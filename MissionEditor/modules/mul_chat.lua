local base = _G

module('mul_chat')

local require       	= base.require
local pairs         	= base.pairs
local ipairs         	= base.ipairs
local table         	= base.table
local math          	= base.math
local loadfile      	= base.loadfile
local setfenv       	= base.setfenv
local string        	= base.string
local assert        	= base.assert
local io            	= base.io
local loadstring    	= base.loadstring
local print         	= base.print
local os            	= base.os

local i18n 				= require('i18n')
local U                 = require('me_utilities')
local DialogLoader      = require('DialogLoader')
local net               = require('net')
local Static            = require('Static')
local Gui               = require('dxgui')
local textutil          = require('textutil')
local EditBox           = require('EditBox')
local DCS               = require('DCS')
local Censorship        = require('censorship')
local Tools 			= require('tools')
local lfs 				= require('lfs')
local Skin				= require('Skin')
local ListBoxItem       = require('ListBoxItem')
local keys              = require('mul_keys')
local Input             = require('Input')
local ProductType		= require('me_ProductType') 

i18n.setup(_M)


cdata =
{
    ALLIES      = _("2Allies"),
    ALL         = _("2All"),
    MESSAGE     = _("MESSAGE:"),
    unknown     = _("unknown_chat","unknown"),
    player      = _("player_chat","player"),
    chat        = _("Chat"),
    
    MissionIsOver = _("Mission is over."),
}

if ProductType.getType() == "LOFAC" then
    cdata.MissionIsOver = _('Mission is over.-LOFAC')
end

mode = {       -- используется из других модулей
    min = "min",
    read = "read",
    write = "write",
}

local bCreated			= false
local listMessages		= {}
local modeCur			= mode.min
local noReadMsg			= 0
local curValueWheel		= 0
local newMsg			= false
local bHideWin			= false
local slotByUnitId		= {}
local chatPos			= {} 
local listStatics		= {}

local bQueryEnable		= true
local keyboardLocked	= false

-------------------------------------------------------------------------------
-- 

local function unlockKeyboardInput(releaseKeyboardKeys)
	if keyboardLocked then
		DCS.unlockKeyboardInput(releaseKeyboardKeys)
		
		keyboardLocked = false
	end
end

local function lockKeyboardInput()
	if keyboardLocked then
		return
	end

	-- блокируем все кнопки клавиатуры, 
	-- кроме кнопок управления чатом
	local keyboardEvents	= Input.getDeviceKeys(Input.getKeyboardDeviceName())
	local inputActions		= Input.getEnvTable().Actions
	
	local removeCommandEvents = function(commandEvents)
		for i, commandEvent in ipairs(commandEvents) do
			-- из массива удаляем элементы с конца
			for j = #keyboardEvents, 1, -1 do
				if keyboardEvents[j] == commandEvent then
					table.remove(keyboardEvents, j)
					
					break
				end
			end
		end	
	end
	
	removeCommandEvents(Input.getUiLayerCommandKeyboardKeys(inputActions.iCommandChat))
	removeCommandEvents(Input.getUiLayerCommandKeyboardKeys(inputActions.iCommandAllChat))
	removeCommandEvents(Input.getUiLayerCommandKeyboardKeys(inputActions.iCommandFriendlyChat))
	removeCommandEvents(Input.getUiLayerCommandKeyboardKeys(inputActions.iCommandChatShowHide))
	
	DCS.lockKeyboardInput(keyboardEvents)
	
	keyboardLocked = true
end

