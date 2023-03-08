package.path = package.path..";./Scripts/?.lua"

local S        = require("Serializer")
local gettext = require("i_18n")

_ = gettext.translate

device_timer_dt		= 0.2

Funnel_min_distance	= 250
Funnel_max_distance	= 1500

MRGS_balistic_time	= 1.0
MRGS_line_distance	= 23.0
MRGS_k_time			= 0.14
MRGS_k_angle_g		= 2.0
MRGS_k_length_g		= 1.0
MRGS_k_length		= 0.1

FEDS_delta_time		= 0.2

Bomb_lead_time		= 4.0
Rocket_lead_time	= 4.0

PAC_PID_pitch       = {3,3,1}
PAC_PID_heading     = {-1,-0,-0}

Alt_GND_SLOPE_check_time = 1.0	 -- sec

DefaultAirThreats = {}
DefaultAirThreats["MAN-FXD"] = {Name = "MAN-FXD", Wingspan = 0, Length = 10, TargetSpeed = 50, Selected = true}
DefaultAirThreats["MAN-RTY"] = {Name = "MAN-RTY", Wingspan = 0, Length = 10, TargetSpeed = 50, Selected = true}
DefaultAirThreats["Array"] = {}
DefaultAirThreats["Array"][0] =
	{Index = 1, Name = "A-10", Wingspan = 57, Length = 54, TargetSpeed = 310, Selected = true}
DefaultAirThreats["Array"][1] =
	{Index = 2, Name = "F-15", Wingspan = 43, Length = 64, TargetSpeed = 370, Selected = true}
DefaultAirThreats["Array"][2] =
	{Index = 3, Name = "F-16", Wingspan = 33, Length = 47, TargetSpeed = 400, Selected = false}
DefaultAirThreats["Array"][3] =
	{Index = 4, Name = "F-18", Wingspan = 37, Length = 56, TargetSpeed = 320, Selected = false}
DefaultAirThreats["Array"][4] =
	{Index = 5, Name = "MIG-29", Wingspan = 37, Length = 57, TargetSpeed = 320, Selected = false}
DefaultAirThreats["Array"][5] =
	{Index = 6, Name = "SU-27", Wingspan = 48, Length = 72, TargetSpeed = 330, Selected = false}
DefaultAirThreats["Array"][6] =
	{Index = 7, Name = "SU-25", Wingspan = 46, Length = 44, TargetSpeed = 390, Selected = true}
DefaultAirThreats["Array"][7] =
	{Index = 8, Name = "AH-64", Wingspan = 49, Length = 49, TargetSpeed = 150, Selected = true}
DefaultAirThreats["Array"][8] =
	{Index = 9, Name = "UH-60", Wingspan = 53, Length = 49, TargetSpeed = 150, Selected = false}
DefaultAirThreats["Array"][9] =
	{Index = 10, Name = "MI-8 HIP", Wingspan = 70, Length = 60, TargetSpeed = 140, Selected = false}

---------------------------------------------------------------------------------
----   DEBUG DEFINITIONS  -------------------------------------------
---------------------------------------------------------------------------------
is_debug = false
---------------------------------------------------------------------------------
----   END OF DEBUG DEFINITIONS  --------------------------------
---------------------------------------------------------------------------------

dofile (LockOn_Options.script_path.."IFFCC/IFFCC_radius_table.lua")
dofile (LockOn_Options.script_path.."IFFCC/IFFCC_BIT_modes.lua")

default_db			= LockOn_Options.script_path.."IFFCC/Database/DataBase.lua"

function get_file_name(loader)
	local campaign = LockOn_Options.mission.campaign
	local mission  = LockOn_Options.mission.title
	local					  name     = db_path
	if campaign ~= "" then    name     = name .. campaign .. "/" end
	if mission  ~= "" then	  name     = name .. mission .. IFFCC_DB_name_suffix end
	return 					  name
end

IFFCC_data = {}

