

local UseSASDebug = false -- Change this to false to remove the SAS symbology

dofile(LockOn_Options.script_path.."HeadUpDisplay/Indicator/definitions.lua")

--local __USE_SCREENSPACE = true

function AddElement(object)
	object.use_mipfilter = true
	object.additive_alpha = true
	object.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	object.level			= HUD_DEFAULT_LEVEL
	Add(object)
end
function AddFullElement(object)
	object.use_mipfilter = true
	object.additive_alpha = true
	object.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	object.level			= HUD_DEFAULT_LEVEL
	Add(object)
end

--------------------------------------------------------------
--- screen space hud
--------------------------------------------------------------
if __USE_SCREENSPACE ~= nil then

function AddElement(object)
	object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = false
    Add(object)
end

end

function AddHUDElement(object)
	AddElement(object) -- <R> some like to call AddHUDElement
end
--------------------------------------------------------------
--------------------------------------------------------------


local BASE_COLOR = {118, 230, 255, 150} -- green {255,255,255,255} -- white local BASE_COLOR = {118, 240, 145, 215} 
local TEST_COLOR = {118, 240, 145, 15}
local TEST_COLOR_2 = {255,0,0,255}

local HUD_MAT= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/hud3.tga",BASE_COLOR)
local TEST_MAT= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/test.tga",TEST_COLOR)
local GLOW_MAT= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/LN_HUDTEX_GLOW.tga",BASE_COLOR)
local TEST_MAT_02= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/hud3.tga",TEST_COLOR_2)
local LADDER_MATERIAL = MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/LN_HUDTEX_HORIZONTAL_01.tga",BASE_COLOR)
local VLINE_MATERIAL = MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/LN_HUDTEX_VERTICAL_01.dds",BASE_COLOR)
local SVLINE_MATERIAL = MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/SmallVLine.dds",BASE_COLOR)
local SHLINE_MATERIAL = MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/SmallHLine.dds",BASE_COLOR)
local FPV_MATERIAL = MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/LN_HUDTEX_FPV_MAIN.tga",BASE_COLOR)
local FPV_FIN_MATERIAL = MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/LN_HUDTEX_FPV_FIN.dds",BASE_COLOR)

local grid_origin	 = CreateElement "ceSimple"
	grid_origin.name = create_guid_string() 
	grid_origin.collimated = true
	grid_origin.init_pos = {00, -0, 0} -- <R> hack, for testing purposes only
AddElement(grid_origin)

local scale = 100.0

if __USE_SCREENSPACE ~= nil then
	scale = 1.0
end

local grid	= CreateElement "ceTexPoly" 
	grid.name 	= create_guid_string() 
	grid.vertices = {{-scale, scale},
					 { scale, scale},
					 { scale,-scale},
					 {-scale,-scale}}
	grid.indices	= {0,1,2,2,3,0}
	grid.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
	grid.material = HUD_MAT	 
	--grid.collimated = true


	grid.parent_element = grid_origin.name
--AddElement(grid)


------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

local texture_size = 1024
local texture_size_x = texture_size
local texture_size_y = texture_size

function texture_box (UL_X,UL_Y,W,H) 
	local ux = UL_X / texture_size_x
	local uy = UL_Y / texture_size_y
	local w = W / texture_size_x
	local h = W / texture_size_y

	return {{ux	 ,uy},
			{ux + w ,uy},
			{ux + w ,uy + h},
			{ux	 	,uy + h}}
end

function create_textured_box(UL_X,UL_Y,DR_X,DR_Y) 
	local size_per_pixel = 1.0 / texture_size * scale
	local W = DR_X - UL_X
	local H = DR_Y - UL_Y

	local half_x = 0.5 * W * size_per_pixel
	local half_y = 0.5 * H * size_per_pixel
	local ux 	 = UL_X / texture_size_x
	local uy 	 = UL_Y / texture_size_y
	local w 	 = W / texture_size_x
	local h 	 = H / texture_size_y

	local object = CreateElement "ceTexPoly"
	object.vertices = {{-half_x, half_y},
						{ half_x, half_y},
						{ half_x,-half_y},
						{-half_x,-half_y}}
	object.indices	 = {0,1,2,2,3,0}
	object.tex_coords = {{ux ,uy},
						 {ux + w ,uy},
						 {ux + w ,uy + h},
						 {ux 	 ,uy + h}}	 
					 
	return object