function create()
    window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/mul_chat.dlg', cdata)
	
    box         = window.Box
    pNoVisible  = window.pNoVisible
    pDown       = box.pDown
    eMessage    = pDown.eMessage
    pBtn        = pDown.pBtn
    tbAll       = pBtn.tbAll
    pMsg        = box.pMsg
    btnMail     = window.btnMail
    vsScroll    = box.vsScroll
    sAll        = pBtn.sAll
    sAllies     = pBtn.sAllies

    tbAll.onChange = onChange_tbAll
    btnMail.onChange = onChange_btnMail
    vsScroll.onChange = onChange_vsScroll
    eMessage.onChange = onChange_eMessage    

    
    pMsg:addMouseWheelCallback(onMouseWheel_eMessage)
    
    vsScroll:setRange(1,1)
 --   vsScroll:setThumbValue(1)
    vsScroll:setValue(1)
    curValueWheel = 1
  --  vsScroll:setStep(1)
  --  vsScroll:setPageStep(1)
    
    widthChat, heightChat = pMsg:getSize()
    
    skinModeWrite = pNoVisible.pModeWrite:getSkin()
    skinModeRead = pNoVisible.pModeRead:getSkin()
    
    skinSelAllies   = pNoVisible.sSelAllies:getSkin()
    skinNoSelAllies = pNoVisible.sNoSelAllies:getSkin()
    
    skinNoSelAll    = pNoVisible.sSelAll:getSkin()
    skinSelAll      = pNoVisible.sNoSelAll:getSkin()
    
    skinMail = btnMail:getSkin()
    skinMailAndQuery = pNoVisible.btnMailAndQuery:getSkin()
    
    eMx,eMy,eMw = eMessage:getBounds()

    typesMessage =
    {
        my          = pNoVisible.eYellowText:getSkin(),
        red         = pNoVisible.eRedText:getSkin(),
        blue        = pNoVisible.eBlueText:getSkin(),
        sys         = pNoVisible.eWhiteText:getSkin(),
		Orange		= pNoVisible.eOrangeText:getSkin(),
    }
    
    testStatic = EditBox.new()
    testStatic:setSkin(typesMessage.sys)
    testStatic:setReadOnly(true)   
    testStatic:setTextWrapping(true)  
    testStatic:setMultiline(true) 
    testStatic:setBounds(0,0,widthChat,20)
    
    listStatics = {}
    
    for i = 1, 20 do
        local staticNew = EditBox.new()        
        table.insert(listStatics, staticNew)
        staticNew:setReadOnly(true)   
        staticNew:setTextWrapping(true)  
        staticNew:setMultiline(true) 
        pMsg:insertWidget(staticNew)
    end
    
    function eMessage:onKeyDown(key, unicode) 
        if 'return' == key then            
            local text = eMessage:getText()            
            if text ~= "\n" and text ~= nil then
                text = string.sub(text, 1, (string.find(text, '%s+$') or 0) - 1)
                net.send_chat(text, tbAll:getState()) 
                --onChatMessage(text, net.get_my_player_id())
            end
            eMessage:setText("")
            eMessage:setSelectionNew(0,0,0,0)
            resizeEditMessage()
        end
    end
	
    testE = EditBox.new()    
    testE:setTextWrapping(true)  
    testE:setMultiline(true)  
    testE:setBounds(0,0,eMw,20)
    testE:setSkin(eMessage:getSkin())	

    w, h = Gui.GetWindowSize()
    
    chatPos.x = 0
    chatPos.y = h/2-200
    
    loadChatPos()
    
    resize(w, h)
    resizeEditMessage()
    
    setMode("min")
    
    
    window:addPositionCallback(positionCallback) 
    
    positionCallback()
    Censorship.init()
    bCreated = true
end

function positionCallback()
    local x, y = window:getPosition()

    if x < 0 then
        x = 0
    end

    if y < 0 then
        y = 0
    end

    if x > (w-360) then
        x = w-360
    end

    if y > (h-400)then
        y = h-400
    end

    window:setPosition(x, y)
end

function loadChatPos()
    local tbl = Tools.safeDoFile(lfs.writedir() .. 'Config/ChatPosition.lua', false)
    if (tbl and tbl.chatPos and tbl.chatPos.x and tbl.chatPos.y) then
        chatPos.x = tbl.chatPos.x
        chatPos.y = tbl.chatPos.y
    end      
end

function saveChatPos()
    chatPos.x, chatPos.y = window:getPosition()
    U.saveInFile(chatPos, 'chatPos', lfs.writedir() .. 'Config/ChatPosition.lua')	
end

function updateSlots()
    local redSlots = DCS.getAvailableSlots("red")
    local blueSlots = DCS.getAvailableSlots("blue")
     
    slotByUnitId = {}
    for k,v in base.pairs(redSlots) do
        slotByUnitId[v.unitId] = v
    end
    
    for k,v in base.pairs(blueSlots) do
        slotByUnitId[v.unitId] = v
    end
    
