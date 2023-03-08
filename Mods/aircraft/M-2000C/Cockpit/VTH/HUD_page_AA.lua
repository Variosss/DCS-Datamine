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


create_dummy("vth-target-pos", {0,0}, "vth-rlf", {{"vth_has_attitude"}, {"vth_radar_lock_pos"}})
create_fromsvg("vth-target-box", 		"vth-target-box", 		{0,0}, "vth-target-pos", {{"vth_radar_lock_symbol", 0}})	
create_fromsvg("vth-target-box-out", 	"vth-target-box-out", 	{0,0}, "vth-target-pos", {{"vth_radar_lock_symbol", 1}})	
create_fromsvg("vth-target-box-jam",	"vth-target-box-jam",	{0,0}, "vth-target-pos", {{"vth_radar_lock_symbol", 2}})	
create_fromsvg("vth-target-box-pred",	"vth-target-box-pred", 	{0,0}, "vth-target-pos", {{"vth_radar_lock_symbol", 3}})	
create_fromsvg("vth-target-tri", 		"vth-target-tri", 		{0,0}, "vth-target-pos", {{"vth_radar_lock_symbol", 4}})	
create_fromsvg("vth-target-tri-out", 	"vth-target-tri-out", 	{0,0}, "vth-target-pos", {{"vth_radar_lock_symbol", 5}})	
create_fromsvg("vth-target-tri-jam",	"vth-target-tri-jam",	{0,0}, "vth-target-pos", {{"vth_radar_lock_symbol", 6}})	
create_fromsvg("vth-target-tri-pred",	"vth-target-tri-pred", 	{0,0}, "vth-target-pos", {{"vth_radar_lock_symbol", 7}})	
create_fromsvg("vth-target-iff-a", 		"vth-target-iff-a", 	{0,0}, "vth-target-pos", {{"vth_radar_lock_symbol", 8}})	
create_fromsvg("vth-target-iff-d", 		"vth-target-iff-d", 	{0,0}, "vth-target-pos", {{"vth_radar_lock_symbol", 9}})	
create_fromsvg("vth-target-iff-query", 	"vth-target-iff-query",	{0,0}, "vth-target-pos", {{"vth_radar_lock_symbol", 10}})	


--Radar Target Data
create_fromsvg("vth-tgt-range-bar", "vth-tgt-range-bar", {85, -67.5, 0}, "vth-axis", {{"vth_has_attitude"}, {"vth_tgt_range_bar"}})	
create_fromsvg("vth-tgt-range-dmax", "vth-tgt-range-dmax", {0, 0}, "vth-tgt-range-bar", {{"vth_tgt_range_dmark", 100.0, 2}})	
create_fromsvg("vth-tgt-range-dnez", "vth-tgt-range-dnez", {0, 0}, "vth-tgt-range-bar", {{"vth_tgt_range_dmark", 100.0, 1}})	
create_fromsvg("vth-tgt-range-dmin", "vth-tgt-range-dmin", {0, 0}, "vth-tgt-range-bar", {{"vth_tgt_range_dmark", 100.0, 0}})	
create_fromsvg("vth-tgt-range", "vth-tgt-range", {0, 0}, "vth-tgt-range-bar", {{"vth_show_mode", ModesAA_All}, {"vth_tgt_range", 100.0}})	
create_text("vth-tgt-range-val", {"%1.f", "%1.1f", "%1.f"}, 6, "LeftCenter", {8, 0}, "vth-tgt-range", {{"vth_tgt_range_val"}})
create_text("vth-tgt-cv", {"%01.f"}, 9, "RightCenter", {78, 32.5}, "vth-axis", {{"vth_has_attitude"}, {"vis_radar_haslock"}, {"vth_tgt_cv"}})
create_fromsvg("vth-tgt-cv-box", "vth-tgt-cv-box", {3, 0}, "vth-tgt-cv", {})
create_text("vth-tgt-aspect", {"%d"}, 10, "CenterCenter", {0, -33}, "vth-axis", {{"vth_has_attitude"}, {"vth_tgt_aspect"}})
			

