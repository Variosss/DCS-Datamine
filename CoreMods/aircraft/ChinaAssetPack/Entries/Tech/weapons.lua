dofile('Scripts/Database/Weapons/warheads.lua')

---- weapon def ----
BarrelsReloadTypes = {
    ['ORDINARY']       = 1,
    ['SIMULTANEOUSLY'] = 2,
    ['SEQUENTIALY']    = 3
}

tail_solid  = { 1, 1, 1, 1 };
tail_liquid = { 0.9, 0.9, 0.9, 0.05 };

local ANTISHIP_MISSILE_TYPE = 11 -- 11: surface to surface; 8: air to surface

-- SAM
local name_9m317 = '9M317'
SA_N_12_9M317 = {
    category        = CAT_MISSILES,
    name            = name_9m317,
    user_name       = _(name_9m317),
    model           = '9m317',
    mass            = 715.0,
    wsTypeOfWeapon  = {4,4,34,WSTYPE_PLACEHOLDER},

    Escort       = 3,
    Head_Type    = 6,
    sigma        = {25, 25, 25},
    M            = 715.0,
    H_max        = 25000.0,
    H_min        = 15.0,
    Diam         = 400.0,
    Cx_pil       = 2,
    D_max        = 30000.0,  -- по нижней границе
    D_min        = 3000.0,
    Head_Form    = 1,
    Life_Time    = 120.0,
    Nr_max       = 24,
    v_min        = 300.0,
    v_mid        = 900.0,
    Mach_max     = 3.6,
    t_b          = 0.0,
    t_acc        = 18.0, -- Same acc time as Kub
    t_marsh      = 0.0,
    Range_max    = 42000.0, -- по верхней границе
    H_min_t      = 5.0,
    Engine_Type  = 1,
    Engine_Type_ = 1,
    Fi_start     = 3.14152,
    Fi_rak       = 3.14152,
    Fi_excort    = 1.05,
    Fi_search    = 99.9,
    OmViz_max    = 99.9,
    exhaust      = { 1, 1, 1, 1 },
    X_back       = -2.15,
    Y_back       = -0.18,
    Z_back       = 0.0,
    Reflection   = 0.0918,
    KillDistance = 13.0,
    ccm_k0       = 0.5,
    PN_coeffs = {
        3,                 -- Number of Entries
        5000.0 ,1.0,       -- Less 5 km to target Pn = 1
        10000.0, 0.5,      -- Between 10 and 5 km  to target, Pn smoothly changes from 0.5 to 1.0.
        15000.0, 0.2
    }; -- Between 15 and 10 km  to target, Pn smoothly changes from 0.2 to 0.5. Longer then 30 km Pn = 0.2.

    warhead = simple_aa_warhead(59.0),

    shape_table_data = {
        {
            name     = name_9m317,
            file     = '9m317',
            life     = 1,
            fire     = {0, 1},
            username = name_9m317,
            index    = WSTYPE_PLACEHOLDER,
        },
    },
}

declare_weapon(SA_N_12_9M317)
--SA_N_12_9M317.shape_table_data.index = SA_N_12_9M317.wsTypeOfWeapon[4]

--[[
declare_loadout({
    category        = CAT_MISSILES,
    CLSID           = '{9M317}',
    attribute       = SA_N_12_9M317.wsTypeOfWeapon,
    displayName     = _('9M317'),
    Elements        = {
    }, -- end of Elements
})
]]

