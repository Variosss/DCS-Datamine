dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/FCR/MFD_FCR_Defs.lua")

local trackAspectAngPtrLen  = 10
local trackSearchTargetSize = 10
local trackTankTargetSize = 15

TARGET_TYPE = 
{
	SEARCH = 0,
    TANK = 1,
    SYSTEM = 2,
    BUG = 3,
}

local FCR_TWS_TrackPlaceholder = addPlaceholder("FCR_tracks", nil, nil, {{"MFD_FCR_TWS_TrackPos", tactical_display_sz_half}})
local FCR_TWS_Track = addPlaceholder("FCR_tracks_Root", nil, FCR_TWS_TrackPlaceholder.name, {{"MFD_FCR_TWS_TrackRotate"}})
addStrokeText("FCR_Track_Altitude", "22", STROKE_FNT_DFLT_10_14, "CenterTop", {0, -19}, FCR_TWS_TrackPlaceholder.name, {{"MFD_FCR_TWS_Altitude"}, {"MFD_FCR_TWS_Track_Color"}})

-- SEARCH TARGETS
local FCR_Track_Search_Targets_Placeholder = addPlaceholder("FCR_Track_Search_Targets_Placeholder", nil, FCR_TWS_Track.name, {{"MFD_FCR_TWS_TrackType", TARGET_TYPE.SEARCH}})
for i = 0, trackSearchTargetSize, 0.5 do
    addStrokeLine(FCR_Track_Search_Targets_Placeholder.name.."_Line_"..i, trackSearchTargetSize, {-trackSearchTargetSize / 2, trackSearchTargetSize / 2 - i}, -90, FCR_Track_Search_Targets_Placeholder.name, {{"MFD_FCR_TWS_Track_Color"}})
end
addStrokeLine("FCR_Track_Search_Target_Pointer", 10, {0, 6}, 0, FCR_Track_Search_Targets_Placeholder.name, {{"MFD_FCR_TWS_Track_Color"}})

-- TANK TARGETS
local FCR_Track_Tank_Targets_Placeholder = addPlaceholder("FCR_Track_Tank_Targets_Placeholder", nil, FCR_TWS_Track.name, {{"MFD_FCR_TWS_TrackType", TARGET_TYPE.TANK}})
for i = 0, trackTankTargetSize, 0.5 do
    addStrokeLine(FCR_Track_Tank_Targets_Placeholder.name.."_Line_"..i, trackTankTargetSize, {-trackTankTargetSize / 2, trackTankTargetSize / 2 - i}, -90, FCR_Track_Tank_Targets_Placeholder.name, {{"MFD_FCR_TWS_Track_Color"}})
end
addStrokeLine("FCR_Track_Tank_Target_Pointer", 10, {0, 6}, 0, FCR_Track_Tank_Targets_Placeholder.name, {{"MFD_FCR_TWS_Track_Color"}})

-- SYSTEM TARGETS
local FCR_Track_System_Targets_Placeholder = addPlaceholder("FCR_Track_System_Targets_Placeholder", nil, FCR_TWS_Track.name, {{"MFD_FCR_TWS_TrackType", TARGET_TYPE.SYSTEM}})
addStrokeSymbol("FCR_Track_System_Targets", {"stroke_symbols_MFD", "fcr-target-big"}, "FromSet", {0, 0}, FCR_Track_System_Targets_Placeholder.name, {{"MFD_FCR_TWS_Track_Color"}})
addStrokeLine("FCR_Track_System_Target_Pointer", 10, {0, 13}, 0, FCR_Track_System_Targets_Placeholder.name, {{"MFD_FCR_TWS_Track_Color"}})

local FCR_Track_System_Target_TailPlaceholder = addPlaceholder("FCR_Track_System_Target_TailPlaceholder", nil, FCR_Track_System_Targets_Placeholder.name, {{"MFD_FCR_TWS_Track_Tail_State"}})
for i = 0, 12 do
    addStrokeLine("FCR_Track_System_Target_Tail_line"..i, 6, {-6 + i, -9},  180, FCR_Track_System_Target_TailPlaceholder.name, {{"MFD_FCR_TWS_Track_Color"}})
end

local FCR_Track_System_Target_XPlaceholder	= addPlaceholder("FCR_Track_System_Target_XPlaceholder", nil, FCR_Track_System_Targets_Placeholder.name, {{"MFD_FCR_TWS_Track_X_State"}})
addStrokeLine("FCR_Track_System_Target_X_line1", 34, { 12,  -12},   45, FCR_Track_System_Target_XPlaceholder.name, {{"MFD_SetColor_Red"}})
addStrokeLine("FCR_Track_System_Target_X_line2", 34, {-12,  -12}, -45, 	FCR_Track_System_Target_XPlaceholder.name, {{"MFD_SetColor_Red"}})

local FCR_TWS_TrackJammingPH = addPlaceholder("FCR_TWS_TrackJammingPH", nil, FCR_TWS_TrackPlaceholder.name, {{"MFD_FCR_TWS_TrackJamming"}})
addStrokeLine("FCR_jammingLine1", 15, {0,  5},  120, FCR_TWS_TrackJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("FCR_jammingLine2", 15, {0,  5}, -120, FCR_TWS_TrackJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("FCR_jammingLine3", 15, {0, -5},  120, FCR_TWS_TrackJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("FCR_jammingLine4", 15, {0, -5}, -120, FCR_TWS_TrackJammingPH.name, {{"MFD_SetColor_Yellow"}})