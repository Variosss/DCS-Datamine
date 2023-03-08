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
	TDOA		= 3,
}



-- main placeholder
local HAD_SYS_AirTrack_PH = addPlaceholder("HAD_SYSTEM_TRACKS", nil, nil, {{"HAD_SYS_AirTrack_Pos"}})

addVarLenStrokeLine("HAD_SYS_AirTrack_LineToTarget", 200, {0, 0}, nil, HAD_SYS_AirTrack_PH.name, {{"HAD_SYS_AirTrack_LineToTarget", 8},{"HAD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, nil, true, 7, 7)
--TDOA
addVarLenStrokeLine("HAD_TDOA_Master_LineToTarget", 200, {0, 0}, nil, HAD_SYS_AirTrack_PH.name, {{"HAD_TDOA_Master_LineToTarget", 8},{"HAD_SYS_AirTrack_Color", COLOR_TYPE.TDOA}}, nil, true, 7, 7)
-- rotated elements
local HAD_SYS_AirTrack_Rotate_PH = addPlaceholder("HAD_SYS_AirTrack_Rotate_PH", nil, HAD_SYS_AirTrack_PH.name, {{"HAD_SYS_AirTrack_Rotate"}})

addStrokeLine("HAD_SYS_AirTrack_CourseNotch", 14, {0, 7}, nil, HAD_SYS_AirTrack_Rotate_PH.name, {{"HAD_SYS_AirTrack_CourseNotch"},{"HAD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, false)

-- triangle
-- wire
addStrokeSymbol("HAD_SYS_AirTrack_WireTriangle", {"stroke_symbols_MFD", "air-track-triangle-big"}, "FromSet", {0, 0}, HAD_SYS_AirTrack_Rotate_PH.name, {{"HAD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.WIRE_TRIANGLE}, {"HAD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}})
-- solid
local HAD_SYS_AirTrack_SolidTriangle_PH = addPlaceholder("HAD_SYS_AirTrack_SolidTriangle_PH", nil, HAD_SYS_AirTrack_Rotate_PH.name, {{"HAD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.SOLID_TRIANGLE}})
for i = 0, 1, 1.0/7.0 do
	addStrokeSymbol("HAD_SYS_AirTrack_SolidTriangle_"..i, {"stroke_symbols_MFD", "air-track-triangle-big"}, "FromSet", {0, 0}, HAD_SYS_AirTrack_SolidTriangle_PH.name, {{"HAD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, i)
end

-- Rectangle
-- wire
addStrokeSymbol("HAD_SYS_AirTrack_WireRectangle", {"stroke_symbols_MFD", "air-track-rectangle-big"}, "FromSet", {0, 0}, HAD_SYS_AirTrack_Rotate_PH.name, {{"HAD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.WIRE_RECTANGLE}, {"HAD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}})
-- solid
local HAD_SYS_AirTrack_SolidRectangle_PH = addPlaceholder("HAD_SYS_AirTrack_SolidRectangle_PH", nil, HAD_SYS_AirTrack_Rotate_PH.name, {{"HAD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.SOLID_RECTANGLE}})
for i = 0, 1, 1.0/7.0 do
	addStrokeSymbol("HAD_SYS_AirTrack_SolidRectangle_"..i, {"stroke_symbols_MFD", "air-track-rectangle-big"}, "FromSet", {0, 0}, HAD_SYS_AirTrack_SolidRectangle_PH.name, {{"HAD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, i)
end

-- Circle
-- wire
addStrokeSymbol("HAD_SYS_AirTrack_WireCircle", {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, HAD_SYS_AirTrack_Rotate_PH.name, {{"HAD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.WIRE_CIRCLE}, {"HAD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}})
-- solid
local HAD_SYS_AirTrack_SolidCircle_PH = addPlaceholder("HAD_SYS_AirTrack_SolidCircle_PH", nil, HAD_SYS_AirTrack_Rotate_PH.name, {{"HAD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.SOLID_CIRCLE}})
for i = 0, 1, 1.0/7.0 do
	addStrokeSymbol("HAD_SYS_AirTrack_SolidCircle_"..i, {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, HAD_SYS_AirTrack_SolidCircle_PH.name, {{"HAD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, i)
end

-- Big Circle (wingman PPLI)
-- wire
addStrokeSymbol("HAD_SYS_AirTrack_WireBigCircle", {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, HAD_SYS_AirTrack_Rotate_PH.name, {{"HAD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.WIRE_BIG_CIRCLE}, {"HAD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, 1.33)
-- solid
local HAD_SYS_AirTrack_SolidBigCircle_PH = addPlaceholder("HAD_SYS_AirTrack_SolidBigCircle_PH", nil, HAD_SYS_AirTrack_Rotate_PH.name, {{"HAD_SYS_AirTrack_Shape", TRACK_SHAPE_TYPE.SOLID_BIG_CIRCLE}})
for i = 0, 1.33, 1.0/7.0 do
	addStrokeSymbol("HAD_SYS_AirTrack_SolidBigCircle_"..i, {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, HAD_SYS_AirTrack_SolidBigCircle_PH.name, {{"HAD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, i)
end

-- non-rotated elements
addStrokeText("HAD_SYS_AirTrack_Altitude", "XX", STROKE_FNT_DFLT_10_14, "CenterTop", {0, -21}, HAD_SYS_AirTrack_PH.name, {{"HAD_SYS_AirTrack_Altitude"}, {"HAD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}})
--addStrokeText("HAD_SYS_AirTrack_DonorId", "XX", STROKE_FNT_DFLT_6_9, "CenterBottom", {0, 17}, HAD_SYS_AirTrack_PH.name, {{"HAD_SYS_AirTrack_DonorId"}, {"HAD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}})
addStrokeText("HAD_SYS_AirTrack_WingmanId", "X", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, 0}, HAD_SYS_AirTrack_PH.name, {{"HAD_SYS_AirTrack_WingmanId"}, {"HAD_SYS_AirTrack_Color", COLOR_TYPE.WINGMAN_ID}})

addStrokeSymbol("HAD_SYS_AirTrack_BuggedTarget", {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, HAD_SYS_AirTrack_PH.name, {{"HAD_SYS_AirTrack_BuggedTarget"}, {"HAD_SYS_AirTrack_Color", COLOR_TYPE.MAIN}}, 1.5)

-- donor mark
local HAD_SYS_AirTrack_DonorMark_PH = addPlaceholder("HAD_SYS_AirTrack_DonorMark_PH", nil, HAD_SYS_AirTrack_PH.name, {{"HAD_SYS_AirTrack_DonorMark"}})
for i = 0.0, 0.3, 0.15 do
	addStrokeSymbol("HAD_SYS_AirTrack_DonorMarkCircle_"..i, {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, HAD_SYS_AirTrack_DonorMark_PH.name, {{"HAD_SYS_AirTrack_Color", COLOR_TYPE.DONOR_MARK}}, i)
end