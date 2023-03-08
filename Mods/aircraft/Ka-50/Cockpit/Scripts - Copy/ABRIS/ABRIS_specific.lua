dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
-------------------------------------------------------------------------------

function set_use_waypoint(elm)
	elm.controllers = {{"specific_waypoint",x_size,x_size}}
end

function set_use_waypoint_remove_orientation(elm)
	elm.controllers = {{"specific_waypoint",x_size,x_size},{"remove_orientation"}}
end

function set_use_datalink(elm)
	elm.controllers = {{"specific_set_datalink_target",x_size,x_size},{"remove_orientation"}}
end

function set_use_datalink_group_member(elm)
	elm.controllers = {{"specific_set_datalink_target",x_size,x_size}}
end

function set_use_route_segment(elm)
	elm.controllers = {{"specific_route_segment",x_size,x_size}}
end

function set_use_satellite(elm)
	elm.controllers = {{"specific_satellite",horizon_size_X * 0.07675,horizon_size_Y * 0.07675},
					   {"specific_satellite_color",0.0, 1.0, 0.0, 0.5, 0.5, 0.5, 1.0, 1.0, 1.0}}
end

function add_waypoint_info(parent,color,route_wpt)

local el_wpt_name                   = CreateElement "ceStringPoly"
el_wpt_name.material		  = "font_Ka-50_ABRIS_"..color
el_wpt_name.formats			  = {"%s"}
el_wpt_name.alignment		  = "LeftCenter"
el_wpt_name.stringdefs		  = abris_font[7]
el_wpt_name.parent_element    = parent.name
--el_wpt_name.init_pos          = {0.03*x_size,0.01*x_size,0}
el_wpt_name.controllers       = {{"specific_waypoint_name",0},
								 {"review_change_color",1,1,1},
								 {"remove_orientation"} ,--}--,
								 {"move",0.03*x_size*GetScale(),0.01*x_size*GetScale()}}
SetDefaultClipWithLevel(el_wpt_name,3)
Add(el_wpt_name)
use_mipfilter(el_wpt_name)

return el_wpt_name

end

function add_waypoint_full_description(parent,color,route_wpt)

local el_wpt_desc             = CreateElement "ceStringPoly"
el_wpt_desc.material		  = "font_Ka-50_ABRIS_"..color
el_wpt_desc.formats			  = {"%s"}
el_wpt_desc.alignment		  = "LeftTop"
el_wpt_desc.stringdefs		  = {0.004,0.7 * 0.004,0,-0.0005}
el_wpt_desc.parent_element    = parent.name
el_wpt_desc.controllers       = {{"specific_waypoint_description",0},
								 {"review_change_color",1,1,1},
								 {"move",0,-0.03*x_size*GetScale()}}
SetDefaultClipWithLevel(el_wpt_desc,3)
Add(el_wpt_desc)
use_mipfilter(el_wpt_desc)
return el_wpt_desc
end

function add_waypoint_info_datalink(parent,color)

local el_wpt_name             = CreateElement "ceStringPoly"
el_wpt_name.material		  = "font_Ka-50_ABRIS_"..color
el_wpt_name.formats			  = {"%s"}
el_wpt_name.alignment		  = "CenterCenter"
el_wpt_name.stringdefs		  = abris_font[7]
el_wpt_name.parent_element    = parent.name
el_wpt_name.init_pos          = {-0.01*x_size,0.0,0}
el_wpt_name.controllers       = {{"specific_waypoint_name",0},
								 {"review_change_color",1,1,1},
								 {"remove_orientation"}}
SetDefaultClipWithLevel(el_wpt_name,3)
Add(el_wpt_name)
use_mipfilter(el_wpt_name)
end

function add_waypoint_info_preplanned_threat(parent,color)

local el_wpt_name             = CreateElement "ceStringPoly"
el_wpt_name.material		  = "font_Ka-50_ABRIS_"..color
el_wpt_name.formats			  = {"%s"}
el_wpt_name.alignment		  = "LeftCenter"
el_wpt_name.stringdefs		  = abris_font[7]
el_wpt_name.parent_element    = parent.name
el_wpt_name.init_pos          = {0.05*x_size,0.0,0}
el_wpt_name.controllers       = {{"specific_waypoint_name",0},
								 {"review_change_color",1,1,1},
								 {"remove_orientation"}}
SetDefaultClipWithLevel(el_wpt_name,3)
Add(el_wpt_name)
use_mipfilter(el_wpt_name)
end

function add_waypoint_info_datalink_group_member(parent,color)

local el_wpt_name             = CreateElement "ceStringPoly"
el_wpt_name.material		  = "font_Ka-50_ABRIS_"..color
el_wpt_name.formats			  = {"%s"}
el_wpt_name.alignment		  = "CenterCenter"
el_wpt_name.stringdefs		  = abris_font[7]
el_wpt_name.parent_element    = parent.name
el_wpt_name.init_pos          = {-0.01*x_size,0.01*x_size,0.0}
--el_wpt_name.init_pos          = {0,0,0}
el_wpt_name.controllers       = {{"specific_waypoint_name",0},
								 {"review_change_color",1,1,1}}
SetDefaultClipWithLevel(el_wpt_name,3)
Add(el_wpt_name)
use_mipfilter(el_wpt_name)
end

function add_spi_marks(parent)
	
	local spi_mark_center_x = 233/512
	local spi_mark_center_y = 136/512
	local spi_mark_size_x = (136 - 125)/512
	local spi_mark_size_y = (233 - 222)/512

	
	spi_mark                = CreateElement "ceTexPoly"
	spi_mark.name           = "spi_mark"
	spi_mark.vertices       = { {-spi_mark_size_x/scale_wpt_spi, spi_mark_size_y/scale_wpt_spi},
								{ spi_mark_size_x/scale_wpt_spi, spi_mark_size_y/scale_wpt_spi},
								{ spi_mark_size_x/scale_wpt_spi,-spi_mark_size_y/scale_wpt_spi},
								{-spi_mark_size_x/scale_wpt_spi,-spi_mark_size_y/scale_wpt_spi}}
	spi_mark.indices        = box_ind
	spi_mark.material       = "INDICATION_ABRIS_YELLOW"
	spi_mark.tex_params		= {spi_mark_center_x, spi_mark_center_y, scale_wpt_spi, scale_wpt_spi}
	spi_mark.parent_element = parent.name
	SetDefaultClipWithLevel(spi_mark,3)
	set_use_waypoint(spi_mark)
	Add(spi_mark)
	use_mipfilter(spi_mark)
end

el_smpl_wpt                = CreateElement "ceTexPoly"
el_smpl_wpt.name           = "el_smpl_wpt"
el_smpl_wpt.vertices       = {{-simple_wpt.x_sz/scale_wpt_small, simple_wpt.x_sz/scale_wpt_small},
							  { simple_wpt.x_sz/scale_wpt_small, simple_wpt.x_sz/scale_wpt_small},
							  { simple_wpt.x_sz/scale_wpt_small,-simple_wpt.x_sz/scale_wpt_small},
							  {-simple_wpt.x_sz/scale_wpt_small,-simple_wpt.x_sz/scale_wpt_small}}
el_smpl_wpt.indices        = box_ind
el_smpl_wpt.material       = "INDICATION_ABRIS_RED"
el_smpl_wpt.tex_params	   = {simple_wpt.x_st,simple_wpt.y_st,scale_wpt_small,scale_wpt_small}
SetDefaultClipWithLevel(el_smpl_wpt,3)
set_use_waypoint(el_smpl_wpt)
Add(el_smpl_wpt)
use_mipfilter(el_smpl_wpt)
add_waypoint_info(el_smpl_wpt,"BLACK",0)
-------------------------------------------------------------------------------
el_smpl_wpt_curr                = CreateElement "ceTexPoly"
el_smpl_wpt_curr.name           = "el_smpl_wpt_curr"
el_smpl_wpt_curr.vertices       = { {-simple_wpt_curr.x_sz/scale_wpt_small, simple_wpt_curr.x_sz/scale_wpt_small},
									{ simple_wpt_curr.x_sz/scale_wpt_small, simple_wpt_curr.x_sz/scale_wpt_small},
									{ simple_wpt_curr.x_sz/scale_wpt_small,-simple_wpt_curr.x_sz/scale_wpt_small},
									{-simple_wpt_curr.x_sz/scale_wpt_small,-simple_wpt_curr.x_sz/scale_wpt_small}}
el_smpl_wpt_curr.indices        = box_ind
el_smpl_wpt_curr.material       = "INDICATION_ABRIS_RED"
el_smpl_wpt_curr.tex_params		= {simple_wpt_curr.x_st,simple_wpt_curr.y_st,scale_wpt_small,scale_wpt_small}
SetDefaultClipWithLevel(el_smpl_wpt_curr,3)
set_use_waypoint(el_smpl_wpt_curr)
Add(el_smpl_wpt_curr)
add_waypoint_info(el_smpl_wpt_curr,"BLACK",0)
use_mipfilter(el_smpl_wpt_curr)

-------------------------------------------------------------------------------
el_beacon_wpt_arrow                = CreateElement "ceTexPoly"
el_beacon_wpt_arrow.name           = "el_beacon_wpt_arrow"
el_beacon_wpt_arrow.vertices       = { {-beacon_wpt_arrow.x_sz_mi/scale_wpt_big,beacon_wpt_arrow.y_sz_pl/scale_wpt_big},
									   { beacon_wpt_arrow.x_sz_pl/scale_wpt_big,beacon_wpt_arrow.y_sz_pl/scale_wpt_big},
									   { beacon_wpt_arrow.x_sz_pl/scale_wpt_big,-beacon_wpt_arrow.y_sz_mi/scale_wpt_big},
									   {-beacon_wpt_arrow.x_sz_mi/scale_wpt_big,-beacon_wpt_arrow.y_sz_mi/scale_wpt_big}}
