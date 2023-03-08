local openFormation = true

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

local function hasSecondElement()
	local pWingmen = data.pUnit:getGroup():getUnit(3)
	return pWingmen ~= nil
end

function specialEvent(params) 
	return staticParamsEvent(Message.wMsgLeaderSpecialCommand,params)
end

function refuelEvent(percent)
	return staticParamsEvent(Message.wMsgLeaderRequestRefueling,{fuel_mass = percent})
end

local menus = data.menus

menus['Engage'] = {
	name = _('Engage'),
	items = {
		[1] = {name = _('Engage Ground Targets'), 												command = sendMessage.new(Message.wMsgLeaderEngageGroundTargets, false, false)},
		[2] = {name = _('Engage Armor'), 														command = sendMessage.new(Message.wMsgLeaderEngageArmor, false, false)},
		[3] = {name = _('Engage Artillery'), 													command = sendMessage.new(Message.wMsgLeaderEngageArtillery, false, false)},
		[4] = {name = _('Engage Air Defenses'), 												command = sendMessage.new(Message.wMsgLeaderEngageAirDefenses, false, false)},
		[5] = {name = _('Engage Utility Vehicles'), 											command = sendMessage.new(Message.wMsgLeaderEngageUtilityVehicles, false, false)},
		[6] = {name = _('Engage Infantry'), 													command = sendMessage.new(Message.wMsgLeaderEngageInfantry, false, false)},
		[7] = {name = _('Engage Ships'), 														command = sendMessage.new(Message.wMsgLeaderEngageNavalTargets, false, false)},
		[8] = {name = _('Engage Bandits'), 														command = sendMessage.new(Message.wMsgLeaderEngageBandits, false, false)},
		[9] = {name = _('Primary and Rejoin'), 													command = sendMessage.new(Message.wMsgLeaderFulfilTheTaskAndJoinUp, false)},
		[10] = {name = _('Primary and RTB'), 													command = sendMessage.new(Message.wMsgLeaderFulfilTheTaskAndReturnToBase, false)},
	}
}
menus['Weapon'] = {
	name = _('Weapon'),
	items = {
		[2] = {name = _('Unguided Bomb'), 														command = sendMessage.new2(2, 2)},
		[4] = {name = _('Rocket'), 																command = sendMessage.new2(2, 4)},
		[6] = {name = _('Gun'), 																command = sendMessage.new2(2, 6)},
	}
}
menus['Engage with'] = {	
	name = _('Engage with'),
	items = {
		[1] = {name = _('Engage Ground Targets'), 	submenu = menus['Weapon'],					parameters = {Message.wMsgLeaderEngageGroundTargets, true, false}},
		[2] = {name = _('Engage Armor'), 			submenu = menus['Weapon'],					parameters = {Message.wMsgLeaderEngageArmor, true, false}},
		[3] = {name = _('Engage Artillery'), 		submenu = menus['Weapon'],					parameters = {Message.wMsgLeaderEngageArtillery, true, false}},
		[4] = {name = _('Engage Air Defenses'), 	submenu = menus['Weapon'],					parameters = {Message.wMsgLeaderEngageAirDefenses, true, false}},
		[5] = {name = _('Engage Utility Vehicles'),	submenu = menus['Weapon'],					parameters = {Message.wMsgLeaderEngageUtilityVehicles, true, false}},
		[6] = {name = _('Engage Infantry'), 		submenu = menus['Weapon'],					parameters = {Message.wMsgLeaderEngageInfantry, true, false}},
		[7] = {name = _('Engage Ships'), 			submenu = menus['Weapon'],					parameters = {Message.wMsgLeaderEngageNavalTargets, true, false}}
	}
}
menus['Maneuvers'] = {
	name = _('Maneuvers'),
	items = {
		[1] = {name = _('Break Right'), 				command = sendMessage.new(Message.wMsgLeaderBreakRight)},
		[2] = {name = _('Break Left'), 					command = sendMessage.new(Message.wMsgLeaderBreakLeft)},
		[3] = {name = _('Break High'), 					command = sendMessage.new(Message.wMsgLeaderBreakHigh)},
		[4] = {name = _('Break Low'), 					command = sendMessage.new(Message.wMsgLeaderBreakLow)},
		[7] = {name = _('Clear Right'), 				command = sendMessage.new(Message.wMsgLeaderClearRight)},
		[8] = {name = _('Clear Left'), 					command = sendMessage.new(Message.wMsgLeaderClearLeft)},
		[9] = {name = _('Pump'), 						command = sendMessage.new(Message.wMsgLeaderPump)}
	}
}
menus['Navigation'] = {
	name = _('Navigation'),
	items = {
		[1] = {name = _('Anchor Here'), 				command = sendMessage.new(Message.wMsgLeaderAnchorHere)},
		[2] = {name = _('Return to base'), 				command = sendMessage.new(Message.wMsgLeaderReturnToBase)},
	}
}
menus['Formation'] = {
	name = _('Formation'),
	items = {
		[1] = {name = _('Go Line Abreast'), 			command = sendMessage.new(Message.wMsgLeaderLineAbreast)},
		[2] = {name = _('Go Trail'), 					command = sendMessage.new(Message.wMsgLeaderGoTrail)},
		[3] = {name = _('Go Wedge'), 					command = sendMessage.new(Message.wMsgLeaderWedge)},
		[4] = {name = _('Go Echelon Right'), 			command = sendMessage.new(Message.wMsgLeaderEchelonRight)},
		[5] = {name = _('Go Echelon Left'), 			command = sendMessage.new(Message.wMsgLeaderEchelonLeft)},
		[6] = {name = _('Go Finger Four'), 				command = sendMessage.new(Message.wMsgLeaderFingerFour)},
		[7] = {name = _('Go Spread Four'), 				command = sendMessage.new(Message.wMsgLeaderSpreadFour)},
		[8] = {	name = _('Open formation'),
				command = {
					sendMessage = sendMessage.new(Message.wMsgLeaderOpenFormation),
					perform = function(self, parameters)
						self.sendMessage:perform(parameters)
						openFormation = true
					end
				},				
				condition = {
					check = function(self)
						return not openFormation
					end
				}
		},
		[9] = {	name = _('Close formation'),
				command = {
					sendMessage = sendMessage.new(Message.wMsgLeaderCloseFormation),
					perform = function(self, parameters)
						self.sendMessage:perform(parameters)
						openFormation = false
					end
				},
				condition = {
					check = function(self)
						return openFormation
					end
				}
		},
	}
}
menus['Wingman'] = {
	name = _('Wingman'),
	items = {
		[1] = {
			name = _('Navigation'),
			submenu = menus['Navigation']
		},
		[2] = {
			name = _('Engage'),
			submenu = menus['Engage'],
		},
		[3] = {
			name = _('Engage with'),
			submenu = menus['Engage with'],
		},
		[4] = {
			name = _('Maneuvers'),
			submenu = menus['Maneuvers']		
		},
		[5] = {
			name = _('Rejoin Formation'),
			command = sendMessage.new(Message.wMsgLeaderJoinUp)
		},
		[7] = {
			name = _('Cover Me'),
			command = sendMessage.new(Message.wMsgLeaderCoverMe)
		},
	}
}
menus['Flight'] = {
	name = _('Flight'),
	items = {
		[1] = {
			name = _('Navigation'),
			submenu = menus['Navigation']				
		},
		[2] = {
			name = _('Engage'),
			submenu = menus['Engage'],
		},
		[3] = {
			name = _('Engage with'),
			submenu = menus['Engage with'],
		},
		[4] = {
			name = _('Maneuvers'),
			submenu = menus['Maneuvers'],
		},
		[5] = {
			name = _('Formation'),
			submenu = menus['Formation'],
		},
		[6] = {
			name = _('Rejoin Formation'),
			command = sendMessage.new(Message.wMsgLeaderJoinUp)
		},
		[7] = {
			name = _('Cover Me'),
			command = sendMessage.new(Message.wMsgLeaderCoverMe)
		},
	}
}
menus['Second Element'] = {
	name = _('Second Element'),
	items = menus['Wingman'].items,
}

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
			data.pUnit:getGroup():getUnit(2) ~= nil then
			tbl.items[1] = {
				name = _('Wingman'),
				submenu = menus['Wingman'],		
				color = {
					get = function(self)
						local pWingmen = data.pUnit:getGroup():getUnit(2)
						return getRecepientColor(pWingmen and pWingmen:getCommunicator())
					end
				},
				command = {
					perform = function(self)
						local pWingmen = data.pUnit:getGroup():getUnit(2)
						selectAndTuneCommunicator(pWingmen and pWingmen:getCommunicator())
					end
				},
				parameter = 1,
			}
		end
		
		if 	not data.showingOnlyPresentRecepients or
			hasFlight() then
			tbl.items[2] = {
				name = _('Flight'),
				submenu = menus['Flight'],						
				color = {
					get = function(self)
						local pGroup = data.pUnit:getGroup()
						for i = 2, 4 do
							local pWingmen = pGroup:getUnit(i)
							if pWingmen then
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
	
		if 	not data.showingOnlyPresentRecepients or
			hasSecondElement() then
			tbl.items[3] = {
				name = _('Second Element'),
				submenu = menus['Second Element'],		
				color = {
					get = function(self)
						local pGroup = data.pUnit:getGroup()
						for i = 3, 4 do
							local pWingmen2 = pGroup:getUnit(i)
							if pWingmen2 then
								return getRecepientColor(pWingmen2:getCommunicator())
							end
						end
						return getRecepientColor(nil)
					end
				},
				command = {
					perform = function(self)
						local pGroup = data.pUnit:getGroup()
						for i = 3, 4 do
							local pWingmen2 = pGroup:getUnit(i)
							if pWingmen2 then
								selectAndTuneCommunicator(pWingmen2:getCommunicator())
							end
						end					
					end
				},	
				parameter = 4,
			}
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

utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/JTAC.lua', getfenv()))(4)
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/ATC.lua', getfenv()))(5, {[Airbase.Category.AIRDROME] = true})
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/AWACS.lua', getfenv()))(7, {tanker = false, radar = false})
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/Ground Crew.lua', getfenv()))(8)
--utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/ATC2.lua', getfenv()))(9, {[Airbase.Category.AIRDROME] = true})
