local base = _G

module('mul_voicechat')

local require = base.require
local tostring = base.tostring
local ipairs = base.ipairs
local pairs = base.pairs
local string = base.string
local print = base.print
local table = base.table

local i18n 			= require('i18n')
local DialogLoader	= require('DialogLoader')
local ListBoxItem	= require('ListBoxItem')
local voice_chat 	= base.safe_require('VoiceChat')
local DcsWeb 		= require('DcsWeb')
local DCS    		= require('DCS')
local TabGroupItem	= require('TabGroupItem')
local Button		= require('Button')
local ScrollPane 	= require('ScrollPane')
local Static		= require('Static')
local UpdateManager	= require('UpdateManager')
local net           = require('net')
local EditBox 		= require('EditBox')
local MsgWindow		= require('MsgWindow')
local optionsEditor = require('optionsEditor')
local Gui          	= require('dxgui')
local Input			= require('Input')
local Window		= require('Window')
local Skin          = require('Skin')
local ToggleButton	= require('ToggleButton')
local Tools  		= require('tools')
local lfs 			= require('lfs')
local RadioMod 		= require('presetsHandling')
local U             = require('me_utilities')


i18n.setup(_M)

cdata = {
	mute_mic 	= _("Mute mic"),
	voicechat 	= _("Voicechat"),
	common		= _("Common chat", "COMMON"),
	Radio		= _("Radio mode"),
	RadioIntercom = _("Radio/Intercom"),
	coalition	= _("COALITION"),
	Channel		= _("Channel"), 
	Sql			= _("Sql"), 	
	Encr		= _("Encr"), 	
	Pwr			= _("Pwr"), 	
	Guard		= _("Guard"), 	
	
	useMic		= _("Mic on"),
	muteMic		= _("Mic off"),
	pushMic		= _("Push to talk"),
	RPTT		= _("R PTT"),
	ION			= _("I ON"),
	IPTT		= _("I PTT"),
	
	Add_user	= _("Add user..."),
	CreateNewRoom = _("Click to create new room"),
	MyRoom		= _("My room"),
	Settings 	= _("Settings"),
	Remove		= _("Remove"),
	MinMode		= _("Minimized mode"),
	ShowGE		= _("Show Guard/Encryption"),
	ShowUV		= _("Show User Volume"),
	UseTURN		= _("Use TURN-server"),
	
	IntegratedRadioUnits	= _("Integrated Radio Units"),
	ExtraRadioUnits			= _("Extra Radio Units"),
	Intercom				= _("Intercom"),
	
	--Hints
	hintCollapseRooms 	= _("Minimize"),
	hintExpandRooms 	= _("Expand Rooms List"),
	hintSettings		= _("Settings"),	
	hintMicMode 		= _("Microphone mode, click to change"),
	hintClose			= _("Close window"),
	hintEnterRoom		= _("Enter new room name"),
	hintAddRoom			= _("Add room"),
	hintCollapsPeers	= _("Close Users List"),
	hintExpandPeers		= _("Expand Users List"),
	hintRoomName		= _("Room name"),
	hintDeleteRoom		= _("Delete room"),
	hintLeaveRoom		= _("Leave room"),
	hintOpenPeersList	= _("Open peers list"),
	hintDeletePeer		= _("Delete peer"),
	hintPeerName		= _("Peer name"),
	hintClosePeersList	= _("Close peers list"),
	hintAddPeer			= _("Add peer"),
	hintRemotePeerMicOn	= _("Mic. on"),
	hintRemotePeerMicOff= _("Mic. off"),
	Balance				= _("Balance"),
	Volume				= _("Volume"),
	MuteUser			= _("Mute User"),
	Volume				= _("User Volume"),
	ShowActiveUsers		= _("Show active users only"),
	TurnRadio			= _("Switch to radio on start"),
	InputVolume			= _("Input Volume"),
	MicrophoneTest		= _("Microphone test"),
	MasterVolume		= _("Master volume"),
	REMOTE				= _("REMOTE"),
	
	FM					= _('FM'),
	AM					= _('AM'),
	Hz					= _('Hz'),
	kHz					= _('kHz'),
	MHz					= _('MHz'),
	mW					= _('mW'),
	W					= _('W'),
	kW					= _('kW'),
	MW					= _('MW'),
	off					= _('OFF'),

}

local objRooms 					= {}
local users 					= {}
local radios 					= {}
local deployRooms 				= {}
local deployRadios 				= {}
local bStart 					= false
local bMicState 				= 0 	-- Use mic - 0 по дефолту,  Mute mic - 1, Push to talk - 2
local activeRoomId
local activeGroupId
local bExpand 					= true
local nameMini 					= ""
local my_peer_id 				= 0
local curMode 					= 0
local usersVoiceOnOffbtn 		= {} -- кнопки индикации звука
local guiRadiosById 			= {} -- панели радио по id
local dataRadiosById 			= {}
local radiosStates 				= {}
local keyboardLocked 			= false
local isFirstRadioListRequest 	= true
local chatPos 					= {} 

local function create_()
	window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_voicechat.dlg", cdata)
--	window:centerWindow()
	wWin, hWin = Gui.GetWindowSize()
	
	spBox 				= window.spBox
	bClose				= window.pTop.bClose	
	pNoVisible			= window.pNoVisible
	bMic				= window.pTop.bMic
	sION				= window.pTop.sION
	sRPTT				= window.pTop.sRPTT	
	panelAddUsers		= window.panelAddUsers
	bExitAddUsers		= panelAddUsers.bExitAddUsers
	spAddUsers			= panelAddUsers.spAddUsers
	tbMini				= window.pTop.tbMini
	pDown				= window.pDown
	eCreateRoom			= pDown.eCreateRoom
	bPlusRoom			= pDown.bPlusRoom -- кнопка добавить комнату
	sRadioNA			= window.pTop.sRadioNA
	tbRadio				= window.pTop.tbRadio
	bSettings			= window.pTop.bSettings
	
	panelSettings		= window.panelSettings
	bSettCancel			= panelSettings.bSettCancel
	cbShowActiveUsers 	= panelSettings.cbShowActiveUsers 
	cbTurnRadio			= panelSettings.cbTurnRadio		
	hsInputVolume		= panelSettings.hsInputVolume
	hsMasterVolume		= panelSettings.hsMasterVolume
	sInputVolumeWidget  = panelSettings.sInputVolumeWidget
	sMasterVolumeWidget = panelSettings.sMasterVolumeWidget
	hsMicrophoneTest	= panelSettings.hsMicrophoneTest
	cbShowGE			= panelSettings.cbShowGE
	cbShowUV			= panelSettings.cbShowUV
	cbUseTURN			= panelSettings.cbUseTURN
	
	btnItemRedSkin		= pNoVisible.btnItemRed:getSkin()	
	btnItemRedBoldSkin	= pNoVisible.btnItemRedBold:getSkin()
	btnItemBlueSkin		= pNoVisible.btnItemBlue:getSkin()
	btnItemBlueBoldSkin	= pNoVisible.btnItemBlueBold:getSkin()
	btnItemGraySkin		= pNoVisible.btnItemGray:getSkin()
	btnItemGrayBoldSkin	= pNoVisible.btnItemGrayBold:getSkin()
	
	bExpandSkin 		= pNoVisible.bExpand:getSkin()
	bRollupSkin			= pNoVisible.bRollup:getSkin()
	bDelSkin			= pNoVisible.bDel:getSkin()
	bSettSkin			= pNoVisible.bSett:getSkin()
	bOutSkin			= pNoVisible.bOut:getSkin()
	spUsersSkin 		= pNoVisible.spUsers:getSkin()
	bUserSkin			= pNoVisible.bUser:getSkin()
	bUserActiveSkin		= pNoVisible.bUserActive:getSkin()
	bAddUserSkin		= pNoVisible.bAddUser:getSkin()
	bPlusSkin			= pNoVisible.bPlus:getSkin()
	sPlugSkin			= pNoVisible.sPlug:getSkin()
	bCloseSkin			= pNoVisible.bClose:getSkin()
	bDefaultMicSkin		= bMic:getSkin()
	clNormalSkin		= pNoVisible.clNormal:getSkin()
	clRedSkin			= pNoVisible.clRed:getSkin()
	bHighlightMicSkin	= pNoVisible.bHighlight:getSkin()
	tbVoiceOnSkin		= pNoVisible.tbVoiceOn:getSkin()
	tbVoiceOffSkin		= pNoVisible.tbVoiceOff:getSkin()
	sPTTredSkin			= pNoVisible.sPTTred:getSkin()
	sPTTgreenSkin		= pNoVisible.sPTTgreen:getSkin()
	sPTTyelloySkin		= pNoVisible.sPTTyelloy:getSkin()
	sPTTgraySkin		= pNoVisible.sPTTgray:getSkin()
	sRPTTredSkin		= pNoVisible.sRPTTred:getSkin()
	sRPTTgreenSkin		= pNoVisible.sRPTTgreen:getSkin()
	sRPTTyelloySkin		= pNoVisible.sRPTTyelloy:getSkin()
	sRPTTgraySkin		= pNoVisible.sRPTTgray:getSkin()
	pNormalSkin			= pNoVisible.pNormal:getSkin()
	pTransDisSkin		= pNoVisible.pTransDis:getSkin()
	
	panelSettingsUser	= window.panelSettingsUser	
	bSettUserCancel		= panelSettingsUser.bSettUserCancel
	cbMuteUser			= panelSettingsUser.cbMuteUser
	hsVolumeUser		= panelSettingsUser.hsVolumeUser
	sVolumeWidget		= panelSettingsUser.sVolumeWidget
	bRemoveUser			= panelSettingsUser.bRemoveUser
	
	panelRadioTempl		= pNoVisible.panelRadio	
	panelType0Templ		= pNoVisible.panelRadioType0
	pIntegratedTempl	= pNoVisible.pIntegrated
	pExtraTempl			= pNoVisible.pExtra
	pIntercomTempl		= pNoVisible.pIntercom 
	
	
	windowSettUser		= Window.new()	
	windowSettUser:setSkin(Skin.windowSkinChatMin())
	windowSettUser:setZOrder(10001)
	windowSettUser:setBounds(0, 0, 305, 215)
	window:removeWidget(panelSettingsUser)
	windowSettUser:insertWidget(panelSettingsUser)	
	panelSettingsUser:setPosition(0,0)	
	
	
	bClose:setTooltipText(cdata.hintClose)
	bClose.onChange = function()
		hidePanelAddUsers()
		window:setVisible(false)
		panelSettings:setVisible(false)
		voice_chat.onOffMicTest(false) 
		unlockKeyboardInput()
	end
	
	eCreateRoom:setText(cdata.CreateNewRoom)
	eCreateRoom:addFocusCallback(function(self, x, y, button)
		if self:getFocused() == true then
			lockKeyboardInput()
			if cdata.CreateNewRoom == self:getText() then	
				self:setText("")
			end
		else
			if "" == self:getText() then
				self:setText(cdata.CreateNewRoom)
			end
			unlockKeyboardInput()						
		end
	end)
	
	function eCreateRoom:onKeyDown(key, unicode) 
        if 'return' == key then            
            onCreateRoom()
			eCreateRoom:setFocused(false)
        end
		if 'escape' == key then            
            eCreateRoom:setText(cdata.CreateNewRoom)
			eCreateRoom:setFocused(false)
        end
    end
	
	bPlusRoom.onChange 			= onCreateRoom
	bSettings.onChange 			= onChange_bSettings
	cbShowActiveUsers.onChange 	= onChange_cbShowActiveUsers
	cbTurnRadio.onChange		= onChange_cbTurnRadio	
	bSettCancel.onChange 		= onChange_bSettCancel
	tbRadio.onChange 			= onChange_tbRadio
	hsInputVolume.onChange 		= onChange_hsInputVolume
	hsMasterVolume.onChange		= onChange_hsMasterVolume
	cbShowGE.onChange			= onChange_cbShowGE
	cbShowUV.onChange			= onChange_cbShowUV
	cbUseTURN.onChange			= onChange_cbUseTURN
	
	cbMuteUser.onChange 		= onChange_cbMuteUser
	hsVolumeUser.onChange 		= onChange_hsVolumeUser
	bRemoveUser.onChange 		= onChange_bRemoveUser
	
	bSettUserCancel.onChange 	= onChange_bSettUserCancel	

	
	bMic.onChange = onChange_bMic
	
	bExitAddUsers:setTooltipText(cdata.hintClosePeersList)
	bExitAddUsers.onChange = onChange_bExitAddUsers
	
	tbMini:setTooltipText(cdata.hintCollapseRooms)
	tbMini.onChange = onChange_tbMini
	
	loadVCPos()  
	window:setPosition((chatPos and chatPos.x) or 0, (chatPos and chatPos.y) or 40)

	window:setSize(353, 768)
	spBox:setSize(353, 550)
		
	panelSettings:setPosition(30,30)
	
	windowSettUser:setVisible(false)
	panelSettings:setVisible(false)
	panelAddUsers:setVisible(false)
	
	setStateText_bMic(bMicState)
	
	tbMini:setState(false)	
	

	Gui.AddMouseCallback('down', function(x, y, button)
		if windowSettUser:getVisible() == true then
			local tmpX, tmpY, tmpW, tmpH = windowSettUser:getBounds()		
			if x < tmpX or x > (tmpX + tmpW)
			 or y < tmpY or y > (tmpY + tmpH) then
				windowSettUser:setVisible(false)
			end
		end
	end)

