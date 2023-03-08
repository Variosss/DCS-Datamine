dofile(LockOn_Options.script_path.."HUD\\HUD_definitions.lua")


------------------------------------SHKVAL TDC----------------------------------------
local shkvalTDC_size 		= 0.065 --0.07

shkval_TDC					= create_HUD_element("ceTexPoly")
shkval_TDC.name				= "shkval_TDC"
shkval_TDC.vertices			= {{-shkvalTDC_size, -shkvalTDC_size}, 
							   {-shkvalTDC_size, shkvalTDC_size},
							   {shkvalTDC_size, shkvalTDC_size},
							   {shkvalTDC_size, -shkvalTDC_size}}
shkval_TDC.indices			= default_box_indices
shkval_TDC.material			= "INDICATION_HUD_KA50"
shkval_TDC.tex_params		= {0.35465, 0.05759, tex_scale, tex_scale}
--shkval_TDC.tex_params		= {820 / 1024, 212 / 1024, tex_scale, tex_scale}
shkval_TDC.controllers      = {{"tv_mark", 1},
                               {"tv_mark_in_HUD_zone",0,hud_zone},
                               {"shkval_limits_blinking",math.rad(5.0)},
                               }
AddWithDefaultClip(shkval_TDC)

--drawDbgGeometry 			= true
--drawDbgMarkers 			= true	
--addDebugGeometryFor(shkval_TDC)
		
txt_TA_symbol					= create_HUD_element("ceStringPoly")
txt_TA_symbol.name				= "txt_TA_symbol"
txt_TA_symbol.material			= "font_Ka-50_HUD"
txt_TA_symbol.init_pos			= {-0.794,TA_text_pos_y + vertical_displacement, 0}
txt_TA_symbol.value				= "ТА"
txt_TA_symbol.alignment			= "LeftCenter"
txt_TA_symbol.stringdefs		= {0.0073, 0.0073, -0.0007, 0.0}
txt_TA_symbol.controllers       = {{"shkval_state", 3}}
AddWithDefaultClip(txt_TA_symbol)

txt_RU_TA_symbol					= create_HUD_element("ceStringPoly")
txt_RU_TA_symbol.name				= "txt_RU_TA_symbol"
txt_RU_TA_symbol.material			= "font_Ka-50_HUD"
txt_RU_TA_symbol.value				= "РУ-"
txt_RU_TA_symbol.alignment			= "RightCenter"
txt_RU_TA_symbol.stringdefs			= {0.0073, 0.0073, -0.0007, 0.0}
txt_RU_TA_symbol.parent_element		= txt_TA_symbol.name
txt_RU_TA_symbol.controllers        = {{"reserve_mode"}}
AddWithDefaultClip(txt_RU_TA_symbol)



txt_P_symbol					= Copy(txt_TA_symbol)
txt_P_symbol.value				= " П"
txt_P_symbol.controllers        = {{"shkval_state", 4}}
Add(txt_P_symbol)

local laser_state = {"   ИД",
					 "   ИП",
					 "   ИУ"}
					 
txt_LR_symbol		= {}
txt_LR_DEFIS_symbol = {}
for i = 1,#laser_state do

txt_LR_symbol[i]							= create_HUD_element("ceStringPoly")
txt_LR_symbol[i].material					= "font_Ka-50_HUD"
txt_LR_symbol[i].value						= laser_state[i]
txt_LR_symbol[i].alignment					= "LeftCenter"
txt_LR_symbol[i].stringdefs		    		= {0.0073, 0.0073, -0.0007, 0.0}
txt_LR_symbol[i].controllers        		= {{"laser_ranger_state",i}}
txt_LR_symbol[i].init_pos					= txt_TA_symbol.init_pos
AddWithDefaultClip(txt_LR_symbol[i])

txt_LR_DEFIS_symbol[i]					    = create_HUD_element("ceStringPoly")
txt_LR_DEFIS_symbol[i].material			    = "font_Ka-50_HUD"
txt_LR_DEFIS_symbol[i].value				= "  -"
txt_LR_DEFIS_symbol[i].alignment			= "LeftCenter"
txt_LR_DEFIS_symbol[i].stringdefs		    = {0.0073, 0.0073, -0.0007, 0.0}
txt_LR_DEFIS_symbol[i].controllers          = {{"shkval_state", 3}}
txt_LR_DEFIS_symbol[i].parent_element       = txt_LR_symbol[i].name
AddWithDefaultClip(txt_LR_DEFIS_symbol[i])

end


