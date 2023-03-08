dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/BIT/BIT_defs.lua")

add_PB_label(8, "BIT")
add_PB_label(20, "OVRD")

local CONFIG_titlePosY = 300
local CONFIG_ItemPosY = CONFIG_titlePosY - 120

local firstColumnPosX  = -370
local secondColumnPosX = 80
local softwareIdIdentX = 150

addStrokeText("CONFIG_TITLE", "S/W CONFIGURATION\nUSN", STROKE_FNT_DFLT_200, "CenterCenter", {0, CONFIG_titlePosY})

local function add_CONFIG_item(item, num, posX)
	local posY = CONFIG_ItemPosY - ((glyphNominalHeight120 + BIT_ItemInterline) * (num - 1))
	addStrokeText("CONFIG_item_name_"..item.name, item.name, BIT_PageFont, "LeftCenter", {posX, posY})
	addStrokeText("CONFIG_item_status_"..item.name, "XXXXXXXX", BIT_PageFont, "LeftCenter", {posX + softwareIdIdentX, posY})
end

local CONFIG_item_pos_count = 0
local function CONFIG_item_pos_counter()
	CONFIG_item_pos_count = CONFIG_item_pos_count + 1
	return CONFIG_item_pos_count
end

local function add_CONFIG_item_next(item, posX)
	add_CONFIG_item(item, CONFIG_item_pos_counter(), posX)
end

-- left column
CONFIG_item_pos_count = 0
add_CONFIG_item_next(EquipItems.ADC, 	firstColumnPosX)
add_CONFIG_item_next(EquipItems.ALE_47, firstColumnPosX)
add_CONFIG_item_next(EquipItems.ASPJ, 	firstColumnPosX)
CONFIG_item_pos_counter() -- ATARS is blank
add_CONFIG_item_next(EquipItems.CLC, 	firstColumnPosX)
add_CONFIG_item_next(EquipItems.CSC, 	firstColumnPosX)
add_CONFIG_item_next(EquipItems.DFIRS, 	firstColumnPosX)
add_CONFIG_item_next(EquipItems.DMS, 	firstColumnPosX)
add_CONFIG_item_next(EquipItems.FCSA, 	firstColumnPosX)
add_CONFIG_item_next(EquipItems.FCSB, 	firstColumnPosX)
add_CONFIG_item_next(EquipItems.FLIR, 	firstColumnPosX)
add_CONFIG_item_next(EquipItems.HMD, 	firstColumnPosX)

-- right column
CONFIG_item_pos_count = 0
add_CONFIG_item_next(EquipItems.IFF, 	secondColumnPosX)
add_CONFIG_item_next(EquipItems.INS, 	secondColumnPosX)
add_CONFIG_item_next(EquipItems.LDDI, 	secondColumnPosX)
add_CONFIG_item_next(EquipItems.LDT, 	secondColumnPosX)
add_CONFIG_item_next(EquipItems.MC1, 	secondColumnPosX)
add_CONFIG_item_next(EquipItems.MC2, 	secondColumnPosX)
add_CONFIG_item_next(EquipItems.MIDS, 	secondColumnPosX)
add_CONFIG_item_next(EquipItems.MU, 	secondColumnPosX)
add_CONFIG_item_next(EquipItems.RDDI, 	secondColumnPosX)
add_CONFIG_item_next(EquipItems.RDR, 	secondColumnPosX)
add_CONFIG_item_next(EquipItems.SDC, 	secondColumnPosX)
add_CONFIG_item_next(EquipItems.SMS, 	secondColumnPosX)

