


local Cx_RP541 = 0.0012
local W_RP541 = 257.0
local Cx_RP522 = 0.0008
local W_RP522 = 180.0



-- Fuel Tanks
declare_loadout(
	{
		category	= CAT_FUEL_TANKS,
		CLSID		= "{M2KC_02_RPL541}",
		name		= "M2KC_02_RPL541",
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("RPL 541 2000 liters Fuel Tank "),
		Weight_Empty	= W_RP541,
		Weight		= W_RP541 + 1580.0,
		Capacity    = 1580.0,
		Cx_pil		= Cx_RP541,
		shape_table_data =
		{
			{
				name	= "M2KC_02_RPL541";
				file	= "M-2000C_02_RP541";
				life	= 1;
				fire	= { 0, 1};
				username	= "M2KC_02_RPL541";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	=
		{
			{
				ShapeName	= "M2KC_02_RPL541",
			},
		},
	}
)

declare_loadout(
	{
		category	= CAT_FUEL_TANKS,
		CLSID		= "{M2KC_02_RPL541_EMPTY}",
		name		= "M2KC_02_RPL541_EMPTY",
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("RPL 541 2000 liters Fuel Tank (Empty)"),
		Weight_Empty	= W_RP541,
		Weight		= W_RP541,	-- Tank starts empty
		Capacity    = 1580.0,
		Cx_pil		= Cx_RP541,
		shape_table_data =
		{
			{
				name	= "M2KC_02_RPL541_EMPTY";
				file	= "M-2000C_02_RP541";
				life	= 1;
				fire	= { 0, 1};
				username	= "M2KC_02_RPL541_EMPTY";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	=
		{
			{
				ShapeName	= "M2KC_02_RPL541",
			},
		},
	}
)

declare_loadout(
	{
		category	= CAT_FUEL_TANKS,
		CLSID		= "{M2KC_08_RPL541}",
		name		= "M2KC_08_RPL541",
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("RPL 541 2000 liters Fuel Tank "),
		Weight_Empty	= W_RP541,
		Weight		= W_RP541 + 1580.0,
		Capacity    = 1580.0,
		Cx_pil		= Cx_RP541,
		shape_table_data =
		{
			{
				name	= "M2KC_08_RPL541";
				file	= "M-2000C_08_RP541";
				life	= 1;
				fire	= { 0, 1};
				username	= "M2KC_08_RPL541";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	=
		{
			{
				ShapeName	= "M2KC_08_RPL541",
			},
		},
	}
)

declare_loadout(
	{
		category	= CAT_FUEL_TANKS,
		CLSID		= "{M2KC_08_RPL541_EMPTY}",
		name		= "M2KC_08_RPL541_EMPTY",
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("RPL 541 2000 liters Fuel Tank (Empty)"),
		Weight_Empty	= W_RP541,
		Weight		= W_RP541,	-- Tank starts empty
		Capacity    = 1580.0,
		Cx_pil		= Cx_RP541,
		shape_table_data =
		{
			{
				name	= "M2KC_08_RPL541_EMPTY";
				file	= "M-2000C_08_RP541";
				life	= 1;
				fire	= { 0, 1};
				username	= "M2KC_08_RPL541_EMPTY";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	=
		{
			{
				ShapeName	= "M2KC_08_RPL541",
			},
		},
	}
)

declare_loadout(
	{
		category	= CAT_FUEL_TANKS,
		CLSID		= "{M2KC_RPL_522}",
		name		= "M2KC_RPL_522",
		name		= "M2KC_RPL_522",
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("RPL 522 1300 liters Fuel Tank"),
		Weight_Empty	= W_RP522,
		Weight		= W_RP522 + 990.0,
		Capacity    = 990.0,
		Cx_pil		= Cx_RP522,
		shape_table_data =
		{
			{
				name	= "M2KC_RPL_522";
				file	= "M-2000C_05_RP522";
				life	= 1;
				fire	= { 0, 1};
				username	= "M2KC_RPL_522";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	=
		{
			{
				ShapeName	= "M2KC_RPL_522",
			},
		},
	}
)

declare_loadout(
	{
		category	= CAT_FUEL_TANKS,
		CLSID		= "{M2KC_RPL_522_EMPTY}",
		name		= "M2KC_RPL_522_EMPTY",
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("RPL 522 1300 liters Fuel Tank (Empty)"),
		Weight_Empty	= W_RP522,
		Weight		= W_RP522, -- Tank starts empty
		Capacity    = 990.0,
		Cx_pil		= Cx_RP522,
		shape_table_data =
		{
			{
				name	= "M2KC_RPL_522_EMPTY";
				file	= "M-2000C_05_RP522";
				life	= 1;
				fire	= { 0, 1};
				username	= "M2KC_RPL_522_EMPTY";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	=
		{
			{
				ShapeName	= "M2KC_RPL_522",
			},
		},
	}
)
