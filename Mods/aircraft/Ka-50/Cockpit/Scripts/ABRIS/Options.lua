local indicator_x_size_meters = 0.076744050
scale_factor   = indicator_x_size_meters
x_size         = 1
y_size         = 1.3007496205006
scale_2        =  ((431 - 9)/512)/(2*x_size)
cursor_sc	   =  2*scale_2
cursor_size    =  16/512
cursor_size    =  cursor_size/cursor_sc



-- sm [1:scale] km
scales = 
{
100,
50,
40,
30,
25,
20,
15,
12.5,
10,
7.5,
6,
5,
4,
3,
2.5,
2,
1.5,
1.25,
1,
0.75,
0.6,
0.5,
0.3,
0.25,
0.2,
0.15
}

for i,s in pairs(scales) do
	scales[i] = scales[i]*1000*100
end

opt = {}
opt.System_Options			 = {}
opt.System_Options.sns		 =  {} --register_as("ABRIS::System_Options::sns")
opt.System_Options.sns.sensor_name = 
{
	{0,"ASHTECH GG12"}
}
opt.System_Options.sns.sensor_port_name = 
{
	{0,LOCALIZE("ВСТРОЕН")}
}
opt.System_Options.sns.control_type_name = 
{
	{0,LOCALIZE("АППАРАТНОЕ")},
	{1,LOCALIZE("Xon/Xoff")},
	{2,LOCALIZE("НЕТ")}
}
opt.System_Options.sns.speed = 
{
	data = {
	{1200,"1200"},	
	{2400,"2400"},
	{4800,"4800"},	
	{9600,"9600"},	
	{19200,"19200"},
	{38440,"38440"},
	{57600,"57600"},
	{115200,"115200"}
	}
}
opt.System_Options.sns.data_bits_qty = 
{
	format = {"%d","%ld"},
	incremented  = true,
	limit        = {4,8},
	default      = 8,
	increment    = 1,
}
opt.System_Options.sns.odd_control = 
{
	data = {
	{0,LOCALIZE("НЕТ")},
	{1,LOCALIZE("ЧЕТ")},
	{2,LOCALIZE("НЕЧЕТ")},
	{3,LOCALIZE("МАРКЕР")},
	{4,LOCALIZE("ПРОБЕЛ")}	
	}
}

opt.System_Options.sns.stop_bit = 
{
	format = {"%.1f","%lf"},
	incremented  = true,
	limit        = {1,2},
	default      = 1,
	increment    = 0.5,
}

opt.System_Options.sns.pdop_mask = 
{
	format = {"%.1f","%lf"},
	incremented  = true,
	limit        = {1,10},
	default      = 4,
	increment    = 1,
}

opt.System_Options.sns.elevation_mask = 
{
	format = {"%.0f°","%lf°"},
	incremented  = true,
	limit        = {0,90},
	default      = 5,
	increment    = 1,
}

opt.System_Options.sns.last_excluded_satellite = 
{
	format = {"%d","%ld"},
	incremented  = true,
	limit        = {0,100},
	default      = 0,
	increment    = 1,
}

opt.System_Options.sns.selected_system = 
{
	data = {
	{3,LOCALIZE("GPS/ГЛОНАСС")},
	{2,LOCALIZE("GPS")}
	}
}



opt.Options				 = {}
opt.Options.main		  = {}

opt.Options.main.map_moving_selection = 
{
	data = {
	{0,LOCALIZE("ОТНОСИТ")},
	{1,LOCALIZE("ИСТИННОЕ")}
	}
}
opt.Options.main.map_scale_selection = 
{
	data = {
	{1,LOCALIZE("ВРУЧНУЮ")},
	{0,LOCALIZE("АВТО")},
	}
}
opt.Options.main.map_orientation =
{
	data = {
	{0,LOCALIZE("КУРС")},
	{1,LOCALIZE("ПУ")},
	{2,LOCALIZE("СЕВЕР")}
	}
}
opt.Options.main.scale = 
{
    format  = {"1:%.f","1:%lf"},
    data    = scales,
	cycled  = false,
	default = 15
}
opt.Options.main.topography_view_limit_scale = scales[3]
opt.Options.main.course_source = 
{
	data = {
	{0,LOCALIZE("ИСТ")},
	{1,LOCALIZE("МАГ")}
	}
}
opt.Options.main.height_source = 
{
	data = {
	{0,LOCALIZE("ГНСС")},
--	{1,LOCALIZE("GPS")},
	{1,LOCALIZE("БАРО")},
	{2,LOCALIZE("РАДИО")}
	}
}
opt.Options.main.flight_time = 
{
	data = {
	{0,LOCALIZE("АВТО")},
    {1,LOCALIZE("ВРУЧНУЮ")}
	}
}
opt.Options.main.record = 
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {1,60},
	default      = 5,
	increment    = 1,
}
opt.Options.main.stp_selection = 
{
	data = {
	{0,LOCALIZE("АВТО")},
    {1,LOCALIZE("ВРУЧНУЮ")}
	}
}
opt.Options.main.stp_flight = 
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,10},
	default      = 5,
	increment    = 1,
}
opt.Options.main.scale_LBU = 
{
    format  = {"%.f","%lf"},
    data    = {1,2,5,10,20},
	cycled  = false,
	default = 2
}
opt.Options.main.RMI_1 = 
{
	data = {
	{1,LOCALIZE("НА ППМ")},
	{2,LOCALIZE("ОТ ППМ")},
	{3,LOCALIZE("VOR")},
	{4,LOCALIZE("АРК")},
	{0,LOCALIZE("ВЫКЛ")}
	}
}
opt.Options.main.RMI_2 = 
{
	data = {
	{4,LOCALIZE("АРК")},
	{0,LOCALIZE("ВЫКЛ")},
	{1,LOCALIZE("НА ППМ")},
	{2,LOCALIZE("ОТ ППМ")},
	{3,LOCALIZE("VOR")}
	}

}
opt.Options.main.stp_flight_method = 
{
	data = {
	{0,LOCALIZE("ТНП")},
	{1,LOCALIZE("ТОП")},
	{2,LOCALIZE("ТЗП")},
	}
}

