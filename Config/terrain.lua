local visibRange = options.graphics.visibRange
local terra_file = "Config/terrain/" .. visibRange .. ".lua"

local cfg = {}
local res, err = env_dofile(cfg, terra_file)
if res then options.graphics.terrain = cfg end