el_beacon_wpt_arrow.indices        = box_ind
el_beacon_wpt_arrow.material       = "INDICATION_ABRIS_RED"
el_beacon_wpt_arrow.tex_params		= {beacon_wpt_arrow.x_st,beacon_wpt_arrow.y_st,scale_wpt_big,scale_wpt_big}
SetDefaultClipWithLevel(el_beacon_wpt_arrow,3)
set_use_waypoint_remove_orientation(el_beacon_wpt_arrow)
Add(el_beacon_wpt_arrow)
add_waypoint_info(el_beacon_wpt_arrow,"BLACK",1)
use_mipfilter(el_beacon_wpt_arrow)

-------------------------------------------------------------------------------
el_beacon_wpt                = CreateElement "ceTexPoly"
el_beacon_wpt.name           = "el_beacon_wpt"
el_beacon_wpt.vertices       = {	 {-beacon_wpt.x_sz/scale_wpt_big,beacon_wpt.y_sz_pl/scale_wpt_big},
									 { beacon_wpt.x_sz/scale_wpt_big,beacon_wpt.y_sz_pl/scale_wpt_big},
									 { beacon_wpt.x_sz/scale_wpt_big,-beacon_wpt.y_sz_mi/scale_wpt_big},
									 {-beacon_wpt.x_sz/scale_wpt_big,-beacon_wpt.y_sz_mi/scale_wpt_big}}
el_beacon_wpt.indices        = box_ind
el_beacon_wpt.material       = "INDICATION_ABRIS_RED"
el_beacon_wpt.tex_params		= {beacon_wpt.x_st,beacon_wpt.y_st,scale_wpt_big,scale_wpt_big}
SetDefaultClipWithLevel(el_beacon_wpt,3)
set_use_waypoint_remove_orientation(el_beacon_wpt)
Add(el_beacon_wpt)
add_waypoint_info(el_beacon_wpt,"RED",1)
use_mipfilter(el_beacon_wpt)

local Landmark_center_x =  134.5/512
local Landmark_center_y =  37/512
local Landmark_size_x   = (149 - 134.5)/512
local Landmark_size_y   = (53  - 37)/512

el_landmark 			   = Copy(el_beacon_wpt)
el_landmark.name 		   = "el_landmark"
el_landmark.material       = "INDICATION_ABRIS_BLACK"
el_landmark.vertices       = {{-Landmark_size_x/scale_wpt_big, Landmark_size_y/scale_wpt_big},
							  { Landmark_size_x/scale_wpt_big, Landmark_size_y/scale_wpt_big},
							  { Landmark_size_x/scale_wpt_big,-Landmark_size_y/scale_wpt_big},
							  {-Landmark_size_x/scale_wpt_big,-Landmark_size_y/scale_wpt_big}}
el_landmark.controllers    = {{"specific_waypoint",x_size,x_size},{"remove_orientation"},{"review_change_color",1,1,1}}
el_landmark.tex_params	   = {Landmark_center_x, Landmark_center_y, scale_wpt_big, scale_wpt_big}
Add(el_landmark)
add_waypoint_info(el_landmark,"BLACK",1)

local Refpoint_center_x =  18/512
local Refpoint_center_y =  82/512
local Refpoint_size_x   = (27 - 18)/512
local Refpoint_size_y   = (89  - 82)/512

el_refpoint 			   = Copy(el_beacon_wpt)
el_refpoint.name 		   = "el_refpoint"
el_refpoint.material       = "INDICATION_ABRIS_BLACK"
el_refpoint.vertices       = {{-Refpoint_size_x/scale_wpt_big, Refpoint_size_y/scale_wpt_big},
							  { Refpoint_size_x/scale_wpt_big, Refpoint_size_y/scale_wpt_big},
							  { Refpoint_size_x/scale_wpt_big,-Refpoint_size_y/scale_wpt_big},
							  {-Refpoint_size_x/scale_wpt_big,-Refpoint_size_y/scale_wpt_big}}
el_refpoint.controllers    = {{"specific_waypoint",x_size,x_size},{"remove_orientation"},{"review_change_color",1,1,1}}
el_refpoint.tex_params	   = {Refpoint_center_x, Refpoint_center_y, scale_wpt_big, scale_wpt_big}
Add(el_refpoint)
local name_ = add_waypoint_info(el_refpoint,"BLACK",1)
local desc_ = add_waypoint_full_description(name_,"BLACK",1)


local Obstacle_center_x =  468/512
local Obstacle_center_y =  300/512
local Obstacle_size_x   = (483 - 468)/512
local Obstacle_size_y   = (300  - 282)/512

el_obstacle 			   =  Copy(el_refpoint)
el_obstacle.name 		   =  "el_obstacle"
el_obstacle.vertices       = {{-Obstacle_size_x/scale_wpt_big, Obstacle_size_y/scale_wpt_big},
							  { Obstacle_size_x/scale_wpt_big, Obstacle_size_y/scale_wpt_big},
							  { Obstacle_size_x/scale_wpt_big,-Obstacle_size_y/scale_wpt_big},
							  {-Obstacle_size_x/scale_wpt_big,-Obstacle_size_y/scale_wpt_big}}
el_obstacle.tex_params	   = {Obstacle_center_x, Obstacle_center_y, scale_wpt_big, scale_wpt_big}
Add(el_obstacle)
add_waypoint_info(el_obstacle,"BLACK",1)

local VOR_center_x =  367.5/512
local VOR_center_y =  81.5/512
local VOR_size_x   = (385 - 367.5)/512
local VOR_size_y   = (81.5  - 67)/512

el_beacon_VOR              = Copy(el_refpoint)
el_beacon_VOR.name	       = "el_beacon_VOR"
el_beacon_VOR.material     = "INDICATION_ABRIS_BLACK"
el_beacon_VOR.vertices     = {{-VOR_size_x/scale_wpt_big, VOR_size_y/scale_wpt_big},
							  { VOR_size_x/scale_wpt_big, VOR_size_y/scale_wpt_big},
							  { VOR_size_x/scale_wpt_big,-VOR_size_y/scale_wpt_big},
							  {-VOR_size_x/scale_wpt_big,-VOR_size_y/scale_wpt_big}}
el_beacon_VOR.tex_params   = {VOR_center_x,VOR_center_y,scale_wpt_big,scale_wpt_big}
Add(el_beacon_VOR)
add_waypoint_info(el_beacon_VOR,"BLACK",1)


local DME_center_x =  276/512
local DME_center_y = VOR_center_y
local DME_size_x   = (298.5 - 276)/512
local DME_size_y   = VOR_size_y

el_beacon_DME              = Copy(el_beacon_VOR)
el_beacon_DME.name	       = "el_beacon_DME"
el_beacon_DME.material     = "INDICATION_ABRIS_BLACK"
el_beacon_DME.vertices     = {{-DME_size_x/scale_wpt_big, DME_size_y/scale_wpt_big},
							  { DME_size_x/scale_wpt_big, DME_size_y/scale_wpt_big},
							  { DME_size_x/scale_wpt_big,-DME_size_y/scale_wpt_big},
							  {-DME_size_x/scale_wpt_big,-DME_size_y/scale_wpt_big}}
el_beacon_DME.tex_params   = {DME_center_x,DME_center_y,scale_wpt_big,scale_wpt_big}
Add(el_beacon_DME)
add_waypoint_info(el_beacon_DME,"BLACK",1)

local VORDME_center_x =  325.5/512
local VORDME_center_y = VOR_center_y
local VORDME_size_x   = DME_size_x
local VORDME_size_y   = VOR_size_y

el_beacon_VORDME               = Copy(el_beacon_DME)
el_beacon_VORDME.name	       = "el_beacon_VORDME"
el_beacon_VORDME.tex_params    =  {VORDME_center_x,VORDME_center_y,scale_wpt_big,scale_wpt_big}
Add(el_beacon_VORDME)
add_waypoint_info(el_beacon_VORDME,"BLACK",1)


local TACAN_center_x =  448.25/512
local TACAN_center_y = VOR_center_y
local TACAN_size_x   = (468 - 448.25)/512
local TACAN_size_y   = 101/512 - VOR_center_y

el_beacon_TACAN              = Copy(el_beacon_DME)
el_beacon_TACAN.name	     = "el_beacon_TACAN"
el_beacon_TACAN.vertices     =  {{-TACAN_size_x/scale_wpt_big,  TACAN_size_y/scale_wpt_big},
								 { TACAN_size_x/scale_wpt_big,  TACAN_size_y/scale_wpt_big},
								 { TACAN_size_x/scale_wpt_big, -TACAN_size_y/scale_wpt_big},
								 {-TACAN_size_x/scale_wpt_big, -TACAN_size_y/scale_wpt_big}}
el_beacon_TACAN.tex_params   =  {TACAN_center_x,TACAN_center_y,scale_wpt_big,scale_wpt_big}
Add(el_beacon_TACAN)
add_waypoint_info(el_beacon_TACAN,"BLACK",1)


local VORTACAN_center_x =  491.5/512

el_beacon_VORTACAN              = Copy(el_beacon_TACAN)
el_beacon_VORTACAN.name	        = "el_beacon_VORTACAN"
el_beacon_VORTACAN.tex_params   =  {VORTACAN_center_x,TACAN_center_y,scale_wpt_big,scale_wpt_big}
Add(el_beacon_VORTACAN)
add_waypoint_info(el_beacon_VORTACAN,"BLACK",1)

local NDB_center_x =  325.5/512
local NDB_center_y =    138/512
local NDB_size     =  (138 - 121)/512



el_beacon_NDB              = Copy(el_beacon_TACAN)
el_beacon_NDB.name	        = "el_beacon_NDB"
el_beacon_NDB.vertices     =  {{-NDB_size/scale_wpt_big,  NDB_size/scale_wpt_big},
							   { NDB_size/scale_wpt_big,  NDB_size/scale_wpt_big},
							   { NDB_size/scale_wpt_big, -NDB_size/scale_wpt_big},
							   {-NDB_size/scale_wpt_big, -NDB_size/scale_wpt_big}}
el_beacon_NDB.tex_params   =  {NDB_center_x,NDB_center_y,scale_wpt_big,scale_wpt_big}
Add(el_beacon_NDB)
add_waypoint_info(el_beacon_NDB,"BLACK",1)

