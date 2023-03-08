local MissionGenerator = require('MissionGenerator')
local NodesManager = require('me_nodes_manager')
local TemplatesManager = require('me_templates_manager')
local MissionModule = require('me_mission')
local MapWindow = require('me_map_window')
local Toolbar = require('me_toolbar')
local GDData = require('me_generator_dialog_data')
local Terrain = require('terrain')
local TheatreOfWarData	= require('Mission.TheatreOfWarData')
local localizationMG = require('me_localizationMG')
local U 			= require('me_utilities')
local DB = require('me_db_api')

local misPath = userFiles.userMissionPath.."MG.miz"

local callback_
local runningFromEditor_
local theatreOfWar_
local genLow_ 

local function reloadEditorMission()
    local nodesVisible = NodesManager.isVisible()
    Toolbar.untoggle_all_except()
    MapWindow.unselectAll()
    MissionModule.mapObjects = {}
    MapWindow.selectedGroup = nil;
    MapWindow.clearUserObjects()
    MissionModule.load(misPath)
    NodesManager.show(nodesVisible)
end

local function reloadMission()
    MapWindow.unselectAll()
    MissionModule.mapObjects = {}
    MapWindow.selectedGroup = nil;
--    MapWindow.clearUserObjects()
    MissionModule.load(misPath)
end

function loadTOW(theatreOfWarName)
    TheatreOfWarData.selectTheatreOfWar(theatreOfWarName)
    MapWindow.initTerrain(true, false, "ME", MissionModule.getDefaultDate())
    MissionModule.create_new_mission(true);
end

function onMisGenEvent(returnCode, nodeId, error, pathMission)
	local enmGenStart, enmGenFinish, enmPercent = 0, 1, 2
	print("--onMisGenEvent--",returnCode, nodeId, error)
	if genLow_ ~= true then
		if returnCode == enmGenStart then
			print('Mission Generator: start thread')

		elseif returnCode == enmGenFinish then
			if nodeId == -1 then
				print('a-ya-yai!!: '..error)
			else
				print('Cool!!')
								
				loadTOW(theatreOfWar_)

				if runningFromEditor_ then
					reloadEditorMission()
				else
					reloadMission()
				end
			end

		elseif returnCode == enmPercent then
			print('percent: '..tostring(nodeId)..' - '..error)
		end
	end	
	
	if callback_ then
		callback_(returnCode, nodeId, error, pathMission)
	end
end

local function generate(playerParams, runningFromEditor, theatreOfWar, nodesIds, redTemplId, blueTemplId, a_callback)
	callback_ = a_callback
	runningFromEditor_ = runningFromEditor
	theatreOfWar_ = theatreOfWar
	localizationMG.init()
	
    local generatorData = {}
    generatorData.combatTemplates = TemplatesManager.templates()
    generatorData.missionNodes = NodesManager.nodes(theatreOfWar)
	
    MissionGenerator.reloadData(generatorData)
    
    playerParams = playerParams
    local params = {}
    params.redTemplId  = redTemplId or ""
    params.blueTemplId  = blueTemplId or ""
    
    params.misPath = misPath
 
    --TODO назвать параметры одинаково, использовать копирование таблицы
    params.nodesIds = nodesIds 
    params.theatreOfWar = theatreOfWar
	params.predefinedMission = playerParams.predefinedMission
    params.playerAircraft = playerParams.aircraft
    params.playerAircraftsType = playerParams.aircraftsType
    params.playerCountry = playerParams.countryId
    params.botsInGroup = playerParams.wingmansCount
    params.difficulty = playerParams.difficulty
    params.forces = playerParams.forces
    params.season = playerParams.season
    params.weather = playerParams.weather
    params.startTime = playerParams.startTime
    params.takeoffFrom = playerParams.takeoffFrom
	params.taskWorldID = playerParams.taskWorldID
	params.playerAltitude = playerParams.playerAltitude
	params.nodeDistance = playerParams.nodeDistance
	params.typeAttack = playerParams.typeAttack

	genLow_ = false
	--callbacksMG.setCallback(endGenerate1)
    MissionGenerator.generate_thread(params)
	--print("---MissionGenerator.generate---",generated, nodeId, errMsg, params.taskWorldID)
end

function generateLow(params, a_callback)
	local result, errStr = MissionGenerator.generate_thread(params)
	if result == true then
		callback_ = a_callback
		genLow_ = true
	end
	return result, errStr
end

function getCountriesByLA(a_type, a_predefinedMission)
	if MissionGenerator.getCountriesByLA then
		return MissionGenerator.getCountriesByLA(a_type, a_predefinedMission) 
	end
	return nil
end

function getListLA(a_idPreset, a_predefinedMission)
	local list = MissionGenerator.getListLA(a_idPreset, a_predefinedMission) 
	local result = {}
	
	for k,unit_type in pairs(list) do
		local unitDef = DB.unit_by_type[unit_type]
		
		local _aircraftType	
		if unitDef.attribute[2] == _G.wsType_Airplane and unitDef.attribute[3] == _G.wsType_Fighter then
			_aircraftType = "FighterPlanes"
		elseif unitDef.attribute[2] == _G.wsType_Airplane 
			and (unitDef.attribute[3] == _G.wsType_Battleplane
				or unitDef.attribute[3] == _G.wsType_Intruder
				or unitDef.attribute[3] == _G.wsType_Cruiser) then
			_aircraftType = "AttackPlanes"
		elseif unitDef.attribute[2] == _G.wsType_Helicopter then
			_aircraftType = "Helicopters"
		end
		
		table.insert(result, {id = unitDef.type, name = unitDef.DisplayName, aircraftType = _aircraftType}) 
	end
	return result
end

local function saveAll()
    if (NodesManager.isChanged()) then
        NodesManager.saveNodes()
    end
    
    if (TemplatesManager.isChanged()) then
        TemplatesManager.saveTamplates()
    end
    
    GDData.saveGeneratorParams()
end

return {
	generate	    = generate,
	saveAll		    = saveAll,
    reloadMission   = reloadMission,
	generateLow		= generateLow,
	getCountriesByLA= getCountriesByLA,
	getListLA		= getListLA,
}