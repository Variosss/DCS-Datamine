dofile(LockOn_Options.script_path.."HUD\\HUD_definitions.lua")

wich_template = 0

local IndicationTexturesPath = LockOn_Options.script_path.."../IndicationTextures/"

if wich_template == 1 then

	template				 = create_HUD_element("ceTexPoly")
	template.name			 = "template"
	template.vertices		 = {{-1.08, -1.08}, {-1.08,  1.08}, {1.08, 1.08}, {1.08, -1.08}}
	template.indices		 = default_box_indices
	template.init_pos		 = {0.0, 0.1, 0}
	template.material        = MakeMaterial(IndicationTexturesPath.."Indication_hud_ka-50_temp.tga", {0,255,0,255})
	template.tex_params		 = {0.18965, 0.15615, 0.28, 0.28}
	template.isdraw			 = true
	Add(template)

	dbg_template_box			   = create_HUD_element("ceMeshPoly")
	dbg_template_box.name		   = "dbg_template_box"
	dbg_template_box.primitivetype = "lines"
	dbg_template_box.vertices	   = {{-1.08, -1.08}, {-1.08,  1.08}, {1.08, 1.08}, {1.08, -1.08}}
	dbg_template_box.indices	   = default_rect_indices
	dbg_template_box.init_pos	   = {0.0, 0.2 - 0.5, 0}
	dbg_template_box.material      = REGIONS_COLOR
	dbg_template_box.isdraw		   = true
	Add(dbg_template_box)

elseif wich_template == 2 then

	template				 = create_HUD_element("ceTexPoly")
	template.name			 = "template"
	template.vertices		 = {{-1.08, -1.08}, {-1.08,  1.08}, {1.08, 1.08}, {1.08, -1.08}}
	template.indices		 = default_box_indices
	template.init_pos		 = {0.0, 0.517 - 0.5, 0}
	template.material        = MakeMaterial(IndicationTexturesPath.."Indication_hud_ka-50_temp2.tga", {0,255,0,255})
	template.tex_params		 = {0.430236, 0.361019, 0.44, 0.44}
	template.isdraw			 = true
	Add(template)

	dbg_template_box			   = create_HUD_element("ceMeshPoly")
	dbg_template_box.name		   = "dbg_template_box"
	dbg_template_box.primitivetype = "lines"
	dbg_template_box.vertices	   = {{-1.08, -1.08}, {-1.08,  1.08}, {1.08, 1.08}, {1.08, -1.08}}
	dbg_template_box.indices	   = default_rect_indices
	dbg_template_box.init_pos	   = {0.0, 0.517 - 0.5, 0}
	dbg_template_box.material      = REGIONS_COLOR
	dbg_template_box.isdraw		   = true
	Add(dbg_template_box)

end

local txt_altitude_offset = 0.41 --0.355

txt_BALT				 = create_HUD_element("ceStringPoly")
txt_BALT.name			 = "txt_BALT"
txt_BALT.material        = "font_Ka-50_HUD"
txt_BALT.init_pos		 = {txt_altitude_offset, 1.03 + vertical_displacement, 0}
txt_BALT.alignment       = "LeftCenter"
txt_BALT.stringdefs      = {0.0073, 0.0073, -0.0007, 0.0}
txt_BALT.formats         = {"%+05.f"}
txt_BALT.controllers     = {{"altitude_txt_source", 1, 300.0}, {"txt_BALT", 0, -9999.0, 9999.0}}
AddWithDefaultClip(txt_BALT)

txt_RALT				 = create_HUD_element("ceStringPoly")
txt_RALT.name			 = "txt_RALT"
txt_RALT.material        = "font_Ka-50_HUD"
txt_RALT.init_pos		 = {txt_altitude_offset, 1.03 + vertical_displacement, 0}
txt_RALT.alignment       = "LeftCenter"
txt_RALT.stringdefs      = {0.0073, 0.0073, -0.0007, 0.0}
txt_RALT.formats         = {"%03.f"}
txt_RALT.controllers     = {{"altitude_txt_source", 2, 300.0}, {"txt_RALT", 0, 0.0, 999.0}}
AddWithDefaultClip(txt_RALT)

txt_RALT_R_symbol				  = create_HUD_element("ceStringPoly")
txt_RALT_R_symbol.name			  = "txt_RALT_R_symbol"
txt_RALT_R_symbol.material        = "font_Ka-50_HUD"
txt_RALT_R_symbol.init_pos		  = {txt_altitude_offset + 0.21, 1.005 + vertical_displacement, 0}
txt_RALT_R_symbol.alignment       = "LeftCenter"
txt_RALT_R_symbol.stringdefs      = {0.0073, 0.0073, 0.0, 0.0}
txt_RALT_R_symbol.value			  = "Р"
txt_RALT_R_symbol.controllers     = {{"altitude_txt_source", 2, 300.0}}
AddWithDefaultClip(txt_RALT_R_symbol)

