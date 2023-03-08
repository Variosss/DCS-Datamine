dofile("./CoreMods/tech/USS_Nimitz/scripts/utils.lua")
dofile("./CoreMods/tech/USS_Nimitz/scripts/crew.lua")

y_min = 15
y_max = 25
parameters = 
{
	deck_height = 20.1494140625,
	catapult_histeresis_delta = 0.1,
	catapult_side_shift = 0.30,
	shuttle_dist = 1,
	holdback_bar_dist = 1,
	takeoff_distance = 5,
	takeoff_delay = 0,
	takeoff_random_spread = 0.5,
	shuttle_tension_condition = 0.99,
	crew_update_interval = 0.05,
}
environment_options = 
{
    query_scene_update_interval = 1,
	query_obstacles_map_cell_size = {1, 1},
	movement = 
	{
		slow_speed = 0.426327,
		walk_speed = 1.762018,
		run_speed  = 3.811785,	
	},
	--[[DebugDraw = 
	{
		draw_tail               = true,
		draw_shell              = true,
		draw_goal               = true,
		show_labels             = false,
		show_nav_grid           = false,
		show_scene_objs         = false,
		show_env_box            = false,
		show_static_obstacles   = true,
		show_agent_neighbours   = false,
		show_agent_obstacles    = true,
		route_height         	= 1.0,
	},--]]
	ORCA = 
	{
		max_speed        	= 1.76,
		min_speed        	= 0.414,
		max_accel        	= 2.23,
		omega_max        	= 40.0/57.3,
		neighborDist     	= 8.0,
		character_radius 	= 0.5,
		timeHorizon      	= 2.0,
		timeHorizonObst  	= 2.0,
		maxNeighbors     	= 10,
		callback_enabled 	= true,
		limit_vel        	= true,
		limit_max_angle  	= true,	
	},
}

aircraft_data = 
{
    ['default'] = 
    {
        wing_unfold_condition = {arg = 8,     value = 0.2, condition = '<'},
        raise_launch_bar_needed = true,
    },
    ['F-14B']   = 
    {
        wing_unfold_condition = {arg = 404,   value = 0.1, condition = '<'},
        raise_launch_bar_needed = false,
    },
    ['F-14A']   = 
    {
        wing_unfold_condition = {arg = 7,     value = 0.1, condition = '<'},
        raise_launch_bar_needed = false,
    },
}

function deck()
	local verts = 
	{
		{-8376.045227 	, 2014.907871,  3721.241051},  		-- 1
		{3568.849564 	, 2014.902026,  -4059.407372}, 		-- 2
		-- {-8829.981232 	, 2014.906670,  -3650.999779},
		{-5912 			, 2014.906670,  -3650},				-- 3
		{16752.621460 	, 2014.907464,  1220.708614},		-- 4
		{16752.554321 	, 2014.907066,  -1220.764965},      -- 5
		{6914.647675 	, 2014.907871,  3721.241051},       -- 6
		{9306.103516 	, 2014.907577,  1917.674690},       -- 7
		{6309.670639 	, 2014.902026,  -4059.407372},      -- 8
		{1510.599136 	, 2014.906670,  -3650.999779},      -- 9
		{9202.045441 	, 2014.906952,  -1919.579262},      -- 10
		{-12427.044678 	, 2014.906933,  -2035.620445},      -- 11
		{-11183.885956 	, 2014.907787,  3205.310493},       -- 12
		{-14394.342041 	, 2014.907722,  2805.833679},       -- 13
		{-11981.600189 	, 2014.906658,  -3721.241326},      -- 14
		{-16070.468140 	, 2014.907006,  -1590.845055},      -- 15
		{-14872.047424 	, 2014.907611,  2127.566772},       -- 16
		{-11156.166077 	, 2014.907825,  3439.724403},       -- 17
		{-16391.674805 	, 2014.907012,  -1551.633400},      -- 18
		{-15765.231323 	, 2014.907635,  2273.831230},       -- 19
		{4140.927505 	, 2014.907871,  3721.241051},       -- 20
		-- {-7076.738739 	, 2014.906670,  -3650.999779},  
		{-5575 			, 2014.906670,  -3650},             -- 21
		{-6422.514343 	, 2014.907871,  3721.241051},       -- 22
		{-6422.514343 	, 2014.907667,  2469.155365},       -- 23
		{-3686.133194 	, 2014.907629,  2237.815529},       -- 24
		{-3686.133194 	, 2014.907871,  3721.241051},       -- 25
		{-7053.665924 	, 2014.907871,  3721.241051},       -- 26
		{-7053.665924 	, 2014.907799,  3279.235130},       -- 27
		{-7553.092194 	, 2014.907799,  3279.235130},       -- 28
		{-7553.092194 	, 2014.907871,  3721.241051},       -- 29
		{-5910          , 2014.907871, -3925}, -- balcony 30
		{-5575          , 2014.907871, -3925}, -- balcony 31
	}
	local polygon = {3, 14, 11, 15, 18, 19, 16, 13, 12, 17, 1, 29, 28, 27, 26, 22, 23, 24, 25, 20, 6, 7, 4, 5, 10, 8, 2, 9, 21, 31, 30}
	--local polygon = {30, 31, 32, 33}

	local deck_obstacle = {}
	for i = #polygon, 1, -1 do
		local ind = polygon[i]
		local v = verts[ind]
		deck_obstacle[i] = {v[1]/100, v[2]/100, v[3]/100}	
	end;
	return deck_obstacle;
