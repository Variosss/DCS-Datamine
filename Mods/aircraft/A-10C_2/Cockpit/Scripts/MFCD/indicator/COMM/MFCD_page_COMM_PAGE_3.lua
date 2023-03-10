dofile(LockOn_Options.script_path.."MFCD\\indicator\\COMM\\MFCD_COMM_common.lua")

addOSB_LabelWSymb(1, "PREV", BRANCH_L)
add_osb_static_hint(1, "Return to COMM Page 2")

addOSB_LabelWSymb(2, "NEXT", BRANCH_L)
add_osb_static_hint(2, "Go to COMM Page 4")

addRT_Selection()
addRowScrollers()

add_dummy_boxes({3, 4, 5, 6, 7, 8, 9, 10, 16, 17})

addCOMM_Table(18, 3, {"CHN", "NAME", "NET"})

for i = 1, 18 do
	addTblText("ChannelNum_" .. i, "" .. i, i, 1)
	addTblText("DashCol3_" .. i, "-", i, 3)
end



addCursor()