-------------------------------------------------------------------------------
el_marker_wpt                = CreateElement "ceTexPoly"
el_marker_wpt.name           = "el_marker_wpt"
el_marker_wpt.vertices       = { {-marker_wpt.x_sz/scale_wpt,marker_wpt.y_sz/scale_wpt},
									   {marker_wpt.x_sz/scale_wpt,marker_wpt.y_sz/scale_wpt},
									   { marker_wpt.x_sz/scale_wpt,-marker_wpt.y_sz/scale_wpt},
									   {-marker_wpt.x_sz/scale_wpt,-marker_wpt.y_sz/scale_wpt}}
el_marker_wpt.indices        = box_ind
el_marker_wpt.material       = "INDICATION_ABRIS_RED"
el_marker_wpt.tex_params		= {marker_wpt.x_st,marker_wpt.y_st,scale_wpt,scale_wpt}
SetDefaultClipWithLevel(el_marker_wpt,3)
set_use_waypoint(el_marker_wpt)
Add(el_marker_wpt)
add_waypoint_info(el_marker_wpt,"RED",0)
use_mipfilter(el_marker_wpt)
-------------------------------------------------------------------------------
el_smpl_wpt_big_solid                = CreateElement "ceTexPoly"
el_smpl_wpt_big_solid.name           = "el_smpl_wpt_big_solid"
el_smpl_wpt_big_solid.vertices       = {  {-solid_simple_wpt.x_sz/scale_wpt_big, solid_simple_wpt.x_sz/scale_wpt_big},
										  { solid_simple_wpt.x_sz/scale_wpt_big, solid_simple_wpt.x_sz/scale_wpt_big},
										  { solid_simple_wpt.x_sz/scale_wpt_big,-solid_simple_wpt.x_sz/scale_wpt_big},
										  {-solid_simple_wpt.x_sz/scale_wpt_big,-solid_simple_wpt.x_sz/scale_wpt_big}}
el_smpl_wpt_big_solid.indices        = box_ind
el_smpl_wpt_big_solid.material       = "INDICATION_ABRIS_GREEN"
el_smpl_wpt_big_solid.tex_params	 = {solid_simple_wpt.x_st,solid_simple_wpt.y_st,scale_wpt_big,scale_wpt_big}
SetDefaultClipWithLevel(el_smpl_wpt_big_solid,3)
--set_use_waypoint_remove_orientation(el_smpl_wpt_big_solid)
set_use_waypoint(el_smpl_wpt_big_solid)
Add(el_smpl_wpt_big_solid)
add_waypoint_info(el_smpl_wpt_big_solid,"GREEN",0)
use_mipfilter(el_smpl_wpt_big_solid)
-------------------------------------------------------------------------------
el_smpl_wpt_solid                = CreateElement "ceTexPoly"
el_smpl_wpt_solid.name           = "el_smpl_wpt_solid"
el_smpl_wpt_solid.vertices       = {  {-solid_simple_wpt.x_sz/scale_wpt_small, solid_simple_wpt.x_sz/scale_wpt_small},
									  { solid_simple_wpt.x_sz/scale_wpt_small, solid_simple_wpt.x_sz/scale_wpt_small},
									  { solid_simple_wpt.x_sz/scale_wpt_small,-solid_simple_wpt.x_sz/scale_wpt_small},
									  {-solid_simple_wpt.x_sz/scale_wpt_small,-solid_simple_wpt.x_sz/scale_wpt_small}}
el_smpl_wpt_solid.indices        = box_ind
el_smpl_wpt_solid.material       = "INDICATION_ABRIS_GREEN"
el_smpl_wpt_solid.tex_params	 = {solid_simple_wpt.x_st,solid_simple_wpt.y_st,scale_wpt_small,scale_wpt_small}
SetDefaultClipWithLevel(el_smpl_wpt_solid,3)
set_use_waypoint_remove_orientation(el_smpl_wpt_solid)
Add(el_smpl_wpt_solid)
add_waypoint_info(el_smpl_wpt_solid,"GREEN",0)
use_mipfilter(el_smpl_wpt_solid)

--------------------------------------------------------------------------------
el_smpl_wpt_solid_blue                = CreateElement "ceTexPoly"
el_smpl_wpt_solid_blue.name           = "el_smpl_wpt_solid_blue"
el_smpl_wpt_solid_blue.vertices       = {{-solid_simple_wpt.x_sz/scale_wpt_small, solid_simple_wpt.x_sz/scale_wpt_small},
										 { solid_simple_wpt.x_sz/scale_wpt_small, solid_simple_wpt.x_sz/scale_wpt_small},
										 { solid_simple_wpt.x_sz/scale_wpt_small,-solid_simple_wpt.x_sz/scale_wpt_small},
										 {-solid_simple_wpt.x_sz/scale_wpt_small,-solid_simple_wpt.x_sz/scale_wpt_small}}
el_smpl_wpt_solid_blue.indices        = box_ind
el_smpl_wpt_solid_blue.material       = "INDICATION_ABRIS_BLUE"
el_smpl_wpt_solid_blue.tex_params	  = {solid_simple_wpt.x_st,solid_simple_wpt.y_st,scale_wpt_small,scale_wpt_small}
SetDefaultClipWithLevel(el_smpl_wpt_solid_blue,3)
set_use_waypoint_remove_orientation(el_smpl_wpt_solid_blue)
Add(el_smpl_wpt_solid_blue)
add_waypoint_info(el_smpl_wpt_solid_blue,"BLUE",0)
use_mipfilter(el_smpl_wpt_solid_blue)

-------------------------------------------------------------------------------
el_beacon_wpt_solid                = CreateElement "ceTexPoly"
el_beacon_wpt_solid.name           = "el_beacon_wpt_solid"
el_beacon_wpt_solid.vertices       = { {-solid_beacon_wpt.x_sz/scale_wpt_big,solid_beacon_wpt.y_sz_pl/scale_wpt_big},
									   { solid_beacon_wpt.x_sz/scale_wpt_big,solid_beacon_wpt.y_sz_pl/scale_wpt_big},
									   { solid_beacon_wpt.x_sz/scale_wpt_big,-solid_beacon_wpt.y_sz_mi/scale_wpt_big},
									   {-solid_beacon_wpt.x_sz/scale_wpt_big,-solid_beacon_wpt.y_sz_mi/scale_wpt_big}}
el_beacon_wpt_solid.indices        = box_ind
el_beacon_wpt_solid.material       = "INDICATION_ABRIS_RED"
el_beacon_wpt_solid.tex_params	   = {solid_beacon_wpt.x_st,solid_beacon_wpt.y_stscale_wpt_big,scale_wpt_big}
SetDefaultClipWithLevel(el_beacon_wpt_solid,3)
set_use_route_segment(el_beacon_wpt_solid)
set_use_waypoint(el_beacon_wpt_solid)
Add(el_beacon_wpt_solid)
add_waypoint_info(el_beacon_wpt_solid,"BLACK",1)
use_mipfilter(el_beacon_wpt_solid)

-------------------------------------------------------------------------------
el_marker_wpt_solid                = CreateElement "ceTexPoly"
el_marker_wpt_solid.name           = "el_marker_wpt_solid"
el_marker_wpt_solid.vertices       = { {-solid_marker_wpt.x_sz/scale_wpt,solid_marker_wpt.y_sz/scale_wpt},
								       { solid_marker_wpt.x_sz/scale_wpt,solid_marker_wpt.y_sz/scale_wpt},
								      { solid_marker_wpt.x_sz/scale_wpt,-solid_marker_wpt.y_sz/scale_wpt},
								      {-solid_marker_wpt.x_sz/scale_wpt,-solid_marker_wpt.y_sz/scale_wpt}}
el_marker_wpt_solid.indices        = box_ind
el_marker_wpt_solid.material       = "INDICATION_ABRIS_RED"
el_marker_wpt_solid.tex_params		= {solid_marker_wpt.x_st,solid_marker_wpt.y_st,scale_wpt,scale_wpt}
SetDefaultClipWithLevel(el_marker_wpt_solid,3)
set_use_waypoint(el_marker_wpt_solid)
Add(el_marker_wpt_solid)
add_waypoint_info(el_marker_wpt_solid,"BLACK",0)
use_mipfilter(el_marker_wpt_solid)

-------------------------------------------------------------------------------
--    DATALINK
-------------------------------------------------------------------------------
el_marker_DLPT_ARMOR      			= CreateElement "ceTexPoly" 
el_marker_DLPT_ARMOR.name           = "el_marker_DLPT_ARMOR"
el_marker_DLPT_ARMOR.material       = "INDICATION_ABRIS_BLUE"
el_marker_DLPT_ARMOR.vertices  =	{{-marker_wpt.x_sz/scale_wpt_datalink,	marker_wpt.y_sz/scale_wpt_datalink},
									 {marker_wpt.x_sz/scale_wpt_datalink,	marker_wpt.y_sz/scale_wpt_datalink},
									 {marker_wpt.x_sz/scale_wpt_datalink,	-marker_wpt.y_sz/scale_wpt_datalink},
									 {-marker_wpt.x_sz/scale_wpt_datalink,	-marker_wpt.y_sz/scale_wpt_datalink}}
el_marker_DLPT_ARMOR.indices        = box_ind
el_marker_DLPT_ARMOR.tex_params		= {marker_wpt.x_st,marker_wpt.y_st,scale_wpt_datalink, scale_wpt_datalink}
set_use_datalink(el_marker_DLPT_ARMOR)
SetDefaultClipWithLevel(el_marker_DLPT_ARMOR,3)
Add(el_marker_DLPT_ARMOR)
add_waypoint_info_datalink(el_marker_DLPT_ARMOR,"BLUE")
use_mipfilter(el_marker_DLPT_ARMOR)
-------------------------------------------------------------------------------
local armor_target_center_x = 279/512
local armor_target_center_y = 237/512
local armor_target_size_x = (304 - 279)/512
local armor_target_size_y = (276  - 237)/512
el_marker_DLPT_ARMOR_TARGET = Copy(el_marker_DLPT_ARMOR)
el_marker_DLPT_ARMOR_TARGET.name	  = "el_marker_DLPT_ARMOR_TARGET"
el_marker_DLPT_ARMOR_TARGET.vertices  =	{{-armor_target_size_x/scale_wpt_datalink,	armor_target_size_y/scale_wpt_datalink},
										 {armor_target_size_x/scale_wpt_datalink,	armor_target_size_y/scale_wpt_datalink},
										 {armor_target_size_x/scale_wpt_datalink,	-armor_target_size_y/scale_wpt_datalink},
										 {-armor_target_size_x/scale_wpt_datalink,	-armor_target_size_y/scale_wpt_datalink}}
