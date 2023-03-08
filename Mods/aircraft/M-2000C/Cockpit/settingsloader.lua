local lfs               = require('lfs')

function load_if_exists(path)   	
    local f,err = loadfile(path)
    if not f then
        return { }
    end
    local env = {_ = function(p) return p end} -- ;
    setfenv(f, env)
	local ok, res = pcall(f)
    env._ = nil;
    return env
end


function settingsloader(filename)   	
	local result = {}
	local t = {}

	t = load_if_exists(LockOn_Options.script_path..filename)
	if (t and type(t) == "table") then
		for key, value in pairs(t) do
			result[key] = value
		end
	end

    t = load_if_exists(lfs.writedir() .. "Config/M-2000C/"..filename)
	if (t and type(t) == "table") then
		print("M-2000C custom configuration found for "..filename)
		for key, value in pairs(t) do
			result[key] = value
		end
	end
	
	
	return result
end