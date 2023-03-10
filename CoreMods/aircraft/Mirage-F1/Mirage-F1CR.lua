
local Pylons_CR = {}
copyTable(Pylons_Common, Pylons_CR)

add_SRM(Pylons_CR, id_MAGIC_I, 1, 7)
add_SRM(Pylons_CR, id_MAGIC_II, 1, 7)

add_Bomb(Pylons_CR, id_BR_250, 4)
add_Bomb(Pylons_CR, id_BR_500, 4)
add_Bomb(Pylons_CR, id_GBU_10, 3, 4, 5)
add_Bomb(Pylons_CR, id_GBU_12, 3, 4, 5)

add_FuelTank(Pylons_CR, id_PTB_580G_F1, 4)
add_FuelTank(Pylons_CR, id_PTB_580G_F1_EMPTY, 4)


make_MirageF1({
	Name						= 'Mirage-F1CR',
	DisplayName					= _('Mirage F1CR'),
	WorldID 					= WSTYPE_PLACEHOLDER,
	Countries 					= {"USA", "France"},
	attribute 					= makeAttribute(WSTYPE_PLACEHOLDER, true),
	tanker_type 				= 2, -- Tanker type if the plane is airrefuel capable
	air_refuel_receptacle_pos 	= air_refuel_receptacle_pos_short,

	Pylons 						= Pylons_CR,
})
