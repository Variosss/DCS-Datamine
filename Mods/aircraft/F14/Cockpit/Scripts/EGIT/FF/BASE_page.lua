IndTexture_Path = LockOn_Options.script_path.."Resources/IndicationTextures/EGIT_FF.dds"
dofile(LockOn_Options.script_path.."Scripts/EGIT/defs.lua")

--------------------------------------- FF INDICATOR ---------------------------------------
width = 1024     -- Texture size
height = 2048
baseMinX = 210  -- coordinates of the base texture in the tex file
baseMaxX = 490
baseMaxY = 152
baseMinY = 1421

baseMidX = (baseMaxX + baseMinX) / 2
baseMidY = (baseMaxY + baseMinY) / 2
x_to_y_ratio = (baseMaxX - baseMinX) / (baseMinY - baseMaxY)
--size_y = 0.5
--size_x = size_y * x_to_y_ratio
maxVertY = 0.0568 --size_y
maxVertX = maxVertY * x_to_y_ratio * 1 --size_x


-- UpperText
calculate_coordinates(210, 490, 250, 150, 210, 490, 250, 150)
add_element(WhiteTexture)

-- Bars
calculate_coordinates(286, 414, 1425, 265, 286, 414, 1425, 265)
add_element(WhiteTexture)

-- FF bar left
local FFBarLeft = CreateElement "ceTexPoly"
    FFBarLeft.primitivetype	= "triangles"
    FFBarLeft.vertices =  {{0,0},{0,0},{0,0},{0,0}}
    FFBarLeft.indices = default_box_indices
    FFBarLeft.h_clip_relation = h_clip_relations.COMPARE
    FFBarLeft.level = TV_LEVEL
    FFBarLeft.name 	= create_guid_string()
    FFBarLeft.material = WhiteTexture
    FFBarLeft.init_pos = {0, 0}
    FFBarLeft.parent_element = grid_origin.name
    FFBarLeft.controllers = {{"FfBarLeftControl", maxVertX, maxVertY}}
AddElement(FFBarLeft)

-- FF bar right
local FFBarRight = CreateElement "ceTexPoly"
    FFBarRight.primitivetype	= "triangles"
    FFBarRight.vertices =  {{0,0},{0,0},{0,0},{0,0}}
    FFBarRight.indices = default_box_indices
    FFBarRight.h_clip_relation = h_clip_relations.COMPARE
    FFBarRight.level = TV_LEVEL
    FFBarRight.name 	= create_guid_string()
    FFBarRight.material = WhiteTexture
    FFBarRight.init_pos = {0, 0}
    FFBarRight.parent_element = grid_origin.name
    FFBarRight.controllers = {{"FfBarRightControl", maxVertX, maxVertY}}
AddElement(FFBarRight)

---- Backlight
local BacklightTex = create_textured_box(baseMinX, baseMaxY, baseMaxX, baseMinY, width, height)
    BacklightTex.name 	= create_guid_string()
    BacklightTex.material = BacklightTexture
    BacklightTex.init_pos = {0,0}
    BacklightTex.alignment = "CenterCenter"
    BacklightTex.parent_element = grid_origin.name
    BacklightTex.controllers = {{"BacklightBrightnessControl"}}
    BacklightTex.vertices = { {-maxVertX, maxVertY},
							{maxVertX, maxVertY},
							{ maxVertX, -maxVertY},
							{-maxVertX, -maxVertY}} 
AddElement(BacklightTex)