el_marker_DLPT_ARMOR_TARGET.tex_params = {armor_target_center_x, armor_target_center_y, scale_wpt_datalink, scale_wpt_datalink}
add_waypoint_info_datalink(el_marker_DLPT_ARMOR_TARGET,"BLUE")
Add(el_marker_DLPT_ARMOR_TARGET)
-------------------------------------------------------------------------------
local air_defence_center_x = 438.5/512
local air_defence_center_y = 33.5/512
local air_defence_size_x = (438.5 - 426)/512
local air_defence_size_y = (33.5  - 6)/512

el_marker_DLPT_AIRDEFENCE                = CreateElement "ceTexPoly"
el_marker_DLPT_AIRDEFENCE.name           = "el_marker_DLPT_AIRDEFENCE"
el_marker_DLPT_AIRDEFENCE.material       = "INDICATION_ABRIS_BLUE"
el_marker_DLPT_AIRDEFENCE.vertices       = { {-air_defence_size_x/scale_wpt_datalink, air_defence_size_y/scale_wpt_datalink},
								             { air_defence_size_x/scale_wpt_datalink, air_defence_size_y/scale_wpt_datalink},
								             { air_defence_size_x/scale_wpt_datalink,-air_defence_size_y/scale_wpt_datalink},
								             {-air_defence_size_x/scale_wpt_datalink,-air_defence_size_y/scale_wpt_datalink}}
el_marker_DLPT_AIRDEFENCE.indices        = box_ind
el_marker_DLPT_AIRDEFENCE.tex_params	 = {air_defence_center_x,air_defence_center_y,scale_wpt_datalink,scale_wpt_datalink}
set_use_datalink(el_marker_DLPT_AIRDEFENCE)
SetDefaultClipWithLevel(el_marker_DLPT_AIRDEFENCE,3)
Add(el_marker_DLPT_AIRDEFENCE)
add_waypoint_info_datalink(el_marker_DLPT_AIRDEFENCE,"BLUE")
use_mipfilter(el_marker_DLPT_AIRDEFENCE)
-------------------------------------------------------------------------------
local airdefence_target_center_x = 337/512
local airdefence_target_center_y = 236/512
local airdefence_target_size_x = (363 - 337)/512
local airdefence_target_size_y = (277  - 236)/512
el_marker_DLPT_AIRDEFENCE_TARGET = Copy(el_marker_DLPT_AIRDEFENCE)
el_marker_DLPT_AIRDEFENCE_TARGET.name	   = "el_marker_DLPT_AIRDEFENCE_TARGET"
el_marker_DLPT_AIRDEFENCE_TARGET.vertices  =	{{-airdefence_target_size_x/scale_wpt_datalink,	airdefence_target_size_y/scale_wpt_datalink},
												 {airdefence_target_size_x/scale_wpt_datalink,	airdefence_target_size_y/scale_wpt_datalink},
												 {airdefence_target_size_x/scale_wpt_datalink,	-airdefence_target_size_y/scale_wpt_datalink},
												 {-airdefence_target_size_x/scale_wpt_datalink,	-airdefence_target_size_y/scale_wpt_datalink}}
el_marker_DLPT_AIRDEFENCE_TARGET.tex_params = {airdefence_target_center_x, airdefence_target_center_y, scale_wpt_datalink, scale_wpt_datalink}
add_waypoint_info_datalink(el_marker_DLPT_AIRDEFENCE_TARGET,"BLUE")
Add(el_marker_DLPT_AIRDEFENCE_TARGET)
-------------------------------------------------------------------------------
el_marker_DLPT_OTHER                = CreateElement "ceTexPoly"
el_marker_DLPT_OTHER.name           = "el_marker_DLPT_OTHER"
el_marker_DLPT_OTHER.material       = "INDICATION_ABRIS_BLUE"
el_marker_DLPT_OTHER.indices        = box_ind
el_marker_DLPT_OTHER.vertices       = { {-cursor_size_box/scale_wpt_datalink, cursor_size_box/scale_wpt_datalink},
							            { cursor_size_box/scale_wpt_datalink, cursor_size_box/scale_wpt_datalink},
							            { cursor_size_box/scale_wpt_datalink,-cursor_size_box/scale_wpt_datalink},
							            {-cursor_size_box/scale_wpt_datalink,-cursor_size_box/scale_wpt_datalink}}
el_marker_DLPT_OTHER.tex_params		= {cursor_center_x_box,cursor_center_y_box, scale_wpt_datalink,scale_wpt_datalink}
set_use_datalink(el_marker_DLPT_OTHER)
SetDefaultClipWithLevel(el_marker_DLPT_OTHER,3)
Add(el_marker_DLPT_OTHER)
add_waypoint_info_datalink(el_marker_DLPT_OTHER,"BLUE")
use_mipfilter(el_marker_DLPT_OTHER)
-------------------------------------------------------------------------------
local other_target_center_x = 401/512
local other_target_center_y = 237/512
local other_target_size_x = (430 - 401)/512
local other_target_size_y = (267  - 237)/512
el_marker_DLPT_OTHER_TARGET = Copy(el_marker_DLPT_OTHER)
el_marker_DLPT_OTHER_TARGET.name      = "el_marker_DLPT_OTHER_TARGET"
el_marker_DLPT_OTHER_TARGET.vertices  =	{{-other_target_size_x/scale_wpt_datalink,	other_target_size_y/scale_wpt_datalink},
										 {other_target_size_x/scale_wpt_datalink,	other_target_size_y/scale_wpt_datalink},
										 {other_target_size_x/scale_wpt_datalink,	-other_target_size_y/scale_wpt_datalink},
										 {-other_target_size_x/scale_wpt_datalink,	-other_target_size_y/scale_wpt_datalink}}
el_marker_DLPT_OTHER_TARGET.tex_params = {other_target_center_x, other_target_center_y, scale_wpt_datalink, scale_wpt_datalink}
add_waypoint_info_datalink(el_marker_DLPT_OTHER_TARGET,"BLUE")
Add(el_marker_DLPT_OTHER_TARGET)
-------------------------------------------------------------------------------
local refpoint_center_x = 474.5/512
local refpoint_center_y = 33.5/512
local refpoint_size_x = (474.5 - 454)/512
local refpoint_size_y = (33.5  - 14)/512

el_marker_DLPT_REFPOINT				   = CreateElement "ceTexPoly"
el_marker_DLPT_REFPOINT.name           = "el_marker_DLPT_REFPOINT"
el_marker_DLPT_REFPOINT.material       = "INDICATION_ABRIS_BLUE"
el_marker_DLPT_REFPOINT.indices        = box_ind
el_marker_DLPT_REFPOINT.vertices       = { {-refpoint_size_x/scale_wpt_datalink, refpoint_size_y/scale_wpt_datalink},
								           { refpoint_size_x/scale_wpt_datalink, refpoint_size_y/scale_wpt_datalink},
								           { refpoint_size_x/scale_wpt_datalink,-refpoint_size_y/scale_wpt_datalink},
								           {-refpoint_size_x/scale_wpt_datalink,-refpoint_size_y/scale_wpt_datalink}}
el_marker_DLPT_REFPOINT.tex_params	   = {refpoint_center_x,refpoint_center_y, scale_wpt_datalink,scale_wpt_datalink}
set_use_datalink(el_marker_DLPT_REFPOINT)
SetDefaultClipWithLevel(el_marker_DLPT_REFPOINT,3)
Add(el_marker_DLPT_REFPOINT)
add_waypoint_info_datalink(el_marker_DLPT_REFPOINT,"BLUE")
use_mipfilter(el_marker_DLPT_REFPOINT)
-------------------------------------------------------------------------------
local refpoint_target_center_x = 470/512
local refpoint_target_center_y = 237/512
local refpoint_target_size_x = (503 - 470)/512
local refpoint_target_size_y = (272  - 237)/512
el_marker_DLPT_REFPOINT_TARGET 			 = Copy(el_marker_DLPT_REFPOINT)
el_marker_DLPT_REFPOINT_TARGET.name      =  "el_marker_DLPT_REFPOINT_TARGET"
el_marker_DLPT_REFPOINT_TARGET.vertices  =	{{-refpoint_target_size_x/scale_wpt_datalink,	refpoint_target_size_y/scale_wpt_datalink},
											 {refpoint_target_size_x/scale_wpt_datalink,	refpoint_target_size_y/scale_wpt_datalink},
											 {refpoint_target_size_x/scale_wpt_datalink,	-refpoint_target_size_y/scale_wpt_datalink},
											 {-refpoint_target_size_x/scale_wpt_datalink,	-refpoint_target_size_y/scale_wpt_datalink}}
el_marker_DLPT_REFPOINT_TARGET.tex_params = {refpoint_target_center_x, refpoint_target_center_y, scale_wpt_datalink, scale_wpt_datalink}
add_waypoint_info_datalink(el_marker_DLPT_REFPOINT_TARGET,"BLUE")
Add(el_marker_DLPT_REFPOINT_TARGET)
-------------------------------------------------------------------------------
el_marker_DLPT_GROUP_MEMBER_plashka 			= CreateElement "ceSimple"
el_marker_DLPT_GROUP_MEMBER_plashka.name  		= "el_marker_DLPT_GROUP_MEMBER_plashka"
set_use_datalink(el_marker_DLPT_GROUP_MEMBER_plashka)
add_waypoint_info_datalink_group_member(el_marker_DLPT_GROUP_MEMBER_plashka,"RED")
Add(el_marker_DLPT_GROUP_MEMBER_plashka)
-------------------------------------------------------------------------------
local GROUP_MEMBER_center_x =  274/512
local GROUP_MEMBER_center_y =  139/512
local GROUP_MEMBER_size_x   =  (290 - 274)/512
local GROUP_MEMBER_size_y   =  (139 - 125)/512

