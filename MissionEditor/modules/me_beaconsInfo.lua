local base = _G

module('me_beaconsInfo')

local require       = base.require
local pairs         = base.pairs
local table         = base.table

local i18n 				= require('i18n')
local Window 			= require('Window')
local U                 = require('me_utilities')
local DialogLoader      = require('DialogLoader')
local Static            = require('Static')
local Skin              = require('Skin')
local textutil          = require('textutil')
local lfs 				= require('lfs')
local Tools 			= require('tools')
local Button			= require('Button')
local UpdateManager	    = require('UpdateManager')
local Gui               = require('dxgui')
local SkinUtils		    = require('SkinUtils')
local GridHeaderCell    = require('GridHeaderCell')
local Terrain			= require('terrain')
local MissionModule 	= require('me_mission')
local MapWindow 		= require('me_map_window')

i18n.setup(_M)

cdata = 
{
	Beacons 					= _("Beacons"),
	name 						= _("Name"),
	ident 						= _("Ident"),
	SelectDeselect 				= _("Select/Deselect All"),
	GoToBeacon					= _("Go to beacon"),
	VOR							= "VOR",
	DME 						= "DME",
	VOR_DME 					= "VOR DME",
	TACAN 						= "TACAN",
	VORTAC 						= "VORTAC",
	RSBN 						= "RSBN",
	BROADCAST_STATION 			= "BROADCAST STATION",
	HOMER 						= "BEACON",
	AIRPORT_HOMER 				= "AIRPORT BEACON",
	AIRPORT_HOMER_WITH_MARKER 	= "AIRPORT BEACON WITH MARKER",
	ILS_FAR_HOMER 				= "ILS FAR BEACON",
	ILS_NEAR_HOMER 				= "ILS NEAR BEACON",
	ILS_LOCALIZER				= "ILS LOCALIZER",
	ILS_GLIDESLOPE 				= "ILS GLIDESLOPE",
	PRMG_LOCALIZER 				= "PRMG LOCALIZER",
	PRMG_GLIDESLOPE 			= "PRMG GLIDESLOPE",
	ICLS_LOCALIZER 				= "ICLS LOCALIZER",
	ICLS_GLIDESLOPE 			= "ICLS GLIDESLOPE",
	NAUTICAL_HOMER 				= "NAUTICAL BEACON",
}

local BeaconTypes = {}
local IndexColumsByType = {}
local TypeByIndexColums = {}
local curKeySort = "display_name"
local sortReverse = false
local selectAll = true


