-- Weapons definitions

-- S-5 Rockets
local S5M1_Warhead =
{
	mass					= 0.815,					-- Mass (Weight) in Kg
    expl_mass				= 0.285,					-- Mass of explosives in kg
    other_factors			= { 1.0, 0.5, 0.5 },
    concrete_factors		= { 1.0, 0.5, 0.1 },
    concrete_obj_factor		= 0.0,
    obj_factors				= { 1.0, 1.0 },
    cumulative_factor		= 3.0,
    cumulative_thickness	= 0.1,
	piercing_mass			= 0.815 * 0.35,				-- Piercing mass is a percentage of warhead mass
}

local S5MO_Warhead =
{
	mass					= 0.815,					
    expl_mass				= 0.285,
    other_factors			= { 1.0, 0.5, 0.5 },
    concrete_factors		= { 1.0, 0.5, 0.1 },
    concrete_obj_factor		= 0.0,
    obj_factors				= { 1.0, 1.0 },
    cumulative_factor		= 3.0,
    cumulative_thickness	= 0.1,
	piercing_mass			= 0.815 * 0.55,
}

local S5_rocket_motor =
{
	fuel_mass				= 3.00,		-- Fuel mass, kg
	motor_length 			= 0.650,
	impulse					= 180,				-- Specific impuls, sec
	boost_time				= 0,				-- Time of booster action
	work_time				= 0.675,			-- Time of mid-flight engine action
	boost_factor			= 1,				-- Booster to cruise trust ratio
	nozzle_position			= {{-0.471, 0, 0}},	-- meters
	nozzle_orientationXYZ	= {{0, 0, 0}},
	tail_width				= 0.052,			-- contrail thickness
	boost_tail				= 1, 
	work_tail				= 1,
	smoke_color				= {0.9, 0.9, 0.9},
	smoke_transparency		= 0.5,
}

local S5M_FFAR_FM = 
{
	mass        = 3.86,									-- Warehad Weight + Fuel mass + rocket body weight
	caliber     = 0.057,								-- Caliber, meters 
	cx_coeff    = {1, 1.2668931, 0.67, 0.4521834,2.08},	-- Cx
	L           = 0.987,								-- Length, meters
	I           = 0.4313938,							-- moment of inertia (kgm2): I = 1/12 ML2
	Ix          = 0.0017991,
	Ma          = 0.131698,								-- dependence moment coefficient of  by  AoA angular acceleration  T / I
	Mw          = 1.4351299,							--  dependence moment coefficient by angular velocity (rad/s): 57.3°/s - (|V|*sin(?))/|r| -  Mw  =  Ma * t 
	wind_time   = 0.675,								-- dispersion coefficient
	wind_sigma  = 5,									-- dispersion coefficient
	freq        = 7,
	wing_unfold_time = 0.02,							-- Unfold time, sec
}

local function S5_FFAR_fm(tbl)
	local t = 
	{
		mass        = 3.86,
		caliber     = 0.057,
		cx_coeff    = {1, 1.2668931, 0.67, 0.4521834, 2.08},
		L           = 0.987,
		I           = 0.4313938,
		Ix          = 0.0017991,
		Ma          = 0.131698,
		Mw          = 1.4351299,
		wind_time   = 0.675,
		wind_sigma  = 5,
		freq        = 7,
		wing_unfold_time = 0.02,
	}
	if tbl then
		for i,o in pairs(tbl) do
			t[i] = o
		end
	end
	return t
end

local function S5_FFAR(main, fm, warhead)
	local t = main or {}
	
	t.category   		= CAT_ROCKETS
	t.wsTypeOfWeapon 	= {wsType_Weapon, wsType_NURS, wsType_Rocket, WSTYPE_PLACEHOLDER}
	t.scheme			= "nurs-standard"
	t.fm 		 		= fm      or S5_FFAR_fm()
	t.fm.shapeName		= t.model
	t.warhead    		= warhead
	----------------------------------------
	t.engine    		= S5_rocket_motor
	t.properties = 
	{
		dist_min = 600,   -- min range, meters
		dist_max = 2500,  -- max range, meters
	}
	if not t.shape_table_data then
		t.shape_table_data ={
			{
				name     = t.model,
				file     = t.model,
				life     = 1,
				fire     = {0, 1},
				username = t.name,
				index    = WSTYPE_PLACEHOLDER,
			},
		}
	end
	declare_weapon(t)
	return t