el_marker_DLPT_GROUP_MEMBER 			   = CreateElement "ceTexPoly"
el_marker_DLPT_GROUP_MEMBER.name           = "el_marker_DLPT_GROUP_MEMBER"
el_marker_DLPT_GROUP_MEMBER.material       = "INDICATION_ABRIS_RED"
el_marker_DLPT_GROUP_MEMBER.vertices       = {{-GROUP_MEMBER_size_x/scale_wpt_datalink, GROUP_MEMBER_size_y/scale_wpt_datalink},
											  { GROUP_MEMBER_size_x/scale_wpt_datalink, GROUP_MEMBER_size_y/scale_wpt_datalink},
											  { GROUP_MEMBER_size_x/scale_wpt_datalink, -GROUP_MEMBER_size_y/scale_wpt_datalink},
											  {-GROUP_MEMBER_size_x/scale_wpt_datalink, -GROUP_MEMBER_size_y/scale_wpt_datalink}} --el_smpl_wpt.vertices
el_marker_DLPT_GROUP_MEMBER.indices        = box_ind
el_marker_DLPT_GROUP_MEMBER.tex_params	   = {GROUP_MEMBER_center_x, GROUP_MEMBER_center_y, scale_wpt_datalink, scale_wpt_datalink}	--el_smpl_wpt.tex_params
el_marker_DLPT_GROUP_MEMBER.parent_element = "el_marker_DLPT_GROUP_MEMBER_plashka"
--el_marker_DLPT_GROUP_MEMBER.controllers    = {{"specific_waypoint_orientation", x_size, x_size}}
SetDefaultClipWithLevel(el_marker_DLPT_GROUP_MEMBER,3)
Add(el_marker_DLPT_GROUP_MEMBER)
use_mipfilter(el_marker_DLPT_GROUP_MEMBER)
-------------------------------------------------------------------------------
el_marker_DLPT_GROUP_MEMBER_with_course_plashka 			= CreateElement "ceSimple"
el_marker_DLPT_GROUP_MEMBER_with_course_plashka.name  		= "el_marker_DLPT_GROUP_MEMBER_with_course_plashka"
set_use_datalink(el_marker_DLPT_GROUP_MEMBER_with_course_plashka)
add_waypoint_info_datalink_group_member(el_marker_DLPT_GROUP_MEMBER_with_course_plashka,"RED")
Add(el_marker_DLPT_GROUP_MEMBER_with_course_plashka)

local GROUP_MEMBER_with_course_center_x =  274/512
local GROUP_MEMBER_with_course_center_y =  139/512
local GROUP_MEMBER_with_course_size_x   =  (290 - 274)/512
local GROUP_MEMBER_with_course_size_y   =  (139 - 105)/512

el_marker_DLPT_GROUP_MEMBER_with_course 			   = CreateElement "ceTexPoly"
el_marker_DLPT_GROUP_MEMBER_with_course.name          	 = "el_marker_DLPT_GROUP_MEMBER_with_course"
el_marker_DLPT_GROUP_MEMBER_with_course.material       = "INDICATION_ABRIS_RED"
el_marker_DLPT_GROUP_MEMBER_with_course.vertices       = {{-GROUP_MEMBER_with_course_size_x/scale_wpt_datalink, GROUP_MEMBER_with_course_size_y/scale_wpt_datalink},
														  { GROUP_MEMBER_with_course_size_x/scale_wpt_datalink, GROUP_MEMBER_with_course_size_y/scale_wpt_datalink},
														  { GROUP_MEMBER_with_course_size_x/scale_wpt_datalink, -GROUP_MEMBER_with_course_size_y/scale_wpt_datalink},
														  {-GROUP_MEMBER_with_course_size_x/scale_wpt_datalink, -GROUP_MEMBER_with_course_size_y/scale_wpt_datalink}} --el_smpl_wpt.vertices
el_marker_DLPT_GROUP_MEMBER_with_course.indices        = box_ind
el_marker_DLPT_GROUP_MEMBER_with_course.tex_params = {GROUP_MEMBER_with_course_center_x, GROUP_MEMBER_with_course_center_y, scale_wpt_datalink, scale_wpt_datalink}	--el_smpl_wpt.tex_params
el_marker_DLPT_GROUP_MEMBER_with_course.parent_element = "el_marker_DLPT_GROUP_MEMBER_with_course_plashka"
el_marker_DLPT_GROUP_MEMBER_with_course.controllers   = {{"specific_waypoint_orientation", x_size, x_size}}
SetDefaultClipWithLevel(el_marker_DLPT_GROUP_MEMBER_with_course,3)
Add(el_marker_DLPT_GROUP_MEMBER_with_course)
use_mipfilter(el_marker_DLPT_GROUP_MEMBER_with_course)
-------------------------------------------------------------------------------
el_marker_DLPT_GROUP_LEADER_plashka 			= CreateElement "ceSimple"
el_marker_DLPT_GROUP_LEADER_plashka.name  		= "el_marker_DLPT_GROUP_LEADER_plashka"
set_use_datalink(el_marker_DLPT_GROUP_LEADER_plashka)
add_waypoint_info_datalink_group_member(el_marker_DLPT_GROUP_LEADER_plashka,"RED")
Add(el_marker_DLPT_GROUP_LEADER_plashka)

local GROUP_LEADER_center_x =  193/512
local GROUP_LEADER_center_y =  139/512
local GROUP_LEADER_size_x   =  (208 - 193)/512
local GROUP_LEADER_size_y   =  (139 - 125)/512

local scale_wpt_datalink_group_leader = scale_wpt_datalink / 1.5

el_marker_DLPT_GROUP_LEADER 			   = CreateElement "ceTexPoly"
el_marker_DLPT_GROUP_LEADER.name           = "el_marker_DLPT_GROUP_LEADER"
el_marker_DLPT_GROUP_LEADER.material       = "INDICATION_ABRIS_RED"
el_marker_DLPT_GROUP_LEADER.vertices       = {{-GROUP_LEADER_size_x/scale_wpt_datalink_group_leader, GROUP_LEADER_size_y/scale_wpt_datalink_group_leader},
											  { GROUP_LEADER_size_x/scale_wpt_datalink_group_leader, GROUP_LEADER_size_y/scale_wpt_datalink_group_leader},
											  { GROUP_LEADER_size_x/scale_wpt_datalink_group_leader, -GROUP_LEADER_size_y/scale_wpt_datalink_group_leader},
											  {-GROUP_LEADER_size_x/scale_wpt_datalink_group_leader, -GROUP_LEADER_size_y/scale_wpt_datalink_group_leader}}
el_marker_DLPT_GROUP_LEADER.indices        = box_ind
el_marker_DLPT_GROUP_LEADER.tex_params	   = {GROUP_LEADER_center_x, GROUP_LEADER_center_y, scale_wpt_datalink_group_leader, scale_wpt_datalink_group_leader}
el_marker_DLPT_GROUP_LEADER.parent_element = "el_marker_DLPT_GROUP_LEADER_plashka"
--el_marker_DLPT_GROUP_LEADER.controllers    = {{"specific_waypoint_orientation", x_size, x_size}}
SetDefaultClipWithLevel(el_marker_DLPT_GROUP_LEADER,3)
Add(el_marker_DLPT_GROUP_LEADER)
use_mipfilter(el_marker_DLPT_GROUP_LEADER)
-------------------------------------------------------------------------------
el_marker_DLPT_GROUP_LEADER_with_course_plashka 			= CreateElement "ceSimple"
el_marker_DLPT_GROUP_LEADER_with_course_plashka.name  		= "el_marker_DLPT_GROUP_LEADER_with_course_plashka"
set_use_datalink(el_marker_DLPT_GROUP_LEADER_with_course_plashka)
add_waypoint_info_datalink_group_member(el_marker_DLPT_GROUP_LEADER_with_course_plashka,"RED")
Add(el_marker_DLPT_GROUP_LEADER_with_course_plashka)

local GROUP_LEADER_with_course_center_x =  193/512
local GROUP_LEADER_with_course_center_y =  139/512
local GROUP_LEADER_with_course_size_x   =  (208 - 193)/512
local GROUP_LEADER_with_course_size_y   =  (139 - 105)/512

local scale_wpt_datalink_group_leader = scale_wpt_datalink / 1.5

el_marker_DLPT_GROUP_LEADER_with_course 			   = CreateElement "ceTexPoly"
el_marker_DLPT_GROUP_LEADER_with_course.name           = "el_marker_DLPT_GROUP_LEADER_with_course"
el_marker_DLPT_GROUP_LEADER_with_course.material       = "INDICATION_ABRIS_RED"
el_marker_DLPT_GROUP_LEADER_with_course.vertices       = {{-GROUP_LEADER_with_course_size_x/scale_wpt_datalink_group_leader, GROUP_LEADER_with_course_size_y/scale_wpt_datalink_group_leader},
														  { GROUP_LEADER_with_course_size_x/scale_wpt_datalink_group_leader, GROUP_LEADER_with_course_size_y/scale_wpt_datalink_group_leader},
														  { GROUP_LEADER_with_course_size_x/scale_wpt_datalink_group_leader, -GROUP_LEADER_with_course_size_y/scale_wpt_datalink_group_leader},
														  {-GROUP_LEADER_with_course_size_x/scale_wpt_datalink_group_leader, -GROUP_LEADER_with_course_size_y/scale_wpt_datalink_group_leader}}
