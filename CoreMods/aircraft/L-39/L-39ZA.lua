local function default_loadout_variants(station,opposite_station)
	local ret_val = { symmetric		 ("{FB3CE165-BF07-4979-887C-92B87F13276B}"	,opposite_station,0.3),-- FAB-100
					  symmetric		 ("{0511E528-EA28-4caf-A212-00D1408DF10A}"	,opposite_station,0.3,{0, 0.05, 0}),-- SAB-100 
					  symmetric		 ("{3C612111-C7AD-476E-8A8E-2485812F4E5C}"	,opposite_station,0.3),-- FAB-250
					  symmetric		 ("{FAB_250_M62}"							,opposite_station,0.3),-- FAB-250-M62
					  symmetric		 ("{OFAB_100_Jupiter}"						,opposite_station,0.3),-- OFAB_100_Jupiter
					  symmetric		 ("{P-50T}"									,opposite_station,0.2),-- P-50T
					  symmetric		 ("{FAB-100x2}"								,opposite_station,0.41),
					  symmetric		 ("{UB-16-57UMP}"							,opposite_station,0.41),
					  symmetric		 ("{PK-3}"									,opposite_station,0.41),
	}
	return ret_val	
end

local function add(tbl_to,tbl_src)
	tbl_to[#tbl_to + 1] = tbl_src
end

local function ZA_inboard (station,opposite_station)
	local  ret_val = default_loadout_variants(station,opposite_station)
	add(ret_val,	symmetric("{PTB_150L_L39}" ,opposite_station,0.41))-- 150 L drop tank
	add(ret_val,	symmetric("{PTB_350L_L39}" ,opposite_station,0.41))-- 350 L drop tank
	return ret_val
end

local function ZA_outboard (station,opposite_station)
	local ret_val = default_loadout_variants(station,opposite_station)
	add(ret_val,	symmetric("{R-3S}" 			,opposite_station,0.41))
	add(ret_val,	symmetric("{APU-60-1_R_60M}",opposite_station,0.41))
	add_smokes(ret_val,opposite_station)
	return ret_val
end

local function make_M559(element_shape,element_mass,tbl)
	local tbl 			= tbl or tbl
	tbl.category		= CAT_BOMBS
	tbl.attribute		= {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER}
	tbl.Count			= 2	--count of wepon
	tbl.Cx_pil			= 0.0025 -- drag index of whole rack
	tbl.Weight			= 100 + 2 * element_mass
	tbl.Elements		=
	{
		{  ShapeName = "m559", IsAdapter = true },
		{  ShapeName =	element_shape,	connector_name = "point1_fab"}, 
		{  ShapeName =	element_shape,	connector_name = "point2_fab"}, 
	}
	return tbl
end


OFAB_100_Jupiter =
{
	category		= CAT_BOMBS,
	name			= "OFAB-100 Jupiter",
	model			= "ofab-100-110tu",
	user_name		= _("OFAB-100 Jupiter - 100kg GP Bomb HD"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme			= "bomb-parashute",
	class_name		= "wAmmunitionBallute",
	type			= 0,
	mass			= 121,
	hMin			= 50,
	hMax			= 12000,
	Cx				= 0.00018,
	VyHold			= -100,
	Ag				= -1.23,
	Reflection		= 0.015,

	fm = {
		mass		= 121,
		caliber		= 0.273,
		cx_coeff	= {1, 0.32, 0.71, 0.15, 1.28},
		cx_factor	= 100,
		L			= 1.05,
		I			= 33.282267,
		Ma			= 2.746331,
		Mw			= 2.146083,
		wind_time	= 1000,
		wind_sigma	= 80,
	},

	control = {
		open_delay = 0.2,
	},

	warhead = simple_warhead(90),-- 44 + bonus of fragments

	shape_table_data = {{
		file	= "ofab-100-110tu",
		index	= WSTYPE_PLACEHOLDER,
	}},

	targeting_data = {
		char_time = 20.47,		--* OK
		chute_char_time = 49.6,	--* OK
		chute_open_time = 0.2,
	},
}
declare_weapon(OFAB_100_Jupiter)

declare_loadout(make_M559(OFAB_100_Jupiter.model,OFAB_100_Jupiter.mass,{
	CLSID			= "{FAB-100x2}",
	wsTypeOfWeapon  =  OFAB_100_Jupiter.wsTypeOfWeapon, 
	Picture			=	"OFAB-100_Jupiter.png",
	displayName		= _("2 x OFAB-100 Jupiter - 100kg GP Bombs HD"),
}))


declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{OFAB_100_Jupiter}",
	attribute		= OFAB_100_Jupiter.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= OFAB_100_Jupiter.Cx,
	Picture			= "OFAB-100_Jupiter.png",
	displayName		= OFAB_100_Jupiter.user_name,
	Weight			= OFAB_100_Jupiter.mass,
	Elements  		= {{ShapeName = OFAB_100_Jupiter.model}},
})

