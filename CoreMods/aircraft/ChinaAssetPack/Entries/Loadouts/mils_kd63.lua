
local kd63_name  = 'KD-63'
local kd63_model = 'kd63'
local kd63_mass  = 2000
local pylon_mass = 50.0

local KD63_warhead =
{
    mass                 = 500,
    caliber              = 760,
    expl_mass            = 300,
    piercing_mass        = 0.0,
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 3.0, 1.0, 5.0 },
    concrete_obj_factor  = 2.0,
    obj_factors          = { 2.0, 1.0 },
    cumulative_factor    = 2.0,
    cumulative_thickness = 0.0,
}


KD63_AS = {
    category        = CAT_MISSILES,
    name            = kd63_name,
    model           = kd63_model,
    user_name       = _(kd63_name),
    mass            = kd63_mass,
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
    add_attributes  = {"Cruise missiles"},

    Escort          = 0,
    Head_Type       = 5,
    sigma           = {8, 8, 8},
    M               = 628.0,
    H_max           = 10000.0,
    H_min           = 500,
    Diam            = 760.0,
    Cx_pil          = 6,
    D_max           = 240000.0,
    D_min           = 20000.0,
    Head_Form       = 0,
    Life_Time       = 1850.0,
    Nr_max          = 18,
    v_min           = 170.0,
    v_mid           = 272.0,
    Mach_max        = 0.9,
    t_b             = 5.0,
    t_acc           = 0.0,
    t_marsh         = 1800.0,
    Range_max       = 150000.0,
    H_min_t         = 0.0,
    Fi_start        = 0.5,
    Fi_rak          = 3.14152,
    Fi_excort       = 1.05,
    Fi_search       = 99.9,
    OmViz_max       = 99.9,
    -- No exhaust (turbo)
    X_back          = -3.805,
    Y_back          = -0.391,
    Z_back          = 0.0,
    Reflection      = 0.121,
    KillDistance    = 0.0,

    shape_table_data = {
        {
            name     = kd63_name,
            file     = kd63_model,
            life     = 1,
            fire     = {0, 1},
            username = kd63_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },

    LaunchDistData =
    {
        20,        7,

                100,    150,    200,    250,    300,    350,    400,
        500,    0,        75790,    83280,    87490,    90390,    93090,    93850,
        600,    0,        73690,    81610,    85620,    88750,    91500,    93860,
        700,    0,        74170,    82540,    86570,    89730,    92470,    94870,
        800,    0,        75175,    83750,    87775,    90975,    93725,    96150,
        900,    0,        75925,    84675,    88775,    91975,    94725,    97175,
        1000,    0,        76500,    85425,    89550,    92750,    95525,    97975,
        2000,    0,        79850,    87125,    91600,    95050,    98075,    100775,
        3000,    81550,    87150,    91150,    94750,    97750,    100250,    102700,
        4000,    85350,    89850,    93850,    97400,    100900,    103100,    105300,
        5000,    87500,    92200,    96300,    100000,    103600,    106300,    108700,
        6000,    90000,    94500,    98500,    102250,    106000,    109250,    112000,
        7000,    91750,    96500,    101000,    105000,    108750,    112250,    115250,
        8000,    93750,    98750,    103250,    107500,    111250,    115000,    118500,
        9000,    95750,    101000,    105750,    110000,    114000,    118000,    122000,
        10000,    97250,    102750,    108000,    113000,    117250,    121500,    126000,
        11000,    98500,    104500,    110500,    115500,    120500,    125500,    130500,
        12000,    100000,    106000,    112500,    119000,    124500,    130000,    135500,
        13000,    101500,    108000,    115000,    122500,    128500,    136000,    142000,
        14000,    103000,    110000,    117500,    126000,    133500,    141500,    148000,
        15000,    103500,    112000,    120000,    129500,    139000,    148500,    155000,
    },

    MinLaunchDistData =
    {
        20,        7,

                100,    150,    200,    250,    300,    350,    400,
        500,    0,        14540,    7320,    11250,    8260,    8680,    8970,
        600,    0,        11400,    7290,    7780,    8230,    8650,    9040,
        700,    0,        7410,    7410,    7890,    8350,    8770,    9160,
        800,    0,        7800,    7525,    8025,    8475,    8900,    9300,
        900,    0,        8325,    7650,    8125,    8575,    9025,    9425,
        1000,    0,        9325,    7725,    8225,    8675,    9100,    9500,
        2000,    0,        9200,    8100,    8250,    8825,    9225,    9725,
        3000,    6050,    6900,    7650,    8200,    8550,    8950,    9350,
        4000,    6350,    7000,    7500,    7950,    8300,    8650,    9000,
        5000,    6600,    7300,    7100,    8000,    8500,    8800,    9200,
        6000,    12750,    7500,    7250,    8250,    8750,    9000,    9500,
        7000,    13250,    7750,    7250,    8500,    8750,    9250,    9750,
        8000,    14250,    8250,    8500,    8750,    9250,    9500,    10000,
        9000,    15000,    14000,    8750,    9250,    9500,    10000,    10500,
        10000,    16000,    14750,    9250,    9500,    10000,    10250,    10750,
        11000,    17000,    16000,    14500,    10500,    11000,    11000,    11500,
        12000,    18500,    17500,    16000,    11000,    11500,    12000,    12500,
        13000,    19500,    19000,    18000,    16500,    12500,    19500,    22500,
        14000,    21000,    20500,    20000,    19000,    18000,    27000,    30000,
        15000,    22500,    22500,    22000,    22000,    31000,    35500,    39000,
    },

    LaunchDistData2 =
    {
        20,        7,

                100,    150,    200,    250,    300,    350,    400,
        500,    0,        75790,    83280,    87490,    90390,    93090,    93850,
        600,    0,        73690,    81610,    85620,    88750,    91500,    93860,
        700,    0,        74170,    82540,    86570,    89730,    92470,    94870,
        800,    0,        75175,    83750,    87775,    90975,    93725,    96150,
        900,    0,        75925,    84675,    88775,    91975,    94725,    97175,
        1000,    0,        76500,    85425,    89550,    92750,    95525,    97975,
        2000,    0,        74275,    87500,    91900,    95300,    98250,    100900,
        3000,    0,        32050,    90350,    95150,    98750,    101850,    104750,
        4000,    0,        36400,    92850,    98200,    102000,    105300,    108350,
        5000,    0,        41100,    92500,    98500,    103000,    106500,    110200,
        6000,    44250,    92750,    98250,    102250,    106000,    109250,    112500,
        7000,    90750,    96250,    101000,    104750,    108500,    112250,    115250,
        8000,    93500,    98500,    103000,    107250,    111000,    115000,    118500,
        9000,    95250,    100500,    105500,    110000,    113750,    117750,    122000,
        10000,    96750,    102250,    107500,    112500,    117000,    121250,    126000,
        11000,    98000,    103500,    109500,    115000,    120000,    125500,    130000,
        12000,    99500,    105500,    112000,    118000,    124000,    130000,    135000,
        13000,    100500,    107000,    114000,    121500,    128000,    135500,    141500,
        14000,    101500,    109000,    116500,    125000,    133000,    141500,    147500,
        15000,    103000,    111000,    119000,    128500,    139000,    147500,    154000,
    },

    MinLaunchDistData2 =
    {
        20,        7,

                100,    150,    200,    250,    300,    350,    400,
        500,    0,        14540,    7320,    11250,    8260,    8680,    8970,
        600,    0,        11400,    7290,    7780,    8230,    8650,    9040,
        700,    0,        7410,    7410,    7890,    8350,    8770,    9160,
        800,    0,        7800,    7525,    8025,    8475,    8900,    9300,
        900,    0,        8325,    7650,    8125,    8575,    9025,    9425,
        1000,    0,        9325,    7725,    8225,    8675,    9100,    9500,
        2000,    0,        8800,    8000,    8450,    8900,    9375,    9775,
        3000,    0,        6100,    8150,    8200,    8700,    9150,    9600,
        4000,    0,        7700,    8400,    8000,    8400,    8800,    8850,
        5000,    0,        8000,    8000,    7900,    10300,    8800,    9400,
        6000,    9750,    7250,    7250,    8250,    8750,    9000,    9500,
        7000,    13250,    7750,    7250,    8500,    8750,    9250,    9750,
        8000,    14250,    8250,    8500,    8750,    9250,    9500,    10000,
        9000,    15000,    14000,    8750,    9250,    9250,    9750,    10500,
        10000,    16000,    14750,    9250,    9500,    10000,    10250,    10750,
        11000,    17000,    16000,    14500,    10500,    11000,    11000,    11500,
        12000,    18500,    17500,    16000,    11000,    11500,    12000,    12500,
        13000,    19500,    19000,    18000,    16500,    12500,    19500,    22500,
        14000,    21000,    20500,    20000,    19000,    17500,    27000,    30000,
        15000,    22500,    22500,    22000,    22000,    31000,    35500,    38500,
    },

    LaunchDistData3 =
    {
        20,        7,

                100,    150,    200,    250,    300,    350,    400,
        500,    0,        75790,    83280,    87490,    90390,    93090,    93850,
        600,    0,        73690,    81610,    85620,    88750,    91500,    93860,
        700,    0,        74170,    82540,    86570,    89730,    92470,    94870,
        800,    0,        75175,    83750,    87775,    90975,    93725,    96150,
        900,    0,        75925,    84675,    88775,    91975,    94725,    97175,
        1000,    0,        76500,    85425,    89550,    92750,    95525,    97975,
        2000,    0,        74275,    87500,    91900,    95300,    98250,    100900,
        3000,    23050,    32050,    90350,    95150,    98750,    101850,    104750,
        4000,    32150,    36400,    92850,    98200,    102000,    105300,    108350,
        5000,    37000,    42200,    95100,    101300,    105300,    108800,    112200,
        6000,    42000,    48000,    96500,    104500,    109000,    112750,    116250,
        7000,    47750,    53500,    96250,    108000,    113250,    117250,    121250,
        8000,    53000,    59000,    77000,    111750,    118250,    123500,    127750,
        9000,    58250,    64250,    70000,    115750,    125250,    131750,    137250,
        10000,    64750,    69750,    75000,    118000,    134750,    144500,    152500,
        11000,    71000,    73500,    78500,    94500,    133000,    147000,    164500,
        12000,    77500,    78000,    86500,    128000,    145000,    160500,    169000,
        13000,    84500,    84500,    119000,    139000,    154500,    165000,    173000,
        14000,    91000,    105500,    128000,    145500,    157500,    169500,    178000,
        15000,    97500,    114500,    132000,    148000,    161500,    173500,    182500,
    },

    MinLaunchDistData3 =
    {
        20,        7,

                100,    150,    200,    250,    300,    350,    400,
        500,    0,        14540,    7320,    7750,    8260,    8680,    8970,
        600,    0,        11400,    7290,    7780,    8230,    8650,    9040,
        700,    0,        7410,    7410,    7890,    8350,    8770,    9160,
        800,    0,        7800,    7525,    8025,    8475,    8900,    9300,
        900,    0,        8325,    7650,    8125,    8575,    9025,    9425,
        1000,    0,        9325,    7725,    8225,    8675,    9100,    9500,
        2000,    0,        8800,    8000,    8450,    8900,    9375,    9775,
        3000,    5500,    6100,    8150,    8200,    8700,    9150,    9600,
        4000,    7250,    7700,    8400,    8000,    8400,    8800,    8850,
        5000,    8900,    8100,    9400,    8200,    8200,    9000,    9400,
        6000,    8000,    8500,    12000,    8500,    8750,    9250,    9750,
        7000,    10750,    9000,    12000,    9000,    9000,    9500,    10000,
        8000,    11750,    9250,    10750,    10000,    9750,    10000,    10500,
        9000,    13000,    9750,    10250,    11250,    10000,    10750,    11250,
        10000,    14250,    12750,    10500,    13500,    11500,    11750,    12500,
        11000,    15000,    14000,    11000,    12500,    15000,    12000,    13500,
        12000,    17000,    15500,    12000,    12000,    13000,    14000,    14500,
        13000,    18500,    17500,    18000,    13000,    14000,    21000,    24500,
        14000,    20000,    20000,    20500,    20500,    14500,    29000,    32000,
        15000,    22000,    22500,    23000,    23500,    32500,    37000,    40500,
    },

    Damage_correction_coeff = 1.0,

    warhead        = KD63_warhead,
    warhead_air    = KD63_warhead,

    scheme     = "sat_cruise_missile",
    class_name = "wAmmunitionAntiShip",

    controller = {
        boost_start = 0.001,
        march_start = 0.8,
    },

    fm = {
        mass        = kd63_mass,
        caliber     = 0.76,
        cx_coeff    = {1,0.39,0.38,0.236,1.31},
        L           = 7,
        I           = 1 / 12 * kd63_mass * 7 * 7,
        Ma          = 0.68,
        Mw          = 1.116,
        wind_sigma  = 0.0,
        wind_time   = 1000.0,
        Sw          = 0.7,
        dCydA       = {0.07, 0.036},
        A           = 0.5,
        maxAoa      = 0.3,
        finsTau     = 0.05,
        Ma_x        = 3,
        Ma_z        = 3,
        Mw_x        = 2.6,
        
        addDeplSw            = 0.6,
        no_wings_A_mlt       = 7,
        wingsDeplProcTime    = 5,
        wingsDeplDelay       = 1,
    },
    
    seeker = {
        coalition                = 2,
        coalition_rnd_coeff      = 5.0,
        can_update_target_pos    = 1,
    },
    
    control_block = {
        seeker_activation_dist        = 20000,
        default_cruise_height         = 300,
        obj_sensor                    = 0,
        can_update_target_pos         = 1,
        turn_before_point_reach       = 1,
        turn_hor_N                    = 0.8,
        turn_max_calc_angle_deg       = 90,
        turn_point_trigger_dist       = 200,
        use_horiz_dist                = 1,
    },
    
    final_autopilot = {
        delay                = 0,
        K                    = 60,
        Ki                   = 0,
        Kg                   = 4,
        finsLimit            = 0.8,
        useJumpByDefault     = 0,
        J_Power_K            = 1.5,
        J_Diff_K             = 0.4,
        J_Int_K              = 0,
        J_Angle_K            = 0.18,
        J_FinAngle_K         = 0.32,
        J_Angle_W            = 0.8,
        J_Trigger_Vert       = 1,
        hKp_err              = 120,
        hKp_err_croll        = 0.04,
        hKd                  = 0.005,
        max_roll             = 0.8,
    },
    
    cruise_autopilot = {
        delay                 = 1,
        Kp_hor_err            = 240,
        Kp_hor_err_croll      = 0.06,
        Kd_hor                = 0,
        Kp_ver                = 9,
        Kii_ver               = 0.2,
        Kd_ver                = 0,
        Kp_eng                = 265,
        Ki_eng                = 0.003,
        Kd_eng                = 0,
        Kp_ver_st1            = 0.009,
        Kd_ver_st1            = 0.015,
        Kp_ver_st2            = 0.00018,
        Kd_ver_st2            = 0.00005,
        
        auto_terrain_following           = 1,
        auto_terrain_following_height    = 600,
        
        alg_points_num            = 7,
        alg_calc_time             = 1.5,
        alg_vel_k                 = 6,
        alg_div_k                 = 2,
        alg_max_sin_climb         = 0.8,
        alg_section_temp_points   = 3,
        alg_tmp_point_vel_k       = 1.5,
        no_alg_vel_k              = 10,
        
        max_roll                  = 0.8,
        max_start_y_vel           = 35,
        stab_vel                  = 250,
        finsLimit                 = 0.8,
        estimated_N_max           = 6,
        eng_min_thrust            = -100,
        eng_max_thrust            = 25000,        
    },
    
    boost = {                --    air launch - no booster
        impulse                              = 0,
        fuel_mass                            = 0,
        work_time                            = 0,
        boost_time                           = 0,
        boost_factor                         = 0,
        nozzle_position                      = {{0, 0, 0}},
        nozzle_orientationXYZ                = {{0, 0, 0}},
        tail_width                           = 0.0,
        smoke_color                          = {0.0, 0.0, 0.0},
        smoke_transparency                   = 0.0,
        custom_smoke_dissipation_factor      = 0.0,
    },
    
    booster_animation = {
        start_val = 0,
    },
    
    play_booster_animation = {
        val = 0,
    },
    
    march = {
        impulse           = 690,
        fuel_mass         = 500,
        work_time         = 9999,
        min_fuel_rate     = 0.005,
        min_thrust        = -100,
        max_thrust        = 25000,
        thrust_Tau        = 0.0017,
        
        nozzle_position                       = {{-2.25, 0.0, 0.0}},
        nozzle_orientationXYZ                 = {{0.0, 0.0, 0.0}},
        tail_width                            = 0.5,
        smoke_color                           = {0.5, 0.5, 0.5},
        smoke_transparency                    = 0.03,
        custom_smoke_dissipation_factor       = 0.2,    
        
        start_burn_effect            = 1,
        start_effect_delay           = {0.0,     0.3,     0.8},
        start_effect_time            = {0.7,     1.0,     0.1},
        start_effect_size            = {0.09,    0.104,   0.11},
        start_effect_smoke           = {0.01,    0.4,     0.01},
        start_effect_x_pow           = {1.0,     1.0,     1.0},
        start_effect_x_dist          = {1.1,     0.9,     0.0},
        start_effect_x_shift         = {0.15,    0.15,    0.2},
        
    },

}

declare_weapon(KD63_AS)

declare_loadout({
    category       = CAT_MISSILES,
    CLSID          = 'DIS_GDJ_KD63',
    Picture        = 'kd63.png',
    wsTypeOfWeapon = KD63_AS.wsTypeOfWeapon,
    attribute      = {4, 4, 32, WSTYPE_PLACEHOLDER},
    displayName    = _(kd63_name),
    Cx_pil         = 0.0023,
    Count          = 1,
    Weight         = kd63_mass + pylon_mass,
    Elements       = {
        {
            ShapeName = "adapter_gdj_kd63",
            IsAdapter = true,
        },
        {
            ShapeName = kd63_model,
            connector_name = "adapter_cnt",
        },
    }, -- end of Elements
    JettisonSubmunitionOnly = true,
    ejectImpulse = 2000,
    Required     = {"DIS_AKG_DLPOD"},
})

declare_loadout({
    category     = CAT_MISSILES,
    CLSID        = 'DIS_KD63',
    Picture      = 'kd63.png',
    attribute    = KD63_AS.wsTypeOfWeapon,
    displayName  = _(kd63_name),
    Cx_pil       = 0.0023,
    Count        = 1,
    Weight       = kd63_mass,
    Elements     = {
        {
            ShapeName = kd63_model,
            Position  = {0, 0, 0},
        },
    }, -- end of Elements
    ejectImpulse = 2000,
    Required     = {"DIS_AKG_DLPOD"},
})

-- KD-63B
local kd63b_name  = 'KD-63B'
local kd63b_model = 'kd63b'

KD63B_AS = {}
copyTable(KD63B_AS, KD63_AS)
KD63B_AS.name           = kd63b_name
KD63B_AS.model          = kd63b_model
KD63B_AS.user_name      = _(kd63b_name)
KD63B_AS.wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER}
KD63B_AS.shape_table_data[1].name     = kd63b_name
KD63B_AS.shape_table_data[1].file     = kd63b_model
KD63B_AS.shape_table_data[1].username = kd63b_name
KD63B_AS.shape_table_data[1].index    = WSTYPE_PLACEHOLDER
declare_weapon(KD63B_AS)


