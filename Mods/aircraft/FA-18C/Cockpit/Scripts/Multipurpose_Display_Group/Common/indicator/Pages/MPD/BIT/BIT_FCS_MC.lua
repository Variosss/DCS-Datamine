dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/BIT/BIT_defs.lua")

addStrokeText("BIT_FCS_MC", "FCS-MC", STROKE_FNT_DFLT_200, "CenterCenter", {0, BIT_titlePosY})

add_BIT_item_PB_label("FCS", 5, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.FCS}})

BIT_item_pos_count = 0
add_BIT_item_status_next(EquipItems.MC1)
add_BIT_item_status_next(EquipItems.MC2)
add_BIT_item_status_next(EquipItems.FCSA)
add_BIT_item_status_next(EquipItems.FCSB)

add_PB_label(6, {"ALL", nil, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.FCS_MC_ALL}, {"MPD_BIT_MemoryInspectActive", 0}}})
add_PB_label(8, "BIT")
add_PB_label(16, {"FCS\nOPTION", nil, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.FCS}}})

local optLabel = add_PB_label(17, {"", nil, {{"MPD_BIT_ItemIsAvailable", BIT_itemsWithAvailability.FCS}, {"MPD_BIT_FCS_OPTION_label"}}})[1]
optLabel.formats = {"FCS\nMAINT",
					"FCS\nNWS",
					"FCS\nATC",
					"FCS\nRIG",
					"FCS\nTG1",
					"FCS\nTG2",
					"FCS\nTG3",
					"FCS\nTG4",
					"FCS\nTG5",
					"FCS\nTG6",
					"FCS\nTG7",
					"FCS\nTG8",
					"FCS\nTG9",
					"FCS\nTG10",
					"FCS\nTG11",
					"FCS\nTG12"}