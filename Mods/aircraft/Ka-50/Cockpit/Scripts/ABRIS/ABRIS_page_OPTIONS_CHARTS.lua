dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
AddSubMode("НАСТРОЙКА КАРТЫ")

local init_y    =    up_line_pos[2] - (y_size - up_line_pos[2])
local delta_row =  -(abris_font[2][1] + abris_font[2][4])

AddCurrentListControl("current_list_block_1","current_list_block_2",init_y,0,100)

base_charts			   	 		 	= CreateElement "ceSimple"
base_charts.name              	 	= "charts_menu_base"
base_charts.init_pos			 	= {0,init_y,0}
base_charts.controllers	  		 	= {{"set_frame_size_for_current_menu",24}}
Add(base_charts)

local entries = 
{
LOCALIZE("КАРТА"),
LOCALIZE("АЭРОДРОМЫ"),
LOCALIZE("ВПП"),
LOCALIZE("СВЯЗЬ АЭРОДРОМА"),
LOCALIZE("ILS"),
LOCALIZE("ILS МАРКЕРЫ"),
LOCALIZE("NDB АЭРОДРОМА"),
LOCALIZE("СРЕДСТВА ОВЧ"),
LOCALIZE("NDB"),
LOCALIZE("ВОЗДУШНЫЕ ТРАССЫ"),
LOCALIZE("ВЕЕРНЫЕ МАРКЕРЫ"),
LOCALIZE("ТРАССОВЫЕ ППМ"),
LOCALIZE("ЗОНЫ ОЖИДАНИЯ"),
LOCALIZE("ЧАСТОТЫ СВЯЗИ"),
LOCALIZE("ОГР.ВОЗДУШНЫЕ ЗОНЫ"),
LOCALIZE("ТАКТИКА"),
LOCALIZE("НАС. ПУНКТЫ"),
LOCALIZE("ОЗЕРА"),
LOCALIZE("РЕКИ"),
LOCALIZE("ЖЕЛ. ДОРОГИ"),
LOCALIZE("ДОРОГИ"),
LOCALIZE("ЛИНИИ ЛЭП"),
LOCALIZE("ТЕКСТ"),
LOCALIZE("ЛИНЕЙНЫЕ ОБЬЕКТЫ"),
LOCALIZE("ГЕО. СЕТКА"),
LOCALIZE("UTM СЕТКА")
}

local function entry(name,i)
	local txt_data_header			= CreateElement "ceStringPoly"
	txt_data_header.name            = "chart_opts_"..tostring(i)
	txt_data_header.material        = "font_Ka-50_ABRIS_WHITE"
	txt_data_header.init_pos 		= {-0.98*x_size,0,0}
	txt_data_header.value           = name
	txt_data_header.alignment       = "LeftTop"
	txt_data_header.controllers  	= {{"current_menu_in_list_position",delta_row,i - 1}}
	txt_data_header.stringdefs      = abris_font[2]
	txt_data_header.parent_element  = base_charts.name
	Add(txt_data_header)
	use_mipfilter(txt_data_header)
	
	local txt_data2			  		= CreateElement "ceStringPoly"
	txt_data2.name            		= "txt_d45ata_"..tostring(i)
	txt_data2.material        		= "font_Ka-50_ABRIS_WHITE"
	txt_data2.init_pos		  		= {0.98*x_size + 0.7*x_size  ,0,0}
	txt_data2.formats         		= {"%s"}
	txt_data2.alignment       		= "LeftTop"
	txt_data2.stringdefs      		= abris_font[2]
	txt_data2.parent_element  		= txt_data_header.name
	txt_data2.controllers    		= {{"current_menu_element_draw",0,i - 1}}
	Add(txt_data2)
	use_mipfilter(txt_data2)
	
end

for i,o in ipairs(entries) do
	entry(o,i)
end