dofile(LockOn_Options.script_path.."MFCD\\indicator\\COMM\\MFCD_COMM_common.lua")

addOSB_LabelWSymb(2, "NEXT", BRANCH_L)
add_osb_static_hint(2, "Go to COMM Page 2")

addRT_Selection()
addRowScrollers()
addFreq_Change()

add_dummy_boxes({1, 3, 4, 5, 6, 7, 8, 9, 10, 16, 17})

addCOMM_Table(18, 4, {"CHN", "NAME", "FREQ", "MOD"})

for i = 1, 18 do
	addTblText("ChannelNum_Com1_"..string.format("%d",i), "" .. i, i, 1)
	addTblText("Preset_name_Com1_"..string.format("%d",i), nil, i, 2, {{"PresetName", i-1}} )
	addTblText("Preset_freq_Com1_"..string.format("%d",i), nil, i, 3, {{"PresetFrequency", i-1}} )
	addTblText("Preset_mod_Com1_"..string.format("%d",i), nil, i, 4, {{"PresetModulation", i-1}} )
end


addCursor()
