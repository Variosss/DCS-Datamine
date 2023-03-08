dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

AddButtons("МЕНЮ","АВТО","РАСЧ","СИСТ","НАВ")
AddMode("СНС")

SNR_Graph_dummy 		= CreateElement "ceSimple"
SNR_Graph_dummy.name  = "SNR_Graph_dummy"
SNR_Graph_dummy.init_pos    = {SNR_X0, SNR_Y0, 0}
Add(SNR_Graph_dummy)

SNratioLabel1 				  = CreateElement "ceStringPoly"
SNratioLabel1.name            = "SNratioLabel1"
SNratioLabel1.material        = "font_Ka-50_ABRIS_WHITE"
SNratioLabel1.name            = "SNratioLabel1"
SNratioLabel1.alignment       = "RightBottom"
SNratioLabel1.init_pos		= {-0.05*x_size,0,0}
SNratioLabel1.value           = "0"
SNratioLabel1.stringdefs      = abris_font[7]
SNratioLabel1.parent_element = "SNR_Graph_dummy"
Add(SNratioLabel1)
use_mipfilter(SNratioLabel1)

SNratioLabel2  	 			= Copy(SNratioLabel1)
SNratioLabel2.name            = "SNratioLabel2"
SNratioLabel2.init_pos		= {-0.05*x_size, SNR_Y_height * 0.5, 0}
SNratioLabel2.value           = "50"
SNratioLabel2.parent_element = "SNR_Graph_dummy"
Add(SNratioLabel2)
use_mipfilter(SNratioLabel2)

SNratioLabel3  	 			= Copy(SNratioLabel1)
SNratioLabel3.name            = "SNratioLabel3"
SNratioLabel3.init_pos		= {-0.05*x_size, SNR_Y_height, 0}
SNratioLabel3.value           = "100"
SNratioLabel3.parent_element = "SNR_Graph_dummy"
Add(SNratioLabel3)
use_mipfilter(SNratioLabel3)

local centers_line  = (385  + (388 - 385)/2)/512

lineXY 			     = CreateElement "ceSimpleLineObject"
lineXY.name          = "lineXY"
lineXY.material	     = "INDICATION_ABRIS_WHITE"
lineXY.width         = 0.004 
lineXY.tex_params    = {{0.1,centers_line},{0.9,centers_line},{scale_2,scale_2}}	
lineXY.vertices      = {{0.0, SNR_Y_height},
							 {0.0, 0.0},
							 {SNR_X_length, 0.0}}
lineXY.parent_element = "SNR_Graph_dummy"							 
Add(lineXY)
use_mipfilter(lineXY)

txt_data_data3			   	 = CreateElement "ceStringPoly"
txt_data_data3.name        = "txt_data_data3"
txt_data_data3.init_pos	   = {-0.95*x_size,-0.6*y_size,0}
txt_data_data3.alignment       = "LeftTop"
txt_data_data3.material        = "font_Ka-50_ABRIS_WHITE"
txt_data_data3.stringdefs      = abris_font[5]
txt_data_data3.value = LOCALIZE("RAIM")
Add(txt_data_data3)
use_mipfilter(txt_data_data3)

txt_data_data3_1			   = Copy(txt_data_data3)
txt_data_data3_1.name        = "txt_data_data3_1"
txt_data_data3_1.init_pos	   = {-0.5*x_size,-0.6*y_size,0}
txt_data_data3_1.value = LOCALIZE("ПОРОГ")
Add(txt_data_data3_1)
use_mipfilter(txt_data_data3_1)

txt_data_data4			   = Copy(txt_data_data3)
txt_data_data4.name        = "txt_data_data4"
txt_data_data4.init_pos	   = {-0.2*x_size,-0.6*y_size,0}
txt_data_data4.formats = {"%.0f ","%s"}
txt_data_data4.controllers = {{"accuracy_limit", 0},{"measurements_units_height", 1}}
Add(txt_data_data4)
use_mipfilter(txt_data_data4)

txt_data_data5			   = Copy(txt_data_data3)
txt_data_data5.name        = "txt_data_data5"
txt_data_data5.init_pos	   = {-0.95*x_size,-0.7*y_size,0}
txt_data_data5.formats = {LOCALIZE("ХОРОШО"), LOCALIZE("ПЛОХО")}
txt_data_data5.controllers = {{"accuracy_grade", 0, 1}}
Add(txt_data_data5)
use_mipfilter(txt_data_data5)

txt_data_data6			   = Copy(txt_data_data3)
txt_data_data6.name        = "txt_data_data6"
txt_data_data6.init_pos	   = {-0.5*x_size,-0.7*y_size,0}
txt_data_data6.formats = {LOCALIZE("МАРШР"), LOCALIZE("АЭРОДРОМ"), LOCALIZE("ВРУЧНУЮ")}
txt_data_data6.controllers = {{"flight_stage", 0, 1, 2}}
Add(txt_data_data6)
use_mipfilter(txt_data_data6)

txt_data_data7			   = Copy(txt_data_data3)
txt_data_data7.name        = "txt_data_data7"
txt_data_data7.init_pos	   = {-0.5*x_size,-0.8*y_size,0}
txt_data_data7.value = LOCALIZE("ВЫБОР")
Add(txt_data_data7)
use_mipfilter(txt_data_data7)