end

-- function onCtrlTab()   
-- --base.print("---onCtrlTab---",getMode(),getAll()) 
    -- if (getMode() == mode.write) and (getAll() == false) then
        -- setMode(mode.min)  
    -- else
        -- setAll(false)
        -- setMode(mode.write)  
    -- end
-- end

-- function onShiftTab()
-- --base.print("---onShiftTab---",getMode(),getAll())
    -- if (getMode() == mode.write) and (getAll() == true) then
        -- setMode(mode.min)
    -- else
        -- setAll(true)
        -- setMode(mode.write)            
    -- end 
-- end

-- function onTab()
-- base.print("---onTab---",getMode(),getAll()) 
    -- if (getMode() ~= mode.read) then
        -- setMode(mode.read)
    -- else
        -- setMode(mode.min)    
    -- end
-- end


    
function resize(w, h)
    window:setBounds(chatPos.x, chatPos.y, 360, 455)
    
    btnMail:setBounds(12, 0, 24, 55)
    box:setBounds(0, 0, 360, 400)
end



--[[
    желтый - мои сообщения
    красный - игроки моей коалиции
    синий - чужие
    белый - системные спектраторы
]]

function onChange_tbAll()
    if tbAll:getState() == true then
        sAll:setSkin(skinSelAll)
        sAllies:setSkin(skinNoSelAllies)
    else
        sAll:setSkin(skinNoSelAll)
        sAllies:setSkin(skinSelAllies)
    end
end

function onChange_btnMail()
    if modeCur == "min" then
        setMode("read")  
    else
        setMode("min")  
    end    
end

function onChange_vsScroll(self)
    curValueWheel = vsScroll:getValue()
    updateListM()
end

function onMouseWheel_eMessage(self, x, y, clicks)
    curValueWheel = curValueWheel - clicks*0.1
    if curValueWheel < 0 then
        curValueWheel = 0
    end
    if curValueWheel > #listMessages-1 then
        curValueWheel = #listMessages-1
    end
    
    vsScroll:setValue(curValueWheel)
    updateListM()
end

function resizeEditMessage()
    local text = eMessage:getText()
    
    testE:setText(text)
    local newW, newH = testE:calcSize()  

    eMessage:setBounds(eMx,eMy,eMw,newH)
    
    local x,y,w,h = pBtn:getBounds()
    pBtn:setBounds(x,eMy+newH+20,w,h)
    
    local x,y,w,h = box:getBounds()
    box:setBounds(x,0,w,eMy+newH+317)
    
    local x,y,w,h = pDown:getBounds()
    pDown:setBounds(x,y,w,eMy+newH+117)
    
    local x,y,w,h = window:getBounds()
    window:setSize(w,eMy+newH+317+55)
end

function onChange_eMessage(self)
    local text = self:getText()

    if (textutil.Utf8Len(text) > 100) then
        local str = textutil.Utf8GetSubString(text,0,100)
        text = str
        self:setText(text)
        local lastLine = self:getLineCount() - 1
        --base.print("----line---",lastLine, self:getLineTextLength(lastLine))
        self:setSelectionNew(lastLine, self:getLineTextLength(lastLine), lastLine, self:getLineTextLength(lastLine))
    end
    
    resizeEditMessage()
end

function clear()
    listMessages = {}
end

function onChatMessage(a_message, a_playerId, a_to)
   base.print("--- onChatMessage---",a_message, a_playerId, a_to)
    if bCreated == false then
        create()
    end
	
	local bServerMsg = (a_playerId == net.get_server_id())
    
    local player_info = net.get_player_info(a_playerId)
	local myId = net.get_my_player_id() 
	local typeMsg = nil
	
    --base.U.traverseTable(player_info)
	if a_to ~= nil then
		if net.CHAT_ALL == a_to then
			typeMsg = "[".._("2All").."] "
		else
			typeMsg = "[".._("2Allies").."] "
		end
	end

    --base.print("---a_message----",a_message, a_playerId)
    local message = base.string.gsub(a_message, '\n', ' ');	
    
    local name = ""
    if player_info then
        name = player_info.name
    end
       
    local myInfo = net.get_player_info(myId)
    local skinM
    
    if myId == a_playerId then
        skinM = typesMessage.my 
	elseif bServerMsg == true then	
		skinM = typesMessage.Orange	
    elseif player_info == nil or player_info.side == 0 then
        skinM = typesMessage.sys       
    elseif 1 == player_info.side then
        skinM = typesMessage.red	
    else 
        skinM = typesMessage.blue
    end
    
    addMessage(message, name, skinM, typeMsg)
