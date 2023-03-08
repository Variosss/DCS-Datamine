dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameINS", 2, 1, LFT, "INS")

AddStaticText("ALIGN", 1, 3, LFT, BRANCH_L .. "ALIGN")
AddStaticText("ALT_ALIGN", 1, 5, LFT, BRANCH_L .. "ALT ALIGN")
AddStaticText("POS", 1, 7, LFT, BRANCH_L .. "POS")
AddStaticText("MISC_ADDR", 1, 9, LFT, DATA_ENTRY .. "MISC")

AddStaticText("INSSTAT", 24, 3, RGHT, "INSSTAT" .. BRANCH_R)
AddStaticText("UPDATE", 24, 5, RGHT, "UPDATE" .. BRANCH_R)
AddStaticText("BRACKETS_MISC_DATA", 24, 9, RGHT, DATA_ENTRY)

add_static_hint_CDU("L1", _("Branch to the ALIGN Page"))
add_static_hint_CDU("L2", _("Branch to the ALTALGN Page"))
add_static_hint_CDU("L3", _("Branch to the POS Page"))
add_static_hint_CDU("R1", _("Branch to the INSSTAT Page"))
add_static_hint_CDU("R2", _("Branch to the UPDATE Page"))
