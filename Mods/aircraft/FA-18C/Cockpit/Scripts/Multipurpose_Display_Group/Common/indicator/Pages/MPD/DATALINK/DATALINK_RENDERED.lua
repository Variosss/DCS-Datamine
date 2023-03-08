dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/DATALINK/DATALINK_tools.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/HARM/HARM_Utils.lua")

WallEyeEmbeddedIndication(true)

local openingSLAM_DESIGNMask = openMaskArea(0, "SLAM_DESIGNATE", {}, {}, {-120, 365}, nil, {{"MPD_SLAM_Designate"}})
set_box_w_h(openingSLAM_DESIGNMask, 340, 40)

local openingSLAM_CENTMask = openMaskArea(0, "SLAM_CENT_MASK", {}, {}, {-120, 325}, nil, {{"MPD_SLAM_Tgt_Dist", 0}})
set_box_w_h(openingSLAM_CENTMask, 340, 40)

AddRender()
SLAMEmbeddedIndication()

closeMaskArea(1, "SLAM_DESIGNATEClose", openingSLAM_DESIGNMask.vertices, openingSLAM_DESIGNMask.indices, openingSLAM_DESIGNMask.init_pos, nil)--, {{"maverick_frame_size", 900 * 1.3}})
closeMaskArea(1, "SLAM_CENTClose", openingSLAM_CENTMask.vertices, openingSLAM_CENTMask.indices, openingSLAM_CENTMask.init_pos, nil)--, {{"maverick_frame_size", 900 * 1.3}})


local function make_box(elem, half_size)
		elem.primitivetype   = "triangles"
		elem.vertices        = {{-half_size,half_size},{half_size,half_size},{half_size,-half_size},{-half_size,-half_size}}
		elem.indices         = {0,1,2,2,3,0}	
end

local width   = 0.003;
local offset  = 0.045;
local box_ind = {0,1,2,2,3,0}

local   base    		 	 = CreateElement "ceMeshPoly"
		make_box(base,1)
		base.material		 = "MAV_COLOR_"..string.format("%d",GetRenderTarget())
		base.screenspace 	 = 1
		base.level 			 = 4
		base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
		base.controllers 	 = {{"MPD_SMS_DATALINK_Video_Type",2}}
		base.isvisible 		 = false
		Add(base)
		
local 	cross_base  			 		 = CreateElement "ceSimple"
		cross_base.screenspace 	 		 = 1
		cross_base.parent_element 		 = base.name
		Add(cross_base)

local 	aimpointcross  			 		= CreateElement "ceSimple"
		aimpointcross.screenspace 	 	= 1
		aimpointcross.level 		 		= 4
		aimpointcross.h_clip_relation  	 = h_clip_relations.COMPARE
		aimpointcross.parent_element 	= cross_base.name
		aimpointcross.controllers 	 	= {{"MPD_SMS_SLAM_ER_Aimpoint_Ang"}, {"datalink_polarity_change_color",0,0,0}}
		Add(aimpointcross)
		
		local   gap_aimpointcross  		 		 = CreateElement "ceMeshPoly"
		make_box(gap_aimpointcross,0.03)
		gap_aimpointcross.init_rot 		 		 = {45.0, 0.0}
		gap_aimpointcross.screenspace 	 		 = 1
		gap_aimpointcross.material				 = base.material
		gap_aimpointcross.level 		 		 = 4
		gap_aimpointcross.h_clip_relation  	 	 = h_clip_relations.INCREASE_IF_LEVEL
		gap_aimpointcross.isvisible 		 	 = false
		gap_aimpointcross.parent_element 		 = aimpointcross.name
		Add(gap_aimpointcross)
		
		local   aimpointcross_1	    = CreateElement "ceMeshPoly"
		aimpointcross_1.primitivetype  = "triangles"
		aimpointcross_1.vertices       = {{-0.16,width},
									   { 0.16, width},
									   { 0.16,- width},
									   {-0.16,- width}}
		aimpointcross_1.indices        = {0,1,2,2,3,0}
		aimpointcross_1.init_rot 		 = {45.0, 0.0}
		aimpointcross_1.screenspace 	 = 1
		aimpointcross_1.level 		 = 4
		aimpointcross_1.h_clip_relation  = h_clip_relations.COMPARE
		aimpointcross_1.material		 = base.material
		aimpointcross_1.parent_element = aimpointcross.name
		aimpointcross_1.controllers	= {{"datalink_polarity_change_color",0,0,0}}
		Add(aimpointcross_1)

		local 	aimpointcross_2 		= Copy(aimpointcross_1)	
		aimpointcross_2.init_rot	 	= {-45.0, 0.0}
		Add(aimpointcross_2)