end

function addMessage(a_message, a_name, a_skin, a_typeMsg)
    --a_message = Censorship.censor(a_message)
    
    local date = os.date('*t')
	local dateStr = string.format("%i:%02i:%02i", date.hour, date.min, date.sec)
	
    local name = a_name
    if a_name ~= "" or a_skin ~= typesMessage.sys then
        name = a_name..": "
    end
    
    local fullMessage = "["..dateStr.."] "..(a_typeMsg or "")..Censorship.censor(name)..a_message
    testStatic:setText(fullMessage)
    local newW, newH = testStatic:calcSize()   
    
    local msg = {message = fullMessage, skin = a_skin, height = newH}
    table.insert(listMessages, msg)
        
    local minR, maxR = vsScroll:getRange()
    
    if ((curValueWheel+1) >= maxR) then
        vsScroll:setRange(1,#listMessages)
        vsScroll:setThumbValue(1)
        vsScroll:setValue(#listMessages)
        curValueWheel = #listMessages
    else
    
        vsScroll:setRange(1,#listMessages)
        vsScroll:setThumbValue(1)
    end   
    
    if modeCur == "min" then
        noReadMsg = noReadMsg + 1
        updateNoReadMsg()
    else
        updateListM()
    end
end

function updateNoReadMsg()
    local txt 
    if noReadMsg >= 100 then
        txt = "99+"    
    else
        txt = base.tostring(noReadMsg)
    end
    
    if modeCur == "min" and noReadMsg > 0 then
        setVisibleBtnMail(true)
    end
    
    btnMail:setText(txt)
end

function show(b)

    if bCreated == false then
        create()
    end
    
    if b == false then
        saveChatPos()
    end
    
    setVisible(b)
end

function updateListM()
    for k,v in base.pairs(listStatics) do
        v:setText("")    
    end
   
    local offset = 0
    local curMsg = vsScroll:getValue() + vsScroll:getThumbValue()  --#listMessages
    local curStatic = 1
    local num = 0     
    if listMessages[curMsg] then          
        while curMsg > 0 and heightChat > (offset + listMessages[curMsg].height) do
            local msg = listMessages[curMsg]
            listStatics[curStatic]:setSkin(msg.skin)                                 
            listStatics[curStatic]:setBounds(0,heightChat-offset-msg.height,widthChat,msg.height) 
            listStatics[curStatic]:setText(msg.message)            
            offset = offset + msg.height
            curMsg = curMsg - 1
            curStatic = curStatic + 1
            num = num + 1
        end
    end    
end

function setAll(a_all)
    tbAll:setState(a_all)
    setMode(modeCur)
end

function getAll()
    return tbAll:getState()
end

function onChatShowHide()
    bHideWin = not bHideWin 
    if bHideWin == false then    
        setMode(modeCur)
    else
        window:setVisible(false)
    end
end

function setVisibleBtnMail(b)
    if noReadMsg == 0 then
        btnMail:setVisible(false)  
    else
        btnMail:setVisible(b)  
    end
end

function setVisible(b)
    if bHideWin == false then
        window:setVisible(b)
    else
        window:setVisible(false)
    end
end

function setMode(a_mode)
    modeCur = a_mode 
    
    if window == nil or bHideWin == true then
        return
    end
    if modeCur == "min" then
		window:setVisible(false)
        box:setVisible(false)
        setVisibleBtnMail(true)
        updateNoReadMsg()
        box:setSkin(skinModeRead)
        eMessage:setFocused(false)
        unlockKeyboardInput(true)
        window:setSkin(Skin.windowSkinChatMin())
		window:setHasCursor(false)
        window:setSize(36, 85)
        btnMail:setBounds(12, 0, 24, 55)
        if bQueryEnable then
            btnMail:setSkin(skinMail)
        else
            btnMail:setSkin(skinMailAndQuery)
        end
    end
    
    if modeCur == "read" then
		window:setVisible(false)
        box:setVisible(true)
        setVisibleBtnMail(false)
        box:setSkin(skinModeRead)
        noReadMsg = 0
        vsScroll:setVisible(false)
        pDown:setVisible(false)
        eMessage:setFocused(false)
        unlockKeyboardInput(false)
        window:setSkin(Skin.windowSkinChatMin())
		window:setHasCursor(false)
        window:setSize(360, 455)
    end
    
    if modeCur == "write" then
		window:setVisible(false)
        box:setVisible(true)
        setVisibleBtnMail(false)
        box:setSkin(skinModeWrite)
        noReadMsg = 0
        vsScroll:setVisible(true)
        pDown:setVisible(true)        
        lockKeyboardInput()
        window:setSkin(Skin.windowSkinChatWrite())
		window:setHasCursor(true)
        eMessage:setFocused(true)
        window:setSize(360, 455)
    end    
    updateListM()
end

function getMode()
    return modeCur
end

local function parseSide(a_side)
    if a_side == 0 then
        return _("NEUTRAL_chat","NEUTRAL")
    elseif a_side == 1 then
        return _("RED_chat","RED")
    elseif a_side == 2 then
        return _("BLUE_chat","BLUE")
    else
        return cdata.unknown
    end
end

function getPlayerInfo(a_id)
    local player_info = net.get_player_info(a_id)
    if player_info then
        return parseSide(player_info.side).." "..cdata.player.." "..Censorship.censor(player_info.name)
    end
    return cdata.unknown.." "..cdata.player.." "..cdata.unknown
end

local function getPlayerName(a_id)
    if a_id == 0 then 
        return _("AI")
    end    
    local player_info = net.get_player_info(a_id)
    if player_info then
        return Censorship.censor(player_info.name)
    end
    return cdata.unknown
end

local function getPlayerName2(a_id)
    if a_id == 0 then 
        return _("AI")
    end    
    local player_info = net.get_player_info(a_id)
    if player_info then
        return cdata.player.." "..Censorship.censor(player_info.name)
    end
    return cdata.unknown
end

function getMsgByCode(code)
    local msg = _("Unknown")
    if code == net.ERR_INVALID_ADDRESS then
        msg = _("Invalid address")
    elseif code == net.ERR_CONNECT_FAILED then
        msg = _("Connection failed")
    elseif code == net.ERR_WRONG_VERSION then
        msg = _("Wrong DCS version")
    elseif code == net.ERR_PROTOCOL_ERROR then
        msg = _("Protocol error")
    elseif code == net.ERR_TAINTED_CLIENT then
        msg = _("Client is tainted")
    elseif code == net.ERR_INVALID_PASSWORD then
        msg = _("Invalid password")
    elseif code == net.ERR_BANNED then
        msg = _("Banned")
    elseif code == net.ERR_BAD_CALLSIGN then
        msg = _("Bad callsign")
    elseif code == net.ERR_TIMEOUT then
        msg = _("Connection timed out.")
    elseif code == net.ERR_KICKED then
        msg = _("Kicked")
	elseif code == net.ERR_REFUSED then
        msg = _("Connection refused.")
	elseif code == net.ERR_DENIED_TRIAL_ONLY then
        msg = _("Trial-only clients are not allowed.")
	elseif code == net.ERR_THATS_OKAY then
		msg = _("Thats okay")
	elseif code == net.ERR_NOT_ALLOWED then
		msg = _("Not allowed")	
    end 
    return msg
end
    
function onGameEvent(eventName,arg1,arg2,arg3,arg4,arg5,arg6,arg7) 
	if DCS.isMultiplayer() ~= true then
		return
	end
	
    if eventName == "crash" then
        local unitType = slotByUnitId[arg2].type
        onChatMessage(base.string.format("%s ".._("in_chat", "in").." %s ".._("crashed"),getPlayerInfo(arg1),keys.getDisplayName(unitType)))
    elseif eventName == "eject" then
        local unitType = slotByUnitId[arg2].type
        onChatMessage(base.string.format("%s ".._("in_chat", "in").." %s ".._("ejected"),getPlayerInfo(arg1),keys.getDisplayName(unitType)))
    elseif eventName == "takeoff" then
        local unitType = slotByUnitId[arg2].type
        if arg3 ~= nil and arg3 ~= "" and arg3 ~= " " then
            onChatMessage(base.string.format("%s ".._("in_chat", "in").." %s ".._("took off from").." %s",getPlayerInfo(arg1),keys.getDisplayName(unitType),_(arg3)))
        else
            onChatMessage(base.string.format("%s ".._("in_chat", "in").." %s ".._("took off from ground"),getPlayerInfo(arg1),keys.getDisplayName(unitType)))
        end
    elseif eventName == "landing" then
        local unitType = slotByUnitId[arg2].type
        onChatMessage(base.string.format("%s ".._("in_chat", "in").." %s ".._("landed at").." %s",getPlayerInfo(arg1),keys.getDisplayName(unitType),_(arg3)))
    elseif eventName == "mission_end" then
        onChatMessage(cdata.MissionIsOver)                    
    elseif eventName == "kill" then   --onGameEvent(kill,idPlayer1,typeP1,coalition1, idP2,typeP2, coalition2, weapon)
        local player = parseSide(arg3).." "..getPlayerName2(arg1).." ".._("in_chat", "in").." "..keys.getDisplayName(arg2)
        local killer = parseSide(arg6).." "..getPlayerName2(arg4).." ".._("in_chat", "in").." "..keys.getDisplayName(arg5)
        onChatMessage(player.." ".._("killed").." "..killer.." ".._("with").." "..arg7)
    elseif eventName == "self_kill" then 
        onChatMessage(base.string.format("%s ".._("killed himself"),getPlayerInfo(arg1)))
    elseif eventName == "pilot_death" then 
        onChatMessage(base.string.format("%s ".._("died"),getPlayerInfo(arg1)))
    elseif eventName == "change_slot" then 
        if arg2 ~= nil and slotByUnitId[arg2] ~= nil then
            local unitType = slotByUnitId[arg2].type
			local player_info = net.get_player_info(arg1)
			local sideAccupied = "unknown"
			if player_info then
				sideAccupied = parseSide(player_info.side)
			end
			local player = parseSide(arg3).." "..getPlayerName2(arg1)
            onChatMessage(base.string.format("%s ".._("occupied").." %s %s",player,sideAccupied, keys.tabTr[unitType] or keys.getDisplayName(unitType)))			
        else
			local player = parseSide(arg3).." "..getPlayerName2(arg1)
            onChatMessage(base.string.format("%s ".._("returned to Spectators"),player))
        end
    elseif eventName == "connect" then 
        onChatMessage(base.string.format("%s ".._("connected to server"),getPlayerName(arg1)))        
    elseif eventName == "disconnect" then
		local player = parseSide(arg3).." "..cdata.player.." "..arg2
        local msg = "" 
        if arg4 ~= net.ERR_THATS_OKAY then
            msg = _("Reason")..":"..getMsgByCode(arg4)
        end
        onChatMessage(base.string.format("%s ".._("disconnected").." %s", player, msg))
    elseif eventName == "friendly_fire" then 
        onChatMessage(base.string.format("%s ".._("hit allied").." %s ".._("with").." %s",getPlayerInfo(arg1),getPlayerName2(arg3), arg2))
    elseif eventName == "screenshot" then 
        onChatMessage(base.string.format("%s ".._("took a screenshot"),getPlayerInfo(arg1)))
    else
        onChatMessage(base.string.format("unknown %s %s %s",eventName, arg1 or "nil", arg2 or "nil" ,arg3  or "nil"))
    end    
    --[[
        "crash", playerID, event.initiator_misID
        "eject", playerID, event.initiator_misID
        "takeoff", event.initiator_misID, event.s_place
        "landing", playerID, event.initiator_misID, event.s_place
        "mission_end", winner, msg
        "kill", playerID, hit.s_weapon, event_.initiator_misID
        "player_kill", playerID, event_.initiator_misID
        ]]
end




