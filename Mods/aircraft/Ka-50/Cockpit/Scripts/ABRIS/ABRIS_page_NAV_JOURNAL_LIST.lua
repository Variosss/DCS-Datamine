dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
new_delta = new_delta_2
--add_line(y_size -    y_pos_delta)
--add_line(y_size -  2*y_pos_delta)
--add_line(y_size -  2*y_pos_delta - 2*new_delta)

x_pos = {
-0.72,
-0.51,
-0.24,
0.08,
0.4,
0.75
}
--[[
	 journal_segment_end_point_name 					
	 journal_segment_end_point_number 				
	 journal_segment_end_point_type 				
	 journal_segment_end_point_latitude 			
	 journal_segment_end_point_longitude 				
	 journal_segment_track_angle 						
	 journal_segment_heading_angle 				
	 journal_segment_preset_wind_direction 			
	 journal_segment_preset_wind_speed 			
	 journal_segment_true_speed 					
	 journal_segment_ground_speed 				
	 journal_segment_length 							
	 journal_segment_remained_route_length 		
	 journal_segment_preset_flight_time 			
	 journal_segment_preset_time_over_target 		
	 journal_segment_estimated_time_over_target 	
	 journal_segment_estimated_remaining_fuel 	
	 journal_segment_preset_flight_level 			
	 journal_segment_preset_atmospheric_temperature 
	 journal_segment_preset_fuel_consumption
-]]
--[[
dummy				   = CreateElement "ceMeshPoly"
dummy.name             = "dummy"
dummy.material         = "GREEN"
dummy.isvisible        = false
dummy.init_pos		   = {-0.99*x_size,y_size -  2*y_pos_delta - 5*new_delta,0}
dummy.controllers      = {{"specific_draw_journal"}} 
Add(dummy)
--]]




-------------------------------------------------------------------------------------

local tick_scale = {}
	  tick_scale.x = 1.0
	  tick_scale.y = 1.25
	  
local from_tick_size_x = {}
	  from_tick_size_x.min = -10/512
	  from_tick_size_x.max = 20/512
local from_tick_size_y = {}
	  from_tick_size_y.min = -5/512
	  from_tick_size_y.max =  5/512
local from_tick_start = {}
	  from_tick_start.x = 310/512
	  from_tick_start.y = 360/512
	  
local goto_tick_size_x = {}
	  goto_tick_size_x.min = -20/512
	  goto_tick_size_x.max =  10/512
local goto_tick_size_y = from_tick_size_y
local goto_tick_start = {}
	  goto_tick_start.x = 320/512
	  goto_tick_start.y = 375/512

 


local cursor_size             =  abris_font[2][1] + abris_font[2][4]
local cursor_size_scaled      =  cursor_size/GetScale()
current					 = CreateElement "ceMeshPoly"
current.name			 = "cwpt_"
current.primitivetype    = "triangles"
current.vertices	= {{0, 0.7*cursor_size_scaled/2},
					   {2*x_size, 0.7*cursor_size_scaled/2},
					   {2*x_size,-0.7*cursor_size_scaled/2},
					   {0,-0.7*cursor_size_scaled/2}}
current.indices     = box_ind
current.material	= "GREEN"
current.init_pos    = {0,-0.5*new_delta,0}			   
current.controllers = {{"journal_segment_current_segment"},
					   {"current_menu_in_list_position",-4*new_delta*GetScale()}}
SetDefaultClipWithLevel(current, 3)
Add(current)
use_mipfilter(current)


journal_segment_current_data_goto			   	 = CreateElement "ceTexPoly"
journal_segment_current_data_goto.name           = "jscdg_"
journal_segment_current_data_goto.material       = "INDICATION_ABRIS_BLACK"
journal_segment_current_data_goto.vertices       = {{tick_scale.x * goto_tick_size_x.min/scale_2,tick_scale.y * goto_tick_size_y.max/scale_2},
													{tick_scale.x * goto_tick_size_x.max/scale_2,tick_scale.y * goto_tick_size_y.max/scale_2},
													{tick_scale.x * goto_tick_size_x.max/scale_2,tick_scale.y * goto_tick_size_y.min/scale_2},
													{tick_scale.x * goto_tick_size_x.min/scale_2,tick_scale.y * goto_tick_size_y.min/scale_2}} 
