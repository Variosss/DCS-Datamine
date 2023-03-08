dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

-- Possible reject status
HMD_StatMsgs = {}

local function addStatMsg(str)
	HMD_StatMsgs[#HMD_StatMsgs + 1] = str
end

addStatMsg("")
addStatMsg("ON")
addStatMsg("1")
addStatMsg("2")

-- Reject Item
local HMD_ItemPosY = 320
local HMD_ItemNamePosX = -350
local HMD_ItemStatusPosX = -10
local HMD_ItemInterline = 14

local nextColIdx = 18
local itemIdx = 0
local interCol = 0
local posY = 0

local boxX = HMD_ItemStatusPosX - HMD_ItemNamePosX + 38
local boxY = glyphNominalHeight120 + 12

local function addHmdRejectItem(name_)
	local itemPlaceholder = addPlaceholder("HMD_item_"..name_, nil, nil, {{"MPD_HMD_Reject_Item_Show", itemIdx}})

	if itemIdx < nextColIdx then
		interCol = 0
		posY = HMD_ItemPosY - ((glyphNominalHeight120 + HMD_ItemInterline) * itemIdx)
	else
		interCol = 420
		posY = HMD_ItemPosY - ((glyphNominalHeight120 + HMD_ItemInterline) * (itemIdx - nextColIdx))
	end
	addStrokeText("HMD_item_name_"..name_,	 name_, STROKE_FNT_DFLT_120, "LeftCenter", {HMD_ItemNamePosX + interCol, posY}, itemPlaceholder.name)
	addStrokeText("HMD_item_status_"..name_, nil, STROKE_FNT_DFLT_120, "CenterCenter", {HMD_ItemStatusPosX + interCol, posY}, itemPlaceholder.name, {{"MPD_HMD_Reject_Item_Status", itemIdx}}, HMD_StatMsgs)
	addStrokeBox("HMD_item_box_"..name_,	 boxX, boxY, "LeftCenter", {HMD_ItemNamePosX + interCol - 12, posY}, itemPlaceholder.name, {{"MPD_HMD_Selected_Item_Box", itemIdx}})
	
	itemIdx = itemIdx + 1
end

-- FCS-MC
addHmdRejectItem("ALTITUDE")
addHmdRejectItem("AIRSPEED")
addHmdRejectItem("BARO/RADALT")
addHmdRejectItem("BARO PRES")
addHmdRejectItem("VSI")
addHmdRejectItem("ALPHA")
addHmdRejectItem("NIRD CIRCLE")
addHmdRejectItem("MSL FOR")
addHmdRejectItem("SP/AMR FOV")
addHmdRejectItem("EW")
addHmdRejectItem("HMD HEADING")
addHmdRejectItem("HMD ELEV")
addHmdRejectItem("A/C HEADING")
addHmdRejectItem("TIME WINDOW")
addHmdRejectItem("FLIR FOV")
addHmdRejectItem("MEMBERS")
addHmdRejectItem("CLOSEST FRND")
addHmdRejectItem("TUCD TRACK")
addHmdRejectItem("WINDOW      1")
addHmdRejectItem("WINDOW      2")
addHmdRejectItem("WINDOW      3")
addHmdRejectItem("WINDOW      4")
addHmdRejectItem("WINDOW      5")
addHmdRejectItem("WINDOW      6")
addHmdRejectItem("WINDOW      7")
addHmdRejectItem("WINDOW      8")
addHmdRejectItem("WINDOW      9")
addHmdRejectItem("WINDOW     10")
addHmdRejectItem("ALT_ASPD_BOX")
addHmdRejectItem("CLIMD_ASPD")
addHmdRejectItem("MACH")
addHmdRejectItem("G")
addHmdRejectItem("MAX G")
addHmdRejectItem("AFT HMD LOS")
addHmdRejectItem("DONORS")
addHmdRejectItem("OTHERS")
addHmdRejectItem("MIDS INFO")

-- MIDS Range Filter selection
addStrokeText("HMD_MIDS_Range", nil, STROKE_FNT_DFLT_120, "RightCenter", {500, -275}, noParent, {{"MPD_HMD_MIDS_Range"}})

-- Pushbuttons
add_PB_label(1, "2")
add_PB_label(2, {"1"}, {"LEVEL"})
add_PB_label(3, "ON")
add_PB_symbol(4, "124-arrow-down")
add_PB_symbol(5, "124-arrow-up")

add_PB_symbol(6, "124-arrow-left")
add_PB_symbol(7, "124-arrow-right")

add_PB_symbol(14, "124-arrow-up")
add_PB_symbol(15, "124-arrow-down")

add_PB_label(19, "RETURN")