add_PB_label(1, {"WPN", nil, {{"MPD_SMS_DATALINK_1_5_PBLabels", 0}}})--, {{"MPD_SMS_DATALINK_WPN"}}})
add_PB_label(2, {"A ANT", nil, {{"MPD_SMS_DATALINK_1_5_PBLabels", 0}}, {{"MPD_SMS_DATALINK_A_ANT"}}})
add_PB_label(4, {"DLY", nil, {{"MPD_SMS_DATALINK_WALLEYE_FUZE", 0}}, {{"MPD_SMS_DATALINK_WALLEYE_FUZE", 1}}})
add_PB_label(5, {"INST", nil, {{"MPD_SMS_DATALINK_WALLEYE_FUZE", 0}}, {{"MPD_SMS_DATALINK_WALLEYE_FUZE", 2}}})

add_PB_label(1, {"PRI", nil, {{"MPD_SMS_DATALINK_1_5_PBLabels", 1}}})
add_PB_label(1, "", {"STA", nil, {{"MPD_SMS_DATALINK_1_5_PBLabels", 1}}})
add_PB_label(2, {"    ", nil, {{"MPD_SMS_DATALINK_1_5_PBLabels", 1, 7}}})
add_PB_label(3, {"    ", nil, {{"MPD_SMS_DATALINK_1_5_PBLabels", 1, 6}}})
add_PB_label(4, {"    ", nil, {{"MPD_SMS_DATALINK_1_5_PBLabels", 1, 2}}})
add_PB_label(5, {"    ", nil, {{"MPD_SMS_DATALINK_1_5_PBLabels", 1, 1}}})


add_PB_label(6, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 0, 0}}, {{"MPD_SMS_6_10PBLabels", 0, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 0}}})
add_PB_label(7, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 1, 0}}, {{"MPD_SMS_6_10PBLabels", 1, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 1}}})
add_PB_label(8, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 2, 0}}, {{"MPD_SMS_6_10PBLabels", 2, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 2}}})
add_PB_label(9, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 3, 0}}, {{"MPD_SMS_6_10PBLabels", 3, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 3}}})
add_PB_label(10, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 4, 0}}, {{"MPD_SMS_6_10PBLabels", 4, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 4}}})

add_PB_label(6, "", "", {"    ", nil, {{"MPD_SMS_DATALINK_WEDL", 0}}})
add_PB_label(7, "", "", {"    ", nil, {{"MPD_SMS_DATALINK_WEDL", 1}}})
add_PB_label(8, "", "", {"    ", nil, {{"MPD_SMS_DATALINK_WEDL", 2}}})
add_PB_label(9, "", "", {"    ", nil, {{"MPD_SMS_DATALINK_WEDL", 3}}})
add_PB_label(10, "", "", {"    ", nil, {{"MPD_SMS_DATALINK_WEDL", 4}}})


