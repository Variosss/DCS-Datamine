-------------------------------------------------------------
-- Warnings 1
-- non-acknowledgeable - Middle of both MFCDs in red reverse video
GCAS_BREAK_X_advisory_msg						= CreateElement "ceStringPoly"
GCAS_BREAK_X_advisory_msg.name					= "GCAS_BREAK_X_advisory_msg"
GCAS_BREAK_X_advisory_msg.material				= font_MFCD_BLACK
GCAS_BREAK_X_advisory_msg.UseBackground			= true
GCAS_BREAK_X_advisory_msg.BackgroundMaterial	= MFCD_SOLID_RED
GCAS_BREAK_X_advisory_msg.alignment				= "CenterCenter"
GCAS_BREAK_X_advisory_msg.value					= "GCAS BREAK X"
GCAS_BREAK_X_advisory_msg.stringdefs			= txt_Warnings1
SetLowerLeftCornerOrigin(GCAS_BREAK_X_advisory_msg)
GCAS_BREAK_X_advisory_msg.init_pos              = {max_pixels_count/2, max_pixels_count/2 + 60}
GCAS_BREAK_X_advisory_msg.controllers			= {{"GCAS_BREAK_X_advisory_msg"}}
Add(GCAS_BREAK_X_advisory_msg)
use_mipfilter(GCAS_BREAK_X_advisory_msg)


WCPN_vertices = {{-174, 53},
				 { 174, 53},
				 { 174, -54},
				 {-174, -54}}

NOTE_vertices = {{-44, 90},
				 {  0, 90},
				 {  0, 0},
				 {-44, 0}}

WCPN_init_pos = {max_pixels_count/2, max_pixels_count/3 - 27}

WCN_DESCR = {}
WCN_DESCR["WARNING2"] =
    {vertices = WCPN_vertices,
     bcgnd_clr = MFCD_SOLID_RED,
     binit_pos = WCPN_init_pos,
     init_pos = {0},
     font = txt_Advisories_font,
     alnment = "CenterCenter",
     UseBack = false,
    }
WCN_DESCR["CAUTION"] =
    {vertices = WCPN_vertices,
     bcgnd_clr = MFCD_SOLID_YELLOW,
     binit_pos = WCPN_init_pos,
     init_pos = {0},
     font = txt_Advisories_font,
     alnment = "CenterCenter",
     UseBack = false,
    }
WCN_DESCR["PRI_NOTE"] = 
    {vertices = WCPN_vertices,
     bcgnd_clr = MFCD_SOLID_WHITE,
     binit_pos = WCPN_init_pos,
     init_pos = {0},
     font = txt_Advisories_font,
     alnment = "CenterCenter",
     UseBack = false,
    }
WCN_DESCR["NOTE"] =
    {vertices = NOTE_vertices,
     bcgnd_clr = MFCD_SOLID_WHITE,
     binit_pos = {max_pixels_count, 10},
     init_pos = {0, 46.8},
     font = predefined_fonts[1],
     alnment = "RightCenter",
     UseBack = true,
    }
	
function createWCN(type, ctrlr)
	local elm_back         = CreateElement "ceMeshPoly"
	elm_back.primitivetype = "triangles"
	elm_back.material	   = WCN_DESCR[type].bcgnd_clr
	elm_back.vertices      = WCN_DESCR[type].vertices
	elm_back.indices       = box_ind
	SetLowerLeftCornerOrigin(elm_back)
	elm_back.init_pos      = WCN_DESCR[type].binit_pos
	elm_back.controllers   = ctrlr
	Add(elm_back)
	use_mipfilter(elm_back)


	local elm              = CreateElement "ceStringPoly"
	elm.material           = font_MFCD_BLACK
	
	local ToUseBackgnd     = WCN_DESCR[type].UseBack
	elm.UseBackground      = ToUseBackgnd
	if ToUseBackgnd then
        elm.BackgroundMaterial = WCN_DESCR[type].bcgnd_clr
	end
		
	elm.alignment          = WCN_DESCR[type].alnment
	elm.stringdefs         = WCN_DESCR[type].font
	elm.parent_element     = elm_back.name
	elm.init_pos           = WCN_DESCR[type].init_pos
	Add(elm)
	use_mipfilter(elm)
	
	return elm
end

local wcn_counter = 0
local wcn_text = {}


local function add_WCN_text(text)
	wcn_counter = wcn_counter + 1
	wcn_text[wcn_counter] = text
