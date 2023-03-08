--/N/ dimovi
local alpha_master = 85 --127,--/N/ 255 - totally opaque
local dir_X = -0.6
local dir_Y = -1.0
local picture_common = "CE2_smoke_oil_canister.png"

-- go to http://www.rapidtables.com/web/color/RGB_Color.htm to pick your color

declare_loadout(
	{		
		category			= CAT_PODS,
		CLSID				= "{CE2_SMOKE_WHITE}",
		attribute			= {wsType_Weapon, wsType_GContainer, wsType_Smoke_Cont, WSTYPE_PLACEHOLDER},
		Count				= 1,
		Picture				= picture_common,
		displayName			= _("Smoke for Christen Eagle II, white"),
		Weight				= 7,
		Cx_pil				= 0.00001,
		
		Elements			={
		},
		
		Smoke = {
            alpha = alpha_master * 2.0,
            r = 255,
            g = 255,
            b = 255,
            dx = dir_X,
            dy = dir_Y,
        },
	}
)

--[[
declare_loadout(
		{		
		category			= CAT_PODS,
		CLSID				= "{CE2_SMOKE_GRAY}",
		attribute			= {wsType_Weapon, wsType_GContainer, wsType_Smoke_Cont, WSTYPE_PLACEHOLDER},
		Count				= 1,
		Picture				= picture_common,
		displayName			= _("Smoke - gray"),
		Weight				= 7,
		Cx_pil				= 0.00001,
		
		Elements			={
		},
		
		Smoke = {
            alpha = alpha_master * 1.5,
            r = 220,
            g = 220,
            b = 220,
            dx = dir_X,
            dy = dir_Y,
        },
	}
)

declare_loadout(
		{		
		category			= CAT_PODS,
		CLSID				= "{CE2_SMOKE_SILVER}",
		attribute			= {wsType_Weapon, wsType_GContainer, wsType_Smoke_Cont, WSTYPE_PLACEHOLDER},
		Count				= 1,
		Picture				= picture_common,
		displayName			= _("Smoke - silver"),
		Weight				= 7,
		Cx_pil				= 0.00001,
		
		Elements			={
		},
		
		Smoke = {
            alpha = alpha_master * 1.5,
            r = 240,
            g = 240,
            b = 220,
            dx = dir_X,
            dy = dir_Y,
        },
	}
)

declare_loadout(
		{		
		category			= CAT_PODS,
		CLSID				= "{CE2_SMOKE_CRIMSON}",
		attribute			= {wsType_Weapon, wsType_GContainer, wsType_Smoke_Cont, WSTYPE_PLACEHOLDER},
		Count				= 1,
		Picture				= picture_common,
		displayName			= _("Smoke - crimson"),
		Weight				= 7,
		Cx_pil				= 0.00001,
		
		Elements			={
		},
		
		Smoke = {
            alpha = alpha_master * 1.5,
            r = 236,
            g = 25,
            b = 39,
            dx = dir_X,
            dy = dir_Y,
        },
	}
)

declare_loadout(
		{		
		category			= CAT_PODS,
		CLSID				= "{CE2_SMOKE_STEELBLUE}",
		attribute			= {wsType_Weapon, wsType_GContainer, wsType_Smoke_Cont, WSTYPE_PLACEHOLDER},
		Count				= 1,
		Picture				= picture_common,
		displayName			= _("Smoke - blue"),
		Weight				= 7,
		Cx_pil				= 0.00001,
		
		Elements			={
		},
		
		Smoke = {
            alpha = alpha_master * 1.5,
            r = 63,
            g = 129,
            b = 179,
            dx = dir_X,
            dy = dir_Y,
        },
	}
)

declare_loadout(
		{		
		category			= CAT_PODS,
		CLSID				= "{CE2_SMOKE_SEAGREEN}",
		attribute			= {wsType_Weapon, wsType_GContainer, wsType_Smoke_Cont, WSTYPE_PLACEHOLDER},
		Count				= 1,
		Picture				= picture_common,
		displayName			= _("Smoke - green"),
		Weight				= 7,
		Cx_pil				= 0.00001,
		
		Elements			={
		},
		
		Smoke = {
            alpha = alpha_master * 1.5,
            r = 55,
            g = 172,
            b = 83,
            dx = dir_X,
            dy = dir_Y,
        },
	}
)

]]