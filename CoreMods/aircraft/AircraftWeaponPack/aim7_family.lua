local AIM_7_FM =
{
	mass				= 231,  
	caliber				= 0.2,  
	wind_sigma			= 0.0,
	wind_time			= 0.0,
	tail_first			= 1,
	fins_part_val		= 0,
	rotated_fins_inp	= 0,
	delta_max			= math.rad(20),
	draw_fins_conv		= {math.rad(90),1,1},
	L					= 0.2,
	S					= 0.0324,
	Ix					= 3.5,
	Iy					= 127.4,
	Iz					= 127.4,
	
	Mxd					= 0.3 * 57.3,
	Mxw					= -44.5,

	table_scale	= 0.2,
	table_degree_values = 1,
--	Mach	  | 0.0		0.2		0.4		0.6		0.8		1.0		1.2		1.4		1.6		1.8		2.0		2.2		2.4		2.6		2.8		3.0		3.2		3.4		3.6		3.8		4.0	 |
	Cx0 	= {	0.34,	0.34,	0.34,	0.34,	0.35,	1.10,	1.27,	1.23,	1.19,	1.12,	1.05,	1.0,	0.95,	0.91,	0.87,	0.84,	0.81,	0.78,	0.76,	0.74,	0.72 },
	CxB 	= {	0.11,	0.11,	0.11,	0.11,	0.11,	0.18,	0.19,	0.17,	0.16,	0.14,	0.13,	0.12,	0.12,	0.11,	0.11,	0.10,	0.09,	0.09,	0.08,	0.08,	0.07 },
	K1		= { 0.0056,	0.0056,	0.0056,	0.0056,	0.0056,	0.0056,	0.0056,	0.0056,	0.0052,	0.0048,	0.0045,	0.0041,	0.0037,	0.0036,	0.0034,	0.0032,	0.0031,	0.0030,	0.0029,	0.0027,	0.0026 },
	K2		= { 0.0055,	0.0055,	0.0055,	0.0055,	0.0055,	0.0055,	0.0055,	0.0055,	0.0051,	0.0047,	0.0043,	0.0037,	0.0031,	0.0032,	0.0033,	0.0035,	0.0036,	0.0037,	0.0038,	0.0039,	0.0040 },
	Cya		= { 1.14,	1.14,	1.14,	1.14,	1.14,	1.42,	1.46,	1.39,	1.32,	1.15,	1.06,	1.00,	0.94,	0.89,	0.83,	0.78,	0.73,	0.69,	0.65,	0.61,	0.57 },
	Cza		= { 1.14,	1.14,	1.14,	1.14,	1.14,	1.42,	1.46,	1.39,	1.32,	1.15,	1.06,	1.00,	0.94,	0.89,	0.83,	0.78,	0.73,	0.69,	0.65,	0.61,	0.57 },
	Mya		= { -0.5,	-0.5},
	Mza		= { -0.5,	-0.5},
	Myw		= { -2.0,	-2.0},
	Mzw		= { -2.0,	-2.0},
	A1trim	= { 10.0,	10.0},
	A2trim	= { 10.0,	10.0},
		
	model_roll = math.rad(45),
	fins_stall = 1,
}


