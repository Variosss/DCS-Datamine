dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.common_script_path.."hex_and_bits.lua")

--dofile(LockOn_Options.script_path.."MFCD\\indicator\\MFCD_hints.lua")

mip_filter_used		= true

SetScale(FOV)

max_pixels_count_x = 128
max_pixels_count_y = 80
channel_offset = 20

--x_size    = GetScale() * 0.95 -- half_width
x_size    = GetScale() -- half_width
new_scale = 2 * x_size / max_pixels_count_x

fov_scale = 1 --GetScale()
SetCustomScale(new_scale)


local font_scale = new_scale * 1.8
local font_horiz_spacing = 0.0
local font_vert_spacing  = 0.0

font_horiz_spacing = font_horiz_spacing / font_scale
font_vert_spacing  = font_vert_spacing / font_scale

fonts_sizes = {}

for i = 1, 2 do
	fonts_sizes[i] = {}
end

fonts_sizes[1] = {9, 	6}
fonts_sizes[2] = {8,  14}
fonts_sizes[3] = {9,  8}

predefined_fonts = {}
predefined_fonts[1] = {0.93*fonts_sizes[1][2] * font_scale, 0.76*fonts_sizes[1][2] * font_scale, font_horiz_spacing * font_scale, font_vert_spacing * font_scale}
predefined_fonts[2] = {0.9*fonts_sizes[2][2] * font_scale, 0.8*fonts_sizes[2][2] * font_scale, font_horiz_spacing * font_scale, font_vert_spacing * font_scale}
predefined_fonts[3] = {fonts_sizes[3][2] * font_scale, fonts_sizes[3][2] * font_scale, font_horiz_spacing * font_scale, font_vert_spacing * font_scale}


frame_box = {{0   			   ,   0},
			 {max_pixels_count_x ,   0},
		     {max_pixels_count_x ,max_pixels_count_y},
		     {0   			   ,max_pixels_count_y}}
			 
frame_ind = default_rect_indices
box_ind   = {0,1,2,2,3,0}

-- The third parameter is optional
function use_mipfilter(object)
	if mip_filter_used then
		object.use_mipfilter = true
	end
end

function AddLowerLeftCornerOriginArc210()
	   lower_left_corner		  = CreateElement  "ceSimple"
	   lower_left_corner.name     = "lower_left_corner_arc210"
	   lower_left_corner.init_pos = {-max_pixels_count_x/2, -max_pixels_count_y/2}
	   Add(lower_left_corner)
end 

AddLowerLeftCornerOriginArc210()

function SetLowerLeftCornerOrigin(object)
	object.parent_element =  "lower_left_corner_arc210"
end

function AddBackground(material)
	--material = material or "MFCD_BLUE" -- "INDICATION_COMMON_BLACK"
	material = material or "INDICATION_COMMON_BLACK"
	local fon			= CreateElement "ceMeshPoly"
	fon.name 		    = "Background"
	fon.primitivetype   = "triangles"
	fon.material 	    = material
	fon.vertices        = frame_box
	fon.indices	        = box_ind
	SetLowerLeftCornerOrigin(fon)
	Add(fon)
end

function AddRT(controllers)
	local txt_RT					= CreateElement "ceStringPoly"
	txt_RT.name						= "txt_RT"
	txt_RT.material					= "font_ARC210_small"
	txt_RT.alignment				= "RightTop"
	txt_RT.value					= "RT1"
	txt_RT.init_pos					= {max_pixels_count_x-5, max_pixels_count_y-2}
	txt_RT.stringdefs				= predefined_fonts[1]
	txt_RT.controllers				= controllers
	SetLowerLeftCornerOrigin(txt_RT)
	Add(txt_RT)
	use_mipfilter(txt_RT)
end

function AddTextLabel(text, align, x, y, font, material, controllers)
	local txt_label					= CreateElement "ceStringPoly"
	txt_label.name					= text
	txt_label.material				= material
	txt_label.alignment				= align
	txt_label.value					= text
	txt_label.init_pos				= {x, y}
	txt_label.stringdefs			= font
	txt_label.controllers			= controllers
	SetLowerLeftCornerOrigin(txt_label)
	Add(txt_label)
	use_mipfilter(txt_label)
	
	return txt_label
end


function AddTempSettingLabel(formats)
	local txt_label					= CreateElement "ceStringPoly"
	txt_label.name					= create_guid_string()
	txt_label.material				= "font_ARC210_small"
	txt_label.alignment				= "LeftCenter"
	txt_label.formats				= formats
	txt_label.init_pos				= {0, max_pixels_count_y/2}
	txt_label.stringdefs			= predefined_fonts[1]
	txt_label.controllers			= {{"temp_setting_label"}}
	SetLowerLeftCornerOrigin(txt_label)
	Add(txt_label)
	use_mipfilter(txt_label)
	
	return txt_label
end

hint_name = {}
for osb = 1, 3 do
	local osb_description = string.format("%d",osb)
	hint_name["LINE_"..osb_description] = "BTN-ARC210-LINE"..osb_description
end

function add_static_hint(line, hint_text)
local  hint			   =  CreateElement  "ceHint"
	   hint.value	   =  hint_text
	   hint.hint_name  =  hint_name[string.format("LINE_%d", line)]	
	   Add(hint)
return hint
end

function add_osb_hint_controllers(line, hint_text, controllers)
    local hint = add_static_hint(line, hint_text)
	hint.controllers = controllers
	return hint
