db_path = db_path or "./Scripts/Database/"
dofile(db_path.."db_countries.lua")
--require(current_mod_path.."/Entry/Common.lua")


local pylon_1A,pylon_1B,pylon_2,pylon_3,pylon_4,pylon_5,pylon_6,pylon_7,pylon_8B,pylon_8A = 1,2,3,4,5,6,7,8,9,10

function unpack (t, i)
  i = i or 1
  if t[i] ~= nil then
    return t[i], unpack(t, i + 1)
  end
end

local bomb_front = true
local bomb_rear = false
local bomb_right = true
local bomb_left = false
function bombs(front, right)  -- bool front, bool right  (belly stations)
  local use_bombs = true
  local rail_arg, rail_val
  local FR, LR
  local rocket_or_flares
  local LR_opposite_pylon  -- opposite pylon left/right
  local FR_opposite_pylon  -- opposite pylon front/rear
  local mak79suffix, mak79suffix2
  rail_val=0.5
  local mak_arg
  if front then
    FR = "F"
	mak_arg = 2601
    mak79suffix=" 4}"
    if right then
      mak79suffix2 = " 3R}"
      rail_arg = 602
      LR = "R"
      rocket_or_flares = "{BRU3242_LAU10}"
      LR_opposite_pylon = pylon_3
      FR_opposite_pylon = pylon_5
    else
      mak79suffix2 = " 3L}"
      rail_arg = 601
      LR = "L"
      rocket_or_flares = "{BRU3242_2*LAU10 R}"
      LR_opposite_pylon = pylon_6
      FR_opposite_pylon = pylon_4
    end
  else
    FR = "R"
	mak_arg = 2600
    if right then
      mak79suffix = " 3R}"
      mak79suffix2 = " 1R}"
      LR = "R"
      rail_arg = 604
      rocket_or_flares = "{BRU3242_SUU25}"
      LR_opposite_pylon = pylon_4
      FR_opposite_pylon = pylon_6
    else
      mak79suffix = " 3L}"
      mak79suffix2 = " 1L}"
      LR = "L"
      rail_arg = 603
      rocket_or_flares = "{BRU3242_2*SUU25 R}"
      LR_opposite_pylon = pylon_5
      FR_opposite_pylon = pylon_3
    end
  end
  local conn = "WEP_BRU-34_"..FR.."_"..LR
  local makconn = "MAK-79_Root_"..FR.."_"..LR
  if use_bombs then
    local _bombs = {
                { CLSID = "{BRU-32 MK-82}",  arg = rail_arg, arg_value = rail_val, connector = conn },
                { CLSID = "{BRU-32 MK-82AIR}",  arg = rail_arg, arg_value = rail_val, connector = conn },
                { CLSID = "{BRU-32 MK-82SE}",  arg = rail_arg, arg_value = rail_val, connector = conn },
                { CLSID = "{BRU-32 BDU-45}",  arg = rail_arg, arg_value = rail_val, connector = conn },
                { CLSID = "{BRU-32 BDU-45B}",  arg = rail_arg, arg_value = rail_val, connector = conn },
                { CLSID = "{MAK79_MK81"..mak79suffix,  arg = rail_arg, arg_value = rail_val, connector = makconn },
                { CLSID = "{MAK79_MK82"..mak79suffix,  arg = rail_arg, arg_value = rail_val, connector = makconn },
                { CLSID = "{MAK79_BDU45"..mak79suffix,  arg = rail_arg, arg_value = rail_val, connector = makconn },
                { CLSID = "{MAK79_BDU45B"..mak79suffix,  arg = rail_arg, arg_value = rail_val, connector = makconn },
                { CLSID = "{MAK79_BDU33"..mak79suffix, arg = rail_arg, arg_value = rail_val, connector = makconn },
                { CLSID = "{BRU3242_3*BDU33}",  arg = rail_arg, arg_value = rail_val, connector = conn },
                { CLSID = "{MAK79_MK82AIR"..mak79suffix, arg = rail_arg, arg_value = rail_val, connector = makconn },
                { CLSID = "{MAK79_MK82SE"..mak79suffix, arg = rail_arg, arg_value = rail_val, connector = makconn },
                { CLSID = "{MAK79_MK83"..mak79suffix2,  arg = rail_arg, arg_value = rail_val, connector = makconn },
                { CLSID = "{BRU-32 MK-83}",  arg = rail_arg, arg_value = rail_val, connector = conn },
                { CLSID = "{BRU-32 GBU-12}",  arg = rail_arg, arg_value = rail_val, connector = conn },
                { CLSID = "{BRU-32 GBU-16}",  arg = rail_arg, arg_value = rail_val, connector = conn },
                -- TODO: 1x BDU-57 LGTR on TER
                { CLSID = rocket_or_flares,  arg = rail_arg, arg_value = rail_val, connector = conn },
                --{ CLSID = "{CBU_99}"},
                { CLSID = "{BRU-32 MK-20}",  arg = rail_arg, arg_value = rail_val, connector = conn },
                { CLSID = "{BRU3242_ADM141}",  arg = rail_arg, arg_value = rail_val, connector = conn },
                { CLSID = "{BRU-32 MK-84}",  arg = rail_arg, arg_value = rail_val, connector = conn }

          }
    if front then
        _bombs[#_bombs + 1] = { CLSID = "{BRU-32 GBU-10}",  arg = rail_arg, arg_value = rail_val, connector = conn }
        _bombs[#_bombs + 1] = { CLSID = "{MAK79_MK20 2"..LR.."}",  arg = rail_arg, arg_value = rail_val, connector = makconn }
        -- TODO: ALQ-167  (left OR right, but not both)
    else
        -- TODO: CNU-188 baggage pod  (left OR right, but not both)
        _bombs[#_bombs + 1] = { CLSID = "{MAK79_MK20"..mak79suffix2,  arg = rail_arg, arg_value = rail_val, connector = makconn }
    end
    if front and not right then
        _bombs[#_bombs + 1] = { CLSID = "{BRU-32 GBU-24}",  arg = rail_arg, arg_value = rail_val, connector = conn }
    end
    if not front and right then
        _bombs[#_bombs + 1] = { CLSID = "{BRU-32 GBU-24}",  arg = rail_arg, arg_value = rail_val, connector = conn }
    end
    -- XXX these appear mounted on aircraft already shining (firefly!), so don't use for now
    --if not front then
    --    _bombs[#_bombs + 1] = { CLSID = "{BRU3242_2*LUU2 "..LR.."}",  arg = rail_arg, arg_value = rail_val, connector = conn }
    --end

    return unpack(_bombs)
  end
end

function shoulder_a2g(right, unit_name)
  local use_bombs = true
  local LR
  if right then
    LR="R"
  else
    LR="L"
  end
  if use_bombs then
    local _bombs = {
                { CLSID = "{PHXBRU3242_2*LAU10 "..LR.."S}",connector="WEP_PhoenixWingPylon_"..LR },
                { CLSID = "{PHXBRU3242_2*MK81 "..LR.."S}",connector="WEP_PhoenixWingPylon_"..LR },
                { CLSID = "{PHXBRU3242_2*MK82 "..LR.."S}",connector="WEP_PhoenixWingPylon_"..LR },
                { CLSID = "{PHXBRU3242_2*MK82AIR "..LR.."S}",connector="WEP_PhoenixWingPylon_"..LR },
                { CLSID = "{PHXBRU3242_2*MK82SE "..LR.."S}",connector="WEP_PhoenixWingPylon_"..LR },
                { CLSID = "{PHXBRU3242_2*MK20 "..LR.."S}",connector="WEP_PhoenixWingPylon_"..LR },
                { CLSID = "{PHXBRU3242_MK83 "..LR.."S}",connector="WEP_PhoenixWingPylon_"..LR },
                { CLSID = "{PHXBRU3242_BDU33}",connector="WEP_PhoenixWingPylon_"..LR },
                { CLSID = "{PHXBRU3242_2*BDU45 "..LR.."S}",connector="WEP_PhoenixWingPylon_"..LR },
                { CLSID = "{PHXBRU3242_2*BDU45B "..LR.."S}",connector="WEP_PhoenixWingPylon_"..LR },
    }
    if right and (unit_name == "F-14B" or unit_name == "F-14A-135-GR") then
        _bombs[#_bombs + 1] =  { CLSID	= "{F14-LANTIRN-TP}",connector="WEP_Shoulder_Sparrow_R",arg = 606, arg_value = 1.0, } -- LANTIRN
    end
    return unpack(_bombs)
  end
end

function fuel_tanks(unit_name, opposite_pylon)
  if (unit_name == "F-14B" or unit_name == "F-14A-135-GR") then
    local _tanks = {
        { CLSID = "{F14-300gal}", arg = 700, arg_value = 0.0,
            forbidden = {
                {station = opposite_pylon,loadout = {"{F14-300gal-empty}"}},
                {station = opposite_pylon,loadout = {"<CLEAN>"}},
            }
        }, -- Fuel tank 300 gal
        { CLSID = "{F14-300gal-empty}", arg = 700, arg_value = 0.0,
            forbidden = {
                {station = opposite_pylon,loadout = {"{F14-300gal}"}},
                {station = opposite_pylon,loadout = {"<CLEAN>"}},
            }
        }, -- empty 300gal tank
        { CLSID = "<CLEAN>", arg = 700, arg_value = 1.0,
            forbidden = {
                {station = opposite_pylon,loadout = {"{F14-300gal-empty}"}},
                {station = opposite_pylon,loadout = {"{F14-300gal}"}},
            }
        }, -- clean pylon
    }
    return unpack(_tanks)
  end
end

function shoulder_a2a(right, unit_name)
    local LR
    if right then
      LR="R"
    else
      LR="L"
    end
    local _weapons = {
    }
    if (unit_name == "F-14B" or unit_name == "F-14A-135-GR") then
        _weapons[#_weapons + 1] =  { CLSID = "{SHOULDER AIM-7P}",connector="WEP_Shoulder_Sparrow_"..LR }
    end
    if (unit_name == "F-14A-95-GR") then
        _weapons[#_weapons + 1] =  { CLSID = "{SHOULDER AIM-7E}",connector="WEP_Shoulder_Sparrow_"..LR }
    end
    if #_weapons > 0 then
        return unpack(_weapons)
    end
end

function belly_aim7p(connector_name, argnum, unit_name, forbidden_entry)

    local _weapons = {
    }
    if (unit_name == "F-14B" or unit_name == "F-14A-135-GR") then
        _weapons[#_weapons + 1] =
            { CLSID = "{BELLY AIM-7P}", arg = argnum, arg_value = 1.0, connector = connector_name, Cx_gain = 0.125,
                forbidden = forbidden_entry
            }
    end
    if (unit_name == "F-14A-95-GR") then
        _weapons[#_weapons + 1] =
            { CLSID = "{BELLY AIM-7E}", arg = argnum, arg_value = 1.0, connector = connector_name, Cx_gain = 0.125,
                forbidden = forbidden_entry
            }
    end
if #_weapons > 0 then
        return unpack(_weapons)
    end
end

function m61burstdefault(unit_name)
    if (unit_name == "F-14B") then
        return 0 -- 200
    else
        return 2 -- 50
    end
end
-------- GUN ---------------

local m61_20_hei = {
  category = CAT_SHELLS,
  name = "M56A3_HE_RED",
  user_name = _("M56A3 20mm HEI"),
  model_name    = "tracer_bullet_red",
    projectile      = "HE",
    payloadEffect   = "Thermal",
    payloadMaterial = "RDX",
    payload = 0.110,
  v0    = 3320*0.3048,
  Dv0   = 50.0/3320.0,
  Da0     = 0.001,
  Da1     = 0.0,
  mass      = 0.110,
  round_mass = 0.349,
  explosive     = 0.110, -- 0.0170 kg in real
  life_time     = 30,
  caliber     = 20.0,
  s         = 0.0,
  j         = 0.0,
  l         = 0.0,
  charTime    = 0,
  cx        = {0.5,1.27,0.70,0.200,2.30},
  k1        = 2.0e-08,
  tracer_off    = -100,
  scale_tracer  = 0,

  cartridge = 0,
}
declare_weapon(m61_20_hei)

local m61_20_api = {
  category = CAT_SHELLS,
  name = "M53_AP_RED",
  user_name = _("M53 20mm API"),
  model_name    = "tracer_bullet_red",
    projectile      = "AP",
  v0    = 3380*0.3048,
  Dv0   = 50.0/3380.0,
  Da0     = 0.001,
  Da1     = 0.0,
  mass      = 0.110,
  round_mass = 0.349,
  explosive     = 0.0,
  life_time     = 30,
  caliber     = 20.0,
  s         = 0.0,
  j         = 0.0,
  l         = 0.0,
  charTime    = 0,
  cx        = {0.5,1.27,0.70,0.200,2.30},
  k1        = 2.0e-08,
  tracer_off    = -100,
  scale_tracer  = 0,

  cartridge = 0,
}
declare_weapon(m61_20_api)

-- M55A2  TP ball hollow
local m61_20_tp = {
  category = CAT_SHELLS,
  name = "M55A2_TP_RED",
  user_name = _("M55A2 20mm TP"),
  model_name    = "tracer_bullet_red",
    projectile      = "Ball",
    payloadEffect   = "HollowCharge",
  v0    = 3380*0.3048,
  Dv0   = 50.0/3380.0,
  Da0     = 0.001,
  Da1     = 0.0,
  mass      = 0.110,
  round_mass = 0.349,
  explosive     = 0.0,
  life_time     = 30,
  caliber     = 20.0,
  s         = 0.0,
  j         = 0.0,
  l         = 0.0,
  charTime    = 0,
  cx        = {0.5,1.27,0.70,0.200,2.30},
  k1        = 2.0e-08,
  tracer_off    = -100,
  scale_tracer  = 0,

  cartridge = 0,
}
declare_weapon(m61_20_tp)

local m61_20_tracer = {
  category = CAT_SHELLS,
  name = "M53_APT_RED",
  user_name = _("20mm tracer"),
  model_name    = "tracer_bullet_red",
    projectile      = "AP",
  v0    = 3380*0.3048,
  Dv0   = 50.0/3380.0,
  Da0     = 0.001,
  Da1     = 0.0,
  mass      = 0.110,
  round_mass = 0.349,
  explosive     = 0.0,
  life_time     = 30,
  caliber     = 20.0,
  s         = 0.0,
  j         = 0.0,
  l         = 0.0,
  charTime    = 0,
  cx        = {0.5,1.27,0.70,0.200,2.30},
  k1        = 2.0e-08,
  tracer_off    = 6,
  scale_tracer  = 1,

  cartridge = 0,
}
declare_weapon(m61_20_tracer)
-- TODO: PGU-28 (for F-14B, as mentioned in F14AAP-1) [slightly faster, less drag, e.g. https://www.gd-ots.com/munitions/medium-caliber-ammunition/20mm-x-102-pgu/]

local function m61a1(tbl)

    tbl.category = CAT_GUN_MOUNT
    tbl.name =  "M-61A1"
    tbl.display_name =  _("M-61A1")
    tbl.supply      =
    {
        shells = {"M56A3_HE_RED", "M53_AP_RED", "M55A2_TP_RED", "M53_APT_RED"},
        mixes  = { {1,1,1,1,4}, {2,2,2,2,4}, {1,2,1,2,4}, {3,3,3,3,4} },
        count  = 676,
    }
    if tbl.mixes then
       tbl.supply.mixes = tbl.mixes
       tbl.mixes        = nil
    end
    tbl.gun =
    {
        max_burst_length    = 100000,
        rates               = {6000,4000},
        recoil_coeff        = 0.7*1.3,
        barrels_count       = 1,
    }
    if tbl.rates then
       tbl.gun.rates        =  tbl.rates
       tbl.rates            = nil
    end

    tbl.ejector_pos             = tbl.ejector_pos or {0, 0, 0}
    tbl.ejector_pos_connector   = tbl.ejector_pos_connector     or  "Gun_point"
    tbl.ejector_dir             = tbl.ejector_dir or {0, 0, 0}
    tbl.supply_position         = tbl.supply_position   or {0,  0, 0}
    tbl.aft_gun_mount           = false
    tbl.effective_fire_distance = 2700
    tbl.drop_cartridge          = 0
    tbl.muzzle_pos              = tbl.muzzle_pos            or  {0,0,0}     -- all position from connector
    tbl.muzzle_pos_connector    = tbl.muzzle_pos_connector  or  "Gun_point" -- all position from connector
    tbl.azimuth_initial         = tbl.azimuth_initial       or  0
    tbl.elevation_initial       = tbl.elevation_initial     or  0
    tbl.smoke_dir               = tbl.smoke_dir             or  {0, 0, 0}
    if  tbl.effects == nil then
        tbl.effects = {{ name = "FireEffect", arg = tbl.effect_arg_number or 350 },{name = "SmokeEffect", smoke_exhaust = "PNT_GUN_SMOKE" , add_speed = {10,0,0}}}

        --tbl.effects = {{ name = "FireEffect"     , arg = tbl.effect_arg_number or 436 },
        --               { name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
        --               { name = "SmokeEffect"}}
    end
    return declare_weapon(tbl)
end

function make_f14(rewrite_settings)

local rewrite_settings  = rewrite_settings or {Shape = 'F-14B' , Name = 'F-14B' , DisplayName = _('F-14B'), Countries = {"USA", "Iran"}, WorldID = WSTYPE_PLACEHOLDER}
local smokiness
local emptyweight
if rewrite_settings.Name == "F-14B" then
  smokiness = 0.05
  emptyweight = 19976
else
  smokiness = 0.12
  emptyweight = 19090
end
local launch_bar_connected_arg_value_	= 0.87

F_14 = {
    --return plane( "F-14B", _("F-14B"),

    -- ********************* MUST *************************
    Name    = 'F-14B',
    DisplayName = _('F-14B'),

    Picture   = "F-14B.png",
    Shape     = "F-14B",
    -- ****************************************************

    --******************** COMMON *************************
   
    WorldID =    WSTYPE_PLACEHOLDER,

    Countries = {"USA"},

    --attribute = {wsType_Air, wsType_Airplane, wsType_Fighter, F_14,
    attribute = {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER,"Fighters", "Refuelable","Datalink"},

   -- Crew = 2,
    CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_AVERAGE, LOOK_AVERAGE, LOOK_AVERAGE),

    LandRWCategories =
    {
        [1] =
        {
            Name = "AircraftCarrier",
        }, -- end of [1]
    }, -- end of LandRWCategories

    TakeOffRWCategories =
    {
        [1] =
        {
            Name = "AircraftCarrier With Catapult",
        }, -- end of [1]
    }, -- end of TakeOffRWCategories

    input_profile_entry = "F-14",

    shape_table_data =
    {
        {
            file      = rewrite_settings.Shape   or 'f-14b';
            life      = 20;
            vis      = 5;
            desrt     = 'f-14b-oblomok';
            fire      = { 300, 4 };
            --username    = rewrite_settings.Name    or 'F-14B';
            username    = 'F-14B';
            index       = rewrite_settings.WorldID or WSTYPE_PLACEHOLDER;
            classname = "lLandPlane";
            positioning = "BYNORMAL";
            drawonmap     = true;
        },

        {
            name     = "f-14b-oblomok";
            file     = "'f-14b-oblomok";
            fire     = { 240, 2 };
        },
    },

    -- Countermeasures,
	passivCounterm =
    {
		CMDS_Edit = false,
		SingleChargeTotal = 200,
		chaff = {default = 140, increment = 10, chargeSz = 1}, -- 2 x 40 (LAU-138, RR-184/AL is ~1/4 of a standard chaff) + 60 (AN/ALE-39)
		flare = {default = 60, increment = 10, chargeSz = 1},
	},

    chaff_flare_dispenser =
    {
		-- AN/ALE-39
        [1] =
        {
            dir   = {0, -1, 0},
            pos = {-6.540, 0.185, -0.229},
        }, -- end of [1]
		
		-- Left LAU-138
		[2] =
        {
            dir   = {0, -1, 0},
            pos = {-6.540, 0.185, -0.229},
        }, -- end of [2]
        
		-- Left LAU-138
		[3] =
        {
            dir   = {-1, 0, 0},
            pos = {-0.47967, 0.2638, -3.4626},
        }, -- end of [2]
		
		-- Right LAU-138
		[4] =
        {
            dir   = {-1, 0, 0},
            pos = {-0.47967, 0.2638, 3.4626},
        }, -- end of [3]
    }, -- end of chaff_flare_dispenser

    Sensors = {
        RADAR = "AN/APG-71",
        RWR = "Abstract RWR" -- AN/ALR-67
    },

    Countermeasures = {
        ECM = "AN/ALQ-126"
    },
    mapclasskey = "P0091000024",

	Navpoint_Panel = true,
    --Fixpoint_Panel = true,
    --Waypoint_Panel = true,

    HumanRadio = {
        frequency     = 124.0, -- onboard radio, default DCSW frequency, chnl 0
        editable     = true,
        minFrequency     = 30.000,
        maxFrequency     = 399.975,
		rangeFrequency = {
			{min = 30.0,  max = 87.975},
			{min = 108.0, max = 173.975},
			{min = 225.0, max = 399.975},
		},
        modulation     = MODULATION_AM
    },

--************************************************************


--******************** AIRCRAFT CONSTRUCTION ********************

    M_empty     = emptyweight,  -- according to weight and balance sheet
    M_nominal     = 25000,
    M_max         = 33724, -- according to perfomance manual
    M_fuel_max     = 7348, -- without externals
    H_max          = 17000, -- about 56 000 feet
    average_fuel_consumption = 0.11,--
    CAS_min     = 60,
    V_opt         = 223,
    V_take_off     = 70,
    V_land         = 70,-- affects APPROACH speed! not actual touchdown speed!

--19090
    EmptyWeight     = tostring(emptyweight), -- according to weight and balance sheet
    MaxFuelWeight     = "7348",
    MaxHeight     = "17000",
    MaxSpeed     = "2500",
    MaxTakeOffWeight     = "33724",
    Rate     = "50",
    WingSpan = "19.54",


    V_max_sea_level = 362,
    V_max_h         = 700,
    Vy_max         = 230,
    Mach_max     = 2.35,
    Ny_min         = -4,
    Ny_max         = 9.0,
    Ny_max_e     = 9.0,

    AOA_take_off     = 0.17454,
    bank_angle_max     = 60,

    has_afteburner     = true,--true,
    has_speedbrake     = true,
    has_differential_stabilizer    = true,

    detection_range_max     = 120,
    radar_can_see_ground = false,

	tand_gear_max = 50.0, -- =	2.75, -- tan(70deg)
	nose_gear_wheel_diameter     = 0.500,
	nose_gear_pos     = {6.3050, -2.3066, 0.0000},
    nose_gear_amortizer_direct_stroke     = -0.4726,
    nose_gear_amortizer_reversal_stroke     = -0.9023,
    nose_gear_amortizer_normal_weight_stroke    = -0.4826,	

	main_gear_wheel_diameter     = 0.900,
	main_gear_pos     = {-0.8493, -2.3066, 2.5136},
    main_gear_amortizer_direct_stroke     = 0.0,
    main_gear_amortizer_reversal_stroke    = -0.6389,
	main_gear_amortizer_normal_weight_stroke	= 	-0.5,
	
    tanker_type = 2,

    wing_area     = 54.5,
    wing_span     = 10.15, --To allow smaller ramp spots in oversweep
    wing_type     = 1, --Variable geometry
    thrust_sum_max     = 12280,
    thrust_sum_ab     = 24740,
    length     = 16.60,
    height     = 4.8,
    flaps_maneuver     = 1.0, -- Must be over a certain threshold to trigger carrier catapults.
    range     = 2960,
    RCS     = 6,
    IR_emission_coeff         = 0.9,
    IR_emission_coeff_ab     = 4.75,
    wing_tip_pos         = {-2.5, 0.075, 10.3},

    is_tanker     = false,
    air_refuel_receptacle_pos	= 	{8.8213, 0.9655, 1.22227},
    engines_count    = 2,
    bigParkingRamp     =   false,

	launch_bar_connected_arg_value	= launch_bar_connected_arg_value_,
	
    engines_nozzles =
    {
        [1] =
        {
            pos     = {-6.67, 0.051, 1.414},
            elevation     = 0,
            diameter     = 0.01,
            exhaust_length_ab    = 0.01,
            exhaust_length_ab_K = 0.75,
            smokiness_level     = smokiness
        },
        [2] =
        {
            pos     = {-6.67, 0.051, -1.414},
            elevation     = 0,
            diameter     = 0.01,
            exhaust_length_ab    = 0.01,
            exhaust_length_ab_K = 0.75,
            smokiness_level     = smokiness
        },
    },

  --  crew_size = 2,

   crew_stations = "HumanOrchestra",
   crew_members =
   {
       [1] =
       {
           ejection_seat_name = "f-14b_gru7",
           drop_canopy_name = "f-14b_canopy",
      --     pilot_name     = "MiG-21_pilot",
           pos = {4,    0.65,    0},
           can_be_playable   = true,
           canopy_arg           = 38,
           ejection_order    = 2,
           g_suit         =  2.0,
           canopy_pos    = {3.916,0.798,0},
           ejection_added_speed = {-3,15,-3}, --pilot to the left
           role      = "pilot",
           role_display_name    = _("Pilot"),
       },
       [2] =
       {
           ejection_seat_name = "f-14b_gru7",
           drop_canopy_name = "f-14b_canopy",
   --        pilot_name     = "MiG-21_pilot",
           pos = {2.5,    0.65,    0},
           can_be_playable  = true,
           canopy_pos   =  {3.916,0.798,0},
           ejection_added_speed = {-3,15,3}, -- RIO to the right
           ejection_order   = 1,
           g_suit         =  2.0,
           canopy_arg          = 38,
           pilot_body_arg  = 472,
           role      = "instructor",
           role_display_name    = _("Radar Intercept Officer"),
       },
   },


    fires_pos =
    {
        [1]     =     {-0.60, 0.30, 0.00}, --iza CT, na hrbatu
        [2]     =     {0.1926, 0.662, 3.8878}, -- wing left
        [3]     =     {0.1926, 0.662, -3.8878},  -- wing right
        [4]     =     {0.00,    0.00, 2.00}, --sred. krilo desno
        [5]     =     {0.00,    0.00, -2.00}, --sred. krilo desno
        [6]     =     {0.00,    0.00, 3.00}, --spolj. krilo desno
        [7]     =     {0.00,    0.00, -3.00}, --spolj. krilo desno
        [8]     =     {-8.0, -0.4, 1.50},--trag
        [9]     =     {-8.0, -0.4, -1.50},--trag
        [10]   =     {-3.00, 0.20, 0.50},--trup desno
        [11]   =     {-3.00, 0.20, -0.50}, --trup levo
    },

    --[[
    SpecificCallnames = {
      [country.USA] = {
        {_('AARDVARK'),		'AARDVARK'},
        {_('BLACK LION'),		'BLACK LION'},
        {_('DOG'),		'DOG'},
        {_('FAST EAGLE'),		'FAST EAGLE'},
        {_('VICTORY'),		'VICTORY'},
        {_('DIAMOND'),		'DIAMOND'},
        {_('HUNTER'),		'HUNTER'},
        {_('GUNFIGHTER'),		'GUNFIGHTER'},
      }
    },
    InheriteCommonCallnames = true,
    --]]

	mechanimations = {
        Door0 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 38, "to", 0.9, "in", 9.5},},},}, Flags = {"Reversible"},},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "to", 0.0, "in", 5.0},},},}, Flags = {"Reversible", "StepsBackwards"},},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"JettisonCanopy", 0},},},},},
        },
		--DestroyHook = {
		--	{Transition = {"A
		--},
        FoldableWings = {
            {Transition = {"Retract", "Extend"}, Sequence = {{C = {{"Arg", 404, "to", 0.0, "in", 5.0},
																   {"Arg", 405, "to", 0.0, "in", 5.0},
																   {"Arg", 507, "to", 0.0, "in", 3.0},
																   {"Arg", 508, "to", 0.0, "in", 3.0}}}}, Flags = {"Reversible"}},
            {Transition = {"Extend", "Retract"}, Sequence = {{C = {{"Arg", 404, "to", 1.0, "in", 5.0},
																   {"Arg", 405, "to", 1.0, "in", 5.0},
																   {"Arg", 507, "to", 1.0, "in", 3.0},
																   {"Arg", 508, "to", 1.0, "in", 3.0}}}}, Flags = {"Reversible", "StepsBackwards"}},
        },
        LaunchBar = {
            {Transition = {"Retract", "Extend"}, Sequence = {{C = {{"ChangeDriveTo", "HydraulicGravityAssisted"}, {"VelType", 3}, {"Sleep", "for", 3.400}, {"Arg", 85, "to", 1.0, "in", 2.0} }}}},
            --{Transition = {"Extend", "Retract"}, Sequence = {{C = {{"ChangeDriveTo", "Hydraulic"}, {"VelType", 2}, {"Arg", 85, "to", 0.000, "in", 4.0}}}}},
            --{Transition = {"Retract", "Stage"},  Sequence = {{C = {{"ChangeDriveTo", "HydraulicGravityAssisted"}, {"VelType", 3}, {"Arg", 85, "to", 1.0, "in", 4.0}}}}},
            {Transition = {"Stage", "Retract"},  Sequence = {{C = {{"ChangeDriveTo", "Hydraulic"}, {"VelType", 2}, {"Arg", 85, "to", 0.000, "in", 4.0}}}}},
            {Transition = {"Extend", "Stage"},   Sequence = {
                    {C = {{"ChangeDriveTo", "Mechanical"}, {"Sleep", "for", 0.000}}},
                    {C = {{"Arg", 85, "from", 1.0, "to", 0.775, "in", 0.600}}},
                    {C = {{"Arg", 85, "from", 0.775, "to", 0.750, "in", 0.300}}},
                    --{C = {{"Sleep", "for", 1.800}}},
                    --{C = {{"Sleep", "for", 0.150}}},
                    {C = {{"Arg", 85, "from", 0.750, "to", 0.810, "in", 0.100, "sign", 1}}},
                    {C = {{"Arg", 85, "from", 0.810, "to", 0.98, "in", 0.200}}},
                    --{C = {{"PosType", 6}, {"Sleep", "for", 3.3}}},
                    --{C = {{"Arg", 85, "from", 0.930, "to", 0.871, "in", 1.25}}},
                },
            },
			{Transition = {"Stage", "Pull"},  Sequence = {
					{C = {{"ChangeDriveTo", "Mechanical"}, {"VelType", 2}, {"Arg", 85, "to", launch_bar_connected_arg_value_, "in", 0.15}}},
					{C = {{"ChangeDriveTo", "Mechanical"}, {"VelType", 2}, {"Arg", 85, "to", 0.88, "speed", 0.1}}},
					{C = {{"ChangeDriveTo", "Mechanical"}, {"VelType", 2}, {"Arg", 85, "to", 0.87, "speed", 0.02}}},
					}
			},
            {Transition = {"Stage", "Extend"},   Sequence = {{C = {{"ChangeDriveTo", "HydraulicGravityAssisted"}, {"VelType", 3}, {"Arg", 85, "from", 0.871, "to", 1.0, "in", 0.2}}}}},
			{Transition = {"Any", "Retract"},  Sequence = {{C = {{"ChangeDriveTo", "Hydraulic"}, {"VelType", 2}, {"Arg", 85, "to", 0.000, "in", 4.0}}}}},
        },
		CentralStrut = 
		{
            {Transition = {"Any", "Stage"}, Sequence = {{C = {{"ChangeDriveTo", "Hydraulic"}, {"VelType", 2},{"Arg", 1, "to", 0.8, "in", 2.0}}}}},
			{Transition = {"Stage","Extend"}, Sequence = {{C = {{"Arg", 1, "to", 0.0, "in", 0.7}}}}},            
        },
    }, -- end of mechanimations
	
    net_animation =
    {
        -- AICS

        --RightRamp1
        1609,
        --RightRamp2
        1610,
        --Hook new
        1305, 

        --LeftRamp1
        1611,
        --LeftRamp2
        1612,

        -- Wings

        --    LeftSweep
        404,
		--    RightSweep
		405,
		
		-- LeftOverSweep
		507,
		-- RightOverSweep
		508,

        --    LeftFlex
        1500,
        --    RightFlex
        1501,

        -- Engine
        --LeftNozzle
        434,
		--RightNozzle
		433,
       
        --Right AB
        28,
        --Left AB
        29,

        --Wheel chocks
        23,

        -- ControlSurface
        --LeftMainFlaps
        1001,
        --RightMainFlaps
        1003,
        --LeftAuxFlaps
        1004,
        --RightAuxFlaps
        1002,

        --LeftOuterSlats
        1022,
        --RightOuterSlats
        1021,
        --LeftInnerSlats
        --999,
        --RightInnerSlats
        --999,

        --LeftStabilator
        450,
        --RightStabilator
        406,

        --TopSpeedBrake
        21,
        --BottomLeftSpeedBrake
        182,
        --BottomRightSpeedBrake
        184,

        --RightInnerSpoiler
        1012,
        --RightOuterSpoiler
        1013,
        --LeftInnerSpoiler
        1011,
        --LeftOuterSpoiler
        1010,

        --LeftRudder
        509,
        --RightRudder
        1020,
		
		-- Airbrake
		400,
		401,
		402,

        --Hook
        25,

		85, -- Launch bar

        --Refuel probe
        22,

		-- Pilot Head Left Right
		6000,
		--Pilot Head Up Down
		6001,
		-- Pilot Lean Left Right
		6002,
		--Pilot Lean Forward
		1614,
        --Pilot Salute
         1600, 
         --Rio Lean in
         1601,
        -- Rio hold on
         1603,
         -- Rio right left
        626,
        -- Rio up down
        627,
		-- Phoenix railr front
		600,
		-- Phoenix rails rear
		605,
		-- LANTIRN
		606,
		607,
        608,
        700, -- fuel tank pylons
        
	-- fuel dump
        3600,
        3601,
        3602,
        3603,
		
	-- eng fires
        3604,
        3605,
        3606,
        3607,

	-- yaw string	
        2500,
        2501,
		-- Lights
		200,
		615,
		625,
    },

    --****************************************************

    --******************** FAILURES **********************

    Failures = {
        { id = 'RADAR_FAILURE_TOTAL', label = _('Radar: Total'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 0
        { id = 'DDD_FAILURE_TOTAL', label = _('DDD: Total'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- ENGINE
		{ id = 'L_ENG_FIRE', label = _('Left Engine: Fire'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_ENG_FIRE', label = _('Right Engine: Fire'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'L_ENG_SEIZED', label = _('Left Engine: Main Spool Seizure'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_ENG_SEIZED', label = _('Right Engine: Main Spool Seizure'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'L_ENG_TURBINE_FAILURE', label = _('Left Engine: Turbine Failed'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_ENG_TURBINE_FAILURE', label = _('Right Engine: Turbine Failed'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'L_ENG_OIL_LEAK_SLOW', label = _('Left Engine: Slow Oil Leak (1 hr)'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_ENG_OIL_LEAK_SLOW', label = _('Right Engine: Slow Oil Leak (1 hr)'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'L_ENG_OIL_LEAK_MODERATE', label = _('Left Engine: Moderate Oil Leak (30 min)'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_ENG_OIL_LEAK_MODERATE', label = _('Right Engine: Moderate Oil Leak (30 min)'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'L_ENG_OIL_LEAK_SEVERE', label = _('Left Engine: Severe Oil Leak (2 min)'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_ENG_OIL_LEAK_SEVERE', label = _('Right Engine: Severe Oil Leak (2 min)'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'L_ENG_COMPRESSOR_STALL', label = _('Left Engine: Compressor Stall'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_ENG_COMPRESSOR_STALL', label = _('Right Engine: Compressor Stall'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'L_ENG_POP_STALL', label = _('Left Engine: Pop Stall'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_ENG_POP_STALL', label = _('Right Engine: Pop Stall'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--		{ id = 'L_ENG_SUPERSONIC_INLET_BUZZ', label = _('Left Engine: Supersonic Inlet Buzz'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--		{ id = 'R_ENG_SUPERSONIC_INLET_BUZZ', label = _('Right Engine: Supersonic Inlet Buzz'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'L_ENG_HPT_OVERSPEED', label = _('Left Engine: Turbine Overspeed'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_ENG_HPT_OVERSPEED', label = _('Right Engine: Turbine Overspeed'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'L_ENG_AFTC_PRI_FAILED', label = _('Left Engine: AFTC Failure'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_ENG_AFTC_PRI_FAILED', label = _('Right Engine: AFTC Failure'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'L_ENG_AICS_RAMP_FAIL_OPEN', label = _('Left Engine: AICS Ramp Fail Open'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_ENG_AICS_RAMP_FAIL_OPEN', label = _('Right Engine: AICS Ramp Fail Open'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'L_ENG_AICS_RAMP_FAIL_CLOSED', label = _('Left Engine: AICS Ramp Fail Closed'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_ENG_AICS_RAMP_FAIL_CLOSED', label = _('Right Engine: AICS Ramp Fail Closed'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'L_ENG_AICS_RAMP_FAIL_IN_POS', label = _('Left Engine: AICS Ramp Fail In Position'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_ENG_AICS_RAMP_FAIL_IN_POS', label = _('Right Engine: AICS Ramp Fail In Position'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'L_ENG_NOZZLE_FAILURE', label = _('Left Engine: Exhaust Nozzle Failure'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_ENG_NOZZLE_FAILURE', label = _('Right Engine: Exhaust Nozzle Failure'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- CADC
		{ id = 'CADC_FAILURE_TOTAL', label = _('CADC: Total'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CADC_PRESSURE_SENSOR', label = _('CADC: Pressure sensor'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CADC_WING_SWEEP_COMMAND_CHANNEL_1', label = _('CADC: Wing Sweep Channel 1'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CADC_WING_SWEEP_COMMAND_CHANNEL_2', label = _('CADC: Wing Sweep Channel 2'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CADC_MANEUVER_FLAP_COMMAND', label = _('CADC: Maneuver Flap Command'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CADC_RUDDER_AUTHORITY_COMMAND', label = _('CADC: Rudder Authority Command'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CADC_STABILIZER_AUTHORITY_COMMAND', label = _('CADC: Stabilizer Authority Command'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CADC_ANGLE_OF_ATTACK_SIGNAL', label = _('CADC: Angle Of Attack Signal'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CADC_TOTAL_TEMPERATURE_SIGNAL', label = _('CADC: Temperature Signal'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CADC_WING_SWEEP_INDICATOR', label = _('CADC: Wing Sweep Indicator'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CADC_CSDC_CONNECTION', label = _('CADC: Digital output to CSDC'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- NAV
		{ id = 'INS_FAILURE_TOTAL', label = _('INS: Total'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'INS_FAILURE_NAV_COMPUTER', label = _('INS: Nav Computer'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'IMU_FAILURE_TOTAL', label = _('IMU: Total'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'IMU_FAILURE_QUANTIZER', label = _('IMU: Quantizer'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'AHRS_FAILURE_TOTAL', label = _('AHRS: Total'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'AHRS_FAILURE_GYRO', label = _('AHRS: Gyro Platform'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'AHRS_FAILURE_MAD', label = _('AHRS: Magnetic Azimuth Detector'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- RWR AN/ALR-67
		{ id = 'RWR_FAILURE_TOTAL', label = _('RWR: Total'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWR_FAILURE_CONTROL_BOX', label = _('RWR: Control Box'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWR_FAILURE_COMPUTER', label = _('RWR: Computer'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWR_FAILURE_LOW_BAND', label = _('RWR: Low Band Receiver/Antenna'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWR_FAILURE_QUAD45', label = _('RWR: 45 Quad Receiver/Antenna'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWR_FAILURE_QUAD135', label = _('RWR: 135 Quad Receiver/Antenna'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWR_FAILURE_QUAD225', label = _('RWR: 225 Quad Receiver/Antenna'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWR_FAILURE_QUAD315', label = _('RWR: 315 Quad Receiver/Antenna'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWR_FAILURE_MBE', label = _('RWR: MBE BUS'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWR_FAILURE_BLANKER', label = _('RWR: Interference Blanker'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWR_FAILURE_DISPLAY_PILOT', label = _('RWR: Display Pilot'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWR_FAILURE_DISPLAY_RIO', label = _('RWR: Display RIO'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- COUNTERMEASURES AN/ALE-39
		{ id = 'CMS_FAILURE_PROGRAMMER', label = _('Countermeasures: Programmer'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CMS_FAILURE_LEFT_DISPENSER', label = _('Countermeasures: Left Dispenser'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CMS_FAILURE_RIGHT_DISPENSER', label = _('Countermeasures: Right Dispenser'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- UHF AN/ARC-159
		{ id = 'UHF_ARC_159_FAILURE_TOTAL', label = _('UHF AN/ARC-159: Total'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'UHF_ARC_159_FAILURE_DISPLAY', label = _('UHF AN/ARC-159: Display'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'UHF_ARC_159_FAILURE_REMOTE_DISPLAY', label = _('UHF AN/ARC-159: Remote Display Pilot'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'UHF_ARC_159_FAILURE_REMOTE_DISPLAY_RIO', label = _('UHF AN/ARC-159: Remote Display RIO'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'UHF_ARC_159_FAILURE_INTERNAL_MODULE', label = _('UHF AN/ARC-159: Internal Module'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'UHF_ARC_159_FAILURE_TRANSCEIVER', label = _('UHF AN/ARC-159: Transceiver'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'UHF_ARC_159_FAILURE_ANTENNA', label = _('UHF AN/ARC-159: Antenna'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- VHF/UHF AN/ARC-182
		{ id = 'VHF_ARC_182_FAILURE_TOTAL', label = _('VHF/UHF AN/ARC-182: Total'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'VHF_ARC_182_FAILURE_DISPLAY', label = _('VHF/UHF AN/ARC-182: Display'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'VHF_ARC_182_FAILURE_REMOTE_DISPLAY', label = _('VHF/UHF AN/ARC-182: Remote Display'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'VHF_ARC_182_FAILURE_INTERNAL_MODULE', label = _('VHF/UHF AN/ARC-182: Internal Module'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'VHF_ARC_182_FAILURE_TRANSCEIVER', label = _('VHF/UHF AN/ARC-182: Transceiver'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'VHF_ARC_182_FAILURE_ANTENNA', label = _('VHF/UHF AN/ARC-182: Antenna'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- ICS
		{ id = 'ICS_FAILURE_AMPLIFIER_PILOT_NORM', label = _('ICS: Amplifier Pilot'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ICS_FAILURE_AMPLIFIER_PILOT_BU', label = _('ICS: Amplifier Pilot Backup'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ICS_FAILURE_AMPLIFIER_RIO_NORM', label = _('ICS: Amplifier RIO'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ICS_FAILURE_AMPLIFIER_RIO_BU', label = _('ICS: Amplifier RIO Backup'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- TACAN
		{ id = 'TACAN_FAILURE_TOTAL', label = _('TACAN: Total'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TACAN_FAILURE_TRANSMITTER', label = _('TACAN: Transmitter'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TACAN_FAILURE_RECEIVER', label = _('TACAN: Receiver'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- ILS
		{ id = 'ILS_FAILURE_TOTAL', label = _('ILS: Total'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ILS_FAILURE_DECODER', label = _('ILS: Decoder'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ILS_FAILURE_ANTENNA', label = _('ILS: Antenna'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        -- HUD
        { id = 'HUD_FAILURE_TOTAL', label = _('HUD: Total'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        -- VDI
        { id = 'VDI_FAILURE_TOTAL', label = _('VDI: Total'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        -- RIO TID bowl
        { id = 'TID_FAILURE_TOTAL', label = _('TID: Total'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        
        -- Wings
        { id = 'W_S_L', label = _('Wings: Left Sweep Failure'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'W_S_R', label = _('Wings: Right Sweep Failure'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

        -- Engines


        -- Hydraulics
        { id = 'HYD_Combined', label = _('Hydraulics: Left Engine Pump'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'HYD_Flight', label = _('Hydraulics: Right Engine Pump'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'HYD_Transf', label = _('Hydraulics: Transfer Pump-Motor'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
       --{ id = 'HYD_CombLeak', label = _('Hydraulics: Combined System Leak'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
       --{ id = 'HYD_FlightLeak', label = _('Hydraulics: Flight System Leak'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
       --{ id = 'HYD_SpoilLeak', label = _('Hydraulics: Spoiler System Leak'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
       --{ id = 'HYD_FBackLeak', label = _('Hydraulics: Flight Backup System Leak'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

       -- Jester
       { id = 'JESTER', label = _('Jester: Incapacitated'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

       -- Emergency Gear Handle
       { id = 'EMERGENCY_GEAR_LEVER_PULLED', label = _('Emergency Gear Handle: Pulled'),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100},
       
    },

    --****************************************************
    Guns =
    {
        -- function gun_mount(template_name, ammo_override, mount_override, trigger_override)
        --[[
        gun_mount("M_61",
            {
                count = 676,
            },
            {
                muzzle_pos_connector = "PNT_GUN",  --53milliradians higher than ADL
                --elevation_initial = 5.03,
                --azimuth_initial = -0.5, -- 0.5deg to the right
                --smoke_dir = {0, -3, 10},
                gun = {rates = {6000,4000} },
            }
        )
        --]]
        m61a1({muzzle_pos_connector = "PNT_GUN", --53milliradians higher than ADL
        smoke_dir = {0,-1,-0.2},
        elevation_initial=0.57,
        })
    },
    ammo_type ={ _("20mm HEI"),
                 _("20mm API"),
                 _("20mm AP&HE"),
                 _("20mm TP"),
    },

    Pylons =
    {
        pylon(pylon_1A, 0, 1.342000, 0.183859, -3.44629,
            {
                --FiX = 90,
                --FiZ = 5.03,
                DisplayName = "1A",
                connector = "WEP_AIM-9_L",
                use_full_connector_position = true,
            },
            {

                { CLSID = "{LAU-138 wtip - AIM-9M}" }, -- AIM-9M
                { CLSID = "{LAU-138 wtip - AIM-9L}" }, -- AIM-9L
                { CLSID = "{LAU-138 wtip - TCTS L}" }, -- ACMI pod
                { CLSID = "CATM-9M" }, -- CATM-9/CAP-9M
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}" }, -- Smokewinder red
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}" }, -- Smokewinder green
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}" }, -- Smokewinder blue
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}" }, -- Smokewinder white
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}" }, -- Smokewinder yellow
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}" }, -- Smokewinder orange
            }
        ),
        pylon(pylon_1B, 1, 0.900000, -0.230000, -3.130000,
            {
                --FiZ = -1,
                DisplayName = "1B",
                use_full_connector_position = true,
            },
            {
                { CLSID = "{SHOULDER AIM_54C_Mk47 L}",connector="WEP_PhoenixWingPylon_L"  },  -- AIM-54C Mk47
                { CLSID = "{SHOULDER AIM_54C_Mk60 L}",connector="WEP_PhoenixWingPylon_L"  },  -- AIM-54C Mk47
                { CLSID = "{SHOULDER AIM_54A_Mk47 L}",connector="WEP_PhoenixWingPylon_L"  },  -- AIM-54A Mk47
                { CLSID = "{SHOULDER AIM_54A_Mk60 L}",connector="WEP_PhoenixWingPylon_L"  },  -- AIM-54A Mk60
                { CLSID = "{SHOULDER AIM-7M}",connector="WEP_Shoulder_Sparrow_L" },
                { CLSID = "{SHOULDER AIM-7F}",connector="WEP_Shoulder_Sparrow_L" },
                { CLSID = "{SHOULDER AIM-7MH}",connector="WEP_Shoulder_Sparrow_L" },
                { CLSID = "{LAU-7 - AIM-9M}",Type=0,connector="WEP_Sidewinder_Extra_L"}, -- AIM-9M
                { CLSID = "{LAU-7 - AIM-9L}",Type=0,connector="WEP_Sidewinder_Extra_L"}, -- AIM-9L
                { CLSID = "{LAU-7 - TCTS}",connector="WEP_Sidewinder_Extra_L" }, -- ACMI pod
                shoulder_a2a(bomb_left, rewrite_settings.Name),
                shoulder_a2g(bomb_left, rewrite_settings.Name)
            }
        ),
        pylon(pylon_2, 1, -0.221000, -0.882000, -1.487000,
            {
                --FiZ = 0,
                DisplayName = "2",
                connector = "WEP_Fuel_Pylon_L",
                use_full_connector_position = true,
            },
            {
                fuel_tanks(rewrite_settings.Name, pylon_7)
            }
        ),
        pylon(pylon_3, 1, 2.749000, -0.462000, -0.520000,
            {
                --FiZ = -1,
                DisplayName = "3", -- front left
                use_full_connector_position = true,
            },
            {
                { CLSID = "{AIM_54A_Mk47}", arg = 601, arg_value = 0, connector = "WEP_Phoenix_FrontPallette_L", Cx_gain = 0.57, -- drag index 12 on shoulder vs 8 in tunnel 8/12 = .66 (manual also says to subtract 5 from total index for tunnel stores from total of 40 for 4 AIM54s) 
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54A
                { CLSID = "{AIM_54A_Mk60}", arg = 601, arg_value = 0, connector = "WEP_Phoenix_FrontPallette_L", Cx_gain = 0.57,
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54A Mk60
                { CLSID = "{AIM_54C_Mk47}", arg = 601, arg_value = 0, connector = "WEP_Phoenix_FrontPallette_L", Cx_gain = 0.57,
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54C Mk60
				{ CLSID = "{AIM_54C_Mk60}", arg = 601, arg_value = 0, connector = "WEP_Phoenix_FrontPallette_L", Cx_gain = 0.57,
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54C Mk47
                { CLSID = "{BELLY AIM-7M}", arg = 600, arg_value = 1.0, connector = "WEP_Sparrow_Indent_F_L", Cx_gain = 0.125, -- note: tunnel AIM7 drag index = 2, shoulder AIM7 = 6 (manual also says to subtract 5 from total index for tunnel stores from a total index of 8 for 4 AIM7s)
                    forbidden = {
                        {station = pylon_3,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk60}"}},
                    }
                }, -- AIM-7M
                { CLSID = "{BELLY AIM-7F}", arg = 600, arg_value = 1.0, connector = "WEP_Sparrow_Indent_F_L", Cx_gain = 0.125,
                    forbidden = {
                        {station = pylon_3,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk60}"}},
                    }
                }, -- AIM-7F
                { CLSID = "{BELLY AIM-7MH}", arg = 600, arg_value = 1.0, connector = "WEP_Sparrow_Indent_F_L", Cx_gain = 0.125,
                    forbidden = {
                        {station = pylon_3,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk60}"}},
                    }
                }, -- AIM-7MH
                {
                    CLSID = "<CLEAN>", arg = 600, arg_value = 1.0,
                    forbidden = {
                        {station = pylon_3,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk60}"}},
                    }
                },
                belly_aim7p("WEP_Sparrow_Indent_F_L", 600, rewrite_settings.Name,
                  { {station = pylon_3,loadout = {"{AIM_54A_Mk47}"}},
                    {station = pylon_3,loadout = {"{AIM_54A_Mk60}"}},
                    {station = pylon_3,loadout = {"{AIM_54C_Mk47}"}},
                    {station = pylon_3,loadout = {"{AIM_54C_Mk60}"}},
                    {station = pylon_6,loadout = {"{AIM_54A_Mk47}"}},
                    {station = pylon_6,loadout = {"{AIM_54A_Mk60}"}},
                    {station = pylon_6,loadout = {"{AIM_54C_Mk60}"}},
                    {station = pylon_6,loadout = {"{AIM_54C_Mk47}"}} } ),
                bombs(bomb_front, bomb_left)
            }
        ),
        pylon(pylon_4, 1, -1.783000, -0.385000, -0.520000,
            {
                --FiZ = -1,
                DisplayName = "4",  -- back left rail, or backmost sparrow hollow
                use_full_connector_position = true,
            },
            {
                { CLSID = "{AIM_54A_Mk47}", arg = 603, arg_value = 0, connector = "WEP_Phoenix_RearPallette_L", Cx_gain = 0.57,
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54A
                { CLSID = "{AIM_54A_Mk60}", arg = 603, arg_value = 0, connector = "WEP_Phoenix_RearPallette_L", Cx_gain = 0.57,
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54A Mk60
                { CLSID = "{AIM_54C_Mk47}", arg = 603, arg_value = 0, connector = "WEP_Phoenix_RearPallette_L", Cx_gain = 0.57,
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54C Mk47
				{ CLSID = "{AIM_54C_Mk60}", arg = 603, arg_value = 0, connector = "WEP_Phoenix_RearPallette_L", Cx_gain = 0.57,
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54C Mk60
                { CLSID = "{BELLY AIM-7M}", arg = 605, arg_value = 1.0, connector = "WEP_Sparrow_Rear", Cx_gain = 0.125,
                    forbidden = {
                        {station = pylon_4,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk60}"}},
                    }
                }, -- AIM-7M
                { CLSID = "{BELLY AIM-7F}", arg = 605, arg_value = 1.0, connector = "WEP_Sparrow_Rear", Cx_gain = 0.125,
                    forbidden = {
                        {station = pylon_4,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk60}"}},
                    }
                }, -- AIM-7F
                { CLSID = "{BELLY AIM-7MH}", arg = 605, arg_value = 1.0, connector = "WEP_Sparrow_Rear", Cx_gain = 0.125,
                    forbidden = {
                        {station = pylon_4,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk60}"}},
                    }
                }, -- AIM-7MH
                {
                    CLSID = "<CLEAN>", arg = 605, arg_value = 1.0,
                    forbidden = {
                        {station = pylon_4,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk60}"}},
                    }
                },
                belly_aim7p("WEP_Sparrow_Rear", 605, rewrite_settings.Name,
                  { {station = pylon_4,loadout = {"{AIM_54A_Mk47}"}},
                    {station = pylon_4,loadout = {"{AIM_54A_Mk60}"}},
                    {station = pylon_4,loadout = {"{AIM_54C_Mk47}"}},
                    {station = pylon_4,loadout = {"{AIM_54C_Mk60}"}},
                    {station = pylon_5,loadout = {"{AIM_54A_Mk47}"}},
                    {station = pylon_5,loadout = {"{AIM_54A_Mk60}"}},
                    {station = pylon_5,loadout = {"{AIM_54C_Mk60}"}},
                    {station = pylon_5,loadout = {"{AIM_54C_Mk47}"}} } ),
                bombs(bomb_rear, bomb_left)
            }
        ),
        pylon(pylon_5, 1, -1.783000, -0.385000, 0.492000,
            {
                --FiZ = -1,
                DisplayName = "5", -- back right rail, or center sparrow hollow
                use_full_connector_position = true,
            },
            {
                { CLSID = "{AIM_54A_Mk47}", arg = 604, arg_value = 0, connector = "WEP_Phoenix_RearPallette_R", Cx_gain = 0.57,
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54A
                { CLSID = "{AIM_54A_Mk60}", arg = 604, arg_value = 0, connector = "WEP_Phoenix_RearPallette_R", Cx_gain = 0.57,
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54A Mk60
                { CLSID = "{AIM_54C_Mk47}", arg = 604, arg_value = 0, connector = "WEP_Phoenix_RearPallette_R", Cx_gain = 0.57,
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54C Mk47
				{ CLSID = "{AIM_54C_Mk60}", arg = 604, arg_value = 0, connector = "WEP_Phoenix_RearPallette_R", Cx_gain = 0.57,
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_4,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54C Mk60
                { CLSID = "{BELLY AIM-7M}", arg = 605, arg_value = 1.0, connector = "WEP_Sparrow_Centr", Cx_gain = 0.125,
                    forbidden = {
                        {station = pylon_3,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_4,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk60}"}}
                    }
                }, -- AIM-7M
                { CLSID = "{BELLY AIM-7F}", arg = 605, arg_value = 1.0, connector = "WEP_Sparrow_Centr", Cx_gain = 0.125,
                    forbidden = {
                        {station = pylon_3,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_4,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk60}"}},
                    }
                }, -- AIM-7F
                { CLSID = "{BELLY AIM-7MH}", arg = 605, arg_value = 1.0, connector = "WEP_Sparrow_Centr", Cx_gain = 0.125,
                    forbidden = {
                        {station = pylon_3,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_4,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk60}"}},
                    }
                }, -- AIM-7MH
                {
                    CLSID = "<CLEAN>", arg = 605, arg_value = 1.0,
                    forbidden = {
                        {station = pylon_4,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_4,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_5,loadout = {"{AIM_54C_Mk60}"}},
                    }
                },
                belly_aim7p("WEP_Sparrow_Centr", 605, rewrite_settings.Name,
                  { {station = pylon_3,loadout = {"{AIM_54A_Mk47}"}},
                    {station = pylon_3,loadout = {"{AIM_54A_Mk60}"}},
                    {station = pylon_3,loadout = {"{AIM_54C_Mk47}"}},
                    {station = pylon_3,loadout = {"{AIM_54C_Mk60}"}},
                    {station = pylon_4,loadout = {"{AIM_54A_Mk47}"}},
                    {station = pylon_4,loadout = {"{AIM_54A_Mk60}"}},
                    {station = pylon_4,loadout = {"{AIM_54C_Mk47}"}},
                    {station = pylon_4,loadout = {"{AIM_54C_Mk60}"}},
                    {station = pylon_5,loadout = {"{AIM_54A_Mk47}"}},
                    {station = pylon_5,loadout = {"{AIM_54A_Mk60}"}},
                    {station = pylon_5,loadout = {"{AIM_54C_Mk47}"}},
                    {station = pylon_5,loadout = {"{AIM_54C_Mk60}"}},
                    {station = pylon_6,loadout = {"{AIM_54A_Mk47}"}},
                    {station = pylon_6,loadout = {"{AIM_54A_Mk60}"}},
                    {station = pylon_6,loadout = {"{AIM_54C_Mk60}"}},
                    {station = pylon_6,loadout = {"{AIM_54C_Mk47}"}} } ),
                bombs(bomb_rear, bomb_right)
            }
        ),
        pylon(pylon_6, 1, 2.749000, -0.462000, 0.492000,
            {
                --FiZ = -1,
                DisplayName = "6", -- front right
                use_full_connector_position = true,
            },
            {
                { CLSID = "{AIM_54A_Mk47}", arg = 602, arg_value = 0, connector = "WEP_Phoenix_FrontPallette_R", Cx_gain = 0.57,
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54A
                { CLSID = "{AIM_54A_Mk60}", arg = 602, arg_value = 0, connector = "WEP_Phoenix_FrontPallette_R", Cx_gain = 0.57,
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54A Mk60
                { CLSID = "{AIM_54C_Mk47}", arg = 602, arg_value = 0, connector = "WEP_Phoenix_FrontPallette_R", Cx_gain = 0.57,
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54C Mk47
				{ CLSID = "{AIM_54C_Mk60}", arg = 602, arg_value = 0, connector = "WEP_Phoenix_FrontPallette_R", Cx_gain = 0.57,
                    forbidden = {
                        {station = pylon_5,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7M}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7F}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7MH}"}},
                        {station = pylon_5,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_3,loadout = {"{BELLY AIM-7P}"}},
                        {station = pylon_6,loadout = {"{BELLY AIM-7P}"}},
                    }
                }, -- AIM-54C Mk60
                { CLSID = "{BELLY AIM-7M}", arg = 600, arg_value = 1.0, connector = "WEP_Sparrow_Indent_F_R", Cx_gain = 0.125,
                    forbidden = {
                        {station = pylon_3,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk60}"}},
                    }
                }, -- AIM-7M
                { CLSID = "{BELLY AIM-7F}", arg = 600, arg_value = 1.0, connector = "WEP_Sparrow_Indent_F_R", Cx_gain = 0.125,
                    forbidden = {
                        {station = pylon_3,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk60}"}},
                    }
                }, -- AIM-7F
                { CLSID = "{BELLY AIM-7MH}", arg = 600, arg_value = 1.0, connector = "WEP_Sparrow_Indent_F_R", Cx_gain = 0.125,
                    forbidden = {
                        {station = pylon_3,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk60}"}},
                    }
                }, -- AIM-7MH
                {
                    CLSID = "<CLEAN>", arg = 600, arg_value = 1.0,
                    forbidden = {
                        {station = pylon_3,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_3,loadout = {"{AIM_54C_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54A_Mk60}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk47}"}},
                        {station = pylon_6,loadout = {"{AIM_54C_Mk60}"}},
                    }
                },
                belly_aim7p("WEP_Sparrow_Indent_F_R", 600, rewrite_settings.Name,
                  { {station = pylon_3,loadout = {"{AIM_54A_Mk47}"}},
                    {station = pylon_3,loadout = {"{AIM_54A_Mk60}"}},
                    {station = pylon_3,loadout = {"{AIM_54C_Mk47}"}},
                    {station = pylon_3,loadout = {"{AIM_54C_Mk60}"}},
                    {station = pylon_6,loadout = {"{AIM_54A_Mk47}"}},
                    {station = pylon_6,loadout = {"{AIM_54A_Mk60}"}},
                    {station = pylon_6,loadout = {"{AIM_54C_Mk60}"}},
                    {station = pylon_6,loadout = {"{AIM_54C_Mk47}"}} } ),
                bombs(bomb_front, bomb_right)
            }
        ),
        pylon(pylon_7, 1, -0.221000, -0.882000, 1.487000,
            {
                --FiZ = 0,
                DisplayName = "7",
                connector = "WEP_Fuel_Pylon_R",
                use_full_connector_position = true,
            },
            {
                fuel_tanks(rewrite_settings.Name, pylon_2)
            }
        ),
        pylon(pylon_8B, 1, 0.900000, -0.230000, 3.125000,
            {
                --FiZ = -1,
                DisplayName = "8B",
                use_full_connector_position = true,
            },
            {
                { CLSID = "{SHOULDER AIM_54C_Mk47 R}",connector="WEP_PhoenixWingPylon_R"  },  -- AIM-54C Mk47
                { CLSID = "{SHOULDER AIM_54C_Mk60 R}",connector="WEP_PhoenixWingPylon_R"  },  -- AIM-54C Mk47
                { CLSID = "{SHOULDER AIM_54A_Mk47 R}",connector="WEP_PhoenixWingPylon_R"  },  -- AIM-54A Mk47
                { CLSID = "{SHOULDER AIM_54A_Mk60 R}",connector="WEP_PhoenixWingPylon_R"  },  -- AIM-54A Mk60
                { CLSID = "{SHOULDER AIM-7M}",connector="WEP_Shoulder_Sparrow_R" },
                { CLSID = "{SHOULDER AIM-7F}",connector="WEP_Shoulder_Sparrow_R" },
                { CLSID = "{SHOULDER AIM-7MH}",connector="WEP_Shoulder_Sparrow_R" },
                { CLSID = "{LAU-7 - AIM-9M}",Type=0,connector="WEP_Sidewinder_Extra_R"}, -- AIM-9M
                { CLSID = "{LAU-7 - AIM-9L}",Type=0,connector="WEP_Sidewinder_Extra_R"}, -- AIM-9L
                { CLSID = "{LAU-7 - TCTS}",connector="WEP_Sidewinder_Extra_R" }, -- ACMI pod
                shoulder_a2a(bomb_right, rewrite_settings.Name),
                shoulder_a2g(bomb_right, rewrite_settings.Name)
            }
        ),
        pylon(pylon_8A, 0, 1.342000, 0.183859,  3.44629,
            {
                --FiX = -90,
                --FiZ = 5.03,
                DisplayName = "8A",
                connector = "WEP_AIM-9_R",
                use_full_connector_position = true,
            },
            {
                { CLSID = "{LAU-138 wtip - AIM-9M}" }, -- AIM-9M
                { CLSID = "{LAU-138 wtip - AIM-9L}" }, -- AIM-9L
                { CLSID = "{LAU-138 wtip - TCTS R}" }, -- ACMI pod
                { CLSID = "CATM-9M" }, -- CATM-9/CAP-9M
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}" }, -- Smokewinder red
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}" }, -- Smokewinder green
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}" }, -- Smokewinder blue
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}" }, -- Smokewinder white
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}" }, -- Smokewinder yellow
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}" }, -- Smokewinder orange
            }
        )

    },

    Tasks =
    {
        aircraft_task(CAP),
        aircraft_task(Escort),
        aircraft_task(FighterSweep),
        aircraft_task(Intercept),
        --aircraft_task(GAI),
        aircraft_task(Reconnaissance),
        aircraft_task(GroundAttack),
        aircraft_task(RunwayAttack),
        aircraft_task(PinpointStrike),
		aircraft_task(AntishipStrike),
        aircraft_task(CAS),
        aircraft_task(AFAC),
    },
    DefaultTask = aircraft_task(Intercept),

    --*************************************************************


    --************************ SFM ******************************
    SFM_Data =
    {
        aerodynamics =
        {
            Cy0    =    0.075,
            Mzalfa    =    4.355,
            Mzalfadt    =    0.8,
            kjx    =    2.75,
            kjz    =    0.00125,
            Czbe    =    -0.016,
            cx_gear    =    0.0268,
            cx_flap    =    0.05,
            cy_flap    =    0.5,
            cx_brk    =    0.06,
            table_data =
            {--                    M            Cx0           Cya             B              B4          Omxmax     Aldop         Cymax
                [1]      =    {    0.000    ,    0.021    ,    0.062    ,    0.110    ,    0.042    ,    0.500    ,    30.000    ,    1.925    },
                [2]      =    {    0.200    ,    0.021    ,    0.062    ,    0.110    ,    0.042    ,    1.500    ,    30.000    ,    1.925    },
                [3]      =    {    0.400    ,    0.021    ,    0.062    ,    0.110    ,    0.042    ,    2.500    ,    30.000    ,    1.925    },
                [4]      =    {    0.600    ,    0.022    ,    0.062    ,    0.110    ,    0.042    ,    3.500    ,    30.000    ,    1.925    },
                [5]      =    {    0.700    ,    0.022    ,    0.062    ,    0.110    ,    0.042    ,    3.500    ,    28.667    ,    1.925    },
                [6]      =    {    0.800    ,    0.022    ,    0.062    ,    0.150    ,    0.067    ,    3.500    ,    27.333    ,    1.925    },
                [7]      =    {    0.900    ,    0.020    ,    0.062    ,    0.300    ,    0.100    ,    3.500    ,    26.000    ,    1.925    },
                [8]      =    {    1.000    ,    0.028    ,    0.062    ,    0.160    ,    0.000    ,    3.500    ,    24.667    ,    1.925    },
                [9]      =    {    1.050    ,    0.033    ,    0.062    ,    0.180    ,    0.000    ,    3.500    ,    24.000    ,    1.925    },
                [10]      =    {    1.100    ,    0.038    ,    0.035    ,    0.200    ,    0.000    ,    3.150    ,    18.000    ,   1.925    },
                [11]      =    {    1.200    ,    0.038    ,    0.035    ,    0.300    ,    0.100    ,    2.450    ,    17.000    ,   1.050    },
                [12]      =    {    1.300    ,    0.037    ,    0.035    ,    0.317    ,    0.107    ,    1.750    ,    16.000    ,   1.000    },
                [13]      =    {    1.500    ,    0.034    ,    0.034    ,    0.350    ,    0.200    ,    1.500    ,    13.000    ,   0.900    },
                [14]      =    {    1.700    ,    0.031    ,    0.032    ,    0.383    ,    0.200    ,    0.900    ,    12.000    ,   0.700    },
                [15]      =    {    1.800    ,    0.030    ,    0.031    ,    0.400    ,    0.200    ,    0.860    ,    11.400    ,   0.640    },
                [16]      =    {    2.000    ,    0.029    ,    0.030    ,    0.433    ,    0.200    ,    0.780    ,    10.200    ,   0.520    },
                [17]      =    {    2.200    ,    0.032    ,    0.028    ,    0.467    ,    0.200    ,    0.700    ,    9.000    ,    0.400    },
                [18]      =    {    2.400    ,    0.030    ,    0.025    ,    0.500    ,    0.200    ,    0.700    ,    9.000    ,    0.400    },
                [19]      =    {    3.000    ,    0.030    ,    0.025    ,    0.600    ,    0.200    ,    0.700    ,    9.000    ,    0.400    },
            }, -- end of table_data
        }, -- end of aerodynamics
        engine =
        {
            Nmg    =    63.5,
            MinRUD    =    0,
            MaxRUD    =    1,
            MaksRUD    =    0.85,
            ForsRUD    =    0.91,
            typeng    =    1,
            hMaxEng    =    19,
            dcx_eng    =    0.0144,
            cemax    =    1.24,
            cefor    =    2.56,
            dpdh_m    =    1650,
            dpdh_f    =    14000,
            table_data =
            {
                [1]      =    {    0.000    ,    99508    ,    179415    },
                [2]      =    {    0.200    ,    96492    ,    179415    },
                [3]      =    {    0.400    ,    96492    ,    189969    },
                [4]      =    {    0.600    ,    99508    ,    208062    },
                [5]      =    {    0.700    ,    101015    ,    220123    },
                [6]      =    {    0.800    ,    99508    ,    230677    },
                [7]      =    {    0.900    ,    98603    ,    237000    },
                [8]      =    {    1.000    ,    98000    ,    247000    },
                [9]      =    {    1.100    ,    105539    ,    279000    },
                [10]      =    {    1.200    ,    108554    ,    291000    },
                [11]      =    {    1.300    ,    111569    ,    300000    },
                [12]      =    {    1.500    ,    114585    ,    310000    },
                [13]      =    {    1.800    ,    108554    ,    325000    },
                [14]      =    {    2.000    ,    102523    ,    329000    },
                [15]      =    {    2.200    ,    96492    ,    346000    },
                [16]      =    {    2.400    ,    90462    ,    348000    },
                [17]      =    {    3.000    ,    84431    ,    271385    },
            }, -- end of table_data
        }, -- end of engine
    },

    --************************ SFM end **************************

    --************************ DAMAGE **************************

    Damage = verbose_to_dmg_properties({
       
        ["WING_L"]				    = {args = {510}, critical_damage = 6, deps_cells = {"FLAP_L", "WING_FUEL_TANK_L"}},
        -- ["WING_L"]				    = {args = {510}, critical_damage = 10, deps_cells = {"WING_L_TIP", "WING_L_SPOILERS", "WING_L_FLAPS"}},
        -- ["WING_L_TIP"]			    = {args = {511}, critical_damage = 3},
		-- ["WING_L_SPOILERS"]	    	= {args = {512}, critical_damage = 2},
        ["FLAP_L"]		    		= {args = {513}, critical_damage = 2},

        ["WINGBOX_LEFT"]			= {args = {514}, critical_damage = 15},  -- Main wingbox mechanism left
        ["WINGBOX_RIGHT"]		    = {args = {515}, critical_damage = 15},  -- Main wingbox mechanism right

        ["CABIN_LEFT_SIDE"]			= {args = {516}, critical_damage = 2},  --Front fuselage left
        ["CABIN_RIGHT_SIDE"]		= {args = {517}, critical_damage = 2},  --Front fuselage right
        
        ["FUSELAGE_LEFT_SIDE"]		= {args = {518}, critical_damage = 3},  --Shoulder Left
        ["FUSELAGE_RIGHT_SIDE"]		= {args = {519}, critical_damage = 3},  --Shoulder Right

        ["FUSELAGE_TOP"]		    = {args = {520}, critical_damage = 3},  --Fuselage Spine
        
        ["ENGINE_R_INTAKE"]		    = {args = {521}, critical_damage = 3},  --Engine Intake
        ["ENGINE_L_INTAKE"]		    = {args = {522}, critical_damage = 3},  --Engine Intake

        ["ENGINE_L_UPPER"]		    = {args = {523}, critical_damage = 3},  --Engine/Fuselage Upper 
        ["ENGINE_R_UPPER"]		    = {args = {524}, critical_damage = 3},  --Engine/Fuselage Upper

        ["ENGINE_R"]		        = {args = {525}, critical_damage = 3},  --Engine nacelle bottom part
        ["ENGINE_L"]		        = {args = {526}, critical_damage = 3},  --engine nacelle bottom part

        ["NOSE_CENTER"]	            = {args = {527}, critical_damage = 2},  --Nosecone

        ["CREW_1"]	                = {args = {528}, critical_damage = 2},   --Pilot
        ["CREW_2"]	                = {args = {529}, critical_damage = 2},   --Rio

        ["ELEVATOR_L"]			    = {args = {530}, critical_damage = 4},   -- Horizontal tailplane
        ["ELEVATOR_R"]			    = {args = {531}, critical_damage = 4},   -- Horizontal tailplane
        
        ["FIN_L_CENTER"]			= {args = {532}, critical_damage = 4, deps_cells = {"FIN_L_TOP", "RUDDER_L"}},  --Left Vertical lower (About half and half)
        ["FIN_L_TOP"]				= {args = {533}, critical_damage = 3},  --Left Vertical Upper
        
        ["FIN_R_CENTER"]			= {args = {534}, critical_damage = 4, deps_cells = {"FIN_R_TOP", "RUDDER_R"}},  --Right vertical lower
        ["FIN_R_TOP"]				= {args = {535}, critical_damage = 3},  --Right vertical Upper
        
        ["AVX_001"]		            = {args = {536}, critical_damage = 2},    --Avionics cluster front left fuselage right behind the radar
        ["AVX_002"]		            = {args = {537}, critical_damage = 2},    --Avionics cluster left side behind RIO
        ["AVX_003"]		            = {args = {538}, critical_damage = 2},    --Avionics cluster right side behind RIO
        ["AVX_004"]		            = {args = {539}, critical_damage = 2},    --Avionics box behind left side RIO cluster

        ["AVX_GTS"]		            = {args = {540}, critical_damage = 2},    --Avionics cluster front left fuselage right behind the radar
        ["AVX_ECS"]		            = {args = {541}, critical_damage = 2},    --Avionics cluster front left fuselage right behind the radar

        ["SPINE_LINES_01"]			= {args = {542}, critical_damage = 2},   --Hydraulics/Lines that run down the spine (frontmost)
        ["SPINE_LINES_02"]			= {args = {543}, critical_damage = 2},   --Hydraulics/Lines that run down the spine (middle)
        ["SPINE_LINES_03"]			= {args = {544}, critical_damage = 2},   --Hydraulics/Lines that run down the spine (rearmost)

        ["FUEL_TANK_FRONT"]			= {args = {545}, critical_damage = 2},   --Fuel tank right behind RIO
        ["FUEL_TANK_CENTR"]			= {args = {546}, critical_damage = 2},   --Middle Fuselage
        ["FUEL_TANK_REAR"]			= {args = {547}, critical_damage = 2},   --Fuel tank Rear Fuselage

        ["WING_FUEL_TANK_L"]		= {args = {548}, critical_damage = 3},   --Left wing fuel tank
        ["WING_FUEL_TANK_R"]		= {args = {549}, critical_damage = 3},   --Right wing fuel tank

        ["INTAKE_RAMPS_RIGHT"]		= {args = {550}, critical_damage = 3},   --Intake Ramp Actuators Right
        ["INTAKE_RAMPS_LEFT"]		= {args = {551}, critical_damage = 3},   --Intake Ramp Actuators Left

        ["TCS"]	                	= {args = {552}, critical_damage = 1},   --TCS Pod

        ["GUN_BARELLS"]	        	= {args = {553}, critical_damage = 3},   --M61 Barrels
        ["GUN_AMMO"]	        	= {args = {554}, critical_damage = 3},   --M61 AmmoDrum

        ["FRONT_PHOENIX"]	    	= {args = {555}, critical_damage = 2},   --Front Phoenix Pylons
        ["REAR_PHOENIX"]	   		= {args = {556}, critical_damage = 2},   --Rear Phoenix Pylons

        --Left Engine -------------------------
        ["F110_FRONT_L"]			= {args = {557}, critical_damage = 4},   --Engine Fan Stage (intake)
        ["F110_MID_L"]				= {args = {558}, critical_damage = 4},   --Middle of engine
        ["F110_REAR_L"]				= {args = {559}, critical_damage = 4},   --Rear of engine
        ["NOZZLE_L"]				= {args = {560}, critical_damage = 4},   --Left Engine petals/nozzle

         --Right Engine -------------------------
        ["F110_FRONT_R"]			= {args = {561}, critical_damage = 4},   --Engine Fan Stage (intake)
        ["F110_MID_R"]				= {args = {562}, critical_damage = 4},   --Middle of engine
        ["F110_REAR_R"]				= {args = {563}, critical_damage = 4},   --Rear of engine
        ["NOZZLE_R"]				= {args = {564}, critical_damage = 4},   --Right Engine petals/nozzle

        ["COUNTERMEASURES"]			= {args = {565}, critical_damage = 1},   --Block of countermeasures on tail

        ["ECM_DUCKTAIL"]			= {args = {566}, critical_damage = 1},   --ECM Antenna on ducktail
       
        ["TACAN"]					= {args = {567}, critical_damage = 1},   --TACAN Antenna spine
        ["UHF_IFF"]					= {args = {568}, critical_damage = 1},   --UHF/IFF antenna spine

        ["RWR_NACELLE_L"]			= {args = {569}, critical_damage = 1},   -- RWR antenna (315 deg) on the nacelle
        ["RWR_NACELLE_R"]			= {args = {570}, critical_damage = 1},   -- RWR antenna (45 deg) on the nacelle
		
		["WING_R"]					= {args = {571}, critical_damage = 6, deps_cells = {"FLAP_R", "WING_FUEL_TANK_L"}},
		-- ["WING_R"]				= {args = {571}, critical_damage = 10, deps_cells = {"WING_R_TIP", "WING_R_SPOILERS", "WING_R_FLAPS"}},
        -- ["WING_R_TIP"]			= {args = {572}, critical_damage = 3},
		-- ["WING_R_SPOILERS"]		= {args = {573}, critical_damage = 2},
		["FLAP_R"]					= {args = {574}, critical_damage = 2},

        ["RUDDER_L"]				= {args = {575}, critical_damage = 2},
        ["RUDDER_R"]				= {args = {576}, critical_damage = 2},

        ["RWR_TAIL_L"]				= {args = {577}, critical_damage = 1},	-- RWR antenna (225 deg)
        ["RWR_TAIL_R"]				= {args = {578}, critical_damage = 1},	-- RWR antenna (135 deg)
        
		-- No 3d shapes:
        -- ["SPEEDBRAKE_LB"]		= {args = {579}, critical_damage = 1},
        -- ["SPEEDBRAKE_RB"]		= {args = {580}, critical_damage = 1},
        -- ["SPEEDBRAKE_T"]			= {args = {581}, critical_damage = 1},

        -- ["GEAR_N"]				= {args = {582}, critical_damage = 4},
        -- ["GEAR_L"]				= {args = {583}, critical_damage = 4},
        -- ["GEAR_R"]				= {args = {584}, critical_damage = 4},
		
		["KEEL_L"]					= {args = {586}, critical_damage = 3},  -- Little fin under the nacelle
		["KEEL_R"]					= {args = {587}, critical_damage = 3},  -- Little fin under the nacelle
		
		["PYLONL"]					= {args = {588}, critical_damage = 2},
		["PYLONR"]					= {args = {589}, critical_damage = 2},
		
		["AVX_WALL_LEFT_FRONT"]		= {args = {590}, critical_damage = 2},
        ["AVX_WALL_LEFT_REAR"]		= {args = {591}, critical_damage = 2},
		["AVX_WALL_RIGHT_FRONT"]	= {args = {592}, critical_damage = 2},
        ["AVX_WALL_RIGHT_REAR"]		= {args = {593}, critical_damage = 2},
		
		["DASHBOARD_PILOT"]			= {args = {594}, critical_damage = 2},
        ["DASHBOARD_RIO"]			= {args = {595}, critical_damage = 2},
		
		["EJECTION_SEAT_PILOT"]		= {args = {596}, critical_damage = 6},
        ["EJECTION_SEAT_RIO"]		= {args = {597}, critical_damage = 6},
		
		["HOOK"]					= {args = {2502}, critical_damage = 3},
    }),

    DamageParts =
    {

        [1000 + 35] = "f-14b_damageParts_wing", --Wing L
        [1000 + 36] = "f-14b_damageParts_wing", --Wing R

        [1000 + 51] = "f-14b_damageParts_stabilizer",
        [1000 + 52] = "f-14b_damageParts_stabilizer",
		
		[1000 + 98] = "f-14b_damageParts_hook",


    --    [1000 + 55] = "MiG-21-oblomok-tail",
    },

    --****************************************************

    --******************* LIGHTS *************************

    lights_data =
    {
        typename =    "collection",
		lights      =
            {
				[1]	= {
					typename	=	"collection",
					lights 		= {	{typename = "argumentlight", argument = 83}, },		-- anticollision lights					
				},--must be collection
				[2]	= {
					typename	= 	"collection",
					lights		= {	{typename  = "argumentlight",	argument  = 51}, }, -- taxi
				},--must be collection
				[3]	= {
					typename 	= "collection",
					lights		= {	{typename  = "argumentlight",	argument  = 190}, }, -- position
				},--must be collection
				[4]	= {
					typename	= "collection",
					lights		= {	{typename  = "argumentlight",	argument  = 200},	}, -- slime
				},--must be collection
				[5]	= {},--must be collection
            },
    },

    --****************************************************

    --************** EDITOR CUSTOM SUBMENU ***************

    panelRadio = {
		[1] = {
            name = _("UHF AN/ARC-159"),
            range = {min = 225.0, max = 399.975},
            channels = {
                [1] = { name = _("Channel 1"), default = 225.0, modulation = _("AM")}, -- default
                [2] = { name = _("Channel 2"), default = 258.0, modulation = _("AM")},
                [3] = { name = _("Channel 3"), default = 260.0, modulation = _("AM")},
                [4] = { name = _("Channel 4"), default = 270.0, modulation = _("AM")},
                [5] = { name = _("Channel 5"), default = 255.0, modulation = _("AM")},
                [6] = { name = _("Channel 6"), default = 259.0, modulation = _("AM")},
                [7] = { name = _("Channel 7"), default = 262.0, modulation = _("AM")},
                [8] = { name = _("Channel 8"), default = 257.0, modulation = _("AM")},
                [9] = { name = _("Channel 9"), default = 253.0, modulation = _("AM")},
                [10] = { name = _("Channel 10"), default = 263.0, modulation = _("AM")},
                [11] = { name = _("Channel 11"), default = 267.0, modulation = _("AM")},
                [12] = { name = _("Channel 12"), default = 254.0, modulation = _("AM")},
                [13] = { name = _("Channel 13"), default = 264.0, modulation = _("AM")},
                [14] = { name = _("Channel 14"), default = 266.0, modulation = _("AM")},
                [15] = { name = _("Channel 15"), default = 265.0, modulation = _("AM")},
                [16] = { name = _("Channel 16"), default = 252.0, modulation = _("AM")},
                [17] = { name = _("Channel 17"), default = 268.0, modulation = _("AM")},
                [18] = { name = _("Channel 18"), default = 269.0, modulation = _("AM")},
                [19] = { name = _("Channel 19"), default = 268.0, modulation = _("AM")},
                [20] = { name = _("Channel 20"), default = 269.0, modulation = _("AM")},
            }
        },
		[2] = {
            name = _("VHF/UHF AN/ARC-182"),
            range = {{min = 30.0, max = 87.975},
					 {min = 108.0, max = 173.975},
					 {min = 225.0, max = 399.975}},
            channels = {
                [1] = { name = _("Channel 1"), default = 225.0}, -- default
                [2] = { name = _("Channel 2"), default = 258.0},
                [3] = { name = _("Channel 3"), default = 260.0},
                [4] = { name = _("Channel 4"), default = 270.0},
                [5] = { name = _("Channel 5"), default = 255.0},
                [6] = { name = _("Channel 6"), default = 259.0},
                [7] = { name = _("Channel 7"), default = 262.0},
                [8] = { name = _("Channel 8"), default = 257.0},
                [9] = { name = _("Channel 9"), default = 253.0},
                [10] = { name = _("Channel 10"), default = 263.0},
                [11] = { name = _("Channel 11"), default = 267.0},
                [12] = { name = _("Channel 12"), default = 254.0},
                [13] = { name = _("Channel 13"), default = 264.0},
                [14] = { name = _("Channel 14"), default = 266.0},
                [15] = { name = _("Channel 15"), default = 265.0},
                [16] = { name = _("Channel 16"), default = 252.0},
                [17] = { name = _("Channel 17"), default = 268.0},
                [18] = { name = _("Channel 18"), default = 269.0},
                [19] = { name = _("Channel 19"), default = 268.0},
                [20] = { name = _("Channel 20"), default = 269.0},
                [21] = { name = _("Channel 21"), default = 225.0},
                [22] = { name = _("Channel 22"), default = 258.0},
                [23] = { name = _("Channel 23"), default = 260.0},
                [24] = { name = _("Channel 24"), default = 270.0},
                [25] = { name = _("Channel 25"), default = 255.0},
                [26] = { name = _("Channel 26"), default = 259.0},
                [27] = { name = _("Channel 27"), default = 262.0},
                [28] = { name = _("Channel 28"), default = 257.0},
                [29] = { name = _("Channel 29"), default = 253.0},
                [30] = { name = _("Channel 30"), default = 263.0},
            }
        },
    },

    AddPropAircraft = {
        {
            id = "M61BURST", control = 'comboList', label = _('M-61 Burst Mode'),
            values = {
                {id =  0, dispName = _("Burst 200")},
                {id =  1, dispName = _("Burst 100")},
                {id =  2, dispName = _("Burst 50")},
                {id =  3, dispName = _("Manual")},
            },
            defValue  = m61burstdefault(rewrite_settings.Name),
            wCtrl     = 150,
            playerOnly = true
        },
		{
            id = "ALE39Loadout", control = 'comboList', label = _('AN/ALE-39 Loadout'),
            values = {
                {id =  0, dispName = _("60 Flares / 0 Chaff")},
                {id =  1, dispName = _("50 Flares / 10 Chaff")},
                {id =  2, dispName = _("40 Flares / 20 Chaff")},
                {id =  3, dispName = _("30 Flares / 30 Chaff")},
				{id =  4, dispName = _("20 Flares / 40 Chaff")},
				{id =  5, dispName = _("10 Flares / 50 Chaff")},
				{id =  6, dispName = _("0 Flares / 60 Chaff")},
            },
            defValue  = 0,
            wCtrl     = 150,
            playerOnly = true
        },
		{ id = "UseLAU138", control = 'checkbox', label = _('Fill LAU-138 With Chaff'), defValue = true, playerOnly = true},
		{ id = "INSAlignmentStored", control = 'checkbox', label = _('INS Reference Alignment Stored'), defValue = false, playerOnly = true},
        { id = "TacanChannel" , control = 'spinbox', label = _('TACAN Channel Presel (0 = Auto)'), defValue = 0, min = 0, max = 126, playerOnly = true},
		{ id = "TacanBand", control = 'comboList', label = _('TACAN Band'), defValue = 0, values = { {id =  0, dispName = _("X")}, {id =  1, dispName = _("Y") } }, playerOnly = true},
		{ id = "IlsChannel" , control = 'spinbox', label = _('ILS Channel Presel'), defValue = 1, min = 1, max = 20, playerOnly = true},
        { id = "KY28Key" , control = 'spinbox', label = _('KY-28 Encryption Key'), defValue = 1, min = 1, max = 255, playerOnly = true},
        { id = "LGB1000", control = 'spinbox',  label = _('Laser Code 1st Digit'), defValue = 1, min = 1, max = 1, dimension = ' ', playerOnly = true}, -- only for completeness
        { id = "LGB100", control = 'spinbox',  label = _('Laser Code 2nd Digit'), defValue = 6, min = 5, max = 7, dimension = ' ', playerOnly = true},
        { id = "LGB10", control = 'spinbox',  label = _('Laser Code 3rd Digit'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},
        { id = "LGB1", control = 'spinbox',  label = _('Laser Code 4th Digit'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},

      --  { id = "JesterDisable", control = 'checkbox', label = _('Disable Jester AI'), defValue = false, playerOnly = true},
    },

}

if rewrite_settings then
   for i,o in pairs(rewrite_settings) do
		F_14[i] = o
   end
end

add_aircraft(F_14)

end

make_f14()
