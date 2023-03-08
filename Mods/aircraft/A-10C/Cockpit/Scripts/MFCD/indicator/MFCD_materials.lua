
local postfix  = "_RIGHT"
if  disposition == 'L' then
	  postfix  = "_LEFT"
end
font_MFCD 	     = "font_MFCD"        .. postfix
font_MFCD_RED    = "font_MFCD_RED"    .. postfix
font_MFCD_BLUE   = "font_MFCD_BLUE"   .. postfix
font_MFCD_BLACK  = "font_MFCD_BLACK"  .. postfix
font_MFCD_GREY   = "font_MFCD_GREY"   .. postfix
font_MFCD_WHITE  = "font_MFCD_WHITE"  .. postfix
font_MFCD_YELLOW = "font_MFCD_YELLOW" .. postfix
font_TGP	     = "font_TGP"		  .. postfix

MFCD_SOLID_BLACK 		= "INDICATION_COMMON_BLACK"
MFCD_SOLID_GREY         = "MFCD_GREY" 	  .. postfix
MFCD_SOLID_DARK_GREY    = "MFCD_DARK_GREY".. postfix

MFCD_SOLID_GREY_2       = "MFCD_GREY_2"   .. postfix
MFCD_SOLID_GREY_MAV     = "MFCD_GREY_MAV" .. postfix

MFCD_SOLID_WHITE        = "MFCD_WHITE"	.. postfix
MFCD_SOLID_YELLOW		= "MFCD_YELLOW" .. postfix
MFCD_SOLID_RED          = "MFCD_RED"    .. postfix
MFCD_SOLID_GREEN        = "MFCD_GREEN"  .. postfix
MFCD_SOLID_BLUE         = "MFCD_BLUE"   .. postfix
MFCD_SOLID_VIOLET 		= "MFCD_VIOLET" .. postfix

MFCD_CICU_BLACK        = "MFCD_CICU_BLACK"
MFCD_CICU_WHITE		   = "MFCD_CICU_WHITE" 
MFCD_CICU_GREY         = "MFCD_CICU_GREY"    
MFCD_CICU_INIT_BLUE    = "MFCD_CICU_WHITE"

MFCD_YELLOW  = "INDICATION_MFCD_YELLOW" .. postfix
MFCD_BLUE    = "INDICATION_MFCD_BLUE"   .. postfix
MFCD_GREEN   = "INDICATION_MFCD_GREEN"  .. postfix
MFCD_RED     = "INDICATION_MFCD_RED"    .. postfix
MFCD_BLACK	 = "INDICATION_MFCD_BLACK"  .. postfix
MFCD_WHITE	 = "INDICATION_MFCD_WHITE"  .. postfix
MFCD_GREY    = "INDICATION_MFCD_GREY"   .. postfix
MFCD_GREY_2  = "INDICATION_MFCD_GREY_2" .. postfix
MFCD_VIOLET  = "INDICATION_MFCD_VIOLET" .. postfix

MFCD_TEST_DISP_GREY 	= {}
MFCD_TEST_DISP_RED 		= {}
MFCD_TEST_DISP_GREEN 	= {}
MFCD_TEST_DISP_BLUE 	= {}

for i=1,8 do
	MFCD_TEST_DISP_GREY[i]	= "MFCD_TEST_DISP_GREY_"..i
	MFCD_TEST_DISP_RED[i]	= "MFCD_TEST_DISP_RED_"..i
	MFCD_TEST_DISP_GREEN[i]	= "MFCD_TEST_DISP_GREEN_"..i
	MFCD_TEST_DISP_BLUE[i]	= "MFCD_TEST_DISP_BLUE_"..i
end 

