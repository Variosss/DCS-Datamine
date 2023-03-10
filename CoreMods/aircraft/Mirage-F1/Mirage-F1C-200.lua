
make_MirageF1({
	Name						= 'Mirage-F1C-200',
	DisplayName					= _('Mirage F1C-200'),
	WorldID 					= WSTYPE_PLACEHOLDER,
	Countries 					= {"France"},
	attribute 					= makeAttribute(WSTYPE_PLACEHOLDER, true),
	tanker_type 				= 2, -- Tanker type if the plane is airrefuel capable
	air_refuel_receptacle_pos 	= air_refuel_receptacle_pos_short,
	
	Pylons 						= Pylons_C200_CH_CJ_CK_CZ_EH_JA,
})
