IndTexture_Path = LockOn_Options.script_path.."Resources/IndicationTextures/EGIT_EGT.dds"
dofile(LockOn_Options.script_path.."Scripts/EGIT/defs.lua")

--------------------------------------- EGT INDICATOR ---------------------------------------
width = 1024     -- Texture size
height = 2048
baseMinX = 185  -- coordinates of the base texture in the tex file
baseMaxX = 495
baseMaxY = 155
baseMinY = 1420

baseMidX = (baseMaxX + baseMinX) / 2
baseMidY = (baseMaxY + baseMinY) / 2
x_to_y_ratio = (baseMaxX - baseMinX) / (baseMinY - baseMaxY)
--size_y = 0.5
--size_x = size_y * x_to_y_ratio
maxVertY = 0.0568 --size_y  --0.0568
maxVertX = maxVertY * x_to_y_ratio * 1 --size_x

-- 'EGIT'Text
calculate_coordinates(290, 410, 210, 152, 290, 410, 210, 152)
add_element(WhiteTexture)

-- 'L Cx100 R'Text
calculate_coordinates(200, 495, 250, 210, 200, 495, 250, 210)
add_element(WhiteTexture)

-- Bars
calculate_coordinates(286, 414, 1425, 265, 286, 414, 1425, 265)
add_element(WhiteTexture)

-- EGT bar left
local EgtBarLeft = CreateElement "ceTexPoly"
    EgtBarLeft.primitivetype	= "triangles"
    EgtBarLeft.vertices =  {{0,0},{0,0},{0,0},{0,0}}
    EgtBarLeft.indices = default_box_indices
    EgtBarLeft.h_clip_relation = h_clip_relations.COMPARE
    EgtBarLeft.level = TV_LEVEL
    EgtBarLeft.name 	= create_guid_string()
    EgtBarLeft.material = WhiteTexture
    EgtBarLeft.init_pos = {0, 0}
    EgtBarLeft.parent_element = grid_origin.name
    EgtBarLeft.controllers = {{"EgtBarLeftControl", maxVertX, maxVertY}}
AddElement(EgtBarLeft)

-- Left chevrons
calculate_coordinates(206, 237, 564, 486, 206, 237, 564, 486)
add_element(WhiteTexture, "EgtChevronsLeft")


-- EGT bar right
local EgtBarRight = CreateElement "ceTexPoly"
    EgtBarRight.primitivetype	= "triangles"
    EgtBarRight.vertices =  {{0,0},{0,0},{0,0},{0,0}}
    EgtBarRight.indices = default_box_indices
    EgtBarRight.h_clip_relation = h_clip_relations.COMPARE
    EgtBarRight.level = TV_LEVEL
    EgtBarRight.name 	= create_guid_string()
    EgtBarRight.material = WhiteTexture
    EgtBarRight.init_pos = {0, 0}
    EgtBarRight.parent_element = grid_origin.name
    EgtBarRight.controllers = {{"EgtBarRightControl", maxVertX, maxVertY}}
AddElement(EgtBarRight)

-- Right chevrons
calculate_coordinates(463, 494, 563, 486, 463, 494, 563, 486)
add_element(WhiteTexture, "EgtChevronsRight")

-- BIT
calculate_coordinates(190, 240, 190, 160, 190, 240, 190, 160)
add_element(WhiteTexture, "BitOnControl")

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

--(minX, maxX, minY, maxY, parentMinX, parentMaxX, parentMinY, parentMaxY)
