dofile(LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_TAD_tools.lua")

Label_OSB_01       = add_OSB_label(1,BRANCH_L .. "TAD")
addOSB_Box(1, {Label_OSB_01})
add_osb_static_hint(1 , _("Return to TAD page"))

add_osb_static_hint(17 , _("Enter Callsign"))

add_dummy_boxes({2, 3, 4})


--Label_OSB_05       = add_OSB_label(5,BRANCH_L .. "TDL")
--addOSB_Box(5, {Label_OSB_05})
--add_osb_static_hint(5 , _("Go to TDL page"))


Label_OSB_07       = add_OSB_label(7,DATA_ENTRY)
Label_OSB_07_text  = default_label_text(7,true)
Label_OSB_07_text.parent_element = Label_OSB_07.name
Label_OSB_07_text.formats     = {"OWN ID\n%d","OWN ID\n0%d"}
Label_OSB_07_text.controllers = {{"tad_SADL_ownID_txt", 0, 1}}
addOSB_Box(7,{Label_OSB_07, Label_OSB_07_text})
add_osb_static_hint(7 , _("Set OWN ID Number"))


Label_OSB_08       = add_OSB_label(8,DATA_ENTRY)
Label_OSB_08_text  = default_label_text(8,true)
Label_OSB_08_text.parent_element = Label_OSB_08.name
Label_OSB_08_text.formats     = {"GRP ID\n%d", "GRP ID\n0%d"}
Label_OSB_08_text.controllers = {{"tad_SADL_grpID_txt", 0, 1}}
addOSB_Box(8,{Label_OSB_08,Label_OSB_08_text})
add_osb_static_hint(8 , _("Set GROUP ID Number"))


add_dummy_boxes({6})

--[[
Label_OSB_17       = add_OSB_label(17,ROTARY)
Label_OSB_17_text  = default_label_text(17)
Label_OSB_17_text.parent_element = Label_OSB_17.name
Label_OSB_17_text.formats     = {"CALL\n%s"}
Label_OSB_17_text.controllers = {{"tad_SADL_pwr_output_txt"}}
addOSB_Box(17,{Label_OSB_17, Label_OSB_17_text})
add_osb_static_hint(17 , _("Enter callsign"))
--]]

Label_OSB_17       = add_OSB_label(17, DATA_ENTRY)
--Label_OSB_17.controllers = {{"tad_TDL_info_voice_callsign_lbl_avail"}}

Label_OSB_17_text  = default_label_text(17,true)
--SetLowerLeftCornerOrigin(Label_OSB_17_text)
--Label_OSB_17_text.init_pos = {soi_min_x, OSB_positions[17][2]}
Label_OSB_17_text.parent_element = Label_OSB_17.name
Label_OSB_17_text.formats = {"CALL", "CALL\n%s"}
Label_OSB_17_text.controllers = {{"tad_TDL_info_voice_callsign"}}
addOSB_Box(17,{Label_OSB_17,Label_OSB_17_text})

add_dummy_boxes({10, 16, 18, 19, 20})

-- commented for a while as it occludes hook coordinates field
-- Also note that this info should be rendered on all TAD pages where
-- a hook is visible
--add_sadl_data()

-- TODO: hook LAN/LON is missing
