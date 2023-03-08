dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

up_line          = CreateElement "ceTexPoly"
up_line.name     = "up_line"
SetLine(up_line)
up_line.init_pos = up_line_pos
Add(up_line)

frame_1 = AddFrame(-0.4,0.4,-0.5,0.5)
frame_1.init_pos = {-0.5,0.2,0}

frame_2 = AddFrame(-0.3,0.3,-0.4,0.4)
frame_2.parent_element = frame_1.name

frame_3 = AddFrame(-0.4,0.4,-0.1,0.1)
frame_3.init_pos  = {0,-0.7}
frame_3.parent_element = frame_1.name

frame_4 = AddFrame(-0.2,0.1,-0.5,0.5)
frame_4.init_pos  = {0.7,0,0}
frame_4.parent_element = frame_1.name

frame_5 = AddFrame(0.1,0.2,0.1,0.5)
frame_5.parent_element = frame_4.name

frame_6 = AddFrame(-0.2,-0.1,-0.1,0.1)
frame_6.init_pos  = {0,-0.7}
frame_6.parent_element = frame_4.name

txt_buttons_status			     	= CreateElement "ceStringPoly"
txt_buttons_status.name             = "txt_buttons_status"
txt_buttons_status.material         = "font_Ka-50_ABRIS_GREEN"
txt_buttons_status.init_pos		    = {0,-0.1*y_size,0}
txt_buttons_status.value            = "1 2 3 4 5"
txt_buttons_status.alignment        = "CenterTop"
txt_buttons_status.stringdefs       = abris_font[2]
txt_buttons_status.parent_element   = frame_3.name
Add(txt_buttons_status)
use_mipfilter(txt_buttons_status)

txt_hardware_status			     	 = CreateElement "ceStringPoly"
txt_hardware_status.name             = "txt_hardware_status"
txt_hardware_status.material         = "font_Ka-50_ABRIS_GREEN"
txt_hardware_status.init_pos		 = {-0.3*x_size,0,0}
txt_hardware_status.value            = LOCALIZE("ОСН.ПРОЦЕССОР").."\n"..LOCALIZE("РПЗУ").."\n\n"..LOCALIZE("ОЗУ").."\n"
txt_hardware_status.alignment        = "RightTop"
txt_hardware_status.stringdefs       = abris_font[2]
txt_hardware_status.parent_element   = up_line.name
Add(txt_hardware_status)
use_mipfilter(txt_hardware_status)

txt_hardware_status2		     	 = Copy(txt_hardware_status)
txt_hardware_status2.init_pos		 = {0.9*x_size,-0.07*y_size,0}
txt_hardware_status2.value           = LOCALIZE("НАВ.ДАТЧИК").."\n\n"..LOCALIZE("БЛОК ЭП").."\n\nRS\n\n"..LOCALIZE("ЦАП").."\n\n"..LOCALIZE("АЦП").."\n\nARINC"
Add(txt_hardware_status2)

txt_hardware_status3		     	 = Copy(txt_hardware_status2)
txt_hardware_status3.value           = "\n\n\n\n\n\n\n\n\n\n \nTX RX\n 0  0\n 1  1\n 2  2\n 3  3"
Add(txt_hardware_status3)

txt_hardware_status4		     	 = Copy(txt_hardware_status2)
txt_hardware_status4.value           = "\n\n\n\n\n\n\n1 2 3 4\n\n1 2 3 4 5 6\n"
Add(txt_hardware_status4)

txt_hardware_status5		     	  = Copy(txt_hardware_status2)
txt_hardware_status5.value            = "ARINC-429\n"..LOCALIZE("X-PCB")
txt_hardware_status5.parent_element   = frame_4.name
txt_hardware_status5.init_pos         = {0.5*x_size,-0.64*y_size,0}
Add(txt_hardware_status5)

local delta  = 0.015*y_size
local delta2 = 0.14 *y_size
local centers_line  = (385  + (388 - 385)/2)/512

lines = {}
for i = 1,4 do
	lines[i] 			     = CreateElement "ceSimpleLineObject"
	lines[i].name            = "line_"..string.format("%d",i)
	lines[i].material	     = "INDICATION_ABRIS_GREEN"
	lines[i].width           = 0.004 
	lines[i].init_pos	 	 = {0.1,-0.4,0} 
	lines[i].tex_params      = {{0.1,centers_line},{0.9,centers_line},{scale_2,scale_2}}	
	lines[i].vertices        = {{0,-(i - 1)*delta},
								{0.15*x_size + (i - 1)*delta,-(i - 1)*delta},
								{0.15*x_size + (i - 1)*delta, 0.875 - (i-1)*delta2},
								{0.3*x_size                 , 0.875 - (i-1)*delta2}}
	lines[i].parent_element  = frame_5.name
	Add(lines[i])
	use_mipfilter(lines[i])
end

lines[5] = Copy(lines[1])
lines[5].init_pos	 	 = {0.1,0.05,0} 
lines[5].vertices        = {{-0.1,0},
							{0.15*x_size - delta,0},
							{0.15*x_size - delta,0.5 - 0.05},
							{0.2 *x_size        ,0.5 - 0.05},
							{0.2 *x_size        ,0.5}}
lines[5].parent_element  = frame_4.name
Add(lines[5])

lines[6] = Copy(lines[1])
lines[6].init_pos	 	 = {-0.1,0,0} 
lines[6].vertices        = {{0,-0.03},
							{0,0.79},
							{0.05,0.79}}
lines[6].parent_element  = lines[5].name
Add(lines[6])

