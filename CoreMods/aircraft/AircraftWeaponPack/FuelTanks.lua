local PTB_450 =
{
	category		= CAT_FUEL_TANKS,
	CLSID			= "{PTB_450}",
	attribute		= {1, 3, 43, WSTYPE_PLACEHOLDER},
	Picture			= "PTB.png",
	Weight_Empty	= 110,
	Weight			= 550,
	displayName		= _("Fuel tank PTB-450"),
	Cx_pil 			= 0.001464844,

	shape_table_data = {{
		name		= "PTB_450",
		file		= "PTB-450",
		username	= _("PTB-450"),
		index		= WSTYPE_PLACEHOLDER,
	}},

	Elements = {{ ShapeName = "PTB-450" }}
}
declare_loadout(PTB_450)

-- For backwards compatibility
local PTB_450_Old = {}
copy_recursive(PTB_450_Old, PTB_450)
PTB_450_Old.CLSID = "{B99EE8A8-99BC-4a8d-89AC-A26831920DCE}"
declare_loadout(PTB_450_Old)

local EFT_230GAL =
{
	category		= CAT_FUEL_TANKS,
	CLSID			= "{EFT_230GAL}",
	attribute		= {1, 3, 43, WSTYPE_PLACEHOLDER},
	Picture			= "PTB.png",
	Weight_Empty	= 63.5,
	Weight			= 765.45,
	displayName		= _("Fuel tank 230 gal"),
	Cx_pil 			= 0.001464844,

	shape_table_data = {{
		name		= "EFT_230Gal",
		file		=  "fuel_tank_230",
		username	=  _("Fuel tank 230 gal"),
		index		= WSTYPE_PLACEHOLDER,
	}},

	Elements = {{ ShapeName = "fuel_tank_230" }}
}
declare_loadout(EFT_230GAL)