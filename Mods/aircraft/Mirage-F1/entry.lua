local self_ID = "Mirage F1 by Aerges"

local function copyTable(src, target)
    if not target then
        target = {}
    end
	
    for i, v in pairs(src) do
        if type(v) == 'table' then
            if not target[i] then
                target[i] = {}
            end
            copyTable(v, target[i])
        else
            target[i] = v
        end
    end
	
    return target
end

declare_plugin(self_ID,
{
installed 	 		= true, -- if false that will be place holder , or advertising
dirName	  	 		= current_mod_path,
displayName  		= _("Mirage F1"),
shortName	 		= "Mirage F1",
fileMenuName 		= _("Mirage F1"),
update_id    		= "AERGES_MIRAGE-F1",
version 	 		= __DCS_VERSION__ .. " EA",
state		 		= "installed",
developerName		= _("Aerges"),
info		 		= _("The Mirage F1 is a third-generation air superiority fighter and attack aircraft, designed and built in France. It has been exported to around a dozen countries, entering combat in many of them. More than 720 units have been manufactured between 1966 and 1992."),
creditsFile  		= "credits.txt",

binaries =
{
	'ABaseF1',
	'MirageF1cmn',
	'MirageF1CE',
	'MirageF1EE',
},

Skins = 
	{
		{
			name	= "Mirage F1",
			dir		= "Skins/1"
		},
	},
Missions =
	{
		{
			name	= _("Mirage F1"),
			dir		= "Missions",
			CLSID	= "{CLSID5456456311CLSID}",	
		},
	},	
LogBook =
	{
		{
			name	= _("Mirage F1CE"),
			type	= "Mirage-F1CE",
		},
		{
			name	= _("Mirage F1EE"),
			type	= "Mirage-F1EE",
		},
	},
Options =
    {
        {
            name		= _("Mirage F1"),
            nameId		= "Mirage-F1",
            dir			= "Options",	
        },
    },		
InputProfiles =
	{
		["Mirage-F1CE"]		= current_mod_path..'/Input/Mirage-F1CE',
		["Mirage-F1EE"]		= current_mod_path..'/Input/Mirage-F1EE',
	},
})
---------------------------------------------------------------------------------------
mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_texture_path  (current_mod_path.."/Textures/Avionics-F1.zip")
mount_vfs_texture_path  (current_mod_path.."/Textures/Avionics-F1_NM.zip")
mount_vfs_texture_path  (current_mod_path.."/Textures/Avionics-F1_RoughMet.zip")
mount_vfs_texture_path	(current_mod_path .."/Skins/1/ME") --for simulator loading window

mount_vfs_liveries_path(current_mod_path .. "/Liveries")
--mount_vfs_sound_path (current_mod_path.."/Sounds")

dofile(current_mod_path.."/ViewsF1C.lua")
make_view_settings('Mirage-F1CE', 	ViewSettingsF1C, SnapViewsF1C)
make_view_settings('Mirage-F1EE', 	ViewSettingsF1C, SnapViewsF1C)

-- debug gear positions
local nose_gear_pos 						= {2.871,-2.140,0.0} --{2.862, -2.040, 0.0}
--local nose_gear_pos 						= {2.862, -3.040, 0.0}
local left_gear_pos 						= {-2.070,-1.999,-1.221}
--local left_gear_pos 						= {-2.092, -4.868, -1.221}
local right_gear_pos 						= copyTable(left_gear_pos)
right_gear_pos[3] 							= -right_gear_pos[3]

