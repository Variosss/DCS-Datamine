-- The module contains information about actions for action list of waypoints
-- The module contains information about actions for action list of waypoints

local base = _G

module('me_action_db')

local require = base.require

local U				= require('me_utilities')
local DB			= require('me_db_api')
local mission		= require('me_mission')
local OptionsData	= require('Options.Data')
local mod_dictionary = require('dictionary')
local TriggerZoneController	= require('Mission.TriggerZoneController')
local ProductType 			= require('me_ProductType') 

require('i18n').setup(_M)

--Common data
local localization = {
    groupImmortal   = _('Make all units of the group immortal.'),
    allowGroup    = _('Allow the group to engage the enemy unit or the enemy static object during the mission')
}

if ProductType.getType() == "LOFAC" then
    localization.groupImmortal     = _("Make all units of the group immortal.-LOFAC")
    localization.allowGroup        = _('Allow the group to engage the enemy unit or the enemy static object during the mission-LOFAC')
end

--Weapon

do

local cdata = {	    
	noWeapon					= _('No weapon'),
	all							= _('All'),
		unguided 				= _('Unguided'),
			shells				= _('-Shells'),
			cannon				= _('-Cannons'),
			conventionalShell	= _('--Conventional'),
			markerShells		= _('-Marker'),
			smokeShell			= _('--Smoke'),
			candleShell			= _('--Illumination'),
			rockets				= _('-Rockets'),
				smokeRockets	= _('--Smoke rockets'),
				lightRockets	= _('--Light rockets'),
				candleRockets	= _('--Candle rockets'),
				heavyRockets	= _('--Heavy rockets'),
			bombs				= _('-Bombs'),
				ironBombs		= _('--Iron bombs'),
				clusterBombs	= _('--Cluster bombs'),
				candleBombs		= _('--Candle bombs'),
		Torpedoes				= _('-Torpedoes'),
		guided					= _('Guided'),
		guidedBombs				= _('-Guided bombs'),
		missiles				= _('-Missiles'),
			ASM					= _('-ASM'),
				ATGM			= _('--ATGM'),
				standardASM		= _('--Standard ASM'),
				ARM				= _('--ARM'),
				antiship		= _('--Antiship missiles'),
				cruiseMissile	= _('--Cruise missiles'),
			AAM					= _('-AAM'),
				SR_AAM			= _('--SR AAM'),
				MR_AAM			= _('--MR AAM'),
				LR_AAM			= _('--LR AAM'),
			Decoys				= _('-Decoys')
		
}



function weaponItem(nameIn, valueIn)
	return { name = nameIn, value = valueIn }
end

local cannon_const = 805306368
local smokeShell_const = 17179869184 --1 << 34
local candleShell_const = 34359738368 --1 << 35
local markerShell_const = 51539607552 -- smokeShell_const | candleShell_const 
local shells_const = 52344913920 -- cannon_const | markerShell_const

weaponTable = {
	noWeapon					= weaponItem(cdata.noWeapon, 		0),
	all							= weaponItem(cdata.all, 			4294967295),
	unguided 					= weaponItem(cdata.unguided, 		805339120),
		cannon					= weaponItem(cdata.cannon, 			cannon_const),
		shells					= weaponItem(cdata.shells,			shells_const),
			conventionalShell  	= weaponItem(cdata.conventionalShell, cannon_const), -- the "cannon" const value with another list item name to be used in ground units
			markerShell			= weaponItem(cdata.markerShells, 	markerShell_const),
			smokeShell			= weaponItem(cdata.smokeShell, 		smokeShell_const),
			candleShell			= weaponItem(cdata.candleShell, 	candleShell_const),
		rockets					= weaponItem(cdata.rockets, 		30720),
			smokeRockets		= weaponItem(cdata.smokeRockets, 	4096),
			lightRockets		= weaponItem(cdata.lightRockets, 	2048),
			candleRockets		= weaponItem(cdata.candleRockets, 	8192),
			heavyRockets		= weaponItem(cdata.heavyRockets, 	16384),
		bombs					= weaponItem(cdata.bombs, 			2032),
			ironBombs			= weaponItem(cdata.ironBombs, 		240),
			clusterBombs		= weaponItem(cdata.clusterBombs, 	768),
			candleBombs			= weaponItem(cdata.candleBombs, 	1024),
		Torpedoes				= weaponItem(cdata.Torpedoes, 		4294967296),		
	guided						= weaponItem(cdata.guided, 			268402702),
		guidedBombs				= weaponItem(cdata.guidedBombs, 	14),
		missiles				= weaponItem(cdata.missiles, 		268402688),
			ASM					= weaponItem(cdata.ASM, 			4161536),		
				ATGM			= weaponItem(cdata.ATGM, 			131072),
				standardASM		= weaponItem(cdata.standardASM, 	1835008),
				ARM				= weaponItem(cdata.ARM, 			32768),
				antiship		= weaponItem(cdata.antiship,		65536),
				cruiseMissile	= weaponItem(cdata.cruiseMissile, 	2097152),
			AAM					= weaponItem(cdata.AAM, 			264241152),
				SR_AAM			= weaponItem(cdata.SR_AAM, 			4194304),
				MR_AAM			= weaponItem(cdata.MR_AAM, 			8388608),
				LR_AAM			= weaponItem(cdata.LR_AAM, 			16777216),
		Decoys					= weaponItem(cdata.Decoys, 			8589934592),
}

end

local counter = {
	value_ = 1,
	start = function(self)
		self.value_ = 1
		return self.value_
	end,
	next = function(self)
		self.value_ = self.value_ + 1
		return self.value_
	end
}

priorityMax = 255

highestPriority = 0
lowestPriority = priorityMax

ActionType = {
	TASK				= 1,
	ENROUTE_TASK		= 2,
	COMMAND				= 3,
	OPTION				= 4
}

ActionId = {
	--ActionType.TASK
	NO_TASK				= counter:start(),
	ATTACK_GROUP		= counter:next(),
	ATTACK_UNIT			= counter:next(),
	ATTACK_MAP_OBJECT	= counter:next(),
	BOMBING				= counter:next(),
	BOMBING_RUNWAY		= counter:next(),
	ORBIT				= counter:next(),
	LAND				= counter:next(),
	REFUELING			= counter:next(),
	FAC_ATTACK_GROUP	= counter:next(),
	FIRE_AT_POINT		= counter:next(),
	HOLD				= counter:next(),
	FOLLOW				= counter:next(),
	ESCORT				= counter:next(),
	EMBARK_TO_TRANSPORT	= counter:next(),  
	GO_TO_WAYPOINT		= counter:next(),
	EMBARKING				= counter:next(),
	DISEMBARKING			= counter:next(),
	CARGO_TRANSPORTATION	= counter:next(),
	GROUND_ESCORT			= counter:next(),
	--ActionType.ENROUTE_TASK
	NO_ENROUTE_TASK		= counter:next(),
	ENGAGE_TARGETS		= counter:next(),
	ENGAGE_TARGETS_IN_ZONE = counter:next(),
	ENGAGE_GROUP		= counter:next(),
	ENGAGE_UNIT			= counter:next(),
	AWACS				= counter:next(),
	EWR					= counter:next(),
	FAC					= counter:next(),
	FAC_ENGAGE_GROUP	= counter:next(),
	TANKER				= counter:next(),
	FIGHTER_SWEEP		= counter:next(),
	CAS					= counter:next(),
	CAP					= counter:next(),
	SEAD				= counter:next(),
	ANTI_SHIP			= counter:next(),
	--ActionType.COMMAND
	NO_ACTION			= counter:next(),
	SCRIPT				= counter:next(),
	SCRIPT_FILE			= counter:next(),
	SET_CALLSIGN		= counter:next(),
	SET_FREQUENCY		= counter:next(),
	SET_FREQUENCYFORUNIT	= counter:next(),
	TRANSMIT_MESSAGE	= counter:next(),
	STOP_TRANSMISSION	= counter:next(),
	SWITCH_WAYPOINT		= counter:next(),
	SWITCH_ITEM			= counter:next(),
	INVISIBLE			= counter:next(),
	IMMORTAL			= counter:next(),
	START				= counter:next(),
	ACTIVATE_TACAN		= counter:next(),
	DEACTIVATE_BEACON	= counter:next(),
	EPLRS				= counter:next(),
	SMOKE_ON_OFF		= counter:next(),
	--ActionType.OPTION
	NO_OPTION			= counter:next(),
	ROE					= counter:next(),
	REACTION_ON_THREAT	= counter:next(),
	RADAR_USING			= counter:next(),
	FLARE_USING			= counter:next(),
	FORMATION			= counter:next(),  --58
	RTB_ON_BINGO		= counter:next(),
	RTB_ON_OUT_OF_AMMO	= counter:next(),
	SILENCE				= counter:next(),
	DISPERSE_ON_ATTACK  = counter:next(),
	ALARM_STATE			= counter:next(),
	ECM_USING			= counter:next(),
	PROHIBIT_AA			= counter:next(),
	PROHIBIT_JETT		= counter:next(),
	PROHIBIT_AB			= counter:next(),
	PROHIBIT_AG			= counter:next(),
	MISSILE_ATTACK		= counter:next(),
	PROHIBIT_WP_PASS_REPORT	= counter:next(),
	--PROHIBITIONS		= counter:next(),

	--AWARNESS_LEVEL		= counter:next(),
	--ActionType.TASK
	AEROBATICS			= counter:next(),
    ENGAGE_AIR_WEAPONS  = counter:next(),
	CARPET_BOMBING		= counter:next(),
	WW2_BIG_FORMATION	= counter:next(),
	
	--ActionType.OPTION
	RADIO_USAGE_CONTACT	= counter:next(),
	RADIO_USAGE_ENGAGE	= counter:next(),
	RADIO_USAGE_KILL	= counter:next(),
	ACTIVATE_ICLS		= counter:next(),
	DEACTIVATE_ICLS		= counter:next(),	
	
	--ActionType.TASK
	PARATROOPERS_DROP	= counter:next(),
	
	AIRBONE_DROP_OPERATION= counter:next(), -- удалено
	AIRCRAFT_INTERCEPT_RANGE	= counter:next(), 
	ATTACH_TRAILER		= counter:next(), 
	DETACH_TRAILER	= counter:next(), 
	
	--ActionType.OPTION			
	JETT_TANKS_IF_EMPTY	= counter:next(),	-- https://jira.eagle.ru/browse/ASSETS-1141
	FORCED_ATTACK		= counter:next(),   -- https://jira.eagle.ru/browse/ASSETS-1822
	
	ALT_RESTRICTION_MIN	= counter:next(),
	RESTRICT_TARGET		= counter:next(),
	ALT_RESTRICTION_MAX	= counter:next(),	
	LOADING_SHIP		= counter:next(),	 --90
	CARGO_TRANSPORTATION_PLANE = counter:next(),	 
	CARGO_UNLOAD_PLANE 	= counter:next(),
	ACTIVATE_LINK4		= counter:next(),
	DEACTIVATE_LINK4	= counter:next(),	
	ACTIVATE_ACLS		= counter:next(),
	DEACTIVATE_ACLS		= counter:next(),
	
	--ActionType.TASK
	RECOVERY_TANKER		= counter:next(),
	SHIP_HOLD_POINT		= counter:next(),
}

local function printActionId(task)
	return task.number..'. '..getActionDataByTask(task).displayName
end

local function printActionName(task)
	return (task.name ~= nil and base.string.len(task.name) > 0) and ' \"'..task.name..'\"' or ''
end

--Check start condition
function isStartConditionDefined(condition)
	return 	condition.time ~= nil or
			condition.userFlag ~= nil or
			condition.probability ~= nil or
			(condition.condition ~= nil and base.string.len(condition.condition) > 0)
end

--Check stop condition
function isStopConditionDefined(stopCondition)
	return 	stopCondition.time ~= nil or
			stopCondition.userFlag ~= nil or
			(stopCondition.condition ~= nil and base.string.len(stopCondition.condition) > 0) or
			stopCondition.duration ~= nil or
			stopCondition.lastWaypoint ~= nil
end	

local function printTaskAttrbutes(task)
	local description = ''
	if task.id == 'ControlledTask' then
		local startConditionPresent = task.params.condition and isStartConditionDefined(task.params.condition)
		local stopConditionPresent = task.params.stopCondition and isStopConditionDefined(task.params.stopCondition)
		if startConditionPresent or stopConditionPresent then
			description = description..' -'
		end
		if startConditionPresent then
			description = description..'?'
		end
		if 	startConditionPresent or
			stopConditionPresent then
			description = description..'/'
		end
		if stopConditionPresent then
			description = description..'?'
		end
	end	
	if task.auto then
		description = description..' -a'
	end
	if task.valid ~= nil then
		description = description..' -!'
	end
	if not task.enabled then
		description = description..' -x'
	end
	return description
end

local function getCommonDescription(group, wpt, task)
	return printActionId(task)..printActionName(task)..printTaskAttrbutes(task)
end

function getNewTblGroupIdForEPLRS(a_group)
	local groupIds = {}
	local groupIsAirbourne = a_group.type == 'plane' or a_group.type == 'helicopters'	
	for curGroupIndex, curGroup in base.pairs(mission.group_by_id) do
		if curGroup ~= a_group then
			local curGroupIsAirbourne = curGroup.type == 'plane' or curGroup.type == 'helicopters'
			if groupIsAirbourne == curGroupIsAirbourne then
				for wptIndex, wpt in base.pairs(curGroup.route.points) do
					if wpt.task then
						for taskIndex, task in base.pairs(wpt.task.params.tasks) do
							if task.id == 'WrappedAction' then
								local action = task.params.action
								if action.id == 'EPLRS' then
									groupIds[action.params.groupId] = true
								end
							end
						end
					end
				end
			end
		end
	end
	for i = 1, 99 do
		if groupIds[i] == nil then
			return { groupId = i }
		end
	end
	return { groupId = 0 }
end

function calcTACANFrequencyMHz(AA, modeChannel, channel)		
	if 	not AA and
		modeChannel == 'X' then
		if channel < 64 then
			return 962 + channel - 1
		else
			return 1151 + channel - 64
		end
	else
		if channel < 64 then
			return 1088 + channel - 1
		else
			return 1025 + channel - 64
		end
	end
end

function fill_TACAN(a_unit, params)
	local unitDesc = DB.unit_by_type[a_unit.type]
	if unitDesc.TACAN == true then					
		if a_unit.boss.type == 'plane' or a_unit.boss.type == 'helicopter' then
			-- Tankers are supposed to have a 'normal' TACAN station onboard, not Air-to-Air TACAN
			params.AA = base.findAttribute(unitDesc.attribute, 'Tankers') ~= true
		else
			params.AA = false
		end

		if 'ship' == a_unit.boss.type then
			-- TACAN
			params.system = 3
		elseif 'vehicle' == a_unit.boss.type then
			if params.modeChannel == 'Y' then
				-- TACAN_MOBILE_MODE_Y
				params.system = 19
			else
				-- TACAN_MOBILE_MODE_X
				params.system = 18
			end
		elseif base.findAttribute(unitDesc.attribute, 'Tankers') then
			if params.modeChannel == 'Y' then
				-- TACAN_TANKER_MODE_Y
				params.system = 5
			else
				-- TACAN_TANKER_MODE_X
				params.system = 4
			end
		end
	else
		if params.modeChannel == 'Y' then
			-- TACAN_AA_MODE_Y
			params.system = 14
		else
			-- TACAN_AA_MODE_X
			params.system = 13
		end
	end
	
	params.frequency = 1000000 * calcTACANFrequencyMHz(params.AA, params.modeChannel, params.channel)
	
	return params
end	

defaultActionType = ActionType.TASK

actionTypeData = {
	[ActionType.TASK] = {
		displayName = _('Perform Task'),
		desc = _('Perform task.\nTask require time to perform and switch to another action in the list'),
		defaultActionId = ActionId.NO_TASK,
	},
	[ActionType.ENROUTE_TASK] = {
		displayName = _('Start Enroute Task'),
		desc = _('Start en-route task.\nEn-route tasks are performed together with current task'),
		defaultActionId = ActionId.NO_ENROUTE_TASK,
	},
	[ActionType.COMMAND] = {
		displayName = _('Perform Command'),
		desc = _('Performs a command for the group.\nCommand is a single action and take no time to perform'),
		defaultActionId = ActionId.NO_ACTION,
	},
	[ActionType.OPTION] = {
		displayName = _('Set Option'),
		desc = _('Set a behavior option.\nBehavior options affect the group behavior whatever task it performs'),
		defaultActionId = ActionId.NO_OPTION,
	}
}

