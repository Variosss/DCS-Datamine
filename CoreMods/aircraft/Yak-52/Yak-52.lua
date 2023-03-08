-- Setting up model container
mount_vfs_model_path(current_mod_path .. "/Shapes")
mount_vfs_texture_path(current_mod_path .. "/Textures")
mount_vfs_liveries_path (current_mod_path .. "/Liveries")
-- end of Setting up model container



-- Declaring aircraft
Yak52 = {

    Name                = 'Yak-52',
    DisplayName         = _('Yak-52'),
    date_of_introduction = 1979.00,
    country_of_origin   = "RUS",

--    HumanCockpit        = true,
--    HumanCockpitPath    = current_mod_path..'/Cockpit/',
    Picture             = "Yak-52.png",
    Rate                = 20, -- RewardPoint in Multiplayer -- TODO evaluate - Made Dragon
    Shape               = "Yak-52",
    XRayShape           = "Yak-52_X-Ray",
    propellorShapeType  = '3ARG',

    shape_table_data    = {
        {
            file        = 'Yak-52';
            life        = 18; -- life bar -- TODO evaluate - Made Dragon
            vis         = 3; -- visibility gain -- TODO evaluate - Made Dragon
            desrt       = 'Bf-109K-4_oblomki'; -- Name of destroyed object file name -- TODO replace - Made Dragon
            fire        = {300, 2}; -- Fire on the ground after destroyed: 300sec 2m -- TODO evaluate - Made Dragon
            username    = 'Yak-52';
            index       = WSTYPE_PLACEHOLDER;
            classname   = "lLandPlane";
            positioning = "BYNORMAL";
            drawonmap = true;
        },
        {
            name = "Bf-109K-4_oblomki"; -- TODO replace - Made Dragon
            file = "Bf-109K-4_oblomki"; -- TODO replace - Made Dragon
            fire = {240, 2};
        },
    },

    mapclasskey = "P0091000026",  -- ref. MissionEditor/data/NewMap/images/nato/P91000024.png
    attribute   = {wsType_Air, wsType_Airplane, wsType_Cruiser, WSTYPE_PLACEHOLDER, "UAVs",},
    Categories  = {},



    -----------------------------------------------------------------------------------------------



    M_empty         = 1229.0, -- kg
    M_nominal       = 1315.0, -- kg
    M_max           = 1315.0, -- kg
    M_fuel_max      = 122.0 * 0.72, -- kg
    H_max           = 4000.0, -- m
    average_fuel_consumption = 0.009042, -- this is highly relative, but good estimates are 36-40l/min = 28-31kg/min = 0.47-0.52kg/s -- 45l/min = 35kg/min = 0.583kg/s
    CAS_min         = 180, -- if this is not OVERALL FLIGHT TIME, but just LOITER TIME, than it should be 10-15 minutes.....CAS capability in minute (for AI)
    V_opt           = 190.0 / 3.6,-- Cruise speed (for AI)
    V_take_off      = 120.0 / 3.6, -- Take off speed in m/s (for AI)
    V_land          = 120.0 / 3.6, -- Land speed in m/s (for AI)
    V_max_sea_level = 270.0 / 3.6, -- Max speed at sea level in m/s (for AI)
    V_max_h         = 270.0 / 3.6, -- Max speed at max altitude in m/s (for AI)
    Vy_max          = 4.444, -- Max climb speed in m/s (for AI)
    Mach_max        = 0.3524, -- Max speed in Mach (for AI)
    Ny_min          = -5.0, -- Min G (for AI)
    Ny_max          = 7.0, -- Max G (for AI)
    Ny_max_e        = 7.0, -- Max G (for AI)
    AOA_take_off    = 0.157, -- AoA in take off (for AI) -- TODO evaluate - Made Dragon
    bank_angle_max  = 60, -- Max bank angle (for AI) -- TODO evaluate - Made Dragon

    has_afteburner  = false, -- AFB yes/no
    has_speedbrake  = false, -- Air brake yes/no
    has_differential_stabilizer = false, -- Differential stabilizers yes/no
    flaps_transmission = "Pneumatic",
    undercarriage_transmission = "Pneumatic",
    doors_transmission = "Mechanical",
    doors_movement = 2,

    tand_gear_max   = 0.577, -- tang(a) <- a = steering angle -- TODO evaluate - Made Dragon

    nose_gear_pos                            = {0.803, -1.526, 0.0}, -- Central gear coordinates
    nose_gear_amortizer_direct_stroke        = 0.0,
    nose_gear_amortizer_reversal_stroke      = -0.15,
    nose_gear_amortizer_normal_weight_stroke = -0.15+0.147,
    nose_gear_wheel_diameter                 = 0.400,

    main_gear_pos                            = {-1.042, -1.455, 1.392}, -- Main gear coordinates
    main_gear_amortizer_direct_stroke        = 0.0,
    main_gear_amortizer_reversal_stroke      = -0.294,
    main_gear_amortizer_normal_weight_stroke = -0.294+0.285,
    main_gear_wheel_diameter                 = 0.5, -- TODO evaluate - Made Dragon

    wing_area       = 15.0, -- Wing area in m2
    wing_span       = 9.3, -- Wing span in metres
    wing_type       = 0, -- 0 = Fixed wing
                         -- 1 = Variable geometry
                         -- 2 = Fold-able wing
    thrust_sum_max  = 3000.0, -- Thrust in kg (44kN) -- TODO evaluate - Made Dragon
    thrust_sum_ab   = 3000.0, -- Thrust in kg (71kN) -- TODO evaluate - Made Dragon
    length          = 7.745, -- Full length in m
    height          = 2.7, -- Height in m
    flaps_maneuver  = 0.0, -- Max flaps in take-off and manoeuvre (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
    range           = 465, -- Max range in km (for AI)
    RCS             = 2.5, -- Radar Cross Section m2 -- TODO evaluate - Made Dragon
    IR_emission_coeff = 0.1, -- Normal engine -- IR_emission_coeff = 1.0 @ Su-27 without afterburner. It is a reference value. -- TODO evaluate - Made Dragon
    IR_emission_coeff_ab = 0, -- Same with afterburner
    wing_tip_pos    = {0.237 - 1.0, -0.088, 5.6 + 0.2}, -- Wing tip coordinates for visual effects -- TODO evaluate - Made Dragon
    nose_gear_wheel_diameter = 0.319, -- in m -- TODO evaluate - Made Dragon
    main_gear_wheel_diameter = 0.683, -- in m -- TODO evaluate - Made Dragon
    brakeshute_name = 0, -- Landing - brake chute visual shape after separation

    engines_count = 1, -- Engines count
    engines_nozzles = {
        [1] = {
            pos                 = {1.97, -0.09,-0.56}, -- Nozzle coordinates -- TODO evaluate - Made Dragon
            elevation           = 0, -- AFB cone elevation -- TODO evaluate - Made Dragon
            diameter            = 0 * 0.1, -- AFB cone diameter -- TODO evaluate - Made Dragon
            exhaust_length_ab   = -3.0, -- Length in m -- TODO evaluate - Made Dragon
            exhaust_length_ab_K = 0.3, -- AB animation -- TODO evaluate - Made Dragon
            engine_number       = 1, -- Both to first engine -- TODO evaluate - Made Dragon
        }, -- end of [1]
        [2] = {
            pos                 = {1.97, -0.09, 0.56}, -- Nozzle coordinates -- TODO evaluate - Made Dragon
            elevation           = 0, -- AFB cone elevation -- TODO evaluate - Made Dragon
            diameter            = 0 * 0.1, -- AFB cone diameter -- TODO evaluate - Made Dragon
            exhaust_length_ab   = -3.0, -- Length in m -- TODO evaluate - Made Dragon
            exhaust_length_ab_K = 0.3, -- AB animation -- TODO evaluate - Made Dragon
            engine_number       = 1, -- Both to first engine -- TODO evaluate - Made Dragon
        }, -- end of [2]
    }, -- end of engines_nozzles

    crew_members = {
        [1] = {
            pilot_name          = "pilot_raf", -- TODO evaluate - Made Dragon
            pos                 = {-0.39, -0.1, 0.0},
			can_be_playable 	 = true,
			role 				 = "pilot",
			role_display_name    = _("Pilot"),
            canopy_pos          = {-1.203,  0.658, 0}, -- TODO evaluate - Made Dragon
            canopy_arg          = 38,
            ejection_seat_name  = 0,
            ejection_order      = 0,
            drop_canopy_name    = 0,
            drop_parachute_name = "pilot_raf_parachute", -- TODO evaluate - Made Dragon
            canopy_args = {38, 6.0, 421, 0.4},
        }, -- end of [1]
        [2] = {
            pilot_name          = "pilot_raf", -- TODO evaluate - Made Dragon
            pos                 = {-1.72, -0.1, 0.0},
			can_be_playable 	 = true,
			role 				 = "instructor",
			role_display_name    = _("Instructor pilot"),
            canopy_pos          = {-2.203,  0.658, 0}, -- TODO evaluate - Made Dragon
            canopy_arg          = 421,
            pilot_body_arg      = 472,
            ejection_seat_name  = 0,
            ejection_order      = 1,
            drop_canopy_name    = 0,
            drop_parachute_name = "pilot_raf_parachute", -- TODO evaluate - Made Dragon
            canopy_args = {38, 0.4, 421, 6.0},
        }, -- end of [2]
    }, -- end of crew_members

    fires_pos = { -- TODO deprecate w/ x-ray - Made Dragon
        [1] = {0.0, 0.5, 0.0}, -- Fuselage -- TODO evaluate - Made Dragon
        --[2] = {-0.6, -0.3, 0.95}, -- Wing R In
        --[3] = {-0.6, -0.3, -0.95},-- Wing L In
        --[4] = {-0.7, -0.25, 2.2}, -- Wing R Mid
        --[5] = {-0.7, -0.25, -2.2}, -- Wing L Mid
        --[6] = {-0.9, -0.18, 4.4}, -- Wing R Out
        --[7] = {-0.9, -0.18, -4.4}, -- Wing L Out
        [8] = {1.7, -0.1, 0.1}, -- Engine R In -- TODO evaluate - Made Dragon
        [9] = {1.7, -0.1, -0.1}, -- Engine L In -- TODO evaluate - Made Dragon
        --[10] = {0.2, 0.1, 0.1}, -- Engine R Out
        --[11] = {0.2, 0.1, -0.1}, -- Engine L Out
    }, -- end of fires_pos

    -- Countermeasures
    SingleChargeTotal   = 0,
    CMDS_Incrementation = 0,
    ChaffDefault        = 0,
    ChaffChargeSize     = 0,
    FlareDefault        = 0,
    FlareChargeSize     = 0,
    CMDS_Edit           = false,



    mechanimations = {
        Door0 = {
            {Transition = {"Close", "Open"},   Sequence = {{C = {{"PosType", 6}, {"Sleep", "for", 2.0}}},     {C = {{"Arg", 414, "to", 1.0, "in", 0.303}}},     {C = {{"VelType", 0}, {"Arg", 38, "to", 0.9, "at", 0.7}}},       {C = {{"Arg", 414, "to", 0.0, "in", 0.147}}},     {C = {{"PosType", 6}, {"Sleep", "for", 3.0}}}},     Flags = {"Reversible"}},
            {Transition = {"Open", "Close"},   Sequence = {{C = {{"PosType", 6}, {"Sleep", "for", 2.0}}},     {C = {{"Arg", 414, "to", 0.0, "in", 0.147}}},     {C = {{"VelType", 0}, {"Arg", 38, "to", 0.0, "at", 0.7}}},       {C = {{"Arg", 414, "to", 1.0, "in", 0.303}}},     {C = {{"PosType", 6}, {"Sleep", "for", 3.0}}}},     Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Close", "Taxi"},   Sequence = {{C = {{"PosType", 6}, {"Sleep", "for", 2.0}}},     {C = {{"Arg", 414, "to", 1.0, "in", 0.303}}},     {C = {{"VelType", 0}, {"Arg", 38, "to", 0.121, "at", 0.7}}},     {C = {{"Arg", 414, "to", 0.0, "in", 0.147}}},     {C = {{"PosType", 6}, {"Sleep", "for", 3.0}}}},     Flags = {"Reversible"}},
            {Transition = {"Taxi", "Close"},   Sequence = {{C = {{"PosType", 6}, {"Sleep", "for", 2.0}}},     {C = {{"Arg", 414, "to", 0.0, "in", 0.147}}},     {C = {{"VelType", 0}, {"Arg", 38, "to", 0.0, "at", 0.7}}},       {C = {{"Arg", 414, "to", 1.0, "in", 0.303}}},     {C = {{"PosType", 6}, {"Sleep", "for", 3.0}}}},     Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Open", "Taxi"},    Sequence = {{C = {{"PosType", 6}, {"Sleep", "for", 2.0}}},     {C = {{"Arg", 414, "to", 1.0, "in", 0.303}}},     {C = {{"VelType", 0}, {"Arg", 38, "to", 0.121, "at", 0.7}}},     {C = {{"Arg", 414, "to", 0.0, "in", 0.147}}},     {C = {{"PosType", 6}, {"Sleep", "for", 3.0}}}},     Flags = {"Reversible"}},
            {Transition = {"Taxi", "Open"},    Sequence = {{C = {{"PosType", 6}, {"Sleep", "for", 2.0}}},     {C = {{"Arg", 414, "to", 0.0, "in", 0.147}}},     {C = {{"VelType", 0}, {"Arg", 38, "to", 0.9, "at", 0.7}}},       {C = {{"Arg", 414, "to", 1.0, "in", 0.303}}},     {C = {{"PosType", 6}, {"Sleep", "for", 3.0}}}},     Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Open", "Bailout"}, Sequence = {{C = {{"Sleep", "for", 0.0}}}}},
        },
        Door1 = {
            {Transition = {"Close", "Open"},   Sequence = {{C = {{"PosType", 7}, {"Sleep", "for", 6.6}}},     {C = {{"Arg", 415, "to", 1.0, "in", 0.303}}},     {C = {{"VelType", 2}, {"Arg", 421, "to", 0.9, "at", 0.7}}},      {C = {{"Arg", 415, "to", 0.0, "in", 0.147}}},     {C = {{"PosType", 7}, {"Sleep", "for", 6.6}}}},     Flags = {"Reversible"}},
            {Transition = {"Open", "Close"},   Sequence = {{C = {{"PosType", 7}, {"Sleep", "for", 6.6}}},     {C = {{"Arg", 415, "to", 0.0, "in", 0.147}}},     {C = {{"VelType", 2}, {"Arg", 421, "to", 0.0, "at", 0.7}}},      {C = {{"Arg", 415, "to", 1.0, "in", 0.303}}},     {C = {{"PosType", 7}, {"Sleep", "for", 6.6}}}},     Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Close", "Taxi"},   Sequence = {{C = {{"PosType", 7}, {"Sleep", "for", 6.6}}},     {C = {{"Arg", 415, "to", 1.0, "in", 0.303}}},     {C = {{"VelType", 2}, {"Arg", 421, "to", 0.121, "at", 0.7}}},    {C = {{"Arg", 415, "to", 0.0, "in", 0.147}}},     {C = {{"PosType", 7}, {"Sleep", "for", 6.6}}}},     Flags = {"Reversible"}},
            {Transition = {"Taxi", "Close"},   Sequence = {{C = {{"PosType", 7}, {"Sleep", "for", 6.6}}},     {C = {{"Arg", 415, "to", 0.0, "in", 0.147}}},     {C = {{"VelType", 2}, {"Arg", 421, "to", 0.0, "at", 0.7}}},      {C = {{"Arg", 415, "to", 1.0, "in", 0.303}}},     {C = {{"PosType", 7}, {"Sleep", "for", 6.6}}}},     Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Open", "Taxi"},    Sequence = {{C = {{"PosType", 7}, {"Sleep", "for", 6.6}}},     {C = {{"Arg", 415, "to", 1.0, "in", 0.303}}},     {C = {{"VelType", 2}, {"Arg", 421, "to", 0.121, "at", 0.7}}},    {C = {{"Arg", 415, "to", 0.0, "in", 0.147}}},     {C = {{"PosType", 7}, {"Sleep", "for", 6.6}}}},     Flags = {"Reversible"}},
            {Transition = {"Taxi", "Open"},    Sequence = {{C = {{"PosType", 7}, {"Sleep", "for", 6.6}}},     {C = {{"Arg", 415, "to", 0.0, "in", 0.147}}},     {C = {{"VelType", 2}, {"Arg", 421, "to", 0.9, "at", 0.7}}},      {C = {{"Arg", 415, "to", 1.0, "in", 0.303}}},     {C = {{"PosType", 7}, {"Sleep", "for", 6.6}}}},     Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Open", "Bailout"}, Sequence = {{C = {{"Sleep", "for", 0.0}}}}},
        },
    },



--    net_animation = {
--        43, -- side door
--    },  



    -- Sensors
    detection_range_max     = 0,
    radar_can_see_ground    = false, -- This should be examined (what is this exactly?) ??? -- TODO evaluate - Made Dragon
    CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_BAD, LOOK_AVERAGE, LOOK_AVERAGE),
    Sensors = {
        OPTIC = "Merkury LLTV", -- For night goggles imitation
    },



    HumanRadio = {
        frequency = 132.0,
        editable = true,
        minFrequency = 118.000,
        maxFrequency = 136.975,
        modulation = MODULATION_AM
    },
    panelRadio = {
        {
            ID = "ARK-15M",
            name = _("ARK-15M"),
            displayUnits = "kHz",
            range = {min = 0.100, max = 1.795},
            channels = {
                [1] = { name = _("Channel 1, Outer"),       default = 0.625,    modulation = _("AM")},  -- Krasnodar-Center
                [2] = { name = _("Channel 1, Inner"),       default = 0.303,    modulation = _("AM")},  -- Krasnodar-Center
                [3] = { name = _("Channel 2, Outer"),       default = 0.289,    modulation = _("AM")},  -- Maykop
                [4] = { name = _("Channel 2, Inner"),       default = 0.591,    modulation = _("AM")},  -- Maykop
                [5] = { name = _("Channel 3, Outer"),       default = 0.408,    modulation = _("AM")},  -- Krymsk
                [6] = { name = _("Channel 3, Inner"),       default = 0.803,    modulation = _("AM")},  -- Krymsk
                [7] = { name = _("Channel 4, Outer"),       default = 0.443,    modulation = _("AM")},  -- Anapa
                [8] = { name = _("Channel 4, Inner"),       default = 0.215,    modulation = _("AM")},  -- Anapa
            }
        },
    },



    -- Guns
    Guns = nil,

    Pylons = {
        pylon(
            1, -- pylon index
            2, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
            0.5 * (0.887 + 0.913), 0.5 * (-0.573 -0.532), 0.0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
            {
                connector = "disable",
                DisplayName = _("SMK")
            },
            add_smokes(
                nil,
                nil,
                {
                    "{INV-SMOKE-RED}",    -- Smoke Generator - red
                    "{INV-SMOKE-GREEN}",  -- Smoke Generator - green
                    "{INV-SMOKE-BLUE}",   -- Smoke Generator - blue
                    "{INV-SMOKE-WHITE}",  -- Smoke Generator - white
                    "{INV-SMOKE-YELLOW}", -- Smoke Generator - yellow
                    "{INV-SMOKE-ORANGE}"  -- Smoke Generator - orange
                }
            )
        ),
    },



    -- Tasks
    Tasks = {
        aircraft_task(CAP),
        aircraft_task(Escort),
        aircraft_task(AFAC),
    },
    DefaultTask = aircraft_task(AFAC),



    -- SFM Data
    SFM_Data = {
        aerodynamics = { -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
            Cy0         = 0.1, -- zero AoA lift coefficient
            Mzalfa      = 4.355, -- coefficients for pitch agility
            Mzalfadt    = 0.8, -- coefficients for pitch agility
            kjx         = 2.25,
            kjz         = 0.00125,
            Czbe        = -0.016, -- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
            cx_gear     = 0.0277, -- coefficient, drag, gear
            cx_flap     = 0.095, -- coefficient, drag, full flaps
            cy_flap     = 0.45, -- coefficient, normal force, lift, flaps
            cx_brk      = 0.06, -- coefficient, drag, breaks
            table_data  = 
            {   --      M       Cx0         Cya         B       B4      Omxmax  Aldop       Cymax
                    {   0.0,    0.0242, 0.10,       0.0634,     0.0,    0.15,   20.0,       1.58,   },
                    {   0.2,    0.0242, 0.10,       0.0634,     0.0,    1.606,  20.0,       1.58,   },
                    {   0.342,  0.0245, 0.0787,     0.061,      0.017,  2.353,  18.0,       1.3,    },
                    {   0.5,    0.0263, 0.0770,     0.057,      0.025,  1.145,  16.0,       0.95,   },
                    {   0.59,   0.0268, 0.0768,     0.0514,     0.026,  0.761,  15.0,       0.75,   },
                    {   0.67,   0.0331, 0.0784,     0.047,      0.021,  0.384,  14.5,       0.62,   },
                    {   0.74,   0.0465, 0.0848,     0.08,       0.16,   0.206,  10.0,       0.46,   },
                    {   0.76,   0.0527, 0.0813,     0.1,        0.25,   0.133,  9.0,        0.42,   },
                    {   0.8,    0.0737, 0.0695,     0.2,        0.36,   0.077,  6.0,        0.38,   },
                    {   0.83,   0.1006, 0.0993,     0.34,       2.4,    0.063,  4.5,        0.3,    },
                    {   0.9,    0.1470, 0.073,      0.56,       3.0,    0.042,  3.0,        0.2,    },
                }, -- end of table_data
            -- M - Mach number
            -- Cx0 - Coefficient, drag, profile, of the airplane
            -- Cya - Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. Inversely proportional to the available G-loading at any Mach value. (lower the Cya value, higher G available) per 1 degree AOA
            -- B - Polar quad coeff
            -- B4 - Polar 4th power coeff
            -- Omxmax - roll rate, rad/s
            -- Aldop - Alfadop Max AOA at current M - departure threshold
            -- Cymax - Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)
        }, -- end of aerodynamics
        engine = {
            Nominal_RPM = 2920,
            Nmg     = 24.027, -- RPM at idle
            MinRUD  = 0, -- Min state of the throttle
            MaxRUD  = 1, -- Max state of the throttle
            MaksRUD = 1, -- Military power state of the throttle
            ForsRUD = 1, -- Afterburner state of the throttle
            type    = "Radial",
            cylinder_firing_order = {1, 3, 5, 7, 9, 2, 4, 6, 8},
            Startup_Prework = 58.0,

            hMaxEng = 12.5, -- Max altitude for safe engine operation in km
            dcx_eng = 0.015, -- Engine drag coefficient
            cemax   = 0.37, -- not used for fuel calculation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
            cefor   = 0.37, -- not used for fuel calculation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
            dpdh_m  = 1800, -- altitude coefficient for max thrust
            dpdh_f  = 1800, -- altitude coefficient for AB thrust
            k_adiab_1           = 0.037923,
            k_adiab_2           = 0.0562,
            MAX_Manifold_P_1    = 155774,       
            MAX_Manifold_P_2    = 206570,       
            MAX_Manifold_P_3    = 226648,       
            k_after_cool        = 0.54,
            Displ               = 27,
            k_Eps               = 6,
            Stroke              = 0.152,
            V_pist_0            = 12,
            Nu_0                = 1.2,
            Nu_1                = 0.9,
            Nu_2                = 0.001,
            N_indic_0           = 1023040,
            N_fr_0              = 0.072,
            N_fr_1              = 0.02,
            Init_Mom            = 220,
            D_prop              = 3.28,
            MOI_prop            = 65,
            k_gearbox           = 2.096,
            P_oil               = 495438,
            k_boost             = 3,
            k_cfug              = 0.003,
            k_oil               = 0.00004,
            k_piston            = 3000,
            k_reg               = 0.003,
            k_vel               = 0.017,
            table_data = 
            {
            --   M          Pmax
                {0.0,       16620.0},
                {0.1,       15600.0},
                {0.2,       14340.0},
                {0.3,       13320.0},
                {0.4,       12230.0},
                {0.5,       11300.0},
                {0.6,       10600.0},
                {0.7,       10050.0},
                {0.8,        9820.0},
                {0.9,        5902.0},
                {1.9,        3469.0}
            },
            -- M - Mach number
            -- Pmax - Engine thrust at military power
            -- Pfor - Engine thrust at AFB
            --cylinder_firing_order = {1,3,4,2},
        }, -- end of engine
    },



    -- Damage, index meaning see in Scripts\Aircrafts\_Common\Damage.lua
    Damage = verbose_to_dmg_properties({
        -- TODO evaluate - Made Dragon
        -- TODO expand with sectioned wings and extra damage visuals - Made Dragon

        -- Propellor
        ["BLADE_1_IN"] = {
            critical_damage = 1,
            construction = {durability = 0.25, skin = "Aluminum"},
        },
        ["BLADE_2_IN"] = {
            critical_damage = 1,
            construction = {durability = 0.25, skin = "Aluminum"},
        },
        ["BLADE_3_IN"] = {
            critical_damage = 1,
            construction = {durability = 0.25, skin = "Aluminum"},
        },
        --

        -- Engine housing
        ["NOSE_LEFT_SIDE"] = {
            critical_damage = 2,
args = {150}, -- TODO remove on new xray
            children = {
                "NOSE_RIGHT_SIDE",
                "GEAR_F",
                --"WHEEL_F", -- TODO: remove w/ X-Ray - Made Dragon
            },
            construction = {durability = 1.2, skin = "Aluminum"},
            droppable = false,
            innards = {
                {id = "XEng0Case", skin = "CastIron", wall = 0.022},
                {id = "XEng0Heads", count = 9, skin = "CastIron", wall = 0.056},
                {id = "XEng0OilTank", skin = "Steel", wall = 0.003},
            },
        },
        ["NOSE_RIGHT_SIDE"] = {
            critical_damage = 2,
args = {149}, -- TODO remove on new xray
            construction = {durability = 1.2, skin = "Aluminum"},
            droppable = false,
        },
        --

        -- Fuselage
        ["FUSELAGE_BOTTOM"] = {
args = {152}, -- TODO remove on new xray
            critical_damage = 3,
            children = {
                "NOSE_LEFT_SIDE",
                "CABIN_LEFT_SIDE",
                "TAIL_LEFT_SIDE",
                "WING_L_IN",
                "WING_R_IN",
                --"GEAR_F", "WHEEL_F", "NOSE_RIGHT_SIDE", "CABIN_RIGHT_SIDE", "COCKPIT" -- TODO: remove w/ X-Ray - Made Dragon
            },
            construction = {durability = 0.9, skin = "Aluminum"},
            droppable = false,
        },
        ["CABIN_LEFT_SIDE"] = {
            critical_damage = 2, args = {154},
            children = {
                "CABIN_RIGHT_SIDE",
            },
            construction = {durability = 1.2, skin = "Aluminum"},
            droppable = false,
        },
        ["CABIN_RIGHT_SIDE"] = {
            critical_damage = 2, args = {153},
            children = {
                "COCKPIT",
            },
            construction = {durability = 1.2, skin = "Aluminum"},
            droppable = false,
        },
        --

        -- Cockpit
        ["COCKPIT"] = {
            critical_damage = 1, args = {189},
            construction = {durability = 1.0, skin = "Glass"},
            droppable = false,
            innards = {
                {id = "XCrew0"},
                {id = "XCrew0H", skin = "CastIron", wall = 0.150},
                {id = "XCrew1"},
                {id = "XCrew1H", skin = "CastIron", wall = 0.150},
            },
        },
        --

        -- Tail & Sporn
        ["TAIL_LEFT_SIDE"] = {
            critical_damage = 2, args = {158},
            children = {
                "TAIL_RIGHT_SIDE",
            },
            construction = {durability = 1.31, skin = "Aluminum"},
            droppable = false,
        },
        ["TAIL_RIGHT_SIDE"] = {
            critical_damage = 2, args = {157},
            children = {
                "TAIL",
            },
            construction = {durability = 1.31, skin = "Aluminum"},
            droppable = false,
        },
        ["TAIL"] = {
args = {159}, -- TODO remove on new xray
            critical_damage = 1,
            children = {
                "FIN_L_BOTTOM",
                "STABILIZER_L_IN",
                "STABILIZER_R_IN",
            },
            construction = {durability = 1.0, skin = "Aluminum"},
            droppable = false, -- TODO: remove w/ X-Ray - Made Dragon
            --detachable = {shape = "SpitfireIXc_oblomok_tail"},
        },
        --

        -- Keel & Rudder
        ["FIN_L_BOTTOM"] = {
            critical_damage = 1, args = {243},
            children = {"FIN_L_TOP"},
            construction = {durability = 0.4, skin = "Aluminum", spar = "FlangeBeam"},
            droppable = false, -- TODO: remove w/ X-Ray - Made Dragon
            --detachable = {shape = "SpitfireIXc_oblomok_tail"},
        },
        ["FIN_L_TOP"] = {
            critical_damage = 1, args = {242},
            children = {"RUDDER"},
            construction = {durability = 0.4, skin = "Aluminum", spar = "FlangeBeam"},
            droppable = false, -- TODO: remove w/ X-Ray - Made Dragon
            --detachable = {shape = "SpitfireIXc_oblomok_tail"},
        },
        ["RUDDER"] = {
            critical_damage = 1, args = {247},
            construction = {durability = 0.8, skin = "Fabric", spar = "Truss"},
            droppable = false, -- TODO: remove w/ X-Ray - Made Dragon
            --detachable = {shape = "SpitfireIXc_oblomok_tail"},
        },
        --

        -- Stabilizers & Elevators
        ["STABILIZER_L_IN"] = {
args = {236}, -- TODO remove on new xray
            critical_damage = 2,
            children = {
                "ELEVATOR_L_IN",
            },
            construction = {durability = 1.0, skin = "Aluminum", spar = "FlangeBeam"},
            droppable = false, -- TODO: remove w/ X-Ray - Made Dragon
            --detachable = {shape = "SpitfireIXc_oblomok_tail"},
        },
        ["ELEVATOR_L_IN"] = {
args = {240}, -- TODO remove on new xray
            critical_damage = 1,
            construction = {durability = 1.0, skin = "Fabric", spar = "Truss"},
            droppable = false, -- TODO: remove w/ X-Ray - Made Dragon
            --detachable = {shape = "SpitfireIXc_oblomok_tail"},
        },
        ["STABILIZER_R_IN"] = {
args = {234}, -- TODO remove on new xray
            critical_damage = 2,
            children = {
                "ELEVATOR_R_IN",
            },
            construction = {durability = 1.0, skin = "Aluminum", spar = "FlangeBeam"},
            droppable = false, -- TODO: remove w/ X-Ray - Made Dragon
            --detachable = {shape = "SpitfireIXc_oblomok_tail"},
        },
        ["ELEVATOR_R_IN"] = {
args = {238}, -- TODO remove on new xray
            critical_damage = 1,
            construction = {durability = 1.0, skin = "Fabric", spar = "Truss"},
            droppable = false, -- TODO: remove w/ X-Ray - Made Dragon
            --detachable = {shape = "SpitfireIXc_oblomok_tail"},
        },
        --

        -- Left Wing
        ["WING_L_IN"] = {
args = {225}, -- TODO remove on new xray
            critical_damage = 7,
            children = {
                "AILERON_L",
                "GEAR_L",
            },
            construction = {durability = 7.5, skin = "Aluminum", spar = "FlangeBeam", count = 2},
            droppable = false, -- TODO: remove w/ X-Ray - Made Dragon
            --detachable = {shape = "SpitfireIXc_oblomok_wing_l"},
            innards = {
                {id = "XFuelTank0", skin = "Aluminum", wall = 0.004, specific = "Aluminum"},
            },
        },
        ["AILERON_L"] = {
args = {226}, -- TODO remove on new xray
            critical_damage = 1,
            construction = {durability = 0.8, skin = "Fabric", spar = "Truss"},
            droppable = false, -- TODO: remove w/ X-Ray - Made Dragon
            --detachable = {shape = "SpitfireIXc_oblomok_wing_l"},
        },
        --

        -- Right Wing
        ["WING_R_IN"] = {
args = {215}, -- TODO remove on new xray
            critical_damage = 7,
            children = {
                "AILERON_R",
                "GEAR_R",
            },
            construction = {durability = 7.5, skin = "Aluminum", spar = "FlangeBeam", count = 2},
            droppable = false, -- TODO: remove w/ X-Ray - Made Dragon
            --detachable = {shape = "SpitfireIXc_oblomok_wing_r"},
            innards = {
                {id = "XFuelTank1", skin = "Aluminum", wall = 0.004, specific = "Aluminum"},
            },
        },
        ["AILERON_R"] = {
args = {216}, -- TODO remove on new xray
            critical_damage = 1,
            construction = {durability = 0.8, skin = "Fabric", spar = "Truss"},
            droppable = false, -- TODO: remove w/ X-Ray - Made Dragon
            --detachable = {shape = "SpitfireIXc_oblomok_wing_r"},
        },
        --

        -- Undercarriage
        ["GEAR_F"] = {
args = {253}, -- TODO remove on new xray
            critical_damage = 2,
            construction = {durability = 10.0, skin = "Steel", spar = "Rod"},
        },
        ["WHEEL_F"] = {
args = {136}, -- TODO remove on new xray
            critical_damage = 2,
            construction = {durability = 1.0, skin = "Rubber"},
        },
        ["GEAR_L"] = {
args = {259}, -- TODO remove on new xray
            critical_damage = 3,
            construction = {durability = 10.0, skin = "Steel", spar = "Rod"},
            detachable = {shape = "SpitfireIXc_oblomok_wing_l"},
        },
        ["WHEEL_L"] = {
args = {134}, -- TODO remove on new xray
            critical_damage = 3,
            construction = {durability = 1.0, skin = "Rubber"},
        },
        ["GEAR_R"] = {
args = {255}, -- TODO remove on new xray
            critical_damage = 3,
            construction = {durability = 10.0, skin = "Steel", spar = "Rod"},
            detachable = {shape = "SpitfireIXc_oblomok_wing_r"},
        },
        ["WHEEL_R"] = {
args = {135}, -- TODO remove on new xray
            critical_damage = 3,
            construction = {durability = 1.0, skin = "Rubber"},
        },
        --
    }),

    DamageParts = {
        [1] = "SpitfireIXc_oblomok_wing_r", -- wing R -- TODO evaluate - Made Dragon
        [2] = "SpitfireIXc_oblomok_wing_l", -- wing L -- TODO evaluate - Made Dragon
        --[3] = "", -- nose
        [4] = "SpitfireIXc_oblomok_tail", -- tail -- TODO evaluate - Made Dragon
    },



    AddPropAircraft = {
        {
            id = "SoloFlight",
            control = 'checkbox',
            label = _('Solo Flight'),
            defValue = false,
            weightWhenOn = -80,
            wCtrl = 150,
			arg = 472,
        },
        {
            id = 'PropellorType',
            control = 'comboList',
            label = _('Property.Yak52.PropellorType'),
            defValue = 0,
            arg = 1000,
            values = {
                {id = 0, dispName = _("2-Blade V530TA-D35"), value = 0.0},
                {id = 1, dispName = _("3-Blade MTV-9"), value = 1.0},
            },
            wCtrl = 150,
        },
        {
            id = "NetCrewControlPriority",
            control = 'comboList',
            label = _('Aircraft Control Priority'),
            playerOnly = true,
            defValue = 0,
            values = {
                {id = 0, dispName = _("Pilot")},
                {id = 1, dispName = _("Instructor")},
                {id = -1, dispName = _("Ask Always")},
                {id = -2, dispName = _("Equally Responsible")},
            },
            wCtrl = 150,
        },
    },



    Failures = { -- TODO evaluate - Made Dragon
        { id = 'CTRL_AILERON_ROD_DESTROYED',            label = _('Aileron control failure'),                           enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'CTRL_AILERON_ROD_MAJOR_DAMAGE',         label = _('Aileron control crippled'),                          enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'CTRL_AILERON_ROD_MINOR_DAMAGE',         label = _('Aileron control damaged'),                           enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'CTRL_ELEVATOR_ROD_DESTROYED',           label = _('Elevator control failure'),                          enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'CTRL_ELEVATOR_ROD_MAJOR_DAMAGE',        label = _('Elevator control crippled'),                         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'CTRL_ELEVATOR_ROD_MINOR_DAMAGE',        label = _('Elevator control damaged'),                          enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'CTRL_ELEVATOR_TRIM_FAILURE',            label = _('Trim drive failure'),                                enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'CTRL_RUDDER_ROD_DESTROYED',             label = _('Rudder control failure'),                            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'CTRL_RUDDER_ROD_MAJOR_DAMAGE',          label = _('Rudder control crippled'),                           enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'CTRL_RUDDER_ROD_MINOR_DAMAGE',          label = _('Rudder control damaged'),                            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'CTRL_COMPASS_DESTROYED',                label = _('Compass destroyed'),                                 enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

        { id = 'ELEC_BATTERY_OVERHEAT',                 label = _('Battery overheated'),                                enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ELEC_BATTERY_DESTROYED',                label = _('Battery failure'),                                   enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ELEC_GENERATOR_FAILURE',                label = _('Generator failure'),                                 enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ELEC_GENERATOR_REGULATOR_MALFUNCTION',  label = _('Regulator malfunction'),                             enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ELEC_BOOSTER_FUEL_PUMP_FAILURE',        label = _('Booster pump failure'),                              enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ELEC_BOOSTER_FUEL_PUMP_COIL_FAILURE',   label = _('Booster pump electrical malfunction'),               enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ELEC_UC_LAMP_CU_BULB_FAILURE',          label = _('Undercarriage indicator Up light bulb broken'),      enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ELEC_UC_LAMP_CD_BULB_FAILURE',          label = _('Undercarriage indicator Down light bulb broken'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ELEC_PITOT_HEAT_WIRING',                label = _('Pitot heating wire broken'),                         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ELEC_PITOT_HEAT_ELEMENT',               label = _('Pitot heating element burned out'),                  enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ELEC_RETICLE_BULB_FAILURE',             label = _('Reticle bulb broken'),                               enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ELEC_SUPERCHARGER_BULB_FAILURE',        label = _('Supercharger indicator bulb broken'),                enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ELEC_SUPERCHARGER_SOLENOID_FAILURE',    label = _('Supercharger solenoid failure'),                     enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ELEC_STARTER_LOOM_SEVERED',             label = _('Starter control wire broken'),                       enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ELEC_STARTER_SOLENOID_FAILURE',         label = _('Starter solenoid failure'),                          enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ELEC_STARTER_RELAY_FAILURE',            label = _('Starter relay failure'),                             enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ELEC_NAVLIGHT_RED_FAILURE',             label = _('LH nav. light failure'),                             enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ELEC_NAVLIGHT_GREEN_FAILURE',           label = _('RH nav. light failure'),                             enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ELEC_NAVLIGHT_WHITE_FAILURE',           label = _('Aft nav. light failure'),                            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

--        { id = 'FUEL_ENGINE0_FUEL_PUMP_FAILURE',           label = _('Motor fuel pump failure'),                           enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'FUEL_ENGINE0_FUEL_PUMP_DEGRADED',          label = _('Motor fuel pump crippled'),                          enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'FUEL_BOOSTER_FUEL_PUMP_DEGRADED',       label = _('Booster pump mechanical malfunction'),               enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'FUEL_DROPTANK_LINE_SEVERED',            label = _('Drop tank hose severed'),                            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'FUEL_MAIN_TANK_MINOR_LEAK',             label = _('Fuel tank minor leak'),                              enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'FUEL_MAIN_TANK_MAJOR_LEAK',             label = _('Fuel tank leak'),                                    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

--        { id = 'INST_VARIOMETR_DEPRESSURIZATION',       label = _('Variometer depressurization'),                       enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'INST_VARIOMETER_CLOGGED',               label = _('Variometer hose clogged'),                           enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'INST_SPEEDOMETER_DEPRESSURIZATION',     label = _('Speedometer depressurization'),                      enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'INST_PITOT_DAMAGE',                     label = _('Pitot damaged'),                                     enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'INST_TACH0_LOOM_SEVERED',               label = _('Tachometer circuit failure'),                        enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'INST_TACH0_POOR_CONNECTION',            label = _('Tachometer poor connection'),                        enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'INST_TACH0_RESISTANCE_MISMATCH',        label = _('Tachometer indicator adjustment fault'),             enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

        { id = 'PNEM_COMPRESSOR_FAILURE',               label = _('Pneumatic air compressor failure'),                  enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'PNEM_PRIMARY_CONTAINER_PERFORATED',     label = _('Primary air cylinder perforated'),                   enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'PNEM_SECONDARY_CONTAINER_PERFORATED',   label = _('Secondary air cylinder perforated'),                 enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'PNEM_ENGINE_HOSE_PERFORATED',           label = _('Master air hose perforated'),                        enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'PNEM_SUPERCHARGER_JACK_JAMMED',         label = _('Supercharger ram jammed'),                           enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'PNEM_RADIATOR_JACK_FAILURE',            label = _('Radiator jack failure'),                             enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'PNEM_LOW_PRS_JUNCTION_BOX_DESTROYED',   label = _('Air low pressure junction box destroyed'),           enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'PNEM_FLAPS_HOSE_PERFORATED',            label = _('Flaps hose perforated'),                             enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'PNEM_LH_FLAP_JACK_BUSTED',              label = _('Left flap jack busted'),                             enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'PNEM_RH_FLAP_JACK_BUSTED',              label = _('Right flap jack busted'),                            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'PNEM_MACHINE_GUNS_HOSE_PERFORATED',     label = _('Machine guns control hose perforated'),              enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'PNEM_CANNONS_HOSE_PERFORATED',          label = _('Cannons control hose perforated'),                   enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'PNEM_BRAKE_RELAY_MALFUNCTION',          label = _('Brake relay valve malfunction'),                     enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'PNEM_BRAKE_RELAY_FAILURE',              label = _('Brake relay valve failure'),                         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'PNEM_LH_BRAKE_HOSE_PERFORATED',         label = _('Left wheel brake hose perforated'),                  enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'PNEM_RH_BRAKE_HOSE_PERFORATED',         label = _('Right wheel brake hose perforated'),                 enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

        { id = 'ENG0_JAMMED',                           label = _('Engine destroyed'),                                  enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ENG0_MAGNETO0',                         label = _('Magneto No. 1 failure'),                             enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ENG0_MAGNETO1',                         label = _('Magneto No. 2 failure'),                             enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ENG0_GOVERNOR_MALFUNCTION',             label = _('Propeller governor malfunction'),                    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ENG0_GOVERNOR_FAILURE',                 label = _('Propeller governor failure'),                        enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ENG0_GOVERNOR_REGULATOR_MALFUNCTION',   label = _('Propeller governor regulator failure'),              enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ENG0_STARTER_CLUTCH_FAILURE',           label = _('Starter clutch failure'),                            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ENG0_STARTER_MOTOR_FAILURE',            label = _('Starter motor failure'),                             enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ENG0_BOOST_REGULATOR_MALFUNCTION',      label = _('Boost regulator malfunction'),                       enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ENG0_WATERRADIATOR0_PIERCED',           label = _('Port water radiator pierced'),                       enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ENG0_WATERRADIATOR1_PIERCED',           label = _('Starboard water radiator pierced'),                  enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--        { id = 'ENG0_OILRADIATOR0_PIERCED',             label = _('Oil radiator pierced'),                              enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
    },



    lights_data = {
        typename = "collection",
        lights = {
        }
    },



    ViewSettings = ViewSettings,
    SnapViews    = SnapViews,
}



-- Finalize
add_aircraft(Yak52)
