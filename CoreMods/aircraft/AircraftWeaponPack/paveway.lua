declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{GBU-24}",
	attribute		= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, 41},
	Count 			= 1,
	Cx				= 0.000793,
	Picture			= "gbu24.png",
	displayName		= _("GBU-24A/B Paveway III - 2000lb Laser Guided Bomb"),
	Weight			= 1087,
	Elements  		= {{ShapeName = "gbu-24"}},
})

BDU45LG_WARHEAD =
{
	mass					= 0,
	expl_mass				= 0,
	piercing_mass			= 0,
	other_factors			= { 0.0, 0.0, 0.0 },
	obj_factors				= { 0.0, 0.0 },
	concrete_factors		= { 0.0, 0.0, 0.0 },
	cumulative_factor		= 0.0,
	concrete_obj_factor		= 0.0,
	cumulative_thickness	= 0.0,

	transparency	= 0.5,
	color			= {2, 2, 2},
	intensity		= 10,
	duration		= 300,
	flare   		= false,
}



local windCoeff = 0
local BDU_45LGB = 
{
	category			= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, WSTYPE_PLACEHOLDER},
	name			= "BDU_45LGB",
	user_name		= _("BDU-45LGB"),
	model			= "BDU-50LGB",
    type    = 0,
    mass    = 277.0,
    hMin    = 1000.0,
    hMax    = 40000.0,
    Cx      = 0.000365,
    VyHold  = -100.0,
    Ag      = -2.0,

	shape_table_data =
	{
		{
			name     = "BDU_45LGB",
			file     =  "BDU-50LGB",
			life     = 1,
			fire     = {0, 1},
			username =  _("BDU-45LGB"),
			index    = WSTYPE_PLACEHOLDER,
		},
	},
	
	warhead = BDU45LG_WARHEAD,--predefined_warhead("BDU"),
	targeting_data =  {char_time       = 20.380000},


	scheme			= "bomb-paveway-II-afm-smoke",
	class_name		= "wAmmunitionLaserHoming",

	fm =
	{
			mass            = 277.0,
			caliber         = 0.279000,
			cx_coeff        = {1.037, 0.74, 0.6, 0.382, 1.34},
			L               = 3.276000,
			wind_time       = 1000.000000,
			wind_sigma      = windCoeff * 80.000000,
			Sw				= 0.4,
			A				= 0.36,
			Ma_x			= 0.1,
			Mw_x			= 1.0,
			maxAoa			= math.rad(7),
			finsTau			= 0.1,
			dCydA 			= {0.036, 0.036},
	},

	bang_bang_autopilot = 
	{
		omegaDumpingK = 0.8
	},
	
	LaunchDistData =
	{
		19,		8,

				100,	150,	200,	250,	300,	350,	400,	450,		
		100,	0,		0,		3000,	5550,	7575,	8375,	8975,	9025,	
		200,	0,		0,		3625,	6350,	8400,	9750,	10425,	11100,	
		400,	0,		0,		4325,	7200,	9175,	10525,	11450,	12250,	
		700,	0,		0,		5500,	8325,	10325,	11600,	12500,	13275,	
		1000,	0,		0,		6600,	9400,	11400,	12600,	13550,	14300,	
		2000,	2450,	7000,	10450,	13150,	14950,	16150,	17000,	17750,	
		3000,	4800,	10900,	14300,	16900,	18600,	19700,	20400,	21200,	
		4000,	6100,	14400,	18100,	20800,	22300,	23300,	24100,	24800,	
		5000,	7100,	17200,	21900,	24600,	26200,	27100,	27800,	28500,	
		6000,	8100,	17200,	25500,	28600,	30000,	30900,	31600,	32400,	
		7000,	8750,	17250,	28750,	32500,	33750,	34750,	35500,	36000,	
		8000,	9500,	17500,	32250,	36250,	37750,	38500,	39250,	40250,	
		9000,	10250,	17750,	35250,	39500,	41750,	42500,	43250,	44250,	
		10000,	10750,	18000,	38000,	42500,	45500,	46500,	47250,	48250,	
		11000,	11000,	18000,	39500,	45000,	48500,	50500,	51000,	52500,	
		12000,	11500,	18000,	34500,	47000,	51500,	54000,	55000,	56500,	
		13000,	11000,	18000,	31000,	49000,	53000,	57000,	59000,	60000,	
		14000,	12000,	18000,	29000,	51000,	55000,	59000,	63000,	64000,	
		15000,	12000,	18000,	28000,	48000,	57000,	61000,	66000,	68000,	
	},

	MinLaunchDistData =
	{
		19,		8,

				100,	150,	200,	250,	300,	350,	400,	450,		
		100,	0,		0,		1225,	1475,	1125,	1125,	700,	1100,	
		200,	0,		0,		1725,	1050,	1075,	1100,	1225,	1100,	
		400,	0,		0,		1800,	1825,	1825,	1825,	1825,	1825,	
		700,	0,		0,		2725,	3050,	3175,	3175,	3175,	3175,	
		1000,	0,		0,		3350,	4000,	4400,	4550,	4550,	4550,	
		2000,	2150,	3450,	4700,	5800,	6700,	7450,	8150,	8800,	
		3000,	2500,	4100,	5600,	7000,	8100,	9200,	10100,	11100,	
		4000,	2700,	4500,	6200,	7800,	9200,	10400,	11500,	12700,	
		5000,	2900,	4800,	6800,	8500,	10100,	11400,	12700,	14100,	
		6000,	3100,	5100,	7200,	9100,	10800,	12200,	13700,	15300,	
		7000,	3250,	5500,	7750,	9750,	11500,	13000,	14750,	16500,	
		8000,	3500,	5750,	7750,	10000,	12000,	13750,	15500,	17500,	
		9000,	3500,	6000,	8250,	10500,	12500,	14500,	16250,	18750,	
		10000,	3500,	6000,	8500,	11000,	13000,	15000,	17250,	19750,	
		11000,	3500,	6500,	9000,	11500,	13500,	15500,	18000,	21000,	
		12000,	3500,	6500,	9000,	11500,	14000,	16500,	19000,	22000,	
		13000,	4000,	7000,	10000,	12000,	15000,	17000,	20000,	23000,	
		14000,	4000,	7000,	10000,	13000,	14000,	18000,	21000,	24000,	
		15000,	4000,	7000,	10000,	13000,	16000,	19000,	22000,	25000,	
	},
}

