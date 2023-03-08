dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/BIT/BIT_defs.lua")

addStrokeText("BIT_EW", "EW", STROKE_FNT_DFLT_200, "CenterCenter", {0, BIT_titlePosY})

add_BIT_item_PB_label("ALE-47", 3)
add_BIT_item_PB_label("IBS", 4)

BIT_item_pos_count = 0
add_BIT_item_status_next(EquipItems.RWR)
add_BIT_item_status_next(EquipItems.IBS)
add_BIT_item_status_next(EquipItems.ALE_47)
add_BIT_item_status_next(EquipItems.ASPJ)
