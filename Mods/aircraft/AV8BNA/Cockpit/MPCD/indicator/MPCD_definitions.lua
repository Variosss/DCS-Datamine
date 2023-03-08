dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."Displays/Display_Units.lua")
dofile(LockOn_Options.script_path.."Displays/Display_StrokeDefs.lua")

MPCD_DEFAULT_LEVEL     = 5

-- Screen units
DItoScreenUnits = DItoIn()
ScreenUnitsToDI = 1 / DItoScreenUnits
dbg_drawStrokesAsWire = false
ALPHA_BLEND 	= true
MPCD_STRK_SCALE	= 1.0

--SetScale(FOV)
SetScale(METERS)
SetCustomScale(GetScale() * (1 / MeterToIn) * DItoScreenUnits) -- Display Increments

-- Display Sizes
function PosX(pos) return (pos or 1) * GetHalfWidth() * MeterToIn * InToDI() end
function PosY(pos) return (pos or 1) * GetHalfHeight() * MeterToIn * InToDI() end

Render_Screen = GetRenderTarget() + 1

-- Default POS Values
mpcd_scale		= 0.55/275
mpcd_grid_scale	= 0.50/275
mpcd_hdg_scale	= 0.70/275
mpcd_hdg_displ	= (3448 * mpcd_hdg_scale / 480) * GetScale()
mils_ratio		= 100.0/275.0 * MilToDI(MPCD_STRK_SCALE)

symbol_pixels_x =  44.0 * 2 -- pi
symbol_pixels_y =  72.0 * 2

-- Default button positions
--      06    07    08    09    10  
--    +-----------------------------+
-- 05 |                             | 11
-- 04 |                             | 12
-- 03 |                             | 13
-- 02 |                             | 14
-- 01 |                             | 15
--    +-----------------------------+
--      20    19    18    17    16  

mpcd_btn_01_pos = {PosX(-0.95), PosY(-0.60), 0}
mpcd_btn_02_pos = {PosX(-0.95), PosY(-0.30), 0}
mpcd_btn_03_pos = {PosX(-0.95), PosY(-0.00), 0}
mpcd_btn_04_pos = {PosX(-0.95), PosY( 0.30), 0}
mpcd_btn_05_pos = {PosX(-0.95), PosY( 0.60), 0}

mpcd_btn_06_pos = {PosX(-0.65), PosY( 0.93), 0}
mpcd_btn_07_pos = {PosX(-0.33), PosY( 0.93), 0}
mpcd_btn_08_pos = {PosX(-0.00), PosY( 0.93), 0}
mpcd_btn_09_pos = {PosX( 0.33), PosY( 0.93), 0}
mpcd_btn_10_pos = {PosX( 0.65), PosY( 0.93), 0}

mpcd_btn_11_pos = {PosX( 0.95), PosY( 0.60), 0}
mpcd_btn_12_pos = {PosX( 0.95), PosY( 0.30), 0}
mpcd_btn_13_pos = {PosX( 0.95), PosY(-0.00), 0}
mpcd_btn_14_pos = {PosX( 0.95), PosY(-0.30), 0}
mpcd_btn_15_pos = {PosX( 0.95), PosY(-0.60), 0}

mpcd_btn_16_pos = {PosX( 0.65), PosY(-0.93), 0}
mpcd_btn_17_pos = {PosX( 0.33), PosY(-0.93), 0}
mpcd_btn_18_pos = {PosX(-0.00), PosY(-0.93), 0}
mpcd_btn_19_pos = {PosX(-0.33), PosY(-0.93), 0}
mpcd_btn_20_pos = {PosX(-0.65), PosY(-0.93), 0}

