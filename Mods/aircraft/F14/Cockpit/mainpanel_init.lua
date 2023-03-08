
submodel = get_aircraft_type()
shape = "F14B_Cockpit"
if submodel ~= "F-14B" then
    shape = "F14A_Cockpit"
end

shape_name = shape

is_EDM = true
new_shape = true 
new_model_format = true
new_infrared_debug = false
v_angle_shift 	 = math.rad(1)

simplify_cockpit = false

shift = {0, 0, 0}
rotation = math.rad(0.0)


ambient =
{
	lighttype = "ambient"
}

ambient_light = {0, 0, 255}
ambient_color_day_texture = { 72, 100, 160 }
ambient_color_night_texture = {40, 10, 180}
ambient_color_from_cockpit_illumination = {240, 240, 240}
ambient_color_from_devices = {16, 12, 12}
ambient_color_from_panels	 = {16, 12, 12}
ambient_color_from_abris	 = {10, 24, 12}
ambient_color_from_shkval	 = {50, 50, 50}

dusk_border = 0.2

draw_old_cockpit = false
draw_pilot = false
use_external_views = false 

draw_arcade = LockOn_Options.flight.easy_radar or LockOn_Options.flight.auto_lockon

external_model_canopy_arg = 38

day_texture_set_value = 0.0
night_texture_set_value = 0.1
render_target_always = true

cockpit_illumination_external = 69
nightBeginTime = 20.0
nightEndTime = 6.0


---------------------------------------------------------------
-- CONTROLLERS
---------------------------------------------------------------

local controllers = LoRegisterPanelControls()

-- MIRROR == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == = 
mirrors_data = 
{ 
	--center_point 	= {0.375,0.095,0},
	width           =  1.0,
    aspect          =  1.0,
    --rotation        = math.rad(-15),
    animation_speed = 2.0,
    near_clip       = 0.1,
    middle_clip     = 10,
	far_clip        = 600000,
	connector = "PNT_MIRROR_LOC",
}

mirrors_draw = CreateGauge()
mirrors_draw.arg_number = 16
mirrors_draw.input = {0,1}
mirrors_draw.output = {1,0}
mirrors_draw.controller = controllers.mirrors_draw

-- IN COCKPIT PILOT ==========================

pilot_draw                      = CreateGauge()
pilot_draw.arg_number           = 3335
pilot_draw.input                = {0.0, 1.0}
pilot_draw.output               = {0.0, 1.0}
pilot_draw.controller           = controllers.pilot_draw 

---------------------------------------------------------

dofile(LockOn_Options.common_script_path.."tools.lua")
livery = find_custom_livery("F-14B","default")

args_initial_state =
{
}
local hideStick = get_option_value("difficulty.hideStick","local")
if hideStick then
	args_initial_state[33] = 1.0
end

args_initial_state[3334] = 0.0
--args_initial_state[411] = 1.0

need_to_be_closed = true