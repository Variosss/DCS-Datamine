-- static spring
front_static = 10000
main_static  = 40000

-- springs
front_spring_factor 		= 1800000.0
front_spring_factor_rate	= 3.0
main_spring_factor  		= 3600000.0
main_spring_factor_rate		= 3.0

-- dampers
front_direct_damper = 18000.0
front_back_damper	= front_direct_damper*0.5
main_direct_damper 	= 55000.0
main_back_damper 	= main_direct_damper*0.45

-- friction
front_static_friction = 0.80
nose_side_friction  = 0.75
nose_glide_friction = 0.50
nose_roll_friction	= 0.035

main_static_friction = 0.55
main_side_friction  = 0.78
main_glide_friction = 0.40
main_roll_friction  = 0.035

anti_skid = 600
wheel_lock_protection_speed = 25
wheel_brake_moment = 9000

suspension = {
	{ -- Nosegear
		mass				= 50.0,
		damage_element		= 83,
		wheel_axle_offset	= 0,
		self_attitude		= true,
		yaw_limit			= math.rad(30.0),

		amortizer_max_length					= 0.35,
		amortizer_basic_length					= 0.35,
		amortizer_reduce_length					= 0.35,
		allowable_hard_contact_length			= 1.0,

		amortizer_spring_force_factor			= front_spring_factor,
		amortizer_spring_force_factor_rate		= front_spring_factor_rate,
		amortizer_static_force					= front_static,
		amortizer_direct_damper_force_factor	= front_direct_damper,
		amortizer_back_damper_force_factor		= front_back_damper,


		damper_coeff = 20.0,

		anti_skid_installed = false,

		wheel_moment_of_inertia 		= 7,
		wheel_radius					= 0.200, --0.200
		wheel_static_friction_factor	= front_static_friction ,
		wheel_side_friction_factor		= nose_side_friction,
		wheel_roll_friction_factor		= nose_roll_friction ,-- 0.06
		wheel_glide_friction_factor		= nose_glide_friction,
		wheel_damage_force_factor		= 450,
		wheel_damage_speed 				= 90.0, -- 320km/h according to manual

		arg_post				= 0,
		arg_amortizer			= 1,
		arg_wheel_yaw 			= 2,
		arg_wheel_rotation		= 76,
		collision_shell_name	= "WHEEL_F"
	},
		
		
	{ -- Maingear L
		damage_element	= 84,
		mass			= 80,
		wheel_radius	= 0.30,

		yaw_limit		= 0.0,
		self_attitude	= false,

		anti_skid_installed = true,
		crossover_locked_wheel_protection           = true,
		crossover_locked_wheel_protection_speed_min = wheel_lock_protection_speed_min,
		anti_skid_improved                          = true,
		anti_skid_gain                              = anti_skid,
			
		amortizer_max_length					= 0.40,
		amortizer_basic_length					= 0.40,
		amortizer_reduce_length					= 0.4,
		allowable_hard_contact_length			= 0.35,

		amortizer_spring_force_factor			= main_spring_factor,
		amortizer_spring_force_factor_rate		= main_spring_factor_rate,
		amortizer_static_force					= main_static,
		amortizer_direct_damper_force_factor	= main_direct_damper,
		amortizer_back_damper_force_factor		= main_back_damper,

		damper_coeff = 30.0,

		wheel_static_friction_factor	= main_static_friction,
		wheel_side_friction_factor		= main_side_friction,
		wheel_roll_friction_factor		= main_roll_friction,
		wheel_glide_friction_factor		= main_glide_friction,

		wheel_damage_force_factor		= 450,
		wheel_brake_moment_max			= wheel_brake_moment,
		wheel_damage_speed 				= 90.0, -- 320km/h according to manual

		arg_post				= 5,
		arg_amortizer			= 6,
		arg_wheel_rotation		= 102,
		arg_wheel_yaw			= -1,
		collision_shell_name	= "WHEEL_LFront"
	},
		
		
	{  -- Maingear R
		damage_element	= 85,
		mass			= 80,
		wheel_radius	= 0.30,

		yaw_limit		= 0.0,
		self_attitude	= false,

		anti_skid_installed = true,
		crossover_locked_wheel_protection           = true,
		crossover_locked_wheel_protection_speed_min = wheel_lock_protection_speed_min,
		anti_skid_improved                          = true,
		anti_skid_gain                              = anti_skid,
			
		amortizer_max_length			= 0.40,
		amortizer_basic_length			= 0.40,
		amortizer_reduce_length			= 0.4,
		allowable_hard_contact_length	= 0.35,

		amortizer_spring_force_factor			= main_spring_factor,
		amortizer_spring_force_factor_rate		= main_spring_factor_rate,
		amortizer_static_force					= main_static,
		amortizer_direct_damper_force_factor	= main_direct_damper,
		amortizer_back_damper_force_factor		= main_back_damper,

		damper_coeff = 30.0,

		wheel_static_friction_factor	= main_static_friction,
		wheel_side_friction_factor		= main_side_friction,
		wheel_roll_friction_factor		= main_roll_friction,
		wheel_glide_friction_factor		= main_glide_friction,
			
		wheel_damage_force_factor		= 450,
		wheel_brake_moment_max			= wheel_brake_moment,
		wheel_damage_speed 				= 90.0, -- 320km/h according to manual

		arg_post				= 3,
		arg_amortizer			= 4,
		arg_wheel_rotation		= 101,
		arg_wheel_yaw			= -1,
		collision_shell_name	= "WHEEL_RFront"
	}
} -- gears
