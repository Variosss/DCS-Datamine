dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")


NO_STR = LOCALIZE("НЕТ")


txt_data_onboardloader			   	= CreateElement "ceStringPoly"
txt_data_onboardloader.name         = "txt_data_onboardloader"
txt_data_onboardloader.material     = "font_Ka-50_ABRIS_GREEN"
txt_data_onboardloader.init_pos		= {-0.98*x_size,0.97*y_size - (y_size - up_line_pos[2]),0}
txt_data_onboardloader.value        = LOCALIZE("БОРТОВОЙ ЗАГРУЗЧИК")
txt_data_onboardloader.alignment    = "LeftTop"
txt_data_onboardloader.stringdefs   = abris_font[2]
Add(txt_data_onboardloader)
use_mipfilter(txt_data_onboardloader)

down_line                = CreateElement "ceTexPoly"
down_line.name           = "down_line"
SetLine(down_line)
down_line.init_pos       = {0.98*x_size,(-10*(abris_font[2][1] + abris_font[2][4]) - 0.4*abris_font[2][1])/GetScale(),0}
down_line.parent_element = "txt_data_onboardloader"
Add(down_line)


txt_data_onboardstore			     = CreateElement "ceStringPoly"
txt_data_onboardstore.name           = "txt_data_onboardstore"
txt_data_onboardstore.material       = "font_Ka-50_ABRIS_GREEN"
txt_data_onboardstore.init_pos		 = {-0.98*x_size,-0.4*abris_font[2][1]/GetScale(),0}
txt_data_onboardstore.value          = LOCALIZE("БОРТОВОЙ НАКОПИТЕЛЬ")
txt_data_onboardstore.alignment      = "LeftTop"
txt_data_onboardstore.stringdefs     = abris_font[2]
txt_data_onboardstore.parent_element =  "down_line"
Add(txt_data_onboardstore)
use_mipfilter(txt_data_onboardstore)

down_line2                = CreateElement "ceTexPoly"
down_line2.name           = "down_line2"
SetLine(down_line2)
down_line2.init_pos       = {0.98*x_size,(-11*(abris_font[2][1] + abris_font[2][4]) - 0.4*abris_font[2][1])/GetScale(),0}
down_line2.parent_element = "txt_data_onboardstore"
Add(down_line2)


database_item_names = 
{
LOCALIZE("НАВИГАЦИЯ"),
LOCALIZE("ТОПОГРАФИЯ"),
LOCALIZE("КОМП.МАРШРУТЫ"),
LOCALIZE("ДОП.ИНФОРМАЦИЯ"),
LOCALIZE("РЕЛЬЕФ"),
LOCALIZE("ТТХ"),
LOCALIZE("МАРШРУТЫ"),
LOCALIZE("МЕТЕО"),
LOCALIZE("МОРСКИЕ КАРТЫ")
}

local y_diplacement = (abris_font[2][1] + abris_font[2][4] )/GetScale()
------------------------------------------------------------------------------------------------------------------------------------

txt_database = {}
txt_database_absent_status = {}
txt_database_value = {}
txt_database_freshness = {}

for i =1,9 do

txt_database[i] 		 		= CreateElement "ceStringPoly"
txt_database[i].name    		= "txt_database"..database_item_names[i] 
txt_database[i].material        = "font_Ka-50_ABRIS_WHITE"
txt_database[i].init_pos		= {0,-y_diplacement - (i - 1)*y_diplacement,0}
txt_database[i].value           = database_item_names[i]
txt_database[i].alignment       = "LeftTop"
txt_database[i].stringdefs      = abris_font[2]
txt_database[i].parent_element  = txt_data_onboardloader.name
Add(txt_database[i])
use_mipfilter(txt_database[i])

txt_database_freshness[i]				= CreateElement "ceStringPoly"
txt_database_freshness[i].name    		= "freshness"..database_item_names[i] 
txt_database_freshness[i].material      = "font_Ka-50_ABRIS_WHITE"
txt_database_freshness[i].init_pos		= {0.98*x_size + 0.3*x_size,0,0}
txt_database_freshness[i].formats       = {"%02.f:%02.f:%04.f"}
txt_database_freshness[i].alignment     = "LeftTop"
txt_database_freshness[i].stringdefs    = abris_font[2]
txt_database_freshness[i].controllers    = {{"database_item_date"   ,0,1  ,i-1},
                                            {"database_item_state"  ,1,i-1,1},
                                            {"database_item_expired",1,i-1}}
txt_database_freshness[i].parent_element= txt_database[i].name
Add(txt_database_freshness[i])
use_mipfilter(txt_database_freshness[i])


