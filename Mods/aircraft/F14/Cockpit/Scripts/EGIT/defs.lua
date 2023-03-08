dofile(LockOn_Options.common_script_path.."devices_defs.lua")

dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")

INDICATOR_LEVEL = EGIT_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."fonts.lua")
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

--

-----------------------

BaseTexture = MakeMaterial(IndTexture_Path, {15, 15, 20, 1}) 
BacklightTexture = MakeMaterial(IndTexture_Path, {150, 5, 3, 20}) --115, 80, 90, 100 
WhiteTexture = MakeMaterial(IndTexture_Path, {80, 80, 80, 170}) 

function AddElement(object)
  --  object.screenspace = ScreenType.SCREENSPACE_TRUE
	object.use_mipfilter = true
	object.additive_alpha = true
    Add(object)
end

grid_origin = create_origin()
    grid_origin.init_pos = {0, 0}
    grid_origin.controllers = {{"PowerOnControl"}}

-------------------------- functions ----------------------------
function calculate_coordinates(minX, maxX, minY, maxY, parentMinX, parentMaxX, parentMinY, parentMaxY)
    vertDown = - maxVertY * (parentMaxY - baseMidY) / (baseMinY - baseMidY)
    vertLeft = maxVertX * (parentMinX - baseMidX) / (baseMidX - baseMinX)
    vertRight = maxVertX * (parentMaxX - baseMidX) / (baseMaxX - baseMidX)
    vertUp = maxVertY * (parentMinY - baseMidY) / (baseMaxY - baseMidY)

    uvDown = minY / height
    uvLeft = minX / width
    uvRight = maxX / width
    uvUp = maxY /height
end

function add_element(texture, controller_name_str)
    local newElement = CreateElement "ceTexPoly"
        newElement.primitivetype	= "triangles"
        newElement.indices = default_box_indices
        newElement.h_clip_relation = h_clip_relations.COMPARE
        newElement.level = TV_LEVEL
        newElement.name 	= create_guid_string()
        newElement.material = texture
        newElement.init_pos = {0, 0}
        newElement.parent_element = grid_origin.name
        newElement.vertices = { {vertLeft, vertUp},
                                {vertRight, vertUp},
                                {vertRight, vertDown},
                                {vertLeft, vertDown}} 
        newElement.tex_coords = {{uvLeft , uvDown},
                            {uvRight , uvDown},
                            {uvRight , uvUp},
                            {uvLeft , uvUp}}
        newElement.controllers = {{controller_name_str}}
    AddElement(newElement)
end