dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.common_script_path.."hex_and_bits.lua")
dofile(LockOn_Options.script_path.."symbols.lua")
dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_hints.lua")
dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_materials.lua")

meters_per_lon_degree 	= 78658.808189
navy_miles			= 1 / 1852.0

if disposition == "L" then
	DEFAULT_LEVEL = 4 
else
	DEFAULT_LEVEL = 6
end


function set_as_invisible_mask(obj)
	local show_masks = false
	obj.isvisible = show_masks
	obj.material  = "MASK_MATERIAL"
end


mip_filter_used		= true

SetScale(FOV)
dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_sizes.lua")
SetCustomScale(new_scale)

dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_fonts.lua")

frame_box = {{0   			   ,   0},
			 {max_pixels_count ,   0},
		     {max_pixels_count ,max_pixels_count},
		     {0   			   ,max_pixels_count}}
			 
frame_ind = default_rect_indices
box_ind   = {0,1,2,2,3,0}

function bx(xsz, ymin, ymax)
	local ymin = ymin or -xsz
	local ymax = ymax or  xsz
	return {{-xsz, ymin}, {-xsz, ymax},
			{ xsz, ymax}, { xsz, ymin}}
end

function tx(x, y)
	return {x/512, y/512}
end

OSB_positions			  = {
[1]	  = {110						   			, max_pixels_count - OSB_symbol_spacing},	--up
[2]	  = {110 + 87.25				   			, max_pixels_count - OSB_symbol_spacing},	--up
[3]	  = {max_pixels_count/2			   			, max_pixels_count - OSB_symbol_spacing},	--up
[4]	  = {max_pixels_count - 110 - 87.25			, max_pixels_count - OSB_symbol_spacing},	--up
[5]	  = {max_pixels_count - 110		   			, max_pixels_count - OSB_symbol_spacing},	--up

[6]	  = {max_pixels_count - OSB_symbol_spacing	, max_pixels_count - 100         },	--right
[7]	  = {max_pixels_count - OSB_symbol_spacing	, max_pixels_count - 100 -   82.5},	--right
[8]	  = {max_pixels_count - OSB_symbol_spacing	, max_pixels_count - 100 - 2*82.5},	--right
[9]	  = {max_pixels_count - OSB_symbol_spacing	, max_pixels_count - 100 - 3*82.5},	--right
[10]  = {max_pixels_count - OSB_symbol_spacing	, max_pixels_count - 100 - 4*82.5},	--right

[11]  = {max_pixels_count - 110		  			,OSB_symbol_spacing},				--down
[12]  = {max_pixels_count - 110 - 87.25			,OSB_symbol_spacing},				--down
[13]  = {max_pixels_count/2			  			,OSB_symbol_spacing},				--down
[14]  = {110 + 87.25                  			,OSB_symbol_spacing},				--down
[15]  = {110		                  			,OSB_symbol_spacing},				--down

[16]  = {OSB_symbol_spacing						,max_pixels_count - 100 - 4*82.5},	--left
[17]  = {OSB_symbol_spacing						,max_pixels_count - 100 - 3*82.5},	--left
[18]  = {OSB_symbol_spacing						,max_pixels_count - 100 - 2*82.5},	--left
[19]  = {OSB_symbol_spacing						,max_pixels_count - 100 -   82.5},	--left
[20]  = {OSB_symbol_spacing						,max_pixels_count - 100         },	--left
}
function SetDefaultClipWithLevel(object,level)
	level = level or 0
	object.h_clip_relation = h_clip_relations.COMPARE
	object.level 		   = DEFAULT_LEVEL + level
end

function AddLowerLeftCornerOrigin()
	   lower_left_corner		  = CreateElement  "ceSimple"
	   lower_left_corner.name     = "lower_left_corner"
	   lower_left_corner.init_pos = {-max_pixels_count/2, -max_pixels_count/2}
	   Add(lower_left_corner)
end 

AddLowerLeftCornerOrigin()

function SetLowerLeftCornerOrigin(object)
	object.parent_element =  "lower_left_corner"
end

function LowerLeft_WithOutParentness(obj,x,y)	
	local x = x or 0
	local y = y or 0
	obj.init_pos = {-max_pixels_count/2  + x, -max_pixels_count/2  + y}
end

function AddBackground(material)
	--material = material or MFCD_SOLID_BLUE -- MFCD_SOLID_BLACK
	material = material or MFCD_SOLID_BLACK
	fon			        = CreateElement "ceMeshPoly"
	fon.name 		    = "Background"
	fon.primitivetype   = "triangles"
	fon.material 	    = material
	fon.vertices        = frame_box
	fon.indices	        = box_ind
	fon.blend_mode 		= blend_mode.IBM_REGULAR
	SetLowerLeftCornerOrigin(fon)
	Add(fon)
end

