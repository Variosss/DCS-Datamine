-- Please ignore all the commented-out stuff, will be cleaned up soon (TM)
--#region WIPDeclarations

declare_loadout({
	category			= CAT_PODS,
	CLSID				= "{SA342_M134_SIDE_R}",
	Picture				= "M134.png",
	PictureBlendColor	= "0xffffffff",
	displayName			= _("M134 - 6 x 7.62mm MiniGun right door"),
	Weight				= 270.4,
	Weight_Empty		= 175.68,
	Cx_pil				= 0.001220703125,
	attribute			= {wsType_Weapon, wsType_GContainer, wsType_Cannon_Cont, WSTYPE_PLACEHOLDER},
	gun_mounts			= get_predefined_aircraft_gunpod("M134_SIDE_R"),
		-- Below is the baseline definition for the M134 gun mount in case I'd need to adjust it
	-- gun_mounts			= gun_mount(
	-- 	"M_134",
	-- 	{ count = 3200 },
	-- 	{
	-- 		muzzle_pos_connector = "POINT_MGUN_01",
	-- 		ejector_pos = {-0.7, -0.1,  0.0},
	-- 		effects = {
	-- 			-- heat_ef_,
	-- 			fire_effect(43),
	-- 			smoke_effect(),
	-- 			{ name = "FeedBelt", arg_main = 552, arg_tail = 553, full_load = 3200, tail_load = 70 },
	-- 			{ name = "CustomArguments", args = {{"ArmedLight", 425}} }
	-- 		},
	-- 		barrel_circular_error = 0.005,
	-- 		turret = { name = "M_134_Turret", Door_Arg	= 44 }
	-- 	}
	-- ),
	kind_of_shipping	= 2,
	Elements = {{
		Position		= {0, 0, 0},
		ShapeName		= "ab-212_m134gunner_r",
	}},
	shape_table_data = {{
		file			= "ab-212_m134gunner_r", -- placeholder
		username		= "M134MiniGunner_R_SA342",
		index			= WSTYPE_PLACEHOLDER,
	}},
})
--#endregion WIPDeclarations