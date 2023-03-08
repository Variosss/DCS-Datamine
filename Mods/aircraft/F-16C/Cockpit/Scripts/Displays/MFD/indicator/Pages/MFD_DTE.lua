dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Computers/MMC_Types.lua")

local DTE_Declutter = 
{
	LOAD 	= 0,
	MPD 	= 1,
	FCR 	= 2,
	ELINT 	= 3,
	IDM 	= 4,
	LINK16 	= 5,
	NCTR 	= 6,
	MSMD 	= 7,
	PROF 	= 8,
	INV 	= 9,
	COMM 	= 10,
}

local DTE_CurrentPage = 
{
	PAGE_1 = 0,
	PAGE_2 = 1,
}

local DTE_ROOT_PAGE	= addPlaceholder("DTE_ROOT_PAGE",	nil, nil)
local DTE_PAGE_1	= addPlaceholder("DTE_PAGE_1",		nil, nil,	{{"DTE_PageShow", DTE_CurrentPage.PAGE_1}})
local DTE_PAGE_2	= addPlaceholder("DTE_PAGE_2",		nil, nil,  	{{"DTE_PageShow", DTE_CurrentPage.PAGE_2}})

-----------------Common

addStrokeText("DTE_ID_HEADER", "DTC ID", STROKE_FNT_DFLT_10_14, "Center", {-40, 100}, DTE_ROOT_PAGE.name)
addStrokeText("DTE_ID_VALUE", "698213", STROKE_FNT_DFLT_10_14, "Center", {-40, 80}, DTE_ROOT_PAGE.name)

local Bullseye_LOS = addPlaceholder("Bullseye_LOS", {-215, -195}, DTE_ROOT_PAGE.name, {{"DTE_BullseyeLOS_VisibleState", 1}})
local Bullseye_LOS_Radius = 17
addStrokeCircle("Bullseye_LOS_Cirle", Bullseye_LOS_Radius, nil, Bullseye_LOS.name, {{"MFD_SetColor_Group_1"}})
addStrokeText("Bullseye_LOS_Range", nil, STROKE_FNT_DFLT_8_12, "CenterCenter", nil, Bullseye_LOS.name, {{"DTE_BullseyeLOS_Range"}, {"MFD_SetColor_Group_1"}})
addStrokeText("Bullseye_LOS_Bearing", nil, STROKE_FNT_DFLT_8_12, "CenterCenter", {0, -Bullseye_LOS_Radius * 1.8}, Bullseye_LOS.name, {{"DTE_BullseyeLOS_Bearing"}, {"MFD_SetColor_Group_1"}})
local Bullseye_LOS_Pointer = addPlaceholder("Bullseye_LOS_Pointer", nil, Bullseye_LOS.name, {{"DTE_Heading"}, {"DTE_BullseyeLOS_PointerRotation"}})
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}})
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_1", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.8)
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_2", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.6)
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_3", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.4)
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_4", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.2)

local Aircraft_reference_symbol_Root = addPlaceholder("Aircraft_reference_symbol_Root", {0,0}, nil, {{"DTE_BullseyeLOS_VisibleState", 0}})
-- A/C Reference symbol
local AC_Reference_PH = addPlaceholder("AC_Reference_root", {-215, -210}, Aircraft_reference_symbol_Root.name, {{"MFD_AC_Reference_Symbol"}})
addStrokeSymbol("Aircraft_reference_Reference_Symbol", {"stroke_symbols_MFD", "AC-reference"}, "FromSet", {0, 0}, AC_Reference_PH.name, {{"MFD_SetColor_Group_1"}})
-- Steering line
addStrokeLine("Azimuth_Steering_Bar", 40, {0, -20}, 0, AC_Reference_PH.name, {{"MFD_AzimuthSteeringBar", 20}, {"MFD_SetColor_Group_1"}})
addStrokeLine("Vertical_Steering_Bar", 40, {-20, 0}, -90, AC_Reference_PH.name, {{"MFD_VerticalSteeringBar", 20}, {"MFD_SetColor_Group_1"}})