opt.Options.main.RAIM_limit = 
{
	format = {"%.0f","%lf"},
	incremented  = true,
	limit        = {0, 9999},
	default      = 100,
	increment    = 1,
}

opt.Options.main.RAIM_limit_manual = 
{
	data = {
	{0,LOCALIZE("АВТО")},
	{1,LOCALIZE("ВРУЧНУЮ")},
	}
}
opt.Options.main.time =
{
	data = {
	{0,"HH:MM:SS"},
	}
}

opt.Options.main.date =
{
	data = {
	{0,"DD-MM-YY"},
	}
}

opt.Options.main.use_pseudo_ranges = 
{
	data = {
	{0,LOCALIZE("ВКЛ")},
	{1,LOCALIZE("ВЫКЛ")},
	}
}

opt.Options.main.scale_factor = scale_factor
opt.Options.main.cursor_size  = cursor_size
opt.Options.main.ABRIS_time_localization = 
{
	Local_Time_shift	 = 0
}
opt.Options.main.ABRIS_date = {}
opt.Options.main.additional_info_colors =
{
	{255,255,0,"YELLOW"},
	{216,73,90,"CLEAR"},
	{64,65,140,"CLEAR"},
	{100,188,79,"CLEAR"},
	{255,255,255,"CLEAR"},
	{255,0,0,"CLEAR"},
	{139,105,50,"CLEAR"},
	{0,0,0,"CLEAR"},
	{227,127,25,"CLEAR"}
}
opt.Options.charts       = {}
opt.Options.charts.aeronavigation = 
{
	data = {
	{2,LOCALIZE("ВЫБ")},
	{1,LOCALIZE("ВСЕ")},
	{0,LOCALIZE("ВЫКЛ")},
	}
}
opt.Options.charts.airports = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.runways = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.airport_communication = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.instrument_landing = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.landing_beacons = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.omnidirectional_beacons = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.radio_VHF = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.radio_UHF = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.civilian_traffic_routes = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.fanmarker_beacons = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.civilian_traffic_stp = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.waiting_routes = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.route_communication = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.air_corridors = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.tactical_situation = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.towns = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.lakes = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.rivers = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.rail_roads = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.roads = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.cables = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.text = 
{
	value = true,
	strings = {"+","-"}
}
opt.Options.charts.line_objects = 
{
	value = true,
	strings = {"+","-"}
}

opt.Options.charts.lat_lon_grid = 
{
	value = true,
	strings = {"+","-"}
}

opt.Options.charts.mgrs_grid = 
{
	value = false,
	strings = {"+","-"}
}