end;

function balcony()
	local h = 20.14;
	local points = 
	{
		{-59.10, h, -36.45}, -- 3
		{-59.10, h, -39.25}, -- 2
		{-55.75, h, -39.25}, -- 1
		{-55.75, h, -36.45}, -- 0 
	}
	return points;
end

function cockpit()
	local h = 20.14;
	local points = 
	{
		{87, h, 4.6},
		{87, h, 7.8},
		{81, h, 7.8},
		{81, h, 4.6},
		{87, h, 4.6},
	}
	return points;
end;

function test_obstacle()
	local h = 20.14;
	local points = 
	{
		{75.82-5, h, 13.19},
		{75.82-5, h, 19.15},
		{57.35,   h, 20.92},
		{56.30,   h, 15.04},
		{75.82-5, h, 13.19},
	}
	return points;
end;

deck_obstacle_data = 
{
	deck(),
	--balcony(),
	cockpit(),
	--test_obstacle()
}

jbd_box = {{-12, -1, -5},{0, 5, 5}}

catapults = 
{
    [1] = 
    {
        start_box   = { {   21, y_min,  11}, { 62, y_max,  23.5} }, 
        --service_box = { {   21, y_min,  11}, { 92, y_max,  23.5} }, 
        service_box = { {   -40, -1,  -9}, { 30, 5,  6}}, 
        jbd_box = jbd_box,
        hbb_mount_point_animation_offset = {-0.34, 0, -1.16},
    },
    [2] = 
    {
        start_box   = { {   16, y_min,  -12}, { 60, y_max,   6}},
        --service_box = { {   16, y_min,  -12}, { 90, y_max,   6}},
        service_box = { {   -40, -1,  -6}, { 30, 5,  6}}, 
		jbd_box = jbd_box,
        hbb_mount_point_animation_offset = {-0.401, 0, 1.16},
    },
    [3] = 
    {
        start_box   = {{-78, y_min, -25}, {-57, y_max, -13}}, 		 
        --service_box = {{-78, y_min, -25}, {-27, y_max, -13}},
        service_box = { {   -45, -1,  -7}, { 30, 5,  6}}, 
		jbd_box = jbd_box,
        hbb_mount_point_animation_offset = {-0.401, 0, 1.16},
    },
    [4] = 
    {
        start_box = {{ -96, y_min, -36}, {-68.5, y_max, -27.5}}, 
        --service_box = {{ -96, y_min, -36}, {-38.5, y_max, -27.5}}, 
        service_box = { {   -45, -1,  -6}, { 30, 5,  6}},
        jbd_box = jbd_box,
        hbb_mount_point_animation_offset = {-0.401, 0, 1.16},
    },
}


crew = crews.crew
static_crew = crews.static_crew
takeoff_crew = crews.takeoff_crew

