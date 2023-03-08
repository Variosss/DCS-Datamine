dofile(LockOn_Options.script_path.."config.lua")

shape_name					= "AV8BNA-CPT"
is_EDM						= true
new_model_format			= true
livery                      = "default"

ambient_light				= {255,255,255}
day_texture_set_value       = 0.0
ambient_color_day_texture	= {255, 0, 0}
night_texture_set_value     = 0.1
ambient_color_night_texture	= {40, 60 ,150}
ambient_color_from_devices	= {50, 50, 40}
ambient_color_from_panels	= {35, 25, 25}
dusk_border					= 0.4

draw_pilot					= false
use_external_views          = false
external_model_canopy_arg	= 38
cockpit_local_point			= {3.705, 0.703, 0.0}

Z_test                      = {
								near = 0.05, far  = 4.0,
							}

local controllers			= LoRegisterPanelControls()


--------------------------------------------------------------------------------
-- Mirror
--------------------------------------------------------------------------------
mirrors_data =
{
    width 		 	=  0.836615,
    aspect 		 	=  2.0,
	rotation 	 	= -0.15079632;
	rotation_y		= -math.pi;
	animation_speed = 2.0;
	near_clip 		= 0.1;
	middle_clip		= 10;
	far_clip		= 60000;
	connector 		= "AV8B_NA_CPT_MIRROR",
}

mirrors_draw                    = CreateGauge()
mirrors_draw.arg_number    		= 983
mirrors_draw.input   			= {0,1}
mirrors_draw.output   			= {1,0}
mirrors_draw.controller         = controllers.mirrors_draw

need_to_be_closed			= true