end

local wcn = {}

-------------------------------------------------------------
-- Warnings 2
-- acknowledgeable - Lower center of both MFCDs in red reverse video
-------------------------------------------------------------
add_WCN_text(
"CHECK\n"..
"ATTITUDE")

idx_begin = wcn_counter

add_WCN_text(
"IAM LAUNCH\n"..
"ABORT")

add_WCN_text(
"EMERGENCY\n"..
"JETT FAIL")

add_WCN_text(
"HUNG STORE\n"..
"STATION XX")

idx_msg_hung = wcn_counter

idx_end = wcn_counter

for idx = idx_begin, idx_end do
    wcn[idx] = createWCN("WARNING2", {{"wcn_active_WCPN", idx}})
    wcn[idx].value = wcn_text[idx]
end

wcn[idx_msg_hung].formats =
{
"HUNG STORE\n"..
"STATION %02d"
}
wcn[idx_msg_hung].controllers = 
	{{"wcn_active_WCPN", idx_msg_hung}, {"WCN_LastHungStoreStation"}}

-------------------------------------------------------------
-- Cautions
-- acknowledgeable - Lower center of both MFCDs in yellow reverse video
-------------------------------------------------------------
add_WCN_text(
"CICU\n"..
"FAIL")

idx_begin = wcn_counter

add_WCN_text(
"TGP LASER/INV\n"..
"CONFLICT")

add_WCN_text(
"ALM\n"..
"FAIL")

add_WCN_text(
"28VDC ISA\n"..
"FAIL")

add_WCN_text(
"ISA EMERGENCY\n"..
"JETT FAIL")

add_WCN_text(
"ALL WEAPONS\n"..
"FAIL")

add_WCN_text(
"ODD STATIONS\n"..
"FAIL")

add_WCN_text(
"EVEN STATIONS\n"..
"FAIL")

add_WCN_text(
"RELEASE\n"..
"ABORTED")

add_WCN_text(
"IFF\n"..
"FAILURE")

add_WCN_text(
"CHECK\n"..
"MASTER ARM")

add_WCN_text(
"CHECK GND\n"..
"SAFETY ORIDE")

add_WCN_text(
"CHECK\n"..
"GUN ARM")

add_WCN_text(
"CHECK\n"..
"PICKLE")

add_WCN_text(
"CHECK\n"..
"LASER ARM")

add_WCN_text(
"MASTER ARM\n"..
"FAIL")

add_WCN_text(
"LASER CODE\n"..
"MISMATCH")

add_WCN_text(
"GUN ARM\n"..
"FAIL")

add_WCN_text(
"IFF\n"..
"NOT READY")

add_WCN_text(
"IFFCC AV3\n"..
"NOT READY")

add_WCN_text(
"EGI AV3\n"..
"NOT READY")

add_WCN_text(
"CDU\n"..
"NOT READY")

add_WCN_text(
"CADC\n"..
"NOT READY")

add_WCN_text(
"LEFT MFCD\n"..
"NOT READY")

add_WCN_text(
"RIGHT MFCD\n"..
"NOT READY")

add_WCN_text(
"TGP\n"..
"NOT READY")

add_WCN_text(
"EPLRS\n"..
"NOT READY")

add_WCN_text(
"JDAM NOT READY\n"..
"STATION 3")

add_WCN_text(
"JDAM NOT READY\n"..
"STATION 4")

add_WCN_text(
"JDAM NOT READY\n"..
"STATION 5")

add_WCN_text(
"JDAM NOT READY\n"..
"STATION 7")

add_WCN_text(
"JDAM NOT READY\n"..
"STATION 8")

add_WCN_text(
"JDAM NOT READY\n"..
"STATION 9")

add_WCN_text(
"WCMD NOT READY\n"..
"STATION 3")

add_WCN_text(
"WCMD NOT READY\n"..
"STATION 4")

add_WCN_text(
"WCMD NOT READY\n"..
"STATION 5")

add_WCN_text(
"WCMD NOT READY\n"..
"STATION 7")

add_WCN_text(
"WCMD NOT READY\n"..
"STATION 8")

add_WCN_text(
"WCMD NOT READY\n"..
"STATION 9")

add_WCN_text(
"1760 NOT READY\n"..
"STATION 3")

add_WCN_text(
"1760 NOT READY\n"..
"STATION 4")

add_WCN_text(
"1760 NOT READY\n"..
"STATION 5")

