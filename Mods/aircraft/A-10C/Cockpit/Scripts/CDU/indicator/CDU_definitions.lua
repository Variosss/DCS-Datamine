dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."symbols.lua")
local gettext = require("i_18n")
_ = gettext.translate

SetScale(FOV)
initScale = GetScale()

CharactersCount = 24
LinesCount = 10


if RepeaterMode then
	dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_sizes.lua")
	dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_fonts.lua")
	dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_hints.lua")
	dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_materials.lua")
	
			
	VerticalK_OriginPos = 1.394
	VerticalK_TextPos   = 1.705
	VerticalOffset		= 1.5
	
	HorizontalK_OriginPos	= 0.808  --!!!
	HorizontalK_TextPos		= 0.8577 --!!!
	RightAlignmentShift		= 0.90
		
	FontMaterial		= font_MFCD
	FontMaterialBlack	= font_MFCD_BLACK
	stringdefs			= txt_CDU_font
	
	ScratchPadHorOffset	= 3
	PageNumNorOffset	= 3
	CursorShift			= -0.08
else
	VerticalK_OriginPos = 1.594
	VerticalK_TextPos   = VerticalK_OriginPos
	VerticalOffset		= 3.00
		
	HorizontalK_OriginPos	= 1.0
	HorizontalK_TextPos		= HorizontalK_OriginPos
	RightAlignmentShift		= 1.03--1.15
	
	FontMaterial		= "font_CDU"
	FontMaterialBlack	= FontMaterial
	stringdefs			= {0.0041, 0.00372, 0.000, 0.0015}--{0.0041, 0.0041, 0.0, 0.0015}
						-- size y, size x,  dx, ?
	
	ScratchPadHorOffset	= 0
	PageNumNorOffset	= 0
	CursorShift			= 0.0
end

x_size    = GetScale() -- half_width
new_scale = 2 * x_size / CharactersCount
SetCustomScale(new_scale)

mip_filter_usedCDU = true

function AddLowerLeftCornerOriginCDU()
	LowerLeftCorner				= CreateElement "ceSimple"
	LowerLeftCorner.name		= "LowerLeftCornerCDU"
	LowerLeftCorner.init_pos	= {-(CharactersCount/2) * HorizontalK_OriginPos - 0.6 , -(LinesCount/2 + 0.5) * VerticalK_OriginPos + VerticalOffset, 0}
	Add(LowerLeftCorner)
end 

AddLowerLeftCornerOriginCDU()

function SetLowerLeftCornerOriginCDU(object)
	object.parent_element =  "LowerLeftCornerCDU"
end

function use_mipfilterCDU(object)
	if mip_filter_usedCDU then
		object.use_mipfilter = true
	end
end

LFT = "Left"
RGHT = "Right"

function AddText(Name, Xpos, Ypos, Alignment, Controllers, Value, Black)
	local txt			= CreateElement "ceStringPoly"
	txt.name			= Name
	
	if (Black ~= nil and Black) then
		txt.material	= FontMaterialBlack
	else
		txt.material	= FontMaterial
	end
	
	SetLowerLeftCornerOriginCDU(txt)
	txt.stringdefs		= stringdefs
	
	shift = 0.0--0.05
	
	if Alignment == "Right" then
		txt.alignment	= "RightTop"
		shift = RightAlignmentShift
	else
		txt.alignment	= "LeftTop"
	end

	txt.init_pos		= {(Xpos - 1) * HorizontalK_TextPos + shift, (LinesCount-Ypos) * VerticalK_TextPos, 0.0}
	
	if Controllers ~= nil then
		txt.controllers		= Controllers
	end
	
	if Value ~= nil then
		if type(Value) == "table" then
			txt.formats = Value
		else
			txt.value = Value
		end
	end
	
	use_mipfilterCDU(txt)
	Add(txt)
end

function AddStaticText(Name, Xpos, Ypos, Alignment, Value, Black)
	AddText(Name, Xpos, Ypos, Alignment, nil, Value, Black)
end

function AddCursor(Xpos, Controllers)
	local txt			= CreateElement "ceStringPoly"
	txt.name			= "Cursor"
	txt.material		= FontMaterial
	SetLowerLeftCornerOriginCDU(txt)
	txt.stringdefs		= stringdefs
	
	txt.alignment		= "LeftTop"
	txt.init_pos		= {(Xpos - 1) * HorizontalK_TextPos + CursorShift, 0.0, 0.0}
	
	txt.controllers		= Controllers
	txt.value			= FILLED
		
	use_mipfilterCDU(txt)
	Add(txt)
end

LSK_to_OSB_table = {}
LSK_to_OSB_table["L1"] = 19
LSK_to_OSB_table["L2"] = 18
LSK_to_OSB_table["L3"] = 17
LSK_to_OSB_table["L4"] = 16
LSK_to_OSB_table["R1"] = 7
LSK_to_OSB_table["R2"] = 8
LSK_to_OSB_table["R3"] = 9
LSK_to_OSB_table["R4"] = 10

function LSK_to_OSB(lsk)
	return LSK_to_OSB_table[lsk]
end

function add_static_hint_CDU(lsk, hint_text)
	if RepeaterMode then
		return add_osb_static_hint(LSK_to_OSB(lsk), hint_text)
	else
		local hintCDU		= CreateElement  "ceHint"
		hintCDU.value		= hint_text
		hintCDU.hint_name	= "PNT-BTN-CDU-ARW-" .. lsk
		Add(hintCDU)
		
		return hintCDU
	end
end

function add_hint_controllers_CDU(lsk, hint_text, controllers)
	if RepeaterMode then
		return add_osb_hint_controllers(LSK_to_OSB(lsk), hint_text, controllers)
	else
		local hintCDU		= CreateElement  "ceHint"
		hintCDU.value		= hint_text
		hintCDU.hint_name	= "PNT-BTN-CDU-ARW-" .. lsk
		hintCDU.controllers = controllers
		Add(hintCDU)
		
		return hintCDU
	end
end

function add_hint_format_controllers_CDU(lsk, formats, controllers)
	if RepeaterMode then
		return add_osb_hint_format_controllers(LSK_to_OSB(lsk), formats, controllers)
	else
		local hintCDU		= CreateElement  "ceHint"
		hintCDU.value		= hint_text
		hintCDU.hint_name	= "PNT-BTN-CDU-ARW-" .. lsk
		hintCDU.formats		= formats
		hintCDU.controllers = controllers
		Add(hintCDU)
	
		return hintCDU
	end
end
