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
txt_mrk.formats     = {"MRK %s",
					   " %s\n",
					   LOCALIZE("ВЫС").." %.f\n",
					   LOCALIZE("СКЛ").." %.1f°"}
txt_mrk.controllers = {{"txt_cursor_latitude",0},
					   {"txt_cursor_longitude",1},
					   {"txt_cursor_surface_height",2},
					   {"txt_cursor_magnetic_variation",3}}
Add(txt_mrk)
use_mipfilter(txt_mrk)

---------------------------------------------------------------------------------------
AddCursor(true,"RED")
---------------------------------------------------------------------------------------
