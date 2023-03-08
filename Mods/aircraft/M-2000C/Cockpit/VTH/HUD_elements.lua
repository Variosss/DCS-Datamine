local my_path = LockOn_Options.script_path.."VTH/"
dofile(my_path.."HUD_definitions.lua")

create_dummy("vth-rlf", {0, 92.5}, nil, {})
create_dummy("vth-axis", {0, -37.5}, nil, {})

ModeGND = 1
ModeNAV = 2
ModeAPP = 4
ModeOBL = 8
ModePOL = 16
ModeAA_Gun = 32
ModeAA_Fox1 = 64
ModeAA_Fox2 = 128
ModeAG_Gun = 256
ModeAG_Rocket = 512
ModeAG_CCIP = 1024
ModeAG_CCRP = 2048
ModeNull = 4096
ModeOther = 8192

ModesAA_All = ModeAA_Gun+ModeAA_Fox1+ModeAA_Fox2+ModePOL


function create_horizon()
	create_fromsvg("vth-horizon", "vth-horizon", {0, 0}, "vth-rlf", {{"vth_declutter"}, {"vth_roll" ,1.0}, {"vth_pitch"}})	
	for i=0,99 do
		create_fromsvg("vth-snowflake-"..i, "vth-snowflake", {0,0}, "vth-rlf", {{"vth_declutter"}, {"vth_snowflake", i}})
	end
end

function create_heading_tape()
	local hdgtape_width = 35	-- degrees
	local hdgtape_scale = 2.5	-- mrad per degree, very close to 1/7degree
	
	--Everything is attached to the main heading tick
	create_fromsvg("vth-hdg-tick", "vth-hdg-tick", {0,0}, "vth-rlf", {{"vth_has_heading"}, {"vth_declutter"}, {"vth_move_mode", 0, -75, ModeAPP }})
	create_fromsvg("vth-hdg-course", "vth-hdg-course", {0,0}, "vth-hdg-tick", {{"vth_hdg_course", hdgtape_scale, 15.0}})
	create_fromsvg("vth-hdg-ap", "vth-hdg-ap", {0,0}, "vth-hdg-tick", {{"vth_hdg_ap", hdgtape_scale, 15.0}})
	create_text("vth-hdg-ap-val", {"%03d"}, 6, "CenterTop", {0,-10}, "vth-hdg-ap", {{"vth_hdg_ap_val", 15.0}})

	push_cliprect("tape_begin", -hdgtape_width*hdgtape_scale*0.5, hdgtape_width*hdgtape_scale*0.5, 0, 20, "vth-hdg-tick")
	create_fromsvg("vth-hdg-tape", "vth-hdg-tape", {0,0}, "vth-hdg-tick", {{"vth_hdg_tape", hdgtape_scale}})
	for i=-1,2 do
		create_text("vth-hdg-tapeval"..i, {"%02d"}, 9, "CenterBottom", {i*hdgtape_scale*10,8}, "vth-hdg-tape", {{"vth_hdg_tapeval", i}})
	end
	pop_cliprect()
end



function create_ladder()
	local base = create_dummy("vth-ladder-base", {0,0}, "vth-rlf", {{"vth_has_attitude"}})
	for i=-90,90,5 do
		local bar_name = "vth-ladder"..i
		if i>0 then
			create_fromsvg(bar_name, "vth-ladder-sky", {0,0}, "vth-ladder-base", {{"vth_declutter"}, {"vth_ladder", i}})
		elseif i<0 then
			create_fromsvg(bar_name, "vth-ladder-ground", {0,0}, "vth-ladder-base", {{"vth_declutter"}, {"vth_ladder", i}})
		end
		
		if (i%10)==0 and i~=0 then
			create_text(bar_name.."-val", tostring(math.abs(i)), 9, "LeftCenter", {65,0}, bar_name, {})		
			create_text(bar_name.."-val", tostring(math.abs(i)), 9, "RightCenter", {-65,0}, bar_name, {})		
		end
	end
	return base
end



function create_flightdata()
	-- Height controller
	create_dummy("vth-flightdata", {0, 15}, "vth-rlf", {{"vth_move_mode", 0, -75, ModeAPP + ModeAA_Gun + ModeAA_Fox2 }})

	-- Left Side
	create_text("vth-ias", {"%03.f"}, 13, "RightBottom", {-70, -13}, "vth-flightdata", {{"vth_ias", 30.0}})		
	create_text("vth-mach", {"%01.2f"}, 9, "RightBottom", {-68, -24}, "vth-flightdata", {{"vth_mach", 0.6}})		
	--create_text("vth-trt", {"TR%02.1f\nPS%3.0f\nVZ%3.0f"}, 9, "RightBottom", {-68, -52}, "vth-flightdata", {{"vth_trt", 1.0}})		

	-- Right Side
	create_text("vth-balt-100", "", 13, "RightBottom", {94, -12.5}, "vth-flightdata", {{"vth_balt_100"}})
	create_text("vth-balt-1", "", 9, "RightBottom", {108, -12}, "vth-flightdata", {{"vth_balt_1"}})		
	create_text("vth-radalt", {"%01.f H", "***** H", "H"}, 9, "RightBottom", {121.5, -24}, "vth-flightdata", {{"vth_radalt"}})		
	create_text("vth-radalt-sel", {"%01.f HG"}, 9, "RightBottom", {121.5, -36}, "vth-flightdata", {{"vth_radalt_sel"}})		
	create_text("vth-but-dist", {"%1.1fN%2d ", "%3.fN%2d ", "%1.1fN%2d*", "%3.fN%2d*"}, 9, "RightBottom", {121.5, -84}, "vth-flightdata", {{"wp_dist"}})