local nose_gear =
{
	--pos									= nose_gear_pos,
	arg_post								= 0, 				-- extension/retraction animation
	mass 									= 83.0,				-- not used in external FM
	drag_factor								= 0.0, 				-- drag is computed internally in FM
	damage_element 							= 83, --"WHEEL_F"
	damage_omega							= 30.0, 			-- jamming speed threshold upon impact of rotation limiter (nose wheel yaw axis rotation is meant here)
	allowable_hard_contact_length 			= 0.1,
	noise_k									= 0.4, 				-- surface noise coefficient
	wheel_ground_block_flag					= false,
	influence_of_pos_z_to_V_l_z				= false,			-- not applicable to self-attitude wheel
	
	-- shock strut
	arg_amortizer							= 1,				-- strut compression animation
	amortizer_min_length					= 0.0,
	amortizer_max_length 					= 0.3, 				-- doesn't corresponds to the current 3D)
	amortizer_basic_length 					= 0.3,
	amortizer_spring_force_factor 			= 1350000, -- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate) -- From tables
	amortizer_spring_force_factor_rate 		= 2.65,
	amortizer_static_force 					= 6500,
	amortizer_reduce_length 				= 0.004,
	amortizer_direct_damper_force_factor 	= 10000.0,--500.0,--12500.0, 	--50000.0, 			-- Calculated from the graphics
	amortizer_back_damper_force_factor 		= 8000.0,--20000.0, --3500.0, 	--13000.0, 			-- Calculated from the graphics

	-- wheel
	arg_wheel_rotation						= 101,				-- wheel rotation animation
	arg_wheel_damage						= 134,				-- wheel damage animation
	wheel_moment_of_inertia 				= 0.6, 				-- Indirect calculation
	wheel_radius 							= 0.17, 			-- F1
	wheel_axle_offset 						= 0.05,
	track_width								= 0.2,
	wheel_static_friction_factor 			= 0.9,
	wheel_side_friction_factor 				= 0.65,
	wheel_roll_friction_factor 				= 0.02, 			-- F1
	wheel_glide_friction_factor 			= 0.28,
	wheel_kz_factor							= 0.0,
	wheel_damage_force_factor 				= 250.0,
	wheel_damage_speedX						= 90.0,
	wheel_damage_delta_speedX				= 28.0,
	
	
	-- second amortizer
	--amortizer_spring2_min_length = 0.0,
	--amortizer_spring2_max_length = 0.1,
	--amortizer_spring2_basic_length = 0.1,
	--amortizer_spring2_spring_force_factor = 1000000,
	--amortizer_spring2_spring_force_factor_rate = 1.0,
	--amortizer_direct_damper2_force_factor = 800,
	--amortizer_back_damper2_force_factor = 300,
	
	-- TODO: to verify
	-- specific for self-orienting nose wheel
	arg_wheel_yaw							= 2,
	axle_angle								= 0.0,
	yaw_limit 								= math.rad(45.0), 	-- F1
	self_attitude     						= false,
	damper_coeff 							= 300.0, 			-- Will have to be tested
	moment_limit							= 0.0,
}

local main_gear = 
{
	--pos									= left_gear_pos,
	arg_post								= 5, 				-- extension/retraction animation
	mass 									= 210.0,			-- not used in external FM
	drag_factor								= 0.0, 				-- drag is computed internally in FM
	damage_element 							= 84, --"WHEEL_L"
	allowable_hard_contact_length 			= 0.2,
	noise_k									= 0.4, 				-- surface noise coefficient
	wheel_ground_block_flag					= true,
	influence_of_pos_z_to_V_l_z				= true,
	
	-- shock strut
	arg_amortizer							= 6,				-- strut compression animation
	amortizer_min_length					= 0.0,
	amortizer_max_length 					= 0.21,				-- per sources
	amortizer_basic_length 					= 0.21,
	amortizer_spring_force_factor 			= 1885000,--45000000,--2500000,
	amortizer_spring_force_factor_rate 		= 1.755,--4.0,
	amortizer_static_force 					= 30000.0,
	amortizer_reduce_length 				= 0.008,
	amortizer_direct_damper_force_factor 	= 60000.0,--42500.0,--	-- Calculated from the graphics
	amortizer_back_damper_force_factor 		= 40000.0,--13800.0,--	--
	
	-- wheel
	arg_wheel_rotation						= 103,				-- wheel rotation animation
	arg_wheel_damage						= 136,				-- wheel damage animation
	wheel_moment_of_inertia 				= 4.95, 			-- Indirect calculation
	wheel_radius 							= 0.3, 				-- F1
	wheel_axle_offset 						= 0.25,				-- F1?
	track_width								= 0.3,				-- TODO: to check
	wheel_static_friction_factor 			= 0.9,
	wheel_side_friction_factor 				= 0.65,
	wheel_roll_friction_factor 				= 0.02, 			-- F1
	wheel_glide_friction_factor 			= 0.28,
	wheel_kz_factor							= 0.0,
	wheel_damage_force_factor 				= 250.0,
	wheel_damage_speedX						= 90.0,
	wheel_damage_delta_speedX				= 28.0,
	
		-- second amortizer
	--amortizer_spring2_min_length = 0.0,
	--amortizer_spring2_max_length = 0.1,
	--amortizer_spring2_basic_length = 0.1,
	--amortizer_spring2_spring_force_factor = 4000000,
	--amortizer_spring2_spring_force_factor_rate = 1.0,
	--amortizer_direct_damper2_force_factor = 1000,--20000,
	--amortizer_back_damper2_force_factor = 400,--8000,
		
	-- specific for main wheel
	wheel_brake_moment_max 					= 8500,--5000, --According to indirect calculations
	anti_skid_installed 					= true,
	

}

