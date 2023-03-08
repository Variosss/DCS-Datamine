local my_path = LockOn_Options.script_path.."VTB/"
dofile(my_path.."VTB_definitions.lua")


local nextmode = 1
function createmode()
	local mode = nextmode
	nextmode = nextmode*2
	return mode
end


ModeGND 		= createmode()
ModeNAV 		= createmode()
ModeAPP 		= createmode()
ModeOBL 		= createmode()
ModePOL 		= createmode()
ModeAA_Gun 		= createmode()
ModeAA_Fox1 	= createmode()
ModeAA_Fox2 	= createmode()
ModeAG_Gun 		= createmode()
ModeAG_Rocket 	= createmode()
ModeAG_CCIP 	= createmode()
ModeAG_CCRP 	= createmode()
ModeNull 		= createmode()
ModeOther 		= createmode()
ModeAll			= nextmode-1

nextmode = 1
ModeRDI_OFF		= createmode()
ModeRDI_PCH		= createmode()
ModeRDI_PCM		= createmode()
ModeRDI_PSP		= createmode()
ModeRDI_AUTO	= createmode()
ModeRDI_PSIC	= createmode()
ModeRDI_SHB		= createmode()
ModeRDI_PSID	= createmode()
ModeRDI_TAS		= createmode()
ModeRDI_SIL		= createmode()
ModeRDI_DEC		= createmode()
ModeRDI_VISU	= createmode()
ModeRDI_SCAN	= createmode()
ModeRDI_All		= nextmode-1

ModesRDI_AG = ModeRDI_DEC + ModeRDI_SHB + ModeRDI_VISU + ModeRDI_TAS
ModesRDI_NO_AG = ModeRDI_All - ModesRDI_AG

ModesAAPol = ModePOL + ModeAA_Gun + ModeAA_Fox1 + ModeAA_Fox2
ModesAG = ModeAG_Gun + ModeAG_Rocket + ModeAG_CCIP + ModeAG_CCRP

GridPPI = 1
GridBScope = 2
GridCAD = 4



function create_radar_grid(type, aircraft_pos)
	push_color("vtb_mrq")
	create_fromsvg("vtb-grid-1", "vtb-grid-"..type.."1", aircraft_pos, nil)
	create_fromsvg("vtb-grid-2", "vtb-grid-"..type.."2", aircraft_pos, nil, {{"vtb_rng_lvl_min", 2}})
	pop_color()
end

function create_cad_grid(aircraft_pos)
	push_color("vtb_mrq")
	create_fromsvg("vtb-grid-cad", "vtb-grid-cad", aircraft_pos, nil)
	pop_color()
end

function create_radar_text()
	push_color("vtb_cav")
	create_text("vtb-rdr-mode", 	{"%s"}, 	2.5 , "CenterCenter", {37,45}, nil, {{"vtb_rdr_mode"}, {"vtb_scaleoption", 1.25}})	
	create_text("vtb-rdr-sil", 		"SIL",		4.0, "CenterCenter", { 0, 15}, nil, {{"vtb_rdr_sil"}})
	create_text("vtb-rdr-range", 	{"%d"}, 	2.5, "LeftCenter",	 { 2, 42}, nil, {{"vtb_rdr_range"}, {"vtb_move_bygrid", 0, 5, GridCAD }, {"vtb_scaleoption", 1.25}})
	create_text("vtb-rdr-ch-a",		{"%d"}, 	2.5, "CenterCenter", {50, 39}, nil, {{"vtb_rdr_ch", 0, 0}})
	create_text("vtb-rdr-ch-b",		{"%d"}, 	2.5, "CenterCenter", {58, 39}, nil, {{"vtb_rdr_ch", 1, 0}})
	create_text("vtb-rdr-chm-a",	{"%d"}, 	2.5, "CenterCenter", {50, 35}, nil, {{"vtb_rdr_ch", 0, 1}})
	create_text("vtb-rdr-chm-b",	{"%d"}, 	2.5, "CenterCenter", {58, 35}, nil, {{"vtb_rdr_ch", 1, 1}})
	create_text("vtb-rdr-jammed",	"B",		4.0, "CenterCenter", {-50,50}, nil, {{"vtb_rdr_jammed"}})
	create_text("vtb-rdr-hardtfac",	"A",		4.0, "CenterCenter", {-50,56}, nil, {{"vtb_rdr_hardtfac"}})
	create_text("vtb-lock-mode",	{"%1.0f"},	2.5, "RightBottom",  {55,-42}, nil, {{"vtb_lock_mode"}, {"vtb_scaleoption", 1.25}})
	create_text("vtb-msg-tel",		"TEL",		3.0, "LeftCenter", 	 {-45,44}, nil, {{"vtb_msg_tel"}, {"vtb_show_bymode", ModeNAV}})
	create_text("vtb-msg-taf",		"TAF",		3.0, "LeftCenter", 	 {-45,32}, nil, {{"vtb_msg_taf"}})
	create_text("vtb-msg-pcm",		"PCM",		3.0, "CenterCenter", {54, 45}, nil, {{"vtb_msg_pcm"}})
	--create_text("vtb-msg-evf",	"EVF",		3.0, "LeftCenter", 	 {-45,38}, nil, {})
	pop_color()