txt_range				   = create_HUD_element("ceStringPoly")
txt_range.name			   = "txt_range"
txt_range.material		   = "font_Ka-50_HUD"
txt_range.init_pos		   = {0.145, -0.27 + vertical_displacement, 0}
txt_range.alignment        = "RightCenter"
txt_range.stringdefs       = {0.0073, 0.0073, -0.0007, 0.0}
txt_range.formats		   = {"%3.1f"}
txt_range.controllers      = {{"txt_range", 0, 99.9}}
AddWithDefaultClip(txt_range)

txt_V_H						= create_HUD_element("ceStringPoly")
txt_V_H.name				= "txt_V_H"
txt_V_H.material			= "font_Ka-50_HUD"
txt_V_H.init_pos			= {0.0, -0.38 + vertical_displacement, 0}
txt_V_H.alignment			= "CenterCenter"
txt_V_H.stringdefs			= {0.0073, 0.0073, -0.0007, 0.0}
txt_V_H.controllers			= {{"CautionsBlink"}, {"txt_V_H"}}
AddWithDefaultClip(txt_V_H)

txt_info				= create_HUD_element("ceStringPoly")
txt_info.name			= "txt_info"
txt_info.material		= "font_Ka-50_HUD"
txt_info.init_pos		= {0.0, -0.32 + vertical_displacement, 0}
txt_info.alignment		= "CenterTop"
txt_info.value			= "ИКВ\nНВ" --"К\nКУК-1"
txt_info.stringdefs		= {0.0073, 0.0073, -0.0007, 0.0009}
--txt_info.controllers	= {{"scales_reject"}, {"txt_info", 0, -99.0, 99.0}}
txt_info.isdraw			= false
AddWithDefaultClip(txt_info)

underline					= create_HUD_element("ceTexPoly")
underline.name				= "underline"
underline.vertices			= {{-0.01, -0.01}, {-0.01, 0.01}, {0.275, 0.01}, {0.275, -0.01}}
underline.indices			= default_box_indices
underline.init_pos			= {-0.1335, -0.0962, 0}
underline.material			= "INDICATION_HUD_KA50"
underline.tex_params		= {0.33638, 0.09828, tex_scale, tex_scale}
underline.parent_element	= "txt_info"
AddWithDefaultClip(underline)

--[[
underline_region			= create_region(underline, "underline_region")
underline_region.isdraw		= true
Add(underline_region)
--]]
----------------------------------------------------------------------------------------------------------------------------------------
bird_base             = create_HUD_element("ceSimple")
bird_base.name        = "bird_base"
bird_base.init_pos    = bird_position
bird_base.controllers = {{"scales_reject"}, {"PitchBankAvail"}}
Add(bird_base)


bird_mark            = create_HUD_element("ceTexPoly")
bird_mark.name       = "bird_mark"
bird_mark.vertices   = {{-0.16, -0.074}, {-0.16, 0.01}, {0.16, 0.01}, {0.16, -0.074}}
bird_mark.indices    = default_box_indices
bird_mark.material   = "INDICATION_HUD_KA50"
bird_mark.tex_params = {0.39978, 0.00941, tex_scale, tex_scale}
bird_mark.parent_element = bird_base.name
bird_mark.controllers = {{"reverse_bank"}}
AddWithDefaultClip(bird_mark)

bank_scale            = create_HUD_element("ceTexPoly")
bank_scale.name       = "bank_scale"
bank_scale.vertices   = {{-0.37, -0.32}, {-0.37, 0.012}, {0.37, 0.012}, {0.37, -0.32}}
bank_scale.indices    = default_box_indices
bank_scale.parent_element = bird_base.name
bank_scale.material   = "INDICATION_HUD_KA50"
bank_scale.tex_params = {0.59136, 0.00886, tex_scale, tex_scale}
AddWithDefaultClip(bank_scale)

IAS_scale            = create_HUD_element("ceTexPoly")
IAS_scale.name       = "IAS_scale"
IAS_scale.vertices   = {{-0.157, -0.55}, {-0.157, 0.032}, {0.008, 0.032}, {0.008, -0.55}}
IAS_scale.indices    = default_box_indices
IAS_scale.init_pos   = {-0.42, 0.87 + vertical_displacement, 0}
IAS_scale.material   = "INDICATION_HUD_KA50"
IAS_scale.tex_params = {0.32973, 0.03765, tex_scale, tex_scale}
IAS_scale.controllers = {{"scales_reject"}, {"IAS_scale_visibility", 50.0, 1}}
AddWithDefaultClip(IAS_scale)

