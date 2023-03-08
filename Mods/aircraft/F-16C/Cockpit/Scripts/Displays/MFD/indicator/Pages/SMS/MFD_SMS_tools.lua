dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")

function addSelectableInvString(name, text, pos, controller, contSelectLabel)
	-- normal string
	addStrokeText(name, text, STROKE_FNT_DFLT_10_14, "LeftCenter", pos, nil, controller)
	-- highlighted background
	local rootBackground = addPlaceholder(name.."_Selected_Background", pos, nil, {contSelectLabel})
	local sideX = 7 * 14 + 4
	local sideY =	22
	for i = 0, sideY, 0.5 do
		addStrokeLine(rootBackground.name.."_Line_"..i, sideX, {-4, sideY / 2 - i}, -90, rootBackground.name)
	end

	-- inversed string
	controller[#controller + 1] = contSelectLabel
	addBlackText(name.."_Selected", text, STROKE_FNT_DFLT_10_14, "LeftCenter", pos, nil, controller)
end

-- SMS AA
function addSmsAaLoadedWeapon(name, parent, pylon, controller, contSelectLabel)
	local name_ = name..pylon
	local pos = {0, 0}
	if pylon < 5 then
		-- left wing
		pos = {-232 + (pylon - 1) * 28, PB_positions[16][2]}
	elseif pylon > 5 then
		-- right wing
		pos = {232 - (9 - pylon) * 28, PB_positions[10][2]}
	end
	-- Root
	local main_root = addPlaceholder(name_.."_root", pos, parent)
	-- normal string
	addStrokeText(name_, tostring(pylon), STROKE_FNT_DFLT_10_14, "CenterCenter", {0,0}, main_root.name, controller)
	-- highlighted background
	local rootBackground = addPlaceholder(name_.."_Selected_Background", {0,0}, main_root.name, {contSelectLabel})
	local sideX = 14
	local sideY = 18
	for i = 0, sideY, 0.5 do
		addStrokeLine(rootBackground.name.."_Line_"..i, sideX, {-sideX*0.5, sideY / 2 - i}, -90, rootBackground.name)
	end
	-- inversed string
	controller[#controller + 1] = contSelectLabel
	addBlackText(name_.."_Selected", tostring(pylon), STROKE_FNT_DFLT_10_14, "CenterCenter", {0,0}, main_root.name, controller)
end

-- SMS AG
function addSmsAgLoadedWeapon(name, parent, pylon, controller, contSelectLabel)
	local name_ = name..pylon
	local pos = {0, 0}
	if pylon < 5 then
		-- left wing
		pos = {-232 + (pylon - 3) * 28, PB_positions[16][2]}
	elseif pylon > 5 then
		-- right wing
		pos = {232 - (7 - pylon) * 28, PB_positions[10][2]}
	end
	-- Root
	local main_root = addPlaceholder(name_.."_root", pos, parent)
	-- normal string
	addStrokeText(name_, tostring(pylon), STROKE_FNT_DFLT_10_14, "CenterCenter", {0,0}, main_root.name, controller)
	-- highlighted background
	local rootBackground = addPlaceholder(name_.."_Selected_Background", {0,0}, main_root.name, {contSelectLabel})
	local sideX = 14
	local sideY = 18
	for i = 0, sideY, 0.5 do
		addStrokeLine(rootBackground.name.."_Line_"..i, sideX, {-sideX*0.5, sideY / 2 - i}, -90, rootBackground.name)
	end
	-- inversed string
	controller[#controller + 1] = contSelectLabel
	addBlackText(name_.."_Selected", tostring(pylon), STROKE_FNT_DFLT_10_14, "CenterCenter", {0,0}, main_root.name, controller)
end

function addTgpMaverickHandoff(name, parent, pylon, controller, contSelectLabel)
	local name_ = name..pylon
	local pos = {0, 0}
	if pylon < 5 then
		-- left wing
		pos = {-170 + (pylon - 3) * 24, -140}
	elseif pylon > 5 then
		-- right wing
		pos = {170 - (7 - pylon) * 24, -140}
	end
	-- Root
	local main_root = addPlaceholder(name_.."_root", pos, parent)
	-- normal string
	addStrokeText(name_, tostring(pylon), STROKE_FNT_DFLT_8_12, "CenterCenter", {0,0}, main_root.name, controller)
	-- highlighted background
	local rootBackground = addPlaceholder(name_.."_Selected_Background", {0,0}, main_root.name, {contSelectLabel})
	local sideX = 12
	local sideY = 16
	for i = 0, sideY, 0.5 do
		addStrokeLine(rootBackground.name.."_Line_"..i, sideX, {-sideX*0.5, sideY / 2 - i}, -90, rootBackground.name)
	end
	-- inversed string
	controller[#controller + 1] = contSelectLabel
	addBlackText(name_.."_Selected"..pylon, tostring(pylon), STROKE_FNT_DFLT_8_12, "CenterCenter", {0,0}, main_root.name, controller)
	-- Handoff status
	addStrokeText(name_.."_Handoff", "", STROKE_FNT_DFLT_8_12, "CenterCenter", {0, 18}, main_root.name, {{"WPN_MAV_HandoffState", pylon}}, {"", "S", "1", "2", "T", "C"})
end

function addWpnMaverickLoadedWeapon(name, parent, pylon, controller, contSelectLabel)
	local name_ = name..pylon
	local pos = {0, 0}
	if pylon < 5 then
		-- left wing
		pos = {-210 + (pylon - 3) * 28, PB_positions[16][2] - 10}
	elseif pylon > 5 then
		-- right wing
		pos = {210 - (7 - pylon) * 28, PB_positions[10][2] - 10}
	end
	-- Root
	local main_root = addPlaceholder(name_.."_root", pos, parent)
	-- normal string
	addStrokeText(name_, tostring(pylon), STROKE_FNT_DFLT_10_14, "CenterCenter", {0,0}, main_root.name, controller)
	-- highlighted background
	local rootBackground = addPlaceholder(name_.."_Selected_Background", {0,0}, main_root.name, {contSelectLabel})
	local sideX = 14
	local sideY = 18
	for i = 0, sideY, 0.5 do
		addStrokeLine(rootBackground.name.."_Line_"..i, sideX, {-sideX*0.5, sideY / 2 - i}, -90, rootBackground.name)
	end
	-- inversed string
	controller[#controller + 1] = contSelectLabel
	addBlackText(name_.."_Selected"..pylon, tostring(pylon), STROKE_FNT_DFLT_10_14, "CenterCenter", {0,0}, main_root.name, controller)
	-- Handoff status
	addStrokeText(name_.."_Handoff", "", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, 20}, main_root.name, {{"WPN_MAV_HandoffState", pylon}}, {"", "S", "1", "2", "T", "C"})
end

function addWpnHarmLoadedWeapon(name, parent, pylon, controller, contSelectLabel)
	local name_ = name..pylon
	local pos = {0, 0}
	if pylon < 5 then
		-- left wing
		pos = {-160 + (pylon - 3) * 100, -195}
	elseif pylon > 5 then
		-- right wing
		pos = {160 - (7 - pylon) * 100, -195}
	end
	-- Root
	local main_root = addPlaceholder(name_.."_root", pos, parent)
	-- normal string
	addStrokeText(name_, tostring(pylon), STROKE_FNT_DFLT_10_14, "CenterCenter", {0,0}, main_root.name, controller)
	-- highlighted background
	local rootBackground = addPlaceholder(name_.."_Selected_Background", {0,0}, main_root.name, {contSelectLabel})
	local sideX = 14
	local sideY = 18
	for i = 0, sideY, 0.5 do
		addStrokeLine(rootBackground.name.."_Line_"..i, sideX, {-sideX*0.5, sideY / 2 - i}, -90, rootBackground.name)
	end
	-- inversed string
	controller[#controller + 1] = contSelectLabel
	addBlackText(name_.."_Selected"..pylon, tostring(pylon), STROKE_FNT_DFLT_10_14, "CenterCenter", {0,0}, main_root.name, controller)
end