journal_segment_current_data_goto.indices        = box_ind
journal_segment_current_data_goto.tex_params     = {goto_tick_start.x,goto_tick_start.y,scale_2/tick_scale.x,scale_2/tick_scale.y}
journal_segment_current_data_goto.init_pos		 = {1.5 * new_delta,0,0}
journal_segment_current_data_goto.parent_element =  current.name
SetDefaultClipWithLevel(journal_segment_current_data_goto, 3)
Add(journal_segment_current_data_goto)
use_mipfilter(journal_segment_current_data_goto)


journal_segment_current_data_from			   	 = CreateElement "ceTexPoly"
journal_segment_current_data_from.name           = "jscdf_"
journal_segment_current_data_from.material       = "INDICATION_ABRIS_WHITE"
journal_segment_current_data_from.vertices       = {{tick_scale.x * from_tick_size_x.min/scale_2,tick_scale.y * from_tick_size_y.max/scale_2},
													{tick_scale.x * from_tick_size_x.max/scale_2,tick_scale.y * from_tick_size_y.max/scale_2},
													{tick_scale.x * from_tick_size_x.max/scale_2,tick_scale.y * from_tick_size_y.min/scale_2},
													{tick_scale.x * from_tick_size_x.min/scale_2,tick_scale.y * from_tick_size_y.min/scale_2}} 
journal_segment_current_data_from.indices        = box_ind
journal_segment_current_data_from.tex_params     = {from_tick_start.x,from_tick_start.y,scale_2/tick_scale.x,scale_2/tick_scale.y}
journal_segment_current_data_from.init_pos		 = {-0.2*new_delta,4*new_delta,0}
journal_segment_current_data_from.parent_element = journal_segment_current_data_goto.name
--journal_segment_current_data_from.level		    = DEFAULT_LEVEL + 3
--journal_segment_current_data_from.h_clip_relation = h_clip_relations.COMPARE
SetDefaultClipWithLevel(journal_segment_current_data_from, 3)
Add(journal_segment_current_data_from)
use_mipfilter(journal_segment_current_data_from)

txt_journal_segment_current_data_goto			   	 = CreateElement "ceStringPoly"
txt_journal_segment_current_data_goto.name           = "tjscdg_"
txt_journal_segment_current_data_goto.material       = "font_Ka-50_ABRIS_GREEN"
txt_journal_segment_current_data_goto.alignment      = "RightCenter"
txt_journal_segment_current_data_goto.stringdefs     = abris_font[7]
txt_journal_segment_current_data_goto.value          = LOCALIZE("НА")
txt_journal_segment_current_data_goto.parent_element = journal_segment_current_data_goto.name
txt_journal_segment_current_data_goto.init_pos		 = {0,0.08*new_delta,0}
SetDefaultClipWithLevel(txt_journal_segment_current_data_goto, 3)
Add(txt_journal_segment_current_data_goto)
use_mipfilter(txt_journal_segment_current_data_goto)

txt_journal_segment_current_data_from   			 = CreateElement "ceStringPoly"
txt_journal_segment_current_data_from.name           = "tjscdf_"
txt_journal_segment_current_data_from.material       = "font_Ka-50_ABRIS_BLACK"
txt_journal_segment_current_data_from.alignment      = "LeftCenter"
txt_journal_segment_current_data_from.stringdefs     = abris_font[7]
txt_journal_segment_current_data_from.value          = LOCALIZE("ОТ")
txt_journal_segment_current_data_from.parent_element = journal_segment_current_data_from.name
txt_journal_segment_current_data_from.init_pos		 = {0,0.08*new_delta,0}
--txt_journal_segment_current_data_from.level		      = DEFAULT_LEVEL + 3
--txt_journal_segment_current_data_from.h_clip_relation = h_clip_relations.COMPARE
SetDefaultClipWithLevel(txt_journal_segment_current_data_from, 3)
Add(txt_journal_segment_current_data_from)
use_mipfilter(txt_journal_segment_current_data_from)

-------------------------------------------------------------------------------------

