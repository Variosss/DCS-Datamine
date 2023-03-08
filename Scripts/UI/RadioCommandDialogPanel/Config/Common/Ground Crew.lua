local mainMenuPos = ...

--Menus
local menus = data.menus

menus['Ground power'] = {
	name = _('Ground power'),
	items = {
		[1] = {name = _('On'), 							command = sendMessage.new(Message.wMsgLeaderGroundToggleElecPower, true)},
		[2] = {name = _('Off'), 						command = sendMessage.new(Message.wMsgLeaderGroundToggleElecPower, false)}
	}
}

local showMissionResourcesDialog = {
	perform = function(self)
		MissionResourcesDialog.onRadioMenuRearm()
	end
}

menus['Ground Crew'] = {
	name = _('Ground Crew'),
	items = {
		[1] = {name = _('Rearm & Refuel'), 				command = showMissionResourcesDialog},
		[2] = {name = _('Ground power'), 				submenu = menus['Ground power']},
		[3] = {name = _('Request Repair'), 				command = sendMessage.new(Message.wMsgLeaderGroundRepair)}
	}
}

local function buildGroundCrew(self, menu)
	if 	not data.showingOnlyPresentRecepients or
		not data.pUnit:inAir() then
		menu.items[mainMenuPos] = {
			name = _('Ground Crew'),
			submenu = menus['Ground Crew'],
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

table.insert(data.rootItem.builders, buildGroundCrew)



COMMAND_REARM                       = 1
COMMAND_RELOAD_CANNON               = 2
COMMAND_REFUEL                      = 3
COMMAND_CHANGE_COCKPIT_EQUIPMENT    = 4
COMMAND_CHANGE_POWER_SOURCE         = 5
COMMAND_GROUND_POWER_ON_OFF         = 6
COMMAND_LADDER                      = 7
COMMAND_REPAIR                      = 8
COMMAND_RUN_INERTIAL_STARTER        = 9
COMMAND_WHEEL_CHOCKS_ON_OFF         = 10
COMMAND_GROUND_AIR_ON_OFF           = 11
COMMAND_GROUND_AIR_APPLY            = 12
COMMAND_TOGGLE_CANOPY               = 13
COMMAND_CHANGE_AIRFRAME_CONFIG      = 14
COMMAND_MAINTAIN_PRIMING            = 15
COMMAND_EXHAUST_SCREEN				= 16

COCKPIT_DEVICE_HMS                  = 0
COCKPIT_DEVICE_NVG                  = 1
COCKPIT_DEVICE_GUN_SIGHT            = 2
COCKPIT_DEVICE_BOMB_SIGHT           = 3
COCKPIT_DEVICE_FLARE_PISTOL         = 4
COCKPIT_DEVICE_BLIND_SCREEN         = 5

COCKPIT_DEVICE_STATE_DISMOUNT       = 0
COCKPIT_DEVICE_STATE_MOUNT          = 1
COCKPIT_DEVICE_STATE_REPLACE        = 2

POWER_SOURCE_TURBO_GEAR             = 0
POWER_SOURCE_REGULAR_LAUNCH         = 1