opt.Options.brightness   = 1.0
opt.Options.measurements = {}
opt.Options.measurements.latitude = 
{
	data = {
	{"%02.f°%02.f\'%.s%02.f\""," __°__\'__\""..LOCALIZE("C/Ю")},
	{"%02.f°%02.f.%s\'"		  ," __°__.__\'" ..LOCALIZE("C/Ю")},
	}
}
opt.Options.measurements.longitude = 
{
	data = {
	{"%03.f°%02.f\'%.s%02.f\"","___°__\'__\""..LOCALIZE("В/З")},
	{"%03.f°%02.f.%s\'"		  ,"___°__.__\'" ..LOCALIZE("В/З")},
	}
}
opt.Options.measurements.speed = 
{
	data = {
	{3.6,LOCALIZE("км/ч")}; -- Kilometers per hour
	{3.6/1.852,LOCALIZE("узл")}; -- Knots (NM per hour)
	{1.0,LOCALIZE("м/с")}; -- Meters per second
	}
}
opt.Options.measurements.range =
{
	data = {
	{0.001,LOCALIZE("км")}; -- Kilometers
	{6.213711922e-4,LOCALIZE("ам")}; -- Statute Miles
	{5.399568035e-4,LOCALIZE("мм")}; -- International Navy Miles
	}
}
opt.Options.measurements.height =
{ 
	data = {
	{1,LOCALIZE("м")}; -- Meters
	{3.280839895013,LOCALIZE("фт")}; -- Feet
	}
}
opt.Options.measurements.ellipsoid = 
{
	data = {
	{LOCALIZE("WGS-84"),LOCALIZE("WGS-84")},
	{LOCALIZE("Красовского"),LOCALIZE("Красовского")},
	},
	default = 1
}
opt.Options.measurements.weight =
{
	data = {
	{1,LOCALIZE("кг")}; -- Kilograms
	{2.20462247,LOCALIZE("фнт")} -- Pounds
	}
}

opt.Options.measurements.vertical_speed = 
{
	data = {
	{1,LOCALIZE("м/с")};
	{65.6167979,LOCALIZE("фт/мин")};
	}
}
opt.Options.perfomance = {}
opt.Options.perfomance.V_1 =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,350},
	default      = 120,
	increment    = 10,
}
opt.Options.perfomance.V_2 =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,350},
	default      = 160,
	increment    = 10,
}
opt.Options.perfomance.V_3 =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,350},
	default      = 120,
	increment    = 10,
}
opt.Options.perfomance.V_up_norm =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,350},
	default      = 130,
	increment    = 10,
}
opt.Options.perfomance.V_up_limit =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,350},
	default      = 130,
	increment    = 10,
}
opt.Options.perfomance.V_cruise_norm =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,350},
	default      = 200,
	increment    = 10,
}
opt.Options.perfomance.V_cruise_limit =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,350},
	default      = 180,
	increment    = 10,
}
opt.Options.perfomance.V_down_norm =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,350},
	default      = 120,
	increment    = 10,
}
opt.Options.perfomance.V_down_limit =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,350},
	default      = 120,
	increment    = 10,
}
opt.Options.perfomance.Vy_up =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,50},
	default      = 5,
	increment    = 1,
}
opt.Options.perfomance.Vy_down =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,50},
	default      = 4,
	increment    = 1,
}
opt.Options.perfomance.roll_at_route =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,60},
	default      = 15,
	increment    = 1,
}
opt.Options.perfomance.roll =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,60},
	default      = 15,
	increment    = 1,
}
opt.Options.perfomance.fuel_taxi =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,100},
	default      = 20,
	increment    = 1,
}
opt.Options.perfomance.fuel_takeoff =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,100},
	default      = 20,
	increment    = 1,
}
opt.Options.perfomance.fuel_consumption_flight =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,1500},
	default      = 786,
	increment    = 10,
}
opt.Options.perfomance.fuel_consumption_flight_limit =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,1500},
	default      = 1000,
	increment    = 10,
}
opt.Options.signals = {}
opt.Options.signals.approach_to_stp =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,20},
	default      = 1,
	increment    = 1,
}
opt.Options.signals.approach_to_climbpoint =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,20},
	default      = 1,
	increment    = 1,
}
opt.Options.signals.approach_to_divepoint =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,20},
	default      = 1,
	increment    = 1,
}
opt.Options.signals.approach_to_turnpoint =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,20},
	default      = 1,
	increment    = 1,
}
opt.Options.signals.border_avoidance_1 =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,20},
	default      = 1,
	increment    = 1,
}
opt.Options.signals.border_avoidance_2 =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,20},
	default      = 1,
	increment    = 1,
}
opt.Options.signals.border_air_traffic_control_zone =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,20},
	default      = 1,
	increment    = 1,
}
opt.Options.signals.limit_LBU =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,20},
	default      = 1,
	increment    = 1,
}
opt.Options.signals.limit_course =
{
	format = {"%.f°","%lf"},
	incremented  = true,
	limit        = {0,90},
	default      = 20,
	increment    = 1,
}
opt.Options.signals.collision_detection_horizon_level =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,20},
	default      = 1,
	increment    = 1,
}
opt.Options.signals.collision_detection_vertical_level =
{
	format = {"%.f","%lf"},
	incremented  = true,
	limit        = {0,20},
	default      = 1,
	increment    = 1,
}
opt.Options.signals.collision_detection_earth =
{
	value   = false,
	strings = {LOCALIZE("ВКЛ"),LOCALIZE("ВЫКЛ")}
}