--	bSettings:setVisible(false)
	sRadioNA:setVisible(false)
	tbRadio:setVisible(false)

	
end

function getTxtModulation(a_modulation)
	if a_modulation == 0 then
		return cdata.AM
	else
		return cdata.FM
	end
end

function setStateText_bMic(a_bMicState)
	if a_bMicState == 0 then
		bMic:setText(cdata.useMic)
	elseif a_bMicState == 1 then
		bMic:setText(cdata.muteMic)
	else
		bMic:setText(cdata.pushMic)
	end
end

function setSkin_bMic(a_bMicState)
	if a_bMicState == 0 then
		bMic:setSkin(bHighlightMicSkin)
	else
		bMic:setSkin(bDefaultMicSkin)
	end
end

function hidePanelAddUsers()
	panelAddUsers:setVisible(false)-- при любом действии скрываем панель добавления юзеров
	local tmpX, tmpY = spBox:getSize()
	
	updateSize()
end		

function onChange_bMic()
	hidePanelAddUsers()
	bMicState = bMicState + 1
	if bMicState > 2 then
		bMicState = 0
	end
	
	setSkin_bMic(bMicState)
	setStateText_bMic(bMicState)	
	voice_chat.setMicMode(bMicState)
end

function onChange_tbMini()
	bExpand = not(tbMini:getState())
	
	if (bExpand) then
		tbMini:setTooltipText(cdata.hintCollapseRooms)	
		update()
	else
		tbMini:setTooltipText(cdata.hintExpandRooms)
		update()
	end
end

function updateMicState()
	if voice_chat == nil then 
		return
	end
	
	if not window then
		create_()
	end	
	
	bMicState = voice_chat.getMicMode()
	setSkin_bMic(bMicState)
	setStateText_bMic(bMicState)
end

function onChange_bExitAddUsers()
	hidePanelAddUsers()
end

-- show window
function show(b)
	if voice_chat == nil then 
		return
	end
	
	if b then
		if not window then
			create_()
		end	
	end

	if window then
		window:setVisible(b)
		if b == false then
			voice_chat.onOffMicTest(false) 
		end
	end
	
	if b then
		update()
	end
end

function loadVCPos()
    local tbl = Tools.safeDoFile(lfs.writedir() .. 'Config/VCPosition.lua', false)
    if (tbl and tbl.chatPos and tbl.chatPos.x and tbl.chatPos.y) then		 
        chatPos.x = tbl.chatPos.x
        chatPos.y = tbl.chatPos.y
		
		if (wWin < chatPos.x+20) then
			chatPos.x = wWin-20
		end
		
		if (-333 > chatPos.x) then
			chatPos.x = -333
		end

		if (hWin < chatPos.y+20) then
			chatPos.y = hWin-20
		end

		if (0 > chatPos.y) then
			chatPos.y = 0
		end	
    end 
end

function saveVCPos()
    chatPos.x, chatPos.y = window:getPosition()
    U.saveInFile(chatPos, 'chatPos', lfs.writedir() .. 'Config/VCPosition.lua')	
end

-- 0-gray, 1-yelloy, 2-green, 3-red
function getSkinRPTT()
	local state = 0
	local skin = sRPTTgraySkin
	if radios then
		if radios.integrated then
			for k,v in base.pairs(radios.integrated) do
				if radiosStates[v.number] then
					if radiosStates[v.number] == 2 then
						return sRPTTgreenSkin
					elseif radiosStates[v.number] == 3 then
						state = 3
						skin = sRPTTredSkin
					elseif state~= 3 and radiosStates[v.number] == 1 then
						state = 1
						skin = sRPTTyelloySkin
					end
				end
			end
		end
	
		if radios.extra then
			for k,v in base.pairs(radios.extra) do
				if radiosStates[v.number] then
					if radiosStates[v.number] == 2 then
						return sRPTTgreenSkin
					elseif radiosStates[v.number] == 3 then
						state = 3
						skin = sRPTTredSkin
					elseif state~= 3 and radiosStates[v.number] == 1 then
						state = 1
						skin = sRPTTyelloySkin
					end
				end
			end
		end
	end
	return skin
end

-- RADIO
function updateRadio(number, handler)	
	if voice_chat == nil then 
		return
	end
	
	local str_handler = ""
	local value = 0		
	if (number >= 0) then	-- USING RADIO_PARAMETERS		
		if handler == voice_chat.RadioHandlers.ON_OFF_STATUS then --0 RADIO_PARAMETERS::ON_OFF_STATUS
			str_handler = "RADIO_ON_OFF_STATUS"
			value = voice_chat.getRadioIndication(0, number, voice_chat.RadioHandlers.ON_OFF_STATUS) --first parameter is hanler type: 0 - RADIO_PARAMETERS
			if guiRadiosById[number] then
				if value == 3 then
					guiRadiosById[number].sPTT:setSkin(sPTTredSkin)
					radiosStates[number] = 3
				elseif value == 1 then
					guiRadiosById[number].sPTT:setSkin(sPTTyelloySkin)
					radiosStates[number] = 1
				elseif value == 2 then
					guiRadiosById[number].sPTT:setSkin(sPTTgreenSkin)
					radiosStates[number] = 2
				elseif value == 0 then
					guiRadiosById[number].sPTT:setSkin(sPTTgraySkin)
					radiosStates[number] = 0
				end
				sRPTT:setSkin(getSkinRPTT())
			end
		elseif handler == voice_chat.RadioHandlers.FREQUENCY then --1 RADIO_PARAMETERS::FREQUENCY
			str_handler = "RADIO_FREQUENCY"
			value = voice_chat.getRadioFrequency(number)
			base.print("--updateRadio--",number,value)

			if guiRadiosById[number] then	
				set_eFreqText(guiRadiosById[number].eFreq, value)	
			end	
			if dataRadiosById[number] then
				dataRadiosById[number].frequency = value
			end
		elseif handler == voice_chat.RadioHandlers.SOUND_VOLUME then --2 RADIO_PARAMETERS::SOUND_VOLUME
			str_handler = "RADIO_SOUND_VOLUME"
			value = voice_chat.getRadioVolume(number)
			if guiRadiosById[number] and guiRadiosById[number].type ~= 0 then
				guiRadiosById[number].pVolume.hsVolume:setValue(value)
			end	
			if dataRadiosById[number] then
				dataRadiosById[number].soundVolume = value
			end
		elseif handler == voice_chat.RadioHandlers.CHANNEL then --3 RADIO_PARAMETERS::CHANNEL
			str_handler = "RADIO_CHANNEL"
			value = voice_chat.getRadioChannel(number)
			if guiRadiosById[number] then
				if guiRadiosById[number].type == 0 then
					guiRadiosById[number].eChannel:setText(value)
				else
					setList(guiRadiosById[number].clChannel, value)
				end
			end
			if dataRadiosById[number] then
				dataRadiosById[number].channel = value
			end
		elseif handler == voice_chat.RadioHandlers.MODULATION then --4 RADIO_PARAMETERS::MODULATION
			str_handler = "RADIO_MODULATION"
			value = voice_chat.getRadioModulation(number)
			if guiRadiosById[number] then
				if guiRadiosById[number].type == 0 then
					guiRadiosById[number].eMod:setText(getTxtModulation(value))
				else
					setListMod(guiRadiosById[number].clMod, value)
				end
			end
			if dataRadiosById[number] then
				dataRadiosById[number].modulation = value
			end
		elseif handler == voice_chat.RadioHandlers.GUARD_STATUS then --5 RADIO_PARAMETERS::GUARD_STATUS
			str_handler = "RADIO_GUARD_STATUS"
			value = voice_chat.getRadioGuardReceiverOnOff(number)
			local guard = voice_chat.getRadioGuardReceiverFrequency(number)
			
			if guiRadiosById[number] then
				if guiRadiosById[number].type == 0 then
					local eGuard = guiRadiosById[number].eGuard	
					
					if value == false then 			
						eGuard:setText(cdata.off)
						guiRadiosById[number].sGuardMHz:setVisible(false)
					else						
						set_eFreqText(guiRadiosById[number].eGuard, guard)
						guiRadiosById[number].sGuardMHz:setVisible(true)	
					end	
				else
					if value == false then 			
						setList(guiRadiosById[number].clGuard, "off")
					else
						setList(guiRadiosById[number].clGuard, guard)
					end		
				end				
			end
	
			if dataRadiosById[number] then
				dataRadiosById[number].guard = guard
				dataRadiosById[number].guardStatusOnOff = value
			end
		elseif handler == voice_chat.RadioHandlers.ENCRYPTION_STATUS then --6 RADIO_PARAMETERS::ENCRYPTION_STATUS 	
			str_handler = "ENCRYPTION_STATUS"
			value = voice_chat.getEncryptionEnabled(number)
			if guiRadiosById[number] then
				guiRadiosById[number].cbEncryption:setState(value)
				guiRadiosById[number].sbEncryption:setEnabled(value)
			end
			if dataRadiosById[number] then
				dataRadiosById[number].isEncryptionEnabled = value
			end			
		elseif handler == voice_chat.RadioHandlers.CRYPTO_KEY then -- 7 RADIO_PARAMETERS::CRYPTO_KEY 
			str_handler = "RADIO_CRYPTO_KEY"
			value = voice_chat.getRadioEncryptionKey(number)
			if guiRadiosById[number] then
				guiRadiosById[number].sbEncryption:setValue(value)
			end
			if dataRadiosById[number] then
				dataRadiosById[number].encryptionKey = value
			end
		elseif handler == voice_chat.RadioHandlers.SQUELCH_STATUS then --8 RADIO_PARAMETERS::SQUELCH_STATUS
			str_handler = "RADIO_SQUELCH_STATUS"
			value = voice_chat.getRadioSquelchOnOff(number)
			if guiRadiosById[number] and guiRadiosById[number].type ~= 0 then
				guiRadiosById[number].pMisc.cbSquelch:setState(value)
			end
			if dataRadiosById[number] then
				dataRadiosById[number].squelchStatus = value
			end
		elseif handler == voice_chat.RadioHandlers.TRANSMITTER_PWR then --9 RADIO_PARAMETERS::TRANSMITTER_PWR
			str_handler = "RADIO_TRANSMITTER_PWR"
			value = voice_chat.getRadioPower(number)
			if guiRadiosById[number] and guiRadiosById[number].type ~= 0 then
				setList(guiRadiosById[number].pMisc.clPower, value)
			end	
			if dataRadiosById[number] then
				dataRadiosById[number].transmitterPower = value
			end
		elseif handler == voice_chat.RadioHandlers.TRANSMISSION_ENABLED then  --11 RADIO_PARAMETERS::TRANSMISSION_ENABLED
			str_handler = "RADIO_TRANSMISSION_ENABLED"
			value = voice_chat.isRadioAvailableForTransmission(number)
			if guiRadiosById[number] then
				if value ~= false then
					guiRadiosById[number]:setSkin(pNormalSkin)
				else
					guiRadiosById[number]:setSkin(pTransDisSkin)
				end
				if dataRadiosById[number] then
					dataRadiosById[number].isTransmissionAvailable = value
				end	
			end			
		elseif handler == voice_chat.RadioHandlers.IS_TRANSMITTING or -- 10 RADIO_PARAMETERS::IS_TRANSMITTING
				handler == voice_chat.RadioHandlers.CURRENT_RECEIVING_RADIO then -- RADIO_PARAMETERS::RADIO_PARAMETERS_MAX
			
			if handler == voice_chat.RadioHandlers.IS_TRANSMITTING then
				str_handler = "IS_TRANSMITTING"
			else
				str_handler = "CURRENT_RECEIVING_RADIO"
			end	
			
			if guiRadiosById[number] then
				radiosStates[number] = voice_chat.getRadioIndication(0, number, handler)
				if radiosStates[number] == 1 then
					guiRadiosById[number].sPTT:setSkin(sPTTyelloySkin)
				elseif radiosStates[number] == 2 then
					guiRadiosById[number].sPTT:setSkin(sPTTgreenSkin)
				elseif radiosStates[number] == 3 then
					guiRadiosById[number].sPTT:setSkin(sPTTredSkin)
				end
					
				sRPTT:setSkin(getSkinRPTT())
			end
		elseif handler == voice_chat.RadioHandlers.EXTERNALY_CONTROLLED	then
			str_handler = "RADIO_PARAMETERS_SINGLETONS::EXTERNALY_CONTROLLED"
			if voice_chat.getIsExternallyControlled(number) == true then
				guiRadiosById[number].sNameRadio:setText((dataRadiosById[number].display_num or '').." "..dataRadiosById[number].name.." [".. cdata.REMOTE.."]")
				guiRadiosById[number].pVolume.hsVolume:setEnabled(false)
				guiRadiosById[number].pMisc.clPower:setEnabled(false)
				guiRadiosById[number].pMisc.cbSquelch:setEnabled(false)
				guiRadiosById[number].clGuard:setEnabled(false)				
				guiRadiosById[number].sbEncryption:setEnabled(false)
				guiRadiosById[number].cbEncryption:setEnabled(false)
				guiRadiosById[number].clMod:setEnabled(false)
				guiRadiosById[number].eFreq:setEnabled(false)
				guiRadiosById[number].bDecFreq:setEnabled(false)
				guiRadiosById[number].bIncFreq:setEnabled(false)
				guiRadiosById[number].clChannel:setEnabled(false)				
			else
				guiRadiosById[number].sNameRadio:setText((dataRadiosById[number].display_num or '').." "..dataRadiosById[number].name)
				guiRadiosById[number].pVolume.hsVolume:setEnabled(true)
				guiRadiosById[number].pMisc.clPower:setEnabled(true)
				guiRadiosById[number].pMisc.cbSquelch:setEnabled(true)
				guiRadiosById[number].clGuard:setEnabled(true)
				guiRadiosById[number].sbEncryption:setEnabled(voice_chat.getEncryptionEnabled(number))
				guiRadiosById[number].cbEncryption:setEnabled(true)
				guiRadiosById[number].clMod:setEnabled(true)
				guiRadiosById[number].eFreq:setEnabled(true)
				guiRadiosById[number].bDecFreq:setEnabled(true)
				guiRadiosById[number].bIncFreq:setEnabled(true)
				guiRadiosById[number].clChannel:setEnabled(true)				
			end
				
			
			
		end -- end if handler == voice_chat.RadioHandlers.XXXX
	else	-- USING RADIO_PARAMETERS_SINGLETONS
		if handler == voice_chat.RadioHandlersSingletons.INTERCOM_SOUND_VOLUME then -- RADIO_PARAMETERS_SINGLETONS::INTERCOM_SOUND_VOLUME
			str_handler = "RADIO_PARAMETERS_SINGLETONS::INTERCOM_SOUND_VOLUME"
			-- value = [0 .. 100]
			value = voice_chat.getIntercomVolume()
			voice_chat.updateCrewVolume(value)
		elseif handler == voice_chat.RadioHandlersSingletons.INTERCOM_HOT_MIKE_STATUS then -- RADIO_PARAMETERS_SINGLETONS::INTERCOM_HOT_MIKE_STATUS
			str_handler = "RADIO_PARAMETERS_SINGLETONS::INTERCOM_HOT_MIKE_STATUS"
			-- value: 0 - PTT mode, 1 - ALWAYS_ON mode
			value = voice_chat.getIntercomMode()
			
			if value == 0 then
				sION:setText(cdata.IPTT)
			else
				sION:setText(cdata.ION)
			end
		end
		
		if handler ~= voice_chat.RadioHandlersSingletons.INTERCOM_SOUND_VOLUME then
			local intercom_indication = voice_chat.getIntercomIndication()
			local pIntercom = guiRadiosById["intercom"] 
			
			if intercom_indication == 3 then
				pIntercom.sPTT:setSkin(sPTTredSkin)
				sION:setSkin(sRPTTredSkin)
			elseif intercom_indication == 1 then
				pIntercom.sPTT:setSkin(sPTTyelloySkin)
				sION:setSkin(sRPTTyelloySkin)
			elseif intercom_indication == 2 then
				pIntercom.sPTT:setSkin(sPTTgreenSkin)
				sION:setSkin(sRPTTgreenSkin)
			elseif intercom_indication == 0 then
				pIntercom.sPTT:setSkin(sPTTgraySkin)
				sION:setSkin(sRPTTgraySkin)
			end
		end
	end
	base.print("Handler : Value", str_handler, value)
