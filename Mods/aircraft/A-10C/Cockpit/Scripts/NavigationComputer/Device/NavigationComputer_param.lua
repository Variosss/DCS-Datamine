---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
----   DEBUG DEFINITIONS  -------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
is_debug = false
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
----   END OF DEBUG DEFINITIONS  --------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

package.path = package.path..";./Scripts/?.lua"

local S        = require("Serializer")

dofile (LockOn_Options.script_path.."NavigationComputer/Database/Database_Common.lua")

device_timer_dt		= 0.05

-- Coeffs for ADI steering bars in STRPT mode
kc    = 6   -- heading error
kcils = 6   -- heading error for ILS mode
kw    = 0   -- angular rate x
kz    = 3   -- course deviation
kzils = 9   -- course deviation for ILS mode
kb    = 0.6 -- bank

--Pitch steering bar
kh    = 60  -- glideslope deviation
khils = 50  -- glideslope deviation for ILS mode
ky    = 0   -- angular rate y
kp    = 1   -- pitch

default_db			= LockOn_Options.script_path.."NavigationComputer/Database/Default_DTS_CDU_DB.lua"

function get_file_name(loader)
	local campaign = LockOn_Options.mission.campaign
	local mission  = LockOn_Options.mission.title
	local					  name     = db_path
	if campaign ~= "" then    name     = name .. campaign .. "/" end
	if mission  ~= "" then	  name     = name .. mission .. CDU_DB_name_suffix end
	return 					  name
end

function GetLatitude(str)
	local sign

	local lat_sign, lat_deg, lat_min, lat_1000
	local lon_sign, lon_deg, lon_min, lon_1000
	for lat_sign, lat_deg, lat_min, lat_1000, lon_sign, lon_deg, lon_min, lon_1000 in string.gfind(str, "(%a+) (%d+) (%d+).(%d+)/(%a+)(%d+) (%d+).(%d+)") do
		if "N" == lat_sign then
			sign = 1
		else
			sign = -1
		end
		
		return sign * (lat_deg*60*1000 + lat_min*1000 + lat_1000) / 60000
	end
	
	return 0
end

function GetLongtitude(str)
	local sign

	local lat_sign, lat_deg, lat_min, lat_1000
	local lon_sign, lon_deg, lon_min, lon_1000
	for lat_sign, lat_deg, lat_min, lat_1000, lon_sign, lon_deg, lon_min, lon_1000 in string.gfind(str, "(%a+) (%d+) (%d+).(%d+)/(%a+)(%d+) (%d+).(%d+)") do
		if "W" == lon_sign then
			sign = -1
		else
			sign = 1
		end
		
		return sign * (lon_deg*60*1000 + lon_min*1000 + lon_1000) / 60000
	end
	
	return 0
end

--WP_database = {}

--FP_database = {}

-- Left empty to not create excessive errors with dynamic atmosphere.
-- Comment this line to load wind from editor (may be useful for testing).
Wind_database = {}

-- Example of use
--[[
Wind_database = {
Model = 1,
WindParam = {{Alt = 1000,  Dir = 51,  Speed = 97},
{Alt = 6000, Dir = 50,  Speed = 97},
{Alt = 26000, Dir = 215, Speed = 97}}}
]]

