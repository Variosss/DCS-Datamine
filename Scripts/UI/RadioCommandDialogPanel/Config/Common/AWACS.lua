local base = _G
local mainMenuPos, parameters = ...

local speech = require('speech')

local function checkUnit(self)
	local receiver = getSelectedReceiver()
	if receiver ~= nil and receiver:checkUnit() ~= nil then 
		return true
	end
	return false
end

--Menus
local menus = data.menus
local receiver
menus['AWACS'] = {
	name = _('AWACS'),
	items = {
		{
			name = _('Vector to bullseye'),
			condition = {
				check = function(self)
					if checkUnit() then 
						local receiver = getSelectedReceiver()
						return (receiver ~= nil and speech.protocolByCountry[receiver:getUnit():getCountry()] or speech.defaultProtocol) == 'NATO'
					else
						return false
					end
				end
			},
			command = sendMessage.new(Message.wMsgLeaderVectorToBullseye)
		},

		{
			name = _('Vector to home plate'),
			condition = {
				check = function(self)
					if checkUnit() then return true
					else return false end
				end
			},
			command = sendMessage.new(Message.wMsgLeaderVectorToHomeplate)
		},
		parameters.tanker
			and
		{
			name = _('Vector to tanker'),
			condition = {
				check = function(self)
					if checkUnit() then return true
					else return false end
				end
			},
			command = sendMessage.new(Message.wMsgLeaderVectorToTanker)
		}
			or
		nil
		,
		{
			name = _('Request BOGEY DOPE'),
			condition = {
				check = function(self)
					if checkUnit() then return true
					else return false end
				end
			},
			command = sendMessage.new(Message.wMsgLeaderVectorToNearestBandit)
		},
		{
			name = _('Request PICTURE'),
			condition = {
				check = function(self)
					if checkUnit() then return true
					else return false end
				end
			},
			command = sendMessage.new(Message.wMsgLeaderPicture)
		},
		parameters.radar
			and
		{
			name = _('DECLARE'),
			condition = {
				check = function(self)
					if checkUnit() then return true
					else return false end
				end
			},
			command = sendMessage.new(Message.wMsgLeaderDeclare)
		}
			or
		nil
	}
}

local function getAWACSes()
	return coalition.getServiceProviders(data.pUnit:getCoalition(), coalition.service.AWACS)
end

local function buildAWACSes(self, menu)
	local AWACSes = getAWACSes()
	if 	not data.showingOnlyPresentRecepients or
		getRecepientsState(AWACSes) ~= RecepientState.VOID then
		menu.items[mainMenuPos] = buildRecepientsMenu(AWACSes, _('AWACS'), { name = _('AWACS'), submenu = menus['AWACS'] })
	end
end

table.insert(data.rootItem.builders, buildAWACSes)

--[[
local msgHandler = {
	onMsg = function(self, pMessage, pRecepient)
		--print('onMsg AWACS pMessage:getEvent() = '..tostring(pMessage:getEvent() and pMessage:getEvent()))
		--print('onMsg AWACS pMessage:getSender() = '..tostring(pMessage:getSender()))		
		self:onMsgEvent(pMessage:getEvent(), pMessage:getSender(), pRecepient)
	end,
	onMsgEvent = function(self, event, pMsgSender, pRecepient)		
		--print('onMsgEvent event.id = '..tostring(event))
		local pUnit = pMsgSender:getUnit()
		local nUnitCategory = pUnit:getCategory()
		if nUnitCategory == Object.Category.BASE or nUnitCategory == Object.Category.UNIT then
			local airbaseCategory = pUnit:getDesc().category
			if event == Message.wMsgATCClearedForEngineStartUp then
				if airbaseCategory == Airbase.Category.HELIPAD then
					return events.STARTUP_PERMISSION_FROM_HELIPAD
				elseif airbaseCategory == Airbase.Category.AIRDROME then
					return events.STARTUP_PERMISSION_FROM_AIRDROME
				elseif airbaseCategory == Airbase.Category.SHIP then
					return events.STARTUP_PERMISSION_FROM_SHIP
				end
			elseif event == Message.wMsgATCTakeoffDenied then
				local typeName = pMsgSender:getUnit():getTypeName()
				if airbaseCategory == Airbase.Category.HELIPAD then
					return events.DENY_TAKEOFF_FROM_HELIPAD
				elseif airbaseCategory == Airbase.Category.AIRDROME then
					return events.DENY_TAKEOFF_FROM_AIRDROME
				elseif airbaseCategory == Airbase.Category.SHIP then
					return events.DENY_TAKEOFF_FROM_SHIP
				end
			elseif event == Message.wMsgATCYouAreClearedForTO then
				local typeName = pMsgSender:getUnit():getTypeName()
				if airbaseCategory == Airbase.Category.HELIPAD then
					return events.CLEAR_TO_TAKEOFF_FROM_HELIPAD
				elseif airbaseCategory == Airbase.Category.AIRDROME then
					return events.CLEAR_TO_TAKEOFF_FROM_AIRDROME
				elseif airbaseCategory == Airbase.Category.SHIP then
					return events.CLEAR_TO_TAKEOFF_FROM_SHIP
				end
			end
		end
	end	
}
table.insert(data.msgHandlers, msgHandler)
]]