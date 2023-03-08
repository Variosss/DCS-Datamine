local mainMenuPos, parameters = ...

--Menu
local menus = data.menus



local function hasFlight()
	local pGroup = data.pUnit:getGroup()
	for i = 2, 4 do
		local pWingmen = pGroup:getUnit(i)
		if pWingmen ~= nil then
			return true
		end
	end
	return false
end





menus['Flight Check'] = {
	name = _('Flight Check'),
	items = {
		{
			name = _('Flight Check-in menu'),											command = sendMessage.new(Message.wMsgLeaderFlightCheckIn)
		}
	}
}

menus['ATC2'] = {
	name = _('ATC2'),
	items = {
		{	name = _('Flight Check-In'),
			submenu = menus['Flight Check'],
				color = {
					get = function(self)
						local pGroup = data.pUnit:getGroup()
						for i = 2, 4 do
							local pWingmen = pGroup:getUnit(i)
							if pWingmen ~= nil then
								return getRecepientColor(pWingmen and pWingmen:getCommunicator())
							end
						end
						return getRecepientColor(nil)
					end
				},
				command = {
					perform = function(self)
						local pGroup = data.pUnit:getGroup()
						for i = 2, 4 do
							local pWingmen = pGroup:getUnit(i)
							if pWingmen ~= nil then
								selectAndTuneCommunicator(pWingmen and pWingmen:getCommunicator())
								return
							end
						end					
					end
				},
				parameter = 5,	
		},
		{	name = _('Request startup'),							  		command = sendMessage.new(Message.wMsgLeaderRequestEnginesLaunch),
			condition = {
				check = function(self)
					return not data.pUnit:inAir()
				end
			}
		},			
		--[[
		{	name = _('Ground Control: Request taxi for takeoff'),				command = sendMessage.new(Message.wMsgLeaderRequestTaxiForTakeoff),
			condition = {
				check = function(self)
					return data.pUnit:inAir()
				end
			}
		},
		{
			name = _('Tower: Request takeoff'), 								command = sendMessage.new(Message.wMsgLeaderTowerRequestTakeOff),
				condition = {
					check = function(self)
						return data.pUnit:inAir()
				end
			}
		},
		--]]
		{
			name = _('Approach Control: Visual Overhead'), 						command = sendMessage.new(Message.wMsgLeaderApproachOverhead),
				condition = {
					check = function(self)
						return data.pUnit:inAir()
				end
			}
		},
		{
			name = _('Approach Control: Visual Straight-in'), 					command = sendMessage.new(Message.wMsgLeaderApproachStraight),
				condition = {
					check = function(self)
						return data.pUnit:inAir()
				end
			}
		},
		{
			name = _('Approach Control: Instrument Approach'), 					command = sendMessage.new(Message.wMsgLeaderApproachInstrument),
				condition = {
					check = function(self)
						return data.pUnit:inAir()
				end
			}
		},
		--[[
		{
			name = _('Tower: Report the initial for the break'), 					command = sendMessage.new(Message.wMsgLeaderGroundRepair),
				condition = {
					check = function(self)
						return data.pUnit:inAir()
				end
			}
		},
		--]]
		{
			name = _('Tower: Report inbound for the straight-in'), 					command = sendMessage.new(Message.wMsgLeaderInboundStraight),
				condition = {
					check = function(self)
						return data.pUnit:inAir()
				end
			}
		},
		--[[
		{
			name = _('Ground Control: Request Taxi to Parking'), 					command = sendMessage.new(Message.wMsgLeaderGroundRepair),
				condition = {
					check = function(self)
						return data.pUnit:inAir()
				end
			}
		}
		--]]
	}
}


