dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameDTSSTAT", 2, 1, LFT, "DTSSTAT")
AddStaticText("DTCID", 2, 3, LFT, "DTCID 0430 9714 0720")
AddStaticText("VRSN",  2, 4, LFT, "VRSN PO1A   DTS")

AddText("DTS_ST0",    23, 4, LFT, {{"DTSDeviceStatus", 0}}, "N")
AddText("DTS_ST1",    23, 4, LFT, {{"DTSDeviceStatus", 1}}, "I")
AddText("DTS_ST2",    23, 4, LFT, {{"DTSDeviceStatus", 2}}, "V")
AddText("DTS_ST3",    23, 4, LFT, {{"DTSDeviceStatus", 3}}, "F")
AddText("DTS_ST4",    23, 4, LFT, {{"DTSDeviceStatus", 4}}, "I")

AddStaticText("MODE",  2, 5, LFT, "MODE INDX")
AddStaticText("ST_ST", 2, 6, LFT, "SELF TEST STATUS")
AddStaticText("LINE7", 2, 7, LFT, "0000 0000 0000")
AddStaticText("BIT_TST",2, 8, LFT, "BIT TEST")
AddStaticText("LINE9", 2, 9, LFT, "0000 0000")

AddStaticText("DTS",  24, 9, RGHT, "DTS" .. BRANCH_R)

add_static_hint_CDU("R4", _("Branch to the DTS page"))