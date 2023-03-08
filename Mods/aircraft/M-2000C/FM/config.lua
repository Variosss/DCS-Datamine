M2KFM = {
	-- center of mass position relative to object 3d model center for empty aircraft (m)
	-- in DCS World coordinates		
	center_of_mass		=	{ -1.35, 0.25, 0.0},	
	-- moment of inertia of empty aircraft (kg/m^2)
	-- (Ix, Iz, Iy, Ixy) in typical body coordinates (not DCS World coordinates)
	moment_of_inertia  	= 	{15288.0, 80000.0, 70000.0, 0.0},   	-- moment of inertia of empty aircraft
	suspension 			= {
		{ -- NOSE WHEEL
			damage_element					= 83,
			allowable_hard_contact_length   = 0.1,
			wheel_axle_offset				= 0.02,-- 0.0
			self_attitude					= false,
			damper_coeff			        = 300.0,
			yaw_limit						= math.rad(65.0),			
			moment_limit                    = 750.0,
			filter_yaw                      = false,
			
			amortizer_min_length					= 0.0,
			amortizer_max_length					= 0.235,-- 0.235
			amortizer_basic_length					= 0.235,-- 0.235
			amortizer_spring_force_factor			= 850000.0,-- 750000.0
			amortizer_spring_force_factor_rate		= 2.2,-- 2
			amortizer_static_force					= 22000.0,-- 25000.0
			amortizer_reduce_length					= 0.22,-- 0.22
			amortizer_direct_damper_force_factor	= 20000.0,-- 30000.0
			amortizer_back_damper_force_factor		= 20000.0,-- 35000.0
			
			anti_skid_installed = false,

			wheel_radius					= 0.1,
			wheel_static_friction_factor	= 0.75,
			wheel_side_friction_factor		= 0.85 ,
			wheel_roll_friction_factor		= 0.01 ,
			wheel_glide_friction_factor     = 0.65 ,
			wheel_damage_force_factor		= 450.0,
			wheel_damage_speed 				= 102.0,

			arg_post			= 0,
			arg_amortizer		= 1,
			arg_wheel_rotation	= 76,
			arg_wheel_damage	= 134,
			collision_shell_name  = "WHEEL_F",
		},
		{ -- LEFT WHEEL
			damage_element					= 84,			
			allowable_hard_contact_length   = 0.2,
			amortizer_max_length					= 0.22, 
			amortizer_basic_length					= 0.22, 			                                        
			amortizer_spring_force_factor			= 66000.0/math.pow(0.22, 1.5),
			amortizer_spring_force_factor_rate		= 1.5,
			amortizer_static_force					= 35000.0,
			amortizer_reduce_length					= 0.21,
			amortizer_direct_damper_force_factor	= 40000.0,
			amortizer_back_damper_force_factor		= 10000.0,
			
			anti_skid_installed = true,
			
			wheel_radius					= 0.225,
			wheel_static_friction_factor	= 0.85 ,
			wheel_side_friction_factor		= 0.85 ,
			wheel_roll_friction_factor		= 0.05 ,
			wheel_glide_friction_factor     = 0.65 ,
			wheel_damage_force_factor		= 450.0,
			wheel_brake_moment_max			= 8000.0,
			wheel_damage_speed 				= 111.0,

			arg_post			= 5,
			arg_amortizer		= 6,
			arg_wheel_rotation	= 102,
			arg_wheel_damage	= 136,
			collision_shell_name  = "WHEEL_L",
		},
		{  -- RIGHT WHEEL			
			damage_element					= 85,						
			allowable_hard_contact_length   = 0.2,
			amortizer_max_length					= 0.22, 
			amortizer_basic_length					= 0.22, 			                                        
			amortizer_spring_force_factor			= 66000.0/math.pow(0.22, 1.5),
			amortizer_spring_force_factor_rate		= 1.5,
			amortizer_static_force					= 35000.0,
			amortizer_reduce_length					= 0.21,
			amortizer_direct_damper_force_factor	= 40000.0,
			amortizer_back_damper_force_factor		= 10000.0,
			
			anti_skid_installed = true,
			
			wheel_radius					= 0.225,
			wheel_static_friction_factor	= 0.85 ,
			wheel_side_friction_factor		= 0.85 ,
			wheel_roll_friction_factor		= 0.05 ,
			wheel_glide_friction_factor     = 0.65 ,
			wheel_damage_force_factor		= 450.0,
			wheel_brake_moment_max			= 8000.0,
			wheel_damage_speed 				= 111.0,

			arg_post			= 3,
			arg_amortizer		= 4,
			arg_wheel_rotation	= 103,
			arg_wheel_damage	= 135,
			collision_shell_name  = "WHEEL_R",
		},
	}, -- gears
	
	disable_built_in_oxygen_system	= false, -- set this to false to enable hypoxia effects, etc
}