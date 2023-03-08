
function symmetric(clsid,opposite_station,arg_value,attach_point_offset)
	return  {
		CLSID     = clsid,	
		arg_value = arg_value or 0.1,
		required  = {{station = opposite_station,loadout = {clsid}}},
		attach_point_position = attach_point_offset,
	}
end

local smokes = {
				"{D3F65166-1AB8-490f-AF2F-2FB6E22568B1}",--Smoke Generator - red
				"{D3F65166-1AB8-490f-AF2F-2FB6E22568B2}",--Smoke Generator - green
				"{D3F65166-1AB8-490f-AF2F-2FB6E22568B3}",--Smoke Generator - blue
				"{D3F65166-1AB8-490f-AF2F-2FB6E22568B4}",--Smoke Generator - white
				"{D3F65166-1AB8-490f-AF2F-2FB6E22568B5}",--Smoke Generator - yellow
				"{D3F65166-1AB8-490f-AF2F-2FB6E22568B6}" --Smoke Generator - orange
}

local smokes_without_mass = {
				"{INV-SMOKE-RED}"	,--Smoke Generator - red
				"{INV-SMOKE-GREEN}"	,--Smoke Generator - green
				"{INV-SMOKE-BLUE}"	,--Smoke Generator - blue
				"{INV-SMOKE-WHITE}"	,--Smoke Generator - white
				"{INV-SMOKE-YELLOW}",--Smoke Generator - yellow
				"{INV-SMOKE-ORANGE}" --Smoke Generator - orange
}

function add_smokes(loadout_table,opposite_station,src)
	local out = loadout_table or {}
	local smk = src or smokes
	for i,o in ipairs(smk) do
		local t = { CLSID = o , arg_value = 0.1}
		if  opposite_station ~= nil then
			t.required = {{station = opposite_station,loadout = smk}}
		end
		out[#out + 1] = t
	end
	return out
end

P_50T = {
	category  = CAT_BOMBS,
	name      = "P-50T",
	model     = "p-50t",
	user_name = _("P-50T - 50kg Practice Bomb LD"),
	wsTypeOfWeapon = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme    = "bomb-smoke",
	type      = 0,
	mass      = 50.0,
	hMin      = 200.0,
	hMax      = 12000.0,
	Cx        = 0.00035,
	VyHold    = -100.0,
	Ag        = -1.23,
	Reflection = 0.01,
	fm = {
		mass        = 50,  -- empty weight with warhead, wo fuel, kg
		caliber     = 0.203,  -- Caliber, meters 
		cx_coeff    = {1, 0.39, 0.38, 0.236, 1.31}, -- Cx
		L           = 1.040, -- Length, meters 
		I           = 4.507, -- kgm2 - moment of inertia  I = 1/12 ML2
		Ma          = 0.667,  -- dependence moment coefficient of  by  AoA angular acceleration  T / I
		Mw          = 1.094, --  rad/s  - 57.3°/s - dependence moment coefficient by angular velocity (|V|*sin(?))/|r| -  Mw  =  Ma * t     
		wind_sigma  = 10, -- dispersion coefficient
		cx_factor   = 100,
	},
	warhead = {
			--smoke itself
			transparency		 = 0.5,
			color 				 = {0.95, 0.89, 0.99}, -- White colour RGB
			intensity 			 = 5,
			duration 			 = 60,
			flare				 = true,
			-- junk to avoid exception in warhead scheme loading
			mass 				 = 0.01,
			expl_mass       	 = 0.01,
			piercing_mass   	 = 0,
			caliber				 = 0.203,
			other_factors 		 = {1, 1, 1},
			obj_factors 		 = {1, 1},
			concrete_factors 	 = {1, 1, 1},
			cumulative_factor 	 = 0,
			concrete_obj_factor  = 0,
			cumulative_thickness = 0,
	},
	shape_table_data = {
		{
			name     = "P-50T",
			file     = "p-50t",
			life     = 1,
			fire     = {0, 1},
			username = "P-50T",
			index    = WSTYPE_PLACEHOLDER,
		},
	},
	targeting_data = {
		char_time = 20.87, -- characteristic time for sights 
	},
}
declare_weapon(P_50T)


declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{P-50T}",
	attribute		= P_50T.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= P_50T.Cx,
	Picture			= "P-50T.png",
	displayName		= P_50T.user_name,
	Weight			= P_50T.mass,
	Elements  		= {{ShapeName = "p-50t"}},
})

