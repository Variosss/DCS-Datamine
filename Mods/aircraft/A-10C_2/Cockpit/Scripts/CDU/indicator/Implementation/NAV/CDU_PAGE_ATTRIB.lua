dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameATTRIB",  2, 1, LFT, "ATTRIB")

AddStaticText("DEF_ATT", 2, 3, LFT, "DEFAULT ATTRIBUTES")

--SCALE
AddStaticText("SCALE",		    1, 5, LFT, ROTARY .. "SCALE:")
AddText		 ("ATTRIBScale",    2, 6, LFT, {{"ATTRIB_Scale", 0}}, "ENROUTE")
AddText		 ("ATTRIBScale1",    2, 6, LFT, {{"ATTRIB_Scale", 1}}, "TERMINAL")
AddText		 ("ATTRIBScale2",    2, 6, LFT, {{"ATTRIB_Scale", 2}}, "APPROACH")
AddText		 ("ATTRIBScale3",    2, 6, LFT, {{"ATTRIB_Scale", 3}}, "HIGH ACC")

--STEER
AddStaticText("STEER",		    1, 7, LFT, ROTARY .. "STEER:")
AddText		 ("ATTRIBSteer",    2, 8, LFT, {{"ATTRIB_Steer", 0}}, "TO FROM")
AddText		 ("ATTRIBSteer1",    2, 8, LFT, {{"ATTRIB_Steer", 1}}, "DIRECT")
AddText		 ("ATTRIBSteer2",    2, 8, LFT, {{"ATTRIB_Steer", 2}}, "TO TO")

--SCS
AddText      ("SCS_ROTARY", 1, 9, LFT, {{"ATTRIB_SCS_rotary"}}, ROTARY)
AddStaticText("SCS",            2, 9, LFT, "SCS:")
AddText		 ("ATTRIBSCS0",     6, 9, LFT, {{"ATTRIB_SCS", 0}}, "OFF")
AddText		 ("ATTRIBSCS1",     6, 9, LFT, {{"ATTRIB_SCS", 1}}, "ON")

--VNAV
AddStaticText("VNAV_MODE",	   24, 3, RGHT, ROTARY)
AddText		 ("ATTRIBVNavMode",23, 3, RGHT, {{"ATTRIB_VNavMode", 0}}, "2D")
AddText		 ("ATTRIBVNavMode1",23, 3, RGHT, {{"ATTRIB_VNavMode", 1}}, "3D")

AddText("VANGLE",  	           24, 5, RGHT,{{"ATTRIB_VNavMode", 1}} ,"VERT ANG:"..ROTARY)
AddText("VANGLEMode",          23, 6, RGHT, {{"ATTRIB_VNavMode", 1}, {"ATTRIB_VangleMode", 0}}, "COMPUTED")
AddText("VANGLEMode1",          23, 6, RGHT, {{"ATTRIB_VNavMode", 1}, {"ATTRIB_VangleMode", 1}}, "ENTERED")
AddText("VANGLEValue",         23, 7, RGHT, {{"ATTRIB_VNavMode", 1}, {"ATTRIB_VangleValue"}})
AddText("VANGLEEntry",         24, 7, RGHT, {{"ATTRIB_VNavMode", 1}, {"ATTRIB_VangleMode", 1}}, DATA_ENTRY)

--COURSE
AddText      ("ATTRIBCRS0",    13, 8, LFT, {{"ATTRIB_ActiveSteer", 0}, {"ATTRIB_SCS", 0}}, "HSI SET AT")
AddText      ("ATTRIBCRS1",    13, 8, LFT, {{"ATTRIB_SCS", 1}}, "HSI SET AT")
AddText      ("ATTRIBCRS2",    13, 8, LFT, {{"ATTRIB_ActiveSteer", 1}, {"ATTRIB_SCS", 0}}, "DIAL HSI TO")
AddText      ("ATTRIBCRS3",    13, 8, LFT, {{"ATTRIB_ActiveSteer", 2}, {"ATTRIB_SCS", 0}}, "DIAL HSI TO")
AddText      ("ATTRIBCRS4",     14, 9, LFT, {{"ATTRIB_ActiveSteer", 0}}, "CRS:")
AddText      ("ATTRIBCRS5",     14, 9, LFT, {{"ATTRIB_ActiveSteer", 1}}, "CRS:")
AddText      ("ATTRIBCRS6",     14, 9, LFT, {{"ATTRIB_ActiveSteer", 2}}, "CRS:")
AddText	     ("ATTRIB_CRS_VAL",23, 9, RGHT, {{"ATTRIB_CourseValue"}})

add_static_hint_CDU("L2", _("Select Scale Settings"))
add_static_hint_CDU("L3", _("Select a Steering Mode"))
add_static_hint_CDU("L4", _("Select a Course Steering"))

add_static_hint_CDU("R1", _("Toggle between 2D and 3D navigation"))
add_static_hint_CDU("R2", _("Toggle between COMPUTED and ENTERED Vertical Angle"))
add_hint_controllers_CDU("R3", _("Enter a Vertical Angle "), {{"ATTRIB_VangleMode",1}})
