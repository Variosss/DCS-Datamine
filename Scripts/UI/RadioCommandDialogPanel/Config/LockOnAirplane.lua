local parameters = ...

local Formation = {
	LINE_ABREAST = 1,
	TRAIL = 2,
	WEDGE = 3,
	ECHELON_RIGHT = 4,
	FINGER_FOUR   = 5,
	SPREAD_FOUR   = 6
}

local formation = Formation.ECHELON_RIGHT

local openFormation = 2

local menus = data.menus

function refuelEvent(percent)
	return staticParamsEvent(Message.wMsgLeaderRequestRefueling,{fuel_mass = percent})
end

menus['Engage'] = {
	name = _('Engage'),
	items = {
		{name = _('My Target'), 						command = sendMessage.new(Message.wMsgLeaderEngageMyTarget, false)},
		{name = _('My Enemy'), 							command = sendMessage.new(Message.wMsgLeaderMyEnemyAttack, false)},
		{name = _('Bandits'), 							command = sendMessage.new(Message.wMsgLeaderEngageBandits, false)},
		{name = _('Air Defences'), 						command = sendMessage.new(Message.wMsgLeaderEngageAirDefenses, false)},
		{name = _('Ground Targets'), 					command = sendMessage.new(Message.wMsgLeaderEngageGroundTargets, false)},
		{name = _('Engage Ships'), 						command = sendMessage.new(Message.wMsgLeaderEngageNavalTargets, false, false)},
		{name = _('Primary and Rejoin'), 				command = sendMessage.new(Message.wMsgLeaderFulfilTheTaskAndJoinUp, false)},
		{name = _('Primary and RTB'), 					command = sendMessage.new(Message.wMsgLeaderFulfilTheTaskAndReturnToBase, false)},
	}
}
if parameters.fighter then
	menus['Go Pincher'] = {
		name = _('Go Pincher'),
		items = {
			{ name = _('Heigh'), 							command = sendMessage.new(Message.wMsgLeaderPincerHigh) },
			{ name = _('Low'), 								command = sendMessage.new(Message.wMsgLeaderPincerLow) },
			{ name = _('Right'), 							command = sendMessage.new(Message.wMsgLeaderPincerRight) },
			{ name = _('Left'), 							command = sendMessage.new(Message.wMsgLeaderPincerLeft) }
		}
	}
end
menus['Go To'] = {
	name = _('Go To'),
	items = {
		{ name = _('Return to Base'), 					command = sendMessage.new(Message.wMsgLeaderReturnToBase) },
		{ name = _('Route'), 							command = sendMessage.new(Message.wMsgLeaderFlyRoute) },
		{ name = _('Hold Position'), 					command = sendMessage.new(Message.wMsgLeaderAnchorHere) },
		parameters.refueling and
			{ name = _('Fly to Tanker'), 					command = sendMessage.new(Message.wMsgLeaderGoRefueling) }
		or
			nil
	}
}
if parameters.radar then
	menus['Radar'] = {
		name = _('Radar'),
		items = {
			{ name = _('On'), 								command = sendMessage.new(Message.wMsgLeaderRadarOn) },
			{ name = _('Off'), 								command = sendMessage.new(Message.wMsgLeaderRadarOff) },
		}
	}
end
if parameters.ECM then
	menus['ECM'] = {
		name = _('ECM'),
		items = {
			{ name = _('On'), 								command = sendMessage.new(Message.wMsgLeaderDisturberOn) },
			{ name = _('Off'), 								command = sendMessage.new(Message.wMsgLeaderDisturberOff) },
		}
	}