local name_hq16 = 'HQ-16'
HQ_16 = {
    category        = CAT_MISSILES,
    name            = name_hq16,
    user_name       = _(name_hq16),
    model           = 'hq16',
    mass            = 650.0,
    wsTypeOfWeapon  = {4,4,34,WSTYPE_PLACEHOLDER},

    Escort       = 3,
    Head_Type    = 6,
    sigma        = {25, 25, 25}, --aiming error on target
    M            = 650.0, --missile mass in KG
    H_max        = 18000.0, --maximum flight altitude
    H_min        = 5.0,  --minimum flight altitude
    Diam         = 340.0, --diameter
    Cx_pil       = 2,
    D_max        = 42000.0,  -- maximum launch range at 0 height
    D_min        = 3000.0, --minimum launch range
    Head_Form    = 1,
    Life_Time    = 120.0,
    Nr_max       = 22,
    v_min        = 160.0, --minimum speed
    v_mid        = 1000.0, --average speed
    Mach_max     = 3.5,
    t_b          = 0.0, --engine start delay time
    t_acc        = 15.0, --engine operating time
    t_marsh      = 0.0, --time in flight
    Range_max    = 45000.0, -- maximum launch range at maximum height (HHQ16: 45km)
    H_min_t      = 5.0, --minimum target height
    Engine_Type  = 1,
    Engine_Type_ = 1,
    Fi_start     = 3.14152, -- angle of tracking at firing
    Fi_rak       = 3.14152,
    Fi_excort    = 2.0,
    Fi_search    = 99.9, --search angle limit
    OmViz_max    = 99.9, --search line speed limit
    exhaust      = { 1, 1, 1, 1 },
    X_back       = -2.55,
    Y_back       = 0.0,
    Z_back       = 0.0,
    Reflection   = 0.0918, --effective surface of radio reflection, square meters (like Buk M1)
    KillDistance = 15.0,
    ccm_k0       = 0.3,
    PN_coeffs = {
        3,                 -- Number of Entries
        5000.0 ,1.0,        -- Less 5 km to target Pn = 1
        10000.0, 0.5,        -- Between 10 and 5 km  to target, Pn smoothly changes from 0.5 to 1.0.
        15000.0, 0.2
    }; -- Between 15 and 10 km  to target, Pn smoothly changes from 0.2 to 0.5. Longer then 30 km Pn = 0.2.

    warhead = simple_aa_warhead(59.0),

    shape_table_data = {
        {
            name     = name_hq16,
            file     = 'hq16',
            life     = 1,
            fire     = {0, 1},
            username = name_hq16,
            index    = WSTYPE_PLACEHOLDER,
        },
    },
}

declare_weapon(HQ_16)
--HQ_16.shape_table_data.index = HQ_16.wsTypeOfWeapon[4]

--[[
declare_loadout({
    category        = CAT_MISSILES,
    CLSID           = '{HQ16}',
    attribute       = HQ_16.wsTypeOfWeapon,
    displayName     = _('HQ-16'),
    Elements        = {
    }, -- end of Elements
})
]]

local name_hhq9 = 'HHQ-9'
HHQ_9 = {
    category        = CAT_MISSILES,
    name            = name_hhq9,
    user_name       = _(name_hhq9),
    model           = 'hhq9a',
    mass            = 1300.0,
    wsTypeOfWeapon  = {4,4,34,WSTYPE_PLACEHOLDER},

    Escort       = 3,
    Head_Type    = 6,
    sigma        = {25, 25, 25}, --aiming error on target
    M            = 1300.0, --missile mass in KG
    H_max        = 27000.0, --maximum flight altitude
    H_min        = 14.0,  --minimum flight altituder
    Diam         = 470.0, --diameter
    Cx_pil       = 2.8,
    D_max        = 60000.0,  -- maximum launch range at 0 height
    D_min        = 5000.0, --minimum launch range
    Head_Form    = 1,
    Life_Time    = 180.0,
    Nr_max       = 25,
    v_min        = 180.0, --minimum speed
    v_mid        = 1500.0, --average speed
    Mach_max     = 4.2,
    t_b          = 0.0, --engine start delay time
    t_acc        = 30.0, --engine operating time
    t_marsh      = 0.0, --time in flight
    Range_max    = 100000.0, -- maximum launch range at maximum height (HHQ9: 100km range)
    H_min_t      = 25.0, --minimum target height
    Engine_Type  = 1,
    Engine_Type_ = 1,
    Fi_start     = 3.14152, -- angle of tracking at firing
    Fi_rak       = 3.14152,
    Fi_excort    = 2,
    Fi_search    = 99.9, --search angle limit
    OmViz_max    = 99.9, --search line speed limit
    exhaust      = { 1, 1, 1, 1 },
    X_back       = -3.4,
    Y_back       = 0.0,
    Z_back       = 0.0,
    Reflection   = 0.178, --effective surface of radio reflection, square meters (like 5V55)
    KillDistance = 20.0,
    ccm_k0       = 0.3,
    PN_coeffs = {
        3,                 -- Number of Entries
        5000.0 ,1.0,        -- Less 5 km to target Pn = 1
        10000.0, 0.5,        -- Between 10 and 5 km  to target, Pn smoothly changes from 0.5 to 1.0.
        20000.0, 0.2
    }; -- Between 20 and 10 km  to target, Pn smoothly changes from 0.2 to 0.5. Longer then 30 km Pn = 0.2.

    warhead = simple_aa_warhead(150),

    shape_table_data = {
        {
            name     = name_hhq9,
            file     = 'hhq9a',
            life     = 1,
            fire     = {0, 1},
            username = name_hhq9,
            index    = WSTYPE_PLACEHOLDER,
        },
    },
}

