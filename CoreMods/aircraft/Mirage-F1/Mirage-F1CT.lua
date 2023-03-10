
local Pylons_CT = {}
copyTable(Pylons_Common, Pylons_CT)

add_SRM(Pylons_CT, id_MAGIC_I, 1, 7)
add_SRM(Pylons_CT, id_MAGIC_II, 1, 7)

add_R530(Pylons_CT, id_SUPER_530F, 3, 5)

add_FuelTank(Pylons_CT, id_PTB_580G_F1, 4)
add_FuelTank(Pylons_CT, id_PTB_580G_F1_EMPTY, 4)


make_MirageF1({
	Name						= 'Mirage-F1CT',
	DisplayName					= _('Mirage F1CT'),
	WorldID 					= WSTYPE_PLACEHOLDER,
	Countries 					= {"USA", "France"},
	attribute 					= makeAttribute(WSTYPE_PLACEHOLDER, true),
	tanker_type 				= 2, -- Tanker type if the plane is airrefuel capable
	air_refuel_receptacle_pos 	= air_refuel_receptacle_pos_short,

	Pylons 						= Pylons_CT,
})
