
function copyTable(src, target)
    if not target then
       target = {}
    end
	
    for i, v in pairs(src) do
        if type(v) == 'table' then
            if not target[i] then
                target[i] = {}
            end
			copyTable(v, target[i])
        else
            target[i] = v
        end
    end
	
    return target
end

function applyRewriteSettings(src, target)
	if not src then
		return
	end
	
    for i, v in pairs(src) do
        if type(v) == 'table' then
            target[i] = {}
            copyTable(v, target[i])
        else
            target[i] = v
        end
    end
end

g_suit_effectiveness		= 1

noPassivCounterm = {
	CMDS_Edit 				= false,
	SingleChargeTotal 		= 0,
	chaff 					= {default = 0, increment = 0, chargeSz = 0},
	flare 					= {default = 0, increment = 0, chargeSz = 0}
}

passivCounterm = {
	CMDS_Edit 				= true,
	SingleChargeTotal 		= 60,
	chaff 					= {default = 30, increment = 30, chargeSz = 1},
	flare 					= {default = 15, increment = 15, chargeSz = 2}
}

-- KC-130 and KC-135MPRS have 'floating' drogue contact point lateral positioning.
-- The short probe coordinates were adjusted to account for this.
air_refuel_receptacle_pos_short = {5.66, 0.483, 0.311}
air_refuel_receptacle_pos_long = {5.818, 0.483, 0.311}

panelRadio_CE_BE_EE = {
	[1] = {  
		name = _("TRAP-136"),
		range = {min = 118.0, max = 399.975},
		channels = {
			[1] = { name = _("Channel 1"), default = 118.0, modulation = _("AM"), connect = true},
			[2] = { name = _("Channel 2"), default = 119.25, modulation = _("AM")},
			[3] = { name = _("Channel 3"), default = 122.0, modulation = _("AM")},
			[4] = { name = _("Channel 4"), default = 126.5, modulation = _("AM")},
			[5] = { name = _("Channel 5"), default = 127.0, modulation = _("AM")},
			[6] = { name = _("Channel 6"), default = 129.0, modulation = _("AM")},
			[7] = { name = _("Channel 7"), default = 131.0, modulation = _("AM")},
			[8] = { name = _("Channel 8"), default = 133.0, modulation = _("AM")},
			[9] = { name = _("Channel 9"), default = 141.0, modulation = _("AM")},
			[10] = { name = _("Channel 10"), default = 250.5, modulation = _("AM")},
			[11] = { name = _("Channel 11"), default = 251.0, modulation = _("AM")},
			[12] = { name = _("Channel 12"), default = 253.0, modulation = _("AM")},
			[13] = { name = _("Channel 13"), default = 254.0, modulation = _("AM")},
			[14] = { name = _("Channel 14"), default = 257.0, modulation = _("AM")},
			[15] = { name = _("Channel 15"), default = 260.0, modulation = _("AM")},
			[16] = { name = _("Channel 16"), default = 261.0, modulation = _("AM")},
			[17] = { name = _("Channel 17"), default = 262.0, modulation = _("AM")},
			[18] = { name = _("Channel 18"), default = 263.0, modulation = _("AM")},
			[19] = { name = _("Channel 19"), default = 267.0, modulation = _("AM")},
			[20] = { name = _("Channel 20"), default = 270.0, modulation = _("AM")},
		}			
	},
	
	[2] = {  
		name = _("TRAP-137B"),
		range = {min = 225.0, max = 399.975},
		channels = {
			[1] = { name = _("Channel 1"), default = 225.0, modulation = _("AM")},
			[2] = { name = _("Channel 2"), default = 230.0, modulation = _("AM")},
			[3] = { name = _("Channel 3"), default = 240.0, modulation = _("AM")},
			[4] = { name = _("Channel 4"), default = 250.5, modulation = _("AM")},
			[5] = { name = _("Channel 5"), default = 251.0, modulation = _("AM")},
			[6] = { name = _("Channel 6"), default = 256.0, modulation = _("AM")},
			[7] = { name = _("Channel 7"), default = 257.0, modulation = _("AM")},
			[8] = { name = _("Channel 8"), default = 262.0, modulation = _("AM")},
			[9] = { name = _("Channel 9"), default = 263.0, modulation = _("AM")},
			[10] = { name = _("Channel 10"), default = 267.0, modulation = _("AM")},
			[11] = { name = _("Channel 11"), default = 270.0, modulation = _("AM")},
			[12] = { name = _("Channel 12"), default = 254.0, modulation = _("AM")},
			[13] = { name = _("Channel 13"), default = 264.0, modulation = _("AM")},
			[14] = { name = _("Channel 14"), default = 266.0, modulation = _("AM")},
			[15] = { name = _("Channel 15"), default = 265.0, modulation = _("AM")},
			[16] = { name = _("Channel 16"), default = 252.0, modulation = _("AM")},
			[17] = { name = _("Channel 17"), default = 268.0, modulation = _("AM")},
			[18] = { name = _("Channel 18"), default = 271.0, modulation = _("AM")},
			[19] = { name = _("Channel 19"), default = 275.0, modulation = _("AM")},
			[20] = { name = _("Channel 20 (N/A in 'Easy Comms')"), default = 360.0, modulation = _("AM")},
		}			
	}
}