log_colors = 
{
    ['GreenSubtree']        = {0, 1, 0},
    ['Green2Subtree']       = {0, 1, 0},
    ['CatOfficerSubtree']   = {1, 1, 0},
    ['WhiteSubtree']        = {0.8, 0.7, 0.6},
    ['ShooterSubtree']      = {1, 1, 0},
}

names = 
{
    shooter = 'shooter',
    cat_officer = 'cat_officer',
    safe0 = 'white1',
    safe1 = 'white2',
    green = 'green',
	green2 = 'green2',
}

---[[
function color(r,g,b)
	return {r/255, g/255, b/255}
end

local holdback_bar_model = 'Holdback_Bar.EDM';
local light_stick_model = 'light_stick.lods';
local light_stick_transform = {{0, -1, 0, 0},{1, 0, 0, 0},{0,0,1, 0},{0,0,0,1}}
local light_transform = {{1, 0, 0, 0},{0, 1, 0, 0},{0, 0, 1, 0},{0.2, 0, 0, 1}}
local light_range = 0.8;--30
local light_red_color 		= color(255, 40 , 0)
local light_green_color 	= color(40 , 255, 0)
local light_blue_color 		= color(120, 220, 255)
local light_yellow_color 	= color(255, 220, 0)
local light_colors = 
{
	{-- left                    right
		{light_green_color, 	light_red_color}, 		-- shooter
		{light_yellow_color, 	light_yellow_color},	-- director
		{light_blue_color, 		light_blue_color},		-- white1
		{light_blue_color, 		light_blue_color},		-- white2
		{light_blue_color, 		light_blue_color},		-- green
		{light_blue_color, 		light_blue_color},		-- green	
	},
	{-- left                    right
		{light_red_color, 		light_green_color},		-- shooter
		{light_yellow_color, 	light_yellow_color},	-- director
		{light_blue_color, 		light_blue_color},		-- white1
		{light_blue_color, 		light_blue_color},		-- white2
		{light_blue_color, 		light_blue_color},		-- green
		{light_blue_color, 		light_blue_color},		-- green	
	},
	{-- left                    right
		{light_red_color, 		light_green_color},		-- shooter
		{light_yellow_color, 	light_yellow_color},	-- director
		{light_blue_color, 		light_blue_color},		-- white1
		{light_blue_color, 		light_blue_color},		-- white2
		{light_blue_color, 		light_blue_color},		-- green
		{light_blue_color, 		light_blue_color},		-- green	
	},
	{-- left                    right
		{light_red_color, 		light_green_color},		-- shooter
		{light_yellow_color, 	light_yellow_color},	-- director
		{light_blue_color, 		light_blue_color},		-- white1
		{light_blue_color, 		light_blue_color},		-- white2
		{light_blue_color, 		light_blue_color},		-- green
		{light_blue_color, 		light_blue_color},		-- green	
	},
}

local scale_table = 
{
	enabled = true,
	argument = 2,
	range = 
	{-- distance, arg_value
		{25, 0}, 
		{150, 1},
	},
}

-- 0 - 0.25 - orange
-- 0.25 - 0.5 - yellow
-- 0.5 - 0.75 - green 
-- 0.75 - 1 - blue

function add_model_attachment(crew_id, member_id, attachment_name, connector_name, transform, model_name, params)
	local item =	
	{
		type = 'model_attachment',
		name = attachment_name,
		connector = connector_name, 
		transform = transform,
		model = model_name,
	}
	for k,v in pairs(params or {}) do
		item[k] = v
	end
	crew[crew_id].members[member_id].attachments = crew[crew_id].members[member_id].attachments or {}
	table.insert(crew[crew_id].members[member_id].attachments, item)
end

function add_light_attachment(crew_id, member_id, attachment_name, connector_name, transform, light_color)
	local item =	
	{
		type = 'light_attachment',
		name = attachment_name,
		connector = connector_name, 
		transform = transform,
		light_color = light_color,
		range = light_range,
	}
	crew[crew_id].members[member_id].attachments = crew[crew_id].members[member_id].attachments or {}
	table.insert(crew[crew_id].members[member_id].attachments, item)
end

-- Night Mode Sticks
---[[
for crew_id = 1,4 do
	for member_id = 1,6 do
		add_model_attachment(crew_id, member_id, 'RightStick', '__conn_hand_R', light_stick_transform, light_stick_model, {arg_scalable = scale_table}) 
		add_model_attachment(crew_id, member_id, 'LeftStick',  '__conn_hand_L', light_stick_transform, light_stick_model, {arg_scalable = scale_table})	
		add_light_attachment(crew_id, member_id, 'LeftLight',  '__conn_hand_L', light_transform, light_colors[crew_id][member_id][1])	
		add_light_attachment(crew_id, member_id, 'RightLight', '__conn_hand_R', light_transform, light_colors[crew_id][member_id][2]) 
	end
end
--]]


-- HBB attachments for gren_hbb
add_model_attachment(1, 5, 'HBB', '__conn_hand_R', {}, holdback_bar_model) 
add_model_attachment(2, 5, 'HBB', '__conn_hand_L', {}, holdback_bar_model) 
add_model_attachment(3, 5, 'HBB', '__conn_hand_L', {}, holdback_bar_model) 
add_model_attachment(4, 5, 'HBB', '__conn_hand_L', {}, holdback_bar_model) 


crew[1].members[5].override_animation = 'holdback_bar_arm_R'
crew[2].members[5].override_animation = 'holdback_bar_arm_L'
crew[3].members[5].override_animation = 'holdback_bar_arm_L'
crew[4].members[5].override_animation = 'holdback_bar_arm_L'
--]]