txt_journal_segment_data = {}
txt_journal_segment_data[1]			   	   = CreateElement "ceStringPoly"
txt_journal_segment_data[1].name             = "jsd_1_"
txt_journal_segment_data[1].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[1].init_pos		 = {x_size + x_pos[1],0.0*new_delta,0}
txt_journal_segment_data[1].alignment        = "CenterTop"
txt_journal_segment_data[1].stringdefs       = abris_font[3]
txt_journal_segment_data[1].formats			 = {"%02d"}
txt_journal_segment_data[1].controllers      ={{"current_menu_in_list_position",-4*new_delta*GetScale()},
											   {"current_menu_item_number",0},
											   --{"current_waypoint_change_color",0,0,0}
											   }
SetDefaultClipWithLevel(txt_journal_segment_data[1], 3)
Add(txt_journal_segment_data[1])
use_mipfilter(txt_journal_segment_data[1])

-------------------------------------------------------------------------------------

txt_journal_segment_data[2]			   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[2].name             = "jsd_2_"
txt_journal_segment_data[2].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[2].init_pos		 = {0,-0.08*new_delta,0}
txt_journal_segment_data[2].alignment        = "LeftTop"
txt_journal_segment_data[2].stringdefs       = abris_font[7]
txt_journal_segment_data[2].formats			 = {"  %s"}
txt_journal_segment_data[2].controllers      = {{"journal_segment_end_point_name",0},
												{"current_menu_item_change_color",0,0,0}
												--, {"current_waypoint_change_color",0,0,0}
												}
txt_journal_segment_data[2].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[2], 3)
Add(txt_journal_segment_data[2])
use_mipfilter(txt_journal_segment_data[2])

txt_journal_segment_data[3]			   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[3].name             = "jsd_3_"
txt_journal_segment_data[3].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[3].init_pos		 = {0.41,0,0}
txt_journal_segment_data[3].alignment        = "LeftTop"
txt_journal_segment_data[3].stringdefs       = abris_font[3]
txt_journal_segment_data[3].formats          = {"%s"," %s"}
txt_journal_segment_data[3].controllers      = {{"journal_segment_end_point_latitude" ,0},
										    	{"journal_segment_end_point_longitude",1},
												{"current_menu_item_change_color",0,0,0}
												--,{"current_waypoint_change_color",0,0,0}
												}
txt_journal_segment_data[3].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[3], 3)
Add(txt_journal_segment_data[3])
use_mipfilter(txt_journal_segment_data[3])

txt_journal_segment_data[4]			   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[4].name             = "jsd_4_"
txt_journal_segment_data[4].material         = "font_Ka-50_ABRIS_WHITE_INVERSE"
txt_journal_segment_data[4].init_pos		 = {0.33,0.1*new_delta,0}
txt_journal_segment_data[4].alignment        = "CenterTop"
txt_journal_segment_data[4].stringdefs       = abris_font[3]
txt_journal_segment_data[4].formats			 = {"%s"}
txt_journal_segment_data[4].controllers      ={{"journal_segment_end_point_type",0}}
txt_journal_segment_data[4].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[4], 3)
Add(txt_journal_segment_data[4])
use_mipfilter(txt_journal_segment_data[4])

----------------------------------------------------------------------------------------------

