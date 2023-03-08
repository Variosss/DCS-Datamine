local base = _G

module('mul_listIntegrityCheck')

local require       = base.require

local i18n 				= require('i18n')
local Window 			= require('Window')
local DialogLoader      = require('DialogLoader')
local Gui               = require('dxgui')
local net               = require('net')

i18n.setup(_M)

cdata = 
{
    IntegrityCheck  = _("IntegrityCheck"),
    ok              = _("OK"),
}

local filesIntegrityCheck


function create()
    w, h = Gui.GetWindowSize()
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_listIntegrityCheck.dlg", cdata)    

    main_panel              = window.main_panel
    pBox                    = main_panel.pBox
    btnOk                   = main_panel.btnOk
    eFiles                  = pBox.eFiles

    btnOk.onChange = onChange_btnOk

    resize(w, h)
end

function resize(w, h)
    window:setBounds(0, 0, w, h)
    
    wP, hP = main_panel:getSize()
    window.main_panel:setBounds((w-wP)/2, (h-hP)/2, wP, hP)
end    
 

function onChange_btnOk()

    show(false)
end

function updatePanel()
    eFiles:setText("")
    if filesIntegrityCheck ~= nil then
        local text = ""
        for k,v in base.pairs(filesIntegrityCheck) do
            text = text..v.."\n"
        end
        base.print("--text---",text)
        eFiles:setText(text)
    else
        base.print("FAIL: filesIntegrityCheck == nil")
    end
end

function show(b, a_filesIntegrityCheck)
    filesIntegrityCheck = a_filesIntegrityCheck
    if window == nil then
        create()
    end

    if b then
        updatePanel()
    end   

    window:setVisible(b)    
end