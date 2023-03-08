--/N/ 07 nov. 2018
--/M/ 20180508
--/M/ 20180930
--/M/ 20181024
--/M/ 20190924

-- Setting up model container

mount_vfs_liveries_path(current_mod_path.."/Liveries")
mount_vfs_texture_path (current_mod_path.."/Textures")
mount_vfs_texture_path (current_mod_path.."/Textures/Base")
mount_vfs_texture_path (current_mod_path.."/Textures/Pilot")
mount_vfs_texture_path (current_mod_path.."/Textures/Cockpit")
mount_vfs_texture_path (current_mod_path.."/Textures/Propeller")
mount_vfs_model_path(current_mod_path.."/Shapes")
mount_vfs_texture_path (current_mod_path.."/Textures2") -- For Testing
-- end of Setting up model container


-- Declaring aircraft
Eagle_II =  {

	Name		         = "Christen Eagle II",
	DisplayName		     = _("Christen Eagle II"),
	date_of_introduction = 1977.00,
	country_of_orgin     = "USA",
	
	--HumanCockpit         = true,
	--HumanCockpitPath     = current_mod_path.."/Cockpit/",
	Picture		         = "Christen Eagle II.png",
	Rate			     = -20,                        -- RewardPoint in Multiplayer
	--Shape			     = "Christen Eagle II",--"CE2",
	--XRayShape           = "CE2_X-Ray",
    --propellorShapeType  = "3ARG",
	
	shape_table_data = 
	{
		{
			file		= "CE2",                         -- model and lods
			life		= 12,                            -- The strength of the object (ie. lifebar *)
			vis			= 3,                             -- Visibility factor, multiplier (for a small objects is better to put lower nr).
			desrt		= "Fighter-2-crush", --"self",   -- Name of destroyed object file name
			fire		= {300, 2},                      -- Fire on the ground after destoyed: 300sec 2m
			username	= "Christen Eagle II",
			index		= WSTYPE_PLACEHOLDER,
			classname	= "lLandPlane",
			positioning	= "BYNORMAL",
			drawonmap 	= true,
		},	
	},
	
	mapclasskey		= "P0091000025",  -- ref. MissionEditor/data/NewMap/images/themes/nato/P91000025.png
	--attribute		= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER ,"Aux",}, -- Battleplanes 
	attribute   = {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER,"Battleplanes",},


	Categories		= {},--{"{C168A850-3C0B-436a-95B5-C4A015552560}", "Plane",},	
	
	AddPropAircraft = 
	{
		{
			id = "SoloFlight",
			control = "checkbox",
			label = _("Solo Flight"),
			defValue = false,
			weightWhenOn = -85
		},
--[[	{
            id = "PropellorType",
            control = "comboList",
            label = _("Property.CE2.PropellorType"),
            defValue = 0,
            arg = 1000,
            values = {
                {id = 0, dispName = _("2-Blade V530TA-D35")},
                {id = 1, dispName = _("3-Blade MTV-9")},
            },
            wCtrl = 150,
        },
]]--		
		{
			id = "NetCrewControlPriority", 
			control = "comboList",
			label = _("Aircraft Control Priority"),
			values =
				{
					{id =  0, dispName = _("Pilot")},
					{id =  1, dispName = _("Instructor")},
					{id = -1, dispName = _("Ask Always")},
					{id = -2, dispName = _("Equally Responsible")}
				},
			defValue  = 1,
			wCtrl     = 150
		},
		
		{
			id = "NS430allow",
			control = 'checkbox',
			label = _('NS430 Allow'),
			playerOnly = true,
			defValue = true
		},
	},