-- Missiles
create_dummy("vth-director", {0, 0}, "vth-axis", {{"vth_director"}})	
create_fromsvg("vth-director-ring", "vth-director-ring",	{0, 0}, "vth-director", {{"vth_director_ring"}})	
create_fromsvg("vth-inrange-ring", "vth-inrange-ring",	{0, 0}, "vth-director-ring", {{"vth_inrange_ring"}})	
create_fromsvg("vth-director-fly", "vth-director-fly",	{0, 0}, "vth-director", {{"vth_director_fly"}})	
create_fromsvg("vth-director-fly", "vth-director-fly",	{0, 0}, "vth-director", {{"vth_director_fly"}})	
create_text("vth-director-g", {"%0.1f"}, 10, "CenterCenter", {0,  33}, "vth-director", {{"vth_director_g"}})
create_fromsvg("vth-breakaway", "vth-breakaway",	{0, 0}, "vth-director", {{"vth_breakaway"}})	
create_fromsvg("vth-psic-mem", "vth-psic-mem",	{0, -13}, "vth-director", {{"vth_psic_mem"}})	
create_text("vth-msg-TIR", "TIR", 10, "CenterCenter", {0, -46}, "vth-director", {{"vth_msg_tir"}})
create_text("vth-msg-DOM", "DOM", 10, "CenterCenter", {0, -46}, "vth-axis", {{"vth_msg_dom"}})


-- MAV
create_fromsvg("vth-mag-vscan", "vth-mag-vscan", {-85, 33.5}, "vth-axis", {{"vth_mag_vscan"}})	
create_fromsvg("vth-mag-hscan", "vth-mag-hscan", {-85, 33.5}, "vth-axis", {{"vth_mag_hscan"}})	


local mav_window_coef = 1000*3.14159/180
create_fromsvg("vth-mav-window-ul", "vth-mav-window-ul", {-3.4*mav_window_coef, 1.0*mav_window_coef}, "vth-rlf", {{"vth_mav_window"}})	
create_fromsvg("vth-mav-window-ur", "vth-mav-window-ur", { 3.4*mav_window_coef, 1.0*mav_window_coef}, "vth-rlf", {{"vth_mav_window"}})	
create_fromsvg("vth-mav-window-bl", "vth-mav-window-bl", {-3.4*mav_window_coef,-5.0*mav_window_coef}, "vth-rlf", {{"vth_mav_window"}})	
create_fromsvg("vth-mav-window-br", "vth-mav-window-br", { 3.4*mav_window_coef,-5.0*mav_window_coef}, "vth-rlf", {{"vth_mav_window"}})	






-- WEAPONS DATA
-- LEFT SIDE DATA
create_text("vth-engage-rule", {"%s"}, 9, "LeftTop", {-112,45}, "vth-axis", {{"vth_engage_rule"}})
create_text("vth-weapon", {"%s"}, 9, "LeftTop", {-112,35}, "vth-axis", {{"vth_sel_weapon"}})
create_text("vth-gmeter", {"%01.1fG"}, 9, "RightTop", {-82, 25}, "vth-axis", {{"vth_gmeter"}})



