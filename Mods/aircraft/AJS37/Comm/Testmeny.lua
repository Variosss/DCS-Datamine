local mainMenuPos = ...

--Menus
-- print("TESTMENU!")
-- for key,value in pairs(events) do print(key,value) end
-- --table.insert(data.rootItem.builders, buildGroundCrew)
-- --events.Message.wMsgTestTest =	{_('hello'), 'hello'}
-- events['Message'][wMsgTestTest] = {_('hello'), 'hello'} -- Gave up. Adding in common_events.lua instead.

local menus = data.menus

menus['TestTest'] = {
	name = _('TestTest'),
	items = {
		[1] = {name = _('On'), 							command = sendMessage.new( { _('test'), 'test' }, true)},
		[2] = {name = _('Off'), 						command = sendMessage.new({ _('test'), 'test' }, false)}
	}
}

local showMissionResourcesDialog = {
	perform = function(self)
		MissionResourcesDialog.onRadioMenuRearm()
	end
}
local doThisOtherThing = {
	perform = function(self)
		--set_aircraft_draw_argument_value(607, 1)
			--print_message_to_user("AFK disengaged");
			print("HEEEEEEEEEEEEELO")
	end
}
menus['Viggen Special Menu'] = {
	name = _('Viggen Special'),
	items = {
		[1] = {name = _('Rearm & Refuel'), 				command = showMissionResourcesDialog},
		[2] = {name = _('TestTestSubmenu'), 				submenu = menus['TestTest']},
		[3] = {name = _('Cats Rule (,,,)=(^.^)=(,,,) Yes?'), 				command = doThisOtherThing},--command = sendMessage.new({ _('cat'), 'cat' })}
		[4] = {name = _('Pickles!'), 				command = 123},
	}
}

local function buildGroundCrew(self, menu)
	if 	not data.showingOnlyPresentRecepients or
		not data.pUnit:inAir() then
		menu.items[mainMenuPos] = {
			name = _('Viggen Special Menu'),
			submenu = menus['Viggen Special Menu'],
			color = {
				get = function(self)
					return getRecepientColor(nil)
				end
			},
			command = {
				perform = function(self)
					selectAndTuneCommunicator(nil)
				end
			},	
		}
	end
end

--table.insert(data.rootItem.builders, buildGroundCrew)

	