-- Commands
-- the section is not intended for end-user editing
dofile(LockOn_Options.script_path.."command_defs.lua")

KeyCommands =	{{command = Keys.PlaneTrimOff},
				 {command = Keys.PlaneTrimOn},
                 
				 {command = Keys.PlaneTrimCancel},
				 {command = Keys.iCommandHelicopterHover    ,arg = 598, arg_increment = 1,direct_set = true, arg_lim = {0, 1}},
                 {command = Keys.iCommandHelicopterHover_up ,arg = 598, arg_increment = 0,direct_set = true, arg_lim = {0, 1}},
				 {command = Keys.iCommandAutopilotEmergOFF   ,arg = 604, arg_increment = 1,direct_set = true, arg_lim = {0, 1}},
                 {command = Keys.iCommandAutopilotEmergOFF_up,arg = 604, arg_increment = 0,direct_set = true, arg_lim = {0, 1}},
                 {command = Keys.iCommandHelicopter_PPR_button_K},
                 {command = Keys.iCommandHelicopter_PPR_button_H},
                 {command = Keys.iCommandHelicopter_PPR_button_T},
                 {command = Keys.iCommandHelicopter_PPR_button_B},
                 {command = Keys.iCommandHelicopter_PPR_button_DIR},       
                 {command = Keys.iCommandHelicopter_PPR_button_K_up},
                 {command = Keys.iCommandHelicopter_PPR_button_H_up},
                 {command = Keys.iCommandHelicopter_PPR_button_T_up},
                 {command = Keys.iCommandHelicopter_PPR_button_B_up},
                 {command = Keys.iCommandHelicopter_PPR_button_DIR_up},
                 
				 {command = Keys.PPR_BAR_RV},
                 {command = Keys.iCommandPlane_ShowControls},
                 }
