dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/FCR/MFD_FCR_Defs.lua")

local count = -1
local function counter()
	count = count + 1
	return count
end

local TRACK_SHAPE_TYPE =
{
	WIRE_CIRCLE			= counter(),
	WIRE_BIG_CIRCLE		= counter(),
	WIRE_RECTANGLE		= counter(),
	WIRE_TRIANGLE		= counter(),
	SOLID_CIRCLE		= counter(),
	SOLID_BIG_CIRCLE	= counter(),
	SOLID_RECTANGLE		= counter(),
	SOLID_TRIANGLE		= counter(),
}

local COLOR_TYPE =
{
	MAIN		= 0,
	WINGMAN_ID	= 1,
	DONOR_MARK	= 2,
}



-- main placeholder
local FCR_SYS_AirTrack_PH = addPlaceholder("FCR_SYS_air_tracks", nil, nil, {{"MFD_FCR_SYS_AirTrack_Pos", tactical_display_sz_half}})

-- rotated elements
local FCR_SYS_AirTrack_Rotate_PH = addPlaceholder("FCR_SYS_AirTrack_Rotate_PH", nil, FCR_SYS_AirTrack_PH.name, {{"MFD_FCR_SYS_AirTrack_Rotate"}})

addStrokeLine("FCR_SYS_AirTrack_CourseNotch", 14, {0, 7}, nil, FCR_SYS_AirTrack_Rotate_PH.name, {{"MFD_FCR_SYS_AirTrack_CourseNotch"},{"MFD_FCR_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, false, nil, nil, material)

-- triangle
-- wire
addStrokeSymbol("FCR_SYS_AirTrack_WireTriangle", {"stroke_symbols_MFD", "air-track-triangle-big"}, "FromSet", {0, 0}, FCR_SYS_AirTrack_Rotate_PH.name, {{"MFD_FCR_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.WIRE_TRIANGLE}, {"MFD_FCR_SYS_AirTrack_Color", COLOR_TYPE.MAIN}})
-- solid
local FCR_SYS_AirTrack_SolidTriangle_PH = addPlaceholder("FCR_SYS_AirTrack_SolidTriangle_PH", nil, FCR_SYS_AirTrack_Rotate_PH.name, {{"MFD_FCR_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.SOLID_TRIANGLE}})
for i = 0, 1, 1.0/7.0 do
	addStrokeSymbol("FCR_SYS_AirTrack_SolidTriangle_"..i, {"stroke_symbols_MFD", "air-track-triangle-big"}, "FromSet", {0, 0}, FCR_SYS_AirTrack_SolidTriangle_PH.name, {{"MFD_FCR_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, i)
end

-- Rectangle
-- wire
addStrokeSymbol("FCR_SYS_AirTrack_WireRectangle", {"stroke_symbols_MFD", "air-track-rectangle-big"}, "FromSet", {0, 0}, FCR_SYS_AirTrack_Rotate_PH.name, {{"MFD_FCR_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.WIRE_RECTANGLE}, {"MFD_FCR_SYS_AirTrack_Color", COLOR_TYPE.MAIN}})
-- solid
local FCR_SYS_AirTrack_SolidRectangle_PH = addPlaceholder("FCR_SYS_AirTrack_SolidRectangle_PH", nil, FCR_SYS_AirTrack_Rotate_PH.name, {{"MFD_FCR_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.SOLID_RECTANGLE}})
for i = 0, 1, 1.0/7.0 do
	addStrokeSymbol("FCR_SYS_AirTrack_SolidRectangle_"..i, {"stroke_symbols_MFD", "air-track-rectangle-big"}, "FromSet", {0, 0}, FCR_SYS_AirTrack_SolidRectangle_PH.name, {{"MFD_FCR_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, i)
end

-- Circle
-- wire
addStrokeSymbol("FCR_SYS_AirTrack_WireCircle", {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, FCR_SYS_AirTrack_Rotate_PH.name, {{"MFD_FCR_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.WIRE_CIRCLE}, {"MFD_FCR_SYS_AirTrack_Color", COLOR_TYPE.MAIN}})
-- solid
local FCR_SYS_AirTrack_SolidCircle_PH = addPlaceholder("FCR_SYS_AirTrack_SolidCircle_PH", nil, FCR_SYS_AirTrack_Rotate_PH.name, {{"MFD_FCR_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.SOLID_CIRCLE}})
for i = 0, 1, 1.0/7.0 do
	addStrokeSymbol("FCR_SYS_AirTrack_SolidCircle_"..i, {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, FCR_SYS_AirTrack_SolidCircle_PH.name, {{"MFD_FCR_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, i)
end

-- Big Circle (wingman PPLI)
-- wire
addStrokeSymbol("FCR_SYS_AirTrack_WireBigCircle", {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, FCR_SYS_AirTrack_Rotate_PH.name, {{"MFD_FCR_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.WIRE_BIG_CIRCLE}, {"MFD_FCR_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, 1.33)
-- solid
local FCR_SYS_AirTrack_SolidBigCircle_PH = addPlaceholder("FCR_SYS_AirTrack_SolidBigCircle_PH", nil, FCR_SYS_AirTrack_Rotate_PH.name, {{"MFD_FCR_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.SOLID_BIG_CIRCLE}})
for i = 0, 1.33, 1.0/7.0 do
	addStrokeSymbol("FCR_SYS_AirTrack_SolidBigCircle_"..i, {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, FCR_SYS_AirTrack_SolidBigCircle_PH.name, {{"MFD_FCR_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, i)
end

-- non-rotated elements
addStrokeText("FCR_SYS_AirTrack_Altitude", "XX", STROKE_FNT_DFLT_10_14, "CenterTop", {0, -21}, FCR_SYS_AirTrack_PH.name, {{"MFD_FCR_SYS_AirTrack_Altitude"}, {"MFD_FCR_SYS_AirTrack_Color", COLOR_TYPE.MAIN}})
addStrokeText("FCR_SYS_AirTrack_DonorId", "XX", STROKE_FNT_DFLT_10_14, "CenterBottom", {0, 21}, FCR_SYS_AirTrack_PH.name, {{"MFD_FCR_SYS_AirTrack_DonorId"}, {"MFD_FCR_SYS_AirTrack_Color", COLOR_TYPE.MAIN}})
addStrokeText("FCR_SYS_AirTrack_WingmanId", "X", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, 0}, FCR_SYS_AirTrack_PH.name, {{"MFD_FCR_SYS_AirTrack_WingmanId"}, {"MFD_FCR_SYS_AirTrack_Color", COLOR_TYPE.WINGMAN_ID}})

addStrokeSymbol("FCR_SYS_AirTrack_BuggedTarget", {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, FCR_SYS_AirTrack_PH.name, {{"MFD_FCR_SYS_AirTrack_BuggedTarget"}, {"MFD_FCR_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, 1.5)

-- donor mark
local FCR_SYS_AirTrack_DonorMark_PH = addPlaceholder("FCR_SYS_AirTrack_DonorMark_PH", nil, FCR_SYS_AirTrack_PH.name, {{"MFD_FCR_SYS_AirTrack_DonorMark"}})
for i = 0.0, 0.3, 0.15 do
	addStrokeSymbol("FCR_SYS_AirTrack_DonorMarkCircle_"..i, {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, FCR_SYS_AirTrack_DonorMark_PH.name, {{"MFD_FCR_SYS_AirTrack_Color", COLOR_TYPE.DONOR_MARK}}, i)
end

local FCR_SYS_AirTrackJammingPH = addPlaceholder("FCR_SYS_AirTrackJammingPH", nil, FCR_SYS_AirTrack_PH.name, {{"MFD_FCR_SYS_AirTrackJamming"}})
addStrokeLine("FCR_jammingLine1", 15, {0,  5},  120, FCR_SYS_AirTrackJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("FCR_jammingLine2", 15, {0,  5}, -120, FCR_SYS_AirTrackJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("FCR_jammingLine3", 15, {0, -5},  120, FCR_SYS_AirTrackJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("FCR_jammingLine4", 15, {0, -5}, -120, FCR_SYS_AirTrackJammingPH.name, {{"MFD_SetColor_Yellow"}})

addStrokeSymbol("FCR_SYS_AirTrack_PDLT", {"stroke_symbols_MFD", "target-pdlt"}, "FromSet", {0, 0}, FCR_SYS_AirTrack_PH.name, {{"MFD_FCR_SYS_AirTrack_Color", COLOR_TYPE.MAIN}, {"MFD_FCR_SYS_AirTrack_PDLT_State"}})