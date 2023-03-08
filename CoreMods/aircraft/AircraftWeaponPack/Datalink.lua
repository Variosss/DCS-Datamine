declare_loadout({
	category 		= CAT_PODS,
	CLSID			= "{AWW-13}",
	attribute		= {4, 15, 44, WSTYPE_PLACEHOLDER},
	Count 			= 1,
	Cx_pil			= 0.000244140625,
	Picture			= "ANAAS38.png",
	displayName		= _("AWW-13 DATALINK POD"),
	Weight			= 200,
	
	shape_table_data =
        {
            {
                file = "ANAWW_13",
                life = 1,
                fire = { 0, 1},
                username = "ANAWW-13",
                index = WSTYPE_PLACEHOLDER,
            },
        },
	
	Elements		=	
	{
			{
				Position	=	{0,	0,	0},
				ShapeName	=	"ANAWW_13",
			}
	},					
})