dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/BIT/BIT_defs.lua")

addStrokeText("BIT_STORES", "STORES", STROKE_FNT_DFLT_200, "CenterCenter", {0, BIT_titlePosY})

add_BIT_item_PB_label("CLC", 3)
add_BIT_item_PB_label("AWW-4", 4, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.AWW4}})
add_BIT_item_PB_label("SMS", 5, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.SMS}})

BIT_item_pos_count = 0
add_BIT_item_status_next(EquipItems.SMS)
add_BIT_item_status_next(EquipItems.AWW4)
add_BIT_item_status_next(EquipItems.CLC)
add_BIT_item_status_next(EquipItems.WPNS)
	
add_PB_label(7, {"STATION", nil, {{"MPD_BIT_MemoryInspectActive", 0}}})
add_PB_label(17, {"SMS\nMAINT", nil, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.SMS}}})