declare_weapon(HHQ_9)
--HHQ_9.shape_table_data.index = HHQ_9.wsTypeOfWeapon[4]

--[[
declare_loadout({
    category        = CAT_MISSILES,
    CLSID           = '{HHQ9}',
    attribute       = HHQ_9.wsTypeOfWeapon,
    displayName     = _('HHQ-9'),
    Elements        = {
    }, -- end of Elements
})
]]

local YJ83_warhead =
{
    mass                 = 165,
    caliber              = 360,
    expl_mass            = 165,
    piercing_mass        = 0.0,
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 3.0, 1.0, 1.0 },
    concrete_obj_factor  = 2.0,
    obj_factors          = { 3.0, 1.0 },
    cumulative_factor    = 2.0,
    cumulative_thickness = 0.0,
}

-- Anti-Ship Missiles
local name_yj83 = 'YJ-83'
YJ_83_AS = {
    category        = CAT_MISSILES,
    name            = name_yj83,
    user_name       = _(name_yj83),
    model           = 'yj83',
    mass            = 850,
    wsTypeOfWeapon  = {4,4,ANTISHIP_MISSILE_TYPE,WSTYPE_PLACEHOLDER},

    Escort       = 0,
    Head_Type    = 5,
    sigma        = {30, 30, 20},
    M            = 850,
    H_max        = 10000.0,
    H_min        = -1,
    Diam         = 343.0,
    Cx_pil       = 1,
    D_max        = 180000.0,
    D_min        = 12000.0,
    Head_Form    = 1,
    Life_Time    = 1850.0,
    Nr_max       = 6,
    v_min        = 100.0,
    v_mid        = 150.0,
    Mach_max     = 1.5,
    t_b          = 0.0,
    t_acc        = 5,
    t_marsh      = 1800.0,
    Range_max    = 180000.0,
    H_min_t      = 0.0,
    Fi_start     = 0.25,
    Fi_rak       = 3.14152,
    Fi_excort    = 0.35,
    Fi_search    = 99.9,
    OmViz_max    = 99.9,
    Stage_       = 2,
    Engine_Type_ = 6,
    Stage        = 2,
    Engine_Type  = 6,
    exhaust1     = tail_solid,
    X_back       = -2.566,
    Y_back       = 0.0,
    Z_back       = 0.0,
    X_back_acc   = -3.9,
    Y_back_acc   = 0.0,
    Z_back_acc   = 0.0,
    Reflection   = 0.121,
    KillDistance = 0.0,

    warhead     = YJ83_warhead, --antiship_penetrating_warhead(250.0, 343),
    warhead_air = YJ83_warhead, --antiship_penetrating_warhead(250.0, 343),

    add_attributes = {"Anti-Ship missiles"},

    shape_table_data = {
        {
            name     = name_yj83,
            file     = 'yj83',
            life     = 1.5,
            fire     = {0, 1},
            username = name_yj83,
            index    = WSTYPE_PLACEHOLDER,
        },
    },

    encyclopediaAnimation = {
        args = {
            [1] = 1.00,
        },
    },

    class_name      = "wAmmunitionSelfHoming",
    scheme          = "anti_ship_missile_tb",

    fm = {
        mass            = 715,
        caliber         = 0.36,
        cx_coeff        = {1, 0.3, 0.65, 0.018, 1.6},
        L               = 5.145,
        I               = 1 / 12 * 715.0 * 5.145 * 5.145,
        Ma              = 0.6,
        Mw              = 1.116,
        wind_sigma      = 0.0,
        wind_time       = 1000.0,
        Sw              = 0.75,
        dCydA           = {0.07, 0.036},
        A               = 0.08,
        maxAoa          = 0.3,
        finsTau         = 0.05,
        Ma_x            = 3,
        Ma_z            = 3,
        Kw_x            = 0.05,
    },

    simple_seeker = {
        delay        = 1.0,
        FOV          = math.rad(45),
        stTime       = 0.5,
        opTime       = 9999,
    },

    autopilot =    --inertial autopilot + horiz correction when seeker is on
    {
        delay                      = 1,        -- time delay
        Kpv                        = 0.02,    -- vertical control PID
        Kdv                        = 2,
        Kiv                        = 0.00006,
        Kph                        = 500.0,        -- horiz control PID
        Kdh                        = 5.0,
        Kih                        = 0.0,
        glide_height               = 20.0,        -- cruise glide height
        use_current_height         = 0,        -- keep launch height
        max_vert_speed             = 60.0,        -- max vertical speed kept from launch height to glide height
        altim_vel_k                = 1.0,        -- proximity sensor correction by velocity coeff
        finsLimit                  = 0.68,        -- max signal value from autopilot to fins
        inertial_km_error          = 0.05,        -- inertial guidance error coeff to 1 km flight distance
    },

    final_autopilot =        -- final stage guidance with terminal maneuver
    {
        delay                    = 0,
        K                        = 60,        -- autopilot P
        Ki                       = 0,        -- I
        Kg                       = 6,        -- D
        finsLimit                = 0.9,
        useJumpByDefault         = 1,        --
        J_Power_K                = 2.0,        -- terminal maneuver params: P
        J_Diff_K                 = 0.8,        -- D
        J_Int_K                  = 0,        -- I
        J_Angle_K                = 0.7,        -- jump maneuver angle
        J_FinAngle_K             = 0.52,        -- jump inactivation trigger angle to target
        J_Angle_W                = 3.0,        -- max maneuver angle speed
        bang_bang                = 0,        -- use only -1, 1 values to control fins
        J_Trigger_Vert           = 1,        -- use global y axis
    },

    h_glide_on = {            -- turn on seeker and start horiz. correction if target is locked on
        delay                   = 1,
        trigger_dist            = 10000,
    },

    mode_switcher = {        -- use final maneuver if target is locked on
        delay           = 1,
        trigger_dist    = 4000,
    },

    self_destruct =         -- if seeker still can not find a target explode warhead
    {
        delay = 1,
        trigger_dist            = 1000,
        inactivation_dist       = 900,
    },

    controller = {
        boost_start = 0.001,
        march_start = 0.01,
    },

    boost = {
        impulse                             = 170,
        fuel_mass                           = 125,
        work_time                           = 4,
        boost_time                          = 0,
        boost_factor                        = 0,
        nozzle_position                     = {{-3.9, 0, 0}},
        nozzle_orientationXYZ               = {{-1, 0, 0}},
        tail_width                          = 0.1,
        smoke_color                         = {1, 1, 1},
        smoke_transparency                  = 0.8,
        custom_smoke_dissipation_factor     = 0.5,
    },

    booster_animation = {
        start_val = 1, -- start arg.1 value ( default value without animation)
    },

    play_booster_animation = {
        val = 1, -- 1/0
    },

    march = {
        impulse          = 660,
        fuel_mass        = 80,
        work_time        = 9999,
        min_fuel_rate    = 0.005,
        min_thrust       = 0,
        max_thrust       = 5000,
        thrust_Tau       = 0.0017,
    },

    engine_control = {
        default_speed   = 300,
        K               = 300,
        Kd              = 0.01,
        Ki              = 0.001,
        burst_signal    = 9999, -- used in 'anti_ship_missile_tb' scheme
    },
}

