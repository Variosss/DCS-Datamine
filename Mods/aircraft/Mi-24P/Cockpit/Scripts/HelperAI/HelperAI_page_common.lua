dofile(LockOn_Options.common_script_path.."elements_defs.lua")



function create_and_add_elements(cross_size, compass_size, is_vr)
--intentionally no indentation
local cross_pos 	= {0, 	  0}
local compass_pos 	= {0, -0.45}

if is_vr then 
	SetCustomScale(1.0)
else 
	SetScale(FOV)
	local total_aspect  = LockOn_Options.screen.aspect
	local total_w 		= LockOn_Options.screen.width
	local total_h 		= LockOn_Options.screen.height
	local ULX,ULY,SZX,SZY,GUI_scale = get_UIMainView()
	
	compass_pos = {-0.75 * total_aspect, -0.5} --relative to screen center, 1 equals screen height afaik
	--viewports stuff	
	local v = find_viewport("GU_MAIN_VIEWPORT", "CENTER")
	if v ~= nil then
		if v.width ~= total_w or v.height ~= total_h then
			ULX = v.x
			ULY = v.y
			SZX = v.width
			SZY = v.height
			local aspect = SZX/SZY
			cross_pos = {(ULX + SZX / 2 - total_w / 2) / total_w * total_aspect * 2, -(ULY + SZY / 2 - total_h / 2) / total_h * 2}
			compass_pos = {cross_pos[1] + compass_pos[1] * SZX / total_w, cross_pos[2] + compass_pos[2] * SZY / total_h}
			cross_size = cross_size * v.height / total_h
			compass_size = compass_size * v.height / total_h
		end
	end
	--end viewports stuff
end


local cross_holder_box_width = cross_size * 0.4
local cross_holder_box_aspect = 0.5

local cross_holder_radius = cross_size * 0.6
local hdg_pos = {0, cross_holder_radius * 0.8} --relative to cross center
local az_pos = {-cross_holder_radius  * 0.70710678118 * 1.2, -cross_holder_radius  * 0.5 * 1.2}
local el_pos = {cross_holder_radius  * 0.70710678118 * 1.2, -cross_holder_radius  * 0.5 * 1.2}

local compass_cross_size = compass_size * 0.22
local compass_base_size = compass_size * 1.075
local compass_marks_size = compass_size * 1.38
local compass_arrow_size = compass_size * 0.25
local compass_holder_box_width = compass_size * 0.22
local compass_holder_box_aspect = 0.5

local compass_holder_box_x = 0.39 * compass_size
local compass_holder_box_y = 0.56 * compass_size
local mode_pos  = {}
if not is_vr then
    mode_pos = {-compass_holder_box_x, -compass_holder_box_y} --relative to compass center
else
    mode_pos = {0, 0.2 * compass_size}
end

local compass_arrow_pos = {0, compass_size * 0.45}

local speed_pos = {-compass_holder_box_x, compass_holder_box_y}
local alt_pos = {compass_holder_box_x, compass_holder_box_y} 
local course_pos = {0, 0.725 * compass_size}

local VR_rotate_angle = 72.0
local VR_add_height = compass_size * 0.06

local course_with_head_width = compass_size * 0.288
local course_with_head_height = compass_size * 0.32

local caption_scale_cross
local caption_scale_compass
if not is_vr then
    caption_scale_cross = cross_size * 0.2
    caption_scale_compass = compass_size  * 0.12
else
    caption_scale_cross = cross_size * 2.2
    caption_scale_compass = compass_size  * 1.6
end

local text_frame_width = compass_size * 0.55 * 1.5
local text_frame_height = compass_size * 0.12 * 1.5

local list_text_scale = caption_scale_compass * 0.8 * 1.5

local cm_frame_width = compass_size * 0.55


local countermeasures_rel_width = 0.2

local common_mat = MakeMaterial("Mods/aircraft/Mi-24P/Cockpit/IndicationTextures/HelperAI_common.dds",{255,255,255,255})

GOST_TABLE  = {class  = "ceUITTF",  ttf = "Mods/aircraft/Mi-24P/Cockpit/IndicationTextures/GOST_BU.TTF", size = 20}
local gost_font   = MakeFont(GOST_TABLE,{255,255,255,255})

local default_tex_coords =	{
								{0, 0},
								{1, 0},
								{1, 1},
								{0, 1},
							}

local function simple_rectangle(wid,hei)
	return	{
				{-wid/2,hei/2},
				{wid/2,hei/2},
				{wid/2,-hei/2},
				{-wid/2,-hei/2},
			}
end

local function simple_square(size)
	return simple_rectangle(size,size)
end


local texture_w = 1024
local texture_h = 1024				
local function minmax_to_coords(min_x, max_x, min_y, max_y)
	return
	{
		{min_x / texture_w, min_y / texture_h},
		{max_x / texture_w, min_y / texture_h},
		{max_x / texture_w, max_y / texture_h},
		{min_x / texture_w, max_y / texture_h},
	}
end

local white_holder_coords	= minmax_to_coords(105, 185, 8, 48)
local yellow_holder_coords	= minmax_to_coords(8, 88, 66, 106)
local red_holder_coords		= minmax_to_coords(297, 377, 8, 48)
local green_holder_coords   = minmax_to_coords(8, 88, 8, 48)
local beige_holder_coords	= minmax_to_coords(201, 281, 8, 48)

local crosshair_coords 		= minmax_to_coords(512, 602, 469, 559)

local circular_bug_coords	= minmax_to_coords(328, 358, 69, 99)
local linear_bug_coords		= minmax_to_coords(260, 292, 73, 93)

local cm_circle_coords		= minmax_to_coords(555, 611, 772, 828)
local cm_bar_coords			= minmax_to_coords(848, 1004, 792, 832)

local function AddElement(elem)
	if not is_vr then
		elem.screenspace		= ScreenType.SCREENSPACE_TRUE
	end
	Add(elem)
end

local 	base_					= CreateElement "ceSimple"
		base_.controllers 		= {{"vr_size_control",compass_pos[2]}}
AddElement(base_)