local function makeWrappedAction(id, params)
	return {
			id = 'WrappedAction',
			params = {
				action = {
					id = id,
					params = params or {}
				}
			}
	}
end

local function declareCommand(id, displayName, desc, params, getDescription, key, verifyGroupCapability, makeParams, onRemove)
	return {
		type					= ActionType.COMMAND,
		displayName				= displayName,
		desc					= desc,
		getDescription			= getDescription,
		verifyGroupCapability	= verifyGroupCapability,
		makeParams				= makeParams,
		task					= makeWrappedAction(id, params),
		onRemove				= onRemove
	}
end

local OptionName = {
	NO_OPTION			= -1,
	ROE 				= 0,
	REACTION_ON_THREAT 	= 1,
	RADAR_USING			= 3,
	FLARE_USING			= 4,
	FORMATION			= 5,
	RTB_ON_BINGO		= 6,
	SILENCE				= 7,
    DISPERSE_ON_ATTACK  = 8,
	ALARM_STATE			= 9,
	RTB_ON_OUT_OF_AMMO	= 10,
	AWARNESS_LEVEL 		= 11,
	FOLLOWING			= 12,
	ECM_USING			= 13,
	PROHIBIT_AA			= 14,
	PROHIBIT_JETT		= 15,
	PROHIBIT_AB			= 16,
	PROHIBIT_AG			= 17,
	MISSILE_ATTACK		= 18,
	PROHIBIT_WP_PASS_REPORT = 19,
    ENGAGE_AIR_WEAPONS  = 20,
	RADIO_USAGE_CONTACT	= 21,
	RADIO_USAGE_ENGAGE	= 22,
	RADIO_USAGE_KILL	= 23,
	AIRCRAFT_INTERCEPT_RANGE  = 24,
	JETT_TANKS_IF_EMPTY = 25,
	FORCED_ATTACK		= 26,
	ALT_RESTRICTION_MIN	= 27,
	RESTRICT_TARGET		= 28,
	ALT_RESTRICTION_MAX = 29,
}

local OptionValue = {
	--OptionName.ROE
	WEAPON_FREE					= 0,
	OPEN_FIRE_WEAPON_FREE		= 1,
	OPEN_FIRE					= 2,
	RETURN_FIRE					= 3, 
	WEAPON_HOLD					= 4,		
	--OptionName.REACTION_ON_THREAT
	NO_REACTION 				= 0,
	PASSIVE_DEFENCE				= 1,
	EVADE_FIRE					= 2,
	BYPASS_AND_ESCAPE			= 3,
	ALLOW_ABORT_MISSION			= 4,
	HOR_AAA_EVADE_FIRE			= 5,
	--OptionName.RADAR_USING
	NEVER_USE					= 0,
	USE_FOR_ATTACK_ONLY			= 1,
	USE_FOR_SEARCH_IF_REQUIRED	= 2,
	USE_FOR_CONTINUOUS_SEARCH	= 3,
	--OptionName.FLARE_USING
	NEVER_USE					= 0,
	USE_AGAINST_FIRED_MISSILE	= 1,
	USE_WHEN_FLYING_IN_SAM_WEZ	= 2,
	USE_WHEN_FLYING_NEAR_ENEMIES= 3,
	--OptionName.ALARM_STATE
	ALARM_STATE_AUTO			= 0,
	ALARM_STATE_GREEN			= 1,
	ALARM_STATE_RED				= 2,
	--OptionName.AWARNESS_LEVEL
	AWARNESS_LEVEL_SAFE			= 0,
	AWARNESS_LEVEL_AWARE		= 1,
	AWARNESS_LEVEL_DANGER		= 2,
	--OptionName.ECM_USING
	NEVER_USE						= 0,
	USE_IF_ONLY_LOCK_BY_RADAR		= 1,
	USE_IF_DETECTED_LOCK_BY_RADAR	= 2,
	ALWAYS_USE						= 3,
	--OptionName.MISSILE_ATTACK
	MAX_RANGE						= 0,
	NEZ_RANGE						= 1,
	HALF_WAY_RMAX_NEZ				= 2,
	TARGET_THREAT_EST				= 3,
	RANDOM_RANGE					= 4,
	--OptionName.RESTRICT_TARGET
	ENGAGE_ALL_UNITS				= 0,
	ENGAGE_AIR_UNITS_ONLY			= 1,
	ENGAGE_GROUND_UNITS_ONLY		= 2,	
}

local ROEValues = {
	air = {
		list = {
			OptionValue.WEAPON_FREE,
			OptionValue.OPEN_FIRE_WEAPON_FREE,
			OptionValue.OPEN_FIRE,
			OptionValue.RETURN_FIRE,
			OptionValue.WEAPON_HOLD,
		},
		default = OptionValue.OPEN_FIRE
	},
	ground = {
		list = {
			OptionValue.WEAPON_FREE,
			OptionValue.RETURN_FIRE,
			OptionValue.WEAPON_HOLD,
		},
		default = OptionValue.WEAPON_FREE
	}
}

local ALARM_STATE_values = {
		list = {
			OptionValue.ALARM_STATE_AUTO,
			OptionValue.ALARM_STATE_GREEN,
			OptionValue.ALARM_STATE_RED,
		},
		default = OptionValue.ALARM_STATE_AUTO
}	

optionValues = {
	[OptionName.ROE] = {
		['plane']		= ROEValues.air,
		['helicopter']	= ROEValues.air,
		['vehicle']		= ROEValues.ground,
		['ship']		= ROEValues.ground
	},
	[OptionName.ALARM_STATE] = {
		['vehicle']		= ALARM_STATE_values,
		['ship']		= ALARM_STATE_values,
	},
	[OptionName.REACTION_ON_THREAT] = {
		list = {
			OptionValue.NO_REACTION,
			OptionValue.PASSIVE_DEFENCE,
			OptionValue.EVADE_FIRE,
			OptionValue.BYPASS_AND_ESCAPE,
			OptionValue.ALLOW_ABORT_MISSION,
			OptionValue.HOR_AAA_EVADE_FIRE
		},
		default = OptionValue.ALLOW_ABORT_MISSION
	},
	[OptionName.RADAR_USING] = {
		list = {
			OptionValue.NEVER_USE,
			OptionValue.USE_FOR_ATTACK_ONLY,
			OptionValue.USE_FOR_SEARCH_IF_REQUIRED,
			OptionValue.USE_FOR_CONTINUOUS_SEARCH
		},
		default = OptionValue.USE_FOR_SEARCH_IF_REQUIRED
	},
	[OptionName.FLARE_USING] = {
		list = {
			OptionValue.NEVER_USE,
			OptionValue.USE_AGAINST_FIRED_MISSILE,
			OptionValue.USE_WHEN_FLYING_IN_SAM_WEZ,
			OptionValue.USE_WHEN_FLYING_NEAR_ENEMIES
		},
		default = OptionValue.USE_WHEN_FLYING_IN_SAM_WEZ
	},
	[OptionName.DISPERSE_ON_ATTACK] = {		
		units = U.timeUnits,
		min = 0,
		max = 1000000,
		default = 600,
		DisplayNameValue = _("Disperse")
	},
	[OptionName.AWARNESS_LEVEL] = {
		list = {
			OptionValue.AWARNESS_LEVEL_SAFE,
			OptionValue.AWARNESS_LEVEL_AWARE,
			OptionValue.AWARNESS_LEVEL_DANGER
		},
		default = OptionValue.AWARNESS_LEVEL_AWARE
	},
	[OptionName.RTB_ON_OUT_OF_AMMO] = {
		list = {},
		default = weaponTable.noWeapon.value
	},
	[OptionName.ECM_USING] = {
		list = {
			OptionValue.NEVER_USE,
			OptionValue.USE_IF_ONLY_LOCK_BY_RADAR,
			OptionValue.USE_IF_DETECTED_LOCK_BY_RADAR,
			OptionValue.ALWAYS_USE
		},
		default = OptionValue.USE_IF_ONLY_LOCK_BY_RADAR
	},
	[OptionName.MISSILE_ATTACK] = {
		list = {
			OptionValue.MAX_RANGE,
			OptionValue.NEZ_RANGE,
			OptionValue.HALF_WAY_RMAX_NEZ,
			OptionValue.TARGET_THREAT_EST,
			OptionValue.RANDOM_RANGE
		},
		default = OptionValue.TARGET_THREAT_EST
	},
	[OptionName.RADIO_USAGE_CONTACT]={
		list = {
		},
	},
	[OptionName.RADIO_USAGE_ENGAGE]={
		list = {
		},
	},
	[OptionName.RADIO_USAGE_KILL]={
		list = {
		},
	},	
	[OptionName.AIRCRAFT_INTERCEPT_RANGE]={
		min = 0,
		max = 100,
		default = 100
	},
	[OptionName.ALT_RESTRICTION_MIN] = {
		units = U.altitudeUnits,
		min = 0,
		max = 1000000,
		default = 200,
	},
	[OptionName.ALT_RESTRICTION_MAX] = {
		units = U.altitudeUnits,
		min = 0,
		max = 1000000,
		default = 3500,
	},
	[OptionName.RESTRICT_TARGET] = {
		list = {
			OptionValue.ENGAGE_ALL_UNITS,
			OptionValue.ENGAGE_AIR_UNITS_ONLY,
			OptionValue.ENGAGE_GROUND_UNITS_ONLY,
		},
		default = OptionValue.ENGAGE_ALL_UNITS
	},
}

optionValueDisplayName = {
	[OptionName.ROE] = {
		[OptionValue.WEAPON_FREE]					= _('WEAPON FREE'),
		[OptionValue.OPEN_FIRE_WEAPON_FREE]			= _('PRIORITY DESIGNATED'),
		[OptionValue.OPEN_FIRE]						= _('ONLY DESIGNATED'),
		[OptionValue.RETURN_FIRE]					= _('RETURN FIRE'), 
		[OptionValue.WEAPON_HOLD]					= _('WEAPON HOLD')
	},
	[OptionName.ALARM_STATE] = {
		[OptionValue.ALARM_STATE_AUTO]				= _('AUTO'),
		[OptionValue.ALARM_STATE_GREEN]				= _('GREEN state'),
		[OptionValue.ALARM_STATE_RED]				= _('RED state'),
	},
	[OptionName.REACTION_ON_THREAT] = {
		[OptionValue.NO_REACTION] 					= _('NO REACTION'),
		[OptionValue.PASSIVE_DEFENCE]				= _('PASSIVE DEFENCE'),
		[OptionValue.EVADE_FIRE]					= _('EVADE FIRE'),
		[OptionValue.BYPASS_AND_ESCAPE]				= _('BYPASS AND ESCAPE (N/A)'),
		[OptionValue.ALLOW_ABORT_MISSION]			= _('ALLOW ABORT MISSION'),
		[OptionValue.HOR_AAA_EVADE_FIRE]			= _('HORIZONTAL AAA FIRE EVADE')
	},
	[OptionName.RADAR_USING] = {
		[OptionValue.NEVER_USE]						= _('NEVER USE'),
		[OptionValue.USE_FOR_ATTACK_ONLY]			= _('USE FOR ATTACK ONLY'),
		[OptionValue.USE_FOR_SEARCH_IF_REQUIRED]	= _('USE FOR SEARCH IF REQUIRED'),
		[OptionValue.USE_FOR_CONTINUOUS_SEARCH]		= _('USE FOR CONTINUOUS SEARCH')
	},
	[OptionName.FLARE_USING] = {
		[OptionValue.NEVER_USE]						= _('NEVER USE'),
		[OptionValue.USE_AGAINST_FIRED_MISSILE]		= _('USE AGAINST FIRED MISSILE'),
		[OptionValue.USE_WHEN_FLYING_IN_SAM_WEZ]	= _('USE WHEN FLYING IN SAM WEZ'),
		[OptionValue.USE_WHEN_FLYING_NEAR_ENEMIES]	= _('USE WHEN FLYING NEAR ENEMIES (N/A)')
	},
	[OptionName.AWARNESS_LEVEL] = {
		[OptionValue.AWARNESS_LEVEL_SAFE]			= _('SAFE'),
		[OptionValue.AWARNESS_LEVEL_AWARE]			= _('AWARE'),
		[OptionValue.AWARNESS_LEVEL_DANGER]			= _('DANGER')
	},
	[OptionName.RTB_ON_OUT_OF_AMMO] = {
	},	
	[OptionName.ECM_USING] = {
		[OptionValue.NEVER_USE]						= _('NEVER USE'),
		[OptionValue.USE_IF_ONLY_LOCK_BY_RADAR]		= _('USE IF ONLY LOCK BY_RADAR'),
		[OptionValue.USE_IF_DETECTED_LOCK_BY_RADAR]	= _('USE IF DETECTED OR LOCK BY RADAR'),
		[OptionValue.ALWAYS_USE]					= _('ALWAYS USE')
	},
	[OptionName.PROHIBIT_AA] = {
	},
	[OptionName.PROHIBIT_JETT] = {
	},
	[OptionName.PROHIBIT_AB] = {
	},
	[OptionName.PROHIBIT_AG] = {
	},
	[OptionName.MISSILE_ATTACK] = {
		[OptionValue.MAX_RANGE]						= _('MAX RANGE LAUNCH'),
		[OptionValue.NEZ_RANGE]						= _('NO ESCAPE ZONE LAUNCH'),
		[OptionValue.HALF_WAY_RMAX_NEZ]				= _('HALF WAY MAX RANGE - NO ESCAPE ZONE LAUNCH'),
		[OptionValue.TARGET_THREAT_EST]				= _('LAUNCH BY TARGET THREAT ESTIMATE'),
		[OptionValue.RANDOM_RANGE]					= _('RANDOM BETWEEN MAX RANGE AND NO ESCAPE ZONE LAUNCH'),
	},
	[OptionName.PROHIBIT_WP_PASS_REPORT] = {
	},
	[OptionName.RADIO_USAGE_CONTACT]={
	},
	[OptionName.RADIO_USAGE_ENGAGE]={
	},
	[OptionName.RADIO_USAGE_KILL]={
	},
	[OptionName.AIRCRAFT_INTERCEPT_RANGE]={
	},
	[OptionName.RESTRICT_TARGET] = {
		[OptionValue.ENGAGE_ALL_UNITS]				= _('ENGAGE ALL UNITS'),
		[OptionValue.ENGAGE_AIR_UNITS_ONLY]			= _('ENGAGE AIR UNITS ONLY'),
		[OptionValue.ENGAGE_GROUND_UNITS_ONLY]		= _('ENGAGE GROUND UNIT ONLY'),
	},
}


--OptionName.RTB_ON_OUT_OF_AMMO
do
	local list = {	weaponTable.noWeapon,
					weaponTable.all,
					weaponTable.unguided,
						weaponTable.cannon,
						weaponTable.rockets,
							weaponTable.lightRockets,
							weaponTable.heavyRockets,
						weaponTable.bombs,
							weaponTable.ironBombs,
							weaponTable.clusterBombs,
							weaponTable.candleBombs,
						weaponTable.Torpedoes,		
					weaponTable.guided,
						weaponTable.guidedBombs,
						weaponTable.missiles,
							weaponTable.ASM,
								weaponTable.ATGM,
								weaponTable.standardASM,
								weaponTable.ARM,
								weaponTable.antiship,
								weaponTable.cruiseMissile,
							weaponTable.AAM,
								weaponTable.SR_AAM,
								weaponTable.MR_AAM,
								weaponTable.LR_AAM }

	for weaponItemIndex, weaponItem in base.pairs(list) do
		base.table.insert(optionValues[OptionName.RTB_ON_OUT_OF_AMMO].list, weaponItem.value)
		optionValueDisplayName[OptionName.RTB_ON_OUT_OF_AMMO][weaponItem.value] = weaponItem.name
	end

end

--OptionName.FORMATION
do	
	optionValues[OptionName.FORMATION] = {
		['plane']		= {
			list = {},
			default = DB.db.Formations['plane'].default
		},
		['helicopter']	= {
			list = {},
			default = DB.db.Formations['helicopter'].default
		},
		['big_formations']	= {
			list = {},
			default = DB.db.Formations['big_formations'].default
		},
	}
	optionValueDisplayName[OptionName.FORMATION] = {}
	for groupType, formations in base.pairs(DB.db.Formations) do
		for index, formation in base.pairs(formations.list) do
			base.table.insert(optionValues[OptionName.FORMATION][groupType].list, formation.WorldID)
			optionValueDisplayName[OptionName.FORMATION][formation.WorldID] = formation.Name
		end
	end
