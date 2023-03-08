local base = _G

module('CheckListTreeMulty')
mtab = { __index = _M }

local print = base.print
local require = base.require
local ipairs = base.ipairs
local pairs = base.pairs
local error = base.error
local table = base.table
local assert = base.assert

local Factory = require('Factory')
local Widget = require('Widget')
local CheckListBox = require('CheckListBox')
local CheckListBoxItem = require('CheckListBoxItem')
local Skin = require('Skin')
local gui = require('dxgui')

Factory.setBaseClass(_M, CheckListBox)

function new(shift, tree, nameToCaptionMap)
  return Factory.create(_M, shift, tree, nameToCaptionMap)
end

local function setChecklistTreeItemSkinOffset(interactiveState, offset)
	local checkBoxWidth = 16
	local innerStateCount = 4
	local gap = 8
	
	for innerState = 1, innerStateCount do
		local state = interactiveState[innerState]
		local checkHorzAlign = state.check.horzAlign
		local textHorzAlign = state.text.horzAlign
		
		checkHorzAlign.offset = offset
		textHorzAlign.offset = offset + checkBoxWidth + gap
	end
end

local checkListTreeItemSkin = Skin.checkListBoxItemSkin()

local function makeCheckListTreeSkin(offset)
	local states = checkListTreeItemSkin.skinData.states
	  
	setChecklistTreeItemSkinOffset(states.released, offset)
	setChecklistTreeItemSkinOffset(states.hover, offset)
	setChecklistTreeItemSkinOffset(states.disabled, offset)	
	
	return checkListTreeItemSkin
end

function construct(self, shift, tree, nameToCaptionMap)
	CheckListBox.construct(self)
	
	self.shift = 0
	self:setShift(shift)

	if tree and nameToCaptionMap then
		self:setCheckBoxTree(tree, nameToCaptionMap)
	end	
end  

function newWidget(self)
  return gui.NewCheckListBox()
end

function setSkin(self, skin)
	CheckListBox.setSkin(self, skin)
	
	skin = self:getSkin()
	checkListTreeItemSkin = skin.skinData.skins.item
end

function reset(self)
	local itemCounter = self:getItemCount() - 1
	
	for i = 0, itemCounter do
		self:getItem(i):setChecked(false)
	end
end

function setShift(self, shift)
	if shift then
		self.shift = shift
	end	
end

function insertCheckBox(self, name, parentCheckBox, nameToCaptionMap, level)
	local caption = nameToCaptionMap[name]
	local item = CheckListBoxItem.new(caption)
	
	item.name = name
	item.parentCheckBox = parentCheckBox
	item.childCheckBoxes = {}
	
	local offset = level * self.shift
	
	item:setSkin(makeCheckListTreeSkin(offset))
	self:insertItem(item)
	
	if parentCheckBox then
		table.insert(parentCheckBox.childCheckBoxes, item)
	end
	
	return item
end

function setCheckBoxTree(self, treeHead, nameToCaptionMap)
	self:clear()
	
	if treeHead then
		self.parentCheckBox = {}
		if treeHead[1] then 
			for k,treeHeadCur in base.ipairs(treeHead) do
				index = #self.parentCheckBox+1	
				self.parentCheckBox[index] = self:insertCheckBox(treeHeadCur.name, nil, nameToCaptionMap, 1)							
				if treeHeadCur.childs then
					self:insertCheckBoxTree(treeHeadCur.childs, self.parentCheckBox[index], nameToCaptionMap, 2)										
				end
			end
		else
			index = #self.parentCheckBox+1	
			self.parentCheckBox[index] = self:insertCheckBox(treeHead.name, nil, nameToCaptionMap, 1)							
			if treeHead.childs then
				self:insertCheckBoxTree(treeHead.childs, self.parentCheckBox[index], nameToCaptionMap, 2)										
			end
		end
	else
		self.parentCheckBox = nil		
	end
end

function insertCheckBoxTree(self, tree, parentCheckBox, nameToCaptionMap, level)
	if tree then
		for subNodeNum, subNode in pairs(tree) do			
			if subNode.name then
				local checkBox = self:insertCheckBox(subNode.name,	parentCheckBox, nameToCaptionMap, level)
				self:insertCheckBoxTree(subNode.childs, checkBox, nameToCaptionMap, level + 1)
			else
				self:insertCheckBox(subNode, parentCheckBox, nameToCaptionMap, level)
			end
		end
	end
end

function getHead(self)
	return self.parentCheckBox
end

function onChange(self, item)
	self:updateChilds_(item)
	
	if item.parentCheckBox then
		self:onChildChange_(item.parentCheckBox)
	end
end

function onItemChange(self)
	CheckListBox.onItemChange(self)
	self:onChange(self:getSelectedItem())
end
	
function getFlags(self)		
	if self.parentCheckBox then
		local flags = {}
		
		for k,parentCheckBox in base.ipairs(self.parentCheckBox) do
			self:getCheckBoxFlags_(parentCheckBox, flags)
		end	

		return  flags 
	else
		return nil
	end
end
	
function getCheckBoxFlags_(self, checkBox, result)	
	if checkBox:getChecked() then
		result[#result + 1] = checkBox.name
	else
		for subCheckBoxNum, subCheckBox in pairs(checkBox.childCheckBoxes) do
			self:getCheckBoxFlags_(subCheckBox, result)
		end		
	end

	return result
end

function getNoFlags(self)		
	if self.parentCheckBox then
		local flags = {}
		
		for k,parentCheckBox in base.ipairs(self.parentCheckBox) do
			self:getCheckBoxNoFlags_(parentCheckBox, flags)
		end	

		return  flags 
	else
		return nil
	end
end
	
function getCheckBoxNoFlags_(self, checkBox, result)	
	if not (checkBox:getChecked()) and #checkBox.childCheckBoxes == 0 then
		result[#result + 1] = checkBox.name
	else
		for subCheckBoxNum, subCheckBox in pairs(checkBox.childCheckBoxes) do
			self:getCheckBoxNoFlags_(subCheckBox, result)
		end		
	end

	return result
end

function updateChilds_(self, item)
	for i, v in pairs(item.childCheckBoxes) do
		v:setChecked(item:getChecked())
		self:updateChilds_(v)
	end
end

function onChildChange_(self, item)
	local allChecked = false
	assert(item.childCheckBoxes ~= nil)
	for i, v in pairs(item.childCheckBoxes) do
		if v:getChecked() then
			allChecked = true
		else
			allChecked = false
			break
		end
	end
	item:setChecked(allChecked)
	if item.parentCheckBox then
		self:onChildChange_(item.parentCheckBox)
	end
end
