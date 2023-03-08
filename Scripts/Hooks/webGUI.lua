local Tools = require("tools")
local TableUtils = require("TableUtils")
local S = require("Serializer")
local U = require("me_utilities")

function table.slice(tbl, first, last, step)
    local sliced = {}

    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced + 1] = tbl[i]
    end

    return sliced
end

function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

-- load server settings
local defaultSettingsServer = net.get_default_server_settings()

local function loadSettingsRaw()
    local tbl = Tools.safeDoFile(lfs.writedir() .. "Config/serverSettings.lua", false)
    if (tbl and tbl.cfg) then
        return TableUtils.mergeTables(defaultSettingsServer, tbl.cfg)
    else
        return defaultSettingsServer
    end
end

function mergeGuiSettings(new_settings)
    local settings = loadSettingsRaw()

    for k, v in pairs(new_settings) do
        settings[k] = v
    end

    return settings
end

function saveSettings(settings)
    mergedSettings = mergeGuiSettings(settings)
    U.saveInFile(mergedSettings, "cfg", lfs.writedir() .. "Config/serverSettings.lua")
    return true
end

-- API Methods
uri_actions = {}

function uri_actions.getPlayers()
    local result = {
        ["players"] = {
            ["all"] = {},
            ["banned"] = net.banlist_get() or {}
        },
        ["server_id"] = net.get_server_id()
    }

    local playersList = net.get_player_list()
    if playersList ~= nil then
        for k, v in pairs(playersList) do
            result["players"]["all"][tostring(v)] = net.get_player_info(v)
            local score = net.get_stat(v, net.PS_SCORE)
            if score == nil then
                score = 0
            end
            result["players"]["all"][tostring(v)]["score"] = score
        end
        return result
    end
    return {}
end

function uri_actions.changeServerName(params)
    local name = params["name"]
    local id = params["id"]
    local server_id = net.get_server_id()
    if id == server_id then
        local result = net.set_name(name, id)
        local nicknames = safeReadNicknames(lfs.writedir() .. "Config/nicknames.lua")
        local current_nicknames = nicknames["nicknames"]
        table.insert(current_nicknames, 1, name)
        if table.getn(current_nicknames) > 5 then
            local diff = table.getn(current_nicknames) - 5
            for i=1,diff do
                table.remove(current_nicknames)
            end
        end

        U.saveInFile(current_nicknames, "nicknames", lfs.writedir() .. "Config/nicknames.lua")
        return result
    end
end

function uri_actions.getSessionHistory(params)
    local rowid = params["rowid"]
    local min_timestamp = params["min_date"]
    local max_timestamp = params["max_date"]
    local history, last_rowid
    if min_timestamp ~= nil then
        history, last_rowid = net.get_session_history(rowid, min_timestamp, max_timestamp)
    else
        history, last_rowid = net.get_session_history(rowid)
    end

    local result = {
        history = history,
        last_rowid = last_rowid
    }
    return result
end

function uri_actions.makeScreenshot(params)
    local id = params["id"]
    local result = net.screenshot_request(id)
    return result
end

function uri_actions.deleteScreenshot(params)
    local player_id = params["player_id"]
    local key = params["key"]
    local result = net.screenshot_del(player_id, key)
    return result
end

function uri_actions.banPlayer(params)
    local id = params["id"]
    local ucid = params["ucid"]
    local ban_period = params["period"]
    local reason = params["reason"]

    local result = net.banlist_add_by_ucid(ucid, ban_period, reason)
    if result == true then
        if params["id"] ~= nil then
            result = net.kick(id, reason)
        end
    end
    return result
end

function uri_actions.unbanPlayer(params)
    local ucid = params["ucid"]
    local result = net.banlist_remove(ucid)
    return result
end

function uri_actions.kickPlayer(params)
    local id = params["id"]
    local reason = params["reason"]
    local res = net.kick(id, reason)
    if res == nil then
        res = -1
    end
    return res
end

function uri_actions.syncOptionsLua()
    -- Merge options.lua from MissionEditor into User config
    local defaultOptionsTbl = Tools.safeDoFile("./MissionEditor/Data/Scripts/options.lua", true)
    local userOptionsTbl = Tools.safeDoFile(lfs.writedir() .. "Config/options.lua", true)
    local resultTbl = TableUtils.mergeTablesOptions(defaultOptionsTbl, userOptionsTbl, true)
    U.saveInFile(resultTbl["options"], "options", lfs.writedir() .. "Config/options.lua")
    return 0
end

function uri_actions.getServerSettings()
    local settings = loadSettingsRaw()
    local ip = DcsWeb.get_data("dcs:whatsmyip")

    local result = {
        settings = settings,
        ip = ip
    }

    return result
end

