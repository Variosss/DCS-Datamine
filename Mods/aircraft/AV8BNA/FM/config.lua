AV8BFM = {
	-- center of mass position relative to object 3d model center for empty aircraft (m)
	-- in DCS World coordinates		
	center_of_mass		=	{ 0.0, 0.0, 0.0},	
	-- moment of inertia of empty aircraft (kg/m^2)
	-- (Ix, Iz, Iy, Ixy) in typical body coordinates (not DCS World coordinates)
	moment_of_inertia  	= 	{9008, 75585, 70255, 2955},   	-- moment of inertia of empty aircraft
	suspension 			= {
		{ -- NOSE WHEEL
			damage_element					= "FRONT_WHEEL",
			allowable_hard_contact_length   = 0.1,
			wheel_axle_offset				= 0.33,
			self_attitude					= false,
			damper_coeff			        = 300.0,
			yaw_limit						= math.rad(45.0),			
			moment_limit                    = 750.0,
			filter_yaw                      = false,
			
			amortizer_min_length					= 0.0,
			amortizer_max_length					= 0.3429,
			amortizer_basic_length					= 0.3429,
			amortizer_spring_force_factor			= 4250000.0,	 -- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate
			amortizer_spring_force_factor_rate		= 3.25,
			amortizer_static_force					= 4937.0, --31137.0,
			amortizer_reduce_length					= 0.2032,
			amortizer_direct_damper_force_factor	= 35000.0,
			amortizer_back_damper_force_factor		= 25000.0,
			
			anti_skid_installed = false,

			wheel_radius					= 0.33,
			wheel_static_friction_factor	= 0.75,
			wheel_glide_friction_factor		= 0.30,
			wheel_side_friction_factor		= 0.65,
			wheel_roll_friction_factor		= 0.04,
			wheel_damage_force_factor		= 450.0,
            wheel_kz_factor					= 0.25,
            noise_k							= 0.4,
            wheel_damage_speedX				= 108,
            wheel_damage_delta_speedX		= 15,

			arg_post			= 0,
			arg_amortizer		= 1,
			arg_wheel_rotation	= 101,
			arg_wheel_damage	= 134,
			collision_shell_name  = "FRONT_WHEEL",
		},
		{ -- LEFT WHEEL
			damage_element					= "LEFT_WHEEL",			
			allowable_hard_contact_length   = 0.2,
			amortizer_max_length					= 0.3048, 
			amortizer_basic_length					= 0.3048, 
			amortizer_spring_force_factor			= 5000000, 
			amortizer_spring_force_factor_rate		= 4,
			amortizer_static_force					= 3442.0, 
			amortizer_reduce_length					= 0.135382, 
			amortizer_direct_damper_force_factor	= 25000.0,
			amortizer_back_damper_force_factor		= 25000.0,
			
			anti_skid_installed = false, 
			
			wheel_radius					= 0.17145,
			wheel_static_friction_factor	= 0.75,
			wheel_glide_friction_factor		= 0.30,
			wheel_side_friction_factor		= 0.65,
			wheel_roll_friction_factor		= 0.04,
			wheel_damage_force_factor		= 450.0,			
			wheel_kz_factor					= 0.3,
			noise_k							= 0.2,
			wheel_damage_speedX				= 97.5,
			wheel_damage_delta_speedX		= 11.5,
			
			arg_post			= 5,
			arg_amortizer		= 6,
			arg_wheel_rotation	= 102,
			arg_wheel_damage	= 136,
			collision_shell_name  = "LEFT_WHEEL",
		},
		{  -- RIGHT WHEEL			
			damage_element					= "RIGHT_WHEEL",						
			allowable_hard_contact_length   = 0.2,
			amortizer_max_length					= 0.3048, 
			amortizer_basic_length					= 0.3048, 
			amortizer_spring_force_factor			= 5000000, 
			amortizer_spring_force_factor_rate		= 4,
			amortizer_static_force					= 3442.0, 
			amortizer_reduce_length					= 0.135382, 
			amortizer_direct_damper_force_factor	= 25000.0,
			amortizer_back_damper_force_factor		= 25000.0,
			
			anti_skid_installed = false, 
			
			wheel_radius					= 0.17145,
			wheel_static_friction_factor	= 0.75,
			wheel_glide_friction_factor		= 0.30,
			wheel_side_friction_factor		= 0.65,
			wheel_roll_friction_factor		= 0.04,
			wheel_damage_force_factor		= 450.0,
			wheel_kz_factor					= 0.3,
			noise_k							= 0.2,
			wheel_damage_speedX				= 97.5,
			wheel_damage_delta_speedX		= 11.5,
			
			arg_post			= 3,
			arg_amortizer		= 4,
			arg_wheel_rotation	= 103,
			arg_wheel_damage	= 135,
			collision_shell_name  = "RIGHT_WHEEL",
		},		
		{ -- AFT WHEEL
			damage_element					= "AFT_WHEEL",
			allowable_hard_contact_length   = 0.1,			
			amortizer_min_length					= 0.0,
			amortizer_max_length					= 0.3175,
			amortizer_basic_length					= 0.3175,
			amortizer_spring_force_factor			= 35000000.0,	
			amortizer_spring_force_factor_rate		= 5,
			amortizer_static_force					= 17792.0,
			amortizer_reduce_length					= 0.298704,
			amortizer_direct_damper_force_factor	= 40000.0,
			amortizer_back_damper_force_factor		= 35000.0,
			
			anti_skid_installed = true,

			wheel_radius					= 0.33,
            wheel_static_friction_factor	= 0.8,
            wheel_glide_friction_factor		= 0.8 * 0.4,
            wheel_side_friction_factor		= 0.55,
            wheel_roll_friction_factor		= 0.03,
			wheel_damage_force_factor		= 450.0,
			wheel_damage_speed 				= 111.0,
			wheel_brake_moment_max			= 5000.0,
            wheel_kz_factor					= 0.25,
            noise_k							= 0.4,
            wheel_damage_speedX				= 108,
            wheel_damage_delta_speedX		= 15,
			
			arg_post			= 342,
			arg_amortizer		= 343,
			arg_wheel_rotation	= 104,
			arg_wheel_damage	= 137,
			collision_shell_name  = "AFT_WHEEL",
            
            track_width		= 0.4, -- separation distance between two wheels
		},
	}, -- gears
	
	disable_built_in_oxygen_system	= false, -- set this to false to enable hypoxia effects, etc
	water_debug = false, -- debug water consumption
}