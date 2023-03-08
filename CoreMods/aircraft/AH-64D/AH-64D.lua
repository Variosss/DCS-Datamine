local payload_x = 0.588000
local payload_y = -0.320000
local payload_z = {2.360000, 1.600000}

local ExtFuelTankID							= "{EFT_230GAL}"								-- 230 gal External Fuel Tank

local NURSLauncherID_MK151					= "M261_MK151"									-- M261 pod - 19 x 2.75" Hydra rockets M151 HE - high-explosive
local NURSLauncherID_M229					= "{M261_M229}"									-- M261 pod - 19 x 2.75\" Hydra, UnGd Rkts M229, HEDP
local NURSLauncherID_M257					= "{M261_M257}"									-- M261 pod - 19 x 2.75\" Hydra, UnGd Rkts M257, Illum.
local NURSLauncherID_M274					= "{M261_M274}"									-- M261 pod - 19 x 2.75\" Hydra, UnGd Rkts M274, Smk
local NURSLauncherID_M282					= "{M261_M282}"									-- M261 pod - 19 x 2.75\" Hydra, UnGd Rkts M282, Pen
local NURSLauncherID_M433					= "{M261_M151_M433}"							-- M261 pod - 19 x 2.75\" Hydra, UnGd Rkts M151 HE, M433 RC Fuze
local NURSLauncherID_M151_M274_OUTBOARD		= "{M261_OUTBOARD_AB_M151_E_M274}"				-- M261: Outboard Launcher, Zones A/B: M151 Hydra (6PD), Zone E: M274 Hydra (6SK)
local NURSLauncherID_M151_M257_OUTBOARD		= "{M261_OUTBOARD_AB_M151_E_M257}"				-- M261: Outboard Launcher, Zones A/B: M151 Hydra (6PD), Zone E: M257 Hydra (6IL)
local NURSLauncherID_M274_M151_INBOARD		= "{M261_INBOARD_DE_M151_C_M274}"				-- M261: Inboard Launcher, Zone C: M274 Hydra (6SK), Zones D/E: M151 Hydra (6PD)
local NURSLauncherID_M257_M151_INBOARD		= "{M261_INBOARD_DE_M151_C_M257}"				-- M261: Inboard Launcher, Zone C: M257 Hydra (6IL), Zones D/E: M151 Hydra (6PD)

local HellfireLauncherID_AGM114K_4			= "{88D18A5E-99C8-4B04-B40B-1C02F2018B6E}"		-- AGM-114K Hellfire * 4
local HellfireLauncherID_AGM114K_3_L		= "{M299_3xAGM_114K_OUTBOARD_PORT}"				-- AGM-114K Hellfire * 3, two on top row and one on lower outboard
local HellfireLauncherID_AGM114K_3_R		= "{M299_3xAGM_114K_OUTBOARD_STARBOARD}"		-- AGM-114K Hellfire * 3, two on top row and one on lower outboard
local HellfireLauncherID_AGM114K_2			= "{M299_2xAGM_114K}"							-- AGM-114K Hellfire * 2, on top row
local HellfireLauncherID_AGM114K_1_L		= "{M299_1xAGM_114K_OUTBOARD_PORT}"				-- AGM-114K Hellfire * 1, on top row, outboard
local HellfireLauncherID_AGM114K_1_R		= "{M299_1xAGM_114K_OUTBOARD_STARBOARD}"		-- AGM-114K Hellfire * 1, on top row, outboard
local HellfireLauncherID_AGM114K_0			= "{M299_EMPTY}"								-- empty Hellfire launcher


