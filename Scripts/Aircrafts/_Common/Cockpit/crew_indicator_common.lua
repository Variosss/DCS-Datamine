-- definitions common for crew_indicator
dofile(LockOn_Options.common_script_path .. "elements_defs.lua")

function AddElement ( object )
    object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end



function getTextureCoordsFromPixelCoords ( Left, Top, Right, Bottom, TextureHorizontalSizeInPixels, TextureVerticalSizeInPixels )
    return {{Left/TextureHorizontalSizeInPixels, Bottom/TextureVerticalSizeInPixels}, {Left/TextureHorizontalSizeInPixels, Top/TextureVerticalSizeInPixels}, {Right/TextureHorizontalSizeInPixels, Top/TextureVerticalSizeInPixels}, {Right/TextureHorizontalSizeInPixels, Bottom/TextureVerticalSizeInPixels}}
end



aspect          = LockOn_Options.screen.aspect
size            = 0.3



texture_icons = MakeMaterial("Bazar/Textures/AvionicsCommon/crew_roles.tga", {255, 255, 255, 192})
texture_hull  = MakeMaterial(LockOn_Options.script_path .. "../IndicationTextures/crew_hull.tga", {255, 255, 255, 164})
FONT_         = MakeFont({used_DXUnicodeFontData = "font_dejavu_lgc_sans_22"}, {0, 0, 0, 255})
backdrop      = MakeMaterial(nil, {0x2f, 0x61, 0x86, 0xcc})
role_icons = {
    getTextureCoordsFromPixelCoords(0, 0, 0, 0, 5, 4), -- Unspecified
    getTextureCoordsFromPixelCoords(0, 1, 1, 2, 5, 4), -- Driver
    getTextureCoordsFromPixelCoords(2, 1, 3, 2, 5, 4), -- Bombardier
    getTextureCoordsFromPixelCoords(1, 1, 2, 2, 5, 4), -- CraneOperator
    getTextureCoordsFromPixelCoords(0, 2, 1, 3, 5, 4), -- Gunner_Disabled
    getTextureCoordsFromPixelCoords(1, 2, 2, 3, 5, 4), -- Gunner_ReturnFire
    getTextureCoordsFromPixelCoords(2, 2, 3, 3, 5, 4), -- Gunner_ReturnFire_FangsOut
    getTextureCoordsFromPixelCoords(3, 2, 4, 3, 5, 4), -- Gunner_FreeFire
    getTextureCoordsFromPixelCoords(4, 2, 5, 3, 5, 4), -- Gunner_FreeFire_FangsOut
}
cabin_icons = {
    getTextureCoordsFromPixelCoords(0, 0, 0, 0, 5, 4), -- Removed
    getTextureCoordsFromPixelCoords(0, 0, 1, 1, 5, 4), -- Disabled
    getTextureCoordsFromPixelCoords(1, 0, 2, 1, 5, 4), -- Restricted
    getTextureCoordsFromPixelCoords(2, 0, 3, 1, 5, 4), -- Available
    getTextureCoordsFromPixelCoords(3, 0, 4, 1, 5, 4), -- Occupied
    getTextureCoordsFromPixelCoords(4, 0, 5, 1, 5, 4), -- Manned
}



base                 = CreateElement "ceSimple" --"ceMeshPoly"
base.name            = "BASE"
base.primitivetype   = "triangles"
base.material        = backdrop
base.vertices        = {{0.0, -size},
                        {0.0, 0.0}, 
                        {0.5 * size, 0.0},
                        {0.5 * size, -size}}
base.indices         = default_box_indices
base.init_pos        = {-aspect, -1.0 + size + 0.0525}
base.controllers     = {{"show"},}
base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
base.level           = DEFAULT_LEVEL
AddElement(base)

hull                = CreateElement "ceTexPoly"
hull.name           = "HULL"
hull.vertices       = {{0.0, -size},
                       {0.0, 0.0}, 
                       {0.5 * size, 0.0},
                       {0.5 * size, -size}}
hull.indices        = default_box_indices
hull.material       = texture_hull
hull.tex_coords     = {{0,1},{0,0},{1,0},{1,1}}
hull.parent_element = base.name
--hull.init_pos       = {-aspect, -1 + size + 0.0525}
AddElement(hull)



