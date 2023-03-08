dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
AddButtons("ИНФО","НА","МСШТБ+","МСШТБ-","НАВ")

middle_line_cur             = CreateElement "ceTexPoly"
middle_line_cur.name		= "middle_line_cur"
SetLineSized(middle_line_cur,0,1.3*x_size)
middle_line_cur.init_pos	= {-0.3*x_size,y_center_render - y_render_size - size_mrk,0}
Add(middle_line_cur)
--------------------------------------------------------------------------------------
AddCursor(true,"RED")
---------------------------------------------------------------------------------------
--[[
"map_info_point_bearing" 
"map_info_point_latitude" 
"map_info_point_longitude"
"map_info_point_name" 
"map_info_point_type_name"
"map_info_point_additional_info"
--]]

txt_mrk             = CreateElement "ceStringPoly"
txt_mrk.name        = "txt_mrk"
txt_mrk.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk.alignment   = "LeftTop"
txt_mrk.stringdefs  = abris_font[5] 
txt_mrk.init_pos    = {-0.29*x_size,y_center_render - y_render_size,0}
txt_mrk.formats	=	{""}
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
								{"map_info_point_full_description", 3},						
								{"map_info_point_name",3},
								{"map_info_point_height"     ,4},
								{"measurements_units_height" ,5},	
								{"map_info_point_callsign"     ,3},
								{"map_info_point_runway_length"    ,6},
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
								{"map_info_point_short_description", 3},		
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
								{"map_info_point_short_description", 3},		
								{"map_info_point_name",3},
								{"map_info_point_band",4,2},
								{"map_info_point_callsign"     ,3},						
								{"map_info_point_morze_callsign" ,5}								
							  }
Add(txt_mrk_vor)
use_mipfilter(txt_mrk_vor)

txt_mrk_stp				=Copy(txt_mrk_airdrome)
txt_mrk_stp.name        = "txt_mrk_stp"
txt_mrk_stp.formats      = {"BRG:%03.f°/","%03.f°","\tDST:%.2f\n","%s\n","%s\n","%s\n"}
txt_mrk_stp.controllers	= {                                
								{"info_point_check_type", 0},
								{"map_info_point_bearing"  ,0},
								{"map_info_point_bearing"  ,1,1},
								{"map_info_point_distance" ,2},						
								{"map_info_point_short_description", 3},							
								{"map_info_point_name"     ,4},
								{"map_info_point_full_description", 5},							
							   }
Add(txt_mrk_stp)
use_mipfilter(txt_mrk_stp)

txt_mrk_datalink				=Copy(txt_mrk_airdrome)
txt_mrk_datalink.name        = "txt_mrk_datalink"
txt_mrk_datalink.formats      = {"BRG:%03.f°/","%03.f°","\tDST:%.2f\n","%s\n","%s "}
txt_mrk_datalink.controllers	= {                                
								{"info_point_check_type", 4},
								{"map_info_point_bearing"  ,0},
								{"map_info_point_bearing"  ,1,1},
								{"map_info_point_distance" ,2},						
								{"map_info_point_short_description", 3},	
								{"map_info_point_name",3}						
							   }
Add(txt_mrk_datalink)
use_mipfilter(txt_mrk_datalink)

txt_mrk_town				=Copy(txt_mrk_airdrome)
txt_mrk_town.name        = "txt_mrk_town"
txt_mrk_town.formats      = {"BRG:%03.f°/","%03.f°","\tDST:%.2f\n","%s\n","%s "}
txt_mrk_town.controllers	= {                                
								{"info_point_check_type", 3},
								{"map_info_point_bearing"  ,0},
								{"map_info_point_bearing"  ,1,1},
								{"map_info_point_distance" ,2},						
								{"map_info_point_short_description", 3},	
								{"map_info_point_name",3}			
							   }
Add(txt_mrk_town)
use_mipfilter(txt_mrk_town)


txt_mrk_void				=  Copy(txt_mrk_airdrome)
txt_mrk_void.name        	= "txt_mrk_void"
txt_mrk_void.formats      	= {"BRG:%03.f°/","%03.f°","\tDST:%.2f\n","%s\n","%s "}
txt_mrk_void.controllers	= {                                
								{"info_point_check_type"   ,5},
								{"map_info_point_bearing"  ,0},
								{"map_info_point_bearing"  ,1,1},
								{"map_info_point_distance" ,2}
							   }
Add(txt_mrk_void)
use_mipfilter(txt_mrk_void)


txt_mrk3             = CreateElement "ceStringPoly"
txt_mrk3.name        = "txt_mrk3"
txt_mrk3.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk3.alignment   = "LeftTop"
txt_mrk3.stringdefs  = abris_font[5] 
txt_mrk3.init_pos    = {-0.05 * x_size,-0.55*x_size,0}
txt_mrk3.formats     = {" %s ","%s\n",
						" "..LOCALIZE("СКЛ").." %.1f°,",
						LOCALIZE("ВЫС").." %.f "}
txt_mrk3.parent_element = "txt_mrk"
txt_mrk3.controllers = {{"map_info_point_latitude" 	   ,0},
						{"map_info_point_longitude"	   ,1},
						{"map_info_point_mag_variation",2},
						{"map_info_point_height"	   ,3}}
Add(txt_mrk3)
use_mipfilter(txt_mrk3)