dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
----------------------------------------------------------------------------------
AddMode("ПОИСК")
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddMap()
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
stencil_return                  = CreateElement "ceMeshPoly"
stencil_return.primitivetype    = "triangles" 
stencil_return.vertices         =  render_map.vertices	
stencil_return.indices          =  render_map.indices
stencil_return.name			    = "stencil_return"
stencil_return.material         = "GREEN"
stencil_return.isvisible        = false
stencil_return.isdraw           = true
stencil_return.parent_element   = "screen"
stencil_return.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
stencil_return.level            = DEFAULT_LEVEL + 3
Add(stencil_return)
------------------------------------------------------------------------------------------
plane_symbol                = CreateElement "ceTexPoly"
plane_symbol.name           = "plane_symbol"
plane_symbol.vertices       = {{-plane_size_x/scale_2, plane_size_y/scale_2},
							   { plane_size_x/scale_2, plane_size_y/scale_2},
							   { plane_size_x/scale_2,-plane_size_y/scale_2},
							   {-plane_size_x/scale_2,-plane_size_y/scale_2}}
plane_symbol.indices        = box_ind
plane_symbol.material       = "INDICATION_ABRIS_RED"
plane_symbol.tex_params		= {plane_center_x,plane_center_y,scale_2,scale_2}
plane_symbol.parent_element = "screen"
plane_symbol.controllers	= {{"self_map_orient",x_size,x_size,-1}}
SetDefaultClipWithLevel(plane_symbol,3)
Add(plane_symbol)
use_mipfilter(plane_symbol)
---------------------------------------------------------------------------------------
AddSignalsBorder()
---------------------------------------------------------------------------------------
up_line             = CreateElement "ceTexPoly"
up_line.name		= "up_line"
SetLine(up_line)
up_line.init_pos	= {0,y_center_render + y_render_size,0}
Add(up_line)
---------------------------------------------------------------------------------------
middle_line             = CreateElement "ceTexPoly"
middle_line.name		= "middle_line"
SetLine(middle_line)
middle_line.init_pos	= {0,y_center_render - y_render_size,0}
Add(middle_line)
---------------------------------------------------------------------------------------
center_line             = CreateElement "ceTexPoly"
center_line .name		= "center_line"
center_line.init_pos	= {-0.3*x_size,y_center_render - y_render_size,0}
center_line.init_rot	= {-90.0,0,0}
SetLineSized(center_line ,0,0.545*y_size)
Add(center_line)

middle_line_cur             = CreateElement "ceTexPoly"
middle_line_cur.name		= "middle_line_cur"
SetLineSized(middle_line_cur,0,1.3*x_size)
middle_line_cur.init_pos	= {-0.3*x_size,y_center_render - y_render_size - size_mrk,0}
Add(middle_line_cur)


txt_mrk             = CreateElement "ceStringPoly"
txt_mrk.name        = "txt_mrk"
txt_mrk.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk.alignment   = "LeftTop"
txt_mrk.stringdefs  = abris_font[5] 
txt_mrk.init_pos    = {-0.29*x_size,y_center_render - y_render_size,0}
txt_mrk.formats     = {""}
Add(txt_mrk)
use_mipfilter(txt_mrk)

txt_mrk_airdrome             = CreateElement "ceStringPoly"
txt_mrk_airdrome.name        = "txt_mrk_airdrome"
txt_mrk_airdrome.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk_airdrome.alignment   = "LeftTop"
txt_mrk_airdrome.stringdefs  = abris_font[5] 
--txt_mrk_airdrome.init_pos    = {-0.29*x_size,y_center_render - y_render_size,0}
txt_mrk_airdrome.parent_element	="txt_mrk"
txt_mrk_airdrome.formats     = {"BRG:%03.f°/","%03.f°","\tDST:%.2f\n","%s\n","%.0f","%s ",LOCALIZE("ВПП").." %i"}
txt_mrk_airdrome.controllers = {								
								{"info_point_check_type", 1},
								{"map_info_point_bearing"  ,0},
								{"map_info_point_bearing"  ,1,1},
								{"map_info_point_distance" ,2},
								{"map_info_point_full_description",3},
								{"map_info_point_name",3},
								{"map_info_point_height"     ,4},
								{"measurements_units_height" ,5},	
								{"map_info_point_callsign"     ,3},
								{"map_info_point_runway_length"    ,6 },
								{"measurements_units_height" ,5}								
								}
Add(txt_mrk_airdrome)
use_mipfilter(txt_mrk_airdrome)