end

function updateIndication(peerID, voiceOnOff)
	if voice_chat == nil then 
		return
	end
	
	local activeOwnerId, activeRoomId, activeRoomType, activeUnitId = voice_chat.getActiveRoom()
	local roomKey = getRoomKey(activeOwnerId, activeRoomId, activeRoomType, activeUnitId)
	if roomKey and usersVoiceOnOffbtn[roomKey] and usersVoiceOnOffbtn[roomKey][peerID] then
		if voiceOnOff == true then
			usersVoiceOnOffbtn[roomKey][peerID].on:setVisible(true)
			usersVoiceOnOffbtn[roomKey][peerID].off:setVisible(false)
		else
			usersVoiceOnOffbtn[roomKey][peerID].on:setVisible(false)
			usersVoiceOnOffbtn[roomKey][peerID].off:setVisible(true)
		end
	end
end

function updateMicrophoneTest(a_value)	
	if hsMicrophoneTest then
		hsMicrophoneTest:setValue(a_value)
	end
end

function reCreateRadios()
	radios = voice_chat.getRadioList()
		
	--base.U.traverseTable(radios)
	--base.print("--xxx radios--",radios)
		
	guiRadiosById = {}
	dataRadiosById = {}
	
	bMic:setVisible(false)
	sION:setVisible(true)
	sRPTT:setVisible(true)
	pDown:setVisible(false)
	
	guiRadiosById["integrated"] = pIntegratedTempl:clone()
	guiRadiosById["extra"] = pExtraTempl:clone()
	guiRadiosById["intercom"] = pIntercomTempl:clone()
	
	spBox:insertWidget(guiRadiosById["integrated"])
	spBox:insertWidget(guiRadiosById["extra"])
	spBox:insertWidget(guiRadiosById["intercom"])
	
	guiRadiosById['integrated'].bDeploy:addChangeCallback(function()
				deployRadios['integrated'] = not deployRadios['integrated']
				UpdateManager.add(function()
							fillRadios(radios)
							return true
							end)
			end)
			
	guiRadiosById['extra'].bDeploy:addChangeCallback(function()
				deployRadios['extra'] = not deployRadios['extra']
				UpdateManager.add(function()
							fillRadios(radios)
							return true
							end)
			end)		
			
	for k,cat in base.pairs({radios.extra, radios.integrated}) do		
		for k,v in base.pairs(cat) do	
			dataRadiosById[v.number] = v
			if v.type == 1 or v.type == 2 then
				-- тип 1 и 2
				v.preset = RadioMod.getPreset(v.ID)		
				local pRadio = panelRadioTempl:clone()
				guiRadiosById[v.number] = pRadio
				pRadio.type = v.type
				
				pRadio.bDeploy:addChangeCallback(function()
					deployRadios[v.number] = not deployRadios[v.number]
					UpdateManager.add(function()
								fillRadios(radios)
								return true
								end)
				end)
				spBox:insertWidget(pRadio)
							
				fillListChannel(pRadio.clChannel, v.preset.Channels)
				fillListPower(pRadio.pMisc.clPower, v.preset.Power)
				fillListGuard(pRadio.clGuard, v.preset.Guards)
				fillListMod(pRadio.clMod, v.preset.Ranges)
				
				if pRadio.clChannel:getItemCount() < 2 then
					pRadio.clChannel:setVisible(false)
					pRadio.sChannel:setVisible(false)
				else
					pRadio.clChannel:setVisible(true)
					pRadio.sChannel:setVisible(true)
				end
				
				pRadio.clChannel.number = v.number				
				pRadio.clChannel:addChangeCallback(function(self)										
					local channel = guiRadiosById[self.number].clChannel:getSelectedItem().id
					if channel == nil then
						verifyChannel(self)	
						channel = guiRadiosById[self.number].clChannel:getSelectedItem().id
					end
					 
					if channel then
						local tmpFreq = dataRadiosById[self.number].preset.Channels[channel].freq
						voice_chat.setRadioFrequency(self.number, 1, tmpFreq)						
						set_eFreqText(guiRadiosById[self.number].eFreq, tmpFreq)	
					end
				end)
				
				pRadio.pMisc.clPower.number = v.number	
				pRadio.pMisc.clPower:addChangeCallback(function(self)
					local value = guiRadiosById[self.number].pMisc.clPower:getSelectedItem().id
					voice_chat.setRadioPower(self.number, value)
				end)
				
				pRadio.clGuard.number = v.number			
				pRadio.clGuard:addChangeCallback(function(self)
					local id = guiRadiosById[self.number].clGuard:getSelectedItem().id
					local mod = guiRadiosById[self.number].clGuard:getSelectedItem().mod
					if id == "off" then
						voice_chat.setRadioGuardReceiverOnOff(self.number, false)
					else
						voice_chat.setRadioGuardReceiverOnOff(self.number, true)
						voice_chat.setRadioGuardReceiverFrequency(self.number, id)
						voice_chat.setRadioGuardReceiverModulation(self.number, mod) 
					end
				end)
				
				pRadio.sbEncryption.number = v.number	
				pRadio.sbEncryption:addChangeCallback(function(self)					
					voice_chat.setRadioEncryptionKey(self.number, guiRadiosById[self.number].sbEncryption:getValue()) 					
				end)
				
				pRadio.sbEncryption:addFocusCallback(function(self)
					if self:getFocused() == true then 
						lockKeyboardInput()
					else
						unlockKeyboardInput()
					end
				end)
				
				pRadio.cbEncryption.number = v.number
				pRadio.cbEncryption:addChangeCallback(function(self)
					voice_chat.setEncryptionEnabled(self.number, guiRadiosById[self.number].cbEncryption:getState())
					guiRadiosById[self.number].sbEncryption:setEnabled(guiRadiosById[self.number].cbEncryption:getState())
				end)

				pRadio.pMisc.cbSquelch.number = v.number
				pRadio.pMisc.cbSquelch:addChangeCallback(function(self)
					voice_chat.setRadioSquelchOnOff(self.number, guiRadiosById[self.number].pMisc.cbSquelch:getState())
				end)				
				
				pRadio.clMod.number = v.number	 
				pRadio.clMod:addChangeCallback(function(self)
					voice_chat.setRadioModulation(self.number, guiRadiosById[self.number].clMod:getSelectedItem().modulation)	
					correctFreq(self)
				end)
				
				pRadio.bDecFreq.number = v.number
				pRadio.bDecFreq:addChangeCallback(onChange_bDecFreq)

				pRadio.bIncFreq.number = v.number
				pRadio.bIncFreq:addChangeCallback(onChange_bIncFreq)
				
				pRadio.eFreq.number = v.number
				pRadio.eFreq:addFocusCallback(function(self)
					if self:getFocused() then
						lockKeyboardInput()
					else 
						correctFreq(self)
						unlockKeyboardInput()
					end
				end)
				
				pRadio.eFreq:addKeyDownCallback(function(self,key, unicode)					
					if 'return' == key then 
						self:setFocused(false) 
					end
				end)
				
				pRadio.pVolume.hsVolume.number = v.number
				pRadio.pVolume.hsVolume:addChangeCallback(function(self)
					voice_chat.setRadioVolume(self.number, guiRadiosById[self.number].pVolume.hsVolume:getValue())						
				end)
			else
				-- тип 0
				local pRadio = panelType0Templ:clone()

				guiRadiosById[v.number] = pRadio
				pRadio.type = v.type
				
				pRadio.bDeploy:addChangeCallback(function()
					deployRadios[v.number] = not deployRadios[v.number]
					UpdateManager.add(function()
								fillRadios(radios)
								return true
								end)
				end)
				spBox:insertWidget(pRadio)	

				pRadio.sbEncryption.number = v.number	
				pRadio.sbEncryption:addChangeCallback(function(self)
					voice_chat.setRadioEncryptionKey(self.number, guiRadiosById[self.number].sbEncryption:getValue()) 
				end)
				
				pRadio.sbEncryption:addFocusCallback(function(self)
					if self:getFocused() == true then 
						lockKeyboardInput()
					else
						unlockKeyboardInput()
					end
				end)

				pRadio.cbEncryption.number = v.number
				pRadio.cbEncryption:addChangeCallback(function(self)
					voice_chat.setEncryptionEnabled(self.number, guiRadiosById[self.number].cbEncryption:getState())
					guiRadiosById[self.number].sbEncryption:setEnabled(guiRadiosById[self.number].cbEncryption:getState())
				end)			
				
				pRadio.eChannel:setEnabled(false)
				pRadio.eFreq:setEnabled(false)
				pRadio.eMod:setEnabled(false)
				pRadio.eGuard:setEnabled(false)
			end
		end
	end
		
	fillRadios(radios)		
end