end

---[[--

local navigation_marker	 = CreateElement "ceSimple"
	navigation_marker.name = create_guid_string() 
	navigation_marker.collimated = true
	navigation_marker.init_pos = {0, 0, 0}
	navigation_marker.parent_element = grid_origin.name
AddElement(navigation_marker)



------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
--16.5454545455 pixels = 1 degree <- Not anymore
local one_degree = 9.05--8.9--9.9104250048--16.5454545455

local outer_height_line_width = 2.1325966851*one_degree--8*0.2363714286
local compass_outer_height_line_width = 1.8*one_degree--8*0.2363714286
local outer_height_line_height = 3*one_degree --181*0.2363714286

local small_outer_height_line_height = 3.1*one_degree --181*0.2363714286

-- Compass numbers of every 10 degrees. Maximum 3 is displayed at any time{93, 168, 119, 255}--
local BASE_COLOR2 = {121, 250, 78, 100}
--local BASE_COLOR2 = {93, 168, 119, 255}--{255  ,255,255,255} -- WHY DOES ONLY WHITE WORK ???? 128,165,0,120 --
--local FONT_         = MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2) --MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
local FONT_         = MakeFont({used_DXUnicodeFontData = "font_ajs37_HUD3"},BASE_COLOR2)--"font_ajs37"},BASE_COLOR2) --MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
--local FONT_         = MakeFont({used_DXUnicodeFontData = LockOn_Options.script_path.."../resources/IndicationTextures/font_ajs37"},BASE_COLOR2,30,"test_font2") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
--local FONTLARGE_         = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
local compassnrheight = 0.005*(0.018/0.009128072)--0.00115
local compassnrwidth = 0.0031*(0.018/0.009128072)--0.00043

local outer_height_line1 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
outer_height_line1.name 	= "outer_height_line1"
outer_height_line1.material = VLINE_MATERIAL
outer_height_line1.vertices   = {{-outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width,-outer_height_line_height},
				   {-outer_height_line_width,-outer_height_line_height}}
outer_height_line1.controllers = {{"height_lines"}}
outer_height_line1.init_pos = {0,0,0}
outer_height_line1.parent_element = navigation_marker.name
AddHUDElement(outer_height_line1)

local outer_height_line2 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
outer_height_line2.name 	= "outer_height_line2"
outer_height_line2.material = VLINE_MATERIAL
outer_height_line2.vertices   = {{-outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width,-outer_height_line_height},
				   {-outer_height_line_width,-outer_height_line_height}}
outer_height_line2.controllers = {{"height_lines"}}
outer_height_line2.init_pos = {0,0,0}
outer_height_line2.parent_element = navigation_marker.name
AddHUDElement(outer_height_line2)

local middle_height_line_width = 2.1325966851*one_degree--8*0.2363714286
local middle_height_line_height = 2*one_degree--111*0.2363714286

local middle_height_line1 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
middle_height_line1.name 	= "middle_height_line1"
middle_height_line1.material = VLINE_MATERIAL
middle_height_line1.vertices   = {{-middle_height_line_width, middle_height_line_height},
				   { middle_height_line_width, middle_height_line_height},
				   { middle_height_line_width,-middle_height_line_height},
				   {-middle_height_line_width,-middle_height_line_height}}
middle_height_line1.controllers = {{"height_lines"}}
middle_height_line1.init_pos = {0,0,0}
middle_height_line1.parent_element = navigation_marker.name
AddHUDElement(middle_height_line1)

local middle_height_line2 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
middle_height_line2.name 	= "middle_height_line2"
middle_height_line2.material = VLINE_MATERIAL
middle_height_line2.vertices   = {{-middle_height_line_width, middle_height_line_height},
				   { middle_height_line_width, middle_height_line_height},
				   { middle_height_line_width,-middle_height_line_height},
				   {-middle_height_line_width,-middle_height_line_height}}
middle_height_line2.controllers = {{"height_lines"}}
middle_height_line2.init_pos = {0,0,0}
middle_height_line2.parent_element = navigation_marker.name
AddHUDElement(middle_height_line2)


local inner_height_line_width = 2.1325966851*one_degree--8*0.2363714286
local inner_height_line_height = 1*one_degree--57*0.2363714286