declare_loadout({
	category		 = CAT_FUEL_TANKS,
	CLSID			 = "{PTB_150L_L39}",
	attribute		 =  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
	Picture			 = "PTB.png",
	displayName		 = _("Fuel Tank 150 liters"),
	Weight_Empty	 = 8,
	Weight			 = 8 +  0.775 * 150,
	Cx_pil			 = 0.002,
	shape_table_data = 
	{
		{
			name 	= "FuelTank_150L",
			file	= "FuelTank_150L";
			life	= 1;
			fire	= { 0, 1};
			username	= "FuelTank 150L";
			index	= WSTYPE_PLACEHOLDER;
		},
	},
	Elements	= 
	{
		{
			ShapeName	= "FuelTank_150L",
		}, 
	}, 
})


declare_loadout({
	category		 = CAT_FUEL_TANKS,
	CLSID			 = "{PTB_350L_L39}",
	attribute		 =  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
	Picture			 = "PTB.png",
	displayName		 = _("Fuel Tank 350 liters"),
	Weight_Empty	 = 12,
	Weight			 = 12 +  0.775 * 350,
	Cx_pil			 = 0.002,
	shape_table_data = 
	{
		{
			name 	= "FuelTank_350L",
			file	= "FuelTank_350L";
			life	= 1;
			fire	= { 0, 1};
			username	= "FuelTank 350L";
			index	= WSTYPE_PLACEHOLDER;
		},
	},
	Elements	= 
	{
		{
			ShapeName	= "FuelTank_350L",
		}, 
	}, 
})


function central_smoke_slot(station)
	return  pylon(station, 2, -5.0, 0.5, 0, {connector = "disable", DisplayName = _("SMK")},add_smokes(nil,nil,smokes_without_mass))
end


local function default_loadout_variants(station,opposite_station)
	local ret_val = { symmetric		 ("{FB3CE165-BF07-4979-887C-92B87F13276B}",opposite_station,0.3),-- FAB-100
					  symmetric		 ("{0511E528-EA28-4caf-A212-00D1408DF10A}",opposite_station,0.3,{0, 0.05, 0}),-- SAB-100
					  symmetric		 ("{UB-16-57UMP}"						  ,opposite_station),
					  symmetric		 ("{P-50T}"								  ,opposite_station,0.2),-- P-50T
					  symmetric		 ("{PTB_150L_L39}"						  ,opposite_station),-- 150 L drop tank
					  symmetric		 ("{R-3S}"								  ,opposite_station)
	}
	add_smokes(ret_val,opposite_station)
	return ret_val	
end

function make_albatros(rewrite_settings)  

