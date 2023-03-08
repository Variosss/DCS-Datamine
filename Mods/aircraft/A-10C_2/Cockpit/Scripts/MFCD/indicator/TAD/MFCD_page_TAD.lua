dofile(LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_TAD_tools.lua")

txt_no_nav_data							= CreateElement "ceStringPoly"
txt_no_nav_data.name					= "txt_no_nav_data"
txt_no_nav_data.material				= font_MFCD
txt_no_nav_data.alignment				= "CenterCenter"
txt_no_nav_data.UseBackground			= true
txt_no_nav_data.BackgroundMaterial		= MFCD_SOLID_BLACK
txt_no_nav_data.value          			= "NO NAV\nDATA"
txt_no_nav_data.init_pos				= {max_pixels_count/2,OSB_positions[19][2] + (OSB_positions[20][2] - OSB_positions[19][2])*0.5,0}
SetLowerLeftCornerOrigin(txt_no_nav_data)
txt_no_nav_data.stringdefs				= predefined_fonts[3]
txt_no_nav_data.controllers				= {{"tad_pos_symbology_available", 1}}
Add(txt_no_nav_data)
use_mipfilter(txt_no_nav_data)


-- It is shown in reverse video when SPI broadcast is SET
-- (not necessary is broadcasting)
--bool_dummy_osb	  (6, "tad_SPI_broadcast_is_set", "SPI\n ON", "SPI\nOFF")
SPI_BdcstPlacer				   = add_OSB_label(6)
SPI_BdcstLblOFF				   = default_label_text(6,true)
SPI_BdcstLblOFF.value		   = "SPI\nOFF"
SPI_BdcstLblOFF.parent_element = SPI_BdcstPlacer.name 
SPI_BdcstLblOFF.controllers    = {{"tad_pos_symbology_available"}, {"tad_SPI_broadcast_is_set", -1}}

SPI_BdcstLblON				   = Copy(SPI_BdcstLblOFF)
SPI_BdcstLblON.value		   = "SPI\n ON"
SPI_BdcstLblON.material		   = font_MFCD_BLACK
SPI_BdcstLblON.BackgroundMaterial = MFCD_SOLID_GREEN
SPI_BdcstLblON.controllers     = {{"tad_pos_symbology_available"}, {"tad_SPI_broadcast_is_set"}}
Add(SPI_BdcstLblON)


label_7_W_C 				    = add_OSB_label(7, SYS_ACTION)
label_7_W_C.material            = font_MFCD_RED
label_7_W_C.controllers         = {{"declutter"}, {"tad_pos_symbology_available"}, {"tad_WILCO_CNTCO_available", 1}}

label_7_W_C_text 			    = default_label_text(7,true)
label_7_W_C_text.parent_element = label_7_W_C.name
label_7_W_C_text.material       = font_MFCD_RED
label_7_W_C_text.value          = "CNTCO"

label_7_CNC 				    = add_OSB_label(7, SYS_ACTION)
label_7_CNC.material            = font_MFCD_RED
label_7_CNC.controllers         = {{"declutter"}, {"tad_pos_symbology_available"}, {"tad_is_ma_obj_hooked"}}

label_7_CNC_text 			    = default_label_text(7,true)
label_7_CNC_text.parent_element = label_7_CNC.name
label_7_CNC_text.material       = font_MFCD_RED
label_7_CNC_text.value          = "CNC"

label_7 				= add_OSB_label(7, SYS_ACTION)
label_7.controllers     = {{"tad_pos_symbology_available"},
                            {"declutter"}, 
                            --{"locked_OSB_status", 7, -1},
							{"tad_is_PPLI_hooked"},
							{"tad_WILCO_CNTCO_available", 0}
						   }

label_7_text 	         = default_label_text(7,true)
label_7_text.formats     = {"SEND", "SEND\n%s"}
label_7_text.parent_element = label_7.name
label_7_text.controllers = {{"tad_send_ma_label"}}

addOSB_Box(7, {label_7_W_C, label_7_W_C_text, label_7_CNC, label_7_CNC_text, label_7, label_7_text})


-- OSB 9
add_tad_coordinates_display_mode_selection()


label_10 					  = add_OSB_label(10, BRANCH_L)
label_10_text 				  = default_label_text(10, true)
label_10_text.parent_element  = label_10.name
label_10_text.value 		  = "NET"

add_osb_static_hint(10, _("Network Configuration Page"))
addOSB_Box(10, {label_10, label_10_text})


label_17 							 = add_OSB_label(17, SYS_ACTION)
label_17.controllers                 = {{"declutter"}, {"tad_copy_available"}};

label_17_text				 		 = default_label_text(17, true)
label_17_text.formats		 		 = {"%d?"}
label_17_text.controllers 	 		 = {{"tad_next_mission_waypoint_available", 1},
										{"tad_next_available_mission_waypoint", 0}}
label_17_text.parent_element 		 = label_17.name

label_17_text_DB_FULL				 = default_label_text(17, true)
label_17_text_DB_FULL.value			 = "DB\nFULL"
label_17_text_DB_FULL.controllers 	 = {{"tad_next_mission_waypoint_available", 0}}
label_17_text_DB_FULL.parent_element = label_17.name

addOSB_Box(17, {label_17, label_17_text, label_17_text_DB_FULL})


label_18 = add_OSB_label(18, ROTARY)
label_18.controllers = {{"declutter"}, {"locked_OSB_status", 18 - 1, -1}, {"tad_pos_symbology_available"}, {"tad_hook_conn_line_opt_avail"}};

label_18_text = {}
for i = 1,8 do
	label_18_text[i] = default_label_text(18, true)
	label_18_text[i].parent_element = label_18.name
	label_18_text[i].controllers = {{"tad_pos_symbology_available"}, {"tad_hook_mode",i - 1}}
end
label_18_text[1].value = "HOOK\nOWN"  --TAD_TAG_MODE_OWN
label_18_text[2].value = "OWN\nHOOK"  --TAD_TAG_MODE_OWN_TAG
label_18_text[3].value = "HOOK\nBULL" --TAD_TAG_MODE_BULL
label_18_text[4].value = "BULL\nHOOK" --TAD_TAG_MODE_BULL_TAG
label_18_text[5].value = "HOOK\nCURS" -- TAD_TAG_MODE_CURS
label_18_text[6].value = "CURS\nHOOK" --TAD_TAG_MODE_CURS_TAG
label_18_text[7].value = "BULL\nCURS" --TAD_TAG_MODE_BULL_CURS
label_18_text[8].value = "CURS\nBULL" --TAD_TAG_MODE_CURS_BULL     


addOSB_Box(18,{label_18,
				label_18_text[1],
				label_18_text[2],
				label_18_text[3],
				label_18_text[4],
				label_18_text[5],
				label_18_text[6],
				label_18_text[7],
				label_18_text[8]})


label_19_W_C 				= add_OSB_label(19, SYS_ACTION)
label_19_W_C.controllers    = {{"declutter"}, {"tad_pos_symbology_available"}, {"tad_WILCO_CNTCO_available", 1}}

label_19_W_C_text           = default_label_text(19, true)
label_19_W_C_text.parent_element = label_19_W_C.name
label_19_W_C_text.value     = "WILCO"

addOSB_Box(19, {label_19_W_C, label_19_W_C_text})

label_20 = add_OSB_label(20, ROTARY)
label_20.controllers = {{"tad_pos_symbology_available"}, {"declutter"}, {"locked_OSB_status", 19, -1}};

label_20_text = {}
for i = 0,2 do
	label_20_text[i] = default_label_text(20, true)
	label_20_text[i].parent_element = label_20.name
	label_20_text[i].controllers = {{"tad_pos_symbology_available"}, {"tad_map_display_mode",i}}
end
label_20_text[0].value = "MAP\nOFF"
label_20_text[1].value = "MAP\nMAN"
label_20_text[2].value = "MAP\nAUTO"

addOSB_Box(20, {label_20,label_20_text[0], label_20_text[1], label_20_text[2]})


MA_txt				= CreateElement "ceStringPoly"
MA_txt.name			= "MA"
MA_txt.alignment	= "CenterCenter"
MA_txt.value		= "ATTACK"
MA_txt.material		= font_MFCD
MA_txt.UseBackground	  = true
MA_txt.BackgroundMaterial = MFCD_SOLID_BLACK
MA_txt.stringdefs	= txt_labels_font
MA_txt.init_pos		= {OSB_positions[3][1]-2, OSB_positions[3][2]-22}
MA_txt.controllers	= {{"declutter"}, {"tad_pos_symbology_available"}, {"tad_WILCO_CNTCO_available", 1}, {"blinkingMA"}}
Add(MA_txt)
SetLowerLeftCornerOrigin(MA_txt)
use_mipfilter(MA_txt)


add_dummy_boxes({6, 16})

add_osb_static_hint(20, _("Moving Map Display Mode"))
add_osb_static_hint(9,  _("Select Coordinate System for Hooked Symbol"))
add_osb_static_hint(18, _("Select Hook Mode"))
add_osb_static_hint(17, _("Copy Hook as Mission waypoint"))
