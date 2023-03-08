dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."config.lua")

function post_initialize()
	-- Commented until further investigation of its purpose.
	-- Reason: it was always setting Taxi/Landing lights to taxi position.
	
	--local light = GetSelf()
	--light:performClickableAction(device_commands.Button_14, 0)
    --light:performClickableAction(device_commands.Button_15, 0)
	--light:performClickableAction(device_commands.Button_16, 0)
end

function skinned_material_name(original,texture,class)
	return original
end

CautionLights =
{
	arg_number	       = 905,
	input		       = {0, 1},
	output		       = {0, 1},
	smooth 			   = true,
	use_electric_power = false,
}

AppIndxrAndAARLights =
{
	arg_number	       = 906,
	input		       = {0, 1},
	output		       = {0.65, 1},
	smooth 			   = true,
	use_electric_power = false,
}

local designer_choice 	  =  {0, 200/255, 160/255}

local console_light_color = designer_choice --{0,1.0,0.7}

ConsoleLight =
{
	arg_number	      = 800,
	input		      = {0, 1},
	output		      = {0, 1},
	smooth 			  = true,
}

EngineInstrumentLights =
{
	arg_number	= 801,
	input		= {0, 1},
	output		= {0, 1},
	smooth		= true,
}

EngineInstrumentLights2 =
{
	arg_number	= 805,
	input		= {0,   1},
	output		= {0, 0.3},
}


FlightInstrumentsLights =
{
	arg_number	= 802,
	input		= {0, 1},
	output		= {0, 1},
	smooth 			  = true,
}

AuxiliaryInstrumentsLights =
{
	arg_number	= 803,
	input		= {0, 1},
	output		= {0, 1},
	smooth 			  = true,
}



AccelerometerAndCompassLight =
{
	arg_number	= 804,
	input		= {0, 1},
	output		= {0, 1},
	smooth 			  = true,
 }

LIGHT_SCHEME_BASIC     = 0
LIGHT_SCHEME_IMPROVED  = 1

 
light_scheme =     LIGHT_SCHEME_IMPROVED  
				-- LIGHT_SCHEME_BASIC

local attenuation_default 	= {0,1,3,2}
local cone_angles_1       	= math.rad(60)
local cone_angles_2     	= math.rad(90)
FloodLight = 
{
 	arg_number	= 806,
	input		= {0, 1},
	output		= {0, 1},
}

FloodLight_Thunderstorm = 
{
 	arg_number	= 807,
	input		= {0, 1},
	output		= {0, 1},
}

thunderstorm_limit = 0.5

ElecConsumerParamsFormationLight = {40, true, 1, 10, 115}
ElecConsumerParamsLandLight      = {200, true, 1, 10, 115}

need_to_be_closed = true -- close lua state after initialization 
-- arg for external shape
cockpit_illumination_external = 69

-- In hours (24 hrs format). 6.5 means - 6 hours 30 minutes.
-- If a mission is started within the 'night' period determined by these two variables
-- cockpit lighting will be on at mission start. Otherwise it will be off.
night_start_time = 19.0
night_end_time = 7.0

NightConditionBySunZenithAngle = true
SolarElevationAngle = 5.0	-- 5 degrees above horizon

-- Position lights flash pattern
--positionLightsOnTime  = 0.54
--positionLightsOffTime = 0.19
