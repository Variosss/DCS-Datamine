dofile(LockOn_Options.script_path.."MFCD\\indicator\\COMM\\MFCD_COMM_common.lua")

addOSB_LabelWSymb(1, "PREV", BRANCH_L)
add_osb_static_hint(1, "Return to COMM Page 3")

addRT_Selection()
addRowScrollers()

add_dummy_boxes({2, 3, 4, 5, 6, 7, 8, 9, 10, 16, 17})

addCOMM_Table(7, 3, {"CHN", "NAME", "NET"})

for i = 1, 7 do
	addTblText("ChannelNum_" .. i, "" .. (18 + i), i, 1)
	addTblText("DashCol3_" .. i, "-", i, 3)
end


addCursor()