end


------------------------------------------
local S5M1_FFAR_HE_FRAG	= S5_FFAR(
	--base
	{
		name		= "S5M1_HEFRAG_FFAR",
		model		= "c-5m",
		user_name	= _("S-5M1 HE-FRAG FFAR"),
		shape_table_data = 
		{
			{
				name     = "S5M1_HEFRAG_FFAR",
				file     = "S5M1_HEFRAG_FFAR";
				life     = 1;
				fire     = {0, 1};
				username = "S5M1_HEFRAG_FFAR";
				index    = WSTYPE_PLACEHOLDER;
			},
		},
	},
	S5M_FFAR_FM,	--fm
	S5M1_Warhead	--warhead
)

------------------------------------------
local S5MO_FFAR_HE_FRAG	= S5_FFAR(
	--base
	{
		name		= "S5MO_HEFRAG_FFAR",
		model		= "c-5m",
		user_name	= _("S-5MO HE-FRAG FFAR"),
		shape_table_data = 
		{
			{
				name     = "S5MO_HEFRAG_FFAR",
				file     = "S5MO_HEFRAG_FFAR";
				life     = 1;
				fire     = {0, 1};
				username = "S5MO_HEFRAG_FFAR";
				index    = WSTYPE_PLACEHOLDER;
			},
		},
	},
	S5M_FFAR_FM,	--fm
	S5MO_Warhead	--warhead
)

------------------------------------------
function ORO_57K(CLSID,rocket)
	local data =
	{
		CLSID			= CLSID,
		category		= CAT_ROCKETS,
		Picture			= "b13.png",
		Count			= 8,
		Cx_pil			= 0.00196533203125,
		wsTypeOfWeapon  = rocket.wsTypeOfWeapon,
		attribute		= {4,	7,	32,	WSTYPE_PLACEHOLDER },
		displayName		= _("ORO-57K").." - "..rocket.user_name.." x 8",
		Elements		= {{ ShapeName	= "oro-57k.edm" , IsAdapter = true}},
		Weight			= 33 + (8  * rocket.fm.mass),
	}
	for i = 1, data.Count do
		data.Elements[#data.Elements + 1] = {
			connector_name	= "tube_"..i,
			ShapeName		=	"c-5m"
		}
	end
	declare_loadout(data)
end

ORO_57K("{ORO57K_S5M1_HEFRAG}"	,S5M1_FFAR_HE_FRAG)
ORO_57K("{ORO57K_S5MO_HEFRAG}"	,S5MO_FFAR_HE_FRAG)

declare_loadout(
	{
		category		= CAT_ROCKETS,
		CLSID			= "{ORO57K_S5M_HEFRAG}",
		displayName		= _("ORO-57K - S-5M x 8"),
		wsTypeOfWeapon	= {4, 7, 33, 31},			-- S-5 FFAR
		attribute		= {4, 7, 32, WSTYPE_PLACEHOLDER},
		Count			= 8,
		Picture			= "b13.png",
		Weight_Empty	= 33,
		Weight			= (8 * 3.99) + 33,
		Cx_pil			= 0.001,
		shape_table_data = 
		{
			{
				name     = "ORO57K_S5M_HEFRAG",
				file     = "ORO57K_S5M_HEFRAG";
				life     = 1;
				fire     = {0, 1};
				username = "ORO57K_S5M_HEFRAG";
				index    = WSTYPE_PLACEHOLDER;
			},
		},
		Elements = {{ ShapeName = "oro-57k.edm", IsAdapter = true}}
	}
)

