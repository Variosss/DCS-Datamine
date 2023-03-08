dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/TGP/MFD_TGP_tools.lua")

local noControllers = nil

---------------------------------------------------
-- On/Off placeholder
local flirRoot = addPlaceholder("TGP_Root", {0,0})
local operPlaceholder = addPlaceholder("TGP_OnOff", {0,0}, nil, {{"TGP_OperPlaceholder", 1}})
local videoOnPlaceholder = addPlaceholder("TGP_VideoOn", {0,0}, operPlaceholder.name, {{"TGP_VideoOn"}})
--
local TGP_NoModeMenu = addPlaceholder("TGP_NoModeMenu_Root", {0, 0}, operPlaceholder.name, {{"TGP_ModeMenu", 0}})

---------------------------------------------------
-- VIDEO and other
AddRenderFLIR()
---------------------------------------------------

---------------------------------------------------
-- A/C altitude
addStrokeText("TGP_RadarAltitude", "", STROKE_FNT_DFLT_8_12, "CenterCenter", {190, 200}, TGP_NoModeMenu.name, {{"TGP_RadarAltitude"}})

-- A/C Reference symbol
local AC_Reference_root = addPlaceholder("AC_Reference_root", {-215, -210}, flirRoot.name, {{"MFD_AC_Reference_Symbol"}})
addStrokeSymbol("AC_Reference_Symbol", {"stroke_symbols_MFD", "AC-reference"}, "FromSet", {0, 0}, AC_Reference_root.name, {{"MFD_SetColor_Group_1"}})
-- Steering line
addStrokeLine("AzimuthSteeringBar", 40, {0, -20}, 0, AC_Reference_root.name, {{"MFD_AzimuthSteeringBar", 20}, {"MFD_SetColor_Group_1"}})
addStrokeLine("Vertical_Steering_Bar", 40, {-20, 0}, -90, AC_Reference_root.name, {{"MFD_VerticalSteeringBar", 20}, {"MFD_SetColor_Group_1"}})

---------------------------------------------------
-- LOS position
-- situational awareness cue should be clipped in the center area of TGP cross
local rtclCenter = 5
local maskVerts = {{-rtclCenter/2,  rtclCenter/2},
			 { rtclCenter/2,  rtclCenter/2}, 
			 { rtclCenter/2, -rtclCenter/2},
			 {-rtclCenter/2, -rtclCenter/2}}

openMaskArea(0, "TGP_LosPosCenter_Open", maskVerts, box_ind, {0,0}, nil)

local losPosYmax = 238
local losPosPlaceholder = addPlaceholder("TGP_LosPosPlaceholder", {0,0}, videoOnPlaceholder.name,
					{{"TGP_Azimuth", 0, -1},
					 {"move", 0, losPosYmax * GetScale(), 0},
					 {"TGP_Elevation", 0, losPosYmax / math.rad(90)}})
local boxSide = 5
local losPosBox 	= addStrokeBox("TGP_LosPosition", boxSide, boxSide, "CenterCenter", {0,0}, losPosPlaceholder.name)
losPosBox.init_rot	= {45}

closeMaskArea(1, "TGP_LosPosCenter_Close", maskVerts, box_ind, {0,0}, nil)

-- Slewing indicator
addStrokeText("TGP_SlewingIndicator", "", STROKE_FNT_DFLT_8_12, "LeftCenter", {-150, 150}, TGP_NoModeMenu.name, {{"TGP_SlewingIndicator"}})


-- NOT TIMED OUT
addStrokeText("TGP_NotTimedOut_label", "NOT TIMED OUT", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, 200}, flirRoot.name, {{"TGP_NotTimedOut_Label"}})

