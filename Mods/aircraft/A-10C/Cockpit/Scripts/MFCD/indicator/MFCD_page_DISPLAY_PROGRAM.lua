dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")

txt_DPP							= CreateElement "ceStringPoly"
txt_DPP.name					= "txt_DPP"
txt_DPP.material				= font_MFCD
txt_DPP.alignment				= "CenterCenter"
txt_DPP.value					= "DISPLAY\nPROGRAM"
txt_DPP.init_pos				= {max_pixels_count/2,OSB_positions[19][2],0}
SetLowerLeftCornerOrigin(txt_DPP)
txt_DPP.stringdefs				= predefined_fonts[3]
txt_DPP.UseBackground			= true
txt_DPP.BackgroundMaterial		= MFCD_SOLID_BLACK
Add(txt_DPP)
use_mipfilter(txt_DPP)

buttons			 = {6, 7, 8, 9, 10, 16, 17, 18, 19, 20}
txt_osb_symbol	 = {}
txt_osb_values   = {}


for i, osb in pairs(buttons) do
	txt_osb_symbol[i] 				 =  add_OSB_label(osb, SYS_ACTION)
	txt_osb_values[i]		  		 =  default_label_text(osb, true) 
	txt_osb_values[i].parent_element =  txt_osb_symbol[i].name
	txt_osb_values[i].controllers	 = {{"DPP_OSB_label", 0, osb - 1},
										{"txt_color_selected_DPP_OSB"			, osb - 1}}
	txt_osb_values[i].value			 = ""
	txt_osb_values[i].formats        = {"%s"}
	
	addOSB_Box(osb, {txt_osb_symbol[i],
					 txt_osb_values[i]})
end

add_dummy_boxes({1, 2, 3, 4, 5})

add_osb_static_hint(7 , _("System Status and BIT Results"))
add_osb_static_hint(8 , _("Access to DTC Load Control"))
add_osb_static_hint(9 , _("Display and Control Maverick Video"))
add_osb_static_hint(10, _("Remove Assigned Page from MFCD"))
add_osb_static_hint(16, _("Repeat EGI CDU Display"))
add_osb_static_hint(17, _("Display the message page (for SADL use only)"))
add_osb_static_hint(18, _("Display and Enter Digital Stores Management Information"))
add_osb_static_hint(19, _("Display and Control Targeting Pod Video"))
add_osb_static_hint(20, _("Display and Control Tactical Awareness Display"))
