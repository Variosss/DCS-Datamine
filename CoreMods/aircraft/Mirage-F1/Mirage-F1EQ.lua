
make_MirageF1({
	Name						= 'Mirage-F1EQ',
	DisplayName					= _('Mirage F1EQ'),
	WorldID 					= WSTYPE_PLACEHOLDER,
	Countries 					= {"Iran", "Iraq"},
	attribute 					= makeAttribute(WSTYPE_PLACEHOLDER, true),
	tanker_type 				= 2, -- Tanker type if the plane is airrefuel capable
	air_refuel_receptacle_pos 	= air_refuel_receptacle_pos_short,

	Pylons 						= Pylons_ED_BD_EQ_BQ,
})
