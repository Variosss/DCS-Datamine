local Beacon			= require('Mission.Beacon')
local AirdromeData		= require('Mission.AirdromeData')
local TheatreOfWarData	= require('Mission.TheatreOfWarData')
local Tools				= require('tools')
local Terrain			= require('terrain')
local U                 = require('me_utilities')

local beaconsWithoutMarker_
local beaconsWithMarker_
local beaconsIls_
local beaconsTacan_
local beaconsVor_
local beaconsDME_
local beaconsVORDME_
local beaconsVORTAC_
local beaconsRSBN_
local beaconsHOMER_

local BEACON_ACTIVE_
local BEACON_TYPE_NAUTICAL_HOMER_
local BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER_
local BEACON_TYPE_ILS_FAR_HOMER_
local BEACON_TYPE_ILS_NEAR_HOMER_
local BEACON_TYPE_ILS_LOCALIZER_
local BEACON_TYPE_ILS_GLIDESLOPE_
local BEACON_TYPE_PRMG_LOCALIZER_
local BEACON_TYPE_PRMG_GLIDESLOPE_
local BEACON_TYPE_TACAN_
local BEACON_TYPE_VOR_
local BEACON_TYPE_VORTAC_
local BEACON_TYPE_VOR_DME_
local BEACON_TYPE_HOMER_
local BEACON_TYPE_AIRPORT_HOMER_

local function matchBeaconWithMarkerSideType(sideType)
	return	sideType == BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER_ or
			sideType == BEACON_TYPE_ILS_FAR_HOMER_ or
			sideType == BEACON_TYPE_ILS_NEAR_HOMER_
end

local function matchBeaconIlsSideType(sideType)
	return	sideType == BEACON_TYPE_ILS_LOCALIZER_ 
			or sideType == BEACON_TYPE_PRMG_LOCALIZER_
end

local function matchBeaconTacanSideType(sideType)
	return	sideType == BEACON_TYPE_TACAN_
end

local function matchBeaconVorSideType(sideType)
	return	sideType == BEACON_TYPE_VOR_
end

local function matchBeaconDMESideType(sideType)
	return	sideType == BEACON_TYPE_DME_
end

local function matchBeaconVORDMESideType(sideType)
	return	sideType == BEACON_TYPE_VOR_DME_
end

local function matchBeaconVORTACSideType(sideType)
	return	sideType == BEACON_TYPE_VORTAC_
end

local function matchBeaconRSBNSideType(sideType)
	return	sideType == BEACON_TYPE_RSBN_
end

local function matchBeaconHOMERSideType(sideType)
	return	sideType == BEACON_TYPE_HOMER_ or sideType == BEACON_TYPE_AIRPORT_HOMER_
end

local function loadBeaconsWithoutMarker(beaconsData)
	if beaconsData then
		for name, beaconData in pairs(beaconsData) do            
			if	(nil == beaconData.status or beaconData.status == BEACON_ACTIVE_) and 
				beaconData.type ~= BEACON_TYPE_NAUTICAL_HOMER_ then

				local x, y		= Terrain.convertLatLonToMeters(beaconData.position.latitude, beaconData.position.longitude)
				local angle		= 0
				local frequency	= beaconData.frequency
				local beacon	= Beacon.new(x, y, angle, frequency)
				beacon:setName(beaconData.name)
                beacon:setCallsign(beaconData.callsign)
                beacon:setChannel(beaconData.channel)
				table.insert(beaconsWithoutMarker_, beacon)
			end
		end
	end
end

local function calcPosition(a_beaconData, a_angle) 
    local offsetX = 0 
    local offsetY = 0   
    local angle = -a_angle + math.pi / 2 -- для правильной ориентации на карте
    if angle and a_beaconData.chartOffsetX then
        offsetX = a_beaconData.chartOffsetX * math.sin(angle)
        offsetY = a_beaconData.chartOffsetX * math.cos(angle)
    end
    return a_beaconData.position[1]+offsetX, a_beaconData.position[3]+offsetY
end

