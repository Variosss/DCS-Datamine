dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local counter = 0
local function count()
	counter = counter + 1
	return counter
end

local TopYPos = 343
local DistanceBetweenRow = 60
local LabelOffset = 70
local LRLabelOffset = 250
local LDataOffset = 180
local RDataOffset = 260

addStrokeText("LEFT_EPE", "LEFT EPE", STROKE_FNT_DFLT_150, "CenterCenter", {-LRLabelOffset, TopYPos + LabelOffset})
addStrokeText("RIGHT_EPE", "RIGHT EPE", STROKE_FNT_DFLT_150, "CenterCenter", {LRLabelOffset, TopYPos + LabelOffset})

addStrokeText("INLET_TEMP", "INLET TEMP", STROKE_FNT_DFLT_150, "CenterCenter", {0, TopYPos})
addStrokeText("INLET_TEMP_L", "-31", STROKE_FNT_DFLT_150, "RightCenter", {-LDataOffset, TopYPos}, nil, {{"MPD_ENG_Inlet_Temp", 0}})
addStrokeText("INLET_TEMP_R", "-31", STROKE_FNT_DFLT_150, "RightCenter", {RDataOffset, TopYPos}, nil, {{"MPD_ENG_Inlet_Temp", 1}})

addStrokeText("N1_RPM", "N1 RPM", STROKE_FNT_DFLT_150, "CenterCenter", {0, TopYPos - DistanceBetweenRow * count()})
addStrokeText("N1_RPM_L", "90", STROKE_FNT_DFLT_150, "RightCenter", {-LDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_N1_RPM", 0}})
addStrokeText("N1_RPM_R", "89", STROKE_FNT_DFLT_150, "RightCenter", {RDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_N1_RPM", 1}})

addStrokeText("N2_RPM", "N2 RPM", STROKE_FNT_DFLT_150, "CenterCenter", {0, TopYPos - DistanceBetweenRow * count()})
addStrokeText("N2_RPM_L", "87", STROKE_FNT_DFLT_150, "RightCenter", {-LDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_N2_RPM", 0}})
addStrokeText("N2_RPM_R", "0", STROKE_FNT_DFLT_150, "RightCenter", {RDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_N2_RPM", 1}})

addStrokeText("EGT", "EGT", STROKE_FNT_DFLT_150, "CenterCenter", {0, TopYPos - DistanceBetweenRow * count()})
addStrokeText("EGT_L", "673", STROKE_FNT_DFLT_150, "RightCenter", {-LDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Exhaust_Gas_Temperature", 0}})
addStrokeText("EGT_R", "677", STROKE_FNT_DFLT_150, "RightCenter", {RDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Exhaust_Gas_Temperature", 1}})

addStrokeText("FF", "FF", STROKE_FNT_DFLT_150, "CenterCenter", {0, TopYPos - DistanceBetweenRow * count()})
addStrokeText("FF_L", "2430", STROKE_FNT_DFLT_150, "RightCenter", {-LDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Fuel_Flow", 0}})
addStrokeText("FF_R", "2410", STROKE_FNT_DFLT_150, "RightCenter", {RDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Fuel_Flow", 1}})

addStrokeText("NOZ_POS", "NOZ POS", STROKE_FNT_DFLT_150, "CenterCenter", {0, TopYPos - DistanceBetweenRow * count()})
addStrokeText("NOZ_POS_L", "15", STROKE_FNT_DFLT_150, "RightCenter", {-LDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Nozzle_position", 0}})
addStrokeText("NOZ_POS_R", "16", STROKE_FNT_DFLT_150, "RightCenter", {RDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Nozzle_position", 1}})

addStrokeText("OIL_PRESS", "OIL PRESS", STROKE_FNT_DFLT_150, "CenterCenter", {0, TopYPos - DistanceBetweenRow * count()})
addStrokeText("OIL_PRESS_L", "108", STROKE_FNT_DFLT_150, "RightCenter", {-LDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Oil_Pressure", 0}})
addStrokeText("OIL_PRESS_R", "110", STROKE_FNT_DFLT_150, "RightCenter", {RDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Oil_Pressure", 1}})

addStrokeText("THRUST", "THRUST", STROKE_FNT_DFLT_150, "CenterCenter", {0, TopYPos - DistanceBetweenRow * count()})
addStrokeText("THRUST_L", "0.4", STROKE_FNT_DFLT_150, "RightCenter", {-LDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Thrust", 0}})
addStrokeText("THRUST_R", "0.9", STROKE_FNT_DFLT_150, "RightCenter", {RDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Thrust", 1}})

addStrokeText("VIB", "VIB", STROKE_FNT_DFLT_150, "CenterCenter", {0, TopYPos - DistanceBetweenRow * count()})
addStrokeText("VIB_L", "0.4", STROKE_FNT_DFLT_150, "RightCenter", {-LDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Vibration", 0}})
addStrokeText("VIB_R", "0.9", STROKE_FNT_DFLT_150, "RightCenter", {RDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Vibration", 1}})

addStrokeText("FUEL_TEMP", "FUEL TEMP", STROKE_FNT_DFLT_150, "CenterCenter", {0, TopYPos - DistanceBetweenRow * count()})
addStrokeText("FUEL_TEMP_L", "29", STROKE_FNT_DFLT_150, "RightCenter", {-LDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Fuel_Temp", 0}})
addStrokeText("FUEL_TEMP_R", "26", STROKE_FNT_DFLT_150, "RightCenter", {RDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Fuel_Temp", 1}})

addStrokeText("EPR", "EPR", STROKE_FNT_DFLT_150, "CenterCenter", {0, TopYPos - DistanceBetweenRow * count()})
addStrokeText("EPR_L", "3.40", STROKE_FNT_DFLT_150, "RightCenter", {-LDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Engine_Pressure_Ratio", 0}})
addStrokeText("EPR_R", "3.31", STROKE_FNT_DFLT_150, "RightCenter", {RDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Engine_Pressure_Ratio", 1}})

addStrokeText("CDP", "CDP", STROKE_FNT_DFLT_150, "CenterCenter", {0, TopYPos - DistanceBetweenRow * count()})
addStrokeText("CDP_L", "97", STROKE_FNT_DFLT_150, "RightCenter", {-LDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Compressor_Discharge_Pressure", 0}})
addStrokeText("CDP_R", "96", STROKE_FNT_DFLT_150, "RightCenter", {RDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Compressor_Discharge_Pressure", 1}})

addStrokeText("TDP", "TDP", STROKE_FNT_DFLT_150, "CenterCenter", {0, TopYPos - DistanceBetweenRow * count()})
addStrokeText("TDP_L", "76", STROKE_FNT_DFLT_150, "RightCenter", {-LDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Turbine_Discharge_Pressure", 0}})
addStrokeText("TDP_R", "80", STROKE_FNT_DFLT_150, "RightCenter", {RDataOffset, TopYPos - DistanceBetweenRow * counter}, nil, {{"MPD_ENG_Turbine_Discharge_Pressure", 1}})

add_PB_label(16, {"RECORD", nil, nil, true})