dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local rootName = "UFC_BU_root"
addPlaceholder(rootName, {0, 0})

-- Buttons

add_PB_label(1, "RET")
add_PB_label(3, "PAGE", {"", rootName, {{"MPD_UFC_BU_CurrentPage"}}})
add_PB_symbol(4, "075-arrow-down")
addStrokeText("CHAN_label", "C\nH\nA\nN\n", STROKE_FNT_DFLT_100, "LeftCenter", {-505, 227}, nil)
add_PB_symbol(5, "075-arrow-up")

add_PB_label(6, {"COM1", rootName, nil, {{"MPD_UFC_BU_CurrentSelectedStations", 1}}}, {"", rootName, {{"MPD_UFC_BU_CurrentChannel", 1}}}, {"", rootName, {{"MPD_UFC_BU_CurrentFrequency", 1}}})
add_PB_label(7, {"COM2", rootName, nil, {{"MPD_UFC_BU_CurrentSelectedStations", 2}}}, {"", rootName, {{"MPD_UFC_BU_CurrentChannel", 2}}}, {"", rootName, {{"MPD_UFC_BU_CurrentFrequency", 2}}})
add_PB_label(8, "1")
add_PB_label(9, "2")
add_PB_label(10, "3")

add_PB_label(11, "4")
add_PB_label(12, "5")
add_PB_label(13, "6")
add_PB_label(14, "7")
add_PB_label(15, "8")

add_PB_label(16, "9")
add_PB_label(17, "0")
add_PB_label(19, "ENT")
add_PB_label(20, "CLR")

------- Table of channels

local function addChannels(num)
	local placeholder_name = "UFC_BU_TableOfChannels_"..num
	addPlaceholder(placeholder_name, {0, 0}, rootName, {{"MPD_UFC_BU_CurrentGroupChannel", num}})

	addStrokeText("UFC_BU_TableOfChannels_VALUE"..num.."_StationNumber",		"",	STROKE_FNT_DFLT_120, "CenterCenter", {-200,	0}, 	placeholder_name, {{"MPD_UFC_BU_GroupMemberNumber", num}})
	addStrokeText("UFC_BU_TableOfChannels_VALUE"..num.."_StationFrequency",		"",	STROKE_FNT_DFLT_120, "CenterCenter", {-20,	0}, 	placeholder_name, {{"MPD_UFC_BU_GroupMemberFrequency", num}})
	addStrokeText("UFC_BU_TableOfChannels_VALUE"..num.."_StationDesignation",	"",	STROKE_FNT_DFLT_120, "CenterCenter", {180,	0}, 	placeholder_name, {{"MPD_UFC_BU_GroupMemberDesignation", num}})
	
	addStrokeBox("UFC_BU_TableOfChannels_VALUE"..num.."_StationBox", 480, 50, "CenterCenter", {0, 0}, placeholder_name, {{"MPD_UFC_BU_GroupMemberSelectedChannelBox", num}})
end

for i = 0, 11 do
	addChannels(i)
end

addStrokeLine("BOTTOM_LINE", 550, {-270, -350}, -90, rootName)
--------

-- ScratchPad
local scratchPad = "UFC_BU_ScratchPad"
addPlaceholder(scratchPad, {280,380}, rootName, {{"MPD_UFC_BU_ScratchPad_Show"}})
addStrokeText("UFC_BU_ScratchPadText", "123.456", STROKE_FNT_DFLT_100, "CenterCenter", {0, 0}, scratchPad, {{"MPD_UFC_BU_ScratchPad_NewFrequency"}})
addStrokeBox("UFC_BU_ScratchPadBox", 200, 50, "CenterCenter", {0, 0}, scratchPad)

--

addMenuLabel("MENU", rootName, nil, false)