local function loadBeaconsMarkerT4(beaconsData)
	if beaconsData then
		for name, beaconData in pairs(beaconsData) do
            local angle = (beaconData.direction or 0) * math.pi / 180 
            local x, y		= calcPosition(beaconData,angle) 
            
            local beacon	= Beacon.new(x, y, angle, beaconData.frequency)                        
            beacon:setName(beaconData.name)
            beacon:setCallsign(beaconData.callsign)
			
			local channel = beaconData.channel or ""
			if (beaconData.type == BEACON_TYPE_TACAN_) then
				channel = channel.."X"
			end
            
            if beaconData.type == BEACON_TYPE_PRMG_LOCALIZER_ then
                beacon:setTextColor({0, 0, 1})
            end
	
			beacon:setChannel(channel)
            
            if matchBeaconIlsSideType(beaconData.type) then            
                table.insert(beaconsIls_, beacon)
            elseif matchBeaconVorSideType(beaconData.type) then                                
                table.insert(beaconsVor_, beacon)
            elseif matchBeaconWithMarkerSideType(beaconData.type) then
                table.insert(beaconsWithMarker_, beacon)
            elseif matchBeaconTacanSideType(beaconData.type) then   
                table.insert(beaconsTacan_, beacon)
            elseif matchBeaconDMESideType(beaconData.type) then
                table.insert(beaconsDME_, beacon)
            elseif matchBeaconVORDMESideType(beaconData.type) then
                table.insert(beaconsVORDME_, beacon)
            elseif matchBeaconVORTACSideType(beaconData.type) then  
                table.insert(beaconsVORTAC_, beacon)
            elseif matchBeaconRSBNSideType(beaconData.type) then  
                table.insert(beaconsRSBN_, beacon) 
            elseif matchBeaconHOMERSideType(beaconData.type) then  
                table.insert(beaconsHOMER_, beacon) 
            else
                --print("--no used type beacon--",beaconData.type)
            end
		end
	end
end

local function matchSideName(sideName, edge1name, edge2name)
	if sideName == edge1name then
		return 1
	elseif sideName == edge2name then
		return 2
	else
		local sideNumber	= tonumber(string.match(sideName,	'%d+'))		
		local edge1Number	= tonumber(string.match(edge1name,	'%d+'))
		local edge2Number	= tonumber(string.match(edge2name,	'%d+'))
		
		if	edge1Number == sideNumber	or 
			edge1Number == sideNumber + 1 or 
			edge1Number == sideNumber - 1 then
			
			return 1
		end	
		
		if	edge2Number == sideNumber	or 
			edge2Number == sideNumber + 1 or 
			edge2Number == sideNumber - 1 then
			
			return 2
		end
	end
	
	return 0
end

local function getBeaconPlacement(sideName, runway, roadnet)
	local x
	local y
	local angle
	local matchResult = matchSideName(sideName, runway.edge1name, runway.edge2name)
	
	if 1 == matchResult then
		x			= runway.edge1x
		y			= runway.edge1y
		angle		= math.pi + runway.course	
	elseif 2 == matchResult then
		x			= runway.edge2x
		y			= runway.edge2y
		angle		= runway.course	
	else
		x			= runway.edge1x
		y			= runway.edge1y
		angle		= math.pi + runway.course
		
		print('Error! Beacon side not found!', sideName, runway.edge1name, runway.edge2name, roadnet)
	end
	
	return x, y, angle
end

local function getBeaconPosition(x, y, angle, position)	
	if position.S0 then					   
	   return	x - position.S0 * math.cos(angle),
				y - position.S0 * math.sin(angle) 
	end
	
	if position.Z0 then					   
	   return	x + position.Z0 * math.cos(-math.pi / 2 + angle),
				y + position.Z0 * math.sin(-math.pi / 2 + angle)					
	end
					
	return x, y
end

local function createBeaconsWithMarkerFromRunway(sideType, side, sideName, roadnet)	
	local position = side.position
	
	if not position then
		if sideType == BEACON_TYPE_ILS_FAR_HOMER_ then
			position = {S0 = -4000}
		elseif sideType == BEACON_TYPE_ILS_NEAR_HOMER_ then
			position = {S0 = -1300}
		end
	end
	
	for i, runway in pairs(Terrain.getRunwayList(roadnet)) do
		local sideX, sideY, angle	= getBeaconPlacement(sideName, runway, roadnet)
		local x, y					= getBeaconPosition(sideX, sideY, angle, position)
		local frequency				= side.frequency
		local beacon				= Beacon.new(x, y, angle, frequency)
		
        beacon:setName(side.name)
        beacon:setCallsign(side.callsign)
        beacon:setChannel(side.channel)
		table.insert(beaconsWithMarker_, beacon)
	end
end

local function createBeaconsIlsFromRunway(side, sideName, roadnet)
	for i, runway in pairs(Terrain.getRunwayList(roadnet)) do
		local sideX, sideY, angle	= getBeaconPlacement(sideName, runway, roadnet)
		local frequency				= side.frequency
		local channel
		
		local beaconIls = Beacon.new(sideX, sideY, angle, frequency)
        
        if side.type == BEACON_TYPE_PRMG_LOCALIZER_ then
			channel = side.channel
            beaconIls:setTextColor({0, 0, 1})
		end
		
        beaconIls:setName(side.name)
        beaconIls:setCallsign(side.callsign)
        beaconIls:setChannel(channel)
		
		table.insert(beaconsIls_, beaconIls)
	end
end

