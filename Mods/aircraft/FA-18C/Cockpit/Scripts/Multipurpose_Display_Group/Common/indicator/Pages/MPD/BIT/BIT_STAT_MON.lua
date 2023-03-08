dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/BIT/BIT_defs.lua")

addStrokeText("BIT_STAT_MON", "STATUS MONITOR", STROKE_FNT_DFLT_200, "CenterCenter", {0, BIT_titlePosY})

add_BIT_item_PB_label("DFIRS", 2)
add_BIT_item_PB_label("AISI", 3)
add_BIT_item_PB_label("MU", 4)
add_BIT_item_PB_label("SDC", 5)
add_BIT_item_PB_label("FQTY", 14)
add_BIT_item_PB_label("FXFR", 15)

BIT_item_pos_count = 0
add_BIT_item_status_next(EquipItems.SDC)
add_BIT_item_status_next(EquipItems.MU)
add_BIT_item_status_next(EquipItems.AISI)

add_PB_label(7, {"MSP", nil, {{"MPD_BIT_MemoryInspectActive", 0}}})
add_PB_label(17, {"FIRAM\nMAINT", nil, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.FIRAM_MAINT}}})

local FLBIT_LineInterval = (glyphNominalHeight120 + BIT_ItemInterline)
local FLBIT_pos_y = BIT_ItemPosY - (FLBIT_LineInterval * 12)
addStrokeText("TK2FL_LABEL", "TK2FL", BIT_PageFont, "LeftCenter", {BIT_ItemNamePosX, FLBIT_pos_y})
addStrokeText("TK3FL_LABEL", "TK3FL", BIT_PageFont, "LeftCenter", {BIT_ItemNamePosX, FLBIT_pos_y - FLBIT_LineInterval})


local FLBIT_StatMsgs =
{
	"",
	"IN TEST",
	"RESTRT",
	"SF TEST",
	"OFF",
	"NO TEST",
	"MUX FAIL",
	"DEGD+OVRHT",
	"OVRHT",
	"DEGD",
	"OP GO",
	"GO",
	"PBIT GO",
}

addStrokeText("TK2FL_STATUS", "", BIT_PageFont, "LeftCenter", {BIT_ItemStatusPosX, FLBIT_pos_y},						nil, {{"MPD_BIT_TK2FL_Status"}}, FLBIT_StatMsgs)
addStrokeText("TK3FL_STATUS", "", BIT_PageFont, "LeftCenter", {BIT_ItemStatusPosX, FLBIT_pos_y - FLBIT_LineInterval},	nil, {{"MPD_BIT_TK3FL_Status"}}, FLBIT_StatMsgs)