txt_LR_PAUSE_symbol						= create_HUD_element("ceStringPoly")
txt_LR_PAUSE_symbol.name				= "txt_LR_PAUSE_symbol"
txt_LR_PAUSE_symbol.material			= "font_Ka-50_HUD"
txt_LR_PAUSE_symbol.value				= "ПАУЗА"
txt_LR_PAUSE_symbol.alignment			= "CenterTop"
txt_LR_PAUSE_symbol.stringdefs		    = {0.0073, 0.0073, -0.0007, 0.0}
txt_LR_PAUSE_symbol.controllers         = {{"laser_ranger_relaxation_control"}}
txt_LR_PAUSE_symbol.init_pos		    = {0.0, 0.11 + vertical_displacement, 0}
AddWithDefaultClip(txt_LR_PAUSE_symbol)

--[[
temperature						= create_HUD_element("ceStringPoly")
temperature.name				= "temperature"
temperature.material			= "font_Ka-50_HUD"
temperature.alignment			= "CenterTop"
temperature.stringdefs		    = {0.0073, 0.0073, -0.0007, 0.0}
temperature.formats             = {"%3.f"}
temperature.controllers         = {{"dbg_laser_temperature",0}}
temperature.init_pos		    = {0.3, -0.32 , 0}
Add(temperature)
--]]



txt_LR_countdown					= create_HUD_element("ceStringPoly")
txt_LR_countdown.name				= "txt_LR_countdown"
txt_LR_countdown.material			= "font_Ka-50_HUD"
txt_LR_countdown.alignment			= "CenterTop"
txt_LR_countdown.stringdefs		    = {0.0073, 0.0073, -0.0007, 0.0}
txt_LR_countdown.formats             = {"%02.f"}
txt_LR_countdown.controllers        = {{"laser_countdown_control",0}}
txt_LR_countdown.init_pos		    = {-0.5, 0.11 + vertical_displacement, 0}
AddWithDefaultClip(txt_LR_countdown)


local shkval_zone_scale = 0.3/35

base_frame             =  create_HUD_element("ceSimple")
base_frame.name        =  "exceed_HUD_zone"
base_frame.init_pos    =  bird_position
base_frame.controllers =  {{"tv_mark_in_HUD_zone",1,hud_zone}}
Add(base_frame)


shkval_limits_up					= create_HUD_element("ceTexPoly")
shkval_limits_up.name				= "shkval_limits_up"
shkval_limits_up.vertices			= {{-shkval_zone_scale*35,-0.011},
                                       {-shkval_zone_scale*35, 0.011},
                                       { shkval_zone_scale*35, 0.011},
                                       { shkval_zone_scale*35,-0.011}}
shkval_limits_up.indices			= default_box_indices
shkval_limits_up.init_pos			= {0,shkval_zone_scale * 15,0}
shkval_limits_up.init_rot			= {0.0, 0.0, 0}
shkval_limits_up.material			= "INDICATION_HUD_KA50"
shkval_limits_up.tex_params			= {0.5, 952/1024, tex_scale, tex_scale}
shkval_limits_up.parent_element     = base_frame.name 
AddWithDefaultClip(shkval_limits_up)

shkval_limits_left					= create_HUD_element("ceTexPoly")
shkval_limits_left.name				= "shkval_limits_left"
shkval_limits_left.vertices			= {{0,-0.011},
                                       {0, 0.011},
                                       {shkval_zone_scale*100, 0.011},
                                       {shkval_zone_scale*100,-0.011}}
shkval_limits_left.indices			= default_box_indices
shkval_limits_left.init_pos			= {-shkval_zone_scale*35, 0.0, 0}
shkval_limits_left.init_rot			= {-90.0, 0.0, 0}
shkval_limits_left.material			= "INDICATION_HUD_KA50"
shkval_limits_left.tex_params		= {0.5, 952/1024, tex_scale, tex_scale}
shkval_limits_left.parent_element   = "shkval_limits_up"
AddWithDefaultClip(shkval_limits_left)

shkval_limits_right					= Copy(shkval_limits_left)
shkval_limits_right.init_pos		= {shkval_zone_scale*35, 0, 0}
Add(shkval_limits_right)

shkval_limits_down					= Copy(shkval_limits_up)
shkval_limits_down.init_pos			= {0,-shkval_zone_scale * 85,0}
Add(shkval_limits_down)

tv_angles                   = Copy(shkval_TDC)
tv_angles.parent_element    = base_frame.name
tv_angles.controllers       = {{"tv_angles",shkval_zone_scale*57.3*GetScale(),shkval_zone_scale*57.3*GetScale()},
                               {"shkval_limits_blinking",math.rad(5.0)}}
Add(tv_angles)

