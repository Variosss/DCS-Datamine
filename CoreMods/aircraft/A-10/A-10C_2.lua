-- NOTE: A-10A.lua and A-10C.lua are expected to be executed before

-- 'A_10C_2' defines only differences between A-10C 2 and A-10C
local A_10C_2 =  {
	Name 				= "A-10C_2",
	
	Shape 				= "A-10CII",
	
	livery_entry		= "A-10CII",
	
	shape_table_data 	= 
	{
		{
			file  = "A-10CII";
			username = "A-10C II";
			index = WSTYPE_PLACEHOLDER;
			life  = 32; 					-- прочность объекта (методом lifebar*) -- The strength of the object (ie. lifebar *)
			vis   = 3; 						-- множитель видимости (для маленьких объектов лучше ставить поменьше). Visibility factor (For a small objects is better to put lower nr).
			desrt = "A-10_DAM"; 			-- Name of destroyed object file name
			fire  = { 300, 2}; 				-- Fire on the ground after destoyed: 300sec 4m
		},
		{
			file  = "A-10_DAM";
			fire  = { 0, 1};
		}
	},
	
	DisplayName			=	_("A-10C II"),
	WorldID				=	WSTYPE_PLACEHOLDER,
	attribute 			=   {wsType_Air, wsType_Airplane, wsType_Battleplane, WSTYPE_PLACEHOLDER, "Battleplanes", "Refuelable", "Datalink", "Link16"},
	input_profile_entry = 	"A-10C II",

	--Countries 			= 	{"USA"},
	
	-- moved to common aircraft options
	--[[
	AddPropAircraft = {
		{ id = "DefaultGunMode", control = 'comboList', label = _('Default Gun Mode'), playerOnly = true, 
		  values = {{id = 0, dispName = _("CCIP Gun Reticle")},
					{id = 1, dispName = _("CCIP Gun Cross")}
				   },
		  defValue  = 0,
		  wCtrl     = 150
		},
	},		
	]]
	
	-- Countermeasures
	-- Flares maximum count is 480 (vs older count of 240) with the new A-10C countermeasure flare buckets
	passivCounterm = {
		CMDS_Edit = true,
		SingleChargeTotal = 480,
		-- RR-170 - 30 cartridges per magazine, increment by 2 magazines
		chaff = {default = 240, increment = 60, chargeSz = 1},
		-- Unknown type - 30 cartridges per magazine, increment by 2 magazines
		flare = {default = 240, increment = 60, chargeSz = 1}
	},
	
	Pylons =	{
        pylon(1, 0, -0.615000, -0.016000, -6.365000,
            {
				use_full_connector_position=true,
            },
            {
                { CLSID = "{DB434044-F5D0-4F1F-9BA9-B73027E18DD3}" },
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, -- MK-82				
				{ CLSID = "LAU-105_1*AIM-9M_L" },
				{ CLSID = "LAU-105" },
				{ CLSID = "LAU-105_2*CATM-9M" },
				{ CLSID = "LAU-105_1*CATM-9M_L" },
				{ CLSID = "{6D21ECEA-F85B-4E8D-9D51-31DC9B8AA4EF}" },
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}" },
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}" },
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}" },
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}" },
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}" },
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}" },
				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" }, -- GBU-12
				{ CLSID = "{BDU-50LD}" },
				{ CLSID = "{BDU-50LGB}" }, -- BDU-50LGB
				{ CLSID = "{BDU-50HD}" },
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "ALQ_184" }, -- ALQ-184		
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "LAU-105_AIS_ASQ_T50_L" },	-- ACMI
				{ CLSID = "LAU-105_2*AIM-9L"}, -- AIM-9Lx2
				{ CLSID = "LAU-105_1*AIM-9L_L"}, -- AIM-9Lx1
            }
        ),
        pylon(2, 0, -0.615000, -0.144000, -5.408000,
            {
 				use_full_connector_position=true,
            },
            {
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, -- MK-82
                { CLSID = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}" }, -- AAQ-28
				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" }, -- GBU-12
				{ CLSID = "{BDU-50LD}" },
				{ CLSID = "{BDU-50HD}" },
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{FC85D2ED-501A-48ce-9863-49D468DDD5FC}" }, -- LAU-68 with Mk1
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, -- LAU-68 with Mk5
				{ CLSID = "{65396399-9F5C-4ec3-A7D2-5A8F4C1D90C4}" }, -- LAU-68 with Mk61
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68 with Mk151
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU-68 with Mk156
				{ CLSID = "{1F7136CB-8120-4e77-B97B-945FF01FB67C}" }, -- LAU-68 with WTU1B
				{ CLSID = "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}" }, -- LAU-68 with M257
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}" }, -- LAU-68 with M274
				{ CLSID = "{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}" }, -- LAU-68 with M278
				{ CLSID = "{D22C2D63-E5C9-4247-94FB-5E8F3DE22B71}" }, -- LAU-131 with Mk1
				{ CLSID = "{319293F2-392C-4617-8315-7C88C22AF7C4}" }, -- LAU-131 with Mk5
				{ CLSID = "{1CA5E00B-D545-4ff9-9B53-5970E292F14D}" }, -- LAU-131 with Mk61
				{ CLSID = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}" }, -- LAU-131 with Mk151
				{ CLSID = "{2AF2EC3F-9065-4de5-93E1-1739C9A71EF7}" }, -- LAU-131 with Mk156
				{ CLSID = "{DDCE7D70-5313-4181-8977-F11018681662}" }, -- LAU-131 with WTU1B
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}" }, -- LAU-131 with M257
				{ CLSID = "{6D6D5C07-2A90-4a68-9A74-C5D0CFFB05D9}" }, -- LAU-131 with M274
				{ CLSID = "{1FE353C6-5EB6-4d22-9CFD-6DB384EC7296}" }, -- LAU-131 with M278
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{BDU-50LGB}" }, -- BDU-50LGB
				{ CLSID = "{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}" }, -- SUU-25
				{ CLSID = "{LAU-131 - 7 AGR-20A}" }, -- LAU-131 with M151 APKWS
				{ CLSID = "{LAU-131 - 7 AGR-20 M282}" }, -- LAU-131 with M282 APKWS
			}
        ),
        pylon(3, 0, -0.615000, -0.337000, -4.015000,
            {
				use_full_connector_position=true,
            },
            {
                { CLSID = "{69DC8AE7-8F77-427B-B8AA-B19D3F478B66}" }, -- LAU-117 AGM-65K
                { CLSID = "LAU_88_AGM_65D_ONE" }, -- LAU-88 AGM-65D*1
				{ CLSID = "{E6A6262A-CA08-4B3D-B030-E1A993B98452}" }, -- LAU-88 AGM-65D*2
				{ CLSID = "{DAC53A2F-79CA-42FF-A77A-F5649B601308}" },  -- LAU-88 AGM-65D*3
                { CLSID = "{444BA8AE-82A7-4345-842E-76154EFCCA46}" }, -- LAU-117 AGM-65D
				--{ CLSID = "{F16A4DE0-116C-4A71-97F0-2CF85B0313EC}" }, -- AGM-65E LAU-117
				{ CLSID = "LAU_117_AGM_65L" }, -- LAU-117 AGM-65L
                { CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" }, -- MK-84
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, -- MK-82
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- TER MK-82
 				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" }, -- GBU-12
				{ CLSID = "{BDU-50LD}" },
				{ CLSID = "{BDU-50HD}" },
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" }, -- GBU-10
				{ CLSID = "{GBU-31}" },
				{ CLSID = "{GBU-31V3B}" },				
				{ CLSID = "{GBU-38}" },
				{ CLSID = "{FC85D2ED-501A-48ce-9863-49D468DDD5FC}" }, -- LAU-68 with Mk1
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, -- LAU-68 with Mk5
				{ CLSID = "{65396399-9F5C-4ec3-A7D2-5A8F4C1D90C4}" }, -- LAU-68 with Mk61
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68 with Mk151
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU-68 with Mk156
				{ CLSID = "{1F7136CB-8120-4e77-B97B-945FF01FB67C}" }, -- LAU-68 with WTU1B
				{ CLSID = "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}" }, -- LAU-68 with M257
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}" }, -- LAU-68 with M274
				{ CLSID = "{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}" }, -- LAU-68 with M278
				{ CLSID = "{D22C2D63-E5C9-4247-94FB-5E8F3DE22B71}" }, -- LAU-131 with Mk1
				{ CLSID = "{319293F2-392C-4617-8315-7C88C22AF7C4}" }, -- LAU-131 with Mk5
				{ CLSID = "{1CA5E00B-D545-4ff9-9B53-5970E292F14D}" }, -- LAU-131 with Mk61
				{ CLSID = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}" }, -- LAU-131 with Mk151
				{ CLSID = "{2AF2EC3F-9065-4de5-93E1-1739C9A71EF7}" }, -- LAU-131 with Mk156
				{ CLSID = "{DDCE7D70-5313-4181-8977-F11018681662}" }, -- LAU-131 with WTU1B
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}" }, -- LAU-131 with M257
				{ CLSID = "{6D6D5C07-2A90-4a68-9A74-C5D0CFFB05D9}" }, -- LAU-131 with M274
				{ CLSID = "{1FE353C6-5EB6-4d22-9CFD-6DB384EC7296}" }, -- LAU-131 with M278
				{ CLSID = "{443364AE-D557-488e-9499-45EDB3BA6730}" }, -- LAU-68x3 with MK1
				{ CLSID = "{9BC82B3D-FE70-4910-B2B7-3E54EFE73262}" }, -- LAU-68x3 with Mk5
				{ CLSID = "{C0FA251E-B645-4ce5-926B-F4BC20822F8B}" }, -- LAU-68x3 with Mk61
				{ CLSID = "{64329ED9-B14C-4c0b-A923-A3C911DA1527}" }, -- LAU-68x3 with Mk151
				{ CLSID = "{C2593383-3CA8-4b18-B73D-0E750BCA1C85}" }, -- LAU-68x3 with Mk156
				{ CLSID = "{A1853B38-2160-4ffe-B7E9-9BF81E6C3D77}" }, -- LAU-68x3 with WTU1B
				{ CLSID = "{4C044B08-886B-46c8-9B1F-AB05B3ED9C1D}" }, -- LAU-68x3 with M257
				{ CLSID = "{E6966004-A525-4f47-AF94-BCFEDF8FDBDA}" }, -- LAU-68x3 with M274
				{ CLSID = "{B2DC636E-5E45-42db-81D9-38F3E059107C}" }, -- LAU-68x3 with M278
				{ CLSID = "LAU_131x3_HYDRA_70_MK1" }, -- LAU-131x3 with MK1
				{ CLSID = "LAU_131x3_HYDRA_70_MK5" }, -- LAU-131x3 with Mk5
				{ CLSID = "LAU_131x3_HYDRA_70_MK61" }, -- LAU-131x3 with Mk61
				{ CLSID = "LAU_131x3_HYDRA_70_M151" }, -- LAU-131x3 with Mk151
				{ CLSID = "LAU_131x3_HYDRA_70_M156" }, -- LAU-131x3 with Mk156
				{ CLSID = "LAU_131x3_HYDRA_70_WTU1B" }, -- LAU-131x3 with WTU1B
				{ CLSID = "LAU_131x3_HYDRA_70_M257" }, -- LAU-131x3 with M257
				{ CLSID = "LAU_131x3_HYDRA_70_M274" }, -- LAU-131x3 with M274
				{ CLSID = "LAU_131x3_HYDRA_70_M278" }, -- LAU-131x3 with M278
				{ CLSID = "MXU-648-TP" }, --MXU-648 Travel Pod
				{ CLSID = "BRU-42_LS" },
				{ CLSID = "BRU-42_3*BDU-33"},
				{ CLSID = "LAU_117_AGM_65H" }, -- LAU-117 AGM-65H
				{ CLSID = "LAU_117_AGM_65G" }, -- LAU-117 AGM-65G
				{ CLSID = "LAU_88_AGM_65H" },  -- LAU-88 AGM-65H
				{ CLSID = "LAU_88_AGM_65H_2_L"},
				{ CLSID = "LAU_88_AGM_65H_3"},
				{ CLSID = "LAU_117_TGM_65D"},
				{ CLSID = "LAU_117_TGM_65G"},
				{ CLSID = "LAU_117_TGM_65H"},
				{ CLSID = "LAU_117_CATM_65K"},
				{ CLSID = "BRU-42_3*GBU-12"}, -- BRU-42 3*GBU-12
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{CBU_105}" }, -- CBU-105
				{ CLSID = "{CBU_103}" }, -- CBU-103
				{ CLSID = "{BDU-50LGB}" }, -- BDU-50LGB
				{ CLSID = "{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}" }, -- SUU-25
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, -- TER MK-82AIR
				{ CLSID = "{BRU-42_LS_3*SUU-25_8*LUU-2}" },
				{ CLSID = "{LAU-131 - 7 AGR-20A}" }, -- LAU-131 with M151 APKWS
				{ CLSID = "{LAU-131 - 7 AGR-20 M282}" }, -- LAU-131 with M282 APKWS
				{ CLSID = "{LAU-131x3 - 7 AGR-20A}" }, -- LAU-131x3 with M151 APKWS
				{ CLSID = "{LAU-131x3 - 7 AGR-20 M282}" }, -- LAU-131x3 with M282 APKWS
				{ CLSID = "{GBU_54_V_1B}" }, -- GBU-54/B Laser JDAM
				}
        ),
        pylon(4, 0, -0.615000, -0.501000, -1.853000,
            {
				use_full_connector_position=true,
            },
            {
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
                { CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" },
				{ CLSID = "Fuel_Tank_FT600" },
  				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },
				{ CLSID = "{BDU-50LD}" },
				{ CLSID = "{BDU-50HD}" },
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" }, -- GBU-10
				{ CLSID = "{GBU-31}" },
				{ CLSID = "{GBU-31V3B}" },				
				{ CLSID = "{GBU-38}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{FC85D2ED-501A-48ce-9863-49D468DDD5FC}" }, -- LAU-68 with Mk1
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, -- LAU-68 with Mk5
				{ CLSID = "{65396399-9F5C-4ec3-A7D2-5A8F4C1D90C4}" }, -- LAU-68 with Mk61
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68 with Mk151
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU-68 with Mk156
				{ CLSID = "{1F7136CB-8120-4e77-B97B-945FF01FB67C}" }, -- LAU-68 with WTU1B
				{ CLSID = "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}" }, -- LAU-68 with M257
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}" }, -- LAU-68 with M274
				{ CLSID = "{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}" }, -- LAU-68 with M278
				{ CLSID = "{D22C2D63-E5C9-4247-94FB-5E8F3DE22B71}" }, -- LAU-131 with Mk1
				{ CLSID = "{319293F2-392C-4617-8315-7C88C22AF7C4}" }, -- LAU-131 with Mk5
				{ CLSID = "{1CA5E00B-D545-4ff9-9B53-5970E292F14D}" }, -- LAU-131 with Mk61
				{ CLSID = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}" }, -- LAU-131 with Mk151
				{ CLSID = "{2AF2EC3F-9065-4de5-93E1-1739C9A71EF7}" }, -- LAU-131 with Mk156
				{ CLSID = "{DDCE7D70-5313-4181-8977-F11018681662}" }, -- LAU-131 with WTU1B
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}" }, -- LAU-131 with M257
				{ CLSID = "{6D6D5C07-2A90-4a68-9A74-C5D0CFFB05D9}" }, -- LAU-131 with M274
				{ CLSID = "{1FE353C6-5EB6-4d22-9CFD-6DB384EC7296}" }, -- LAU-131 with M278
				{ CLSID = "{443364AE-D557-488e-9499-45EDB3BA6730}" }, -- LAU-68x3 with MK1
				{ CLSID = "{9BC82B3D-FE70-4910-B2B7-3E54EFE73262}" }, -- LAU-68x3 with Mk5
				{ CLSID = "{C0FA251E-B645-4ce5-926B-F4BC20822F8B}" }, -- LAU-68x3 with Mk61
				{ CLSID = "{64329ED9-B14C-4c0b-A923-A3C911DA1527}" }, -- LAU-68x3 with Mk151
				{ CLSID = "{C2593383-3CA8-4b18-B73D-0E750BCA1C85}" }, -- LAU-68x3 with Mk156
				{ CLSID = "{A1853B38-2160-4ffe-B7E9-9BF81E6C3D77}" }, -- LAU-68x3 with WTU1B
				{ CLSID = "{4C044B08-886B-46c8-9B1F-AB05B3ED9C1D}" }, -- LAU-68x3 with M257
				{ CLSID = "{E6966004-A525-4f47-AF94-BCFEDF8FDBDA}" }, -- LAU-68x3 with M274
				{ CLSID = "{B2DC636E-5E45-42db-81D9-38F3E059107C}" }, -- LAU-68x3 with M278
				{ CLSID = "LAU_131x3_HYDRA_70_MK1" }, -- LAU-131x3 with MK1
				{ CLSID = "LAU_131x3_HYDRA_70_MK5" }, -- LAU-131x3 with Mk5
				{ CLSID = "LAU_131x3_HYDRA_70_MK61" }, -- LAU-131x3 with Mk61
				{ CLSID = "LAU_131x3_HYDRA_70_M151" }, -- LAU-131x3 with Mk151
				{ CLSID = "LAU_131x3_HYDRA_70_M156" }, -- LAU-131x3 with Mk156
				{ CLSID = "LAU_131x3_HYDRA_70_WTU1B" }, -- LAU-131x3 with WTU1B
				{ CLSID = "LAU_131x3_HYDRA_70_M257" }, -- LAU-131x3 with M257
				{ CLSID = "LAU_131x3_HYDRA_70_M274" }, -- LAU-131x3 with M274
				{ CLSID = "LAU_131x3_HYDRA_70_M278" }, -- LAU-131x3 with M278
				{ CLSID = "MXU-648-TP" }, --MXU-648 Travel Pod
				{ CLSID = "BRU-42_LS" },
				{ CLSID = "BRU-42_3*BDU-33"},
				{ CLSID = "BRU-42_3*GBU-12"}, -- BRU-42 3*GBU-12
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{CBU_105}" }, -- CBU-105
				{ CLSID = "{CBU_103}" }, -- CBU-103
				{ CLSID = "{BDU-50LGB}" }, -- BDU-50LGB
				{ CLSID = "{BRU-42_3*Mk-82AIR}" },
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- TER 3*MK82
				{ CLSID = "{LAU-131 - 7 AGR-20A}" }, -- LAU-131 with M151 APKWS
				{ CLSID = "{LAU-131 - 7 AGR-20 M282}" }, -- LAU-131 with M282 APKWS
				{ CLSID = "{LAU-131x3 - 7 AGR-20A}" }, -- LAU-131x3 with M151 APKWS
				{ CLSID = "{LAU-131x3 - 7 AGR-20 M282}" }, -- LAU-131x3 with M282 APKWS
				{ CLSID = "{GBU_54_V_1B}" }, -- GBU-54/B Laser JDAM
				}
        ),
        pylon(5, 0, -0.615000, -0.501000, -0.587000,
            {
 				use_full_connector_position=true,
            },
            {
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
                { CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" },
  				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },
				{ CLSID = "{BDU-50LD}" },
				{ CLSID = "{BDU-50HD}" },
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" }, -- GBU-10
				{ CLSID = "{GBU-31}" },
				{ CLSID = "{GBU-31V3B}" },
				{ CLSID = "{GBU-38}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "MXU-648-TP" }, --MXU-648 Travel Pod
				{ CLSID = "BRU-42_LS" },
				{ CLSID = "BRU-42_3*BDU-33"},
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{CBU_105}" }, -- CBU-105
				{ CLSID = "{CBU_103}" }, -- CBU-103
				{ CLSID = "{BDU-50LGB}" }, -- BDU-50LGB
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- TER 3*MK82
				{ CLSID = "{BRU-42_3*Mk-82AIR}" },
				{ CLSID = "{GBU_54_V_1B}" }, -- GBU-54/B Laser JDAM
				}
        ),
        pylon(6, 0, -0.615000, -0.527000, 0.000000,
            {
 				use_full_connector_position=true,
            },
            {
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
                { CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" },
  				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },
				{ CLSID = "{BDU-50LD}" },
				{ CLSID = "{BDU-50HD}" },
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" }, -- GBU-10
				{ CLSID = "{CBU-87}" },
				{ CLSID = "MXU-648-TP" }, --MXU-648 Travel Pod
				{ CLSID = "BRU-42_LS" },
				{ CLSID = "BRU-42_3*BDU-33"},
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{BDU-50LGB}" }, -- BDU-50LGB
				{ CLSID = "Fuel_Tank_FT600" },
            }
        ),
        pylon(7, 0, -0.615000, -0.501000, 0.587000,
            {
 				use_full_connector_position=true,
            },
            {
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
                { CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" },
 				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },
				{ CLSID = "{BDU-50LD}" },
				{ CLSID = "{BDU-50HD}" },
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" }, -- GBU-10
				{ CLSID = "{GBU-31}" },
				{ CLSID = "{GBU-31V3B}" },
				{ CLSID = "{GBU-38}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "MXU-648-TP" }, --MXU-648 Travel Pod
				{ CLSID = "BRU-42_LS" },
				{ CLSID = "BRU-42_3*BDU-33"},
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{CBU_105}" }, -- CBU-105
				{ CLSID = "{CBU_103}" }, -- CBU-103
				{ CLSID = "{BDU-50LGB}" }, -- BDU-50LGB
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- TER 3*MK82
				{ CLSID = "{BRU-42_3*Mk-82AIR}" },
				{ CLSID = "{GBU_54_V_1B}" }, -- GBU-54/B Laser JDAM
				}
        ),
        pylon(8, 0, -0.615000, -0.501000, 1.853000,
            {
 				use_full_connector_position=true,
            },
            {
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
                { CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" },
				{ CLSID = "Fuel_Tank_FT600" },
   				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },
				{ CLSID = "{BDU-50LD}" },
				{ CLSID = "{BDU-50HD}" },
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" }, -- GBU-10
				{ CLSID = "{GBU-31}" },
				{ CLSID = "{GBU-31V3B}" },
				{ CLSID = "{GBU-38}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{FC85D2ED-501A-48ce-9863-49D468DDD5FC}" }, -- LAU-68 with Mk1
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, -- LAU-68 with Mk5
				{ CLSID = "{65396399-9F5C-4ec3-A7D2-5A8F4C1D90C4}" }, -- LAU-68 with Mk61
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68 with Mk151
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU-68 with Mk156
				{ CLSID = "{1F7136CB-8120-4e77-B97B-945FF01FB67C}" }, -- LAU-68 with WTU1B
				{ CLSID = "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}" }, -- LAU-68 with M257
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}" }, -- LAU-68 with M274
				{ CLSID = "{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}" }, -- LAU-68 with M278
				{ CLSID = "{D22C2D63-E5C9-4247-94FB-5E8F3DE22B71}" }, -- LAU-131 with Mk1
				{ CLSID = "{319293F2-392C-4617-8315-7C88C22AF7C4}" }, -- LAU-131 with Mk5
				{ CLSID = "{1CA5E00B-D545-4ff9-9B53-5970E292F14D}" }, -- LAU-131 with Mk61
				{ CLSID = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}" }, -- LAU-131 with Mk151
				{ CLSID = "{2AF2EC3F-9065-4de5-93E1-1739C9A71EF7}" }, -- LAU-131 with Mk156
				{ CLSID = "{DDCE7D70-5313-4181-8977-F11018681662}" }, -- LAU-131 with WTU1B
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}" }, -- LAU-131 with M257
				{ CLSID = "{6D6D5C07-2A90-4a68-9A74-C5D0CFFB05D9}" }, -- LAU-131 with M274
				{ CLSID = "{1FE353C6-5EB6-4d22-9CFD-6DB384EC7296}" }, -- LAU-131 with M278
				{ CLSID = "{443364AE-D557-488e-9499-45EDB3BA6730}" }, -- LAU-68x3 with MK1
				{ CLSID = "{9BC82B3D-FE70-4910-B2B7-3E54EFE73262}" }, -- LAU-68x3 with Mk5
				{ CLSID = "{C0FA251E-B645-4ce5-926B-F4BC20822F8B}" }, -- LAU-68x3 with Mk61
				{ CLSID = "{64329ED9-B14C-4c0b-A923-A3C911DA1527}" }, -- LAU-68x3 with Mk151
				{ CLSID = "{C2593383-3CA8-4b18-B73D-0E750BCA1C85}" }, -- LAU-68x3 with Mk156
				{ CLSID = "{A1853B38-2160-4ffe-B7E9-9BF81E6C3D77}" }, -- LAU-68x3 with WTU1B
				{ CLSID = "{4C044B08-886B-46c8-9B1F-AB05B3ED9C1D}" }, -- LAU-68x3 with M257
				{ CLSID = "{E6966004-A525-4f47-AF94-BCFEDF8FDBDA}" }, -- LAU-68x3 with M274
				{ CLSID = "{B2DC636E-5E45-42db-81D9-38F3E059107C}" }, -- LAU-68x3 with M278
				{ CLSID = "LAU_131x3_HYDRA_70_MK1" }, -- LAU-131x3 with MK1
				{ CLSID = "LAU_131x3_HYDRA_70_MK5" }, -- LAU-131x3 with Mk5
				{ CLSID = "LAU_131x3_HYDRA_70_MK61" }, -- LAU-131x3 with Mk61
				{ CLSID = "LAU_131x3_HYDRA_70_M151" }, -- LAU-131x3 with Mk151
				{ CLSID = "LAU_131x3_HYDRA_70_M156" }, -- LAU-131x3 with Mk156
				{ CLSID = "LAU_131x3_HYDRA_70_WTU1B" }, -- LAU-131x3 with WTU1B
				{ CLSID = "LAU_131x3_HYDRA_70_M257" }, -- LAU-131x3 with M257
				{ CLSID = "LAU_131x3_HYDRA_70_M274" }, -- LAU-131x3 with M274
				{ CLSID = "LAU_131x3_HYDRA_70_M278" }, -- LAU-131x3 with M278
				{ CLSID = "MXU-648-TP" }, --MXU-648 Travel Pod
				{ CLSID = "BRU-42_LS" },
				{ CLSID = "BRU-42_3*BDU-33"},
				{ CLSID = "BRU-42_3*GBU-12"}, -- BRU-42 3*GBU-12
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{CBU_105}" }, -- CBU-105
				{ CLSID = "{CBU_103}" }, -- CBU-103
				{ CLSID = "{BDU-50LGB}" }, -- BDU-50LGB
				{ CLSID = "{BRU-42_3*Mk-82AIR}" },
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- TER 3*MK82
				{ CLSID = "{LAU-131 - 7 AGR-20A}" }, -- LAU-131 with M151 APKWS
				{ CLSID = "{LAU-131 - 7 AGR-20 M282}" }, -- LAU-131 with M282 APKWS
				{ CLSID = "{LAU-131x3 - 7 AGR-20A}" }, -- LAU-131x3 with M151 APKWS
				{ CLSID = "{LAU-131x3 - 7 AGR-20 M282}" }, -- LAU-131x3 with M282 APKWS
				{ CLSID = "{GBU_54_V_1B}" }, -- GBU-54/B Laser JDAM
				}
        ),
        pylon(9, 0, -0.615000, -0.337000, 4.015000,
            {
 				use_full_connector_position=true,
            },
            {
                { CLSID = "{69DC8AE7-8F77-427B-B8AA-B19D3F478B66}" },
                { CLSID = "LAU_88_AGM_65D_ONE" }, -- LAU-88 AGM-65D*1
				{ CLSID = "{E6A6262A-CA08-4B3D-B030-E1A993B98453}" },
				{ CLSID = "{DAC53A2F-79CA-42FF-A77A-F5649B601308}" },  -- LAU-88 AGM-65D*3
                { CLSID = "{444BA8AE-82A7-4345-842E-76154EFCCA46}" },
				--{ CLSID = "{F16A4DE0-116C-4A71-97F0-2CF85B0313EC}" }, -- AGM-65E LAU-117
				{ CLSID = "LAU_117_AGM_65L" }, -- LAU-117 AGM-65L
                { CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" }, -- MK-84
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, -- MK-82
                { CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- TER MK-82
   				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },
				{ CLSID = "{BDU-50LD}" },
				{ CLSID = "{BDU-50HD}" },
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" }, -- GBU-10
				{ CLSID = "{GBU-31}" },
				{ CLSID = "{GBU-31V3B}" },
				{ CLSID = "{GBU-38}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{FC85D2ED-501A-48ce-9863-49D468DDD5FC}" }, -- LAU-68 with Mk1
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, -- LAU-68 with Mk5
				{ CLSID = "{65396399-9F5C-4ec3-A7D2-5A8F4C1D90C4}" }, -- LAU-68 with Mk61
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68 with Mk151
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU-68 with Mk156
				{ CLSID = "{1F7136CB-8120-4e77-B97B-945FF01FB67C}" }, -- LAU-68 with WTU1B
				{ CLSID = "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}" }, -- LAU-68 with M257
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}" }, -- LAU-68 with M274
				{ CLSID = "{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}" }, -- LAU-68 with M278
				{ CLSID = "{D22C2D63-E5C9-4247-94FB-5E8F3DE22B71}" }, -- LAU-131 with Mk1
				{ CLSID = "{319293F2-392C-4617-8315-7C88C22AF7C4}" }, -- LAU-131 with Mk5
				{ CLSID = "{1CA5E00B-D545-4ff9-9B53-5970E292F14D}" }, -- LAU-131 with Mk61
				{ CLSID = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}" }, -- LAU-131 with Mk151
				{ CLSID = "{2AF2EC3F-9065-4de5-93E1-1739C9A71EF7}" }, -- LAU-131 with Mk156
				{ CLSID = "{DDCE7D70-5313-4181-8977-F11018681662}" }, -- LAU-131 with WTU1B
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}" }, -- LAU-131 with M257
				{ CLSID = "{6D6D5C07-2A90-4a68-9A74-C5D0CFFB05D9}" }, -- LAU-131 with M274
				{ CLSID = "{1FE353C6-5EB6-4d22-9CFD-6DB384EC7296}" }, -- LAU-131 with M278
				{ CLSID = "{443364AE-D557-488e-9499-45EDB3BA6730}" }, -- LAU-68x3 with MK1
				{ CLSID = "{9BC82B3D-FE70-4910-B2B7-3E54EFE73262}" }, -- LAU-68x3 with Mk5
				{ CLSID = "{C0FA251E-B645-4ce5-926B-F4BC20822F8B}" }, -- LAU-68x3 with Mk61
				{ CLSID = "{64329ED9-B14C-4c0b-A923-A3C911DA1527}" }, -- LAU-68x3 with Mk151
				{ CLSID = "{C2593383-3CA8-4b18-B73D-0E750BCA1C85}" }, -- LAU-68x3 with Mk156
				{ CLSID = "{A1853B38-2160-4ffe-B7E9-9BF81E6C3D77}" }, -- LAU-68x3 with WTU1B
				{ CLSID = "{4C044B08-886B-46c8-9B1F-AB05B3ED9C1D}" }, -- LAU-68x3 with M257
				{ CLSID = "{E6966004-A525-4f47-AF94-BCFEDF8FDBDA}" }, -- LAU-68x3 with M274
				{ CLSID = "{B2DC636E-5E45-42db-81D9-38F3E059107C}" }, -- LAU-68x3 with M278
				{ CLSID = "LAU_131x3_HYDRA_70_MK1" }, -- LAU-131x3 with MK1
				{ CLSID = "LAU_131x3_HYDRA_70_MK5" }, -- LAU-131x3 with Mk5
				{ CLSID = "LAU_131x3_HYDRA_70_MK61" }, -- LAU-131x3 with Mk61
				{ CLSID = "LAU_131x3_HYDRA_70_M151" }, -- LAU-131x3 with Mk151
				{ CLSID = "LAU_131x3_HYDRA_70_M156" }, -- LAU-131x3 with Mk156
				{ CLSID = "LAU_131x3_HYDRA_70_WTU1B" }, -- LAU-131x3 with WTU1B
				{ CLSID = "LAU_131x3_HYDRA_70_M257" }, -- LAU-131x3 with M257
				{ CLSID = "LAU_131x3_HYDRA_70_M274" }, -- LAU-131x3 with M274
				{ CLSID = "LAU_131x3_HYDRA_70_M278" }, -- LAU-131x3 with M278
				{ CLSID = "MXU-648-TP" }, --MXU-648 Travel Pod
				{ CLSID = "BRU-42_LS" },
				{ CLSID = "BRU-42_3*BDU-33"},
				{ CLSID = "LAU_117_AGM_65H" }, -- LAU-117 AGM-65H
				{ CLSID = "LAU_117_AGM_65G" }, -- LAU-117 AGM-65G
				{ CLSID = "LAU_88_AGM_65H" },  -- LAU-88 AGM-65H
				{ CLSID = "LAU_88_AGM_65H_2_R"},
				{ CLSID = "LAU_88_AGM_65H_3"},
				{ CLSID = "LAU_117_TGM_65D"},
				{ CLSID = "LAU_117_TGM_65G"},
				{ CLSID = "LAU_117_TGM_65H"},
				{ CLSID = "LAU_117_CATM_65K"},
				{ CLSID = "BRU-42_3*GBU-12"}, -- BRU-42 3*GBU-12
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{CBU_105}" }, -- CBU-105
				{ CLSID = "{CBU_103}" }, -- CBU-103
				{ CLSID = "{BDU-50LGB}" }, -- BDU-50LGB
				{ CLSID = "{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}" }, -- SUU-25
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, -- TER MK-82AIR
				{ CLSID = "{BRU-42_LS_3*SUU-25_8*LUU-2}" },
				{ CLSID = "{LAU-131 - 7 AGR-20A}" }, -- LAU-131 with M151 APKWS
				{ CLSID = "{LAU-131 - 7 AGR-20 M282}" }, -- LAU-131 with M282 APKWS
				{ CLSID = "{LAU-131x3 - 7 AGR-20A}" }, -- LAU-131x3 with M151 APKWS
				{ CLSID = "{LAU-131x3 - 7 AGR-20 M282}" }, -- LAU-131x3 with M282 APKWS
				{ CLSID = "{GBU_54_V_1B}" }, -- GBU-54/B Laser JDAM
			}
        ),
        pylon(10, 0, -0.615000, -0.144000, 5.408000,
            {
  				use_full_connector_position=true,
            },
            {
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, -- MK-82
                { CLSID = "{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}" }, -- SUU-25
                { CLSID = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}" }, -- AAQ-28	       	
				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" }, -- GBU-12
				{ CLSID = "{BDU-50LD}" },
				{ CLSID = "{BDU-50HD}" },
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{FC85D2ED-501A-48ce-9863-49D468DDD5FC}" }, -- LAU-68 with Mk1
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, -- LAU-68 with Mk5
				{ CLSID = "{65396399-9F5C-4ec3-A7D2-5A8F4C1D90C4}" }, -- LAU-68 with Mk61
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68 with Mk151
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU-68 with Mk156
				{ CLSID = "{1F7136CB-8120-4e77-B97B-945FF01FB67C}" }, -- LAU-68 with WTU1B
				{ CLSID = "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}" }, -- LAU-68 with M257
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}" }, -- LAU-68 with M274
				{ CLSID = "{9115A5AF-6D5C-4b6b-BEA9-31D48B5C6001}" }, -- LAU-68 with M278
				{ CLSID = "{D22C2D63-E5C9-4247-94FB-5E8F3DE22B71}" }, -- LAU-131 with Mk1
				{ CLSID = "{319293F2-392C-4617-8315-7C88C22AF7C4}" }, -- LAU-131 with Mk5
				{ CLSID = "{1CA5E00B-D545-4ff9-9B53-5970E292F14D}" }, -- LAU-131 with Mk61
				{ CLSID = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}" }, -- LAU-131 with Mk151
				{ CLSID = "{2AF2EC3F-9065-4de5-93E1-1739C9A71EF7}" }, -- LAU-131 with Mk156
				{ CLSID = "{DDCE7D70-5313-4181-8977-F11018681662}" }, -- LAU-131 with WTU1B
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}" }, -- LAU-131 with M257
				{ CLSID = "{6D6D5C07-2A90-4a68-9A74-C5D0CFFB05D9}" }, -- LAU-131 with M274
				{ CLSID = "{1FE353C6-5EB6-4d22-9CFD-6DB384EC7296}" }, -- LAU-131 with M278
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{BDU-50LGB}" }, -- BDU-50LGB
				{ CLSID = "{LAU-131 - 7 AGR-20A}" }, -- LAU-131 with M151 APKWS
				{ CLSID = "{LAU-131 - 7 AGR-20 M282}" }, -- LAU-131 with M282 APKWS
			}
        ),
        pylon(11, 0, -0.615000, -0.016000, 6.365000,
            {
   				use_full_connector_position=true,
            },
            {
                { CLSID = "{DB434044-F5D0-4F1F-9BA9-B73027E18DD3}" },
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}" },
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}" },
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}" },
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}" },
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}" },
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}" },
				{ CLSID = "{6D21ECEA-F85B-4E8D-9D51-31DC9B8AA4EF}" },
  				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" }, -- GBU-12
				{ CLSID = "{BDU-50LD}" },
				{ CLSID = "{BDU-50HD}" },
				{ CLSID = "{Mk82AIR}" },
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, -- MK-82				
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{BDU-50LGB}" }, -- BDU-50LGB
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "LAU-105_1*AIM-9M_R" },
				{ CLSID = "LAU-105" },
				{ CLSID = "ALQ_184" }, -- ALQ-184		
				{ CLSID = "LAU-105_2*CATM-9M" },
				{ CLSID = "LAU-105_1*CATM-9M_R" },
				{ CLSID = "LAU-105_AIS_ASQ_T50_R" },	-- ACMI
				{ CLSID = "LAU-105_2*AIM-9L"}, -- AIM-9Lx2
				{ CLSID = "LAU-105_1*AIM-9L_R"}, -- AIM-9Lx1
			}
        ),
    },
}

-- Make A-10C 2
make_A10C(A_10C_2)
