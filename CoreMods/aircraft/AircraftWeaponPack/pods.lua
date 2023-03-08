declare_loadout({
	category 		= CAT_PODS,
	CLSID			= "ALQ_184_Long",
	Picture			= "ALQ184.png",
	attribute		= {4,	15,	45,	WSTYPE_PLACEHOLDER},
	Weight			= 286,
	Cx_pil			= 0.00070256637315,
	displayName		= _("ALQ-184 Long - ECM Pod"),

	shape_table_data =
	{
		{
			file = "alq-184long",
			life = 1,
			fire = { 0, 1},
			username = "alq-184long",
			index = WSTYPE_PLACEHOLDER,
		},
	},
	
	Elements =
	{
		{ ShapeName = "alq-184long", }
	},
})
