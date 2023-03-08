dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")

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
local HSD_SYS_AirTrack_PH = addPlaceholder("HSD_SYS_air_tracks", nil, nil, {{"MFD_HSD_SYS_AirTrack_Pos"}})

addVarLenStrokeLine("HSD_SYS_AirTrack_LineToTarget", 200, {0, 0}, nil, HSD_SYS_AirTrack_PH.name, {{"MFD_HSD_SYS_AirTrack_LineToTarget", 8},{"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, nil, true, 7, 7)

-- rotated elements
local HSD_SYS_AirTrack_Rotate_PH = addPlaceholder("HSD_SYS_AirTrack_Rotate_PH", nil, HSD_SYS_AirTrack_PH.name, {{"MFD_HSD_SYS_AirTrack_Rotate"}})

addStrokeLine("HSD_SYS_AirTrack_CourseNotch", 14, {0, 7}, nil, HSD_SYS_AirTrack_Rotate_PH.name, {{"MFD_HSD_SYS_AirTrack_CourseNotch"},{"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, false)

-- triangle
-- wire
addStrokeSymbol("HSD_SYS_AirTrack_WireTriangle", {"stroke_symbols_MFD", "air-track-triangle-big"}, "FromSet", {0, 0}, HSD_SYS_AirTrack_Rotate_PH.name, {{"MFD_HSD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.WIRE_TRIANGLE}, {"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}})
-- solid
local HSD_SYS_AirTrack_SolidTriangle_PH = addPlaceholder("HSD_SYS_AirTrack_SolidTriangle_PH", nil, HSD_SYS_AirTrack_Rotate_PH.name, {{"MFD_HSD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.SOLID_TRIANGLE}})
for i = 0, 1, 1.0/7.0 do
	addStrokeSymbol("HSD_SYS_AirTrack_SolidTriangle_"..i, {"stroke_symbols_MFD", "air-track-triangle-big"}, "FromSet", {0, 0}, HSD_SYS_AirTrack_SolidTriangle_PH.name, {{"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, i)
end

-- Rectangle
-- wire
addStrokeSymbol("HSD_SYS_AirTrack_WireRectangle", {"stroke_symbols_MFD", "air-track-rectangle-big"}, "FromSet", {0, 0}, HSD_SYS_AirTrack_Rotate_PH.name, {{"MFD_HSD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.WIRE_RECTANGLE}, {"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}})
-- solid
local HSD_SYS_AirTrack_SolidRectangle_PH = addPlaceholder("HSD_SYS_AirTrack_SolidRectangle_PH", nil, HSD_SYS_AirTrack_Rotate_PH.name, {{"MFD_HSD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.SOLID_RECTANGLE}})
for i = 0, 1, 1.0/7.0 do
	addStrokeSymbol("HSD_SYS_AirTrack_SolidRectangle_"..i, {"stroke_symbols_MFD", "air-track-rectangle-big"}, "FromSet", {0, 0}, HSD_SYS_AirTrack_SolidRectangle_PH.name, {{"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, i)
end

-- Circle
-- wire
addStrokeSymbol("HSD_SYS_AirTrack_WireCircle", {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, HSD_SYS_AirTrack_Rotate_PH.name, {{"MFD_HSD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.WIRE_CIRCLE}, {"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}})
-- solid
local HSD_SYS_AirTrack_SolidCircle_PH = addPlaceholder("HSD_SYS_AirTrack_SolidCircle_PH", nil, HSD_SYS_AirTrack_Rotate_PH.name, {{"MFD_HSD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.SOLID_CIRCLE}})
for i = 0, 1, 1.0/7.0 do
	addStrokeSymbol("HSD_SYS_AirTrack_SolidCircle_"..i, {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, HSD_SYS_AirTrack_SolidCircle_PH.name, {{"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, i)
end

-- Big Circle (wingman PPLI)
-- wire
addStrokeSymbol("HSD_SYS_AirTrack_WireBigCircle", {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, HSD_SYS_AirTrack_Rotate_PH.name, {{"MFD_HSD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.WIRE_BIG_CIRCLE}, {"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, 1.33)
-- solid
local HSD_SYS_AirTrack_SolidBigCircle_PH = addPlaceholder("HSD_SYS_AirTrack_SolidBigCircle_PH", nil, HSD_SYS_AirTrack_Rotate_PH.name, {{"MFD_HSD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.SOLID_BIG_CIRCLE}})
for i = 0, 1.33, 1.0/7.0 do
	addStrokeSymbol("HSD_SYS_AirTrack_SolidBigCircle_"..i, {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, HSD_SYS_AirTrack_SolidBigCircle_PH.name, {{"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, i)
end

-- non-rotated elements
-- ground target
addStrokeLine("HSD_SYS_GroundTarget_CourseNotch", 14, {5, -2}, nil, HSD_SYS_AirTrack_PH.name, {{"MFD_HSD_SYS_GroundTarget_CourseNotch"},{"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, false)
addStrokeText("HSD_SYS_GroundTarget_WingmanId", "X", STROKE_FNT_DFLT_6_9, "CenterCenter", {0, 13}, HSD_SYS_AirTrack_PH.name, {{"MFD_HSD_SYS_GroundTarget_WingmanId"}, {"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.WINGMAN_ID}})

addStrokeText("HSD_SYS_AirTrack_Altitude", "XX", STROKE_FNT_DFLT_10_14, "CenterTop", {0, -21}, HSD_SYS_AirTrack_PH.name, {{"MFD_HSD_SYS_AirTrack_Altitude"}, {"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}})
--addStrokeText("HSD_SYS_AirTrack_DonorId", "XX", STROKE_FNT_DFLT_6_9, "CenterBottom", {0, 17}, HSD_SYS_AirTrack_PH.name, {{"MFD_HSD_SYS_AirTrack_DonorId"}, {"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}})
addStrokeText("HSD_SYS_AirTrack_WingmanId", "X", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, 0}, HSD_SYS_AirTrack_PH.name, {{"MFD_HSD_SYS_AirTrack_WingmanId"}, {"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.WINGMAN_ID}})

addStrokeSymbol("HSD_SYS_AirTrack_BuggedTarget", {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, HSD_SYS_AirTrack_PH.name, {{"MFD_HSD_SYS_AirTrack_BuggedTarget"}, {"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, 1.5)

-- donor mark
local HSD_SYS_AirTrack_DonorMark_PH = addPlaceholder("HSD_SYS_AirTrack_DonorMark_PH", nil, HSD_SYS_AirTrack_PH.name, {{"MFD_HSD_SYS_AirTrack_DonorMark"}})
for i = 0.0, 0.3, 0.15 do
	addStrokeSymbol("HSD_SYS_AirTrack_DonorMarkCircle_"..i, {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, HSD_SYS_AirTrack_DonorMark_PH.name, {{"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.DONOR_MARK}}, i)
end

addStrokeSymbol("HSD_SYS_AirTrack_PDLT", {"stroke_symbols_MFD", "target-pdlt"}, "FromSet", {0, 0}, HSD_SYS_AirTrack_PH.name, {{"MFD_HSD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}, {"MFD_HSD_SYS_AirTrack_PDLT_State"}})

local FCR_HSD_ContactJammingPH = addPlaceholder("FCR_HSD_ContactJammingPH", nil, HSD_SYS_AirTrack_PH.name, {{"MFD_HSD_SYS_AirTrack_Jamming"}})
addStrokeLine("FCR_HSD_jammingLine1", 15, {0,  5},  120, FCR_HSD_ContactJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("FCR_HSD_jammingLine2", 15, {0,  5}, -120, FCR_HSD_ContactJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("FCR_HSD_jammingLine3", 15, {0, -5},  120, FCR_HSD_ContactJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("FCR_HSD_jammingLine4", 15, {0, -5}, -120, FCR_HSD_ContactJammingPH.name, {{"MFD_SetColor_Yellow"}})