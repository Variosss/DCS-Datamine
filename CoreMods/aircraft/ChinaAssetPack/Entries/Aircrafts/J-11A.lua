local function BD3(clsid)
    return {CLSID = clsid, arg_value = 0.15 }
end

local function MBD(clsid)
    return {CLSID = clsid, arg_value = 0.25 }
end

function pl_cat(clsid, name)
    local res = {};

    res.CLSID = clsid;
    res.Name = name;

    return res;
end

mount_vfs_model_path (current_mod_path .. '/Shapes/J-11A')
mount_vfs_texture_path (current_mod_path .. '/Textures/J-11A')

J11A = {
    Name             = 'J-11A',
    DisplayName      = _('J-11A'),
    WorldID          = J_11A,
    EmptyWeight      = "17500",
    MaxTakeOffWeight = "33000",
    MaxFuelWeight    = "9400",
    MaxHeight        = "18500",
    MaxSpeed         = "2500",
    Picture          = 'J-11A.png',
    ViewSettings     = ViewSettings,
    Rate             = 50, -- RewardPoint in Multiplayer
    Shape            = 'J-11A',
    shape_table_data = {
        {
            file        = 'J-11A',
            life        = 18,               -- lifebar
            vis         = 3,                -- visibility gain.
            desrt       = 'J-11A-oblomok',  -- Name of destroyed object file name
            fire        = { 300, 2},        -- Fire on the ground after destoyed: 300sec 2m
            username    = 'J-11A',
            index       = J_11A,
            classname   = 'lLandPlane',
            positioning = 'BYNORMAL',
        },
        {
            name = 'J-11A-oblomok',
            file = 'J-11A-oblomok',
            fire = { 240, 2},
        },
    },

    Countries = {'China', 'USAF Aggressors'},
    date_of_introduction = 1998.12, --
    country_of_origin = 'CHN',

    --sounderName = "Aircraft/Planes/J-11A",

    -------------------------
    -- add model draw args for network transmitting to this draw_args table (32 limit)
    net_animation = {
        0, -- front gear
        3, -- right gear
        5, -- left gear
        9, -- right flap
        10, -- left flap
        11, -- right aileron
        12, -- left aileron
        15, -- right elevator
        16, -- left elevator
        17, -- rudder

        38,  -- canopy
        115, -- gear door
        116, -- gear door
        117, -- gear door

        190, -- left (red) navigation wing-tip light
        191, -- right (green) navigation wing-tip light
        192, -- tail (white) light

        198, -- anticollision (flashing red) top light
        199, -- anticollision (flashing red) bottom light
        208, -- taxi light (white) right main gear door
    },

    -------------------------
    mapclasskey = 'P0091000024',
    attribute   = {wsType_Air, wsType_Airplane, wsType_Fighter, J_11A, "Fighters"},
    Categories  = {
        pl_cat("{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor"),
    },

    -------------------------
    M_empty                     = 17500,    -- J-11A with pilot and nose load, kg
    M_nominal                   = 23000,    -- J-11A kg (Empty Plus Full Internal Fuel)
    M_max                       = 33000,    -- J-11A kg (Maximum Take Off Weight)
    M_fuel_max                  = 9400,     -- J-11A kg (Internal Fuel Only)
    H_max                       = 18500,    -- J-11A m  (Maximum Operational Ceiling)
    average_fuel_consumption    = 0.268,    --
    CAS_min                     = 58,       --
    V_opt                       = 170,      --
    V_take_off                  = 75.0,     -- Take off speed in m/s (for AI)
    V_land                      = 65,       -- Land speed in m/s (for AI)
    V_max_sea_level             = 403,      -- Max speed at sea level in m/s (for AI)
    V_max_h                     = 694.44,   -- Max speed at max altitude in m/s (for AI)
    Vy_max                      = 325,      -- Max climb speed in m/s (for AI)
    Mach_max                    = 2.35,     -- Max speed in Mach (for AI)
    Ny_min                      = -3,       -- Min G (for AI)
    Ny_max                      = 8,        -- Max G (for AI)
    Ny_max_e                    = 8,        -- Max G (for AI)
    AOA_take_off                = 0.17,     -- AoA in take off (for AI)
    stores_number               = 10,
    bank_angle_max              = 60,       -- Max bank angle (for AI)
    has_afteburner              = true,     -- AFB yes/no
    has_speedbrake              = true,     -- Speedbrake yes/no

    -----------------------------------------------------------------------
    tand_gear_max                             = 0.577,                   -- tangent on maximum yaw angle of front wheel, 65 degrees tan(64deg)
    nose_gear_pos                             = {5.221, -2.185, 0.0},    -- nosegear coord
    nose_gear_wheel_diameter                  = 0.754,                   -- in m
    nose_gear_amortizer_direct_stroke         = 2.289 - 2.185,           -- down from nose_gear_pos !!!
    nose_gear_amortizer_reversal_stroke       = 1.992 - 2.185,           -- up
    nose_gear_amortizer_normal_weight_stroke  = -0.00311633945,          -- down from nose_gear_pos
    main_gear_pos                             = {-0.537, -2.237, 2.168}, -- main gear coords
    main_gear_wheel_diameter                  = 0.972,                   -- in m
    main_gear_amortizer_direct_stroke         = 2.555 - 2.237,           -- down from main_gear_pos !!!
    main_gear_amortizer_reversal_stroke       = 2.123 - 2.237,           -- up
    main_gear_amortizer_normal_weight_stroke  = 0.0986220837,            -- down from main_gear_pos
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------
    brakeshute_name           = 4,         -- Landing - brake chute visual shape after separation
    tanker_type               = 0,         -- Tanker type if the plane is airrefuel capable (same type as F-14, aka drogue basket)
    is_tanker                 = false,     -- Tanker yes/no
    air_refuel_receptacle_pos = {0, 0, 0}, -- refuel coords

    wing_area                 = 62,        -- J-11A wing area in m2
    wing_span                 = 14.7,      -- J-11A  wing spain in m,
    wing_type                 = 0,         -- Fixed wing
    flaps_maneuver            = 1.0,       -- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)

    thrust_sum_max            = 15200,
    thrust_sum_ab             = 25000,

    length                    = 21.935,    -- J-11A full lenght in m
    height                    = 5.932,     -- J-11A height in m
    range                     = 3740,      -- Max range in km (for AI)
    RCS                       = 5.5,       -- Radar Cross Section m2
    IR_emission_coeff         = 1,         -- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
    IR_emission_coeff_ab      = 5,         -- With afterburner
    wing_tip_pos              = {-4.5, 0.4, 7.5}, -- wingtip coords for visual effects

    engines_count = 2, -- Engines count
    engines_nozzles = {
        [1] = {
            pos                 = {-6.889, -0.257, -1.193}, -- nozzle coords
            elevation           = 0, -- AFB cone elevation
            diameter            = 1.137, -- AFB cone diameter
            exhaust_length_ab   = 8.6, -- lenght in m
            exhaust_length_ab_K = 0.629, -- AB animation
            smokiness_level     = 0.1,
        }, -- end of [1]
        [2] = {
            pos                 = {-6.889, -0.257, 1.193}, -- nozzle coords
            elevation           = 0, -- AFB cone elevation
            diameter            = 1.137, -- AFB cone diameter
            exhaust_length_ab   = 8.6, -- lenght in m
            exhaust_length_ab_K = 0.629, -- AB animation
            smokiness_level     = 0.1,
        }, -- end of [2]
    }, -- end of engines_nozzles

    crew_size     = 1,
    crew_members = {
        [1] = {
            can_be_playable     = true,
            pilot_name          = "pilot_j11a",
            ejection_seat_name  = 'pilot_j11a_seat', -- 9
            drop_canopy_name    = 'J-11A-fonar', -- 35
            pos                 = {7.916, 0.986, 0},
            --canopy_pos          = {2.677, 2.677, 0},
            --canopy_ejection_dir = {-1.0,0.2,0},
            canopy_arg          = 38,
        }, -- end of [1]
    }, -- end of crew_members

    fires_pos = {
        [1]  = {-1.594, -0.064, 0},
        [2]  = {-1.073, 0.319, 3.716},
        [3]  = {-1.187, 0.338, -3.678},
        [4]  = {-0.82, 0.265, 2.774},
        [5]  = {-0.82, 0.265, -2.774},
        [6]  = {-0.82, 0.255, 3.260},
        [7]  = {-0.82, 0.255, -3.080},
        [8]  = {-5.889, -0.257, 1.193},
        [9]  = {-5.889, -0.257, -1.193},
        [10] = {-1.257, 0.283, 3.05},
        [11] = {-1.257, 0.283, -2.50},
    }, -- end of fires_pos

    effects_presets = {
        { effect = 'OVERWING_VAPOR', file = current_mod_path .. '/Effects/J-11A_overwingVapor.lua', preset = "J11A" },
    },

    HumanRadio = {
        frequency = 127.5,
        modulation = MODULATION_AM,
    },

    --sensors
    Sensors = {
        RWR   = 'Abstract RWR',
        RADAR = 'N-001',
        IRST  = 'OLS-27',
    },

    -- Countermeasures
    passivCounterm = {
        CMDS_Edit = true,
        SingleChargeTotal = 192,
        -- PPR-26
        chaff = {default = 96, increment = 3, chargeSz = 1},
        -- PPI-26
        flare = {default = 96, increment = 3, chargeSz = 1}
    },

    chaff_flare_dispenser = {
            [1] =
            {
                dir = {0, 1, 0},
                pos = {-5.776, 1.4, -0.422},
            }, -- end of [1]
            [2] =
            {
                dir = {0, 1, 0},
                pos = {-5.776, 1.4, 0.422},
            }, -- end of [2]
    }, -- end of chaff_flare_dispenser

    -- Countermeasures
    --[[
    Countermeasures = {
        ECM = {"Sorbciya"}
    },
    ]]

    detection_range_max = 250,
    radar_can_see_ground = true, --

    CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_AVERAGE, LOOK_AVERAGE, LOOK_AVERAGE),

    mech_timing = {{0.0, 0.074; 0.11, 0.14}, -- CANOPY_OPEN_TIMES
                   {0.0, 0.18; 0.89, 0.074}, -- CANOPY_CLOSE_TIMES
                  },

    Guns = {
        gun_mount('GSh_30_1', { count = 150 }, {
                    muzzle_pos = {6.44,   0.34,  1.0},
                    elevation_initial = 2.0,
                    drop_cartridge = 203,
                    ejector_dir = {7.0 ,-1.0,0.5},
                    ejector_pos_connector = 'eject 1',}
                 ),
    },

    pylons_enumeration = {10, 1, 9, 2, 3, 8, 4, 7, 6, 5},
    Pylons = {
        pylon(1, 0, -1.943000, 0.173000, -7.280000,
            {arg = 308, arg_value = 0, use_full_connector_position = true,},
            {
                { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}" }, --R-73
                { CLSID = '{RKL609_L}', arg = 308, arg_value = 1, required = {{station = 10, loadout = {'{RKL609_R}'},}} },--Sorbciya

                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B1}" }, --Smoke Generator - red
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B2}" }, --Smoke Generator - green
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B3}" }, --Smoke Generator - blue
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B4}" }, --Smoke Generator - white
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B5}" }, --Smoke Generator - yellow
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B6}" }, --Smoke Generator - orange
            }
        ),
        pylon(2, 0, -2.535000, -0.165000, -6.168000,
            {arg = 309, arg_value = 0, use_full_connector_position = true,},
            {
                { CLSID = '{FBC29BFE-3D24-4C64-B81D-941239D12249}', arg_value = 0 }, --R-73
                --{ CLSID = '{PL-8}', arg_value = 0 },  --PL-8
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B1}" }, --Smoke Generator - red
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B2}" }, --Smoke Generator - green
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B3}" }, --Smoke Generator - blue
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B4}" }, --Smoke Generator - white
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B5}" }, --Smoke Generator - yellow
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B6}" }, --Smoke Generator - orange
            }
        ),
        pylon(3, 0, -1.137000, -0.321000, -4.524000,
            {arg = 310, arg_value = 0, use_full_connector_position = true,},
            {
                { CLSID = '{FBC29BFE-3D24-4C64-B81D-941239D12249}' , arg_value = 0.3}, --R-73
                --{ CLSID = '{PL-8}', arg_value = 0 },  --PL-8
                { CLSID = '{9B25D316-0434-4954-868F-D51DB1A38DF0}', arg_value = 0 }, --R-27R
                { CLSID = '{E8069896-8435-4B90-95C0-01A03AE6E400}', arg_value = 0 }, --R-27ER
                { CLSID = '{88DAC840-9F75-4531-8689-B46E64E42E53}', arg_value = 0 }, --R-27T
                { CLSID = '{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}', arg_value = 0 }, --R-27ET
                { CLSID = '{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}', arg_value = 0.45, Type = 1 }, --R-77
                BD3("{35B698AC-9FEF-4EC4-AD29-484A0085F62B}"),--BetAB-500
                BD3("{BD289E34-DF84-4C5E-9220-4B14C346E79D}"),--BetAB-500ShP
                BD3('{37DCC01E-9E02-432F-B61D-10C166CA2798}'), --FAB-500 M62
                BD3('{3C612111-C7AD-476E-8A8E-2485812F4E5C}'),--FAB-250
                --BD3("{96A7F676-F956-404A-AD04-F33FB2C74884}"), --KMGU-2 - 96 AO-2.5RT
                --BD3("{96A7F676-F956-404A-AD04-F33FB2C74881}"), --KMGU-2 - 96 PTAB-2.5KO
                BD3("{4203753F-8198-4E85-9924-6F8FF679F9FF}"),--RBK-250 PTAB-2.5M
                BD3("{RBK_250_275_AO_1SCH}"),                -- RBK-250-275 AO-1SCh
                BD3("{D5435F26-F120-4FA3-9867-34ACE562EF1B}"),--RBK-500 PTAB-10-5
                BD3("{7AEC222D-C523-425e-B714-719C0D1EB14D}"),--RBK-500 PTAB-1M
                BD3("{RBK_500U_OAB_2_5RT}"),                --RBK-500U OAB-2.5RT
                MBD("{F99BEC1A-869D-4AC7-9730-FBA0E3B1F5FC}"),--MER*6 FAB-100
                MBD("{53BE25A4-C86C-4571-9BC0-47D668349595}"),-- 6 * FAB-250
                BD3("{0511E528-EA28-4caf-A212-00D1408DF10A}"), --SAB-100
                BD3("{FC56DF80-9B09-44C5-8976-DCFAFF219062}"), --B-13L - 5 S-13 OF
                BD3("{A0648264-4BC0-4EE8-A543-D119F6BA4257}"), --S-25 OFM
                BD3("{F72F47E5-C83A-4B85-96ED-D3E46671EE9A}"), --B-8M1 - 20 S-8KOM
                BD3("{3DFB7320-AB0E-11d7-9897-000476191836}"), --B-8M1 - 20 S-8TsM
                BD3("B-8M1 - 20 S-8OFP2"),--B-8M1 - 20 S-8OFP2

                -- twin pylon
                { CLSID = '{FAB_250_DUAL_L}', arg_value = 1.0 }, --
                { CLSID = '{FAB_500_DUAL_L}', arg_value = 1.0 }, --
                { CLSID = '{RBK_250_PTAB25M_DUAL_L}', arg_value = 1.0 }, --
                { CLSID = '{RBK_500_PTAB105_DUAL_L}', arg_value = 1.0 },
                { CLSID = '{B13_5_S13OF_DUAL_L}', arg_value = 1.0 }, --
                { CLSID = '{B8M1_20_S8KOM_DUAL_L}', arg_value = 1.0 }, --
                { CLSID = '{B8M1_20_S8TsM_DUAL_L}', arg_value = 1.0 }, --
                { CLSID = '{B8M1_20_S8OFP2_DUAL_L}', arg_value = 1.0 }, --
                { CLSID = '{S25_DUAL_L}', arg_value = 1.0 }, --
            }
        ),
        pylon(4, 1, -0.075000, -1.218000, -1.192000,
            {arg = 311, arg_value = 1, use_full_connector_position = true,},
            {
                { CLSID = '{9B25D316-0434-4954-868F-D51DB1A38DF0}', arg_value = 0 }, --R-27R
                { CLSID = '{E8069896-8435-4B90-95C0-01A03AE6E400}', arg_value = 0 }, --R-27ER
                --{ CLSID = '{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}', arg_value = 0 }, --R-27ET
                { CLSID = '{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}', arg_value = 0.35, Type = 1 }, --R-77
                BD3('{37DCC01E-9E02-432F-B61D-10C166CA2798}'), --FAB-500 M62
                BD3('{3C612111-C7AD-476E-8A8E-2485812F4E5C}'),--FAB-250
                BD3("{35B698AC-9FEF-4EC4-AD29-484A0085F62B}"),--BetAB-500
                BD3("{BD289E34-DF84-4C5E-9220-4B14C346E79D}"),--BetAB-500ShP
                --BD3("{96A7F676-F956-404A-AD04-F33FB2C74884}"), --KMGU-2 - 96 AO-2.5RT
                --BD3("{96A7F676-F956-404A-AD04-F33FB2C74881}"), --KMGU-2 - 96 PTAB-2.5KO
                MBD("{F99BEC1A-869D-4AC7-9730-FBA0E3B1F5FC}"),--MER*6 FAB-100
                BD3("{RBK_250_275_AO_1SCH}"),                -- RBK-250-275 AO-1SCh
                BD3("{D5435F26-F120-4FA3-9867-34ACE562EF1B}"),--RBK-500 PTAB-10-5
                BD3("{7AEC222D-C523-425e-B714-719C0D1EB14D}"),--RBK-500 PTAB-1M
                BD3("{RBK_500U_OAB_2_5RT}"),                --RBK-500U OAB-2.5RT
                BD3("{0511E528-EA28-4caf-A212-00D1408DF10A}"), --SAB-100
            }
        ),
        pylon(5, 1, -3.751000, -0.384000, 0.000000,
            {arg = 312, arg_value = 0, use_full_connector_position = true,},
            {
                { CLSID = '{9B25D316-0434-4954-868F-D51DB1A38DF0}', arg_value = 0 }, --R-27R
                { CLSID = '{E8069896-8435-4B90-95C0-01A03AE6E400}', arg_value = 0 }, --R-27ER
                --{ CLSID = '{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}', arg_value = 0 }, --R-27ET
                { CLSID = '{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}', arg_value = 0.35, Type = 1 }, --R-77
                BD3('{37DCC01E-9E02-432F-B61D-10C166CA2798}'), --FAB-500 M62
                BD3('{3C612111-C7AD-476E-8A8E-2485812F4E5C}'),--FAB-250
                BD3("{35B698AC-9FEF-4EC4-AD29-484A0085F62B}"),--BetAB-500
                BD3("{BD289E34-DF84-4C5E-9220-4B14C346E79D}"),--BetAB-500ShP
                MBD("{F99BEC1A-869D-4AC7-9730-FBA0E3B1F5FC}"),--MER*6 FAB-100
                BD3("{RBK_250_275_AO_1SCH}"),                -- RBK-250-275 AO-1SCh
                BD3("{D5435F26-F120-4FA3-9867-34ACE562EF1B}"),--RBK-500 PTAB-10-5
                BD3("{7AEC222D-C523-425e-B714-719C0D1EB14D}"),--RBK-500 PTAB-1M
                BD3("{RBK_500U_OAB_2_5RT}"),                --RBK-500U OAB-2.5RT
                BD3("{0511E528-EA28-4caf-A212-00D1408DF10A}"), --SAB-100
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B1}" }, --Smoke Generator - red
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B2}" }, --Smoke Generator - green
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B3}" }, --Smoke Generator - blue
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B4}" }, --Smoke Generator - white
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B5}" }, --Smoke Generator - yellow
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B6}" }, --Smoke Generator - orange
            }),
        pylon(6, 1, 0.986000, -0.384000, 0.000000,
            {arg = 313, arg_value = 0, use_full_connector_position = true,},
            {
                { CLSID = '{9B25D316-0434-4954-868F-D51DB1A38DF0}', arg_value = 0 }, --R-27R
                { CLSID = '{E8069896-8435-4B90-95C0-01A03AE6E400}', arg_value = 0 }, --R-27ER
                --{ CLSID = '{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}', arg_value = 0 }, --R-27ET
                { CLSID = '{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}', arg_value = 0.35, Type = 1 }, --R-77
                BD3('{37DCC01E-9E02-432F-B61D-10C166CA2798}'), --FAB-500 M62
                BD3('{3C612111-C7AD-476E-8A8E-2485812F4E5C}'),--FAB-250
                BD3("{35B698AC-9FEF-4EC4-AD29-484A0085F62B}"),--BetAB-500
                BD3("{BD289E34-DF84-4C5E-9220-4B14C346E79D}"),--BetAB-500ShP
                MBD("{F99BEC1A-869D-4AC7-9730-FBA0E3B1F5FC}"),--MER*6 FAB-100
                MBD("{53BE25A4-C86C-4571-9BC0-47D668349595}"),-- 6 * FAB-250
                BD3("{RBK_250_275_AO_1SCH}"),                -- RBK-250-275 AO-1SCh
                BD3("{D5435F26-F120-4FA3-9867-34ACE562EF1B}"),--RBK-500 PTAB-10-5
                BD3("{7AEC222D-C523-425e-B714-719C0D1EB14D}"),--RBK-500 PTAB-1M
                BD3("{RBK_500U_OAB_2_5RT}"),                --RBK-500U OAB-2.5RT
                BD3("{0511E528-EA28-4caf-A212-00D1408DF10A}"), --SAB-100
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B1}" }, --Smoke Generator - red
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B2}" }, --Smoke Generator - green
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B3}" }, --Smoke Generator - blue
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B4}" }, --Smoke Generator - white
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B5}" }, --Smoke Generator - yellow
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B6}" }, --Smoke Generator - orange
            }
        ),
        pylon(7, 1, -0.075000, -1.218000, 1.192000,
            {arg = 314, arg_value = 1, use_full_connector_position = true,},
            {
                { CLSID = '{9B25D316-0434-4954-868F-D51DB1A38DF0}', arg_value = 0 }, --R-27R
                { CLSID = '{E8069896-8435-4B90-95C0-01A03AE6E400}', arg_value = 0 }, --R-27ER
                --{ CLSID = '{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}', arg_value = 0 }, --R-27ET
                { CLSID = '{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}', arg_value = 0.35, Type = 1 }, --R-77
                BD3('{37DCC01E-9E02-432F-B61D-10C166CA2798}'), --FAB-500 M62
                BD3('{3C612111-C7AD-476E-8A8E-2485812F4E5C}'),--FAB-250
                BD3("{35B698AC-9FEF-4EC4-AD29-484A0085F62B}"),--BetAB-500
                BD3("{BD289E34-DF84-4C5E-9220-4B14C346E79D}"),--BetAB-500ShP
                --BD3("{96A7F676-F956-404A-AD04-F33FB2C74884}"), --KMGU-2 - 96 AO-2.5RT
                --BD3("{96A7F676-F956-404A-AD04-F33FB2C74881}"), --KMGU-2 - 96 PTAB-2.5KO
                MBD("{F99BEC1A-869D-4AC7-9730-FBA0E3B1F5FC}"),--MER*6 FAB-100
                BD3("{RBK_250_275_AO_1SCH}"),                -- RBK-250-275 AO-1SCh
                BD3("{D5435F26-F120-4FA3-9867-34ACE562EF1B}"),--RBK-500 PTAB-10-5
                BD3("{7AEC222D-C523-425e-B714-719C0D1EB14D}"),--RBK-500 PTAB-1M
                BD3("{RBK_500U_OAB_2_5RT}"),                --RBK-500U OAB-2.5RT
                BD3("{0511E528-EA28-4caf-A212-00D1408DF10A}"), --SAB-100
            }
        ),
        pylon(8, 0, -1.137000, -0.321000, 4.524000,
            {arg = 315, arg_value = 0, use_full_connector_position = true,},
            {
                { CLSID = '{FBC29BFE-3D24-4C64-B81D-941239D12249}' , arg_value = 0.3}, --R-73
                --{ CLSID = '{PL-8}', arg_value = 0 },  --PL-8
                { CLSID = '{9B25D316-0434-4954-868F-D51DB1A38DF0}', arg_value = 0 }, --R-27R
                { CLSID = '{E8069896-8435-4B90-95C0-01A03AE6E400}', arg_value = 0 }, --R-27ER
                { CLSID = '{88DAC840-9F75-4531-8689-B46E64E42E53}', arg_value = 0 }, --R-27T
                { CLSID = '{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}', arg_value = 0 }, --R-27ET
                { CLSID = '{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}', arg_value = 0.45, Type = 1 }, --R-77
                BD3("{35B698AC-9FEF-4EC4-AD29-484A0085F62B}"),--BetAB-500
                BD3("{BD289E34-DF84-4C5E-9220-4B14C346E79D}"),--BetAB-500ShP
                BD3('{37DCC01E-9E02-432F-B61D-10C166CA2798}'), --FAB-500 M62
                BD3('{3C612111-C7AD-476E-8A8E-2485812F4E5C}'),--FAB-250
                --BD3("{96A7F676-F956-404A-AD04-F33FB2C74884}"), --KMGU-2 - 96 AO-2.5RT
                --BD3("{96A7F676-F956-404A-AD04-F33FB2C74881}"), --KMGU-2 - 96 PTAB-2.5KO
                BD3("{4203753F-8198-4E85-9924-6F8FF679F9FF}"),--RBK-250 PTAB-2.5M
                BD3("{RBK_250_275_AO_1SCH}"),                -- RBK-250-275 AO-1SCh
                BD3("{D5435F26-F120-4FA3-9867-34ACE562EF1B}"),--RBK-500 PTAB-10-5
                BD3("{7AEC222D-C523-425e-B714-719C0D1EB14D}"),--RBK-500 PTAB-1M
                BD3("{RBK_500U_OAB_2_5RT}"),                --RBK-500U OAB-2.5RT
                MBD("{F99BEC1A-869D-4AC7-9730-FBA0E3B1F5FC}"),--MER*6 FAB-100
                MBD("{53BE25A4-C86C-4571-9BC0-47D668349595}"),-- 6 * FAB-250
                BD3("{0511E528-EA28-4caf-A212-00D1408DF10A}"), --SAB-100
                BD3("{FC56DF80-9B09-44C5-8976-DCFAFF219062}"), --B-13L - 5 S-13 OF
                BD3("{A0648264-4BC0-4EE8-A543-D119F6BA4257}"), --S-25 OFM
                BD3("{F72F47E5-C83A-4B85-96ED-D3E46671EE9A}"), --B-8M1 - 20 S-8KOM
                BD3("{3DFB7320-AB0E-11d7-9897-000476191836}"), --B-8M1 - 20 S-8TsM
                BD3("B-8M1 - 20 S-8OFP2"),--B-8M1 - 20 S-8OFP2

                -- twin pylon
                { CLSID = '{FAB_250_DUAL_R}', arg_value = 1.0 }, --
                { CLSID = '{FAB_500_DUAL_R}', arg_value = 1.0 }, --
                { CLSID = '{RBK_250_PTAB25M_DUAL_R}', arg_value = 1.0 }, --
                { CLSID = '{RBK_500_PTAB105_DUAL_R}', arg_value = 1.0 },
                { CLSID = '{B13_5_S13OF_DUAL_R}', arg_value = 1.0 }, --
                { CLSID = '{B8M1_20_S8KOM_DUAL_R}', arg_value = 1.0 }, --
                { CLSID = '{B8M1_20_S8TsM_DUAL_R}', arg_value = 1.0 }, --
                { CLSID = '{B8M1_20_S8OFP2_DUAL_R}', arg_value = 1.0 }, --
                { CLSID = '{S25_DUAL_R}', arg_value = 1.0 }, --
            }
        ),
        pylon(9, 0, -2.535000, -0.165000, 6.168000,
            {arg = 316, arg_value = 0, use_full_connector_position = true,},
            {
                { CLSID = '{FBC29BFE-3D24-4C64-B81D-941239D12249}', arg_value = 0 }, --R-73
                --{ CLSID = '{PL-8}', arg_value = 0 },  --PL-8
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B1}" }, --Smoke Generator - red
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B2}" }, --Smoke Generator - green
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B3}" }, --Smoke Generator - blue
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B4}" }, --Smoke Generator - white
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B5}" }, --Smoke Generator - yellow
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B6}" }, --Smoke Generator - orange
            }
        ),
        pylon(10, 0, -1.943000, 0.173000, 7.280000,
            {arg = 317, arg_value = 0, use_full_connector_position = true,},
            {
                { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}" }, --R-73
                { CLSID = '{RKL609_R}', arg = 317, arg_value = 1, required = {{station = 1, loadout = {'{RKL609_L}'},}} },--Sorbciya

                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B1}" }, --Smoke Generator - red
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B2}" }, --Smoke Generator - green
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B3}" }, --Smoke Generator - blue
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B4}" }, --Smoke Generator - white
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B5}" }, --Smoke Generator - yellow
                { CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B6}" }, --Smoke Generator - orange
            }
        ),
    },

    Tasks = {
        aircraft_task(CAP),
        aircraft_task(Intercept),
        aircraft_task(Escort),
        aircraft_task(FighterSweep),
        aircraft_task(AFAC),
        aircraft_task(CAS),
        aircraft_task(GroundAttack),
        aircraft_task(RunwayAttack),
        aircraft_task(AntishipStrike),
    },

    DefaultTask = aircraft_task(CAP),

    SFM_Data = {
        aerodynamics = {
            Cy0        = 0,
            Mzalfa     = 4.355,
            Mzalfadt   = 0.8,
            kjx        = 2.7,
            kjz        = 0.00125,
            Czbe       = -0.016,
            cx_gear    = 0.0268,
            cx_flap    = 0.063,
            cy_flap    = 0.42,
            cx_brk     = 0.06,
            table_data = {
            --      M     Cx0         Cya         B         B4          Omxmax    Aldop    Cymax
                {0.0,    0.0165,        0.077,        0.1,        0.032,      0.65,    25.0,    1.6,    },
                {0.2,    0.0165,        0.077,        0.1,        0.032,      1.95,    25.0,    1.6,    },
                {0.4,    0.0165,        0.077,        0.1,        0.032,      3.25,    25.0,    1.6,    },
                {0.6,    0.0165,        0.080,        0.094,      0.043,      4.55,    24.0,    1.5,    },
                {0.7,    0.0170,        0.083,        0.094,      0.045,      4.55,    23.0,    1.45,   },
                {0.8,    0.0178,        0.087,        0.094,      0.048,      4.55,    21.0,    1.4,    },
                {0.9,    0.0215,        0.091,        0.11,       0.050,      4.55,    20.0,    1.3,    },
                {1.0,    0.0310,        0.094,        0.15,       0.1,        4.55,    18.0,    1.2,    },
                {1.1,    0.0422,        0.094,        0.15,       0.1,        4.10,    16.0,    1.1,    },
                {1.2,    0.0440,        0.091,        0.14,       0.1,        3.19,    17.0,    1.05,   },
                {1.3,    0.0432,        0.085,        0.17,       0.096,      2.28,    15.0,    1.0,    },
                {1.5,    0.0423,        0.068,        0.23,       0.09,       1.95,    13.0,    0.9,    },
                {1.8,    0.0416,        0.051,        0.23,       0.38,       1.17,    12.0,    0.7,    },
                {2.0,    0.0416,        0.043,        0.08,       2.5,        1.04,    10.5,    0.55,   },
                {2.2,    0.0416,        0.037,        0.16,       3.2,        0.91,     9.0,    0.4,    },
                {2.5,    0.0410,        0.036,        0.25,       4.5,        0.91,     9.0,    0.4,    },
                {3.9,    0.0395,        0.033,        0.35,       6.0,        0.8,      9.0,    0.4,    },
            }
        }, -- end of aerodynamics

        engine = {
            Nmg      = 67.5,
            MinRUD   = 0,
            MaxRUD   = 1,
            MaksRUD  = 0.85,
            ForsRUD  = 0.91,
            typeng   = 1,
            hMaxEng  = 19.5,
            dcx_eng  = 0.0124,
            cemax    = 1.24,
            cefor    = 2.56,
            dpdh_m   = 8000,
            dpdh_f   = 17000.0,
            table_data = {
            --   M        Pmax         Pfor
                {0.0,    126000,    185024},
                {0.2,    126000,    198744},
                {0.4,    126000,    208250},
                {0.6,    126000,    220892},
                {0.7,    124000,    226870},
                {0.8,    124000,    232887},
                {0.9,    122000,    250210},
                {1.0,    117000,    256120},
                {1.1,    113000,    265400},
                {1.2,    110000,    280300},
                {1.3,    102000,    298900},
                {1.5,     85000,    326000},
                {1.8,     30000,    350000},
                {2.0,     19000,    363000},
                {2.2,     17000,    384000},
                {2.5,     12000,    415000},
                {3.9,     10000,    260476},
            },
        }, -- end of engine
    },

    Damage = {
        [0]  = {critical_damage = 5,  args = {146}},
        [1]  = {critical_damage = 3,  args = {296}},
        [2]  = {critical_damage = 3,  args = {297}},
        [3]  = {critical_damage = 8,  args = {65} },
        [4]  = {critical_damage = 2,  args = {298}},
        [5]  = {critical_damage = 2,  args = {301}},
        [7]  = {critical_damage = 2,  args = {249}},
        [8]  = {critical_damage = 2,  args = {265}},
        [9]  = {critical_damage = 3,  args = {154}},
        [10] = {critical_damage = 3,  args = {153}},
        [11] = {critical_damage = 1,  args = {167}},
        [12] = {critical_damage = 1,  args = {161}},
        [13] = {critical_damage = 2,  args = {169}},
        [14] = {critical_damage = 2,  args = {163}},
        [15] = {critical_damage = 2,  args = {267}},
        [16] = {critical_damage = 2,  args = {266}},
        [17] = {critical_damage = 2,  args = {168}},
        [18] = {critical_damage = 2,  args = {162}},
        [20] = {critical_damage = 1,  args = {183}},
        [23] = {critical_damage = 5,  args = {223}},
        [24] = {critical_damage = 5,  args = {213}},
        [27] = {critical_damage = 3,  args = {231}},
        [28] = {critical_damage = 3,  args = {221}},
        [29] = {critical_damage = 6,  args = {224}, deps_cells = {23}},
        [30] = {critical_damage = 6,  args = {214}, deps_cells = {24}},
        [35] = {critical_damage = 6,  args = {225}, deps_cells = {23, 29, 27, 37}},
        [36] = {critical_damage = 6,  args = {215}, deps_cells = {24, 30, 28, 38}},
        [37] = {critical_damage = 2,  args = {228}},
        [38] = {critical_damage = 2,  args = {218}},
        [39] = {critical_damage = 2,  args = {244}},
        [40] = {critical_damage = 2,  args = {241}},
        [43] = {critical_damage = 2,  args = {243}, deps_cells = {39, 53}},
        [44] = {critical_damage = 2,  args = {242}, deps_cells = {40, 54}},
        [51] = {critical_damage = 2,  args = {240}},
        [52] = {critical_damage = 2,  args = {238}},
        [53] = {critical_damage = 2,  args = {248}},
        [54] = {critical_damage = 2,  args = {247}},
        [55] = {critical_damage = 2,  args = {159}},
        [58] = {critical_damage = 2,  args = {156}},
        [59] = {critical_damage = 2,  args = {148}},
        [82] = {critical_damage = 2,  args = {152}},
        [83] = {critical_damage = 3,  args = {134}}, -- nose wheel
        [84] = {critical_damage = 3,  args = {136}}, -- left wheel
        [85] = {critical_damage = 3,  args = {135}}, -- right wheel

    },

    Failures = {
        { id = 'asc',       label = _('Su27 ASC'),            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'autopilot', label = _('Su27 AUTOPILOT'),      enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'hydro',     label = _('HYDRO'),               enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'l_engine',  label = _('L-ENGINE'),            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'r_engine',  label = _('R-ENGINE'),            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'radar',     label = _('RADAR'),               enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'eos',       label = _('EOS'),                 enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'helmet',    label = _('HELMET'),              enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'rws',       label = _('RWS'),                 enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ecm',       label = _('ECM'),                 enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'hud',       label = _('HUD'),                 enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'mfd',       label = _('MFD'),                 enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
    },

    DamageParts = {
        [1] = 'J-11A-OBLOMOK-WING-R', --
        [2] = 'J-11A-OBLOMOK-WING-L', --
    },

    lights_data = {
        typename = 'collection',
        lights = {
            [WOLALIGHT_STROBES] = {
                typename = "collection",
                lights = {
                    {
                        typename = "natostrobelight", position = {-7.414241, -0.274914, 0.082471}, argument = 199,
                        proto = { -- strobe lamp, white
                            color = {1.0, 1.0, 1.0, 0.012 * math.sqrt(1000)}, range = 48.0, angle_max = math.rad(180.0), angle_min = math.rad(180.0),
                            controller = "Strobe", period = 1.33333,
                        },
                    },
                }
            },
            [WOLALIGHT_SPOTS] = {
                typename = 'collection',
                lights = {
                    {typename = 'argumentlight', argument = 208},
                },
            },
            [WOLALIGHT_NAVLIGHTS] = {
                typename = 'collection',
                lights = {
                    { -- left tip
                        typename = 'argumentlight',
                        argument = 190,
                    },
                    { -- right tip
                        typename = 'argumentlight',
                        argument = 191,
                    },
                    { -- left tail
                        typename = 'argumentlight',
                        argument = 192,
                    },
                },
            },
            [WOLALIGHT_FORMATION_LIGHTS] = {
                typename = 'argumentlight', argument = 200,
                --[[typename = 'collection',
                lights = {
                    {typename = 'argumentlight', argument = 200,},
                },]]
            },
            [WOLALIGHT_TAXI_LIGHTS] = {
                typename = 'collection',
                lights = {
                    {typename = 'argumentlight', argument = 209},
                },
            },
        }, -- end of lights_data.lights
    }, -- end lights_data
}

add_aircraft(J11A)

dofile(current_mod_path.."/Entries/Aircrafts/Views/J-11A.lua")
make_view_settings('J-11A', ViewSettings, SnapViews)