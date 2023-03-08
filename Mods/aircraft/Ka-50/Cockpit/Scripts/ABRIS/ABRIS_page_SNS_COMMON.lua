dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

up_line          = CreateElement "ceTexPoly"
up_line.name     = "up_line"
SetLine(up_line)
up_line.init_pos = up_line_pos
Add(up_line)

txt_data_data			   	 = CreateElement "ceStringPoly"
txt_data_data.name            = "txt_data_data"
txt_data_data.material        = "font_Ka-50_ABRIS_GREEN"
txt_data_data.init_pos		 = {-0.95*x_size,0.9*y_size,0}
txt_data_data.value           = LOCALIZE("ИНФОРМАЦИЯ ГНСС")
txt_data_data.alignment       = "LeftTop"
txt_data_data.stringdefs      = abris_font[5]
Add(txt_data_data)
use_mipfilter(txt_data_data)

txt_data_data2			   	 = CreateElement "ceStringPoly"
txt_data_data2.name            = "txt_data_data2"
txt_data_data2.material        = "font_Ka-50_ABRIS_WHITE"
txt_data_data2.init_pos		 = {-0.95*x_size,0.82*y_size,0}
txt_data_data2.value           = LOCALIZE("ДАТЧИК").."   GG.#196.550PV__L__GM__S".."\n"..LOCALIZE("ПОСЛ ВРМ").."\n"..LOCALIZE("ПОЗ").."\n\n"..LOCALIZE("ВЫС").."\n"..LOCALIZE("ПС").."\n"..LOCALIZE("ФПУ").."\n"..LOCALIZE("ТОЧН ГОР").."\n"..LOCALIZE("ТОЧН ВЕР").."\n\n"..LOCALIZE("PDOP").."\n"..LOCALIZE("HDOP").."\n"..LOCALIZE("VDOP").."\n"..LOCALIZE("TDOP").."\n\n"..LOCALIZE("СИСТЕМА").."\n"..LOCALIZE("КА СЛЕЖ").."\n"..LOCALIZE("   ИСП")
txt_data_data2.alignment       = "LeftTop"
txt_data_data2.stringdefs      = abris_font[5]
Add(txt_data_data2)
use_mipfilter(txt_data_data2)

txt_sns_data             = CreateElement "ceStringPoly"
txt_sns_data.name        = "txt_mrk_airdrome"
txt_sns_data.material    = "font_Ka-50_ABRIS_WHITE"
txt_sns_data.alignment   = "LeftTop"
txt_sns_data.stringdefs  = abris_font[5] 
txt_sns_data.init_pos    = {-0.2*x_size,0.76*y_size,0}
txt_sns_data.formats     = {"%.0f:%.0f:%.0f\n","%s\n"}
txt_sns_data.controllers = {{"sns_time", 0},
							{"sns_latitude"  ,1},
							{"sns_longitude" ,1}}
Add(txt_sns_data)
use_mipfilter(txt_sns_data)

txt_sns_data2 			= Copy(txt_sns_data)
txt_sns_data2.init_pos    = {-0.4*x_size,0.58*y_size,0}
txt_sns_data2.formats     = {"%.0f","%.1f","%.1f\n","%.2f","%s\n"}
txt_sns_data2.controllers = {
							--{"sns_mode" , 3},
							{"sns_height", 0},
							{"measurements_units_height",4},
							{"sns_speed"  ,1},
							{"measurements_units_speed", 4},
							{"sns_fpu" ,2},
							{"sns_hor_accuracy" ,3},
							{"measurements_units_range", 4},
							{"sns_ver_accuracy" ,3},
							{"measurements_units_height", 4}}
Add(txt_sns_data2)
use_mipfilter(txt_sns_data2)

txt_sns_data3 			= Copy(txt_sns_data)
txt_sns_data3.init_pos    = {-0.4*x_size,0.22*y_size,0}
txt_sns_data3.formats     = {"%.1f\n","%i\n","\n"..LOCALIZE("GPS/ГЛОНАСС").."\n","\n"..LOCALIZE("GPS").."\n"}
txt_sns_data3.controllers = {	{"sns_pdop", 0},
								{"sns_hdop"  ,0},
								{"sns_vdop" ,0},
								{"sns_tdop" ,0},
								{"sns_method" ,2,3},
								{"sns_sat_tracking_qty", 1},
								{"sns_sat_using_qty", 1}}
