local base = _G

module('me_updater')

local require   = base.require
local os        = base.os

local lfs 	    = require('lfs')
local Gui 	    = require('dxgui')
local minizip   = require('minizip')
local MsgWindow = require('MsgWindow')
local i18n 		= require('i18n')

i18n.setup(_M)

addInterrelated = {}
listComp = {}

function init()
    JSON = (base.loadfile "Scripts/JSON.lua")()
    loadListComponents()
end


function loadListComponents()
    local file = base.io.open('autoupdate.cfg', 'rb')
    if file then
        local s = file:read('*a')
        local lua_value = JSON:decode(s)
        listComp = lua_value.modules or {}
        
        local exclusive_modules = lua_value.exclusive_modules or {}
        for k,v in base.pairs(exclusive_modules) do
            for _tmp, vv in base.pairs(v) do
                addInterrelated[vv] = v
            end
        end
        
        file:close()
    end    
end

function decodeJSON(a_str)
    return JSON:decode(a_str)
end

function Quit()
    base.START_PARAMS.missionPath = ''
    base.START_PARAMS.campaign = ''
    base.START_PARAMS.realMissionPath = ''
    base.START_PARAMS.command = '--quit'
    base.START_PARAMS.returnScreen = ''
    
    Gui.doQuit()
end

function installComponent(a_name)
	local pathUpdater = getPathUpdater()
	
    if pathUpdater and (a_name ~= nil) then
        local cmdline = "--run --waitpid "..os.getpid().." install ".. a_name 
        --base.print("-----",cmdline, pathUpdater)
        os.run_process(pathUpdater, cmdline)
        Quit()
    end
end

function isEnable()
	local a, err = lfs.attributes("bin/dcs_updater.exe")
	local b, err = lfs.attributes("dcs_updater.exe")
	
	return a or b
end

function getPathUpdater()
	local a, err = lfs.attributes("bin/dcs_updater.exe")
	local b, err = lfs.attributes("dcs_updater.exe")
	
	if a then	
		return "bin/dcs_updater.exe"
	elseif b then
		return "dcs_updater.exe"
	else
		MsgWindow.warning(_("The Updater is not found. You can download it here:").." http://updates.digitalcombatsimulator.com", _("WARNING"), _("OK")):show()
		return
	end	
end

function uninstallComponent(a_name)
	local pathUpdater = getPathUpdater()
	
    if pathUpdater and (a_name ~= nil) then
        local cmdline = "--run --waitpid "..os.getpid().." uninstall ".. a_name   
        --base.print("-----",cmdline)
        os.run_process(pathUpdater, cmdline)
        Quit()
    end
end      

function getInstalledComponents(a_tbl)
    if a_tbl == nil then
        return 
    end    

    local result = ""
    for k,v in base.pairs(listComp) do
        for kk,vv in base.pairs(a_tbl) do
            if (vv == v) then
                result = result..v.." "                
            end    
        end
    end
    
    result = base.string.sub(result, 1, base.string.len(result) - 1)
    
    --base.print("-----result=",result)
    
    return result
end          


function isInstalledComponent(a_comp)
    local comp = addInterrelated[a_comp]
    comp = comp or {a_comp}
    
    for k,v in base.pairs(listComp) do
        for _tmp, vc in base.pairs(comp) do
            if (v == vc) then
                return true
            end
        end
    end
    return false
end





