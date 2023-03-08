dofile(LockOn_Options.script_path.."EWS/RWR/indicator/RWR_ALR56_definitions.lua")
---------------------------- BIT ---------------------------------
local BIT_PAGES =
{
	OFF = 0,
	PAGE_1 = 1,
	PAGE_2 = 2,
	PAGE_3 = 3,
	PAGE_4 = 4,
	PAGE_5 = 5,
	PAGE_6 = 6,
	PAGE_7 = 7,
	PAGE_8 = 8,
	PAGE_1A = 9,		-- Special BIT page
}

-- BIT Page 1
AddText("RWR_BIT_1", 0.0 , -0.05, {{"RWR_BIT_Page_Fails", BIT_PAGES.PAGE_1}}, "RWR\nSYSTEM GO")

-- BIT Page 2
AddText("RWR_BIT_2", -0.25 , -0.6, {{"RWR_BIT_Page_Fails", BIT_PAGES.PAGE_2}}, "F16C")

-- BIT Page 3
AddText("RWR_BIT_3", -0.3, -0.4, {{"RWR_BIT_Page_Fails", BIT_PAGES.PAGE_3}}, "OFP")
AddText("RWR_BIT_3_1", 0.45, -0.4, {{"RWR_BIT_Page_Fails", BIT_PAGES.PAGE_3}}, "0020")

-- BIT Page 4
AddText("RWR_BIT_4", 0.1 , -0.2, {{"RWR_BIT_Page_Fails", BIT_PAGES.PAGE_4}}, "WO	0040")

-- BIT Page 5
AddText("RWR_BIT_5", 0.1 , 0.0, {{"RWR_BIT_Page_Fails", BIT_PAGES.PAGE_5}}, "PA	0050")

-- BIT Page 6
AddText("RWR_BIT_6", 0.1 , 0.2, {{"RWR_BIT_Page_Fails", BIT_PAGES.PAGE_6}}, "US	0060")

-- BIT Page 7
AddText("RWR_BIT_7", -0.05 , 0.4, {{"RWR_BIT_Page_Fails", BIT_PAGES.PAGE_7}}, "TEST OK")

-- BIT Page 8

-- BIT Page 1A Special
