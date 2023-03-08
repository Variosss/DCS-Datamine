dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_materials.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_strokesDefs.lua")
dofile(LockOn_Options.script_path.."symbology_defs.lua")

override_materials		= true
override_material		= "MPD_DMC_OUTLINE"
override_font			= "font_MPD_DMC_outline"
override_thickness		= DMC_outline_thickness
override_fuzziness  	= DMC_outline_fuzziness

addPlaceholder("OutlinedLevel_ON", nil, nil, {{"MPD_SA_SetOutlinedLevel", 1}})

dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/SA/SA.lua")

addPlaceholder("OutlinedLevel_OFF", nil, nil, {{"MPD_SA_SetOutlinedLevel", 0}})