-- Zoom level
addStrokeText("TGP_ZoomLevel", "", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, 200}, TGP_NoModeMenu.name, {{"TGP_ZoomLevel"}}, {"%dZ"})
-- Gain/Level
local mgc_root = addPlaceholder("TGP_MGC", {0,0}, TGP_NoModeMenu.name, {{"TGP_GainControl", 1}})
addStrokeText("TGP_GainValue", "", STROKE_FNT_DFLT_10_14, "LeftCenter", {-235, 210}, mgc_root.name, {{"TGP_GainValue"}}, {"%dG"})
-- Level buttons
local level_root = addPlaceholder("Range_Scale_Root", {PB_positions[17][1] + 10 , (PB_positions[17][2] - PB_positions[16][2]) / 2 + PB_positions[16][2] - 10}, mgc_root.name)
addStrokeText("TGP_LevelValue", "", STROKE_FNT_DFLT_10_14, "CenterCenter", nil, level_root.name, {{"TGP_LevelValue"}}, {"%dL"})
local levelOffset = 25
local levelSymbolScale = 3.5
addStrokeSymbol("Decrement_Range_Scale_Symbol", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, -levelOffset}, level_root.name, {{"MFD_Declutter"}}, levelSymbolScale)
local Increment = addStrokeSymbol("Increment_Range_Scale_Symbol", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, levelOffset}, level_root.name, {{"MFD_Declutter"}}, levelSymbolScale)
Increment.init_rot = {180}
addSizeClipMask(level_root, 2, 72, {{"MFD_Declutter"}, {"TGP_GainControl", 1}}, {-19, 0})

-- Track Status
addStrokeText("TGP_TrackStatus", "", STROKE_FNT_DFLT_8_12, "RightCenter", {30, -170}, TGP_NoModeMenu.name, {{"TGP_TrackStatus"}}, {"", "AREA", "POINT", "INR      ", "INR  AREA", "INR POINT", "RATES"})

-- Time to release, Time to destination
addStrokeText("TGP_TimeToStp", nil, STROKE_FNT_DFLT_8_12, "RightCenter", {200, -200}, TGP_NoModeMenu.name, {{"TGP_TimeToStp"}})

---------------------------------------------------
-- OSBs
add_PB_label(1, "A-A",	flirRoot.name, {{"MFD_Declutter"}, {"TGP_SelectedMode", 1, TGP_MODE.AA}})
add_PB_label(1, "A-G",	flirRoot.name, {{"MFD_Declutter"}, {"TGP_SelectedMode", 1, TGP_MODE.AG}})
add_PB_label(1, "STBY",	flirRoot.name, {{"MFD_Declutter"}, {"TGP_SelectedMode", 1, TGP_MODE.STBY}})

add_PB_label(3, "WIDE",	operPlaceholder.name, {{"MFD_Declutter"}, {"TGP_FOV_Label", 0}}, nil, {"WIDE", "NARO"})
add_Selectable_PB_Label(4, "OVRD",	operPlaceholder.name, {{"MFD_Declutter"}, {"TGP_OverrideMode", 0}}, {{"TGP_OverrideMode", 1}})
add_PB_label(5, "CNTL",	TGP_NoModeMenu.name, {{"MFD_Declutter"}})

local pb6 = add_Simple_PB_label(6, "WHOT",	TGP_NoModeMenu.name, {{"MFD_Declutter"}, {"TGP_Polarity", 0}})
pb6.formats = {"TV", "WHOT", "BHOT"}

local pb18 = add_Simple_PB_label(18, "",	TGP_NoModeMenu.name, {{"MFD_Declutter"}, {"TGP_GainControl"}})
pb18.formats = {"M\nG\nC", "A\nG\nC"}
local pb20 = add_Simple_PB_label(20, "\n", TGP_NoModeMenu.name, {{"MFD_Declutter"}, {"TGP_ModeMenu", 0}, {"TGP_GRAY_Opt", 0}})
pb20.formats = {"GRAY\nOFF", "GRAY\nON"}

---------------------------------------------------
-- MODE MENU page
local TGP_ModeMenu = addPlaceholder("TGP_ModeMenu_Root", {0, 0}, noParent, {{"TGP_ModeMenu", 1}})

add_Selectable_PB_Label(20, "A-A",	TGP_ModeMenu.name, {{"TGP_SelectedMode", 0, TGP_MODE.AA}},	 {{"TGP_SelectedMode", 1, TGP_MODE.AA}})
add_Selectable_PB_Label(6,  "A-G",	TGP_ModeMenu.name, {{"TGP_SelectedMode", 0, TGP_MODE.AG}},	 {{"TGP_SelectedMode", 1, TGP_MODE.AG}})
add_Selectable_PB_Label(10, "STBY",	TGP_ModeMenu.name, {{"TGP_SelectedMode", 0, TGP_MODE.STBY}}, {{"TGP_SelectedMode", 1, TGP_MODE.STBY}})
