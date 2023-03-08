dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")

local HAD_THRT_DECLUTTER =
{
	CLASS_1				= 0,
	CLASS_2				= 1,
	CLASS_3				= 2,
	CLASS_4				= 3,
	CLASS_5				= 4,
	CLASS_6				= 5,
	CLASS_7				= 6,
	CLASS_8				= 7,
	CLASS_9				= 8,
	CLASS_10			= 9,
	CLASS_11			= 10,
	ALL					= 11,
	MAN					= 12,
}

local ROOT_PAGE				= addPlaceholder("ROOT_PAGE",		nil, nil)
local HAD_THRT_PAGE			= addPlaceholder("HAD_THRT_PAGE",		nil, ROOT_PAGE.name)

local Aircraft_reference_symbol_Root = addPlaceholder("Aircraft_reference_symbol_Root", {0,0}, nil, {{"HAD_BullseyeLOS_VisibleState", 0}})
-- A/C Reference symbol
local AC_Reference_PH = addPlaceholder("AC_Reference_root", {-215, -210}, Aircraft_reference_symbol_Root.name, {{"MFD_AC_Reference_Symbol"}})
addStrokeSymbol("Aircraft_reference_Reference_Symbol", {"stroke_symbols_MFD", "AC-reference"}, "FromSet", {0, 0}, AC_Reference_PH.name, {{"MFD_SetColor_Group_1"}})
-- Steering line
addStrokeLine("Azimuth_Steering_Bar", 40, {0, -20}, 0, AC_Reference_PH.name, {{"MFD_AzimuthSteeringBar", 20}, {"MFD_SetColor_Group_1"}})
addStrokeLine("Vertical_Steering_Bar", 40, {-20, 0}, -90, AC_Reference_PH.name, {{"MFD_VerticalSteeringBar", 20}, {"MFD_SetColor_Group_1"}})
------------------------------------------------------
function add_SelectablePB_TwoLine_Label(PB_number, line1Text, line2Text, parent, controller, controllerNumber)
add_Selectable_PB_Label(PB_number, line1Text, 	parent, {{controller, 0, controllerNumber}},	{{controller, 1, controllerNumber}})

local sizeBoxX = (line2Text:len() * (20 + line2Text:len() + 1));
local sizeBoxY = 24;

local posFillBox_X
local posFillBox_Y

local posText_X = - 4;
local posText_Y = -30;

if (PB_number >= 1 and PB_number <= 5) then
posFillBox_X = -3;
posFillBox_Y = -22;
sizeBoxX = (line2Text:len() * (12 + line2Text:len()));
if (line2Text:len() > 1) then
posText_X = -(line2Text:len() * 7);
end
elseif (PB_number >= 6 and PB_number <= 10) then 
posFillBox_X = 2;
posFillBox_Y = -21;
if (line2Text:len() == 2) then
posText_X = - 16;
end
if (line2Text:len() > 2) then
posText_X = - ((16 * (line2Text:len()-1))-(line2Text:len()-1));
end
elseif (PB_number >= 16 and PB_number <= 20) then
posFillBox_X = 0;
posFillBox_Y = -21;
posText_X = -6;
end

addFillBox("FillBox"..PB_number, sizeBoxX, sizeBoxY,					  "Center", {PB_positions[PB_number][1] + posFillBox_X, PB_positions[PB_number][2] + posFillBox_Y}, parent, {{controller, 3, controllerNumber}})
addStrokeText("StrokeText"..PB_number, line2Text, 	STROKE_FNT_DFLT_10_14,"Center", {PB_positions[PB_number][1] + posText_X, 	PB_positions[PB_number][2] + posText_Y},	parent, {{controller, 2, controllerNumber}})
addBlackText("BlackText"..PB_number,	line2Text, 	STROKE_FNT_DFLT_10_14,"Center", {PB_positions[PB_number][1] + posText_X, 	PB_positions[PB_number][2] + posText_Y}, 	parent, {{controller, 3, controllerNumber}})
end