--------------------Page1
addStrokeText("DTE_LINK16", "LINK16 INIT REQD", STROKE_FNT_DFLT_10_14, "Center", {-110, -60}, DTE_PAGE_1.name)

add_PB_label(1, 			"ON", 		DTE_PAGE_1.name)
add_PB_label(2, 			"CLSD", 	DTE_PAGE_1.name)
add_Selectable_PB_Label(3, 	"LOAD", 	DTE_PAGE_1.name, {{"DTE_Declutter", 1, DTE_Declutter.LOAD}}, {{"DTE_Declutter", 0, DTE_Declutter.LOAD}})
add_Selectable_PB_Label(4, 	"FCR", 		DTE_PAGE_1.name, {{"DTE_Declutter", 1, DTE_Declutter.FCR}}, {{"DTE_Declutter", 0, DTE_Declutter.FCR}})

add_Selectable_PB_Label(6, 	"ELINT", 	DTE_PAGE_1.name, {{"DTE_Declutter", 1, DTE_Declutter.ELINT}}, {{"DTE_Declutter", 0, DTE_Declutter.ELINT}})
add_Selectable_PB_Label(7, 	"IDM", 		DTE_PAGE_1.name, {{"DTE_Declutter", 1, DTE_Declutter.IDM}}, {{"DTE_Declutter", 0, DTE_Declutter.IDM}})
add_Selectable_PB_Label(8, 	"LINK16\nA",DTE_PAGE_1.name, {{"DTE_Declutter", 1, DTE_Declutter.LINK16}}, {{"DTE_Declutter", 0, DTE_Declutter.LINK16}})
add_Selectable_PB_Label(9, 	"NCTR",		DTE_PAGE_1.name, {{"DTE_Declutter", 1, DTE_Declutter.NCTR}}, {{"DTE_Declutter", 0, DTE_Declutter.NCTR}})
add_Simple_PB_label(10, 	"PAGE\n1", 	DTE_PAGE_1.name)

add_Selectable_PB_Label(16, "MSMD", 	DTE_PAGE_1.name, {{"DTE_Declutter", 1, DTE_Declutter.MSMD}}, {{"DTE_Declutter", 0, DTE_Declutter.MSMD}})
add_Selectable_PB_Label(17, "PROF", 	DTE_PAGE_1.name, {{"DTE_Declutter", 1, DTE_Declutter.PROF}}, {{"DTE_Declutter", 0, DTE_Declutter.PROF}})
add_Selectable_PB_Label(18, "INV", 		DTE_PAGE_1.name, {{"DTE_Declutter", 1, DTE_Declutter.INV}}, {{"DTE_Declutter", 0, DTE_Declutter.INV}})
add_Selectable_PB_Label(19, "COMM", 	DTE_PAGE_1.name, {{"DTE_Declutter", 1, DTE_Declutter.COMM}}, {{"DTE_Declutter", 0, DTE_Declutter.COMM}})
add_Selectable_PB_Label(20, "MPD", 		DTE_PAGE_1.name, {{"DTE_Declutter", 1, DTE_Declutter.MPD}}, {{"DTE_Declutter", 0, DTE_Declutter.MPD}})

------------------Page2
addStrokeText("DTE_GPS", "GPS FORMAT INVALID", STROKE_FNT_DFLT_10_14, "Center", {-120, -60}, DTE_PAGE_2.name)
add_PB_label(1, 			"ON", 		DTE_PAGE_2.name)

add_Simple_PB_label(10, 	"PAGE\n2", 	DTE_PAGE_2.name)

add_Simple_PB_label(19, 	"COLR", 	DTE_PAGE_2.name)
add_Simple_PB_label(20, 	"GPS", 		DTE_PAGE_2.name)
