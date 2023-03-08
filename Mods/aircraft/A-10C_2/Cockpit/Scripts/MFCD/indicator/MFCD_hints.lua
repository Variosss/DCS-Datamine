local gettext = require("i_18n")
_ = gettext.translate


if  disposition == nil then
	if GetRenderTarget() == 1 then		disposition = "L"
	else								disposition = "R" 	end
end

hint_name = {}
for osb = 1, 20 do
	local osb_description = string.format("%02d",osb)
	hint_name["OSB_"..osb_description] = "PNT-BTN-MFD-"..disposition.."-"..osb_description
end

function add_swing_button_hint_name(name)
	hint_name[name.."-UP"] = "PNT-MFD-"..disposition.."-"..name.."-UP"
	hint_name[name.."-DN"] = "PNT-MFD-"..disposition.."-"..name.."-DN"
end

add_swing_button_hint_name("ADJ")
add_swing_button_hint_name("DSP")
add_swing_button_hint_name("BRT")
add_swing_button_hint_name("CON")
add_swing_button_hint_name("SYM")
hint_name["LEVER"] = "PNT-LVR-MFD-"..disposition

local function add_static_hint(osb, hint_text)
local  hint			   =  CreateElement  "ceHint"
	   hint.value	   =  hint_text
	   hint.hint_name  =  hint_name["OSB_"..string.format("%02d", osb)]	
	   Add(hint)
return hint
end

function add_osb_static_hint(osb, hint_text)
	local  hint = add_static_hint(osb, hint_text)
    hint.controllers = {{"locked_OSB_status",osb - 1,-1}}
	return hint
end

function add_osb_hint_controllers(osb, hint_text, controllers)
    local hint = add_static_hint(osb, hint_text)
	hint.controllers = controllers
	return hint
end

function add_osb_hint_format_controllers(osb, formats, controllers)
    local hint = add_static_hint(osb, hint_text)
	hint.formats	= formats
	hint.controllers = controllers
	return hint
end

function free_osb_hints(osbs)
	local hnt = {}
	for i,o in pairs(osbs) do
		hnt[i] = add_osb_static_hint(o,"")
	end
end