function create()
	window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_beaconsInfo.dlg", cdata)
	grid 		= window.grid
	pNoVisible 	= window.pNoVisible
	btnClose	= window.btnClose
	pSett		= window.pSett
	bGoToBeacon = pSett.bGoToBeacon
	
	cbTbl = {}
	cbTbl.cbVOR	 						= pSett.cbVOR
	cbTbl.cbDME							= pSett.cbDME
	cbTbl.cbVOR_DME						= pSett.cbVOR_DME
	cbTbl.cbTACAN						= pSett.cbTACAN
	cbTbl.cbVORTAC						= pSett.cbVORTAC
	cbTbl.cbRSBN						= pSett.cbRSBN
	cbTbl.cbBROADCAST_STATION 			= pSett.cbBROADCAST_STATION
	cbTbl.cbHOMER						= pSett.cbHOMER
    cbTbl.cbAIRPORT_HOMER				= pSett.cbAIRPORT_HOMER
	cbTbl.cbAIRPORT_HOMER_WITH_MARKER	= pSett.cbAIRPORT_HOMER_WITH_MARKER  	
	cbTbl.cbILS_FAR_HOMER				= pSett.cbILS_FAR_HOMER
	cbTbl.cbILS_NEAR_HOMER				= pSett.cbILS_NEAR_HOMER
	cbTbl.cbILS_LOCALIZER				= pSett.cbILS_LOCALIZER
	cbTbl.cbILS_GLIDESLOPE				= pSett.cbILS_GLIDESLOPE
	cbTbl.cbPRMG_LOCALIZER				= pSett.cbPRMG_LOCALIZER
	cbTbl.cbPRMG_GLIDESLOPE				= pSett.cbPRMG_GLIDESLOPE
	cbTbl.cbICLS_LOCALIZER				= pSett.cbICLS_LOCALIZER
	cbTbl.cbICLS_GLIDESLOPE				= pSett.cbICLS_GLIDESLOPE
	cbTbl.cbNAUTICAL_HOMER				= pSett.cbNAUTICAL_HOMER
	
	bSelectDeselect						= pSett.bSelectDeselect
		
	SkinsHeaders = 
    {
		skinSortUp      = pNoVisible.gridHeaderCellSortUp:getSkin(),
		skinSortDown    = pNoVisible.gridHeaderCellSortDown:getSkin(),
		skinNoSort      = pNoVisible.gridHeaderCellNoSort:getSkin(),     
    }	
	
	BeaconTypesDef = Tools.safeDoFileWithDofile("Scripts/World/Radio/BeaconTypes.lua") 
	BeaconTypes = {
		[1] = {type = BeaconTypesDef.BEACON_TYPE_VOR, name = "VOR", enable = true}, 
		[2] = {type = BeaconTypesDef.BEACON_TYPE_DME, name = "DME", enable = true}, 
		[3] = {type = BeaconTypesDef.BEACON_TYPE_VOR_DME, name = "VOR DME", enable = true},
		[4] = {type = BeaconTypesDef.BEACON_TYPE_TACAN, name = "TACAN", enable = true},
		[5] = {type = BeaconTypesDef.BEACON_TYPE_VORTAC, name = "VORTAC", enable = true},
		[6] = {type = BeaconTypesDef.BEACON_TYPE_RSBN, name = "RSBN", enable = false},
		[7] = {type = BeaconTypesDef.BEACON_TYPE_BROADCAST_STATION, name = "BROADCAST STATION", enable = false},
		[8] = {type = BeaconTypesDef.BEACON_TYPE_HOMER, name = "BEACON", enable = false},
		[9] = {type = BeaconTypesDef.BEACON_TYPE_AIRPORT_HOMER, name = "AIRPORT BEACON", enable = false},
		[10] = {type = BeaconTypesDef.BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER, name = "AIRPORT BEACON WITH MARKER", enable = false},
		[11] = {type = BeaconTypesDef.BEACON_TYPE_ILS_FAR_HOMER, name = "ILS FAR BEACON", enable = false},
		[12] = {type = BeaconTypesDef.BEACON_TYPE_ILS_NEAR_HOMER, name = "ILS NEAR BEACON", enable = false},
		[13] = {type = BeaconTypesDef.BEACON_TYPE_ILS_LOCALIZER, name = "ILS LOCALIZER", enable = false},
		[14] = {type = BeaconTypesDef.BEACON_TYPE_ILS_GLIDESLOPE, name = "ILS GLIDESLOPE", enable = false},
		[15] = {type = BeaconTypesDef.BEACON_TYPE_PRMG_LOCALIZER, name = "PRMG LOCALIZER", enable = false},
		[16] = {type = BeaconTypesDef.BEACON_TYPE_PRMG_GLIDESLOPE, name = "PRMG GLIDESLOPE", enable = false},
		[17] = {type = BeaconTypesDef.BEACON_TYPE_ICLS_LOCALIZER, name = "ICLS LOCALIZER", enable = false},
		[18] = {type = BeaconTypesDef.BEACON_TYPE_ICLS_GLIDESLOPE, name = "ICLS GLIDESLOPE", enable = true},
		[19] = {type = BeaconTypesDef.BEACON_TYPE_NAUTICAL_HOMER, name = "NAUTICAL BEACON", enable = false},
	}
	
	SelectedColums = {}
	
	-- дефолт
	cbTbl.cbVOR:setState(true)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_VOR] = true
	cbTbl.cbDME:setState(true)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_DME] = true
	cbTbl.cbVOR_DME:setState(true)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_VOR_DME] = true	
	cbTbl.cbTACAN:setState(true)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_TACAN] = true
	cbTbl.cbVORTAC:setState(true)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_VORTAC] = true
	cbTbl.cbICLS_GLIDESLOPE:setState(true)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_ICLS_GLIDESLOPE] = true
	--------
	
	BeaconByType = {}
	for k,v in base.ipairs(BeaconTypes) do
		BeaconByType[v.type] = v
	end
	
	gridHeaderSkin = pNoVisible.gridHeader:getSkin()
	gridStaticSkin = pNoVisible.gridStatic:getSkin()

	createGrid()

	local width, height = Gui.GetWindowSize()
	window:setBounds( U.left_toolbar_w ,U.top_toolbar_h, width- U.left_toolbar_w, height-U.top_toolbar_h-U.bottom_toolbar_h)
	grid:setSize(width- U.left_toolbar_w-20, height-U.top_toolbar_h-U.bottom_toolbar_h - 250)
	btnClose:setPosition(width- U.left_toolbar_w-32, 10)
	pSett:setPosition(10, height-U.top_toolbar_h-U.bottom_toolbar_h - 200)
	
	
	btnClose.onChange = onChange_btnClose
	
	cbTbl.cbVOR.onChange	 					= onChange_cbVOR
	cbTbl.cbDME.onChange						= onChange_cbDME
	cbTbl.cbVOR_DME.onChange					= onChange_cbVOR_DME
	cbTbl.cbTACAN.onChange						= onChange_cbTACAN
	cbTbl.cbVORTAC.onChange						= onChange_cbVORTAC
	cbTbl.cbRSBN.onChange						= onChange_cbRSBN
	cbTbl.cbBROADCAST_STATION.onChange 			= onChange_cbBROADCAST_STATION
	cbTbl.cbHOMER.onChange						= onChange_cbHOMER
    cbTbl.cbAIRPORT_HOMER.onChange				= onChange_cbAIRPORT_HOMER
	cbTbl.cbAIRPORT_HOMER_WITH_MARKER.onChange	= onChange_cbAIRPORT_HOMER_WITH_MARKER  	
	cbTbl.cbILS_FAR_HOMER.onChange				= onChange_cbILS_FAR_HOMER
	cbTbl.cbILS_NEAR_HOMER.onChange				= onChange_cbILS_NEAR_HOMER
	cbTbl.cbILS_LOCALIZER.onChange				= onChange_cbILS_LOCALIZER
	cbTbl.cbILS_GLIDESLOPE.onChange				= onChange_cbILS_GLIDESLOPE
	cbTbl.cbPRMG_LOCALIZER.onChange				= onChange_cbPRMG_LOCALIZER
	cbTbl.cbPRMG_GLIDESLOPE.onChange			= onChange_cbPRMG_GLIDESLOPE
	cbTbl.cbICLS_LOCALIZER.onChange				= onChange_cbICLS_LOCALIZER
	cbTbl.cbICLS_GLIDESLOPE.onChange			= onChange_cbICLS_GLIDESLOPE
	cbTbl.cbNAUTICAL_HOMER.onChange				= onChange_cbNAUTICAL_HOMER
	
	bSelectDeselect.onChange			= onChange_bSelectDeselect	
	bGoToBeacon.onChange				= onChange_bGoToBeacon	

	grid.onMouseDown = function(self, x, y, button)
        local col, row = self:getMouseCursorColumnRow(x, y)

        if -1 < row then
			self:selectRow(row)  
        end
    end