local function getATCs2()
		
	local atcs = {}
	
	local neutralAirbases = coalition.getServiceProviders(coalition.side.NEUTRAL, coalition.service.ATC)
	for i, airbase in pairs(neutralAirbases) do
		table.insert(atcs, airbase)
	end	
	
	local selfCoalition = data.pUnit:getCoalition()
	local ourAirbases = coalition.getServiceProviders(selfCoalition, coalition.service.ATC)
	for i, airbase in pairs(ourAirbases) do
		table.insert(atcs, airbase)
	end
			
	local selfPoint = data.pUnit:getPosition().p
	local function distanceSorter(lu, ru)
			
		local lpoint = lu:getPoint()
		local ldist2 = (lpoint.x - selfPoint.x) * (lpoint.x - selfPoint.x) + (lpoint.z - selfPoint.z) * (lpoint.z - selfPoint.z)
		
		local rpoint = ru:getPoint()
		local rdist2 = (rpoint.x - selfPoint.x) * (rpoint.x - selfPoint.x) + (rpoint.z - selfPoint.z) * (rpoint.z - selfPoint.z)
		
		return ldist2 < rdist2
	end
		
	table.sort(atcs, distanceSorter)
	
	return atcs
end

local function buildATCs2(self, menu)
	local ATCs = getATCs2()
	if 	not data.showingOnlyPresentRecepients or getRecepientsState(ATCs) ~= RecepientState.VOID then
			menu.items[mainMenuPos] = buildRecepientsMenu(ATCs, _('ATC2'), { name = _('ATC2'), submenu = menus['ATC2'] })
	end
end

table.insert(data.rootItem.builders, buildATCs2)

--[[
data.rootItem = {
	name = _('ATC2'),
	getSubmenu = function(self)	
		local tbl = {
			name = _('ATC2'),
			items = {}
		}

		if 	not data.showingOnlyPresentRecepients or
			hasFlight() then
			tbl.items[1] = {
				name = _('Flight Check-In'),
				submenu = menus['Flight Check'],
				color = {
					get = function(self)
						local pGroup = data.pUnit:getGroup()
						for i = 2, 4 do
							local pWingmen = pGroup:getUnit(i)
							if pWingmen ~= nil then
								return getRecepientColor(pWingmen and pWingmen:getCommunicator())
							end
						end
						return getRecepientColor(nil)
					end
				},
				command = {
					perform = function(self)
						local pGroup = data.pUnit:getGroup()
						for i = 2, 4 do
							local pWingmen = pGroup:getUnit(i)
							if pWingmen ~= nil then
								selectAndTuneCommunicator(pWingmen and pWingmen:getCommunicator())
								return
							end
						end					
					end
				},
				parameter = 5,
			}
		end

		tbl.items[2] = {
			
		}

		return tbl
		,
		builders = {}
}
--]]

--Dialogs

--Departure Airdrome

