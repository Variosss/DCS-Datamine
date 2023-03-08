local mainMenuPos = ...

--Menus
local menus = data.menus

menus['Tanker'] = {
	name = _('Tanker'),
	items = {
		[1] = {name = _('Intent to refuel'), 				command = sendMessage.new(Message.wMsgLeaderIntentToRefuel)}
	}
}

local function getTankers()
	local selfCoalition = data.pUnit:getCoalition()
	local tankers = coalition.getServiceProviders(selfCoalition, coalition.service.TANKER)
	local selfPoint = data.pUnit:getPosition().p
	local function distanceSorter(lu, ru)
		
		local lpoint = lu:getPosition().p
		local ldist2 = (lpoint.x - selfPoint.x) * (lpoint.x - selfPoint.x) + (lpoint.z - selfPoint.z) * (lpoint.z - selfPoint.z)
		
		local rpoint = ru:getPosition().p
		local rdist2 = (rpoint.x - selfPoint.x) * (rpoint.x - selfPoint.x) + (rpoint.z - selfPoint.z) * (rpoint.z - selfPoint.z)
				
		return ldist2 < rdist2
	end
	table.sort(tankers, distanceSorter)	
	return tankers
end

local function buildTankers(self, menu)
	local tankers = getTankers()
	if 	not data.showingOnlyPresentRecepients or
		getRecepientsState(tankers) ~= RecepientState.VOID then
		menu.items[mainMenuPos] = buildRecepientsMenu(tankers, _('Tanker'), { name = _('Tanker'), submenu = menus['Tanker'] })
	end
end

table.insert(data.rootItem.builders, buildTankers)
		
--Tanker
local dialog = {}
dialogsData.dialogs['Tanker'] = dialog
dialog.name = _('Tanker')
dialog.menus = {}
dialog.menus['Intent to refuel'] = {
	name = _('Intent to refuel'),
	items = {
		[1] = { name = _('Intent to refuel'), 					command = sendMessage.new(Message.wMsgLeaderIntentToRefuel) }
	}
}
dialog.menus['Pre-contact'] = {
	name = _('Pre-contact'),
	items = {		
		[1] = { name = _('Ready pre-contact'), 					command = sendMessage.new(Message.wMsgLeaderReadyPreContact) },
		[2] = { name = _('Abort refuel'), 						command = sendMessage.new(Message.wMsgLeaderAbortRefueling) }
	}
}
dialog.menus['Trail'] = {
	name = _('Trail'),
	items = {		
		[1] = { name = _('Ready pre-contact'), 					command = sendMessage.new(Message.wMsgLeaderReadyPreContact) },
		[2] = { name = _('Abort refuel'), 						command = sendMessage.new(Message.wMsgLeaderAbortRefueling) }
	}
}
dialog.menus['Cleared contact'] = {
	name = _('Cleared contact'),
	items = {		
		[1] = { name = _('Abort refuel'), 						command = sendMessage.new(Message.wMsgLeaderAbortRefueling) }
	}
}
dialog.menus['Contact'] = {
	name = _('Contact'),
	items = {		
		[1] = { name = _('Abort refuel'), 						command = sendMessage.new(Message.wMsgLeaderStopRefueling) }
	}
}
dialog.menus['Fuel transfering'] = {
	name = _('Fuel transfering'),
	items = {
		[1] = { name = _('Abort refuel'), 						command = sendMessage.new(Message.wMsgLeaderStopRefueling) }
	}
}
dialog.stages = {
	['Closed'] = {	
		[Message.wMsgTankerClearedPreContact] 	= TO_STAGE('Tanker', 'Pre-contact'),
		[Message.wMsgTankerChicksInTow]			= TO_STAGE('Tanker', 'Trail'),
	},
	['Trail'] = {
		[Message.wMsgTankerClearedPreContact]	= TO_STAGE('Tanker',  'Pre-contact'),
		[Message.wMsgLeaderAbortRefueling]		= TERMINATE()
	},	
	['Pre-contact'] = {
		[Message.wMsgTankerClearedContact]		= TO_STAGE('Tanker',  'Cleared contact'),
		[Message.wMsgLeaderAbortRefueling]		= TERMINATE()
	},
	['Cleared contact'] = {
		[Message.wMsgTankerContact]				= TO_STAGE('Tanker',  'Contact'),
		[Message.wMsgTankerReturnPreContact]	= TO_STAGE('Tanker',  'Pre-contact'),
		[Message.wMsgLeaderAbortRefueling]		= TERMINATE()
	},	
	['Contact'] = {
		[Message.wMsgTankerFuelFlow]			= TO_STAGE('Tanker',  'Fuel transfering'),
		[Message.wMsgTankerReturnPreContact]	= TO_STAGE('Tanker',  'Cleared contact'),
		[Message.wMsgTankerDisconnectNow]		= TERMINATE(),
		[Message.wMsgTankerRefuelingComplete]	= TERMINATE(),
		[Message.wMsgLeaderStopRefueling]		= TERMINATE()
	},
	['Fuel transfering'] = {	
		[Message.wMsgTankerReturnPreContact]	= TO_STAGE('Tanker',  'Cleared contact'),
		[Message.wMsgTankerDisconnectNow]		= TERMINATE(),
		[Message.wMsgTankerRefuelingComplete]	= TERMINATE(),
		[Message.wMsgLeaderStopRefueling]		= TERMINATE()
	}
}

--Dialog triggers
local trigger = DialogStartTrigger:new(dialog)
dialogsData.triggers[Message.wMsgTankerClearedPreContact] = trigger
dialogsData.triggers[Message.wMsgTankerChicksInTow] = trigger