local base = _G

module('messagesHistory')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local print = base.print
local table = base.table
local string = base.string
local tonumber = base.tonumber
local tostring = base.tostring
local assert = base.assert
local type = base.type
local math = base.math
local os = base.os

local Gui               = require('dxgui')
local DialogLoader      = require('DialogLoader')
local gettext           = require('i_18n')
local DCS               = require('DCS')
local i18n 				= require('i18n')
local Static            = require('Static')
local UpdateManager		= require('UpdateManager')

i18n.setup(_M)

cdata = {
	JOURNAL 			= _("JOURNAL"),
	Dialogs 			= _("DIALOGS"),
	RadioMessage 		= _("RADIO MESSAGE"),
	CLOSE				= _("CLOSE"),
}

local listMessagesAll	= {}	
local listMessages		= {}	
local heightPanelMsg    = 0
local widthPanelMsg     = 0
local listStatics		= {}
local curValueWheel		= 0


function create()
	window = DialogLoader.spawnDialogFromFile('Scripts/UI/messagesHistory.dlg', cdata)
	window:setBounds(0, 0, 1000, 768)  
	window:centerWindow()
	window:addHotKeyCallback('escape', onChange_btnClose)
	
	btnClose 	= window.pTop.btnClose
	bClose		= window.pDown.bClose
	cbTriggers 	= window.pRight.cbTriggers
	cbRadio		= window.pRight.cbRadio
	pMsg		= window.pMsg
	vsScroll	= pMsg.vsScroll
	testStatic	= pMsg.testStatic 
	pNoVisible	= window.pNoVisible
	
			
	
	widthPanelMsg, heightPanelMsg = pMsg:getSize()
	btnClose.onChange = onChange_btnClose
	bClose.onChange = onChange_btnClose
	vsScroll.onChange = onChange_vsScroll
	cbTriggers.onChange = onChange_cbTriggers
	cbRadio.onChange = onChange_cbRadio
		
	pMsg:addMouseWheelCallback(onMouseWheel_eMessage)	
		
	sTimeSkin 			= pNoVisible.sTime:getSkin()
	sTimeGraySkin 		= pNoVisible.sTimeGray:getSkin()
	sTimeGrayOffsetSkin	= pNoVisible.sTimeGrayOffset:getSkin()
	sTimeOffsetSkin		= pNoVisible.sTimeOffset:getSkin()
	sMsgSkin 			= pNoVisible.sMsg:getSkin()
	sMsgGraySkin		= pNoVisible.sMsgGray:getSkin()
	sMsgGrayOffsetSkin	= pNoVisible.sMsgGrayOffset:getSkin()
	sMsgOffsetSkin		= pNoVisible.sMsgOffset:getSkin()
	
	listStatics = {}
    
    for i = 1, 40 do
        local staticNew = Static.new()               
        pMsg:insertWidget(staticNew)
		
		local sTimeNew = Static.new()               
        pMsg:insertWidget(sTimeNew)
		
		table.insert(listStatics, {sTime = sTimeNew, sMsg = staticNew}) 
    end
	
	curValueWheel = 1
	vsScroll:setValue(1)
	vsScroll:setRange(1,1)
	vsScroll:setThumbValue(31)
end


function show(b)
	if window == nil then
		create()
	end
	
	if b then
		DCS.lockAllMouseInput()
		updateListMsg(true)	
	else
		DCS.unlockMouseInput()
	end
	
	window:setVisible(b)
end

function isValidMessage(a_msg)
	if cbTriggers:getState() == true and a_msg.type == 'trigger' then
		return true
	end
	
	if cbRadio:getState() == true and a_msg.type == 'radio' then
		return true
	end
	
	return false
end

