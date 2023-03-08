local my_path = LockOn_Options.script_path.."SimpleHUD/Lua/"
dofile(my_path.."HUD_definitions.lua")

-- precreated material for mfd0 is render_target_1 
-- precreated material for mfd1 is render_target_2 
-- precreated material for mfd2 is render_target_3 
-- precreated material for mfd3 is render_target_4 

local sz 	 = 40
local verts  =   {{-sz,  sz},
				  { sz,  sz},
				  { sz, -sz},
				  {-sz, -sz}}
				  
				  
frame                                       = CreateElement "ceMeshPoly"
frame.name                                  = "fr"
frame.primitivetype                         = "lines"
frame.material                              = MakeMaterial(nil,{0,0,0,255})
frame.vertices                  			= verts
frame.indices			                    = {0,1,1,2,2,3,3,0}
							 
													
AddHUDElement(frame)

		  
				  
TV_RENDER					= CreateElement "ceTexPoly"
TV_RENDER.name				= "TV_RENDER"
TV_RENDER.vertices			= verts
TV_RENDER.indices			= {0, 1, 2, 0, 2, 3}
TV_RENDER.tex_coords 		= {{0,0},{1,0},{1,1},{0,1}}
TV_RENDER.material			= "render_target_1"
AddHUDElement(TV_RENDER)


TV_RENDER_src_view					= CreateElement "ceTexPoly"
TV_RENDER_src_view.name				= "TV_RENDER_src_view"
TV_RENDER_src_view.vertices			= verts
TV_RENDER_src_view.indices			= {0, 1, 2, 0, 2, 3}
TV_RENDER_src_view.init_pos 		= {0,-2 * sz}
TV_RENDER_src_view.tex_coords 		= {{0,0},{1,0},{1,1},{0,1}}
TV_RENDER_src_view.material			= MakeMaterial("mfd0",{255,255,255,100})
AddHUDElement(TV_RENDER_src_view)