-- Rocket launchers' parameters
local RLData = {
	LR25 = {
		attribute		= {wsType_Weapon, wsType_NURS, wsType_Container, 182}, -- 182 (LAU-3) - needed for nose cap ejection
		category		= CAT_ROCKETS,
		connNamePattern	= "Tube_%02d",
		Count			= 25,
		Cx_pil			= 0.00059912109375,
		displayNamePfx	= "LR-25 - 25 x ",
		modelFileName	= "LR-25",
		Picture			= "LR25.png",
		Weight_Empty	= 46,
	},
	M261 = {
		attribute		= {wsType_Weapon, wsType_NURS, wsType_Container, WSTYPE_PLACEHOLDER},
		category		= CAT_ROCKETS,
		connNamePattern	= "tube_%d",
		Count			= 19,
		Cx_pil			= 0.001708984375,
		displayNamePfx	= "M261 - 19 x ",
		Elements		= ContainerWithSubshapes("M261", "hydra_m151he", 19, "tube_%d"),
		modelFileName	= "M261",
		Picture			= "LAU61.png",
		Weight_Empty	= 39.4, -- per SME feedback
	},
	MATRAF1 = {
		attribute		= {wsType_Weapon, wsType_NURS, wsType_Container, WSTYPE_PLACEHOLDER},
		category		= CAT_ROCKETS,
		Count			= 36,
		Cx_pil			= 0.016 / 25,
		displayNamePfx	= "MATRA F1 - 36 x ",
		Elements		= ContainerWithSubshapes("Matra-F1-Rocket", "SA342_SNEB68", 36),
		modelFileName	= "Matra-F1-Rocket",
		Picture			= "LAU61.png",
		Weight_Empty	= 88
	},
	MATRAF4 = {
		attribute		= {wsType_Weapon, wsType_NURS, wsType_Container, WSTYPE_PLACEHOLDER},
		category		= CAT_ROCKETS,
		Count			= 18,
		Cx_pil			= 0.007 / 25,
		displayNamePfx	= "MATRA F4 - 18 x ",
		Elements		= {{ ShapeName = "M-2000C_LRF4", IsAdapter = true }},
		modelFileName	= "M-2000C_LRF4",
		Picture			= "LAU61.png",
		Weight_Empty	= 96.5
	},
	TELSON8 = {
		attribute		= {wsType_Weapon, wsType_NURS, wsType_Container, WSTYPE_PLACEHOLDER},
		category		= CAT_ROCKETS,
		Count			= 8,
		Cx_pil			= 0.007,
		displayNamePfx	= "Telson 8 - 8 x ",
		Elements		= ContainerWithSubshapes("SA342_Telson8", "SA342_SNEB68", 8),
		modelFileName	= "SA342_Telson8",
		Picture			= "SNEB68.png",
		Weight_Empty	= 30
	},
}

local function RocketContainer(shape)
	return {{ ShapeName = shape, IsAdapter = true }}
end

---A function to declare a lot of rockets (and create their descriptors) w/o copypasta; indices in the paramTable are unique weapon names.
---@param paramTable	table	The table of parameters of the rockets (what FM/engine/warhead is to be used; some parameter overrides, etc.);
--- basically, the only required parameter is schemeName, but you'll want to use some more to achieve your goals.
---@return				table	OverallResult	Total descriptor list for the declared rockets (for later use)
function BatchDeclareRockets(paramTable)
	OverallResult = {}

	for index, rktParams in pairs(paramTable.variantSpecificParams) do
		currentResult = {}

		local rktParamOverrides = rktParams.paramOverrides or {}

		-- Parameters for most types of rockets (those without "launcher" block), excluding dispenser/illumination rockets
		local warheadParams		= rktParams.payloadParams.warhead or {}
		-- Parameters for dispenser/illumination rockets (those with "launcher" block)
		local launcherParams	= rktParams.payloadParams.launcher or {}

		-- Engine mass w/propellant
		local engineTotalMass	= paramTable.commonParams.baseEngine.total_mass or 0
		-- Engine length
		local engineLength		= paramTable.commonParams.baseEngine.length or 0
		-- Payload (warhead) full mass
		local payloadMass		= warheadParams.mass or launcherParams.ammunition.client.fm.mass or 0
		-- Payload (warhead) length
		local payloadLength		= warheadParams.length or launcherParams.ammunition.client.fm.L or 0
		-- Final displayName
		local displayNameFinal	= rktParams.displayName

		-- If we need to add a prefix
		if paramTable.commonParams.displayNamePfx then
			displayNameFinal = paramTable.commonParams.displayNamePfx .. " " .. displayNameFinal
		end

		-- Create the descriptor table
		currentResult = {
			category		= CAT_ROCKETS,
			name			= index,
			user_name		= rktParams.displayName,
			displayName		= displayNameFinal,
			scheme			= rktParams.schemeName,
			class_name		= "wAmmunitionNURS",
			model			= rktParams.modelFileName or paramTable.commonParams.modelFileName,
			wsTypeOfWeapon	= rktParamOverrides.wsTypeOfWeapon or {wsType_Weapon, wsType_NURS, wsType_Rocket, rktParamOverrides.wsTypeOfWeaponL4 or WSTYPE_PLACEHOLDER},

			engine			= paramTable.commonParams.baseEngine,

			fm = specialize_fm_parameters(
				paramTable.commonParams.baseFM,
				{
					mass		= engineTotalMass + payloadMass,
					L			= engineLength + payloadLength,
					I			= 1 / 12 * (engineTotalMass + payloadMass) * (engineLength + payloadLength) ^ 2,
					shapeName	= rktParams.modelFileName,
					freq		= paramTable.commonParams.baseEngine.induced_RPS or 7
				}
			),

			properties = rktParams.properties or {
				dist_min	= 500,
				dist_max	= 4000
			},

			shape_table_data = {{
				name		= index,
				file		= rktParams.modelFileName or paramTable.commonParams.modelFileName,
				username	= displayNameFinal,
				index		= rktParamOverrides.wsTypeOfWeaponL4 or WSTYPE_PLACEHOLDER
			}}
		}

		if warheadParams.mass then
			currentResult.warhead = warheadParams
		elseif launcherParams.ammunition.client.fm.mass then
			currentResult.launcher = { ammunition = launcherParams.ammunition }
			currentResult.control = { delay = launcherParams.delay }
		end

		OverallResult[index] = currentResult
		declare_weapon(OverallResult[index])
	end

	return OverallResult
