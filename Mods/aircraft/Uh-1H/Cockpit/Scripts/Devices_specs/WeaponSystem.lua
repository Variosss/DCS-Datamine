dofile(LockOn_Options.script_path.."AI/AI_Gunners.lua")

--UnlimitedWeapon = true
GunPodCutOffAzimuth = math.rad(-12.0)

ElecConsumerParamsLights = {0.5, true}

NURS_Interval = 0.08

gun_rel_threshhold = 0.01

gun_rel_sensitivity_vert = 1;
gun_rel_sensitivity_hor = 1;
gun_rel_sensitivity_vert_bound = 1;
gun_rel_sensitivity_hor_bound = 1;

dofile("Scripts/Database/wsTypes.lua")

Rockets_Order = {
	{launchers = {XM_158_HYDRA_70_MK1,
				XM_158_HYDRA_70_MK5,
				XM_158_HYDRA_70_M151,
				XM_158_HYDRA_70_M156,
				XM_158_HYDRA_70_M274,
				XM_158_HYDRA_70_M257}, 
	orders = {{1, order = {7,1,4,6,3,5,2}}, 
			  {2, order = {2,5,1,4,6,3,7}}} --{pilon_num, {order}}
	},
	{launchers = {M261_HYDRA_70_M151,
				M261_HYDRA_70_M156}, 
	orders = {{1, order = {1,8,14,12,7,18,2,4,16,11,5,13,17,15,3,10,9,6,19}}, 
			  {2, order = {1,12,7,8,14,2,18,6,17,10,5,13,16,15,3,11,9,4,19}}} --{pilon_num, {order}}]]
	}
}

Door_Head_Pos = {}
Door_Head_Pos[M134_SIDE_L] =
{
	pivot = {-0.121463, 0.19,  -1.39},
	d_v   = {-0.68, 0.0168, 0.002}
}

Door_Head_Pos[M134_SIDE_R] =
{
	pivot = {-0.121463, 0.19,  1.39},
	d_v   = {-0.68, 0.0168, -0.002}
}

Door_Head_Pos[M60_SIDE_L] =
{
	pivot = {-0.121377, -0.138260, -1.514663},
	d_v   = {-0.57, 0.188, 0.002},
}

Door_Head_Pos[M60_SIDE_R] =
{
	pivot = {-0.126, -0.138260,  1.477076},
	d_v   = {-0.57, 0.188, -0.002}
}

Door_Head_Pos_default_left =
{
	pivot = {-0.126, -0.138260,  -1.514663},
	d_v   = {-0.7, 0.188, -0.002}
}

Door_Head_Pos_default_right =
{
	pivot = {-0.126, -0.138260,  1.477076},
	d_v   = {-0.7, 0.188, -0.002}
}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()