end

function add_osb_hint_format_controllers(line, formats, controllers)
    local hint = add_static_hint(line, nil)
	hint.formats	= formats
	hint.controllers = controllers
	return hint
end


--[[
dofile(LockOn_Options.script_path.."MFCD\\indicator\\MFCD_fonts.lua")

function bx(xsz, ymin, ymax)
	local ymin = ymin or -xsz
	local ymax = ymax or  xsz
	return {{-xsz, ymin}, {-xsz, ymax},
			{ xsz, ymax}, { xsz, ymin}}
end


function tx(x, y)
	return {x/512, y/512}
end

function SetDefaultClipWithLevel(object,level)
	level = level or 0
	object.h_clip_relation = h_clip_relations.COMPARE
	object.level 		   = DEFAULT_LEVEL + level
end

function LowerLeft_WithOutParentness(obj,x,y)	
	local x = x or 0
	local y = y or 0
	obj.init_pos = {-max_pixels_count/2  + x, -max_pixels_count/2  + y}
end

function shift_label_pos(object, button, x, y)
	object.init_pos = {OSB_positions[button][1] + x, OSB_positions[button][2] + y, 0}
end

function shift_button_pos(object,button,x,y)
	SetLowerLeftCornerOrigin(object)
	object.init_pos = {OSB_positions[button][1] + x, OSB_positions[button][2] + y, 0}
end


function SetScreenSpace(object)
	object.screenspace = 2
end

function SetScreenSpaceTexParams(object,xs,ys)
	object.tex_params = {xs,ys,texture_scale*GetScale(),texture_scale*GetScale()}
end

function SetScreenSpaceTexParamsScale(object,xs,ys,scale)
	if scale == nil then
		object.tex_params = {xs,ys,texture_scale*GetScale(),texture_scale*GetScale()}
	else
		object.tex_params = {xs,ys,scale*texture_scale*GetScale(),scale*(texture_scale*GetScale())}
	end
end

function line_2_pixel_back(verts,parent)
	local size							   = 2 -- текстура немного не влезает
	local tex_param_default 			   = 2*texture_scale
	local border_background 		       = CreateElement "ceSimpleLineObject"
		  border_background.name           = create_guid_string()
		  border_background.material	   = "INDICATION_MFCD_BLACK"
		  border_background.width          = 2*size
		  border_background.tex_params     = {{0.1, 503.5/512}, {0.9, 503.5/512}, {texture_scale, 0.5 * tex_param_default}}	
		  border_background.vertices       = verts
		  if parent then
		      border_background.parent_element   = parent.name
		  end
		  Add(border_background)
		  use_mipfilter(border_background)
	return border_background
end

function line_2_pixel_main(verts,parent)
	local size					= 2 -- текстура немного не влезает
	local tex_param_default 	= 2*texture_scale
	local border				= CreateElement "ceSimpleLineObject"
		  border.name			= create_guid_string()
		  border.material		= "INDICATION_MFCD_GREEN"
		  border.width			= size
		  border.tex_params		= {{0.1,503.5/512},{0.9,503.5/512},{texture_scale,tex_param_default}}	
		  border.vertices		= verts
		  if parent then
		  border.parent_element   = parent.name
		  end
		  Add(border)
		  use_mipfilter(border)
	return border
end

function line_2_pixel_with_background(verts, clip_level, clip_relation)

local border_background      = line_2_pixel_back(verts)
local border			     = line_2_pixel_main(verts,border_background)

	  clip_level    = clip_level    or DEFAULT_LEVEL
	  clip_relation = clip_relation or h_clip_relations.NULL
	  border_background.h_clip_relation = clip_relation
	  border_background.level 		    = clip_level
	  border.h_clip_relation 			= clip_relation
	  border.level 		    			= clip_level
	  return border_background
end



function line_2_pixel(verts,material)
	local size				= 2.2 -- текстура немного не влезает
	local tex_param_default = 2*texture_scale
	local border			= CreateElement "ceSimpleLineObject"
	border.name				= create_guid_string()
	border.material			= material
	border.width			= size
	border.tex_params		= {{0.1, 503.5 / 512}, {0.9, 503.5 / 512}, {texture_scale, tex_param_default}}
	border.vertices			= verts
	Add(border)
	use_mipfilter(border)
	return border
end

function line_2_pixel_screenspace(verts)
	local size 				= 3 / max_pixels_count
	local border			= CreateElement "ceSimpleLineObject"
	border.name				= create_guid_string()
	border.material			= "INDICATION_COMMON_GREY"
	border.width			= size
	border.vertices			= verts
	SetScreenSpace(border)
	Add(border)
	use_mipfilter(border)
	return border
end

function shift_obj_pos(target_object, source_object, x, y)
	target_object.init_pos = {source_object.init_pos[1] + x, source_object.init_pos[2] + y, 0}
end


function Resize(Object, Kx, Ky)
	vertices = Object.vertices
	if vertices ~= nil then
		for k, v in pairs(vertices) do
			v[1] = v[1] * Kx
			v[2] = v[2] * Ky
		end
		
		Object.vertices = vertices
	end
	
	tex_params = Object.tex_params
	if tex_params ~= nil and #tex_params > 3 and
	   tex_params[3] ~= nil and tex_params[4] ~= nil then
		tex_params[3] = tex_params[3] / Kx
		tex_params[4] = tex_params[4] / Ky
		
		Object.tex_params = tex_params
	end
end
--]]