mpcd_btn_16_sel_pos = {PosX( 0.65), PosY(-0.87), 0}
mpcd_btn_17_sel_pos = {PosX( 0.33), PosY(-0.87), 0}
mpcd_btn_18_sel_pos = {PosX(-0.00), PosY(-0.87), 0}
mpcd_btn_19_sel_pos = {PosX(-0.33), PosY(-0.87), 0}
mpcd_btn_20_sel_pos = {PosX(-0.65), PosY(-0.87), 0}

--- Colors Definitions ---

MPCD_BLACK		= {0, 0, 0, 255}
MPCD_WHITE		= {255, 255, 255, 255}
MPCD_YELLOW		= {255, 255, 0, 255}
MPCD_BLUE		= {30, 144, 255, 255}	-- dodger blue. 0,0,255 is too dark.
MPCD_RED		= {255, 0, 0, 255}
MPCD_ORANGE		= {255, 165, 0, 255}
MPCD_DARK_GREY	= {105, 105, 105, 255}

MPCD_GREEN			= {0, 255, 0, 255}
MPCD_GREEN_SEMI		= {0, 204, 0, 255}
MPCD_GREEN_DEMI		= {0, 128, 0, 255}
MPCD_GREEN_DARK		= {0, 100, 0, 255}
MPCD_GREEN_YELLOW	= {122, 240, 41, 255}	-- {173, 255, 47, 255}
MPCD_GREEN_LIME		= {50, 205, 50, 255}
MPCD_GREEN_PALE		= {152, 251, 152, 255}
MPCD_GREEN_LIGHT	= {144, 238, 144, 255}

-- Materials Definition --
local resources_path_m = LockOn_Options.script_path.."Resources/MPCD/"

mpcd_align_mtl					= "mpcd_align_mtl_y"	-- MakeMaterial(resources_path_m.."MPCD_Align.tga", MPCD_YELLOW)
mpcd_symbols_mtl_w				= "mpcd_symbols_1_w"	-- MakeMaterial(resources_path_m.."MPCD_Symbols_01.dds", MPCD_WHITE)		-- SYMBOLS PACK (MAVERIK RETICLE)
mpcd_symbols_mtl_b				= "mpcd_symbols_1_b"	-- MakeMaterial(resources_path_m.."MPCD_Symbols_01.dds", MPCD_BLACK)		-- SYMBOLS PACK (MAVERIK RETICLE)
mpcd_ehsd_lines_fg				= "mpcd_ehsd_lines_fg"	-- MakeMaterial(nil,	MPCD_GREEN_YELLOW)
mpcd_ehsd_lines_bg				= "mpcd_ehsd_lines_bg"	-- MakeMaterial(nil,	MPCD_BLACK)
mpcd_ehsd_nseq_lines_igr		= "mpcd_ehsd_route_lines_fg"
mpcd_ehsd_nseq_lines_ebg		= "mpcd_ehsd_dashed_lines_bg"
mpcd_ehsd_nseq_lines_egr		= "mpcd_ehsd_dashed_lines_fg"
mpcd_ehsd_route_lines_green 	= "mpcd_ehsd_route_lines_gr"
mpcd_ehsd_route_lines_blue		= "mpcd_ehsd_route_lines_bl"
mpcd_ehsd_route_lines_orange	= "mpcd_ehsd_route_lines_or"
mpcd_ehsd_route_lines_violet	= "mpcd_ehsd_route_lines_vl"
mpcd_ehsd_route_lines_red		= "mpcd_ehsd_route_lines_rd"

stroke_material			= "mpcdl_strk_symb_fg"
stroke_material_outl	= "mpcdl_strk_symb_bg"
stroke_font     		= "font_MPCDL_stroke"
stroke_font_outline		= "font_MPCDL_stroke_outline"