local rewrite_settings  = rewrite_settings or {Shape = 'L-39_C' , Name = 'L-39C' , WorldID = WSTYPE_PLACEHOLDER}
local base_L_39 = {
	Picture				=	"L-39C.png",	
	shape_table_data 	= 
	{
		{
			file  	    = rewrite_settings.Shape   or 'L-39_C';
			username    = rewrite_settings.Name    or 'L-39C';
			index       = rewrite_settings.WorldID or WSTYPE_PLACEHOLDER;
			life  	    = 15; -- прочность объекта (методом lifebar*) -- The strength of the object (ie. lifebar *)
			vis   	    = 3; -- множитель видимости (для маленьких объектов лучше ставить поменьше). Visibility factor (For a small objects is better to put lower nr).
			desrt       = 'Fighter-2-crush',-- Name of destroyed object file name
			fire  	    = { 300, 4}; -- Fire on the ground after destoyed: 300sec 4m
			classname   = "lLandPlane";
			positioning = "BYNORMAL";
		},
	},
	DisplayName									=	_("L-39C"),
	mapclasskey									=	"P0091000025",
	WorldID										=    WSTYPE_PLACEHOLDER,
	attribute 									= 	{1,	1,	6,WSTYPE_PLACEHOLDER,
													"Battleplanes",
													"All",
													"NonAndLightArmoredUnits",
													"NonArmoredUnits",
													"Air",
													"Planes",
													"Battle airplanes"},
	Rate										=	50,

	country_of_origin = "RUS",

	AOA_take_off								=	0.23,
	CAS_min										=	56,
	CanopyGeometry 								= 	{-0.34202014332567,	-0.64085638205579,	-0.93969262078591,	-0.036833608500735,	0.86602540378444},
	Categories 									= 	{},
	main_gear_amortizer_direct_stroke			=	0,
	main_gear_amortizer_normal_weight_stroke	=	-0.05,
	main_gear_amortizer_reversal_stroke			=	-0.153,
	main_gear_pos 								= 	{-0.27,	-1.527,	1.211},
	main_gear_wheel_diameter					=	0.6,
	nose_gear_amortizer_direct_stroke			=	0,
	nose_gear_amortizer_normal_weight_stroke	=	-0.07,
	nose_gear_amortizer_reversal_stroke			=	-0.272,
	nose_gear_pos 								= 	{4.181,	-1.51,	0},
	nose_gear_wheel_diameter					=	0.428,
	radar_can_see_ground						=	false,
	range										=	1015,
	tand_gear_max								=	0.577,
	thrust_sum_ab								=	8224,
	thrust_sum_max								=	8224,
	wing_area									=	18.8,
	wing_span									=	9.12,
	wing_tip_pos 								= 	{-1.1,	0,	4.5},
	IR_emission_coeff							=	0.2,
	IR_emission_coeff_ab						=	0,
	M_empty										=	3478, 
	M_fuel_max									=	980,
	M_max										=	4700,
	M_nominal									=	4300,
	Mach_max									=	0.8,
	MaxFuelWeight								=	980,
	MaxHeight									=	12000,
	MaxSpeed									=	761,
	MaxTakeOffWeight							=	4700,
	Ny_max										=	8,
	Ny_max_e									=	8,
	Ny_min										=	-3,
	RCS											=	2.5,
	defFuelRatio								=	0.84, -- топливо по умолчанию в долях от полного
	H_max										=	11000,
	V_land										=	50,
	V_max_h										=	212,
	V_max_sea_level								=	250,
	V_opt										=	125,
	V_take_off									=	53,
	Vy_max										=	22,
	WingSpan									=	9.46,
	average_fuel_consumption					=	0.302,
	bank_angle_max								=	60,
	bigParkingRamp								=	false,
	brakeshute_name								=	0,
	detection_range_max							=	0,
	engines_count								=	1,
	flaps_maneuver								=	0.5,
	has_afteburner								=	false,
	has_differential_stabilizer					=	false,
	has_speedbrake								=	true,
    flaps_transmission                          =   "Hydraulic",
    undercarriage_transmission                  =   "Hydraulic",
	height										=	4.77,
	length										=	12.13,
	crew_members = 
	{
		[1] = 
		{
			drop_canopy_name	 = "L-39_C_fonar_1",
			ejection_seat_name	 = "pilot_l39_seat",
			pilot_name		     = "pilot_l39",
			pos 				 = {3.266,	0.329,	0},
			can_be_playable 	 = true,
			canopy_arg           = 38, 
			ejection_order 		 = 1,
			canopy_pos			 = {2.916,0.798,0},
			ejection_added_speed = {-5,15,0},
			role 				 = "pilot",
			role_display_name    = _("Pilot"),
			drop_parachute_name	 = "pilot_l39_parachute",
		},-- end of [1]
		[2] = 
		{
			drop_canopy_name	= "L-39_C_fonar_2",
			ejection_seat_name	= "pilot_l39_seat",
			pilot_name		    = "pilot_l39",
			pos 				= {1.765,	0.549,	0},
			can_be_playable 	= true,
			canopy_arg          = 421, 
			pilot_body_arg		= 472,
			ejection_order 		= 2,
			canopy_pos			=  {1.563,0.895,0},
			ejection_added_speed = {-5,15,0},
			role 				 = "instructor",
			role_display_name    = _("Instructor pilot"),
			drop_parachute_name	 = "pilot_l39_parachute",
		},-- end of [2]
	},-- end of crew_members
    mechanimations = {
        Door0 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"VelType", 0}, {"Arg", 38, "to", 0.9, "in", 2.87}}}}, Flags = {"Reversible"}},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"VelType", 1}, {"Arg", 38, "to", 0.0, "in", 3.344}}}}, Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Open", "Bailout"},Sequence = {{C = {{"Sleep", "for", 0.0}}}}},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"JettisonCanopy", 0}}}}},
        },
        Door1 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"PosType", 9}, {"Sleep", "for", 3.0}}}, {C = {{"VelType", 1}, {"Arg", 421, "to", 0.9, "in", 2.87}}},  {C = {{"Sleep", "for", 0.0}}}}, Flags = {"Reversible"}},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"Sleep", "for", 0.0}}},                 {C = {{"VelType", 2}, {"Arg", 421, "to", 0.0, "in", 3.344}}}, {C = {{"PosType", 9}, {"Sleep", "for", 3.0}}}}, Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Open", "Bailout"},Sequence = {{C = {{"Sleep", "for", 0.0}}}}},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"JettisonCanopy", 1}}}}},
        },
    },

	-- add model draw args for network transmitting to this draw_args table (16 limit)
	net_animation = 
	{
	470, --[[emergency generator]]
	471, --[[emergency spinning]]
	473, --[[Hood]]
	},
	
	Pylons =	{
	    pylon(1, 0, 0.184040, -0.359076, -2.557844, {arg = 308,arg_value = 0,connector = "Pylon_1",DisplayName = "1"},default_loadout_variants(1,3)),
		central_smoke_slot(2),
	    pylon(3, 0, 0.184040, -0.359076,  2.557844, {arg = 309,arg_value = 0,connector = "Pylon_2",DisplayName = "2"},default_loadout_variants(3,1)),
	},
	
	DefaultTask =   aircraft_task(CAS),
	Tasks 		= 
	{
        aircraft_task(GroundAttack),
        aircraft_task(RunwayAttack),
        aircraft_task(CAS),
        aircraft_task(AFAC),
		aircraft_task(CAP),
		aircraft_task(AntishipStrike),
	},-- end of Tasks
	
	
	Failures = {
		-- engine
		{ id = 'ef_shutdown',					label = _('Engine SHUTDOWN'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ef_fire',						label = _('Engine FIRE'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ef_vibration',					label = _('Engine VIBRATION'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ef_surge',						label = _('Engine SURGE'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },  
		{ id = 'ef_rt12',						label = _('Engine RT-12 FAILURE'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ef_fuel_reg',					label = _('Engine fuel governor FAILURE'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

		-- electric system
		{ id = 'ELEC_GENERATOR_FAILURE',			label = _('Generator FAILURE'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ELEC_EMERGENCY_GENERATOR_FAILURE',			label = _('Emergency Generator FAILURE'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ELEC_STARTER_FAILURE',				label = _('Starter FAILURE'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ELEC_BATTERY_DESTROYED',				label = _('Battery FAILURE'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'es_damage_Inverter36x3',		label = _('Inverter 3x36V FAILURE'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'es_damage_InverterPT500C',		label = _('Inverter PT-500 FAILURE'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'es_damage_Inverter115_1',		label = _('Inverter 115V I FAILURE'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'es_damage_Inverter115_2',		label = _('Inverter 115V II FAILURE'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- fuel system
		{ id = 'FUEL_BOOSTER_FUEL_PUMP_0_FAILURE',		label = _('Fuel Booster Pump FAILURE'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- hydraulic system
		{ id = 'HYDR_PUMP_FAILURE',			label = _('Main Hydraulic Pump FAILURE'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hs_damage_MainAccumulator',		label = _('Main Hydraulic Accumulator FAILURE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hs_damage_AuxAccumulator',		label = _('Auxiliary Accumulator FAILURE'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- oil system
		{ id = 'ENG0_OIL_PUMP_FAILURE',			label = _('Oil Pump FAILURE'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- oxygen system
		{ id = 'OXYN_PRIMARY_CONTAINER_MINOR_LEAK',		label = _('Oxygen FAILURE'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- air system
		{ id = 'PNEM_MAIN_HOSE_PERFORATED',	label = _('Depressurization'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- Instruments
		{ id = 'GMC1AE_GYRO_FAILURE',			label = _('GMC-1AE gyro FAILURE'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'AGD1_GYRO_TOTAL_FAILURE',		label = _('AGD-1 gyro FAILURE'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ssf_full_pressure_fail',		label = _('fwd cockpit full p manometer FAILURE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ssf_static_pressure_fail',		label = _('fwd cockpit static p manometer FAILURE'),enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- RKL-41
		{ id = 'RKL_41_TOTAL_FAILURE',			label = _('RKL-41 Total FAILURE'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RKL_41_ADF_DAMAGE',				label = _('RKL-41 Goniometer FAILURE'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RKL_41_ANT_DAMAGE',				label = _('RKL-41 Antenna FAILURE'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- Weapon System
		{ id = 'GSH23_CHARGED_FAILURE',			label = _('GSh-23l Charge FAILURE'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
	},
	AddPropAircraft = {
		{ id = "SoloFlight" 			, control = 'checkbox' , label = _('Solo Flight')			   , defValue = false, weightWhenOn = -80,
					arg = 472, argTbl = {[true] = 0.5, [false] = 0}},
		{ id = "NetCrewControlPriority" , control = 'comboList', label = _('Aircraft Control Priority'), playerOnly = true,
		  values = {{id =  0, dispName = _("Pilot")},
					{id =  1, dispName = _("Instructor")},
					{id = -1, dispName = _("Ask Always")},
					{id = -2, dispName = _("Equally Responsible")}},
		  defValue  = 1,
		  wCtrl     = 150
		},
		{ id = "NS430allow" , control = 'checkbox', label = _('Allow NS 430'), defValue = true},	
		{ id = "DismountIFRHood", control = 'checkbox' , label = _('Dismount IFR Hood'), defValue = false, playerOnly = true},
		
	},
		
	Damage =   
	{
		[0] =  -- nose center
		{
			args = 	{146}, 
			critical_damage	=	3,
		},
		[1] =  -- nose left
		{
			args = 	{150}, 
			critical_damage	=	3,
		},
		[2] =  -- nose right
		{
			args = 	{148}, 
			critical_damage	=	3,
		},
		[3] = -- cockpit
		{
			args = 	{65},
			critical_damage	=	7,
		},
		[4] = -- cabin left
		{
			args = 	{150},
			critical_damage	=	5,
		},
		[5] = -- cabin right
		{
			args = 	{149},
			critical_damage	=	5,
		},
		[8] =  -- front gear box
		{
			args = 	{265},  
			critical_damage	=	3,
		},
		[9] = -- fuselage left
		{
			args = 	{154},
			critical_damage	=	4,
			deps_cells = { 11 },
		},
		[10] = -- fuselage right
		{
			args = 	{153},
			critical_damage	=	4,
			deps_cells = { 11 },
		},
		[11] =  --engine
		{
			critical_damage =	3,
		},
		[15] = -- gear box l
		{
			args = 	{267},
			critical_damage	=	3,
		},
		[16] = -- gear box r
		{
			args = 	{266},
			critical_damage	=	3,
		},
		[19] = -- airbrake l
		{
			args = 	{185},
			critical_damage	=	5,
		},
		[20] = -- airbrake r
		{
			args = 	{183},
			critical_damage	=	5,
		},
		[23] = -- lt wing out
		{
			args = 	{223},
			critical_damage	=	3,
		},
		[24] = -- rt wing out
		{
			args = 	{213},
			critical_damage	=	3,
		},
		[25] =  -- lt ail
		{
			args = 	{226}, 
			critical_damage	=	3,
		},
		[26] =  -- rt ail
		{
			args = 	{216},
			critical_damage	=	3,
		},
		[29] =  -- lt wing cnt
		{
			args = 	{224},
			critical_damage	=	10,
			deps_cells = 	{23,	25},
		},
		[30] =  -- rt wing cnt
		{
			args = 	{214},
			critical_damage	=	10,
			deps_cells = 	{24,	26},
		},
		[35] = -- lt wing in
		{
			args = 	{225},
			critical_damage	=	10,
			deps_cells = 	{23, 25, 29, 37, 84},
		},
		[36] = -- rt wing in
		{
			args = 	{215},
			critical_damage	=	10,
			deps_cells = 	{24, 26, 30, 38, 85},
		},
		[37] = -- lt flap
		{
			args = 	{227},
			critical_damage	=	3,
		},
		[38] =  -- rt flap
		{
			args = 	{217}, 
			critical_damage	=	3,
		},
		[40] = -- fin r top
		{
			args = 	{241},
			critical_damage	= 3,
		},
		[42] = -- fin r center
		{
			args = 	{242},
			critical_damage	= 5,
			deps_cells = {40, 54},
		},
		[44] = -- fin r bottom
		{
			args = 	{243},
			critical_damage	= 15,
			deps_cells = {42, 40, 54, 55},
		},
		[45] = -- lt stab out
		{
			args = 	{235},
			critical_damage	=	7,
		},
		[46] = -- rt stab out
		{
			args = 	{233}, 
			critical_damage	=	7,
		},
		[47] = -- lt stab in
		{
			args = 	{236}, 
			critical_damage	=	7,
			deps_cells = 	{45, 51},
		},
		[48] = -- rt stab in
		{
			args = 	{234}, 
			critical_damage	=	7,
			deps_cells = 	{46, 52},
		},
		[51] = -- elev lt
		{
			args = 	{240},
			critical_damage	=	3,
		},
		[52] = -- elev rt 
		{
			args = 	{238},
			critical_damage	=	3,
		},
		[54] = -- rudder
		{
			args = 	{247},
			critical_damage	=	3,
		},
		[55] = -- !!!fake element!!! (for logic tail kill)
		{
			args = 	{81},
			critical_damage	= 20,
		},-- end of [55]
		[56] = -- tail left (nozzle!)
		{
			args = 	{158},
			critical_damage	=	4,
			deps_cells = { 11 },
		},
		[57] = -- tail right (nozzle!)
		{
			args = 	{157},
			critical_damage	=	4,
			deps_cells = { 11 },
		},
		[58] = -- tail bottom
		{
			args = 	{156},
			critical_damage	=	4,
			deps_cells = { 11 },
		},
		[59] = -- nose bottom
		{
			args = 	{148},
			critical_damage	=	3,
		},
		[82] = --fuselage bottom
		{
			args = 	{152},
			critical_damage	=	4,
		},
		[83] =  -- nose wheel
		{
			args = 	{134},
			critical_damage	=	4,
		},-- end of [83]
		[84] = -- wheel lt
		{
			args = 	{136},
			critical_damage	=	4,
		},
		[85] = -- wheel rt
		{
			args = 	{135},
			critical_damage	=	4,
		},
	},-- end of Damage
	DamageParts 	= 	{"L-39_C_oblomok__wing_R",	"L-39_C_oblomok__wing_L", "", "L-39_C_oblomok__kil_stab"},
	HumanRadio 		= 	
	{
		frequency	= 305.0,
		editable	= true,
		minFrequency	= 118.000,
		maxFrequency	= 390.000,
        rangeFrequency = {	{min = 118.0, max = 140.0},
                            {min = 220.0, max = 390.0}
                        },
		modulation	= MODULATION_AM,
	},
	panelRadio = {
        [1] = {  
            name = _("R-832M"),
            range = {	{min = 118.0, max = 140.0},
						{min = 220.0, max = 390.0}
			},
            channels = {
                [1] = { name = _("Channel 0"),		default = 305.0, modulation = _("AM"), connect = true}, -- default
                [2] = { name = _("Channel 1"),		default = 264.0, modulation = _("AM")},	-- min. water : 135.0, 264.0
                [3] = { name = _("Channel 2"),		default = 265.0, modulation = _("AM")},	-- nalchik : 136.0, 265.0
                [4] = { name = _("Channel 3"),		default = 256.0, modulation = _("AM")},	-- sochi : 127.0, 256.0
                [5] = { name = _("Channel 4"),		default = 254.0, modulation = _("AM")},	-- maykop : 125.0, 254.0
                [6] = { name = _("Channel 5"),		default = 250.0, modulation = _("AM")},	-- anapa : 121.0, 250.0
                [7] = { name = _("Channel 6"),		default = 270.0, modulation = _("AM")},	-- beslan : 141.0, 270.0
                [8] = { name = _("Channel 7"),		default = 257.0, modulation = _("AM")},	-- krasnodar-pashk. : 128.0, 257.0
                [9] = { name = _("Channel 8"),		default = 255.0, modulation = _("AM")},	-- gelenjik : 126.0, 255.0
                [10] = { name = _("Channel 9"),		default = 262.0, modulation = _("AM")},	-- kabuleti : 133.0, 262.0
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

	SFM_Data = 
	{
		aerodynamics = 
		{
			Cy0			=	0,
			Czbe		=	-0.016,
			Mzalfa		=	4.355,
			Mzalfadt	=	0.8,
			cx_brk		=	0.06,
			cx_flap		=	0.095,
			cx_gear		=	0.0217,
			cy_flap		=	0.65,
			kjx			=	2.25,
			kjz			=	0.00125,
			table_data = 
			{
				[1] = 	{0,		0.022,	0.075,	0.08,	0.03,	0.15,	20,	1.33},
				[2] = 	{0.1,	0.022,	0.075,	0.08,	0.03,	0.7,	19,	1.33},
				[3] = 	{0.2,	0.022,	0.075,	0.08,	0.03,	1.2,	18,	1.3},
				[4] = 	{0.3,	0.022,	0.078,	0.08,	0.03,	1.6,	17,	1.2},
				[5] = 	{0.4,	0.022,	0.079,	0.08,	0.03,	2.1,	13,	1.1},
				[6] = 	{0.5,	0.0222,	0.08,	0.08,	0.03,	2.6,	11,	1},
				[7] = 	{0.6,	0.0236,	0.0825,	0.08,	0.03,	3.1,	9,	0.8},
				[8] = 	{0.7,	0.0246,	0.085,	0.087,	0.036,	3.5,	7,	0.7},
				[9] = 	{0.8,	0.035,	0.08,	0.17,	0.056,	3.5,	4,	0.5},
				[10] = 	{0.85,	0.05,	0.07,	0.26,	0.069,	3.5,	3,	0.4},
				[11] = 	{1.1,	0.16,	0.03,	0.5,	0.08,	1.5,	1,	0.3},
			},-- end of table_data
		},-- end of aerodynamics
		engine = 
		{
			ForsRUD	=	1,
			MaksRUD	=	1,
			MaxRUD	=	1,
			MinRUD	=	0,
			Nmg		=	56.01,
			cefor	=	0.37,
			cemax	=	0.37,
			dcx_eng	=	0.0015,
			dpdh_f	=	1800,
			dpdh_m	=	1800,
			hMaxEng	=	12.5,
			table_data = 
			{
				[1] = 	{0,		16620},
				[2] = 	{0.1,	15600},
				[3] = 	{0.2,	14340},
				[4] = 	{0.3,	13320},
				[5] = 	{0.4,	12230},
				[6] = 	{0.5,	11300},
				[7] = 	{0.6,	10600},
				[8] = 	{0.7,	10050},
				[9] = 	{0.8,	9820},
				[10] = 	{0.9,	5902},
				[11] = 	{1.9,	3469},
			},-- end of table_data
			type	=	"TurboJet",
            Startup_Prework = 10.0,
            Shutdown_Duration = 28.0,
		},-- end of engine
	},-- end of SFM_Data

	-- Countermeasures
	passivCounterm = {
		CMDS_Edit = false,
		SingleChargeTotal = 0,
		chaff = {default = 0, increment = 0, chargeSz = 0},
		flare = {default = 0, increment = 0, chargeSz = 0}
	},

	chaff_flare_dispenser = 
	{
		{
			dir = 	{0,	1,	0},
			pos = 	{-3.677,	1.012,	-0.859},
		},-- end of [1]
		{
			dir = 	{0,	1,	0},
			pos = 	{-3.677,	1.012,	0.859},
		},-- end of [2]
	},-- end of chaff_flare_dispenser

	engines_nozzles 	= 
	{
		{
			diameter	=	0.6,
			elevation	=	0,
			exhaust_length_ab	=	8.631,
			exhaust_length_ab_K	=	0.76,
			pos = 	{-5,	0.5,	0},
			smokiness_level	=	0.1,
		},-- end of [1]
	},-- end of engines_nozzles
	fires_pos = 
	{
		[1] = 	{-2		,	0.595,	0},
		[2] = 	{0		,	0	,	1.5},
		[3] = 	{0		,	0	,	-1.5},
		[4] = 	{0.265	,	0	,	2.237},
		[5] = 	{-0.265	,	0	,	-2.237},
		[6] = 	{0.5	,	0	,	4.274},
		[7] = 	{0.5	,	0	,	-4.274},
		[8] = 	{-5		,	0.5	,	0},
		[9] = 	{-5		,	0.5	,	0},
		[10] = 	{-5		,	0.5	,	0},
		[11] = 	{-5		,	0.5	,	0},
	},-- end of fires_pos
	lights_data = 
	{
        typename = "collection",
        lights = {
            [WOLALIGHT_LANDING_LIGHTS] = {
                typename = "collection",
                lights = {
                    {	argument = 208,	typename = "argumentlight",	connector = "MAIN_SPOT_PTR_01"},
                    {	argument = 210,	typename = "argumentlight",	connector = "MAIN_SPOT_PTR_02"},
                },
            },-- end of [2]
            [WOLALIGHT_TAXI_LIGHTS] = {
                typename = "collection",
                lights = {
                    {	argument = 209,	typename = "argumentlight",	connector = "MAIN_SPOT_PTR_01"},
                    {	argument = 211,	typename = "argumentlight",	connector = "MAIN_SPOT_PTR_02"},
                },
            },
            [3] = {
                typename = "collection",
                lights = {
                    [1] = {	argument = 192,	typename = "argumentlight", controller = "Strobe", mode = 0, period = 2.0, flash_time = 1.0, },
                    [2] = {	argument = 190,	typename = "argumentlight", controller = "Strobe", mode = 0, period = 2.0, flash_time = 1.0, },
                    [3] = {	argument = 191,	typename = "argumentlight", controller = "Strobe", mode = 0, period = 2.0, flash_time = 1.0, },
                },
            },-- end of [3]
        },
	},-- end of lights_data
}-- end of base_L_39

if rewrite_settings then 
   for i,o in pairs(rewrite_settings) do
		base_L_39[i] = o
   end
end

if base_L_39.Name == 'L-39C' then
	local props = base_L_39.AddPropAircraft
	props[#props + 1] = { id = "DismountGunSight", control = 'checkbox' , label = _('Dismount Gunsight'), defValue = false,}
end

add_aircraft(base_L_39)
end

make_albatros()