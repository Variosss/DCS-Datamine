dofile(LockOn_Options.script_path.."MFCD\\indicator\\MFCD_useful_definitions.lua")
dofile(LockOn_Options.common_script_path.."elements_defs.lua")


function addRT_Selection()
	Label_OSB18_comm  = add_OSB_label(18, ROTARY .. " RT 1")
	Label_OSB18_comm.init_pos = {Label_OSB18_comm.init_pos[1]+35, Label_OSB18_comm.init_pos[2]-5}
	add_osb_static_hint(18, "Select receiver-transmitter(No function")
end

function addFreq_Change()
	add_osb_static_hint(17, "Change frequency of preset")
	add_osb_static_hint(16, "Change name of preset")
	add_osb_static_hint(05, "Toggle modulatioin of preset if available")

	--[[AddTextValComm("FreqText", "LeftCenter",
		{OSB_positions[17][1] - 15, (OSB_positions[17][2]-10)},
		txt_labels_font, false,	nil, "FREQ")
		
	AddTextValComm("NameText", "LeftCenter",
		{OSB_positions[16][1] - 15, (OSB_positions[16][2]-10)},
		txt_labels_font, false,	nil, "NAME")	
		
	AddTextValComm("ModText", "LeftCenter",
		{OSB_positions[5][1] - 15, (OSB_positions[5][2]-10)},
		txt_labels_font, false,	nil, "MOD")]]--
		
	Label_OSB17_comm  = add_OSB_label(17, DATA_ENTRY .. " FREQ")
	Label_OSB16_comm  = add_OSB_label(16, DATA_ENTRY .. " NAME")
	Label_OSB05_comm  = add_OSB_label(05, ROTARY .. "MOD")
	
	Label_OSB17_comm.init_pos = {Label_OSB17_comm.init_pos[1]+35, Label_OSB17_comm.init_pos[2]-5}
	Label_OSB16_comm.init_pos = {Label_OSB16_comm.init_pos[1]+35, Label_OSB16_comm.init_pos[2]-6}
	Label_OSB05_comm.init_pos = {Label_OSB05_comm.init_pos[1], Label_OSB05_comm.init_pos[2]+10}
end

function addRowScrollers()
	Scrollers = addScrollers(20, 19, 5)
	add_osb_static_hint(19, "Cycle Table Row Down")
	add_osb_static_hint(20, "Cycle Table Row Up")

	addOSB_Box(20, {Scrollers[3]})
	addOSB_Box(19, {Scrollers[4]})

	AddTextValComm("RowText", "LeftCenter",
		{OSB_positions[19][1] - 15, (OSB_positions[19][2] + OSB_positions[20][2]) / 2},
		txt_labels_font, false,	nil, " ROW")
end


-------------------------------------------------------------------------------
-- Table
TblLeftX         = 115
TblTopY          = 495
TblDeltaY        = 24
TblXFirstColumn  = 60

TblCenterX		= max_pixels_count/2 + 6

TblHalfWidth	= 150
TblHalfWidthVertLines = 49
TblRowHeight	= 20
Tbl1stLinePosY	= max_pixels_count - 100

TblHdrTxtY			= Tbl1stLinePosY + TblRowHeight / 2
TblHdrTxtOffsetX	= TblHalfWidthVertLines + (TblHalfWidth - TblHalfWidthVertLines) / 2

TblXCoords = {TblXFirstColumn, TblXFirstColumn * 2 + 20, TblXFirstColumn * 2 - 5, TblXFirstColumn}


--[[Cursor						= CreateElement "ceStringPoly"
Cursor.name					= "SELECTED_ARROW"
Cursor.material				= font_MFCD
Cursor.UseBackground		= false
Cursor.BackgroundMaterial	= MFCD_SOLID_BLACK
Cursor.alignment			= "RightCenter"
Cursor.init_pos				= {TblCenterX - TblHalfWidth - 15, TblHdrTxtY - TblRowHeight,0}
Cursor.value				= BRANCH_L
Cursor.stringdefs			= predefined_fonts[2]
Cursor.controllers			= {{"COMM_Cursor", TblRowHeight}}
SetLowerLeftCornerOrigin(Cursor)
Add(Cursor)
use_mipfilter(Cursor)]]--


function addTblText(Name, Value, Raw, Column, Controllers)
	local PosX = TblLeftX
	local Count = 1
	while Count <= Column do
		if Count < Column then
			PosX = PosX + TblXCoords[Count]
		elseif Count == Column then
			PosX = PosX + TblXCoords[Count] / 2
		else
			break
		end
		
		Count = Count + 1
	end
		
	return AddTextValComm(Name, "CenterCenter",
		{PosX, TblTopY - (Raw - 1) * TblDeltaY - TblDeltaY / 2},
		predefined_fonts[1], false,	Controllers, Value)
