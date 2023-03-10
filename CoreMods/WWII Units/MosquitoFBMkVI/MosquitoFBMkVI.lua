local MOSQUITOFBMKVI = "MosquitoFBMkVI"

-- Setting up model container
mount_vfs_model_path(current_mod_path .. "/" .. MOSQUITOFBMKVI .. "/Shapes")
-- TODO TMP FIX w/ textures archive when ready - Made Dragon
mount_vfs_texture_path(current_mod_path .. "/" .. MOSQUITOFBMKVI .. "/Textures/" .. MOSQUITOFBMKVI)
mount_vfs_texture_path(current_mod_path .. "/" .. MOSQUITOFBMKVI .. "/Textures")
mount_vfs_liveries_path(current_mod_path .. "/" .. MOSQUITOFBMKVI .. "/Liveries")
-- end of Setting up model container



-- Defining 50 gal. slipper tank
declare_loadout({category = CAT_FUEL_TANKS, CLSID = "{MOSQUITO_50GAL_SLIPPER_TANK}", displayName = _("50 gal. Drop Tank"),
    attribute = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
    Picture = "british_Mosquito_50gal.png",
    PictureBlendColor = "0xffffffff",
    Weight_Empty = 24.0,
    Weight = 24.0 + 163.7,
    Cx_pil = 0.00021772764,
    shape_table_data = {
        {
            file = "Mosquito_Drop_Tank_50gal";
            life = 1;
            fire = {0, 1};
            username = "MOSQUITO_50GAL_SLIPPER_TANK";
            index = WSTYPE_PLACEHOLDER;
        },
    },
    Elements = {
        {
            ShapeName = "Mosquito_Drop_Tank_50gal",
        },
    },
})

-- Defining 100 gal. slipper tank
declare_loadout({category = CAT_FUEL_TANKS, CLSID = "{MOSQUITO_100GAL_SLIPPER_TANK}", displayName = _("100 gal. Drop Tank"),
    attribute = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
    Picture = "british_Mosquito_100gal.png",
    PictureBlendColor = "0xffffffff",
    Weight_Empty = 48.0,
    Weight = 48.0 + 327.3,
    Cx_pil = 0.00021772764,
    shape_table_data = {
        {
            file = "Mosquito_Drop_Tank_100gal";
            life = 1;
            fire = {0, 1};
            username = "MOSQUITO_100GAL_SLIPPER_TANK";
            index = WSTYPE_PLACEHOLDER;
        },
    },
    Elements = {
        {
            ShapeName = "Mosquito_Drop_Tank_100gal",
        },
    },
})

-- Defining rockets collective
local mossie_hvars = function ( CLSID, shell, connectors, pic, input_settings )
    local elements = {}
    for i,o in ipairs(connectors) do
        elements[i] = {ShapeName = shell.model, connector_name = o}
    end
    local count = #connectors
    declare_loadout({
        category = CAT_ROCKETS,
        CLSID = CLSID,
        DistributeOverCarrierDirectly = true,
        displayName = tostring(count) .. " x " .. shell.displayName,
        wsTypeOfWeapon = shell.wsTypeOfWeapon,
        attribute = shell.wsTypeOfWeapon,
        Count = count,
        Picture = pic,
        PictureBlendColor = "0xffffffff",
        Weight_Empty = 130,
        Weight = 130 + shell.fm.mass * count,
        Cx_pil = 0.001,
        Elements = elements,
        pilon_jettison_option = 3, --NO_JETTISON_AVAILABLE
        settings = input_settings
    })
end
mossie_hvars("{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}",    British_HE_60LBFNo1_3INCHNo1,   {"PYLON_1", "PYLON_2", "PYLON_3", "PYLON_5"},   "british_RS_60lb_F_No1.png",      PredefinedFuzeGUISettings("WWII_R_B_RP3F"))
mossie_hvars("{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}",   British_HE_60LBFNo1_3INCHNo1,   {"PYLON_12", "PYLON_11", "PYLON_9", "PYLON_8"}, "british_RS_60lb_F_No1.png",      PredefinedFuzeGUISettings("WWII_R_B_RP3F"))
mossie_hvars("{MOSSIE_2_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}",    British_HE_60LBFNo1_3INCHNo1,   {"PYLON_1", "PYLON_2"},                         "british_RS_60lb_F_No1.png",      PredefinedFuzeGUISettings("WWII_R_B_RP3F"))
mossie_hvars("{MOSSIE_2_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}",   British_HE_60LBFNo1_3INCHNo1,   {"PYLON_12", "PYLON_11"},                       "british_RS_60lb_F_No1.png",      PredefinedFuzeGUISettings("WWII_R_B_RP3F"))
mossie_hvars("{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}",  British_HE_60LBSAPNo2_3INCHNo1, {"PYLON_1", "PYLON_2", "PYLON_3", "PYLON_5"},   "british_RS_60lb_SAP_No2.png",    PredefinedFuzeGUISettings("WWII_R_B_RP3SAP"))
mossie_hvars("{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}", British_HE_60LBSAPNo2_3INCHNo1, {"PYLON_12", "PYLON_11", "PYLON_9", "PYLON_8"}, "british_RS_60lb_SAP_No2.png",    PredefinedFuzeGUISettings("WWII_R_B_RP3SAP"))
mossie_hvars("{MOSSIE_2_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}",  British_HE_60LBSAPNo2_3INCHNo1, {"PYLON_1", "PYLON_2"},                         "british_RS_60lb_SAP_No2.png",    PredefinedFuzeGUISettings("WWII_R_B_RP3SAP"))
mossie_hvars("{MOSSIE_2_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}", British_HE_60LBSAPNo2_3INCHNo1, {"PYLON_12", "PYLON_11"},                       "british_RS_60lb_SAP_No2.png",    PredefinedFuzeGUISettings("WWII_R_B_RP3SAP"))
mossie_hvars("{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}",     British_AP_25LBNo1_3INCHNo1,    {"PYLON_1", "PYLON_2", "PYLON_3", "PYLON_5"},   "british_RS_25lb_AP.png")
mossie_hvars("{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}",    British_AP_25LBNo1_3INCHNo1,    {"PYLON_12", "PYLON_11", "PYLON_9", "PYLON_8"}, "british_RS_25lb_AP.png")
mossie_hvars("{MOSSIE_2_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}",     British_AP_25LBNo1_3INCHNo1,    {"PYLON_1", "PYLON_2"},                         "british_RS_25lb_AP.png")
mossie_hvars("{MOSSIE_2_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}",    British_AP_25LBNo1_3INCHNo1,    {"PYLON_12", "PYLON_11"},                       "british_RS_25lb_AP.png")