remap_table = 
{
    "member_name",
    "white_move_pos1_allowed",
    "green_move_pos0_allowed",
	"green_set_holdbackbar_allowed",
	"green2_move_pos0_allowed",
	"green2_set_holdbackbar_allowed",
	"green2_move_pos1_allowed",
	"white_move_pos2_allowed",
    "white_kneel_animation_name",
    "white_idle2kneel_animation_name",
    "white_kneel2idle_animation_name",
    "white_kneel_ok_animation_name",
	"sign_ok_animation_name",
    "white_kneel_allowed",
	"shooter_move_pos1_allowed",
    "sign_ok_allowed",
    "start_shooter_sequence",
    "phase_done",
	"catapult_taken",
	"ran_in_safe_place",
	"crew_ready",
	"white1_run_from_catapult",
	"white2_run_from_catapult",
	"green_run_from_catapult",
	"green2_run_from_catapult",
	"shooter_run_from_catapult",
	"cat_officer_run_from_catapult",	
	"white1_run_to_catapult",
	"white2_run_to_catapult",
	"green_run_to_catapult",
	"green2_run_to_catapult",
	"shooter_run_to_catapult",
	"cat_officer_run_to_catapult",
	"takeoff_distance",
	"takeoff_delay",
	"takeoff_random_spread",
	"plane_run_away",
	"plane_parked",
    "runway_start",
    "reset_la_request",
    "la_assigned",
	"night_mode",

}

