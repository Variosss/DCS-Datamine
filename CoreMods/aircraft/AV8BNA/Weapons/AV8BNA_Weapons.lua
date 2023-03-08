-- Weapons definitions here
local lb_to_kg = 0.453592
local lau7_weight = 90.0*lb_to_kg

-- Fuel Tanks
local load_name = "AV8BNA_AERO1D"
declare_loadout(
 	{
 		category		= CAT_FUEL_TANKS,
		name			= load_name,
 		CLSID			= "{AV8BNA_AERO1D}",
 		attribute		=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
 		Picture			= "PTB.png",
 		displayName		= _("AERO 1D 300 Gallons Fuel Tank "),
 		Weight_Empty	= 89.8113,	-- (198 pounds empty tank)
 		Weight			= 998.3513,	-- (2201 pounds lodaded = 198 empty tank + 2003 fuel )
		Capacity		= 908.54,
 		Cx_pil			= 0.002,
 		shape_table_data =
 		{
 			{
 				name		= load_name;
 				file		= "AV8BNA_FT";
 				life		= 1;
 				fire		= { 0, 1};
 				username	= load_name;
 				index		= WSTYPE_PLACEHOLDER;
 			},
 		},
 		Elements	=
 		{
 			{
 				ShapeName	= "AV8BNA_FT",
 			},
 		},
 	}
)

load_name = "AV8BNA_AERO1D_EMPTY"
declare_loadout(
 	{
 		category		= CAT_FUEL_TANKS,
		name			= load_name,
 		CLSID			= "{AV8BNA_AERO1D_EMPTY}",
 		attribute		=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
 		Picture			= "PTB.png",
 		displayName		= _("AERO 1D 300 Gallons Fuel Tank (Empty)"),
 		Weight_Empty	= 89.8113,	-- (198 pounds empty tank)
 		Weight			= 89.8113,	-- Tank starts empty
		Capacity		= 908.54,
 		Cx_pil			= 0.002,
 		shape_table_data =
 		{
 			{
 				name		= load_name;
 				file		= "AV8BNA_FT";
 				life		= 1;
 				fire		= { 0, 1};
 				username	= load_name;
 				index		= WSTYPE_PLACEHOLDER;
 			},
 		},
 		Elements	=
 		{
 			{
 				ShapeName	= "AV8BNA_FT",
 			},
 		},
 	}
)

-- GAU-12 Ammunition
local ammo_weight = 0.493

declare_weapon(
	{
		category				= CAT_SHELLS,
		name					= "PGU32_SAPHEI_T",
		user_name				= _("PGU-32/U SAPHEI-T"),
		model_name				= "tracer_bullet_red",
		v0						= 1100.0,
		Dv0						= 0.00508,
		Da0						= 0.0005,
		Da1						= 0.0,
		mass					= 0.185,
		round_mass				= 0.493,
		explosive				= 0.085,
		life_time				= 7.0,
		caliber					= 25.0,
		piercing_mass			= 0.130,
		s						= 0.0,
		j						= 0.0,
		l						= 0.0,
		charTime				= 0,
		cx						= {1.0,0.78,0.80,0.15,2.20},
		k1						= 7.7e-10,
		tracer_off				= 6,
		tracer_on				= 0.02,
		scale_tracer			= 2,
		--scale_smoke				= 0.50,
		--smoke_opacity			= 0.10,
		--smoke_tail_life_time	= 1.0,
		cartridge				= 0,
	}
)

