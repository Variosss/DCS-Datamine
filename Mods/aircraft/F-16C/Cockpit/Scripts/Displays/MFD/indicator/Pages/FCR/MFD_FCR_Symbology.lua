dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")

function AddAgRangeArcs(angle, parent, controller)
	local ArcsPH = addPlaceholder("Arcs PH for angle "..angle, nil, parent, controller)
	addStrokeArc("Arc 1/4 with angle "..angle, 120, angle, angle * 0.5, nil, ArcsPH.name)
	addStrokeArc("Arc 1/2 with angle "..angle, 120 * 2, angle, angle * 0.5, nil, ArcsPH.name)
	addStrokeArc("Arc 3/4 with angle "..angle, 120 * 3, angle, angle * 0.5, nil, ArcsPH.name)
end

function AddAgAcquisitionCursor(controller)
	local baseName = "Acquisition Cursor "

	local AcquisitionCursorPH = addPlaceholder(baseName.."PH", {0, 0}, noParent, controller)

	addStrokeBox(baseName.."box", 20, 20, "CenterCenter", nil, AcquisitionCursorPH.name, {{"FCR_AG_AcquisitionCursorType", 2}})
	local TTD = addFillBox(baseName.."Tracked Target Diamond", 10, 10, "CenterCenter", nil, AcquisitionCursorPH.name, {{"FCR_AG_AcquisitionCursorType", 1}})
	TTD.init_rot = {45}

	addStrokeLine(baseName.."Top Line", 500, {0, 10}, 0, AcquisitionCursorPH.name)
	addStrokeLine(baseName.."Bottom Line", 500, {0, -10}, 180, AcquisitionCursorPH.name)
	addStrokeLine(baseName.."Left Line", 500, {-10, 0}, 90, AcquisitionCursorPH.name)
	addStrokeLine(baseName.."Right Line", 500, {10, 0}, -90, AcquisitionCursorPH.name)
	
	addStrokeLine(baseName.."Top Serif", 10, {-5, 60}, -90, AcquisitionCursorPH.name)
	addStrokeLine(baseName.."Bottom Serif", 10, {-5, -60}, -90, AcquisitionCursorPH.name)
	addStrokeLine(baseName.."Left Serif", 10, {-60, -5}, 0, AcquisitionCursorPH.name)
	addStrokeLine(baseName.."Right Serif", 10, {60, -5}, 0, AcquisitionCursorPH.name)
end

function AddGainGage()
	local width = 15
	local height = 60
	local angle = 60
	local baseName = "Gain gage "

	local GainGagePH = addPlaceholder(baseName.."PH", {-230, 165}, noParent, {{"FCR_AG_MapRoot"}, {"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})
	addStrokeLine(baseName.."Vertical line", height, {0, 0}, 0, GainGagePH.name)
	addStrokeLine(baseName.."Bottom line", width, {0, 0}, -90, GainGagePH.name)
	addStrokeLine(baseName.."Top line", width, {0, height}, -90, GainGagePH.name)

	local CaretPH = addPlaceholder(baseName.."Caret PH", {0, 0}, GainGagePH.name, {{"FCR_AG_GainIndicator", height}})
	addStrokeLine(baseName.."Caret top", width, {0, 0}, -90 + angle / 2, CaretPH.name)
	addStrokeLine(baseName.."Caret bottom", width, {0, 0}, -90 - angle / 2, CaretPH.name)
end

function AddAgExpCursor(parentRoot, controller)
	local baseName = "Exp Cursor "
	local ExpCursorPH = addPlaceholder(baseName.."PH", {0, 0}, parentRoot, controller)

	addStrokeBox(baseName.."box", 20, 20, "CenterCenter", nil, ExpCursorPH.name, {{"FCR_AG_AcquisitionCursorType", 2}})
	local TTD = addFillBox(baseName.."Tracked Target Diamond", 10, 10, "CenterCenter", nil, ExpCursorPH.name, {{"FCR_AG_AcquisitionCursorType", 1}})
	TTD.init_rot = {45}

	addStrokeLine(baseName.."Top Line", 500, {0, 10}, 0, ExpCursorPH.name)
	addStrokeLine(baseName.."Bottom Line", 500, {0, -10}, 180, ExpCursorPH.name)
	addStrokeLine(baseName.."Left Line", 500, {-10, 0}, 90, ExpCursorPH.name)
	addStrokeLine(baseName.."Right Line", 500, {10, 0}, -90, ExpCursorPH.name)
end

function AddAgrRangeIndicator(parentRoot)
	local baseName = "AGR range indicator "
	local LineVerticalOffset = 130
	local AgrRangeIndPH = addPlaceholder(baseName.."PH", {220, -130}, parentRoot)

	local LineLen = 20
	addStrokeLine(baseName.."Center Serif", LineLen, {0, LineVerticalOffset}, 90, AgrRangeIndPH.name)
	addStrokeLine(baseName.."Top Serif", LineLen, {0, LineVerticalOffset * 2}, 90, AgrRangeIndPH.name)
	addStrokeLine(baseName.."Bottom Serif", LineLen, {0, 0}, 90, AgrRangeIndPH.name)

	local CursorPH = addPlaceholder(baseName.." cursor PH", {-LineLen - 15, 0}, AgrRangeIndPH.name, {{"FCR_AGR_RangeCursorPosition", LineVerticalOffset * 2}})
	addStrokeBox(baseName.."Box", 20, 20, "CenterCenter", nil, CursorPH.name, {{"FCR_AGR_RangeCursorType", 2}})
	local Diamond = addFillBox(baseName.."Diamond", 10, 10, "CenterCenter", nil, CursorPH.name, {{"FCR_AGR_RangeCursorType", 1}})
	Diamond.init_rot = {45}
end