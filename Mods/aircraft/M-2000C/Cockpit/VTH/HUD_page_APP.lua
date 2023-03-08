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
create_aux_gunsight()



-- AOA Cue
create_fromsvg("vth-appr-aoa", "vth-appr-aoa", {0,0}, "vth-fpm", {{"appr_aoa"}})

-- RADALT below FPM
create_text("vth-fpm-radalt", {"H%4.f"}, 9, "CenterCenter", {0, -20}, "vth-fpm", {{"app_fpm_radalt"}})		


-- OUTER/MIDDLE/INNER MARKER
create_text("txt_omi_marker", "M", 15, "CenterCenter", {0,91.5}, "vth-axis", {{"appr_ils_marker"}})

-- ILS
create_fromsvg("vth-ils-loc", "vth-ils-loc", {0,0}, "vth-rlf", {{"vth_has_attitude"}, {"appr_loc_window" ,0.15}})
create_fromsvg("vth-ils-box", "vth-ils-box", {0,0}, "vth-rlf", {{"vth_has_attitude"}, {"appr_ils_window"}})
create_fromsvg("vth-ils-tlow", "vth-ils-tlow", {0,0}, "vth-ils-box", {{"appr_ils_tlow"}})
create_fromsvg("vth-ils-thigh", "vth-ils-thigh", {0,0}, "vth-ils-box", {{"appr_ils_thigh"}})
create_fromsvg("vth-ils-tleft", "vth-ils-tleft", {0,0}, "vth-ils-box", {{"appr_ils_tleft"}})
create_fromsvg("vth-ils-tright", "vth-ils-tright", {0,0}, "vth-ils-box", {{"appr_ils_tright"}})
create_fromsvg("vth-ils-rwy", "vth-ils-rwy", {0, 0}, "vth-rlf", {{"vth_has_attitude"}, {"appr_synth_rwy"}})
create_fromsvg("vth-app-pd", "vth-app-pd", {0,0}, "vth-rlf", {{"vth_ladder", 0.0}, {"appr_pd"}})
create_fromsvg("vth-app-cp-line", "vth-app-cp-line", {0,0}, "vth-rlf", {{"vth_roll"}, {"vth_pitch"}, {"appr_cp_hdg"}, {"appr_cp_angle"}})
create_fromsvg("vth-app-cp-tick", "vth-app-cp-tick", {0,0}, "vth-rlf", {{"vth_roll"}, {"vth_pitch"}, {"appr_cp_hdg"}})

