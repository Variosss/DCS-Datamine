dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")

addOffLabel("HAD", nil)

local HAD_Root = addPlaceholder("HAD_Root", {0,0})
-- A/C Reference symbol
local AC_Reference_root = addPlaceholder("AC_Reference_root", {-215, -210}, HAD_Root.name, {{"MFD_AC_Reference_Symbol"}})
addStrokeSymbol("AC_Reference_Symbol", {"stroke_symbols_MFD", "AC-reference"}, "FromSet", {0, 0}, AC_Reference_root.name, {{"MFD_SetColor_Group_1"}})
-- Steering line
addStrokeLine("AzimuthSteeringBar", 40, {0, -20}, 0, AC_Reference_root.name, {{"MFD_AzimuthSteeringBar", 20}, {"MFD_SetColor_Group_1"}})
addStrokeLine("Vertical_Steering_Bar", 40, {-20, 0}, -90, AC_Reference_root.name, {{"MFD_VerticalSteeringBar", 20}, {"MFD_SetColor_Group_1"}})
