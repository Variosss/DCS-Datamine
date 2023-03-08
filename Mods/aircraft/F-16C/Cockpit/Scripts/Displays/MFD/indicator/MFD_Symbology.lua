dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Strokes_Defs.lua")
dofile(LockOn_Options.script_path.."symbology_defs.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Page_Defs.lua")

stroke_thickness = MFD_stroke_thickness
stroke_fuzziness = MFD_stroke_fuzziness

-------------------------------------------- LOCAL --------------------------------------------
local TDXLeftPos = -158	--TD - top and down menu
local DYLeftPos = -230
local TYLeftPos = DYLeftPos * -1

local LRYLeftPos = 155	--LR - left and right menu
local LXLeftPos = -230
local RXLeftPos = LXLeftPos * -1

local PB_TextDistBetweenWordsInRow = 79
local PB_TextDistBetweenWordsInColumn = 78
local PB_TextDistBetweenLines = 18
local PB_TextDistBetweenColumns = 15

local PB_TextFont = STROKE_FNT_DFLT_10_14

local id = 0
local function getUnicID()
	id = id + 1
	return "_id:"..id
end

local function AddLineBreaksInStr( str )
	local retStr = ""
	for i = 1, #str - 1 do
		retStr = retStr..string.sub(str, i, i).."\n"
	end
	retStr = retStr..string.sub(str, #str, #str)
	return retStr
end

function addTextFromArgTable(args_table, pos, offset)
	local offsetX = offset[1]
	local offsetY = offset[2]
	
	local str_raw
	local str
	local result = {}
	
	for i = 1, #args_table do
		local arg = args_table[i]
		local parent = nil
		local controllers = nil
		
		if type(arg) == "string" then
			str	= arg
		elseif type(arg) == "table" then
			str = arg[1]
			parent = arg[2]
			controllers = arg[3]
		end
		
		str_raw = str or "NONAME_"..getUnicID()
		
		if offsetY == 0 then
			-- label text is written vertically
			str = AddLineBreaksInStr(str)
		end
		
		result[#result + 1] = addStrokeText(str_raw.."_"..i.."_"..getUnicID(), str, PB_TextFont, "CenterCenter",
			{pos[1] + PB_TextDistBetweenColumns * (i - 1) * offsetX, pos[2] + PB_TextDistBetweenLines * (i - 1) * offsetY},
			parent, controllers)
	end
	
	return result
end

function getOffsetFromPBnum(PBNumber, factor)
	local offsetSize = factor or 1
	if PBNumber >= 1 and PBNumber <= 5 then
        -- top PBs: 1-5
        return {0, -offsetSize}
		--return {1, 0}
	elseif PBNumber >= 6 and PBNumber <= 10 then
		-- right PBs: 6-10
		return {-offsetSize, 0}
		--return {0, -1}
	elseif PBNumber >= 11 and PBNumber <= 15 then
		-- bottom PBs: 11-15
		return {0, offsetSize}
	elseif PBNumber >= 16 and PBNumber <= 20 then
		-- left PBs: 16-20
		return {offsetSize, 0}
    else
        return {0, 0}
	end
end

local function getAlignByPBNumber(PBNumber)
	if PBNumber <= 5 and PBNumber >= 1 then
		return "CenterTop"
	elseif PBNumber <= 10 and PBNumber >= 6 then
		return "RightCenter"
	elseif PBNumber <= 15 and PBNumber >= 11 then
		return "CenterBottom"
	elseif PBNumber <= 20 and PBNumber >= 16 then
		return "LeftCenter"
	end
end

local function getPositionByPBNumber(PBNumber)
	local position = {0, 0}
	local PrevPosition = PB_positions[PBNumber]
	local ExtremePosition = 240

	if PBNumber <= 5 and PBNumber >= 1 then
		position = {PrevPosition[1], ExtremePosition}
	elseif PBNumber <= 10 and PBNumber >= 6 then
		position = {ExtremePosition, PrevPosition[2]}
	elseif PBNumber <= 15 and PBNumber >= 11 then
		position = {PrevPosition[1], -ExtremePosition}
	elseif PBNumber <= 20 and PBNumber >= 16 then
		position = {-ExtremePosition, PrevPosition[2]}
	end

	return position
end

local function getTextOffsetByPBNumber(PBNumber)
	local position = {0, 0}
	local TopBottomOffset = 3
	local LeftRightOffset = TopBottomOffset

	if PBNumber <= 5 and PBNumber >= 1 then
		position = {0, -TopBottomOffset}
	elseif PBNumber <= 10 and PBNumber >= 6 then
		position = {-LeftRightOffset, 0}
	elseif PBNumber <= 15 and PBNumber >= 11 then
		position = {0, TopBottomOffset}
	elseif PBNumber <= 20 and PBNumber >= 16 then
		position = {LeftRightOffset, 0}
	end

	return position
end

local function calculateRows(text)
	local NumberOfRows = 1
	for S in text:gmatch("\n") do
		NumberOfRows = NumberOfRows + 1
	end	
	return NumberOfRows
end

local function calculateColumns(text)
	local NumberOfColumns = 1
	local currentSymbolNumber = 0
	for i = 1, #text do
		local char = text:sub(i,i)
		if char == "\n" then
			if currentSymbolNumber > NumberOfColumns then
				NumberOfColumns = currentSymbolNumber
			end
			currentSymbolNumber = 0
		else
			currentSymbolNumber = currentSymbolNumber + 1
		end
	end
	if currentSymbolNumber > NumberOfColumns then
		NumberOfColumns = currentSymbolNumber
	end
	return NumberOfColumns
end

local function addClipMaskForTable(Text, Root)--text, vertical, maskController, offset, SymCountIfVertical)
	local width = 0
	local height = 0
	if Text.align == "RightCenter" or Text.align == "LeftCenter" then
		-- Vertical Mask
		width = 4
		height = Text.rows * 19
	else
		-- Horisontal Mask
		width = Text.columns * 15
		height = 4
	end

	local maskPos = {-Root.init_pos[1], -Root.init_pos[2]}
	local openingMask = openMaskArea(0, Root.name.."_Mask", {}, {}, maskPos, Root.name, Text.controller.mask)
	set_box_w_h(openingMask, width, height)