function update() 
	if voice_chat == nil then 
		return
	end
	
	if not window then
		create_()
	end	
	
	updateMode()
		
	if ((curMode == 0) or 
		(curMode == 1 and isFirstRadioListRequest == true)) then
		spBox:clear()
		objRooms = {}
		yOffset = 0	
	end
	
	if (curMode == 1) then
		if (isFirstRadioListRequest) then
			reCreateRadios()
			isFirstRadioListRequest = false
		end
	else
		bMic:setVisible(true)
		sION:setVisible(false)
		sRPTT:setVisible(false)
		-- { {owner_peer_id = 0, room_id = 1, type = 0, unit_id = number, side = number, name = 'common', dispname = 'common', access_peer_list = {1,2,3 ..}}, ... }
		local listRoomsTMP = voice_chat.getRooms()

		-- { {peer_id = number, peer_name= "peer_name", side = number, owner_peer_id = 6, room_id = number, is_mute = bool}, ... }
		users = voice_chat.getPeersList()
	
		if listRoomsTMP == nil then
			return
		end
		
		local listRooms ={}
		listRooms.PERSISTENT = {}
		listRooms.MULTICREW = {}
		listRooms.MANAGEABLE = {}
		
		for k, v in base.pairs(listRoomsTMP) do
			if v.type == voice_chat.RoomType.PERSISTENT then
				base.table.insert(listRooms.PERSISTENT, v)
			end
			
			if v.type == voice_chat.RoomType.MULTICREW then
				base.table.insert(listRooms.MULTICREW, v)
			end

			if v.type == voice_chat.RoomType.MANAGEABLE then
				base.table.insert(listRooms.MANAGEABLE, v)
			end
		end
		
		--base.U.traverseTable(listRooms)
		--base.U.traverseTable(users)
		--base.print("---listRooms---")

		fillRooms(listRooms)
	end	
	
end

function updateMode()
	if voice_chat.isInUnit() then
		curMode = voice_chat.getVoiceChatMode(my_peer_id) --0 - ROOM, либо 1 - RADIO
		sRadioNA:setVisible(false)
		tbRadio:setVisible(true)
			
		if curMode == 0 then
			tbRadio:setState(true)	
			bMic:setEnabled(true)
			isFirstRadioListRequest = true
		else
			tbRadio:setState(false)	
			bMic:setEnabled(false)
		end
	else
		sRadioNA:setVisible(true)
		tbRadio:setVisible(false)
		
		curMode = 0
		bMic:setEnabled(true)
		isFirstRadioListRequest = true
		tbRadio:setState(true)	
	end
	
	if curMode == 1 then
		if voice_chat.isIntercom() then					
			window:setText(cdata.RadioIntercom)				
		else
			window:setText(cdata.Radio)				
		end		
	else
		window:setText(nameMini)
	end	
end

function updateSize()
	local tmpX, tmpY, tmpW, tmpH = window:getBounds()
	local sizeW  = 353
	
	local tmpX, tmpY = spBox:getSize()
	
	if bExpand == true then 
		tmpH = tmpY+47+50+20
	else
		tmpH = 70
	end
	
	if curMode == 0 then
		if panelAddUsers:getVisible() == true then
			local tmpuX, tmpuY, tmpuW, tmpuH = panelAddUsers:getBounds()

			if (tmpH) < (tmpuY+tmpuH+20) then
				tmpH = tmpuY+tmpuH+20
			end
		end
	end

	if panelSettings:getVisible() == true then		
		if tmpH < 384 then
			tmpH = 384
		end	
	end
	
	window:setSize(sizeW, tmpH)
end

function onChange_tbRadio()
	if tbRadio:getState() == true then
		voice_chat.setVoiceChatMode(0) -- RADIO
	else
		voice_chat.setVoiceChatMode(1) -- ROOM
	end
	update()
end


function onChange_bSettings()
	panelSettings:setVisible(not panelSettings:getVisible())

	updateSize()
	
	if panelSettings:getVisible() then
		local opt = voice_chat.getOptions() 

		if opt then
			cbTurnRadio:setState(opt.is_auto_switch_to_radio)
			cbShowActiveUsers:setState(opt.show_active_users)
			hsInputVolume:setValue(opt.input_volume_level)			
			sInputVolumeWidget:setText(opt.input_volume_level.."%")
			hsMasterVolume:setValue(opt.master_volume)			
			sMasterVolumeWidget:setText(opt.master_volume.."%")		
			cbShowGE:setState(opt.show_guard_encryption)
			cbShowUV:setState(opt.show_user_volume)
			cbUseTURN:setState(opt.use_turn_server)
		end
		voice_chat.onOffMicTest(true)
	else
		voice_chat.onOffMicTest(false) 
	end
end

function onChange_cbShowActiveUsers()
	voice_chat.setOptions({show_active_users = cbShowActiveUsers:getState()})
	update()
	updateSize()
end

function onChange_cbTurnRadio()
	voice_chat.setOptions({is_auto_switch_to_radio = cbTurnRadio:getState()})
	update()
	updateSize()
end

function onChange_hsInputVolume()
	voice_chat.setOptions({input_volume_level = hsInputVolume:getValue()})
	--voice_chat.setMicVolume(hsInputVolume:getValue())
	sInputVolumeWidget:setText(hsInputVolume:getValue().."%")
end

function onChange_hsMasterVolume()
	voice_chat.setOptions({master_volume = hsMasterVolume:getValue()})
	sMasterVolumeWidget:setText(hsMasterVolume:getValue().."%")
end

function onChange_cbShowGE()
	voice_chat.setOptions({show_guard_encryption = cbShowGE:getState()})
	update()
	updateSize()
end

function onChange_cbShowUV()
	voice_chat.setOptions({show_user_volume = cbShowUV:getState()})
	update()
	updateSize()
end

function onChange_cbUseTURN()
	voice_chat.setOptions({use_turn_server = cbUseTURN:getState()})
	update()
	updateSize()
end

function onChange_bSettCancel()
	panelSettings:setVisible(false)
	voice_chat.onOffMicTest(false) 
	update()
	updateSize()
end

function onChange_cbMuteUser(self)
	voice_chat.peerVoiceEnable(self.data.peer_id, self:getState())
	update()
	updateSize()
end

function onChange_hsVolumeUser(self)
	voice_chat.setTrackAudioVolume(self.data.peer_id, self:getValue())
	sVolumeWidget:setText(self:getValue().."%")
end

function onChange_bRemoveUser(self)
	voice_chat.removeUser(self.data.ownerPeerId, self.data.roomId, self.data.roomType, self.data.unitId, self.data.peer_id)
	update()
	updateSize()
end



function onChange_bSettUserCancel()
	windowSettUser:setVisible(false)
	update()
end

function onChange_mute(self)
	if my_peer_id == self.peer_id then
		self:setState(false)
		self.pair:setState(false)
		return
	end

	if self:getState() == true then
		self:setState(true)
		self.pair:setState(true)
		voice_chat.peerVoiceEnable(self.peer_id, true)
		self:setVisible(true)
		self.pair:setVisible(false)
	else
		self:setState(false)
		self.pair:setState(false)
		voice_chat.peerVoiceEnable(self.peer_id, false)
		self:setVisible(true)
		self.pair:setVisible(false)
	end	
end

--[[
enum RoomType 
{
PERSISTENT = 0, - default - rooms that cannot be deleted by the user, common rooms.
MULTICREW = 1,  - persistent rooms that are created for aircraft with crew
MANAGEABLE = 2, - managed rooms that can be deleted by the user. User is the owner of this room.
}
]]

function fillRooms(a_listRooms)
	usersVoiceOnOffbtn = {} -- очищаем кнопки индикации звука
	local offsetY = 0
	offsetY = addGroup(a_listRooms.PERSISTENT, cdata.PERSISTENT, 0, offsetY)	--PERSISTENT
	offsetY = addGroup(a_listRooms.MULTICREW, cdata.MULTICREW, 1, offsetY)		--MULTICREW
	offsetY = addGroup(a_listRooms.MANAGEABLE, cdata.MANAGEABLE, 2, offsetY)	--MANAGEABLE
		
	offsetY = offsetY + 20
		
	--	заглушка чтобы скроллпейн оставлял место под виджетами добавления комнат
	--	local sPlugTMP = Static.new()
	--	sPlugTMP:setSkin(sPlugSkin)
	--	sPlugTMP:setBounds(305,offsetY, 20, 20)
	--	spBox:insertWidget(sPlugTMP)
		
	spBox:updateWidgetsBounds()
	pDown:setVisible(true)

	local newWinH = offsetY
	if offsetY > hWin-300 then
		newWinH = hWin-300
	end
			
	if bExpand == true then 
		spBox:setSize(353, newWinH)
		pDown:setPosition(0,newWinH+47)
	else
		spBox:setSize(353, 70)
		window:setText(nameMini)
	end
	
	updateSize()
end

