dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/BIT/BIT_defs.lua")

addStrokeText("BIT_NAV", "NAV", STROKE_FNT_DFLT_200, "CenterCenter", {0, BIT_titlePosY})

add_BIT_item_PB_label("TCN", 1)
add_BIT_item_PB_label("RALT", 2)
add_BIT_item_PB_label("ILS", 3)
add_BIT_item_PB_label("ADC", 4, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.ADC}})
add_BIT_item_PB_label("INS", 5, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.INS}})
add_BIT_item_PB_label("AUG", 11)
add_BIT_item_PB_label("BCN", 12)
add_BIT_item_PB_label("GPS", 13)

BIT_item_pos_count = 0
add_BIT_item_status_next(EquipItems.INS)
add_BIT_item_status_next(EquipItems.ADC)
add_BIT_item_status_next(EquipItems.ILS)
add_BIT_item_status_next(EquipItems.RALT)
add_BIT_item_status_next(EquipItems.TCN)
add_BIT_item_status_next(EquipItems.AUG)
add_BIT_item_status_next(EquipItems.BCN)
add_BIT_item_status_next(EquipItems.GPS)

add_PB_label(16, {"MAD\nCAL", nil, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.ADC}}})
add_PB_label(17, {"ADC\nMAINT", nil, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.ADC}}})
add_PB_label(19, {"INS\nMAINT", nil, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.INS}}})
add_PB_label(20, {"INS\nGB", nil, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.INS}}})