function ReadAGL_FloorAlt(str)
	str, temp	= GetStringField(str)
	str, temp	= GetNumberField(str)
	IFFCC_data["AGL_FloorAlt"] = tonumber(temp)
end

function ReadMSL_FloorAlt(str)
	str, temp	= GetStringField(str)
	IFFCC_data["MSL_FloorAlt"] = tonumber(str)
end

function ReadMSL_CeilingAlt(str)
	str, temp	= GetStringField(str)
	str, temp	= GetNumberField(str)
	IFFCC_data["MSL_CeilingAlt"] = tonumber(temp)
	
	str, temp	= GetStringField(str)
	if nil ~= string.find(str, "NO", 1, true) then
		IFFCC_data["CCIPGunCrossOccult"] = false
	else
		IFFCC_data["CCIPGunCrossOccult"] = true
	end
end

function ReadCCIPConsentMode(str)
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)
	local CONSENT_MODE_STRINGS = {}
	CONSENT_MODE_STRINGS[0]		= "OFF"
	CONSENT_MODE_STRINGS[1]		= "3/9"
	CONSENT_MODE_STRINGS[2]		= "5 MIL"

	-- enum CCIP_CONSENT_OPTIONS
	--   CON_OPT_OFF
	--   CON_OPT_3_9
	--   CON_OPT_5_mil

	GetValueFromString(IFFCC_data, "CCIPConsentMode", TrimStringLeft(TrimStringRight(str)), CONSENT_MODE_STRINGS) --TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ
end

function ReadHUDOptions(f)
	local str
	str=f:read()
	local temp
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)
	local SPEED_OPTIONS_STRINGS = {}
	SPEED_OPTIONS_STRINGS[0]		= "Indicated"
	SPEED_OPTIONS_STRINGS[1]		= "True"
	SPEED_OPTIONS_STRINGS[2]		= "Ground"

	-- AIRSPEED_DISPLAY_OPTIONS
	--   SPEED_OPT_IAS,
	--   SPEED_OPT_TAS,
	--   SPEED_OPT_GS,
	--   SPEED_OPT_MACH_IAS

	GetValueFromString(IFFCC_data, "SpeedDisplayOptions", TrimStringLeft(TrimStringRight(temp)), SPEED_OPTIONS_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)
	if nil ~= string.find(temp, "Numerics", 1, true) then
		IFFCC_data["Tapes"] = false
	else
		IFFCC_data["Tapes"] = true
	end
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)
	if nil ~= string.find(temp, "Standard", 1, true) then
		IFFCC_data["Metric"] = false
	else
		IFFCC_data["Metric"] = true
	end
end

function ReadThreatString(str)
	local ret = {}
	
	str, temp	= GetNumberField(str)
	if nil ~= temp then
		ret["Index"] = tonumber(temp)
	end
	
	str, temp	= GetStringField(str)
	if "" == temp  or nil == temp then
		return ret
	end
	ret["Name"] = TrimStringLeft(TrimStringRight(temp))
	
	str, temp	= GetNumberField(str)
	if nil ~= temp then
		ret["Wingspan"] = tonumber(temp)
	end
	
	str, temp	= GetNumberField(str)
	if nil ~= temp then
		ret["Length"] = tonumber(temp)
	end
	
	str, temp	= GetNumberField(str)
	if nil ~= temp then
		ret["TargetSpeed"] = tonumber(temp)
	end
	
	return ret
end

function ReadAirThreats(f)
	local str
	str=f:read()
	str=f:read()
	IFFCC_data["AirThreats"]			= {}
	IFFCC_data["AirThreats"]["Array"]	= {}
	for i = 0, 11 do
		local res = ReadThreatString(str)
		if nil ~= res["Name"] then
			if "MAN-FXD" == res["Name"] then
				IFFCC_data["AirThreats"]["MAN-FXD"] = res
			elseif "MAN-RTY" == res["Name"] then
				IFFCC_data["AirThreats"]["MAN-RTY"] = res
			else
				print(tostring(res["Index"]-1))
				IFFCC_data["AirThreats"]["Array"][tostring(res["Index"]-1)] = res
			end
		end
		str=f:read()
	end
