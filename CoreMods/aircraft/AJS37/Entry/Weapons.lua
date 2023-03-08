--/N/ jan 2015

-- Headtypes
-- // тип головки самонаведения ГСН:
-- const int InfraredSeeker = 1;    // Thermal IR (infrared seeker)
-- const int ActiveRadar        = 2;    //  (active radar (AR) (+ИНС)) 
-- const int AntiRadar          = 3;    // (Passive radar +INS)
-- const int LaserHoming        = 4;    // Laser illumination (+INS)
-- const int Autopilot          = 5;    // Autonmous (INS+ Card, GPS,TV,IIR...)
-- const int SemiActiveRadar    = 6;    // semi-active radar (SAR) 
-- const int SemiAutoAT	    = 7;	// semi-automatic control with a platform for anti-tank systems , fly to woPoint, coordinates woPoint change platform.

-- Highest possible number seems to be ~25772

local wsType_LYSBOMB = 11030
--11019 = A (01) J (10) S (19) + 11 => 11030
local wsType_BK90 = 11031
local wsType_BK90MJ1 = 11053
local wsType_BK90MJ2 = 11054
local wsType_BK90Test = 11032
local wsType_HEBOMB = 11033
local wsType_HEBOMBDrag = 11034
local wsType_Rb05 = 11035
local wsType_AKAN = 11036
local wsType_AKANPOD = 11055
local wsType_Rb24 = 11037
local wsType_Rb24J = 11038
local wsType_Rb74 = 11039
local wsType_Rb04 = 11040
local wsType_Rb15 = 11041
local wsType_Rb04AI = 11042
local wsType_Rb15AI = 11043
local wsType_ARAK70HE = 11044
local wsType_ARAK70HEPOD = 11048
local wsType_ARAK70AP = 11049
local wsType_ARAK70APPOD = 11056
local wsType_KB = 11045
local wsType_U22 = 11046
local wsType_U22A = 11047
local wsType_RB75 = 11050
local wsType_RB75T = 11051
local wsType_RB75B = 11052

local function calcPiercingMass(warhead)
	warhead.piercing_mass = warhead.mass;
	if (warhead.expl_mass/warhead.mass > 0.1) then
		warhead.piercing_mass = warhead.mass/5.0;
	end
end

local explosivePercent = 1--0.8

local function simple_aa_warhead(power, caliber) -- By Saint /N/
 local res = {};

	res.mass = 1.1*power;--power;
	res.expl_mass = power;
	res.other_factors = {1, 1, 1};
	res.obj_factors = {1, 1};
	res.concrete_factors = {1, 1, 1};
	res.cumulative_factor = 0;
	res.concrete_obj_factor = 0.0;
	res.cumulative_thickness = 0.0;
	res.caliber = caliber;

	calcPiercingMass(res)
 return res;
end

local function enhanced_a2a_warhead(power, caliber) -- By Yoda /N/
 local res = {};

	res.expl_mass = 1.7*power;
	res.mass = res.expl_mass;
	res.other_factors = {1, 1, 1};
	res.obj_factors = {1, 1};
	res.concrete_factors = {1, 1, 1};
	res.cumulative_factor = 0;
	res.concrete_obj_factor = 0.0;
	res.cumulative_thickness = 0.0;
	res.caliber = caliber;

	calcPiercingMass(res)
 return res;
end

local function simple_warhead(power, caliber)
 local res = {};

	res.caliber = caliber
	res.expl_mass = power*explosivePercent; --new explosion damage effect (explosive + fragments)
	res.mass = res.expl_mass;
	res.other_factors = {1, 1, 1};
	res.obj_factors = {1, 1};
	res.concrete_factors = {1, 1, 1};
	res.cumulative_factor = 0;
	res.concrete_obj_factor = 0.0;
	res.cumulative_thickness = 0.0;

	calcPiercingMass(res)
 return res;
end

local function cumulative_warhead(power, caliber)
 local res = {};
	res.caliber = caliber or 120
	res.expl_mass = power*explosivePercent;
	res.mass = res.expl_mass;
	res.other_factors = {1, 1, 1};
	res.obj_factors = {1, 1};
	res.concrete_factors = {1, 1, 1};
	res.cumulative_factor = 10.0;
	res.concrete_obj_factor = 0.0;
	res.cumulative_thickness = 0.2;

	calcPiercingMass(res)
 return res;
end

local function penetrating_warhead(power, piercing_mass, caliber)
 local res = {};

	res.expl_mass = power*explosivePercent;
	res.mass = res.expl_mass;
	res.other_factors = {1, 1, 1};
	res.obj_factors = {1, 1};
	res.concrete_factors = {1, 1, 10};
	res.cumulative_factor = 5.0;
	res.concrete_obj_factor = 5.0;
	res.cumulative_thickness = 0.0;
	res.piercing_mass = piercing_mass;
	res.caliber = caliber;

	calcPiercingMass(res)
	return res;
end

function HE_penetrating_warhead(power,caliber)
	local res = {};
	
	res.caliber = caliber;
    res.expl_mass = power;
	res.mass = res.expl_mass;
    res.other_factors = { 0.5, 0.5, 0.5 };
    res.obj_factors = {1, 1};
    res.concrete_factors = {1, 1, 1};
    res.concrete_obj_factor = 2.0;
	res.cumulative_factor = 0.0;    
    res.cumulative_thickness = 0.0;
    
    calcPiercingMass(res)
	return res;
end


local function mbd3_full(shape)
	return 	{
		mbd3_u6_adapter,
		mbd3_u6_element(shape,6),
		mbd3_u6_element(shape,5),
		mbd3_u6_element(shape,4),
		mbd3_u6_element(shape,3),
		mbd3_u6_element(shape,2),
		mbd3_u6_element(shape,1),
	}
end

local function aircraft_gunpod(gunpod_name, ...)
    local type = _G[gunpod_name];
    if type == nil then
        error("Unknown type for "..gunpod_name);
    end
	aircraft_gunpod_with_wstype(gunpod_name,type,arg)
end

local function aircraft_gunpod_with_wstype(gunpod_name,wstype,mounts)
	--print(gunpod_name)
    local res = dbtype("wAircraftGunpodEquipment", {
        ws_type     = wstype;
		gunpod_name  = gunpod_name;
    });
	if not res.short_name then 
		   res.short_name = gunpod_name
	end
	if not res.display_name then 
		   res.display_name = res.short_name
	end
    res.mounts = {};
	
    for i, v in ipairs(mounts) do
        res.mounts[i] = v;
    end
    weapons_table.aircraft_gunpods[gunpod_name] = res
end

warhead = {}
--AA MISSILES
warhead["Rb24"] = enhanced_a2a_warhead(4.5, 127); -- /Ragnar: 4.8kg? Using same "calibre" as R-13M above
warhead["Rb74"] =  enhanced_a2a_warhead(9.4, 127); -- 2.9kg according to Arboga Robot Museum webpage,  ARBOGA IS USUALLY QUITE WRONG.


-- ROCKETS

-- AG MISSILES
warhead["Rb05"] = penetrating_warhead(160, 125, 300);--(150, 125, 275 Tweaked by Jedi

warhead["Rb04"]  = penetrating_warhead(1400.0, 500); --= penetrating_warhead(700, 500);--160 is far to weak... -- simple_warhead was 700

warhead["huge"] = simple_warhead(700*12,450)

warhead["m71"] = simple_warhead(125,450); -- Explosive 60 kg + fragments bonus

warhead["none"] = simple_warhead(1,1)

warhead["Rb75"] = penetrating_warhead(57,305)
warhead["Rb75T"] = simple_warhead(130,305)


-- AKAN/Aden cannon


    declare_weapon({category = CAT_SHELLS, name = "MINGR55", user_name = _("MINGR55"),
        model_name      = "tracer_bullet_white",
		mass      = 0.242,
		round_mass = 0.22,
        cartridge_mass  = 0.031 + 0.009, -- Empty shell
        explosive       = 0.242,--0.26,--0.0000, 0.052 latest
        v0              = 790.0,
        Dv0             = 0.0040,
        Da0             = 0.001,
        Da1             = 0.0,
        life_time       = 100.0,
        caliber         = 30,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.912, 0.7, 0.25, 1.80},
        k1              = 4.8e-08,
        tracer_off      = 6.1,
        tracer_on       = 0.01,
        smoke_tail_life_time = 1.5,
        scale_tracer    = 1,
        cartridge       = 0,
        scale_smoke     = 1,
        smoke_opacity   = 0.1,
    })


----------------------------------------------------------------------------------------------------------------	
    -- AKAN_MOUNT 
local function AKAN_MOUNT ( tbl )
	tbl.category = CAT_GUN_MOUNT
	tbl.name = "AKAN"
	tbl.supply = {
		shells = {"MINGR55", "MINGR55", "MINGR55"},
		mixes = {{1, 2, 3, 1, 2, 3}},
		count = 150,
	}
	if tbl.mixes then
		tbl.supply.mixes = tbl.mixes
		tbl.mixes = nil
	end
	if tbl.count then
		tbl.supply.count = tbl.count
		tbl.count = nil
	end
	tbl.gun = {
		max_burst_length = 65535,
		rates = {1380}, -- unsynchronized mount
		recoil_coeff = 0.7*1.3*0,
		barrels_count = 1,
	}
	if tbl.rates then
		tbl.gun.rates = tbl.rates
		tbl.rates = nil
	end
	tbl.ejector_pos = tbl.ejector_pos or {0.0, 0.05, 0.0}
	tbl.ejector_dir = tbl.ejector_dir or {0, -1, 0}
	tbl.effect_arg_number = tbl.effect_arg_number or 436
	tbl.supply_position = tbl.supply_position or {0, 0.3, -0.3}
	tbl.aft_gun_mount = false
	tbl.effective_fire_distance = 2000
	--tbl.drop_cartridge = 204
	tbl.muzzle_pos = {0, 0, 0} -- all position from connector
	tbl.azimuth_initial = tbl.azimuth_initial or 0.0
	tbl.elevation_initial = tbl.elevation_initial or 0
	return declare_weapon(tbl)
end
	

declare_loadout({
	category      =  CAT_PODS,
	CLSID         = "{AKAN}",
	attribute     = {wsType_Weapon,wsType_GContainer,wsType_Cannon_Cont,WSTYPE_PLACEHOLDER},
	Picture       = "AKANM55.png",
	displayName   = _("AKAN M/55 Gunpod, 150 rnds MINGR55-HE"),
	Weight        = 276,
	Cx_pil        = 0.001220703125,
	Elements      	 = {{ShapeName = "AKANM55"}},
	shape_table_data = {{file  	 = 'AKANM55',	username = 'AKANM55',index    =  WSTYPE_PLACEHOLDER}},
	kind_of_shipping = 2,--SOLID_MUNITION
	gun_mounts  = { AKAN_MOUNT({ muzzle_pos_connector   = "Point_Gun",
								 effect_arg_number 	   = 433,
								 ejector_pos_connector  = "eject 2",
								 effects = {{name = "FireEffect", arg = 433 , attenuation = 1.0 , light_pos = {0.5,0.5,0} , light_time = 0.1},
											{name = "SmokeEffect"},
								 }
					})
	}
})
--wstype_containers[wsType_AKAN]  	= {wsType_Weapon, wsType_GContainer, wsType_Cannon_Cont}
--aircraft_gunpod_with_wstype(gunpod_name,wstype,mounts)
--aircraft_gunpod_with_wstype("wsType_AKAN", wsType_AKAN ,gun_mount("GSh_23_UPK", { count = 250}, {muzzle_pos = {1.257,-0.12,0.0}, ejector_pos = {-0.7, -0.1,  0.0},			effects = {fire_effect(15),smoke_effect()} } ));


-- MISSILES
local lau117_mass = 37.6

local Rb24 = {

	category		= CAT_AIR_TO_AIR,
	name			= "Rb 24",
	user_name		= _("Rb 24"),
	-- wrong -> wsTypeOfWeapon = {4, 4, 11, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AA_Missile, wsType_Rb24},
	NatoName		=	"(Rb24)",
	

	shape_table_data =
	{
		{
			name	 = "Robot24";
			file  = "aim-9b"; -- <-- replace this file name with proper one
			life  = 1;
			fire  = { 0, 1};
			username = "Robot 24";
			index = wsType_Rb24,
		},
	},
		Escort 			= 0,
		Head_Type 		= 1,
		sigma 			= {3, 3, 3},
		M 				= 74.39,
		H_max 			= 18000.0,
		H_min 			= -1,
		Diam 			= 127.0,
		Cx_pil			= 0.4, -- WH: Bogus value to provide appropriate drag before and after launch (eliminating negative pylon drag).
		D_max 			= 4000.0,
		D_min 			= 300.0,
		Head_Form 		= 0,
		Life_Time 		= 30.0,
		Nr_max 			= 10,
		v_min 			= 140.0,
		v_mid 			= 350.0,
		Mach_max 		= 2.2,
		t_b 			= 0.0,
		t_acc			= 2.2,
		t_marsh			= 0.0,
		Range_max		= 11000.0,
		H_min_t		    = 1.0,
		Fi_start 		= 0.3,
		Fi_rak 		    = 1.1,
		Fi_excort 		= 0.44,
		Fi_search 		= 0.044,
		OmViz_max 		= 0.2,
        warhead	 		= warhead["Rb24"],
		exhaust 		=  { 1, 1, 1, 1 },
		X_back 			= -1.55,
		Y_back 			= 0.0,
		Z_back			= 0.0,
		Reflection		= 0.03,
		KillDistance 	= 9.0,
		ccm_k0 = 10.0,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
		--seeker sensivity params
		SeekerSensivityDistance = 4000, -- The range of target with IR value = 1. In meters. In forward hemisphere.
		SeekerCooled	 = false, -- True is cooled seeker and false is not cooled seeker.		
		
	ModelData = 
	{   58 ,  -- model params count
		0.35 ,   -- characteristic square (характеристическая площадь)
		
		-- параметры зависимости Сx
		0.04 , -- Cx_k0 планка Сx0 на дозвуке ( M << 1)
		0.08 , -- Cx_k1 высота пика волнового кризиса
		0.02 , -- Cx_k2 крутизна фронта на подходе к волновому кризису
		0.05, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1)
		1.2 , -- Cx_k4 крутизна спада за волновым кризисом 
		1.2 , -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))
		
		-- параметры зависимости Cy
		0.5 , -- Cy_k0 планка Сy0 на дозвуке ( M << 1)
		0.4	 , -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)
		1.2  , -- Cy_k2 крутизна спада(фронта) за волновым кризисом  
		
		0.29 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
		0.0, --угловая скорость создаваймая моментом газовых рулей
		
	-- Engine data. Time, fuel flow, thrust.	
	--	t_statr		t_b		t_accel		t_march		t_inertial		t_break		t_end		-- Stage
		-1.0,		-1.0,	2.2,  		0.0,		0.0,			0.0,		1.0e9,      -- time of stage, sec
		 0.0,		0.0,	8.45,		0.0,		0.0,			0.0,		0.0,        -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
		 0.0,		0.0,	17150.0,	0.0,		0.0,			0.0,		0.0,        -- thrust, newtons
	
		 25.0, -- таймер самоликвидации, сек
		 21.5, -- время работы энергосистемы, сек
		 0, -- абсолютная высота самоликвидации, м
		 0.5, -- время задержки включения управления (маневр отлета, безопасности), сек
		 1.0e9, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр "горка", м
		 1.0e9, -- дальность до цели, при которой маневр "горка" завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м 
		 0.0,  -- синус угла возвышения траектории набора горки
		 30.0, -- продольное ускорения взведения взрывателя
		 0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
		 1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
		 1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
		 2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
		 0.0,
		 0.0,
		 0.0,
		 0.0,
		 0.0,
		  -- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
		 9000.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
		 4000.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч, м
		 4000.0, -- дальность ракурс 	180(навстречу) град, Н=1000м, V=900км/ч, м
		 0.2, -- Уменьшение разрешенной дальности пуска при отклонении вектора скорости носителя от линии визирования цели.
		 1.0, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в нижнюю полусферу. Уменьшение дальности при стрельбе вниз.
		 1.4, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в верхнюю полусферу. Увеличение дальности при стрельбе вверх.
		-3.0, -- Вертикальная плоскость. Угол перегиба кривой разрешенной дальности, верхняя - нижняя полусфера.
		 0.5, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя.
	},
		
		
	
}

