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

menus['Engage'] = {
	name = _('Engage'),
	items = {
		{name = _('My Target'), 						command = sendMessage.new(Message.wMsgLeaderEngageMyTarget)},
		{name = _('My Enemy'), 							command = sendMessage.new(Message.wMsgLeaderMyEnemyAttack)},
		{name = _('Bandits'), 							command = sendMessage.new(Message.wMsgLeaderEngageBandits, false, false)},
		{name = _('Air Defences'), 						command = sendMessage.new(Message.wMsgLeaderEngageAirDefenses, false, false)},
		{name = _('Ground Targets'), 					command = sendMessage.new(Message.wMsgLeaderEngageGroundTargets, false, false)},
		{name = _('Mission and Rejoin'), 				command = sendMessage.new(Message.wMsgLeaderFulfilTheTaskAndJoinUp)},
		{name = _('Mission and RTB'), 					command = sendMessage.new(Message.wMsgLeaderFulfilTheTaskAndReturnToBase)},
	}
}
menus['Go Pincer'] = {
	name = _('Go Pincer'),
	items = {
		{ name = _('High'), 							command = sendMessage.new(Message.wMsgLeaderPincerHigh) },
		{ name = _('Low'), 								command = sendMessage.new(Message.wMsgLeaderPincerLow) },
		{ name = _('Right'), 							command = sendMessage.new(Message.wMsgLeaderPincerRight) },
		{ name = _('Left'), 							command = sendMessage.new(Message.wMsgLeaderPincerLeft) }
	}
}
menus['Go To'] = {
	name = _('Go To'),
	items = {
		{ name = _('Return to Base'), 					command = sendMessage.new(Message.wMsgLeaderReturnToBase) },
		{ name = _('Route'), 							command = sendMessage.new(Message.wMsgLeaderFlyRoute) },
		{ name = _('Hold Position'), 					command = sendMessage.new(Message.wMsgLeaderAnchorHere) },
		{ name = _('Fly to Tanker'),					command = sendMessage.new(Message.wMsgLeaderGoRefueling) },
	}
}
menus['Reconnaissance'] = {
	name = _('Reconnaissance'),
	items = {
		{ name = _('5 NM'), 							command = sendMessage.new(Message.wMsgLeaderMakeRecon, 9260)},
		{ name = _('10 NM'), 							command = sendMessage.new(Message.wMsgLeaderMakeRecon, 18520)},
		{ name = _('15 NM'), 							command = sendMessage.new(Message.wMsgLeaderMakeRecon, 27780)},
		{ name = _('20 NM'), 							command = sendMessage.new(Message.wMsgLeaderMakeRecon, 37040)},
		{ name = _('30 NM'), 							command = sendMessage.new(Message.wMsgLeaderMakeRecon, 55560)},
		{ name = _('40 NM'), 							command = sendMessage.new(Message.wMsgLeaderMakeRecon, 74080)},
		{ name = _('50 NM'), 							command = sendMessage.new(Message.wMsgLeaderMakeRecon, 92600)},
	}
}

menus['Radar'] = {
	name = _('Radar'),
	items = {
		{ name = _('On'), 								command = sendMessage.new(Message.wMsgLeaderRadarOn) },
		{ name = _('Off'), 								command = sendMessage.new(Message.wMsgLeaderRadarOff) },
	}
}