function ReadWaypointString(str)
	local temp
	local WptIndex
	
	--Считываем номер точки
	str, WptIndex	= GetNumberField(str)
	if nil == WptIndex then return end
	if 0 > WptIndex or 2050 < WptIndex then return end

	local table_field = {}

	--Считываем имя точки
	str, temp		= GetStringField(str)
	if nil == temp or "" == temp then return end
	table_field["Identifier"] 		= string.upper(temp)

	--Считываем координаты точки
	str, temp		= GetStringField(str)
	table_field["Latitude"] 		= GetLatitude(temp)
	table_field["Longitude"] 		= GetLongtitude(temp)
	
	--Считываем координаты MGRS точки
	str, temp		= GetStringField(str)
	
	--Считываем превышение точки
	str, temp		= GetNumberField(str)
	if 0 == temp then
		table_field["ElevationPresent"] 		= 0
		table_field["Elevation"] 				= 0
	else
		table_field["ElevationPresent"] 		= 1
		table_field["Elevation"] 				= temp
	end

	--Считываем DTOT
	str, temp		= GetStringField(str)
	local index	= string.find(temp, "00:00:00")
	if nil == index then
		table_field["DTOTPresent"] 		= 1
		local hour, minute, second		= GetTime(temp)
		table_field["DTOT"] 			= {}
		table_field["DTOT"]["H"]		= hour
		table_field["DTOT"]["M"]		= minute
		table_field["DTOT"]["S"]		= second
	else
		table_field["DTOTPresent"] 		= 0
	end
	
	--Считываем Datum
	str, temp		= GetStringField(str)
	local ELLIPSOID_STRINGS = {}
	ELLIPSOID_STRINGS[ELLIPSOID.ELL_WGS_84]		= "W84"
