dofile(LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_TAD_tools.lua")

txt_TAD_PPP							= CreateElement "ceStringPoly"
txt_TAD_PPP.name					= "txt_TAD_PPP"
txt_TAD_PPP.material				= font_MFCD
txt_TAD_PPP.alignment				= "CenterCenter"
txt_TAD_PPP.value					= "TAD DISPLAY\nPROGRAM"
txt_TAD_PPP.init_pos				= {max_pixels_count/2,OSB_positions[19][2],0}
SetLowerLeftCornerOrigin(txt_TAD_PPP)
txt_TAD_PPP.stringdefs				= predefined_fonts[3]
--txt_TAD_PPP.UseBackground			= true
--txt_TAD_PPP.BackgroundMaterial	= MFCD_SOLID_BLACK
Add(txt_TAD_PPP)
use_mipfilter(txt_TAD_PPP)

buttons			 = {6,7,8,9,16,17,18,19,20}
txt_osb_values   = {}

for i, osb in pairs(buttons) do
	txt_osb_values[i]		  		 =  default_label_text(osb, true) 
	txt_osb_values[i].controllers	 = {{"tad_PPP_OSB_label", 0, osb - 1},
										{"tad_color_selected_PPP_OSB"			,osb - 1}}
	txt_osb_values[i].formats        = {"%s"}
	
	if osb < 10 then
		shift_button_pos(txt_osb_values[i], osb, -10, 0)
	else
		shift_button_pos(txt_osb_values[i], osb, 10, 0)		
	end
	
	addOSB_Box(osb, {txt_osb_values[i]})
end

txt_osb_value_clear		  		   =  default_label_text(10, true) 
txt_osb_value_clear.value      	   =  "CLR" 
txt_osb_value_clear.controllers	 = {{"tad_color_selected_PPP_OSB"			,10 - 1}}
shift_button_pos(txt_osb_value_clear, 10, -10, 0)
addOSB_Box(10, {txt_osb_value_clear})

Add_NOT_SOI_display()
