
local weight_fuel_max_F1EE = 3246

local Pylons_EE = {}
copyTable(Pylons_CE_BE_EE, Pylons_EE)

add_ECM_pod(Pylons_EE, id_BARAX, 2, 6)


make_MirageF1({
	Name						= 'Mirage-F1EE',
	DisplayName					= _('Mirage F1EE'),
	WorldID 					= WSTYPE_PLACEHOLDER,
	attribute 					= makeAttribute(WSTYPE_PLACEHOLDER, true),
	tanker_type 				= 2, -- Tanker type if the plane is airrefuel capable
	air_refuel_receptacle_pos 	= air_refuel_receptacle_pos_long,
	
	MaxFuelWeight 				= string.format("%d", weight_fuel_max_F1EE),
	M_fuel_max 					= weight_fuel_max_F1EE,
	
	passivCounterm 				= passivCounterm,
	Pylons 						= Pylons_EE,
	
	AddPropAircraft 			= makeAircraftProperties(extraAircraftProp_INSStartMode, extraAircraftProp_RWR_type),
})
