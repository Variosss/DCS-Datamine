dofile(LockOn_Options.common_script_path.."elements_defs.lua")

local glass_material = MakeMaterial(LockOn_Options.script_path.."../../Common/Resources/GLASS-HELMET-INDICATOR.dds", {255, 255, 255, 255})

local vertSide = 2.6

local glass       = CreateElement "ceTexPoly"
glass.name 		  = "HelmetGlass"
glass.material    = glass_material
glass.vertices    = {{-vertSide, vertSide}, {vertSide, vertSide}, {vertSide, -vertSide}, {-vertSide, -vertSide}}
glass.tex_coords  = {{0, 0}, {1, 0}, {1, 1}, {0, 1}}
glass.indices	  = default_box_indices
--glass.screenspace = ScreenType.SCREENSPACE_TRUE
glass.controllers = {{"helmetGlassPos", 0, 2.6}}
Add(glass)
