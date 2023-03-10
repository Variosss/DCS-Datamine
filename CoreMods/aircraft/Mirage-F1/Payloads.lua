
function pylon_loadout(clsid, arg_value, arg_increment, attach_point_position, required, forbidden)
	local result = {}
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
id_BARAX = "BARAX_ECM" --BARAX ECM POD


local stations =
{
	pylon(1, 0, -3.215, -0.035, -4.329, 	{use_full_connector_position = true, connector = "Pylon1", arg = 308, arg_value = 0.0}, {}),
	pylon(2, 0, -1.982, -0.207, -2.867, 	{use_full_connector_position = true, connector = "Pylon2", arg = 309, arg_value = 0.0}, {}),
	pylon(3, 0, -1.647, -0.328, -2.048, 	{use_full_connector_position = true, connector = "Pylon3", arg = 310, arg_value = 0.0}, {}),
	pylon(4, 0, -1.06,  -1.283,  0.0, 		{use_full_connector_position = true, connector = "Pylon4", arg = 311, arg_value = 0.0}, {}),	
	pylon(5, 0, -1.647, -0.328,  2.048, 	{use_full_connector_position = true, connector = "Pylon5", arg = 312, arg_value = 0.0}, {}),
	pylon(6, 0, -1.982, -0.207, 2.867, 		{use_full_connector_position = true, connector = "Pylon6", arg = 313, arg_value = 0.0}, {}),
	pylon(7, 0, -3.215, -0.035, 4.329, 		{use_full_connector_position = true, connector = "Pylon7", arg = 314, arg_value = 0.0}, {})
}