el_marker_DLPT_GROUP_LEADER_with_course.indices        = box_ind
el_marker_DLPT_GROUP_LEADER_with_course.tex_params	   = {GROUP_LEADER_with_course_center_x, GROUP_LEADER_with_course_center_y, scale_wpt_datalink_group_leader, scale_wpt_datalink_group_leader}
el_marker_DLPT_GROUP_LEADER_with_course.parent_element = "el_marker_DLPT_GROUP_LEADER_with_course_plashka"
el_marker_DLPT_GROUP_LEADER_with_course.controllers    = {{"specific_waypoint_orientation", x_size, x_size}}
SetDefaultClipWithLevel(el_marker_DLPT_GROUP_LEADER_with_course,3)
Add(el_marker_DLPT_GROUP_LEADER_with_course)
use_mipfilter(el_marker_DLPT_GROUP_LEADER_with_course)
-------------------------------------------------------------------------------
el_marker_DLPT_PREPLANNED_THREAT 			    = CreateElement "ceTexPoly"
el_marker_DLPT_PREPLANNED_THREAT.name           = "el_marker_DLPT_PREPLANNED_THREAT"
el_marker_DLPT_PREPLANNED_THREAT.material       = "INDICATION_ABRIS_BLUE"
el_marker_DLPT_PREPLANNED_THREAT.vertices       = el_smpl_wpt.vertices
el_marker_DLPT_PREPLANNED_THREAT.indices        = box_ind
el_marker_DLPT_PREPLANNED_THREAT.tex_params	    = el_smpl_wpt.tex_params
set_use_datalink(el_marker_DLPT_PREPLANNED_THREAT)
SetDefaultClipWithLevel(el_marker_DLPT_PREPLANNED_THREAT,3)
Add(el_marker_DLPT_PREPLANNED_THREAT)
add_waypoint_info_preplanned_threat(el_marker_DLPT_PREPLANNED_THREAT,"BLUE")
use_mipfilter(el_marker_DLPT_PREPLANNED_THREAT)
-------------------------------------------------------------------------------
el_marker_DLPT_PREPLANNED_FRIEND 			    = CreateElement "ceTexPoly"
el_marker_DLPT_PREPLANNED_FRIEND.name           = "el_marker_DLPT_PREPLANNED_FRIEND"
el_marker_DLPT_PREPLANNED_FRIEND.material       = "INDICATION_ABRIS_RED"
el_marker_DLPT_PREPLANNED_FRIEND.vertices       = el_smpl_wpt.vertices
el_marker_DLPT_PREPLANNED_FRIEND.indices        = box_ind
el_marker_DLPT_PREPLANNED_FRIEND.tex_params	    = el_smpl_wpt.tex_params
set_use_datalink(el_marker_DLPT_PREPLANNED_FRIEND)
SetDefaultClipWithLevel(el_marker_DLPT_PREPLANNED_FRIEND,3)
Add(el_marker_DLPT_PREPLANNED_FRIEND)
add_waypoint_info_preplanned_threat(el_marker_DLPT_PREPLANNED_FRIEND,"RED")
use_mipfilter(el_marker_DLPT_PREPLANNED_FRIEND)
-------------------------------------------------------------------------------
--    DATALINK
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- AIRPORTS
-------------------------------------------------------------------------------
local tex_params_airport = {simple_wpt.x_st,simple_wpt.y_st,scale_wpt,scale_wpt}

el_airport_NEW_fon  = Copy(el_smpl_wpt_big_solid)
el_airport_NEW_fon.name     	= "el_airport_NEW_fon"
el_airport_NEW_fon.vertices    = {	  {-solid_simple_wpt.x_sz/scale_wpt_big, solid_simple_wpt.x_sz/scale_wpt_big},
									  { solid_simple_wpt.x_sz/scale_wpt_big, solid_simple_wpt.x_sz/scale_wpt_big},
									  { solid_simple_wpt.x_sz/scale_wpt_big,-solid_simple_wpt.x_sz/scale_wpt_big},
									  {-solid_simple_wpt.x_sz/scale_wpt_big,-solid_simple_wpt.x_sz/scale_wpt_big}}
el_airport_NEW_fon.tex_params	 = {solid_simple_wpt.x_st,solid_simple_wpt.y_st,scale_wpt_big,scale_wpt_big}									  
el_airport_NEW_fon.material = "INDICATION_ABRIS_BLACK"
Add(el_airport_NEW_fon)
-------------------------------------------------------------------------------------------------------------------------------------
el_airport_CIVILIAN_fon   		 = Copy(el_smpl_wpt_big_solid)
el_airport_CIVILIAN_fon.name     = "el_airport_CIVILIAN_fon"
el_airport_CIVILIAN_fon.material = "INDICATION_ABRIS_WHITE"
Add(el_airport_CIVILIAN_fon)

el_airport_CIVILIAN 			   = CreateElement "ceTexPoly"
el_airport_CIVILIAN.name           = "el_airport_CIVILIAN"
el_airport_CIVILIAN.material       = "INDICATION_ABRIS_VIOLET"
el_airport_CIVILIAN.vertices	   = {{-simple_wpt.x_sz/scale_wpt_big, simple_wpt.x_sz/scale_wpt_big},
									  { simple_wpt.x_sz/scale_wpt_big, simple_wpt.x_sz/scale_wpt_big},
									  { simple_wpt.x_sz/scale_wpt_big,-simple_wpt.x_sz/scale_wpt_big},
									  {-simple_wpt.x_sz/scale_wpt_big,-simple_wpt.x_sz/scale_wpt_big}}
el_airport_CIVILIAN.indices        = box_ind
el_airport_CIVILIAN.tex_params	   = {374.5/512,simple_wpt.y_st,scale_wpt_big,scale_wpt_big}
el_airport_CIVILIAN.parent_element = "el_airport_CIVILIAN_fon"
SetDefaultClipWithLevel(el_airport_CIVILIAN,3)
Add(el_airport_CIVILIAN)
add_waypoint_info(el_airport_CIVILIAN,"VIOLET",1)
use_mipfilter(el_airport_CIVILIAN)
-------------------------------------------------------------------------------------------------------------------------------------
el_airport_MILITARY  			= Copy(el_smpl_wpt_solid)
el_airport_MILITARY.name     	= "el_airport_MILITARY"
el_airport_MILITARY.vertices    = {	 {-simple_wpt.x_sz/scale_wpt_big, simple_wpt.x_sz/scale_wpt_big},
									 { simple_wpt.x_sz/scale_wpt_big, simple_wpt.x_sz/scale_wpt_big},
									 { simple_wpt.x_sz/scale_wpt_big,-simple_wpt.x_sz/scale_wpt_big},
									 {-simple_wpt.x_sz/scale_wpt_big,-simple_wpt.x_sz/scale_wpt_big}}
el_airport_MILITARY.indices     = box_ind
el_airport_MILITARY.material 	= "INDICATION_ABRIS_VIOLET"
el_airport_MILITARY.tex_params	= {simple_wpt.x_st,simple_wpt.y_st,scale_wpt_big,scale_wpt_big}									  
Add(el_airport_MILITARY)

--[[
el_airport_MILITARY				   = CreateElement "ceTexPoly"
el_airport_MILITARY.name           = "el_airport_MILITARY"
el_airport_MILITARY.material       = "INDICATION_ABRIS_VIOLET"
el_airport_MILITARY.vertices       = el_smpl_wpt.vertices
el_airport_MILITARY.indices        = box_ind
el_airport_MILITARY.tex_params	   = {19.5/512,simple_wpt.y_st,scale_wpt_big,scale_wpt_big}
--el_airport_MILITARY.tex_params	   = el_smpl_wpt.tex_params
el_airport_MILITARY.parent_element = "el_airport_MILITARY_fon"
SetDefaultClipWithLevel(el_airport_MILITARY,3)
Add(el_airport_MILITARY)
add_waypoint_info(el_airport_MILITARY,"VIOLET",1)
use_mipfilter(el_airport_MILITARY)
--]]
--[[
el_airport_MILITARY				   = CreateElement "ceTexPoly"
el_airport_MILITARY.name           = "el_airport_MILITARY"
el_airport_MILITARY.material       = "INDICATION_ABRIS_VIOLET"
el_airport_MILITARY.vertices       = {	{-solid_simple_wpt.x_sz/scale_wpt_big, solid_simple_wpt.x_sz/scale_wpt_big},
										{ solid_simple_wpt.x_sz/scale_wpt_big, solid_simple_wpt.x_sz/scale_wpt_big},
										{ solid_simple_wpt.x_sz/scale_wpt_big,-solid_simple_wpt.x_sz/scale_wpt_big},
										{-solid_simple_wpt.x_sz/scale_wpt_big,-solid_simple_wpt.x_sz/scale_wpt_big}}
el_airport_MILITARY.indices        = box_ind
el_airport_MILITARY.tex_params	   = {solid_simple_wpt.x_st, solid_simple_wpt.y_st, scale_wpt_big, scale_wpt_big}
SetDefaultClipWithLevel(el_airport_MILITARY,3)
Add(el_airport_MILITARY)
add_waypoint_info(el_airport_MILITARY,"VIOLET",1)
use_mipfilter(el_airport_MILITARY)
--]]
-------------------------------------------------------------------------------------------------------------------------------------
el_airport_heli_MILITARY_fon  = Copy(el_airport_CIVILIAN_fon)
el_airport_heli_MILITARY_fon.name     = "el_airport_heli_MILITARY_fon"
set_use_waypoint_remove_orientation(el_airport_heli_MILITARY_fon)
Add(el_airport_heli_MILITARY_fon)

el_airport_heli_MILITARY = CreateElement "ceTexPoly"
el_airport_heli_MILITARY.name           = "el_airport_heli_MILITARY"
el_airport_heli_MILITARY.material       = "INDICATION_ABRIS_VIOLET"
el_airport_heli_MILITARY.vertices       = el_smpl_wpt.vertices
el_airport_heli_MILITARY.indices        = box_ind
el_airport_heli_MILITARY.tex_params	   = {94/512,81.5/512,scale_wpt_big,scale_wpt_big}
el_airport_heli_MILITARY.parent_element = "el_airport_heli_MILITARY_fon"
SetDefaultClipWithLevel(el_airport_heli_MILITARY,3)
Add(el_airport_heli_MILITARY)
add_waypoint_info(el_airport_heli_MILITARY,"VIOLET",1)
use_mipfilter(el_airport_heli_MILITARY)
-------------------------------------------------------------------------------------------------------------------------------------
el_airport_RESTRICTED_fon  = Copy(el_airport_heli_MILITARY_fon)
el_airport_RESTRICTED_fon.name     = "el_airport_RESTRICTED_fon"
Add(el_airport_RESTRICTED_fon)