end

local function getEnumOptionDescription(group, wpt, task)
	local actionParams = getActionParams(task)
	local description = task.number..'. '..getActionDataByTask(task).displayName..((actionParams.name and actionParams.value) and ' = '..optionValueDisplayName[actionParams.name][actionParams.value] or '')
	if 	task.name ~= nil and
		base.string.len(task.name) > 0 then
		description = description..' '..task.name
	end
	description = description..printTaskAttrbutes(task)
	return description
end

local function getTargetTypesOptionDescription(group, wpt, task)
	local actionParams = getActionParams(task)
	local description = task.number..'. '..getActionDataByTask(task).displayName..' = '.. (actionParams.value or '')
	if 	task.name ~= nil and
		base.string.len(task.name) > 0 then
		description = description..' '..task.name
	end
	description = description..printTaskAttrbutes(task)
	return description
end

local function getFormationOptionDescription(group, wpt, task)
	local actionParams = getActionParams(task)
	if actionParams == nil then
		return _("Error")
	end

	local description = task.number..'. '..getActionDataByTask(task).displayName
	if actionParams.name and actionParams.value then
		local formationIndex = actionParams.formationIndex or actionParams.value
		description = description..' = '..optionValueDisplayName[actionParams.name][formationIndex]
		local side = {
				[0] = _('right'),
				[1] = _('left'),
		}		
		local formation = DB.db.Formations[group.type].list[formationIndex]
		if formation.zInverse then
			description = description..' '..side[actionParams.zInverse or 0]
		end
		if formation.intervals then
			local intervalIndex = actionParams.intervalIndex or formation.defaultIntervalIndex
			description = description..' '..formation.intervals[intervalIndex].._('m')
		end
	end
	if 	task.name ~= nil and
		base.string.len(task.name) > 0 then
		description = description..' '..task.name
	end
	description = description..printTaskAttrbutes(task)
	return description
end


AerobaticsManeuversData = {
	['STRAIGHT_FLIGHT'] = {
		displayName = _('Straight flight'),
		desc = _('Perform straight flight.'),
		param = {
			FlightTime 			= {value = 10, min_v = 1,max_v = 200, step = 0.1,order = 6,},
		}
	},
	['WINGOVER_FLIGHT'] = {
		displayName = _('Wingover Flight'),
		desc = _('Perform wingover flight.'),
		param = { 
			FlightTime 			= {value = 10, min_v = 1,max_v = 200, step = 0.1,order = 6,},
		}
	},
	['EDGE_FLIGHT'] = {
		displayName = _('Edge Flight'),
		desc = _('Perform flight on edge.'),
		param = { 
			FlightTime 			= {value = 10, min_v = 1,max_v = 200, step = 0.1,order = 6,},
			SIDE				= {value = 0,order = 7,},
		}
	},
	['TURN'] = {
		displayName = _('Turn'),
		desc = _('Perform turn.'),
		param = { 
			Ny_req				= {value = 2,order = 6,},
			ROLL				= {value = 60,order = 7,},
			SECTOR				= {value = 360,order = 8,},
			SIDE				= {value = 0,order = 9,},
		}
	},
	['FORCED_TURN'] = {
		displayName = _('Forced Turn'),
		desc = _('Perform Forced Turn.'),
		param = { 
			SECTOR				= {value = 360,order = 6,},
			SIDE				= {value = 0,order = 7,},
			FlightTime 			= {value = 0, min_v = 0,max_v = 200, step = 0.1,order = 8,},
			MinSpeed			= {value = 250, min_v = 30,max_v = 3000, step = 10.0,order = 9,},
		}
	},
	['LOOP'] = {
		displayName = _('Loop'),
		desc = _('Perform Loop.'),
		param = { 
		}
	},
	['SKEWED_LOOP'] = {
		displayName = _('Skewed Loop'),
		desc = _('Perform Skewed Loop.'),
		param = { 
			ROLL				= {value = 60,order = 6,},
			SIDE				= {value = 0,order = 7,},
		}
	},
	['MILITARY_TURN'] = {
		displayName = _('Military Turn'),
		desc = _('Perform Military Turn.'),
		param = { 
			SIDE				= {value = 0,order = 6,},
		}
	},
	['AILERON_ROLL'] = {
		displayName = _('AILERON_ROLL'),
		desc = _('Perform aileron roll.'),
		param = { 
			SIDE				= {value = 0,order = 6,},
			RollRate			= {value = 90, min_v = 15,max_v = 450, step = 5.0,order = 7,},
			SECTOR				= {value = 360,order = 8,},
			FIXSECTOR			= {value = 0, min_v = 0,max_v = 180, step = 5.0,order = 9,},
		}
	},
	['BARREL_ROLL'] = {
		displayName = _('BARREL_ROLL'),
		desc = _('Perform barrel roll.'),
		param = { 
			SIDE				= {value = 0,order = 6,},
			RollRate			= {value = 90, min_v = 15,max_v = 450, step = 5.0,order = 7,},
			SECTOR				= {value = 360,order = 8,},
		}
	},
	['SPLIT_S'] = {
		displayName = _('SPLIT_S'),
		desc = _('Perform split-s (half barrel and half loop down).'),
		param = { 
			FinalSpeed 			= {value = 500,order = 6,},
		}
	},
	['IMMELMAN'] = {
		displayName = _('IMMELMAN'),
		desc = _('Perform immelman (half loop up and half barrel).'),
		param = { 
		}
	},
	['HUMMERHEAD'] = {
		displayName = _('HUMMERHEAD'),
		desc = _('Perform hummerhead.'),
		param = { 
			SIDE				= {value = 0,order = 6,},
		}
	},
	['CLIMB'] = {
		displayName = _('CLIMB'),
		desc = _('Perform climb.'),
		param = { 
			Angle				= {value = 45, min_v = 15,max_v = 90, step = 5.0,order = 6,},
			FinalAltitude 		= {value = 4000,order = 7,},
		}
	},
	['DIVE'] = {
		displayName = _('DIVE'),
		desc = _('Perform dive.'),
		param = { 
			Angle				= {value = 45, min_v = 15,max_v = 90, step = 5.0,order = 6,},
			FinalAltitude 		= {value = 1000,order = 7,},
		}
	},
	['CANDLE'] = {
		displayName = _('TAILSLIDE'),
		desc = _('Perform tailslide.'),
		param = { 
		}
	},
	['SPIRAL'] = {
		displayName = _('SPIRAL'),
		desc = _('Perform spirals.'),
		param = { 
			SECTOR				= {value = 360,order = 6,},
			ROLL				= {value = 60,order = 7,},
			SIDE				= {value = 0,order = 8,},
			UPDOWN				= {value = 0,order = 9,},
			Angle				= {value = 45, min_v = 5,max_v = 80, step = 5.0,order = 10,},
		}
	},
	['HORIZONTAL_EIGHT'] = {
		displayName = _('Horizontal Eight'),
		desc = _('Perform two different side turns.'),
		param = { 			
			ROLL1				= {value = 60,order = 7,},
			ROLL2				= {value = 60,order = 8,},
			SIDE				= {value = 0,order = 9,},
		}
	},
}

if base.CustomAerobatics then
	for k,v in base.pairs(base.CustomAerobatics) do
		AerobaticsManeuversData[k] = v
	end
end


local function boolToString(value)
	if value then
		return _('on')
	else
		return _('off')
	end
end

local function getFlagOptionDescription(group, wpt, task)
	local actionParams = getActionParams(task)
	local description = task.number..'. '..getActionDataByTask(task).displayName..' = '..boolToString(actionParams.value)
	if 	task.name ~= nil and
		base.string.len(task.name) > 0 then
		description = description..' '..task.name
	end
	description = description..printTaskAttrbutes(task)
	return description
end

local function getNumericOptionDescription(group, wpt, task)
	local actionParams = getActionParams(task)
	local actionOption = optionValues[actionParams.name]
	
	local description
	if actionOption.units == nil then
		description = task.number..'. '..getActionDataByTask(task).displayName..' = '..(actionParams.value ~= nil and base.tostring(actionParams.value) or boolToString(false))
	else
		local unitSystem    = OptionsData.getUnits()
		description = task.number..'. '..getActionDataByTask(task).displayName..' = '..(actionParams.value ~= nil and (base.tostring(base.math.floor(actionParams.value*actionOption.units[unitSystem].coeff+0.5)).." "..actionOption.units[unitSystem].name) or boolToString(false))
	end
	
	if 	task.name ~= nil and
		base.string.len(task.name) > 0 then
		description = description..' '..task.name
	end
	description = description..printTaskAttrbutes(task)
	return description
end

local function declareOption(id, displayName, desc, getDescription, verifyGroupCapability) 
	return {	type = ActionType.OPTION,
				displayName = _(displayName),
				desc = desc,
				getDescription = getDescription,
				verifyGroupCapability = verifyGroupCapability,
				task = makeWrappedAction('Option', { name = id })	}
end

local function declareEnumOption(id, displayName, desc)
	return {	type = ActionType.OPTION,
				displayName = _(displayName),
				desc = desc,
				getDescription = getEnumOptionDescription,
				task = makeWrappedAction('Option', { name = id })	}
end

local function declareTargetTypesOption(id, displayName, desc)
	return {	type = ActionType.OPTION,
				displayName = _(displayName),
				desc = desc,
				getDescription = getTargetTypesOptionDescription,
				task = makeWrappedAction('Option', { name = id })	}
end

local function declareFlagOption(id, displayName, desc, defaultValue)
	return {	type = ActionType.OPTION,
				displayName = _(displayName),
				desc = desc,
				getDescription = getFlagOptionDescription,
				task = makeWrappedAction('Option', { name = id, value = defaultValue })	}
end

local function declareNumericOption(id, displayName, desc, defaultValue, verifyGroupCapability)
	return {	type = ActionType.OPTION,
				displayName = _(displayName),
				desc = desc,
				getDescription = getNumericOptionDescription,
				verifyGroupCapability = verifyGroupCapability,
				task = makeWrappedAction('Option', { name = id, value = defaultValue})	}
end

local function getGroupDescription(group, wpt, task)
	local actionParams = getActionParams(task)
	local group = actionParams.groupId and base.module_mission.group_by_id[actionParams.groupId]
	return printActionId(task)..(group and '(\"'..group.name..'\")' or _('(nothing)'))..printActionName(task)..' '..printTaskAttrbutes(task)
end

local function isNoGroup(task)
	local actionParams = getActionParams(task)
	local group = actionParams.groupId and base.module_mission.group_by_id[actionParams.groupId]
	return group == nil
end

local function isNoZone(task)
	local actionParams = getActionParams(task)
	local zone = actionParams.zoneId and TriggerZoneController.getTriggerZone(actionParams.zoneId)
	return zone == nil
end

function isNoFullTask(task)
	local actionData = getActionDataByTask(task)
	if actionData == nil then
		return nil
	end
	local result = false
	
	if actionData.isNoGroup ~= nil then
		result = result or actionData.isNoGroup(task)
	end
	
	if actionData.isNoZone ~= nil then
		result = result or actionData.isNoZone(task)
	end

	return result
end

local function getTransportDescription(group, wpt, task)
	local actionParams = getActionParams(task)
	local strGroups
	for k,v in base.pairs(actionParams.groupsForEmbarking) do
		if strGroups then
			strGroups = strGroups..", "
		else
			strGroups = '(\"'
		end
		local group = base.module_mission.group_by_id[v]
		strGroups = strGroups..(group and group.name or '')
	end
	if strGroups then
		strGroups = strGroups..'\")'
	end	
	return printActionId(task)..(strGroups or "")
end

local function getUnitDescription(group, wpt, task)
	local actionParams = getActionParams(task)
	local unit = actionParams.unitId and base.module_mission.unit_by_id[actionParams.unitId]
	return printActionId(task)..(unit and '(\"'..unit.name..'\")' or _('(nothing)'))..printActionName(task)..' '..printTaskAttrbutes(task)
end

local function getCallName(group, callsignId)
	local unitType = group.units[1].type
	local callsigns =	DB.db.getCallnames(group.boss.id, unitType) or		
						DB.db.getUnitCallnames(group.boss.id, DB.unit_by_type[unitType].attribute)
	if callsigns ~= nil then
		for i, v in base.pairs(callsigns) do
			if callsignId == v.WorldID then
				return v.Name
			end
		end
	end
	return ''
end

function getBoolValueDescription(group, wpt, task)
	local actionParams = getActionParams(task)
	return printActionId(task)..('('..boolToString(actionParams.value or actionParams.flag)..')')..printActionName(task)..' '..printTaskAttrbutes(task)
end	

local function isWesternCountry(group, wpt)
	if U.isWesternCountry(group.boss and group.boss.name) then
		return nil
	else
		return _('It is not a western country')
	end
end

