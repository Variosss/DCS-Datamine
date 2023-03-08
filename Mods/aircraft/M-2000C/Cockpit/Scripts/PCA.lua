local id_MAGIC = "{MMagicII}"
local id_S530D = "{Matra_S530D}"
local id_MK82  = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"
local id_MK82S = "{Mk82SNAKEYE}"
local id_MK82A = "{Mk82AIR}"
local id_SMP250H = "{SAMP250HD}"
local id_SMP250L = "{SAMP250LD}"
local id_BLG66 = "{BLG66_BELOUGA_AC}"
local id_BAP100 = "{BAP_100}"


local id_GBU12 = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"
local id_GBU16 = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}"
local id_GBU24 = "{34759BBC-AF1E-4AEE-A581-498FF7A6EBCE}"
local id_SMK_R = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"
local id_SMK_G = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"
local id_SMK_B = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"
local id_SMK_W = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"
local id_SMK_Y = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"
local id_SMK_O = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"
local id_RKTS  = "{Matra155RocketPod}"

local id_RPL522   = "{M2KC_RPL_522}"
local id_RPL541L  = "{M2KC_02_RPL541}"
local id_RPL541R  = "{M2KC_08_RPL541}"

local id_AGF = "{M2KC_AGF}"
local id_AAF = "{M2KC_AAF}"

--New syntax
pca_func = {
	{ code="MAG",  prog="FOX2", model=id_MAGIC, loadouts={id_MAGIC}},
	{ code="MAF",  prog="FOX2", model=id_MAGIC, loadouts={M2KC_AAF}, fake=true},
	{ code="530",  prog="FOX1", model=id_S530D, loadouts={id_S530D}, jett_container=true, exclgroup=1 },
	{ code="53F",  prog="FOX1", model=id_S530D, loadouts={M2KC_AAF}, fake=true, exclgroup=1},
	{ code="RP" ,  prog="FUEL", loadouts={id_RPL522, id_RPL541L, id_RPL541R}, jett_container=true},
	{ code="BL1",  prog="CCRP", model=id_MK82, loadouts={id_MK82}, exclgroup=2},
	{ code="BL2",  prog="CCRP", model=id_SMP250L, loadouts={id_SMP250L}, exclgroup=2},
	{ code="EL1",  prog="CCRP", model=id_GBU12, loadouts={id_GBU12}, exclgroup=2},
	{ code="EL4",  prog="CCRP", model=id_GBU24, loadouts={id_GBU24}, exclgroup=2},
	{ code="EL6",  prog="CCRP", model=id_GBU16, loadouts={id_GBU16}, exclgroup=2},
	{ code="BF1",  prog="CCIP", model=id_MK82A, loadouts={id_MK82A}, exclgroup=2},
	{ code="BF2",  prog="CCIP", model=id_MK82S, loadouts={id_MK82S}, exclgroup=2},
	{ code="BF3",  prog="CCIP", model=id_SMP250H, loadouts={id_SMP250H}, exclgroup=2},
	{ code="BF6",  prog="CCIP", model=id_BLG66, loadouts={id_BLG66}, exclgroup=2},
	{ code="BF8",  prog="CCIP", model=id_BAP100, loadouts={id_BAP100}, jett_container = true, exclgroup=2 },
	{ code="RK3",  prog="RCKT", model=id_RKTS, loadouts={id_RKTS}, exclgroup=2},
	{ code="RKF",  prog="RCKT", model=id_RKTS, loadouts={M2KC_AGF}, fake=true, exclgroup=2},
	{ code="BFF",  prog="CCIP", model=id_MK82, loadouts={M2KC_AGF}, fake=true, exclgroup=2},
	{ code="BLF",  prog="CCRP", model=id_MK82A, loadouts={M2KC_AGF}, fake=true, exclgroup=2},
	{ code="FUM",  prog="SMKE", loadouts={id_SMK_R, id_SMK_G, id_SMK_B, id_SMK_W, id_SMK_Y, id_SMK_O}, jett_container=true},
	}

