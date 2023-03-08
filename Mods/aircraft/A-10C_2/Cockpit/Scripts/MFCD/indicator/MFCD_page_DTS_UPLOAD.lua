dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")

txt_DTS_Display							= CreateElement "ceStringPoly"
txt_DTS_Display.name					= "txt_DTS_Display"
txt_DTS_Display.material				= font_MFCD
txt_DTS_Display.alignment				= "CenterCenter"
txt_DTS_Display.value					= "DTS\nUPLOAD"
txt_DTS_Display.init_pos				= {max_pixels_count/2,OSB_positions[19][2],0}
SetLowerLeftCornerOrigin(txt_DTS_Display)
txt_DTS_Display.stringdefs				= predefined_fonts[3]
txt_DTS_Display.UseBackground			= true
txt_DTS_Display.BackgroundMaterial		= MFCD_SOLID_BLACK
Add(txt_DTS_Display)
use_mipfilter(txt_DTS_Display)

txt_DTS_Display_underline						= CreateElement "ceStringPoly"
txt_DTS_Display_underline.name					= "txt_DTS_Display_underline"
txt_DTS_Display_underline.material				= font_MFCD
txt_DTS_Display_underline.alignment				= "CenterCenter"
txt_DTS_Display_underline.value					= "___\n______"
txt_DTS_Display_underline.parent_element		= "txt_DTS_Display"
txt_DTS_Display_underline.stringdefs			= predefined_fonts[3]
Add(txt_DTS_Display_underline)
use_mipfilter(txt_DTS_Display_underline)

buttons = 
{
	20, 19, 18, 17, 16, 10, 8
}

texts = 
{
	"", "LOAD\nTAD", "LOAD\nDSMS", "LOAD\nTGP", "LOAD\nPAGE", "LOAD\nALL", "LOAD\nHMCS",
}

txt_osb_symbols	 = {}
txt_load_flag    = {}
txt_osb_texts    = {}

-- It is for reference only
--[[
DTS_UPLOAD_TDL	= 1
DTS_UPLOAD_TAD  = 2
DTS_UPLOAD_DSMS = 3
DTS_UPLOAD_TGP  = 4
DTS_UPLOAD_PAGE = 5
DTS_UPLOAD_ALL	= 6
--]]

for i = 2, #buttons do

	txt_osb_symbols[i]			   = add_OSB_label(buttons[i], SYS_ACTION)
	txt_osb_symbols[i].controllers = {{"DTS_UploadAvail"}}
	
	txt_load_flag[i]			   = Copy(txt_osb_symbols[i])
	txt_load_flag[i].value  	   = "*"
	txt_load_flag[i].controllers   = {{"DTS_current_loaded", i}}
	Add(txt_load_flag[i])
	
	txt_osb_texts[i]			   = add_text_osb_position(buttons[i], texts[i])
	txt_osb_texts[i].controllers   = {{"declutter"}}
	
	addOSB_Box(buttons[i], {txt_osb_symbols[i],
							txt_load_flag[i],
							txt_osb_texts[i]})
end

add_dummy_boxes({1, 2, 3, 4, 5, 6, 7, 9})

add_osb_static_hint(8, _("Load HMCS Settings Only"))
add_osb_static_hint(10, _("Load All DTS Data"))
add_osb_static_hint(16, _("Load DTS Page Assignments Only"))
add_osb_static_hint(17, _("Load DTS TGP Defaults Only"))
add_osb_static_hint(18, _("Load DSMS Data Only"))
add_osb_static_hint(19, _("Load TAD Settings Only"))
--add_osb_static_hint(20, _("Load Tactical Data Link (SADL) Settings"))
