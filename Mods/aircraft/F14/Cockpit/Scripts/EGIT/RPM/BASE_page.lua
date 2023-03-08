IndTexture_Path = LockOn_Options.script_path.."Resources/IndicationTextures/EGIT_RPM.dds"
dofile(LockOn_Options.script_path.."Scripts/EGIT/defs.lua")

--------------------------------------- RPM INDICATOR ---------------------------------------
width = 1024     -- Texture size
height = 2048
baseMinX = 205  -- coordinates of the base texture in the tex file
baseMaxX = 495
baseMaxY = 155
baseMinY = 1420

baseMidX = (baseMaxX + baseMinX) / 2
baseMidY = (baseMaxY + baseMinY) / 2
local x_to_y_ratio = (baseMaxX - baseMinX) / (baseMinY - baseMaxY)
--size_y = 0.5
-- size_x = size_y * x_to_y_ratio
maxVertY = 0.0568 -- size_y
maxVertX = maxVertY * x_to_y_ratio --size_x


---- Base texture
--[[
local BaseTex = create_textured_box(baseMinX, baseMaxY, baseMaxX, baseMinY, width, height)
    BaseTex.name 	= create_guid_string()
    BaseTex.material = BaseTexture
    BaseTex.init_pos = {0,0}
    BaseTex.parent_element = grid_origin.name
    BaseTex.alignment = "CenterCenter"
    BaseTex.isdraw = true
    BaseTex.use_mipfilter = true
 --   BaseTex.additive_alpha = false
    BaseTex.vertices = { {-maxVertX, maxVertY},
							{maxVertX, maxVertY},
							{ maxVertX, -maxVertY},
							{-maxVertX, -maxVertY}} 
AddElement(BaseTex)
]]--

-- UpperText
calculate_coordinates(207, 487, 250, 155, 207, 487, 250, 155)
add_element(WhiteTexture)

-- Bars
calculate_coordinates(286, 414, 1425, 265, 286, 414, 1425, 265)
add_element(WhiteTexture)

-- RPM bar left
local RpmBarLeft = CreateElement "ceTexPoly"
    RpmBarLeft.primitivetype	= "triangles"
    RpmBarLeft.vertices =  {{0,0},{0,0},{0,0},{0,0}}
    RpmBarLeft.indices = default_box_indices
    RpmBarLeft.h_clip_relation = h_clip_relations.COMPARE
    RpmBarLeft.level = TV_LEVEL
    RpmBarLeft.name 	= create_guid_string()
    RpmBarLeft.material = WhiteTexture
    RpmBarLeft.init_pos = {0, 0}
    RpmBarLeft.parent_element = grid_origin.name
    RpmBarLeft.controllers = {{"RpmBarLeftControl", maxVertX, maxVertY}}
AddElement(RpmBarLeft)

-- 20% RPM horizontal bar left
calculate_coordinates(206, 239, 1325, 1314, 206, 239, 1325, 1314)
add_element(WhiteTexture, "RpmEngStartBarLeft")

-- Lower chevron left
calculate_coordinates(206, 237, 363, 322, 206, 237, 363, 322)
add_element(WhiteTexture, "RpmChevronLowerLeft")

-- Upper chevron left
calculate_coordinates(206, 237, 323, 285, 206, 237, 323, 285)
add_element(WhiteTexture, "RpmChevronUpperLeft")

-- RPM bar right
local RpmBarRight = CreateElement "ceTexPoly"
    RpmBarRight.primitivetype	= "triangles"
    RpmBarRight.vertices =  {{0,0},{0,0},{0,0},{0,0}}
    RpmBarRight.indices = default_box_indices
    RpmBarRight.h_clip_relation = h_clip_relations.COMPARE
    RpmBarRight.level = TV_LEVEL
    RpmBarRight.name 	= create_guid_string()
    RpmBarRight.material = WhiteTexture
    RpmBarRight.init_pos = {0, 0}
    RpmBarRight.parent_element = grid_origin.name
    RpmBarRight.controllers = {{"RpmBarRightControl", maxVertX, maxVertY}}
AddElement(RpmBarRight)

-- 20% RPM horizontal bar right
calculate_coordinates(461, 495, 1325, 1314, 461, 495, 1325, 1314)
add_element(WhiteTexture, "RpmEngStartBarRight")

-- Lower chevron right
calculate_coordinates(463, 494, 362, 324, 463, 494, 362, 324)
add_element(WhiteTexture, "RpmChevronLowerRight")

-- Upper chevron right
calculate_coordinates(463, 494, 322, 284, 463, 494, 322, 284)
add_element(WhiteTexture, "RpmChevronUpperRight")

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