Add(txt_sns_data3)
use_mipfilter(txt_sns_data3)


Horizon_dummy 		= CreateElement "ceSimple"
Horizon_dummy.name  = "Horizon_dummy"
Horizon_dummy.init_pos    = {horizon_center_X,horizon_center_Y,0}
Add(Horizon_dummy)

local centers_line  = (385  + (388 - 385)/2)/512

cross_ver_line 			       = CreateElement "ceSimpleLineObject"
cross_ver_line.name            = "cross_ver_line"
cross_ver_line.material	       = "INDICATION_ABRIS_WHITE"
cross_ver_line.width           = 0.004 
cross_ver_line.parent_element  = "Horizon_dummy"
cross_ver_line.tex_params      = {{0.1,centers_line},{0.9,centers_line},{scale_2,scale_2}}	
cross_ver_line.vertices        = {{0.0, 1.1 * horizon_size_Y}, {0.0, -1.1 * horizon_size_Y}}
Add(cross_ver_line)
use_mipfilter(cross_ver_line)

cross_hor_line 			     = CreateElement "ceSimpleLineObject"
cross_hor_line.name            = "cross_hor_line"
cross_hor_line.material	     = "INDICATION_ABRIS_WHITE"
cross_hor_line.width           = 0.004 
cross_hor_line.parent_element  = "Horizon_dummy"
cross_hor_line.tex_params      = {{0.1,centers_line},{0.9,centers_line},{scale_2,scale_2}}	
cross_hor_line.vertices        = {{1.1 * horizon_size_X, 0.0}, {-1.1 * horizon_size_X, 0.0}}
Add(cross_hor_line)
use_mipfilter(cross_hor_line)

circle_90 			     = CreateElement "ceSimpleLineObject"
circle_90.name            = "circle_90"
circle_90.material	     = "INDICATION_ABRIS_WHITE"
circle_90.width           = 0.004 
circle_90.parent_element  = "Horizon_dummy"
circle_90.tex_params      = {{0.1,centers_line},{0.9,centers_line},{scale_2,scale_2}}	
circle_90.vertices        = {{0.3 * x_size, 0.0}, {-0.3 * x_size, 0.0}}
set_verts_circle(circle_90,360,30,horizon_size_X,0)
Add(circle_90)
use_mipfilter(circle_90)

circle_60 = Copy(circle_90)
set_verts_circle(circle_60,360,30,horizon_size_X * 0.666,0)
Add(circle_60)
use_mipfilter(circle_60)

circle_30 = Copy(circle_90)
set_verts_circle(circle_30,360,30,horizon_size_X * 0.333,0)
Add(circle_30)
use_mipfilter(circle_30)

elev_angle_mask 			     = CreateElement "ceCircle"
elev_angle_mask.name            = "elev_angle_mask"
elev_angle_mask.material	     = MakeMaterial("",{255,255,255,255})
elev_angle_mask.parent_element  = "Horizon_dummy"
elev_angle_mask.dashed 			= true
elev_angle_mask.controllers 	= {{"elev_angle_mask", 32, horizon_size_X * 0.07675}}
Add(elev_angle_mask)
use_mipfilter(elev_angle_mask)

hor_line_label ={}
for i = -3,3 do
	if i ~= 0 then
		hor_line_label[i]			   = CreateElement "ceStringPoly"
		hor_line_label[i].name         = "hor_line_label"..string.format("%d",i)
		hor_line_label[i].material     = "font_Ka-50_ABRIS_WHITE"
		hor_line_label[i].init_pos	   = {horizon_size_X * 0.333 * i, 0.0 ,0} 
		hor_line_label[i].value        = string.format("%d",90 - math.abs(i) * 30)
		hor_line_label[i].alignment    = "CenterTop"
		hor_line_label[i].stringdefs   = abris_font[7]
		hor_line_label[i].parent_element = "Horizon_dummy"
		Add(hor_line_label[i])
		use_mipfilter(hor_line_label[i])
	end
end


Horizon_2_dummy 		= CreateElement "ceSimple"
Horizon_2_dummy.name  = "Horizon_2_dummy"
Horizon_2_dummy.init_pos    = {horizon_center_X,horizon_center_Y,0}
Add(Horizon_2_dummy)
Horizon_2_dummy.controllers = {{"specific_draw_satellites",horizon_center_X * 0.07675, horizon_center_Y * 0.07675, horizon_size_X * 0.07675, horizon_size_Y * 0.07675}}