declare_weapon(YJ_83_AS)
--YJ_83_AS.shape_table_data.index = YJ_83_AS.wsTypeOfWeapon[4]

--[[
declare_loadout({
    category        = CAT_MISSILES,
    CLSID           = '{YJ-83}',
    attribute       = YJ_83_AS.wsTypeOfWeapon,
    displayName     = _('YJ-83'),
    Elements        = {
    }, -- end of Elements
})
]]

local yj84_name = 'YJ-84'

YJ_84_AS = {}
copyTable(YJ_84_AS, YJ_83_AS)
YJ_84_AS.name           = yj84_name
YJ_84_AS.user_name      = _(yj84_name)
YJ_84_AS.wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER}
YJ_84_AS.shape_table_data[1].name     = yj84_name
YJ_84_AS.shape_table_data[1].username = yj84_name
YJ_84_AS.shape_table_data[1].index    = WSTYPE_PLACEHOLDER
declare_weapon(YJ_84_AS)


local YJ62_warhead =
{
    mass                 = 350,
    caliber              = 540,
    expl_mass            = 350,
    piercing_mass        = 0.0,
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 3.0, 1.0, 1.0 },
    concrete_obj_factor  = 2.0,
    obj_factors          = { 3.0, 1.0 },
    cumulative_factor    = 2.0,
    cumulative_thickness = 0.0,
}

