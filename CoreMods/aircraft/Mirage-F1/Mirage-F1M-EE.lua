
local weight_fuel_max_F1M_EE = 3246

local Pylons_M_EE = {}
copyTable(Pylons_CE_BE_EE, Pylons_M_EE)

add_ECM_pod(Pylons_M_EE, id_BARAX, 2, 6)

make_MirageF1({
	Name						= 'Mirage-F1M-EE',
	DisplayName					= _('Mirage F1M (C.14 52-73)'),
	WorldID 					= WSTYPE_PLACEHOLDER,
	Countries 					= {"Spain", "USA"},
	attribute 					= makeAttribute(WSTYPE_PLACEHOLDER, true),
	tanker_type 				= 2, -- Tanker type if the plane is airrefuel capable
	air_refuel_receptacle_pos 	= air_refuel_receptacle_pos_long,
	
	MaxFuelWeight 				= string.format("%d", weight_fuel_max_F1M_EE),
	M_fuel_max 					= weight_fuel_max_F1M_EE,
	
	passivCounterm 				= passivCounterm,
	
	Pylons 						= Pylons_M_EE,
})