menus['ECM'] = {
	name = _('ECM'),
	items = {
		{ name = _('On'), 								command = sendMessage.new(Message.wMsgLeaderDisturberOn) },
		{ name = _('Off'), 								command = sendMessage.new(Message.wMsgLeaderDisturberOff) },
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
			name = _('Engage'),
			submenu = menus['Engage']
		},
		[2] = {
			name = _('Go Pincer'),
			submenu = menus['Go Pincer'],
		},
		[3] = {
			name = _('Go To'),
			submenu = menus['Go To'],
		},
		[4] = {
			name = _('Cover Me'),
			command = sendMessage.new(Message.wMsgLeaderCoverMe)
		},
		[5] = {
			name = _('Formation'),
			getSubmenu = getFormationSubmenu,
		},
		[6] = {
			name = _('Hold Position'),
			submenu = menus['Hold Position'],
			command = sendMessage.new(Message.wMsgLeaderAnchorHere)
		},
		[7] = {
			name = _('Rejoin Formation'),
			command = sendMessage.new(Message.wMsgLeaderJoinUp)
		},
		[8] = {
			name = _('Radar'),
			submenu = menus['Radar'],
		},
		[9] = {
			name = _('ECM'),
			submenu = menus['ECM'],
		},
		[10] = {
			name = _('Jettison Weapons'),
			command = sendMessage.new(Message.wMsgLeaderJettisonWeapons)
		},
	}
}
local wingmenMenuItems = {
	[1] = {
		name = _('Engage'),
		submenu = menus['Engage']
	},
	[2] = {
		name = _('Go Pincer'),
		submenu = menus['Go Pincer'],
	},
	[3] = {
		name = _('Go To'),
		submenu = menus['Go To'],
	},
	[4] = {
		name = _('Cover Me'),
		command = sendMessage.new(Message.wMsgLeaderCoverMe)
	},
	[5] = {
		name = _('Reconnaissance'),
		submenu = menus['Reconnaissance'],
	},
	[6] = {
		name = _('Hold Position'),
		submenu = menus['Hold Position'],
		command = sendMessage.new(Message.wMsgLeaderAnchorHere)
	},
	[7] = {
		name = _('Rejoin Formation'),
		command = sendMessage.new(Message.wMsgLeaderJoinUp)
	},
	[8] = {
		name = _('Radar'),
		submenu = menus['Radar'],
	},
	[9] = {
		name = _('ECM'),
		submenu = menus['ECM'],
	},
	[10] = {
		name = _('Jettison Weapons'),
		command = sendMessage.new(Message.wMsgLeaderJettisonWeapons)
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


		--Some kind of if debug here TODO
		--[[tbl.items[9] = {
			name = _('To RIO'),
			submenu = menus['ToRIO']
		}]]

		return tbl
	end,
	builders = {}
}

utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/JTAC.lua', getfenv()))(4)
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/ATC.lua', getfenv()))(5, {['Airdrome'] = true, ['Helipad'] = false} )
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/Tanker.lua', getfenv()))(6)
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/AWACS.lua', getfenv()))(7, {tanker = true, radar = false})
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/Ground Crew.lua', getfenv()))(8)

-- Wheel Chocks
menus['Wheel chocks'] = {
	name = _('Wheel chocks'),
	items = {
		[1] = {name = _('Place_'),  command =
            {
                sendMessage = sendMessage.new(Message.wMsgLeaderGroundToggleWheelChocks, true),
                perform = function(self, parameters)
                    local sensors_device = data.base.GetDevice(8)
                    if sensors_device then
                        sensors_device:place_wheel_chocks()
                    end
                    self.sendMessage:perform(parameters)
                end
            }
        },

		[2] = {name = _('Remove_'), command =
            {
                sendMessage = sendMessage.new(Message.wMsgLeaderGroundToggleWheelChocks, false),
                perform = function(self, parameters)
                    local sensors_device = data.base.GetDevice(8)
                    if sensors_device then
                        sensors_device:remove_wheel_chocks()
                    end
                    self.sendMessage:perform(parameters)
                end
            }
        }
	}
}

table.insert(menus['Ground Crew'].items, { name = _('Wheel chocks'), submenu = menus['Wheel chocks']})

menus['Ground Air Supply'] = {
	name = _('Ground Air Supply'),
	items = {
		[1] = {name = _('Connect'),    command = sendMessage.new(Message.wMsgLeaderGroundToggleAir, true)},
		[2] = {name = _('Disconnect'), command = sendMessage.new(Message.wMsgLeaderGroundToggleAir, false)},
	--	[3] = {name = _('Apply'),      command = sendMessage.new(Message.wMsgLeaderGroundApplyAir, true)}
	}
}

table.insert(menus['Ground Crew'].items, { name = _('Ground Air Supply'), submenu = menus['Ground Air Supply']})



local LoadAle39 = {
	perform = function(self, parameters)		
		local ale39 = data.base.GetDevice(5)
		if ale39 then
			ale39:set_cms_loadout(self.loadoutIndex)
		end
	end
}
LoadAle39.__index = LoadAle39
function LoadAle39.new(loadoutIndex)
	local loadAle39 = { loadoutIndex = loadoutIndex }
	data.base.setmetatable(loadAle39, LoadAle39)
	return loadAle39
end

menus['AN/ALE-39 Loadouts'] = { 
	name = _('AN/ALE-39 Loadouts'),
	items = {
		[1] = {name = _('60 Flares / 0 Chaffs'), command = LoadAle39.new(0)},
		[2] = {name = _('50 Flares / 10 Chaffs'), command = LoadAle39.new(1)},
		[3] = {name = _('40 Flares / 20 Chaffs'), command = LoadAle39.new(2)},
		[4] = {name = _('30 Flares / 30 Chaffs'), command = LoadAle39.new(3)},
		[5] = {name = _('20 Flares / 40 Chaffs'), command = LoadAle39.new(4)},
		[6] = {name = _('10 Flares / 50 Chaffs'), command = LoadAle39.new(5)},
		[7] = {name = _('0 Flares / 60 Chaffs'), command = LoadAle39.new(6)},
	}
}

table.insert(menus['Ground Crew'].items, { name = _('Select AN/ALE-39 Loadout'), submenu = menus['AN/ALE-39 Loadouts']})



local LoadKy28Key = {
	perform = function(self, parameters)		
		local commDevice = data.base.GetDevice(2)
		if commDevice then
			commDevice:load_ky28_key(self.keyIndex)
		end
	end
}
LoadKy28Key.__index = LoadKy28Key
function LoadKy28Key.new(keyIndex)
	local loadKy27Key = { keyIndex = keyIndex }
	data.base.setmetatable(loadKy27Key, LoadKy28Key)
	return loadKy27Key
end

menus['KY-28 Encryption'] = { 
	name = _('KY-28 Encryption'),
	items = {
		[1] = {name = _('Load KYK-28 key 1'), command = LoadKy28Key.new(1)},
		[2] = {name = _('Load KYK-28 key 2'), command = LoadKy28Key.new(2)},
		[3] = {name = _('Load KYK-28 key 3'), command = LoadKy28Key.new(3)},
		[4] = {name = _('Load KYK-28 key 4'), command = LoadKy28Key.new(4)},
		[5] = {name = _('Load KYK-28 key 5'), command = LoadKy28Key.new(5)},
		[6] = {name = _('Load KYK-28 key 6'), command = LoadKy28Key.new(6)},
		[7] = {name = _('Load KYK-28 key 7'), command = LoadKy28Key.new(7)},
		[8] = {name = _('Load KYK-28 key 8'), command = LoadKy28Key.new(8)},
	}
}

table.insert(menus['Ground Crew'].items, { name = _('KY-28 Encryption'), submenu = menus['KY-28 Encryption']})

table.insert(menus['Ground Crew'].items, { name = _('Request Launch'), command = sendMessage.new(Message.wMsgLeaderGroundRequestLaunch, true)})

table.insert(menus['Ground Crew'].items, { name = _('Salute!'), command = 
{
	perform = function(self)		
		local commDevice = data.base.GetDevice(2)
		if commDevice then
			commDevice:catapult_salute()
		end
	end
}})
