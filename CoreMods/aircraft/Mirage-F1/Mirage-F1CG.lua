
local Pylons_CG = {}
copyTable(Pylons_Common, Pylons_CG)

add_SRM(Pylons_CG, id_AIM_9B, 1, 2, 6, 7)
add_SRM(Pylons_CG, id_AIM_9J, 1, 2, 6, 7)
add_SRM(Pylons_CG, id_AIM_9JULI, 1, 2, 6, 7)

add_Bomb(Pylons_CG, id_BR_250, 4)
add_Bomb(Pylons_CG, id_BR_500, 4)
add_Bomb(Pylons_CG, id_GBU_10, 4)
add_Bomb(Pylons_CG, id_GBU_12, 4)

add_R530(Pylons_CG, id_R530F_EM, 3, 4, 5)
add_R530(Pylons_CG, id_R530F_IR, 3, 4, 5)
add_R530(Pylons_CG, id_SUPER_530F, 3, 5)


make_MirageF1({
	Name						= 'Mirage-F1CG',
	DisplayName					= _('Mirage F1CG'),
	WorldID 					= WSTYPE_PLACEHOLDER,
	Countries 					= {"Greece"},
	
	Pylons 						= Pylons_CG,
})