function addRadio(v, offsetY)
	pRadio = guiRadiosById[v.number]	
	pRadio:setVisible(true)
	local opt = voice_chat.getOptions() 

	if v.type == 0 then
		-- тип 0			
		pRadio:setPosition(0, offsetY)	
		
		if deployRadios[v.number] == nil then
			deployRadios[v.number] = true
		end
		
		if deployRadios[v.number] == true then
			pRadio.bDeploy:setSkin(bRollupSkin)
		else
			pRadio.bDeploy:setSkin(bExpandSkin)
		end

		if v.indication  == 3 then
			guiRadiosById[v.number].sPTT:setSkin(sPTTredSkin)
			radiosStates[v.number] = 3
		elseif v.indication == 1 then
			guiRadiosById[v.number].sPTT:setSkin(sPTTyelloySkin)
			radiosStates[v.number] = 1
		elseif v.indication == 2 then		
			guiRadiosById[v.number].sPTT:setSkin(sPTTgreenSkin)
			radiosStates[v.number] = 2
		elseif v.indication == 0 then	
			guiRadiosById[v.number].sPTT:setSkin(sPTTgraySkin)
			radiosStates[v.number] = 0
		end		
		
		pRadio.sNameRadio:setText(v.name)
		
		pRadio.eChannel:setText(v.channel)
		set_eFreqText(pRadio.eFreq, v.frequency)
		
		pRadio.eMod:setText(getTxtModulation(v.modulation))
		
		if v.isGuardPresent == false then
			pRadio.eGuard:setVisible(false)
			pRadio.sGuard:setVisible(false)
			pRadio.sGuardMHz:setVisible(false)
		else	
			pRadio.eGuard:setVisible(true)
			pRadio.sGuard:setVisible(true)
			if v.guardStatusOnOff == true then
				pRadio.sGuardMHz:setVisible(true)	
			else
				pRadio.sGuardMHz:setVisible(false)
			end
		end
		
		if v.guardStatusOnOff == false then 			
			pRadio.eGuard:setText(cdata.off)
		else
			set_eFreqText(pRadio.eGuard, v.guardFrequency)
		end	
	
		if v.isEncryptionPresent == false then
			pRadio.sbEncryption:setVisible(false)
			pRadio.cbEncryption:setVisible(false)
			pRadio.sEncr:setVisible(false)
		else
			pRadio.sbEncryption:setVisible(true)
			pRadio.cbEncryption:setVisible(true)
			pRadio.sEncr:setVisible(true)
		end
				
		pRadio.cbEncryption:setState(v.isEncryptionEnabled)			
		pRadio.sbEncryption:setValue(v.encryptionKey)
		pRadio.sbEncryption:setEnabled(v.isEncryptionEnabled)	

		if v.isTransmissionAvailable ~= false then
			pRadio:setSkin(pNormalSkin)
		else
			pRadio:setSkin(pTransDisSkin)
		end

		if deployRadios[v.number] == false and opt.show_guard_encryption ~= true
			and (v.isGuardPresent == true or v.isEncryptionPresent == true)  then					
			pRadio:setSize(350,60)
			offsetY = offsetY + 60
		else	
			offsetY = offsetY + 100
			pRadio:setSize(350,100)
		end
	else
		-- тип 1 и тип 2						
		pRadio:setPosition(0, offsetY)
		pRadio:setEnabled(true)
		
		if deployRadios[v.number] == nil then
			deployRadios[v.number] = true
		end
		
		if deployRadios[v.number] == true then
			pRadio.bDeploy:setSkin(bRollupSkin)
		else
			pRadio.bDeploy:setSkin(bExpandSkin)
		end
				
		if v.indication == 3 then
			guiRadiosById[v.number].sPTT:setSkin(sPTTredSkin)
			radiosStates[v.number] = 3
		elseif v.indication == 1 then
			guiRadiosById[v.number].sPTT:setSkin(sPTTyelloySkin)
			radiosStates[v.number] = 1
		elseif v.indication == 2 then		
			guiRadiosById[v.number].sPTT:setSkin(sPTTgreenSkin)
			radiosStates[v.number] = 2
		elseif v.indication == 0 then	
			guiRadiosById[v.number].sPTT:setSkin(sPTTgraySkin)
			radiosStates[v.number] = 0
		end
		
		if v.externaly_controlled == true then
			pRadio.sNameRadio:setText((v.display_num or '').." "..v.name.." [".. cdata.REMOTE.."]")
			pRadio.pVolume.hsVolume:setEnabled(false)
			pRadio.pMisc.clPower:setEnabled(false)
			pRadio.pMisc.cbSquelch:setEnabled(false)
			pRadio.clGuard:setEnabled(false)
			pRadio.sbEncryption:setEnabled(false)
			pRadio.cbEncryption:setEnabled(false)
			pRadio.clMod:setEnabled(false)
			pRadio.eFreq:setEnabled(false)
			pRadio.bDecFreq:setEnabled(false)
			pRadio.bIncFreq:setEnabled(false)
			pRadio.clChannel:setEnabled(false)
		else
			pRadio.sNameRadio:setText((v.display_num or '').." "..v.name)
			pRadio.pVolume.hsVolume:setEnabled(true)
			pRadio.pMisc.clPower:setEnabled(true)
			pRadio.pMisc.cbSquelch:setEnabled(true)
			pRadio.clGuard:setEnabled(true)
			pRadio.sbEncryption:setEnabled(v.isEncryptionEnabled)
			pRadio.cbEncryption:setEnabled(true)
			pRadio.clMod:setEnabled(true)
			pRadio.eFreq:setEnabled(true)
			pRadio.bDecFreq:setEnabled(true)
			pRadio.bIncFreq:setEnabled(true)
			pRadio.clChannel:setEnabled(true)
		end
				
		setList(pRadio.clChannel, v.channel)	
				
		if v.isGuardPresent == false then
			pRadio.clGuard:setVisible(false)
			pRadio.sGuard:setVisible(false)
		else
			pRadio.clGuard:setVisible(true)
			pRadio.sGuard:setVisible(true)
			
			if v.preset.Guards then
				if v.guardStatusOnOff == false then
					setList(pRadio.clGuard, "off")
				else					
					setList(pRadio.clGuard, v.guardFrequency)
				end
			end
		end
		pRadio.clGuard.isGuardPresent = v.isGuardPresent
		
		if v.isSquelchPresent == false then
			pRadio.pMisc.cbSquelch:setVisible(false)
		else
			pRadio.pMisc.cbSquelch:setVisible(true)
		end
		pRadio.pMisc.cbSquelch:setState(v.squelchStatus)
		pRadio.pMisc.cbSquelch.isSquelchPresent = v.isSquelchPresent
						
		setListMod(pRadio.clMod, v.modulation)
						
		set_eFreqText(pRadio.eFreq, v.frequency)	
		
		local step = dataRadiosById[v.number].preset.Step
		local unitStep = cdata.Hz
		if step >= 1000 then
			step = step / 1000
			unitStep = cdata.kHz
		end
		pRadio.sStep:setText(step.." "..unitStep)
		
		setList(pRadio.pMisc.clPower, v.transmitterPower)

		pRadio.pVolume.hsVolume:setValue(v.soundVolume)			
		
		--pRadio.hsBalance:setValue(v.soundVolume)
		
		pRadio.pBalance:setVisible(false)
		if v.type == 0 then
			pRadio.pVolume:setVisible(false)
		else
			pRadio.pVolume:setVisible(true)
		end
		
		if v.isEncryptionPresent == false then
			pRadio.sbEncryption:setVisible(false)
			pRadio.cbEncryption:setVisible(false)
			pRadio.sEncr:setVisible(false)
		else
			pRadio.sbEncryption:setVisible(true)
			pRadio.cbEncryption:setVisible(true)
			pRadio.sEncr:setVisible(true)
		end
				
		pRadio.cbEncryption:setState(v.isEncryptionEnabled)		
		pRadio.sbEncryption:setValue(v.encryptionKey)
		pRadio.sbEncryption:setEnabled(v.isEncryptionEnabled)	
		
		if v.isTransmissionAvailable ~= false then
			pRadio:setSkin(pNormalSkin)
		else
			pRadio:setSkin(pTransDisSkin)
		end
		
		if deployRadios[v.number] == false then
			-- свернуто
			if opt.show_guard_encryption == true 
				and (v.isGuardPresent == true or v.isEncryptionPresent == true) then
				--есть строка GE
				if v.isEncryptionPresent == true then
					pRadio.sEncr:setVisible(true)
					pRadio.cbEncryption:setVisible(true)
					pRadio.sbEncryption:setVisible(true)
				end
				if v.isGuardPresent == true then
					pRadio.sGuard:setVisible(true)
					pRadio.clGuard:setVisible(true)
				end
				pRadio.pMisc:setVisible(false)
				if opt.show_user_volume == true then
					pRadio.pVolume:setPosition(20, 85)
					pRadio:setSize(350,110)
					offsetY = offsetY + 110
				else
					pRadio:setSize(350,85)
					offsetY = offsetY + 85
				end
			else
				-- нет строки GE
				pRadio.sEncr:setVisible(false)
				pRadio.cbEncryption:setVisible(false)
				pRadio.sbEncryption:setVisible(false)
				pRadio.sGuard:setVisible(false)
				pRadio.clGuard:setVisible(false)
				
				pRadio.pMisc:setVisible(false)	
				if opt.show_user_volume == true then
					pRadio.pVolume:setPosition(20, 60)
					pRadio:setSize(350,85)
					offsetY = offsetY + 85
				else
					pRadio:setSize(350,60)
					offsetY = offsetY + 60
				end				
			end	
		else
			if v.isGuardPresent == true or v.isEncryptionPresent == true then
				--есть строка GE
				if v.isEncryptionPresent == true then
					pRadio.sEncr:setVisible(true)
					pRadio.cbEncryption:setVisible(true)
					pRadio.sbEncryption:setVisible(true)
				end
				if v.isGuardPresent == true then
					pRadio.sGuard:setVisible(true)
					pRadio.clGuard:setVisible(true)
				end
				pRadio.pMisc:setPosition(20, 85)
				pRadio.pMisc:setVisible(true)	
				pRadio.pVolume:setPosition(20, 110)
				pRadio:setSize(350,135)
				offsetY = offsetY + 135
			else
				-- нет строки GE
				pRadio.sEncr:setVisible(false)
				pRadio.cbEncryption:setVisible(false)
				pRadio.sbEncryption:setVisible(false)
				pRadio.sGuard:setVisible(false)
				pRadio.clGuard:setVisible(false)
				
				pRadio.pMisc:setPosition(20, 60)
				pRadio.pMisc:setVisible(true)	
				pRadio.pVolume:setPosition(20, 85)
				pRadio:setSize(350,110)
				offsetY = offsetY + 110
			end	
		end
		verifyChannel(pRadio.clChannel)
	end

	return offsetY
end

function fillRadios(a_listRadios)
	local offsetY = 0	
	radiosStates = {} --очищаем состояния индикации радио
	
	for k,v in base.pairs(guiRadiosById) do
		v:setVisible(false)
	end
	
	if a_listRadios.integrated then
		local pRadio = guiRadiosById["integrated"] 
		pRadio:setVisible(true)
		pRadio:setPosition(0, offsetY)
		offsetY = offsetY + 30
		pRadio:setEnabled(true)
		
		if deployRadios['integrated'] == nil then
			deployRadios['integrated'] = true
		end
		
		if deployRadios['integrated'] == true then
			pRadio.bDeploy:setSkin(bRollupSkin)
		else
			pRadio.bDeploy:setSkin(bExpandSkin)
		end
		
		if deployRadios['integrated'] == true then
			for k,v in base.pairs(a_listRadios.integrated) do	
				offsetY = addRadio(v, offsetY)		
			end
		end
	end
	
	if a_listRadios.extra and #a_listRadios.extra > 0 then
		local pRadio = guiRadiosById["extra"] 
		pRadio:setVisible(true)
		pRadio:setPosition(0, offsetY)
		pRadio:setEnabled(true)
		offsetY = offsetY + 30
		
		if deployRadios['extra'] == nil then
			deployRadios['extra'] = true
		end
		
		if deployRadios['extra'] == true then
			pRadio.bDeploy:setSkin(bRollupSkin)
		else
			pRadio.bDeploy:setSkin(bExpandSkin)
		end
		
		if deployRadios['extra'] == true then
			for k,v in base.pairs(a_listRadios.extra) do	
				offsetY = addRadio(v, offsetY)
			end					
		end
	end
	
	sRPTT:setSkin(getSkinRPTT())
	
	local intercomData = voice_chat.getIntercomData()
	local pIntercom = guiRadiosById["intercom"] 
	
	if intercomData.is_intercom then	
		pIntercom:setVisible(true)
		pIntercom:setPosition(0, offsetY)
		pIntercom:setEnabled(true)	
		
		offsetY = offsetY + 30
	end	
	
	if intercomData.intercom_mode == 0 then
		sION:setText(cdata.IPTT)
	else
		sION:setText(cdata.ION)
	end
			
	if intercomData.intercom_indication then
		-- enum { GREY_LED = 0, YELLOW_LED = 1, GREEN_LED = 2, RED_LED = 3} 
		if intercomData.intercom_indication == 3 then
			pIntercom.sPTT:setSkin(sPTTredSkin)
			sION:setSkin(sRPTTredSkin)
		elseif intercomData.intercom_indication == 1 then
			pIntercom.sPTT:setSkin(sPTTyelloySkin)
			sION:setSkin(sRPTTyelloySkin)
		elseif intercomData.intercom_indication == 2 then
			pIntercom.sPTT:setSkin(sPTTgreenSkin)
			sION:setSkin(sRPTTgreenSkin)
		elseif intercomData.intercom_indication == 0 then
			pIntercom.sPTT:setSkin(sPTTgraySkin)
			sION:setSkin(sRPTTgraySkin)
		end
	end
	
	spBox:updateWidgetsBounds()
	
	local newWinH = offsetY + 5
	if offsetY > hWin-300 then
		newWinH = hWin-300
	end
	
	if bExpand == true then 
		spBox:setSize(353, newWinH)	 
	else
		spBox:setSize(353, 70)
	end
	
	updateSize()	
end

function addGroup(a_data, a_title, a_id, a_offsetY)
	local id = 'group_'..a_id
	deployRooms[id] = deployRooms[id] or false
	
	activeOwnerId, activeRoomId, activeRoomType, activeUnitId = voice_chat.getActiveRoom()
--	base.print("-- activeOwnerId, activeRoomId, activeRoomType ---", activeOwnerId, activeRoomId, activeRoomType)

	for k, v in base.ipairs(a_data) do
		a_offsetY = addRoomInList(v, a_id, a_offsetY)
	end

	return a_offsetY
end

function getRoomKey(a_owner_peer_id, a_room_id, a_type, a_unit_id)
	return 'key_'..a_owner_peer_id..'_'..a_room_id..'_'..a_type..'_'..a_unit_id
end

function addRoomInList(a_data, a_id, a_offsetY)
	local name = a_data.dispname or a_data.name

	local roomKey = getRoomKey(a_data.owner_peer_id, a_data.room_id, a_data.type, a_data.unit_id)
	--base.print("-- Room key: --", roomKey)

	usersVoiceOnOffbtn[roomKey] = {}
	
	deployRooms[roomKey] = deployRooms[roomKey] or false
	
