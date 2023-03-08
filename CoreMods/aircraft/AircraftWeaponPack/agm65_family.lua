local function calcPiercingMass(warhead)
	warhead.piercing_mass  = warhead.mass;
	if (warhead.expl_mass/warhead.mass > 0.1) then
		warhead.piercing_mass  = warhead.mass/5.0;
	end
end

function HE_penetrating_warhead(power,caliber)
	local res = {};
	
	res.caliber = caliber;
    res.expl_mass = power;
	res.mass = res.expl_mass;
    res.other_factors = { 0.5, 0.5, 0.5 };
    res.obj_factors = {1, 1};
    res.concrete_factors = {1, 1, 1};
    res.concrete_obj_factor = 2.0;
	res.cumulative_factor = 0.0;    
    res.cumulative_thickness = 0.0;
    
    calcPiercingMass(res)
	return res;
end


local AGM_65F =
{
	category		= CAT_MISSILES,
	name			= "AGM_65F", -- AGM-65F
	user_name		= _("AGM-65F"),
	class_name = "wAmmunitionSelfHoming",
	scheme = "AGM-65",
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
	model			= "AGM-65F",
	
	mass			= 301,
	Escort = 0,
    Head_Type = 5,
	sigma = {5, 5, 5},
	M = 301.0,
	H_max = 10000.0,
	H_min = -1,
	Diam = 305.0,
	Cx_pil = 4,
	D_max = 12964.0,
	D_min = 500.0,
	Head_Form = 0,
	Head_Form = 0,
	Life_Time = 110,
	Nr_max = 16,
	v_min = 50.0,
	v_mid = 290.0,
	Mach_max = 1.5,
	t_b = 0.0,
	t_acc = 4.0,
	t_marsh = 0.0,
	Range_max = 24076.0,
	H_min_t = 0.0,
	Fi_start = 0.5,
	Fi_rak = 3.14152,
	Fi_excort = 1.05,
	Fi_search = 99.9,
	OmViz_max = 99.9,
	exhaust = {0.75, 0.75, 0.75, 0.1},
	X_back = -0.9,
	Y_back = -0.15,
	Z_back = 0.0,
	Reflection = 0.08,
	KillDistance = 0.0,

	shape_table_data =
	{
		{
			name		= "AGM_65F",
			file		= "AGM-65F",
			life		= 1,
			fire		= { 0, 1},
			username	= _("AGM-65F Maverick"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 301,  
		caliber     = 0.305,  
		cx_coeff    = {1,0.39,0.38,0.236,1.31},
		L           = 2.49,
		I           = 1 / 12 * 209 * 2.49 * 2.49,
		Ma          = 0.68,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 0.55,
		dCydA		= {0.07, 0.036},
		A			= 0.36,
		maxAoa		= 0.23,
		finsTau		= 0.1,
		Ma_x		= 3,
		Kw_x		= 0.03,
		I_x			= 40,
	},
	
	seeker = {
		delay			= 0.0,
		op_time			= 105,
		FOV				= math.rad(60),
		max_w_LOS		= 0.06,
		max_w_LOS_surf	= 0.03,
	
		max_target_speed			= 33,
		max_target_speed_rnd_coeff	= 10,
		
		ship_track_by_default		= 1,
		ship_track_board_vis_angle	= math.rad(60),
	},
	
	PN_autopilot = {
		K			= 0.02,
		Ki			= 0,
		Kg			= 2.5,
		Kx			= 0.02,
		fins_limit	= 0.3,
		K_GBias		= 0.28,
	},
	
	march = {
		smoke_color			= {0.8, 0.8, 0.8},
		smoke_transparency	= 0.7,
	},
	
	warhead = predefined_warhead("AGM_65G"),
	warhead_air = predefined_warhead("AGM_65G"),
}

declare_weapon(AGM_65F)

local AGM_65L =
{
	category		= CAT_MISSILES,
	name			= "AGM_65L",
	user_name		= _("AGM-65L"),
	class_name 		= "wAmmunitionLaserHoming",
	scheme 			= "AGM-65E",
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
	model			= "agm-65l",
	
	mass	= 292,
	Escort = 1,
    Head_Type = 4,
	sigma = {5, 5, 5},
	M = 292.0,
	H_max = 10000.0,
	H_min = -1,
	Diam = 305.0,
	Cx_pil = 4,
	D_max = 18520.0,
    D_min = 1000.0,
	Head_Form = 0,
	Life_Time = 110,
	Nr_max = 16,
	v_min = 50.0,
	v_mid = 290.0,
	Mach_max = 1.5,
	t_b = 0.0,
	t_acc = 4.0,
	t_marsh = 0.0,
	Range_max = 11112.0,
	H_min_t = 0.0,
	Fi_start = 0.5,
	Fi_rak = 3.14152,
	Fi_excort = 1.05,
	Fi_search = 99.9,
	OmViz_max = 99.9,
	exhaust = {0.75, 0.75, 0.75, 0.1},
	X_back = -0.9,
	Y_back = -0.15,
	Z_back = 0.0,
	Reflection = 0.08,
	KillDistance = 0.0,

	shape_table_data =
	{
		{
			name		= "AGM_65L",
			file		= "AGM-65l",
			life		= 1,
			fire		= { 0, 1},
			username	= _("AGM-65L Maverick"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 292,  
		caliber     = 0.305,  
		cx_coeff    = {1,0.39,0.38,0.236,1.31},
		L           = 2.49,
		I           = 1 / 12 * 209 * 2.49 * 2.49,
		Ma          = 0.68,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 0.55,
		dCydA		= {0.07, 0.036},
		A			= 0.36,
		maxAoa		= 0.23,
		finsTau		= 0.1,
		Ma_x		= 3,
		Mw_x		= 3.3,
		I_x			= 40,
	},
	
	laser_spot_seeker = {
		FOV					= 0.558,
		max_seeker_range	= 18520,
	},

	PN_autopilot = {
		K			= 0.014,
		Ki			= 0,
		Kg			= 1.4,
		Kx			= 0.02,
		fins_limit	= 0.3,
		K_GBias		= 0.26,
	},
	
	march = {
		smoke_color			= {0.8, 0.8, 0.8},
		smoke_transparency	= 0.7,
	},
	
	warhead 	= predefined_warhead("AGM_65E"),
	warhead_air = predefined_warhead("AGM_65E"),
}

declare_weapon(AGM_65L)


local AGM_65A =
{
	category		= CAT_MISSILES,
	name			= "AGM_65A", -- AGM-65F
	user_name		= _("AGM-65A"),
	class_name 		= "wAmmunitionSelfHoming",
	scheme			= "AGM-65",
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
	model			= "agm-65b",
	
	mass        	= 210.5, 
	Escort			= 0,
    Head_Type		= 5,
	sigma			= {5, 5, 5},
	M				= 210.5,
	H_max			= 10000.0,
	H_min			= -1,
	Diam			= 305.0,
	Cx_pil			= 4,
	D_max			= 12964.0,
	D_min			= 500.0,
	Head_Form		= 0,
	Life_Time		= 110,
	Nr_max			= 16,
	v_min			= 50.0,
	v_mid			= 290.0,
	Mach_max		= 1.5,
	t_b				= 0.0,
	t_acc			= 4.0,
	t_marsh			= 0.0,
	Range_max		= 24076.0,
	H_min_t			= 0.0,
	Fi_start		= 0.5,
	Fi_rak			= 3.14152,
	Fi_excort		= 1.05,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	exhaust			= {0.7, 0.7, 0.7, 0.1},
	X_back			= -0.9,
	Y_back			= -0.15,
	Z_back 			= 0.0,
	Reflection		= 0.08,
	KillDistance	= 0.0,

	shape_table_data =
	{
		{
			name		= "AGM_65A",
			file		= "agm-65b",
			life		= 1,
			fire		= { 0, 1},
			username	= _("AGM-65A"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 210.5,  
		caliber     = 0.305,  
		cx_coeff    = {1,0.39,0.38,0.236,1.31},
		L           = 2.49,
		I           = 1 / 12 * 209 * 2.49 * 2.49,
		Ma          = 0.68,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 0.55,
		dCydA		= {0.07, 0.036},
		A			= 0.36,
		maxAoa		= 0.23,
		finsTau		= 0.1,
		Ma_x		= 3,
		Kw_x		= 0.03,
		I_x			= 40,
	},
	
	seeker = {
		delay			= 0.0,
		op_time			= 105,
		FOV				= math.rad(60),
		max_w_LOS		= 0.05,
		max_w_LOS_surf	= 0.025,
	
		max_target_speed			= 28,
		max_target_speed_rnd_coeff	= 10,
	},
	
	PN_autopilot = {
		K			= 0.014,
		Ki			= 0,
		Kg			= 2.5,
		Kx			= 0.02,
		fins_limit	= 0.3,
		K_GBias		= 0.26,
	},
	
	march = {
		smoke_color			= {0.7, 0.7, 0.7},
		smoke_transparency	= 0.72,
	},
	
	warhead		= predefined_warhead("AGM_65A"),
	warhead_air = predefined_warhead("AGM_65A"),
}

declare_weapon(AGM_65A)

local AGM_65B =
{
	category		= CAT_MISSILES,
	name			= "AGM_65B", -- AGM-65F
	user_name		= _("AGM-65B"),
	class_name 		= "wAmmunitionSelfHoming",
	scheme			= "AGM-65",
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
	model			= "agm-65b",
	
	mass       		= 210.5, 
	Escort			= 0,
    Head_Type		= 5,
	sigma			= {5, 5, 5},
	M				= 210.5,
	H_max			= 10000.0,
	H_min			= -1,
	Diam			= 305.0,
	Cx_pil			= 4,
	D_max			= 12964.0,
	D_min			= 500.0,
	Head_Form		= 0,
	Life_Time		= 110,
	Nr_max			= 16,
	v_min			= 50.0,
	v_mid			= 290.0,
	Mach_max		= 1.5,
	t_b				= 0.0,
	t_acc			= 4.0,
	t_marsh			= 0.0,
	Range_max		= 24076.0,
	H_min_t			= 0.0,
	Fi_start		= 0.5,
	Fi_rak			= 3.14152,
	Fi_excort		= 1.05,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	exhaust			= {0.7, 0.7, 0.7, 0.1},
	X_back			= -0.9,
	Y_back			= -0.15,
	Z_back 			= 0.0,
	Reflection		= 0.08,
	KillDistance	= 0.0,

	shape_table_data =
	{
		{
			name		= "AGM_65B",
			file		= "agm-65b",
			life		= 1,
			fire		= { 0, 1},
			username	= _("AGM-65B"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 210.5,
		caliber     = 0.305,
		cx_coeff    = {1,0.39,0.38,0.236,1.31},
		L           = 2.49,
		I           = 1 / 12 * 209 * 2.49 * 2.49,
		Ma          = 0.68,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 0.55,
		dCydA		= {0.07, 0.036},
		A			= 0.36,
		maxAoa		= 0.23,
		finsTau		= 0.1,
		Ma_x		= 3,
		Kw_x		= 0.03,
		I_x			= 40,
	},
	
	seeker = {
		delay			= 0.0,
		op_time			= 105,
		FOV				= math.rad(50),
		max_w_LOS		= 0.055,
		max_w_LOS_surf	= 0.0275,
	
		max_target_speed			= 33,
		max_target_speed_rnd_coeff	= 10,
	},
	
	PN_autopilot = {
		K			= 0.014,
		Ki			= 0,
		Kg			= 2.5,
		Kx			= 0.02,
		fins_limit	= 0.3,
		K_GBias		= 0.26,
	},
	
	march = {
		smoke_color			= {0.7, 0.7, 0.7},
		smoke_transparency	= 0.72,
	},
	
	warhead		= predefined_warhead("AGM_65B"),
	warhead_air = predefined_warhead("AGM_65B"),
}

declare_weapon(AGM_65B)

local agm65_variants =
{
	["AGM-65F"]  		= {display_name = _("AGM-65F - Maverick F (IIR ASM)"), Picture	=	"agm65.png", ws_type = AGM_65F.wsTypeOfWeapon,	category = CAT_MISSILES, mass = 301.0},
	["AGM-65L"]  		= {display_name = _("AGM-65L - Maverick E2/L (CCD Laser ASM)"), Picture	=	"agm65.png", ws_type = AGM_65L.wsTypeOfWeapon,	category = CAT_MISSILES, mass = 292.0},
	["AGM-65A"]  		= {display_name = _("AGM-65A - Maverick A (TV Guided)"), Picture	=	"agm65.png", ws_type = AGM_65A.wsTypeOfWeapon,	category = CAT_MISSILES, mass = 210.5},
	["AGM-65B"]  		= {display_name = _("AGM-65B - Maverick B (TV Guided)"), Picture	=	"agm65.png", ws_type = AGM_65B.wsTypeOfWeapon,	category = CAT_MISSILES, mass = 210.5},
}

local function lau_117_Maverick(clsid,element)

	local var 	   = agm65_variants[element] or agm65_variants["AGM-65F"]
	local var_mass = var.mass or 301.0
	local display_name	= var.display_name or element
	
	local ret = {
		category			=	CAT_MISSILES,
		CLSID				=	clsid,
		Picture				=	var.Picture,
		wsTypeOfWeapon		=	var.ws_type,
		attribute     		=  {4,	4,	32,	WSTYPE_PLACEHOLDER},
		Count 			  	= 1,
		displayName	  		=	_("LAU-117 with").." "..display_name,
		Weight  		  	= LAU_117_mass + var.mass,
		Cx_pil				= 0.00025 + 0.0009765625,
		Cx_item				= 0.0009765625,
		Elements		  = 
		{
			{
				ShapeName	=	"LAU-117",
			}, 
			{
				Position	=	{0.18,	-0.078,	0},
				ShapeName	=	"AGM-65F",
			}
		}
	}

	declare_loadout(ret)
end

lau_117_Maverick("LAU_117_AGM_65F"	,"AGM-65F")
lau_117_Maverick("LAU_117_AGM_65L"	,"AGM-65L")
lau_117_Maverick("LAU_117_AGM_65A"	,"AGM-65A")
lau_117_Maverick("LAU_117_AGM_65B"	,"AGM-65B")