local name_yj62 = 'YJ-62'
YJ_62_AS = {
    category        = CAT_MISSILES,
    name            = name_yj62,
    user_name       = _(name_yj62),
    model           = 'yj62',
    mass            = 1240,
    wsTypeOfWeapon  = {4,4,ANTISHIP_MISSILE_TYPE,WSTYPE_PLACEHOLDER},

    Escort        = 0,
    Head_Type     = 5,
    sigma         = {30, 30, 20},
    M             = 1240,
    H_max         = 10000.0,
    H_min         = -1,
    Diam          = 540.0,
    Cx_pil        = 1,
    D_max         = 300000.0,
    D_min         = 2000.0,
    Head_Form     = 1,
    Life_Time     = 1850.0,
    Nr_max        = 12,
    v_min         = 100.0,
    v_mid         = 150.0,
    Mach_max      = 0.8,
    t_b           = 0.0,
    t_acc         = 3,
    t_marsh       = 1500.0,
    Range_max     = 300000.0,
    H_min_t       = 0.0,
    Fi_start      = 0.25,
    Fi_rak        = 3.14152,
    Fi_excort     = 0.35,
    Fi_search     = 99.9,
    OmViz_max     = 99.9,
    exhaust1      = tail_solid,
    X_back        = -2.236,
    Y_back        = 0.0,
    Z_back        = 0.0,
    X_back_acc    = -3.925,
    Y_back_acc    = 0.06,
    Z_back_acc    = 0.0,
    Reflection    = 0.121,
    KillDistance  = 0.0,

    warhead     = YJ62_warhead, --antiship_penetrating_warhead(480.0, 343),
    warhead_air = YJ62_warhead, --antiship_penetrating_warhead(480.0, 343),

    add_attributes = {"Cruise missiles", --[["Anti-Ship missiles"]]},

    shape_table_data = {
        {
            name     = name_yj62,
            file     = 'yj62',
            life     = 1.8,
            fire     = {0, 1},
            username = name_yj62,
            index    = WSTYPE_PLACEHOLDER,
        },
    },

    encyclopediaAnimation = {
        args = {
            [1] = 1.00,
        },
    },

    class_name      = "wAmmunitionSelfHoming",
    scheme          = "anti_ship_missile_tb",

    fm = {
        mass            = 1240,
        caliber         = 0.54,
        cx_coeff        = {1,0.3,0.65,0.018,1.6},
        L               = 6.1,
        I               = 1 / 12 * 1240.0 * 6.1 * 6.1,
        Ma              = 2,
        Mw              = 4,
        wind_sigma      = 0.0,
        wind_time       = 1000.0,
        Sw              = 1.2,
        dCydA           = {0.07, 0.036},
        A               = 0.08,
        maxAoa          = 0.3,
        finsTau         = 0.2,
        Ma_x            = 2,
        Ma_z            = 2,
        Kw_x            = 0.07,
    },

    simple_seeker = {
        delay             = 1.0,
        FOV               = math.rad(45),
        stTime            = 0.5,
        opTime            = 9999,
    },

    autopilot =    --inertial autopilot + horiz correction when seeker is on
    {
        delay                      = 1,        -- time delay
        Kpv                        = 0.02,    -- vertical control PID
        Kdv                        = 2,
        Kiv                        = 0.00006,
        Kph                        = 500,        -- horiz control PID
        Kdh                        = 5.0,
        Kih                        = 0.0,
        glide_height               = 15.0,        -- cruise glide height
        use_current_height         = 0,        -- keep launch height
        max_vert_speed             = 100.0,        -- max vertical speed kept from launch height to glide height
        altim_vel_k                = 1.0,        -- proximity sensor correction by velocity coeff
        finsLimit                  = 0.68,        -- max signal value from autopilot to fins
        inertial_km_error          = 0.05,        -- inertial guidance error coeff to 1 km flight distance
    },

    final_autopilot =        -- final stage guidance with terminal maneuver
    {
        delay                    = 0,
        K                        = 60,        -- autopilot P
        Ki                       = 0,        -- I
        Kg                       = 5,        -- D
        finsLimit                = 0.9,
        useJumpByDefault         = 0,        --
        J_Power_K                = 2.0,        -- terminal maneuver params: P
        J_Diff_K                 = 0.8,        -- D
        J_Int_K                  = 0,        -- I
        J_Angle_K                = 0.5,        -- jump maneuver angle
        J_FinAngle_K             = 0.3,        -- jump inactivation trigger angle to target
        J_Angle_W                = 2.0,        -- max maneuver angle speed
        bang_bang                = 0,        -- use only -1, 1 values to control fins
        J_Trigger_Vert           = 1,        -- use global y axis
    },

    h_glide_on = {            -- turn on seeker and start horiz. correction if target is locked on
        delay                   = 1,
        trigger_dist            = 15000,
    },

    mode_switcher = {        -- use final maneuver if target is locked on
        delay                   = 1,
        trigger_dist            = 500,
    },

    self_destruct =         -- if seeker still can not find a target explode warhead
    {
        delay = 1,
        trigger_dist            = 1000,
        inactivation_dist       = 900,
    },

    controller = {
        boost_start             = 0.001,
        march_start             = 0.01,
        suppres_march           = 0.01,    --指令到动作的延时
    },

    boost = {    --    air launch - no booster
        impulse                         = 170,        -- F = Isp*mass/time*G
        fuel_mass                       = 220,
        work_time                       = 4,
        boost_time                      = 0,
        boost_factor                    = 0,
        nozzle_position                 = {{-3.925, 0.06, 0}},
        nozzle_orientationXYZ           = {{-1, 0, 0}},
        tail_width                      = 0.5,
        smoke_color                     = {1, 1, 1},
        smoke_transparency              = 0.8,
        custom_smoke_dissipation_factor = 0.5,
    },

    booster_animation = {
        start_val = 1, -- start arg.1 value ( default value without animation)
    },

    play_booster_animation = {
        val = 1, -- 1/0
    },

    march = {
        impulse               = 660,
        fuel_mass             = 180,
        work_time             = 9999,
        min_fuel_rate         = 0.005,
        min_thrust            = 0,
        max_thrust            = 6500,
        thrust_Tau            = 0.0017,
    },

    engine_control = {
        default_speed        = 235,
        K                    = 235,
        Kd                   = 0.01,
        Ki                   = 0.001,
        burst_signal         = 9999, -- used in 'anti_ship_missile_tb' scheme
    },
}

