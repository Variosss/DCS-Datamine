dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/BIT/BIT_defs.lua")

addStrokeText("BIT_DISPLAYS", "DISPLAYS", STROKE_FNT_DFLT_200, "CenterCenter", {0, BIT_titlePosY})

--add_BIT_item_PB_label("MPCD", 1)
add_BIT_item_PB_label("DMS", 2)
add_BIT_item_PB_label("UFC", 3)
add_BIT_item_PB_label("IFEI", 4)

-- MDG
local MDG_hor_line_len = 80
local BIT_ItemInterlineMDG = 6
local MDG_placeholder = addPlaceholder("BIT_item_PB_label_placeholder_MDG", {PB_positions[5][1], PB_positions[5][2]})
local MDG_vert_line_len = glyphNominalHeight120 * 3 + BIT_ItemInterlineMDG * 4
addStrokeText("BIT_item_PB_label_DDI", BIT_item_space.."DDI", BIT_PageFont, "LeftBottom", {0, glyphNominalHeight120 / 2 + BIT_ItemInterlineMDG * 2}, MDG_placeholder.name)
addStrokeLine("BIT_item_PB_label_line_1", MDG_hor_line_len, {BIT_item_space_len, glyphNominalHeight120 / 2 + BIT_ItemInterlineMDG}, -90, MDG_placeholder.name)
addStrokeText("BIT_item_PB_label_MPCD", BIT_item_space.."MPCD", BIT_PageFont, "LeftCenter", nil, MDG_placeholder.name)
addStrokeLine("BIT_item_PB_label_line_2", MDG_hor_line_len, {BIT_item_space_len, -glyphNominalHeight120 / 2 - BIT_ItemInterlineMDG}, -90, MDG_placeholder.name)
addStrokeText("BIT_item_PB_label_HUD", BIT_item_space.."HUD", BIT_PageFont, "LeftTop", {0, -glyphNominalHeight120 / 2 - BIT_ItemInterlineMDG * 2}, MDG_placeholder.name)
addStrokeLine("BIT_item_line_MDG", MDG_vert_line_len, {0, -MDG_vert_line_len/2}, 0, MDG_placeholder.name)

add_BIT_item_PB_label("HMD", 11)

BIT_item_pos_count = 0
add_BIT_item_status_next(EquipItems.LDDI)
add_BIT_item_status_next(EquipItems.RDDI)
add_BIT_item_status_next(EquipItems.MPCD)
add_BIT_item_status_next(EquipItems.HUD)
add_BIT_item_status_next(EquipItems.IFEI)
add_BIT_item_status_next(EquipItems.DMS)
add_BIT_item_status_next(EquipItems.HMD)
	
add_PB_label(16, "UFC\nMAINT")
add_PB_label(17, "HMD\nMAINT")
