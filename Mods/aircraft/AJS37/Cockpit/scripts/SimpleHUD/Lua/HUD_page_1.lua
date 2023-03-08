local my_path = LockOn_Options.script_path.."SimpleHUD/Lua/"
dofile(my_path.."HUD_definitions.lua")

local  roll_bird = create_textured_box(353,--left texture border
									   5,--top most texture border 
									   465,--right border
									   36,--down border
									   nil, -- x coordinate of center object (optional )
									   10  -- y coordinate of center object (optional )
									  )
roll_bird.name 	      = "roll_bird"
roll_bird.init_pos    = {0,0,0}
roll_bird.controllers = {{"hud_roll" ,1.0},
						 {"hud_pitch",-0.6}}    --0.6 as it default distance between pilot eye and hud 

AddHUDElement(roll_bird)



txt_pitch					= CreateElement "ceStringPoly"
txt_pitch.name				= "txt_pitch"
txt_pitch.material			= indication_font
txt_pitch.init_pos			= {0.0,-20}
txt_pitch.alignment			= "CenterCenter"
txt_pitch.formats			= {"%+03.f"}
txt_pitch.stringdefs		= font_size_default
txt_pitch.controllers 		= {{"txt_pitch",0}}
txt_pitch.parent_element    = roll_bird.name
AddHUDElement(txt_pitch)