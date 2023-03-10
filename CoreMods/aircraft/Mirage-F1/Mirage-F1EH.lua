
make_MirageF1({
	Name						= 'Mirage-F1EH',
	DisplayName					= _('Mirage F1EH'),
	WorldID 					= WSTYPE_PLACEHOLDER,
	Countries 					= {"Morocco"},
	attribute 					= makeAttribute(WSTYPE_PLACEHOLDER, true),
	tanker_type 				= 2, -- Tanker type if the plane is airrefuel capable
	air_refuel_receptacle_pos 	= air_refuel_receptacle_pos_long,
	
	--------------------------------------------------------------------------------------------------------------------------------------------- 	
	-- Countermeasures
	passivCounterm 				= passivCounterm,

	Pylons 						= Pylons_C200_CH_CJ_CK_CZ_EH_JA,
})
