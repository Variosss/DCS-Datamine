assert(db.Formations ~= nil)

local formation = db.FormationID.HEL_WEDGE
local overwatch = false
assert(formation ~= nil)

function specialEvent(params) 
	return staticParamsEvent(Message.wMsgLeaderSpecialCommand,params)
end

function refuelEvent(percent)
	return staticParamsEvent(Message.wMsgLeaderRequestRefueling,{fuel_mass = percent})
end


local FormationDirection = {
	RIGHT = 1,
	LEFT = 2
}

local formationDirection = FormationDirection.RIGHT

local FormationVariant = {
	TIGHT = 1,
	CRUISE = 2,
	COMBAT = 3
}

local availableVariant = {
	[db.FormationID.HEL_ECHELON] = {
		[FormationVariant.TIGHT] = 1,
		[FormationVariant.CRUISE] = 2,
		[FormationVariant.COMBAT] = 3
	},
	[db.FormationID.HEL_FRONT] = {
		[FormationVariant.CRUISE] = 1,
		[FormationVariant.COMBAT] = 2
	}
}

local formationVariant = {
	[db.FormationID.HEL_ECHELON] = FormationVariant.CRUISE,
	[db.FormationID.HEL_FRONT] = FormationVariant.CRUISE
}

local menus = data.menus

--[[
	Pincer High
	Pincer Low
	Pincer Right
	Pincer Left
 
Radar On
Radar Off
 
ECM On
ECM Off
 
	Primary and Rejoin
	Primary and RTB
 
Check in
]]

--/N/ check these first:

menus['Radar'] = {
	name = _('Radar'),
	items = {
		{ name = _('On'), 								command = sendMessage.new(Message.wMsgLeaderRadarOn)},
		{ name = _('Off'), 								command = sendMessage.new(Message.wMsgLeaderRadarOff)},
	}
}


menus['ECM'] = {
	name = _('ECM'),
	items = {
		{ name = _('On'), 								command = sendMessage.new(Message.wMsgLeaderDisturberOn)},
		{ name = _('Off'), 								command = sendMessage.new(Message.wMsgLeaderDisturberOff)},
	}
}

-------------------------


menus['Assist me'] = {
	name = _('Assist me'),
	items = {
		{name = _('Cover Me'), 							command = sendMessage.new(Message.wMsgLeaderCoverMe)},
		{name = _('Engage My Target'), 					command = sendMessage.new(Message.wMsgLeaderEngageMyTarget)},
		{name = _('Engage My Enemy'), 					command = sendMessage.new(Message.wMsgLeaderMyEnemyAttack)},
	}
}

menus['Engage Bandits'] = {
	name = _('Engage Bandits'),
	items = {
		{name = _('Engage Offensive'), 					command = sendMessage.new(Message.wMsgLeaderEngageBandits, false, false)},
		{ name = _('Pincer Right'), 					command = sendMessage.new(Message.wMsgLeaderPincerRight)},
		{ name = _('Pincer Left'), 						command = sendMessage.new(Message.wMsgLeaderPincerLeft)},
		{ name = _('Pincer Heigh'), 					command = sendMessage.new(Message.wMsgLeaderPincerHigh)},
		{ name = _('Pincer Low'), 						command = sendMessage.new(Message.wMsgLeaderPincerLow)},
	}
}

menus['Engage Ground targets'] = {
	name = _('Engage Ground targets'),
	items = {
		{name = _('Ground Targets'), 					command = sendMessage.new(Message.wMsgLeaderEngageGroundTargets, false, false)},
		{name = _('Air Defences'), 						command = sendMessage.new(Message.wMsgLeaderEngageAirDefenses, false, false)},
		--/N/ old mig
		{name = _('Armor'), 							command = sendMessage.new(Message.wMsgLeaderEngageArmor, false, false)},
		{name = _('Artillery'), 						command = sendMessage.new(Message.wMsgLeaderEngageArtillery, false, false)},
		{name = _('Utility Vehicles'), 					command = sendMessage.new(Message.wMsgLeaderEngageUtilityVehicles, false, false)},
		{name = _('Infantry'), 							command = sendMessage.new(Message.wMsgLeaderEngageInfantry, false, false)},
		{name = _('Ships'), 							command = sendMessage.new(Message.wMsgLeaderEngageNavalTargets, false, false)},
	}
}