local left_gear = main_gear
local right_gear = copyTable(main_gear)

-- attributes different from the left gear
--right_gear.pos							= right_gear_pos
right_gear.arg_post							= 3					-- extension/retraction animation
right_gear.arg_amortizer					= 4					-- strut compression animation
right_gear.arg_wheel_rotation				= 102				-- wheel rotation animation
right_gear.arg_wheel_damage 				= 135				-- wheel damage animation
right_gear.damage_element 					= 85 --"WHEEL_R"

-- For rigid body properties
local m_coeff = 11492 / 15000
local gyro_effect_ 								= true

-- rigid body properties
local rigid_body_default_force_max_				= 1000000.0 * m_coeff
local rigid_body_default_force_damage_			= 500000.0 * m_coeff
local rigid_body_default_spring_force_factor_	= 2400000.0 * m_coeff
local rigid_body_direct_damper_force_factor_	= 120000.0  * m_coeff
local rigid_body_back_damper_force_factor_		= 200000.0  * m_coeff

-- landing gear
local zeroize_amortizers_before_collision_check_ = true

local disable_built_in_oxygen_system_			= true

local F1_FM =
{
	self_ID,
	'MirageF1cmn',
	
	-- dynamic body properties
	
	-- center of mass (CoG) is for empty aircraft, with pilot, no unusable liquids, gear up - 7887 kg
	-- (x,y,z) in DCS axes = (x,-z,y) in AFM axes
	--center_of_mass 						= {-1.379, -0.095, 0.0},
	center_of_mass 							= {-1.425, -0.096, 0.0},
	-- (Ix,Iy,Iz,Ixy) in DCS axes = (Ix, Iz, Iy, Ixz) in AFM axes
	--moment_of_inertia 					= {8207, 72203, 67392, 2729},
	moment_of_inertia 						= {8206, 70591, 65780, 2729},
	gyro_effect 							= gyro_effect_,
	
	-- rigid body properties
	rigid_body_default_force_max			= rigid_body_default_force_max_,
	rigid_body_default_force_damage			= rigid_body_default_force_damage_,
	rigid_body_default_spring_force_factor	= rigid_body_default_spring_force_factor_,
	rigid_body_direct_damper_force_factor	= rigid_body_direct_damper_force_factor_,
	rigid_body_back_damper_force_factor		= rigid_body_back_damper_force_factor_,
	
	-- landing gear
	zeroize_amortizers_before_collision_check = zeroize_amortizers_before_collision_check_,
	suspension = {nose_gear, left_gear, right_gear},
	
	disable_built_in_oxygen_system = disable_built_in_oxygen_system_,		
}

make_flyable('Mirage-F1CE',current_mod_path..'/Cockpit/Mirage-F1/Mirage-F1CE/',F1_FM,current_mod_path..'/Comm/comm.lua')
make_flyable('Mirage-F1EE',current_mod_path..'/Cockpit/Mirage-F1/Mirage-F1EE/',F1_FM,current_mod_path..'/Comm/comm.lua')

plugin_done()-- finish declaration , clear temporal data