local function loadBeaconsFromRunway(runwayData, roadnet)
	if runwayData then
		for sideRangeName, ranges in pairs(runwayData) do
			if ranges.side then
				for sideName, sides in pairs(ranges.side) do
					for j, side in ipairs(sides) do
						local sideType = side.type
						
						if matchBeaconWithMarkerSideType(sideType) then
							createBeaconsWithMarkerFromRunway(sideType, side, sideName, roadnet)
						elseif matchBeaconIlsSideType(sideType) then
							createBeaconsIlsFromRunway(side, sideName, roadnet)
						end
					end
				end
			end
		end	
	end
end

local function createBeaconWithMarkerFromAirdrome(airdrome)
	local x, y		= Terrain.convertLatLonToMeters(airdrome.position.latitude, airdrome.position.longitude)
	local angle		= 0
	local frequency	= airdrome.frequency
	local beacon	= Beacon.new(x, y, angle, frequency)
	beacon:setName(airdrome.name)
    beacon:setCallsign(airdrome.callsign)
    beacon:setChannel(airdrome.channel)
	table.insert(beaconsWithMarker_, beacon)
end

local function createBeaconTacanFromAirdrome(airdrome)
	local x			= airdrome.position.x
	local y			= airdrome.position.z
	local channel	= airdrome.channelTACAN
	local angle 	= 0
	local frequency

	local beaconTacan = Beacon.new(x, y, angle, frequency)
	
	beaconTacan:setChannel(channel)
    beaconTacan:setName(airdrome.name)
    beaconTacan:setCallsign(airdrome.callsign)
	
	table.insert(beaconsTacan_, beaconTacan)
end

local function createBeaconHomerFromAirdrome(airdrome)
	local x, y		= Terrain.convertLatLonToMeters(airdrome.position.latitude, airdrome.position.longitude)
	local angle 	= 0
	local frequency	= airdrome.frequency

	local beacon = Beacon.new(x, y, angle, frequency)
	
    beacon:setCallsign(airdrome.callsign)
	
	table.insert(beaconsHOMER_, beacon)
end

local function createBeaconVorFromAirdrome(airdrome)
	local x, y		= Terrain.convertLatLonToMeters(airdrome.position.latitude, airdrome.position.longitude)
	local angle		= 0
	local frequency	= airdrome.frequency
	local beacon	= Beacon.new(x, y, angle, frequency)
	beacon:setChannel(airdrome.channel)
    beacon:setName(airdrome.name)
    beacon:setCallsign(airdrome.callsign)
	table.insert(beaconsVor_, beacon)
end

local function createBeaconRSBNFromAirdrome(airdrome, airdromeNumber)
    local x, y
    local angle	= 0
    if airdrome.position.x and airdrome.position.y then
        x = airdrome.position.x
        y = airdrome.position.y
    elseif airdrome.position.latitude and airdrome.position.longitude then
        x, y = Terrain.convertLatLonToMeters(airdrome.position.latitude, airdrome.position.longitude)
    else
        x = listAirdromes[airdromeNumber].reference_point.x
        y = listAirdromes[airdromeNumber].reference_point.y	
        x, y = getBeaconPosition(x, y, angle, airdrome.position)
    end
	local frequency	= airdrome.frequency
	local beacon	= Beacon.new(x, y, angle, frequency)
    beacon:setChannel(airdrome.channel)
    beacon:setName(airdrome.name)
    beacon:setCallsign(airdrome.callsign)
	table.insert(beaconsRSBN_, beacon)
end

local function loadBeaconsFromAirdrome(airdromeData, airdromeNumber)
	if airdromeData then
		for i, airdrome in ipairs(airdromeData) do
			local sideType = airdrome.type
			
			if matchBeaconWithMarkerSideType(sideType) then
				createBeaconWithMarkerFromAirdrome(airdrome)
			elseif matchBeaconTacanSideType(sideType) then
				createBeaconTacanFromAirdrome(airdrome)
			elseif matchBeaconVorSideType(sideType)	then
				createBeaconVorFromAirdrome(airdrome)
            elseif matchBeaconRSBNSideType(sideType) then   
                createBeaconRSBNFromAirdrome(airdrome, airdromeNumber)
            elseif matchBeaconHOMERSideType(sideType) then  
                createBeaconHomerFromAirdrome(airdrome)
			end
		end
	end
end