end
menus['Smoke'] = {
	name = _('Smoke'),
	items = {
		{ name = _('On'), 								command = sendMessage.new(Message.wMsgLeaderSmokeOn) },
		{ name = _('Off'), 								command = sendMessage.new(Message.wMsgLeaderSmokeOff) },
	}
}
menus['Go Formation'] = {
	name = _('Go Formation'),
	items = {
		{
			name = _('Rejoin Formation'),
			command = sendMessage.new(Message.wMsgLeaderJoinUp)
		},	
		{
			name = _('Go Line Abreast'),
			command = {
				sendMessage = sendMessage.new(Message.wMsgLeaderLineAbreast),
				perform = function(self, parameters)
					self.sendMessage:perform(parameters)
					formation = Formation.LINE_ABREAST
				end
			},
			condition = {
				check = function(self)
					return formation ~= Formation.LINE_ABREAST
				end
			}
		},
		{
			name = _('Go Trail'),
			command = {
				sendMessage = sendMessage.new(Message.wMsgLeaderGoTrail),
				perform = function(self, parameters)
					self.sendMessage:perform(parameters)
					formation = Formation.TRAIL
				end
			},
			condition = {
				check = function(self)
					return formation ~= Formation.TRAIL
				end
			}
		},
		{
			name = _('Go Wedge'),
			command = {
				sendMessage = sendMessage.new(Message.wMsgLeaderWedge),
				perform = function(self, parameters)
					self.sendMessage:perform(parameters)
					formation = Formation.WEDGE
				end
			},
			condition = {
				check = function(self)
					return formation ~= Formation.WEDGE
				end
			}
		},
		{
			name = _('Go Echelon Right'),
			command = {
				sendMessage = sendMessage.new(Message.wMsgLeaderEchelonRight),
				perform = function(self, parameters)
					self.sendMessage:perform(parameters)
					formation = Formation.ECHELON_RIGHT
				end
			},
			condition = {
				check = function(self)
					return formation ~= Formation.ECHELON_RIGHT
				end
			}
		},
		{
			name = _('Go Finger Four'),
			command = {
				sendMessage = sendMessage.new(Message.wMsgLeaderFingerFour),
				perform = function(self, parameters)
					self.sendMessage:perform(parameters)
					formation = Formation.FINGER_FOUR
				end
			},
			condition = {
				check = function(self)
					return formation ~= Formation.FINGER_FOUR
				end
			}
		},
		{
			name = _('Go Spread Four'),
			command = {
				sendMessage = sendMessage.new(Message.wMsgLeaderSpreadFour),
				perform = function(self, parameters)
					self.sendMessage:perform(parameters)
					formation = Formation.SPREAD_FOUR
				end
			},
			condition = {
				check = function(self)
					return formation ~= Formation.SPREAD_FOUR
				end
			}
		},
		{
			name = _('Close formation'),
			command = {
				sendMessage = sendMessage.new(Message.wMsgLeaderCloseFormation),
				perform = function(self, parameters)
					self.sendMessage:perform(parameters)
					openFormation = 1
				end
			},
			condition = {
				check = function(self)
					return openFormation ~= 1
				end
			}
		},
		{
			name = _('Open formation'),
			command = {
				sendMessage = sendMessage.new(Message.wMsgLeaderOpenFormation),
				perform = function(self, parameters)
					self.sendMessage:perform(parameters)
					openFormation = 2
				end
			},				
			condition = {
				check = function(self)
					return openFormation ~= 2
				end
			}
		},
		{
			name = _('Close Group formation'),
			command = {
				sendMessage = sendMessage.new(Message.wMsgLeaderCloseGroupFormation),
				perform = function(self, parameters)
					self.sendMessage:perform(parameters)
					openFormation = 3
				end
			},				
			condition = {
				check = function(self)
					return openFormation ~= 3
				end
			}
		},
	}
}

