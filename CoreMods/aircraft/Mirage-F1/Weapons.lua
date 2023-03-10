
local RP35_empty_w = 160.0

local fuelTank_RP35_cmn =
{
	category   			= CAT_FUEL_TANKS,
	attribute  			= {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
	Picture   			= "ftm1.png",
	Cx_pil				= 0.001,
	Weight_Empty  		= RP35_empty_w,
	Capacity   			= 898.0,
	
	shape_table_data =
	{
		{
			file    	= "PTB_1200_F1";
			life    	= 1;
			fire    	= {0, 1};
			username 	= "RP35 Pylon Fuel Tank (1137 l usable)";
			index 		= WSTYPE_PLACEHOLDER;
		},
	},
	
	Elements = 
	{
		{
			Position 	= {0, 0, 0},
			Rotation 	= {0, 0, 0},
			ShapeName 	= "PTB_1200_F1",
		},
	}, 
}

-- fuel tank 1200 liters (full)
local fuelTank_RP35_full = {}
copyTable(fuelTank_RP35_cmn, fuelTank_RP35_full)

fuelTank_RP35_full.CLSID    	= "PTB-1200-F1"
fuelTank_RP35_full.displayName	= _("RP35 Pylon Fuel Tank (1137 l usable)")
fuelTank_RP35_full.Weight    	= RP35_empty_w + 898.0

declare_loadout(fuelTank_RP35_full)

-- fuel tank 1200 liters (empty)
local fuelTank_RP35_empty = {}
copyTable(fuelTank_RP35_cmn, fuelTank_RP35_empty)

fuelTank_RP35_empty.CLSID    	= "PTB-1200-F1-EMPTY"
fuelTank_RP35_empty.displayName	= _("RP35 Pylon Fuel Tank (1137 l usable) [Empty]")
fuelTank_RP35_empty.Weight    	= RP35_empty_w

declare_loadout(fuelTank_RP35_empty)


local RPL201_empty_w = 265.0

local fuelTank_RPL201_cmn =
{
	category   			= CAT_FUEL_TANKS,
	attribute  			=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
	Picture   			= "ftm1.png",
	Cx_pil				= 0.001,
	Weight_Empty  		= RPL201_empty_w,
	Capacity    		= 1825.0,
	
	shape_table_data = 
	{
		{
			file    	= "PTB_580G_F1";
			life    	= 1;
			fire    	= { 0, 1};
			username 	= "RPL201 Pylon Fuel Tank (2310 l usable)";
			index 		= WSTYPE_PLACEHOLDER;
		},
	},
	
	Elements = 
	{
		{
			Position 	= {0, 0, 0},
			Rotation 	= {0, 0, 0},
			ShapeName 	= "PTB_580G_F1",
		}, 
	}, 
}

-- fuel tank 580 gal (full)
local fuelTank_RPL201_full = {}
copyTable(fuelTank_RPL201_cmn, fuelTank_RPL201_full)

fuelTank_RPL201_full.CLSID    		= "PTB-580G-F1"
fuelTank_RPL201_full.displayName	= _("RPL201 Pylon Fuel Tank (2310 l usable)")
fuelTank_RPL201_full.Weight    	= RPL201_empty_w + 1825.0

declare_loadout(fuelTank_RPL201_full)

-- fuel tank 580 gal (empty)
local fuelTank_RPL2201_empty = {}
copyTable(fuelTank_RPL201_cmn, fuelTank_RPL2201_empty)

fuelTank_RPL2201_empty.CLSID    	= "PTB-580G-F1-EMPTY"
fuelTank_RPL2201_empty.displayName	= _("RPL201 Pylon Fuel Tank (2310 l usable) [Empty]")
fuelTank_RPL2201_empty.Weight    	= RPL201_empty_w

declare_loadout(fuelTank_RPL2201_empty)

declare_loadout(
	{
		category 			= CAT_PODS,
		CLSID				= "BARAX_ECM",
		Picture				= "ALQ184.png",
		attribute			= {4, 15, 45, WSTYPE_PLACEHOLDER},
		Weight				= 85,
		Cx_pil				= 0.00070256637315,
		displayName			= _("BARAX - ECM Pod"),

		shape_table_data =
		{
			{
				file 		= "BARAX",
				life 		= 1,
				fire 		= {0, 1},
				username 	= "BARAX",
				index 		= WSTYPE_PLACEHOLDER,
			},
		},
		
		Elements =
		{
			{ShapeName = "BARAX",}
		},
	}
)

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

