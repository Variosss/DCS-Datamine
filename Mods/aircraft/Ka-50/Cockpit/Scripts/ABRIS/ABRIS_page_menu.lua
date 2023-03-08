dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

AddButtons("ОПЦИИ","УПРАВ","ПЛАН","СНС","НАВ")
AddMode("МЕНЮ")

up_line          = CreateElement "ceTexPoly"
up_line.name     = "up_line"
SetLine(up_line)
up_line.init_pos = up_line_pos
Add(up_line)

down_line          = CreateElement "ceTexPoly"
down_line.name     = "down_line"
SetLine(down_line)
down_line.init_pos = {0,0,0}
Add(down_line)

txt_data_data			   	 = CreateElement "ceStringPoly"
txt_data_data.name            = "txt_data_data"
txt_data_data.material        = "font_Ka-50_ABRIS_GREEN"
txt_data_data.init_pos		 = {-0.98*x_size,0.9*y_size,0}
txt_data_data.value           = LOCALIZE("ДАННЫЕ")
txt_data_data.alignment       = "LeftTop"
txt_data_data.stringdefs      = abris_font[2]
Add(txt_data_data)
use_mipfilter(txt_data_data)


txt_data_value			   	   = CreateElement "ceStringPoly"
txt_data_value.name            = "txt_data_value"
txt_data_value.material        = "font_Ka-50_ABRIS_WHITE"
txt_data_value.init_pos		   = {-0.2*x_size,0.9*y_size,0}
txt_data_value.value           = LOCALIZE("ЧИСЛО")..":"
txt_data_value.alignment       = "LeftTop"
txt_data_value.stringdefs      = abris_font[2]
Add(txt_data_value)
use_mipfilter(txt_data_value)

txt_data_date			   	 = CreateElement "ceStringPoly"
txt_data_date.name            = "txt_data_date"
txt_data_date.material        = "font_Ka-50_ABRIS_WHITE"
txt_data_date.init_pos		 = {0.4*x_size,0.9*y_size,0}
txt_data_date.alignment       = "LeftTop"
txt_data_date.formats         = {"%02.f:%02.f:%04.f"}
txt_data_date.controllers	 = {{"txt_date",0}}
txt_data_date.stringdefs      = abris_font[2]
Add(txt_data_date)
use_mipfilter(txt_data_date)

NO_STR = LOCALIZE("НЕТ")

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
txt_database[i].parent_element  = txt_data_data.name
SetDefaultClipWithLevel(txt_database[i],2)
Add(txt_database[i])
use_mipfilter(txt_database[i])

txt_database_freshness[i]				= CreateElement "ceStringPoly"
txt_database_freshness[i].name    		= "freshness"..database_item_names[i] 
txt_database_freshness[i].material      = "font_Ka-50_ABRIS_WHITE"
txt_database_freshness[i].init_pos		= {0.98*x_size + 0.4*x_size,-0.0 * y_size,0}
txt_database_freshness[i].formats       = {"%02.f:%02.f:%04.f"}
txt_database_freshness[i].alignment     = "LeftTop"
txt_database_freshness[i].stringdefs    = abris_font[2]
txt_database_freshness[i].controllers    = {{"database_item_date"   ,0,0  ,i-1},
                                            {"database_item_state"  ,0,i-1,1},
                                            {"database_item_expired"  ,0  ,i-1}}
txt_database_freshness[i].parent_element= txt_database[i].name
SetDefaultClipWithLevel(txt_database_freshness[i],2)
Add(txt_database_freshness[i])
use_mipfilter(txt_database_freshness[i])


txt_database_value[i]				 = CreateElement "ceStringPoly"
txt_database_value[i].name    		 = "value"..database_item_names[i] 
txt_database_value[i].material       = "font_Ka-50_ABRIS_WHITE"
txt_database_value[i].init_pos		 = {0.98*x_size,0,0}
txt_database_value[i].formats        = {"%s"}
txt_database_value[i].alignment      = "LeftTop"
txt_database_value[i].stringdefs     = abris_font[2]
txt_database_value[i].controllers    = {{"database_item_value",0,0,i-1},
										{"database_item_state",0,i-1,1}}
txt_database_value[i].parent_element = txt_database[i].name
SetDefaultClipWithLevel(txt_database_value[i],2)
Add(txt_database_value[i])
use_mipfilter(txt_database_value[i])


txt_database_absent_status[i]				 = CreateElement "ceStringPoly"
txt_database_absent_status[i].name    		 = "absent"..database_item_names[i] 
txt_database_absent_status[i].material       = "font_Ka-50_ABRIS_RED"
txt_database_absent_status[i].init_pos		 = {0.98*x_size,0,0}
txt_database_absent_status[i].value          = NO_STR
txt_database_absent_status[i].alignment      = "LeftTop"
txt_database_absent_status[i].stringdefs     = abris_font[2]
txt_database_absent_status[i].controllers    = {{"database_item_state",0,i-1,0}}
txt_database_absent_status[i].parent_element = txt_database[i].name
SetDefaultClipWithLevel(txt_database_absent_status[i],2)
Add(txt_database_absent_status[i])
use_mipfilter(txt_database_absent_status[i])

end



---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


txt_NAV_SENSORS			   	    = CreateElement "ceStringPoly"
txt_NAV_SENSORS.name            = "txt_NAV_SENSORS"
txt_NAV_SENSORS.material        = "font_Ka-50_ABRIS_GREEN"
txt_NAV_SENSORS.init_pos		= {-0.98*x_size,0,0}
txt_NAV_SENSORS.value           = LOCALIZE("НАВ.ДАТЧИКИ")
txt_NAV_SENSORS.alignment       = "LeftTop"
txt_NAV_SENSORS.stringdefs      = abris_font[2]
Add(txt_NAV_SENSORS)
use_mipfilter(txt_NAV_SENSORS)

