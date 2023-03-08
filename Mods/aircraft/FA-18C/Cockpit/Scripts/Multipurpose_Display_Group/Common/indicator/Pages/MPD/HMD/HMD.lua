dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

--add_PB_label(1, {"UPLK"}, {"ALGN"})
local pb1 = add_PB_label(1, {"UPLK", nil, {{"MPD_HMD_PB1_TEXT", 0}}},
							{"ALGN", nil, {{"MPD_HMD_PB1_TEXT", 0}}})
							
local pb1_align = add_PB_label(1, {"FINE", nil, {{"MPD_HMD_PB1_TEXT", 1}}})
	  add_PB_label(1, {"    ", nil, nil, {{"MPD_HMD_FINE_Box"}}})
	  
local pb3 = add_PB_label(3, {"UPLK", nil, {{"MPD_HMD_PB1_TEXT", 0}}},
							{"RESET", nil, {{"MPD_HMD_PB1_TEXT", 0}}})

local rejectOpt = add_PB_label(7, {"", nil, {{"MPD_HMD_Reject_Level_Option"}}})[1]
rejectOpt.formats = {"",
					 "NORM",
					 "REJ 1",
					 "REJ 2"}

local brtOpt = add_PB_label(11, {"", nil, {{"MPD_HMD_Bright_Option"}}}, "BRT")
				  
add_PB_label(12, {"BLNK", nil, nil, {{"MPD_HMD_Blank_Box"}}})

add_PB_label(17, "MIDS\nSETUP")
add_PB_label(19, "REJECT\nSETUP")
add_PB_label(20, {"ALIGN", nil, nil, {{"MPD_HMD_ALIGN"}}})
