dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")


-- Menu
add_PB_label(1, {"S"}, {" "}, {"W"})
add_PB_label(3, {"W"})
add_PB_label(5, {"N"}, {" "}, {"W"})
add_PB_label(8, {"N", nil, {{"MPD_HSI_GRID_N_Available"}}, nil})
add_PB_label(11, {"E"}, {" "}, {"N"})
add_PB_label(13, {"E"})
add_PB_label(15, {"E"}, {" "}, {"S"})
add_PB_label(18, {"S", nil, {{"MPD_HSI_GRID_S_Available"}}, nil})

-- GRID
local grid_square_size = 150
local grid_square_size05 = grid_square_size / 2
local grid_side = grid_square_size * 5
local grid_side05 = grid_side / 2

for i = 0,2,1 do
	local dist = grid_square_size05 + grid_square_size * i
	addStrokeLine("GRID_Line_left_"..i,		grid_side, {-dist, -grid_side05}, 0)
	addStrokeLine("GRID_Line_right_"..i,	grid_side, { dist, -grid_side05}, 0)
	addStrokeLine("GRID_Line_up_"..i,		grid_side, {grid_side05,  dist}, 90)
	addStrokeLine("GRID_Line_down_"..i,		grid_side, {grid_side05, -dist}, 90)
end

-- REF Type
local GRID_REF_TYPE =
{
	AC_POS	= 0,
	REF_WP	= 1,
	OS		= 2,
}

local GridCenterPH = addPlaceholder("GRID_REF_Type_PH", {0,-15}, nil, {{"MPD_HSI_GRID_CenterShift", grid_square_size}})
addStrokeSymbol("GRID_REF_Type_AC_POS",	{"stroke_symbols_MDI_AMPCD", "136-aircraft"},		"FromSet", {0,0}, GridCenterPH.name, {{"MPD_HSI_GRID_REF_Type", GRID_REF_TYPE.AC_POS}}, 1)
addStrokeSymbol("GRID_REF_Type_REF_WP",	{"stroke_symbols_MDI_AMPCD", "SA-LS"},				"FromSet", {0,0}, GridCenterPH.name, {{"MPD_HSI_GRID_REF_Type", GRID_REF_TYPE.REF_WP}}, 2)
addStrokeSymbol("GRID_REF_Type_OS",		{"stroke_symbols_MDI_AMPCD", "Waypoint-symbol"},	"FromSet", {0,0}, GridCenterPH.name, {{"MPD_HSI_GRID_REF_Type", GRID_REF_TYPE.OS}}, 2.5)

-- SIG Digraphs
for y = -2,2,1 do
	for x = -2,2,1 do
		local digraph = addStrokeText("GRID_SquareDigraph_"..x.."_"..y, "XX", STROKE_FNT_DFLT_150, "CenterCenter", {grid_square_size * x, grid_square_size * y}, nil, {{"MPD_HSI_GRID_Digraph", x, y, 50}})
		addStrokeLine("GRID_SquareChoosen_"..x.."_"..y, 60, {30, -25}, 90, digraph.name, {{"MPD_HSI_GRID_DigraphUnderline", x, y}})
	end
end

-- Zone Intersections
local zone_intersection_pos_dy = 20
local zone_intersections_pos_y =
{
	grid_square_size * 2.5 + zone_intersection_pos_dy,
	-grid_square_size * 2.5 - zone_intersection_pos_dy
}

for j = 1,2,1 do
	for i = 0,3,1 do
		local pos_x = -grid_square_size * 1.5 + grid_square_size * i
		local pos_y = zone_intersections_pos_y[j]

		local zone_intersection_PH = addPlaceholder("GRID_ZoneIntersection_PH"..i..j, {pos_x,pos_y}, nil, {{"MPD_HSI_GRID_ZoneIntersectionShow", i}})
		local label_name = "GRID_ZoneIntersections_"..j.."_"..i
		addStrokeText(label_name.."_l", "XX", STROKE_FNT_DFLT_120, "RightCenter", {-15, 0}, zone_intersection_PH.name, {{"MPD_HSI_GRID_ZoneIntersectionNumber", i}})
		addStrokeText(label_name.."_r", "XX", STROKE_FNT_DFLT_120, "LeftCenter",  { 15, 0}, zone_intersection_PH.name, {{"MPD_HSI_GRID_ZoneIntersectionNumber", i+1}})
	end
end


-- TDC Cursor
addMPD_TDC_diamond()

local TDC_Root = "TDC_Root"
local TDCLineLen = 80
local TDCLineOffset = 40
local TDCLabelOffsetX = TDCLineOffset + 10
local TDCLabelOffsetY = TDCLineLen / 4
addPlaceholder(TDC_Root, {0, 0}, nil, {{"MPD_GRID_TDCPosition", 512}})
addStrokeLine("TDC_Line_Right", TDCLineLen, {TDCLineOffset, -TDCLineLen / 2}, 0, TDC_Root, {{"MPD_HSI_GRID_SetYellowColor"}})
addStrokeLine("TDC_Line_Left", TDCLineLen, {-TDCLineOffset, -TDCLineLen / 2}, 0, TDC_Root, {{"MPD_HSI_GRID_SetYellowColor"}})