-- кнопка "развернуть комнату"
	local bRoomDownTMP = Button.new()
	bRoomDownTMP:setTooltipText(cdata.hintCollapsPeers)
	bRoomDownTMP.data = {}
	bRoomDownTMP.data.name = a_data.name
	bRoomDownTMP.data.roomKey = roomKey
	bRoomDownTMP.data.ownerPeerId = a_data.owner_peer_id
	bRoomDownTMP.data.roomId = a_data.room_id
	bRoomDownTMP.data.roomType = a_data.type
	bRoomDownTMP.data.unitId = a_data.unit_id
	bRoomDownTMP:setSkin(bRollupSkin)
	bRoomDownTMP:setBounds(15,a_offsetY, 30, 30)
	spBox:insertWidget(bRoomDownTMP)
	
	-- кнопка "свернуть комнату"
	local bRoomUpTMP = Button.new()
	bRoomUpTMP:setTooltipText(cdata.hintExpandPeers)
	bRoomUpTMP.data = {}
	bRoomUpTMP.data.name = a_data.name
	bRoomUpTMP.data.roomKey = roomKey
	bRoomUpTMP.data.ownerPeerId = a_data.owner_peer_id
	bRoomUpTMP.data.roomId = a_data.room_id
	bRoomUpTMP.data.roomType = a_data.type
	bRoomUpTMP.data.unitId = a_data.unit_id
	bRoomUpTMP:setSkin(bExpandSkin)
	bRoomUpTMP:setBounds(15,a_offsetY, 30, 30)
	spBox:insertWidget(bRoomUpTMP)			
	
	-- имя комнаты
	local bRoomTMP = Button.new()	
	bRoomTMP:setTooltipText(a_data.name)
	bRoomTMP.data = {}
	bRoomTMP.data.name = a_data.name
	bRoomTMP.data.roomKey = roomKey
	bRoomTMP.data.ownerPeerId = a_data.owner_peer_id
	bRoomTMP.data.roomId = a_data.room_id
	bRoomTMP.data.roomType = a_data.type
	bRoomTMP.data.unitId = a_data.unit_id
	
	local nameRoom = a_data.dispname
	if a_data.name == 'common' and voice_chat.RoomType.PERSISTENT then
		nameRoom = cdata.common
		nameMini = nameRoom
		bRoomTMP:setTooltipText(nameRoom)
		if a_data.owner_peer_id == activeOwnerId and a_data.room_id == activeRoomId  and
			a_data.type == activeRoomType and a_data.unit_id == activeUnitId	then
			bRoomTMP:setSkin(btnItemGrayBoldSkin)
		else
			bRoomTMP:setSkin(btnItemGraySkin)
		end		
	elseif a_data.name == 'coalition' and voice_chat.RoomType.PERSISTENT then
		local side = getPlayerSideName()
		if side == voice_chat.Side.RED then	
			nameRoom = cdata.coalition.." (".._("red")..")"
			if a_data.owner_peer_id == activeOwnerId and a_data.room_id == activeRoomId  and 
				a_data.type == activeRoomType and a_data.unit_id == activeUnitId then
				bRoomTMP:setSkin(btnItemRedBoldSkin)
				nameMini = nameRoom
			else
				bRoomTMP:setSkin(btnItemRedSkin)
			end
		elseif side == voice_chat.Side.BLUE then
			nameRoom = cdata.coalition.." (".._("blue")..")"
			if a_data.owner_peer_id == activeOwnerId and a_data.room_id == activeRoomId  and 
				a_data.type == activeRoomType and a_data.unit_id == activeUnitId then
				bRoomTMP:setSkin(btnItemBlueBoldSkin)
				nameMini = nameRoom
			else
				bRoomTMP:setSkin(btnItemBlueSkin)
			end
		end
		bRoomTMP:setTooltipText(nameRoom)
	else	
		if a_data.owner_peer_id == activeOwnerId and a_data.room_id == activeRoomId  and 
			a_data.type == activeRoomType and a_data.unit_id == activeUnitId then
			bRoomTMP:setSkin(btnItemGrayBoldSkin)
			nameMini = a_data.dispname
		else
			bRoomTMP:setSkin(btnItemGraySkin)
		end	
	end

	bRoomTMP:setText(nameRoom)
	bRoomTMP:setBounds(55,a_offsetY, 270, 30)
	spBox:insertWidget(bRoomTMP)
	
	local bRoomDelOutTMP = nil
	if a_id == voice_chat.RoomType.MANAGEABLE then
		-- кнопка "удалить/выйти"
		bRoomDelOutTMP = Button.new()
		bRoomDelOutTMP.data = {}
		bRoomDelOutTMP.data.name = a_data.name
		bRoomDelOutTMP.data.roomKey = roomKey
		bRoomDelOutTMP.data.ownerPeerId = a_data.owner_peer_id
		bRoomDelOutTMP.data.roomId = a_data.room_id
		bRoomDelOutTMP.data.roomType = a_data.type
		bRoomDelOutTMP.data.unitId = a_data.unit_id
		
		if a_data.type == voice_chat.RoomType.MANAGEABLE and 
			a_data.owner_peer_id == my_peer_id then  --MANAGEABLE - user room owner
			bRoomDelOutTMP:setTooltipText(cdata.hintDeleteRoom)
			bRoomDelOutTMP:setSkin(bDelSkin)
		else
			bRoomDelOutTMP:setTooltipText(cdata.hintLeaveRoom)
			bRoomDelOutTMP:setSkin(bOutSkin)
		end
		bRoomDelOutTMP:setBounds(305, a_offsetY, 30, 30)
		spBox:insertWidget(bRoomDelOutTMP)
		bRoomDelOutTMP.onChange = onRoomDelOut
		
		if a_id == voice_chat.RoomType.MANAGEABLE and 
			a_data.owner_peer_id == my_peer_id then --MANAGEABLE
			-- кнопка Plus у комнаты перед ведром
			local bPlusUsersRoomTMP = Button.new()
			bPlusUsersRoomTMP:setTooltipText(cdata.hintOpenPeersList)
			bPlusUsersRoomTMP:setSkin(bPlusSkin)
			bPlusUsersRoomTMP:setBounds(270,a_offsetY, 30, 30)
			spBox:insertWidget(bPlusUsersRoomTMP)
			bPlusUsersRoomTMP.data ={}
			bPlusUsersRoomTMP.data.offsetY = a_offsetY + 30
			bPlusUsersRoomTMP.data.roomKey = roomKey
			bPlusUsersRoomTMP.data.ownerPeerId = a_data.owner_peer_id
			bPlusUsersRoomTMP.data.roomId = a_data.room_id
			bPlusUsersRoomTMP.data.roomType = a_data.type
			bPlusUsersRoomTMP.data.unitId = a_data.unit_id
			bPlusUsersRoomTMP.onChange = onAddUser
		end
	end
	
	local function isAccess(a_user, a_idRoom)
		for tmp, peerId in base.pairs(a_idRoom.access_peer_list) do
			if peerId == a_user.peer_id then
				return true
			end
		end
		return false
	end
	
	if deployRooms[roomKey] == true then
		a_offsetY = a_offsetY + 30
		local spUsersTMP = ScrollPane.new()
		spUsersTMP:setTooltipText(cdata.hintTest)
		spUsersTMP:setSkin(spUsersSkin)
		local offsetUser = 0
		for k, user in base.pairs(users) do
			if isAccess(user, a_data) then
				local newItem = Button.new()
				newItem:setTooltipText(cdata.hintPeerName)
				if a_data.owner_peer_id == user.owner_peer_id and a_data.room_id == user.room_id then 
					if (a_data.side == voice_chat.Side.ALL or a_data.side == user.side) and 
						(voice_chat.getVoiceChatMode(user.peer_id) == 0) then
						newItem:setSkin(bUserActiveSkin)						
					else
						newItem:setSkin(bUserSkin)
					end
				else
					newItem:setSkin(bUserSkin)
				end
				newItem:setBounds(0, offsetUser, 250,30)
				newItem:setText(user.peer_name)		
				spUsersTMP:insertWidget(newItem)
				newItem.data ={}
				newItem.data.peer_id = user.peer_id					
				newItem.data.roomKey = roomKey
				newItem.data.ownerPeerId = a_data.owner_peer_id
				newItem.data.roomId = a_data.room_id
				newItem.data.roomType = a_data.type
				newItem.data.unitId = a_data.unit_id
				
				newItem:addMouseDownCallback(function(self, x, y, button) 
					if button == 3 and my_peer_id ~= user.peer_id then
						showSettUser(self.data, x, y)		 				
					end				
				end)
				
				if a_id == voice_chat.RoomType.MANAGEABLE and 
					a_data.owner_peer_id == my_peer_id and
						a_data.owner_peer_id ~= user.peer_id then --MANAGEABLE
				-- кнопка удалить игрока из комнаты
					local bDelTMP = Button.new()
					bDelTMP:setTooltipText(cdata.hintDeletePeer)
					bDelTMP:setSkin(bDelSkin)
					bDelTMP:setBounds(250,offsetUser, 30, 30)
					spUsersTMP:insertWidget(bDelTMP)
					bDelTMP.data ={}
					bDelTMP.data.peer_id = user.peer_id					
					bDelTMP.data.roomKey = roomKey
					bDelTMP.data.ownerPeerId = a_data.owner_peer_id
					bDelTMP.data.roomId = a_data.room_id
					bDelTMP.data.roomType = a_data.type
					bDelTMP.data.unitId = a_data.unit_id
					bDelTMP.onChange = onRemoveUserInRoom
				end
				
				if my_peer_id ~= user.peer_id then
					-- кнопка настроек игрока 
					local bStgTMP = Button.new()
					--	bStgTMP:setTooltipText(cdata.hintDeletePeer)
					bStgTMP:setSkin(bSettSkin)
					bStgTMP:setBounds(280,offsetUser, 30, 30)
					spUsersTMP:insertWidget(bStgTMP)
					bStgTMP.data ={}
					bStgTMP.data.peer_id = user.peer_id					
					bStgTMP.data.roomKey = roomKey
					bStgTMP.data.ownerPeerId = a_data.owner_peer_id
					bStgTMP.data.roomId = a_data.room_id
					bStgTMP.data.roomType = a_data.type
					bStgTMP.data.unitId = a_data.unit_id
					local tmpX, tmpY = spBox:getPosition()
					bStgTMP.data.x = 280
					bStgTMP.data.y = offsetUser + a_offsetY + tmpY + 20
					bStgTMP.onChange = onSettUserInRoom
				
				
				--две кнопки друг над другом - видна только одна
				-- кнопка UserOff/UserMute 
					local tmpSettU = voice_chat.getPeerAudioState(user.peer_id)
	
					local bIconVolOffTMP = ToggleButton.new()
				--	bIconVolOffTMP:setTooltipText(cdata.hintDeletePeer)
					bIconVolOffTMP:setSkin(tbVoiceOffSkin)
					bIconVolOffTMP:setBounds(230,offsetUser, 30, 30)
					bIconVolOffTMP.peer_id = user.peer_id				
					spUsersTMP:insertWidget(bIconVolOffTMP)
					bIconVolOffTMP.onChange = onChange_mute
					bIconVolOffTMP:setState(tmpSettU.is_mute)
					
				-- кнопка UserOn/UserMute 
					local bIconVolOnTMP = ToggleButton.new()
				--	bIconVolOnTMP:setTooltipText(cdata.hintDeletePeer)
					bIconVolOnTMP:setSkin(tbVoiceOnSkin)
					bIconVolOnTMP:setBounds(230,offsetUser, 30, 30)
					bIconVolOnTMP.peer_id = user.peer_id	
					spUsersTMP:insertWidget(bIconVolOnTMP)
					bIconVolOnTMP.onChange = onChange_mute
					bIconVolOnTMP:setState(tmpSettU.is_mute)
					
					bIconVolOffTMP.pair = bIconVolOnTMP
					bIconVolOnTMP.pair = bIconVolOffTMP
					
					usersVoiceOnOffbtn[roomKey][user.peer_id] = {off = bIconVolOffTMP, on = bIconVolOnTMP}

					bIconVolOffTMP:setVisible(true)
					bIconVolOnTMP:setVisible(false)
				end	
								
				offsetUser = offsetUser + 30
			end
		end		
		spUsersTMP:setBounds(0, a_offsetY, 320, offsetUser + 2)
		a_offsetY = a_offsetY + offsetUser
		spBox:insertWidget(spUsersTMP)
		bRoomUpTMP:setVisible(false)
		bRoomDownTMP:setVisible(true)
		

		if a_id == voice_chat.RoomType.MANAGEABLE and
			a_data.owner_peer_id == my_peer_id then --MANAGEABLE
			--кнопка добавления юзеров
			local addUserItem = Button.new()
			addUserItem:setTooltipText(cdata.hintOpenPeersList)
			addUserItem:setSkin(bAddUserSkin)
			addUserItem:setBounds(50, a_offsetY, 200,30)
			addUserItem:setText(cdata.Add_user)		
			spBox:insertWidget(addUserItem)
			addUserItem.data = {}
			addUserItem.data.offsetY = a_offsetY
			addUserItem.data.roomKey = roomKey
			addUserItem.data.ownerPeerId = a_data.owner_peer_id
			addUserItem.data.roomId = a_data.room_id
			addUserItem.data.roomType = a_data.type
			addUserItem.data.unitId = a_data.unit_id
			addUserItem.onChange = onAddUser
				
			-- кнопка Plus
			local bPlusUsersTMP = Button.new()
			bPlusUsersTMP:setTooltipText(cdata.hintOpenPeersList)
			bPlusUsersTMP:setSkin(bPlusSkin)
			bPlusUsersTMP:setBounds(250,a_offsetY, 30, 30)
			spBox:insertWidget(bPlusUsersTMP)
			bPlusUsersTMP.data ={}
			bPlusUsersTMP.data.offsetY = a_offsetY
			bPlusUsersTMP.data.roomKey = roomKey
			bPlusUsersTMP.data.ownerPeerId = a_data.owner_peer_id
			bPlusUsersTMP.data.roomId = a_data.room_id
			bPlusUsersTMP.data.roomType = a_data.type
			bPlusUsersTMP.data.unitId = a_data.unit_id
			bPlusUsersTMP.onChange = onAddUser
			
			a_offsetY = a_offsetY + 30	
		end

	else
		a_offsetY = a_offsetY + 30
		bRoomDownTMP:setVisible(false)
		bRoomUpTMP:setVisible(true)
	end
	
	objRooms[a_data.name] = {name = bRoomTMP, btnDown = bRoomDownTMP, btnUp = bRoomUpTMP, btnDelOut = bRoomDelOutTMP, spUsers = spUsersTMP}	

	bRoomDownTMP.onChange = onRoomDown
	bRoomUpTMP.onChange = onRoomUp
	bRoomTMP:addChangeCallback(onActiveRoom)
	
	
	return a_offsetY 
