local base = _G

module('mul_bda')

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
local SkinUtils         = require('SkinUtils')
local UpdateManager		= require('UpdateManager')
local ProductType		= require('me_ProductType') 

i18n.setup(_M)


cdata =
{
    ALLIES      = _("ALLIES"),
    ALL         = _("ALL"),
    MESSAGE     = _("MESSAGE:"),
    unknown     = _("unknown_Bda","unknown"),
    player      = _("player_Bda","player"),
    bda         = _("Bda"),
  
	rbdai       = _("Realtime Battle Damage Assessment"),
	--rbdai       = _("RBDAI"),

    MissionIsOver = _("Mission is over."),
	ON			= _("ON"),
	OFF			= _("OFF"),
}

if ProductType.getType() == "LOFAC" then
    cdata.MissionIsOver = _('Mission is over.-LOFAC')
end

mode = {       -- используется из других модулей
    min = "min",
    movedOff = "movedOff",
    movedOn = "movedOn",
}

local pinnedX = false
local pinnedY = false
local marginX			= 14
local marginY			= 14
local widthOffsetBox	= 17
local heightOffsetBox	= 5
local heightStaticLine	= 25
local bCreated			= false
local listMessages		= {}
local modeCur			= mode.min
local newMsg			= false
local bBdaIsOnOff		= false
local slotByUnitId		= {}
local BdaPos			= {} 
local listStatics		= {}
local bVisState			= false

--local timeUpdate = 0 
local timeUpdateStart = 0 

--local winWidth = 390
--local winHeight = 300
local winWidth		= 185
local winWidthEdge	= winWidth
local winHeight		= 180
local maxLines		= 15
local screenWidth
local screenHeight

local staticNew

local lastClock = 0
local lastClockOff = 0
local _bF10IsOn = false

--local fSpeed = 0.35
local fSpeed = 1.5
--[[
-------------------------------------------------------------------------------
--  Временно так.  Будет переделано для каждой строки свое время и прозрачность
local alpha = 1.0
function updateFadeOut( d_time )
	--base.print("--- updateFade ---",d_time)
	local speed = d_time * fSpeed
	--base.print("--- updateFade speed : ",speed)
	alpha = alpha - speed
	--base.print("--- updateFade alpha : ",alpha)

	local num = 0
	local curMsg = #listMessages
	if listMessages[curMsg] then          
		while curMsg > 0 and num < maxLines do
            local msg = listMessages[curMsg]
			if ( alpha < 0.0 ) then 
				alpha = 0.0 
			end
			msg.alpha = alpha
            curMsg = curMsg - 1
            num = num + 1
		end
		updateListM()
	end
end

function updateFade()

	local realClock = base.os.clock()

	if lastClock then
		updateFadeOut(realClock - lastClock)
	end
	
	lastClock = realClock
end

local fadeAdded = false
function updateTime()
	local timeUpdate = base.math.floor(base.os.clock() - timeUpdateStart)
	--base.print("--- updateTime---",timeUpdate)
	if timeUpdate == 10 and fadeAdded == false then
		alpha = 1.0
		lastClock = base.os.clock()
		UpdateManager.add(updateFade)
		fadeAdded = true
		Gui.EnableHighSpeedUpdate(true)
	elseif timeUpdate > 12 then
		show(false)
		Gui.EnableHighSpeedUpdate(false)
		UpdateManager.delete(updateFade)
		fadeAdded = false
		return true
	end

	return false
end
]]

local bComplete = true
function updateTime2()

	bComplete = true
	local realClock = base.os.clock()

	if lastClock then
		local d_time = realClock - lastClock
		local num = 0
		local curMsg = #listMessages
		if listMessages[curMsg] then
			while curMsg > 0 and num < maxLines do
				local msg = listMessages[curMsg]
				if msg.timeToFade > 10.0 then
					local speedAlpha = d_time * fSpeed
					msg.alpha = msg.alpha - speedAlpha
					if msg.alpha < 0.0 then
						msg.alpha = 0.0
						msg.needUpdate = false
					else
						bComplete = false
						msg.needUpdate = true
					end
				else
					msg.timeToFade = msg.timeToFade + d_time
					msg.needUpdate = false
					bComplete = false
				end
				curMsg = curMsg - 1
				num = num + 1
			end
			updateListM()
		end
	else
		bComplete = false
	end
	
	lastClock = realClock
	if bComplete == true then
		updateListSize()
		clear()
		onBdaShow(false)
		Gui.EnableHighSpeedUpdate(false)
		return true
	end

	return false