local crosshair				= CreateElement "ceTexPoly" --center: 557 514, top: 470, side: 590
crosshair.name				= "crosshair"
crosshair.material			= common_mat
crosshair.vertices			= simple_square(cross_size / 2)
crosshair.init_pos			= cross_pos
crosshair.parent_element    = base_.name
crosshair.tex_coords		= crosshair_coords
crosshair.indices			= default_box_indices
if not is_vr then
	crosshair.controllers		= {{"show_crosshair"}}
else
	crosshair.controllers		= {{"show_crosshair_VR"}}
end
AddElement(crosshair)

local hdg_holder_red			= CreateElement "ceTexPoly"
hdg_holder_red.name				= "hdg_holder_red"
hdg_holder_red.material			= common_mat
hdg_holder_red.parent_element 	= crosshair.name
hdg_holder_red.vertices			= simple_rectangle(cross_holder_box_width, cross_holder_box_width * cross_holder_box_aspect)
hdg_holder_red.init_pos			= hdg_pos
hdg_holder_red.tex_coords		= red_holder_coords
hdg_holder_red.indices			= default_box_indices
hdg_holder_red.controllers		= {{"show_hdg_az_el_red"}}
AddElement(hdg_holder_red)

local hdg_holder_yellow				= CreateElement "ceTexPoly"
hdg_holder_yellow.name				= "hdg_holder_yellow"
hdg_holder_yellow.material			= common_mat
hdg_holder_yellow.parent_element 	= crosshair.name
hdg_holder_yellow.vertices			= simple_rectangle(cross_holder_box_width, cross_holder_box_width * cross_holder_box_aspect)
hdg_holder_yellow.init_pos			= hdg_pos
hdg_holder_yellow.tex_coords		= yellow_holder_coords
hdg_holder_yellow.indices			= default_box_indices
hdg_holder_yellow.controllers		= {{"show_hdg_az_el_yellow"}}
AddElement(hdg_holder_yellow)

local hdg_holder_beige				= CreateElement "ceTexPoly"
hdg_holder_beige.name				= "hdg_holder_beige"
hdg_holder_beige.material			= common_mat
hdg_holder_beige.parent_element 	= crosshair.name
hdg_holder_beige.vertices			= simple_rectangle(cross_holder_box_width, cross_holder_box_width * cross_holder_box_aspect)
hdg_holder_beige.init_pos			= hdg_pos
hdg_holder_beige.tex_coords			= beige_holder_coords
hdg_holder_beige.indices			= default_box_indices
hdg_holder_beige.controllers		= {{"show_hdg_az_el_beige"}}
AddElement(hdg_holder_beige)

local hdg_holder_green				= CreateElement "ceTexPoly"
hdg_holder_green.name				= "hdg_holder_green"
hdg_holder_green.material			= common_mat
hdg_holder_green.parent_element 	= crosshair.name
hdg_holder_green.vertices			= simple_rectangle(cross_holder_box_width, cross_holder_box_width * cross_holder_box_aspect)
hdg_holder_green.init_pos			= hdg_pos
hdg_holder_green.tex_coords			= green_holder_coords
hdg_holder_green.indices			= default_box_indices
hdg_holder_green.controllers		= {{"show_hdg_az_el_green"}}
AddElement(hdg_holder_green)

local hdg_text 						= CreateElement "ceStringPoly"
hdg_text.name 						= "hdg_text"
hdg_text.parent_element 			= crosshair.name
hdg_text.init_pos					= hdg_pos
hdg_text.material 					= gost_font
hdg_text.stringdefs 				= {caption_scale_cross * 0.06, caption_scale_cross * 0.06, 0, 0}
hdg_text.alignment 					= "CenterCenter"
hdg_text.controllers 				= {{'hdg_text'}}
AddElement(hdg_text)


local az_holder_red				= CreateElement "ceTexPoly"
az_holder_red.name				= "az_holder_red"
az_holder_red.material			= common_mat
az_holder_red.parent_element 	= crosshair.name
az_holder_red.vertices			= simple_rectangle(cross_holder_box_width, cross_holder_box_width * cross_holder_box_aspect)
az_holder_red.init_pos			= az_pos
az_holder_red.tex_coords		= red_holder_coords
az_holder_red.indices			= default_box_indices
az_holder_red.controllers		= {{"show_hdg_az_el_red"}}
AddElement(az_holder_red)

local az_holder_yellow				= CreateElement "ceTexPoly"
az_holder_yellow.name				= "az_holder_yellow"
az_holder_yellow.material			= common_mat
az_holder_yellow.parent_element 	= crosshair.name
az_holder_yellow.vertices			= simple_rectangle(cross_holder_box_width, cross_holder_box_width * cross_holder_box_aspect)
az_holder_yellow.init_pos			= az_pos
az_holder_yellow.tex_coords			= yellow_holder_coords
az_holder_yellow.indices			= default_box_indices
az_holder_yellow.controllers		= {{"show_hdg_az_el_yellow"}}
AddElement(az_holder_yellow)

local az_holder_beige				= CreateElement "ceTexPoly"
az_holder_beige.name				= "az_holder_beige"
az_holder_beige.material			= common_mat
az_holder_beige.parent_element 		= crosshair.name
az_holder_beige.vertices			= simple_rectangle(cross_holder_box_width, cross_holder_box_width * cross_holder_box_aspect)
az_holder_beige.init_pos			= az_pos
az_holder_beige.tex_coords			= beige_holder_coords
az_holder_beige.indices				= default_box_indices
az_holder_beige.controllers			= {{"show_hdg_az_el_beige"}}
AddElement(az_holder_beige)

local az_holder_green				= CreateElement "ceTexPoly"
az_holder_green.name				= "az_holder_green"
az_holder_green.material			= common_mat
az_holder_green.parent_element 		= crosshair.name
az_holder_green.vertices			= simple_rectangle(cross_holder_box_width, cross_holder_box_width * cross_holder_box_aspect)
az_holder_green.init_pos			= az_pos
az_holder_green.tex_coords			= green_holder_coords
az_holder_green.indices				= default_box_indices
az_holder_green.controllers			= {{"show_hdg_az_el_green"}}
AddElement(az_holder_green)

