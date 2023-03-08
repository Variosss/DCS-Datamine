dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_strokesDefs.lua")

local RawHitWidth = 18
local trackedTgt_MachAlt_ShiftX		= 27

local AA_TrackPlaceholder = addPlaceholder("AZ_EL_tracks", nil, nil, {{"MPD_RDR_AZ_EL_TWS_Position", tactical_display_sz_half}})

local TRACK_FILE_TYPE = 
{
    SIMPLE = 0,
    AOT = 1,
    LS = 2,
    DT2 = 3,
    RANKED = 4
}

local RDR_track_HAFU = addPlaceholder("RDR_track_HAFU", nil, AA_TrackPlaceholder.name, {{"MPD_RDR_AZ_EL_TWS_Type", TRACK_FILE_TYPE.RANKED}})

addStrokeSymbol(RDR_track_HAFU.name.."_OnBoard_Friendly",		{"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"},			"FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_AZ_EL_TWS_HAFU", HAFU_TYPE.FRIENDLY},	{"MPD_RDR_AZ_EL_TWS_Color"}})
addStrokeSymbol(RDR_track_HAFU.name.."_OnBoard_Hostile",		{"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"},			"FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_AZ_EL_TWS_HAFU", HAFU_TYPE.HOSTILE},	{"MPD_RDR_AZ_EL_TWS_Color"}})
addStrokeSymbol(RDR_track_HAFU.name.."_OnBoard_Unknown",		{"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"},			"FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_AZ_EL_TWS_HAFU", HAFU_TYPE.UNKNOWN},	{"MPD_RDR_AZ_EL_TWS_Color"}})
addStrokeSymbol(RDR_track_HAFU.name.."_OnBoard_Ambiguous_sqr",	{"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"},			"FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_AZ_EL_TWS_HAFU", HAFU_TYPE.AMBIGUOUS},	{"MPD_RDR_AZ_EL_TWS_Color"}})
addStrokeSymbol(RDR_track_HAFU.name.."_OnBoard_Ambiguous_top",	{"stroke_symbols_MDI_AMPCD", "SA-FF-Sensor-Ambiguous"},	"FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_AZ_EL_TWS_HAFU", HAFU_TYPE.AMBIGUOUS},	{"MPD_RDR_AZ_EL_TWS_Color"}})

