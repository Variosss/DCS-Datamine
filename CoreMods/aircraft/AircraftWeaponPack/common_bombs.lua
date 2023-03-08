-- Bomb pylons' parameters
local BPylonData = {
	CLB4 = {
		attribute		= {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER},
		category		= CAT_BOMBS,
		Count			= 4,
		Cx_pil			= 0.011 / 25,
		displayNamePfx	= "CLB 4 - 4 x ",
		modelFileName	= "CLB_4",
		Weight_Empty	= 183,
	},
	CLB30 = {
		attribute		= {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER},
		category		= CAT_BOMBS,
		Count			= 1,
		Cx_pil			= 0.003 / 25,
		displayNamePfx	= "CLB 30 - ",
		modelFileName	= "CLB_30",
		Weight_Empty	= 45,
	},
}

local function Mk_bomb(main, warhead, picture, clsid)
	local t = main

	t.category			= CAT_BOMBS
	t.wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER}
	t.type				= 0
	t.hMin				= 100.0
	t.hMax				= 10000.0
	t.VyHold			= -100.0
	t.Ag      			= -1.23

	t.shape_table_data =
	{
		{
			name     = t.name,
			file     = t.model,
			life     = 1,
			fire     = {0, 1},
			username = t.user_name,
			index    = WSTYPE_PLACEHOLDER,
		},
	}

	t.warhead = warhead

	return t
end

local function Mk_82(main, warhead, picture, clsid)

	local t = Mk_bomb(main, warhead, picture, clsid)

	t.mass				= 228.0
	t.Cx				= 0.00025
	t.scheme			= "bomb-common"
	t.class_name		= "wAmmunition"

	t.fm =
	{
		mass            = 228.0,
		caliber         = 0.273,
		cx_coeff        = {1.0, 0.29, 0.71, 0.14, 1.28},
		L               = 2.21,
		I               = 94.425933,
		Ma              = 2.746331,
		Mw              = 2.146083,
		wind_time       = 1000.0,
		wind_sigma      = 80.0
	}

	t.targeting_data =
	{
		char_time = 20.32
	}

	declare_weapon(t)

	declare_loadout({
		category 		= CAT_BOMBS,
		CLSID	 		= clsid,
		attribute		= t.wsTypeOfWeapon,
		Count 			= 1,
		Cx_pil			= t.Cx,
		Picture			= picture,
		displayName		= t.user_name,
		Weight			= t.mass,
		Elements  		= {{ShapeName = t.model}},
	})

	return t
end

local function Mk_83(main, warhead, picture, clsid)

	local t = Mk_bomb(main, warhead, picture, clsid)

	t.mass				= 454.0
	t.Cx				= 0.00035
	t.scheme			= "bomb-common"
	t.class_name		= "wAmmunition"

	t.fm =
	{
		mass		= 454.0,
		caliber		= 0.356,
		cx_coeff	= {1.0, 0.29, 0.71, 0.13, 1.28},
		L			= 3.0,
		I			= 340.5,
		Ma			= 2.746331,
		Mw			= 2.146083,
		wind_time	= 1000.0,
		wind_sigma	= 150.0,
	}

	t.targeting_data =
	{
		char_time = 20.32
	}

	declare_weapon(t)

	declare_loadout({
		category 		= CAT_BOMBS,
		CLSID	 		= clsid,
		attribute		= t.wsTypeOfWeapon,
		Count 			= 1,
		Cx_pil			= t.Cx,
		Picture			= picture,
		displayName		= t.user_name,
		Weight			= t.mass,
		Elements  		= {{ShapeName = t.model}},
	})

	return t
end

local function Mk_84(main, warhead, picture, clsid)

	local t = Mk_bomb(main, warhead, picture, clsid)

	t.mass				= 908.0
	t.Cx				= 0.00056
	t.scheme			= "bomb-common"
	t.class_name		= "wAmmunition"

	t.fm =
	{
		mass		= 908.0,
		caliber		= 0.457,
		cx_coeff	= {1.0, 0.39, 0.6, 0.168, 1.31},
		L			= 2.5,
		I			= 864.446267,
		Ma			= 2.746331,
		Mw			= 2.146083,
		wind_time	= 1000.0,
		wind_sigma	= 220.0,
	}

	t.targeting_data =
	{
		char_time = 20.32
	}

	declare_weapon(t)

	declare_loadout({
		category 		= CAT_BOMBS,
		CLSID	 		= clsid,
		attribute		= t.wsTypeOfWeapon,
		Count 			= 1,
		Cx_pil			= t.Cx,
		Picture			= picture,
		displayName		= t.user_name,
		Weight			= t.mass,
		Elements  		= {{ShapeName = t.model}},
	})

	return t
end

local function Mk_Air(main, warhead, picture, clsid)

	local t = Mk_bomb(main, warhead, picture, clsid)

	t.scheme			= "bomb-parashute"
	t.class_name		= "wAmmunitionBallute"

	declare_weapon(t)

	declare_loadout({
		category 		= CAT_BOMBS,
		CLSID	 		= clsid,
		attribute		= t.wsTypeOfWeapon,
		Count 			= 1,
		Cx_pil			= t.Cx,
		Picture			= picture,
		displayName		= t.user_name,
		Weight			= t.mass,
		Elements  		= {{ShapeName = t.model}},
	})
	return t
end

local function create_BRD_4_250(bomb_shape, bomb_mass, tbl)
	local elements = {}

	tbl.category = CAT_PODS
	tbl.Picture = "BRD-4-250.png"
	tbl.attribute = {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER}
	tbl.Cx_pil = 0.002
	tbl.Count = 4
	tbl.Weight = 86 + 4 * bomb_mass
	tbl.JettisonSubmunitionOnly = false
	tbl.kind_of_shipping = 1

	table.insert(elements, { ShapeName = "BRD-4-250", IsAdapter = true })
	for i = 1, 4 do
		table.insert(elements, { ShapeName = bomb_shape, connector_name =  "Point"..string.format("%02d", i)})
	end

	tbl.Elements = elements

	return tbl
end

local function create_ThomBran_MER(mer_shape, bomb_shape, bomb_mass, stackHeight, tbl)
	local elements = {}

	tbl.category				= CAT_BOMBS
	tbl.attribute				= {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER}
	tbl.Cx_pil					= 0.00045
	tbl.JettisonSubmunitionOnly	= true
	tbl.kind_of_shipping		= 1
	tbl.ejectImpulse			= 500

	if mer_shape == "14-3-M2" then
		tbl.Count = 3 * stackHeight -- stackWidth * stackHeight
		tbl.Weight = 62.5 + tbl.Count * bomb_mass
	elseif mer_shape == "30-6-M2" then
		tbl.Count = 2 * 3 * stackHeight -- stack quantity * stackWidth * stackHeight
		tbl.Weight = 150 + tbl.Count * bomb_mass
	end

	table.insert(elements, { ShapeName = mer_shape, IsAdapter = true })
	for i = 1, math.min(3, stackHeight) do -- here we attach bombs to each AdapterPoint (L[F/R], C[F/R], R[F/R] [1; stackHeight])
		for _, horPosition in ipairs({"L", "C", "R"}) do
			if mer_shape == "14-3-M2" then
				table.insert(elements, { ShapeName = bomb_shape, connector_name = "AdapterPoint_"..horPosition..i })
			elseif mer_shape == "30-6-M2" then
				for _, latPosition in ipairs({"F", "R"}) do
					table.insert(elements, { ShapeName = bomb_shape, connector_name = "AdapterPoint_"..horPosition..latPosition..i })
				end
			end
		end
	end

	tbl.displayName	= mer_shape .. " - " .. tbl.Count .. " x " .. tbl.displayName
	tbl.Elements	= elements
	tbl.Cx_pil		= tbl.Cx_pil + tbl.Count * tbl.Cx

	return tbl
end

