local my_path = LockOn_Options.script_path.."SimpleHUD/Lua/"
dofile(my_path.."HUD_definitions.lua")
local  static_grid 			= create_textured_box(350,--left texture border
												  130,--top most texture border 
												  756,--right border
												  540,--down border
												  nil, -- x coordinate of center object (optional )
												  240  -- y coordinate of center object (optional )
												  )
	   static_grid.name 	= "static_grid"
	   static_grid.init_pos = {0,0,0}
	   AddHUDElement(static_grid)



