dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")

LRU_ALL			= 1
LRU_CICU		= 2
LRU_CICU_WP		= 3
LRU_CICU_MP		= 4
LRU_CICU_DLP	= 5
LRU_CICU_GVM	= 6
LRU_CICU_ALM	= 7
LRU_1760_3		= 8
LRU_1760_4		= 9
LRU_1760_5		= 10
LRU_1760_7		= 11
LRU_1760_8		= 12
LRU_1760_9		= 13

LRU_TGP			= 14
LRU_LTMFCD		= 15
LRU_RTMFCD		= 16
LRU_HOTAS		= 17
LRU_HOTAS_STICK	= 18
LRU_HOTAS_THRTL	= 19
LRU_HOTAS_AHCP	= 20
LRU_EGI			= 21
LRU_IFFCC		= 22
LRU_CDU			= 23
LRU_EPLRS		= 24
-- A-10C II specific
LRU_HMCS		= 25

STATUS_NA		= x01
STATUS_VALID	= x02
STATUS_OFF		= x04
STATUS_INIT		= x08
STATUS_FAIL		= x10
STATUS_TEST		= x20
STATUS_NC		= x40
STATUS_DEGR		= x80

TEST_NA			= x01
TEST_UN			= x02
TEST_IP			= x04
TEST_PASS		= x08
TEST_FAIL		= x10

LRU_TYPE_JDAM	= x01
LRU_TYPE_WCMD	= x02

-- CICU test steps
MFCD_CICU_NO_TEST  	= 0
MFCD_CICU_START	   	= 1
MFCD_CICU_TESTING  	= 2
MFCD_CICU_WHITE_SCR = 3
MFCD_CICU_BLACK_SCR = 4
MFCD_CICU_GREY_SCR 	= 5
MFCD_CICU_TEST_END 	= 6
MFCD_CICU_TEST_POST_END = 7
MFCD_CICU_BLUE_SCR 	= 8

LRU_names = {}
LRU_names[LRU_ALL]			= "ALL     "
LRU_names[LRU_CICU]			= "CICU    "
LRU_names[LRU_CICU_WP]		= " WP     "
LRU_names[LRU_CICU_MP]		= " MP     "
LRU_names[LRU_CICU_DLP]		= " DLP    "
LRU_names[LRU_CICU_GVM]		= " GVM    "
LRU_names[LRU_CICU_ALM]		= " ALM    "
LRU_names[LRU_1760_3]		= "1760-3  "
LRU_names[LRU_1760_4]		= "1760-4  "
LRU_names[LRU_1760_5]		= "1760-5  "
LRU_names[LRU_1760_7]		= "1760-7  "
LRU_names[LRU_1760_8]		= "1760-8  "
LRU_names[LRU_1760_9]		= "1760-9  "
LRU_names[LRU_TGP]			= "TGP     "
LRU_names[LRU_LTMFCD]		= "LTMFCD  "
LRU_names[LRU_RTMFCD]		= "RTMFCD  "
LRU_names[LRU_HOTAS]		= "HOTAS   "
LRU_names[LRU_HOTAS_STICK]	= " STICK  "
LRU_names[LRU_HOTAS_THRTL]	= " THRTL  "
LRU_names[LRU_HOTAS_AHCP]	= " AHCP   "
LRU_names[LRU_EGI]			= "EGI     "
LRU_names[LRU_IFFCC]		= "IFFCC   "
LRU_names[LRU_CDU]			= "CDU     "
LRU_names[LRU_EPLRS]		= "EPLRS   "
-- A-10C II specific
LRU_names[LRU_HMCS]			= "HMCS    "

LRU_names2 = {}
LRU_names2[LRU_ALL]			= "ALL"
LRU_names2[LRU_CICU]		= "CICU"
LRU_names2[LRU_CICU_WP]		= "WP"
LRU_names2[LRU_CICU_MP]		= "MP"
LRU_names2[LRU_CICU_DLP]	= "DLP"
LRU_names2[LRU_CICU_GVM]	= "GVM"
LRU_names2[LRU_CICU_ALM]	= "ALM"
LRU_names2[LRU_1760_3]		= "1760-3"
LRU_names2[LRU_1760_4]		= "1760-4"
LRU_names2[LRU_1760_5]		= "1760-5"
LRU_names2[LRU_1760_7]		= "1760-7"
LRU_names2[LRU_1760_8]		= "1760-8"
LRU_names2[LRU_1760_9]		= "1760-9"
LRU_names2[LRU_TGP]			= "TGP"
LRU_names2[LRU_LTMFCD]		= "LTMFCD"
LRU_names2[LRU_RTMFCD]		= "RTMFCD"
LRU_names2[LRU_HOTAS]		= "HOTAS"
LRU_names2[LRU_HOTAS_STICK]	= "STICK"
LRU_names2[LRU_HOTAS_THRTL]	= "THRTL"
LRU_names2[LRU_HOTAS_AHCP]	= "AHCP"
LRU_names2[LRU_EGI]			= "EGI"
LRU_names2[LRU_IFFCC]		= "IFFCC"
LRU_names2[LRU_CDU]			= "CDU"
LRU_names2[LRU_EPLRS]		= "EPLRS"
-- A-10C II specific
LRU_names2[LRU_HMCS]		= "HMCS"

