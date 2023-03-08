dofile(LockOn_Options.script_path.."HUD\\HUD_definitions.lua")

ASE_center_y = 2.24 / texture_size

missile_ASE_circle					= create_HUD_element("ceTexPoly")
missile_ASE_circle.name				= "missile_ASE_circle"
missile_ASE_circle.vertices			= {{-0.118, -0.118}, {-0.118, 0.157}, {0.118, 0.157}, {0.118, -0.118}}
missile_ASE_circle.indices			= default_box_indices
missile_ASE_circle.material			= "INDICATION_HUD_KA50"
missile_ASE_circle.tex_params		= {27.75 / texture_size, ASE_center_y, tex_scale, tex_scale}
missile_ASE_circle.controllers		= {{"missile_ASE_circle"},{"ASE_circle_position"}}--{"current_sight"}}
AddWithDefaultClip(missile_ASE_circle)

--[[
missile_ASE_circle_region		 = create_region(missile_ASE_circle, "missile_ASE_circle_region")
missile_ASE_circle_region.isdraw = true
Add(missile_ASE_circle_region)
--]]

missile_ASE_distance_sector					= create_HUD_element("ceHWSector")
missile_ASE_distance_sector.name			= name
missile_ASE_distance_sector.vertices1		= {{-0.007, -0.15}, {-0.007, 0.15}, {0.15, 0.15}, {0.15, -0.15}}
missile_ASE_distance_sector.tex_params1		= {31.73 / texture_size, ASE_center_y, tex_scale, tex_scale}
missile_ASE_distance_sector.vertices2		= {{-0.15, -0.15}, {-0.15, 0.15}, {0.007, 0.15}, {0.007, -0.15}}
missile_ASE_distance_sector.tex_params2		= {31.52 / texture_size, ASE_center_y, tex_scale, tex_scale}
missile_ASE_distance_sector.maskvertices	= {{-0.15, -0.15}, {-0.15, 0.15}, {0.0, 0.15}, {0.0, -0.15}}
missile_ASE_distance_sector.indices			= default_box_indices
missile_ASE_distance_sector.material		= "INDICATION_HUD_KA50"
missile_ASE_distance_sector.controllers     = {{"ASE_circle_distance_sector", 10000.0, (math.pi * 2.0) / 10000.0}}
missile_ASE_distance_sector.parent_element	= "missile_ASE_circle"
missile_ASE_distance_sector.minangle		= math.rad(2.0)
missile_ASE_distance_sector.maxangle		= math.rad(358.0)
AddWithDefaultClip(missile_ASE_distance_sector)

--[[
local use1 = false

dbg1					= create_HUD_element("ceTexPoly")
dbg1.name				= "dbg1"
dbg1.indices			= default_box_indices
dbg1.material			= "INDICATION_HUD_KA50"

if use1 == true then
	dbg1.vertices			= {{-0.007, -0.15}, {-0.007, 0.15}, {0.15, 0.15}, {0.15, -0.15}}
	dbg1.tex_params			= {31.73 / texture_size, ASE_center_y, tex_scale, tex_scale}
else
	dbg1.vertices			= {{-0.15, -0.15}, {-0.15, 0.15}, {0.007, 0.15}, {0.007, -0.15}}
	dbg1.tex_params			= {31.52 / texture_size, ASE_center_y, tex_scale, tex_scale}
end

AddWithDefaultClip(dbg1)

addDebugGeometryForced(dbg1)
--]]

ASE_tick_vertices = {{-0.005, 0.105}, {-0.005, 0.155}, {0.005, 0.155}, {0.005, 0.105}}

local function add_ASE_range_tick(parent,init_angle,controllers)
	local tick				= create_HUD_element("ceTexPoly")
	tick.vertices			= ASE_tick_vertices
	tick.indices			= default_box_indices
	tick.material		    = "INDICATION_HUD_KA50"
	tick.tex_params			= {29.46 / texture_size, ASE_center_y, tex_scale, tex_scale}
	tick.init_rot			= {init_angle, 0.0, 0.0}
	tick.parent_element		= parent.name
	if  controllers then
		tick.controllers        = controllers
    end
	AddWithDefaultClip(tick)
	return tick
end

local cont = {}
for i = 1,3 do cont[i] = {{"piper_dynamic_launch_zone", 10000, (math.pi * 2.0) / 10000 ,i - 1}}    end
                       
missile_ASE_min_range_tick = add_ASE_range_tick(missile_ASE_circle,0,cont[1])
missile_ASE_aut_range_tick = add_ASE_range_tick(missile_ASE_circle,0,cont[2])
--missile_ASE_max_range_tick = add_ASE_range_tick(missile_ASE_circle,0,cont[3])

shkval_piper = add_piper("shkval_piper", {{"tv_mark", 2}})
--[[
add_piper_distance_sector("shkval_distance_sector", "shkval_piper")
add_piper_range_tick("shkval_min_range_tick", "shkval_piper", -28.8)
add_piper_range_tick("shkval_max_range_tick", "shkval_piper", -288.0)
--]]



					   
add_piper_distance_sector_basic("shkval_distance_sector", "shkval_piper"  ,{{"missile_ASE_circle",0},
                                                                            {"show_piper_launch_zone"},
                                                                            {"piper_distance_sector", 10000, (math.pi * 2.0) / 10000}})

--[[
add_piper_range_tick_basic("shkval_min_range_tick", "shkval_piper", -28.8 ,{{"missile_ASE_circle",0},{"show_piper_launch_zone"}})
add_piper_range_tick_basic("shkval_max_range_tick", "shkval_piper", -288.0,{{"missile_ASE_circle",0},{"show_piper_launch_zone"}})
--]]
--[[
add_piper_DLZ_tick_basic ("shkval_min_range_tick", "shkval_piper",controllers_1)
add_piper_DLZ_tick_basic ("shkval_max_range_tick", "shkval_piper",controllers_2)
--]]