declare_loadout({
    category       = CAT_MISSILES,
    CLSID          = 'DIS_GDJ_KD63B',
    Picture        = 'kd63b.png',
    wsTypeOfWeapon = KD63B_AS.wsTypeOfWeapon,
    attribute      = {4, 4, 32, WSTYPE_PLACEHOLDER},
    displayName    = _(kd63b_name),
    Cx_pil         = 0.0023,
    Count          = 1,
    Weight         = kd63_mass + pylon_mass,
    Elements       = {
        {
            ShapeName = "adapter_gdj_kd63",
            IsAdapter = true,
        },
        {
            ShapeName = kd63b_model,
            connector_name = "adapter_cnt",
        },
    }, -- end of Elements
    JettisonSubmunitionOnly = true,
    ejectImpulse = 2000,
    Required     = {"DIS_AKG_DLPOD"},
})

declare_loadout({
    category     = CAT_MISSILES,
    CLSID        = 'DIS_KD63B',
    Picture      = 'kd63b.png',
    attribute    = KD63B_AS.wsTypeOfWeapon,
    displayName  = _(kd63b_name),
    Cx_pil       = 0.0023,
    Count        = 1,
    Weight       = kd63_mass,
    Elements     = {
        {
            ShapeName = kd63b_model,
            Position  = {0, 0, 0},
        },
    }, -- end of Elements
    ejectImpulse = 2000,
    Required     = {"DIS_AKG_DLPOD"},
})
