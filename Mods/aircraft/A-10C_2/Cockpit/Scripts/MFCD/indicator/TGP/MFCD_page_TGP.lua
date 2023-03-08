dofile(LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_TGP_tools.lua")


local SzScale = max_pixels_count * GetScale()

local Friendly_Symbols_Placer        = CreateElement("ceSimple")
Friendly_Symbols_Placer.name         = "Friendly_Symbols_Placer"
Friendly_Symbols_Placer.controllers	 = {{"tgp_Friendly_Symbols_Available"}}
SetLowerLeftCornerOrigin(Friendly_Symbols_Placer)
Add(Friendly_Symbols_Placer)

for i = 1, 5 do
	local Friendly_PPLI_Symbol			  = CreateElement("ceTexPoly")
	Friendly_PPLI_Symbol.name 			  = "Friendly_PPLI_Symbol_" .. i
	Friendly_PPLI_Symbol.controllers	  = {{"tgp_Friendly_Symbol", SzScale, SzScale, i, 1}}
	Friendly_PPLI_Symbol.h_clip_relation  = h_clip_relations.COMPARE
	Friendly_PPLI_Symbol.level 		      = DEFAULT_LEVEL
	Friendly_PPLI_Symbol.material	      = "INDICATION_MFCD_GREEN"
	Friendly_PPLI_Symbol.vertices         = bx(12)
	Friendly_PPLI_Symbol.indices		  = box_ind
	Friendly_PPLI_Symbol.tex_params       = {171 / 512,
	                                         208 / 512,
	                                         2.2 * texture_scale,
	                                         2.2 * texture_scale}	
    Friendly_PPLI_Symbol.parent_element   = Friendly_Symbols_Placer.name
	use_mipfilter(Friendly_PPLI_Symbol)
	Add(Friendly_PPLI_Symbol)
end


Add_SOI_border()

---------------------------------------------------------------
-- OSB 2
--
Label_OSB2             = add_OSB_label(2, "A-G")
Label_OSB2.controllers = {{"declutter"}, {"locked_OSB_status", 2 - 1, -1}, {"tgp_master_mode_is_AG", 0}}

Label_OSB2_Inversed             = add_OSB_label(2, "A-G", false, true)
Label_OSB2_Inversed.controllers = {{"declutter"}, {"locked_OSB_status", 2 - 1, -1}, {"tgp_master_mode_is_AG", 1}}

addOSB_Box(2, {Label_OSB2, Label_OSB2_Inversed})

---------------------------------------------------------------
-- OSB 3
--
Label_OSB3             = add_OSB_label(3, "STBY")
Label_OSB3.controllers = {{"declutter"}, {"locked_OSB_status", 3 - 1, -1}, {"tgp_master_mode_is_STBY", 0}}

Label_OSB3_Inversed             = add_OSB_label(3, "STBY", false, true)
Label_OSB3_Inversed.controllers = {{"declutter"}, {"locked_OSB_status", 3 - 1, -1}, {"tgp_master_mode_is_STBY", 1}}

addOSB_Box(3, {Label_OSB3, Label_OSB3_Inversed})

---------------------------------------------------------------
-- OSB 4
--
Label_OSB4             = add_OSB_label(4, "A-A")
Label_OSB4.controllers = {{"declutter"}, {"locked_OSB_status", 4 - 1, -1}, {"tgp_master_mode_is_AA", 0}}

Label_OSB4_Inversed             = add_OSB_label(4, "A-A", false, true)
Label_OSB4_Inversed.controllers = {{"declutter"}, {"locked_OSB_status", 4 - 1, -1}, {"tgp_master_mode_is_AA", 1}}

addOSB_Box(4, {Label_OSB4, Label_OSB4_Inversed})


txt_power_off							= CreateElement "ceStringPoly"
txt_power_off.name						= "txt_power_off"
txt_power_off.material					= font_MFCD
txt_power_off.alignment					= "CenterCenter"
txt_power_off.UseBackground				= true
txt_power_off.BackgroundMaterial		= MFCD_SOLID_BLACK
txt_power_off.value          			= "TGP OFF"
txt_power_off.init_pos					= {max_pixels_count/2,OSB_positions[19][2] + (OSB_positions[20][2] - OSB_positions[19][2])*0.5,0}
SetLowerLeftCornerOrigin(txt_power_off)
txt_power_off.stringdefs				= predefined_fonts[3]
txt_power_off.controllers				= {{"tgp_power",-1}}
Add(txt_power_off)
use_mipfilter(txt_power_off)

txt_not_timed_out 				 		= Copy(txt_power_off)
txt_not_timed_out.controllers	 		= {{"tgp_power"}, {"tgp_not_timed_out"}}
txt_not_timed_out.value          		= "NOT TIMED OUT"
Add(txt_not_timed_out)

TGP_video_mode = {}

for i = 0, 2 do
	TGP_video_mode[i]						= CreateElement "ceStringPoly"
	TGP_video_mode[i].name					= "TGP_video_mode"..string.format("%d",i)
	TGP_video_mode[i].material				= font_MFCD
	TGP_video_mode[i].alignment				= "RightTop"
	TGP_video_mode[i].stringdefs			= txt_labels_font
	TGP_video_mode[i].UseBackground			= true
	TGP_video_mode[i].BackgroundMaterial	= MFCD_SOLID_BLACK
	TGP_video_mode[i].controllers			= {{"tgp_video_mode", i}}
	TGP_video_mode[i].init_pos           	= {OSB_positions[6][1] + font_1_x - 2, soi_max_y + OSB_symbol_spacing, 0}
	SetLowerLeftCornerOrigin(TGP_video_mode[i])
	Add(TGP_video_mode[i])
	use_mipfilter(TGP_video_mode[i])
end

TGP_video_mode[0].value = "CCD"
TGP_video_mode[1].value = "WHOT"
TGP_video_mode[2].value = "BHOT"

TGP_altitude 						= CreateElement "ceStringPoly"
TGP_altitude.name					= "TGP_altitude"
TGP_altitude.material				= font_MFCD
TGP_altitude.alignment				= "RightTop"
TGP_altitude.stringdefs				= txt_labels_font
TGP_altitude.UseBackground			= true
TGP_altitude.BackgroundMaterial		= MFCD_SOLID_BLACK
TGP_altitude.formats				= {"%.f", "XXXXX"}
TGP_altitude.controllers			= {{"tgp_altitude", 3.2808398950}}
TGP_altitude.init_pos           	= {OSB_positions[6][1] + font_1_x - 2, soi_max_y - 5,0}
SetLowerLeftCornerOrigin(TGP_altitude)
Add(TGP_altitude)
use_mipfilter(TGP_altitude)

TGP_zoom_level						= CreateElement "ceStringPoly"
TGP_zoom_level.name					= "TGP_zoom_level"
TGP_zoom_level.material				= font_MFCD
TGP_zoom_level.alignment			= "LeftTop"
TGP_zoom_level.stringdefs			= txt_labels_font
TGP_zoom_level.UseBackground		= true
TGP_zoom_level.formats				= {" %dZ"}
TGP_zoom_level.controllers			= {{"tgp_zoom_level", 0}}
TGP_zoom_level.BackgroundMaterial	= MFCD_SOLID_BLACK
TGP_zoom_level.init_pos           	= {OSB_positions[20][1] - font_1_x, soi_max_y + OSB_symbol_spacing,0}
SetLowerLeftCornerOrigin(TGP_zoom_level)
Add(TGP_zoom_level)
use_mipfilter(TGP_zoom_level)

TGP_FOV_WIDE					= CreateElement "ceStringPoly"
TGP_FOV_WIDE.name				= "TGP_FOV"
TGP_FOV_WIDE.material			= font_MFCD
TGP_FOV_WIDE.alignment			= "LeftTop"
TGP_FOV_WIDE.stringdefs			= txt_labels_font
TGP_FOV_WIDE.UseBackground		= true
TGP_FOV_WIDE.value				= "WIDE"
TGP_FOV_WIDE.BackgroundMaterial	= MFCD_SOLID_BLACK
TGP_FOV_WIDE.init_pos           = {OSB_positions[20][1] - font_1_x, soi_max_y - 5, 0}
TGP_FOV_WIDE.controllers		= {{"tgp_lss_mode_lss", 0}, {"tgp_FOV", -1}}
SetLowerLeftCornerOrigin(TGP_FOV_WIDE)
Add(TGP_FOV_WIDE)
use_mipfilter(TGP_FOV_WIDE)

TGP_FOV_NARROW 		 = Copy(TGP_FOV_WIDE)
TGP_FOV_NARROW.value = "NARO"
TGP_FOV_NARROW.controllers		= {{"tgp_lss_mode_lss", 0}, {"tgp_FOV", 1}}
Add(TGP_FOV_NARROW)


TGP_FOV_WIDE_LSS					= Copy(TGP_FOV_WIDE)
TGP_FOV_WIDE_LSS.controllers		= {{"tgp_lss_mode_lss"}, {"tgp_FOV", -1}}
TGP_FOV_WIDE_LSS.value				= "WSCH"
Add(TGP_FOV_WIDE_LSS)

TGP_FOV_NARROW_LSS 		 			= Copy(TGP_FOV_WIDE)
TGP_FOV_NARROW_LSS.value 			= "NSCH"
TGP_FOV_NARROW_LSS.controllers		= {{"tgp_lss_mode_lss"}, {"tgp_FOV", 1}}
Add(TGP_FOV_NARROW_LSS)


add_coordinates_field()
--	()
Add_NOT_SOI_display()
