dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
AddBackground("Background_Mask", true) -- clipping mask

local First_Image = addPlaceholder("First_Image", nil, nil, {{"INIT_ShowStartImage"}})
addStrokeLine("INIT_Vertical_Line", 480, {0, -240}, 0, First_Image.name, nil, nil, nil, nil, "INDICATION_COMMON_WHITE")
addStrokeLine("INIT_Horisontal_Line", 480, {240, 0}, 90, First_Image.name, nil, nil, nil, nil, "INDICATION_COMMON_WHITE")
add_X_Over("INTI_X", 480, 480, nil, First_Image.name, nil)
local Big_Box_Size = 342
local INIT_Big_Box = addStrokeBox("INIT_Big_Box", Big_Box_Size, Big_Box_Size, "CenterCenter", nil, First_Image.name, nil, "INDICATION_COMMON_WHITE")
INIT_Big_Box.init_rot = {45}
local Little_Box_Size = 155
addStrokeBox("INIT_Little_Box", Little_Box_Size, Little_Box_Size, "CenterCenter", nil, First_Image.name, nil, "INDICATION_COMMON_WHITE")


local Standby_Root = addPlaceholder("Standby_Root", {0, -30}, nil, {{"INIT_ShowStandby"}})
local OnePart = 20
local GreenVertices = 
{
    {0, 0},
    { 5 * OnePart, -3 * OnePart},
    { 0, -6 * OnePart},
    { -5 * OnePart, -3 * OnePart}
}
local RedVertices = 
{
    {0, 0},
    { -5 * OnePart, -3 * OnePart},
    { -5 * OnePart, 2 * OnePart},
    { 0, 5 * OnePart},
}
local BlueVertices = 
{
    {0, 0},
    { 5 * OnePart, -3 * OnePart},
    { 5 * OnePart, 2 * OnePart},
    { 0, 5 * OnePart},
}
addMesh("Green_Mesh", GreenVertices, default_box_indices, {0, 0}, "triangles", Standby_Root.name, nil, "INDICATION_COMMON_GREEN")
addMesh("Red_Mesh", RedVertices, default_box_indices, {0, 0}, "triangles", Standby_Root.name, nil, "INDICATION_COMMON_RED")
addMesh("Blue_Mesh", BlueVertices, default_box_indices, {0, 0}, "triangles", Standby_Root.name, nil, "INDICATION_COMMON_LBLUE")

local BoxWidth = 100
local BoxHeight = 28
local BoxVertices = 
{
    { -BoxWidth / 2, BoxHeight / 2 },
    { BoxWidth / 2, BoxHeight / 2 },
    { BoxWidth / 2, -BoxHeight / 2 },
    { -BoxWidth / 2, -BoxHeight / 2 }
}
local LabelPosition = {0, 250}
addMesh("Blue_Box", BoxVertices, default_box_indices, LabelPosition, "triangles", Standby_Root.name, {{"INIT_StandbyLabel", 2}})
addStrokeText("Standby", "STANDBY", STROKE_FNT_DFLT_10_14, "CenterCenter", LabelPosition, Standby_Root.name, {{"INIT_StandbyLabel", 1}})