local inner_height_line1 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
inner_height_line1.name 	= "inner_height_line1"
inner_height_line1.material = VLINE_MATERIAL
inner_height_line1.vertices   = {{-inner_height_line_width, inner_height_line_height},
				   { inner_height_line_width, inner_height_line_height},
				   { inner_height_line_width,-inner_height_line_height},
				   {-inner_height_line_width,-inner_height_line_height}}
inner_height_line1.controllers = {{"height_lines"}}
inner_height_line1.init_pos = {0,0,0}
inner_height_line1.parent_element = navigation_marker.name
AddHUDElement(inner_height_line1)

local inner_height_line2 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
inner_height_line2.name 	= "inner_height_line2"
inner_height_line2.material = VLINE_MATERIAL
inner_height_line2.vertices   = {{-inner_height_line_width, inner_height_line_height},
				   { inner_height_line_width, inner_height_line_height},
				   { inner_height_line_width,-inner_height_line_height},
				   {-inner_height_line_width,-inner_height_line_height}}
inner_height_line2.controllers = {{"height_lines"}}
inner_height_line2.init_pos = {0,0,0}
inner_height_line2.parent_element = navigation_marker.name
AddHUDElement(inner_height_line2)

local artifical_horizon_width = 10*one_degree--559*0.2363714286
local artifical_horizon_height = 3.1325966851*one_degree--6*0.2363714286

local artifical_horizon1 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
artifical_horizon1.name 	= "artifical_horizon1"
artifical_horizon1.material = LADDER_MATERIAL
artifical_horizon1.vertices   = {{-artifical_horizon_width, artifical_horizon_height},
				   { artifical_horizon_width, artifical_horizon_height},
				   { artifical_horizon_width,-artifical_horizon_height},
				   {-artifical_horizon_width,-artifical_horizon_height}}
artifical_horizon1.controllers = {{"artifical_horizon"}}
artifical_horizon1.init_pos = {0,0,0}
artifical_horizon1.parent_element = grid_origin.name
AddHUDElement(artifical_horizon1)

--------------- Test

local hud_glow_width = 20*one_degree--559*0.2363714286
local hud_glow_height = 20*one_degree--6*0.2363714286

local hud_glow01			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
hud_glow01.name 	= "nicks_test01"
hud_glow01.material = GLOW_MAT
hud_glow01.vertices   = {{-hud_glow_width, hud_glow_height },
				   { hud_glow_width, hud_glow_height },
				   { hud_glow_width,-hud_glow_height },
				   {-hud_glow_width,-hud_glow_height }}
hud_glow01.controllers = {{"background"}}
hud_glow01.init_pos = {0,0,0}
hud_glow01.parent_element = grid_origin.name
--AddFullElement(hud_glow01)

----------------- Test --------------------------------------------------------------

local artifical_horizon2			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
artifical_horizon2.name 	= "artifical_horizon2"
artifical_horizon2.material = LADDER_MATERIAL
artifical_horizon2.vertices   = {{-artifical_horizon_width, artifical_horizon_height},
				   { artifical_horizon_width, artifical_horizon_height},
				   { artifical_horizon_width,-artifical_horizon_height},
				   {-artifical_horizon_width,-artifical_horizon_height}}
artifical_horizon2.controllers = {{"artifical_horizon"}}
artifical_horizon2.init_pos = {0,0,0}
artifical_horizon2.parent_element = grid_origin.name
AddHUDElement(artifical_horizon2)

-------------

--They are about 6.5 degrees in width and end at 4 degrees
local five_degree_width =  6.5*one_degree--82.73 --350/5-- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local five_degree_height =  0.7862857143*one_degree--0.4912365526*one_degree--10.16 --43/5--100 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?


local negative_five1			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
	--203+5,--left texture border
	--900-0,--top most texture border 
	--553+10,--right border
	--900+43+10,--down border
	--nil, -- x coordinate of center object (optional )
	--nil  -- y coordinate of center object (optional )
--	)
negative_five1.name 	= "negative_five1"
negative_five1.material = LADDER_MATERIAL
negative_five1.vertices   = {{-five_degree_width, artifical_horizon_height},
				   { five_degree_width, artifical_horizon_height},
				   { five_degree_width,-artifical_horizon_height},
				   {-five_degree_width,-artifical_horizon_height}}
negative_five1.controllers = {{"artifical_horizon"}}
negative_five1.init_pos = {0,0,0}
negative_five1.parent_element = grid_origin.name
AddHUDElement(negative_five1)


