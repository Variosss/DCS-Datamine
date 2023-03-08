local ka_50_III_wingtip_station =
{
	-- database (aircraft weapon pack) definition
	{ CLSID = "{9S846_2xIGLA}",	arg_value = 0,	add_mass = 25.8 },
	{ CLSID = "<CLEAN>",		arg_value = 1,	add_mass = -25 },
}

function make_Ka50_3(rewrite_settings)

local Ka50_3 =  {
	Name 				= "Ka-50_3",
	Shape 				= "Ka-50_3",
	WorldID 			= WSTYPE_PLACEHOLDER,
	DisplayName			= _("Ka-50 III"),
	shape_table_data 	=
	{
		{
			file  	 = "Ka-50_3";
			username = "Ka-50 III";
			index 	 = WSTYPE_PLACEHOLDER;
			life  	 = 15;					-- прочность объекта (методом lifebar*) -- The strength of the object (ie. lifebar *)
			vis   	 = 3;                  -- множитель видимости (для маленьких объектов лучше ставить поменьше). Visibility factor (For a small objects is better to put lower nr).
			desrt 	 = "KA-50-OBLOMOK";	-- Name of destroyed object file name
			fire  	 = { 300, 2};          -- Fire on the ground after destoyed: 300sec 4m
		},
		{
			file  = "KA-50-OBLOMOK";
			fire  = { 0, 1};
		}
	},

	attribute 			= {wsType_Air, wsType_Helicopter, wsType_Battleplane, WSTYPE_PLACEHOLDER, "Attack helicopters"},
	input_profile_entry = "Ka-50 III",
	
	net_animation =
	{
		43,
		44, 	-- spotlight
		208,
		209,
		457,	--[[ExhausScreen]]
	},
	
	main_gear_pos 				= {-0.414, -1.73 - 0.04,	1.31}, 
	nose_gear_pos 				= {4.4,   -1.77 - 0.02, 0}, 
	lead_stock_main				= 0.25,
	lead_stock_support			= 0.223,


	IR_emission_coeff			= 0.6, -- without exhaust screens (they removable here)
	------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	Guns = {
		gun_mount("2A42", 
        {
			count1 = 240, 
			count2 = 220, 
			second_box_offset = {0.909, 0, 0} 
		}, 
        {
			supply_position = {0.305, -0.6, 0.0},
			muzzle_pos_connector = "Gun_point",
			ejector_pos_connector = "Gun_point001",
            ejector_dir = {0.5, -0.5, 0.0},
			effects = 
			{
				{ name = "TurretRecoil", recoil_arg = 350, spring_coeff = 0.3, recoil_coeff = 0.95  },
				{ name = "FireEffect"},
				{ name = "SmokeEffect"},  
				{ name = "ShellsMovement", shells_movement_arg = 349 }
			}
		})
	},
	
	mechanimations = {			
		Door0 = {
			{Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 38, "from", 0.0, "to", 1.0, "in", 1.356}}}}, Flags = {"Reversible"}},
			{Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "from", 1.0, "to", 0.0, "in", 2.927}}}}, Flags = {"Reversible", "StepsBackwards"}},
			{Transition = {"Any", "Bailout"}, Sequence = {
				{C = {{"Origin", "x", 0.7, "y", 2.0, "z", 0.0}, {"Impulse", 1, "tertiary", 10.0}, {"Impulse", 2, "tertiary", 10.0},
					{"DamagePart", "BLADE_1_IN", "to", 1000},
					{"DamagePart", "BLADE_2_IN", "to", 1000},
					{"DamagePart", "BLADE_3_IN", "to", 1000},
					{"DamagePart", "BLADE_4_IN", "to", 1000},
					{"DamagePart", "BLADE_5_IN", "to", 1000},
					{"DamagePart", "BLADE_6_IN", "to", 1000},
					{"Sleep", "for", 0.5}}
				},
				{C = {{"Arg", 25, "to", 1.0, "in", 0.5}, {"Sleep", "for", 0.0}}},
			}},
		},
		WindscreenWiper0 = {
			{Transition = {"Any", "Hang"}, Sequence = {{C = {{"Sleep", "for", 0.0}}}}},
			{Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 13, "to", 0.0, "at", 1.5, "sign", -1}}}}},
			{Transition = {"Any", "CustomStage0"}, Sequence = {{C = {{"Arg", 13, "to", 1.0, "at", 5.0, "sign", 1}}}, {C = {{"Arg", 13, "to", 0.0, "at", 5.0, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
			{Transition = {"Any", "CustomStage1"}, Sequence = {{C = {{"Arg", 13, "to", 1.0, "at", 3.0, "sign", 1}}}, {C = {{"Arg", 13, "to", 0.0, "at", 3.0, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
			{Transition = {"Any", "CustomStage2"}, Sequence = {{C = {{"Arg", 13, "to", 1.0, "at", 1.5, "sign", 1}}}, {C = {{"Arg", 13, "to", 0.0, "at", 1.5, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
		},
		WindscreenWiper1 = {
			{Transition = {"Any", "Hang"}, Sequence = {{C = {{"Sleep", "for", 0.0}}}}},
			{Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 14, "to", 0.0, "at", 1.5, "sign", -1}}}}},
			{Transition = {"Any", "CustomStage1"}, Sequence = {{C = {{"Arg", 14, "to", 1.0, "at", 1.5, "sign", 1}}}, {C = {{"Arg", 14, "to", 0.0, "at", 1.5, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
		},
		HeadLights = {
			{Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 209, "to", 0.00, "speed", 0.14}, {"Arg", 44, "to", 0.00, "speed", 0.14},   {"Arg", 208, "to", 0.00, "speed", 0.14}, {"Arg", 43, "to", 0.00, "speed", 0.14},},},},},
			{Transition = {"Any", "Taxi"},    Sequence = {{C = {{"Arg", 209, "to", 1.00, "speed", 0.14}, {"Arg", 44, "to", 0.0, "speed", 0.14},   {"Arg", 208, "to", 1.00, "speed", 0.14}, {"Arg", 43, "to", 0.0, "speed", 0.14},},},},},
			{Transition = {"Any", "High"},    Sequence = {{C = {{"Arg", 209, "to", 0.73, "speed", 0.14}, {"Arg", 44, "to", 0.0, "speed", 0.14},   {"Arg", 208, "to", 0.73, "speed", 0.14}, {"Arg", 43, "to", 0.0, "speed", 0.14},},},},},
		},
        ServiceHatches = {
            {Transition = {"Close", "Open"}, Sequence = {{C = {{"PosType", 3}, {"Sleep", "for", 1200.0}}}, {C = {{"Arg", 428, "to", 1.0, "speed", 0.6}}}}},
            {Transition = {"Open", "Close"}, Sequence = {{C = {{"PosType", 3}, {"Sleep", "for", 1200.0}}}, {C = {{"Arg", 428, "to", 0.0, "speed", 0.6}}}}},
        },

	   Crewman0GesturesMoveSunglass = {
			{Transition = {"Any", "Retract"}, Sequence = {	{-- pause before rise	
																C = {{"Sleep", "for", 1.0}} 
															},
															{
																C = {{"Arg", 508, "to", 0.0, "speed", 0.50},}
															,}}},
			{Transition = {"Any", "Extend"},  Sequence = {{C = {{"Arg", 508, "to", 1.0, "speed", 0.50},}}}},
		},
		--[[
		Crewman0GesturesNVGActions = {
			{Transition = {"Any", "Dismantle"},  Sequence = {{C = {{"Arg", 509, "set", 0.0},}}}},
			{Transition = {"Any", "Erect"},  	 Sequence = {{C = {{"Arg", 509, "set", 0.5},}}}},
			{Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 506, "to", 0.0, "speed", 0.125},}}}, Flags = {"Reversible"},},
			{Transition = {"Any", "Extend"},  Sequence = {{C = {{"Arg", 506, "to", 0.25, "speed", 0.125},}}}, Flags = {"Reversible"},},
		},
		Crewman0GesturesHMSActions = {
			{Transition = {"Any", "Dismantle"},  Sequence = {{C = {{"Arg", 509, "set", 0.0},}}}},
			{Transition = {"Any", "Erect"},  	 Sequence = {{C = {{"Arg", 509, "set", 0.75},}}}},
			{Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 507, "to", 0.0, "speed", 0.25},}}}, Flags = {"Reversible"},},
			{Transition = {"Any", "Extend"},  Sequence = {{C = {{"Arg", 507, "to", 0.5, "speed", 0.25},}}}, Flags = {"Reversible"},},
		},
		--]]
		Crewman0GesturesNVGActions = {
			{Transition = {"Any", "Dismantle"},  Sequence = {{C = {{"Arg", 509, "set", 0.0},}}, {C = {{"Arg", 506, "to", 0.0, "speed", 0.125}, {"Arg", 507, "to", 0.0, "speed", 0.25},}} }},
			{Transition = {"Any", "Erect"},  	 Sequence = {{C = {{"Arg", 509, "set", 0.5},}}}},
			{Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 506, "to", 0.0, "speed", 0.125}, {"Arg", 507, "to", 0.0, "speed", 0.25},}} }, Flags = {"Reversible"},},
			{Transition = {"Any", "Extend"},  Sequence = {{C = {{"Arg", 506, "to", 0.25, "speed", 0.125}, {"Arg", 507, "to", 0.0, "speed", 0.25},}} }, Flags = {"Reversible"},},
		},
		Crewman0GesturesHMSActions = {
			{Transition = {"Any", "Dismantle"},  Sequence = {{C = {{"Arg", 509, "set", 0.0},}}, {C = {{"Arg", 507, "to", 0.0, "speed", 0.25}, {"Arg", 506, "to", 0.0, "speed", 0.125},}}}},
			{Transition = {"Any", "Erect"},  	 Sequence = {{C = {{"Arg", 509, "set", 0.75},}}}},
			{Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 507, "to", 0.0, "speed", 0.25}, {"Arg", 506, "to", 0.0, "speed", 0.125},}} }, Flags = {"Reversible"},},
			{Transition = {"Any", "Extend"},  Sequence = {{C = {{"Arg", 507, "to", 0.5, "speed", 0.25}, {"Arg", 506, "to", 0.0, "speed", 0.125},}} }, Flags = {"Reversible"},},
		},

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
								typename = "argumentlight",	argument  = 190,
								proto = lamp_prototypes.BANO_7M_red,
							},		-- navigation lights: left red
							{
								typename = "argumentlight",	argument  = 191,
								proto = lamp_prototypes.BANO_7M_green,
								},		-- navigation lights: right green
							{
								typename = "argumentlight",	argument  = 192,
								proto = lamp_prototypes.HS_2A,
							},		-- navigation lights: tail white							
						},
					},
				},
			},
			[WOLALIGHT_SPOTS] = {
				typename = "collection",
				lights = {
					{
						typename = "collection",
						lights = {
							{
								typename = "argumentlight", connector = "MAIN_SPOT_PTR", argument = 46,
								proto = lamp_prototypes.FPP_7,
								movable = true,
							},
						},
					},
				},
			},
			[WOLALIGHT_TAXI_LIGHTS] = {
				typename = "collection",
				lights = {
					{
						typename = "collection",
						lights = {
							{
								typename = "argumentlight", connector = "MAIN_SPOT_PTR", argument = 46,
								proto = lamp_prototypes.FPP_7,
								movable = true,
							},
						},
					},
				},
			},
			[WOLALIGHT_PROJECTORS ] = {			-- secondary spotlight moved here 
				typename = "collection",
				lights = {
					{
						typename = "argumentlight", connector = "RESERV_SPOT_PTR", argument = 45,
						proto = lamp_prototypes.FPP_7,
						movable = true,
					},
				},
			},
			[WOLALIGHT_BEACONS] = {
				typename = "collection",
				lights = {
					{
						typename = "Collection",
						lights = {
							{
								typename = "RotatingBeacon", connector = "RED_BEACON", argument = -1,
								rotary_assembly_argument = 195,
								flood_light_argument = 193,
								proto = lamp_prototypes.MSL_3_2, angular_velocity = math.rad(360.0/1.5),
								range = 0,
							},
						},
					},
				},
			},
			[WOLALIGHT_FORMATION_LIGHTS] = {
				typename = "collection",
				lights = {
					{
						typename = "argumentlight", argument = 200,
					},
				},
			},
			--[WOLALIGHT_TIPS_LIGHTS] = tips_lights_default, -- the prototype from Lights.lua
			[WOLALIGHT_TIPS_LIGHTS] = {
				typename = "collection",
				lights = {
					{typename  = "argumentlight", argument = 47, }}--tips lights 
			}
		},
	}, -- end of lights_data
	
	
	Pylons = {
		pylon(1, 0, 0.848, -0.289, -2.694,
			{
				use_full_connector_position	= true,
				connector					= "HardPoint-9",
				arg 	  					= 308,
				arg_value 					= 0.701,
				DisplayName 				= "1",
			},
			ka_50_outboard_station(true,1),
			2 -- order for sorting columns in ME
		),
		pylon(2, 0, 0.848, -0.33, -1.984,
			{
				use_full_connector_position = true,
				connector 					= "HardPoint-3",
				arg 						= 309,
				DisplayName 				= "2",
			},
			ka_50_inboard_station,
			3 -- order for sorting columns in ME
		),
		pylon(3, 0, 0.848, -0.33,  1.984,
			{
				use_full_connector_position = true,
				connector 					= "HardPoint-4",
				arg 						= 310,
				DisplayName 				= "3",
			},
			ka_50_inboard_station,
			4 -- order for sorting columns in ME
		),
		pylon(4, 0, 0.848, -0.289, 2.694,
			{
				use_full_connector_position = true,
				connector 					= "HardPoint-10",
				arg 	  					= 311,
				arg_value 					= 0.701,
				DisplayName 				= "4",
			},
			ka_50_outboard_station(true,4),
			5 -- order for sorting columns in ME
		),
		pylon(5, 0, 0.85, -0.2587,-3.236,
			{
				arg 						= 312,
				arg_value					= 0.5,
				use_full_connector_position = true,
				connector 					= "HardPoint-1",
				DisplayName 				= _("AAM L"),
				mass						= 25
			},
			ka_50_III_wingtip_station,
			1 -- order for sorting columns in ME
		),
		pylon(6, 0, 0.85, -0.2587, 3.236,
			{
				arg 						= 313,
				arg_value					= 0.5,
				use_full_connector_position = true,
				connector 					= "HardPoint-6",
				DisplayName 				= _("AAM R"),
				mass						= 25
			},
			ka_50_III_wingtip_station,
			6 -- order for sorting columns in ME
		),
	},
	
		Failures =
	{
		{ id = 'hydro_main',  label = _('HYDRO MAIN'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hydro_common',  label = _('HYDRO COMMON'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'l_engine',  label = _('L-ENGINE'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'r_engine',  label = _('R-ENGINE'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'asc_p',  	label = _('ASC PITCH'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'asc_r',  	label = _('ASC ROLL'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'asc_y',  	label = _('ASC YAW'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'asc_a',  	label = _('ASC ALT'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'abris_software',  	label = _('ABRIS SOFTWARE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'abris_hardware',  	label = _('ABRIS HARDWARE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'laser_failure' ,  	label = _('LASER FAILURE'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RADAR_ALT_TOTAL_FAILURE', 	label = _("RALT FAILURE"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'DNS_FAILURE',  label = _('DNS failure'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'IMU_FAILURE',  label = _('INS failure'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
	},

	DamageParts =
 	{
		[1] = "Ka-50_3-wing-R",
		[2] = "Ka-50_3-wing-L",
		[3] = "KA-50-NOSE",
		[4] = "Ka-50_3-tail",
		[5] = "KA-50-BLADE",
	},
	------------------------------------------------------------------------------------------------------------------------------------------------------------------
	AddPropAircraft = {
		{
			id 		= 'modification',
			control = 'comboList',
			label 	= _('Modification'),
			arg 	= 737,
			values  = {
				{id = "Ka-50_3", dispName = _("Version 2022") , value = 1},
				{id = "Ka-50"  , dispName = _("Version 2011") , value = 0},
			},
			wCtrl		= 150,
			defValue	= "Ka-50_3",
			forcedPylons = 
			{
				["Ka-50"] = 
				{
					[5] = "<CLEAN>",
					[6] = "<CLEAN>",
				}
			},
		},
		
		{ id = "Helmet-mounted device",	control = 'comboList', label = _('Helmet-mounted device'),
			values = {
				{id = 0, dispName = _("AUTO")},
				{id = 1, dispName = _("HMS")},
				{id = 2, dispName = _("NVG Ka50")},
			},
			defValue	= 0,
			wCtrl		= 150,
			playerOnly = true
		},
		
		{ id = "ExhaustScreen" , control = 'checkbox', label = _('Exhaust Dispenser'), defValue = true, weight = 160, arg = 457},
		
					-- INS ALIGNMENT	
		{ id = "idPlaceHolder", control = 'label', playerOnly = true,},				
		{ id = "idLabel", control = 'label', label = _('INS ALIGNMENT'), xLbl = 150, playerOnly = true},
		{ id = "Realistic INS",    control = 'comboList', label = _('Realism'),
            values = {
                {id = 0, dispName = _("No alignment and fixtaking needed")	, guiAction = {onSelect = 'disable',	controls = {'IMU alignment type'}}},
                {id = 2, dispName = _("No alignment needed but fixtaking")	, guiAction = {onSelect = 'enable' , 	controls = {'IMU alignment type'}}},
                {id = 1, dispName = _("Fully realistic")					, guiAction = {onSelect = 'enable' , 	controls = {'IMU alignment type'}}},
            },
            defValue    = 1,
            wCtrl        = 150,
            playerOnly = true
        },
		{ id = "IMU alignment type",    control = 'comboList', label = _('At Hot Start'),
            values = {
                {id = 1, dispName = _("Fast")},
                {id = 2, dispName = _("Normal")},
                {id = 3, dispName = _("Normal with Gyro")},
            },
            defValue    = 3,
            wCtrl        = 150,
            playerOnly = true
        },		
	},
	visualIR = { 
		coeffs = {	-- heat collect coef, heat loose coef, texture_coef, texture_base_val
					{0.02, 	0.0001,  1.0, 0.0}, -- engines and equipment
					{ 0.1, 	0.01,  1.0, 0.01}, -- aerodynamic heat - edges for fixed wing, rotors blades for heli
					{0.003, 0.05,  1.0, 0.0}, -- weapon/canon
					{0.01, 	0.0001,  4.0, 0.1}	-- overall hull -> environment
				 }
				},
	------------------------------------------------------------------------------------------------------------------------------------------------------------------
}

if rewrite_settings then
   for i, o in pairs(rewrite_settings) do
		Ka50_3[i] = o
   end
end

make_Ka50(Ka50_3)

end

make_Ka50_3()
