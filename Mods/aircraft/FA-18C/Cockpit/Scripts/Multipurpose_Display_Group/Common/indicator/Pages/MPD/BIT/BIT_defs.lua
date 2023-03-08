dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

BIT_titlePosY = 237
BIT_groupInterLine = 13

BIT_ItemPosY = BIT_titlePosY - 76
BIT_ItemNamePosX = -173
BIT_ItemStatusPosX = 29
BIT_ItemInterline = 13

BIT_PageFont = {fontScaleY_120, fontScaleX_120, fontIntercharDflt120 * GetScale(), 8 * GetScale()}

BIT_EquipGroups =
{
	NAV				= 0,
	COMM			= 1,
	STORES			= 2,
	SENSORS			= 3,
	FCS_MC			= 4,
	DISPLAYS		= 5,
	STATUS_MONITOR	= 6,
	EW				= 7,
}

EquipItems = {}

local EquipIdx = 0
local function addEquipItem(key_, name_)
	EquipItems[key_] = {idx = EquipIdx,  name = name_}
	EquipIdx = EquipIdx + 1
end

-- FCS-MC
addEquipItem("MC1", 	"MC1")
addEquipItem("MC2", 	"MC2")
addEquipItem("FCSA",	"FCSA")
addEquipItem("FCSB",	"FCSB")
-- SENSORS
addEquipItem("RDR",		"RDR")
addEquipItem("FLIR",	"FLIR")
addEquipItem("LST", 	"LST")
addEquipItem("LDT", 	"LDT")
addEquipItem("LTDR", 	"LTDR")
addEquipItem("CAM", 	"CAM")
addEquipItem("NFLIR", 	"NFLIR")
addEquipItem("ATARS", 	"ATARS")
-- STORES
addEquipItem("SMS", 	"SMS")
addEquipItem("AWW4", 	"AWW-4")
addEquipItem("CLC", 	"CLC")
addEquipItem("WPNS", 	"WPNS")
-- COMM1
addEquipItem("CSC", 	"CSC")
addEquipItem("ICS", 	"ICS")
addEquipItem("IFF", 	"IFF")
addEquipItem("D_L", 	"D/L")
addEquipItem("COM1", 	"COM1")
addEquipItem("COM2", 	"COM2")
addEquipItem("COM3", 	"COM3")
addEquipItem("MIDS", 	"MIDS")
-- NAV
addEquipItem("INS", 	"INS")
addEquipItem("GPS", 	"GPS")
addEquipItem("ADC", 	"ADC")
addEquipItem("ILS", 	"ILS")
addEquipItem("RALT", 	"RALT")
addEquipItem("TCN", 	"TCN")
addEquipItem("BCN", 	"BCN")
addEquipItem("AUG", 	"AUG")
-- DISPLAYS
addEquipItem("LDDI", 	"LDDI")
addEquipItem("RDDI", 	"RDDI")
addEquipItem("MPCD", 	"MPCD")
addEquipItem("HUD", 	"HUD")
addEquipItem("IFEI", 	"IFEI")
addEquipItem("UFC", 	"UFC")
addEquipItem("DMS", 	"DMS")
addEquipItem("HMD", 	"HMD")
-- aft cockpit
addEquipItem("ALDDI", 	"ALDDI")
addEquipItem("ARDDI", 	"ARDDI")
addEquipItem("AMPCD", 	"AMPCD")
addEquipItem("AIFEI", 	"AIFEI")
-- STATUS MONITOR
addEquipItem("SDC", 	"SDC")
addEquipItem("MU", 		"MU")
addEquipItem("AISI", 	"AISI")
addEquipItem("DFIRS", 	"DFIRS")
-- EW
addEquipItem("RWR", 	"RWR")
addEquipItem("IBS", 	"IBS")
addEquipItem("ALE_47", 	"ALE-47")
addEquipItem("ASPJ", 	"ASPJ")
	
EquipIdx = nil

BIT_itemsWithAvailability =
{
	-- FCS-MC
	FCS_MC_ALL	= 0,		-- BIT group
	FCS			= 1,		-- also FCS MAINT, FCS OPTION
	-- STORES
	SMS			= 2,		-- also SMS MAINT
	AWW4		= 3,
	-- COMM
	CSC			= 4,
	-- NAV
	INS			= 5,		-- also INS GB, INS MAINT
	ADC			= 6,		-- also ADC MAINT, MAD CAL
	-- STATUS MONITOR
	FIRAM_MAINT	= 7,		-- submenu
	-- SENSORS
	FLIR		= 8,
	LTDR		= 9,
}

BIT_StatMsgs = {}

local function addStatMsg(str)
	BIT_StatMsgs[#BIT_StatMsgs + 1] = str
end

addStatMsg("")
addStatMsg("IN TEST")
addStatMsg("RESTRT")
addStatMsg("SF TEST")
addStatMsg("OFF")
addStatMsg("NOT RDY")
addStatMsg("MUX FAIL")
addStatMsg("DEGD+OVRHT")
addStatMsg("OVRHT")
addStatMsg("DEGD")
addStatMsg("OP GO")
addStatMsg("GO")
addStatMsg("PBIT GO")

BIT_item_space = "   "
BIT_item_space_len = glyphNominalWidth120 * 3 + fontIntercharDflt120 * 2

function add_BIT_item_PB_label(name, PB, controllers)
	local align
	local text
	local space = "   "
	if PB <= 5 then
		align = "LeftCenter"
		text = BIT_item_space..name
	else
		align = "RightCenter"
		text = name..BIT_item_space
	end
	
	addStrokeLine("BIT_item_line_"..name, glyphNominalHeight120, {PB_positions[PB][1], PB_positions[PB][2] - glyphNominalHeight120 / 2}, 0, nil, controllers)
	addStrokeText("BIT_item_PB_label_"..name, text, BIT_PageFont, align, PB_positions[PB], nil, controllers)
end

local function add_BIT_item_status(item, num)
	local posY = BIT_ItemPosY - ((glyphNominalHeight120 + BIT_ItemInterline) * (num - 1))
	addStrokeText("BIT_item_name_"..item.name, item.name, BIT_PageFont, "LeftCenter", {BIT_ItemNamePosX, posY})
	addStrokeText("BIT_item_status_"..item.name, nil, BIT_PageFont, "LeftCenter", {BIT_ItemStatusPosX, posY}, nil, {{"MPD_BIT_ItemStatus", item.idx}}, BIT_StatMsgs)
end

BIT_item_pos_count = 0 -- global
local function BIT_item_pos_counter()
	BIT_item_pos_count = BIT_item_pos_count + 1
	return BIT_item_pos_count
end

function add_BIT_item_status_next(item)
	add_BIT_item_status(item, BIT_item_pos_counter())
end