menus['Flight'] = {
	name = _('Flight'),
	items = {
		[1] = {
			name = _('Engage'),
			submenu = menus['Engage']
		},
		[2] = parameters.fighter
			and
		{
			name = _('Go Pincher'),
			submenu = menus['Go Pincher'],
		}
			or
		nil,
		[3] = {
			name = _('Go To'),
			submenu = menus['Go To'],
		},
		[4] = parameters.radar
			and
		{
			name = _('Radar'),
			submenu = menus['Radar'],
		}
			or
		nil,
		[5] = parameters.ECM
			and
		{
			name = _('ECM'),
			submenu = menus['ECM'],
		}
			or
		nil,
		[6] = {
			name = _('Smoke'),
			submenu = menus['Smoke'],
		},
		[7] = {
			name = _('Cover Me'),
			command = sendMessage.new(Message.wMsgLeaderCoverMe)
		},
		[8] = {
			name = _('Jettison Weapons'),
			command = sendMessage.new(Message.wMsgLeaderJettisonWeapons)
		},			
		[9] = {
			name = _('Go Formation'),
			submenu = menus['Go Formation']
		},
		[10] = {
			name = _('Flight Check-In'),
			command = sendMessage.new(Message.wMsgLeaderFlightCheckIn)
		}
	}
}
local wingmenMenuItems = {
	[1] = {
		name = _('Engage'),
		submenu = menus['Engage']
	},
	[2] = parameters.fighter
		and
	{
		name = _('Go Pincher'),
		submenu = menus['Go Pincher'],
	}
		or
	nil,
	[3] = {
		name = _('Go To'),
		submenu = menus['Go To'],
	},
	[4] = parameters.radar
		and
	{
		name = _('Radar'),
		submenu = menus['Radar'],
	}
		or
	nil,
	[5] = parameters.ECM
		and
	{
		name = _('ECM'),
		submenu = menus['ECM'],
	}
		or
	nil,
	[6] = {
		name = _('Smoke'),
		submenu = menus['Smoke'],
	},
	[7] = {
		name = _('Cover Me'),
		command = sendMessage.new(Message.wMsgLeaderCoverMe)
	},
	[8] = {
		name = _('Jettison Weapons'),
		command = sendMessage.new(Message.wMsgLeaderJettisonWeapons)
	},
	[9] = {
		name = _('Rejoin Formation'),
		command = sendMessage.new(Message.wMsgLeaderJoinUp)
	}
}

local function makeWingmenMenu(number)
	return {
		name = _('Wingman ')..number,
		submenu = {
			name = _('Wingman ')..number,
			items = wingmenMenuItems
		},
		condition = {
			check = function(self)
				if not data.showingOnlyPresentRecepients then
					return true
				end
				local pWingmen = data.pUnit:getGroup():getUnit(number)
				return pWingmen ~= nil
			end
		},			
		color = {
			get = function(self)
				local pWingmen = data.pUnit:getGroup():getUnit(number)
				return getRecepientColor(pWingmen and pWingmen:getCommunicator())
			end
		},
		command = {
			perform = function(self)
				local pWingmen = data.pUnit:getGroup():getUnit(number)
				selectAndTuneCommunicator(pWingmen and pWingmen:getCommunicator())
			end
		},
		parameter = number - 1,
	}
end

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




data.rootItem = {
	
	name = _('Main'),
	getSubmenu = function(self)	
		local tbl = {
			name = _('Main'),
			items = {}
		}
		
		if data.pUnit == nil or data.pUnit:isExist() == false then
			return tbl
		end		
		
		
		if 	not data.showingOnlyPresentRecepients or
			hasFlight() then
			tbl.items[1] = {
				name = _('Flight'),
				submenu = menus['Flight'],						
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
		
		for	number = 2, 4 do
			if 	not data.showingOnlyPresentRecepients or
				data.pUnit:getGroup():getUnit(number) ~= nil then
				tbl.items[number] = makeWingmenMenu(number)
			end
		end
			
		if self.builders ~= nil then
			for index, builder in pairs(self.builders) do
				builder(self, tbl)
			end
		end
		
		if #data.menuOther.submenu.items > 0 then
			tbl.items[10] = {
				name = _('Other'),
				submenu = data.menuOther.submenu
			}
		end
		
		if #data.menuEmbarkToTransport.submenu.items > 0 then
			tbl.items[6] = {
				name = _('Descent'),
				submenu = data.menuEmbarkToTransport.submenu,
				condition = data.menuEmbarkToTransport.condition
			}
		end
		
		return tbl
	end,
	builders = {}
}

local airbaseTypes = {
	[Airbase.Category.AIRDROME] = true
}

if parameters.naval then
	airbaseTypes[Airbase.Category.SHIP] = true
end

utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/ATC.lua', getfenv()))(5, airbaseTypes)
if parameters.refueling then
	utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/Tanker.lua', getfenv()))(6)
end
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/AWACS.lua', getfenv()))(7, {tanker = parameters.refueling, radar = parameters.radar})
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/Ground Crew.lua', getfenv()))(8)
--utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/ATC2.lua', getfenv()))(9, airbaseTypes)