end

function show(b)
	if window == nil then
		create()
	end
	
	if b then
		update()
	end
	
	window:setVisible(b)
end

function update()
	grid:removeAllRows()
	
	local count = grid:getColumnCount()	
	for index = 2, count - 1 do
		local typeB = TypeByIndexColums[index]
		if SelectedColums[typeB] ~= true then
			grid:setColumnWidth(index, 0)
		else	
			local width = grid:getColumnWidth(index)
			if width == 0 then
				local Header = grid:getColumnHeader(index)
				local nw,nh = Header:calcSize()
				width = nw + 60
			end
			grid:setColumnWidth(index, width)
		end
	end
	
	BeaconsList = {}
	local tblBeacons = Terrain.getBeacons()
	for k,v in base.pairs(tblBeacons) do
		if v.callsign and v.type and (v.frequency
			or ((v.type == BeaconTypesDef.BEACON_TYPE_TACAN 
				or v.type == BeaconTypesDef.BEACON_TYPE_ICLS_GLIDESLOPE) and v.channel))	then			
			base.table.insert(BeaconsList, {callsign = v.callsign, display_name = v.display_name ,
							beaconsTbl = {[v.type] = {frequency = v.frequency, channel = v.channel, modeChannel = "X", position = v.position}}})
		else  
			base.print("--noCallsign_Frequency_Type--", v.display_name, v.type, v.frequency)
		end
	end	
	
	for k, group in base.pairs(MissionModule.group_by_id) do
		if group.route and group.route.points then
			for kk,wpt in base.pairs(group.route.points) do
				if wpt.task and wpt.task.params and wpt.task.params.tasks then
					for kkk, task in base.pairs(wpt.task.params.tasks) do
						if task.params and task.params.action 
							and (task.params.action.id == "ActivateBeacon" or task.params.action.id == "ActivateICLS") then							
							if task.params.action.params.unitId then
								local tmp = task.params.action.params	
								local colorTmp	
								if group.boss.boss.name == 'blue' then
									colorTmp = "0x597FFFFF"
								elseif group.boss.boss.name == 'red' then
									colorTmp = "0xFF4F49FF"
								end	
								base.table.insert(BeaconsList, {callsign = tmp.callsign or tmp.name or "", display_name = MissionModule.unit_by_id[tmp.unitId].name, color = colorTmp,
								           beaconsTbl = {[tmp.type] = {frequency = tmp.frequency, channel = tmp.channel, modeChannel = tmp.modeChannel, position = {wpt.x, 0, wpt.y}}}
										   })
							end
						end
					end
				end
			end
		end
	end
	
	base.table.sort(BeaconsList, compareTbl)
	
	local row = 0
	for k, beacons in base.ipairs(BeaconsList) do
		local beaconsTmp = {}
		local enable = false
		for typeB, v in base.pairs(beacons.beaconsTbl) do			
			if SelectedColums[typeB] == true then			
				beaconsTmp[typeB] = {frequency = v.frequency,  channel = v.channel
									, modeChannel = v.modeChannel}
				enable = true
				if beacons.position == nil and v.position ~= nil then
					beacons.position = v.position
				end
			end
		end		
		
		if enable == true then
			grid:insertRow(20)
			
		------1
			local cell = Static.new()
			cell:setText(beacons.display_name)
			grid:setCell(0, row, cell)
			cell.position = beacons.position
			cell:setSkin(gridStaticSkin)
			if beacons.color then
				cell:setSkin(SkinUtils.setStaticTextColor(beacons.color, cell:getSkin()))
			end
		--	cell:setTooltipText(ххх)

		------2
			cell = Static.new()
			cell:setText(beacons.callsign)
			grid:setCell(1, row, cell)
			cell:setSkin(gridStaticSkin)
			if beacons.color then
				cell:setSkin(SkinUtils.setStaticTextColor(beacons.color, cell:getSkin()))
			end
			
			for typeB, data in base.pairs(beaconsTmp) do
				cell = Static.new()
				local freqTmp, freqStr
				if typeB == BeaconTypesDef.BEACON_TYPE_HOMER
					or typeB == BeaconTypesDef.BEACON_TYPE_AIRPORT_HOMER				
					or typeB == BeaconTypesDef.BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER
					or typeB == BeaconTypesDef.BEACON_TYPE_ILS_FAR_HOMER
					or typeB == BeaconTypesDef.BEACON_TYPE_ILS_NEAR_HOMER
					or typeB == BeaconTypesDef.BEACON_TYPE_NAUTICAL_HOMER then
					
					freqTmp = data.frequency/1000
					freqStr = addSeparate(base.tostring(freqTmp)).." ".._("kHz")
				elseif typeB == BeaconTypesDef.BEACON_TYPE_TACAN 
					or typeB == BeaconTypesDef.BEACON_TYPE_ICLS_GLIDESLOPE then
					freqStr = base.tostring(data.channel)..(data.modeChannel or "")	
				else	
					freqTmp = data.frequency/1000000
					freqStr = addSeparate(base.tostring(freqTmp)).." ".._("MHz")
				end
				cell:setText(freqStr)
				grid:setCell(IndexColumsByType[typeB], row, cell)
				cell:setSkin(gridStaticSkin)
				if beacons.color then
					cell:setSkin(SkinUtils.setStaticTextColor(beacons.color, cell:getSkin()))
				end
			end
			row = row + 1
		end	
	end
	
	updateColumnHeaders()
