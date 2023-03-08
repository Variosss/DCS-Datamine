dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local id = 0
local function getUnicID()
	id = id + 1
	return "_id:"..id
end

local Radius = 310 --280
local BankTickLen = 20
local CircleYOffset = 100
local customStringDef120 = {fontScaleY_120, fontScaleX_120, 17 * GetScale(), fontInterlineDflt120 * GetScale()}
local OffsetBetweenNumbers = 100
local ScaleSize = 9 * OffsetBetweenNumbers

-- debug background
local dbg_scale_x = 0.00096
-- 1962
local dbg_scale_y = dbg_scale_x
local dbg_bck_res = 1050
local DBG_background = addTexturedMesh("DBG_background", "INDICATION_MPD_ADI_DBG",
	--{{-512, -512}, {-512, 512}, {512, 512}, {512, -512}},
	{{0, 0}, {0, dbg_bck_res}, {dbg_bck_res, dbg_bck_res}, {dbg_bck_res, 0}},
	{0, 0, dbg_scale_x, dbg_scale_y}, {-512, -515})
DBG_background.h_clip_relation = h_clip_relations.NULL
DBG_background.isdraw          = false

--[[
addStrokeLine("ADI_DBG_border1", 1024, {-512, -512})
addStrokeLine("ADI_DBG_border2", 1024, {-512, 512}, -90)
addStrokeLine("ADI_DBG_border3", 1024, {512, 512}, 180)
addStrokeLine("ADI_DBG_border4", 1024, {512, -512}, 90)
]]

addStrokeCircle("ADI_Circle", Radius, {0, CircleYOffset})
addStrokeSymbol("waterline", {"stroke_symbols_HUD", "145-waterline"}, "FromSet", {0, CircleYOffset}, nil, nil, 1.2)

-- Cardinal bank angle ticks - 0, 30, 60, 90 degrees. Symmetrical about vertical axis.
for i = 0, 6 do
	addStrokeLine("ADI_BankTick_"..i, BankTickLen, {-Radius * math.cos(math.rad(i * -30)), Radius * math.sin(math.rad(i * -30)) + CircleYOffset}, 90 + 30 * i)
end
----------------------------

-- Shork bank angle ticks - 70 and 80 degrees. Symmetrical about vertical axis.
local startAngle = -70
for j = 0, 1 do
	for i = 0, 1 do
		addStrokeLine("ADI_BankTickShort_"..j.."_"..i, BankTickLen / 2,
			{-Radius * math.cos(math.rad(i * -10 + startAngle)), Radius * math.sin(math.rad(i * -10 + startAngle)) + CircleYOffset}, 10 * i + 90 + math.abs(startAngle))
	end
	startAngle = startAngle - 30
end
--------------------------------
local RoTRootName = "Rate_Of_Turn_Root"
addPlaceholder(RoTRootName, {0, -295}, nil, {{"MPD_ADI_Rate_or_Turn_Valid"}})
local XOffsetTurnRateMark = 100
addStrokeBox("Turn_Rate_Center_Box", 50, 40, "CenterCenter", {0, 0}, RoTRootName)
addStrokeBox("Turn_Rate_Left_Box", 50, 40, "CenterCenter", {-XOffsetTurnRateMark, 0}, RoTRootName)
addStrokeBox("Turn_Rate_Right_Box", 50, 40, "CenterCenter", {XOffsetTurnRateMark, 0}, RoTRootName)
addStrokeBox("Turn_Rate_Box", 50, 50, "CenterCenter", {0, -65}, RoTRootName, {{"MPD_ADI_Rate_or_Turn", XOffsetTurnRateMark}})

add_PB_label(16, {" STBY ", nil, nil, {{"MPD_ADI_Source_Box", 0}}})
add_PB_label(20, {" INS ", nil, nil, {{"MPD_ADI_Source_Box", 1}}})

--------------------------------------------------------------------------------------------------------------------------------------------------------
local openingMask = openMaskArea(0, "ADI_Mask", {}, {}, {0, CircleYOffset})
set_circle(openingMask, Radius)

local rootName = "ADI_center"
addPlaceholder(rootName, {0, CircleYOffset}, nil, {{"MPD_ADI_PitchRoll", ScaleSize}})

local clippedObject
local NZRadius = 20	--NZ - Nadir or Zenith

clippedObject = addStrokeLine("ADI_CenterLine", OffsetBetweenNumbers * 30, {0, - OffsetBetweenNumbers * 15}, 0, rootName)
setClipLevel(clippedObject, 1)