end

function addTblTextLeft(Name, Value, Raw, Column, Controllers)
	local PosX = TblLeftX
	local Count = 1
	while Count <= Column do
		if Count < Column then
			PosX = PosX + TblXCoords[Count]
		elseif Count == Column then
			PosX = PosX + TblXCoords[Count] / 2
		else
			break
		end
		
		Count = Count + 1
	end
		
	return AddTextValComm(Name, "CenterCenter",
		{PosX, TblTopY - (Raw - 1) * TblDeltaY - TblDeltaY / 2},
		predefined_fonts[1], false,	Controllers, Value)
end

function addCOMM_Table(Rows, Columns, HeaderNames)
	ColumnsTable = {}
	ColumnsTable[1] = TblXCoords[1]
	TblWidth        = ColumnsTable[1]
	for i = 2, Columns - 1 do
		ColumnsTable[i] = TblXCoords[i] + ColumnsTable[i - 1]
		TblWidth = TblWidth + TblXCoords[i]
	end
	TblWidth = TblWidth + TblXCoords[Columns]
	
	AddTable(Rows, ColumnsTable, TblDeltaY, TblWidth, TblLeftX, TblTopY)
	
	for i = 1, Columns do
		local HdrElem = addTblText("HDR_" .. HeaderNames[i], HeaderNames[i], 0, i)
		HdrElem.init_pos = {HdrElem.init_pos[1], HdrElem.init_pos[2] + 3}
	end
end

function addCursor()
	AddTextValComm("SELECTED_ARROW", "RightCenter",
		{TblLeftX - 15, TblTopY - TblDeltaY / 2},
		predefined_fonts[2], false,	{{"COMM_cursor", TblDeltaY}}, BRANCH_L)
end

function addOSB_LabelWSymb(osb, text, symbol, UseBackground, inversed)
	local Text   = addOSB_Lbl(osb, text, UseBackground, inversed)
	local Symbol = attachOSB_LabelSymbol(Text, osb, symbol, UseBackground, inversed)

	addOSB_Box(osb, {Text, Symbol})

	return Text, Symbol
end

function AddTextValComm(Name, Alignment, InitPos, FontDefs, DrawBackgnd, Controllers, Val)
	local Obj = AddTextComm(Name, Alignment, InitPos, FontDefs, DrawBackgnd, Controllers)
	Obj.value = Val
	return Obj
end

function AddTextComm(Name, Alignment, InitPos, FontDefs, DrawBackgnd, Controllers)
	local Obj              = CreateElement "ceStringPoly"
	Obj.name               = Name
	Obj.material           = "font_MFCD"
	Obj.alignment          = Alignment
	Obj.init_pos           = InitPos
	SetLowerLeftCornerOrigin(Obj)
	Obj.stringdefs         = FontDefs
	Obj.UseBackground      = DrawBackgnd
	Obj.BackgroundMaterial = "INDICATION_COMMON_BLACK"
	--Obj.UseBackground      = true
	--Obj.BackgroundMaterial = "INDICATION_COMMON_RED"
	
	if Controllers ~= nil then
		Obj.controllers    = Controllers
	end
	
	Add(Obj)
	use_mipfilter(Obj)

	return Obj
end

function addOSB_Lbl(osb, Val, UseBackground, inversed)
	local osb_side = getOSB_Side(osb)
	
	local label	= CreateElement("ceStringPoly")
	label.name  = create_guid_string()
	
	if UseBackground then
		label.UseBackground			 = true
		if inversed then
			label.material			 = "font_MFCD_BLACK"
			label.BackgroundMaterial = "MFCD_GREEN"
		else
			label.material			 = "font_MFCD"
			label.BackgroundMaterial = "INDICATION_COMMON_BLACK"
		end
	else
		label.material			     = "font_MFCD"
	end
	
	if type(Val) == "table" then
		label.formats = Val
	else
		label.value = Val
	end
	
	label.stringdefs = txt_labels_font	
	
	if osb_side == OSB_SIDES.up then
		label.alignment = "CenterTop"
	elseif osb_side == OSB_SIDES.down then
		label.alignment = "CenterBottom"
	elseif osb_side == OSB_SIDES.right then
		label.alignment = "RightCenter"
	elseif osb_side == OSB_SIDES.left then
		label.alignment = "LeftCenter"
	end
	
	label.controllers = {{"declutter"}, {"locked_OSB_status", osb - 1, -1}}
	
	SetLowerLeftCornerOrigin(label)
	
	if osb_side == OSB_SIDES.up then
	    label.init_pos = {OSB_positions[osb][1], OSB_positions[osb][2] + OSB_symbol_spacing}
	elseif osb_side == OSB_SIDES.down then
	    label.init_pos = {OSB_positions[osb][1], OSB_positions[osb][2] - OSB_symbol_spacing}
	elseif osb_side == OSB_SIDES.right then
	    label.init_pos = {OSB_positions[osb][1] - OSB_label_spacing, OSB_positions[osb][2]}
	elseif osb_side == OSB_SIDES.left then
	    label.init_pos = {OSB_positions[osb][1] + OSB_label_spacing, OSB_positions[osb][2]}
	end
	
	Add(label)
	use_mipfilter(label)

	return label