local function getForbiddenTypes(origin_num, this_num, origin_clsid)
	-- these types are forbidden for 'i'-th station when you load some weapon on this_station (origin_num)

	local ret_tbl = {}
	
	if origin_clsid == NURSLauncherID_MK151 then
		ret_tbl =
		{
			NURSLauncherID_M257,
			NURSLauncherID_M274,
			NURSLauncherID_M229,
			NURSLauncherID_M282,
			NURSLauncherID_M433,
			NURSLauncherID_M151_M274_OUTBOARD,
			NURSLauncherID_M151_M257_OUTBOARD
		}
		
		if (origin_num == 2 or origin_num == 3) and (this_num == 2 or this_num == 3)	then	-- choose for inboard -> forbid for inboard
			ret_tbl[#ret_tbl+1] = NURSLauncherID_M274_M151_INBOARD
			ret_tbl[#ret_tbl+1] = NURSLauncherID_M257_M151_INBOARD
		end
	end

	if origin_clsid == NURSLauncherID_M257 then
		ret_tbl =
		{
			NURSLauncherID_MK151,
			NURSLauncherID_M229,
			NURSLauncherID_M274,
			NURSLauncherID_M282,
			NURSLauncherID_M433,
			NURSLauncherID_M151_M274_OUTBOARD,
			NURSLauncherID_M274_M151_INBOARD,
			NURSLauncherID_M257_M151_INBOARD
		}

		if (origin_num == 1 or origin_num == 4) and (this_num == 1 or this_num == 4)	then	-- choose for outboard -> forbid for outboard
			ret_tbl[#ret_tbl+1] = NURSLauncherID_M151_M257_OUTBOARD
		end
	end	

	if origin_clsid == NURSLauncherID_M274 then
		ret_tbl =
		{
			NURSLauncherID_MK151,
			NURSLauncherID_M229,
			NURSLauncherID_M257,
			NURSLauncherID_M282,
			NURSLauncherID_M433,
			NURSLauncherID_M151_M257_OUTBOARD,
			NURSLauncherID_M274_M151_INBOARD,
			NURSLauncherID_M257_M151_INBOARD
		}

		if (origin_num == 1 or origin_num == 4) and (this_num == 1 or this_num == 4)	then	-- choose for outboard -> forbid for outboard
			ret_tbl[#ret_tbl+1] = NURSLauncherID_M151_M274_OUTBOARD
		end
	end

	if origin_clsid == NURSLauncherID_M229 then
		ret_tbl =
		{
			NURSLauncherID_MK151,
			NURSLauncherID_M257,
			NURSLauncherID_M274,
			NURSLauncherID_M282,
			NURSLauncherID_M433,
			NURSLauncherID_M151_M274_OUTBOARD,
			NURSLauncherID_M151_M257_OUTBOARD,
			NURSLauncherID_M274_M151_INBOARD,
			NURSLauncherID_M257_M151_INBOARD
		}
	end

	if origin_clsid == NURSLauncherID_M282 then
		ret_tbl =
		{
			NURSLauncherID_MK151,
			NURSLauncherID_M257,
			NURSLauncherID_M274,
			NURSLauncherID_M229,
			NURSLauncherID_M433,
			NURSLauncherID_M151_M274_OUTBOARD,
			NURSLauncherID_M151_M257_OUTBOARD,
			NURSLauncherID_M274_M151_INBOARD,
			NURSLauncherID_M257_M151_INBOARD
		}
	end

	if origin_clsid == NURSLauncherID_M433 then
		ret_tbl =
		{
			NURSLauncherID_MK151,
			NURSLauncherID_M257,
			NURSLauncherID_M274,
			NURSLauncherID_M229,
			NURSLauncherID_M282,
			NURSLauncherID_M151_M274_OUTBOARD,
			NURSLauncherID_M151_M257_OUTBOARD,
			NURSLauncherID_M274_M151_INBOARD,
			NURSLauncherID_M257_M151_INBOARD
		}
	end

	if origin_clsid == NURSLauncherID_M151_M274_OUTBOARD then
		ret_tbl =
		{
			NURSLauncherID_MK151,
			NURSLauncherID_M229,
			NURSLauncherID_M257,
			NURSLauncherID_M282,
			NURSLauncherID_M433,
			NURSLauncherID_M151_M257_OUTBOARD,
			NURSLauncherID_M274_M151_INBOARD,
			NURSLauncherID_M257_M151_INBOARD
		}

		if (this_num == 1 or this_num == 4)	then					-- forbid for outboard
			ret_tbl[#ret_tbl+1] = NURSLauncherID_M274
		end
	end
	
	if origin_clsid == NURSLauncherID_M151_M257_OUTBOARD then
		ret_tbl =
		{
			NURSLauncherID_MK151,
			NURSLauncherID_M229,
			NURSLauncherID_M274,
			NURSLauncherID_M282,
			NURSLauncherID_M433,
			NURSLauncherID_M151_M274_OUTBOARD,
			NURSLauncherID_M274_M151_INBOARD,
			NURSLauncherID_M257_M151_INBOARD
		}

		if (this_num == 1 or this_num == 4)	then					-- forbid for outboard
			ret_tbl[#ret_tbl+1] = NURSLauncherID_M257
		end
	end

	if origin_clsid == NURSLauncherID_M274_M151_INBOARD then
		ret_tbl =
		{
			NURSLauncherID_M229,
			NURSLauncherID_M257,
			NURSLauncherID_M274,
			NURSLauncherID_M282,
			NURSLauncherID_M433,
			NURSLauncherID_M151_M274_OUTBOARD,
			NURSLauncherID_M151_M257_OUTBOARD,
		}

		if (this_num == 2 or this_num == 3)	then					-- forbid for inboard
			ret_tbl[#ret_tbl+1] = NURSLauncherID_MK151
			ret_tbl[#ret_tbl+1] = NURSLauncherID_M257_M151_INBOARD
		end
	end

	if origin_clsid == NURSLauncherID_M257_M151_INBOARD then
		ret_tbl =
		{
			NURSLauncherID_M229,
			NURSLauncherID_M257,
			NURSLauncherID_M274,
			NURSLauncherID_M282,
			NURSLauncherID_M433,
			NURSLauncherID_M151_M274_OUTBOARD,
			NURSLauncherID_M151_M257_OUTBOARD,
		}

		if (this_num == 2 or this_num == 3)	then					-- forbid for inboard
			ret_tbl[#ret_tbl+1] = NURSLauncherID_MK151
			ret_tbl[#ret_tbl+1] = NURSLauncherID_M274_M151_INBOARD
		end
	end

	return ret_tbl
end

local function DoForbidOnOthers(this_station, clsid)
	local tbl = {}
	local iter = 1
	
	local isHellfire 	=	clsid == HellfireLauncherID_AGM114K_4
						or 	clsid == HellfireLauncherID_AGM114K_3_L
						or 	clsid == HellfireLauncherID_AGM114K_3_R
						or 	clsid == HellfireLauncherID_AGM114K_2	
						or 	clsid == HellfireLauncherID_AGM114K_1_L
						or 	clsid == HellfireLauncherID_AGM114K_1_R
						or 	clsid == HellfireLauncherID_AGM114K_0

	if(clsid == ExtFuelTankID or isHellfire) then 	-- restrictions are only for NURS
		return {}
	end
	
	for i=1,4 do
		if i~=this_station then
			tbl[iter] = {station = i, loadout = getForbiddenTypes(this_station, i, clsid)}
			iter = iter + 1
		end
	end
	
	return tbl
end


local function symmetric(clsid, this_station, opposite_station, arg_value)
	return  {
		CLSID     = clsid,
		arg_value = arg_value or 0.1,
		required  = {{station = opposite_station, loadout = {clsid}}},
		forbidden = DoForbidOnOthers(this_station, clsid)
	}
end

local function setRktLoadout(clsid, this_station, opposite_station, arg_value)
	return  {
		CLSID     = clsid,
		arg_value = arg_value or 0.1,
		required  = {},
		forbidden = DoForbidOnOthers(this_station, clsid)
	}
end

local function default_loadout_variants(station,opposite_station)
	local INB_OUTB_Variants = {}
	if station == 1 or station == 4 then
		INB_OUTB_Variants = {NURSLauncherID_M151_M274_OUTBOARD, NURSLauncherID_M151_M257_OUTBOARD}
	else
		INB_OUTB_Variants = {NURSLauncherID_M274_M151_INBOARD, NURSLauncherID_M257_M151_INBOARD}
	end
	
	local LEFT_RIGHT_Variants = {}
	if station == 1 or station == 2 then	-- left
		LEFT_RIGHT_Variants = {HellfireLauncherID_AGM114K_3_L, HellfireLauncherID_AGM114K_1_L}
	else
		LEFT_RIGHT_Variants = {HellfireLauncherID_AGM114K_3_R, HellfireLauncherID_AGM114K_1_R}
	end
	
	local ret_val = { setRktLoadout(NURSLauncherID_MK151,		station,	opposite_station,	1),
					  setRktLoadout(NURSLauncherID_M257,		station,	opposite_station,	1),
					  setRktLoadout(NURSLauncherID_M274,		station,	opposite_station,	1),
					  setRktLoadout(NURSLauncherID_M229,		station,	opposite_station,	1),
					  setRktLoadout(NURSLauncherID_M282,		station,	opposite_station,	1),
					  setRktLoadout(NURSLauncherID_M433,		station,	opposite_station,	1),
					  setRktLoadout(INB_OUTB_Variants[1],		station,	opposite_station,	1),
					  setRktLoadout(INB_OUTB_Variants[2],		station,	opposite_station,	1),

					  { CLSID = HellfireLauncherID_AGM114K_4,	arg_value = 1 },
					  { CLSID = LEFT_RIGHT_Variants[1],			arg_value = 1 },
					  { CLSID = HellfireLauncherID_AGM114K_2,	arg_value = 1 },
					  { CLSID = LEFT_RIGHT_Variants[2],			arg_value = 1 },
					  { CLSID = HellfireLauncherID_AGM114K_0,	arg_value = 1 },

					  { CLSID = ExtFuelTankID,					arg_value = 1 }
	}
	return ret_val	
end

local function getPylonArg(num)
	return {
		FiZ = 0,	-- TODO: what is it?
	
		arg = 640 + num - 1,
		arg_value = 0,
		use_full_connector_position = true,
		connector = "Pylon"..num,
	}
end

local function getValuesTbl(params_cap_tbl)
	local rez_tbl = {}
	for i = 1, #params_cap_tbl do
		rez_tbl[i] = {id = i-1, dispName = params_cap_tbl[i]}
	end

	return rez_tbl
end

local function addComboList(key, caption, params_cap_tbl, def, width)
	return {
		id = key, control = 'comboList', label = caption,
		values = getValuesTbl(params_cap_tbl), defValue = def or 0,
		wCtrl = width or 150,
		playerOnly = true
	}
end

local function recoil_effect(arg, spring, recoil)  
	return { name = "TurretRecoil", recoil_arg = arg, spring_coeff = spring, recoil_coeff = recoil  }
end

function fire_effect(fire_arg,duration,attenuation,light_pos)  
	return { name = "FireEffect", arg = fire_arg,duration = duration or 0.02, attenuation = attenuation or 2 , light_pos = light_pos or {0.5,0,0}}
end

function smoke_effect()  
	return { name = "SmokeEffect"}
end

local function shells_movement_effect( arg )  
	return { name = "ShellsMovement", shells_movement_arg = arg }
end

local AH_64D = {
	Name				= 'AH-64D_BLK_II',
	Shape				= 'AH-64D_bl2',
	shape_table_data	=
	{
		{
			file		= "AH-64D_bl2";
			username	= "AH-64D_BLK_II";
			index		= WSTYPE_PLACEHOLDER;
			life		= 20;
			vis			= 3;
			desrt		= "AH-64D_destr";
			fire		= { 300, 2};
			classname	= "lLandPlane";
			positioning	= "BYNORMAL";
		},
		{
			name		= "AH-64D_destr";
			file		= "AH-64-OBLOMOK";
			fire		= { 0, 1};
		}
	},

	Picture				= "AH-64D.png",
	DisplayName			= _("AH-64D BLK.II"),
	mapclasskey			= "P0091000021",
	WorldID				= WSTYPE_PLACEHOLDER,
	attribute			= {wsType_Air, wsType_Helicopter, wsType_Battleplane, WSTYPE_PLACEHOLDER, "Attack helicopters"},
	Categories			= {},
	CanopyGeometry		= makeHelicopterCanopyGeometry(LOOK_GOOD, LOOK_GOOD, LOOK_GOOD),
	encyclopediaAnimation = {
		args = {
			[507] = 1.000000, -- Pilot's eyepiece
			[517] = 1.000000, -- Copilot/Gunner's eyepiece
		},
	},

	-- Countermeasures,
	passivCounterm =
	{
		CMDS_Edit			= false,
		SingleChargeTotal	= 90,
		chaff				= {default = 30, increment = 30, chargeSz = 1},
		flare				= {default = 60, increment = 30, chargeSz = 1}
	},
	Sensors =
	{
		RADAR	= "AN/APG-78",
		OPTIC	= {"TADS DTV", "TADS FLIR"},
		RWR		= "Abstract RWR"
	},
	laserEquipment = 
	{
		laserRangefinder = true,
		laserDesignator  = true,
	},
	EPLRS = true,

	HumanRadio =
	{
		editable = true,
		frequency = 127.5,
		minFrequency = 30,
		maxFrequency = 399.975,
		rangeFrequency = {
			{min =  30.0, max =  87.975, modulation	= MODULATION_FM},			
			{min = 108.0, max = 151.975, modulation	= MODULATION_AM},
			{min = 225.0, max = 399.975, modulation	= MODULATION_AM}
		},
		modulation = MODULATION_AM,
	},
	panelRadio	= {
		[1] = {
			name = _("ARC-186"),
			range = { {min = 108.0, max = 151.975 }},		
			channels = {
					[1] = { name = _("Channel 1"),		default = 127.5}, -- default
					[2] = { name = _("Channel 2"),		default = 135.0},	-- min. water
					[3] = { name = _("Channel 3"),		default = 136.0},	-- nalchik
					[4] = { name = _("Channel 4"),		default = 127.0},	-- sochi
					[5] = { name = _("Channel 5"),		default = 125.0},	-- maykop
					[6] = { name = _("Channel 6"),		default = 121.0},	-- anapa
					[7] = { name = _("Channel 7"),		default = 141.0},	-- beslan
					[8] = { name = _("Channel 8"),		default = 128.0},	-- krasnodar-pashk.
					[9] = { name = _("Channel 9"),		default = 126.0},	-- gelenjik		
					[10] ={ name = _("Channel 10"),		default = 137.0}, -- mozdok					
			}
		},
		[2] = {
			name = _("ARC-164"),
			range = { {min = 225.0, max = 399.975 }},		
			channels = {
					[1] = { name = _("Channel 1"),		default = 225.0, connect = true},
					[2] = { name = _("Channel 2"),		default = 240.0},	
					[3] = { name = _("Channel 3"),		default = 255.0},	
					[4] = { name = _("Channel 4"),		default = 270.0},	
					[5] = { name = _("Channel 5"),		default = 285.0},	
					[6] = { name = _("Channel 6"),		default = 300.0},	
					[7] = { name = _("Channel 7"),		default = 325.0},	
					[8] = { name = _("Channel 8"),		default = 350.0},	
					[9] = { name = _("Channel 9"),		default = 375.0},	
					[10] ={ name = _("Channel 10"),		default = 390.0}, 			
			}
		},
		[3] = {
			name = _("FM 1: ARC-201D"),
			range = {min =  30.0, max =  87.975, modulation	= MODULATION_FM},
			channels = {
				[1] =  { name = _("Channel 1"),		default = 30.000},
				[2] =  { name = _("Channel 2"),		default = 30.010},	
				[3] =  { name = _("Channel 3"),		default = 30.015},	
				[4] =  { name = _("Channel 4"),		default = 30.020},	
				[5] =  { name = _("Channel 5"),		default = 30.025},	
				[6] =  { name = _("Channel 6"),		default = 30.030},	
				[7] =  { name = _("Channel 7"),		default = 30.035},	
				[8] =  { name = _("Channel 8"),		default = 30.040},	
				[9] =  { name = _("Channel 9"),		default = 30.045},	
				[10] = { name = _("Channel 10"),	default = 30.050},			
			}
		},
		[4] = {
			name = _("FM 2: ARC-201D"),
			range = {min =  30.0, max =  87.975, modulation	= MODULATION_FM},
			channels = {
				[1] =  { name = _("Channel 1"),		default = 30.000},
				[2] =  { name = _("Channel 2"),		default = 30.010},	
				[3] =  { name = _("Channel 3"),		default = 30.015},	
				[4] =  { name = _("Channel 4"),		default = 30.020},	
				[5] =  { name = _("Channel 5"),		default = 30.025},	
				[6] =  { name = _("Channel 6"),		default = 30.030},	
				[7] =  { name = _("Channel 7"),		default = 30.035},	
				[8] =  { name = _("Channel 8"),		default = 30.040},	
				[9] =  { name = _("Channel 9"),		default = 30.045},	
				[10] = { name = _("Channel 10"),	default = 30.050},			
			}
		},		
	},
	TACAN_AA = true,

	Pylons =
	{
		pylon(1, 0, payload_x, payload_y, -payload_z[1],
			getPylonArg(1),
			default_loadout_variants(1,4)
		),
		pylon(2, 0, payload_x, payload_y, -payload_z[2],
			getPylonArg(2),
			default_loadout_variants(2,3)
		),
		-- pylon(3, 0, 0, 0, 0,
			-- {
				-- FiZ = 0,
				-- DisplayName = _("IAFS"),
			-- },
			-- {
				-- { CLSID = "{***}" },													--add tunk 130 gal and 58 rounds at all for the gun
				-- { CLSID = "{***}" },													--add tunk 100 gal and 300 rounds at all for the gun
				-- { CLSID = "<CLEAN>",									arg_value = 1},	--no additional tunk and the gun has its maximum 1200 rounds
			-- }
		-- ),
		pylon(3, 0, payload_x, payload_y, payload_z[2],
			getPylonArg(3),
			default_loadout_variants(3,2)
		),
		pylon(4, 0, payload_x, payload_y, payload_z[1],
			getPylonArg(4),
			default_loadout_variants(4,1)
		),
	},
-- 
	Guns =
	{
		gun_mount("M_230_new",
			{ count = 300 },
			{
				muzzle_pos = {3.881, -1.821,  0.0},
				supply_position = {0.14, 0.1, 0.0},
				muzzle_pos_connector = "Gun_point_01",
				ejector_pos_connector = "ejector_1",
				max_burst_length = 300,
				effects = {recoil_effect(350, 0.3, 0.95), fire_effect(46), smoke_effect(), shells_movement_effect( 349 )   }
			}
		)
	},
	ammo_type_default = 1,
	ammo_type ={
			_("M789 HEDP"),
			_("M788 TP"),
	},

	Tasks =
	{
		aircraft_task(CAS),
		aircraft_task(GroundAttack),
		aircraft_task(Escort),
		aircraft_task(AFAC),
		aircraft_task(AntishipStrike)
	},-- end of Tasks
	DefaultTask = aircraft_task(CAS),

	LandRWCategories =
	{
		[1] = 
		{
			Name = "AircraftCarrier",
		}, -- end of [1]
		[2] = 
		{
			Name = "HelicopterCarrier",
		}, -- end of [2]
	}, -- end of LandRWCategories
	TakeOffRWCategories =
	{
		[1] = 
		{
			Name = "AircraftCarrier",
		}, -- end of [1]
		[2] = 
		{
			Name = "HelicopterCarrier",
		}, -- end of [2]
	}, -- end of TakeOffRWCategories

	-- RTS
	EmptyWeight			= "6167.7",
	MaxFuelWeight		= "1438",
	MaxHeight			= "4500",
	MaxSpeed			= "280",
	MaxTakeOffWeight	= "10432.6", -- p755 The aircraft maximum gross weight is 20,260 pounds, except for non- tactical ferry flights, which may not exceed 23,000 pounds.
	Rate				= "50",

	-- Aircraft Descriptor
	M_empty						= 6167.7 + 0 + 0,	-- (aircraft itself + engines + FCR + basic equipment + crew = 13306 pounds) + (IAFS fuel container?) + (IAFS ammo container?)
	M_nominal					= 6552,
	M_max						= 10432.6,
	M_fuel_max					= 1438,			--	(fwd + aft tanks) + IAFS fuel
	--M_Boost_Mixt_max			= 
	length						= 17.87,
	height						= 4.15,
	--apu_rpm_delay				= 
	Vy_max						= 12.7,
	radar_can_see_ground		= false,
	RCS							= 5,
	detection_range_max			= 0,
	IR_emission_coeff			= 0.2,
	Ny_max						= 3.5,
	range						= 480,
	tanker_type					= 2,
	air_refuel_receptacle_pos	= { -0.051, 0.911, 0},
	--bigParkingRamp			= 
	country_of_origin			= "USA",

	-- Helicopter Descriptor
	rotor_height				= 1.6,
	rotor_diameter				= 14.63,
	blades_number				= 4,
	blade_area					= 3.39,
	rotor_RPM					= 289,
	tail_rotor_RPM				= 1403,
	blade_chord					= 0.53,
	rotor_MOI					= 5800,
	rotor_pos					= {0.123,	1.47,	0},
	thrust_correction			= 0.75,
	fuselage_Cxa0				= 0.5,
	fuselage_Cxa90				= 5.9,
	fuselage_area				= 4,
	centering					= -0.1136,
	tail_pos					= {-9,	1.401,	0},
	tail_fin_area				= 1.45,
	tail_stab_area				= 2.94,

	MOI							= {6170,	28982,	33441},

	V_max						= 365,
	V_max_cruise				= 296,
	H_stat_max_L				= 4570,
	H_stat_max					= 3505,
	H_din_two_eng				= 6400,
	H_din_one_eng				= 3290,
	flight_time_typical			= 110,
	flight_time_maximum			= 189,
	
	lead_stock_main				= 0.37,
	lead_stock_support			= 0.147,
	scheme						= 0,

	Vy_land_max					= 12.8,
	sound_name					= "Aircrafts/Engines/RotorAH64",

	--cannon_sight_type			=
	--cargo_max_weight			=
	--cargo_radius_in_menu		=
	--helicopter_hook_pos		=
	--h_max_gear_hook			=

	fire_rate					= 625,
	stores_number				= 4,

	--
	wheel_steering_angle_max					= math.rad(180.0),
	nose_gear_pos								= {-9.203,	-0.960,	0},
	--[[nose_gear_amortizer_direct_stroke			= 0.0,						-- down from nose_gear_pos !!!
	nose_gear_amortizer_reversal_stroke			= -(0.246 + 0.030),			-- up
	nose_gear_amortizer_normal_weight_stroke	= -(0.246 + 0.030) * 0.7,	-- down from nose_gear_pos
	nose_gear_wheel_diameter					= 0.3228,
	nose_gear_door_close_after_retract			= false,]]--

	main_gear_pos								= {1.361,	-1.832,	1.017},
	--[[main_gear_amortizer_direct_stroke			= 0.0,						-- down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke			= -(0.267 + 0.056),			-- up
	main_gear_amortizer_normal_weight_stroke	= -(0.267 + 0.056) * 0.7,	-- down from main_gear_pos
	main_gear_wheel_diameter					= 0.6448,
	main_gear_door_close_after_retract			= false,]]--

	engines_count = 2,
	engine_data =
	{
		power_take_off	= 1169,
		power_max		= 1169,
		power_WEP		= 1297,
		power_TH_k =
		{
			[1] = {  6.3136,	-151.3,		1252.4},
			[2] = {  4.9361,	-143.84,	1263.3},
			[3] = {  3.0994,	-125.54,	1239.5},
			[4] = { -2.3851,	-55.487,	1006.7},
		},
		SFC_k			= {  0,			-0.0002618,	0.5813},
		power_RPM_k		= { -0.0778,	 0.2506,	0.8099},
		power_RPM_min	= 9.1384,
		sound_name		= "Aircrafts/Engines/EngineGE",
	},
	engines_nozzles =
	{
		[1] =
		{
			diameter			= 0.6,
			exhaust_length_ab	= 0.1,
		}, -- end of [1]
		[2] =
		{
			diameter			= 0.6,
			exhaust_length_ab	= 0.1,
		}, -- end of [2]
	}, -- end of engines_nozzles

	crew_size = 2,
	crew_members =
	{
		[1] =
		{
			ejection_seat_name	= 0,
			drop_canopy_name	= 0,
			pos					= { 1.3, 0, 1.3},
			pilot_body_arg		= 50,
			canopy_arg			= 38,
			--canopy_args			= {38},
			can_be_playable		= true,
			role				= "pilot",
			role_display_name	= _("Pilot"),
		},
		[2] =
		{
			ejection_seat_name	= 0,
			drop_canopy_name	= 0,
			pos					= { 2.7, -0.8, 1.3},
			pilot_body_arg		= 472,
			canopy_arg			= 421,
			--canopy_args			= {38},
			can_be_playable		= true,
			role				= "copilot",
			role_display_name	= _("Copilot/Gunner"),
		},
	}, -- end of crew_members
	crew_stations = "HumanOrchestra",
	doors_movement  = 2,
	mechanimations = {       
		   WindscreenWiper0 = {
                {Transition = {"Any", "Hang"}, Sequence = {{C = {{"Sleep", "for", 0.0}}}}},
                {Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 13, "to", 0.0, "at", 2.0 / 60.0 * 60.0, "sign", -1}}}}},
                {Transition = {"Any", "CustomStage0"}, Sequence = {{C = {{"Arg", 13, "to", 1.0, "at", 2.0 / 60.0 * 60.0, "sign", 1}}}, {C = {{"Arg", 13, "to", 0.0, "at", 2.0 / 60.0 * 60.0, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
                {Transition = {"Any", "CustomStage1"}, Sequence = {{C = {{"Arg", 13, "to", 1.0, "at", 2.0 / 60.0 * 90.0, "sign", 1}}}, {C = {{"Arg", 13, "to", 0.0, "at", 2.0 / 60.0 * 90.0, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},               
            },
            WindscreenWiper1 = {
                {Transition = {"Any", "Hang"}, Sequence = {{C = {{"Sleep", "for", 0.0}}}}},
                {Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 14, "to", 0.0, "at", 2.0 / 60.0 * 60.0, "sign", -1}}}}},
                {Transition = {"Any", "CustomStage0"}, Sequence = {{C = {{"Arg", 14, "to", 1.0, "at", 2.0 / 60.0 * 60.0, "sign", 1}}}, {C = {{"Arg", 14, "to", 0.0, "at", 2.0 / 60.0 * 60.0, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
                {Transition = {"Any", "CustomStage1"}, Sequence = {{C = {{"Arg", 14, "to", 1.0, "at", 2.0 / 60.0 * 90.0, "sign", 1}}}, {C = {{"Arg", 14, "to", 0.0, "at", 2.0 / 60.0 * 90.0, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},              
            },
			Door0 = { -- operator canopy
				{Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 421, "to", 0.9, "in", 2.0},},},}, Flags = {"Reversible"},},
				{Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 421, "to", 0.0, "in", 2.0},},},}, Flags = {"Reversible", "StepsBackwards"},},
			},
			Door1 = { -- pilot canopy
				{Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 38, "to", 0.9, "in", 2.0},},},}, Flags = {"Reversible"},},
				{Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "to", 0.0, "in", 2.0},},},}, Flags = {"Reversible", "StepsBackwards"},},
			},

			Pylon0Elevation = {	-- Pylon LO
				{Transition = {"Any", "Any"},	Sequence = {{C = {{"Arg", 640, "from", -0.1667, "to", 0.0556, "in", 1.2},},},}, Flags = {"Reversible"},},

				{Transition = {"Any", "Taxi"},  Sequence = {{C = {{"Arg", 640, "to", -0.055, "speed", 1.0 / 40.0},},},}, Flags = {"Reversible"},},-- ground stow position	-5deg, -5/90 = 0.055
				{Transition = {"Any", "Medium"},Sequence = {{C = {{"Sleep", "for", 0.5}}},
															{C = {{"Arg", 640, "to",  0.044, "speed", 1.0 / 40.0},},},}, Flags = {"Reversible"},}, -- flight mode position 4deg, 4/90=0.044				
				{Transition = {"Any", "Low"}, 	Sequence = {{C = {{"Arg", 640, "to",   -1.0, "speed", 1.0 / 20.0 , "sign", -1.0},},},},},	-- down movement
				{Transition = {"High", "Low"}, 	Sequence = {{C = {{"Arg", 640, "to",   -1.0, "speed", 1.0 / 20.0 , "sign", -1.0},},},}, Flags = {"Reversible"},},	-- down 
				{Transition = {"Any", "High"},  Sequence = {{C = {{"Arg", 640, "to",    1.0, "speed", 1.0 / 20.0 , "sign",  1.0},},},},},	-- up movement
				{Transition = {"Low", "High"},  Sequence = {{C = {{"Arg", 640, "to",    1.0, "speed", 1.0 / 20.0 , "sign",  1.0},},}, },Flags = {"Reversible"},},	-- up
			},
			Pylon1Elevation = {	-- Pylon LI
				{Transition = {"Any", "Any"},	Sequence = {{C = {{"Arg", 641, "from", -0.1667, "to", 0.0556, "in", 1.2},},},}, Flags = {"Reversible"},},

				{Transition = {"Any", "Taxi"},  Sequence = {{C = {{"Arg", 641, "to", -0.055, "speed", 1.0 / 40.0},},},}, Flags = {"Reversible"},},	-- ground stow position
				{Transition = {"Any", "Medium"},Sequence = {{C = {{"Sleep", "for", 0.5}}},
															{C = {{"Arg", 641, "to",  0.044, "speed", 1.0 / 40.0},},},}, Flags = {"Reversible"},}, -- flight mode position
				{Transition = {"Any", "Low"}, 	Sequence = {{C = {{"Arg", 641, "to",   -1.0, "speed", 1.0 / 20.0 , "sign", -1.0},},},},},	-- down movement
				{Transition = {"High", "Low"}, 	Sequence = {{C = {{"Arg", 641, "to",   -1.0, "speed", 1.0 / 20.0 , "sign", -1.0},},},}, Flags = {"Reversible"},},	-- down 
				{Transition = {"Any", "High"},  Sequence = {{C = {{"Arg", 641, "to",    1.0, "speed", 1.0 / 20.0 , "sign",  1.0},},},},},	-- up movement
				{Transition = {"Low", "High"},  Sequence = {{C = {{"Arg", 641, "to",    1.0, "speed", 1.0 / 20.0 , "sign",  1.0},},}, },Flags = {"Reversible"},},	-- up
			},
			Pylon2Elevation = {	-- Pylon RI
				{Transition = {"Any", "Any"},	Sequence = {{C = {{"Arg", 642, "from", -0.1667, "to", 0.0556, "in", 1.2},},},}, Flags = {"Reversible"},},

				{Transition = {"Any", "Taxi"},  Sequence = {{C = {{"Arg", 642, "to", -0.055, "speed", 1.0 / 40.0},},},}, Flags = {"Reversible"},},	-- ground stow position
				{Transition = {"Any", "Medium"},Sequence = {{C = {{"Sleep", "for", 0.5}}},
															{C = {{"Arg", 642, "to",  0.044, "speed", 1.0 / 40.0},},},}, Flags = {"Reversible"},}, -- flight mode position
				{Transition = {"Any", "Low"}, 	Sequence = {{C = {{"Arg", 642, "to",   -1.0, "speed", 1.0 / 20.0 , "sign", -1.0},},},},},	-- down movement
				{Transition = {"High", "Low"}, 	Sequence = {{C = {{"Arg", 642, "to",   -1.0, "speed", 1.0 / 20.0 , "sign", -1.0},},},}, Flags = {"Reversible"},},	-- down 
				{Transition = {"Any", "High"},  Sequence = {{C = {{"Arg", 642, "to",    1.0, "speed", 1.0 / 20.0 , "sign",  1.0},},},},},	-- up movement
				{Transition = {"Low", "High"},  Sequence = {{C = {{"Arg", 642, "to",    1.0, "speed", 1.0 / 20.0 , "sign",  1.0},},}, },Flags = {"Reversible"},},	-- up
			},
			Pylon3Elevation = {	-- Pylon RO
				{Transition = {"Any", "Any"},	Sequence = {{C = {{"Arg", 643, "from", -0.1667, "to", 0.0556, "in", 1.2},},},}, Flags = {"Reversible"},},

				{Transition = {"Any", "Taxi"},  Sequence = {{C = {{"Arg", 643, "to", -0.055, "speed", 1.0 / 40.0},},},}, Flags = {"Reversible"},},	-- ground stow position
				{Transition = {"Any", "Medium"},Sequence = {{C = {{"Sleep", "for", 0.5}}},
															{C = {{"Arg", 643, "to",  0.044, "speed", 1.0 / 40.0},},},}, Flags = {"Reversible"},}, -- flight mode position
				{Transition = {"Any", "Low"}, 	Sequence = {{C = {{"Arg", 643, "to",   -1.0, "speed", 1.0 / 20.0 , "sign", -1.0},},},},},	-- down movement
				{Transition = {"High", "Low"}, 	Sequence = {{C = {{"Arg", 643, "to",   -1.0, "speed", 1.0 / 20.0 , "sign", -1.0},},},}, Flags = {"Reversible"},},	-- down 
				{Transition = {"Any", "High"},  Sequence = {{C = {{"Arg", 643, "to",    1.0, "speed", 1.0 / 20.0 , "sign",  1.0},},},},},	-- up movement
				{Transition = {"Low", "High"},  Sequence = {{C = {{"Arg", 643, "to",    1.0, "speed", 1.0 / 20.0 , "sign",  1.0},},}, },Flags = {"Reversible"},},	-- up 
			},
			SearchLight0Elevation = {
				{Transition = {"Any", "Retract"},	Sequence = {{C = {{"Arg", 423, "from", 1.0,  "to",   0.0, "speed", 1.0},},},},},
				{Transition = {"Any", "Extend"},	Sequence = {{C = {{"Arg", 423, "from", 0.0,  "to",   1.0, "speed", 1.0},},},},},
			},
			SearchLight0Panning = {
				{Transition = {"Any", "Right"},	Sequence = {{C = {{"Arg", 424, "from",  1.0,  "to",   -1.0, "speed", 1.0},},},},},
				{Transition = {"Any", "Left"},	Sequence = {{C = {{"Arg", 424, "from", -1.0,  "to",    1.0, "speed", 1.0},},},},},
			},
			HeadLights = {
                {Transition = {"Any", "Retract"},   Sequence = {{C = {{"Arg", 209, "to", 0.0, "speed", 1.0},      
																	{"Arg", 423, "to", 0.0, "speed", 0.5}, 
																	{"Arg", 424, "to", 0.0, "speed", 0.5},},},},},
                {Transition = {"Any", "Taxi"}, 		Sequence = {{C = {{"Arg", 209, "to", 1.0, "speed", 0.5},      
																	{"Arg", 423, "to", 0.95, "speed", 0.5}, 
																	{"Arg", 424, "to", 0.0, "speed", 0.5},},},},},
				{Transition = {"Any", "High"}, 		Sequence = {{C = {{"Arg", 209, "to", 1.0, "speed", 0.5},																 
																	{"Arg", 423, "to", 0.7, "speed", 0.1}, 
																	{"Arg", 424, "to", 0.0, "speed", 0.5},},},},},
				{Transition = {"Retract", "Taxi"}, 	Sequence = {{C = {{"Arg", 209,"from", 0.0, "to", 1.0, "in", 10.0},      
																	{"Arg", 423, "to", 0.95, "speed", 0.5}},},},Flags = {"Reversible"}},
				{Transition = {"High", "Taxi"}, 	Sequence = {{C = {{"Arg", 209, "to", 1.0, "in", 0.5},      
																	{"Arg", 423,"from", 0.7, "to", 0.95,  "in", 3.0}},},},Flags = {"Reversible"}},
				{Transition = {"Taxi", "High"}, 	Sequence = {{C = {{"Arg", 209, "to", 1.0, "in",  10.0},													
																	{"Arg", 423,"from", 0.95, "to", 0.7,  "in",   5.0}},},},Flags = {"Reversible"}},
            },
			
			
			
    }, -- end of mechanimations
	net_animation =
	{
		-- arguments to be synced to phantom
	--	19,			-- gun turret az
	--	20,			-- gun turret el
	--	350,		-- gun turret rollback
	--	349,		-- gun turret shellsmovement

		449,		-- left AADS yaw
		450,		-- left AADS pitch
		530,		-- right AADS yaw
		531,		-- right AADS pitch
		
		600,		-- PNVS az
		605,		-- FCR/RFI

		2,			-- tail wheel yaw
		11, 12,		-- cyclic stick
		15, 16,		-- stabilizer

		306, 307,	-- TADS turret

		509, 519,	-- NVG
		552, 553,	-- mask
		506, 507, 508,	-- PLT helmet kit
		516, 517, 518,	-- CPG helmet kit
		459, 460,	-- died/alive
		529, 549,	-- helmet correction
		546, 547, 548,	-- CPG works with...
		550, 551,	-- hands on stick
		39, 99,		-- PLT head turn
		337, 399,	-- CPG head turn
		520, 540,	-- crew breathing
		521, 541,	-- crew shaking

		50, 472,	-- show crew bodies

	},

	fires_pos =
	{
		[1]		= {  0,		 0,		 0},
		[2]		= { -1.73,	 0.19,	-0.916},
		[3]		= { -1.73,	 0.19,	 0.916},
		[4]		= { -7.4,	-0.72,	 0},
		[5]		= {  0.47,	-0.39,	 0},
		[6]		= { -1.17,	-0.4,	 0},
		[7]		= {  0,		 0,		 0},
		[8]		= {  0,		 0,		 0},
		[9]		= {  0,		 0,		 0},
		[10]	= {  0,		 0,		 0},
		[11]	= {  0,		 0,		 0},
	},

	effects_presets =
	{
		{effect = "APU_STARTUP_BLAST", preset = "mi8mtv2", ttl = 3.0},
	},

	chaff_flare_dispenser =
	{
		[1] =		-- flare
		{
			dir	= {  0.821, -0.191, -0.537 },
			pos	= { -5.857, -0.301, -0.543 },
		},
		[2] =		-- flare
		{
			dir	= {  0.821, -0.191, 0.537 },
			pos	= { -5.857, -0.301, 0.542 },
		},
		[3] =		-- chaff
		{
			dir	= { -0.484,  0.750, -0.451 },
			pos	= { -7.339, -0.169, -0.456 },
		},
	},

	Failures =
	{
		-- electric system
		--{ id = 'Failure_Elec_UtilityBattery',					label = _('Utility Battery FAILURE'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'APU_Fire',							label = _('APU Fire'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'LeftEngine_Fire',					label = _('Engine 1 Fire'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RightEngine_Fire',					label = _('Engine 2 Fire'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },			
	},

	Damage = verbose_to_dmg_properties(
	{
		["GUN"]						= { args = {610}, critical_damage = 3 },

		["NOSE_CENTER"]				= { args = {82}, critical_damage = 2 },	-- turret

		["RADAR"]					= { args = {146}, critical_damage = 2 },

		["COCKPIT"]					= { args = {65}, critical_damage = 3 },
		["CABIN_BOTTOM"]			= { args = {300}, critical_damage = 3 },

		["NOSE_LEFT_SIDE"]			= { args = {150}, critical_damage = 3 },
		["NOSE_RIGHT_SIDE"]			= { args = {149}, critical_damage = 3 },
		["LEFT_GEAR_BOX"]			= { args = {257}, critical_damage = 3 },
		["RIGHT_GEAR_BOX"]			= { args = {256}, critical_damage = 3 },
		["NOSE_BOTTOM"]				= { args = {148}, critical_damage = 3 },

		["FUSELAGE_TOP"]			= { args = {151}, critical_damage = 3 },
		["FUSELAGE_LEFT_SIDE"]		= { args = {154}, critical_damage = 5 },
		["FUSELAGE_RIGHT_SIDE"]		= { args = {153}, critical_damage = 5 },
		["WING_L_PART_IN"]			= { args = {227}, critical_damage = 3 },
		["WING_R_PART_IN"]			= { args = {226}, critical_damage = 3 },
		["FUSELAGE_BOTTOM"]			= { args = {152}, critical_damage = 3 },

		["WHEEL_F"]					= { args = {264}, critical_damage = 3 },
		["WHEEL_L"]					= { args = {259}, critical_damage = 3 },
		["WHEEL_R"]					= { args = {255}, critical_damage = 3 },

		["ENGINE_L"]				= { args = {166}, critical_damage = 3 },
		["ENGINE_R"]				= { args = {160}, critical_damage = 3 },

		["WING_L_IN"]				= { args = {225}, critical_damage = 5, deps_cells = {"WING_L_OUT"} },
		["WING_L_OUT"]				= { args = {224}, critical_damage = 5 },

		["WING_R_IN"]				= { args = {215}, critical_damage = 5, deps_cells = {"WING_R_OUT"} },
		["WING_R_OUT"]				= { args = {214}, critical_damage = 5 },

		["TAIL_TOP"]				= { args = {155}, critical_damage = 5 },
		["TAIL_LEFT_SIDE"]			= { args = {158}, critical_damage = 5 },
		["TAIL_RIGHT_SIDE"]			= { args = {157}, critical_damage = 5 },
		["TAIL_BOTTOM"]				= { args = {156}, critical_damage = 5 },

		["FIN_L_CENTER"]			= { args = {245}, critical_damage = 3, deps_cells = {"FIN_L_TOP", "FIN_L_BOTTOM"} },
		["FIN_R_CENTER"]			= { args = {242}, critical_damage = 3, deps_cells = {"FIN_L_TOP", "FIN_L_BOTTOM"} },
		["FIN_L_BOTTOM"]			= { args = {81}, critical_damage = 3 },	-- virtual

		["FIN_L_TOP"]				= { args = {61}, critical_damage = 3, deps_cells = {"FIN_R_TOP", "STABILIZATOR_L", "WHEEL_F", "RUDDER_R"} },
		["FIN_R_TOP"]				= { args = {62}, critical_damage = 3, deps_cells = {"RUDDER_R"} },

		["STABILIZATOR_L"]			= { args = {63}, critical_damage = 3 },

		["RUDDER_R"]				= { args = {238}, critical_damage = 5 },

		["ROTOR"]					= { --[[args = {146},]] critical_damage = 20, deps_cells = {"BLADE_1_IN", "BLADE_2_IN", "BLADE_3_IN", "BLADE_4_IN", "RADAR"} },

		["BLADE_1_IN"]				= { --[[args = {},]] critical_damage = 4, deps_cells = {"BLADE_1_CENTER", "BLADE_1_OUT"} },
		["BLADE_1_CENTER"]			= { args = {117}, critical_damage = 3, deps_cells = {"BLADE_1_OUT"} },
		["BLADE_1_OUT"]				= { args = {116}, critical_damage = 2, damage_boundary = 1.0 },

		["BLADE_2_IN"]				= { --[[args = {},]] critical_damage = 4, deps_cells = {"BLADE_2_CENTER", "BLADE_2_OUT"} },
		["BLADE_2_CENTER"]			= { args = {120}, critical_damage = 3, deps_cells = {"BLADE_2_OUT"} },
		["BLADE_2_OUT"]				= { args = {119}, critical_damage = 2, damage_boundary = 1.0 },

		["BLADE_3_IN"]				= { --[[args = {},]] critical_damage = 4, deps_cells = {"BLADE_3_CENTER", "BLADE_3_OUT"} },
		["BLADE_3_CENTER"]			= { args = {123}, critical_damage = 3, deps_cells = {"BLADE_3_OUT"} },
		["BLADE_3_OUT"]				= { args = {122}, critical_damage = 2, damage_boundary = 1.0 },

		["BLADE_4_IN"]				= { --[[args = {},]] critical_damage = 4, deps_cells = {"BLADE_4_CENTER", "BLADE_4_OUT"} },
		["BLADE_4_CENTER"]			= { args = {126}, critical_damage = 3, deps_cells = {"BLADE_4_OUT"} },
		["BLADE_4_OUT"]				= { args = {125}, critical_damage = 2, damage_boundary = 1.0 },

		["CREW_1"]					= { --[[args = {},]] critical_damage = 1 },
		["CREW_2"]					= { --[[args = {},]] critical_damage = 1 },

		-- additional non-standard
		["WHEEL_P_L"]				= { --[[args = {},]] critical_damage = 1 },
		["WHEEL_P_R"]				= { --[[args = {},]] critical_damage = 1 },
		["WHEEL_P_REAR"]			= { --[[args = {},]] critical_damage = 1 },

	}),-- end of Damage

	DamageParts =
	{
		--[1] = "F-16C_oblomok_wing_R",
		--[2] = "F-16C_oblomok_wing_L",
	},
	
	SFM_Data = {
		aerodynamics =
		{
			Cy0			=	0,
			Mzalfa		=	4.355,
			Mzalfadt	=	0.8,
			kjx			=	2.75,
			kjz			=	0.00125,
			Czbe		=	-0.016,
			cx_gear		=	0.0268,
			cx_flap		=	0.05,
			cy_flap		=	0.52,
			cx_brk		=	0.06,
			table_data =
			{
				[1] = 	{0,	0.0165,	0.07,	0.132,	0.032,	0.5,	30,	1.2},
				[2] = 	{0.2,	0.0165,	0.07,	0.132,	0.032,	1.5,	30,	1.2},
				[3] = 	{0.4,	0.0165,	0.07,	0.133,	0.032,	2.5,	30,	1.2},
				[4] = 	{0.6,	0.0165,	0.073,	0.133,	0.043,	3.5,	30,	1.2},
				[5] = 	{0.7,	0.017,	0.076,	0.134,	0.045,	3.5,	28.666666666667,	1.18},
				[6] = 	{0.8,	0.024,	0.079,	0.137,	0.052,	3.5,	27.333333333333,	1.16},
				[7] = 	{0.9,	0.041,	0.083,	0.143,	0.058,	3.5,	26,	1.14},
				[8] = 	{1,	0.062,	0.085,	0.18,	0.1,	3.5,	24.666666666667,	1.12},
				[9] = 	{1.05,	0.061,	0.0855,	0.1975,	0.095,	3.5,	24,	1.11},
				[10] = 	{1.1,	0.06,	0.086,	0.215,	0.09,	3.15,	18,	1.1},
				[11] = 	{1.2,	0.051,	0.083,	0.228,	0.12,	2.45,	17,	1.05},
				[12] = 	{1.3,	0.046,	0.077,	0.237,	0.17,	1.75,	16,	1},
				[13] = 	{1.49,	0.044,	0.062,	0.251,	0.2,	1.5125,	13.15,	0.905},
				[14] = 	{1.5,	0.043903225806452,	0.061483870967742,	0.25064516129032,	0.2058064516129,	1.5,	13,	0.9},
				[15] = 	{1.7,	0.041967741935484,	0.051161290322581,	0.24354838709677,	0.32193548387097,	0.9,	12,	0.7},
				[16] = 	{1.8,	0.041,	0.046,	0.24,	0.38,	0.86,	11.4,	0.64},
				[17] = 	{2,	0.042,	0.039,	0.222,	2.5,	0.78,	10.2,	0.52},
				[18] = 	{2.2,	0.041,	0.034,	0.227,	3.2,	0.7,	9,	0.4},
				[19] = 	{2.5,	0.039,	0.033,	0.25,	4.5,	0.7,	9,	0.4},
				[20] = 	{3.9,	0.035,	0.033,	0.35,	6,	0.7,	9,	0.4},
			}, -- end of table_data
		}, -- end of aerodynamics
		engine =
		{
			Nmg		=	35, -- RPM at idle
			MinRUD	=	0, -- Min state of the РУД
			MaxRUD	=	1, -- Max state of the РУД
			MaksRUD	=	1, -- Military power state of the РУД
			ForsRUD	=	1, -- Afterburner state of the РУД
			type	=	"TurboShaft",
			hMaxEng	=	19, -- Max altitude for safe engine operation in km
			dcx_eng	=	0.0134, -- Engine drag coeficient
			cemax	=	1.24, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			cefor	=	2.56, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			dpdh_m	=	1340, --  altitude coefficient for max thrust
			dpdh_f	=	1340, --  altitude coefficient for AB thrust
			table_data =
			{		--   M			Pmax		 Pfor
				{ 0.0	,	26000	,	26000	},
				{ 0.1	,	26000	,	26000	},
				{ 0.2	,	24430	,	24430	},
				{ 0.3	,	23040	,	23040	},
				{ 0.4	,	22090	,	22090	},
				{ 0.5	,	21490	,	21490	},
				{ 0.6	,	21310	,	21310	},
				{ 0.7	,	21400	,	21400	},
				{ 0.8	,	22090	,	22090	},
				{ 0.86	,	22780	,	22780	},
				{ 0.9	,	23300	,	23300	},
				{ 0.94	,	23650	,	23650	},
				{ 1		,	24260	,	24260	},
				{ 1.04	,	24600	,	24600	},
				{ 1.1	,	25640	,	25640	},
				
				
			}, -- end of table_data
			-- M - Mach number
			-- Pmax - Engine thrust at military power
			-- Pfor - Engine thrust at AFB
		}, -- end of engine
	},
	
	
	lights_data =
	{
		typename =	"collection",
		lights	=
		{
			[WOLALIGHT_STROBES]	=
			{
				typename = "collection",
				lights = 
				{	
					{typename = "argumentlight",	argument = 193,		controller = "Strobe", period = 1.7, flash_time = 0.05, phase_shift = 0.5},		-- anticollision light: left red
					{typename = "argumentlight",	argument = 194,		controller = "Strobe", period = 1.7, flash_time = 0.05},						-- anticollision light: right red
				},
			},--must be collection
			[WOLALIGHT_SPOTS]	=
			{
				typename = "collection",
				lights = 
				{	
					{typename = "argumentlight",	argument  = 209},		-- search/landing light
				},
			},--must be collection
			[WOLALIGHT_NAVLIGHTS]	=
			{
				typename = "collection",
				lights = 
				{	
					{typename = "argumentlight",	argument  = 190},		-- navigation lights: left red
					{typename = "argumentlight",	argument  = 191},		-- navigation lights: right green
					{typename = "argumentlight",	argument  = 192},		-- navigation lights: tail white
				},
			},--must be collection
			[WOLALIGHT_FORMATION_LIGHTS]	=
			{
				typename = "collection",
				lights = 
				{	
					{typename = "argumentlight",	argument  = 200},		-- formation lights
				},
			},--must be collection
			[WOLALIGHT_AUX_LIGHTS]	=
			{
				typename = "collection",
				lights = 
				{
					{typename = "argumentlight",	argument = 195,		controller = "Strobe", period = 1.7, flash_time = 0.05, phase_shift = 0.5},		-- anticollision light: left white
					{typename = "argumentlight",	argument = 196,		controller = "Strobe", period = 1.7, flash_time = 0.05},						-- anticollision light: right white
				},
			},--must be collection
		}, -- end of lights
	},-- end of lights_data
	
	-- Aircraft Additional Properties

	AddPropAircraft = {
		{ id = "FCR_RFI_removed" , control = 'checkbox', label = _('FCR/RFI removed'), defValue = true, weightWhenOn = -237.23, arg = 605},	-- FCR weight = 523 pounds
		{ id = "PltNVG" , control = 'checkbox', label = _('Allow Plt NVG'), defValue = true, arg = 509},
		{ id = "CpgNVG" , control = 'checkbox', label = _('Allow Cpg NVG'), defValue = true, arg = 519},		
		addComboList("FlareBurstCount",			_('Flare Burst Count'), 					{"1","2","3","4","6","8"}),
		addComboList("FlareBurstInterval",		_('Flare Burst Interval, [sec]'), 			{"0.1","0.2","0.3","0.4"}),
		addComboList("FlareSalvoCount",			_('Flare Salvo Count'), 					{"1","2","4","8",_("Continuous")}),
		addComboList("FlareSalvoInterval",		_('Flare Salvo Interval, [sec]'), 			{"1","2","3","4","5","8",_("Random")}),
		addComboList("FlareProgramDelay",		_('Flare Delay betw Programs, [sec]'), 		{"1","2","3","4"}),
					-- AI HELPER SECTION
		{ id = "mul_Label", control = 'label', label = _('AI HELPER'), xLbl = 150,},			
		{ id = "OverrideIFF",
			control = 'comboList',
			label = _('AI IFF Detection Mode'),
			playerOnly = true,
			values = {
				{id = 0, dispName = _("Auto")},
				{id = 1, dispName = _("Simple")},
				{id = 2, dispName = _("Label Only")},
				{id = 3, dispName = _("Realistic")}
			},
			defValue  = 0,
			wCtrl = 150,
		},
		{ id = "TrackAirTargets" , control = 'checkbox', label = _('Track air targets','Track Air Targets'), defValue = true},
					-- MULTIPLAYER SECTION
		{ id = "mul_Label", control = 'label', label = _('MULTIPLAYER'), xLbl = 150,},
		{ id = "NetCrewControlPriority",
			control = 'comboList',
			label = _('Aircraft Control Priority'),
			playerOnly = true,
			values = {
				{id =  0, dispName = _("Pilot")},
				{id =  1, dispName = _("CPG")},
				{id = -1, dispName = _("Ask Always")},
				{id = -2, dispName = _("Equally Responsible")}
			},
			defValue  = 0,
			wCtrl = 150,
		},
		{ id = "AIDisabled" , control = 'checkbox', label = _('AI Disabled'), defValue = false},
		{ id = "HumanOrchestra"  , control = 'checkbox', label = _('Disable Multicrew'), defValue = false, playerOnly = true, },		
	},
	
	visualIR = { 
		coeffs = {	-- heat collect coef, heat loose coef, texture_coef, texture_base_val
					{0.02, 	0.01,  1.0, 0.0}, -- engines and equipment
					{ 0.1, 	0.01,  1.0, -0.1}, -- aerodynamic heat - edges for fixed wing, rotors blades for heli
					{0.003, 0.05,  1.0, 0.0}, -- weapon/canon
					{0.01, 	0.02,  4.0, 0.1}	-- overall hull -> environment
				 }
				},

	input_profile_entry = "AH-64D_BLK_II_PLT",

	InheriteCommonCallnames = true,
	SpecificCallnames = {
		["USA"] = {
					{_('ArmyAir'),			'Army_Air'},
					{_('Apache'),			'Apache'},
					{_('Crow'),				'Crow'},
					{_('Chaos'),			'Chaos'},
					{_('Sioux'),			'Sioux'},
					{_('Gatling'),			'Gatling'},
					{_('Gunslinger'),		'Gunslinger'},
					{_('Hammerhead'),		'Hammerhead'},
					{_('Bootleg'),			'Bootleg'},
					{_('Palehorse'),		'Palehorse'},
					{_('Carnivore'),		'Carnivore'},
					{_('Saber'),			'Saber'}
		}
	},
}

add_aircraft(AH_64D)