--[[
Mk_82({name = "Mk_82B",		model = "mk-82", user_name= _("Mk-82B")},	predefined_warhead("BDU"),		"mk82.png", "{Mk_82B}")
Mk_82({name = "Mk_82YT",	model = "mk-82", user_name= _("Mk-82YT")},	predefined_warhead("BDU"),		"mk82.png", "{Mk_82YT}")
Mk_82({name = "Mk_82BT",	model = "mk-82", user_name= _("Mk-82BT")},	predefined_warhead("Mk_82"),	"mk82.png", "{Mk_82BT}")
Mk_82({name = "Mk_82P",		model = "mk-82", user_name= _("Mk-82P")},	predefined_warhead("Mk_82P"),	"mk82.png", "{Mk_82P}")
Mk_82({name = "Mk_82PT",	model = "mk-82", user_name= _("Mk-82PT")},	predefined_warhead("Mk_82P"),	"mk82.png", "{Mk_82PT}")
Mk_82({name = "Mk_82SB",	model = "mk-82", user_name= _("Mk-82SB")},	predefined_warhead("Mk_82"),	"mk82.png", "{Mk_82SB}")
Mk_82({name = "Mk_82SP",	model = "mk-82", user_name= _("Mk-82SP")},	predefined_warhead("Mk_82"),	"mk82.png", "{Mk_82SP}")

Mk_83({name = "Mk_83BT",	model = "mk-83", user_name= _("Mk-83BT")},	predefined_warhead("Mk_83"),	"mk83.png", "{Mk_83BT}")
Mk_83({name = "Mk_83P",		model = "mk-83", user_name= _("Mk-83P")},	predefined_warhead("Mk_83P"),	"mk83.png", "{Mk_83P}")
Mk_83({name = "Mk_83PT",	model = "mk-83", user_name= _("Mk-83PT")},	predefined_warhead("Mk_83P"),	"mk83.png", "{Mk_83PT}")

Mk_84({name = "Mk_84T",		model = "mk-84",	user_name= _("Mk-84T")},	predefined_warhead("Mk_84"),	"mk84.png", "{Mk_84T}")
Mk_84({name = "Mk_84P",		model = "mk-84",	user_name= _("Mk-84P")},	predefined_warhead("Mk_84P"),	"mk84.png", "{Mk_84P}")
]]

MK_82Y = Mk_Air({
	name		= "Mk_82Y",
	model		= "mk-82air",
	user_name	= _("Mk-82Y - 500lb GP Chute Retarded HD"),

	mass		= 232,
	Cx			= 0.00035,
	Reflection	= 0.035,

	fm = {
		mass		= 232,
		caliber		= 0.273,
		cx_coeff	= {1, 0.29, 0.71, 0.14, 1.28},
		L			= 2.21,
		I			= 94.42593,
		cx_factor	= 100,
		wind_time	= 1000,
		wind_sigma	= 8,
	},

	control = {
		open_delay	= 0.2,
	},

	targeting_data = {
		char_time = 20.31,		--* OK
		chute_char_time = 33.5,	--* OK
		chute_open_time = 0.2,
	}

}, predefined_warhead("Mk_82"), "mk82AIR.png", "{Mk_82Y}")

Mk_Air({
	name		= "Mk_83CT",
	model		= "mk-82air",
	user_name	= _("Mk-83CT"),

	mass = 454,
	Cx	= 0.00035,

	fm = {
		mass		= 454,
		caliber		= 0.356,
		cx_coeff	= {1, 0.29, 0.71, 0.14, 1.28},
		L			= 3,
		I			= 340.5,
		Ma			= 0.42,
		Mw			= 1.42,
		wind_time	= 1000,
		wind_sigma	= 8,
		cx_factor	= 100,
	},

	control = {
		open_delay = 0.2,
	},

	targeting_data = {
		char_time = 20.3,		--* OK
		chute_char_time = 32.5,	--* OK
		chute_open_time = 0.2,
	}
}, predefined_warhead("Mk_83"), "mk82AIR.png", "{Mk_83CT}")

local function Mk_Smoke(main, warhead, picture, clsid)

	local t = Mk_bomb(main, warhead, picture, clsid)

	t.scheme			= "bomb-smoke"
	t.class_name		= "wAmmunitionFuzeCtrl"

	declare_weapon(t)

	declare_loadout({
		category 		= CAT_BOMBS,
		CLSID	 		= clsid,
		attribute		= t.wsTypeOfWeapon,
		Count 			= 1,
		Cx_pil			= t.Cx,
		Picture			= picture,
		displayName		= t.displayName or t.user_name,
		Weight			= t.mass,
		Elements  		= {{ShapeName = t.model}},
	})

	return t
end

local function Mk_Air_Smoke(main, warhead, picture, clsid)

	local t = Mk_bomb(main, warhead, picture, clsid)

	t.scheme			= "bomb-parashute-smoke"
	t.class_name		= "wAmmunitionBallute"

	declare_weapon(t)

	declare_loadout({
		category 		= CAT_BOMBS,
		CLSID	 		= clsid,
		attribute		= t.wsTypeOfWeapon,
		Count 			= 1,
		Cx_pil			= t.Cx,
		Picture			= picture,
		displayName		= t.displayName or t.user_name,
		Weight			= t.mass,
		Elements  		= {{ShapeName = t.model}},
	})
	return t
end

BDU45_WARHEAD =
{
	mass					= 0,
	expl_mass				= 0,
	piercing_mass			= 0,
	other_factors			= { 0.0, 0.0, 0.0 },
	obj_factors				= { 0.0, 0.0 },
	concrete_factors		= { 0.0, 0.0, 0.0 },
	cumulative_factor		= 0.0,
	concrete_obj_factor		= 0.0,
	cumulative_thickness	= 0.0,

	transparency	= 0.5,
	color			= {2, 2, 2},
	intensity		= 10,
	duration		= 300,
	flare   		= false,
}

BDU_45 = Mk_Air_Smoke(
{
	name		= "BDU_45",
	model		= "mk-82_snakeye_inert",
	user_name	= _("BDU-45"),
	displayName	= _("BDU-45 - 500lb Practice Bomb"),

	encyclopediaAnimation = {
		args = {
			[0] = 1,	-- safity switch lanyard
			[19] = 1,	-- tail spread
		},
	},

	mass		= 232,
	Cx			= 0.00035,

	fm = {
		mass		= 232,
		caliber		= 0.273,
		cx_coeff	= {1, 0.29, 0.71, 0.14, 1.28},
		L			= 2.21,
		I			= 94.42593,
		cx_factor	= 100,
		wind_time	= 1000,
		wind_sigma	= 8,
	},

	control = {
		open_delay = 0.2,
	},

	targeting_data = {
		char_time = 20.3,		--* OK
		chute_char_time = 34.5,	--* OK
		chute_open_time = 0.2,
	}
}, BDU45_WARHEAD, "mk82AIR.png", "{BDU_45}")

BDU_45B = Mk_Smoke(
{
	name		= "BDU_45B",
	model		= "BDU_45B",
	user_name	= _("BDU-45B"),
	displayName	=  _("BDU-45B - 500lb Practice Bomb"),

	mass		= 232.0,
	Cx			= 0.00035,

	fm =
	{
		mass		= 232.0,
		caliber		= 0.273,
		cx_coeff	= {1.0, 0.29, 0.71, 0.14, 1.28},
		L			= 2.21,
		I			= 94.42593,
		cx_factor	= 100.0,
		wind_time	= 1000.0,
		wind_sigma	= 8.0,
	},

	targeting_data =
	{
		char_time = 20.32,
	},

}, BDU45_WARHEAD, "mk82.png", "{BDU_45B}")