add_WCN_text(
"1760 NOT READY\n"..
"STATION 7")

add_WCN_text(
"1760 NOT READY\n"..
"STATION 8")

add_WCN_text(
"1760 NOT READY\n"..
"STATION 9")

add_WCN_text(
"LEFT MFCD\n"..
"FAIL")

add_WCN_text(
"RIGHT MFCD\n"..
"FAIL")

add_WCN_text(
"TGP\n"..
"FAIL")

add_WCN_text(
"EPLRS\n"..
"INOP")

add_WCN_text(
"MASTER ARM\n"..
"SWITCH FAIL")

add_WCN_text(
"GUN TRIGGER\n"..
"FAIL")

add_WCN_text(
"WEAPON RELEASE\n"..
"STUCK KEY")
 
add_WCN_text(
"LASER ARM\n"..
"SWITCH FAIL")

add_WCN_text(
"ALM POWER\n"..
"FAIL")

add_WCN_text(
"TMS SWITCH\n"..
"FAIL")

add_WCN_text(
"DMS SWITCH\n"..
"FAIL")

add_WCN_text(
"SLEW\n"..
"FAIL")

add_WCN_text(
"COOLIE SWITCH\n"..
"FAIL")

add_WCN_text(
"BOAT SWITCH\n"..
"FAIL")

add_WCN_text(
"CHINA HAT\n"..
"SWITCH FAIL")

add_WCN_text(
"JDAM FAIL\n"..
"STATION 3")

add_WCN_text(
"JDAM FAIL\n"..
"STATION 4")

add_WCN_text(
"JDAM FAIL\n"..
"STATION 5")

add_WCN_text(
"JDAM FAIL\n"..
"STATION 7")

add_WCN_text(
"JDAM FAIL\n"..
"STATION 8")

add_WCN_text(
"JDAM FAIL\n"..
"STATION 9")

add_WCN_text(
"WCMD FAIL\n"..
"STATION 3")

add_WCN_text(
"WCMD FAIL\n"..
"STATION 4")

add_WCN_text(
"WCMD FAIL\n"..
"STATION 5")

add_WCN_text(
"WCMD FAIL\n"..
"STATION 7")

add_WCN_text(
"WCMD FAIL\n"..
"STATION 8")

add_WCN_text(
"WCMD FAIL\n"..
"STATION 9")

add_WCN_text(
"JDAM JPF FAIL\n"..
"STATION 3")

add_WCN_text(
"JDAM JPF FAIL\n"..
"STATION 4")

add_WCN_text(
"JDAM JPF FAIL\n"..
"STATION 5")

add_WCN_text(
"JDAM JPF FAIL\n"..
"STATION 7")

add_WCN_text(
"JDAM JPF FAIL\n"..
"STATION 8")

add_WCN_text(
"JDAM JPF FAIL\n"..
"STATION 9")

add_WCN_text(
"TRIGGER 1ST\n"..
"STUCK KEY")

add_WCN_text(
"TRIGGER 2ND\n"..
"STUCK KEY")

add_WCN_text(
"TMS SWITCH\n"..
"STUCK KEY")

add_WCN_text(
"DMS SWITCH\n"..
"STUCK KEY")

add_WCN_text(
"SLEW SWITCH\n"..
"STUCK KEY")

add_WCN_text(
"COOLIE SWITCH\n"..
"STUCK KEY")

add_WCN_text(
"CHINA HAT SW\n"..
"STUCK KEY")

add_WCN_text(
"LEFT MFCD\n"..
"STUCK KEY")

add_WCN_text(
"RIGHT MFCD\n"..
"STUCK KEY")

add_WCN_text(
"AV2 FAIL")

add_WCN_text(
"AV3 FAIL")

add_WCN_text(
"1760 FAIL")

add_WCN_text(
"CICU\n"..
"DEGRADED")

add_WCN_text(
"ALM\n"..
"DEGRADED")

add_WCN_text(
"GVM VIDEO\n"..
"FAIL")

add_WCN_text(
"CICU\n"..
"OVER TEMP")

add_WCN_text(
"LEFT MFCD\n"..
"OVER TEMP")

add_WCN_text(
"RIGHT MFCD\n"..
"OVER TEMP")

add_WCN_text(
"JDAM GPS FAIL\n"..
"STATION 3")

add_WCN_text(
"JDAM GPS FAIL\n"..
"STATION 4")