declare_weapon(YJ_62_AS)
--YJ_62_AS.shape_table_data.index = YJ_62_AS.wsTypeOfWeapon[4]

--[[
declare_loadout({
    category        = CAT_MISSILES,
    CLSID           = '{YJ-62}',
    attribute       = YJ_62_AS.wsTypeOfWeapon,
    displayName     = _('YJ-62'),
    Elements        = {
    }, -- end of Elements
})
]]



local name_hq7 = 'HQ-7'
HQ_7 = {
    category        = CAT_MISSILES,
    name            = name_hq7,
    user_name       = _(name_hq7),
    model           = 'hq7ml',
    wsTypeOfWeapon  = {4,4,wsType_SS_Missile,WSTYPE_PLACEHOLDER},

    Escort        = 3,
    Head_Type     = 8,
    sigma         = {5, 5, 5},
    M             = 84.5,
    H_max         = 5500.0,
    H_min         = 14.5,
    Diam          = 156.0,
    Cx_pil        = 2,
    D_max         = 12000.0,
    D_min         = 500.0,
    Head_Form     = 1,
    Life_Time     = 40.0,
    Nr_max        = 18,
    v_min         = 170.0,
    v_mid         = 430.0,
    Mach_max      = 2.5,
    t_b           = 0.0,
    t_acc         = 8.0,
    t_marsh       = 2.0,
    Range_max     = 12000.0,
    H_min_t       = 30.0, -- cause ASM fly on 14.9992 m above the sea level. NOT ON 15
    Fi_start      = 3.14152,
    Fi_rak        = 3.14152,
    Fi_excort     = 3.14152,
    Fi_search     = 99.9,
    OmViz_max     = 99.9,
    warhead       = simple_aa_warhead(15.0),
    exhaust       = {0.7, 0.7, 0.7, 0.40},
    tail_scale    = 0.6,
    X_back        = -1.85,
    Y_back        = 0.0,
    Z_back        = 0.0,
    Reflection    = 0.010,
    KillDistance  = 7.0,
    ccm_k0        = 0.3,
    effect_max_length = 10000,
    --[[
    ModelData = {
        58 ,  -- model params count
        0.06 ,   -- characteristic square (характеристическая площадь)

        -- параметры зависимости Сx
        0.1 , -- Cx_k0 планка Сx0 на дозвуке ( M << 1)
        0.1 , -- Cx_k1 высота пика волнового кризиса
        0.02 , -- Cx_k2 крутизна фронта на подходе к волновому кризису
        0.06, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1)
        1.2 , -- Cx_k4 крутизна спада за волновым кризисом
        1.2 , -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))

        -- параметры зависимости Cy
        0.8 , -- Cy_k0 планка Сy0 на дозвуке ( M << 1)
        0.8     , -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)
        1.2  , -- Cy_k2 крутизна спада(фронта) за волновым кризисом

        0.4 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
        0.0, --угловая скорость создаваймая моментом газовых рулей

    -- Engine data. Time, fuel flow, thrust.
    --    t_statr        t_b        t_accel        t_march        t_inertial        t_break        t_end            -- Stage
        -1.0,        -1.0,    2.6,          0.0,        0.0,            0.0,        1.0e9,         -- time of stage, sec
         0.0,        0.0,    9.03,        0.0,        0.0,            0.0,        0.0,           -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
         0.0,        0.0,    11700.0,    0.0,    0.0,            0.0,        0.0,           -- thrust, newtons

         30.0, -- таймер самоликвидации, сек
         60.0, -- время работы энергосистемы, сек
         0, -- абсолютная высота самоликвидации, м
         0.5, -- время задержки включения управления (маневр отлета, безопасности), сек
         1.0e9, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр "горка", м
         1.0e9, -- дальность до цели, при которой маневр "горка" завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м
         0.0,  -- синус угла возвышения траектории набора горки
         30.0, -- продольное ускорения взведения взрывателя
         30.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
         1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
         1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
         3.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
         0.0,
         0.0,
         0.0,
         0.0,
         0.0,

         0.0,
         0.0,
         0.0,
         0.0,
         0.0,
         0.0,
        0.0,
        0.0,
    },
    ]]

    shape_table_data = {
        {
            name     = name_hq7,
            file     = 'hq7ml',
            life     = 1,
            fire     = {0, 1},
            username = name_hq7,
            index    = WSTYPE_PLACEHOLDER,
        },
    },
}