local az_text 				= CreateElement "ceStringPoly"
az_text.name 				= "az_text"
az_text.parent_element 		= crosshair.name
az_text.init_pos			= az_pos
az_text.material 			= gost_font
az_text.stringdefs 			= {caption_scale_cross * 0.06, caption_scale_cross * 0.06, 0, 0}
az_text.alignment 			= "CenterCenter"
az_text.controllers 		= {{'az_text'}}
AddElement(az_text)

local el_holder_red				= CreateElement "ceTexPoly"
el_holder_red.name				= "el_holder_red"
el_holder_red.material			= common_mat
el_holder_red.parent_element 	= crosshair.name
el_holder_red.vertices			= simple_rectangle(cross_holder_box_width, cross_holder_box_width * cross_holder_box_aspect)
el_holder_red.init_pos			= el_pos
el_holder_red.tex_coords		= red_holder_coords
el_holder_red.indices			= default_box_indices
el_holder_red.controllers		= {{"show_hdg_az_el_red"}}
AddElement(el_holder_red)

local el_holder_yellow				= CreateElement "ceTexPoly"
el_holder_yellow.name				= "el_holder_yellow"
el_holder_yellow.material			= common_mat
el_holder_yellow.parent_element 	= crosshair.name
el_holder_yellow.vertices			= simple_rectangle(cross_holder_box_width, cross_holder_box_width * cross_holder_box_aspect)
el_holder_yellow.init_pos			= el_pos
el_holder_yellow.tex_coords			= yellow_holder_coords
el_holder_yellow.indices			= default_box_indices
el_holder_yellow.controllers		= {{"show_hdg_az_el_yellow"}}
AddElement(el_holder_yellow)

local el_holder_beige				= CreateElement "ceTexPoly"
el_holder_beige.name				= "el_holder_beige"
el_holder_beige.material			= common_mat
el_holder_beige.parent_element 		= crosshair.name
el_holder_beige.vertices			= simple_rectangle(cross_holder_box_width, cross_holder_box_width * cross_holder_box_aspect)
el_holder_beige.init_pos			= el_pos
el_holder_beige.tex_coords			= beige_holder_coords
el_holder_beige.indices				= default_box_indices
el_holder_beige.controllers			= {{"show_hdg_az_el_beige"}}
AddElement(el_holder_beige)

local el_holder_green				= CreateElement "ceTexPoly"
el_holder_green.name				= "el_holder_green"
el_holder_green.material			= common_mat
el_holder_green.parent_element 		= crosshair.name
el_holder_green.vertices			= simple_rectangle(cross_holder_box_width, cross_holder_box_width * cross_holder_box_aspect)
el_holder_green.init_pos			= el_pos
el_holder_green.tex_coords			= green_holder_coords
el_holder_green.indices				= default_box_indices
el_holder_green.controllers			= {{"show_hdg_az_el_green"}}
AddElement(el_holder_green)

local el_text 			= CreateElement "ceStringPoly"
el_text.name 			= "el_text"
el_text.parent_element 	= crosshair.name
el_text.init_pos		= el_pos
el_text.material 		= gost_font
el_text.stringdefs 		= {caption_scale_cross * 0.06, caption_scale_cross * 0.06, 0, 0}
el_text.alignment 		= "CenterCenter"
el_text.controllers 	= {{'el_text'}}
AddElement(el_text)

local countermeasures_pos = {}
countermeasures_pos[1] = compass_pos[1]
countermeasures_pos[2] = compass_pos[2]

if not is_vr then 
	countermeasures_pos[1] = countermeasures_pos[1] * 1.1
end

local countermeasures_frame				= CreateElement "ceTexPoly"
countermeasures_frame.name				= "countermeasures_frame"
countermeasures_frame.material			= common_mat
countermeasures_frame.vertices			= { --TAK HADO, DO NOT COPY!!!
											{ cm_frame_width/2, -cm_frame_width*(555-1016)/(852-1016)/2},
											{ cm_frame_width/2,  cm_frame_width*(555-1016)/(852-1016)/2},
											{-cm_frame_width/2,  cm_frame_width*(555-1016)/(852-1016)/2},
											{-cm_frame_width/2, -cm_frame_width*(555-1016)/(852-1016)/2},
										}
countermeasures_frame.init_pos			= countermeasures_pos
countermeasures_frame.tex_coords		= minmax_to_coords(555, 1016, 852, 1016)
countermeasures_frame.parent_element	= base_.name
countermeasures_frame.indices			= default_box_indices
if not is_vr then
	countermeasures_frame.controllers		= {{"show_countermeasures"}}
else
	countermeasures_frame.controllers		= {{"show_countermeasures_VR"}}
end
AddElement(countermeasures_frame)

local countermeasures_interval_circle				= CreateElement "ceTexPoly"
countermeasures_interval_circle.name				= "countermeasures_interval_circle"
countermeasures_interval_circle.parent_element		= countermeasures_frame.name		
countermeasures_interval_circle.material			= common_mat
countermeasures_interval_circle.vertices			= simple_square(cm_frame_width * 0.35)
countermeasures_interval_circle.init_pos			= {0, cm_frame_width*(555-1016)/(852-1016) * 0.345}
countermeasures_interval_circle.tex_coords			= cm_circle_coords
countermeasures_interval_circle.indices				= default_box_indices
AddElement(countermeasures_interval_circle)

local function tricky_vertices(wid, hei)
	return	{
				{0,hei/2},
				{-wid,hei/2},
				{-wid,-hei/2},
				{0,-hei/2},
			}
end

local cm_cbug_size = 0.17

local countermeasures_interval_bug				= CreateElement "ceTexPoly"
countermeasures_interval_bug.name				= "countermeasures_interval_bug"
countermeasures_interval_bug.parent_element		= countermeasures_interval_circle.name
countermeasures_interval_bug.material			= common_mat
countermeasures_interval_bug.vertices			= tricky_vertices(cm_cbug_size * cm_frame_width, cm_cbug_size * cm_frame_width)
countermeasures_interval_bug.tex_coords			= circular_bug_coords
countermeasures_interval_bug.indices			= default_box_indices
countermeasures_interval_bug.controllers		= {{"countermeasures_interval_bug"}}
AddElement(countermeasures_interval_bug)

