local base = _G

module('me_requiredUnits')

local require   = base.require
local ipairs    = base.ipairs
local next      = base.next


local DialogLoader	 	= require('DialogLoader')
local module_mission 	= require('me_mission')
local DB 				= require('me_db_api')
local ListBoxItem		= require('ListBoxItem')
local Static            = require('Static')
local Button			= require('Button')
local UpdateManager		= require('UpdateManager')
local Skin				= require('Skin')

require('i18n').setup(_M)

local vdata = {}

local cdata = 
{
	No 				= _("No"),
	RequiredUnits	= _("Required units"),
	Sources 		= _("Sources"),
	Consumers 		= _("Consumers"),
	add 			= _("add"),
	Name 			= _("Name"),
	UnitId 			= _("UnitId"),
	MaxRange 		= _("MaxRange"),
	curRange 		= _("curRange"),
	Remove 			= _("Remove"),
	Range			= _("Range"),
}

local style
local SourceTbl = {}
local linksSourcesTbl = {}

function create()
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_requiredUnits.dlg', cdata)

	pConsumer 		= window.pConsumer
	pSource 		= window.pSource
	clSources 		= pConsumer.clSources
	btnAdd 			= pConsumer.btnAdd
	gridSources 	= pConsumer.gridSources
	gridConsumers	= pSource.gridConsumers
	
	staticSkinGridItem = window.pNoVisible.sGridItem:getSkin()
	
	btnAdd.onChange = onChange_btnAdd
end


function show(b, a_style, a_unit)
	if window == nil then
		create()
	end
	
	vdata.unit = a_unit
	style = a_style

	updateStyle()
	
	window:setVisible(b)
end

function updateStyle()
	base.print("--updateStyle--",style)
	if style == 'Consumer' then
		pConsumer:setVisible(true)
		pSource:setVisible(false)
		pConsumer:setPosition(0, 0)
		window:setBounds(base.right_panel_x-600, base.right_panel_y, 600, 250)
		updateConsumer()
	elseif style == 'Source' then
		pConsumer:setVisible(false)
		pSource:setVisible(true)
		pSource:setPosition(0, 0)
		window:setBounds(base.right_panel_x-600, base.right_panel_y, 600, 250)
		updateSource()
	else
		pConsumer:setVisible(false)
		pSource:setVisible(false)
	end
end

function updateConsumer()
	local unitDef = DB.unit_by_type[vdata.unit.type]
	SourceTbl 			= {}
	linksSourcesTbl 	= {}

	-- определяем подходит ли тип юнита для связывания
	function isSource(a_unitDef, a_type)
	--	local unitDefSource = DB.unit_by_type[a_type]
		
		local result = false
		if a_unitDef.WS and a_unitDef.WS.requiredUnits then
			for k,v in base.pairs(a_unitDef.WS.requiredUnits) do
				result = result or (v[1] == a_type)
			end
		end
		
		return result
	end
	
	if vdata.unit and vdata.unit.linksSources then
		for k,v in base.pairs(vdata.unit.linksSources) do
			linksSourcesTbl[v] = v
		end
	end	
		
	if unitDef.WS.requiredUnits then
		for k, v in base.pairs(module_mission.unit_by_id) do
			if isSource(unitDef, v.type) == true then
				SourceTbl[v.unitId] = v.name
			end
		end
	end	
	
	clSources:clear()
	
	local item = ListBoxItem.new(cdata.No)
	item.sourceId = nil
	clSources:insertItem(item)
	clSources:selectItem(clSources:getItem(0))
		
	for sourceId, sourceName in base.pairs(SourceTbl) do
		if linksSourcesTbl[sourceId] == nil then
			local item = ListBoxItem.new(sourceName)
			item.sourceId = sourceId
			clSources:insertItem(item)	
		end
	end

	updateGridSources()
end

function updateSource()
	local unitDef = DB.unit_by_type[vdata.unit.type]
	SourceTbl 			= {}
	linksSourcesTbl 	= {}

	updateGridConsumers()
end

function getRequiredData(a_requiredUnits, a_type)
	for k,v in base.pairs(a_requiredUnits) do
		if v[1] == a_type then
			return v
		end
	end
end

function onChange_btnAdd()
	local item = clSources:getSelectedItem()
	
	if item.sourceId ~= nil then
		module_mission.linkRequiredUnits(vdata.unit, module_mission.unit_by_id[item.sourceId])
		updateConsumer()
	end