end

function addSeparate(n)
   local v1,v2,v3 = base.string.match(n,'^([^%d]*%d)(%d*)(.-)$')
   return v1..(v2:reverse():gsub('(%d%d%d)','%1 '):reverse())..v3
end

local function getColumnHeaderSkin(a_key, a_index)
	if curKeySort == a_key then
		if sortReverse then
			return SkinsHeaders.skinSortDown
		else
			return SkinsHeaders.skinSortUp
		end
	else
		return SkinsHeaders.skinNoSort
	end
end

function updateColumnHeaders()
	local count = grid:getColumnCount()
	
	for i = 0, count - 1 do
		local gridHeaderCell = grid:getColumnHeader(i)
		
		if gridHeaderCell then
			local skin = getColumnHeaderSkin(gridHeaderCell.KeySort, i)
			
			if skin then
				gridHeaderCell:setSkin(skin)
			end
		end
	end
end

function createGrid()
	
--Name
	local gridHeaderName = GridHeaderCell.new()
	gridHeaderName:setSkin(gridHeaderSkin) 
	gridHeaderName:setText(cdata.name)	
	gridHeaderName:addChangeCallback(headerCellChangeCallback)
	gridHeaderName.KeySort = "display_name"
	gridHeaderName.index = 0
	grid:insertColumn(200, gridHeaderName)

