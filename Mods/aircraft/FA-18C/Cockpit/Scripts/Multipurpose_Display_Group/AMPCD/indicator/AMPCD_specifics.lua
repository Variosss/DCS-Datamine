
-- Set screen units and indicator scale
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_scales.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_materials.lua")

-- Init display border verts. From 3D Max, in meters.
-- Right half of the vertices set. Symmetric about Y axis.
displayBorderVerts = {
	{0.0640,  0.0645},
	{0.0648,  0.0641},
	{0.0656,  0.0633},
	{0.0659,  0.0625},
	{0.0659, -0.0625},
	{0.0655, -0.0634},
	{0.0648, -0.0641},
	{0.0649, -0.0645}
}

stroke_font     	= MDG_font_name(MDG_SELF_IDS.HI)
stroke_material 	= MDG_material_name(MDG_SELF_IDS.HI)
collimated      	= false
additive_alpha  	= false