-- K13A R-3S (AA-2 Atoll)
local K13A_DRAG				= 2.58 / 4096.0 -- 4096 - magic number from long time ago when flanker was 1.5

declare_loadout(
	{
		category			= 	CAT_AIR_TO_AIR,
		CLSID 				= 	"{K-13A}",
		Picture				=	"aim9p.png",
		displayName			=	_("K-13A"),
		NatoName			=	"{AA-2}",
		attribute			=	"weapons.missiles.R-3S",
		Cx_pil				=	K13A_DRAG,
		Count				=	1,
		Weight				=	90.0,
		Elements			=  {{ShapeName = "R-3C"}}-- end of Elements
	}
)

declare_loadout(
	{
		category	= CAT_FUEL_TANKS,
		CLSID		= "PTB400_MIG19",
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("Fuel Tank 400 liters"),
		Weight_Empty	= 32.0,
		Weight		= 32.0 + 400*0.83, -- 0.83 is L to KG conv from system details
		Cx_pil		= 0.001313754,
		shape_table_data = 
		{
			{
				name	= "PTB400_MIG19";
				file	= "PTB400_MIG19";
				life	= 1;
				fire	= { 0, 1};
				username	= "PTB400_MIG19";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "PTB400_MIG19",
			}, 
		}, 
	}
)

declare_loadout(
	{
		category	= CAT_FUEL_TANKS,
		CLSID		= "PTB760_MIG19",
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("Fuel Tank 760 liters"),
		Weight_Empty	= 33.0,
		Weight		= 33.0 + 760*0.83, -- 0.83 is L to KG conv from system details
		Cx_pil		= 0.0018392556,			--2.0*0.001313754,
		shape_table_data = 
		{
			{
				name	= "PTB760_MIG19";
				file	= "PTB760_MIG19";
				life	= 1;
				fire	= { 0, 1};
				username	= "PTB760_MIG19";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "PTB760_MIG19",
			}, 
		}, 
	}
)

-- Ammunition definition
local NR30_cartridge_30mm	= 203
local NR30_link_weight		= 0.09
local tracer_on_time		= 0.02
local barrel_smoke_level	= 0.50
local barrel_smoke_opacity	= 0.10

declare_weapon(
	{
		category				= CAT_SHELLS,
		name					= "NR30_30x155_HEI_T",
		user_name				= _("OFZT 30x155 HEI-T"),
		model_name				= "tracer_bullet_crimson",
		v0    					= 780,
		Dv0   					= 0.0050,
		Da0     				= 0.0007,
		Da1     				= 0.0,
		mass      				= 0.403,
		round_mass 				= 0.840 + NR30_link_weight,	-- round + link
		cartridge_mass			= 0.437 + NR30_link_weight,	-- cartriges are ejected
		explosive				= 0.043,
		life_time				= 5.0,
		caliber					= 30.0,
		s						= 0.0,
		j						= 0.0,
		l						= 0.0,
		charTime				= 0,
		cx						= {1.0,0.74,0.65,0.150,1.78},
		k1						= 2.3e-08,
		tracer_off				= 1.5,
		tracer_on				= tracer_on_time,
		scale_tracer			= 2,
		scale_smoke				= barrel_smoke_level,
		smoke_opacity			= barrel_smoke_opacity,
		smoke_tail_life_time	= 1.0,
		cartridge				= 0,
	}
)

