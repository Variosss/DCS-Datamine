local my_path = LockOn_Options.script_path.."VTH/"
dofile(my_path.."HUD_elements.lua")

create_horizon()
create_ladder()
create_heading_tape()
create_flightdata()
create_fpm_ap()
create_but_nav()
create_magic_reticles()
create_general_warnings()
create_debug()


create_fromsvg("vth-top-cue", "vth-top-cue", {0,0}, "vth-fpm", {{"vth_has_attitude"}, {"vth_top_cue"}})
create_fromsvg("vth-rd-cue", "vth-rd-cue", {0,0}, "vth-rlf", {{"vth_fpm_pos"}, {"vth_roll"}, {"vth_rd_cue" }, {"constrain_box_h_axis"}})
