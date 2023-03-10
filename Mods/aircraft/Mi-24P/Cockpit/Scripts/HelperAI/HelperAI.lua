device_timer_dt = 0.01
dofile(LockOn_Options.script_path.."HelperAI/HelperAI_sound.lua")
group_criterion = 20
min_angular_radius_for_group = 0.05
safety_switch_time = 2.0
usr_time = 3.0
scho_time = 4.0
pn_time = 5.0

long_press_time = 0.5
course_change_low_speed = 10
alt_change_low_speed = 50
course_change_high_speed = 40
alt_change_high_speed = 250
baro_alt_threshold = 700
course_alt_change_transition_time = 2

speed_change_time = 1
lag_time_for_ai_pilot = 1

shoot_in_time = 3.0

atgm_range_114 = 4500
atgm_range_120 = 6000

disable_sound = false

scan_rad_around_point = 2500

min_angular_radius =
{
    lowres = 0.0043,
    medres = 0.008,
    hires = 0.02,
    iff = 0.025,
}

min_contrast_f = 0.001

aim_pid = {p = 100, i = 10, d = 0}

stick_stowing_params = {isLagElement = true, valmin = 0, valmax = 1, T1 = 0.2, wmax = 0}

op_head_params_horz = {isLagElement = true, valmin = -1, valmax = 1, T1 = 1.0}
op_head_params_vert = {isLagElement = true, valmin = -0.3, valmax = 0, T1 = 1.0}

ohshi_head_coeff = 0.5

secret_debug_mode_render_debug_info_nikto_ne_dogadayetsya = true

-------------------------------------------
need_to_be_closed = true -- lua_state  will be closed in post_initialize()