IAS_index				= create_HUD_element("ceTexPoly")
IAS_index.name			= "IAS_index"
IAS_index.vertices		= {{-0.01, -0.029}, {-0.01, 0.029}, {0.029, 0.029}, {0.029, -0.029}}
IAS_index.indices		= default_box_indices
IAS_index.init_pos		= {0.014, -0.519, 0}
IAS_index.material		= "INDICATION_HUD_KA50"
IAS_index.tex_params	= {0.28433, 0.01772, tex_scale, tex_scale}
IAS_index.controllers	= {{"IAS_index", 0.0000832}}
IAS_index.parent_element = "IAS_scale"
AddWithDefaultClip(IAS_index)

IAS_max_index					= create_HUD_element("ceTexPoly")
IAS_max_index.name				= "IAS_max_index"
IAS_max_index.vertices			= {{-0.007, -0.022}, {-0.007, 0.01}, {0.049, 0.01}, {0.049, -0.022}}
IAS_max_index.indices			= default_box_indices
IAS_max_index.init_pos			= {0.004, -0.519, 0}
IAS_max_index.material			= "INDICATION_HUD_KA50"
IAS_max_index.tex_params		= {0.33583, 0.08389, tex_scale, tex_scale}
IAS_max_index.controllers		= {{"IAS_max_avail"}, {"IAS_max", 0.000084}}
IAS_max_index.parent_element	= "IAS_scale"
AddWithDefaultClip(IAS_max_index)

ralt_scale				= create_HUD_element("ceTexPoly")
ralt_scale.name			= "ralt_scale"
ralt_scale.vertices		= {{-0.045, -0.625}, {-0.045, 0.03}, {0.11, 0.03}, {0.11, -0.625}}
ralt_scale.indices		= default_box_indices
ralt_scale.init_pos		= {0.41, 0.87 + vertical_displacement, 0}
ralt_scale.material		= "INDICATION_HUD_KA50"
ralt_scale.tex_params	= {0.28959, 0.54651, tex_scale, tex_scale}
ralt_scale.controllers  = {{"ralt_scale_visibility", 50.0}}
AddWithDefaultClip(ralt_scale)

ralt_scale_index				= create_HUD_element("ceTexPoly")
ralt_scale_index.name			= "ralt_scale_index"
ralt_scale_index.vertices		= {{-0.029, -0.029}, {-0.029, 0.029}, {0.01, 0.029}, {0.01, -0.029}}
ralt_scale_index.indices		= default_box_indices
ralt_scale_index.init_pos		= {-0.011, -0.6001, 0}
ralt_scale_index.material		= "INDICATION_HUD_KA50"
ralt_scale_index.tex_params		= {0.30759, 0.01772, tex_scale, tex_scale}
ralt_scale_index.controllers	= {{"ralt_index", 0.0, 0.00097}}
ralt_scale_index.parent_element = "ralt_scale"
AddWithDefaultClip(ralt_scale_index)

azimuth_deviation_scale					= create_HUD_element("ceTexPoly")
azimuth_deviation_scale.name			= "azimuth_deviation_scale"
azimuth_deviation_scale.vertices		= {{-0.342, -0.01}, {-0.342, 0.08}, {0.342, 0.08}, {0.342, -0.01}}
azimuth_deviation_scale.indices			= default_box_indices
azimuth_deviation_scale.init_pos		= {0.0,heading_tape_vert_pos + vertical_displacement, 0}
azimuth_deviation_scale.init_rot		= {0.0, 0.0, 0}
azimuth_deviation_scale.material		= "INDICATION_HUD_KA50"
azimuth_deviation_scale.tex_params		= {16.10 / texture_size, 28.19 / texture_size, tex_scale, tex_scale}
azimuth_deviation_scale.controllers		= {{"heading_or_azimuth_deviation_avail", 1}}
AddWithDefaultClip(azimuth_deviation_scale)

local azd_symbol_hor_pos_offset  = 0.331
local azd_symbol_vert_pos_offset = 0.591  - 0.54
local azd_index_vert_pos_offset  = 0.503  - 0.54
local azd30_x_size = 0.043
local azd_symbol_y_size = 0.03

local azd_symbol_x_coord = 11.82
local azd30_y_coord = 29.21


local azd180_x_size  = 0.06
local azd180_y_coord = 30.04

