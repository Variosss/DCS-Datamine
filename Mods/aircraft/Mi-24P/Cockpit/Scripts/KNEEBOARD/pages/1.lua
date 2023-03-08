dofile(LockOn_Options.script_path.."KNEEBOARD/pages/common.lua")

local dY = LineSizeY

-- Weapon Status ------------------------------------------------
-----------------------------------------------------------------

local LinePosition = function (line)
	return getLineY(line - 2)
end


local line1_y = LinePosition(1)
local line2_y = LinePosition(2)
local line3_y = LinePosition(3)
local line4_y = LinePosition(4)
local line5_y = LinePosition(5)
local line6_y = LinePosition(6)
local line7_y = LinePosition(7)
local line8_y = LinePosition(8)
local line9_y = LinePosition(9)

local line15_y = LinePosition(15)
local line16_y = LinePosition(16)

local label_x = 0.07
local value_x = 0.07
local key_x = 0.5


local function newHints08()
	local txt			= CreateElement "ceStringPoly"
	txt.material		= font_hints_kneeboard
	txt.stringdefs		= predefined_font_08
	return txt
end

local function newKeys()
	local txt			= CreateElement "ceStringPoly"
	txt.material		= font_hints_kneeboard_keys
	txt.stringdefs		= predefined_font_0
	txt.alignment		= "LeftBottom"
	return txt
end

local function newHints()
	local txt			= CreateElement "ceStringPoly"
	txt.material		= font_hints_kneeboard
	txt.stringdefs		= predefined_font_0
	return txt
end


txt_WeapStatus				= newHints08()
txt_WeapStatus.name			= "txt_WeapStatus"
txt_WeapStatus.init_pos		= {0, line1_y, 0}
txt_WeapStatus.value		= _("WEAPON STATUS:_board")
txt_WeapStatus.alignment	= "CenterBottom"
txt_WeapStatus.controllers	= {{"show_weap_status"}}
AddElement(txt_WeapStatus)

for i = 1, 6 do
	local txt_Status_Pilon			= newHints()
	txt_Status_Pilon.init_pos		= {-0.75 + (i-1) * 0.3, line2_y, 0}
	txt_Status_Pilon.formats		= {"---",
									   _("GUV-GL_board"),
									   _("GUV-MG_board"),
									   _("UPK_board"),
									   _("B8_board"),
									   _("Bomb_board")}
	txt_Status_Pilon.alignment		= "CenterBottom"
	txt_Status_Pilon.controllers	= {{"show_weap_status"},{"Status_Pilon", i}}
	AddElement(txt_Status_Pilon)
end


for i = 1, 6 do
	local txt_Count_on_pilon		= newHints()
	txt_Count_on_pilon.name			= "txt_Count_on_pilon" .. string.format("%i", i)
	txt_Count_on_pilon.init_pos		= {-0.75 + (i-1) * 0.3, line3_y, 0}
	txt_Count_on_pilon.alignment	= "CenterBottom"
	txt_Count_on_pilon.controllers	= {{"show_weap_status"},{"Count_on_pilon", i}}
	AddElement(txt_Count_on_pilon)
end

txt_Master_Armed				= newHints()
txt_Master_Armed.name			= "txt_Master_Armed"
txt_Master_Armed.init_pos		= {label_x, line5_y, 0}
txt_Master_Armed.value			= _("MASTER ARM:_board")
txt_Master_Armed.alignment		= "RightBottom"
txt_Master_Armed.controllers	= {{"show_weap_status"}}
AddElement(txt_Master_Armed)

txt_Master_Armed_Value				= newHints()
txt_Master_Armed_Value.name			= "txt_Master_Armed_Value"
txt_Master_Armed_Value.init_pos		= {value_x, line5_y, 0}
txt_Master_Armed_Value.formats		= {_("OFF_board"), _("ON_board")}
txt_Master_Armed_Value.alignment	= "LeftBottom"
txt_Master_Armed_Value.controllers	= {{"show_weap_status"},{"Master_Armed"}}
AddElement(txt_Master_Armed_Value)

txt_Master_Armed_key				= newKeys()
txt_Master_Armed_key.name			= "txt_Master_Armed_key"
txt_Master_Armed_key.init_pos		= {key_x, line5_y, 0}
txt_Master_Armed_key.value			= "P"
txt_Master_Armed_key.controllers    = {{"show_weap_status"}}
AddElement(txt_Master_Armed_key)
 
