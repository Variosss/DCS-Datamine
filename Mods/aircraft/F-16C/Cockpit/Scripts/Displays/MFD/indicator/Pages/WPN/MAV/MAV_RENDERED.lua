dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/WPN/MAV/MAV_tools.lua")

local rendered_line_width	= 0.003

AddRender()

local videoReady_root = addPlaceholder("videoReady_root", {0,0}, nil, {{"WPN_MAV_NTO", 0}})
SetScreenSpace(videoReady_root)

-- Tracking Gate
back    			= CreateElement "ceMeshPoly"
back.name           = "back"
back.primitivetype  = "triangles"
back.vertices       =  {{-1, 1},
					    { 1, 1},
						{ 1,-1},
						{-1,-1}}
back.indices         = box_ind
back.level		     = DEFAULT_LEVEL
back.h_clip_relation = h_clip_relations.REWRITE_LEVEL
set_as_invisible_mask(back)
back.parent_element = videoReady_root.name
Add(back)
SetScreenSpace(back)

gate					= CreateElement "ceMeshPoly"
gate.name				= "gate"
gate.primitivetype 		= "triangles"
gate.vertices			=  {{-0.05, 0.05},
							{ 0.05, 0.05},
							{ 0.05,-0.05},
							{-0.05,-0.05}}
gate.indices			= box_ind
gate.h_clip_relation 	= h_clip_relations.INCREASE_LEVEL
gate.controllers     	= {{"maverick_force_correlate",-1},{"maverick_frame_size_scale",1 / 0.0625}}
set_as_invisible_mask(gate)
gate.parent_element 	= videoReady_root.name
Add(gate)
SetScreenSpace(gate)

-- Crosshairs
base				= CreateElement "ceSimple"
base.name			= "base"
base.controllers	= {{"maverick_frame_position",2,2}}
base.parent_element	= videoReady_root.name
Add(base)
SetScreenSpace(base)

cross_hair					= CreateElement "ceMeshPoly"
cross_hair.name				= "cross_hair"
cross_hair.primitivetype	= "triangles"
cross_hair.material			= "INDICATION_COMMON_WHITE"
cross_hair.parent_element	= base.name
cross_hair.controllers		= {{"maverick_polarity_change_color",0,0,0}}
set_cross(cross_hair, 5, rendered_line_width)
SetDefaultClipWithLevel(cross_hair)
Add(cross_hair)
SetScreenSpace(cross_hair)

-- Depression Markers
local depression_marks = {}
for i =1,3 do
	depression_marks[i]					= CreateElement "ceMeshPoly"
	depression_marks[i].name			= "depression_marks"..string.format("%d",i)
	depression_marks[i].primitivetype	= "triangles"
	depression_marks[i].material		= "INDICATION_COMMON_WHITE"
	depression_marks[i].vertices		= {	{-(0.05 + rendered_line_width), rendered_line_width},
											{ (0.05 + rendered_line_width), rendered_line_width},
											{ (0.05 + rendered_line_width),-rendered_line_width},
											{-(0.05 + rendered_line_width),-rendered_line_width}}
	depression_marks[i].indices			= box_ind
	depression_marks[i].init_pos		= {0, -i/6, 0}
	depression_marks[i].controllers		= {{"maverick_polarity_change_color",0,0,0}}
	depression_marks[i].parent_element	=  videoReady_root.name
	Add(depression_marks[i])
	SetScreenSpace(depression_marks[i])
end

-- Corner Markers
narrow_width = 0.075
narrow_delta = rendered_line_width
local corner_mark = {}
for i = 1,4 do
	corner_mark[i]					= CreateElement "ceMeshPoly"
	corner_mark[i].name				= "corner_mark"..string.format("%d",i)
	corner_mark[i].primitivetype	= "triangles"
	corner_mark[i].material			= "INDICATION_COMMON_WHITE"
	corner_mark[i].vertices			= { {-narrow_delta,					-narrow_delta},
										{-narrow_delta,					 narrow_width},
										{ 			 0,					 narrow_width + narrow_delta},
										{ narrow_delta,					 narrow_width},
										{ narrow_width,					 narrow_delta},
										{ narrow_width + narrow_delta,	 			0},
										{ narrow_width,					-narrow_delta},
										{ narrow_delta,					 narrow_delta}}
	corner_mark[i].indices			=  {0,1,7; 1,3,7; 1,2,3; 0,7,6; 7,4,6; 4,5,6}
	corner_mark[i].parent_element	=  videoReady_root.name
	corner_mark[i].controllers		= {{"maverick_FOV"},{"maverick_polarity_change_color",0,0,0}}
	use_mipfilter(corner_mark[i])
	Add(corner_mark[i])
	SetScreenSpace(corner_mark[i])
end

corner_mark[1].init_pos       = {-1/2,-1/2,0}
corner_mark[2].init_pos       = {-1/2, 1/2,0}
corner_mark[2].init_rot       = {-90,0,0}
corner_mark[3].init_pos       = { 1/2, 1/2,0}
corner_mark[3].init_rot       = {180,0,0}
corner_mark[4].init_pos       = { 1/2,-1/2,0}
corner_mark[4].init_rot       = {90,0,0}

-- Pointing Cross
local k = (1/6)/math.rad(5)

pointing_cross					= CreateElement "ceMeshPoly"
pointing_cross.name				= "pointing_cross"
pointing_cross.primitivetype	= "triangles"
pointing_cross.material			= "INDICATION_COMMON_WHITE"
pointing_cross.parent_element	= videoReady_root.name
set_cross(pointing_cross, 1/6, rendered_line_width)
pointing_cross.controllers		= {{"maverick_view_angle", k, 1},{"maverick_lock_blinking"},{"maverick_polarity_change_color",0,0,0}}									 
SetDefaultClipWithLevel(pointing_cross)
use_mipfilter(pointing_cross)
Add(pointing_cross)
SetScreenSpace(pointing_cross)

--local openingMask = openMaskArea(0, "CrossArea", {}, {}, {0, 0}, nil, {{"maverick_frame_size", 315 * 1.3}})
--set_box_w_h(openingMask, 10, 10)

--local GridPos1 = addPlaceholder("GridPos1", {0,0}, nil, {{"WPN_MAV_NTO", 0},{"maverick_lock_blinking"}})

--addPlaceholder("GridPos", {0,0}, nil, {{"WPN_MAV_NTO", 0}})

--closeMaskArea(1, "CrossAreaClose", openingMask.vertices, openingMask.indices, openingMask.init_pos, nil, {{"maverick_frame_size", 315 * 1.3}})

--Small_Cross = addPlaceholder("Small_Cross", {0,0}, "GridPos1", {{"WPN_MAV_AGM_Gimbal_Ang", 450, 1}})
--Small_Cross1 = addStrokeLine("Small_Cross1", 90, {0, -45}, 0, "Small_Cross", {{"maverick_polarity_change_color",0,0,0}})
--Small_Cross2 = addStrokeLine("Small_Cross2", 90, {45, 0}, 90, "Small_Cross", {{"maverick_polarity_change_color",0,0,0}})