end

------------------------------------------- GLOBAL --------------------------------------------
-- Add black stroke text
function addBlackText(name, value, stringdef, align, pos, parent, controllers, formats)
	-- Save basic parameters
	local core_font = stroke_font
	local core_material = stroke_material

	-- Set new parameters
	stroke_font = "font_stroke_MFD_Black"
	stroke_material = "MFD_BLACK"

	local text = addStrokeText(name, value, stringdef, align, pos, parent, controllers, formats)	 

	-- Restore basic parameters
	stroke_font = core_font
	stroke_material = core_material

	return text
end

function addBlackBoldText(name, value, stringdef, align, pos, parent, controllers, formats)
	-- Save basic parameters
	local core_font = stroke_font
	local core_material = stroke_material

	-- Set new parameters
	stroke_font = "font_stroke_MFD_BlackBold"
	stroke_material = "MFD_BLACK"

	local text = addStrokeText(name, value, stringdef, align, pos, parent, controllers, formats)	 

	-- Restore basic parameters
	stroke_font = core_font
	stroke_material = core_material

	return text
end

-- global table with precalculated pushbuttons positions (copy/paste fight)
PB_positions = {}
for PBNumber = 1, 20 do
	if PBNumber <= 5 and PBNumber >= 1 then
		PB_positions[PBNumber] = {TDXLeftPos + PB_TextDistBetweenWordsInRow * (PBNumber - 1), TYLeftPos}
	elseif PBNumber <= 10 and PBNumber >= 6 then
		PB_positions[PBNumber] = {RXLeftPos, LRYLeftPos - PB_TextDistBetweenWordsInColumn * (PBNumber - 6)}
	elseif PBNumber <= 15 and PBNumber >= 11 then
		PB_positions[PBNumber] = {TDXLeftPos + PB_TextDistBetweenWordsInRow * (15 - PBNumber), DYLeftPos}
	elseif PBNumber <= 20 and PBNumber >= 16 then
		PB_positions[PBNumber] = {LXLeftPos, LRYLeftPos - PB_TextDistBetweenWordsInColumn * (20 - PBNumber)}
	end
end

