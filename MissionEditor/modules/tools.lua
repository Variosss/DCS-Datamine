-- GUI-independed helper functions

local base = _G

module('tools')

local log      = base.require('log')

-- load file in empty environment and returns that environment
function safeDoFile(filename, a_showError)   	
    local f,err = base.loadfile(filename)
    if not f then
        if (a_showError ~= false) then  
            --base.print(base.debug.traceback())
            base.print("ERROR: safeDoFile() file not found!", err)
        end
        return { }
    end
    local env = {_ = function(p) return p end} -- ;
    base.setfenv(f, env)
	local ok, res = base.pcall(f)
	if not ok then
		log.error('ERROR: safeDoFile() failed to pcall "'..filename..'": '..res)
	end
    env._ = nil;
    return env
end

function safeDoFileWithEnv(filename)
    local f,err = base.loadfile(filename)
    if not f then
        base.print("ERROR: safeDoFileWithRequire() file not found!", err)
        return { }
    end
    local env = {base = base}
    base.setfenv(f, env)
    local ok, res = base.pcall(f)
	if not ok then
		log.error('ERROR: safeDoFileWithEnv() failed to pcall "'..filename..'": '..res)
		return
	end
	env.base = nil
    return env
end

function safeDoFileWithRequire(filename)
    local f,err = base.loadfile(filename)
    if not f then
        base.print("ERROR: safeDoFileWithRequire() file not found!", err)
        return { }
    end
    local env = {require = base.require,
                table = base.table, 
                pairs = base.pairs,
				ipairs = base.ipairs,
                print = base.print
                }
    base.setfenv(f, env)
    local ok, res = base.pcall(f)
	if not ok then
		log.error('ERROR: safeDoFileWithRequire() failed to pcall "'..filename..'": '..res)
		return
	end
    return env
end

function safeDoFileWithDofile(filename)
    local f,err = base.loadfile(filename)
    if not f then
        base.print("ERROR: safeDoFileWithDofile() file not found!", err)
        return { }
    end
    local env = {table = base.table, 
                pairs = base.pairs,
                type = base.type,
                assert = base.assert,
                print = base.print,
                math = base.math,
                tostring = base.tostring,
                module = base.module,
				require = base.require,
				package = base.package,
				loadfile = base.loadfile,
				setfenv = base.setfenv,
				pcall	= base.pcall,
				string = base.string,
				ipairs = base.ipairs,
				io = base.io,
                }
    env['_G'] = env
    
    env.dofile = function(n) f2, err = base.loadfile(n); if f2 then base.setfenv(f2, env); f2() end end

    base.setfenv(f, env)
    local ok, res = base.pcall(f)
	if not ok then
		log.error('ERROR: safeDoFileWithRequire() failed to pcall "'..filename..'": '..res)
		return
	end
    return env
end