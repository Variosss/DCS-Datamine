dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_materials.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_strokesDefs.lua")

override_materials		= true
override_material		= MDG_material_name(MDG_SELF_IDS.HI)
override_font			= "font_MPD_DMC_main"
override_thickness		= DMC_stroke_thickness
override_fuzziness  	= DMC_stroke_fuzziness

dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/SA/SA.lua")