end

function attachOSB_LabelSymbol(Lbl, osb, Val, UseBackground, inversed)
	local osb_side = getOSB_Side(osb)

	local symbol = CreateElement("ceStringPoly")
	symbol.name  = create_guid_string()
	
	if UseBackground then
		symbol.UseBackground			 = true
		if inversed then
			symbol.material			  = "font_MFCD_BLACK"
			symbol.BackgroundMaterial = "MFCD_GREEN"
		else
			symbol.material			  = "font_MFCD"
			symbol.BackgroundMaterial =  "INDICATION_COMMON_BLACK"
		end
	else
		symbol.material = "font_MFCD"
	end

	if type(Val) == "table" then
		symbol.formats = Val
	else
		symbol.value = Val
	end
	
	symbol.stringdefs = txt_labels_font
	
	if osb_side == OSB_SIDES.up then
		symbol.alignment = "RightTop"
	elseif osb_side == OSB_SIDES.down then
		symbol.alignment = "RightBottom"
	elseif osb_side == OSB_SIDES.right then
		symbol.alignment = "LeftCenter"
	elseif osb_side == OSB_SIDES.left then
		symbol.alignment = "RightCenter"
	end
	
	symbol.parent_element = Lbl.name
	
	LblHasFormats = Lbl.formats ~= nil and #Lbl.formats > 0
	
	if osb_side == OSB_SIDES.up or osb_side == OSB_SIDES.down then
		if LblHasFormats then
			local MaxX = 0
			for k, v in pairs(Lbl.formats) do
				CurrX = getUpDnOSB_LblSymbDisplacement(v)
				if MaxX < CurrX then
					MaxX = CurrX
				end
			end
			
			symbol.init_pos = {-MaxX, 0}
		else
			symbol.init_pos = {-getUpDnOSB_LblSymbDisplacement(Lbl.value), 0}
		end
	end
	
	Add(symbol)
	use_mipfilter(symbol)
	
	return symbol
end

function getUpDnOSB_LblSymbDisplacement(LblText)
	local Pos = string.find(LblText, "\n")
	local Len = string.len(LblText)
	
	if Pos == nil then
		return font_1_x * Len / 2
	else
		
		local MaxLen = Pos - 1
		
		while true do
			local PrevPos = Pos
			Pos = string.find(LblText, "\n", Pos + 1)
			
			if Pos == nil then
				local NewLen = Len - PrevPos
				if MaxLen < NewLen then
					MaxLen = NewLen
				end
				
				return font_1_x * MaxLen / 2
			end
			
			local NewLen = Pos - PrevPos - 1
			if MaxLen < NewLen then
				MaxLen = NewLen
			end
		end
	end
end




local sc = GetScale()

local char_w = sc * 0.045
local char_h = sc * 0.05
local char_space = sc * 0.005
local line_space = sc * 0.03




function AddTextTable(Name, Xpos, Ypos, Controllers, Value, Formats)
	local elem			= CreateElement "ceStringPoly"
	elem.name			= Name
	elem.material		= "font_MFCD"
	elem.init_pos		= {Xpos, Ypos, 0.0}
	elem.alignment		= "LeftTop"
	elem.UseBackground   = DrawBackgnd
	elem.BackgroundMaterial = "INDICATION_COMMON_BLACK"
	elem.stringdefs		= FontDefs
	elem.value			= Value
	elem.controllers	= Controllers
	elem.formats		= Formats
	--elem.parent_element	= "background"
	elem.use_mipfilter	= true
	elem.additive_alpha	= true

	Add(elem)
	--return elem
end



