local cpt_cmn_folder = folder.."../../../Cockpit/Common/"
dofile(cpt_cmn_folder.."devices.lua")
dofile(cpt_cmn_folder.."command_defs.lua")
dofile(folder.."../../input_tools.lua")

local res
if isJoystick(deviceName) then
	res = {keyCommands = {}, axisCommands = {}}
else
	res = {keyCommands = {}}
end
	
local function addInputEntryKey(defs, keyb_combos, joy_combos)
	addInputEntryKeyCmn(res.keyCommands, deviceName, defs, keyb_combos, joy_combos)
end

local function addInputEntryAxis(defs, combos)
	addInputEntryAxisCmn(res.axisCommands, deviceName, defs, combos)
end

----------------------------------------------------------------

addInputEntryKey({down = iCommandCockpitShowPilotOnOff, 										name = _('Show Pilot Body'), 			category = _('General')},
	{{key = 'P', reformers = {'RShift'}}})	
	
----------------------------------------------------------------	
--Flight Control	
--addInputEntryKey({down = iCommandPlaneTrimCancel, 											name = 'Trim Reset', 					category = _('Flight Control')},
--	{{key = 'T', reformers = {'LCtrl'}}})

----------------------------------------------------------------
-- Pilot Stick show/hide
--addInputEntryKey({down = 8032, cockpit_device_id = devices.SYSTEMS, value_down = 1.0, 		name = _('SHOW/HIDE FLIGHT STICK'), 	category = {_('Flight Control')})
	
----------------------------------------------------------------	
-- Pilot stick
addInputEntryKey({down = iCommandPlaneUpStart, 			up = iCommandPlaneUpStop, 				name = _('Aircraft Pitch Down'), 		category = _('Flight Control')},
	{{key = 'Up'}})	
addInputEntryKey({down = iCommandPlaneDownStart,			up = iCommandPlaneDownStop,			name = _('Aircraft Pitch Up'),			category = _('Flight Control')},
	{{key = 'Down'}})	
addInputEntryKey({down = iCommandPlaneLeftStart,			up = iCommandPlaneLeftStop,			name = _('Aircraft Bank Left'),			category = _('Flight Control')},
	{{key = 'Left'}})	
addInputEntryKey({down = iCommandPlaneRightStart,			up = iCommandPlaneRightStop,		name = _('Aircraft Bank Right'),		category = _('Flight Control')},
	{{key = 'Right'}})
	
----------------------------------------------------------------	
-- Rudder
addInputEntryKey({down = iCommandPlaneLeftRudderStart,	up = iCommandPlaneLeftRudderStop,		name = _('Aircraft Rudder Left'),		category = _('Flight Control')},
	{{key = 'Z'}})		
addInputEntryKey({down = iCommandPlaneRightRudderStart,	up = iCommandPlaneRightRudderStop,		name = _('Aircraft Rudder Right'),		category = _('Flight Control')},
	{{key = 'X'}})

----------------------------------------------------------------	
-- Pilot stick trim
addInputEntryKey({pressed = iCommandPlaneTrimUp,			up = iCommandPlaneTrimStop, 		name = _('Trim: Nose Up'),				category = _('Flight Control')}, 
	{{key = '.', reformers = {'RCtrl'}}})
addInputEntryKey({pressed = iCommandPlaneTrimDown,		up = iCommandPlaneTrimStop, 			name = _('Trim: Nose Down'),			category = _('Flight Control')},
	{{key = ';', reformers = {'RCtrl'}}})	
addInputEntryKey({pressed = iCommandPlaneTrimLeft,		up = iCommandPlaneTrimStop,				name = _('Trim: Left Wing Down'),		category = _('Flight Control')},
	{{key = ',', reformers = {'RCtrl'}}})	
addInputEntryKey({pressed = iCommandPlaneTrimRight,		up = iCommandPlaneTrimStop, 			name = _('Trim: Right Wing Down'),		category = _('Flight Control')},
	{{key = '/', reformers = {'RCtrl'}}})
	
----------------------------------------------------------------	
-- Rudder trim
--addInputEntryKey({pressed = iCommandPlaneTrimLeftRudder,	up = iCommandPlaneTrimStop, 		name = _('Trim: Rudder Left'),			category = _('Flight Control')},
--	{{key = 'Z', reformers = {'RCtrl'}}})		
--addInputEntryKey({pressed = iCommandPlaneTrimRightRudder,	up = iCommandPlaneTrimStop, 		name = _('Trim: Rudder Right'),			category = _('Flight Control')},
--	{{key = 'X', reformers = {'RCtrl'}}})		

----------------------------------------------------------------	
-- Throttle
addInputEntryKey({pressed = iCommandThrottleIncrease, 	up = iCommandThrottleStop,  			name = _('Throttle Up'),				category = _('Flight Control')},
	{{key = 'Num+'}})		
addInputEntryKey({pressed = iCommandThrottleDecrease, 	up = iCommandThrottleStop, 				name = _('Throttle Down'),				category = _('Flight Control')},
	{{key = 'Num-'}})		

----------------------------------------------------------------	
-- Speedbrake
addInputEntryKey({down = iCommandPlaneAirBrake,			up = iCommandPlaneAirBrakeOff, 			name = _('Airbrake'),					category = _('Systems'), features = {"airbrake"}},
	{{key = 'B'}})
addInputEntryKey({down = iCommandPlaneAirBrakeOn,												name = _('Airbrake On'),				category = _('Systems') , features = {"airbrake"}},
	{{key = 'B', reformers = {'LShift'}}})
addInputEntryKey({down = iCommandPlaneAirBrakeOff,												name = _('Airbrake Off'),				category = _('Systems'), features = {"airbrake"}},
	{{key = 'B', reformers = {'LCtrl'}}})

----------------------------------------------------------------	
-- Slat/flap					
addInputEntryKey({down = iCommandPlaneFlaps,													name = _('Slat/Flap lever - one step up/down'),		category = _('Systems')},
	{{key = 'F'}})
addInputEntryKey({down = iCommandPlaneFlapsOn,													name = _('Slat/Flap lever - one step down'),		category = _('Systems')},
	{{key = 'F', reformers = {'LShift'}}})
addInputEntryKey({down = iCommandPlaneFlapsOff,													name = _('Slat/Flap lever - one step up'),			category = _('Systems')},
	{{key = 'F', reformers = {'LCtrl'}}})

----------------------------------------------------------------	
-- Landing gear
addInputEntryKey({down = iCommandPlaneGear,														name = _('Landing Gear Up/Down'),					category = _('Systems')},
	{{key = 'G'}})
addInputEntryKey({down = iCommandPlaneGearUp,													name = _('Landing Gear Up'),						category = _('Systems')},
	{{key = 'G', reformers = {'LCtrl'}}})
addInputEntryKey({down = iCommandPlaneGearDown,													name = _('Landing Gear Down'),						category = _('Systems')},
	{{key = 'G', reformers = {'LShift'}}})

----------------------------------------------------------------	
-- Wheelbrake
addInputEntryKey({down = iCommandPlaneWheelBrakeOn, up = iCommandPlaneWheelBrakeOff, 			name = _('Wheel Brake On'),							category = _('Systems')},
	{{key = 'W'}})

--addInputEntryKey({down = iCommandPlaneFonar,													name = _('Canopy Open/Close'),						category = _('Systems')},
--	{{key = 'C', reformers = {'LCtrl'}}})							
							
addInputEntryKey({down = iCommandPlaneEject,													name = _('Eject (3 times)'),						category = _('Systems')},
	{{key = 'E', reformers = {'LCtrl'}}})

----------------------------------------------------------------
-- Cheat
addInputEntryKey({down = iCommandEnginesStart, 													name = ('Auto Start'), 								category = _('Cheat')},
	{{key = 'Home',  reformers = {'LWin'}}})																				
addInputEntryKey({down = iCommandEnginesStop,  													name = ('Auto Stop') , 								category = _('Cheat')},
	{{key = 'End' ,  reformers = {'LWin'}}})

----------------------------------------------------------------
-- View Cockpit
addInputEntryKey({down = iCommandToggleMirrors,													name = _('Toggle Mirrors'),							category = _('View Cockpit'), features = {"Mirrors"}},
	{{key = 'M' }})

----------------------------------------------------------------
-- Cockpit Camera Motion
addInputEntryKey({down = iCommandViewTransposeModeOn, up = iCommandViewTransposeModeOff, 		name = _('Camera transpose mode (press and hold)'), category = _('View Cockpit')},
	{{key = 'F1', reformers = {'LShift'}}})
addInputEntryKey({down = iCommand_ExplorationStart, 											name = _('Enable visual recon mode'), 				category = _('View Cockpit')})

----------------------------------------------------------------
--Wheel brake
addInputEntryKey({down = iCommandPlaneWheelBrakeLeftOn, up = iCommandPlaneWheelBrakeLeftOff, 	name = _('Wheel Brake Left On/Off'), 				category = _('Systems')},
	{{key = 'X', reformers = {'LCtrl'}}})
addInputEntryKey({down = iCommandPlaneWheelBrakeRightOn, up = iCommandPlaneWheelBrakeRightOff, 	name = _('Wheel Brake Right On/Off'), 				category = _('Systems')},
	{{key = 'X', reformers = {'LAlt'}}})

----------------------------------------------------------------
-- Helmet glass
addInputEntryKey({down = 8028, cockpit_device_id = devices.HELMET, name = _('Helmet glass'), category =_('General')},
	{{key = 'H'}})

----------------------------------------------------------------
-- Incidence test switch
addInputEntryKey({down = devCmds.Cmd10, up = devCmds.Cmd10, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Incidence test switch - INC'), category = {_('Left console'), _('Air data system')}})
addInputEntryKey({down = devCmds.Cmd11, up = devCmds.Cmd11, cockpit_device_id = devices.MAIN, value_down = -1.0, value_up = 0.0, name = _('Incidence test switch - DEC'), category = {_('Left console'), _('Air data system')}})

----------------------------------------------------------------
-- Flying aid and autopilot interlocks test display unit.

-- Flight control test restart button
addInputEntryKey({down = devCmds.Cmd12, up = devCmds.Cmd12, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Flight control test restart button'), category = {_('Left console'), _('Flight controls and flying aids')}})
-- Flight control test switch guard
addInputEntryKey({down = devCmds.Cmd13, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Flight control test switch guard - OPEN'), category = {_('Left console'), _('Flight controls and flying aids')}})
addInputEntryKey({down = devCmds.Cmd13, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Flight control test switch guard - CLOSE'), category = {_('Left console'), _('Flight controls and flying aids')}})
-- Flight control test switch
addInputEntryKey({down = devCmds.Cmd14, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Flight control test switch - ON'), category = {_('Left console'), _('Flight controls and flying aids')}})
addInputEntryKey({down = devCmds.Cmd14, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Flight control test switch - OFF'), category = {_('Left console'), _('Flight controls and flying aids')}})

----------------------------------------------------------------
-- Flight Control System controls

-- Servo reset button
addInputEntryKey({down = devCmds.Cmd20, up = devCmds.Cmd20, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Servo reset button'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
	{{key = 'S', reformers = {"RAlt"}}})
-- Stick uncouple switch
addInputEntryKey({down = devCmds.Cmd21, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Stick uncouple switch - ON'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
	{{key = 'S', reformers = {"RCtrl", "RShift"}}})
addInputEntryKey({down = devCmds.Cmd21, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Stick uncouple switch - OFF'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
	{{key = 'S', reformers = {"RCtrl", "RAlt"}}})
-- Stick uncouple switch guard
addInputEntryKey({down = devCmds.Cmd22, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Stick uncouple switch guard - OPEN'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
	{{key = 'S', reformers = {"LCtrl", "LShift"}}})
addInputEntryKey({down = devCmds.Cmd22, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Stick uncouple switch guard - CLOSE'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
	{{key = 'S', reformers = {"LCtrl", "LAlt"}}})
-- ARTHUR selector switch guard
addInputEntryKey({down = devCmds.Cmd23, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('ARTHUR selector switch guard - OPEN'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
	{{key = 'A', reformers = {"LCtrl", "LShift"}}})
addInputEntryKey({down = devCmds.Cmd23, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('ARTHUR selector switch guard - CLOSE'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
	{{key = 'A', reformers = {"LCtrl", "LAlt"}}})
-- ARTHUR selector switch	
addInputEntryKey({down = devCmds.Cmd24, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('ARTHUR selector switch - AUTO'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
	{{key = 'A', reformers = {"RCtrl"}}})
addInputEntryKey({down = devCmds.Cmd24, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('ARTHUR selector switch - HIGH'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
	{{key = 'A', reformers = {"RCtrl", "RShift"}}})
addInputEntryKey({down = devCmds.Cmd24, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('ARTHUR selector switch - LOW'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
	{{key = 'A', reformers = {"RCtrl", "RAlt"}}})
-- Yaw/Anti-slip switch	
addInputEntryKey({down = devCmds.Cmd25, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Yaw/Anti-slip switch - ANTI-SLIP'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
	{{key = 'Y', reformers = {"RCtrl", "RShift"}}})
addInputEntryKey({down = devCmds.Cmd25, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Yaw/Anti-slip switch - YAW'), category = {_('Left front panel'), _('Flight controls and flying aids')}})
addInputEntryKey({down = devCmds.Cmd25, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Yaw/Anti-slip switch - OFF'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
	{{key = 'Y', reformers = {"RCtrl", "RAlt"}}})
-- Pitch switch
addInputEntryKey({down = devCmds.Cmd26, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Pitch switch - ON'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
	{{key = 'P', reformers = {"RCtrl", "RShift"}}})
addInputEntryKey({down = devCmds.Cmd26, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Pitch switch - OFF'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
	{{key = 'P', reformers = {"RCtrl", "RAlt"}}})
-- Rudder trim control switch	
addInputEntryKey({down = devCmds.Cmd27, up = devCmds.Cmd27, cockpit_device_id = devices.MAIN,	value_down = 1.0, value_up = 0.0, name = _('Rudder trim control switch left'), category = {_('Left console'), _('Flight controls and flying aids')}},
	{{key = 'Z', reformers = {'RCtrl'}}})
addInputEntryKey({down = devCmds.Cmd28, up = devCmds.Cmd28, cockpit_device_id = devices.MAIN,	value_down = -1.0, value_up = 0.0, name = _('Rudder trim control switch right'),	category = {_('Left console'), _('Flight controls and flying aids')}},
	{{key = 'X', reformers = {'RCtrl'}}})

----------------------------------------------------------------
-- Autopilot

-- Autopilot PA button
addInputEntryKey({down = devCmds.Cmd35, up = devCmds.Cmd35, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Autopilot PA button'), category = {_('Central front panel'), _('Autopilot')}},
	{{key = 'P', reformers = {"RShift"}}})
-- Autopilot ALT button
addInputEntryKey({down = devCmds.Cmd36, up = devCmds.Cmd36, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Autopilot ALT button'), category = {_('Central front panel'), _('Autopilot')}},
	{{key = 'P', reformers = {"LShift"}}})
-- Autopilot CAP button
addInputEntryKey({down = devCmds.Cmd37, up = devCmds.Cmd37, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Autopilot CAP button'), category = {_('Central front panel'), _('Autopilot')}},
	{{key = 'P', reformers = {"LCtrl"}}})
-- Autopilot R button
addInputEntryKey({down = devCmds.Cmd38, up = devCmds.Cmd38, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Autopilot R button'), category = {_('Central front panel'), _('Autopilot')}},
	{{key = 'P', reformers = {"LAlt"}}})
-- Autopilot G button
addInputEntryKey({down = devCmds.Cmd39, up = devCmds.Cmd39, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Autopilot G button'), category = {_('Central front panel'), _('Autopilot')}},
	{{key = 'P', reformers = {"RAlt"}}})
-- Autopilot disconnect trigger
addInputEntryKey({down = devCmds.Cmd40, up = devCmds.Cmd40, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Autopilot disconnect trigger'), category = {_('Control stick'), _('Autopilot')}},
	{{key = 'A'}})
-- Autopilot intensity control
addInputEntryKey({pressed = devCmds.Cmd41, cockpit_device_id = devices.MAIN, value_pressed = 1, name = _('Autopilot intensity control increase'), category = {_('Central front panel'), _('Autopilot')}})
addInputEntryKey({pressed = devCmds.Cmd41, cockpit_device_id = devices.MAIN, value_pressed = -1, name = _('Autopilot intensity control decrease'), category = {_('Central front panel'), _('Autopilot')}})
-- Autopilot control and indicator unit test button
addInputEntryKey({down = devCmds.Cmd42, up = devCmds.Cmd42, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Autopilot control and indicator unit test button'), category = {_('Central front panel'), _('Autopilot')}})
-- Autopilot disengage lever
addInputEntryKey({down = devCmds.Cmd630, up = devCmds.Cmd630, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Autopilot disengage lever'), category = {_('Control stick'), _('Autopilot')}},
	{{key = 'P'}})

----------------------------------------------------------------
-- Engine/Fuel controls

-- Throttle cut/idle switch
addInputEntryKey({down = devCmds.Cmd51, up = devCmds.Cmd51, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Throttle cut/idle switch'), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'I'}})
-- Engine restart switch
addInputEntryKey({down = devCmds.Cmd52, up = devCmds.Cmd53, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('In-flight relight control'), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'E', reformers = {"LAlt"}}})
-- Ignition/Ventilation selector switch - 'R/H', 'L/H', 'Ventil'
addInputEntryKey({down = devCmds.Cmd54, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _("Ignition/Ventilation selector switch - L/H"), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'I', reformers = {"RAlt"}}})
addInputEntryKey({down = devCmds.Cmd54, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _("Ignition/Ventilation selector switch - R/H"), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'I', reformers = {"RCtrl"}}})
addInputEntryKey({down = devCmds.Cmd54, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _("Ignition/Ventilation selector switch - VENTIL"), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'I', reformers = {"RShift"}}})
-- Start button cover
addInputEntryKey({down = devCmds.Cmd55, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Start button cover - OPEN'), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'E', reformers = {"LCtrl", "LShift"}}})
addInputEntryKey({down = devCmds.Cmd55, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Start button cover - CLOSE'), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'E', reformers = {"LCtrl", "LAlt"}}})
-- Start button
addInputEntryKey({down = devCmds.Cmd56, up = devCmds.Cmd56, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Start button'), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'E', reformers = {"LShift"}}})
-- LP main cock switch guard
addInputEntryKey({down = devCmds.Cmd57, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('LP main cock switch guard - OPEN'), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'F', reformers = {"LCtrl", "LShift"}}})
addInputEntryKey({down = devCmds.Cmd57, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('LP main cock switch guard - CLOSE'), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'F', reformers = {"LCtrl", "LAlt"}}})
-- LP main cock switch
addInputEntryKey({down = devCmds.Cmd58, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('LP main cock switch - OFF'), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'F', reformers = {"RCtrl", "RShift"}}})
addInputEntryKey({down = devCmds.Cmd58, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('LP main cock switch - OPEN'), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'F', reformers = {"RCtrl", "RAlt"}}})
-- JPT emergency regulation switch
addInputEntryKey({down = devCmds.Cmd62, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('JPT emergency regulation switch - AUTO'), category = {_('Left console'), _('Engine/Fuel controls')}})
addInputEntryKey({down = devCmds.Cmd62, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('JPT emergency regulation switch - OFF'), category = {_('Left console'), _('Engine/Fuel controls')}})
-- A/B main cock switch guard
addInputEntryKey({down = devCmds.Cmd63, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('A/B main cock switch guard - OPEN'), category = {_('Left console'), _('Engine/Fuel controls')}})
addInputEntryKey({down = devCmds.Cmd63, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('A/B main cock switch guard - CLOSE'), category = {_('Left console'), _('Engine/Fuel controls')}})
-- A/B main cock switch
addInputEntryKey({down = devCmds.Cmd64, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('A/B main cock switch - OFF'), category = {_('Left console'), _('Engine/Fuel controls')}})
addInputEntryKey({down = devCmds.Cmd64, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('A/B main cock switch - ON'), category = {_('Left console'), _('Engine/Fuel controls')}})
-- Starting pump switch
addInputEntryKey({down = devCmds.Cmd65, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Starting pump switch - ON'), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'S', reformers = {"RShift"}}})
addInputEntryKey({down = devCmds.Cmd65, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Starting pump switch - OFF'), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'S', reformers = {"RCtrl"}}})
-- R/H LP pump switch
addInputEntryKey({down = devCmds.Cmd66, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('R/H LP pump switch - ON'), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'U', reformers = {"RShift"}}})
addInputEntryKey({down = devCmds.Cmd66, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('R/H LP pump switch - OFF'), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'U', reformers = {"RCtrl"}}})
-- L/H LP pump switch
addInputEntryKey({down = devCmds.Cmd67, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('L/H LP pump switch - ON'), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'U', reformers = {"LShift"}}})
addInputEntryKey({down = devCmds.Cmd67, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('L/H LP pump switch - OFF'), category = {_('Left console'), _('Engine/Fuel controls')}},
	{{key = 'U', reformers = {"LCtrl"}}})
-- Shock-cone manual control switch
addInputEntryKey({down = devCmds.Cmd68, up = devCmds.Cmd68, cockpit_device_id = devices.MAIN,	value_down = 1.0, value_up = 0.0, name = _('Shock-cone manual control switch up'), category = {_('Central front panel'), _('Engine/Fuel controls')}})
addInputEntryKey({down = devCmds.Cmd69, up = devCmds.Cmd69, cockpit_device_id = devices.MAIN,	value_down = -1.0, value_up = 0.0, name = _('Shock-cone manual control switch down'),	category = {_('Central front panel'), _('Engine/Fuel controls')}})
-- Shock-cone pushbutton
addInputEntryKey({down = devCmds.Cmd70, up = devCmds.Cmd71, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Shock-cone pushbutton'), category = {_('Central front panel'), _('Engine/Fuel controls')}})
-- Firing fuel dipper switch
addInputEntryKey({down = devCmds.Cmd72, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Firing fuel dipper switch - ON'), category = {_('Right console'), _('Engine/Fuel controls')}})
addInputEntryKey({down = devCmds.Cmd72, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Firing fuel dipper switch - OFF'), category = {_('Right console'), _('Engine/Fuel controls')}})

----------------------------------------------------------------
-- Fuel quantity indicator

-- Feeder tank/Fuselage selector switch
addInputEntryKey({down = devCmds.Cmd75, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Feeder tank/Fuselage selector switch - FT'), category = {_('Central front panel'), _('Fuel system')}})
addInputEntryKey({down = devCmds.Cmd75, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Feeder tank/Fuselage selector switch - F'), category = {_('Central front panel'), _('Fuel system')}})
-- Fuel gauge test button
addInputEntryKey({down = devCmds.Cmd76, up = devCmds.Cmd76, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Fuel gauge test button'), category = {_('Central front panel'), _('Fuel system')}})

----------------------------------------------------------------
-- Jettisoning panel

-- Emergency jettison button guard
addInputEntryKey({down = devCmds.Cmd77, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Emergency jettison button guard - OPEN'), category = {_('Central front panel'), _('Fuel system')}},
	{{key = 'J', reformers = {"LCtrl", "LShift"}}})
addInputEntryKey({down = devCmds.Cmd77, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Emergency jettison button guard - CLOSE'), category = {_('Central front panel'), _('Fuel system')}},
	{{key = 'J', reformers = {"LCtrl", "LAlt"}}})
-- Emergency jettison button
addInputEntryKey({down = devCmds.Cmd78, up = devCmds.Cmd78, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Emergency jettison button'), category = {_('Central front panel'), _('Fuel system')}},
	{{key = 'J', reformers = {"LCtrl"}}})
-- Selective jettison button guard
addInputEntryKey({down = devCmds.Cmd79, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Selective jettison button guard - OPEN'), category = {_('Central front panel'), _('Fuel system')}},
	{{key = 'J', reformers = {"RCtrl", "RShift"}}})
addInputEntryKey({down = devCmds.Cmd79, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Selective jettison button guard - CLOSE'), category = {_('Central front panel'), _('Fuel system')}},
	{{key = 'J', reformers = {"RCtrl", "RAlt"}}})
-- Selective jettison button
addInputEntryKey({down = devCmds.Cmd80, up = devCmds.Cmd80, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Selective jettison button'), category = {_('Central front panel'), _('Fuel system')}},
	{{key = 'J', reformers = {"LAlt"}}})
-- Jettisoning selector switch
addInputEntryKey({down = devCmds.Cmd81, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Jettisoning selector switch - WING 2'), category = {_('Central front panel'), _('Fuel system')}},
	{{key = 'J', reformers = {"RShift"}}})
addInputEntryKey({down = devCmds.Cmd81, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Jettisoning selector switch - WING 1'), category = {_('Central front panel'), _('Fuel system')}},
	{{key = 'J', reformers = {"RCtrl"}}})
addInputEntryKey({down = devCmds.Cmd81, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Jettisoning selector switch - FUS'), category = {_('Central front panel'), _('Fuel system')}},
	{{key = 'J', reformers = {"LShift"}}})

----------------------------------------------------------------
-- Fuel transfer, refuelling and indication

-- Fuel quantity reset thumbwheel
addInputEntryKey({down = devCmds.Cmd82, up = devCmds.Cmd82, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Fuel quantity reset thumbwheel'), category = {_('Central front panel'), _('Fuel system')}})
-- Crossfeed switch
addInputEntryKey({down = devCmds.Cmd83, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Crossfeed switch - ON'), category = {_('Central front panel'), _('Fuel system')}})
addInputEntryKey({down = devCmds.Cmd83, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Crossfeed switch - OFF'), category = {_('Central front panel'), _('Fuel system')}})
-- Emergency transfer switch
addInputEntryKey({down = devCmds.Cmd84, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Emergency transfer switch - ON'), category = {_('Central front panel'), _('Fuel system')}})
addInputEntryKey({down = devCmds.Cmd84, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Emergency transfer switch - OFF'), category = {_('Central front panel'), _('Fuel system')}})
-- Fuel transfer sequence selector switch
addInputEntryKey({down = devCmds.Cmd85, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Fuel transfer sequence selector switch - CLEAN'), category = {_('Central front panel'), _('Fuel system')}})
addInputEntryKey({down = devCmds.Cmd85, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Fuel transfer sequence selector switch - WG. PYL. TK'), category = {_('Central front panel'), _('Fuel system')}})
-- Fuel transfer indicator test
addInputEntryKey({down = devCmds.Cmd86, up = devCmds.Cmd86, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Fuel transfer indicator test'), category = {_('Central front panel'), _('Fuel system')}})

----------------------------------------------------------------
-- Radar control stick

-- Radar control stick elevation/altitude difference button
addInputEntryKey({down = devCmds.Cmd100, up = devCmds.Cmd100, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Radar control stick elevation/altitude difference button'), category = {_('Left console'), _('Radar control stick')}})
-- Radar control stick scale selection
addInputEntryKey({down = devCmds.Cmd102, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Radar control stick scale selection - LEFT'), category = {_('Left console'), _('Radar control stick')}})
addInputEntryKey({down = devCmds.Cmd102, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Radar control stick scale selection - RIGHT'), category = {_('Left console'), _('Radar control stick')}})
-- Radar control stick scan selection
addInputEntryKey({down = devCmds.Cmd104, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Radar control stick scan selection - LEFT'), category = {_('Left console'), _('Radar control stick')}})
addInputEntryKey({down = devCmds.Cmd104, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Radar control stick scan selection - RIGHT'), category = {_('Left console'), _('Radar control stick')}})
-- Radar control stick bearing control (horizontal axis)
addInputEntryKey({down = devCmds.Cmd106, up = devCmds.Cmd106, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick bearing control - right'), category = {_('Left console'), _('Radar control stick')}})
addInputEntryKey({down = devCmds.Cmd107, up = devCmds.Cmd107, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick bearing control - left'), category = {_('Left console'), _('Radar control stick')}})
-- Radar control stick range/velocity control (vertical axis)
addInputEntryKey({down = devCmds.Cmd109, up = devCmds.Cmd109, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick range/velocity control - increase'), category = {_('Left console'), _('Radar control stick')}})
addInputEntryKey({down = devCmds.Cmd110, up = devCmds.Cmd110, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick range/velocity control - decrease'), category = {_('Left console'), _('Radar control stick')}})
-- Radar control stick elevation control buttons
addInputEntryKey({down = devCmds.Cmd111, up = devCmds.Cmd111, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick elevation increase button'), category = {_('Left console'), _('Radar control stick')}})
addInputEntryKey({down = devCmds.Cmd112, up = devCmds.Cmd112, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick elevation decrease button'), category = {_('Left console'), _('Radar control stick')}})
-- Radar control stick gain control wheel
addInputEntryKey({down = devCmds.Cmd114, up = devCmds.Cmd114, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick gain control wheel - increase'), category = {_('Left console'), _('Radar control stick')}})
addInputEntryKey({down = devCmds.Cmd115, up = devCmds.Cmd115, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick gain control wheel - decrease'), category = {_('Left console'), _('Radar control stick')}})
-- Radar control stick fast gain reset button
addInputEntryKey({down = devCmds.Cmd116, up = devCmds.Cmd116, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick fast gain reset button'), category = {_('Left console'), _('Radar control stick')}})
-- Radar control stick APS/APC lever - TWS
addInputEntryKey({down = devCmds.Cmd117, up = devCmds.Cmd117, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick APS/APC lever - TWS'), category = {_('Left console'), _('Radar control stick')}})
-- Radar control stick APS/APC lever - Lock-On
addInputEntryKey({down = devCmds.Cmd117, up = devCmds.Cmd117, cockpit_device_id = devices.MAIN, value_down = -1.0, value_up = 0.0, name = _('Radar control stick APS/APC lever - Lock-On'), category = {_('Left console'), _('Radar control stick')}})
-- Radar control stick unlocking control
addInputEntryKey({down = devCmds.Cmd118, up = devCmds.Cmd118, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick unlocking control'), category = {_('Left console'), _('Radar control stick')}})

----------------------------------------------------------------
-- Main PTT (VOIP)
addInputEntryKey({down = devCmds.Cmd119, up = devCmds.Cmd119, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('VoIP PTT button (custom)'), category = {_('Radio system')}})
-- Alternative PTT
addInputEntryKey({down = devCmds.Cmd120, up = devCmds.Cmd120, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Alternative PTT'), category = {_('Left console'), _('Radio system')}},
	{{key = 'T', reformers = {"RAlt"}}})

----------------------------------------------------------------
-- High-lift devices

-- Slat/Flap lever
addInputEntryKey({down = devCmds.Cmd122, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Slat/Flap lever - full flap'), category = {_('Left console'), _('High-lift devices')}},
	{{key = 'F', reformers = {"LWin"}}})
addInputEntryKey({down = devCmds.Cmd122, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Slat/Flap lever - 1/2 flap'), category = {_('Left console'), _('High-lift devices')}},
	{{key = 'F', reformers = {"RAlt"}}})
addInputEntryKey({down = devCmds.Cmd122, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Slat/Flap lever - full up'), category = {_('Left console'), _('High-lift devices')}},
	{{key = 'F', reformers = {"LAlt"}}})
addInputEntryKey({down = devCmds.Cmd122, up = devCmds.Cmd122, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.5, name = _('Slat/Flap lever - HOTAS flaps down'), category = {_('Left console'), _('High-lift devices')}})
addInputEntryKey({down = devCmds.Cmd122, up = devCmds.Cmd122, cockpit_device_id = devices.MAIN ,value_down = -1.0, value_up = 0.5, name = _('Slat/Flap lever - HOTAS flaps up'), category = {_('Left console'), _('High-lift devices')}})
-- High-lift device selector switch
addInputEntryKey({down = devCmds.Cmd123, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('High-lift device selector switch - NORMAL'), category = {_('Left console'), _('High-lift devices')}},
	{{key = 'H', reformers = {"LShift"}}})
addInputEntryKey({down = devCmds.Cmd123, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('High-lift device selector switch - OFF'), category = {_('Left console'), _('High-lift devices')}},
	{{key = 'H', reformers = {"LCtrl"}}})
addInputEntryKey({down = devCmds.Cmd123, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('High-lift device selector switch - EMG. RETR.'), category = {_('Left console'), _('High-lift devices')}},
	{{key = 'H', reformers = {"LAlt"}}})
-- Combat flap lever
addInputEntryKey({down = devCmds.Cmd638, up = devCmds.Cmd638, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Combat flap lever'), category = {_('Throttle lever'), _('High-lift devices')}},
	{{key = 'V', reformers = {"LCtrl"}}})
-- Combat flap button
addInputEntryKey({down = devCmds.Cmd639, up = devCmds.Cmd639, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Combat flap button'), category = {_('Throttle lever'), _('High-lift devices')}},
	{{key = 'V'}})

----------------------------------------------------------------
-- Radio selector unit

-- MISS potentiometer
addInputEntryKey({pressed = devCmds.Cmd125, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('MISS potentiometer - Increase'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}})
addInputEntryKey({pressed = devCmds.Cmd125, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('MISS potentiometer - Decrease'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}})
-- TAC potentiometer
addInputEntryKey({pressed = devCmds.Cmd127, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('TAC potentiometer - Increase'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}})
addInputEntryKey({pressed = devCmds.Cmd127, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('TAC potentiometer - Decrease'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}})
-- VOR potentiometer
addInputEntryKey({pressed = devCmds.Cmd129, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('VOR potentiometer - Increase'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}})
addInputEntryKey({pressed = devCmds.Cmd129, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('VOR potentiometer - Decrease'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}})
-- "AMPLI 2-1" selector switch
addInputEntryKey({down = devCmds.Cmd130, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('AMPLI 2-1" selector switch - 1'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}})
addInputEntryKey({down = devCmds.Cmd130, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('AMPLI 2-1" selector switch - 2'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}})
-- U + V pushbutton
addInputEntryKey({down = devCmds.Cmd131, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('U + V pushbutton - PUSH'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
	{{key = 'V', reformers = {"LCtrl", "LWin"}}})
addInputEntryKey({pressed = devCmds.Cmd133, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('U + V pushbutton - Increase'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
	{{key = 'V', reformers = {"LCtrl", "LShift"}}})
addInputEntryKey({pressed = devCmds.Cmd133, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('U + V pushbutton - Decrease'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
	{{key = 'V', reformers = {"LCtrl", "LAlt"}}})
-- U pushbutton
addInputEntryKey({down = devCmds.Cmd134, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('U pushbutton - PUSH'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
	{{key = 'U', reformers = {"LCtrl", "LWin"}}})
addInputEntryKey({pressed = devCmds.Cmd136, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('U pushbutton - Increase'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
	{{key = 'U', reformers = {"LCtrl", "LShift"}}})
addInputEntryKey({pressed = devCmds.Cmd136, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('U pushbutton - Decrease'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
	{{key = 'U', reformers = {"LCtrl", "LAlt"}}})
-- RAP + CME pushbutton
addInputEntryKey({down = devCmds.Cmd137, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('RAP + CME pushbutton - PUSH'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
	{{key = 'D', reformers = {"LCtrl", "LWin"}}})
addInputEntryKey({pressed = devCmds.Cmd139, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('RAP + CME pushbutton - Increase'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
	{{key = 'D', reformers = {"LCtrl", "LShift"}}})
addInputEntryKey({pressed = devCmds.Cmd139, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('RAP + CME pushbutton - Decrease'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
	{{key = 'D', reformers = {"LCtrl", "LAlt"}}})
-- MKR + TP pushbutton
addInputEntryKey({down = devCmds.Cmd140, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('MKR + TP pushbutton - PUSH'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
	{{key = 'K', reformers = {"LCtrl", "LWin"}}})
addInputEntryKey({pressed = devCmds.Cmd142, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('MKR + TP pushbutton - Increase'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
	{{key = 'K', reformers = {"LCtrl", "LShift"}}})
addInputEntryKey({pressed = devCmds.Cmd142, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('MKR + TP pushbutton - Decrease'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
	{{key = 'K', reformers = {"LCtrl", "LAlt"}}})

----------------------------------------------------------------
-- V/UHF radio control unit

-- Test selector switch
addInputEntryKey({down = devCmds.Cmd145, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('V/UHF control unit test selector switch - E + A2'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd145, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('V/UHF control unit test selector switch - R'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
-- SIL switch
addInputEntryKey({down = devCmds.Cmd146, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('SIL switch - ON'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd146, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('SIL switch - OFF'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
-- Frequency select thumbwheel - Hundreds
addInputEntryKey({down = devCmds.Cmd148, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Frequency select thumbwheel - Hundreds - Increase'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd148, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Frequency select thumbwheel - Hundreds - Decrease'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
-- Frequency select thumbwheel - Tens
addInputEntryKey({down = devCmds.Cmd150, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Frequency select thumbwheel - Tens - Increase'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd150, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Frequency select thumbwheel - Tens - Decrease'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
-- Frequency select thumbwheel - Units
addInputEntryKey({down = devCmds.Cmd152, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Frequency select thumbwheel - Units - Increase'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd152, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Frequency select thumbwheel - Units - Decrease'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
-- Frequency select thumbwheel - Tenths
addInputEntryKey({down = devCmds.Cmd154, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Frequency select thumbwheel - Tenths - Increase'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd154, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Frequency select thumbwheel - Tenths - Decrease'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
-- Frequency select thumbwheel - Thousandths
addInputEntryKey({down = devCmds.Cmd156, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Frequency select thumbwheel - Thousandths - Increase'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd156, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Frequency select thumbwheel - Thousandths - Decrease'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
-- Function selector
addInputEntryKey({down = devCmds.Cmd158, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('V/UHF control unit function selector - Clockwise'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd158, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('V/UHF control unit function selector - Counterclockwise'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
-- 25W - 5W switch
addInputEntryKey({down = devCmds.Cmd159, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('25W - 5W switch - 5W'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd159, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('25W - 5W switch - 25W'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
-- Frequency selector switch
addInputEntryKey({down = devCmds.Cmd161, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Frequency selector switch - Clockwise'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd161, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Frequency selector switch - Counterclockwise'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
-- Channel selector
addInputEntryKey({down = devCmds.Cmd163, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('V/UHF control unit channel selector - Clockwise'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd163, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('V/UHF control unit channel selector - Counterclockwise'), category = {_('Left console'), _('Radio system'), _('V/UHF radio control unit')}})

----------------------------------------------------------------
-- Engine emergency regulation

-- Emergency regulation light
addInputEntryKey({down = devCmds.Cmd165, up = devCmds.Cmd165, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Emergency regulation light - PUSH'), category = {_('Left wall'), _('Engine emergency regulation')}})
addInputEntryKey({pressed = devCmds.Cmd166, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Emergency regulation light - Increase'), category = {_('Left wall'), _('Engine emergency regulation')}})
addInputEntryKey({pressed = devCmds.Cmd166, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Emergency regulation light - Decrease'), category = {_('Left wall'), _('Engine emergency regulation')}})
-- Emergency regulation switch guard
addInputEntryKey({down = devCmds.Cmd167, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Emergency regulation switch guard - OPEN'), category = {_('Left wall'), _('Engine emergency regulation')}})
addInputEntryKey({down = devCmds.Cmd167, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Emergency regulation switch guard - CLOSE'), category = {_('Left wall'), _('Engine emergency regulation')}})
-- Emergency regulation switch
addInputEntryKey({down = devCmds.Cmd168, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Emergency regulation switch - ON'), category = {_('Left wall'), _('Engine emergency regulation')}})
addInputEntryKey({down = devCmds.Cmd168, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Emergency regulation switch - OFF'), category = {_('Left wall'), _('Engine emergency regulation')}},
	{{key = 'L', reformers = {"RCtrl", "RAlt"}}})
-- Emergency regulation control lever
addInputEntryKey({down = devCmds.Cmd169, up = devCmds.Cmd169, cockpit_device_id = devices.MAIN,	value_down = 1.0, value_up = 0.0, name = _('Emergency regulation control lever - Forward/Increase'), category = {_('Left wall'), _('Engine emergency regulation')}},
	{{key = 'PageUp'}})
addInputEntryKey({down = devCmds.Cmd170, up = devCmds.Cmd170, cockpit_device_id = devices.MAIN,	value_down = -1.0, value_up = 0.0, name = _('Emergency regulation control lever - Aft/Decrease'),	category = {_('Left wall'), _('Engine emergency regulation')}},
	{{key = 'PageDown'}})

-- Brake chute control
addInputEntryKey({down = devCmds.Cmd171, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Brake chute control - Aft/Open'), category = {_('Left wall'), _('Systems')}},
	{{key = 'B', reformers = {"RCtrl"}}})
addInputEntryKey({down = devCmds.Cmd171, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Brake chute control - Forward/Drop'), category = {_('Left wall'), _('Systems')}},
	{{key = 'B', reformers = {"RShift"}}})

----------------------------------------------------------------
-- Canopy controls

-- Canopy lock control
addInputEntryKey({down = devCmds.Cmd172, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Canopy lock control - Aft/Open'), category = {_('Right wall'), _('Systems')}})
addInputEntryKey({down = devCmds.Cmd172, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Canopy lock control - Forward/Close'), category = {_('Right wall'), _('Systems')}})
-- Canopy embrittle control
addInputEntryKey({down = devCmds.Cmd173, up = devCmds.Cmd173, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Canopy embrittle control'), category = {_('Left wall'), _('Systems')}})
-- Canopy hinged handle
addInputEntryKey({down = devCmds.Cmd174, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Canopy hinged handle - Extend'), category = {_('Front structure'), _('Systems')}})
addInputEntryKey({down = devCmds.Cmd174, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Canopy hinged handle - Retract'), category = {_('Front structure'), _('Systems')}})
-- Canopy seal valve control lever
addInputEntryKey({down = devCmds.Cmd175, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Canopy seal valve control lever - Deflate'), category = {_('Right wall'), _('Systems')}})
addInputEntryKey({down = devCmds.Cmd175, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Canopy seal valve control lever - Inflate'), category = {_('Right wall'), _('Systems')}})
-- Mirrors
addInputEntryKey({down = devCmds.Cmd176, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mirrors - Fold'), category = {_('Front structure'), _('Systems')}},
	{{key = 'M', reformers = {"RCtrl", "RShift"}}})
addInputEntryKey({down = devCmds.Cmd176, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Mirrors - Unfold'), category = {_('Front structure'), _('Systems')}},
	{{key = 'M', reformers = {"RCtrl", "RAlt"}}})
-- Canopy handle
addInputEntryKey({down = devCmds.Cmd178, cockpit_device_id = devices.MAIN, value_down = 0.99, name = _('Canopy handle - OPEN/CLOSE'), category = {_('Front structure'), _('Systems')}},
	{{key = 'C', reformers = {"LCtrl"}}})

----------------------------------------------------------------
-- Undercarriage, nose wheel steering, brake and anti-skid

-- U/C safety lever
addInputEntryKey({down = devCmds.Cmd190, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('U/C safety lever - OPEN'), category = {_('Left front panel'), _('Systems'), _('Undercarriage')}},
	{{key = 'G', reformers = {"LCtrl", "LShift"}}})
addInputEntryKey({down = devCmds.Cmd190, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('U/C safety lever - CLOSE'), category = {_('Left front panel'), _('Systems'), _('Undercarriage')}},
	{{key = 'G', reformers = {"LCtrl", "LAlt"}}})
-- U/C control lever
addInputEntryKey({down = devCmds.Cmd191, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('U/C control lever - Extend'), category = {_('Left front panel'), _('Systems'), _('Undercarriage')}},
	{{key = 'G', reformers = {"RShift"}}})
addInputEntryKey({down = devCmds.Cmd191, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('U/C control lever - Retract'), category = {_('Left front panel'), _('Systems'), _('Undercarriage')}},
	{{key = 'G', reformers = {"RCtrl"}}})
-- Anti-retraction override button
addInputEntryKey({down = devCmds.Cmd192, up = devCmds.Cmd192, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Anti-retraction override button'), category = {_('Left front panel'), _('Systems'), _('Undercarriage')}})
-- Emergency/Parking brake handle
addInputEntryKey({down = devCmds.Cmd193, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Emergency/Parking brake handle - Push/Release'), category = {_('Left front panel'), _('Systems'), _('Braking system')}},
	{{key = 'W', reformers = {"LShift"}}})
addInputEntryKey({down = devCmds.Cmd193, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Emergency/Parking brake handle - Pull/Set'), category = {_('Left front panel'), _('Systems'), _('Braking system')}},
	{{key = 'W', reformers = {"LCtrl"}}})
-- Anti-skid (SPAD) switch guard
addInputEntryKey({down = devCmds.Cmd194, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Anti-skid (SPAD) switch guard - OPEN'), category = {_('Central front panel'), _('Systems'), _('Anti-skid')}},
	{{key = 'K', reformers = {"RCtrl", "RShift"}}})
addInputEntryKey({down = devCmds.Cmd194, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Anti-skid (SPAD) switch guard - CLOSE'), category = {_('Central front panel'), _('Systems'), _('Anti-skid')}},
	{{key = 'K', reformers = {"RCtrl", "RAlt"}}})
-- Anti-skid (SPAD) switch
addInputEntryKey({down = devCmds.Cmd195, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Anti-skid (SPAD) switch - OFF'), category = {_('Central front panel'), _('Systems'), _('Anti-skid')}},
	{{key = 'K', reformers = {"RCtrl"}}})
addInputEntryKey({down = devCmds.Cmd195, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Anti-skid (SPAD) switch - ON'), category = {_('Central front panel'), _('Systems'), _('Anti-skid')}},
	{{key = 'K', reformers = {"RAlt"}}})
-- Nose wheel steering high sensitivity button
addInputEntryKey({down = devCmds.Cmd196, up = devCmds.Cmd197, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Nose wheel steering high sensitivity button'), category = {_('Central front panel'), _('Systems'), _('Nose wheel steering')}},
	{{key = 'N', reformers = {"LAlt"}}})
-- Nose wheel steering switch guard
addInputEntryKey({down = devCmds.Cmd198, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Nose wheel steering switch guard - OPEN'), category = {_('Central front panel'), _('Systems'), _('Nose wheel steering')}},
	{{key = 'N', reformers = {"LCtrl", "LShift"}}})
addInputEntryKey({down = devCmds.Cmd198, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Nose wheel steering switch guard - CLOSE'), category = {_('Central front panel'), _('Systems'), _('Nose wheel steering')}},
	{{key = 'N', reformers = {"LCtrl", "LAlt"}}})
-- Nose wheel steering switch
addInputEntryKey({down = devCmds.Cmd199, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Nose wheel steering switch - OFF'), category = {_('Central front panel'), _('Systems'), _('Nose wheel steering')}},
	{{key = 'N', reformers = {"LCtrl"}}})
addInputEntryKey({down = devCmds.Cmd199, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Nose wheel steering switch - ON'), category = {_('Central front panel'), _('Systems'), _('Nose wheel steering')}},
	{{key = 'N', reformers = {"LShift"}}})
-- Emergency U/C handle
addInputEntryKey({down = devCmds.Cmd200, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Emergency U/C handle - NORMAL'), category = {_('Right front panel'), _('Systems'), _('Undercarriage')}})
addInputEntryKey({down = devCmds.Cmd200, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Emergency U/C handle - DOORS'), category = {_('Right front panel'), _('Systems'), _('Undercarriage')}})
addInputEntryKey({down = devCmds.Cmd200, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Emergency U/C handle - U/C'), category = {_('Right front panel'), _('Systems'), _('Undercarriage')}})

----------------------------------------------------------------
-- Hydraulic system controls

-- Hydraulic pressure selector switch
addInputEntryKey({down = devCmds.Cmd201, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Hydraulic pressure selector switch - 1 SERVO 2'), category = {_('Central front panel'), _('Systems'), _('Hydraulic system')}})
addInputEntryKey({down = devCmds.Cmd201, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Hydraulic pressure selector switch - ANC Em.B'), category = {_('Central front panel'), _('Systems'), _('Hydraulic system')}})
-- Electro-pump switch
addInputEntryKey({down = devCmds.Cmd202, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Electro-pump switch - ON'), category = {_('Right console'), _('Systems'), _('Hydraulic system')}})
addInputEntryKey({down = devCmds.Cmd202, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Electro-pump switch - OFF'), category = {_('Right console'), _('Systems'), _('Hydraulic system')}})

----------------------------------------------------------------
-- Air data system and miscellaneous instrument controls 

----------------------------------------------------------------
-- Clock

-- Chronometer starting control and clock winding/setting knob
addInputEntryKey({down = devCmds.Cmd210, up = devCmds.Cmd210, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Chronometer starting control'), category = {_('Front structure'), _('Clock')}},
	{{key = 'W', reformers = {"RAlt"}}})
addInputEntryKey({pressed = devCmds.Cmd211, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Clock winding/setting knob - Clockwise'), category = {_('Front structure'), _('Clock')}})
addInputEntryKey({pressed = devCmds.Cmd211, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Clock winding/setting knob - Counterclockwise'), category = {_('Front structure'), _('Clock')}})
-- Clock winding/setting lever
addInputEntryKey({down = devCmds.Cmd212, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Clock winding/setting lever - Setting'), category = {_('Front structure'), _('Clock')}})
addInputEntryKey({down = devCmds.Cmd212, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Clock winding/setting lever - Winding'), category = {_('Front structure'), _('Clock')}})

----------------------------------------------------------------
-- Incidence indicator

-- Incidence indicator lighting rheostat
addInputEntryKey({pressed = devCmds.Cmd214, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Incidence indicator lighting rheostat - Increase'), category = {_('Front structure'), _('Air data system')}})
addInputEntryKey({pressed = devCmds.Cmd214, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Incidence indicator lighting rheostat - Decrease'), category = {_('Front structure'), _('Air data system')}})

----------------------------------------------------------------
-- Air data instrument controls

-- Mach/Airspeed indicator reference airspeed knob
addInputEntryKey({pressed = devCmds.Cmd219, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Mach/Airspeed indicator reference airspeed knob - Increase'), category = {_('Central front panel'), _('Air data system')}},
	{{key = 'S', reformers = {"LCtrl", "LWin"}}})
addInputEntryKey({pressed = devCmds.Cmd219, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Mach/Airspeed indicator reference airspeed knob - Decrease'), category = {_('Central front panel'), _('Air data system')}},
	{{key = 'S', reformers = {"LShift", "LWin"}}})
-- Slaved altimeter barometric pressure setting knob
addInputEntryKey({pressed = devCmds.Cmd221, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Slaved altimeter barometric pressure setting knob - Increase'), category = {_('Central front panel'), _('Air data system')}},
	{{key = 'Z', reformers = {"LCtrl", "LWin"}}})
addInputEntryKey({pressed = devCmds.Cmd221, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Slaved altimeter barometric pressure setting knob - Decrease'), category = {_('Central front panel'), _('Air data system')}},
	{{key = 'Z', reformers = {"LShift", "LWin"}}})
-- Standby altimeter barometric pressure setting knob
addInputEntryKey({pressed = devCmds.Cmd223, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Standby altimeter barometric pressure setting knob - Increase'), category = {_('Central front panel'), _('Air data system')}},
	{{key = 'Z', reformers = {"RCtrl", "RShift"}}})
addInputEntryKey({pressed = devCmds.Cmd223, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Standby altimeter barometric pressure setting knob - Decrease'), category = {_('Central front panel'), _('Air data system')}},
	{{key = 'Z', reformers = {"RCtrl", "RAlt"}}})
-- Probe heater switch
addInputEntryKey({down = devCmds.Cmd224, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Probe heater switch - ON'), category = {_('Right console'), _('Air data system')}})
addInputEntryKey({down = devCmds.Cmd224, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Probe heater switch - OFF'), category = {_('Right console'), _('Air data system')}})

----------------------------------------------------------------
-- Heading and vertical reference system and standby horizon controls

-- Standby horizon switch
addInputEntryKey({down = devCmds.Cmd230, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Standby horizon switch - ON'), category = {_('Right console'), _('Heading and vertical reference system')}})
addInputEntryKey({down = devCmds.Cmd230, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Standby horizon switch - OFF'), category = {_('Right console'), _('Heading and vertical reference system')}})
-- Spherical indicator day/night selector switch
addInputEntryKey({pressed = devCmds.Cmd231, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Spherical indicator day/night selector switch - DAY'), category = {_('Central front panel'), _('Heading and vertical reference system')}})
addInputEntryKey({pressed = devCmds.Cmd231, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Spherical indicator day/night selector switch - NIGHT'), category = {_('Central front panel'), _('Heading and vertical reference system')}})
-- Spherical indicator pole setting and marker beacon light test
addInputEntryKey({down = devCmds.Cmd232, up = devCmds.Cmd232, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Marker beacon light test'), category = {_('Central front panel'), _('Heading and vertical reference system')}})
addInputEntryKey({pressed = devCmds.Cmd233, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Spherical indicator pole setting - P'), category = {_('Central front panel'), _('Heading and vertical reference system')}})
addInputEntryKey({pressed = devCmds.Cmd233, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Spherical indicator pole setting - N'), category = {_('Central front panel'), _('Heading and vertical reference system')}})
-- Standby horizon uncage and aircraft model control
addInputEntryKey({down = devCmds.Cmd234, up = devCmds.Cmd234, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Standby horizon uncage'), category = {_('Central front panel'), _('Heading and vertical reference system')}})
addInputEntryKey({pressed = devCmds.Cmd236, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Aircraft model control - UP'), category = {_('Central front panel'), _('Heading and vertical reference system')}})
addInputEntryKey({pressed = devCmds.Cmd236, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Aircraft model control - DOWN'), category = {_('Central front panel'), _('Heading and vertical reference system')}})

----------------------------------------------------------------
-- Heading control unit

-- Heading and vertical reference system control switch
addInputEntryKey({down = devCmds.Cmd238, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Heading and vertical reference system control switch - Clockwise'), category = {_('Right console'), _('Heading and vertical reference system')}},
	{{key = 'H', reformers = {"LWin", "LShift"}}})
addInputEntryKey({down = devCmds.Cmd238, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Heading and vertical reference system control switch - Counterclockwise'), category = {_('Right console'), _('Heading and vertical reference system')}},
	{{key = 'H', reformers = {"LWin", "LCtrl"}}})
-- Emergency gyromagnetic compass switch
addInputEntryKey({down = devCmds.Cmd239, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Emergency gyromagnetic compass switch - ON'), category = {_('Right console'), _('Heading and vertical reference system')}})
addInputEntryKey({down = devCmds.Cmd239, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Emergency gyromagnetic compass switch - OFF'), category = {_('Right console'), _('Heading and vertical reference system')}})
-- Heading control unit erection button
addInputEntryKey({down = devCmds.Cmd240, up = devCmds.Cmd240, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Heading control unit erection button'), category = {_('Central front panel'), _('Heading and vertical reference system')}})

----------------------------------------------------------------
-- Electrical system controls

-- Battery switch
addInputEntryKey({down = devCmds.Cmd250, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Battery switch - ON'), category = {_('Right front panel'), _('Electrical system')}})
addInputEntryKey({down = devCmds.Cmd250, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Battery switch - OFF'), category = {_('Right front panel'), _('Electrical system')}})
-- Alternator 1 switch
addInputEntryKey({down = devCmds.Cmd251, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Alternator 1 switch - ON'), category = {_('Right front panel'), _('Electrical system')}})
addInputEntryKey({down = devCmds.Cmd251, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Alternator 1 switch - OFF'), category = {_('Right front panel'), _('Electrical system')}})
-- Alternator 2 switch
addInputEntryKey({down = devCmds.Cmd252, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Alternator 2 switch - ON'), category = {_('Right front panel'), _('Electrical system')}})
addInputEntryKey({down = devCmds.Cmd252, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Alternator 2 switch - OFF'), category = {_('Right front panel'), _('Electrical system')}})
-- TR reset button
addInputEntryKey({down = devCmds.Cmd253, up = devCmds.Cmd253, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('TR reset button'), category = {_('Right front panel'), _('Electrical system')}})
-- Inverter selector switch
addInputEntryKey({down = devCmds.Cmd254, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Inverter selector switch - INV'), category = {_('Right front panel'), _('Electrical system')}})
addInputEntryKey({down = devCmds.Cmd254, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Inverter selector switch - AUTO'), category = {_('Right front panel'), _('Electrical system')}})
addInputEntryKey({down = devCmds.Cmd255, up = devCmds.Cmd255, cockpit_device_id = devices.MAIN ,value_down = -1.0, value_up = 0.0, name = _('Inverter selector switch - RESET'), category = {_('Right front panel'), _('Electrical system')}})

----------------------------------------------------------------
-- Warning lights

-- Combat flaps light
addInputEntryKey({down = devCmds.Cmd266, up = devCmds.Cmd266, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Combat flaps light - PUSH'), category = {_('Central front panel'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd268, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Combat flaps light - Increase'), category = {_('Central front panel'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd268, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Combat flaps light - Decrease'), category = {_('Central front panel'), _('Warnings')}})
-- U/C light
addInputEntryKey({down = devCmds.Cmd269, up = devCmds.Cmd269, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('U/C light'), category = {_('Central front panel'), _('Warnings')}})
-- Nose wheel steering light
addInputEntryKey({down = devCmds.Cmd270, up = devCmds.Cmd270, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Nose wheel steering light - PUSH'), category = {_('Central front panel'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd272, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Nose wheel steering light - Increase'), category = {_('Central front panel'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd272, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Nose wheel steering light - Decrease'), category = {_('Central front panel'), _('Warnings')}})
-- Airbrake light
addInputEntryKey({down = devCmds.Cmd273, up = devCmds.Cmd273, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Airbrake light - PUSH'), category = {_('Central front panel'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd275, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Airbrake light - Increase'), category = {_('Central front panel'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd275, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Airbrake light - Decrease'), category = {_('Central front panel'), _('Warnings')}})
-- Limit warning light + Horn
addInputEntryKey({down = devCmds.Cmd276, up = devCmds.Cmd276, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Limit warning light + Horn'), category = {_('Central front panel'), _('Warnings')}})
-- A/B INJ light
addInputEntryKey({down = devCmds.Cmd278, up = devCmds.Cmd278, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('A/B INJ light'), category = {_('Central front panel'), _('Warnings')}})
-- A/B ON light
addInputEntryKey({down = devCmds.Cmd279, up = devCmds.Cmd279, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('A/B ON light'), category = {_('Central front panel'), _('Warnings')}})
-- A/B SRL light
addInputEntryKey({down = devCmds.Cmd280, up = devCmds.Cmd280, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('A/B SRL light'), category = {_('Central front panel'), _('Warnings')}})
-- Standby receptacle light
addInputEntryKey({down = devCmds.Cmd281, up = devCmds.Cmd281, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Standby receptacle light - PUSH'), category = {_('Central front panel'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd283, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Standby receptacle light - Increase'), category = {_('Central front panel'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd283, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Standby receptacle light - Decrease'), category = {_('Central front panel'), _('Warnings')}})
-- Configuration indicator test button
addInputEntryKey({down = devCmds.Cmd284, up = devCmds.Cmd284, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Configuration indicator test button'), category = {_('Central front panel'), _('Warnings')}})
-- Failure warning panel T test button
addInputEntryKey({down = devCmds.Cmd285, up = devCmds.Cmd285, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Failure warning panel T test button'), category = {_('Right front panel'), _('Warnings')}})
-- Failure warning panel O2 test button
addInputEntryKey({down = devCmds.Cmd286, up = devCmds.Cmd286, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Failure warning panel O2 test button'), category = {_('Right front panel'), _('Warnings')}})
-- Warning horn switch
addInputEntryKey({down = devCmds.Cmd287, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Warning horn switch - ON'), category = {_('Right console'), _('Warnings')}})
addInputEntryKey({down = devCmds.Cmd287, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Warning horn switch - OFF'), category = {_('Right console'), _('Warnings')}})
-- (C + M or SW) R light
addInputEntryKey({down = devCmds.Cmd294, up = devCmds.Cmd294, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('(C + M or SW) R light - PUSH'), category = {_('Central front panel'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd296, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('(C + M or SW) R light - Increase'), category = {_('Central front panel'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd296, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('(C + M or SW) R light - Decrease'), category = {_('Central front panel'), _('Warnings')}})
-- Cannons too hot light
addInputEntryKey({down = devCmds.Cmd297, up = devCmds.Cmd297, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Cannons too hot light - PUSH'), category = {_('Right front panel'), _('Armament system'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd299, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Cannons too hot light - Increase'), category = {_('Right front panel'), _('Armament system'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd299, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Cannons too hot light - Decrease'), category = {_('Right front panel'), _('Armament system'), _('Warnings')}})

-- BIP button
addInputEntryKey({down = devCmds.Cmd300, up = devCmds.Cmd300, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('BIP button'), category = {_('Central front panel'), _('Warnings')}})

----------------------------------------------------------------
-- Exterior lighting

-- Landing light control
addInputEntryKey({down = devCmds.Cmd310, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Landing light control - TAXY'), category = {_('Left wall'), _('Exterior lighting')}},
	{{key = 'L', reformers = {"LShift"}}})
addInputEntryKey({down = devCmds.Cmd310, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Landing light control - LAND'), category = {_('Left wall'), _('Exterior lighting')}},
	{{key = 'L'}})
addInputEntryKey({down = devCmds.Cmd310, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Landing light control - OFF'), category = {_('Left wall'), _('Exterior lighting')}},
	{{key = 'L', reformers = {"LCtrl"}}})
-- Formation light control
addInputEntryKey({down = devCmds.Cmd311, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Formation light control - BRIGHT'), category = {_('Right front panel'), _('Exterior lighting')}},
	{{key = 'L', reformers = {"RShift"}}})
addInputEntryKey({down = devCmds.Cmd311, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Formation light control - OFF'), category = {_('Right front panel'), _('Exterior lighting')}},
	{{key = 'L', reformers = {"RCtrl"}}})
addInputEntryKey({down = devCmds.Cmd311, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Formation light control - DIM'), category = {_('Right front panel'), _('Exterior lighting')}},
	{{key = 'L', reformers = {"RAlt"}}})
-- Navigation light control
addInputEntryKey({down = devCmds.Cmd312, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Navigation light control - BRIGHT'), category = {_('Right front panel'), _('Exterior lighting')}},
	{{key = 'N', reformers = {"RShift"}}})
addInputEntryKey({down = devCmds.Cmd312, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Navigation light control - OFF'), category = {_('Right front panel'), _('Exterior lighting')}},
	{{key = 'N', reformers = {"RCtrl"}}})
addInputEntryKey({down = devCmds.Cmd312, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Navigation light control - DIM'), category = {_('Right front panel'), _('Exterior lighting')}},
	{{key = 'N', reformers = {"RAlt"}}})
-- Search light control
addInputEntryKey({down = devCmds.Cmd313, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Search light control - ON'), category = {_('Right console'), _('Exterior lighting')}},
	{{key = 'O', reformers = {"RCtrl", "RShift"}}})
addInputEntryKey({down = devCmds.Cmd313, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Search light control - OFF'), category = {_('Right console'), _('Exterior lighting')}},
	{{key = 'O', reformers = {"RCtrl", "RAlt"}}})

----------------------------------------------------------------
-- Cabin lighting

-- Miscellaneous instrument lighting switch
addInputEntryKey({down = devCmds.Cmd314, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Miscellaneous instrument lighting switch - Aft'), category = {_('Front structure'), _('Cabin lighting')}})
addInputEntryKey({down = devCmds.Cmd314, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Miscellaneous instrument lighting switch - Neutral'), category = {_('Front structure'), _('Cabin lighting')}})
addInputEntryKey({down = devCmds.Cmd314, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Miscellaneous instrument lighting switch - Forward'), category = {_('Front structure'), _('Cabin lighting')}})
-- Map light rheostat
addInputEntryKey({pressed = devCmds.Cmd316, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Map light rheostat - Clockwise/Increase'), category = {_('Front structure'), _('Cabin lighting')}})
addInputEntryKey({pressed = devCmds.Cmd316, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Map light rheostat - Counterclockwise/Decrease'), category = {_('Front structure'), _('Cabin lighting')}})
-- Miscellaneous instrument integral lighting rheostat
addInputEntryKey({pressed = devCmds.Cmd318, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Miscellaneous instrument integral lighting rheostat - Clockwise/Increase'), category = {_('Front structure'), _('Cabin lighting')}})
addInputEntryKey({pressed = devCmds.Cmd318, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Miscellaneous instrument integral lighting rheostat - Counterclockwise/Decrease'), category = {_('Front structure'), _('Cabin lighting')}})

----------------------------------------------------------------
-- Lighting control unit

-- Day/Night selector switch
addInputEntryKey({down = devCmds.Cmd319, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Day/Night selector switch - DAY'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}})
addInputEntryKey({down = devCmds.Cmd319, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Day/Night selector switch - NIGHT'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}})
-- Light and panel lighting rheostat
addInputEntryKey({pressed = devCmds.Cmd321, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Light and panel lighting rheostat - Clockwise/Increase'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}})
addInputEntryKey({pressed = devCmds.Cmd321, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Light and panel lighting rheostat - Counterclockwise/Decrease'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}})
-- Ultraviolet lighting rheostat
addInputEntryKey({pressed = devCmds.Cmd323, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Ultraviolet lighting rheostat - Clockwise/Increase'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}})
addInputEntryKey({pressed = devCmds.Cmd323, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Ultraviolet lighting rheostat - Counterclockwise/Decrease'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}})
-- Dual instrument panel lighting rheostat (Floodlights)
addInputEntryKey({pressed = devCmds.Cmd325, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Dual instrument panel lighting rheostat (Floodlights) - Clockwise/Increase'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}})
addInputEntryKey({pressed = devCmds.Cmd325, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Dual instrument panel lighting rheostat (Floodlights) - Counterclockwise/Decrease'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}})
-- Dual instrument panel lighting rheostat (Integral)
addInputEntryKey({pressed = devCmds.Cmd327, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Dual instrument panel lighting rheostat (Integral) - Clockwise/Increase'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}})
addInputEntryKey({pressed = devCmds.Cmd327, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Dual instrument panel lighting rheostat (Integral) - Counterclockwise/Decrease'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}})
-- Dual console and pedestal lighting rheostat (Floodlights)
addInputEntryKey({pressed = devCmds.Cmd329, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Dual console and pedestal lighting rheostat (Floodlights) - Clockwise/Increase'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}})
addInputEntryKey({pressed = devCmds.Cmd329, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Dual console and pedestal lighting rheostat (Floodlights) - Counterclockwise/Decrease'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}})
-- Dual console and pedestal lighting rheostat (Integral)
addInputEntryKey({pressed = devCmds.Cmd331, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Dual console and pedestal lighting rheostat (Integral) - Clockwise/Increase'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}})
addInputEntryKey({pressed = devCmds.Cmd331, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Dual console and pedestal lighting rheostat (Integral) - Counterclockwise/Decrease'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}})

----------------------------------------------------------------
-- Radionavigation

----------------------------------------------------------------
-- TACAN control box

-- TACAN X/Y mode selector
addInputEntryKey({down = devCmds.Cmd335, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('TACAN X/Y mode selector - Y mode'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}})
addInputEntryKey({down = devCmds.Cmd335, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('TACAN X/Y mode selector - X mode'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}})
-- TACAN frequency hundreds and tens selector
addInputEntryKey({pressed = devCmds.Cmd336, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('TACAN frequency hundreds and tens selector - Clockwise'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}})
addInputEntryKey({pressed = devCmds.Cmd336, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('TACAN frequency hundreds and tens selector - Counterclockwise'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}})
-- TACAN mode selector
addInputEntryKey({down = devCmds.Cmd338, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('TACAN mode selector - Counterclockwise'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}})
addInputEntryKey({down = devCmds.Cmd338, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('TACAN mode selector - Clockwise'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}})
-- TACAN frequency units selector
addInputEntryKey({pressed = devCmds.Cmd339, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('TACAN frequency units selector - Clockwise'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}})
addInputEntryKey({pressed = devCmds.Cmd339, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('TACAN frequency units selector - Counterclockwise'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}})

----------------------------------------------------------------
-- VOR/ILS control box

-- VOR-ILS control unit ON/OFF selector
addInputEntryKey({down = devCmds.Cmd340, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('VOR-ILS control unit ON/OFF selector - ON'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}})
addInputEntryKey({down = devCmds.Cmd340, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('VOR-ILS control unit ON/OFF selector - OFF'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}})
-- VOR-ILS control unit MHz frequency selector
addInputEntryKey({pressed = devCmds.Cmd341, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('VOR-ILS control unit MHz frequency selector - Clockwise'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}})
addInputEntryKey({pressed = devCmds.Cmd341, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('VOR-ILS control unit MHz frequency selector - Counterclockwise'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}})
-- VOR-ILS control unit test selector
addInputEntryKey({down = devCmds.Cmd342, up = devCmds.Cmd342, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('VOR-ILS control unit test selector - BD'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}})
addInputEntryKey({down = devCmds.Cmd343, up = devCmds.Cmd343, cockpit_device_id = devices.MAIN ,value_down = -1.0, value_up = 0.0, name = _('VOR-ILS control unit test selector - HG'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}})
-- VOR-ILS control unit kHz frequency selector
addInputEntryKey({pressed = devCmds.Cmd344, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('VOR-ILS control unit kHz frequency selector - Clockwise'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}})
addInputEntryKey({pressed = devCmds.Cmd344, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('VOR-ILS control unit kHz frequency selector - Counterclockwise'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}})

----------------------------------------------------------------
-- Omnibearing and VOR/ILS-TAC selector box

-- Omnibearing selector
addInputEntryKey({pressed = devCmds.Cmd345, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Omnibearing selector - Counterclockwise'), category = {_('Right console'), _('Radionavigation'), _('Omnibearing and VOR/ILS-TAC selector box')}})
addInputEntryKey({pressed = devCmds.Cmd345, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Omnibearing selector - Clockwise'), category = {_('Right console'), _('Radionavigation'), _('Omnibearing and VOR/ILS-TAC selector box')}})
-- VOR/ILS-OFF-TACAN selector
addInputEntryKey({down = devCmds.Cmd347, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('VOR/ILS-OFF-TACAN selector - Counterclockwise'), category = {_('Right console'), _('Radionavigation'), _('Omnibearing and VOR/ILS-TAC selector box')}})
addInputEntryKey({down = devCmds.Cmd347, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('VOR/ILS-OFF-TACAN selector - Clockwise'), category = {_('Right console'), _('Radionavigation'), _('Omnibearing and VOR/ILS-TAC selector box')}})

-- Heading selection knob
addInputEntryKey({pressed = devCmds.Cmd348, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Heading selection knob - Counterclockwise'), category = {_('Right console'), _('Radionavigation')}},
	{{key = 'R', reformers = {"RCtrl"}}})
addInputEntryKey({pressed = devCmds.Cmd348, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Heading selection knob - Clockwise'), category = {_('Right console'), _('Radionavigation')}},
	{{key = 'R', reformers = {"RShift"}}})

----------------------------------------------------------------
-- Oxygen system

-- Oxygen test button (T button)
addInputEntryKey({down = devCmds.Cmd360, up = devCmds.Cmd360, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Oxygen test button (T button)'), category = {_('Right console'), _('Oxygen system')}})
-- Pilot oxygen test button
addInputEntryKey({down = devCmds.Cmd361, up = devCmds.Cmd361, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Pilot oxygen test button'), category = {_('Right console'), _('Oxygen system')}})
-- "N-100%-EMG" mode selector switch
addInputEntryKey({down = devCmds.Cmd362, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('N-100%-EMG mode selector switch - NORMAL'), category = {_('Ejection seat'), _('Oxygen system')}})
addInputEntryKey({down = devCmds.Cmd362, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('N-100%-EMG mode selector switch - 100%'), category = {_('Ejection seat'), _('Oxygen system')}})
addInputEntryKey({down = devCmds.Cmd362, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('N-100%-EMG mode selector switch - EMG'), category = {_('Ejection seat'), _('Oxygen system')}})
-- Oxygen overpressure button
addInputEntryKey({down = devCmds.Cmd363, up = devCmds.Cmd363, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Oxygen overpressure button'), category = {_('Ejection seat'), _('Oxygen system')}})
-- Anti-g connection cover
addInputEntryKey({down = devCmds.Cmd364, up = devCmds.Cmd364, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Anti-g connection cover'), category = {_('Ejection seat'), _('Oxygen system')}})
-- Anti-g test button
addInputEntryKey({down = devCmds.Cmd365, up = devCmds.Cmd365, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Anti-g test button'), category = {_('Ejection seat'), _('Oxygen system')}})
-- Anti-g valve cock
addInputEntryKey({down = devCmds.Cmd366, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Anti-g valve cock - ON'), category = {_('Ejection seat'), _('Oxygen system')}})
addInputEntryKey({down = devCmds.Cmd366, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Anti-g valve cock - OFF'), category = {_('Ejection seat'), _('Oxygen system')}})

----------------------------------------------------------------
-- Air conditioning system

-- Emergency cold switch
addInputEntryKey({down = devCmds.Cmd375, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Emergency cold switch - NORMAL'), category = {_('Right console'), _('Air conditioning system')}})
addInputEntryKey({down = devCmds.Cmd375, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Emergency cold switch - EMG COLD'), category = {_('Right console'), _('Air conditioning system')}})
-- Master valve control switch
addInputEntryKey({down = devCmds.Cmd376, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Master valve control switch - ON'), category = {_('Right console'), _('Air conditioning system')}})
addInputEntryKey({down = devCmds.Cmd376, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Master valve control switch - OFF'), category = {_('Right console'), _('Air conditioning system')}})
-- Temperature control rheostat
addInputEntryKey({pressed = devCmds.Cmd378, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Temperature control rheostat - Clockwise'), category = {_('Right console'), _('Air conditioning system')}})
addInputEntryKey({pressed = devCmds.Cmd378, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Temperature control rheostat - Counterclockwise'), category = {_('Right console'), _('Air conditioning system')}})
-- Auto/Manual selector switch
addInputEntryKey({down = devCmds.Cmd379, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Auto/Manual selector switch - MANUAL'), category = {_('Right console'), _('Air conditioning system')}})
addInputEntryKey({down = devCmds.Cmd379, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Auto/Manual selector switch - AUTO'), category = {_('Right console'), _('Air conditioning system')}})
-- Hot/Cold selector switch
addInputEntryKey({down = devCmds.Cmd381, up = devCmds.Cmd381, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Hot/Cold selector switch - COLD'), category = {_('Right console'), _('Air conditioning system')}})
addInputEntryKey({down = devCmds.Cmd380, up = devCmds.Cmd380, cockpit_device_id = devices.MAIN ,value_down = -1.0, value_up = 0.0, name = _('Hot/Cold selector switch - HOT'), category = {_('Right console'), _('Air conditioning system')}})
-- Ram air switch guard
addInputEntryKey({down = devCmds.Cmd382, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Ram air switch guard - OPEN'), category = {_('Right console'), _('Air conditioning system')}})
addInputEntryKey({down = devCmds.Cmd382, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Ram air switch guard - CLOSE'), category = {_('Right console'), _('Air conditioning system')}})
-- Ram air switch
addInputEntryKey({down = devCmds.Cmd383, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Ram air switch - ON'), category = {_('Right console'), _('Air conditioning system')}})
addInputEntryKey({down = devCmds.Cmd383, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Ram air switch - OFF'), category = {_('Right console'), _('Air conditioning system')}})
-- Demist switch
addInputEntryKey({down = devCmds.Cmd384, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Demist switch - ON'), category = {_('Right console'), _('Air conditioning system')}})
addInputEntryKey({down = devCmds.Cmd384, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Demist switch - OFF'), category = {_('Right console'), _('Air conditioning system')}})

----------------------------------------------------------------
-- Circuit breaker box

-- Gyro control unit power supply
addInputEntryKey({down = devCmds.Cmd395, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Gyro control unit power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd395, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Gyro control unit power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- High-lift device servo unit power supply
addInputEntryKey({down = devCmds.Cmd396, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('High-lift device servo unit power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd396, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('High-lift device servo unit power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- Indicator and failure detector power supply
addInputEntryKey({down = devCmds.Cmd397, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Indicator and failure detector power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd397, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Indicator and failure detector power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- Inverter transfer unit power supply and control
addInputEntryKey({down = devCmds.Cmd398, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Inverter transfer unit power supply and control - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd398, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Inverter transfer unit power supply and control - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- Dual hydraulic pressure gauge power supply
addInputEntryKey({down = devCmds.Cmd399, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Dual hydraulic pressure gauge power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd399, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Dual hydraulic pressure gauge power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- Gun firing trigger power supply
addInputEntryKey({down = devCmds.Cmd400, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Gun firing trigger power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd400, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Gun firing trigger power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- LP cock power supply
addInputEntryKey({down = devCmds.Cmd401, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('LP cock power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd401, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('LP cock power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- Electro-pump relay power supply
addInputEntryKey({down = devCmds.Cmd402, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Electro-pump relay power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd402, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Electro-pump relay power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- Flight refuelling system power supply
addInputEntryKey({down = devCmds.Cmd403, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Flight refuelling system power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd403, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Flight refuelling system power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- Cabin pressurization system power supply
addInputEntryKey({down = devCmds.Cmd404, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Cabin pressurization system power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd404, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Cabin pressurization system power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- Inverter 28 V power supply
addInputEntryKey({down = devCmds.Cmd405, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Inverter 28 V power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd405, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Inverter 28 V power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- U/C normal operation power supply
addInputEntryKey({down = devCmds.Cmd406, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('U/C normal operation power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd406, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('U/C normal operation power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- V/UHF power supply
addInputEntryKey({down = devCmds.Cmd407, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('V/UHF power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd407, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('V/UHF power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- Starter and sequencing system power supply
addInputEntryKey({down = devCmds.Cmd408, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Starter and sequencing system power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd408, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Starter and sequencing system power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- Refuelling probe control power supply
addInputEntryKey({down = devCmds.Cmd409, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Refuelling probe control power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
	{{key = '5', reformers = {"RCtrl", "RShift"}}})
addInputEntryKey({down = devCmds.Cmd409, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Refuelling probe control power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
	{{key = '5', reformers = {"RCtrl", "RAlt"}}})
-- Manual trim control power supply
addInputEntryKey({down = devCmds.Cmd410, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Manual trim control power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd410, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Manual trim control power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- Valve position repeater, control valve and ground mode power supply
addInputEntryKey({down = devCmds.Cmd411, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Valve position repeater, control valve and ground mode power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd411, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Valve position repeater, control valve and ground mode power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- Failure warning panel and master failure warning light power supply
addInputEntryKey({down = devCmds.Cmd412, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Failure warning panel and master failure warning light power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd412, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Failure warning panel and master failure warning light power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- Configuration indicator (U/C section) and U/C warning light power supply
addInputEntryKey({down = devCmds.Cmd413, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Configuration indicator (U/C section) and U/C warning light power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd413, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Configuration indicator (U/C section) and U/C warning light power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- IFF power supply
addInputEntryKey({down = devCmds.Cmd414, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('IFF power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd414, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('IFF power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
-- Emergency regulation system and control lever power supply
addInputEntryKey({down = devCmds.Cmd415, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Emergency regulation system and control lever power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})
addInputEntryKey({down = devCmds.Cmd415, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Emergency regulation system and control lever power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}})

----------------------------------------------------------------
-- Ejection seat

-- Seat height adjustment control
addInputEntryKey({down = devCmds.Cmd431, up = devCmds.Cmd431, cockpit_device_id = devices.MAIN ,value_down = -1.0, value_up = 0.0, name = _('Seat height adjustment control - UP'), category = {_('Ejection seat')}},
	{{key = 'Y', reformers = {"RShift"}}})
addInputEntryKey({down = devCmds.Cmd430, up = devCmds.Cmd430, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Seat height adjustment control - DOWN'), category = {_('Ejection seat')}},
	{{key = 'Y', reformers = {"RCtrl"}}})
-- Face blind firing handle
addInputEntryKey({down = devCmds.Cmd432, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Face blind firing handle - PULL'), category = {_('Ejection seat')}},
	{{key = 'E', reformers = {"RShift"}}})
addInputEntryKey({down = devCmds.Cmd432, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Face blind firing handle - PUSH'), category = {_('Ejection seat')}},
	{{key = 'E', reformers = {"RCtrl"}}})
-- Alternative firing handle
addInputEntryKey({down = devCmds.Cmd434, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Alternative firing handle - PULL'), category = {_('Ejection seat')}},
	{{key = 'E', reformers = {"RAlt"}}})
addInputEntryKey({down = devCmds.Cmd434, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Alternative firing handle - PUSH'), category = {_('Ejection seat')}},
	{{key = 'E', reformers = {"RShift", "RAlt"}}})
-- Ejection handle safety pin
addInputEntryKey({pressed = devCmds.Cmd650,cockpit_device_id = devices.MAIN,	value_pressed = 0.0,	name = _('Ejection Seat Handle Safety Pin INSTALL'),	category = {_('Ejection seat')}})
addInputEntryKey({pressed = devCmds.Cmd650,cockpit_device_id = devices.MAIN,	value_pressed = 1.0,	name = _('Ejection Seat Handle Safety Pin REMOVE'),	category = {_('Ejection seat')}})

----------------------------------------------------------------
-- Chaff and flares dispenser ALE 40 control unit

-- Chaff/flares selector switch
addInputEntryKey({down = devCmds.Cmd437, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Chaff/flares selector switch - FLARE'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}})
addInputEntryKey({down = devCmds.Cmd437, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Chaff/flares selector switch - BOTH'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}})
addInputEntryKey({down = devCmds.Cmd437, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Chaff/flares selector switch - CHAFF'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}})
-- Program selector switch
addInputEntryKey({down = devCmds.Cmd439, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Program selector switch - Clockwise'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}})
addInputEntryKey({down = devCmds.Cmd439, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Program selector switch - Counterclockwise'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}})
-- Chaff counter reset button
addInputEntryKey({down = devCmds.Cmd440, up = devCmds.Cmd440, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Chaff counter reset button'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}})
-- Flares counter reset button
addInputEntryKey({down = devCmds.Cmd441, up = devCmds.Cmd441, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Flares counter reset button'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}})
-- Emergency jettisoning switch
addInputEntryKey({down = devCmds.Cmd442, up = devCmds.Cmd442, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = -1.0, name = _('Emergency jettisoning switch'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}},
	{{key = 'D', reformers = {"RAlt"}}})

----------------------------------------------------------------
-- Radar detector switch
addInputEntryKey({down = devCmds.Cmd443, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Radar detector switch - ON'), category = {_('Right console'), _('Radar detector')}})
addInputEntryKey({down = devCmds.Cmd443, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Radar detector switch - OFF'), category = {_('Right console'), _('Radar detector')}})

-- Chaff and flares release button
addInputEntryKey({down = devCmds.Cmd444, up = devCmds.Cmd444, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Chaff/flares release button'), category = {_('Left wall'), _('Chaff and flares dispenser system')}},
	{{key = 'D'}})

----------------------------------------------------------------
-- Control stick

-- Gun firing trigger
addInputEntryKey({down = devCmds.Cmd631, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Gun firing trigger - UNFOLDED'), category = {_('Control Stick'), _('Armament system')}},
	{{key = 'Space', reformers = {"RCtrl"}}})
addInputEntryKey({down = devCmds.Cmd631, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Gun firing trigger - FOLDED'), category = {_('Control Stick'), _('Armament system')}},
	{{key = 'Space', reformers = {"RShift"}}})
-- PTT button
addInputEntryKey({down = devCmds.Cmd632, up = devCmds.Cmd632, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('PTT button'), category = {_('Control Stick'), _('Radio system')}},
	{{key = 'T'}})
-- Search light button
addInputEntryKey({down = devCmds.Cmd633, up = devCmds.Cmd633, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Search light button'), category = {_('Control Stick'), _('Exterior lighting')}},
	{{key = 'T'}})
-- Bombs, rockets, missiles and sight recorder button
addInputEntryKey({down = devCmds.Cmd634, up = devCmds.Cmd634, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Bombs, rockets, missiles and sight recorder button'), category = {_('Control Stick'), _('Armament system')}},
	{{key = 'Space', reformers = {"RAlt"}}})
-- Gun firing safety
addInputEntryKey({down = devCmds.Cmd635, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Gun firing safety - OUT'), category = {_('Control Stick'), _('Armament system')}},
	{{key = 'Space', reformers = {"LCtrl", "LWin"}}})
addInputEntryKey({down = devCmds.Cmd635, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Gun firing safety - IN'), category = {_('Control Stick'), _('Armament system')}},
	{{key = 'Space', reformers = {"LShift", "LWin"}}})
-- Gun button
addInputEntryKey({down = devCmds.Cmd636, up = devCmds.Cmd636, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Gun button'), category = {_('Control Stick'), _('Armament system')}},
	{{key = 'Space'}})
-- Sight recorder button
addInputEntryKey({down = devCmds.Cmd637, up = devCmds.Cmd637, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Sight recorder button'), category = {_('Control Stick'), _('Sight system and recording camera')}},
	{{key = 'Space', reformers = {"LCtrl", "LWin", "LAlt"}}})

----------------------------------------------------------------
-- Throttle lever
-- (C + M or SW) R button
addInputEntryKey({down = devCmds.Cmd640, up = devCmds.Cmd640, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('(C + M or SW) R button'), category = {_('Throttle lever'), _('Armament system')}},
	{{key = 'R', reformers = {"LCtrl"}}})
-- Cannon 300-600m and missile lock/unlock button
addInputEntryKey({down = devCmds.Cmd641, up = devCmds.Cmd641, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Cannon 300-600m and missile lock/unlock button'), category = {_('Throttle lever'), _('Armament system')}},
	{{key = 'C', reformers = {"RCtrl"}}})

----------------------------------------------------------------
-- Moved from Mirage-F1CE default lua

----------------------------------------------------------------
-- Armament control panel

-- Sight selector
addInputEntryKey({down = devCmds.Cmd580, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Sight selector - APP'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '1', reformers = {"LShift"}}})
addInputEntryKey({down = devCmds.Cmd580, cockpit_device_id  = devices.MAIN, value_down = 0.5, name = _('Sight selector - ON'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '1', reformers = {"LCtrl"}}})
addInputEntryKey({down = devCmds.Cmd580, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Sight selector - OFF'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '1', reformers = {"LAlt"}}})
-- Bomb/Rocket selector
addInputEntryKey({down = devCmds.Cmd581, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Bomb/Rocket selector - OUTBD'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '2', reformers = {"LShift"}}})
addInputEntryKey({down = devCmds.Cmd581, cockpit_device_id  = devices.MAIN, value_down = 0.5, name = _('Bomb/Rocket selector - 1+2'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '2', reformers = {"LCtrl"}}})
addInputEntryKey({down = devCmds.Cmd581, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Bomb/Rocket selector - INBD'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '2', reformers = {"LAlt"}}})
-- MATRA 550 missile switch
addInputEntryKey({down = devCmds.Cmd582, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('MATRA 550 or Sidewinder missile switch - ON'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '3', reformers = {"LShift"}}})
addInputEntryKey({down = devCmds.Cmd582, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('MATRA 550 or Sidewinder missile switch - OFF'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '3', reformers = {"LCtrl"}}})
-- Fore/Aft selector switch
addInputEntryKey({down = devCmds.Cmd583, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Fore/Aft selector switch - FORE'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '4', reformers = {"LShift"}}})
addInputEntryKey({down = devCmds.Cmd583, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Fore/Aft selector switch - AFT'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '4', reformers = {"LCtrl"}}})
-- Auto/Manual firing selector switch
addInputEntryKey({down = devCmds.Cmd584, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Auto/Manual firing selector switch - AUTO'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '5', reformers = {"LShift"}}})
addInputEntryKey({down = devCmds.Cmd584, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Auto/Manual firing selector switch - MAN'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '5', reformers = {"LCtrl"}}})
-- Single/Salvo selector
addInputEntryKey({down = devCmds.Cmd585, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Single/Salvo selector - SINGLE'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '6', reformers = {"LShift"}}})
addInputEntryKey({down = devCmds.Cmd585, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Single/Salvo selector - SALVO'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '6', reformers = {"LCtrl"}}})
-- Instantaneous/Delay/Safe selector switch
addInputEntryKey({down = devCmds.Cmd586, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Instantaneous/Delay/Safe selector switch - INST'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '7', reformers = {"LShift"}}})
addInputEntryKey({down = devCmds.Cmd586, cockpit_device_id  = devices.MAIN, value_down = 0.5, name = _('Instantaneous/Delay/Safe selector switch - DLY'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '7', reformers = {"LCtrl"}}})
addInputEntryKey({down = devCmds.Cmd586, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Instantaneous/Delay/Safe selector switch - SAFE'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '7', reformers = {"LAlt"}}})

-- Armament control panel - lighted pushbutton selectors

-- Left MATRA R550 or Sidewinder missile pushbutton
addInputEntryKey({down = devCmds.Cmd587, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Left MATRA R550 or Sidewinder missile pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}})
-- Left or fuselage MATRA R530 missile pushbutton
addInputEntryKey({down = devCmds.Cmd588, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Left or fuselage MATRA R530 missile pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}})
-- Air-to-Air guns pushbutton
addInputEntryKey({down = devCmds.Cmd589, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Air-to-Air guns pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}})
-- Wing bombs pushbutton
addInputEntryKey({down = devCmds.Cmd590, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Wing bombs pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}})
-- Right MATRA R550 or Sidewinder missile pushbutton
addInputEntryKey({down = devCmds.Cmd591, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Right MATRA R550 or Sidewinder missile pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}})
-- Right MATRA R530 missile pushbutton
addInputEntryKey({down = devCmds.Cmd592, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Right MATRA R530 missile pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}})
-- Air-to-Ground guns or rockets pushbutton
addInputEntryKey({down = devCmds.Cmd593, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Air-to-Ground guns or rockets pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}})
-- Fuselage bombs pushbutton
addInputEntryKey({down = devCmds.Cmd594, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Fuselage bombs pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}})

-- Armament control panel - continued

-- R 530 Missile Normal/Altitude difference selector switch
addInputEntryKey({down = devCmds.Cmd595, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('R 530 Missile Normal/Altitude difference selector switch - SNAP'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '0', reformers = {"LShift"}}})
addInputEntryKey({down = devCmds.Cmd595, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('R 530 Missile Normal/Altitude difference selector switch - NORM'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '0', reformers = {"LCtrl"}}})
-- Normal/Jammer pursuit switch, commented as being 'No function'
--addInputEntryKey({down = devCmds.Cmd596, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Normal/Jammer pursuit switch (No function) - JP'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
--	{{key = '`', reformers = {"LShift"}}})
--addInputEntryKey({down = devCmds.Cmd596, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Normal/Jammer pursuit switch (No function) - N'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
--	{{key = '`', reformers = {"LCtrl"}}})
-- Armament panel lights test
addInputEntryKey({down = devCmds.Cmd597, up = devCmds.Cmd597, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Armament panel lights test'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
	{{key = '0', reformers = {"LWin"}}})

----------------------------------------------------------------
-- Armament control panel - radar controls

-- Radar selector
addInputEntryKey({down = devCmds.Cmd613, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Radar selector - TX'), category = {_('Right console'), _('Radar'), _('Armament control panel')}},
	{{key = '8', reformers = {"LShift"}}})
addInputEntryKey({down = devCmds.Cmd613, cockpit_device_id  = devices.MAIN, value_down = 0.5, name = _('Radar selector - SBY'), category = {_('Right console'), _('Radar'), _('Armament control panel')}},
	{{key = '8', reformers = {"LCtrl"}}})
addInputEntryKey({down = devCmds.Cmd613, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Radar selector - OFF'), category = {_('Right console'), _('Radar'), _('Armament control panel')}},
	{{key = '8', reformers = {"LAlt"}}})
-- Emergency transmission button
addInputEntryKey({down = devCmds.Cmd614, up = devCmds.Cmd614, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Radar emergency transmission button'), category = {_('Right console'), _('Radar'), _('Armament control panel')}},
	{{key = '9', reformers = {"LWin"}}})
-- Radar 4 lines/1 line scan switch
addInputEntryKey({down = devCmds.Cmd615, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Radar 4 lines/1 line scan switch - 4L'), category = {_('Right console'), _('Radar'), _('Armament control panel')}},
	{{key = '9', reformers = {"LShift"}}})
addInputEntryKey({down = devCmds.Cmd615, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Radar 4 lines/1 line scan - 1L'), category = {_('Right console'), _('Radar'), _('Armament control panel')}},
	{{key = '9', reformers = {"LCtrl"}}})

----------------------------------------------------------------
-- Radar indicator scope control box

-- Indicator lights brightness
addInputEntryKey({pressed = devCmds.Cmd619, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Indicator lights brightness - Increase'), category = {_('Right console'), _('Radar indicator scope control box')}})
addInputEntryKey({pressed = devCmds.Cmd619, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Indicator lights brightness - Decrease'), category = {_('Right console'), _('Radar indicator scope control box')}})
-- Strobe brightness
addInputEntryKey({pressed = devCmds.Cmd621, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Strobe brightness - Increase'), category = {_('Right console'), _('Radar indicator scope control box')}})
addInputEntryKey({pressed = devCmds.Cmd621, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Strobe brightness - Decrease'), category = {_('Right console'), _('Radar indicator scope control box')}})
-- Distance markers brightness
addInputEntryKey({pressed = devCmds.Cmd623, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Distance markers brightness - Increase'), category = {_('Right console'), _('Radar indicator scope control box')}})
addInputEntryKey({pressed = devCmds.Cmd623, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Distance markers brightness - Decrease'), category = {_('Right console'), _('Radar indicator scope control box')}})
-- Horizon and radial velocity marker brightness
addInputEntryKey({pressed = devCmds.Cmd625, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Horizon and radial velocity marker brightness - Increase'), category = {_('Right console'), _('Radar indicator scope control box')}})
addInputEntryKey({pressed = devCmds.Cmd625, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Horizon and radial velocity marker brightness - Decrease'), category = {_('Right console'), _('Radar indicator scope control box')}})
-- Horizon symbol vertical position
addInputEntryKey({pressed = devCmds.Cmd627, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Horizon symbol vertical position - Increase'), category = {_('Right console'), _('Radar indicator scope control box')}})
addInputEntryKey({pressed = devCmds.Cmd627, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Horizon symbol vertical position - Decrease'), category = {_('Right console'), _('Radar indicator scope control box')}})

----------------------------------------------------------------
-- Armament master switch

-- Armament master switch guard
addInputEntryKey({down = devCmds.Cmd143, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Armament master switch guard - OPEN'), category = {_('Left console'), _('Armament system')}},
	{{key = "Space", reformers = {"LCtrl", "LShift"}}})
addInputEntryKey({down = devCmds.Cmd143, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Armament master switch guard - CLOSE'), category = {_('Left console'), _('Armament system')}},
	{{key = "Space", reformers = {"LCtrl", "LAlt"}}})
-- Armament master switch
addInputEntryKey({down = devCmds.Cmd144, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Armament master switch - TEST'), category = {_('Left console'), _('Armament system')}},
	{{key = "Space", reformers = {"LShift"}}})
addInputEntryKey({down = devCmds.Cmd144, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Armament master switch - ON'), category = {_('Left console'), _('Armament system')}},
	{{key = "Space", reformers = {"LCtrl"}}})
addInputEntryKey({down = devCmds.Cmd144, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Armament master switch - OFF'), category = {_('Left console'), _('Armament system')}},
	{{key = "Space", reformers = {"LAlt"}}})

----------------------------------------------------------------
-- ANTENNA-GYRO switch
addInputEntryKey({down = devCmds.Cmd453, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('ANTENNA-GYRO switch - GYRO'), category = {_('Left console'), _('Armament system')}},
	{{key = "G", reformers = {"LAlt"}}})
addInputEntryKey({down = devCmds.Cmd453, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('ANTENNA-GYRO switch - ANTENNA'), category = {_('Left console'), _('Armament system')}},
	{{key = "G", reformers = {"RAlt"}}})

----------------------------------------------------------------
-- Left wall armament switches

-- (C + M or SW) R deselection switch
addInputEntryKey({down = devCmds.Cmd475, up = devCmds.Cmd475, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('(C + M or SW) R deselection switch'), category = {_('Left wall'), _('Armament system')}},
	{{key = "W", reformers = {"LCtrl", "LWin"}}})
-- Telemeter/zone scanning switch
addInputEntryKey({down = devCmds.Cmd476, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Telemeter/zone scanning switch - TEL'), category = {_('Left wall'), _('Armament system')}},
	{{key = "Z", reformers = {"LAlt", "LShift"}}})
addInputEntryKey({down = devCmds.Cmd476, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Telemeter/zone scanning switch - CENTER'), category = {_('Left wall'), _('Armament system')}},
	{{key = "Z", reformers = {"LAlt", "LWin"}}})
addInputEntryKey({down = devCmds.Cmd476, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Telemeter/zone scanning switch - BPZ'), category = {_('Left wall'), _('Armament system')}})

----------------------------------------------------------------
-- Accelerometer reset button and rheostat
addInputEntryKey({down = devCmds.Cmd477, up = devCmds.Cmd477, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Accelerometer reset button and rheostat'), category = {_('Front structure'), _('Systems')}})

----------------------------------------------------------------
-- Sight system and recording camera

-- AUTO/MAN intensity selector switch
addInputEntryKey({down = devCmds.Cmd480, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('AUTO/MAN intensity selector switch - MAN'), category = {_('Central front panel'), _('Sight system and recording camera')}})
addInputEntryKey({down = devCmds.Cmd480, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('AUTO/MAN intensity selector switch - AUTO'), category = {_('Central front panel'), _('Sight system and recording camera')}})
-- Lighting selector switch
addInputEntryKey({down = devCmds.Cmd481, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Lighting selector switch - E'), category = {_('Central front panel'), _('Sight system and recording camera')}})
addInputEntryKey({down = devCmds.Cmd481, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Lighting selector switch - N'), category = {_('Central front panel'), _('Sight system and recording camera')}})
addInputEntryKey({down = devCmds.Cmd481, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Lighting selector switch - O'), category = {_('Central front panel'), _('Sight system and recording camera')}})
-- Manual gravity drop selection thumbwheel
addInputEntryKey({pressed = devCmds.Cmd482, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Manual gravity drop selection thumbwheel - Decrease'), category = {_('Central front panel'), _('Sight system and recording camera')}},
	{{key = 'M', reformers = {"LCtrl"}}})
addInputEntryKey({pressed = devCmds.Cmd482, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Manual gravity drop selection thumbwheel - Increase'), category = {_('Central front panel'), _('Sight system and recording camera')}},
	{{key = 'M', reformers = {"LAlt"}}})
-- Fixed Reticle intensity rheostat
addInputEntryKey({pressed = devCmds.Cmd484, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Fixed Reticle intensity rheostat - Clockwise/Increase'), category = {_('Central front panel'), _('Sight system and recording camera')}})
addInputEntryKey({pressed = devCmds.Cmd484, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Fixed Reticle intensity rheostat - Counterclockwise/Decrease'), category = {_('Central front panel'), _('Sight system and recording camera')}})
-- Moving and Target Reticles intensity rheostat
addInputEntryKey({pressed = devCmds.Cmd486, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Moving and Target Reticles intensity rheostat - Clockwise/Increase'), category = {_('Central front panel'), _('Sight system and recording camera')}})
addInputEntryKey({pressed = devCmds.Cmd486, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Moving and Target Reticles intensity rheostat - Counterclockwise/Decrease'), category = {_('Central front panel'), _('Sight system and recording camera')}})
-- Attitude Reticle intensity rheostat
addInputEntryKey({pressed = devCmds.Cmd488, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Attitude Reticle intensity rheostat - Clockwise/Increase'), category = {_('Central front panel'), _('Sight system and recording camera')}})
addInputEntryKey({pressed = devCmds.Cmd488, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Attitude Reticle intensity rheostat - Counterclockwise/Decrease'), category = {_('Central front panel'), _('Sight system and recording camera')}})
-- Sight system test button
addInputEntryKey({down = devCmds.Cmd489, up = devCmds.Cmd489, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Sight system test button'), category = {_('Central front panel'), _('Sight system and recording camera')}})
-- Exposure time repeater
addInputEntryKey({pressed = devCmds.Cmd491, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Exposure time repeater - Clockwise'), category = {_('Central front panel'), _('Sight system and recording camera')}})
addInputEntryKey({pressed = devCmds.Cmd491, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Exposure time repeater - Counterclockwise'), category = {_('Central front panel'), _('Sight system and recording camera')}})
-- Overrun select thumbwheel
addInputEntryKey({pressed = devCmds.Cmd493, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Overrun select thumbwheel - Increase'), category = {_('Central front panel'), _('Sight system and recording camera')}})
addInputEntryKey({pressed = devCmds.Cmd493, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Overrun select thumbwheel - Decrease'), category = {_('Central front panel'), _('Sight system and recording camera')}})
-- 5/16 PPS framing rate selector switch
addInputEntryKey({down = devCmds.Cmd494, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('5/16 PPS framing rate selector switch - 16'), category = {_('Central front panel'), _('Sight system and recording camera')}})
addInputEntryKey({down = devCmds.Cmd494, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('5/16 PPS framing rate selector switch - 5'), category = {_('Central front panel'), _('Sight system and recording camera')}})
-- Sight camera test switch
addInputEntryKey({down = devCmds.Cmd495, up = devCmds.Cmd495, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Sight camera test switch - TEST'), category = {_('Central front panel'), _('Sight system and recording camera')}})

----------------------------------------------------------------
-- Radar

-- Radar test buttton
addInputEntryKey({down = devCmds.Cmd505, up = devCmds.Cmd505, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Radar test buttton'), category = {_('Central front panel'), _('Radar')}})
-- Scope intensity adjustment
addInputEntryKey({pressed = devCmds.Cmd507, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Scope intensity adjustment - Clockwise/Increase'), category = {_('Central front panel'), _('Radar')}})
addInputEntryKey({pressed = devCmds.Cmd507, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Scope intensity adjustment - Counterclockwise/Decrease'), category = {_('Central front panel'), _('Radar')}})
-- Radar function selection
addInputEntryKey({down = devCmds.Cmd509, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Radar function selection - Clockwise/Increase'), category = {_('Central front panel'), _('Radar')}})
addInputEntryKey({down = devCmds.Cmd509, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Radar function selection - Counterclockwise/Decrease'), category = {_('Central front panel'), _('Radar')}})
-- Storage adjustment
addInputEntryKey({pressed = devCmds.Cmd511, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Storage adjustment - Clockwise/Increase'), category = {_('Central front panel'), _('Radar')}})
addInputEntryKey({pressed = devCmds.Cmd511, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Storage adjustment - Counterclockwise/Decrease'), category = {_('Central front panel'), _('Radar')}})
-- Scope erasing
addInputEntryKey({down = devCmds.Cmd512, up = devCmds.Cmd512, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Scope erasing'), category = {_('Central front panel'), _('Radar')}})
-- Polaroid screen adjustment
addInputEntryKey({pressed = devCmds.Cmd514, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Polaroid screen adjustment - Clockwise'), category = {_('Central front panel'), _('Radar')}})
addInputEntryKey({pressed = devCmds.Cmd514, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Polaroid screen adjustment - Counterclockwise'), category = {_('Central front panel'), _('Radar')}})

-- Radar cover
addInputEntryKey({down = devCmds.Cmd629, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Radar cover remove toggle'), category = {_('Central front panel')}})

----------------------------------------------------------------
-- IFF

-- Mode 1 coding tens selector
addInputEntryKey({down = devCmds.Cmd521, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode 1 coding tens selector - Increase'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd521, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode 1 coding tens selector - Decrease'), category = {_('Central front panel'), _('IFF')}})
-- Mode 1 coding units selector
addInputEntryKey({down = devCmds.Cmd523, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode 1 coding units selector - Increase'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd523, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode 1 coding units selector - Decrease'), category = {_('Central front panel'), _('IFF')}})
-- Mode 3A coding thousands selector
addInputEntryKey({down = devCmds.Cmd525, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode 3A coding thousands selector - Increase'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd525, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode 3A coding thousands selector - Decrease'), category = {_('Central front panel'), _('IFF')}})
-- Mode 3A coding hundreds selector
addInputEntryKey({down = devCmds.Cmd527, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode 3A coding hundreds selector - Increase'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd527, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode 3A coding hundreds selector - Decrease'), category = {_('Central front panel'), _('IFF')}})
-- Mode 3A coding tens selector
addInputEntryKey({down = devCmds.Cmd529, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode 3A coding tens selector - Increase'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd529, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode 3A coding tens selector - Decrease'), category = {_('Central front panel'), _('IFF')}})
-- Mode 3A coding units selector
addInputEntryKey({down = devCmds.Cmd531, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode 3A coding units selector - Increase'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd531, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode 3A coding units selector - Decrease'), category = {_('Central front panel'), _('IFF')}})
-- Position identification selector
addInputEntryKey({down = devCmds.Cmd533, up = devCmds.Cmd533, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Position identification selector - IDENT'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd532, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Position identification selector - OFF'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd532, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Position identification selector - MIC'), category = {_('Central front panel'), _('IFF')}})
-- IFF test button
addInputEntryKey({down = devCmds.Cmd534, up = devCmds.Cmd534, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('IFF test button'), category = {_('Central front panel'), _('IFF')}})
-- Mode 4 selector switch
addInputEntryKey({down = devCmds.Cmd536, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode 4 selector switch - Clockwise'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd536, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode 4 selector switch - Counterclockwise'), category = {_('Central front panel'), _('IFF')}})
-- IFF monitoring light
addInputEntryKey({down = devCmds.Cmd537, up = devCmds.Cmd537, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('IFF monitoring light - PUSH'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({pressed = devCmds.Cmd539, cockpit_device_id = devices.MAIN, value_pressed = 1.0, name = _('IFF monitoring light - Increase'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({pressed = devCmds.Cmd539, cockpit_device_id = devices.MAIN, value_pressed = -1.0, name = _('IFF monitoring light - Decrease'), category = {_('Central front panel'), _('IFF')}})
-- Function selector switch
addInputEntryKey({down = devCmds.Cmd541, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Function selector switch - Clockwise'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd541, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Function selector switch - Counterclockwise'), category = {_('Central front panel'), _('IFF')}})
-- IFF mode 4 switch
addInputEntryKey({down = devCmds.Cmd542, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('IFF mode 4 switch - ON'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd542, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('IFF mode 4 switch - OFF'), category = {_('Central front panel'), _('IFF')}})
-- IFF fault light
addInputEntryKey({down = devCmds.Cmd543, up = devCmds.Cmd543, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('IFF fault light - PUSH'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({pressed = devCmds.Cmd545, cockpit_device_id = devices.MAIN, value_pressed = 1.0, name = _('IFF fault light - Increase'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({pressed = devCmds.Cmd545, cockpit_device_id = devices.MAIN, value_pressed = -1.0, name = _('IFF fault light - Decrease'), category = {_('Central front panel'), _('IFF')}})
-- AUDIO-LIGHT switch
addInputEntryKey({down = devCmds.Cmd546, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('AUDIO-LIGHT switch - ON'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd546, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('AUDIO-LIGHT switch - OFF'), category = {_('Central front panel'), _('IFF')}})
-- M-1 mode switch
addInputEntryKey({down = devCmds.Cmd547, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('M-1 mode switch - ON'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd547, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('M-1 mode switch - OFF'), category = {_('Central front panel'), _('IFF')}})
-- M-2 mode switch
addInputEntryKey({down = devCmds.Cmd548, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('M-2 mode switch - ON'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd548, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('M-2 mode switch - OFF'), category = {_('Central front panel'), _('IFF')}})
-- M-3 mode switch
addInputEntryKey({down = devCmds.Cmd549, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('M-3 mode switch - ON'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd549, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('M-3 mode switch - OFF'), category = {_('Central front panel'), _('IFF')}})
-- M-4 mode switch
addInputEntryKey({down = devCmds.Cmd550, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('M-4 mode switch - ON'), category = {_('Central front panel'), _('IFF')}})
addInputEntryKey({down = devCmds.Cmd550, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('M-4 mode switch - OFF'), category = {_('Central front panel'), _('IFF')}})

-- Axes

--addInputEntryAxis({action = iCommandPlaneRoll, 				name = _('Roll')},
--	defaultDeviceAssignmentFor("roll"))
addInputEntryAxis({action = GLOB_CMD_F1CMN_AXIS_STICK_ROLL, 	name = _('Roll')},
	defaultDeviceAssignmentFor("roll"))
--addInputEntryAxis({action = iCommandPlanePitch, 				name = _('Pitch')},
--	defaultDeviceAssignmentFor("pitch"))
addInputEntryAxis({action = GLOB_CMD_F1CMN_AXIS_STICK_PITCH,	name = _('Pitch')},
	defaultDeviceAssignmentFor("pitch"))
--addInputEntryAxis({action = iCommandPlaneRudder, 				name = _('Rudder')},
--	defaultDeviceAssignmentFor("rudder"))
addInputEntryAxis({action = GLOB_CMD_F1CMN_AXIS_RUDDER, 		name = _('Rudder')},
	defaultDeviceAssignmentFor("rudder"))
addInputEntryAxis({action = iCommandPlaneThrustCommon, 			name = _('Thrust')},
	defaultDeviceAssignmentFor("thrust"))

addInputEntryAxis({action = iCommandLeftWheelBrake,        		name = _('Wheel Brake Left')})
addInputEntryAxis({action = iCommandRightWheelBrake,       		name = _('Wheel Brake Right')})
addInputEntryAxis({action = iCommandWheelBrake,       	 		name = _('Wheel Brakes')})

-- Radar control stick bearing control (horizontal axis)
addInputEntryAxis({action = devCmds.Cmd105, cockpit_device_id = devices.MAIN,	name = _('Radar control stick bearing control'), category = {_('Left console'), _('Radar control stick')}})
-- Radar control stick range/velocity control (vertical axis)
addInputEntryAxis({action = devCmds.Cmd108, cockpit_device_id = devices.MAIN,	name = _('Radar control stick range/velocity control'), category = {_('Left console'), _('Radar control stick')}})
-- Radar control stick gain control wheel
addInputEntryAxis({action = devCmds.Cmd113, cockpit_device_id = devices.MAIN,	name = _('Radar control stick gain control wheel'), category = {_('Left console'), _('Radar control stick')}})


----------------------------------------------------------------

local resJoint
if isJoystick(deviceName) then
	resJoint = external_profile("Config/Input/Aircrafts/common_joystick_binding.lua")
	join(resJoint.axisCommands, res.axisCommands)
else
	resJoint = external_profile("Config/Input/Aircrafts/common_keyboard_binding.lua")
end

join(resJoint.keyCommands, res.keyCommands)

return resJoint
