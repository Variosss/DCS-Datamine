dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameDTS", 2, 1, LFT, "DTS")

AddStaticText("DTS",      2, 3, LFT, "DTS")
AddText("DTS_ST0",        9, 3, LFT, {{"DTSDeviceStatus", 0}}, "N")
AddText("DTS_ST1",        9, 3, LFT, {{"DTSDeviceStatus", 1}}, "I")
AddText("DTS_ST2",        9, 3, LFT, {{"DTSDeviceStatus", 2}}, "V")
AddText("DTS_ST3",        9, 3, LFT, {{"DTSDeviceStatus", 3}}, "F")
AddText("DTS_ST4",        9, 3, LFT, {{"DTSDeviceStatus", 4}}, "I")

AddStaticText("READY",    2, 5, LFT, "READY")
AddText("READY_ST0",      8, 5, LFT, {{"DTSDeviceStatus", 0}}, "NO")
AddText("READY_ST3",      8, 5, LFT, {{"DTSDeviceStatus", 3}}, "NO")
AddText("READY_ST1",      8, 5, LFT, {{"DTSDeviceStatus", 1}}, "YES")
AddText("READY_ST2",      8, 5, LFT, {{"DTSDeviceStatus", 2}}, "YES")
AddText("READY_ST4",      8, 5, LFT, {{"DTSDeviceStatus", 4}}, "NO")

AddStaticText("DTSUPLD", 24, 3, RGHT, "DTSUPLD" .. BRANCH_R)
AddStaticText("DTSDNLD", 24, 5, RGHT, "DTSDNLD" .. BRANCH_R)
AddStaticText("DTSSTAT", 24, 7, RGHT, "DTSSTAT" .. BRANCH_R)

add_static_hint_CDU("R1", _("Branch to the DTS Upload page"))
add_static_hint_CDU("R2", _("Branch to the DTS Download page"))
add_static_hint_CDU("R3", _("Branch to the DTS Status page"))