clippedObject = addStrokeCircle("Zenith_Circle", NZRadius, {0, OffsetBetweenNumbers * 9}, rootName)
setClipLevel(clippedObject, 1)

clippedObject = addStrokeCircle("Nadir_Circle", NZRadius, {0, -OffsetBetweenNumbers * 9}, rootName)
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("Nadir_Circle_Cross_1", NZRadius * 2, {NZRadius* math.sin(math.rad(45)), -NZRadius* math.cos(math.rad(45)) - OffsetBetweenNumbers * 9}, 45, rootName)
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("Nadir_Circle_Cross_2", NZRadius * 2, {-NZRadius* math.sin(math.rad(45)), -NZRadius* math.cos(math.rad(45)) - OffsetBetweenNumbers * 9}, -45, rootName)
setClipLevel(clippedObject, 1)

local PitchTickLen = BankTickLen / 2

for i = -8, 8 do
	clippedObject = addStrokeText("ADI_Deg_"..i, math.abs(i).."0" , customStringDef120, "CenterCenter", {0, OffsetBetweenNumbers * i}, rootName)
	setClipLevel(clippedObject, 1)
	clippedObject = addStrokeLine("ADI_PitchMark_"..i, PitchTickLen, {PitchTickLen / 2, OffsetBetweenNumbers * i - OffsetBetweenNumbers / 2}, 90, rootName)
	setClipLevel(clippedObject, 1)
end
clippedObject = addStrokeLine("ADI_PitchMark_9", PitchTickLen, {PitchTickLen / 2, OffsetBetweenNumbers * 9 - OffsetBetweenNumbers / 2}, 90, rootName)
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("ADI_PitchMark_-9", PitchTickLen, {PitchTickLen / 2, OffsetBetweenNumbers * -9 - OffsetBetweenNumbers / 2}, 90, rootName)
setClipLevel(clippedObject, 1)

for i = -1, -3, -1 do
	clippedObject =
		addStrokeText("ADI_Deg_BeyondNadir_"..i, 9 - math.abs(i).."0" , customStringDef120, "CenterCenter", {0, OffsetBetweenNumbers * i - OffsetBetweenNumbers * 9}, rootName)
	setClipLevel(clippedObject, 1)
	
	clippedObject =
		addStrokeLine("ADI_PitchMark_BeyondNadir_"..i, PitchTickLen, {PitchTickLen / 2, OffsetBetweenNumbers * i - OffsetBetweenNumbers / 2 - OffsetBetweenNumbers * 9}, 90, rootName)
	setClipLevel(clippedObject, 1)

	clippedObject =
		addStrokeText("ADI_Deg_BeyondZenith_"..i, 9 - math.abs(i).."0" , customStringDef120, "CenterCenter", {0, -OffsetBetweenNumbers * i + OffsetBetweenNumbers * 9}, rootName)
	setClipLevel(clippedObject, 1)
	
	clippedObject =
		addStrokeLine("ADI_PitchMark_BeyondZenith_"..i, PitchTickLen, {PitchTickLen / 2, -OffsetBetweenNumbers * i - OffsetBetweenNumbers / 2 + OffsetBetweenNumbers * 9}, 90, rootName)
	setClipLevel(clippedObject, 1)
end

for i = 0, 12 * OffsetBetweenNumbers, 10 do
	clippedObject = addStrokeLine("ADI_DashedAreaLine_"..i, Radius  * 2.5, {Radius  * 2.5 / 2, -(i + 2)}, 90, rootName)
	setClipLevel(clippedObject, 1)
end


closeMaskArea(1, "ADI_MaskClose", openingMask.vertices, openingMask.indices, openingMask.init_pos)

-- Director indicator
local DirBarsR = Radius * 0.8
addStrokeLine("ADI_Director_Indicator_Vert", DirBarsR * 2, {0, CircleYOffset - DirBarsR}, 0, nil, {{"MPD_RDR_EADI_SetYellowColor"}, {"Common_IndicatorLandingSystem", 0, DirBarsR}})
addPlaceholder("ADI_Director_Indicator_Hor_PH", {-DirBarsR, CircleYOffset}, nil, {{"Common_IndicatorLandingSystem", 1, DirBarsR}})
addStrokeLine("ADI_Director_Indicator_Hor", DirBarsR * 2, {0, 0}, -90, "ADI_Director_Indicator_Hor_PH", {{"MPD_RDR_EADI_SetYellowColor"}})
