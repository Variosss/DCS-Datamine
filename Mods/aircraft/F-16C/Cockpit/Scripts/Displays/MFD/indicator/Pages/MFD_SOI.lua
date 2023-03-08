dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_formats_IDs.lua")

local FrameSize = 480
addStrokeBox("SOI", FrameSize, FrameSize, "CenterCenter", nil, nil, {{"MFD_SOI", 1}, {"MFD_SetColor_Group_2"}}, nil, 2.9)

addNotSoiLabel({{"MFD_SOI", 0, MFD_DISPL_FMT_LEV1.HSD}})