bombs_data =
{
	["MK-82"]			= {name = _("Mk-82 - 500lb GP Bomb LD"),			mass = 228, wsType = {4, 5, 9, 31},  Cx = 0.00025, picture = "mk82.png"},
	["MK-82_Snakeye"]	= {name = _("Mk-82 Snakeye - 500lb GP Bomb HD"),	mass = 249.5, wsType = {4, 5, 9, 79},  Cx = 0.00035, picture = "mk82AIR.png"},
	["MK-82Y"]			= {name = _("Mk-82Y - 500lb GP Chute Retarded HD"), mass = 232, wsType = MK_82Y.wsTypeOfWeapon,  Cx = 0.00035, picture = "mk82AIR.png"},
	["MK-82AIR"]		= {name = _("Mk-82 AIR Ballute - 500lb GP Bomb HD"), mass = 242, wsType = {4, 5, 9, 75},  Cx = 0.00035, picture = "mk82AIR.png"},
	["ROCKEYE"]			= {name = _("Mk-20 Rockeye - 490lbs CBU, 247 x HEAT Bomblets"),	mass = 222, wsType = {4, 5, 38, 45}, Cx = 0.000413, picture = "Mk20.png"},
	["BDU-33"]			= {name = _("BDU-33 - 25lb Practice Bomb LD"),			mass = 11.3, wsType = {4, 5, 9, 69}, Cx = 0.00025, picture = "bdu-33.png"},
	["MK-83"] 			= {name = _("Mk-83 - 1000lb GP Bomb LD"), 			mass = 454, wsType = {4, 5, 9, 32}, Cx = 0.00035, picture = "mk83.png"},
	["GBU-12"] 			= {name = _("GBU-12 - 500lb Laser Guided Bomb"), 		mass = 277, wsType = {4, 5, 36, 38}, Cx = 0.000413, picture = "GBU12.png"},
	["GBU-16"] 			= {name = _("GBU-16 - 1000lb Laser Guided Bomb"), 		mass = 513, wsType = {4, 5, 36, 39}, Cx = 0.000413, picture = "GBU16.png"},
	["GBU-31"] 			= {name = _("GBU-31"), 		mass = 934, wsType = {4, 5,	36,	85}, Cx = 0.000413, picture = "GBU31.png"},
	["GBU-31V"] 		= {name = _("GBU-31(V)3/B - JDAM, 2000lb GPS Guided Bomb"), 		mass = 981, wsType = {4, 5,	36,	92}, Cx = 0.000413, picture = "GBU-31V3B.png"},
	["GBU-38"] 			= {name = _("GBU-38 - JDAM, 500lb GPS Guided Bomb"), 		mass = 241, wsType = {4, 5,	36,	86}, Cx = 0.00035, picture = "GBU38.png"},
	["BDU-45"]			= {name = _("BDU-45 - 500lb Practice Bomb"),			mass = 232, wsType = BDU_45.wsTypeOfWeapon,  Cx = 0.00035, picture = "mk82AIR.png"},
	["BDU-45B"]			= {name = _("BDU-45B - 500lb Practice Bomb"),			mass = 232, wsType = BDU_45B.wsTypeOfWeapon,  Cx = 0.00025, picture = "mk82.png"},
}

