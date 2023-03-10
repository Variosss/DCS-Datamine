dofile(LockOn_Options.script_path.."MFCD\\indicator\\COMM\\MFCD_COMM_common.lua")

addOSB_LabelWSymb(1, "PREV", BRANCH_L)
add_osb_static_hint(1, "Return to COMM Page 1")

--addOSB_LabelWSymb(2, "NEXT", BRANCH_L)
--add_osb_static_hint(2, "Go to COMM Page 3")

addRT_Selection()
addRowScrollers()
addFreq_Change()

add_dummy_boxes({3, 4, 5, 6, 7, 8, 9, 10, 16, 17})

addCOMM_Table(17, 4, {"CHN", "NAME", "FREQ", "MOD"})

for i = 1, 7 do
	addTblText("ChannelNum_Com2_"..string.format("%d",i), "" .. 18 + i, i, 1)
	--addTblText("DashCol3_" .. i, "-", i, 3)
	--addTblText("DashCol4_" .. i, "-", i, 4)
	addTblText("Preset_name_Com2_"..string.format("%d",i), nil, i, 2, {{"PresetName", i+17}} )
	addTblTextLeft("Preset_freq_Com2_"..string.format("%d",i), nil, i, 3, {{"PresetFrequency", i+17}} )
	addTblTextLeft("Preset_mod_Com2_"..string.format("%d",i), nil, i, 4, {{"PresetModulation", i+17}} )
end

addTblText("ChannelNum_26T", "26T", 8, 1)
addTblText("ChannelNum_26R", "26R", 9, 1)
addTblText("ChannelNum_27T", "27T", 10, 1)
addTblText("ChannelNum_27R", "27R", 11, 1)
addTblText("ChannelNum_28T", "28T", 12, 1)
addTblText("ChannelNum_28R", "28R", 13, 1)
addTblText("ChannelNum_29T", "29T", 14, 1)
addTblText("ChannelNum_29R", "29R", 15, 1)
addTblText("ChannelNum_30T", "30T", 16, 1)
addTblText("ChannelNum_30R", "30R", 17, 1)

local i = 8
local j = 8
while i<=17 do
	addTblText("Preset_name_Com2_"..string.format("%d",i), nil, i, 2, {{"PresetName", j+17}} )
	addTblText("Preset_freq_Com2_"..string.format("%d",i), nil, i, 3, {{"PresetFrequency", j+17}} )
	addTblText("Preset_mod_Com2_"..string.format("%d",i), nil, i, 4, {{"PresetModulation", j+17}} )
	
	addTblText("Preset_name_Com2_"..string.format("%d",i+1), nil, i, 2, {{"PresetName", j+17}} )
	addTblText("Preset_freq_Com2_"..string.format("%d",i+1), nil, i+1, 3, {{"PresetFrequency", j+17}} )
	addTblText("Preset_mod_Com2_"..string.format("%d",i+1), nil, i+1, 4, {{"PresetModulation", j+17}} )
	i = i+2
	j = j+1
end






addCursor()
