dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")
dofile(LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_DSMS_useful_definitions.lua")

local dx = 5  --

boxes_background = {}

for i = 1, 5 do
	boxes_background[i]				= CreateElement "ceMeshPoly"
	boxes_background[i].name		= "BOXES_BACKGROUND_OSB6"..i
	boxes_background[i].material	= MFCD_SOLID_BLUE
	boxes_background[i].primitivetype	= "triangles"
	boxes_background[i].vertices	= {{(25+110) , 27.5},
										{25		 , 27.5},
										{25		 ,-27.5},
										{(25+110),-27.5},
										{(25+110), 27.5}}
	boxes_background[i].indices		= box_ind
	boxes_background[i].controllers	= {{"DSMS_store_background_visible_active", StoreIndexes[i]}, {"DSMS_store_background_color", StoreIndexes[i]}}
	shift_button_pos_2(boxes_background[i],i+15,dx)
	Add(boxes_background[i])
	use_mipfilter(boxes_background[i])
end

for i = 7, 11 do
	boxes_background[i]				= CreateElement "ceMeshPoly"
	boxes_background[i].name		= "BOXES_BACKGROUND_OSB6"..i
	boxes_background[i].material	= MFCD_SOLID_BLUE
	boxes_background[i].primitivetype	= "triangles"
	boxes_background[i].vertices	= {{(-25-110), 27.5},
									   { -25	 , 27.5},
									   { -25	 ,-27.5},
									   {(-25-110),-27.5},
									   {(-25-110), 27.5}}
	boxes_background[i].indices		= box_ind
	shift_button_pos_2(boxes_background[i],i-1,-dx)
	boxes_background[i].controllers	= {{"DSMS_store_background_visible_active", StoreIndexes[i]}, {"DSMS_store_background_color", StoreIndexes[i]}}
	Add(boxes_background[i])
	use_mipfilter(boxes_background[i])
end

boxes_background[6]				= CreateElement "ceMeshPoly"
boxes_background[6].name		= "BOXES_BACKGROUND_OSB6"..6
boxes_background[6].material	= MFCD_SOLID_BLUE
boxes_background[6].primitivetype	= "triangles"
boxes_background[6].vertices	= {{(0+55) ,-54+27.5},
									{0-55  ,-54+27.5},
									{0-55  ,-54-27.5},
									{(0+55),-54-27.5},
									{(0+55),-54+27.5}}
boxes_background[6].indices		= box_ind
shift_button_pos_2(boxes_background[6],3)
boxes_background[6].controllers	= {{"DSMS_store_background_visible_active", StoreIndexes[6]}, {"DSMS_store_background_color", StoreIndexes[6]}}
Add(boxes_background[6])
use_mipfilter(boxes_background[6])

labels = {}
for i = 5, 9 do
	labels[i]						= CreateElement "ceStringPoly"
	labels[i].name					= "OSB_" .. string.format("%d",i)
	labels[i].material				= font_MFCD
	labels[i].UseBackground			= false
	labels[i].alignment				= "LeftCenter"
	labels[i].formats				= {string.format("%d",i+2), "P", "I", "H"}
	labels[i].stringdefs			= predefined_fonts[3]
	labels[i].controllers			= {{"DSMS_store_number_color", StoreIndexes[i+2]}}
	shift_button_pos_2(labels[i],i  + 1,-23 - dx)
	Add(labels[i])
	use_mipfilter(labels[i])
	addOSB_Box(i+1, {labels[i]})
end

for i = 15, 19 do
	labels[i]						= CreateElement "ceStringPoly"
	labels[i].name					= "OSB_" .. string.format("%d",i)
	labels[i].material				= font_MFCD
	labels[i].UseBackground			= false
	labels[i].alignment				= "LeftCenter"
	labels[i].formats				= {string.format("%d",i-14), "P", "I", "H"}
	labels[i].stringdefs			= predefined_fonts[3]
	labels[i].controllers			= {{"DSMS_store_number_color", StoreIndexes[i-14]}}
	shift_button_pos_2(labels[i],i  + 1,dx)
	Add(labels[i])
	use_mipfilter(labels[i])
	addOSB_Box(i+1, {labels[i]})
end

labels[2]						= CreateElement "ceStringPoly"
labels[2].name					= "OSB_" .. string.format("%d",2)
labels[2].material				= font_MFCD
labels[2].UseBackground			= false
labels[2].alignment				= "CenterTop"
labels[2].formats				= {string.format("%d",2+4), "P", "I", "H"}
labels[2].stringdefs			= predefined_fonts[3]
labels[2].controllers			= {{"DSMS_store_number_color", StoreIndexes[2+4]}}
shift_button_pos(labels[2],2  + 1,0,5)
SetLowerLeftCornerOrigin(labels[2])
Add(labels[2])
use_mipfilter(labels[2])
addOSB_Box(2+1, {labels[i]})

boxes = {}
for i = 7, 11 do
	boxes[i]				=  line_2_pixel({{(-25-110),27.5},{-25,27.5},{-25,-27.5},{(-25-110),-27.5},{(-25-110),27.5}}, MFCD_GREEN)
	SetLowerLeftCornerOrigin(boxes[i])
	boxes[i].init_pos		=  boxes_background[i].init_pos
	boxes[i].controllers	= {{"DSMS_not_inventory"}, {"DSMS_store_color", StoreIndexes[i]}}
end

for i = 1, 5 do
	boxes[i]				=  line_2_pixel({{(25+110),27.5},{25,27.5},{25,-27.5},{(25+110),-27.5},{(25+110),27.5}}, MFCD_GREEN)
	SetLowerLeftCornerOrigin(boxes[i])
	boxes[i].init_pos		=  boxes_background[i].init_pos
	boxes[i].controllers	= {{"DSMS_not_inventory"}, {"DSMS_store_color", StoreIndexes[i]}}
end

boxes[6]				=  line_2_pixel({{(0+55),-54+27.5},{0-55,-54+27.5},{0-55,-54-27.5},{(0+55),-54-27.5},{(0+55),-54+27.5}}, MFCD_GREEN)
SetLowerLeftCornerOrigin(boxes[6])
boxes[6].init_pos		=  boxes_background[6].init_pos
boxes[6].controllers	= {{"DSMS_not_inventory"}, {"DSMS_store_color", StoreIndexes[6]}}

StoreCount = {}
for i = 7, 11 do
	StoreCount[i]						= CreateElement "ceStringPoly"
	StoreCount[i].name					= "STORE_COUNT_" ..i
	StoreCount[i].material				= font_MFCD
	StoreCount[i].UseBackground			= true
	StoreCount[i].BackgroundMaterial	= MFCD_SOLID_BLACK
	StoreCount[i].alignment				= "RightCenter"
	StoreCount[i].controllers			= {{"DSMS_store_count", 0, StoreIndexes[i]}, {"DSMS_store_color", StoreIndexes[i]}}
	StoreCount[i].formats				= {"%d"}
	StoreCount[i].stringdefs			= predefined_fonts[2]
	shift_obj_pos(StoreCount[i], boxes[i], -25-110-1, 0)
	SetLowerLeftCornerOrigin(StoreCount[i])
	Add(StoreCount[i])
	use_mipfilter(StoreCount[i])
end

StoreCount[6]						= CreateElement "ceStringPoly"
StoreCount[6].name					= "STORE_COUNT_" .. 6
StoreCount[6].material				= font_MFCD
StoreCount[6].UseBackground			= true
StoreCount[6].BackgroundMaterial	= MFCD_SOLID_BLACK
StoreCount[6].alignment				= "RightCenter"
StoreCount[6].controllers			= {{"DSMS_store_count", 0, StoreIndexes[6]}, {"DSMS_store_color", StoreIndexes[6]}}
StoreCount[6].formats				= {"%d"}
StoreCount[6].stringdefs			= predefined_fonts[2]
shift_obj_pos(StoreCount[6], boxes[6], -55-1, -54)
SetLowerLeftCornerOrigin(StoreCount[6])
Add(StoreCount[6])
use_mipfilter(StoreCount[6])

for i = 1, 5 do
	StoreCount[i]						= CreateElement "ceStringPoly"
	StoreCount[i].name					= "STORE_COUNT_" .. i
	StoreCount[i].material				= font_MFCD
	StoreCount[i].UseBackground			= true
	StoreCount[i].BackgroundMaterial	= MFCD_SOLID_BLACK
	StoreCount[i].alignment				= "LeftCenter"
	StoreCount[i].controllers			= {{"DSMS_store_count", 0, StoreIndexes[i]}, {"DSMS_store_color", StoreIndexes[i]}}
	StoreCount[i].stringdefs			= predefined_fonts[2]
	StoreCount[i].formats				= {"%d"}
	shift_obj_pos(StoreCount[i], boxes[i], 25+110+1, 0)
	SetLowerLeftCornerOrigin(StoreCount[i])
	Add(StoreCount[i])
	use_mipfilter(StoreCount[i])
end

count_boxes = {}
local BoxSide = 20
local tex_param_default		= 2 * texture_scale
for i = 1, 11 do
	count_boxes[i]					= CreateElement "ceBoundingTexBox"
	count_boxes[i].name				= "count_boxes"..i
	count_boxes[i].width			= 2
	count_boxes[i].material			= MFCD_GREEN
	count_boxes[i].init_pos			= StoreCount[i].init_pos
	count_boxes[i].tex_params		= {{0.1,503.5/512},{0.9,503.5/512}, {texture_scale, tex_param_default * 1.5*0.7}}
	count_boxes[i].controllers		= {{"DSMS_count_boxes", StoreIndexes[i]}, {"DSMS_store_color", StoreIndexes[i]}}
	count_boxes[i].geometry_hosts	= {StoreCount[i].name}
	count_boxes[i].vertices			= {{-BoxSide,-BoxSide},
										{ BoxSide,-BoxSide},
										{ BoxSide, BoxSide},
										{-BoxSide, BoxSide}}
	SetLowerLeftCornerOrigin(count_boxes[i])
	Add(count_boxes[i])
	use_mipfilter(count_boxes[i])
end

StoreName = {}
for i = 7, 11 do
	StoreName[i]						= CreateElement "ceStringPoly"
	StoreName[i].name					= "STORE_NAME_" .. i
	StoreName[i].material				= font_MFCD
	StoreName[i].UseBackground			= false
	StoreName[i].alignment				= "LeftBottom"
	StoreName[i].controllers			= {{"DSMS_store_name", StoreIndexes[i]}, {"DSMS_store_color", StoreIndexes[i]}}
	StoreName[i].stringdefs			= predefined_fonts[1]
	shift_obj_pos(StoreName[i], boxes[i], -25-110+4, 0)
	SetLowerLeftCornerOrigin(StoreName[i])
	Add(StoreName[i])
	use_mipfilter(StoreName[i])
end

for i = 1, 5 do
	StoreName[i]						= CreateElement "ceStringPoly"
	StoreName[i].name					= "STORE_NAME_" .. i
	StoreName[i].material				= font_MFCD
	StoreName[i].UseBackground			= false
	StoreName[i].alignment				= "LeftBottom"
	StoreName[i].controllers			= {{"DSMS_store_name", StoreIndexes[i]}, {"DSMS_store_color", StoreIndexes[i]}}
	StoreName[i].stringdefs			= predefined_fonts[1]
	shift_obj_pos(StoreName[i], boxes[i], 25+4, 0)
	SetLowerLeftCornerOrigin(StoreName[i])
	Add(StoreName[i])
	use_mipfilter(StoreName[i])
end

StoreName[6]						= CreateElement "ceStringPoly"
StoreName[6].name					= "STORE_NAME_" .. 6
StoreName[6].material				= font_MFCD
StoreName[6].UseBackground			= false
StoreName[6].alignment				= "LeftBottom"
StoreName[6].controllers			= {{"DSMS_store_name", StoreIndexes[6]}, {"DSMS_store_color", StoreIndexes[6]}}
StoreName[6].stringdefs			= predefined_fonts[1]
shift_obj_pos(StoreName[6], boxes[6], -55+4, -54)
SetLowerLeftCornerOrigin(StoreName[6])
Add(StoreName[6])
use_mipfilter(StoreName[6])

MavLauncher88 = {}
MavLauncher88[3]						= CreateElement "ceStringPoly"
MavLauncher88[3].name					= "MavLauncher88" .. 3
MavLauncher88[3].material				= font_MFCD
MavLauncher88[3].UseBackground			= false
MavLauncher88[3].alignment				= "LeftTop"
MavLauncher88[3].controllers			= {{"DSMS_mav_launcher88", StoreIndexes[3]}, {"DSMS_store_color", StoreIndexes[3]}}
MavLauncher88[3].stringdefs				= predefined_fonts[1]
MavLauncher88[3].value					= "88"
shift_obj_pos(MavLauncher88[3], boxes[3], 25+4, 0)
SetLowerLeftCornerOrigin(MavLauncher88[3])
Add(MavLauncher88[3])
use_mipfilter(MavLauncher88[3])

MavLauncher88[9]						= CreateElement "ceStringPoly"
MavLauncher88[9].name					= "MavLauncher88" .. 9
MavLauncher88[9].material				= font_MFCD
MavLauncher88[9].UseBackground			= false
MavLauncher88[9].alignment				= "LeftTop"
MavLauncher88[9].controllers			= {{"DSMS_mav_launcher88", StoreIndexes[9]}, {"DSMS_store_color", StoreIndexes[9]}}
MavLauncher88[9].stringdefs				= predefined_fonts[1]
MavLauncher88[9].value					= "88"
shift_obj_pos(MavLauncher88[9], boxes[9], -25-110+4, 0)
SetLowerLeftCornerOrigin(MavLauncher88[9])
Add(MavLauncher88[9])
use_mipfilter(MavLauncher88[9])

MavLauncher117 = {}
MavLauncher117[3]						= CreateElement "ceStringPoly"
MavLauncher117[3].name					= "MavLauncher117" .. 3
MavLauncher117[3].material				= font_MFCD
MavLauncher117[3].UseBackground			= false
MavLauncher117[3].alignment				= "LeftTop"
MavLauncher117[3].controllers			= {{"DSMS_mav_launcher117", StoreIndexes[3]}, {"DSMS_store_color", StoreIndexes[3]}}
MavLauncher117[3].stringdefs			= predefined_fonts[1]
MavLauncher117[3].value					= "117"
shift_obj_pos(MavLauncher117[3], boxes[3], 25+4, 0)
SetLowerLeftCornerOrigin(MavLauncher117[3])
Add(MavLauncher117[3])
use_mipfilter(MavLauncher117[3])

MavLauncher117[9]						= CreateElement "ceStringPoly"
MavLauncher117[9].name					= "MavLauncher117" .. 9
MavLauncher117[9].material				= font_MFCD
MavLauncher117[9].UseBackground			= false
MavLauncher117[9].alignment				= "LeftTop"
MavLauncher117[9].controllers			= {{"DSMS_mav_launcher117", StoreIndexes[9]}, {"DSMS_store_color", StoreIndexes[9]}}
MavLauncher117[9].stringdefs			= predefined_fonts[1]
MavLauncher117[9].value					= "117"
shift_obj_pos(MavLauncher117[9], boxes[9], -25-110+4, 0)
SetLowerLeftCornerOrigin(MavLauncher117[9])
Add(MavLauncher117[9])
use_mipfilter(MavLauncher117[9])

MavStat = {}
MavStat[3]							= CreateElement "ceStringPoly"
MavStat[3].name						= "MavStat" .. 3
MavStat[3].material					= font_MFCD
MavStat[3].UseBackground			= false
MavStat[3].alignment				= "RightTop"
MavStat[3].controllers				= {{"DSMS_maverick_status", StoreIndexes[3]}, {"DSMS_store_color", StoreIndexes[3]}}
MavStat[3].stringdefs				= predefined_fonts[1]
MavStat[3].formats					= {"", "OFF", "OFF", "ALN", "RDY", "RDY", "RDY", "FLAPS", "RDY", "RDY", "STBY"}
shift_obj_pos(MavStat[3], boxes[3], 25+110, 0)
SetLowerLeftCornerOrigin(MavStat[3])
Add(MavStat[3])
use_mipfilter(MavStat[3])

MavStat[9]							= CreateElement "ceStringPoly"
MavStat[9].name						= "MavStat" .. 9
MavStat[9].material					= font_MFCD
MavStat[9].UseBackground			= false
MavStat[9].alignment				= "RightTop"
MavStat[9].controllers				= {{"DSMS_maverick_status", StoreIndexes[9]}, {"DSMS_store_color", StoreIndexes[9]}}
MavStat[9].stringdefs				= predefined_fonts[1]
MavStat[9].formats					= {"", "OFF", "OFF", "ALN", "RDY", "RDY", "RDY", "FLAPS", "RDY", "RDY", "STBY"}
shift_obj_pos(MavStat[9], boxes[9], -25, 0)
SetLowerLeftCornerOrigin(MavStat[9])
Add(MavStat[9])
use_mipfilter(MavStat[9])

DraLauncher = {}
DraLauncher[1]						= CreateElement "ceStringPoly"
DraLauncher[1].name					= "DraLauncher" .. 1
DraLauncher[1].material				= font_MFCD
DraLauncher[1].UseBackground		= false
DraLauncher[1].alignment			= "LeftTop"
DraLauncher[1].controllers			= {{"DSMS_dra_launcher", StoreIndexes[1]}, {"DSMS_store_color", StoreIndexes[1]}}
DraLauncher[1].stringdefs			= predefined_fonts[1]
DraLauncher[1].value				= "DRA"
shift_obj_pos(DraLauncher[1], boxes[1], 25+4, 0)
SetLowerLeftCornerOrigin(DraLauncher[1])
Add(DraLauncher[1])
use_mipfilter(DraLauncher[1])

DraLauncher[11]						= CreateElement "ceStringPoly"
DraLauncher[11].name				= "DraLauncher" .. 11
DraLauncher[11].material			= font_MFCD
DraLauncher[11].UseBackground		= false
DraLauncher[11].alignment			= "LeftTop"
DraLauncher[11].controllers			= {{"DSMS_dra_launcher", StoreIndexes[11]}, {"DSMS_store_color", StoreIndexes[11]}}
DraLauncher[11].stringdefs			= predefined_fonts[1]
DraLauncher[11].value				= "DRA"
shift_obj_pos(DraLauncher[11], boxes[11], -25-110+4, 0)
SetLowerLeftCornerOrigin(DraLauncher[11])
Add(DraLauncher[11])
use_mipfilter(DraLauncher[11])

AIM9Stat = {}
AIM9Stat[1]							= CreateElement "ceStringPoly"
AIM9Stat[1].name					= "AIM9Stat" .. 1
AIM9Stat[1].material				= font_MFCD
AIM9Stat[1].UseBackground			= false
AIM9Stat[1].alignment				= "RightTop"
AIM9Stat[1].controllers				= {{"DSMS_sidewinder_present", StoreIndexes[1]}, {"DSMS_sidewinder_status_station", StoreIndexes[1]}, {"DSMS_store_color", StoreIndexes[1]}}
AIM9Stat[1].stringdefs				= predefined_fonts[1]
AIM9Stat[1].formats					= {"OFF", "COOL", "RDY"}
shift_obj_pos(AIM9Stat[1], boxes[1], 25+110, 0)
SetLowerLeftCornerOrigin(AIM9Stat[1])
Add(AIM9Stat[1])
use_mipfilter(AIM9Stat[1])

AIM9Stat[11]						= CreateElement "ceStringPoly"
AIM9Stat[11].name					= "AIM9Stat" .. 11
AIM9Stat[11].material				= font_MFCD
AIM9Stat[11].UseBackground			= false
AIM9Stat[11].alignment				= "RightTop"
AIM9Stat[11].controllers			= {{"DSMS_sidewinder_present", StoreIndexes[11]}, {"DSMS_sidewinder_status_station", StoreIndexes[11]}, {"DSMS_store_color", StoreIndexes[11]}}
AIM9Stat[11].stringdefs				= predefined_fonts[1]
AIM9Stat[11].formats				= {"OFF", "COOL", "RDY"}
shift_obj_pos(AIM9Stat[11], boxes[11], -25, 0)
SetLowerLeftCornerOrigin(AIM9Stat[11])
Add(AIM9Stat[11])
use_mipfilter(AIM9Stat[11])

Launcher68 = {}

Launcher68[2]						= CreateElement "ceStringPoly"
Launcher68[2].name					= "Launcher68" .. 2
Launcher68[2].material				= font_MFCD
Launcher68[2].UseBackground			= false
Launcher68[2].alignment				= "LeftTop"
Launcher68[2].controllers			= {{"DSMS_68_launcher", StoreIndexes[2]}, {"DSMS_store_color", StoreIndexes[2]}}
Launcher68[2].stringdefs			= predefined_fonts[1]
Launcher68[2].value					= "68"
shift_obj_pos(Launcher68[2], boxes[2], 25+4, 0)
SetLowerLeftCornerOrigin(Launcher68[2])
Add(Launcher68[2])
use_mipfilter(Launcher68[2])

Launcher68[3]						= Copy(Launcher68[2])
Launcher68[3].controllers			= {{"DSMS_68_launcher", StoreIndexes[3]}, {"DSMS_store_color", StoreIndexes[3]}}
shift_obj_pos(Launcher68[3], boxes[3], 25+4, 0)
SetLowerLeftCornerOrigin(Launcher68[3])
Add(Launcher68[3])
use_mipfilter(Launcher68[3])

Launcher68[4]						= Copy(Launcher68[2])
Launcher68[4].controllers			= {{"DSMS_68_launcher", StoreIndexes[4]}, {"DSMS_store_color", StoreIndexes[4]}}
shift_obj_pos(Launcher68[4], boxes[4], 25+4, 0)
SetLowerLeftCornerOrigin(Launcher68[4])
Add(Launcher68[4])
use_mipfilter(Launcher68[4])

Launcher68[8]						= Copy(Launcher68[2])
Launcher68[8].controllers			= {{"DSMS_68_launcher", StoreIndexes[8]}, {"DSMS_store_color", StoreIndexes[8]}}
shift_obj_pos(Launcher68[8], boxes[8], -25-110+4, 0)
SetLowerLeftCornerOrigin(Launcher68[8])
Add(Launcher68[8])
use_mipfilter(Launcher68[8])

Launcher68[9]						= Copy(Launcher68[2])
Launcher68[9].controllers			= {{"DSMS_68_launcher", StoreIndexes[9]}, {"DSMS_store_color", StoreIndexes[9]}}
shift_obj_pos(Launcher68[9], boxes[9], -25-110+4, 0)
SetLowerLeftCornerOrigin(Launcher68[9])
Add(Launcher68[9])
use_mipfilter(Launcher68[9])

Launcher68[10]						= Copy(Launcher68[2])
Launcher68[10].controllers			= {{"DSMS_68_launcher", StoreIndexes[10]}, {"DSMS_store_color", StoreIndexes[10]}}
shift_obj_pos(Launcher68[10], boxes[10], -25-110+4, 0)
SetLowerLeftCornerOrigin(Launcher68[10])
Add(Launcher68[10])
use_mipfilter(Launcher68[10])

Launcher131 = {}

Launcher131[2]						= CreateElement "ceStringPoly"
Launcher131[2].name					= "Launcher131" .. 2
Launcher131[2].material				= font_MFCD
Launcher131[2].UseBackground		= false
Launcher131[2].alignment			= "LeftTop"
Launcher131[2].controllers			= {{"DSMS_131_launcher", StoreIndexes[2]}, {"DSMS_store_color", StoreIndexes[2]}}
Launcher131[2].stringdefs			= predefined_fonts[1]
Launcher131[2].value				= "131"
shift_obj_pos(Launcher131[2], boxes[2], 25+4, 0)
SetLowerLeftCornerOrigin(Launcher131[2])
Add(Launcher131[2])
use_mipfilter(Launcher131[2])

Launcher131[3]						= Copy(Launcher131[2])
Launcher131[3].controllers			= {{"DSMS_131_launcher", StoreIndexes[3]}, {"DSMS_store_color", StoreIndexes[3]}}
shift_obj_pos(Launcher131[3], boxes[3], 25+4, 0)
SetLowerLeftCornerOrigin(Launcher131[3])
Add(Launcher131[3])
use_mipfilter(Launcher131[3])

Launcher131[4]						= Copy(Launcher131[2])
Launcher131[4].controllers			= {{"DSMS_131_launcher", StoreIndexes[4]}, {"DSMS_store_color", StoreIndexes[4]}}
shift_obj_pos(Launcher131[4], boxes[4], 25+4, 0)
SetLowerLeftCornerOrigin(Launcher131[4])
Add(Launcher131[4])
use_mipfilter(Launcher131[4])

Launcher131[8]						= Copy(Launcher131[2])
Launcher131[8].controllers			= {{"DSMS_131_launcher", StoreIndexes[8]}, {"DSMS_store_color", StoreIndexes[8]}}
shift_obj_pos(Launcher131[8], boxes[8], -25-110+4, 0)
SetLowerLeftCornerOrigin(Launcher131[8])
Add(Launcher131[8])
use_mipfilter(Launcher131[8])

Launcher131[9]						= Copy(Launcher131[2])
Launcher131[9].controllers			= {{"DSMS_131_launcher", StoreIndexes[9]}, {"DSMS_store_color", StoreIndexes[9]}}
shift_obj_pos(Launcher131[9], boxes[9], -25-110+4, 0)
SetLowerLeftCornerOrigin(Launcher131[9])
Add(Launcher131[9])
use_mipfilter(Launcher131[9])

Launcher131[10]						= Copy(Launcher131[2])
Launcher131[10].controllers			= {{"DSMS_131_launcher", StoreIndexes[10]}, {"DSMS_store_color", StoreIndexes[10]}}
shift_obj_pos(Launcher131[10], boxes[10], -25-110+4, 0)
SetLowerLeftCornerOrigin(Launcher131[10])
Add(Launcher131[10])
use_mipfilter(Launcher131[10])

LauncherTER = {}

LauncherTER[3]						= CreateElement "ceStringPoly"
LauncherTER[3].name					= "LauncherTER" .. 3
LauncherTER[3].material				= font_MFCD
LauncherTER[3].UseBackground		= false
LauncherTER[3].alignment			= "LeftTop"
LauncherTER[3].controllers			= {{"DSMS_TER_launcher", StoreIndexes[3]}, {"DSMS_store_color", StoreIndexes[3]}}
LauncherTER[3].stringdefs			= predefined_fonts[1]
LauncherTER[3].value				= "TER"
shift_obj_pos(LauncherTER[3], boxes[3], 25+4, 0)
SetLowerLeftCornerOrigin(LauncherTER[3])
Add(LauncherTER[3])
use_mipfilter(LauncherTER[3])

LauncherTER[4]						= Copy(LauncherTER[3])
LauncherTER[4].controllers			= {{"DSMS_TER_launcher", StoreIndexes[4]}, {"DSMS_store_color", StoreIndexes[4]}}
shift_obj_pos(LauncherTER[4], boxes[4], 25+4, 0)
SetLowerLeftCornerOrigin(LauncherTER[4])
Add(LauncherTER[4])
use_mipfilter(LauncherTER[4])

LauncherTER[5]						= Copy(LauncherTER[3])
LauncherTER[5].controllers			= {{"DSMS_TER_launcher", StoreIndexes[5]}, {"DSMS_store_color", StoreIndexes[5]}}
shift_obj_pos(LauncherTER[5], boxes[5], 25+4, 0)
SetLowerLeftCornerOrigin(LauncherTER[5])
Add(LauncherTER[5])
use_mipfilter(LauncherTER[5])

LauncherTER[6]						= Copy(LauncherTER[3])
LauncherTER[6].controllers			= {{"DSMS_TER_launcher", StoreIndexes[6]}, {"DSMS_store_color", StoreIndexes[6]}}
shift_obj_pos(LauncherTER[6], boxes[6], -55+4, -55)
SetLowerLeftCornerOrigin(LauncherTER[6])
Add(LauncherTER[6])
use_mipfilter(LauncherTER[6])

LauncherTER[7]						= Copy(LauncherTER[3])
LauncherTER[7].controllers			= {{"DSMS_TER_launcher", StoreIndexes[7]}, {"DSMS_store_color", StoreIndexes[7]}}
shift_obj_pos(LauncherTER[7], boxes[7], -25-110+4, 0)
SetLowerLeftCornerOrigin(LauncherTER[7])
Add(LauncherTER[7])
use_mipfilter(LauncherTER[7])

LauncherTER[8]						= Copy(LauncherTER[3])
LauncherTER[8].controllers			= {{"DSMS_TER_launcher", StoreIndexes[8]}, {"DSMS_store_color", StoreIndexes[8]}}
shift_obj_pos(LauncherTER[8], boxes[8], -25-110+4, 0)
SetLowerLeftCornerOrigin(LauncherTER[8])
Add(LauncherTER[8])
use_mipfilter(LauncherTER[8])

LauncherTER[9]						= Copy(LauncherTER[3])
LauncherTER[9].controllers			= {{"DSMS_TER_launcher", StoreIndexes[9]}, {"DSMS_store_color", StoreIndexes[9]}}
shift_obj_pos(LauncherTER[9], boxes[9], -25-110+4, 0)
SetLowerLeftCornerOrigin(LauncherTER[9])
Add(LauncherTER[9])
use_mipfilter(LauncherTER[9])

--- Нижние строки для наров
local function add_rockets_param(station, name, formats, controllers)
	local RocketParam				= CreateElement "ceStringPoly"
	RocketParam.name				= name
	RocketParam.material			= font_MFCD
	RocketParam.UseBackground		= false
	RocketParam.alignment			= "LeftTop"
	RocketParam.formats				= formats
	RocketParam.controllers			= controllers
	RocketParam.stringdefs			= predefined_fonts[1]
		
	local shiftX
	if station >= 2 and station <= 4 then
		shiftX = 25+4
	else
		shiftX = -25-110+4
	end
	
	shift_obj_pos(RocketParam, boxes[station], shiftX, 0)
	SetLowerLeftCornerOrigin(RocketParam)
	Add(RocketParam)
	use_mipfilter(RocketParam)
	
	return RocketParam
end

local RocketParamStrFormats = {"PMI", "WP", "TP", "ILLUM", "IR ILLUM", "SMOKE", "HE", "HEAT", "TP"}

for i = 2, 10 do
	if i ~= 5 and i ~= 6 and i ~= 7 then
		add_rockets_param(i, "RocketParam" .. i, RocketParamStrFormats, {{"DSMS_station_is_rocket", StoreIndexes[i]}, {"DSMS_store_color", StoreIndexes[i]}, {"DSMS_store_rocket_param", StoreIndexes[i]}})
	end
end

--Код лазера
LsrCode = {}

LsrCode[1]						= CreateElement "ceStringPoly"
LsrCode[1].name					= "LsrCode" .. 1
LsrCode[1].material				= font_MFCD
LsrCode[1].UseBackground		= false
LsrCode[1].alignment			= "LeftTop"
LsrCode[1].controllers			= {{"DSMS_lsr_code_avail", StoreIndexes[1]}, {"DSMS_lsr_code", 0, StoreIndexes[1]}, {"DSMS_store_color", StoreIndexes[1]}}
LsrCode[1].stringdefs			= predefined_fonts[1]
LsrCode[1].formats				= {"%d"}
shift_obj_pos(LsrCode[1], boxes[1], 25+4, 0)
SetLowerLeftCornerOrigin(LsrCode[1])
Add(LsrCode[1])
use_mipfilter(LsrCode[1])

LsrCode[2]						= Copy(LsrCode[1])
LsrCode[2].controllers			= {{"DSMS_lsr_code_avail", StoreIndexes[2]}, {"DSMS_lsr_code", 0, StoreIndexes[2]}, {"DSMS_store_color", StoreIndexes[2]}}
shift_obj_pos(LsrCode[2], boxes[2], 25+4, 0)
SetLowerLeftCornerOrigin(LsrCode[2])
Add(LsrCode[2])
use_mipfilter(LsrCode[2])

LsrCode[3]						= Copy(LsrCode[1])
LsrCode[3].controllers			= {{"DSMS_lsr_code_avail", StoreIndexes[3]}, {"DSMS_lsr_code", 0, StoreIndexes[3]}, {"DSMS_store_color", StoreIndexes[3]}}
shift_obj_pos(LsrCode[3], boxes[3], 25+4, 0)
SetLowerLeftCornerOrigin(LsrCode[3])
Add(LsrCode[3])
use_mipfilter(LsrCode[3])

LsrCode[4]						= Copy(LsrCode[1])
LsrCode[4].controllers			= {{"DSMS_lsr_code_avail", StoreIndexes[4]}, {"DSMS_lsr_code", 0, StoreIndexes[4]}, {"DSMS_store_color", StoreIndexes[4]}}
shift_obj_pos(LsrCode[4], boxes[4], 25+4, 0)
SetLowerLeftCornerOrigin(LsrCode[4])
Add(LsrCode[4])
use_mipfilter(LsrCode[4])

LsrCode[5]						= Copy(LsrCode[1])
LsrCode[5].controllers			= {{"DSMS_lsr_code_avail", StoreIndexes[5]}, {"DSMS_lsr_code", 0, StoreIndexes[5]}, {"DSMS_store_color", StoreIndexes[5]}}
shift_obj_pos(LsrCode[5], boxes[5], 25+4, 0)
SetLowerLeftCornerOrigin(LsrCode[5])
Add(LsrCode[5])
use_mipfilter(LsrCode[5])

LsrCode[6]						= Copy(LsrCode[1])
LsrCode[6].controllers			= {{"DSMS_lsr_code_avail", StoreIndexes[6]}, {"DSMS_lsr_code", 0, StoreIndexes[6]}, {"DSMS_store_color", StoreIndexes[6]}}
shift_obj_pos(LsrCode[6], boxes[6], -55+4, -55)
SetLowerLeftCornerOrigin(LsrCode[6])
Add(LsrCode[6])
use_mipfilter(LsrCode[6])

LsrCode[7]						= Copy(LsrCode[1])
LsrCode[7].controllers			= {{"DSMS_lsr_code_avail", StoreIndexes[7]}, {"DSMS_lsr_code", 0, StoreIndexes[7]}, {"DSMS_store_color", StoreIndexes[7]}}
shift_obj_pos(LsrCode[7], boxes[7], -25-110+4, 0)
SetLowerLeftCornerOrigin(LsrCode[7])
Add(LsrCode[7])
use_mipfilter(LsrCode[7])

LsrCode[8]						= Copy(LsrCode[1])
LsrCode[8].controllers			= {{"DSMS_lsr_code_avail", StoreIndexes[8]}, {"DSMS_lsr_code", 0, StoreIndexes[8]}, {"DSMS_store_color", StoreIndexes[8]}}
shift_obj_pos(LsrCode[8], boxes[8], -25-110+4, 0)
SetLowerLeftCornerOrigin(LsrCode[8])
Add(LsrCode[8])
use_mipfilter(LsrCode[8])

LsrCode[9]						= Copy(LsrCode[1])
LsrCode[9].controllers			= {{"DSMS_lsr_code_avail", StoreIndexes[9]}, {"DSMS_lsr_code", 0, StoreIndexes[9]}, {"DSMS_store_color", StoreIndexes[9]}}
shift_obj_pos(LsrCode[9], boxes[9], -25-110+4, 0)
SetLowerLeftCornerOrigin(LsrCode[9])
Add(LsrCode[9])
use_mipfilter(LsrCode[9])

LsrCode[10]						= Copy(LsrCode[1])
LsrCode[10].controllers			= {{"DSMS_lsr_code_avail", StoreIndexes[10]}, {"DSMS_lsr_code", 0, StoreIndexes[10]}, {"DSMS_store_color", StoreIndexes[10]}}
shift_obj_pos(LsrCode[10], boxes[10], -25-110+4, 0)
SetLowerLeftCornerOrigin(LsrCode[10])
Add(LsrCode[10])
use_mipfilter(LsrCode[10])

LsrCode[11]						= Copy(LsrCode[1])
LsrCode[11].controllers			= {{"DSMS_lsr_code_avail", StoreIndexes[11]}, {"DSMS_lsr_code", 0, StoreIndexes[11]}, {"DSMS_store_color", StoreIndexes[11]}}
shift_obj_pos(LsrCode[11], boxes[11], -25-110+4, 0)
SetLowerLeftCornerOrigin(LsrCode[11])
Add(LsrCode[11])
use_mipfilter(LsrCode[11])

--Конфигурация
ConfigString = {}

ConfigString[1]						= CreateElement "ceStringPoly"
ConfigString[1].name				= "ConfigString" .. 1
ConfigString[1].material			= font_MFCD
ConfigString[1].UseBackground		= false
ConfigString[1].alignment			= "LeftTop"
ConfigString[1].controllers			= {{"DSMS_config_avail", StoreIndexes[1]}, {"DSMS_config_name", 0, StoreIndexes[1]}, {"DSMS_store_color", StoreIndexes[1]}}
ConfigString[1].stringdefs			= predefined_fonts[1]
ConfigString[1].formats				= {"%s"}
shift_obj_pos(ConfigString[1], boxes[1], 25+4, 0)
SetLowerLeftCornerOrigin(ConfigString[1])
Add(ConfigString[1])
use_mipfilter(ConfigString[1])

ConfigString[2]						= Copy(ConfigString[1])
ConfigString[2].controllers			= {{"DSMS_config_avail", StoreIndexes[2]}, {"DSMS_config_name", 0, StoreIndexes[2]}, {"DSMS_store_color", StoreIndexes[2]}}
shift_obj_pos(ConfigString[2], boxes[2], 25+4, 0)
SetLowerLeftCornerOrigin(ConfigString[2])
Add(ConfigString[2])
use_mipfilter(ConfigString[2])

ConfigString[3]						= Copy(ConfigString[1])
ConfigString[3].controllers			= {{"DSMS_config_avail", StoreIndexes[3]}, {"DSMS_config_name", 0, StoreIndexes[3]}, {"DSMS_store_color", StoreIndexes[3]}}
shift_obj_pos(ConfigString[3], boxes[3], 25+4, 0)
SetLowerLeftCornerOrigin(ConfigString[3])
Add(ConfigString[3])
use_mipfilter(ConfigString[3])

ConfigString[4]						= Copy(ConfigString[1])
ConfigString[4].controllers			= {{"DSMS_config_avail", StoreIndexes[4]}, {"DSMS_config_name", 0, StoreIndexes[4]}, {"DSMS_store_color", StoreIndexes[4]}}
shift_obj_pos(ConfigString[4], boxes[4], 25+4, 0)
SetLowerLeftCornerOrigin(ConfigString[4])
Add(ConfigString[4])
use_mipfilter(ConfigString[4])

ConfigString[5]						= Copy(ConfigString[1])
ConfigString[5].controllers			= {{"DSMS_config_avail", StoreIndexes[5]}, {"DSMS_config_name", 0, StoreIndexes[5]}, {"DSMS_store_color", StoreIndexes[5]}}
shift_obj_pos(ConfigString[5], boxes[5], 25+4, 0)
SetLowerLeftCornerOrigin(ConfigString[5])
Add(ConfigString[5])
use_mipfilter(ConfigString[5])

ConfigString[6]						= Copy(ConfigString[1])
ConfigString[6].controllers			= {{"DSMS_config_avail", StoreIndexes[6]}, {"DSMS_config_name", 0, StoreIndexes[6]}, {"DSMS_store_color", StoreIndexes[6]}}
shift_obj_pos(ConfigString[6], boxes[6], -55+4, -55)
SetLowerLeftCornerOrigin(ConfigString[6])
Add(ConfigString[6])
use_mipfilter(ConfigString[6])

ConfigString[7]						= Copy(ConfigString[1])
ConfigString[7].controllers			= {{"DSMS_config_avail", StoreIndexes[7]}, {"DSMS_config_name", 0, StoreIndexes[7]}, {"DSMS_store_color", StoreIndexes[7]}}
shift_obj_pos(ConfigString[7], boxes[7], -25-110+4, 0)
SetLowerLeftCornerOrigin(ConfigString[7])
Add(ConfigString[7])
use_mipfilter(ConfigString[7])

ConfigString[8]						= Copy(ConfigString[1])
ConfigString[8].controllers			= {{"DSMS_config_avail", StoreIndexes[8]}, {"DSMS_config_name", 0, StoreIndexes[8]}, {"DSMS_store_color", StoreIndexes[8]}}
shift_obj_pos(ConfigString[8], boxes[8], -25-110+4, 0)
SetLowerLeftCornerOrigin(ConfigString[8])
Add(ConfigString[8])
use_mipfilter(ConfigString[8])

ConfigString[9]						= Copy(ConfigString[1])
ConfigString[9].controllers			= {{"DSMS_config_avail", StoreIndexes[9]}, {"DSMS_config_name", 0, StoreIndexes[9]}, {"DSMS_store_color", StoreIndexes[9]}}
shift_obj_pos(ConfigString[9], boxes[9], -25-110+4, 0)
SetLowerLeftCornerOrigin(ConfigString[9])
Add(ConfigString[9])
use_mipfilter(ConfigString[9])

ConfigString[10]						= Copy(ConfigString[1])
ConfigString[10].controllers			= {{"DSMS_config_avail", StoreIndexes[10]}, {"DSMS_config_name", 0, StoreIndexes[10]}, {"DSMS_store_color", StoreIndexes[10]}}
shift_obj_pos(ConfigString[10], boxes[10], -25-110+4, 0)
SetLowerLeftCornerOrigin(ConfigString[10])
Add(ConfigString[10])
use_mipfilter(ConfigString[10])

ConfigString[11]						= Copy(ConfigString[1])
ConfigString[11].controllers			= {{"DSMS_config_avail", StoreIndexes[11]}, {"DSMS_config_name", 0, StoreIndexes[11]}, {"DSMS_store_color", StoreIndexes[11]}}
shift_obj_pos(ConfigString[11], boxes[11], -25-110+4, 0)
SetLowerLeftCornerOrigin(ConfigString[11])
Add(ConfigString[11])
use_mipfilter(ConfigString[11])

LauncherSUU25 = {}

LauncherSUU25[3]					= CreateElement "ceStringPoly"
LauncherSUU25[3].name				= "LauncherTER" .. 31
LauncherSUU25[3].material			= font_MFCD
LauncherSUU25[3].UseBackground		= false
LauncherSUU25[3].alignment			= "LeftTop"
LauncherSUU25[3].controllers		= {{"DSMS_SUU_launcher", StoreIndexes[3]}, {"DSMS_store_color", StoreIndexes[3]}}
LauncherSUU25[3].stringdefs			= predefined_fonts[1]
LauncherSUU25[3].value				= "SUU25"
shift_obj_pos(LauncherSUU25[3], boxes[3], 25+4, 0)
SetLowerLeftCornerOrigin(LauncherSUU25[3])
Add(LauncherSUU25[3])
use_mipfilter(LauncherSUU25[3])

LauncherSUU25[2]						= Copy(LauncherSUU25[3])
LauncherSUU25[2].controllers			= {{"DSMS_SUU_launcher", StoreIndexes[2]}, {"DSMS_store_color", StoreIndexes[2]}}
shift_obj_pos(LauncherSUU25[2], boxes[2], 25+4, 0)
SetLowerLeftCornerOrigin(LauncherSUU25[2])
Add(LauncherSUU25[2])
use_mipfilter(LauncherSUU25[2])

LauncherSUU25[9]						= Copy(LauncherSUU25[3])
LauncherSUU25[9].controllers			= {{"DSMS_SUU_launcher", StoreIndexes[9]}, {"DSMS_store_color", StoreIndexes[9]}}
shift_obj_pos(LauncherSUU25[9], boxes[9], -25-110+4, 0)
SetLowerLeftCornerOrigin(LauncherSUU25[9])
Add(LauncherSUU25[9])
use_mipfilter(LauncherSUU25[9])

LauncherSUU25[10]						= Copy(LauncherSUU25[3])
LauncherSUU25[10].controllers			= {{"DSMS_SUU_launcher", StoreIndexes[10]}, {"DSMS_store_color", StoreIndexes[10]}}
shift_obj_pos(LauncherSUU25[10], boxes[10], -25-110+4, 0)
SetLowerLeftCornerOrigin(LauncherSUU25[10])
Add(LauncherSUU25[10])
use_mipfilter(LauncherSUU25[10])

local function add_IAM_status(station, name, formats, controllers)
	local statusElem  				= CreateElement "ceStringPoly"
	statusElem.name					= name
	statusElem.material				= font_MFCD
	statusElem.UseBackground		= false
	statusElem.alignment			= "LeftTop"
	statusElem.controllers			= controllers
	statusElem.stringdefs			= predefined_fonts[1]
	statusElem.formats				= formats

	local shiftX
	local shiftY
	
	if station >= 3 and station <= 5 then
		shiftX = 25+4
		shiftY = 0
	elseif station == 6 then
		shiftX = -55+4
		shiftY = -55
	else
		shiftX = -25-110+4
		shiftY = 0
	end
	
	shift_obj_pos(statusElem, boxes[station], shiftX, shiftY)
	SetLowerLeftCornerOrigin(statusElem)
	Add(statusElem)
	use_mipfilter(statusElem)
	
	return statusElem
end

local IAM_str_formats = {"",
						 "ERS FAIL",
						 "ERASED",
						 "ERASING",
						 "NO COMM",
						 "OFF",
						 "FAIL",
						 "INIT",
						 "TEST",
						 "NO SPI",
						 "RETRY",
						 "ABORTED",
						 "ALN UNS",
						 "ALN DEG",
						 "ALN IRDY",
						 "ALN GRDY",
						 "ALN RDY",
						 "UNSAT",
						 "DEG",
						 "IMU RDY",
						 "GPS RDY",
						 "RDY",
						}

for i = 3, 9 do
	add_IAM_status(i, "IAM_status" .. i, IAM_str_formats, {{"DSMS_store_is_IAM", StoreIndexes[i]}, {"DSMS_store_IAM_status", StoreIndexes[i]}, {"DSMS_store_color", StoreIndexes[i]}})
end
