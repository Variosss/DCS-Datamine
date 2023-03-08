dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
SetScale(FOV)

add_picture("kneeboard_notepad_background.dds")

local fnt_proto = {class  = "ceUITTF",  ttf = "DejaVuLGCSans.ttf" , size = 17}   -- {used_DXUnicodeFontData = "font_dejavu_lgc_sans_22"}
font_hints_kneeboard					= MakeFont(fnt_proto,{100,0,100,255})
font_hints_kneeboard_keys				= MakeFont(fnt_proto,{255  ,0,0,255})
font_checklist_kneeboard				= MakeFont(fnt_proto,{0, 0,   0,255})
font_checklist_kneeboard_keys			= MakeFont(fnt_proto,{255  ,0,0,255})
font_checklist_kneeboard_item			= MakeFont(fnt_proto,{0, 0,  50,255})
font_checklist_kneeboard_answer			= MakeFont(fnt_proto,{0, 50,  0,255})


function AddElement(object)
    object.use_mipfilter = true
    Add(object)
end

-- Fonts

local function FontSize(scale)
	local FontSizeY1	= 0.0066 * scale
	local FontSizeX1    = FontSizeY1 * 0.64

	return {FontSizeY1,	FontSizeX1,0,0}
end

predefined_font			= FontSize(1.1)
predefined_font_0 		= FontSize(0.8)
predefined_font_08		= FontSize(1)
predefined_font_key		= FontSize(0.9)
predefined_font_item	= FontSize(0.75)

ChecklistBase					= CreateElement "ceSimple"
ChecklistBase.name				= "ChecklistBase"
ChecklistBase.init_pos			= {0, GetAspect() - 3.5 * 0.0075}
AddElement(ChecklistBase)

--
local  tune_y = 0.01

HeadLineY		= 1.355  + tune_y
TitleLineY		= 1.165  + tune_y
FirstLineY		= 1.075  + tune_y
LineSizeY		= 0.092
itemsNumX		= -0.96
itemsTextX		= -0.83
itemsAnswerX	= 0.95
checklistNum	= 0

function getLineY(line)
	return FirstLineY - LineSizeY * (line)
end

function addChecklistTitle(num, text, key)
	if not txt_Checklist then 
		txt_Checklist				= CreateElement "ceStringPoly"
		txt_Checklist.name			= "txt_Checklist"
		txt_Checklist.material		= font_checklist_kneeboard
		txt_Checklist.init_pos		= {0, HeadLineY, 0}
		txt_Checklist.value			= _("CHECKLIST")
		txt_Checklist.alignment		= "CenterBottom"
		txt_Checklist.stringdefs	= predefined_font
		AddElement(txt_Checklist)
	end

	checklistNum = num

	txt_ChecklistTitle				= CreateElement "ceStringPoly"
	txt_ChecklistTitle.name			= "txt_ChecklistTitle" .. string.format("%i", num)
	txt_ChecklistTitle.material		= font_checklist_kneeboard
	txt_ChecklistTitle.init_pos		= {-0.93, TitleLineY, 0}
	txt_ChecklistTitle.value		= text
	txt_ChecklistTitle.alignment	= "LeftBottom"
	txt_ChecklistTitle.stringdefs	= predefined_font_08
	AddElement(txt_ChecklistTitle)
	
	txt_ChecklistKey				= CreateElement "ceStringPoly"
	txt_ChecklistKey.name			= "txt_ChecklistKey" .. string.format("%i", num)
	txt_ChecklistKey.material		= font_checklist_kneeboard_keys
	txt_ChecklistKey.init_pos		= {0.93, TitleLineY, 0}
	txt_ChecklistKey.value			= key
	txt_ChecklistKey.alignment		= "RightBottom"
	txt_ChecklistKey.stringdefs		= predefined_font_key
	AddElement(txt_ChecklistKey)

end

function addChecklistItem(num, text, answer)

	txt_ChecklistItemNum				= CreateElement "ceStringPoly"
	txt_ChecklistItemNum.name			= "txt_ChecklistItemNum" .. string.format("%i", checklistNum) .. string.format("%i", num)
	txt_ChecklistItemNum.material		= font_checklist_kneeboard_item
	txt_ChecklistItemNum.init_pos		= {itemsNumX, getLineY(num), 0}
	txt_ChecklistItemNum.value			= string.format("%i.", num)
	txt_ChecklistItemNum.alignment		= "LeftBottom"
	txt_ChecklistItemNum.stringdefs		= predefined_font_item
	AddElement(txt_ChecklistItemNum)

	txt_ChecklistItemText				= CreateElement "ceStringPoly"
	txt_ChecklistItemText.name			= "txt_ChecklistItemText" .. string.format("%i", checklistNum) .. string.format("%i", num)
	txt_ChecklistItemText.material		= font_checklist_kneeboard_item
	txt_ChecklistItemText.init_pos		= {itemsTextX, getLineY(num), 0}
	txt_ChecklistItemText.value			= text
	txt_ChecklistItemText.alignment		= "LeftBottom"
	txt_ChecklistItemText.stringdefs	= predefined_font_item
	AddElement(txt_ChecklistItemText)

	txt_ChecklistItemAnswer				= CreateElement "ceStringPoly"
	txt_ChecklistItemAnswer.name		= "txt_ChecklistItemAnswer" .. string.format("%i", checklistNum) .. string.format("%i", num)
	txt_ChecklistItemAnswer.material	= font_checklist_kneeboard_answer
	txt_ChecklistItemAnswer.init_pos	= {itemsAnswerX, getLineY(num), 0}
	txt_ChecklistItemAnswer.value		= answer
	txt_ChecklistItemAnswer.alignment	= "RightBottom"
	txt_ChecklistItemAnswer.stringdefs	= predefined_font_item
	AddElement(txt_ChecklistItemAnswer)

end

