dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameHARS",   2, 1, LFT, "HARS")

AddStaticText("INVALID",        2, 3, LFT, "INVALID")
AddStaticText("HARS",          18, 3, LFT, "HARS")
AddStaticText("ROLL",           2, 5, LFT, "ROLL")
AddStaticText("PITCH",          2, 7, LFT, "PITCH")
AddStaticText("MAG_HEAD",       2, 9, LFT, "MAG HEAD")

AddStaticText("DEGREE1",       17, 5, LFT, DEGREE)
AddStaticText("DEGREE2",       17, 7, LFT, DEGREE)
AddStaticText("DEGREE3",       17, 9, LFT, DEGREE)

AddText("INVALID_ST0",         10, 3, LFT, {{"HARS_InvalidStatus", 0}}, "NO")
AddText("INVALID_ST1",         10, 3, LFT, {{"HARS_InvalidStatus", 1}}, "YES")

AddText("HARS_ST2",			   23, 3, LFT, {{"HARS_DeviceStatus", 2}}, "V")
AddText("HARS_ST3",			   23, 3, LFT, {{"HARS_DeviceStatus", 3}}, "F")

AddText("ROLL_ST2",			   19, 5, LFT, {{"HARS_RollStatus", 2}}, "V")
AddText("ROLL_ST3",			   19, 5, LFT, {{"HARS_RollStatus", 3}}, "F")

AddText("PITCH_ST2",		   19, 7, LFT, {{"HARS_PitchStatus", 2}}, "V")
AddText("PITCH_ST3",		   19, 7, LFT, {{"HARS_PitchStatus", 3}}, "F")

AddText("MAGH_ST2",			   19, 9, LFT, {{"HARS_MagHeadStatus", 2}}, "V")
AddText("MAGH_ST3",			   19, 9, LFT, {{"HARS_MagHeadStatus", 3}}, "F")

AddText("ROLL_VAL",            16, 5, RGHT, {{"HARS_Roll"}})
AddText("PITCH_VAL",           16, 7, RGHT, {{"HARS_Pitch"}})
AddText("MAGH_VAL",            16, 9, RGHT, {{"HARS_MagHead"}})
