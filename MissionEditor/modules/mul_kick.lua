local base = _G

module('mul_kick')

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
local Window 			= require('Window')
local U                 = require('me_utilities')
local MsgWindow         = require('MsgWindow')
local DialogLoader      = require('DialogLoader')
local net               = require('net')
local UpdateManager	    = require('UpdateManager')
local Tools 			= require('tools')
local Gui               = require('dxgui')
local DCS               = require('DCS')


i18n.setup(_M)

cdata = 
{
    Kickreason             = _("Kick reason"),

    

}

local bCreated = false
local id = nil


-------------------------------------------------------------------------------
-- 
function create()
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_kick.dlg", cdata)
    
    eMsg        = window.pBox.eMsg
    bOk         = window.pBox.bOk
    btnCancel   = window.pBox.bCancel
    
    window:centerWindow() 
    window:addHotKeyCallback('return', onChange_Ok)

    btnCancel.onChange = onChange_Cancel
    bOk.onChange = onChange_Ok

    
    create = true
end

function show(b, a_id)
    if window == nil then
        create()
    end
    
    if b == true then
        id = a_id
        eMsg:setText("")
        eMsg:setFocused(true)        
        DCS.lockAllKeyboardInput()
    else
        DCS.unlockKeyboardInput(true)
    end
    
    window:setVisible(b)     
end

function onChange_Cancel()
    show(false)
end      

function onChange_Ok()
    base.print("---kick----",id, eMsg:getText())
    if id then        
        net.kick(id, eMsg:getText()) 
        eMsg:setText("")
    end   
    show(false)
end  