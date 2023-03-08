dofile(LockOn_Options.script_path.."HUD\\HUD_definitions.lua")
--[[
grid            = create_HUD_element("ceTexPoly")
grid.name       = "grid"
grid.vertices   = {{-0.564, -0.837}, {-0.564, 0.297}, {0.564, 0.297}, {0.564, -0.837}}
grid.indices    = default_box_indices
grid.init_pos   = {0.0, 0.795 + vertical_displacement, 0}
grid.material   = "INDICATION_HUD_KA50"
grid.tex_params = {19.52 / texture_size, 8.47 / texture_size, tex_scale, tex_scale}
AddWithDefaultClip(grid)
--]]

txt_test					= create_HUD_element("ceStringPoly")
txt_test.name				= "txt_test"
txt_test.material			= "font_Ka-50_HUD"
txt_test.init_pos			= {0, 0.25 + vertical_displacement, 0}
txt_test.alignment			= "CenterCenter"
txt_test.value				= "EAGLE DYNAMICS"
txt_test.stringdefs		    = {0.0073, 0.0073, -0.0007, 0.0009}
AddWithDefaultClip(txt_test)

--[[
grid_test_region		= create_region(grid, "grid_test_region")
grid_test_region.isdraw = true
Add(grid_test_region)
--]]