local countermeasures_interval_caption			= CreateElement "ceStringPoly"
countermeasures_interval_caption.name			= "countermeasures_interval_caption"
countermeasures_interval_caption.parent_element	= countermeasures_frame.name	
countermeasures_interval_caption.init_pos		= {0, 0.45 * cm_frame_width * 2.83536585366}
countermeasures_interval_caption.value			= "INTERVAL"
countermeasures_interval_caption.material		= gost_font
countermeasures_interval_caption.stringdefs		= {caption_scale_cross * 0.05, caption_scale_cross * 0.05, 0, 0}
countermeasures_interval_caption.alignment		= "CenterCenter"
AddElement(countermeasures_interval_caption)

local countermeasures_interval_2				= CreateElement "ceStringPoly"
countermeasures_interval_2.name					= "countermeasures_interval_2"
countermeasures_interval_2.parent_element		= countermeasures_frame.name	
countermeasures_interval_2.init_pos				= {-0.29 * cm_frame_width, 0.35 * cm_frame_width * 2.83536585366}
countermeasures_interval_2.value				= "2"
countermeasures_interval_2.material				= gost_font
countermeasures_interval_2.stringdefs			= {caption_scale_cross * 0.05, caption_scale_cross * 0.05, 0, 0}
countermeasures_interval_2.alignment			= "CenterCenter"
AddElement(countermeasures_interval_2)

local countermeasures_interval_4				= CreateElement "ceStringPoly"
countermeasures_interval_4.name					= "countermeasures_interval_4"
countermeasures_interval_4.parent_element		= countermeasures_frame.name	
countermeasures_interval_4.init_pos				= {0.29 * cm_frame_width, 0.35 * cm_frame_width * 2.83536585366}
countermeasures_interval_4.value				= "4"
countermeasures_interval_4.material				= gost_font
countermeasures_interval_4.stringdefs			= {caption_scale_cross * 0.05, caption_scale_cross * 0.05, 0, 0}
countermeasures_interval_4.alignment			= "CenterCenter"
AddElement(countermeasures_interval_4)

local countermeasures_series_circle					= CreateElement "ceTexPoly"
countermeasures_series_circle.name					= "countermeasures_series_circle"
countermeasures_series_circle.parent_element		= countermeasures_frame.name	
countermeasures_series_circle.material				= common_mat
countermeasures_series_circle.vertices				= simple_square(cm_frame_width * 0.35)
countermeasures_series_circle.init_pos				= {0, cm_frame_width*(555-1016)/(852-1016) * 0.1225}
countermeasures_series_circle.tex_coords			= cm_circle_coords
countermeasures_series_circle.indices				= default_box_indices
AddElement(countermeasures_series_circle)

local countermeasures_series_bug			= CreateElement "ceTexPoly"
countermeasures_series_bug.name				= "countermeasures_series_bug"
countermeasures_series_bug.parent_element	= countermeasures_series_circle.name
countermeasures_series_bug.material			= common_mat
countermeasures_series_bug.vertices			= tricky_vertices(cm_cbug_size * cm_frame_width, cm_cbug_size * cm_frame_width)
countermeasures_series_bug.tex_coords		= circular_bug_coords
countermeasures_series_bug.indices			= default_box_indices
countermeasures_series_bug.controllers		= {{"countermeasures_series_bug"}}
AddElement(countermeasures_series_bug)

local countermeasures_series_caption				= CreateElement "ceStringPoly"
countermeasures_series_caption.name					= "countermeasures_series_caption"
countermeasures_series_caption.parent_element		= countermeasures_frame.name	
countermeasures_series_caption.init_pos				= {0, 0.225 * cm_frame_width * 2.83536585366}
countermeasures_series_caption.value				= "SERIES"
countermeasures_series_caption.material				= gost_font
countermeasures_series_caption.stringdefs			= {caption_scale_cross * 0.05, caption_scale_cross * 0.05, 0, 0}
countermeasures_series_caption.alignment			= "CenterCenter"
AddElement(countermeasures_series_caption)

local countermeasures_series_4				= CreateElement "ceStringPoly"
countermeasures_series_4.name				= "countermeasures_series_4"
countermeasures_series_4.parent_element		= countermeasures_frame.name	
countermeasures_series_4.init_pos			= {-0.29 * cm_frame_width, 0.124 * cm_frame_width * 2.83536585366}
countermeasures_series_4.value				= "4"
countermeasures_series_4.material			= gost_font
countermeasures_series_4.stringdefs			= {caption_scale_cross * 0.05, caption_scale_cross * 0.05, 0, 0}
countermeasures_series_4.alignment			= "CenterCenter"
AddElement(countermeasures_series_4)

local countermeasures_series_16				= CreateElement "ceStringPoly"
countermeasures_series_16.name				= "countermeasures_series_16"
countermeasures_series_16.parent_element	= countermeasures_frame.name	
countermeasures_series_16.init_pos			= {0.29 * cm_frame_width, 0.124 * cm_frame_width * 2.83536585366}
countermeasures_series_16.value				= "16"
countermeasures_series_16.material			= gost_font
countermeasures_series_16.stringdefs		= {caption_scale_cross * 0.05, caption_scale_cross * 0.05, 0, 0}
countermeasures_series_16.alignment			= "CenterCenter"
AddElement(countermeasures_series_16)

local cm_lbug_bar_size = cm_frame_width * 0.95
local cm_lbug_bar_aspect = 40/156

local countermeasures_side_bar					= CreateElement "ceTexPoly"
countermeasures_side_bar.name					= "countermeasures_side_bar"
countermeasures_side_bar.parent_element			= countermeasures_frame.name	
countermeasures_side_bar.material				= common_mat
countermeasures_side_bar.vertices				= simple_rectangle(cm_lbug_bar_size, cm_lbug_bar_size * cm_lbug_bar_aspect)
countermeasures_side_bar.init_pos				= {0, cm_frame_width * (555-1016)/(852-1016) * -0.09}
countermeasures_side_bar.tex_coords				= cm_bar_coords
countermeasures_side_bar.indices				= default_box_indices
AddElement(countermeasures_side_bar)

