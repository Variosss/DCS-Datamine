dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/AMPCD/indicator/AMPCD_specifics.lua")

-- the parameters for 'MPD_common_bake_page.lua'
bake_material_name 		= AMPCD_BAKE_MATERIAL
aspect_adjustment 		= 0.97

dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/BAKE/MPD_common_bake_page.lua")