azimuth_deviation_scale_30                  = CreateElement "ceSimple"
azimuth_deviation_scale_30.name				= "azimuth_deviation_scale_30"
azimuth_deviation_scale_30.controllers		= {{"azimuth_deviation_caption_type", 0,math.rad(30.0)}}
azimuth_deviation_scale_30.parent_element   = "azimuth_deviation_scale"
Add(azimuth_deviation_scale_30)

azimuth_deviation_scale_180                 = CreateElement "ceSimple"
azimuth_deviation_scale_180.name			= "azimuth_deviation_scale_180"
azimuth_deviation_scale_180.controllers		= {{"azimuth_deviation_caption_type", 1,math.rad(30.0)}}
azimuth_deviation_scale_180.parent_element  = "azimuth_deviation_scale"
Add(azimuth_deviation_scale_180)


azimuth_deviation_symbol = {}
for i = 1,4 do
    azimuth_deviation_symbol[i]					= create_HUD_element("ceTexPoly")
    azimuth_deviation_symbol[i].vertices		= {{-azd30_x_size, -azd_symbol_y_size},
                                                   {-azd30_x_size,  azd_symbol_y_size},
                                                   { azd30_x_size,  azd_symbol_y_size}, 
                                                   { azd30_x_size, -azd_symbol_y_size}}
    azimuth_deviation_symbol[i].indices			= default_box_indices
    azimuth_deviation_symbol[i].material		= "INDICATION_HUD_KA50"
    
    if i == 1 or i == 3 then
        azimuth_deviation_symbol[i].init_pos			= {-azd_symbol_hor_pos_offset, azd_symbol_vert_pos_offset, 0}
    else
        azimuth_deviation_symbol[i].init_pos			= { azd_symbol_hor_pos_offset, azd_symbol_vert_pos_offset, 0}
    end

    if i < 3            then 
        azimuth_deviation_symbol[i].tex_params		    = {azd_symbol_x_coord / texture_size, azd30_y_coord / texture_size, tex_scale, tex_scale}
        azimuth_deviation_symbol[i].parent_element  	= azimuth_deviation_scale_30.name
    else
        azimuth_deviation_symbol[i].tex_params		    = {azd_symbol_x_coord / texture_size, azd180_y_coord / texture_size, tex_scale, tex_scale}
        azimuth_deviation_symbol[i].parent_element  	= azimuth_deviation_scale_180.name
    end
    
    AddWithDefaultClip(azimuth_deviation_symbol[i])
end

azimuth_deviation_index = {}

for i =1,2 do
    azimuth_deviation_index[i]				    = create_HUD_element("ceTexPoly")
    azimuth_deviation_index[i].vertices		    = {{-0.03, -0.03}, {-0.03, 0.035}, {0.03, 0.035}, {0.03, -0.03}}
    azimuth_deviation_index[i].indices		    = default_box_indices
    azimuth_deviation_index[i].init_pos		    = {0.0, azd_index_vert_pos_offset, 0}
    azimuth_deviation_index[i].init_rot		    = {0.0, 0.0, 0}
    azimuth_deviation_index[i].material		    = "INDICATION_HUD_KA50"
    azimuth_deviation_index[i].tex_params		= {14.75 / texture_size, 1.69 / texture_size, tex_scale, tex_scale}
    if i == 1 then
        azimuth_deviation_index[i].controllers		= {{"azimuth_deviation", 0.051, math.rad(30.0)}}
        azimuth_deviation_index[i].parent_element   = azimuth_deviation_scale_30.name
    else
        azimuth_deviation_index[i].controllers		= {{"azimuth_deviation", 0.051 / 6.0, math.rad(180.0)}}
        azimuth_deviation_index[i].parent_element   = azimuth_deviation_scale_180.name
    end
    AddWithDefaultClip(azimuth_deviation_index[i])

end

pitch_bank_border_size = 0.34
pitch_bank_scale_border1 = create_HUD_element("ceMeshPoly")
pitch_bank_scale_border1.name = "pitch_bank_scale_border1"
pitch_bank_scale_border1.primitivetype = "triangles"
pitch_bank_scale_border1.vertices = {{-pitch_bank_border_size, -pitch_bank_border_size},
									{-pitch_bank_border_size, pitch_bank_border_size},
									{pitch_bank_border_size, pitch_bank_border_size},
									{pitch_bank_border_size, -pitch_bank_border_size}
									}
pitch_bank_scale_border1.indices  = default_box_indices
pitch_bank_scale_border1.init_pos = bird_position
pitch_bank_scale_border1.material = "GREEN_2"
pitch_bank_scale_border1.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
pitch_bank_scale_border1.level			= HUD_DEFAULT_LEVEL
--pitch_bank_scale_border1.isdraw = true
pitch_bank_scale_border1.isvisible = false
pitch_bank_scale_border1.controllers = {{"PitchBankAvail"}}
Add(pitch_bank_scale_border1)