end

local xm,ym
function updateNewTime()
	return updateTime2()
end

-----------------------------------------------------------------------------------------
-- message OFF panel
-----------------------------------------------------------------------------------------
local bCompleteOff = true
function updateNewTimeOff()
	
	bCompleteOff = true
	local realClock = base.os.clock()
	if lastClock then
		local d_time = realClock - lastClockOff

		local num = 0
		local curMsg = #listMessages
		if listMessages[curMsg] then
			while curMsg > 0 and num < maxLines do
				local msg = listMessages[curMsg]
				if msg.timeToFade > 2.0 then
					local speedAlpha = d_time * fSpeed
					msg.alpha = msg.alpha - speedAlpha
					if msg.alpha < 0.0 then
						msg.alpha = 0.0
					else
						bCompleteOff = false
					end
				else
					msg.timeToFade = msg.timeToFade + d_time
					bCompleteOff = false
				end
				curMsg = curMsg - 1
				num = num + 1
			end
			updateListM()
		end
	else
		bCompleteOff = false
	end

	lastClockOff = realClock
	if bCompleteOff == true then
		window:setVisible(false)
		Gui.EnableHighSpeedUpdate(false)
		--base.print("--- updateNewTimeOff bCompleteOff == true ")
		return true
	end

end

-----------------------------------------------------------------------------------------

function startTimeOff()
	UpdateManager.delete(updateNewTime)
	Gui.EnableHighSpeedUpdate(true)
	lastClockOff = base.os.clock()
	UpdateManager.add(updateNewTimeOff)
end
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local xxx = 0
function updateNewTime_test()
	local realClock = base.os.clock()
	if lastClock then
		xxx = xxx + 0.1
	end
	lastClockOff = realClock
end

function startTime()
	if isOn() == false then
		return
	end
	UpdateManager.delete(updateNewTimeOff)
	Gui.EnableHighSpeedUpdate(true)
	lastClock = base.os.clock()
	UpdateManager.add(updateNewTime)
	--UpdateManager.add(updateNewTime_test)
end


local bMouseDown = false
local pointXstart, pointYstart
function onMouseDown_eMessage(self,x , y, button)
	base.print("--- onMouseDown_eMessage : x,y  ", x,y)
	bMouseDown = true
	pointXstart = x
	pointYstart = y
	self:captureMouse()
end

function onMouseUp_eMessage(self,x , y, button)
	base.print("--- onMouseUp_eMessage : x,y  ", x,y)
	bMouseDown = false
	self:releaseMouse()
end


function onMouseMove_eMessage(self, dx , dy)
	--base.print("--- onMouseMove_eMessage : x,y  ", dx, dy)
	if bMouseDown then
		local x, y = window:getPosition()
		newx = x + (dx - pointXstart);
		newy = y + (dy - pointYstart);

		pointXstart = dx
		pointYstart = dy

		if (newx + winWidthEdge) < screenWidth then
			pinnedX = false
		end

		window:setPosition(newx, newy)
	end
end

local function setSizeWindow(width,height)
	winWidthEdge = width
	window:setSize(width, winHeight)
	box:setBounds(widthOffsetBox, heightOffsetBox, width-widthOffsetBox*2, height-heightOffsetBox*2)

	local x,y = window:getPosition()
    if x >= (screenWidth-winWidthEdge - marginX) then
		pinnedX = true
    end

	if pinnedX  then
		x = screenWidth-winWidthEdge - marginX
	end
	window:setPosition(x,y)
	
end