function makeAttribute(WorldID, refuelable)
	local res = {wsType_Air, wsType_Airplane, wsType_Fighter, WorldID, "Multirole fighters"}
	
	if refuelable == true then
		res[#res + 1] = "Refuelable"
	end
	
	return res
end

local defaultOptionWidgedWidth = 75

function makeAircraftProperties(...)
	
	-- Properties common for each aircraft version
	local props = {
		{ id = "RadarCoverSettings", control = 'comboList', label = _('Force Radar Cover State At Start'), playerOnly = true, 
		  values = {{id = 1, dispName = _("NO")},
					{id = 2, dispName = _("FORCE ON")},
					{id = 3, dispName = _("FORCE OFF")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
	
		{ id = "ChaffMultiNumber", control = 'comboList', label = _('Chaff Burst Count'), playerOnly = true, 
		  values = {{id = 1, dispName = _("1")},
					{id = 2, dispName = _("2")},
					{id = 3, dispName = _("3")},
					{id = 4, dispName = _("4")},
					{id = 5, dispName = _("6")},
					{id = 6, dispName = _("8")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "ChaffMultiTime", control = 'comboList', label = _('Chaff Burst Interval'), playerOnly = true, 
		  values = {{id = 1, dispName = _("0.05 s")},
					{id = 2, dispName = _("0.1 s")},
					{id = 3, dispName = _("0.15 s")},
					{id = 4, dispName = _("0.2 s")},
					{id = 5, dispName = _("0.3 s")},
					{id = 6, dispName = _("0.4 s")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "ChaffProgramNumber", control = 'comboList', label = _('Chaff Salvo Count'), playerOnly = true, 
		  values = {{id = 1, dispName = _("1")},
					{id = 2, dispName = _("2")},
					{id = 3, dispName = _("4")},
					{id = 4, dispName = _("8")},
					{id = 5, dispName = _("Continuous")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "ChaffProgramTime", control = 'comboList', label = _('Chaff Salvo Interval'), playerOnly = true, 
		  values = {{id = 1, dispName = _("1.0 s")},
					{id = 2, dispName = _("2.0 s")},
					{id = 3, dispName = _("3.0 s")},
					{id = 4, dispName = _("4.0 s")},
					{id = 5, dispName = _("5.0 s")},
					{id = 6, dispName = _("8.0 s")},
					{id = 7, dispName = _("Random")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "FlareMultiNumber", control = 'comboList', label = _('Flare Burst Count'), playerOnly = true, 
		  values = {{id = 1, dispName = _("1")},
					{id = 2, dispName = _("2")},
					{id = 3, dispName = _("4")},
					{id = 4, dispName = _("8")},
					{id = 5, dispName = _("Continuous")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "FlareMultiTime", control = 'comboList', label = _('Flare Burst Interval'), playerOnly = true, 
		  values = {{id = 1, dispName = _("3.0 s")},
					{id = 2, dispName = _("4.0 s")},
					{id = 3, dispName = _("6.0 s")},
					{id = 4, dispName = _("8.0 s")},
					{id = 5, dispName = _("10.0 s")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "GunBurstSettings", control = 'comboList', label = _('Gun Burst Settings'), playerOnly = true, 
		  values = {{id = 0, dispName = _("OFF")},
					{id = 1, dispName = _("BURST")},
					{id = 2, dispName = _("0.5 s")},
					{id = 3, dispName = _("1 s")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},	
		
		{ id = "RocketSalvoF1", control = 'comboList', label = _('F1 Rocket Launcher Salvo Count'), playerOnly = true, 
		  values = {{id = 1, dispName = _("6")},
					{id = 2, dispName = _("12")},
					{id = 3, dispName = _("18")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "RocketSalvoF4", control = 'comboList', label = _('F4 Rocket Launcher Salvo Count'), playerOnly = true, 
		  values = {{id = 1, dispName = _("1")},
					{id = 2, dispName = _("3")},
					{id = 3, dispName = _("6")},
					{id = 4, dispName = _("18")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "LaserCode100",		control = 'spinbox',  label = _('Laser code for GBUs, 1x11'), defValue = 6, min = 5, max = 7, dimension = ' ', playerOnly = true},
		{ id = "LaserCode10",		control = 'spinbox',  label = _('Laser code for GBUs, 11x1'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},
		{ id = "LaserCode1",		control = 'spinbox',  label = _('Laser code for GBUs, 111x'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},		
	}
	
	-- Add specific properties, added via the variable arguments list
	local arg = {...}
	for i, v in ipairs(arg) do
		props[#props + 1] = {}
		copyTable(v, props[#props])
	end
	
	return props
end

-- Now it is used at least in F1EE
extraAircraftProp_INSStartMode =
	{ id = "INSStartMode", control = 'comboList', label = _('INS start position always correct'), playerOnly = true, 
	  values = {{id = 1, dispName = _("YES")},
				{id = 2, dispName = _("NO")}},
	  defValue  = 1,
	  wCtrl     = defaultOptionWidgedWidth
	}

-- Now it is used at least in F1EE
extraAircraftProp_RWR_type =
	{ id = "RWR_type", control = 'comboList', label = _('RWR type'), playerOnly = true, -- TODO: to enable for AI
	  values = {{id = "ALR_300", dispName = _("ALR-300"), value = 1},
				{id = "BF", dispName = _("BF"), value = 2}},
	  defValue  = 1,
	  wCtrl     = defaultOptionWidgedWidth
	}
			
function DEFA_553(tbl)

	tbl.category 		 = CAT_GUN_MOUNT 
	tbl.name 	 		 = "defa_553"
	tbl.supply 	 		 = 
	{
		shells 			 = {"DEFA552_30"},
		mixes  			 = {{1,2,2,1,2,2}}, 
		count  			 = 135,
	}
	
	if tbl.mixes then 
	   tbl.supply.mixes  = tbl.mixes
	   tbl.mixes	     = nil
	end
	
	tbl.gun = 
	{
		max_burst_length = 25,
		rates 			 = {1200},
		recoil_coeff 	 = 1,
		barrels_count 	 = 1,
	}
	
	if tbl.rates then 
	    tbl.gun.rates    = tbl.rates
	    tbl.rates	     = nil
	end
	
	drop_cartridge 				= cartridge_30mm
	tbl.ejector_pos 			= tbl.ejector_pos or {-0.4, -1.2, 0.18}
	tbl.ejector_dir 			= {0,-1,0}
	tbl.supply_position  		= tbl.supply_position or {0,  0.3, -0.3}
	tbl.aft_gun_mount 			= false
	tbl.effective_fire_distance = 1800
	tbl.drop_cartridge 			= 0
	tbl.muzzle_pos				= tbl.muzzle_pos or {0,0,0} -- all position from connector
	tbl.muzzle_pos_connector	= tbl.muzzle_pos_connector or "Gun_point" -- all position from connector
	tbl.azimuth_initial 		= tbl.azimuth_initial or 0
	tbl.elevation_initial 		= tbl.elevation_initial or 0
	
	if tbl.effects == nil then
		tbl.effects = {{ name = "FireEffect", arg = tbl.effect_arg_number or 436 },
					   { name = "HeatEffectExt", shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
					   { name = "SmokeEffect"}}
	end
	
	return declare_weapon(tbl)
end

function declareGuns(Name)
	local gunsSpecifics = {
		left = {muzzle_pos_connector = "Gun_point_1",
		 rates = {1249},
		 mixes = {{2,1,1,1,1,1}},
		 effect_arg_number = 434,
		 azimuth_initial = 0,
		 elevation_initial = 0,
		 supply_position = {0.646, -0.876, -0.205}
		},
		right = {muzzle_pos_connector = "Gun_point_2",
		 rates = {1229},
		 mixes = {{1,1,2,1,1,1}},
		 effect_arg_number = 435,
		 azimuth_initial = 0,
		 elevation_initial = 0,
		 supply_position = {0.646, -0.876, 0.205}
		}
	}
	
	if Name == 'Mirage-F1CT' then
		-- Right only
		return {DEFA_553(gunsSpecifics.right)}
	elseif Name == 'Mirage-F1CR' then
		-- Left only
		return {DEFA_553(gunsSpecifics.left)}
	else
		-- Left and right
		return {DEFA_553(gunsSpecifics.left), DEFA_553(gunsSpecifics.right)}
	end
end

function pylon_loadout(clsid, arg_value, arg_increment, attach_point_position, required, forbidden)
	result = {}
	result['CLSID'] = clsid
	if arg_value then
		result['arg_value'] = arg_value
	end
	if arg_increment then
		result['arg_increment'] = arg_increment
	end
	if attach_point_position then
		result['attach_point_position'] = attach_point_position
	end
	if required then
		reqlist = {}
		for i, pylon in ipairs(required) do
			reqlist[#reqlist+1]= {station = pylon, loadout = {clsid}}
		end	
		result['required'] = reqlist
	end
	
	if forbidden then
		result['forbidden'] = forbidden
	end
	return result
end
	
id_AIM_9B = "{AIM-9B}"
id_AIM_9J = "{AIM-9J}"
id_AIM_9P = "{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}"
id_AIM_9JULI  = "{AIM-9JULI}"
id_MAGIC_I = "{R550_Magic_1}"
id_MAGIC_II = "{FC23864E-3B80-48E3-9C03-4DA8B1D7497B}"
id_MK82 = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"
id_MK83 = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}"
id_BR_250 = "BR_250"
id_BR_500 = "BR_500"
id_SAMP125LD = "{SAMP125LD}"-- SAMP 125 Low Drag
id_SAMP250LD = "{SAMP250LD}"-- SAMP 250 Low Drag
id_SAMP250HD = "{SAMP250HD}"-- SAMP 250 High Drag
id_SAMP400LD = "{SAMP400LD}"-- SAMP 400 Low Drag
id_SAMP400HD = "{SAMP400HD}"-- SAMP 400 High Drag
id_BLU107B_DURANDAL = "{BLU107B_DURANDAL}"-- Durandal
id_BLG66_BELOUGA = "{BLG66_BELOUGA}"-- BELOUGA
id_MF1_250 = "{MATRA_F1_SNEBT250}"-- MATRA F1
id_MF1_251 = "{MATRA_F1_SNEBT251}"-- MATRA F1 AA HE
id_MF1_252 = "{MATRA_F1_SNEBT252}"-- MATRA F1	
id_MF1_253  = "{MATRA_F1_SNEBT253}"-- MATRA F1 Shaped charge
id_MF1_254_R = "{MATRA_F1_SNEBT254_RED}"-- MATRA F1 smoke
id_MF1_254_Y  = "{MATRA_F1_SNEBT254_YELLOW}"-- MATRA F1 smoke
id_MF1_254_G = "{MATRA_F1_SNEBT254_GREEN}"-- MATRA F1 smoke
id_MF1_256 = "{MATRA_F1_SNEBT256}"-- MATRA F1 AP
id_MF1_257 = "{MATRA_F1_SNEBT257}"-- MATRA F1
id_MF1_259E = "{MATRA_F1_SNEBT259E}"-- MATRA F1
id_MF4_250 = "{MATRA_F4_SNEBT250}"-- MATRA F4
id_MF4_251 = "{MATRA_F4_SNEBT251}"-- MATRA F4 AA HE
id_MF4_252 = "{MATRA_F4_SNEBT252}"-- MATRA F4
id_MF4_253 = "{MATRA_F4_SNEBT253}"-- MATRA F4 Shaped charge
id_MF4_254_R = "{MATRA_F4_SNEBT254_RED}"-- MATRA F4 smoke	
id_MF4_254_Y = "{MATRA_F4_SNEBT254_YELLOW}"-- MATRA F4 smoke
id_MF4_254_G = "{MATRA_F4_SNEBT254_GREEN}"-- MATRA F4 smoke
id_MF4_256 = "{MATRA_F4_SNEBT256}"-- MATRA F4 AP
id_MF4_257 = "{MATRA_F4_SNEBT257}"-- MATRA F4
id_MF4_259E = "{MATRA_F4_SNEBT259E}"-- MATRA F4
id_R530F_EM = "{R530F_EM}"-- MATRA-R530 EM
id_R530F_IR = "{R530F_IR}"-- MATRA-R530 IR
id_GBU_10 = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}"-- GBU-10
id_GBU_12 = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"-- GBU-12
id_GBU_16 = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}"-- GBU-16
id_CLB4_MK82 = "{CLB4_MK82}"
id_CLB4_DURANDAL = "{CLB4_BLU107}"
id_CLB4_125LD = "{CLB4_SAMP125LD}"
id_CLB4_250LD = "{CLB4_SAMP250LD}"
id_CLB4_250HD = "{CLB4_SAMP250HD}"
id_CLB4_400LD = "{CLB4_SAMP400LD}"
id_CLB4_400HD = "{CLB4_SAMP400HD}"
id_SUPER_530F = "{S530F}"--SUPER 530F
id_MICA_RF = "{6D778860-7BB8-4ACB-9E95-BA772C6BBC2C}"--MICA RF
id_MICA_IR = "{0DA03783-61E4-40B2-8FAE-6AEE0A5C5AAE}"--MICA IR
id_GBU_27 = "{EF0A9419-01D6-473B-99A3-BEBDB923B14D}"-- GBU-27
id_PTB_1200_F1 = "PTB-1200-F1"-- FUEL TANKS
id_PTB_1200_F1_EMPTY = "PTB-1200-F1-EMPTY"-- FUEL TANKS
id_PTB_580G_F1 = "PTB-580G-F1"-- FUEL TANKS
id_PTB_580G_F1_EMPTY = "PTB-580G-F1-EMPTY"-- FUEL TANKS

Pylons_CE_BE_EE = {
	pylon(1, 0, -3.215, -0.035, -4.329,{ use_full_connector_position=true,connector = "Pylon1",  arg = 308, arg_value = 0.0},
		{	
			pylon_loadout(id_AIM_9B, 0.15, nil,	nil, 		{ 7 }),		-- AIM-9B
			pylon_loadout(id_AIM_9J, 0.15, nil,	nil,		{ 7 }), 	-- AIM-9J
			pylon_loadout(id_AIM_9P, 0.15, nil,	nil,		{ 7 }), 	-- AIM-9P
			pylon_loadout(id_AIM_9JULI, 0.15, nil, nil,		{ 7 }),	-- AIM-9JULI
			pylon_loadout(id_MAGIC_I, 0.15, nil, {-0.1,  -0.09,  0.0},		{ 7 }), -- R550 Magic I
			pylon_loadout(id_MAGIC_II, 0.15, nil, {-0.1,  -0.09,  0.0},		{ 7 }), -- R550 Magic I
						
		}
	),
	pylon(2, 0, -1.982, -0.207, -2.867,{ use_full_connector_position=true,connector = "Pylon2", arg = 309, arg_value = 0.0 },
		{
			pylon_loadout(id_MK82, 0.25, nil,	nil, 		{ 6 }),		-- MK82
			pylon_loadout(id_MK83, 0.25, nil,	nil,		{ 6 }), 	-- MK83
			pylon_loadout(id_BR_250, 0.25, nil, nil,		{ 6 }),	-- BR_250
			pylon_loadout(id_BR_500, 0.25, nil, nil,		{ 6 }), -- BR_500
			pylon_loadout(id_SAMP125LD, 0.25, nil,	nil, 	{ 6 }),		-- SAMP 125 Low Drag
			pylon_loadout(id_SAMP250LD, 0.25, nil,	nil,	{ 6 }), 	-- SAMP 250 Low Drag
			pylon_loadout(id_SAMP250HD, 0.25, nil, nil,	{ 6 }),	-- SAMP 250 High Drag
			pylon_loadout(id_SAMP400LD, 0.25, nil, nil,	{ 6 }), -- SAMP 400 Low Drag
			pylon_loadout(id_SAMP400HD, 0.25, nil,	nil,	{ 6 }), 	-- SAMP 400 High Drag
			pylon_loadout(id_BLU107B_DURANDAL, 0.25, nil, nil,		{ 6 }),	-- Durandal
			pylon_loadout(id_BLG66_BELOUGA, 0.25, nil, {0.04,  0.00,  0.0},		{ 6 }), -- BELOUGA
			pylon_loadout(id_MF1_250, 0.35, nil,	nil, 	{ 6 }),		-- MATRA F1
			pylon_loadout(id_MF1_251, 0.35, nil,	nil,	{ 6 }), 	-- MATRA F1 AA HE
			pylon_loadout(id_MF1_252, 0.35, nil, nil,		{ 6 }),	-- MATRA F1	
			pylon_loadout(id_MF1_253, 0.35, nil, nil,		{ 6 }), -- MATRA F1 Shaped charge
			pylon_loadout(id_MF1_254_R, 0.35, nil,	nil, 	{ 6 }),		-- MATRA F1 smoke
			pylon_loadout(id_MF1_254_Y, 0.35, nil,	nil,	{ 6 }), 	-- MATRA F1 smoke
			pylon_loadout(id_MF1_254_G, 0.35, nil, nil,	{ 6 }),	-- MATRA F1 smoke
			pylon_loadout(id_MF1_256, 0.35, nil, nil,		{ 6 }), -- MATRA F1 AP
			pylon_loadout(id_MF1_257, 0.35, nil,	nil,	{ 6 }), 	-- MATRA F1
			pylon_loadout(id_MF1_259E, 0.35, nil, nil,		{ 6 }),	-- MATRA F1
			pylon_loadout(id_MF4_250, 0.25, nil,	nil, 	{ 6 }),		-- MATRA F4
			pylon_loadout(id_MF4_251, 0.25, nil,	nil,	{ 6 }), 	-- MATRA F4 AA HE
			pylon_loadout(id_MF4_252, 0.25, nil, nil,		{ 6 }),	-- MATRA F4	
			pylon_loadout(id_MF4_253, 0.25, nil, nil,		{ 6 }), -- MATRA F4 Shaped charge
			pylon_loadout(id_MF4_254_R, 0.25, nil,	nil, 	{ 6 }),		-- MATRA F4 smoke
			pylon_loadout(id_MF4_254_Y, 0.25, nil,	nil,	{ 6 }), 	-- MATRA F4 smoke
			pylon_loadout(id_MF4_254_G, 0.25, nil, nil,	{ 6 }),	-- MATRA F4 smoke
			pylon_loadout(id_MF4_256, 0.25, nil, nil,		{ 6 }), -- MATRA F4 AP
			pylon_loadout(id_MF4_257, 0.25, nil,	nil,	{ 6 }), 	-- MATRA F4
			pylon_loadout(id_MF4_259E, 0.25, nil, nil,		{ 6 }),	-- MATRA F4
							

		}
	),
	pylon(3, 0, -1.647, -0.328,  -2.048,
		{ use_full_connector_position=true, arg = 310,connector = "Pylon3", arg_value = 0.0 },
		{
			pylon_loadout(id_MK82, 0.15, nil,	nil, 		{ 5 }),		-- MK82
			pylon_loadout(id_MK83, 0.15, nil,	nil,		{ 5 }), 	-- MK83
			pylon_loadout(id_BR_250, 0.15, nil, nil,		{ 5 }),	-- BR_250
			pylon_loadout(id_BR_500, 0.15, nil, nil,		{ 5 }), -- BR_500
			pylon_loadout(id_SAMP125LD, 0.15, nil,	nil, 	{ 5 }),		-- SAMP 125 Low Drag
			pylon_loadout(id_SAMP250LD, 0.15, nil,	nil,	{ 5 }), 	-- SAMP 250 Low Drag
			pylon_loadout(id_SAMP250HD, 0.15, nil, nil,	{ 5 }),	-- SAMP 250 High Drag
			pylon_loadout(id_SAMP400LD, 0.15, nil, nil,	{ 5 }), -- SAMP 400 Low Drag
			pylon_loadout(id_SAMP400HD, 0.15, nil,	nil,	{ 5 }), 	-- SAMP 400 High Drag
			pylon_loadout(id_BLU107B_DURANDAL, 0.15, nil, nil,		{ 5 }),	-- Durandal
			pylon_loadout(id_BLG66_BELOUGA, 0.15, nil, {0.04,  0.00,  0.0},		{ 5 }), -- BELOUGA
			pylon_loadout(id_MF1_250, 0.15, nil,	nil, 	{ 5 }),		-- MATRA F1
			pylon_loadout(id_MF1_251, 0.15, nil,	nil,	{ 5 }), 	-- MATRA F1 AA HE
			pylon_loadout(id_MF1_252, 0.15, nil, nil,		{ 5 }),	-- MATRA F1	
			pylon_loadout(id_MF1_253, 0.15, nil, nil,		{ 5 }), -- MATRA F1 Shaped charge
			pylon_loadout(id_MF1_254_R, 0.15, nil,	nil, 	{ 5 }),		-- MATRA F1 smoke
			pylon_loadout(id_MF1_254_Y, 0.15, nil,	nil,	{ 5 }), 	-- MATRA F1 smoke
			pylon_loadout(id_MF1_254_G, 0.15, nil, nil,	{ 5 }),	-- MATRA F1 smoke
			pylon_loadout(id_MF1_256, 0.15, nil, nil,		{ 5 }), -- MATRA F1 AP
			pylon_loadout(id_MF1_257, 0.15, nil,	nil,	{ 5 }), 	-- MATRA F1
			pylon_loadout(id_MF1_259E, 0.15, nil, nil,		{ 5 }),	-- MATRA F1
			pylon_loadout(id_MF4_250, 0.15, nil,	nil, 	{ 5 }),		-- MATRA F4
			pylon_loadout(id_MF4_251, 0.15, nil,	nil,	{ 5 }), 	-- MATRA F4 AA HE
			pylon_loadout(id_MF4_252, 0.15, nil, nil,		{ 5 }),	-- MATRA F4	
			pylon_loadout(id_MF4_253, 0.15, nil, nil,		{ 5 }), -- MATRA F4 Shaped charge
			pylon_loadout(id_MF4_254_R, 0.15, nil,	nil, 	{ 5 }),		-- MATRA F4 smoke
			pylon_loadout(id_MF4_254_Y, 0.15, nil,	nil,	{ 5 }), 	-- MATRA F4 smoke
			pylon_loadout(id_MF4_254_G, 0.15, nil, nil,	{ 5 }),	-- MATRA F4 smoke
			pylon_loadout(id_MF4_256, 0.15, nil, nil,		{ 5 }), -- MATRA F4 AP
			pylon_loadout(id_MF4_257, 0.15, nil,	nil,	{ 5 }), 	-- MATRA F4
			pylon_loadout(id_MF4_259E, 0.15, nil, nil,		{ 5 }),	-- MATRA F4
			pylon_loadout(id_R530F_EM, 0.25, nil, {0.368, 0.029, 0.00},	nil, {{station = 4, loadout = {id_R530F_EM}}, {station = 4, loadout = {id_R530F_IR}}}), 	-- MATRA R530F_EM
			pylon_loadout(id_R530F_IR, 0.25, nil, {0.368, 0.029, 0.00},	nil, {{station = 4, loadout = {id_R530F_EM}}, {station = 4, loadout = {id_R530F_IR}}}),	-- MATRA R530F_IR
			pylon_loadout(id_SUPER_530F, 0.25, nil, {0.0, -0.1, 0.00},	{ 5 }, {{station = 4, loadout = {id_R530F_EM}}, {station = 4, loadout = {id_R530F_IR}}}), -- MATRA S530F
			--pylon_loadout(id_GBU_10, 0.15, nil, nil,		{ 5 }), -- GBU_10
			pylon_loadout(id_GBU_12, 0.15, nil,	nil,		{ 5 }), 	-- GBU_12
			pylon_loadout(id_GBU_16, 0.15, nil,	nil,		{ 5 }), 	-- GBU_16
			pylon_loadout(id_PTB_1200_F1, 0.15, nil, nil,	{ 5 }),	-- FUEL TANK	
			pylon_loadout(id_PTB_1200_F1_EMPTY, 0.15, nil, nil,	{ 5 }),	-- FUEL TANK
	
			
		}
	),
	------------ 
	pylon(4, 0, -1.06, -1.283, 0.0,{ use_full_connector_position=true,connector = "Pylon4", arg = 311, arg_value = 0.0 },
		{
			pylon_loadout(id_MK82, 0.15, nil,	nil),		-- MK82
			pylon_loadout(id_MK83, 0.15, nil,	nil), 	-- MK83
			pylon_loadout(id_GBU_10, 0.15, nil,	nil), -- GBU_10
			pylon_loadout(id_GBU_12, 0.15, nil,	nil), 	-- GBU_12
			pylon_loadout(id_BLG66_BELOUGA, 0.15, nil,	nil), -- BELOUGA
			pylon_loadout(id_BR_250, 0.15, nil,	nil),	-- BR_250
			pylon_loadout(id_BR_500, 0.15, nil,	nil), -- BR_500	
			pylon_loadout(id_SAMP250LD, 0.15, nil,	nil), 	-- SAMP 250 Low Drag
			pylon_loadout(id_SAMP250HD, 0.15, nil,	nil),	-- SAMP 250 High Drag
			pylon_loadout(id_SAMP400LD, 0.15, nil,	nil), -- SAMP 400 Low Drag
			pylon_loadout(id_SAMP400HD, 0.15, nil,	nil), 	-- SAMP 400 High Drag				
			pylon_loadout(id_R530F_EM, 0.25, nil, {-0.068,  -0.112,  0.0}, nil, {{station = 3, loadout = {id_R530F_EM}}, {station = 5, loadout = {id_R530F_EM}}, {station = 3, loadout = {id_R530F_IR}}, {station = 5, loadout = {id_R530F_IR}}}), 	-- MATRA R530F_EM
			pylon_loadout(id_R530F_IR, 0.25, nil, {-0.068,  -0.112,  0.0}, nil, {{station = 3, loadout = {id_R530F_EM}}, {station = 5, loadout = {id_R530F_EM}}, {station = 3, loadout = {id_R530F_IR}}, {station = 5, loadout = {id_R530F_IR}}}),	-- MATRA R530F_IR
			pylon_loadout(id_CLB4_MK82, 0.35, nil,	nil),
			pylon_loadout(id_CLB4_DURANDAL, 0.35, nil,	nil),
			pylon_loadout(id_CLB4_125LD, 0.35, nil,	nil),
			pylon_loadout(id_CLB4_250LD, 0.35, nil,	nil),
			pylon_loadout(id_CLB4_250HD, 0.35, nil,	nil),
			pylon_loadout(id_CLB4_400LD, 0.35, nil,	nil),
			pylon_loadout(id_CLB4_400HD, 0.35, nil,	nil),
			pylon_loadout(id_PTB_1200_F1, 0.15, nil, nil),	-- FUEL TANK
			pylon_loadout(id_PTB_1200_F1_EMPTY, 0.15, nil, nil),	-- FUEL TANK			
							
		}
	),
	------------		
	pylon(5, 0, -1.647, -0.328,  2.048,{ use_full_connector_position=true,connector = "Pylon5", arg = 312, arg_value = 0.0 },
		{
			pylon_loadout(id_MK82, 0.15, nil,	nil, 		{ 3 }),		-- MK82
			pylon_loadout(id_MK83, 0.15, nil,	nil,		{ 3 }), 	-- MK83
			pylon_loadout(id_BR_250, 0.15, nil, nil,		{ 3 }),	-- BR_250
			pylon_loadout(id_BR_500, 0.15, nil, nil,		{ 3 }), -- BR_500
			pylon_loadout(id_SAMP125LD, 0.15, nil,	nil, 	{ 3 }),		-- SAMP 125 Low Drag
			pylon_loadout(id_SAMP250LD, 0.15, nil,	nil,	{ 3 }), 	-- SAMP 250 Low Drag
			pylon_loadout(id_SAMP250HD, 0.15, nil, nil,	{ 3 }),	-- SAMP 250 High Drag
			pylon_loadout(id_SAMP400LD, 0.15, nil, nil,	{ 3 }), -- SAMP 400 Low Drag
			pylon_loadout(id_SAMP400HD, 0.15, nil,	nil,	{ 3 }), 	-- SAMP 400 High Drag
			pylon_loadout(id_BLU107B_DURANDAL, 0.15, nil, nil,		{ 3 }),	-- Durandal
			pylon_loadout(id_BLG66_BELOUGA, 0.15, nil, {0.04,  0.00,  0.0},		{ 3 }), -- BELOUGA
			pylon_loadout(id_MF1_250, 0.15, nil,	nil, 	{ 3 }),		-- MATRA F1
			pylon_loadout(id_MF1_251, 0.15, nil,	nil,	{ 3 }), 	-- MATRA F1 AA HE
			pylon_loadout(id_MF1_252, 0.15, nil, nil,		{ 3 }),	-- MATRA F1	
			pylon_loadout(id_MF1_253, 0.15, nil, nil,		{ 3 }), -- MATRA F1 Shaped charge
			pylon_loadout(id_MF1_254_R, 0.15, nil,	nil, 	{ 3 }),		-- MATRA F1 smoke
			pylon_loadout(id_MF1_254_Y, 0.15, nil,	nil,	{ 3 }), 	-- MATRA F1 smoke
			pylon_loadout(id_MF1_254_G, 0.15, nil, nil,	{ 3 }),	-- MATRA F1 smoke
			pylon_loadout(id_MF1_256, 0.15, nil, nil,		{ 3 }), -- MATRA F1 AP
			pylon_loadout(id_MF1_257, 0.15, nil,	nil,	{ 3 }), 	-- MATRA F1
			pylon_loadout(id_MF1_259E, 0.15, nil, nil,		{ 3 }),	-- MATRA F1
			pylon_loadout(id_MF4_250, 0.15, nil,	nil, 	{ 3 }),		-- MATRA F4
			pylon_loadout(id_MF4_251, 0.15, nil,	nil,	{ 3 }), 	-- MATRA F4 AA HE
			pylon_loadout(id_MF4_252, 0.15, nil, nil,		{ 3 }),	-- MATRA F4	
			pylon_loadout(id_MF4_253, 0.15, nil, nil,		{ 3 }), -- MATRA F4 Shaped charge
			pylon_loadout(id_MF4_254_R, 0.15, nil,	nil, 	{ 3 }),		-- MATRA F4 smoke
			pylon_loadout(id_MF4_254_Y, 0.15, nil,	nil,	{ 3 }), 	-- MATRA F4 smoke
			pylon_loadout(id_MF4_254_G, 0.15, nil, nil,	{ 3 }),	-- MATRA F4 smoke
			pylon_loadout(id_MF4_256, 0.15, nil, nil,		{ 3 }), -- MATRA F4 AP
			pylon_loadout(id_MF4_257, 0.15, nil,	nil,	{ 3 }), 	-- MATRA F4
			pylon_loadout(id_MF4_259E, 0.15, nil, nil,		{ 3 }),	-- MATRA F4
			pylon_loadout(id_R530F_EM, 0.25, nil, {0.368, 0.029, 0.00},	nil, {{station = 4, loadout = {id_R530F_EM}}, {station = 4, loadout = {id_R530F_IR}}}), 	-- MATRA R530F_EM
			pylon_loadout(id_R530F_IR, 0.25, nil, {0.368, 0.029, 0.00},	nil, {{station = 4, loadout = {id_R530F_EM}}, {station = 4, loadout = {id_R530F_IR}}}),	-- MATRA R530F_IR
			pylon_loadout(id_SUPER_530F, 0.25, nil, {0.0, -0.1, 0.00},	{ 3 }, {{station = 4, loadout = {id_R530F_EM}}, {station = 4, loadout = {id_R530F_IR}}}),-- MATRA S530F	
			--pylon_loadout(id_GBU_10, 0.15, nil, nil,		{ 3 }), -- GBU_10
			pylon_loadout(id_GBU_12, 0.15, nil,	nil,		{ 3 }), 	-- GBU_12
			pylon_loadout(id_GBU_16, 0.15, nil,	nil,		{ 3 }), 	-- GBU_16
			pylon_loadout(id_PTB_1200_F1, 0.15, nil, nil,	{ 3 }),	-- FUEL TANK
			pylon_loadout(id_PTB_1200_F1_EMPTY, 0.15, nil, nil,	{ 3 }),	-- FUEL TANK			

		}
	),
	pylon(6, 0, -1.982, -0.207, 2.867,{ use_full_connector_position=true,connector = "Pylon6", arg = 313, arg_value = 0.0 },
		{

			pylon_loadout(id_MK82, 0.25, nil,	nil, 		{ 2 }),		-- MK82
			pylon_loadout(id_MK83, 0.25, nil,	nil,		{ 2 }), 	-- MK83
			pylon_loadout(id_BR_250, 0.25, nil, nil,		{ 2 }),	-- BR_250
			pylon_loadout(id_BR_500, 0.25, nil, nil,		{ 2 }), -- BR_500
			pylon_loadout(id_SAMP125LD, 0.25, nil,	nil, 	{ 2 }),		-- SAMP 125 Low Drag
			pylon_loadout(id_SAMP250LD, 0.25, nil,	nil,	{ 2 }), 	-- SAMP 250 Low Drag
			pylon_loadout(id_SAMP250HD, 0.25, nil, nil,	{ 2 }),	-- SAMP 250 High Drag
			pylon_loadout(id_SAMP400LD, 0.25, nil, nil,	{ 2 }), -- SAMP 400 Low Drag
			pylon_loadout(id_SAMP400HD, 0.25, nil,	nil,	{ 2 }), 	-- SAMP 400 High Drag
			pylon_loadout(id_BLU107B_DURANDAL, 0.25, nil, nil,		{ 2 }),	-- Durandal
			pylon_loadout(id_BLG66_BELOUGA, 0.25, nil, {0.04,  0.00,  0.0},		{ 2 }), -- BELOUGA
			pylon_loadout(id_MF1_250, 0.35, nil,	nil, 	{ 2 }),		-- MATRA F1
			pylon_loadout(id_MF1_251, 0.35, nil,	nil,	{ 2 }), 	-- MATRA F1 AA HE
			pylon_loadout(id_MF1_252, 0.35, nil, nil,		{ 2 }),	-- MATRA F1	
			pylon_loadout(id_MF1_253, 0.35, nil, nil,		{ 2 }), -- MATRA F1 Shaped charge
			pylon_loadout(id_MF1_254_R, 0.35, nil,	nil, 	{ 2 }),		-- MATRA F1 smoke
			pylon_loadout(id_MF1_254_Y, 0.35, nil,	nil,	{ 2 }), 	-- MATRA F1 smoke
			pylon_loadout(id_MF1_254_G, 0.35, nil, nil,	{ 2 }),	-- MATRA F1 smoke
			pylon_loadout(id_MF1_256, 0.35, nil, nil,		{ 2 }), -- MATRA F1 AP
			pylon_loadout(id_MF1_257, 0.35, nil,	nil,	{ 2 }), 	-- MATRA F1
			pylon_loadout(id_MF1_259E, 0.35, nil, nil,		{ 2 }),	-- MATRA F1
			pylon_loadout(id_MF4_250, 0.25, nil,	nil, 	{ 2 }),		-- MATRA F4
			pylon_loadout(id_MF4_251, 0.25, nil,	nil,	{ 2 }), 	-- MATRA F4 AA HE
			pylon_loadout(id_MF4_252, 0.25, nil, nil,		{ 2 }),	-- MATRA F4	
			pylon_loadout(id_MF4_253, 0.25, nil, nil,		{ 2 }), -- MATRA F4 Shaped charge
			pylon_loadout(id_MF4_254_R, 0.25, nil,	nil, 	{ 2 }),		-- MATRA F4 smoke
			pylon_loadout(id_MF4_254_Y, 0.25, nil,	nil,	{ 2 }), 	-- MATRA F4 smoke
			pylon_loadout(id_MF4_254_G, 0.25, nil, nil,	{ 2 }),	-- MATRA F4 smoke
			pylon_loadout(id_MF4_256, 0.25, nil, nil,		{ 2 }), -- MATRA F4 AP
			pylon_loadout(id_MF4_257, 0.25, nil,	nil,	{ 2 }), 	-- MATRA F4
			pylon_loadout(id_MF4_259E, 0.25, nil, nil,		{ 2 }),	-- MATRA F4					
		}
	),

	pylon(7, 0, -3.215, -0.035, 4.329,{ use_full_connector_position=true,connector = "Pylon7", arg = 314, arg_value = 0.0 },
		{
			pylon_loadout(id_AIM_9B, 0.15, nil,	nil, 		{ 1 }),		-- AIM-9B
			pylon_loadout(id_AIM_9J, 0.15, nil,	nil,		{ 1 }), 	-- AIM-9J
			pylon_loadout(id_AIM_9P, 0.15, nil,	nil,		{ 1 }), 	-- AIM-9P
			pylon_loadout(id_AIM_9JULI, 0.15, nil, nil,	{ 1 }),	-- AIM-9JULI
			pylon_loadout(id_MAGIC_I, 0.15, nil, {-0.1,  -0.09,  0.0},		{ 1 }), -- R550 Magic I
			pylon_loadout(id_MAGIC_II, 0.15, nil, {-0.1,  -0.09,  0.0},		{ 1 }), -- R550 Magic I
		}
	),
}

F1_all_versions = {
	Rate 						= 40, -- RewardPoint in Multiplayer
	
	shape_table_data = 
	{
		{
			life  	 			= 18, -- lifebar
			vis   	 			= 3, -- visibility gain
			fire  	 			= {300, 6}, -- Fire on the ground after destoyed: 300sec 2m
			classname 			= "lLandPlane",
			positioning 		= "BYNORMAL",		
		},
		{
			fire  				= {300, 6},
			classname 			= "lLandPlane",
			positioning 		= "BYNORMAL",		
		},
	},
	
	mapclasskey 				= "P0091000024",
	Categories 					= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},
	
	H_max 					 	= 15240, -- m --50000 ft practical ceiling. 55000 ft absolute.
	average_fuel_consumption 	= 0.5, -- this is highly relative, but good estimates are 36-40l/min = 28-31kg/min = 0.47-0.52kg/s -- 45l/min = 35kg/min = 0.583kg/s
	CAS_min 					= 50, -- if this is not OVERAL FLIGHT TIME, but jus LOITER TIME, than it sholud be 10-15 minutes.....CAS capability in minute (for AI)
	V_opt 						= 300,-- Cruise speed (for AI)
	Mach_max 					= 2.1, -- Max speed in Mach (for AI)
	Ny_min 						= -3, -- Min G (for AI)
	Ny_max 						= 7.2,  -- Max G (for AI)
	Ny_max_e 					= 6.0,  -- Max G (for AI)
	bank_angle_max 				= 85, -- Max bank angle (for AI)
	
	has_afteburner 				= true, -- AFB yes/no
	has_speedbrake 				= true, -- Speedbrake yes/no
	has_differential_stabilizer = false,
	bigParkingRamp				= false,
	
	stores_number				= 9,
	brakeshute_name				= "Mirage-F1_parachute_1", -- Landing - brake chute visual shape after separation
	
	tanker_type 				= 0, -- Tanker type if the plane is airrefuel capable
	is_tanker 					= false, -- Tanker yes/no
	
	wing_area 					= 25, -- wing area in m2
	wing_span 					= 8.4, -- wing span in m
	wing_type 					= 0,
	length 						= 15.3, -- full lenght in m
	height 						= 4.5, -- height in m
	flaps_maneuver 				= 0.5, -- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
	range 						= 3300, -- Max range in km (for AI)
	RCS 						= 5, -- Radar Cross Section m2
	IR_emission_coeff 			= 0.8, -- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
	IR_emission_coeff_ab 		= 3, -- With afterburner
	wing_tip_pos 				= {-3.5, -0.04, 4.22}, -- wingtip coords for turbulence and AI taxi/collision logic

	engines_count				= 1, -- Engines count
	thrust_sum_max 				= 4867, -- thrust in kg (47.7kN)
	thrust_sum_ab 				= 6969, -- thrust in kg (68.3kN)
	
	----------------- LANDING GEAR
	nose_gear_amortizer_normal_weight_stroke = -0.00311633945,
	main_gear_amortizer_normal_weight_stroke = 0.00,

	nose_gear_wheel_diameter 	= 0.346, -- in m
	main_gear_wheel_diameter 	= 0.608, -- in m

	tand_gear_max 				= 2.1445,
	
	net_animation 				=
	{
		11, -- Right aileron
		12,	-- Left aileron
		13, -- Right slat
		14,	-- Left slat
		15, -- Right stabilizer
		16,	-- Left stabilizer
		18, -- Rudder
		28, -- Afterburner
		35, -- Brake chute deployment position
		36,	-- Brake chute deflection up/down
		37,	-- Brake chute deflection left/right
		38, -- Canopy position
		69, -- Cockpit main lights 
		75, -- GPU presence
		83, -- Navigation light fuselage
		86, -- Nosecones position
		90,	-- Nozzle position
		115, -- Right gear door
		116, -- Left gear door
		117, -- Nose gear door
		120, -- Right spoiler
		123, -- Left spoiler
		126, -- Right inner flap
		127, -- Right outer flap
		128, -- Left inner flap
		129, -- Left outer flap
		149, -- Canopy embrittlement
		182, -- Right airbrake
		184, -- Left airbrake
		190, -- Left navlight
		191, -- Right navlight
		201, -- Formation light
		209, -- Landing light
		282, -- Additional air intake right up
		283, -- Additional air intake right low
		284, -- Additional air intake left up
		285, -- Additional air intake left low
		
		308, -- Wingtip pylon left
		309, -- Outboard pylon left
		310, -- Inboard pylon left
		311, -- Centerline pylon
		312, -- Inboard pylon right
		313, -- Outboard pylon right
		314, -- Wingtip pylon right
		
		338, -- Right wing flex
		339, -- Left wing flex
		340, -- Right wing tors
		341, -- Left wing tors
		427, -- Landing light pos
		705, -- Radar cover
		750, -- Countermeasure number flare left
		751, -- Countermeasure number chaff right
		752, -- Countermeasure type left
		753, -- Countermeasure type right
		754, -- Countermeasure number flare right
		755, -- Countermeasure number chaff left
		780, -- ADI roll
		781, -- ADI pitch
		782, -- ADI bearing
		802, -- Nav light vert stab red
		803, -- Nav light vert stab white
		844, -- Wheel chocks
		845, -- Access ladder
		905, -- Police light
		911, -- Canopy hanger
		924, -- GPU state
		925, -- Compressor stall state
		926, -- Engine starter
		970, -- Lateral cockpit lights
		971, -- Miscellaneous cockpit lights
		972, -- AOA indicator lights
		973, -- Lateral cockpit flood lights
		974, -- Front cockpit flood lights
		975, -- UV cockpit lights
		
		994, -- Mirage F1EE RWR type
	},
	
	engines_nozzles = {
		[1] = 
		{
			pos 				=  {-6.93,-0.111,0.0}, -- nozzle coords
			elevation   		=  0, -- AFB cone elevation
			diameter	 		= 1.029, -- AFB cone diameter
			exhaust_length_ab   = 9, -- lenght in m
			exhaust_length_ab_K = 0.5, -- AB animation
			smokiness_level 	= 0.2,				
		}, -- end of [1]
	}, -- end of engines_nozzles
	
	fires_pos = {
		[1] = 	{-0.855,	0.593,	   0.0},	-- Fuselage					
		[2] = 	{-2.314,	0.178,	 2.065},	-- Wing inner Right
		[3] = 	{-2.332,	0.187,  -2.02},	    -- Wing inner Left
		[4] = 	{-2.836,	0.122,   2.775},	-- Wing middle Right
		[5] = 	{-2.973,	0.095,  -3.034},	-- Wing middle Left
		[6] = 	{-3.615,   -0.012,	 4.086},	-- Wing outer Right
		[7] = 	{-3.553,   -0.017,	-4.077},	-- Wing outer Left			
		[8] = 	{-5.249,     -0.1,	   0.0},	-- Engine
	}, -- end of fires_pos
	
	effects_presets = {
		{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/MirageF1_overwingVapor.lua"},
	},
	
	-- No passive countermeasures by default
	passivCounterm 				= noPassivCounterm,
	-- Coordinates for passive countermeasures dispencers (when those are present)
	chaff_flare_dispenser = {
		[1] = 
		{
			dir 				= {0, -1, -1},
			pos 				= {-4.312, -0.648, -0.488},
		}, -- end of [1]
		[2] = 
		{
			dir 				= {0, -1, 1},
			pos 				= {-4.312, -0.648, 0.488},
		}, -- end of [2]
	}, -- end of chaff_flare_dispenser
	
	-- Sensors
	detection_range_max		 	= 70,
	radar_can_see_ground 	 	= true,
	
	Sensors = {
		RADAR 					= "RDY",
		IRST 					= nil,
		RWR 					= "Abstract RWR"
	},
	
	CanopyGeometry = {
		azimuth   				= {-160.0, 160.0}, -- pilot view horizontal (AI)
		elevation 				= {-50.0, 90.0} -- pilot view vertical (AI)
	},		
	
	HumanRadio = {		
		frequency 				= 127.5,  -- Radio Freq
		editable 				= true,
		minFrequency 			= 100.000,
		maxFrequency 			= 400.000,
		modulation 				= MODULATION_AM
	},
		
	SFM_Data = {
		engine = 
		{
			type	=	"TurboJet",
			Nmg		=	67.5,
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	0.85,
			ForsRUD	=	0.91,
			typeng	=	1,
			hMaxEng	=	19.5,
			dcx_eng	=	0.0085,  -- Affects drag of engine when shutdown
			                     -- cemax/cefor affect sponginess of elevator/inertia at slow speed
			                     -- affects available g load apparently
			cemax	=	1.24,
			cefor	=	2.56,
			-- following affect thrust/max alt
			dpdh_m	=	3270,  -- Loss of thrust in N per 1000 m
			dpdh_f	=	6600, -- Loss of thrust in N per 1000 m
			table_data = 
			{
			         --   M		 Pmax        Pfor
				[1] = 	{0,	    49000,	    70600},
				[2] = 	{0.2,	45700,	    67700}, -- 132 kts at SL
				[3] = 	{0.3,	44900,	    68700}, -- 198 kts at SL
				[4] = 	{0.4,	44800,	    69700}, -- 265 kts at SL
				[5] = 	{0.6,	46000,	    74600}, -- 397 kts at SL
				[6] = 	{0.7,	47000,	    78500},
				[7] = 	{0.8,	48600,	    82400},
				[8] = 	{0.9,	50000,	    87500},
				[9] = 	{1,	    51500,	    93200},
				[10] = 	{1.1,	53000,	    98100},
				[11] = 	{1.2,	54500,	    104000},
				[12] = 	{1.3,	56500,	    109900},
				[13] = 	{1.5,	59000,	    121600},
				[14] = 	{1.8,	70000,	    144000},
				[15] = 	{2,	    70000,	    155800},
				[16] = 	{2.2,	90000,	    167530},
				[17] = 	{2.5,	47700,	    162000},
				[18] = 	{3,	    20000,	    40000},
			}, -- end of table_data
			-- M - Mach number
			-- Pmax - Engine thrust at military power
			-- Pfor - Engine thrust at AFB
		}, -- end of engine
	},
---------------------------------------------------------------------------------------------------------------------------------------------	
	Failures = 
	{
		{ id = "battery_fail", label = _("Battery failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "alt1_fail", label = _("Alternator 1 failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "alt2_fail", label = _("Alternator 2 failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "tr1_fail", label = _("Transformer 1 failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "tr2_fail", label = _("Transformer 2 failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "triphase_inv_fail", label = _("Three-phase inverter failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "miss_bus_fail", label = _("Missile bus failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = "left_fuel_pump_fail", label = _("Left fuel pump failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_fuel_pump_fail", label = _("Right fuel pump failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "detotalizer_fail", label = _("Fuel detotalizer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "fuel_gauges_fail", label = _("Fuel gauges failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "fuel_intercom_fail", label = _("Fuel crossfeed valve failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		--{ id = "fuel_pressurization_fail", label = _("Fuel pressurization failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "left_wing_transfer_fail", label = _("Left wing fuel tank transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_wing_transfer_fail", label = _("Right wing fuel tank transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "front_central_transfer_fail", label = _("Front central fuel tank transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "left_front_transfer_fail", label = _("Left front fuel tank transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_front_transfer_fail", label = _("Right front fuel tank transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "left_rear_transfer_fail", label = _("Left rear fuel tank transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_rear_transfer_fail", label = _("Right rear fuel tank transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "external_tanks_transfer_fail", label = _("External fuel tanks transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "left_wing_leaks", label = _("Left wing fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_wing_leaks", label = _("Right wing fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "front_central_leaks", label = _("Front central fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "left_front_leaks", label = _("Left front fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_front_leaks", label = _("Right front fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "left_rear_leaks", label = _("Left rear fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_rear_leaks", label = _("Right rear fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "left_feeder_leaks", label = _("Left feeder fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_feeder_leaks", label = _("Right feeder fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "fuel_accu_leaks", label = _("Fuel accumulator leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = "left_airbrake_fail", label = _("Left airbrake failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_airbrake_fail", label = _("Right airbrake failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "gear_lever_fail", label = _("Gear actuation failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "gear_down_lock_fail", label = _("Gear locking failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "gear_nose_stuck", label = _("Nose gear stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "gear_left_stuck", label = _("Left gear stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "gear_right_stuck", label = _("Right gear stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "brakes_fail", label = _("Wheel brakes failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "chute_fail", label = _("Drag chute failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "electropump_fail", label = _("Electropump failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "hydr1_leaks", label = _("Hydraulic circuit 1 leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "hydr1_reserv_leaks", label = _("Hydraulic reservoir 1 leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "hydr1_pump_fail", label = _("Hydraulic pump 1 failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "hydr2_leaks", label = _("Hydraulic circuit 2 leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "hydr2_reserv_leaks", label = _("Hydraulic reservoir 2 leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "hydr2_pump_fail", label = _("Hydraulic pump 2 failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "hydr_serv_leaks", label = _("Hydraulic servitudes circuit leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "flap_left_stuck", label = _("Left flap stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "flap_right_stuck", label = _("Right flap stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "flaps_stuck", label = _("Both flaps stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "slat_inner_left_stuck", label = _("Left inner slat stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "slat_inner_right_stuck", label = _("Right inner slat stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "slat_outer_left_stuck", label = _("Left outer slat stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "slat_outer_right_stuck", label = _("Right outer slat stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "slats_stuck", label = _("All slats stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = "pitot_heat_fail", label = _("Pitot tube heating failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "altitude_chain_fail", label = _("Altitude chain failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "mach_chain_fail", label = _("Mach chain failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "incidometer_fail", label = _("Incidometer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "incidometer_blockage_fail", label = _("Incidometer stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "anemo_central_fail", label = _("Anemometry central failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = "trim_pitch_fail", label = _("Pitch trim fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "trim_roll_fail", label = _("Roll trim fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "trim_yaw_fail", label = _("Yaw trim fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "trim_elect_supply", label = _("Trim electric failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "yaw_damper_fail", label = _("Yaw damper failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "pilot_aids_1_fail", label = _("Pilot aids 1 electric supply failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "pilot_aids_2_fail", label = _("Pilot aids 2 electric supply failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "pitch_chain_fail", label = _("Pitch control chain failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "ap_global_fail", label = _("Autopilot failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = "broken_guards", label = _("Engine nozzle vanes stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "oil_fail", label = _("Engine oil pump failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "nosecone_stuck", label = _("Engine nosecones stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "nosecone_stuck_forward", label = _("Engine nosecones stuck forwards"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "nosecone_stuck_backward", label = _("Engine nosecones stuck backwards"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "start_fail", label = _("Engine starter failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "ignition_fail", label = _("Engine ignition failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "total_comp_stall", label = _("Total compressor stall"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "partial_comp_stall", label = _("Partial compressor stall"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "overspeed_fail", label = _("Engine overspeed failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "discharge_valves_fail", label = _("Engine discharge valves failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		--{ id = "accessory_support_fail", label = _("Engine accessory supports failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "engine_fire", label = _("Engine fire"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "AB_fire", label = _("Afterburner fire"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "compressor_damage", label = _("Engine compressor damaged"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "engine_flameout", label = _("Engine flameout"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = "cabin_temp_fail", label = _("Cabin temperature regulation fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "equip_temp_fail", label = _("Equipment bay temperature regulation fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "oxygen_regulator_fail", label = _("Oxygen regulator fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = "gyros_general_BSM_fail", label = _("General gyroscopic central fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "gyros_main_fail", label = _("Main gyroscope fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "gyros_emergency_fail", label = _("Emergency gyroscope fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
	},
	
---------------------------------------------------------------------------------------------------------------------------------------------
	lights_data = 	{
		typename = "collection",
		lights = 	{
			--[[NATO STROBE LIGHTS]]--
			[1] = {
				typename = "collection",
				lights ={
					{typename = "argnatostrobelight",  argument = 83,  period = 1.333,  phase_shift = 0.0}, -- Top Strobe
					{typename = "argnatostrobelight",  argument = 802,  period = 1.4,  phase_shift = 0.0}, -- Strobe Orange Tail
					{typename = "argnatostrobelight",  argument = 803,  period = 1.4,  phase_shift = 0.0}, --Strobe White Tail					
				}
			},
			
			--[[TAXI Lights]]--
			[2] = {	typename	=	"collection",
				lights = {
						[1] = {	typename = "spotlight",		argument = 209},	
						[3] = {	typename = "argumentlight",	argument = 427,	speed  = 3.0},
					}
			},
	

			--[[NAVIGATION LIGHTS]]--
			[4] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight",  argument  = 190}, --Red Position
					{typename = "argumentlight",  argument  = 191}, --Green Position
					
					
				}
			},
			
			--[[FORMATION LIGHTS]]--
			[5] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight",argument = 200}, --CT/CR
					{typename = "argumentlight",  argument  = 201}, --Green Position					

				}
			},	
			
			--[[REFUEL LIGHTS]]--
			[6] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight",  argument  = 903},
				}
			},	
			--[[POLICE LIGHTS]]--
			[7] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight",  argument  = 905},
				}
			},			
			
		},
	},
	-- end lights_data
	
	AddPropAircraft = makeAircraftProperties(),
}