end

function onSettUserInRoom(self)
	local x, y = window:getPosition()
	showSettUser(self.data, self.data.x + x, self.data.y + y)
end

				
function showSettUser(data, x, y)
	windowSettUser:setPosition(x, y)
	windowSettUser:setVisible(true)
	
	local tmpSettU = voice_chat.getPeerAudioState(data.peer_id)
	cbMuteUser.data = data
	cbMuteUser:setState(tmpSettU.is_mute)
	hsVolumeUser:setValue(tmpSettU.track_audio_volume)
	hsVolumeUser.data = data
	sVolumeWidget:setText(tmpSettU.track_audio_volume.."%")
	bRemoveUser.data = data
	usersVoiceOnOffbtn[data.roomKey][data.peer_id].on:setState(tmpSettU.is_mute)
	usersVoiceOnOffbtn[data.roomKey][data.peer_id].off:setState(tmpSettU.is_mute)
	
	if data.roomType ~= voice_chat.RoomType.MANAGEABLE then
		bRemoveUser:setVisible(false)
	else
		bRemoveUser:setVisible(true)
	end
end

function updateAddUserList()
	--base.print("---onAddUser---", AddUserList.roomKey)
	spAddUsers:clear()
	--local listUsers = voice_chat.getAccessPeersList(AddUserList.room_id)
	local listUsers = voice_chat.getAccessPeersList(AddUserList.ownerPeerId, AddUserList.roomId, AddUserList.roomType)
	---TEST--
--[[	listUsers ={
			{peer_id = 1, peer_name = "xxx1"},
			{peer_id = 2, peer_name = "xxx2"},
			{peer_id = 3, peer_name = "xxx3"},
			{peer_id = 4, peer_name = "xxx4"},
			{peer_id = 5, peer_name = "xxx5"},
			{peer_id = 6, peer_name = "xxx6"},
			{peer_id = 7, peer_name = "xxx7"},
			{peer_id = 8, peer_name = "xxx8"},
			{peer_id = 9, peer_name = "xxx9"},
			{peer_id = 15, peer_name = "xxx15"},
			{peer_id = 16, peer_name = "xxx16"},
			{peer_id = 17, peer_name = "xxx17"},
			{peer_id = 18, peer_name = "xxx18"},
			{peer_id = 19, peer_name = "xxx19"},
		}
]]	
	---
	local offsetUser = 0
	for k, user in base.pairs(listUsers) do
		if id == user.room_id then
			local newItem = Button.new()
			newItem:setTooltipText(cdata.hintPeerName)
			newItem:setSkin(bUserSkin)
			newItem:setBounds(0, offsetUser, 200,30)
			newItem:setText(user.peer_name)	
			newItem.data ={}
			newItem.data.peer_id = user.peer_id
			spAddUsers:insertWidget(newItem)
					
			-- кнопка добавить комнату
			local bPlusTMP = Button.new()
			bPlusTMP:setTooltipText(cdata.hintAddPeer)
			bPlusTMP:setSkin(bPlusSkin)
			bPlusTMP:setBounds(250,offsetUser, 30, 30)
			spAddUsers:insertWidget(bPlusTMP)
			bPlusTMP.data ={}
			bPlusTMP.data.peer_id = user.peer_id
			bPlusTMP.data.roomKey = AddUserList.roomKey
			bPlusTMP.data.ownerPeerId = AddUserList.ownerPeerId
			bPlusTMP.data.roomId = AddUserList.roomId
			bPlusTMP.data.roomType = AddUserList.roomType			
			bPlusTMP.onChange = onAddUserInRoom
	
			offsetUser = offsetUser + 30
		end
	end	
	
	offsetUser = offsetUser + 30
	if offsetUser > 150 then
		offsetUser = 150
	end
	spAddUsers:setBounds(0, 30, 290, offsetUser)
	
	panelAddUsers:setBounds(30, AddUserList.offsetY+50-spBox:getVertScrollValue(), 305, offsetUser+50) -- +50- spBox offset
	panelAddUsers:setVisible(true)
	panelAddUsers:setZIndex(10)
	
	updateSize()
end

function onAddUser(self)
	AddUserList = {}
	AddUserList.offsetY = self.data.offsetY
	AddUserList.roomKey = self.data.roomKey
	AddUserList.ownerPeerId = self.data.ownerPeerId
	AddUserList.roomId = self.data.roomId
	AddUserList.roomType = self.data.roomType
	updateAddUserList()
end

function onRoomDown(self)
--	base.print("---onRoomDown---", self.data.roomKey, self.data.ownerPeerId, self.data.roomId, self.data.roomType)
	hidePanelAddUsers()
	deployRooms[self.data.roomKey] = false
	UpdateManager.add(function()
							update()
							return true
						end
					)
end

function onRoomUp(self)
--	base.print("--- onRoomUp ---",self.data.roomKey, self.data.ownerPeerId, self.data.roomId, self.data.roomType)
	hidePanelAddUsers()
	deployRooms[self.data.roomKey] = true
	UpdateManager.add(function()
							update()
							return true
						end
					)
	
end

function onActiveRoom(self)
--	base.print("--- onActiveRoom ---", self.data.roomKey, self.data.ownerPeerId, self.data.roomId, self.data.roomType)
	hidePanelAddUsers()
	voice_chat.setActiveRoom(self.data.ownerPeerId, self.data.roomId, self.data.roomType, self.data.unitId)
	UpdateManager.add(function()
							update()
							return true
						end
					)
end

function onAddUserInRoom(self)
--	base.print("--- onAddUserInRoom ---",self.data.roomKey, self.data.ownerPeerId, self.data.roomId, self.data.roomType, self.data.peer_id)
	voice_chat.addUser(self.data.ownerPeerId, self.data.roomId, self.data.roomType, self.data.unitId, self.data.peer_id)
	UpdateManager.add(function()
							updateAddUserList()
							return true
						end
					)
end

function onRemoveUserInRoom(self)
--	base.print("--- onRemoveUserUserInRoom ---",self.data.roomKey, self.data.ownerPeerId, self.data.roomId, self.data.roomType, self.data.peer_id)
	voice_chat.removeUser(self.data.ownerPeerId, self.data.roomId, self.data.roomType, self.data.unitId, self.data.peer_id)
end

function onRoomDelOut(self)
--	base.print("--- bRoomDelOutTMP.onChange ---",self.data.roomKey, self.data.ownerPeerId, self.data.roomId, self.data.roomType, self.data.name)
	hidePanelAddUsers()
	if self.data.roomType == voice_chat.RoomType.MANAGEABLE and 
		self.data.ownerPeerId == my_peer_id then --MANAGEABLE, - user room owner
		voice_chat.deleteRoom(self.data.ownerPeerId, self.data.roomId, self.data.roomType, self.data.unitId)
		--base.print("--- deleteRoom ---")
	else
		voice_chat.leaveRoom(self.data.ownerPeerId, self.data.roomId, self.data.roomType, self.data.unitId)
		--base.print("--- leaveRoom ---")
	end	
end

function onCreateRoom()
	hidePanelAddUsers() -- any action hides the add user panel
	local newNameRoom = eCreateRoom:getText()
	if newNameRoom == cdata.CreateNewRoom then
		newNameRoom = cdata.MyRoom
	end
	local result = voice_chat.createRoom(newNameRoom, voice_chat.Side.ALL, voice_chat.RoomType.MANAGEABLE) -- createRoom("ROOM_NAME", SIDE, <ROOM_TYPE>)
	
	if result == 0 or result == nil then
		eCreateRoom:setText(cdata.CreateNewRoom)
		UpdateManager.add(function()
							update()
							return true
						end
					)
	elseif result == 1 then
		MsgWindow.warning(_("Attempt to add a room with wrong room type"), _("Create room"), _("OK")):show()
	elseif result == 2 then		
		MsgWindow.warning(_("Attempt to add an empty room name"), _("Create room"), _("OK")):show()
	end
	
	-- [RADIO] 
	-- local idx = voice_chat.createDynamicRadio(table)
end

function changeSlot(a_side, a_unit_id)
--	base.print("--- mul_voicechat.lua--ChangeSlot ---",a_side)
	voice_chat.changeSlot(a_side, a_unit_id)
end

function getPlayerSideName()
	local playerName = "player"
	local side = 0
	
	local player_info = net.get_player_info(net.get_my_player_id())
	if player_info then
		playerName = player_info.name
		side = player_info.side
	end
	
	return side, playerName
end

function start_stream()
	if voice_chat == nil then 
		return
	end
	
	if bStart == false then
		bStart = true
--		base.print("--- Start voice chat panel ---")
		voice_chat.startStream()
	end
end

function stop_stream(a_bExit)
	if voice_chat == nil then 
		return
	end
--	base.print("--- Stop voice chat panel ---",a_bExit)
	voice_chat.stopStream(a_bExit)
	
	if window then
		hidePanelAddUsers()
		window:setVisible(false)
		voice_chat.onOffMicTest(false) 	
		saveVCPos()
	end	
	
	bStart = false
end

function ChangeVoiceChatOption(a_value, a_endUpdateVoiceChatOption)	
	voice_chat.changeVoiceChatOption(a_value, a_endUpdateVoiceChatOption)
end

function PushToTalkHighlight(do_highlight)
	if voice_chat == nil then 
		return
	end
	
	if bMicState == 2 then
		if (do_highlight) then
			bMic:setSkin(bHighlightMicSkin)
			--base.print("highlight ON")
		else
			bMic:setSkin(bDefaultMicSkin)
			--base.print("highlight OFF")
		end		
	end
end

function isVisible()
	if not window then
		return false
	end
	return window:getVisible()
end


function onPeerConnect(id)	
	if voice_chat == nil then 
		return
	end
	
	local is_local = true
	
	my_peer_id = net.get_my_player_id()
	if (id ~= my_peer_id) then
		is_local = false
	end
	
	local peer_info = net.get_player_info(id)
	
	if peer_info then
		local connectData = {}
		
		local serverSettings = net.get_server_settings()
		
		connectData.server_allow_voice_chat = serverSettings.advanced.voice_chat_server
		connectData.server_allow_extra_radios = serverSettings.advanced.allow_dynamic_radio
		connectData.server_peer_id = net.get_server_id()
		connectData.is_local = is_local
		connectData.peer_id = id
		connectData.peer_name = peer_info.name
		connectData.peer_side = peer_info.side
		connectData.mic_state = optionsEditor.getOption("sound.microphone_use")
		
		--voice_chat.onPeerConnect(serverSettings.advanced.voice_chat_server, net.get_server_id(), is_local, id, peerName, peerSide, tmp_bMicState)
		voice_chat.onPeerConnect(connectData)
	else
		base.print("[ERROR]:OnPeerConnect: peer info undefined peerID = ", id)
	end

end

function onPeerDisconnect(id)
	if voice_chat == nil then 
		return
	end
	voice_chat.onPeerDisconnect(id)
end

function unlockKeyboardInput()
	if keyboardLocked then
		DCS.unlockKeyboardInput(true)
		keyboardLocked = false
	end
end

function lockKeyboardInput()
	if keyboardLocked then
		return
	end

	local keyboardEvents	= Input.getDeviceKeys(Input.getKeyboardDeviceName())

	DCS.lockKeyboardInput(keyboardEvents)
	keyboardLocked = true
end

function fillListPower(a_list, a_data)
	a_list:clear()
	local num = 0
	for k, v in base.pairs(a_data) do
		local txt = cdata.W
		local value = v.value
		
		if v.value > 1000000 then
			txt = cdata.MW
			value = value / 1000000
		elseif v.value > 1000 then
			txt = cdata.kW
			value = value / 1000
		elseif v.value > 1 then
			txt = cdata.W
		elseif v.value > 0.001 then
			txt = cdata.mW
			value = value * 1000
		end
				
		local item = ListBoxItem.new(value.." "..txt)
		item.id = v.value
		a_list:insertItem(item)
		num = num + 1
	end
	if num < 2 then
		a_list:setEnabled(false)
	else
		a_list:setEnabled(true)
	end
end

function fillListGuard(a_list, a_data)
	a_list:clear()
	local item = ListBoxItem.new(cdata.off)
	item.id = 'off'
	a_list:insertItem(item)
	
	for k, v in base.pairs(a_data) do
		local txt = cdata.MHz
--		local value = v.freq
		local mod = getTxtModulation(v.modulation)
--[[		
		if v.freq > 1000000 then
			txt = cdata.MHz
			value = value / 1000000
		elseif v.freq > 1000 then
			txt = cdata.kHz
			value = value / 1000
		end
]]		
		local item = ListBoxItem.new(base.string.format("%0.3f %s %s",v.freq/1000000, txt, mod))
		item.id = v.freq
		item.mod = v.modulation
		a_list:insertItem(item)
	end
end

