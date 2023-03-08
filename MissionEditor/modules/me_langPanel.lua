local base = _G

module('me_langPanel')

local require       = base.require
local pairs         = base.pairs
local table         = base.table
local math          = base.math
local loadfile      = base.loadfile
local setfenv       = base.setfenv
local string        = base.string
local assert        = base.assert
local io            = base.io
local loadstring    = base.loadstring
local print         = base.print
local os            = base.os

local i18n 				= require('i18n')
local U                 = require('me_utilities')
local MsgWindow         = require('MsgWindow')
local DialogLoader		= require('DialogLoader')
local mod_dictionary    = require('dictionary')
local ListBoxItem       = require("ListBoxItem")
local module_mission    = require('me_mission')
local toolbar           = require('me_toolbar')
local statusbar 		= require('me_statusbar')
local waitScreen        = require('me_wait_screen')
local LangController	= require('Mission.LangController')
local MapWindow			= require('me_map_window')
local me_menubar		= require('me_menubar')

i18n.setup(_M)

cdata = 
{
    createLanguage  = _("create Language"),
    deleteLanguage  = _("delete Language"),
    Close           = _("CLOSE"),
    DeleteLang      = _("DELETE LANGUAGE"),    
    msgDeleteLang   = _("Are you sure you want to delete language: "),
    yes		        = _('Yes'),
	no		        = _('No'),
    
    curLocal        = _('Current local:'),
    selLocal        = _('Select local:'),
    OK              = _('OK'),
    DELSELLOCAL     = _('DELETE LOCAL'),
    locConPanel     = _('Local control panel'),    
    createNewLocal  = _('Create new local'),
    typeTwo         = _('Type two symbols of local'),
    createLocal     = _('CREATE LOCAL'),
}



-------------------------------------------------------------------------------
-- 
function create(x, y, w, h)
    window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_selectLang.dlg', cdata) 

    window:setBounds(x, y, w, h)
    
    panel           = window.panel
    sCurLang        = panel.sCurLang
    btnClose        = panel.btnClose
    btnOk           = panel.bOk
    comboListLangs  = panel.comboListLangs
    
    btnClose.onChange = btnClose_onChange
    btnOk.onChange = btnOk_onChange
    comboListLangs.onChange = comboListLangsonChange
    clLocale = window.panel.clLocale
    
    loadLocales()

    btnNewLang = window.panel.btnNewLang
    btnNewLang.onChange = btnNewLangonChange
    
    btnDeleteLang = window.panel.btnDeleteLang
    btnDeleteLang.onChange = btnDeleteLangChange
end

function loadLocales()
    local f = base.loadfile("MissionEditor/data/scripts/Langs.lua")
	local env = {}	
    locales = nil
    if f then
        base.setfenv(f, env)
        f()
        locales = env.locales
    end    
    
    function compareLocales(tab1, tab2)
        return tab1.locale < tab2.locale
    end
    
    table.sort(locales, compareLocales)

    function fillListLoacales(locales)
        local locale = i18n.getLocale()
        local firstItem
        for k,v in base.ipairs(locales) do
            local item = ListBoxItem.new(v.locale.." "..v.name)
            item.locale = v.locale
            clLocale:insertItem(item)
            
            if k == 1 then
                firstItem = item
            end
          
            if base.string.upper(locale) == item.locale then
                firstItem = item
            end
        end 
        clLocale:selectItem(firstItem)
    end
    
    if locales then
        fillListLoacales(locales)
    end
end
    
function show(b)
    if b == true then
        fillListboxLangs()
        updateBtnDeleteLang()
        updateCurLang()
    end
    
    window:setVisible(b)
end

function btnClose_onChange()
    show(false)
end

function comboListLangsonChange(self, item)   
    
end

function updateCurLang()
    sCurLang:setText(LangController.getCurLang())
end