txt_Safe_Armed				= newHints()
txt_Safe_Armed.name			= "txt_Safe_Armed"
txt_Safe_Armed.init_pos		= {label_x, line6_y, 0}
txt_Safe_Armed.value		= _("SAFETY SWITCHER:_board")
txt_Safe_Armed.alignment	= "RightBottom"
txt_Safe_Armed.controllers	= {{"show_weap_status"}}
AddElement(txt_Safe_Armed)

txt_Safe_Armed_Value				= newHints()
txt_Safe_Armed_Value.name			= "txt_Safe_Armed_Value"
txt_Safe_Armed_Value.init_pos		= {value_x, line6_y, 0}
txt_Safe_Armed_Value.formats		= {_("SAFE_board"), _("ARMED_board")}
txt_Safe_Armed_Value.alignment		= "LeftBottom"
txt_Safe_Armed_Value.controllers    = {{"show_weap_status"},{"Safe_Armed"}}
AddElement(txt_Safe_Armed_Value)

txt_Safe_Armed_key				= newKeys()
txt_Safe_Armed_key.name			= "txt_Safe_Armed_key"
txt_Safe_Armed_key.init_pos		= {key_x, line6_y, 0}
txt_Safe_Armed_key.value		= "LALT S"
txt_Safe_Armed_key.controllers	= {{"show_weap_status"}}
AddElement(txt_Safe_Armed_key)

txt_Active_Weap				= newHints()
txt_Active_Weap.name		= "txt_Active_Weap"
txt_Active_Weap.init_pos	= {label_x, line7_y, 0}
txt_Active_Weap.value    	= _("ACTIVE WEAPON:_board")
txt_Active_Weap.alignment  	= "RightBottom"
txt_Active_Weap.controllers	= {{"show_weap_status"}}
AddElement(txt_Active_Weap)

txt_Active_Weap_Value				= newHints()
txt_Active_Weap_Value.name			= "txt_Active_Weap_Value"
txt_Active_Weap_Value.init_pos		= {value_x, line7_y, 0}
txt_Active_Weap_Value.formats		= {_("RS_board"), _("PKT_board"), _("UPK_board"), _("GUV-0_board"), _("GUV-800_board"), _("GUV-624_board"), _("GUV-622_board")}
txt_Active_Weap_Value.alignment		= "LeftBottom"
txt_Active_Weap_Value.controllers	= {{"show_weap_status"}, {"Active_Weap"}}
AddElement(txt_Active_Weap_Value)

txt_Active_Weap_Key				= newKeys()
txt_Active_Weap_Key.name		= "txt_Active_Weap_Key"
txt_Active_Weap_Key.init_pos	= {key_x, line7_y, 0}
txt_Active_Weap_Key.formats		= {"RC + ]/[", "RC + ]/[", "RC + ]/[", "RA+RC+]/[", "RA+RC+]/[", "RA+RC+]/[", "RA+RC+]/["}
txt_Active_Weap_Key.controllers	= {{"show_weap_status"}, {"Active_Weap"}}
AddElement(txt_Active_Weap_Key)

txt_Selector				= newHints()
txt_Selector.name			= "txt_Selector"
txt_Selector.init_pos		= {label_x, line8_y, 0}
txt_Selector.value    		= _("BW:_board")
txt_Selector.alignment  	= "RightBottom"
txt_Selector.controllers    = {{"show_weap_status"}}
AddElement(txt_Selector)

txt_Selector_Value				= newHints()
txt_Selector_Value.name			= "txt_Selector_Value"
txt_Selector_Value.init_pos		= {value_x,  line8_y, 0}
txt_Selector_Value.formats		= {_("I_board"), _("II_board"), _("III_board"), _("IV_board"), _("V_board"), _("GUV_board")}
txt_Selector_Value.alignment	= "LeftBottom"
txt_Selector_Value.controllers	= {{"show_weap_status"}, {"Selector_Value"}}
AddElement(txt_Selector_Value)

txt_Selector_Key				= newKeys()
txt_Selector_Key.name			= "txt_Selector_Key"
txt_Selector_Key.init_pos		= {key_x,  line8_y, 0}
txt_Selector_Key.value    		= ":/."
txt_Selector_Key.controllers	= {{"show_weap_status"}}
AddElement(txt_Selector_Key)


txt_FLARES				= newHints()
txt_FLARES.name			= "txt_FLARES"
txt_FLARES.init_pos		= {-0.9, line15_y, 0}
txt_FLARES.value    	= _("FLARES:")
txt_FLARES.alignment  	= "LeftBottom"
AddElement(txt_FLARES)