function create()
    base.print("--- BDA create() ---")

	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/mul_bda.dlg', cdata)
	
    box         = window.Box
    pNoVisible  = window.pNoVisible
    vsScroll    = box.vsScroll
    
	local w,h = window:getSize();
	winWidth = w;

	screenWidth, screenHeight = Gui.GetWindowSize()
	setSizeWindow(winWidth, winHeight)

	box:addMouseMoveCallback(onMouseMove_eMessage)
	box:addMouseDownCallback(onMouseDown_eMessage)
	box:addMouseUpCallback(onMouseUp_eMessage)
    
    widthMsgBox, heightMsgBox = box:getSize()
    skinModeWrite = pNoVisible.pModeWrite:getSkin()
    skinModeRead = pNoVisible.pModeRead:getSkin()
        
    typesMessage =
    {
		my          = pNoVisible.eWhiteText:getSkin(),
		red         = pNoVisible.eRedText:getSkin(),
    }
    
    staticForCalcSizeMessage = EditBox.new()
	staticForCalcSizeMessage:setSkin(typesMessage.my);
    staticForCalcSizeMessage:setReadOnly(true)   
    staticForCalcSizeMessage:setTextWrapping(false)  
    staticForCalcSizeMessage:setMultiline(false) 
    staticForCalcSizeMessage:setBounds(0,0,widthMsgBox,heightStaticLine)

    listStatics = {}
    
    for i = 1, 12 do
        staticNew = EditBox.new()        
        table.insert(listStatics, staticNew)
        staticNew:setReadOnly(true)   
        staticNew:setTextWrapping(false)  
        staticNew:setMultiline(false) 

		staticNew:addMouseDownCallback(onMouseDown_eMessage)
		staticNew:addMouseUpCallback(onMouseUp_eMessage)
		staticNew:addMouseMoveCallback(onMouseMove_eMessage)

		box:insertWidget(staticNew)
    end

	-- Set position on GameWindow   
	BdaPos.x = ((1715.0 + winWidth) / 1920.0) * screenWidth - winWidth
	if screenHeight == 768 then
		BdaPos.y = ((616.0 + winHeight) / 1080.0) * screenHeight - winHeight  -- 1280x768 
	else
		BdaPos.y = ((636.0 + winHeight) / 1080.0) * screenHeight - winHeight  -- 1920x1080
	end

	marginX = screenWidth - (BdaPos.x + winWidth)
	marginY = marginX
	--base.print("---marginX : ",marginX)
	-- End position on GameWindow

	-- Uncomment for use Drag&Drop and use saved position.
    --loadBdaPos()
    
	window:setPosition(BdaPos.x, BdaPos.y);    
    window:addPositionCallback(positionCallback) 
    
	window:setVisible(false)
    box:setVisible(true)
    vsScroll:setVisible(false)
    window:setSize(winWidth, winHeight)
	window:setHasCursor(false)

    positionCallback()
    Censorship.init()
    bCreated = true
end

function positionCallback()
    local x, y = window:getPosition()

    if x < marginX then
        x = marginX
    end

    if y <  marginY then
        y = marginY
    end

    if x >= (screenWidth-winWidthEdge - marginX) then
        x = screenWidth-winWidthEdge - marginX
		pinnedX = true
    end

    if y >= (screenHeight-winHeight - marginY)then
        y = screenHeight-winHeight - marginY
		pinnedY = true
    end

    window:setPosition(x, y)
end

function loadBdaPos()
    local tbl = Tools.safeDoFile(lfs.writedir() .. 'Config/BdaPosition.lua', false)
    if (tbl and tbl.BdaPosNew and tbl.BdaPosNew.x and tbl.BdaPosNew.y) then
        BdaPos.x = tbl.BdaPosNew.x
        BdaPos.y = tbl.BdaPosNew.y
    end      
end

function saveBdaPos()
    if window then
		BdaPos.x, BdaPos.y = window:getPosition()
		U.saveInFile(BdaPos, 'BdaPosNew', lfs.writedir() .. 'Config/BdaPosition.lua')	
	end
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
    
function resize(width, height)
    --window:setBounds(BdaPos.x, BdaPos.y, width, height)
    --box:setBounds(widthOffsetBox, 0, width-widthOffsetBox*2, height-heightOffsetBox*2)
