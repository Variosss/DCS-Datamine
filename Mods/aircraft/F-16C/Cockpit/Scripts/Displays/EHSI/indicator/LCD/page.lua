dofile(LockOn_Options.script_path.."Displays/Common/indicator/Units.lua")

SetCustomScale(1)

local displaySize_inch	= 2.45 * InToMeter	-- [inch]
local size05 = displaySize_inch / 2

local verts	= 	{{-size05, size05},
				 { size05, size05},
				 { size05,-size05},
				 {-size05,-size05}}

local inds	= {0, 1, 2, 0, 2, 3}

local hud_only_background			= CreateElement "ceTexPoly"
hud_only_background.material		= MakeMaterial("GameOverlay/radar_bluegray_bg.png",{50,50,50,255})
hud_only_background.vertices		= verts
hud_only_background.indices			= inds
hud_only_background.additive_alpha	= false
hud_only_background.tex_coords		= {{0, 0},{1,0},{1,1},{0,1}}
hud_only_background.controllers		= {{"render_purpose",1}}
Add(hud_only_background)

local picture			= CreateElement "ceTexPoly"
picture.material		= MakeMaterial("EHSI_LCD_F16",{255,255,255,255})
picture.vertices		= verts
picture.indices			= inds
picture.additive_alpha	= true
picture.tex_coords		= {{0, 0},{1, 0},{1,1},{0, 1}}
Add(picture)