-- GAU12 Gunpod
function GAK_14_GunPak(tbl)

	tbl.category	= CAT_GUN_MOUNT 
	tbl.name		= "GAU_12"
	tbl.supply		= 
	{
		shells	= {
					"PGU32_SAPHEI_T",
					"M242_25_AP_M791", 
					"M242_25_HE_M792"
				 },
		mixes	= {
					{1},
					{2},
					{3},
				}, 
		count	= 300,
	}
	if tbl.mixes then 
	   tbl.supply.mixes =  tbl.mixes
	   tbl.mixes	    = nil
	end
	tbl.gun = 
	{
		max_burst_length = 300,
		rates 			 = {3585},
		recoil_coeff 	 = 1,
		barrels_count 	 = 1,
	}
	if tbl.rates then 
	   tbl.gun.rates    =  tbl.rates
	   tbl.rates	    = nil
	end	
	tbl.ejector_pos 			= tbl.ejector_pos or {0.0, 0.0, 0.0}
	tbl.ejector_dir 			= {0,0,0}
	tbl.supply_position  		= tbl.supply_position or {0,  0.3, -0.3}
	tbl.aft_gun_mount 			= false
	tbl.effective_fire_distance = 3700
	tbl.drop_cartridge 			= 0
	tbl.muzzle_pos				= tbl.muzzle_pos or  {0,0,0} -- all position from connector
	tbl.muzzle_pos_connector	= tbl.muzzle_pos_connector or  "Gun_point" -- all position from connector
	tbl.azimuth_initial 		= tbl.azimuth_initial    or 0   
	tbl.elevation_initial 		= tbl.elevation_initial  or 0   
	if  tbl.effects == nil then
		tbl.effects = {
			{ name = "FireEffect"     , arg = tbl.effect_arg_number or 436 },
			{ name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
			{ name = "SmokeEffect"}
		}
	end
	return declare_weapon(tbl)
end

declare_loadout(
	{
		category			=  CAT_PODS,
		CLSID				= "{GAU_12_Equalizer}",
		displayName			= _("GAU 12 Gunpod w/SAPHEI-T"),
		Picture				=	"gunpod.png",
		attribute			= {wsType_Weapon, wsType_GContainer, wsType_Cannon_Cont, WSTYPE_PLACEHOLDER},
		wsTypeOfWeapon		= {wsType_Weapon, wsType_Shell, wsType_Shell_A, wsTypeVulkan},
		Weight				= 136 + (300 * ammo_weight), -- INCLUDE AMMO FOR FULL WEIGHT
        Weight_Empty        = 136,
		Cx_pil				= 0.001220703125,
		kind_of_shipping	= 2,--SOLID_MUNITION
		gun_mounts			= {
			GAK_14_GunPak(
				{
					mixes					= {{1, 1, 1}},
					muzzle_pos				= {0.0, 0.0, 0.0},
					muzzle_pos_connector	= "Gun_point",
					azimuth_initial			= 0.0, -- -0.04363323, -- 2.5 degs to the left
					effect_arg_number		= 433,
				}
			)
		},
		shape_table_data =
		{
			{
				name		= "GAU_12_Equalizer";
				file		= "AV8BNA_GP";
				life		= 1;
				fire		= {0, 1};
				username	= "GAU_12_Equalizer";
				index		= WSTYPE_PLACEHOLDER;
			},
		},
		Elements = {
			[1]	= {
				Position	=	{0, 0, 0},
				ShapeName	=	"AV8BNA_GP",
			}, 
		}, -- end of Elements
	
	--m3_browing({muzzle_pos = {2.91,   0.42,  -0.5 }  	, rates = {1249},mixes = {{2,1,1,1,1,1}},effect_arg_number = 434,azimuth_initial = 0,elevation_initial = 0,supply_position = {2, -0.3, -0.4}}), --up
	}
)

declare_loadout(
	{
		category			=  CAT_PODS,
		CLSID				= "{GAU_12_Equalizer_AP}",
		displayName			= _("GAU 12 Gunpod w/AP M79"),
		Picture				=	"gunpod.png",
		attribute			= {wsType_Weapon, wsType_GContainer, wsType_Cannon_Cont, WSTYPE_PLACEHOLDER},
		wsTypeOfWeapon		= {wsType_Weapon, wsType_Shell, wsType_Shell_A, wsTypeVulkan},
		Weight				= 136 + (300 * ammo_weight), -- INCLUDE AMMO FOR FULL WEIGHT
        Weight_Empty        = 136,
		Cx_pil				= 0.001220703125,
		kind_of_shipping	= 2,--SOLID_MUNITION
		gun_mounts			= {
			GAK_14_GunPak(
				{
					mixes					= {{2, 2, 2}},
					muzzle_pos				= {0.0, 0.0, 0.0},
					muzzle_pos_connector	= "Gun_point",
					azimuth_initial			= 0.0, -- -0.04363323, -- 2.5 degs to the left
					effect_arg_number		= 433,
				}
			)
		},
		shape_table_data =
		{
			{
				name		= "GAU_12_Equalizer_AP";
				file		= "AV8BNA_GP";
				life		= 1;
				fire		= {0, 1};
				username	= "GAU_12_Equalizer_AP";
				index		= WSTYPE_PLACEHOLDER;
			},
		},
		Elements = {
			[1]	= {
				Position	=	{0, 0, 0},
				ShapeName	=	"AV8BNA_GP",
			}, 
		}, -- end of Elements
	
	--m3_browing({muzzle_pos = {2.91,   0.42,  -0.5 }  	, rates = {1249},mixes = {{2,1,1,1,1,1}},effect_arg_number = 434,azimuth_initial = 0,elevation_initial = 0,supply_position = {2, -0.3, -0.4}}), --up
	}
)

declare_loadout(
	{
		category			=  CAT_PODS,
		CLSID				= "{GAU_12_Equalizer_HE}",
		displayName			= _("GAU 12 Gunpod w/HE M792"),
		Picture				=	"gunpod.png",
		attribute			= {wsType_Weapon, wsType_GContainer, wsType_Cannon_Cont, WSTYPE_PLACEHOLDER},
		wsTypeOfWeapon		= {wsType_Weapon, wsType_Shell, wsType_Shell_A, wsTypeVulkan},
		Weight				= 136 + (300 * ammo_weight), -- INCLUDE AMMO FOR FULL WEIGHT
        Weight_Empty        = 136,
		Cx_pil				= 0.001220703125,
		kind_of_shipping	= 2,--SOLID_MUNITION
		gun_mounts			= {
			GAK_14_GunPak(
				{
					mixes					= {{3, 3, 3}},
					muzzle_pos				= {0.0, 0.0, 0.0},
					muzzle_pos_connector	= "Gun_point",
					azimuth_initial			= 0.0, -- -0.04363323, -- 2.5 degs to the left
					effect_arg_number		= 433,
				}
			)
		},
		shape_table_data =
		{
			{
				name		= "GAU_12_Equalizer_HE";
				file		= "AV8BNA_GP";
				life		= 1;
				fire		= {0, 1};
				username	= "GAU_12_Equalizer_HE";
				index		= WSTYPE_PLACEHOLDER;
			},
		},
		Elements = {
			[1]	= {
				Position	=	{0, 0, 0},
				ShapeName	=	"AV8BNA_GP",
			}, 
		}, -- end of Elements
	
	--m3_browing({muzzle_pos = {2.91,   0.42,  -0.5 }  	, rates = {1249},mixes = {{2,1,1,1,1,1}},effect_arg_number = 434,azimuth_initial = 0,elevation_initial = 0,supply_position = {2, -0.3, -0.4}}), --up
	}
)

-- Jammer Pod
declare_loadout(
	{
		category	= CAT_PODS,
		CLSID		= "{ALQ_164_RF_Jammer}",
		Picture		= "ALQ184.png",
		displayName	= _("AN/ALQ-164 DECM Pod"),
		Weight		= 188.241, -- 415lbs
		Cx_pil		= 0.00070256637315,
		attribute	= {wsType_Weapon,	wsType_GContainer,	wsType_Jam_Cont, WSTYPE_PLACEHOLDER},
		shape_table_data =
		{
			{
				name		= "ALQ_164_RF_Jammer";
				file		= "AV8BNA_ALQ164";
				life		= 1;
				fire		= {0, 1};
				username	= "ALQ_164_RF_Jammer";
				index		= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			[1]	= {
				Position	=	{0,	0,	0},
				ShapeName	=	"AV8BNA_ALQ164",
			}, 
		}, -- end of Elements
	}
)

-- Rocket Pods
-- TO BE DETERMINED --

-- AGM-122
local tail_solid = { 1, 1, 1, 1 };	-- Smoke trail
local sidearm_weight = 218.0*lb_to_kg --218 pounds

declare_loadout(
	{
		category		= CAT_MISSILES,
		CLSID			= "{AGM_122_SIDEARM}",
		Picture			= "aim9p.png",
		displayName		= _("AGM-122 Sidearm"),
		Weight			= sidearm_weight,
		wsTypeOfWeapon	= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, 68},
		attribute		= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, 68},
		Elements	= {
			[1]	= {
				DrawArgs	=	{
					[1]	=	{1,	1},
					[2]	=	{2,	1},
				}, -- end of DrawArgs
				Position	=	{0,	0,	0},
				ShapeName	=	"AIM-9B",
			}, 
		}, -- end of Elements
	}
)