end



--[[
    желтый - мои сообщения
    красный - игроки моей коалиции
]]
function clear()
    listMessages = {}
    for k,v in base.pairs(listStatics) do
       v:setText("")    
    end
end

function F10IsOn()
	return _bF10IsOn
end

function onBdaMessage(a_message, a_playerId, a_skin)
   --base.print("---onBdaMessage--- : ",a_message, a_playerId, a_skin)
    
	onCreateBda()
	if F10IsOn() ~= true then
		--onBdaShowF10(true)
		onBdaShow(true)
	end

	--local bServerMsg = (a_playerId == net.get_server_id())

    local player_info = net.get_player_info(a_playerId)
    --base.U.traverseTable(player_info)
    local message = base.string.gsub(a_message, '\n', ' ');	
    
    local name = ""
    if player_info then
        name = player_info.name
    end
    --local myId = net.get_my_player_id() 
    --local myInfo = net.get_player_info(myId)
    local skinM
    
	if a_skin == 1 then
		skinM = typesMessage.red
	else
		skinM = typesMessage.my 
	end

    addMessage(message, name, skinM)
end

---------------------------------------------------------------
-- Calculate width window
---------------------------------------------------------------
function updateListSize()

	local maxWidth = widthMsgBox
	local width = maxWidth
	local winWidthUpdate = winWidth
	local num = 0
	local curMsg = #listMessages
    if curMsg > 0 and listMessages[curMsg] then
		while curMsg > 0 and num < maxLines do
            local msg = listMessages[curMsg]
			msg.needUpdate = true
			curMsg = curMsg - 1
			num = num + 1

			if( msg.alpha > 0.0 ) then
				--width = widthMsgBox
				if msg.width > widthMsgBox then
					width = msg.width
				end

				if maxWidth < width then
					maxWidth = width
					winWidthUpdate = maxWidth+widthOffsetBox*2
				end
			end
        end
    end    

	setSizeWindow(winWidthUpdate,winHeight);
end
---------------------------------------------------------------

function addMessage(a_message, a_name, a_skin)
    --a_message = Censorship.censor(a_message)
    
    local name = a_name
	local fullMessage = Censorship.censor(name)..a_message
	staticForCalcSizeMessage.setSkin(a_skin)
    staticForCalcSizeMessage:setText(fullMessage)
    local newW, newH = staticForCalcSizeMessage:calcSize()   
    
    local msg = {message = fullMessage, skin = a_skin, width = newW, height = newH, alpha = 1.0, timeToFade = 0, needUpdate = true}
    table.insert(listMessages, msg)

	---------------------------------------------------------------
	-- Calculate width window
	---------------------------------------------------------------
	updateListSize()

	---------------------------------------------------------------
	-- Update edit boxes
	---------------------------------------------------------------
    updateListM()

end





---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------

local function hexColorToRGBA256(hexColor)
	-- hexColor строка в формате 0xrrggbbaa
	local r = base.tonumber(			base.string.sub(hexColor, 1, 4)	)	-- 0xrr
	local g = base.tonumber('0x' .. 	base.string.sub(hexColor, 5, 6)	)	-- 0xgg
	local b = base.tonumber('0x' ..	base.string.sub(hexColor, 7, 8)	)	-- 0xbb
	local a = base.tonumber('0x' ..	base.string.sub(hexColor, -2)	)	-- 0xaa
	
	return r, g, b, a
end

local function RGBA256ToHexColor(r, g, b, a)
	return string.format('0x%.2x%.2x%.2x%.2x', r, g, b, a)
end

---------------------------------------------------------------------------

function setTextAlpha(alpha, skin)
	skin = skin or Skin.staticSkin()
	
	local released = skin.skinData.states.released[2]
	
	released.text = released.text or Text.new()
	
	local r, g, b, a = hexColorToRGBA256(released.text.color)
	
	a = alpha * 255
	
	released.text.color = RGBA256ToHexColor(r, g, b, a)
	
	if released.text.shadowColor then
		local sr, sg, sb, sa = hexColorToRGBA256(released.text.shadowColor)
	
		if sa > a then
			sa = a
			released.text.shadowColor = RGBA256ToHexColor(sr, sg, sb, sa)
		end
	end
	
	return skin
