-- Set screen units and indicator scale
dofile(LockOn_Options.script_path.."Displays/Common/indicator/Units.lua")

SetScale(MILLYRADIANS)

stroke_font     	= "font_HMD"
stroke_material 	= "HMD_SYMBOLOGY_MATERIAL"
additive_alpha  	= true
collimated      	= true

-- Right half of the vertices set. Symmetric about Y axis.
local bgSize = 10.5
displayBorderVerts = {
	{ bgSize,  bgSize},
	{ bgSize, -bgSize},
	{-bgSize, -bgSize},
	{-bgSize,  bgSize}
}