-- Missiles
-- Missiles
--create_text("vth-salvo", "S", 10.5, "CenterCenter", {0,-62},    "vth-axis", {{"vth_530_salvo"}})		
create_text("vth-wpn-g", "G", 10.5, "CenterCenter", {-50, -62}, "vth-axis", {{"vth_mis_present", 0}})
create_text("vth-wpn-d", "D", 10.5, "CenterCenter", { 50, -62}, "vth-axis", {{"vth_mis_present", 1}})
create_fromsvg("vth-active-missile-g", 	"vth-active-missile", {0,0}, "vth-wpn-g", {{"vth_mis_active", 0}})	
create_fromsvg("vth-active-missile-d", 	"vth-active-missile", {0,0}, "vth-wpn-d", {{"vth_mis_active", 1}})	
create_text("vth-tof-g", {"%1.f"}, 9, "CenterCenter", {-50, -50}, "vth-axis", {{"vth_530_tof", 0}, {"vth_move_mode", -20, 58, ModeAA_Gun+ModeAA_Fox2 }})
create_text("vth-tof-d", {"%1.f"}, 9, "CenterCenter", { 50, -50}, "vth-axis", {{"vth_530_tof", 1}, {"vth_move_mode",  20, 58, ModeAA_Gun+ModeAA_Fox2 }})
create_fromsvg("vth-tof-forf-g", "vth-tof-forf", {0,0}, "vth-tof-g", {{"vth_530_tof_forf", 0}})
create_fromsvg("vth-tof-forf-d", "vth-tof-forf", {0,0}, "vth-tof-d", {{"vth_530_tof_forf", 1}})



-- Gun Ammo
create_text("vth-gun-ammo-g", {"%d"}, 9, "CenterCenter", {-27, -62}, "vth-axis", {{"vth_gun_ammo", 0}})
create_text("vth-gun-ammo-d", {"%d"}, 9, "CenterCenter", { 27, -62}, "vth-axis", {{"vth_gun_ammo", 1}})


-- Close Air Combat Mode
create_fromsvg("vth-ccm-axe", "vth-ccm-axe",	{0, 0}, "vth-rlf", {{"vth_ccm_paxe"}})	
create_fromsvg("vth-ccm-psp", "vth-ccm-psp",	{0, 0}, "vth-rlf", {{"vth_ccm_psp"}})	
create_fromsvg("vth-ccm_scan", "vth-ccm-scan",	{0, 0}, "vth-rlf", {{"vth_ccm_scan"}})	
create_text("vth-ccm-mode", {"%s"}, 9, "RightTop", {108,41.5}, "vth-axis", {{"vth_ccm_mode"}})


-- WEAPONS CUES


-- AA - Gun
create_fromsvg("vth-gun-cross", "vth-gun-cross",	{0,0}, "vth-rlf", {{"vth_gun_cross"}})	
create_fromsvg("vth-snake", "vth-app-cp-line", {0, 0}, "vth-rlf", {{"vth_has_attitude"}, {"vth_snake"}})			
create_fromsvg("vth-snake-bar-300m", "vth-snake-bar", {0, 0}, "vth-snake", {{"vth_has_attitude"}, {"vth_snake_bar", 300}})			
create_fromsvg("vth-snake-bar-600m", "vth-snake-bar", {0, 0}, "vth-snake", {{"vth_has_attitude"}, {"vth_snake_bar", 600}})			
create_fromsvg("vth-gun-reticle", "vth-gun-reticle",	{0,0}, "vth-rlf", {{"vth_has_attitude"}, {"vth_gun_reticle"}})	
create_fromsvg("vth-gun-range", "vth-gun-range", {0, 0}, "vth-gun-reticle", {{"vth_gun_range", 20}})			
create_fromsvg("vth-gun-range-future", "vth-gun-range-future",	{0,0}, "vth-gun-reticle", {{"vth_gun_range_future", 5.0}})	
create_fromsvg("vth-pol-range-tick", "vth-pol-range-tick",	{0,0}, "vth-gun-reticle", {{"vth_show_mode", ModePOL}})	
create_fromsvg("vth-cclt-marker-1", "vth-cclt-marker", {0,0}, "vth-rlf", {{"vth_has_attitude"}, {"vth_cclt_shoot", -1}})
create_fromsvg("vth-cclt-marker-2", "vth-cclt-marker", {0,0}, "vth-rlf", {{"vth_has_attitude"}, {"vth_cclt_shoot", -2}})
for i=0,100 do
	create_fromsvg("vth-cclt-shoot-"..i, "vth-cclt-shoot", {0,0}, "vth-rlf", {{"vth_has_attitude"}, {"vth_cclt_shoot", i}})
end