addStrokeText("TWS_track_TUC_Mach", nil, STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, RDR_track_HAFU.name, {{"MPD_AZ_EL_RDR_TWS_TUC_Mach"}, {"MPD_RDR_AZ_EL_TWS_Color"}})
addStrokeText("TWS_track_TUC_Altitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, RDR_track_HAFU.name, {{"MPD_AZ_EL_RDR_TWS_TUC_Altitude"}, {"MPD_RDR_AZ_EL_TWS_Color"}})
addStrokeText(RDR_track_HAFU.name.."_Jamming", "J", STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, RDR_track_HAFU.name, {{"MPD_AZ_EL_RDR_TWS_Jamming"}, {"MPD_RDR_AZ_EL_TWS_Color"}})
addStrokeText(RDR_track_HAFU.name.."_FLIRTrack", "F", STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, RDR_track_HAFU.name, {{"MPD_AZ_EL_RDR_TWS_FLIRTrack"}, {"MPD_RDR_AZ_EL_TWS_Color"}})

addStrokeSymbol(RDR_track_HAFU.name.."_DT2", {"stroke_symbols_MDI_AMPCD", "SA-DT2"}, "FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_AZ_EL_TWS_FileType", TRACK_FILE_TYPE.DT2}, {"MPD_RDR_AZ_EL_TWS_Color"}})
addStrokeText(RDR_track_HAFU.name.."_Ranked", nil, STROKE_FNT_DFLT_100, "CenterCenter", nil, RDR_track_HAFU.name, {{"MPD_RDR_AZ_EL_TWS_FileType", TRACK_FILE_TYPE.RANKED}, {"MPD_RDR_AZ_EL_TWS_Color"}})
local L_AND_S_Root = addStrokeSymbol(RDR_track_HAFU.name.."_L_And_S", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_AZ_EL_TWS_FileType", TRACK_FILE_TYPE.LS}, {"MPD_RDR_AZ_EL_TWS_Color"}})
addStrokeSymbol(RDR_track_HAFU.name.."_L_And_S_Filler_1", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, L_AND_S_Root.name, {{"MPD_RDR_AZ_EL_TWS_Color"}}, 0.8)
addStrokeSymbol(RDR_track_HAFU.name.."_L_And_S_Filler_2", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, L_AND_S_Root.name, {{"MPD_RDR_AZ_EL_TWS_Color"}}, 0.6)
addStrokeSymbol(RDR_track_HAFU.name.."_L_And_S_Filler_3", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, L_AND_S_Root.name, {{"MPD_RDR_AZ_EL_TWS_Color"}}, 0.4)
addStrokeCircle(RDR_track_HAFU.name.."_L_And_S_Filler_4", 1, nil, L_AND_S_Root.name, {{"MPD_RDR_AZ_EL_TWS_Color"}})

local symbol
symbol = addStrokeSymbol(RDR_track_HAFU.name.."_OffBoard_Friendly", {"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"}, "FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_AZ_EL_TWS_Offboard", HAFU_TYPE.FRIENDLY}, {"MPD_RDR_AZ_EL_TWS_Color"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol(RDR_track_HAFU.name.."_OffBoard_Hostile", {"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"}, "FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_AZ_EL_TWS_Offboard", HAFU_TYPE.HOSTILE}, {"MPD_RDR_AZ_EL_TWS_Color"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol(RDR_track_HAFU.name.."_OffBoard_Unknown", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_AZ_EL_TWS_Offboard", HAFU_TYPE.UNKNOWN}, {"MPD_RDR_AZ_EL_TWS_Color"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol(RDR_track_HAFU.name.."_OffBoard_Ambiguous", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_AZ_EL_TWS_Offboard", HAFU_TYPE.AMBIGUOUS}, {"MPD_RDR_AZ_EL_TWS_Color"}})
symbol.init_rot = {180}


----- FF
local RDR_FF_HAFU = addPlaceholder("RDR_FF_HAFU", nil, AA_TrackPlaceholder.name, {{"MPD_RDR_AZ_EL_FF_SHOW"}})
local isOutlined = 0

addStrokeCircle(RDR_FF_HAFU.name.."_FF_Circle_Center", 1, nil, RDR_FF_HAFU.name, {{"MPD_AZ_EL_SA_FF_CenterDot"}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})

addStrokeText("TWS_FF_TUC_Mach", nil, STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, RDR_FF_HAFU.name, {{"MPD_AZ_EL_RDR_TWS_TUC_Mach"}, {"MPD_RDR_AZ_EL_TWS_Color"}})
addStrokeText("TWS_FF_TUC_Altitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, RDR_FF_HAFU.name, {{"MPD_AZ_EL_RDR_TWS_TUC_Altitude"}, {"MPD_RDR_AZ_EL_TWS_Color"}})

addStrokeSymbol(RDR_FF_HAFU.name.."_OnBoard_Friendly", {"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"}, "FromSet", nil, RDR_FF_HAFU.name, {{"MPD_AZ_EL_SA_FF_OnboardPilotID", HAFU_TYPE.FRIENDLY}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})
addStrokeSymbol(RDR_FF_HAFU.name.."_OnBoard_Hostile", {"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"}, "FromSet", nil, RDR_FF_HAFU.name, {{"MPD_AZ_EL_SA_FF_OnboardPilotID", HAFU_TYPE.HOSTILE}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})
addStrokeSymbol(RDR_FF_HAFU.name.."_OnBoard_Unknown", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, RDR_FF_HAFU.name, {{"MPD_AZ_EL_SA_FF_OnboardPilotID", HAFU_TYPE.UNKNOWN}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})
local OnBoard_Ambiguous_Root = addStrokeSymbol(RDR_FF_HAFU.name.."_OnBoard_Ambiguous", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, RDR_FF_HAFU.name, {{"MPD_AZ_EL_SA_FF_OnboardPilotID", HAFU_TYPE.AMBIGUOUS}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})
addStrokeSymbol(RDR_FF_HAFU.name.."_OnBoard_Sensor_Ambiguous", {"stroke_symbols_MDI_AMPCD", "SA-FF-Sensor-Ambiguous"}, "FromSet", nil, OnBoard_Ambiguous_Root.name, {{"MPD_AZ_EL_SA_FF_OnboardPilotID", HAFU_TYPE.AMBIGUOUS}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})

local symbol
symbol = addStrokeSymbol(RDR_FF_HAFU.name.."_OffBoard_Friendly", {"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"}, "FromSet", nil, RDR_FF_HAFU.name, {{"MPD_AZ_EL_SA_FF_OffboardPilotID", HAFU_TYPE.FRIENDLY}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})
symbol.init_rot = {180}
symbol = addStrokeSymbol(RDR_FF_HAFU.name.."_OffBoard_Hostile", {"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"}, "FromSet", nil, RDR_FF_HAFU.name, {{"MPD_AZ_EL_SA_FF_OffboardPilotID", HAFU_TYPE.HOSTILE}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})
symbol.init_rot = {180}
symbol = addStrokeSymbol(RDR_FF_HAFU.name.."_OffBoard_Unknown", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, RDR_FF_HAFU.name, {{"MPD_AZ_EL_SA_FF_OffboardPilotID", HAFU_TYPE.UNKNOWN}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})
symbol.init_rot = {180}
symbol = addStrokeSymbol(RDR_FF_HAFU.name.."_OffBoard_Ambiguous", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, RDR_FF_HAFU.name, {{"MPD_AZ_EL_SA_FF_OffboardPilotID", HAFU_TYPE.AMBIGUOUS}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})
symbol.init_rot = {180}

addStrokeSymbol(RDR_FF_HAFU.name.."_Angle_Only", {"stroke_symbols_MDI_AMPCD", "SA-Angle-Only"}, "FromSet", nil, RDR_FF_HAFU.name, {{"MPD_AZ_EL_SA_FF_TrackFileType", TRACK_FILE_TYPE.AOT}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})
addStrokeSymbol(RDR_FF_HAFU.name.."_DT2", {"stroke_symbols_MDI_AMPCD", "SA-DT2"}, "FromSet", nil, RDR_FF_HAFU.name, {{"MPD_AZ_EL_SA_FF_TrackFileType", TRACK_FILE_TYPE.DT2}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})
addStrokeText(RDR_FF_HAFU.name.."_Ranked", nil, STROKE_FNT_DFLT_100, "CenterCenter", nil, RDR_FF_HAFU.name, {{"MPD_AZ_EL_SA_FF_TrackFileType", TRACK_FILE_TYPE.RANKED}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})
local L_AND_S_Root = addStrokeSymbol(RDR_FF_HAFU.name.."_L_And_S", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, RDR_FF_HAFU.name, {{"MPD_AZ_EL_SA_FF_TrackFileType", TRACK_FILE_TYPE.LS}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})
addStrokeSymbol(RDR_FF_HAFU.name.."_L_And_S_Filler_1", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, L_AND_S_Root.name, {{"MPD_AZ_EL_SA_FF_Color", isOutlined}}, 0.8)
addStrokeSymbol(RDR_FF_HAFU.name.."_L_And_S_Filler_2", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, L_AND_S_Root.name, {{"MPD_AZ_EL_SA_FF_Color", isOutlined}}, 0.6)
addStrokeSymbol(RDR_FF_HAFU.name.."_L_And_S_Filler_3", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, L_AND_S_Root.name, {{"MPD_AZ_EL_SA_FF_Color", isOutlined}}, 0.4)
addStrokeCircle(RDR_FF_HAFU.name.."_L_And_S_Filler_4", 1, nil, L_AND_S_Root.name, {{"MPD_AZ_EL_SA_FF_Color"}})

addStrokeSymbol(RDR_FF_HAFU.name.."_FF_Surface", {"stroke_symbols_MDI_AMPCD", "SA-Surface-Symbol"}, "FromSet", nil, RDR_FF_HAFU.name, {{"MPD_AZ_EL_SA_Surface"}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})
addStrokeSymbol(RDR_FF_HAFU.name.."_FF_Jammer", {"stroke_symbols_MDI_AMPCD", "SA-Jammer"}, "FromSet", {-30, 0}, RDR_FF_HAFU.name, {{"MPD_AZ_EL_SA_FF_Jammer"}, {"MPD_AZ_EL_SA_FF_Color", isOutlined}})


----- SURV
local RDR_SURV_HAFU = addPlaceholder("RDR_SURV_HAFU", nil, AA_TrackPlaceholder.name, {{"MPD_RDR_AZ_EL_SURV_SHOW"}})

addStrokeText("TWS_SURV_TUC_Mach", nil, STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, RDR_SURV_HAFU.name, {{"MPD_AZ_EL_RDR_TWS_TUC_Mach"}, {"MPD_RDR_AZ_EL_TWS_Color"}})
addStrokeText("TWS_SURV_TUC_Altitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, RDR_SURV_HAFU.name, {{"MPD_AZ_EL_RDR_TWS_TUC_Altitude"}, {"MPD_RDR_AZ_EL_TWS_Color"}})

addStrokeCircle(RDR_SURV_HAFU.name.."_Surveillance_Friendly", 15, nil, RDR_SURV_HAFU.name, {{"MPD_AZ_EL_SA_Surveillance_HAFU", HAFU_TYPE.FRIENDLY}, {"MPD_AZ_EL_SA_Surveillance_Color", isOutlined}})
addStrokeBox(RDR_SURV_HAFU.name.."_Surveillance_Unknown", 20, 40, "CenterCenter", nil, RDR_SURV_HAFU.name, {{"MPD_AZ_EL_SA_Surveillance_HAFU", HAFU_TYPE.UNKNOWN}, {"MPD_AZ_EL_SA_Surveillance_Color", isOutlined}})
local symbol = addStrokeBox(RDR_SURV_HAFU.name.."_Surveillance_Hostile", 20, 20, "CenterCenter", nil, RDR_SURV_HAFU.name, {{"MPD_AZ_EL_SA_Surveillance_HAFU", HAFU_TYPE.HOSTILE}, {"MPD_AZ_EL_SA_Surveillance_Color", isOutlined}})
symbol.init_rot = {45}
addStrokeSymbol(RDR_SURV_HAFU.name.."_Surveillance_Surface", {"stroke_symbols_MDI_AMPCD", "SA-Surface-Symbol"}, "FromSet", nil, RDR_SURV_HAFU.name, {{"MPD_AZ_EL_SA_Surface"}, {"MPD_AZ_EL_SA_Surveillance_Color", isOutlined}}, 1.8)


----- PPLI
function PPLI_Symbol(parent, course_controller, isOutlined)
	TXDSG_LINE_TYPE =
	{
		SOLID	= 1,
		DASHED	= 2,
	}

	local Radius = 20
	addStrokeCircle(parent.."_PPLI_Circle", Radius, nil, parent, {{"MPD_RDR_AZ_EL_PPLI_Color", isOutlined}})
	addStrokeSymbol(parent.."_DonorDot", {"stroke_symbols_MDI_AMPCD", "SA-PPLI-DOT"}, "FromSet", nil, parent, {{"MPD_RDR_AZ_EL_PPLI_DonorDot", -Radius}, {"MPD_RDR_AZ_EL_PPLI_Color", isOutlined}})
	addStrokeSymbol(parent.."_C2Dot", {"stroke_symbols_MDI_AMPCD", "SA-PPLI-DOT"}, "FromSet", nil, parent, {{"MPD_RDR_AZ_EL_PPLI_C2Dot", -Radius}, {"MPD_RDR_AZ_EL_PPLI_Color", isOutlined}})
	addStrokeText(parent.."_PPLI_ID", nil, STROKE_FNT_DFLT_120, "CenterCenter", nil, parent, {{"MPD_RDR_AZ_EL_PPLI_ID"}, {"MPD_RDR_AZ_EL_PPLI_Color", isOutlined}})
	
	local L_AND_S_Root = addStrokeSymbol(parent.."_L_And_S", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, parent, {{"MPD_RDR_AZ_EL_PPLI_LandS"}, {"MPD_RDR_AZ_EL_PPLI_Color", isOutlined}})
	addStrokeSymbol(parent.."_L_And_S_Filler_1", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, L_AND_S_Root.name, {{"MPD_RDR_AZ_EL_PPLI_Color", isOutlined}}, 0.8)
	addStrokeSymbol(parent.."_L_And_S_Filler_2", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, L_AND_S_Root.name, {{"MPD_RDR_AZ_EL_PPLI_Color", isOutlined}}, 0.6)
	addStrokeSymbol(parent.."_L_And_S_Filler_3", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, L_AND_S_Root.name, {{"MPD_RDR_AZ_EL_PPLI_Color", isOutlined}}, 0.4)
	addStrokeCircle(parent.."_L_And_S_Filler_4", 1, nil, L_AND_S_Root.name, {{"MPD_RDR_AZ_EL_PPLI_Color"}})
end
local RDR_PPLI_HAFU = addPlaceholder("RDR_PPLI_HAFU", nil, AA_TrackPlaceholder.name, {{"MPD_RDR_AZ_EL_PPLI_SHOW"}})
PPLI_Symbol(RDR_PPLI_HAFU.name, {"MPD_RDR_MSI_SetCourse", DYNAMIC_DATA.RDR_PPLI, 20}, 0)
addStrokeText("RDR_PPLI_Mach", nil, STROKE_FNT_DFLT_100, "RightCenter", {-35, 0}, RDR_PPLI_HAFU.name, {{"MPD_AZ_EL_RDR_TWS_TUC_Mach"}, {"MPD_RDR_AZ_EL_TWS_Color", 0}})
addStrokeText("RDR_PPLI_Altitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {35, 0}, RDR_PPLI_HAFU.name, {{"MPD_AZ_EL_RDR_TWS_TUC_Altitude"}, {"MPD_RDR_AZ_EL_TWS_Color", 0}})