declare_loadout(
	{
		category		= CAT_MISSILES,
		CLSID			= "{LAU_7_AGM_122_SIDEARM}",
		Picture			= "aim9p.png",
		displayName		= _("AGM-122 Sidearm"),
		wsTypeOfWeapon	= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, 68},
		attribute		= {4, 4, 32, 111},
		Cx_pil			= 0.001959765625,
		Count			= 1,
		Weight			= lau7_weight + sidearm_weight,
		Elements	= {
			{	ShapeName	= "aero-3b", IsAdapter = true  }, 
			{	ShapeName	= "AIM-9B",	 connector_name = "Point"},
		}, -- end of Elements
	}
)

-- AIM-9L on adapter
local AIM9L_Mass = 85.73
local AIM9L_Cx_pil = 1.68
local AIM9L_DRAG = AIM9L_Cx_pil / 4096.0 -- 4096 - magic number from long time ago when flanker was 1.5 
local lau7_drag = 0.001

declare_loadout(
	{
		category		= CAT_AIR_TO_AIR,
		CLSID			= "{AIM-9L-ON-ADAPTER}",
		Picture			= "us_AIM-9L.png",
		displayName		= _("LAU-7 with AIM-9L Sidewinder IR AAM"),
		wsTypeOfWeapon	= "weapons.missiles.AIM-9L",
		attribute		= {4, 4, 32, 111},
		Cx_pil			= lau7_drag + AIM9L_DRAG,
		Count			= 1,
		Weight			= lau7_weight + AIM9L_Mass,
		Elements	= {
			{	ShapeName	= "aero-3b", IsAdapter = true  }, 
			{	ShapeName	= "AIM-9L",	 connector_name = "Point"},
		}, -- end of Elements
	}
)