pitch_bank_scale1          = create_HUD_element("ceTexPoly")
pitch_bank_scale1.name     = "pitch_bank_scale1"
pitch_bank_scale1.vertices = {{-0.19, -0.013}, {-0.19, 2.1}, {0.19, 2.1}, {0.19, -0.013}}
pitch_bank_scale1.indices  = default_box_indices
pitch_bank_scale1.init_pos = bird_position
pitch_bank_scale1.material   = "INDICATION_HUD_KA50"
pitch_bank_scale1.tex_params = {0.07281, 0.74169, tex_scale, tex_scale}
pitch_bank_scale1.controllers   = {{"scales_reject"}, {"PitchBankAvail"}, {"pitch", pitch_K}}
pitch_bank_scale1.h_clip_relation = h_clip_relations.COMPARE
pitch_bank_scale1.level = HUD_DEFAULT_LEVEL + 1
Add(pitch_bank_scale1)

pitch_bank_scale2          = create_HUD_element("ceTexPoly")
pitch_bank_scale2.name     = "pitch_bank_scale2"
pitch_bank_scale2.vertices = {{-0.19, 0.013}, {-0.19, -2.1}, {0.19, -2.1}, {0.19, 0.013}}
pitch_bank_scale2.indices  = default_box_indices
pitch_bank_scale2.init_pos = bird_position
pitch_bank_scale2.material   = "INDICATION_HUD_KA50"
pitch_bank_scale2.tex_params = {0.20736, 0.01661, tex_scale, tex_scale}
pitch_bank_scale2.controllers   = {{"scales_reject"}, {"PitchBankAvail"}, {"pitch", pitch_K}}
pitch_bank_scale2.h_clip_relation = h_clip_relations.COMPARE
pitch_bank_scale2.level = HUD_DEFAULT_LEVEL + 1
Add(pitch_bank_scale2)

pitch_bank_border_size = 0.34
pitch_bank_scale_border2 = create_HUD_element("ceMeshPoly")
pitch_bank_scale_border2.name = "pitch_bank_scale_border2"
pitch_bank_scale_border2.primitivetype = "triangles"
pitch_bank_scale_border2.vertices = {{-pitch_bank_border_size, -pitch_bank_border_size},
									{-pitch_bank_border_size, pitch_bank_border_size},
									{pitch_bank_border_size, pitch_bank_border_size},
									{pitch_bank_border_size, -pitch_bank_border_size}
									}
pitch_bank_scale_border2.indices  = default_box_indices
pitch_bank_scale_border2.init_pos = bird_position
pitch_bank_scale_border2.material = "GREEN_2"
pitch_bank_scale_border2.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
pitch_bank_scale_border2.level = HUD_DEFAULT_LEVEL + 1
--pitch_bank_scale_border2.isdraw = true
pitch_bank_scale_border2.isvisible = false
pitch_bank_scale_border2.controllers = {{"PitchBankAvail"}}
Add(pitch_bank_scale_border2)

txtTgtNavFixHorOffset = -0.58

txt_TgtEntry					= create_HUD_element("ceStringPoly")
txt_TgtEntry.name				= "txt_TgtEntry"
txt_TgtEntry.material			= "font_Ka-50_HUD"
txt_TgtEntry.init_pos			= {txtTgtNavFixHorOffset, TA_text_pos_y + (2 * interline) + vertical_displacement, 0}
txt_TgtEntry.alignment			= "RightCenter"
txt_TgtEntry.value				= "ОТ"
txt_TgtEntry.stringdefs			= {0.0073, 0.0073, -0.0007, 0.0009}
txt_TgtEntry.controllers		= {{"TgtEntrySymbAvail"}}
AddWithDefaultClip(txt_TgtEntry)

txt_NavFix						= create_HUD_element("ceStringPoly")
txt_NavFix.name					= "txt_NavFix"
txt_NavFix.material				= "font_Ka-50_HUD"
txt_NavFix.init_pos				= {txtTgtNavFixHorOffset,TA_text_pos_y + (3 * interline) + vertical_displacement, 0}
txt_NavFix.alignment			= "RightCenter"
txt_NavFix.value				= "КОРР"
txt_NavFix.stringdefs			= {0.0073, 0.0073, -0.0007, 0.0009}
txt_NavFix.controllers			= {{"NavFixSymbAvail"}}
AddWithDefaultClip(txt_NavFix)
