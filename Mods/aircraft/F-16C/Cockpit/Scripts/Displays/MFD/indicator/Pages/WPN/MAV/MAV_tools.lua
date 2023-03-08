dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_page_defs.lua")

max_pixels_count 		= 480
box_ind 	= {0,1,2,2,3,0}

function set_as_invisible_mask(obj)
	local show_masks = false
	obj.isvisible = show_masks
	obj.material  = "MASK_MATERIAL"
end

function AddRender()
	local	verts = {{-238,  238},
					{ 238,  238}, 
					{ 238, -238},
					{-238, -238}}
	
	local	back    		 	 = CreateElement "ceMeshPoly"
			back.primitivetype   = "triangles"
			back.vertices        = verts
			back.indices         = box_ind
			set_as_invisible_mask(back)
			back.level		     = DEFAULT_LEVEL
			back.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	Add(back)

	local render_base = addPlaceholder("render_base", nil, nil, {{"WPN_MAV_NTO", 0}})
	
	local	render_tv					= CreateElement "ceTexPoly"
			render_tv.name			= "screen"
			render_tv.vertices		= verts
			render_tv.indices			= {0, 1, 2, 0, 2, 3}
			render_tv.tex_params		= {0.5,0.5, 1.0/(max_pixels_count), 1.0/(max_pixels_count)}
			---------------------------------------------------------------------------------------
			render_tv.material			= "render_target_"..string.format("%d",GetRenderTarget() + 1)
			---------------------------------------------------------------------------------------
			render_tv.controllers		= {{"WPN_AGM65_IR_Render",0}}
			render_tv.level 			= DEFAULT_LEVEL
			render_tv.h_clip_relation	= h_clip_relations.COMPARE
			render_tv.parent_element	= render_base.name
			render_tv.additive_alpha	= true
			render_tv.input_space_SRGB 	= true
	Add(render_tv)

	local	render_mav_ir				= Copy(render_tv)	
			render_mav_ir.material		= MakeMaterial("mfd"..tostring(GetRenderTarget()),{255,255,255,255})
			render_mav_ir.controllers	= {{"WPN_AGM65_IR_Render",1}}
	Add(render_mav_ir)
end

function SetDefaultClipWithLevel(object,level)
	level = level or 0
	object.h_clip_relation = h_clip_relations.COMPARE
	object.level 		   = DEFAULT_LEVEL + level
end

function SetScreenSpace(object)
	object.screenspace = 2
end

mip_filter_used		= true

function use_mipfilter(object)
	if mip_filter_used then
		object.use_mipfilter = true
	end
end

function set_cross(object,cross_size,cross_delta)
	object.vertices	= {{ cross_delta, cross_size},
						{ cross_delta, cross_delta},
						{ cross_size , cross_delta},
						{ cross_size ,-cross_delta},
						{ cross_delta,-cross_delta},
						{ cross_delta,-cross_size},
						{-cross_delta,-cross_size},
						{-cross_delta,-cross_delta},
						{-cross_size ,-cross_delta},
						{-cross_size , cross_delta},
						{-cross_delta, cross_delta},
						{-cross_delta, cross_size}}
	object.indices =  {	11,  0,  1;
						11,  1, 10;
						 1,  2,  3;
						 1,  3,  4;
						 4,  5,  6;
						 4,  6,  7;
						 9, 10,  7;
						 9,  7,  8;
						10,  1,  7;
						 7,  1,  4}
end
