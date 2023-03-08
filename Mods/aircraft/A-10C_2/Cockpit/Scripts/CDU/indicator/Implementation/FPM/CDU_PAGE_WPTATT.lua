dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameWPTATT",	2, 1, LFT, "WPTATT")

-- Waypoint number and name
AddText("WPT",			        2, 2, LFT, {{"AnnVisible", 0}}, "WPT:")
AddText("WPTATT_WPT_Number",    6, 2, LFT, {{"AnnVisible", 0}, {"WPTATT_WPTNumber", 1}})
AddText("WPTATT_WPT_Name",     11, 2, LFT, {{"AnnVisible", 0}, {"WPTATT_WPTName", 1}})

--Flight Plan number
AddStaticText("IN_FP",	       19, 3, LFT, "IN:")
AddText("WPTATT_FP_Number",    22, 3, LFT, {{"WPTATT_FPNumber", 0}})

--SCALE
AddStaticText("SCALE",		    1, 3, LFT, ROTARY .. "SCALE:")
AddText		 ("WPTATTScale",    2, 4, LFT, {{"WPTATTScale", 0}}, "ENROUTE")
AddText		 ("WPTATTScale1",    2, 4, LFT, {{"WPTATTScale", 1}}, "TERMINAL")
AddText		 ("WPTATTScale2",    2, 4, LFT, {{"WPTATTScale", 2}}, "APPROACH")
AddText		 ("WPTATTScale3",    2, 4, LFT, {{"WPTATTScale", 3}}, "HIACC")
AddText		 ("WPTATTScale4",    2, 4, LFT, {{"WPTATTScale", 4}}, "********")

--STEER
AddStaticText("STEER",		    1, 5, LFT, ROTARY .. "STEER:")
AddText		 ("WPTATTSteer",    2, 6, LFT, {{"WPTATTSteer", 0}}, "TO FROM")
AddText		 ("WPTATTSteer1",    2, 6, LFT, {{"WPTATTSteer", 1}}, "DIRECT")
AddText		 ("WPTATTSteer2",    2, 6, LFT, {{"WPTATTSteer", 2}}, "TO TO")
AddText		 ("WPTATTSteer4",    2, 6, LFT, {{"WPTATTSteer", 4}}, "*******")

--VNAV
AddStaticText("VNAV_MODE",	   24, 5, RGHT, "VNAV MODE:" .. ROTARY)
AddText		 ("WPTATTVNavMode",23, 6, RGHT, {{"WPTATTVNavMode", 0}}, "2D")
AddText		 ("WPTATTVNavMode1",23, 6, RGHT, {{"WPTATTVNavMode", 1}}, "3D")
AddText		 ("WPTATTVNavMode2",23, 6, RGHT, {{"WPTATTVNavMode", 2}}, "**")

AddText("VANGLE",  	           24, 7, RGHT,{{"WPTATTVNavMode", 1}} ,"VANGLE:"..ROTARY)
AddText("VANGLEMode",          23, 8, RGHT, {{"WPTATTVNavMode", 1}, {"WPTATTVangleMode", 0}}, "COMPUTED")
AddText("VANGLEMode1",          23, 8, RGHT, {{"WPTATTVNavMode", 1}, {"WPTATTVangleMode", 1}}, "ENTERED")
AddText("VANGLEValue",         23, 9, RGHT, {{"WPTATTVNavMode", 1}, {"WPTATTVangleValue"}})
AddText("VANGLEEntry",         24, 9, RGHT, {{"WPTATTVNavMode", 1}, {"WPTATTVangleMode", 1}}, DATA_ENTRY)


--Desired Time To Go (DTTG)
AddStaticText("WPTATT_DTTG_ST", 1, 7, LFT, DATA_ENTRY .. "DTTG:")
AddText		 ("WPTATT_DTTG",    7, 7, LFT, {{"WPTATT_DTTG", 0}}, " ********")
AddText		 ("WPTATT_DTTG1",  	7, 7, LFT, {{"WPTATT_DTTG", 1}})

--Desired Time On Target (DTOT)
AddStaticText("WPTATT_DTOT_ST", 1, 9, LFT, DATA_ENTRY .. "DTOT:")
AddText		 ("WPTATT_DTOT",    8, 9, LFT, {{"WPTATT_DTOT", 0}}, "********")
AddText		 ("WPTATT_DTOT1",    8, 9, LFT, {{"WPTATT_DTOT", 1}})