if Render_Screen == 1 then
	MPCD_DEFAULT_LEVEL     = 5
	
	mpcd_symbols_mtl	= "mpcdl_symbols_1_g"	-- MakeMaterial(resources_path_m.."MPCD_Symbols_01.dds", MPCD_GREEN_YELLOW)	-- SYMBOLS PACK
	mpcd_symbols_2_mtl	= "mpcdl_symbols_2_g"	-- MakeMaterial(resources_path_m.."MPCD_Symbols_02.tga", MPCD_GREEN_YELLOW)	-- STRS + TPOD RETICLE PACK
	mpcd_symbols_3_mtl	= "mpcdl_symbols_3"		-- MakeMaterial(resources_path_m.."MPCD_Symbols_03.tga", MPCD_GREEN_YELLOW)	-- RWR + RETICLE PACK
	mpcd_symbols_4_mtl	= "mpcdl_symbols_4"		-- MakeMaterial(resources_path_m.."MPCD_Symbols_04.tga", MPCD_GREEN_YELLOW)	-- LSS/LST RETICLE (TO BE DELETED)
	mpcd_symbols_5_mtl	= "mpcdl_symbols_5"		-- MakeMaterial(resources_path_m.."MPCD_Symbols_05.tga", MPCD_GREEN_YELLOW)	-- AMG-65E RETICLE
	mpcd_symbols_6_mtl	= "mpcdl_symbols_6"		-- MakeMaterial(resources_path_m.."HUD_Symbols.tga", MPCD_GREEN_YELLOW)
	mpcd_tpod_symbols	= "tpod_symbols_L"		-- MakeMaterial(resources_path_m.."TPOD_Symbols_01.tga", MPCD_GREEN_YELLOW)
	
	mpcd_ehsd_nseq_lines_ebg		= "mpcdl_ehsd_dashed_lines_bg"
	mpcd_ehsd_nseq_lines_egr		= "mpcdl_ehsd_dashed_lines_fg"
	
	---- Fonts Definition ----
	mpcd_tpod_font		= "mpcdl_tpod_font"
	
	mpcd_font_base		= "mpcdl_tpod_font"
	mpcd_font_video		= "mpcdl_tpod_font"
	mpcd_font_night		= "mpcdl_tpod_font"
	mpcd_font_black 	= "mpcdl_tpod_font_bg"
	
	mpcd_font_white		= "mpcdl_tpod_font"
	mpcd_font_tacan		= "mpcdl_tpod_font"	--MPCD_GREEN
	mpcd_font_nav		= "mpcdl_tpod_font"	--MPCD_BLUE
	mpcd_font_hdg		= "mpcdl_tpod_font"	--MPCD_ORANGE
	mpcd_font_warn		= "mpcdl_tpod_font"	--MPCD_RED
	mpcd_font_caut		= "mpcdl_tpod_font"	--MPCD_YELLOW
	
	mpcd_lmav_font		= "mpcdl_lmav_font"
