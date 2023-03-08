dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")


local mode = add_Simple_PB_label(6,		"REC",	nil, {{"MFD_TCN_Mode"}})
mode.formats = {"OFF", "REC", "T/R", "A/A TR"}

add_Simple_PB_label(8,	"CH\n123",	nil, {{"MFD_TCN_Channel"}})

local band = add_Simple_PB_label(10,	"X",	nil, {{"MFD_TCN_Band"}})
band.formats = {"X", "Y"}

local TcnChanRoot = addPlaceholder("TCN_CHAN_Root", {PB_positions[8][1] - 10, PB_positions[8][2]})
local TcnChanOffset = 75
local TcnChanSymbolScale = 3.5
addStrokeSymbol("TCN_CHAN_DEC_Symbol", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, -TcnChanOffset}, TcnChanRoot.name, nil, TcnChanSymbolScale)
local Increment = addStrokeSymbol("TCN_CHAN_INC_Symbol", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, TcnChanOffset}, TcnChanRoot.name, nil, TcnChanSymbolScale)
Increment.init_rot = {180}
