local base = _G

module('me_AirAdjustments')

local require = base.require

-- Модули LuaGUI
local DialogLoader 		= require('DialogLoader')
local DB 				= require('me_db_api')
local U 				= require('me_utilities')	-- Утилиты создания типовых виджетов
local panel_aircraft 	= require('me_aircraft')
local Static 			= require('Static')
local CheckBox 			= require('CheckBox')
local ComboList 		= require('ComboList')
local Slider 			= require('HorzSlider')
local SpinBox 			= require('SpinBox')
local EditBox 			= require('EditBox')
local ListBoxItem 		= require('ListBoxItem')
local crutches 			= require('me_crutches')  
local panel_loadout		= require('me_loadout')
local Gui               = require('dxgui')
local lfs 				= require('lfs')
local Tools  			= require('tools')
local TableUtils 		= require('TableUtils')
local TabGroupItem		= require('TabGroupItem')
local i18n 				= require('i18n')
local log      			= require('log')

i18n.setup(_M)

cdata = 
{
   Option 				= _("Option"),
   Value 				= _("Value"),
   AircraftSettings 	= _("Aircraft Settings"),
   CANCEL				= _("CANCEL"),
   OK					= _("OK"),
}

local typeLA = nil
local modulId = nil
local OptionsTblDef = nil
local OptionsTblCur = nil
local dirName = lfs.writedir().."AircraftSettings/"
local btnTabs ={}

function create()
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_AirAdjustments.dlg', cdata)

	pBox 		= window.pBox
	pCenter		= pBox.pCenter
	pNoVisible	= window.pNoVisible
	bCancel 	= pCenter.bCancel
	bOk 		= pCenter.bOk
	treeView	= pCenter.treeView
	gridOptions = pCenter.grid0
	bClose		= pBox.bClose
	header		= pBox.header
	
	nameSkin 			= pNoVisible.static:getSkin()
	comboListSkin 		= pNoVisible.comboList:getSkin()
	checkBoxSkin 		= pNoVisible.checkBox:getSkin()
	listBoxItemSkin 	= pNoVisible.listBoxItem:getSkin()
	spinBoxSkin			= pNoVisible.spinBox:getSkin()
	tabGroupItemSkin	= pNoVisible.tabGroupItem:getSkin()
	
	local w, h = Gui.GetWindowSize()
	window:setBounds(0, 0, w, h)
	local boxW,boxH = pBox:getSize()
	pBox:setPosition((w-boxW)/2, (h-boxH)/2)
	
	bCancel.onChange = onChange_bCancel
	bClose.onChange = onChange_bCancel
	bOk.onChange = onChange_bOk
	
	function treeView:onNodeMouseDown(node)
		fillOptions(node)
	end
end	

function getUserOptions()
	local staticTemplate
	local AircraftSettings = {}
	local modulName = base.string.gsub(modulId, '/', '_');
	local fullFileName = dirName..modulName..'.lua'
    
    if fullFileName then
       local tbl = Tools.safeDoFile(fullFileName, false)
		if (tbl and tbl.AircraftSettings) then
			return true, tbl.AircraftSettings
		else
			return false, nil
		end 
    end
	return false, nil
end

function saveUserOptions()
	if OptionsTblCur then		
		local a = lfs.attributes(dirName,'mode')
		if not a then
			lfs.mkdir(dirName)
		end
	
		local modulName = base.string.gsub(modulId, '/', '_');
		local fullFileName = lfs.writedir() .. 'AircraftSettings/'..modulName..'.lua'

		U.saveInFile(OptionsTblCur, 'AircraftSettings', fullFileName)
	end
end

local function addTbl(a_Tbl, a_parent)
	a_parent[a_Tbl.id] = {}
	if a_Tbl.childs then
		for k,v in base.pairs(a_Tbl.childs) do
			if v.type == 'section' or v.type == 'tab'  then
				addTbl(v, a_parent[a_Tbl.id])
			else
				a_parent[a_Tbl.id][v.id] = v.defValue
			end
		end
	end
end

function createOptionsTblDef(a_AircraftSettings)
	if OptionsTblDef == nil then
		OptionsTblDef  = {}		
		for k,v in base.pairs(a_AircraftSettings) do
			addTbl(v, OptionsTblDef)
		end	
	end
	
	local res, userOptions = getUserOptions()
	if res == true then
		local options = {}
		TableUtils.copyTable(options, OptionsTblDef)
		options = TableUtils.mergeTablesOptions(options, userOptions)
		OptionsTblCur = options
	else
		OptionsTblCur = {}
		TableUtils.copyTable(OptionsTblCur, OptionsTblDef)
	end
	
	
end

-- Открытие/закрытие панели
function show(b, a_type, a_pluginInfo) 
	if window == nil then
		create()
	end	
	
	typeLA 	= a_type
	modulId = a_pluginInfo.id
	
    if b then		
        update(a_pluginInfo)
    end
    
    window:setVisible(b)
end

function onChange_bCancel()
	typeLA = nil
	modulId = nil
	OptionsTblDef = nil
	OptionsTblCur = nil
	window:setVisible(false)
end

function onChange_bOk()
	if typeLA and modulId then
		saveUserOptions()
	end
	typeLA = nil
	modulId = nil
	OptionsTblDef = nil
	OptionsTblCur = nil
	window:setVisible(false)
end

function safeDoFileWithLocalization(filename, a_showError)  
    local f,err = base.loadfile(filename)
    if not f then
        if (a_showError ~= false) then  
            base.print("ERROR: safeDoFile() file not found!", err)
        end
        return { }
    end
    local env = {_ = i18n.ptranslate} 
    base.setfenv(f, env)
	local ok, res = base.pcall(f)
	if not ok then
		log.error('ERROR: AirAdjustments failed to pcall "'..filename..'": '..res)
		return { }
	end
    return env