else
	MPCD_DEFAULT_LEVEL     = 15
	
	stroke_material			= "mpcdr_strk_symb_fg"
	stroke_material_outl	= "mpcdr_strk_symb_bg"
	stroke_font     		= "font_MPCDR_stroke"
	stroke_font_outline		= "font_MPCDR_stroke_outline"
	--
	mpcd_symbols_mtl	= "mpcdr_symbols_1_g"	-- MakeMaterial(resources_path_m.."MPCD_Symbols_01.dds", MPCD_GREEN_YELLOW)	-- SYMBOLS PACK
	mpcd_symbols_2_mtl	= "mpcdr_symbols_2_g"	-- MakeMaterial(resources_path_m.."MPCD_Symbols_02.tga", MPCD_GREEN_YELLOW)	-- STRS + TPOD RETICLE PACK
	mpcd_symbols_3_mtl	= "mpcdr_symbols_3"		-- MakeMaterial(resources_path_m.."MPCD_Symbols_03.tga", MPCD_GREEN_YELLOW)	-- RWR + RETICLE PACK
	mpcd_symbols_4_mtl	= "mpcdr_symbols_4"		-- MakeMaterial(resources_path_m.."MPCD_Symbols_04.tga", MPCD_GREEN_YELLOW)	-- LSS/LST RETICLE (TO BE DELETED)
	mpcd_symbols_5_mtl	= "mpcdr_symbols_5"		-- MakeMaterial(resources_path_m.."MPCD_Symbols_05.tga", MPCD_GREEN_YELLOW)	-- AMG-65E RETICLE
	mpcd_symbols_6_mtl	= "mpcdr_symbols_6"		-- MakeMaterial(resources_path_m.."HUD_Symbols.tga", MPCD_GREEN_YELLOW)
	mpcd_tpod_symbols	= "tpod_symbols_R"		-- MakeMaterial(resources_path_m.."TPOD_Symbols_01.tga", MPCD_GREEN_YELLOW)
	
	mpcd_ehsd_nseq_lines_ebg		= "mpcdr_ehsd_dashed_lines_bg"
	mpcd_ehsd_nseq_lines_egr		= "mpcdr_ehsd_dashed_lines_fg"

	---- Fonts Definition ----
	mpcd_tpod_font		= "mpcdr_tpod_font"
	
	mpcd_font_base		= "mpcdr_tpod_font"
	mpcd_font_video		= "mpcdr_tpod_font"
	mpcd_font_night		= "mpcdr_tpod_font"
	mpcd_font_black 	= "mpcdr_tpod_font_bg"
	
	mpcd_font_white		= "mpcdr_tpod_font"
	mpcd_font_tacan		= "mpcdr_tpod_font"	--MPCD_GREEN
	mpcd_font_nav		= "mpcdr_tpod_font"	--MPCD_BLUE
	mpcd_font_hdg		= "mpcdr_tpod_font"	--MPCD_ORANGE
	mpcd_font_warn		= "mpcdr_tpod_font"	--MPCD_RED
	mpcd_font_caut		= "mpcdr_tpod_font"	--MPCD_YELLOW
	
	mpcd_lmav_font		= "mpcdr_lmav_font"
end

---- Fonts Definition ----
MPCD_default_font_size		= {0.0047, 0.0047}
MPCD_data1_font_size		= {0.0060, 0.0060}
MPCD_data2_font_size		= {0.0050, 0.0050}
MPCD_data2_bg_font_size		= {0.0052, 0.0052}
MPCD_small_font_size		= {0.0040, 0.0040}
MPCD_large_font_size		= {0.0070, 0.0070}
MPCD_Xlarge_font_size		= {0.0080, 0.0080}

-- Stroke Fonts
-- WARNING! The only available fonts sizes for MDG stroke symbology are: 100% (20 DI), 120%, 150%, 200%
-- Do not define your own sizes!

-- AV-8B NA MDG DIs (display increments)
glyphNominalHeight100 = 22
glyphNominalWidth100  = 13
glyphAspect = glyphNominalWidth100 / glyphNominalHeight100

glyphNominalHeight120 = glyphNominalHeight100 * 1.2
glyphNominalHeight150 = glyphNominalHeight100 * 1.5
glyphNominalHeight200 = glyphNominalHeight100 * 2

glyphNominalWidth120 = roundDI(glyphNominalWidth100 * 1.2)
glyphNominalWidth150 = glyphNominalWidth100 * 1.5
glyphNominalWidth200 = glyphNominalWidth100 * 2

fontScaleY_100 = glyphNominalHeight100 * GetScale()
fontScaleY_120 = glyphNominalHeight120 * GetScale()
fontScaleY_150 = glyphNominalHeight150 * GetScale()
fontScaleY_200 = glyphNominalHeight200 * GetScale()

fontScaleX_100 = glyphNominalWidth100 * GetScale()
fontScaleX_120 = glyphNominalWidth120 * GetScale()
fontScaleX_150 = glyphNominalWidth150 * GetScale()
fontScaleX_200 = glyphNominalWidth200 * GetScale()