add_WCN_text(
"JDAM GPS FAIL\n"..
"STATION 5")

add_WCN_text(
"JDAM GPS FAIL\n"..
"STATION 7")

add_WCN_text(
"JDAM GPS FAIL\n"..
"STATION 8")

add_WCN_text(
"JDAM GPS FAIL\n"..
"STATION 9")

add_WCN_text(
"JDAM TM FAIL\n"..
"STATION 3")

add_WCN_text(
"JDAM TM FAIL\n"..
"STATION 4")

add_WCN_text(
"JDAM TM FAIL\n"..
"STATION 5")

add_WCN_text(
"JDAM TM FAIL\n"..
"STATION 7")

add_WCN_text(
"JDAM TM FAIL\n"..
"STATION 8")

add_WCN_text(
"JDAM TM FAIL\n"..
"STATION 9")

add_WCN_text(
"WCMD TM FAIL\n"..
"STATION 3")

add_WCN_text(
"WCMD TM FAIL\n"..
"STATION 4")

add_WCN_text(
"WCMD TM FAIL\n"..
"STATION 5")

add_WCN_text(
"WCMD TM FAIL\n"..
"STATION 7")

add_WCN_text(
"WCMD TM FAIL\n"..
"STATION 8")

add_WCN_text(
"WCMD TM FAIL\n"..
"STATION 9")

add_WCN_text(
"ANALOG INPUT\n"..
"FAIL")

add_WCN_text(
"ANALOG OUTPUT\n"..
"FAIL")
 
add_WCN_text(
"FUEL QUANTITY\n"..
"FAIL")

add_WCN_text(
"AIM9\n"..
"SEEKER FAIL")

add_WCN_text(
"MAV\n"..
"GIMBAL FAIL")

add_WCN_text(
"TGP\n"..
"TRACKER FAIL")

add_WCN_text(
"TGP\n"..
"VIDEO FAIL")

add_WCN_text(
"TGP\n"..
"FLIR FAIL")

add_WCN_text(
"TGP\n"..
"LASER FAIL")

add_WCN_text(
"TGP LASER\n"..
"DES FAIL")

add_WCN_text(
"TGP LASER\n"..
"SPOT FAIL")

add_WCN_text(
"TGP LASER\n"..
"RANGER FAIL")

add_WCN_text(
"TGP BORESIGHT\n"..
"FAIL")

add_WCN_text(
"TGP ECU\n"..
"FAIL")

add_WCN_text(
"TGP\n"..
"OVER TEMP")

add_WCN_text(
"TGP HIGH\n"..
"PRESSUR FAIL")

add_WCN_text(
"TGP LASER\n"..
"MARKER FAIL")

add_WCN_text(
"TGP CID\n"..
"FAIL")

add_WCN_text(
"TGP\n"..
"DEGRADED")

add_WCN_text(
"EPLRS\n"..
"DEGRADED")

add_WCN_text(
"TGP BUS A\n"..
"FAIL")

add_WCN_text(
"TGP BUS B\n"..
"FAIL")

add_WCN_text(
"TGP AUTOLASE\n"..
"FAIL")

add_WCN_text(
"TGP HOME\n"..
"FAIL")

add_WCN_text(
"LASER DES\n"..
"CODE INVALID")

add_WCN_text(
"LASER TRACK\n"..
"CODE INVALID")

add_WCN_text(
"IFF UPDATE\n"..
"TIMEOUT")

add_WCN_text(
"IFF\n"..
"MISMATCH")

add_WCN_text(
"IFF WOW\n"..
"UPDATE FAIL")

add_WCN_text(
"IFF DEFAULT\n"..
"MS INVALID")

add_WCN_text(
"IFF\n"..
"BUS A FAIL")

add_WCN_text(
"IFF\n"..
"BUS B FAIL")

--[[
add_WCN_text(
"ARC-210 (1)\n"..
"BUS A FAIL") ]]--
 
add_WCN_text(
"WS3\n"..
"BUS A FAIL")

add_WCN_text(
"WS4\n"..
"BUS A FAIL")

add_WCN_text(
"WS5\n"..
"BUS A FAIL")

add_WCN_text(
"WS7\n"..
"BUS A FAIL")

add_WCN_text(
"WS8\n"..
"BUS A FAIL")

add_WCN_text(
"WS9\n"..
"BUS A FAIL")

add_WCN_text(
"WS3\n"..
"BUS B FAIL")

add_WCN_text(
"WS4\n"..
"BUS B FAIL")

