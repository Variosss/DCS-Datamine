dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/HARM/HARM_Utils.lua")

local HARM_Mode_NONE	= 0
local HARM_Mode_SP		= 1
local HARM_Mode_TOO		= 2
local HARM_Mode_PB		= 3
local HARM_Mode_SP_PB	= 4

addStrokeText("HARM_Station", "", STROKE_FNT_DFLT_120, "CenterCenter", {-336, 350}, nil, {{"MPD_HARM_Station"}}, {"STA %1d"})

-------------------------------------- Menu --------------------------------------
local pb3 = add_PB_label(3, {" PB ", nil, nil, {{"MPD_HARM_Mode_Box", HARM_Mode_PB}}})[1]
local pb4 = add_PB_label(4, {" TOO ", nil, nil, {{"MPD_HARM_Mode_Box", HARM_Mode_TOO}}})[1]
local pb5 = add_PB_label(5, {" SP ", nil, nil, {{"MPD_HARM_Mode_Box", HARM_Mode_SP}}})[1]

local vBox_sizeX = 25
local vBox_sizeY = 124
local vBox_offsetX = 7
add_X_Over("BP_3_Break_X", 	vBox_sizeX, vBox_sizeY, {vBox_offsetX, 0}, pb3.name, {{"MPD_HARM_Mode_DEGD", HARM_Mode_PB}})
add_X_Over("BP_4_Break_X", 	vBox_sizeX, vBox_sizeY, {vBox_offsetX, 0}, pb4.name, {{"MPD_HARM_Mode_DEGD", HARM_Mode_TOO}})
add_X_Over("BP_5_Break_X", 	vBox_sizeX, vBox_sizeY, {vBox_offsetX, 0}, pb5.name, {{"MPD_HARM_Mode_DEGD", HARM_Mode_SP}})

local pb6 = add_PB_label(6, {"       ", nil, {{"MPD_HARM_SelectedWeapon", 0}}, {{"MPD_HARM_SelectedWeapon", 1}}}, "", {"RDY", nil, {{"MPD_HARM_SelectedWeapon", 2}}})[1]

local hBox_sizeX = 154
local hBox_sizeY = 36
local hBox_offsetY = -12
add_X_Over("BP_6_Break_X", 	hBox_sizeX, hBox_sizeY, {0, hBox_offsetY}, pb6.name, {{"MPD_HARM_SelectedWeapon", 3}})

add_PB_label(13, {"STEP", nil, {{"MPD_SMS_STEP_Label"}}})

add_Harm_Ovrd_PB16()

addStrokeText("HARM_HARM_SP_PB_Indication", nil, STROKE_FNT_DFLT_150, "CenterCenter", {0, 50}, nil, {{"MPD_HARM_SP_PB_Indication"}})
add_X_Over("HARM_HARM_SP_PB_Indication_X", 150, 36, {0, 0}, "HARM_HARM_SP_PB_Indication", {{"MPD_HARM_SP_PB_Indication_X"}})