txt_database_value[i]				 = CreateElement "ceStringPoly"
txt_database_value[i].name    		 = "value"..database_item_names[i] 
txt_database_value[i].material       = "font_Ka-50_ABRIS_WHITE"
txt_database_value[i].init_pos		 = {0.98*x_size,0,0}
txt_database_value[i].formats        = {"%s"}
txt_database_value[i].alignment      = "LeftTop"
txt_database_value[i].stringdefs     = abris_font[2]
txt_database_value[i].controllers    = {{"database_item_value",0,1,i-1},{"database_item_state",1,i-1,1}}
txt_database_value[i].parent_element = txt_database[i].name
Add(txt_database_value[i])
use_mipfilter(txt_database_value[i])


txt_database_absent_status[i]				 = CreateElement "ceStringPoly"
txt_database_absent_status[i].name    		 = "absent"..database_item_names[i] 
txt_database_absent_status[i].material       = "font_Ka-50_ABRIS_RED"
txt_database_absent_status[i].init_pos		 = {0.98*x_size,0,0}
txt_database_absent_status[i].value          = NO_STR
txt_database_absent_status[i].alignment      = "LeftTop"
txt_database_absent_status[i].stringdefs     = abris_font[2]
txt_database_absent_status[i].controllers    = {{"database_item_state",1,i-1,0}}
txt_database_absent_status[i].parent_element = txt_database[i].name
Add(txt_database_absent_status[i])
use_mipfilter(txt_database_absent_status[i])

end


for i =1,9 do

txt_database[9 + i] 		 		= CreateElement "ceStringPoly"
txt_database[9 + i].name    		= "txt_database_store"..database_item_names[i] 
txt_database[9 + i].material        = "font_Ka-50_ABRIS_WHITE"
txt_database[9 + i].init_pos		= {0,-y_diplacement - (i - 1)*y_diplacement,0}
txt_database[9 + i].value           = database_item_names[i]
txt_database[9 + i].alignment       = "LeftTop"
txt_database[9 + i].stringdefs      = abris_font[2]
txt_database[9 + i].parent_element  = txt_data_onboardstore.name
Add(txt_database[9 + i])
use_mipfilter(txt_database[9 + i])

txt_database_freshness[9 + i]				= CreateElement "ceStringPoly"
txt_database_freshness[9 + i].name    		= "freshness_store"..database_item_names[i] 
txt_database_freshness[9 + i].material      = "font_Ka-50_ABRIS_WHITE"
txt_database_freshness[9 + i].init_pos		= {0.98*x_size + 0.3*x_size,0,0}
txt_database_freshness[9 + i].formats       = {"%02.f:%02.f:%04.f"}
txt_database_freshness[9 + i].alignment     = "LeftTop"
txt_database_freshness[9 + i].stringdefs    = abris_font[2]
txt_database_freshness[9 + i].controllers    = {{"database_item_date" ,0,0  ,i-1},
                                                {"database_item_state",0,i-1,1},
                                                {"database_item_expired",0  ,i-1}}
txt_database_freshness[9 + i].parent_element= txt_database[9 + i].name
Add(txt_database_freshness[9 + i])
use_mipfilter(txt_database_freshness[9 + i])


txt_database_value[9 + i]				 = CreateElement "ceStringPoly"
txt_database_value[9 + i].name    		 = "value_store"..database_item_names[i] 
txt_database_value[9 + i].material       = "font_Ka-50_ABRIS_WHITE"
txt_database_value[9 + i].init_pos		 = {0.98*x_size,0,0}
txt_database_value[9 + i].formats        = {"%s"}
txt_database_value[9 + i].alignment      = "LeftTop"
txt_database_value[9 + i].stringdefs     = abris_font[2]
txt_database_value[9 + i].controllers    = {{"database_item_value",0,0,i-1},{"database_item_state",0,i-1,1}}
txt_database_value[9 + i].parent_element = txt_database[9 + i].name
Add(txt_database_value[9 + i])
use_mipfilter(txt_database_value[9 + i])


txt_database_absent_status[9 + i]				 = CreateElement "ceStringPoly"
txt_database_absent_status[9 + i].name    		 = "absent_store"..database_item_names[i] 
txt_database_absent_status[9 + i].material       = "font_Ka-50_ABRIS_RED"
txt_database_absent_status[9 + i].init_pos		 = {0.98*x_size,0,0}
txt_database_absent_status[9 + i].value          = NO_STR
txt_database_absent_status[9 + i].alignment      = "LeftTop"
txt_database_absent_status[9 + i].stringdefs     = abris_font[2]
txt_database_absent_status[9 + i].controllers    = {{"database_item_state",0,i-1,0}}
txt_database_absent_status[9 + i].parent_element = txt_database[9 + i].name
Add(txt_database_absent_status[9 + i])
use_mipfilter(txt_database_absent_status[9 + i])

end
------------------------------------------------------------------------------------------------------------------------------------