txt_mrk_homer					=Copy(txt_mrk_airdrome)
txt_mrk_homer.name        = "txt_mrk_homer"
txt_mrk_homer.formats      = {"BRG:%03.f°/","%03.f°","\tDST:%.2f\n","%s\n","%3.2f ","%s "}
txt_mrk_homer.controllers	= {	{"info_point_check_type", 2, 8},							
                                {"map_info_point_bearing"  ,0},
								{"map_info_point_bearing"  ,1,1},
								{"map_info_point_distance" ,2},
--								{"map_info_point_type_name",5},
								{"map_info_point_short_description",3},
								{"map_info_point_name",3},
								{"map_info_point_band",4,1},
								{"map_info_point_callsign"     ,3},						
								{"map_info_point_morze_callsign" ,5}								
							  }
Add(txt_mrk_homer)
use_mipfilter(txt_mrk_homer)

txt_mrk_vor					=Copy(txt_mrk_airdrome)
txt_mrk_vor.name        = "txt_mrk_vor"
txt_mrk_vor.formats      = {"BRG:%03.f°/","%03.f°","\tDST:%.2f\n","%s\n","%3.2f ","%s "}
txt_mrk_vor.controllers	= {	{"info_point_check_type", 2, 1},							
                                {"map_info_point_bearing"  ,0},
								{"map_info_point_bearing"  ,1,1},
								{"map_info_point_distance" ,2},
--								{"map_info_point_type_name",5},
								{"map_info_point_short_description",3},
								{"map_info_point_name",3},
								{"map_info_point_band",4,2},
								{"map_info_point_callsign"     ,3},						
								{"map_info_point_morze_callsign" ,5}								
							  }
Add(txt_mrk_vor)
use_mipfilter(txt_mrk_vor)

txt_mrk_stp				=Copy(txt_mrk_airdrome)
txt_mrk_stp.name        = "txt_mrk_stp"
txt_mrk_stp.formats      = {"BRG:%03.f°/","%03.f°","\tDST:%.2f\n","%s\n","%s "}
txt_mrk_stp.controllers	= {                                
								{"info_point_check_type", 0},
								{"map_info_point_bearing"  ,0},
								{"map_info_point_bearing"  ,1,1},
								{"map_info_point_distance" ,2},						
--								{"map_info_point_type_name",4},
								{"map_info_point_short_description",3},
								{"map_info_point_name",3},
								{"map_info_point_callsign"     ,4}												
							   }
Add(txt_mrk_stp)
use_mipfilter(txt_mrk_stp)

txt_mrk2             = CreateElement "ceStringPoly"
txt_mrk2.name        = "txt_mrk2"
txt_mrk2.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk2.alignment   = "LeftTop"
txt_mrk2.stringdefs  = abris_font[5] 
txt_mrk2.init_pos    = {-0.7*x_size,0,0}
txt_mrk2.parent_element = "txt_mrk"
txt_mrk2.formats     = {"ETA %02.f:%02.f\n","ETE %02.f:%02.f\n","FUEL %5.0f\n","REM %5.0f\n"}
txt_mrk2.controllers = {{"map_info_point_estimated_arrival_time"  ,0},
						{"map_info_point_estimated_time_to_go"  ,1},
						{"map_info_point_estimated_fuel_consumption" ,2},
						{"map_info_point_estimated_remaining_fuel" ,3}}
Add(txt_mrk2)
use_mipfilter(txt_mrk2)

txt_mrk3             = CreateElement "ceStringPoly"
txt_mrk3.name        = "txt_mrk3"
txt_mrk3.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk3.alignment   = "LeftTop"
txt_mrk3.stringdefs  = abris_font[5] 
txt_mrk3.init_pos    = {0,-0.55*x_size,0}
txt_mrk3.formats     = {" %s ","%s "..LOCALIZE("СКЛ")}
txt_mrk3.parent_element = "txt_mrk"
txt_mrk3.controllers = {{"map_info_point_latitude" ,0},
						{"map_info_point_longitude",1}}
Add(txt_mrk3)
use_mipfilter(txt_mrk3)

txt_mrk4                = CreateElement "ceStringPoly"
txt_mrk4.name           = "txt_mrk4"
txt_mrk4.material       = "font_Ka-50_ABRIS_WHITE"
txt_mrk4.alignment      = "RightTop"
txt_mrk4.stringdefs     = abris_font[5] 
txt_mrk4.init_pos       = {1.29*x_size,0,0}
txt_mrk4.formats        = {"\n%.1f"}
txt_mrk4.parent_element = "txt_mrk3"
txt_mrk4.controllers    = {{"map_info_point_mag_variation",0}}
Add(txt_mrk4)
use_mipfilter(txt_mrk4)


AddButtons("ПОИСК","НА","ИНФО","СПИСОК","НАВ")