end



function create_tdc(pos, scale_y, mm_per_deg)
	push_color("vtb_mrq")
	create_dummy("vtb-tdc-pos", pos, nil, {{"vtb_tdc_pos", scale_y, mm_per_deg or scale_y}})
	create_fromsvg("vtb-tdc-ret", "vtb-tdc", {0,0}, "vtb-tdc-pos", {{"vtb_tdc_ret"}})
	create_text("vtb-tdc-rng", {"%1.f", "%1.1f"}, 4, "RightBottom", {-9, 0.0}, "vtb-tdc-pos", {{"vtb_tdc_rng"}})
	create_text("vtb-tdc-alt-h", {"%d"}, 3, "LeftBottom",  {6, 6}, "vtb-tdc-pos", {{"vtb_tdc_alt_h"}})
	create_text("vtb-tdc-alt-m", {"%d"}, 3, "LeftCenter",  {6, 0}, "vtb-tdc-pos", {{"vtb_tdc_alt_m"}})
	create_text("vtb-tdc-alt-l", {"%d"}, 3, "LeftTop",     {6,-6}, "vtb-tdc-pos", {{"vtb_tdc_alt_l"}})
	pop_color()
end

function create_heading_tape()
	push_color("vtb_cav")
	local mm_per_deg = 1.04		--Heading scale is exactly 1.04mm per degree from the doc
	create_dummy("vtb-hdg-tape", {0.0, -47.5}, nil, {{"vtb_hdg_tape"}})

	push_cliprect("tape_begin", -43.5*mm_per_deg, 43.5*mm_per_deg, 2, -20, "vtb-hdg-tape")
	create_fromsvg("vtb-hdg-tape-scale", 		"vtb-hdg-tape-scale", {0,0}, "vtb-hdg-tape", {{"vtb_hdg_tape_scale", mm_per_deg}})
	for i=-1,2 do
		create_text("vtb-hdg-tape-val"..i, {"%02d"}, 2.5, "CenterBottom", {i*mm_per_deg*30,-6}, "vtb-hdg-tape-scale", {{"vtb_hdg_tape_val", i}, {"vtb_scaleoption", 1.15}})
	end
	pop_cliprect()
	
	create_fromsvg("vtb-course-tick", 	"vtb-course-tick", 	{0,0}, "vtb-hdg-tape", {{"vtb_course_tick", mm_per_deg}})
	create_fromsvg("vtb-tdc-az", 		"vtb-az-tick", 		{0,0}, "vtb-hdg-tape", {{"vtb_tdc_az", 		mm_per_deg}})
	create_fromsvg("vtb-taf-course", 	"vtb-taf-course", 	{0,0}, "vtb-hdg-tape", {{"vtb_declutter"}, {"vtb_taf_course", 	mm_per_deg, 50.0}})
	create_fromsvg("vtb-magic-az", 		"vtb-az-tick", 		{0,0}, "vtb-hdg-tape", {{"vtb_magic_az", 	mm_per_deg}})
	pop_color()
end


function create_elev_scale()
	push_color("vtb_cav")
	local mm_per_deg = 5.0/6.0
	create_fromsvg("vtb-elev-scale",	"vtb-elev-scale",	{-62,0}, 	nil, 			  {{"vtb_ribbon", 0}, {"vtb_elev_scale"}})
	create_fromsvg("vtb-ant-elev",		"vtb-elev-tick",	{6,0}, 		"vtb-elev-scale", {{"vtb_ant_elev", 	mm_per_deg}})
	create_text("vtb-lines-elev", {"%d"}, 2.5,"LeftCenter", {13,0}, 	"vtb-elev-scale", {{"vtb_lines_elev", mm_per_deg}})
	create_fromsvg("vtb-magic-elev",	"vtb-elev-tick", 	{6,0}, 		"vtb-elev-scale", {{"vtb_magic_elev", mm_per_deg}})
	pop_color()
end