menus['Execute'] = {
	name = _('Execute'),
	items = {
		--/N/ test
		--[[
		{name = _('Check in'), 							command = sendMessage.new(Message.wMsgLeaderCheckIn)},
		{name = _('Radar ON'), 							command = sendMessage.new(Message.wMsgLeaderRadarOn)},
		{name = _('Radar OFF'), 						command = sendMessage.new(Message.wMsgLeaderRadarOff)},
		{name = _('ECM ON'), 							command = sendMessage.new(Message.wMsgLeaderECMOn)},
		{name = _('ECM OFF'), 							command = sendMessage.new(Message.wMsgLeaderECMOff)},
		]]
	
		{name = _('Radar'), 							submenu = menus['Radar']},
		{name = _('ECM'),								submenu = menus['ECM']},
		
		{name = _('Jettison Weapons'), 					command = sendMessage.new(Message.wMsgLeaderJettisonWeapons)},
		{name = _('Mission and Rejoin'), 				command = sendMessage.new(Message.wMsgLeaderFulfilTheTaskAndJoinUp)},
		{name = _('Mission and RTB'), 					command = sendMessage.new(Message.wMsgLeaderFulfilTheTaskAndReturnToBase)},

	}
}


menus['Navigation'] = {
	name = _('Navigation'),
	items = {
		{ name = _('Follow Route'), 					command = sendMessage.new(Message.wMsgLeaderFlyRoute)},
		{ name = _('Hold Position'),					command = sendMessage.new(Message.wMsgLeaderAnchorHere)},
		{ name = _('Rejoin Formation'),					command = sendMessage.new(Message.wMsgLeaderJoinUp)},
		{ name = _('Return to Base'), 					command = sendMessage.new(Message.wMsgLeaderReturnToBase)},
	}
}



menus['Reconnaissance'] = {
	name = _('Reconnaissance'),
	items = {
		--{ name = _('1 km'), 							command = sendMessage.new(Message.wMsgLeaderMakeRecon, 1000)},
		--{ name = _('2 km'), 							command = sendMessage.new(Message.wMsgLeaderMakeRecon, 2000)},
		--{ name = _('3 km'), 							command = sendMessage.new(Message.wMsgLeaderMakeRecon, 3000)},
		{ name = _('5 km'), 							command = sendMessage.new(Message.wMsgLeaderMakeRecon, 5000)},
		--{ name = _('8 km'), 							command = sendMessage.new(Message.wMsgLeaderMakeRecon, 8000)},
		{ name = _('10 km'), 							command = sendMessage.new(Message.wMsgLeaderMakeRecon, 10000)},
		{ name = _('15 km'), 							command = sendMessage.new(Message.wMsgLeaderMakeRecon, 15000)},
	}
}

local function getFormationSubmenu(self)
	local tbl = {
		name = _('Formation'),
		items = {
			[1] = {name = _('Go Line Abreast'), 			command = sendMessage.new(Message.wMsgLeaderLineAbreast)},
			[2] = {name = _('Go Trail'), 					command = sendMessage.new(Message.wMsgLeaderGoTrail)},
			[3] = {name = _('Go Wedge'), 					command = sendMessage.new(Message.wMsgLeaderWedge)},
			[4] = {name = _('Go Echelon Right'), 			command = sendMessage.new(Message.wMsgLeaderEchelonRight)},
			[5] = {name = _('Go Echelon Left'), 			command = sendMessage.new(Message.wMsgLeaderEchelonLeft)},
			[6] = {name = _('Go Finger Four'), 				command = sendMessage.new(Message.wMsgLeaderFingerFour)},
			[7] = {name = _('Go Spread Four'), 				command = sendMessage.new(Message.wMsgLeaderSpreadFour)},
		}
	}
	if not openFormation then
		tbl.items[8] = {
			name = _('Open formation'),
			command = {
				sendMessage = sendMessage.new(Message.wMsgLeaderOpenFormation),
				perform = function(self, parameters)
					self.sendMessage:perform(parameters)
					openFormation = true
				end
			}
		}
	else
		tbl.items[9] = {
			name = _('Close formation'),
			command = {
				sendMessage = sendMessage.new(Message.wMsgLeaderCloseFormation),
				perform = function(self, parameters)
					self.sendMessage:perform(parameters)
					openFormation = false
				end
			}
		}
	end
	return tbl
