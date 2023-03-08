----   DEBUG DEFINITIONS  -------------------------------------------
is_debug = false
----   END OF DEBUG DEFINITIONS  --------------------------------

Lookup_Tables_Path = LockOn_Options.script_path .. "SADL/Lookup_Tables/"
dofile(Lookup_Tables_Path .. "Air_Specific_Types.lua")
dofile(Lookup_Tables_Path .. "Land_Specific_Types.lua")
dofile(Lookup_Tables_Path .. "Surf_Specific_Types.lua")
dofile(Lookup_Tables_Path .. "Stores.lua")

package.path = package.path..";./Scripts/?.lua"

local gettext	= require("i_18n")
local S			= require("Serializer")

_ = gettext.translate

default_db			= LockOn_Options.script_path.."SADL/Database/DataBase.lua"

function get_file_name(loader)
	local campaign = LockOn_Options.mission.campaign
	local mission  = LockOn_Options.mission.title
	local					  name     = db_path
	if campaign ~= "" then    name     = name .. campaign .. "/" end
	if mission  ~= "" then	  name     = name .. mission .. SADL_DB_name_suffix end
	return 					  name
end


device_timer_dt		= 0.05


function ReadOwnNumber(str)
	str = string.sub(str, string.find(str, "Ownship Flight Number:", 1, true)+23, string.len(str))
	SADL_data["OwnNumber"]	= tonumber(str)
end

function ReadDataLinkOptions(str)
	local temp
	local index
	
	for i = 1, 8 do
		str, temp	= GetStringField(str)
	end

	str, index	= GetNumberField(str)
	if nil == index then
		return
	end
		
	SADL_data["Members"][index] = {}
	print(temp)
	
	str, temp	= GetStringField(str)
	temp = TrimStringLeft(temp)
	if "" ~= temp then
		SADL_data["Members"][index]["FlightLead"]	= true
	else
		SADL_data["Members"][index]["FlightLead"]	= false
	end

	str, temp	= GetStringField(str)
	SADL_data["Members"][index]["TrackNumber"]	= TrimStringLeft(temp)
	
	str, temp	= GetStringField(str)
	SADL_data["Members"][index]["CallSign"]		= TrimStringLeft(temp)
	
	SADL_data["Members"][index]["URN"]			= tonumber(str)
end

function ReadDonors(f)
	SADL_data["Donors"] = {}
	
	local temp
	local j = 1

	for k = 1, 2 do
		str=f:read()
		for i = 1, 8 do
			str, temp	= GetStringField(str)
		end
		for i = 1, 5 do
			str, temp	= GetStringField(str)
			str, temp	= GetStringField(str)
			SADL_data["Donors"][j]	= TrimStringLeft(temp)
			j=j+1
		end
		str, temp	= GetStringField(str)
		SADL_data["Donors"][j]	= TrimStringLeft(str)
		j=j+1
	end
end

function ReadPower(str)
	local temp
	for i = 1, 13 do
		str, temp	= GetStringField(str)
	end
	
	str, temp		= GetStringField(str)
	local POWER_STRINGS = {}
	POWER_STRINGS[0]		= "Silent"
	POWER_STRINGS[1]		= "0.4 Watts"
	POWER_STRINGS[2]		= "3 Watts"
	POWER_STRINGS[3]		= "20 Watts"
	POWER_STRINGS[4]		= "100 Watts"
--[[
	enum enum_PWR_OUT
	{
		PWR_OUT_SLNT,
		PWR_OUT_0_4,
		PWR_OUT_3,
		PWR_OUT_20,
		PWR_OUT_100,
	};
--]]
	GetValueFromString(SADL_data, "Power", TrimStringLeft(temp), POWER_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ

	str, temp		= GetStringField(str)
	local NTR_STRINGS = {}
	NTR_STRINGS[0]		= "Air"
	NTR_STRINGS[1]		= "Gateway"
	NTR_STRINGS[2]		= "Ground"
--[[
	enum enum_NTR
	{
		NTR_AIR = SADL_NET_AIR,
		NTR_GAT = SADL_NET_GAT,
		NTR_GND = SADL_NET_GND
	};
--]]
	GetValueFromString(SADL_data, "NTR", TrimStringLeft(TrimStringRight(str)), NTR_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ
end

function Read_from_CDU_DB(f)
	SADL_data = {}
	SADL_data["Members"] = {}
	
	local str
	str=f:read()
	while nil ~= str do
		if nil ~= string.find(str, "Ownship Flight Number:", 1, true) then
			ReadOwnNumber(str)
			str=f:read()
			for i = 1, 4 do
				str=f:read()
				ReadDataLinkOptions(str)
			end
		end
		if nil ~= string.find(str, "Donor Track Numbers", 1, true) then
			ReadDonors(f)
		end
		if nil ~= string.find(str, "Power:", 1, true) then
			ReadPower(str)
		end
		str=f:read()
	end
end

-- SETTINGS_PATH is left for compatibility with old missions
SETTINGS_PATH  = "SADL/SETTINGS.lua"
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

SADL_FAILURE_TOTAL	= 0
Damage = {	{Failure = SADL_FAILURE_TOTAL, Failure_name = "SADL_FAILURE_TOTAL", Failure_editor_name = _("SADL total failure"),  Element = 5, Integrity_Treshold = 0.75, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}
