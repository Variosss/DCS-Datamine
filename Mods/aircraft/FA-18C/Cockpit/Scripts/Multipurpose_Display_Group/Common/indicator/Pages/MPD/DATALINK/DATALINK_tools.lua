dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

max_pixels_count = 900

box_ind   = {0,1,2,2,3,0}

function set_as_invisible_mask(obj)
	local show_masks = false
	obj.isvisible = show_masks
	obj.material  = "MASK_MATERIAL"
end

function AddRender()
	local   verts 			     = {{-max_pixels_count/2,  max_pixels_count/2},
									 { max_pixels_count/2,  max_pixels_count/2}, 
									 { max_pixels_count/2, -max_pixels_count/2/1.2},
									 {-max_pixels_count/2, -max_pixels_count/2/1.2}}
	
	local   back    		 	 = CreateElement "ceMeshPoly"
			back.primitivetype   = "triangles"
			back.vertices        = verts
			back.indices         = box_ind
			set_as_invisible_mask(back)
			back.level		     = DEFAULT_LEVEL
			back.h_clip_relation = h_clip_relations.REWRITE_LEVEL
			Add(back)
	
	local render_tv					= CreateElement "ceTexPoly"
		  render_tv.name			= "screen_DATALINK"
		  render_tv.vertices		= verts
		  render_tv.indices			= {0, 1, 2, 0, 2, 3}
		  render_tv.tex_params		= {0.5,0.5, 1.0/(max_pixels_count), 1.0/(max_pixels_count)}
		  ---------------------------------------------------------------------------------------
		  render_tv.material		= "render_target_"..string.format("%d",GetRenderTarget() + 1)
		  ---------------------------------------------------------------------------------------
		  render_tv.controllers		= {{"MPD_SMS_DATALINK_TV_Render"}}
		  render_tv.level 			= DEFAULT_LEVEL
		  render_tv.h_clip_relation = h_clip_relations.COMPARE
		  render_tv.additive_alpha  = true
		  render_tv.input_space_SRGB = true
		Add(render_tv)
end


function set_cross(object,cross_size,cross_delta)
	object.vertices       =  {{ cross_delta, cross_size},
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
	object.indices        =  {	11,0,1;
								11,1,10;
								1,2,3;
								1,3,4;
								4,5,6;
								4,6,7;
								9,10,7;
								9,7,8;
								10,1,7;
								7,1,4}
								
end


function set_cross_X(object,cross_size,cross_delta)

    local delta2 = cross_delta / math.sin(math.rad(45))
    
	object.vertices       =  {{0                  ,delta2},
                              {cross_size - delta2,cross_size},
                              {cross_size         ,cross_size - delta2},
                              {delta2             ,0},
                              {cross_size,-(cross_size - delta2)},
                              {cross_size- delta2,- cross_size},
                              {0,- delta2},
                              {-(cross_size - delta2),-cross_size},
                              {-cross_size ,-(cross_size- delta2)},
                              {-delta2 ,0},
                              {-cross_size ,cross_size - delta2},
                              {-(cross_size - delta2) ,cross_size}}

	object.indices        =  {	7,9,3;
                                1,3,9;
                                7,8,9;
                                1,2,3;
                                9,10,11;
                                9,11,0;
                                3,5,6;
                                3,4,5}						
end

function SetScreenSpace(object)
	object.screenspace = 2
end

function SetDefaultClipWithLevel(object,level)
	level = level or 0
	object.h_clip_relation = h_clip_relations.COMPARE
	object.level 		   = DEFAULT_LEVEL + level
end

function use_mipfilter(object)
	if mip_filter_used then
		object.use_mipfilter = true
	end
end