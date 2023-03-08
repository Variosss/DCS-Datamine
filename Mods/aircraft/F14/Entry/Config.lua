


-- total static spring force should probably be around 262525 N which corresponds to weight with internal fuel and no weapons.
-- No, because f14 is supposed to ride quite low on main gears

front_static = 70000;
main_static = 8000;

front_spring_factor =  3823600;
main_spring_factor = 1757840;
main_spring_factor_rate = 5.0;

main_direct_damper = 160000; --115000;
main_back_dmper = 160000; --190000;


FM = {
	-- center of mass position relative to object 3d model center for empty aircraft (m)
	-- in DCS World coordinates
	center_of_mass		=	{0.0, 0.0, 0.0} ,-- {-0.041, 0.0, 0.0},	
	-- moment of inertia of empty aircraft (kg/m^2)
	-- (Ix, Iz, Iy, Ixy) in typical body coordinates (not DCS World coordinates)
	moment_of_inertia  	= 	{83925.5, 431000.0, 352872.5, 3310},   	-- moment of inertia of empty aircraft



	suspension 			= {
		{ -- Nosegear
			mass							= 50.0,
			damage_element					= 83,
			wheel_axle_offset				= 0,
			self_attitude					= true,
			yaw_limit						= math.rad(70.0),

	--		allowable_hard_contact_length	= 0.25,

			amortizer_max_length					= 0.4,
			amortizer_basic_length					= 0.4,
			amortizer_reduce_length					= 0.1,
			allowable_hard_contact_length			= 1.0,

		  amortizer_spring_force_factor			= front_spring_factor,
		  amortizer_spring_force_factor_rate		= 2.5,
		  amortizer_static_force					= front_static,
		  amortizer_direct_damper_force_factor	= 152000.0,
		  amortizer_back_damper_force_factor		= 152000.0,


			damper_coeff = 20.0,

			anti_skid_installed = false,

			wheel_moment_of_inertia 		= 7,
			wheel_radius					= 0.250,
			wheel_static_friction_factor	= 0.35 ,
			wheel_side_friction_factor		= 1.1,
			wheel_roll_friction_factor		= 0.06 ,
			wheel_glide_friction_factor		= 0.58 ,
			wheel_damage_force_factor		= 450,
			wheel_damage_speed 				= 98.0, -- 190 knots according to manual

			arg_post			= 0,
			arg_amortizer		= 1,
			arg_wheel_yaw 		= 2,
			arg_wheel_rotation	= 76,
			--arg_wheel_damage	= 134,
			collision_shell_name  = "WHEEL_F",
		},
		{ -- Maingear L
			damage_element					= 84,
			mass							= 80,
			wheel_radius					= 0.45,
			wheel_moment_of_inertia 		= 9,

			yaw_limit	 = 0.0,
			self_attitude	 = false,
			anti_skid_installed = true,

			amortizer_max_length					= 0.65,
			amortizer_basic_length					= 0.65,
			amortizer_reduce_length					= 0.01,  -- have to have reduce length or it adds force for some stupid reason
			allowable_hard_contact_length			= 0.3,

			amortizer_spring_force_factor			= main_spring_factor,
			amortizer_spring_force_factor_rate		= main_spring_factor_rate,
			amortizer_static_force					= main_static,--68917.0,
			amortizer_direct_damper_force_factor	= main_direct_damper, --45000.0,
			amortizer_back_damper_force_factor		= main_back_dmper,

			damper_coeff = 30.0,

			wheel_static_friction_factor	= 0.42 ,
			wheel_side_friction_factor		= 0.95 ,
			wheel_roll_friction_factor		= 0.067 ,
			wheel_glide_friction_factor		= 0.8 ,

			wheel_damage_force_factor		= 200,
			wheel_brake_moment_max			= 18000.0,
			wheel_damage_speed 				= 135.0, -- 190 knots according to manual

			arg_post			= 5,
			arg_amortizer		= 6,
			arg_wheel_rotation	= 77,
			arg_wheel_yaw = -1,
		--	arg_wheel_damage	= 136,
			collision_shell_name  = "WHEEL_L",
		},
		{  -- Maingear R
			damage_element					= 85,
			mass							= 80,
			wheel_radius					= 0.45,
			wheel_moment_of_inertia 		= 9,

			yaw_limit	 = 0.0,
			self_attitude	 = false,
			anti_skid_installed = true,

			amortizer_max_length					= 0.65,
			amortizer_basic_length					= 0.65,
			amortizer_reduce_length					= 0.01, -- have to have reduce length or it adds force for some stupid reason
			allowable_hard_contact_length			= 0.3,

			amortizer_spring_force_factor			= main_spring_factor,
			amortizer_spring_force_factor_rate		= main_spring_factor_rate,
			amortizer_static_force					= main_static,--68917.0,
			amortizer_direct_damper_force_factor	= main_direct_damper, --45000.0,
			amortizer_back_damper_force_factor		= main_back_dmper,

			damper_coeff = 30.0,

			wheel_static_friction_factor	= 0.42 ,
			wheel_side_friction_factor		= 0.95 ,
			wheel_roll_friction_factor		= 0.067 ,
			wheel_glide_friction_factor		= 0.8 ,
			wheel_damage_force_factor		= 200,
			wheel_brake_moment_max			= 18000.0,
			wheel_damage_speed 				= 135.0, -- 190 knots according to manual

			arg_post			= 3,
			arg_amortizer		= 4,
			arg_wheel_rotation	= 77,
			arg_wheel_yaw = -1,
		--	arg_wheel_damage	= 136,
			collision_shell_name  = "WHEEL_R",
		},
	}, -- gears


	disable_built_in_oxygen_system	= false, -- set this to false to enable hypoxia effects, etc
}