declare_weapon(
	{
		category				= CAT_SHELLS,
		name					= "NR30_30x155_APT",
		user_name				= _("BT 30x155 AP-T"),
		model_name				= "tracer_bullet_yellow",
		v0						= 780,
		Dv0						= 0.0081,			--0.0050,
		Da0						= 0.0005,			--0.0007,
		Da1						= 0.0,
		mass					= 0.403,			
		round_mass				= 0.840 + NR30_link_weight,	-- round + link
		cartridge_mass			= 0.437 + NR30_link_weight,	-- cartriges are ejected
		explosive				= 0.000,
		life_time				= 6.0,				--5.0,
		caliber					= 30.0,
		s						= 0.0,
		j						= 0.0,
		l						= 0.0,
		charTime				= 0,
		cx						= {0.5, 0.86, 0.25, 0.236, 2.00},	--{1.0,0.74,0.65,0.150,1.78},
		k1						= 1.2e-08,							--2.3e-08,
		tracer_off				= 1.5,
		tracer_on				= tracer_on_time,
		scale_tracer			= 2,
		scale_smoke				= barrel_smoke_level,
		smoke_opacity			= barrel_smoke_opacity,
		smoke_tail_life_time	= 1.0,
		cartridge				= 0,
	}
)

declare_weapon(
	{
		category				= CAT_SHELLS,
		name					= "NR30_30x155_APHE",
		user_name				= _("BR 30x155 APHE"),
		model_name				= "tracer_bullet_yellow",
		v0						= 780,
		Dv0						= 0.0081,			--0.0050,
		Da0						= 0.0005,			--0.0007,
		Da1						= 0.0,
		mass					= 0.403,			
		round_mass				= 0.840 + NR30_link_weight,	-- round + link
		cartridge_mass			= 0.437 + NR30_link_weight,	-- cartriges are ejected
		explosive				= 0.043,
		life_time				= 6.0,
		caliber					= 30.0,
		s						= 0.0,
		j						= 0.0,
		l						= 0.0,
		charTime				= 0,
		cx						= {0.5, 0.86, 0.25, 0.236, 2.00},
		k1						= 1.2e-08,
		tracer_off				= 0,
		tracer_on				= 0,	-- No tracers
		scale_tracer			= 2,
		scale_smoke				= barrel_smoke_level,
		smoke_opacity			= barrel_smoke_opacity,
		smoke_tail_life_time	= 1.0,
		cartridge				= 0,
	}
)

-- Guns definition
function nr30(tbl)

	tbl.category 		= CAT_GUN_MOUNT 
	tbl.name 	 		= "NR-30"
	tbl.display_name	= "NR-30"
	tbl.supply 	 		= 
	{
		mixes  = {
					{2, 3, 1, 1, 1},
					{1},	-- HE-T
					{2},	-- AP-T
					{3},	-- APHE
				}, 
		shells = {
					"NR30_30x155_HEI_T", 
					"NR30_30x155_APT",
					"NR30_30x155_APHE",
				},
		
		count  = 70,
	}
	
	if tbl.mixes then 
	   tbl.supply.mixes =  tbl.mixes
	   tbl.mixes	    = nil
	end
	tbl.gun				= 
	{
		max_burst_length = 100,
		rates 			 = {900},
		recoil_coeff 	 = 1,
		barrels_count 	 = 1,
	}
	if tbl.rates then 
	   tbl.gun.rates    =  tbl.rates
	   tbl.rates	    = nil
	end	
	tbl.ejector_pos 			= tbl.ejector_pos or {0.0, 0.0, 0.0}
	tbl.ejector_dir 			= tbl.ejector_dir or {-2.0, -2.0, 0.0}
	tbl.supply_position  		= tbl.supply_position or {0,  0, 0}
	tbl.aft_gun_mount 			= false
	tbl.effective_fire_distance = 1000
	tbl.drop_cartridge 			= NR30_cartridge_30mm
	tbl.muzzle_pos				= tbl.muzzle_pos or {0,0,0}	-- all position from connector
	tbl.azimuth_initial 		= tbl.azimuth_initial or 0   
	tbl.elevation_initial 		= tbl.elevation_initial or 0   
	if  tbl.effects == nil then
		tbl.effects = 
		{
			{ name = "FireEffect",		arg = tbl.effect_arg_number or 436 },
			{ name = "HeatEffectExt",	shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
			{ name = "SmokeEffect"}
		}
	end
	
	return declare_weapon(tbl)
end
