dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")

-- Prepare display border vertices and indices
--local displayBorderInds = prepareBorderVerts(displayBorderVerts, MeterToIn * InToPX()
AddBackground("Background_Mask", true) -- clipping mask

local GAAF_L = 215
local GAAF_2L = GAAF_L * 2
local GAAF_LEN = math.sqrt(GAAF_2L * GAAF_2L * 2)
local GAAF_PH = addPlaceholder("GAAF MFD X PH", {0,0}, nil, {{"MFD_GAAF_X"}})
addStrokeLine("GAAF MFD /",		GAAF_LEN, {-GAAF_L, -GAAF_L}, -45, GAAF_PH.name, nil, false)
addStrokeLine("GAAF MFD \\",	GAAF_LEN, { GAAF_L, -GAAF_L},  45, GAAF_PH.name, nil, false)
