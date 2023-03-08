-- Set screen units and indicator scale
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_units.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_materials.lua")

-- DI - F/A-18 Multipurpose Display Group stroke indicator Display Increment
DItoScreenUnits = DItoMil()
ScreenUnitsToDI = 1 / DItoScreenUnits

SetScale(MILLYRADIANS)
SetCustomScale(GetScale() * DItoScreenUnits) -- Display Increments

stroke_font     	= MDG_font_name(MDG_SELF_IDS.HUD)
stroke_material 	= MDG_material_name(MDG_SELF_IDS.HUD)
additive_alpha  	= true
collimated      	= true