function uri_actions.getDefaultServerSettings()
    local settings = loadSettingsRaw()

    local current_missions = net.missionlist_get()

    -- TODO: If settings[missionList] AND no current missions in a list, do stuff
    -- TODO: WHY there would be anything in current_missions when server's not even started? Ask!
    if settings["missionList"] ~= nil and next(current_missions["missionList"]) == nil then
        -- Add to game mission list via net.missionlist_append
        for i, mission in ipairs(settings["missionList"]) do
            local res = net.missionlist_append(mission)
            if res ~= true then
                log.write("WebGUI", log.DEBUG, string.format("Couldn't add misssion %s!", mission))
                result = -1
            end
        end
    end

    settings["listLoop"] = current_missions["listLoop"]
    settings["listShuffle"] = current_missions["listShuffle"]

    local ip = DcsWeb.get_data("dcs:whatsmyip")

    local result = {
        settings = settings,
        ip = ip
    }

    return result
end

function hashPasswords(params)
    if params['redPassword'] ~= nil and params['redPassword'] ~= '' then
        params['redPasswordHash'] = net.hash_password(params['redPassword'])
        params['redPassword'] = nil
    else
        params['redPasswordHash'] = nil
        params['redPassword'] = nil
    end
    if params['bluePassword'] ~= nil and params['bluePassword'] ~= '' then
        params['bluePasswordHash'] = net.hash_password(params['bluePassword'])
        params['bluePassword'] = nil
    else
        params['bluePasswordHash'] = nil
        params['bluePassword'] = nil
    end
end

function uri_actions.setServerSettings(params)
    local settings = params['settings']
    hashPasswords(settings['advanced'])
    local result = saveSettings(settings)
    return result
end

function uri_actions.startServer(params)
    local settings = loadSettingsRaw()
    settings["listStartIndex"] = params["listStartIndex"]
    local nicknames = safeReadNicknames(lfs.writedir() .. "Config/nicknames.lua")
    local server_id = net.get_server_id()
    net.set_name(nicknames["nicknames"][1], server_id)
    local res = net.start_server(settings)

    -- Saving actual mission list and listStartIndex
    local mission_list = net.missionlist_get()
    settings["missionList"] = mission_list["missionList"]
    saveSettings(settings)

    return {
        res = res,
        mission_list = mission_list
    }
end

function uri_actions.stopServer()
    local result = net.stop_game()
    return result
end

function uri_actions.pauseServer()
    local result = DCS.setPause(true)
    return result
end

function uri_actions.resumeServer()
    local result = DCS.setPause(false)
    return result
end

function uri_actions.getSimulatorMode()
    local result = DCS.getSimulatorMode()
    return result
end

function uri_actions.getPauseState()
    local result = DCS.getPause()
    return result
end

function uri_actions.getServerUptime()
    local result = net.get_server_uptime()
    return result
end

function uri_actions.getMissionInfo()
    local result = {
        mission_name = DCS.getMissionName(),
        mission_filename = DCS.getMissionFilename(),
        mission_description = DCS.getMissionDescription(),
        mission_time = DCS.getModelTime(),
        result_red = DCS.getMissionResult("red"),
        result_blue = DCS.getMissionResult("blue")
    }
    return result
end

function uri_actions.getMissionList()
    local result = net.missionlist_get()
    return result
end

function uri_actions.startMission(params)
    local result = net.missionlist_run(params["mission_id"])
    local mission_list = net.missionlist_get()
    saveSettings({
        missionList=mission_list["missionList"],
        listStartIndex=mission_list["listStartIndex"]
    })
    return {
        res = result,
        mission_list = mission_list
    }
end

function uri_actions.restartMission(params)
    local mission_id = params["mission_id"]
    local result = net.missionlist_run(mission_id)
    -- TODO: Frontend expects full mission list here
    return result
end

function uri_actions.stopMission()
    local result = DCS.stopMission()
    return result
end

function uri_actions.deleteMissions(params)
    local result = 0
    local deleted_missions = {}
    for _, mission_id in ipairs(params["missions"]) do
        res = net.missionlist_delete(mission_id)
        if res ~= true then
            log.write(
                "WebGUI",
                log.DEBUG,
                string.format("Couldn't delete mission id %s, res = %s!", tostring(mission_id), tostring(res))
            )
            result = -1
        else
            table.insert(deleted_missions, mission_id)
        end
    end

    local current_missions = net.missionlist_get()
    result = saveSettings({missionList = current_missions["missionList"]})

    return {
        result = result,
        deleted_missions = deleted_missions
    }
end

function uri_actions.addMissions(params)
    local result = 0
    for i, mission in ipairs(params["missions"]) do
        res = net.missionlist_append(mission)
        if res ~= true then
            log.write("WebGUI", log.DEBUG, string.format("Couldn't add mission %s!", mission))
            result = -1
        end
    end
    -- Save current mission list to serverSettings.lua
    local current_missions = net.missionlist_get()
    result = saveSettings({missionList = current_missions["missionList"]})

    return result
end