dialogsData.dialogs['ATC2 Departure Airdrome'] = {
	name = _('ATC2 Departure Airdrome'),
	menus = {
		['Ready to taxi to runway'] = {								-- После запуска двигателей!!!
			name = _('Ready to taxi to runway'),
			items = {
				{	name = _('Flight Check-In'),
					submenu = menus['Flight Check'],
						color = {
							get = function(self)
								local pGroup = data.pUnit:getGroup()
								for i = 2, 4 do
									local pWingmen = pGroup:getUnit(i)
									if pWingmen ~= nil then
										return getRecepientColor(pWingmen and pWingmen:getCommunicator())
									end
								end
								return getRecepientColor(nil)
							end
						},
						command = {
							perform = function(self)
								local pGroup = data.pUnit:getGroup()
								for i = 2, 4 do
									local pWingmen = pGroup:getUnit(i)
									if pWingmen ~= nil then
										selectAndTuneCommunicator(pWingmen and pWingmen:getCommunicator())
										return
									end
								end					
							end
						},
						parameter = 5,	
				},
				{ name = _('Ground Control: Request taxi for takeoff'),	command = sendMessage.new(Message.wMsgLeaderRequestTaxiToRunway) },
				{ name = _('Request control hover'),					command = sendMessage.new(Message.wMsgLeaderRequestControlHover),  
					condition = {
						check = function(self)
							return data.pUnit:hasAttribute('Helicopters')
						end
					}
				},
				{ name = _('Abort takeoff'), 				command = sendMessage.new(Message.wMsgLeaderAbortTakeoff) }
			}
		},
		['Hover Check'] = {
			name = _('Hover Check'),
			items = {
				{ name = _('Request to taxi to runway'),	command = sendMessage.new(Message.wMsgLeaderRequestTaxiToRunway) },
				{ name = _('Abort takeoff'), 				command = sendMessage.new(Message.wMsgLeaderAbortTakeoff) }
			}
		},		
		['ATC2 Ready to takeoff'] = {
			name = _('ATC2 Ready to takeoff'),
			items = {
				{ name = _('Tower: Request takeoff'), 			command = sendMessage.new(Message.wMsgLeaderTowerRequestTakeOff) },
				{ name = _('ATC2 Abort takeoff'), 				command = sendMessage.new(Message.wMsgLeaderAbortTakeoff) }
			}
		},
		['ATC2 Taking Off'] = {
			name = _('ATC2 Taking Off'),
			items = {
				{ name = _('Flight Check-In'),
					submenu = menus['Flight Check'],
						color = {
							get = function(self)
								local pGroup = data.pUnit:getGroup()
								for i = 2, 4 do
									local pWingmen = pGroup:getUnit(i)
									if pWingmen ~= nil then
										return getRecepientColor(pWingmen and pWingmen:getCommunicator())
									end
								end
								return getRecepientColor(nil)
							end
						},
						command = {
							perform = function(self)
								local pGroup = data.pUnit:getGroup()
								for i = 2, 4 do
									local pWingmen = pGroup:getUnit(i)
									if pWingmen ~= nil then
										selectAndTuneCommunicator(pWingmen and pWingmen:getCommunicator())
										return
									end
								end					
							end
						},
					parameter = 5,	
				},
				{ name = _('ATC2 Abort takeoff'), 				command = sendMessage.new(Message.wMsgLeaderAbortTakeoff) }
			}
		}
	}
}
dialogsData.dialogs['ATC2 Departure Airdrome'].stages = {
	['Closed'] = {	
		[events.NOTIFY_BIRTH_ON_RAMP_HOT]					= { menu = dialogsData.dialogs['ATC2 Departure Airdrome'].menus['ATC2 Ready to takeoff'], newStage = 'ATC2 Ready to takeoff' },
		[events.DENY_TAKEOFF_FROM_AIRDROME] 				= { menu = dialogsData.dialogs['ATC2 Departure Airdrome'].menus['ATC2 Ready to takeoff'], newStage = 'ATC2 Ready to takeoff' },
		[events.NOTIFY_BIRTH_ON_RUNWAY]						= { menu = dialogsData.dialogs['ATC2 Departure Airdrome'].menus['ATC2 Taking Off'], newStage = 'ATC2 Taking Off' },
		[events.CLEAR_TO_TAKEOFF_FROM_AIRDROME]				= { menu = dialogsData.dialogs['ATC2 Departure Airdrome'].menus['ATC2 Taking Off'], newStage = 'ATC2 Taking Off' },
		[events.STARTUP_PERMISSION_FROM_AIRDROME] 			= { menu = dialogsData.dialogs['ATC2 Departure Airdrome'].menus['Ready to taxi to runway'], newStage = 'Ready to taxi to runway' },
		[Message.wMsgATCClearedToTaxiRunWay] 				= { menu = dialogsData.dialogs['ATC2 Departure Airdrome'].menus['ATC2 Ready to takeoff'], newStage = 'ATC2 Ready to takeoff' },
		[events.TAKEOFF] 									= TERMINATE(),
		[events.LANDING]									= { menu = dialogsData.dialogs['ATC2 Departure Airdrome'].menus['ATC2 Ready to takeoff'], newStage = 'ATC2 Ready to takeoff' }
	},
	['Hover Check'] = {
		[Message.wMsgATCClearedToTaxiRunWay] 			= { menu = dialogsData.dialogs['ATC2 Departure Airdrome'].menus['ATC2 Ready to takeoff'], newStage = 'ATC2 Ready to takeoff' },
		[Message.wMsgATCYouHadTakenOffWithNoPermission]	= TERMINATE(),
		[Message.wMsgATCTaxiToParkingArea]				= TERMINATE(),
		[events.ENGINE_SHUTDOWN]						= TERMINATE()
	},	
	['Ready to taxi to runway'] = {
		[Message.wMsgATCClearedToTaxiRunWay] 			= { menu = dialogsData.dialogs['ATC2 Departure Airdrome'].menus['ATC2 Ready to takeoff'], newStage = 'ATC2 Ready to takeoff' },
		[Message.wMsgATCClearedControlHover]			= { menu = dialogsData.dialogs['ATC2 Departure Airdrome'].menus['Hover Check'], newStage = 'Hover Check' },
		[events.TAKEOFF] 								= TERMINATE(),
		[Message.wMsgATCTaxiToParkingArea]				= TERMINATE(),
		[events.ENGINE_SHUTDOWN]						= TERMINATE()
	},
	['ATC2 Ready to takeoff'] = {
		[Message.wMsgATCYouAreClearedForTO]				= { menu = dialogsData.dialogs['ATC2 Departure Airdrome'].menus['ATC2 Taking Off'], newStage = 'ATC2 Taking Off' },
		[events.TAKEOFF] 								= TERMINATE(),
		[Message.wMsgATCTaxiToParkingArea]				= TERMINATE(),
		[events.ENGINE_SHUTDOWN]						= TERMINATE()
	},
	['ATC2 Taking Off'] = {
		[Message.wMsgATCClearedToTaxiRunWay] 			= { menu = dialogsData.dialogs['ATC2 Departure Airdrome'].menus['ATC2 Ready to takeoff'], newStage = 'ATC2 Ready to takeoff' },
		[events.TAKEOFF] 								= TERMINATE(),
		[Message.wMsgATCTaxiToParkingArea]				= TERMINATE(),
		[events.ENGINE_SHUTDOWN]						= TERMINATE()
	}
}