local AIM_7E =
{
	category		= CAT_AIR_TO_AIR,
	name			= "AIM-7E",
	displayName		= _("AIM-7E Sparrow Semi-Active Radar"),
	user_name		= _("AIM-7E"),
	scheme			= "aa_missile_semi_active",
	class_name		= "wAmmunitionSelfHoming",
	model			= "aim-7",
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AA_Missile,WSTYPE_PLACEHOLDER},
	
	mass			= 230,
	Escort			= 1,
	Head_Type		= 6,
	sigma			= {5.6, 5, 5.6},
	H_max			= 24400.0,
	H_min			= 1.0,
	Diam			= 203.0,
	Cx_pil			= 2.21,
	D_max			= 20000.0,
	D_min			= 1500.0,
	Head_Form		= 1,
	Life_Time		= 90.0,
	Nr_max			= 25,
	v_min			= 140.0,
	v_mid			= 500.0,
	Mach_max		= 3.2,
	t_b				= 0.6,
	t_acc			= 3.3,
	t_marsh			= 11.0,
	Range_max		= 50000.0,
	H_min_t			= 15.0,
	Fi_start		= 0.4,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.8,
	Fi_search		= 0.1,
	OmViz_max		= 0.35,
	exhaust			= {0.78, 0.78, 0.78, 0.3};
	X_back			= -2.0,
	Y_back			= -0.0,
	Z_back			= 0.0, -- -0.1,
	Reflection		= 0.08,
	KillDistance	= 12.0,
	M				= 230,
	
	ccm_k0 = 2.0,
	rad_correction = 0,
	height_error_k = 110, -- если проекция скорости цели на линию визирования меньше этого значения, появляется ошибка
	height_error_max_vel = 150, -- пропорциональный коэффициент
	height_error_max_h = 450, -- максимальная высота, где появляется ошибка
	
	warhead		= predefined_warhead("AIM_7"),
	warhead_air = predefined_warhead("AIM_7"),
	
	shape_table_data =
	{
		{
			name  = "aim_7_E";
			file  = "aim-7";
			life  = 1;
			fire  = { 0, 1};
			username = "AIM-7E";
			index 	 = WSTYPE_PLACEHOLDER,
		},
	},
		
	ModelData = {   58 ,  -- model params count
					0.9 ,   -- characteristic square (характеристическая площадь)
			
					-- параметры зависимости Сx
					0.0125 , -- планка Сx0 на дозвуке ( M << 1)
					0.052 , -- высота пика волнового кризиса
					0.010 , -- крутизна фронта на подходе к волновому кризису
					0.002 , -- планка Cx0 на сверхзвуке ( M >> 1)
					0.5  , -- крутизна спада за волновым кризисом 
					1.2  , -- коэффициент отвала поляры
					
					-- параметры зависимости Cy
					2.20, -- планка Cya на дозвуке ( M << 1)
					1.05, -- планка Cya на сверхзвуке ( M >> 1)
					1.20, -- крутизна спада(фронта) за волновым кризисом  

					0.18, -- ~10 degrees Alfa_max  максимальный балансировачный угол, радианы
					0.00, --угловая скорость создаваймая моментом газовых рулей
						
					--	t_statr   t_b      t_accel  t_march   t_inertial   t_break  t_end
					-1.0,        -1.0,       2.8,     0.0,      0.0,		 0.0,    1.0e9,           -- time interval
					 0.0,         0.0, 	   14.28,     0.0,      0.0,         0.0,    0.0,           -- fuel flow rate in second kg/sec(секундный расход массы топлива кг/сек)
					 0.0,         0.0,   35000.0,     0.0,      0.0,         0.0,    0.0,           -- thrust
					
					 1.0e9, -- таймер самоликвидации, сек
					 75.0, -- время работы энергосистемы
					 0.0, -- абсалютеая высота самоликвидации, м
					 1.5, -- время задержки включения управленя, сек
					 1.0e9, -- дальность до цели в момент пуска, выше которой выполняется маневр набора высоты 
					 1.0e9, -- дальность до цели на трассе, менее которой начинается завершение маневра набора высоты (длжен быть больше чем предылущий параметр) 
					 0.0,  -- синус угла возвышения траектории набора горки
					 50.0, -- продольное ускорения взведения взрывателя
					 0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
					 1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
					 1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
					 2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
					 -- ЗРП. Данные для рассчета дальностей пуска (индикация на прицеле)
					 14.0, -- производная дальности по скорости носителя на высоте 1км, ППС
					 -19.0, -- производная дальности по скорости цели на высоте 1км, ЗПС
					 -2.2, -- производная по высоте производной дальности по скорости цели, ЗПС
					 19000, -- дальность ракурс 180(навстречу) град, Н=5000м, V=900км/ч, м
					 4800.0, -- дальность ракурс 0(в догон) град, Н=5000м, V=900км/ч, м
					 26000.0, -- дальность ракурс 180(навстречу) град, Н=10000м, V=900км/ч, м
					 7000.0, -- дальность ракурс 0(в догон) град, Н=10000м, V=900км/ч, м
					 13000.0, -- дальность ракурс 180(навстречу) град, Н=1000м,  V=900км/ч, м
					 2500.0, -- дальность ракурс 0(в догон) град, Н=1000м, V=900км/ч, м
					 2500.0, -- смещение назад отнсительно нуля задней точки зоны достижимости
					 0.4, -- процент гарантированной дальности от дальности в ППС на высоте 1км
					-0.014, -- производная процента гарантированной дальности в ППС по высоте
					0.5, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя.
				},  
				
	controller = {
		boost_start = 0.5,
		march_start = 0.6,
	},
	
	boost = {
		impulse								= 250,
		fuel_mass							= 0,
		work_time							= 0,
		nozzle_position						= {{-1.9, 0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		nozzle_exit_area 					= 0.00724,
		tail_width							= 0.4,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.2,	
	},
	
	march = {
		impulse								= 250,
		fuel_mass							= 40,
		work_time							= 2.8,
		nozzle_position						= {{-1.9, 0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		nozzle_exit_area 					= 0.00724,
		tail_width							= 0.4,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.2,
	},
	
	fm = AIM_7_FM,
	
	proximity_fuze = {
		radius		= 12,
		arm_delay	= 1.6,
	},
	
	seeker = {
		delay		= 2.0,
		op_time		= 75,
		FOV			= math.rad(92),
		max_w_LOS	= math.rad(15),
		sens_near_dist			= 100,
		sens_far_dist			= 30000,
		ccm_k0					= 2,
		aim_sigma				= 8,
		height_error_k			= 110;
		height_error_max_vel	= 150;
		height_error_max_h		= 450;
	},

	autopilot = {
		x_channel_delay		= 0.9,
		delay				= 1.6,
		op_time				= 75,
		Kconv				= 3.0,
		Knv					= 0.02,
		Kd					= 0.4,
		Ki					= 0.15,
		Kout				= 1.0,
		Kx					= 0.1,
		Krx					= 2.0,
		fins_limit			= math.rad(20),
		fins_limit_x		= math.rad(5),
		Areq_limit			= 25.0,
		bang_bang			= 0,
		max_side_N			= 10,
		max_signal_Fi		= math.rad(12),
		rotate_fins_output	= 0,
		alg					= 0,
		PN_dist_data 		= {	15000,	1,
								9000,	1},
		null_roll			= math.rad(45),
	},
}

declare_weapon(AIM_7E)

local AIM_7F =
{
	category		= CAT_AIR_TO_AIR,
	name			= "AIM-7F",
	displayName		= _("AIM-7F Sparrow Semi-Active Radar"),
	user_name		= _("AIM-7F"),
	scheme			= "aa_missile_semi_active",
	class_name		= "wAmmunitionSelfHoming",
	model			= "AIM-7F",
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AA_Missile,WSTYPE_PLACEHOLDER},
	
	mass = 231,
	Escort = 1,
	Head_Type = 6,
	sigma = {5.6, 5, 5.6},
	M = 231,
	H_max = 24400.0,
	H_min = 1.0,
	Diam = 203.0,
	Cx_pil = 2.21,
	D_max = 20000.0,
	D_min = 1500.0,
	Head_Form = 1,
	Life_Time = 90.0,
	Nr_max = 25,
	v_min = 140.0,
	v_mid = 500.0,
	Mach_max = 3.2,
	t_b = 0.5,
	t_acc = 3.3,
	t_marsh = 11.0,
	Range_max = 50000.0,
	H_min_t = 15.0,
	Fi_start = 0.4,
	Fi_rak = 3.14152,
	Fi_excort = 0.96,
	Fi_search = 0.1,
	OmViz_max = 0.35,
	exhaust = {0.78, 0.78, 0.78, 0.3};
	X_back = -2.0,
	Y_back = -0.0,
	Z_back = 0.0, -- -0.1,
	Reflection = 0.08,
	KillDistance = 12.0,
	ccm_k0 = 1.0,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1. The curve is non linear!
	rad_correction = 0,
	
	-- The guidance error from the influence of the surface at low altitudes
	height_error_k = 110, -- если проекция скорости цели на линию визирования меньше этого значения, появляется ошибка
	height_error_max_vel = 150, -- пропорциональный коэффициент
	height_error_max_h = 450, -- максимальная высота, где появляется ошибка
	
	warhead		= predefined_warhead("AIM_7"),
	warhead_air = predefined_warhead("AIM_7"),
	
	hoj = 1,
	
	shape_table_data =
	{
		{
			name  = "aim_7_F";
			file  = "AIM-7F";
			life  = 1;
			fire  = { 0, 1};
			username = "AIM-7F";
			index 	 = WSTYPE_PLACEHOLDER,
		},
	},
	
	supersonic_A_coef_skew = 0.25, -- наклон прямой коэффициента отвала поляры на сверхзвуке
	nozzle_exit_area =	0.007238, -- площадь выходного сечения сопла
		
	ModelData = {   58 ,  -- model params count
					0.9 ,   -- characteristic square (характеристическая площадь)
			
					-- параметры зависимости Сx
					0.0125 , -- планка Сx0 на дозвуке ( M << 1)
					0.052 , -- высота пика волнового кризиса
					0.010 , -- крутизна фронта на подходе к волновому кризису
					0.002 , -- планка Cx0 на сверхзвуке ( M >> 1)
					0.5  , -- крутизна спада за волновым кризисом 
					1.2  , -- коэффициент отвала поляры
					
					-- параметры зависимости Cy
					2.20, -- планка Cya на дозвуке ( M << 1)
					1.05, -- планка Cya на сверхзвуке ( M >> 1)
					1.20, -- крутизна спада(фронта) за волновым кризисом  

					0.18, -- ~10 degrees Alfa_max  максимальный балансировачный угол, радианы
					0.00, --угловая скорость создаваймая моментом газовых рулей
						
					--	t_statr   t_b      t_accel  t_march   t_inertial   t_break  t_end
					-1.0,    -1.0 ,  	3.7  ,  10.8,      0.0,		   0.0,      1.0e9,           -- time interval
					 0.0,     0.0 ,   	10.4 ,  2.02,     0.0,         0.0,      0.0,           -- fuel flow rate in second kg/sec(секундный расход массы топлива кг/сек)
					 0.0,     0.0 ,   25192.0,  4140.0,   0.0,         0.0,      0.0,           -- thrust
					
					 1.0e9, -- таймер самоликвидации, сек
					 75.0, -- время работы энергосистемы
					 0.0, -- абсалютеая высота самоликвидации, м
					 1.5, -- время задержки включения управленя, сек
					 1.0e9, -- дальность до цели в момент пуска, выше которой выполняется маневр набора высоты 
					 1.0e9, -- дальность до цели на трассе, менее которой начинается завершение маневра набора высоты (длжен быть больше чем предылущий параметр) 
					 0.0,  -- синус угла возвышения траектории набора горки
					 50.0, -- продольное ускорения взведения взрывателя
					 0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
					 1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
					 1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
					 2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
					 -- ЗРП. Данные для рассчета дальностей пуска (индикация на прицеле)
					 14.0, -- производная дальности по скорости носителя на высоте 1км, ППС
					 -21.0, -- производная дальности по скорости цели на высоте 1км, ЗПС
					 -2.2, -- производная по высоте производной дальности по скорости цели, ЗПС
					 27000, -- дальность ракурс 180(навстречу) град, Н=5000м, V=900км/ч, м
					 7000.0, -- дальность ракурс 0(в догон) град, Н=5000м, V=900км/ч, м
					 38000.0, -- дальность ракурс 180(навстречу) град, Н=10000м, V=900км/ч, м
					 12000.0, -- дальность ракурс 0(в догон) град, Н=10000м, V=900км/ч, м
					 19000.0, -- дальность ракурс 180(навстречу) град, Н=1000м,  V=900км/ч, м
					 5000.0, -- дальность ракурс 0(в догон) град, Н=1000м, V=900км/ч, м
					 2500.0, -- смещение назад отнсительно нуля задней точки зоны достижимости
					 0.4, -- процент гарантированной дальности от дальности в ППС на высоте 1км
					-0.014, -- производная процента гарантированной дальности в ППС по высоте
					0.5, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя.
				},
				
	controller = {
		boost_start = 0.5,
		march_start = 4.2,
	},
	
	boost = {
		impulse								= 247,
		fuel_mass							= 38.48,
		work_time							= 3.7,
		nozzle_position						= {{-1.9, 0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		nozzle_exit_area 					= 0.00724,
		tail_width							= 0.4,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.2,	
	},
	
	march = {
		impulse								= 209,
		fuel_mass							= 21.82,
		work_time							= 10.8,
		nozzle_position						= {{-1.9, 0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		nozzle_exit_area 					= 0.00724,
		tail_width							= 0.4,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.2,
	},
	
	fm = AIM_7_FM,
	
	proximity_fuze = {
		radius		= 12,
		arm_delay	= 1.6,
	},
	
	seeker = {
		delay					= 1.5,
		op_time					= 75,
		FOV						= math.rad(110),
		max_w_LOS				= math.rad(20),
		sens_near_dist			= 100,
		sens_far_dist			= 30000,
		ccm_k0					= 1.0,
		aim_sigma				= 5.5,
		height_error_k			= 110,
		height_error_max_vel	= 150,
		height_error_max_h		= 450,
		hoj						= 1,
	},

	autopilot = {
		x_channel_delay		= 0.9,
		delay				= 1.5,
		op_time				= 75,
		Kconv				= 3.0,
		Knv					= 0.02,
		Kd					= 0.4,
		Ki					= 0.15,
		Kout				= 1.0,
		Kx					= 0.1,
		Krx					= 2.0,
		fins_limit			= math.rad(20),
		fins_limit_x		= math.rad(5),
		Areq_limit			= 25.0,
		bang_bang			= 0,
		max_side_N			= 10,
		max_signal_Fi		= math.rad(12),
		rotate_fins_output	= 0,
		alg					= 0,
		PN_dist_data 		= {	15000,	1,
								9000,	1},
		null_roll			= math.rad(45),
		
		loft_active_by_default	= 0,
		loft_add_pitch			= math.rad(30),
		loft_time				= 3.5,
		loft_min_dist			= 6500,
		loft_max_dist			= 20000,
	},
}

declare_weapon(AIM_7F)

local AIM_7M = 
{
	category		= CAT_AIR_TO_AIR,
	name			= "AIM_7",
	displayName		= _("AIM-7M Sparrow Semi-Active Radar"),
	user_name		= _("AIM-7M"),
	scheme			= "aa_missile_semi_active",
	class_name		= "wAmmunitionSelfHoming",
	model			= "aim-7",
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AA_Missile,AIM_7},

	mass = 231.1,
    Escort = 1,
    Head_Type = 6,
	sigma = {5.6, 5, 5.6},
    M = 231.1,
    H_max = 24400.0,
    H_min = 1.0,
    Diam = 203.0,
    Cx_pil = 2.21,
    D_max = 20000.0,
    D_min = 1500.0,
    Head_Form = 1,
    Life_Time = 90.0,
    Nr_max = 25,
    v_min = 140.0,
    v_mid = 500.0,
    Mach_max = 3.2,
    t_b = 0.5,
    t_acc = 3.3,
    t_marsh = 11.0,
    Range_max = 50000.0,
    H_min_t = 15.0,
    Fi_start = 0.44,
    Fi_rak = 3.14152,
    Fi_excort = 1.05,
    Fi_search = 0.1,
    OmViz_max = 0.35,
    exhaust = {0.78, 0.78, 0.78, 0.3};
    X_back = -2.0,
    Y_back = -0.0,
    Z_back = 0.0, -- -0.1,
    Reflection = 0.08,
    KillDistance = 12.0,
    ccm_k0 = 0.5,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
	rad_correction = 0,
 	hoj = 1,
	
	warhead		= predefined_warhead("AIM_7"),
	warhead_air = predefined_warhead("AIM_7"),
		
	PN_coeffs = {2, 				-- Number of Entries	
				5000.0 ,1.0,		-- Less 5 km to target Pn = 1
				15000.0, 0.4};		-- Between 15 and 5 km  to target, Pn smoothly changes from 0.4 to 1.0. Longer then 15 km Pn = 0.4.
				
	shape_table_data =
	{
		{
			name  = "aim_7";
			file  = "aim-7";
			life  = 1;
			fire  = { 0, 1};
			username = "AIM-7M";
			index 	 = AIM_7,
		},
	},

	supersonic_A_coef_skew = 0.25, -- наклон прямой коэффициента отвала поляры на сверхзвуке
	nozzle_exit_area =	0.007238, -- площадь выходного сечения сопла
		
	ModelData = {   58 ,  -- model params count
					0.9 ,   -- characteristic square (характеристическая площадь)
	
					-- параметры зависимости Сx
					0.0125 , -- планка Сx0 на дозвуке ( M << 1)
					0.052 , -- высота пика волнового кризиса
					0.010 , -- крутизна фронта на подходе к волновому кризису
					0.002 , -- планка Cx0 на сверхзвуке ( M >> 1)
					0.5  , -- крутизна спада за волновым кризисом 
					1.2  , -- коэффициент отвала поляры
						
					-- параметры зависимости Cy
					2.20, -- планка Cya на дозвуке ( M << 1)
					1.05, -- планка Cya на сверхзвуке ( M >> 1)
					1.20, -- крутизна спада(фронта) за волновым кризисом  

					0.18, -- ~10 degrees Alfa_max  максимальный балансировачный угол, радианы
					0.00, --угловая скорость создаваймая моментом газовых рулей
					
					--	t_statr   t_b      t_accel  t_march   t_inertial   t_break  t_end
					-1.0,    -1.0 ,  	3.7  ,  10.8,      0.0,		   0.0,      1.0e9,           -- time interval
					 0.0,     0.0 ,   	10.4 ,  2.02,     0.0,         0.0,      0.0,           -- fuel flow rate in second kg/sec(секундный расход массы топлива кг/сек)
					 0.0,     0.0 ,   25192.0,  4140.0,   0.0,         0.0,      0.0,           -- thrust
				
					 1.0e9, -- таймер самоликвидации, сек
					 75.0, -- время работы энергосистемы
					 0.0, -- абсалютеая высота самоликвидации, м
					 1.5, -- время задержки включения управленя, сек
					 5000, -- дальность до цели в момент пуска, выше которой выполняется маневр набора высоты 
					 6000, -- дальность до цели на трассе, менее которой начинается завершение маневра набора высоты (длжен быть больше чем предылущий параметр) 
					 0.1,  -- синус угла возвышения траектории набора горки
					 50.0, -- продольное ускорения взведения взрывателя
					 0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
					 1.19, -- характеристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
					 1.0, -- характеристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
					 2.0, -- характеристика системы САУ-РАКЕТА,  полоса пропускания контура управления
					 -- ЗРП. Данные для рассчета дальностей пуска (индикация на прицеле)
					 14.0, -- производная дальности по скорости носителя на высоте 1км, ППС
					 -21.0, -- производная дальности по скорости цели на высоте 1км, ЗПС
					 -2.2, -- производная по высоте производной дальности по скорости цели, ЗПС
					 27000, -- дальность ракурс 180(навстречу) град, Н=5000м, V=900км/ч, м
					 7000.0, -- дальность ракурс 0(в догон) град, Н=5000м, V=900км/ч, м
					 38000.0, -- дальность ракурс 180(навстречу) град, Н=10000м, V=900км/ч, м
					 12000.0, -- дальность ракурс 0(в догон) град, Н=10000м, V=900км/ч, м
					 19000.0, -- дальность ракурс 180(навстречу) град, Н=1000м,  V=900км/ч, м
					 5000.0, -- дальность ракурс 0(в догон) град, Н=1000м, V=900км/ч, м
					 2500.0, -- смещение назад отнсительно нуля задней точки зоны достижимости
					 0.40, -- процент гарантированной дальности от дальности в ППС на высоте 1км
					-0.014, -- производная процента гарантированной дальности в ППС по высоте
					0.5, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя.
	},
	
	controller = {
		boost_start = 0.5,
		march_start = 4.2,
	},

	boost = {
		impulse								= 247,
		fuel_mass							= 38.48,
		work_time							= 3.7,
		nozzle_position						= {{-1.9, 0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		nozzle_exit_area 					= 0.00724,
		tail_width							= 0.4,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.2,
	},

	march = {
		impulse								= 209,
		fuel_mass							= 21.82,
		work_time							= 10.8,
		nozzle_position						= {{-1.9, 0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		nozzle_exit_area 					= 0.00724,
		tail_width							= 0.4,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.2,

--		fuel_rate_data	=	{	--t		rate
--								0.0,	2.0,
--								4.0,	1.8,
--							},
	},

	fm = AIM_7_FM,

	proximity_fuze = {
		radius		= 12,
		arm_delay	= 1.6,
	},

	seeker = {
		delay					= 1.5,
		op_time					= 75,
		FOV						= math.rad(120),
		max_w_LOS				= math.rad(20),
		sens_near_dist			= 100,
		sens_far_dist			= 30000,
		ccm_k0					= 1.0,
		aim_sigma				= 5.5,
		height_error_k			= 100,
		height_error_max_vel	= 138,
		height_error_max_h		= 300,
		hoj						= 1,
	},

	autopilot = {
		x_channel_delay 	= 0.9,
		delay				= 1.5,
		op_time				= 75,
		Kconv				= 4.0,
		Knv					= 0.02,
		Kd					= 0.4,
		Ki					= 0.1,
		Kout				= 1.0,
		Kx					= 0.1,
		Krx					= 2.0,
		fins_limit			= math.rad(20),
		fins_limit_x		= math.rad(5),
		Areq_limit			= 25.0,
		bang_bang			= 0,
		max_side_N			= 10,
		max_signal_Fi		= math.rad(12),
		rotate_fins_output	= 0,
		alg					= 0,
		PN_dist_data 		= {	15000,	1,
								9000,	1},
		null_roll			= math.rad(45),

		loft_active_by_default	= 0,
		loft_add_pitch			= math.rad(30),
		loft_time				= 3.5,
		loft_min_dist			= 6500,
		loft_max_dist			= 20000,
	},
}

declare_weapon(AIM_7M)

local AIM_7H = 
{
	category		= CAT_AIR_TO_AIR,
	name			= "AIM-7MH",
	displayName		= _("AIM-7MH Sparrow Semi-Active Radar"),
	user_name		= _("AIM-7MH"),
	scheme			= "aa_missile_semi_active",
	class_name		= "wAmmunitionSelfHoming",
	model			= "aim-7",
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AA_Missile,WSTYPE_PLACEHOLDER},
	
	mass = 231,
	Escort = 1,
	Head_Type = 6,
	sigma = {5.6, 5, 5.6},
	M = 231,
	H_max = 24400.0,
	H_min = 1.0,
	Diam = 203.0,
	Cx_pil = 2.21,
	D_max = 20000.0,
	D_min = 1500.0,
	Head_Form = 1,
	Life_Time = 90.0,
	Nr_max = 25,
	v_min = 140.0,
	v_mid = 500.0,
	Mach_max = 3.2,
	t_b = 0.5,
	t_acc = 3.3,
	t_marsh = 11.0,
	Range_max = 50000.0,
	H_min_t = 15.0,
	Fi_start = 0.4,
	Fi_rak = 3.14152,
	Fi_excort = 1.05,
	Fi_search = 0.1,
	OmViz_max = 0.35,
	exhaust = {0.78, 0.78, 0.78, 0.3};
	X_back = -2.0,
	Y_back = -0.0,
	Z_back = 0.0, -- -0.1,
	Reflection = 0.08,
	KillDistance = 12.0,
	ccm_k0 = 0.5,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability) 
	loft = 1,
	hoj = 1,
	
	warhead		= predefined_warhead("AIM_7"),
	warhead_air = predefined_warhead("AIM_7"),
	
	PN_coeffs = {2, 				-- Number of Entries	
				5000.0 ,1.0,		-- Less 5 km to target Pn = 1
				15000.0, 0.4};		-- Between 15 and 5 km  to target, Pn smoothly changes from 0.4 to 1.0. Longer then 15 km Pn = 0.4.
	
	shape_table_data =
	{
		{
			name  = "aim_7_H";
			file  = "aim-7";
			life  = 1;
			fire  = { 0, 1};
			username = "AIM-7MH";
			index 	 = WSTYPE_PLACEHOLDER,
		},
	},
	
	supersonic_A_coef_skew = 0.25, -- наклон прямой коэффициента отвала поляры на сверхзвуке
	nozzle_exit_area =	0.007238, -- площадь выходного сечения сопла
		
	ModelData = {   58 ,  -- model params count
					0.9 ,   -- characteristic square (характеристическая площадь)
			
					-- параметры зависимости Сx
					0.0125 , -- планка Сx0 на дозвуке ( M << 1)
					0.052 , -- высота пика волнового кризиса
					0.010 , -- крутизна фронта на подходе к волновому кризису
					0.002 , -- планка Cx0 на сверхзвуке ( M >> 1)
					0.5  , -- крутизна спада за волновым кризисом 
					1.2  , -- коэффициент отвала поляры
					
					-- параметры зависимости Cy
					2.20, -- планка Cya на дозвуке ( M << 1)
					1.05, -- планка Cya на сверхзвуке ( M >> 1)
					1.20, -- крутизна спада(фронта) за волновым кризисом  

					0.18, -- ~10 degrees Alfa_max  максимальный балансировачный угол, радианы
					0.00, --угловая скорость создаваймая моментом газовых рулей
					
					--	t_statr   t_b      t_accel  t_march   t_inertial   t_break  t_end
					-1.0,    -1.0 ,  	3.7  ,  10.8,      0.0,		   0.0,      1.0e9,           -- time interval
					 0.0,     0.0 ,   	10.4 ,  2.02,     0.0,         0.0,      0.0,           -- fuel flow rate in second kg/sec(секундный расход массы топлива кг/сек)
					 0.0,     0.0 ,   25192.0,  4140.0,   0.0,         0.0,      0.0,           -- thrust
					
					 1.0e9, -- таймер самоликвидации, сек
					 75.0, -- время работы энергосистемы
					 0.0, -- абсалютеая высота самоликвидации, м
					 1.5, -- время задержки включения управленя, сек
					 5000, -- дальность до цели в момент пуска, выше которой выполняется маневр набора высоты 
					 15000, -- дальность до цели на трассе, менее которой начинается завершение маневра набора высоты (длжен быть больше чем предылущий параметр) 
					 0.1,  -- синус угла возвышения траектории набора горки
					 50.0, -- продольное ускорения взведения взрывателя
					 0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
					 1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
					 1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
					 2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
					 -- ЗРП. Данные для рассчета дальностей пуска (индикация на прицеле)
					 14.0, -- производная дальности по скорости носителя на высоте 1км, ППС
					-21.0, -- производная дальности по скорости цели на высоте 1км, ЗПС
					-2.2, -- производная по высоте производной дальности по скорости цели, ЗПС
					 27000, -- дальность ракурс 180(навстречу) град, Н=5000м, V=900км/ч, м
					 7000.0, -- дальность ракурс 0(в догон) град, Н=5000м, V=900км/ч, м
					 38000.0, -- дальность ракурс 180(навстречу) град, Н=10000м, V=900км/ч, м
					 12000.0, -- дальность ракурс 0(в догон) град, Н=10000м, V=900км/ч, м
					 19000.0, -- дальность ракурс 180(навстречу) град, Н=1000м,  V=900км/ч, м
					 5000.0, -- дальность ракурс 0(в догон) град, Н=1000м, V=900км/ч, м
					 2500.0, -- смещение назад отнсительно нуля задней точки зоны достижимости
					 0.4, -- процент гарантированной дальности от дальности в ППС на высоте 1км
					-0.014, -- производная процента гарантированной дальности в ППС по высоте
					 0.5, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя.
				},
	
	controller = {
		boost_start = 0.5,
		march_start = 4.2,
	},
	
	boost = {
		impulse								= 247,
		fuel_mass							= 38.48,
		work_time							= 3.7,
		nozzle_position						= {{-1.9, 0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		nozzle_exit_area 					= 0.00724,
		tail_width							= 0.4,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.2,	
	},
	
	march = {
		impulse								= 209,
		fuel_mass							= 21.82,
		work_time							= 10.8,
		nozzle_position						= {{-1.9, 0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		nozzle_exit_area 					= 0.00724,
		tail_width							= 0.4,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.2,
	},
	
	fm = AIM_7_FM,
	
	proximity_fuze = {
		radius		= 12,
		arm_delay	= 1.6,
	},
	
	seeker = {
		delay					= 1.5,
		op_time					= 75,
		FOV						= math.rad(120),
		max_w_LOS				= math.rad(20),
		sens_near_dist			= 100,
		sens_far_dist			= 60000,
		ccm_k0					= 0.5,
		aim_sigma				= 5.5,
		height_error_k			= 100;
		height_error_max_vel	= 138;
		height_error_max_h		= 300;
		hoj						= 1,
	},

	autopilot = {
		x_channel_delay		= 0.9,
		delay				= 1.5,
		op_time				= 75,
		Kconv				= 4.0,
		Knv					= 0.02,
		Kd					= 0.4,
		Ki					= 0.1,
		Kout				= 1.0,
		Kx					= 0.1,
		Krx					= 2.0,
		fins_limit			= math.rad(20),
		fins_limit_x		= math.rad(5),
		Areq_limit			= 25.0,
		bang_bang			= 0,
		max_side_N			= 10,
		max_signal_Fi		= math.rad(12),
		rotate_fins_output	= 0,
		alg					= 0,
		PN_dist_data 		= {	15000,	1,
								9000,	1},
		null_roll			= math.rad(45),
		
		loft_active_by_default	= 1,
		loft_add_pitch			= math.rad(30),
		loft_time				= 3.5,
		loft_min_dist			= 6500,
		loft_max_dist			= 20000,
	},
}

declare_weapon(AIM_7H)


local AIM_7P = 
{
	category		= CAT_AIR_TO_AIR,
	name			= "AIM-7P",
	displayName		= _("AIM-7P Sparrow Semi-Active Radar"),
	user_name		= _("AIM-7P"),
	scheme			= "aa_missile_semi_active",
	class_name		= "wAmmunitionSelfHoming",
	model			= "aim-7",
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AA_Missile,WSTYPE_PLACEHOLDER},
	
	mass = 231,
	Escort = 1,
	Head_Type = 6,
	sigma = {5.6, 5, 5.6},
	M = 231,
	H_max = 24400.0,
	H_min = 1.0,
	Diam = 203.0,
	Cx_pil = 2.21,
	D_max = 20000.0,
	D_min = 1500.0,
	Head_Form = 1,
	Life_Time = 90.0,
	Nr_max = 25,
	v_min = 140.0,
	v_mid = 500.0,
	Mach_max = 3.2,
	t_b = 0.5,
	t_acc = 3.3,
	t_marsh = 11.0,
	Range_max = 50000.0,
	H_min_t = 15.0,
	Fi_start = 0.4,
	Fi_rak = 3.14152,
	Fi_excort = 1.05,
	Fi_search = 0.1,
	OmViz_max = 0.35,
	exhaust = {0.78, 0.78, 0.78, 0.3};
	X_back = -2.0,
	Y_back = -0.0,
	Z_back = 0.0, -- -0.1,
	Reflection = 0.08,
	KillDistance = 12.0,
	ccm_k0 = 0.5,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability) 
	loft = 1,
	hoj = 1,
	
	warhead		= predefined_warhead("AIM_7"),
	warhead_air = predefined_warhead("AIM_7"),
	
	PN_coeffs = {2, 				-- Number of Entries	
				5000.0 ,1.0,		-- Less 5 km to target Pn = 1
				15000.0, 0.4};		-- Between 15 and 5 km  to target, Pn smoothly changes from 0.4 to 1.0. Longer then 15 km Pn = 0.4.
	
	shape_table_data =
	{
		{
			name  = "aim_7_P";
			file  = "aim-7";
			life  = 1;
			fire  = { 0, 1};
			username = "AIM-7P";
			index 	 = WSTYPE_PLACEHOLDER,
		},
	},
	
	supersonic_A_coef_skew = 0.25, -- наклон прямой коэффициента отвала поляры на сверхзвуке
	nozzle_exit_area =	0.007238, -- площадь выходного сечения сопла
		
	ModelData = {   58 ,  -- model params count
					0.9 ,   -- characteristic square (характеристическая площадь)
			
					-- параметры зависимости Сx
					0.0125 , -- планка Сx0 на дозвуке ( M << 1)
					0.052 , -- высота пика волнового кризиса
					0.010 , -- крутизна фронта на подходе к волновому кризису
					0.002 , -- планка Cx0 на сверхзвуке ( M >> 1)
					0.5  , -- крутизна спада за волновым кризисом 
					1.2  , -- коэффициент отвала поляры
					
					-- параметры зависимости Cy
					2.20, -- планка Cya на дозвуке ( M << 1)
					1.05, -- планка Cya на сверхзвуке ( M >> 1)
					1.20, -- крутизна спада(фронта) за волновым кризисом  

					0.18, -- ~10 degrees Alfa_max  максимальный балансировачный угол, радианы
					0.00, --угловая скорость создаваймая моментом газовых рулей
					
					--	t_statr   t_b      t_accel  t_march   t_inertial   t_break  t_end
					-1.0,    -1.0 ,  	3.7  ,  10.8,      0.0,		   0.0,      1.0e9,           -- time interval
					 0.0,     0.0 ,   	10.4 ,  2.02,     0.0,         0.0,      0.0,           -- fuel flow rate in second kg/sec(секундный расход массы топлива кг/сек)
					 0.0,     0.0 ,   25192.0,  4140.0,   0.0,         0.0,      0.0,           -- thrust
					
					 1.0e9, -- таймер самоликвидации, сек
					 75.0, -- время работы энергосистемы
					 0.0, -- абсалютеая высота самоликвидации, м
					 1.5, -- время задержки включения управленя, сек
					 5000, -- дальность до цели в момент пуска, выше которой выполняется маневр набора высоты 
					 15000, -- дальность до цели на трассе, менее которой начинается завершение маневра набора высоты (длжен быть больше чем предылущий параметр) 
					 0.1,  -- синус угла возвышения траектории набора горки
					 50.0, -- продольное ускорения взведения взрывателя
					 0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
					 1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
					 1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
					 2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
					 -- ЗРП. Данные для рассчета дальностей пуска (индикация на прицеле)
					 14.0, -- производная дальности по скорости носителя на высоте 1км, ППС
					-21.0, -- производная дальности по скорости цели на высоте 1км, ЗПС
					-2.2, -- производная по высоте производной дальности по скорости цели, ЗПС
					 27000, -- дальность ракурс 180(навстречу) град, Н=5000м, V=900км/ч, м
					 7000.0, -- дальность ракурс 0(в догон) град, Н=5000м, V=900км/ч, м
					 38000.0, -- дальность ракурс 180(навстречу) град, Н=10000м, V=900км/ч, м
					 12000.0, -- дальность ракурс 0(в догон) град, Н=10000м, V=900км/ч, м
					 19000.0, -- дальность ракурс 180(навстречу) град, Н=1000м,  V=900км/ч, м
					 5000.0, -- дальность ракурс 0(в догон) град, Н=1000м, V=900км/ч, м
					 2500.0, -- смещение назад отнсительно нуля задней точки зоны достижимости
					 0.4, -- процент гарантированной дальности от дальности в ППС на высоте 1км
					-0.014, -- производная процента гарантированной дальности в ППС по высоте
					 0.5, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя.
				},
	
	controller = {
		boost_start = 0.5,
		march_start = 4.2,
	},
	
	boost = {
		impulse								= 247,
		fuel_mass							= 38.48,
		work_time							= 3.7,
		nozzle_position						= {{-1.9, 0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		nozzle_exit_area 					= 0.00724,
		tail_width							= 0.4,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.2,	
	},
	
	march = {
		impulse								= 209,
		fuel_mass							= 21.82,
		work_time							= 10.8,
		nozzle_position						= {{-1.9, 0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		nozzle_exit_area 					= 0.00724,
		tail_width							= 0.4,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.2,
	},
	
	fm = AIM_7_FM,
	
	proximity_fuze = {
		radius		= 12,
		arm_delay	= 1.6,
	},
	
	seeker = {
		delay					= 1.5,
		op_time					= 75,
		FOV						= math.rad(120),
		max_w_LOS				= math.rad(20),
		sens_near_dist			= 100,
		sens_far_dist			= 60000,
		ccm_k0					= 0.5,
		aim_sigma				= 5.5,
		height_error_k			= 100;
		height_error_max_vel	= 138;
		height_error_max_h		= 300;
		hoj						= 1,
		rad_correction			= 1,
	},

	autopilot = {
		x_channel_delay		= 0.9,
		delay				= 1.5,
		op_time				= 75,
		Kconv				= 4.0,
		Knv					= 0.02,
		Kd					= 0.4,
		Ki					= 0.1,
		Kout				= 1.0,
		Kx					= 0.1,
		Krx					= 2.0,
		fins_limit			= math.rad(20),
		fins_limit_x		= math.rad(5),
		Areq_limit			= 25.0,
		bang_bang			= 0,
		max_side_N			= 10,
		max_signal_Fi		= math.rad(12),
		rotate_fins_output	= 0,
		alg					= 0,
		PN_dist_data 		= {	15000,	1,
								9000,	1},
		null_roll			= math.rad(45),
		
		loft_active_by_default	= 1,
		loft_add_pitch			= math.rad(30),
		loft_time				= 3.5,
		loft_min_dist			= 6500,
		loft_max_dist			= 20000,
	},
}

declare_weapon(AIM_7P)

local function single_aim_7(clsid, element)
	declare_loadout({
	    CLSID	    = clsid,
	    category	= CAT_AIR_TO_AIR,
	    Picture	    = "us_AIM-7.png",
        PictureBlendColor = "0xffffffff",
	    displayName	= element.displayName,
	    Weight		= element.mass,
	    attribute	= element.wsTypeOfWeapon,
	    Elements	=	
	    {
		    [1]	=	
		    {
			    DrawArgs	=	
			    {
				    [1]	=	{1,	1},
				    [2]	=	{2,	1},
				    [3]	=	{3,	1},
			    }, -- end of DrawArgs
			    Position	=	{0,	0,	0},
			    ShapeName	=	element.model,
		    }, 
	    }, -- end of Elements
    })
end


local function lau_115_aim_7(clsid, element, elem_CLSID)
	local ret = {
		category			=	CAT_AIR_TO_AIR,
		CLSID				=	clsid,
		Picture				=	"us_AIM-7.png",
        PictureBlendColor   =   "0xffffffff",
		wsTypeOfWeapon		=	element.wsTypeOfWeapon, -- !ATTENTION wsTypeOfWeapon cannot be intermediate container - it always should be actual final weapon type 
		attribute			=	{4,	4,	32,	WSTYPE_PLACEHOLDER},
		Cx_pil				=	0.000894765625,
		Count				=	1,
		Weight				=	lau115_weight + element.mass,
		Elements			=	
		{
			{	ShapeName	=	"LAU-115C"	   	  ,	IsAdapter  	   =   true  }, 
--			{	ShapeName	= element.shape_table_data.name,	connector_name =  "Point01"},
			{	payload_CLSID = elem_CLSID ,	connector_name =  "Point01"}
		}-- end of Elements
	}
	ret.displayName =	_("LAU-115C with").." "..element.displayName
	declare_loadout(ret)
end

local CLSID_7M = "{8D399DDA-FF81-4F14-904D-099B34FE7918}"

single_aim_7("{AIM-7E}", AIM_7E)
single_aim_7("{AIM-7F}", AIM_7F)
single_aim_7(CLSID_7M, AIM_7M)
single_aim_7("{AIM-7H}", AIM_7H)
single_aim_7("{AIM-7P}", AIM_7P)

lau_115_aim_7("{LAU-115 - AIM-7E}", AIM_7E, "{AIM-7E}")
lau_115_aim_7("{LAU-115 - AIM-7F}", AIM_7F, "{AIM-7F}")
lau_115_aim_7("{LAU-115 - AIM-7M}", AIM_7M, CLSID_7M)
lau_115_aim_7("{LAU-115 - AIM-7H}", AIM_7H, "{AIM-7H}")
lau_115_aim_7("{LAU-115 - AIM-7P}", AIM_7P, "{AIM-7P}")