function AddRender()
	local   verts 			     = {{-max_pixels_count/2,  max_pixels_count/2},
									 { max_pixels_count/2,  max_pixels_count/2}, 
									 { max_pixels_count/2, -max_pixels_count/2},
									 {-max_pixels_count/2, -max_pixels_count/2}}
	
	local   back    		 	 = CreateElement "ceMeshPoly"
			back.primitivetype   = "triangles"
			back.vertices        = verts
			back.indices         = box_ind
			set_as_invisible_mask(back)
			back.level		     = DEFAULT_LEVEL
			back.h_clip_relation = h_clip_relations.REWRITE_LEVEL
			Add(back)
		
	
	local render_base 			  = CreateElement  "ceSimple"
		  render_base.controllers = {{"render_available"}}
	  	  Add(render_base)
	  
	
	local render_tv					= CreateElement "ceTexPoly"
		  render_tv.name			= "screen"
		  render_tv.vertices		= verts
		  render_tv.indices			= {0, 1, 2, 0, 2, 3}
		  render_tv.tex_params		= {0.5,0.5,1/(max_pixels_count),1/(max_pixels_count)}
		  ---------------------------------------------------------------------------------------
		  render_tv.material		= "render_target_"..string.format("%d",GetRenderTarget() + 1)
		  ---------------------------------------------------------------------------------------
		  render_tv.controllers		= {{"maverick_screen_is_IR",0},
									   {"tgp_digital_zoom"}}
		  render_tv.level 			= DEFAULT_LEVEL
		  render_tv.h_clip_relation = h_clip_relations.COMPARE
	      render_tv.parent_element  = render_base.name
		  Add(render_tv)
		  
	local render_mav_ir				= Copy(render_tv)	
		  render_mav_ir.controllers	= {{"maverick_screen_is_IR",1},
									   {"video_brightness",0.1,1.0,1.0/63.0},
									   {"video_contrast"  ,0  ,1.0,1.0/32.0}}
		  ---------------------------------------------------------------------------------------
		  render_mav_ir.material	= MakeMaterial("mfd"..tostring(GetRenderTarget()),{255,255,255,255})
		  ---------------------------------------------------------------------------------------
		  Add(render_mav_ir)
end