add_WCN_text(
"WS5\n"..
"BUS B FAIL")

add_WCN_text(
"WS7\n"..
"BUS B FAIL")

add_WCN_text(
"WS8\n"..
"BUS B FAIL")

add_WCN_text(
"WS9\n"..
"BUS B FAIL")

add_WCN_text(
"EGI\n"..
"BUS A FAIL")

add_WCN_text(
"EGI\n"..
"BUS B FAIL")

add_WCN_text(
"IFFCC\n"..
"BUS A FAIL")

add_WCN_text(
"IFFCC\n"..
"BUS B FAIL")

add_WCN_text(
"TGP LASER\n"..
"NOT FIRING")

add_WCN_text(
"TGP MARKER\n"..
"NOT FIRING")

idx_end = wcn_counter

for idx = idx_begin, idx_end do
    wcn[idx] = createWCN("CAUTION", {{"wcn_active_WCPN", idx}})
    wcn[idx].value = wcn_text[idx]
end

-------------------------------------------------------------
-- Priority Notes
-- acknowledgeable - Lower center of both MFCDs in white reverse video
-------------------------------------------------------------
idx_begin = wcn_counter

add_WCN_text(
"SALVO/CLEAR A/C")

add_WCN_text(
"MSN CANCELLED")

add_WCN_text(
"NEW TASKING")

add_WCN_text(
"CANCEL ACT MSN")

add_WCN_text(
"GO TO VOICE")

add_WCN_text(
"LAR TIME OUT")

idx_end = wcn_counter
for idx = idx_begin, idx_end do
    wcn[idx] = createWCN("PRI_NOTE", {{"wcn_active_WCPN", idx}})
    wcn[idx].value = wcn_text[idx]
end

-------------------------------------------------------------
-- Notes
-- acknowledgeable - Lower right-hand corner of both MFCDs in white reverse video
--
-- All notes have 4 letters width, and are aligned to the right border horizontally,
--  and to the center vertically.
-- The text was changed to meet these requirements.
-------------------------------------------------------------
add_WCN_text(
"WILC\n"..
"CNTC\n"..
"REQD")

idx_begin = wcn_counter

add_WCN_text(
" STL\n"..
"DATA")

add_WCN_text(
" NEW\n"..
"EMER\n"..
"  PT")

add_WCN_text(
" FLT\n"..
"WILC")

add_WCN_text(
" FLT\n"..
"CNTC")

add_WCN_text(
" FLT\n"..
"CNTP")

add_WCN_text(
" FLT\n"..
" MBR\n"..
"DSNG")

add_WCN_text(
" FLT\n"..
" MBR\n"..
" BDA")

add_WCN_text(
" FLT\n"..
" MBR\n"..
"ASGN")

add_WCN_text(
" TGT\n"..
"IDNT\n"..
"CHNG")

add_WCN_text(
"SALV\n"..
" CLR\n"..
"  AC")

add_WCN_text(
"  GO\n"..
"  TO\n"..
"  VO")

add_WCN_text(
"DSNG\n"..
"RSPS\n"..
"RCVD")

add_WCN_text(
" BDA\n"..
"RSPS\n"..
"RCVD")

add_WCN_text(
"  MA\n"..
"WILC\n"..
"RCVD")

add_WCN_text(
"  MA\n"..
"CNTC\n"..
"RCVD")

add_WCN_text(
"  MA\n"..
"CNTP\n"..
"RCVD")

add_WCN_text(
"CANC\n"..
"WILC\n"..
"RCVD")

add_WCN_text(
"CANC\n"..
"CNTC\n"..
"RCVD")

add_WCN_text(
"CANC\n"..
"CNTP\n"..
"RCVD")

add_WCN_text(
"TEXT\n"..
"FULL")

add_WCN_text(
" CAS\n"..
"FULL")

add_WCN_text(
"  MA\n"..
"FULL")

add_WCN_text(
"TEXT\n"..
" 90%\n"..
"FULL")

add_WCN_text(
" CAS\n"..
" 90%\n"..
"FULL")

add_WCN_text(
"  MA\n"..
" 90%\n"..
"FULL")

add_WCN_text(
"IDNT\n"..
" DIF")

add_WCN_text(
"  MA\n"..
"  NO\n"..
" OPR")

add_WCN_text(
"CANC\n"..
"  NO\n"..
" OPR")

