local base = _G

module('TreeView')
mtab = { __index = _M }

local print			= base.print
local require		= base.require
local ipairs		= base.ipairs
local error			= base.error
local table			= base.table
local string		= base.string

local Factory		= require('Factory')
local Widget		= require('Widget')
local CheckListBox	= require('CheckListBox')
local TreeViewItem	= require('TreeViewItem')
local Skin			= require('Skin')
local gui			= require('dxgui')

Factory.setBaseClass(_M, Widget)

function new()
	return Factory.create(_M)
end
	
function construct(self)
	Widget.construct(self)
	
	self:setSkin(Skin.treeViewSkin())
	
	self:addItemMouseDownCallback(function(self)
		local item = CheckListBox.getSelectedItem(self)
		
		if item then
			self:onNodeMouseDown(item.node)
		end	
	end)
	
	self:addItemMouseUpCallback(function(self)
		local item = CheckListBox.getSelectedItem(self)
		
		if item then
			self:onNodeMouseUp(item.node)
		end	
	end)
	
	self:addItemMouseDoubleDownCallback(function(self)
		local item = CheckListBox.getSelectedItem(self)
		
		if item then
			self:onNodeMouseDoubleClick(item.node)
		end	
	end)
	
	self:addItemChangeCallback(function(self)
		local item = CheckListBox.getSelectedItem(self)
		local node = item.node
		
		if item:getChecked() then
			expandNode(node)
		else
			collapseNode(node)
		end	

		self:onNodeChange(node)
	end)
	
	self:addSelectionChangeCallback(function()
		local item = CheckListBox.getSelectedItem(self)
		local node = item.node
		
		self:onSelectedNodeChange(node)
	end)	
	
	self.nodes = {}
end

function newWidget(self)
	return gui.NewCheckListBox()
end

function getScrollPosition(self)
	return gui.CheckListBoxGetScrollPosition(self.widget)
end

function setScrollPosition(self, value)
	gui.CheckListBoxSetScrollPosition(self.widget, value)
end

local function setOffsets(self, itemSkin, level)
	local skinParams	= itemSkin.skinData.params
	local markerSize	= skinParams.checkSize
	local markerGap		= skinParams.checkGap
	local pictureSize	= skinParams.pictureSize
	local pictureGap	= skinParams.pictureGap
	local markerOffset	= level * (markerSize + markerGap)
	local textOffset	= markerOffset + markerSize + markerGap + pictureSize + pictureGap
	
	local apply = function(interactiveState)
		for innerState = 1, 4 do
			interactiveState[innerState].check.horzAlign.offset = markerOffset
			interactiveState[innerState].text.horzAlign.offset = textOffset	
		end
	end
	
	apply(itemSkin.skinData.states.released)
	apply(itemSkin.skinData.states.hover)
end

local function findNodeIndex(nodes, node, result)	
	for i, n in ipairs(nodes) do		
		if node == n then
			return true
		end
		
		result.value = result.value + 1
		
		if findNodeIndex(n.children, node, result) then
			return true
		end
	end

	return false	
end

local function findNodeLinearIndex(self, node)
	local result = {
		value = 0
	}
	
	if findNodeIndex(self.nodes, node, result) then
		return result.value
	end
end

local function getNodeLevel(node)
	local level	= 0
	local parentNode = node.parentNode
	
	while parentNode do
		level = level + 1
		parentNode = parentNode.parentNode
	end
	
	return level
end

local function printChildren(children, level)
	local prefix = string.rep('\t', level)
	
	for i, child in ipairs(children) do
		print(prefix, child.text)
		
		printChildren(child.children, level + 1)
	end
end

function dump(self)
	printChildren(self.nodes, 0)
end

function addNode(self, text, parentNode, index)
	local parentText
	
	if parentNode then
		parentText = parentNode.text
	end

	local node = {
		text		= text,
		parentNode	= parentNode,
		children	= {},
		expanded	= false,
	}
	
	local children
	
	if parentNode then
		children = parentNode.children
		parentNode.item:setCheckVisible(true)
	else
		children = self.nodes
	end
	
	if index then
		if index < 1 or index > #children + 1 then
			error('Invalid node index!')
		end
		
		table.insert(children, index, node)
	else
		table.insert(children, node)
	end
	
	local linearIndex	= findNodeLinearIndex(self, node)
	local item			= TreeViewItem.new(node.text)
	local itemSkin		= self:getSkin().skinData.skins.item
	local level			= getNodeLevel(node)
	
	setOffsets(self, itemSkin, level)
	
	item:setSkin(itemSkin)
	item.node = node
	node.item = item
	
	CheckListBox.insertItem(self, item, linearIndex)
	
	item:setCheckVisible(false)
	
	return node