end

rockets_data =
{
	["LAU-68_M151"]		= {name = "LAU-68 pod - 7 x 2.75\" Hydra, UnGd Rkts M151, HE", payload_CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}",	mass = 113.9, mass_empty = 40.4, wsType = {4, 7, 33, 147}, Cx = 0.00146484375,  picture = "LAU68.png"},
	["LAU-68_MK5"]		= {name = "LAU-68 pod - 7 x 2.75\" Hydra, UnGd Rkts Mk5, HEAT",	payload_CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}",	mass = 102.1, mass_empty = 40.4, wsType = {4, 7, 33, 145}, Cx = 0.00146484375,  picture = "LAU68.png"},
	["LAU-10"]			= {name = "LAU-10 pod - 4 x 127mm ZUNI, UnGd Rkts Mk71, HE/FRAG", payload_CLSID = "{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}",	mass = 316.6, mass_empty = 66.2, wsType = {4, 7, 33, 37},  Cx = 0.001708984375, picture = "LAU10.png"},
	["LAU-61"]			= {name = "LAU-61 pod - 19 x 2.75\" Hydra, UnGd Rkts M151, HE",	payload_CLSID = "{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}",	mass = 273.4, mass_empty = 73.9, wsType = {4, 7, 33, 147}, Cx = 0.001708984375, picture = "LAU61.png"},
}

declare_loadout({
				category		=	CAT_ROCKETS,
				CLSID			=	"{LAU_61R}",
				Picture			=	"LAU61.png",
				Cx_pil			=	0.001708984375,
				displayName		=	_("LAU-61R pod - 19 x 2.75\" Hydra, UnGd Rkts M151, HE"),
				Count			=	19,
				Elements		=	RocketContainer("LAU-61"),
				Weight			=	73.9+19*10.4,
				wsTypeOfWeapon	=	"weapons.nurs.HYDRA_70_M151",
				attribute		=	{4,	7,	32,	9},
})

declare_loadout({
				category		=	CAT_ROCKETS,
				CLSID			=	"{LAU_10R}",
				Picture			=	"LAU10.png",
				Cx_pil			=	0.001708984375,
				displayName		=	_("LAU-10R pod - 4 x 127mm ZUNI, UnGd Rkts Mk71, HE/FRAG"),
				Count			=	4,
				Weight			=	316.6,
				wsTypeOfWeapon	=	{4,	7,	33,	37},
				attribute		=	{4,	7,	32,	8},
				Elements		=	{
					{ ShapeName = "LAU-10" , IsAdapter = true},
					--rockets itself
					{ ShapeName = "zuni", Position = {0.1, 0.049, 0.072} },
					{ ShapeName = "zuni", Position = {0.1, 0.049, -0.073} },
					{ ShapeName = "zuni", Position = {0.1, -0.095, 0.072} },
					{ ShapeName = "zuni", Position = {0.1, -0.095, -0.073} },
				},
})