---------------------------------------------------------
add_SelectablePB_TwoLine_Label(1, "CLASS", "11", HAD_THRT_PAGE.name,"HAD_SelectedClassesDeclutter", HAD_THRT_DECLUTTER.CLASS_11)
add_Selectable_PB_Label(2, 	"MAN", 			HAD_THRT_PAGE.name, {{"HAD_SelectedClassesDeclutter", 1, HAD_THRT_DECLUTTER.MAN}},	{{"HAD_SelectedClassesDeclutter", 0, HAD_THRT_DECLUTTER.MAN}})
add_PB_label(3, 			"SITE\nALL",	HAD_THRT_PAGE.name)
add_Selectable_PB_Label(4, 	"THRT", 		HAD_THRT_PAGE.name, {{"HAD_THRT", 0}},	{{"HAD_THRT", 1}})
add_Selectable_PB_Label(5, 	"ALL", 			HAD_THRT_PAGE.name, {{"HAD_SelectedClassesDeclutter", 0, HAD_THRT_DECLUTTER.ALL}},	{{"HAD_SelectedClassesDeclutter", 1, HAD_THRT_DECLUTTER.ALL}})
------------------------------------------------------
add_SelectablePB_TwoLine_Label(6, "CLASS", "6", HAD_THRT_PAGE.name,"HAD_SelectedClassesDeclutter", HAD_THRT_DECLUTTER.CLASS_6)
add_SelectablePB_TwoLine_Label(7, "CLASS", "7", HAD_THRT_PAGE.name,"HAD_SelectedClassesDeclutter", HAD_THRT_DECLUTTER.CLASS_7)
add_SelectablePB_TwoLine_Label(8, "CLASS", "8", HAD_THRT_PAGE.name,"HAD_SelectedClassesDeclutter", HAD_THRT_DECLUTTER.CLASS_8)
add_SelectablePB_TwoLine_Label(9, "CLASS", "9", HAD_THRT_PAGE.name,"HAD_SelectedClassesDeclutter", HAD_THRT_DECLUTTER.CLASS_9)
add_SelectablePB_TwoLine_Label(10, "CLASS", "10", HAD_THRT_PAGE.name,"HAD_SelectedClassesDeclutter",HAD_THRT_DECLUTTER.CLASS_10)
--------------------------------------------------------
add_SelectablePB_TwoLine_Label(16, "CLASS", "5", HAD_THRT_PAGE.name,"HAD_SelectedClassesDeclutter", HAD_THRT_DECLUTTER.CLASS_5)
add_SelectablePB_TwoLine_Label(17, "CLASS", "4", HAD_THRT_PAGE.name,"HAD_SelectedClassesDeclutter", HAD_THRT_DECLUTTER.CLASS_4)
add_SelectablePB_TwoLine_Label(18, "CLASS", "3", HAD_THRT_PAGE.name,"HAD_SelectedClassesDeclutter", HAD_THRT_DECLUTTER.CLASS_3)
add_SelectablePB_TwoLine_Label(19, "CLASS", "2", HAD_THRT_PAGE.name,"HAD_SelectedClassesDeclutter", HAD_THRT_DECLUTTER.CLASS_2)
add_SelectablePB_TwoLine_Label(20, "CLASS", "1", HAD_THRT_PAGE.name,"HAD_SelectedClassesDeclutter", HAD_THRT_DECLUTTER.CLASS_1)

addStrokeText("HTS", "HTS OFP\nID 0042", STROKE_FNT_DFLT_10_14, "Center", {-40,0}, HAD_THRT_PAGE.name)
addStrokeText("HTS_SCTDisplay", "SCT X:XX", STROKE_FNT_DFLT_10_14, "Center", {-55,165}, HAD_THRT_PAGE.name, {{"HAD_ScanTime"}})