add_WCN_text(
"ADDL\n"..
" MSN\n"..
"DATA")

add_WCN_text(
"MULT\n"..
" FLT\n"..
"LEAD")

add_WCN_text(
" NEW\n"..
"MSG") -- note that it is overrided by controller

add_WCN_text(
"CHNG\n"..
" LSR\n"..
"  SW")

add_WCN_text(
" TGP\n"..
"MARK\n"..
"DEGR")

add_WCN_text(
" TGP\n"..
" LSD\n"..
"DEGR")

add_WCN_text(
" TGP\n"..
" VID\n"..
"DEGR")

add_WCN_text(
" TGP\n"..
" CID\n"..
"DEGR")

add_WCN_text(
"LMFD\n"..
"DEGR")

add_WCN_text(
"RMFD\n"..
"DEGR")

add_WCN_text(
"EPLR\n"..
"BATT\n"..
" LOW")

add_WCN_text(
"EPLR\n"..
" KEY\n"..
"FAIL")

add_WCN_text(
"  UP\n"..
"LOAD\n"..
" TDL\n"..
"FAIL")

add_WCN_text(
"PEND\n"..
" CAS\n"..
"FULL")

add_WCN_text(
"PEND\n"..
"TEXT\n"..
"FULL")

add_WCN_text(
" NVM\n"..
"FAIL")

add_WCN_text(
"  NO\n"..
" SPI")

add_WCN_text(
" TGP\n"..
"TRCK\n"..
" ERR")

add_WCN_text(
" TGP\n"..
"TRCK\n"..
" POL\n"..
" ERR")

add_WCN_text(
" TGP\n"..
"GAIN\n"..
" ERR")

add_WCN_text(
" TGP\n"..
"FLIR\n"..
" POL\n"..
" ERR")

add_WCN_text(
" TGP\n"..
"SNSR\n"..
" ERR")

add_WCN_text(
" TGP\n"..
" FOV\n"..
" ERR")

add_WCN_text(
"FLIR\n"..
" CAL\n"..
"  NO\n"..
"STRT")

add_WCN_text(
"SRVC\n"..
"MODE\n"..
"  NO\n"..
"STRT")

add_WCN_text(
" TGP\n"..
" INT\n"..
"TIME\n"..
" OUT")

add_WCN_text(
" TGP\n"..
" CAL\n"..
"TIME\n"..
" OUT")

add_WCN_text(
" TGP\n"..
"BRST\n"..
"TIME\n"..
" OUT")

add_WCN_text(
"COPY\n"..
"FAIL")

add_WCN_text(
"CHCK\n"..
"  EO\n"..
"TIME")

add_WCN_text(
"CHCK\n"..
"  EO\n"..
"WYPT")

add_WCN_text(
"CHCK\n"..
" TGP\n"..
"MODE")

add_WCN_text(
"CHCK\n"..
" LSR\n"..
"TYPE")

add_WCN_text(
"AIM9\n"..
"MODE")

add_WCN_text(
"DSMS\n"..
"STAT")

add_WCN_text(
"DSMS\n"..
"INVT\n"..
"    \n"..
"CMBT")

add_WCN_text(
"DSMS\n"..
"INVT\n"..
"    \n"..
" TRN")

add_WCN_text(
"DSMS\n"..
"PROF\n"..
"    \n"..
"CMBT")

add_WCN_text(
"DSMS\n"..
"PROF\n"..
"    \n"..
" TRN")

add_WCN_text(
"CHCK\n"..
" TDL\n"..
"CNFG")

add_WCN_text(
"IAM3\n"..
" KEY\n"..
" CHK")

add_WCN_text(
"IAM4\n"..
" KEY\n"..
" CHK")

add_WCN_text(
"IAM5\n"..
" KEY\n"..
" CHK")

add_WCN_text(
"IAM7\n"..
" KEY\n"..
" CHK")

add_WCN_text(
"IAM8\n"..
" KEY\n"..
" CHK")

add_WCN_text(
"IAM9\n"..
" KEY\n"..
" CHK")

add_WCN_text(
"  UP\n"..
"LOAD\n"..
"PAGE\n"..
"FAIL")

add_WCN_text(
"  UP\n"..
"LOAD\n"..
" TAD\n"..
"FAIL")

add_WCN_text(
"  UP\n"..
"LOAD\n"..
"DSMS\n"..
"FAIL")

add_WCN_text(
"  UP\n"..
"LOAD\n"..
" TGP\n"..
"FAIL")