local function bru_33_2x_bombs(element)
	local bomb_variant = bombs_data[element] or bombs_data["MK-82"]
	local data = {
		category		=	CAT_BOMBS,
		CLSID			=	"{BRU33_2X_"..element.."}",
		Picture			=	bomb_variant.picture,
		wsTypeOfWeapon	=	bomb_variant.wsType,
		displayName		=  _("BRU-33 with 2 x ")..bomb_variant.name,
		attribute		=	{wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
		Cx_pil			=	0.00244140625 + bomb_variant.Cx,		-- TODO
		Count			=	2,
		Weight			=	bru_33VER_mass + 2 * bomb_variant.mass,			-- TODO
		Elements		= {	{ShapeName	= "BRU_33A",	IsAdapter  	   = true},
							{ShapeName	= element,		connector_name = "Point02"},
							{ShapeName	= element,		connector_name = "Point01"}
		}, -- end of Elements
	}
	declare_loadout(data)
end

bru_33_2x_bombs("MK-82")					-- {BRU33_2X_MK-82}
bru_33_2x_bombs("MK-82_Snakeye")			-- {BRU33_2X_MK-82_Snakeye}
bru_33_2x_bombs("MK-82Y")					-- {BRU33_2X_MK-82Y}
bru_33_2x_bombs("BDU-45")					-- {BRU33_2X_BDU-45}
bru_33_2x_bombs("BDU-45B")					-- {BRU33_2X_BDU-45B}
bru_33_2x_bombs("ROCKEYE")					-- {BRU33_2X_ROCKEYE}
bru_33_2x_bombs("MK-83")					-- {BRU33_2X_MK-83}
bru_33_2x_bombs("GBU-12")					-- {BRU33_2X_GBU-12}
bru_33_2x_bombs("GBU-16")					-- {BRU33_2X_GBU-16}

local function bru_55_with_2x(element)
	local bomb_variant = bombs_data[element] or bombs_data["GBU-38"]
	local data = {
		category		=	CAT_BOMBS,
		CLSID			=	"{BRU55_2*"..element.."}",
		Picture			=	bomb_variant.picture,
		wsTypeOfWeapon	=	bomb_variant.wsType,
		displayName		=  _("BRU-55 with 2 x ")..bomb_variant.name,
		attribute		=	{wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
		Cx_pil			=	0.00244140625 + 2*bomb_variant.Cx,		-- TODO
		Count			=	2,
		Weight			=	bru_33VER_mass + 2*bomb_variant.mass,			-- TODO
		Elements		= {	{ShapeName	= "BRU_55",	IsAdapter  	   = true},
							{ShapeName	= element,		connector_name = "Point02"},
							{ShapeName	= element,		connector_name = "Point01"}
		}, -- end of Elements
	}
	declare_loadout(data)
end

bru_55_with_2x("GBU-38")					-- {BRU55_2*GBU-38}

local function bru_57_with_2x(element)
	local bomb_variant = bombs_data[element] or bombs_data["GBU-38"]
	local data = {
		category		=	CAT_BOMBS,
		CLSID			=	"{BRU57_2*"..element.."}",
		Picture			=	bomb_variant.picture,
		wsTypeOfWeapon	=	bomb_variant.wsType,
		displayName		=  _("BRU-57 with 2 x ")..bomb_variant.name,
		attribute		=	{wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
		Cx_pil			=	0.00244140625 + 2*bomb_variant.Cx,		-- TODO
		Count			=	2,
		Weight			=	bru_33VER_mass + 2*bomb_variant.mass,			-- TODO
		Elements		= {	{ShapeName	= "BRU_57",	IsAdapter  	   = true},
							{ShapeName	= element,		connector_name = "Point02"},
							{ShapeName	= element,		connector_name = "Point01"}
		}, -- end of Elements
	}
	declare_loadout(data)
end

bru_57_with_2x("GBU-38")					-- {BRU57_2*GBU-38}

local function MER_BRU_41A_Bombs(element)
	local bomb_variant = bombs_data[element] or bombs_data["MK-82"]

	local attach_point_position = element_self_attach_point[element]
	local data = {
		category		=	CAT_BOMBS,
		CLSID			=	"{BRU41_6X_"..element.."}",
		Picture			=	bomb_variant.picture,
		wsTypeOfWeapon	=	bomb_variant.wsType,
		displayName		=  _("BRU-41A with 6 x ")..bomb_variant.name,
		attribute		=	{wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
		Cx_pil			=	bomb_variant.Cx,		-- TODO
		Count			=	6,
		Weight			=	bru_41MER_mass + 6 * bomb_variant.mass,			-- TODO
		Elements		= {	{ShapeName	= "BRU_41A",	IsAdapter  	   = true},
							{ShapeName	= element,		connector_name = "Point02" ,attach_point_position = attach_point_position },
							{ShapeName	= element,		connector_name = "Point01" ,attach_point_position = attach_point_position },
							{ShapeName	= element,		connector_name = "Point05" ,attach_point_position = attach_point_position },
							{ShapeName	= element,		connector_name = "Point06" ,attach_point_position = attach_point_position },
							{ShapeName	= element,		connector_name = "Point03" ,attach_point_position = attach_point_position },
							{ShapeName	= element,		connector_name = "Point04" ,attach_point_position = attach_point_position }
		}, -- end of Elements
	}
	declare_loadout(data)
end


MER_BRU_41A_Bombs("MK-82")					-- {BRU41_6X_MK-82}
MER_BRU_41A_Bombs("BDU-33")					-- {BRU41_6X_BDU-33}

-- TER-9/A with bombs
local function ter_9a_bombs(element_, isFull, isLeft)
	local bomb_variant = bombs_data[element_] or bombs_data["MK-82"]
	local count_
	local elements_ = {}
	local side_
	if isFull then
		count_ = 3
		elements_ = ter_9a_three(element_)
		side_ = ""
	elseif isLeft then
		count_ = 2
		elements_ = ter_9a_two_left(element_)
		side_ = "L"
	else
		count_ = 2
		elements_ = ter_9a_two_right(element_)
		side_ = "R"
	end

	local data = {
		category		=	CAT_BOMBS,
		CLSID			=	"{TER_9A_"..count_..side_.."*"..element_.."}",
		Picture			=	bomb_variant.picture,
		wsTypeOfWeapon	=	bomb_variant.wsType,
		displayName		=  _("TER-9A with ")..count_.." x "..bomb_variant.name,
		attribute		=	{wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
		Cx_pil			=	0.00045 + count_ * bomb_variant.Cx,
		Count			=	count_,
		Weight			=	ter_9a_mass + count_ * bomb_variant.mass,			-- TODO
		Elements		= 	elements_,
	}
	declare_loadout(data)
end

ter_9a_bombs("MK-82", false, true)						-- {TER_9A_2L*MK-82}
ter_9a_bombs("MK-82", false, false)						-- {TER_9A_2R*MK-82}
ter_9a_bombs("MK-82", true)								-- {TER_9A_3*MK-82}
ter_9a_bombs("MK-82_Snakeye", false, true)				-- {TER_9A_2L*MK-82_Snakeye}
ter_9a_bombs("MK-82_Snakeye", false, false)				-- {TER_9A_2R*MK-82_Snakeye}
ter_9a_bombs("MK-82_Snakeye", true)						-- {TER_9A_3*MK-82_Snakeye}
ter_9a_bombs("MK-82AIR", false, true)					-- {TER_9A_2L*MK-82AIR}
ter_9a_bombs("MK-82AIR", false, false)					-- {TER_9A_2R*MK-82AIR}
ter_9a_bombs("MK-82AIR", true)							-- {TER_9A_3*MK-82AIR}
ter_9a_bombs("GBU-12", false, true)						-- {TER_9A_2L*GBU-12}
ter_9a_bombs("GBU-12", false, false)					-- {TER_9A_2R*GBU-12}
ter_9a_bombs("BDU-33", true)							-- {TER_9A_3*BDU-33}

-- MBD3-U6 FABs
local mbd3_u6_conn =
{
	[1] = {Position = {-0.986625, -0.360123, -0.000000}  , Rotation = { 0,0,0} },-- задний нижний
	[2] = {Position = { 0.898015, -0.360123, -0.000000}  , Rotation = { 0,0,0} },-- головной нижний
	[3] = {Position = {-0.986493, -0.122812, -0.160811}  , Rotation = { 40,0,0} },-- задний левый
	[4] = {Position = {-0.986493, -0.124806,  0.159743}  , Rotation = {-40,0,0} },-- задний правый
	[5] = {Position = { 0.898147, -0.122812, -0.160811}  , Rotation = { 40,0,0} },-- головной левый
	[6] = {Position = { 0.898147, -0.124806,  0.159743}  , Rotation = {-40,0,0} },-- головной правый
}

local mbd3_u6_adapter =  {
	ShapeName	=	"mbd3-u6-68",
}

local function mbd3_u6_element(shape,i)
	return 	{
				Position	=	mbd3_u6_conn[i].Position,
				Rotation	=	mbd3_u6_conn[i].Rotation,
				ShapeName	=	shape,
			}
end

local function mbd3_three_fwd(shape)
	return	{
		mbd3_u6_adapter,
		mbd3_u6_element(shape,6),
		mbd3_u6_element(shape,5),
		mbd3_u6_element(shape,2),
	}
end

local function mbd3_four_fwd(shape)
	return	{
		mbd3_u6_adapter,
		mbd3_u6_element(shape,6),
		mbd3_u6_element(shape,5),
		mbd3_u6_element(shape,2),
		mbd3_u6_element(shape,1),
	}
end

local function mbd3_five(shape)
	return	{
		mbd3_u6_adapter,
		mbd3_u6_element(shape,6),
		mbd3_u6_element(shape,5),
		mbd3_u6_element(shape,4),
		mbd3_u6_element(shape,3),
		mbd3_u6_element(shape,2),
	}
end

declare_loadout({
		category 		= CAT_BOMBS,
		CLSID	 		= "{MBD3_U6_3*FAB-250_fwd}",
		attribute		= {4, 5, 32, WSTYPE_PLACEHOLDER},
		wsTypeOfWeapon	= {4, 5, 9, 6},
		Count 			= 3,
		Cx_pil			= 0.005,
		Picture			= "FAB250.png",
		displayName		= _("MBD3-U6-68 with 3 x FAB-250 - 250kg GP Bombs LD"),
		Weight			= 810,
		Elements		= mbd3_three_fwd("fab-250-n1"),
	})

declare_loadout({
		category 		= CAT_BOMBS,
		CLSID	 		= "{MBD3_U6_4*FAB-250_fwd}",
		attribute		= {4, 5, 32, WSTYPE_PLACEHOLDER},
		wsTypeOfWeapon	= {4, 5, 9, 6},
		Count 			= 4,
		Cx_pil			= 0.005,
		Picture			= "FAB250.png",
		displayName		= _("MBD3-U6-68 with 4 x FAB-250 - 250kg GP Bombs LD"),
		Weight			= 1060,
		Elements		= mbd3_four_fwd("fab-250-n1"),
	})

declare_loadout({
		category 		= CAT_BOMBS,
		CLSID	 		= "{MBD3_U6_5*FAB-250}",
		attribute		= {4, 5, 32, WSTYPE_PLACEHOLDER},
		wsTypeOfWeapon	= {4, 5, 9, 6},
		Count 			= 5,
		Cx_pil			= 0.005,
		Picture			= "FAB250.png",
		displayName		= _("MBD3-U6-68 with 5 x FAB-250 - 250kg GP Bombs LD"),
		Weight			= 1310,
		Elements		= mbd3_five("fab-250-n1"),
	})

Durandal = {
	category		= CAT_BOMBS,
	name			= "Durandal",
	model			= "Durandal",
	user_name		= "BLU-107/B Durandal",
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_BetAB, Durandal},
	scheme			= "bomb-concrete",
	type			= 1,
	mass			= 219,
	hMin			= 60,
	hMax			= 5000,
	Cx				= 0.0006,
	VyHold			= -75,
	Ag				= -20,
	sounderName		= "Weapons/BetAB_500ShP",

	fm = {
		mass		= 219,
		caliber		= 0.212,
		cx_coeff	= {1, 0.39, 0.6, 0.168, 1.31},
		L			= 2.491,
		I			= 113.24,
		Ma			= 5,
		Mw			= 2.77,
		wind_time	= 3,
		wind_sigma	= 2.5,
		cx_factor	= 950,
		shapeName	= "Durandal"
	},

	warhead = predefined_warhead("BLU_107B"),

	engine = {
		fuel_mass				= 36,
		impulse					= 170,
		boost_time				= 0.45,
		work_time				= 1,
		boost_factor			= 1,
		nozzle_position			= {{-1.15, 0, 0}},
		nozzle_orientationXYZ	= {{0, 0, 0}},
		tail_width				= 0.5,
		boost_tail				= 1,
		work_tail				= 1,
		smoke_color				= {0.6, 0.6, 0.6},
		smoke_transparency		= 0.3,
	},

	control = {
		delay_par = 1.1,
		delay_eng = 5.5,
	},

	shape_table_data = {{
		file		= "Durandal",
		username	= "Durandal",
		index		= WSTYPE_PLACEHOLDER,
	}},

	targeting_data = {	--* OK
		char_time		= 20.3,
		chute_char_time	= 76,
		chute_open_time	= 1.1,
		chute_cut_time	= 5.5
	}
}
declare_weapon(Durandal)

BAP_100 = {
	category		= CAT_BOMBS,
	name			= "BAP-100",
	user_name		= "BAP-100",
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_BetAB, WSTYPE_PLACEHOLDER},
	scheme			= "bomb-concrete",
	model			= "BAP-100",
	type			= 1,
	mass			= 32.5,
	hMin			= 40,
	hMax			= 3000,
	Cx				= 0.0006,
	VyHold			= -50,
	Ag				= -5,
	sounderName		= "Weapons/BetAB_500ShP",

	fm = {
		mass		= 32.5,
		caliber		= 0.1,
		cx_coeff	= {1, 0.82, 0.65, 0.142, 2.11},
		L			= 1.78,
		I			= 8.58,
		Ma			= 14.5,
		Mw			= 24,
		wind_time	= 3,
		wind_sigma	= 25,
		cx_factor	= 1200,
	},

	warhead = predefined_warhead("BAP_100"),

	engine = {
		fuel_mass				= 8,
		impulse					= 130,
		boost_time				= 0,
		work_time				= 0.3,
		boost_factor			= 1,
		nozzle_position			= {{-0.85, 0, 0}},
		nozzle_orientationXYZ	= {{0, 0, 0}},
		tail_width				= 0.3,
		boost_tail				= 1,
		work_tail				= 1,
		smoke_color				= {0.6, 0.6, 0.6},
		smoke_transparency		= 0.8,
	},

	control = {
		delay_par = 0.5,
		delay_eng = 3.75,
	},

	shape_table_data = {{
		file		= "BAP-100",
		username	= "BAP-100",
		index		= WSTYPE_PLACEHOLDER,
	}},

	targeting_data = {	--* OK
		char_time		= 20.32,
		chute_char_time	= 63,
		chute_open_time	= 0.5,
		chute_cut_time	= 3.75
	}
}
declare_weapon(BAP_100)

BAT_120 = {
	category		= CAT_BOMBS,
	name			= "BAT-120",
	user_name		= "BAT-120 ABL",
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme			= "bomb-parashute",
	model			= "BAT-120",
	type			= 1,
	mass			= 34,
	hMin			= 40,
	hMax			= 1000,
	Cx				= 0.0006,
	VyHold			= -50,
	Ag				= -5,

	fm = {
		mass		= 34,
		caliber		= 0.12,
		cx_coeff	= {1, 0.82, 0.65, 0.142, 2.11},
		L			= 1.5,
		I			= 6.38,
		Ma			= 0.9,
		Mw			= 3.2,
		wind_time	= 1000,
		wind_sigma	= 4,
		cx_factor	= 800,
	},

	warhead = predefined_warhead("BAT_120ABL"),

	control = {
		open_delay = 0.5,
	},

	shape_table_data = {{
		file		= "BAT-120",
		username	= "BAT-120",
		index		= WSTYPE_PLACEHOLDER,
	}},

	targeting_data = {	--* OK
		char_time = 20.37,
		chute_char_time = 175,
		chute_open_time = 0.5,
	}
}
declare_weapon(BAT_120)

MK76 = {
	category		= CAT_BOMBS,
	name			= "MK76",
	user_name		= "Mk 76",
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme			= "bomb-smoke",
	model			= "MK76",
	type			= 0,
	mass			= 11.3,
	hMin			= 200,
	hMax			= 12000,
	Cx				= 0.00015,
	VyHold			= -100,
	Ag				= -1.23,

	fm = {
		mass		= 11.3,
		caliber		= 0.1,
		cx_coeff	= {1, 0.82, 0.65, 0.142, 2.11},
		L			= 0.575,
		I			= 94.425933,
		Ma			= 2.746331,
		Mw			= 2.146083,
		wind_time	= 1000,
		wind_sigma	= 80
	},

	warhead = {
		mass					= 11.3,
		expl_mass				= 0,
		other_factors			= {1, 1, 1},
		obj_factors				= {1, 1},
		concrete_factors		= {1, 1, 1},
		cumulative_factor		= 0,
		concrete_obj_factor		= 0,
		cumulative_thickness	= 0,
		piercing_mass			= 11.3,
		caliber					= 0.1,
		transparency			= 0.5,
		color					= {2, 2, 2},
		intensity				= 10,
		duration				= 60,
		flare					= false
	},

	shape_table_data = {{
		file		= "MK76",
		username	= "MK76",
		index		= WSTYPE_PLACEHOLDER,
	}},

	targeting_data = {
		char_time = 20.54,
	},
}
declare_weapon(MK76)

MK106 = {
	category		= CAT_BOMBS,
	name			= "MK106",
	user_name		= "Mk 106",
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme			= "bomb-smoke",
	model			= "MK106",
	type			= 0,
	mass			= 2.27,
	hMin			= 200,
	hMax			= 12000,
	Cx				= 0.00015,
	VyHold			= -100,
	Ag				= -1.23,

	fm = {
		mass		= 2.27,
		caliber		= 0.1,
		cx_coeff	= {1, 0.82, 0.65, 0.142, 2.11},
		L			= 0.575,
		I			= 94.425933,
		Ma			= 2.746331,
		Mw			= 2.146083,
		wind_time	= 1000,
		wind_sigma	= 80,
	},

	warhead = {
		mass					= 2.27,
		expl_mass				= 0,
		other_factors			= {1, 1, 1},
		obj_factors				= {1, 1},
		concrete_factors		= {1, 1, 1},
		cumulative_factor		= 0,
		concrete_obj_factor		= 0,
		cumulative_thickness	= 0,
		piercing_mass			= 2.27,
		caliber					= 0.1,
		transparency			= 0.5,
		color					= {2, 2, 2},
		intensity				= 10,
		duration				= 15,
		flare					= false
	},

	shape_table_data = {{
		file		= "MK106",
		username	= "MK106",
		index		= WSTYPE_PLACEHOLDER,
	}},

	targeting_data = {
		char_time = 22.02,
	},
}
declare_weapon(MK106)

FAB_250_M62 = {
	category		= CAT_BOMBS,
	name			= "FAB-250-M62",
	user_name		= "FAB-250-M62",
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme			= "bomb-common",
	model			= "fab-250-m62",
	type			= 1,
	mass			= 227,
	hMin			= 500,
	hMax			= 12000,
	VyHold			= -50,
	Ag				= -5,

	fm = {
		mass		= 227,
		caliber		= 0.3,
		cx_coeff	= {1, 0.39, 0.8, 0.168, 1.31},
		L			= 1.924,
		I			= 70.03,
		Ma			= 0.141338,
		Mw			= 2.244756,
		wind_sigma	= 30,
	},

	warhead = predefined_warhead("FAB_250"),

	shape_table_data = {{
		file		= "fab-250-m62",
		username	= "FAB-250-M62",
		index		= WSTYPE_PLACEHOLDER,
	}},

	targeting_data = {
		char_time = 20.36,
	}
}
declare_weapon(FAB_250_M62)

SAMP125LD = {
	category		= CAT_BOMBS,
	name			= "SAMP125LD",
	user_name		= "SAMP-125 LD",
	displayName		= _("SAMP-125 - 125 kg GP Bomb LD"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme			= "bomb-common-anim",
	model			= "SAMP_125",
	type			= 1,
	mass			= 120,
	hMin			= 50,
	hMax			= 12000,
	VyHold			= -50,
	Ag				= -5,

	fm = {
		mass		= 120,
		caliber		= 0.198,
		cx_coeff	= {1, 0.32, 0.71, 0.15, 1.28},
		L			= 1.406,
		I			= 1 / 12 * 120 * 1.406 ^ 2,
		Ma			= 0.141338,
		Mw			= 2.244756,
		wind_sigma	= 30,
		wind_time	= 1000,
	},

	arming_delay = {
		enabled = true,
		delay_time = 2
	},

	warhead = predefined_warhead("SAMP125"),

	shape_table_data = {{
		file	 = "SAMP_125",
		username = "SAMP125",
		index	 = WSTYPE_PLACEHOLDER,
	}},

	targeting_data = {
		char_time = 20.34, --* OK
	}
}
declare_weapon(SAMP125LD)

SAMP250LD = {
	category		= CAT_BOMBS,
	name			= "SAMP250LD",
	user_name		= "SAMP-250 LD",
	displayName		= _("SAMP-250 - 250 kg GP Bomb LD"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme			= "bomb-common-anim",
	model			= "SAMP_250FB",
	type			= 1,
	mass			= 245,
	hMin			= 50,
	hMax			= 12000,
	VyHold			= -50,
	Ag				= -5,

	fm = {
		mass		= 245,
		caliber		= 0.324,
		cx_coeff	= {1, 0.29, 0.71, 0.14, 1.28},
		L			= 2.121,
		I			= 1 / 12 * 245 * 2.121 ^ 2,
		Ma			= 0.141338,
		Mw			= 2.244756,
		wind_sigma	= 30,
		wind_time	= 1000,
	},

	arming_delay = {
		enabled = true,
		delay_time = 2
	},

	warhead = predefined_warhead("SAMP250"),

	shape_table_data = {{
		file	 = "SAMP_250FB",
		username = "SAMP250FB",
		index	 = WSTYPE_PLACEHOLDER,
	}},

	targeting_data = {
		char_time = 20.37, --* OK
	}
}
declare_weapon(SAMP250LD)

SAMP250HD = {
	category		= CAT_BOMBS,
	name			= "SAMP250HD",
	user_name		= "SAMP-250 HD",
	displayName		= _("SAMP-250 - 250 kg GP Chute Retarded Bomb HD"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme			= "bomb-parashute",
	model			= "SAMP_250R",
	type			= 1,
	mass			= 269,
	hMin			= 50,
	hMax			= 2000,
	VyHold			= -50,
	Ag				= -5,

	fm = {
		mass		= 269,
		caliber		= 0.324,
		cx_coeff	= {1, 0.29, 0.71, 0.14, 1.28},
		L			= 2.121,
		I			= 1 / 12 * 269 * 2.121 ^ 2,
		Ma			= 0.9,
		Mw			= 3.2,
		wind_time	= 1000,
		wind_sigma	= 4,
		cx_factor	= 300,
	},

	control = {
		open_delay = 0.3,
	},

	arming_delay = {
		enabled = true,
		delay_time = 3.3
	},

	warhead = predefined_warhead("SAMP250"),

	shape_table_data = {{
		file	 = "SAMP_250R",
		username = "SAMP250R",
		index	 = WSTYPE_PLACEHOLDER,
	}},

	targeting_data = {	--* OK
		char_time = 20.36,
		chute_char_time = 70,
		chute_open_time = 0.3
	}
}
declare_weapon(SAMP250HD)

SAMP400LD = {
	category		= CAT_BOMBS,
	name			= "SAMP400LD",
	user_name		= "SAMP-400 LD",
	displayName		= _("SAMP-400 - 400 kg GP Bomb LD"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme			= "bomb-common-anim",
	model			= "SAMP_400FB",
	type			= 1,
	mass			= 360,
	hMin			= 200,
	hMax			= 12000,
	VyHold			= -50,
	Ag				= -5,

	fm = {
		mass		= 360,
		caliber		= 0.403,
		cx_coeff	= {1, 0.29, 0.71, 0.13, 1.28},
		L			= 2.194,
		I			= 1 / 12 * 360 * 2.194 ^ 2,
		Ma			= 0.141338,
		Mw			= 2.244756,
		wind_sigma	= 30,
		wind_time	= 1000,
	},

	arming_delay = {
		enabled = true,
		delay_time = 2
	},

	warhead = predefined_warhead("SAMP400"),

	shape_table_data = {{
		file	 = "SAMP_400FB",
		username = "SAMP400FB",
		index	 = WSTYPE_PLACEHOLDER,
	}},

	targeting_data = {
		char_time = 20.36, -- *OK
	}
}
declare_weapon(SAMP400LD)

SAMP400HD = {
	category		= CAT_BOMBS,
	name			= "SAMP400HD",
	user_name		= "SAMP-400 HD",
	displayName		= _("SAMP-400 - 400 kg GP Chute Retarded Bomb HD"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme			= "bomb-parashute",
	model			= "SAMP_400R",
	type			= 1,
	mass			= 395,
	hMin			= 50,
	hMax			= 2000,
	VyHold			= -50,
	Ag				= -5,

	fm = {
		mass		= 395,
		caliber		= 0.403,
		cx_coeff	= {1, 0.29, 0.71, 0.14, 1.28},
		L			= 2.194,
		I			= 1 / 12 * 395 * 2.194 ^ 2,
		Ma			= 0.9,
		Mw			= 3.2,
		wind_time	= 1000,
		wind_sigma	= 4,
		cx_factor	= 300,
	},

	control = {
		open_delay = 0.3,
	},

	arming_delay = {
		enabled = true,
		delay_time = 3.3
	},

	warhead = predefined_warhead("SAMP400"),

	shape_table_data = {{
		file	 = "SAMP_400R",
		username = "SAMP400R",
		index	 = WSTYPE_PLACEHOLDER,
	}},

	targeting_data = {	--* OK
		char_time = 20.36,
		chute_char_time = 72.5,
		chute_open_time = 0.3
	}
}
declare_weapon(SAMP400HD)

Mk_84AIR_GP = {
	category		= CAT_BOMBS,
	name			= "Mk_84AIR_GP",
	user_name		= "Mk-84 AIR GP HD",
	displayName		= _("Mk-84 AIR (BSU-50) - 2000 lb GP Chute Retarded Bomb HD"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	class_name		= "wAmmunitionBallute",
	scheme			= "bomb-parashute",
	model			= "mk-84air",
	type			= 1,
	mass			= 911.7,
	hMin			= 25,
	hMax			= 2000,
	VyHold			= -50,
	Ag				= -5,

	fm = {
		mass		= 911.7,
		caliber		= 0.4572,
		cx_coeff	= {1, 0.39, 0.6, 0.168, 1.31},
		L			= 3.477,
		I			= 1 / 12 * 911.7 * 3.477 ^ 2,
		Ma			= 0.9,
		Mw			= 3.2,
		wind_time	= 1000,
		wind_sigma	= 4,
		cx_factor	= 300,
	},

	control = {
		open_delay = 0.2,
	},

	arming_delay = {
		enabled = true,
		delay_time = 2
	},

	warhead = predefined_warhead("Mk_84"),

	shape_table_data = {{
		file	 = "mk-84air",
		username = "Mk_84AIR_GP",
		index	 = WSTYPE_PLACEHOLDER,
	}},

	targeting_data = {			--* OK
		char_time = 20.31,
		chute_char_time = 55.7,
		chute_open_time = 0.2,
	}
}
declare_weapon(Mk_84AIR_GP)

Mk_84AIR_TP = {
	category		= CAT_BOMBS,
	name			= "Mk_84AIR_TP",
	user_name		= "Mk-84 AIR TP HD",
	displayName		= _("Mk-84 AIR (BSU-50) - 2000 lb TP Chute Retarded Bomb HD"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	class_name		= "wAmmunitionBallute",
	scheme			= "bomb-parashute",
	model			= "mk-84air_inert",
	type			= 1,
	mass			= 911.7,
	hMin			= 25,
	hMax			= 2000,
	VyHold			= -50,
	Ag				= -5,

	fm = {
		mass		= 911.7,
		caliber		= 0.4572,
		cx_coeff	= {1, 0.39, 0.6, 0.168, 1.31},
		L			= 3.477,
		I			= 1 / 12 * 911.7 * 3.477 ^ 2,
		Ma			= 0.9,
		Mw			= 3.2,
		wind_time	= 1000,
		wind_sigma	= 4,
		cx_factor	= 300,
	},

	control = {
		open_delay = 0.2,
	},

	arming_delay = {
		enabled = true,
		delay_time = 2
	},

	warhead = predefined_warhead("Mk_84TP"),

	shape_table_data = {{
		file	 = "mk-84air_inert",
		username = "Mk_84AIR_TP",
		index	 = WSTYPE_PLACEHOLDER,
	}},

	targeting_data = {			--* OK
		char_time = 20.31,
		chute_char_time = 55.7,
		chute_open_time = 0.2,
	}
}
declare_weapon(Mk_84AIR_TP)

declare_loadout({
	category			= CAT_BOMBS,
	CLSID				= "{Mk_84AIR_GP}",
	attribute			= Mk_84AIR_GP.wsTypeOfWeapon,
	Count				= 1,
	Cx_pil				= 0.000357,
	Picture				= "mk84.png",
	displayName			= Mk_84AIR_GP.displayName,
	Weight				= Mk_84AIR_GP.mass,
	Elements			= {{ ShapeName = Mk_84AIR_GP.model }},
})

declare_loadout({
	category			= CAT_BOMBS,
	CLSID				= "{Mk_84AIR_TP}",
	attribute			= Mk_84AIR_TP.wsTypeOfWeapon,
	Count				= 1,
	Cx_pil				= 0.000357,
	Picture				= "mk84.png",
	displayName			= Mk_84AIR_TP.displayName,
	Weight				= Mk_84AIR_TP.mass,
	Elements			= {{ ShapeName = Mk_84AIR_TP.model }},
})

declare_loadout({
	category			= CAT_BOMBS,
	CLSID				= "{SAMP125LD}",
	attribute			= SAMP125LD.wsTypeOfWeapon,
	Count				= 1,
	Cx_pil				= 0.001 / 25,
	Picture				= "mk82.png",
	displayName			= SAMP125LD.displayName,
	Weight				= SAMP125LD.mass,
	Elements			= {{ ShapeName = SAMP125LD.model }},
})

declare_loadout({
	category			= CAT_BOMBS,
	CLSID				= "{SAMP250LD}",
	attribute			= SAMP250LD.wsTypeOfWeapon,
	Count				= 1,
	Cx_pil				= 0.003 / 25,
	Picture				= "mk82.png",
	displayName			= SAMP250LD.displayName,
	Weight				= SAMP250LD.mass,
	Elements			= {{ ShapeName = SAMP250LD.model }},
})

declare_loadout({
	category			= CAT_BOMBS,
	CLSID				= "{SAMP250HD}",
	attribute			= SAMP250HD.wsTypeOfWeapon,
	Count				= 1,
	Cx_pil				= 0.003 / 25,
	Picture				= "mk82AIR.png",
	displayName			= SAMP250HD.displayName,
	Weight				= SAMP250HD.mass,
	Elements			= {{ ShapeName = SAMP250HD.model }},
})

declare_loadout({
	category			= CAT_BOMBS,
	CLSID				= "{SAMP400LD}",
	attribute			= SAMP400LD.wsTypeOfWeapon,
	Count				= 1,
	Cx_pil				= 0.005 / 25,
	Picture				= "mk83.png",
	displayName			= SAMP400LD.displayName,
	Weight				= SAMP400LD.mass,
	Elements			= {{ ShapeName = SAMP400LD.model }},
})

declare_loadout({
	category			= CAT_BOMBS,
	CLSID				= "{SAMP400HD}",
	attribute			= SAMP400HD.wsTypeOfWeapon,
	Count				= 1,
	Cx_pil				= 0.005 / 25,
	Picture				= "mk83.png",
	displayName			= SAMP400HD.displayName,
	Weight				= SAMP400HD.mass,
	Elements			= {{ ShapeName = SAMP400HD.model }},
})

-- Out of necessity - no connectors are present on the CLB4 model
local function clb4Elements(munitionModelName, doUseAltPositions)
	local posTable = {
		{1.242, -0.045, -0.275},
		{-1.471, -0.045, -0.275},
		{1.242, -0.045, 0.275},
		{-1.471, -0.045, 0.275},
	}

	if doUseAltPositions then
		posTable = {
			{1.002, -0.071, -0.275},
			{-1.391, -0.045, -0.275},
			{1.002, -0.071, 0.275},
			{-1.391, -0.045, 0.275},
		}
	end

	return {
		{ ShapeName = "CLB_4", IsAdapter = true },
		{ Position = posTable[1], ShapeName = munitionModelName },
		{ Position = posTable[2], ShapeName = munitionModelName },
		{ Position = posTable[3], ShapeName = munitionModelName },
		{ Position = posTable[4], ShapeName = munitionModelName },
	}
end

BatchDeclareLoadout(
	BPylonData.CLB4,
	{
		["{CLB4_MK82S}"] = {
			displayName		= BPylonData.CLB4.displayNamePfx .. _("Mk-82 Snakeye - 500lb GP Bomb HD"),
			Picture			= "mk82AIR.png",
			wsTypeOfWeapon	= "weapons.bombs.MK_82SNAKEYE",
			singleWpnMass	= 249.5,
			Cx_pil			= 0.019 / 25,
			Elements		= clb4Elements("MK-82_Snakeye")
		},
		["{CLB4_MK82}"] = {
			displayName		= BPylonData.CLB4.displayNamePfx .. _("Mk-82 - 500lb GP Bomb LD"),
			Picture			= "mk82.png",
			wsTypeOfWeapon	= "weapons.bombs.Mk_82",
			singleWpnMass	= 228,
			Cx_pil			= 0.019 / 25,
			Elements		= clb4Elements("MK-82")
		},
		["{CLB4_BLU107}"] = {
			displayName		= BPylonData.CLB4.displayNamePfx .. _("BLU-107/B Durandal - 219kg Concrete Piercing Chute Retarded Bomb w/Booster"),
			Picture			= "blu107.png",
			wsTypeOfWeapon	= Durandal.wsTypeOfWeapon,
			singleWpnMass	= Durandal.fm.mass,
			Cx_pil			= 0.015 / 25,
			Elements		= clb4Elements(Durandal.model)
		},
		["{CLB4_SAMP125LD}"] = {
			displayName		= BPylonData.CLB4.displayNamePfx .. SAMP125LD.displayName,
			Picture			= "mk82.png",
			wsTypeOfWeapon	= SAMP125LD.wsTypeOfWeapon,
			singleWpnMass	= SAMP125LD.fm.mass,
			Cx_pil			= 0.013 / 25,
			Elements		= clb4Elements(SAMP125LD.model, true)
		},
		["{CLB4_SAMP250LD}"] = {
			displayName		= BPylonData.CLB4.displayNamePfx .. SAMP250LD.displayName,
			Picture			= "mk82.png",
			wsTypeOfWeapon	= SAMP250LD.wsTypeOfWeapon,
			singleWpnMass	= SAMP250LD.fm.mass,
			Cx_pil			= 0.023 / 25,
			Elements		= clb4Elements(SAMP250LD.model, true)
		},
		["{CLB4_SAMP250HD}"] = {
			displayName		= BPylonData.CLB4.displayNamePfx .. SAMP250HD.displayName,
			Picture			= "mk82AIR.png",
			wsTypeOfWeapon	= SAMP250HD.wsTypeOfWeapon,
			singleWpnMass	= SAMP250HD.fm.mass,
			Cx_pil			= 0.023 / 25,
			Elements		= clb4Elements(SAMP250HD.model, true)
		},
		["{CLB4_SAMP400LD}"] = {
			displayName		= BPylonData.CLB4.displayNamePfx .. SAMP400LD.displayName,
			Picture			= "mk83.png",
			wsTypeOfWeapon	= SAMP400LD.wsTypeOfWeapon,
			singleWpnMass	= SAMP400LD.fm.mass,
			Cx_pil			= 0.031 / 25,
			Elements		= clb4Elements(SAMP400LD.model, true)
		},
		["{CLB4_SAMP400HD}"] = {
			displayName		= BPylonData.CLB4.displayNamePfx .. SAMP400HD.displayName,
			Picture			= "mk82AIR.png",
			wsTypeOfWeapon	= SAMP400HD.wsTypeOfWeapon,
			singleWpnMass	= SAMP400HD.fm.mass,
			Cx_pil			= 0.031 / 25,
			Elements		= clb4Elements(SAMP400HD.model, true)
		},
	}
)

BatchDeclareLoadout(
	BPylonData.CLB30,
	{
		-- From "CLB30-PYLON-MK83"
		["{CLB30_MK83}"] = {
			displayName		= BPylonData.CLB30.displayNamePfx .. _("Mk-83 - 1000lb GP Bomb LD"),
			Picture			= "mk83.png",
			wsTypeOfWeapon	= "weapons.bombs.Mk_83",
			singleWpnMass	= 454,
			Cx_pil			= 0.008 / 25,
			Elements		= {
				{ ShapeName = "CLB_30", IsAdapter = true },
				{ Position = {0, -0.046, 0}, ShapeName = "MK-83" },
			}
		},
	}
)

bombs_data["Durandal"] 	= { name = _("BLU-107/B Durandal - 219kg Concrete Piercing Chute Retarded Bomb w/Booster"), picture = "blu107.png" }
bombs_data["BAP_100"] 	= { name = _("BAP-100 - 32kg Concrete Piercing Chute Retarded Bomb w/Booster"), picture = "BAP100x6.png" }
bombs_data["BAT_120"] 	= { name = _("BAT-120 ABL - 34kg HE/Frag Chute Retarded Bomb HD"), picture = "BAT120x6.png"	}
bombs_data["MK76"]		= { name = _("Mk 76 - 25lb Practice Bomb LD") }
bombs_data["MK106"]		= { name = _("Mk 106 - 5lb Practice Bomb LD") }

-- FAB-250M-62
declare_loadout({
	category         = CAT_BOMBS,
	CLSID            = "{FAB_250_M62}",
	attribute        = FAB_250_M62.wsTypeOfWeapon,
	Count            = 1,
	Cx_pil           = 0.000750,
	Picture          = "rus_FAB-250n-1.png",
	PictureBlendColor = "0xffffffff",
	displayName      = _("FAB-250-M62 - 250kg GP Bomb LD"),
	Weight           = FAB_250_M62.mass,
	Elements         = {{ ShapeName = FAB_250_M62.model }},
})

-- Durandal
declare_loadout({
	category         = CAT_BOMBS,
	CLSID            = "{BLU107B_DURANDAL}",
	attribute        = Durandal.wsTypeOfWeapon,
	Count            = 1,
	Cx_pil           = Durandal.Cx,
	Picture          = bombs_data["Durandal"].picture,
	displayName      = bombs_data["Durandal"].name,
	Weight           = Durandal.mass,
	Elements         = {{ShapeName = Durandal.model}},
	ejectImpulse     = 5,
})

-- 6 x BAP-100 (14-3-M2)
declare_loadout(
	create_ThomBran_MER("14-3-M2", BAP_100.model, BAP_100.mass, 2, {
		CLSID			= "{14_3_M2_6xBAP100}",
		displayName		= bombs_data["BAP_100"].name,
		wsTypeOfWeapon	= BAP_100.wsTypeOfWeapon,
		Picture			= bombs_data["BAP_100"].picture,
		Cx				= BAP_100.Cx
	})
)

-- 9 x BAP-100 (14-3-M2)
declare_loadout(
	create_ThomBran_MER("14-3-M2", BAP_100.model, BAP_100.mass, 3, {
		CLSID			= "{14_3_M2_9xBAP100}",
		displayName		= bombs_data["BAP_100"].name,
		wsTypeOfWeapon	= BAP_100.wsTypeOfWeapon,
		Picture			= bombs_data["BAP_100"].picture,
		Cx				= BAP_100.Cx
	})
)

-- 12 x BAP-100 (30-6-M2)
declare_loadout(
	create_ThomBran_MER("30-6-M2", BAP_100.model, BAP_100.mass, 2, {
		CLSID			= "{30_6_M2_12xBAP100}",
		displayName		= bombs_data["BAP_100"].name,
		wsTypeOfWeapon	= BAP_100.wsTypeOfWeapon,
		Picture			= bombs_data["BAP_100"].picture,
		Cx				= BAP_100.Cx
	})
)

-- 18 x BAP-100 (30-6-M2)
declare_loadout(
	create_ThomBran_MER("30-6-M2", BAP_100.model, BAP_100.mass, 3, {
		CLSID			= "{30_6_M2_18xBAP100}",
		displayName		= bombs_data["BAP_100"].name,
		wsTypeOfWeapon	= BAP_100.wsTypeOfWeapon,
		Picture			= bombs_data["BAP_100"].picture,
		Cx				= BAP_100.Cx
	})
)

-- 6 x BAT-120 (14-3-M2)
declare_loadout(
	create_ThomBran_MER("14-3-M2", BAT_120.model, BAT_120.mass, 2, {
		CLSID			= "{14_3_M2_6xBAT120}",
		displayName		= bombs_data["BAT_120"].name,
		wsTypeOfWeapon	= BAT_120.wsTypeOfWeapon,
		Picture			= bombs_data["BAT_120"].picture,
		Cx				= BAT_120.Cx
	})
)

-- 9 x BAT-120 (14-3-M2)
declare_loadout(
	create_ThomBran_MER("14-3-M2", BAT_120.model, BAT_120.mass, 3, {
		CLSID			= "{14_3_M2_9xBAT120}",
		displayName		= bombs_data["BAT_120"].name,
		wsTypeOfWeapon	= BAT_120.wsTypeOfWeapon,
		Picture			= bombs_data["BAT_120"].picture,
		Cx				= BAT_120.Cx
	})
)

-- 12 x BAT-120 (30-6-M2)
declare_loadout(
	create_ThomBran_MER("30-6-M2", BAT_120.model, BAT_120.mass, 2, {
		CLSID			= "{30_6_M2_12xBAT120}",
		displayName		= bombs_data["BAT_120"].name,
		wsTypeOfWeapon	= BAT_120.wsTypeOfWeapon,
		Picture			= bombs_data["BAT_120"].picture,
		Cx				= BAT_120.Cx
	})
)

-- 18 x BAT-120 (30-6-M2)
declare_loadout(
	create_ThomBran_MER("30-6-M2", BAT_120.model, BAT_120.mass, 3, {
		CLSID			= "{30_6_M2_18xBAT120}",
		displayName		= bombs_data["BAT_120"].name,
		wsTypeOfWeapon	= BAT_120.wsTypeOfWeapon,
		Picture			= bombs_data["BAT_120"].picture,
		Cx				= BAT_120.Cx
	})
)

-- 4 x Mk76 (BRD-4-250)
declare_loadout(
	create_BRD_4_250(MK76.model, MK76.mass, {
		CLSID			= "{BRD_4_250_4xMK76}",
		wsTypeOfWeapon	= MK76.wsTypeOfWeapon,
		displayName		= "BRD-4-250 - 4 x " .. bombs_data["MK76"].name
	})
)

-- 4 x Mk106 (BRD-4-250)
declare_loadout(
	create_BRD_4_250(MK106.model, MK106.mass, {
		CLSID			= "{BRD_4_250_4xMK106}",
		wsTypeOfWeapon	= MK106.wsTypeOfWeapon,
		displayName		= "BRD-4-250 - 4 x " .. bombs_data["MK106"].name
	})
)
