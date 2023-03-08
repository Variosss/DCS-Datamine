dofile(LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_TAD_tools.lua")



Label_OSB_01   = add_OSB_label(1, BRANCH_L 	 .. "TAD")
Label_OSB_02   = add_OSB_label(2, SYS_ACTION .. "RSET")

addOSB_Box(1, {Label_OSB_01})
addOSB_Box(2, {Label_OSB_02})

Scrollers = addScrollers(20, 19, 10,
	{{"declutter"}, {"locked_OSB_status", 20 - 1, -1}},
	{{"declutter"}, {"locked_OSB_status", 19 - 1, -1}})

addOSB_Box(20, {Scrollers[3]})
addOSB_Box(19, {Scrollers[4]})

Label_OSB18 						= add_OSB_label(18, DATA_ENTRY)

Label_OSB18_text_NEW				= default_label_text(18, true)
Label_OSB18_text_NEW.parent_element = Label_OSB18.name
Label_OSB18_text_NEW.value			= "NEW"
Label_OSB18_text_NEW.controllers    = {{"tad_new_profile_status",0}}

Label_OSB18_text_CREATED				= default_label_text(18, true)
Label_OSB18_text_CREATED.parent_element = Label_OSB18.name
Label_OSB18_text_CREATED.formats		= {"%s"}
Label_OSB18_text_CREATED.controllers    = {{"tad_new_profile_status", 1}, {"tad_temporal_profile_name", 0}}

Label_OSB18_text_DBFULL				= default_label_text(18, true)
Label_OSB18_text_DBFULL.parent_element = Label_OSB18.name
Label_OSB18_text_DBFULL.value			= "DB\nFULL"
Label_OSB18_text_DBFULL.controllers    = {{"tad_new_profile_status", 2}}

addOSB_Box(18, {Label_OSB18, Label_OSB18_text_NEW, Label_OSB18_text_CREATED, Label_OSB18_text_DBFULL})


Label_OSB17 					= add_OSB_label(17 ,BRANCH_L)
Label_OSB17_text				= default_label_text(17, true)
Label_OSB17_text.parent_element = Label_OSB17.name
Label_OSB17_text.value			= "CHG\nSET"
Label_OSB17_text.isdraw 		= true

addOSB_Box(17, {Label_OSB17, Label_OSB17_text})

profile_name						= CreateElement "ceStringPoly"
profile_name.material				= font_MFCD
profile_name.alignment				= "LeftCenter"
profile_name.stringdefs				= txt_labels_font
profile_name.UseBackground			= true
profile_name.BackgroundMaterial		= MFCD_SOLID_BLACK
profile_name.formats				= {"%s"}
profile_name.controllers			= {{"declutter"},
									   {"tad_db_profile_name", 0}}
SetLowerLeftCornerOrigin(profile_name)
profile_name.init_pos				= {OSB_positions[19][1] - 5, (OSB_positions[19][2] + OSB_positions[20][2]) * 0.5, 0}
Add(profile_name)
use_mipfilter(profile_name)

add_osb_static_hint(1, _("Return to TAD page"))
add_osb_static_hint(2, _("Reset TAD Settings to Default"))
add_osb_static_hint(17, _("Go to TAD Profile Settings page"))
add_osb_static_hint(18, _("Create Profile Name"))
add_osb_static_hint(19, _("Cycle to Previous Profile"))
add_osb_static_hint(20, _("Cycle to Next Profile"))

--[[
Label_OSB09 					= add_OSB_label(9,BRANCH_L)
Label_OSB09_text				= default_label_text(9)
Label_OSB09_text.parent_element = Label_OSB09.name
Label_OSB09_text.value			= "TDL"
addOSB_Box(9, {Label_OSB09, Label_OSB09_text})
add_osb_static_hint(9, _("Go to Tactical Datalink page"))
--]]

add_tad_save_delete_profile_notification()

add_dummy_boxes({4, 5, 6, 7, 8, 10, 16})