function addMessage(a_type, a_msg)
	if window == nil then
		create()
	end
	
	local date = os.date('*t')
	local dateStr = string.format("%i:%02i:%02i", date.hour, date.min, date.sec)
	
	testStatic:setText(a_msg)
    local newW, newH = testStatic:calcSize() 

	testStatic:setSize(895, newH) 
	local linesTbl = testStatic:getTextLines() 
	
	for k,v in base.ipairs(linesTbl) do
		local msg = {message = v, height = 16, type = a_type}
		if k == 1 then
			msg.dateStr = dateStr
			msg.height  = msg.height + 5			
		end
		
		if k == #linesTbl then
			msg.height  = msg.height + 7
		end
		
		table.insert(listMessagesAll, msg)		
		
		if isValidMessage(msg) then
			table.insert(listMessages, msg)				
		end
	end
	updateList()
end

function clear()
    listMessages = {}
	listMessagesAll = {}
end

function onChange_btnClose()
	show(false)
end

function updateList(a_bFocusLast)
	for k,v in base.pairs(listStatics) do
        v.sTime:setText("")  
		v.sMsg:setText("") 
		v.sTime:setVisible(false)
		v.sMsg:setVisible(false)	
    end

	local offset = 0
    local curMsg = vsScroll:getValue()
	
	if a_bFocusLast == true then
		local height = 12

		for i = #listMessages, 1, -1 do
			height = height + listMessages[i].height
				
			if height <= (heightPanelMsg) then
				curMsg = i
			else
				break
			end
		end
		
	end
		
	vsScroll:setValue(curMsg)
	curValueWheel = vsScroll:getValue()

    local curStatic = 1
    local num = 0 
	local graySkin = true
    if listMessages[curMsg] then 
        while listMessages[curMsg] and heightPanelMsg > (offset + listMessages[curMsg].height + 12) do
            local msg = listMessages[curMsg]
			
			if msg.dateStr then
				if num ~= 0 then
					graySkin = not graySkin
				end
				
				if graySkin then
					listStatics[curStatic].sTime:setSkin(sTimeGrayOffsetSkin)
					listStatics[curStatic].sMsg:setSkin(sMsgGrayOffsetSkin)
				else
					listStatics[curStatic].sTime:setSkin(sTimeOffsetSkin)
					listStatics[curStatic].sMsg:setSkin(sMsgOffsetSkin)
				end
			else
				if graySkin then
					listStatics[curStatic].sTime:setSkin(sTimeGraySkin)
					listStatics[curStatic].sMsg:setSkin(sMsgGraySkin)
				else
					listStatics[curStatic].sTime:setSkin(sTimeSkin)
					listStatics[curStatic].sMsg:setSkin(sMsgSkin)
				end
			end	
			
			
			
			listStatics[curStatic].sTime:setBounds(0, offset, 85, msg.height) 
            listStatics[curStatic].sTime:setText(msg.dateStr or "")  
			
            listStatics[curStatic].sMsg:setBounds(85, offset, 895, msg.height) 
            listStatics[curStatic].sMsg:setText(msg.message)
			
			listStatics[curStatic].sTime:setVisible(true)
			listStatics[curStatic].sMsg:setVisible(true)	
					
            offset = offset + msg.height
            curMsg = curMsg + 1
            curStatic = curStatic + 1
            num = num + 1
        end
    end  
	
	vsScroll:setRange(1,#listMessages+1)
	vsScroll:setThumbValue(num) 
	if num == #listMessages then
		vsScroll:setVisible(false)
	else
		vsScroll:setVisible(true)
	end
end

function onChange_vsScroll(self)
    curValueWheel = vsScroll:getValue()
    updateList()
end

function onMouseWheel_eMessage(self, x, y, clicks)
    curValueWheel = curValueWheel - clicks
    if curValueWheel < 1 then
        curValueWheel = 1
    end
    if curValueWheel > #listMessages then
        curValueWheel = #listMessages
    end
    
    vsScroll:setValue(curValueWheel)
    updateList()
end

function onChange_cbTriggers()
	updateListMsg(true)
end
	
function onChange_cbRadio()
	updateListMsg(true)
end

function updateListMsg(a_bFocusLast)
	listMessages = {}
	
	for k,msg in base.ipairs(listMessagesAll) do
		if isValidMessage(msg) == true then
			base.table.insert(listMessages, msg)
		end
	end

	updateList(a_bFocusLast)
end	