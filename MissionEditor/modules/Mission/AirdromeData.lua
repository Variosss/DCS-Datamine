local Airdrome				= require('Mission.Airdrome')
local TheatreOfWarData		= require('Mission.TheatreOfWarData')
local CoalitionController	= require('Mission.CoalitionController')
local TableUtils			= require('TableUtils')
local Terrain				= require('terrain')
local U						= require('me_utilities')
local UC				    = require('utils_common')
local i18n					= require('i18n')
local DCS                   = require('DCS')

local controller_
local missionData_
local airdromesById_
local idCounter_ = 0
local tblOriginalAirdromes

local function setController(controller)
	controller_	= controller
end

local function setMissionData(missionData)
	missionData_ = missionData
end

local function getAirdromeBounds()
	local airdromeBounds = {}
	local func, err = loadfile(TheatreOfWarData.getMapFolder() .. 'AirdromeBounds.lua')
	
	if func then
		airdromeBounds = func()
	else
		print(err)
	end
	
	return airdromeBounds
end

-- для избежания конфликта с id объектов в миссиях, созданных до AirdromeData,
-- у аэродромов id сделаем отрицательными
local function getNewId()
	idCounter_ = idCounter_ - 1
	
	return idCounter_
end

local function onNewMission()
	idCounter_ 		= 0
	airdromesById_	= {}
    tblOriginalAirdromes = {}
	
	local coalitionName = CoalitionController.neutralCoalitionName()
	
    local radio 
    if Terrain.getRadio then
        radio= Terrain.getRadio()
    end
	
	local Airdromes = Terrain.GetTerrainConfig('Airdromes')
   
	if Airdromes == nil then
		return
	end
	
	for airdromeNumber, airdromeInfo in pairs(Terrain.GetTerrainConfig('Airdromes')) do
        if (airdromeInfo.reference_point) and (airdromeInfo.abandoned ~= true)  then 
            local x, y			= airdromeInfo.reference_point.x, airdromeInfo.reference_point.y
            local height        = Terrain.GetHeight(x, y)
            local locale		= i18n.getLocale()		
            local name	
			local warehouses
			local fueldepots
			
			if Terrain.getObjectPosition then
				if airdromeInfo.warehouses then
					warehouses = {}
					for k,v in pairs(airdromeInfo.warehouses) do
						local x,y = Terrain.getObjectPosition(v)						
						if x ~= nil and y ~= nil then
							table.insert(warehouses, {x=x, y=y})
						else
							--print("ERROR getObjectPosition did not return coordinates, for object:",v)
						end
					end
				end
				if airdromeInfo.fueldepots then
					fueldepots = {}
					for k,v in pairs(airdromeInfo.fueldepots) do
						local x,y = Terrain.getObjectPosition(v)
						if x ~= nil and y ~= nil then
							table.insert(fueldepots, {x=x, y=y})
						else
							--print("ERROR getObjectPosition did not return coordinates, for object:",v)
						end
					end
				end
			end
		
            if airdromeInfo.display_name then
                name = _(airdromeInfo.display_name) 
            else
                name = airdromeInfo.names[locale] or airdromeInfo.names['en']
            end    
            --print("--airdromeInfo name--", name, airdromeInfo.display_name,airdromeInfo.roadnet)  
            local class	
            if type(airdromeInfo.class) == 'number' then
                class			= tostring(airdromeInfo.class)
            else
                class			= airdromeInfo.class
            end
         --   U.traverseTable(airdromeInfo)
         --   print("--airdromeNumber--",airdromeNumber, airdromeInfo.frequency, airdromeInfo.radio)  
            local frequencyList = {}
            if airdromeInfo.frequency then
                frequencyList	= airdromeInfo.frequency
            else
                if airdromeInfo.radio then
                    for k, radioId in pairs(airdromeInfo.radio) do
                        local frequencys = DCS.getATCradiosData(radioId)
                      --  U.traverseTable(frequencys)
                      --  print("--frequencys---")
                        if frequencys then
                            for kk,vv in pairs(frequencys) do
                                table.insert(frequencyList, vv)  
                            --    print("--add--",airdromeNumber, name,  vv)  
                            end
                        end
                    end
                end            
            end
            
            local roadnet 		= airdromeInfo.roadnet
            local heading		= Terrain.getRunwayHeading(roadnet)
            local angle			= UC.toDegrees(heading)
        --    local bounds		= airdromeBounds[airdromeNumber]
            
          --  if not bounds then
                --print('Aerodrome ' .. name .. ' has no bounds!')
          --  end
        
            local id = getNewId()
            local airdrome = Airdrome.new(x, y, airdromeNumber, name, class, frequencyList, angle, bounds, id, height, warehouses, fueldepots)
            
            airdrome:setCoalitionName(coalitionName)
            airdrome:setRoadnet(roadnet)
            
            if missionData_ then
                missionData_.registerAirdrome(id)
            end

            airdromesById_[id]	= airdrome
            
            tblOriginalAirdromes[airdromeNumber] = airdromeInfo
        end
	end	
end

local function getTblOriginalAirdromes()
    return tblOriginalAirdromes
end

local function getAirdromes()
	local airdromes = {}
	
	for id, airdrome in pairs(airdromesById_) do
		table.insert(airdromes, airdrome:clone())
	end
	
	return airdromes
end

local function getAirdrome(airdromeId)
	local airdrome = airdromesById_[airdromeId]
	
	if airdrome then
		return airdrome:clone()
	end	
end

local function getAirdromeId(airdromeNumber)
	for id, airdrome in pairs(airdromesById_) do
		if airdrome:getAirdromeNumber() == airdromeNumber then
			return id
		end
	end
end

local function getAirdromeNumber(airdromeId)
	local airdrome = airdromesById_[airdromeId]
	
	if airdrome then
		return airdrome:getAirdromeNumber()
	end	
end

local function getAirdromeRoadnet(airdromeNumber)
	local airdrome = airdromesById_[getAirdromeId(airdromeNumber)]
	
	if airdrome then
		return airdrome:getRoadnet()
	end	
end

local function setAirdromeCoalition(airdromeId, coalitionName)
	airdromesById_[airdromeId]:setCoalitionName(coalitionName)
	
	if controller_ then
		controller_.airdromeCoalitionChanged(airdromeId)
	end
end

return {
	setController			= setController,
	setMissionData			= setMissionData,
	
	onNewMission			= onNewMission,
	
	getAirdromes			= getAirdromes,
	getAirdrome				= getAirdrome,
	getAirdromeId			= getAirdromeId,
	getAirdromeNumber		= getAirdromeNumber,
	getAirdromeRoadnet		= getAirdromeRoadnet,
    getTblOriginalAirdromes = getTblOriginalAirdromes,
	setAirdromeCoalition	= setAirdromeCoalition,
}