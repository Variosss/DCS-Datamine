local base = _G

module('mul_nickname')

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
local textutil          = require('textutil')
local lfs 				= require('lfs')
local ListBoxItem		= require('ListBoxItem')
local log      			= require('log')

i18n.setup(_M)

cdata = 
{
    ChangeNickname  = _("Change nickname"),
    maxSymbols      = _("maximum 25 symbols"),
    Player          = _("Player"),
}

local tblNickNames = {}
local curNickName = nil

-------------------------------------------------------------------------------
-- 
function create(w, h)
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_nickname.dlg", cdata)

    pBox        = window.pBox
    cbNickName  = pBox.cbNickName
    btnOk       = pBox.btnOk
    btnCancel   = pBox.btnCancel
    
    cbNickName.onChangeEditBox = onChange_cbNickName
    btnOk.onChange      = onChange_btnOk
    btnCancel.onChange  = onChange_btnCancel
    
    
    window:setBounds(0, 0, w, h)
    local boxW,boxH = pBox:getSize()
    pBox:setPosition((w-boxW)/2, (h-boxH)/2)
    
    window:addHotKeyCallback('return', onChange_btnOk)
    
    loadNicknames()
    fill_cbNickName() 
end

function show(b, a_callback)
    callback = a_callback
    
    if b == true then
        fill_cbNickName()
  --      eMsg:setText("")
 --       eMsg:setFocused(true)        
    else
    end
    
    window:setVisible(b)     
end

function onChange_cbNickName(self)
    local text = self:getText()

    if (textutil.Utf8Len(text) > 25) then
        local str = textutil.Utf8GetSubString(text,0,25)
        text = str
        self:setText(text)
        self:setSelection(25,0)
       -- local lastLine = self:getLineCount() - 1
        --base.print("----line---",lastLine, self:getLineTextLength(lastLine))
        --self:setSelectionNew(0,1,0,2)
    end
    
end

function loadNicknames()
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
            base.setfenv(f, env)
            local ok, res = base.pcall(f)
			if not ok then
				log.error('ERROR: loadNicknames() failed to pcall "'..path..'": '..res)
				return
			end
            for i = 1, 5 do
                tblNickNames[i] = env.nicknames[i]
            end
        end    
 --   else
       -- base.table.insert(tblNickNames,cdata.Player)
    end 
end

function fill_cbNickName() 
    cbNickName:clear()
    cbNickName:setText("")

    if tblNickNames then
        for i, v in base.ipairs(tblNickNames) do
            local item = ListBoxItem.new(v)
            item.index = i
            cbNickName:insertItem(item)
        end

        cbNickName:selectItem(cbNickName:getItem(0))
        curNickName = cbNickName:getText()       
    end

    if curNickName == nil or curNickName == "" then
        curNickName = cdata.Player
        cbNickName:setText(curNickName)
    end
end

function saveNicknames()
    if tblNickNames then
        U.saveInFile(tblNickNames, 'nicknames', lfs.writedir() .. 'Config/nicknames.lua')    
    end   
end

function onChange_btnCancel()
    if callback then
        callback()
    end
    show(false)
end      

function onChange_btnOk()
    local enableIndex = nil
    curNickName = cbNickName:getText()
    
    curNickName = textutil.Utf8StringTrimLeft(curNickName)
    curNickName = textutil.Utf8StringTrimRight(curNickName)
    
    oldStr =  nil
    while oldStr ~= curNickName do
        oldStr = curNickName
        curNickName = base.string.gsub(curNickName,"  "," ")
    end

    if curNickName == "" then
        return
    end
    
    if tblNickNames then
        for k,v in base.pairs(tblNickNames) do
            if curNickName == v then
                enableIndex = k
            end
        end
    else
        tblNickNames = {}
    end
    if enableIndex ~= nil then
        base.table.remove(tblNickNames,enableIndex)
    end
    base.table.insert(tblNickNames,1, curNickName)
    for i = #tblNickNames, 6, -1 do
        base.table.remove(tblNickNames,i)
    end
        
    if callback then
        callback()
    end
    
    saveNicknames()
    show(false)
end  

function getNickname()
    return curNickName
end