local function bru_33_2xlau(clsid,element,left,right)
	local lau_variant = rockets_data[element] or rockets_data["LAU-68_M151"]
	local ret = {
		category			=	CAT_ROCKETS,
		CLSID				=	clsid,
		Picture				=	lau_variant.picture,
		wsTypeOfWeapon		=	lau_variant.wsType,
		attribute			=	{4,	7,	32,	WSTYPE_PLACEHOLDER},
		Cx_pil				=	0.00244140625,
		Elements 			= {{ShapeName	=	"BRU_33A",IsAdapter  	   =   true  },}
	}
	if left then 	ret.Elements[#ret.Elements + 1] = {payload_CLSID = lau_variant.payload_CLSID, connector_name =	"Point02"}	end
	if right then	ret.Elements[#ret.Elements + 1] = {payload_CLSID = lau_variant.payload_CLSID, connector_name =	"Point01"}	end

	local sz = #ret.Elements - 1
	ret.Count  = sz
	ret.Weight_Empty = bru_33VER_mass + sz * lau_variant.mass_empty
	ret.Weight = bru_33VER_mass + sz * lau_variant.mass

	ret.Cx_pil = ret.Cx_pil + sz * lau_variant.Cx

	if sz > 1 then
		ret.displayName =	_("BRU-33").." with 2 x "..lau_variant.name
	else
		ret.displayName =	_("BRU-33").." with 1 x "..lau_variant.name
	end
	declare_loadout(ret)
end

local function fillM261Zones(loadoutTable) -- loadoutTable: zone name/rocket CLSID pairs
	local result = {}
	local tubeCLSIDPairs = {}
	local zoneNumbersTable = {
		["A"] = {1, 2, 3, 4, 7, 8, 12, 13, 16, 17, 18, 19},
		["B"] = {5, 6, 14, 15},
		["E"] = {9, 10, 11}
	}

	result[#result + 1] = {
		ShapeName = "M261",
		IsAdapter = true
	}

	for zoneName, CLSID in pairs(loadoutTable) do
		if zoneName == "C" then -- tube numbers are the same for A/C and B/D zones
			zoneName = "A"
		elseif zoneName == "D" then
			zoneName = "B"
		end

		-- make CLSIDs correspond to tube numbers
		for __, tubeNumber in ipairs(zoneNumbersTable[zoneName]) do
			tubeCLSIDPairs[tubeNumber] = CLSID
		end
	end

	for i, CLSID in ipairs(tubeCLSIDPairs) do
		result[i + 1] = {
			payload_CLSID = CLSID,
			connector_name = string.format("tube_%d", i)
		}
	end

	return result
end

bru_33_2xlau("{BRU33_2*LAU68}"	,	"LAU-68_M151",true,true)
bru_33_2xlau("{BRU33_LAU68}"	,	"LAU-68_M151",true, false)
bru_33_2xlau("{BRU33_LAU68_MK5}",	"LAU-68_MK5",true,false)
bru_33_2xlau("{BRU33_2*LAU68_MK5}",	"LAU-68_MK5",true,true)
bru_33_2xlau("{BRU33_LAU10}",		"LAU-10",true,false)
bru_33_2xlau("{BRU33_2*LAU10}",		"LAU-10",true,true)
bru_33_2xlau("{BRU33_LAU61}",		"LAU-61",true,false)
bru_33_2xlau("{BRU33_2*LAU61}",		"LAU-61",true,true)

declare_loadout({
	category		 = CAT_ROCKETS,
	CLSID			 = "{UB-16-57UMP}",
	displayName		 =	_("UB-16UM pod - 16 x S-5KO, 57mm UnGd Rkts, HEAT/Frag"),
	wsTypeOfWeapon	 =	{4,	7,	33,	31},
	attribute	 	 =	{4,	7,	32,	WSTYPE_PLACEHOLDER},
	Count			 =	16,
	Picture			 = "ub16.png",
	Weight_Empty	 = 57,
	Weight			 = 138,
	Cx_pil			 =	0.00196533203125,
	Elements		 = ContainerWithSubshapes("UB-16-57UMP", "S-5KO", 16, "tube_%d")
})

declare_loadout({
	category		=	CAT_ROCKETS,
	CLSID			=	"{FC56DF80-9B09-44C5-8976-DCFAFF219062}",
	Picture			=	"rus_B-13L_S-13OF.png",
	PictureBlendColor = "0xffffffff",
	Cx_pil			=	0.00159912109375,
	displayName		=	_("B-13L pod - 5 x S-13-OF, 122mm UnGd Rkts, Blast/Frag"),
	Count			=	5,
	Elements		=	ContainerWithSubshapes("UB-13", "C-13", 5, "tube_%d"),
	Weight			=	510,
	wsTypeOfWeapon	=	{4,	7,	33,	33},
	attribute		=	{4,	7,	32,	1},
})

declare_loadout({
	category 		= CAT_ROCKETS,
	CLSID	 		= "{TWIN_B13L_5OF}",
	wsTypeOfWeapon	= {4,	7,	33,	33},
	attribute		= {4,	7,	32,	WSTYPE_PLACEHOLDER},
	Count 			= 10,
	Cx_pil			= 0.0004,
	Picture			= "B13.png",
	displayName		=	_("2 x B-13L pods - 10 x S-13-OF, 122mm UnGd Rkts, Blast/Frag"),
	Weight			= 32 + 2*(160+5*69),
	JettisonSubmunitionOnly = true,
	Elements		=	{
	   {ShapeName = "su-27-twinpylon",IsAdapter = true},
	   {payload_CLSID = "{FC56DF80-9B09-44C5-8976-DCFAFF219062}", connector_name = "S-25-L"},
	   {payload_CLSID = "{FC56DF80-9B09-44C5-8976-DCFAFF219062}", connector_name = "S-25-R"},
	}
})

declare_loadout({
	category 		= CAT_ROCKETS,
	CLSID	 		= "{TWIN_B_8M1_S_8KOM}",
	wsTypeOfWeapon	= {4,	7,	33,	32},
	attribute		= {4,	7,	32,	WSTYPE_PLACEHOLDER},
	Count 			= 40,
	Cx_pil			= 0.0004,
	Picture			= "B8V20A.png",
	displayName		=	_("2 x B-8M1 pods - 40 x S-8KOM, 80mm UnGd Rkts, HEAT/AP"),
	Weight			= 32+ 2*(137.5 + 20 * 11.3),
	JettisonSubmunitionOnly = true,
	Elements		=	{
	   {ShapeName = "su-27-twinpylon",IsAdapter = true},
	   {payload_CLSID = "{F72F47E5-C83A-4B85-96ED-D3E46671EE9A}", DrawArgs = {{3,0.5}}, connector_name = "S-25-L"},
	   {payload_CLSID = "{F72F47E5-C83A-4B85-96ED-D3E46671EE9A}", DrawArgs = {{3,0.5}}, connector_name = "S-25-R"},
	}
})

declare_loadout({
	category 		= CAT_ROCKETS,
	CLSID	 		= "{TWIN_B_8M1_S_8_OFP2}",
	wsTypeOfWeapon	= {4,	7,	33,	155},
	attribute		= {4,	7,	32,	WSTYPE_PLACEHOLDER},
	Count 			= 40,
	Cx_pil			= 0.0004,
	Picture			= "B8V20A.png",
	displayName		=	_("2 x B-8V20A pods - 40 x S-8OFP2, 80mm UnGd Rkts, HE/Frag/AP"),
	Weight			= 32+2*(137.5 + 20 * 16.7),
	JettisonSubmunitionOnly = true,
	Elements		=	{
	   {ShapeName = "su-27-twinpylon",IsAdapter = true},
	   {payload_CLSID = "B-8M1 - 20 S-8OFP2", DrawArgs = {{3,0.5}},connector_name = "S-25-L"},
	   {payload_CLSID = "B-8M1 - 20 S-8OFP2", DrawArgs = {{3,0.5}},connector_name = "S-25-R"},
	}
})

declare_loadout({
	category 		= CAT_ROCKETS,
	CLSID	 		= "{TWIN_B_8M1_S_8TsM}",
	wsTypeOfWeapon	= {4,	7,	33,	30},
	attribute		= {4,	7,	32,	WSTYPE_PLACEHOLDER},
	Count 			= 40,
	Cx_pil			= 0.0004,
	Picture			= "B8V20A.png",
	displayName		=	_("2 x B-8V20A pods - 40 x S-8TsM, 80mm UnGd Rkts, Smk"),
	Weight			= 32+2*(137.5 + 20 * 11.1),
	JettisonSubmunitionOnly = true,
	Elements		=	{
	   {ShapeName = "su-27-twinpylon",IsAdapter = true},
	   {payload_CLSID = "{3DFB7320-AB0E-11d7-9897-000476191836}", DrawArgs = {{3,0.5}}, connector_name = "S-25-L"},
	   {payload_CLSID = "{3DFB7320-AB0E-11d7-9897-000476191836}", DrawArgs = {{3,0.5}}, connector_name = "S-25-R"},
	}
})

declare_loadout({
	category 		= CAT_ROCKETS,
	CLSID	 		= "{APU_68_S-24}",
	wsTypeOfWeapon	= {4,	7,	33,	34},
	attribute		= {4,	7,	32,	WSTYPE_PLACEHOLDER},
	Count 			= 1,
	Cx_pil			= 0.0002,
	Picture			= "RBK250.png",
	displayName		= _("APU-68 - S-24B"),
	Weight			= 38.5 + 235,
	Elements		=	{
	   {ShapeName = "apu-68um3",IsAdapter = true},
	   {payload_CLSID = "{1FA14DEA-8CDB-45AD-88A8-EC068DF1E65A}", connector_name = "Point Pilon s24"},
	}
})

local AGR_20_M151_UNGUIDED =
{
	category		= CAT_ROCKETS,
	name			= "AGR_20_M151_unguided",
	user_name		= _("APKWS M151 unguided"),
	scheme			= "nurs-standard",
	class_name		= "wAmmunitionNURS",
	model			= "AGR_20",
	wsTypeOfWeapon 	= {wsType_Weapon, wsType_NURS, wsType_Rocket, WSTYPE_PLACEHOLDER},

	warhead		= predefined_warhead("HYDRA_70_M151"),

	shape_table_data =
	{
		{
			name  = "AGR_20_M151_unguided";
			file  = "AGR_20";
			life  = 1;
			fire  = { 0, 1};
			username = _("APKWS M151 unguided"),
			index 	 = WSTYPE_PLACEHOLDER,
		},
	},

	engine = {
		fuel_mass   				= 7.5,
		impulse     				= 210,
		boost_time  				= 0,
		work_time   				= 1.8,
		boost_factor				= 1,
		nozzle_position 	   		= {{-0.95, 0, 0}},
		nozzle_orientationXYZ		= {{0, 0, 0}},
		tail_width  				= 0.052,
		boost_tail  				= 1,
		work_tail   				= 1,
		smoke_color					= {0.5, 0.474, 0.443},
		smoke_transparency			= 0.5,
	},

	fm = {
		mass        = 15,
		caliber     = 0.07,
		cx_coeff    = {1, 1.5, 0.68, 0.7, 1.75},
		L           = 1.81,
		I           = 1 / 12 * 15 * 1.81 * 1.81,
		Ma          = 0.84,
		Mw          = 3.5,
		shapeName   = "AGR_20",
		wind_sigma	= 5,
		wind_time	= 1.8,
	},

	properties = {
		dist_min = 500,
		dist_max = 4000,
	},
}

declare_weapon(AGR_20_M151_UNGUIDED)

local AGR_20_M282_UNGUIDED =
{
	category		= CAT_ROCKETS,
	name			= "AGR_20_M282_unguided",
	user_name		= _("APKWS M282 unguided"),
	scheme			= "nurs-standard",
	class_name		= "wAmmunitionNURS",
	model			= "AGR_20",
	wsTypeOfWeapon 	= {wsType_Weapon, wsType_NURS, wsType_Rocket, WSTYPE_PLACEHOLDER},

	warhead		= predefined_warhead("HYDRA_70_M282"),

	shape_table_data =
	{
		{
			name  = "AGR_20_M282_unguided";
			file  = "AGR_20";
			life  = 1;
			fire  = { 0, 1};
			username = _("APKWS M282 unguided"),
			index 	 = WSTYPE_PLACEHOLDER,
		},
	},

	engine = {
		fuel_mass   				= 7.5,
		impulse     				= 210,
		boost_time  				= 0,
		work_time   				= 1.8,
		boost_factor				= 1,
		nozzle_position 	   		= {{-0.95, 0, 0}},
		nozzle_orientationXYZ		= {{0, 0, 0}},
		tail_width  				= 0.052,
		boost_tail  				= 1,
		work_tail   				= 1,
		smoke_color					= {0.5, 0.474, 0.443},
		smoke_transparency			= 0.5,
	},

	fm = {
		mass        = 17,
		caliber     = 0.07,
		cx_coeff    = {1, 1.5, 0.68, 0.7, 1.75},
		L           = 1.81,
		I           = 1 / 12 * 15 * 1.81 * 1.81,
		Ma          = 0.84,
		Mw          = 3.5,
		shapeName   = "AGR_20",
		wind_sigma	= 5,
		wind_time	= 1.8,
	},

	properties = {
		dist_min = 500,
		dist_max = 4000,
	},
}

declare_weapon(AGR_20_M282_UNGUIDED)

local Hydra_Mk66_Variants = BatchDeclareRockets({
	commonParams = {
		baseFM			= predefined_fm("Hydra70"),
		baseEngine		= predefined_engine("Mk66"),
	},
	variantSpecificParams = {
		["HYDRA_70_M151"] = {
			displayName		= _("Hydra 70 M151 HE"),
			schemeName		= "nurs-standard",
			modelFileName	= "hydra_m151he",
			payloadParams	= { warhead = predefined_warhead("HYDRA_70_M151") },
			paramOverrides	= { wsTypeOfWeaponL4 = HYDRA_70_M151 }
		},
		["HYDRA_70_M151_M433"] = {
			displayName		= _("Hydra 70 M151 HE, M433 RC Fuze"),
			schemeName		= "nurs-standard",
			modelFileName	= "hydra_m433",
			payloadParams	= { warhead = predefined_warhead("HYDRA_70_M151") },
		},
		["HYDRA_70_M156"] = {
			displayName		= _("Hydra 70 M156 SM"),
			schemeName		= "nurs-marker",
			modelFileName	= "hydra_m156",
			payloadParams	= { warhead = predefined_warhead("HYDRA_70_M156") },
			paramOverrides	= { wsTypeOfWeaponL4 = HYDRA_70_M156 }
		},
		["HYDRA_70_M229"] = {
			displayName		= _("Hydra 70 M229 HE"),
			schemeName		= "nurs-standard",
			modelFileName	= "hydra_m229",
			payloadParams	= { warhead = predefined_warhead("HYDRA_70_M229") },
		},
		["HYDRA_70_M257"] = {
			displayName		= _("Hydra 70 M257 IL"),
			schemeName		= "nurs-light",
			modelFileName	= "Hydra_M257",
			payloadParams	= { launcher = { ammunition = get_bomb_munition("M257_FLARE"), delay = 10.1 } },
			properties = {
				dist_min	= 1000,
				dist_max	= 4000,
				max_TOF		= 10.5 -- exaggerated a bit to avoid AI overshooting the target due to non-instant deceleration of the flare element
			},
			paramOverrides	= { wsTypeOfWeaponL4 = HYDRA_70_M257 }
		},
		["HYDRA_70_M259"] = {
			displayName		= _("Hydra 70 M259 SM"),
			schemeName		= "nurs-marker",
			modelFileName	= "hydra_wdu4aa", -- best match available rn
			payloadParams	= { warhead = predefined_warhead("HYDRA_70_M259") },
		},
		["HYDRA_70_M274"] = {
			displayName		= _("Hydra 70 M274 TP-SM"),
			schemeName		= "nurs-marker",
			modelFileName	= "hydra_m156", -- best match available rn
			payloadParams	= { warhead = predefined_warhead("HYDRA_70_M274") },
			paramOverrides	= { wsTypeOfWeaponL4 = HYDRA_70_M274 }
		},
		["HYDRA_70_M282"] = {
			displayName		= _("Hydra 70 M282 MPP"),
			schemeName		= "nurs-standard",
			modelFileName	= "hydra_m282",
			payloadParams	= { warhead = predefined_warhead("HYDRA_70_M282") },
		},
	}
})

declare_loadout({
	category		=	CAT_ROCKETS,
	CLSID			=	"{M151_HYDRA}",
	Count			=	1,
	Elements		=	{{ ShapeName = Hydra_Mk66_Variants["HYDRA_70_M151"].model }},
	Weight			=	Hydra_Mk66_Variants["HYDRA_70_M151"].fm.mass,
	wsTypeOfWeapon	=	Hydra_Mk66_Variants["HYDRA_70_M151"].wsTypeOfWeapon,
	attribute		=	Hydra_Mk66_Variants["HYDRA_70_M151"].wsTypeOfWeapon,
})

declare_loadout({
	category		=	CAT_ROCKETS,
	CLSID			=	"{M257_HYDRA}",
	Count			=	1,
	Elements		=	{{ ShapeName = Hydra_Mk66_Variants["HYDRA_70_M257"].model }},
	Weight			=	Hydra_Mk66_Variants["HYDRA_70_M257"].fm.mass,
	wsTypeOfWeapon	=	Hydra_Mk66_Variants["HYDRA_70_M257"].wsTypeOfWeapon,
	attribute		=	Hydra_Mk66_Variants["HYDRA_70_M257"].wsTypeOfWeapon,
})

declare_loadout({
	category		=	CAT_ROCKETS,
	CLSID			=	"{M274_HYDRA}",
	Count			=	1,
	Elements		=	{{ ShapeName = Hydra_Mk66_Variants["HYDRA_70_M274"].model }},
	Weight			=	Hydra_Mk66_Variants["HYDRA_70_M274"].fm.mass,
	wsTypeOfWeapon	=	Hydra_Mk66_Variants["HYDRA_70_M274"].wsTypeOfWeapon,
	attribute		=	Hydra_Mk66_Variants["HYDRA_70_M274"].wsTypeOfWeapon,
})

BatchDeclareLoadout(
	RLData.M261,
	{
		["M261_MK151"]	= { weaponResName = "HYDRA_70_M151" },
		["{M261_M151_M433}"] = { weaponResName = "HYDRA_70_M151_M433" },
		["M261_MK156"]	= { weaponResName = "HYDRA_70_M156" },
		["{M261_M229}"]	= { weaponResName = "HYDRA_70_M229" },
		["{M261_M257}"]	= { weaponResName = "HYDRA_70_M257" },
		["{M261_M259}"]	= { weaponResName = "HYDRA_70_M259" },
		["{M261_M274}"]	= { weaponResName = "HYDRA_70_M274" },
		["{M261_M282}"]	= { weaponResName = "HYDRA_70_M282" },
		["{M261_OUTBOARD_AB_M151_E_M274}"] = {
			multiWeaponTable = {
				["HYDRA_70_M151"] = 16,
				["HYDRA_70_M274"] = 3,
			},
			Elements		= fillM261Zones({ ["A"] = "{M151_HYDRA}", ["B"] = "{M151_HYDRA}", ["E"] = "{M274_HYDRA}" }),
			displayName		= _("M261 - 19 x Hydra 70, Pod Zones: A/B - M151; E - M274"),
			wsTypeOfWeapon	= "weapons.nurs.HYDRA_70_M151"
		},
		["{M261_OUTBOARD_AB_M151_E_M257}"] = {
			multiWeaponTable = {
				["HYDRA_70_M151"] = 16,
				["HYDRA_70_M257"] = 3,
			},
			Elements		= fillM261Zones({ ["A"] = "{M151_HYDRA}", ["B"] = "{M151_HYDRA}", ["E"] = "{M257_HYDRA}" }),
			displayName		= _("M261 - 19 x Hydra 70, Pod Zones: A/B - M151; E - M257"),
			wsTypeOfWeapon	= "weapons.nurs.HYDRA_70_M151"
		},
		["{M261_INBOARD_DE_M151_C_M274}"] = {
			multiWeaponTable = {
				["HYDRA_70_M151"] = 16,
				["HYDRA_70_M274"] = 3,
			},
			Elements		= fillM261Zones({ ["C"] = "{M274_HYDRA}", ["D"] = "{M151_HYDRA}", ["E"] = "{M151_HYDRA}" }),
			displayName		= _("M261 - 19 x Hydra 70, Pod Zones: C - M274; D/E - M151"),
			wsTypeOfWeapon	= "weapons.nurs.HYDRA_70_M151"
		},
		["{M261_INBOARD_DE_M151_C_M257}"] = {
			multiWeaponTable = {
				["HYDRA_70_M151"] = 16,
				["HYDRA_70_M257"] = 3,
			},
			Elements		= fillM261Zones({ ["C"] = "{M257_HYDRA}", ["D"] = "{M151_HYDRA}", ["E"] = "{M151_HYDRA}" }),
			displayName		= _("M261 - 19 x Hydra 70, Pod Zones: C - M257; D/E - M151"),
			wsTypeOfWeapon	= "weapons.nurs.HYDRA_70_M151"
		},
	},
	Hydra_Mk66_Variants
)

declare_loadout({
	category		=	CAT_ROCKETS,
	CLSID			=	"{UB-32A-24}",
	Picture			=	"rus_UB-32_S-5KO.png",
	PictureBlendColor = "0xffffffff",
	Cx_pil			=	0.00196533203125,
	displayName		=	_("UB-32A-24 pod - 32 x S-5KO"),
	Count			=	32,
	Elements		=	ContainerWithSubshapes("UB_32A_24", "S-5KO", 32, "tube_%d"),
	Weight			=	275,
	wsTypeOfWeapon	=	{4,	7,	33,	31},
	attribute		=	{4,	7,	32,	WSTYPE_PLACEHOLDER},
})

local ARF8M3_Variants = BatchDeclareRockets({
	commonParams = {
		baseFM			= predefined_fm("ARF8M3"),
		baseEngine		= predefined_engine("ARF8M3"),
	},
	variantSpecificParams = {
		["ARF8M3API"] = {
			displayName		= _("ARF-8/M3 API"),
			schemeName		= "nurs-standard",
			payloadParams	= { warhead = predefined_warhead("ARF8M3API")},
			modelFileName	= "ARF8M3_API",
			properties		= { dist_min = 450, dist_max = 4500 }
		},
		["ARF8M3HEI"] = {
			displayName		= _("ARF-8/M3 HEI Heavy"),
			schemeName		= "nurs-standard",
			payloadParams	= { warhead = predefined_warhead("ARF8M3HEIHeavy")},
			modelFileName	= "ARF8M3_HEI",
			properties		= { dist_min = 450, dist_max = 4500 }
		},
		["ARF8M3TPSM"] = {
			displayName		= _("ARF-8/M3 TP-SM"),
			schemeName		= "nurs-marker",
			payloadParams	= { warhead = predefined_warhead("ARF8M3TPSM")},
			modelFileName	= "ARF8M3_TP",
			properties		= { dist_min = 450, dist_max = 4500 }
		},
	}
})

BatchDeclareLoadout(
	RLData.LR25,
	{
		["{LR25_ARF8M3_API}"]	= { weaponResName = "ARF8M3API", },
		["{LR25_ARF8M3_HEI}"]	= { weaponResName = "ARF8M3HEI", },
		["{LR25_ARF8M3_TPSM}"]	= { weaponResName = "ARF8M3TPSM", },
	},
	ARF8M3_Variants
)

local S_25_O = {
	category		= CAT_ROCKETS,
	name			= "S-25-O",
	user_name		= _("S-25-O"),
	scheme			= "nurs-standard",
	class_name		= "wAmmunitionNURS",
	model			= "C-25O",
	wsTypeOfWeapon 	= {wsType_Weapon, wsType_NURS, wsType_Rocket, WSTYPE_PLACEHOLDER},

	fm = {
		mass        = 380,
		caliber     = 0.42, 
		cx_coeff    = {1,0.8459661,0.67,0.3019448,2.08},
		L           = 3.31,
		I           = 433.01467,
		Ma          = 0.192352,
		Mw          = 2.521688,
		shapeName   = "C-25O",
		wind_time   = 2.2,
		wind_sigma  = 3,
	},

	engine = predefined_engine("9GSch605"),

	warhead = predefined_warhead("S_25_O"),

	properties = {
		dist_min = 1600,
		dist_max = 3000
	},

	shape_table_data = {{
		name  = "S-25-O";
		file  = "C-25O";
		username = _("S-25-O Frag"),
		index 	 = WSTYPE_PLACEHOLDER,
	}},
}
declare_weapon(S_25_O)

rockets_data["S_25_O"] = {name = _("S-25-O - 420mm UnGd Rkt, 380kg Frag"), payload_CLSID = "{S_25_O}", mass = S_25_O.fm.mass + 65, mass_empty = 65, wsType = S_25_O.wsTypeOfWeapon, Cx = 0.001708984375, picture = "S25.png"}

declare_loadout({
	category		= CAT_ROCKETS,
	CLSID			= rockets_data["S_25_O"].payload_CLSID,
	Picture			= rockets_data["S_25_O"].picture,
	Cx_pil			= rockets_data["S_25_O"].Cx,
	displayName		= rockets_data["S_25_O"].name,
	Count			= 1,
	Elements		= {
		{ ShapeName = "C-25PU", IsAdapter = true, DrawArgs = {{3, 0.5}}},
		{ ShapeName = "C-25O", DrawArgs = {{2, 1}}, connector_name = "tube_1"}
	},
	Weight			= rockets_data["S_25_O"].mass,
	Weight_Empty	= rockets_data["S_25_O"].mass_empty,
	wsTypeOfWeapon	= rockets_data["S_25_O"].wsType,
	attribute		= {wsType_Weapon, wsType_NURS, wsType_Container, WSTYPE_PLACEHOLDER},
})

declare_loadout({
	category		= CAT_ROCKETS,
	CLSID			= "{TWIN_S25_O}",
	Picture			= rockets_data["S_25_O"].picture,
	Cx_pil			= 0.0004 + 2 * rockets_data["S_25_O"].Cx,
	displayName		= "2 x " .. rockets_data["S_25_O"].name,
	Count			= 2,
	JettisonSubmunitionOnly = true,
	Elements		= {
		{ ShapeName = "su-27-twinpylon", IsAdapter = true },
		{ payload_CLSID = rockets_data["S_25_O"].payload_CLSID, connector_name = "S-25-L" },
		{ payload_CLSID = rockets_data["S_25_O"].payload_CLSID, connector_name = "S-25-R" },
	},
	Weight			= 32 + 2 * rockets_data["S_25_O"].mass,
	Weight_Empty	= 32 + 2 * rockets_data["S_25_O"].mass_empty,
	wsTypeOfWeapon	= rockets_data["S_25_O"].wsType,
	attribute		= {wsType_Weapon, wsType_NURS, wsType_Container, WSTYPE_PLACEHOLDER},
})

local SNEB68_F1B_Variants = BatchDeclareRockets({
	commonParams = {
		baseFM			= predefined_fm("SNEB68"),
		baseEngine		= predefined_engine("SNEBType25F1B"),
		displayNamePfx	= _("68 mm"),
		modelFileName	= "SA342_SNEB68"
	},
	variantSpecificParams = {
		["SNEB_TYPE250_F1B"] = {
			displayName		= _("SNEB Type 250 F1B TP-SM"),
			schemeName		= "nurs-marker",
			payloadParams	= { warhead = predefined_warhead("SNEBType20") },
		},
		["SNEB_TYPE251_F1B"] = {
			displayName		= _("SNEB Type 251 F1B HE"),
			schemeName		= "nurs-standard",
			payloadParams	= { warhead = predefined_warhead("SNEBType21") },
		},
		["SNEB_TYPE252_F1B"] = {
			displayName		= _("SNEB Type 252 F1B TP"),
			schemeName		= "nurs-standard",
			payloadParams	= { warhead = predefined_warhead("SNEBType22") },
		},
		["SNEB_TYPE253_F1B"] = {
			displayName		= _("SNEB Type 253 F1B HEAT"),
			schemeName		= "nurs-standard",
			payloadParams	= { warhead = predefined_warhead("SNEBType23") },
		},
		["SNEB_TYPE254_F1B_RED"] = {
			displayName		= _("SNEB Type 254 F1B SM Red"),
			schemeName		= "nurs-marker",
			payloadParams	= { warhead = predefined_warhead("SNEBType24Red") },
		},
		["SNEB_TYPE254_F1B_YELLOW"] = {
			displayName		= _("SNEB Type 254 F1B SM Yellow"),
			schemeName		= "nurs-marker",
			payloadParams	= { warhead = predefined_warhead("SNEBType24Yellow") },
		},
		["SNEB_TYPE254_F1B_GREEN"] = {
			displayName		= _("SNEB Type 254 F1B SM Green"),
			schemeName		= "nurs-marker",
			payloadParams	= { warhead = predefined_warhead("SNEBType24Green") },
		},
		["SNEB_TYPE256_F1B"] = {
			displayName		= _("SNEB Type 256 F1B HE/Frag"),
			schemeName		= "nurs-standard",
			payloadParams	= { warhead = predefined_warhead("SNEBType26") },
		},
		["SNEB_TYPE257_F1B"] = {
			displayName		= _("SNEB Type 257 F1B HE/Frag Lg Whd"),
			schemeName		= "nurs-standard",
			payloadParams	= { warhead = predefined_warhead("SNEBType27") },
		},
		["SNEB_TYPE259E_F1B"] = {
			displayName		= _("SNEB Type 259E F1B IL"),
			schemeName		= "nurs-light",
			payloadParams	= { launcher = { ammunition = get_bomb_munition("SAB_100_LE"), delay = 10.1 } },
		},
	}
})

local SNEB68_Rotary_Variants = BatchDeclareRockets({
	commonParams = {
		baseFM			= predefined_fm("SNEB68"),
		baseEngine		= predefined_engine("SNEBType25H1"),
		displayNamePfx	= _("68 mm"),
		modelFileName	= "SA342_SNEB68",
	},
	variantSpecificParams = {
		["SNEB_TYPE251_H1"] = {
			displayName		= _("SNEB Type 251 H1 HE"),
			schemeName		= "nurs-standard",
			payloadParams	= { warhead = predefined_warhead("SNEBType21") },
		},
		["SNEB_TYPE252_H1"] = {
			displayName		= _("SNEB Type 252 H1 TP"),
			schemeName		= "nurs-standard",
			payloadParams	= { warhead = predefined_warhead("SNEBType22") },
		},
		["SNEB_TYPE253_H1"] = {
			displayName		= _("SNEB Type 253 H1 HEAT"),
			schemeName		= "nurs-standard",
			payloadParams	= { warhead = predefined_warhead("SNEBType23") },
		},
		["SNEB_TYPE254_H1_RED"] = {
			displayName		= _("SNEB Type 254 H1 SM Red"),
			schemeName		= "nurs-marker",
			payloadParams	= { warhead = predefined_warhead("SNEBType24Red") },
		},
		["SNEB_TYPE254_H1_YELLOW"] = {
			displayName		= _("SNEB Type 254 H1 SM Yellow"),
			schemeName		= "nurs-marker",
			payloadParams	= { warhead = predefined_warhead("SNEBType24Yellow") },
		},
		["SNEB_TYPE254_H1_GREEN"] = {
			displayName		= _("SNEB Type 254 H1 SM Green"),
			schemeName		= "nurs-marker",
			payloadParams	= { warhead = predefined_warhead("SNEBType24Green") },
		},
		["SNEB_TYPE256_H1"] = {
			displayName		= _("SNEB Type 256 H1 HE/Frag"),
			schemeName		= "nurs-standard",
			payloadParams	= { warhead = predefined_warhead("SNEBType26") },
		},
		["SNEB_TYPE257_H1"] = {
			displayName		= _("SNEB Type 257 H1 HE/Frag Lg Whd"),
			schemeName		= "nurs-standard",
			payloadParams	= { warhead = predefined_warhead("SNEBType27") },
		},
		["SNEB_TYPE259E_H1"] = {
			displayName		= _("SNEB Type 259E H1 IL"),
			schemeName		= "nurs-light",
			payloadParams	= { launcher = { ammunition = get_bomb_munition("SAB_100_LE"), delay = 10.1 } },
		},
	}
})

BatchDeclareLoadout(
	RLData.MATRAF1,
	{
		["{MATRA_F1_SNEBT250}"]			= { weaponResName = "SNEB_TYPE250_F1B" },
		["{MATRA_F1_SNEBT251}"]			= { weaponResName = "SNEB_TYPE251_F1B" },
		["{MATRA_F1_SNEBT252}"]			= { weaponResName = "SNEB_TYPE252_F1B" },
		["{MATRA_F1_SNEBT253}"]			= { weaponResName = "SNEB_TYPE253_F1B" },
		["{MATRA_F1_SNEBT254_RED}"]		= { weaponResName = "SNEB_TYPE254_F1B_RED" },
		["{MATRA_F1_SNEBT254_YELLOW}"]	= { weaponResName = "SNEB_TYPE254_F1B_YELLOW" },
		["{MATRA_F1_SNEBT254_GREEN}"]	= { weaponResName = "SNEB_TYPE254_F1B_GREEN" },
		["{MATRA_F1_SNEBT256}"]			= { weaponResName = "SNEB_TYPE256_F1B" },
		["{MATRA_F1_SNEBT257}"]			= { weaponResName = "SNEB_TYPE257_F1B" },
		["{MATRA_F1_SNEBT259E}"]		= { weaponResName = "SNEB_TYPE259E_F1B" },
	},
	SNEB68_F1B_Variants
)

BatchDeclareLoadout(
	RLData.MATRAF4,
	{
		["{MATRA_F4_SNEBT250}"]			= { weaponResName = "SNEB_TYPE250_F1B" },
		["{MATRA_F4_SNEBT251}"]			= { weaponResName = "SNEB_TYPE251_F1B" },
		["{MATRA_F4_SNEBT252}"]			= { weaponResName = "SNEB_TYPE252_F1B" },
		["{MATRA_F4_SNEBT253}"]			= { weaponResName = "SNEB_TYPE253_F1B" },
		["{MATRA_F4_SNEBT254_RED}"]		= { weaponResName = "SNEB_TYPE254_F1B_RED" },
		["{MATRA_F4_SNEBT254_YELLOW}"]	= { weaponResName = "SNEB_TYPE254_F1B_YELLOW" },
		["{MATRA_F4_SNEBT254_GREEN}"]	= { weaponResName = "SNEB_TYPE254_F1B_GREEN" },
		["{MATRA_F4_SNEBT256}"]			= { weaponResName = "SNEB_TYPE256_F1B" },
		["{MATRA_F4_SNEBT257}"]			= { weaponResName = "SNEB_TYPE257_F1B" },
		["{MATRA_F4_SNEBT259E}"]		= { weaponResName = "SNEB_TYPE259E_F1B" },
	},
	SNEB68_F1B_Variants
)

-- Type 250 is available only with F1B motor
SNEB68_Rotary_Variants["SNEB_TYPE250_F1B"] = SNEB68_F1B_Variants["SNEB_TYPE250_F1B"]

BatchDeclareLoadout(
	RLData.TELSON8,
	{
		["{TELSON8_SNEBT250}"]			= { weaponResName = "SNEB_TYPE250_F1B", Picture = "SNEB68_Smoke.png" },
		["{TELSON8_SNEBT251}"]			= { weaponResName = "SNEB_TYPE251_H1" },
		["{TELSON8_SNEBT252}"]			= { weaponResName = "SNEB_TYPE252_H1" },
		["{TELSON8_SNEBT253}"]			= { weaponResName = "SNEB_TYPE253_H1" },
		["{TELSON8_SNEBT254_RED}"]		= { weaponResName = "SNEB_TYPE254_H1_RED", Picture = "SNEB68_Smoke.png", PictureBlendColor = "0xff0000ff" },
		["{TELSON8_SNEBT254_YELLOW}"]	= { weaponResName = "SNEB_TYPE254_H1_YELLOW", Picture = "SNEB68_Smoke.png", PictureBlendColor = "0xffff00ff" },
		["{TELSON8_SNEBT254_GREEN}"]	= { weaponResName = "SNEB_TYPE254_H1_GREEN", Picture = "SNEB68_Smoke.png", PictureBlendColor = "0x00ff00ff" },
		["{TELSON8_SNEBT256}"]			= { weaponResName = "SNEB_TYPE256_H1" },
		["{TELSON8_SNEBT257}"]			= { weaponResName = "SNEB_TYPE257_H1" },
		["{TELSON8_SNEBT259E}"]			= { weaponResName = "SNEB_TYPE259E_H1" },
		-- Backwards-compatibility section
		["{LAU_SNEB68_WP}"]				= { weaponResName = "SNEB_TYPE250_F1B", Picture = "SNEB68_Smoke.png" },
		["{LAU_SNEB68G}"]				= { weaponResName = "SNEB_TYPE253_H1" },
	},
	SNEB68_Rotary_Variants
)
