local mainMenuPos = ...

--Message handlers

local nineLineDataForReadBack = nil

local repeatBDAAllowed = false

local fsmBDA = nil

do

local fsm = require('fsm')

local fsmBDARecepient = {
	setRepeatBDAAllowed = function(self, val)
		if val ~= nil then
			repeatBDAAllowed = val
		end
	end
}

local fsmBDAData = {
	init_state = 'Standby',
	transitions = {
		['Standby'] = {
			['Start engaging'] = {
				newState = 'Engaging before first BDA',
				outSymbol = false
			}
		},
		['Engaging before first BDA'] = {
			['Start engaging'] = {
				newState = 'Engaging before first BDA',
				outSymbol = false,
			},		
			['BDA'] = {
				newState = 'Engaging after first BDA',
				outSymbol = true,
			},
			['Stop engaging'] = {
				newState = 'Standby',
				outSymbol = nil
			}
		},		
		['Engaging after first BDA'] = {
			['Start engaging'] = {
				newState = 'Engaging before first BDA',
				outSymbol = false
			},
			['Stop engaging'] = {
				newState = 'Standby',
				outSymbol = nil,
			}
		},
		
	}
}

fsmBDA = fsm:new(fsmBDAData, fsmBDARecepient.setRepeatBDAAllowed, fsmBDARecepient, 'FSM BDA')

end


local msgHandler = {
	onMsg = function(self, pMessage, pRecepient)
		local event	= pMessage:getEvent()
		if 	event == Message.wMsgFAC9lineBrief or 
			event == Message.wMsgFAC9lineBriefWP or
			event == Message.wMsgFAC9lineBriefWPLaser or
			event == Message.wMsgFAC9lineBriefIRPointer or
			event == Message.wMsgFAC9lineBriefLaser then
			local messageTbl = pMessage:getTable()
			nineLineDataForReadBack = nineLineDataForReadBack or {}
			nineLineDataForReadBack.target_elevation = messageTbl.parameters.target_elevation
			nineLineDataForReadBack.target_location = messageTbl.parameters.target_location
			fsmBDA:onSymbol('Start engaging')
		elseif event == Message.wMsgFAC9lineRemarks then
			local messageTbl = pMessage:getTable()
			nineLineDataForReadBack = nineLineDataForReadBack or {}
			nineLineDataForReadBack.final_attack_heading = messageTbl.parameters.final_attack_heading
		elseif	event == Message.wMsgFACTargetDestroyed or
				event == Message.wMsgFACTargetPartiallyDestroyed or
				event == Message.wMsgFACTargetNotDestroyed then
			fsmBDA:onSymbol('BDA')
		elseif	event == Message.wMsgLeaderCheckOut or
				event == Message.wMsgFAC_CLEARED_TO_DEPART or
				event == Message.wMsgFACNoTaskingAvailableClearedToDepart then
			fsmBDA:onSymbol('Stop engaging')
		end
	end
}

table.insert(data.msgHandlers, msgHandler)

local send9LineReadBack = {
	perform = function(self, parameters)
		assert(nineLineDataForReadBack ~= nil)
		data.pComm:sendMessage(	{	type = Message.type.TYPE_CONSTRUCTABLE,
									playMode = Message.playMode.PLAY_MODE_LIMITED_DURATION,
									event = Message.wMsgLeader9LineReadback,									
									parameters = nineLineDataForReadBack},  parameters[1])
	end	
}

--Menus
local menus = data.menus

menus['JTAC'] = {
	name = _('JTAC'),
	items = {
		{name = _('Check-in 15 min'), 						command = sendMessage.new(Message.wMsgLeaderCheckIn, 15 * 60)},
		{name = _('Check-in 30 min'), 						command = sendMessage.new(Message.wMsgLeaderCheckIn, 30 * 60)},
		{name = _('Check-in 45 min'), 						command = sendMessage.new(Message.wMsgLeaderCheckIn, 45 * 60)},
		{name = _('Check-in 60 min'), 						command = sendMessage.new(Message.wMsgLeaderCheckIn, 60 * 60)}
	}
}

local function getJTACList()
	local selfCoalition = data.pUnit:getCoalition()
	local JTACs = coalition.getServiceProviders(selfCoalition, coalition.service.FAC)
	local selfPoint = data.pUnit:getPosition().p
	local function distanceSorter(lu, ru)
		
		local lpoint = lu:getPosition().p
		local ldist2 = (lpoint.x - selfPoint.x) * (lpoint.x - selfPoint.x) + (lpoint.z - selfPoint.z) * (lpoint.z - selfPoint.z)
		
		local rpoint = ru:getPosition().p
		local rdist2 = (rpoint.x - selfPoint.x) * (rpoint.x - selfPoint.x) + (rpoint.z - selfPoint.z) * (rpoint.z - selfPoint.z)
				
		return ldist2 < rdist2
	end
	table.sort(JTACs, distanceSorter)
	return JTACs
end

local function buildJTACs(self, menu)
	local ammo = data.pUnit:getAmmo()
	if ammo ~= nil then
		local JTACs = getJTACList()
		if 	not data.showingOnlyPresentRecepients or
			getRecepientsState(JTACs) ~= RecepientState.VOID then
			menu.items[mainMenuPos] = buildRecepientsMenu(JTACs, _('JTAC'), { name = _('JTAC'), submenu = menus['JTAC'] })
		end
	end
end

table.insert(data.rootItem.builders, buildJTACs)

--Dialog

