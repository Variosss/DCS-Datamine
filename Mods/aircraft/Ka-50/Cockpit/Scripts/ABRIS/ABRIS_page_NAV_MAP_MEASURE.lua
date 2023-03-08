dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
AddButtons("ИНФО","МАРКЕР","МСШТБ+","МСШТБ-","НАВ")
---------------------------------------------------------------------------------------
txt_mrk             = CreateElement "ceStringPoly"
txt_mrk.name        = "txt_mrk"
txt_mrk.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk.alignment   = "LeftTop"
txt_mrk.stringdefs  = abris_font[5]
txt_mrk.init_pos    = {-0.29*x_size,y_center_render - y_render_size,0}
txt_mrk.formats     = {"ERB:%s"," %s\n",
					   "BRG:%03.f°/","%03.f°\n",
					   "DST:%.2f\n",
					   LOCALIZE("ВЫС")..":%.f\n",
					   LOCALIZE("СКЛ")..":%.1f°"
					   }
				   
txt_mrk.controllers = {{"txt_cursor_latitude",0},
                       {"txt_cursor_longitude",1},
                       {"txt_cursor_marker_bearing",2},
                       {"txt_cursor_marker_bearing",3,1},
                       {"txt_cursor_segment_length",4},
					   {"txt_cursor_surface_height",5},
					   {"txt_cursor_magnetic_variation",6}}
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
