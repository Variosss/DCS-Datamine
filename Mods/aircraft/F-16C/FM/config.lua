-- BEGIN -- this part of the file is not intended for an end-user editing
--[[ --------------------------------------------------------------- ]]--

local mainGear = {
	--amortizer_min_length					= 0.0,
	amortizer_max_length					= 0.240,	-- 0.2667 (strut stroke) + 0.073025 (wheel static axle)
	amortizer_basic_length					= 0.240,	-- 0.2667 (strut stroke) + 0.073025 (wheel static axle)
	amortizer_spring_force_factor			= 2.1e+7,
	amortizer_spring_force_factor_rate		= 3,
	amortizer_static_force					= 1000,
	amortizer_reduce_length					= 0.05,
	amortizer_direct_damper_force_factor	= 60000,
	amortizer_back_damper_force_factor		= 20000,
	allowable_hard_contact_length			= 0.1,

	anti_skid_installed = true,

	crossover_locked_wheel_protection			= true,
	crossover_locked_wheel_protection_speed_min	= 18.0,
	anti_skid_improved							= true,
	anti_skid_gain								= 400.0,

	wheel_radius					= 0.352425,	-- 27.75 / 2 (inch)
	wheel_static_friction_factor	= 0.70,
	wheel_glide_friction_factor		= 0.30,
	wheel_side_friction_factor		= 0.43,
	wheel_roll_friction_factor		= 0.04,
	wheel_damage_force_factor		= 450.0,
	wheel_brake_moment_max			= 9500.0,
	wheel_kz_factor					= 0.52,
	noise_k							= 0.4,
	wheel_damage_speedX				= 115,
	wheel_damage_delta_speedX		= 11.5,
}