txt_NAV_SENSORS_current			   	    = CreateElement "ceStringPoly"
txt_NAV_SENSORS_current.name            = "txt_NAV_SENSORS_current"
txt_NAV_SENSORS_current.material        = "font_Ka-50_ABRIS_WHITE"
txt_NAV_SENSORS_current.init_pos		= {-0.98*x_size,0,0}
txt_NAV_SENSORS_current.value           = "\n"..LOCALIZE("ГНСС").."\n"..LOCALIZE("ВЫСОТОМЕР").."\n"
txt_NAV_SENSORS_current.alignment       = "LeftTop"
txt_NAV_SENSORS_current.stringdefs      = abris_font[2]
Add(txt_NAV_SENSORS_current)
use_mipfilter(txt_NAV_SENSORS_current)


txt_SELF_INFO_header			   	  = CreateElement "ceStringPoly"
txt_SELF_INFO_header.name            = "txt_SELF_INFO_header"
txt_SELF_INFO_header.material        = "font_Ka-50_ABRIS_WHITE"
txt_SELF_INFO_header.init_pos		  = {-0.98*x_size,0,0}
txt_SELF_INFO_header.value           = "\n\n\n\n\n\n\n\n\n"..LOCALIZE("РЕСУРС").."\n"..LOCALIZE("С/Н").."\n"..LOCALIZE("ВЕРСИЯ ПО")
txt_SELF_INFO_header.alignment       = "LeftTop"
txt_SELF_INFO_header.stringdefs      = abris_font[2]
Add(txt_SELF_INFO_header)
use_mipfilter(txt_SELF_INFO_header)

txt_SELF_INFO			   	  = CreateElement "ceStringPoly"
txt_SELF_INFO.name            = "txt_SELF_INFO"
txt_SELF_INFO.material        = "font_Ka-50_ABRIS_GREEN"
txt_SELF_INFO.init_pos		  = {-0.98*x_size,0,0}
txt_SELF_INFO.formats         = {"\n\n\n\n\n\n\n\n\n\t\t\t%s","\n\t\t\t%s","\n\t\t\t%s"}
txt_SELF_INFO.controllers     = {{"txt_lo_resource",0},{"txt_lo_serialnumber",1},{"txt_lo_version",2}}
txt_SELF_INFO.alignment       = "LeftTop"
txt_SELF_INFO.stringdefs      = abris_font[2]
Add(txt_SELF_INFO)
use_mipfilter(txt_SELF_INFO)

txt_NAV_SENSORS_current_READY			   	  = CreateElement "ceStringPoly"
txt_NAV_SENSORS_current_READY.name            = "txt_NAV_SENSORS_current_READY"
txt_NAV_SENSORS_current_READY.material        = "font_Ka-50_ABRIS_GREEN"
txt_NAV_SENSORS_current_READY.formats         = {"\n",LOCALIZE("ГОТОВ"),"\n",LOCALIZE("ГОТОВ")}
txt_NAV_SENSORS_current_READY.alignment       = "LeftTop"
txt_NAV_SENSORS_current_READY.stringdefs      = abris_font[2]
txt_NAV_SENSORS_current_READY.controllers     = {{"txt_txt",0},{"txt_SNS_status",1,2},{"txt_SNS_status",1,3},{"txt_txt",2},{"txt_RALT_status",3,1}}
Add(txt_NAV_SENSORS_current_READY)
use_mipfilter(txt_NAV_SENSORS_current_READY)

txt_NAV_SENSORS_current_NOTREADY			   	 = CreateElement "ceStringPoly"
txt_NAV_SENSORS_current_NOTREADY.name            = "txt_NAV_SENSORS_current_NOTREADY"
txt_NAV_SENSORS_current_NOTREADY.material        = "font_Ka-50_ABRIS_YELLOW"
txt_NAV_SENSORS_current_NOTREADY.alignment       = "LeftTop"
txt_NAV_SENSORS_current_NOTREADY.formats         = {"\n",LOCALIZE("НЕ ГОТОВ"),"\n",LOCALIZE("НЕ ГОТОВ"),}
txt_NAV_SENSORS_current_NOTREADY.controllers     = {{"txt_txt",0},{"txt_SNS_status",1,1},{"txt_txt",2},{"txt_RALT_status",3,0}}
txt_NAV_SENSORS_current_NOTREADY.stringdefs      = abris_font[2]
Add(txt_NAV_SENSORS_current_NOTREADY)
use_mipfilter(txt_NAV_SENSORS_current_NOTREADY)

txt_NAV_SENSORS_current_NO			   	   = CreateElement "ceStringPoly"
txt_NAV_SENSORS_current_NO.name            = "txt_NAV_SENSORS_current_NO"
txt_NAV_SENSORS_current_NO.material        = "font_Ka-50_ABRIS_RED"
txt_NAV_SENSORS_current_NO.value           = "\n\n"..NO_STR.."\n"
txt_NAV_SENSORS_current_NO.alignment       = "LeftTop"
txt_NAV_SENSORS_current_NO.formats         = {"\n",NO_STR,"\n",NO_STR}
txt_NAV_SENSORS_current_NO.controllers     = {{"txt_txt",0},{"txt_SNS_status",1,0},{"txt_txt",2},{"txt_RALT_status",3,-1}}
txt_NAV_SENSORS_current_NO.stringdefs      = abris_font[2]
Add(txt_NAV_SENSORS_current_NO)
use_mipfilter(txt_NAV_SENSORS_current_NO)
