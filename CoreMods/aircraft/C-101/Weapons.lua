--------------------------------------------------SMOKE SYSTEM-----------------------------------------------------------------
declare_loadout(
	{
		category		= CAT_PODS,
		CLSID			= "{SMOKE-SYSTEM-AVIOJET}",
		Picture	= "white_color.png",
		PictureBlendColor= '0xffffffff',		
		displayName		= _("Smoke System (White Smoke)"),
		
		attribute	=	{4,	15,	50,	WSTYPE_PLACEHOLDER},			
		Smoke  = {
			alpha = 180,
			r  = 255,
			g  = 255,
			b  = 255,
			dx = -1.455,
			dy = -0.062
		},
		
		shape_table_data = 
		{
			{
				name 	= "smoke-pod",
				file	= "smoke_pod";
				life	= 1;
				fire	= { 0, 1};
				username	= "SMOKE_SYSTEM_AVIOJET";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Weight			= 1.0,
		Count 			= 1,
		Cx_pil			= 0.0,
		Elements		={{
								ShapeName	=	"smoke_pod", 
								Position	=	{0,- 0.059317,0}, 
								DrawArgs	=	{[3] = {3,0.1}}
							}}
	}
)

declare_loadout(
	{
		category		= CAT_PODS,
		CLSID			= "{SMOKE-RED-AVIOJET}",
		Picture	= "red_color.png",
		PictureBlendColor= '0xff0000ff',		
		displayName		= _("Smoke System red colorant"),
		
		attribute	=	{4,	15,	50,	WSTYPE_PLACEHOLDER},			
		Smoke  = {
			alpha = 180,
			r  = 255,
			g  = 0,
			b  = 0,
			dx = -1.455,
			dy = -0.062
		},
		
		shape_table_data = 
		{
			{
				name 	= "smoke-pod",
				file	= "smoke_pod";
				life	= 1;
				fire	= { 0, 1};
				username	= "SMOKE_RED_AVIOJET";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Weight			= 32.6, -- bottle: 14 kg, colorant: 20 l
		Count 			= 1,
		Cx_pil			= 0.0,
		Elements		={{
								ShapeName	=	"smoke_pod", 
								Position	=	{0,- 0.059317,0}, 
								DrawArgs	=	{[3] = {3,0.1}}
							}}
	}
)

declare_loadout(
	{
		category		= CAT_PODS,
		CLSID			= "{SMOKE-YELLOW-AVIOJET}",
		Picture	= "yellow_color.png",
		PictureBlendColor= '0xffe600ff',			
		displayName		= _("Smoke System yellow colorant"),
		
		attribute	=	{4,	15,	50,	WSTYPE_PLACEHOLDER},			
		Smoke  = {
			alpha = 180,
			r  = 255,
			g  = 230,
			b  = 0,
			dx = -1.455,
			dy = -0.062
		},
		
		shape_table_data = 
		{
			{
				name 	= "smoke-pod",
				file	= "smoke_pod";
				life	= 1;
				fire	= { 0, 1};
				username	= "SMOKE_YELLOW_AVIOJET";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Weight			= 32.6, -- bottle: 14 kg, colorant: 20 l
		Count 			= 1,
		Cx_pil			= 0.0,
		Elements		={{
								ShapeName	=	"smoke_pod", 
								Position	=	{0,- 0.059317,0}, 
								DrawArgs	=	{[3] = {3,0.1}}
							}}
	}
)
--------------------------------------------------SMOKE SYSTEM-----------------------------------------------------------------




---------------------------------------------------BOMBS------------------------------------------------------------------

--------------------------------------------------BIN-200-----------------------------------------------------------------
local BIN_200 = {
	category  = CAT_BOMBS,
	name      = "BIN_200",
	model     = "BIN-200",
	user_name = _("BIN-200 - 200kg Napalm Incendiary Bomb"),
	wsTypeOfWeapon = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme    = "bomb-common",
	type      = 0,
    mass      = 200,
    hMin      = 1000.0,
    hMax      = 12000.0,
    Cx        = 0.00035,
    VyHold    = -100.0,
    Ag        = -1.23,

	fm = {
        mass            = 200,
        caliber         = 0.325000,
        cx_coeff        = {1.000000, 0.390000, 0.600000, 0.168000, 1.310000},
        L               = 2.500000,
        I               = 220.833333,
        Ma              = 0.290638,
        Mw              = 2.769849,
        wind_time       = 1000.000000,
        wind_sigma      = 100.000000,
        
        cx_factor       = 300,
    },
  
	warhead = {
		mass                 = 20,
		expl_mass            = 20,
		other_factors        = {1, 1, 1},
		obj_factors          = {1, 1},
		concrete_factors     = {1, 1, 1},
		cumulative_factor    = 0,
		concrete_obj_factor  = 0,
		cumulative_thickness = 0,
		piercing_mass        = 5,
		caliber              = 200,
	},
	
	

	-- velK is calibrated to get arming time of 0.8 seconds at initial bomb speed of 150 m/s (540 km/h)
	arming_vane = {enabled = true, velK = 0.00834},
	-- overriding default setting (delay is enabled for all bombs by default)
	arming_delay = {enabled = false, delay_time = 0},
	
	shape_table_data = {
		{
			name     = "BIN_200",
			file     = "BIN-200",
			life     = 1,
			fire     = {0, 1},
			username = "BIN-200",
			index    = WSTYPE_PLACEHOLDER,
		},
	},
 
	targeting_data = {
		char_time = 20.87, -- characteristic time for sights 
	},
}
declare_weapon(BIN_200)

declare_loadout(
{
	category 		= CAT_BOMBS,
	CLSID	 		= "BIN_200",
	attribute		= BIN_200.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= BIN_200.Cx,
	Picture			= "BIN200.png",		-- TODO: "FAB50.png",
	displayName		= BIN_200.user_name,
	Weight			= BIN_200.mass,
	Elements  = {
		{
			ShapeName = "BIN-200",
		}, 
	},
}
)
--------------------------------------------------BR_250------------------------------------------------------------------
local BR_250 = {
	category  = CAT_BOMBS,
	name      = "BR_250",
	model     = "BR-250",
	user_name = _("BR-250 - 250kg GP Bomb LD"),
	wsTypeOfWeapon = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme    = "bomb-common",
        type    = 0,
        mass    = 250,
        hMin    = 100.0,
        hMax    = 12000.0,
        Cx      = 0.00025,
        VyHold  = -100.0,
        Ag      = -1.23,

	fm = {
            mass            = 250,
            caliber         = 0.273000,
            cx_coeff        = {1.000000, 0.290000, 0.710000, 0.140000, 1.280000},
            L               = 2.210000,
            I               = 94.425933,
            Ma              = 2.746331,
            Mw              = 2.146083,
            wind_time       = 1000.000000,
            wind_sigma      = 80.000000,
    },
  
	warhead = {
		mass                 = 25,
		expl_mass            = 25,
		other_factors        = {1, 1, 1},
		obj_factors          = {1, 1},
		concrete_factors     = {1, 1, 1},
		cumulative_factor    = 0,
		concrete_obj_factor  = 0,
		cumulative_thickness = 0,
		piercing_mass        = 5,
		caliber              = 200,
	},

	-- velK is calibrated to get arming time of 0.8 seconds at initial bomb speed of 150 m/s (540 km/h)
	arming_vane = {enabled = true, velK = 0.00834},
	-- overriding default setting (delay is enabled for all bombs by default)
	arming_delay = {enabled = false, delay_time = 0},
	
	shape_table_data = {
		{
			name     = "BR_250",
			file     = "BR-250",
			life     = 1,
			fire     = {0, 1},
			username = "BR-250",
			index    = WSTYPE_PLACEHOLDER,
		},
	},
 
	targeting_data = {
		char_time = 20.87, -- characteristic time for sights 
	},
}
declare_weapon(BR_250)

declare_loadout(
{
	category 		= CAT_BOMBS,
	CLSID	 		= "BR_250",
	attribute		= BR_250.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= BR_250.Cx,
	Picture			= "br250.png",		-- TODO: "FAB50.png",
	displayName		= BR_250.user_name,
	Weight			= BR_250.mass,
	Elements  = {
		{
			ShapeName = "BR-250",
		}, 
	},
}
)
--------------------------------------------------BR_500-------------------------------------------------------------------
local BR_500 = {
	category  = CAT_BOMBS,
	name      = "BR_500",
	model     = "BR-500",
	user_name = _("BR-500 - 500kg GP Bomb LD"),
	wsTypeOfWeapon = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme    = "bomb-common",
        type    = 0,
        mass    = 500,
        hMin    = 200.0,
        hMax    = 12000.0,
        Cx      = 0.00035,
        VyHold  = -100.0,
        Ag      = -1.23,

	fm = {
            mass            = 500,
            caliber         = 0.356000,
            cx_coeff        = {1.000000, 0.290000, 0.710000, 0.130000, 1.280000},
            L               = 3.000000,
            I               = 340.500000,
            Ma              = 2.746331,
            Mw              = 2.146083,
            wind_time       = 1000.000000,
            wind_sigma      = 150.000000,
    },
  
	warhead = {
		mass                 = 51,
		expl_mass            = 51,
		other_factors        = {1, 1, 1},
		obj_factors          = {1, 1},
		concrete_factors     = {1, 1, 1},
		cumulative_factor    = 0,
		concrete_obj_factor  = 0,
		cumulative_thickness = 0,
		piercing_mass        = 5,
		caliber              = 200,
	},

	-- velK is calibrated to get arming time of 0.8 seconds at initial bomb speed of 150 m/s (540 km/h)
	arming_vane = {enabled = true, velK = 0.00834},
	-- overriding default setting (delay is enabled for all bombs by default)
	arming_delay = {enabled = false, delay_time = 0},
	
	shape_table_data = {
		{
			name     = "BR_500",
			file     = "BR-500",
			life     = 1,
			fire     = {0, 1},
			username = "BR-500",
			index    = WSTYPE_PLACEHOLDER,
		},
	},
 
	targeting_data = {
		char_time = 20.87, -- characteristic time for sights 
	},
}
declare_weapon(BR_500)

declare_loadout(
{
	category 		= CAT_BOMBS,
	CLSID	 		= "BR_500",
	attribute		= BR_500.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= BR_500.Cx,
	Picture			= "br500.png",		-- TODO: "FAB50.png",
	displayName		= BR_500.user_name,
	Weight			= BR_500.mass,
	Elements  = {
		{
			ShapeName = "BR-500",
		}, 
	},
}
)
-----------------------------------------------------GUNS----------------------------------
function m3_browing(tbl)

	tbl = gun_mount(
		"ANM3", { count = 220, max_burst_length = 220 }, {
			muzzle_pos_connector = tbl.muzzle_pos_connector or "Gun_point",
			ejector_pos = tbl.ejector_pos or {-1.4, -0.15, 0.0},
			ejector_dir = {0, -5, 0},
			supply_position = tbl.supply_position or {0,  0.3, -0.3},
			effects = {
				{ name = "FireEffect"     , arg 		 = tbl.effect_arg_number or 436 },
				{ name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
				{ name = "SmokeEffect"}
			}
		}
	)
	tbl.category = CAT_GUN_MOUNT
	tbl.name 	 = "m3_browning"

	tbl.aft_gun_mount 			= false
	tbl.azimuth_initial 		= tbl.azimuth_initial    or 0
	tbl.elevation_initial 		= tbl.elevation_initial  or 0
	tbl.muzzle_pos				= tbl.muzzle_pos 		 or  {0,0,0} -- all position from connector
	return declare_weapon(tbl)
end

function DEFA_553(tbl)

	tbl = gun_mount(
		"DEFA553", { count = 130, max_burst_length = 130 }, {
			muzzle_pos_connector = tbl.muzzle_pos_connector or "Gun_point",
			ejector_pos = tbl.ejector_pos or {-1.7, -0.15, 0.0},
			ejector_dir = {0, -5, 0},
			supply_position = tbl.supply_position or {0,  0.3, -0.3},
			effects = {
				{ name = "FireEffect"     , arg 		 = tbl.effect_arg_number or 436 },
				{ name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
				{ name = "SmokeEffect"}
			}
		}
	)
	tbl.category = CAT_GUN_MOUNT
	tbl.name 	 = "DEFA_553"

	tbl.aft_gun_mount 			= false
	tbl.azimuth_initial 		= tbl.azimuth_initial    or 0
	tbl.elevation_initial 		= tbl.elevation_initial  or 0
	tbl.muzzle_pos				= tbl.muzzle_pos 		 or  {0,0,0} -- all position from connector
	return declare_weapon(tbl)
end

declare_loadout({
	category 		=   CAT_PODS,
	CLSID	 		=  "{C-101-DEFA553}",
	attribute		=   {wsType_Weapon,wsType_GContainer,wsType_Cannon_Cont,WSTYPE_PLACEHOLDER},
	Picture			=	"DEFA.png",
	displayName		=	_("DEFA-553 - 30mm Revolver Cannon"),
	Weight			=	218,
	Cx_pil			=	0.001220703125,
	Elements  		= {{ShapeName = "C-101-DEFA553"}},
	kind_of_shipping = 2,--SOLID_MUNITION
	gun_mounts		= {
			DEFA_553({
			muzzle_pos_connector = "Point_Gun", 
			effect_arg_number = 1050,
			azimuth_initial = 0,
			elevation_initial = 0,
			supply_position = {2, -0.3, -0.4}})  
			},
	shape_table_data = {{file  	 = 'C-101-DEFA553';	username = 'DEFA-553';index    =  WSTYPE_PLACEHOLDER;}}
})

declare_loadout({
	category 		=   CAT_PODS,
	CLSID	 		=  "{AN-M3}",
	attribute		=   {wsType_Weapon,wsType_GContainer,wsType_Cannon_Cont,WSTYPE_PLACEHOLDER},
	Picture			=	"ANM3.png",
	displayName		=	_("AN-M3 - 2*Browning Machine Guns 12.7mm"),
	Weight			=	218,
	Cx_pil			=	0.001220703125,
	Elements  		= {{ShapeName = "AN-M3"}},
	kind_of_shipping = 2,--SOLID_MUNITION
	gun_mounts		= {
			m3_browing({
			muzzle_pos_connector = "Point_Gun"  , 
			effect_arg_number = 1051,
			azimuth_initial = 0,
			elevation_initial = 0,
			supply_position = {2, -0.3, -0.4}}),
			
			m3_browing({
			muzzle_pos_connector = "Point_Gun_1"  , 
			effect_arg_number = 1052,
			azimuth_initial = 0,
			elevation_initial = 0,
			supply_position = {2, -0.3, -0.4}})
	},
			
	shape_table_data = {{file  	 = 'AN-M3';	username = 'AN-M3';index    =  WSTYPE_PLACEHOLDER;}}
})
----------------------------------BDU-33------------------------------
	
declare_loadout({
				category  = CAT_BOMBS,
				CLSID	=	"CBLS-200",
				Picture	=	"bdu-33.png",
				wsTypeOfWeapon	=	{4,	5,	9,	69},
				displayName	=	_("4*BDU-33 - AF/B37K Rack with 4*25lb Practice Bomb LD"),
				attribute	=	{4,	5,	32,	114},
				Cx_pil	=	0.002,
				Count	=	4,
				Weight	=	84.4,
				Elements= {	{ShapeName	= "CBLS-200",	IsAdapter  	   = true},
							{ShapeName	= "BDU-33",		connector_name = "BDU-33-F-L"},
							{ShapeName	= "BDU-33",		connector_name = "BDU-33-F-R"},
							{ShapeName	= "BDU-33",		connector_name = "BDU-33-B-L"},
							{ShapeName	= "BDU-33",		connector_name = "BDU-33-B-R"},

		}, -- end of Elements
})

-------------------------- BLG66 BELUGA----------------------------------------
BELOUGA_DATA =
{
	scheme = 
	{
		cluster =
		{
				mass            = 1.200000, -- old = 0.590000,
				caliber         = 0.065000, -- old = 0.053000,
				cx_coeff        = {1.000000, 0.390000, 0.380000, 0.236000, 1.310000},
				L               = 0.343000,
				I               = 0.005784,
				Ma              = 0.049268,
				Mw              = 0.211020,
				
				model_name	    = "PTAB-2_5KO",
		},
		
		warhead		= predefined_warhead("C_5"), -- OLD MK118
		
	},
	cluster_scheme	= "cluster",
	name    = _("BLG-66"),
	type_name = _("cluster"),
}

BelougaBomb  = {
	category  		= CAT_BOMBS,
	name      		= "BELOUGA",
	model     		= "BELOUGA",
	user_name 		= _("Belouga"),
	wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
	scheme    		= "bomb-cassette",
	class_name		= "wAmmunition",
	
	type    	= 5,
	mass    	= 290.0,
	hMin    	= 60.96,
	hMax    	= 5000.0,
	Cx      	= 0.000413,
	VyHold  	= -100.0,
	Ag      	= -1.23,
	explMass	= 94.0,
	
	fm = {
        mass            = 290.000000,
        caliber         = 0.360000,
        cx_coeff        = {1.000000, 0.390000, 0.600000, 0.168000, 1.310000},
        L               = 2.340000,
        I               = 101.298600,
        Ma              = 0.197848,
        Mw              = 1.987409,
        wind_time       = 1000.000000,
        wind_sigma      = 100.000000,
	},
	
	control = 
    {
        open_delay = 1.30,
    },
	
    launcher = 
    {
        cluster = cluster_desc(
			"Bomb_Other", 
			wsType_Bomb_Cluster, 
			combine_cluster(
				BELOUGA_DATA, {
					cluster = {
						count			= 151,
						effect_count	= 20,
						wind_sigma		= 5,
						impulse_sigma	= 5, -- было 20
						moment_sigma	= 0.0001,
					}
				}, 
				"cluster"
			)
		)

	},
	
	targeting_data = 
	{
	    v0 = 200.0,
		data =
		{
			{1.000000, 20.200000, 0.000000},
			{10.000000, 20.387832, 0.000049},
			{20.000000, 20.411080, -0.000119},
			{30.000000, 20.417762, -0.000146},
			{40.000000, 20.418872, -0.000155},
			{50.000000, 20.422678, -0.000196},
			{60.000000, 20.422795, -0.000193},
			{70.000000, 20.424225, -0.000193},
			{80.000000, 20.423192, -0.000183},
			{90.000000, 20.425867, -0.000199},
			{100.000000, 20.430273, -0.000180},
			{200.000000, 20.622970, -0.000053},
			{300.000000, 20.857516, -0.000047},
			{400.000000, 21.057872, -0.000108},
			{500.000000, 21.223882, -0.000184},
			{600.000000, 21.362917, -0.000257},
			{700.000000, 21.481392, -0.000324},
			{800.000000, 21.583711, -0.000385},
			{900.000000, 21.673304, -0.000438},
			{1000.000000, 21.752745, -0.000486},
			{1100.000000, 21.823816, -0.000529},
			{1200.000000, 21.887984, -0.000567},
			{1300.000000, 21.946335, -0.000601},
			{1400.000000, 21.999764, -0.000632},
			{1500.000000, 22.048955, -0.000659},
			{1600.000000, 22.094484, -0.000684},
			{1700.000000, 22.136835, -0.000706},
			{1800.000000, 22.176353, -0.000726},
			{1900.000000, 22.213413, -0.000743},
			{2000.000000, 22.248243, -0.000759},
			{3000.000000, 22.514201, -0.000834},
			{4000.000000, 22.696000, -0.000852},
			{5000.000000, 22.836800, -0.000867},
			{6000.000000, 22.954552, -0.000900},
			{7000.000000, 23.058133, -0.000956},
			{8000.000000, 23.152369, -0.001030},
			{9000.000000, 23.239969, -0.001118},
			{10000.000000, 23.322436, -0.001221},
		}        
	},
	
	shape_table_data =
	{
		{
			name	 = "BELOUGA",
			file     = "BELOUGA",
			life     = 1,
			fire     = {0, 1},
			username = _("Belouga"),
			index    = WSTYPE_PLACEHOLDER,
		},
	}
	
}

declare_weapon(BelougaBomb)

declare_loadout({
	category		=	CAT_BOMBS,
	CLSID			= 	"{BLG66_BELOUGA}",
	Picture			=	"Mk20.png",
	displayName		=	_("Belouga"),
	wsTypeOfWeapon	=	BelougaBomb.wsTypeOfWeapon,
	attribute		=	BelougaBomb.wsTypeOfWeapon,
	Count			=	1,
	Weight			=	290,
	Elements		=	{
		[1]	= {
			DrawArgs = {
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{0,	0,	0},
			ShapeName	=	"BELOUGA",
		}, 
	}, -- end of Elements
})