local cm_lbug_size = cm_frame_width * 0.2
local cm_lbug_aspect = 20/32

local countermeasures_side_bug				= CreateElement "ceTexPoly"
countermeasures_side_bug.name				= "countermeasures_side_bug"
countermeasures_side_bug.parent_element		= countermeasures_side_bar.name
countermeasures_side_bug.material			= common_mat
countermeasures_side_bug.vertices			= simple_rectangle(cm_lbug_size, cm_lbug_size * cm_lbug_aspect)
countermeasures_side_bug.tex_coords			= linear_bug_coords
countermeasures_side_bug.indices			= default_box_indices
countermeasures_side_bug.controllers		= {{"countermeasures_side_bug", 0.32 * cm_frame_width}}
AddElement(countermeasures_side_bug)

local countermeasures_side_caption				= CreateElement "ceStringPoly"
countermeasures_side_caption.name					= "countermeasures_side_caption"
countermeasures_side_caption.parent_element		= countermeasures_frame.name	
countermeasures_side_caption.init_pos				= {0, 0 * cm_frame_width * 2.83536585366}
countermeasures_side_caption.value				= "SIDE"
countermeasures_side_caption.material				= gost_font
countermeasures_side_caption.stringdefs			= {caption_scale_cross * 0.05, caption_scale_cross * 0.05, 0, 0}
countermeasures_side_caption.alignment			= "CenterCenter"
AddElement(countermeasures_side_caption)

local countermeasures_side_left				= CreateElement "ceStringPoly"
countermeasures_side_left.name					= "countermeasures_side_left"
countermeasures_side_left.parent_element		= countermeasures_frame.name	
countermeasures_side_left.init_pos				= {-0.32 * cm_frame_width, -0.1725 * cm_frame_width * 2.83536585366}
countermeasures_side_left.value				= "LH"
countermeasures_side_left.material				= gost_font
countermeasures_side_left.stringdefs			= {caption_scale_cross * 0.05, caption_scale_cross * 0.05, 0, 0}
countermeasures_side_left.alignment			= "CenterCenter"
AddElement(countermeasures_side_left)

local countermeasures_side_both				= CreateElement "ceStringPoly"
countermeasures_side_both.name					= "countermeasures_side_both"
countermeasures_side_both.parent_element		= countermeasures_frame.name	
countermeasures_side_both.init_pos				= {0 * cm_frame_width, -0.1725 * cm_frame_width * 2.83536585366}
countermeasures_side_both.value				= "BOTH"
countermeasures_side_both.material				= gost_font
countermeasures_side_both.stringdefs			= {caption_scale_cross * 0.05, caption_scale_cross * 0.05, 0, 0}
countermeasures_side_both.alignment			= "CenterCenter"
AddElement(countermeasures_side_both)


local countermeasures_side_right				= CreateElement "ceStringPoly"
countermeasures_side_right.name					= "countermeasures_side_right"
countermeasures_side_right.parent_element		= countermeasures_frame.name	
countermeasures_side_right.init_pos				= {0.32 * cm_frame_width, -0.1725 * cm_frame_width * 2.83536585366}
countermeasures_side_right.value				= "RH"
countermeasures_side_right.material				= gost_font
countermeasures_side_right.stringdefs			= {caption_scale_cross * 0.05, caption_scale_cross * 0.05, 0, 0}
countermeasures_side_right.alignment			= "CenterCenter"
AddElement(countermeasures_side_right)

local countermeasures_type_bar					= CreateElement "ceTexPoly"
countermeasures_type_bar.name					= "countermeasures_type_bar"
countermeasures_type_bar.parent_element			= countermeasures_frame.name	
countermeasures_type_bar.material				= common_mat
countermeasures_type_bar.vertices				= simple_rectangle(cm_lbug_bar_size, cm_lbug_bar_size * cm_lbug_bar_aspect)
countermeasures_type_bar.init_pos				= {0, cm_frame_width * (555-1016)/(852-1016) * -0.36}
countermeasures_type_bar.tex_coords				= cm_bar_coords
countermeasures_type_bar.indices				= default_box_indices
AddElement(countermeasures_type_bar)

local countermeasures_type_bug				= CreateElement "ceTexPoly"
countermeasures_type_bug.name				= "countermeasures_type_bug"
countermeasures_type_bug.parent_element		= countermeasures_type_bar.name
countermeasures_type_bug.material			= common_mat
countermeasures_type_bug.vertices			= simple_rectangle(cm_lbug_size, cm_lbug_size * cm_lbug_aspect)
countermeasures_type_bug.tex_coords			= linear_bug_coords
countermeasures_type_bug.indices			= default_box_indices
countermeasures_type_bug.controllers		= {{"countermeasures_type_bug", 0.32 * cm_frame_width}}
AddElement(countermeasures_type_bug)

local countermeasures_type_caption				= CreateElement "ceStringPoly"
countermeasures_type_caption.name					= "countermeasures_type_caption"
countermeasures_type_caption.parent_element		= countermeasures_frame.name	
countermeasures_type_caption.init_pos				= {0, -0.25 * cm_frame_width * 2.83536585366}
countermeasures_type_caption.value				= "TYPE"
countermeasures_type_caption.material				= gost_font
countermeasures_type_caption.stringdefs			= {caption_scale_cross * 0.05, caption_scale_cross * 0.05, 0, 0}
countermeasures_type_caption.alignment			= "CenterCenter"
AddElement(countermeasures_type_caption)

local countermeasures_type_flare				= CreateElement "ceStringPoly"
countermeasures_type_flare.name					= "countermeasures_type_flare"
countermeasures_type_flare.parent_element		= countermeasures_frame.name	
countermeasures_type_flare.init_pos				= {-0.28 * cm_frame_width, -0.43 * cm_frame_width * 2.83536585366}
countermeasures_type_flare.value				= "FLARE"
countermeasures_type_flare.material				= gost_font
countermeasures_type_flare.stringdefs			= {caption_scale_cross * 0.05, caption_scale_cross * 0.05, 0, 0}
countermeasures_type_flare.alignment			= "CenterCenter"
AddElement(countermeasures_type_flare)