local function load()
	beaconsWithoutMarker_	= {}
	beaconsWithMarker_		= {}
	beaconsIls_				= {}
	beaconsTacan_			= {}
	beaconsVor_				= {}
    beaconsDME_             = {}
    beaconsVORDME_          = {}
    beaconsVORTAC_          = {}
    beaconsRSBN_            = {}
    beaconsHOMER_           = {}
	
    local BeaconTypes = Tools.safeDoFileWithDofile("Scripts/World/Radio/BeaconTypes.lua") 
    
    BEACON_ACTIVE_							= BeaconTypes.BEACON_ACTIVE
    BEACON_TYPE_NAUTICAL_HOMER_				= BeaconTypes.BEACON_TYPE_NAUTICAL_HOMER
    BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER_	= BeaconTypes.BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER
    BEACON_TYPE_ILS_FAR_HOMER_				= BeaconTypes.BEACON_TYPE_ILS_FAR_HOMER
    BEACON_TYPE_ILS_NEAR_HOMER_				= BeaconTypes.BEACON_TYPE_ILS_NEAR_HOMER
    BEACON_TYPE_ILS_LOCALIZER_				= BeaconTypes.BEACON_TYPE_ILS_LOCALIZER
	BEACON_TYPE_ILS_GLIDESLOPE_				= BeaconTypes.BEACON_TYPE_ILS_GLIDESLOPE
    BEACON_TYPE_PRMG_LOCALIZER_				= BeaconTypes.BEACON_TYPE_PRMG_LOCALIZER
	BEACON_TYPE_PRMG_GLIDESLOPE_			= BeaconTypes.BEACON_TYPE_PRMG_GLIDESLOPE
	BEACON_TYPE_TACAN_						= BeaconTypes.BEACON_TYPE_TACAN
    BEACON_TYPE_VOR_						= BeaconTypes.BEACON_TYPE_VOR
    BEACON_TYPE_DME_                        = BeaconTypes.BEACON_TYPE_DME 
    BEACON_TYPE_VOR_DME_                    = BeaconTypes.BEACON_TYPE_VOR_DME
    BEACON_TYPE_VORTAC_                     = BeaconTypes.BEACON_TYPE_VORTAC
    BEACON_TYPE_RSBN_                       = BeaconTypes.BEACON_TYPE_RSBN  
    BEACON_TYPE_HOMER_                      = BeaconTypes.BEACON_TYPE_HOMER
    BEACON_TYPE_AIRPORT_HOMER_              = BeaconTypes.BEACON_TYPE_AIRPORT_HOMER
    

    local tblBeacons = Terrain.getBeacons()
    --print("----tblBeacons=",tblBeacons)
    --U.traverseTable(tblBeacons)
    if tblBeacons == nil then
        local filename	= TheatreOfWarData.getBeaconsFile()
        local data		= Tools.safeDoFileWithDofile(filename)
        listAirdromes   = AirdromeData.getTblOriginalAirdromes()
         
        if data then
            loadBeaconsWithoutMarker(data.beacons)
            
            if data.Airdrome then
                for airdromeNumber, beaconData in pairs(data.Airdrome) do
                    local roadnet = AirdromeData.getAirdromeRoadnet(airdromeNumber)
                    
                    if roadnet then
                        loadBeaconsFromRunway(beaconData.runway, roadnet)
                    end
                    
                    loadBeaconsFromAirdrome(beaconData.airdrome,airdromeNumber)
                end
            end
        end
    else
        loadBeaconsMarkerT4(tblBeacons)

       -- U.traverseTable(tblBeacons)
       -- print("------gggggg-----")
    end    
end

local function cloneBeacons(beacons)
	local result = {}
	
	for i, beacon in ipairs(beacons) do
		table.insert(result, beacon:clone())
	end
	
	return result
end

local function getBeaconsWithoutMarker()	
	return cloneBeacons(beaconsWithoutMarker_)
end

local function getBeaconsWithMarker()
	return cloneBeacons(beaconsWithMarker_)
end

local function getBeaconsIls()
	return cloneBeacons(beaconsIls_)
end

local function getBeaconsTacan()
	return cloneBeacons(beaconsTacan_)
end

local function getBeaconsVor()
	return cloneBeacons(beaconsVor_)
end

local function getBeaconsDME()
	return cloneBeacons(beaconsDME_)
end

local function getBeaconsVORDME()
	return cloneBeacons(beaconsVORDME_)
end

local function getBeaconsVORTAC()
	return cloneBeacons(beaconsVORTAC_)
end

local function getBeaconsRSBN()
	return cloneBeacons(beaconsRSBN_)
end

local function getBeaconsHOMER()
	return cloneBeacons(beaconsHOMER_)
end


return {
	load					= load,
	getBeaconsWithoutMarker	= getBeaconsWithoutMarker,
	getBeaconsWithMarker	= getBeaconsWithMarker,
	getBeaconsIls			= getBeaconsIls,
	getBeaconsTacan			= getBeaconsTacan,
	getBeaconsVor			= getBeaconsVor,
    getBeaconsDME           = getBeaconsDME,
    getBeaconsVORDME        = getBeaconsVORDME,
    getBeaconsVORTAC        = getBeaconsVORTAC,
    getBeaconsRSBN          = getBeaconsRSBN,
    getBeaconsHOMER         = getBeaconsHOMER,
}