declare_loadout({
	category 		=   CAT_PODS,
	CLSID	 		=  "{PK-3}",
	attribute		=   {wsType_Weapon,wsType_GContainer,wsType_Cannon_Cont,WSTYPE_PLACEHOLDER},
	Picture			=	"pk3.png",
	displayName		=	_("PK-3 - 7.62mm GPMG"),
	Weight			=	218,
	Cx_pil			=	0.001220703125,
	Elements  		= {{ShapeName = "PK-3"}},
	kind_of_shipping = 2,--SOLID_MUNITION
	gun_mounts		= {
		gun_mount("PK_mix_1",{ count = 1000},{muzzle_pos_connector = "Point_Gun"  ,ejector_pos_connector = "extractor1",barrel_circular_error = 0.005, effects = { fire_effect(6,0.05),smoke_effect()}}),
		gun_mount("PK_mix_2",{ count = 1000},{muzzle_pos_connector = "Point_Gun_1",ejector_pos_connector = "extractor2",barrel_circular_error = 0.005, effects = { fire_effect(5,0.05),smoke_effect()}}),
		gun_mount("PK_mix_3",{ count = 1000},{muzzle_pos_connector = "Point_Gun_2",ejector_pos_connector = "extractor1",barrel_circular_error = 0.005, effects = { fire_effect(4,0.05),smoke_effect()}})
	},
	shape_table_data = {{file  	 = 'PK-3';	username = 'PK-3';index    =  WSTYPE_PLACEHOLDER;}}
})


--gun deflector tuning to have zero moment 
local dx =  4.11726952  - 0.26850316145142072  -- difference between nozzle point and  center of mass 
local dy = -0.532874584 - 0.25959990759348101  -- difference between nozzle point and  center of mass 


function l39za_settings(unit_name, display_name)
	local l39za_local_setting =
	{
		Shape 										= 	'L-39_ZA',
		Name										=	unit_name,
		Picture										=	'L-39ZA.png',	
		DisplayName									=	display_name or _(unit_name),
		WorldID										=    61,
		M_empty										=	3614, 
		M_max										=	5600,
		M_nominal									=	5600,
		livery_entry								=   "L-39ZA",
		
		country_of_origin = "CZE",

		Pylons =	{
		    pylon(1, 0, 0.184040, -0.359076, -2.557844, {arg = 308,arg_value = 0,connector = "Pylon_1",DisplayName = "1"},ZA_outboard(1,5)),
		    pylon(2, 0, 0.202975, -0.391420, -1.906432, {arg = 309,arg_value = 0,connector = "Pylon_2",DisplayName = "2"},ZA_inboard (2,4)),
			central_smoke_slot(3),
		    pylon(4, 0, 0.202975, -0.391420, 1.906432 , {arg = 310,arg_value = 0,connector = "Pylon_3",DisplayName = "3"},ZA_inboard (4,2)),
		    pylon(5, 0, 0.184040, -0.359076,  2.557844, {arg = 311,arg_value = 0,connector = "Pylon_4",DisplayName = "4"},ZA_outboard(5,1)),
		},
		Guns = {gun_mount("GSh_23_2",
				{ 
					count = 150
				},
				{
					muzzle_pos_connector  = "Gun_point_1",
					ejector_pos_connector = "ejector_1",
					ejector_dir			  = {20,0,0},
					impulse_vec_rot  	  = {z = math.atan(dy/dx)};--rotation of impulse vector respect of muzzle break geometry
					drop_cartridge   	  = 203;
					max_burst_length 	  = 1e6;
				})
		},					
		Countries = {} , --prevent adding this unit for all countries , it is already added in db_countries
	}
	return l39za_local_setting
end

make_albatros(l39za_settings('L-39ZA',_('L-39ZA')))