local countermeasures_type_chaff				= CreateElement "ceStringPoly"
countermeasures_type_chaff.name					= "countermeasures_type_chaff"
countermeasures_type_chaff.parent_element		= countermeasures_frame.name	
countermeasures_type_chaff.init_pos				= {0.28 * cm_frame_width, -0.43 * cm_frame_width * 2.83536585366}
countermeasures_type_chaff.value				= "CHAFF"
countermeasures_type_chaff.material				= gost_font
countermeasures_type_chaff.stringdefs			= {caption_scale_cross * 0.05, caption_scale_cross * 0.05, 0, 0}
countermeasures_type_chaff.alignment			= "CenterCenter"
AddElement(countermeasures_type_chaff)

--[[
local countermeasures_type_mix				= CreateElement "ceStringPoly"
countermeasures_type_mix.name					= "countermeasures_type_mix"
countermeasures_type_mix.parent_element		= countermeasures_frame.name	
countermeasures_type_mix.init_pos				= {0.32 * cm_frame_width, -0.43 * cm_frame_width * 2.83536585366}
countermeasures_type_mix.value				= "MIX"
countermeasures_type_mix.material				= gost_font
countermeasures_type_mix.stringdefs			= {caption_scale_cross * 0.035, caption_scale_cross * 0.04, 0, 0}
countermeasures_type_mix.alignment			= "CenterCenter"
AddElement(countermeasures_type_mix)
]]

--:|||:
--:|/\/\/\/\/\/\|:
--:|||:

local compass_cross				= CreateElement "ceTexPoly"
compass_cross.name				= "compass_cross"
compass_cross.material			= common_mat
compass_cross.vertices			= simple_square(compass_cross_size) --simple_rectangle(compass_cross_size, compass_cross_size * (236-310)/(523-593)) --simple_square(compass_cross_size)
compass_cross.init_pos			= compass_pos
compass_cross.tex_coords		= minmax_to_coords(523, 593, 232, 310)
compass_cross.indices			= default_box_indices
compass_cross.parent_element	= base_.name
if not is_vr then
	compass_cross.controllers		= {{"show_compass"}}
else
	compass_cross.controllers		= {{"show_compass_VR", VR_rotate_angle}}
end
AddElement(compass_cross)

local compass_base				= CreateElement "ceTexPoly"
compass_base.name				= "compass_base"
compass_base.material			= common_mat
compass_base.parent_element 	= compass_cross.name
compass_base.vertices			= simple_square(compass_base_size)
compass_base.tex_coords			= minmax_to_coords(656, 1016, 400, 760)
compass_base.indices			= default_box_indices
compass_base.controllers		= {{"rotate_compass_base"}}
AddElement(compass_base)

local compass_scale				= CreateElement "ceTexPoly"
compass_scale.name				= "compass_scale"
compass_scale.material			= common_mat
compass_scale.parent_element 	= compass_cross.name
compass_scale.vertices			= simple_square(compass_size)
compass_scale.tex_coords		= minmax_to_coords(681, 1016, 8, 343)
compass_scale.indices			= default_box_indices
compass_scale.controllers		= {{"rotate_compass_scale"}}
AddElement(compass_scale)

local compass_arrow				= CreateElement "ceTexPoly"
compass_arrow.name				= "compass_arrow"
compass_arrow.parent_element 	= compass_cross.name
compass_arrow.material			= common_mat
compass_arrow.vertices			= simple_square(compass_arrow_size)
compass_arrow.init_pos			= compass_arrow_pos
compass_arrow.tex_coords		= minmax_to_coords(523, 590, 352, 419)
compass_arrow.indices			= default_box_indices
AddElement(compass_arrow)

local compass_marks_white			= CreateElement "ceTexPoly" --center x: 244 center y: 325 half-size: 230
compass_marks_white.name			= "compass_marks_white"
compass_marks_white.material		= common_mat
compass_marks_white.parent_element 	= compass_cross.name
compass_marks_white.vertices		= {
										{-compass_marks_size/2,  compass_marks_size*(325-125)/230/2},
										{ compass_marks_size/2,  compass_marks_size*(325-125)/230/2},
										{ compass_marks_size/2, -compass_marks_size*(551-325)/230/2},
										{-compass_marks_size/2, -compass_marks_size*(551-325)/230/2},
									}
compass_marks_white.tex_coords		= minmax_to_coords(14, 474, 125, 551)
compass_marks_white.indices			= default_box_indices
compass_marks_white.controllers		= {{"show_compass_marks_white"}}
AddElement(compass_marks_white)

local compass_marks_yellow				= CreateElement "ceTexPoly" --center x: 244 center y: 787 half-size: 230
compass_marks_yellow.name				= "compass_marks_yellow"
compass_marks_yellow.material			= common_mat
compass_marks_yellow.parent_element 	= compass_cross.name
compass_marks_yellow.vertices			= {
										{-compass_marks_size/2,  compass_marks_size*(787-588)/230/2},
										{ compass_marks_size/2,  compass_marks_size*(787-588)/230/2},
										{ compass_marks_size/2, -compass_marks_size*(1014-787)/230/2},
										{-compass_marks_size/2, -compass_marks_size*(1014-787)/230/2},
									}
compass_marks_yellow.tex_coords			= minmax_to_coords(14, 474, 588, 1014)
compass_marks_yellow.indices			= default_box_indices
compass_marks_yellow.controllers		= {{"show_compass_marks_yellow"}}
AddElement(compass_marks_yellow)


local mode_holder_white				= CreateElement "ceTexPoly"
mode_holder_white.name				= "mode_holder_white"
mode_holder_white.material			= common_mat
mode_holder_white.parent_element 	= compass_cross.name
mode_holder_white.vertices			= simple_rectangle(compass_holder_box_width, compass_holder_box_width * compass_holder_box_aspect)
mode_holder_white.init_pos			= mode_pos
mode_holder_white.tex_coords		= white_holder_coords
mode_holder_white.indices			= default_box_indices
mode_holder_white.controllers		= {{'show_mode_holder_white'}}
AddElement(mode_holder_white)

