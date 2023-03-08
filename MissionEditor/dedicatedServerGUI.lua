--- Dedicated server Game User Interface script
--required for proper DCS utilities start
dofile('./Scripts/UI/initGUI.lua')

local net    = require('net')
local DcsWeb = require('DcsWeb')
local DCS    = require('DCS')
local Tools  = require('tools')
local TableUtils = require('TableUtils')
local OptionsDialog			= require('me_options')

local nickname = ""

-- same for options database
if not me_db then
	OptionsData = require('Options.Data')
	OptionsData.load({})

	me_db = require('me_db_api')
	me_db.create() -- чтение и обработка БД редактора

	-- база данных по плагинам загружается в me_db_api
	-- после ее загрузки можно загрузить настройки для плагинов
	OptionsData.loadPluginsDb()
end

-- load server settings
local defaultSettingsServer = net.get_default_server_settings()

local function loadSettingsRaw()
    local tbl = Tools.safeDoFile(lfs.writedir() .. 'Config/serverSettings.lua', true)
    if (tbl and tbl.cfg) then
        --print('Using merged settings')
        return TableUtils.mergeTables(defaultSettingsServer, tbl.cfg)
    else
        --print('Using default settings')
        return defaultSettingsServer
    end 
end

function loadNicknames()
    nickname = "Server"
    local path = lfs.writedir()..'Config/nicknames.lua'
    local a, errB = lfs.attributes(path)
	if not (a and a.mode == 'file') then
		path = lfs.writedir()..'MissionEditor/nicknames.lua'
		a, errB = lfs.attributes(path)
	end
    if (a and a.mode == 'file')  then
        local f = loadfile(path) 
        if f then    
            local env = {}
            setfenv(f, env)
            local ok, res = pcall(f)
			if not ok then
				log.error('ERROR: loadNicknames() failed to pcall "'..path..'": '..res)
				return
			end
            if env.nicknames[1] then
                nickname = env.nicknames[1]
            end
        end    
    end 
end

-- set local player name
loadNicknames()
net.set_name(nickname)

-- CALLED FROM DCS AFTER MISSION PREREQUISITES LOADED
function onReadyToStartServer()
    -- login if necessary
    if DcsWeb.get_login_status() ~= 200 then
        log.write('Dedicated Server', log.DEBUG, 'Logging in...')
        local res = DcsWeb.make_request('dcs:login')
        if res ~= 200 then
            log.write('Dedicated Server', log.DEBUG, 'Failed to login with code: ', res)
            --log.write('WebGUI', log.DEBUG, DcsWeb.get_data('dcs:login'))
            DCS.exitProcess(1)
            return false
        else
            log.write('Dedicated Server', log.DEBUG, 'Successfully logged in.')
        end
    end

    -- start the server
    local user_script = lfs.writedir()..'Scripts/dedicatedServer.lua'

    if lfs.attributes(user_script,'mode') == 'file' then
        serverSettings = loadSettingsRaw()
        dofile(user_script)
    else        
        local s = loadSettingsRaw()
        if not s or not s.missionList or #s.missionList == 0 then
            log.write('Dedicated Server', log.INFO, 'Mission list is empty, server not started.')
            return false
        end
         --log.write('WebGUI', log.DEBUG, 'Server settings:', s)
        local res = net.start_server(s)
        if res ~= 0 then
            log.write('Dedicated Server', log.DEBUG, 'Failed to start server with code: ', res)
            --DCS.exitProcess(2)
            return false
        end
    end
	
    return true;
end
--- EOF