txt_FLARES_Count				= newHints()
txt_FLARES_Count.name			= "txt_FLARES_Count"
txt_FLARES_Count.init_pos		= {0, line15_y, 0}
txt_FLARES_Count.alignment		= "CenterBottom"
txt_FLARES_Count.controllers	= {{"Snars_Count", 1}}
AddElement(txt_FLARES_Count)

txt_CHAFFS				= newHints()
txt_CHAFFS.name			= "txt_CHAFFS"
txt_CHAFFS.init_pos		= {-0.9, line16_y, 0}
txt_CHAFFS.value    	= _("CHAFFS:")
txt_CHAFFS.alignment  	= "LeftBottom"
AddElement(txt_CHAFFS)

txt_CHAFFS_Count				= newHints()
txt_CHAFFS_Count.name			= "txt_CHAFFS_Count"
txt_CHAFFS_Count.init_pos		= {0, line16_y, 0}
txt_CHAFFS_Count.alignment		= "CenterBottom"
txt_CHAFFS_Count.controllers	= {{"Snars_Count", 0}}
AddElement(txt_CHAFFS_Count)

-- CREW ------------------------------
---------------------------------------

local crew_first_line_y = LinePosition(24)
local crew_line1_y = crew_first_line_y

local crew_label_x = 0.3
local crew_value_x = 0.4
local crew_key_x = 0.4

base				= newHints08()
base.name			= "txt_Status"
base.value    		= _("CREW STATUS:_board")    
base.init_pos		= {0,  crew_line1_y, 0}
base.alignment   	= "CenterBottom"
base.controllers    = {{"show"}}
AddElement(base)

txt_Hints				= newHints()
txt_Hints.name			= "txt_Hints"
txt_Hints.value    		= _("HEALTH     ROE       AMMO  BURST_board")
txt_Hints.init_pos		= {-0.9, - dY}
txt_Hints.alignment   	= "LeftBottom"
txt_Hints.parent_element = base.name
AddElement(txt_Hints)

local m_index = 0

name_t = {_("PILOT_board"), _("GUNNER_board"),}
status_t = {"-", _("HOLD_board"), _("RET.FIRE_board"), _("FREE FIRE_board"), _("PLAYER_board")}
burst_t = {"  -", _("SHORT_board"), _("LONG_board")}
seats_n =    {0,2}

function add_crew_member(member)
txt_member					= newHints()
txt_member.name				= "txt_mem"..m_index
txt_member.value    		= member    
txt_member.init_pos			= {-0.9, -dY*(m_index+2) }
txt_member.alignment   		= "LeftBottom"
txt_member.parent_element	= base.name
txt_member.controllers		= {{"show_member",seats_n[m_index+1]},{"health",seats_n[m_index+1]}}
AddElement(txt_member)

txt_status					= newHints()
txt_status.name				= "txt_status"..m_index  
txt_status.init_pos			= {0.5, 0.0 }
txt_status.alignment   		= "LeftBottom"
txt_status.parent_element	= txt_member.name
txt_status.formats    		= status_t
txt_status.controllers		= {{"status",seats_n[m_index+1]}}
AddElement(txt_status)

txt_ammo				= newHints()
txt_ammo.name			= "txt_ammo"..m_index
txt_ammo.init_pos		= {0.95, 0.0}
txt_ammo.alignment   	= "LeftBottom"
txt_ammo.parent_element = txt_member.name
txt_ammo.formats    	= {"%d%%"," -"}
txt_ammo.controllers  	= {{"ammo",seats_n[m_index+1]}}
AddElement(txt_ammo)

txt_burst					= newHints()
txt_burst.name				= "txt_burst"..m_index 
txt_burst.init_pos			= {1.22, 0.0}
txt_burst.alignment   		= "LeftBottom"
txt_burst.parent_element	= txt_member.name
txt_burst.formats    		= burst_t
txt_burst.controllers		= {{"burst",seats_n[m_index+1]}}
AddElement(txt_burst)

m_index = m_index + 1
end


add_crew_member(name_t[1])
add_crew_member(name_t[2])

txt_Gunner_Key					= newKeys()
txt_Gunner_Key.name				= "txt_Gunner_Key"
txt_Gunner_Key.init_pos			= {1.51, 0.0}
txt_Gunner_Key.value			= "LC+LW+4"
txt_Gunner_Key.parent_element	= "txt_mem1"
txt_Gunner_Key.controllers		= {{"show_member",2}}
AddElement(txt_Gunner_Key)