F16C = {
	center_of_mass		= {-1.4, -0.069, 0.0},	--x,y,z
	moment_of_inertia	= {  12875.0, 85552.0, 75674.0, -1331.0},--Ix,Iy,Iz,Ixy			-- Ix(roll) = 9496, Iy(pitch) = 55814, Iz(yaw) = 63100 [slug-ft2]
	--moment_of_inertia = {  4610.0, 48882.0, 52678.0, 0.0},--Ix,Iy,Iz,Ixy
	suspension			= {
		{ -- NOSE WHEEL
			damage_element					= 83,
			wheel_axle_offset				= 0.0,
			self_attitude					= false,
			yaw_limit						= math.rad(32.0),
			moment_limit					= 750.0,
			damper_coeff					= 300.0,
			allowable_hard_contact_length	= 0.25,
			filter_yaw						= false,

			amortizer_min_length						= 0.0,
			amortizer_max_length						= 0.244,	-- (0.254 (strut stroke) * sin(70 deg)) = 0.239 + 0.0381 (wheel static axle)
			amortizer_basic_length						= 0.244,	-- (0.254 (strut stroke) * sin(70 deg)) = 0.239 + 0.0381 (wheel static axle)
			amortizer_spring_force_factor				= 5200000,	-- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate
			amortizer_spring_force_factor_rate			= 3,
			amortizer_static_force						= 1000,
			amortizer_reduce_length						= 0.05,
			amortizer_direct_damper_force_factor		= 35000,
			amortizer_back_damper_force_factor			= 15000,

			anti_skid_installed							= false,

			wheel_radius								= 0.2286,	-- 18 / 2 (inch)
			wheel_static_friction_factor				= 0.65,
			wheel_side_friction_factor					= 0.45,
			wheel_roll_friction_factor					= 0.05,
			wheel_glide_friction_factor					= 0.30,
			wheel_damage_force_factor					= 450.0,
			wheel_kz_factor								= 0.3,
			noise_k										= 1.0,
			wheel_damage_speedX							= 115,
			wheel_damage_delta_speedX					= 11.5,

			arg_post			= 0,
			arg_amortizer		= 1,
			arg_wheel_rotation	= 101,
			arg_wheel_damage	= 134
		},
		{ -- LEFT WHEEL
			damage_element					= 84,

			amortizer_max_length						= mainGear.amortizer_max_length,
			amortizer_basic_length						= mainGear.amortizer_basic_length,
			amortizer_spring_force_factor				= mainGear.amortizer_spring_force_factor, -- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate
			amortizer_spring_force_factor_rate			= mainGear.amortizer_spring_force_factor_rate,
			amortizer_static_force						= mainGear.amortizer_static_force,
			amortizer_reduce_length						= mainGear.amortizer_reduce_length,
			amortizer_direct_damper_force_factor		= mainGear.amortizer_direct_damper_force_factor,
			amortizer_back_damper_force_factor			= mainGear.amortizer_back_damper_force_factor,
			allowable_hard_contact_length				= mainGear.allowable_hard_contact_length,

			anti_skid_installed							= mainGear.anti_skid_installed,

			crossover_locked_wheel_protection			= mainGear.crossover_locked_wheel_protection,
			crossover_locked_wheel_protection_wheel		= 2,
			crossover_locked_wheel_protection_speed_min	= mainGear.crossover_locked_wheel_protection_speed_min,
			anti_skid_improved							= mainGear.anti_skid_improved;
			anti_skid_gain								= mainGear.anti_skid_gain,

			wheel_radius								= mainGear.wheel_radius,
			wheel_static_friction_factor				= mainGear.wheel_static_friction_factor,
			wheel_side_friction_factor					= mainGear.wheel_side_friction_factor,
			wheel_roll_friction_factor					= mainGear.wheel_roll_friction_factor,
			wheel_glide_friction_factor					= mainGear.wheel_glide_friction_factor,
			wheel_damage_force_factor					= mainGear.wheel_damage_force_factor,
			wheel_brake_moment_max						= mainGear.wheel_brake_moment_max,
			wheel_kz_factor								= mainGear.wheel_kz_factor,
			noise_k										= mainGear.noise_k,
			wheel_damage_speedX							= mainGear.wheel_damage_speedX,
			wheel_damage_delta_speedX					= mainGear.wheel_damage_delta_speedX,

			arg_post			= 5,
			arg_amortizer		= 6,
			arg_wheel_rotation	= 102,
			arg_wheel_damage	= 136
		},
		{  -- RIGHT WHEEL
			damage_element					= 85,

			amortizer_max_length						= mainGear.amortizer_max_length,
			amortizer_basic_length						= mainGear.amortizer_basic_length,
			amortizer_spring_force_factor				= mainGear.amortizer_spring_force_factor, -- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate
			amortizer_spring_force_factor_rate			= mainGear.amortizer_spring_force_factor_rate,
			amortizer_static_force						= mainGear.amortizer_static_force,
			amortizer_reduce_length						= mainGear.amortizer_reduce_length,
			amortizer_direct_damper_force_factor		= mainGear.amortizer_direct_damper_force_factor,
			amortizer_back_damper_force_factor			= mainGear.amortizer_back_damper_force_factor,
			allowable_hard_contact_length				= mainGear.allowable_hard_contact_length,

			anti_skid_installed							= mainGear.anti_skid_installed,

			crossover_locked_wheel_protection			= mainGear.crossover_locked_wheel_protection,
			crossover_locked_wheel_protection_wheel		= 1,
			crossover_locked_wheel_protection_speed_min	= mainGear.crossover_locked_wheel_protection_speed_min,
			anti_skid_improved							= mainGear.anti_skid_improved;
			anti_skid_gain								= mainGear.anti_skid_gain,

			wheel_radius								= mainGear.wheel_radius,
			wheel_static_friction_factor				= mainGear.wheel_static_friction_factor,
			wheel_side_friction_factor					= mainGear.wheel_side_friction_factor,
			wheel_roll_friction_factor					= mainGear.wheel_roll_friction_factor,
			wheel_glide_friction_factor					= mainGear.wheel_glide_friction_factor,
			wheel_damage_force_factor					= mainGear.wheel_damage_force_factor,
			wheel_brake_moment_max						= mainGear.wheel_brake_moment_max,
			wheel_kz_factor								= mainGear.wheel_kz_factor,
			noise_k										= mainGear.noise_k,
			wheel_damage_speedX							= mainGear.wheel_damage_speedX,
			wheel_damage_delta_speedX					= mainGear.wheel_damage_delta_speedX,

			arg_post			= 3,
			arg_amortizer		= 4,
			arg_wheel_rotation	= 103,
			arg_wheel_damage	= 135
		},
	}, -- gears suspension
	disable_built_in_oxygen_system	= true,
--[[ ------------------------------------------------------------- ]]--
-- END -- this part of the file is not intended for an end-user editing

	-- FFB force multiplier
	ffbPitchK	= 0.65,
	ffbRollK	= 0.65,

	-- view shake amplitude
	minor_shake_ampl = 0.07,
	major_shake_ampl = 0.25,

	-- debug
	debugLine = "{M}:%1.3f {KCAS}:%4.1f {KEAS}:%4.1f {KTAS}:%4.1f {Mind}:%1.3f {IndAS}:%4.1f {AoA}:%4.1f {AoS}:%4.1f {nx}:%2.1f {ny}:%4.1f {nz}:%5.2f {wx}:%4.1f {wy}:%4.1f {wz}:%4.1f {Fx}:%7.0f {Pl}:%7.0f {mass_lb}:%4.1f {X}:%2.2f {Lstab}:%2.1f {Lail}:%2.1f {Rud}:%2.1f {pitch}:%2.1f {Vy}:%7.1f {DI}:%3.0f",
}