lines[7] = Copy(lines[6])
lines[7].vertices        = {{0.15 ,0.1},
							{0.15 ,0.79  - delta2},
							{0.2  ,0.79  - delta2}}
Add(lines[7])

lines[8] = Copy(lines[7])
lines[8].init_pos	 	 = {-0.2,0.35,0} 
lines[8].width			 = 0.008
lines[8].vertices        = {{0.0 ,0.0},
							{0.0 ,-0.6}}

Add(lines[8])

lines[9] = Copy(lines[8])
lines[9].init_pos	 	 = {0.05,0,0} 
lines[9].vertices        = {{0.0 ,0.0},
							{0.0 ,-0.5}}
lines[9].parent_element  = lines[8].name
Add(lines[9])	

lines[10] = Copy(lines[7])
lines[10].init_pos	 	  = {0,-0.6,0} 
lines[10].vertices        = {{0.0  ,0.0},
							 {0.0  ,-0.875 + 0.1},
							 {0.12 ,-0.875 + 0.1}}
lines[10].parent_element  = lines[8].name
Add(lines[10])	

lines[11] = Copy(lines[7])
lines[11].init_pos	 	  = {0.05,-0.5,0} 
lines[11].vertices        = {{0.0  ,-0.1},
							 {0.0  ,-0.875 + delta2/2},
							 {0.02 ,-0.875 + delta2/2}}
lines[11].parent_element  = lines[9].name
Add(lines[11])	

lines[12] = Copy(lines[7])
lines[12].init_pos	 	  = {0,0,0} 
lines[12].vertices        = {{ 0.0  , 0.0},
							 { 0.0  , 0.53},
							 {-0.1  , 0.53}}
lines[12].parent_element  = lines[8].name
Add(lines[12])	

lines[13] = Copy(lines[7])
lines[13].init_pos	 	  = {0,0.53 - delta2/2,0} 
lines[13].vertices        = {{ 0.0  , 0.0},
							 {-0.1  , 0.0}}
lines[13].parent_element  = lines[12].name
Add(lines[13])	

lines[14] = Copy(lines[13])
lines[14].init_pos	 	  = {0,0.53 - 1.5*delta2,0} 
Add(lines[14])	


lines[15] = Copy(lines[12])
lines[15].init_pos        = {0.25 - delta,0,0}
lines[15].material        = "INDICATION_ABRIS_BLUE"
lines[15].vertices        = {{ 0.0  , 0.05},
							 { 0.0  , 0.53 - delta2},
							 { 0.1  , 0.53 - delta2}}
Add(lines[15])

lines[16] = Copy(lines[11])
lines[16].init_pos        = {-0.1,-0.5,0}
lines[16].material        = "INDICATION_ABRIS_BLUE"
lines[16].vertices        = {{ 0.0  ,-0.3},
							 { 0.0  ,-0.875},
							 {-0.1 ,-0.875}}
Add(lines[16])

lines[17] = Copy(lines[15])
lines[17].init_pos        = {0.05,0,0}
lines[17].material        = "INDICATION_ABRIS_BLUE"
lines[17].vertices        = {{ 0.0  , 0.05},
							 { 0.0  , 0.53},
							 { 0.1  , 0.53}}
Add(lines[17])


lines[18] = Copy(lines[17])
lines[18].init_pos        = {0.35,-0.45,0}
lines[18].parent_element  = frame_1.name
lines[18].vertices        = {{ 0.0  , 0},
							 { 0.1  , 0},
							 { 0.1  , 1},
							 {-0.1  , 1}}
Add(lines[18])

lines[19] = Copy(lines[18])
lines[19].init_pos        = {-0.35,0.45,0}
lines[19].vertices        = {{ 0.0  , 0},
							 { 0.0  , 0.1},
							 { 0.1  , 0.1}}
Add(lines[19])

txt_SELF_INFO_header			   	  = CreateElement "ceStringPoly"
txt_SELF_INFO_header.name            = "txt_SELF_INFO_header"
txt_SELF_INFO_header.material        = "font_Ka-50_ABRIS_WHITE"
txt_SELF_INFO_header.init_pos		  = {-0.98*x_size,-0.7*y_size,0}
txt_SELF_INFO_header.value           = LOCALIZE("РЕСУРС").."\n"..LOCALIZE("С/Н").."\n"..LOCALIZE("ВЕРСИЯ ПО")
txt_SELF_INFO_header.alignment       = "LeftTop"
txt_SELF_INFO_header.stringdefs      = abris_font[2]
Add(txt_SELF_INFO_header)
use_mipfilter(txt_SELF_INFO_header)

txt_SELF_INFO			   	  = CreateElement "ceStringPoly"
txt_SELF_INFO.name            = "txt_SELF_INFO"
txt_SELF_INFO.material        = "font_Ka-50_ABRIS_WHITE"
txt_SELF_INFO.formats         = {"\t\t\t%s\n"}
txt_SELF_INFO.controllers     = {{"txt_lo_resource",0},{"txt_lo_serialnumber",0},{"txt_lo_version",0}}
txt_SELF_INFO.alignment       = "LeftTop"
txt_SELF_INFO.stringdefs      = abris_font[2]
txt_SELF_INFO.parent_element  = "txt_SELF_INFO_header"
Add(txt_SELF_INFO)
use_mipfilter(txt_SELF_INFO)


AddMode("УПРАВЛЕНИЕ")
AddContextBlock(LOCALIZE("СООБЩЕН").."\n".."К-О41".."\n"..LOCALIZE("БЗД"))
AddButtons("УСТАН","","","ТЕСТ","МЕНЮ")