-----------------------------------------------------------------------------------------------


	
	--Postoji "buba" u proracunu min mase. Ako se postavi prazan avion sa jednim pilotom, i pozove "refuel" vidi se da je min. masa 648 umesto 563 (563 je ispravno prikazano u ME). Izgleda da simulator ne oduzima tezinu pilota od M_empty.
	
	M_empty								     =	648,                         -- 478 is empty, BUT->	(2 pilots 170 kg! - 2 pilots are accounted in empty mass by default!)
	M_nominal								 =	687,                         -- kg	(2 pilots 170 kg, 39kg fuel)
	M_max									 =	726,                         -- kg	(2 pilots 170 kg, 71kg fuel, 7 kg smoke oil) 
	M_fuel_max							     =	 71,                         -- kg
	
	H_max                                    = 6000,                         -- m
	average_fuel_consumption                 =	  0.01,                      -- kg/s
	CAS_min								     =	 29,--42,                         -- minimal calibrated airspeed*?

	V_opt									 =   67,                         -- Cruise speed (for AI)
	V_take_off								 =   42,--40,                    -- Take off speed in m/s (for AI)
	V_land									 =   44,--32,                    -- approach speed in m/s (for AI)
	V_max_sea_level					         =   93.6,                       -- this is Vne -- Max speed at sea level in m/s (for AI)
	V_max_h								     =   85,                         -- this is max speed in ME, --123.88, -- Max speed at max altitude in m/s (for AI)
	Vy_max									 =   10.8,                       -- Max climb speed in m/s (for AI)
	Mach_max 								 =    0.30,                      -- Max speed in Mach (for AI)	???
	Ny_min									 =   -5.0,                       -- Min G (for AI)
	Ny_max									 =    7.0,                       -- Max G (for AI)
	Ny_max_e								 =    5.0,                       -- ?? Max G (for AI)
	AOA_take_off						     =    0.14,--0.17,               -- AoA in take off radians (for AI)
	bank_angle_max					         =   60,--85,                    -- Max bank angle (for AI)

	has_afteburner						     = false,
	has_speedbrake					         = false,
	has_differential_stabilizer		         = false,
	bigParkingRamp							 = false,
	--flaps_transmission                       = "Pneumatic",
    --undercarriage_transmission               = "Pneumatic",
	
	tand_gear_max						     =    0.577,                     -- postoje 2 standardne i 2 jedinstvene vrednosti u planeconst.lua
	
	nose_gear_pos							 = { -3.566, -0.680, 0.00},      -- nosegear coord, 100% compressed
	nose_gear_amortizer_direct_stroke		 =	  0.043,                    --  + goes up from nose_gear_pos,
	nose_gear_amortizer_reversal_stroke		 =   -0.043,        		     -- 0% compression, + is up
	nose_gear_amortizer_normal_weight_stroke =	  0.00,                    -- 50% compression, + is up from main_gear_pos
	nose_gear_wheel_diameter				 =	  0.153,                     -- in m
	
	main_gear_pos							 = {  0.490, -1.300, 0.859},		 -- main gear coords, 100% compressed
	main_gear_amortizer_direct_stroke		 =    0.087,                     -- + goes up from nose_gear_pos,
	main_gear_amortizer_reversal_stroke		 =   -0.087,		             -- 0% compression, + is up
	main_gear_amortizer_normal_weight_stroke =    0.00,	  		         -- 50% compression, + is up from main_gear_pos
	main_gear_wheel_diameter				 =	  0.337,                     -- in m
	
	--[[
	nose_gear_pos							 = { -3.566, -0.635, 0.00},      -- nosegear coord, 100% compressed
	nose_gear_amortizer_direct_stroke		 =	  0.083,                    --  + goes up from nose_gear_pos,
	nose_gear_amortizer_reversal_stroke		 =   -0.083,        		     -- 0% compression, + is up
	nose_gear_amortizer_normal_weight_stroke =	  0.0415,                    -- 50% compression, + is up from main_gear_pos
	nose_gear_wheel_diameter				 =	  0.153,                     -- in m
	
	main_gear_pos							 = {  0.490, -1.178, 0.859},		 -- main gear coords, 100% compressed
	main_gear_amortizer_direct_stroke		 =    0.174,                     -- + goes up from nose_gear_pos,
	main_gear_amortizer_reversal_stroke		 =   -0.174,		             -- 0% compression, + is up
	main_gear_amortizer_normal_weight_stroke =    0.087,	  		         -- 50% compression, + is up from main_gear_pos
	main_gear_wheel_diameter				 =	  0.337,                     -- in m
	]]
	wing_area								 =   11.61288,                   -- wing area in m2
	wing_span								 =    1.91 * 6.0706,                    -- wing span in m, NOTE: due to double wing, span is multiplied by 1.91 to enable proper MAC calculation
    wing_type       						 =    0, -- 0 = Fixed wing, 1 = Variable geometry, 2 = Foldable wing
   
	thrust_sum_max					         = 2500,                         -- thrust 
    thrust_sum_ab						     = 2500,                         -- thrust 
	length									 =    5.6388,                    --SFM ne radi dobro sa "kratkim" avionima -> ovo je prava vrednost 5.46, -- full lenght in m		**
	height									 =    1.9812,                    -- height in m				**
    flaps_maneuver						     =    0.0,                       -- Max flaps in take-off and maneuver (0.5 = 1st stage, 1.0 = 2nd stage) (for AI)
	range									 =  690,                         -- Max range in km (for AI)
	RCS										 =    1.5,                       -- Radar Cross Section m2
	IR_emission_coeff				         =    0.04,                      -- IR emmision, no aterburner. 1.0 is Su-27.
	IR_emission_coeff_ab 		             =    0.0,                       --  IR emmision, with afterburner.
	--wing_tip_pos 							 = {  0.00, 0.80, 3.00},         -- wingtip coords for visual effects //N/ turned OFF by Mantis request 0000830
    brakeshute_name 						 =    0, -- Landing - brake chute visual shape after separation	
	is_tanker							     =	  false,                     -- Tanker yes/no
	tanker_type							     =    0,                         -- Tanker type if the plane is tanker
	air_refuel_receptacle_pos	             = {  0, 0, 0},                  -- refuel coords
	

	engines_count						     =    1,                         -- Engines count
	engines_nozzles = 
	{
		[1] = 
		{
			pos								 = {0.60, -0.80, 0.00},        -- nozzle coords
			elevation						 =  0.00,                      -- AFB cone elevation
			diameter						 =  0.10,                      -- AFB cone diameter
			exhaust_length_ab		         =	1.00,                      -- lenght in m
			exhaust_length_ab_K        	     =	0.76,                      -- AB animation
			smokiness_level			         =	0.01,
		}, 
	},
	
	crew_members = 
	{
		[1] = 
		{
			drop_canopy_name	 = "CE2_Canopy",
			ejection_seat_name	 = 0,
			pilot_name		     = "CE2_Pilot_01",
			drop_parachute_name =  "CE2_Pilot_01_Parachute",
			--pos					 = {-1.50, -0.20, 0.00}, --Ilona"s {-1.50, -0.20, 0.08},  --{-1.10, -0.08, 0.00},  --fabricki podatak
			pos					 = {-1.10, -0.08, 0.00},  --fabricki podatak
			can_be_playable  	 = true,
			canopy_arg           = 38, 
			pilot_body_arg		 = 50,
			ejection_order 		 =  2,
			canopy_pos			 = { 1.61, 1.18, 0.00},
			--canopy_ejection_dir	 = {-1.00, 0.20, 0.00},
ejection_added_speed = {-1, 3, -3},--{-5, 15, 0},
			role 				 = "instructor",
			role_display_name    = _("Instructor Pilot"),		
		},
		
		[2] = 
		{
			drop_canopy_name	 = "CE2_Canopy",
			ejection_seat_name	 = 0,                     --"pilot_l39_seat",
			pilot_name		     = "CE2_Pilot_02",
			drop_parachute_name =  "CE2_Pilot_02_Parachute",
			--pos					 = {-0.56, -0.28, 0.00}, --Ilona"s {-0.56, -0.28, 0.20},   --{-0.27, -0.1, 0.00}, -- korig. vrednost za bolju stabilnost dvoseda --{-0.287, -0.1, 0.00}, fabricki podatak
			pos					 = {-0.27, -0.1, 0.00}, -- korig. vrednost za bolju stabilnost dvoseda --{-0.287, -0.1, 0.00}, fabricki podatak
			can_be_playable 	 = true,
			canopy_arg           = 38,
			pilot_body_arg		 = 472,
			ejection_order 		 =  1,
			canopy_pos			 = { 1.61, 1.18, 0.00},
			canopy_ejection_dir	 = {-1.00, 0.20, 0.00},
ejection_added_speed = {-1, 3, -3},--{-5,15,0},
			role 				 = "pilot",
			role_display_name    = _("Pilot"),		
		},
	},
	
	fires_pos = -- depreciate with X-Ray
	{
			[1] = { 0.500, -0.30,  0.000},      -- Fuselage
			--[2] =	{-1.114, -0.29,	 0.901},	-- Wing inner Right
			--[3] =	{-1.268, -0.29,	-1.162},	-- Wing inner Left
			--[4] =	{ 0.215, -0.26,	 1.195},	-- Wing middle Right
			--[5] =	{-1.582, -0.26,	-1.687},	-- Wing middle Left
			--[6] = {-0.800, -0.26,	 2.200},	-- Wing outer Right
			--[7] = {-1.000, -0.29,	-0.806},	-- Wing outer Left
			[2] = {-0.500, -0.30,	 0.000},	-- Engine (inner Right)
			--[9] =	{ 0.000, -0.30,	 0.000},	-- Engine (inner Left)
	},


	--[[
	passivCounterm =
	{
	    CMDS_Incrementation = 0,
		ChaffDefault        = 0,
		ChaffChargeSize     = 0,
		FlareDefault        = 0,
		FlareChargeSize     = 0,
	
		CMDS_Edit		  = false,
		SingleChargeTotal = 0,
		chaff			  = {default = 0, increment = 0, chargeSz = 0},
		flare			  = {default = 0, increment = 0, chargeSz = 0},
	},
	]]
	
    -- Countermeasures
	--[[
    SingleChargeTotal   = 0,
    CMDS_Incrementation = 0,
    ChaffDefault        = 0,
    ChaffChargeSize     = 0,
    FlareDefault        = 0,
    FlareChargeSize     = 0,
    CMDS_Edit           = false,
	]]
	



	-- Add model draw args for network transmitting to this draw_args table (16 limit)
	net_animation = 
	{
	600, 601, -- aerobatic sight gauge
	--337, 359, -- pilot front
	-- 39,  99, -- pilot rear
	407, 413, -- prop rotation and pitch
	950,      -- wheel covers
	 38,	  -- canopy
	},
	

	
	
    -- Sensors
	detection_range_max	 = 0,
	radar_can_see_ground = false,
	CanopyGeometry		 = makeAirplaneCanopyGeometry(LOOK_GOOD, LOOK_GOOD, LOOK_GOOD),
	
