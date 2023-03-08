-- Commands
-- the section is not intended for end-user editing
dofile(LockOn_Options.script_path.."command_defs.lua")

KeyCommands = 	{{command = Keys.Plane_ABRIS_Power},
				 {command = Keys.Plane_ABRIS_BT_1,		},--	  arg = 512, arg_increment = 1, arg_lim = {0, 1}},
 				 {command = Keys.Plane_ABRIS_BT_1_up,	},--	  arg = 512, arg_increment = -1, arg_lim = {0, 1}},
				 {command = Keys.Plane_ABRIS_BT_2,		},--	  arg = 513, arg_increment = 1, arg_lim = {0, 1}},
				 {command = Keys.Plane_ABRIS_BT_2_up,	},--	  arg = 513, arg_increment = -1, arg_lim = {0, 1}},
				 {command = Keys.Plane_ABRIS_BT_3,		},--	  arg = 514, arg_increment = 1, arg_lim = {0, 1}},
				 {command = Keys.Plane_ABRIS_BT_3_up,	},--	  arg = 514, arg_increment = -1, arg_lim = {0, 1}},
				 {command = Keys.Plane_ABRIS_BT_4,		},--	  arg = 515, arg_increment = 1, arg_lim = {0, 1}},
				 {command = Keys.Plane_ABRIS_BT_4_up,	},--	  arg = 515, arg_increment = -1, arg_lim = {0, 1}},
				 {command = Keys.Plane_ABRIS_BT_5,		},--	  arg = 516, arg_increment = 1, arg_lim = {0, 1}},
				 {command = Keys.Plane_ABRIS_BT_5_up,	},--	  arg = 516, arg_increment = -1, arg_lim = {0, 1}},
				 {command = Keys.Plane_ABRIS_Axis_Increase},
				 {command = Keys.Plane_ABRIS_Axis_Decrease},
				 {command = Keys.Plane_ABRIS_Axis_Push},
				 {command = Keys.Plane_ABRIS_Axis_Push_up},
				 {command = Keys.Plane_ABRIS_Brightness_Increase},
				 {command = Keys.Plane_ABRIS_Brightness_Decrease},
				 {command = PlaneChangeWaypoint}}