declare_weapon(HQ_7)



-- Torpedo

local yu6_name = 'YU-6'
local yu6_mass = 1558.0
local yu6_warhead =
{
    mass                 = 260,
    caliber              = 533,
    expl_mass            = 260,
    piercing_mass        = 100,
    fantom               = 1.0,
    other_factors        = { 4.0, 4.0, 4.0 },
    concrete_factors     = { 8.0, 8.0, 20.0 },
    concrete_obj_factor  = 8.0,
    obj_factors          = { 8.0, 8.0 },
    cumulative_factor    = 4.0,
    cumulative_thickness = 0.5,
    time_self_destruct   = 1200,
}

YU_6 = {}

local yu6_guided = false

if yu6_guided then

    YU_6 = {
        category        = CAT_TORPEDOES,
        name            = yu6_name,
        user_name       = _(yu6_name),
        scheme          = "guided_torpedo",
        class_name      = "wAmmunition",
        model           = "yu6",
        mass            = yu6_mass,

        wsTypeOfWeapon  = {wsType_Weapon,wsType_Torpedo,wsType_A_Torpedo,WSTYPE_PLACEHOLDER},

        Head_Type    = 0,
        Diam         = 533.0,
        D_max        = 40000.0,
        D_min        = 200.0,
        V_min        = -1.0,
        V_max        = 320.0,
        H_max        = 3.0,
        H_min        = -100.0,
        Life_Time    = 1800.0,
        Nr_max       = 4.0,
        v_mid        = 40.0,

        shape_table_data =
        {
            {
                name        = yu6_name,
                file        = 'yu6',
                life        = 1,
                fire        = {0, 1},
                username    = _(yu6_name),
                index       = WSTYPE_PLACEHOLDER,
            },
        },

        fm = {
            mass            = yu6_mass,
            caliber         = 0.533,
            cx_coeff        = {1,0.39,0.38,0.236,1.31},
            L               = 7.186,
            I               = 1 / 12 * yu6_mass * 7.186 * 7.186,
            Ma              = 0.2,
            Mw              = 0.4,
            wind_sigma      = 0.0,
            wind_time       = 0.0,
            Sw              = 0.5,
            dCydA           = {0.07, 0.036},
            A               = 0.5,
            maxAoa          = 0.3,
            finsTau         = 0.02,
            Ma_x            = 0.1,
            Kw_x            = 0.0005,
            calcAirFins     = 0,
            fins_val_div    = 10000,
            rho_w           = 515,
            int_rho_y       = 1.8,
            Sww             = 0.5,
            splash_time     = 0.5,
            splash_dt       = 0.004,
        },

        autopilot =
        {
            delay                   = 2.0,
            Kpv                     = 0.03,
            Kdv                     = 0.0,
            Kiv                     = 0.00002,
            Kph                     = 28.0,
            Kdh                     = 3.0,
            Kih                     = 0.0,

            steady_depth            = 5.0,
            hKp_err_croll           = 0.0,
            roll_diff_correction    = 1,
            fins_limit              = 0.25,
            x_fins_limit            = 0.0,
            vel_proj_div            = 10.0,
            v_vel_limit             = 25.0,

            air_ctrl                = 1,
            hor_ctrl                = 1,

            hor_spir_on_time        = 350,
            hor_spir_period         = 30,
            hor_spir_power          = 0.4,
        },

        engine =
        {
            thrust = 9900,
        },

        warhead        = yu6_warhead,
        warhead_water  = yu6_warhead,
    }