fontIntercharDflt100 		= 5.5		-- 4
fontIntercharDflt120 		= 7.5		-- 6
fontIntercharDflt150 		= 7.5		-- 6
fontIntercharDflt200 		= 13.5	-- 12
fontIntercharDflt120_wide 	= 10.5		-- 9
fontIntercharDflt150_wide 	= 10.5		-- 9

fontInterlineDflt100 		= 5
fontInterlineDflt120 		= 6
fontInterlineDflt150 		= 12
fontInterlineDflt200 		= 12

STROKE_FNT_DFLT_100 		= 1
STROKE_FNT_DFLT_120 		= 2
STROKE_FNT_DFLT_150 		= 3
STROKE_FNT_DFLT_200 		= 4
STROKE_FNT_DFLT_120_WIDE 	= 5
STROKE_FNT_DFLT_150_WIDE 	= 6

stringdefs	= {}
stringdefs[STROKE_FNT_DFLT_100] 		= {fontScaleY_100, fontScaleX_100, fontIntercharDflt100 * GetScale(), fontInterlineDflt100 * GetScale()}
stringdefs[STROKE_FNT_DFLT_120] 		= {fontScaleY_120, fontScaleX_120, fontIntercharDflt120 * GetScale(), fontInterlineDflt120 * GetScale()}
stringdefs[STROKE_FNT_DFLT_150] 		= {fontScaleY_150, fontScaleX_150, fontIntercharDflt150 * GetScale(), fontInterlineDflt150 * GetScale()}
stringdefs[STROKE_FNT_DFLT_200] 		= {fontScaleY_200, fontScaleX_200, fontIntercharDflt200 * GetScale(), fontInterlineDflt200 * GetScale()}
stringdefs[STROKE_FNT_DFLT_120_WIDE] 	= {fontScaleY_120, fontScaleX_120, fontIntercharDflt120_wide * GetScale(), fontInterlineDflt150 * GetScale()}
stringdefs[STROKE_FNT_DFLT_150_WIDE] 	= {fontScaleY_150, fontScaleX_150, fontIntercharDflt150_wide * GetScale(), fontInterlineDflt150 * GetScale()}



----- MPCD Modes -----

mpcd_steering_modes = { EHSD_STR_WPT = 0, EHSD_STR_TCN = 1, EHSD_STR_AWLS = 2, EHSD_STR_WOS = 3, EHSD_STR_TOS = 4, EHSD_STR_DESG_STP = 5, EHSD_STR_DESG_TGT = 6 }

----- MPCD Functions -----
local mpcd_texture_size_x = 1024
local mpcd_texture_size_y = 1024
box_indices = { 0,1,2; 0,2,3 }

function mpcd_texture_box (UL_X,UL_Y,W,H)
	local ux = UL_X / mpcd_texture_size_x
	local uy = UL_Y / mpcd_texture_size_y
	local w  = W / mpcd_texture_size_x
	local h  = H / mpcd_texture_size_y
	return {
		{ux	    ,uy},
		{ux + w ,uy},
		{ux + w ,uy + h},
		{ux	 	,uy + h}
	}
end

