dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/HARM/HARM_Utils.lua")

local columnX = -305
local columnY = 300
local rowStep = 35

local classesPH = addPlaceholder("MPD_HARM_SCAN_symbols", {0, 0}, nil, {{"MPD_HARM_Scan_Symbols", 0, 1}})

for i = 1, 15 do
	local curY = columnY - (i-1) * rowStep
	local curClass = addStrokeText("MPD_HARM_class"..i, HARM_Classes[i+1], STROKE_FNT_DFLT_120, "LeftCenter", {columnX, curY}, classesPH.name,
		{{"MPD_HARM_Scan_Symbols", 0, i}})
	
	addStrokeSymbol("MPD_HARM_SCAN_Center"..i,	{"stroke_symbols_MDI_AMPCD", "harm-signal-center"},	"FromSet", {-45, 0}, curClass.name,
		{{"MPD_HARM_Scan_Symbols", 1, i}})
	addStrokeSymbol("MPD_HARM_SCAN_Left"..i,	{"stroke_symbols_MDI_AMPCD", "harm-signal-left"},	"FromSet", {-66, 0}, curClass.name,
		{{"MPD_HARM_Scan_Symbols", 2, i}})
	local arrowR = addStrokeSymbol("MPD_HARM_SCAN_Right"..i, {"stroke_symbols_MDI_AMPCD", "harm-signal-left"}, "FromSet", {-24, 0}, curClass.name,
		{{"MPD_HARM_Scan_Symbols", 3, i}})
	arrowR.init_rot = {180}
end

-------------------------------------- Menu --------------------------------------
add_PB_label(17, {"SCAN", nil, nil, {{"MPD_HARM_SCAN_Box"}}})
