dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/BIT/BIT_defs.lua")

addStrokeText("BIT_COMM", "COMM", STROKE_FNT_DFLT_200, "CenterCenter", {0, BIT_titlePosY})

add_BIT_item_PB_label("D/L", 2)
add_BIT_item_PB_label("IFF", 3)
add_BIT_item_PB_label("ICS", 4)
add_BIT_item_PB_label("CSC", 5, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.CSC}})
add_BIT_item_PB_label("COM1", 11)
add_BIT_item_PB_label("COM2", 12)
add_BIT_item_PB_label("MIDS", 15)

BIT_item_pos_count = 0
add_BIT_item_status_next(EquipItems.CSC)
add_BIT_item_status_next(EquipItems.ICS)
add_BIT_item_status_next(EquipItems.IFF)
add_BIT_item_status_next(EquipItems.D_L)
add_BIT_item_status_next(EquipItems.COM1)
add_BIT_item_status_next(EquipItems.COM2)
add_BIT_item_status_next(EquipItems.MIDS)