function create_attitude()
	push_color("vtb_cav")
	-- 1.0/0.6 mm per slope deg limited to 30 degrees
	create_fromsvg("vtb-aircraft", 	"vtb-aircraft", {0,0}, nil, {})
	create_fromsvg("vtb-horizon", 	"vtb-horizon", {0,0}, "vtb-aircraft", {{"vtb_horizon", 1.0/0.6, 30.0}})
	pop_color()
end

function create_speed_vector()
	push_color("vtb_cav")
	create_fromsvg("vtb-speed-vector", "vtb-arrow", {0,0}, "vtb-aircraft-pos", {{"vtb_speed_vector", 5.0}})	-- 5mm per 100m/s
	create_fromsvg("vtb-taf-vector", "vtb-arrow", {0,0}, "vtb-aircraft-pos", {{"vtb_declutter"}, {"vtb_taf_vector", 5.0}})	-- 5mm per 100m/s
	pop_color()
end

function create_flight_data()
	push_color("vtb_cav")
	create_text("vtb-ias", 		{"%03.f"}, 3, "LeftBottom",  {-45, -58}, nil, {{"vtb_ias", 30.0}})		
	create_text("vtb-mach", 	{"%01.1f"},3, "LeftBottom",  {-45, -62}, nil, {{"vtb_mach", 0.6}})		
	create_text("vtb-taf-mach", {"%01.1f"},3, "LeftBottom",  {-25, -62}, nil, {{"vtb_declutter"}, {"vtb_taf_mach", 0.6}})		
	create_text("vtb-taf_balt", {"%01.f"}, 3, "RightBottom", { 25, -58}, nil, {{"vtb_declutter"}, {"vtb_taf_balt"}})
	create_text("vtb-balt", {"%01.f"}, 3, "RightBottom", { 45, -58}, nil, {{"vtb_balt"}})
	create_text("vtb-radalt",  {"H%5.f", "H*****", "H     "}, 3, "CenterBottom", {0,-6}, nil, {{"vtb_radalt"}, {"vtb_show_rdimode", ModesRDI_AG}})
	create_text("vtb-dec-hd", {"HD%4d"}, 3, "LeftBottom", {23, -19}, nil, {{"vtb_dec_hd"}, {"vtb_show_rdimode", ModeRDI_DEC+ModeRDI_SHB}})
	create_fromsvg("vtb-radalt-low", "vtb-radalt-low", {0,0}, nil, {{"vtb_radalt_low"}})
	pop_color()
end



--Sweep
function create_sweep(pos, range_scale, mm_per_deg)
	push_color("vtb_vid")
	create_fromsvg("vtb-rdr-arc", "vtb-rdr-arc", pos, nil, {{"vtb_rdr_arc", range_scale, mm_per_deg}})
	create_fromsvg("vtb-iff-arc", "vtb-rdr-arc", pos, nil, {{"vtb_iff_arc", range_scale*0.95, mm_per_deg}})
	pop_color()
end


function create_synth_contacts(n, pos, scale_y, mm_per_deg)
	push_color("vtb_vid")
	for i=0,n-1 do
		create_contact("vtb-contact-pos-".. i, pos, nil, {{"vtb_contact_symbol", 0, i}, {"vtb_contact_pos", i, scale_y, mm_per_deg or scale_y}})	-- Mouette
		create_contact_mach("vtb-contact-cvel-".. i, 3.0, "LeftCenter", {3.5,0}, "vtb-contact-pos-".. i, {{"vtb_contact_cvel", i}})			-- CV Pseudo Mach
		create_contact("vtb-iff-contact-".. i.. i, pos, nil, {{"vtb_contact_symbol", 5, i}, {"vtb_iff_pos", i, scale_y, mm_per_deg or scale_y}})	-- Diamond
	end
	pop_color()
end

function create_jam_sources(n, pos, scale_y, mm_per_deg)
	push_color("vtb_vid")
	for i=0,n-1 do
		create_contact("vtb-jam-".. i, pos, nil, {{"vtb_contact_symbol", 4, i}, {"vtb_jam_pos", i, scale_y, mm_per_deg or scale_y}})	-- Stars
	end
	pop_color()
end

