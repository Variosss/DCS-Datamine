
local weight_fuel_max_F1EE = 3246

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
	Pylons 						= Pylons_CE_BE_EE,
	
	AddPropAircraft 			= makeAircraftProperties(extraAircraftProp_INSStartMode, extraAircraftProp_RWR_type),
})