-- Declaring aircraft
function make_MosquitoFBMkVI ( rewrite_settings )
local AIRCRAFT = {

    Name                = MOSQUITOFBMKVI,
    DisplayName         = _("Mosquito FB Mk. VI"),
    date_of_introduction= 1942.5,
    country_of_origin   = "UK",
--    Countries           = {"UK", "USA", "AUS"},

    Picture             = MOSQUITOFBMKVI .. ".png",
    Rate                = 40, -- RewardPoint in Multiplayer -- TODO evaluate - Made Dragon
    Shape               = MOSQUITOFBMKVI,
    XRayShape           = MOSQUITOFBMKVI .. "_x-ray",
    propellorShapeType  = "3ARG_PROC_BLUR",
    propellorShapeName  = "MosquitoFBMkVI_blade.FBX",
    debrisGeneration    = 1,

    shape_table_data    = {
        {
            file        = "";
            life        = 48; -- life bar -- TODO evaluate - Made Dragon
            vis         = 8; -- visibility gain -- TODO evaluate - Made Dragon
            desrt       = MOSQUITOFBMKVI .. "_oblomki"; -- Name of destroyed object file name
            fire        = {3600, 6}; -- Fire on the ground after destroyed
            username    = "";
            index       = WSTYPE_PLACEHOLDER;
            classname   = "lLandPlane";
            positioning = "BYNORMAL";
            drawonmap = true;
        },
        {
            name = MOSQUITOFBMKVI .. "_oblomki";
            file = MOSQUITOFBMKVI .. "_oblomki";
            fire = {3600, 6};
        },
    },

    mapclasskey = "P0091000025", -- ref. MissionEditor/data/NewMap/images/nato/*.png
    attribute   = {wsType_Air, wsType_Airplane, wsType_Intruder, WSTYPE_PLACEHOLDER, "Battleplanes",},
    Categories  = {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",}, -- TODO ???



    -----------------------------------------------------------------------------------------------



    M_empty         = 7489.5, -- kg -- without ammo and fuel
    M_nominal       = 9900, -- kg -- TODO evaluate - Made Dragon
    M_max           = 11000, -- kg -- TODO evaluate - Made Dragon
    M_fuel_max      = 1483.1, -- kg
    M_fuel_per_tank = {190.0, 214.4, 255.3, 163.7, 255.3, 214.4, 190.0, 206.2}, -- kg
    defFuelRatio    = 0.672, -- топливо по умолчанию в долях от полного
    H_max           = 11500, -- m -- TODO evaluate - Made Dragon
    average_fuel_consumption = 0.302, -- this is highly relative, but good estimates are 36-40l/min = 28-31kg/min = 0.47-0.52kg/s -- 45l/min = 35kg/min = 0.583kg/s -- TODO evaluate - Made Dragon
    CAS_min         = 56, -- if this is not OVERALL FLIGHT TIME, but just LOITER TIME, than it should be 10-15 minutes.....CAS capability in minute (for AI) -- TODO evaluate - Made Dragon
    V_opt           = 115,-- Cruise speed (for AI) -- TODO evaluate - Made Dragon
    V_take_off      = 53, -- Take off speed in m/s (for AI) -- TODO evaluate - Made Dragon
    V_land          = 50, -- Land speed in m/s (for AI) -- TODO evaluate - Made Dragon
    V_max_sea_level = 208, -- Max speed at sea level in m/s (for AI) -- TODO evaluate - Made Dragon
    V_max_h         = 180, -- Max speed at max altitude in m/s (for AI) -- TODO evaluate - Made Dragon
    Vy_max          = 15, -- Max climb speed in m/s (for AI) -- TODO evaluate - Made Dragon
    Mach_max        = 0.76, -- Max speed in Mach (for AI) -- TODO evaluate - Made Dragon
    Ny_min          = -4, -- Min G (for AI) -- TODO evaluate - Made Dragon
    Ny_max          = 8.0,  -- Max G (for AI) -- TODO evaluate - Made Dragon
    Ny_max_e        = 8.0,  -- Max G (for AI) -- TODO evaluate - Made Dragon
    AOA_take_off    = 0.157, -- AoA in take off (for AI) -- TODO evaluate - Made Dragon
    bank_angle_max  = 60, -- Max bank angle (for AI) -- TODO evaluate - Made Dragon

    has_afteburner  = false, -- AFB yes/no
    has_speedbrake  = false, -- Air brake yes/no
    has_differential_stabilizer = false, -- Differential stabilizers yes/no
    flaps_transmission = "Hydraulic",
    undercarriage_transmission = "Hydraulic",
    undercarriage_movement = 2,
    bomb_bay_movement = 2,
    doors_transmission = "Mechanical",
    doors_movement  = 2,

    tand_gear_max   = 0.577, -- tang(a) <- a = steering angle -- TODO evaluate - Made Dragon

    nose_gear_pos                            = {-8.043, -0.419, 0.0}, -- Central gear coordinates
    nose_gear_amortizer_direct_stroke        = 0,
    nose_gear_amortizer_reversal_stroke      = -0.101,
    nose_gear_amortizer_normal_weight_stroke = -0.1, 
    nose_gear_wheel_diameter                 = 0.454, 

    main_gear_pos                            = {0.464, -2.249, 2.491}, -- Main gear coordinates
    main_gear_amortizer_direct_stroke        = 0,
    main_gear_amortizer_reversal_stroke      = -(0.175 + 0.075), -- + wheel pneumatic
    main_gear_amortizer_normal_weight_stroke = -0.17,
    main_gear_wheel_diameter                 = 0.908, 

    wing_area       = 42.0, 	-- Wing area in m2 -- TODO ???
    wing_span       = 16.3, -- Wing span in metres -- TODO ???
    wing_type       = 0, -- 0 = Fixed wing
                         -- 1 = Variable geometry
                         -- 2 = Fold-able wing
    wing_ad_sections= {0, 0, 0, 1, 1, 2, 2},
    thrust_sum_max  = 8224, -- Thrust in kg (44kN) -- TODO evaluate - Made Dragon
    thrust_sum_ab   = 8224, -- Thrust in kg (71kN) -- TODO evaluate - Made Dragon
    length          = 12.34, -- Full length in m -- TODO evaluate - Made Dragon
    height          = 3.81, -- Height in m -- TODO evaluate - Made Dragon
    flaps_maneuver  = 0.5, -- Max flaps in take-off and manoeuvre (0.5 = 1st stage; 1.0 = 2nd stage) (for AI) -- TODO ???
    range           = 1015, -- Max range in km (for AI) -- TODO evaluate - Made Dragon
    RCS             = 2.5, -- Radar Cross Section m2 -- TODO evaluate - Made Dragon
    IR_emission_coeff = 0.1, -- Normal engine -- IR_emission_coeff = 1.0 @ Su-27 without afterburner. It is a reference value. -- TODO evaluate - Made Dragon
    IR_emission_coeff_ab = 0, -- Same with afterburner
    --wing_tip_pos    = {0.237 - 1.0, -0.088, 5.6 + 0.2}, -- Wing tip coordinates for visual effects
    brakeshute_name = 0, -- Landing - brake chute visual shape after separation

    engines_count = 2, -- Engines count
    engines_nozzles = {
        [1] = {
            pos                 = {0.695, -0.228, -2.552}, -- Nozzle coordinates
            elevation           = 0, -- AFB cone elevation
            diameter            = 0 * 0.1, -- AFB cone diameter
            exhaust_length_ab   = -3.0, -- Length in m
            exhaust_length_ab_K = 0.3, -- AB animation
            engine_number       = 1, -- Both to first engine
        }, -- end of [1]
        [2] = {
            pos                 = {0.695, -0.228, 2.552}, -- Nozzle coordinates
            elevation           = 0, -- AFB cone elevation
            diameter            = 0 * 0.1, -- AFB cone diameter
            exhaust_length_ab   = -3.0, -- Length in m
            exhaust_length_ab_K = 0.3, -- AB animation
            engine_number       = 1, -- Both to first engine
        }, -- end of [2]
    }, -- end of engines_nozzles

    crew_members = {
        [1] = {
            pilot_name          = "pilot_mosquito",
            pos                 = {0.95 , 0.225, -0.21},
            ejection_seat_name  = 0,
            drop_parachute_name = "pilot_mosquito_parachute",
            drop_canopy_name    = MOSQUITOFBMKVI .. "_oblomok_door1", -- TODO evaluate - Made Dragon
            canopy_pos          = {-1.203, 0.658, 0.000}, -- TODO evaluate - Made Dragon
            canopy_arg          = 38,
            canopy_args         = {38, 1.0, 348, 1.0, 349, 1.0},
            bailout_arg         = 38,
            boarding_arg        = 38,
            can_be_playable     = true,
            role                = "pilot",
            role_display_name   = _("Pilot"),
        }, -- end of [1]
        [2] = {
            pilot_name          = "pilot_mosquito",
            pos                 = {0.95 , 0.225, -0.21}, 
            ejection_seat_name  = 0,
            drop_parachute_name = "pilot_mosquito_parachute",
            drop_canopy_name    = MOSQUITOFBMKVI .. "_oblomok_door1", -- TODO evaluate - Made Dragon
            canopy_pos          = {-1.203, 0.658, 0.000}, -- TODO evaluate - Made Dragon
            canopy_arg          = 38,
            canopy_args         = {38, 1.0, 348, 1.0, 349, 1.0},
            bailout_arg         = 38,
            boarding_arg        = 38,
            pilot_body_arg      = 472,
            can_be_playable     = true,
            role                = "copilot",
            role_display_name   = _("Navigator"),
        }, -- end of [2]
    }, -- end of crew_members
    crew_stations = "HumanOrchestra",

    fires_pos = {
        [1] = {0.0, 0.5, 0.0},
        [2] = {-0.6, -0.3, 0.95},
        [3] = {-0.6, -0.3, -0.95},
        [4] = {-0.7, -0.25, 2.2},
        [5] = {-0.7, -0.25, -2.2},
        [6] = {-0.9, -0.18, 4.4},
        [7] = {-0.9, -0.18, -4.4},
        [8] = {1.7, -0.1, 0.1},
        [9] = {1.7, -0.1, -0.1},
        [10] = {0.2, 0.1, 0.1},
        [11] = {0.2, 0.1, -0.1},
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
        HeadLights = {
            {Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 210, "to", 0.0, "speed", 1.0 / 8.0 * 0.8, "sign", -1.0}, {"Arg", 211, "to", 0.0, "speed", 1.0 / 8.0 * 0.8, "sign", -1.0},},},},},
            {Transition = {"Any", "Taxi"},    Sequence = {{C = {{"Arg", 210, "to", 0.8, "speed", 1.0 / 8.0 * 0.8, "sign", 1.0},  {"Arg", 211, "to", 0.0, "speed", 1.0 / 8.0 * 0.8, "sign", -1.0},},},},},
            {Transition = {"Any", "High"},    Sequence = {{C = {{"Arg", 210, "to", 0.8, "speed", 1.0 / 8.0 * 0.8, "sign", 1.0},  {"Arg", 211, "to", 0.8, "speed", 1.0 / 8.0 * 0.8, "sign", 1.0},},},},},
        },
        HeadLight0 = {
            {Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 210, "to", 0.0, "speed", 1.0 / 8.0 * 0.8, "sign", -1.0},},},},},
            {Transition = {"Any", "High"},    Sequence = {{C = {{"Arg", 210, "to", 1.0, "speed", 1.0 / 8.0 * 0.8, "sign", 1.0},},},},},
        },
        HeadLight1 = {
            {Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 211, "to", 0.0, "speed", 1.0 / 8.0 * 0.8, "sign", -1.0},},},},},
            {Transition = {"Any", "High"},    Sequence = {{C = {{"Arg", 211, "to", 1.0, "speed", 1.0 / 8.0 * 0.8, "sign", 1.0},},},},},
        },

        ServiceHatch9 = {
            {Transition = {"Any", "Retract"}, Sequence = {
                {C = {{"PokeSound", 12004}, {"Arg", 473, "to", 1.0, "in", 0.4}}},
            }},
            {Transition = {"Any", "Extend"}, Sequence = {
                {C = {{"PokeSound", 12005}, {"Arg", 473, "to", 0.0, "in", 0.8}}},
            }},
        },
        ServiceHatch10 = {
            {Transition = {"Close", "Open"}, Sequence = {
                {C = {{"PosType", 6}, {"Sleep", "for", 4.0}}},
                {C = {{"PokeSound", 12000}}},
                {C = {{"Arg", 348, "from", 0.0, "to", 0.5, "in", 0.2}}},
                {C = {{"Arg", 348, "from", 0.5, "to", 1.0, "in", 0.6}}},
            }, Flags = {"Reversible"}},
            {Transition = {"Open", "Close"}, Sequence = {
                {C = {{"PokeSound", 12001}}},
                {C = {{"Arg", 348, "from", 1.0, "to", 0.5, "in", 0.8}}},
                {C = {{"Arg", 348, "from", 0.5, "to", 0.0, "in", 0.2}}},
            }, Flags = {"Reversible"}},
        },
        ServiceHatch11 = {
            {Transition = {"Close", "Open"}, Sequence = {
                {C = {{"PosType", 8}, {"Sleep", "for", 4.0}}},
                {C = {{"PokeSound", 12002}}},
                {C = {{"Arg", 349, "from", 0.0, "to", 0.5, "in", 0.2}}},
                {C = {{"Arg", 349, "from", 0.5, "to", 1.0, "in", 0.6}}},
            }, Flags = {"Reversible"}},
            {Transition = {"Open", "Close"}, Sequence = {
                {C = {{"PokeSound", 12003}}},
                {C = {{"Arg", 349, "from", 1.0, "to", 0.5, "in", 0.8}}},
                {C = {{"Arg", 349, "from", 0.5, "to", 0.0, "in", 0.2}}},
            }, Flags = {"Reversible"}},
        },
        BombBay = {
            {Transition = {"Close", "Open"}, Sequence = {
                {C = {{"Arg", 26, "to", 1.0, "in", 12.0, "sign", 1}}},
            }},
            {Transition = {"Open", "Close"}, Sequence = {
                {C = {{"Arg", 26, "to", 0.0, "in", 12.0, "sign", -1}}},
            }},
        },

        LeftStrut = {
            {
                Transition = {"Retract", "Extend"},
                Sequence = {
                    {C = {{"VelType", 3}, {"Arg", 5, "from", 0.0, "to", 1.0, "in", 8.0}}},
                },
                Flags = {"Reversible"},
            },
            {
                Transition = {"Extend", "Retract"},
                Sequence = {
                    {C = {{"VelType", 3}, {"Arg", 5, "from", 1.0, "to", 0.0, "in", 10.0}}},
                },
                Flags = {"Reversible"},
            },
            {
                Transition = {"Extend", "Collapse"},
                Sequence = {
                    {C = {{"VelType", 3}, {"PosType", 6}, {"Arg", 5, "to", 0.5, "speed", 2.0, "sign", -1}}},
                },
            },
        },
        RightStrut = {
            {
                Transition = {"Retract", "Extend"},
                Sequence = {
                    {C = {{"VelType", 4}, {"Arg", 3, "from", 0.0, "to", 1.0, "in", 8.0}}},
                },
                Flags = {"Reversible"},
            },
            {
                Transition = {"Extend", "Retract"},
                Sequence = {
                    {C = {{"VelType", 4}, {"Arg", 3, "from", 1.0, "to", 0.0, "in", 10.0}}},
                },
                Flags = {"Reversible"},
            },
            {
                Transition = {"Extend", "Collapse"},
                Sequence = {
                    {C = {{"VelType", 4}, {"PosType", 7}, {"Arg", 3, "to", 0.5, "speed", 2.0, "sign", -1}}},
                },
            },
        },
        CentralStrut = {
            {
                Transition = {"Retract", "Extend"},
                Sequence = {
                    {C = {{"VelType", 5}, {"Arg", 0, "from", 0.0, "to", 1.0, "in", 8.0}}},
                },
                Flags = {"Reversible"},
            },
            {
                Transition = {"Extend", "Retract"},
                Sequence = {
                    {C = {{"VelType", 5}, {"Arg", 0, "from", 0.0, "to", 0.0, "in", 9.0}}},
                },
                Flags = {"Reversible"},
            },
            {
                Transition = {"Extend", "Collapse"},
                Sequence = {
                    {C = {{"PosType", 0}, {"Arg", 0, "to", 0.5, "speed", 2.0, "sign", -1}}},
                },
            },
        },

        Door0 = {
            {
                Transition = {"Close", "Open"},
                Sequence = {
                    {C = {{"Arg", 38, "from", 0.0, "to", 0.25, "in", 0.25}, {"PokeSound", 12006}}},
                    {C = {{"Sleep", "for", 0.5}}},
                    {C = {{"Arg", 38, "from", 0.25, "to", 0.9, "in", 0.9}}},
                },
                Flags = {"Reversible"},
            },
            {
                Transition = {"Open", "Close"},
                Sequence = {
                    {C = {{"Arg", 38, "from", 0.25, "to", 0.0, "in", 0.4}}},
                    {C = {{"Sleep", "for", 0.25}}},
                    {C = {{"Arg", 38, "from", 0.9, "to", 0.25, "in", 0.9}, {"PokeSound", 12007}}},
                },
                Flags = {"Reversible", "StepsBackwards"},
            },
            {
                Transition = {"Open", "Board"},
                Sequence = {
                    {C = {{"Sleep", "for", 0.0}}},
                },
            },
            {
                Transition = {"Board", "Open"},
                Sequence = {
                    {C = {{"Sleep", "for", 0.0}}},
                },
            },
            {
                Transition = {"Any", "Bailout"},
                Sequence = {
                    {C = {{"TearCanopy", 0}}}
                },
            },
            {
                Transition = {"Any", "Ditch"},
                Sequence = {
                    {C = {{"Arg", 108, "set", 1.0}}},
                },
            },
        },
        Door1 = {DuplicateOf = "Door0"},
    },

    net_animation = {
        278, 279, 203
    },



    -- Sensors
    detection_range_max     = 0,
    radar_can_see_ground    = false, -- This should be examined (what is this exactly?) ???
    CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_BAD, LOOK_GOOD, LOOK_GOOD),
    Sensors = {
        OPTIC = "Merkury LLTV", -- For night goggles imitation
    },



    HumanRadio = {
        frequency = 124.000,
        editable = true,
        minFrequency = 0.200,
        maxFrequency = 156.000,
        rangeFrequency = {
            {min = 100.000, max = 156.000},
            {min = 5.500, max = 10.000},
            {min = 3.000, max = 5.500},
            {min = 0.200, max = 0.500},
        },
        modulation = MODULATION_AM,
    },

    panelRadio = {
        [1] = {
            ID = "SCR522",
            name = _("TR.1143"),
            displayUnits = "MHz",
            range = {min = 38.000, max = 156.000},
            channels = {
                [1] = {name = _("Channel A"),             default = 105.000, modulation = _("AM"), connect = true},
                [2] = {name = _("Channel B"),             default = 124.000, modulation = _("AM")},
                [3] = {name = _("Channel C"),             default = 131.000, modulation = _("AM")},
                [4] = {name = _("Channel D"),             default = 139.000, modulation = _("AM")},
                [5] = {name = _("A.1271 Base Frequency"), default = 108.900, modulation = _("AM")},
            }
        },
        [2] = {
            ID = "T1154R1155R1",
            name = _("T.1154N Range 1"),
            displayUnits = "MHz",
            range = {
                {min = 5.500, max = 10.000},
            },
            channels = {
                [1] = {name = _("Preset A"), default = 9.255, modulation = _("AM")},
                [2] = {name = _("Preset B"), default = 8.000, modulation = _("AM")},
                [3] = {name = _("Preset C"), default = 7.710, modulation = _("AM")},
                [4] = {name = _("Preset D"), default = 6.872, modulation = _("AM")},
                [5] = {name = _("Preset E"), default = 5.955, modulation = _("AM")},
                [6] = {name = _("Preset F"), default = 5.850, modulation = _("AM")},
                [7] = {name = _("Preset G"), default = 5.750, modulation = _("AM")},
                [8] = {name = _("Preset H"), default = 5.650, modulation = _("AM")},
            }
        },
        [3] = {
            ID = "T1154R1155R2",
            name = _("T.1154N Range 2"),
            displayUnits = "MHz",
            range = {
                {min = 3.000, max = 5.500},
            },
            channels = {
                [1] = {name = _("Preset J"), default = 5.250, modulation = _("AM")},
                [2] = {name = _("Preset K"), default = 5.000, modulation = _("AM")},
                [3] = {name = _("Preset L"), default = 4.750, modulation = _("AM")},
                [4] = {name = _("Preset M"), default = 4.500, modulation = _("AM")},
                [5] = {name = _("Preset N"), default = 4.250, modulation = _("AM")},
                [6] = {name = _("Preset P"), default = 3.250, modulation = _("AM")},
                [7] = {name = _("Preset Q"), default = 3.012, modulation = _("AM")},
                [8] = {name = _("Preset R"), default = 3.011, modulation = _("AM")},
            }
        },
        [4] = {
            ID = "T1154R1155R3",
            name = _("T.1154N Range 3"),
            displayUnits = "kHz",
            range = {
                {min = 200.000, max = 500.000},
            },
            channels = {
                [1] = {name = _("Preset S"), default = 0.444000, modulation = _("AM")},
                [2] = {name = _("Preset T"), default = 0.421000, modulation = _("AM")},
                [3] = {name = _("Preset U"), default = 0.303000, modulation = _("AM")},
                [4] = {name = _("Preset V"), default = 0.300000, modulation = _("AM")},
                [5] = {name = _("Preset W"), default = 0.270000, modulation = _("AM")},
                [6] = {name = _("Preset X"), default = 0.260000, modulation = _("AM")},
                [7] = {name = _("Preset Y"), default = 0.250000, modulation = _("AM")},
                [8] = {name = _("Preset Z"), default = 0.240000, modulation = _("AM")},
            }
        },
    },

    AddPropAircraft = {
        {
            id = "SoloFlight", label = _("Solo Flight"),
            control = "checkbox",
            defValue = false,
            weightWhenOn = -90,
            arg = 472,
            wCtrl = 150,
        },
        {
            id = "Flare_Gun", label = _("Flare Gun Port"),
            control = "comboList",
            playerOnly = true,
            defValue = 1,
            values = {
                { id = 0, dispName = _("None")},
                { id = 1, dispName = _("Flare Gun")},
            },
            wCtrl = 150,
        },
        {
            id = "ResinLights", label = _("Resin Lights Colour Filter"),
            control = "comboList",
            defValue = 0.15,
            values = {
                { id = 0.15, dispName = _("Red")},
                { id = 0.25, dispName = _("Orange")},
                { id = 0.35, dispName = _("Yellow")},
                { id = 0.45, dispName = _("Green")},
                { id = 0.55, dispName = _("Sky")},
                { id = 0.65, dispName = _("Blue")},
                { id = 0.75, dispName = _("Violet")},
                { id = 0.05, dispName = _("White")},
            },
            arg = 203,
            argTbl = {
                [0] = 0.15,
                [1] = 0.25,
                [2] = 0.35,
                [3] = 0.45,
                [4] = 0.55,
                [5] = 0.65,
                [6] = 0.75,
                [7] = 0.05,
            },
            wCtrl = 150,
        },
    },



    -- Guns
    Guns = {
        -- Hispano Mk. II No. 1
        HispanoMkII({
            muzzle_pos_connector = "Gun_point_08",
            effect_arg_number = 349,
            mixes = {
                --[[ APIT ]]  {2, 4, 6, 2, 4},
                --[[ BaIT ]]  {2, 4, 6, 2, 4},
                --[[ API ]]  {2, 4},
                --[[ BaI ]]  {2, 4},
                --[[ CM ]]  {6, 2, 2, 4, 1},
                --[[ HE ]]  {6, 2, 2, 4, 1},
                --[[ AG ]]  {6, 3, 3, 3, 3},
                --[[ CS ]]  {1, 2, 2, 4, 1},
                --[[ NO ]]  {5, 2, 2, 4, 1},
                --[[ TP ]]  {6, 1, 1, 1, 1, 1, 1},
            },
            count = 150,
            barrel_circular_error = 0.0,
            azimuth_initial = -0/60,
            elevation_initial = 0.0,
            supply_position = {-0.49, -0.154, -0.227},
            drop_cartridge = 204,
            ejector_pos_connector = "ejector_Machinegun_04",
            ejector_dir           = {0, 5, 0},
            effects = {
                {name = "FireEffect", arg = 349, attenuation = 2.0, light_pos = {0.5, 0.5, 0.0} , light_time = 0.1},
                {name = "SmokeEffect"},
            }
        }),

        -- Hispano Mk. II No. 2
        HispanoMkII({
            muzzle_pos_connector = "Gun_point_07",
            effect_arg_number = 348,
            mixes = {
                --[[ APIT ]]  {2, 4},
                --[[ BaIT ]]  {2, 4},
                --[[ API ]]  {2, 4},
                --[[ BaI ]]  {2, 4},
                --[[ CM ]]  {1, 6, 2, 2, 4},
                --[[ HE ]]  {1, 6, 2, 2, 4},
                --[[ AG ]]  {3, 6, 3, 3, 3},
                --[[ CS ]]  {1, 1, 2, 2, 4},
                --[[ NO ]]  {1, 5, 2, 2, 4},
                --[[ TP ]]  {1, 1, 1, 6, 1, 1, 1},
            },
            count = 150,
            rates = {650 - 20},
            barrel_circular_error = 0.0,
            azimuth_initial = -0/60,
            elevation_initial = 0.0,
            supply_position = {0.346, -0.154, -0.032},
            drop_cartridge = 204,
            ejector_pos_connector = "ejector_Machinegun_02",
            ejector_dir           = {0, 5, 0},
            effects = {
                {name = "FireEffect", arg = 348, attenuation = 2.0, light_pos = {0.5, 0.5, 0.0} , light_time = 0.1},
                {name = "SmokeEffect"},
            }
        }),

        -- Hispano Mk. II No. 3
        HispanoMkII({
            muzzle_pos_connector = "Gun_point_06",
            effect_arg_number = 436,
            mixes = {
				--[[ APIT ]]  {2, 4},
                --[[ BaIT ]]  {2, 4},
                --[[ API ]]  {2, 4},
                --[[ BaI ]]  {2, 4},
                --[[ CM ]]  {2, 4, 1, 6, 2},
                --[[ HE ]]  {2, 4, 1, 6, 2},
                --[[ AG ]]  {3, 3, 3, 6, 3},
                --[[ CS ]]  {2, 4, 1, 1, 2},
                --[[ NO ]]  {2, 4, 1, 5, 2},
                --[[ TP ]]  {1, 1, 1, 1, 1, 6, 1},
            },
            count = 150,
            rates = {650 + 15},
            barrel_circular_error = 0.0,
            azimuth_initial = 0/60,
            elevation_initial = 0.0,
            supply_position = {0.346, -0.154, -0.032},
            drop_cartridge = 204,
            ejector_pos_connector = "ejector_Machinegun_02",
            ejector_dir           = {0, 5, 0},
            effects = {
                {name = "FireEffect", arg = 436, attenuation = 2.0, light_pos = {0.5, 0.5, 0.0} , light_time = 0.1},
                {name = "SmokeEffect"},
            }
        }),

        -- Hispano Mk. II No. 4
        HispanoMkII({
            muzzle_pos_connector = "Gun_point_05",
            effect_arg_number = 435,
            mixes = {
                --[[ APIT ]]  {2, 4, 6, 2, 4},
                --[[ BaIT ]]  {2, 4, 6, 2, 4},
                --[[ API ]]  {2, 4},
                --[[ BaI ]]  {2, 4},
                --[[ CM ]]  {6, 2, 2, 4, 1},
                --[[ HE ]]  {6, 2, 2, 4, 1},
                --[[ AG ]]  {6, 3, 3, 3, 3},
                --[[ CS ]]  {1, 2, 2, 4, 1},
                --[[ NO ]]  {5, 2, 2, 4, 1},
                --[[ TP ]]  {6, 1, 1, 1, 1, 1, 1},
            },
            count = 150,
            rates = {650 - 65},
            barrel_circular_error = 0.0,
            azimuth_initial = 0/60,
            elevation_initial = 0.0,
            supply_position = {-0.49, -0.154, -0.227},
            drop_cartridge = 204,
            ejector_pos_connector = "ejector_Machinegun_01",
            ejector_dir           = {0, 5, 0},
            effects = {
                {name = "FireEffect", arg = 435, attenuation = 2.0, light_pos = {0.5, 0.5, 0.0} , light_time = 0.1},
                {name = "SmokeEffect"},
            }
        }),

        -- Browning .303 No. 1
        Browning303MkII({
            muzzle_pos_connector = "Gun_point_04",
            effect_arg_number = 434,
            mixes = {
                --[[ APT ]]  {13, 13, 8, 13, 13, 13, 13},
                --[[ BaT ]]  {13, 13, 8, 13, 13, 13, 13},
                --[[ API ]]  {13},
                --[[ BaI ]]  {11},
                --[[ CM ]]  {14, 3, 3, 3, 3},
                --[[ HE ]]  {14, 11, 11, 11, 11},
                --[[ AG ]]  {14, 3, 3, 3, 3},
                --[[ CS ]]  {3},
                --[[ NO ]]  {3},
                --[[ TP ]]  {14, 1},
            },
            count = 500,
            barrel_circular_error = 0.0002,
            rates = {1100 - 40},
            azimuth_initial = -0/60,
            elevation_initial = 0.0,
            supply_position = {1.81, 0.248, -0.240},
            effects = {
                {name = "FireEffect", arg = 434, attenuation = 2.0, light_pos = {0.5, 0.5, 0.0} , light_time = 0.1},
                {name = "SmokeEffect"},
            }
        }),

        -- Browning .303 No. 2
        Browning303MkII({
            muzzle_pos_connector = "Gun_point_03",
            effect_arg_number = 433,
            mixes = {
				--[[ APT ]]  {11},
                --[[ BaT ]]  {3},
                --[[ API ]]  {11},
                --[[ BaI ]]  {3},
                --[[ CM ]]  {13, 8, 13, 13, 13},
                --[[ HE ]]  {13, 8, 13, 13, 13},
                --[[ AG ]]  {11, 6, 11, 11, 11},
                --[[ CS ]]  {13},
                --[[ NO ]]  {13, 9, 13, 13, 13},
                --[[ TP ]]  {8},
            },
            count = 500,
            barrel_circular_error = 0.0004,
            rates = {1100 + 10},
            azimuth_initial = -0/60,
            elevation_initial = 0.0,
            supply_position = {1.81, 0.248, -0.080},
            effects = {
                {name = "FireEffect", arg = 433, attenuation = 2.0, light_pos = {0.5, 0.5, 0.0} , light_time = 0.1},
                {name = "SmokeEffect"},
            }
        }),

        -- Browning .303 No. 3
        Browning303MkII({
            muzzle_pos_connector = "Gun_point_02",
            effect_arg_number = 432,
            mixes = {
                --[[ APT ]]  {11},
                --[[ BaT ]]  {3},
                --[[ API ]]  {11},
                --[[ BaI ]]  {3},
                --[[ CM ]]  {13, 13, 13, 8, 13},
                --[[ HE ]]  {13, 13, 13, 8, 13},
                --[[ AG ]]  {11, 11, 11, 6, 11},
                --[[ CS ]]  {13},
                --[[ NO ]]  {13, 13, 13, 9, 13},
                --[[ TP ]]  {8},
            },
            count = 500,
            barrel_circular_error = 0.0009,
            rates = {1100 + 90},
            azimuth_initial = 0/60,
            elevation_initial = 0.0,
            supply_position = {1.81, 0.248, 0.080},
            effects = {
                {name = "FireEffect", arg = 432, attenuation = 2.0, light_pos = {0.5, 0.5, 0.0} , light_time = 0.1},
                {name = "SmokeEffect"},
            }
        }),

        -- Browning .303 No. 4
        Browning303MkII({
            muzzle_pos_connector = "Gun_point_01",
            effect_arg_number = 350,
            mixes = {
				--[[ APT ]]  {13, 13, 13, 13, 8, 13, 13},
                --[[ BaT ]]  {13, 13, 13, 13, 8, 13, 13},
                --[[ API ]]  {13},
                --[[ BaI ]]  {11},
                --[[ CM ]]  {11, 11, 14, 11, 11},
                --[[ HE ]]  {11, 11, 14, 11, 11},
                --[[ AG ]]  {11, 11, 6, 11, 11},
                --[[ CS ]]  {3},
                --[[ NO ]]  {11},
                --[[ TP ]]  {1, 14},
            },
            count = 500,
            barrel_circular_error = 0.0012,
            rates = {1100 - 70},
            azimuth_initial = 0/60,
            elevation_initial = 0.0,
            supply_position = {1.81, 0.248, 0.240},
            effects = {
                {name = "FireEffect", arg = 350, attenuation = 2.0, light_pos = {0.5, 0.5, 0.0} , light_time = 0.1},
                {name = "SmokeEffect"},
            }
        }),
    },
    ammo_type = {
	    _("APIT AP/De Wilde (Tracer) - 20mm HEI/SAPI/APT"),
        _("BaIT Ball/De Wilde (Tracer) - 20mm HEI/SAPI/APT"),
        _("API AP/De Wilde (No Tracer) - 20mm HEI/SAPI"),
        _("BaI Ball/De Wilde (No Tracer) - 20mm HEI/SAPI"),
        _("CM Combat Mix"),
        _("HE Anti-Bomber"),
        _("AG Ground Attack"),
        _("CS No Tracers"),
        _("NO Night Time Tracers"),
        _("TP Target Practice"),
    },

    Pylons = {
        pylon( -- Port Wing Bomb Carrier & Drop Tank Carrier (0)
            1, -- pylon index 
            0, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
            0, 0, 0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
            {
                use_full_connector_position = true,
                connector = "PYLON_4_B",
                arg = 311,
                arg_value = 1.0,
            },
            {
                {
                    CLSID = "{British_GP_250LB_Bomb_Mk4}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 2, loadout = {"{British_GP_250LB_Bomb_Mk4}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_GP_250LB_Bomb_Mk5}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 2, loadout = {"{British_GP_250LB_Bomb_Mk5}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_GP_500LB_Bomb_Mk4}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 2, loadout = {"{British_GP_500LB_Bomb_Mk4}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_GP_500LB_Bomb_Mk4_Short}", arg_value = 0.0,
                    required = {
                        {station = 2, loadout = {"{British_GP_500LB_Bomb_Mk4_Short}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_GP_500LB_Bomb_Mk5}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 2, loadout = {"{British_GP_500LB_Bomb_Mk5}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_MC_250LB_Bomb_Mk1}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 2, loadout = {"{British_MC_250LB_Bomb_Mk1}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_MC_250LB_Bomb_Mk2}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 2, loadout = {"{British_MC_250LB_Bomb_Mk2}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_MC_500LB_Bomb_Mk1_Short}", arg_value = 0.0,
                    required = {
                        {station = 2, loadout = {"{British_MC_500LB_Bomb_Mk1_Short}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_MC_500LB_Bomb_Mk2}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 2, loadout = {"{British_MC_500LB_Bomb_Mk2}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                --{
                --    CLSID = "{British_SAP_250LB_Bomb_Mk5}", arg_value = 0.0,
                --    required = {
                --        {station = 2, loadout = {"{British_SAP_250LB_Bomb_Mk5}"}},
                --    },
                --    forbidden = {
                --        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                --        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                --        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                --        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                --        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                --        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                --    },
                --},
                {
                    CLSID = "{British_SAP_500LB_Bomb_Mk5}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 2, loadout = {"{British_SAP_500LB_Bomb_Mk5}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{MOSQUITO_50GAL_SLIPPER_TANK}", arg_value = 0.2, attach_point_oriented = true,
                    required = {
                        {station = 2, loadout = {"{MOSQUITO_50GAL_SLIPPER_TANK}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{MOSQUITO_100GAL_SLIPPER_TANK}", arg_value = 0.2, attach_point_oriented = true,
                    required = {
                        {station = 2, loadout = {"{MOSQUITO_100GAL_SLIPPER_TANK}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
            },
            100 -- sorting order
        ),
        pylon( -- Starboard Wing Bomb Carrier & Drop Tank Carrier (1)
            2, -- pylon index
            0, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
            0, 0, 0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
            {
                --use_full_connector_position = true,
                use_full_connector_position = true,
                connector = "PYLON_10_B",
                arg = 317,
                arg_value = 1.0,
            },
            {
                {
                    CLSID = "{British_GP_250LB_Bomb_Mk4}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 1, loadout = {"{British_GP_250LB_Bomb_Mk4}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_GP_250LB_Bomb_Mk5}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 1, loadout = {"{British_GP_250LB_Bomb_Mk5}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_GP_500LB_Bomb_Mk4}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 1, loadout = {"{British_GP_500LB_Bomb_Mk4}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_GP_500LB_Bomb_Mk4_Short}", arg_value = 0.0,
                    required = {
                        {station = 1, loadout = {"{British_GP_500LB_Bomb_Mk4_Short}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_GP_500LB_Bomb_Mk5}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 1, loadout = {"{British_GP_500LB_Bomb_Mk5}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_MC_250LB_Bomb_Mk1}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 1, loadout = {"{British_MC_250LB_Bomb_Mk1}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_MC_250LB_Bomb_Mk2}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 1, loadout = {"{British_MC_250LB_Bomb_Mk2}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_MC_500LB_Bomb_Mk1_Short}", arg_value = 0.0,
                    required = {
                        {station = 1, loadout = {"{British_MC_500LB_Bomb_Mk1_Short}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{British_MC_500LB_Bomb_Mk2}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 1, loadout = {"{British_MC_500LB_Bomb_Mk2}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                --{
                --    CLSID = "{British_SAP_250LB_Bomb_Mk5}", arg_value = 0.0,
                --    required = {
                --        {station = 1, loadout = {"{British_SAP_250LB_Bomb_Mk5}"}},
                --    },
                --    forbidden = {
                --        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                --        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                --        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                --        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                --        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                --        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                --    },
                --},
                {
                    CLSID = "{British_SAP_500LB_Bomb_Mk5}", arg_value = 0.0, DrawArgs = {{57, 0.1}},
                    required = {
                        {station = 1, loadout = {"{British_SAP_500LB_Bomb_Mk5}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{MOSQUITO_50GAL_SLIPPER_TANK}", arg_value = 0.2, attach_point_oriented = true,
                    required = {
                        {station = 1, loadout = {"{MOSQUITO_50GAL_SLIPPER_TANK}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{MOSQUITO_100GAL_SLIPPER_TANK}", arg_value = 0.2, attach_point_oriented = true,
                    required = {
                        {station = 1, loadout = {"{MOSQUITO_100GAL_SLIPPER_TANK}"}},
                    },
                    forbidden = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
            },
            400 -- sorting order
        ),
        pylon( -- Belly Bomb Carrier - Port (2)
            3, -- pylon index 
            2, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
            0, 0, 0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
            {
                use_full_connector_position = true,
                connector = "PYLON_6",
            },
            {
                {
                    CLSID = "{British_GP_250LB_Bomb_Mk4_on_Handley_Page_Type_B_Cut_Bar}",
                    required = {
                        {station = 4, loadout = {"{British_GP_250LB_Bomb_Mk4_on_Handley_Page_Type_B_Cut_Bar}"}},
                    },
                },
                {
                    CLSID = "{British_GP_250LB_Bomb_Mk5_on_Handley_Page_Type_B_Cut_Bar}",
                    required = {
                        {station = 4, loadout = {"{British_GP_250LB_Bomb_Mk5_on_Handley_Page_Type_B_Cut_Bar}"}},
                    },
                },
                {
                    CLSID = "{British_GP_500LB_Bomb_Mk4_Short_on_Handley_Page_Type_B_Cut_Bar}",
                    required = {
                        {station = 4, loadout = {"{British_GP_500LB_Bomb_Mk4_Short_on_Handley_Page_Type_B_Cut_Bar}"}},
                    },
                },
                {
                    CLSID = "{British_MC_250LB_Bomb_Mk1_on_Handley_Page_Type_B_Cut_Bar}",
                    required = {
                        {station = 4, loadout = {"{British_MC_250LB_Bomb_Mk1_on_Handley_Page_Type_B_Cut_Bar}"}},
                    },
                },
                {
                    CLSID = "{British_MC_250LB_Bomb_Mk2_on_Handley_Page_Type_B_Cut_Bar}",
                    required = {
                        {station = 4, loadout = {"{British_MC_250LB_Bomb_Mk2_on_Handley_Page_Type_B_Cut_Bar}"}},
                    },
                },
                {
                    CLSID = "{British_MC_500LB_Bomb_Mk1_Short_on_Handley_Page_Type_B_Cut_Bar}",
                    required = {
                        {station = 4, loadout = {"{British_MC_500LB_Bomb_Mk1_Short_on_Handley_Page_Type_B_Cut_Bar}"}},
                    },
                },
                {
                    CLSID = "{British_SAP_250LB_Bomb_Mk5_on_Handley_Page_Type_B_Cut_Bar}",
                    required = {
                        {station = 4, loadout = {"{British_SAP_250LB_Bomb_Mk5_on_Handley_Page_Type_B_Cut_Bar}"}},
                    },
                },
            },
            200 -- sorting order
        ),
        pylon( -- Belly Bomb Carrier - Starboard (3)
            4, -- pylon index 
            2, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
            0, 0, 0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
            {
                use_full_connector_position = true,
                connector = "PYLON_7",
            },
            {
                {
                    CLSID = "{British_GP_250LB_Bomb_Mk4_on_Handley_Page_Type_B_Cut_Bar}",
                    required = {
                        {station = 3, loadout = {"{British_GP_250LB_Bomb_Mk4_on_Handley_Page_Type_B_Cut_Bar}"}},
                    },
                },
                {
                    CLSID = "{British_GP_250LB_Bomb_Mk5_on_Handley_Page_Type_B_Cut_Bar}",
                    required = {
                        {station = 3, loadout = {"{British_GP_250LB_Bomb_Mk5_on_Handley_Page_Type_B_Cut_Bar}"}},
                    },
                },
                {
                    CLSID = "{British_GP_500LB_Bomb_Mk4_Short_on_Handley_Page_Type_B_Cut_Bar}",
                    required = {
                        {station = 3, loadout = {"{British_GP_500LB_Bomb_Mk4_Short_on_Handley_Page_Type_B_Cut_Bar}"}},
                    },
                },
                {
                    CLSID = "{British_MC_250LB_Bomb_Mk1_on_Handley_Page_Type_B_Cut_Bar}",
                    required = {
                        {station = 3, loadout = {"{British_MC_250LB_Bomb_Mk1_on_Handley_Page_Type_B_Cut_Bar}"}},
                    },
                },
                {
                    CLSID = "{British_MC_250LB_Bomb_Mk2_on_Handley_Page_Type_B_Cut_Bar}",
                    required = {
                        {station = 3, loadout = {"{British_MC_250LB_Bomb_Mk2_on_Handley_Page_Type_B_Cut_Bar}"}},
                    },
                },
                {
                    CLSID = "{British_MC_500LB_Bomb_Mk1_Short_on_Handley_Page_Type_B_Cut_Bar}",
                    required = {
                        {station = 3, loadout = {"{British_MC_500LB_Bomb_Mk1_Short_on_Handley_Page_Type_B_Cut_Bar}"}},
                    },
                },
                {
                    CLSID = "{British_SAP_250LB_Bomb_Mk5_on_Handley_Page_Type_B_Cut_Bar}",
                    required = {
                        {station = 3, loadout = {"{British_SAP_250LB_Bomb_Mk5_on_Handley_Page_Type_B_Cut_Bar}"}},
                    },
                },
            },
            300 -- sorting order
        ),
        pylon( -- Port Wing Rocket Beams Collective (4)
            5, -- pylon index 
            0, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
            0, 0, 0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
            {
                use_full_connector_position = true,
                connector = "PYLON_1",
                arg = 312,
                arg_value = 0.0,
            },
            {
                {
                    CLSID = "{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}", arg_value = 0.2,
                    required = {
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 1, loadout = {""}},
                        {station = 2, loadout = {""}},
                    },
                },
                {
                    CLSID = "{MOSSIE_2_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}", arg_value = 0.1,
                    required = {
                        {station = 6, loadout = {"{MOSSIE_2_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}", arg_value = 0.2,
                    required = {
                        {station = 6, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 1, loadout = {""}},
                        {station = 2, loadout = {""}},
                    },
                },
                {
                    CLSID = "{MOSSIE_2_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}", arg_value = 0.1,
                    required = {
                        {station = 6, loadout = {"{MOSSIE_2_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}", arg_value = 0.2,
                    required = {
                        {station = 6, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                        {station = 1, loadout = {""}},
                        {station = 2, loadout = {""}},
                    },
                },
                {
                    CLSID = "{MOSSIE_2_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}", arg_value = 0.1,
                    required = {
                        {station = 6, loadout = {"{MOSSIE_2_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}"}},
                    },
                },
            },
            50 -- sorting order
        ),
        pylon( -- Starboard Wing Rocket Beams Collective (5)
            6, -- pylon index 
            0, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
            0, 0, 0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
            {
                use_full_connector_position = true,
                connector = "PYLON_12",
                arg = 318,
                arg_value = 0.0,
            },
            {
                {
                    CLSID = "{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}", arg_value = 0.2,
                    required = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 1, loadout = {""}},
                        {station = 2, loadout = {""}},
                    },
                },
                {
                    CLSID = "{MOSSIE_2_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}", arg_value = 0.1,
                    required = {
                        {station = 5, loadout = {"{MOSSIE_2_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}", arg_value = 0.2,
                    required = {
                        {station = 5, loadout = {"{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 1, loadout = {""}},
                        {station = 2, loadout = {""}},
                    },
                },
                {
                    CLSID = "{MOSSIE_2_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}", arg_value = 0.1,
                    required = {
                        {station = 5, loadout = {"{MOSSIE_2_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                    },
                },
                {
                    CLSID = "{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}", arg_value = 0.2,
                    required = {
                        {station = 5, loadout = {"{MOSSIE_4_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                        {station = 1, loadout = {""}},
                        {station = 2, loadout = {""}},
                    },
                },
                {
                    CLSID = "{MOSSIE_2_British_AP_25LBNo1_3INCHNo1_ON_RIGHT_WING_RAILS}", arg_value = 0.1,
                    required = {
                        {station = 5, loadout = {"{MOSSIE_2_British_AP_25LBNo1_3INCHNo1_ON_LEFT_WING_RAILS}"}},
                    },
                },
            },
            450 -- sorting order
        ),
    },



    -- Tasks
    Tasks = {
        aircraft_task(CAP),
        aircraft_task(Escort),
        aircraft_task(Intercept),
        aircraft_task(FighterSweep),
        aircraft_task(GroundAttack),
        aircraft_task(CAS),
        aircraft_task(AFAC),
        aircraft_task(RunwayAttack),
        aircraft_task(AntishipStrike),
    },
    DefaultTask = aircraft_task(CAP),



    -- SFM Data
    SFM_Data = {
        aerodynamics = { -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
            Cy0         = 0.15, -- zero AoA lift coefficient
            Mzalfa      = 4.355, -- coefficients for pitch agility
            Mzalfadt    = 0.8, -- coefficients for pitch agility
            kjx         = 2.25,
            kjz         = 0.00125,
            Czbe        = -0.016, -- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
            cx_gear     = 0.0277, -- coefficient, drag, gear
            cx_flap     = 0.035, -- coefficient, drag, full flaps
            cy_flap     = 0.33, -- coefficient, normal force, lift, flaps
            cx_brk      = 0.06, -- coefficient, drag, breaks
            table_data  = 
			{	--      M		Cx0		 	Cya			B		B4	   	Omxmax	Aldop		Cymax
					{	0.0	,	0.022	,	0.0820	,	0.0644	,	0.000001,	0.166	,	16.0,	1.14},
					{	0.3	,	0.022	,	0.0820	,	0.0644	,	0.000001,	0.995	,	16.0,	1.14},
					{	0.4	,	0.022	,	0.0820	,	0.0644	,	0.000001,	0.970	,	15.45,	1.12},
					{	0.5	,	0.023	,	0.0820	,	0.0644	,	0.000001,	0.901	,	15.0,	1.1	},
					{	0.6	,	0.025	,	0.0805	,	0.0644	,	0.000001,	0.799	,	13.06,	1.027},
					{	0.65,	0.0265	,	0.0790	,	0.064	,	0.039	,	0.749	,	11.66,	0.93},
					{	0.7	,	0.0275	,	0.0680	,	0.066	,	0.096	,	0.707	,	9.94,	0.81},
					{	0.73,	0.034	,	0.0590	,	0.08	,	0.14	,	0.674	,	8.98,	0.717},
					{	0.76,	0.044	,	0.0570	,	0.086	,	0.152	,	0.634	,	4.8	,	0.4	},
					{	0.82,	0.0495	,	0.0640	,	0.09	,	0.16	,	0.436	,	3.6	,	0.3	},
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
            Nominal_RPM = 3000.0,
            Nmg     = 18.2, -- RPM at idle
            MinRUD  = 0, -- Min state of the throttle
            MaxRUD  = 1, -- Max state of the throttle
            MaksRUD = 1, -- Military power state of the throttle
            ForsRUD = 1, -- Afterburner state of the throttle
            type    = "Piston",
            name    = "RollsRoyceMerlin",
            Startup_Prework = 15.0,
            Startup_RPMs = {
                {0.0, 0},
                {2.0, 120},
                {5.6, 120},
                {5.5, 120},
                {6.5, 1100},
                {8.5, 900},
				{13.0, 900},
				{21.0, 550},
            },
            Startup_Ignition_Time = 6.3,
            Shutdown_Duration = 6.3,

            hMaxEng = 12.5, -- Max altitude for safe engine operation in km
            dcx_eng = 0.015, -- Engine drag coefficient
            cemax   = 0.37, -- not used for fuel calculation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
            cefor   = 0.37, -- not used for fuel calculation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
            dpdh_m  = 1800, -- altitude coefficient for max thrust
            dpdh_f  = 1800, -- altitude coefficient for AB thrust
			k_adiab_1			= 0.0325,
			k_adiab_2			= 0.042,
			MAX_Manifold_P_1	= 150000,
			MAX_Manifold_P_2	= 163560,
			MAX_Manifold_P_3	= 225500,
			k_after_cool		= 0.001,
			Displ				= 27,
			k_Eps				= 6,
			Stroke				= 0.152,
			V_pist_0			= 12,
			Nu_0				= 1.2,
			Nu_1				= 0.9,
			Nu_2				= 0.001,
			N_indic_0			= 1023040,
			N_fr_0				= 0.072,
			N_fr_1				= 0.02,
			Init_Mom			= 220,
			D_prop				= 3.66,
			MOI_prop			= 65,
			k_gearbox			= 2.381,
			P_oil				= 495438,
			k_boost				= 3,
			k_cfug				= 0.003,
			k_oil				= 0.00004,
			k_piston			= 3000,
			k_reg				= 0.003,
			k_vel				= 0.017,
            prop_pitch_min      = 26.0, -- prop pitch min, degrees 
            prop_pitch_max      = 82.0, -- prop pitch max, degrees 
            prop_pitch_feather  = 90.0, -- prop pitch feather position, degrees if feather < prop_pitch_max no feathering available
            prop_blades_count   = 3,
            --prop_locations      = {
            --    {2.363, 0.104, -2.491}, {math.pi, 0.0, 0.0},
            --    {2.363, 0.104,  2.491}, {math.pi, 0.0, 0.0},
            --},
            prop_direction      = 1,
			table_data = 
			{
			--   M			Pmax
				{0.0,		16620.0},
				{0.1,		15600.0},
				{0.2,		14340.0},
				{0.3,		13320.0},
				{0.4,		12230.0},
				{0.5,		11300.0},
				{0.6,		10600.0},
				{0.7,		10050.0},
				{0.8,		 9820.0},
				{0.9,		 5902.0},
				{1.9,		 3469.0}
			},
			-- M - Mach number
			-- Pmax - Engine thrust at military power
			-- Pfor - Engine thrust at AFB
		}, -- end of engine
    },



    -- Damage, index meaning see in Scripts\Aircrafts\_Common\Damage.lua
    Damage = verbose_to_dmg_properties({
        -- Fuselage - Fore
        ["NOSE_BOTTOM"] = {
            args = {--[[148]]-1}, damage_boundary = 0.22,
            critical_damage = 3,
            construction = {durability = 1.78, skin = "Plywood"}, droppable = false,
            children = {"NOSE_LEFT_SIDE", "NOSE_RIGHT_SIDE", "NOSE_TOP", "NOSE_CENTER", "FUSELAGE_BOTTOM"},
            innards = {
                {id = "XGun-100", skin = "Steel", wall = 0.004},
                {id = "XAmmoBox-100", skin = "Aluminum", wall = 0.002},
                {id = "XGun-101", skin = "Steel", wall = 0.004},
                {id = "XAmmoBox-101", skin = "Aluminum", wall = 0.002},
                {id = "XGun-102", skin = "Steel", wall = 0.004},
                {id = "XAmmoBox-102", skin = "Aluminum", wall = 0.002},
                {id = "XGun-103", skin = "Steel", wall = 0.004},
                {id = "XAmmoBox-103", skin = "Aluminum", wall = 0.002},
                {id = "XGun-104", skin = "Steel", wall = 0.002},
                {id = "XAmmoBox-104", skin = "Aluminum", wall = 0.002},
                {id = "XGun-105", skin = "Steel", wall = 0.002},
                {id = "XAmmoBox-105", skin = "Aluminum", wall = 0.002},
                {id = "XGun-106", skin = "Steel", wall = 0.002},
                {id = "XAmmoBox-106", skin = "Aluminum", wall = 0.002},
                {id = "XGun-107", skin = "Steel", wall = 0.002},
                {id = "XAmmoBox-107", skin = "Aluminum", wall = 0.002},
                {id = "XHydroHose0", skin = "Rubber", wall = 0.024, plenum = 0.0002,
                    failures = {
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_UP_HOSES_CLOGGED", 0.5},
                        {"HYDR_INTERNAL_LEAKAGE", 0.1, "Exclusive"},
                        {"UNCR_LH_STRUT_HOSE_PIERCED", 0.01},
                        {"UNCR_RH_STRUT_HOSE_PIERCED", 0.01},
                    },
                },
                {id = "XPneumoHoseZ0", skin = "Rubber", wall = 0.014,
                    failures = {
                        {"PNEM_MACHINE_GUNS_HOSE_PERFORATED", 0.5},
                    },
                },
            },
        },
        ["NOSE_LEFT_SIDE"] = {
            args = {--[[150]]-1}, damage_boundary = 0.01,
            critical_damage = 3,
            construction = {durability = 2.54, skin = "Plywood"}, droppable = false,
            children = {"HATCH_08", "HATCH_09"},
            innards = {
                {id = "XCtrlEng0Quadrant", skin = "Steel", wall = 0.002},
                {id = "XCtrlEng1Quadrant", skin = "Steel", wall = 0.002,
                    failures = {
                        {"INST_COMPASS_MALFUNCTION", 0.25},
                    },
                },
                {id = "XOxygenCrew0Hose", skin = "Rubber", wall = 0.006, plenum = 0.01,
                    failures = {
                        {"OXYN_MIX_GEAR_00_DAMAGED", 0.1},
                    },
                },
                {id = "XCrew0", skin = "Fabric", wall = 0.024},
                {id = "XCrew0H", skin = "Rubber", wall = 0.004},
                {id = "XArmor0", skin = "Steel", wall = 0.014},
                {id = "XCockpitElement1", skin = "Aluminum", wall = 0.003,
                    failures = {
                    },
                },
                {id = "XCtrlCrew0Stick", skin = "Steel", wall = 0.044},
            },
        },
        ["NOSE_RIGHT_SIDE"] = {
            args = {--[[149]]-1}, damage_boundary = 0.01,
            critical_damage = 3,
            construction = {durability = 2.34, skin = "Plywood"}, droppable = false,
            children = {"HATCH_01", "HATCH_07", "HATCH_10"},
            innards = {
                {id = "XOxygenCrew1Hose", skin = "Rubber", wall = 0.006, plenum = 0.01,
                    failures = {
                        {"OXYN_MIX_GEAR_01_DAMAGED", 0.1},
                    },
                },
                {id = "XCrew1", skin = "Fabric", wall = 0.024},
                {id = "XCrew1H", skin = "Rubber", wall = 0.004},
                {id = "XArmor1", skin = "Steel", wall = 0.014},
                {id = "XCockpitElement7", skin = "Aluminum", wall = 0.001,
                    failures = {
                        {"ELEC_DASHBOARD_HARNESS_CUT", 0.5},
                        {"ELEC_MASTER_COMPASS_HARNESS_CUT", 0.5},
                        {"ELEC_PITOT_HEAT_WIRING", 0.5},
                        {"INST_HUD_FAILURE", 0.5},
                        {"OXYN_PRIMARY_CONTAINER_MINOR_LEAK", 0.5},
                        {"OXYN_MIX_GEAR_00_DAMAGED", 0.5},
                        {"OXYN_MIX_GEAR_01_DAMAGED", 0.5},
                        {"OXYN_MIX_HOSE_00_RUPTURED", 0.5},
                        {"OXYN_MIX_HOSE_01_RUPTURED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                        {"UNCR_DN_HOSES_CLOGGED", 0.5},
                    },
                },
            },
        },
        ["NOSE_TOP"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 3,
            construction = {durability = 2.00, skin = "Plywood"}, droppable = false,
            children = {"COCKPIT"},
            innards = {
                {id = "XCockpitElement2", skin = "Aluminum", wall = 0.003,
                    failures = {
                    },
                },
                {id = "XCockpitElement3", skin = "Aluminum", wall = 0.003,
                    failures = {
                    },
                },
                {id = "XCockpitElement4", skin = "Aluminum", wall = 0.003,
                    failures = {
                    },
                },
                {id = "XCockpitElement5", skin = "Aluminum", wall = 0.003,
                    failures = {
                    },
                },
                {id = "XHydroQuadrant", skin = "Steel", wall = 0.002, spar = "HeavySprocket"},
                {id = "XArmor4", skin = "Steel", wall = 0.022},
            },
        },
        ["NOSE_CENTER"] = {
            args = {148}, damage_boundary = 0.222,
            critical_damage = 1,
            construction = {durability = 0.59, skin = "Plywood"}, droppable = false,
        },
        ["HATCH_01"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 1,
            construction = {durability = 0.46, skin = "Aluminum", spar = "Truss"}, droppable = true,
            innards = {
                {id = "XJoint14", skin = "Steel", wall = 0.006, count = 2},
                {id = "XJoint15", skin = "Steel", wall = 0.006, count = 2},
            },
        },
        ["HATCH_07"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 1.5,
            construction = {durability = 0.79, skin = "Aluminum", spar = "Truss"}, droppable = true,
            innards = {
                {id = "XJoint04", skin = "Steel", wall = 0.006, count = 3},
                {id = "XJoint08", skin = "Steel", wall = 0.006, count = 3},
                {id = "XJoint16", skin = "Steel", wall = 0.006, count = 3},
            },
        },
        ["HATCH_08"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 1.5,
            construction = {durability = 0.79, skin = "Aluminum", spar = "Truss"}, droppable = true,
            innards = {
                {id = "XJoint09", skin = "Steel", wall = 0.006, count = 3},
                {id = "XJoint13", skin = "Steel", wall = 0.006, count = 3},
                {id = "XJoint17", skin = "Steel", wall = 0.006, count = 3},
            },
        },
        ["COCKPIT"] = {
            args = {--[[65]]-1}, damage_boundary = 0.01,
            critical_damage = 1,
            construction = {durability = 0.86, skin = "Glass", spar = "Truss"}, droppable = false,
            children = {"HATCH_02"},
            innards = {
                {id = "XArmor2", skin = "Steel", wall = 0.014},
                {id = "XArmor3", skin = "ReinforcedGlass", wall = 0.040},
                {id = "XCockpitElement6", skin = "Aluminum", wall = 0.003,
                    failures = {
                    },
                },
                {id = "XCockpitElement8", skin = "Aluminum", wall = 0.002, spar = "HeavySprocket",
                    failures = {
                    },
                },
                {id = "XCockpitElement9", skin = "Aluminum", wall = 0.002, spar = "HeavySprocket",
                    failures = {
                    },
                },
            },
        },
        ["HATCH_02"] = {
            args = {118}, damage_boundary = 0.01,
            critical_damage = 1,
            construction = {durability = 0.35, skin = "Glass", spar = "Truss"}, droppable = true,
        },
        ["HATCH_09"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 1,
            construction = {durability = 0.35, skin = "Aluminum", spar = "Truss"}, droppable = true,
            innards = {
                {id = "XJoint00", skin = "Steel", wall = 0.006, count = 2},
                {id = "XJoint01", skin = "Steel", wall = 0.006, count = 2},
            },
        },
        ["HATCH_10"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 1,
            construction = {durability = 0.35, skin = "Aluminum", spar = "Truss"}, droppable = true,
            innards = {
                {id = "XJoint02", skin = "Steel", wall = 0.006, count = 2},
                {id = "XJoint03", skin = "Steel", wall = 0.006, count = 2},
            },
        },
        --

        -- Fuselage - Aft
        ["FUSELAGE_BOTTOM"] = {
            args = {--[[152]]-1}, damage_boundary = 0.01,
            critical_damage = 4,
            construction = {durability = 2.10, skin = "Plywood"}, droppable = false,
            children = {"FUSELAGE_LEFT_SIDE", "FUSELAGE_RIGHT_SIDE", "FUSELAGE_TOP", "HATCH_05", "HATCH_06", "TAIL_BOTTOM"},
            innards = {
                {id = "XSparFF", skin = "DeltaWood", wall = 0.056, durability = 2.0},
                {id = "XSparFA", skin = "DeltaWood", wall = 0.056, durability = 2.0},
                {id = "XFuelElement0", skin = "Rubber", wall = 0.012, plenum = 0.0001,
                    failures = {
                    },
                },
                {id = "XPneumoHoseZ1", skin = "Rubber", wall = 0.014,
                    failures = {
                        {"PNEM_CANNONS_HOSE_PERFORATED", 0.5},
                    },
                },
                {id = "XHydroHose8", skin = "Rubber", wall = 0.014, plenum = 0.003,
                    failures = {
                    },
                },
            },
        },
        ["FUSELAGE_LEFT_SIDE"] = {
            args = {--[[158]]-1}, damage_boundary = 0.01,
            critical_damage = 4,
            construction = {durability = 3.56, skin = "Plywood"}, droppable = false,
            children = {"WING_L_00"},
            innards = {
                {id = "XCtrlLineAilerons", skin = "Steel", wall = 0.002, plenum = 0.0001},
                {id = "XOxygenTank0", skin = "CastIron", wall = 0.012},
                {id = "XOxygenTank1", skin = "CastIron", wall = 0.012},
                {id = "XElecRadio", skin = "Plastic", wall = 0.012, spar = "Rod", plenum = 0.75, durability = 0.05,
                    failures = {
                        {"VHF_CRYSTAL", 0.5, "Exclusive"},
                        {"VHF_SHORTED_CTL_BOX", 0.2, "Exclusive"},
                        {"VHF_VT_BURNED_OUT", 0.1, "Exclusive"},
                        {"VHF_VT207_DEFECTIVE", 0.01, "Exclusive"},
                        {"VHF_SQUELCH_RELAY", 0.8, "Exclusive"},
                    },
                },
                {id = "XElecBattery", skin = "Plastic", wall = 0.010},
            },
        },
        ["FUSELAGE_RIGHT_SIDE"] = {
            args = {--[[157]]-1}, damage_boundary = 0.01,
            critical_damage = 4,
            construction = {durability = 3.56, skin = "Plywood"}, droppable = false,
            children = {"WING_R_00", "HATCH_04"},
            innards = {
                {id = "XPneumoHose", skin = "Aluminum", wall = 0.002, plenum = 0.001},
                {id = "XOxygenTank2", skin = "CastIron", wall = 0.012},
                {id = "XOxygenTank3", skin = "CastIron", wall = 0.012},
                {id = "XOxygenHose", skin = "Rubber", wall = 0.055},
                {id = "XHydroTank", skin = "Aluminum", wall = 0.003,
                    failures = {
                    },
                },
                {id = "XPneumoTank0", skin = "CastIron", wall = 0.008},
                {id = "XPneumoTank1", skin = "CastIron", wall = 0.008},
            },
        },
        ["FUSELAGE_TOP"] = {
            args = {147}, damage_boundary = 0.222,
            critical_damage = 4,
            construction = {durability = 3.56, skin = "Plywood"}, droppable = false,
            children = {"HATCH_03"},
            innards = {
                {id = "XFuelTank3", skin = "Rubber", wall = 0.006, lining = "Rubber", plenum = 0.95},
                {id = "XFuelElementPumpPress", skin = "Steel", wall = 0.003,
                    failures = {
                    },
                },
            },
        },
        ["HATCH_05"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 1.5,
            construction = {durability = 1.86, skin = "Aluminum", spar = "Truss"}, droppable = true,
            innards = {
                {id = "XJoint06", skin = "Steel", wall = 0.006, count = 3},
                {id = "XJoint07", skin = "Steel", wall = 0.006, count = 3},
                {id = "XJoint05", skin = "Steel", wall = 0.006, count = 3},
            },
        },
        ["HATCH_06"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 1.5,
            construction = {durability = 1.86, skin = "Aluminum", spar = "Truss"}, droppable = true,
            innards = {
                {id = "XJoint11", skin = "Steel", wall = 0.006, count = 3},
                {id = "XJoint12", skin = "Steel", wall = 0.006, count = 3},
                {id = "XJoint10", skin = "Steel", wall = 0.006, count = 3},
            },
        },
        ["HATCH_03"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 1,
            construction = {durability = 0.81, skin = "Plywood", spar = "Truss"}, droppable = true,
        },
        ["HATCH_04"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 1.5,
            construction = {durability = 1.24, skin = "Aluminum", spar = "Truss"}, droppable = true,
        },
        --

        -- Fuselage - Tail
        ["TAIL_BOTTOM"] = {
            args = {-1},
            critical_damage = 4,
            construction = {durability = 2.47, skin = "Plywood"}, droppable = false,
            children = {"TAIL_LEFT_SIDE", "TAIL_RIGHT_SIDE", "TAIL_TOP", "TAIL"},
            innards = {
                {id = "XCtrlLineRudder", skin = "Steel", wall = 0.004, plenum = 0.005},
                {id = "XCtrlLineElevator", skin = "Steel", wall = 0.004, plenum = 0.005},
                {id = "XHydroHose7", skin = "Rubber", wall = 0.014, plenum = 0.003,
                    failures = {
                        {"UNCR_C_STRUT_HOSE_PIERCED", 1.0, "Exclusive"},
                        {"HYDR_EXTERNAL_LEAKAGE", 0.25},
                    },
                },
                {id = "XElecMasterCompass", skin = "Aluminum", wall = 0.003,
                    failures = {
                        {"COMPASS_ERRATIC_OPERATION", 0.3},
                    }
                },
            },
        },
        ["TAIL_LEFT_SIDE"] = {
            args = {-1},
            critical_damage = 4,
            construction = {durability = 2.63, skin = "Plywood"}, droppable = false,
        },
        ["TAIL_RIGHT_SIDE"] = {
            args = {-1},
            critical_damage = 4,
            construction = {durability = 2.63, skin = "Plywood"}, droppable = false,
        },
        ["TAIL_TOP"] = {
            args = {151}, damage_boundary = 0.222,
            critical_damage = 3,
            construction = {durability = 2.47, skin = "Plywood"}, droppable = false,
            children = {"FIN_L_BOTTOM"},
        },
        ["TAIL"] = {
            args = {159}, damage_boundary = 0.222,
            critical_damage = 2,
            construction = {durability = 2.00, skin = "Plywood"}, droppable = false,
            children = {"WHEEL_REAR", "STABILIZER_L_IN", "STABILIZER_R_IN"},
            innards = {
                {id = "XHydroGearJackC", skin = "Steel", wall = 0.004},
                {id = "XUCShockC", skin = "Steel", wall = 0.004},
                {id = "XElecElement6", skin = "Steel", wall = 0.001,
                    failures = {
                        {"ELEC_PITOT_HEAT_WIRING", 1.0},
                    },
                },
                {id = "XElecElement7", skin = "CastIron", wall = 0.005,
                    failures = {
                        {"ELEC_PITOT_HEAT_WIRING", 0.1},
                    },
                },
                {id = "XElecElement4", skin = "Glass", wall = 0.0004,
                    failures = {
                        {"ELEC_NAVLIGHT_WHITE_FAILURE", 1.0},
                    },
                },
            },
        },
        --

        -- Keel & Rudder
        ["FIN_L_BOTTOM"] = {
            args = {242}, damage_boundary = 0.222,
            critical_damage = 2,
            construction = {durability = 0.76, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            children = {"FIN_L_TOP"},
            innards = {
                {id = "XSparKeelIn", skin = "Plywood", wall = 0.035, plenum = 0.05, count = 2, durability = 1.2},
            },
        },
        ["FIN_L_TOP"] = {
            args = {241}, damage_boundary = 0.222,
            critical_damage = 1.5,
            children = {"RUDDER_R"},
            construction = {durability = 0.44, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            children = {"RUDDER_R"},
            innards = {
                {id = "XSparKeelOut", skin = "Plywood", wall = 0.035, plenum = 0.05, count = 2, durability = 1.2},
            },
        },
        ["RUDDER_R"] = {
            args = {248}, damage_boundary = 0.5,
            critical_damage = 1,
            construction = {durability = 0.80, skin = "Fabric", spar = "Truss"}, droppable = true,
            children = {"RUDDER"},
            innards = {
                {id = "XJointR0", skin = "Aluminum", wall = 0.012, count = 2},
                {id = "XJointR1", skin = "Aluminum", wall = 0.012, count = 2},
            },
        },
        ["RUDDER"] = {
            args = {247}, damage_boundary = 0.5,
            critical_damage = 1,
            construction = {durability = 0.72, skin = "Fabric", spar = "Truss"}, droppable = true,
        },
        --

        -- Stabilizers & Elevators
        ["STABILIZER_L_IN"] = {
            args = {236}, damage_boundary = 0.222,
            critical_damage = 2,
            construction = {durability = 1.16, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            children = {"STABILIZER_L_OUT"},
            innards = {
                {id = "XSparStabLHIn", skin = "Plywood", wall = 0.045, plenum = 0.2, durability = 1.1},
            },
        },
        ["STABILIZER_L_OUT"] = {
            args = {235}, damage_boundary = 0.222,
            critical_damage = 2,
            children = {"ELEVATOR_L_IN"},
            construction = {durability = 1.24, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            innards = {
                {id = "XSparStabLHOut", skin = "Plywood", wall = 0.045, plenum = 0.2, durability = 1.1},
            },
        },
        ["ELEVATOR_L_IN"] = {
            args = {240}, damage_boundary = 0.5,
            critical_damage = 1,
            construction = {durability = 0.82, skin = "Aluminum", spar = "Truss"}, droppable = true,
            children = {"ELEVATOR_L_OUT"},
        },
        ["ELEVATOR_L_OUT"] = {
            args = {239}, damage_boundary = 0.5,
            critical_damage = 1,
            construction = {durability = 0.93, skin = "Aluminum", spar = "Truss"}, droppable = true,
            innards = {
                {id = "XJointELH0", skin = "Aluminum", wall = 0.012, count = 3},
                {id = "XJointELH1", skin = "Aluminum", wall = 0.012, count = 3},
                {id = "XJointELH2", skin = "Aluminum", wall = 0.012, count = 3},
            },
        },
        ["STABILIZER_R_IN"] = {
            args = {234}, damage_boundary = 0.222,
            critical_damage = 2,
            construction = {durability = 1.16, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            children = {"STABILIZER_R_OUT"},
            innards = {
                {id = "XSparStabRHIn", skin = "Plywood", wall = 0.045, plenum = 0.2, durability = 1.1},
            },
        },
        ["STABILIZER_R_OUT"] = {
            args = {233}, damage_boundary = 0.222,
            critical_damage = 2,
            construction = {durability = 1.24, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            children = {"ELEVATOR_R_IN"},
            innards = {
                {id = "XSparStabRHOut", skin = "Plywood", wall = 0.045, plenum = 0.2, durability = 1.1},
            },
        },
        ["ELEVATOR_R_IN"] = {
            args = {238}, damage_boundary = 0.5,
            critical_damage = 1,
            construction = {durability = 0.82, skin = "Aluminum", spar = "Truss"}, droppable = true,
            children = {"ELEVATOR_R_OUT"},
        },
        ["ELEVATOR_R_OUT"] = {
            args = {237}, damage_boundary = 0.5,
            critical_damage = 1,
            construction = {durability = 0.93, skin = "Aluminum", spar = "Truss"}, droppable = true,
            innards = {
                {id = "XJointERH0", skin = "Aluminum", wall = 0.012, count = 3},
                {id = "XJointERH1", skin = "Aluminum", wall = 0.012, count = 3},
                {id = "XJointERH2", skin = "Aluminum", wall = 0.012, count = 3},
            },
        },
        --

        -- Left Wing
        ["WING_L_00"] = {
            args = {213}, damage_boundary = 0.222,
            critical_damage = 4,
            construction = {durability = 3.34, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            children = {"WING_L_01", "WING_L_02", "FLAP_L_IN"},
            innards = {
                {id = "XSparWLHI00", skin = "WoodPlank", wall = 0.062, count = 2, plenum = 0.18},
                {id = "XFuelTank1", skin = "Rubber", wall = 0.006, lining = "Rubber"},
                {id = "XFuelTank2", skin = "Rubber", wall = 0.006, lining = "Rubber"},
            },
        },
        ["WING_L_01"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 2,
            construction = {durability = 0.86, skin = "Aluminum", spar = "Truss"}, droppable = false,
            innards = {
                {id = "XEng0WaterRadiator", skin = "Aluminum", wall = 0.004, plenum = 0.92},
                {id = "XEng0WaterHose0", skin = "Rubber", wall = 0.014, plenum = 0.01},
                {id = "XEng0WaterHose1", skin = "Rubber", wall = 0.014, plenum = 0.01},
                {id = "XEng0OilRadiator", skin = "Aluminum", wall = 0.004},
            },
        },
        ["WING_L_02"] = {
            args = {-1, 167, 170, 171}, damage_boundary = 0.01,
            critical_damage = 2,
            construction = {durability = 2.97, skin = "Plywood", spar = "FlangeBeam"}, droppable = false,
            children = {"WING_L_03", "ENGINE_1", "COWLING_1", "COWLING_2", "GEAR_L"},
            innards = {
                {id = "XHydroFlapsJackLH", skin = "CastIron", wall = 0.006},
                {id = "XHydroHose3", skin = "Rubber", wall = 0.014, plenum = 0.001,
                    failures = {
                        {"CTRL_LANDING_FLAPS_LH_HOSE", 1.0},
                    },
                },
                {id = "XHydroGearJackLH", skin = "CastIron", wall = 0.006},
                {id = "XUCLockLHU", skin = "Aluminum", wall = 0.008,
                    failures = {
                        {"UNCR_LH_STRUT_DOWN_LOCK_FAILURE", 0.12},
                    },
                },
                {id = "XHydroHose1", skin = "Rubber", wall = 0.014, plenum = 0.001,
                    failures = {
                        {"UNCR_LH_STRUT_HOSE_PIERCED", 1.0},
                    },
                },
                {id = "XEng0OilTank", skin = "Aluminum", wall = 0.003},
                {id = "XFuelElementLHPumpPress", skin = "Steel", wall = 0.003,
                    failures = {
                    },
                },
                {id = "XPneumoHose0", skin = "Aluminum", wall = 0.002, plenum = 0.01,
                    failures = {
                    },
                },
            },
        },
        ["WING_L_03"] = {
            args = {58}, damage_boundary = 0.111,
            critical_damage = 3,
            construction = {durability = 2.47, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            children = {"WING_L_04", "FLAP_L_OUT"},
            innards = {
                {id = "XSparWLHI01", skin = "WoodPlank", wall = 0.062, count = 2, plenum = 0.18},
                {id = "XFuelTank0", skin = "Rubber", wall = 0.006, lining = "Rubber", plenum = 0.9},
                {id = "XElecElement3", skin = "Steel", wall = 0.001,
                    failures = {
                    },
                },
                {id = "XFuelElement1", skin = "Steel", wall = 0.003,
                    failures = {
                    },
                },
            },
        },
        ["WING_L_04"] = {
            args = {59}, damage_boundary = 0.111,
            critical_damage = 5,
            construction = {durability = 3.94, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            children = {"WING_L_05"},
            innards = {
                {id = "XSparWLHI02", skin = "WoodPlank", wall = 0.062, count = 2, plenum = 0.18},
                {id = "XCtrlLineAileronLH", skin = "Steel", wall = 0.002, plenum = 0.001},
                {id = "XFuelElementLHDropTankPress", skin = "Steel", wall = 0.003,
                    failures = {
                    },
                },
            },
            failures = {
                {"ELEC_PORT_LIGHT_DAMAGED", 0.05},
            },
        },
        ["WING_L_05"] = {
            args = {60}, damage_boundary = 0.111,
            critical_damage = 2,
            construction = {durability = 1.30, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            children = {"WING_L_06"},
            innards = {
                {id = "XSparWLHI03", skin = "WoodPlank", wall = 0.062, count = 2, plenum = 0.18},
            },
        },
        ["WING_L_06"] = {
            args = {61}, damage_boundary = 0.111,
            critical_damage = 1,
            construction = {durability = 0.25, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            children = {"AILERON_L"},
            innards = {
                {id = "XSparWLHI04", skin = "WoodPlank", wall = 0.031, count = 2, plenum = 0.18},
                {id = "XElecElement0", skin = "Glass", wall = 0.004,
                    failures = {
                        {"ELEC_NAVLIGHT_RED_FAILURE", 1.0},
                    },
                },
            },
        },
        ["AILERON_L"] = {
            args = {226}, damage_boundary = 0.111,
            critical_damage = 1.5,
            construction = {durability = 1.67, skin = "Aluminum", spar = "Truss"}, droppable = true,
            innards = {
                {id = "XJointALH0", skin = "Aluminum", wall = 0.008, count = 3},
                {id = "XJointALH1", skin = "Aluminum", wall = 0.008, count = 3},
                {id = "XJointALH2", skin = "Aluminum", wall = 0.008, count = 3},
            },
        },
        ["FLAP_L_IN"] = {
            args = {227}, damage_boundary = 0.111,
            critical_damage = 1,
            construction = {durability = 1.13, skin = "Plywood", spar = "Truss"}, droppable = true,
            innards = {
                {id = "XJointFlapLH2", skin = "Aluminum", wall = 0.008, count = 3},
            },
        },
        ["FLAP_L_OUT"] = {
            args = {228}, damage_boundary = 0.111,
            critical_damage = 1,
            construction = {durability = 0.73, skin = "Plywood", spar = "Truss"}, droppable = true,
            innards = {
                {id = "XJointFlapLH0", skin = "Aluminum", wall = 0.008, count = 3},
                {id = "XJointFlapLH1", skin = "Aluminum", wall = 0.008, count = 3},
            },
        },
        ["COWLING_1"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 1,
            construction = {durability = 0.51, skin = "Aluminum", spar = "Truss"}, droppable = false,
            innards = {
                {id = "XJointCowling0", skin = "Aluminum", wall = 0.004, count = 3},
                {id = "XJointCowling1", skin = "Aluminum", wall = 0.004, count = 3},
                {id = "XJointCowling2", skin = "Aluminum", wall = 0.004, count = 3},
                {id = "XJointCowling3", skin = "Aluminum", wall = 0.004, count = 3},
                {id = "XJointCowling4", skin = "Aluminum", wall = 0.004, count = 3},
                {id = "XJointCowling5", skin = "Aluminum", wall = 0.004, count = 3},
                {id = "XJointCowling6", skin = "Aluminum", wall = 0.004, count = 3},
                {id = "XJointCowling7", skin = "Aluminum", wall = 0.004, count = 3},
            },
        },
        ["COWLING_2"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 1,
            construction = {durability = 0.51, skin = "Aluminum", spar = "Truss"}, droppable = false,
        },
        --

        -- Right Wing
        ["WING_R_00"] = {
            args = {223}, damage_boundary = 0.222,
            critical_damage = 4,
            construction = {durability = 3.34, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            children = {"WING_R_01", "WING_R_02", "FLAP_R_IN"},
            innards = {
                {id = "XSparWRHI00", skin = "WoodPlank", wall = 0.062, count = 2, plenum = 0.18},
                {id = "XFuelTank4", skin = "Rubber", wall = 0.006, lining = "Rubber"},
                {id = "XFuelTank5", skin = "Rubber", wall = 0.006, lining = "Rubber"},
            },
        },
        ["WING_R_01"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 2,
            construction = {durability = 0.86, skin = "Aluminum", spar = "Truss"}, droppable = false,
            innards = {
                {id = "XEng1WaterRadiator", skin = "Aluminum", wall = 0.004, plenum = 0.92},
                {id = "XEng1WaterHose0", skin = "Rubber", wall = 0.014, plenum = 0.01},
                {id = "XEng1WaterHose1", skin = "Rubber", wall = 0.014, plenum = 0.01},
                {id = "XEng1OilRadiator", skin = "Aluminum", wall = 0.004},
            },
        },
        ["WING_R_02"] = {
            args = {-1, 161, 164, 165}, damage_boundary = 0.01,
            critical_damage = 2,
            construction = {durability = 2.97, skin = "Plywood", spar = "FlangeBeam"}, droppable = false,
            children = {"WING_R_03", "ENGINE_2", "COWLING_3", "COWLING_4", "GEAR_R"},
            innards = {
                {id = "XHydroFlapsJackRH", skin = "CastIron", wall = 0.006},
                {id = "XHydroHose6", skin = "Rubber", wall = 0.014, plenum = 0.001,
                    failures = {
                        {"CTRL_LANDING_FLAPS_RH_HOSE", 1.0},
                    },
                },
                {id = "XHydroGearJackRH", skin = "CastIron", wall = 0.006},
                {id = "XUCLockRHU", skin = "Aluminum", wall = 0.008,
                    failures = {
                        {"UNCR_RH_STRUT_DOWN_LOCK_FAILURE", 0.12},
                    },
                },
                {id = "XHydroHose2", skin = "Rubber", wall = 0.014, plenum = 0.001,
                    failures = {
                        {"UNCR_RH_STRUT_HOSE_PIERCED", 1.0},
                    },
                },
                {id = "XEng1OilTank", skin = "Aluminum", wall = 0.003},
                {id = "XFuelElementRHPumpPress", skin = "Steel", wall = 0.003,
                    failures = {
                    },
                },
                {id = "XPneumoHose1", skin = "Aluminum", wall = 0.002, plenum = 0.01,
                    failures = {
                    },
                },
            },
        },
        ["WING_R_03"] = {
            args = {53}, damage_boundary = 0.111,
            critical_damage = 3,
            construction = {durability = 2.47, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            children = {"WING_R_04", "FLAP_R_OUT"},
            innards = {
                {id = "XSparWRHI01", skin = "WoodPlank", wall = 0.062, count = 2, plenum = 0.18},
                {id = "XFuelTank6", skin = "Rubber", wall = 0.006, lining = "Rubber", plenum = 0.9},
                {id = "XElecElement2", skin = "Steel", wall = 0.001,
                    failures = {
                    },
                },
                {id = "XFuelElement2", skin = "Steel", wall = 0.003,
                    failures = {
                    },
                },
            },
        },
        ["WING_R_04"] = {
            args = {54}, damage_boundary = 0.111,
            critical_damage = 5,
            construction = {durability = 3.94, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            children = {"WING_R_05"},
            innards = {
                {id = "XSparWRHI02", skin = "WoodPlank", wall = 0.062, count = 2, plenum = 0.18},
                {id = "XCtrlLineAileronRH", skin = "Steel", wall = 0.002, plenum = 0.001},
                {id = "XFuelElementRHDropTankPress", skin = "Steel", wall = 0.003,
                    failures = {
                    },
                },
            },
            failures = {
                {"ELEC_STBD_LIGHT_DAMAGED", 0.05},
            },
        },
        ["WING_R_05"] = {
            args = {55}, damage_boundary = 0.111,
            critical_damage = 2,
            construction = {durability = 1.30, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            children = {"WING_R_06"},
            innards = {
                {id = "XSparWRHI03", skin = "WoodPlank", wall = 0.062, count = 2, plenum = 0.18},
            },
        },
        ["WING_R_06"] = {
            args = {56}, damage_boundary = 0.111,
            critical_damage = 1,
            construction = {durability = 0.25, skin = "Plywood", spar = "FlangeBeam"}, droppable = true,
            children = {"AILERON_R"},
            innards = {
                {id = "XSparWRHI04", skin = "WoodPlank", wall = 0.031, count = 2, plenum = 0.18},
                {id = "XElecElement1", skin = "Glass", wall = 0.004,
                    failures = {
                        {"ELEC_NAVLIGHT_GREEN_FAILURE", 1.0},
                    },
                },
            },
        },
        ["AILERON_R"] = {
            args = {216}, damage_boundary = 0.111,
            critical_damage = 1.5,
            construction = {durability = 1.67, skin = "Aluminum", spar = "Truss"}, droppable = true,
            innards = {
                {id = "XJointARH0", skin = "Aluminum", wall = 0.008, count = 3},
                {id = "XJointARH1", skin = "Aluminum", wall = 0.008, count = 3},
                {id = "XJointARH2", skin = "Aluminum", wall = 0.008, count = 3},
            },
        },
        ["FLAP_R_IN"] = {
            args = {217}, damage_boundary = 0.111,
            critical_damage = 1,
            construction = {durability = 1.13, skin = "Plywood", spar = "Truss"}, droppable = true,
            innards = {
                {id = "XJointFlapRH2", skin = "Aluminum", wall = 0.008, count = 3},
            },
        },
        ["FLAP_R_OUT"] = {
            args = {218}, damage_boundary = 0.111,
            critical_damage = 1,
            construction = {durability = 0.73, skin = "Plywood", spar = "Truss"}, droppable = true,
            innards = {
                {id = "XJointFlapRH0", skin = "Aluminum", wall = 0.008, count = 3},
                {id = "XJointFlapRH1", skin = "Aluminum", wall = 0.008, count = 3},
            },
        },
        ["COWLING_3"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 1,
            construction = {durability = 0.51, skin = "Aluminum", spar = "Truss"}, droppable = false,
        },
        ["COWLING_4"] = {
            args = {-1}, damage_boundary = 0.01,
            critical_damage = 1,
            construction = {durability = 0.51, skin = "Aluminum", spar = "Truss"}, droppable = false,
        },
        --

        -- Engine 1 & Rotary parts
        ["ENGINE_1"] = {
            args = {168, 166, 169},
            critical_damage = 5,
            construction = {durability = 2.03, skin = "Aluminum", spar = "Truss"}, droppable = false,
            children = {"BLADE_1_IN", "BLADE_2_IN", "BLADE_3_IN"},
            innards = {
                {id = "XSparEngine0", skin = "Steel", wall = 0.005, plenum = 0.007, count = 2, durability = 2.0, spar = "HeavySprocket"},
                {id = "XEng0Case", skin = "CastIron", wall = 0.010},
                {id = "XEng0HeadsLH", count = 6, skin = "Aluminum", wall = 0.010, plenum = 0.75, durability = 0.9},
                {id = "XEng0HeadsRH", count = 6, skin = "Aluminum", wall = 0.010, plenum = 0.75, durability = 0.9},
                {id = "XEng0PropGear", skin = "Steel", wall = 0.012, spar = "HeavySprocket"},
                {id = "XEng0Governor", skin = "Steel", wall = 0.012, spar = "HeavySprocket"},
                {id = "XEng0Magneto0", skin = "Plastic", wall = 0.010},
                {id = "XEng0Magneto1", skin = "Plastic", wall = 0.010},
                {id = "XEng0Supercharger", skin = "Steel", wall = 0.004},
                {id = "XEng0Carb", skin = "Steel", wall = 0.014},
                {id = "XEng0Intake", skin = "Aluminum", wall = 0.002, plenum = 0.06,
                    failures = {
                        {"INST_TACH0_LOOM_SEVERED", 0.05},
                        {"INST_TACH0_POOR_CONNECTION", 0.6},
                        {"INST_TACH0_RESISTANCE_MISMATCH", 0.15},
                    },
                },
                {id = "XEng0FuelPump", skin = "Steel", wall = 0.012},
                {id = "XEng0OilPump", skin = "Steel", wall = 0.005},
                {id = "XEng0WaterTank", skin = "Plastic", wall = 0.012},
                {id = "XEng0WaterPump", skin = "Steel", wall = 0.010},
                {id = "XElecEng0Starter", skin = "Steel", wall = 0.032},
                {id = "XCtrlLineEng0", skin = "Steel", wall = 0.007, plenum = 0.01},
                {id = "XPneumoCompressor", skin = "Steel", wall = 0.005, count = 2},
                {id = "XHydroPump0", skin = "Steel", wall = 0.035, count = 2},
                {id = "XHydroHose4", skin = "Rubber", wall = 0.014, plenum = 0.001,
                    failures = {
                    },
                },
                {id = "XFuelElementLHPump", skin = "Steel", wall = 0.003,
                    failures = {
                    },
                },
                {id = "XFuelLine0", skin = "Rubber", wall = 0.014, plenum = 0.25},
                {id = "XEng0OilHose", skin = "Rubber", wall = 0.012, plenum = 0.1},
            },
        },
        ["BLADE_1_IN"] = {
            args = {--[[270]]-1}, damage_boundary = 0.1,
            critical_damage = 2,
            construction = {durability = 0.1, skin = "WoodPlank"}, droppable = false,
            children = {"BLADE_1_OUT"},
        },
        ["BLADE_1_OUT"] = {
            args = {380},
            critical_damage = 2,
            construction = {durability = 999, min_max_arg_to_break = {minimal = 0.33, maximal = 0.66}},
        },
        ["BLADE_2_IN"] = {
            args = {--[[271]]-1}, damage_boundary = 0.1,
            critical_damage = 2,
            construction = {durability = 0.1, skin = "WoodPlank"}, droppable = false,
            children = {"BLADE_2_OUT"},
        },
        ["BLADE_2_OUT"] = {
            args = {381},
            critical_damage = 2,
            construction = {durability = 999, min_max_arg_to_break = {minimal = 0.64, maximal = 0.88}},
        },
        ["BLADE_3_IN"] = {
            args = {--[[272]]-1}, damage_boundary = 0.1,
            critical_damage = 2,
            construction = {durability = 0.1, skin = "WoodPlank"}, droppable = false,
            children = {"BLADE_3_OUT"},
        },
        ["BLADE_3_OUT"] = {
            args = {382},
            critical_damage = 2,
            construction = {durability = 999, min_max_arg_to_break = {minimal = 0.866, maximal = 0.134}},
        },
        --

        -- Engine 2 & Rotary parts
        ["ENGINE_2"] = {
            args = {162, 160, 163},
            critical_damage = 5,
            construction = {durability = 2.03, skin = "Aluminum", spar = "Truss"}, droppable = false,
            children = {"BLADE_4_IN", "BLADE_5_IN", "BLADE_6_IN"},
            innards = {
                {id = "XSparEngine1", skin = "Steel", wall = 0.005, plenum = 0.007, count = 2, durability = 2.0, spar = "HeavySprocket"},
                {id = "XEng1Case", skin = "CastIron", wall = 0.010},
                {id = "XEng1HeadsLH", count = 6, skin = "Aluminum", wall = 0.010, plenum = 0.75, durability = 0.9},
                {id = "XEng1HeadsRH", count = 6, skin = "Aluminum", wall = 0.010, plenum = 0.75, durability = 0.9},
                {id = "XEng1PropGear", skin = "Steel", wall = 0.012, spar = "HeavySprocket"},
                {id = "XEng1Governor", skin = "Steel", wall = 0.012, spar = "HeavySprocket"},
                {id = "XEng1Magneto0", skin = "Plastic", wall = 0.010},
                {id = "XEng1Magneto1", skin = "Plastic", wall = 0.010},
                {id = "XEng1Supercharger", skin = "Steel", wall = 0.004},
                {id = "XEng1Carb", skin = "Steel", wall = 0.014},
                {id = "XEng1Intake", skin = "Aluminum", wall = 0.002, plenum = 0.06,
                    failures = {
                        {"INST_TACH1_LOOM_SEVERED", 0.05},
                        {"INST_TACH1_POOR_CONNECTION", 0.6},
                        {"INST_TACH1_RESISTANCE_MISMATCH", 0.15},
                    },
                },
                {id = "XEng1FuelPump", skin = "Steel", wall = 0.012},
                {id = "XEng1OilPump", skin = "Steel", wall = 0.005},
                {id = "XEng1WaterTank", skin = "Plastic", wall = 0.012},
                {id = "XEng1WaterPump", skin = "Steel", wall = 0.010},
                {id = "XElecEng1Starter", skin = "Steel", wall = 0.032},
                {id = "XCtrlLineEng1", skin = "Steel", wall = 0.007, plenum = 0.01},
                {id = "XHydroPump1", skin = "Steel", wall = 0.035, count = 2,
                    failures = {
                    },
                },
                {id = "XHydroHose5", skin = "Rubber", wall = 0.014, plenum = 0.001,
                    failures = {
                    },
                },
                {id = "XElecGenerator", skin = "Steel", wall = 0.005},
                {id = "XFuelElementRHPump", skin = "Steel", wall = 0.003,
                    failures = {
                    },
                },
                {id = "XFuelLine1", skin = "Rubber", wall = 0.014, plenum = 0.25},
                {id = "XEng1OilHose", skin = "Rubber", wall = 0.012, plenum = 0.1},
            },
        },
        ["BLADE_4_IN"] = {
            args = {--[[270]]-1}, damage_boundary = 0.1,
            critical_damage = 2,
            construction = {durability = 0.1, skin = "WoodPlank"}, droppable = false,
            children = {"BLADE_4_OUT"},
        },
        ["BLADE_4_OUT"] = {
            args = {383},
            critical_damage = 2,
            construction = {durability = 999, min_max_arg_to_break = {minimal = 0.33, maximal = 0.66}},
        },
        ["BLADE_5_IN"] = {
            args = {--[[271]]-1}, damage_boundary = 0.1,
            critical_damage = 2,
            construction = {durability = 0.1, skin = "WoodPlank"}, droppable = false,
            children = {"BLADE_5_OUT"},
        },
        ["BLADE_5_OUT"] = {
            args = {384},
            critical_damage = 2,
            construction = {durability = 999, min_max_arg_to_break = {minimal = 0.64, maximal = 0.88}},
        },
        ["BLADE_6_IN"] = {
            args = {--[[272]]-1}, damage_boundary = 0.1,
            critical_damage = 2,
            construction = {durability = 0.1, skin = "WoodPlank"}, droppable = false,
            children = {"BLADE_6_OUT"},
        },
        ["BLADE_6_OUT"] = {
            args = {385},
            critical_damage = 2,
            construction = {durability = 999, min_max_arg_to_break = {minimal = 0.866, maximal = 0.134}},
        },
        --

        -- Undercarriage
        --["GEAR_REAR"] = {
        --    args = {-1},
        --    critical_damage = 2,
        --    construction = {durability = 10.0, skin = "Steel", spar = "Rod"}, droppable = false,
        --    children = {"WHEEL_REAR"},
        --    --innards = {
        --        --{id = "XUCShockC", skin = "Steel", wall = 0.030},
        --    --},
        --},
        ["WHEEL_REAR"] = {
            args = {136}, damage_boundary = 1.0,
            critical_damage = 0.35,
            construction = {durability = 0.35, skin = "Rubber"},
        },
        ["GEAR_L"] = {
            args = {-1},
            critical_damage = 3,
            construction = {durability = 10.0, skin = "Steel", spar = "Rod"}, droppable = false,
            children = {"WHEEL_L"},
            innards = {
                {id = "XPneumoHoseWBrakeLH", skin = "Rubber", wall = 0.006},
                {id = "XUCShockLH", skin = "Steel", wall = 0.005},
            },
        },
        ["WHEEL_L"] = {
            args = {134}, damage_boundary = 1.0,
            critical_damage = 0.5,
            construction = {durability = 0.5, skin = "Rubber"},
            innards = {
                {id = "XUCWheelDrumLH", skin = "CastIron", wall = 0.012, spar = "HeavySprocket"},
            },
        },
        ["GEAR_R"] = {
            args = {-1},
            critical_damage = 3,
            construction = {durability = 10.0, skin = "Steel", spar = "Rod"}, droppable = false,
            children = {"WHEEL_R"},
            innards = {
                {id = "XPneumoHoseWBrakeRH", skin = "Rubber", wall = 0.006},
                {id = "XUCShockRH", skin = "Steel", wall = 0.005},
            },
        },
        ["WHEEL_R"] = {
            args = {135}, damage_boundary = 1.0,
            critical_damage = 0.5,
            construction = {durability = 0.5, skin = "Rubber"},
            innards = {
                {id = "XUCWheelDrumRH", skin = "CastIron", wall = 0.012, spar = "HeavySprocket"},
            },
        },
        --
    }),

    DamageParts = {
        [1] = MOSQUITOFBMKVI .. "_oblomok_wing_R", -- wing R
        [2] = MOSQUITOFBMKVI .. "_oblomok_wing_L", -- wing L
        --[3] = "", -- nose
        [4] = MOSQUITOFBMKVI .. "_oblomok_tail", -- tail
    },



    Failures = verbose_to_failures_table({
        --{ id = "CTRL_AILERON_ROD_DESTROYED",            label = _("Aileron control failure"),                           },
        --{ id = "CTRL_AILERON_TRIM_FAILURE",             label = _("Aileron trim failure"),                              },
        --{ id = "CTRL_ELEVATOR_ROD_DESTROYED",           label = _("Elevator control failure"),                          },
        --{ id = "CTRL_ELEVATOR_TRIM_FAILURE",            label = _("Elevator trim failure"),                             },
        --{ id = "CTRL_RUDDER_ROD_DESTROYED",             label = _("Rudder control failure"),                            },
        --{ id = "CTRL_RUDDER_TRIM_FAILURE",              label = _("Rudder trim failure"),                               },
        --{ id = "CTRL_LANDING_FLAPS_LH_DRIVE_DAMAGED",   label = _("Left flap cylinder damaged"),                        },
        --{ id = "CTRL_LANDING_FLAPS_LH_MECHANICAL",      label = _("Left flap mechanical links damaged"),                },
        --{ id = "CTRL_LANDING_FLAPS_RH_DRIVE_DAMAGED",   label = _("Right flap cylinder damaged"),                       },
        --{ id = "CTRL_LANDING_FLAPS_RH_MECHANICAL",      label = _("Left flap mechanical links damaged"),                },

        { id = "CTRL_LANDING_FLAPS_LH_HOSE",            label = _("Left flap hydraulic hose damaged"),                  },
        { id = "CTRL_LANDING_FLAPS_RH_HOSE",            label = _("Right flap hydraulic hose damaged"),                 },



        --{ id = "ELEC_BATTERY_OVERHEAT",                 label = _("Battery overheated"),                                },
        --{ id = "ELEC_BATTERY_DESTROYED",                label = _("Battery failure"),                                   },
        --{ id = "ELEC_GENERATOR_FAILURE",                label = _("Generator failure"),                                 },
        --{ id = "ELEC_GENERATOR_REGULATOR_MALFUNCTION",  label = _("Generator regulator malfunction"),                   },
        --{ id = "ELEC_BOOSTER_FUEL_PUMP_0_FAILURE",      label = _("Main booster pump motor failure"),                   },
        --{ id = "ELEC_BOOSTER_FUEL_PUMP_0_COIL_FAILURE", label = _("Main booster pump electrical malfunction"),          },
        --{ id = "ELEC_BOOSTER_FUEL_PUMP_1_FAILURE",      label = _("Auxiliary booster pump motor failure"),              },
        --{ id = "ELEC_BOOSTER_FUEL_PUMP_1_COIL_FAILURE", label = _("Auxiliary booster pump electrical malfunction"),     },
        --{ id = "ELEC_PITOT_HEAT_WIRING",                label = _("Pitot heating wire broken"),                         },
        --{ id = "ELEC_PITOT_HEAT_ELEMENT",               label = _("Pitot heating element burned out"),                  },
        --{ id = "ELEC_STARTER_LOOM_SEVERED",             label = _("Starter control wire broken"),                       },
        --{ id = "ELEC_BOMBABWGERAT_RELEASE_MALFUNCTION", label = _("Ordnance arming panel malfunction"),                 },
        --{ id = "ELEC_BOMBABWGERAT_RELEASE_FAILURE",     label = _("Ordnance arming panel power circuit severed"),       },

        { id = "ELEC_PORT_LIGHT_DAMAGED",               label = _("Port landing light damaged"),                        },
        { id = "ELEC_STBD_LIGHT_DAMAGED",               label = _("Starboard landing light damaged"),                   },
        --{ id = "ELEC_UC_LAMP_FAILURE",                  label = _("Undercarriage control lamp broken"),                 },
        --{ id = "ELEC_GOVERNOR_BOX_DAMAGED",             label = _("Governor control box damaged"),                      },
        --{ id = "ELEC_MSB_CB_BUSTED",                    label = _("Main switch box breakers panel busted"),             },
        --{ id = "ELEC_MSB_CONTROLS_FAILURE",             label = _("Main switch box control lamps assembly failure"),    },
        --{ id = "ELEC_MSB_DAMAGED",                      label = _("Main switch box damaged"),                           },
        --{ id = "ELEC_SIGNAL_LIGHTS_FAILURE",            label = _("Signal lights failure"),                             },
        --{ id = "ELEC_SIGNAL_LIGHTS_MALFUNCTION",        label = _("Signal lights box damaged"),                         },
        --{ id = "ELEC_RED_SIGNAL_LIGHT_BROKEN",          label = _("Red signal light bulb broken"),                      },
        --{ id = "ELEC_GREEN_SIGNAL_LIGHT_BROKEN",        label = _("Green signal light bulb broken"),                    },
        --{ id = "ELEC_AMBER_SIGNAL_LIGHT_BROKEN",        label = _("Amber signal light bulb broken"),                    },
        --{ id = "ELEC_CABIN_LIGHTS_FAILURE",             label = _("Cabin illumination circuit severed"),                },
        --{ id = "ELEC_LH_CABIN_LIGHT_POOR_CONTACT",      label = _("Left cabin illumination lamp poor contact"),         },
        --{ id = "ELEC_RH_CABIN_LIGHT_POOR_CONTACT",      label = _("Right cabin illumination lamp poor contact"),        },
        --{ id = "ELEC_OIL_GAUGE_FAILURE",                label = _("Oil temperature gauge failure"),                     },
        --{ id = "ELEC_C5_LAMP_POOR_CONTACT",             label = _("Left UV lamp poor contact"),                         },
        --{ id = "ELEC_C5_LAMP_1_POOR_CONTACT",           label = _("Right UV lamp poor contact"),                        },
        { id = "VHF_CRYSTAL",                           label = _("Radio. Crystal or tube failure"),                    },
        { id = "VHF_SHORTED_CTL_BOX",                   label = _("Radio. Shorted control box"),                        },
        { id = "VHF_VT_BURNED_OUT",                     label = _("Radio. Receiver burned out"),                        },
        { id = "VHF_VT207_DEFECTIVE",                   label = _("Radio. Squelch tube burned out"),                    },
        { id = "VHF_SQUELCH_RELAY",                     label = _("Radio. Squelch relay not working"),                  },



        --{ id = "FUEL_ENGINE0_FUEL_PUMP_FAILURE",        label = _("Carburettor pump failure"),                          },
        --{ id = "FUEL_ENGINE0_FUEL_PUMP_DEGRADED",       label = _("Carburettor pump crippled"),                         },
        --{ id = "FUEL_BOOSTER_FUEL_PUMP_0_FAILURE",      label = _("Main booster pump damaged"),                         },
        --{ id = "FUEL_BOOSTER_FUEL_PUMP_0_DEGRADED",     label = _("Main booster pump mechanical malfunction"),          },
        --{ id = "FUEL_BOOSTER_FUEL_PUMP_1_FAILURE",      label = _("Auxiliary booster pump damaged"),                    },
        --{ id = "FUEL_BOOSTER_FUEL_PUMP_1_DEGRADED",     label = _("Auxiliary booster pump mechanical malfunction"),     },
        --{ id = "FUEL_BOOSTER_FUEL_PUMP_2_FAILURE",      label = _("External tank pressure pump damaged"),               },
        --{ id = 'FUEL_TANK_00_LEAK_STOPPED',             label = _('Main fuel tank leak stopped'), hidden = true,        },
        --{ id = 'FUEL_TANK_00_MINOR_LEAK',               label = _('Main fuel tank minor leak'),   hidden = true,        },
        --{ id = 'FUEL_TANK_00_MEDIUM_LEAK',              label = _('Main fuel tank major leak'),   hidden = true,        },
        --{ id = 'FUEL_TANK_00_MAJOR_LEAK',               label = _('Main fuel tank ruptured'),     hidden = true,        },
        --{ id = 'FUEL_TANK_00_FIRE_STOPPED',             label = _('Main fuel tank fire stopped'), hidden = true,        },
        --{ id = 'FUEL_TANK_00_FIRE',                     label = _('Main fuel tank is on fire'),   hidden = true,        },
        --{ id = 'FUEL_TANK_00_EXPLODED',                 label = _('Main fuel tank exploded'),     hidden = true,        },
        --{ id = 'FUEL_TANK_01_LEAK_STOPPED',             label = _('Auxiliary fuel tank leak stopped'), hidden = true,   },
        --{ id = 'FUEL_TANK_01_MINOR_LEAK',               label = _('Auxiliary fuel tank minor leak'),   hidden = true,   },
        --{ id = 'FUEL_TANK_01_MEDIUM_LEAK',              label = _('Auxiliary fuel tank major leak'),   hidden = true,   },
        --{ id = 'FUEL_TANK_01_MAJOR_LEAK',               label = _('Auxiliary fuel tank ruptured'),     hidden = true,   },
        --{ id = 'FUEL_TANK_01_FIRE_STOPPED',             label = _('Auxiliary fuel tank fire stopped'), hidden = true,   },
        --{ id = 'FUEL_TANK_01_FIRE',                     label = _('Auxiliary fuel tank is on fire'),   hidden = true,   },
        --{ id = 'FUEL_TANK_01_EXPLODED',                 label = _('Auxiliary fuel tank exploded'),     hidden = true,   },
        --{ id = 'FUEL_NITRO_TANK_LEAK_STOPPED',          label = _('Water tank leak stopped'), hidden = true,            },
        --{ id = 'FUEL_NITRO_TANK_MINOR_LEAK',            label = _('Water tank minor leak'),   hidden = true,            },
        --{ id = 'FUEL_NITRO_TANK_MAJOR_LEAK',            label = _('Water tank ruptured'),     hidden = true,            },



        --{ id = "HYDR_PUMP_FAILURE",                     label = _("Hydraulic pump failure"),                            },



        --{ id = "INST_VARIOMETR_DEPRESSURIZATION",       label = _("Variometer depressurization"),                       },
        --{ id = "INST_VARIOMETER_CLOGGED",               label = _("Variometer hose clogged"),                           },
        --{ id = "INST_SPEEDOMETER_DEPRESSURIZATION",     label = _("Speedometer depressurization"),                      },
        --{ id = "INST_PITOT_DAMAGE",                     label = _("Pitot damaged"),                                     },
        --{ id = "INST_DI_EXCESSIVE_DRIFT",               label = _("Directional gyro fail"),                             },
        --{ id = "INST_DI_MECHANICAL_FAILURE",            label = _("Directional gyro mechanism fail"),                   },
        { id = "INST_TACH0_LOOM_SEVERED",               label = _("Port tachometer circuit failure"),                   },
        { id = "INST_TACH0_POOR_CONNECTION",            label = _("Port tachometer poor connection"),                   },
        { id = "INST_TACH0_RESISTANCE_MISMATCH",        label = _("Port tachometer indicator adjustment fault"),        },
        { id = "INST_TACH1_LOOM_SEVERED",               label = _("Starboard tachometer circuit failure"),              },
        { id = "INST_TACH1_POOR_CONNECTION",            label = _("Starboard tachometer poor connection"),              },
        { id = "INST_TACH1_RESISTANCE_MISMATCH",        label = _("Starboard tachometer indicator adjustment fault"),   },
        --{ id = "INST_HUD_FAILURE",                      label = _("Gun sight loom severed"),                            },
        --{ id = "INST_COMPASS_MALFUNCTION",              label = _("Compass destroyed"),                                 },

        { id = "COMPASS_ERRATIC_OPERATION",             label = _("Repeater compass wires shorted or open. Erratic operation"),},
        --{ id = "INST_CLOCK_MALFUNCTION",                label = _("Clock damaged"),                                     },
        --{ id = "HORIZON_BAR_NOT_SETTLE",                label = _("Artif Horizon. Horizon bar does not settle"),        },
        --{ id = "TURNIND_POINTER_FAILS_NO_VACUUM",       label = _("Turn indicator. No vacuum to instrument"),           },
        --{ id = "TURNIND_POINTER_FAILS_DEFECTIVE",       label = _("Turn indicator. Defective instrument"),              },
        --{ id = "TURNIND_INCORRECT_SENS_DEFECTIVE",      label = _("Turn indicator. Incorrect sensitivity"),             },
        --{ id = "TURNIND_INCORRECT_SENS_VAC_HIGH",       label = _("Turn indicator. Vacuum high"),                       },
        --{ id = "TURNIND_INCORRECT_SENS_VAC_LOW",        label = _("Turn indicator. Vacuum low"),                        },
        --{ id = "TURNIND_POINTER_NOT_SET_ZERO",          label = _("Turn indicator. Pointer does not set on 0(N/F)"),    },
        --{ id = "TURNIND_POINTER_VIBRATES",              label = _("Turn indicator. Excessive vibration"),               },
        --{ id = 'ELEC_RETICLE_BULB_FAILURE',             label = _('N-9. Lamp defective'),                               },
        --{ id = "K14_NO_POWER_SUPPLY",                   label = _("K-14. No power supply."),                            },
        --{ id = "K14_FIXED_LAMP_DEFECTIVE",              label = _("K-14. Fixed reticle lamp defective"),                },
        --{ id = "K14_MOV_LAMP_DEFECTIVE",                label = _("K-14. Movable reticle lamp defective"),              },
        --{ id = "K14_MOTOR_DEFECTIVE",                   label = _("K-14. Motor defective"),                             },
        --{ id = "SUCTION_PUMP_FAILURE",                  label = _("Suction pump failure"),                              },



        --{ id = "OXYN_PRIMARY_CONTAINER_PERFORATED",     label = _("Oxygen cylinder perforated"),                        },
        --{ id = "OXYN_PRIMARY_CONTAINER_MINOR_LEAK",     label = _("Oxygen cylinder minor leak"),                        },
        --{ id = "OXYN_RIGHT_CONTAINER_PERFORATED",       label = _("Oxygen wing cylinder perforated"),                   },



        --{ id = "UNCR_CONTROLLER_FAILURE",               label = _("Undercarriage selector valve failure"),              },

        { id = "UNCR_DN_HOSES_CLOGGED",                 label = _("Undercarriage extension hose clogged"),              },
        { id = "UNCR_UP_HOSES_CLOGGED",                 label = _("Undercarriage retraction hose clogged"),             },



        { id = "WEAP_GUN_00_DAMAGED",                   label = _("Hispano cannon (No. 1) inoperable"),                 },
        { id = "WEAP_GUN_00_AMMO_BELT_SEVERED",         label = _("Hispano cannon (No. 1) ammo supply damaged"),        },
        { id = "WEAP_GUN_01_DAMAGED",                   label = _("Hispano cannon (No. 2) inoperable"),                 },
        { id = "WEAP_GUN_01_AMMO_BELT_SEVERED",         label = _("Hispano cannon (No. 2) ammo supply damaged"),        },
        { id = "WEAP_GUN_02_DAMAGED",                   label = _("Hispano cannon (No. 3) inoperable"),                 },
        { id = "WEAP_GUN_02_AMMO_BELT_SEVERED",         label = _("Hispano cannon (No. 3) ammo supply damaged"),        },
        { id = "WEAP_GUN_03_DAMAGED",                   label = _("Hispano cannon (No. 4) inoperable"),                 },
        { id = "WEAP_GUN_03_AMMO_BELT_SEVERED",         label = _("Hispano cannon (No. 4) ammo supply damaged"),        },
        { id = "WEAP_GUN_04_DAMAGED",                   label = _("Browning MG (No. 1) inoperable"),                    },
        { id = "WEAP_GUN_04_AMMO_BELT_SEVERED",         label = _("Browning MG (No. 1) ammo supply damaged"),           },
        { id = "WEAP_GUN_05_DAMAGED",                   label = _("Browning MG (No. 2) inoperable"),                    },
        { id = "WEAP_GUN_05_AMMO_BELT_SEVERED",         label = _("Browning MG (No. 2) ammo supply damaged"),           },
        { id = "WEAP_GUN_06_DAMAGED",                   label = _("Browning MG (No. 3) inoperable"),                    },
        { id = "WEAP_GUN_06_AMMO_BELT_SEVERED",         label = _("Browning MG (No. 3) ammo supply damaged"),           },
        { id = "WEAP_GUN_07_DAMAGED",                   label = _("Browning MG (No. 4) inoperable"),                    },
        { id = "WEAP_GUN_07_AMMO_BELT_SEVERED",         label = _("Browning MG (No. 4) ammo supply damaged"),           },



        --{ id = "ENG0_JAMMED",                           label = _("Engine destroyed"),                                  },
        --{ id = "ENG0_MAGNETO0",                         label = _("Magneto No. 1 failure"),                             },
        --{ id = "ENG0_MAGNETO1",                         label = _("Magneto No. 2 failure"),                             },
        --{ id = "ENG0_GOVERNOR_MALFUNCTION",             label = _("Propeller governor malfunction"),                    },
        --{ id = "ENG0_GOVERNOR_FAILURE",                 label = _("Propeller governor failure"),                        },
        --{ id = "ENG0_GOVERNOR_REGULATOR_MALFUNCTION",   label = _("Propeller governor regulator failure"),              },
        --{ id = "ENG0_STARTER_CLUTCH_FAILURE",           label = _("Starter clutch failure"),                            },
        --{ id = "ENG0_STARTER_MOTOR_FAILURE",            label = _("Starter motor failure"),                             },
        --{ id = "ENG0_BOOST_REGULATOR_MALFUNCTION",      label = _("Boost regulator malfunction"),                       },
        --{ id = "ENG0_OIL_RADIATOR_0_PIERCED",           label = _("Left oil radiator pierced"),                         },
        --{ id = "ENG0_OIL_HOSE_0_LEAK",                  label = _("Left oil hose leak"),                                },
        --{ id = "ENG0_OIL_HOSE_0_BURST",                 label = _("Left oil line burst open"),                          },
        --{ id = "ENG0_OIL_RADIATOR_1_PIERCED",           label = _("Right oil radiator pierced"),                        },
        --{ id = "ENG0_OIL_HOSE_1_LEAK",                  label = _("Right oil hose leak"),                               },
        --{ id = "ENG0_OIL_HOSE_1_BURST",                 label = _("Right oil line burst open"),                         },
        --CTRL_COMPASS_DESTROYED
        --ELEC_MASTER_COMPASS_HARNESS_CUT", Failure
        --name = "COMPASS_ERRATIC_OPERATION", Failu
         --= "INST_MASTER_COMPASS_FAILURE", Failure
        --_name = "INST_COMPASS_MALFUNCTION", Failu
--{Failure = VHF_CRYSTAL, Failure_name = "VHF_CRYSTAL", Failure_editor_name = _("Radio. Crystal or tube failure"),  Element = 3, Integrity_Treshold = 0.3, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
--{Failure = VHF_SHORTED_CTL_BOX, Failure_name = "VHF_SHORTED_CTL_BOX", Failure_editor_name = _("Radio. Shorted control box"),  Element = 3, Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
--{Failure = VHF_VT_BURNED_OUT, Failure_name = "VHF_VT_BURNED_OUT", Failure_editor_name = _("Radio. Receiver burned out"),  Element = 3, Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
--{Failure = VHF_VT207_DEFECTIVE, Failure_name = "VHF_VT207_DEFECTIVE", Failure_editor_name = _("Radio. Squelch tube burned out"),  Element = 3, Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
--{Failure = VHF_SQUELCH_RELAY, Failure_name = "VHF_SQUELCH_RELAY", Failure_editor_name = _("Radio. Squelch relay not working"),  Element = 3, Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
--
--
        
        
    }),



    lights_data = {
        typename = "collection",
        lights = {
            [WOLALIGHT_LANDING_LIGHTS] = {
                typename = "collection",
                lights = {
                    { -- 0 -- LH Spot Light
                        typename = "collection",
                        lights = {
                            {
                                typename = "spotlight", connector = "Light_208", argument = 208,
                                proto = lamp_prototypes.LFS_P_27_600, angle_max = math.rad(18.0), angle_min = math.rad(11.0), angle_change_rate = math.rad(32.0 * 0.25),
                                power_up_t = 2.8, movable = true,
                            },
                            {
                                typename = "spotlight", connector = "Light_208",
                                proto = lamp_prototypes.LFS_P_27_600, range = 24.0, angle_max = math.rad(136.0), angle_min = math.rad(116.0), angle_change_rate = math.rad(-52.0),
                                power_up_t = 2.8, movable = true,
                            },
                            {
                                typename = "Omni", connector = "Light_208", pos_correction = {0.2, 0.0, 0.0},
                                proto = lamp_prototypes.LFS_P_27_600, range = 6.0,
                            },
                        },
                    },
                    { -- 1 -- RH Spot Light
                        typename = "collection",
                        lights = {
                            {
                                typename = "spotlight", connector = "Light_209", argument = 209,
                                proto = lamp_prototypes.LFS_P_27_600, angle_max = math.rad(18.0), angle_min = math.rad(11.0), angle_change_rate = math.rad(32.0 * 0.25),
                                power_up_t = 2.8, movable = true,
                            },
                            {
                                typename = "spotlight", connector = "Light_209",
                                proto = lamp_prototypes.LFS_P_27_600, range = 24.0, angle_max = math.rad(136.0), angle_min = math.rad(116.0), angle_change_rate = math.rad(-52.0),
                                power_up_t = 2.8, movable = true,
                            },
                            {
                                typename = "Omni", connector = "Light_209", pos_correction = {0.2, 0.0, 0.0},
                                proto = lamp_prototypes.LFS_P_27_600, range = 6.0,
                            },
                        },
                    },
                },
            },
            [WOLALIGHT_TAXI_LIGHTS] = {
                typename = "collection",
                lights = {
                    { -- 0 -- LH Spot Light
                        typename = "collection",
                        lights = {
                            {
                                typename = "spotlight", connector = "Light_208", argument = 208,
                                proto = lamp_prototypes.LFS_P_27_600, angle_max = math.rad(18.0), angle_min = math.rad(11.0), angle_change_rate = math.rad(32.0 * 0.25),
                                power_up_t = 2.8, movable = true,
                            },
                            {
                                typename = "spotlight", connector = "Light_208",
                                proto = lamp_prototypes.LFS_P_27_600, range = 24.0, angle_max = math.rad(136.0), angle_min = math.rad(116.0), angle_change_rate = math.rad(-52.0),
                                power_up_t = 2.8, movable = true,
                            },
                            {
                                typename = "Omni", connector = "Light_208", pos_correction = {0.2, 0.0, 0.0},
                                proto = lamp_prototypes.LFS_P_27_600, range = 6.0,
                            },
                        },
                    },
                },
            },
            [WOLALIGHT_NAVLIGHTS] = {
                typename = "Collection",
                lights = {
                    { -- 0 -- Left Position Light (RED)
                        typename = "Spot", connector = "Light_190", argument = 190,
                        proto = lamp_prototypes.BANO_7M_red, angle_max = math.rad(160.0), angle_min = math.rad(90.0),
                    },
                    { -- 1 -- Right Position Light (GREEN)
                        typename = "Spot", connector = "Light_191", argument = 191,
                        proto = lamp_prototypes.BANO_7M_green, angle_max = math.rad(160.0), angle_min = math.rad(90.0),
                    },
                    { -- 2 -- Tail Position Light (WHITE)
                        typename = "Collection",
                        lights = {
                            {
                                typename = "Spot", connector = "Light_192", argument = 192,
                                proto = lamp_prototypes.ANO_3_Bl,
                            },
                            {
                                typename = "Omni", connector = "Light_192",
                                proto = lamp_prototypes.ANO_3_Bl, range = 8.0,
                            },
                        },
                    },
                },
            },
            [WOLALIGHT_AUX_LIGHTS] = {
                typename = "collection",
                lights = {
                    { -- 0 -- Red Recognition Light
                        typename = "Collection",
                        lights = {
                            {
                                typename = "omnilight", connector = "Light_200", pos_correction = {0.2, 0.0, 0.0}, argument = 200,
                                color = {0.99, 0.11, 0.11, 0.15}, range = 8.0,
                                power_up_t = 0.005,
                            },
                            {
                                typename = "spotlight", connector = "Light_200",
                                color = {0.99, 0.11, 0.11, 0.15}, range = 120.0, angle_max = math.rad(140.0), angle_min = math.rad(0.0),
                                power_up_t = 0.005,
                            },
                        },
                    },
                    { -- 1 -- Green Recognition Light
                        typename = "Collection",
                        lights = {
                            {
                                typename = "omnilight", connector = "Light_201", pos_correction = {0.2, 0.0, 0.0}, argument = 201,
                                color = {0.0, 0.894, 0.6, 0.15}, range = 8.0,
                                power_up_t = 0.005,
                            },
                            {
                                typename = "spotlight", connector = "Light_201",
                                color = {0.0, 0.894, 0.6, 0.15}, range = 120.0, angle_max = math.rad(140.0), angle_min = math.rad(0.0),
                                power_up_t = 0.005,
                            },
                        },
                    },
                    { -- 2 -- Amber Recognition Light
                        typename = "Collection",
                        lights = {
                            {
                                typename = "omnilight", connector = "Light_202", pos_correction = {0.2, 0.0, 0.0}, argument = 202,
                                color = {0.99, 0.82, 0.07, 0.15}, range = 8.0,
                                power_up_t = 0.005,
                            },
                            {
                                typename = "spotlight", connector = "Light_202",
                                color = {0.99, 0.82, 0.07, 0.15}, range = 120.0, angle_max = math.rad(140.0), angle_min = math.rad(0.0),
                                power_up_t = 0.005,
                            },
                        },
                    },
                    { -- 3 -- White Recognition Light
                        typename = "Collection",
                        lights = {
                            {
                                typename = "omnilight", connector = "Light_206", pos_correction = {0.35, 0.0, 0.0}, argument = 193,
                                color = {0.99, 0.99, 0.99, 0.15}, range = 8.0,
                                power_up_t = 0.005,
                            },
                            {
                                typename = "spotlight", connector = "Light_206",
                                color = {0.99, 0.99, 0.99, 0.15}, range = 80.0, angle_max = math.rad(140.0), angle_min = math.rad(0.0),
                                power_up_t = 0.005,
                            },
                        },
                    },
                    { -- 4 -- Bomb Bay Illumination
                        typename = "Collection",
                        lights = {
                            {
                                typename = "Spot", connector = "Light_Bomb Bay", argument = 205,
                                color = {255, 201, 125, 0.24}, range = 12.0, angle_max = math.rad(140.0), angle_min = math.rad(80.0),
                                power_up_t = 0.5,
                            },
                            {
                                typename = "Omni", connector = "Light_Bomb Bay_1",
                                color = {255, 201, 125, 0.24}, range = 12.0,
                                power_up_t = 0.5,
                            },
                        },
                    },
                    { -- 5 -- Loop Antenna Light
                        typename = "Argument", argument = 297,
                    },
                    { -- 6 -- LH UV Light
                        typename = "Argument", argument = 298,
                    },
                    { -- 7 -- Emergency Floodlight
                        typename = "Argument", argument = 299,
                    },
                    { -- 8 -- J.B.B. Floodlight
                        typename = "Argument", argument = 300,
                    },
                    { -- 9 -- Chart Floodlight
                        typename = "Argument", argument = 301,
                    },
                    { -- 10 -- RH UV Light
                        typename = "Argument", argument = 303,
                    },
                    { -- 11 -- Compass Floodlight
                        typename = "Argument", argument = 304,
                    },
                    { -- 12 -- Bomb Panel Lighting
                        typename = "Argument", argument = 305,
                    },
                    { -- 13 -- RH Panel Floodlight
                        typename = "Argument", argument = 307,
                    },
                },
            },
            [WOLALIGHT_CABIN_BOARDING] = {
                typename = "collection",
                lights = {
                    { -- 0 -- Dome Light
                        typename = "Argument", argument = 296,
                    },
                    { -- 1 -- LH Panel Floodlight
                        typename = "Argument", argument = 302,
                    },
                },
            },
            [WOLALIGHT_FORMATION_LIGHTS] = {
                typename = "collection",
                lights = {
                    {
                        typename = "Argument", argument = 196,
                    },
                    {
                        typename = "Argument", argument = 197,
                    },
                },
            },
        },
    },



    ViewSettings = ViewSettings,
    SnapViews    = SnapViews,
}

if rewrite_settings then 
   for i,o in pairs(rewrite_settings) do
        AIRCRAFT[i] = o
   end
end

AIRCRAFT.shape_table_data[1].file     = AIRCRAFT.Shape
AIRCRAFT.shape_table_data[1].username = AIRCRAFT.Name

return AIRCRAFT
end



-- Mosquito FB Mk. VI
add_aircraft(make_MosquitoFBMkVI())