--Ident	
	local gridHeaderName = GridHeaderCell.new()
	gridHeaderName:setSkin(gridHeaderSkin) 
	gridHeaderName:setText(cdata.ident)	
	gridHeaderName:addChangeCallback(headerCellChangeCallback)
	gridHeaderName.KeySort = "callsign"
	gridHeaderName.index = 1
	grid:insertColumn(70, gridHeaderName)

	
	local index = 2
	for k, Beacon in base.ipairs(BeaconTypes) do	
	--	if SelectedColums[Beacon.type] == true then
			local gridHeaderName = GridHeaderCell.new()
			gridHeaderName:setSkin(gridHeaderSkin) 
			gridHeaderName:setText(Beacon.name)	
			gridHeaderName:addChangeCallback(headerCellChangeCallback)
			gridHeaderName.KeySort = Beacon.type
			gridHeaderName.index = index
			local nw,nh = gridHeaderName:calcSize()
			grid:insertColumn(nw + 60, gridHeaderName)
			IndexColumsByType[Beacon.type] = index
			TypeByIndexColums[index] = Beacon.type
			index = index + 1
			
	--	end
	end
	
end

function compareTbl(tab1, tab2)
	if curKeySort == 'display_name' or curKeySort == 'callsign' then
		if sortReverse == false then
			return textutil.Utf8Compare(tab1[curKeySort], tab2[curKeySort])
		else
			return textutil.Utf8Compare(tab2[curKeySort], tab1[curKeySort])
		end
	elseif curKeySort == BeaconTypesDef.BEACON_TYPE_TACAN then
		local value1 = (tab1.beaconsTbl[curKeySort] and tab1.beaconsTbl[curKeySort].channel) or 9999999999999999
		local value2 = (tab2.beaconsTbl[curKeySort] and tab2.beaconsTbl[curKeySort].channel) or 9999999999999999
		
		if sortReverse == false then
			return value1 < value2
		else
			return value2 < value1
		end
	else
		local value1 = (tab1.beaconsTbl[curKeySort] and tab1.beaconsTbl[curKeySort].frequency) or 9999999999999999
		local value2 = (tab2.beaconsTbl[curKeySort] and tab2.beaconsTbl[curKeySort].frequency) or 9999999999999999
		
		if sortReverse == false then
			return value1 < value2
		else
			return value2 < value1
		end
	end	