function uri_actions.saveMissionList(params)
    local filename = params["save_as"]
    local mission_list = params["mission_list"]

    if string.sub(filename, -4) ~= ".lst" then
        filename = filename .. ".lst"
    end

    local result = U.saveInFile(mission_list, "missions", filename)
    return result
end

function uri_actions.loadMissionList(params)
    local mission_list = Tools.safeDoFile(params["list_to_load"], false)

    -- Iterate over current mission list, deleting ALL
    local delete_all_result = net.missionlist_clear()

    -- Now load from .lst file
    -- TODO: Check if file loaded correctly and has 'missions' key-value pair
    for i, mission in ipairs(mission_list["missions"]) do
        result = net.missionlist_append(mission)
    end

    -- Return something. Maybe collect results, if any result falsy, return false, otherwise true
    return true
end

function uri_actions.moveMission(params)
    local old_id = params["id_from"]
    local new_id = params["id_to"]

    result = net.missionlist_move(old_id, new_id)

    --TODO: save new mission list state to serverSettings.lua
    local current_missions = net.missionlist_get()
    saveSettings({
        missionList=current_missions["missionList"],
        listStartIndex=current_missions["listStartIndex"]
    })
    return result
end

function uri_actions.getFileList(params)
    local result
    if params["path"] ~= nil then
        result = getFolder(params["path"], params["fileType"])
    else
        result = getFolder(lfs.writedir() .. "Missions", params["fileType"])
    end
    return result
end

function uri_actions.changeMissionListSettings(params)
    local result = -1
    if params["type"] ~= nil and params["value"] ~= nil then
        if params["type"] == "listLoop" then
            result = net.missionlist_set_loop(params["value"])
            saveSettings({listLoop = params["value"]})
        elseif params["type"] == "listShuffle" then
            result = net.missionlist_set_shuffle(params["value"])
            saveSettings({listShuffle = params["value"]})
        end
    end
    return result
end

function uri_actions.updateChat(params)
    local result = {}
    local id_from = params["id_from"]

    local chatIndex = 0
    local chatHistory = {}
    chatHistory, chatIndex = net.get_chat_history(id_from)

    result = {
        new_last_id = chatIndex,
        chatHistory = chatHistory
    }
    return result
end

function uri_actions.sendChat(params)
    local result = net.send_chat(params["msg"], params["all"])
    return result
end

function uri_actions.sendChatTo(params)
    local result = net.send_chat_to(params["msg"], params["to"])
    return result
end

function uri_actions.updateLog(params)
    local result = {}
    local id_from = params["id_from"]

    local logHistory = {}
    local logIndex = 0
    logHistory, logIndex = DCS.getLogHistory(id_from)
    result = {
        logHistory = logHistory,
        new_last_id = logIndex
    }
    return result
end

function onWebServerRequest(requestString, requestParams)
    --log.write('WebGUI', log.TRACE, string.format('%s called!', requestString))
    requestParams = net.json2lua(requestParams)

    if uri_actions[requestString] ~= nil then
        local result = uri_actions[requestString](requestParams)
        --log.write('WebGUI', log.TRACE, string.format('%s returned %s!', requestString, net.lua2json(result)))
        return net.lua2json(result)
    end

    return net.lua2json(string.format("No such method %s", requestString))
end

function getFolder(path, file_type)
    local function starts_with(str, start)
        return str:sub(1, #start) == start
    end

    local allowed_extension = {
        ["mission"] = ".miz",
        ["missionList"] = ".lst"
    }
    local result = {}

    local saved_games_path = string.match(lfs.writedir(), "(.-Saved Games).*$")
    if starts_with(path, saved_games_path) == false then
        path = saved_games_path
    end
    result["root"] = path
    result["files"] = {}
    result["dirs"] = {}
    result["topDir"] = saved_games_path

    for file in lfs.dir(path) do
        if not (file == "." or file == "..") then
            local f = path .. "\\" .. file -- Abspath for a file (might be useful)
            local attr = lfs.attributes(f) -- Getting attributes
            if type(attr) == "table" then
                if attr.mode == "directory" then
                    table.insert(result["dirs"], {name = file, abspath = f, last_modified = attr.modification})
                elseif string.sub(file, -4) == allowed_extension[file_type] then
                    table.insert(result["files"], {name = file, abspath = f, last_modified = attr.modification})
                end
            end
        end
    end

    return result
end

function safeReadNicknames(path)
    local nicknames = Tools.safeDoFile(path, false)
    --log.write('WebGUI', log.DEBUG, string.format("Reading nicknames.lua: %s", net.lua2json(nicknames)))
    if next(nicknames) == nil then
        log.write('WebGUI', log.DEBUG, "nicknames.lua is empty, creating new")
        U.saveInFile({'Server'}, "nicknames", path)
        nicknames = Tools.safeDoFile(path, false)
    end
    return nicknames
end

local webCallbacks = {}
webCallbacks.onWebServerRequest = onWebServerRequest
DCS.setUserCallbacks(webCallbacks)