local mode_holder_yellow			= CreateElement "ceTexPoly"
mode_holder_yellow.name				= "mode_holder_yellow"
mode_holder_yellow.material			= common_mat
mode_holder_yellow.parent_element 	= compass_cross.name
mode_holder_yellow.vertices			= simple_rectangle(compass_holder_box_width, compass_holder_box_width * compass_holder_box_aspect)
mode_holder_yellow.init_pos			= mode_pos
mode_holder_yellow.tex_coords		= yellow_holder_coords
mode_holder_yellow.indices			= default_box_indices
mode_holder_yellow.controllers		= {{'show_mode_holder_yellow'}}
AddElement(mode_holder_yellow)

local mode_text = CreateElement "ceStringPoly"
mode_text.name = "mode_text"
mode_text.parent_element = compass_cross.name
mode_text.material = gost_font
mode_text.stringdefs = {caption_scale_compass * 0.05, caption_scale_compass * 0.05, 0, 0}
mode_text.init_pos			= mode_pos
mode_text.alignment = "CenterCenter"
mode_text.controllers = {{'mode_text'}}
AddElement(mode_text)

local speed_holder_yellow 			= CreateElement "ceTexPoly"
speed_holder_yellow.name			= "speed_holder_yellow"
speed_holder_yellow.material		= common_mat
speed_holder_yellow.parent_element 	= compass_cross.name
speed_holder_yellow.vertices		= simple_rectangle(compass_holder_box_width, compass_holder_box_width * compass_holder_box_aspect)
speed_holder_yellow.init_pos		= speed_pos
speed_holder_yellow.tex_coords		= yellow_holder_coords
speed_holder_yellow.indices			= default_box_indices
speed_holder_yellow.controllers		= {{"show_speed_holder_yellow", VR_rotate_angle, VR_add_height}}
AddElement(speed_holder_yellow)

local speed_holder_white 			= CreateElement "ceTexPoly"
speed_holder_white.name				= "speed_holder_white"
speed_holder_white.material			= common_mat
speed_holder_white.parent_element 	= compass_cross.name
speed_holder_white.vertices			= simple_rectangle(compass_holder_box_width, compass_holder_box_width * compass_holder_box_aspect)
speed_holder_white.init_pos			= speed_pos
speed_holder_white.tex_coords		= white_holder_coords
speed_holder_white.indices			= default_box_indices
speed_holder_white.controllers		= {{"show_speed_holder_white", VR_rotate_angle, VR_add_height}}
AddElement(speed_holder_white)

local speed_text 				= CreateElement "ceStringPoly"
speed_text.name 				= "speed_text"
speed_text.parent_element 		= compass_cross.name
speed_text.material 			= gost_font
speed_text.init_pos 			= speed_pos
speed_text.stringdefs 			= {caption_scale_compass * 0.05, caption_scale_compass * 0.05, 0, 0}
speed_text.alignment 			= "CenterCenter"
speed_text.controllers 			= {{'speed_text', VR_rotate_angle, VR_add_height}}
AddElement(speed_text)

local speed_text_top 			= CreateElement "ceStringPoly"
speed_text_top.name 			= "speed_text_top"
speed_text_top.parent_element 	= speed_text.name
speed_text_top.material 		= gost_font
speed_text_top.init_pos 		= {0, compass_holder_box_width * compass_holder_box_aspect}
speed_text_top.stringdefs 		= {caption_scale_compass * 0.04, caption_scale_compass * 0.04, 0, 0}
speed_text_top.alignment 		= "CenterCenter"
speed_text_top.value 			= "IAS"
AddElement(speed_text_top)

local alt_holder_yellow 			= CreateElement "ceTexPoly"
alt_holder_yellow.name				= "alt_holder_yellow"
alt_holder_yellow.material			= common_mat
alt_holder_yellow.parent_element 	= compass_cross.name
alt_holder_yellow.vertices			= simple_rectangle(compass_holder_box_width, compass_holder_box_width * compass_holder_box_aspect)
alt_holder_yellow.init_pos			= alt_pos
alt_holder_yellow.tex_coords		= yellow_holder_coords
alt_holder_yellow.indices			= default_box_indices
alt_holder_yellow.controllers		= {{"show_alt_holder_yellow", VR_rotate_angle, VR_add_height}}
AddElement(alt_holder_yellow)

local alt_holder_white 				= CreateElement "ceTexPoly"
alt_holder_white.name				= "alt_holder_white"
alt_holder_white.material			= common_mat
alt_holder_white.parent_element 	= compass_cross.name
alt_holder_white.vertices			= simple_rectangle(compass_holder_box_width, compass_holder_box_width * compass_holder_box_aspect)
alt_holder_white.init_pos			= alt_pos
alt_holder_white.tex_coords			= white_holder_coords
alt_holder_white.indices			= default_box_indices
alt_holder_white.controllers		= {{"show_alt_holder_white", VR_rotate_angle, VR_add_height}}
AddElement(alt_holder_white)

local alt_text 				= CreateElement "ceStringPoly"
alt_text.name 				= "alt_text"
alt_text.parent_element 	= compass_cross.name
alt_text.material 			= gost_font
alt_text.init_pos 			= alt_pos
alt_text.stringdefs 		= {caption_scale_compass * 0.05, caption_scale_compass * 0.05, 0, 0}
alt_text.alignment 			= "CenterCenter"
alt_text.controllers 		= {{'alt_text', VR_rotate_angle, VR_add_height}}
AddElement(alt_text)

local alt_add_text 			= CreateElement "ceStringPoly"
alt_add_text.name 			= "alt_add_text"
alt_add_text.parent_element = alt_text.name
alt_add_text.material 		= gost_font
alt_add_text.init_pos 		= {compass_holder_box_width * 0.6, 0}
alt_add_text.stringdefs 	= {caption_scale_compass * 0.05, caption_scale_compass * 0.05, 0, 0}
alt_add_text.alignment 		= "LeftCenter"
alt_add_text.controllers 	= {{'alt_add_text'}}
AddElement(alt_add_text)