el_airport_RESTRICTED = CreateElement "ceTexPoly"
el_airport_RESTRICTED.name           = "el_airport_RESTRICTED"
el_airport_RESTRICTED.material       = "INDICATION_ABRIS_VIOLET"
el_airport_RESTRICTED.vertices       = el_smpl_wpt.vertices
el_airport_RESTRICTED.indices        = box_ind
el_airport_RESTRICTED.tex_params	 = {58/512,81.5/512,scale_wpt_big,scale_wpt_big}
SetDefaultClipWithLevel(el_airport_RESTRICTED,3)
el_airport_RESTRICTED.parent_element = "el_airport_RESTRICTED_fon"
Add(el_airport_RESTRICTED)
add_waypoint_info(el_airport_RESTRICTED,"VIOLET",1)
use_mipfilter(el_airport_RESTRICTED)
-------------------------------------------------------------------------------------------------------------------------------------
el_airport_hydro_MILITARY_fon  = Copy(el_airport_heli_MILITARY_fon)
el_airport_hydro_MILITARY_fon.name     = "el_airport_hydro_MILITARY_fon"
Add(el_airport_hydro_MILITARY_fon)

el_airport_hydro_MILITARY = CreateElement "ceTexPoly"
el_airport_hydro_MILITARY.name           = "el_airport_hydro_MILITARY"
el_airport_hydro_MILITARY.material       = "INDICATION_ABRIS_VIOLET"
el_airport_hydro_MILITARY.vertices       = el_smpl_wpt.vertices
el_airport_hydro_MILITARY.indices        = box_ind
el_airport_hydro_MILITARY.tex_params	   = {129.5/512,81.5/512,scale_wpt_big,scale_wpt_big}
SetDefaultClipWithLevel(el_airport_hydro_MILITARY,3)
el_airport_hydro_MILITARY.parent_element = "el_airport_hydro_MILITARY_fon"
Add(el_airport_hydro_MILITARY)
add_waypoint_info(el_airport_hydro_MILITARY,"VIOLET",1)
use_mipfilter(el_airport_hydro_MILITARY)
-------------------------------------------------------------------------------
-- AIRPORTS
-------------------------------------------------------------------------------

el_route_segment_OK				 	= CreateElement "ceSimpleLineObject"
el_route_segment_OK.primitivetype   = "triangles"
el_route_segment_OK.name            = "el_route_segment_OK"
el_route_segment_OK.material	    = "DARK_GREEN" --"GREEN"
el_route_segment_OK.width           = 0.004 
el_route_segment_OK.controllers     = {{"specific_set_fill_route",x_size,x_size,0}}
SetDefaultClipWithLevel(el_route_segment_OK,3)
Add(el_route_segment_OK)
use_mipfilter(el_route_segment_OK)
-------------------------------------------------------------------------------
el_moving_route_segment				    = CreateElement "ceSimpleLineObject"
el_moving_route_segment.primitivetype   = "triangles"
el_moving_route_segment.name            = "el_moving_route_segment"
el_moving_route_segment.material	    = "GREEN"
el_moving_route_segment.width           = 0.004 
el_moving_route_segment.controllers     = {{"specific_moving_route_segment",x_size,x_size,0}}
SetDefaultClipWithLevel(el_moving_route_segment,3)
Add(el_moving_route_segment)
use_mipfilter(el_moving_route_segment)
-------------------------------------------------------------------------------
el_route_segment_NEXT				  = CreateElement "ceSimpleLineObject"
el_route_segment_NEXT.primitivetype   = "triangles"
el_route_segment_NEXT.name            = "el_route_segment_NEXT"
el_route_segment_NEXT.material	      = "BLUE"
el_route_segment_NEXT.width           = 0.004 
el_route_segment_NEXT.controllers     = {{"specific_set_fill_route",x_size,x_size,1}}
SetDefaultClipWithLevel(el_route_segment_NEXT,3)
Add(el_route_segment_NEXT)
use_mipfilter(el_route_segment_NEXT)
-------------------------------------------------------------------------------
local airport_beacon_center_x = 387/512
local airport_beacon_center_y = 137.5/512
local airport_beacon_size_x   = (415 - 387)/512
local airport_beacon_size_y   = (137.5 - 124)/512
-------------------------------------------------------------------------------
el_marker_airport_beacon                = CreateElement "ceTexPoly"
el_marker_airport_beacon.name           = "el_marker_airport_beacon"
el_marker_airport_beacon.material       = "INDICATION_ABRIS_GREEN"
el_marker_airport_beacon.indices        = box_ind
el_marker_airport_beacon.vertices       = {{-airport_beacon_size_x/scale_wpt, airport_beacon_size_y/scale_wpt},
										   { airport_beacon_size_x/scale_wpt, airport_beacon_size_y/scale_wpt},
										   { airport_beacon_size_x/scale_wpt,-airport_beacon_size_y/scale_wpt},
										   {-airport_beacon_size_x/scale_wpt,-airport_beacon_size_y/scale_wpt}}
el_marker_airport_beacon.tex_params		=  {airport_beacon_center_x,airport_beacon_center_y,scale_wpt,scale_wpt}
SetDefaultClipWithLevel(el_marker_airport_beacon,3)
el_marker_airport_beacon.controllers    = {{"specific_waypoint",x_size,x_size}}
Add(el_marker_airport_beacon)
use_mipfilter(el_marker_airport_beacon)
-------------------------------------------------------------------------------

el_threat_friendly = CreateElement "ceMeshPoly"
el_threat_friendly.name  = "threat_friendly"
el_threat_friendly.material = "SAM_RED"
el_threat_friendly.primitivetype = "triangles"
el_threat_friendly.controllers    = {{"additional_info_SAM_threat",x_size,x_size}}

--SetDefaultClipWithLevel(el_threat_friendly,3)
el_threat_friendly.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
el_threat_friendly.level = DEFAULT_LEVEL + 3

Add(el_threat_friendly)
use_mipfilter(el_threat_friendly)

el_threat_hostile = CreateElement "ceMeshPoly"
el_threat_hostile.name  = "threat_hostile"
el_threat_hostile.material = "SAM_BLUE"
el_threat_hostile.primitivetype = "triangles"
el_threat_hostile.controllers    = {{"additional_info_SAM_threat",x_size,x_size}}

--SetDefaultClipWithLevel(el_threat_hostile,3)
el_threat_hostile.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
el_threat_hostile.level = DEFAULT_LEVEL + 3

Add(el_threat_hostile)
use_mipfilter(el_threat_hostile)


el_additional_info_line				 	= CreateElement "ceSimpleLineObject"
el_additional_info_line.primitivetype   = "triangles"
el_additional_info_line.name            = "el_additional_info_line"
el_additional_info_line.material	    = "RED"
el_additional_info_line.width           = 0.004 
el_additional_info_line.controllers     = {{"additional_info_linear_object",x_size,x_size,0}}
SetDefaultClipWithLevel(el_additional_info_line,3)
Add(el_additional_info_line)
use_mipfilter(el_additional_info_line)

el_additional_info_current_line				 	= CreateElement "ceSimpleLineObject"
el_additional_info_current_line.primitivetype   = "triangles"
el_additional_info_current_line.name            = "el_additional_info_current_line"
el_additional_info_current_line.material	    = "RED"
el_additional_info_current_line.width           = 0.010 
el_additional_info_current_line.controllers     = {{"additional_info_linear_object",x_size,x_size,0}}
SetDefaultClipWithLevel(el_additional_info_current_line,3)
Add(el_additional_info_current_line)
use_mipfilter(el_additional_info_current_line)

--[[
el_SPI				 = Copy(el_marker_wpt)
el_SPI.name			 = "el_SPI"
el_SPI.material		  = "INDICATION_ABRIS_BLACK"
el_SPI.controllers = {{"specific_waypoint",x_size,x_size},{"sensor_point_of_interest_availability"}}
Add(el_SPI)
--]]

el_SPI_line				    = CreateElement "ceSimpleLineObject"
el_SPI_line.primitivetype   = "triangles"
el_SPI_line.name            = "el_SPI_line"
el_SPI_line.material	    = "YELLOW"
el_SPI_line.width           = 0.004 
el_SPI_line.controllers     = {{"specific_SPI_line",x_size,x_size,0},{"sensor_point_of_interest_availability"}}
SetDefaultClipWithLevel(el_SPI_line,3)
Add(el_SPI_line)
add_spi_marks(el_SPI_line)
use_mipfilter(el_SPI_line)

local centers_line  = (385  + (388 - 385)/2)/512

--GPS MARK
--круг
gps_satellite_mark 			    = CreateElement "ceTexPoly"
gps_satellite_mark.name         = "gps_satellite_mark"
gps_satellite_mark.material	    = "INDICATION_ABRIS_GREEN"	
gps_satellite_mark.indices = box_ind
gps_satellite_mark.vertices     =  {{-gps_satellite_size_x/scale_satellite,  gps_satellite_size_y/scale_satellite},
										{gps_satellite_size_x/scale_satellite,  gps_satellite_size_y/scale_satellite},
										{gps_satellite_size_x/scale_satellite, -gps_satellite_size_y/scale_satellite},
										{-gps_satellite_size_x/scale_satellite, -gps_satellite_size_y/scale_satellite}}											
gps_satellite_mark.tex_params   =  {gps_satellite_center_x,gps_satellite_center_y,scale_satellite,scale_satellite}	
gps_satellite_mark.isdraw 		= false	
set_use_satellite(gps_satellite_mark)
Add(gps_satellite_mark)
use_mipfilter(gps_satellite_mark)
--рамка
gps_satellite_border 			     = CreateElement "ceSimpleLineObject"
gps_satellite_border.name            = "gps_satellite_border"
gps_satellite_border.material	     = "INDICATION_ABRIS_WHITE"
gps_satellite_border.width           = 0.004 
gps_satellite_border.tex_params      = {{0.1,centers_line},{0.9,centers_line},{scale_2,scale_2}}	
gps_satellite_border.vertices        = {{gps_satellite_size_x/scale_satellite, 0.0}, {-gps_satellite_size_x/scale_satellite, 0.0}}
set_verts_circle(gps_satellite_border,360,15,gps_satellite_size_x/scale_satellite,0)
gps_satellite_border.parent_element = "gps_satellite_mark"
Add(gps_satellite_border)
use_mipfilter(gps_satellite_border)	
--текст
gps_satellite_label 			     = CreateElement "ceStringPoly"
gps_satellite_label.name            = "gps_satellite_label"
gps_satellite_label.material	     = "font_Ka-50_ABRIS_BLACK"
gps_satellite_label.alignment    = "CenterCenter"
gps_satellite_label.stringdefs   = abris_font[7]
gps_satellite_label.formats     = {"%d"}
gps_satellite_label.value        = ""
gps_satellite_label.parent_element = "gps_satellite_mark"
gps_satellite_label.controllers = {{"specific_satellite_label",0}}
Add(gps_satellite_label)
use_mipfilter(gps_satellite_label)

