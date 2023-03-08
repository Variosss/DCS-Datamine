-- Note: To prevent 'fixed displays' (BULL info, chart scale, etc) to be rendered
-- before cursor, SetLowerLeftCornerOrigin(elem) function should not be used for those.
-- Use direct display coordinates instead of this function.

dofile(LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_TAD_tools.lua")

Add_SOI_border()

--[[
dbg_volume				= CreateElement "ceSimpleLineObject"
dbg_volume.material		= MFCD_GREEN
dbg_volume.width			= 2
dbg_volume.tex_params		= {{0.1,350.5/512},{0.9,350.5/512},{texture_scale,2*texture_scale}}	
dbg_volume.controllers    = {{"tad_depress",(max_pixels_count/2)*GetScale(),(max_pixels_count/2)*GetScale()},
							 {"tad_dbg_volume",(max_pixels_count/2)*GetScale(),(max_pixels_count/2)*GetScale()}}
SetLowerLeftCornerOrigin(dbg_volume)
dbg_volume.init_pos	  = {max_pixels_count/2,max_pixels_count/2}
Add(dbg_volume)
use_mipfilter(dbg_volume)
--]]

function ring_2_pixel(radius)
    local segments = 36 
    local verts = {}
    for i = 1,segments + 1 do
        local alfa = math.rad((i-1) * 360/segments)
 		verts[i] = {radius * math.sin(alfa),radius * math.cos(alfa)}
    end

    local  ring  = line_2_pixel_with_background(verts, DEFAULT_LEVEL, h_clip_relations.COMPARE)
    return ring
end

tad_radius   = 250

tad_1 				  = ring_2_pixel(tad_radius)
tad_1.init_pos		  = {max_pixels_count/2, max_pixels_count/2}
SetLowerLeftCornerOrigin(tad_1)	

tad_3                 = ring_2_pixel(1.5 * tad_radius)
tad_3.parent_element  = tad_1.name				
tad_3.controllers     = {{"tad_depressed"}}

tad_1.controllers = {{"tad_pos_symbology_available"}, {"tad_rings_enable"},
					 {"tad_ring"},
					 {"tad_depress",(max_pixels_count/2)*GetScale(),(max_pixels_count/2)*GetScale()}}


segments = 36
verts = {}
for i = 1, segments + 1 do
	local alfa = math.rad((i-1) * 360/segments)
	verts[i] = {0.5*tad_radius * math.sin(alfa),0.5*tad_radius  * math.cos(alfa)}
end

tad_2_back  		   = line_2_pixel_back(verts,tad_1)
tad_2_back.controllers = {{"tad_north_direction"}}

rotation_tick = {0, -90, -180}

tick_background = {}
tick = {}

for i = 1, 3 do 
	local size  = 2
	local sz 	= 8
	local tex_param_default = 2*texture_scale

	tick_background[i]		 		   = CreateElement "ceTexPoly"
	tick_background[i].material	   = MFCD_BLACK
	tick_background[i].tex_params     = {0.5, 503/512, texture_scale, 0.5*tex_param_default}
	tick_background[i].vertices       = {{0.5 * tad_radius - sz - 0.5, size},
										    {0.5 * tad_radius + sz + 0.5, size},
										    {0.5 * tad_radius + sz + 0.5,-size},
										    {0.5 * tad_radius - sz - 0.5,-size}}
	tick_background[i].indices	 	   = box_ind
	tick_background[i].init_rot	   = {rotation_tick[i],0,0}
	tick_background[i].parent_element = tad_2_back.name
	Add(tick_background[i])
	use_mipfilter(tick_background[i])

	tick[i]		  	       = CreateElement "ceTexPoly"
	tick[i].material	   = MFCD_GREEN
	tick[i].tex_params     = {0.5, 503/512, texture_scale, tex_param_default}
	tick[i].vertices       = {{0.5 * tad_radius - sz , size},
						     {0.5 * tad_radius + sz , size},
							 {0.5 * tad_radius + sz ,-size},
							 {0.5 * tad_radius - sz ,-size}}
	tick[i].indices		   = box_ind
	tick[i].parent_element = tick_background[i].name
	Add(tick[i])
	use_mipfilter(tick[i])
end

tad_2 =  line_2_pixel_main(verts,tad_2_back)

local kh1 = 0.61
local kv1 = kh1 * 0.92
north_background  				= CreateElement "ceTexPoly"
north_background.vertices		= {{-18 * kh1, 13 * kv1},
									{18 * kh1, 13 * kv1},
									{18 * kh1, -13 * kv1},
									{-18 * kh1, -13 * kv1}}
north_background.indices		= box_ind
north_background.material		= MFCD_BLACK
north_background.tex_params		= {33/512, 303/512, (2 / kh1) * texture_scale, (2 / kv1) * texture_scale} 
north_background.parent_element = tad_2.name
north_background.init_pos		= {0, 0.5 * tad_radius + 12, 0}
use_mipfilter(north_background) 
Add(north_background)

local kh2 = kh1 * 0.77
local kv2 = kh2 * 0.7
north				= CreateElement "ceTexPoly"
north.vertices		= {{-18 * kh2, 13 * kv2},
						{18 * kh2, 13 * kv2},
						{18 * kh2, -13 * kv2},
						{-18 * kh2, -13 * kv2}}
north.indices		= box_ind
north.material		= MFCD_GREEN
north.tex_params	= {33/512, 303/512, (2 / kh2) * texture_scale, (2 / kv2) * texture_scale} 
north.parent_element = north_background.name
north.init_pos		= {0, 0, 0}
use_mipfilter(north) 
Add(north)

-- Moved there as TAD symbols and waypoints lines should be rendered
--  over range rings and SOI border
-- Refer to SADL documents for symbology display order
flight_plan_line				= CreateElement "ceSimpleLineObject"
flight_plan_line.material		= MFCD_GREEN
flight_plan_line.width			= 2
flight_plan_line.tex_params		= {{0.1,350.5/512},{0.9,350.5/512},{texture_scale,2*texture_scale}}	
flight_plan_line.controllers    = {{"tad_pos_symbology_available"}, {"tad_flight_plan_lines_enable"},
								   {"tad_scs_available", 0},
								   {"tad_ownship_waypoints_enable"},
								   {"tad_nav_steering_source",0},
								   {"tad_depress",(max_pixels_count/2)*GetScale(),(max_pixels_count/2)*GetScale()},
								   {"tad_flight_plan_line",(max_pixels_count/2)*GetScale(),(max_pixels_count/2)*GetScale()}}
flight_plan_line.h_clip_relation= h_clip_relations.COMPARE
flight_plan_line.level			= DEFAULT_LEVEL
SetLowerLeftCornerOrigin(flight_plan_line)
flight_plan_line.init_pos	  = {max_pixels_count/2,max_pixels_count/2}
Add(flight_plan_line)
use_mipfilter(flight_plan_line)

-- Note: hook connector line should be rendered after waypoint's lines,
--  and before other TAD symbols (finally it works)
hook_connector_line				= CreateElement("ceHWLine")
hook_connector_line.name		= "hook_connector_line"
hook_connector_line.vertices	= {{0				  ,-2}, 
								   {8*max_pixels_count,-2},
								   {8*max_pixels_count, 2},
								   {0				  , 2}}
hook_connector_line.maskvertices		= {{0				  ,-2}, 
								   {8*max_pixels_count,-2},
								   {8*max_pixels_count, 2},
								   {0				  , 2}}
hook_connector_line.indices			= box_ind
hook_connector_line.maxlength		= 8 * max_pixels_count / GetScale()
hook_connector_line.material		= MFCD_YELLOW
hook_connector_line.tex_params		= {0,337.5/512, 2*texture_scale, 2*texture_scale}
hook_connector_line.controllers		= {{"tad_pos_symbology_available"}, {"tad_hook_connector_line_available"}, {"tad_depress", (max_pixels_count/2)*GetScale(), (max_pixels_count/2)*GetScale()},
									{"tad_hook_connector_line", (max_pixels_count/2)*GetScale(), (max_pixels_count/2)*GetScale(), 1/GetScale(), 19 * GetScale(), 32 * GetScale(), 2 * GetScale()},
									{"rotate", math.rad(90.0)}}
hook_connector_line.h_clip_relation		= h_clip_relations.COMPARE
hook_connector_line.level				= DEFAULT_LEVEL
hook_connector_line.use_sigle_line		= true
Add(hook_connector_line)
use_mipfilter(hook_connector_line)

-- const
local ar_x_p = 14
local ar_x_m = 1
local ar_y = 8
local tx = texture_scale * 2.5

-- adjustable
local ar_scale = 0.77
local ar_x_coeff = 1.38
local back_k = 1.22

hook_conn_line_arrow_background				    = CreateElement "ceTexPoly"
hook_conn_line_arrow_background.name		   	= "hook_conn_line_arrow_background"
hook_conn_line_arrow_background.material	   	= MFCD_BLACK
hook_conn_line_arrow_background.vertices         = {{ ar_x_m * ar_scale * ar_x_coeff * back_k, -ar_y * ar_scale * back_k},
											   { ar_x_m * ar_scale * ar_x_coeff * back_k,  ar_y * ar_scale * back_k},
                                               {-ar_x_p * ar_scale * ar_x_coeff * back_k,  ar_y * ar_scale * back_k},
                                               {-ar_x_p * ar_scale * ar_x_coeff * back_k, -ar_y * ar_scale * back_k}}
hook_conn_line_arrow_background.tex_params	   = {4 / 512, 480 / 512, -tx / ar_scale / ar_x_coeff / back_k, tx / ar_scale / back_k}
hook_conn_line_arrow_background.indices         = box_ind
hook_conn_line_arrow_background.controllers	   = {{"tad_hook_connector_line_arrow", (max_pixels_count/2)*GetScale(), (max_pixels_count/2)*GetScale(), 32 * GetScale()}}
hook_conn_line_arrow_background.parent_element  = hook_connector_line.name
--SetLowerLeftCornerOrigin(hook_conn_line_arrow_background)
--hook_conn_line_arrow_background.init_pos = {max_pixels_count/4,max_pixels_count/4}
hook_conn_line_arrow_background.h_clip_relation = h_clip_relations.COMPARE
hook_conn_line_arrow_background.level		   = DEFAULT_LEVEL
Add(hook_conn_line_arrow_background)
use_mipfilter(hook_conn_line_arrow_background)

hook_conn_line_arrow			= CreateElement "ceTexPoly"
hook_conn_line_arrow.name		= "hook_conn_line_arrow"
hook_conn_line_arrow.material	= MFCD_YELLOW
hook_conn_line_arrow.vertices   = {{ ar_x_m * ar_scale * ar_x_coeff, -ar_y * ar_scale},
								   { ar_x_m * ar_scale * ar_x_coeff,  ar_y * ar_scale},
                                   {-ar_x_p * ar_scale * ar_x_coeff,  ar_y * ar_scale},
                                   {-ar_x_p * ar_scale * ar_x_coeff, -ar_y * ar_scale}}
hook_conn_line_arrow.tex_params	    = {4 / 512, 480 / 512, -tx / ar_scale / ar_x_coeff, tx / ar_scale}
hook_conn_line_arrow.indices        = box_ind
hook_conn_line_arrow.parent_element = hook_conn_line_arrow_background.name
hook_conn_line_arrow.init_pos 		= {-2.3, 0}
hook_conn_line_arrow.h_clip_relation = h_clip_relations.COMPARE
hook_conn_line_arrow.level		    = DEFAULT_LEVEL
Add(hook_conn_line_arrow)
use_mipfilter(hook_conn_line_arrow)

-- the TAD dynamic symbology
dummy 			  = CreateElement "ceSimple"
dummy.name 		  = "map_entry_point"
dummy.controllers = {{"tad_pos_symbology_available"}, {"tad_depress",(max_pixels_count/2)*GetScale(),(max_pixels_count/2)*GetScale()},
					 {"tad_draw_objects",(max_pixels_count/2)*GetScale(),(max_pixels_count/2)*GetScale()}}
-- Commented
--SetLowerLeftCornerOrigin(dummy)
--dummy.init_pos	  = {max_pixels_count/2, max_pixels_count/2}
Add(dummy)



el_scs_line				    = CreateElement "ceSimpleLineObject"
el_scs_line.material		= MFCD_GREEN
el_scs_line.width			= 2
el_scs_line.tex_params		= {{0.1,350.5/512},{0.9,350.5/512},{texture_scale,2*texture_scale}}	
el_scs_line.controllers     = {    {"tad_pos_symbology_available"}, {"tad_scs_available", 1}, 
                                   {"tad_depress", (max_pixels_count/2) * GetScale(), (max_pixels_count/2) * GetScale()},
								   {"tad_scs_line", (max_pixels_count/2)*GetScale(),(max_pixels_count/2)*GetScale()},								   
							  }
el_scs_line.h_clip_relation = h_clip_relations.COMPARE
el_scs_line.level			= DEFAULT_LEVEL
SetLowerLeftCornerOrigin(el_scs_line)
el_scs_line.init_pos	    = {max_pixels_count/2,max_pixels_count/2}
Add(el_scs_line)
use_mipfilter(el_scs_line)

tad_cursor = add_tad_cursor()
tad_cursor.controllers = {{"tad_pos_symbology_available"}, {"tad_depress",(max_pixels_count/2)*GetScale(),(max_pixels_count/2)*GetScale()},
						  {"tad_cursor",(max_pixels_count/2)*GetScale(),(max_pixels_count/2)*GetScale()}}


scale						= CreateElement "ceStringPoly"
scale.name					= "TAD_scale"
scale.UseBackground			= true
scale.material				= font_MFCD
scale.BackgroundMaterial	= MFCD_SOLID_BLACK	  
scale.stringdefs			= predefined_fonts[2]
scale.alignment				= "RightCenter"
scale.formats 				= {"%s"}
scale.controllers			= {{"tad_pos_symbology_available"}, {"declutter"}, {"tad_fov_type", 0}, {"tad_scale", 0}}
scale.init_pos			    = {soi_max_x + 15 - max_pixels_count / 2,
                               soi_max_y + 2 - max_pixels_count / 2}
Add(scale)
use_mipfilter(scale)
--SetLowerLeftCornerOrigin(scale)

tad_fov_EXP1              = Copy(scale)
tad_fov_EXP1.name         = "TAD_EXP1"
tad_fov_EXP1.controllers  = {{"declutter"}, {"tad_fov_type", 1}, {"tad_fov_and_scale_blink", 0.5}}
tad_fov_EXP1.value	      = "EXP1"
Add(tad_fov_EXP1)

tad_fov_EXP2              = Copy(scale)
tad_fov_EXP2.name         = "TAD_EXP2"
tad_fov_EXP2.controllers  = {{"declutter"}, {"tad_fov_type", 2}, {"tad_fov_and_scale_blink",0.5}}
tad_fov_EXP2.value        = "EXP2"
Add(tad_fov_EXP2)


current_chart 							= default_label_text(6, true)
current_chart.formats					= {"%s"}
current_chart.controllers				= {{"tad_pos_symbology_available"}, {"declutter"}, {"tad_fov_and_scale_blink", 0.5}, {"tad_chart", 0}}
current_chart.init_pos					= {soi_max_x + 15 - max_pixels_count / 2,
                                           OSB_positions[6][2] + 40 - max_pixels_count / 2}

NO_LINK_txt						= CreateElement "ceStringPoly"
NO_LINK_txt.name				= "NO_LINK_txt"
NO_LINK_txt.material			= font_MFCD
NO_LINK_txt.UseBackground	    = true
NO_LINK_txt.BackgroundMaterial  = MFCD_SOLID_BLACK
NO_LINK_txt.alignment			= "CenterCenter"
NO_LINK_txt.init_pos			= {0, 518 - max_pixels_count/2}
NO_LINK_txt.value				= "NO LINK"
NO_LINK_txt.stringdefs			= predefined_fonts[1]
NO_LINK_txt.controllers			= {{"tad_DL_no_link", 1}}
Add(NO_LINK_txt)
use_mipfilter(NO_LINK_txt)

------------------------------------------------
add_tad_hook_info()
------------------------------------------------
add_bullseye_info()
Add_NOT_SOI_display_TAD()


