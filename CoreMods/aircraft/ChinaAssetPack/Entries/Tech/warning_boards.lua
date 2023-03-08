local function add_fortification(f)
    if (f) then
        f.shape_table_data = 
        {
            {
                file        = f.ShapeName,
                life        = f.Life,
                username    = f.Name,
                desrt       = f.ShapeNameDestr or "self",
                classname   = f.classname   or "lLandVehicle",
                positioning = f.positioning or "ONLYHEIGTH" --available: {"BYNORMAL", "ONLYHEIGTH", "BY_XZ", "ADD_HEIGTH"}
            }
        }
        if f.ShapeNameDestr then
            f.shape_table_data[#f.shape_table_data + 1] = 
            {
                name  = f.ShapeName,
                file  = f.ShapeNameDestr,    
            }
        end
        
        f.mapclasskey = "P0091000035";
        f.attribute = {wsType_Static, wsType_Standing} -- if 'attribute' == nil then insertion will be aborted
        
        add_surface_unit(f)
        GT = nil
    else
        error("Can't add fortification")
    end
end

-- Warning Board 01
add_fortification({
    Name         = "warning_board_a",
    DisplayName  = _("Warning Board: Spy Cannot Escape!"),
    ShapeName    = "biaoyu",
    Life         = 1,
    Rate         = 1,
    desrt        = "self",
    category     = 'Fortification',
    SeaObject    = false,
    isPutToWater = false,
    positioning  = "ONLYHEIGTH",
    classname    = "lStandartStructure",
    Countries    = {'China'},
})

-- Warning Board 02
add_fortification({
    Name         = "warning_board_b",
    DisplayName  = _("Warning Board: Catch Spy!"),
    ShapeName    = "biaoyu-2",
    Life         = 1,
    Rate         = 1,
    desrt        = "self",
    category     = 'Fortification',
    SeaObject    = false,
    isPutToWater = false,
    positioning  = "ONLYHEIGTH",
    classname    = "lStandartStructure",
    Countries    = {'China'},
})
