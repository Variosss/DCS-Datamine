dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/BIT/BIT_defs.lua")

addStrokeText("BIT_SENSORS", "SENSORS", STROKE_FNT_DFLT_200, "CenterCenter", {0, BIT_titlePosY})

--add_BIT_item_PB_label("CAM", 2)
--add_BIT_item_PB_label("LDT", 3)
add_BIT_item_PB_label("LTDR", 3, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.LTDR}})
add_BIT_item_PB_label("FLIR", 4, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.FLIR}})
add_BIT_item_PB_label("RDR", 5)

BIT_item_pos_count = 0
add_BIT_item_status_next(EquipItems.RDR)
add_BIT_item_status_next(EquipItems.FLIR)
add_BIT_item_status_next(EquipItems.LTDR)
--add_BIT_item_status_next(EquipItems.LST)
--add_BIT_item_status_next(EquipItems.LDT)
--add_BIT_item_status_next(EquipItems.CAM)
--add_BIT_item_status_next(EquipItems.LTDR)
	
add_PB_label(17, "RDR\nMAINT")