-- The third parameter is optional
function addOSB_MeshBox(OSB, Hosts, OptName)

	local GH = {}
	
	if Hosts ~= nil then
		for k, v in pairs(Hosts) do
			GH[#GH + 1] = v.name
		end
	end
	
	local OSB_Box  				= CreateElement "ceBoundingMeshBox"
	
	if OptName == nil then
		OSB_Box.name 			= "OSB_Box" .. string.format("%d", OSB)
		
		for k, v in pairs(GH) do
			OSB_Box.name = OSB_Box.name .. "_" .. v
		end
	else
		OSB_Box.name = OptName
	end
	
	OSB_Box.primitivetype		= "lines"
	OSB_Box.material	   		= MFCD_SOLID_VIOLET
	shift_button_pos_2(OSB_Box,OSB)
	local BoxSide = 20
	OSB_Box.vertices			= {{-BoxSide,-BoxSide},
								   { BoxSide,-BoxSide},
								   { BoxSide, BoxSide},
								   {-BoxSide, BoxSide}}
	OSB_Box.controllers			= {{"pressed_OSB_status", OSB - 1, 1}}
	OSB_Box.geometry_hosts		= GH
	Add(OSB_Box)
	use_mipfilter(OSB_Box)
	
	return OSB_Box
end

-- The third parameter is optional
function addOSB_Box(OSB, Hosts, OptName)
	local GH = {}
	
	if Hosts ~= nil then
		for k, v in pairs(Hosts) do
			GH[#GH + 1] = v.name
		end
	end
	
	local size					= 1.5
	local tex_param_default		= 2 * texture_scale
	local OSB_Box  				= CreateElement "ceBoundingTexBox"
	
	if OptName == nil then
		OSB_Box.name 			= "OSB_Box" .. string.format("%d", OSB)
	
		for k, v in pairs(GH) do
			OSB_Box.name = OSB_Box.name .. "_" .. v
		end
	else
		OSB_Box.name = OptName
	end
	
	OSB_Box.material	   		= MFCD_VIOLET
	OSB_Box.width				= size
	--OSB_Box.tex_params			= {{0.1, 413.9/512}, {0.9, 413.9/512}, {texture_scale, tex_param_default}}
	OSB_Box.tex_params			= {{0.1,503.5/512},{0.9,503.5/512}, {texture_scale, tex_param_default * 1.5}}
	shift_button_pos_2(OSB_Box,OSB)
	local BoxSide = 20
	OSB_Box.vertices			= {{-BoxSide,-BoxSide},
								   { BoxSide,-BoxSide},
								   { BoxSide, BoxSide},
								   {-BoxSide, BoxSide},
								   {-BoxSide,-BoxSide}}
	OSB_Box.controllers			= {{"pressed_OSB_status", OSB - 1, 1}}
	OSB_Box.geometry_hosts		= GH
	Add(OSB_Box)
	use_mipfilter(OSB_Box)
	return OSB_Box
end


function use_mipfilter(object)
	if mip_filter_used then
		object.use_mipfilter = true
	end
end


function shift_button_pos(object,osb,x,y)
	local right = osb > 5 and osb < 11
	local left  = osb > 15 
	local up    = osb < 6
	local down  = osb < 16 and osb > 10
	
	SetLowerLeftCornerOrigin(object)
	local x = x or 0
	local y = y or 0
	local osb_pos = OSB_positions[osb]
	if up then
	    object.init_pos = {osb_pos[1] + x,soi_max_y + OSB_symbol_spacing  	 + y}
	elseif down then
	    object.init_pos = {osb_pos[1] + x,soi_min_y 						 + y}
	elseif right then
	    object.init_pos = {soi_max_x  + x,osb_pos[2] 			 + y}
	elseif left then
	    object.init_pos = {soi_min_x  + x,osb_pos[2] 			 + y}
	end
end

function shift_button_pos_2(object,osb,x,y)
	local x = x or 0
	local y = y or 0
	local osb_pos = OSB_positions[osb]
	SetLowerLeftCornerOrigin(object)
	object.init_pos = {osb_pos[1] + x, osb_pos[2] + y}
end


function SetScreenSpace(object)
	object.screenspace = 2 -- render to texture
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
		  border_background.material	   = MFCD_BLACK
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
	border.material		= MFCD_GREEN
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
	border_background.level 		= clip_level
	border.h_clip_relation 			= clip_relation
	border.level 		    		= clip_level
	return border_background
end


function line_2_pixel(verts,material)
	local size				= 2.2 -- текстура немного не влезает
	local tex_param_default = 2*texture_scale
	local border			= CreateElement "ceSimpleLineObject"
	border.material			= material
	border.width			= size
	border.tex_params		= {{0.1,503.5/512},{0.9,503.5/512},{texture_scale,tex_param_default}}	
	border.vertices			= verts
	Add(border)
	use_mipfilter(border)
	return border
end


function line_2_pixel_screenspace(verts)
	local size 				= 3 / max_pixels_count
	local border			= CreateElement "ceSimpleLineObject"
	border.material			= MFCD_SOLID_GREY
	border.width			= size
	border.vertices			= verts
	SetScreenSpace(border)
	Add(border)
	use_mipfilter(border)
	return border
end


soi_min_x = 30 
soi_max_x = max_pixels_count - soi_min_x
soi_min_y = soi_min_x
soi_max_y = max_pixels_count - soi_min_y
 
function Add_SOI_border()
	local sz    = max_pixels_count/2 - 40
	local object = line_2_pixel_with_background({{soi_min_x,soi_max_y},
                                                 {soi_max_x,soi_max_y},
                                                 {soi_max_x,soi_min_y},
                                                 {soi_min_x,soi_min_y},
                                                 {soi_min_x,soi_max_y}})
	SetLowerLeftCornerOrigin(object) 
	object.controllers    = {{"self_SOI"}}
end


NOT_SOI_coord_x = max_pixels_count/2
NOT_SOI_coord_y = 100

function Add_NOT_SOI_display_helper()
	local NOT_SOI					= CreateElement "ceStringPoly"
	NOT_SOI.name					= "NOT_SOI"
	NOT_SOI.alignment				= "CenterCenter"
	NOT_SOI.value					= "NOT SOI"
	NOT_SOI.material				= font_MFCD_BLACK
	NOT_SOI.stringdefs				= predefined_fonts[2]
	NOT_SOI.controllers				= {{"self_SOI",-1}}
	NOT_SOI.UseBackground			= true
	NOT_SOI.BackgroundMaterial		= MFCD_SOLID_GREY
	use_mipfilter(NOT_SOI)
			
	return NOT_SOI
end


function Add_NOT_SOI_display()
	local NOT_SOI					= Add_NOT_SOI_display_helper()
	SetLowerLeftCornerOrigin(NOT_SOI)
	NOT_SOI.init_pos				= {NOT_SOI_coord_x, NOT_SOI_coord_y, 0}
	Add(NOT_SOI)
	
	return NOT_SOI
end


function shift_obj_pos(target_object, source_object, x, y)
	target_object.init_pos = {source_object.init_pos[1] + x, source_object.init_pos[2] + y, 0}
end


size_ARS = 25 + 7

function add_attitude_reference_symbol()

	local	attitude_symbol_background     = CreateElement "ceMeshPoly"
	attitude_symbol_background.name    	   = "attitude_symbol_background"
	attitude_symbol_background.primitivetype = "triangles"
	attitude_symbol_background.vertices = {{-size_ARS,-size_ARS},
										   { size_ARS,-size_ARS},
										   { size_ARS, size_ARS},
										   {-size_ARS, size_ARS}}
	SetLowerLeftCornerOrigin(attitude_symbol_background)
	attitude_symbol_background.indices 		   = box_ind
	attitude_symbol_background.init_pos        = {soi_min_x + size_ARS - 21,soi_min_y + size_ARS + 1}
	attitude_symbol_background.material        = MFCD_SOLID_BLACK
	attitude_symbol_background.level		   = DEFAULT_LEVEL + 1
	attitude_symbol_background.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	Add(attitude_symbol_background)

	local   bird_size_x     = 44.4/512  -   1.5/512
	local   bird_size_y_max = 446.5/512 - 422.5/512
	local   bird_size_y_min = 446.5/512 - 456.5/512
	local   bird_scale      = 2*texture_scale 
	
	local   arc_size_x_min  = 89.5/512  -   153/512
	local   arc_size_x_max  = 206 /512  -   1.5/512
	local   arc_size_y_max  = 421.5/512 -  419/512
	local   arc_size_y_min  = 421.5/512 - 474.5/512

	local   brd_scale 	    = size_ARS / 35

	local 	attitude_symbol_bird  = CreateElement "ceTexPoly"
	attitude_symbol_bird.name = "attitude_symbol_bird"
	attitude_symbol_bird.vertices = {{-brd_scale * bird_size_x/bird_scale , brd_scale * bird_size_y_max/bird_scale},
									 { brd_scale * bird_size_x/bird_scale , brd_scale * bird_size_y_max/bird_scale},
									 { brd_scale * bird_size_x/bird_scale , brd_scale * bird_size_y_min/bird_scale},
									 {-brd_scale * bird_size_x/bird_scale , brd_scale * bird_size_y_min/bird_scale}}
									 
	attitude_symbol_bird.indices    = box_ind
	attitude_symbol_bird.material   = MFCD_GREEN
	attitude_symbol_bird.tex_params = {44.4/512,446.5/512,bird_scale/brd_scale,bird_scale/brd_scale} 
	attitude_symbol_bird.parent_element = attitude_symbol_background.name
	use_mipfilter(attitude_symbol_bird) 
	Add(attitude_symbol_bird)

	local 	arc_base		= CreateElement "ceSimple"
	arc_base.name           = "arc_base"
	arc_base.parent_element = attitude_symbol_bird.name
	arc_base.controllers	= {{"attitude_symbol_roll",1.0}}
	Add(arc_base)

	local 	attitude_symbol_background_left   		= CreateElement "ceMeshPoly"
	attitude_symbol_background_left.name    	  	= "attitude_symbol_background_left"
	attitude_symbol_background_left.primitivetype	= "triangles"
	attitude_symbol_background_left.vertices 		= {{-size_ARS,-size_ARS},{ 0,-size_ARS},{ 0, size_ARS},{-size_ARS, size_ARS}}
	attitude_symbol_background_left.indices 		= box_ind
	set_as_invisible_mask(attitude_symbol_background_left)
	attitude_symbol_background_left.h_clip_relation = h_clip_relations.INCREASE_LEVEL
	attitude_symbol_background_left.parent_element  = arc_base.name
	Add(attitude_symbol_background_left)

	local 	attitude_symbol_arc    = CreateElement "ceTexPoly"
	attitude_symbol_arc.name       = "attitude_symbol_arc"
	attitude_symbol_arc.vertices   = { {brd_scale *arc_size_x_min/bird_scale , brd_scale *arc_size_y_max/bird_scale},
									   {brd_scale *arc_size_x_max/bird_scale , brd_scale *arc_size_y_max/bird_scale},
									   {brd_scale *arc_size_x_max/bird_scale , brd_scale *arc_size_y_min/bird_scale},
									   {brd_scale *arc_size_x_min/bird_scale , brd_scale *arc_size_y_min/bird_scale}}
	attitude_symbol_arc.indices    = box_ind
	attitude_symbol_arc.material   = MFCD_GREEN
	attitude_symbol_arc.tex_params = {153/512,421.5/512,bird_scale/brd_scale,bird_scale/brd_scale} 
	attitude_symbol_arc.parent_element = arc_base.name
	use_mipfilter(attitude_symbol_arc) 
	attitude_symbol_arc.level		    = DEFAULT_LEVEL + 2
	attitude_symbol_arc.h_clip_relation = h_clip_relations.COMPARE
	attitude_symbol_arc.controllers	= {{"attitude_symbol_pitch",1.0}}
	Add(attitude_symbol_arc)

	local 	attitude_symbol_background_left_ret = Copy(attitude_symbol_background_left)
	attitude_symbol_background_left_ret.name = "attitude_symbol_background_left_ret"
	attitude_symbol_background_left_ret.h_clip_relation = h_clip_relations.DECREASE_LEVEL
	Add(attitude_symbol_background_left_ret)

	local 	attitude_symbol_background_right = Copy(attitude_symbol_background_left)
	attitude_symbol_background_right.name  = "attitude_symbol_background_right"
	attitude_symbol_background_right.vertices 	=  {{0  ,-size_ARS},
													{ size_ARS,-size_ARS},
													{ size_ARS, size_ARS},
													{0  , size_ARS}}
	Add(attitude_symbol_background_right)

	local   attitude_symbol_arc2    = Copy(attitude_symbol_arc)
	attitude_symbol_arc2.name		= "attitude_symbol_arc2"
	attitude_symbol_arc2.vertices   = { {-brd_scale *arc_size_x_min/bird_scale , brd_scale *arc_size_y_max/bird_scale},
									    {-brd_scale *arc_size_x_max/bird_scale , brd_scale *arc_size_y_max/bird_scale},
									    {-brd_scale *arc_size_x_max/bird_scale , brd_scale *arc_size_y_min/bird_scale},
									    {-brd_scale *arc_size_x_min/bird_scale , brd_scale *arc_size_y_min/bird_scale}}
	attitude_symbol_arc2.tex_params = {153/512,421.5/512,-bird_scale/brd_scale,bird_scale/brd_scale} 
	attitude_symbol_arc2.controllers	= {{"attitude_symbol_pitch",-1.0}}
	Add(attitude_symbol_arc2)

	local 	attitude_symbol_background_right_ret = Copy(attitude_symbol_background_right)
	attitude_symbol_background_right_ret.name  = "attitude_symbol_background_right_ret"
	attitude_symbol_background_right_ret.h_clip_relation = h_clip_relations.DECREASE_LEVEL
	Add(attitude_symbol_background_right_ret)

	local   txt_thousands				= CreateElement "ceStringPoly"
	txt_thousands.name					= "txt_thousands"
	txt_thousands.material				= font_MFCD
	txt_thousands.UseBackground			= true
	txt_thousands.BackgroundMaterial	= MFCD_SOLID_BLACK
	txt_thousands.alignment				= "RightTop"
	txt_thousands.formats               = {"%02.f", "%03.f"}
	txt_thousands.stringdefs			= txt_labels_font --predefined_fonts[1]
	SetLowerLeftCornerOrigin(txt_thousands)
	txt_thousands.init_pos              = {soi_min_x + 3, soi_min_y + 2}
	txt_thousands.controllers			= {{"attitude_symbol_barometric_altitude_thousands", 3.28}}
	Add(txt_thousands)
	use_mipfilter(txt_thousands)

-- according to the sources we have, the hundreds numeric is slightly
-- depressed due to it's size.

	local 	txt_hundreds 				= Copy(txt_thousands)
	txt_hundreds.name					= "txt_hundreds"
	txt_hundreds.alignment				= "LeftTop"
	txt_hundreds.formats                = {"%01.f"}
	txt_hundreds.stringdefs		    	= txt_smallest_font --predefined_fonts[1]
	txt_hundreds.parent_element         = txt_thousands.name
	txt_hundreds.init_pos               = {0, -4.7, 0}
	txt_hundreds.controllers			= {{"attitude_symbol_barometric_altitude_hundreds", 0, 3.28}}
	Add(txt_hundreds)
end


function add_text_osb_position(osb, str)
    local label 	= default_label_text(osb,true)
	label.value	= str
	shift_button_pos(label,osb)   
	return label
end

function addScrollers(OSB1, OSB2, dx, Ctrlrs1, Ctrlrs2)
	local Backgnd1				= CreateElement "ceMeshPoly"
	Backgnd1.name				= "OSB"..OSB1.."_ScrollSymbol_Backgnd"
	Backgnd1.primitivetype		= "triangles"
	Backgnd1.vertices    		= {{-17, -21}, {-17, 13}, { 17, 13}, { 17, -21}}
	Backgnd1.indices	     	= box_ind
	set_as_invisible_mask(Backgnd1)
	if Ctrlrs1 ~= nil then
		Backgnd1.controllers	= Ctrlrs1
	end
	shift_button_pos(Backgnd1, OSB1, dx, 0)
	Add(Backgnd1)
	
	local ScrollSymbol1  		= CreateElement "ceTexPoly"
	ScrollSymbol1.name 			= "OSB"..OSB1.."_ScrollSymbol"
	ScrollSymbol1.vertices		= {{-18 , 13}, {18, 13}, {18, -13}, {-18, -13}}
	ScrollSymbol1.indices		= box_ind
	ScrollSymbol1.material		= MFCD_GREEN
	ScrollSymbol1.tex_params	= {33/512, 303/512, 2*texture_scale, 2*texture_scale} 
	shift_button_pos(ScrollSymbol1, OSB1, dx, 0)
	if Ctrlrs1 ~= nil then
		ScrollSymbol1.controllers = Ctrlrs1
	end
	use_mipfilter(ScrollSymbol1) 
	SetLowerLeftCornerOrigin(ScrollSymbol1)
	Add(ScrollSymbol1)
	
	--addOSB_Box(OSB1, {Backgnd1})

	local Backgnd2				= CreateElement "ceMeshPoly"
	Backgnd2.name				= "OSB"..OSB2.."_ScrollSymbol_Backgnd"
	Backgnd2.primitivetype		= "triangles"
	Backgnd2.vertices    		= {{-17, 21}, {-17, -13}, { 17, -13}, { 17, 21}}
	Backgnd2.indices	     	= box_ind
	set_as_invisible_mask(Backgnd2)
	if Ctrlrs2 ~= nil then
		Backgnd2.controllers	= Ctrlrs2
	end
	shift_button_pos(Backgnd2, OSB2, dx, 0)
	Add(Backgnd2)
	
	local ScrollSymbol2  		= CreateElement "ceTexPoly"
	ScrollSymbol2.name 			= "OSB"..OSB2.."_ScrollSymbol"
	ScrollSymbol2.vertices		= {{-18 , 13}, {18, 13}, {18, -13}, {-18, -13}}
	ScrollSymbol2.indices		= box_ind
	ScrollSymbol2.material		= MFCD_GREEN
	ScrollSymbol2.tex_params	= {33/512, 303/512, 2*texture_scale, 2*texture_scale} 
	shift_button_pos(ScrollSymbol2, OSB2, dx, 0)
	ScrollSymbol2.init_rot		= {180, 0, 0}
	if Ctrlrs2 ~= nil then
		ScrollSymbol2.controllers = Ctrlrs2
	end
	use_mipfilter(ScrollSymbol2) 
	SetLowerLeftCornerOrigin(ScrollSymbol2)
	Add(ScrollSymbol2)
	
	--addOSB_Box(OSB2, {Backgnd2})
	return {ScrollSymbol1, ScrollSymbol2, Backgnd1, Backgnd2}
end

function dummy_screenspace(controllers)
	local  base				   = CreateElement "ceSimple"
	base.controllers     = controllers
	SetScreenSpace(base)
	Add(base)
	return base
end

function dummy(controllers)
	local  base				    = CreateElement "ceSimple"
	base.controllers     = controllers
	Add(base)
	return base
end


function bool_rotary(osb,controller,on,off)
	local	label = add_OSB_label(osb, ROTARY)
	local   label_off		 = default_label_text(osb, true)
	label_off.value			 = off
	label_off.parent_element = label.name 
	label_off.controllers    = {{controller, -1}}

	local   label_on		 = Copy(label_off)
	label_on.value			 = on
	label_on.controllers     = {{controller}}
	Add(label_on)
	addOSB_Box(osb,{label,label_off,label_on})
end


function bool_dummy_osb(osb,controller,on,off)

	local	label 			 = add_OSB_label(osb)
	local   label_off		 = default_label_text(osb, true)
	label_off.value			 = off
	label_off.parent_element = label.name 
	label_off.controllers    = {{controller,-1}}

	local   label_on		 = Copy(label_off)
	label_on.value			 = on
	label_on.controllers     = {{controller}}
	Add(label_on)
end


function enumeration_rotary(osb,controller,values)
	local   label_values = {}
			label_values[1] = add_OSB_label(osb, ROTARY)
	for i,v in pairs(values) do
			label_values[i + 1]		  = default_label_text(osb)
			label_values[i + 1].value = v
			label_values[i + 1].parent_element = label_values[1].name 
			label_values[i + 1].controllers    = {{controller,i - 1}}	
	end
	addOSB_Box(osb,label_values)
end


function enumeration_osb_dummy(osb,controller,values)
	local   label_values = {}
			label_values[1] = add_OSB_label(osb)
	for i,v in pairs(values) do
			label_values[i + 1]		  = default_label_text(osb)
			label_values[i + 1].value = v
			label_values[i + 1].parent_element = label_values[1].name 
			label_values[i + 1].controllers    = {{controller,i - 1}}	
	end
end


function add_dummy_boxes(osbs)
	for i,osb in pairs(osbs) do
			addOSB_Box(osb)
	end
end


function AddTable(Rows, Cols, Row_height, Width, Startx, Starty, Material)
    local tab   		= line_2_pixel({{0,0},
    									{0,     -Rows * Row_height}, 
    									{Width, -Rows * Row_height}, 
    									{Width, 0},
    									{0,     0}}, Material or MFCD_GREEN)
    tab.init_pos	    = {Startx, Starty}
    SetLowerLeftCornerOrigin(tab)
	
    local tab_rows={}
    if Rows > 1 then
		for i=1, Rows - 1 do
    		tab_rows[i]				= line_2_pixel({{0    , -i*Row_height},
    												{Width, -i*Row_height}}, Material or MFCD_GREEN)
    		tab_rows[i].parent_element = tab.name
		end
    end
    
    local tab_cols={}
    for i = 1,#Cols do
    	tab_cols[i]				 = line_2_pixel({{Cols[i], 0},
    											 {Cols[i],-Rows * Row_height}}, Material or MFCD_GREEN)
    	tab_cols[i].parent_element = tab.name
    end
    return tab
end


function AddTblBackgndRow(Name, Color, Row, Row_height, Width, Startx, Starty, Controllers)
	local Elem			= CreateElement "ceMeshPoly"
	Elem.name			= Name
	Elem.material		= Color
	Elem.primitivetype	= "triangles"
	Elem.init_pos		= {Startx, Starty - Row * Row_height, 0}
	
	Elem.vertices		= {{0, 0},
						   {Width, 0},
						   {Width, Row_height},
						   {0, Row_height}}
	Elem.indices		= box_ind
	if Controllers ~= nil then
		Elem.controllers = Controllers
	end
	SetLowerLeftCornerOrigin(Elem)
	Add(Elem)
	use_mipfilter(Elem)
		
	return Elem
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


function addTableScrollBar(X, Y, VertSize,
	BarController, UpArrowController, DownArrowController, Parent)
	
	local scroll_bar_base 			= CreateElement "ceSimple"
	scroll_bar_base.name			= "scroll_bar_base"
	if Parent ~= nil then
		scroll_bar_base.parent_element = Parent.name
	end
	scroll_bar_base.init_pos 		= {X, Y}
	Add(scroll_bar_base)

	local half_sz = VertSize / 2
	local arrow_pos = half_sz + 20
	local scroll_w = 12
	local scroll_half_w = scroll_w / 2
	local arrow_height = 16

	local scroll_bar				= CreateElement "ceHWLine"
	scroll_bar.name					= "scroll_bar"
	scroll_bar.vertices				= {{-0.6, -7.4}, {-0.6, 7.4}, {189.25, 7.4}, {189.25, -7.4}}
	scroll_bar.maskvertices			= {{0.0, -7.4}, {0.0, 7.4}, {189.25, 7.4}, {189.25, -7.4}}
	scroll_bar.indices				= box_ind
	scroll_bar.init_pos				= {0, half_sz, 0}
	scroll_bar.init_rot				= {-90, 0, 0}
	scroll_bar.length				= VertSize
	scroll_bar.maxlength			= VertSize
	scroll_bar.material				= MFCD_WHITE
	scroll_bar.tex_params			= {2 / 512, 399.734 / 512, texture_scale * 3, texture_scale * 3}
	scroll_bar.parent_element		=  scroll_bar_base.name
	if BarController ~= nil then
		scroll_bar.controllers		= BarController
	end
	---------------------------------------
	--scroll_bar.isdraw				= false -- DBG. REMOVE THIS!
	---------------------------------------
	Add(scroll_bar)
	use_mipfilter(scroll_bar)

	local scroll = line_2_pixel({{-scroll_half_w, -half_sz}, {-scroll_half_w, half_sz},
		{scroll_half_w, half_sz}, {scroll_half_w, -half_sz}, {-scroll_half_w, -half_sz}}, MFCD_WHITE)
	scroll.parent_element = scroll_bar_base.name

	local scroll_up_filled  		= CreateElement "ceTexPoly"
	scroll_up_filled.vertices		= {{-1, scroll_half_w + 1},	{arrow_height + 1, scroll_half_w + 1},
		{arrow_height + 1, -scroll_half_w - 1}, {-1, -scroll_half_w - 1}}
	scroll_up_filled.indices		= box_ind
	scroll_up_filled.material		= MFCD_WHITE
	scroll_up_filled.tex_params		= {4.5 / 512, 479.5 / 512, 1.9 * texture_scale, 2.8 * texture_scale}
	scroll_up_filled.init_pos		= {0, arrow_pos, 0}	
	scroll_up_filled.init_rot		= {-90, 0, 0}
	use_mipfilter(scroll_up_filled) 
	scroll_up_filled.parent_element	=  scroll_bar_base.name
	if UpArrowController ~= nil then
		scroll_up_filled.controllers = UpArrowController
	end
	---------------------------------------
	--scroll_up_filled.isdraw			= false -- DBG. REMOVE THIS!
	---------------------------------------
	Add(scroll_up_filled)
	
	local scroll_down_filled		= CreateElement "ceTexPoly"
	scroll_down_filled.vertices		= {{-1, scroll_half_w + 1},	{arrow_height + 1, scroll_half_w + 1},
		{arrow_height + 1, -scroll_half_w - 1}, {-1, -scroll_half_w - 1}}
	scroll_down_filled.indices		= box_ind
	scroll_down_filled.material		= MFCD_WHITE
	scroll_down_filled.tex_params	= {4.5 / 512, 479.5 / 512, 1.9 * texture_scale, 2.8 * texture_scale} 
	scroll_down_filled.init_pos		= {0, -arrow_pos, 0}
	scroll_down_filled.init_rot		= {90, 0, 0}
	if DownArrowController ~= nil then
		scroll_down_filled.controllers = DownArrowController
	end
	---------------------------------------
	--scroll_down_filled.isdraw		= false -- DBG. REMOVE THIS!
	---------------------------------------
	use_mipfilter(scroll_down_filled) 
	scroll_down_filled.parent_element = scroll_bar_base.name
	Add(scroll_down_filled)

	local scroll_up = line_2_pixel({{-scroll_half_w, -arrow_height}, {0, 0},
		{scroll_half_w, -arrow_height}, {-scroll_half_w, -arrow_height}}, MFCD_WHITE)
	scroll_up.parent_element = scroll_bar_base.name												 
	scroll_up.init_pos = {0, arrow_pos, 0}

	local scroll_down = line_2_pixel({{-scroll_half_w, arrow_height}, {0, 0},
		{scroll_half_w, arrow_height}, {-scroll_half_w, arrow_height}}, MFCD_WHITE)
	scroll_down.parent_element =  scroll_bar_base.name												 
	scroll_down.init_pos = {0, -arrow_pos, 0}
end

function addConfirmation(Name, Ctrl, Txt)
		confirm_deletion				    = CreateElement "ceStringPoly"
		confirm_deletion.name			    = Name
		confirm_deletion.material		    = font_MFCD_BLACK
		confirm_deletion.UseBackground	    = true
		confirm_deletion.BackgroundMaterial = MFCD_SOLID_WHITE
		confirm_deletion.alignment		    = "CenterCenter"
		confirm_deletion.value			    = Txt
		confirm_deletion.stringdefs		    = predefined_fonts[3]
		confirm_deletion.init_pos			= {max_pixels_count/2, 120, 0}
		confirm_deletion.controllers		= Ctrl
		SetLowerLeftCornerOrigin(confirm_deletion)
		Add(confirm_deletion)
		use_mipfilter(confirm_deletion)
end

OSB_SIDES = {up = 1, right = 2, down = 3, left = 4}

function getOSB_Side(osb)
	if osb < 6 then
		return OSB_SIDES.up
	elseif osb > 5 and osb < 11 then
		return OSB_SIDES.right
	elseif osb > 10 and osb < 16 then
		return OSB_SIDES.down
	end
	
	return OSB_SIDES.left
end

function default_label_text(osb, UseBackground, inverse) -- additional inscription
	local osb_side = getOSB_Side(osb)
	
	local label	= CreateElement "ceStringPoly"
	
	label.UseBackground	= UseBackground
	
	if UseBackground then 
		if inverse then
			label.material			 = font_MFCD_BLACK
			label.BackgroundMaterial = MFCD_SOLID_GREEN
		else
			label.material			 = font_MFCD
			label.BackgroundMaterial = MFCD_SOLID_BLACK	  
		end
	else
		label.material			 = font_MFCD
	end 
	
	label.stringdefs = txt_labels_font
	if osb_side == OSB_SIDES.up or osb_side == OSB_SIDES.down then
        label.alignment	= "CenterTop"
	elseif osb_side == OSB_SIDES.right then
        label.alignment = "RightCenter"
    elseif losb_side == OSB_SIDES.eft then
        label.alignment = "LeftCenter"
    end

	Add(label)
	use_mipfilter(label)
	return label
end

function add_OSB_label(osb, Val, DontUseBackground, inversed)
	local osb_side = getOSB_Side(osb)

	local label	= CreateElement("ceStringPoly")

	if DontUseBackground ~= true then
		label.UseBackground			= true
		if inversed then
			label.material			 = font_MFCD_BLACK
			label.BackgroundMaterial = MFCD_SOLID_GREEN
		else
			label.material			 = font_MFCD
			label.BackgroundMaterial = MFCD_SOLID_BLACK	  
		end
	end
		
	if type(Val) == "table" then
		label.formats = Val
	else
		label.value = Val
	end
	
	label.stringdefs			= txt_labels_font	
		
	if osb_side == OSB_SIDES.up or osb_side == OSB_SIDES.down then
	    label.alignment = "CenterTop"
	elseif osb_side == OSB_SIDES.right then
	    label.alignment = "LeftCenter"
	elseif osb_side == OSB_SIDES.left then
	    label.alignment = "RightCenter"
	end
		
	label.controllers = {{"declutter"}, {"locked_OSB_status", osb - 1, -1}}
	
	shift_button_pos(label,osb)
	Add(label)
	use_mipfilter(label)
	return label
end

