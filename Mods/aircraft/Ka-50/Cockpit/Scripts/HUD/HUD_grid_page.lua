dofile(LockOn_Options.script_path.."HUD\\HUD_definitions.lua")

grid            = create_HUD_element("ceTexPoly")
grid.name       = "grid"
grid.vertices   = {{-0.564, -0.837}, {-0.564, 0.297}, {0.564, 0.297}, {0.564, -0.837}}
grid.indices    = default_box_indices
grid.init_pos   = {0.0, 0.728 + vertical_displacement, 0}
grid.material   = "INDICATION_HUD_KA50"
grid.tex_params = {19.52 / texture_size, 8.47 / texture_size, tex_scale, tex_scale}
AddWithDefaultClip(grid)