end

---------------------------------------------------------------------------

local function setTextColor(color, skin)
	skin = skin or Skin.staticSkin()
	
	local released = skin.skinData.states.released[2]
	
	released.text = released.text or Text.new()
	released.text.color = color
    
    return skin
end


local function setFontSize(size, skin)
	skin = skin or Skin.staticSkin()
	
	local released = skin.skinData.states.released[2]
	
	released.text = released.text or Text.new()
	released.text.fontSize = size
    
    return skin
end

---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------



function updateListM()
    --for k,v in base.pairs(listStatics) do
    --   v:setText("")    
    --end

    local offset = 0
	local curMsg = #listMessages
    local curStatic = 1
    local num = 0
	local maxWidth = widthMsgBox
	local width = maxWidth
    if listMessages[curMsg] then

		while curMsg > 0 and num < maxLines do
            local msg = listMessages[curMsg]

			if msg.alpha > 0.0 and msg.needUpdate then

				setTextAlpha( msg.alpha, msg.skin )
				--setFontSize( 12, msg.skin )
				msg.height = heightStaticLine
				if listStatics[curStatic] then
					listStatics[curStatic]:setSkin(msg.skin)                                 
					listStatics[curStatic]:setBounds(0,offset*msg.height,msg.width,msg.height) 
					listStatics[curStatic]:setText(msg.message)
				end

			end

            offset = offset + 1
            curMsg = curMsg - 1
            curStatic = curStatic + 1
            num = num + 1
        end
    end    
end

function onShow(bShow)
	base.print("---onShow--- : ", bShow);
	show(bShow)
end

function show(bShow)
	if bShow == false then
        --saveBdaPos()
    end
	bBdaIsOnOff = false;
	if window then
		window:setVisible(bShow)
		bBdaIsOnOff = bShow;
	end
end

function onCreateBda()
	base.print("---onCreateBda()---");
    if bCreated == false then
        create()
    end
end

function onBdaShowF10(bValue)
	base.print("---onBdaShowF10()--- bValue , isOn(): ",bValue , isOn());
	if window and isOn() == true then
		if #listStatics == 0 then 
			window:setVisible(false)
			_bF10IsOn = false
		elseif #listMessages == 0 then
			window:setVisible(false)
			_bF10IsOn = false
		else
			window:setVisible(bValue)
			_bF10IsOn = bValue
		end
	else
		_bF10IsOn = false
	end
end

function onBdaShow(bValue)
	base.print("---onBdaShow()--- bValue , isOn(): ",bValue , isOn());
	if window and isOn() == true then
		window:setVisible(bValue)
		_bF10IsOn = bValue
	else
		_bF10IsOn = false
	end
end

function onBdaShowHide()
    base.print("---onBdaShowHide()---");
	onCreateBda()
	bBdaIsOnOff = not bBdaIsOnOff
    if isOn() == true then		

		clear()
		if window then
			setMode(modeCur)
			--[[
			window:setVisible(true)
			local message = cdata.rbdai.." is "..cdata.ON
			onBdaMessage(message, -1,0)
			timeUpdateStart = base.os.clock()
			startTime()
			]]
		end
    else

		clear()
		if window then
			setMode(modeCur)
			window:setVisible(false)
			--[[
			window:setVisible(true)
			local message = cdata.rbdai.." is "..cdata.OFF
			onBdaMessage(message, -1,0)
			timeUpdateStart = base.os.clock()
			startTimeOff()
			]]
		end
    end

end


function setMode(a_mode)
    base.print("BDA setMode: a_mode, bBdaIsOnOff = ", a_mode, bBdaIsOnOff)
	if isOn() == false or window == nil then
		return
	end
  
	modeCur = a_mode

	if modeCur == "movedOn" then
		window:setHasCursor(true)
	else
		window:setHasCursor(false)
	end

    updateListM()