local negative_five2			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
negative_five2.name 	= "negative_five2"
negative_five2.material = LADDER_MATERIAL
negative_five2.vertices   = {{-five_degree_width, artifical_horizon_height},
				   { five_degree_width, artifical_horizon_height},
				   { five_degree_width,-artifical_horizon_height},
				   {-five_degree_width,-artifical_horizon_height}}
negative_five2.controllers = {{"artifical_horizon"}}
negative_five2.init_pos = {0,0,0}
negative_five2.parent_element = grid_origin.name
AddHUDElement(negative_five2)


local positive_five1			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
positive_five1.name 	= "positive_five1"
positive_five1.material = LADDER_MATERIAL
positive_five1.vertices   = {{-five_degree_width, artifical_horizon_height},
				   { five_degree_width, artifical_horizon_height},
				   { five_degree_width,-artifical_horizon_height},
				   {-five_degree_width,-artifical_horizon_height}}
positive_five1.controllers = {{"artifical_horizon"}}
positive_five1.init_pos = {0,0,0}
positive_five1.parent_element = grid_origin.name
AddHUDElement(positive_five1)


local positive_five2			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
positive_five2.name 	= "positive_five2"
positive_five2.material = LADDER_MATERIAL
positive_five2.vertices   = {{-five_degree_width, artifical_horizon_height},
				   { five_degree_width, artifical_horizon_height},
				   { five_degree_width,-artifical_horizon_height},
				   {-five_degree_width,-artifical_horizon_height}}
positive_five2.controllers = {{"artifical_horizon"}}
positive_five2.init_pos = {0,0,0}
positive_five2.parent_element = grid_origin.name
AddHUDElement(positive_five2)

-- The +5 and -5 numbers
local artificialhorizonnumber1           = CreateElement "ceStringPoly"
artificialhorizonnumber1.name            = "artificialhorizonnumber1"
artificialhorizonnumber1.material        = FONT_--"font_NAV"
artificialhorizonnumber1.init_pos        = {-0,-0}
artificialhorizonnumber1.alignment       = "CenterCenter"
artificialhorizonnumber1.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
-- compass_numbmarker1.vertices   = {{-outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width,-compass_fimerker_height},
				   -- {-outer_height_line_width,-compass_fimerker_height}}
