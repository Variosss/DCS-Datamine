-- BEGIN -- this part of the file is not intended for an end-user editing
--[[ --------------------------------------------------------------- ]]--

local mainGear = {
	--amortizer_min_length					= 0.0,
	amortizer_max_length					= 0.595 + 0.06,	-- absorber + tire, (0.642 + 0.06)
	amortizer_basic_length					= 0.595 + 0.06,	-- absorber + tire, (0.642 + 0.06)
	amortizer_spring_force_factor			= 1000.0,
	amortizer_spring_force_factor_rate		= 0,
	amortizer_static_force					= 1000.0,
	amortizer_reduce_length					= 0.63,
	amortizer_direct_damper_force_factor	= 10000.0,
	amortizer_back_damper_force_factor		= 40000.0,
	allowable_hard_contact_length			= 0.1,

	--amortizer_spring2_min_length					= 0.0,
	amortizer_spring2_max_length					= 0.20565,
	amortizer_spring2_basic_length					= 0.20565,
	amortizer_spring2_spring_force_factor			= 3500000.0,
	amortizer_spring2_spring_force_factor_rate		= 1.5,
	amortizer_direct_damper2_force_factor			= 300000.0,
	amortizer_back_damper2_force_factor				= 150000.0,

	anti_skid_installed = true,

	crossover_locked_wheel_protection = true,
	crossover_locked_wheel_protection_speed_min = 18.0,
	anti_skid_improved = true,
	anti_skid_gain = 200.0,

	wheel_radius					= 0.340,
	wheel_static_friction_factor	= 0.8,
	wheel_glide_friction_factor		= 0.8 * 0.4,
	wheel_side_friction_factor		= 0.55,
	wheel_roll_friction_factor		= 0.03,
	wheel_damage_force_factor		= 450.0,
	wheel_brake_moment_max			= 9000.0,
	wheel_kz_factor					= 0.25,
	noise_k							= 0.4,
	wheel_damage_speedX				= 108,
	wheel_damage_delta_speedX		= 15,
}

