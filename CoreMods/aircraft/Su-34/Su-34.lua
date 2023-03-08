 local RAIL 	= 0
 local CATAPULT = 1

local BD4_pylons =
{
	[4] = "Point4_BD4",
	[7] = "Point7_BD4",
	[9] = "Point9_BD4",
}

local AKU470_connectors = 
{
[7]  = "Pylon7_AKU470",	
[8]  = "Point8_AKU470",
[5]  = "Point5_AKU470",
[6]  = "Point6_AKU470",	
}

local EMPTY_station =
{
	[2]  = "PYLON_2",
	[3]  = "PYLON_3",
	[4]  = "PYLON_4",
	[5]  = "PYLON_5",
	[6]  = "PYLON_6",
	[7]  = "PYLON_7",
	[8]  = "PYLON_8",
	[9]  = "PYLON_9",
	[10] = "PYLON_10"
}

local function BD4_(station,clsid)
	local conn = BD4_pylons[station]
	if conn ~= nil then
		return {CLSID = clsid,  connector = conn , arg_value = 0.1 }
	else
		return {CLSID = clsid}
	end
end

local function MER(station,clsid)
	local conn = EMPTY_station[station]
	if conn ~= nil then
		return {CLSID = clsid, connector = conn , arg_value = 0}
	else
		return {CLSID = clsid}
	end
end

local function WITHOUT_BD(station,clsid,launch_type)
	local conn = EMPTY_station[station]
	if conn ~= nil then
		return {CLSID = clsid, connector = conn , arg_value = 1,Type = launch_type}
	else
		return {CLSID = clsid,Type = launch_type}
	end
end

local SIDE_R73		= { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}"}