-- BOMBS

-- copy from Scripts\Database\db_weapons_data.lua:777   BRU-42_LS now have corrected connectors orientation  since rev 131922
local defaultArgs = {
					[1]	=	{1,	1},
					[2]	=	{2,	1},
					} -- end of DrawArgs
					
			
function bru_42_ls(element,count)
	
	--"Point01" (-0.038423, -0.351833,  0.000008)
	--"Point02" (-0.038423, -0.120182,  0.124399)
	--"Point03" (-0.038423, -0.120182, -0.117564)
	return {
		{	
			ShapeName	=	"BRU-42_LS",
		},
		{
			DrawArgs		= defaultArgs,
			ShapeName		= element,
			connector_name	= "Point02",
		}, 
		{
			DrawArgs		= defaultArgs,
			ShapeName		= element,
			connector_name	= "Point03",
		},
		{
			DrawArgs		= defaultArgs,
			ShapeName		= element,
			connector_name	= "Point01",
		} 
	}
end

function bru_42_ls_2(element,left)

	local con =  "Point03"
	if not left then 
		con = "Point02"
	end
	return {
		{	
			ShapeName	=	"BRU-42_LS",
		},
		{
			DrawArgs		= defaultArgs,
			ShapeName		= element,
			connector_name	= con,
		},
		{
			DrawArgs		= defaultArgs,
			ShapeName		= element,
			connector_name	= "Point01",
		} 
	}
end		

