dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
AddButtons("ИНФО","МЕРИТЬ","МСШТБ+","МСШТБ-","НАВ")

middle_line_cur             = CreateElement "ceTexPoly"
middle_line_cur.name		= "middle_line_cur"
SetLineSized(middle_line_cur,0,1.3*x_size)
middle_line_cur.init_pos	= {-0.3*x_size,y_center_render - y_render_size - size_mrk,0}
Add(middle_line_cur)
---------------------------------------------------------------------------------------
txt_mrk             = CreateElement "ceStringPoly"
txt_mrk.name        = "txt_mrk"
txt_mrk.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk.alignment   = "LeftTop"
txt_mrk.stringdefs  = abris_font[5] 
txt_mrk.init_pos    = {-0.29*x_size,y_center_render - y_render_size,0}
txt_mrk.formats     = {"MRK:%s"," %s\n",
					   "ERB:%s"," %s\n",
					   "BRG:%03.f°/","%03.f°\n",
					   "DST:%.2f\n",
					   LOCALIZE("ВЫС")..":    %.f\n",
					   LOCALIZE("ВЫС")..":MRK:%.f\n",
					   LOCALIZE("СКЛ").." %.1f°"}
					   		   
txt_mrk.controllers = {	{"txt_cursor_marker_latitude" 		 ,0},
						{"txt_cursor_marker_longitude"		 ,1},
						{"txt_cursor_latitude"        		 ,2},
						{"txt_cursor_longitude"       		 ,3},
						{"txt_cursor_marker_bearing"  		 ,4},
						{"txt_cursor_marker_bearing"  		 ,5,1},
						{"txt_cursor_segment_length"  		 ,6},
						{"txt_cursor_surface_height"  		 ,7},
						{"txt_cursor_marker_surface_height"  ,8},
						{"txt_cursor_magnetic_variation"	 ,9}}
						
						
Add(txt_mrk)
use_mipfilter(txt_mrk)

---------------------------------------------------------------------------------------
cursor_segment				   = CreateElement "ceSimpleLineObject"
cursor_segment.primitivetype   = "triangles"
cursor_segment.name            = "cursor_segment"
cursor_segment.material	       = "RED"
cursor_segment.width           = 0.004 
cursor_segment.init_pos        = {0,y_center_render,0}
SetDefaultClipWithLevel(cursor_segment,3)
cursor_segment.controllers     = {{"cursor_segment",x_size,x_size}}
Add(cursor_segment)
use_mipfilter(cursor_segment)

---------------------------------------------------------------------------------------
AddCursor(false,"RED")
---------------------------------------------------------------------------------------
cursor_marker                = CreateElement "ceTexPoly"
cursor_marker.name           = "cursor_marker"
cursor_marker.vertices       = { {-solid_beacon_wpt.x_sz/scale_wpt,solid_beacon_wpt.y_sz_pl/scale_wpt},
							     { solid_beacon_wpt.x_sz/scale_wpt,solid_beacon_wpt.y_sz_pl/scale_wpt},
							     { solid_beacon_wpt.x_sz/scale_wpt,-solid_beacon_wpt.y_sz_mi/scale_wpt},
							     {-solid_beacon_wpt.x_sz/scale_wpt,-solid_beacon_wpt.y_sz_mi/scale_wpt}}
cursor_marker.indices        = box_ind
cursor_marker.material       = "INDICATION_ABRIS_RED"
cursor_marker.tex_params	 = {solid_beacon_wpt.x_st,solid_beacon_wpt.y_st,scale_wpt,scale_wpt}
cursor_marker.controllers    = {{"cursor_marker",x_size,x_size}}
cursor_marker.parent_element = "cursor_segment"
SetDefaultClipWithLevel(cursor_marker,3)
Add(cursor_marker)
use_mipfilter(cursor_marker)

--------------------------------------------------------------------------------------