local repeatBDAMenuItem = { name = _('Repeat BDA'),
							command = sendMessage.new(Message.wMsgLeaderRequestBDA),
							condition = {
								check = function(self)
									return repeatBDAAllowed
								end
							} }

local dialog = {}
dialogsData.dialogs['JTAC'] = dialog

dialog.name = _('JTAC')
dialog.menus = {}
dialog.menus['Ready to task'] = {
	name = _('Ready to task'),
	items = {
		[1] = { name = _('Request tasking'), 		command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		[2] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 1 - 2. Ready for 9-line'] = {
	name = _('Ready for 9-line'),
	items = {
		[1] = { name = _('Ready to copy'), 			command = sendMessage.new(Message.wMsgLeaderReadyToCopy) },
		[2] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 1 - 2. Ready for remarks'] = {
	name = _('Ready for remarks'),
	items = {
		[1] = { name = _('Ready to copy remarks'),	command = sendMessage.new(Message.wMsgLeaderReadyToCopyRemarks) },
		[2] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[3] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 1 - 2. WP. Ready for remarks'] = dialog.menus['Type 1 - 2. Ready for remarks']
dialog.menus['Type 1 - 2. WPLaser. Ready for remarks'] = dialog.menus['Type 1 - 2. Ready for remarks']
dialog.menus['Type 1 - 2. IR. Ready for remarks'] = dialog.menus['Type 1 - 2. Ready for remarks']
dialog.menus['Type 1 - 2. Laser. Ready for remarks'] = dialog.menus['Type 1 - 2. Ready for remarks']
dialog.menus['Type 1 - 2. 9-line readback'] = {
	name = _('9-line readback'),
	items = {
		[1] = { name = _('9-line readback'), 		command = send9LineReadBack },
		[2] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[3] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 1 - 2. WP. 9-line readback'] = dialog.menus['Type 1 - 2. 9-line readback']
dialog.menus['Type 1 - 2. WPLaser. 9-line readback'] = dialog.menus['Type 1 - 2. 9-line readback']
dialog.menus['Type 1 - 2. IR. 9-line readback'] = dialog.menus['Type 1 - 2. 9-line readback']
dialog.menus['Type 1 - 2. Laser. 9-line readback'] = dialog.menus['Type 1 - 2. 9-line readback']
dialog.menus['Type 1 - 2. Ready for action'] = {
	name = _('Ready for action'),
	items = {
		[1] = { name = _('IP INBOUND'), 			command = sendMessage.new(Message.wMsgLeader_IP_INBOUND)},
		[2] = { name = _('Repeat brief'), 			command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		[3] = { name = _('What is my target?'), 	command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },
		[4] = { name = _('Contact'), 				command = sendMessage.new(Message.wMsgLeaderContact, 0)},
		[5] = repeatBDAMenuItem,
		[6] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[7] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 1 - 2. WP. Ready for action'] = dialog.menus['Type 1 - 2. Ready for action']
dialog.menus['Type 1 - 2. WPLaser. Ready for action'] = dialog.menus['Type 1 - 2. Ready for action']
dialog.menus['Type 1 - 2. WP. Wait for mark'] = {
	name = _('WP Wait for smoke'),
	items = {
		[1] = { name = _('Repeat brief'), 			command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		[2] = { name = _('What is my target?'), 	command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },
		[3] = { name = _('Contact'), 				command = sendMessage.new(Message.wMsgLeaderContact, 0)},
		[4] = repeatBDAMenuItem,
		[5] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[6] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 1 - 2. WP. Wait for mark spot'] = {
	name = _('WP Wait for smoke spot'),
	items = {
		[1] = { name = _('Contact the mark'), 		command = sendMessage.new(Message.wMsgLeader_CONTACT_the_mark)},
		[2] = { name = _('Repeat brief'), 			command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		[3] = { name = _('What is my target?'), 	command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },
		[4] = { name = _('Contact'), 				command = sendMessage.new(Message.wMsgLeaderContact, 0) },
		[5] = repeatBDAMenuItem,
		[6] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[7] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}

dialog.menus['Type 1 - 2. WPLaser. Wait for mark'] = {
	name = _('WPLaser Wait for smoke'),
	items = {
		[1] = { name = _('LASER ON'), 				command = sendMessage.new(Message.wMsgLeader_LASER_ON) },	
		[2] = { name = _('Repeat brief'), 			command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		[3] = { name = _('What is my target?'), 	command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },
		[4] = { name = _('Contact'), 				command = sendMessage.new(Message.wMsgLeaderContact, 0)},
		[5] = repeatBDAMenuItem,
		[6] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[7] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 1 - 2. WPLaser. Wait for mark spot'] = {
	name = _('WPLaser Wait for smoke spot'),
	items = {
		[1] = { name = _('Contact the mark'), 		command = sendMessage.new(Message.wMsgLeader_CONTACT_the_mark)},
		[2] = { name = _('Repeat brief'), 			command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		[3] = { name = _('What is my target?'), 	command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },
		[4] = { name = _('Contact'), 				command = sendMessage.new(Message.wMsgLeaderContact, 0) },
		[5] = repeatBDAMenuItem,
		[6] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[7] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}

dialog.menus['Type 1 - 2. IR. Ready for action'] = dialog.menus['Type 1 - 2. Ready for action']
dialog.menus['Type 1 - 2. IR. Wait for mark'] = {
	name = _('Waiting for SPARKLE'),
	items = {
		[1] = { name = _('SPARKLE'), 				command = sendMessage.new(Message.wMsgLeader_SPARKLE) },
		[2] = { name = _('Repeat brief'), 			command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		[3] = { name = _('What is my target?'), 	command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },
		[4] = { name = _('Contact'), 				command = sendMessage.new(Message.wMsgLeaderContact, 0)},
		[5] = repeatBDAMenuItem,
		[6] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[7] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 1 - 2. IR. STEADY'] = {
	name = _('IR-Pointer. STEADY'),
	items = {
		{ name = _('CONTACT SPARKLE'), 			command = sendMessage.new(Message.wMsgLeader_CONTACT_SPARKLE)},
		{ name = _('SNAKE'), 					command = sendMessage.new(Message.wMsgLeader_SNAKE)},
		--{ name = _('PULSE'), 					command = sendMessage.new(Message.wMsgLeader_PULSE)},
		{ name = _('STOP'), 					command = sendMessage.new(Message.wMsgLeader_STOP)},
		{ name = _('Repeat brief'), 			command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		{ name = _('What is my target?'), 		command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },
		{ name = _('Contact'), 					command = sendMessage.new(Message.wMsgLeaderContact, 0) },
		repeatBDAMenuItem,
		{ name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		{ name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }	
	}
}
dialog.menus['Type 1 - 2. IR. SNAKE'] = {
	name = _('IR-Pointer. SNAKE'),
	items = {
		{ name = _('CONTACT SPARKLE'), 			command = sendMessage.new(Message.wMsgLeader_CONTACT_SPARKLE)},
		{ name = _('STEADY'), 					command = sendMessage.new(Message.wMsgLeader_STEADY)},
		--{ name = _('PULSE'), 					command = sendMessage.new(Message.wMsgLeader_PULSE)},
		{ name = _('STOP'), 					command = sendMessage.new(Message.wMsgLeader_STOP)},
		{ name = _('Repeat brief'), 			command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		{ name = _('What is my target?'), 		command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },
		{ name = _('Contact'), 					command = sendMessage.new(Message.wMsgLeaderContact, 0)},
		repeatBDAMenuItem,
		{ name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		{ name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }	
	}	
}
dialog.menus['Type 1 - 2. IR. PULSE'] = {
	name = _('IR-Pointer. PULSE'),
	items = {
		[1] = { name = _('CONTACT SPARKLE'), 		command = sendMessage.new(Message.wMsgLeader_CONTACT_SPARKLE)},
		[2] = { name = _('STEADY'), 				command = sendMessage.new(Message.wMsgLeader_STEADY)},
		[3] = { name = _('SNAKE'), 					command = sendMessage.new(Message.wMsgLeader_SNAKE)},
		[4] = { name = _('STOP'), 					command = sendMessage.new(Message.wMsgLeader_STOP)},
		[5] = { name = _('Repeat brief'), 			command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		[6] = { name = _('What is my target?'), 	command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },
		[7] = { name = _('Contact'), 				command = sendMessage.new(Message.wMsgLeaderContact, 0)},
		[8] = repeatBDAMenuItem,
		[9] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[10] = { name = _('Check out'), 			command = sendMessage.new(Message.wMsgLeaderCheckOut) }	
	}
}
dialog.menus['Type 1 - 2. Laser. Ready for action'] = dialog.menus['Type 1 - 2. Ready for action']
dialog.menus['Type 1 - 2. Laser. 10 sec readiness'] = {
	name = _('TEN SECONDS TO LASER'),
	items = {
		[1] = { name = _('LASER ON'), 				command = sendMessage.new(Message.wMsgLeader_LASER_ON) },
		[2] = { name = _('TEN SECONDS'), 			command = sendMessage.new(Message.wMsgLeader_TEN_SECONDS) },
		[3] = { name = _('Repeat brief'), 			command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		[4] = { name = _('What is my target?'), 	command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },
		[5] = { name = _('Contact'), 				command = sendMessage.new(Message.wMsgLeaderContact, 0)},
		[6] = repeatBDAMenuItem,
		[7] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[8] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 1 - 2. Laser. Wait for mark'] = {
	name = _('Wait for laser'),
	items = {
		[1] = { name = _('LASER ON'), 				command = sendMessage.new(Message.wMsgLeader_LASER_ON) },
		[2] = { name = _('Repeat brief'), 			command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		[3] = { name = _('What is my target?'), 	command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },
		[4] = { name = _('Contact'), 				command = sendMessage.new(Message.wMsgLeaderContact, 0)},
		[5] = repeatBDAMenuItem,
		[6] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[7] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 1 - 2. Laser. Wait for mark spot'] = {
	name = _('Wait for laser spot'),
	items = {
		[1] = { name = _('SPOT'), 					command = sendMessage.new(Message.wMsgLeader_SPOT)},
		[2] = { name = _('TERMINATE'), 				command = sendMessage.new(Message.wMsgLeader_TERMINATE)},
		[3] = { name = _('SHIFT'), 					command = sendMessage.new(Message.wMsgLeader_SHIFT)},
		[4] = { name = _('Repeat brief'), 			command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		[5] = { name = _('What is my target?'), 	command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },
		[6] = { name = _('Contact'), 				command = sendMessage.new(Message.wMsgLeaderContact, 0)},
		[7] = repeatBDAMenuItem,
		[8] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[9] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 1 - 2. IP INBOUND'] = {
	name = _('IP INBOUND'),
	items = {
		[1] = { name = _('IN'), 					command = sendMessage.new(Message.wMsgLeader_IN) },
		[2] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[3] = { name = _('What is my target?'), 	command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },
		[4] = { name = _('Contact'), 				command = sendMessage.new(Message.wMsgLeaderContact, 0) },
		[5] = repeatBDAMenuItem,
		[6] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 1 - 2. RUNNING IN'] = {
	name = _('RUNNING IN'),
	items = {
		[1] = { name = _('OFF'), 					command = sendMessage.new(Message.wMsgLeader_OFF) },
		[2] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[3] = { name = _('What is my target?'), 	command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },
		[4] = { name = _('Contact'), 				command = sendMessage.new(Message.wMsgLeaderContact, 0) },
		[5] = repeatBDAMenuItem,
		[6] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 3. Ready for 9-line'] = {
	name = _('Ready for 9-line'),
	items = {
		[1] = { name = _('Ready to copy'), 			command = sendMessage.new(Message.wMsgLeaderReadyToCopy) },
		[2] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 3. Ready for remarks'] = {
	name = _('Ready for remarks'),
	items = {
		[1] = { name = _('Ready to copy remarks'),	command = sendMessage.new(Message.wMsgLeaderReadyToCopyRemarks) },
		[2] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 3. 9-line readback'] = {
	name = _('9-line readback'),
	items = {
		[1] = { name = _('9-line readback'), 		command = send9LineReadBack },
		[2] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 3. WP. Ready for remarks'] = dialog.menus['Type 3. Ready for remarks']
dialog.menus['Type 3. WPLaser. Ready for remarks'] = dialog.menus['Type 3. Ready for remarks']
dialog.menus['Type 3. IR. Ready for remarks'] = dialog.menus['Type 3. Ready for remarks']
dialog.menus['Type 3. Laser. Ready for remarks'] = dialog.menus['Type 3. Ready for remarks']
dialog.menus['Type 3. Ready for action'] = {
	name = _('Ready for action'),
	items = {
		[1] = { name = _('Repeat brief'), 			command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		[2] = { name = _('What is my target?'), 	command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },		
		[3] = { name = _('Contact'), 				command = sendMessage.new(Message.wMsgLeaderContact, 0)},
		[4] = repeatBDAMenuItem,
		[5] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[6] = { name = _('Check out'), 				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}
dialog.menus['Type 3. ENGAGEMENT'] = {
	name = _('ENGAGEMENT'),
	items = {
		[1] = { name = _('ATTACK COMPLETE'), 		command = sendMessage.new(Message.wMsgLeader_ATTACK_COMPLETE )},
		[2] = { name = _('Repeat brief'), 			command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		[3] = { name = _('Unable to comply'), 		command = sendMessage.new(Message.wMsgLeaderUnableToComply) },
		[4] = { name = _('What is my target?'), 	command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },
		[5] = { name = _('Contact'), 				command = sendMessage.new(Message.wMsgLeaderContact, 0)},
		[6] = repeatBDAMenuItem,
		[7] = { name = _('Check out'),				command = sendMessage.new(Message.wMsgLeaderCheckOut) }
	}
}

dialog.stages = {
	['Closed'] = {	
		[Message.wMsgFACType1InEffectAdviseWhenReadyFor9Line] 	= TO_STAGE('JTAC', 'Type 1 - 2. Ready for 9-line'),
		[Message.wMsgFACType2InEffectAdviseWhenReadyFor9Line] 	= TO_STAGE('JTAC', 'Type 1 - 2. Ready for 9-line'),
		[Message.wMsgFACType3InEffectAdviseWhenReadyFor9Line] 	= TO_STAGE('JTAC', 'Type 3. Ready for 9-line'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	--Ready to task
	['Ready to task'] = {
		[Message.wMsgFACType1InEffectAdviseWhenReadyFor9Line] 	= TO_STAGE('JTAC', 'Type 1 - 2. Ready for 9-line'),
		[Message.wMsgFACType2InEffectAdviseWhenReadyFor9Line] 	= TO_STAGE('JTAC', 'Type 1 - 2. Ready for 9-line'),
		[Message.wMsgFACType3InEffectAdviseWhenReadyFor9Line] 	= TO_STAGE('JTAC', 'Type 3. Ready for 9-line'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	--Type 1 - 2
	['Type 1 - 2. Ready for 9-line'] = {		
		[Message.wMsgFACType3InEffectAdviseWhenReadyFor9Line] 	= TO_STAGE('JTAC', 'Type 3. Ready for 9-line'),	
		[Message.wMsgFAC9lineBrief] 							= TO_STAGE('JTAC', 'Type 1 - 2. Ready for action'),
		[Message.wMsgFAC9lineBriefWP] 							= TO_STAGE('JTAC', 'Type 1 - 2. WP. Ready for action'),
		[Message.wMsgFAC9lineBriefWPLaser] 						= TO_STAGE('JTAC', 'Type 1 - 2. WPLaser. Ready for action'),
		[Message.wMsgFAC9lineBriefIRPointer] 					= TO_STAGE('JTAC', 'Type 1 - 2. IR. Ready for action'),
		[Message.wMsgFAC9lineBriefLaser] 						= TO_STAGE('JTAC', 'Type 1 - 2. Laser. Ready for action'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	--Type 1 - 2
	--Mark: NONE
	['Type 1 - 2. Ready for action'] = {
		[Message.wMsgFAC_CONTINUE]								= TO_STAGE('JTAC', 'Type 1 - 2. IP INBOUND', true),
		[Message.wMsgFACAdviseWhenReadyForRemarksAndFutherTalkOn]	= TO_STAGE('JTAC', 'Type 1 - 2. Ready for remarks'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 	= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. Ready for remarks'] = {
		[Message.wMsgFAC9lineRemarks] 							= TO_STAGE('JTAC', 'Type 1 - 2. 9-line readback'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. 9-line readback'] = {
		[Message.wMsgFACReport_IP_INBOUND] 						= TO_STAGE('JTAC', 'Type 1 - 2. Ready for action'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},		
	--Mark: WP
	['Type 1 - 2. WP. Ready for action'] = {
		[Message.wMsgFAC_CONTINUE]								= TO_STAGE('JTAC', 'Type 1 - 2. WP. Wait for mark', true),
		[Message.wMsgFACAdviseWhenReadyForRemarksAndFutherTalkOn]	= TO_STAGE('JTAC', 'Type 1 - 2. WP. Ready for remarks'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. Ready for action'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 	= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. WP. Ready for remarks'] = {
		[Message.wMsgFAC9lineRemarks] 							= TO_STAGE('JTAC', 'Type 1 - 2. WP. 9-line readback'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. Ready for remarks'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. WP. 9-line readback'] = {
		[Message.wMsgFACReport_IP_INBOUND] 						= TO_STAGE('JTAC', 'Type 1 - 2. WP. Ready for action'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. 9-line readback'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. WP. Wait for mark'] = {
		[Message.wMsgFACMarkOnDeck]								= TO_STAGE('JTAC', 'Type 1 - 2. WP. Wait for mark spot'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. IP INBOUND'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. WP. Wait for mark spot'] = {
		[Message.wMsgLeader_CONTACT_the_mark]					= TO_STAGE('JTAC', 'Type 1 - 2. IP INBOUND'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	--Mark: WPLaser
	['Type 1 - 2. WPLaser. Ready for action'] = {
		[Message.wMsgFAC_CONTINUE]								= TO_STAGE('JTAC', 'Type 1 - 2. WPLaser. Wait for mark', true),
		[Message.wMsgFACAdviseWhenReadyForRemarksAndFutherTalkOn]	= TO_STAGE('JTAC', 'Type 1 - 2. WPLaser. Ready for remarks'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. Ready for action'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 	= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. WPLaser. Ready for remarks'] = {
		[Message.wMsgFAC9lineRemarks] 							= TO_STAGE('JTAC', 'Type 1 - 2. WPLaser. 9-line readback'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. Ready for remarks'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. WPLaser. 9-line readback'] = {
		[Message.wMsgFACReport_IP_INBOUND] 						= TO_STAGE('JTAC', 'Type 1 - 2. WPLaser. Ready for action'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. 9-line readback'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. WPLaser. Wait for mark'] = {
		[Message.wMsgFACMarkOnDeck]								= TO_STAGE('JTAC', 'Type 1 - 2. WPLaser. Wait for mark spot'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. IP INBOUND'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. WPLaser. Wait for mark spot'] = {
		[Message.wMsgLeader_CONTACT_the_mark]					= TO_STAGE('JTAC', 'Type 1 - 2. Laser. Wait for mark'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	--Mark: IR
	['Type 1 - 2. IR. Ready for action'] = {
		[Message.wMsgFAC_CONTINUE]								= TO_STAGE('JTAC', 'Type 1 - 2. IR. Wait for mark', true),
		[Message.wMsgFACAdviseWhenReadyForRemarksAndFutherTalkOn]	= TO_STAGE('JTAC', 'Type 1 - 2. IR. Ready for remarks'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. Ready for action'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. IR. Ready for remarks'] = {
		[Message.wMsgFAC9lineRemarks] 							= TO_STAGE('JTAC', 'Type 1 - 2. IR. 9-line readback'),
		[Message.wMsgFAC_NoMark] 								= TO_STAGE('JTAC', 'Type 1 - 2. Ready for remarks'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. IR. 9-line readback'] = {
		[Message.wMsgFACReport_IP_INBOUND] 						= TO_STAGE('JTAC', 'Type 1 - 2. IR. Ready for action'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. 9-line readback'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},	
	['Type 1 - 2. IR. Wait for mark'] = {
		[Message.wMsgFAC_SPARKLE]								= TO_STAGE('JTAC', 'Type 1 - 2. IR. STEADY'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. IP INBOUND'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. IR. STEADY'] = {	
		[Message.wMsgLeader_CONTACT_SPARKLE]					= TO_STAGE('JTAC', 'Type 1 - 2. IP INBOUND'),
		[Message.wMsgFAC_SNAKE]									= TO_STAGE('JTAC', 'Type 1 - 2. IR. SNAKE'),
		[Message.wMsgFAC_PULSE]									= TO_STAGE('JTAC', 'Type 1 - 2. IR. PULSE'),		
		[Message.wMsgFAC_STOP]									= TO_STAGE('JTAC', 'Type 1 - 2. IR. Wait for mark'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. IP INBOUND'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. IR. SNAKE'] = {	
		[Message.wMsgLeader_CONTACT_SPARKLE]					= TO_STAGE('JTAC', 'Type 1 - 2. IP INBOUND'),
		[Message.wMsgFAC_STEADY]								= TO_STAGE('JTAC', 'Type 1 - 2. IR. STEADY'),
		[Message.wMsgFAC_PULSE]									= TO_STAGE('JTAC', 'Type 1 - 2. IR. PULSE'),		
		[Message.wMsgFAC_STOP]									= TO_STAGE('JTAC', 'Type 1 - 2. IR. Wait for mark'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. IP INBOUND'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. IR. PULSE'] = {	
		[Message.wMsgLeader_CONTACT_SPARKLE]					= TO_STAGE('JTAC', 'Type 1 - 2. IP INBOUND'),
		[Message.wMsgFAC_STEADY]								= TO_STAGE('JTAC', 'Type 1 - 2. IR. STEADY'),
		[Message.wMsgFAC_SNAKE]									= TO_STAGE('JTAC', 'Type 1 - 2. IR. SNAKE'),
		[Message.wMsgFAC_STOP]									= TO_STAGE('JTAC', 'Type 1 - 2. IR. Wait for mark'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. IP INBOUND'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	--Mark: Laser
	['Type 1 - 2. Laser. Ready for action'] = {
		[Message.wMsgFAC_CONTINUE]								= TO_STAGE('JTAC', 'Type 1 - 2. Laser. 10 sec readiness', true),
		[Message.wMsgFACAdviseWhenReadyForRemarksAndFutherTalkOn]= TO_STAGE('JTAC', 'Type 1 - 2. Laser. Ready for remarks'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. Ready for action'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},	
	['Type 1 - 2. Laser. Ready for remarks'] = {
		[Message.wMsgFAC9lineRemarks] 							= TO_STAGE('JTAC', 'Type 1 - 2. Laser. 9-line readback'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. Laser. Ready for remarks'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. Laser. 9-line readback'] = {
		[Message.wMsgFACReport_IP_INBOUND] 						= TO_STAGE('JTAC', 'Type 1 - 2. Laser. Ready for action'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. Laser. 9-line readback'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},	
	['Type 1 - 2. Laser. 10 sec readiness'] = {
		[Message.wMsgLeader_TEN_SECONDS]						= TO_STAGE('JTAC', 'Type 1 - 2. Laser. Wait for mark'),
		[Message.wMsgFAC_LASER_ON]								= TO_STAGE('JTAC', 'Type 1 - 2. Laser. Wait for mark spot'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. IP INBOUND'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},	
	['Type 1 - 2. Laser. Wait for mark'] = {
		[Message.wMsgFAC_LASER_ON]								= TO_STAGE('JTAC', 'Type 1 - 2. Laser. Wait for mark spot'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. IP INBOUND'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 1 - 2. Laser. Wait for mark spot'] = {
		[Message.wMsgLeader_SPOT]								= TO_STAGE('JTAC', 'Type 1 - 2. IP INBOUND'),
		[Message.wMsgFAC_TERMINATE]								= TO_STAGE('JTAC', 'Type 1 - 2. Laser. Wait for mark'),
		[Message.wMsgFAC_NoMark]								= TO_STAGE('JTAC', 'Type 1 - 2. IP INBOUND'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	--Attack
	['Type 1 - 2. IP INBOUND'] = {
		[Message.wMsgFAC_CLERED_HOT]							= TO_STAGE('JTAC', 'Type 1 - 2. RUNNING IN'),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT_ATTACK]							= TO_STAGE('JTAC', 'Type 1 - 2. Ready for action'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},		
	['Type 1 - 2. RUNNING IN'] = {
		[Message.wMsgFACTargetPartiallyDestroyed]				= RETURN_TO_STAGE(),
		[Message.wMsgFACTargetNotDestroyed]						= RETURN_TO_STAGE(),
		[Message.wMsgLeaderUnableToComply]						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT]									= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	--Type 3
	['Type 3. Ready for 9-line'] = {
		[Message.wMsgFACType1InEffectAdviseWhenReadyFor9Line] 	= TO_STAGE('JTAC', 'Type 1 - 2. Ready for 9-line'),
		[Message.wMsgFACType2InEffectAdviseWhenReadyFor9Line] 	= TO_STAGE('JTAC', 'Type 1 - 2. Ready for 9-line'),	
		[Message.wMsgFAC9lineBrief] 							= TO_STAGE('JTAC', 'Type 3. Ready for action'),
		[Message.wMsgFAC9lineBriefWP] 							= TO_STAGE('JTAC', 'Type 3. Ready for action'),
		[Message.wMsgFAC9lineBriefWPLaser] 						= TO_STAGE('JTAC', 'Type 3. Ready for action'),
		[Message.wMsgFAC9lineBriefIRPointer] 					= TO_STAGE('JTAC', 'Type 3. Ready for action'),
		[Message.wMsgFAC9lineBriefLaser] 						= TO_STAGE('JTAC', 'Type 3. Ready for action'),		
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 3. Ready for remarks'] = {
		[Message.wMsgFAC9lineRemarks] 							= TO_STAGE('JTAC', 'Type 3. 9-line readback'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 3. 9-line readback'] = {
		[Message.wMsgFACReadBackCorrect] 						= TO_STAGE('JTAC', 'Type 3. Ready for action'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderUnableToComply] 						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},		
	['Type 3. Ready for action'] = {
		[Message.wMsgFAC_CLEARED_TO_ENGAGE]						= TO_STAGE('JTAC', 'Type 3. ENGAGEMENT'),
		[Message.wMsgFACAdviseWhenReadyForRemarksAndFutherTalkOn]	= TO_STAGE('JTAC', 'Type 3. Ready for remarks'),
		[Message.wMsgLeaderUnableToComply]						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT] 								= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed]						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart]		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART]						= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	},
	['Type 3. ENGAGEMENT'] = {
		[Message.wMsgLeaderUnableToComply]						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFAC_ABORT]									= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACTargetDestroyed]						= TO_STAGE('JTAC', 'Ready to task'),
		[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= TERMINATE(),
		[Message.wMsgFAC_CLEARED_TO_DEPART] 					= TERMINATE(),
		[Message.wMsgLeaderCheckOut]							= TERMINATE()
	}
}
--[[
dialogsData.dialogs['WP'] = {}
dialogsData.dialogs['WP'].name = _('WP')
dialogsData.dialogs['WP'].menus = {}
dialogsData.dialogs['WP'].menus['Waiting for contact'] = {
	name = _('Waiting for contact'),
	items = {
		{ name = _('Contact the mark'), 		command = sendMessage.new(Message.wMsgLeader_CONTACT_the_mark)},
	}
}
dialogsData.dialogs['WP'].stages = {
	['Closed'] = {
		[Message.wMsgFACMarkOnDeck]							= TO_STAGE('WP', 'Waiting for contact'),
	}
}
dialogsData.dialogs['IR-Pointer'] = {}
dialogsData.dialogs['IR-Pointer'].name = _('IR-Pointer')
dialogsData.dialogs['IR-Pointer'].menus = {}
dialogsData.dialogs['IR-Pointer'].menus['Ready'] = {
	name = _('Ready'),
	items = {
		{ name = _('SPARKLE'), 					command = sendMessage.new(Message.wMsgLeader_SPARKLE) },
	}
}
dialogsData.dialogs['IR-Pointer'].menus['STEADY'] = {
	name = _('STEADY'),
	items = {
		{ name = _('SNAKE'), 						command = sendMessage.new(Message.wMsgLeader_SNAKE)},
		{ name = _('PULSE'), 						command = sendMessage.new(Message.wMsgLeader_PULSE)},
		{ name = _('STOP'), 						command = sendMessage.new(Message.wMsgLeader_STOP)},
		{ name = _('ROPE'), 						command = sendMessage.new(Message.wMsgLeader_ROPE)}
	}
}
dialogsData.dialogs['IR-Pointer'].menus['SNAKE'] = {
	name = _('SNAKE'),
	items = {
		{ name = _('STEADY'), 						command = sendMessage.new(Message.wMsgLeader_STEADY)},
		{ name = _('PULSE'), 						command = sendMessage.new(Message.wMsgLeader_PULSE)},
		{ name = _('STOP'), 						command = sendMessage.new(Message.wMsgLeader_STOP)},
		{ name = _('ROPE'), 						command = sendMessage.new(Message.wMsgLeader_ROPE)}
	}	
}
dialogsData.dialogs['IR-Pointer'].menus['PULSE'] = {
	name = _('PULSE'),
	items = {
		{ name = _('STEADY'), 						command = sendMessage.new(Message.wMsgLeader_STEADY)},
		{ name = _('SNAKE'), 						command = sendMessage.new(Message.wMsgLeader_SNAKE)},
		{ name = _('STOP'), 						command = sendMessage.new(Message.wMsgLeader_STOP)},
		{ name = _('ROPE'), 						command = sendMessage.new(Message.wMsgLeader_ROPE)}
	}
}
dialogsData.dialogs['IR-Pointer'].menus['ROPE'] = {
	name = _('ROPE'),
	items = {
		{ name = _('STEADY'), 						command = sendMessage.new(Message.wMsgLeader_STEADY)},
		{ name = _('SNAKE'), 						command = sendMessage.new(Message.wMsgLeader_SNAKE)},
		{ name = _('PULSE'), 						command = sendMessage.new(Message.wMsgLeader_PULSE)},
		{ name = _('STOP'), 						command = sendMessage.new(Message.wMsgLeader_STOP)}		
	}
}
dialogsData.dialogs['IR-Pointer'].stages = {
	['Closed'] = {
		[events.START_IR_POINTER_DIALOG]						= TO_STAGE('IR-Pointer', 'Ready'),
	},
	['Ready'] = {
		[Message.wMsgFAC_SPARKLE]							= TO_STAGE('IR-Pointer', 'STEADY'),
	},
	['STEADY'] = {
		[Message.wMsgFAC_SNAKE]							= TO_STAGE('IR-Pointer', 'SNAKE'),
		[Message.wMsgFAC_PULSE]							= TO_STAGE('IR-Pointer', 'PULSE'),
		[Message.wMsgFAC_ROPE]								= TO_STAGE('IR-Pointer', 'ROPE'),
		[Message.wMsgFAC_STOP]								= TO_STAGE('IR-Pointer', 'Ready'),
	},
	['SNAKE'] = {
		[Message.wMsgFAC_PULSE]							= TO_STAGE('IR-Pointer', 'PULSE'),
		[Message.wMsgFAC_STEADY]							= TO_STAGE('IR-Pointer', 'STEADY'),
		[Message.wMsgFAC_ROPE]								= TO_STAGE('IR-Pointer', 'ROPE'),
		[Message.wMsgFAC_STOP]								= TO_STAGE('IR-Pointer', 'Ready'),
	},
	['PULSE'] = {
		[Message.wMsgFAC_SNAKE]							= TO_STAGE('IR-Pointer', 'SNAKE'),
		[Message.wMsgFAC_STEADY]							= TO_STAGE('IR-Pointer', 'STEADY'),
		[Message.wMsgFAC_ROPE]								= TO_STAGE('IR-Pointer', 'ROPE'),
		[Message.wMsgFAC_STOP]								= TO_STAGE('IR-Pointer', 'Ready'),
	},
	['ROPE'] = {
		[Message.wMsgFAC_SNAKE]							= TO_STAGE('IR-Pointer', 'SNAKE'),
		[Message.wMsgFAC_PULSE]							= TO_STAGE('IR-Pointer', 'PULSE'),
		[Message.wMsgFAC_STEADY]							= TO_STAGE('IR-Pointer', 'STEADY'),
		[Message.wMsgFAC_STOP]								= TO_STAGE('IR-Pointer', 'Ready'),
	},
}
dialogsData.dialogs['Laser'] = {}
dialogsData.dialogs['Laser'].name = _('Laser')
dialogsData.dialogs['Laser'].menus = {}
dialogsData.dialogs['Laser'].menus['Ready'] = {
	name = _('Ready'),
	items = {
		{ name = _('TEN SECONDS'), 			command = sendMessage.new(Message.wMsgLeader_TEN_SECONDS) },
	}
}
dialogsData.dialogs['Laser'].menus['Prepare'] = {
	name = _('Prepare'),
	items = {
		{ name = _('LASER ON'), 				command = sendMessage.new(Message.wMsgLeader_LASER_ON) },
	}
}
dialogsData.dialogs['Laser'].menus['Lasing'] = {
	name = _('Lasing'),
	items = {
		{ name = _('SHIFT'), 					command = sendMessage.new(Message.wMsgLeader_SHIFT)},
		{ name = _('TERMINATE'), 				command = sendMessage.new(Message.wMsgLeader_TERMINATE)},		
	}
}
dialogsData.dialogs['Laser'].stages = {
	['Closed'] = {
		[events.START_LASER_DIALOG]										= TO_STAGE('Laser', 'Ready'),
	},
	['Ready'] = {
		[Message.wMsgLeader_TEN_SECONDS]							= TO_STAGE('Laser', 'Prepare'),
	},
	['Prepare'] = {
		[Message.wMsgFAC_LASER_ON]									= TO_STAGE('Laser', 'Lasing'),
	},
	['Lasing'] = {
		[Message.wMsgFAC_TERMINATE]								= TO_STAGE('Laser', 'Prepare'),
	},	
}
dialogsData.dialogs['JTAC. Questions about task'].name = _('JTAC. Questions about task')
dialogsData.dialogs['JTAC. Questions about task'].menus = {}
dialogsData.dialogs['JTAC. Questions about task'].menus['Tasked'] = {
	name = _('Tasked'),
	items = {
		{ name = _('Repeat brief'), 			command = sendMessage.new(Message.wMsgLeaderRequestTasking) },
		{ name = _('What is my target?'), 		command = sendMessage.new(Message.wMsgLeaderRequestTargetDescription) },		
		{ name = _('Contact'), 				command = sendMessage.new(Message.wMsgLeaderContact, 0) },
	}
}
dialogsData.dialogs['JTAC. Repeat BDA'].name = _('JTAC. Repeat BDA')
dialogsData.dialogs['JTAC. Repeat BDA'].menus = {}
dialogsData.dialogs['JTAC. Repeat BDA'].menus['BDA received'] = {
	name = _('BDA received'),
	items = {
		{ name = _('Repeat BDA'), 			command = sendMessage.new(Message.wMsgLeaderRequestBDA)},
	}
}
--]]

local trigger = DialogStartTrigger:new(dialog)
dialogsData.triggers[Message.wMsgFACType1InEffectAdviseWhenReadyFor9Line] = trigger
dialogsData.triggers[Message.wMsgFACType2InEffectAdviseWhenReadyFor9Line] = trigger
dialogsData.triggers[Message.wMsgFACType3InEffectAdviseWhenReadyFor9Line] = trigger
--[[
[Message.wMsgFAC9lineBriefWP]								= nil,
[Message.wMsgFAC9lineBriefIRPointer]						= StartFSMTrigger:new(	self,	'IR-Pointer',
																						{
																							init_state = 'OFF',
																							transitions = {
																								OFF = {
																									[Message.wMsgFAC_CONTINUE]							= { outSymbol = events.START_IR_POINTER_DIALOG,
																																								newState = 'ON' }
																								},
																								ON = {
																									[Message.wMsgFACNoTaskingAvailableClearedToDepart] = { outSymbol = nil,
																																								newState = 'OFF' },
																									[Message.wMsgFAC_CLEARED_TO_DEPART] 				= { outSymbol = nil,
																																								newState = 'OFF' },
																									[Message.wMsgLeaderCheckOut]						= { outSymbol = nil,
																																								newState = 'OFF' }
																								}
																							}
																						}
																					),
[Message.wMsgFAC9lineBriefLaser]							= StartFSMTrigger:new(	self,	'Laser',
																						{
																							init_state = 'OFF',
																							transitions = {
																								OFF = {
																									[Message.wMsgFAC_CONTINUE]							= {	outSymbol = events.START_LASER_DIALOG,
																																								newState = 'ON' }
																								},
																								ON = {
																									[Message.wMsgFACNoTaskingAvailableClearedToDepart] = { outSymbol = nil,
																																								newState = 'OFF' },
																									[Message.wMsgFAC_CLEARED_TO_DEPART] 				= { outSymbol = nil,
																																								newState = 'OFF' },
																									[Message.wMsgLeaderCheckOut]						= { outSymbol = nil,
																																								newState = 'OFF' }
																								}
																							}
																						}
																					),	
[events.START_IR_POINTER_DIALOG]								= DialogStartTrigger:new(self,	dialogsData.dialogs['IR-Pointer']),
[events.START_LASER_DIALOG]										= DialogStartTrigger:new(self,	dialogsData.dialogs['Laser'])
--]]