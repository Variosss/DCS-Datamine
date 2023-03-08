dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local noParent = nil
local noController = nil

-- Page Label
addStrokeText("HMD_PageLabel", "MIDS JHMCS PRIORITY", STROKE_FNT_DFLT_150, "CenterCenter", {0, 250}, noParent, noController)

-- Items list
HMD_MidsItems = {}

local function addMidsItems(str)
	HMD_MidsItems[#HMD_MidsItems + 1] = str
end

addMidsItems("MEMBERS")
addMidsItems("CLOSEST FRIENDLY")
addMidsItems("TUC'D TRACK")
addMidsItems("DONORS")
addMidsItems("OTHERS")

-- MIDS Item
local HMD_ItemPosX = -180
local HMD_ItemPosY = 200
local HMD_ItemNamePosX = 35
local HMD_ItemInterline = 14

local itemIdx = 0
local posY = 0

local boxX = 300
local boxY = glyphNominalHeight120 + 12

local function addHmdMidsItem()
	posY = HMD_ItemPosY - ((glyphNominalHeight120 + HMD_ItemInterline) * itemIdx)
	local itemPlaceholder = addPlaceholder("HMD_MIDS_item_"..itemIdx, {HMD_ItemPosX, posY}, noParent, noController)
	addStrokeText("HMD_MIDS_item_id_"..itemIdx,	itemIdx + 1, STROKE_FNT_DFLT_120, "LeftCenter", {0, 0}, itemPlaceholder.name)
	addStrokeText("HMD_MIDS_item_name_"..itemIdx,	nil,		 STROKE_FNT_DFLT_120, "LeftCenter", {HMD_ItemNamePosX, 0}, itemPlaceholder.name, {{"MPD_HMD_MIDS_Item_Name", itemIdx}}, HMD_MidsItems)
	addStrokeBox("HMD_MIDS_item_box_"..itemIdx,	 boxX, boxY, "LeftCenter", {-12, 0}, itemPlaceholder.name, {{"MPD_HMD_MIDS_Selected_Item_Box", itemIdx}})
	
	itemIdx = itemIdx + 1
end

-- MIDS Items
addHmdMidsItem()
addHmdMidsItem()
addHmdMidsItem()
addHmdMidsItem()
addHmdMidsItem()

-- MIDS Range Filter selection
addStrokeText("HMD_MIDS_Range", nil, STROKE_FNT_DFLT_120, "RightCenter", {500, -275}, noParent, {{"MPD_HMD_MIDS_Range"}})

-- Pushbuttons
add_PB_label(2, {"SEL", noParent, noController, {{"MPD_HMD_MIDS_SEL_Box"}}})
add_PB_symbol(4, "124-arrow-down")
add_PB_symbol(5, "124-arrow-up")

add_PB_symbol(14, "124-arrow-up")
add_PB_symbol(15, "124-arrow-down")

local pb16 = add_PB_label(16, "MEMBER\nBLNK")
addStrokeBox("HMD_MIDS_MemberBlnk_box",	126, 66, "CenterBottom", {0, -6}, pb16[1].name, {{"MPD_HMD_MIDS_MEMBER_Box"}})
local pb17 = add_PB_label(17, "CLSTFR\nBLNK")
addStrokeBox("HMD_MIDS_ClstfrBlnk_box",	126, 66, "CenterBottom", {0, -6}, pb17[1].name, {{"MPD_HMD_MIDS_CLSTFR_Box"}})
add_PB_label(19, "RETURN")
