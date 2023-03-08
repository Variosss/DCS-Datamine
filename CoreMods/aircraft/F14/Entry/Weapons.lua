-- for warhead functions and default warheads map (for warheads["AIM_65"])
dofile("Scripts/Database/Weapons/warheads.lua")



local function bru_42_3x_weapon(clsid,weapon_info,left,right,bottom,attach_offset)

    local bru_42_mass = 128
    local lvl2 = weapon_info.level2
    if type(weapon_info.wsType)=="table" then
      lvl2 = weapon_info.wsType[2]
    end
	local ret = {
		category			=	weapon_info.category,
		CLSID				=	clsid,
		Picture				=	weapon_info.picture,
		attribute			=	{wsType_Weapon,	lvl2,	wsType_Container, WSTYPE_PLACEHOLDER},
		Cx_pil				=	0.0005,
		Elements 			= { }
	}
    if type(weapon_info.wsType)=="table" and weapon_info.wsType[4] ~= nil then
        ret.wsTypeOfWeapon = weapon_info.wsType
    end
    if type(weapon_info.wsType)=="string" then
        ret.wsTypeOfWeapon = weapon_info.wsType
    end
    ret.Elements[#ret.Elements + 1] = { ShapeName	= "HB_F14_EXT_BRU42",IsAdapter  =   true}
    local sz = 0
	if left then
        sz = sz + 1
        ret.Elements[#ret.Elements + 1] = {payload_CLSID = weapon_info.payload_CLSID, connector_name =	"BRU-42_LEFT"}
		if (attach_offset ~= nil) then
		  ret.Elements[#ret.Elements].attach_point_position = attach_offset
		end
    end
	if right then
        sz = sz + 1
        ret.Elements[#ret.Elements + 1] = {payload_CLSID = weapon_info.payload_CLSID, connector_name =	"BRU-42_RIGHT"}
		if (attach_offset ~= nil) then
		  ret.Elements[#ret.Elements].attach_point_position = attach_offset
		end
    end
	if bottom then
        sz = sz + 1
        ret.Elements[#ret.Elements + 1] = {payload_CLSID = weapon_info.payload_CLSID, connector_name =	"BRU-42_LOWER"}
		if (attach_offset ~= nil) then
		  ret.Elements[#ret.Elements].attach_point_position = attach_offset
		end
    end

	ret.Count  = sz
	ret.Weight = bru_42_mass +  sz * weapon_info.mass

	ret.Cx_pil = ret.Cx_pil + sz * weapon_info.Cx

    if sz > 1 then
        ret.displayName =	sz.." "..weapon_info.name
    else
        ret.displayName =	weapon_info.name
    end
	declare_loadout(ret)
    return ret
end

local function bru_42_3x_bomb(clsid,weapon_info,left,right,bottom,attach_offset)

    local bru_42_mass = 128
    local lvl2 = weapon_info.level2
    if type(weapon_info.wsType)=="table" then
      lvl2 = weapon_info.wsType[2]
    end
	local ret = {
		category			=	weapon_info.category,
		CLSID				=	clsid,
		Picture				=	weapon_info.picture,
		attribute			=	{wsType_Weapon,	lvl2,	wsType_Container, WSTYPE_PLACEHOLDER},
		Cx_pil				=	0.0005,
		Elements 			= { }
	}
    if type(weapon_info.wsType)=="table" and weapon_info.wsType[4] ~= nil then
        ret.wsTypeOfWeapon = weapon_info.wsType
    end
    if type(weapon_info.wsType)=="string" then
        ret.wsTypeOfWeapon = weapon_info.wsType
    end
    ret.Elements[#ret.Elements + 1] = { ShapeName	= "HB_F14_EXT_BRU42",IsAdapter  =   true}
    local sz = 0
	if left then
        sz = sz + 1
        ret.Elements[#ret.Elements + 1] = {ShapeName = weapon_info.ShapeName, connector_name =	"BRU-42_LEFT"}
		if (attach_offset ~= nil) then
		  ret.Elements[#ret.Elements].attach_point_position = attach_offset
		end
    end
	if right then
        sz = sz + 1
        ret.Elements[#ret.Elements + 1] = {ShapeName = weapon_info.ShapeName, connector_name =	"BRU-42_RIGHT"}
		if (attach_offset ~= nil) then
		  ret.Elements[#ret.Elements].attach_point_position = attach_offset
		end
    end
	if bottom then
        sz = sz + 1
        ret.Elements[#ret.Elements + 1] = {ShapeName = weapon_info.ShapeName, connector_name =	"BRU-42_LOWER"}
		if (attach_offset ~= nil) then
		  ret.Elements[#ret.Elements].attach_point_position = attach_offset
		end
    end

	ret.Count  = sz
	ret.Weight = bru_42_mass +  sz * weapon_info.mass

	ret.Cx_pil = ret.Cx_pil + sz * weapon_info.Cx

    if sz > 1 then
        ret.displayName =	sz.." "..weapon_info.name
    else
        ret.displayName =	weapon_info.name
    end
	declare_loadout(ret)
    return ret
end

local function mak79_4x_weapon(clsid,weapon_info,clampvariant,frontleft,frontright,rearleft,rearright,attach_offset)
    --[[
	clampvariants:
	1: outer pairs of clamps on pallet
	rear |-- *----* --> front
	         *----*
	2: inner pairs of clamps on pallet
	         -*--*-
	         -*--*-
	3: front outer rear inner clamps
	         -*---*
	         -*---*
	4: front inner rear outer clamps
	         *---*-
	         *---*-
	--]]
    local mak_79_mass = 10 -- TODO: find good value for this adapter
	local ret = {
		category			=	weapon_info.category,
		CLSID				=	clsid,
		Picture				=	weapon_info.picture,
		attribute			=	{wsType_Weapon,	weapon_info.level2,	wsType_Container, WSTYPE_PLACEHOLDER},
		Cx_pil				=	0.00001, -- TODO: what is reasonable?
		Elements 			= { }
	}

    if type(weapon_info.wsType)=="table" and weapon_info.wsType[4] ~= nil then
        ret.wsTypeOfWeapon = weapon_info.wsType
    end
    if type(weapon_info.wsType)=="string" then
        ret.wsTypeOfWeapon = weapon_info.wsType
    end
    ret.Elements[#ret.Elements + 1] = { ShapeName	= "MAK-79_VAR_"..clampvariant, IsAdapter  =   true  }
    local sz = 0
	if frontleft then
        sz = sz + 1
        ret.Elements[#ret.Elements + 1] = {payload_CLSID = weapon_info.payload_CLSID, connector_name = "F_L", use_full_connector_position = true}
		if (attach_offset ~= nil) then
		  ret.Elements[#ret.Elements].attach_point_position = attach_offset
		end
    end
	if frontright then
        sz = sz + 1
        ret.Elements[#ret.Elements + 1] = {payload_CLSID = weapon_info.payload_CLSID, connector_name = "F_R", use_full_connector_position = true}
		if (attach_offset ~= nil) then
		  ret.Elements[#ret.Elements].attach_point_position = attach_offset
		end
    end
	if rearleft then
        sz = sz + 1
        ret.Elements[#ret.Elements + 1] = {payload_CLSID = weapon_info.payload_CLSID, connector_name = "R_L", use_full_connector_position = true}
		if (attach_offset ~= nil) then
		  ret.Elements[#ret.Elements].attach_point_position = attach_offset
		end
    end
	if rearright then
        sz = sz + 1
        ret.Elements[#ret.Elements + 1] = {payload_CLSID = weapon_info.payload_CLSID, connector_name = "R_R", use_full_connector_position = true}
		if (attach_offset ~= nil) then
		  ret.Elements[#ret.Elements].attach_point_position = attach_offset
		end
    end

	ret.Count  = sz
	ret.Weight = sz * mak_79_mass +  sz * weapon_info.mass

	ret.Cx_pil = ret.Cx_pil + sz * weapon_info.Cx

    if sz > 1 then
        ret.displayName =	"MAK79 "..sz.." "..weapon_info.name
    else
        ret.displayName =	"MAK79 "..weapon_info.name
    end
	declare_loadout(ret)
    return ret
end

local function bru_32_nested(clsid,nested_loadout)
    local adu_703_bru_32_mass = 57.38

    local lvl2 = wsType_Missile
    if type(nested_loadout.attribute)=="table" then
      lvl2 = nested_loadout.attribute[2]
    end
	local ret = {
		category			=	nested_loadout.category,
		CLSID				=	clsid,
		Picture				=	nested_loadout.Picture,
		attribute			=	{wsType_Weapon,	lvl2,	wsType_Container,	WSTYPE_PLACEHOLDER},
		Cx_pil				=	0.00002, -- TODO: what is reasonable?
   		JettisonSubmunitionOnly = true,
		Elements 			= {
        }
	}
    if nested_loadout.wsTypeOfWeapon ~= nil then
        ret.wsTypeOfWeapon		=	nested_loadout.wsTypeOfWeapon
    end
    ret.Elements[#ret.Elements + 1] = { ShapeName	= "HB_F14_EXT_BRU34", IsAdapter  =   true  }
    ret.Elements[#ret.Elements + 1] = {payload_CLSID = nested_loadout.CLSID, connector_name = "WEP_BRU-34_BRU-42"}
	ret.Count  = nested_loadout.Count
	ret.Weight = adu_703_bru_32_mass + nested_loadout.Weight

	ret.Cx_pil = ret.Cx_pil + nested_loadout.Cx_pil

	--ret.displayName =	_("BRU-32 ")..nested_loadout.displayName
	ret.displayName =	nested_loadout.displayName
	declare_loadout(ret)
    return ret
end

local function phx_adapter_nested(clsid,nested_loadout)
    local phx_adapter_mass = 0 -- TODO
	local ret = {
		category			=	nested_loadout.category,
		CLSID				=	clsid,
		Picture				=	nested_loadout.Picture,
		attribute			=	{wsType_Weapon,	nested_loadout.attribute[2],	wsType_Container,	WSTYPE_PLACEHOLDER},
		Cx_pil				=	0.0001, -- TODO: what is reasonable?
   		JettisonSubmunitionOnly = true,
		Elements 			= {
        }
	}
    if nested_loadout.wsTypeOfWeapon ~= nil then
        ret.wsTypeOfWeapon		=	nested_loadout.wsTypeOfWeapon
    end
    ret.Elements[#ret.Elements + 1] = { ShapeName	= "HB_F14_EXT_SHOULDER_PHX_L", IsAdapter  =   true  }
    ret.Elements[#ret.Elements + 1] = {payload_CLSID = nested_loadout.CLSID, connector_name = "WEP_Phoenix_Connector"}
	ret.Count  = nested_loadout.Count
	ret.Weight = phx_adapter_mass + nested_loadout.Weight


	ret.Cx_pil = ret.Cx_pil + nested_loadout.Cx_pil

	--ret.displayName =	_("PHX ")..nested_loadout.displayName
	ret.displayName =	nested_loadout.displayName
	declare_loadout(ret)
    return ret
end

--------- MISSILES ---------
----------------------------------------------

function make_aim_54(missile, motor, smokey)

	local shape_name = "AIM-54"..missile.name.."_"..motor.name
	local username = "AIM-54"..missile.name.."-"..motor.name

	-- accounts for the mk47 mod0 or mod1
	local smoke = {1, 1, 1, 1}
	if smokey ~= nil and smokey == false then
		smoke = {0.8, 0.8, 0.8, 0.05 }
	end

	local weapon = {
    category		= CAT_AIR_TO_AIR,
    name			= "AIM_54".. missile.name .."_"..motor.name,
    user_name		= _(username),
    wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AA_Missile,WSTYPE_PLACEHOLDER},
    --class_name	= "wAmmunitionPhoenix",
    shape_table_data =
    {
        {
            name	 = shape_name;
            file  = missile.model_name;
            life  = 1;
            fire  = { 0, 1};
            username = username;
            index = WSTYPE_PLACEHOLDER,
        },
    },


        Escort = 0,
        Head_Type = 2,
        sigma = {5, 5, 5},
        M = missile.mass + motor.propellant_mass,
        H_max = 20000.0,
        H_min = 1.0,
        Diam = 380.0,
        Cx_pil = 5,
        D_max = 14000.0,
        D_min = 700.0,
        Head_Form = 1,
        Life_Time = 200.0,
        Nr_max = 18,
        v_min = 140.0,
        v_mid = 700.0,
        Mach_max = 4.0,
        t_b = 0.0,
        t_acc = 3.0,
        t_marsh = 5.0,
        Range_max = 180000.0,
        H_min_t = 3.0,
        Fi_start = 0.5,
        Fi_rak = 3.14152,
        Fi_excort = 1.05,
        Fi_search = 1.05,
        OmViz_max = 0.52,
        warhead = warheads["AIM_54"],
        exhaust = smoke,
        X_back = -1.72,
        Y_back = 0.0,
        Z_back = 0.0,
        Reflection = 0.12,
        KillDistance = 15.0,
		ccm_k0 = missile.ccm_k0,
        loft = 1,
        hoj = missile.hoj,
        go_active_by_default = missile.go_active_by_default,
        active_radar_lock_dist = 18520,
        PN_gain = missile.PN_gain,
        loft_factor = missile.loft_factor,
        supersonic_A_coef_skew = 0.295, -- наклон прямой коэффициента отвала поляры на сверхзвуке
		nozzle_exit_area = 1e-6, -- площадь выходного сечения сопла
		
        PN_coeffs = {
            4,
            15000.0 ,1.0,
            25000.0, 0.85,
            40000.0, 0.65,
            100000.0, 0.3,
        };

        ModelData = {   58,  -- model params count
                        1.1,   -- characteristic square (характеристическая площадь)
                        
                        -- параметры зависимости Сx
                        0.042 , -- Cx_k0 планка Сx0 на дозвуке ( M << 1)
                        0.083 , -- Cx_k1 высота пика волнового кризиса
                        0.01 , -- Cx_k2 крутизна фронта на подходе к волновому кризису
                        -0.24, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1)
                        0.12 , -- Cx_k4 крутизна спада за волновым кризисом 
                        0.18 , -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))
                        
                        -- параметры зависимости Cy
                        1.6 , -- Cy_k0 планка Сy0 на дозвуке ( M << 1)
                        1.3	, -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)
                        1.2 , -- Cy_k2 крутизна спада(фронта) за волновым кризисом  
                        
                        0.35, -- 7 Alfa_max  максимальный балансировачный угол, радианы
                        0.0, --угловая скорость создаваймая моментом газовых рулей  
                        
                    -- Engine data. Time, fuel flow, thrust.	
                    --  t_statr     t_b     t_accel     t_march     t_inertial      t_break     t_end           -- Stage
                        0.27,       -1.0,   motor.burn_time,       0.1,        0.0,            0.0,        1.0e9,         -- time of stage, sec
                        0.0,       0.0,     motor.propellant_mass / motor.burn_time,       0.0,        0.0,            0.0,        0.0,           -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
                        0.0,       0.0,     motor.thrust,    0.0,        0.0,            0.0,        0.0,           -- thrust, newtons
            
                        1.0e9, -- таймер самоликвидации, сек
                        200.0, -- время работы энергосистемы, сек
                        0, -- абсолютная высота самоликвидации, м
                        2.5, -- время задержки включения управления (маневр отлета, безопасности), сек
                        40000.0, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр "горка", м
                        30000.0, -- дальность до цели, при которой маневр "горка" завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м 
                        missile.loft_angle,  -- синус угла возвышения траектории набора горки
                        30.0, -- продольное ускорения взведения взрывателя
                        0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
                        missile.guidance.k0, -- характеристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
                        missile.guidance.k1, -- характеристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
                        missile.guidance.w_cutoff, -- характеристика системы САУ-РАКЕТА,  полоса пропускания контура управления

                        -- DLZ data. Use numbers below for your implemetation. --From Denis Alekseev
                        -- ЗРП. Данные для рассчета дальностей пуска (индикация на прицеле)
                        50.0, -- производная дальности по скорости носителя на высоте 1км, ППС
                        -45.0, -- производная дальности по скорости цели на высоте 1км, ЗПС
                        -7.2, -- производная по высоте производной дальности по скорости цели, ЗПС
                        72000.0, -- дальность ракурс 180 град(навстречу), Н=5000м, V=900км/ч, м
                        28000.0, -- дальность ракурс 180(в догон) град, Н=5000м, V=900км/ч, м
                        120000.0, -- дальность ракурс 180(навстречу) град, Н=10000м, V=900км/ч, м
                        46000.0, -- дальность ракурс 0(в догон) град, Н=10000м, V=900км/ч, м
                        44000.0, -- дальность ракурс 180 град, Н=1000м, V=900км/ч, м
                        20000.0, -- дальность ракурс 180(в догон) град, Н=1000м, V=900км/ч, м
                        3500.0, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в нижнюю полусферу. Уменьшение дальности при стрельбе вниз.
                        0.4, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в верхнюю полусферу. Увеличение дальности при стрельбе вверх.
                        -0.012, -- Вертикальная плоскость. Угол перегиба кривой разрешенной дальности, верхняя - нижняя полусфера.
                        0.7, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя
        },
    }

	return weapon
end
-- Common missile properties
local AIM_54A_missile_properties = {
	name = "A",
	model_name = "HB_F14_EXT_AIM54_A",
	mass = 281.0,
	PN_gain = 5,
	loft_factor = 35.0,
	loft_angle = 0.17, --this is sin(loft_angle)
	go_active_by_default = 0,
	hoj = 1,
	ccm_k0 = 1.0,
	guidance = {
		k0 = 36.0,
		k1 = 7.8,
		w_cutoff = 1.0,
	},
}

local AIM_54C_missile_properties = {
	name = "C",
	model_name = "HB_F14_EXT_AIM54",
	mass = 291.0,
	PN_gain = 5,
	loft_factor = 35.0,
	loft_angle = 0.17, --this is sin(loft_angle)
	go_active_by_default = 1,
	hoj = 1,
	ccm_k0 = 0.2,
	guidance = {
		k0 = 36.0,
		k1 = 7.8,
		w_cutoff = 1.0,
	},
}

local MK47_motor_properties = {
	name = "Mk47",
	propellant_mass = 163.0,
	burn_time = 27.0,
	thrust = 13595.0,
}

local MK60_motor_properties = {
	name = "Mk60",
	propellant_mass = 163.0,
	burn_time = 20.6,
	thrust = 17793.0,
}


local AIM_54A_Mk47 = make_aim_54(AIM_54A_missile_properties, MK47_motor_properties)
local AIM_54A_Mk60 = make_aim_54(AIM_54A_missile_properties, MK60_motor_properties)

local AIM_54C_Mk47 = make_aim_54(AIM_54C_missile_properties, MK47_motor_properties, false)
local AIM_54C_Mk60 = make_aim_54(AIM_54C_missile_properties, MK60_motor_properties)

declare_weapon(AIM_54A_Mk47)
declare_weapon(AIM_54A_Mk60)
declare_weapon(AIM_54C_Mk47)
declare_weapon(AIM_54C_Mk60)

declare_loadout({	-- AIM-54A Mk47
    category		=	CAT_AIR_TO_AIR,
    CLSID			= 	"{AIM_54A_Mk47}",
    Picture			=	"aim54.png",
    --wsTypeOfWeapon	=	AIM_54A_Mk47.wsTypeOfWeapon,
    displayName		=	AIM_54A_Mk47.user_name,
    --attribute		=	{wsType_Weapon, wsType_Missile, wsType_Container, WSTYPE_PLACEHOLDER},
    attribute	=	AIM_54A_Mk47.wsTypeOfWeapon,
    Cx_pil			=	AIM_54A_Mk47.Cx_pil  / 4096.0,
    Count			=	1,
    Weight			=	AIM_54A_Mk47.M,
    Elements	=
    {
		--{	ShapeName	=	"HB_F14_EXT_PHX_ALU"  ,	IsAdapter  	   =   true  },
        {
            DrawArgs	=
            {
                [1]	=	{1,	1},
                [2]	=	{2,	1},
            }, -- end of DrawArgs
            --Position	=	{0,	0,	0},
            --connector_name = "WEP_Phoenix_FrontPallette_L_ALU",
            ShapeName	=	"AIM-54A_Mk47",
        },
    }, -- end of Elements
})

declare_loadout({	-- AIM-54A Mk60
    category		=	CAT_AIR_TO_AIR,
    CLSID			= 	"{AIM_54A_Mk60}",
    Picture			=	"aim54.png",
    --wsTypeOfWeapon	=	AIM_54A_Mk60.wsTypeOfWeapon,
    displayName		=	AIM_54A_Mk60.user_name,
    --attribute		=	{wsType_Weapon, wsType_Missile, wsType_Container, WSTYPE_PLACEHOLDER},
    attribute	=	AIM_54A_Mk60.wsTypeOfWeapon,
    Cx_pil			=	AIM_54A_Mk60.Cx_pil / 4096.0,
    Count			=	1,
    Weight			=	AIM_54A_Mk60.M,
    Elements	=
    {
		--{	ShapeName	=	"HB_F14_EXT_PHX_ALU"  ,	IsAdapter  	   =   true  },
        {
            DrawArgs	=
            {
                [1]	=	{1,	1},
                [2]	=	{2,	1},
            }, -- end of DrawArgs
            --Position	=	{0,	0,	0},
            --connector_name = "WEP_Phoenix_FrontPallette_L_ALU",
            ShapeName	=	"AIM-54A_M60",
        },
    }, -- end of Elements
})

declare_loadout({	-- AIM-54C Mk47
    category		=	CAT_AIR_TO_AIR,
    CLSID			= 	"{AIM_54C_Mk47}",
    Picture			=	"aim54.png",
    --wsTypeOfWeapon	=	AIM_54C_Mk47.wsTypeOfWeapon,
    displayName		=	AIM_54C_Mk47.user_name,
    --attribute		=	{wsType_Weapon, wsType_Missile, wsType_Container, WSTYPE_PLACEHOLDER},
    attribute	=	AIM_54C_Mk47.wsTypeOfWeapon,
    Cx_pil			=	AIM_54C_Mk47.Cx_pil / 4096.0,
    Count			=	1,
    Weight			=	AIM_54C_Mk47.M,
    Elements	=
    {
		--{	ShapeName	=	"HB_F14_EXT_PHX_ALU"  ,	IsAdapter  	   =   true  },
        {
            DrawArgs	=
            {
                [1]	=	{1,	1},
                [2]	=	{2,	1},
            }, -- end of DrawArgs
            --Position	=	{0,	-0.5,	0},
            --connector_name = "WEP_Phoenix_FrontPallette_L_ALU",
            ShapeName	=	"AIM-54C_M47",
        },
    }, -- end of Elements
})

declare_loadout({	-- AIM-54C Mk47
    category		=	CAT_AIR_TO_AIR,
    CLSID			= 	"{AIM_54C_Mk60}",
    Picture			=	"aim54.png",
    --wsTypeOfWeapon	=	AIM_54C_Mk47.wsTypeOfWeapon,
    displayName		=	AIM_54C_Mk60.user_name,
    --attribute		=	{wsType_Weapon, wsType_Missile, wsType_Container, WSTYPE_PLACEHOLDER},
    attribute	=	AIM_54C_Mk60.wsTypeOfWeapon,
    Cx_pil			=	AIM_54C_Mk60.Cx_pil / 4096.0,
    Count			=	1,
    Weight			=	AIM_54C_Mk60.M,
    Elements	=
    {
		--{	ShapeName	=	"HB_F14_EXT_PHX_ALU"  ,	IsAdapter  	   =   true  },
        {
            DrawArgs	=
            {
                [1]	=	{1,	1},
                [2]	=	{2,	1},
            }, -- end of DrawArgs
            --Position	=	{0,	-0.5,	0},
            --connector_name = "WEP_Phoenix_FrontPallette_L_ALU",
            ShapeName	=	"AIM-54C_M60",
        },
    }, -- end of Elements
})

local function shoulder_aim_54(clsid, element, elem_CLSID, side)  -- side L or R
	local ret = {
		category			=	CAT_AIR_TO_AIR,
		CLSID				=	clsid,
		Picture				=	"aim54.png",
		wsTypeOfWeapon		=	element.wsTypeOfWeapon,
		attribute			=	{4,	4,	32,	WSTYPE_PLACEHOLDER},
		Cx_pil				=	1.25 * (element.Cx_pil/4096.0),
								-- per F-14 perf manual:
								-- shoulder AIM54 drag index = 12
								-- AIM54 shoulder adapter index = 3
								-- total drag index = 15, add 25% more drag to shoulder AIM54
		Count				=	1,
		Weight				=	element.M + 45.36,  --100lbs for LAU-93
		JettisonSubmunitionOnly = true,
		Elements			=
		{
			{	ShapeName	=	"HB_F14_EXT_SHOULDER_PHX_"..side  ,	IsAdapter  	   =   true  },
			{	payload_CLSID = elem_CLSID , connector_name = "WEP_Phoenix_Connector"}
		}-- end of Elements
	}
    -- actually a LAU-93 adapter, the LAU-93 is internal to the adapter (and the rails also have LAU-93)
	--ret.displayName =	_("LAU-93 ").." "..element.name
	--ret.displayName =	element.name
    ret.displayName = element.user_name
	declare_loadout(ret)
end

-- shoulder phoenix stations
shoulder_aim_54("{SHOULDER AIM_54C_Mk60 L}", AIM_54C_Mk60, "{AIM_54C_Mk60}", "L")
shoulder_aim_54("{SHOULDER AIM_54C_Mk60 R}", AIM_54C_Mk60, "{AIM_54C_Mk60}", "R")
shoulder_aim_54("{SHOULDER AIM_54C_Mk47 L}", AIM_54C_Mk47, "{AIM_54C_Mk47}", "L")
shoulder_aim_54("{SHOULDER AIM_54C_Mk47 R}", AIM_54C_Mk47, "{AIM_54C_Mk47}", "R")
shoulder_aim_54("{SHOULDER AIM_54A_Mk60 L}", AIM_54A_Mk60, "{AIM_54A_Mk60}", "L")
shoulder_aim_54("{SHOULDER AIM_54A_Mk60 R}", AIM_54A_Mk60, "{AIM_54A_Mk60}", "R")
shoulder_aim_54("{SHOULDER AIM_54A_Mk47 L}", AIM_54A_Mk47, "{AIM_54A_Mk47}", "L")
shoulder_aim_54("{SHOULDER AIM_54A_Mk47 R}", AIM_54A_Mk47, "{AIM_54A_Mk47}", "R")

----- sidewinders
-- from aim9_family.lua


local aim9_variants =
{
	["AIM-9"]  		= {picture = "us_AIM-9L.png", display_name = _("AIM-9M")	  	 			,wstype = {4,	4,	7	, AIM_9 },	category = CAT_AIR_TO_AIR, mass = 86.64	},
	["AIM-9P"] 		= {picture = "us_AIM-9P.png", display_name = _("AIM-9P")	  	 			,wstype = {4,	4,	7	, AIM_9P},	category = CAT_AIR_TO_AIR, mass = 86.18	},
	["AIM-9L"]		= {picture = "us_AIM-9L.png", display_name = _("AIM-9L"), wstype = "weapons.missiles.AIM-9L",	category = CAT_AIR_TO_AIR	},
    ["ais-pod-t50_l"] = {picture = "ais-pod-t50_l.png", display_name = _("AN/ASQ-T50 TCTS Pod - ACMI Pod")	,wstype = {4,	15,	47	,	 108},	category = CAT_PODS,       mass = 62.6  },
    ["ais-pod-t50_r"] = {picture = "ais-pod-t50_r.png", display_name = _("AN/ASQ-T50 TCTS Pod - ACMI Pod")	,wstype = {4,	15,	47	,	 108},	category = CAT_PODS,       mass = 62.6  },
    ["ais-pod-t50_d"] = {picture = "ais-pod-t50_d.png", display_name = _("AN/ASQ-T50 TCTS Pod - ACMI Pod")	,wstype = {4,	15,	47	,	 108},	category = CAT_PODS,       mass = 62.6  },
}

local function aim_9_with_adapter(CLSID,aim_9_variant)
	local var 	   = aim9_variants[aim_9_variant] or aim9_variants["AIM-9"]
	local var_mass = var.mass or 85.5
    local name_prefix = "LAU-7 "
    local pic = var.picture or "aim9p.png"
	declare_loadout({
		category			= var.category,
		CLSID 				= CLSID,
		Picture				=	pic,
		displayName			=	name_prefix..var.display_name,
		wsTypeOfWeapon		=   var.wstype,
		attribute			=	{4,	4,	32,	111},
		Cx_pil				=	1.125*(2.58 / 4096.0),  -- 2.58 from AIM_9L.Cx_pil
								-- per F-14 perf manual:
								-- shoulder AIM9 drag index = 8
								-- AIM9 shoulder adapter index = 1
								-- total drag index = 9, add 12.5% (1/8) more drag to shoulder AIM9
		Count				=	1,
		Weight				=	15 + var_mass,
		JettisonSubmunitionOnly = true,
		Elements			=
		{
			{	ShapeName	=	"HB_F14_EXT_LAU-7"	   	  ,	IsAdapter  	   =   true},
			{	ShapeName	=	aim_9_variant	  ,	connector_name =  "WEP_Sidewinder_Extra"},
		}-- end of Elements
	})
end

local function aim_9_without_adapter(CLSID,aim_9_variant,name_prefix)
	local var = aim9_variants[aim_9_variant] or aim9_variants["AIM-9"]
	local var_mass = var.mass or 85.5
    local pic = var.picture or "aim9p.png"
	declare_loadout({
		category			= 	var.category,
		CLSID 				= 	CLSID,
		Picture				=	pic,
		displayName			=	name_prefix..var.display_name,
		attribute			=	var.wstype,
		Cx_pil				=	2.58 / 4096.0,  -- 2.58 from AIM_9L.Cx_pil
		Count				=	1,
		Weight				=	var_mass,
		Elements			=  {{ShapeName = aim_9_variant}}-- end of Elements
	})
end

--for i,v in ipairs({"L","R"}) do
--end
--aim_9_with_adapter("{LAU-7 - AIM-9P}","AIM-9P")
aim_9_with_adapter("{LAU-7 - AIM-9M}","AIM-9")
aim_9_with_adapter("{LAU-7 - AIM-9L}","AIM-9L")
aim_9_with_adapter("{LAU-7 - TCTS}","ais-pod-t50_d")

-- wingtip sidewinders use "adapter" built into the external model
aim_9_without_adapter("{LAU-138 wtip - AIM-9M}","AIM-9","LAU-138 ")
aim_9_without_adapter("{LAU-138 wtip - AIM-9L}","AIM-9L","LAU-138 ")
aim_9_without_adapter("{LAU-138 wtip - TCTS L}","ais-pod-t50_l","")
aim_9_without_adapter("{LAU-138 wtip - TCTS R}","ais-pod-t50_r","")

----- sparrows
local function f14_shoulder_aim_7(clsid, missilename, wstype)
	local ret = {
		category			=	CAT_AIR_TO_AIR,
		CLSID				=	clsid,
		Picture				=	"aim7_r.png",
        wsTypeOfWeapon		=   wstype, -- {4,	4,	7,	21},
		attribute			=	{4,	4,	32,	WSTYPE_PLACEHOLDER},
		Cx_pil				=	1.33 * (2.21 / 4096.0),  -- 2.21 from AIM-7 definition
								-- per F-14 perf manual:
								-- shoulder AIM7 drag index = 6
								-- AIM7 shoulder adapter index = 2
								-- total drag index = 8, add 33% (2/6) more drag to shoulder AIM7
		Count				=	1,
		Weight				=	54.4 + 230,
		JettisonSubmunitionOnly = true,
		Elements			=
		{
			{	ShapeName	=	"HB_F14_EXT_SPARROW_PYLON" ,IsAdapter  =   true  },
			{	ShapeName	=	"HB_F14_EXT_AIM-7" , connector_name =  "WEP_Sparrow_Connector", use_full_connector_position = true}
		}-- end of Elements
	}
    -- actually LAU-92 adapter, the LAU-92 is internal to the adapter and also internal in the F-14 belly sparrow slots
	--ret.displayName =	_("LAU-92").." "..missilename
    ret.displayName =	missilename
	declare_loadout(ret)
end

local function f14_belly_aim_7(clsid, missilename, wstype, mass)
	local ret = {
		category			=	CAT_AIR_TO_AIR,
		CLSID				=	clsid,
		Picture				=	"aim7_r.png",
    Count			=	1,
    Weight			=	mass,
        attribute		=   wstype, --{4,	4,	7,	21},
		Cx_pil				=	(2.21 / 4096.0),--0.001959765625,
 -- AKO this value is almost 4x higher than 2.21/4096!
								-- note: cannot reduce belly AIM7 drag here without affecting missile flyout performance
		Count				=	1,
		Weight				=	230,
		Weight_Empty		=	0,
		Elements			=
		{
			{	ShapeName	=	"HB_F14_EXT_AIM-7"}
		}-- end of Elements
	}
    -- actually LAU-92 adapter, the LAU-92 is internal to the adapter and also internal in the F-14 belly sparrow slots
	--ret.displayName =	_("LAU-92").." "..missilename
    ret.displayName =	missilename

	declare_loadout(ret)
end

f14_shoulder_aim_7("{SHOULDER AIM-7M}", "AIM-7M", {4, 4,  7,  21})
f14_belly_aim_7("{BELLY AIM-7M}", "AIM-7M", {4, 4,  7,  21}, 231)
f14_shoulder_aim_7("{SHOULDER AIM-7E}", "AIM-7E", "weapons.missiles.AIM-7E")
f14_belly_aim_7("{BELLY AIM-7E}", "AIM-7E", "weapons.missiles.AIM-7E", 231)
f14_shoulder_aim_7("{SHOULDER AIM-7F}", "AIM-7F", "weapons.missiles.AIM-7F")
f14_belly_aim_7("{BELLY AIM-7F}", "AIM-7F", "weapons.missiles.AIM-7F", 231)
f14_shoulder_aim_7("{SHOULDER AIM-7MH}", "AIM-7MH", "weapons.missiles.AIM-7MH")
f14_belly_aim_7("{BELLY AIM-7MH}", "AIM-7MH", "weapons.missiles.AIM-7MH", 231)
f14_shoulder_aim_7("{SHOULDER AIM-7P}", "AIM-7P", "weapons.missiles.AIM-7P")
f14_belly_aim_7("{BELLY AIM-7P}", "AIM-7P", "weapons.missiles.AIM-7P", 231)

----- fuel tanks
local GALLON_TO_KG = 3.785 * 0.8
declare_loadout(
{
    category		= CAT_FUEL_TANKS,
    CLSID			= "{F14-300gal-empty}",
    attribute		=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
    Picture	=	"PTB.png",
    Weight_Empty	= 50,
    Weight			= 70, --20 eunusable or something
    Capacity = 300*GALLON_TO_KG,
    --attribute	=	{1,	3,	43,	12},
    shape_table_data =
    {
        {
            name	= "HB_F14_EXT_DROPTANK_EMPTY";
            file	= "HB_F14_EXT_DROPTANK";
            life	= 1;
            fire	= { 0, 1};
            username	= "Fuel tank 300 gal";
            index	= WSTYPE_PLACEHOLDER;
        },
    },
    Elements	=
    {
        [1]	=
        {
            Position	=	{0,	0,	0},
            ShapeName	=	"HB_F14_EXT_DROPTANK_EMPTY",
        },
    }, -- end of Elements
    displayName	=	_("Fuel tank 300 gal (empty)"),
    Cx_pil = 0.0011,
})

declare_loadout(
{
    category		= CAT_FUEL_TANKS,
    CLSID			= "{F14-300gal}",
    attribute		=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
    Picture	=	"PTB.png",
    Weight_Empty	= 50,
    Weight			= 50 + 300 * GALLON_TO_KG,
    Capacity = 300*GALLON_TO_KG,
    --attribute	=	{1,	3,	43,	12},
    shape_table_data =
    {
        {
            name	= "HB_F14_EXT_DROPTANK";
            file	= "HB_F14_EXT_DROPTANK";
            life	= 1;
            fire	= { 0, 1};
            username	= "Fuel tank 300 gal";
            index	= WSTYPE_PLACEHOLDER;
        },
    },
    Elements	=
    {
        [1]	=
        {
            Position	=	{0,	0,	0},
            ShapeName	=	"HB_F14_EXT_DROPTANK",
        },
    }, -- end of Elements
    displayName	=	_("Fuel tank 300 gal"),
    Cx_pil = 0.0011,
})


-- LANTIRN
declare_loadout(
{
    category		= CAT_PODS,
    CLSID			= "{F14-LANTIRN-TP}",
    attribute		= {wsType_Weapon, wsType_GContainer, wsType_Control_Cont, WSTYPE_PLACEHOLDER},
    Picture	=	"LantirnTP.png",
    Weight			= 342,
    shape_table_data =
    {
        {
            name	= "HB_F14_EXT_LANTIRN_PYLON";
            --file	= "HB_F14_EXT_LANTIRN_PYLON";
            life	= 1;
            fire	= { 0, 1};
            username	= "HB_F14_EXT_LANTIRN_PYLON";
            index	= WSTYPE_PLACEHOLDER;
        },
    },
    Elements	=
    {
    }, -- end of Elements
	Sensors	 = 
	{
		OPTIC  = {"LANTIRN AAQ-14 FLIR"}
	},
    displayName	=	_("LANTIRN Targeting Pod"),
    Cx_pil = 0.002,
	laserRanger = true,
    laserDesignator = true,
})

-- SPECIAL
--[[
-- failed experiment
declare_loadout(
{
    category		= CAT_SERVICE,
    CLSID			= "{F14-CLEAN-RAIL}",
    Picture			=	"Weaponx.png",
    PictureBlendColor = { r = 112/255,g = 140/255,b = 170/255,a = 1},
    Weight_Empty	=	0,
    Weight			=	0,
    Cx_pil			=	0,
    attribute		=	{0,0,0,0},
    displayName	=	_("Clean Phoenix Pallet"),
    Elements = { {} },
})
--]]

-- F14AAA-75:  TALD vehicles are loaded on improved Triple Ejector Racks (BRU-42)

-- CNU-188/A External Baggage Container is a modified fuel tank, hangs on BRU-32 (F14AAA-75 Fig 3-10)

-- BOMBS
--[[
Mk_81       = 30;  -- Mk-81
Mk_82       = 31;  -- Mk-82
Mk_83       = 32;  -- Mk-83
Mk_84       = 33;  -- Mk-84
GBU_10      = 36;  -- GBU-10
GBU_11      = 37;  -- GBU-11
GBU_12      = 38;  -- GBU-12
GBU_16      = 39;  -- GBU-16

" The (BRU-42) TER provides
vertical separation from the fuselage at stations 3
and 6 for LAU-10/A rocket launchers and at stations
4 and 5 for SUU-44A flare dispensers"

           station 1  2  3  4  5  6  7  8
           ------------------------------
rockets LAU10/A:   2     2        1     2
mk-81 (lo&hi):     2     4  3  3  4     2
mk-82 (lo&hi):     2     4  3  3  4     2
mk-83 (lo):        1     3  1  1  3     1
mk-84 (lo):              1  1  1  1

MAK-79 clamps directly on the sides of the rails can be used instead of TER to mount
multiple bombs on each rail. 2 clamps can be connected to each side of the rail (4 total),
in one of two positions each (8 positions total)
--]]

declare_loadout(
{
    category = CAT_BOMBS,
    CLSID	=	"{BRU-32 MK-84}",
    Picture	=	"mk84.png",
    displayName	=	_("Mk-84"),
    Weight_Empty = 57.38,   -- 100lbs+26.5lbs
    Weight	= 57.38 + 894, -- see db_weapons_data.lua
    --wsTypeOfWeapon	=	{4,	5,	9,	33},
    wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, Mk_84},
    attribute      = {wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
    Count = 1,
    Cx_pil = 0.00002,
    Cx_item = 0.00056, -- see bombs_data.lua

    Elements	=
    {
        { ShapeName	= "HB_F14_EXT_BRU34" ,IsAdapter  =   true  },  -- combination ADU-703 & BRU-32
        {
            ShapeName	=	"MK-84",
            connector_name =  "WEP_BRU-34_MK84",
            --use_full_connector_position = true,
            DrawArgs	=
            {
                {19, 0.0}, -- fusing wire visible
                {56, 0.0}, -- fusing scheme
                {57, 1.0} -- gator skin
            }, -- end of DrawArgs
        },
    }, -- end of Elements
})

declare_loadout(
{
    category = CAT_BOMBS,
    CLSID	=	"{BRU-32 MK-83}",
    Picture	=	"mk83.png",
    displayName	=	_("Mk-83"),
    Weight_Empty = 57.38,   -- 100lbs+26.5lbs
    Weight	= 57.38 + 447,  -- see db_weapons_data.lua
    --wsTypeOfWeapon	=	{4,	5,	9,	32},
    wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, Mk_83},
    attribute      = {wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
    Count = 1,
    Cx_pil = 0.00002,
    Cx_item = 0.00035, -- see bombs_data.lua

    Elements	=
    {
        { ShapeName	= "HB_F14_EXT_BRU34" ,IsAdapter  =   true  },  -- combination ADU-703 & BRU-32
        {
            ShapeName	=	"MK-83",
            connector_name =  "WEP_BRU-34_MK84",
            --use_full_connector_position = true,
            DrawArgs	=
            {
                {19, 0.0}, -- fusing wire visible
                {56, 0.0}, -- fusing scheme
                {57, 0.12} -- gator skin
            }, -- end of DrawArgs
        },
    }, -- end of Elements
})

declare_loadout(
{
    category = CAT_BOMBS,
    CLSID	=	"{BRU-32 BDU-45B}",
    Picture	=	"mk82.png",
    displayName	=	_("BDU-45B"),
    Weight_Empty = 57.38,
    Weight	= 57.38 + 241,
    --wsTypeOfWeapon	=	{4,	5,	9,	31},
    --wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, BDU_45B},
    wsTypeOfWeapon	= "weapons.bombs.BDU_45B",
    attribute      = {wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
    Count = 1,
    Cx_pil = 0.00002,
    Cx_item = 0.00035, -- see bombs_data.lua

    Elements	=
    {
        { ShapeName	= "HB_F14_EXT_BRU34" ,IsAdapter  =   true  },  -- combination ADU-703 & BRU-32
        {
            ShapeName	=	"BDU_45B",
            connector_name =  "WEP_BRU-34_MK82",
            --use_full_connector_position = true,
            DrawArgs	=
            {
                {19, 0.0}, -- fusing wire visible
                {56, 0.0}, -- fusing scheme
                {57, 0.12} -- gator skin
            }, -- end of DrawArgs
        },
    }, -- end of Elements
})

declare_loadout(
{
    category = CAT_BOMBS,
    CLSID	=	"{BRU-32 BDU-45}",
    Picture	=	"mk82AIR.png",
    displayName	=	_("BDU-45"),
    Weight_Empty = 57.38,
    Weight	= 57.38 + 241,
    --wsTypeOfWeapon	=	{4,	5,	9,	31},
    --wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, BDU_45},
    wsTypeOfWeapon	= "weapons.bombs.BDU_45",
    attribute      = {wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
    Count = 1,
    Cx_pil = 0.00002,
    Cx_item = 0.00035, -- see bombs_data.lua

    Elements	=
    {
        { ShapeName	= "HB_F14_EXT_BRU34" ,IsAdapter  =   true  },  -- combination ADU-703 & BRU-32
        {
            ShapeName	=	"mk-82_snakeye_inert",
            connector_name =  "WEP_BRU-34_MK82",
            --use_full_connector_position = true,
            DrawArgs	=
            {
                {19, 0.0}, -- fusing wire visible
                {56, 0.0}, -- fusing scheme
                {57, 0.12} -- gator skin
            }, -- end of DrawArgs
        },
    }, -- end of Elements
})

declare_loadout(
{
    category = CAT_BOMBS,
    CLSID	=	"{BRU-32 MK-82}",
    Picture	=	"mk82.png",
    displayName	=	_("Mk-82"),
    Weight_Empty = 57.38,   -- 100lbs+26.5lbs
    Weight	= 57.38 + 241,  -- see db_weapons_data.lua
    --wsTypeOfWeapon	=	{4,	5,	9,	31},
    wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, Mk_82},
    attribute      = {wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
    Count = 1,
    Cx_pil = 0.00002,
    Cx_item = 0.00025, -- see bombs_data.lua

    Elements	=
    {
        { ShapeName	= "HB_F14_EXT_BRU34" ,IsAdapter  =   true  },  -- combination ADU-703 & BRU-32
        {
            ShapeName	=	"MK-82",
            connector_name =  "WEP_BRU-34_MK82",
            --use_full_connector_position = true,
            DrawArgs	=
            {
                {19, 0.0}, -- fusing wire visible
                {56, 0.0}, -- fusing scheme
                {57, 0.12} -- gator skin
            }, -- end of DrawArgs
        },
    }, -- end of Elements
})

declare_loadout(
{
    category = CAT_BOMBS,
    CLSID	=	"{BRU-32 MK-82AIR}",
    Picture	=	"mk82AIR.png",
    displayName	=	_("Mk-82AIR"),
    Weight_Empty = 57.38,   -- 100lbs+26.5lbs
    Weight	= 57.38 + 241,  -- see db_weapons_data.lua
    --wsTypeOfWeapon	=	{4,	5,	9,	75},
    wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, MK_82AIR},
    attribute      = {wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
    Count = 1,
    Cx_pil = 0.00002,
    Cx_item = 0.00025, -- see bombs_data.lua

    Elements	=
    {
        { ShapeName	= "HB_F14_EXT_BRU34" ,IsAdapter  =   true  },  -- combination ADU-703 & BRU-32
        {
            ShapeName	=	"Mk-82AIR",
            connector_name =  "WEP_BRU-34_MK82",
            --use_full_connector_position = true,
            DrawArgs	=
            {
                {19, 0.0}, -- fusing wire visible
                {56, 0.0}, -- fusing scheme
                {57, 0.12} -- gator skin
            }, -- end of DrawArgs
        },
    }, -- end of Elements
})

declare_loadout(
{
    category = CAT_BOMBS,
    CLSID	=	"{BRU-32 MK-82SE}",
    Picture	=	"mk82AIR.png",
    displayName	=	_("Mk-82 SnakeEye"),
    Weight_Empty = 57.38,   -- 100lbs+26.5lbs
    Weight	= 57.38 + 241,  -- see db_weapons_data.lua
    --wsTypeOfWeapon	=	{4,	5,	9,	75},
    wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, MK_82SNAKEYE},
    attribute      = {wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
    Count = 1,
    Cx_pil = 0.00002,
    Cx_item = 0.00025, -- see bombs_data.lua

    Elements	=
    {
        { ShapeName	= "HB_F14_EXT_BRU34" ,IsAdapter  =   true  },  -- combination ADU-703 & BRU-32
        {
            ShapeName	=	"MK-82_Snakeye",
            connector_name =  "WEP_BRU-34_MK82",
            --use_full_connector_position = true,
            DrawArgs	=
            {
                {19, 0.0}, -- fusing wire visible
                {56, 0.0}, -- fusing scheme
                {57, 0.12} -- gator skin
            }, -- end of DrawArgs
        },
    }, -- end of Elements
})

declare_loadout(
{
    category = CAT_BOMBS,
    CLSID	=	"{BRU-32 MK-20}",
    Picture	=	"Mk20.png",
    displayName	=	_("Mk-20"),
    Weight_Empty = 57.38,   -- 100lbs+26.5lbs
    Weight	= 57.38 + 222,  -- see db_weapons_data.lua
    --wsTypeOfWeapon	=	{4,	5,	9,	75},
    wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, ROCKEYE},
    attribute      = {wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
    Count = 1,
    Cx_pil = 0.00002,
    Cx_item = 0.000413, -- see bombs_data.lua

    Elements	=
    {
        { ShapeName	= "HB_F14_EXT_BRU34" ,IsAdapter  =   true  },  -- combination ADU-703 & BRU-32
        {
            ShapeName	=	"ROCKEYE",
            connector_name =  "WEP_BRU-34_MK82",
            --use_full_connector_position = true,
            DrawArgs	=
            {
                {19, 0.0}, -- fusing wire visible
                {56, 0.0}, -- fusing scheme
                {57, 0.12} -- gator skin
            }, -- end of DrawArgs
        },
    }, -- end of Elements
})

--{ CLSID = "{CBU_99}"},


declare_loadout(
{
    category = CAT_BOMBS,
    CLSID	=	"{BRU-32 GBU-10}",
    Picture	=	"GBU10.png",
    displayName	=	_("GBU-10"),
    Weight_Empty = 57.38,   -- 100lbs+26.5lbs
    Weight	= 57.38 + 940,  -- 940kg from wikipedia, db_weapons_data.lua says 1162 though
    wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, GBU_10},
    attribute      = {wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
    Count = 1,
    Cx_pil = 0.00002,
    Cx_item = 0.000793, -- see bombs_data.lua

    Elements	=
    {
        { ShapeName	= "HB_F14_EXT_BRU34" ,IsAdapter  =   true  },  -- combination ADU-703 & BRU-32
        {
            ShapeName	=	"GBU-10",
            connector_name =  "WEP_BRU-34_MK84",
            --use_full_connector_position = true,
        },
    }, -- end of Elements
})

declare_loadout(
{
    category = CAT_BOMBS,
    CLSID	=	"{BRU-32 GBU-12}",
    Picture	=	"GBU12.png",
    displayName	=	_("GBU-12"),
    Weight_Empty = 57.38,   -- 100lbs+26.5lbs
    Weight	= 57.38 + 275,  -- see db_weapons_data.lua
    wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, GBU_12},
    attribute      = {wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
    Count = 1,
    Cx_pil = 0.00002,
    Cx_item = 0.000569, -- see bombs_data.lua

    Elements	=
    {
        { ShapeName	= "HB_F14_EXT_BRU34" ,IsAdapter  =   true  },  -- combination ADU-703 & BRU-32
        {
            ShapeName	=	"GBU-12",
            connector_name =  "WEP_BRU-34_MK82",
            --use_full_connector_position = true,
        },
    }, -- end of Elements
})

declare_loadout(
{
    category = CAT_BOMBS,
    CLSID	=	"{BRU-32 GBU-16}",
    Picture	=	"GBU16.png",
    displayName	=	_("GBU-16"),
    Weight_Empty = 57.38,   -- 100lbs+26.5lbs
    Weight	= 57.38 + 564,  -- see db_weapons_data.lua
    wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, GBU_16},
    attribute      = {wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
    Count = 1,
    Cx_pil = 0.00002,
    Cx_item = 0.000640, -- see bombs_data.lua

    Elements	=
    {
        { ShapeName	= "HB_F14_EXT_BRU34" ,IsAdapter  =   true  },  -- combination ADU-703 & BRU-32
        {
            ShapeName	=	"GBU-16",
            connector_name =  "WEP_BRU-34_MK84",
            --use_full_connector_position = true,
        },
    }, -- end of Elements
})

declare_loadout(
{
    category = CAT_BOMBS,
    CLSID	=	"{BRU-32 GBU-24}",
    Picture	=	"GBU27.png", -- TODO: need GBU24.png ?
    displayName	=	_("GBU-24"),
    Weight_Empty = 57.38,   -- 100lbs+26.5lbs
    Weight	= 57.38 + 1050,  -- 1050kg from wikipedia, 900 from db_weapons_data.lua though
    wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, GBU_24},
    attribute      = {wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
    Count = 1,
    Cx_pil = 0.00002,
    Cx_item = 0.000793, -- see bombs_data.lua

    Elements	=
    {
        { ShapeName	= "HB_F14_EXT_BRU34" ,IsAdapter  =   true  },  -- combination ADU-703 & BRU-32
        {
            ShapeName	=	"GBU-24",
            connector_name =  "WEP_BRU-34_MK84",
            --use_full_connector_position = true,
        },
    }, -- end of Elements
})

local mk81_bomb = {
    category = CAT_BOMBS,
	level2 = wsType_Bomb,
    name = "Mk-81",
    payload_CLSID = "{90321C8E-7ED1-47D4-A160-E074D5ABD902}",
    mass = 118, -- db_weapons_data.lua
    wsType = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, Mk_81},
    Cx = 0.00018, -- bombs_data.lua
    ShapeName = "MK-81",
    picture = "FAB100.png" -- mk81.png?
}

local mk82_bomb = {
    category = CAT_BOMBS,
	level2 = wsType_Bomb,
    name = "Mk-82",
    payload_CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",
    mass = 241, -- db_weapons_data.lua
    wsType = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, Mk_82},
    Cx = 0.00025, -- bombs_data.lua
    ShapeName = "MK-82",
    picture = "mk82.png"
}

local mk83_bomb = {
    category = CAT_BOMBS,
	level2 = wsType_Bomb,
    name = "Mk-83",
    payload_CLSID = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}",
    mass = 447, -- db_weapons_data.lua
    wsType = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, Mk_83},
    Cx = 0.00035, -- bombs_data.lua
    ShapeName = "MK-83",
    picture = "mk83.png"
}

local bdu33_bomb = {
    category = CAT_BOMBS,
	level2 = wsType_Bomb,
    name = "BDU-33",
    payload_CLSID	=	"{BDU-33}",
    mass	=	11, -- db_weapons_data
    wsType	=	{wsType_Weapon,	wsType_Bomb,	wsType_Bomb_A,	BDU_33},
    Cx = 0.00025, -- bombs_data.lua
    ShapeName = "BDU-33",
    picture	=	"bdu-33.png"
}

local bdu45_bomb = {
    category = CAT_BOMBS,
	level2 = wsType_Bomb,
    name = "BDU-45",
    payload_CLSID	=	"{BDU_45}",
    mass	=	232, -- common_bombs.lua
    wsType	=	"weapons.bombs.BDU_45",
    --wsType	=	{wsType_Weapon,	wsType_Bomb,	wsType_Bomb_A,	BDU_45},
    Cx = 0.00035, -- common_bombs.lua
    ShapeName = "mk-82_snakeye_inert",
    picture	=	"mk82AIR.png"
}

local bdu45b_bomb = {
    category = CAT_BOMBS,
	level2 = wsType_Bomb,
    name = "BDU-45B",
    payload_CLSID	=	"{BDU_45B}",
    mass	=	232, -- common_bombs.lua
    wsType	=	"weapons.bombs.BDU_45B",
    --wsType	=	{wsType_Weapon,	wsType_Bomb,	wsType_Bomb_A,	BDU_45B},
    Cx = 0.00025, -- common_bombs.lua
    ShapeName = "BDU_45B",
    picture	=	"mk82.png"
}

local mk82air_bomb = {
    category = CAT_BOMBS,
	level2 = wsType_Bomb,
    name = "Mk-82AIR",
    payload_CLSID	=	"{Mk82AIR}",
    mass	=	241, -- bombs_data.lua  (db_weapons_data.lua has 232...)
    wsType	=	{wsType_Weapon,	wsType_Bomb,	wsType_Bomb_A,	MK_82AIR},
    Cx = 0.00025, -- bombs_data.lua
    ShapeName	=	"Mk-82AIR",
    picture	=	"mk82AIR.png"
}

local mk82se_bomb = {
    category = CAT_BOMBS,
	level2 = wsType_Bomb,
    name = "Mk-82 SnakeEye",
    payload_CLSID	=	"{Mk82SNAKEYE}",
    mass	=	241, -- bombs_data.lua  (db_weapons_data.lua has 232...)
    wsType	=	{wsType_Weapon,	wsType_Bomb,	wsType_Bomb_A,	MK_82SNAKEYE},
    Cx = 0.00025, -- bombs_data.lua
    ShapeName	=	"MK-82_Snakeye",
    picture	=	"mk82AIR.png"
}

local mk20_bomb = {
    category = CAT_BOMBS,
	level2 = wsType_Bomb,
    name = "MK-20",
    payload_CLSID	=	"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}",
    mass	=	222, -- bombs_data.lua
    wsType	=	{wsType_Weapon,	wsType_Bomb, wsType_Bomb_Cluster, ROCKEYE},
    Cx = 0.00002, -- bombs_data.lua
    ShapeName	=	"ROCKEYE",
    picture	=	"Mk20.png"
}


local adm_141a_tald =
{
	category		= CAT_MISSILES,
	level2 = wsType_Missile,
	name			= "ADM_141A",
    payload_CLSID = "{ADM_141A}",
	mass			= 180,
	wsType	= "weapons.missiles.ADM_141A",
	Cx			= 8.0/4096.0, --8 in tactical_decoys.lua
	picture			= "agm154.png"
}

phx_adapter_nested("{PHXBRU3242_2*MK81 RS}", bru_32_nested("{BRU3242_2*MK81 RS}", bru_42_3x_bomb("{BRU42_2*MK81 RS}", mk81_bomb, false, true, true) ) )
phx_adapter_nested("{PHXBRU3242_2*MK81 LS}", bru_32_nested("{BRU3242_2*MK81 LS}", bru_42_3x_bomb("{BRU42_2*MK81 LS}", mk81_bomb, true, false, true) ) )

phx_adapter_nested("{PHXBRU3242_2*MK82 RS}", bru_32_nested("{BRU3242_2*MK82 RS}", bru_42_3x_bomb("{BRU42_2*MK82 RS}", mk82_bomb, false, true, true) ) )
phx_adapter_nested("{PHXBRU3242_2*MK82 LS}", bru_32_nested("{BRU3242_2*MK82 LS}", bru_42_3x_bomb("{BRU42_2*MK82 LS}", mk82_bomb, true, false, true) ) )
phx_adapter_nested("{PHXBRU3242_2*BDU45 RS}", bru_32_nested("{BRU3242_2*BDU45 RS}", bru_42_3x_bomb("{BRU42_2*BDU45 RS}", bdu45_bomb, false, true, true) ) )
phx_adapter_nested("{PHXBRU3242_2*BDU45 LS}", bru_32_nested("{BRU3242_2*BDU45 LS}", bru_42_3x_bomb("{BRU42_2*BDU45 LS}", bdu45_bomb, true, false, true) ) )
phx_adapter_nested("{PHXBRU3242_2*BDU45B RS}", bru_32_nested("{BRU3242_2*BDU45B RS}", bru_42_3x_bomb("{BRU42_2*BDU45B RS}", bdu45b_bomb, false, true, true) ) )
phx_adapter_nested("{PHXBRU3242_2*BDU45B LS}", bru_32_nested("{BRU3242_2*BDU45B LS}", bru_42_3x_bomb("{BRU42_2*BDU45B LS}", bdu45b_bomb, true, false, true) ) )
phx_adapter_nested("{PHXBRU3242_2*MK82AIR RS}", bru_32_nested("{BRU3242_2*MK82AIR RS}", bru_42_3x_bomb("{BRU42_2*MK82AIR RS}", mk82air_bomb, false, true, true) ) )
phx_adapter_nested("{PHXBRU3242_2*MK82AIR LS}", bru_32_nested("{BRU3242_2*MK82AIR LS}", bru_42_3x_bomb("{BRU42_2*MK82AIR LS}", mk82air_bomb, true, false, true) ) )
phx_adapter_nested("{PHXBRU3242_2*MK82SE RS}", bru_32_nested("{BRU3242_2*MK82SE RS}", bru_42_3x_bomb("{BRU42_2*MK82SE RS}", mk82se_bomb, false, true, true) ) )
phx_adapter_nested("{PHXBRU3242_2*MK82SE LS}", bru_32_nested("{BRU3242_2*MK82SE LS}", bru_42_3x_bomb("{BRU42_2*MK82SE LS}", mk82se_bomb, true, false, true) ) )
phx_adapter_nested("{PHXBRU3242_2*MK20 RS}", bru_32_nested("{BRU3242_2*MK20 RS}", bru_42_3x_bomb("{BRU42_2*MK20 RS}", mk20_bomb, false, true, true) ) )
phx_adapter_nested("{PHXBRU3242_2*MK20 LS}", bru_32_nested("{BRU3242_2*MK20 LS}", bru_42_3x_bomb("{BRU42_2*MK20 LS}", mk20_bomb, true, false, true) ) )
--phx_adapter_nested("{PHXBRU3242_2*MK82 RS}", bru_32_nested("{BRU3242_2*MK82 RS}", bru_42_3x_weapon("{BRU42_2*MK82 RS}", mk82_bomb, false, true, true) ) )
--phx_adapter_nested("{PHXBRU3242_2*MK82 LS}", bru_32_nested("{BRU3242_2*MK82 LS}", bru_42_3x_weapon("{BRU42_2*MK82 LS}", mk82_bomb, true, false, true) ) )

phx_adapter_nested("{PHXBRU3242_MK83 RS}", bru_32_nested("{BRU3242_MK83 RS}", bru_42_3x_bomb("{BRU42_MK83 RS}", mk83_bomb, false, false, true) ) )
phx_adapter_nested("{PHXBRU3242_MK83 LS}", bru_32_nested("{BRU3242_MK83 LS}", bru_42_3x_bomb("{BRU42_MK83 LS}", mk83_bomb, false, false, true) ) )


bru_32_nested("{BRU3242_3*BDU33}", bru_42_3x_bomb("{BRU42_3*BDU33}", bdu33_bomb, true, true, true, {0.18, 0.01, 0.0}) )

phx_adapter_nested("{PHXBRU3242_BDU33}", bru_32_nested("{BRU3242_3*BDU33_N}", bru_42_3x_bomb("{BRU42_3*BDU33_N}", bdu33_bomb, true, true, true, {0.18, 0.01, 0.0}) ) )

mak79_4x_weapon("{MAK79_MK81 4}",mk81_bomb,3,true,true,true,true)
mak79_4x_weapon("{MAK79_MK81 3L}",mk81_bomb,4,true,true,true,false)
mak79_4x_weapon("{MAK79_MK81 3R}",mk81_bomb,4,true,true,false,true)
mak79_4x_weapon("{MAK79_MK82 4}",mk82_bomb,3,true,true,true,true)
mak79_4x_weapon("{MAK79_MK82 3L}",mk82_bomb,4,true,true,true,false)
mak79_4x_weapon("{MAK79_MK82 3R}",mk82_bomb,4,true,true,false,true)
mak79_4x_weapon("{MAK79_BDU45 4}",bdu45_bomb,3,true,true,true,true)
mak79_4x_weapon("{MAK79_BDU45 3L}",bdu45_bomb,4,true,true,true,false)
mak79_4x_weapon("{MAK79_BDU45 3R}",bdu45_bomb,4,true,true,false,true)
mak79_4x_weapon("{MAK79_BDU45B 4}",bdu45b_bomb,3,true,true,true,true)
mak79_4x_weapon("{MAK79_BDU45B 3L}",bdu45b_bomb,4,true,true,true,false)
mak79_4x_weapon("{MAK79_BDU45B 3R}",bdu45b_bomb,4,true,true,false,true)
mak79_4x_weapon("{MAK79_BDU33 4}",bdu33_bomb,2,true,true,true,true, { 0.19, -0.01, 0.0})
mak79_4x_weapon("{MAK79_BDU33 3L}",bdu33_bomb,2,true,true,true,false, { 0.19, -0.01, 0.0})
mak79_4x_weapon("{MAK79_BDU33 3R}",bdu33_bomb,2,true,true,false,true, { 0.19, -0.01, 0.0})
mak79_4x_weapon("{MAK79_MK82AIR 4}",mk82air_bomb,3,true,true,true,true)
mak79_4x_weapon("{MAK79_MK82AIR 3L}",mk82air_bomb,4,true,true,true,false)
mak79_4x_weapon("{MAK79_MK82AIR 3R}",mk82air_bomb,4,true,true,false,true)
mak79_4x_weapon("{MAK79_MK82SE 4}",mk82se_bomb,3,true,true,true,true)
mak79_4x_weapon("{MAK79_MK82SE 3L}",mk82se_bomb,4,true,true,true,false)
mak79_4x_weapon("{MAK79_MK82SE 3R}",mk82se_bomb,4,true,true,false,true)

mak79_4x_weapon("{MAK79_MK83 3L}",mk83_bomb,1,false,true,true,true)
mak79_4x_weapon("{MAK79_MK83 3R}",mk83_bomb,1,true,false,true,true)
mak79_4x_weapon("{MAK79_MK83 1R}",mk83_bomb,2,false,false,false,true)
mak79_4x_weapon("{MAK79_MK83 1L}",mk83_bomb,2,false,false,true,false)

mak79_4x_weapon("{MAK79_MK20 2L}",mk20_bomb,4,true,false,true,false)
mak79_4x_weapon("{MAK79_MK20 2R}",mk20_bomb,4,false,true,false,true)
mak79_4x_weapon("{MAK79_MK20 1R}",mk20_bomb,2,false,false,false,true)
mak79_4x_weapon("{MAK79_MK20 1L}",mk20_bomb,2,false,false,true,false)

bru_32_nested("{BRU3242_ADM141}", bru_42_3x_weapon("{BRU42_ADM141}", adm_141a_tald, false, false, true) )

-- ROCKETS

local lau10_zuni = {
    category = CAT_ROCKETS,
    name = "LAU-10 - 4 ZUNI MK 71",
    payload_CLSID = "{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}",
    mass = 440,
    --wsType = {4, 7, 33, 37},
    wsType = { wsType_Weapon, wsType_NURS, wsType_Rocket, Zuni_127 },
    Cx = 0.001708984375,
    picture = "LAU10.png"
}

bru_32_nested("{BRU3242_LAU10}", bru_42_3x_weapon("{BRU42_LAU10}", lau10_zuni, false, true, false) )
bru_32_nested("{BRU3242_2*LAU10 L}", bru_42_3x_weapon("{BRU42_2*LAU10 L}", lau10_zuni, true, false, true) )
bru_32_nested("{BRU3242_2*LAU10 R}", bru_42_3x_weapon("{BRU42_2*LAU10 R}", lau10_zuni, true, true, false) )

phx_adapter_nested("{PHXBRU3242_2*LAU10 RS}", bru_32_nested("{BRU3242_2*LAU10 RS}", bru_42_3x_weapon("{BRU42_2*LAU10 RS}", lau10_zuni, false, true, true) ) )
phx_adapter_nested("{PHXBRU3242_2*LAU10 LS}", bru_32_nested("{BRU3242_2*LAU10 LS}", bru_42_3x_weapon("{BRU42_2*LAU10 LS}", lau10_zuni, true, false, true) ) )

-- TODO: SUU-44 instead of SUU-25?  (seems only older F-14 docs refer to SUU-44 though, newer ones refer to SUU-25)
-- Differences: SUU-25 can launch 8 LUU-2B/B individually, SUU-44 always launches an entire tube at a time (2 LUU-2B/B at a time)
--              SUU-25 looks a bit different (more aerodynamic nosecone for instance)
-- http://www.tpub.com/aviord321/105.htm
local suu25_flare = {
    category = CAT_BOMBS,
    name = "SUU-25 * 8 LUU-2",
    payload_CLSID = "{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}",
    mass = 130,
    wsType = { wsType_Weapon, wsType_Bomb, wsType_Bomb_Lighter, LUU_2B },
    Cx = 0.001,
    picture = "L005.png"
}

bru_32_nested("{BRU3242_SUU25}", bru_42_3x_weapon("{BRU42_SUU25}", suu25_flare, false, true, false, {0.05, 0.00, 0.0}) )
bru_32_nested("{BRU3242_2*SUU25 L}", bru_42_3x_weapon("{BRU42_2*SUU25 L}", suu25_flare, true, false, true, {0.05, 0.00, 0.0}) )
bru_32_nested("{BRU3242_2*SUU25 R}", bru_42_3x_weapon("{BRU42_2*SUU25 R}", suu25_flare, true, true, false, {0.05, 0.00, 0.0}) )

local luu2_flare = {
    category = CAT_BOMBS,
    name = "LUU-2",
    mass = 13.6, -- db_weapons_data.lua
    wsType = { wsType_Weapon, wsType_Bomb, wsType_Bomb_Lighter, LUU_2B },
    Cx = 0.0001, -- bombs_data.lua
    ShapeName = "luu-2",
    picture = "mk82.png" ---XXX replace with icon of luu-2
}

-- XXX these appear mounted on aircraft already shining (firefly!), so don't use for now
bru_32_nested("{BRU3242_2*LUU2 R}", bru_42_3x_bomb("{BRU42_2*LUU2 R}", luu2_flare, true, false, true) )
bru_32_nested("{BRU3242_2*LUU2 L}", bru_42_3x_bomb("{BRU42_2*LUU2 L}", luu2_flare, false, true, true) )