--Arrival

dialogsData.dialogs['Approach'] = {}
dialogsData.dialogs['Approach'].name = _('Approach')
dialogsData.dialogs['Approach'].menus = {}
dialogsData.dialogs['Approach'].menus['Inbound'] = {
	name = _('Inbound'),
	items = {
		{ name = _('Abort Inbound'), 						command = sendMessage.new(Message.wMsgLeaderAbortInbound) },
		{ name = _('I\'m lost'), 							command = sendMessage.new(Message.wMsgLeaderRequestAzimuth)},		
	}
}
dialogsData.dialogs['Approach'].menus['Orbit'] = {
	name = _('Orbit'),
	items = {
		{ name = _('Abort Inbound'), 						command = sendMessage.new(Message.wMsgLeaderAbortInbound) },
		{ name = _('I\'m lost'), 							command = sendMessage.new(Message.wMsgLeaderRequestAzimuth)}
	}
}
dialogsData.dialogs['Approach'].menus['Ready to land'] = {				--!!!! after Inbound
	name = _('Ready to land'),
	items = {
		{ name = _('Tower: Report Abeam'), 						command = sendMessage.new(Message.wMsgLeaderRequestLanding) },
		{ name = _('Abort Inbound'), 						command = sendMessage.new(Message.wMsgLeaderAbortInbound) },
		{ name = _('I\'m lost'), 							command = sendMessage.new(Message.wMsgLeaderRequestAzimuth)}
	}
}
dialogsData.dialogs['Approach'].menus['Landing'] = {
	name = _('Landing'),
	items = {
		{ name = _('Abort Inbound'), 						command = sendMessage.new(Message.wMsgLeaderAbortInbound) }		
	}
}
dialogsData.dialogs['Approach'].menus['Parking'] = {
	name = _('Parking'),
	items = {
		{ name = _('Ground Control: Request Taxi to Park'), 			command = sendMessage.new(Message.wMsgLeaderRequestTaxiToParking) },
	}
}

