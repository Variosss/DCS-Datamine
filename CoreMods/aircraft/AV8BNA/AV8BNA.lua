dofile(current_mod_path.."/WEAPONS/AV8BNA_Weapons.lua")

-- Load restrictions
local Pylon_1_AIM9_Restrictions = {
	{station = 2, loadout = {"{BRU-42A_2*GBU-12_SIDE_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-83_LEFT}"}},
	{station = 2, loadout = {"{BRU-70A_3*GBU-38}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-38_SIDE_LEFT}"}},
	
	{station = 2, loadout = {"{BRU-70A_3*GBU-54}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-54_SIDE_LEFT}"}},
	
	{station = 2, loadout = {"{BRU-42_3*Mk-82LD}"}},		
	{station = 2, loadout = {"{BRU-42_2*Mk-82_LEFT}"}},
	
	{station = 2, loadout = {"{BRU-42_2*Mk-82AIR_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_3_MK82AIR}"}},
	
	{station = 2, loadout = {"{BRU-42_2*Mk-82SNAKEYE_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_3*Mk-82SNAKEYE}"}},
	
	{station = 2, loadout = {"{BRU-42_2*MK-20_LEFT}"}},
	{station = 2, loadout = {"{BRU-70_2*CBU-99_LEFT}"}},
	
	{station = 2, loadout = {"{BRU-42_3*Mk-81LD}"}},
	{station = 2, loadout = {"BRU-42_3*BDU-33"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	
	-- Deprecated, added for backward compatibility
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 2, loadout = {"{BRU-42_2*GBU-12_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_3*GBU-38}"}},
	{station = 2, loadout = {"{BRU-42_2*GBU-38_LEFT}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-54_LEFT}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
}

local Pylon_1_Bomb_Restrictions = {
	{station = 2, loadout = {"{BRU-42A_2*GBU-12_SIDE_LEFT}"}},
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

local Pylon_1_GBU12_Restrictions = {
	{station = 2, loadout = {"{BRU-42A_2*GBU-12_SIDE_LEFT}"}},
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	
	{station = 2, loadout = {"{BRU-70_3*GBU-38}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-38_SIDE_LEFT}"}},
	
	{station = 2, loadout = {"{BRU-70A_3*GBU-54}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-54_SIDE_LEFT}"}},
	
	{station = 2, loadout = {"{BRU-42_3*Mk-82LD}"}},		
	{station = 2, loadout = {"{BRU-42_2*Mk-82_LEFT}"}},
	
	{station = 2, loadout = {"{BRU-42_2*Mk-82AIR_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_3_MK82AIR}"}},
	
	{station = 2, loadout = {"{BRU-42_2*Mk-82SNAKEYE_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_3*Mk-82SNAKEYE}"}},
	
	{station = 2, loadout = {"{BRU-42_2*MK-20_LEFT}"}},
	{station = 2, loadout = {"{BRU-70_2*CBU-99_LEFT}"}},
	
	{station = 2, loadout = {"{BRU-42_3*Mk-81LD}"}},
	{station = 2, loadout = {"BRU-42_3*BDU-33"}},
	
	{station = 2, loadout = {"{AV8BNA_AERO1D}"}},
	{station = 2, loadout = {"{AV8BNA_AERO1D_EMPTY}"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	
	-- Deprecated, added for backward compatibility
	{station = 2, loadout = {"{BRU-42_2*GBU-12_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_3*GBU-38}"}},
	{station = 2, loadout = {"{BRU-42_2*GBU-38_LEFT}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-54_LEFT}"}},
}

local Pylon_1_FuelTank_Restriction = {
	{station = 2, loadout = {"{AV8BNA_AERO1D}"}},
	{station = 2, loadout = {"{AV8BNA_AERO1D_EMPTY}"}},
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

local Pylon_2_ITERx2_Restrictions = {
	{station = 1, loadout = {"{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}"}},
	{station = 1, loadout = {"{AIM-9L}"}},
	{station = 1, loadout = {"{AGM_122_SIDEARM}"}},
	{station = 1, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	{station = 1, loadout = {"{AIS_ASQ_T50}"}},
	{station = 1, loadout = {"CATM-9M"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

local Pylon_2_ITERx3_Restrictions = {
	{station = 1, loadout = {"{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}"}},
	{station = 1, loadout = {"{AIM-9L}"}},
	{station = 1, loadout = {"{AGM_122_SIDEARM}"}},
	{station = 1, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	{station = 1, loadout = {"{AIS_ASQ_T50}"}},
	{station = 1, loadout = {"CATM-9M"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	--{station = 3, loadout = {"{AV8BNA_AERO1D}"}},
	--{station = 3, loadout = {"{AV8BNA_AERO1D_EMPTY}"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

local Pylon_2_LITENING_Restrictions = {
	{station = 3, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	{station = 5, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	{station = 6, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	{station = 7, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

local Pylon_2_FuelTank_Restrictions = {
	{station = 1, loadout = {"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}},
	{station = 1, loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}},
	{station = 1, loadout = {"{Mk82SNAKEYE}"}},
	{station = 1, loadout = {"{Mk82AIR}"}},
	{station = 1, loadout = {"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}"}},
	{station = 1, loadout = {"{CBU_99}"}},
	{station = 1, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

local Pylon_3_LITENING_Restrictions = {
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 2, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	{station = 5, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	{station = 6, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	{station = 7, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

local Pylon_3_FuelTank_Restrictions = {
	--{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	--{station = 2, loadout = {"{BRU-70_3*GBU-38}"}},
	--{station = 2, loadout = {"{BRU-70A_3*GBU-54}"}},
	--{station = 2, loadout = {"{BRU-42_3*Mk-82LD}"}},		
	--{station = 2, loadout = {"{BRU-42_3_MK82AIR}"}},
	--{station = 2, loadout = {"{BRU-42_3*Mk-82SNAKEYE}"}},
	--{station = 2, loadout = {"{BRU-42_3*Mk-81LD}"}},
	--{station = 2, loadout = {"BRU-42_3*BDU-33"}},
	--{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

local Pylon_5_LITENING_Restrictions = {
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 2, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	{station = 3, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	{station = 6, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	{station = 7, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

local Pylon_6_FuelTank_Restrictions = {
	--{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	--{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	--{station = 7, loadout = {"{BRU-70_3*GBU-38}"}},
	--{station = 7, loadout = {"{BRU-70A_3*GBU-54}"}},
	--{station = 7, loadout = {"{BRU-42_3*Mk-82LD}"}},		
	--{station = 7, loadout = {"{BRU-42_3_MK82AIR}"}},
	--{station = 7, loadout = {"{BRU-42_3*Mk-82SNAKEYE}"}},
	--{station = 7, loadout = {"{BRU-42_3*Mk-81LD}"}},
	--{station = 7, loadout = {"BRU-42_3*BDU-33"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

local Pylon_6_LITENING_Restrictions = {
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 2, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	{station = 3, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	{station = 5, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	{station = 7, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

local Pylon_7_LITENING_Restrictions = {
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 2, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	{station = 3, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	{station = 5, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	{station = 6, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

local Pylon_7_ITERx2_Restrictions = {
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 8, loadout = {"{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}"}},
	{station = 8, loadout = {"{AIM-9L}"}},
	{station = 8, loadout = {"{AGM_122_SIDEARM}"}},
	{station = 8, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	{station = 8, loadout = {"{AIS_ASQ_T50}"}},
	{station = 8, loadout = {"CATM-9M"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

local Pylon_7_ITERx3_Restrictions = {

	
	{station = 8, loadout = {"{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}"}},
	{station = 8, loadout = {"{AIM-9L}"}},
	{station = 8, loadout = {"{AGM_122_SIDEARM}"}},
	{station = 8, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	{station = 8, loadout = {"{AIS_ASQ_T50}"}},
	{station = 8, loadout = {"CATM-9M"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	--{station = 8},
	--{station = 6, loadout = {"{AV8BNA_AERO1D}"}},
	--{station = 6, loadout = {"{AV8BNA_AERO1D_EMPTY}"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

local Pylon_7_FuelTank_Restrictions = {
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 8, loadout = {"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}},
	{station = 8, loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}},
	{station = 8, loadout = {"{Mk82SNAKEYE}"}},
	{station = 8, loadout = {"{Mk82AIR}"}},
	{station = 8, loadout = {"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}"}},
	{station = 8, loadout = {"{CBU_99}"}},
	{station = 8, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

local Pylon_8_AIM9_Restrictions = {
	
	{station = 7, loadout = {"{BRU-42_2*Mk-83_RIGHT}"}},
	---
	{station = 7, loadout = {"{BRU-42A_2*GBU-12_SIDE_RIGHT}"}},
	
	{station = 7, loadout = {"{BRU-70A_3*GBU-38}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-38_SIDE_RIGHT}"}},
	
	{station = 7, loadout = {"{BRU-70A_3*GBU-54}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-54_SIDE_RIGHT}"}},
	
	{station = 7, loadout = {"{BRU-42_3*Mk-82LD}"}},		
	{station = 7, loadout = {"{BRU-42_2*Mk-82_RIGHT}"}},
	
	{station = 7, loadout = {"{BRU-42_2*Mk-82AIR_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_3_MK82AIR}"}},
	
	{station = 7, loadout = {"{BRU-42_2*Mk-82SNAKEYE_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_3*Mk-82SNAKEYE}"}},
	
	{station = 7, loadout = {"{BRU-42_2*MK-20_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70_2*CBU-99_RIGHT}"}},
	
	{station = 7, loadout = {"{BRU-42_3*Mk-81LD}"}},
	{station = 7, loadout = {"BRU-42_3*BDU-33"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	
	-- Deprecated, added for backward compatibility
	{station = 7, loadout = {"{BRU-42_2*GBU-12_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_3*GBU-38}"}},
	{station = 7, loadout = {"{BRU-42_2*GBU-38_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-54_RIGHT}"}},
}

local Pylon_8_GBU12_Restrictions = {
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 7, loadout = {"{BRU-42A_2*GBU-12_SIDE_RIGHT}"}},
	
	{station = 7, loadout = {"{BRU-70_3*GBU-38}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-38_SIDE_RIGHT}"}},
	
	{station = 7, loadout = {"{BRU-70A_3*GBU-54}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-54_SIDE_RIGHT}"}},
	
	{station = 7, loadout = {"{BRU-42_3*Mk-82LD}"}},		
	{station = 7, loadout = {"{BRU-42_2*Mk-82_RIGHT}"}},
	
	{station = 7, loadout = {"{BRU-42_2*Mk-82AIR_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_3_MK82AIR}"}},
	
	{station = 7, loadout = {"{BRU-42_2*Mk-82SNAKEYE_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_3*Mk-82SNAKEYE}"}},
	
	{station = 7, loadout = {"{BRU-42_2*MK-20_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70_2*CBU-99_RIGHT}"}},
	
	{station = 7, loadout = {"{BRU-42_3*Mk-81LD}"}},
	{station = 7, loadout = {"BRU-42_3*BDU-33"}},
	
	{station = 7, loadout = {"{AV8BNA_AERO1D}"}},
	{station = 7, loadout = {"{AV8BNA_AERO1D_EMPTY}"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	
	-- Deprecated, added for backward compatibility
	{station = 7, loadout = {"{BRU-42_2*GBU-12_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70A_3*GBU-38}"}},
	{station = 7, loadout = {"{BRU-42_2*GBU-38_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-54_RIGHT}"}},
}

local Pylon_8_FuelTank_Restriction = {
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	--{station = 7, loadout = {"{AV8BNA_AERO1D}"}},
	--{station = 7, loadout = {"{AV8BNA_AERO1D_EMPTY}"}},
}

local Pylon_1_Smokewinder_Restriction = {
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 2, loadout = {"{AIM-9M-ON-ADAPTER}"}},
	{station = 2, loadout = {"{AIM-9L-ON-ADAPTER}"}},
	---
	{station = 2, loadout = {"{LAU_7_AGM_122_SIDEARM}"}},
	---
	{station = 2, loadout = {"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}},
	{station = 2, loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}},
	{station = 2, loadout = {"{Mk82SNAKEYE}"}},
	{station = 2, loadout = {"{Mk82AIR}"}},
	{station = 2, loadout = {"{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}"}},
	{station = 2, loadout = {"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}"}},
	{station = 2, loadout = {"{CBU_99}"}},
	{station = 2, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	{station = 2, loadout = {"{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}"}},
	{station = 2, loadout = {"{GBU-38}"}},
	{station = 2, loadout = {"{GBU_32_V_2B}"}},
	{station = 2, loadout = {"{GBU_54_V_1B}"}},
	---
	{station = 2, loadout = {"{BRU-42_2*Mk-82_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_2*MK-20_LEFT}"}},
	{station = 2, loadout = {"{BRU-70_2*CBU-99_LEFT}"}},
	{station = 2, loadout = {"{BRU-42A_2*GBU-12_SIDE_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-82AIR_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-82SNAKEYE_LEFT}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-38_SIDE_LEFT}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-54_SIDE_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-82_RIGHT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-83_RIGHT}"}},
	{station = 2, loadout = {"{BRU-42_2*MK-20_RIGHT}"}},
	{station = 2, loadout = {"{BRU-70_2*CBU-99_RIGHT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-82AIR_RIGHT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-82SNAKEYE_RIGHT}"}},
	{station = 2, loadout = {"{BRU-42_2*GBU-38_RIGHT}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-54_RIGHT}"}},
	---
	{station = 2, loadout = {"{BRU-42_3*Mk-81LD}"}},
	{station = 2, loadout = {"{BRU-42_3*Mk-82LD}"}},
	{station = 2, loadout = {"{BRU-42_3_MK82AIR}"}},
	{station = 2, loadout = {"{BRU-42_3*Mk-82SNAKEYE}"}},
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 2, loadout = {"{BRU-70_3*GBU-38}"}},
	{station = 2, loadout = {"{BRU-70A_3*GBU-54}"}},
	---
	{station = 2, loadout = {"{BDU-33}"}},
	{station = 2, loadout = {"BRU-42_3*BDU-33"}},
	---
	{station = 2, loadout = {"{F16A4DE0-116C-4A71-97F0-2CF85B0313EC}"}},
	{station = 2, loadout = {"LAU_117_AGM_65L"}},
	{station = 2, loadout = {"LAU_117_AGM_65F"}},
	---
	{station = 2, loadout = {"{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}"}},
	{station = 2, loadout = {"{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}"}},
	{station = 2, loadout = {"{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}"}},
	{station = 2, loadout = {"{4F977A2A-CD25-44df-90EF-164BFA2AE72F}"}},
	{station = 2, loadout = {"{1F7136CB-8120-4e77-B97B-945FF01FB67C}"}},
	{station = 2, loadout = {"{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}"}},
	{station = 2, loadout = {"{0877B74B-5A00-4e61-BA8A-A56450BA9E27}"}},
	{station = 2, loadout = {"{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}"}},
	{station = 2, loadout = {"{LAU-131 - 7 AGR-20A}"}},
	{station = 2, loadout = {"{LAU-131 - 7 AGR-20 M282}"}},
	{station = 2, loadout = {"{LAU3_FFAR_WP156}"}},
	{station = 2, loadout = {"{LAU3_FFAR_MK1HE}"}},
	{station = 2, loadout = {"{LAU3_FFAR_MK5HEAT}"}},
	---
	{station = 2, loadout = {"{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}"}},
	{station = 2, loadout = {"{BRU-42_LS_3*SUU-25_8*LUU-2}",}},
	---
	{station = 2, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	---
	{station = 2, loadout = {"{AV8BNA_AERO1D}"}},
	{station = 2, loadout = {"{AV8BNA_AERO1D_EMPTY}"}},
	---
	{station = 3},
	{station = 4},
	{station = 5},
	{station = 6},
	---
	{station = 7, loadout = {"{AIM-9M-ON-ADAPTER}"}},
	{station = 7, loadout = {"{AIM-9L-ON-ADAPTER}"}},
	---
	{station = 7, loadout = {"{LAU_7_AGM_122_SIDEARM}"}},
	---
	{station = 7, loadout = {"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}},
	{station = 7, loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}},
	{station = 7, loadout = {"{Mk82SNAKEYE}"}},
	{station = 7, loadout = {"{Mk82AIR}"}},
	{station = 7, loadout = {"{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}"}},
	{station = 7, loadout = {"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}"}},
	{station = 7, loadout = {"{CBU_99}"}},
	{station = 7, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	{station = 7, loadout = {"{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}"}},
	{station = 7, loadout = {"{GBU-38}"}},
	{station = 7, loadout = {"{GBU_32_V_2B}"}},
	{station = 7, loadout = {"{GBU_54_V_1B}"}},
	---
	{station = 7, loadout = {"{BRU-42_2*Mk-82_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_2*MK-20_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70_2*CBU-99_LEFT}"}},
	{station = 7, loadout = {"{BRU-42A_2*GBU-12_SIDE_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-82AIR_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-82SNAKEYE_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-38_SIDE_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-54_SIDE_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-82_LEFT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-83_LEFT}"}},
	{station = 7, loadout = {"{BRU-42_2*MK-20_LEFT}"}},
	{station = 7, loadout = {"{BRU-70_2*CBU-99_LEFT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-82AIR_LEFT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-82SNAKEYE_LEFT}"}},
	{station = 7, loadout = {"{BRU-42_2*GBU-38_LEFT}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-54_LEFT}"}},
	---
	{station = 7, loadout = {"{BRU-42_3*Mk-81LD}"}},
	{station = 7, loadout = {"{BRU-42_3*Mk-82LD}"}},
	{station = 7, loadout = {"{BRU-42_3_MK82AIR}"}},
	{station = 7, loadout = {"{BRU-42_3*Mk-82SNAKEYE}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 7, loadout = {"{BRU-70_3*GBU-38}"}},
	{station = 7, loadout = {"{BRU-70A_3*GBU-54}"}},
	---
	{station = 7, loadout = {"{BDU-33}"}},
	{station = 7, loadout = {"BRU-42_3*BDU-33"}},
	---
	{station = 7, loadout = {"{F16A4DE0-116C-4A71-97F0-2CF85B0313EC}"}},
	{station = 7, loadout = {"LAU_117_AGM_65L"}},
	{station = 7, loadout = {"LAU_117_AGM_65F"}},
	---
	{station = 7, loadout = {"{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}"}},
	{station = 7, loadout = {"{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}"}},
	{station = 7, loadout = {"{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}"}},
	{station = 7, loadout = {"{4F977A2A-CD25-44df-90EF-164BFA2AE72F}"}},
	{station = 7, loadout = {"{1F7136CB-8120-4e77-B97B-945FF01FB67C}"}},
	{station = 7, loadout = {"{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}"}},
	{station = 7, loadout = {"{0877B74B-5A00-4e61-BA8A-A56450BA9E27}"}},
	{station = 7, loadout = {"{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}"}},
	{station = 7, loadout = {"{LAU-131 - 7 AGR-20A}"}},
	{station = 7, loadout = {"{LAU-131 - 7 AGR-20 M282}"}},
	{station = 7, loadout = {"{LAU3_FFAR_WP156}"}},
	{station = 7, loadout = {"{LAU3_FFAR_MK1HE}"}},
	{station = 7, loadout = {"{LAU3_FFAR_MK5HEAT}"}},
	---
	{station = 7, loadout = {"{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}"}},
	{station = 7, loadout = {"{BRU-42_LS_3*SUU-25_8*LUU-2}",}},
	---
	{station = 7, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	---
	{station = 7, loadout = {"{AV8BNA_AERO1D}"}},
	{station = 7, loadout = {"{AV8BNA_AERO1D_EMPTY}"}},
	---
	{station = 8, loadout = {"{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}"}},
	{station = 8, loadout = {"{AIM-9L}"}},
	---
	{station = 8, loadout = {"{AGM_122_SIDEARM}"}},
	---
	{station = 8, loadout = {"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}},
	{station = 8, loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}},
	{station = 8, loadout = {"{Mk82SNAKEYE}"}},
	{station = 8, loadout = {"{Mk82AIR}"}},
	{station = 8, loadout = {"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}"}},
	{station = 8, loadout = {"{CBU_99}"}},
	{station = 8, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	---
	{station = 8, loadout = {"{AIS_ASQ_T50}"}},
	{station = 8, loadout = {"CATM-9M"}},
	{station = 8, loadout = {"{BDU-33}"}},
	
	-- Deprecated, added for backward compatibility
	{station = 2, loadout = {"{BRU-42_2*GBU-12_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_3*GBU-38}"}},
	{station = 2, loadout = {"{BRU-42_2*GBU-38_LEFT}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-54_LEFT}"}},
	---
	{station = 7, loadout = {"{BRU-42_2*GBU-12_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_3*GBU-38}"}},
	{station = 7, loadout = {"{BRU-42_2*GBU-38_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-54_RIGHT}"}},
}

local Pylon_2_Smokewinder_Restriction = {
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 1, loadout = {"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}},
	{station = 1, loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}},
	{station = 1, loadout = {"{Mk82SNAKEYE}"}},
	{station = 1, loadout = {"{Mk82AIR}"}},
	{station = 1, loadout = {"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}"}},
	{station = 1, loadout = {"{CBU_99}"}},
	{station = 1, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	---
	{station = 1, loadout = {"{AIS_ASQ_T50}"}},
	{station = 1, loadout = {"CATM-9M"}},
	{station = 1, loadout = {"{BDU-33}"}},
	---
	{station = 3},
	{station = 4},
	{station = 5},
	{station = 6},
	---
	{station = 7, loadout = {"{AIM-9M-ON-ADAPTER}"}},
	{station = 7, loadout = {"{AIM-9L-ON-ADAPTER}"}},
	---
	{station = 7, loadout = {"{LAU_7_AGM_122_SIDEARM}"}},
	---
	{station = 7, loadout = {"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}},
	{station = 7, loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}},
	{station = 7, loadout = {"{Mk82SNAKEYE}"}},
	{station = 7, loadout = {"{Mk82AIR}"}},
	{station = 7, loadout = {"{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}"}},
	{station = 7, loadout = {"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}"}},
	{station = 7, loadout = {"{CBU_99}"}},
	{station = 7, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	{station = 7, loadout = {"{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}"}},
	{station = 7, loadout = {"{GBU-38}"}},
	{station = 7, loadout = {"{GBU_32_V_2B}"}},
	{station = 7, loadout = {"{GBU_54_V_1B}"}},
	---
	{station = 7, loadout = {"{BRU-42_2*Mk-82_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_2*MK-20_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70_2*CBU-99_LEFT}"}},
	{station = 7, loadout = {"{BRU-42A_2*GBU-12_SIDE_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-82AIR_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-82SNAKEYE_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-38_SIDE_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-54_SIDE_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-82_LEFT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-83_LEFT}"}},
	{station = 7, loadout = {"{BRU-42_2*MK-20_LEFT}"}},
	{station = 7, loadout = {"{BRU-70_2*CBU-99_LEFT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-82AIR_LEFT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-82SNAKEYE_LEFT}"}},
	{station = 7, loadout = {"{BRU-42_2*GBU-38_LEFT}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-54_LEFT}"}},
	---
	{station = 7, loadout = {"{BRU-42_3*Mk-81LD}"}},
	{station = 7, loadout = {"{BRU-42_3*Mk-82LD}"}},
	{station = 7, loadout = {"{BRU-42_3_MK82AIR}"}},
	{station = 7, loadout = {"{BRU-42_3*Mk-82SNAKEYE}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 7, loadout = {"{BRU-70_3*GBU-38}"}},
	{station = 7, loadout = {"{BRU-70A_3*GBU-54}"}},
	---
	{station = 7, loadout = {"{BDU-33}"}},
	{station = 7, loadout = {"BRU-42_3*BDU-33"}},
	---
	{station = 7, loadout = {"{F16A4DE0-116C-4A71-97F0-2CF85B0313EC}"}},
	{station = 7, loadout = {"LAU_117_AGM_65L"}},
	{station = 7, loadout = {"LAU_117_AGM_65F"}},
	---
	{station = 7, loadout = {"{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}"}},
	{station = 7, loadout = {"{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}"}},
	{station = 7, loadout = {"{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}"}},
	{station = 7, loadout = {"{4F977A2A-CD25-44df-90EF-164BFA2AE72F}"}},
	{station = 7, loadout = {"{1F7136CB-8120-4e77-B97B-945FF01FB67C}"}},
	{station = 7, loadout = {"{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}"}},
	{station = 7, loadout = {"{0877B74B-5A00-4e61-BA8A-A56450BA9E27}"}},
	{station = 7, loadout = {"{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}"}},
	{station = 7, loadout = {"{LAU-131 - 7 AGR-20A}"}},
	{station = 7, loadout = {"{LAU-131 - 7 AGR-20 M282}"}},
	{station = 7, loadout = {"{LAU3_FFAR_WP156}"}},
	{station = 7, loadout = {"{LAU3_FFAR_MK1HE}"}},
	{station = 7, loadout = {"{LAU3_FFAR_MK5HEAT}"}},
	---
	{station = 7, loadout = {"{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}"}},
	{station = 7, loadout = {"{BRU-42_LS_3*SUU-25_8*LUU-2}",}},
	---
	{station = 7, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	---
	{station = 8, loadout = {"{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}"}},
	{station = 8, loadout = {"{AIM-9L}"}},
	---
	{station = 8, loadout = {"{AGM_122_SIDEARM}"}},
	---
	{station = 8, loadout = {"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}},
	{station = 8, loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}},
	{station = 8, loadout = {"{Mk82SNAKEYE}"}},
	{station = 8, loadout = {"{Mk82AIR}"}},
	{station = 8, loadout = {"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}"}},
	{station = 8, loadout = {"{CBU_99}"}},
	{station = 8, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	---
	{station = 8, loadout = {"{AIS_ASQ_T50}"}},
	{station = 8, loadout = {"CATM-9M"}},
	{station = 8, loadout = {"{BDU-33}"}},
	---
	
	-- Deprecated, added for backward compatibility
	{station = 2, loadout = {"{BRU-42_2*GBU-12_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_3*GBU-38}"}},
	{station = 2, loadout = {"{BRU-42_2*GBU-38_LEFT}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-54_LEFT}"}},
	---
	{station = 7, loadout = {"{BRU-42_2*GBU-12_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_3*GBU-38}"}},
	{station = 7, loadout = {"{BRU-42_2*GBU-38_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-54_RIGHT}"}},
}

local Pylon_7_Smokewinder_Restriction = {
	{station = 1, loadout = {"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}},
	{station = 1, loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}},
	{station = 1, loadout = {"{Mk82SNAKEYE}"}},
	{station = 1, loadout = {"{Mk82AIR}"}},
	{station = 1, loadout = {"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}"}},
	{station = 1, loadout = {"{CBU_99}"}},
	{station = 1, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	---
	{station = 1, loadout = {"{AIS_ASQ_T50}"}},
	{station = 1, loadout = {"CATM-9M"}},
	{station = 1, loadout = {"{BDU-33}"}},
	---
	{station = 2, loadout = {"{AIM-9M-ON-ADAPTER}"}},
	{station = 2, loadout = {"{AIM-9L-ON-ADAPTER}"}},
	---
	{station = 2, loadout = {"{LAU_7_AGM_122_SIDEARM}"}},
	---
	{station = 2, loadout = {"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}},
	{station = 2, loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}},
	{station = 2, loadout = {"{Mk82SNAKEYE}"}},
	{station = 2, loadout = {"{Mk82AIR}"}},
	{station = 2, loadout = {"{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}"}},
	{station = 2, loadout = {"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}"}},
	{station = 2, loadout = {"{CBU_99}"}},
	{station = 2, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	{station = 2, loadout = {"{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}"}},
	{station = 2, loadout = {"{GBU-38}"}},
	{station = 2, loadout = {"{GBU_32_V_2B}"}},
	{station = 2, loadout = {"{GBU_54_V_1B}"}},
	---
	{station = 2, loadout = {"{BRU-42_2*Mk-82_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_2*MK-20_LEFT}"}},
	{station = 2, loadout = {"{BRU-70_2*CBU-99_LEFT}"}},
	{station = 2, loadout = {"{BRU-42A_2*GBU-12_SIDE_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-82AIR_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-82SNAKEYE_LEFT}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-38_SIDE_LEFT}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-54_SIDE_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-82_RIGHT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-83_RIGHT}"}},
	{station = 2, loadout = {"{BRU-42_2*MK-20_RIGHT}"}},
	{station = 2, loadout = {"{BRU-70_2*CBU-99_RIGHT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-82AIR_RIGHT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-82SNAKEYE_RIGHT}"}},
	{station = 2, loadout = {"{BRU-42_2*GBU-38_RIGHT}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-54_RIGHT}"}},
	---
	{station = 2, loadout = {"{BRU-42_3*Mk-81LD}"}},
	{station = 2, loadout = {"{BRU-42_3*Mk-82LD}"}},
	{station = 2, loadout = {"{BRU-42_3_MK82AIR}"}},
	{station = 2, loadout = {"{BRU-42_3*Mk-82SNAKEYE}"}},
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 2, loadout = {"{BRU-70_3*GBU-38}"}},
	{station = 2, loadout = {"{BRU-70A_3*GBU-54}"}},
	---
	{station = 2, loadout = {"{BDU-33}"}},
	{station = 2, loadout = {"BRU-42_3*BDU-33"}},
	---
	{station = 2, loadout = {"{F16A4DE0-116C-4A71-97F0-2CF85B0313EC}"}},
	{station = 2, loadout = {"LAU_117_AGM_65L"}},
	{station = 2, loadout = {"LAU_117_AGM_65F"}},
	---
	{station = 2, loadout = {"{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}"}},
	{station = 2, loadout = {"{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}"}},
	{station = 2, loadout = {"{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}"}},
	{station = 2, loadout = {"{4F977A2A-CD25-44df-90EF-164BFA2AE72F}"}},
	{station = 2, loadout = {"{1F7136CB-8120-4e77-B97B-945FF01FB67C}"}},
	{station = 2, loadout = {"{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}"}},
	{station = 2, loadout = {"{0877B74B-5A00-4e61-BA8A-A56450BA9E27}"}},
	{station = 2, loadout = {"{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}"}},
	{station = 2, loadout = {"{LAU-131 - 7 AGR-20A}"}},
	{station = 2, loadout = {"{LAU-131 - 7 AGR-20 M282}"}},
	{station = 2, loadout = {"{LAU3_FFAR_WP156}"}},
	{station = 2, loadout = {"{LAU3_FFAR_MK1HE}"}},
	{station = 2, loadout = {"{LAU3_FFAR_MK5HEAT}"}},
	---
	{station = 2, loadout = {"{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}"}},
	{station = 2, loadout = {"{BRU-42_LS_3*SUU-25_8*LUU-2}",}},
	---
	{station = 2, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	---
	{station = 2, loadout = {"{AV8BNA_AERO1D}"}},
	{station = 2, loadout = {"{AV8BNA_AERO1D_EMPTY}"}},
	---
	{station = 3},
	{station = 4},
	{station = 5},
	{station = 6},
	---
	{station = 8, loadout = {"{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}"}},
	{station = 8, loadout = {"{AIM-9L}"}},
	---
	{station = 8, loadout = {"{AGM_122_SIDEARM}"}},
	---
	{station = 8, loadout = {"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}},
	{station = 8, loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}},
	{station = 8, loadout = {"{Mk82SNAKEYE}"}},
	{station = 8, loadout = {"{Mk82AIR}"}},
	{station = 8, loadout = {"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}"}},
	{station = 8, loadout = {"{CBU_99}"}},
	{station = 8, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	---
	{station = 8, loadout = {"{AIS_ASQ_T50}"}},
	{station = 8, loadout = {"CATM-9M"}},
	{station = 8, loadout = {"{BDU-33}"}},
	---
	
	-- Deprecated, added for backward compatibility
	{station = 2, loadout = {"{BRU-42_2*GBU-12_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_3*GBU-38}"}},
	{station = 2, loadout = {"{BRU-42_2*GBU-38_LEFT}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-54_LEFT}"}},
	---
	{station = 7, loadout = {"{BRU-42_2*GBU-12_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_3*GBU-38}"}},
	{station = 7, loadout = {"{BRU-42_2*GBU-38_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-54_RIGHT}"}},
}

local Pylon_8_Smokewinder_Restriction = {
	{station = 1, loadout = {"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}},
	{station = 1, loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}},
	{station = 1, loadout = {"{Mk82SNAKEYE}"}},
	{station = 1, loadout = {"{Mk82AIR}"}},
	{station = 1, loadout = {"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}"}},
	{station = 1, loadout = {"{CBU_99}"}},
	{station = 1, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	---
	{station = 1, loadout = {"{AIS_ASQ_T50}"}},
	{station = 1, loadout = {"CATM-9M"}},
	{station = 1, loadout = {"{BDU-33}"}},
	---
	{station = 2, loadout = {"{AIM-9M-ON-ADAPTER}"}},
	{station = 2, loadout = {"{AIM-9L-ON-ADAPTER}"}},
	---
	{station = 2, loadout = {"{LAU_7_AGM_122_SIDEARM}"}},
	---
	{station = 2, loadout = {"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}},
	{station = 2, loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}},
	{station = 2, loadout = {"{Mk82SNAKEYE}"}},
	{station = 2, loadout = {"{Mk82AIR}"}},
	{station = 2, loadout = {"{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}"}},
	{station = 2, loadout = {"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}"}},
	{station = 2, loadout = {"{CBU_99}"}},
	{station = 2, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	{station = 2, loadout = {"{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}"}},
	{station = 2, loadout = {"{GBU-38}"}},
	{station = 2, loadout = {"{GBU_32_V_2B}"}},
	{station = 2, loadout = {"{GBU_54_V_1B}"}},
	---
	{station = 2, loadout = {"{BRU-42_2*Mk-82_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_2*MK-20_LEFT}"}},
	{station = 2, loadout = {"{BRU-70_2*CBU-99_LEFT}"}},
	{station = 2, loadout = {"{BRU-42A_2*GBU-12_SIDE_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-82AIR_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-82SNAKEYE_LEFT}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-38_SIDE_LEFT}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-54_SIDE_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-82_RIGHT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-83_RIGHT}"}},
	{station = 2, loadout = {"{BRU-42_2*MK-20_RIGHT}"}},
	{station = 2, loadout = {"{BRU-70_2*CBU-99_RIGHT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-82AIR_RIGHT}"}},
	{station = 2, loadout = {"{BRU-42_2*Mk-82SNAKEYE_RIGHT}"}},
	{station = 2, loadout = {"{BRU-42_2*GBU-38_RIGHT}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-54_RIGHT}"}},
	---
	{station = 2, loadout = {"{BRU-42_3*Mk-81LD}"}},
	{station = 2, loadout = {"{BRU-42_3*Mk-82LD}"}},
	{station = 2, loadout = {"{BRU-42_3_MK82AIR}"}},
	{station = 2, loadout = {"{BRU-42_3*Mk-82SNAKEYE}"}},
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 2, loadout = {"{BRU-70_3*GBU-38}"}},
	{station = 2, loadout = {"{BRU-70A_3*GBU-54}"}},
	---
	{station = 2, loadout = {"{BDU-33}"}},
	{station = 2, loadout = {"BRU-42_3*BDU-33"}},
	---
	{station = 2, loadout = {"{F16A4DE0-116C-4A71-97F0-2CF85B0313EC}"}},
	{station = 2, loadout = {"LAU_117_AGM_65L"}},
	{station = 2, loadout = {"LAU_117_AGM_65F"}},
	---
	{station = 2, loadout = {"{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}"}},
	{station = 2, loadout = {"{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}"}},
	{station = 2, loadout = {"{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}"}},
	{station = 2, loadout = {"{4F977A2A-CD25-44df-90EF-164BFA2AE72F}"}},
	{station = 2, loadout = {"{1F7136CB-8120-4e77-B97B-945FF01FB67C}"}},
	{station = 2, loadout = {"{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}"}},
	{station = 2, loadout = {"{0877B74B-5A00-4e61-BA8A-A56450BA9E27}"}},
	{station = 2, loadout = {"{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}"}},
	{station = 2, loadout = {"{LAU-131 - 7 AGR-20A}"}},
	{station = 2, loadout = {"{LAU-131 - 7 AGR-20 M282}"}},
	{station = 2, loadout = {"{LAU3_FFAR_WP156}"}},
	{station = 2, loadout = {"{LAU3_FFAR_MK1HE}"}},
	{station = 2, loadout = {"{LAU3_FFAR_MK5HEAT}"}},
	---
	{station = 2, loadout = {"{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}"}},
	{station = 2, loadout = {"{BRU-42_LS_3*SUU-25_8*LUU-2}",}},
	---
	{station = 2, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	---
	{station = 2, loadout = {"{AV8BNA_AERO1D}"}},
	{station = 2, loadout = {"{AV8BNA_AERO1D_EMPTY}"}},
	---
	{station = 3},
	{station = 4},
	{station = 5},
	{station = 6},
	---
	{station = 7, loadout = {"{AIM-9M-ON-ADAPTER}"}},
	{station = 7, loadout = {"{AIM-9L-ON-ADAPTER}"}},
	---
	{station = 7, loadout = {"{LAU_7_AGM_122_SIDEARM}"}},
	---
	{station = 7, loadout = {"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}},
	{station = 7, loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}},
	{station = 7, loadout = {"{Mk82SNAKEYE}"}},
	{station = 7, loadout = {"{Mk82AIR}"}},
	{station = 7, loadout = {"{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}"}},
	{station = 7, loadout = {"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}"}},
	{station = 7, loadout = {"{CBU_99}"}},
	{station = 7, loadout = {"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"}},
	{station = 7, loadout = {"{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}"}},
	{station = 7, loadout = {"{GBU-38}"}},
	{station = 7, loadout = {"{GBU_32_V_2B}"}},
	{station = 7, loadout = {"{GBU_54_V_1B}"}},
	---
	{station = 7, loadout = {"{BRU-42_2*Mk-82_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_2*MK-20_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70_2*CBU-99_LEFT}"}},
	{station = 7, loadout = {"{BRU-42A_2*GBU-12_SIDE_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-82AIR_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-82SNAKEYE_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-38_SIDE_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-54_SIDE_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-82_LEFT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-83_LEFT}"}},
	{station = 7, loadout = {"{BRU-42_2*MK-20_LEFT}"}},
	{station = 7, loadout = {"{BRU-70_2*CBU-99_LEFT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-82AIR_LEFT}"}},
	{station = 7, loadout = {"{BRU-42_2*Mk-82SNAKEYE_LEFT}"}},
	{station = 7, loadout = {"{BRU-42_2*GBU-38_LEFT}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-54_LEFT}"}},
	---
	{station = 7, loadout = {"{BRU-42_3*Mk-81LD}"}},
	{station = 7, loadout = {"{BRU-42_3*Mk-82LD}"}},
	{station = 7, loadout = {"{BRU-42_3_MK82AIR}"}},
	{station = 7, loadout = {"{BRU-42_3*Mk-82SNAKEYE}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 7, loadout = {"{BRU-70_3*GBU-38}"}},
	{station = 7, loadout = {"{BRU-70A_3*GBU-54}"}},
	---
	{station = 7, loadout = {"{BDU-33}"}},
	{station = 7, loadout = {"BRU-42_3*BDU-33"}},
	---
	{station = 7, loadout = {"{F16A4DE0-116C-4A71-97F0-2CF85B0313EC}"}},
	{station = 7, loadout = {"LAU_117_AGM_65L"}},
	{station = 7, loadout = {"LAU_117_AGM_65F"}},
	---
	{station = 7, loadout = {"{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}"}},
	{station = 7, loadout = {"{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}"}},
	{station = 7, loadout = {"{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}"}},
	{station = 7, loadout = {"{4F977A2A-CD25-44df-90EF-164BFA2AE72F}"}},
	{station = 7, loadout = {"{1F7136CB-8120-4e77-B97B-945FF01FB67C}"}},
	{station = 7, loadout = {"{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}"}},
	{station = 7, loadout = {"{0877B74B-5A00-4e61-BA8A-A56450BA9E27}"}},
	{station = 7, loadout = {"{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}"}},
	{station = 7, loadout = {"{LAU-131 - 7 AGR-20A}"}},
	{station = 7, loadout = {"{LAU-131 - 7 AGR-20 M282}"}},
	{station = 7, loadout = {"{LAU3_FFAR_WP156}"}},
	{station = 7, loadout = {"{LAU3_FFAR_MK1HE}"}},
	{station = 7, loadout = {"{LAU3_FFAR_MK5HEAT}"}},
	---
	{station = 7, loadout = {"{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}"}},
	{station = 7, loadout = {"{BRU-42_LS_3*SUU-25_8*LUU-2}",}},
	---
	{station = 7, loadout = {"{A111396E-D3E8-4b9c-8AC9-2432489304D5}"}},
	---
	{station = 7, loadout = {"{AV8BNA_AERO1D}"}},
	{station = 7, loadout = {"{AV8BNA_AERO1D_EMPTY}"}},
	---
	{station = 1, loadout = {"{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}"}},
	{station = 1, loadout = {"{AIM-9L}"}},
	---
	{station = 1, loadout = {"{AGM_122_SIDEARM}"}},
	---
	
	-- Deprecated, added for backward compatibility
	{station = 2, loadout = {"{BRU-42_2*GBU-12_LEFT}"}},
	{station = 2, loadout = {"{BRU-42_3*GBU-38}"}},
	{station = 2, loadout = {"{BRU-42_2*GBU-38_LEFT}"}},
	{station = 2, loadout = {"{BRU-70A_2*GBU-54_LEFT}"}},
	---
	{station = 7, loadout = {"{BRU-42_2*GBU-12_RIGHT}"}},
	{station = 7, loadout = {"{BRU-42_3*GBU-38}"}},
	{station = 7, loadout = {"{BRU-42_2*GBU-38_RIGHT}"}},
	{station = 7, loadout = {"{BRU-70A_2*GBU-54_RIGHT}"}},
}

local Pods_Restrictions = {
	{station = 2, loadout = {"{BRU-42A_3*GBU-12}"}},
	{station = 7, loadout = {"{BRU-42A_3*GBU-12}"}},
	---
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 1, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 2, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 7, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
	---
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"}},
	{station = 8, loadout = {"{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"}},
}

--all aim-9 models in last version are centered
local aim_9_attachment_point = {0.5 , -0.062 , 0}
local tpod_attachment_point = { -0.15, -0.2, 0.0}

AV8BNA =  {

	Name 				=   'AV8BNA',
	DisplayName			= _('AV-8B N/A'),
	ViewSettings		= ViewSettings,

	--HumanCockpit 		= true,
	--HumanCockpitPath    = current_mod_path..'/Cockpit/',

	Picture 			= "AV8BNA.png",
	Rate 				= 50, -- RewardPoint in Multiplayer
	Shape 				= "AV8BNA",
	
	LandRWCategories = 
    {
        [1] = 
        {
           Name = "HelicopterCarrier",
        },
        [2] = 
        {
           Name = "AircraftCarrier",
        },
        [3] = 
        {
            Name = "AircraftCarrier With Catapult",
        }, 
        [4] = 
        {
            Name = "AircraftCarrier With Tramplin",
        }, 
    },
	
	TakeOffRWCategories = 
    {
        [1] = 
        {
            Name = "HelicopterCarrier",
        },
        [2] = 
        {
           Name = "AircraftCarrier",
        },
        [3] = 
        {
            Name = "AircraftCarrier With Catapult",
        }, 
        [4] = 
        {
            Name = "AircraftCarrier With Tramplin",
        }, 
    },
	
	takeoff_and_landing_type = "VTOL",
	
	-------------------------
	shape_table_data 	=
	{
		{
			file  	 = 'AV8BNA';
			life  	 = 18; -- lifebar
			vis   	 = 3; -- visibility gain.
			desrt    = 'AV8BNA_destr'; -- Name of destroyed object file name
			fire  	 = { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username = 'AV8BNA';
			index    =  WSTYPE_PLACEHOLDER;
			classname = "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			name  = "AV8BNA_destr";
			file  = "AV8BNA_destr";
			fire  = { 240, 2};
		},

	},
	
	CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_AVERAGE, LOOK_AVERAGE, LOOK_AVERAGE),
	
	-------------------------
	-- Model draw args for network transmitting to this draw_args table (32 limit)
	net_animation = 
	{
		290, -- NOZZLE FWD LEFT
		291, -- NOZZLE FWD RIGHT
		292, -- NOZZLE AFT LEFT
		293, -- NOZZLE AFT RIGHT
		-- 4
		104, -- AFT GEAR ROTATION
		342, -- AFT GEAR ANGLE
		343, -- AFT GEAR COMPRESSION
		-- 7
		274, -- STBD_INTAKE_DOOR_1
		275, -- STBD_INTAKE_DOOR_2
		276, -- STBD_INTAKE_DOOR_3
		277, -- STBD_INTAKE_DOOR_4
		278, -- STBD_INTAKE_DOOR_5
		279, -- STBD_INTAKE_DOOR_6
		280, -- STBD_INTAKE_DOOR_7
		281, -- PORT_INTAKE_DOOR_1
		282, -- PORT_INTAKE_DOOR_2
		283, -- PORT_INTAKE_DOOR_3
		284, -- PORT_INTAKE_DOOR_4
		285, -- PORT_INTAKE_DOOR_5
		286, -- PORT_INTAKE_DOOR_6
		287, -- PORT_INTAKE_DOOR_7
		-- 21
		906, -- PILOT HELMET
		907, -- PILOT THROTTLE
		910, -- NOZZLE GLOW INTERIOR
		911, -- NOZZLE GLOW EXTERIOR
		999, -- WIND VANE
		-- 26
		802, -- STROBE_LIGHT_BOTTOM
		903, -- AIR REFUELING LIGHT
		905, -- AUX LANDING LIGHT
		-- 29
		934, -- FORMATION DIMMER
		935, -- NAVIGATION DIMMER
		936, -- STROBE DIMMER
		-- 32
		83,  -- STROBE_LIGHT_TOP
		190, -- LEFT_NAV_LIGHT
		191, -- TAIL_NAV_LIGHT
		192, -- RIGHT_NAV_LIGHT
		200, -- FORM_LIGHT_FRONT
		201, -- FORM_LIGHT_AFT
		208, -- LANDING_LIGHT
		209, -- TAXI_LIGHT
		-- 41
		22,  -- REFUEL BOOM
		182, -- AIR BRAKE
		325, -- ENGINE FAN
		3080,-- FUEL DUMP LEFT
		3090,-- FUEL DUMP RIGHT
	},
	
	-------------------------
	mapclasskey = "P0091000025",
	attribute = {
		wsType_Air, 
		wsType_Airplane, 
		wsType_Fighter,
		AV_8B,
		"Bombers",
		"Refuelable",
		"Datalink"
	},
	
	Categories = {"{C168A850-3C0B-436a-95B5-C4A015552560}", "Plane",},
	
	--------- General Characteristics ---------
	length						=	14.12,	-- AV-8B Corrected
	height						=	 3.55,	-- AV-8B Corrected
	wing_area					=	21.37,	-- AV-8B Corrected
	wing_span					=	 9.24,	-- AV-8B Corrected
	wing_tip_pos				= 	{-2.537, -0.265, 4.5},
	RCS							=	5,
	air_refuel_receptacle_pos	= 	{3.916, 0.942, -1.702},	--{3.528, 0.832, -1.584}, 
	has_speedbrake				=	true,
	brakeshute_name				=	0,
	tanker_type					=	2,		-- PROBE_AND_DROGUE
	stores_number				=	8,		-- AV-8B: Wing Outer x 2, Wing Middle x 2, Wing Inner x 2, Fusselage Center x 2

	crew_members = 
	{
		[1] = 
		{
			ejection_seat_name		= "AV8BNA_Pilot_seat",
			pilot_name		   		= "AV8BNA_Pilot",
			drop_canopy_name		= "AV8BNA_Canopy",
			drop_parachute_name		= "AV8BNA_Parachute",
			pos 					= {3.43, 0.703, 0.0},
			g_suit					= 2.0,
            bailout_arg 			= -1,
		}, 
	},
	
    mechanimations = {
		Door0 = {
			{Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 38, "to", 0.9, "in", 1.5},},},}, Flags = {"Reversible"},},
			{Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "to", 0.0, "in", 1.5},},},}, Flags = {"Reversible", "StepsBackwards"},},
			{Transition = {"Open", "Taxi"},   Sequence = {{C = {{"Sleep", "for", 0.0},},},},},
			{Transition = {"Taxi", "Open"},   Sequence = {{C = {{"Sleep", "for", 0.0},},},},},
			{Transition = {"Open", "Bailout"},Sequence = {{C = {{"TearCanopy", 0}, {"Arg", 909, "set", 1.0},},},},},
			{Transition = {"Taxi", "Bailout"},Sequence = {{C = {{"TearCanopy", 0}, {"Arg", 909, "set", 1.0},},},},},
			{Transition = {"Any", "Bailout"}, Sequence = {{C = {{"Origin", "x", 3.458, "y", 0.703, "z", 0.0}, {"Impulse", 1, "tertiary", 1.0}, {"Impulse", 2, "tertiary", 10.5}, {"Sleep", "for", 0.005},},}, {C = {{"Arg", 909, "set", 1.0},},},},},
		},
	},
	
	----- Weight & Fuel Characteristics  ------
	M_empty		=	7015.2598,	-- with pilot and nose load, kg (15466lb see tester spreadsheet, Water added as option below)
	M_nominal	=	10534.6828,	-- kg (Empty Plus Full Internal Fuel)
	M_max		=	14100.0,	-- kg (Maximum Take Off Weight - Rolling) Max Take Off Weight Vertical = 9415.0
	M_fuel_max	=	3519.423,	-- kg (Maximum Internal Fuel Only)
	H_max		=	13716,		-- m  (Maximum Operational Ceiling)
	CAS_min		=	60,			-- Minimum CAS speed (m/s) (for AI)
	average_fuel_consumption	=	0.125,
	
	---------- AI Flight Parameters -----------
	V_opt			=  225.0,
	V_take_off		=   58.0,
	V_land			=   61.0,
	V_max_sea_level	=  300.0,
	V_max_h			=  275.0,
	Vy_max	        =  150.0,
	Mach_max	    =    0.90, -- AV-8B Corrected
	Ny_min			=   -2.0,
	Ny_max			=    7.0,
	Ny_max_e	    =    7.0,
	AOA_take_off	=    0.14,
	bank_angle_max	=   60,
	flaps_maneuver	=    1,
	range	        = 2200,
	
	-------- Suspension Characteristics -------
	tand_gear_max 							 = 1.0,	-- tangent on maximum yaw angle of front wheel, 45 degrees tan(45deg)
	
											-- ALEX'S FIX			-- CJ'S VALUES
	nose_gear_pos 							 = {2.02,-2.05, 0.0},	-- {4.613,-2.25, 0.0},	--{2.9,-1.5, 0.0},		-- nosegear coord
	nose_gear_wheel_diameter				 =  0.66,				--  0.35 * 2.0,			-- in m
	nose_gear_amortizer_direct_stroke        =  0.2032,					--  0.220,  	    	-- down from nose_gear_pos !!!
	nose_gear_amortizer_reversal_stroke      = -0.1397,		-- -0.015,				-- up
	nose_gear_amortizer_normal_weight_stroke =  0.0,				--  0.1,				-- down from nose_gear_pos
	--nose_gear_hiking						 =  0.325,
	
	main_gear_pos 							 = {-1.97,-1.725, 2.45},	-- {-0.187,-2.00, 1.75},	-- {-1.9,-1.55, 1.75},	-- main gear coords
	main_gear_wheel_diameter				 =  0.3429,			--  0.45 * 2.0,				-- in m
	main_gear_amortizer_direct_stroke        =  0.135382,					--  0.21,					-- down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke      = -0.169418,		-- -0.01, 					-- up
	main_gear_amortizer_normal_weight_stroke =  0.0,				-- down from main_gear_pos
	
	-- Rear gear
	tandem_gear_pos 							 = {-1.52,-1.725, 0},	-- rear gear coords
	tandem_gear_wheel_diameter				 	 =  0.66,				-- in m
	tandem_gear_amortizer_direct_stroke        	 =  0.298704,					-- down from tandem_gear_pos !!!
	tandem_gear_amortizer_reversal_stroke        = -0.018796, 		-- up
	tandem_gear_amortizer_normal_weight_stroke   =  0.0,				-- down from tandem_gear_pos

	---------- Engine Characteristics ---------
	has_afteburner			=	false,
	thrust_sum_max			=	10660.0, --AV-8B Corrected
	thrust_sum_ab			=	10660.0, --AV-8B Corrected
	engines_count			=	1,
	IR_emission_coeff		=	0.7,	-- <--- I doubt the IR detection coefficient for this engine is 1. I changed it to 0.7 (Reference is Su-27 without afterburner : IR_emission_coeff = 1)
	IR_emission_coeff_ab	=	0,
	
	engines_nozzles = 
	{
		[1] = 
		{
			engine_number		= 1,
			pos 				= {-2.891, 0.039, -1.427},
			elevation			= 0,
			diameter			= 1.085,
			exhaust_length_ab	= 8.629,
			exhaust_length_ab_K	= 0.76,
			smokiness_level		= 0.2,
		}, -- end of [1]
		[2] = 
		{
			engine_number		= 1,
			pos 				= {-2.891, 0.039, 1.427},
			elevation			= 0,
			diameter			= 1.085,
			exhaust_length_ab	= 8.629,
			exhaust_length_ab_K	= 0.76,
			smokiness_level		= 0.2,
		}, -- end of [2]
	}, -- end of engines_nozzles
	
	--------- Sensors Characteristics ---------
	detection_range_max		=	100,
	radar_can_see_ground	=	false,
	Sensors = {
		OPTIC = "Harrier GR_5 FLIR",
		RWR = "Abstract RWR"
	},
	
	---------- Radio Characteristics ----------
	TACAN = true,
	HumanRadio = {
		frequency = 243.0,
		editable = true,
		minFrequency = 30.000,
		maxFrequency = 399.975,
        rangeFrequency = {
			{min = 30.0,  max = 87.975},
			{min = 108.0, max = 115.975},
			{min = 118.0, max = 173.975},
			{min = 225.0, max = 399.975},
		},
		modulation = MODULATION_AM,
	},
	
	panelRadio = {
		[1] = {
			name = _("V/UHF Radio 1"),
			range = {
				{min = 30.0, max = 400.0}
			},
            channels = {
                [1] = { name = _("Channel 1"),		default = 177.0, modulation = _("AM"), connect = true}, -- Mozdok ATC
                [2] = { name = _("Channel 2"),		default = 264.0, modulation = _("AM")},	-- min. water : 135.0, 264.0
                [3] = { name = _("Channel 3"),		default = 265.0, modulation = _("AM")},	-- nalchik : 136.0, 265.0
                [4] = { name = _("Channel 4"),		default = 256.0, modulation = _("AM")},	-- sochi : 127.0, 256.0
                [5] = { name = _("Channel 5"),		default = 254.0, modulation = _("AM")},	-- maykop : 125.0, 254.0
                [6] = { name = _("Channel 6"),		default = 250.0, modulation = _("AM")},	-- anapa : 121.0, 250.0
                [7] = { name = _("Channel 7"),		default = 270.0, modulation = _("AM")},	-- beslan : 141.0, 270.0
                [8] = { name = _("Channel 8"),		default = 257.0, modulation = _("AM")},	-- krasnodar-pashk. : 128.0, 257.0
                [9] = { name = _("Channel 9"),		default = 255.0, modulation = _("AM")},	-- gelenjik : 126.0, 255.0
                [10] = { name = _("Channel 10"),	default = 262.0, modulation = _("AM")},	-- kabuleti : 133.0, 262.0
                [11] = { name = _("Channel 11"),	default = 259.0, modulation = _("AM")},	-- gudauta : 130.0, 259.0
                [12] = { name = _("Channel 12"),	default = 268.0, modulation = _("AM")},	-- soginlug : 139.0, 268.0
                [13] = { name = _("Channel 13"),	default = 269.0, modulation = _("AM")},	-- vaziani : 140.0, 269.0
                [14] = { name = _("Channel 14"),	default = 260.0, modulation = _("AM")},	-- batumi : 131.0, 260.0
                [15] = { name = _("Channel 15"),	default = 263.0, modulation = _("AM")},	-- kutaisi : 134.0, 263.0
                [16] = { name = _("Channel 16"),	default = 261.0, modulation = _("AM")},	-- senaki : 132.0, 261.0
                [17] = { name = _("Channel 17"),	default = 267.0, modulation = _("AM")},	-- lochini : 138.0, 267.0
                [18] = { name = _("Channel 18"),	default = 251.0, modulation = _("AM")},	-- krasnodar-center : 122.0, 251.0
                [19] = { name = _("Channel 19"),	default = 253.0, modulation = _("AM")},	-- krymsk : 124.0, 253.0
                [20] = { name = _("Channel 20"),	default = 266.0, modulation = _("AM")}, -- mozdok : 137.0, 266.0
				[21] = { name = _("Channel 21"),	default = 133.0, modulation = _("AM")}, -- mozdok : 137.0, 266.0
				[22] = { name = _("Channel 22"),	default = 257.8, modulation = _("AM")}, -- mozdok : 137.0, 266.0
				[23] = { name = _("Channel 23"),	default = 122.1, modulation = _("AM")}, -- mozdok : 137.0, 266.0
				[24] = { name = _("Channel 24"),	default = 123.3, modulation = _("AM")}, -- mozdok : 137.0, 266.0
				[25] = { name = _("Channel 25"),	default = 344.0, modulation = _("AM")}, -- mozdok : 137.0, 266.0
				[26] = { name = _("Channel 26"),	default = 385.0, modulation = _("AM")}, -- mozdok : 137.0, 266.0
            }
		},
		[2] = {
			name = _("V/UHF Radio 2"),
			range = {
				{min = 30.0, max = 400.0}
			},
            channels = {
                [1] = { name = _("Channel 1"),		default = 133.0, modulation = _("AM")}, -- Kobuleti ATC
                [2] = { name = _("Channel 2"),		default = 257.8, modulation = _("AM")},	-- Kobuleti ATC
                [3] = { name = _("Channel 3"),		default = 122.1, modulation = _("AM")},	-- Kobuleti ATC
                [4] = { name = _("Channel 4"),		default = 123.3, modulation = _("AM")},	-- Ground Control Approach
                [5] = { name = _("Channel 5"),		default = 344.0, modulation = _("AM")},	-- Ground Control Approach / Search
                [6] = { name = _("Channel 6"),		default = 385.0, modulation = _("AM")},	-- Ground Control Approach / Final
                [7] = { name = _("Channel 7"),		default = 130.0, modulation = _("AM")},	-- Gudauta ATC
                [8] = { name = _("Channel 8"),		default = 385.4, modulation = _("AM")},	-- Ground Control Approach
                [9] = { name = _("Channel 9"),		default = 139.0, modulation = _("AM")},	-- Tblisi - Soganiug ATC
                [10] = { name = _("Channel 10"),	default = 140.0, modulation = _("AM")},	-- Vazinai ATC
                [11] = { name = _("Channel 11"),	default = 134.0, modulation = _("AM")},	-- Kutaisi - Kopitnari ATC
                [12] = { name = _("Channel 12"),	default = 132.0, modulation = _("AM")},	-- Senaki-Koikhi ATC
                [13] = { name = _("Channel 13"),	default = 131.0, modulation = _("AM")},	-- Batumi ATC
                [14] = { name = _("Channel 14"),	default = 129.0, modulation = _("AM")},	-- Sukhumi - Babushara
                [15] = { name = _("Channel 15"),	default = 138.0, modulation = _("AM")},	-- Tiblisi - Lochini ATC
                [16] = { name = _("Channel 16"),	default = 121.0, modulation = _("AM")},	-- Anapa ATC
                [17] = { name = _("Channel 17"),	default = 126.0, modulation = _("AM")},	-- Gelendzhik ATC
                [18] = { name = _("Channel 18"),	default = 125.0, modulation = _("AM")},	-- Maykop - Khanskaya ATC
                [19] = { name = _("Channel 19"),	default = 128.0, modulation = _("AM")},	-- Krasnodar-Pashkovsky ATC
                [20] = { name = _("Channel 20"),	default = 122.0, modulation = _("AM")}, -- Krasnodar-Center ATC
				[21] = { name = _("Channel 21"),	default = 123.0, modulation = _("AM")}, -- Novorossiysk ATC
				[22] = { name = _("Channel 22"),	default = 124.0, modulation = _("AM")}, -- Krymsk ATC
				[23] = { name = _("Channel 23"),	default = 135.0, modulation = _("AM")}, -- Mineralnye Vody ATC
				[24] = { name = _("Channel 24"),	default = 136.0, modulation = _("AM")}, -- Nalchik ATC
				[25] = { name = _("Channel 25"),	default = 141.0, modulation = _("AM")}, -- Beslan ATC
				[26] = { name = _("Channel 26"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
            }
       },
	   [3] = {
			name = _("V/UHF RCS Presets"),
			range = {
				{min = 30.0, max = 400.0}
			},
            channels = {
                [1] = { name = _("Channel 1"),		default = 177.0, modulation = _("AM")}, -- Mozdok ATC
                [2] = { name = _("Channel 2"),		default = 264.0, modulation = _("AM")},	-- min. water : 135.0, 264.0
                [3] = { name = _("Channel 3"),		default = 265.0, modulation = _("AM")},	-- nalchik : 136.0, 265.0
                [4] = { name = _("Channel 4"),		default = 256.0, modulation = _("AM")},	-- sochi : 127.0, 256.0
                [5] = { name = _("Channel 5"),		default = 254.0, modulation = _("AM")},	-- maykop : 125.0, 254.0
                [6] = { name = _("Channel 6"),		default = 250.0, modulation = _("AM")},	-- anapa : 121.0, 250.0
                [7] = { name = _("Channel 7"),		default = 270.0, modulation = _("AM")},	-- beslan : 141.0, 270.0
                [8] = { name = _("Channel 8"),		default = 257.0, modulation = _("AM")},	-- krasnodar-pashk. : 128.0, 257.0
                [9] = { name = _("Channel 9"),		default = 255.0, modulation = _("AM")},	-- gelenjik : 126.0, 255.0
                [10] = { name = _("Channel 10"),	default = 262.0, modulation = _("AM")},	-- kabuleti : 133.0, 262.0
                [11] = { name = _("Channel 11"),	default = 259.0, modulation = _("AM")},	-- gudauta : 130.0, 259.0
                [12] = { name = _("Channel 12"),	default = 268.0, modulation = _("AM")},	-- soginlug : 139.0, 268.0
                [13] = { name = _("Channel 13"),	default = 269.0, modulation = _("AM")},	-- vaziani : 140.0, 269.0
                [14] = { name = _("Channel 14"),	default = 260.0, modulation = _("AM")},	-- batumi : 131.0, 260.0
                [15] = { name = _("Channel 15"),	default = 263.0, modulation = _("AM")},	-- kutaisi : 134.0, 263.0
                [16] = { name = _("Channel 16"),	default = 261.0, modulation = _("AM")},	-- senaki : 132.0, 261.0
                [17] = { name = _("Channel 17"),	default = 267.0, modulation = _("AM")},	-- lochini : 138.0, 267.0
                [18] = { name = _("Channel 18"),	default = 251.0, modulation = _("AM")},	-- krasnodar-center : 122.0, 251.0
                [19] = { name = _("Channel 19"),	default = 253.0, modulation = _("AM")},	-- krymsk : 124.0, 253.0
                [20] = { name = _("Channel 20"),	default = 266.0, modulation = _("AM")}, -- mozdok : 137.0, 266.0
				[21] = { name = _("Channel 21"),	default = 133.0, modulation = _("AM")}, -- mozdok : 137.0, 266.0
				[22] = { name = _("Channel 22"),	default = 257.8, modulation = _("AM")}, -- mozdok : 137.0, 266.0
				[23] = { name = _("Channel 23"),	default = 122.1, modulation = _("AM")}, -- mozdok : 137.0, 266.0
				[24] = { name = _("Channel 24"),	default = 123.3, modulation = _("AM")}, -- mozdok : 137.0, 266.0
				[25] = { name = _("Channel 25"),	default = 344.0, modulation = _("AM")}, -- mozdok : 137.0, 266.0
				[26] = { name = _("Channel 26"),	default = 385.0, modulation = _("AM")}, -- mozdok : 137.0, 266.0
				[27] = { name = _("Channel 27"),	default = 133.0, modulation = _("AM")}, -- Kobuleti ATC
                [28] = { name = _("Channel 28"),	default = 257.8, modulation = _("AM")},	-- Kobuleti ATC
                [29] = { name = _("Channel 29"),	default = 122.1, modulation = _("AM")},	-- Kobuleti ATC
                [30] = { name = _("Channel 30"),	default = 123.3, modulation = _("AM")},	-- Ground Control Approach
            }
		},
	},
	
	InheriteCommonCallnames = true,
	
	----------- ECM Characteristics -----------
	Countermeasures = {
		 ECM = {"AN/ALQ-126", "AN/ALQ-162"}
	},
	
	passivCounterm = {
		CMDS_Edit = false,	-- DO NOT CHANGE THIS VALUE. Chaff & Flares load is defined in Additional Properties
		SingleChargeTotal = 180,
		chaff = {default =  60, increment = 30, chargeSz = 1},
		flare = {default = 120, increment = 30, chargeSz = 1}
	},

	chaff_flare_dispenser 	= {
		{ dir =  {0,  1, -0.75}, pos =  {-3.304,  0.469, -0.375}, }, -- Top Front Left
		{ dir =  {0,  1,  0.75}, pos =  {-3.304,  0.469,  0.375}, }, -- Top Front Right
		{ dir =  {0,  1, -0.75}, pos =  {-3.644,  0.469, -0.375}, }, -- Top Back Left
		{ dir =  {0,  1,  0.75}, pos =  {-3.644,  0.469,  0.375}, }, -- Top Back Right
		{ dir =  {0, -1, -0.15}, pos =  {-3.759, -0.743, -0.130}, }, -- Bottom Left
		{ dir =  {0, -1,  0.15}, pos =  {-3.759, -0.743,  0.130}, }, -- Bottom Right
	},
		
	--------- Armament Characteristics ---------
	
	-- Loadouts changed to reflect the 2015-ish USMC pubs on authorised loadouts on the 09/01/2023
	-- Research and initial coding done by A.J., courtesy of Zeus for rearranging the .lua
	-- for better clarity and code elegance, as well as easier changes on the restrictions.
	
	Pylons = {
		--          Front/Rear, Up/Down, Left/Right
		--            +   -      +  -      -    +
		pylon(1, 0, -0.990, -0.881, -3.975, { arg = 308, arg_value = 0, connector = "str_pnt_001", use_full_connector_position = true, DisplayName = "1", },
            {
				--- Air-to-Air ---
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}",	attach_point_position = aim_9_attachment_point, forbidden = Pylon_1_AIM9_Restrictions },	-- AIM-9M
				{ CLSID = "{AIM-9L}",								attach_point_position = aim_9_attachment_point, forbidden = Pylon_1_AIM9_Restrictions },	-- AIM-9L
				
				-- Anti-radiation --
				{ CLSID	= "{AGM_122_SIDEARM}",						attach_point_position = aim_9_attachment_point, forbidden = Pylon_1_AIM9_Restrictions },	-- AGM-122 Sidearm
				
				-- Air-to-Ground --
				-- Bombs --
				{ CLSID	= "{90321C8E-7ED1-47D4-A160-E074D5ABD902}", arg_value = 0.20,	attach_point_position = { -0.020, -0.115, 0.0}, forbidden = Pylon_1_FuelTank_Restriction },	-- MK-81
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", arg_value = 0.20,	attach_point_position = { -0.110, -0.140, 0.0}, forbidden = Pylon_1_FuelTank_Restriction },	-- MK-82 LD
				{ CLSID = "{Mk82SNAKEYE}",							arg_value = 0.20,	attach_point_position = { -0.110, -0.140, 0.0}, forbidden = Pylon_1_FuelTank_Restriction }, -- MK-82 Snakeye
				{ CLSID	= "{Mk82AIR}",								arg_value = 0.20,	attach_point_position = { -0.110, -0.140, 0.0}, forbidden = Pylon_1_FuelTank_Restriction }, -- MK-82 AIR
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}", arg_value = 0.20,	attach_point_position = { -0.100, -0.17,  0.0}, forbidden = Pylon_1_FuelTank_Restriction },	-- MK-20 Rockeye
				{ CLSID = "{CBU_99}",								arg_value = 0.20,	attach_point_position = { -0.100, -0.17,  0.0}, forbidden = Pylon_1_FuelTank_Restriction },	-- CBU-99
				{ CLSID	= "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", arg_value = 0.20,	attach_point_position = {  0.307, -0.15,  0.0}, forbidden = Pylon_1_GBU12_Restrictions },	-- GBU-12
				-- Missing MK-77 Incendiary
				
				-- Practice --
				{ CLSID = "{AIS_ASQ_T50}",						attach_point_position = { 0.60, 0.0, 0.0}, forbidden = Pylon_1_AIM9_Restrictions },		-- ACMI Pod
				{ CLSID = "CATM-9M",							attach_point_position = { 0.50, 0.0, 0.0}, forbidden = Pylon_1_AIM9_Restrictions },		-- CATM-9M Training Sidewinder
				{ CLSID	= "{BDU-33}",		arg_value = 0.20,	attach_point_position = { 0.18, 0.0, 0.0}, forbidden = Pylon_1_FuelTank_Restriction },	-- BDU-33
				
				-- Smoke Generators --
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}", arg_value = 0.20, forbidden = Pylon_1_Smokewinder_Restriction },	-- Smokewinder red
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}", arg_value = 0.20, forbidden = Pylon_1_Smokewinder_Restriction },	-- Smokewinder green
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}", arg_value = 0.20, forbidden = Pylon_1_Smokewinder_Restriction },	-- Smokewinder blue
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}", arg_value = 0.20, forbidden = Pylon_1_Smokewinder_Restriction },	-- Smokewinder white
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}", arg_value = 0.20, forbidden = Pylon_1_Smokewinder_Restriction },	-- Smokewinder yellow
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}", arg_value = 0.20, forbidden = Pylon_1_Smokewinder_Restriction },	-- Smokewinder orange
            }
        ),
        pylon(2, 0, -0.534, -0.663, -3.179, { arg = 309, arg_value = 0, connector = "str_pnt_002", use_full_connector_position = true, DisplayName = "2", },
            {
				--- Air-to-Air ---
				{ CLSID = "{AIM-9M-ON-ADAPTER}", arg_value = 0.15, forbidden = Pods_Restrictions },	-- AIM-9M
				{ CLSID = "{AIM-9L-ON-ADAPTER}", arg_value = 0.15, forbidden = Pods_Restrictions },	-- AIM-9M
				
				-- Anti-radiation --
				{ CLSID = "{LAU_7_AGM_122_SIDEARM}", forbidden = Pods_Restrictions },					-- AGM-122 With Launcher
				
				-- Air-to-Ground --
				-- Bombs (Single Units)--
				{ CLSID	= "{90321C8E-7ED1-47D4-A160-E074D5ABD902}",	attach_point_position = { -0.020, -0.105, 0.0} },	-- MK-81
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",	attach_point_position = { -0.110, -0.140, 0.0} },	-- MK-82 LD
				{ CLSID = "{Mk82SNAKEYE}",							attach_point_position = { -0.110, -0.140, 0.0} },	-- MK-82 Snakeye
				{ CLSID	= "{Mk82AIR}",								attach_point_position = { -0.110, -0.140, 0.0} },	-- MK-82 AIR
				{ CLSID	= "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}",	attach_point_position = { -0.100, -0.19,  0.0} },	-- MK-83 LD
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}",	attach_point_position = { -0.100, -0.17,  0.0} },	-- MK-20 Rockeye
				{ CLSID = "{CBU_99}",								attach_point_position = { -0.100, -0.17,  0.0} },	-- CBU-99
				{ CLSID	= "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}",	attach_point_position = {  0.301, -0.14,  0.0} },	-- GBU-12
				{ CLSID	= "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}",	attach_point_position = {  0.310, -0.17,  0.0} },	-- GBU-16
				{ CLSID = "{GBU-38}",								attach_point_position = { -0.110, -0.140, 0.0} }, 	-- GBU-38 JDAM
				{ CLSID = "{GBU_32_V_2B}",							attach_point_position = { -0.110, -0.140, 0.0} }, 	-- GBU-32 JDAM
				{ CLSID = "{GBU_54_V_1B}",							attach_point_position = { -0.110, -0.140, 0.0} }, 	-- GBU-54 JDAM
				
				-- Missing MK-77 Incendiary6
				
				-- Bombs x 2 (Multiple Units)--
				{ CLSID	= "{BRU-42_2*Mk-82_LEFT}",			forbidden = Pylon_2_ITERx2_Restrictions },	-- MK-82 x 2
				{ CLSID	= "{BRU-42_2*Mk-83_LEFT}", 			forbidden = Pylon_2_ITERx2_Restrictions }, 	-- MK-83 x 2
				{ CLSID	= "{BRU-42_2*MK-20_LEFT}",			forbidden = Pylon_2_ITERx2_Restrictions },	-- MK-20 x 2
				{ CLSID	= "{BRU-70_2*CBU-99_LEFT}",			forbidden = Pylon_2_ITERx2_Restrictions },	-- CBU-99 x 2
				{ CLSID	= "{BRU-42A_2*GBU-12_SIDE_LEFT}",	forbidden = Pylon_2_ITERx2_Restrictions },	-- GBU-12 x 2
				{ CLSID = "{BRU-42_2*Mk-82AIR_LEFT}",		forbidden = Pylon_2_ITERx2_Restrictions },	-- MK-82 AIR x 2
				{ CLSID = "{BRU-42_2*Mk-82SNAKEYE_LEFT}",	forbidden = Pylon_2_ITERx2_Restrictions },	-- MK-82 Snakeye x 2
				{ CLSID = "{BRU-70A_2*GBU-38_SIDE_LEFT}",	forbidden = Pylon_2_ITERx2_Restrictions },	-- GBU-38 x 2
				{ CLSID = "{BRU-70A_2*GBU-54_SIDE_LEFT}",	forbidden = Pylon_2_ITERx2_Restrictions },	-- GBU-54 x 2
				
				{ CLSID	= "{BRU-42_2*Mk-82_RIGHT}" },			-- MK-82 x 2
				{ CLSID	= "{BRU-42_2*MK-20_RIGHT}" },			-- MK-20 x 2
				{ CLSID	= "{BRU-70_2*CBU-99_RIGHT}" },			-- CBU-99 x 2
				{ CLSID = "{BRU-42_2*Mk-82AIR_RIGHT}" },		-- MK-82 AIR x 2
				{ CLSID = "{BRU-42_2*Mk-82SNAKEYE_RIGHT}" },	-- MK-82 Snakeye x 2
				{ CLSID = "{BRU-42_2*GBU-38_RIGHT}" },			-- GBU-38 x 2
				{ CLSID = "{BRU-70A_2*GBU-54_RIGHT}"},			-- GBU-54 x 2
				
				
				{ CLSID = "{BRU-42_2*GBU-38_LEFT}",			forbidden = Pylon_2_ITERx2_Restrictions },			-- GBU-38 x 2
				{ CLSID = "{BRU-70A_2*GBU-54_LEFT}",		forbidden = Pylon_2_ITERx2_Restrictions },			-- GBU-54 x 2
				
				-- Bombs x 3 (Multiple Units)--
				{ CLSID	= "{BRU-42_3*Mk-81LD}",			forbidden = Pylon_2_ITERx3_Restrictions },
				{ CLSID = "{BRU-42_3*Mk-82LD}",		 	forbidden = Pylon_2_ITERx3_Restrictions },
				{ CLSID = "{BRU-42_3_MK82AIR}",		 	forbidden = Pylon_2_ITERx3_Restrictions },
				{ CLSID = "{BRU-42_3*Mk-82SNAKEYE}", 	forbidden = Pylon_2_ITERx3_Restrictions },
				{ CLSID = "{BRU-70A_3*GBU-38}",			forbidden = Pylon_2_ITERx3_Restrictions },
				{ CLSID = "{BRU-70A_3*GBU-54}",			forbidden = Pylon_2_ITERx3_Restrictions },
				
				-- Practice --
				{ CLSID	= "{BDU-33}",  			attach_point_position = { 0.180, 0.00, 0.0} },											-- BDU-33
				{ CLSID	= "BRU-42_3*BDU-33",												forbidden = Pylon_2_ITERx3_Restrictions },	-- BDU-33 x 3
				
				-- AGMs --
				{ CLSID =	"{F16A4DE0-116C-4A71-97F0-2CF85B0313EC}"},	-- AGM-65E
				{ CLSID =	"LAU_117_AGM_65L" },						-- AGM-65E2/L
				{ CLSID =	"LAU_117_AGM_65F" },						-- AGM-65EF
				
				
				-- Rockets
				{ CLSID	= "{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}" }, 												-- LAU-10 (FFR x 4)
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}", attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU-68 - 7 2.75' rockets MK5 (HE)
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}", attach_point_position = { -0.085, -0.1500, 0.0} },  -- LAU-68 - 7 2.75' rockets M151 (HE)
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}", attach_point_position = { -0.085, -0.1500, 0.0} },  -- LAU-68 - 7 2.75' rockets M156(WP)

				{ CLSID	= "{1F7136CB-8120-4e77-B97B-945FF01FB67C}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 WTU1B (Practice))
				{ CLSID	= "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 Parachute illumination)
				{ CLSID	= "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 Practice smoke)
				{ CLSID = "{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 M278 IR Illumination))
				
				{ CLSID = "{LAU-131 - 7 AGR-20A}" }, 		-- LAU-68 F/A with M151 APKWS
				{ CLSID = "{LAU-131 - 7 AGR-20 M282}" },	-- LAU-68 F/A with M282 APKWS
				
				{ CLSID = "{LAU3_FFAR_WP156}"},		-- LAU-3 FFAR WP156
				{ CLSID = "{LAU3_FFAR_MK1HE}"},		-- LAU-3 FFAR Mk1 HE
				{ CLSID = "{LAU3_FFAR_MK5HEAT}"},	-- LAU-3 FFAR Mk5 HEAT
				
				{ CLSID = "LAU3_WP156"								},	-- LAU-3 - 19 MK156 WP
				{ CLSID = "LAU3_WP1B"								},	-- LAU-3 - 19 WTU-1/B WP
				{ CLSID = "LAU3_WP61"								},	-- LAU-3 - 19 MK61 WP
				{ CLSID = "LAU3_HE5"								},	-- LAU-3 - 19 MK5 HEAT
				{ CLSID = "LAU3_HE151"								},	-- LAU-3 - 19 MK151 HE
				
				-- Dispensers
				{ CLSID	=	"{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}" },	-- SUU-25 x 1 * 8 LUU-2 -- Illumination rounds
				{ CLSID	=	"{BRU-42_LS_3*SUU-25_8*LUU-2}", },			-- SUU-25 x 3 * 8 LUU-2	-- Illumination rounds
				
				{ CLSID = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}",  
					forbidden = Pylon_2_LITENING_Restrictions, 
					attach_point_position = tpod_attachment_point 
				}, -- AN/AAQ-28 LITENING
				
				-- Smoke Generators --
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}", arg_value = 0.20, forbidden = Pylon_2_Smokewinder_Restriction },	-- Smokewinder red
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}", arg_value = 0.20, forbidden = Pylon_2_Smokewinder_Restriction },	-- Smokewinder green
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}", arg_value = 0.20, forbidden = Pylon_2_Smokewinder_Restriction },	-- Smokewinder blue
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}", arg_value = 0.20, forbidden = Pylon_2_Smokewinder_Restriction },	-- Smokewinder white
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}", arg_value = 0.20, forbidden = Pylon_2_Smokewinder_Restriction },	-- Smokewinder yellow
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}", arg_value = 0.20, forbidden = Pylon_2_Smokewinder_Restriction },	-- Smokewinder orange
				
				-- FUEL TANKS --
				{ CLSID = "{AV8BNA_AERO1D}", 		forbidden = Pylon_2_FuelTank_Restrictions },
				{ CLSID = "{AV8BNA_AERO1D_EMPTY}",	forbidden = Pylon_2_FuelTank_Restrictions },
            }
        ),
        pylon(3, 0, 0.095, -0.685, -1.858,  { arg = 310, arg_value = 0, connector = "str_pnt_004", use_full_connector_position = true, DisplayName = "3", },
            {
				-- Air-to-Ground --
				-- Bombs (Single Units)--
				{ CLSID	= "{90321C8E-7ED1-47D4-A160-E074D5ABD902}",	attach_point_position = { -0.020, -0.105, 0.0} },	-- MK-81
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", attach_point_position = { -0.110, -0.140, 0.0} },	-- MK-82 LD
				{ CLSID = "{Mk82SNAKEYE}",							attach_point_position = { -0.110, -0.140, 0.0} }, 	-- MK-82 Snakeye
				{ CLSID	= "{Mk82AIR}",								attach_point_position = { -0.110, -0.140, 0.0} }, 	-- MK-82 AIR
				{ CLSID	= "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}", attach_point_position = { -0.100, -0.19,  0.0} },	-- MK-83 LD
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}", attach_point_position = { -0.100, -0.17,  0.0} },	-- MK-20 Rockeye
				{ CLSID = "{CBU_99}",								attach_point_position = { -0.100, -0.17,  0.0} },	-- CBU-99
				{ CLSID	= "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", attach_point_position = {  0.301, -0.14,  0.0} },	-- GBU-12
				{ CLSID	= "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}", attach_point_position = {  0.390, -0.17,  0.0} },	-- GBU-16
				{ CLSID = "{GBU-38}",								attach_point_position = { -0.110, -0.140, 0.0} }, 	-- GBU-38 JDAM
				{ CLSID = "{GBU_32_V_2B}",							attach_point_position = { -0.110, -0.140, 0.0} }, 	-- GBU-32 JDAM
				{ CLSID = "{GBU_54_V_1B}",							attach_point_position = { -0.110, -0.140, 0.0} }, 	-- GBU-54 JDAM
			
				-- Missing MK-77 Incendiary
				
				-- Bombs (Multiple Units)--
				{ CLSID	= "{BRU-42_2*Mk-81LD_LEFT}" },			-- MK-81 x 2
				{ CLSID	= "{BRU-42_2*Mk-82_LEFT}" },		-- MK-82 x 2
				{ CLSID	= "{BRU-42_2*Mk-83_LEFT}" }, 		-- MK-83 x 2
				{ CLSID	= "{BRU-42_2*MK-20_LEFT}" },		-- MK-20 x 2
				{ CLSID	= "{BRU-70_2*CBU-99_LEFT}" },		-- CBU-99 x 2
				{ CLSID = "{BRU-42_2*Mk-82AIR_LEFT}" },		-- MK-82 AIR x 2
				{ CLSID = "{BRU-42_2*Mk-82SNAKEYE_LEFT}" },	-- MK-82 Snakeye x 2
				{ CLSID = "{BRU-42_2*GBU-38_LEFT}" },		-- GBU-38 x 2
				{ CLSID = "{BRU-70A_2*GBU-54_LEFT}" },		-- GBU-54 x 2
				
				-- Practice --
				{CLSID	=	"{BDU-33}",  attach_point_position = { 0.180, 0.00, 0.0} },	-- BDU-33
				{CLSID	=	"BRU-42_3*BDU-33" },										-- BDU-33 x 3
				
				-- AGMs --
				{ CLSID =	"{F16A4DE0-116C-4A71-97F0-2CF85B0313EC}"},	-- AGM-65E
				{ CLSID =	"LAU_117_AGM_65L" },						-- AGM-65E2/L
				{ CLSID =	"LAU_117_AGM_65F" },						-- AGM-65EF
				
				-- Rockets (Single pod)
				{ CLSID	=	"{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}" }, 													-- LAU-10 (FFR x 4)
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}", attach_point_position = { -0.085, -0.1500, 0.0} },  -- LAU-68 - 7 2.75' rockets MK5 (HE)
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}", attach_point_position = { -0.085, -0.1500, 0.0} },  -- LAU-68 - 7 2.75' rockets M151 (HE)
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}", attach_point_position = { -0.085, -0.1500, 0.0} },  -- LAU-68 - 7 2.75' rockets M156(WP)

				{ CLSID	= "{1F7136CB-8120-4e77-B97B-945FF01FB67C}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 WTU1B (Practice))
				{ CLSID	= "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 Parachute illumination)
				{ CLSID	= "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 Practice smoke)
				{ CLSID = "{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 M278 )IR Illumination))
				
				{ CLSID = "{LAU-131 - 7 AGR-20A}" }, 		-- LAU-68 F/A with M151 APKWS
				{ CLSID = "{LAU-131 - 7 AGR-20 M282}" },	-- LAU-68 F/A with M282 APKWS
				
				{ CLSID = "{LAU3_FFAR_WP156}"},		-- LAU-3 FFAR WP156
				{ CLSID = "{LAU3_FFAR_MK1HE}"},		-- LAU-3 FFAR Mk1 HE
				{ CLSID = "{LAU3_FFAR_MK5HEAT}"},	-- LAU-3 FFAR Mk5 HEAT
				
				{ CLSID = "LAU3_WP156"								},	-- LAU-3 - 19 MK156 WP
				{ CLSID = "LAU3_WP1B"								},	-- LAU-3 - 19 WTU-1/B WP
				{ CLSID = "LAU3_WP61"								},	-- LAU-3 - 19 MK61 WP
				{ CLSID = "LAU3_HE5"								},	-- LAU-3 - 19 MK5 HEAT
				{ CLSID = "LAU3_HE151"								},	-- LAU-3 - 19 MK151 HE
				
				-- PODS --
				{ CLSID = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}",  
					forbidden = Pylon_3_LITENING_Restrictions,
					attach_point_position = tpod_attachment_point 
				}, -- AN/AAQ-28 LITENING
				
				-- FUEL TANKS --
				{ CLSID = "{AV8BNA_AERO1D}",		forbidden = Pylon_3_FuelTank_Restrictions },
				{ CLSID = "{AV8BNA_AERO1D_EMPTY}",	forbidden = Pylon_3_FuelTank_Restrictions },
            }
        ),
        pylon(4, 0, 0.742, -1.262,  0.000,  { arg = 313, arg_value = 0, connector = "str_pnt_012", use_full_connector_position = true, DisplayName = "4A", },
            {
				{ CLSID = "{GAU_12_Equalizer}",		arg_value = 0.20, forbidden = Pods_Restrictions },
				{ CLSID = "{GAU_12_Equalizer_AP}",	arg_value = 0.20, forbidden = Pods_Restrictions },
				{ CLSID = "{GAU_12_Equalizer_HE}",	arg_value = 0.20, forbidden = Pods_Restrictions },
            }
        ),
        pylon(5, 0, 0.742, -1.262,  0.000,  { arg = 313, arg_value = 0, connector = "str_pnt_006", use_full_connector_position = true, DisplayName = "4B", },
            {
				{ CLSID = "{ALQ_164_RF_Jammer}", 
					arg_value = 0.10,  
					forbidden = Pods_Restrictions,
					attach_point_position = { 0.0, 0.0, 0.0} 
				}, -- ALQ-164 ECM
				{ CLSID = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}", 
					arg_value = 0.10, 
					forbidden = Pylon_5_LITENING_Restrictions,
					attach_point_position = { -0.20, -0.20, 0.0}
				}, -- AN/AAQ-28 LITENING
            }
        ),
        pylon(6, 0, 0.095, -0.685,   1.858, { arg = 315, arg_value = 0, connector = "str_pnt_008", use_full_connector_position = true, DisplayName = "5", },
            {
				-- Air-to-Ground --
				-- Bombs (Single Units)--
				{ CLSID	= "{90321C8E-7ED1-47D4-A160-E074D5ABD902}",	attach_point_position = { -0.020, -0.105, 0.0} },	-- MK-81
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", attach_point_position = { -0.110, -0.140, 0.0} },	-- MK-82 LD
				{ CLSID = "{Mk82SNAKEYE}",							attach_point_position = { -0.110, -0.140, 0.0} }, 	-- MK-82 Snakeye
				{ CLSID	= "{Mk82AIR}",								attach_point_position = { -0.110, -0.140, 0.0} }, 	-- MK-82 AIR
				{ CLSID	= "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}", attach_point_position = { -0.100, -0.19,  0.0} },	-- MK-83 LD
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}", attach_point_position = { -0.100, -0.17,  0.0} },	-- MK-20 Rockeye
				{ CLSID = "{CBU_99}",								attach_point_position = { -0.100, -0.17,  0.0} },	-- CBU-99
				{ CLSID	= "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", attach_point_position = {  0.301, -0.14,  0.0} },	-- GBU-12
				{ CLSID	= "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}", attach_point_position = {  0.390, -0.17,  0.0} },	-- GBU-16
				{ CLSID = "{GBU-38}",								attach_point_position = { -0.110, -0.140, 0.0} }, 	-- GBU-38 JDAM
				{ CLSID = "{GBU_32_V_2B}",							attach_point_position = { -0.110, -0.140, 0.0} }, 	-- GBU-32 JDAM
				{ CLSID = "{GBU_54_V_1B}",							attach_point_position = { -0.110, -0.140, 0.0} }, 	-- GBU-54 JDAM
				-- Missing MK-77 Incendiary
				
				-- Bombs (Multiple Units)--
				{ CLSID	= "{BRU-42_2*Mk-81LD_RIGHT}" },				-- MK-81 x 3
				{ CLSID	= "{BRU-42_2*Mk-82_RIGHT}" },			-- MK-82 x 2
				{ CLSID	= "{BRU-42_2*MK-20_RIGHT}" },			-- MK-20 x 2
				{ CLSID	= "{BRU-70_2*CBU-99_RIGHT}" },			-- CBU-99 x 2
				{ CLSID = "{BRU-42_2*Mk-82AIR_RIGHT}" },		-- MK-82 AIR x 2
				{ CLSID = "{BRU-42_2*Mk-82SNAKEYE_RIGHT}" },	-- MK-82 Snakeye x 2
				{ CLSID = "{BRU-42_2*GBU-38_RIGHT}" },			-- GBU-38 x 2
				{ CLSID = "{BRU-70A_2*GBU-54_RIGHT}"},			-- GBU-54 x 2
				
				-- Practice --
				{ CLSID	= "{BDU-33}",  attach_point_position = { 0.180, 0.00, 0.0} },	-- BDU-33
				{ CLSID	=	"BRU-42_3*BDU-33" },										-- BDU-33 x 3
				
				-- AGMs --
				{ CLSID =	"{F16A4DE0-116C-4A71-97F0-2CF85B0313EC}"},	-- AGM-65E
				{ CLSID =	"LAU_117_AGM_65L" },						-- AGM-65E2/L
				{ CLSID =	"LAU_117_AGM_65F" },						-- AGM-65EF
				
				-- Rockets (Single pod)
				{ CLSID	=	"{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}" },														-- LAU-10 (FFR x 4)
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}", attach_point_position = { -0.085, -0.1500, 0.0} }, -- LAU-68 - 7 2.75' rockets MK5 (HE)
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}", attach_point_position = { -0.085, -0.1500, 0.0} },  -- LAU-68 - 7 2.75' rockets M151 (HE)
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}", attach_point_position = { -0.085, -0.1500, 0.0} },  -- LAU-68 - 7 2.75' rockets M156(WP)

				{ CLSID	= "{1F7136CB-8120-4e77-B97B-945FF01FB67C}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 WTU1B (Practice))
				{ CLSID	= "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 Parachute illumination)
				{ CLSID	= "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 Practice smoke)
				{ CLSID = "{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 M278 )IR Illumination))
		
				{ CLSID = "{LAU-131 - 7 AGR-20A}" }, 		-- LAU-68 F/A with M151 APKWS
				{ CLSID = "{LAU-131 - 7 AGR-20 M282}" },	-- LAU-68 F/A with M282 APKWS
				
				{ CLSID = "{LAU3_FFAR_WP156}"},		-- LAU-3 FFAR WP156
				{ CLSID = "{LAU3_FFAR_MK1HE}"},		-- LAU-3 FFAR Mk1 HE
				{ CLSID = "{LAU3_FFAR_MK5HEAT}"},	-- LAU-3 FFAR Mk5 HEAT
				
				{ CLSID = "LAU3_WP156"								},	-- LAU-3 - 19 MK156 WP
				{ CLSID = "LAU3_WP1B"								},	-- LAU-3 - 19 WTU-1/B WP
				{ CLSID = "LAU3_WP61"								},	-- LAU-3 - 19 MK61 WP
				{ CLSID = "LAU3_HE5"								},	-- LAU-3 - 19 MK5 HEAT
				{ CLSID = "LAU3_HE151"								},	-- LAU-3 - 19 MK151 HE
				
				-- PODS --
				{ CLSID = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}",  
					forbidden = Pylon_6_LITENING_Restrictions,
					attach_point_position = tpod_attachment_point 
				}, -- AN/AAQ-28 LITENING
				
				-- FUEL TANKS --
				{ CLSID = "{AV8BNA_AERO1D}",		forbidden = Pylon_6_FuelTank_Restrictions },
				{ CLSID = "{AV8BNA_AERO1D_EMPTY}",	forbidden = Pylon_6_FuelTank_Restrictions },
            }
        ),
        pylon(7, 0, -0.534, -0.663,  3.179, { arg = 317, arg_value = 0, connector = "str_pnt_010", use_full_connector_position = true, DisplayName = "6", },
            {
				--- Air-to-Air ---
				{ CLSID = "{AIM-9M-ON-ADAPTER}", arg_value = 0.15, forbidden = Pods_Restrictions },	-- AIM-9M
				{ CLSID = "{AIM-9L-ON-ADAPTER}", arg_value = 0.15, forbidden = Pods_Restrictions },	-- AIM-9M

				-- Anti-radiation --
				{ CLSID = "{LAU_7_AGM_122_SIDEARM}", forbidden = Pods_Restrictions },					-- AGM-122 With Launcher
				
				-- Air-to-Ground --
				-- Bombs (Single Units)--
				{ CLSID	= "{90321C8E-7ED1-47D4-A160-E074D5ABD902}", attach_point_position = { -0.020, -0.105, 0.0} },	-- MK-81
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", attach_point_position = { -0.090, -0.133, 0.0} },	-- MK-82 LD
				{ CLSID = "{Mk82SNAKEYE}",							attach_point_position = { -0.090, -0.133, 0.0} }, 	-- MK-82 Snakeye
				{ CLSID	= "{Mk82AIR}",								attach_point_position = { -0.090, -0.133, 0.0} }, 	-- MK-82 AIR
				{ CLSID	= "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}", attach_point_position = { -0.100, -0.19,  0.0} },	-- MK-83 LD
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}", attach_point_position = { -0.100, -0.17,  0.0} },	-- MK-20 Rockeye
				{ CLSID = "{CBU_99}",								attach_point_position = { -0.100, -0.17,  0.0} },	-- CBU-99
				{ CLSID	= "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", attach_point_position = {  0.301, -0.14,  0.0} },	-- GBU-12
				{ CLSID	= "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}", attach_point_position = {  0.311, -0.16,  0.0} },	-- GBU-16
				{ CLSID = "{GBU-38}",								attach_point_position = { -0.090, -0.133, 0.0} },	-- GBU-38 JDAM
				{ CLSID = "{GBU_32_V_2B}",							attach_point_position = { -0.110, -0.140, 0.0} }, 	-- GBU-32 JDAM
				{ CLSID = "{GBU_54_V_1B}",							attach_point_position = { -0.110, -0.140, 0.0} }, 	-- GBU-54 JDAM
				-- Missing MK-77 Incendiary
				
				-- Bombs x 2 (Multiple Units)--
				{ CLSID	= "{BRU-42_2*Mk-82_RIGHT}",			forbidden = Pylon_7_ITERx2_Restrictions },	-- MK-82 x 2
				{ CLSID	= "{BRU-42_2*Mk-83_RIGHT}",			forbidden = Pylon_7_ITERx2_Restrictions }, 	-- MK-83 x 2
				{ CLSID	= "{BRU-42_2*MK-20_RIGHT}",			forbidden = Pylon_7_ITERx2_Restrictions },	-- MK-20 x 2
				{ CLSID	= "{BRU-70_2*CBU-99_RIGHT}",		forbidden = Pylon_7_ITERx2_Restrictions },	-- CBU-99 x 2
				{ CLSID	= "{BRU-42A_2*GBU-12_SIDE_RIGHT}",	forbidden = Pylon_7_ITERx2_Restrictions },	-- GBU-12 x 2
				{ CLSID = "{BRU-42_2*Mk-82AIR_RIGHT}",		forbidden = Pylon_7_ITERx2_Restrictions },	-- MK-82 AIR x 2
				{ CLSID = "{BRU-42_2*Mk-82SNAKEYE_RIGHT}",	forbidden = Pylon_7_ITERx2_Restrictions },	-- MK-82 Snakeye x 2
				{ CLSID = "{BRU-70A_2*GBU-38_SIDE_RIGHT}",	forbidden = Pylon_7_ITERx2_Restrictions },	-- GBU-38 x 2
				{ CLSID = "{BRU-70A_2*GBU-54_SIDE_RIGHT}",	forbidden = Pylon_7_ITERx2_Restrictions },	-- GBU-54 x 2
				
				{ CLSID	= "{BRU-42_2*Mk-82_LEFT}" },		-- MK-82 x 2
				{ CLSID	= "{BRU-42_2*Mk-83_LEFT}" }, 		-- MK-83 x 2
				{ CLSID	= "{BRU-42_2*MK-20_LEFT}" },		-- MK-20 x 2
				{ CLSID	= "{BRU-70_2*CBU-99_LEFT}" },		-- CBU-99 x 2
				{ CLSID = "{BRU-42_2*Mk-82AIR_LEFT}" },		-- MK-82 AIR x 2
				{ CLSID = "{BRU-42_2*Mk-82SNAKEYE_LEFT}" },	-- MK-82 Snakeye x 2
				{ CLSID = "{BRU-42_2*GBU-38_LEFT}" },		-- GBU-38 x 2
				{ CLSID = "{BRU-70A_2*GBU-54_LEFT}"},		-- GBU-54 x 2
				
				{ CLSID = "{BRU-42_2*GBU-38_RIGHT}",		forbidden = Pylon_7_ITERx2_Restrictions },			-- GBU-38 x 2
				{ CLSID = "{BRU-70A_2*GBU-54_RIGHT}",		forbidden = Pylon_7_ITERx2_Restrictions },			-- GBU-54 x 2
				
				-- Bombs x 3 (Multiple Units)--
				{ CLSID	= "{BRU-42_3*Mk-81LD}",			forbidden = Pylon_7_ITERx3_Restrictions },
				{ CLSID = "{BRU-42_3*Mk-82LD}",			forbidden = Pylon_7_ITERx3_Restrictions },
				{ CLSID = "{BRU-42_3_MK82AIR}",			forbidden = Pylon_7_ITERx3_Restrictions },
				{ CLSID = "{BRU-42_3*Mk-82SNAKEYE}",	forbidden = Pylon_7_ITERx3_Restrictions },
				{ CLSID = "{BRU-70A_3*GBU-38}",			forbidden = Pylon_7_ITERx3_Restrictions },
				{ CLSID = "{BRU-70A_3*GBU-54}",			forbidden = Pylon_7_ITERx3_Restrictions },
				
				-- Practice --
				{ CLSID	= "{BDU-33}",  			attach_point_position = { 0.180, 0.00, 0.0} },											-- BDU-33
				{ CLSID	= "BRU-42_3*BDU-33",												forbidden = Pylon_7_ITERx3_Restrictions },	-- BDU-33 x 3
				
				-- AGMs --
				{ CLSID =	"{F16A4DE0-116C-4A71-97F0-2CF85B0313EC}"},	-- AGM-65E
				{ CLSID =	"LAU_117_AGM_65L" },						-- AGM-65E2/L
				{ CLSID =	"LAU_117_AGM_65F" },						-- AGM-65EF
				
				-- Rockets
				{ CLSID	= "{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}" }, 													-- LAU-10 (FFR x 4)
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}", attach_point_position = { -0.085, -0.1500, 0.0} },  -- LAU-68 - 7 2.75' rockets MK5 (HE)
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}", attach_point_position = { -0.085, -0.1500, 0.0} },  -- LAU-68 - 7 2.75' rockets M151 (HE)
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}", attach_point_position = { -0.085, -0.1500, 0.0} },  -- LAU-68 - 7 2.75' rockets M156(WP)

				{ CLSID	= "{1F7136CB-8120-4e77-B97B-945FF01FB67C}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 WTU1B (Practice))
				{ CLSID	= "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 Parachute illumination)
				{ CLSID	= "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 Practice smoke)
				{ CLSID = "{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}",	attach_point_position = { -0.085, -0.1500, 0.0} },	-- LAU68D (FFR x 7 M278 )IR Illumination))
				
				{ CLSID = "{LAU-131 - 7 AGR-20A}" }, 		-- LAU-68 F/A with M151 APKWS
				{ CLSID = "{LAU-131 - 7 AGR-20 M282}" },	-- LAU-68 F/A with M282 APKWS
				
				{ CLSID = "{LAU3_FFAR_WP156}"},		-- LAU-3 FFAR WP156
				{ CLSID = "{LAU3_FFAR_MK1HE}"},		-- LAU-3 FFAR Mk1 HE
				{ CLSID = "{LAU3_FFAR_MK5HEAT}"},	-- LAU-3 FFAR Mk5 HEAT
				
				{ CLSID = "LAU3_WP156"								},	-- LAU-3 - 19 MK156 WP
				{ CLSID = "LAU3_WP1B"								},	-- LAU-3 - 19 WTU-1/B WP
				{ CLSID = "LAU3_WP61"								},	-- LAU-3 - 19 MK61 WP
				{ CLSID = "LAU3_HE5"								},	-- LAU-3 - 19 MK5 HEAT
				{ CLSID = "LAU3_HE151"								},	-- LAU-3 - 19 MK151 HE
				
				-- Dispensers
				{ CLSID	=	"{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}" },	-- SUU-25 x 1 * 8 LUU-2 -- Illumination rounds
				{ CLSID	=	"{BRU-42_LS_3*SUU-25_8*LUU-2}", },			-- SUU-25 x 3 * 8 LUU-2	-- Illumination rounds
				
				{ CLSID = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}", 
					forbidden = Pylon_7_LITENING_Restrictions, 
					attach_point_position = tpod_attachment_point 
				}, -- AN/AAQ-28 LITENING
				
				-- Smoke Generators --
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}", arg_value = 0.20, forbidden = Pylon_7_Smokewinder_Restriction },	-- Smokewinder red
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}", arg_value = 0.20, forbidden = Pylon_7_Smokewinder_Restriction },	-- Smokewinder green
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}", arg_value = 0.20, forbidden = Pylon_7_Smokewinder_Restriction },	-- Smokewinder blue
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}", arg_value = 0.20, forbidden = Pylon_7_Smokewinder_Restriction },	-- Smokewinder white
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}", arg_value = 0.20, forbidden = Pylon_7_Smokewinder_Restriction },	-- Smokewinder yellow
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}", arg_value = 0.20, forbidden = Pylon_7_Smokewinder_Restriction },	-- Smokewinder orange
				
				-- FUEL TANKS --
				{ CLSID = "{AV8BNA_AERO1D}", 		forbidden = Pylon_7_FuelTank_Restrictions },
				{ CLSID = "{AV8BNA_AERO1D_EMPTY}",	forbidden = Pylon_7_FuelTank_Restrictions },
            }
        ),
		pylon(8, 0, -0.990, -0.881,  3.975, { arg = 319, arg_value = 0, connector = "str_pnt_011", use_full_connector_position = true, DisplayName = "7", },
            {
				--- Air-to-Air ---
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}", attach_point_position = aim_9_attachment_point, forbidden = Pylon_8_AIM9_Restrictions },	-- AIM-9M
				{ CLSID = "{AIM-9L}",								attach_point_position = aim_9_attachment_point, forbidden = Pylon_8_AIM9_Restrictions },	-- AIM-9L
				
				-- Anti-radiation --
				{ CLSID	= "{AGM_122_SIDEARM}",						attach_point_position = aim_9_attachment_point, forbidden = Pylon_8_AIM9_Restrictions },	-- AGM-122 Sidearm
				
				-- Air-to-Ground --
				-- Bombs --
				{ CLSID	= "{90321C8E-7ED1-47D4-A160-E074D5ABD902}",	arg_value = 0.20,	attach_point_position = { -0.020, -0.115, 0.0}, forbidden = Pylon_8_FuelTank_Restriction },	-- MK-81
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",	arg_value = 0.20,	attach_point_position = { -0.090, -0.133, 0.0}, forbidden = Pylon_8_FuelTank_Restriction },	-- MK-82 LD
				{ CLSID = "{Mk82SNAKEYE}",							arg_value = 0.20,	attach_point_position = { -0.090, -0.133, 0.0}, forbidden = Pylon_8_FuelTank_Restriction }, 	-- MK-82 Snakeye
				{ CLSID	= "{Mk82AIR}",								arg_value = 0.20,	attach_point_position = { -0.090, -0.133, 0.0}, forbidden = Pylon_8_FuelTank_Restriction }, 	-- MK-82 AIR
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}", arg_value = 0.20,	attach_point_position = { -0.100, -0.17,  0.0}, forbidden = Pylon_8_FuelTank_Restriction },	-- MK-20 Rockeye
				{ CLSID = "{CBU_99}",								arg_value = 0.20,	attach_point_position = { -0.100, -0.17,  0.0}, forbidden = Pylon_8_FuelTank_Restriction },	-- CBU-99
				{ CLSID	= "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", arg_value = 0.20,	attach_point_position = {  0.307, -0.15,  0.0}, forbidden = Pylon_8_GBU12_Restrictions },	-- GBU-12
				-- Missing MK-77 Incendiary
				
				-- Practice --
				{ CLSID = "{AIS_ASQ_T50}",						attach_point_position = { 0.60, 0.0, 0.0}, forbidden = Pylon_8_AIM9_Restrictions },		-- ACMI Pod
				{ CLSID = "CATM-9M",							attach_point_position = { 0.50, 0.0, 0.0}, forbidden = Pylon_8_AIM9_Restrictions },		-- CATM-9M Training Sidewinder
				{ CLSID	= "{BDU-33}",		arg_value = 0.20,	attach_point_position = { 0.18, 0.0, 0.0}, forbidden = Pylon_8_FuelTank_Restriction  },	-- BDU-33
				
				-- Smoke Generators --
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}", arg_value = 0.20, forbidden = Pylon_8_Smokewinder_Restriction },	-- Smokewinder red
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}", arg_value = 0.20, forbidden = Pylon_8_Smokewinder_Restriction },	-- Smokewinder green
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}", arg_value = 0.20, forbidden = Pylon_8_Smokewinder_Restriction },	-- Smokewinder blue
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}", arg_value = 0.20, forbidden = Pylon_8_Smokewinder_Restriction },	-- Smokewinder white
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}", arg_value = 0.20, forbidden = Pylon_8_Smokewinder_Restriction },	-- Smokewinder yellow
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}", arg_value = 0.20, forbidden = Pylon_8_Smokewinder_Restriction },	-- Smokewinder orange
            }
        ),
	},

	Tasks = {
        aircraft_task(GroundAttack),
		aircraft_task(PinpointStrike),
        aircraft_task(CAS),
        aircraft_task(AFAC),
		aircraft_task(RunwayAttack),
		aircraft_task(AntishipStrike),
		aircraft_task(SEAD),
		aircraft_task(Escort),
		aircraft_task(CAP),
    },

	DefaultTask = aircraft_task(CAS),
	
	------- Flight Model Characteristics -------
	SFM_Data = {
		aerodynamics = 
		{
			Cy0	        =	0.0334, --0.0668, -- zero AoA lift coefficient*
			Mzalfa	    =	5.0,    -- coefficients for pitch agility
			Mzalfadt	=	0.9,    -- coefficients for pitch agility
			kjx	        =	2.3,    -- Inertia parametre X - Dimension (clean) airframe drag coefficient at X (Top) Simply the wing area in square meters (as that is a major factor in drag calculations)
			kjz	        =	0.00125,-- Inertia parametre Z - Dimension (clean) airframe drag coefficient at Z (Front) Simply the wing area in square meters (as that is a major factor in drag calculations)
			Czbe	    =	-0.016, -- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
			cx_gear	    =	0.015,  -- coefficient, drag, gear ??
			cx_flap	    =	0.08,   -- coefficient, drag, full flaps
			cy_flap	    =	0.26,   -- coefficient, normal force, lift, flaps
			cx_brk	    =	0.08,   -- coefficient, drag, breaks
			table_data = 
			{	--      M		Cx0*	 	Cya*		B2		 	B4	 		Omxmax		Aldop*		Cymax*
				[1 ] = { 0,		0.0235	,	0.0669	,	0.0182	,	0.2298	,	0.5	,	    16.2	,	1.154},
				[2 ] = { 0.1,	0.0235	,	0.0669	,	0.0182	,	0.2298	,	1.5	,	    16.2	,	1.154},
				[3 ] = { 0.2,	0.0235	,	0.0669	,	0.0182	,	0.2296	,	2.0	,	    16.2	,	1.154},
				[4 ] = { 0.4,	0.0235	,	0.0669	,	0.0183	,	0.2294	,	2.25,	    16.2	,	1.154},
				[5 ] = { 0.6,	0.0235	,	0.0674	,	0.0194	,	0.2245	,	2.43,	    16.0	,	1.145},
				[6 ] = { 0.6,	0.0235	,	0.0685	,	0.0252	,	0.2245	,	2.43,	    16.0	,	1.145},
				[7 ] = { 0.7,	0.0235	,	0.0722	,	0.0303	,	0.2111	,	2.82,	    11.8	,	0.921},
				[8 ] = { 0.8,	0.0335	,	0.0689	,	0.0510	,	0.3826	,	2.47,	    9.9		,	0.749},
				[9 ] = { 0.9,	0.0435	,	0.0661	,	0.0554	,	0.4359	,	2.25,	    10.1	,	0.731},
				[10] = { 1.0,	0.0535	,	0.0631	,	0.0514	,	0.5218	,	2.10,	    10.2	,	0.707},
				[11] = { 1.1,	0.0635	,	0.0621	,	0.0547	,	0.5431	,	1.75,	    10.3	,	0.701},
				[12] = { 1.2,	0.0735	,	0.0620	,	0.0559	,	0.5453	,	1.50,	    10.3	,	0.701},
				[13] = { 1.3,	0.0835	,	0.0620	,	0.0572	,	0.5447	,	1.25,	    10.3	,	0.701},
				-- Approximately                                                            
				[14] = { 2.0,	0.0835	,	0.0620	,	0.0572	,	0.5447	,	1.00,	    10.3	,	0.701},
				[15] = { 2.5,	0.0835	,	0.0620	,	0.0572	  ,	0.5447	,	1.00,	    10.3	,	0.701},
				[16] = { 3.9,	0.0835	,	0.0620	,	0.0572	,	0.5447	,	1.00,	    10.3	,	0.701},
			}, -- end of table_data
		}, -- end of aerodynamics
		
		engine = 
		{
			Nmg 	=	29, -- RPM at idle
			MinRUD	=	0, -- Min state of the РУД
			MaxRUD	=	1, -- Max state of the РУД
			MaksRUD	=	1, -- Military power state of the РУД
			ForsRUD	=	1, -- Afterburner state of the РУД
			typeng	=	0, -- 0 - engine with high bypass ratio, 1 - jet engine
			hMaxEng	=	19, -- Max altitude for safe engine operation in km
			dcx_eng	=	0.0170, -- Engine drag coeficient
			cemax	=	1.24, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			cefor	=	2.56, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			dpdh_m	=	4500, --  altitude coefficient for max thrust
			dpdh_f	=	9800, --  altitude coefficient for AB thrust
			table_data = 
			{
				[1] = 	{0,	    105000,	105000},
				[2] = 	{0.1,	105000,	105000},
				[3] = 	{0.2,	105000,	105000},
				[4] = 	{0.3,	105000,	105000},
				[5] = 	{0.4,	105000,	105000},
				[6] = 	{0.5,	105000,	105000},
				[7] = 	{0.6,	105000,	105000},
				[8] = 	{0.7,	102000,	102000},
				[9] = 	{0.8,	100000,	100000},
				[10] = 	{0.9,	 90000,	 90000},
				[11] = 	{1,	     80000,	 80000},
			}, -- end of table_data
		}, -- end of engine
	},
	
	------------- Damage Table Reference -------------
	Damage = verbose_to_dmg_properties(
	{
		-- NOSE SECTION
		["BLADE_1_CENTER"]			= {critical_damage = 3},												-- FLIR AVIONICS
		["BLADE_2_CENTER"]			= {critical_damage = 3},												-- DMT AVIONICS
		["NOSE_SENSOR"]				= {critical_damage =  8, args = {144}},									-- DMT SENSSOR HEAD (DYNAMIC INDEX)
		["NOSE_CENTER"]				= {critical_damage =  8, args = {147}, deps_cells = {"NOSE_SENSOR", "BLADE_1_CENTER", "BLADE_2_CENTER"}},	-- NOSE CONE: FLIR + ARBS
		["NOSE_RIGHT_SIDE"]			= {critical_damage =  8, args = {149}},	-- 
		["NOSE_LEFT_SIDE"]			= {critical_damage =  8, args = {150}},	-- 
		["CABIN_RIGHT_SIDE"]		= {critical_damage =  8, args = {153}},	-- 
		["CABIN_LEFT_SIDE"]			= {critical_damage =  8, args = {154}},	-- 
		["COCKPIT"]					= {critical_damage = 12, args = {65}},	--
		["CABIN_BOTTOM"]			= {critical_damage =  8, args = {82}},	-- 
		["CREW_1"]					= {critical_damage =  2},				-- PILOT
		
		-- PYLONS
		["PYLON1"]					= {critical_damage = 3},	-- LEFT WING OUTER PYLON
		["PYLON2"]					= {critical_damage = 3},	-- LEFT WING CENTER PYLON
		["BLADE_6_IN"]				= {critical_damage = 3},	-- LEFT WING INNER PYLON
		["BLADE_6_CENTER"]			= {critical_damage = 3},	-- CENTERLINE PYLON
		["BLADE_6_OUT"]				= {critical_damage = 3},	-- RIGHT WING INNER PYLON
		["PYLON3"]					= {critical_damage = 3},	-- RIGHT WING CENTER PYLON
		["PYLON4"]					= {critical_damage = 3},	-- RIGHT WING OUTER PYLON
		["MTG_L_BOTTOM"]			= {critical_damage = 5},	-- LEFT GUNPOD/STRAKE
		["MTG_R_BOTTOM"]			= {critical_damage = 5},	-- RIGHT GUNPOD/STRAKE
		
		-- RCS CONTROL
		["NOSE_BOTTOM"]				= {critical_damage = 8, args = {148}},	-- RCS Control
		["FUSELAGE_BOTTOM"]			= {critical_damage = 8, args = {155}},	-- AFFECTS RCS SYSTEM (FRONT AND REAR)
		["WING_L_PART_OUT"]			= {critical_damage = 7, args = {220}},	-- WING L LEADING EDGE CENTER (For RCS system damage)
		["WING_L_PART_CENTER"]		= {critical_damage = 8, args = {221}},	-- WING L LEADING EDGE IN (For RCS system damage)
		["WING_R_PART_OUT"]			= {critical_damage = 7, args = {230}},	-- WING R LEADING EDGE CENTER (For RCS system damage)
		["WING_R_PART_CENTER"]		= {critical_damage = 8, args = {231}},	-- WING R LEADING EDGE IN (For RCS system damage)

		-- FUEL TANKS
		["FUEL_TANK_LEFT_SIDE"]		= {critical_damage = 5},	-- LEFT WING FUEL TANK
		["FUEL_TANK_RIGHT_SIDE"]	= {critical_damage = 5},	-- RIGHT WING FUEL TANK
		["ROTOR"]					= {critical_damage = 5},	-- REAR FUEL TANK
		
		-- AVIONICS
		["BLADE_5_IN"]				= {critical_damage = 5},	-- LEFT AVIONICS BAY 1
		["BLADE_5_CENTER"]			= {critical_damage = 5},	-- LEFT AVIONICS BAY 2
		["BLADE_5_OUT"]				= {critical_damage = 5},	-- LEFT AVIONICS BAY 3
		["BLADE_4_IN"]				= {critical_damage = 5},	-- RIGHT AVIONICS BAY 1
		["BLADE_4_CENTER"]			= {critical_damage = 5},	-- RIGHT AVIONICS BAY 2
		["BLADE_3_IN"]				= {critical_damage = 5},	-- RIGHT AVIONICS BAY 3

		-- CONTROL SURFACES
		["AILERON_L"]				= {critical_damage = 3, args = {226}},	--
		["FLAP_L_OUT"]				= {critical_damage = 5, args = {228}},	--
		["FLAP_L_IN"]				= {critical_damage = 4, args = {227}, deps_cells = {"FLAP_L_OUT"}},	--
		["ELEVATOR_L_IN"]			= {critical_damage = 4, args = {237}, droppable = true,  droppable_shape = "AV-8BNA-OBLOMOK-ELEVATOR-L"},	--
		["AILERON_R"]				= {critical_damage = 3, args = {216}},	--
		["FLAP_R_OUT"]				= {critical_damage = 5, args = {218}},	--
		["FLAP_R_IN"]				= {critical_damage = 4, args = {217}, deps_cells = {"FLAP_R_OUT"}},	--
		["ELEVATOR_R_IN"]			= {critical_damage = 4, args = {239}, droppable = true,  droppable_shape = "AV-8BNA-OBLOMOK-ELEVATOR-R"},	--
		["RUDDER"]					= {critical_damage = 3, args = {248}},	--
		["AIR_BRAKE_L"]				= {critical_damage = 4, args = {183}},	--
		
		-- LANDING GEAR
		["WHEEL_F"]					= {critical_damage = 3, args = {134}},	--
		["FRONT_WHEEL"]				= {critical_damage = 3, args = {253}, deps_cells = {"WHEEL_F"}},			-- NOSE GEAR ASSEMBLY
		["FRONT_GEAR_BOX"]			= {critical_damage = 5, args = {265}, deps_cells = {"FRONT_WHEEL"}},		-- NOSE GEAR HOUSING
		["WHEEL_A"]					= {critical_damage = 3, args = {135}},										-- MAIN GEAR WHEEL
		["AFT_WHEEL"]				= {critical_damage = 3, args = {263}, deps_cells = {"WHEEL_A"}},			-- MAIN GEAR ASSEMBLY
		["HOOK"]					= {critical_damage = 5, args = {268}, deps_cells = {"AFT_WHEEL"}},			-- MAIN GEAR HOUSING
		["WHEEL_L"]					= {critical_damage = 3, args = {136}},	--
		["LEFT_WHEEL"]				= {critical_damage = 3, args = {259}, deps_cells = {"WHEEL_L"}},			-- LEFT GEAR ASSEMBLY
		["LEFT_GEAR_BOX"]			= {critical_damage = 5, args = {267}, deps_cells = {"LEFT_WHEEL"}},			-- LEFT GEAR HOUSING
		["WHEEL_R"]					= {critical_damage = 3, args = {137}},	--
		["RIGHT_WHEEL"]				= {critical_damage = 3, args = {255}, deps_cells = {"WHEEL_R"}},			-- RIGHT GEAR ASSEMBLY
		["RIGHT_GEAR_BOX"]			= {critical_damage = 5, args = {266}, deps_cells = {"RIGHT_WHEEL"}},	-- RIGHT GEAR HOUSING
		
		-- FUSELAGE SECTION
		["FUSELAGE_TOP"]			= {critical_damage = 8, args = {151}},	-- 
		["FUSELAGE_LEFT_SIDE"]		= {critical_damage = 8, args = {177}},	--
		["FUSELAGE_RIGHT_SIDE"]		= {critical_damage = 8, args = {171}},	--
		["TAIL_BOTTOM"]				= {critical_damage = 8, args = {156}},									--
		["TAIL_LEFT_SIDE"]			= {critical_damage = 8, args = {158}, deps_cells = {"ELEVATOR_L_IN"}},	--
		["TAIL_RIGHT_SIDE"]			= {critical_damage = 8, args = {157}, deps_cells = {"ELEVATOR_R_IN"}},	--
		["TAIL"]					= {critical_damage = 8, args = {159}},	-- TAIL CONE
		
		-- WINGS
		["WING_L_OUT"]				= {critical_damage = 5, args = {223}},	-- WING TIP
		["WING_L_CENTER"]			= {critical_damage = 7, args = {224}, deps_cells = {"WING_L_OUT", "WING_L_PART_OUT", "AILERON_L", "PYLON1", "PYLON2"}},	-- WING CENTER
		["WING_L_IN"]				= {critical_damage = 8, args = {225}, deps_cells = {"WING_L_CENTER", "WING_L_PART_CENTER", "FLAP_L_IN", "LEFT_GEAR_BOX", "BLADE_6_IN"}},
		["WING_L_PART_IN"]			= {critical_damage = 9, args = {252}, deps_cells = {"WING_L_IN"}},	-- WING L ROOT
		["WING_R_OUT"]				= {critical_damage = 5, args = {213}},	-- WING TIP
		["WING_R_CENTER"]			= {critical_damage = 7, args = {214}, deps_cells = {"WING_R_OUT", "WING_R_PART_OUT", "AILERON_R", "PYLON3", "PYLON4"}},	-- WING CENTER
		["WING_R_IN"]				= {critical_damage = 8, args = {215}, deps_cells = {"WING_R_CENTER", "WING_R_PART_CENTER", "FLAP_R_IN", "RIGHT_GEAR_BOX", BLADE_6_OUT}},
		["WING_R_PART_IN"]			= {critical_damage = 9, args = {250}, deps_cells = {"WING_R_IN"}},	-- WING R ROOT
		
		-- TAIL FIN
		["FIN_L_TOP"]				= {critical_damage = 8, args = {244}},
		["FIN_L_CENTER"]			= {critical_damage = 8, args = {245}, deps_cells = {"FIN_L_TOP", "RUDDER"}},
		["FIN_L_BOTTOM"]			= {critical_damage = 8, args = {246}, deps_cells = {"FIN_L_CENTER"}},
		
		-- ENGINE
		["ENGINE_L"]				= {critical_damage = 7, args = {272}},	-- ENGINE LEFT SIDE
		["MTG_L"]					= {critical_damage = 7, args = {273}},	-- ENGINE LEFT SIDE TOP
		["BLADE_1_IN"]				= {critical_damage = 7, args = {166}},	-- LEFT INTAKE
		["ENGINE_R"]				= {critical_damage = 7, args = {270}},	-- ENGINE RIGHT SIDE
		["MTG_R"]					= {critical_damage = 7, args = {269}},	-- ENGINE RIGH SIDE TOP
		["BLADE_2_IN"]				= {critical_damage = 7, args = {160}},	-- RIGHT INTAKE
		["BLADE_1_OUT"]				= {critical_damage = 8, args = {167}},	-- FRONT LEFT NOZZLE
		["BLADE_3_OUT"]				= {critical_damage = 8, args = {168}},	-- REAR LEFT NOZZLE
		["BLADE_2_OUT"]				= {critical_damage = 8, args = {161}},	-- FRONT RIGHT NOZZLE
		["BLADE_4_OUT"]				= {critical_damage = 8, args = {162}},	-- REAR RIGHT NOZZLE
		["ENGINE"]					= {critical_damage = 7},				-- ENGINE
		
		-- ENGINE COMPONENTS
		["HYD_RES_1"]				= {critical_damage = 2},	-- LEFT HYDRAULIC RESERVOIR
		["HYD_RES_2"]				= {critical_damage = 2},	-- RIGHT HYDRAULIC RESERVOIR
		["OIL_TANK"]				= {critical_damage = 2},	-- OIL RESERVOIR
		["HYD1_PUMP"]				= {critical_damage = 2},	-- LEFT HYDR PUMP
		["HYD2_PUMP"]				= {critical_damage = 2},	-- RIGHT HYDR PUMP
		["PWD"]						= {critical_damage = 2},	-- APU
		["GENERATOR"]				= {critical_damage = 2},	-- GENERATOR
		["OIL_PUMP"]				= {critical_damage = 2},	-- OIL PUMP
		["OIL_COOLER"]				= {critical_damage = 2},	-- OIL COOLER
		["IGV"]						= {critical_damage = 2},	-- IGV CONTROLLER
		["DECU1"]					= {critical_damage = 2},	-- DECU1
		["DECU2"]					= {critical_damage = 2},	-- DECU2
		
		-- ECM DISPENSERS
		["L_TOP_CM"]				= {critical_damage = 2, args = {303}},	-- TOP LEFT DISPENSER
		["R_TOP_CM"]				= {critical_damage = 2, args = {304}},	-- TOP RIGHT DISPENSER
		["BOTTOM_CM"]				= {critical_damage = 3, args = {305}},	-- BOTTOM DISPENSERS
		
	}
	),-- end of Damage

	DamageParts 	=
 	{
		[1] = "AV-8BNA-OBLOMOK-WING-R",
		[2] = "AV-8BNA-OBLOMOK-WING-L",
        [4] = "AV-8BNA-OBLOMOK-TAIL", -- tail
	},
	
	--------- Failure Table Reference ----------
	Failures = {
		-- FWD Avionics Bay
		{ id = 'DMT_FAILURE_TOTAL',			label = _('DMT Camera Failure'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ARBS_FAILURE_TOTAL',		label = _('ARBS Failure'),								enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'FLIR_FAILURE_TOTAL',		label = _('NAVFLIR Failure'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		-- AFT Avionics Bay
		{ id = 'ADC_FAILURE_TOTAL',			label = _('Air Data Computer Failure'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'MSC_FAILURE_TOTAL',			label = _('Mission Systems Computer Failure'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TCN_FAILURE_TOTAL',			label = _('TACAN Receiver Failure'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'COM1_FAILURE_TOTAL',		label = _('Radio 1 Failure'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'DVMS_FAILURE_TOTAL',		label = _('Moving Map Controller Failure'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'INS_FAILURE_VELOCITY',		label = _('INS Velocity Failure'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'INS_FAILURE_HEADING',		label = _('INS Heading Failure'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'INS_FAILURE_ATTITUDE',		label = _('INS Attitude Failure'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'COM2_FAILURE_TOTAL',		label = _('Radio 2 Failure'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'SMS_FAILURE_TOTAL',			label = _('Weapons Controller Failure'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		-- Weapons Stations
		{ id = 'STATION_1_FAILURE',			label = _('Station 1 Failure'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'STATION_2_FAILURE',			label = _('Station 2 Failure'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'STATION_3_FAILURE',			label = _('Station 3 Failure'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'STATION_4_FAILURE',			label = _('Station 4 Failure'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'STATION_5_FAILURE',			label = _('Station 5 Failure'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'STATION_6_FAILURE',			label = _('Station 6 Failure'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'STATION_7_FAILURE',			label = _('Station 7 Failure'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'STRAKE_LEFT_FAILURE',		label = _('Gun Pod Left Failure'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'STRAKE_RIGHT_FAILURE',		label = _('Gun Pod Right Failure'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
	},
	
	----- External Lights Table Reference ------
	-- Must create the connectors in the exernal model for the external lights
	--[[ 
		LIGHT COLLECTION DATA
		WOLALIGHT_STROBES          = 1
		WOLALIGHT_SPOTS            = 2
		WOLALIGHT_LANDING_LIGHTS   = 2
		WOLALIGHT_NAVLIGHTS        = 3
		WOLALIGHT_FORMATION_LIGHTS = 4
		WOLALIGHT_TIPS_LIGHTS      = 5
		WOLALIGHT_TAXI_LIGHTS      = 6
		WOLALIGHT_BEACONS          = 7
		WOLALIGHT_CABIN_BOARDING   = 8
		WOLALIGHT_CABIN_NIGHT      = 9
		WOLALIGHT_REFUEL_LIGHTS    = 10
		WOLALIGHT_PROJECTORS       = 11
		WOLALIGHT_AUX_LIGHTS       = 12
		WOLALIGHT_IR_FORMATION     = 13
	]]--
	
	-- Position
	-- formation
	-- anti-collision
	-- landing/taxi
	-- aux lights
	-- slidelip vane lights
	-- air refueling probe
	
	lights_data = 	{
		typename = "collection",
		lights = 	{
			--[[HOVER Light]]--
			[WOLALIGHT_AUX_LIGHTS] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight", argument = 209, dir_correction = {elevation = math.rad(3)}, speed = 1.0},
				}
			},
			
			--[[APPROACH Lights]]--
			[WOLALIGHT_LANDING_LIGHTS] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight", argument = 208, dir_correction = {elevation = math.rad(3)}, speed = 1.0},
				}
			},
			
			--[[AUX LIGHTS]]--
			[WOLALIGHT_TAXI_LIGHTS] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight", connector = "CTN_AUX", color = {0.99, 0.99, 0.99}, pos_correction  = {0, 0, 0.0}, argument  = 905, speed = 1.0}, -- Police
				}
			},	
			
			--[ANTI-COLLISION :: [NATO STROBE LIGHTS]]--
			[WOLALIGHT_STROBES] = {
				typename = "collection",
				lights ={
					{typename = "argnatostrobelight",  argument = 83,  period = 1.333,  phase_shift = 0.0}, -- Top Strobe
					{typename = "argnatostrobelight",  argument = 802, period = 1.333,  phase_shift = 0.5}, -- Bottom Strobe
				}
			},
			
			--[POSITION :: [NAVIGATION LIGHTS]]--
			[WOLALIGHT_NAVLIGHTS] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight",  argument  = 190}, --Red Position
					{typename = "argumentlight",  argument  = 191}, --White Position
					{typename = "argumentlight",  argument  = 192}, --Green Position
				}
			},
			
			--[FORMATION :: [FORMATION LIGHTS]]---
			[WOLALIGHT_FORMATION_LIGHTS] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight",argument = 200}, -- form front
					{typename = "argumentlight",argument = 201}, -- form aft
				}
			},	
			
			--[AIR REFUELING PROBE :: [REFUEL LIGHTS]]--
			[WOLALIGHT_REFUEL_LIGHTS] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight", connector = "CNT_RF1", color = {0.99, 0.99, 0.99}, pos_correction  = {0, 0, 0.0}, argument  = 903}, -- Right Side Low
				}
			},	
			
			--[WIND VANE :: [EXTERNAL LIGHTS]]--
			[WOLALIGHT_TIPS_LIGHTS] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight", connector = "CNT_WV", color = {0.99, 0.99, 0.99}, pos_correction  = {0, 0, 0.0}, argument  = 904}, -- Nose Low
				}
			},	
		},
	},
	
	------ Aircraft Additional Properties ------
	Navpoint_Panel = true,
	
	AddPropAircraft = {
		{ id = "LoadWater", control = 'checkbox', label = _('Load Water (500lb)'), defValue = true, weightWhenOn = 226.796}, -- 500lbs
		{ id = "MountNVG", control = 'checkbox', label = _('Load AN/AVS-9 NVG case'), defValue = false},
		{ id = "ClockTime", control = 'comboList', label = _('Cockpit clock time'),
			values = {
				{id =  1, dispName = _("ZULU Time")},
				{id =  2, dispName = _("Local Time")},
			},
			defValue  = 1,
			wCtrl     = 150
		},
		{ id = "RocketBurst", control = 'comboList', label = _('FF Rocket Fire Mode'),
			values = {
				{id =  1, dispName = _("Single Fire")},
				{id =  2, dispName = _("Ripple Fire")},
			},
			defValue  = 1,
			wCtrl     = 150
		},
		{ id = "EWDispenserTFL", control = 'comboList', label = _('Top Front Left EW Dispenser load'),
			values = {
				{id = 1, dispName = _("30 Chaff")},
				{id = 2, dispName = _("30 Flares")},
			},
			defValue = 1,
			wCtrl	 = 150
		},
		{ id = "EWDispenserTFR", control = 'comboList', label = _('Top Front Right EW Dispenser load'),
			values = {
				{id = 1, dispName = _("30 Chaff")},
				{id = 2, dispName = _("30 Flares")},
			},
			defValue = 1,
			wCtrl	 = 150
		},
		{ id = "EWDispenserTBL", control = 'comboList', label = _('Top Rear Left EW Dispenser load'),
			values = {
				{id = 1, dispName = _("30 Chaff")},
				{id = 2, dispName = _("30 Flares")},
			},
			defValue = 2,
			wCtrl	 = 150
		},
		{ id = "EWDispenserTBR", control = 'comboList', label = _('Top Rear Right EW Dispenser load'),
			values = {
				{id = 1, dispName = _("30 Chaff")},
				{id = 2, dispName = _("30 Flares")},
			},
			defValue = 2,
			wCtrl	 = 150
		},
		{ id = "EWDispenserBL", control = 'comboList', label = _('Bottom Left EW Dispenser load'),
			values = {
				{id = 1, dispName = _("30 Chaff")},
				{id = 2, dispName = _("30 Flares")},
			},
			defValue = 2,
			wCtrl	 = 150
		},
		{ id = "EWDispenserBR", control = 'comboList', label = _('Bottom Right EW Dispenser load'),
			values = {
				{id = 1, dispName = _("30 Chaff")},
				{id = 2, dispName = _("30 Flares")},
			},
			defValue = 2,
			wCtrl	 = 150
		},
        { id = "LaserCode100",		control = 'spinbox',  label = _('Laser code for APKWS, 1x11'), defValue = 6, min = 1, max = 8, dimension = ' ' },
        { id = "LaserCode10",		control = 'spinbox',  label = _('Laser code for APKWS, 11x1'), defValue = 8, min = 1, max = 8, dimension = ' ' },
        { id = "LaserCode1",		control = 'spinbox',  label = _('Laser code for APKWS, 111x'), defValue = 8, min = 1, max = 8, dimension = ' ' },
        { id = "GBULaserCode100",	control = 'spinbox',  label = _('Laser code for GBUs, 1x11'),  defValue = 6, min = 5, max = 8, dimension = ' ' },
        { id = "GBULaserCode10",	control = 'spinbox',  label = _('Laser code for GBUs, 11x1'),  defValue = 8, min = 1, max = 8, dimension = ' ' },
        { id = "GBULaserCode1",		control = 'spinbox',  label = _('Laser code for GBUs, 111x'),  defValue = 8, min = 1, max = 8, dimension = ' ' },
		{ id = "AAR_Zone1",			control = 'spinbox',  label = _('AAR Zone 1'),			defValue = 0, min = 0, max = 59, dimension = ' ' },
		{ id = "AAR_Zone2",			control = 'spinbox',  label = _('AAR Zone 2'),			defValue = 0, min = 0, max = 59, dimension = ' ' },
		{ id = "AAR_Zone3",			control = 'spinbox',  label = _('AAR Zone 3'),   		defValue = 0, min = 0, max = 59, dimension = ' ' },
	}
}

add_aircraft(AV8BNA)