end

function Read_from_CDU_DB(f)
	local str
	str=f:read()
	while nil ~= str do
		if nil ~= string.find(str, "AGL Floor Alt Alert:", 1, true) then
			ReadAGL_FloorAlt(str)
		end
		if nil ~= string.find(str, "MSL Floor Alt Alert:", 1, true) then
			ReadMSL_FloorAlt(str)
		end
		if nil ~= string.find(str, "MSL Ceiling Alt Alert:", 1, true) then
			ReadMSL_CeilingAlt(str)
		end
		if nil ~= string.find(str, "CCIP Consent Mode", 1, true) then
			ReadCCIPConsentMode(str)
		end
		if nil ~= string.find(str, "HUD Options", 1, true) then
			ReadHUDOptions(f)
		end
		if nil ~= string.find(str, "Air to Air Threats", 1, true) then
			ReadAirThreats(f)
		end
		str=f:read()
	end
end

function ReadAmmoType(str)
	str, temp	= GetStringField(str)
	local AMMO_TYPE_STRINGS = {}
	AMMO_TYPE_STRINGS[0]		= "CM"
	AMMO_TYPE_STRINGS[1]		= "HEI"
	AMMO_TYPE_STRINGS[2]		= "TP"
	GetValueFromString(IFFCC_data, "AmmoType", TrimStringLeft(TrimStringRight(str)), AMMO_TYPE_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ
end

function ReadAmmoManufacturer(str)
	str, temp	= GetStringField(str)
	local AMMO_MANUFACTURER_STRINGS = {}
	AMMO_MANUFACTURER_STRINGS[0]		= "AVERAGE"
	AMMO_MANUFACTURER_STRINGS[1]		= "OLIN"
	AMMO_MANUFACTURER_STRINGS[2]		= "ALLIANT"

	-- GunMFGTypes
	--   AmmoMFG_AVE,
	--   AmmoMFG_OLIN,
	--   AmmoMFG_ALLT

	GetValueFromString(IFFCC_data, "AmmoManufacturer", TrimStringLeft(TrimStringRight(str)), AMMO_MANUFACTURER_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ
end

function ReadPAC1Mode(str)
	str, temp	= GetStringField(str)
	if nil ~= string.find(str, "DISABLED", 1, true) then
		IFFCC_data["PAC1Mode"] = false
	else
		IFFCC_data["PAC1Mode"] = true
	end
end

function ReadGUNMinAlt(str)
	str, temp	= GetStringField(str)
	IFFCC_data["GUNMinAlt"] = tonumber(str)
end

function Read_from_DSMS_Actual(f)
	local str
	str=f:read()
	while nil ~= str do
		if nil ~= string.find(str, "Ammo Type", 1, true) then
			ReadAmmoType(str)
		end
		if nil ~= string.find(str, "Ammo Manufacturer", 1, true) then
			ReadAmmoManufacturer(str)
		end
		if nil ~= string.find(str, "PAC-1 Position Mode", 1, true) then
			ReadPAC1Mode(str)
		end
		if nil ~= string.find(str, " Min Alt (ft)", 1, true) then
			ReadGUNMinAlt(str)
		end
		str=f:read()
	end
end

-- SETTINGS_PATH is left for compatibility with old missions
SETTINGS_PATH  = "IFFCC/SETTINGS.lua"
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

--RADAR_ALTIMETR_LEFT_ANT_FAILURE		= 0
--RADAR_ALTIMETR_RIGHT_ANT_FAILURE	= 1
--Damage = {	{Failure = RADAR_ALTIMETR_LEFT_ANT_FAILURE, Failure_name = "RadarAltimetr",  Element = 39, Integrity_Treshold = 0.3, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*200},
--			{Failure = RADAR_ALTIMETR_RIGHT_ANT_FAILURE, Failure_name = "RadarAltimetr",  Element = 40, Integrity_Treshold = 0.3}}

--------------------------------------------------------------
-- BIT config
preflight_bit_test_states={{A10C_PREFLIGHT_TEST_START,3.125},{A10C_PREFLIGHT_TEST_B1,5.209},{A10C_PREFLIGHT_TEST_C1_1,6.5},
						   {A10C_PREFLIGHT_TEST_C1_2,1.375},{A10C_PREFLIGHT_TEST_C1_1,4.875},{A10C_PREFLIGHT_TEST_40,4.791},{A10C_PREFLIGHT_TEST_50,4.792},
						   {A10C_PREFLIGHT_TEST_80,1.375},
						   {A10C_GCAS_TEST_4,1.792},{A10C_GCAS_TEST_P_ON,1.416},{A10C_GCAS_TEST_P_LINE,0.375},{A10C_GCAS_TEST_P_ON,0.125},{A10C_GCAS_TEST_5_1,1.0},
						   {A10C_GCAS_TEST_CROSS,1.5,"GCAS_PullUpMessage"},{A10C_GCAS_TEST_CROSS,1.5,"GCAS_AltitudeMessage"},{A10C_GCAS_TEST_5_2,2.084},{A10C_GCAS_TEST_5_3,1.916},
						   {A10C_BIT_TESTS_COMPLETE,2}}
						   
gcas_bit_test_states ={ {A10C_GCAS_TEST_4,1.792},{A10C_GCAS_TEST_P_ON,1.416},{A10C_GCAS_TEST_P_LINE,0.375},{A10C_GCAS_TEST_P_ON,0.125},{A10C_GCAS_TEST_5_1,1.0},
						   {A10C_GCAS_TEST_CROSS,1.5,"GCAS_PullUpMessage"},{A10C_GCAS_TEST_CROSS,1.5,"GCAS_AltitudeMessage"},{A10C_GCAS_TEST_5_2,2.084},{A10C_GCAS_TEST_5_3,1.916},
						   {A10C_BIT_TESTS_COMPLETE,2}}		

vmu_bit_test_states ={ {A10C_VMU_TEST_START,2.0},
{A10C_VMU_TEST_RUN,1.5,"VMU_Message_Play",VMU_TEST_PULL_UP},
{A10C_VMU_TEST_RUN,1.5,"VMU_Message_Play",VMU_TEST_ALTITUDE},
{A10C_VMU_TEST_RUN,1.5,"VMU_Message_Play",VMU_TEST_OBSTACLE},
{A10C_VMU_TEST_RUN,1.5,"VMU_Message_Play",VMU_TEST_SPEEDBRAKE},
{A10C_VMU_TEST_RUN,1.5,"VMU_Message_Play",VMU_TEST_WARNING_AUTOPILOT},
{A10C_VMU_TEST_RUN,1.5,"VMU_Message_Play",VMU_TEST_CEILING},
{A10C_VMU_TEST_RUN,1.5,"VMU_Message_Play",VMU_TEST_IFF},
{A10C_VMU_TEST_RUN,1.5,"VMU_Message_Play",VMU_TEST_AUTOPILOT_ENGAGE},
{A10C_BIT_TESTS_COMPLETE,2.0}}		


IFFCC_FAILURE_TOTAL	= 0
IFFCC_FAILURE_GUN	= 1

Damage = {	{Failure = IFFCC_FAILURE_TOTAL, Failure_name = "IFFCC_FAILURE_TOTAL", Failure_editor_name = _("IFFCC total failure"),  Element = 9, Integrity_Treshold = 0.75, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = IFFCC_FAILURE_GUN, Failure_name = "IFFCC_FAILURE_GUN", Failure_editor_name = _("Gun failure"),  Element = 7, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*200}}
