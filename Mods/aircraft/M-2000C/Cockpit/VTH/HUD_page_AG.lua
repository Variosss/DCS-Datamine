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


-- LEFT
create_text("vth-weapon", {"%s"}, 9, "LeftTop", {-112,37.5}, "vth-axis", {{"vth_sel_weapon",0}})
create_text("vth-gmeter", {"%01.1fG"}, 9, "LeftTop", {-109, 27.5}, "vth-axis", {{"vth_gmeter",0}})

-- RIGHT
create_text("vth-gnd-range", {"%1.1fKM", "%1.0fKM"}, 9, "RightTop", {108,113.5}, "vth-axis", {{"vth_gnd_range"}})

-- AG Gun & Rockets
create_text("vth-gun-ammo-g", {"%d"}, 9, "CenterCenter", {-27, -62}, "vth-axis", {{"vth_gun_ammo", 0}})
create_text("vth-gun-ammo-d", {"%d"}, 9, "CenterCenter", { 27, -62}, "vth-axis", {{"vth_gun_ammo", 1}})
create_fromsvg("vth-gun-reticle", "vth-gun-reticle",	{0,0}, "vth-rlf", {{"vth_gun_reticle"}})	
create_fromsvg("vth-gun-range", "vth-gun-range", {0, 0}, "vth-gun-reticle", {{"vth_gun_range", 20}})			

-- CCRP
create_dummy("vth-ccrp-sight", {0,0}, "vth-rlf", {{"vth_ccrp_sight"}})
create_fromsvg("vth-ccrp-desig", "vth-ccrp-desig", {0, 0}, "vth-ccrp-sight", {{"vth_ccrp_desig"}})
create_fromsvg("vth-ccrp-wings", "vth-ccrp-wings", {0, 0}, "vth-rlf", {{"vth_anchor", 1.0, 1.0},{"vth_ccrp_wings"}})
create_fromsvg("vth-ccrp-armed", "vth-ccrp-armed", {0, 0}, "vth-ccrp-desig", {{"vth_weapon_hot"}, {"vth_mode_pi", 1}})
create_fromsvg("vth-ccrp-ttr", "vth-ccrp-ttr", {0, 0}, "vth-rlf", {{"vth_anchor", 1.0, 1.0},{"vth_ag_ttr"}})

--CCIP
create_fromsvg("vth-ccip-sight", "vth-ccip-sight", {0, 0}, "vth-rlf", {{"vth_ccip_vis"}, {"vth_ccip_sight"}})
create_fromsvg("vth-ccip-armed", "vth-ccip-armed", {0, 0}, "vth-ccip-sight", {{"vth_weapon_hot"}})
create_text("vth-ccip-forf", "300", 9, "CenterTop", {0, 24}, "vth-ccip-sight", {{"vth_ccip_forf"}})
create_fromsvg("vth-ccip-bfl", "vth-ccip-bfl", {0,0}, "vth-rlf", {{"vth_ccip_vis"}, {"vth_ccip_bfl"}})
create_dummy("vth-ccip-fpm", {0,0}, "vth-rlf", {{"vth_fpm_vis"}, {"vth_fpm_pos"}, {"vth_ccip_vis"}})
create_fromsvg("vth-ccip-vz", "vth-ccip-vz", {-30,0}, "vth-ccip-fpm", {{"vth_ccip_vz"}})
create_fromsvg("vth-ccip-vz-arrow", "vth-ccip-vz-arrow", {12,0}, "vth-ccip-fpm", {{"vth_ccip_vz_arrow"}})		
create_fromsvg("vth-ccip-ttr", "vth-ccip-ttr", {0, 0}, "vth-ccip-fpm", {{"vth_ag_ttr"}})

--Safety cues
create_fromsvg("vth-minsafe-height", "vth-minsafe-height", {0,0}, "vth-rlf", {{"vth_anchor", 1.0, 1.0}, {"vth_minsafe_height"}})		
create_fromsvg("vth-no-release", "vth-breakaway",	{0,0}, "vth-axis", {{"vth_no_release"}})	


	

