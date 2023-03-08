local DbOption  = require('Options.DbOption')


local relations_mi8_common_enabled = 
{	
	[false] = {
		action = {
			["mi8_3D_enabled"] = false,
		},
	},
}

local relations_mi8_3D_enabled = 
{	
	[true] = {
		action = {
			["mi8_common_enabled"] = true,
		},
	},
}

local relations_l39c_common_enabled = 
{	
	[false] = {
		action = {
			["l39c_3D_enabled"] = false,
		},
	},
}

local relations_l39c_3D_enabled = 
{	
	[true] = {
		action = {
			["l39c_common_enabled"] = true,
		},
	},
}

local relations_c101cc_common_enabled = 
{	
	[false] = {
		action = {
			["c101cc_3D_enabled"] = false,
		},
	},
}

local relations_c101cc_3D_enabled = 
{	
	[true] = {
		action = {
			["c101cc_common_enabled"] = true,
		},
	},
}

local relations_c101eb_common_enabled = 
{	
	[false] = {
		action = {
			["c101eb_3D_enabled"] = false,
		},
	},
}

local relations_c101eb_3D_enabled = 
{	
	[true] = {
		action = {
			["c101eb_common_enabled"] = true,
		},
	},
}

local relations_sa342_enabled = 
{	
	[false] = {
		action = {
			["sa342_3D_enabled"] = false,
		},
	},
}

local relations_sa342_3D_enabled = 
{	
	[true] = {
		action = {
			["sa342_enabled"] = true,
		},
	},
}

local relations_CEII_enabled = 
{	
	[false] = {
		action = {
			["CEII_3D_enabled"] = false,
		},
	},
}

local relations_CEII_3D_enabled = 
{	
	[true] = {
		action = {
			["CEII_enabled"] = true,
		},
	},
}

return {
	a10a_enabled 				= DbOption.new():setValue(true):checkbox(),
	ajs37_enabled 				= DbOption.new():setValue(true):checkbox(),
	av8b_enabled 				= DbOption.new():setValue(true):checkbox(),
	f15c_enabled 				= DbOption.new():setValue(true):checkbox(),
	f5e3_enabled 				= DbOption.new():setValue(true):checkbox(),
	f86f_enabled 				= DbOption.new():setValue(true):checkbox(),
	j11a_enabled 				= DbOption.new():setValue(true):checkbox(),
	l39za_enabled 				= DbOption.new():setValue(true):checkbox(),
	miraj_enabled 				= DbOption.new():setValue(true):checkbox(),
	mig15bis_enabled 			= DbOption.new():setValue(true):checkbox(),
	mig21bis_enabled 			= DbOption.new():setValue(true):checkbox(),
	mig29a_enabled 				= DbOption.new():setValue(true):checkbox(),
	mig29g_enabled 				= DbOption.new():setValue(true):checkbox(),
	mig29s_enabled 				= DbOption.new():setValue(true):checkbox(),
	su25_enabled 				= DbOption.new():setValue(true):checkbox(),
	su25t_enabled 				= DbOption.new():setValue(true):checkbox(),
	su27_enabled 				= DbOption.new():setValue(true):checkbox(),
	su33_enabled 				= DbOption.new():setValue(true):checkbox(),
	bf109k4_enabled 			= DbOption.new():setValue(true):checkbox(),
	fw190d9_enabled 			= DbOption.new():setValue(true):checkbox(),
	i16_enabled 				= DbOption.new():setValue(true):checkbox(),
	p51d_enabled 				= DbOption.new():setValue(true):checkbox(),
	SpitfireLFMkIX_enabled 		= DbOption.new():setValue(true):checkbox(),
	SpitfireLFMkIXCW_enabled	= DbOption.new():setValue(true):checkbox(),
	tf51d_enabled 				= DbOption.new():setValue(true):checkbox(),
	yak52_enabled 				= DbOption.new():setValue(true):checkbox(),
	uh1h_enabled 				= DbOption.new():setValue(true):checkbox(),
	f14b_enabled				= DbOption.new():setValue(true):checkbox(),
	jf17_enabled				= DbOption.new():setValue(true):checkbox(),
	mi24p_enabled				= DbOption.new():setValue(true):checkbox(),
	mi8_common_enabled 			= DbOption.new():setValue(true):checkbox():setRelations(relations_mi8_common_enabled),
	mi8_3D_enabled 				= DbOption.new():setValue(true):checkbox():setRelations(relations_mi8_3D_enabled),
	l39c_common_enabled 		= DbOption.new():setValue(true):checkbox():setRelations(relations_l39c_common_enabled),
	l39c_3D_enabled 			= DbOption.new():setValue(true):checkbox():setRelations(relations_l39c_3D_enabled),
	c101cc_common_enabled 		= DbOption.new():setValue(true):checkbox():setRelations(relations_c101cc_common_enabled),
	c101cc_3D_enabled 			= DbOption.new():setValue(true):checkbox():setRelations(relations_c101cc_3D_enabled),		
	c101eb_common_enabled 		= DbOption.new():setValue(true):checkbox():setRelations(relations_c101eb_common_enabled),
	c101eb_3D_enabled 			= DbOption.new():setValue(true):checkbox():setRelations(relations_c101eb_3D_enabled),	
	
	sa342_enabled 				= DbOption.new():setValue(true):checkbox():setRelations(relations_sa342_enabled),
	sa342_3D_enabled 			= DbOption.new():setValue(true):checkbox():setRelations(relations_sa342_3D_enabled),
	
	CEII_enabled 				= DbOption.new():setValue(true):checkbox():setRelations(relations_CEII_enabled),
	CEII_3D_enabled 			= DbOption.new():setValue(true):checkbox():setRelations(relations_CEII_3D_enabled),
}