function btnOk_onChange()    
    local item = comboListLangs:getSelectedItem()
	local yes		= _('YES')
    local no		= _('NO')
    local cancel	= _('CANCEL')
    
    if item and (LangController.getCurLang() ~= item.name)  then
        waitScreen.setUpdateFunction(function()
            MapWindow.unselectAll()
            toolbar.untoggle_all_except(self)
            
            if module_mission.isSignedMission() ~= true and (module_mission.isMissionModified() or not module_mission.getMissionPathIsSaved()) then
                local button = me_menubar.showOnExitSavePrompt(yes, no, cancel)            
                if button == yes then
                    toolbar.saveMission()
                    
                    LangController.setSelectLang(item.name) 
                    mod_dictionary.setCurDictionary(item.name)
                    module_mission.load(module_mission.mission.path) 
					MapWindow.show(true)
                    statusbar.updateLang()
                    fillListboxLangs()
                    updateBtnDeleteLang()
                    updateCurLang()
                    show(false)
                elseif button == no then
                    LangController.setSelectLang(item.name) 
                    mod_dictionary.setCurDictionary(item.name)
                    module_mission.load(module_mission.mission.path) 
					MapWindow.show(true)
                    statusbar.updateLang()
                    fillListboxLangs()
                    updateBtnDeleteLang()
                    updateCurLang()
                    show(false)
                else  
                    updateBtnDeleteLang()
                    updateCurLang()
                end
            else
                LangController.setSelectLang(item.name) 
                mod_dictionary.setCurDictionary(item.name)
                module_mission.load(module_mission.mission.path) 
				MapWindow.show(true)
                statusbar.updateLang()
                fillListboxLangs()
                updateBtnDeleteLang()
                updateCurLang()
                show(false)
            end
        end)
    else
        show(false)
    end
end

function updateBtnDeleteLang()
    if LangController.getCurLang() == 'DEFAULT' then
        btnDeleteLang:setEnabled(false)
    else
        btnDeleteLang:setEnabled(true)
    end
end

function fillListboxLangs()
    local nativeItem = nil
    if comboListLangs then
        comboListLangs:clear()
        local langs = mod_dictionary.getLangs()
        local selectItem
        local defaultItem
        for k,v in base.pairs(langs) do
            local item = ListBoxItem.new(v)
            item.name = v           
            comboListLangs:insertItem(item)           
            if LangController.getCurLang() == item.name then
                selectItem = item
            end
            if 'DEFAULT' == item.name then
                defaultItem = item
            end
        
        end
        
        if selectItem then
            comboListLangs:selectItem(selectItem)
        else
            comboListLangs:selectItem(defaultItem)
        end    
    end
end

function btnNewLangonChange()
    local newLang = clLocale:getSelectedItem().locale
    
    if newLang == nil or newLang == "" then
        return
    end    
    if mod_dictionary.isLang(newLang) == true then
        MsgWindow.info(_("Language enabled"), _("ADDLANGUAGE"), cdata.ok):show()
        return
    else    
        mod_dictionary.addNewLang(newLang)       
        toolbar.saveMission() 
        mod_dictionary.CopyKeysToNewDict(newLang)
        LangController.setSelectLang(newLang)        
        mod_dictionary.setCurDictionary(newLang)
        module_mission.load(module_mission.mission.path) 
		MapWindow.show(true)
        statusbar.updateLang()
        fillListboxLangs()
    end
    updateBtnDeleteLang()
end

function btnDeleteLangChange()
    local handler = MsgWindow.question(cdata.msgDeleteLang..LangController.getCurLang().."?", cdata.DeleteLang, cdata.yes, cdata.no)
	
	function handler:onChange(buttonText)
		if buttonText == cdata.yes then
            mod_dictionary.deleteLang(LangController.getCurLang())
    
            toolbar.saveMission()
            LangController.setSelectLang("DEFAULT")
            mod_dictionary.setCurDictionary("DEFAULT")
            module_mission.load(module_mission.mission.path) 
			MapWindow.show(true)
            statusbar.updateLang()
            fillListboxLangs()
            updateBtnDeleteLang()
		end
	end

	handler:show()


    
end

