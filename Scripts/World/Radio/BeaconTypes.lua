package.path = package.path..';./Scripts/?.lua;'..'./Scripts/Common/?.lua;'	
local utils = require('utils')

--Type
BEACON_TYPE_NULL = 0
BEACON_TYPE_VOR = 1
BEACON_TYPE_DME = 2
BEACON_TYPE_VOR_DME = 3
BEACON_TYPE_TACAN = 4
BEACON_TYPE_VORTAC = 5
BEACON_TYPE_RSBN = 128
BEACON_TYPE_BROADCAST_STATION = 1024

BEACON_TYPE_HOMER = 8
BEACON_TYPE_AIRPORT_HOMER = 4104
BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER = 4136
BEACON_TYPE_ILS_FAR_HOMER = 16408
BEACON_TYPE_ILS_NEAR_HOMER = 16424

BEACON_TYPE_ILS_LOCALIZER = 16640
BEACON_TYPE_ILS_GLIDESLOPE = 16896

BEACON_TYPE_PRMG_LOCALIZER = 33024
BEACON_TYPE_PRMG_GLIDESLOPE = 33280

BEACON_TYPE_ICLS_LOCALIZER = 131328
BEACON_TYPE_ICLS_GLIDESLOPE = 131584

BEACON_TYPE_NAUTICAL_HOMER = 65536

--Beacon state
BEACON_DISABLED = 0
BEACON_ACTIVE = 1 --default status
BEACON_INACTIVE = 2
BEACON_DESTROYED = 3

--Constructors
--ILS localizer & glideslop pair

local ILSchannelsPairs = {
	['18X']	=	{108.10,	334.70},
	['18Y']	=	{108.15,	334.55},
	['20X']	=	{108.30,	334.10},
	['20Y']	=	{108.35,	333.95},
	['22X']	=	{108.50,	329.90},
	['22Y']	=	{108.55,	329.75},
	['24X']	=	{108.70,	330.50},
	['24Y']	=	{108.75,	330.35},
	['26X']	=	{108.90,	329.30},
	['26Y']	=	{108.95,	329.15},

	['28X']	=	{109.10,	331.40},
	['28Y']	=	{109.15,	331.25},
	['30X']	=	{109.30,	332.00},
	['30Y']	=	{109.35,	331.85},
	['32X']	=	{109.50,	332.60},
	['32Y']	=	{109.55,	332.45},
	['34X']	=	{109.70,	333.20},
	['34Y']	=	{109.75,	333.05},
	['36X']	=	{109.90,	333.80},
	['36Y']	=	{109.95,	333.65},

	['38X']	=	{110.10,	334.40},
	['38Y']	=	{110.15,	334.25},
	['40X']	=	{110.30,	335.00},
	['40Y']	=	{110.35,	334.85},
	['42X']	=	{110.50,	329.60},
	['42Y']	=	{110.55,	329.45},
	['44X']	=	{110.70,	330.20},
	['44Y']	=	{110.75,	330.05},
	['46X']	=	{110.90,	330.80},
	['46Y']	=	{110.95,	330.65},

	['48X']	=	{111.10,	331.70},
	['48Y']	=	{111.15,	331.55},
	['50X']	=	{111.30,	332.30},
	['50Y']	=	{111.35,	332.15},
	['52X']	=	{111.50,	332.90},
	['52Y']	=	{111.55,	332.75},
	['54X']	=	{111.70,	333.50},
	['54Y']	=	{111.75,	333.35},
	['56X']	=	{111.90,	331.10},
	['56Y']	=	{111.95,	330.95}
}

function findGSByLOC(localFrequencyMhz)
	local channelPairNum = (localFrequencyMhz - 108.10) / 0.2
	local channelLetter = 'X'
	if channelPairNum - math.floor(channelPairNum) > 1E-3 then
		channelLetter = 'Y'
	end
	local channelId = tostring(18 + 2 * math.floor(channelPairNum))..channelLetter		
	local channel = ILSchannelsPairs[channelId]
	assert(channel ~= nil)
	assert(math.abs(channel[1] - localFrequencyMhz) < 10)
	return channel[2]