end

function updateGridSources()
	gridSources:clearRows()
	if vdata.unit.linksSources then
		for k,v in base.pairs(vdata.unit.linksSources) do
			insertRowSources(v)
		end
	end
end

function updateGridConsumers()
	gridConsumers:clearRows()
	if vdata.unit.linksConsumers then
		for k,v in base.pairs(vdata.unit.linksConsumers) do
			insertRowConsumers(v)
		end
	end
end

function onChange_btnRemoveSources(self)
	UpdateManager.add(function()
		module_mission.unlinkRequiredUnits(vdata.unit, module_mission.unit_by_id[self.unitId])
		updateConsumer()
		
		-- удаляем себя из UpdateManager
		return true
	end)
end

function onChange_btnRemoveConsumers(self)
	UpdateManager.add(function()
		module_mission.unlinkRequiredUnits(module_mission.unit_by_id[self.unitId], vdata.unit)
		updateSource()
		
		-- удаляем себя из UpdateManager
		return true
	end)
end

function insertRowSources(a_sourceId)
	local rowIndex = gridSources:getRowCount()
    gridSources:insertRow(20,rowIndex)
	local cell
	local unitS = module_mission.unit_by_id[a_sourceId]
	local unitDef = DB.unit_by_type[vdata.unit.type]
	local dataR = getRequiredData(unitDef.WS.requiredUnits, unitS.type)
	local curRange = base.math.floor(DB.getDist(vdata.unit.x, vdata.unit.y, unitS.x, unitS.y))
	
    ------1
    cell = Static.new()
	cell:setSkin(staticSkinGridItem)  
	cell:setText(rowIndex)	
    gridSources:setCell(0, rowIndex, cell)
	
	------2
    cell = Static.new()
	cell:setSkin(staticSkinGridItem)  
	cell:setText(unitS.name)	
    gridSources:setCell(1, rowIndex, cell)

	------3
    cell = Static.new()
	cell:setSkin(staticSkinGridItem)  
	cell:setText(unitS.unitId)	
    gridSources:setCell(2, rowIndex, cell)

	------4
    cell = Static.new()
	cell:setSkin(staticSkinGridItem)  
	cell:setText(dataR[2])	
    gridSources:setCell(3, rowIndex, cell)
	
	------5 текущее растояние
    cell = Static.new()
	cell:setSkin(staticSkinGridItem)  
	cell:setText(curRange)	
    gridSources:setCell(4, rowIndex, cell)
	
	------6
    cell = Button.new()
	cell:setSkin(Skin.buttonSkin_MENew())   
	cell:setText(_("remove"))	
	cell.unitId = unitS.unitId
	cell.onChange = onChange_btnRemoveSources
    gridSources:setCell(5, rowIndex, cell)
end

function insertRowConsumers(a_consumerId)
	local rowIndex = gridConsumers:getRowCount()
    gridConsumers:insertRow(20,rowIndex)
	local cell
	local unitC = module_mission.unit_by_id[a_consumerId]
	local unitDef = DB.unit_by_type[vdata.unit.type]
	local curRange = base.math.floor(DB.getDist(vdata.unit.x, vdata.unit.y, unitC.x, unitC.y))
	
    ------1
    cell = Static.new()
	cell:setSkin(staticSkinGridItem)  
	cell:setText(rowIndex)	
    gridConsumers:setCell(0, rowIndex, cell)
	
	------2
    cell = Static.new()
	cell:setSkin(staticSkinGridItem)  
	cell:setText(unitC.name)	
    gridConsumers:setCell(1, rowIndex, cell)

	------3
    cell = Static.new()
	cell:setSkin(staticSkinGridItem)  
	cell:setText(unitC.unitId)	
    gridConsumers:setCell(2, rowIndex, cell)
	
	------4 текущее растояние
    cell = Static.new()
	cell:setSkin(staticSkinGridItem)  
	cell:setText(curRange)	
    gridConsumers:setCell(3, rowIndex, cell)
	
	------5
    cell = Button.new()
	cell:setSkin(Skin.buttonSkin_MENew())   
	cell:setText(_("remove"))	
	cell.unitId = unitC.unitId
	cell.onChange = onChange_btnRemoveConsumers
    gridConsumers:setCell(4, rowIndex, cell)
end