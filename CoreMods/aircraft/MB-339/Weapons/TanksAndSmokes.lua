--------------------------------------------------SMOKE SYSTEM-----------------------------------------------------------------
declare_loadout(
	{
		category		= CAT_PODS,
		CLSID			= "{SMOKE-WHITE-MB339}",
		Picture	= "fumo.png",
		PictureBlendColor= '0xffffffff',		
		displayName		= _("MB339 White Smoke"),
		
		attribute	=	{4,	15,	50,	WSTYPE_PLACEHOLDER},			
		Smoke  = {
			alpha = 180,
			r  = 255,
			g  = 255,
			b  = 255,
			dx = -1.455,
			dy = -0.062
		},
		
		shape_table_data = 
		{
			{
				name 	= "MB339_SMOKE-POD",
				file	= "MB339_SMOKE-POD";
				life	= 1;
				fire	= { 0, 1};
				username	= "SMOKE_WHITE_MB339";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Weight			= 1,
		Count 			= 1,
		Cx_pil			= 0.0,--0.001313754,
		Elements		={{
							ShapeName	=	"MB339_SMOKE-POD", 
							Position	=	{0,- 0.059317,0}, 
							DrawArgs	=	{[3] = {3,0.1}}
						}}
	}
)

declare_loadout(
	{
		category		= CAT_PODS,
		CLSID			= "{SMOKE-RED-MB339}",
		Picture	= "fumo.png",
		PictureBlendColor= '0xc81e1eff',	
		displayName		= _("MB339 Red Smoke"),
		
		attribute	=	{4,	15,	50,	WSTYPE_PLACEHOLDER},			
		Smoke  = {
			alpha = 220,
			r  = 255,
			g  = 14,
			b  = 14,
			dx = -1.455,
			dy = -0.062
		},
		
		shape_table_data = 
		{
			{
				name 	= "MB339_SMOKE-POD",
				file	= "MB339_SMOKE-POD";
				life	= 1;
				fire	= { 0, 1};
				username	= "SMOKE_RED_MB339";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Weight			= 1,
		Count 			= 1,
		Cx_pil			= 0.0,--0.001313754,
		Elements		={{
							ShapeName	=	"MB339_SMOKE-POD", 
							Position	=	{0,- 0.059317,0}, 
							DrawArgs	=	{[3] = {3,0.1}}
						}}
	}
)

declare_loadout(
	{
		category		= CAT_PODS,
		CLSID			= "{SMOKE-GREEN-MB339}",
		Picture	= "fumo.png",
		PictureBlendColor= '0x228b22ff',
		displayName		= _("MB339 Green Smoke"),
		
		attribute	=	{4,	15,	50,	WSTYPE_PLACEHOLDER},			
		Smoke  = {
			alpha = 220,
			r  = 13,
			g  = 165,
			b  = 60,
			dx = -1.455,
			dy = -0.062
		},
		
		shape_table_data = 
		{
			{
				name 	= "MB339_SMOKE-POD",
				file	= "MB339_SMOKE-POD";
				life	= 1;
				fire	= { 0, 1};
				username	= "SMOKE_GREEN_MB339";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Weight			= 1,
		Count 			= 1,
		Cx_pil			= 0.0,--0.001313754,
		Elements		={{
							ShapeName	=	"MB339_SMOKE-POD", 
							Position	=	{0,- 0.059317,0}, 
							DrawArgs	=	{[3] = {3,0.1}}
						}}
	}
)
-----------------------------------------SMOKE DIANA 61------------------------------------------------------
declare_loadout(
	{
		category		= CAT_PODS,
		CLSID			= "{SMOKE-BLACK-MB339}",
		Picture	= "fumo.png",
		PictureBlendColor= '0x000000ff',	
		displayName		= _("MB339 Black Smoke"),
		
		attribute	=	{4,	15,	50,	WSTYPE_PLACEHOLDER},			
		Smoke  = {
			alpha = 100,
			r  = 0,
			g  = 0,
			b  = 20,
			dx = -1.455,
			dy = -0.062
		},
		
		shape_table_data = 
		{
			{
				name 	= "MB339_SMOKE-POD",
				file	= "MB339_SMOKE-POD";
				life	= 1;
				fire	= { 0, 1};
				username	= "SMOKE_BLACK_MB339";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Weight			= 1,
		Count 			= 1,
		Cx_pil			= 0.0,--0.001313754,
		Elements		={{
							ShapeName	=	"MB339_SMOKE-POD", 
							Position	=	{0,- 0.059317,0}, 
							DrawArgs	=	{[3] = {3,0.1}}
						}}
	}
)

declare_loadout(
	{
		category		= CAT_PODS,
		CLSID			= "{SMOKE-ORANGE-MB339}",	--"{SMOKE-ORANGE-MB339}",
		Picture	= "fumo.png",
		PictureBlendColor= '0xfc9600ff',		
		displayName		= _("MB339 ORANGE Smoke"),
		
		attribute		=	{4,	15,	50,	WSTYPE_PLACEHOLDER},			
		Smoke  = {
			alpha = 180,
			r  = 255,
			g  = 108,
			b  = 0,
			dx = -1.455,
			dy = -0.062
		},
		
		shape_table_data = 
		{
			{
				name 	= "smoke-pod",
				file	= "smoke_pod";
				life	= 1;
				fire	= { 0, 1};
				username	= "SMOKE_ORANGE_MB339";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Weight			= 1,
		Count 			= 1,
		Cx_pil			= 0.0,--0.001313754,
		Elements		={{
							ShapeName	=	"smoke_pod", 
							Position	=	{0,- 0.059317,0}, 
							DrawArgs	=	{[3] = {3,0.1}}
						}}
	}
)

declare_loadout(
	{
		category		= CAT_PODS,
		CLSID			= "{SMOKE-YELLOW-MB339}",	--"{SMOKE-YELLOW-MB339}",
		Picture	= "fumo.png",
		PictureBlendColor= '0xffff00ff',		
		displayName		= _("MB339 YELLOW Smoke"),
		
		attribute		=	{4,	15,	50,	WSTYPE_PLACEHOLDER},			
		Smoke  = {
			alpha = 180,
			r  = 255,
			g  = 218,
			b  = 0,
			dx = -1.455,
			dy = -0.062
		},
		
		shape_table_data = 
		{
			{
				name 	= "smoke-pod",
				file	= "smoke_pod";
				life	= 1;
				fire	= { 0, 1};
				username	= "SMOKE_YELLOW_MB339";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Weight			= 1,
		Count 			= 1,
		Cx_pil			= 0.0,--0.001313754,
		Elements		={{
							ShapeName	=	"smoke_pod", 
							Position	=	{0,- 0.059317,0}, 
							DrawArgs	=	{[3] = {3,0.1}}
						}}
	}
)

--------------------------------------------END SMOKE DIANA 61--------------------------------------------------------------
--------------------------------------------------SMOKE SYSTEM-----------------------------------------------------------------
----------------TANICHE------------------------
-- declare_loadout(
	-- {
		-- category		 = CAT_FUEL_TANKS,
		-- CLSID			 = "{VOID-PYLON-MB339A}",
		-- attribute		 =  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		-- Picture			 = "void_pylon.png",
		-- displayName		 = _("Empty Pylon"),
		-- Weight_Empty	 = 20, -- kg
		-- Weight			 = 20, -- kg
		-- Cx_pil			 = 0.0003,
		-- shape_table_data = 
		-- {
			-- {
				-- name 	= "MB339_VOID",
				-- file	= "MB339_VOID";
				-- life	= 1;
				-- fire	= { 0, 1};
				-- username	= "VOID_PYLON_MB339A";
				-- index	= WSTYPE_PLACEHOLDER;
			-- },
		-- },
		-- Elements		={{
							-- ShapeName	=	"MB339_VOID", 		
						-- }}
	-- }						
-- )
--[[
declare_loadout(
	{
		category		 = CAT_SERVICE,
		CLSID			 = "{VOID-PYLON-MB339A}",
		attribute		 =  {0,0,0,0},
		Picture			 = "void_pylon.png",
		displayName		 = _("Empty Pylon"),
		Weight_Empty	 = 0, -- kg
		Weight			 = 23, -- kg
		Cx_pil			 = 0.00025,
		shape_table_data = 
		{
			{
				name 	= "MB339_VOID",
				file	= "MB339_VOID";
				life	= 1;
				fire	= { 0, 1};
				username	= "VOID_PYLON_MB339A";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements		={{
							ShapeName	=	"MB339_VOID", 		
						}}
	}						
)
]]
-------------------------------------------------------------------------------------------------------

declare_loadout(
	{
		category		 = CAT_FUEL_TANKS,
		CLSID			 = "{COLOR-TANK}",
		attribute		 =  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture			 = "smoke_tank.png",
		displayName		 = _("Color Oil Tank"),
		Weight_Empty	 = 33 , -- kg
		Weight			 = 132.5, -- kg
		Cx_pil			 = 0.00055,
		shape_table_data = 
		{
			{
				name	= "oiltank",
				file	= "oiltank";
				life	= 1;
				fire	= { 0, 1};
				username	= "FUEL_SMOKE_MISTI__U";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements		={{
							ShapeName	=	"oiltank", 		
						}}
	}						
)

declare_loadout(
	{
		category		 = CAT_FUEL_TANKS,
		CLSID			 = "{WHITE-TANK}",
		attribute		 =  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture			 = "smoke_tank.png",
		displayName		 = _("White Oil Tank"),
		Weight_Empty	 = 33 , -- kg
		Weight			 = 132.5, -- kg
		Cx_pil			 = 0.00055,
		shape_table_data = 
		{
			{
				name	= "oiltank",
				file	= "oiltank";
				life	= 1;
				fire	= { 0, 1};
				username	= "FUEL_SMOKE_BIANCHI__U";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements		={{
							ShapeName	=	"oiltank", 		
						}}
	}						
)


declare_loadout(
	{
		category		 = CAT_FUEL_TANKS,
		CLSID			 = "{FUEL-SUBAL_TANK-330}",	
		attribute		 =  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture			 = "tank_330.png",
		displayName		 = _("Fuel Tank 330lt"),
		Weight_Empty	 = 50, -- kg
		Weight			 = 315, -- kg
		Cx_pil			 = 0.00045,
		shape_table_data = 
		{
			{
				name 	= "MB339_FT330",
				file	= "MB339_FT330";
				life	= 1;
				fire	= { 0, 1};
				username	= "FUEL_SUB_TANK_330_U";	
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements		={{
							ShapeName	=	"MB339_FT330", 		
						}}
	}						
)

declare_loadout(
	{
		category		 = CAT_FUEL_TANKS,
		CLSID			 = "{FUEL-TIP-TANK-500-L}",
		attribute		 =  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture			 = "tip_L.png",
		displayName		 = _("Cylindrical Tip Tank 500lt"),
		Weight_Empty	 = 70, -- kg
		Weight			 = 471, -- kg
		Cx_pil			 = 0.0003,
		shape_table_data = 
		{
			{
				name 	= "MB339_TT500_L",
				file	= "MB339_TT500_L";
				life	= 1;
				fire	= { 0, 1};
				username	= "FUEL_TIP_TANK_500_L";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements		={{
							ShapeName	=	"MB339_TT500_L", 		
						}}
	}						
)

declare_loadout(
	{
		category		 = CAT_FUEL_TANKS,
		CLSID			 = "{FUEL-TIP-TANK-500-R}",
		attribute		 =  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture			 = "tip_R.png",
		displayName		 = _("Cylindrical Tip Tank 500lt"),
		Weight_Empty	 = 70, -- kg
		Weight			 = 471, -- kg
		Cx_pil			 = 0.0003,
		shape_table_data = 
		{
			{
				name 	= "MB339_TT500_R",
				file	= "MB339_TT500_R";
				life	= 1;
				fire	= { 0, 1};
				username	= "FUEL_TIP_TANK_500_R";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements		={{
							ShapeName	=	"MB339_TT500_R", 		
						}}
	}						
)


declare_loadout(
	{
		category		 = CAT_FUEL_TANKS,
		CLSID			 = "{FUEL-TIP-ELLITTIC-L}",
		attribute		 =  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture			 = "ellittici.png",
		displayName		 = _("Elliptic Tip Tank 320lt"),
		Weight_Empty	 = 55, -- kg
		Weight			 = 55+(320*0.81), -- kg
		Cx_pil			 = 0.00012,
		shape_table_data = 
		{
			{
				name 	= "MB339_TT320_L",
				file	= "MB339_TT320_L";
				life	= 1;
				fire	= { 0, 1};
				username	= "FUEL-TIP-ELLITTIC-L";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements		={{
							ShapeName	=	"MB339_TT320_L", 		
						}}
	}						
)


declare_loadout(
	{
		category		 = CAT_FUEL_TANKS,
		CLSID			 = "{FUEL-TIP-ELLITTIC-R}",
		attribute		 =  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture			 = "ellittici.png",
		displayName		 = _("Elliptic Tip Tank 320lt"),
		Weight_Empty	 = 55, -- kg
		Weight			 = 55+(320*0.81), -- kg
		Cx_pil			 = 0.00012,
		shape_table_data = 
		{
			{
				name 	= "MB339_TT320_R",
				file	= "MB339_TT320_R";
				life	= 1;
				fire	= { 0, 1};
				username	= "FUEL-TIP-ELLITTIC-R";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements		={{
							ShapeName	=	"MB339_TT320_R", 		
						}}
	}						
)