artificialhorizonnumber1.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_SCRATCHPAD"}
artificialhorizonnumber1.controllers     = {{"artifical_horizon",0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
artificialhorizonnumber1.additive_alpha  = false
artificialhorizonnumber1.collimated     = true
AddHUDElement(artificialhorizonnumber1)

local artificialhorizonnumber2           = CreateElement "ceStringPoly"
artificialhorizonnumber2.name            = "artificialhorizonnumber2"
artificialhorizonnumber2.material        = FONT_--"font_NAV"
artificialhorizonnumber2.init_pos        = {-0,-0}
artificialhorizonnumber2.alignment       = "CenterCenter"
artificialhorizonnumber2.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
-- compass_numbmarker1.vertices   = {{-outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width,-compass_fimerker_height},
				   -- {-outer_height_line_width,-compass_fimerker_height}}
artificialhorizonnumber2.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_SCRATCHPAD"}
artificialhorizonnumber2.controllers     = {{"artifical_horizon",0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
artificialhorizonnumber2.additive_alpha  = false
artificialhorizonnumber2.collimated     = true
AddHUDElement(artificialhorizonnumber2)

local artificialhorizonnumber3           = CreateElement "ceStringPoly"
artificialhorizonnumber3.name            = "artificialhorizonnumber3"
artificialhorizonnumber3.material        = FONT_--"font_NAV"
artificialhorizonnumber3.init_pos        = {-0,-0}
artificialhorizonnumber3.alignment       = "CenterCenter"
artificialhorizonnumber3.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
-- compass_numbmarker1.vertices   = {{-outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width,-compass_fimerker_height},
				   -- {-outer_height_line_width,-compass_fimerker_height}}
artificialhorizonnumber3.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_SCRATCHPAD"}
artificialhorizonnumber3.controllers     = {{"artifical_horizon",0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
artificialhorizonnumber3.additive_alpha  = false
artificialhorizonnumber3.collimated     = true
AddHUDElement(artificialhorizonnumber3)

local artificialhorizonnumber4           = CreateElement "ceStringPoly"
artificialhorizonnumber4.name            = "artificialhorizonnumber4"
artificialhorizonnumber4.material        = FONT_--"font_NAV"
artificialhorizonnumber4.init_pos        = {-0,-0}
artificialhorizonnumber4.alignment       = "CenterCenter"
artificialhorizonnumber4.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
-- compass_numbmarker1.vertices   = {{-outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width,-compass_fimerker_height},
				   -- {-outer_height_line_width,-compass_fimerker_height}}
artificialhorizonnumber4.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_SCRATCHPAD"}
artificialhorizonnumber4.controllers     = {{"artifical_horizon",0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
artificialhorizonnumber4.additive_alpha  = false
artificialhorizonnumber4.collimated     = true
AddHUDElement(artificialhorizonnumber4)


local reference_height_line1 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
reference_height_line1.name 	= "reference_height_line1"
reference_height_line1.material = VLINE_MATERIAL
reference_height_line1.vertices   = {{-outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width,-outer_height_line_height},
				   {-outer_height_line_width,-outer_height_line_height}}
reference_height_line1.controllers = {{"reference_height"}}
reference_height_line1.init_pos = {0,0,0}
reference_height_line1.parent_element = grid_origin.name
AddHUDElement(reference_height_line1)

local reference_height_line2 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
reference_height_line2.name 	= "reference_height_line2"
reference_height_line2.material = VLINE_MATERIAL
reference_height_line2.vertices   = {{-outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width,-outer_height_line_height},
				   {-outer_height_line_width,-outer_height_line_height}}
reference_height_line2.controllers = {{"reference_height"}}
reference_height_line2.init_pos = {0,0,0}
reference_height_line2.parent_element = grid_origin.name
AddHUDElement(reference_height_line2)

local radar_height_width = 0.5*one_degree--58*0.2363714286
local radar_height_height = artifical_horizon_height*0.75 --0.1325966851*one_degree--7*0.2363714286

local radar_height1 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
radar_height1.name 	= "radar_height1"
radar_height1.material = SHLINE_MATERIAL
radar_height1.vertices   = {{-radar_height_width, radar_height_height},
				   { radar_height_width, radar_height_height},
				   { radar_height_width,-radar_height_height},
				   {-radar_height_width,-radar_height_height}}
radar_height1.controllers = {{"radar_height"}}
radar_height1.init_pos = {0,0,0}
radar_height1.parent_element = grid_origin.name
AddHUDElement(radar_height1)

local radar_height2 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
radar_height2.name 	= "radar_height2"
radar_height2.material = SHLINE_MATERIAL
radar_height2.vertices   = {{-radar_height_width, radar_height_height},
				   { radar_height_width, radar_height_height},
				   { radar_height_width,-radar_height_height},
				   {-radar_height_width,-radar_height_height}}
radar_height2.controllers = {{"radar_height"}}
radar_height2.init_pos = {0,0,0}
radar_height2.parent_element = grid_origin.name
AddHUDElement(radar_height2)


local SAS_Debug 			= create_textured_box(507,--left texture border
	348-0,--top most texture border 
	565,--right border
	355,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
SAS_Debug.name 	= "SAS_Debug"
SAS_Debug.material = HUD_MAT
SAS_Debug.vertices   = {{-radar_height_width, radar_height_height},
				   { radar_height_width, radar_height_height},
				   { radar_height_width,-radar_height_height},
				   {-radar_height_width,-radar_height_height}}
SAS_Debug.controllers = {{"SAS_Debug"}}
SAS_Debug.init_pos = {0,0,0}
SAS_Debug.parent_element = grid_origin.name
if UseSASDebug then
AddHUDElement(SAS_Debug)
end


--16.5454545455 pixels = 1 degree

local stretched_horizon_width = 20*one_degree--20*16.5454545455


-- Used in landing mode
local stretched_horizon 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
stretched_horizon.name 	= "stretched_horizon"
stretched_horizon.material = LADDER_MATERIAL
stretched_horizon.vertices   = {{-stretched_horizon_width, artifical_horizon_height},
				   { stretched_horizon_width, artifical_horizon_height},
				   { stretched_horizon_width,-artifical_horizon_height},
				   {-stretched_horizon_width,-artifical_horizon_height}}
stretched_horizon.controllers = {{"artifical_horizon"}}
stretched_horizon.init_pos = {0,0,0}
stretched_horizon.parent_element = grid_origin.name
AddHUDElement(stretched_horizon)


local glide_path_horizon_width = 4*one_degree--4*16.5454545455

-- Used in landing mode
local glide_path_horizon1 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
glide_path_horizon1.name 	= "glide_path_horizon1"
glide_path_horizon1.material = LADDER_MATERIAL
glide_path_horizon1.vertices   = {{-glide_path_horizon_width, artifical_horizon_height},
				   { glide_path_horizon_width, artifical_horizon_height},
				   { glide_path_horizon_width,-artifical_horizon_height},
				   {-glide_path_horizon_width,-artifical_horizon_height}}
glide_path_horizon1.controllers = {{"artifical_horizon"}}
glide_path_horizon1.init_pos = {0,0,0}
glide_path_horizon1.parent_element = grid_origin.name
AddHUDElement(glide_path_horizon1)

local glide_path_horizon2 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
glide_path_horizon2.name 	= "glide_path_horizon2"
glide_path_horizon2.material = LADDER_MATERIAL
glide_path_horizon2.vertices   = {{-glide_path_horizon_width, artifical_horizon_height},
				   { glide_path_horizon_width, artifical_horizon_height},
				   { glide_path_horizon_width,-artifical_horizon_height},
				   {-glide_path_horizon_width,-artifical_horizon_height}}
glide_path_horizon2.controllers = {{"artifical_horizon"}}
glide_path_horizon2.init_pos = {0,0,0}
glide_path_horizon2.parent_element = grid_origin.name
AddHUDElement(glide_path_horizon2)


-- Compass index of every 5 degrees. Maximum 3 is displayed at any time

local compass_fimerker_height = 0.5*one_degree

local compass_fivemarker1 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
compass_fivemarker1.name 	= "compass_fivemarker1"
compass_fivemarker1.material = VLINE_MATERIAL
compass_fivemarker1.vertices   = {{-compass_outer_height_line_width, compass_fimerker_height},
				   { compass_outer_height_line_width, compass_fimerker_height},
				   { compass_outer_height_line_width,-compass_fimerker_height},
				   {-compass_outer_height_line_width,-compass_fimerker_height}}
compass_fivemarker1.controllers = {{"compass"}}
compass_fivemarker1.init_pos = {0,0,0}
compass_fivemarker1.parent_element = grid_origin.name
AddHUDElement(compass_fivemarker1)

local compass_fivemarker2 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
compass_fivemarker2.name 	= "compass_fivemarker2"
compass_fivemarker2.material = VLINE_MATERIAL
compass_fivemarker2.vertices   = {{-compass_outer_height_line_width, compass_fimerker_height},
				   { compass_outer_height_line_width, compass_fimerker_height},
				   { compass_outer_height_line_width,-compass_fimerker_height},
				   {-compass_outer_height_line_width,-compass_fimerker_height}}
compass_fivemarker2.controllers = {{"compass"}}
compass_fivemarker2.init_pos = {0,0,0}
compass_fivemarker2.parent_element = grid_origin.name
AddHUDElement(compass_fivemarker2)

local compass_fivemarker3 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
compass_fivemarker3.name 	= "compass_fivemarker3"
compass_fivemarker3.material = VLINE_MATERIAL
compass_fivemarker3.vertices   = {{-compass_outer_height_line_width, compass_fimerker_height},
				   { compass_outer_height_line_width, compass_fimerker_height},
				   { compass_outer_height_line_width,-compass_fimerker_height},
				   {-compass_outer_height_line_width,-compass_fimerker_height}}
compass_fivemarker3.controllers = {{"compass"}}
compass_fivemarker3.init_pos = {0,0,0}
compass_fivemarker3.parent_element = grid_origin.name
AddHUDElement(compass_fivemarker3)



local compass_numbmarker1           = CreateElement "ceStringPoly"
compass_numbmarker1.name            = "compass_numbmarker1"
compass_numbmarker1.material        = FONT_--"font_NAV"
compass_numbmarker1.init_pos        = {-0,-0}
compass_numbmarker1.alignment       = "CenterCenter"
compass_numbmarker1.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
-- compass_numbmarker1.vertices   = {{-outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width,-compass_fimerker_height},
				   -- {-outer_height_line_width,-compass_fimerker_height}}
compass_numbmarker1.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_SCRATCHPAD"}
compass_numbmarker1.controllers     = {{"compass",0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
compass_numbmarker1.additive_alpha  = false
compass_numbmarker1.collimated     = true
AddHUDElement(compass_numbmarker1)


local compass_numbmarker2           = CreateElement "ceStringPoly"
compass_numbmarker2.name            = "compass_numbmarker2"
compass_numbmarker2.material        = FONT_--"font_NAV"
compass_numbmarker2.init_pos        = {-0,-0}
compass_numbmarker2.alignment       = "CenterCenter"
compass_numbmarker2.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
-- compass_numbmarker2.vertices   = {{-outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width,-compass_fimerker_height},
				   -- {-outer_height_line_width,-compass_fimerker_height}}
compass_numbmarker2.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_SCRATCHPAD"}
compass_numbmarker2.controllers     = {{"compass",0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
compass_numbmarker2.additive_alpha  = false
compass_numbmarker2.collimated     = true
AddHUDElement(compass_numbmarker2)

local compass_numbmarker3           = CreateElement "ceStringPoly"
compass_numbmarker3.name            = "compass_numbmarker3"
compass_numbmarker3.material        = FONT_--"font_NAV"
compass_numbmarker3.init_pos        = {-0,-0}
compass_numbmarker3.alignment       = "CenterCenter"
compass_numbmarker3.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
-- compass_numbmarker3.vertices   = {{-outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width,-compass_fimerker_height},
				   -- {-outer_height_line_width,-compass_fimerker_height}}
compass_numbmarker3.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_SCRATCHPAD"}
compass_numbmarker3.controllers     = {{"compass",0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
compass_numbmarker3.additive_alpha  = false
compass_numbmarker3.collimated     = true
AddHUDElement(compass_numbmarker3)



local vvi_ring_height = 0.51*one_degree
local vvi_ring_width = 0.51*one_degree

local vvi_ring 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
vvi_ring.name 	= "vvi_ring"
vvi_ring.material = FPV_MATERIAL
vvi_ring.vertices   = {{-vvi_ring_width, vvi_ring_height},
				   { vvi_ring_width, vvi_ring_height},
				   { vvi_ring_width,-vvi_ring_height},
				   {-vvi_ring_width,-vvi_ring_height}}
vvi_ring.controllers = {{"velocity_vector"}}
vvi_ring.init_pos = {0,0,0}
vvi_ring.parent_element = grid_origin.name
AddHUDElement(vvi_ring)


local vvi_fin_height = 0.5*one_degree
local vvi_fin_width = 0.75*outer_height_line_width
local vvi_fin 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
vvi_fin.name 	= "vvi_fin"
vvi_fin.material = SVLINE_MATERIAL
vvi_fin.vertices   = {{-vvi_fin_width, vvi_fin_height},
				   { vvi_fin_width, vvi_fin_height},
				   { vvi_fin_width,-vvi_fin_height},
				   {-vvi_fin_width,-vvi_fin_height}}
vvi_fin.controllers = {{"velocity_vector"}}
vvi_fin.init_pos = {0,0,0}
vvi_fin.parent_element = grid_origin.name
AddHUDElement(vvi_fin)


local vvi_wing_height = 0.75*outer_height_line_width
local vvi_wing_width = 0.751*one_degree
local vvi_wing1 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	-1024,--right border
	-1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
vvi_wing1.name 	= "vvi_wing1"
vvi_wing1.material = SHLINE_MATERIAL
vvi_wing1.vertices   = {{-vvi_wing_width, vvi_wing_height},
				   { vvi_wing_width, vvi_wing_height},
				   { vvi_wing_width,-vvi_wing_height},
				   {-vvi_wing_width,-vvi_wing_height}}
vvi_wing1.controllers = {{"velocity_vector"}}
vvi_wing1.init_pos = {0,0,0}
vvi_wing1.parent_element = grid_origin.name
AddHUDElement(vvi_wing1)

local vvi_wing2 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
vvi_wing2.name 	= "vvi_wing2"
vvi_wing2.material = SHLINE_MATERIAL
vvi_wing2.vertices   = {{-vvi_wing_width, vvi_wing_height},
				   { vvi_wing_width, vvi_wing_height},
				   { vvi_wing_width,-vvi_wing_height},
				   {-vvi_wing_width,-vvi_wing_height}}
vvi_wing2.controllers = {{"velocity_vector"}}
vvi_wing2.init_pos = {0,0,0}
vvi_wing2.parent_element = grid_origin.name
AddHUDElement(vvi_wing2)


local distancetimeline_width = 6*one_degree

local distancetimeline 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
distancetimeline.name 	= "distancetimeline"
distancetimeline.material = LADDER_MATERIAL
distancetimeline.vertices   = {{-distancetimeline_width, artifical_horizon_height},
				   { distancetimeline_width, artifical_horizon_height},
				   { distancetimeline_width,-artifical_horizon_height},
				   {-distancetimeline_width,-artifical_horizon_height}}
distancetimeline.controllers = {{"distancetimeline"}}
distancetimeline.init_pos = {0,0,0}
distancetimeline.parent_element = grid_origin.name
AddHUDElement(distancetimeline)

local distancetimelineref_height = 0.5*one_degree

local distancetimelinerefcenter 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
distancetimelinerefcenter.name 	= "distancetimelinerefcenter"
distancetimelinerefcenter.material = SVLINE_MATERIAL
distancetimelinerefcenter.vertices   = {{-outer_height_line_width, distancetimelineref_height},
				   { outer_height_line_width, distancetimelineref_height},
				   { outer_height_line_width,-distancetimelineref_height},
				   {-outer_height_line_width,-distancetimelineref_height}}
distancetimelinerefcenter.controllers = {{"distancetimeline"}}
distancetimelinerefcenter.init_pos = {0,0,0}
distancetimelinerefcenter.parent_element = grid_origin.name
AddHUDElement(distancetimelinerefcenter)

local distancetimelinerefcenterl 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
distancetimelinerefcenterl.name 	= "distancetimelinerefcenterl"
distancetimelinerefcenterl.material = SVLINE_MATERIAL
distancetimelinerefcenterl.vertices   = {{-outer_height_line_width, distancetimelineref_height},
				   { outer_height_line_width, distancetimelineref_height},
				   { outer_height_line_width,-distancetimelineref_height},
				   {-outer_height_line_width,-distancetimelineref_height}}
distancetimelinerefcenterl.controllers = {{"distancetimeline"}}
distancetimelinerefcenterl.init_pos = {0,0,0}
distancetimelinerefcenterl.parent_element = grid_origin.name
AddHUDElement(distancetimelinerefcenterl)

local distancetimelinerefcenterr 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	1024,--right border
	1024,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
distancetimelinerefcenterr.name 	= "distancetimelinerefcenterr"
distancetimelinerefcenterr.material = SVLINE_MATERIAL
distancetimelinerefcenterr.vertices   = {{-outer_height_line_width, distancetimelineref_height},
				   { outer_height_line_width, distancetimelineref_height},
				   { outer_height_line_width,-distancetimelineref_height},
				   {-outer_height_line_width,-distancetimelineref_height}}
distancetimelinerefcenterr.controllers = {{"distancetimeline"}}
distancetimelinerefcenterr.init_pos = {0,0,0}
distancetimelinerefcenterr.parent_element = grid_origin.name
AddHUDElement(distancetimelinerefcenterr)


-- Center dot
local riktprick_width = 0.2*one_degree
local riktprick_height = 0.2*one_degree

local riktprick 			= create_textured_box(806,--left texture border
	146,--top most texture border 
	821,--right border
	159,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
riktprick.name 	= "riktprick"
riktprick.material = HUD_MAT
riktprick.vertices   = {{-riktprick_width, riktprick_height},
				   { riktprick_width, riktprick_height},
				   { riktprick_width,-riktprick_height},
				   {-riktprick_width,-riktprick_height}}
riktprick.controllers = {{"riktprick"}}
riktprick.init_pos = {0,0,0}
riktprick.parent_element = grid_origin.name
AddHUDElement(riktprick)

-- Digital height
local digital_height           = CreateElement "ceStringPoly"
digital_height.name            = "digital_height"
digital_height.material        = FONT_--"font_NAV"
digital_height.init_pos        = {-0,-0}
digital_height.alignment       = "CenterCenter"
digital_height.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
-- compass_numbmarker1.vertices   = {{-outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width, compass_fimerker_height},
				   -- { outer_height_line_width,-compass_fimerker_height},
				   -- {-outer_height_line_width,-compass_fimerker_height}}
digital_height.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_SCRATCHPAD"}
digital_height.controllers     = {{"digital_height",0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
digital_height.additive_alpha  = false
digital_height.collimated     = true
AddHUDElement(digital_height)


