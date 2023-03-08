dofile(LockOn_Options.common_script_path.."tools.lua")
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

function get_file_name(loader)
	local campaign = LockOn_Options.mission.campaign
	local mission  = LockOn_Options.mission.title
	local					  name     = db_path
	if campaign ~= "" then    name     = name .. campaign .. "/" end
	if mission  ~= "" then	  name     = name .. mission .. CDU_DB_name_suffix end
	return 					  name
end

-- ALL - All options set to ON
-- LOFF - All options set to ON except LINES OFF
-- ACT - All options set to ON except passive tagging turned OFF (Active only)
-- NONE - All options turned OFF 

HOOK_INFO = {}
HOOK_INFO["OFF"] = 0
HOOK_INFO["ON"]  = 1
HOOK_INFO["ACT"] = 2

SHOW_SPI = {}
SHOW_SPI["OWN"] = 0
SHOW_SPI["ALL"] = 1

-- Always present in the system
default_profile = 
{
	name 					= "DFLT",
	bullseye 				= true,
	range_rings 			= true,
	flight_plan_lines 		= true,
	waypoint_labels 		= true,
	tag_info 				= HOOK_INFO.ON,
	ownship_waypoints 		= true,
	spi_display 			= SHOW_SPI.ALL,
	frequency_mapping		= 8,
	guardChannel1			= 3,
	guardChannel2			= 7,
	gateway_key				= "1",
    air_key					= "1",
    ground_key				= "A",
	LCN1					= "00",
	LCN2					= "00",
}

profiles	= {}
for i = 1, 4 do
	profiles[i] = {}
	copyTable(profiles[i], default_profile)
end

profiles[1].name              = "ALL"

profiles[2].name              = "LOFF"
profiles[2].flight_plan_lines = false

profiles[3].name              = "ACT"
profiles[3].tag_info          = HOOK_INFO.ACT

profiles[4].name              = "NONE"
profiles[4].bullseye          = false
profiles[4].range_rings       = false
profiles[4].flight_plan_lines = false
profiles[4].waypoint_labels   = false
profiles[4].tag_info          = HOOK_INFO.OFF
profiles[4].ownship_waypoints = false
profiles[4].reference_points  = false
profiles[4].spi_display       = SHOW_SPI.OWN
profiles[4].air_envir         = false
profiles[4].air_ppli_non_dnr  = false
profiles[4].air_trk_friend    = false
profiles[4].air_neutral       = false
profiles[4].air_other         = false
profiles[4].gnd_envir         = false
profiles[4].gnd_ppli          = false
profiles[4].gnd_trk_friend    = false
profiles[4].gnd_neutral       = false
profiles[4].gnd_other         = false

--------------------------------------------------
-- OSBs to profiles map
--
-- Enumeration was changed to reflect RL logic:
-- up -> down, left -> right

TAD_PPP_profiles = {}
for i = 1, 20 do
	TAD_PPP_profiles[i] = -1
end

-- Currently in use - 'magic OSBs'
TAD_PPP_profiles[2]  = 0
TAD_PPP_profiles[3]  = 1
TAD_PPP_profiles[4]  = 2
TAD_PPP_profiles[5]  = 3
    
-- Stored, may be selected for use at TAD Display Program Page
TAD_PPP_profiles[6]  = 5
TAD_PPP_profiles[7]  = 6
TAD_PPP_profiles[8]  = 7
TAD_PPP_profiles[9]  = 8
TAD_PPP_profiles[16] = 4
TAD_PPP_profiles[17] = 3
TAD_PPP_profiles[18] = 2
TAD_PPP_profiles[19] = 1
TAD_PPP_profiles[20] = 0

function ReadBoolOnOff(str, tbl, field)
	if nil == string.find(str, "Off", 1, true) then
		tbl[field] = true
	else
		tbl[field] = false
	end
end

function ReadProfileData(str)
	local temp
	local index
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)

	if "" == TrimStringLeft(TrimStringRight(str)) then
		return nil
	end
	
	str, index	= GetNumberField(str)

	local ret = {}
	str, temp	= GetStringField(str)
	ret["name"] = TrimStringLeft(temp)
	
	str, temp	= GetStringField(str)
	if nil ~= string.find(temp, "OSB 2", 1, true) then
		TAD_PPP_profiles[2] = index-1
	elseif nil ~= string.find(temp, "OSB 3", 1, true) then
		TAD_PPP_profiles[3] = index-1
	elseif nil ~= string.find(temp, "OSB 4", 1, true) then
		TAD_PPP_profiles[4] = index-1
	elseif nil ~= string.find(temp, "OSB 5", 1, true) then
		TAD_PPP_profiles[5] = index-1
	end

	str, temp	= GetStringField(str)
	ReadBoolOnOff(temp, ret, "bullseye")
	
	str, temp	= GetStringField(str)
	ReadBoolOnOff(temp, ret, "range_rings")
	
	str, temp	= GetStringField(str)
	ReadBoolOnOff(temp, ret, "flight_plan_lines")
	
	str, temp	= GetStringField(str)
	ReadBoolOnOff(temp, ret, "waypoint_labels")
	
	str, temp	= GetStringField(str)
	ReadBoolOnOff(temp, ret, "ownship_waypoints")
	
	str, temp		= GetStringField(str)
	local HOOK_STRINGS = {}
	HOOK_STRINGS[0]		= "OFF"
	HOOK_STRINGS[1]		= "ON"
	HOOK_STRINGS[2]		= "ACT"
	GetValueFromString(ret, "tag_info", TrimStringLeft(temp), HOOK_STRINGS)		--TO DO: ��������� ������� �������� ��������

	str, temp		= GetStringField(str)
	local SPI_STRINGS = {}
	SPI_STRINGS[0]		= "OWN"
	SPI_STRINGS[1]		= "ALL"
	GetValueFromString(ret, "spi_display", TrimStringLeft(temp), SPI_STRINGS)		--TO DO: ��������� ������� �������� ��������

	str, temp		= GetStringField(str)
	ret["air_key"]	= TrimStringLeft(temp)

	str, temp		= GetStringField(str)
	ret["ground_key"]	= string.upper(TrimStringLeft(temp))

	str, temp		= GetStringField(str)
	ret["gateway_key"]	= TrimStringLeft(temp)

	str, temp		= GetStringField(str)
	ret["LCN1"]		= TrimStringLeft(temp)

	str, temp		= GetStringField(str)
	ret["LCN2"]		= TrimStringLeft(temp)

	str, temp		= GetStringField(str)
	temp = TrimStringLeft(temp)
	ret["guardChannel1"]	= string.byte(temp, 1)-48
	ret["guardChannel2"]	= string.byte(temp, 2)-48

	ret["frequency_mapping"]		= tonumber(str)

	return index, ret
end

function ReadProfiles(f)
	local str
	str=f:read()
	while nil ~= str do
		if nil ~= string.find(str, "TAD Profiles", 1, true) then
			profiles = nil
			profiles = {}

			TAD_PPP_profiles[2] = -1
			TAD_PPP_profiles[3] = -1
			TAD_PPP_profiles[4] = -1
			TAD_PPP_profiles[5] = -1

			str=f:read()
			str=f:read()
			local res
			local index = 0
			
			while nil ~= index do
				index, res = ReadProfileData(str)
				if nil ~= index then
					profiles[index] = res
				else
					return
				end
				str=f:read()
			end

			return
		end
		str=f:read()
	end
end