add_X_Over("BP_6_Break_X", 	154, 36, {-336, 488}, 	nil, {{"MPD_SMS_AG_X_Breaker", 0}})
add_X_Over("BP_7_Break_X", 	154, 36, {-167, 488}, 	nil, {{"MPD_SMS_AG_X_Breaker", 1}})
add_X_Over("BP_8_Break_X", 	154, 36, {2, 488}, 		nil, {{"MPD_SMS_AG_X_Breaker", 2}})
add_X_Over("BP_9_Break_X", 	154, 36, {171, 488},	nil, {{"MPD_SMS_AG_X_Breaker", 3}})
add_X_Over("BP_10_Break_X", 154, 36, {340, 488}, 	nil, {{"MPD_SMS_AG_X_Breaker", 4}})


add_PB_label(11, {"F/C", nil, {{"MPD_SMS_FC_Label", 0}}, {{"MPD_SMS_FC_Label", 1}}})

add_PB_label(13, {"STEP", nil, {{"MPD_SMS_DATALINK_STEP"}}})
add_PB_label(14, {"UFC", nil, {{"MPD_SMS_UFC_Label", 0}}, {{"MPD_SMS_UFC_Label", 1, 4}}})
add_PB_label(15, {"FOV", nil, {{"MPD_SMS_DATALINK_SLAM_FOV_Label"}}})
add_PB_label(18, {"MENU"})

add_PB_label(20, {"   ", nil, {{"MPD_SMS_IR_MAV_TRK", 0}}}, "", {"TRACK", nil, {{"MPD_SMS_IR_MAV_TRK", 1}}})

add_Harm_Ovrd_PB16()

addStrokeText("Channel", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, -190}, nil, {{"MPD_SMS_DATALINK_CH"}}, {"CH 00%d"})

local OffsetBetweenColumn = 130
local OffsetBetweenStr = 28

addStrokeText("Station", "STA", STROKE_FNT_DFLT_100, "LeftCenter", {-380, 385}, nil, {{"MPD_SMS_DATALINK_Station"}})
addStrokeText("CurrStation", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn / 2, 0.0}, "Station", {{"MPD_SMS_Curr_Station_Num"}})

local DATALINK_CAGE = {
"",
"CAGED",
"UNCAGED",
}

addStrokeText("CagedStatus", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 385}, nil, {{"MPD_SMS_DATALINK_Caged"}}, DATALINK_CAGE)
addStrokeText("InRng", "IN RNG", STROKE_FNT_DFLT_100, "RightCenter", {380, 357}, nil, {{"MPD_SMS_DATALINK_IN_RNG", 0}})
addStrokeText("TTMR", "TTMR", STROKE_FNT_DFLT_100, "RightCenter", {380, 357}, nil, {{"MPD_SMS_DATALINK_IN_RNG", 1}})
addStrokeText("TTMR_val", nil, STROKE_FNT_DFLT_100, "RightCenter", {-70, 0}, "TTMR", {{"MPD_SMS_DATALINK_IN_RNG", 2}})

addStrokeText("DATALINK_SLAM_TTS", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 332}, nil, {{"MPD_SMS_SLAM_TTS", 999}}, {"%.3d TTS"})

-- Designated waypoint marker
local TD_DiamondPlaceholder = addPlaceholder("TD_DiamondPlaceholder", {400, 450}, nil, {{"TDC_assignedDisplay"}})
addStrokeSymbol("TargetDesignateDiamond_Marker", {"stroke_symbols_HUD", "115-TD-Symbol"}, "FromSet", nil, TD_DiamondPlaceholder.name)
addDot("TD_Diamond_dot", 1.5, nil, TD_DiamondPlaceholder.name)

local DATALINK_SLAM_DIST = {
"%.1f CENT",
"%.1f F/C"
}
		
addStrokeText("SLAM_Designate", "DESIGNATE", STROKE_FNT_DFLT_150_X_WIDE, "LeftCenter", {-285.0, 365.0}, nil, {{"MPD_SLAM_Designate"}})
addStrokeText("SLAM_CENT", nil, STROKE_FNT_DFLT_150_X_WIDE, "RightCenter", {45.0, 325.0}, nil, {{"MPD_SLAM_Tgt_Dist", 1}}, DATALINK_SLAM_DIST)