function bru_42_si_2(element,left)
	local con1 =  "Point02"
	local con2 =  "Point03"
	
	if not left then 
		con1 = "Point03"
		con2 = "Point02"
	end
	
	return {
		{	
			ShapeName	=	"BRU-42_LS",
		},
		{
			DrawArgs		= defaultArgs,
			ShapeName		= element,
			connector_name	= con1,
		}, 
		{
			DrawArgs		= defaultArgs,
			ShapeName		= element,
			connector_name	= con2,
		},
		
	}
end

----------------------------------------------------------------------------------------------------------------------------------
-- NOTE: There is major incosistency across mods and even internal ED aircraft on what the weight and Cx for various weapons
-- have, For Example, in the AircraftWeaponsPack these bombs have different weights and Cx as defined by the ED internal
-- bombs_data.lua for indidivual weapons.  Why is this?  I don't know and not sure what to do but I am going to defer to use
-- the value as defined by bombs_data.lua.  Hopefully there will be a solution to better "register" weapons so there is
-- consistency for the same weapon across all aircraft in DCS and better way to define how they are situated on racks so they
-- do not need to be redefined and just point to the single itme in bombs_data.lua
--
-- The one exception is the Cx for the GBU-38 and GBU-54, bombs_data.lua has it defined as 0.00074 which is roughly 4.6x the drag of
-- a normal MK-82!  This is not correct, even the value of 0.00035 as defined in the aircraft weapons pack is more in-line
-- when compared to the Cx of a GBU-12 so we won't use the bomb_data.lua since it's pretty absurd and needs review
--
--
-- CJS 9/24/2022 update these to more accurately reflect the weights as design in the performance aircraft loading
-- for the AV-8B even though what DCS has told us, it is obviously incorrect, as the values in the loading
-- table I trust more
----------------------------------------------------------------------------------------------------------------------------------
bombs_data =
{
    ["MK-81"]			= {name = "Mk-81",			mass =  260.0*lb_to_kg, wsType = {4, 5, 9, 30},               Cx = 0.000130, picture = "mk82.png"},
    ["MK-82"]			= {name = "Mk-82",			mass =  510.0*lb_to_kg, wsType = {4, 5, 9, 31},               Cx = 0.000160, picture = "mk82.png"},
    ["MK-82_Snakeye"]	= {name = "Mk-82 Snakeye",	mass =  550.0*lb_to_kg, wsType = {4, 5, 9, 79},               Cx = 0.000186, picture = "mk82AIR.png"},
    ["MK-82AIR"]		= {name = "Mk-82 AIR",		mass =  544.0*lb_to_kg, wsType = {4, 5, 9, 75},               Cx = 0.000186, picture = "mk82AIR.png"},
    ["ROCKEYE"]			= {name = "Mk-20 Rockeye",	mass =  505.0*lb_to_kg, wsType = {4, 5, 38, 45},              Cx = 0.000265, picture = "Mk20.png"},
	["CBU-99"]			= {name = "CBU-99",			mass =  505.0*lb_to_kg, wsType = {4, 5, 38, 302},             Cx = 0.000265, picture = "Mk20.png"},
    ["MK-83"] 			= {name = "Mk-83", 			mass =  985.0*lb_to_kg, wsType = {4, 5, 9, 32},               Cx = 0.000225, picture = "mk83.png"},
	["GBU-12"] 			= {name = "GBU-12", 		mass =  612.0*lb_to_kg, wsType = {4, 5, 36, 38},              Cx = 0.000365, picture = "GBU12.png"},
	["GBU-16"] 			= {name = "GBU-16", 		mass = 1092.0*lb_to_kg, wsType = {4, 5, 36, 39},              Cx = 0.000410, picture = "GBU16.png"},
	["GBU-38"] 			= {name = "GBU-38", 		mass =  564.0*lb_to_kg, wsType = {4, 5,	36,	86},              Cx = 0.000350, picture = "GBU38.png"},
    ["GBU-54"] 			= {name = "GBU-54(V)1/B", 	mass =  558.0*lb_to_kg, wsType = "weapons.bombs.GBU_54_V_1B", Cx = 0.000350, picture = "GBU54.png"},
}