--[[
addFillBox - creates a filled area of a given size
addFillBox(name, sizeX, sizeY, position, parent, controller, clipLevel)
	clipLevel - 1 for clip in the mask, 0 - ignore mask
Example:
addFillBox("PB_Animation_"..PBNumber, sizeX, sizeY, position, nil, {{"MFD_PB_Animation", PBNumber}}, 1)
]]--
function addFillBox(name, sizeX, sizeY, align, position, parent, controllerRoot, controllerLine, clipLevel, material)
	if clipLevel == nil then
		clipLevel = 0
	end
	if align == nil then
		align = "CenterCenter"
	end
	if position == nil then
		position = {0, 0}
	end

	local sizeX_half = sizeX / 2
	local sizeY_half = sizeY / 2	
	if align == "LeftCenter" then
		position[1] = position[1] + sizeX_half
	elseif align == "RightCenter" then
		position[1] = position[1] - sizeX_half
	elseif align == "CenterBottom" then
		position[2] = position[2] + sizeY_half
	elseif align == "CenterTop" then
		position[2] = position[2] - sizeY_half
	elseif align == "LeftBottom" then
		position[1] = position[1] + sizeX_half
		position[2] = position[2] + sizeY_half
	elseif align == "LeftTop" then
		position[1] = position[1] + sizeX_half
		position[2] = position[2] - sizeY_half
	elseif align == "RightTop" then
		position[1] = position[1] - sizeX_half
		position[2] = position[2] - sizeY_half
	elseif align == "RightBottom" then
		position[1] = position[1] - sizeX_half
		position[2] = position[2] + sizeY_half
	end

	local rootPH = addPlaceholder(name.."_Fill_Box_"..getUnicID(), position, parent, controllerRoot)
	for i = 0, sizeY, 0.5 do
		clippedObject = addStrokeLine(rootPH.name.."_Line_"..getUnicID(), sizeX, {-sizeX_half, sizeY_half - i}, -90, rootPH.name, controllerLine, nil, nil, nil, material)
		if clipLevel == 1 then
			setClipLevel(clippedObject, 1)
		end
	end
	return rootPH
end 

--[[
Text is a table with next fields
Text.number = PBs number
Text.string = basic string for display
Text.align = if nil, use align for PB number
Text.position = if nil, use position for PB number
Text.font = if nil, use STROKE_FNT_DFLT_10_14
Text.parent = parent for all indication
Text.controller = table controllers for:
	Text.controller.root = controller for main element
	Text.controller.text = controller for text element
	Text.controller.selectedElement = controller for root selected
	Text.controller.selectedText = controller for selected text
	Text.controller.mask = controller mask
Text.addLineBreak = add \n after each letter 
Text.rows = number of rows for selected element. If it nil it will be calculated
Text.columns = number of columns for selected element. If it nil it will be calculated
Text.selected = invert all data 
Text.selectable = this element ca be selected or not
Text.addMask = add mask for SOI
Text.formats = nil or format for text
]]--
function add_PB_Label_From_Table(Text)
	-- Set string
	if Text.string == nil then
		Text.string = ""
	end
	-- Set align
	if Text.align == nil then
		Text.align = getAlignByPBNumber(Text.number)
	end
	-- Set position
	if Text.position == nil then
		Text.position = getPositionByPBNumber(Text.number)
	end
	-- Set font
	if Text.font == nil then
		Text.font = STROKE_FNT_DFLT_10_14
	end
	-- Process Line Break
	if Text.addLineBreak then
		Text.string = AddLineBreaksInStr(Text.string)
	end

	-- Set rows
	if Text.rows == nil then
		Text.rows = calculateRows(Text.string)
	end
	-- Set columns
	if Text.columns == nil then
		Text.columns = calculateColumns(Text.string)
	end
	-- Set controllers
	if Text.controller == nil then
		Text.controller = {nil, nil, nil, nil, nil}
	end

	local root = addPlaceholder(Text.string.." Table. Root. Unic ID: "..getUnicID(), Text.position, Text.parent, Text.controller.root)
	
	local textOffset = getTextOffsetByPBNumber(Text.number)	
	local sizeX = Text.columns 	* 14.5
	local sizeY = Text.rows 	* 19
	
	local retVal
	if Text.selectable then
		-- Selected element
		local selectableRoot = addPlaceholder(Text.string.." Selectable Root. Unic ID: "..getUnicID(), nil, root.name, Text.controller.selectedElement)
		addFillBox(selectableRoot.name..". Fill Box", sizeX, sizeY, Text.align, nil, selectableRoot.name)
		addBlackText(selectableRoot.name..". Black Text", Text.string, Text.font, Text.align, textOffset, selectableRoot.name, Text.controller.selectedText, Text.formats)
		if Text.addMask ~= nil then
			addClipMaskForTable(Text, selectableRoot)
		end
		-- Not selected element
		retVal = addStrokeText(root.name..". Text", Text.string, Text.font,  Text.align, textOffset, root.name, Text.controller.text, Text.formats)
		if Text.addMask ~= nil then
			addClipMaskForTable(Text, retVal)
		end
	else
		if Text.selected then
			local selectableRoot = addPlaceholder(Text.string.." Selectable Root. Unic ID: "..getUnicID(), nil, root.name, Text.controller.selectedElement)
			addFillBox(selectableRoot.name..". Fill Box", sizeX, sizeY, Text.align, nil, selectableRoot.name)
			addBlackText(selectableRoot.name..". Black Text", Text.string, Text.font, Text.align, textOffset, selectableRoot.name, Text.controller.selectedText, Text.formats)
			if Text.addMask ~= nil then
				addClipMaskForTable(Text, selectableRoot)
			end
		else
			retVal = addStrokeText(root.name..". Text", Text.string, Text.font,  Text.align, textOffset, root.name, Text.controller.text, Text.formats)
			if Text.addMask ~= nil then
				addClipMaskForTable(Text, retVal)
			end
		end
	end

	return retVal
