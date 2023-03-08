--Speech construction protocol "NATO"

local base = _G

module('USSR')

local common = base.require('common')

--inheritance from common table
base.setmetatable(base.getfenv(), common)

local p = base.require('phrase')
local u = base.require('utils')

local gettext = base.require("i_18n")
local _ = gettext.translate

--AWACS -> PLAYER

AWACSpictureHandler = {
	make = function(self, message, language)
		
		local pUnit = message.sender:getUnit()
		
		local result = self.sub.AWACSToClientHandler:make(message, language)
		
		local groupsQty = #message.parameters.groups
		base.assert(groupsQty > 0)
		
		if groupsQty > 1 then
			result = result + comma_space_ + self.sub.Number:make(groupsQty) + ' ' + self.sub.groups:make()
			for targetIndex, target in base.pairs(message.parameters.groups) do
				local desc
				if targetIndex == 1 then
					desc = self.sub.firstGroup:make()
				else
					desc = self.sub.additionalGroup:make()
				end		
				result = result + CR_ + desc + ' ' + self.sub.AWACSTargetDir:make(target, message.receiver, pUnit:getCountry())
			end
		else
			local group = message.parameters.groups[1]
			result = result + ' ' + self.sub.oneGroup:make() + CR_ + self.sub.AWACSTargetDir:make(group, message.receiver, pUnit:getCountry())
		end
		return result
		
	end,
	sub = {	AWACSToClientHandler	= AWACSToClientHandler,
			groups					= Phrase:new({_('groups'),				'groups'}),
			firstGroup				= Phrase:new({_('First group'),			'First group'}),
			additionalGroup			= Phrase:new({_('Additional group'),	'Additional group'}),
			oneGroup				= Phrase:new({_('single group'),		'single group'}),
			AWACSTargetDir			= AWACSTargetDir,
			Number					= Number}
}

AWACSBullVectorHandler = {
	make = function(self, message, language)
		local pUnit = message.sender:getUnit()
		local receiverPos = message.receiver:getUnit():getPosition().p
		local dir = {	x = message.parameters.point.x - receiverPos.x,
						y = message.parameters.point.y - receiverPos.y,
						z = message.parameters.point.z - receiverPos.z }
		return 	self.sub.AWACSToClientHandler:make(message, language) + ' ' +
				self.sub.Direction:make(dir, pUnit:getCountry())
	end,
	sub = {	AWACSToClientHandler	= AWACSToClientHandler,
			Direction				= Direction }
}

--PLAYER -> ATC

InboundAt = {
	make = function(self, message, language)
		local senderUnit = message.sender:getUnit()
		if senderUnit:hasAttribute('Helicopters') then
			local country = senderUnit:getCountry()
			local selfPos = senderUnit:getPosition().p
			local airdromePos = message.receiver:getUnit():getPosition().p
			local dir = { 	x = selfPos.x - airdromePos.x,
							y = selfPos.y - airdromePos.y,
							z = selfPos.z - airdromePos.z }
			local distanceUnit = unitSystemByCountry[country].distance
			return 	self.sub.AirbaseName:make(message.receiver, getAirdromeNameVariant(language)) +
					comma_space_ + self.sub.PlayerAircraftCallsign:make(message.sender,message.receiver, language == 'RUS') + comma_space_ + self.sub.range:make() + ' ' +
					self.sub.Number:make(u.round(u.get_lengthZX(dir) * distanceUnit.coeff, 1)) + ' ' + self.sub.Altitude:make(selfPos.y, country, 500)
		else
			return	self.sub.AirbaseName:make(message.receiver, getAirdromeNameVariant(language)) +
					comma_space_ + self.sub.PlayerAircraftCallsign:make(message.sender,message.receiver, language == 'RUS') + comma_space_ + self.sub.inbound:make()
		end
	end,
	sub = { PlayerAircraftCallsign	= PlayerAircraftCallsign,
			AirbaseName				= AirbaseName,
			Number					= Number,
			range					= Phrase:new({_('inbound range'), 	'inbound range'}),
			inbound					= Phrase:new({_('inbound'), 		'inbound'}),
			Altitude				= Altitude }
}

handlersTable = {
	--AWACS -> PLAYER
	[base.Message.wMsgLeaderInbound]				= InboundAt,
	--AWACS -> Player
	[base.Message.wMsgAWACSBanditBearingForMiles]	= AWACSbanditBearingHandler,
	[base.Message.wMsgAWACSVectorToNearestBandit]	= AWACSbanditBearingHandler,
	[base.Message.wMsgAWACSPopUpGroup]				= AWACSbanditBearingHandler,
	[base.Message.wMsgAWACSHomeBearing]				= AWACSBullVectorHandler,
	[base.Message.wMsgAWACSTankerBearing]			= AWACSBullVectorHandler,
	[base.Message.wMsgAWACSPicture]					= AWACSpictureHandler,	
}

base.setmetatable(handlersTable, common.handlersTable_mt)

rangeHandlersTable = {
	--PLAYER -> AWACS
	{
		range = { base.Message.wMsgLeaderToAWACSNull,	base.Message.wMsgLeaderToAWACSMaximum },
		handler = ClientToAWACSHandler
	},
	--AWACS -> PLAYER
	{
		range = { base.Message.wMsgAWACSNull,			base.Message.wMsgAWACSMaximum },
		handler = AWACSToClientHandler
	}
}

base.setmetatable(rangeHandlersTable, common.rangeHandlersTable_mt)

base.print('Speech.USSR module loaded')