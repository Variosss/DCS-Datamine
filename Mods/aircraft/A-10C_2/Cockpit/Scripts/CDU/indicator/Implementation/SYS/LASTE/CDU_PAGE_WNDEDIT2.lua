dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PAGE_NUM", 20 + PageNumNorOffset, 10, LFT, "2")

AddText		 ("WINDDATA_ENTRY",  1, 3, LFT, {{"WINDPresent", 3}}, DATA_ENTRY)
AddText		 ("WINDDirSpeed",    2, 3, LFT, {{"WINDPresent", 3}, {"WINDDir", 3, 0}}, "***")
AddText		 ("WINDDirSpeed1",    2, 3, LFT, {{"WINDPresent", 3}, {"WINDDir", 3, 1}})
AddText		 ("WINDDIV",         5, 3, LFT, {{"WINDPresent", 3}}, "/")
AddText		 ("WINDSpeed",	     6, 3, LFT, {{"WINDPresent", 3}, {"WINDSpeed", 3, 0}}, "**")
AddText		 ("WINDSpeed1",	     6, 3, LFT, {{"WINDPresent", 3}, {"WINDSpeed", 3, 1}})
AddText		 ("WINDALT",        12, 3, LFT, {{"WINDPresent", 3}, {"WINDALT", 3}})
AddText		 ("WINDTemp",	    23, 3, RGHT, {{"WINDPresent", 3}, {"WINDTempC", 3, 0}}, "***")
AddText		 ("WINDTemp1",	    23, 3, RGHT, {{"WINDPresent", 3}, {"TempMode", 0}, {"WINDTempC", 3, 1}})
AddText		 ("WINDTemp2",	    23, 3, RGHT, {{"WINDPresent", 3}, {"TempMode", 1}, {"WINDTempF", 3, 1}})
AddText		 ("WINDDATA_ENTRY1", 24, 3, RGHT, {{"WINDPresent", 3}}, DATA_ENTRY)

AddText		 ("WINDDATA_ENTRY2",  1, 5, LFT, {{"WINDPresent", 4}}, DATA_ENTRY)
AddText		 ("WINDDirSpeed2",    2, 5, LFT, {{"WINDPresent", 4}, {"WINDDir", 4, 0}}, "***")
AddText		 ("WINDDirSpeed3",    2, 5, LFT, {{"WINDPresent", 4}, {"WINDDir", 4, 1}})
AddText		 ("WINDDIV1",         5, 5, LFT, {{"WINDPresent", 4}}, "/")
AddText		 ("WINDSpeed2",	     6, 5, LFT, {{"WINDPresent", 4}, {"WINDSpeed", 4, 0}}, "**")
AddText		 ("WINDSpeed3",	     6, 5, LFT, {{"WINDPresent", 4}, {"WINDSpeed", 4, 1}})
AddText		 ("WINDALT1",        12, 5, LFT, {{"WINDPresent", 4}, {"WINDALT", 4}})
AddText		 ("WINDTemp4",	    23, 5, RGHT, {{"WINDPresent", 4}, {"WINDTempC", 4, 0}}, "***")
AddText		 ("WINDTemp5",	    23, 5, RGHT, {{"WINDPresent", 4}, {"TempMode", 0}, {"WINDTempC", 4, 1}})
AddText		 ("WINDTemp6",	    23, 5, RGHT, {{"WINDPresent", 4}, {"TempMode", 1}, {"WINDTempF", 4, 1}})
AddText		 ("WINDDATA_ENTRY3", 24, 5, RGHT, {{"WINDPresent", 4}}, DATA_ENTRY)