end

function getMode()
    return modeCur
end

function isOn()
	return bBdaIsOnOff
end

local function parseSide(a_side)
    if a_side == 0 then
        return _("NEUTRAL_bda","NEUTRAL")
    elseif a_side == 1 then
        return _("RED_bda","RED")
    elseif a_side == 2 then
        return _("BLUE_bda","BLUE")
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
    if a_id == -1 then 
        return _("AI")
    end    
    local player_info = net.get_player_info(a_id)
    if player_info then
        --return cdata.player.." "..Censorship.censor(player_info.name)
		return Censorship.censor(player_info.name)
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
    end 
    return msg
end
    
function onGameBdaEvent(eventName,arg1,arg2,arg3,arg4,arg5,arg6,arg7) 
	base.print("onGameBdaEvent() arg1, bBdaIsOnOff ", arg1, bBdaIsOnOff)
	if isOn() == false then
		return
	end
    if eventName == "crash" then
        local unitType = slotByUnitId[arg2].type
        onBdaMessage(base.string.format("%s ".._("in_Bda", "in").." %s ".._("crashed"),getPlayerInfo(arg1),keys.getDisplayName(unitType)), -1, 1 )
    elseif eventName == "kill" then   --onGameEvent(kill,idPlayer1,typeP1,coalition1, idP2,typeP2, coalition2, weapon)
		if DCS.isMultiplayer() then
			
			local player = getPlayerName2(arg1).." "..arg2
			local deadobj = getPlayerName2(arg4).." "..arg5

			onBdaMessage(deadobj.." ".._("destroyed"), -1, 1 )
		else
			if arg7 and arg7 == "" then
				onBdaMessage(arg5.." ".._("destroyed"), 1, 1 )
			else
				onBdaMessage(arg7.." ".._("destroyed"), 1, 1 )
			end
		end
    elseif eventName == "self_kill" then 
        onBdaMessage(base.string.format("%s ".._("killed himself"),getPlayerInfo(arg1)), -1, 1 )
    elseif eventName == "pilot_death" then 
        onBdaMessage(base.string.format("%s ".._("died"),getPlayerInfo(arg1)), 1, 1 )
	elseif eventName == "damage" then 
		if DCS.isMultiplayer() then
			local player = getPlayerName2(arg4).." "..arg5
			if arg6 < 0.0 then 
				onBdaMessage(base.string.format("%s ".._("damaged"),player), -1, 0 )
			else
				onBdaMessage(base.string.format("%s ".._("damaged").." %d%% ",player, arg6), -1, 0 )
			end
		else
			if arg6 < 0.0 then 
				onBdaMessage(base.string.format("%s ".._("damaged"),arg5), -1, 0 )
			else
				if arg7 and arg7 == "" then
					onBdaMessage(base.string.format("%s ".._("damaged").." %d%% ",arg5, arg6), -1, 0 )
				else
					onBdaMessage(base.string.format("%s ".._("damaged").." %d%% ",arg7, arg6), -1, 0 )
				end
			end
		end
	elseif eventName == 'threat' then 	
			onBdaMessage(base.string.format("%.7f/%.7f/%.7f", arg1, arg2, arg3), -1, 0 )
	elseif eventName == 'score' then 	
			onBdaMessage(base.string.format("You scored +%.7f", arg1), -1, 0 )
       -- onBdaMessage(base.string.format("unknown %s %s %s",eventName, arg1 or "nil", arg2 or "nil" ,arg3  or "nil"), 0, 0 )
	elseif eventName == "agony" then 
		--[[
		if DCS.isMultiplayer() then
			
			local player = getPlayerName2(arg1).." "..arg2
			local deadobj = getPlayerName2(arg4).." "..arg5

			onBdaMessage(deadobj.." ".._("destroyed"), -1, 1 )
		else
		]]
			if arg7 and arg7 == "" then
				onBdaMessage(arg5.." ".._("critical damage"), 1, 1 )
			else
				onBdaMessage(arg7.." ".._("critical damage"), 1, 1 )
			end
		--end
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