--GNSS MARK
--квадрат
gnss_satellite_mark 			     = CreateElement "ceTexPoly"
gnss_satellite_mark.name            = "gnss_satellite_mark"
gnss_satellite_mark.material	     = "INDICATION_ABRIS_GREEN"	
gnss_satellite_mark.indices = box_ind	
gnss_satellite_mark.vertices     =  {{-gnss_satellite_size_x/scale_satellite,  gnss_satellite_size_y/scale_satellite},
										{ gnss_satellite_size_x/scale_satellite,  gnss_satellite_size_y/scale_satellite},
										{ gnss_satellite_size_x/scale_satellite, -gnss_satellite_size_y/scale_satellite},
										{-gnss_satellite_size_x/scale_satellite, -gnss_satellite_size_y/scale_satellite}}
gnss_satellite_mark.tex_params   =  {gnss_satellite_center_x,gnss_satellite_center_y,scale_satellite,scale_satellite}												
gnss_satellite_mark.isdraw 		  = false	
set_use_satellite(gnss_satellite_mark)
Add(gnss_satellite_mark)
use_mipfilter(gnss_satellite_mark)	
--белый контур
gnss_satellite_border = CreateElement "ceSimpleLineObject"
gnss_satellite_border.name = "gnss_satellite_border"
gnss_satellite_border.material	     = "INDICATION_ABRIS_WHITE"	
gnss_satellite_border.width           = 0.004 	
gnss_satellite_border.tex_params      = {{0.1,centers_line},{0.9,centers_line},{scale_2,scale_2}}					
gnss_satellite_border.vertices        = {{gps_satellite_size_x/scale_satellite, 0.0}, {-gps_satellite_size_x/scale_satellite, 0.0}}
set_verts_circle(gnss_satellite_border,360,5,math.sqrt(2) * gps_satellite_size_x/scale_satellite,45)
gnss_satellite_border.parent_element = "gnss_satellite_mark"	
Add(gnss_satellite_border)
use_mipfilter(gnss_satellite_border)
--текст	
gnss_satellite_label 			     = CreateElement "ceStringPoly"
gnss_satellite_label.name            = "gnss_satellite_label"
gnss_satellite_label.material	     = "font_Ka-50_ABRIS_BLACK"
gnss_satellite_label.alignment    = "CenterCenter"
gnss_satellite_label.stringdefs   = abris_font[7]
gnss_satellite_label.formats     = {"%d"}
gnss_satellite_label.value        = ""
gnss_satellite_label.parent_element = "gnss_satellite_mark"
gnss_satellite_label.controllers = {{"specific_satellite_label",0}}
Add(gnss_satellite_label)
use_mipfilter(gnss_satellite_label)

--SNR ROWS
--метка		
SNR_row_label 			  = CreateElement "ceStringPoly"
SNR_row_label.name        = "SNR_row_label"
SNR_row_label.material	  = "font_Ka-50_ABRIS_WHITE"
SNR_row_label.alignment   = "CenterCenter"
SNR_row_label.stringdefs  = abris_font[7]	
SNR_row_label.init_pos    = {SNR_X0 - horizon_center_X + SNR_row_hor_interval + SNR_row_hor_interval * 0.5, SNR_Y0  - horizon_center_Y - SNR_row_hor_interval * 0.3, 0.0}	
SNR_row_label.formats     = {"%d"}	
SNR_row_label.isdraw 	  = false
SNR_row_label.controllers = {{"specific_satellite_label",0},
							 {"specific_satellite_SNR_row_position",SNR_row_hor_interval * 0.07675}}
Add(SNR_row_label)
use_mipfilter(SNR_row_label)	
--столбец
SNR_row 			     = CreateElement "ceTexPoly"
SNR_row.name            = "SNR_row"
SNR_row.material	     = "GREEN"	
SNR_row.init_pos = {-SNR_row_hor_interval * 0.5, SNR_row_hor_interval * 0.3, 0.0}
SNR_row.indices = box_ind
SNR_row.vertices     =  {{0.0,  0.0},
						{SNR_row_width,  0.0},
						{SNR_row_width, SNR_row_height},
						{0.0, SNR_row_height}}
SNR_row.parent_element = "SNR_row_label"
SNR_row.controllers = { {"specific_satellite_SNR_row"},
						{"specific_satellite_color",0.0, 1.0, 0.0, 0.5, 0.5, 0.5, 1.0, 1.0, 1.0}}
Add(SNR_row)
use_mipfilter(SNR_row)

--CLIMB/DIVE point	
climb_dive_point_mark 			    = CreateElement "ceTexPoly"
climb_dive_point_mark.name          = "climb_dive_point_mark"
climb_dive_point_mark.material	    = "INDICATION_ABRIS_WHITE"	
climb_dive_point_mark.indices 		= box_ind
climb_dive_point_mark.vertices     =  {{-gps_satellite_size_x/scale_satellite,  gps_satellite_size_y/scale_satellite},
										{gps_satellite_size_x/scale_satellite,  gps_satellite_size_y/scale_satellite},
										{gps_satellite_size_x/scale_satellite, -gps_satellite_size_y/scale_satellite},
										{-gps_satellite_size_x/scale_satellite, -gps_satellite_size_y/scale_satellite}}											
climb_dive_point_mark.tex_params   =  {gps_satellite_center_x,gps_satellite_center_y,scale_satellite,scale_satellite}
set_use_waypoint_remove_orientation(climb_dive_point_mark)
SetDefaultClipWithLevel(climb_dive_point_mark, 3)
Add(climb_dive_point_mark)
use_mipfilter(climb_dive_point_mark)	
--кружок
climb_dive_point_border 			  = CreateElement "ceTexPoly"
climb_dive_point_border.name          = "climb_dive_point_border"
climb_dive_point_border.material	  = "INDICATION_ABRIS_BLUE"	
climb_dive_point_border.indices 	  =	 box_ind	
climb_dive_point_border.vertices      =  	{{-climb_dive_point_size_x/climb_dive_point_scale,  climb_dive_point_size_y/climb_dive_point_scale},
											{climb_dive_point_size_x/climb_dive_point_scale,  climb_dive_point_size_y/climb_dive_point_scale},
											{climb_dive_point_size_x/climb_dive_point_scale, -climb_dive_point_size_y/climb_dive_point_scale},
											{-climb_dive_point_size_x/climb_dive_point_scale, -climb_dive_point_size_y/climb_dive_point_scale}}											
climb_dive_point_border.tex_params     =  {climb_dive_point_center_x, climb_dive_point_center_y, climb_dive_point_scale, climb_dive_point_scale}
climb_dive_point_border.parent_element = "climb_dive_point_mark"
SetDefaultClipWithLevel(climb_dive_point_border, 3)
Add(climb_dive_point_border)
use_mipfilter(climb_dive_point_border)	
--буква С или Н
climb_dive_point_label				= CreateElement "ceStringPoly"
climb_dive_point_label.name			= "climb_dive_point_label"
climb_dive_point_label.material		= "font_Ka-50_ABRIS_BLUE"
climb_dive_point_label.alignment	= "CenterCenter"
climb_dive_point_label.stringdefs	= abris_font[5]	
climb_dive_point_label.formats		= {LOCALIZE("Н"),LOCALIZE_EX("С", 2)}	
climb_dive_point_label.init_pos 	= {0.007 * x_size, 0.01 * x_size,0}
climb_dive_point_label.parent_element = "climb_dive_point_mark"
climb_dive_point_label.controllers = {{"specific_climb_dive_point_label",0,1}}
Add(climb_dive_point_label)
use_mipfilter(climb_dive_point_label)

--зеленый  кружок поверх сдвигаемых маршрутных точек	
el_smpl_wpt_solid_green                = CreateElement "ceTexPoly"
el_smpl_wpt_solid_green.name           = "el_smpl_wpt_solid_green"
el_smpl_wpt_solid_green.vertices       = {{-solid_simple_wpt.x_sz/scale_wpt_small, solid_simple_wpt.x_sz/scale_wpt_small},
										 { solid_simple_wpt.x_sz/scale_wpt_small, solid_simple_wpt.x_sz/scale_wpt_small},
										 { solid_simple_wpt.x_sz/scale_wpt_small,-solid_simple_wpt.x_sz/scale_wpt_small},
										 {-solid_simple_wpt.x_sz/scale_wpt_small,-solid_simple_wpt.x_sz/scale_wpt_small}}
el_smpl_wpt_solid_green.indices        = box_ind
el_smpl_wpt_solid_green.material       = "INDICATION_ABRIS_GREEN"
el_smpl_wpt_solid_green.tex_params	  = {solid_simple_wpt.x_st,solid_simple_wpt.y_st,scale_wpt_small,scale_wpt_small}
SetDefaultClipWithLevel(el_smpl_wpt_solid_green,3)
set_use_waypoint(el_smpl_wpt_solid_green)
Add(el_smpl_wpt_solid_green)
use_mipfilter(el_smpl_wpt_solid_green)


el_town_fon  = Copy(el_airport_heli_MILITARY_fon)
el_town_fon.name     = "el_town_fon"
Add(el_town_fon)

el_town = CreateElement "ceTexPoly"
el_town.name           = "el_town"
el_town.material       = "INDICATION_ABRIS_BLACK"
el_town.vertices       = el_smpl_wpt.vertices
el_town.indices        = box_ind
el_town.tex_params	 = {58/512,81.5/512,scale_wpt_big,scale_wpt_big}
SetDefaultClipWithLevel(el_town,3)
el_town.parent_element = "el_town_fon"
Add(el_town)
add_waypoint_info(el_town,"BLACK",1)
use_mipfilter(el_town)