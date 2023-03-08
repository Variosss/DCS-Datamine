dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."fonts.lua")
SetScale(FOV)

add_picture(LockOn_Options.script_path.."Resources/IndicationTextures/trapstat.dds")

local gettext = require("i_18n")
_ = gettext.translate

function AddElement(object)
 object.use_mipfilter = true
 Add(object)
end

-- fonts
font_size_x = 0.0075
font_size_y = font_size_x

font_title_defs = {font_size_y, font_size_x, 0.0, 0.0}
font_item_defs = {font_size_y * 0.75, font_size_x * 0.75, -0.0009, 0.0}
font_small_defs = {font_size_y*0.65 * 0.75, font_size_x * 0.75 * 0.75, -0.0009, 0.0}
font_keyhint_defs = {font_size_y * 0.6, font_size_x * 0.6, -0.0009, 0.0}

local start_line_y = 1.25
local line_size_y = 0.14

local function getLineY(line)
 return start_line_y - line_size_y * (line)
end

local keyhint_pos_x = 0.95

local item_pos_x = -0.4



local   trapnumber = CreateElement "ceStringPoly"
        trapnumber.name = "carriername"
        trapnumber.material = "font_general_grey"
        trapnumber.init_pos = {0.0, 1.04, 0}
        trapnumber.value = _("")
        trapnumber.alignment = "CenterBottom"
        trapnumber.stringdefs = font_title_defs
        trapnumber.controllers = {{"carriername", -1}}
        AddElement(trapnumber)

local   datetext = CreateElement "ceStringPoly"
        datetext.name = "date"
        datetext.material = "font_general_grey"
        datetext.init_pos = {0.0, 0.9, 0}
        datetext.value = _("")
        datetext.alignment = "CenterBottom"
        datetext.stringdefs = font_title_defs
        datetext.controllers = {{"date"}}
        AddElement(datetext)


local   wirenum = CreateElement "ceStringPoly"
        wirenum.name = "wirenum"
        wirenum.material = "font_general_grey"
        wirenum.init_pos = {-0.7, -0.955, 0} -- -0.7 -> -0.48
        wirenum.value = _("*")
        wirenum.alignment = "RightBottom"
        wirenum.stringdefs = font_item_defs
        wirenum.controllers = {{"wirenum"}}
        AddElement(wirenum)

local   groovetime = CreateElement "ceStringPoly"
        groovetime.name = "groovetime"
        groovetime.material = "font_general_grey"
        groovetime.init_pos = {-0.35, -1.05, 0} -- -0.7 -> -0.48
        groovetime.value = _("--.-")
        groovetime.alignment = "CenterBottom"
        groovetime.stringdefs = font_small_defs
        groovetime.controllers = {{"groovetime"}}
        AddElement(groovetime)

local   atenabled = CreateElement "ceStringPoly"
        atenabled.name = "ATEnabled"
        atenabled.material = "font_general_grey"
        atenabled.init_pos = {-0.1171, -1.18, 0} -- -0.7 -> -0.48
        atenabled.value = _("*")
        atenabled.alignment = "RightBottom"
        atenabled.stringdefs = font_item_defs
        atenabled.controllers = {{"apenabled", 0}}
        atenabled.isdraw             = false
        AddElement(atenabled)

 local  aclsenabled = CreateElement "ceStringPoly"
        aclsenabled.name = "ACLSEnabled"
        aclsenabled.material = "font_general_grey"
        aclsenabled.init_pos = {-0.725, -1.18, 0} -- -0.7 -> -0.48
        aclsenabled.value = _("*")
        aclsenabled.alignment = "RightBottom"
        aclsenabled.stringdefs = font_item_defs
        aclsenabled.controllers = {{"apenabled", 1}}
        aclsenabled.isdraw             = false
        AddElement(aclsenabled)


        for h_num = 0,6 do

        
                local	VLine					= CreateElement "ceMultiColorLineOrSomething"
                        VLine.name				= "HLine"..h_num
                        VLine.material			= "RED"
                        VLine.width				= 0.005
                        VLine.init_pos			= {0.0, 0.0, 0}
                        VLine.isvisible          = true
                        VLine.isdraw             = true
                        VLine.controllers		= {{"HAlignmentLine", h_num}}
                        AddElement(VLine)
        end

        for v_num = 0,6 do

        
                local	VLine					= CreateElement "ceMultiColorLineOrSomething"
                        VLine.name				= "VLine"..v_num
                        VLine.material			= "RED"
                        VLine.width				= 0.005
                        VLine.init_pos			= {0.0, 0.0, 0}
                        VLine.isvisible          = true
                        VLine.isdraw             = true
                        VLine.controllers		= {{"VAlignmentLine", v_num}}
                        AddElement(VLine)
        end


        local	topdownline					= CreateElement "ceMultiColorLineOrSomething"
                topdownline.name				= "topdownline"
                topdownline.material			= "RED"
                topdownline.width				= 0.05
                topdownline.init_pos			= {0.0, 0.0, 0}
                topdownline.isvisible          = true
                topdownline.isdraw             = true
                topdownline.controllers		= {{"topdownline"}}
                AddElement(topdownline)

        local	sideline					= CreateElement "ceMultiColorLineOrSomething"
		sideline.name				= "sideline"
		sideline.material			= "RED"
		sideline.width				= 0.05
                sideline.init_pos			= {0.0, 0.0, 0}
                sideline.isvisible          = true
                sideline.isdraw             = true
                sideline.controllers		= {{"sideline"}}
                AddElement(sideline)

        
