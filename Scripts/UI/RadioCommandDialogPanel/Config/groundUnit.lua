local openFormation = true

local menus = data.menus

local dummyCommand = {
	perform = function(self, parameters)	
	end
}

local option = {
	OPTION_ROE = 0,
	OPTION_FORMATION = 5,
	OPTION_FOLLOWING = 12,
	}

local roeType = {
	ROE_WEAPON_FREE = 0, 
	ROE_OPEN_FIRE_WEAPON_FREE = 1, 
	ROE_OPEN_FIRE = 2, 
	ROE_RETURN_FIRE = 3, 
	ROE_WEAPON_HOLD = 4,
	}
	
local carFormationType = {
	NotDefined = 0,
	Column = 1,
	Row = 2,
	Wedge = 3,
	Vee = 4,
	Diamond = 5,
	EchelonR = 6,
	EchelonL = 7,
	Free = 8,
	}
	
menus['ROE'] = {
	name = _('ROE'),
	items = {
		{name = _('Fire'), 								command = setBehaviorOption:new(option.OPTION_ROE, roeType.ROE_OPEN_FIRE)}, 
		{name = _('Return fire'), 						command = setBehaviorOption:new(option.OPTION_ROE, roeType.ROE_RETURN_FIRE)},
		{name = _('Hold fire'), 						command = setBehaviorOption:new(option.OPTION_ROE, roeType.ROE_WEAPON_HOLD)},
	}
}
menus['AlarmState'] = {
	name = _('Alarm State'),
	items = {
		{ name = _('AUTO'), 							command = dummyCommand},
		{ name = _('AlarmStateRed'), 					command = dummyCommand},
		{ name = _('AlarmStateGreen'), 					command = dummyCommand},
	}
}

menus['FORMATION'] = {
	name = _('Formation'),
	items = {
		{ name = _('Column'), 							command = setBehaviorOption:new(option.OPTION_FORMATION, carFormationType.Column)},
		{ name = _('Row'), 								command = setBehaviorOption:new(option.OPTION_FORMATION, carFormationType.Row)},
		{ name = _('Wedge'), 							command = setBehaviorOption:new(option.OPTION_FORMATION, carFormationType.Wedge)},
		{ name = _('Vee'), 								command = setBehaviorOption:new(option.OPTION_FORMATION, carFormationType.Vee)},
		{ name = _('Diamond'), 							command = setBehaviorOption:new(option.OPTION_FORMATION, carFormationType.Diamond)},
		{ name = _('EchelonR'), 						command = setBehaviorOption:new(option.OPTION_FORMATION, carFormationType.EchelonR)},
		{ name = _('EchelonL'), 						command = setBehaviorOption:new(option.OPTION_FORMATION, carFormationType.EchelonL)},
		{ name = _('Free'), 							command = setBehaviorOption:new(option.OPTION_FORMATION, carFormationType.Free)},
	}
}

data.rootItem = {
	name = _('Main'),
	getSubmenu = function(self)		
		local tbl = {
			name = _('Main'),
			items = {
				[1] = {
					name = _('ROE'),
					submenu = menus['ROE'],
					condition = {
						check = function(self)
							return true
						end
					},		
					parameter = 1,
				},

--[[				[3] = {
					name = _('Alarm State'),
					submenu = menus['AlarmState'],
					condition = {
						check = function(self)
							return true
						end
					},
					parameter = 3,
				}]]
			}
		}
		if data.pUnit ~= nil and data.pUnit:getNumber() == 1 then
			tbl.items[2] = {
					name = _('Formation'),
					submenu = menus['FORMATION'],
					condition = {
						check = function(self)
							return true
						end
					},			
					parameter = 2,
				}
			tbl.items[3] = {
					name = _('Following leader'),
					condition = {
						check = function(self)
							return true
						end
					},
					parameter = 3,
					command = setBehaviorOption:new(option.OPTION_FOLLOWING, 1)
				}		
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
}