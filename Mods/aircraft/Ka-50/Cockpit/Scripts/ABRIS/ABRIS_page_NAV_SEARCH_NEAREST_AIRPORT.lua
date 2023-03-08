dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
txt_2			   	  = CreateElement "ceStringPoly"
txt_2.name            = "txt_2"
txt_2.material        = "font_Ka-50_ABRIS_WHITE"
txt_2.stringdefs      = abris_font[3]
txt_2.init_pos		  =  {0,y_center_render - y_render_size -new_delta + 0.15*new_delta,0}
txt_2.value           = LOCALIZE("БЛИЖАЙШИЕ").." "..LOCALIZE("АЭРОДРОМЫ")
txt_2.alignment       = "CenterBottom"
use_mipfilter(txt_2)
Add(txt_2)