--[[
ELLIPSOID =
{
	ELL_AIRY				= 0,
	ELL_AUSTRALIAN_NATIONAL	= 1,
	ELL_BESSEL_1841			= 2,
	ELL_BESSEL_1841_NAMBIA	= 3, 
	ELL_CLARKE_1866			= 4,
	ELL_CLARKE_1880			= 5,
	ELL_EVEREST				= 6,
	ELL_FISCHER_1960		= 7,
	ELL_FISCHER_1968		= 8,
	ELL_GRS_1967			= 9,
	ELL_GRS_1980			= 10,
	ELL_HELMERT_1906		= 11,
	ELL_HOUGH				= 12,
	ELL_INTERNATIONAL		= 13,
	ELL_KRASSOVSKY			= 14,
	ELL_MODIFIED_AIRY		= 15,
	ELL_MODIFIED_EVEREST	= 16,
	ELL_MODIFIED_FISCHER	= 17,
	ELL_SOUTH_AMERICAN		= 18,
	ELL_WGS_60				= 19,
	ELL_WGS_66				= 20,
	ELL_WGS_72				= 21,
	ELL_WGS_84				= 22
} 
--]]
	GetValueFromString(table_field, "RefEllipsoid", temp, ELLIPSOID_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ

	--Считываем Str Mode
	str, temp		= GetStringField(str)
	local STEER_STRINGS = {}
	STEER_STRINGS[Waypoint_Steer_mode.WPT_SM_TO_FROM]		= "TO-FROM"
--[[
Waypoint_Steer_mode =
{
	WPT_SM_TO_FROM	= 0
}
--]]
	GetValueFromString(table_field, "Steer_mode", temp, STEER_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ

	--Считываем V Mode
	str, temp		= GetStringField(str)
	local VMODE_STRINGS = {}
	VMODE_STRINGS[Waypoint_VNAV_mode.WPT_VNAVM_2D]		= "2D"
	VMODE_STRINGS[Waypoint_VNAV_mode.WPT_VNAVM_3D]		= "3D"
	GetValueFromString(table_field, "VNAV_mode", temp, VMODE_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ

	--Считываем V Angle
	str, temp	= GetNumberField(str)
	table_field["Angle_3D"] 		= temp
	
	--Считываем Dev Mode
	str, temp		= GetStringField(str)
	local DEV_MODE_STRINGS = {}
	DEV_MODE_STRINGS[Waypoint_Scale.WPT_SCALE_ENROUTE]		= "En-Route"
	DEV_MODE_STRINGS[Waypoint_Scale.WPT_SCALE_TERMINAL]		= "Terminal"
	DEV_MODE_STRINGS[Waypoint_Scale.WPT_SCALE_APPROACH]		= "Approach"
	DEV_MODE_STRINGS[Waypoint_Scale.WPT_SCALE_HIACC]		= "Hi-Accuracy"
	GetValueFromString(table_field, "Scale", temp, DEV_MODE_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ

	--Считываем Description
	str, temp		= GetStringField(str)
	
	--Считываем Type
	str, temp		= GetStringField(str)
	local TYPE_STRINGS = {}
	TYPE_STRINGS[Waypoint_Types.WPT_A_CIV]		= "A-CIV"
	TYPE_STRINGS[Waypoint_Types.WPT_A_JNT]		= "A-JNT"
	TYPE_STRINGS[Waypoint_Types.WPT_A_MIL]		= "A-MIL"
	TYPE_STRINGS[Waypoint_Types.WPT_A_OTH]		= "A-OTH"
	TYPE_STRINGS[Waypoint_Types.WPT_LOCAL]		= "LOCAL"
	TYPE_STRINGS[Waypoint_Types.WPT_NDB]		= "NDB"
	TYPE_STRINGS[Waypoint_Types.WPT_TACAN]		= "TACAN"
	TYPE_STRINGS[Waypoint_Types.WPT_VOR]		= "VOR"
	TYPE_STRINGS[Waypoint_Types.WPT_VORDME]		= "VOR-DME"
	TYPE_STRINGS[Waypoint_Types.WPT_VORTAC]		= "VORTAC"
	TYPE_STRINGS[Waypoint_Types.WPT_WAY_B]		= "WAY-B"
	TYPE_STRINGS[Waypoint_Types.WPT_WAY_H]		= "WAY-H"
	TYPE_STRINGS[Waypoint_Types.WPT_WAY_L]		= "WAY-L"
	TYPE_STRINGS[Waypoint_Types.WPT_WAY_R]		= "WAY-R"
	TYPE_STRINGS[Waypoint_Types.WPT_WAY_T]		= "WAY-T"
	TYPE_STRINGS[Waypoint_Types.WPT_UNK]		= "UNK"
--[[
Waypoint_Types =
{
	WPT_AIMP	= 0,
	WPT_A_CIV	= 1,
	WPT_A_JNT	= 2,
	WPT_A_MIL	= 3,
	WPT_A_OTH	= 4,
	WPT_LOCAL	= 5,
	WPT_NDB		= 6,
	WPT_NDBDME	= 7,
	WPT_TACAN	= 8,
	WPT_VOR		= 9,
	WPT_VORDME	= 10,
	WPT_VORTAC	= 11,
	WPT_WAY_B	= 12,
	WPT_WAY_H	= 13,
	WPT_WAY_L	= 14,
	WPT_WAY_R	= 15,
	WPT_WAY_T	= 16,
	WPT_W_IAP	= 17,
	WPT_W_SID	= 18,
	WPT_W_STAR	= 19,
	WPT_UNK		= 20
}
--]]
	GetValueFromString(table_field, "Type", temp, TYPE_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ

	--Считываем Divert Field
	str, temp		= GetStringField(str)
	local DIVERT_STRINGS = {}
	DIVERT_STRINGS[0]		= "NO"
	DIVERT_STRINGS[1]		= "YES"
	GetValueFromString(table_field, "Divert", temp, DIVERT_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ

	
	table_field["UPDATE"]			= 1
	
	WP_database[WptIndex] = table_field
end

function ReadWaypoints(f)
	local str
	local i
	str = f:read()
	for i = 0, 2050 do
		ReadWaypointString(str)
		str = f:read()
	end

	--Считываем Anchor Point
	if nil ~= string.find(str, "Anchor Point:", 1, true) then
		local temp
		str, temp	= GetStringField(str)
		temp = string.sub(temp, 14, string.len(temp))
		local name
		str, name	= GetStringField(str)
		if "" ~= name then
			--Anchor Point в наличии
			AnchorPoint = tonumber(temp)
		end
	end
end

function ReadFlightPlanString(str, FlightPlan)
	--Считываем Flight Plan Name
	str, temp		= GetStringField(str)
	if "" ~= temp then 
		FlightPlan["Identifier"]	= string.upper(TrimStringLeft(temp))
	end
	
	--Считываем Index
	local Index
	str, Index	= GetNumberField(str)
	--Считываем Number
	str, temp	= GetNumberField(str)
	if nil ~= Index and nil ~= temp then
		FlightPlan["WP_Number"][Index] 		= temp
	end
end

function ReadFlightPlans(f)
	local str
	local i
	local counter = 1
	str = f:read()
	while "" ~= str do
		local FlightPlan = {}
		FlightPlan["WP_Number"]		= {}

		for i = 1, 40 do
			ReadFlightPlanString(str, FlightPlan)
			str = f:read()
		end
		if nil ~= FlightPlan["Identifier"] then
			FP_database[counter] = FlightPlan
		end
		counter = counter+1
	end
end

function ReadWindString(str)
	local Index
	
	--Считываем номер точки
	str, Index	= GetNumberField(str)
	if nil == Index then return end
	if 1 > Index or 7 < Index then return end

	local table_field = {}

	local Altitude, Direction, Speed, Temperature
	for Altitude, Direction, Speed, Temperature in string.gfind(str, "(%d+), (%d+)/(%d+), (%d+)") do
		table_field["Alt"]			= Altitude
		table_field["Dir"]			= Direction
		table_field["Speed"]		= Speed
		table_field["Temperature"]	= Temperature

		Wind_database.WindParam[Index-1] = table_field
	end
	
end

function ReadWindParams(f, str)
	local temp
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)
	local WIND_MODEL_STRINGS = {}
	WIND_MODEL_STRINGS[0]		= " None"
--[[
enum CDU_WIND_MODE
{
	CDU_WM_NONE,
	CDU_WM_WIND,
	CDU_WM_TEMP,
	CDU_WM_BOTH
};
--]]
	GetValueFromString(Wind_database, "Model", str, WIND_MODEL_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ

	Wind_database.WindParam = {}

	str=f:read()
	str=f:read()
	for i = 1, 7 do
		ReadWindString(str)
		str = f:read()
	end
end

function ReadActiveFlightPlan(f)
	local str
	str=f:read()

	--Считываем имя плана
	str, temp	= GetStringField(str)
	if nil == temp or "" == temp then return end
	
	temp = string.upper(TrimStringLeft(temp))

	for key, value in pairs(FP_database) do
		if temp == value["Identifier"] then
			ActiveFlightPlan = key
			return
		end
	end
end

function ReadLocalTime(str)
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)

	temp = TrimStringLeft(temp)
	local sign, hour, minute
	for hour, minute in string.gfind(temp, "(%d+):(%d+)") do
		LocalTime = hour*3600+minute*60
	end
end

function ReadDTSAS(str)
	str, temp	= GetStringField(str)
	str, temp	= GetNumberField(str)
	
	DTSASOWCAvoidance = temp
end

function Read_CDU_DB(f)
	local str
	str=f:read()
	while nil ~= str do
		if nil ~= string.find(str, "Number ,Name", 1, true) then
			ReadWaypoints(f)
		end
		if nil ~= string.find(str, "Flight Plan Name ,Index", 1, true) then
			ReadFlightPlans(f)
		end
		if nil ~= string.find(str, "Wind Table Data", 1, true) then
			ReadWindParams(f, str)
		end
		if nil ~= string.find(str, "Active Flight Plan", 1, true) then
			ReadActiveFlightPlan(f)
		end
		if nil ~= string.find(str, "Local Time Adjust:", 1, true) then
			ReadLocalTime(str)
		end
		if nil ~= string.find(str, "DTSAS OWC Avoidance:", 1, true) then
			ReadDTSAS(str)
		end
		str=f:read()
	end

	LoadAllAirfields	= 0
end

-- SETTINGS_PATH is left for compatibility with old missions
SETTINGS_PATH  = "CDU/SETTINGS.lua"
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

use_mission_route_as_default_flight_plan = true