end


menus['Flight'] = {
	name = _('Flight'),
	items = {
		[1] = {
			name = _('Assist me'),
			submenu = menus['Assist me']
		},
		[2] = {
			name = _('Engage Bandits'),
			submenu = menus['Engage Bandits']
		},
		[3] = {
			name = _('Engage Ground targets'),
			submenu = menus['Engage Ground targets']
		},		
		[4] = {
			name = _('Execute'),
			submenu = menus['Execute']
		},		
		[5] = {
			name = _('Formation'),
			getSubmenu = getFormationSubmenu,
		},
		[6] = {
			name = _('Navigation'),
			submenu = menus['Navigation'],
		},
	}
}
local wingmenMenuItems = {
		[1] = {
			name = _('Assist me'),
			submenu = menus['Assist me']
		},
		[2] = {
			name = _('Engage Bandits'),
			submenu = menus['Engage Bandits']
		},
		[3] = {
			name = _('Engage Ground targets'),
			submenu = menus['Engage Ground targets']
		},		
		[4] = {
			name = _('Execute'),
			submenu = menus['Execute']
		},		
		[5] = {
			name = _('Formation'),
			getSubmenu = getFormationSubmenu,
		},
		[6] = {
			name = _('Navigation'),
			submenu = menus['Navigation'],
		},
		[7] = {
			name = _('Reconnaissance'),
			submenu = menus['Reconnaissance'],
		},
}

local function makeWingmenMenu(number)
	return {
		name = _('Wingman ')..(number + 1),
		submenu = {
			name = _('Wingman ')..(number + 1),
			items = wingmenMenuItems
		},
		condition = {
			check = function(self)
				if not data.showingOnlyPresentRecepients then
					return true
				end
				local pWingmen = data.pUnit:getGroup():getUnit(number + 1)
				return pWingmen ~= nil
			end
		},			
		color = {
			get = function(self)
				local pWingmen = data.pUnit:getGroup():getUnit(number + 1)
				return getRecepientColor(pWingmen and pWingmen:getCommunicator())
			end
		},
		command = {
			perform = function(self)
				local pWingmen = data.pUnit:getGroup():getUnit(number + 1)
				selectAndTuneCommunicator(pWingmen and pWingmen:getCommunicator())
			end
		},
		parameter = number,
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
				data.pUnit:getGroup():getUnit(number + 1) ~= nil then
				tbl.items[number] = makeWingmenMenu(number - 1)
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
		
		return tbl
	end,
	builders = {}
}

utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/JTAC.lua', getfenv()))(4)
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/ATC.lua', getfenv()))(5, {['Airdrome'] = true, ['Helipad'] = false} )
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/AWACS.lua', getfenv()))(7, {tanker = false, radar = false})
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/Ground Crew.lua', getfenv()))(8)


-- Wheel Chocks
--[[
menus['Wheel chocks'] = {
	name = _('Wheel chocks'),
	items = {
		[1] = {name = _('Place_'), 		command = sendMessage.new(Message.wMsgLeaderGroundToggleWheelChocks, true)},
		[2] = {name = _('Remove_'), 		command = sendMessage.new(Message.wMsgLeaderGroundToggleWheelChocks, false)}
	}
}

menus['Ground Crew'].items[4] = { name = _('Wheel chocks'), submenu = menus['Wheel chocks']}

menus['Ground Air Supply'] = {
	name = _('Ground Air Supply'),
	items = {
		[1] = {name = _('Connect'), 		command = sendMessage.new(Message.wMsgLeaderGroundToggleAir, true)},
		[2] = {name = _('Disconnect'), 		command = sendMessage.new(Message.wMsgLeaderGroundToggleAir, false)},
		[3] = {name = _('Apply'), 			command = sendMessage.new(Message.wMsgLeaderGroundApplyAir, true)}
	}
}
]]

