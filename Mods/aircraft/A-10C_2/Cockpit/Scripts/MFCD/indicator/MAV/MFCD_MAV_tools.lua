dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")

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

function add_maverick_dynamic_launch_zone()

local 	dlz_size   = 25
local   dlz_range = 15
local   range_coefficient = 320 - (22 + 10) - (10 + 14) -- 15 nm by design doc
	    range_coefficient = (range_coefficient / dlz_range) / 1852 -- in meters
local 	k = 2 / 1.7

local   dlz_base      		 = CreateElement "ceSimple"
		dlz_base.name        = "dlz_base"
		SetLowerLeftCornerOrigin(dlz_base)
		dlz_base.init_pos	 = {soi_min_x - 21, soi_min_y + size_ARS * 2}
		dlz_base.controllers = {{"maverick_DLZ_is_available"}, {"render_available"}}
		Add(dlz_base)

local   occulation_zone 			   = CreateElement "ceMeshPoly"
		occulation_zone.primitivetype = "triangles"
		occulation_zone.vertices =  {{0,  0},
		                             {52, 0},
									 {52, 320},
									 {0,  320}}
		occulation_zone.indices 		 = box_ind
		occulation_zone.material        = MFCD_SOLID_BLACK
		occulation_zone.parent_element  = dlz_base.name
		Add(occulation_zone)

local 	lower_tick_base      	       = CreateElement "ceSimple"
		lower_tick_base.name           = "lower_tick_base"
		lower_tick_base.parent_element = dlz_base.name
		lower_tick_base.init_pos       = {10, 22 + 10}
		Add(lower_tick_base)

local	flight_time						= CreateElement "ceStringPoly"
		flight_time.material			= font_MFCD
		flight_time.UseBackground		= true
		flight_time.BackgroundMaterial	= MFCD_SOLID_BLACK
		flight_time.alignment			= "LeftTop"
		flight_time.stringdefs			= predefined_fonts[1]
		flight_time.formats            	= {"%3.f"}
		flight_time.parent_element		= lower_tick_base.name
		flight_time.init_pos  			= {-4, 0}
		flight_time.controllers         = {{"maverick_DLZ_range_inside_staple"}, {"maverick_DLZ_time_text"}}
		use_mipfilter(flight_time) 
		Add(flight_time)

local	flight_time_XXX 				= Copy(flight_time)
		flight_time_XXX.controllers     = {{"maverick_DLZ_range_inside_staple", -1}}
		flight_time_XXX.value			= "XXX"
		Add(flight_time_XXX)

local	lower_tick 				  = line_2_pixel_with_background({{0, 0}, {dlz_size, 0}})
		lower_tick.parent_element = lower_tick_base.name

local 	staple_base      	       = CreateElement "ceSimple"
		staple_base.name           = "staple_base"
		staple_base.parent_element = lower_tick.name
		staple_base.controllers    = {{"maverick_in_limits", math.rad(30)}}
		Add(staple_base)

		local CaretBackW = 16
		local CaretBackHalfH = 10
		
local	range_caret_background  = CreateElement "ceTexPoly"
		range_caret_background.vertices = {{0, CaretBackHalfH * k},
											{CaretBackW * k , CaretBackHalfH * k},
											{CaretBackW * k ,-CaretBackHalfH * k},
											{0, -CaretBackHalfH * k}}
		range_caret_background.indices    = box_ind
		range_caret_background.material   = MFCD_BLACK
		range_caret_background.tex_params = {4.5 / 512, 479.5 / 512, (2 / k) * texture_scale, (2 / k) * texture_scale} 
		range_caret_background.parent_element = staple_base.name
		range_caret_background.init_pos   = {dlz_size, 0}
		use_mipfilter(range_caret_background) 
		range_caret_background.controllers = {{"WOW", 0}, {"maverick_DLZ_range_tic", range_coefficient * GetScale(), 0, dlz_range * 1852}}
		Add(range_caret_background)

		local CaretW = 16
		local CaretHalfH = 9
		
local	range_caret  = CreateElement "ceTexPoly"
		range_caret.vertices = {{0 , CaretHalfH},
								 {CaretW, CaretHalfH},
								 {CaretW,-CaretHalfH},
								 {0 ,-CaretHalfH}}
		range_caret.indices    = box_ind
		range_caret.material   = MFCD_GREEN
		range_caret.tex_params = {4.5 / 512, 479.5 / 512, 2.1 * texture_scale, 2 * texture_scale} 
		range_caret.parent_element = range_caret_background.name
		range_caret.init_pos   = {1, 0}
		use_mipfilter(range_caret) 
		Add(range_caret)

local	range_text						= CreateElement "ceStringPoly"
		range_text.material				= font_MFCD
		range_text.UseBackground		= true
		range_text.BackgroundMaterial	= MFCD_SOLID_BLACK
		range_text.alignment			= "LeftCenter"
		range_text.stringdefs			= predefined_fonts[1]
		range_text.formats            	= {"%3.1f"}
		range_text.parent_element		= range_caret.name
		range_text.init_pos  			= {15.5, 0}
		range_text.controllers          = {{"maverick_DLZ_range_text"}}
		use_mipfilter(range_text) 
		Add(range_text)

local	upper_tick 				  = line_2_pixel_with_background({{0, 0}, {dlz_size, 0}})
		upper_tick.init_pos       = {10, 310 - 14}
		upper_tick.parent_element = dlz_base.name

local	staple_max_clipper 				 = CreateElement "ceMeshPoly"
		staple_max_clipper.primitivetype = "triangles"
		staple_max_clipper.vertices      = {{-3, -1.1},
		                                    {dlz_size + 5, -1.1},
									        {dlz_size + 5, 501},
									        {-3, 501}}
		staple_max_clipper.indices 		   = box_ind
		staple_max_clipper.h_clip_relation = h_clip_relations.INCREASE_LEVEL
		staple_max_clipper.parent_element  = staple_base.name
		set_as_invisible_mask(staple_max_clipper)
		staple_max_clipper.controllers     = {{"maverick_DLZ_max_tic",range_coefficient * GetScale()}}
		Add(staple_max_clipper)
							   
local	staple_max                = line_2_pixel_with_background({{0, 0}, {dlz_size + 1, 0}})
		staple_max.parent_element = staple_max_clipper.name

local	staple_min                = line_2_pixel_with_background({{0, 0}, {dlz_size, 0}, {dlz_size, 500}}, DEFAULT_LEVEL, h_clip_relations.COMPARE)
		staple_min.parent_element = staple_base.name
		staple_min.controllers    = {{"maverick_DLZ_min_tic",range_coefficient * GetScale()}}
end