function create_lock_contact(pos, scale_y, mm_per_deg)
	push_color("vtb_cav")
	create_contact("vtb-acqu-pos", pos, nil, {{"vtb_contact_symbol", 2}, {"vtb_lock_pos", scale_y, mm_per_deg or scale_y}})
	create_contact("vtb-lock-pos", pos, nil, {{"vtb_contact_symbol", 1}, {"vtb_lock_pos", scale_y, mm_per_deg or scale_y}})
	create_text("vtb_lock_range",  {"%1.f", "%1.1f"}, 4, "RightCenter", {-6, 0}, "vtb-lock-pos", {{"vtb_lock_range"}})
	create_fromsvg("vtb-lock-speedvec", "vtb-arrow", {0,0}, "vtb-lock-pos", {{"vtb_lock_speedvec", 5.0}})
	
	--Aspect marker also includes number of contacts
	create_text("vtb-lock-aspect",  {"%d", "%d\n\n%d"}, 3, "LeftTop", {6, 1}, "vtb-lock-speedvec", {{"vtb_lock_aspect"}})
	
	--Lock line is exactly 100mm
	create_fromsvg("vtb-lock-line", 	"vtb-lock-line"    , pos, nil, {{"vtb_lock_line", 0, mm_per_deg}})
	create_fromsvg("vtb-lock-line-jam", "vtb-lock-line-jam", pos, nil, {{"vtb_lock_line", 1, mm_per_deg}})
	
	create_fromsvg("vtb-lock-dmin", "vtb-lock-dmin", {0,0}, "vtb-lock-line", {{"vtb_lock_dmark", scale_y, 0}})
	create_fromsvg("vtb-lock-dnez", "vtb-lock-dnez", {0,0}, "vtb-lock-line", {{"vtb_lock_dmark", scale_y, 1}})
	create_fromsvg("vtb-lock-dmax", "vtb-lock-dmax", {0,0}, "vtb-lock-line", {{"vtb_lock_dmark", scale_y, 2}})
	pop_color()
end


function create_do_contact(pos, scale_y, scale_z)
	push_color("vtb_cav")
	create_contact("vtb-do-pos", pos, nil, {{"vtb_contact_symbol", 3}, {"vtb_do_pos", scale_y, scale_z or scale_y}})
	create_fromsvg("vtb-do-speedvec", "vtb-arrow-dashed", {0,0}, "vtb-do-pos", {{"vtb_declutter"}, {"vtb_do_speedvec", 5.0, 1.0}})
	create_text("vtb-do-aspect",  {"%d"}, 3, "LeftTop", {6, 1}, "vtb-do-speedvec", {{"vtb_do_aspect"}})
	create_fromsvg("vtb-do-line", "vtb-lock-line", pos, nil, {{"vtb_declutter"}, {"vtb_do_line", scale_z}})
	create_text("vtb-do-raz",  "RAZ", 3, "CenterCenter", {-56, -54}, nil, {{"vtb_do_raz"}})
	pop_color()
end


function create_lock_info()
	push_color("vtb_cav")
	create_text("vtb-lock-mach",	{"%1.1f"}, 		3, "RightBottom", {-33, 55.0}, nil, {{"vtb_tgt_mach"}})		-- Mach speed
	create_text("vtb-lock-course",  "RB", 			2, "RightBottom", {-15.5,55.5}, nil, {{"vtb_tgt_course"}})	-- Course in degrees
	create_text("vtb-lock-course",  {"%03.f"}, 		3, "LeftBottom",  {-15, 55.0}, nil, {{"vtb_tgt_course"}})	-- Course in degrees
	create_text("vtb-lock-cv",  	{"%1.f"}, 		3, "RightBottom", { 20, 55.0}, nil, {{"vtb_tgt_cv"}})		-- Closing velocity
	create_text("vtb-lock-cv",  	"VR", 			2, "LeftBottom",  {20.5,55.5}, nil, {{"vtb_tgt_cv"}})		-- Closing velocity
	create_text("vtb-lock-balt",	{"%1.0f"}, 		3, "RightBottom", { 48, 55.0}, nil, {{"vtb_tgt_balt"}})		-- Altitude
	create_text("vtb-lock-nctr",	{"%1.0f"}, 		2, "RightBottom", { 43, -42 }, nil, {{"vtb_lock_nctr"}, {"scale_element", 1,2}})	-- NCTR
	create_text("vtb-taf-force",	{"%c"},			3, "CenterBottom",{ 59,   55}, nil, {{"vtb_taf_force"}})
	pop_color()
end

function create_aa_director()
	push_color("vtb_cav")
	create_dummy("vtb-director", {0, 0}, nil, {{"vtb_director"}})	
	create_fromsvg("vtb-director-ring", "vtb-director-ring",	{0, 0}, "vtb-director", {{"vtb_director_ring"}})	
	create_fromsvg("vtb-inrange-ring", "vtb-inrange-ring",	{0, 0}, "vtb-director-ring", {{"vtb_inrange_ring"}})	
	create_fromsvg("vtb-director-fly", "vtb-director-fly",	{0, 0}, "vtb-director", {{"vtb_director_fly"}})	
	create_fromsvg("vtb-psic-mem", "vtb-psic-mem",	{0, 0}, "vtb-director", {{"vtb_psic_mem"}})	
	pop_color()
