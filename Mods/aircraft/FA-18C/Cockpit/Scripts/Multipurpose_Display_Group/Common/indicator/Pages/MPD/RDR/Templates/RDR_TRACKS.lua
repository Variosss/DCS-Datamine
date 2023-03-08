dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_strokesDefs.lua")

local trackedTgt_MachAlt_ShiftX		= 27
local RawHitWidth = 18
local AA_TrackPlaceholder = addPlaceholder("RDR_tracks", nil, nil, {{"MPD_RDR_TWS_Position", tactical_display_sz_half}})

local TRACK_FILE_TYPE = 
{
    SIMPLE = 0,
    AOT = 1,
    LS = 2,
    DT2 = 3,
    RANKED = 4
}

local RDR_track_HAFU = addPlaceholder("RDR_track_HAFU", nil, AA_TrackPlaceholder.name, {{"MPD_RDR_TWS_Type", TRACK_FILE_TYPE.RANKED}})

addStrokeLine(RDR_track_HAFU.name.."_Course_Line", 20, {0, 0}, 0, RDR_track_HAFU.name, {{"MPD_RDR_TWS_Course", 20}, {"MPD_RDR_TWS_Color"}})

addStrokeSymbol(RDR_track_HAFU.name.."_OnBoard_Friendly",		{"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"},			"FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_TWS_HAFU", HAFU_TYPE.FRIENDLY}, {"MPD_RDR_TWS_Color"}})
addStrokeSymbol(RDR_track_HAFU.name.."_OnBoard_Hostile",		{"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"},			"FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_TWS_HAFU", HAFU_TYPE.HOSTILE}, {"MPD_RDR_TWS_Color"}})
addStrokeSymbol(RDR_track_HAFU.name.."_OnBoard_Unknown",		{"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"},			"FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_TWS_HAFU", HAFU_TYPE.UNKNOWN}, {"MPD_RDR_TWS_Color"}})
addStrokeSymbol(RDR_track_HAFU.name.."_OnBoard_Ambiguous_sqr",	{"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"},			"FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_TWS_HAFU", HAFU_TYPE.AMBIGUOUS}, {"MPD_RDR_TWS_Color"}})
addStrokeSymbol(RDR_track_HAFU.name.."_OnBoard_Ambiguous_top",	{"stroke_symbols_MDI_AMPCD", "SA-FF-Sensor-Ambiguous"},	"FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_TWS_HAFU", HAFU_TYPE.AMBIGUOUS}, {"MPD_RDR_TWS_Color"}})

addStrokeText(RDR_track_HAFU.name.."_Jamming", "J", STROKE_FNT_DFLT_100, "RightCenter", {-27, 0}, RDR_track_HAFU.name, {{"MPD_RDR_TWS_Jamming"}, {"MPD_RDR_TWS_Color"}})
addStrokeText(RDR_track_HAFU.name.."_FLIRTrack", "F", STROKE_FNT_DFLT_100, "LeftCenter", {27, 0}, RDR_track_HAFU.name, {{"MPD_RDR_TWS_FLIRTrack"}, {"MPD_RDR_TWS_Color"}})

addStrokeSymbol(RDR_track_HAFU.name.."_DT2", {"stroke_symbols_MDI_AMPCD", "SA-DT2"}, "FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_TWS_FileType", TRACK_FILE_TYPE.DT2}, {"MPD_RDR_TWS_Color"}})
addStrokeText(RDR_track_HAFU.name.."_Ranked", nil, STROKE_FNT_DFLT_100, "CenterCenter", nil, RDR_track_HAFU.name, {{"MPD_RDR_TWS_FileType", TRACK_FILE_TYPE.RANKED}, {"MPD_RDR_TWS_Color"}})
local L_AND_S_Root = addStrokeSymbol(RDR_track_HAFU.name.."_L_And_S", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_TWS_FileType", TRACK_FILE_TYPE.LS}, {"MPD_RDR_TWS_Color"}})
addStrokeSymbol(RDR_track_HAFU.name.."_L_And_S_Filler_1", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, L_AND_S_Root.name, {{"MPD_RDR_TWS_Color"}}, 0.8)
addStrokeSymbol(RDR_track_HAFU.name.."_L_And_S_Filler_2", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, L_AND_S_Root.name, {{"MPD_RDR_TWS_Color"}}, 0.6)
addStrokeSymbol(RDR_track_HAFU.name.."_L_And_S_Filler_3", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, L_AND_S_Root.name, {{"MPD_RDR_TWS_Color"}}, 0.4)
addStrokeCircle(RDR_track_HAFU.name.."_L_And_S_Filler_4", 1, nil, L_AND_S_Root.name, {{"MPD_RDR_TWS_Color"}})

addStrokeText(RDR_track_HAFU.name.."_Altitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, RDR_track_HAFU.name, {{"MPD_RDR_AA_STT_1LOOK_RAID_TrackAltitude"}, {"MPD_RDR_TWS_Color"}})

local RDR_track_Raw_Hit = addPlaceholder("RDR_track_Raw_Hit", nil, AA_TrackPlaceholder.name, {{"MPD_RDR_TWS_Type", TRACK_FILE_TYPE.SIMPLE}})
for i = 1, 4 do
	addStrokeLine("Track_Raw_Hit_Line_"..i, RawHitWidth, {-RawHitWidth/2, 2 * (i - 2.5)}, -90, RDR_track_Raw_Hit.name, {{"MPD_RDR_RawRadarContactIntensity"}})
end

local symbol
symbol = addStrokeSymbol(RDR_track_HAFU.name.."_OffBoard_Friendly", {"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"}, "FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_TWS_Offboard", HAFU_TYPE.FRIENDLY}, {"MPD_RDR_TWS_Color"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol(RDR_track_HAFU.name.."_OffBoard_Hostile", {"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"}, "FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_TWS_Offboard", HAFU_TYPE.HOSTILE}, {"MPD_RDR_TWS_Color"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol(RDR_track_HAFU.name.."_OffBoard_Unknown", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_TWS_Offboard", HAFU_TYPE.UNKNOWN}, {"MPD_RDR_TWS_Color"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol(RDR_track_HAFU.name.."_OffBoard_Ambiguous", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, RDR_track_HAFU.name, {{"MPD_RDR_TWS_Offboard", HAFU_TYPE.AMBIGUOUS}, {"MPD_RDR_TWS_Color"}})
symbol.init_rot = {180}

local RDR_GROUP_PH = addPlaceholder("RDR_GROUP", nil, AA_TrackPlaceholder.name, {{"MPD_RDR_TWS_Type", TRACK_FILE_TYPE.RANKED, 1}})
addStrokeText(RDR_GROUP_PH.name.."_Many", "M", STROKE_FNT_DFLT_100, "RightCenter", {0, 0}, RDR_GROUP_PH.name)
addStrokeText("RDR_GROUP_contactAltitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, RDR_GROUP_PH.name, {{"MPD_RDR_AA_STT_1LOOK_RAID_TrackAltitude"}})