add_WCN_text(
"  UP\n"..
"LOAD\n"..
" GPS\n"..
"FAIL")

add_WCN_text(
"  UP\n"..
"LOAD\n"..
"  DP\n"..
"FAIL")

add_WCN_text(
"  UP\n"..
"LOAD\n"..
" TDL\n"..
"FAIL")

add_WCN_text(
"  UP\n"..
"LOAD\n"..
" IFF\n"..
"FAIL")

add_WCN_text(
"IAM3\n"..
" KEY\n"..
"LOAD\n"..
"FAIL")

add_WCN_text(
"IAM4\n"..
" KEY\n"..
"LOAD\n"..
"FAIL")

add_WCN_text(
"IAM5\n"..
" KEY\n"..
"LOAD\n"..
"FAIL")

add_WCN_text(
"IAM7\n"..
" KEY\n"..
"LOAD\n"..
"FAIL")

add_WCN_text(
"IAM8\n"..
" KEY\n"..
"LOAD\n"..
"FAIL")

add_WCN_text(
"IAM9\n"..
" KEY\n"..
"LOAD\n"..
"FAIL")

add_WCN_text(
"IAM3\n"..
"ERSE\n"..
"FAIL")

add_WCN_text(
"IAM4\n"..
"ERSE\n"..
"FAIL")

add_WCN_text(
"IAM5\n"..
"ERSE\n"..
"FAIL")

add_WCN_text(
"IAM7\n"..
"ERSE\n"..
"FAIL")

add_WCN_text(
"IAM8\n"..
"ERSE\n"..
"FAIL")

add_WCN_text(
"IAM9\n"..
"ERSE\n"..
"FAIL")

add_WCN_text(
" TDL\n"..
" CON\n"..
" FIG\n"..
"FAIL")

add_WCN_text(
"DSMS\n"..
"PROF\n"..
" ERR")

add_WCN_text(
"DSMS\n"..
"PROF\n"..
"FULL")

add_WCN_text(
"DSMS\n"..
" DUP\n"..
"PROF\n"..
"NAME")

add_WCN_text(
"DSMS\n"..
"DFLT\n"..
"PROF\n"..
"INVL")

add_WCN_text(
" TAD\n"..
" DUP\n"..
"PROF")

add_WCN_text(
" TAD\n"..
"PROF\n"..
"FULL")

add_WCN_text(
" TGP\n"..
"  XR\n"..
" ERR")

add_WCN_text(
" TGP\n"..
" SLV\n"..
"STPT\n"..
" INV")

add_WCN_text(
" TGP\n"..
"  IO\n"..
"FAIL")

add_WCN_text(
"CHCK\n"..
" MFL")

add_WCN_text(
" TGP\n"..
" LMZ\n"..
" ERR")

add_WCN_text(
" TGP\n"..
" YRD\n"..
" STK\n"..
" ERR")

add_WCN_text(
" WS3\n"..
"  IO\n"..
"FAIL")

add_WCN_text(
" WS4\n"..
"  IO\n"..
"FAIL")

add_WCN_text(
" WS5\n"..
"  IO\n"..
"FAIL")

add_WCN_text(
" WS7\n"..
"  IO\n"..
"FAIL")

add_WCN_text(
" WS8\n"..
"  IO\n"..
"FAIL")

add_WCN_text(
" WS9\n"..
"  IO\n"..
"FAIL")

add_WCN_text(
" LAR\n"..
"EXCP")

add_WCN_text(
" TGP\n"..
"MENU\n"..
" FLT")

add_WCN_text(
" JPF\n"..
"INVT\n"..
" ERR")

add_WCN_text(
" TGP\n"..
"MENU\n"..
"TIME\n"..
" OUT")

add_WCN_text(
" TGP\n"..
"MENU\n"..
"ENTR\n"..
" ERR")

add_WCN_text(
" TGP\n"..
"MENU\n"..
"EXIT\n"..
" ERR")


idx_end = wcn_counter
for idx = idx_begin, idx_end do
    wcn[idx] = createWCN("NOTE", {{"wcn_active_note", idx}})
    wcn[idx].value = wcn_text[idx]
end

--[[
wcn[idx_msg_x].formats =
{
" MSG",
" MSG\n"..
"%2d ",
}
wcn[idx_msg_x].controllers = 
	{{"wcn_active_note", idx_msg_x}, {"WCN_MessagesCount"}}
--]]