else

    YU_6 = {
        category        = CAT_TORPEDOES,
        name            = yu6_name,
        user_name       = _(yu6_name),
        scheme          = "unguided_torpedo",
        class_name      = "wAmmunition",
        model           = "yu6",
        mass            = yu6_mass,

        wsTypeOfWeapon  = {wsType_Weapon,wsType_Torpedo,wsType_S_Torpedo,WSTYPE_PLACEHOLDER},

        Head_Type    = 0,
        Diam         = 533.0,
        D_max        = 20000.0,
        D_min        = 100.0,
        V_min        = -1.0,
        V_max        = 320.0,
        H_max        = 3.0,
        H_min        = -100.0,
        Life_Time    = 1800.0,
        Nr_max       = 4.0,
        v_mid        = 40.0,

        shape_table_data =
        {
            {
                name        = yu6_name,
                file        = 'yu6',
                life        = 1,
                fire        = { 0, 1},
                username    = _(yu6_name),
                index       = WSTYPE_PLACEHOLDER,
            },
        },

        fm = {
            mass            = yu6_mass,
            caliber         = 0.533,
            cx_coeff        = {1,0.39,0.38,0.236,1.31},
            L               = 7.186,
            I               = 1 / 12 * yu6_mass * 7.186 * 7.186,
            Ma              = 0.2,
            Mw              = 0.4,
            wind_sigma      = 0.0,
            wind_time       = 0.0,
            Sw              = 0.5,
            dCydA           = {0.07, 0.036},
            A               = 0.5,
            maxAoa          = 0.3,
            finsTau         = 0.02,
            Ma_x            = 0.1,
            Kw_x            = 0.0005,
            calcAirFins     = 0,
            fins_val_div    = 10000,
            rho_w           = 515,
            int_rho_y       = 1.8,
            Sww             = 0.5,
            splash_time     = 1.4,
            splash_dt       = 0.004,
        },

        autopilot =
        {
            delay                   = 2.0,
            Kpv                     = 0.03,
            Kdv                     = 0.0,
            Kiv                     = 0.00002,
            Kph                     = 28.0,
            Kdh                     = 3.0,
            Kih                     = 0.0,

            steady_depth            = 5.0,
            hKp_err_croll           = 0.0,
            roll_diff_correction    = 1,
            fins_limit              = 0.25,
            x_fins_limit            = 0.0,
            vel_proj_div            = 10.0,
            v_vel_limit             = 25.0,

            hor_spir_on_time        = 350,
            hor_spir_period         = 30,
            hor_spir_power          = 0.4,
        },

        engine =
        {
            thrust = 9900,
        },

        warhead        = yu6_warhead,
        warhead_water  = yu6_warhead,
    }

end

declare_weapon(YU_6)

declare_loadout({
    category         = CAT_TORPEDOES,
    CLSID            = "DIS_YU_6",
    attribute        = YU_6.wsTypeOfWeapon,
    Count            = 1,
    Cx_pil           = 0.0018,
    Picture          = "agm84a.png",
    displayName      = YU_6.user_name,
    Weight           = YU_6.mass,
    Elements         = {{ShapeName = "yu6"}},
})