function populate ( cabins, hull_icons_displacements, hull_icons_scale_factor_, lines_count_ )
    local lines_count     = lines_count_ or 6
    local lines_icon_size = size / lines_count
    local hull_icons_scale_factor_ = hull_icons_scale_factor_ or 1.0
    local hull_icons_size = hull_icons_scale_factor_ * lines_icon_size
    local txt_size        = 0.08 * lines_icon_size

    local list_base          = CreateElement "ceSimple"
    list_base.name           = "LIST_BASE"
    list_base.init_pos       = {0.5 * size + 1.0 * lines_icon_size, (-lines_count + cabins - 0.5) * lines_icon_size}
    list_base.parent_element = hull.name
    list_base.controllers    = {{"list_origin", lines_icon_size}}
    AddElement(list_base)

    local y = 0.0
    for i = 0, cabins-1 do
        local hull_cabin_icon            = CreateElement "ceTexPoly"
        hull_cabin_icon.name             = "HULL_CABIN_ICON_" .. i
        hull_cabin_icon.vertices         = {{-0.5 * hull_icons_size, -0.5 * hull_icons_size},
                                            {-0.5 * hull_icons_size,  0.5 * hull_icons_size},
                                            { 0.5 * hull_icons_size,  0.5 * hull_icons_size},
                                            { 0.5 * hull_icons_size, -0.5 * hull_icons_size}}
        hull_cabin_icon.indices          = default_box_indices
        hull_cabin_icon.material         = texture_icons
        hull_cabin_icon.state_tex_coords = cabin_icons
        hull_cabin_icon.init_pos         = {hull_icons_displacements[i+1][1] * 0.5 * size, hull_icons_displacements[i+1][2] * size}
        hull_cabin_icon.parent_element   = hull.name
        if hull_icons_displacements[i+1][3] then
            hull_cabin_icon.controllers  = {{"cabin_icon", i}, unpack(hull_icons_displacements[i+1][3])}
        else
            hull_cabin_icon.controllers  = {{"cabin_icon", i}}
        end
        AddElement(hull_cabin_icon)

        local hull_cabin_index          = CreateElement "ceStringPoly"
        hull_cabin_index.name           = "HULL_CABIN_INDEX" .. i
        hull_cabin_index.material       = FONT_
        hull_cabin_index.alignment      = "CenterCenter"
        hull_cabin_index.stringdefs     = {hull_icons_scale_factor_ * 0.75 * txt_size, hull_icons_scale_factor_ * 0.75 * 0.25 * txt_size, 0.0, 0.0}
        hull_cabin_index.value          = "?"
        hull_cabin_index.parent_element = hull_cabin_icon.name
        hull_cabin_index.controllers    = {{"cabin_index", i}}
        AddElement(hull_cabin_index)

        local list_cabin_icon          = Copy(hull_cabin_icon)
        list_cabin_icon.name           = "LIST_CABIN_ICON_" .. i
        list_cabin_icon.vertices       = {{-0.5 * lines_icon_size, -0.5 * lines_icon_size},
                                          {-0.5 * lines_icon_size,  0.5 * lines_icon_size},
                                          { 0.5 * lines_icon_size,  0.5 * lines_icon_size},
                                          { 0.5 * lines_icon_size, -0.5 * lines_icon_size}}
        list_cabin_icon.init_pos       = {0.0, y}
        list_cabin_icon.controllers    = {{"cabin_icon", i}}
        list_cabin_icon.parent_element = list_base.name
        AddElement(list_cabin_icon)

        local list_cabin_index          = Copy(hull_cabin_index)
        list_cabin_index.name           = "LIST_CABIN_INDEX_" .. i
        list_cabin_index.stringdefs     = {0.75 * txt_size, 0.75 * 0.25 * txt_size, 0.0, 0.0}
        list_cabin_index.parent_element = list_cabin_icon.name
        AddElement(list_cabin_index)

        local list_operator          = CreateElement "ceStringPoly"
        list_operator.name           = "LIST_OPERATOR_" .. i
        list_operator.material       = FONT_
        list_operator.init_pos       = {0.5 * lines_icon_size, 0.0}
        list_operator.alignment      = "LeftCenter"
        list_operator.stringdefs     = {txt_size, 0.25 * txt_size, 0.0, 0.0}
        list_operator.value          = "AI"
        list_operator.parent_element = list_cabin_icon.name
        list_operator.controllers    = {{"operator_name", i},}
        AddElement(list_operator)

        local list_role_icon            = CreateElement "ceTexPoly"
        list_role_icon.name             = "LIST_ROLE_ICON_" .. i
        list_role_icon.vertices         = {{-0.5 * lines_icon_size, -0.5 * lines_icon_size},
                                           {-0.5 * lines_icon_size,  0.5 * lines_icon_size},
                                           { 0.5 * lines_icon_size,  0.5 * lines_icon_size},
                                           { 0.5 * lines_icon_size, -0.5 * lines_icon_size}}
        list_role_icon.indices          = default_box_indices
        list_role_icon.material         = texture_icons
        list_role_icon.state_tex_coords = role_icons
        list_role_icon.init_pos         = {-lines_icon_size, 0.0}
        list_role_icon.parent_element   = list_cabin_icon.name
        list_role_icon.controllers      = {{"role_icon", i},}
        AddElement(list_role_icon)

        y = y - lines_icon_size
    end
end