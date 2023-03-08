
PIERCING_IMPOSSIBLE = 0
REAR_ASPECT_ONLY = 1
ALL_ASPECTS = 2

absent_shell_piercing_status = PIERCING_IMPOSSIBLE
absent_target_type_piercing_status = ALL_ASPECTS

shells_by_target_types = {
	["weapons.shells.GSH301_30_AP"] = {	
		[1] = {"NonAndLightArmoredUnits", ALL_ASPECTS},
		[2] = {"HeavyArmoredUnits", REAR_ASPECT_ONLY},
	},	
	["weapons.shells.HP30_30_AP"] = {
		[1] = {"NonAndLightArmoredUnits", ALL_ASPECTS},
		[2] = {"HeavyArmoredUnits", REAR_ASPECT_ONLY},
	},
	["weapons.shells.2A42_30_AP"] = {
		[1] = {"NonAndLightArmoredUnits", ALL_ASPECTS},
		[2] = {"HeavyArmoredUnits", REAR_ASPECT_ONLY},
	},	
	["weapons.shells.GAU8_30_AP"] = {	
		[1] = {"NonAndLightArmoredUnits", ALL_ASPECTS},
		[2] = {"HeavyArmoredUnits", REAR_ASPECT_ONLY},
	},
	["weapons.shells.GAU8_30_HE"] = {	
		[1] = {"NonAndLightArmoredUnits", ALL_ASPECTS},
		[2] = {"HeavyArmoredUnits", REAR_ASPECT_ONLY},
	},		
	["default"] = {
    	[1] = {"NonAndLightArmoredUnits", ALL_ASPECTS},
    	[2] = {"HeavyArmoredUnits", PIERCING_IMPOSSIBLE},		
	}
}