end


function create_waypoints(aircraft_pos, scale_y, scale_z)
	push_color("vtb_cav")
	--BRA from reference waypoint to TDC
	create_text("vtb-ref-wp",	{"%02d"}, 	 2.5, "CenterBottom", {-44, -38.5}, nil, {{"vtb_wp_ref_id"}, {"vtb_scaleoption", 1.25}})
	create_text("vtb-ref-bra",	{"%2.f/%03.f"}, 2.5, "CenterTop", {-44, -41}, nil, {{"vtb_wp_ref_br"}, {"vtb_scaleoption", 1.25}})
	create_fromsvg("vtb-wp-0-pos", "vtb-wp-pos", aircraft_pos, nil, {{"vtb_wp_pos", 0, scale_y, scale_z or scale_y}, {"vtb_hide_bymode", ModesAAPol}})
	create_fromsvg("vtb-wp-0-rd", "vtb-wp-rd", {0,0}, "vtb-wp-0-pos", {{"vtb_wp_rd"}})
	for i=1,5 do
		create_fromsvg("vtb-wp-"..i.."-pos", "vtb-wp-pos", aircraft_pos, nil, {{"vtb_wp_pos", i, scale_y, scale_z or scale_y}, {"vtb_hide_bymode", ModesAG}, {"vtb_ribbon", 0}})
		create_text("vtb-wp-"..i.."-id",	{"%d"}, 2.5, "BottomLeft", {3,0}, "vtb-wp-"..i.."-pos", {{"vtb_wp_id", i}})
	end
	pop_color()
end

function create_mdo()
	push_color("vtb_cav")
	create_text("vtb-mdo-DT",		{"dT\n%03.f"					}, 				3, "CenterTop", {-56,  26}, nil, {{"vtb_ribbon", 1},{"vtb_ribbon_dt"}})
	create_text("vtb-mdo-N",		{ "N\n%02d"						}, 				3, "CenterTop", {-56,   1}, nil, {{"vtb_ribbon", 1},{"vtb_wp_ref_id"}})
	create_text("vtb-mdo-RHO",		{ "p\n%03.f",  "p\n***",  "p\n%03.f\n%03.f"}, 	3, "CenterTop", {-56, -23}, nil, {{"vtb_ribbon", 1},{"vtb_ribbon_val",0}})
	create_text("vtb-mdo-THETA",	{ "t\n%03.f",  "t\n***",  "t\n%03.f\n%03.f"}, 	3, "CenterTop", {-56, -48}, nil, {{"vtb_ribbon", 1},{"vtb_ribbon_val",1}})
	create_text("vtb-mdo-C",		{ "C\n%03.f",  "C\n***",  "C\n%03.f\n%03.f"}, 	3, "CenterTop", { 56,  26}, nil, {{"vtb_ribbon", 1},{"vtb_ribbon_val",2}})
	create_text("vtb-mdo-Z",		{ "Z\n%03.f",  "Z\n***",  "Z\n%03.f\n%03.f"}, 	3, "CenterTop", { 56,   1}, nil, {{"vtb_ribbon", 1},{"vtb_ribbon_val",3}})
	create_text("vtb-mdo-M",		{ "M\n%01.1f", "M\n***",  "M\n%01.1f\n%01.1f"}, 3, "CenterTop", { 56, -23}, nil, {{"vtb_ribbon", 1},{"vtb_ribbon_val",4}})
	create_text("vtb-mdo-T",		{ "T\n%1.2f", "T\n****", "T\n%1.2f\n%1.2f"}, 	3, "CenterTop", { 55, -48}, nil, {{"vtb_ribbon", 1},{"vtb_ribbon_val",5}})
	pop_color()
end

function create_message()
	push_color("vtb_cav")
	create_text("vtb-message", "",	3, "CenterBottom", {0,  -17}, nil, {{"vtb_msg"}})
	create_fromsvg("vtb-msg-strike", "vtb-msg-strike",{0,1.5}, "vtb-message", {{"vtb_msg_strike"}})
	create_fromsvg("vtb-tnv", "vtb-tnv", {0, -2}, "vtb-message", {{"vtb_msg_tnv"}})	
	pop_color()
end



function create_radar_video(parent, range_scale)
	create_video("radar_video", -62.4, 62.4, 0, range_scale, parent, "vtb_vid_image", {{"vth_video"}})
end
