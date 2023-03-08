dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")

local OSB11_label = 
{
	NONE	= 0,
	DCLT	= 1,
	S_J		= 2,
	TCN		= 3
}

--add_PB_label(11, "DCLT", nil, {{"MFD_PB_Menu_11_OSB", OSB11_label.DCLT}}, {{"MFD_PB_Menu_11_OSB", OSB11_label.DCLT}})
add_Selectable_PB_Label(11, "DCLT", nil, {{"MFD_PB_Menu_11_OSB", OSB11_label.DCLT}, {"MFD_DCLT_Selected", 0}}, {{"MFD_DCLT_Selected", 1}})
add_PB_label(11, "S-J",  nil, {{"MFD_PB_Menu_11_OSB", OSB11_label.S_J}},  {{"MFD_PB_Menu_11_OSB", OSB11_label.S_J}})
add_PB_label(11, "TCN",  nil, {{"MFD_PB_Menu_11_OSB", OSB11_label.TCN}},  {{"MFD_PB_Menu_11_OSB", OSB11_label.TCN}})

add_PB_Menu_Label(12)
add_PB_Menu_Label(13)
add_PB_Menu_Label(14)

add_PB_label(15, "SWAP")


for i=1,20 do
	add_PB_Animation(i)
end

-- Attitude Advisory
local att_advPosX = -190
local att_advPosY = 65
local att_advX = 380
local att_advY = 100
local att_advRoot = addPlaceholder("MFD_TGP_AttAdv_base", {att_advPosX, att_advPosY}, nil, {{"TGP_AttitudeAdvisory"}})
addTexturedMesh("MFD_TGP_AttAdv", "INDICATION_TGP_RED", {{0, -att_advY}, {att_advX, -att_advY}, {att_advX, 0}, {0, 0}},
	{1/256,101/256, 240/512 * GetScale(), 240/512 * GetScale()}, nil, nil, att_advRoot.name)

addBlackBoldText("AttAdv_Left1",	"CHECK",	STROKE_FNT_DFLT_10_14, "CenterCenter", {90, -35},	att_advRoot.name)
addBlackBoldText("AttAdv_Left2",	"ATTITUDE",	STROKE_FNT_DFLT_10_14, "CenterCenter", {90, -65},	att_advRoot.name)
addBlackBoldText("AttAdv_Right1",	"CHECK",	STROKE_FNT_DFLT_10_14, "CenterCenter", {290, -35},	att_advRoot.name)
addBlackBoldText("AttAdv_Right2",	"ATTITUDE",	STROKE_FNT_DFLT_10_14, "CenterCenter", {290, -65},	att_advRoot.name)