dialogsData.dialogs['Approach'].stages = {
	['Closed'] = {
		[Message.wMsgATCFlyHeading] 					= TO_STAGE('Approach', 'Inbound'),
		[Message.wMsgATCGoAround]						= TO_STAGE('Approach', 'Ready to land'),
		[events.LANDING]								= TO_STAGE('Approach', 'Parking'),
		[Message.wMsgATCTaxiToParkingArea]				= TO_STAGE('Approach', 'Parking'),
		[Message.wMsgLeaderAbortInbound]				= TERMINATE()
	},
	['Inbound'] = {
		[Message.wMsgATCOrbitForSpacing] 				= TO_STAGE('Approach', 'Orbit'),
		[Message.wMsgATCClearedForVisual] 				= TO_STAGE('Approach', 'Ready to land'),
		[events.LANDING]								= TO_STAGE('Approach', 'Parking'),
		[Message.wMsgLeaderAbortInbound]				= TERMINATE()		
	},
	['Orbit'] = {
		[Message.wMsgATCClearedForVisual] 				= TO_STAGE('Approach', 'Ready to land'),
		[events.LANDING]								= TO_STAGE('Approach', 'Parking'),
		[Message.wMsgLeaderAbortInbound]				= TERMINATE(),
	},
	['Ready to land'] = {
		[Message.wMsgATCYouAreClearedForLanding] 		= TO_STAGE('Approach', 'Landing'),
		[Message.wMsgATCCheckLandingGear]				= TO_STAGE('Approach', 'Landing'),
		[Message.wMsgATCOrbitForSpacing] 				= TO_STAGE('Approach', 'Orbit'),
		[events.LANDING]								= TO_STAGE('Approach', 'Parking'),
		[Message.wMsgLeaderAbortInbound]				= TERMINATE(),
		[Message.wMsgATCGoSecondary]					= TERMINATE(),
	},
	['Landing'] = {
		[Message.wMsgATCGoAround]						= TO_STAGE('Approach', 'Ready to land'),
		[events.LANDING]								= TO_STAGE('Approach', 'Parking'),
		[Message.wMsgLeaderAbortInbound]				= TERMINATE(),
		[Message.wMsgATCGoSecondary]					= TERMINATE(),
	},
	['Parking'] = {
		[events.ENGINE_SHUTDOWN]						= TERMINATE(),
		[Message.wMsgATCTaxiDenied]						= TERMINATE(),
		[Message.wMsgATCClearedToTaxiRunWay]			= TERMINATE(),
		[Message.wMsgATCYouAreClearedForTO]				= TERMINATE(),
		[Message.wMsgATCTakeoffDenied]					= TERMINATE(),
		[events.TAKEOFF] 								= TERMINATE(),
	}
}

--Dialog arrival Triggers

local arrivalDialogTrigger = DialogStartTrigger:new(dialogsData.dialogs['Approach'])
dialogsData.triggers[Message.wMsgATCFlyHeading] 				= arrivalDialogTrigger
dialogsData.triggers[Message.wMsgATCGoAround] 					= arrivalDialogTrigger
dialogsData.triggers[Message.wMsgATCTaxiToParkingArea]			= arrivalDialogTrigger

--Dialog Triggers

