local my_path = LockOn_Options.script_path.."VTH/"
dofile(my_path.."HUD_elements.lua")


--Horizon, ladder, heading tape
create_horizon()
create_ladder()
create_heading_tape()
create_flightdata()
create_general_warnings()
create_aux_gunsight()



-- FPM
create_fromsvg("vth-fpm", "vth-fpm", {0,0}, "vth-rlf", {{"vth_has_attitude"}, {"vth_fpm_vis"}, {"vth_fpm_pos"}})

--Acceleration chevrons
create_fromsvg("vth-accel", "vth-accel", {0,0}, "vth-fpm", {{"vth_has_attitude"}, {"vth_declutter"}, {"hud_acc_z"}})

--Takeoff pitch / tailstrike marker
create_fromsvg("vth-takeoff-pitch", "vth-takeoff-pitch", {0,-deg_to_mrad*13}, "vth-rlf", {{"vth_has_attitude"}})

--Ground acceleration
create_fromsvg("vth-gnd-accel-box", "vth-gnd-accel-box", {0, 87.5}, "vth-axis", {{"vth_has_attitude"}})
create_text("vth-gnd-accel", {"%01.2f"}, 9, "CenterCenter", {0, 0}, "vth-gnd-accel-box", {{"vth_has_attitude"}, {"vth_gnd_accel"}})

