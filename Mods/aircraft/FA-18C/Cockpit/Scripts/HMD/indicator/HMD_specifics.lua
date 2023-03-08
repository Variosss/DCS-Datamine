-- Set screen units and indicator scale
dofile(LockOn_Options.script_path.."HMD/indicator/HMD_units.lua")

-- DI - F/A-18 Multipurpose Display Group stroke indicator Display Increment
DItoScreenUnits = DItoMil()
ScreenUnitsToDI = 1 / DItoScreenUnits

SetScale(MILLYRADIANS)
SetCustomScale(GetScale() * DItoScreenUnits) -- Display Increments

stroke_font     	= "HMD_FONT_MATERIAL"
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