end

local function getChildNodeCount(node)
	local count = #node.children
	
	for i, child in ipairs(node.children) do
		count = count + getChildNodeCount(child)
	end
	
	return count
end

function removeNode(self, node)
	local parentNode = node.parentNode
	local children
	
	if parentNode then
		children = parentNode.children
	else
		children = self.nodes
	end
	
	for i, child in ipairs(children) do
		if child == node then
			local childCount	= getChildNodeCount(node)
			local linearIndex	= findNodeLinearIndex(self, node)

			CheckListBox.removeItem(self, CheckListBox.getItem(self, linearIndex))
			
			for i = 1, childCount do
				CheckListBox.removeItem(self, CheckListBox.getItem(self, linearIndex))	
			end
			
			table.remove(children, i)
			
			break
		end
	end
	
	if parentNode then
		parentNode.item:setCheckVisible(#parentNode.children > 0)
	end
end

function clear(self)
	self.nodes = {}
	CheckListBox.removeAllItems(self)
end

function selectNode(self, node)
	if node then
		CheckListBox.selectItem(self, node.item)
	else
		CheckListBox.selectItem(self, nil)
	end
end

function getSelectedNode(self)
	local item = CheckListBox.getSelectedItem(self)
	local node
	
	if item then
		node = item.node
	end
	
	return node
end

function getItemNode(self, index)
	local item = CheckListBox.getItem(self, index)
	local node
	
	if item then
		node =	item.node
	end
	
	return node
end

function getItemCount(self)
	return CheckListBox.getItemCount(self)
end

function findNode(self, nodesTextList)
	local result
	local nodes = self.nodes
	
	for i, nodeText in ipairs(nodesTextList) do
		local found = false
		
		for j, node in ipairs(nodes) do
			if node.text == nodeText then
				result	= node
				found	= true
				nodes	= node.children
				
				break
			end
		end
		
		if not found then
			break
		end
	end
	
	return result
end

local function showNodes(nodes)
	for i, node in ipairs(nodes) do
		node.item:setVisible(true)
		
		if node.expanded then
			showNodes(node.children)
		end
	end
end

function expandNode(node, expandChildren)
	local result = false
	
	node.expanded = true
	node.item:setChecked(true)
	
	for i, child in ipairs(node.children) do
		child.item:setVisible(true)
		
		if child.expanded or expandChildren then
			if expandNode(child, expandChildren) then
				result = true
				
				break
			end
		end
	end
	
	showNodes(node.children)
	
	return result
end

function expand(self)
	for i, node in ipairs(self.nodes) do
		expandNode(node, true)
	end
end

function expandTillNode(self, node)
	local parentNode = node.parentNode
	
	while parentNode do
		expandNode(parentNode, false)
		parentNode = parentNode.parentNode
	end
end

local function hideNodes(nodes)
	for i, node in ipairs(nodes) do
		node.item:setVisible(false)
		
		hideNodes(node.children)
	end
end

function collapseNode(node, collapseChildren)
	node.expanded = false
	node.item:setChecked(false)
	
	if collapseChildren then
		for i, child in ipairs(node.children) do
			collapseNode(child, collapseChildren)
		end		
	end
	
	hideNodes(node.children)
end

function collapse(self)
	for i, node in ipairs(self.nodes) do
		collapseNode(node, true)
	end
end

function setNodeText(self, node, text)
	node.text = text
	node.item:setText(text)
end

function addItemMouseMoveCallback(self, callback)
	self:addCallback('list box item mouse move', callback)
end

function addItemMouseDownCallback(self, callback)
	self:addCallback('list box item mouse down', callback)
end

function addItemMouseDoubleDownCallback(self, callback)
	self:addCallback('list box item mouse double down', callback)
end

function addItemMouseUpCallback(self, callback)
	self:addCallback('list box item mouse up', callback)
end

-- у элемента списка изменилось состояние (checked/unchecked)
function addItemChangeCallback(self, callback)
	self:addCallback('list box item change', callback)
end

function addSelectionChangeCallback(self, callback)
	self:addCallback('list box selection change', callback)
end

function onNodeMouseDown(self, node)
	-- print('onNodeMouseDown', node.text)
end

function onNodeMouseUp(self, node)
	-- print('onNodeMouseUp', node.text)
end

function onNodeMouseDoubleClick(self, node)
	-- print('onNodeMouseDoubleClick', node.text)
end

function onNodeChange(self, node)
	-- print('onNodeChange', node.text)
end

function onSelectedNodeChange(self, node)
	-- print('onSelectedNodeChange', node.text)
end