local alt_text_top 			= CreateElement "ceStringPoly"
alt_text_top.name 			= "alt_text_top"
alt_text_top.parent_element = alt_text.name
alt_text_top.material 		= gost_font
alt_text_top.init_pos 		= {0, compass_holder_box_width * compass_holder_box_aspect}
alt_text_top.stringdefs 	= {caption_scale_compass * 0.04, caption_scale_compass * 0.04, 0, 0}
alt_text_top.alignment 		= "CenterCenter"
alt_text_top.value 			= "ALT"
AddElement(alt_text_top)

local course_holder_white 			= CreateElement "ceTexPoly"
course_holder_white.name			= "course_holder_white"
course_holder_white.material		= common_mat
course_holder_white.parent_element 	= compass_cross.name
course_holder_white.vertices		= simple_rectangle(compass_holder_box_width, compass_holder_box_width * compass_holder_box_aspect)
course_holder_white.init_pos		= course_pos
course_holder_white.tex_coords		= white_holder_coords
course_holder_white.indices			= default_box_indices
if is_vr then
	course_holder_white.controllers 	= {{'vr_rotate_move', VR_rotate_angle, VR_add_height}}
end
AddElement(course_holder_white)

local course_text 				= CreateElement "ceStringPoly"
course_text.name 				= "course_text"
course_text.parent_element 		= compass_cross.name
course_text.material 			= gost_font
course_text.init_pos 			= course_pos
course_text.stringdefs 			= {caption_scale_compass * 0.05, caption_scale_compass * 0.05, 0, 0}
course_text.alignment 			= "CenterCenter"
course_text.controllers 		= {{'course_text', VR_rotate_angle, VR_add_height}}
AddElement(course_text)

local course_with_head 			= CreateElement "ceTexPoly"
course_with_head.name			= "course_with_head"
course_with_head.material		= common_mat
course_with_head.vertices		= simple_rectangle(course_with_head_width, course_with_head_height)
course_with_head.init_pos		= cross_pos
course_with_head.parent_element	= base_.name
course_with_head.tex_coords		= minmax_to_coords(524, 590, 343, 428)
course_with_head.indices		= default_box_indices
if not is_vr then
	course_with_head.controllers		= {{"course_with_head"}}
else
	course_with_head.controllers		= {{"course_with_head_VR"}}
end
AddElement(course_with_head)


local middle_list_holder 			= CreateElement "ceTexPoly"
middle_list_holder.name				= "middle_list_holder"
middle_list_holder.material			= common_mat
middle_list_holder.vertices			= simple_rectangle(text_frame_width, text_frame_height * 5)
middle_list_holder.init_pos			= compass_pos
middle_list_holder.parent_element	= base_.name
middle_list_holder.tex_coords		= minmax_to_coords(503, 663, 0, 190)
middle_list_holder.indices			= default_box_indices
if not is_vr then
	middle_list_holder.controllers		= {{"show_list"}}
else
	middle_list_holder.controllers		= {{"show_list_VR"}}
end
AddElement(middle_list_holder)


local text_defs = {list_text_scale * 0.045, list_text_scale * 0.045, 0, 0}

local middle_list_text 			= CreateElement "ceStringPoly"
middle_list_text.name 			= "middle_list_text"
middle_list_text.parent_element = middle_list_holder.name
middle_list_text.material 		= gost_font
middle_list_text.stringdefs 	= text_defs
middle_list_text.alignment 		= "CenterCenter"
middle_list_text.controllers 	= {{'middle_list_text'}}
AddElement(middle_list_text)

local upper_upper_list_text 			= CreateElement "ceStringPoly"
upper_upper_list_text.name 				= "upper_upper_list_text"
upper_upper_list_text.parent_element 	= middle_list_text.name
upper_upper_list_text.material 			= gost_font
upper_upper_list_text.stringdefs 		= text_defs
upper_upper_list_text.init_pos			= {0, text_frame_height*2}
upper_upper_list_text.alignment 		= "CenterCenter"
upper_upper_list_text.controllers 		= {{'upper_upper_list_text'}}
AddElement(upper_upper_list_text)

local upper_list_text 					= CreateElement "ceStringPoly"
upper_list_text.name 					= "upper_list_text"
upper_list_text.parent_element 			= middle_list_text.name
upper_list_text.material 				= gost_font
upper_list_text.stringdefs 				= text_defs
upper_list_text.init_pos				= {0, text_frame_height}
upper_list_text.alignment 				= "CenterCenter"
upper_list_text.controllers 			= {{'upper_list_text'}}
AddElement(upper_list_text)

local lower_list_text 					= CreateElement "ceStringPoly"
lower_list_text.name 					= "lower_list_text"
lower_list_text.parent_element 			= middle_list_text.name
lower_list_text.material 				= gost_font
lower_list_text.stringdefs 				= text_defs
lower_list_text.init_pos				= {0, -text_frame_height}
lower_list_text.alignment 				= "CenterCenter"
lower_list_text.controllers 			= {{'lower_list_text'}}
AddElement(lower_list_text)

local lower_lower_list_text 			= CreateElement "ceStringPoly"
lower_lower_list_text.name 				= "lower_lower_list_text"
lower_lower_list_text.parent_element 	= middle_list_text.name
lower_lower_list_text.material 			= gost_font
lower_lower_list_text.stringdefs 		= text_defs
lower_lower_list_text.init_pos			= {0, -text_frame_height * 2}
lower_lower_list_text.alignment 		= "CenterCenter"
lower_lower_list_text.controllers 		= {{'lower_lower_list_text'}}
AddElement(lower_lower_list_text)

local list_arrow_size = text_frame_width * 0.1
local list_arrow_x_offset = -text_frame_width  * 0.45 --relative to list (middle entry) center

local middle_list_arrow 			= CreateElement "ceTexPoly"
middle_list_arrow.name				= "middle_list_arrow"
middle_list_arrow.parent_element 	= middle_list_holder.name
middle_list_arrow.material			= common_mat
middle_list_arrow.vertices			= simple_rectangle(list_arrow_size, list_arrow_size * 14/16)
middle_list_arrow.init_pos			= {list_arrow_x_offset, 0}
middle_list_arrow.tex_coords		= minmax_to_coords(216, 232, 74, 88)
middle_list_arrow.indices			= default_box_indices
AddElement(middle_list_arrow)

end --function create_and_add_elements(cross_size, compass_size, is_vr)