function create_mpcd_textured_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y, mat_index_)
	
	local mils_per_pixel = mpcd_scale
	local W 	   		 = DR_X - UL_X
	local H 	   		 = DR_Y - UL_Y
	local cx		     = (UL_X + 0.5 * W)
	local cy		     = (UL_Y + 0.5 * H)
	
	local CENTER_X 		 = CENTER_X or cx
	local CENTER_Y 		 = CENTER_Y or cy
	local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
	local dcy 		     = mils_per_pixel * (CENTER_Y - cy)
	
	local half_x 		 = 0.5 * W * mils_per_pixel
	local half_y 		 = 0.5 * H * mils_per_pixel

	local mat_index      = 1
	
	if mat_index_ ~= nil then
	   mat_index = mat_index_
	end
	
	local obj_material = mpcd_symbols_mtl
	
	if mat_index == 0 then
		obj_material = mpcd_align_mtl
	elseif mat_index >= 1 and mat_index <= 5 then
		obj_material = mpcd_symbols_mtl
	elseif mat_index == 6 then
		obj_material = mpcd_symbols_mtl_w
	elseif mat_index == 7 then
		obj_material = mpcd_symbols_mtl_b
	elseif mat_index == 8 then
		obj_material = mpcd_symbols_5_mtl
	elseif mat_index >= 11 and mat_index <= 15 then
		obj_material = mpcd_symbols_2_mtl
	elseif mat_index >= 21 and mat_index <= 22 then
		obj_material = mpcd_symbols_3_mtl
	elseif mat_index >= 31 and mat_index <= 34 then
		obj_material = mpcd_symbols_4_mtl
	elseif mat_index >= 61 and mat_index <= 62 then
		obj_material = mpcd_symbols_6_mtl
	end
	
	local object	= CreateElement "ceTexPoly"
	object.material	= obj_material
	object.vertices	= {
						{-half_x - dcx, half_y + dcy},
						{ half_x - dcx, half_y + dcy},
						{ half_x - dcx,-half_y + dcy},
						{-half_x - dcx,-half_y + dcy}
	}
	object.tex_coords = mpcd_texture_box(UL_X,UL_Y,W,H)
	object.indices	  = box_indices
	
	return object
end

function create_tpod_textured_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)
	
	local mils_per_pixel = mpcd_scale
	local W 	   		 = DR_X - UL_X
	local H 	   		 = DR_Y - UL_Y
	local cx		     = (UL_X + 0.5 * W)
	local cy		     = (UL_Y + 0.5 * H)
	
	local CENTER_X 		 = CENTER_X or cx
	local CENTER_Y 		 = CENTER_Y or cy
	local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
	local dcy 		     = mils_per_pixel * (CENTER_Y - cy)
	
	local half_x 		 = 0.5 * W * mils_per_pixel
	local half_y 		 = 0.5 * H * mils_per_pixel
	
	local object	= CreateElement "ceTexPoly"
	object.material	= mpcd_tpod_symbols
	object.vertices	= {
						{-half_x - dcx, half_y + dcy},
						{ half_x - dcx, half_y + dcy},
						{ half_x - dcx,-half_y + dcy},
						{-half_x - dcx,-half_y + dcy}
	}
	object.tex_coords = mpcd_texture_box(UL_X,UL_Y,W,H)
	object.indices	  = box_indices
	
	return object
end


function Add_MPCD_Element(object, _alpha_blend)
	local alpha_blending = false
	if _alpha_blend ~= nil then alpha_blending = _alpha_blend end
	
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = MPCD_DEFAULT_LEVEL
	object.additive_alpha     = alpha_blending
	object.collimated 		  = false
	Add(object)
end

function Add_MPCD_VIDEO_Element(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = MPCD_DEFAULT_LEVEL
	object.additive_alpha     = false -- NO additive blending
	object.collimated 		  = false
	Add(object)
end

-- Stroke Functions

function AddMPCDStrokeSymbol(object, _outline, _alpha_blend)
	local alpha_blending = false
	if _alpha_blend ~= nil then alpha_blending = _alpha_blend end
	
	object.alignment		= "FromSet"
	object.isdraw			= true
	object.draw_as_wire 	= dbg_drawStrokesAsWire
	object.use_mipfilter	= true
	object.h_clip_relation	= h_clip_relations.COMPARE
	object.level			= MPCD_DEFAULT_LEVEL
	object.additive_alpha	= alpha_blending
	object.collimated		= false
	
	if _outline ~= nil then
		object.thickness    	= DMC_outline_thickness
		object.fuzziness    	= DMC_outline_fuzziness
	else
		object.thickness    	= stroke_thickness
		object.fuzziness    	= stroke_fuzziness
	end
	
	Add(object)
end