declare_weapon(Rb24)

declare_loadout(
	{		
		category			= CAT_AIR_TO_AIR,
		CLSID				= "{Robot24}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_Rb24},
		wsTypeOfWeapon		= Rb24.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "aim9p.png",
		displayName			= _("Rb-24 (AIM-9B) Sidewinder IR AAM"),
		Weight				= 112, 
		Weight_Empty		= lau117_mass,
		Cx_pil				= 0.00016,
		Elements			={
			[1]	=
			{
				Position	=	{0, 0, 0},
				ShapeName	=	"aero-3b", --<-- /N/  put the launcher shape name here if any
				IsAdapter 	= true,
			},
			[2]	=
			{
				Position	=	{0.0,	-0.125,	0}, 
				ShapeName	=	"aim-9b", --<-- /N/  put the missile shape name here
			},
		},
	}
)

local Rb24J = { 

	category		= CAT_AIR_TO_AIR,
	name			= "Rb 24J",
	user_name		= _("Rb 24J"),
	--/N/ wrong -> wsTypeOfWeapon = {4, 4, 11, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AA_Missile, wsType_Rb24J},
	NatoName		=	"(Rb24J)",
	

	shape_table_data =
	{
		{
			name	 = "Robot24J";
			file  = "aim-9p5"; -- <--/N/ replace this file name with proper one
			life  = 1;
			fire  = { 0, 1};
			username = "Robot 24J";
			index = wsType_Rb24J,
		},
	},

        Escort = 0,
        Head_Type = 1,
		sigma = {3, 3, 3},
        M = 81.4,
        H_max = 18000.0,
        H_min = -1,
        Diam = 127.0,
        Cx_pil = 0.4, -- WH: Bogus value to provide appropriate drag before and after launch (eliminating negative pylon drag).
        D_max = 7000.0,
        D_min = 300.0,
        Head_Form = 0,
        Life_Time = 40.0,
        Nr_max = 22,
        v_min = 140.0,
        v_mid = 350.0,
        Mach_max = 2.2,
        t_b = 0.0,
        t_acc = 5.0,
        t_marsh = 0.0,
        Range_max = 14000.0,
        H_min_t = 1.0,
        Fi_start = 0.3,
        Fi_rak = 3.14152,
        Fi_excort = 0.7,
        Fi_search = 0.031,
        OmViz_max = 0.28,
        warhead = warhead["Rb24"],
		exhaust =  { 0.7, 0.7, 0.7, 1.0 };
		X_back 	= -1.46,
		Y_back 	= 0.0,
		Z_back	= 0.0,
        Reflection = 0.03,
        KillDistance = 9.0,
		--seeker sensivity params
		SeekerSensivityDistance = 5000, -- The range of target with IR value = 1. In meters. In forward hemisphere.
		ccm_k0 = 3.0,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
		SeekerCooled			= false, -- True is cooled seeker and false is not cooled seeker.	
		
		ModelData = {   58 ,  -- model params count
						0.35 ,   -- characteristic square (характеристическая площадь)
						
						-- параметры зависимости Сx
						0.049 , -- Cx_k0 планка Сx0 на дозвуке ( M << 1)
						0.082 , -- Cx_k1 высота пика волнового кризиса
						0.01 , -- Cx_k2 крутизна фронта на подходе к волновому кризису
						0.001, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1)
						0.55 , -- Cx_k4 крутизна спада за волновым кризисом 
						0.8 , -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))
						
						-- параметры зависимости Cy
						2.5 , -- Cy_k0 планка Сy0 на дозвуке ( M << 1)
						0.8	 , -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)
						1.2  , -- Cy_k2 крутизна спада(фронта) за волновым кризисом  
						
						0.13 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
						0.0, --угловая скорость создаваймая моментом газовых рулей
						
					-- Engine data. Time, fuel flow, thrust.	
					--	t_statr		t_b		t_accel		t_march		t_inertial		t_break		t_end			-- Stage
						-1.0,		-1.0,	2.2,  		0.0,		0.0,			0.0,		1.0e9,         -- time of stage, sec
						0.0,		0.0,	8.45,		0.0,		0.0,			0.0,		0.0,           -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
						0.0,		0.0,	17800.0,	0.0,		0.0,			0.0,		0.0,           -- thrust, newtons
					
						45, -- таймер самоликвидации, сек
						40.0, -- время работы энергосистемы, сек
						0, -- абсолютная высота самоликвидации, м
						0.3, -- время задержки включения управления (маневр отлета, безопасности), сек
						1.0e9, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр "горка", м
						1.0e9, -- дальность до цели, при которой маневр "горка" завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м 
						0.0,  -- синус угла возвышения траектории набора горки
						30.0, -- продольное ускорения взведения взрывателя
						0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
						1.2, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
						1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
						2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
						9.0,
						-11.0,
						-1.4,
						10500.0,
						2800.0,
						 -- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
						17000.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
						5500.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч, м
						6700.0, -- дальность ракурс 	180(навстречу) град, Н=1000м, V=900км/ч, м
						2000.0, -- Уменьшение разрешенной дальности пуска при отклонении вектора скорости носителя от линии визирования цели.
						2500.0, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в нижнюю полусферу. Уменьшение дальности при стрельбе вниз.
						0.55, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в верхнюю полусферу. Увеличение дальности при стрельбе вверх.
						-0.01, -- Вертикальная плоскость. Угол перегиба кривой разрешенной дальности, верхняя - нижняя полусфера.
						0.5, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя.
					},
		
		
	
}

declare_weapon(Rb24J)

declare_loadout(
	{		
		category			= CAT_AIR_TO_AIR,
		CLSID				= "{Robot24J}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_Rb24J},
		wsTypeOfWeapon		= Rb24J.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "aim9p.png",
		displayName			= _("Rb-24J (AIM-9P) Sidewinder IR AAM"),
		Weight				= 119, -- WH: Found 81kg as mass for the RB24J online; added the lau117.
		Weight_Empty		= lau117_mass,
		Cx_pil				= 0.00016,
		Elements			={
			[1]	=
			{
				Position	=	{0, 0, 0},
				ShapeName	=	"aero-3b", --<-- /N/  put the launcher shape name here if any
				IsAdapter 	= true,
			},
			[2]	=
			{
				Position	=	{0.0,	-0.125,	0}, 
				ShapeName	=	"aim-9p5", --<-- /N/  put the missile shape name here
			},
		},
	}
)
local Rb74 = { 

	category		= CAT_AIR_TO_AIR,
	name			= "Rb 74",
	user_name		= _("Rb 74"),
	--/N/ wrong -> wsTypeOfWeapon = {4, 4, 11, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AA_Missile, wsType_Rb74},
	NatoName		=	"(Rb74)",
	

	shape_table_data =
	{
		{
			name	 = "Robot74";
			file  = "AIM-9L"; -- <--/N/ replace this file name with proper one
			life  = 1;
			fire  = { 0, 1};
			username = "Robot 74";
			index = wsType_Rb74,
		},
	},

        Escort = 0,
        Head_Type = 1,
		sigma = {3, 3, 3},
        M = 85.4,
        H_max = 18000.0,
        H_min = -1,
        Diam = 127.0,
        Cx_pil = 0.4, -- WH: Bogus value to provide appropriate drag before and after launch (eliminating negative pylon drag).
        D_max = 7000.0,
        D_min = 300.0,
        Head_Form = 0,
        Life_Time = 60.0,
        Nr_max = 32,
        v_min = 140.0,
        v_mid = 350.0,
        Mach_max = 2.7,
        t_b = 0.0,
        t_acc = 5.0,
        t_marsh = 0.0,
        Range_max = 14000.0,
        H_min_t = 1.0,
        Fi_start = 0.3,
        Fi_rak = 3.14152,
        Fi_excort = 0.79,
        Fi_search = 0.031,
        OmViz_max = 0.44,
        warhead = warhead["Rb74"],
		exhaust = { 0.7, 0.7, 0.7, 1.0 },
		X_back = -1.66,
		Y_back = 0.0,
		Z_back = 0.0,
        Reflection = 0.0182,
        KillDistance = 9.0,
		--seeker sensivity params
		SeekerSensivityDistance = 20000, -- The range of target with IR value = 1. In meters. In forward hemisphere.
		ccm_k0 = 0.75,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
		SeekerCooled			= true, -- True is cooled seeker and false is not cooled seeker.	

		supersonic_A_coef_skew = 0.25, -- наклон прямой коэффициента отвала поляры на сверхзвуке
		nozzle_exit_area =	0.0068, -- площадь выходного сечения сопла

		
		ModelData = {   58,  -- model params count
						0.35,   -- characteristic square (характеристическая площадь)
		
						-- параметры зависимости Сx
						0.049, -- Cx_k0 планка Сx0 на дозвуке ( M << 1)
						0.082, -- Cx_k1 высота пика волнового кризиса
						0.010, -- Cx_k2 крутизна фронта на подходе к волновому кризису
						0.001, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1)
						0.550, -- Cx_k4 крутизна спада за волновым кризисом 
						0.8, -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))
							
						-- параметры зависимости Cy
						2.5, -- Cy_k0 планка Сy0 на дозвуке ( M << 1)
						0.8, -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)
						1.2, -- Cy_k2 крутизна спада(фронта) за волновым кризисом  
							
						0.13, -- 7 Alfa_max  максимальный балансировачный угол, радианы
						0.00, --угловая скорость создаваймая моментом газовых рулей
							
					-- Engine data. Time, fuel flow, thrust.	
					--	t_statr		t_b		t_accel		t_march		t_inertial		t_break		t_end			-- Stage
						-1.0,	   -1.0,	5.20,  		0.0,		0.0,			0.0,		1.0e9,         -- time of stage, sec
						 0.0,		0.0,	5.27,		0.0,		0.0,			0.0,		0.0,           -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
						 0.0,		0.0,	11890.0,	0.0,		0.0,			0.0,		0.0,           -- thrust, newtons
						
						65, -- таймер самоликвидации, сек
						60.0, -- время работы энергосистемы, сек
						0, -- абсолютная высота самоликвидации, м
						0.4, -- время задержки включения управления (маневр отлета, безопасности), сек
						1.0e9, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр "горка", м
						1.0e9, -- дальность до цели, при которой маневр "горка" завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м 
						0.0,  -- синус угла возвышения траектории набора горки
						30.0, -- продольное ускорения взведения взрывателя
						0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
						1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
						1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
						2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
						9.0,
						-13.0,
						-2.1,
						15500.0,
						5500.0,
						-- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
						27000.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
						10000.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч, м
						10500.0, -- дальность ракурс 	180(навстречу) град, Н=1000м, V=900км/ч, м
						3500.0, -- Уменьшение разрешенной дальности пуска при отклонении вектора скорости носителя от линии визирования цели.
						2500.0, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в нижнюю полусферу. Уменьшение дальности при стрельбе вниз.
						0.55, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в верхнюю полусферу. Увеличение дальности при стрельбе вверх.
						-0.01, -- Вертикальная плоскость. Угол перегиба кривой разрешенной дальности, верхняя - нижняя полусфера.
						0.5, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя.
					},
		
		
	
}

declare_weapon(Rb74)

declare_loadout(
	{		
		category			= CAT_AIR_TO_AIR,
		CLSID				= "{Robot74}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_Rb74},
		wsTypeOfWeapon		= Rb74.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "aim9m.png",
		displayName			= _("Rb-74 (AIM-9L) Sidewinder IR AAM"),
		Weight				= 123, -- WH: Found a weight of 85kg online for the missile.
		Weight_Empty		= lau117_mass,
		Cx_pil				= 0.00016,
		Elements			={
			[1]	=
			{
				Position	=	{0, 0, 0},
				ShapeName	=	"aero-3b", --<-- /N/  put the launcher shape name here if any
				IsAdapter 	= true,
			},
			[2]	=
			{
				Position	=	{0.0,	-0.10,	0}, 
				ShapeName	=	"AIM-9L", --<-- /N/  put the missile shape name here
			},
		},
	}
)

