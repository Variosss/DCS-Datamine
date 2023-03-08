dofile(LockOn_Options.script_path.."AI/AI_utility.lua")

S_INIT 			= 0
S_WAIT			= 1
S_ENGAGE 		= 2
S_ACTIVE	    = 3
S_DEATH_ANIM	= 4
S_DEAD			= 5
S_LOAD			= 6
S_UNLOAD		= 7

function fill_side_controller(pylon_, gun_num_, azimuth_limit_, elevation_limit_)
return {
	handler = {
		name = "GunHandler",
		location = {pylon_,gun_num_}, 
	},
	guidance = {
		name = "PilonCannonSight",
		location = {pylon_,gun_num_}, 
		FOF =  { 
			azimuth = azimuth_limit_,
			elevation = elevation_limit_
		},
	},
	Aiming_T = 0.3,
}
end

function fill_side_states(d_arg_, g_arg_, az_arg_, elev_arg_, dead_arg_, hide_gunner_arg_, collision_box_arg_)
return {
	[S_ENGAGE] = {
		--Enagage -- empty because no actions
	},

	[S_ACTIVE] = {
		name = "Cannon",
		max_sight_deviation = {math.rad(1.0), math.rad(1.0)}, -- {azimuth,elevation}
		average_burst = 2.0, -- in sec
		gunner_model_arg = hide_gunner_arg_
	},

	[S_DEATH_ANIM] = {
		name = "AnimateModel",
		args = {
			model_animation(dead_arg_,0.0,1.0,0.2),
		}
	},
	
	[S_DEAD] = {
		name = "GunnerDead",
	},
	
	[S_LOAD] = {
		name = "InitModel",
		args = {
			model_init(az_arg_,0.0),
			model_init(elev_arg_,0.0),	
			model_init(g_arg_,-0.7),
			model_init(d_arg_,0.0),
			model_init(collision_box_arg_,0.0)
		}
	},
	
	[S_UNLOAD] = {
		name = "GunnerUnload",
		args = {
			model_init(collision_box_arg_,1.0),
		}
	},
}
end

function fill_side_state_matrix(d_arg_, g_arg_, dead_arg_)
return {
	--[[INIT]]	{[S_LOAD] = s_cnds({{name="IsPresent", value = true}}),
				 [S_UNLOAD] = s_cnds({{name="IsPresent", value = false}})
				},
				 
	--[[WAIT]]	{[S_ENGAGE] = s_cnds({EngCmd}),
				 [S_DEATH_ANIM] = s_cnds({{name="IsDead"}}),
				 },
	
	--[[ENGAGE]]{[S_ACTIVE]= s_cnds({EngCmd})},
	
	--[[FIRE]] {[S_WAIT] = s_cnds({DEngCmd}),
				[S_DEATH_ANIM] = s_cnds({{name="IsDead"}}),
				},

	--[[DEATH ANIM]] {[S_DEAD] = s_cnds({arg_cnd("EG",dead_arg_,1.0)})},
	
	--[[DEAD]]			{},
			
	--[[LOAD]]		{[S_WAIT] = s_cnds({{name = "OperatorJMP"}})},
	
	--[[CLOSE DOOR FANTOM]] 
				    { 
						[S_UNLOAD] = s_cnds({arg_cnd("E",d_arg_,0.0)}),
					},

}
end