txt_journal_segment_data[5]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[5].name             = "jsd_5_"
txt_journal_segment_data[5].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[5].init_pos		 = {x_pos[4] - x_pos[1],new_delta,0}
txt_journal_segment_data[5].alignment        = "RightTop"
txt_journal_segment_data[5].stringdefs       = abris_font[3]
txt_journal_segment_data[5].formats          = {"%3.1f "}
txt_journal_segment_data[5].controllers      = {{"journal_segment_remained_route_length",0},
												{"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[5].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[5], 3)
Add(txt_journal_segment_data[5])
use_mipfilter(txt_journal_segment_data[5])


txt_journal_segment_data[6]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[6].name             = "jsd_6_"
txt_journal_segment_data[6].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[6].init_pos		 = {x_pos[4] - x_pos[1],3*new_delta,0}
txt_journal_segment_data[6].alignment        = "RightTop"
txt_journal_segment_data[6].stringdefs       = abris_font[3]
txt_journal_segment_data[6].formats          = {"%3.1f "}
txt_journal_segment_data[6].controllers      = {{"journal_segment_length",0},
												{"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[6].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[6], 3)
Add(txt_journal_segment_data[6])
use_mipfilter(txt_journal_segment_data[6])

----------------------------------------------------------------------------------------------

txt_journal_segment_data[7]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[7].name             = "jsd_7_"
txt_journal_segment_data[7].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[7].init_pos		 = {0,new_delta,0}
txt_journal_segment_data[7].alignment        = "RightTop"
txt_journal_segment_data[7].stringdefs       = abris_font[3]
txt_journal_segment_data[7].formats          = {"%03.f° "}
txt_journal_segment_data[7].controllers      = {{"journal_segment_track_angle",0},
												{"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[7].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[7], 3)
Add(txt_journal_segment_data[7])
use_mipfilter(txt_journal_segment_data[7])


txt_journal_segment_data[8]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[8].name             = "jsd_8_"
txt_journal_segment_data[8].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[8].init_pos		 = {0,3*new_delta,0}
txt_journal_segment_data[8].alignment        = "RightTop"
txt_journal_segment_data[8].stringdefs       = abris_font[3]
txt_journal_segment_data[8].formats          = {"%03.f° "}
txt_journal_segment_data[8].controllers      = {{"journal_segment_heading_angle",0},
												{"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[8].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[8], 3)
Add(txt_journal_segment_data[8])
use_mipfilter(txt_journal_segment_data[8])

-----------------------------------------------------------------------------------------------

txt_journal_segment_data[9]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[9].name             = "jsd_9_"
txt_journal_segment_data[9].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[9].init_pos		 = {x_pos[2] - x_pos[1],3*new_delta,0}
txt_journal_segment_data[9].alignment        = "RightTop"
txt_journal_segment_data[9].stringdefs       = abris_font[3]
txt_journal_segment_data[9].formats          = {"%03.f°"}
txt_journal_segment_data[9].controllers      = {{"journal_segment_preset_wind_direction",0},
												{"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[9].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[9], 3)
Add(txt_journal_segment_data[9])
use_mipfilter(txt_journal_segment_data[9])


txt_journal_segment_data[10]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[10].name             = "jsd_10_"
txt_journal_segment_data[10].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[10].init_pos		 = {x_pos[2] - x_pos[1],new_delta,0}
txt_journal_segment_data[10].alignment        = "RightTop"
txt_journal_segment_data[10].stringdefs       = abris_font[3]
txt_journal_segment_data[10].formats          = {"%03.f "}
txt_journal_segment_data[10].controllers      = {{"journal_segment_preset_wind_speed",0},
												 {"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[10].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[10], 3)
Add(txt_journal_segment_data[10])
use_mipfilter(txt_journal_segment_data[10])

------------------------------------------------------------------------------------------------

txt_journal_segment_data[11]	  		   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[11].name             = "jsd_11_"
txt_journal_segment_data[11].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[11].init_pos		  = {x_pos[5] - x_pos[1],new_delta,0}
txt_journal_segment_data[11].alignment        = "RightTop"
txt_journal_segment_data[11].stringdefs       = abris_font[3]
txt_journal_segment_data[11].formats          = {"%02.f:%02.f ","--:--"}
txt_journal_segment_data[11].controllers      = {{"journal_segment_estimated_time_over_target",0,1},
												 {"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[11].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[11], 3)
Add(txt_journal_segment_data[11])
use_mipfilter(txt_journal_segment_data[11])

txt_journal_segment_data[12]	  		   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[12].name             = "jsd_12_"
txt_journal_segment_data[12].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[12].init_pos		  = {x_pos[5] - x_pos[1],2*new_delta,0}
txt_journal_segment_data[12].alignment        = "RightTop"
txt_journal_segment_data[12].stringdefs       = abris_font[3]
txt_journal_segment_data[12].formats          = {"%02.f:%02.f ","--:--"}
txt_journal_segment_data[12].controllers      = {{"journal_segment_preset_time_over_target",0,1},
												 {"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[12].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[12], 3)
Add(txt_journal_segment_data[12])
use_mipfilter(txt_journal_segment_data[12])

txt_journal_segment_data[13]	  		   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[13].name             = "jsd_13_"
txt_journal_segment_data[13].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[13].init_pos		  = {x_pos[5] - x_pos[1],3*new_delta,0}
txt_journal_segment_data[13].alignment        = "RightTop"
txt_journal_segment_data[13].stringdefs       = abris_font[3]
txt_journal_segment_data[13].formats          = {"%02.f:%02.f ","--:--"}
txt_journal_segment_data[13].controllers      = {{"journal_segment_preset_flight_time",0,1},
												 {"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[13].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[13], 3)
Add(txt_journal_segment_data[13])
use_mipfilter(txt_journal_segment_data[13])

--------------------------------------------------------------------------------------------------------------

txt_journal_segment_data[14]	  		   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[14].name             = "jsd_14_"
txt_journal_segment_data[14].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[14].init_pos		  = {x_pos[3] - x_pos[1],new_delta,0}
txt_journal_segment_data[14].alignment        = "RightTop"
txt_journal_segment_data[14].stringdefs       = abris_font[3]
txt_journal_segment_data[14].formats          = {"%03.f "}
txt_journal_segment_data[14].controllers      = {{"journal_segment_ground_speed",0},
												 {"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[14].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[14], 3)
Add(txt_journal_segment_data[14])
use_mipfilter(txt_journal_segment_data[14])

txt_journal_segment_data[15]	  		   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[15].name             = "jsd_15_"
txt_journal_segment_data[15].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[15].init_pos		  = {x_pos[3] - x_pos[1],3*new_delta,0}
txt_journal_segment_data[15].alignment        = "RightTop"
txt_journal_segment_data[15].stringdefs       = abris_font[3]
txt_journal_segment_data[15].formats          = {"%03.f "}
txt_journal_segment_data[15].controllers      = {{"journal_segment_true_speed",0},
												 {"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[15].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[15], 3)
Add(txt_journal_segment_data[15])
use_mipfilter(txt_journal_segment_data[15])

--------------------------------------------------------------------------------------------------------------

txt_journal_segment_data[16]	  		   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[16].name             = "jsd_16_"
txt_journal_segment_data[16].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[16].init_pos		  = {x_pos[6] - x_pos[1],new_delta,0}
txt_journal_segment_data[16].alignment        = "RightTop"
txt_journal_segment_data[16].stringdefs       = abris_font[3]
txt_journal_segment_data[16].formats          = {"%6.f ", "------"}
txt_journal_segment_data[16].controllers      = {{"journal_segment_estimated_remaining_fuel",0,1},
												 {"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[16].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[16], 3)
Add(txt_journal_segment_data[16])
use_mipfilter(txt_journal_segment_data[16])

txt_journal_segment_data[17]	  		   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[17].name             = "jsd_17_"
txt_journal_segment_data[17].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[17].init_pos		  = {x_pos[6] - x_pos[1],2*new_delta,0}
txt_journal_segment_data[17].alignment        = "RightTop"
txt_journal_segment_data[17].stringdefs       = abris_font[3]
txt_journal_segment_data[17].formats          = {"%6.f "}
txt_journal_segment_data[17].controllers      = {{"journal_segment_preset_fuel_consumption",0},
												 {"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[17].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[17], 3)
Add(txt_journal_segment_data[17])
use_mipfilter(txt_journal_segment_data[17])

--------------------------------------------------------------------------------------------------------------

txt_journal_segment_data[18]	  		   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[18].name             = "jsd_18_"
txt_journal_segment_data[18].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[18].init_pos		  = {x_pos[6] - x_pos[1],3*new_delta,0}
txt_journal_segment_data[18].alignment        = "LeftTop"
txt_journal_segment_data[18].stringdefs       = abris_font[7]
txt_journal_segment_data[18].formats          = {"%5.f"}
txt_journal_segment_data[18].controllers      = {{"journal_segment_preset_flight_level",0},
												 {"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[18].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[18], 3)
Add(txt_journal_segment_data[18])
use_mipfilter(txt_journal_segment_data[18])

txt_journal_segment_data[19]	  		   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[19].name             = "jsd_19_"
txt_journal_segment_data[19].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[19].init_pos		  = {0.99*x_size- x_pos[1],new_delta,0}
txt_journal_segment_data[19].alignment        = "RightTop"
txt_journal_segment_data[19].stringdefs       = abris_font[8]
txt_journal_segment_data[19].formats          = {"%+3.f°C"}
txt_journal_segment_data[19].controllers      = {{"journal_segment_preset_atmospheric_temperature",0},
												 {"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[19].parent_element   = txt_journal_segment_data[1].name
--SetDefaultClipWithLevel(txt_journal_segment_data[19], 3)
Add(txt_journal_segment_data[19])
use_mipfilter(txt_journal_segment_data[19])


--------------------------------------------------------------------------------------------------------------