Sensors = {
			--OPTIC = "Merkury LLTV", -- For night goggles imitation
		  },

	HumanRadio = 	
	{
		frequency	   = 305.0,
		editable	   = true,
		minFrequency   = 118.000,
		maxFrequency   = 390.000,
        rangeFrequency = 
		{
			{min = 118.0, max = 140.0},
            {min = 220.0, max = 390.0}
        },
		modulation	   = MODULATION_AM,
	},
	
	panelRadio =
	{
        [1] =
		{  
			--ID           = "KY-196A",
            name         = _("KY 197A"), -- change to KY-196A
			--displayUnits = "kHz",
            range =
			{	
				{min = 118.0, max = 140.0},
				{min = 220.0, max = 390.0}
			},
            channels =
			{
                [1] = { name = _("Channel 0"),		default = 305.0, modulation = _("AM"), connect = true}, -- default
                [2] = { name = _("Channel 1"),		default = 264.0, modulation = _("AM")},	-- min. water : 135.0, 264.0
                [3] = { name = _("Channel 2"),		default = 265.0, modulation = _("AM")},	-- nalchik : 136.0, 265.0
                [4] = { name = _("Channel 3"),		default = 256.0, modulation = _("AM")},	-- sochi : 127.0, 256.0
                [5] = { name = _("Channel 4"),		default = 254.0, modulation = _("AM")},	-- maykop : 125.0, 254.0
                [6] = { name = _("Channel 5"),		default = 250.0, modulation = _("AM")},	-- anapa : 121.0, 250.0
                [7] = { name = _("Channel 6"),		default = 270.0, modulation = _("AM")},	-- beslan : 141.0, 270.0
                [8] = { name = _("Channel 7"),		default = 257.0, modulation = _("AM")},	-- krasnodar-pashk. : 128.0, 257.0
                [9] = { name = _("Channel 8"),		default = 255.0, modulation = _("AM")},	-- gelenjik : 126.0, 255.0
                [10] = { name = _("Channel 9"),		default = 262.0, modulation = _("AM")},	-- kobuleti : 133.0, 262.0
                [11] = { name = _("Channel 10"),	default = 259.0, modulation = _("AM")},	-- gudauta : 130.0, 259.0
                [12] = { name = _("Channel 11"),	default = 268.0, modulation = _("AM")},	-- soginlug : 139.0, 268.0
                [13] = { name = _("Channel 12"),	default = 269.0, modulation = _("AM")},	-- vaziani : 140.0, 269.0
                [14] = { name = _("Channel 13"),	default = 260.0, modulation = _("AM")},	-- batumi : 131.0, 260.0
                [15] = { name = _("Channel 14"),	default = 263.0, modulation = _("AM")},	-- kutaisi : 134.0, 263.0
                [16] = { name = _("Channel 15"),	default = 261.0, modulation = _("AM")},	-- senaki : 132.0, 261.0
                [17] = { name = _("Channel 16"),	default = 267.0, modulation = _("AM")},	-- lochini : 138.0, 267.0
                [18] = { name = _("Channel 17"),	default = 251.0, modulation = _("AM")},	-- krasnodar-center : 122.0, 251.0
                [19] = { name = _("Channel 18"),	default = 253.0, modulation = _("AM")},	-- krymsk : 124.0, 253.0
                [20] = { name = _("Channel 19"),	default = 266.0, modulation = _("AM")}, -- mozdok : 137.0, 266.0
            }
        },
    },

	-- Guns
    Guns = nil,


	Pylons =
	{
		pylon(
			1, -- pylon index
			0, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
			0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
			0, -- ???
			0, -- ???
--[[
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
]]--
			{
				FiX = 0,
				FiY = 0,
				FiZ = 30,
				use_full_connector_position = false,
			},
			{
				{ CLSID = "{CE2_SMOKE_WHITE}",     connector = "", arg = 400, arg_value = 1.0 },
				--[[
				{ CLSID = "{CE2_SMOKE_GRAY}",      connector = "", arg = 400, arg_value = 1.0 },
				{ CLSID = "{CE2_SMOKE_SILVER}",    connector = "", arg = 400, arg_value = 1.0 },
				{ CLSID = "{CE2_SMOKE_CRIMSON}",   connector = "", arg = 400, arg_value = 1.0 },
				{ CLSID = "{CE2_SMOKE_STEELBLUE}", connector = "", arg = 400, arg_value = 1.0 },
				{ CLSID = "{CE2_SMOKE_SEAGREEN}",  connector = "", arg = 400, arg_value = 1.0 },
				]]
				
			}	
		
		),
	
    },
	
	Tasks =
	{
		--aircraft_task(Nothing),			-- 15 --/N/ NOTE: if this is ENABLED, it will cause a bug of "CE II duplicates in Mission Editor", ED mantis bug 46355, 30. July 2019.
        aircraft_task(Transport),		-- 35,
        aircraft_task(Reconnaissance),	-- 17,			
        --aircraft_task(AFAC),
    },	
	DefaultTask = aircraft_task(Nothing),



	SFM_Data = 
	{ -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
		aerodynamics = 
		{
			Cy0				=  0.12,   -- zero AoA lift coefficient
			Mzalfa			=  3.5,    -- coefficients for pitch agility
			Mzalfadt		=  0.5,    -- coefficients for pitch agility
			kjx				=  3.00,   --2.50,        -- koeficijent sile po nagibu (na X osi), sto vise - to brze valjanje i zaustavljanje
			kjz				=  0.0018, --0.0025,    -- koeficijent sile po naklonu (na Z osi), sto vise - to brzi naklon i zaustavljanje
			Czbe			= -0.02,               -- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system

            -- M      -- Mach number
            -- Cx0    -- Coefficient, drag, profile, of the airplane
            -- Cya    -- Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. Inversely proportional to the available G-loading at any Mach value. (lower the Cya value, higher G available) per 1 degree AOA
            -- B      -- Polar quad coeff
            -- B4     -- Polar 4th power coeff
            -- Omxmax -- roll rate, rad/s
            -- Aldop  -- Alfadop Max AOA at current M - departure threshold
            -- Cymax  -- Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)
 
			
			-- ED bug: avion ne moze da sleti ako su naredne vrednosti suvise male (ili 0)
			cx_gear = 0.0277, -- coefficient, drag, gear
			cx_flap = 0.095,  -- coefficient, drag, full flaps
			cy_flap = 0.11,   -- coefficient, normal force, lift, flaps
			cx_brk  = 0.06,   -- coefficient, drag, breaks
			
			table_data =
				{
					--      M		Cx0		 	Cya			 B		 	B4	      Omxmax		Aldop		Cymax
					{	0.000	,	0.020	,	0.0900	,	0.046	,	0.0120	,	0.120	,	15.000	,	1.350	,	}	,
					{	0.025	,	0.020	,	0.0881	,	0.048	,	0.0125	,	0.423	,	15.000	,	1.322	,	}	,
					{	0.050	,	0.020	,	0.0863	,	0.050	,	0.0130	,	0.726	,	15.000	,	1.294	,	}	,
					{	0.075	,	0.020	,	0.0844	,	0.051	,	0.0135	,	1.029	,	15.000	,	1.267	,	}	,
					{	0.100	,	0.020	,	0.0826	,	0.052	,	0.0140	,	1.332	,	15.000	,	1.239	,	}	,
					{	0.125	,	0.020	,	0.0807	,	0.053	,	0.0145	,	1.635	,	15.000	,	1.211	,	}	,
					{	0.150	,	0.020	,	0.0789	,	0.054	,	0.0150	,	1.938	,	15.000	,	1.183	,	}	,
					{	0.175	,	0.020	,	0.0770	,	0.055	,	0.0155	,	2.241	,	15.000	,	1.155	,	}	,
					{	0.200	,	0.020	,	0.0752	,	0.056	,	0.0160	,	2.544	,	15.000	,	1.128	,	}	,
					{	0.225	,	0.020	,	0.0733	,	0.057	,	0.0165	,	2.847	,	15.000	,	1.100	,	}	,
					{	0.250	,	0.020	,	0.0715	,	0.057	,	0.0170	,	3.150	,	15.000	,	1.072	,	}	,
					{	0.275	,	0.020	,	0.0697	,	0.057	,	0.0175	,	3.071	,	15.000	,	1.045	,	}	,
					{	0.300	,	0.020	,	0.0679	,	0.057	,	0.0180	,	2.994	,	15.000	,	1.018	,	}	,
					{	0.400	,	0.020	,	0.0607	,	0.057	,	0.0185	,	2.920	,	15.000	,	0.911	,	}	,
				},
		},
		
		engine = 
		{
			Nominal_RPM      =     2700,
			Nmg				 =	     25.0,--67.5,
			MinRUD			 =	     0.223,
			MaxRUD			 =	     1.0,
			MaksRUD			 =	     1.0,--0.925,
			ForsRUD			 =	     1.0,
			--type    = "Radial",
            cylinder_firing_order = {1, 3, 2, 4},
			typeng			 =	     2,	      --PISTON ENGINE
			
			hMaxEng			 =	     7.0,--12.5,
			dcx_eng			 =	     0.0015, --0.0015,
			cemax			 =	     0.5,--1.5,--0.37,
			cefor			 =	     0.5,--1.5,--0.37,
			dpdh_m			 =	  1800,
			dpdh_f			 =	  1800,
			k_adiab_1		 =	     0.037923,
			k_adiab_2		 =	     0.0562,
			MAX_Manifold_P_1 =	101325,--155774,	
			MAX_Manifold_P_2 =	101325,--206570,
			MAX_Manifold_P_3 =	101325,--226648,
			k_after_cool	 =	     0.54,
			Displ			 =	     5.916,                 -- ok
			k_Eps			 =	     6,--1.72,--6,          -- veliki uticaj na vucnu silu, sto manje to jaca sila
			Stroke			 =	     0.111, -- ok
			V_pist_0		 =	     8.8,--10.0,--12,
			Nu_0			 =	     1.2,
			Nu_1			 =	     0.9,
			Nu_2			 =	     0.001,
			N_indic_0		 = 1600000,--1023040,           -- veliki uticaj na vucnu silu, sto vece to jaca
			N_fr_0			 =	     0.072,
			N_fr_1			 =	     0.02,
			Init_Mom		 =	    20,                     -- guess /was 220/
			D_prop			 =	     1.88,                  -- ok
			MOI_prop		 =	    10.5, --7.76            prop weight 50-55 pounds -- ok
			k_gearbox		 =	     1.0,                   -- ok 
			P_oil			 =	495438,
			k_boost			 =       1,                     -- was 3
			k_cfug			 =       0.003,
			k_oil			 =       0.00004,
			k_piston		 =    3000,
			k_reg			 =       0.003,
			k_vel			 =       0.017,
			
			--M    -- Mach number
            --Pmax -- Engine thrust at military power
            --Pfor -- Engine thrust at AFB
			
			table_data = 
			{
			--   M		Pmax
				{0.00,	2500.0},--4000.0
				{0.03,	2450.0},
				{0.06,	2400.0},
				{0.09,	2350.0},
				{0.12,	2300.0},
				{0.15,	2250.0},
				{0.18,	2200.0},
				{0.21,	2150.0},-- 153 mph
				{0.24,	2100.0},
				{0.27,	2050.0},
				{0.30,	2000.0},-- 230 mph
				{0.40,	1840.0},
				
			},
		},
	},
	


	-- Damage
	dofile(current_mod_path.."/Eagle_II_Damage.lua"),
	
	Damage = verbose_to_dmg_properties(Eagle2_Damage),	
	DamageParts = Eagle2_DamageParts,



	Failures = 
	{
		{ id = "ELECTRIC_FAILURE", label = _("Electric"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 0
		{ id = "ENGINE_FAILURE",   label = _("Engine"),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 1
		{ id = "RADIO_FAILURE",	   label = _("Radio"),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 2
		{ id = "LIGHTS_FAILURE",   label = _("Lights"),	    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 3
		{ id = "PITOT_FAILURE",	   label = _("Pitot Tube"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 4
	},

	lights_data =
	{
		typename = "collection",
		lights 	 = 
		{
			
			[1]	= -- ACL
			{
				typename = "collection",
				lights   = 
				{	
					{
						typename    = "argnatostrobelight", 
						argument    = 194, 
						period      = 1.333, 
						phase_shift = 0.5, 
						--connector   = "ACL", 
						--color       = {1.0, 0.0, 0.0},
					},	
				},
			},
			
			[2] = -- Landing Light
			{
				typename = "collection",
				lights 	 = 
				{
					{
						typename  = "argumentlight",
						argument  = 208,
					},
				},
			},
			
			[3] = -- NAV Lights
			{
				typename = "collection",
				lights 	 = 
				{
					[1] =
					{
						typename  = "argumentlight", 
						argument  = 190,
					},				-- red
					[2] =
					{
						typename  = "argumentlight", 
						argument  = 191,
					},				-- green
					[3] =
					{
						typename  = "argumentlight", 
						argument  = 192,
					},				-- white
				},
			},
			
			[4] = 
			{
				typename = "collection",
				lights 	 = 
				{
				},
			},
			
			[5] = 
			{
				typename = "collection",
				lights 	 = 
				{
				},
			},
			
			[6] = -- Pit, Outside Effect
			{
				typename = "collection",
				lights   = 
				{ 
					[1] = 
					{
						typename  = "omnilight",
						argument  = 68,
						position  = {-0.6, 0.0, 0.0},
						--connector = "AI_PIT",
						color     =	{1.0, 0.0, 0.0},

					},			
				},
			},		
		},
	},
	
	
	--ViewSettings = ViewSettings,
	--SnapViews    = SnapViews,
}

add_aircraft(Eagle_II)