local departureAirdromeDialogTrigger = DialogStartTrigger:new(dialogsData.dialogs['ATC2 Departure Airdrome'])
dialogsData.triggers[events.NOTIFY_BIRTH_ON_RAMP_HOT]				= departureAirdromeDialogTrigger
dialogsData.triggers[events.NOTIFY_BIRTH_ON_RUNWAY]					= departureAirdromeDialogTrigger
dialogsData.triggers[events.STARTUP_PERMISSION_FROM_AIRDROME]		= departureAirdromeDialogTrigger
dialogsData.triggers[Message.wMsgATCClearedToTaxiRunWay]			= departureAirdromeDialogTrigger
dialogsData.triggers[events.DENY_TAKEOFF_FROM_AIRDROME]				= departureAirdromeDialogTrigger
dialogsData.triggers[events.CLEAR_TO_TAKEOFF_FROM_AIRDROME]			= departureAirdromeDialogTrigger

	
	--Event Handler

local enginesAreStarted = false

local worldEventHandler = {
	onEvent = function(self, event)
		--print('data.pUnit = '..tostring(data.pUnit and data.pUnit))
		--print('event.id = '..tostring(event.id))
		--print('event.initiator = '..tostring(event.initiator))
		if event.initiator == data.pUnit then
			local airbaseCommunicator= nil
			if event.place ~= nil and event.place:isExist() then
				airbaseCommunicator = event.place:getCommunicator()
			end
			if event.id == world.event.S_EVENT_BIRTH then
				if event.place ~= nil then
					--print('event.subPlace = '..tostring(event.subPlace))
					if event.subPlace == world.BirthPlace.wsBirthPlace_Park then
						return events.NOTIFY_BIRTH_ON_RAMP_COLD, airbaseCommunicator
					elseif event.subPlace == world.BirthPlace.wsBirthPlace_Park_Hot then
						enginesAreStarted = true
						return events.NOTIFY_BIRTH_ON_RAMP_HOT, airbaseCommunicator
					elseif event.subPlace == world.BirthPlace.wsBirthPlace_RunWay then
						enginesAreStarted = true
						return events.NOTIFY_BIRTH_ON_RUNWAY, airbaseCommunicator
					end
				end
			elseif event.id == world.event.S_EVENT_TAKEOFF then
				return events.TAKEOFF, airbaseCommunicator
			elseif event.id == world.event.S_EVENT_LAND then
				return events.LANDING, airbaseCommunicator
			elseif event.id == world.event.S_EVENT_ENGINE_STARTUP then
				enginesAreStarted = true
				return events.ENGINE_STARTUP, airbaseCommunicator
			elseif event.id == world.event.S_EVENT_ENGINE_SHUTDOWN then
				enginesAreStarted = false
				return events.ENGINE_SHUTDOWN, airbaseCommunicator
			end
		end
	end
}

table.insert(data.worldEventHandlers, worldEventHandler)

--Message Handler

local msgHandler = {
	onMsg = function(self, pMessage, pRecepient)
		self:onMsgEvent(pMessage:getEvent(), pMessage:getSender(), pRecepient)
	end,
	onMsgEvent = function(self, event, pMsgSender, pRecepient)
		local pUnit = pMsgSender:getUnit()
		local nUnitCategory = pUnit:getCategory()
		if nUnitCategory == Object.Category.BASE or nUnitCategory == Object.Category.UNIT then
			local airbaseCategory = pUnit:getDesc().category
			if event == Message.wMsgATCClearedForEngineStartUp then
				if airbaseCategory == Airbase.Category.AIRDROME then
					return events.STARTUP_PERMISSION_FROM_AIRDROME
				end
			elseif event == Message.wMsgATCTakeoffDenied then
				local typeName = pMsgSender:getUnit():getTypeName()
				if airbaseCategory == Airbase.Category.AIRDROME then
					return events.DENY_TAKEOFF_FROM_AIRDROME
				end
			elseif event == Message.wMsgATCYouAreClearedForTO then
				local typeName = pMsgSender:getUnit():getTypeName()
				if airbaseCategory == Airbase.Category.AIRDROME then
					return events.CLEAR_TO_TAKEOFF_FROM_AIRDROME
				end
			end
		end
	end	
}

table.insert(data.msgHandlers, msgHandler)
