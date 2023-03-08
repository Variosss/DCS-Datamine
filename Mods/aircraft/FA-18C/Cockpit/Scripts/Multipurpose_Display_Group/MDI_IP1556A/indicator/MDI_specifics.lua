
-- Set screen units and indicator scale
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_scales.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_materials.lua")

-- Init display border verts. From 3D Max, in meters.
-- Right half of the vertices set. Symmetric about Y axis.
displayBorderVerts = {
	{0.04510,  0.06637},
	{0.04790,  0.06614},
	{0.05060,  0.06559},
	{0.05323,  0.06470},
	{0.05573,  0.06351},
	{0.05803,  0.06199},
	{0.06012,  0.06018},
	{0.06194,  0.05807},
	{0.06349,  0.05575},
	{0.06471,  0.05330},
	{0.06561,  0.05071},
	{0.06618,  0.04802},
	{0.06642,  0.04520},
	{0.06642,  0.04199},
	{0.06642, -0.04240},
	{0.06642, -0.04510},
	{0.06613, -0.04791},
	{0.06564, -0.05061},
	{0.06474, -0.05323},
	{0.06352, -0.05572},
	{0.06196, -0.05803},
	{0.06013, -0.06013},
	{0.05804, -0.06195},
	{0.05574, -0.06349},
	{0.05326, -0.06476},
	{0.05065, -0.06570},
	{0.04796, -0.06622},
	{0.04517, -0.06637},
}

collimated      = false
additive_alpha  = false