end

--[[
add_PB_label - is a standard function that adds horizontal text for buttons 1-5 and 11-15 and vertical for the rest.
add_PB_label(PBNumber, string, parent, text controller, mask controller)
	mask controller - mask, to delete part of the SOI frame
Example:
add_PB_label(1, nil, nil, {{"HSD_CenteredPBLabel"}})
]]--
function add_PB_label(PBNumber, string, parent, controller, maskController, formats)
	local addLineBreak = false
	if (PBNumber >= 6 and PBNumber <= 10) or (PBNumber >= 16 and PBNumber <= 20) then
		addLineBreak = true
	end

	local Text = 
    {
        number = PBNumber,
        string = string,
        parent = parent,
        controller = 
        {
			text = controller,
			mask = maskController,
        },
        addLineBreak = addLineBreak,
        addMask = true,
        formats = formats,
    }    
	local text = add_PB_Label_From_Table(Text)
	return text
end

--[[
add_Simple_PB_label - like add_PB_label but does not make vertical text on PBs 6-10 and 16-19. Align text by the edge. Has controller for the mask
add_Simple_PB_label(PBNumber, string, parent, text controller, mask controller)
Example: 
add_Simple_PB_label(6, "6 M82S", "BOMB_PAGE", nil)
]]--
function add_Simple_PB_label(PBNumber, string, parent, controller, maskController, formats)
	local Text = 
    {
        number = PBNumber,
        string = string,
        parent = parent,
        controller = 
        {
			text = controller,
			mask = maskController,
        },
        addMask = true,
		formats = formats,
    }
	local text = add_PB_Label_From_Table(Text)
	return text
end

--[[
add_Selected_PB_Label - use it when you need selected horisontal PB.
add_Selected_PB_Label(PBNumber, string, controller for text and filler (selected background))
Example: 
add_Selected_PB_Label(4, "INV", {{"SMS_INV_Show_INV_Button"}})
]]--
function add_Selected_PB_Label(PBNumber, string, contSelectLabel)
	local Text = 
    {
        number = PBNumber,
        string = string,
        controller = 
        {
            root = contSelectLabel,
        },
        selected = true,
    }    
    add_PB_Label_From_Table(Text)
end

--[[
add_Selectable_PB_Label - create label that can be selected or not. To create black text, use addBlackText function
add_Selectable_PB_Label(PBNumber, string, not selected controller, selected controller, parent)
	not selected controller - controller for text
	selected controller - controller for filler (selected background) and black text
Example:
add_Selectable_PB_Label(16, "MAN", "BOMB_MODE_SELECT", {{"SMS_AG_BombModeSelected", 0, BOMB_MODES.MAN}}, {{"SMS_AG_BombModeSelected", 1, BOMB_MODES.MAN}})
]]--
function add_Selectable_PB_Label(PBNumber, string, parent, contLabel, contSelectLabel, contSelectText, lineBreak)
	local Text = 
    {
        number = PBNumber,
        string = string,
        parent = parent,
        controller = 
        {
			text = contLabel,
			selectedElement = contSelectLabel,			
			selectedText = contSelectText,
        },
		addLineBreak = lineBreak or false,
        selectable = true,
        addMask = true,
    }    
	add_PB_Label_From_Table(Text)
