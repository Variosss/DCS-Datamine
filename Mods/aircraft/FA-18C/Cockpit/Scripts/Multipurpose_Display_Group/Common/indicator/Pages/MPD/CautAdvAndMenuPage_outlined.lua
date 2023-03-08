dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_materials.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_strokesDefs.lua")

override_materials		= true
override_material		= "MPD_DMC_OUTLINE"
override_font			= "font_MPD_DMC_outline"
override_thickness		= DMC_outline_thickness
override_fuzziness  	= DMC_outline_fuzziness
disableCautAdvMasks		= true

dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/CautAdvAndMenuPage.lua")