FA18C = {
	center_of_mass		= {-1.681, -0.03348,   0.0},			--x,y,z
	moment_of_inertia	= { 31100,  192030, 165930, 3200},	--Ix,Iy,Iz,Ixy	-- TODO: approx.
	zeroize_amortizers_before_collision_check = false,
	suspension 			= {
		{ -- NOSE WHEEL
			damage_element					= 83,
			wheel_axle_offset				= 0.08,
			self_attitude					= false,
			yaw_limit						= math.rad(75.0),
			moment_limit					= 750.0,
			damper_coeff					= 300.0,
			filter_yaw						= false,
			influence_of_pos_z_to_V_l_z		= false,

			amortizer_min_length					= 0.0,
			amortizer_max_length					= 0.5 + 0.04,	-- absorber + tire, (model: 0.5 + 0.04)
			amortizer_basic_length					= 0.5 + 0.04,	-- absorber + tire, (model: 0.5 + 0.04)
			amortizer_spring_force_factor			= 29000000.0,
			amortizer_spring_force_factor_rate		= 9,
			amortizer_static_force					= 10000.0,
			amortizer_reduce_length					= 0.39,
			amortizer_direct_damper_force_factor	= 40000,
			amortizer_back_damper_force_factor		= 20000,
			allowable_hard_contact_length			= 0.1,

			anti_skid_installed = false,

			wheel_radius					= 0.26925,
			wheel_static_friction_factor	= 0.75,
			wheel_glide_friction_factor		= 0.30,
			wheel_side_friction_factor		= 0.65,
			wheel_roll_friction_factor		= 0.04,
			wheel_damage_force_factor		= 450.0,
			wheel_kz_factor					= 0.3,
			noise_k							= 0.2,
			wheel_damage_speedX				= 97.5,
			wheel_damage_delta_speedX		= 11.5,

			arg_post			= 0,
			arg_amortizer		= 1,
			arg_wheel_rotation	= 101,
			arg_wheel_damage	= 135
		},
		{ -- LEFT WHEEL
			damage_element							= 84,

			--amortizer_min_length					= mainGear.amortizer_min_length,
			amortizer_max_length					= mainGear.amortizer_max_length,
			amortizer_basic_length					= mainGear.amortizer_basic_length,
			amortizer_spring_force_factor			= mainGear.amortizer_spring_force_factor, -- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate
			amortizer_spring_force_factor_rate		= mainGear.amortizer_spring_force_factor_rate,
			amortizer_static_force					= mainGear.amortizer_static_force,
			amortizer_reduce_length					= mainGear.amortizer_reduce_length,
			amortizer_direct_damper_force_factor	= mainGear.amortizer_direct_damper_force_factor, 
			amortizer_back_damper_force_factor		= mainGear.amortizer_back_damper_force_factor, 
			allowable_hard_contact_length			= mainGear.allowable_hard_contact_length,

			--amortizer_spring2_min_length					= mainGear.amortizer_spring2_min_length,
			amortizer_spring2_max_length					= mainGear.amortizer_spring2_max_length,
			amortizer_spring2_basic_length					= mainGear.amortizer_spring2_basic_length,
			amortizer_spring2_spring_force_factor			= mainGear.amortizer_spring2_spring_force_factor, -- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate
			amortizer_spring2_spring_force_factor_rate		= mainGear.amortizer_spring2_spring_force_factor_rate,
			amortizer_direct_damper2_force_factor			= mainGear.amortizer_direct_damper2_force_factor,
			amortizer_back_damper2_force_factor				= mainGear.amortizer_back_damper2_force_factor,

			anti_skid_installed = mainGear.anti_skid_installed,

			crossover_locked_wheel_protection			= mainGear.crossover_locked_wheel_protection,
			crossover_locked_wheel_protection_wheel		= 2,
			crossover_locked_wheel_protection_speed_min	= mainGear.crossover_locked_wheel_protection_speed_min,
			anti_skid_improved							= mainGear.anti_skid_improved;
			anti_skid_gain								= mainGear.anti_skid_gain,

			wheel_radius					= mainGear.wheel_radius,
			wheel_static_friction_factor	= mainGear.wheel_static_friction_factor,
			wheel_side_friction_factor		= mainGear.wheel_side_friction_factor,
			wheel_roll_friction_factor		= mainGear.wheel_roll_friction_factor,
			wheel_glide_friction_factor		= mainGear.wheel_glide_friction_factor,
			wheel_damage_force_factor		= mainGear.wheel_damage_force_factor,
			wheel_brake_moment_max			= mainGear.wheel_brake_moment_max,
			wheel_kz_factor					= mainGear.wheel_kz_factor,
			noise_k							= mainGear.noise_k,
			wheel_damage_speedX				= mainGear.wheel_damage_speedX,
			wheel_damage_delta_speedX		= mainGear.wheel_damage_delta_speedX,

			arg_post			= 5,
			arg_amortizer		= 6,
			arg_wheel_rotation	= 103,
			arg_wheel_damage	= 137
		},
		{  -- RIGHT WHEEL
			damage_element							= 85,

			--amortizer_min_length					= mainGear.amortizer_min_length,
			amortizer_max_length					= mainGear.amortizer_max_length,
			amortizer_basic_length					= mainGear.amortizer_basic_length,
			amortizer_spring_force_factor			= mainGear.amortizer_spring_force_factor, -- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate
			amortizer_spring_force_factor_rate		= mainGear.amortizer_spring_force_factor_rate,
			amortizer_static_force					= mainGear.amortizer_static_force,
			amortizer_reduce_length					= mainGear.amortizer_reduce_length,
			amortizer_direct_damper_force_factor	= mainGear.amortizer_direct_damper_force_factor, 
			amortizer_back_damper_force_factor		= mainGear.amortizer_back_damper_force_factor, 
			allowable_hard_contact_length			= mainGear.allowable_hard_contact_length,

			--amortizer_spring2_min_length					= mainGear.amortizer_spring2_min_length,
			amortizer_spring2_max_length					= mainGear.amortizer_spring2_max_length,
			amortizer_spring2_basic_length					= mainGear.amortizer_spring2_basic_length,
			amortizer_spring2_spring_force_factor			= mainGear.amortizer_spring2_spring_force_factor, -- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate
			amortizer_spring2_spring_force_factor_rate		= mainGear.amortizer_spring2_spring_force_factor_rate,
			amortizer_direct_damper2_force_factor			= mainGear.amortizer_direct_damper2_force_factor,
			amortizer_back_damper2_force_factor				= mainGear.amortizer_back_damper2_force_factor,

			anti_skid_installed = mainGear.anti_skid_installed,

			crossover_locked_wheel_protection			= mainGear.crossover_locked_wheel_protection,
			crossover_locked_wheel_protection_wheel		= 1,
			crossover_locked_wheel_protection_speed_min	= mainGear.crossover_locked_wheel_protection_speed_min,
			anti_skid_improved							= mainGear.anti_skid_improved;
			anti_skid_gain								= mainGear.anti_skid_gain,

			wheel_radius					= mainGear.wheel_radius,
			wheel_static_friction_factor	= mainGear.wheel_static_friction_factor,
			wheel_side_friction_factor		= mainGear.wheel_side_friction_factor,
			wheel_roll_friction_factor		= mainGear.wheel_roll_friction_factor,
			wheel_glide_friction_factor		= mainGear.wheel_glide_friction_factor,
			wheel_damage_force_factor		= mainGear.wheel_damage_force_factor,
			wheel_brake_moment_max			= mainGear.wheel_brake_moment_max,
			wheel_kz_factor					= mainGear.wheel_kz_factor,
			noise_k							= mainGear.noise_k,
			wheel_damage_speedX				= mainGear.wheel_damage_speedX,
			wheel_damage_delta_speedX		= mainGear.wheel_damage_delta_speedX,

			arg_post			= 3,
			arg_amortizer		= 4,
			arg_wheel_rotation	= 102,
			arg_wheel_damage	= 136
		},
	}, -- gears
	disable_built_in_oxygen_system	= true,
--[[ ------------------------------------------------------------- ]]--
-- END -- this part of the file is not intended for an end-user editing

	minor_shake_ampl = 0.07,
	major_shake_ampl = 0.25,

	flaps45WakeLossCoefGround = 1.0,
	
	-- debug
	debugLine = "{M}:%1.3f {KCAS}:%4.1f {KEAS}:%4.1f {KTAS}:%4.1f {IndAS}:%4.1f {IAS}:%4.1f {AoA_U}:%5.1f {AoA}:%5.1f {AoS}:%5.1f {ny}:%5.2f {nxV}:%5.2f {wx}:%6.1f {wy}:%6.1f {wz}:%6.1f {Lstab}:%5.1f {Rud}:%5.1f {mass}:%5.1f {mass_lb}:%5.1f {x}:%2.3f {X}:%2.2f {dPsi}:%.1f",
}