LRU_status = {}
LRU_status[LRU_ALL]			= "-"
LRU_status[LRU_CICU]		= "VALID"
LRU_status[LRU_CICU_WP]		= "VALID"
LRU_status[LRU_CICU_MP]		= "VALID"
LRU_status[LRU_CICU_DLP]	= "VALID"
LRU_status[LRU_CICU_GVM]	= "VALID"
LRU_status[LRU_CICU_ALM]	= "VALID"
--LRU_status[LRU_LTMFCD]		= "VALID"
--LRU_status[LRU_RTMFCD]		= "VALID"
LRU_status[LRU_HOTAS]		= "VALID"
LRU_status[LRU_HOTAS_STICK]	= "VALID"
LRU_status[LRU_HOTAS_THRTL]	= "VALID"
LRU_status[LRU_HOTAS_AHCP]	= "VALID"

LRU_test = {}
LRU_test[LRU_ALL]			= "-"
LRU_test[LRU_CICU]			= "UN"
LRU_test[LRU_CICU_WP]		= "-"
LRU_test[LRU_CICU_MP]		= "-"
LRU_test[LRU_CICU_DLP]		= "-"
LRU_test[LRU_CICU_GVM]		= "-"
LRU_test[LRU_CICU_ALM]		= "-"
LRU_test[LRU_TGP]			= "UN"
--LRU_test[LRU_LTMFCD]		= "UN"
--LRU_test[LRU_RTMFCD]		= "UN"
--LRU_test[LRU_HOTAS]		= "UN"
LRU_test[LRU_HOTAS_STICK]	= "-"
LRU_test[LRU_HOTAS_THRTL]	= "-"
LRU_test[LRU_HOTAS_AHCP]	= "-"
LRU_test[LRU_EGI]			= "-"
LRU_test[LRU_IFFCC]			= "-"
LRU_test[LRU_CDU]			= "-"
LRU_test[LRU_EPLRS]			= "-"
LRU_test[LRU_HMCS]			= "-"

LRU_details = {}
LRU_details[LRU_CICU]			= "CICU OFP ID:  V 1 7 10\nCICU CHK SUM: 859068F0"
LRU_details[LRU_CICU_ALM]		= "ALM VERSION:  V 0502"

LRU_stations = {}
LRU_stations[LRU_1760_3]	= 3
LRU_stations[LRU_1760_4]	= 4
LRU_stations[LRU_1760_5]	= 5
LRU_stations[LRU_1760_7]	= 7
LRU_stations[LRU_1760_8]	= 8
LRU_stations[LRU_1760_9]	= 9

TblCenterX		= max_pixels_count/2 + 6

TblHalfWidth	= 150
TblHalfWidthVertLines = 49
TblRowHeight	= 20
Tbl1stLinePosY	= max_pixels_count - 100

TblHdrTxtY			= Tbl1stLinePosY + TblRowHeight / 2
TblHdrTxtOffsetX	= TblHalfWidthVertLines + (TblHalfWidth - TblHalfWidthVertLines) / 2

MFL_StringOffset = 23.4

function AddFaultLogPlacer()
	FaultLogPlacer			= CreateElement "ceSimple"
	FaultLogPlacer.name     = "FaultLogPlacer"
	FaultLogPlacer.init_pos	= {TblCenterX - TblHalfWidth + 5, 146, 0}
	SetLowerLeftCornerOrigin(FaultLogPlacer)
	Add(FaultLogPlacer)
end

AddFaultLogPlacer()

function SetFaultLogPlacerAsParent(object)
	object.parent_element =  "FaultLogPlacer"
end

function AddTblText(Name, Value, Raw, Column, Controllers)
	local Elem			= CreateElement "ceStringPoly"
	Elem.name			= Name
	Elem.alignment		= "CenterCenter"
	Elem.value			= Value
	Elem.material		= font_MFCD_BLACK
	Elem.stringdefs		= predefined_fonts[1]
	
	if Column == 1 then
		PosX = TblCenterX - TblHdrTxtOffsetX
	elseif Column == 2 then
		PosX = TblCenterX
	else
		PosX = TblCenterX + TblHdrTxtOffsetX
	end
		
	Elem.init_pos		= {PosX, TblHdrTxtY - Raw * TblRowHeight, 0}
	if Controllers ~= nil then
		Elem.controllers = Controllers
	end
	Add(Elem)
	SetLowerLeftCornerOrigin(Elem)
	use_mipfilter(Elem)
		
	return Elem
end

function addSTAT_Table(Rows)
	ColumnsTable = {}
	ColumnsTable[1] = TblHalfWidth - TblHalfWidthVertLines
	ColumnsTable[2] = TblHalfWidth + TblHalfWidthVertLines
	
	AddTable(Rows, ColumnsTable, TblRowHeight, TblHalfWidth * 2,
		TblCenterX - TblHalfWidth, Tbl1stLinePosY, MFCD_BLUE)
end