end

function getDataOptions(a_pluginInfo)
	local staticTemplate
	local modulName = base.string.gsub(modulId, '/', '_');
	local fullFileName = a_pluginInfo.optionsFolder..'/'..a_pluginInfo.AircraftSettingsFile
    if fullFileName then
       local tbl = safeDoFileWithLocalization(fullFileName)
		if (tbl and tbl.AircraftSettings) then
			return tbl.AircraftSettings
		else
			return nil
		end 
    end
	return nil
end

function update(a_pluginInfo)
	if typeLA == nil then
		return
	end
	
	local AircraftSettings = getDataOptions(a_pluginInfo)
	
	if AircraftSettings then
		createOptionsTblDef(AircraftSettings)
		
		fillPanel(AircraftSettings)
	end
end

local function addNode(a_node, a_parent, a_optionTbl)
	
	if a_node.type == 'tab' then
		
	else 
		local node = treeView:addNode(a_node.name, a_parent)
		node.id = a_node.id
		a_node.type = a_node.type
		node.parents = ((a_parent and a_parent.parents) or "") .. a_node.id
		node.childs = a_node.childs
		node.refOption = a_optionTbl -- ссылка на таблицу опций
		if a_node.childs then
			for k,v in base.pairs(a_node.childs) do
				if v.type == 'section' or v.type == 'tab' then
					addNode(v, node, a_optionTbl[v.id])
				end
			end
		end
		return node
	end
end

function addTab(a_data)
	local btnTab = TabGroupItem.new()
		
	btnTab:setSkin(tabGroupItemSkin)
	btnTab:setBounds(200*#btnTabs,50,200,30)
	btnTab:setText(a_data.name)
	btnTab.id = a_data.id
	btnTab.childs = a_data.childs
	pCenter:insertWidget(btnTab)
	base.table.insert(btnTabs, btnTab)
	btnTab.onShow = function(self)
		fillTree(self.childs, OptionsTblCur[self.id])
		fillOptions(nil)-- очищаем
	end
end

function fillPanel(a_AircraftSettings)
	if #btnTabs > 0 then
		for i=#btnTabs, 1 do
			pCenter:removeWidget(btnTabs[i])
			btnTabs[i]:destroy()
		end
	end
	btnTabs = {}
	
	for k,v in base.ipairs(a_AircraftSettings) do
		if v.type == 'tab' then
			addTab(v)
		end
	end
	
	if #btnTabs > 0 then
		btnTabs[1]:setState(true)
		fillTree(btnTabs[1].childs, OptionsTblCur[btnTabs[1].id])
	else
		fillTree(a_AircraftSettings, nil)
	end	
end

function fillTree(a_AircraftSettings, a_OptionsTbl)
	local parent = nil
	treeView:clear()
	for k,v in base.pairs(a_AircraftSettings) do
		addNode(v, parent, (a_OptionsTbl and a_OptionsTbl[v.id]) or OptionsTblCur[v.id])
	end	
end

local function addOption(a_option, a_parent)
	local rowIndex = gridOptions:getRowCount()
    local rowHeight = 20    
    
    gridOptions:insertRow(rowHeight)

	local nameCell = Static.new(a_option.name)
    nameCell:setSkin(nameSkin)
	nameCell:setBounds(0 , 0, 100, rowHeight) 
    gridOptions:setCell(0, rowIndex, nameCell)
	
	local ctrl
	if a_option.control == 'comboList' then
		ctrl = ComboList.new()
		ctrl:setSkin(comboListSkin)
        ctrl:setBounds(0 , 0, 100, rowHeight) 
            
		for i, value in base.ipairs(a_option.values) do
			local item = ListBoxItem.new(value.dispName)
			item:setSkin(listBoxItemSkin)
			item.id = value.id
			ctrl:insertItem(item)
		end	
		setValueComboList(ctrl, a_parent[a_option.id] )
		
		ctrl.onChange = function(self, item)
                a_parent[a_option.id] = item.id
				
		end		
	elseif a_option.control == 'checkbox' then	
		ctrl = CheckBox.new()
		ctrl:setSkin(checkBoxSkin)
		ctrl:setBounds(0 , 0, 100, rowHeight)
		ctrl:setState(a_parent[a_option.id])
		ctrl.onChange = function(self)
			a_parent[a_option.id] = ctrl:getState()
		end
	elseif a_option.control == 'spinbox' then
		ctrl = SpinBox.new()
		ctrl:setSkin(spinBoxSkin)
		ctrl:setRange(a_option.min or 0, a_option.max or 100)
		ctrl:setStep(a_option.step or 1)
		ctrl:setValue(a_parent[a_option.id]) 
		ctrl.onChange = function(self)
			a_parent[a_option.id] = ctrl:getValue()
		end 	
		
	end
	
	gridOptions:setCell(1, rowIndex, ctrl)
	 
	 
end

function fillOptions(a_node)
	gridOptions:clearRows()
	if a_node and a_node.childs then
		for k,v in base.pairs(a_node.childs) do
			if v.type ~= 'section' then
				addOption(v, a_node.refOption)
			end
		end
	end
end	

function setValueComboList(a_comboList, a_valueId) 
	local count = a_comboList:getItemCount()
				
	for i = 0, count-1 do
		local item = a_comboList:getItem(i)

		if item.id == a_valueId then
			a_comboList:selectItem(item)
			return
		end
	end	
end



