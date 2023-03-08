local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices = {}
-- moved forward for correct initialization of another devices
-- do not changed folowing sequence for sim
devices["ELEC_INTERFACE"]			= counter() -- 1
devices["FUELSYS_INTERFACE"]		= counter() -- 2
devices["ENGINE_INTERFACE"]			= counter() -- 3
devices["HYDRO_SYS_INTERFACE"]		= counter() -- 4
devices["ADI_PILOT"]				= counter() -- 5
devices["ADI_OPERATOR"]				= counter() -- 6
devices["NAVLIGHT_SYSTEM"]			= counter() -- 7
devices["SOUND_SYSTEM"] 			= counter() -- 8
devices["WEAPON_SYS"]				= counter() -- 9
devices["GMCS"]						= counter() -- 10
devices["VARIOMETER_PILOT"]         = counter() -- 11
devices["CPT_MECH"]					= counter() -- 12
devices["RADAR_ALTIMETER"]			= counter() -- 13
devices["MISC_SYSTEMS_INTERFACE"]	= counter() -- 14
devices["SYS_CONTROLLER"]			= counter() -- 15
devices["HELMET_DEVICE"]			= counter() -- 16
devices["IFF"]						= counter() -- 17
devices["AAU7"]      				= counter() -- 18 -- right barometric altimeter
devices["AAU32"]      				= counter() -- 19 -- left barometric altimeter
devices["VHF_ARC_134"]  			= counter() -- 20
devices["INTERCOM"] 				= counter() -- 21
devices["UHF_ARC_51"] 				= counter() -- 22
devices["VHF_ARC_131"] 				= counter() -- 23
devices["ILS"]			            = counter() -- 24
devices["ARN_82"] 					= counter() -- 25
devices["MARKER_BEACON"] 			= counter() -- 26
devices["ADF_ARN_83"]				= counter() -- 27
devices["REMOTE_COMPASS"]           = counter()	-- 28
devices["COURSE_IND"]	            = counter() -- 29
devices["CLOCK"]					= counter() -- 30
devices["FM_PROXY"]					= counter() -- 31
devices["FLEX_SIGHT"]				= counter() -- 32
devices["TURN_IND"]					= counter() -- 33
devices["NAVIGATION_RELAY"]			= counter() -- 34
devices["MD_1_GYRO"]				= counter() -- 35
devices["ROOF_AIRSPEED"]			= counter() -- 36
devices["NOSE_AIRSPEED"]			= counter() -- 37
devices["COPILOT_RMI"]				= counter() -- 38
devices["STANDBY_COMPASS"] 			= counter() -- 39  	-- compass
devices["VARIOMETER_COPILOT"]       = counter() -- 40	
devices["CONTROL_SYSTEM"]			= counter()	-- 41

devices["MACROS"]          			= counter() -- 42 	-- start stop macros
devices["ARCADE"]					= counter() -- 43
devices["PADLOCK"]					= counter() -- 44
devices["KNEEBOARD"] 				= counter()--45
devices["HEAD_WRAPPER"]				= counter()--46

devices["HEATING_SYSTEM"]			= counter()	-- 47

devices["CARGO_CAM"] 	            = counter()	-- 48
devices["PILOT_SIGHT"]				= counter() -- 49
devices["XM_130"]					= counter() -- 50
devices["EXTERNAL_CARGO_VIEW"]		= counter() -- 51
devices["EXT_CARGO_EQUIPMENT"]		= counter() -- 52
devices["NETWORK_SYNCH_CONTROLLER"]	= counter() -- 53
devices["EXTERNAL_CARGO_SPEECH"]	= counter() -- 54
devices["CREWE"]                    = counter()
---
--can be changed
