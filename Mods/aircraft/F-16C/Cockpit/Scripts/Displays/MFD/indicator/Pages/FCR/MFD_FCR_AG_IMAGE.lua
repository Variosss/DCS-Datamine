dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/Common/indicator/Units.lua")

local ImagePH = addPlaceholder("AG_RadarImageKeeper", {0, -HalfPixelsPerSide}, nil, {{"FCR_AG_MapRoot"}, {"FCR_AG_ImageRotate"}, {"FCR_AG_BSCAN"}})
local sz = HalfPixelsPerSide - 1 -- Pixel
local verts = {{-sz,  sz},
				{ sz,  sz},
				{ sz, -sz},
				{-sz, -sz}}

local videoSignal_MPD				= CreateElement "ceTexPoly"

local parent						= nil
local material						= "render_target_"..string.format("%d", GetRenderTarget() + 1)

setSymbolCommonProperties(videoSignal_MPD, "videoSignal_MPD", {0, HalfPixelsPerSide}, ImagePH.name, {{"FCR_AG_ExpCursorPosition"}}, material)

videoSignal_MPD.vertices			= verts
videoSignal_MPD.indices				= default_box_indices
videoSignal_MPD.tex_params			= {0.5, 0.5, 1 / PixelsPerSide, 1 / PixelsPerSide}
videoSignal_MPD.additive_alpha		= true

Add(videoSignal_MPD)

-- targets, radar video signal
addPlaceholder("AG_RadarContactsKeeper", nil, videoSignal_MPD.name, {{"FCR_AG_GmtMap"}, {"MFD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.RADAR_AG_CONTACTS}})