function fillListChannel(a_list, a_data)
	a_list:clear()
	local item = ListBoxItem.new(" ")
	item.id = nil
	a_list:insertItem(item)
		
	for k, v in base.pairs(a_data) do
		local item = ListBoxItem.new(v.number)
		item.id = k
		item.name = v.number
		a_list:insertItem(item)
	end
end

function setList(a_list, a_value)
	local itemCount = a_list:getItemCount()

	for i = 0, itemCount - 1 do
		local item = a_list:getItem(i)
		if item.id == a_value then			
			a_list:selectItem(item)
			return
		end
	end
end

function fillListMod(a_list, a_ranges)
	a_list:clear()
	local item = ListBoxItem.new(cdata.AM)
	item.modulation  = 0
	a_list:insertItem(item)
	
	local item = ListBoxItem.new(cdata.FM)
	item.modulation = 1
	a_list:insertItem(item)

	a_list:selectItem(a_list:getItem(0))
	
	local bAM = false
	local bFM = false
	for k,v in base.pairs(a_ranges) do
		if v.modulation == 0 then
			bAM = true 
		end
		if v.modulation == 1 then
			bFM = true 
		end
	end
	a_list:setEnabled(bAM and bFM)
end

function setListMod(a_list, a_value)
	local itemCount = a_list:getItemCount()

	for i = 0, itemCount - 1 do
		local item = a_list:getItem(i)
		if item.modulation == a_value then
			a_list:selectItem(item)
			return
		end
	end
end

function fillListFreq(a_list)
	a_list:clear()
	local item = ListBoxItem.new(cdata.Hz)
	item.multValue  = 1
	a_list:insertItem(item)
	
	local item = ListBoxItem.new(cdata.kHz)
	item.multValue = 1000
	a_list:insertItem(item)

	local item = ListBoxItem.new(cdata.MHz)
	item.multValue = 1000000
	a_list:insertItem(item)

	a_list:selectItem(a_list:getItem(0))
end

function setListFreq(a_list, a_value)
	local itemCount = a_list:getItemCount()

	for i = 0, itemCount - 1 do
		local item = a_list:getItem(i)
		if item.multValue == a_value then
			a_list:selectItem(item)
			return
		end
	end
end

function setListPower(a_list, a_value)
	local itemCount = a_list:getItemCount()

	for i = 0, itemCount - 1 do
		local item = a_list:getItem(i)
		if item.multValue == a_value then
			a_list:selectItem(item)
			return
		end
	end
end

function updateRadioPanelControls(dynamic_radio_id, command)
	if voice_chat == nil then 
		return
	end
	
	if guiRadiosById[dynamic_radio_id] then
		if command == 0 then -- HotKeyCommands::MODULATON_NEXT
			if guiRadiosById[dynamic_radio_id] then
				local mod = selectListValue(guiRadiosById[dynamic_radio_id].clMod, 1).modulation
				voice_chat.setRadioModulation(dynamic_radio_id, mod)
			end
--		elseif command == 1 then -- HotKeyCommands::FREQ_CHANGE_SELECTOR_NEXT
--			if guiRadiosById[dynamic_radio_id] then
--				selectListValue(guiRadiosById[dynamic_radio_id].clRazr, 1)
--			end
		elseif command == 2 then -- HotKeyCommands::FREQUENCY_UP
			if guiRadiosById[dynamic_radio_id] then
				onChange_bIncFreq(guiRadiosById[dynamic_radio_id].bIncFreq)
			end
		elseif command == 3 then -- HotKeyCommands::FREQUENCY_DOWN
			if guiRadiosById[dynamic_radio_id] then
				onChange_bDecFreq(guiRadiosById[dynamic_radio_id].bDecFreq)
			end
		elseif command == 4 then -- HotKeyCommands::CHANNEL_INCREASE
			if guiRadiosById[dynamic_radio_id] then
				local channel = selectListValue(guiRadiosById[dynamic_radio_id].clChannel, 1).id
				if channel then
					local tmpFreq = dataRadiosById[dynamic_radio_id].preset.Channels[channel].freq
					voice_chat.setRadioFrequency(dynamic_radio_id, 1, tmpFreq)					
					set_eFreqText(guiRadiosById[dynamic_radio_id].eFreq, tmpFreq)	
				end
			end
		elseif command == 5 then -- HotKeyCommands::CHANNEL_DECREASE
			if guiRadiosById[dynamic_radio_id] then
				local channel = selectListValue(guiRadiosById[dynamic_radio_id].clChannel, -1).id
				if channel then
					local tmpFreq = dataRadiosById[dynamic_radio_id].preset.Channels[channel].freq
					voice_chat.setRadioFrequency(dynamic_radio_id, 1, tmpFreq)				
					set_eFreqText(guiRadiosById[dynamic_radio_id].eFreq, tmpFreq)	
				end
			end
		elseif command == 6 then -- HotKeyCommands::GUARD_CHANGE_NEXT
			if guiRadiosById[dynamic_radio_id]
				and guiRadiosById[dynamic_radio_id].clGuard.isGuardPresent	then
				local lastId = guiRadiosById[dynamic_radio_id].clGuard:getSelectedItem().id
				local item = selectListValue(guiRadiosById[dynamic_radio_id].clGuard, 1)
				local next_guard_modulation = item.mod
				local next_guard_freq = item.id
				
				if lastId == 'off' then
					voice_chat.setRadioGuardReceiverOnOff(dynamic_radio_id, true)
				end
				
				if item.id == 'off' then
					voice_chat.setRadioGuardReceiverOnOff(dynamic_radio_id, false)
				else
					voice_chat.setRadioGuardReceiverModulation(dynamic_radio_id, next_guard_modulation)
					voice_chat.setRadioGuardReceiverFrequency(dynamic_radio_id, next_guard_freq)
				end
			end
		elseif command == 7 then -- HotKeyCommands::ENCRYPTION_ON_OFF
			if guiRadiosById[dynamic_radio_id] then		
				local onOffValue = changeCBValue(guiRadiosById[dynamic_radio_id].cbEncryption)
				voice_chat.setEncryptionEnabled(dynamic_radio_id, onOffValue)
				guiRadiosById[dynamic_radio_id].sbEncryption:setEnabled(guiRadiosById[dynamic_radio_id].cbEncryption:getState())				
			end
		elseif command == 8 then -- HotKeyCommands::POWER_CHANGE_NEXT
			if guiRadiosById[dynamic_radio_id] then
				local next_power_value = selectListValue(guiRadiosById[dynamic_radio_id].pMisc.clPower, 1).id
				voice_chat.setRadioPower(dynamic_radio_id, next_power_value)
			end
		elseif command == 9 then -- HotKeyCommands::SQUELCH_ON_OFF
			if guiRadiosById[dynamic_radio_id] 
				and guiRadiosById[dynamic_radio_id].pMisc.cbSquelch.isSquelchPresent == true then
				local squelchOnOffValue = changeCBValue(guiRadiosById[dynamic_radio_id].pMisc.cbSquelch)
				voice_chat.setRadioSquelchOnOff(dynamic_radio_id, squelchOnOffValue)
			end
		elseif command == 10 then -- HotKeyCommands::VOLUME_UP
			if guiRadiosById[dynamic_radio_id] then
				local next_vol_value = changeHSValue(guiRadiosById[dynamic_radio_id].pVolume.hsVolume, 1)
				voice_chat.setRadioVolume(next_vol_value)
			end	
		elseif command == 11 then -- HotKeyCommands::VOLUME_DOWN
			if guiRadiosById[dynamic_radio_id] then
				local prev_vol_value = changeHSValue(guiRadiosById[dynamic_radio_id].pVolume.hsVolume, -1)
				voice_chat.setRadioVolume(prev_vol_value)
			end	
		elseif command == 12 then -- HotKeyCommands::BALANCE_LEFT	
			if guiRadiosById[dynamic_radio_id] then
			--	local value = changeHSValue(guiRadiosById[dynamic_radio_id].pBalance.hsBalance, -1)
			--	voice_chat.setRadioVolume(value)
			end	
		elseif command == 13 then -- HotKeyCommands::BALANCE_RIGHT
			if guiRadiosById[dynamic_radio_id] then
			--	local value = changeHSValue(guiRadiosById[dynamic_radio_id].pBalance.hsBalance, 1)
			--	voice_chat.setRadioVolume(value)
			end	
		end
	end
end

function selectListValue(a_list, a_inc)
	local selectedItem = a_list:getSelectedItem()
	local selectedItemIndex = a_list:getItemIndex(selectedItem)

	selectedItemIndex = selectedItemIndex + a_inc
	
	if selectedItemIndex > (a_list:getItemCount() - 1) then
		selectedItemIndex = 0
	end
	
	if selectedItemIndex < 0 then
		selectedItemIndex = a_list:getItemCount() - 1
	end
	
	local item = a_list:getItem(selectedItemIndex)
	
	a_list:selectItem(item)
	 
	return item
end

function verifyChannel(self)
	local freq = base.math.floor(base.tonumber(guiRadiosById[self.number].eFreq:getText())* 1000000)	
	local modulation = guiRadiosById[self.number].clMod:getSelectedItem().modulation
	
	setList(guiRadiosById[self.number].clChannel, nil)
	
	for k,v in base.pairs(dataRadiosById[self.number].preset.Channels) do		
		if modulation == v.modulation and v.freq == freq then
			setList(guiRadiosById[self.number].clChannel, k)		
		end
	end
end

function changeCBValue(a_checkBox)
	local state = a_checkBox:getState()
	state = not state
	a_checkBox:setState(state)
	 
	return state
end

function changeHSValue(a_hSlider, a_inc)
	local curValue = a_hSlider:getValue()
	
	a_hSlider:setValue(curValue + a_inc)
	
	return a_hSlider:getValue()
end

function onChange_bDecFreq(self)
	ChangeFreq(self,-1)
		
end

function onChange_bIncFreq(self)
	ChangeFreq(self, 1)
end	

function ChangeFreq(self, a_sign)
	local freq = voice_chat.getRadioFrequency(self.number)

	freq = freq  + (a_sign * dataRadiosById[self.number].preset.Step)
	
	if freq < 0 then
		freq = 0
	end

	set_eFreqText(guiRadiosById[self.number].eFreq, freq)	
	correctFreq(self)
end

function correctFreq(self)
	local freq = base.math.floor(base.tonumber(guiRadiosById[self.number].eFreq:getText()) * 1000000)
						
	--находим в каком диапазоне канал
	local minFreq
	local maxFreq
	local modulation = guiRadiosById[self.number].clMod:getSelectedItem().modulation
	local kNearest 
	local vNearest = 999999999999 
	local freqNearest = 0
	
	for k,v in base.pairs(dataRadiosById[self.number].preset.Ranges) do
		if modulation == v.modulation then
			if freq >= v.minFreq and freq <= v.maxFreq then
				minFreq = v.minFreq
				maxFreq = v.maxFreq
				freqNearest = freq
			else
				-- находим ближайший диапазон
				local v1 = base.math.abs(freq - v.minFreq)
				local v2 = base.math.abs(v.maxFreq - freq)
				if v1 > v2 then
					--ближе к максимуму
					if v2 < vNearest then
						vNearest = v2
						kNearest = k
						freqNearest = v.maxFreq
					end
				else
					--ближе к минимуму
					if v1 < vNearest then
						vNearest = v1
						kNearest = k
						freqNearest = v.minFreq
					end
				end
			end
		end
	end
	
	if minFreq == nil then
		if kNearest == nil then
			base.print("--No ranges---")
		else
			minFreq = dataRadiosById[self.number].preset.Ranges[kNearest].minFreq
			maxFreq = dataRadiosById[self.number].preset.Ranges[kNearest].maxFreq
			
			freq = freqNearest
		end	
	end
	
	if minFreq ~= nil then
		freq  = freq - minFreq

		local numHz  = base.math.floor(freq/dataRadiosById[self.number].preset.Step+0.5)							
		
		local tmpHz = numHz*dataRadiosById[self.number].preset.Step+minFreq
		if tmpHz > maxFreq then
			tmpHz = (numHz-1)*dataRadiosById[self.number].preset.Step+minFreq
		end
		if tmpHz < minFreq then
			tmpHz = minFreq
		end
					
		voice_chat.setRadioFrequency(self.number, 0, tmpHz)	 -- mode {0-MANUAL, 1-PRESET(канал)}
				
		set_eFreqText(guiRadiosById[self.number].eFreq, tmpHz)		
		guiRadiosById[self.number].clChannel:setSkin(clNormalSkin)	
		verifyChannel(self)	
	end
end

function set_eFreqText(a_editBox, a_freq)
	local freq100 = base.math.floor(a_freq/100)*100
	local freq1000 = base.math.floor(a_freq/1000)*1000

	local strFreq
	if freq100 > freq1000 then
		strFreq = base.string.format("%0.4f",a_freq/1000000)
	else
		strFreq = base.string.format("%0.3f",a_freq/1000000)
	end
	a_editBox:setText(strFreq)
end