end

do
	local function set(self, locFrequencyMhz, gsFrequencyMhz, callsign, glideSlopeElev)
		return {
			type = BEACON_TYPE_ILS_LOCALIZER,
			callsign = callsign,
			frequency = locFrequencyMhz * 1000000.0,
			position = {
				-- temporarily omitted as glideslope elevation is
				-- already accounted inside radio measurement equipment
				
				--elevation = glideSlopeElev,
				BS0 = 0.0,
				Z0 = 0.0,
			}
		},
		{
			type = BEACON_TYPE_ILS_GLIDESLOPE,
			frequency = gsFrequencyMhz * 1000000.0,
			position = {
				-- temporarily omitted as glideslope elevation is
				-- already accounted inside radio measurement equipment
				
				--elevation = glideSlopeElev,
				S0 = 305.0,
				Z0 = 0.0,
			}
		}
	end

	ILS = {
		frequency = function(self, frequencyMhz, callsign, glideSlopeElev)
			return set(self, frequencyMhz, findGSByLOC(frequencyMhz), callsign, glideSlopeElev)
		end,
		channel = function(self, channelId, callsign, glideSlopeElev)
			local channel = ILSchannelsPairs[channelId]
			assert(channel ~= nil)
			return set(self, channel[1], channel[2], callsign, glideSlopeElev)
		end
	}
end

-- Use 'Y' channelMode to get frequency for A/A TACAN mode
function getTACANFrequency(channel, channelMode)
	local A = 1151 -- 'X', channel >= 64
	local B = 64   -- channel >= 64
	
	if channel < 64 then
		B = 1
	end
	
	if channelMode == 'Y' then
		A = 1025
		if channel < 64 then
			A = 1088
		end
	else -- 'X'
		if channel < 64 then
			A = 962
		end
	end
	
	return (A + channel - B) * 1000000
end

function TACAN(channelNum, channelMode, callsign, position)
	return 	{
				type = BEACON_TYPE_TACAN,
				callsign = callsign,
				frequency = getTACANFrequency(channelNum, channelMode),
				channelTACAN = channelNum..channelMode,
				position = position or {
											Z0 = -120.0,
											S0 = 1100.0,
										}
			}	
end

function PRMG(channelNum, callsign, glideSlopeElev)
	return {
		type = BEACON_TYPE_PRMG_LOCALIZER,
		callsign = callsign,
		channel = channelNum,
		frequency = 905100000 + 6825000 * (channelNum - 1),
		position = {
			elevation = glideSlopeElev,
			BS0 = 0.0,
			Z0 = 0.0,
			S0 = 3500.0
		}
	},
	{
		type = BEACON_TYPE_PRMG_GLIDESLOPE,
		frequency = 939600000 + 6825000 * (channelNum - 1),
		position = {
			elevation = glideSlopeElev,
			S0 = 170.0,
			Z0 = 250.0,
		}
	}
end

function getICLSFrequency(channel)
	return 15415000000 + 30000000 * ((channel - 1) % 10)
end

function ICLS(channelNum, glideSlopeElev)
	return {
		type = BEACON_TYPE_ICLS_LOCALIZER,
		--callsign = callsign,
		channel = channelNum,
		frequency = getICLSFrequency(channelNum),
		position = {
			elevation = glideSlopeElev,
			BS0 = 0.0,		-- TODO:
			Z0 = 0.0,		-- TODO:
			S0 = 3500.0		-- TODO:
		}
	},
	{
		type = BEACON_TYPE_ICLS_GLIDESLOPE,
		frequency = getICLSFrequency(channelNum),
		position = {
			elevation = glideSlopeElev,
			S0 = 170.0,		-- TODO:
			Z0 = 250.0,		-- TODO:
		}
	}
end



function coordinates(str)
	local latitude, longitude, course = utils.parseCordinates(str)
	return {	latitude = latitude,
				longitude = longitude,
				course = course }
end