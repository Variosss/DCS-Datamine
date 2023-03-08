dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/SMS/MFD_SMS_tools.lua")
dofile(LockOn_Options.script_path.."Computers/MMC_Types.lua")

--addStrokeText("Placeholder_SMS_INV", "SMS INV\nPLACEHOLDER", STROKE_FNT_DFLT_20_28, "CenterCenter")

local AcftSubModeLbl_INV = AcftSubModeLbl
AcftSubModeLbl_INV[2] = "STBY"

local backGrd = {}
backGrd[1] = {name = "MFD_SMS.png",	sz = 240, pos = {0, 0}}			-- for horizon line {0, 69}

function draw_backgroundPic(num)
	local box_sz = backGrd[num].sz
	local quad 		= {	{-box_sz,	box_sz},
						{box_sz, 	box_sz},
						{box_sz,	-box_sz},
						{-box_sz,	-box_sz}}
	local quad_tex	= {	{0,0},
						{1,0},
						{1,1},
						{0,1}}
	local texturesPath = LockOn_Options.script_path.."../IndicationResources/Displays/"
	local textName = backGrd[num].name
	local backgr_pic			= CreateElement "ceTexPoly"
	backgr_pic.name				= "backgr_pic"..num
	backgr_pic.vertices			= quad
	backgr_pic.indices			= {0, 1, 2, 0, 2, 3}
	backgr_pic.material			= MakeMaterial(texturesPath..textName, {100, 100, 100, 150})
	backgr_pic.tex_coords		= quad_tex
	backgr_pic.init_pos			= backGrd[num].pos
	Add(backgr_pic)
end

--draw_backgroundPic(1)

addStrokeText("SMS_INV_Gun_Rnds", "", STROKE_FNT_DFLT_10_14, "LeftCenter", {-240,160}, nil, {{"SMS_INV_Gun", 0}}, {"%02dGUN"})
addStrokeText("SMS_INV_Gun_Ammo", "", STROKE_FNT_DFLT_10_14, "LeftCenter", {-240,130}, nil, {{"SMS_INV_Gun", 1}})

addStrokeText("SMS_INV_Pylon1_Lvl1", "_______", STROKE_FNT_DFLT_10_14, "LeftCenter", {-228, -140}, nil, {{"SMS_INV_Pylon", 0, 0}})
addStrokeText("SMS_INV_Pylon1_Lvl2", "_______", STROKE_FNT_DFLT_10_14, "LeftCenter", {-228, -160}, nil, {{"SMS_INV_Pylon", 0, 1}})

addStrokeText("SMS_INV_Pylon2_Lvl1", "_______", STROKE_FNT_DFLT_10_14, "LeftCenter", {-228,  -80}, nil, {{"SMS_INV_Pylon", 1, 0}})
addStrokeText("SMS_INV_Pylon2_Lvl2", "_______", STROKE_FNT_DFLT_10_14, "LeftCenter", {-228, -100}, nil, {{"SMS_INV_Pylon", 1, 1}})

addSelectableInvString("SMS_INV_Pylon3_Lvl1", "_______", {-190,    3}, {{"SMS_INV_Pylon", 2, 0}}, {"SMS_INV_PylonSelected", 2, 0})
addSelectableInvString("SMS_INV_Pylon3_Lvl2", "_______", {-190,  -17}, {{"SMS_INV_Pylon", 2, 1}}, {"SMS_INV_PylonSelected", 2, 1})
addSelectableInvString("SMS_INV_Pylon3_Lvl3", "_______", {-190,  -37}, {{"SMS_INV_Pylon", 2, 2}}, {"SMS_INV_PylonSelected", 2, 2})
                                                                                                
addSelectableInvString("SMS_INV_Pylon4_Lvl1", "_______", {-124,   77}, {{"SMS_INV_Pylon", 3, 0}}, {"SMS_INV_PylonSelected", 3, 0})
addSelectableInvString("SMS_INV_Pylon4_Lvl2", "_______", {-124,   57}, {{"SMS_INV_Pylon", 3, 1}}, {"SMS_INV_PylonSelected", 3, 1})
addSelectableInvString("SMS_INV_Pylon4_Lvl3", "_______", {-124,   37}, {{"SMS_INV_Pylon", 3, 2}}, {"SMS_INV_PylonSelected", 3, 2})
                                                                                                
addSelectableInvString("SMS_INV_Pylon5_Lvl1", "_______", { -39,  180}, {{"SMS_INV_Pylon", 4, 0}}, {"SMS_INV_PylonSelected", 4, 0})
addSelectableInvString("SMS_INV_Pylon5_Lvl2", "_______", { -39,  160}, {{"SMS_INV_Pylon", 4, 1}}, {"SMS_INV_PylonSelected", 4, 1})
addSelectableInvString("SMS_INV_Pylon5_Lvl3", "_______", { -39,  140}, {{"SMS_INV_Pylon", 4, 2}}, {"SMS_INV_PylonSelected", 4, 2})
                                                                                                
addSelectableInvString("SMS_INV_Pylon6_Lvl1", "_______", {  46,   77}, {{"SMS_INV_Pylon", 5, 0}}, {"SMS_INV_PylonSelected", 5, 0})
addSelectableInvString("SMS_INV_Pylon6_Lvl2", "_______", {  46,   57}, {{"SMS_INV_Pylon", 5, 1}}, {"SMS_INV_PylonSelected", 5, 1})
addSelectableInvString("SMS_INV_Pylon6_Lvl3", "_______", {  46,   37}, {{"SMS_INV_Pylon", 5, 2}}, {"SMS_INV_PylonSelected", 5, 2})
                                                                                                
addSelectableInvString("SMS_INV_Pylon7_Lvl2", "_______", { 112,  -17}, {{"SMS_INV_Pylon", 6, 1}}, {"SMS_INV_PylonSelected", 6, 1})
addSelectableInvString("SMS_INV_Pylon7_Lvl1", "_______", { 112,    3}, {{"SMS_INV_Pylon", 6, 0}}, {"SMS_INV_PylonSelected", 6, 0})
addSelectableInvString("SMS_INV_Pylon7_Lvl3", "_______", { 112,  -37}, {{"SMS_INV_Pylon", 6, 2}}, {"SMS_INV_PylonSelected", 6, 2})

addStrokeText("SMS_INV_Pylon8_Lvl1", "_______", STROKE_FNT_DFLT_10_14, "LeftCenter", { 144,  -80}, nil, {{"SMS_INV_Pylon", 7, 0}})
addStrokeText("SMS_INV_Pylon8_Lvl2", "_______", STROKE_FNT_DFLT_10_14, "LeftCenter", { 144, -100}, nil, {{"SMS_INV_Pylon", 7, 1}})

addStrokeText("SMS_INV_Pylon9_Lvl1", "_______", STROKE_FNT_DFLT_10_14, "LeftCenter", { 144, -140}, nil, {{"SMS_INV_Pylon", 8, 0}})
addStrokeText("SMS_INV_Pylon9_Lvl2", "_______", STROKE_FNT_DFLT_10_14, "LeftCenter", { 144, -160}, nil, {{"SMS_INV_Pylon", 8, 1}})

add_PB_label(1, "", nil, {{"SMS_SubModeLabel"}}, nil, AcftSubModeLbl_INV)
add_Selected_PB_Label(4, "INV", {{"SMS_INV_Show_INV_Button"}})