end

--[[
add_PB_Animation - a special function for creating the effect of clicking a button (filled rectangle) on each page.
DO NOT USE IN OTHER PLACES!!! ALL DONE WITH IT!!!
]]--
function add_PB_Animation(PBNumber)
	local position = PB_positions[PBNumber]
	local strLen = 4
	
	local offset = getOffsetFromPBnum(PBNumber)[1]
	if offset ~= 0 then
		offset = offset * (strLen * 11 / 2)
		position[1] = position[1] + offset
	end

	sizeX = strLen * 15
	sizeY =	22

	addFillBox("PB_Animation_"..PBNumber, sizeX, sizeY, "CenterCenter", position, nil, {{"MFD_PB_Animation", PBNumber}}, nil, 0)
end

--[[
add_PB_Menu_Label - a special function for creating a menu button (12 - 14)
DO NOT USE IN OTHER PLACES!!! ALL DONE WITH IT!!!
]]--
function add_PB_Menu_Label(PBNumber)
	local position = PB_positions[PBNumber]
	local root = addPlaceholder("PB_Menu_Label_ROOT_"..PBNumber, position, nil, {{"MFD_PB_Menu_Show", PBNumber}})
		
	local root_Selected = addPlaceholder("PB_Menu_Label_ROOT_Selected"..PBNumber, nil, root.name, {{"MFD_PB_Menu_Show_Selected", PBNumber, 1}})
	local rootFiller_3Sym = addPlaceholder("PB_Menu_Label_rootFiller_3Sym_"..PBNumber, nil, root_Selected.name, {{"MFD_PB_Menu_Show_Elem", PBNumber, 3}})
	sizeX = 3 * 15
	sizeY =	22
	for i = 0, sizeY, 0.5 do
		addStrokeLine(rootFiller_3Sym.name.."_Line_"..getUnicID(), sizeX, {-sizeX / 2, sizeY / 2 - i}, -90, rootFiller_3Sym.name)
	end
	
	local rootFiller_4Sym = addPlaceholder("PB_Menu_Label_rootFiller_4Sym_"..PBNumber, nil, root_Selected.name, {{"MFD_PB_Menu_Show_Elem", PBNumber, 4}})
	sizeX = 4 * 15
	sizeY =	22
	for i = 0, sizeY, 0.5 do
		addStrokeLine(rootFiller_4Sym.name.."_Line_"..getUnicID(), sizeX, {-sizeX / 2, sizeY / 2 - i}, -90, rootFiller_4Sym.name)
	end

	-- Select label
	local label_Black = addBlackText("PB_Menu_Label_Black_PB_"..PBNumber, nil, PB_TextFont, "CenterCenter",	nil,	root_Selected.name, {{"MFD_PB_Menu_Label", PBNumber}})

	-- Non selected label
	local label = addStrokeText("PB_Menu_Label_"..PBNumber, nil, PB_TextFont, "CenterCenter",	nil,	root.name, {{"MFD_PB_Menu_Show_Selected", PBNumber, 0}, {"MFD_PB_Menu_Label", PBNumber}})


	local function addTextClipMaskByLen(name, symbolLen, position, controller)
		local openingMask = openMaskArea(0, name.."_Mask", {}, {}, {position[1], position[2] - 10}, nil, controller)	
		local width = symbolLen * 15
		local height =	3
		set_box_w_h(openingMask, width, height)
	end

	addTextClipMaskByLen("PB_Menu_Label_3Sym_"..PBNumber, 3, position, {{"MFD_PB_Menu_Show_If_Blank", PBNumber}, {"MFD_PB_Menu_Show_Elem", PBNumber, 3}})
	addTextClipMaskByLen("PB_Menu_Label_4Sym_"..PBNumber, 4, position, {{"MFD_PB_Menu_Show_If_Blank", PBNumber}, {"MFD_PB_Menu_Show_Elem", PBNumber, 4}})
end

