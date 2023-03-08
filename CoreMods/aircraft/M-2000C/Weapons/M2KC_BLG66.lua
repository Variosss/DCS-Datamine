-- BELOUGA DEFINITION
GR_66_AC =
{
	scheme = 
	{
		cluster =
		{
				mass            = 1.200000,
				caliber         = 0.065000,
				cx_coeff        = {1.000000, 0.390000, 0.380000, 0.236000, 1.310000},
				L               = 0.343000,
				I               = 0.005784,
				Ma              = 0.049268,
				Mw              = 0.211020,
				model_name	    = "PTAB-2_5KO",
		},
		warhead		= predefined_warhead("C_5"),
	},
	cluster_scheme	= "cluster",
	name    = _("GR_66_AC"),
	type_name = _("cluster"),
}





BelougaCBU  = {
	category  		= CAT_BOMBS,
	name      		= "BLG66_BELOUGA",
	model     		= "M2000C_BLG66",
	user_name 		= _("BLG-66 Belouga"),
	wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
	scheme    		= "bomb-cassette_new",
	class_name		= "wAmmunitionCbu",
	
	type    	= 5,
	mass    	= 305.0,
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
        open_delay = 2.0,
    },
	
    launcher = 
    {
        cluster = cluster_desc("Bomb_Other",
			wsType_Bomb_Cluster,
			combine_cluster(GR_66_AC,
				{
					cluster =
					{
						count        	= 151,
						effect_count 	= 30,
						wind_sigma  	= 10,
						impulse_sigma 	= 3, -- было 20
						moment_sigma 	= 0.0001,
					}
				},
			"cluster"))
    },
	
	
	targeting_data = 
	{
		char_time = 22.0, -- Was 20.42, compensated to 22.9 as we don't use a ClusterSight
		bomblet_char_time = 22.16,	--Not used with bombsight
	},
	
	shape_table_data =
	{
		{
			name	 = "M2000C_BLG66",
			file     = "M2000C_BLG66",
			life     = 1,
			fire     = {0, 1},
			username = _("BLG-66 BELOUGA"),
			index    = WSTYPE_PLACEHOLDER,
		},
	}
	
}




Belouga = BelougaCBU


declare_weapon(Belouga)

declare_loadout({
	category		=	CAT_BOMBS,
	CLSID			= 	"{BLG66_BELOUGA_AC}",
	Picture			=	"Mk20.png",
	displayName		=	_("BLG-66-AC Belouga"),
	wsTypeOfWeapon	=	Belouga.wsTypeOfWeapon,
	attribute		=	Belouga.wsTypeOfWeapon,
	Count			=	1,
	Weight			=	305,
	Elements		=	{
		[1]	= {
			DrawArgs = {
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{0,	0,	0},
			ShapeName	=	"M2000C_BLG66",
		}, 
	}, -- end of Elements
})