bru_42_mass = 127.0*lb_to_kg -- Previously 214 lbs, from loading manual 127 lbs
bru_42_cx = 0.0005

local function bru_42_3x_bombs(element, clsid)
	local bomb_variant = bombs_data[element] or bombs_data["MK-82"]
    local num_weapons = 3
	local data = {
		category		=	CAT_BOMBS,
		CLSID			=	clsid,
		Picture			=	bomb_variant.picture,
		wsTypeOfWeapon	=	bomb_variant.wsType,
		displayName		=  _(num_weapons.." "..bomb_variant.name),
		attribute		=	{wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
		Cx_pil			=	bru_42_cx + num_weapons * bomb_variant.Cx,
		Count			=	num_weapons,
		Weight			=	bru_42_mass + num_weapons * bomb_variant.mass,
		Weight_Empty	=	bru_42_mass,
		Elements		=   bru_42_ls(element),
	}
	declare_loadout(data)
end

local function bru_42_2x_bombs(element, clsid, left)
	local bomb_variant = bombs_data[element] or bombs_data["MK-82"]
    local num_weapons = 2
    local _side = " *\\*"
	if left then _side = " */*" end
	
	local data = {
		category		=	CAT_BOMBS,
		CLSID			=	clsid,
		Picture			=	bomb_variant.picture,
		wsTypeOfWeapon	=	bomb_variant.wsType,
		displayName		=  _(num_weapons.." "..bomb_variant.name .. _side),
		attribute		=	{wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
		Cx_pil			=	bru_42_cx + num_weapons * bomb_variant.Cx,
		Count			=	num_weapons,
		Weight			=	bru_42_mass + num_weapons * bomb_variant.mass,
		Weight_Empty	=	bru_42_mass,
		Elements		=   bru_42_ls_2(element,left),
	}
	declare_loadout(data)
end

local function bru_42_2x_side_bombs(element, clsid, left)
	local bomb_variant = bombs_data[element] or bombs_data["MK-82"]
    local num_weapons = 2
	local data = {
		category		=	CAT_BOMBS,
		CLSID			=	clsid,
		Picture			=	bomb_variant.picture,
		wsTypeOfWeapon	=	bomb_variant.wsType,
		displayName		=  _(num_weapons.." "..bomb_variant.name .. " *-*"),
		attribute		=	{wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
		Cx_pil			=	bru_42_cx + num_weapons * bomb_variant.Cx,
		Count			=	num_weapons,
		Weight			=	bru_42_mass + num_weapons * bomb_variant.mass,
		Weight_Empty	=	bru_42_mass,
		Elements		=   bru_42_si_2(element, left),
	}
	declare_loadout(data)
end


-- It would be nice to use a generated CLSID but at this point
-- so many users have the inconsistenc CLSID names in their loadouts/missions
-- that it would be a huge disaster to move away from the already defined CLSIDs
bru_42_3x_bombs("GBU-38", "{BRU-70A_3*GBU-38}")
bru_42_2x_side_bombs("GBU-38", "{BRU-70A_2*GBU-38_SIDE_LEFT}", true)	-- LEFT SIDE
bru_42_2x_side_bombs("GBU-38", "{BRU-70A_2*GBU-38_SIDE_RIGHT}", false)	-- RIGHT SIDE

bru_42_3x_bombs("GBU-12", "{BRU-42A_3*GBU-12}")
bru_42_2x_side_bombs("GBU-12", "{BRU-42A_2*GBU-12_SIDE_LEFT}", true)	-- LEFT SIDE
bru_42_2x_side_bombs("GBU-12", "{BRU-42A_2*GBU-12_SIDE_RIGHT}", false)	-- RIGHT SIDE

bru_42_3x_bombs("GBU-16", "{BRU-42A_3*GBU-16}")

bru_42_3x_bombs("MK-82", "{BRU-42_3*Mk-82LD}")
bru_42_2x_bombs("MK-82", "{BRU-42_2*Mk-82_LEFT}", true)  	-- LEFT SIDE
bru_42_2x_bombs("MK-82", "{BRU-42_2*Mk-82_RIGHT}", false) 	-- RIGHT SIDE

bru_42_2x_bombs("ROCKEYE", "{BRU-42_2*MK-20_LEFT}", true)  	-- LEFT SIDE
bru_42_2x_bombs("ROCKEYE", "{BRU-42_2*MK-20_RIGHT}", false) -- RIGHT SIDE

bru_42_2x_bombs("CBU-99", "{BRU-70_2*CBU-99_LEFT}", true)  	-- LEFT SIDE
bru_42_2x_bombs("CBU-99", "{BRU-70_2*CBU-99_RIGHT}", false) -- RIGHT SIDE

bru_42_3x_bombs("MK-83", "{BRU-42_3*Mk-83}")

bru_42_3x_bombs("MK-82_Snakeye", "{BRU-42_3*Mk-82SNAKEYE}")
bru_42_2x_bombs("MK-82_Snakeye", "{BRU-42_2*Mk-82SNAKEYE_LEFT}", true)  	-- LEFT SIDE
bru_42_2x_bombs("MK-82_Snakeye", "{BRU-42_2*Mk-82SNAKEYE_RIGHT}", false)	-- RIGHT SIDE

bru_42_3x_bombs("MK-82AIR", "{BRU-42_3_MK82AIR}")
bru_42_2x_bombs("MK-82AIR", "{BRU-42_2*Mk-82AIR_LEFT}", true)	-- LEFT SIDE
bru_42_2x_bombs("MK-82AIR", "{BRU-42_2*Mk-82AIR_RIGHT}", false)	-- RIGHT SIDE

bru_42_3x_bombs("MK-81", "{BRU-42_3*Mk-81LD}")
bru_42_2x_bombs("MK-81", "{BRU-42_2*Mk-81LD_LEFT}", true)	-- LEFT SIDE
bru_42_2x_bombs("MK-81", "{BRU-42_2*Mk-81LD_RIGHT}", false)	-- RIGHT SIDE

bru_42_3x_bombs("GBU-54", "{BRU-70A_3*GBU-54}")
bru_42_2x_side_bombs("GBU-54", "{BRU-70A_2*GBU-54_SIDE_LEFT}", true)	-- LEFT SIDE
bru_42_2x_side_bombs("GBU-54", "{BRU-70A_2*GBU-54_SIDE_RIGHT}", false)	-- RIGHT SIDE

-- Deprecated loads, only for backwards compatibility
bru_42_3x_bombs("GBU-38", "{BRU-42_3*GBU-38}")
bru_42_2x_bombs("GBU-38", "{BRU-42_2*GBU-38_LEFT}", true)  		-- LEFT SIDE
bru_42_2x_bombs("GBU-38", "{BRU-42_2*GBU-38_RIGHT}", false) 	-- RIGHT SIDE

bru_42_2x_bombs("GBU-12", "{BRU-42_2*GBU-12_LEFT}", true)  		-- LEFT SIDE
bru_42_2x_bombs("GBU-12", "{BRU-42_2*GBU-12_RIGHT}", false) 	-- RIGHT SIDE

bru_42_2x_bombs("GBU-16", "{BRU-42_2*GBU-16_LEFT}", true)  		-- LEFT SIDE
bru_42_2x_bombs("GBU-16", "{BRU-42_2*GBU-16_RIGHT}", false) 	-- RIGHT SIDE

bru_42_2x_bombs("MK-83", "{BRU-42_2*Mk-83_LEFT}", true)  		-- LEFT SIDE
bru_42_2x_bombs("MK-83", "{BRU-42_2*Mk-83_RIGHT}", false) 		-- RIGHT SIDE

bru_42_2x_bombs("GBU-54", "{BRU-70A_2*GBU-54_LEFT}", true)  	-- LEFT SIDE
bru_42_2x_bombs("GBU-54", "{BRU-70A_2*GBU-54_RIGHT}", false)	-- RIGHT SIDE
