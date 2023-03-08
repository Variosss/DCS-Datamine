dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")

local trackedTgt_MachAlt_ShiftX		= 27
local DBG_AA_tgtWidth = 18
local DBG_AA_tgtPlaceholder = addPlaceholder("RDR_contact", nil, nil, {{"MPD_RDR_RawRadarContactPos", tactical_display_sz_half}})

local  DBG_AA_RDR_contact = addPlaceholder("contact", nil, DBG_AA_tgtPlaceholder.name, {{"MPD_RDR_Type", 0}})
for i = 1, 4 do
	addStrokeLine("DBG_AA_targetShapePiece_"..i, DBG_AA_tgtWidth, {-DBG_AA_tgtWidth/2, 2 * (i - 2.5)}, -90, DBG_AA_RDR_contact.name, {{"MPD_RDR_RawRadarContactIntensity"}})
end

addStrokeText("contactAltitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, DBG_AA_RDR_contact.name, {{"MPD_RDR_AA_STT_1LOOK_RAID_ContactAltitude"}})


local RDR_GROUP_PH = addPlaceholder("RDR_GROUP", nil, DBG_AA_tgtPlaceholder.name, {{"MPD_RDR_Type", 2}})
addStrokeText(RDR_GROUP_PH.name.."_Many", "M", STROKE_FNT_DFLT_100, "RightCenter", {0, 0}, RDR_GROUP_PH.name, {{"MPD_RDR_RawRadarContactIntensity"}})
addStrokeText("RDR_GROUP_contactAltitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, RDR_GROUP_PH.name, {{"MPD_RDR_AA_STT_1LOOK_RAID_ContactAltitude"}})