actionsData = {
	--ActionType.TASK
	[ActionId.NO_TASK] = {
		type = ActionType.TASK,
		displayName = _('No Task'),
		desc = _('Empty task'),
		task = {
			id = 'NoTask',
			params = {}
		}
	},
	[ActionId.ATTACK_GROUP] = {
		type = ActionType.TASK,
		displayName = _('Attack Group'),
		desc = _('Attack the enemy group'),
		getDescription = getGroupDescription,
		task = {
			id = 'AttackGroup',
			params = {
				groupId = nil,
				weaponType = nil,
				groupAttack = false,
				attackQtyLimit = false,
				attackQty = 1
			}				
		}
	},
	[ActionId.ATTACK_UNIT] = {
		type = ActionType.TASK,
		displayName = _('Attack Unit'),
		desc = _('Attack the enemy unit or the enemy static object'),
		getDescription = getUnitDescription,
		task = {
			id = 'AttackUnit',
			params = {
				unitId = nil,
				weaponType = nil,
				groupAttack = false,
				attackQtyLimit = false,
				attackQty = 1
			}
		}
	},
	[ActionId.ATTACK_MAP_OBJECT] = {
		type = ActionType.TASK,
		displayName = _('Attack Map Object'),
		desc = _('Attack the map object'),
		task = {
			id = 'AttackMapObject',
			params = {
				weaponType = nil,
				groupAttack = false,
				attackQtyLimit = true,
				attackQty = 1				
			}
		}
	},
	[ActionId.BOMBING] = {
		type = ActionType.TASK,
		displayName = _('Bombing'),
		desc = _('Deliver weapon at the point on the ground'),
		task = {	
			id = 'Bombing',
			params = {
				weaponType 		= nil,
				groupAttack 	= false,
				attackQtyLimit 	= false,
				attackQty 		= 1,
				attackType		= nil
			}
		}
	},
	[ActionId.BOMBING_RUNWAY] = {
		type = ActionType.TASK,
		displayName = _('Bombing Runway'),
		desc = _('Deliver weapon at the runway'),
		task = {	
			id = 'BombingRunway',
			params = {
				weaponType = nil,
				groupAttack = true,
				attackQtyLimit = false,
				attackQty = 1
			}
		}
	},
	[ActionId.ORBIT] = {
		type = ActionType.TASK,
		displayName = _('Orbit'),
		desc = _('Fly orbit'),
		getDescription = function(group, wpt, task)
			local actionParams  = getActionParams(task)		
			local unitSystem    = OptionsData.getUnits()
            local WptAlt        = (wpt and wpt.alt) or 2000
			
			local altitudeDisplayed = base.math.floor(U.altitudeUnits[unitSystem].coeff * (actionParams.altitude or WptAlt) + 0.5)
			return printActionId(task)..'(H = '..(not actionParams.altitudeEdited and 'Hwpt = ' or '')..altitudeDisplayed..' '..U.altitudeUnits[unitSystem].name..')'..printActionName(task)..' '..printTaskAttrbutes(task)
		end,
		task = {	
			id = 'Orbit',
			params = {
				pattern = nil,
			}
		}
	},	
	[ActionId.LAND] = {
		type = ActionType.TASK,
		displayName = _('Land'),
		desc = _('Land on the ground temporary'),
		task = {	
			id = 'Land',
			params = {
				durationFlag = false,
				duration = 5 * 60 + 0
			}
		}
	},
	[ActionId.REFUELING] = {
		type = ActionType.TASK,
		displayName = _('Refueling'),
		desc = _('Refuel from a tanker'),
		task = {	
			id = 'Refueling',
			params = {
			}
		},
		verifyGroupCapability = function(group)
			local unitDesc = DB.unit_by_type[group.units[1].type]
			if DB.findAttribute(unitDesc.attribute, "Refuelable") then
				return nil
			else
				return "\""..unitDesc.Name.."\"".._("has no aerial refueling capabilities")
			end
		end		
	},
	[ActionId.FAC_ATTACK_GROUP] = {
		type = ActionType.TASK,
		displayName = _('FAC - Attack Group'),
		desc = _('Make the lead unit of the group FAC and assign it the target to designate'),
		getDescription = getGroupDescription,
		verifyGroupCapability = isWesternCountry,
		task = {	
			id = 'FAC_AttackGroup',
			params = {
				groupId = nil,
				weaponType = nil
			}
		}
	},		
	[ActionId.FIRE_AT_POINT] = {
		type = ActionType.TASK,
		displayName = _('Fire at Point'),
		desc = _('Fire at point'),
		task = {	
			id = 'FireAtPoint',
			params = {
				zoneRadius = 0,
				templateId = '',
				expendQtyEnabled = false,
				expendQty = 1,
				altitude = nil, -- по дефолту высота не задается
				alt_type = 1 -- по дефолту высота от земли
			}
		}
	},
	[ActionId.HOLD] = {
		type = ActionType.TASK,
		displayName = _('Hold'),
		desc = _('Stop moving'),
		task = {	
			id = 'Hold',
			params = {
				templateId = '',
			}
		}
	},
	[ActionId.FOLLOW] = {
		type = ActionType.TASK,
		displayName = _('Follow'),
		desc = _('Follow the another group'),
		getDescription = getGroupDescription,
		task = {	
			id = 'Follow',
			params = {
				pos = {
					x = -500,   --Distance
					y = 0,      --Elevation
					z = 200,    --Interval
				},
				lastWptIndexFlag = true,
				lastWptIndexFlagChangedManually = true,
				lastWptIndex = nil
			}
		}
	},	
	[ActionId.ESCORT] = {
		type = ActionType.TASK,
		displayName = _('Escort'),
		desc = _('Escort the another group: follow it and protect it from specific types of threats'),
		getDescription = getGroupDescription,
		task = {	
			id = 'Escort',
			params = {
				pos = {
					x = -500,   --Distance
					y = 0,      --Elevation
					z = 200,    --Interval
				},
				lastWptIndexFlag = true,
				lastWptIndexFlagChangedManually = true,
				lastWptIndex = nil,
				engagementDistMax = 60000,
				targetTypes = {
					'Planes',
					--'Ground Units',	-- https://jira.eagle.ru/browse/ASSETS-1723 TODO! make default target types selected for helicopters
				},				
			}
		}
	},	
	[ActionId.EMBARK_TO_TRANSPORT] = {
		type = ActionType.TASK,
		displayName = _('Embark to transport'),
		desc = _('Embark to transport'),		
		task = {	
			id = 'EmbarkToTransport',
			params = {
				zoneRadius = 200,
			}
		},
		
		verifyGroupCapability = function(group)
			for k,v in base.pairs(group.units) do
				local unitDesc = DB.unit_by_type[v.type]
				if (unitDesc.attribute == nil) or (not DB.findAttribute(unitDesc.attribute, "Infantry")) then
					return "\""..unitDesc.Name.."\"".._("has no embark to transport capabilities")
				end
			end
			
			return nil
		end,
	},
	[ActionId.GO_TO_WAYPOINT] = {
		type = ActionType.TASK,
		displayName = _('go to waypoint', 'Go to waypoint'),
		desc = _('go to waypoint', 'Go to waypoint'),
		task = {	
			id = 'GoToWaypoint',
			params = {
			}
		}
	},
	[ActionId.EMBARKING] = {
		type = ActionType.TASK,
		displayName = _('Embarking'),
		desc = _('Embarking'),
		getDescription = getTransportDescription,
		task = {	
			id = 'Embarking',
			params = {
				durationFlag = false,
				distributionFlag = false,
				duration = 5 * 60,
				groupsForEmbarking={},
				distribution={},
				onStartMission = false,
			}
		},
		
		verifyGroupCapability = function(group)
			for k,v in base.pairs(group.units) do
				local unitDesc = DB.unit_by_type[v.type]
				if not unitDesc.InternalCargo then
					return "\""..unitDesc.Name.."\"".._("has no embarking capabilities")
				end
			end
			
			return nil
		end,
	},
	[ActionId.DISEMBARKING] = {
		type = ActionType.TASK,
		displayName = _('Disembarking'),
		desc = _('Disembarking'),
		getDescription = getTransportDescription,
		task = {	
			id = 'Disembarking',
			params = {
				x,
				y,
				groupsForEmbarking={},
			},
		},
		
		verifyGroupCapability = function(group)
			for k,v in base.pairs(group.units) do
				local unitDesc = DB.unit_by_type[v.type]
				if not unitDesc.InternalCargo then
					return "\""..unitDesc.Name.."\"".._("has no disembarking capabilities")
				end
			end
			
			return nil
		end,
	},
	
	[ActionId.ATTACH_TRAILER]	= {
		type = ActionType.TASK,
		displayName = _('Attach trailer'),
		desc = _('Select a trailer unit to attach to a tractor.'),		
		getDescription = function(group, wpt, task)
			local actionParams  = getActionParams(task)	
			local nameTractor = (actionParams.unitIdTractor and base.module_mission.unit_by_id[actionParams.unitIdTractor] and base.module_mission.unit_by_id[actionParams.unitIdTractor].name)
			local nameTrailer = (actionParams.unitIdTrailer and base.module_mission.unit_by_id[actionParams.unitIdTrailer] and base.module_mission.unit_by_id[actionParams.unitIdTrailer].name)
			return printActionId(task).."("..(nameTractor or "").." + ".. (nameTrailer or "")  ..")"								
		end,
		task = {	
			id = 'AttachTrailer',
			params = {
				onStartMission = false,
			},
		},
		

		verifyGroupCapability = function(group)
			local isTow = false
			for k, v in base.pairs(group.units) do
				local unitDesc = DB.unit_by_type[v.type]
				if unitDesc.canTow then
					isTow = true
				end
			end
			
			if isTow == true then
				return nil
			else
				return "\""..group.name.."\"".._("has no tow")
			end
		end
	},	
	
	[ActionId.DETACH_TRAILER]	= {
		type = ActionType.TASK,
		displayName = _('Detach trailer'),
		desc = _('Select a unit to detach from a tractor.'),		
		getDescription = function(group, wpt, task)
			local actionParams  = getActionParams(task)	
			local nameTractor = (actionParams.unitIdTractor and base.module_mission.unit_by_id[actionParams.unitIdTractor] and base.module_mission.unit_by_id[actionParams.unitIdTractor].name)	
			return printActionId(task).."("..(nameTractor or "")..")"									
		end,
		task = {	
			id = 'DetachTrailer',
			params = {
				x,
				y,
			--	direction = 0,
			},
		},
		

		verifyGroupCapability = function(group)
			local isTow = false
			for k, v in base.pairs(group.units) do
				local unitDesc = DB.unit_by_type[v.type]
				if unitDesc.canTow then
					isTow = true
				end
			end
			
			if isTow == true then
				return nil
			else
				return "\""..group.name.."\"".._("has no tow")
			end
		end
	},		
							
	[ActionId.CARGO_TRANSPORTATION] = {
		type = ActionType.TASK,
		displayName = _('Cargo Transportation'),
		desc = _('Cargo transportaion in zone'),
		isNoGroup = isNoGroup,
		isNoZone = isNoZone,
		task = {
			id = 'CargoTransportation',
			params = {
				groupId = nil,
				zoneId = nil,
			}				
		},
		verifyGroupCapability = function(group, wpt)
			local unitDesc = DB.unit_by_type[group.units[1].type]

			if unitDesc.helicopter_hook_pos == nil then
				return _("Cargo transportation can not be assigned to").." \""..unitDesc.Name.."\""
			end
						
			return nil
		end,				
	},
	[ActionId.CARGO_TRANSPORTATION_PLANE] = {
		type = ActionType.TASK,
		displayName = _('Cargo Transportation'),
		desc = _('Cargo transportaion'),
		isNoGroup = isNoGroup,
		task = {
			id = 'CargoTransportationPlane',
			params = {
				groupId = nil,
			}				
		},
		verifyGroupCapability = function(group, wpt)
			if wpt ~= nil and base.panel_route.isTakeOff(wpt.type) ~= true then
				return _("The waypoint is not set as a take-off position")
			end
			
			for k,v in base.pairs(group.units) do
				local unitDesc = DB.unit_by_type[v.type]
				if not (unitDesc.openRamp == 1 or DB.findAttribute(unitDesc.attribute, 'Transports')) then
					return _("Cargo transportation can not be assigned to").." \""..unitDesc.Name.."\""
				end
			end
			
			return nil
		end,		
	},
	[ActionId.CARGO_UNLOAD_PLANE] = {
		type = ActionType.TASK,
		displayName = _('Cargo Unload'),
		desc = _('Cargo Unload'),
		isNoGroup = isNoGroup,
		task = {
			id = 'CargoUnloadPlane',
			params = {
				groupId = nil,
			}				
		},
		verifyGroupCapability = function(group)
			for k,v in base.pairs(group.units) do
				local unitDesc = DB.unit_by_type[v.type]
				if not (unitDesc.openRamp == 1 or DB.findAttribute(unitDesc.attribute, 'Transports')) then
					return _("Cargo transportation can not be assigned to").." \""..unitDesc.Name.."\""
				end
			end
			
			return nil
		end,		
	},	
	[ActionId.AEROBATICS] = {
		type = ActionType.TASK,
		displayName = _('Aerobatics'),
		desc = _('Perform aerobatics maneuvers'),
		getDescription = function(group, wpt, task)
			local actionParams  = getActionParams(task)		
			local unitSystem    = OptionsData.getUnits()
            local WptAlt        = (wpt and wpt.alt) or 2000
			
			local altitudeDisplayed = base.math.floor(U.altitudeUnits[unitSystem].coeff * (actionParams.altitude or WptAlt) + 0.5)
			return printActionId(task)..'(H = '..(not actionParams.altitudeEdited and 'Hwpt = ' or '')..altitudeDisplayed..' '..U.altitudeUnits[unitSystem].name..')'..printActionName(task)..' '..printTaskAttrbutes(task)
		end,
		task = {	
			id = 'Aerobatics',
			params = {
				
			}
		}
	},
	[ActionId.CARPET_BOMBING] = {
		type = ActionType.TASK,
		displayName = _('Carpet bombing'),
		desc = _('Perform large formation bombing'),
		getDescription = function(group, wpt, task)
			local actionParams  = getActionParams(task)		
			local unitSystem    = OptionsData.getUnits()
            local WptAlt        = (wpt and wpt.alt) or 2000
			
			local altitudeDisplayed = base.math.floor(U.altitudeUnits[unitSystem].coeff * (actionParams.altitude or WptAlt) + 0.5)
			return printActionId(task)..'(H = '..(not actionParams.altitudeEdited and 'Hwpt = ' or '')..altitudeDisplayed..' '..U.altitudeUnits[unitSystem].name..')'..printActionName(task)..' '..printTaskAttrbutes(task)
		end,
		task = {	
			id = 'CarpetBombing',
			params = {
				weaponType = weaponTable.ironBombs,
				groupAttack = false,
				attackQtyLimit = false,
				attackQty = 1,
				carpetLength = 500.0,
				attackType   = 'Carpet'
			}
		}
	},
	[ActionId.WW2_BIG_FORMATION] = {
		type = ActionType.TASK,
		displayName = _('Big formation'),
		desc = _('Follow as big formation'),
		getDescription = getGroupDescription,
		isNoGroup = isNoGroup,
		task = {	
			id = 'FollowBigFormation',
			params = {
				pos = {
					x = -150,   --Distance
					y = 0,      --Elevation
					z = 150,    --Interval
				},
				lastWptIndexFlag = true,
				lastWptIndexFlagChangedManually = true,
				lastWptIndex = nil,
				formationType = 0,-- 0 = 1943 style Combat Box, 1 = 1942 JAVELIN DOWN
				posInBox = 1,	-- 1 = Above(right above), 2 = Low(low left), 3 = LowLow(low behind), 0 - лидер
				posInGroup = 1,	-- 1 = left, 2 = right, 0 - лид.
				posInWing = 1  -- 1 = left, 2 = right,0 - лидирующая группа
			}
		}
	},	
	[ActionId.GROUND_ESCORT] = {
		type = ActionType.TASK,
		displayName = _('Ground Escort'),
		desc = _('Escort the ground vehicle group: follow it and protect it from specific types of threats'),
		getDescription = getGroupDescription,
		task = {	
			id = 'GroundEscort',
			params = {
				--[[pos = {
					x = -500,   --Distance
					y = 0,      --Elevation
					z = 200,    --Interval
				},]]--
				lastWptIndexFlag = true,
				lastWptIndexFlagChangedManually = true,
				lastWptIndex = nil,
				engagementDistMax = 500,
				targetTypes = {
					'Helicopters',
					'Ground Units'
				},				
			}
		}
	},	
	[ActionId.PARATROOPERS_DROP] = {
		type = ActionType.TASK,
		displayName = _('Drop of paratroopers'),
		desc = _('Perform paratroopers drop at target'),
		getDescription = function(group, wpt, task)
			local actionParams  = getActionParams(task)		
			local unitSystem    = OptionsData.getUnits()
            local WptAlt        = (wpt and wpt.alt) or 2000
			
			local altitudeDisplayed = base.math.floor(U.altitudeUnits[unitSystem].coeff * (actionParams.altitude or WptAlt) + 0.5)
			return printActionId(task)..'(H = '..(not actionParams.altitudeEdited and 'Hwpt = ' or '')..altitudeDisplayed..' '..U.altitudeUnits[unitSystem].name..')'..printActionName(task)..' '..printTaskAttrbutes(task)
		end,
		task = {	
			id = 'ParatroopersDrop',
			params = {
				groupAttack = false,
				attackQtyLimit = false,
				attackQty = 1,
				carpetLength = 500.0,
				attackType   = 'Carpet',
				scriptFileName = '',
				groupsOnBoard ={},				
			}
		},

	},	
	
	--ActionType.ENROUTE_TASK
	[ActionId.NO_ENROUTE_TASK] = {
		type = ActionType.ENROUTE_TASK,
		displayName = _('No Enroute Task'),
		desc = _('Empty task'),
		task = {
			id = 'NoTask',
			params = {}
		}
	},
	[ActionId.ENGAGE_TARGETS] = {
		type = ActionType.ENROUTE_TASK,
		displayName = _('Engage Targets'),
		desc = _('Engage targets of specific types along the route'),
		task = {
			id = 'EngageTargets',
			params = {
				maxDistEnabled = false,
				maxDist = 15000
			}
		}
	},
	[ActionId.ENGAGE_TARGETS_IN_ZONE] = {
		type = ActionType.ENROUTE_TASK,
		displayName = _('Engage Targets In Zone'),
		desc = _('Engage targets of specific types in the given zone'),
		task = {
			id = 'EngageTargetsInZone',
			params = {
				zoneRadius = 5000
			}
		}
	},
	[ActionId.ENGAGE_GROUP] = {
		type = ActionType.ENROUTE_TASK,
		displayName = _('Engage Group'),
		desc = _('Allow the group to engage the enemy group during the mission'),
		getDescription = getGroupDescription,
		task = {
			id = 'EngageGroup',
			params = {
				groupId = nil,
				weaponType = nil,
				priority = 1
			}				
		}
	},
	[ActionId.ENGAGE_UNIT] = {
		type = ActionType.ENROUTE_TASK,
		displayName = _('Engage Unit'),
		desc = localization.allowGroup,
		getDescription = getUnitDescription,		
		task = {
			id = 'EngageUnit',
			params = {
				unitId = nil,
				weaponType = nil,
				priority = 1,
				groupAttack = false,
				attackQtyLimit = false,
				attackQty = 1				
			}
		}
	},
	[ActionId.AWACS] = {
		type = ActionType.ENROUTE_TASK,
		displayName = _('AWACS'),
		desc = _('Make the lead aircraft of the group AWACS'),
		task = {
			id = 'AWACS',
			params = {
			}
		}
	},
	[ActionId.EWR] = {
		type = ActionType.ENROUTE_TASK,
		displayName = _('EWR'),
		desc = _('Make the lead aircraft of the group EWR'),
		task = {
			id = 'EWR',
			params = {
			}
		},
		verifyGroupCapability = function(group)
			local unitDesc = DB.unit_by_type[group.units[1].type]
			if unitDesc.EWR then
				return nil
			else
				return "\""..unitDesc.Name.."\"".._("is not EWR")
			end			
		end
	},	
	[ActionId.TANKER] = {
		type = ActionType.ENROUTE_TASK,
		displayName = _('Tanker'),
		desc = _('Make the lead aircraft of the group a tanker'),
		task = {
			id = 'Tanker',
			params = {
			}
		}
	},
	[ActionId.FAC] = {
		type = ActionType.ENROUTE_TASK,
		displayName = _('FAC'),
		desc = _('Make the lead aircraft of the a FAC and let it to choose targets to assign by its own'),
		task = {
			id = 'FAC',
			params = {
			}
		},
		verifyGroupCapability = isWesternCountry,
	},
	[ActionId.FAC_ENGAGE_GROUP] = {
		type = ActionType.ENROUTE_TASK,
		displayName = _('FAC - Engage Group'),
		desc = _('Make the lead aircraft of the group FAC and allow it to assign the enemy group'),
		task = {
			id = 'FAC_EngageGroup',
			params = {
			}
		},
		verifyGroupCapability = isWesternCountry,
	},
	[ActionId.FIGHTER_SWEEP] = {
		type = ActionType.ENROUTE_TASK,
		displayName = _('Fighter Sweep'),
		desc = _('Engage enemy aircraft. Enemy fighters are prioritiest targets'),
		task = {
			id = 'EngageTargets',
			key = 'FighterSweep',
			params = {
				targetTypes = {
					'Planes'
				},
				priority = 0
			}
		}
	},
	[ActionId.CAS] = {
		type = ActionType.ENROUTE_TASK,
		displayName = _('CAS'),
		desc = _('Engage enemy ground forces'),
		task = {
			id = 'EngageTargets',
			key = 'CAS',
			params = {
				targetTypes = {
					'Helicopters',
					'Ground Units',
					'Light armed ships'
				},
				priority = 0
			}
		}
	},
	[ActionId.CAP] = {
		type = ActionType.ENROUTE_TASK,
		displayName = _('CAP'),
		desc = _('Engage enemy aircraft'),
		task = {
			id = 'EngageTargets',
			key = 'CAP',
			params = {
				targetTypes = {
					'Air',
				},
				priority = 0
			}
		}
	},
	[ActionId.SEAD] = {
		type = ActionType.ENROUTE_TASK,
		displayName = _('SEAD'),
		desc = _('Engage enemy air defense'),
		task = {
			id = 'EngageTargets',
			key = 'SEAD',
			params = {
				targetTypes = {
					'Air Defence',
				},
				priority = 0
			}
		}
	},
	[ActionId.ANTI_SHIP] = {
		type = ActionType.ENROUTE_TASK,
		displayName = _('Anti-Ship'),
		desc = _('Engage enemy ships'),
		task = {
			id = 'EngageTargets',
			key = 'AntiShip',
			params = {
				targetTypes = {
					'Ships',
				},
				priority = 0
			}
		}
	},	
	
	[ActionId.SHIP_HOLD_POINT] = {
	type = ActionType.TASK,
		displayName = _('Hold'),
		desc = _('Stop moving'),
		task = {	
			id = 'ShipHoldPoint',
			params = {
			}
		}
	},	
	[ActionId.RECOVERY_TANKER] = {
		type = ActionType.TASK,
		displayName = _('Recovery tanker'),
		desc = _('Follow carrier with race track pattern awaiting AAR clients'),
		--getDescription = getGroupDescription,
		getDescription = function(group, wpt, task)
			local actionParams  = getActionParams(task)		
			local unitSystem    = OptionsData.getUnits()
            local WptAlt        = (wpt and wpt.alt) or 2000
			
			local altitudeDisplayed = base.math.floor(U.altitudeUnits[unitSystem].coeff * (actionParams.altitude or WptAlt) + 0.5)
			return printActionId(task)..'(H = '..(not actionParams.altitudeEdited and 'Hwpt = ' or '')..altitudeDisplayed..' '..U.altitudeUnits[unitSystem].name..')'..printActionName(task)..' '..printTaskAttrbutes(task)
		end,
		task = {	
			id = 'RecoveryTanker',
			params = {
				lastWptIndexFlag = true,
				lastWptIndexFlagChangedManually = true,
				lastWptIndex = nil,
				targetTypes = {
					'Ships',
				},				
			}
		}
	},	
	--ActionType.COMMAND
	[ActionId.NO_ACTION]		= declareCommand(
										'NoAction',
										_('No Action'),
										_('Empty command')
									),
	[ActionId.SCRIPT]			= declareCommand(
										'Script',
										_('Script'),
										_('Run lua script. The group will be passed as a single parameter to the function.'),
										{
											command = '' 
										},
										nil,
										nil,
										function(group, wpt, actionData, actionParams)
											if actionParams ~= nil then
												local errorMsg = U.verifyLuaString(actionParams.command)
												if errorMsg ~= nil then
													return errorMsg
												end
											end
											return nil
										end
									),
	[ActionId.SCRIPT_FILE]		= declareCommand(
										'ScriptFile',
										_('Script File'),
										_('Run lua script file. The group will be passed as a single parameter to the function.'),
										{ file = '' },
										function(group, wpt, task)
											local actionParams = getActionParams(task)
                                            local fileName = mod_dictionary.getValueResource(actionParams.file) or ""
											return printActionId(task)..('(\"'..fileName..'\")')..printActionName(task)..' '..printTaskAttrbutes(task)
										end,		
										nil,
										function(group, wpt, actionData, actionParams)
											if actionParams ~= nil and
												actionParams.file ~= nil and 
                                                mod_dictionary.getValueResource(actionParams.file) ~= "" and
												base.string.len(actionParams.file) > 0 then
                                                local tmp, path = mod_dictionary.getValueResource(actionParams.file)
												if path then
													local fullPath = base.tempMissionPath .. path
													local errorMsg = U.verifyLuaFile(fullPath)
													if errorMsg ~= nil then
														return errorMsg
													end
												end
											end
											return nil
										end,
										nil,
										function(group, wpt, task)
											local actionParams = getActionParams(task)
											mod_dictionary.removeResource(actionParams.file)
										end	
									),
	[ActionId.SET_CALLSIGN]		= declareCommand(
										'SetCallsign',
										_('Set Callsign'),
										_('Set callname and group number to the group.'),
										nil,
										function(group, wpt, task)
											local actionParams = getActionParams(task)
											local callsignStr = ''
											if U.isWesternCountry(group.boss.name) then
												local callsign = getCallName(group, actionParams.callname)..' '..(actionParams.number or '')
												callsignStr = '\"'..callsign..'\"'
											else
												callsignStr = base.tostring(actionParams.callsign)
											end
											return printActionId(task)..'('..callsignStr..printActionName(task)..') '..printTaskAttrbutes(task)
										end,
										nil,
										nil,
										function(group)
											if U.isWesternCountry(group.boss.name) then
												return { callnameFlag = true, callname = 1, number = 1 }
											else
												return { callnameFlag = false, callsign = 500 }
											end
										end
									),
	[ActionId.SET_FREQUENCY]	= declareCommand(
										'SetFrequency',
										_('Set Frequency'),										
										_('Set frequency to radios of all the units in the group.'),
										{
											frequency = 131000000.0,
											modulation = 0,
                                            power = 10,
										},
										function(group, wpt, task)
											local actionParams = getActionParams(task)
											return printActionId(task)..('('..(actionParams.frequency / 1000000)..')')..printActionName(task)..' '..printTaskAttrbutes(task)
										end
									),
	[ActionId.SET_FREQUENCYFORUNIT]	= declareCommand(
										'SetFrequencyForUnit',
										_('Set Frequency for unit'),										
										_('Set frequency to radios to the unit'),
										{
											frequency = 131000000.0,
											modulation = 0,
                                            power = 10,
										},
										function(group, wpt, task)
											local actionParams = getActionParams(task)
											return printActionId(task)..('('..(actionParams.frequency / 1000000)..')')..printActionName(task)..' '..printTaskAttrbutes(task)
										end
									),
	[ActionId.TRANSMIT_MESSAGE] = declareCommand(
										'TransmitMessage',
										_('Transmit Message'),
										_('Start radio transmission from the lead unit of the group'),
										{ file = '', subtitle = '', loop = false, duration = 5.0 },
										function(group, wpt, task)
											local actionParams = getActionParams(task)
                                            local fileName = mod_dictionary.getValueResource(actionParams.file) or ""
											return printActionId(task)..('(\"'..fileName..'\", \"'..(actionParams.subtitle or "")..'\", '..boolToString(actionParams.loop)..')')..printActionName(task)..' '..printTaskAttrbutes(task)
										end,
										nil, nil, nil,
										function(group, wpt, task)
											local actionParams = getActionParams(task)
											mod_dictionary.removeResource(actionParams.file)
										end
									),
	[ActionId.STOP_TRANSMISSION] = declareCommand(
										'StopTransmission',
										_('Stop Transmission'),
										_('Stop the radio transmission from the lead unit of the group')
									),
	[ActionId.SWITCH_WAYPOINT]	= declareCommand(
										'SwitchWaypoint',
										_('Switch Waypoint'),
										_('Switch current waypoint of the route.'),										
										nil,
										function(group, wpt, task)
											local actionParams = getActionParams(task)
                                            local nameWpt1 = actionParams.fromWaypointIndex
                                            local nameWpt2 = actionParams.goToWaypointIndex
                                            if (actionParams.fromWaypointIndex) then
                                                nameWpt1 = mission.reNameWaypointsAction(nameWpt1, actionParams.fromWaypointIndex, #group.route.points, group.boss.name)
                                            end
                                            if (actionParams.goToWaypointIndex) then
                                                nameWpt2 = mission.reNameWaypointsAction(nameWpt2, actionParams.goToWaypointIndex, #group.route.points, group.boss.name)
                                            end
											return printActionId(task)..('('..(nameWpt1 or '<current>')..' - '..nameWpt2..')')..printActionName(task)..' '..printTaskAttrbutes(task)
										end
									),
	[ActionId.SWITCH_ITEM]		= declareCommand(
										'SwitchAction',
										_('Switch Action'),
										_('Jump to another action in the action list of the waypoint.'),
										{
											actionIndex = 1
										},
										function(group, wpt, task)
											local actionParams = getActionParams(task)
											return printActionId(task)..('('..(actionParams.actionIndex or '?')..')')..printActionName(task)..' '..printTaskAttrbutes(task)
										end,
										nil,
										function(group, wpt)
											return wpt ~= nil
										end
									),
	[ActionId.INVISIBLE]		= declareCommand(
										'SetInvisible',
										_('Invisible'),
										_('Make all units of the group invisible.'),
										{ value = true },
										getBoolValueDescription
									),
	[ActionId.IMMORTAL]			= declareCommand(
										'SetImmortal',
										_('Immortal'),
										localization.groupImmortal,
										{ value = true },
										getBoolValueDescription
									),
	[ActionId.START]			= declareCommand(
										'Start',
										_('Start'),
										_('Start the assigned task.'),
										nil,
										nil,
										nil, 
										function(group, wpt)
											if wpt == nil then
												return nil
											else
												return _('Not available for waypoint action.')
											end
										end
									),
	[ActionId.LOADING_SHIP]	= declareCommand(	
										'LoadingShip',
										_("Set the ship's draft"),
										_('This command changes the visual waterline level of the ship'),
										{
											cargo = 0,
										},
										function(group, wpt, task)
											local actionParams = getActionParams(task)
											local unitDesc
											local unitName 
											local unit 
											
											if actionParams.unitId then
												unit = base.module_mission.unit_by_id[actionParams.unitId]
												if unit then
													unitDesc = DB.unit_by_type[unit.type]
													unitName = unit.name
												end	
											end	
				
											return printActionId(task)..'('..'Unit "'..(unitName or '')..'") '..' '..(actionParams.cargo or '')..'%'

										end,
										'LoadingShip',
										function(group)
											local isEnableLoading = false
											for k, v in base.pairs(group.units) do
												local unitDesc = DB.unit_by_type[v.type]
												if unitDesc.deltaWaterline ~= nil then
													isEnableLoading = true
												end
											end

											if isEnableLoading == true then
												return nil
											else
												return "\""..group.name.."\"".._("has no loading")
											end
										end
									),	
	[ActionId.ACTIVATE_TACAN]	= declareCommand(
										'ActivateBeacon',
										_('Activate TACAN'),
										_('Activate TACAN beacon onboard of the group lead unit. Only one beacon is available.'),
										{
											type = 4,
											system = 4,
											bearing = true,
											modeChannel = 'X',
											channel = 1,
											AA = true,
											frequency = 1000000 * calcTACANFrequencyMHz(true, 'X', 1),
											callsign = 'TKR'
										},
										function(group, wpt, task)
											local actionParams = getActionParams(task)
											local unitDesc
											local unitName 
											local unit 
											
											if actionParams.unitId then
												unit = base.module_mission.unit_by_id[actionParams.unitId]
												if unit then
													unitDesc = DB.unit_by_type[unit.type]
													unitName = unit.name
												end	
											end	

											if unit then
												if unitDesc.TACAN_AA == true then
													return printActionId(task)..'('..(actionParams.channel or '')..(actionParams.modeChannel or '')..', "'..(actionParams.callsign or '')..'", Unit "'..(unitName or '')..'") '..printActionName(task)..' '..printTaskAttrbutes(task)
												else
													return printActionId(task)..'('..(actionParams.bearing and _('BRG')..' ' or '')..', '..(actionParams.channel or '')..(actionParams.modeChannel or '')..', "'..(actionParams.callsign or '')..'", Unit "'..(unitName or '')..'") '..printActionName(task)..' '..printTaskAttrbutes(task)
												end
											else
												return printActionId(task)..'('..(actionParams.bearing and _('BRG')..' ' or '')..', '..(actionParams.channel or '')..(actionParams.modeChannel or '')..', "'..(actionParams.callsign or '')..'", Unit "") '..printActionName(task)..' '..printTaskAttrbutes(task)
											end
										end,
										'ActivateTACAN',
										function(group)
											local isTacan = false
											for k, v in base.pairs(group.units) do
												local unitDesc = DB.unit_by_type[v.type]
												if unitDesc.TACAN == true or unitDesc.TACAN_AA == true then
													isTacan = true
												end
											end
											
											if isTacan == true then
												return nil
											else
												return "\""..group.name.."\"".._("has no TACAN")
											end
										end,
										function(group, actionParams)
											return fill_TACAN(group.units[1], actionParams)								
										end
									),
	[ActionId.DEACTIVATE_BEACON]= declareCommand(
										'DeactivateBeacon',
										_('Deactivate TACAN'),
										_('Dectivate active beacon (TACAN, etc) onboard of the group lead unit.'),
										nil,
										nil,
										nil,
										function(group)
											local isTacan = false
											for k, v in base.pairs(group.units) do
												local unitDesc = DB.unit_by_type[v.type]
												if unitDesc.TACAN == true or unitDesc.TACAN_AA == true then
													isTacan = true
												end
											end
											
											if isTacan == true then
												return nil
											else
												return "\""..group.name.."\"".._("has no beacon to deactivate")
											end
										end
									),				
	[ActionId.ACTIVATE_ICLS]	= declareCommand(
										'ActivateICLS',
										_('Activate ICLS'),
										_('Activate ICLS onboard of the group lead unit. Only one ICLS is available.'),
										{
											type = 131584,
											channel = 1,
										},
										function(group, wpt, task)
											local actionParams = getActionParams(task)
											local unitDesc
											local unitName 
											local unit 
											
											if actionParams.unitId then
												unit = base.module_mission.unit_by_id[actionParams.unitId]
												if unit then
													unitDesc = DB.unit_by_type[unit.type]
													unitName = unit.name
												end	
											end	
											
											if unit then
												return printActionId(task)..'('..(actionParams.channel or '')..', Unit "'..(unitName or '')..'") '..printActionName(task)..' '..printTaskAttrbutes(task)
											else
												return printActionId(task)..'('..(actionParams.channel or '')..', Unit "") '..printActionName(task)..' '..printTaskAttrbutes(task)
											end
										end,										
										'ActivateICLS',
										function(group)
											local isICLS = false
											for k, v in base.pairs(group.units) do
												local unitDesc = DB.unit_by_type[v.type]
												if unitDesc.ICLS == true then
													isICLS = true
												end
											end
											
											if isICLS == true then
												return nil
											else
												return "\""..group.name.."\"".._("has no ICLS")
											end
										end
									),
	[ActionId.DEACTIVATE_ICLS]= declareCommand(
										'DeactivateICLS',
										_('Deactivate ICLS'),
										_('Dectivate active beacon (ICLS, etc) onboard of the group lead unit.'),
										nil,
										nil,
										nil,
										function(group)	
											local isICLS = false
											for k, v in base.pairs(group.units) do
												local unitDesc = DB.unit_by_type[v.type]
												if unitDesc.ICLS == true then
													isICLS = true
												end
											end
											
											if isICLS == true then
												return nil
											else
												return "\""..group.name.."\"".._("has no ICLS to deactivate")
											end
										end
									),		
	[ActionId.ACTIVATE_LINK4]	= declareCommand(
										'ActivateLink4',
										_('Activate Link 4'),
										_('Activate Link 4 onboard of the group lead unit. Only one Link 4 is available.'),
										nil,
										function(group, wpt, task)
											local actionParams = getActionParams(task)
											local unitDesc
											local unitName 
											local unit 
											
											if actionParams.unitId then
												unit = base.module_mission.unit_by_id[actionParams.unitId]
												if unit then
													unitDesc = DB.unit_by_type[unit.type]
													unitName = unit.name
												end	
											end	
											
											if unit then
												return printActionId(task)..'('..((actionParams.frequency and actionParams.frequency/1000000) or '')..', Unit "'..(unitName or '')..'") '..printActionName(task)..' '..printTaskAttrbutes(task)
											else
												return printActionId(task)..'('..((actionParams.frequency and actionParams.frequency/1000000) or '')..', Unit "") '..printActionName(task)..' '..printTaskAttrbutes(task)
											end
										end,										
										'ActivateLink4',
										function(group)
											local isLink4 = false
											for k, v in base.pairs(group.units) do
												local unitDesc = DB.unit_by_type[v.type]
												if (DB.findAttribute(unitDesc.attribute, 'Aircraft Carriers') == true
													or unitDesc.attribute[3] == base.wsType_AirCarrier)
														and DB.findAttribute(unitDesc.attribute, 'Link4') == true then
													isLink4 = true
												end
											end
											
											if isLink4 == true then
												return nil
											else
												return "\""..group.name.."\"".._("has no Link 4")
											end
										end
									),
	[ActionId.DEACTIVATE_LINK4]= declareCommand(
										'DeactivateLink4',
										_('Deactivate Link 4'),
										_('Dectivate active beacon (Link 4, etc) onboard of the group lead unit.'),
										nil,
										nil,
										nil,
										function(group)
											local isLink4 = false
											for k, v in base.pairs(group.units) do
												local unitDesc = DB.unit_by_type[v.type]
												if (DB.findAttribute(unitDesc.attribute, 'Aircraft Carriers') == true
													or unitDesc.attribute[3] == base.wsType_AirCarrier)
														and DB.findAttribute(unitDesc.attribute, 'Link4') == true then
													isLink4 = true
												end
											end
											
											if isLink4 == true then
												return nil
											else
												return "\""..group.name.."\"".._("has no Link 4")
											end
										end
									),	
	[ActionId.ACTIVATE_ACLS]	= declareCommand(
										'ActivateACLS',
										_('Activate ACLS'),
										_('Activate ACLS onboard of the group lead unit. Only one ACLS is available.'),
										nil,
										function(group, wpt, task)
											local actionParams = getActionParams(task)
											local unitDesc
											local unitName 
											local unit 
											
											if actionParams.unitId then
												unit = base.module_mission.unit_by_id[actionParams.unitId]
												if unit then
													unitDesc = DB.unit_by_type[unit.type]
													unitName = unit.name
												end	
											end	
											
											if unit then
												return printActionId(task)..'('..'Unit "'..(unitName or '')..'") '..printActionName(task)..' '..printTaskAttrbutes(task)
											else
												return printActionId(task)..'('..'Unit "") '..printActionName(task)..' '..printTaskAttrbutes(task)
											end
										end,										
										'ActivateACLS',
										function(group)
											local isACLS = false
											for k, v in base.pairs(group.units) do
												local unitDesc = DB.unit_by_type[v.type]
												if (DB.findAttribute(unitDesc.attribute, 'Aircraft Carriers') == true
													or unitDesc.attribute[3] == base.wsType_AirCarrier)
														and DB.findAttribute(unitDesc.attribute, 'ACLS') == true then
													isACLS = true
												end
											end
											
											if isACLS == true then
												return nil
											else
												return "\""..group.name.."\"".._("has no ACLS")
											end
										end
									),
	[ActionId.DEACTIVATE_ACLS]= declareCommand(
										'DeactivateACLS',
										_('Deactivate ACLS'),
										_('Dectivate active beacon (ACLS, etc) onboard of the group lead unit.'),
										nil,
										nil,
										nil,
										function(group)
											local isACLS = false
											for k, v in base.pairs(group.units) do
												local unitDesc = DB.unit_by_type[v.type]
												if (DB.findAttribute(unitDesc.attribute, 'Aircraft Carriers') == true
													or unitDesc.attribute[3] == base.wsType_AirCarrier)
														and DB.findAttribute(unitDesc.attribute, 'ACLS') == true then
													isACLS = true
												end
											end
											
											if isACLS == true then
												return nil
											else
												return "\""..group.name.."\"".._("has no ACLS")
											end
										end
									),										
	[ActionId.EPLRS]			= declareCommand(
										'EPLRS',
										_('EPLRS'),
										_('Swich Enhanced Position Location Reporting System on and off.'),
										{ value = true, groupId = 0 },
										getBoolValueDescription,
										nil,
										function(group)
											local unitDesc = DB.unit_by_type[group.units[1].type]
											if unitDesc.EPLRS == true then
												return nil
											else
												return "\""..unitDesc.Name.."\"".._("has no EPLRS")
											end
										end,
										function(group)			
											for wptIndex, wpt in base.pairs(group.route.points) do
												if wpt.task then
													for taskIndex, task in base.pairs(wpt.task.params.tasks) do
														if task.id == 'WrappedAction' then
															local action = task.params.action
															if action.id == 'EPLRS' then
																return { groupId = action.params.groupId }
															end
														end
													end
												end
											end
											
											return getNewTblGroupIdForEPLRS(group)
										end
									),
	[ActionId.SMOKE_ON_OFF]			= declareCommand(
										'SMOKE_ON_OFF',
										_('SmokeOn_Off'),
										_('SmokeOn_Off'),
										{ value = true },
										getBoolValueDescription
									),
	--ActionType.OPTION
	[ActionId.NO_OPTION]		= declareEnumOption(
										OptionName.NO_OPTION,
										_('No Option'),
										_('Empty option')
									),
	[ActionId.ROE]				= declareEnumOption(
										OptionName.ROE,
										_('ROE'),
										_('Set Rule of Engagement.')
									),
	[ActionId.ALARM_STATE]		= declareEnumOption(
										OptionName.ALARM_STATE,
										_('ALARM STATE'),
										_('Set SAM readiness state.')
									),
    [ActionId.ENGAGE_AIR_WEAPONS]	=   declareFlagOption(
										OptionName.ENGAGE_AIR_WEAPONS,
										_('Engage air weapons'),
										_('Engage air weapons'),
										true
									),
	--[[
	[ActionId.AWARNESS_LEVEL]	= declareEnumOption(
										OptionName.AWARNESS_LEVEL
										_('AWARNESS LEVEL (N/A)'),
										_('Situation awarness level')
									),
	--]]
	[ActionId.REACTION_ON_THREAT]= declareEnumOption(
										OptionName.REACTION_ON_THREAT,
										_('Reaction On Threat'),
										_('Set what behavior is allowed as a reaction on a threat.')
									),
	[ActionId.RADAR_USING]		= declareEnumOption(
										OptionName.RADAR_USING,	
										_('Radar Using'),
										_('Set the conditions when radar using is allowed to the group.'),
										function(unitDesc)
											return 	unitDesc.Sensors ~= nil and
													(unitDesc.Sensors.RADAR ~= nil or unitDesc.Sensors.RADARS ~= nil)
										end	
									),
	[ActionId.FLARE_USING]		= declareEnumOption(
										OptionName.FLARE_USING,
										_('Flare Using'),
										_('Set the conditions when flare using is allowed to the group.')
									),
	[ActionId.FORMATION]		= declareOption(
										OptionName.FORMATION,
										_('Formation'),
										_('Set the group formation.'),
										getFormationOptionDescription
									),
	[ActionId.RTB_ON_BINGO]		= declareFlagOption(
										OptionName.RTB_ON_BINGO,
										_('RTB on Bingo Fuel'),
										_('Allows the group to return to base when it is bingo fuel.'),
										true
									),
	[ActionId.RTB_ON_OUT_OF_AMMO]= declareEnumOption(
										OptionName.RTB_ON_OUT_OF_AMMO,
										_('RTB on out of ammo'),
										_('Set specific type of ammo that is required by the group to continue its mission.')
									),
	[ActionId.SILENCE]			= declareFlagOption(
										OptionName.SILENCE,
										_('Silence'),
										_('Deny AI flights report events.'),
										false
									),
	[ActionId.DISPERSE_ON_ATTACK] = declareNumericOption(
										OptionName.DISPERSE_ON_ATTACK,
										_('Disperse under fire'),
										_('Allow the group to disperse under attack from the air and set the delay.'),
										600
									),
	[ActionId.ECM_USING]		= declareEnumOption(
										OptionName.ECM_USING,	
										_('ECM Using'),
										_('Set the conditions when ECM using is allowed to the group.')										
									),
									
	[ActionId.PROHIBIT_AA]		= 	declareFlagOption(
										OptionName.PROHIBIT_AA,
										_('Restrict Air-to-Air Attack'),
										_('Restrict Air-to-Air Attack'),
										false
									),
									
	[ActionId.PROHIBIT_JETT]		= 	declareFlagOption(
										OptionName.PROHIBIT_JETT,
										_('Restrict Jettison'),
										_('Restrict Jettisoning external stores.'),
										false
									),
	[ActionId.PROHIBIT_AB]		= 	declareFlagOption(
										OptionName.PROHIBIT_AB,
										_('Restrict Afterburner'),
										_('Restrict Afterburner usage en route.'),
										false
									),
	[ActionId.PROHIBIT_AG]		= 	declareFlagOption(
										OptionName.PROHIBIT_AG,
										_('Restrict Air-to-Ground Attack'),
										_('Restrict Air-to-Ground Attack.'),
										false
									),
	[ActionId.MISSILE_ATTACK]		= declareEnumOption(
										OptionName.MISSILE_ATTACK,	
										_('AA Missile attack ranges'),
										_('Choose the rule of first missile launch in BVR')
									),
	[ActionId.PROHIBIT_WP_PASS_REPORT]			= declareFlagOption(
										OptionName.PROHIBIT_WP_PASS_REPORT,
										_('No Report Waypoint Pass'),
										_('Deny AI flights report when passing waypoint.'),
										false
									),
	[ActionId.RADIO_USAGE_CONTACT]			= declareTargetTypesOption(
										OptionName.RADIO_USAGE_CONTACT,
										_('Radio usage when contact'),
										_('Set specific type of events and target types for radio messages when contact enemy')
									),
	[ActionId.RADIO_USAGE_ENGAGE]			= declareTargetTypesOption(
										OptionName.RADIO_USAGE_ENGAGE,
										_('Radio usage when engage'),
										_('Set specific type of events and target types for radio messages when engage enemy')
									),
	[ActionId.RADIO_USAGE_KILL]			= declareTargetTypesOption(
										OptionName.RADIO_USAGE_KILL,
										_('Radio usage when kill target'),
										_('Set specific type of events and target types for radio messages when kill enemy')
									),

	--[[[ActionId.PROHIBITIONS] = {
		type = ActionType.OPTION,
		displayName = _('Restrictions'),
		desc = _('Restrictions : Air to Air Attack, Air to Ground Attack, Jettisoning external stores, Afterburner usage en route.'),		
		task = {	
			id = 'Restrictions',
			params = {
				PROHIBIT_AA 	= false,
				PROHIBIT_JETT	= false,
				PROHIBIT_AB 	= false,
				PROHIBIT_AG 	= false
			}
		}
	},]]--
	
	[ActionId.AIRCRAFT_INTERCEPT_RANGE]		= declareTargetTypesOption(
										OptionName.AIRCRAFT_INTERCEPT_RANGE,
										_('Interception range'),
										_('You may shorten the Interception range here')
									),	
	[ActionId.JETT_TANKS_IF_EMPTY]		= declareFlagOption(
										OptionName.JETT_TANKS_IF_EMPTY,
										_('Jettison fuel tanks when empty'),
										_('Allows the wingmen to drop empty fuel tanks.'),
										false
									),
	[ActionId.FORCED_ATTACK]		= declareFlagOption(
										OptionName.FORCED_ATTACK,
										_('Override AI attack avoidance decisions'),
										_('When selected, AI will not avoid combat engagements at own decision'),
										false
									),	
	[ActionId.ALT_RESTRICTION_MIN] = declareNumericOption(
										OptionName.ALT_RESTRICTION_MIN,
										_('Altitude restriction MIN for AAA'),
										_('Altitude restriction MIN for AA Artillery'),
										200,								
										function(group)
											local result = false
											for k, unit in base.pairs(group.units) do
												local unitDesc = DB.unit_by_type[unit.type]
												if DB.findAttribute(unitDesc.attribute, "AA_flak") then
													result = true
												end
											end

											if result == true then
												return nil
											else
												return "\"".._("Group").."\" ".._("has no AAA")
											end
										end
									),
									
									
	[ActionId.ALT_RESTRICTION_MAX] = declareNumericOption(
										OptionName.ALT_RESTRICTION_MAX,
										_('Altitude restriction MAX for AAA'),
										_('Altitude restriction MAX for AA Artillery'),
										3500,								
										function(group)
											local result = false
											for k, unit in base.pairs(group.units) do
												local unitDesc = DB.unit_by_type[unit.type]
												if DB.findAttribute(unitDesc.attribute, "AA_flak") then
													result = true
												end
											end

											if result == true then
												return nil
											else
												return "\"".._("Group").."\" ".._("has no AAA")
											end
										end								
									),
									
	[ActionId.RESTRICT_TARGET]		= declareEnumOption(
										OptionName.RESTRICT_TARGET,
										_('Restrict targets'),
										_('Restrict target engagements')
									),						
									
}

--get action unique key
function getActionKey(tbl)
	if tbl.id == 'ControlledTask' then
		return getActionKey(tbl.params.task)
	elseif tbl.id == 'WrappedAction' then
		return getActionKey(tbl.params.action)
	elseif tbl.id == 'Option' then
		return tbl.params.name
	else
		return tbl.key ~= nil and tbl.key or tbl.id
	end
end

function isGroupCapableOfAction(group, wpt, actionData, actionParams)
	--base.print("--isGroupCapableOfAction--",actionData.displayName,actionData.verifyGroupCapability)
	if actionData.verifyGroupCapability ~= nil then
		--base.print("--111--",actionData.verifyGroupCapability(group, wpt, actionData, actionParams))
		return actionData.verifyGroupCapability(group, wpt, actionData, actionParams)
	else
		return nil
	end
end

do
	--Reverse table (action id by task id and helper)
	local actionIdByTask = {}
	for actionId, actionData in base.pairs(actionsData) do
		local actionKey = getActionKey(actionData.task)
		if actionKey == nil then
			base.error("Unable to get key for task with id = "..base.tostring(task.id))
		end
        
        if actionIdByTask[actionKey] == nil then
            actionIdByTask[actionKey] = actionId
        end  
	end
	function getActionIdByTask(task)       
		local actionKey = getActionKey(task)
		return actionIdByTask[actionKey]
	end	
end

function getActionDataByTask(task)
	local actionId = getActionIdByTask(task)
	if actionId == nil then
		base.print("Unable to get action id for task with id = "..base.tostring(task.id))
		return nil
	end
	return actionsData[actionId]
end

function getTaskDescription(group, wpt, task)
	local actionData = getActionDataByTask(task)
	if actionData == nil then
		return nil
	end
	if actionData.getDescription ~= nil then
		return actionData.getDescription(group, wpt, task)
	else
		return getCommonDescription(group, wpt, task)
	end
end

function getTaskDescriptionForMark(group, wpt, task)
	return printActionId(task)..printActionName(task)
end

function onTaskRemove(group, wpt, task)
	local actionData = getActionDataByTask(task)
	if actionData.onRemove ~= nil then
		return actionData.onRemove(group, wpt, task)
	end
end

function getActionParams(tbl)
	if tbl.id == 'ControlledTask' then
		return getActionParams(tbl.params.task)
	elseif tbl.id == 'WrappedAction' then
		return getActionParams(tbl.params.action)
	else
		return tbl.params
	end
end

do
	local actionsForAirUnits = {
		ActionId.NO_ACTION,
		ActionId.SCRIPT,
		ActionId.SCRIPT_FILE,
		ActionId.SET_FREQUENCY,
		ActionId.SET_FREQUENCYFORUNIT,
		ActionId.TRANSMIT_MESSAGE,
		ActionId.STOP_TRANSMISSION,
		ActionId.SWITCH_WAYPOINT,
		ActionId.SWITCH_ITEM,
		ActionId.INVISIBLE,
		ActionId.IMMORTAL,
		ActionId.START,
		ActionId.ACTIVATE_TACAN,
		ActionId.DEACTIVATE_BEACON,
		ActionId.EPLRS,
		ActionId.SMOKE_ON_OFF		
	}

	local actionsForGroundUnits = {
		ActionId.NO_ACTION,
		ActionId.SCRIPT,
		ActionId.SCRIPT_FILE,
		ActionId.SET_CALLSIGN,
		ActionId.SET_FREQUENCY,
		ActionId.TRANSMIT_MESSAGE,
		ActionId.STOP_TRANSMISSION,
		ActionId.GO_TO_WAYPOINT,		
		ActionId.INVISIBLE,
		ActionId.IMMORTAL,
		ActionId.EPLRS,
		ActionId.ACTIVATE_TACAN,
		ActionId.DEACTIVATE_BEACON,
	}

	local actionsForNavalUnits = {
		ActionId.NO_ACTION,
		ActionId.SCRIPT,
		ActionId.SCRIPT_FILE,
		ActionId.INVISIBLE,
		ActionId.IMMORTAL,
		ActionId.ACTIVATE_TACAN,
		ActionId.DEACTIVATE_BEACON,
		ActionId.ACTIVATE_ICLS,
		ActionId.DEACTIVATE_ICLS,
		ActionId.GO_TO_WAYPOINT,
		ActionId.LOADING_SHIP,
		ActionId.ACTIVATE_LINK4,
		ActionId.DEACTIVATE_LINK4,
		ActionId.ACTIVATE_ACLS,
		ActionId.DEACTIVATE_ACLS,
		ActionId.SHIP_HOLD_POINT,
	}
	
	availableActions = {
		['plane'] = {
			[ActionType.TASK] = {
				['Default'] = {
					ActionId.NO_TASK,
					ActionId.ATTACK_GROUP,
					ActionId.ATTACK_UNIT,
					ActionId.ATTACK_MAP_OBJECT,
					ActionId.BOMBING,
					ActionId.BOMBING_RUNWAY,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FAC_ATTACK_GROUP,
					ActionId.FOLLOW,
					ActionId.AEROBATICS,
					ActionId.WW2_BIG_FORMATION,	 
					ActionId.CARGO_TRANSPORTATION_PLANE,	
					ActionId.CARGO_UNLOAD_PLANE,					
				},
				['Nothing'] = {
					ActionId.NO_TASK,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW,
					ActionId.AEROBATICS					
				},
				['Airborne'] = {
					ActionId.NO_TASK,
					ActionId.PARATROOPERS_DROP,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW,
					ActionId.WW2_BIG_FORMATION,
				},
				['SEAD'] = {
					ActionId.NO_TASK,
					ActionId.ATTACK_GROUP,
					ActionId.ATTACK_UNIT,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW,
					ActionId.ESCORT
				},
				['Antiship Strike'] = {
					ActionId.NO_TASK,
					ActionId.ATTACK_GROUP,
					ActionId.ATTACK_UNIT,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW
				},
				['AWACS'] = {
					ActionId.NO_TASK,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW
				},
				['CAS'] = {
					ActionId.NO_TASK,
					ActionId.ATTACK_GROUP,
					ActionId.ATTACK_UNIT,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW,
					ActionId.AEROBATICS
				},
				['CAP'] = {
					ActionId.NO_TASK,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW,
					ActionId.AEROBATICS
				},
				['Pinpoint Strike'] = {
					ActionId.NO_TASK,
					ActionId.ATTACK_MAP_OBJECT,
					ActionId.BOMBING,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW
				},
				['Escort'] = {
					ActionId.NO_TASK,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW,
					ActionId.ESCORT
				},
				['Fighter Sweep'] = {
					ActionId.NO_TASK,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW,
					ActionId.AEROBATICS
				},
				['GAI'] = {
					ActionId.NO_TASK,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW
				},
				['Ground Attack'] = {
					ActionId.NO_TASK,
					ActionId.ATTACK_MAP_OBJECT,
					ActionId.BOMBING,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW,
					ActionId.AEROBATICS,
					ActionId.CARPET_BOMBING,
					ActionId.WW2_BIG_FORMATION,
				},
				['Intercept'] = {
					ActionId.NO_TASK,
					ActionId.ATTACK_GROUP,
					ActionId.ATTACK_UNIT,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW,
					ActionId.AEROBATICS
				},
				['AFAC'] = {
					ActionId.NO_TASK,
					ActionId.ATTACK_GROUP,
					ActionId.ATTACK_UNIT,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FAC_ATTACK_GROUP,
					ActionId.BOMBING,
					ActionId.ATTACK_MAP_OBJECT,
					ActionId.FOLLOW
				},
				['Reconnaissance'] = {
					ActionId.NO_TASK,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW,
					ActionId.AEROBATICS
				},
				['Refueling'] = {
					ActionId.NO_TASK,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW,
					ActionId.RECOVERY_TANKER
				},
				['Runway Attack'] = {
					ActionId.NO_TASK,
					ActionId.ATTACK_MAP_OBJECT,
					ActionId.BOMBING,
					ActionId.BOMBING_RUNWAY,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW,
				},
				['Transport'] = {
					ActionId.NO_TASK,
					ActionId.ORBIT,
					ActionId.REFUELING,
					ActionId.FOLLOW,
					ActionId.AEROBATICS,
					ActionId.WW2_BIG_FORMATION,
					ActionId.CARGO_TRANSPORTATION_PLANE,
					ActionId.CARGO_UNLOAD_PLANE,						
				}			
			},
			[ActionType.ENROUTE_TASK] = {
				['Default'] = {
					ActionId.NO_TASK,
					ActionId.ENGAGE_TARGETS,
					ActionId.ENGAGE_TARGETS_IN_ZONE,
					ActionId.ENGAGE_GROUP,
					ActionId.ENGAGE_UNIT,
					ActionId.AWACS,
					ActionId.FAC,
					ActionId.FAC_ENGAGE_GROUP,
					ActionId.TANKER
				},
				['Nothing'] = {
					ActionId.NO_ENROUTE_TASK,
				},
				['SEAD'] = {
					ActionId.NO_ENROUTE_TASK,
					ActionId.ENGAGE_TARGETS,
					ActionId.ENGAGE_TARGETS_IN_ZONE,
					ActionId.ENGAGE_GROUP,
					ActionId.ENGAGE_UNIT,
					ActionId.SEAD
				},
				['Antiship Strike'] = {
					ActionId.NO_ENROUTE_TASK,
					ActionId.ENGAGE_TARGETS,
					ActionId.ENGAGE_TARGETS_IN_ZONE,
					ActionId.ENGAGE_GROUP,
					ActionId.ENGAGE_UNIT,
					ActionId.ANTI_SHIP
				},
				['AWACS'] = {
					ActionId.NO_ENROUTE_TASK,
					ActionId.AWACS
				},
				['CAS'] = {
					ActionId.NO_ENROUTE_TASK,
					ActionId.ENGAGE_TARGETS,
					ActionId.ENGAGE_TARGETS_IN_ZONE,
					ActionId.ENGAGE_GROUP,
					ActionId.ENGAGE_UNIT,
					ActionId.CAS
				},
				['Pinpoint Strike'] = {
					ActionId.NO_ENROUTE_TASK,
				},
				['CAP'] = {
					ActionId.NO_ENROUTE_TASK,
					ActionId.ENGAGE_TARGETS,
					ActionId.ENGAGE_TARGETS_IN_ZONE,
					ActionId.ENGAGE_GROUP,
					ActionId.ENGAGE_UNIT,
					ActionId.CAP
				},
				['Escort'] = {
					ActionId.NO_ENROUTE_TASK
				},
				['Fighter Sweep'] = {
					ActionId.NO_ENROUTE_TASK,
					ActionId.ENGAGE_TARGETS,
					ActionId.ENGAGE_TARGETS_IN_ZONE,
					ActionId.ENGAGE_GROUP,
					ActionId.ENGAGE_UNIT,	
					ActionId.FIGHTER_SWEEP
				},
				['GAI'] = {
					ActionId.NO_ENROUTE_TASK
				},
				['Ground Attack'] = {
					ActionId.NO_ENROUTE_TASK
				},
				['Intercept'] = {
					ActionId.NO_ENROUTE_TASK
				},
				['AFAC'] = {
					ActionId.NO_ENROUTE_TASK,
					ActionId.ENGAGE_TARGETS,
					ActionId.ENGAGE_TARGETS_IN_ZONE,
					ActionId.ENGAGE_GROUP,
					ActionId.ENGAGE_UNIT,
					ActionId.FAC,
					ActionId.FAC_ENGAGE_GROUP,
				},
				['Reconnaissance'] = {
					ActionId.NO_ENROUTE_TASK
				},
				['Refueling'] = {
					ActionId.NO_ENROUTE_TASK,
					ActionId.TANKER
				},
				['Runway Attack'] = {
					ActionId.NO_ENROUTE_TASK
				},
				['Transport'] = {
					ActionId.NO_ENROUTE_TASK
				}				
			},
			[ActionType.COMMAND] = {
				['Default'] = actionsForAirUnits
			},
			[ActionType.OPTION] = {
				['Default'] = {
					ActionId.NO_OPTION,
					ActionId.ROE,
					ActionId.REACTION_ON_THREAT,
					ActionId.RADAR_USING,
					ActionId.FLARE_USING,
					ActionId.FORMATION,
					ActionId.RTB_ON_BINGO,
					ActionId.RTB_ON_OUT_OF_AMMO,
					ActionId.SILENCE,
					ActionId.AWARNESS_LEVEL,
					ActionId.ECM_USING,
					ActionId.PROHIBIT_AA,
					ActionId.PROHIBIT_JETT,
					ActionId.PROHIBIT_AB,
					ActionId.PROHIBIT_AG,
					ActionId.MISSILE_ATTACK,
					ActionId.PROHIBIT_WP_PASS_REPORT,
					ActionId.RADIO_USAGE_CONTACT,
					ActionId.RADIO_USAGE_ENGAGE,
					ActionId.RADIO_USAGE_KILL,					
					ActionId.JETT_TANKS_IF_EMPTY,
					ActionId.FORCED_ATTACK,
					--ActionId.PROHIBITIONS,
				}
			}		
		},
		
		['helicopter'] = {
			[ActionType.TASK] = {
				['Default'] = {
					ActionId.NO_TASK,
					ActionId.ATTACK_GROUP,
					ActionId.ATTACK_UNIT,
					ActionId.ATTACK_MAP_OBJECT,
					ActionId.BOMBING,
					ActionId.BOMBING_RUNWAY,
					ActionId.ORBIT,
					ActionId.LAND,
					ActionId.FAC_ATTACK_GROUP,
					ActionId.FOLLOW,
					ActionId.CARGO_TRANSPORTATION,
					ActionId.GROUND_ESCORT
				},
				['Nothing'] = {
					ActionId.NO_TASK,
					ActionId.ORBIT,
					ActionId.LAND,
					ActionId.FOLLOW
				},
				['SEAD'] = {
					ActionId.NO_TASK,
					ActionId.ATTACK_GROUP,
					ActionId.ATTACK_UNIT,
					ActionId.ORBIT,
					ActionId.LAND,
					ActionId.FOLLOW,
					ActionId.ESCORT,
					ActionId.CARGO_TRANSPORTATION,
					ActionId.GROUND_ESCORT
				},
				['Antiship Strike'] = {
					ActionId.ATTACK_GROUP,
					ActionId.ATTACK_UNIT,
					ActionId.ORBIT,
					ActionId.LAND,
					ActionId.FOLLOW,
					ActionId.CARGO_TRANSPORTATION					
				},
				['CAS'] = {
					ActionId.NO_TASK,
					ActionId.ATTACK_GROUP,
					ActionId.ATTACK_UNIT,
					ActionId.ORBIT,
					ActionId.LAND,
					ActionId.FOLLOW,
					ActionId.EMBARKING,
					ActionId.DISEMBARKING,
					ActionId.CARGO_TRANSPORTATION,
					ActionId.GROUND_ESCORT
				},
				['Ground Attack'] = {
					ActionId.NO_TASK,
					ActionId.ATTACK_MAP_OBJECT,
					ActionId.BOMBING,
					ActionId.ORBIT,
					ActionId.LAND,
					ActionId.FOLLOW,
					ActionId.EMBARKING,
					ActionId.DISEMBARKING,
					ActionId.GROUND_ESCORT
				},
				['AFAC'] = {
					ActionId.NO_TASK,
					ActionId.ATTACK_GROUP,
					ActionId.ATTACK_UNIT,
					ActionId.ORBIT,
					ActionId.LAND,
					ActionId.FAC_ATTACK_GROUP,
					ActionId.BOMBING,
					ActionId.ATTACK_MAP_OBJECT,
					ActionId.FOLLOW
				},
				['Reconnaissance'] = {
					ActionId.NO_TASK,
					ActionId.ORBIT,
					ActionId.LAND,
					ActionId.FOLLOW
				},
				['Transport'] = {
					ActionId.NO_TASK,
					ActionId.ORBIT,
					ActionId.LAND,
					ActionId.FOLLOW,
					ActionId.EMBARKING,
					ActionId.DISEMBARKING,					
					ActionId.CARGO_TRANSPORTATION					
				},
				['Escort'] = {
					ActionId.NO_TASK,
					ActionId.ORBIT,
					ActionId.LAND,
					ActionId.ESCORT
				},
			},
			[ActionType.ENROUTE_TASK] = {
				['Default'] = {
					ActionId.NO_ENROUTE_TASK,
					ActionId.ENGAGE_TARGETS,
					ActionId.ENGAGE_TARGETS_IN_ZONE,
					ActionId.ENGAGE_GROUP,
					ActionId.ENGAGE_UNIT,
					ActionId.FAC,
					ActionId.FAC_ENGAGE_GROUP
				},
				['Nothing'] = {
					ActionId.NO_ENROUTE_TASK,
				},
				['SEAD'] = {
					ActionId.NO_ENROUTE_TASK,
					ActionId.ENGAGE_TARGETS,
					ActionId.ENGAGE_TARGETS_IN_ZONE,
					ActionId.ENGAGE_GROUP,
					ActionId.ENGAGE_UNIT,
					ActionId.SEAD
				},
				['Antiship Strike'] = {
					ActionId.NO_ENROUTE_TASK,
					ActionId.ENGAGE_TARGETS,
					ActionId.ENGAGE_TARGETS_IN_ZONE,
					ActionId.ENGAGE_GROUP,
					ActionId.ENGAGE_UNIT,
					ActionId.ANTI_SHIP
				},
				['CAS'] = {
					ActionId.NO_ENROUTE_TASK,
					ActionId.ENGAGE_TARGETS,
					ActionId.ENGAGE_TARGETS_IN_ZONE,
					ActionId.ENGAGE_GROUP,
					ActionId.ENGAGE_UNIT,
					ActionId.CAS
				},
				['Ground Attack'] = {
					ActionId.NO_ENROUTE_TASK
				},
				['AFAC'] = {
					ActionId.NO_ENROUTE_TASK,
					ActionId.ENGAGE_TARGETS,
					ActionId.ENGAGE_TARGETS_IN_ZONE,
					ActionId.ENGAGE_GROUP,
					ActionId.ENGAGE_UNIT,
					ActionId.FAC,
					ActionId.FAC_ENGAGE_GROUP
				},
				['Reconnaissance'] = {
					ActionId.NO_ENROUTE_TASK
				},
				['Transport'] = {
					ActionId.NO_ENROUTE_TASK
				}
			},
			[ActionType.COMMAND] = {
				['Default'] = actionsForAirUnits
			},
			[ActionType.OPTION] = {
				['Default'] = {
					ActionId.NO_OPTION,
					ActionId.ROE,
					ActionId.REACTION_ON_THREAT,
					ActionId.RADAR_USING,
					ActionId.FLARE_USING,
					ActionId.FORMATION,
					ActionId.RTB_ON_BINGO,
					ActionId.RTB_ON_OUT_OF_AMMO,
					ActionId.SILENCE,
					ActionId.AWARNESS_LEVEL,
					ActionId.JETT_TANKS_IF_EMPTY,
					ActionId.PROHIBIT_WP_PASS_REPORT,
					ActionId.RADIO_USAGE_CONTACT,
					ActionId.RADIO_USAGE_ENGAGE,
					ActionId.RADIO_USAGE_KILL
				}
			}		
		},	
		['vehicle'] = {
			[ActionType.TASK] = {
				['Default'] = {
					ActionId.NO_TASK,					
					ActionId.FAC_ATTACK_GROUP,
					ActionId.FIRE_AT_POINT,
					ActionId.ATTACK_GROUP,
					ActionId.ATTACK_UNIT,					
					ActionId.HOLD,
					ActionId.EMBARK_TO_TRANSPORT,
					ActionId.GO_TO_WAYPOINT,	
					ActionId.EMBARKING,	
					ActionId.DISEMBARKING,	
					ActionId.ATTACH_TRAILER,
					ActionId.DETACH_TRAILER,					
				}
			},
			[ActionType.ENROUTE_TASK] = {
				['Default'] = {
					ActionId.NO_ENROUTE_TASK,
					ActionId.FAC,
					ActionId.FAC_ENGAGE_GROUP,
					ActionId.EWR
				}
			},
			[ActionType.COMMAND] = {
				['Default'] = actionsForGroundUnits
			},
			[ActionType.OPTION] = {
				['Default'] = {
                    ActionId.NO_OPTION,
                    ActionId.ROE,
                    ActionId.DISPERSE_ON_ATTACK,
					ActionId.ALARM_STATE,
					ActionId.AWARNESS_LEVEL,
                    ActionId.ENGAGE_AIR_WEAPONS,
					ActionId.AIRCRAFT_INTERCEPT_RANGE,
					ActionId.ALT_RESTRICTION_MIN,
					ActionId.ALT_RESTRICTION_MAX,
					ActionId.RESTRICT_TARGET,
                }
			},
		},
		['ship'] = {
			[ActionType.TASK] = {
				['Default'] = {
					ActionId.NO_TASK,
					ActionId.FIRE_AT_POINT,
					ActionId.ATTACK_GROUP,
					ActionId.GO_TO_WAYPOINT,
					ActionId.SHIP_HOLD_POINT,
				}
			},
			[ActionType.ENROUTE_TASK] = {
				['Default'] = {
					ActionId.NO_ENROUTE_TASK,
				}
			},
			[ActionType.COMMAND] = {
				['Default'] = actionsForNavalUnits
			},
			[ActionType.OPTION] = {
				['Default'] = {
                    ActionId.NO_OPTION,
                    ActionId.ROE,
					ActionId.ALARM_STATE,
					ActionId.AWARNESS_LEVEL,
					ActionId.ENGAGE_AIR_WEAPONS,
					ActionId.AIRCRAFT_INTERCEPT_RANGE,
                }
			}		
		}
	}
	
	if base.ED_PUBLIC_AVAILABLE then
		availableActions['plane'][ActionType.TASK]['Airborne'] = nil
	end
	
	local function findAction(actionId, groupType, actionType, groupTask)
		local actions =  availableActions[groupType][actionType][groupTask] or availableActions[groupType][actionType]['Default']			
		for index, curActionId in base.pairs(actions) do
			if actionId == curActionId then
				return true
			end
		end
		return false
	end
		
	function isActionValid(action, group, wpt, groupTask)
		local actionId = getActionIdByTask(action)
		if actionId == nil then
			return "Unable to get action id for task with id = "..base.tostring(action.id)
		end		
		local actionData = actionsData[actionId]
		if actionData == nil then
			return 'Unknown action '..actionId
		end
		local actionType = actionData.type		
		local actions =  availableActions[group.type][actionType][groupTask] or availableActions[group.type][actionType]['Default']			
		local result = nil
		if not findAction(actionId, group.type, actionType, groupTask) then
			result = (result or "").._("not available for \"")..group.type.."\"-\"".._(groupTask).."\""
		end
		local errorMsg = isGroupCapableOfAction(group, wpt, actionData, getActionParams(action))
		if errorMsg ~= nil then
			result = (result or "")..errorMsg
		end
		return result
	end
	
end

local function setTask_(task, group, actionData)
	U.recursiveCopyTable(task, actionData.task)
	if actionData.makeParams then
		local actionParams = getActionParams(task)
		U.recursiveCopyTable(actionParams, actionData.makeParams(group, actionParams))
	end
	return task
end

do
	
	local function createAutoActionById(group, wpt, actionId)
		local actionData = actionsData[actionId]		
		if isGroupCapableOfAction(group, wpt, actionData) == nil then
			local autoAction = {}
			setTask_(autoAction, group, actionData)
			return autoAction
		end
	end
	
	local function createAutoActionCopy(group, wpt, template)
		local actionId = getActionIdByTask(template)
		local actionData = actionsData[actionId]
		if isGroupCapableOfAction(group, wpt, actionData) == nil then
			local autoAction = {}
			U.recursiveCopyTable(autoAction, template)
			return autoAction
		end
	end	
	
	local noTargetTypesAll = {	[1] = "Fighters",
								[2] = "Multirole fighters",
								[3] = "Bombers",
								[4] = "Helicopters",
								[5] = "UAVs",
								[6] = "Infantry",
								[7] = "Fortifications",
								[8] = "Tanks",
								[9] = "IFV",
								[10] = "APC",
								[11] = "Artillery",
								[12] = "Unarmed vehicles",
								[13] = "AAA",
								[14] = "SR SAM",
								[15] = "MR SAM",
								[16] = "LR SAM",
								[17] = "Aircraft Carriers",
								[18] = "Cruisers",
								[19] = "Destroyers",
								[20] = "Frigates",
								[21] = "Corvettes",
								[22] = "Light armed ships",
								[23] = "Unarmed ships",
								[24] = "Submarines",
								[25] = "Cruise missiles",
								[26] = "Antiship Missiles",
								[27] = "AA Missiles",
								[28] = "AG Missiles",
								[29] = "SA Missiles",
							}
	local noTargetTypesAirDefence = {
								[1] = "Fighters",
								[2] = "Multirole fighters",
								[3] = "Bombers",
								[4] = "Helicopters",
								[5] = 'UAVs',
								[6] = "Infantry",
								[7] = "Fortifications",
								[8] = "Tanks",
								[9] = "IFV",
								[10] = "APC",
								[11] = "Artillery",
								[12] = "Unarmed vehicles",
								[13] = "Aircraft Carriers",
								[14] = "Cruisers",
								[15] = "Destroyers",
								[16] = "Frigates",
								[17] = "Corvettes",
								[18] = "Light armed ships",
								[19] = "Unarmed ships",
								[20] = "Submarines",
								[21] = "Cruise missiles",
								[22] = "Antiship Missiles",
								[23] = "AA Missiles",
								[24] = "AG Missiles",
								[25] = "SA Missiles",
							}					

	local autoActions = {
		['all'] = {
			['Default'] = {
				{ create = createAutoActionById, data = ActionId.EPLRS }
			},
			['AWACS'] = {
				{ create = createAutoActionById, data = ActionId.AWACS }
			},
			['Refueling'] = {
				{ create = createAutoActionById, data = ActionId.TANKER },
				{ create = createAutoActionById, data = ActionId.ACTIVATE_TACAN }
			},			
			['Fighter Sweep'] = {
				{ create = createAutoActionById, data = ActionId.FIGHTER_SWEEP }				
			},
			['CAS'] = {
				{ create = createAutoActionById, data = ActionId.CAS }
			},
			['CAP'] = {
				{ create = createAutoActionById, data = ActionId.CAP }
			},
			['SEAD'] = {
				{ create = createAutoActionById, data = ActionId.SEAD },
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.REACTION_ON_THREAT, value = OptionValue.ALLOW_ABORT_MISSION })
				}
			},
			['Antiship Strike'] = {
				{ create = createAutoActionById, data = ActionId.ANTI_SHIP }
			},
			['AFAC'] = {
				{ create = createAutoActionById, data = ActionId.FAC }				
			}
		},
		['plane'] = {
			['Default'] = {
				{ create = createAutoActionById, data = ActionId.EPLRS }
			},
			['AWACS'] = {
				{ create = createAutoActionById, data = ActionId.AWACS }
			},
			['Refueling'] = {
				{ create = createAutoActionById, data = ActionId.TANKER },
				{ create = createAutoActionById, data = ActionId.ACTIVATE_TACAN }
			},			
			['Fighter Sweep'] = {
				{ create = createAutoActionById, data = ActionId.FIGHTER_SWEEP },
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.PROHIBIT_AG, value = true })
				},	
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.MISSILE_ATTACK, value = OptionValue.RANDOM_RANGE })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.PROHIBIT_WP_PASS_REPORT, value = true })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.RADIO_USAGE_CONTACT, value = "none;", 
						targetTypes = {},
						noTargetTypes = noTargetTypesAll })
				},
			},
			['CAS'] = {
				{ create = createAutoActionById, data = ActionId.CAS },
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.REACTION_ON_THREAT, value = OptionValue.EVADE_FIRE })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.RADAR_USING, value = OptionValue.USE_FOR_ATTACK_ONLY })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.FORMATION, value = 131074, variantIndex = 2, formationIndex = 2 })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.PROHIBIT_JETT, value = true })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.RADIO_USAGE_CONTACT, value = "none;", 
						targetTypes = {},
						noTargetTypes = noTargetTypesAll })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.PROHIBIT_WP_PASS_REPORT, value = true })
				},
			},
			['CAP'] = {
				{ create = createAutoActionById, data = ActionId.CAP },
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.PROHIBIT_AG, value = true })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.MISSILE_ATTACK, value = OptionValue.RANDOM_RANGE })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.PROHIBIT_WP_PASS_REPORT, value = true })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.RADIO_USAGE_CONTACT, value = "none;", 
						targetTypes = {},
						noTargetTypes = noTargetTypesAll })
				}
			},
			['SEAD'] = {
				{ create = createAutoActionById, data = ActionId.SEAD },
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.REACTION_ON_THREAT, value = OptionValue.EVADE_FIRE })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.ECM_USING, value = OptionValue.USE_IF_DETECTED_LOCK_BY_RADAR })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.PROHIBIT_WP_PASS_REPORT, value = true })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.RADIO_USAGE_CONTACT, value = "Air Defence;", 
						targetTypes = {[1] = "Air Defence",},
						noTargetTypes = noTargetTypesAirDefence })
				}
			},
			['Antiship Strike'] = {
				{ create = createAutoActionById, data = ActionId.ANTI_SHIP },
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.REACTION_ON_THREAT, value = OptionValue.PASSIVE_DEFENCE })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.RADAR_USING, value = OptionValue.USE_FOR_ATTACK_ONLY })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.FORMATION, value = 131074, variantIndex = 2, formationIndex = 2 })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.PROHIBIT_JETT, value = true })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.RADIO_USAGE_CONTACT, value = "none;", 
						targetTypes = {},
						noTargetTypes = noTargetTypesAll })
				}
			},
			['AFAC'] = {
				{ create = createAutoActionById, data = ActionId.FAC }				
			},
			['Escort'] = {
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.PROHIBIT_AG, value = true })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.MISSILE_ATTACK, value = OptionValue.RANDOM_RANGE })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.PROHIBIT_WP_PASS_REPORT, value = true })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.RADIO_USAGE_CONTACT, value = "none;", 
						targetTypes = {},
						noTargetTypes = noTargetTypesAll })
				}				
			},
			['Intercept'] = {
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.PROHIBIT_AG, value = true })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.MISSILE_ATTACK, value = OptionValue.RANDOM_RANGE })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.PROHIBIT_WP_PASS_REPORT, value = true })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.RADIO_USAGE_CONTACT, value = "none;", 
						targetTypes = {},
						noTargetTypes = noTargetTypesAll })
				}				
			},
			['Ground Attack'] = {
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.REACTION_ON_THREAT, value = OptionValue.PASSIVE_DEFENCE })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.RADAR_USING, value = OptionValue.USE_FOR_ATTACK_ONLY })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.FORMATION, value = 131074, variantIndex = 2, formationIndex = 2 })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.PROHIBIT_JETT, value = true })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.RADIO_USAGE_CONTACT, value = "none;", 
						targetTypes = {},
						noTargetTypes = noTargetTypesAll })
				}
			},
			['Pinpoint Strike'] = {
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.REACTION_ON_THREAT, value = OptionValue.PASSIVE_DEFENCE })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.RADAR_USING, value = OptionValue.USE_FOR_ATTACK_ONLY })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.FORMATION, value = 131074, variantIndex = 2, formationIndex = 2 })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.PROHIBIT_JETT, value = true })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.RADIO_USAGE_CONTACT, value = "none;", 
						targetTypes = {},
						noTargetTypes = noTargetTypesAll })
				}
			},
			['Runway Attack'] = {
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.REACTION_ON_THREAT, value = OptionValue.PASSIVE_DEFENCE })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.RADAR_USING, value = OptionValue.USE_FOR_ATTACK_ONLY })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.FORMATION, value = 131074, variantIndex = 2, formationIndex = 2 })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.PROHIBIT_JETT, value = true })
				},
				{ 	
					create = createAutoActionCopy, 
					data = makeWrappedAction('Option', { name = OptionName.RADIO_USAGE_CONTACT, value = "none;", 
						targetTypes = {},
						noTargetTypes = noTargetTypesAll })
				}
			},	
		},
		['vehicle'] = {
			['Default'] = {
				{ create = createAutoActionById, data = ActionId.EPLRS },
				{ create = createAutoActionById, data = ActionId.EWR }
			}
		},
		['ship'] = {
			['Default'] = {
				{ create = createAutoActionById, data = ActionId.ACTIVATE_TACAN }
			}	
		}
	}	
	
	local function addAutoActions_(actions, group, tbl)
		if actions then
			for autoActionindex, autoActionCreator in base.pairs(actions) do			
				local autoAction = autoActionCreator.create(group, group.route.points[1], autoActionCreator.data)
				if autoAction ~= nil then
					tbl = tbl or {}					
					autoAction.number = #tbl + 1
					autoAction.auto = true
					autoAction.valid = nil
					autoAction.enabled = true					
					base.table.insert(tbl, autoAction)
				end
			end
		end
		return tbl
	end	

	function createAutoActions(group, groupTask)
		local autoActionsByGroupType = autoActions[group.type] or autoActions['all']
		if autoActionsByGroupType then
			local firstUnit = group.units[1]
			local result = addAutoActions_(autoActionsByGroupType[groupTask], group)
			if groupTask ~= 'Default' then
				result = addAutoActions_(autoActionsByGroupType['Default'], group, result)
			end
			return result
		end
	end	
	
	function createAutoTaskFor(group, wpt, actionId, number)
		local actionData = actionsData[actionId]	
		if isGroupCapableOfAction(group, wpt, actionData) == nil then
			local autoTask = { number = number, auto = true, valid = nil, enabled = true }
			setTask_(autoTask, group, actionData)
			return autoTask
		end
	end
end

function createDefaultTask(group, number)
	return createNewTask(actionTypeData[defaultActionType].defaultActionId, group, number)
end

function setTask(task, group, actionId)
	local actionData = actionsData[actionId]
	task.key = nil
	task.params = nil
	setTask_(task, group, actionData)
	return task
end

function createNewTask(actionId, group, number)
	local actionData = actionsData[actionId]
	local task = { number = number, auto = false, valid = nil, enabled = true }
	return setTask_(task, group, actionData)
end

allowToEditAutoTasks = true
