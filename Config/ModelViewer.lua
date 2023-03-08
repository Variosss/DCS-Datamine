dofile("Config/ModelViewer_main.cfg")

local pretty = require("pretty")

modelViewer = {}
local opts_file = lfs.writedir() .. 'Config/ModelViewer.cfg'
if lfs.attributes(opts_file, 'mode') then
    env_dofile(modelViewer, opts_file)
end

-- patch options after loading
if modelViewer.resolution then
    print("replacing dcs options")
    options.graphics.width = modelViewer.resolution[1]
    options.graphics.height = modelViewer.resolution[2]
else
    print("using dcs options")
    modelViewer.resolution = {
        options.graphics.width,
        options.graphics.height
    }
end

options.graphics.Plugins =
{
    "NGModel",
    "animator",
}

function save_config()
    local cfg = io.open(opts_file, 'w')
    cfg:write(pretty.tostring(modelViewer))
    cfg:close()
end


print("Loaded!")