AddText		 ("WINDDATA_ENTRY4",  1, 7, LFT, {{"WINDPresent", 5}}, DATA_ENTRY)
AddText		 ("WINDDirSpeed4",    2, 7, LFT, {{"WINDPresent", 5}, {"WINDDir", 5, 0}}, "***")
AddText		 ("WINDDirSpeed5",    2, 7, LFT, {{"WINDPresent", 5}, {"WINDDir", 5, 1}})
AddText		 ("WINDDIV2",         5, 7, LFT, {{"WINDPresent", 5}}, "/")
AddText		 ("WINDSpeed4",	     6, 7, LFT, {{"WINDPresent", 5}, {"WINDSpeed", 5, 0}}, "**")
AddText		 ("WINDSpeed5",	     6, 7, LFT, {{"WINDPresent", 5}, {"WINDSpeed", 5, 1}})
AddText		 ("WINDALT2",        12, 7, LFT, {{"WINDPresent", 5}, {"WINDALT", 5}})
AddText		 ("WINDTemp7",	    23, 7, RGHT, {{"WINDPresent", 5}, {"WINDTempC", 5, 0}}, "***")
AddText		 ("WINDTemp8",	    23, 7, RGHT, {{"WINDPresent", 5}, {"TempMode", 0}, {"WINDTempC", 5, 1}})
AddText		 ("WINDTemp9",	    23, 7, RGHT, {{"WINDPresent", 5}, {"TempMode", 1}, {"WINDTempF", 5, 1}})
AddText		 ("WINDDATA_ENTRY5", 24, 7, RGHT, {{"WINDPresent", 5}}, DATA_ENTRY)

AddText		 ("WINDDATA_ENTRY6",  1, 9, LFT, {{"WINDPresent", 6}}, DATA_ENTRY)
AddText		 ("WINDDirSpeed6",    2, 9, LFT, {{"WINDPresent", 6}, {"WINDDir", 6, 0}}, "***")
AddText		 ("WINDDirSpeed7",    2, 9, LFT, {{"WINDPresent", 6}, {"WINDDir", 6, 1}})
AddText		 ("WINDDIV3",         5, 9, LFT, {{"WINDPresent", 6}}, "/")
AddText		 ("WINDSpeed6",	     6, 9, LFT, {{"WINDPresent", 6}, {"WINDSpeed", 6, 0}}, "**")
AddText		 ("WINDSpeed7",	     6, 9, LFT, {{"WINDPresent", 6}, {"WINDSpeed", 6, 1}})
AddText		 ("WINDALT3",        12, 9, LFT, {{"WINDPresent", 6}, {"WINDALT", 6}})
AddText		 ("WINDTemp10",	    23, 9, RGHT, {{"WINDPresent", 6}, {"WINDTempC", 6, 0}}, "***")
AddText		 ("WINDTemp11",	    23, 9, RGHT, {{"WINDPresent", 6}, {"TempMode", 0}, {"WINDTempC", 6, 1}})
AddText		 ("WINDTemp12",	    23, 9, RGHT, {{"WINDPresent", 6}, {"TempMode", 1}, {"WINDTempF", 6, 1}})
AddText		 ("WINDDATA_ENTRY7", 24, 9, RGHT, {{"WINDPresent", 6}}, DATA_ENTRY)

add_hint_controllers_CDU("L1", _("Enter wind direction and speed at the corresponding altitude in degrees/knots"), {{"WINDPresent", 3}})
add_hint_controllers_CDU("L2", _("Enter wind direction and speed at the corresponding altitude in degrees/knots"), {{"WINDPresent", 4}})
add_hint_controllers_CDU("L3", _("Enter wind direction and speed at the corresponding altitude in degrees/knots"), {{"WINDPresent", 5}})
add_hint_controllers_CDU("L4", _("Enter wind direction and speed at the corresponding altitude in degrees/knots"), {{"WINDPresent", 6}})
add_hint_controllers_CDU("R1", _("Enter Temperature at corresponding altitude in degrees C"), {{"WINDPresent", 3}})
add_hint_controllers_CDU("R2", _("Enter Temperature at corresponding altitude in degrees C"), {{"WINDPresent", 4}})
add_hint_controllers_CDU("R3", _("Enter Temperature at corresponding altitude in degrees C"), {{"WINDPresent", 5}})
add_hint_controllers_CDU("R4", _("Enter Temperature at corresponding altitude in degrees C"), {{"WINDPresent", 6}})