-- Short range missiles
function add_SRM(pylons, id_weap, ...)
	
	local attachPt
	if id_weap == id_MAGIC_I or id_weap == id_MAGIC_II then
		attachPt = {-0.1,  -0.09,  0.0}
	else
		attachPt = nil
	end
	
	local arg = {...}
	for i, v in ipairs(arg) do
		local launchers = pylons[v].Launchers
		launchers[#launchers + 1] = pylon_loadout(id_weap, 0.15, nil, attachPt)
	end
end

-- Bombs
function add_Bomb(pylons, id_weap, ...)
	
	local attachPt
	if id_weap == id_BLG66_BELOUGA then
		attachPt = {0.04,  0.00,  0.0}
	else
		attachPt = nil
	end
	
	local isCLB
	if id_weap == id_CLB4_MK82 or
		id_weap == id_CLB4_DURANDAL or
		id_weap == id_CLB4_125LD or
		id_weap == id_CLB4_250LD or
		id_weap == id_CLB4_250HD or
		id_weap == id_CLB4_400LD or
		id_weap == id_CLB4_400HD then
		isCLB = true
	else
		isCLB = false
	end
		
	local arg = {...}
	for i, v in ipairs(arg) do
		local launchers = pylons[v].Launchers
			
		local pylonArg
		if isCLB == true then
			pylonArg = 0.35
		else
		
			if v == 2 or v == 6 then
				pylonArg = 0.25
			else
				pylonArg = 0.15
			end
		end
		
		launchers[#launchers + 1] = pylon_loadout(id_weap, pylonArg, nil, attachPt)
	end
end

-- Rockets
function add_Rockets(pylons, id_weap, ...)
	
	local isF1
	if id_weap == id_MF1_250 or
		id_weap == id_MF1_251 or
		id_weap == id_MF1_252 or
		id_weap == id_MF1_253 or
		id_weap == id_MF1_254_R or
		id_weap == id_MF1_254_Y or
		id_weap == id_MF1_254_G or
		id_weap == id_MF1_256 or
		id_weap == id_MF1_257 or
		id_weap == id_MF1_259E then
		isF1 = true
	else
		isF1 = false
	end
			
	local arg = {...}
	for i, v in ipairs(arg) do
		local launchers = pylons[v].Launchers
			
		local pylonArg
		if v == 2 or v == 6 then
			
			if isF1 == true then
				pylonArg = 0.35
			else
				pylonArg = 0.25
			end
		else
			pylonArg = 0.15
		end
		
		launchers[#launchers + 1] = pylon_loadout(id_weap, pylonArg)
	end
end

-- R530 missiles series
function add_R530(pylons, id_weap, ...)
	
	local isS530F = id_weap == id_SUPER_530F
	
	local attachPt
	if isS530F == true then
		attachPt = {0.0, -0.1, 0.00}
	end
	
	local arg = {...}
	for i, v in ipairs(arg) do
		local launchers = pylons[v].Launchers
		
		if isS530F ~= true then
			if v == 4 then
				attachPt = {-0.068,  -0.112,  0.0}
			else
				attachPt = {0.368, 0.029, 0.00}
			end
		end
		
		-- S530F is not present at station 4 in any aircraft version. It was added to restrictions provisionally.
		
		local restrictions
		if v == 4 then
			if isS530F == true then
				
				restrictions =
				{
					-- S530F can't be mixed with S530F at stations 3/5
					{station = 3, loadout = {id_SUPER_530F}}, {station = 5, loadout = {id_SUPER_530F}},
					-- S530F can't be mixed with R530EM/IR at any station
					{station = 3, loadout = {id_R530F_EM}}, {station = 4, loadout = {id_R530F_EM}}, {station = 5, loadout = {id_R530F_EM}},
					{station = 3, loadout = {id_R530F_IR}}, {station = 4, loadout = {id_R530F_IR}}, {station = 5, loadout = {id_R530F_IR}}
				}
			else
				restrictions =
				{
					-- R530EM/IR can't be mixed with R530EM/IR at stations 3/5
					{station = 3, loadout = {id_R530F_EM}}, {station = 5, loadout = {id_R530F_EM}},
					{station = 3, loadout = {id_R530F_IR}}, {station = 5, loadout = {id_R530F_IR}},
					-- R530EM/IR can't be mixed with S530F at any station
					{station = 3, loadout = {id_SUPER_530F}}, {station = 4, loadout = {id_SUPER_530F}}, {station = 5, loadout = {id_SUPER_530F}}
				}
			end
		else
			if isS530F == true then
				restrictions = 
				{
					-- S530F can't be mixed with S530F at station 4
					{station = 4, loadout = {id_SUPER_530F}},
					-- S530F can't be mixed with R530EM/IR at any station
					{station = 3, loadout = {id_R530F_EM}}, {station = 4, loadout = {id_R530F_EM}}, {station = 5, loadout = {id_R530F_EM}},
					{station = 3, loadout = {id_R530F_IR}}, {station = 4, loadout = {id_R530F_IR}}, {station = 5, loadout = {id_R530F_IR}}
				}
			else
				restrictions = 
				{
					-- R530EM/IR can't be mixed with R530EM/IR at station 4
					{station = 4, loadout = {id_R530F_EM}},
					{station = 4, loadout = {id_R530F_IR}},
					-- R530EM/IR can't be mixed with S530F at any station
					{station = 3, loadout = {id_SUPER_530F}}, {station = 4, loadout = {id_SUPER_530F}}, {station = 5, loadout = {id_SUPER_530F}}
				}
			end
		end
		
		launchers[#launchers + 1] = pylon_loadout(id_weap, 0.25, nil, attachPt, nil, restrictions)
	end
end

-- Fuel tank
function add_FuelTank(pylons, id_weap, ...)
	
	local is_FT_580_GAL
	if id_weap == id_PTB_580G_F1 or
		id_weap == id_PTB_580G_F1_EMPTY then
		is_FT_580_GAL = true
	else
		is_FT_580_GAL = false
	end
		
	local arg = {...}
	for i, v in ipairs(arg) do
		local launchers = pylons[v].Launchers
			
		local pylonArg
		if is_FT_580_GAL == true then
			pylonArg = 0.35
		else
			pylonArg = 0.15
		end
		
		launchers[#launchers + 1] = pylon_loadout(id_weap, pylonArg)
	end
end
			
-- ECM pod
function add_ECM_pod(pylons, id_weap, ...)
	
	local is_BARAX
	if id_weap == id_BARAX then
		is_BARAX = true
	else
		is_BARAX = false
	end
		
	local arg = {...}
	for i, v in ipairs(arg) do
		local launchers = pylons[v].Launchers
		
		local restrictions
		if is_BARAX == true then
			
			if v == 2 then
				restrictions = {{station = 6, loadout = {id_BARAX}}}
			elseif v == 6 then
				restrictions = {{station = 2, loadout = {id_BARAX}}}
			end
		else
			restrictions = nil
		end		
		
		launchers[#launchers + 1] = pylon_loadout(id_weap, 0.15, nil, {-0.4, 0.02, 0.0}, nil, restrictions)
	end
end

---------------------------------------------------------------------------------------------
-- Weapons common for all versions
Pylons_Common = {}
copyTable(stations, Pylons_Common)

add_Bomb(Pylons_Common, id_SAMP125LD, 2, 3, 5, 6)
add_Bomb(Pylons_Common, id_SAMP250LD, 2, 3, 4, 5, 6)
add_Bomb(Pylons_Common, id_SAMP250HD, 2, 3, 4, 5, 6)
add_Bomb(Pylons_Common, id_SAMP400LD, 2, 3, 4, 5, 6)
add_Bomb(Pylons_Common, id_SAMP400HD, 2, 3, 4, 5, 6)
add_Bomb(Pylons_Common, id_BLU107B_DURANDAL, 2, 3, 5, 6)
add_Bomb(Pylons_Common, id_BLG66_BELOUGA, 2, 3, 4, 5, 6)
add_Bomb(Pylons_Common, id_CLB4_DURANDAL, 4)
add_Bomb(Pylons_Common, id_CLB4_125LD, 4)
add_Bomb(Pylons_Common, id_CLB4_250LD, 4)
add_Bomb(Pylons_Common, id_CLB4_250HD, 4)
add_Bomb(Pylons_Common, id_CLB4_400LD, 4)
add_Bomb(Pylons_Common, id_CLB4_400HD, 4)

add_Rockets(Pylons_Common, id_MF1_250, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF1_251, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF1_252, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF1_253, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF1_254_R, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF1_254_Y, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF1_254_G, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF1_256, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF1_257, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF1_259E, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF4_250, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF4_251, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF4_252, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF4_253, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF4_254_R, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF4_254_Y, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF4_254_G, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF4_256, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF4_257, 2, 3, 5, 6)
add_Rockets(Pylons_Common, id_MF4_259E, 2, 3, 5, 6)

add_FuelTank(Pylons_Common, id_PTB_1200_F1, 3, 4, 5)
add_FuelTank(Pylons_Common, id_PTB_1200_F1_EMPTY, 3, 4, 5)

---------------------------------------------------------------------------------------------
-- C/B
Pylons_C_B = {}
copyTable(Pylons_Common, Pylons_C_B)

add_SRM(Pylons_C_B, id_MAGIC_I, 1, 7)
add_SRM(Pylons_C_B, id_MAGIC_II, 1, 7)

add_Bomb(Pylons_C_B, id_BR_250, 4)
add_Bomb(Pylons_C_B, id_BR_500, 4)
add_Bomb(Pylons_C_B, id_GBU_10, 4)
add_Bomb(Pylons_C_B, id_GBU_12, 4)

add_R530(Pylons_C_B, id_R530F_EM, 3, 4, 5)
add_R530(Pylons_C_B, id_R530F_IR, 3, 4, 5)
add_R530(Pylons_C_B, id_SUPER_530F, 3, 5)

---------------------------------------------------------------------------------------------
-- CE/BE/EE
Pylons_CE_BE_EE = {}
copyTable(Pylons_Common, Pylons_CE_BE_EE)

add_SRM(Pylons_CE_BE_EE, id_AIM_9B, 1, 7)
add_SRM(Pylons_CE_BE_EE, id_AIM_9J, 1, 7)
add_SRM(Pylons_CE_BE_EE, id_AIM_9P, 1, 7)
add_SRM(Pylons_CE_BE_EE, id_AIM_9JULI, 1, 7)
add_SRM(Pylons_CE_BE_EE, id_MAGIC_I, 1, 7)
add_SRM(Pylons_CE_BE_EE, id_MAGIC_II, 1, 7)

add_Bomb(Pylons_CE_BE_EE, id_MK82, 2, 3, 4, 5, 6)
add_Bomb(Pylons_CE_BE_EE, id_MK83, 2, 3, 4, 5, 6)
add_Bomb(Pylons_CE_BE_EE, id_BR_250, 2, 3, 4, 5, 6)
add_Bomb(Pylons_CE_BE_EE, id_BR_500, 2, 3, 4, 5, 6)
add_Bomb(Pylons_CE_BE_EE, id_GBU_10, 4)
add_Bomb(Pylons_CE_BE_EE, id_GBU_12, 3, 4, 5)
add_Bomb(Pylons_CE_BE_EE, id_GBU_16, 3, 5)
add_Bomb(Pylons_CE_BE_EE, id_CLB4_MK82, 4)

add_R530(Pylons_CE_BE_EE, id_R530F_EM, 3, 4, 5)
add_R530(Pylons_CE_BE_EE, id_R530F_IR, 3, 4, 5)
add_R530(Pylons_CE_BE_EE, id_SUPER_530F, 3, 5)

---------------------------------------------------------------------------------------------
-- EDA/DDA
Pylons_EDA_DDA = {}
copyTable(Pylons_Common, Pylons_EDA_DDA)

add_SRM(Pylons_EDA_DDA, id_MAGIC_I, 1, 7)

add_Bomb(Pylons_EDA_DDA, id_MK82, 2, 3, 4, 5, 6)
add_Bomb(Pylons_EDA_DDA, id_MK83, 2, 3, 4, 5, 6)
add_Bomb(Pylons_EDA_DDA, id_BR_250, 2, 3, 4, 5, 6)
add_Bomb(Pylons_EDA_DDA, id_BR_500, 2, 3, 4, 5, 6)
add_Bomb(Pylons_EDA_DDA, id_GBU_10, 3, 4, 5)
add_Bomb(Pylons_EDA_DDA, id_GBU_12, 3, 4, 5)
add_Bomb(Pylons_EDA_DDA, id_CLB4_MK82, 4)

add_R530(Pylons_EDA_DDA, id_SUPER_530F, 3, 5)

---------------------------------------------------------------------------------------------
-- ED/BD/EQ/BQ
Pylons_ED_BD_EQ_BQ = {}
copyTable(Pylons_Common, Pylons_ED_BD_EQ_BQ)

add_SRM(Pylons_ED_BD_EQ_BQ, id_MAGIC_I, 1, 7)
add_SRM(Pylons_ED_BD_EQ_BQ, id_MAGIC_II, 1, 7)

add_Bomb(Pylons_ED_BD_EQ_BQ, id_MK82, 2, 3, 4, 5, 6)
add_Bomb(Pylons_ED_BD_EQ_BQ, id_MK83, 2, 3, 4, 5, 6)
add_Bomb(Pylons_ED_BD_EQ_BQ, id_BR_250, 2, 3, 4, 5, 6)
add_Bomb(Pylons_ED_BD_EQ_BQ, id_BR_500, 2, 3, 4, 5, 6)
add_Bomb(Pylons_ED_BD_EQ_BQ, id_GBU_10, 3, 4, 5)
add_Bomb(Pylons_ED_BD_EQ_BQ, id_GBU_12, 3, 4, 5)
add_Bomb(Pylons_ED_BD_EQ_BQ, id_CLB4_MK82, 4)

add_R530(Pylons_ED_BD_EQ_BQ, id_SUPER_530F, 3, 5)

---------------------------------------------------------------------------------------------
-- C-200/CH/CJ/CK/CZ/EH/JA
Pylons_C200_CH_CJ_CK_CZ_EH_JA = {}
copyTable(Pylons_Common, Pylons_C200_CH_CJ_CK_CZ_EH_JA)

add_SRM(Pylons_C200_CH_CJ_CK_CZ_EH_JA, id_MAGIC_I, 1, 7)

add_Bomb(Pylons_C200_CH_CJ_CK_CZ_EH_JA, id_BR_250, 4)
add_Bomb(Pylons_C200_CH_CJ_CK_CZ_EH_JA, id_BR_500, 4)
add_Bomb(Pylons_C200_CH_CJ_CK_CZ_EH_JA, id_GBU_10, 4)
add_Bomb(Pylons_C200_CH_CJ_CK_CZ_EH_JA, id_GBU_12, 4)

add_R530(Pylons_C200_CH_CJ_CK_CZ_EH_JA, id_R530F_EM, 3, 4, 5)
add_R530(Pylons_C200_CH_CJ_CK_CZ_EH_JA, id_R530F_IR, 3, 4, 5)
add_R530(Pylons_C200_CH_CJ_CK_CZ_EH_JA, id_SUPER_530F, 3, 5)