local Rb05 = { --Kh_23M

	category		= CAT_MISSILES,
	name			= "Rb 05A",
	user_name		= _("Rb 05A"),
	--/N/ wrong -> wsTypeOfWeapon = {4, 4, 11, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon = {4, 4, 8, wsType_Rb05},
	NatoName		=	"(Rb05A)",
	

	shape_table_data =
	{
		{
			name	 = "Robot05";
			file  = "LNS_RB05A"; -- <--/N/ replace this file name with proper one
			life  = 1;
			fire  = { 0, 1};
			username = "Robot 05";
			index = wsType_Rb05,
		},
	},


	--/N/ missile data
	Escort = 1,
	Head_Type = 4, --/N/ 6 semi active radar, 4 laser /OR/ 7 semi auto
	sigma = {3, 3, 3},--{1.27, 1.55, 1.27},
	M = 288.0,
	H_max = 17000.0,
	H_min = -1,
	Diam = 300.0,
	Cx_pil = 0.3, -- WH: Bogus value to provide appropriate drag before and after launch (eliminating negative pylon drag).
	D_max = 11000.0, -- <--/N/ max launch distance, correct if needed
	D_min = 1000.0, -- <--/N/ min launch distance
	Head_Form = 1, -- <--/N/ 1- cone, 0 - semi-sphere
	Life_Time = 45.0,
	Nr_max = 8,
	v_min = 100.0,--, -- <--/N/ min speed in m/s
	v_mid = 850.0,-- -- <--/N/ max speed in m/s
	Mach_max = 1.8,--2.1, -- Mach 1.6-7 according to del 5. Reaches max speed after about 5 seconds and starts slowing down after 7.
	t_b = 0.0,
	t_acc = 0.5,
	t_marsh = 5.00,
	Range_max = 11000.0, -- 
	H_min_t = 0.0,
	Fi_start = 0.5,
	Fi_rak = 3.14152,
	Fi_excort = 1.55,
	Fi_search = 99.9,
	OmViz_max = 99.9,
	warhead = warhead["Rb05"],
	Engine_Type = 2, -- 1 Solid fuel, 2 liquid fuel, 3 ramjet, 4 Acceleator + LRE, 5 turbojet, 6 turbojet + accelerator
	exhaust = { 0.95, 0.95, 0.95, 0.05},
	X_back = -1.50,
	Y_back = -0.00,
	Z_back = 0.0,
	X_back_acc_	= -1.60,
	Y_back_acc_ = -0.13,
	Z_back_acc_ = 0.0,
	Reflection = 0.12044,
	KillDistance = 0.0,
	--Damage = 2500,--111 * 6,
	
}

declare_weapon(Rb05)

declare_loadout(
	{		
		category			= CAT_MISSILES,
		CLSID				= "{Robot05}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_Rb05},
		wsTypeOfWeapon		= Rb05.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "Robot05A.png",
		displayName			= _("Rb-05A MCLOS ASM/AShM/AAM"), --<-- /N/  put the launcher name here if any
		Weight				= 341, --<--/N/ missile + launcher weight (if any), this is important since the launcher stays on  aircraft! So this weight should be higher than a missile itself!
		Cx_pil				= 0.0002, --<--/N/ this is too low, you might have difficulties later to set up the human and AI FM (ignore the 21 code when it comes to weapons Cx, it is a special case) -- edited Jedi
		Elements			={
			[1]	=
			{
				Position	=	{-0.10, 0, 0},
				ShapeName	=	"rb05pylon", --<-- /N/  put the launcher shape name here if any
				IsAdapter 	= true,
			},
			[2]	=
			{
				Position	=	{0.71,	-0.25,	0}, 
				ShapeName	=	"LNS_RB05A", --<-- /N/  put the missile shape name here
			},
		},
	}
)

local Rb15 = { -- RB15 !!!!11!!!!111!

	category		= CAT_MISSILES,
	name			= "Rb 15F",
	user_name		= _("Rb 15F"),
	wsTypeOfWeapon = {4, 4, 8, wsType_Rb15},--{4, 4, 8, WSTYPE_PLACEHOLDER},
	NatoName		=	"(Rb15F)",
	
	shape_table_data =
	{
		{
			name	 = "Rb15";
			file  = "Rb15";
			life  = 1;
			fire  = { 0, 1};
			username = "Rb15";
			index = WSTYPE_PLACEHOLDER,--"Anti-Ship missiles",
		},
	},

	Escort = 1,
	Head_Type = 4, --/N/ 6 semi active radar, 4 laser /OR/ 7 semi auto
	sigma = {3, 3, 3},--{1.27, 1.55, 1.27},
	M = 560.0,
	H_max = 2000.0,
	H_min = 50,
	Diam = 500.0,
	Cx_pil = 0.0001, -- <--/N/ this should be higher for your missiles, for slim short range missiles should be 0.002 (if I remember correctly). Note that MiG-21 uses custom weapons Cx to comply with Flight model tests-real data.
	D_max = 70000.0, -- <--/N/ max launch distance, correct if needed
	D_min = 2000.0, -- <--/N/ min launch distance
	Head_Form = 1, -- <--/N/ 1- cone, 0 - semi-sphere
	Life_Time = 4500.0,
	Nr_max = 8,
	v_min = 100.0,--, -- <--/N/ min speed in m/s
	v_mid = 305.,-- -- <--/N/ max speed in m/s
	Mach_max = 1.2,--2.1, -- calc. to about M0.95ish
	t_b = 2.0,
	t_acc = 10,
	t_marsh = 240.00,
	Range_max = 70000.0, -- 
	H_min_t = 0.0,
	Fi_start = 0.5,
	Fi_rak = 3.14152,
	Fi_excort = 1.55,
	Fi_search = 99.9,
	OmViz_max = 99.9,
	warhead = warhead["Rb04"],
	Engine_Type = 5, -- 1 Solid fuel, 2 liquid fuel, 3 ramjet, 4 Acceleator + LRE, 5 turbojet, 6 turbojet + accelerator
	--exhaust = { 0.95, 0.95, 0.95, 0.1},
	X_back = -1.50,
	Y_back = -0.00,
	Z_back = 0.0,
	X_back_acc_	= -1.60,
	Y_back_acc_ = -0.13,
	Z_back_acc_ = 0.0,
	Reflection = 0.12044,
	KillDistance = 1.0,
	
}

declare_weapon(Rb15)

declare_loadout(
	{		
		category			= CAT_MISSILES,
		CLSID				= "{Rb15}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_Rb15},
		wsTypeOfWeapon		= Rb15.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "Rb15.png",
		displayName			= _("Rb-15F Programmable Anti-ship Missile"),
		Weight				= 610, --<--/N/ missile + launcher weight (if any), this is important since the launcher stays on  aircraft! So this weight should be higher than a missile itself!
		Cx_pil				= 0.0001, --<--/N/ this is too low, you might have difficulties later to set up the human and AI FM (ignore the 21 code when it comes to weapons Cx, it is a special case) -- edited Jedi
		Elements			={
			[1]	=
			{
				Position	=	{0, 0, 0},
				ShapeName	=	"RB15pylon", --<-- /N/  put the launcher shape name here if any
				IsAdapter 	= true,
			},
			[2]	=
			{
				Position	=	{0.087,	-0.437,	0}, 
				ShapeName	=	"RB15", --<-- /N/  put the missile shape name here
			},
		},
	}
)

local Rb04 = { 

	category		= CAT_MISSILES,
	name			= "Rb 04E",
	user_name		= _("Rb 04E"),
	wsTypeOfWeapon = {4, 4, 8, wsType_Rb04},--{4, 4, 8, WSTYPE_PLACEHOLDER},
	NatoName		=	"(Rb04E)",
	
	shape_table_data =
	{
		{
			name	 = "Rb04";
			file  = "Rb04";
			life  = 1;
			fire  = { 0, 1};
			username = "Rb04";
			index = WSTYPE_PLACEHOLDER,--"Anti-Ship missiles",
		},
	},

	Escort = 1,
	Head_Type = 4, --/N/ 6 semi active radar, 4 laser /OR/ 7 semi auto, 5 Autonmous (INS+ Card, GPS,TV,IIR
	sigma = {3, 3, 3},--{1.27, 1.55, 1.27},
	M = 625.0,
	H_max = 445.0,
	H_min = -1,
	Diam = 500.0,
	Cx_pil = 0.0001, -- <--/N/ this should be higher for your missiles, for slim short range missiles should be 0.002 (if I remember correctly). Note that MiG-21 uses custom weapons Cx to comply with Flight model tests-real data.
	D_max = 31000.0, -- <--/N/ max launch distance, correct if needed
	D_min = 5000.0, -- <--/N/ min launch distance
	Head_Form = 1, -- <--/N/ 1- cone, 0 - semi-sphere
	Life_Time = 4500.0,
	Nr_max = 12,
	v_min = 100.0,--, -- <--/N/ min speed in m/s
	v_mid = 305.,-- -- <--/N/ max speed in m/s
	Mach_max = 1.2,-- 
	t_b = 2.5,
	t_acc = 10,
	t_marsh = 65.60,
	Range_max = 110000.0, -- 
	H_min_t = 0.0,
	Fi_start = 0.5,
	Fi_rak = 3.14152,
	Fi_excort = 1.55,
	Fi_escort = 0.0, -- Typo?
	Fi_search = 99.9,
	OmViz_max = 99.9,
	warhead = warhead["Rb04"],
	Engine_Type = 1, -- 1 Solid fuel, 2 liquid fuel, 3 ramjet, 4 Acceleator + LRE, 5 turbojet, 6 turbojet + accelerator
	exhaust = { 0.95, 0.95, 0.95, 0.3},
	X_back = -2.50,
	Y_back = 0.08,
	Z_back = 0.0,
	X_back_acc_	= -1.60,
	Y_back_acc_ = -0.13,
	Z_back_acc_ = 0.0,
	Reflection = 0.12044,
	KillDistance = 5.0,
-- missile data
        -- Escort = 0, -- 
        -- Head_Type = 4,
		-- sigma = {2, 2, 2}, -- the maximum error of sight in meters , in the target coordinates . x - the longitudinal axis of the goal , y - axis vertialnaya goals , z - transverse axis goals
        -- M = 600.0, -- Gross weight in Kg
        -- H_max = 425.0, -- maximum altitude
        -- H_min = -1, -- Minimium altitude
        -- Diam = 500.0, -- Body diameter in mm
        -- Cx_pil = 2,
        -- D_max = 32000.0, -- Maximum launch range at low altitude
        -- D_min = 1000.0, -- Minimum launch range
        -- Head_Form = 0, --  1- cone, 0 - semi-sphere
        -- Life_Time = 200.0, -- lifetime ( self-destruct timer ) , sec
        -- Nr_max = 12, -- Maximum overload when turning (Max G)
        -- v_min = 20.0, -- Minimum speed
        -- v_mid = 270.0, -- Average speed
        -- Mach_max = 0.90,
        -- t_b = 6.0, -- Time of the motor (start?)
        -- t_acc = 10.3, -- Time of operation of accelerator
        -- t_marsh = 65.6, -- While working in the marching mode
        -- Range_max = 32000.0, -- maximum launch range at maximum height
        -- H_min_t = 0.0, -- minimum target height above terrain , m .
        -- Fi_start = 0.977, -- angle tracking and sighting at start
        -- Fi_rak = 3.14152, -- permissible angle angle purpose (rad)
        -- Fi_excort = 0.97, -- tracking angle ( sight . ) missile targets .
        -- Fi_search = 99.9, --limit angle free search
        -- OmViz_max = 99.9, --  speed limit of the line of sight
	-- warhead = warhead["Rb04"],
	-- exhaust = { 0.85, 0.85, 0.85, 0.20},
	-- Engine_Type = 1, -- 1 Solid fuel, 2 liquid fuel, 3 ramjet, 4 Acceleator + LRE, 5 turbojet, 6 turbojet + accelerator
	-- X_back = -2.27, -- Coordinates of nozzle
    -- Y_back = 0.1,
    -- Z_back = 0.0,
	-- X_back_acc_	= -2.27, -- Coordinates of accelator axis
	-- Y_back_acc_ = -0.1,
	-- Z_back_acc_ = 0.0,
	-- Reflection = 0.12044, -- effectove RCS in square feet
	-- KillDistance = 0.0, -- Fuze distance
	--Damage = 400,-- rough estimation / Damage inflicted by direct contact
	
}

declare_weapon(Rb04)

declare_loadout(
	{		
		category			= CAT_MISSILES,
		CLSID				= "{Rb04}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_Rb04, "Anti-Ship missiles"},
		wsTypeOfWeapon		= Rb04.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "Rb04.png",
		displayName			= _("Rb-04E Anti-ship Missile"),
		Weight				= 661,
		Cx_pil				= 0.001, -- Edited
		Elements			={
			[1]	=
			{
				Position	=	{0, 0, 0},
				ShapeName	=	"rb04pylon", --<-- /N/  put the launcher shape name here if any
				IsAdapter 	= true,
			},
			[2]	=
			{
				Position	=	{0.58,	-0.375,	0}, 
				ShapeName	=	"Rb04",
			},
		},
	}
)

local Rb15AI = 
{
	category		= CAT_MISSILES,
	name			= "Rb 15F (for A.I.)",
	user_name		= _("Rb 15F (for A.I.)"),
	scheme			= "anti_ship_missile_prog_path",
	class_name		= "wAmmunitionCruise",
	model			= "Rb15FAI",
	mass			= 560,
	
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

	Escort			= 0,
	Head_Type		= 5,
	sigma			= {20, 20, 20},
	M				= 560.0,
	H_max			= 2000.0,
	H_min			= -1,
	Diam			= 343.0,
	Cx_pil			= 8,
	D_max			= 190000.0,
	D_min			= 5000.0,
	Head_Form		= 0,
	Life_Time		= 100000,
	Nr_max			= 6,
	v_min			= 170.0,
	v_mid			= 237.5,
	Mach_max		= 0.95,
	t_b				= 2.0,
	t_acc			= 10.0,
	t_marsh			= 240.0,
	Range_max		= 70000.0,
	H_min_t			= 500.0,
	Fi_start		= 0.35,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.7,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= 0,
	Y_back			= 0,
	Z_back			= 0,
	Reflection		= 0.1691,
	KillDistance	= 0.0,
	
	manualWeaponFlag = 2,
	
	LaunchDistData = 
	{	
		14,		8,
		
					50,		75,		100,	125,	150,	200,	250,	300,	
				
		100,		0,		0,		0,		70000,	70000,	70000,	70000,	70000,	
		200,		0,		0,		0,		70000,	70000,	70000,	70000,	70000,
		300,		0,		0,		70000,	70000,	70000,	70000,	70000,	70000,
		500,		0,		0,		70000,	70000,	70000,	70000,	70000,	70000,
		600,		0,		70000,	70000,	70000,	70000,	70000,	70000,	70000,
		800,		0,		70000,	70000,	70000,	70000,	70000,	70000,	70000,	
		900,		70000,	70000,	70000,	70000,	70000,	70000,	70000,	70000,	
		1000,		70000,	70000,	70000,	70000,	70000,	70000,	70000,	70000,	
		2000,		70000,	70000,	70000,	70000,	70000,	70000,	70000,	70000,		
		4000,		70000,	70000,	70000,	70000,	70000,	70000,	70000,	70000,		
		6000,		70000,	70000,	70000,	70000,	70000,	70000,	70000,	70000,		
		8000,		70000,	70000,	70000,	70000,	70000,	70000,	70000,	70000,		
		10000,		70000,	70000,	70000,	70000,	70000,	70000,	70000,	70000,		
		12000,		70000,	70000,	70000,	70000,	70000,	70000,	70000,	70000,		
	},
	
	MinLaunchDistData = 
	{
		10, 6,
					50,		100,	150,	200,	250,	300,
				
		3000,		5000,	5000,	6000,	6000,	7000,	7000,	
		4000,		5000,	6000,	7000,	8000,	8000,	9000,	
		5000,		5000,	7000,	18000,	19000,	20000,	20000,	
		6000,		5000,	27000,	29000,	31000,	32000,	33000,	
		7000,		5000,	38000,	41000,	43000,	44000,	45000,	
		8000,		47000,	50000,	53000,	56000,	57000,	59000,	
		9000,		60000,	63000,	66000,	69000,	71000,	73000,	
		10000,		70000,	70000,	70000,	70000,	70000,	70000,	
		11000,		70000,	70000,	70000,	70000,	70000,	70000,	
		12000,		70000,	70000,	70000,	70000,	70000,	70000,	
	},
	
	add_attributes = {"Cruise missiles"},
	
	shape_table_data =
	{
		{
			name		= "Rb15AI",
			file		= "Rb15FAI",
			life		= 1,
			fire		= { 0, 1},
			username	= _("Rb15AI"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 560.0,  
		caliber     = 0.343,  
		cx_coeff    = {1,0.39,0.38,0.236,1.31},
		L           = 3.85,
		I           = 1 / 12 * 661.5 * 3.85 * 3.85,
		Ma          = 0.68,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 1000.0,
		Sw			= 0.7,
		dCydA		= {0.07, 0.036},
		A			= 0.5,
		maxAoa		= 0.3,
		finsTau		= 0.05,
		Ma_x		= 3,
		Ma_z		= 3,
		Kw_x		= 0.05,
	},
	
	simple_seeker = {
		delay		= 1.0,
		FOV			= math.rad(45),
		stTime		= 0.5,
		opTime		= 9999,
	},
	
	autopilot =
	{
		delay				= 1.0,
		Kpv					= 0.026,
		Kdv					= 3.2,
		Kiv					= 0.00002,
		Kph					= 28.0,
		Kdh					= 3.0,
		Kih					= 0.0,
		glide_height		= 15.0,
		use_current_height	= 0,
		max_vert_speed 		= 25.0,
		altim_vel_k			= 1.0,
		finsLimit			= 0.68,
		inertial_km_error	= 3.0,
	},
	
	final_autopilot =		
	{
		delay				= 0,
		K					= 60,
		Ki					= 0,
		Kg					= 16,
		finsLimit			= 0.9,
		useJumpByDefault	= 1,
		J_Power_K			= 2.5,
		J_Diff_K			= 0.9,
		J_Int_K				= 0,
		J_Angle_K			= 0.06,
		J_FinAngle_K		= 0.08,
		J_Angle_W			= 2.4,
		bang_bang			= 0,
		J_Trigger_Vert		= 1,
	},
	
	h_glide_on = {			-- turn on seeker and start horiz. correction if target is locked on
		delay				= 1,
		trigger_dist		= 8000,
	},
	
	mode_switcher = {		-- use final maneuver if target is locked on
		delay = 1,
		trigger_dist		= 4000,
	},
	
	self_destruct = 		-- if seeker still can not find a target explode warhead
	{
		delay = 1,
		trigger_dist		= 1000,
		inactivation_dist	= 900,
	},
	
	controller = {
		boost_start	= 0.001,
		march_start = 0.01,
	},
	
	boost = {				--	air launch - no booster
		impulse								= 0,
		fuel_mass							= 0,
		work_time							= 0,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{0, 0, 0}},
		nozzle_orientationXYZ				= {{0, 0, 0}},
		tail_width							= 0.0,
		smoke_color							= {0.0, 0.0, 0.0},
		smoke_transparency					= 0.0,
		custom_smoke_dissipation_factor		= 0.0,				
	},
	
	march = {
		impulse			= 690,
		fuel_mass		= 138.5,
		work_time		= 9999,
		min_fuel_rate	= 0.005,
		min_thrust		= -100,
		max_thrust		= 3000,
		thrust_Tau		= 0.0017,
	},
	
	engine_control = {
		default_speed	= 290, --237
		K				= 265,
		Kd				= 0.01,
		Ki				= 0.001,
	},
	
	warhead		=  warhead["Rb04"],
	warhead_air =  warhead["Rb04"],
}

declare_weapon(Rb15AI)

declare_loadout(
	{
	category 		= CAT_MISSILES,
	CLSID	 		= "{Rb15AI}",
	attribute		= Rb15AI.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= 0.001,
	Picture			= "Rb15.png",
	displayName		= Rb15AI.user_name.._(" with launcher"), 
	Weight			= 610,
	
	Elements  		= 	{
							{	
								ShapeName	=	"RB15pylon",
								Position	=	{0, 0, 0},
							}, 
							{	
								ShapeName	=	"Rb15FAI",
								Position	=	{0 ,-0.135,	0},
							},
						},

	}
)


local Rb04AI =
{
	category		= CAT_MISSILES,
	name			= "Rb 04E (for A.I.)",
	user_name		= _("Rb 04E (for A.I.)"),
	scheme			= "anti_ship_missile_prog_path",
	class_name		= "wAmmunitionCruise",
	model			= "Rb04AI",
	mass			= 661,
	
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

	Escort			= 0,
	Head_Type		= 5,
	sigma			= {20, 20, 20},
	M				= 620.0,
	H_max			= 500.0,
	H_min			= -1,
	Diam			= 500.0,
	Cx_pil			= 0.0001,
	D_max			= 32000.0,
	D_min			= 4000.0,
	Head_Form		= 0,
	Life_Time		= 4500,
	Nr_max			= 12,
	v_min			= 100.0,
	v_mid			= 305,
	Mach_max		= 0.95,
	t_b				= 0,
	t_acc			= 0,
	t_marsh			= 155.60,
	Range_max		= 32000.0,
	H_min_t			= 150.0,
	Fi_start		= 0.5,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.7,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= 0,
	Y_back			= 0,
	Z_back			= 0,
	Reflection		= 0.1691,
	KillDistance	= 1.0,
	
	manualWeaponFlag = 2,
	
	LaunchDistData = 
	{	
		14,		8,
		
					50,		75,		100,	125,	150,	200,	250,	300,	
				
		100,		0,		0,		0,		0,		0,		0,			0,		0,	
		200,		0,		0,		0,		20000,	24000,	26000,	32000,	32000,	
		300,		0,		0,		20000,	20000,	24000,	26000,	32000,	32000,		
		500,		0,		0,		20000,	20000,	24000,	26000,	32000,	32000,	
		600,		0,		32000,	32000,	32000,	32000,	32000,	32000,	32000,	
		800,		0,		32000,	32000,	32000,	32000,	32000,	32000,	32000,	
		900,		0,		32000,	32000,	32000,	32000,	32000,	32000,	32000,	
		1000,		0,		32000,	32000,	32000,	32000,	32000,	32000,	32000,		
		2000,		0,		32000,	32000,	32000,	32000,	32000,	32000,	32000,		
		4000,		0,		32000,	32000,	32000,	32000,	32000,	32000,	32000,	
		6000,		0,		32000,	32000,	32000,	32000,	32000,	32000,	32000,		
		8000,		0,		32000,	32000,	32000,	32000,	32000,	32000,	32000,	
		10000,		0,		32000,	32000,	32000,	32000,	32000,	32000,	32000,		
		12000,		0,		32000,	32000,	32000,	32000,	32000,	32000,	32000,	
	},
	
	-- MinLaunchDistData = 
	-- {
		-- 10, 6,
					-- 50,		100,	150,	200,	250,	300,
				
		-- 3000,		5000,	5000,	6000,	6000,	7000,	7000,	
		-- 4000,		5000,	6000,	7000,	8000,	8000,	9000,	
		-- 5000,		5000,	7000,	18000,	19000,	20000,	20000,	
		-- 6000,		5000,	27000,	29000,	31000,	32000,	33000,	
		-- 7000,		5000,	38000,	41000,	43000,	44000,	45000,	
		-- 8000,		47000,	50000,	53000,	56000,	57000,	59000,	
		-- 9000,		60000,	63000,	66000,	69000,	71000,	73000,	
		-- 10000,		73000,	76000,	80000,	83000,	85000,	87000,	
		-- 11000,		86000,	90000,	94000,	98000,	101000,	103000,	
		-- 12000,		100000,	105000,	109000,	113000,	116000,	119000,	
	-- },
	
	add_attributes = {"Cruise missiles"},
	
	shape_table_data =
	{
		{
			name		= "Rb 04E (for A.I.)",
			file		= "Rb04AI",
			life		= 1,
			fire		= { 0, 1},
			username	= _("Rb 04E (for A.I.)"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 620.0,  -- Total mass of the projectile, kg
		caliber     = 0.500,  -- Caliber ,mm
		cx_coeff    = {1, 0.3, 0.65, 0.018, 1.6},--		cx_coeff	= {1, 0.3, 0.65, 0.09, 1.4}, The initial coefficients for Cx
		L           = 4.45, -- Length
		I           = 1500, -- Moment of inertia relative to the transverse axis
		Ma          = 3, --Gradient of the coefficient of angular momentum on the angle of attack
		Mw          = 10, -- Gradient of the coefficient of angular velocity
		wind_sigma	= 0.0, -- "wind of dispersion" is the standard deviation
		wind_time	= 0.0, -- "wind of dispersion" - time of action
		Sw			= 2.0, -- Wing area
		dCydA		= {0.07, 0.036}, -- AoA in degrees
		A			= 0.5, -- A, polar
		maxAoa		= 0.3, -- Max AoA (rads)
		finsTau		= 0.05, -- Time of full deviation of rudders (sec)
		Ma_x		= 3,
		Ma_z		= 3,
		Kw_x		= 0.05,
	},
	
	simple_seeker = {
		delay		= 4.0,
		FOV			= math.rad(60),
		stTime		= 0.5,
		opTime		= 9999,
	},
	
	autopilot =
	{
		delay				= 3.0,
		Kpv					= 0.026,
		Kdv					= 3.2,
		Kiv					= 0.00002,
		Kph					= 28.0,
		Kdh					= 3.0,
		Kih					= 0.0,
		glide_height		= 15.0,
		use_current_height	= 0,
		max_vert_speed 		= 25.0,
		altim_vel_k			= 1.0,
		finsLimit			= 0.9,
		inertial_km_error	= 3.0,
	},
	
	final_autopilot =		
	{
		delay				= 0,
		K					= 60,
		Ki					= 0,
		Kg					= 16,
		finsLimit			= 0.9,
		useJumpByDefault	= 0,
		J_Power_K			= 2.5,
		J_Diff_K			= 0.9,
		J_Int_K				= 0,
		J_Angle_K			= 0.06,
		J_FinAngle_K		= 0.08,
		J_Angle_W			= 2.4,
		bang_bang			= 0,
		J_Trigger_Vert		= 1,
	},
	
	h_glide_on = {			-- turn on seeker and start horiz. correction if target is locked on
		delay				= 1,
		trigger_dist		= 8000,
	},
	
	mode_switcher = {		-- use final maneuver if target is locked on
		delay = 1,
		trigger_dist		= 4000,
	},
	
	self_destruct = 		-- if seeker still can not find a target explode warhead
	{
		delay = 1,
		trigger_dist		= 1000,
		inactivation_dist	= 900,
	},
	
	controller = {
		boost_start	= 3.00,
		march_start = 150.0,
	},
	
	boost = {	--	air launch - no booster
		impulse								= 130,
		fuel_mass							= 100,
		work_time							= 65.6,
		boost_time							= 2.5,
		boost_factor						= 0,
		nozzle_position						= {{-2.5, 0, 0}},
		nozzle_orientationXYZ				= {{0, 0, 0}},
		tail_width							= 0.3,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.2,				
	},
	
	march = {
		impulse			= 690,
		fuel_mass		= 67.5,
		work_time		= 9999,
		min_fuel_rate	= 0.005,
		min_thrust		= -100,
		max_thrust		= 3000,
		thrust_Tau		= 0.0017,
	},	

	
	engine_control = {
		default_speed	= 280,
		K				= 265,
		Kd				= 0.01,
		Ki				= 0.001,
	},
	
	warhead		= warhead["Rb04"],
	warhead_air = warhead["Rb04"],
}

declare_weapon(Rb04AI)

declare_loadout(
	{
	category 		= CAT_MISSILES,
	CLSID	 		= "{Rb04AI}",
	attribute		= Rb04AI.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= 0.001,
	Picture			= "Rb04.png",
	displayName		= Rb04AI.user_name.._(" with launcher"), 
	Weight			= 661,
	
	Elements  		= 	{
							{	
								ShapeName	=	"rb04pylon",
								Position	=	{0, 0, 0},
							}, 
							{	
								ShapeName	=	"Rb04AI",
								Position	=	{0 ,-0.135,	0},
							},
						},

	}
)





-- RB75 (AGM-65A)
local RB75 = 
{ 

	category		= CAT_MISSILES,
	name			= "RB75", -- AGM-65F
	user_name		= _("RB-75A"),
	class_name 		= "wAmmunitionSelfHoming",
	scheme			= "AGM-65",
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,wsType_RB75},
	model			= "RB75",


	
	mass        	= 210.5, 
	Escort			= 0,
    Head_Type		= 5,
	sigma			= {5, 5, 5},
	M				= 210.5,
	H_max			= 10000.0,
	H_min			= -1,
	Diam			= 305.0,
	Cx_pil			= 4,
	D_max			= 7000.0,
	D_min			= 500.0,
	Head_Form		= 0,
	Life_Time		= 110,
	Nr_max			= 16,
	v_min			= 50.0,
	v_mid			= 290.0,
	Mach_max		= 1.5,
	t_b				= 0.0,
	t_acc			= 4.0,
	t_marsh			= 0.0,
	Range_max		= 24076.0,
	H_min_t			= 0.0,
	Fi_start		= 0.5,
	Fi_rak			= 3.14152,
	Fi_excort		= 1.05,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	exhaust			= {0.7, 0.7, 0.7, 0.1},
	X_back			= -0.9,
	Y_back			= -0.15,
	Z_back 			= 0.0,
	Reflection		= 0.063,
	KillDistance	= 0.0,

	shape_table_data =
	{
		{
			name		= "RB_75A",
			file		= "RB75",
			life		= 1,
			fire		= { 0, 1},
			username	= _("RB-75A"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 210.5,  
		caliber     = 0.305,  
		cx_coeff    = {1,0.39,0.38,0.236,1.31},
		L           = 2.49,
		I           = 1 / 12 * 209 * 2.49 * 2.49,
		Ma          = 0.68,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 0.55,
		dCydA		= {0.07, 0.036},
		A			= 0.36,
		maxAoa		= 0.23,
		finsTau		= 0.1,
		Ma_x		= 3,
		Kw_x		= 0.03,
		I_x			= 40,
	},
	
	seeker = {
		delay			= 0.0,
		op_time			= 105,
		FOV				= math.rad(60),
		max_w_LOS		= 0.05,
		max_w_LOS_surf	= 0.025,
	
		max_target_speed			= 128,
		max_target_speed_rnd_coeff	= 10,
	},
	
	PN_autopilot = {
		K			= 0.014,
		Ki			= 0,
		Kg			= 2.5,
		Kx			= 0.02,
		fins_limit	= 0.3,
		K_GBias		= 0.26,
	},
	
	march = {
		smoke_color			= {0.7, 0.7, 0.7},
		smoke_transparency	= 0.72,
	},
	
	warhead		= predefined_warhead("AGM_65A"),
	warhead_air = predefined_warhead("AGM_65A"),

	shape_table_data =
	{
		{
			name	 = "RB75";
			file  = "RB75";
			life  = 1;
			fire  = { 0, 1};
			username = "RB75";
			index = WSTYPE_PLACEHOLDER,
		},
	},	
}

declare_weapon(RB75)

declare_loadout(
	{		
		category			= CAT_MISSILES,
		CLSID				= "{RB75}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_RB75},
		wsTypeOfWeapon		= RB75.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "agm65.png",
		displayName			= _("Rb-75A (AGM-65A Maverick) (TV ASM)"),
		Weight				= 210.5 + lau117_mass,
		Weight_Empty		= lau117_mass,
		Cx_pil 		  		= 0.0009765625,
		Elements			={
			[1]	=
			{
				Position	=	{0, 0, 0},
				ShapeName	=	"lau-117", --<-- /N/  put the launcher shape name here if any
				IsAdapter 	= true,
			},
			[2]	=
			{
				Position	=	{0.18,	-0.078,	0},
				ShapeName	=	"RB75",
			},
		},
	}
)

-- RB75B (AGM-65B)
local RB75B = 
{ 

	category		= CAT_MISSILES,
	name			= "RB75B", -- AGM-65F
	user_name		= _("RB-75B"),
	class_name 		= "wAmmunitionSelfHoming",
	scheme			= "AGM-65",
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,wsType_RB75B},
	model			= "RB75B",


	
	mass        	= 210.5, 
	Escort			= 0,
    Head_Type		= 5,
	sigma			= {5, 5, 5},
	M				= 210.5,
	H_max			= 10000.0,
	H_min			= -1,
	Diam			= 305.0,
	Cx_pil			= 4,
	D_max			= 12964.0,
	D_min			= 500.0,
	Head_Form		= 0,
	Life_Time		= 110,
	Nr_max			= 16,
	v_min			= 50.0,
	v_mid			= 290.0,
	Mach_max		= 1.5,
	t_b				= 0.0,
	t_acc			= 4.0,
	t_marsh			= 0.0,
	Range_max		= 24076.0,
	H_min_t			= 0.0,
	Fi_start		= 0.5,
	Fi_rak			= 3.14152,
	Fi_excort		= 1.05,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	exhaust			= {0.7, 0.7, 0.7, 0.1},
	X_back			= -0.9,
	Y_back			= -0.15,
	Z_back 			= 0.0,
	Reflection		= 0.063,
	KillDistance	= 0.0,

	shape_table_data =
	{
		{
			name		= "RB_75B",
			file		= "RB75b",
			life		= 1,
			fire		= { 0, 1},
			username	= _("RB-75B"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 210.5,  
		caliber     = 0.305,  
		cx_coeff    = {1,0.39,0.38,0.236,1.31},
		L           = 2.49,
		I           = 1 / 12 * 209 * 2.49 * 2.49,
		Ma          = 0.68,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 0.55,
		dCydA		= {0.07, 0.036},
		A			= 0.36,
		maxAoa		= 0.23,
		finsTau		= 0.1,
		Ma_x		= 3,
		Kw_x		= 0.03,
		I_x			= 40,
	},
	
	seeker = {
		delay			= 0.0,
		op_time			= 105,
		FOV				= math.rad(60),
		max_w_LOS		= 0.05,
		max_w_LOS_surf	= 0.025,
	
		max_target_speed			= 128,
		max_target_speed_rnd_coeff	= 10,
	},
	
	PN_autopilot = {
		K			= 0.014,
		Ki			= 0,
		Kg			= 2.5,
		Kx			= 0.02,
		fins_limit	= 0.3,
		K_GBias		= 0.26,
	},
	
	march = {
		smoke_color			= {0.7, 0.7, 0.7},
		smoke_transparency	= 0.72,
	},
	
	warhead		= predefined_warhead("AGM_65A"),
	warhead_air = predefined_warhead("AGM_65A"),

	shape_table_data =
	{
		{
			name	 = "RB75B";
			file  = "RB75B";
			life  = 1;
			fire  = { 0, 1};
			username = "RB75B";
			index = WSTYPE_PLACEHOLDER,
		},
	},	
}

declare_weapon(RB75B)

declare_loadout(
	{		
		category			= CAT_MISSILES,
		CLSID				= "{RB75B}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_RB75B},
		wsTypeOfWeapon		= RB75B.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "agm65.png",
		displayName			= _("Rb-75B (AGM-65B Maverick) (TV ASM)"),
		Weight				= 210.5 + lau117_mass,
		Weight_Empty		= lau117_mass,
		Cx_pil 		  		= 0.0009765625,
		Elements			={
			[1]	=
			{
				Position	=	{0, 0, 0},
				ShapeName	=	"lau-117", --<-- /N/  put the launcher shape name here if any
				IsAdapter 	= true,
			},
			[2]	=
			{
				Position	=	{0.18,	-0.078,	0},
				ShapeName	=	"RB75B",
			},
		},
	}
)

-- RB75T (AGM-65A Heavy)
local RB75T = 
{ 

	category		= CAT_MISSILES,
	name			= "RB75T", -- AGM-65F
	user_name		= _("RB-75T"),
	class_name 		= "wAmmunitionSelfHoming",
	scheme			= "AGM-65",
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,wsType_RB75T},
	model			= "RB75T",


	
	mass        	= 295.0, 
	Escort			= 0,
    Head_Type		= 5,
	sigma			= {5, 5, 5},
	M				= 295.0,
	H_max			= 10000.0,
	H_min			= -1,
	Diam			= 305.0,
	Cx_pil			= 4,
	D_max			= 7000.0,
	D_min			= 500.0,
	Head_Form		= 0,
	Life_Time		= 110,
	Nr_max			= 16,
	v_min			= 50.0,
	v_mid			= 290.0,
	Mach_max		= 1.5,
	t_b				= 0.0,
	t_acc			= 4.0,
	t_marsh			= 0.0,
	Range_max		= 24076.0,
	H_min_t			= 0.0,
	Fi_start		= 0.5,
	Fi_rak			= 3.14152,
	Fi_excort		= 1.05,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	exhaust			= {0.7, 0.7, 0.7, 0.1},
	X_back			= -0.9,
	Y_back			= -0.15,
	Z_back 			= 0.0,
	Reflection		= 0.063,
	KillDistance	= 0.0,

	shape_table_data =
	{
		{
			name		= "RB_75T",
			file		= "RB75T",
			life		= 1,
			fire		= { 0, 1},
			username	= _("RB-75T"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 295.0,  
		caliber     = 0.305,  
		cx_coeff    = {1,0.39,0.38,0.236,1.31},
		L           = 2.49,
		I           = 1 / 12 * 209 * 2.49 * 2.49,
		Ma          = 0.68,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 0.55,
		dCydA		= {0.07, 0.036},
		A			= 0.36,
		maxAoa		= 0.23,
		finsTau		= 0.1,
		Ma_x		= 3,
		Kw_x		= 0.03,
		I_x			= 40,
	},
	
	seeker = {
		delay			= 0.0,
		op_time			= 105,
		FOV				= math.rad(60),
		max_w_LOS		= 0.05,
		max_w_LOS_surf	= 0.025,
	
		max_target_speed			= 128,
		max_target_speed_rnd_coeff	= 10,
	},
	
	PN_autopilot = {
		K			= 0.014,
		Ki			= 0,
		Kg			= 2.5,
		Kx			= 0.02,
		fins_limit	= 0.3,
		K_GBias		= 0.26,
	},
	
	march = {
		smoke_color			= {0.7, 0.7, 0.7},
		smoke_transparency	= 0.72,
	},
	
	warhead		= predefined_warhead("AGM_65E"),
	warhead_air = predefined_warhead("AGM_65E"),

	shape_table_data =
	{
		{
			name	 = "RB75T";
			file  = "RB75T";
			life  = 1;
			fire  = { 0, 1};
			username = "RB75T";
			index = WSTYPE_PLACEHOLDER,
		},
	},	
}

declare_weapon(RB75T)

declare_loadout(
	{		
		category			= CAT_MISSILES,
		CLSID				= "{RB75T}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_RB75T},
		wsTypeOfWeapon		= RB75T.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "agm65.png",
		displayName			= _("Rb-75T (AGM-65A Maverick) (TV ASM Lg HE Whd)"),
		Weight				= 295 + lau117_mass,
		Weight_Empty		= lau117_mass,
		Cx_pil 		  		= 0.0009765625,
		Elements			={
			[1]	=
			{
				Position	=	{0, 0, 0},
				ShapeName	=	"lau-117", --<-- /N/  put the launcher shape name here if any
				IsAdapter 	= true,
			},
			[2]	=
			{
				Position	=	{0.18,	-0.078,	0},
				ShapeName	=	"RB75T",
			},
		},
	}
)



-- declare_weapon(LYSBOMB_CANDLE)
local LYSBOMB_CANDLE = {
-- USE THIS KIND OF DEFINITION ONLY IF YOU  ARE SURE YOU WANT TO DEFINE CUSTOM SUB-WEAPON.
-- OTHERVISE, IT IS MUCH WISER TO USE WHAT ALREADY EXIST, LIKE SOME lau-s.
	category  = CAT_BOMBS,
	name   = "LYSBOMB_CANDLE",
	model    = "luu-2", --!!!!
	user_name   = _("LYSBOMB_CANDLE whatever"),
	wsTypeOfWeapon = {wsType_Weapon,wsType_Bomb,wsType_Bomb_Lighter,WSTYPE_PLACEHOLDER},
	scheme = "bomb-light",
	type = 2,
	mass = 25.0,
	hMin = 1000.0, --!!!!!
	hMax = 15000.0, --!!!!!
	Cx = 0.00205, 
	VyHold = -100.0, 
	Ag = -1.23,

	fm =
	{
		mass = 25.00, --!!!!!
		caliber = 0.201, --!!!!!
		cx_coeff = {1.000000, 0.390000, 0.600000, 0.168000, 1.310000},
		L = 50.0,
		I = 88.875,
		Ma = 0.324570,
		Mw = 3.139597,
		wind_sigma = 0.00,
		cx_factor  = 2100,
	},

	light =
    {
        start_time  = 2, --!!!!!
        duration    = 170, --!!!!!
        light_position = {0.7, 0, 0}, --!!!!!
        light_color 	= {1.0, 0.54, 0}, 	-- Sodium colored flame
        light_attenuation = 800.0, -- What is this? Should be 3 million candela ?
        smoke_position = {-0.7, 0, 0},
        smoke_color = {0.952, 0.952, 0.952},
        smoke_transparency = 0.8,
        smoke_width = 1,
	
    },
    
    control = 
    {
        delay_par   = 2, --!!!!!
    },
	
	shape_table_data =
	{
		{
			name  = "luu-2", --!!!!!
			file  = "luu-2", --/N/ you HAVE to use existing 3D model, either Vig custom or some that exist in DCS
			life  = 1,
			fire  = { 0, 1},
			username = "luu-2",
			index = WSTYPE_PLACEHOLDER,
		},
	},
	
	targeting_data =
	{
		char_time = 21.02, 
	},

}

declare_weapon(LYSBOMB_CANDLE)
--================= IF FIRST PART WORKS, ADD THIS AND REPEAT PROCEDURE =================================

local LYSBOMB = {
	category  = CAT_BOMBS,
	name   = "LYSBOMB",
	model    = "LYSB71",  --/N/ you HAVE to use existing 3D model, either Vig custom or some that exist in DCS
	user_name   = _("LYSBOMB Illumination bomb"),
	wsTypeOfWeapon = {wsType_Weapon,wsType_Bomb,wsType_Bomb_Lighter,wsType_LYSBOMB},--
	--wsTypeOfWeapon = {wsType_Weapon,wsType_Bomb,wsType_Bomb_Cluster,WSTYPE_PLACEHOLDER},
	scheme = "bomb-light",--"bomb-parashute",--"bomb-sab",
	type = 2,
	mass = 80.0, --!!!!!
	hMin = 1000.0,
	hMax = 15000.0,
	Cx = 0.00005,--0.00025,
	VyHold = -100.0,
	Ag = -1.23,

	fm =
	{
		mass            = 25.000000, --!!!!!
		caliber         = 0.201,
		cx_coeff        = {1.000000, 0.290000, 0.710000, 0.140000, 1.280000},
		L               = 2.210000,
		I               = 94.425933,
		Ma              = 2.746331,
		Mw              = 2.146083,
		wind_sigma      = 0.000000,
		cx_factor   	= 2100,
	},
warhead = warhead["FAB-500M54"],
	launcher = 
	{
		ammunition_name = "LYSBOMB_CANDLE",
	},

	control = 
	{
		open_delay    = 25.0,--12.5,
		open_interval = 15.0,
		items_count   = 1, --
		delay_par   = 25.0,--12.5, --!!!!!
	},
	light =
    {
        start_time  = 16.5, --!!!!!
        duration    = 170, --!!!!!
        light_position = {0.7, 0, 0}, --!!!!!
        light_color 	= {1.0, 0.54, 0}, 	-- Sodium colored flame
        light_attenuation = 800.0, -- What is this? Should be 3 million candela ?
		
        smoke_position = {-0.7, 0, 0},
        smoke_color = {0.952, 0.952, 0.952},
        smoke_transparency = 0.8,
        smoke_width = 1,
	
    },

	shape_table_data =
	{
		{
			name  = "LYSB71",
			file  = "LYSB71", --/N/ you HAVE to use existing 3D model, either Vig custom or some that exist in DCS
			life  = 1,
			fire  = { 0, 1},
			username = "LYSB71",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	targeting_data =
	{
		char_time = 31.02, 
	}

}

declare_weapon(LYSBOMB)

declare_loadout(
{
	category			= CAT_BOMBS,
	CLSID				= "{LYSBOMB}",
	attribute			= {4,	5,	32,	32},--{wsType_Weapon,wsType_Bomb,wsType_Bomb_Lighter,wsType_LYSBOMB},--WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon		= LYSBOMB.wsTypeOfWeapon,
	Count				= 2,
	Picture				= "Lysb71.png",
	displayName			= _("2x 80kg LYSB-71 Illumination Bomb"),
	Cx_pil = 0.002,
	Weight				= (LYSBOMB.mass * 2) + 60,
Elements	=	{
					[1]	=	
					{
						Position	=	{0,	0,	0},
						ShapeName	=	"PylonM71",
					}, 
					[2]	=	
					{
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{-0.674,	-0.343, -0.217},
						ShapeName	=	"LYSB71",
						Rotation    = 	{0,0,0},
					}, 
					[3]	=	
					{
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{-0.674,	-0.343, 0.217},
						ShapeName	=	"LYSB71",
						Rotation    = 	{0,0,0},
					}, 
				}, -- end of Elements
}
)




local HEBOMBD = {
	category  = CAT_BOMBS,
	name   = "HEBOMBD",
	model    = "SB71HD",  --/N/ you HAVE to use existing 3D model, either Vig custom or some that exist in DCS
	user_name   = _("M/71 HE-Bomb w chute"),
	wsTypeOfWeapon = {wsType_Weapon,wsType_Bomb,wsType_Bomb_A,wsType_HEBOMBDrag},--
	
	scheme = "bomb-parashute",--"bomb-parashute",--"bomb-sab",
	type = 0,
	mass = 121.0, --!!!!!
	 hMin = 100.0,
	 hMax = 15000.0,
	 Cx = 0.00018,
	 VyHold = -100.0,
	 Ag = -1.23,

	fm =
	{
		mass            = 121.000000, --!!!!!
		caliber         = 0.214000 * 2.0,
		cx_coeff        = {1.000000, 0.290000, 0.710000, 0.140000, 1.280000},
		L               = 2.210000,
		I               = 94.425933,
		Ma              = 2.746331,
		Mw              = 2.146083,
		wind_time       = 1000.000000,
		wind_sigma      = 80.000000,
		cx_factor   	= 30,
	},
warhead = warhead["m71"],

control = 
    {
        open_delay = 1.0,
		delay_par   = 1.0, --!!!!!
    },
	
	shape_table_data =
	{
		{
			name  = "SB71HD",
			file  = "SB71HD", --/N/ you HAVE to use existing 3D model, either Vig custom or some that exist in DCS
			life  = 1,
			fire  = { 0, 1},
			username = "SB71HD",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	targeting_data = 
	{	
		v0 = 500,
		data = 
		{
			{1.000000, 21.147949, 0.002807},
			{10.000000, 28.262668, -0.017193},
			{20.000000, 29.687629, -0.016767},
			{30.000000, 30.394407, -0.015892},
			{40.000000, 30.826322, -0.015080},
			{50.000000, 31.133114, -0.014428},
			{60.000000, 31.361560, -0.013889},
			{70.000000, 31.543970, -0.013440},
			{80.000000, 31.690640, -0.013045},
			{90.000000, 31.814418, -0.012713},
			{100.000000, 31.920050, -0.012425},
			{200.000000, 32.511629, -0.010723},
			{300.000000, 32.789778, -0.009863},
			{400.000000, 32.963413, -0.009307},
			{500.000000, 33.086372, -0.008907},
			{600.000000, 33.179450, -0.008596},
			{700.000000, 33.253103, -0.008346},
			{800.000000, 33.312920, -0.008139},
			{900.000000, 33.362577, -0.007968},
			{1000.000000, 33.404350, -0.007824},
			{1100.000000, 33.439925, -0.007702},
			{1200.000000, 33.470498, -0.007599},
			{1300.000000, 33.496988, -0.007513},
			{1400.000000, 33.520106, -0.007440},
			{1500.000000, 33.540403, -0.007378},
			{1600.000000, 33.558365, -0.007327},
			{1700.000000, 33.574326, -0.007285},
			{1800.000000, 33.588629, -0.007251},
			{1900.000000, 33.601489, -0.007224},
			{2000.000000, 33.613137, -0.007202},
			{3000.000000, 33.690673, -0.007191},
			{4000.000000, 33.737805, -0.007357},
			{5000.000000, 33.773738, -0.007590},
			{6000.000000, 33.802367, -0.007864},
			{7000.000000, 33.824277, -0.008170},
			{8000.000000, 33.839206, -0.008505},
			{9000.000000, 33.846586, -0.008868},
			{10000.000000, 33.845625, -0.009258},
		}    
	},

}

declare_weapon(HEBOMBD)

declare_loadout(
{
	category			= CAT_BOMBS,
	CLSID				= "{M71BOMBD}",
	attribute			= {4,	5,	32,	32},--{wsType_Weapon,wsType_Bomb,wsType_Bomb_Lighter,wsType_HEBOMB},--WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon		= HEBOMBD.wsTypeOfWeapon,
	Count				= 4,
	Cx_pil	=	(HEBOMBD.Cx*4)+0.0003, -- This needs to be more than the sum of the Cx_pil for the 4 bombs.


	Picture				= "SB71HD.png",
	displayName			= _("4x SB M/71 120kg GP Bomb High-drag"),--HEBOMB.user_name,
	Weight				=  (HEBOMBD.mass * 4) + 125,
		shape_table_data =
	{
		{
			name  = "LavettM71",
			file  = "LavettM71", --/N/ you HAVE to use existing 3D model, either Vig custom or some that exist in DCS
			life  = 1,
			fire  = { 0, 1},
			username = "LavettM71",
			index = 32,
		},
	},
Elements	=	{
					[1]	=	
					{
						Position	=	{0,	0,	0},
						ShapeName	=	"PylonM71",
						IsAdapter 	= true,
					}, 
					[2]	=	
					{ -- Back left
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{-0.674,	-0.343,	-0.217},
						ShapeName	=	"SB71HD",
						Rotation    = 	{0,0,0},
					}, 
					[3]	=	
					{ -- Back right
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{-0.674,	-0.343, 0.217},
						ShapeName	=	"SB71HD",
						Rotation    = 	{0,0,0},
					}, 
					[4]	=	
					{ -- Front left
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{1.275,	-0.343, -0.217},
						ShapeName	=	"SB71HD",
						Rotation    = 	{0,0,0},
					}, 
					[5]	=	
					{ -- Front right
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{1.275,	-0.343, 0.217},
						ShapeName	=	"SB71HD",
						Rotation    = 	{0,0,0},
					}, 
				}, -- end of Elements
}
)




local HEBOMB = {
	category  = CAT_BOMBS,
	name   = "HEBOMB",
	model    = "SB71LD",  --/N/ you HAVE to use existing 3D model, either Vig custom or some that exist in DCS
	user_name   = _("M/71 HE-Bomb"),
	wsTypeOfWeapon = {wsType_Weapon,wsType_Bomb,wsType_Bomb_A,wsType_HEBOMB},--
	
	scheme = "bomb-common",--"bomb-parashute",--"bomb-sab",
	type = 0,
	mass = 121.0, --!!!!!
	 hMin = 100.0,
	 hMax = 15000.0,
	 Cx = 0.00018, -- T changed 0602 
	 VyHold = -100.0,
	 Ag = -1.23,

	fm =
	{
		mass            = 121.000000, --!!!!!
		caliber         = 0.214000 * 2.0,
		cx_coeff        = {1.000000, 0.290000, 0.710000, 0.140000, 1.280000},
		L               = 2.210000,
		I               = 94.425933,
		Ma              = 2.746331,
		Mw              = 2.146083,
		wind_time       = 1000.000000,
		wind_sigma      = 80.000000,
	},
warhead = warhead["m71"],


	
	shape_table_data =
	{
		{
			name  = "SB71LD",
			file  = "SB71LD", --/N/ you HAVE to use existing 3D model, either Vig custom or some that exist in DCS
			life  = 1,
			fire  = { 0, 1},
			username = "SB71LD",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	targeting_data =
	{
		char_time = 21.02, 
	}

}

declare_weapon(HEBOMB)

declare_loadout(
{
	category			= CAT_BOMBS,
	CLSID				= "{M71BOMB}",
	attribute			= {4,	5,	32,	32},	--attribute			= {4,	5,	9,	wsType_HEBOMB},--{wsType_Weapon,wsType_Bomb,wsType_Bomb_Lighter,wsType_HEBOMB},--WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon		= HEBOMB.wsTypeOfWeapon,
	Count				= 4,
	Cx_pil	=	(HEBOMB.Cx*4)+0.0003,--0.001, -- This needs to be more than the sum of the Cx_pil for the 4 bombs.


	Picture				= "SB71LD.png",
	displayName			= _("4x SB M/71 120kg GP Bomb Low-drag"),--HEBOMB.user_name,
	Weight				=  (HEBOMB.mass * 4) + 125,
Elements	=	{
					[1]	=	
					{
						Position	=	{0,	0,	0},
						ShapeName	=	"PylonM71",
						IsAdapter 	= true,
					}, 
					[2]	=	
					{ -- Back left
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{-0.674,	-0.343,	-0.217},
						ShapeName	=	"SB71LD",
						Rotation    = 	{0,0,0},
					}, 
					[3]	=	
					{ -- Back right
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{-0.674,	-0.343, 0.217},
						ShapeName	=	"SB71LD",
						Rotation    = 	{0,0,0},
					}, 
					[4]	=	
					{ -- Front left
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{1.275,	-0.343, -0.217},
						ShapeName	=	"SB71LD",
						Rotation    = 	{0,0,0},
					}, 
					[5]	=	
					{ -- Front right
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{1.275,	-0.343, 0.217},
						ShapeName	=	"SB71LD",
						Rotation    = 	{0,0,0},
					}, 
				}, -- end of Elements
}
)


-- ARAK

local ARAK70BHE = {
	category			= CAT_ROCKETS,
	name				= "ARAKM70BHE",
	user_name			= _("ARAKM70BHE"),
	wsTypeOfWeapon		= {wsType_Weapon,wsType_NURS,wsType_Rocket,wsType_ARAK70HE},
	scheme 				= "nurs-standard",
	model 				= "ARAK70HE",

        fm = 
        {
            mass        = 44.7,   -- start weight, kg
            caliber     = 0.135, -- Caliber, meters 
            cx_coeff    = {1,0.889005,0.67,0.3173064,2.08},  -- Cx
            L           = 2.105, --Length, meters
            I           = 39.00209, -- moment of inertia
            Ix          = 6, -- not used???
            Ma          = 0.50851, -- dependence moment coefficient of  by  AoA
            Mw          = 3.28844, --  dependence moment coefficient by angular speed
            shapeName   = "",
            
            wind_time   = 1.5, -- dispersion coefficient
            wind_sigma  = 4, -- dispersion coefficient
        },

        engine =
        {
            fuel_mass   = 12.5, -- Fuel mass, kg
            impulse     = 180, -- Specific impulse, sec
            boost_time  = 0, -- Time of booster action
            work_time   = 2.2, -- Time of mid-flight engine action
            boost_factor= 1, -- Booster to cruise trust ratio
            nozzle_position =  {{-0.758, 0, 0}}, -- meters
            tail_width  = 0.150, -- contrail thickness 
            boost_tail  = 1.5,
            work_tail   = 1.5,

            smoke_color = {0.1, 0.1, 0.1},
			smoke_transparency = 0.6,--0.8,
        },

	warhead	=
	{
		mass	= 21.6,-- HE 21.6, HEAT 19.7
		expl_mass = 21.6,--0.285, HE warhead 21.6, HEAT 5.0
		other_factors = { 2.0, 2.5, 2.5},--{ 1.0, 0.5, 0.5},
		concrete_factors = { 0.8, 0.8, 0.8},--{ 1.0, 0.5, 0.1},
		concrete_obj_factor = 0.8,
		obj_factors = { 1.5, 1.5},--{ 1.0, 1.0},
		cumulative_factor= 2.0,
		cumulative_thickness = 0.6,
		piercing_mass			= 20.0,
	},

	shape_table_data =
	{
		{
			file		 = "ARAK70HE",
			life		 = 1,
			fire		 = {0, 1},
			username = "ARAKM70",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	properties =
	{
		dist_min = 500,
		dist_max = 7000,
	}
}

declare_weapon(ARAK70BHE)


declare_loadout(
{
	category 		= CAT_ROCKETS,
	CLSID 			= "{ARAKM70BHE}",
	attribute 		= {wsType_Weapon,wsType_NURS,wsType_Container,wsType_ARAK70HEPOD},
	--attribute 		= {wsType_Weapon,wsType_NURS,wsType_Container,WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon	=	ARAK70BHE.wsTypeOfWeapon,	
	Picture 		= "ARAK70HE.png",
	displayName		= _("ARAK M/70B HE 6x 135mm UnGd Rkts, Shu70 HE/FRAG"),
	Weight 			= (19.7 + 25)*6 + 104, -- (Head + fuse + body) * 6 + pod weight
	Count			=	6,
	Cx_pil			=	0.00059912109375,
	kind_of_shipping = 1,

	Elements = {
	
		{
			ShapeName	=	"ARAKM70B", -- pod name
			IsAdapter = true,
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.192,	-0.077}, --1
			ShapeName	=	"ARAK70HE",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.45,	-0.073}, --2
			ShapeName	=	"ARAK70HE",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.326, 0.143}, --3
			ShapeName	=	"ARAK70HE",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.326,	-0.143}, --4
			ShapeName	=	"ARAK70HE",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.192,	0.077}, --5
			ShapeName	=	"ARAK70HE",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.45,	0.073}, --6
			ShapeName	=	"ARAK70HE",
			Rotation = {0,0,0},
		},
	},

}
)

local ARAK70BAP = {
	category			= CAT_ROCKETS,
	name				= "ARAKM70BAP",
	user_name			= _("ARAKM70BAP"),
	wsTypeOfWeapon		= {wsType_Weapon,wsType_NURS,wsType_Rocket,wsType_ARAK70AP},
	scheme 				= "nurs-standard",
	model 				= "ARAK70AP",

        fm = 
        {
            mass        = 44.7,   -- start weight, kg
            caliber     = 0.135, -- Caliber, meters 
            cx_coeff    = {1,0.889005,0.67,0.3173064,2.08},  -- Cx
            L           = 2.105, --Length, meters
            I           = 39.00209, -- moment of inertia
            Ix          = 6, -- not used???
            Ma          = 0.50851, -- dependence moment coefficient of  by  AoA
            Mw          = 3.28844, --  dependence moment coefficient by angular speed
            shapeName   = "",
            
            wind_time   = 1.5, -- dispersion coefficient
            wind_sigma  = 4, -- dispersion coefficient
        },

        engine =
        {
            fuel_mass   = 12.5, -- Fuel mass, kg
            impulse     = 180, -- Specific impulse, sec
            boost_time  = 0, -- Time of booster action
            work_time   = 2.2, -- Time of mid-flight engine action
            boost_factor= 1, -- Booster to cruise trust ratio
            nozzle_position =  {{-0.758, 0, 0}}, -- meters
            tail_width  = 0.150, -- contrail thickness 
            boost_tail  = 1.5,
            work_tail   = 1.5,

            smoke_color = {0.1, 0.1, 0.1},
			smoke_transparency = 0.6,--0.8,
        },

	warhead	=
	{
		mass	= 19.7,-- HE 21.6, HEAT 19.7
		expl_mass = 19.7,--0.285, HE warhead 21.6, HEAT 5.0
		other_factors = { 2.0, 2.5, 2.5},--{ 1.0, 0.5, 0.5},
		concrete_factors = { 1.5, 0.8, 0.8},--{ 1.0, 0.5, 0.1},
		concrete_obj_factor = 0.8,
		obj_factors = { 1.5, 1.5},--{ 1.0, 1.0},
		cumulative_factor= 2.0,
		cumulative_thickness = 0.6,
		piercing_mass			= 40.0,
	},

	shape_table_data =
	{
		{
			file		 = "ARAK70AP",
			life		 = 1,
			fire		 = {0, 1},
			username = "ARAKM70AP",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	properties =
	{
		dist_min = 500,
		dist_max = 7000,
	}
}

declare_weapon(ARAK70BAP)


declare_loadout(
{
	category 		= CAT_ROCKETS,
	CLSID 			= "{ARAKM70BAP}",
	attribute 		= {wsType_Weapon,wsType_NURS,wsType_Container,wsType_ARAK70APPOD},
	--attribute 		= {wsType_Weapon,wsType_NURS,wsType_Container,WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon	=	ARAK70BAP.wsTypeOfWeapon,	
	Picture 		= "ARAK70AP.png",
	displayName		= _("ARAK M/70B AP 6x 135mm UnGd Rkts, Pshu70 HEAT"),
	Weight 			= (19.7 + 25)*6 + 104, -- (Head + fuse + body) * 6 + pod weight
	Count			=	6,
	Cx_pil			=	0.00059912109375,
	kind_of_shipping = 1,

	Elements = {
	
		{
			ShapeName	=	"ARAKM70B", -- pod name
			IsAdapter = true,
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.192,	-0.077}, --1
			ShapeName	=	"ARAK70AP",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.45,	-0.073}, --2
			ShapeName	=	"ARAK70AP",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.326, 0.143}, --3
			ShapeName	=	"ARAK70AP",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.326,	-0.143}, --4
			ShapeName	=	"ARAK70AP",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.192,	0.077}, --5
			ShapeName	=	"ARAK70AP",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.45,	0.073}, --6
			ShapeName	=	"ARAK70AP",
			Rotation = {0,0,0},
		},
	},

}
)
-- Mavericks

attribute	=	{4,	4,	32,	137}, --AGM-65H




declare_loadout(
    {
        category = CAT_FUEL_TANKS,
        CLSID = "{VIGGEN_X-TANK}",
        attribute = {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
        Picture = "Xtank.png",
        displayName = _("AJS External-tank 1013kg fuel"),
        Weight_Empty = 195,
        Weight = 1208,
        Cx_pil            = 0.0016,--0.002197266, -- Ragnar: I've calculated it to be exactly this much // changed to F-5 tank Cx -- Teo// testing
        shape_table_data =
            {
                {
                    file = "LNS_VIG_XTANK",
                    life = 1,
                    fire = { 0, 1},
                    username = "LNS_VIGGEN_XTANK",
                    index = WSTYPE_PLACEHOLDER,
                },
            },
        Elements =
            {
                {
                DrawArgs =
                    {
                        [1] = {1, 1},
                        [2] = {2, 1},
                    },
                        Position = {0, 0, 0},
                        ShapeName = "LNS_VIG_XTANK",
                    },
                },
            }
)


--/N/ kontejneri, SPS / ASO
declare_loadout(
	{
		category = CAT_PODS,
		CLSID = "{U22}",
		attribute  = {wsType_Weapon, wsType_GContainer, wsType_Jam_Cont, WSTYPE_PLACEHOLDER},
		Picture = "U22.png",
		displayName = _("U/22 Jammer pod"),
		Weight = 348,
		Cx_pil	=	0.000244140625,

		shape_table_data =
			{
				{
					file = "U22", 
					life = 1,
					fire = { 0, 1},
					username = "U22 Jammer",
					index = WSTYPE_PLACEHOLDER,
				},
			},
			
		Elements =
		{
			{
				Position	=	{0.0,	0.0,	0}, 
				ShapeName	=	"U22",
			},
		},
	}
)

declare_loadout(
	{
		category = CAT_PODS,
		CLSID = "{U22A}",
		attribute  = {wsType_Weapon, wsType_GContainer, wsType_Jam_Cont, WSTYPE_PLACEHOLDER},
		Picture = "U22A.png",
		displayName = _("U22/A Jammer"),
		Weight = 348,
		Cx_pil	=	0.000244140625,

		shape_table_data =
			{
				{
					file = "U22a", 
					life = 1,
					fire = { 0, 1},
					username = "U22/A Jammer Pod",
					index = WSTYPE_PLACEHOLDER,
				},
			},
			
		Elements			={
			{
				Position	=	{0.0,	0.0,	0}, 
				ShapeName	=	"U22A",
			},
		},
	}
)

declare_loadout(
 {
  category = CAT_PODS,
  CLSID = "{KB}",
  attribute = {wsType_Weapon,wsType_GContainer,wsType_Snare_Cont,WSTYPE_PLACEHOLDER},
  Picture = "kb.png",
  displayName = _("KB Flare/Chaff dispenser pod"),
  Cx_pil = 0.000244140625,
  Weight = 316, --kg? Fully loaded
  
  
  shape_table_data =
   {
    {
     file = "KBpod",
     life = 1,
     fire = { 0, 1},
     username = "KB F/C dispenser",
     index = WSTYPE_PLACEHOLDER,
    },
   },
		Elements =
		{

			{
				Position	=	{0.0,	-0.0,	0}, 
				ShapeName	=	"KBpod",
			},
		},

 }
)


--/N/ smoke container
declare_loadout(
	
		{		
		category			= CAT_PODS,
		CLSID				= "{SMOKE_WHITE}",
		attribute			= {wsType_Weapon, wsType_GContainer, wsType_Smoke_Cont, WSTYPE_PLACEHOLDER},
		Count				= 1,
		Picture				= "HVAR_smoke.png",
		displayName			= _("Smoke - white - 21"),
		Weight				= 30,
		Cx_pil				= 0.00001,
		
		Elements			={
		},
		
		Smoke = {
            alpha = 180,--/N/ 255 - totally opaque
            r = 255,
            g = 255,
            b = 255,
            dx = -1.5,
            dy = -0.05
        },		
		
	}
)



--------------------------------------------------------------------------
--							BOMBKAPSEL-90								--
--------------------------------------------------------------------------
-- Copied from glide_bombs.lua


function BK_90 (name, user_name, scheme, cluster_name, cluster_scheme_, open_dist_k, wst, bomblets_data)
	
	local bk ={}
	bk.category		= CAT_MISSILES
	bk.name			= name
	bk.user_name	= user_name
	bk.scheme		= scheme
	bk.class_name	= "wAmmunitionSelfHoming"
	bk.model		= "BK_90"
	bk.mass			= 605
	
	bk.wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,wst}

	bk.Escort			= 0
	bk.Head_Type		= 5
	bk.sigma			= {20, 20, 20}
	bk.M				= 605.0
	bk.H_max			= 1600.0
	bk.H_min			= 50
	bk.Diam				= 400.0
	bk.Cx     			= 0.0024
	bk.Cx_pil     		= 10
	bk.D_max			= 10000.0
	bk.D_min			= 1500.0
	bk.Head_Form		= 0
	bk.Life_Time		= 1000
	bk.Nr_max			= 4
	bk.v_min			= 170.0
	bk.v_mid			= 240.0
	bk.Mach_max			= 0.95
	bk.t_b				= 0.0
	bk.t_acc			= 0.0
	bk.t_marsh			= 0.0
	bk.Range_max		= 10000.0
	bk.H_min_t			= 0.0
	bk.Fi_start			= 1.57
	bk.Fi_rak			= 3.14152
	bk.Fi_excort		= 3.14152
	bk.Fi_search		= 99.9
	bk.OmViz_max		= 99.9
	bk.X_back			= 0.0
	bk.Y_back			= 0.0
	bk.Z_back			= 0.0
	bk.Reflection		= 0.4
	bk.KillDistance		= 0.0
	
	bk.LaunchDistData = 
	{		
		10,		8,
		
				160,	180,	200,	220,	240,	260,	280,	300,	
		50,		500,	2200,	3000,	4800,	6800,	8800,	9600,	10000,	
		100,	1200,	2600,	4000,	5800,	7600,	9500,	9800,	10000,	
		150,	1600,	3000,	4200,	6000,	8000,	9600,	9900,	10000,	
		200,	1800,	3000,	4400,	6200,	8200,	9600,	9900,	10000,	
		250,	2000,	3200,	4600,	6200,	8200,	9600,	10000,	10000,	
		300,	2200,	3300,	4600,	6400,	8400,	9700,	10000,	10000,	
		350,	2200,	3400,	4700,	6400,	8400,	9800,	10000,	10000,	
		400,	2400,	3400,	4700,	6600,	8500,	9800,	10000,	10000,	
		450,	2400,	3400,	4700,	6600,	8500,	9900,	10000,	10000,	
		500,	2500,	3500,	4800,	6700,	8600,	9900,	10000,	10000,	
	}
		
	bk.shape_table_data =
	{
		{
			name	 = name,
			file	 = "BK_90",
			life	 = 1,
			fire	 = { 0, 1},
			username = user_name,
			index	 = WSTYPE_PLACEHOLDER,
		},
	}
	
	bk.warhead		= simple_warhead(0)
	
	bk.fm =
	{
		mass        = 605.0,  
		caliber     = 0.55,  
		L           = 3.5,
		I           = 270,
		Ma          = 1.0,
		Mw          = 3.0,
		cx_coeff	= {1, 0.3, 0.65, 0.09, 1.4},
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		dCydA		= {0.09, 0.036},
		A			= 0.13,
		maxAoa		= 0.4,
		finsTau		= 0.2,
		Sw			= 0.3,
		Ma_x		= 1.0,
		Kw_x		= 0.01,
		I_x			= 25,
	}
	
	bk.autopilot =
	{
		delay				= 2.0,
		Kpv					= 0.024,
		Kdv					= 3.0,
		Kiv					= 0.000012,
		Kph					= 28.0,
		Kdh					= 2.0,
		Kih					= 0.0,
		glide_height		= 120.0,
		use_current_height	= 1,
		max_vert_speed 		= 40.0,
		altim_vel_k			= 1.0,
		finsLimit			= 0.8,
	}
	
	bk.open_trigger = 
	{
		delay			= 2.0,
		trigger_dist_k	= open_dist_k,
	}

	local scheme_data =  bomblets_data
	
	scheme_data.dispenser = 
	{
		mass					= 605,
		caliber					= 0.55,
		L						= 3.5,
		I						= 270.0,
		Ma						= 1,
		Mw						= 3,
		cx_coeff				= {1, 0.3, 0.65, 0.09, 1.4},
		model_name				= "BK_90",
		set_start_args			= {},
		spawn_time				=	{
										0,
										0.2,	0.22,	0.24,	0.26,
										0.4,	0.42,	0.44,	0.46,
										0.6,	0.62,	0.64,	0.66,
										0.8,	0.82,	0.84,	0.86,
										1.0,	1.02,	1.04,	1.06,
										1.2,	1.22,	1.24,	1.26,
									},
		spawn_weight_loss		= {0,	16.9, 16.9, 16.9, 16.9, 16.9, 16.9, 16.9, 16.9,
										16.9, 16.9, 16.9, 16.9, 16.9, 16.9, 16.9, 16.9,
										16.9, 16.9, 16.9, 16.9, 16.9, 16.9, 16.9, 16.9,},
		spawn_args_change		=	{
										{1,31,1},	{2,32,1},	{3,33,1},	{4,34,1},
										{5,35,1},	{6,36,1},	{7,37,1},	{8,38,1},
										{9,39,1},	{10,40,1},	{11,41,1},	{12,42,1},
										{13,43,1},	{14,44,1},	{15,45,1},	{16,46,1},
										{17,47,1},	{18,48,1},	{19,49,1},	{20,50,1},
										{21,51,1},	{22,52,1},	{23,53,1},	{24,54,1},
									},
		op_spawns				= 26,
		use_effects				= 0,
		hide_effect_0			= 1,
	}
	
	local levParam = 
	{
		scheme			= scheme_data,
		name    		= cluster_name,
		type_name		= _("cluster"),
		cluster_scheme	= cluster_scheme_,
	}
	
	bk.launcher =
    {
        cluster = cluster_desc("Bomb_Other", wsType_Bomb_Cluster, levParam),
    }
	
	declare_weapon(bk)
	return bk
end

local BK90_MJ1 = BK_90("BK90_MJ1", _("BK90 MJ1"), "inertial_guided_glide_bomb", _("MJ1"), "disp_bomblets", 1.4, wsType_BK90MJ1, {
	bomblets =
	{
		wind_sigma					= 25,
		impulse_sigma				= 4,
		moment_sigma				= 0.1,
		count						= 72,
		effect_count				= 72,
		mass						= 6,
		caliber						= 0.132,
		cx_coeff					= {1, 0.39, 0.38, 0.236, 1.31},
		L							= 0.3,
		I							= 0.02,
		Ma							= 0.06,
		Mw							= 0.8,
		model_name					= "MUS_JAS_1",
		init_pos					=	{
											{1.0674599409103394,	0.12363214790821075,	-0.2},
											{1.0674599409103394,	0.12363214790821075,	0.0},
											{1.0674599409103394,	0.12363214790821075,	0.2},
											
											{1.0674779415130615,	-0.0071935374289751053,	-0.2},
											{1.0674779415130615,	-0.0071935374289751053,	0.0},
											{1.0674779415130615,	-0.0071935374289751053,	0.2},
											
											{0.90919733047485352,	-0.0064242500811815262,	-0.2},
											{0.90919733047485352,	-0.0064242500811815262,	0.0},
											{0.90919733047485352,	-0.0064242500811815262,	0.2},
											
											{0.90921545028686523,	0.12363214790821075,	-0.2},
											{0.90921545028686523,	0.12363214790821075,	0.0},
											{0.90921545028686523,	0.12363214790821075,	0.2},
											
											{0.75522589683532715,	0.12363214790821075,	-0.2},
											{0.75522589683532715,	0.12363214790821075,	0.0},
											{0.75522589683532715,	0.12363214790821075,	0.2},
											
											{0.75508940219879150,	-0.0071935374289751053,	-0.2},
											{0.75508940219879150,	-0.0071935374289751053,	0.0},
											{0.75508940219879150,	-0.0071935374289751053,	0.2},
											
											{0.59696328639984131,	-0.0064242500811815262,	-0.2},
											{0.59696328639984131,	-0.0064242500811815262,	0.0},
											{0.59696328639984131,	-0.0064242500811815262,	0.2},														
											
											{0.59682685136795044,	0.12363214790821075,	-0.2},
											{0.59682685136795044,	0.12363214790821075,	0.0},
											{0.59682685136795044,	0.12363214790821075,	0.2},
											
											{0.44255921244621277,	0.12363214790821075,	-0.2},
											{0.44255921244621277,	0.12363214790821075,	0.0},
											{0.44255921244621277,	0.12363214790821075,	0.2},
											
											{0.44267767667770386,	-0.0071935374289751053,	-0.2},
											{0.44267767667770386,	-0.0071935374289751053,	0.0},
											{0.44267767667770386,	-0.0071935374289751053,	0.2},
											
											{0.28429663181304932,	-0.0064242351800203323,	-0.2},
											{0.28429663181304932,	-0.0064242351800203323,	0.0},
											{0.28429663181304932,	-0.0064242351800203323,	0.2},
											
											{0.28441512584686279,	0.12363214790821075,	-0.2},
											{0.28441512584686279,	0.12363214790821075,	0.0},
											{0.28441512584686279,	0.12363214790821075,	0.2},
											
											{0.13067781925201416,	0.12363214790821075,	-0.2},
											{0.13067781925201416,	0.12363214790821075,	0.0},
											{0.13067781925201416,	0.12363214790821075,	0.2},
											
											{0.13079625368118286,	-0.0071935225278139114,	-0.2},
											{0.13079625368118286,	-0.0071935225278139114,	0.0},
											{0.13079625368118286,	-0.0071935225278139114,	0.2},
											
											{-0.027584791183471680,	-0.0064242351800203323,	-0.2},
											{-0.027584791183471680,	-0.0064242351800203323,	0.0},
											{-0.027584791183471680,	-0.0064242351800203323,	0.2},
											
											{-0.027466297149658203,	0.12363214790821075,	-0.2},
											{-0.027466297149658203,	0.12363214790821075,	0.0},
											{-0.027466297149658203,	0.12363214790821075,	0.2},
											
											{-0.18173396587371826,	0.12363214790821075,	-0.2},
											{-0.18173396587371826,	0.12363214790821075,	0.0},
											{-0.18173396587371826,	0.12363214790821075,	0.2},
											
											{-0.18187046051025391,	-0.0071935225278139114,	-0.2},
											{-0.18187046051025391,	-0.0071935225278139114,	0.0},
											{-0.18187046051025391,	-0.0071935225278139114,	0.2},
											
											{-0.33999657630920410,	-0.0064242351800203323,	-0.2},
											{-0.33999657630920410,	-0.0064242351800203323,	0.0},
											{-0.33999657630920410,	-0.0064242351800203323,	0.2},
											
											{-0.34013295173645020,	0.12363214790821075,	-0.2},
											{-0.34013295173645020,	0.12363214790821075,	0.0},
											{-0.34013295173645020,	0.12363214790821075,	0.2},
											
											{-0.49412250518798828,	0.12363214790821075,	-0.2},
											{-0.49412250518798828,	0.12363214790821075,	0.0},
											{-0.49412250518798828,	0.12363214790821075,	0.2},
											
											{-0.49410438537597656,	-0.0071935225278139114,	-0.2},
											{-0.49410438537597656,	-0.0071935225278139114,	0.0},
											{-0.49410438537597656,	-0.0071935225278139114,	0.2},
											
											{-0.65238511562347412,	-0.0064242649823427200,	-0.2},
											{-0.65238511562347412,	-0.0064242649823427200,	0.0},
											{-0.65238511562347412,	-0.0064242649823427200,	0.2},
											
											{-0.65236699581146240,	0.12363214790821075,	-0.2},
											{-0.65236699581146240,	0.12363214790821075,	0.0},
											{-0.65236699581146240,	0.12363214790821075,	0.2},
										},
										
		init_ypr					=	{
											{4.7123886426183308,0,0},
											{4.7123886426183308,0,0},
											{4.7123886426183308,0,0},
											{1.5707963148700226,0,0},
											{1.5707963148700226,0,0},
											{1.5707963148700226,0,0},
										},
										
		explosion_impulse_coeff		= 350,
		explosion_dont_use_x_axis	= 1,
		release_rnd_coeff			= 0.9,
		chute_open_time				= 0.4,
		chute_cut_time				= 500.0,
		chute_diam					= 0.8,
		chute_Cx					= 1,
		chute_rnd_coeff				= 0.5,
		explosion_center			=	{{0,0, -10000},{0,0,10000},},
		spawn_options				=	{
											{0,1,3}, {0,2,3}, {0,3,3}, {0,4,3},
											{0,5,3}, {0,6,3}, {0,7,3}, {0,8,3},
											{0,9,3}, {0,10,3}, {0,11,3}, {0,12,3},
											{0,13,3}, {0,14,3}, {0,15,3}, {0,16,3},
											{0,17,3}, {0,18,3}, {0,19,3}, {0,20,3},
											{0,21,3}, {0,22,3}, {0,23,3}, {0,24,3},
										},
	},
	warhead			=  simple_warhead(20, 120), -- x3 for effect on target 11.7
})

local BK90_MJ2 = BK_90("BK90_MJ2", _("BK90 MJ2"), "inertial_guided_glide_bomb", _("MJ2"), "disp_bomblets", 1.5, wsType_BK90MJ2, {
	bomblets =
	{
		wind_sigma					= 25,
		impulse_sigma				= 4,
		moment_sigma				= 0.1,
		count						= 24,
		effect_count				= 24,
		mass						= 18,
		caliber						= 0.132,
		cx_coeff					= {1, 0.39, 0.38, 0.236, 1.31},
		L							= 0.5,
		I							= 0.061333,
		Ma							= 0.06,
		Mw							= 0.8,
		model_name					= "MUS_JAS_2",
		connectors_model_name		= "BK_90",
		explosion_impulse_coeff		= 550,
		explosion_dont_use_x_axis	= 1,
		release_rnd_coeff			= 0.9,
		chute_open_time				= 0.7,
		chute_cut_time				= 500.0,
		chute_diam					= 1.8,
		chute_Cx					= 1,
		chute_rnd_coeff				= 0.65,
		explosion_center			=	{{0,0, -10000},{0,0,10000},},
		spawn_options				=	{
											{0,1,1}, {0,2,1}, {0,3,1}, {0,4,1},
											{0,5,1}, {0,6,1}, {0,7,1}, {0,8,1},
											{0,9,1}, {0,10,1}, {0,11,1}, {0,12,1},
											{0,13,1}, {0,14,1}, {0,15,1}, {0,16,1},
											{0,17,1}, {0,18,1}, {0,19,1}, {0,20,1},
											{0,21,1}, {0,22,1}, {0,23,1}, {0,24,1},
										},
	},
	warhead			=  cumulative_warhead(50.1, 120),
})

local BK90_MJ1_MJ2 = BK_90("BK90_MJ1_MJ2", _("BK90 MJ1-MJ2"), "inertial_guided_glide_bomb", _("MJ1-MJ2"), "disp_2bomblets", 1.6, wsType_BK90, {
	bomblets =
	{
		wind_sigma			= 25,
		impulse_sigma		= 4,
		moment_sigma		= 0.1,
		count				= 36,
		effect_count		= 36,
		mass				= 6,
		caliber				= 0.132,
		cx_coeff			= {1, 0.39, 0.38, 0.236, 1.31},
		L					= 0.3,
		I					= 0.02,
		Ma					= 0.06,
		Mw					= 0.8,
		model_name			= "MUS_JAS_1",
		init_pos			=	{
									{1.0674599409103394,	0.12363214790821075,	-0.2},
									{1.0674599409103394,	0.12363214790821075,	0.0},
									{1.0674599409103394,	0.12363214790821075,	0.2},
									
									{0.90919733047485352,	-0.0064242500811815262,	-0.2},
									{0.90919733047485352,	-0.0064242500811815262,	0.0},
									{0.90919733047485352,	-0.0064242500811815262,	0.2},
						
									{0.75522589683532715,	0.12363214790821075,	-0.2},
									{0.75522589683532715,	0.12363214790821075,	0.0},
									{0.75522589683532715,	0.12363214790821075,	0.2},
									
									{0.59696328639984131,	-0.0064242500811815262,	-0.2},
									{0.59696328639984131,	-0.0064242500811815262,	0.0},
									{0.59696328639984131,	-0.0064242500811815262,	0.2},														
												
									{0.44255921244621277,	0.12363214790821075,	-0.2},
									{0.44255921244621277,	0.12363214790821075,	0.0},
									{0.44255921244621277,	0.12363214790821075,	0.2},
									
									{0.28429663181304932,	-0.0064242351800203323,	-0.2},
									{0.28429663181304932,	-0.0064242351800203323,	0.0},
									{0.28429663181304932,	-0.0064242351800203323,	0.2},
									
									{0.13067781925201416,	0.12363214790821075,	-0.2},
									{0.13067781925201416,	0.12363214790821075,	0.0},
									{0.13067781925201416,	0.12363214790821075,	0.2},
									
									{-0.027584791183471680,	-0.0064242351800203323,	-0.2},
									{-0.027584791183471680,	-0.0064242351800203323,	0.0},
									{-0.027584791183471680,	-0.0064242351800203323,	0.2},
									
									{-0.18173396587371826,	0.12363214790821075,	-0.2},
									{-0.18173396587371826,	0.12363214790821075,	0.0},
									{-0.18173396587371826,	0.12363214790821075,	0.2},
									
									{-0.33999657630920410,	-0.0064242351800203323,	-0.2},
									{-0.33999657630920410,	-0.0064242351800203323,	0.0},
									{-0.33999657630920410,	-0.0064242351800203323,	0.2},
									
									{-0.49412250518798828,	0.12363214790821075,	-0.2},
									{-0.49412250518798828,	0.12363214790821075,	0.0},
									{-0.49412250518798828,	0.12363214790821075,	0.2},
									
									{-0.65238511562347412,	-0.0064242649823427200,	-0.2},
									{-0.65238511562347412,	-0.0064242649823427200,	0.0},
									{-0.65238511562347412,	-0.0064242649823427200,	0.2},
								},
										
		init_ypr			=	{
									{4.7123886426183308,0,0},
									{4.7123886426183308,0,0},
									{4.7123886426183308,0,0},
									{1.5707963148700226,0,0},
									{1.5707963148700226,0,0},
									{1.5707963148700226,0,0},
								},
		explosion_impulse_coeff		= 350,
		explosion_dont_use_x_axis	= 1,
		release_rnd_coeff			= 0.9,
		chute_open_time				= 0.4,
		chute_cut_time				= 500.0,
		chute_diam					= 0.8,
		chute_Cx					= 1,
		chute_rnd_coeff				= 0.5,
		explosion_center			=	{{0,0, -10000},{0,0,10000},},
		spawn_options				=	{
											{0,1,3}, {0,3,3}, 
											{0,5,3},  {0,7,3}, 
											{0,9,3},  {0,11,3},
											{0,13,3}, {0,15,3}, 
											{0,17,3}, {0,19,3},
											{0,21,3}, {0,23,3},
										},
	},
				
	bomblets2 =
	{
		wind_sigma				= 25,
		impulse_sigma			= 4,
		moment_sigma			= 0.1,
		count					= 12,
		effect_count			= 12,
		mass					= 18,
		caliber					= 0.132,
		cx_coeff				= {1, 0.39, 0.38, 0.236, 1.31},
		L						= 0.5,
		I						= 0.061333,
		Ma						= 0.06,
		Mw						= 0.8,
		model_name				= "MUS_JAS_2",
		init_pos				=	{
										{1.0674779415130615,	-0.0071935374289751053,	0.0},
										{0.90921545028686523,	0.12363214790821075,	0.0},
										{0.75508940219879150,	-0.0071935374289751053,	0.0},
										{0.59682685136795044,	0.12363214790821075,	0.0},
										{0.44267767667770386,	-0.0071935374289751053,	0.0},
										{0.28441512584686279,	0.12363214790821075,	0.0},
										{0.13079625368118286,	-0.0071935225278139114,	0.0},
										{-0.027466297149658203,	0.12363214790821075,	0.0},
										{-0.18187046051025391,	-0.0071935225278139114,	0.0},
										{-0.34013295173645020,	0.12363214790821075,	0.0},
										{-0.49410438537597656,	-0.0071935225278139114,	0.0},
										{-0.65236699581146240,	0.12363214790821075,	0.0},
									},
													
		init_ypr				=	{
										{4.7123886426183308,0,0},
										{1.5707963148700226,0,0},
									},
													
		explosion_impulse_coeff		= 550,
		explosion_dont_use_x_axis	= 1,
		release_rnd_coeff			= 0.9,
		chute_open_time				= 0.7,
		chute_cut_time				= 500.0,
		chute_diam					= 1.8,
		chute_Cx					= 1,
		chute_rnd_coeff				= 0.65,
		explosion_center			=	{{0,0, -10000},{0,0,10000},},
		spawn_options				=	{
											{0,2,1}, {0,4,1},
											{0,6,1}, {0,8,1},
											{0,10,1}, {0,12,1},
											{0,14,1}, {0,16,1},
											{0,18,1}, {0,20,1},
											{0,22,1}, {0,24,1},
										},
	},
	
	warhead			=  simple_warhead(20, 120), -- x3 for effect on target 11.4
	warhead2		=  cumulative_warhead(50.1, 120),  -- x3 for effect on target
})

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{BK90MJ1}",
	attribute		= BK90_MJ1.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= BK90_MJ1.Cx,
	Picture			= "bk90.png",
	displayName		= _("BK-90 MJ1 (72 x MJ1 HE-FRAG Bomblets)"),
	Weight			= BK90_MJ1.mass,
	Elements  		= {{ShapeName = "BK_90"}},
})

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{BK90MJ2}",
	attribute		= BK90_MJ2.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= BK90_MJ2.Cx,
	Picture			= "bk90.png",
	displayName		= _("BK-90 MJ2 (24 x MJ2 HEAT Bomblets)"),
	Weight			= BK90_MJ2.mass,
	Elements  		= {{ShapeName = "BK_90"}},	
})

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{BK90}",
	attribute		= BK90_MJ1_MJ2.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= BK90_MJ1_MJ2.Cx,
	Picture			= "bk90.png",
	displayName		= _("BK-90 MJ1+2 (12x MJ2 HEAT / 36x MJ1 HE-FRAG Bomblets)"),
	Weight			= BK90_MJ1_MJ2.mass,
	Elements  		= {{ShapeName = "BK_90"}},
})
