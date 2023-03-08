-- This is page symbology definitions file, with HUD pages specifics.

dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Common_page_defs.lua")

waterlineShiftY = DegToDI(4)

-- Fonts sizes reference for HUD:
-- 100% - 6.8 mil
-- 120% - 8.16 mil
-- 150% - 10.2 mil
-- 200% - 13.6 mil

-- F/A-18 MDG DIs (display increments)
fontIntercharHUD_norm_120 = 6
fontIntercharHUD_mid_120  = 8
fontIntercharHUD_norm_150 = 6

stringdefs_HUD_norm_120 = {fontScaleY_120, fontScaleX_120, fontIntercharHUD_norm_120 * GetScale(), fontInterlineDflt120 * GetScale()}
stringdefs_HUD_mid_120  = {fontScaleY_120, fontScaleX_120, fontIntercharHUD_mid_120 * GetScale(),  fontInterlineDflt120 * GetScale()}
stringdefs_HUD_norm_150 = {fontScaleY_150, fontScaleX_150, fontIntercharHUD_norm_150 * GetScale(), fontInterlineDflt150 * GetScale()}

-- Airspeed/Altitude numerics definitions
local CAS_AltBoxGapY 	= 5
CAS_AltBoxHeight 		= glyphNominalHeight150 + CAS_AltBoxGapY * 2
CAS_AltBoxEdgeX 		= 350
CAS_AltNumericsShiftY 	= -glyphNominalHeight150 / 2 - CAS_AltBoxGapY

CAS_BoxWidth 			= 115
Alt_BoxWidth 			= 141

gap_alt_hund_tenths 	= 15

-- placeholders
waterline_origin = addPlaceholder("waterline_origin", {0, waterlineShiftY})
CAS_BoxOrigin    = addPlaceholder("CAS_BoxOrigin", {-CAS_AltBoxEdgeX, 0}, waterline_origin.name)
ALT_BoxOrigin    = addPlaceholder("ALT_BoxOrigin", {CAS_AltBoxEdgeX, 0}, waterline_origin.name)

-- A/A, A/G gun and rockets
AA_GunBoresight_Y = DegToDI(2)
AA_GunCrossPos_Y = waterlineShiftY + AA_GunBoresight_Y

gunRktReticleRadius  	= MilToDI(25)  -- 50 mils

-- tic marks
gunRktReticleTickLen = 18
gunRktReticleRangeTickLen = 25


function addGunCross(name, pos, parent, controller)
	local placeholder = addPlaceholder(name.."_placeholder", pos, parent, controller)
	local gunCrossLineLen = 30
	addStrokeLine(name.."_vertical", gunCrossLineLen, {0, -gunCrossLineLen / 2}, 0, placeholder.name)
	addStrokeLine(name.."_horizontal", gunCrossLineLen, {gunCrossLineLen / 2, }, 90, placeholder.name)
end