end

function onChange_btnClose()
	window:setVisible(false)
end

function onChange_cbVOR(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_VOR] = self:getState()	
	update()
end

function onChange_cbDME(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_DME] = self:getState()	
	update()
end

function onChange_cbVOR_DME(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_VOR_DME] = self:getState()	
	update()
end

function onChange_cbTACAN(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_TACAN] = self:getState()	
	update()
end

function onChange_cbVORTAC(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_VORTAC] = self:getState()	
	update()
end

function onChange_cbRSBN(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_RSBN] = self:getState()	
	update()
end

function onChange_cbBROADCAST_STATION(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_BROADCAST_STATION] = self:getState()	
	update()
end

function onChange_cbHOMER(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_HOMER] = self:getState()	
	update()
end

function onChange_cbAIRPORT_HOMER(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_AIRPORT_HOMER] = self:getState()	
	update()
end

function onChange_cbAIRPORT_HOMER_WITH_MARKER(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER] = self:getState()	
	update()
end
  	
function onChange_cbILS_FAR_HOMER(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_ILS_FAR_HOMER] = self:getState()	
	update()
end

function onChange_cbILS_NEAR_HOMER(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_ILS_NEAR_HOMER] = self:getState()	
	update()
end

function onChange_cbILS_LOCALIZER(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_ILS_LOCALIZER] = self:getState()	
	update()
end

function onChange_cbILS_GLIDESLOPE(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_ILS_GLIDESLOPE] = self:getState()	
	update()
end

function onChange_cbPRMG_LOCALIZER(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_PRMG_LOCALIZER] = self:getState()	
	update()
end

function onChange_cbPRMG_GLIDESLOPE(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_PRMG_GLIDESLOPE] = self:getState()	
	update()
end

function onChange_cbICLS_LOCALIZER(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_ICLS_LOCALIZER] = self:getState()	
	update()
end

function onChange_cbICLS_GLIDESLOPE(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_ICLS_GLIDESLOPE] = self:getState()	
	update()
end

function onChange_cbNAUTICAL_HOMER(self)
	SelectedColums[BeaconTypesDef.BEACON_TYPE_NAUTICAL_HOMER] = self:getState()	
	update()
end

function onChange_bSelectDeselect(self)	
	for k,v in base.pairs(cbTbl) do
		v:setState(selectAll)
	end

	for k,v in base.pairs(BeaconTypes) do
		SelectedColums[v.type] = selectAll
	end
	
	selectAll = not selectAll
	update()
end

function onChange_bGoToBeacon(self) 
	local selectedRowIndex  = grid:getSelectedRow()
	if -1 < selectedRowIndex  then
		local position = grid:getCell(0, selectedRowIndex).position
		if position and position[1] and position[3] then
			MapWindow.focusPointMap(position[1], position[3])
			UpdateManager.add(function()
				window:setVisible(false)			
				return true
			end)			
		end
	end
end

function headerCellChangeCallback(self)  
	if curKeySort ~= self.KeySort then
		curKeySort = self.KeySort
	else
		sortReverse = not sortReverse
	end

	update()	
end	