declare_weapon(BDU_45LGB)

declare_loadout({
	category		=	CAT_BOMBS,
	CLSID			=	"{BDU_45LG}",
	Picture			=	"GBU12.png",
	displayName		=  _("BDU-45 LG - 500lb Practice Laser Guided Bomb"),
	attribute		=	BDU_45LGB.wsTypeOfWeapon,
	Cx_pil			=	0.000413,
	Count			=	1,
	Weight			=	BDU_45LGB.mass,
	Elements		= {{ShapeName	= BDU_45LGB.model}},
})

local BDU_45LG_x2 = {
		category		=	CAT_BOMBS,
		CLSID			=	"{BRU33_2X_BDU_45LG}",
		Picture			=	"GBU12.png",
		wsTypeOfWeapon	=	BDU_45LGB.wsTypeOfWeapon,
		displayName		=  _("BRU-33 with 2 x BDU-45 LG 500lb Practice Laser Guided Bomb"),
		attribute		=	{wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
		Cx_pil			=	0.00244140625 + BDU_45LGB.Cx,
		Count			=	2,
		Weight			=	bru_33VER_mass + 2 * BDU_45LGB.mass,
		Elements		= {	{ShapeName	= "BRU_33A",	IsAdapter  	   = true},
							{ShapeName	= BDU_45LGB.model,		connector_name = "Point02"},
							{ShapeName	= BDU_45LGB.model,		connector_name = "Point01"}
		}, -- end of Elements
	}
declare_loadout(BDU_45LG_x2)