names_table = 
{
    ["Sign_CatapultLaunch"]     = { "Sign_CatapultLaunch_L",    "Sign_CatapultLaunch_R",    "Sign_CatapultLaunch_R",    "Sign_CatapultLaunch_R" },
    ["Sign_Launch1"]            = { "Sign_Launch_0001_01_P1",   "Sign_Launch_0010_01_P1",   "Sign_Launch_1100_01_P1",   "Sign_Launch_1100_01_P1" },
    ["Sign_Launch2"]            = { "Sign_Launch_0001_01_P2",   "Sign_Launch_0010_01_P2",   "Sign_Launch_1100_01_P2",   "Sign_Launch_1100_01_P2" },
    ["Sign_Point"]              = { "Sign_PointL",              "Sign_PointR",              "Sign_PointR",              "Sign_PointR" },
    ["holdback_bar_arm"]        = { "holdback_bar_arm_R",       "holdback_bar_arm_L",       "holdback_bar_arm_L",       "holdback_bar_arm_L" },
    ["Holdbar_SetUp"]           = { "Holdbar_SetUp_R",          "Holdbar_SetUp_L",          "Holdbar_SetUp_L",          "Holdbar_SetUp_L" },
    ["Holdbar_PickUp"]          = { "Holdbar_PickUp_R",         "Holdbar_PickUp_L",         "Holdbar_PickUp_L",         "Holdbar_PickUp_L" },
    ["__conn_hand"]             = { "__conn_hand_R",            "__conn_hand_L",            "__conn_hand_L",            "__conn_hand_L" },
    ["NoseGearOperation"]       = { "NoseGearOperation_L",      "NoseGearOperation_R",      "NoseGearOperation_R",      "NoseGearOperation_R" },
    ["NoseGearOperation1"]      = { "NoseGearOperation1_L",     "NoseGearOperation1_R",     "NoseGearOperation1_R",     "NoseGearOperation1_R" },
    ["NoseGearOperation2"]      = { "NoseGearOperation2_L",     "NoseGearOperation2_R",     "NoseGearOperation2_R",     "NoseGearOperation2_R" },
    ["white1_kneel_animation"]  = { "CrouchM_Loop",             "CrouchM_Loop",             "CrouchM_Loop",             "CrouchM_Loop" },    
    ["white2_kneel_animation"]  = { "CrouchU_Loop",             "CrouchU_Loop",             "CrouchU_Loop",             "Idle" },    
    ["white1_ok_animation"]     = { "CrouchM_SignOk2",          "CrouchM_SignOk2",          "CrouchM_SignOk2",          "CrouchM_SignOk2" },    
    ["white2_ok_animation"]     = { "CrouchU_SignOk2",          "CrouchU_SignOk2",          "CrouchU_SignOk2",          "Sign_Ok_R" },   
    ["green_nw_ok_animation"]   = { "CrouchU_SignOk",           "CrouchM_SignOk",           "CrouchM_SignOk",           "CrouchM_SignOk" },    
	
    ["green_nw_stick_attachment"]			= { "LeftStick",          		"RightStick",          		"RightStick",          		"RightStick" },    
    ["green_nw_light_attachment"]			= { "LeftLight",          		"RightLight",          		"RightLight",          		"RightLight" }, 
    ["green_nw_night_override_animation"]	= { "Night_Stick_ArmPose_L", 	"Night_Stick_ArmPose_R", 	"Night_Stick_ArmPose_R", 	"Night_Stick_ArmPose_R" }, 
	
    ["shooter_left_stick_attachment"]		= { "LeftStick",    "RightStick",   "RightStick",   "RightStick" },    
    ["shooter_right_stick_attachment"]		= { "RightStick",   "LeftStick",    "LeftStick",    "LeftStick" },    
    ["shooter_left_light_attachment"]		= { "LeftLight",    "RightLight",   "RightLight",   "RightLight" },    
    ["shooter_right_light_attachment"]		= { "RightLight",   "LeftLight",    "LeftLight",    "LeftLight" },
	["green_hbb_stick"] 					= { "LeftStick",    "LeftStick",   	"LeftStick",   	"LeftStick" },
	["green_hbb_light_stick"]				= { "LeftLight", 	"LeftLight",	"LeftLight",	"LeftLight" },
	["green_hbb_night_override_animation"]	= { "Night_Stick_ArmPose_L", 	"Night_Stick_ArmPose_L", 	"Night_Stick_ArmPose_L", 	"Night_Stick_ArmPose_L" }, 
	
}

crew[1].behavior = './CoreMods/tech/USS_Nimitz/scripts/common.xml'
crew[2].behavior = './CoreMods/tech/USS_Nimitz/scripts/common.xml'
crew[3].behavior = './CoreMods/tech/USS_Nimitz/scripts/common.xml'
crew[4].behavior = './CoreMods/tech/USS_Nimitz/scripts/common.xml'
crew[4].master_catapult = 3
crew[1].neighbour_catapult = 2
crew[2].neighbour_catapult = 1


--[[
shooter
01.move_to_launch_pos
02.move_to_initial_pos
03.free_cat
04.occupy_cat

director
01.move_to_launch_pos
02.move_to_initial_pos
03.free_cat
04.occupy_cat

white
01.move_1_pos
02.move_to_launch_pos
03.move_to_initial_pos
04.free_cat
05.occupy_cat

green_hbb
01.setup_hbb
02.move_to_launch_pos
03.pickup_hbb
04.move_to_initial_pos
05.free_cat
06.occupy_cat

green_nw
01.move_to_nose_gear
02.move_to_launch_pos
03.move_to_initial_pos
04.free_cat
05.occupy_cat
--]]

--traverseTable(state_machines, nil, nil, 'out.lua')