end


function create_fpm_ap()
	create_fromsvg("vth-fpm", "vth-fpm", {0,0}, "vth-rlf", {{"vth_has_attitude"}, {"vth_fpm_vis"}, {"vth_fpm_pos"}})
	create_fromsvg("vth-accel", "vth-accel", {0,0}, "vth-fpm", {{"vth_has_attitude"}, {"vth_declutter"}, {"hud_acc_z", 1.0/3.0}})
	create_fromsvg("vth-ap-star", "vth-ap-star", {0,0}, "vth-rlf", {{"vth_declutter"}, {"vth_fpm_vis"}, {"vth_ap_star"}})
end

function create_but_nav()
	create_fromsvg("vth-course-dev", "vth-course-dev", {0,0}, "vth-rlf", {{"vth_anchor", 1.0, 1.0}, {"vth_roll"}, {"vth_course_dev"}})	
	create_fromsvg("vth-but-cross", "vth-but-cross", {0,0}, "vth-rlf", {{"vth_has_attitude"},{"wp_but_reticle"}})
end


function create_magic_reticles()
	create_dummy("vth-magic-lock-pos", {0,0}, "vth-rlf", {{"vth_has_attitude"}, {"vth_magic_lock_pos"}})
	create_fromsvg("vth-magic-ring", 		"vth-magic-ring",			{0,0}, "vth-magic-lock-pos", {{"vth_magic_symbol", 0}})	
	create_fromsvg("vth-magic-ring-out", 	"vth-magic-ring-out",		{0,0}, "vth-magic-lock-pos", {{"vth_magic_symbol", 1}})
end


function create_general_warnings()
	create_text("vth-message", "",	10.5, "CenterTop", {0, -80}, "vth-axis", {{"vth_msg"}, {"vth_move_mode", 0, 20, ModeGND }})
	create_fromsvg("vth-msg-strike", "vth-msg-strike",{0,-5.25}, "vth-message", {{"vth_msg_strike"}})
	create_fromsvg("vth-tnv", "vth-tnv", {0, 3}, "vth-message", {{"vth_msg_tnv"}})	
	create_fromsvg("vth-pullup", "vth-pullup",	{0,0}, "vth-axis", {{"vth_low_alt_warn"}, {"vth_hide_mode", ModeAPP+ModeGND}})		
	create_text("vth-lower_info", "", 10.5, "CenterCenter", { 0, -70}, "vth-axis", {{"vth_lower_info"}})
	create_text("vth-pcm", "PCM", 10.5, "CenterCenter", {-90,8}, "vth-axis", {{"vth_radar_pcm", 0}})
	create_fromsvg("vth-pcm-box", "vth-pcm-box",	{0,0}, "vth-pcm", {{"vth_radar_pcm", 1}})	
end


function create_debug()
	override_material("vth_red")
	create_dummy("debug_vis", {0,0}, "vth-rlf", {{"vth_debug_vis"}})
	create_fromsvg("vth-debug-radar", "vth-debug-radar", {0,0}, "debug_vis", {{"vth_debug_radar_direction"}})		
	for i =0,2 do
		create_fromsvg("vth-debug-pos"..i, "vth-debug-pos", {0,0}, "debug_vis", {{"vth_debug_pos", i}})
	end
	create_text("debug_ranging_mode", {"%s%"}, 9, "LeftTop", {-112, -150}, "debug_vis", {{"vth_debug_radar_mode"}})
	create_fromsvg("vth-debug-magic", "vth-debug-magic", {0,0}, "debug_vis", {{"vth_debug_magic"}})
	create_fromsvg("vth-debug-target-pred", "vth-debug-target-pred", {0,0}, "debug_vis", {{"vth_debug_target_pred"}})		
	create_fromsvg("vth-debug-shell-pred", "vth-debug-shell-pred", {0,0}, "debug_vis", {{"vth_debug_shell_pred"}})		
	override_material_end()
end

function create_aux_gunsight()
	create_fromsvg("vth-aux-gunsight", "vth-aux-gunsight", {0, 0}, "vth-rlf", {{"vth_aux_gunsight"}})	
	create_text("vth-aux-gunsight-val", {"%1.f"}, 9, "LeftCenter", {25, 10}, "vth-aux-gunsight", {{"vth_aux_gunsight_val"}})
end