--[[
addTextClipMask is a function to create an SOI clipping region.
addTextClipMask(text, vertical, maskController)
	vertical - is text vertical
	maskController - the mask controller
Example: 
addTextClipMask(CONT_Label)
]]--
function addTextClipMask(text, vertical, maskController, offset, SymCountIfVertical)
	local localOffset = offset or {0, 0}
	local openingMask = openMaskArea(0, text.name.."_Mask", {}, {}, {localOffset[1], localOffset[2]}, text.name, maskController)

	local width, height
	local symbolLen = #text.value

	if vertical then
		symbolLen = SymCountIfVertical or math.ceil(symbolLen / 2)
		width = 2
		height = symbolLen *	19
	else
		width = symbolLen * 15
		height = 2
	end

	set_box_w_h(openingMask, width, height)
end

--[[
addSizeClipMask - create a mask of a given size in place of a character. Used to clip SOI
addSizeClipMask(symbol, width, height)
Example:
addSizeClipMask(RangeScaleRoot, 40, 72)
]]--
function addSizeClipMask(symbol, width, height, maskController, offset)
	local localOffset = offset or {0, 0}
	local openingMask = openMaskArea(0, symbol.name.."_Mask", {}, {}, {symbol.init_pos[1] + localOffset[1], symbol.init_pos[2] + localOffset[2]}, nil, maskController)
	set_box_w_h(openingMask, width, height)
end

--[[
addTextSizeClipMask - a function for creating a mask in place of text, but based on the specified text sizes
addTextSizeClipMask(text, StrLen, RowNum)
	StrLen - string length
	RowNum - numbers of rows
Example:
addTextSizeClipMask(PB_6, 3, 2)
]]--
function addTextSizeClipMask(text, StrLen, RowNum)
	addSizeClipMask(text, StrLen * 15, RowNum * 19)
end

--[[
Adds OFF label
	text - String with name, e.g. "FCR"
	controller - table of controllers
--]]
function addOffLabel(text, controllers)
	local OffRoot = addPlaceholder(text.."_OFF_Label", {0, 34}, nil, controllers)

	addStrokeText(text.."_OFF_Lable_name", text, STROKE_FNT_DFLT_8_12,  "CenterCenter", {0,  50}, OffRoot.name)
	addStrokeText(text.."_OFF_Label_off", "OFF", STROKE_FNT_DFLT_28_36, "CenterCenter", {0,  0}, OffRoot.name)
end
--[[
Adds NOT SOI label to a page
--]]
function addNotSoiLabel(controllers)
	local NotSoiRoot = addPlaceholder("NotSoi_Label", {0, 120}, nil, controllers)
	addStrokeText("NotSoi_Label_off", "NOT SOI", STROKE_FNT_DFLT_10_14, "CenterCenter", {0,  0}, NotSoiRoot.name)
end

function AddBackground(name, invisible, controllers)
	local MaskSize = 240
	local element	        = CreateElement "ceMeshPoly"
	element.name 		    = name
	element.primitivetype   = "triangles"
	element.material 	    = "MFD_BACKGROUND"
	element.vertices        = {{-MaskSize, -MaskSize}, {-MaskSize, MaskSize}, {MaskSize, MaskSize}, {MaskSize, -MaskSize}}
	element.indices	     	= {0, 1, 2, 0, 2, 3}
	element.blend_mode 	 	= blend_mode.IBM_REGULAR
	element.change_opacity  = false
	
	if invisible == true then
		element.h_clip_relation = h_clip_relations.REWRITE_LEVEL
		element.level			= DEFAULT_LEVEL
		setAsInvisibleMask(element) -- changes material
	end
	
	if controllers ~= nil then
		element.controllers = controllers
	end
	
	Add(element)
end

function addStrokeSelectableText(name, value, stringdef, align, pos, parent, contNonSel, contSel, formats)
	local sizeX = calculateColumns(value) * 14.5
	local sizeY = calculateRows(value) * 19
	
	local boxOffset = 2
	if align:gmatch("Left") then
		boxOffset = boxOffset * -1
	end

	local selectableRoot = addPlaceholder(name.." Selectable Text Root", pos, parent, contSel)
	addFillBox(selectableRoot.name..". Fill Box", sizeX, sizeY, align, {boxOffset, 0}, selectableRoot.name)
	addBlackText(selectableRoot.name..". Black Text", value, stringdef, align, nil, selectableRoot.name, nil, formats)
	
	-- Not selected element
	retVal = addStrokeText(selectableRoot.name..". Text", value, stringdef,  align, pos, parent, contNonSel, formats)
end