local APU_R73		= { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", arg_value = 0.55}							-- R_73 APU-73

local AKU_R77 		= function (index)			return { CLSID = "{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}", connector = string.format("Point%d_AKU170",index), arg_value = 0.25,	Type = CATAPULT	} end  --R-77 AKU-170

local AKU_470		= function (index,clsid)	return { CLSID = clsid ,connector = AKU470_connectors[index], arg_value = 0.3,	Type = CATAPULT}	end	--AKU-470
local APU_470		= function (index,clsid)	return { CLSID = clsid ,connector = string.format("Point%d_APU470",index)	 ,  arg_value = 0.35}	end	--APU-470

local AKU_R27R		= function (index) return AKU_470(index,"{9B25D316-0434-4954-868F-D51DB1A38DF0}") end		-- R-27 AKU-470
local AKU_R27ER		= function (index) return AKU_470(index,"{E8069896-8435-4B90-95C0-01A03AE6E400}") end		-- R-27ER AKU-470

local APU_R27R		= function (index) return APU_470(index,"{9B25D316-0434-4954-868F-D51DB1A38DF0}") end
local APU_R27ER		= function (index) return APU_470(index,"{E8069896-8435-4B90-95C0-01A03AE6E400}") end
local APU_R27T		= function (index) return APU_470(index,"{88DAC840-9F75-4531-8689-B46E64E42E53}") end
local APU_R27ET		= function (index) return APU_470(index,"{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}") end

local function BD3(clsid)
	return {CLSID = clsid, arg_value = 0.05 }
end

local function MER_6xFAB100(station)
	return	MER(station,"{F99BEC1A-869D-4AC7-9730-FBA0E3B1F5FC}")
end

local function MER_6xFAB250(station)
	return	MER(station,"{53BE25A4-C86C-4571-9BC0-47D668349595}")
end

local function MER_5xFAB250(station)
	return	MER(station,"{MBD3_U6_5*FAB-250}")
end

local ADD_LIST = function(dest,src)
	local t = dest or {}
	if src then
		for i,o in ipairs(src) do
			t[#t + 1] = o
		end
	end
	return t
end


local AG_MISSILES = 
{
	---------------------------------------------------------------------
	{ CLSID = "{X-29T}", arg_value = 0.45, Type = CATAPULT, add_mass = 186 },	--	Kh-29T --! add_mass is needed bcuz the AKU-58 is within the Su-34's shape
	{ CLSID = "{X-29L}", arg_value = 0.45, Type = CATAPULT, add_mass = 186 },	--	Kh-29L --! <->
	{ CLSID = "{X-31A}", arg_value = 0.45, Type = CATAPULT, add_mass = 186 },	--	Kh-31A --! <->
	{ CLSID = "{X-31P}", arg_value = 0.45, Type = CATAPULT, add_mass = 186 },	--	Kh-31P --! <->
	{ CLSID = "{2234F529-1D57-4496-8BB0-0150F9BDBBD2}", arg_value = 0.45, Type = CATAPULT, add_mass = 186, attach_point_position = {-0.069, -0.27, 0} },	--	Kh-35 --! <->
	{ CLSID = "{B5CA9846-776E-4230-B4FD-8BCC9BFB1676}", arg_value = 1.0, Type = CATAPULT, attach_point_position = {0.43, 0.21, 0} },						--	Kh-58U
	------------------------------------------------------------------
}

local ROCKETS = 
{
	---------------------------------------------------------------------
	BD3("{F72F47E5-C83A-4B85-96ED-D3E46671EE9A}"),	--	B-8M1 - 20 S-8KOM
	BD3("{FC56DF80-9B09-44C5-8976-DCFAFF219062}"),	--	B-13L - 5 S-13 OF
	BD3("{A0648264-4BC0-4EE8-A543-D119F6BA4257}"),	--	O-25 - S-25 OFM
	BD3("{S_25_O}"),								--	O-25 - S-25 O
	------------------------------------------------------------------
}

local function BOMBS_UP_TO_500(actual_index)
	return 
	{
		BD3("{35B698AC-9FEF-4EC4-AD29-484A0085F62B}"),	--	BetAB-500
		BD3("{BD289E34-DF84-4C5E-9220-4B14C346E79D}"),	--	BetAB-500ShP
		BD3("{4203753F-8198-4E85-9924-6F8FF679F9FF}"),	--	RBK-250 PTAB-2.5M
		BD3("{RBK_250_275_AO_1SCH}"),					--	RBK-250-275 AO-1SCH
		BD3("{RBK_500U_OAB_2_5RT}"),					--	RBK-500U OAB-2.5RT
		BD3("{D5435F26-F120-4FA3-9867-34ACE562EF1B}"),	--	RBK-500-255 PTAB-10-5
		BD3("{7AEC222D-C523-425e-B714-719C0D1EB14D}"),	--	RBK-500 PTAB-1M
		BD3("{3C612111-C7AD-476E-8A8E-2485812F4E5C}"),	--	FAB-250
		BD3("{FAB_250_M62}"),							--	FAB-250-M62
		BD3("{37DCC01E-9E02-432F-B61D-10C166CA2798}"),	--	FAB-500 M62
		BD3("{BA565F89-2373-4A84-9502-A0E017D3A44A}"),	--	KAB-500L
		BD3("{E2C426E3-8B10-4E09-B733-9CDC26520F48}"),	--	KAB-500Kr
		BD3("{KAB_500S_LOADOUT}"),						--	KAB-500S
		BD3("{0511E528-EA28-4caf-A212-00D1408DF10A}"),	--	SAB-100
		BD3("{FB3CE165-BF07-4979-887C-92B87F13276B}"),	--	FAB-100
		MER_6xFAB100(actual_index), 					--  6 * FAB-100	
	}
end

local BD_FAB_1500 = {CLSID	= "{40AA4ABE-D6EB-4CD6-AEFE-A1A0477B24AB}", arg_value = 0.15 }		--	FAB-1500 M54

local HEAVY_GUIDED_BOMBS = function(actual_index)
	return {
		BD4_(actual_index,"{39821727-F6E2-45B3-B1F0-490CC8921D1E}"),		--	KAB-1500L
		BD4_(actual_index,"{KAB_1500LG_LOADOUT}"),							--	KAB-1500LG-Pr
		BD4_(actual_index,"{KAB_1500Kr_LOADOUT}"),							--	KAB-1500Kr
	}
end

local DEFAULT_AG_ORDNANCE = function(actual_index)
	local t = {}
	ADD_LIST(t,AG_MISSILES)
	ADD_LIST(t,AG_MISSILES_APU68)
	ADD_LIST(t,ROCKETS)
	ADD_LIST(t,BOMBS_UP_TO_500(actual_index))
	ADD_LIST(t,{
		BD3("{96A7F676-F956-404A-AD04-F33FB2C74884}"),	--	KMGU-2 - 96 AO-2.5RT
		BD3("{96A7F676-F956-404A-AD04-F33FB2C74881}"),	--	KMGU-2 - 96 PTAB-2.5KO
	})
	return t
end

local STATION_2 = function(actual_index)
return {
	APU_R73,
	AKU_R77(actual_index),
}
end

local STATION_3 = function(actual_index)
	local t = DEFAULT_AG_ORDNANCE(actual_index)
	ADD_LIST(t,
	{
		APU_R73,
		AKU_R77(actual_index),
		APU_R27R(actual_index),
		APU_R27ER(actual_index),
		APU_R27T(actual_index),
		APU_R27ET(actual_index),
		MER_5xFAB250(actual_index),
	})
	return t
end

local STATION_4 = function(actual_index)
	local t = DEFAULT_AG_ORDNANCE(actual_index)
	ADD_LIST(t,
	{
		AKU_R77(actual_index),
		APU_R27R(actual_index),
		APU_R27ER(actual_index),
		APU_R27T(actual_index),
		APU_R27ET(actual_index),
		
		BD_FAB_1500,					--	FAB-1500 M54
		MER_5xFAB250(actual_index),
	})
	ADD_LIST(t,HEAVY_GUIDED_BOMBS(actual_index))
	
	local aku58_kh59 				   = WITHOUT_BD(actual_index,"{40AB87E8-BEFB-4D85-90D9-B2753ACF9514}",CATAPULT)
	aku58_kh59.attach_point_position = {0.43,0.03,0}
	
	ADD_LIST(t,
	{
		aku58_kh59
	})
	return t
end

local STATION_5 = function(actual_index)
	local t = {}
	ADD_LIST(t,
	{
		AKU_R77(actual_index),
		AKU_R27R(actual_index),
		AKU_R27ER(actual_index),
		MER_5xFAB250(actual_index),
	})
	ADD_LIST(t,AG_MISSILES)
	ADD_LIST(t,BOMBS_UP_TO_500(actual_index))
	return t
end

local STATION_UNDERBELLY = function(actual_index)
	local t = ADD_LIST(nil,BOMBS_UP_TO_500(actual_index))
	ADD_LIST(t,
	{
		--R77,
		AKU_R27R(actual_index),
		AKU_R27ER(actual_index),
	})
	if actual_index == 7 then 
		ADD_LIST(t,HEAVY_GUIDED_BOMBS(actual_index))
		ADD_LIST(t,{MER_6xFAB250(actual_index)})
		ADD_LIST(t, {BD_FAB_1500})
	end
	return t
end


declare_loadout({
	category 		= CAT_PODS,
	CLSID	 		= "{ECM_POD_L_175V}",
	attribute		=	{4,	15,	45,	WSTYPE_PLACEHOLDER},
	displayName		=	_("L175V Khibiny ECM pod"),
	Cx_pil			=	0.000244140625,
	Picture			= 	"L005.png",
	Weight			= 	150,
	Elements		= 	{}
})

add_aircraft({
	Name 				=   'Su-34',
	DisplayName			= _('Su-34'),
	Picture 			=  'Su-34.png',
	Rate 				=  70, -- RewardPoint in Multiplayer
	Shape 				=  'Su-34',
	shape_table_data 	= 
	{
		{
			file  	 	= "Su-34";
			life  	 	= 24;
			vis  	 	= 3;
			desrt 	 	= "Fighter-1-crush";
			fire  	 	= { 300, 2};
			username 	= "Su-34";
			index 	 	= Su_34;
			classname   = "lLandPlane";
			positioning = "BYNORMAL";
		}
	},
	
	country_of_origin	= "RUS",

	mapclasskey			=  "P0091000024",
	WorldID 			=  Su_34,
	Countries 			= {"Russia"},

	EmptyWeight 		= 22300,
	M_empty				= 22300,
	M_nominal			= 33325,
	M_fuel_max			= 9800,
	MaxFuelWeight 		= 9800,

	M_max				= 45000,
	MaxTakeOffWeight 	= 45000,
	WingSpan 			= 14.7,
	wing_area			= 62,
	wing_span			= 14.7,
	length				= 23.3,
	height				= 6,

	MaxHeight 			= 17000,
	H_max				= 15000,

	MaxSpeed 			= 1900,
	CAS_min				= 58,
	V_opt				= 170,
	V_take_off			= 75,
	V_land				= 65,
	AOA_take_off		= 0.14,
	V_max_sea_level		= 403,
	V_max_h				= 527.78,
	Mach_max			= 1.8,

	bank_angle_max		= 60,
	Ny_min				= -3,
	Ny_max				= 7,
	Ny_max_e			= 7,
	Vy_max				= 300,

	range						=	4000,
	average_fuel_consumption	=	0.2606,
	has_afteburner				=	true,
	has_speedbrake				=	false,
	brakeshute_name				=	4,

	radar_can_see_ground		=	true,
	detection_range_max			=	250,
	RCS							=	6,
	IR_emission_coeff			=	1,
	IR_emission_coeff_ab		=	5,
	tanker_type					=	4,
	air_refuel_receptacle_pos 	= 	{9.709,	0.941,	-1.561},
	wing_tip_pos 				=	{-4.5,	0.4,	7.5},
	flaps_maneuver				=	1,

	main_gear_pos				= 	{-0.29,	-2.819,	2.33},
	nose_gear_pos				= 	{6.78,	-2.587,	0},
	nose_gear_wheel_diameter	=	0.628,
	main_gear_wheel_diameter	=	1.011,


	nose_gear_amortizer_direct_stroke    	 =  0,  -- down from nose_gear_pos !!!
	nose_gear_amortizer_reversal_stroke  	 =  2.25 - 2.587,  -- up
	main_gear_amortizer_direct_stroke	 	 =  0, --  down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke  	 = 	2.417 - 2.819, --  up
	nose_gear_amortizer_normal_weight_stroke = -0.1,-- down from nose_gear_pos
	main_gear_amortizer_normal_weight_stroke = -0.1,-- down from main_gear_pos


	tand_gear_max	=	0.577,

	thrust_sum_max	=	18000,
	thrust_sum_ab	=	25600,
	engines_count	=	2,

	engines_nozzles =
	{
		[1] =
		{
			pos = 	{-6.889,	-0.257,	-1.193},
			elevation	=	1.5,
			diameter	=	1.137,
			exhaust_length_ab	=	7,
			exhaust_length_ab_K	=	0.76,
			smokiness_level     = 	0.1,
		}, -- end of [1]
		[2] =
		{
			pos = 	{-6.889,	-0.257,	1.193},
			elevation	=	1.5,
			diameter	=	1.137,
			exhaust_length_ab	=	7,
			exhaust_length_ab_K	=	0.76,
			smokiness_level     = 	0.1,
		}, -- end of [2]
	}, -- end of engines_nozzles

	crew_members =
	{
		[1] =
		{
			ejection_seat_name	=	9,
			drop_canopy_name	=	"su-34-fonar-l",
            canopy_pos = {0, 0, 0},
            canopy_ejection_dir = {0.0, 0.5, -0.5},
			pos = {7.99, 0.7, -0.367},
		}, -- end of [1]
		[2] =
		{
			ejection_seat_name	=	9,
			drop_canopy_name	=	"su-34-fonar-r",
            canopy_pos = {0, 0, 0},
            canopy_ejection_dir = {0.0, 0.5, 0.5},
			pos = {7.99, 0.7, 0.392},
            canopy_arg = 118,
		}, -- end of [2]
	}, -- end of crew_members

    mechanimations = {
        Door0 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 38, "set", 0.9}}}}, Flags = {"Reversible"}},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "set", 0.0}}}}, Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"PosType", 8}, {"Sleep", "for", 2.0}}}, {C = {{"JettisonCanopy", 0}}}}},
        },
        Door1 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 421, "set", 0.9}}}}, Flags = {"Reversible"}},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 421, "set", 0.0}}}}, Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"JettisonCanopy", 1}}}}},
        },
    }, -- end of mechanimations

	fires_pos =
	{
		[1] = 	{-1.594,	-0.064,		0},
		[2] = 	{-1.073,	0.319,		2.304},
		[3] = 	{-1.187,	0.338,		-3.678},
		[4] = 	{-0.82,		0.265,		2.774},
		[5] = 	{-0.82,		0.265,		-2.774},
		[6] = 	{-0.82,		0.255,		4.274},
		[7] = 	{-0.82,		0.255,		-4.274},
		[8] = 	{-5.889,	-0.257,		1.193},
		[9] = 	{-5.889,	-0.257,		-1.193},
		[10] = 	{-1.257,	0.283,		3.05},
		[11] = 	{-1.257,	0.283,		-3.05},
	}, -- end of fires_pos
	chaff_flare_dispenser =
	{
		[1] =
		{
			dir = 	{0,	1,	0},
			pos = 	{-5.776,	1.4,	-0.422},
		}, -- end of [1]
		[2] =
		{
			dir = 	{0,	1,	0},
			pos = 	{-5.776,	1.4,	0.422},
		}, -- end of [2]
	}, -- end of chaff_flare_dispenser


	-- Countermeasures
	passivCounterm = {
		CMDS_Edit = true,
		SingleChargeTotal = 128,
		-- PPR-26
		chaff = {default = 64, increment = 3, chargeSz = 1},
		-- PPI-26
		flare = {default = 64, increment = 3, chargeSz = 1}
	},

	attribute 		= { wsType_Air, wsType_Airplane, wsType_Fighter, Su_34,"Bombers", "Refuelable"},
	CanopyGeometry	=  makeAirplaneCanopyGeometry(LOOK_GOOD, LOOK_AVERAGE, LOOK_AVERAGE),
	Sensors =
	{
		RADAR = "N-011M",
		OPTIC = "Su-34 FLIR",
		RWR   = "Abstract RWR"
	},
	laserEquipment = 
	{
		laserRangefinder = true,
		laserDesignator  = true,
	},

	--pylons_enumeration = {12, 1, 11, 2, 3, 10, 4, 9, 5, 8, 7, 6},

	Pylons = {
	pylon(1,  RAIL, 	-1.835346, 0.097043,  -7.412458,{use_full_connector_position=true,connector = "Point1_APU73"	,arg = 308,arg_value = 0},
	{
		SIDE_R73,
		{ CLSID = "{44EE8698-89F9-48EE-AF36-5FD31896A82F}",	arg_value = 1,   required = {{station = 12,loadout = {"{44EE8698-89F9-48EE-AF36-5FD31896A82A}"}}}},--Sorbciya
		{ CLSID = "{ECM_POD_L_175V}",						arg_value = 0.1, required = {{station = 12,loadout = {"{ECM_POD_L_175V}"}}}},--Khibiny
	}),
	pylon(2,  RAIL, 	-2.276925, -0.134286, -6.328241,{use_full_connector_position=true,connector = "Point2_APU73"	,arg = 309,arg_value = 0},	STATION_2(2)),
	pylon(3,  CATAPULT, -1.015399, -0.182422, -4.753561,{use_full_connector_position=true,connector = "Point3_BD3"		,arg = 310,arg_value = 0},	STATION_3(3)),
	pylon(4,  CATAPULT, -0.325835, -0.203349, -3.490985,{use_full_connector_position=true,connector = "Point_4_BD3"		,arg = 311,arg_value = 0},	STATION_4(4)),
	pylon(5,  CATAPULT,  0.154832, -1.263379, -1.195078,{use_full_connector_position=true,connector = "Point5_BD3"		,arg = 312,arg_value = 0},	STATION_5(5)),
	pylon(6,  CATAPULT, -4.626298, -0.280635, -0.000286,{use_full_connector_position=true,connector = "Point6_BD3"		,arg = 313,arg_value = 0},	STATION_UNDERBELLY(6)),
	pylon(7,  CATAPULT,  0.297626, -0.268015, -0.000161,{use_full_connector_position=true,connector = "Point7_BD3"		,arg = 314,arg_value = 0},	STATION_UNDERBELLY(7)),
	pylon(8,  CATAPULT,  0.154833, -1.263415,  1.195329,{use_full_connector_position=true,connector = "Point8_BD3"		,arg = 315,arg_value = 0},	STATION_5(8)),
	pylon(9,  CATAPULT, -0.337402, -0.201416,  3.490494,{use_full_connector_position=true,connector = "Point9_BD3"		,arg = 316,arg_value = 0},	STATION_4(9)),
	pylon(10, CATAPULT, -1.018391, -0.183166,  4.753661,{use_full_connector_position=true,connector = "Point10_BD3"		,arg = 317,arg_value = 0},	STATION_3(10)),
	pylon(11, RAIL, 	-2.276925, -0.134286,  6.329078,{use_full_connector_position=true,connector = "Point11_APU73"	,arg = 318,arg_value = 0},	STATION_2(11)),
	pylon(12, RAIL, 	-1.835346,  0.097043,  7.411980,{use_full_connector_position=true,connector = "Point12_APU73"	,arg = 319,arg_value = 0},
	{
		SIDE_R73,
		{ CLSID = "{44EE8698-89F9-48EE-AF36-5FD31896A82A}",	arg_value = 1,   required = {{station = 1,loadout = {"{44EE8698-89F9-48EE-AF36-5FD31896A82F}"}}}},--Sorbciya
		{ CLSID = "{ECM_POD_L_175V}",						arg_value = 0.1, required = {{station = 1,loadout = {"{ECM_POD_L_175V}"}}}},--Khibiny
	})
	},
	
	Damage = {
		[0]  = {critical_damage = 5,  args = {146}},	-- nose center
		[1]  = {critical_damage = 5,  args = {150}},	-- 1 - nose left
		[2]  = {critical_damage = 5,  args = {149}},	-- 2 - nose right
		[3]  = {critical_damage = 20, args = {65}},		-- 3 - cockpit
		[8]  = {critical_damage = 2,  args = {265}},	-- 8 - front gear door
		[9]  = {critical_damage = 3,  args = {154}},	-- 9 - fuselage left
		[10] = {critical_damage = 3,  args = {153}},	-- 10 - fuselage right
		[11] = {critical_damage = 1,  args = {173}},	-- 11 - engine in left 
		[12] = {critical_damage = 1,  args = {162}},	-- 12 - engine in right 
		[13] = {critical_damage = 2,  args = {169,172}},	-- 13 - nacelle, left bottom
		[14] = {critical_damage = 2,  args = {161,163}},	-- 14 - nacelle, right bottom
		[15] = {critical_damage = 2,  args = {267}},	-- 15 - gear left door
		[16] = {critical_damage = 2,  args = {266}},	-- 16 - gear right 	door
		[23] = {critical_damage = 5,  args = {223}},	-- 23 - wing out left
		[21] = {critical_damage = 3,  args = {232}},	-- 21 - slat out left  WING_L_PART_OUT
		[33] = {critical_damage = 3,  args = {230,251}},	-- 33  - slat in left  WING_L_PART_IN
		[29] = {critical_damage = 6,  args = {224}, deps_cells = {21,23}},	-- 29 - wing centre left 
		[37] = {critical_damage = 2,  args = {227}},	-- 37 - flap in left 
		[35] = {critical_damage = 6,  args = {225}, deps_cells = {21, 23, 29, 33, 37}},	-- 35 - wing in left
		[24] = {critical_damage = 5,  args = {213}},	-- 24 - wing out right 
		[22] = {critical_damage = 3,  args = {222}},	-- 22 - slat out right  WING_R_PART_OUT
		[34] = {critical_damage = 3,  args = {221, 250}},	-- 34  - slat in left  WING_R_PART_IN		
		[30] = {critical_damage = 6,  args = {214}, deps_cells = {22,24}},	-- 30 - wing centre right 
		[38] = {critical_damage = 2,  args = {217}},	-- 38 - flap in right 
		[36] = {critical_damage = 6,  args = {215}, deps_cells = {22,24, 34, 30, 38}}, -- 36 - wing in right		
		[39] = {critical_damage = 2,  args = {244}}, 	-- 39 - fin top left 		
		[41] = {critical_damage = 2,  args = {245}, deps_cells = {39}}, 	-- 41 - fin centre left
		[43] = {critical_damage = 2,  args = {246}, deps_cells = {39, 41, 53}},-- 43 - fin bottom left	
		[40] = {critical_damage = 2,  args = {241}}, 	-- 40 - fin top right
		[42] = {critical_damage = 2,  args = {242}, deps_cells = {40}}, 	-- 42 - fin centre right
		[44] = {critical_damage = 2,  args = {243}, deps_cells = {40, 42, 54}}, -- 44 - fin bottom right 
		[47] = {critical_damage = 2,  args = {235}},	-- 47 - stabilizer in left
		[51] = {critical_damage = 2,  args = {240}}, 	-- 51 - elevator in left
		[48] = {critical_damage = 2,  args = {233}},	-- 48 - stabilizer in right
		[52] = {critical_damage = 2,  args = {233}},	-- 52 - elevator in right
		[53] = {critical_damage = 2,  args = {248}},	-- 53 - rudder left
		[54] = {critical_damage = 2,  args = {247}},	-- 54 - rudder right
		[55] = {critical_damage = 6,  args = {159}},	-- 55 - tail
		[58] = {critical_damage = 6,  args = {156}},	-- 58 - tail bottom
		[56] = {critical_damage = 6,  args = {158}},	-- 56 TAIL_LEFT_SIDE
		[57] = {critical_damage = 6,  args = {157}},	-- 57 TAIL_RIGHT_SIDE
		[59] = {critical_damage = 2,  args = {148}},	-- 59 - nose bottom
		[82] = {critical_damage = 2,  args = {152}},	-- 82 - fuselage bottom 
	},
	
	Tasks =
	{
		aircraft_task(AFAC),
		aircraft_task(SEAD),
		aircraft_task(AntishipStrike),
		aircraft_task(CAS),
		aircraft_task(PinpointStrike),
		aircraft_task(GroundAttack),
		aircraft_task(RunwayAttack),
	},
	DefaultTask = aircraft_task(GroundAttack),

	SFM_Data =
	{
		aerodynamics =
		{
			Cy0	=	0,
			Mzalfa	=	4.355,
			Mzalfadt	=	0.8,
			kjx	=	2.4,
			kjz	=	0.00125,
			Czbe	=	-0.016,
			cx_gear	=	0.0268,
			cx_flap	=	0.05,
			cy_flap	=	0.5,
			cx_brk	=	0.06,
			table_data =
			{
				{0,		0.0165,		0.07,	0.1,	0.032,	0.5,	30,			1.6},
				{0.2,	0.0165,		0.07,	0.1,	0.032,	1.5,	30,			1.56667},
				{0.4,	0.0165,		0.07,	0.1,	0.032,	2.5,	30,			1.5333},
				{0.6,	0.0165,		0.073,	0.094,	0.043,	3.5,	30,			1.5},
				{0.7,	0.017,		0.076,	0.094,	0.045,	3.5,	28.6667,	1.43333},
				{0.8,	0.0178,		0.079,	0.094,	0.048,	3.5,	27.3333,	1.36667},
				{0.9,	0.0215,		0.083,	0.11,	0.05,	3.5,	26,			1.3},
				{1,		0.031,		0.085,	0.15,	0.1,	3.5,	24.6667,	1.2333},
				{1.05,	0.0366,		0.0855,	0.15,	0.1,	3.5,	24,			1.2},
				{1.1,	0.0422,		0.086,	0.15,	0.1,	3.15,	18,			1.1},
				{1.2,	0.044,		0.083,	0.14,	0.1,	2.45,	17,			1.05},
				{1.3,	0.0432,		0.077,	0.17,	0.096,	1.75,	16,			1},
				{1.5,	0.0423,		0.062,	0.23,	0.09,	1.5,	13,			0.9},
				{1.7,	0.04183,	0.0513,	0.23,	0.2833,	0.9,	12,		0.7},
				{1.8,	0.0416,		0.046,	0.23,	0.38,	0.86,	11.4,		0.64},
				{2,		0.0416,		0.039,	0.08,	2.5,	0.78,	10.2,		0.52},
				{2.2,	0.0416,		0.034,	0.16,	3.2,	0.7,	9,			0.4},
				{2.5,	0.041,		0.033,	0.25,	4.5,	0.7,	9,			0.4},
				{3.9,	0.0395,		0.033,	0.35,	6,		0.7,	9,			0.4},
			}, -- end of table_data
		}, -- end of aerodynamics
		engine =
		{
			Nmg		=	70.00001,
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	0.85,
			ForsRUD	=	0.91,
			type	=	"TurboJet",
			hMaxEng	=	19,
			dcx_eng	=	0.0124,
			cemax	=	1.24,
			cefor	=	2.56,
			dpdh_m	=	8000,
			dpdh_f	=	17000,
			table_data =
			{
				{0.0,	126000,	185024},
				{0.2,	126000,	198744},
				{0.4,	126000,	208250},
				{0.6,	126000,	220892},
				{0.7,	124000,	226870},
				{0.8,	124000,	232887},
				{0.9,	122000,	250210},
				{1.0,	117000,	256102},
				{1.1,	113000,	265430},
				{1.2,	110000,	280300},
				{1.3,	102000,	298900},
				{1.5,	85000,	326000},
				{1.8,	30000,	350000},
				{2.0,	19000,	363000},
				{2.2,	17000,	384000},
				{2.5,	12000,	415000},
				{3.9,	10000,	260476},
			}, -- end of table_data
		}, -- end of engine
	},

    lights_data = {
        typename = "collection",
        lights = {
            [WOLALIGHT_NAVLIGHTS] = {
                typename = "collection",
                lights = {
                    {
                        typename = "collection",
                        lights = {
                            {
                                typename = "argumentlight", argument = 192,
                            },
                            {
                                typename = "argumentlight", argument = 190,
                            },
                            {
                                typename = "argumentlight", argument = 191,
                            },
                        },
                    },
                },
            },
            [WOLALIGHT_SPOTS] = {
                typename = "collection",
                lights = {
                    {
                        typename = "argumentlight", argument = 210,
                        exposure = {{0, 0.9, 1.0}}, movable = true,
                    },
                },
            },
            [WOLALIGHT_TAXI_LIGHTS] = {
                typename = "collection",
                lights = {
                    {
                        typename = "argumentlight", argument = 210,
                        exposure = {{0, 0.9, 1.0}},
                    },
                },
            },
        },
    },

	-- solve triangle to have B_end == C_end with given A
	-- B_start assumed to be A_start
	-- C_start assumed to be A_end
	SolveTriangles = 
	{
		-- left gear post kinematics 
		{
			A_start   = "bracing_centr004",
			A_end     = "bracing_centr003",
			B_end     = "bracing_004",
			B_control = 484,
			C_end	  = "bracing_003",
			C_control = 483,
			B_scale   =  1/math.rad(46);
			C_scale   =  1/math.rad(25);
		},
		-- right gear post kinematics 
		{
			A_start   = "bracing_centr006",
			A_end     = "bracing_centr005",
			B_end     = "bracing_006",
			B_control = 486,
			C_end	  = "bracing_005",
			C_control = 485,
			B_scale   =  1/math.rad(46);
			C_scale   =  1/math.rad(25);
		},
	},
})
