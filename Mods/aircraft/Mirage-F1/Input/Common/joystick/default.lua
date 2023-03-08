local cpt_cmn_folder = folder.."../../../Cockpit/Common/"
dofile(cpt_cmn_folder.."devices.lua")
dofile(cpt_cmn_folder.."command_defs.lua")
local res = external_profile("Config/Input/Aircrafts/common_joystick_binding.lua")

join(res.keyCommands,{

{down = iCommandCockpitShowPilotOnOff, 		name = _('Show Pilot Body'), category = _('General')},

----------------------------------------------------------------
--Flight Control
--{down = iCommandPlaneTrimCancel, name = 'Trim Reset', category = 'Flight Control'},

----------------------------------------------------------------
-- Control Stick show/hide
--{down = 8032, cockpit_device_id = devices.SYSTEMS, value_down = 1.0, name = _('SHOW/HIDE FLIGHT STICK'), category = {_('Flight Control')}},

{down = iCommandPlaneUpStart,				up = iCommandPlaneUpStop,			name = _('Aircraft Pitch Down'),	category = _('Flight Control')},
{down = iCommandPlaneDownStart,				up = iCommandPlaneDownStop,			name = _('Aircraft Pitch Up'),		category = _('Flight Control')},
{down = iCommandPlaneLeftStart,				up = iCommandPlaneLeftStop,			name = _('Aircraft Bank Left'),		category = _('Flight Control')},
{down = iCommandPlaneRightStart,			up = iCommandPlaneRightStop,		name = _('Aircraft Bank Right'),	category = _('Flight Control')},
{down = iCommandPlaneLeftRudderStart,		up = iCommandPlaneLeftRudderStop,	name = _('Aircraft Rudder Left'),	category = _('Flight Control')},
{down = iCommandPlaneRightRudderStart,		up = iCommandPlaneRightRudderStop,	name = _('Aircraft Rudder Right'),	category = _('Flight Control')},

{pressed = iCommandPlaneTrimUp,				up = iCommandPlaneTrimStop, name = _('Trim: Nose Up'),			category = _('Flight Control')},
{pressed = iCommandPlaneTrimDown,			up = iCommandPlaneTrimStop, name = _('Trim: Nose Down'),		category = _('Flight Control')},
{pressed = iCommandPlaneTrimLeft,			up = iCommandPlaneTrimStop, name = _('Trim: Left Wing Down'),	category = _('Flight Control')},
{pressed = iCommandPlaneTrimRight,			up = iCommandPlaneTrimStop, name = _('Trim: Right Wing Down'),	category = _('Flight Control')},
{pressed = iCommandPlaneTrimLeftRudder,		up = iCommandPlaneTrimStop, name = _('Trim: Rudder Left'),		category = _('Flight Control')},
{pressed = iCommandPlaneTrimRightRudder,	up = iCommandPlaneTrimStop, name = _('Trim: Rudder Right'),		category = _('Flight Control')},

{pressed = iCommandThrottleIncrease,		up = iCommandThrottleStop,  name = _('Throttle Up'),		category = _('Flight Control')},
{pressed = iCommandThrottleDecrease,		up = iCommandThrottleStop,  name = _('Throttle Down'),		category = _('Flight Control')},

{down = iCommandPlaneAirBrake,				up = iCommandPlaneAirBrakeOff, 		name = _('Airbrake'),				category = _('Systems') , features = {"airbrake"}},
{down = iCommandPlaneAirBrakeOn,			name = _('Airbrake On'),							category = _('Systems') , features = {"airbrake"}},
{down = iCommandPlaneAirBrakeOff,			name = _('Airbrake Off'),							category = _('Systems') , features = {"airbrake"}},

{down = iCommandPlaneFlaps,					name = _('Slat/Flap lever - one step up/down'),		category = _('Systems')},
{down = iCommandPlaneFlapsOn,				name = _('Slat/Flap lever - one step down'),		category = _('Systems')},
{down = iCommandPlaneFlapsOff,				name = _('Slat/Flap lever - one step up'),			category = _('Systems')},

{down = iCommandPlaneGear,					name = _('Landing Gear Up/Down'),					category = _('Systems')},
{down = iCommandPlaneGearUp,				name = _('Landing Gear Up'),						category = _('Systems')},
{down = iCommandPlaneGearDown,				name = _('Landing Gear Down'),						category = _('Systems')},

{down = iCommandPlaneWheelBrakeOn, up = iCommandPlaneWheelBrakeOff, name = _('Wheel Brake On'),	category = _('Systems')},
--{down = iCommandPlaneFonar,					name = _('Canopy Open/Close'),						category = _('Systems')},
{down = iCommandPlaneEject,					name = _('Eject (3 times)'),						category = _('Systems')},

----------------------------------------------------------------
-- Cheat
{down = iCommandEnginesStart, 				name = ('Auto Start'), category = _('Cheat')},
{down = iCommandEnginesStop,  				name = ('Auto Stop') , category = _('Cheat')},

----------------------------------------------------------------
-- View Cockpit
{down = iCommandToggleMirrors,				name = _('Toggle Mirrors'),							category = _('View Cockpit'), features = {"Mirrors"}},

----------------------------------------------------------------
-- Cockpit Camera Motion
{down = iCommandViewTransposeModeOn, up = iCommandViewTransposeModeOff, name = _('Camera transpose mode (press and hold)'), category = _('View Cockpit')},
{down = iCommand_ExplorationStart, 			name = _('Enable visual recon mode'), category = _('View Cockpit')},

----------------------------------------------------------------
--Wheel brake
{down = iCommandPlaneWheelBrakeLeftOn, up = iCommandPlaneWheelBrakeLeftOff, name = _('Wheel Brake Left On/Off'), category = _('Systems')},
{down = iCommandPlaneWheelBrakeRightOn, up = iCommandPlaneWheelBrakeRightOff, name = _('Wheel Brake Right On/Off'), category = _('Systems')},

----------------------------------------------------------------
-- Helmet glass
{down = 8028, cockpit_device_id = devices.HELMET, name = _('Helmet glass'), category =_('General')},

----------------------------------------------------------------
-- Incidence test switch
{down = devCmds.Cmd10, up = devCmds.Cmd10, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Incidence test switch - INC'), category = {_('Left console'), _('Air data system')}},
{down = devCmds.Cmd11, up = devCmds.Cmd11, cockpit_device_id = devices.MAIN, value_down = -1.0, value_up = 0.0, name = _('Incidence test switch - DEC'), category = {_('Left console'), _('Air data system')}},

----------------------------------------------------------------
-- Flying aid and autopilot interlocks test display unit.

-- Flight control test restart button
{down = devCmds.Cmd12, up = devCmds.Cmd12, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Flight control test restart button'), category = {_('Left console'), _('Flight controls and flying aids')}},
-- Flight control test switch guard
{down = devCmds.Cmd13, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Flight control test switch guard - OPEN'), category = {_('Left console'), _('Flight controls and flying aids')}},
{down = devCmds.Cmd13, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Flight control test switch guard - CLOSE'), category = {_('Left console'), _('Flight controls and flying aids')}},
-- Flight control test switch
{down = devCmds.Cmd14, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Flight control test switch - ON'), category = {_('Left console'), _('Flight controls and flying aids')}},
{down = devCmds.Cmd14, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Flight control test switch - OFF'), category = {_('Left console'), _('Flight controls and flying aids')}},

----------------------------------------------------------------
-- Flight Control System controls

-- Servo reset button
{down = devCmds.Cmd20, up = devCmds.Cmd20, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Servo reset button'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
-- Stick uncouple switch
{down = devCmds.Cmd21, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Stick uncouple switch - ON'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
{down = devCmds.Cmd21, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Stick uncouple switch - OFF'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
-- Stick uncouple switch guard
{down = devCmds.Cmd22, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Stick uncouple switch guard - OPEN'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
{down = devCmds.Cmd22, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Stick uncouple switch guard - CLOSE'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
-- ARTHUR selector switch guard
{down = devCmds.Cmd23, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('ARTHUR selector switch guard - OPEN'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
{down = devCmds.Cmd23, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('ARTHUR selector switch guard - CLOSE'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
-- ARTHUR selector switch
{down = devCmds.Cmd24, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('ARTHUR selector switch - AUTO'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
{down = devCmds.Cmd24, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('ARTHUR selector switch - HIGH'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
{down = devCmds.Cmd24, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('ARTHUR selector switch - LOW'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
-- Yaw/Anti-slip switch
{down = devCmds.Cmd25, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Yaw/Anti-slip switch - ANTI-SLIP'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
{down = devCmds.Cmd25, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Yaw/Anti-slip switch - YAW'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
{down = devCmds.Cmd25, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Yaw/Anti-slip switch - OFF'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
-- Pitch switch
{down = devCmds.Cmd26, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Pitch switch - ON'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
{down = devCmds.Cmd26, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Pitch switch - OFF'), category = {_('Left front panel'), _('Flight controls and flying aids')}},
-- Rudder trim control switch
{combos = {{key = 'Z', reformers = {"LCtrl", "LAlt", "LWin"}}},	down = devCmds.Cmd27, up = devCmds.Cmd27, cockpit_device_id = devices.MAIN,	value_down = 1.0, value_up = 0.0, name = _('Rudder trim control switch left'), category = {_('Left console'), _('Flight controls and flying aids')}},
{combos = {{key = 'X', reformers = {"LCtrl", "LAlt", "LWin"}}},	down = devCmds.Cmd28, up = devCmds.Cmd28, cockpit_device_id = devices.MAIN,	value_down = -1.0, value_up = 0.0, name = _('Rudder trim control switch right'),	category = {_('Left console'), _('Flight controls and flying aids')}},

----------------------------------------------------------------
-- Autopilot

-- Autopilot PA button
{down = devCmds.Cmd35, up = devCmds.Cmd35, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Autopilot PA button'), category = {_('Central front panel'), _('Autopilot')}},
-- Autopilot ALT button
{down = devCmds.Cmd36, up = devCmds.Cmd36, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Autopilot ALT button'), category = {_('Central front panel'), _('Autopilot')}},
-- Autopilot CAP button
{down = devCmds.Cmd37, up = devCmds.Cmd37, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Autopilot CAP button'), category = {_('Central front panel'), _('Autopilot')}},
-- Autopilot R button
{down = devCmds.Cmd38, up = devCmds.Cmd38, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Autopilot R button'), category = {_('Central front panel'), _('Autopilot')}},
-- Autopilot G button
{down = devCmds.Cmd39, up = devCmds.Cmd39, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Autopilot G button'), category = {_('Central front panel'), _('Autopilot')}},
-- Autopilot disconnect trigger
{down = devCmds.Cmd40, up = devCmds.Cmd40, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Autopilot disconnect trigger'), category = {_('Control stick'), _('Autopilot')}},
-- Autopilot intensity control
{pressed = devCmds.Cmd41, cockpit_device_id = devices.MAIN, value_pressed = 1, name = _('Autopilot intensity control increase'), category = {_('Central front panel'), _('Autopilot')}},
{combos = {{key = 'A', reformers = {"LCtrl"}}},pressed = devCmds.Cmd41, cockpit_device_id = devices.MAIN, value_pressed = -1, name = _('Autopilot intensity control decrease'), category = {_('Central front panel'), _('Autopilot')}},
-- Autopilot control and indicator unit test button
{down = devCmds.Cmd42, up = devCmds.Cmd42, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Autopilot control and indicator unit test button'), category = {_('Central front panel'), _('Autopilot')}},
-- Autopilot disengage lever
{down = devCmds.Cmd630, up = devCmds.Cmd630, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Autopilot disengage lever'), category = {_('Control stick'), _('Autopilot')}},

----------------------------------------------------------------
-- Engine/Fuel controls

-- Throttle cut/idle switch
{down = devCmds.Cmd51, up = devCmds.Cmd51, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Throttle cut/idle switch'), category = {_('Left console'), _('Engine/Fuel controls')}},
-- Engine restart switch
{down = devCmds.Cmd52, up = devCmds.Cmd53, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('In-flight relight control'), category = {_('Left console'), _('Engine/Fuel controls')}},
-- Ignition/Ventilation selector switch - 'R/H', 'L/H', 'Ventil'
{down = devCmds.Cmd54, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _("Ignition/Ventilation selector switch - L/H"), category = {_('Left console'), _('Engine/Fuel controls')}},
{down = devCmds.Cmd54, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _("Ignition/Ventilation selector switch - R/H"), category = {_('Left console'), _('Engine/Fuel controls')}},
{down = devCmds.Cmd54, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _("Ignition/Ventilation selector switch - VENTIL"), category = {_('Left console'), _('Engine/Fuel controls')}},
-- Start button cover
{down = devCmds.Cmd55, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Start button cover - OPEN'), category = {_('Left console'), _('Engine/Fuel controls')}},
{down = devCmds.Cmd55, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Start button cover - CLOSE'), category = {_('Left console'), _('Engine/Fuel controls')}},
-- Start button
{down = devCmds.Cmd56, up = devCmds.Cmd56, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Start button'), category = {_('Left console'), _('Engine/Fuel controls')}},
-- LP main cock switch guard
{down = devCmds.Cmd57, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('LP main cock switch guard - OPEN'), category = {_('Left console'), _('Engine/Fuel controls')}},
{down = devCmds.Cmd57, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('LP main cock switch guard - CLOSE'), category = {_('Left console'), _('Engine/Fuel controls')}},
-- LP main cock switch
{down = devCmds.Cmd58, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('LP main cock switch - OFF'), category = {_('Left console'), _('Engine/Fuel controls')}},
{down = devCmds.Cmd58, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('LP main cock switch - OPEN'), category = {_('Left console'), _('Engine/Fuel controls')}},
-- JPT emergency regulation switch
{down = devCmds.Cmd62, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('JPT emergency regulation switch - AUTO'), category = {_('Left console'), _('Engine/Fuel controls')}},
{down = devCmds.Cmd62, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('JPT emergency regulation switch - OFF'), category = {_('Left console'), _('Engine/Fuel controls')}},
-- A/B main cock switch guard
{down = devCmds.Cmd63, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('A/B main cock switch guard - OPEN'), category = {_('Left console'), _('Engine/Fuel controls')}},
{down = devCmds.Cmd63, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('A/B main cock switch guard - CLOSE'), category = {_('Left console'), _('Engine/Fuel controls')}},
-- A/B main cock switch
{down = devCmds.Cmd64, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('A/B main cock switch - OFF'), category = {_('Left console'), _('Engine/Fuel controls')}},
{down = devCmds.Cmd64, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('A/B main cock switch - ON'), category = {_('Left console'), _('Engine/Fuel controls')}},
-- Starting pump switch
{down = devCmds.Cmd65, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Starting pump switch - ON'), category = {_('Left console'), _('Engine/Fuel controls')}},
{down = devCmds.Cmd65, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Starting pump switch - OFF'), category = {_('Left console'), _('Engine/Fuel controls')}},
-- R/H LP pump switch
{down = devCmds.Cmd66, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('R/H LP pump switch - ON'), category = {_('Left console'), _('Engine/Fuel controls')}},
{down = devCmds.Cmd66, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('R/H LP pump switch - OFF'), category = {_('Left console'), _('Engine/Fuel controls')}},
-- L/H LP pump switch
{down = devCmds.Cmd67, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('L/H LP pump switch - ON'), category = {_('Left console'), _('Engine/Fuel controls')}},
{down = devCmds.Cmd67, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('L/H LP pump switch - OFF'), category = {_('Left console'), _('Engine/Fuel controls')}},
-- Shock-cone manual control switch
{down = devCmds.Cmd68, up = devCmds.Cmd68, cockpit_device_id = devices.MAIN,	value_down = 1.0, value_up = 0.0, name = _('Shock-cone manual control switch up'), category = {_('Central front panel'), _('Engine/Fuel controls')}},
{combos = {{key = 'C', reformers = {'RCtrl'}}},	down = devCmds.Cmd69, up = devCmds.Cmd69, cockpit_device_id = devices.MAIN,	value_down = -1.0, value_up = 0.0, name = _('Shock-cone manual control switch down'),	category = {_('Central front panel'), _('Engine/Fuel controls')}},
-- Shock-cone pushbutton
{down = devCmds.Cmd70, up = devCmds.Cmd71, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Shock-cone pushbutton'), category = {_('Central front panel'), _('Engine/Fuel controls')}},
-- Firing fuel dipper switch
{down = devCmds.Cmd72, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Firing fuel dipper switch - ON'), category = {_('Right console'), _('Engine/Fuel controls')}},
{combos = {{key = 'F', reformers = {"LCtrl", "LWin"}}},	down = devCmds.Cmd72, cockpit_device_id = devices.MAIN,	value_down = 0.0, name = _('Firing fuel dipper switch - OFF'),	category = {_('Right console'), _('Engine/Fuel controls')}},

----------------------------------------------------------------
-- Fuel quantity indicator

-- Feeder tank/Fuselage selector switch
{down = devCmds.Cmd75, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Feeder tank/Fuselage selector switch - FT'), category = {_('Central front panel'), _('Fuel system')}},
{down = devCmds.Cmd75, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Feeder tank/Fuselage selector switch - F'), category = {_('Central front panel'), _('Fuel system')}},
-- Fuel gauge test button
{down = devCmds.Cmd76, up = devCmds.Cmd76, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Fuel gauge test button'), category = {_('Central front panel'), _('Fuel system')}},

----------------------------------------------------------------
-- Jettisoning panel

-- Emergency jettison button guard
{down = devCmds.Cmd77, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Emergency jettison button guard - OPEN'), category = {_('Central front panel'), _('Fuel system')}},
{down = devCmds.Cmd77, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Emergency jettison button guard - CLOSE'), category = {_('Central front panel'), _('Fuel system')}},
-- Emergency jettison button
{down = devCmds.Cmd78, up = devCmds.Cmd78, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Emergency jettison button'), category = {_('Central front panel'), _('Fuel system')}},
-- Selective jettison button guard
{down = devCmds.Cmd79, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Selective jettison button guard - OPEN'), category = {_('Central front panel'), _('Fuel system')}},
{down = devCmds.Cmd79, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Selective jettison button guard - CLOSE'), category = {_('Central front panel'), _('Fuel system')}},
-- Selective jettison button
{down = devCmds.Cmd80, up = devCmds.Cmd80, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Selective jettison button'), category = {_('Central front panel'), _('Fuel system')}},
-- Jettisoning selector switch
{down = devCmds.Cmd81, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Jettisoning selector switch - WING 2'), category = {_('Central front panel'), _('Fuel system')}},
{down = devCmds.Cmd81, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Jettisoning selector switch - WING 1'), category = {_('Central front panel'), _('Fuel system')}},
{down = devCmds.Cmd81, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Jettisoning selector switch - FUS'), category = {_('Central front panel'), _('Fuel system')}},

----------------------------------------------------------------
-- Fuel transfer, refuelling and indication

-- Fuel quantity reset thumbwheel
{down = devCmds.Cmd82, up = devCmds.Cmd82, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Fuel quantity reset thumbwheel'), category = {_('Central front panel'), _('Fuel system')}},
-- Crossfeed switch
{down = devCmds.Cmd83, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Crossfeed switch - ON'), category = {_('Central front panel'), _('Fuel system')}},
{down = devCmds.Cmd83, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Crossfeed switch - OFF'), category = {_('Central front panel'), _('Fuel system')}},
-- Emergency transfer switch
{down = devCmds.Cmd84, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Emergency transfer switch - ON'), category = {_('Central front panel'), _('Fuel system')}},
{down = devCmds.Cmd84, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Emergency transfer switch - OFF'), category = {_('Central front panel'), _('Fuel system')}},
-- Fuel transfer sequence selector switch
{down = devCmds.Cmd85, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Fuel transfer sequence selector switch - CLEAN'), category = {_('Central front panel'), _('Fuel system')}},
{down = devCmds.Cmd85, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Fuel transfer sequence selector switch - WG. PYL. TK'), category = {_('Central front panel'), _('Fuel system')}},
-- Fuel transfer indicator test
{down = devCmds.Cmd86, up = devCmds.Cmd86, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Fuel transfer indicator test'), category = {_('Central front panel'), _('Fuel system')}},

----------------------------------------------------------------
-- Radar control stick

-- Radar control stick elevation/altitude difference button
{down = devCmds.Cmd100, up = devCmds.Cmd100, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick elevation/altitude difference button'), category = {_('Left console'), _('Radar control stick')}},
-- Radar control stick scale selection
{down = devCmds.Cmd102, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Radar control stick scale selection - LEFT'), category = {_('Left console'), _('Radar control stick')}},
{down = devCmds.Cmd102, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Radar control stick scale selection - RIGHT'), category = {_('Left console'), _('Radar control stick')}},
-- Radar control stick scan selection
{down = devCmds.Cmd104, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Radar control stick scan selection - LEFT'), category = {_('Left console'), _('Radar control stick')}},
{down = devCmds.Cmd104, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Radar control stick scan selection - RIGHT'), category = {_('Left console'), _('Radar control stick')}},
-- Radar control stick bearing control (horizontal axis)
{down = devCmds.Cmd106, up = devCmds.Cmd106, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick bearing control - right'), category = {_('Left console'), _('Radar control stick')}},
{down = devCmds.Cmd107, up = devCmds.Cmd107, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick bearing control - left'), category = {_('Left console'), _('Radar control stick')}},
-- Radar control stick range/velocity control (vertical axis)
{down = devCmds.Cmd109, up = devCmds.Cmd109, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick range/velocity control - increase'), category = {_('Left console'), _('Radar control stick')}},
{down = devCmds.Cmd110, up = devCmds.Cmd110, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick range/velocity control - decrease'), category = {_('Left console'), _('Radar control stick')}},
-- Radar control stick elevation control buttons
{down = devCmds.Cmd111, up = devCmds.Cmd111, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick elevation increase button'), category = {_('Left console'), _('Radar control stick')}},
{down = devCmds.Cmd112, up = devCmds.Cmd112, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick elevation decrease button'), category = {_('Left console'), _('Radar control stick')}},
-- Radar control stick gain control wheel
{down = devCmds.Cmd114, up = devCmds.Cmd114, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick gain control wheel - increase'), category = {_('Left console'), _('Radar control stick')}},
{down = devCmds.Cmd115, up = devCmds.Cmd115, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick gain control wheel - decrease'), category = {_('Left console'), _('Radar control stick')}},
-- Radar control stick fast gain reset button
{down = devCmds.Cmd116, up = devCmds.Cmd116, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick fast gain reset button'), category = {_('Left console'), _('Radar control stick')}},
-- Radar control stick APS/APC lever - TWS
{down = devCmds.Cmd117, up = devCmds.Cmd117, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick APS/APC lever - TWS'), category = {_('Left console'), _('Radar control stick')}},
-- Radar control stick APS/APC lever - Lock-On
{down = devCmds.Cmd117, up = devCmds.Cmd117, cockpit_device_id = devices.MAIN, value_down = -1.0, value_up = 0.0, name = _('Radar control stick APS/APC lever - Lock-On'), category = {_('Left console'), _('Radar control stick')}},
-- Radar control stick unlocking control
{down = devCmds.Cmd118, up = devCmds.Cmd118, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Radar control stick unlocking control'), category = {_('Left console'), _('Radar control stick')}},

----------------------------------------------------------------
-- Main PTT (VOIP)
{down = devCmds.Cmd119, up = devCmds.Cmd119, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('VoIP PTT button (custom)'), category = {_('Radio system')}},
-- Alternative PTT
{down = devCmds.Cmd120, up = devCmds.Cmd120, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Alternative PTT'), category = {_('Left console'), _('Radio system')}},

----------------------------------------------------------------
-- High-lift devices

-- Slat/Flap lever
{down = devCmds.Cmd122, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Slat/Flap lever - full flap'), category = {_('Left console'), _('High-lift devices')}},
{down = devCmds.Cmd122, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Slat/Flap lever - 1/2 flap'), category = {_('Left console'), _('High-lift devices')}},
{down = devCmds.Cmd122, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Slat/Flap lever - full up'), category = {_('Left console'), _('High-lift devices')}},
{down = devCmds.Cmd122, up = devCmds.Cmd122, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.5, name = _('Slat/Flap lever - HOTAS flaps down'), category = {_('Left console'), _('High-lift devices')}},
{down = devCmds.Cmd122, up = devCmds.Cmd122, cockpit_device_id = devices.MAIN ,value_down = -1.0, value_up = 0.5, name = _('Slat/Flap lever - HOTAS flaps up'), category = {_('Left console'), _('High-lift devices')}},
-- High-lift device selector switch
{down = devCmds.Cmd123, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('High-lift device selector switch - NORMAL'), category = {_('Left console'), _('High-lift devices')}},
{down = devCmds.Cmd123, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('High-lift device selector switch - OFF'), category = {_('Left console'), _('High-lift devices')}},
{down = devCmds.Cmd123, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('High-lift device selector switch - EMG. RETR.'), category = {_('Left console'), _('High-lift devices')}},
-- Combat flap lever
{down = devCmds.Cmd638, up = devCmds.Cmd638, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Combat flap lever'), category = {_('Throttle lever'), _('High-lift devices')}},
-- Combat flap button
{down = devCmds.Cmd639, up = devCmds.Cmd639, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Combat flap button'), category = {_('Throttle lever'), _('High-lift devices')}},

----------------------------------------------------------------
-- Radio selector unit

-- MISS potentiometer
{pressed = devCmds.Cmd125, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('MISS potentiometer - Increase'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
{pressed = devCmds.Cmd125, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('MISS potentiometer - Decrease'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
-- TAC potentiometer
{pressed = devCmds.Cmd127, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('TAC potentiometer - Increase'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
{pressed = devCmds.Cmd127, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('TAC potentiometer - Decrease'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
-- VOR potentiometer
{pressed = devCmds.Cmd129, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('VOR potentiometer - Increase'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
{pressed = devCmds.Cmd129, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('VOR potentiometer - Decrease'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
-- "AMPLI 2-1" selector switch
{down = devCmds.Cmd130, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('AMPLI 2-1" selector switch - 1'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
{down = devCmds.Cmd130, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('AMPLI 2-1" selector switch - 2'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
-- U + V pushbutton
{down = devCmds.Cmd131, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('U + V pushbutton - PUSH'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
{pressed = devCmds.Cmd133, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('U + V pushbutton - Increase'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
{pressed = devCmds.Cmd133, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('U + V pushbutton - Decrease'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
-- U pushbutton
{down = devCmds.Cmd134, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('U pushbutton - PUSH'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
{pressed = devCmds.Cmd136, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('U pushbutton - Increase'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
{pressed = devCmds.Cmd136, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('U pushbutton - Decrease'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
-- RAP + CME pushbutton
{down = devCmds.Cmd137, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('RAP + CME pushbutton - PUSH'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
{pressed = devCmds.Cmd139, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('RAP + CME pushbutton - Increase'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
{pressed = devCmds.Cmd139, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('RAP + CME pushbutton - Decrease'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
-- MKR + TP pushbutton
{down = devCmds.Cmd140, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('MKR + TP pushbutton - PUSH'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
{pressed = devCmds.Cmd142, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('MKR + TP pushbutton - Increase'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},
{pressed = devCmds.Cmd142, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('MKR + TP pushbutton - Decrease'), category = {_('Left console'), _('Radio system'), _('Radio selector unit')}},

----------------------------------------------------------------
-- V/UHF control unit

-- Test selector switch
{down = devCmds.Cmd145, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('V/UHF control unit test selector switch - E + A2'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
{down = devCmds.Cmd145, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('V/UHF control unit test selector switch - R'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
-- SIL switch
{down = devCmds.Cmd146, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('SIL switch - ON'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
{down = devCmds.Cmd146, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('SIL switch - OFF'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
-- Frequency select thumbwheel - Hundreds
{down = devCmds.Cmd148, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Frequency select thumbwheel - Hundreds - Increase'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
{down = devCmds.Cmd148, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Frequency select thumbwheel - Hundreds - Decrease'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
-- Frequency select thumbwheel - Tens
{down = devCmds.Cmd150, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Frequency select thumbwheel - Tens - Increase'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
{down = devCmds.Cmd150, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Frequency select thumbwheel - Tens - Decrease'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
-- Frequency select thumbwheel - Units
{down = devCmds.Cmd152, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Frequency select thumbwheel - Units - Increase'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
{down = devCmds.Cmd152, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Frequency select thumbwheel - Units - Decrease'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
-- Frequency select thumbwheel - Tenths
{down = devCmds.Cmd154, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Frequency select thumbwheel - Tenths - Increase'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
{down = devCmds.Cmd154, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Frequency select thumbwheel - Tenths - Decrease'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
-- Frequency select thumbwheel - Thousandths
{down = devCmds.Cmd156, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Frequency select thumbwheel - Thousandths - Increase'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
{down = devCmds.Cmd156, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Frequency select thumbwheel - Thousandths - Decrease'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
-- Function selector
{down = devCmds.Cmd158, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('V/UHF control unit function selector - Clockwise'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
{down = devCmds.Cmd158, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('V/UHF control unit function selector - Counterclockwise'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
-- 25W - 5W switch
{down = devCmds.Cmd159, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('25W - 5W switch - 5W'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
{down = devCmds.Cmd159, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('25W - 5W switch - 25W'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
-- Frequency selector switch
{down = devCmds.Cmd161, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Frequency selector switch - Clockwise'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
{down = devCmds.Cmd161, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Frequency selector switch - Counterclockwise'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
-- Channel selector
{down = devCmds.Cmd163, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('V/UHF control unit channel selector - Clockwise'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},
{down = devCmds.Cmd163, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('V/UHF control unit channel selector - Counterclockwise'), category = {_('Left console'), _('Radio system'), _('V/UHF control unit')}},

----------------------------------------------------------------
-- Engine emergency regulation

-- Emergency regulation light
{down = devCmds.Cmd165, up = devCmds.Cmd165, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Emergency regulation light - PUSH'), category = {_('Left wall'), _('Engine emergency regulation')}},
{pressed = devCmds.Cmd166, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Emergency regulation light - Increase'), category = {_('Left wall'), _('Engine emergency regulation')}},
{pressed = devCmds.Cmd166, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Emergency regulation light - Decrease'), category = {_('Left wall'), _('Engine emergency regulation')}},
-- Emergency regulation switch guard
{down = devCmds.Cmd167, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Emergency regulation switch guard - OPEN'), category = {_('Left wall'), _('Engine emergency regulation')}},
{down = devCmds.Cmd167, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Emergency regulation switch guard - CLOSE'), category = {_('Left wall'), _('Engine emergency regulation')}},
-- Emergency regulation switch
{down = devCmds.Cmd168, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Emergency regulation switch - ON'), category = {_('Left wall'), _('Engine emergency regulation')}},
{down = devCmds.Cmd168, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Emergency regulation switch - OFF'), category = {_('Left wall'), _('Engine emergency regulation')}},
-- Emergency regulation control lever
{combos = {{key = 'PageUp'}},	down = devCmds.Cmd169, up = devCmds.Cmd169, cockpit_device_id = devices.MAIN,	value_down = 1.0, value_up = 0.0, name = _('Emergency regulation control lever - Forward/Increase'), category = {_('Left wall'), _('Engine emergency regulation')}},
{combos = {{key = 'PageDown'}},	down = devCmds.Cmd170, up = devCmds.Cmd170, cockpit_device_id = devices.MAIN,	value_down = -1.0, value_up = 0.0, name = _('Emergency regulation control lever - Aft/Decrease'),	category = {_('Left wall'), _('Engine emergency regulation')}},

-- Brake chute control
{down = devCmds.Cmd171, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Brake chute control - Aft/Open'), category = {_('Left wall'), _('Systems')}},
{down = devCmds.Cmd171, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Brake chute control - Forward/Drop'), category = {_('Left wall'), _('Systems')}},

----------------------------------------------------------------
-- Canopy controls

-- Canopy lock control
{down = devCmds.Cmd172, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Canopy lock control - Aft/Open'), category = {_('Right wall'), _('Systems')}},
{down = devCmds.Cmd172, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Canopy lock control - Forward/Close'), category = {_('Right wall'), _('Systems')}},
-- Canopy embrittle control
{down = devCmds.Cmd173, up = devCmds.Cmd173, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Canopy embrittle control'), category = {_('Left wall'), _('Systems')}},
-- Canopy hinged handle
{down = devCmds.Cmd174, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Canopy hinged handle - Extend'), category = {_('Front structure'), _('Systems')}},
{down = devCmds.Cmd174, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Canopy hinged handle - Retract'), category = {_('Front structure'), _('Systems')}},
-- Canopy seal valve control lever
{down = devCmds.Cmd175, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Canopy seal valve control lever - Deflate'), category = {_('Right wall'), _('Systems')}},
{down = devCmds.Cmd175, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Canopy seal valve control lever - Inflate'), category = {_('Right wall'), _('Systems')}},
-- Mirrors
{down = devCmds.Cmd176, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mirrors - Fold'), category = {_('Front structure'), _('Systems')}},
{down = devCmds.Cmd176, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Mirrors - Unfold'), category = {_('Front structure'), _('Systems')}},
-- Canopy handle
{down = devCmds.Cmd178, cockpit_device_id = devices.MAIN, value_down = 0.99, name = _('Canopy handle - OPEN/CLOSE'), category = {_('Front structure'), _('Systems')}},

----------------------------------------------------------------
-- Undercarriage, nose wheel steering, brake and anti-skid

-- U/C safety lever
{down = devCmds.Cmd190, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('U/C safety lever - OPEN'), category = {_('Left front panel'), _('Systems'), _('Undercarriage')}},
{down = devCmds.Cmd190, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('U/C safety lever - CLOSE'), category = {_('Left front panel'), _('Systems'), _('Undercarriage')}},
-- U/C control lever
{down = devCmds.Cmd191, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('U/C control lever - Extend'), category = {_('Left front panel'), _('Systems'), _('Undercarriage')}},
{down = devCmds.Cmd191, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('U/C control lever - Retract'), category = {_('Left front panel'), _('Systems'), _('Undercarriage')}},
-- Anti-retraction override button
{down = devCmds.Cmd192, up = devCmds.Cmd192, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Anti-retraction override button'), category = {_('Left front panel'), _('Systems'), _('Undercarriage')}},
-- Emergency/Parking brake handle
{down = devCmds.Cmd193, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Emergency/Parking brake handle - Push/Release'), category = {_('Left front panel'), _('Systems'), _('Braking system')}},
{down = devCmds.Cmd193, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Emergency/Parking brake handle - Pull/Set'), category = {_('Left front panel'), _('Systems'), _('Braking system')}},
-- Anti-skid (SPAD) switch guard
{down = devCmds.Cmd194, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Anti-skid (SPAD) switch guard - OPEN'), category = {_('Central front panel'), _('Systems'), _('Anti-skid')}},
{down = devCmds.Cmd194, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Anti-skid (SPAD) switch guard - CLOSE'), category = {_('Central front panel'), _('Systems'), _('Anti-skid')}},
-- Anti-skid (SPAD) switch
{down = devCmds.Cmd195, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Anti-skid (SPAD) switch - OFF'), category = {_('Central front panel'), _('Systems'), _('Anti-skid')}},
{down = devCmds.Cmd195, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Anti-skid (SPAD) switch - ON'), category = {_('Central front panel'), _('Systems'), _('Anti-skid')}},
-- Nose wheel steering high sensitivity button
{down = devCmds.Cmd196, up = devCmds.Cmd197, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Nose wheel steering high sensitivity button'), category = {_('Central front panel'), _('Systems'), _('Nose wheel steering')}},
-- Nose wheel steering switch guard
{down = devCmds.Cmd198, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Nose wheel steering switch guard - OPEN'), category = {_('Central front panel'), _('Systems'), _('Nose wheel steering')}},
{down = devCmds.Cmd198, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Nose wheel steering switch guard - CLOSE'), category = {_('Central front panel'), _('Systems'), _('Nose wheel steering')}},
-- Nose wheel steering switch
{down = devCmds.Cmd199, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Nose wheel steering switch - OFF'), category = {_('Central front panel'), _('Systems'), _('Nose wheel steering')}},
{down = devCmds.Cmd199, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Nose wheel steering switch - ON'), category = {_('Central front panel'), _('Systems'), _('Nose wheel steering')}},
-- Emergency U/C handle
{down = devCmds.Cmd200, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Emergency U/C handle - NORMAL'), category = {_('Right front panel'), _('Systems'), _('Undercarriage')}},
{down = devCmds.Cmd200, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Emergency U/C handle - DOORS'), category = {_('Right front panel'), _('Systems'), _('Undercarriage')}},
{down = devCmds.Cmd200, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Emergency U/C handle - U/C'), category = {_('Right front panel'), _('Systems'), _('Undercarriage')}},

----------------------------------------------------------------
-- Hydraulic system controls

-- Hydraulic pressure selector switch
{down = devCmds.Cmd201, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Hydraulic pressure selector switch - 1 SERVO 2'), category = {_('Central front panel'), _('Systems'), _('Hydraulic system')}},
{down = devCmds.Cmd201, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Hydraulic pressure selector switch - ANC Em.B'), category = {_('Central front panel'), _('Systems'), _('Hydraulic system')}},
-- Electro-pump switch
{down = devCmds.Cmd202, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Electro-pump switch - ON'), category = {_('Right console'), _('Systems'), _('Hydraulic system')}},
{down = devCmds.Cmd202, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Electro-pump switch - OFF'), category = {_('Right console'), _('Systems'), _('Hydraulic system')}},

----------------------------------------------------------------
-- Air data system and miscellaneous instrument controls 

----------------------------------------------------------------
-- Clock

-- Chronometer starting control and clock winding/setting knob
{down = devCmds.Cmd210, up = devCmds.Cmd210, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Chronometer starting control'), category = {_('Front structure'), _('Clock')}},
{pressed = devCmds.Cmd211, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Clock winding/setting knob - Clockwise'), category = {_('Front structure'), _('Clock')}},
{pressed = devCmds.Cmd211, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Clock winding/setting knob - Counterclockwise'), category = {_('Front structure'), _('Clock')}},
-- Clock winding/setting lever
{down = devCmds.Cmd212, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Clock winding/setting lever - Setting'), category = {_('Front structure'), _('Clock')}},
{down = devCmds.Cmd212, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Clock winding/setting lever - Winding'), category = {_('Front structure'), _('Clock')}},

----------------------------------------------------------------
-- Incidence indicator

-- Incidence indicator lighting rheostat
{pressed = devCmds.Cmd214, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Incidence indicator lighting rheostat - Increase'), category = {_('Front structure'), _('Air data system')}},
{pressed = devCmds.Cmd214, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Incidence indicator lighting rheostat - Decrease'), category = {_('Front structure'), _('Air data system')}},

----------------------------------------------------------------
-- Air data instrument controls

-- Mach/Airspeed indicator reference airspeed knob
{pressed = devCmds.Cmd219, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Mach/Airspeed indicator reference airspeed knob - Increase'), category = {_('Central front panel'), _('Air data system')}},
{pressed = devCmds.Cmd219, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Mach/Airspeed indicator reference airspeed knob - Decrease'), category = {_('Central front panel'), _('Air data system')}},
-- Slaved altimeter barometric pressure setting knob
{pressed = devCmds.Cmd221, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Slaved altimeter barometric pressure setting knob - Increase'), category = {_('Central front panel'), _('Air data system')}},
{pressed = devCmds.Cmd221, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Slaved altimeter barometric pressure setting knob - Decrease'), category = {_('Central front panel'), _('Air data system')}},
-- Standby altimeter barometric pressure setting knob
{pressed = devCmds.Cmd223, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Standby altimeter barometric pressure setting knob - Increase'), category = {_('Central front panel'), _('Air data system')}},
{pressed = devCmds.Cmd223, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Standby altimeter barometric pressure setting knob - Decrease'), category = {_('Central front panel'), _('Air data system')}},
-- Probe heater switch
{down = devCmds.Cmd224, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Probe heater switch - ON'), category = {_('Right console'), _('Air data system')}},
{down = devCmds.Cmd224, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Probe heater switch - OFF'), category = {_('Right console'), _('Air data system')}},

----------------------------------------------------------------
-- Heading and vertical reference system and standby horizon controls

-- Standby horizon switch
{down = devCmds.Cmd230, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Standby horizon switch - ON'), category = {_('Right console'), _('Heading and vertical reference system')}},
{down = devCmds.Cmd230, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Standby horizon switch - OFF'), category = {_('Right console'), _('Heading and vertical reference system')}},
-- Spherical indicator day/night selector switch
{pressed = devCmds.Cmd231, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Spherical indicator day/night selector switch - DAY'), category = {_('Central front panel'), _('Heading and vertical reference system')}},
{pressed = devCmds.Cmd231, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Spherical indicator day/night selector switch - NIGHT'), category = {_('Central front panel'), _('Heading and vertical reference system')}},
-- Spherical indicator pole setting and marker beacon light test
{down = devCmds.Cmd232, up = devCmds.Cmd232, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Marker beacon light test'), category = {_('Central front panel'), _('Heading and vertical reference system')}},
{pressed = devCmds.Cmd233, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Spherical indicator pole setting - P'), category = {_('Central front panel'), _('Heading and vertical reference system')}},
{pressed = devCmds.Cmd233, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Spherical indicator pole setting - N'), category = {_('Central front panel'), _('Heading and vertical reference system')}},
-- Standby horizon uncage and aircraft model control
{down = devCmds.Cmd234, up = devCmds.Cmd234, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Standby horizon uncage'), category = {_('Central front panel'), _('Heading and vertical reference system')}},
{pressed = devCmds.Cmd236, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Aircraft model control - UP'), category = {_('Central front panel'), _('Heading and vertical reference system')}},
{pressed = devCmds.Cmd236, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Aircraft model control - DOWN'), category = {_('Central front panel'), _('Heading and vertical reference system')}},

----------------------------------------------------------------
-- Heading control unit

-- Heading and vertical reference system control switch
{down = devCmds.Cmd238, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Heading and vertical reference system control switch - Clockwise'), category = {_('Right console'), _('Heading and vertical reference system')}},
{down = devCmds.Cmd238, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Heading and vertical reference system control switch - Counterclockwise'), category = {_('Right console'), _('Heading and vertical reference system')}},
-- Emergency gyromagnetic compass switch
{down = devCmds.Cmd239, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Emergency gyromagnetic compass switch - ON'), category = {_('Right console'), _('Heading and vertical reference system')}},
{down = devCmds.Cmd239, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Emergency gyromagnetic compass switch - OFF'), category = {_('Right console'), _('Heading and vertical reference system')}},
-- Heading control unit erection button
{down = devCmds.Cmd240, up = devCmds.Cmd240, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Heading control unit erection button'), category = {_('Central front panel'), _('Heading and vertical reference system')}},

----------------------------------------------------------------
-- Electrical system controls

-- Battery switch
{down = devCmds.Cmd250, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Battery switch - ON'), category = {_('Right front panel'), _('Electrical system')}},
{down = devCmds.Cmd250, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Battery switch - OFF'), category = {_('Right front panel'), _('Electrical system')}},
-- Alternator 1 switch
{down = devCmds.Cmd251, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Alternator 1 switch - ON'), category = {_('Right front panel'), _('Electrical system')}},
{down = devCmds.Cmd251, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Alternator 1 switch - OFF'), category = {_('Right front panel'), _('Electrical system')}},
-- Alternator 2 switch
{down = devCmds.Cmd252, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Alternator 2 switch - ON'), category = {_('Right front panel'), _('Electrical system')}},
{down = devCmds.Cmd252, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Alternator 2 switch - OFF'), category = {_('Right front panel'), _('Electrical system')}},
-- TR reset button
{down = devCmds.Cmd253, up = devCmds.Cmd253, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('TR reset button'), category = {_('Right front panel'), _('Electrical system')}},
-- Inverter selector switch
{down = devCmds.Cmd254, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Inverter selector switch - INV'), category = {_('Right front panel'), _('Electrical system')}},
{down = devCmds.Cmd254, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Inverter selector switch - AUTO'), category = {_('Right front panel'), _('Electrical system')}},
{down = devCmds.Cmd255, up = devCmds.Cmd255, cockpit_device_id = devices.MAIN ,value_down = -1.0, value_up = 0.0, name = _('Inverter selector switch - RESET'), category = {_('Right front panel'), _('Electrical system')}},

----------------------------------------------------------------
-- Warning lights

-- Master failure warning light
{down = devCmds.Cmd265, up = devCmds.Cmd265, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Master failure warning light'), category = {_('Central front panel'), _('Warnings')}},
-- Combat flaps light
{down = devCmds.Cmd266, up = devCmds.Cmd266, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Combat flaps light - PUSH'), category = {_('Central front panel'), _('Warnings')}},
{pressed = devCmds.Cmd268, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Combat flaps light - Increase'), category = {_('Central front panel'), _('Warnings')}},
{pressed = devCmds.Cmd268, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Combat flaps light - Decrease'), category = {_('Central front panel'), _('Warnings')}},
-- U/C light
{down = devCmds.Cmd269, up = devCmds.Cmd269, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('U/C light'), category = {_('Central front panel'), _('Warnings')}},
-- Nose wheel steering light
{down = devCmds.Cmd270, up = devCmds.Cmd270, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Nose wheel steering light - PUSH'), category = {_('Central front panel'), _('Warnings')}},
{pressed = devCmds.Cmd272, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Nose wheel steering light - Increase'), category = {_('Central front panel'), _('Warnings')}},
{pressed = devCmds.Cmd272, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Nose wheel steering light - Decrease'), category = {_('Central front panel'), _('Warnings')}},
-- Airbrake light
{down = devCmds.Cmd273, up = devCmds.Cmd273, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Airbrake light - PUSH'), category = {_('Central front panel'), _('Warnings')}},
{pressed = devCmds.Cmd275, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Airbrake light - Increase'), category = {_('Central front panel'), _('Warnings')}},
{pressed = devCmds.Cmd275, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Airbrake light - Decrease'), category = {_('Central front panel'), _('Warnings')}},
-- Limit warning light + Horn
{down = devCmds.Cmd276, up = devCmds.Cmd276, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Limit warning light + Horn'), category = {_('Central front panel'), _('Warnings')}},
-- Fire warning light (ENG/AB) + Horn
{down = devCmds.Cmd277, up = devCmds.Cmd277, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Fire warning light (ENG/AB) + Horn'), category = {_('Central front panel'), _('Warnings')}},
-- A/B INJ light
{down = devCmds.Cmd278, up = devCmds.Cmd278, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('A/B INJ light'), category = {_('Central front panel'), _('Warnings')}},
-- A/B ON light
{down = devCmds.Cmd279, up = devCmds.Cmd279, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('A/B ON light'), category = {_('Central front panel'), _('Warnings')}},
-- A/B SRL light
{down = devCmds.Cmd280, up = devCmds.Cmd280, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('A/B SRL light'), category = {_('Central front panel'), _('Warnings')}},
-- Standby receptacle light
{down = devCmds.Cmd281, up = devCmds.Cmd281, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Standby receptacle light - PUSH'), category = {_('Central front panel'), _('Warnings')}},
{pressed = devCmds.Cmd283, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Standby receptacle light - Increase'), category = {_('Central front panel'), _('Warnings')}},
{pressed = devCmds.Cmd283, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Standby receptacle light - Decrease'), category = {_('Central front panel'), _('Warnings')}},
-- Configuration indicator test button
{down = devCmds.Cmd284, up = devCmds.Cmd284, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Configuration indicator test button'), category = {_('Central front panel'), _('Warnings')}},
-- Failure warning panel T test button
{down = devCmds.Cmd285, up = devCmds.Cmd285, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Failure warning panel T test button'), category = {_('Right front panel'), _('Warnings')}},
-- Failure warning panel O2 test button
{down = devCmds.Cmd286, up = devCmds.Cmd286, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Failure warning panel O2 test button'), category = {_('Right front panel'), _('Warnings')}},
-- Warning horn switch
{down = devCmds.Cmd287, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Warning horn switch - ON'), category = {_('Right console'), _('Warnings')}},
{down = devCmds.Cmd287, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Warning horn switch - OFF'), category = {_('Right console'), _('Warnings')}},
-- (C + M or SW) R light
{down = devCmds.Cmd294, up = devCmds.Cmd294, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('(C + M or SW) R light - PUSH'), category = {_('Central front panel'), _('Warnings')}},
{pressed = devCmds.Cmd296, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('(C + M or SW) R light - Increase'), category = {_('Central front panel'), _('Warnings')}},
{pressed = devCmds.Cmd296, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('(C + M or SW) R light - Decrease'), category = {_('Central front panel'), _('Warnings')}},
-- Cannons too hot light
{down = devCmds.Cmd297, up = devCmds.Cmd297, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Cannons too hot light - PUSH'), category = {_('Right front panel'), _('Armament system'), _('Warnings')}},
{pressed = devCmds.Cmd299, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Cannons too hot light - Increase'), category = {_('Right front panel'), _('Armament system'), _('Warnings')}},
{pressed = devCmds.Cmd299, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Cannons too hot light - Decrease'), category = {_('Right front panel'), _('Armament system'), _('Warnings')}},

-- BIP button
{down = devCmds.Cmd300, up = devCmds.Cmd300, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('BIP button'), category = {_('Central front panel'), _('Warnings')}},

----------------------------------------------------------------
-- Exterior lighting

-- Landing light control
{down = devCmds.Cmd310, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Landing light control - TAXY'), category = {_('Left wall'), _('Exterior lighting')}},
{down = devCmds.Cmd310, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Landing light control - LAND'), category = {_('Left wall'), _('Exterior lighting')}},
{down = devCmds.Cmd310, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Landing light control - OFF'), category = {_('Left wall'), _('Exterior lighting')}},
-- Formation light control
{down = devCmds.Cmd311, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Formation light control - BRIGHT'), category = {_('Right front panel'), _('Exterior lighting')}},
{down = devCmds.Cmd311, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Formation light control - OFF'), category = {_('Right front panel'), _('Exterior lighting')}},
{down = devCmds.Cmd311, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Formation light control - DIM'), category = {_('Right front panel'), _('Exterior lighting')}},
-- Navigation light control
{down = devCmds.Cmd312, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Navigation light control - BRIGHT'), category = {_('Right front panel'), _('Exterior lighting')}},
{down = devCmds.Cmd312, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Navigation light control - OFF'), category = {_('Right front panel'), _('Exterior lighting')}},
{down = devCmds.Cmd312, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Navigation light control - DIM'), category = {_('Right front panel'), _('Exterior lighting')}},
-- Search light control
{down = devCmds.Cmd313, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Search light control - ON'), category = {_('Right console'), _('Exterior lighting')}},
{down = devCmds.Cmd313, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Search light control - OFF'), category = {_('Right console'), _('Exterior lighting')}},

----------------------------------------------------------------
-- Cabin lighting

-- Miscellaneous instrument lighting switch
{down = devCmds.Cmd314, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Miscellaneous instrument lighting switch - Aft'), category = {_('Front structure'), _('Cabin lighting')}},
{down = devCmds.Cmd314, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Miscellaneous instrument lighting switch - Neutral'), category = {_('Front structure'), _('Cabin lighting')}},
{down = devCmds.Cmd314, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Miscellaneous instrument lighting switch - Forward'), category = {_('Front structure'), _('Cabin lighting')}},
-- Map light rheostat
{pressed = devCmds.Cmd316, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Map light rheostat - Clockwise/Increase'), category = {_('Front structure'), _('Cabin lighting')}},
{pressed = devCmds.Cmd316, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Map light rheostat - Counterclockwise/Decrease'), category = {_('Front structure'), _('Cabin lighting')}},
-- Miscellaneous instrument integral lighting rheostat
{pressed = devCmds.Cmd318, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Miscellaneous instrument integral lighting rheostat - Clockwise/Increase'), category = {_('Front structure'), _('Cabin lighting')}},
{pressed = devCmds.Cmd318, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Miscellaneous instrument integral lighting rheostat - Counterclockwise/Decrease'), category = {_('Front structure'), _('Cabin lighting')}},

----------------------------------------------------------------
-- Lighting control unit

-- Day/Night selector switch
{down = devCmds.Cmd319, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Day/Night selector switch - DAY'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}},
{down = devCmds.Cmd319, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Day/Night selector switch - NIGHT'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}},
-- Light and panel lighting rheostat
{pressed = devCmds.Cmd321, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Light and panel lighting rheostat - Clockwise/Increase'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}},
{pressed = devCmds.Cmd321, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Light and panel lighting rheostat - Counterclockwise/Decrease'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}},
-- Ultraviolet lighting rheostat
{pressed = devCmds.Cmd323, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Ultraviolet lighting rheostat - Clockwise/Increase'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}},
{pressed = devCmds.Cmd323, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Ultraviolet lighting rheostat - Counterclockwise/Decrease'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}},
-- Dual instrument panel lighting rheostat (Floodlights)
{pressed = devCmds.Cmd325, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Dual instrument panel lighting rheostat (Floodlights) - Clockwise/Increase'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}},
{pressed = devCmds.Cmd325, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Dual instrument panel lighting rheostat (Floodlights) - Counterclockwise/Decrease'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}},
-- Dual instrument panel lighting rheostat (Integral)
{pressed = devCmds.Cmd327, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Dual instrument panel lighting rheostat (Integral) - Clockwise/Increase'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}},
{pressed = devCmds.Cmd327, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Dual instrument panel lighting rheostat (Integral) - Counterclockwise/Decrease'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}},
-- Dual console and pedestal lighting rheostat (Floodlights)
{pressed = devCmds.Cmd329, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Dual console and pedestal lighting rheostat (Floodlights) - Clockwise/Increase'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}},
{pressed = devCmds.Cmd329, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Dual console and pedestal lighting rheostat (Floodlights) - Counterclockwise/Decrease'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}},
-- Dual console and pedestal lighting rheostat (Integral)
{pressed = devCmds.Cmd331, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Dual console and pedestal lighting rheostat (Integral) - Clockwise/Increase'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}},
{pressed = devCmds.Cmd331, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Dual console and pedestal lighting rheostat (Integral) - Counterclockwise/Decrease'), category = {_('Right console'), _('Cabin lighting'), _('Lighting control unit')}},

----------------------------------------------------------------
-- Radionavigation

----------------------------------------------------------------
-- TACAN control box

-- TACAN X/Y mode selector
{down = devCmds.Cmd335, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('TACAN X/Y mode selector - Y mode'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}},
{down = devCmds.Cmd335, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('TACAN X/Y mode selector - X mode'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}},
-- TACAN frequency hundreds and tens selector
{pressed = devCmds.Cmd336, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('TACAN frequency hundreds and tens selector - Clockwise'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}},
{pressed = devCmds.Cmd336, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('TACAN frequency hundreds and tens selector - Counterclockwise'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}},
-- TACAN mode selector
{down = devCmds.Cmd338, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('TACAN mode selector - Clockwise'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}},
{down = devCmds.Cmd338, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('TACAN mode selector - Counterclockwise'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}},
-- TACAN frequency units selector
{pressed = devCmds.Cmd339, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('TACAN frequency units selector - Clockwise'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}},
{pressed = devCmds.Cmd339, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('TACAN frequency units selector - Counterclockwise'), category = {_('Right console'), _('Radionavigation'), _('TACAN control box')}},

----------------------------------------------------------------
-- VOR/ILS control box

-- VOR-ILS control unit ON/OFF selector
{down = devCmds.Cmd340, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('VOR-ILS control unit ON/OFF selector - ON'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}},
{down = devCmds.Cmd340, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('VOR-ILS control unit ON/OFF selector - OFF'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}},
-- VOR-ILS control unit MHz frequency selector
{pressed = devCmds.Cmd341, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('VOR-ILS control unit MHz frequency selector - Clockwise'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}},
{pressed = devCmds.Cmd341, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('VOR-ILS control unit MHz frequency selector - Counterclockwise'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}},
-- VOR-ILS control unit test selector
{down = devCmds.Cmd342, up = devCmds.Cmd342, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('VOR-ILS control unit test selector - BD'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}},
{down = devCmds.Cmd343, up = devCmds.Cmd343, cockpit_device_id = devices.MAIN ,value_down = -1.0, value_up = 0.0, name = _('VOR-ILS control unit test selector - HG'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}},
-- VOR-ILS control unit kHz frequency selector
{pressed = devCmds.Cmd344, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('VOR-ILS control unit kHz frequency selector - Clockwise'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}},
{pressed = devCmds.Cmd344, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('VOR-ILS control unit kHz frequency selector - Counterclockwise'), category = {_('Right console'), _('Radionavigation'), _('VOR/ILS control box')}},

----------------------------------------------------------------
-- Omnibearing and VOR/ILS-TAC selector box

-- Omnibearing selector
{pressed = devCmds.Cmd345, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Omnibearing selector - Counterclockwise'), category = {_('Right console'), _('Radionavigation'), _('Omnibearing and VOR/ILS-TAC selector box')}},
{pressed = devCmds.Cmd345, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Omnibearing selector - Clockwise'), category = {_('Right console'), _('Radionavigation'), _('Omnibearing and VOR/ILS-TAC selector box')}},
-- VOR/ILS-OFF-TACAN selector
{down = devCmds.Cmd347, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('VOR/ILS-OFF-TACAN selector - Counterclockwise'), category = {_('Right console'), _('Radionavigation'), _('Omnibearing and VOR/ILS-TAC selector box')}},
{down = devCmds.Cmd347, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('VOR/ILS-OFF-TACAN selector - Clockwise'), category = {_('Right console'), _('Radionavigation'), _('Omnibearing and VOR/ILS-TAC selector box')}},

-- Heading selection knob
{pressed = devCmds.Cmd348, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Heading selection knob - Counterclockwise'), category = {_('Right console'), _('Radionavigation')}},
{pressed = devCmds.Cmd348, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Heading selection knob - Clockwise'), category = {_('Right console'), _('Radionavigation')}},

----------------------------------------------------------------
-- Oxygen system

-- Oxygen test button (T button)
{down = devCmds.Cmd360, up = devCmds.Cmd360, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Oxygen test button (T button)'), category = {_('Right console'), _('Oxygen system')}},
-- Pilot oxygen test button
{down = devCmds.Cmd361, up = devCmds.Cmd361, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Pilot oxygen test button'), category = {_('Right console'), _('Oxygen system')}},
-- "N-100%-EMG" mode selector switch
{down = devCmds.Cmd362, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('N-100%-EMG mode selector switch - NORMAL'), category = {_('Ejection seat'), _('Oxygen system')}},
{down = devCmds.Cmd362, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('N-100%-EMG mode selector switch - 100%'), category = {_('Ejection seat'), _('Oxygen system')}},
{down = devCmds.Cmd362, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('N-100%-EMG mode selector switch - EMG'), category = {_('Ejection seat'), _('Oxygen system')}},
-- Oxygen overpressure button
{down = devCmds.Cmd363, up = devCmds.Cmd363, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Oxygen overpressure button'), category = {_('Ejection seat'), _('Oxygen system')}},
-- Anti-g connection cover
{down = devCmds.Cmd364, up = devCmds.Cmd364, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Anti-g connection cover'), category = {_('Ejection seat'), _('Oxygen system')}},
-- Anti-g test button
{down = devCmds.Cmd365, up = devCmds.Cmd365, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Anti-g test button'), category = {_('Ejection seat'), _('Oxygen system')}},
-- Anti-g valve cock
{down = devCmds.Cmd366, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Anti-g valve cock - ON'), category = {_('Ejection seat'), _('Oxygen system')}},
{down = devCmds.Cmd366, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Anti-g valve cock - OFF'), category = {_('Ejection seat'), _('Oxygen system')}},

----------------------------------------------------------------
-- Air conditioning system

-- Emergency cold switch
{down = devCmds.Cmd375, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Emergency cold switch - NORMAL'), category = {_('Right console'), _('Air conditioning system')}},
{down = devCmds.Cmd375, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Emergency cold switch - EMG COLD'), category = {_('Right console'), _('Air conditioning system')}},
-- Master valve control switch
{down = devCmds.Cmd376, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Master valve control switch - ON'), category = {_('Right console'), _('Air conditioning system')}},
{down = devCmds.Cmd376, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Master valve control switch - OFF'), category = {_('Right console'), _('Air conditioning system')}},
-- Temperature control rheostat
{pressed = devCmds.Cmd378, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Temperature control rheostat - Clockwise'), category = {_('Right console'), _('Air conditioning system')}},
{pressed = devCmds.Cmd378, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Temperature control rheostat - Counterclockwise'), category = {_('Right console'), _('Air conditioning system')}},
-- Auto/Manual selector switch
{down = devCmds.Cmd379, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Auto/Manual selector switch - MANUAL'), category = {_('Right console'), _('Air conditioning system')}},
{down = devCmds.Cmd379, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Auto/Manual selector switch - AUTO'), category = {_('Right console'), _('Air conditioning system')}},
-- Hot/Cold selector switch
{down = devCmds.Cmd381, up = devCmds.Cmd381, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Hot/Cold selector switch - COLD'), category = {_('Right console'), _('Air conditioning system')}},
{down = devCmds.Cmd380, up = devCmds.Cmd380, cockpit_device_id = devices.MAIN ,value_down = -1.0, value_up = 0.0, name = _('Hot/Cold selector switch - HOT'), category = {_('Right console'), _('Air conditioning system')}},
-- Ram air switch guard
{down = devCmds.Cmd382, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Ram air switch guard - OPEN'), category = {_('Right console'), _('Air conditioning system')}},
{down = devCmds.Cmd382, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Ram air switch guard - CLOSE'), category = {_('Right console'), _('Air conditioning system')}},
-- Ram air switch
{down = devCmds.Cmd383, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Ram air switch - ON'), category = {_('Right console'), _('Air conditioning system')}},
{down = devCmds.Cmd383, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Ram air switch - OFF'), category = {_('Right console'), _('Air conditioning system')}},
-- Demist switch
{down = devCmds.Cmd384, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Demist switch - ON'), category = {_('Right console'), _('Air conditioning system')}},
{down = devCmds.Cmd384, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Demist switch - OFF'), category = {_('Right console'), _('Air conditioning system')}},

----------------------------------------------------------------
-- Circuit breaker box

-- Gyro control unit power supply
{down = devCmds.Cmd395, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Gyro control unit power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd395, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Gyro control unit power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- High-lift device servo unit power supply
{down = devCmds.Cmd396, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('High-lift device servo unit power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd396, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('High-lift device servo unit power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- Indicator and failure detector power supply
{down = devCmds.Cmd397, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Indicator and failure detector power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd397, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Indicator and failure detector power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- Inverter transfer unit power supply and control
{down = devCmds.Cmd398, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Inverter transfer unit power supply and control - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd398, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Inverter transfer unit power supply and control - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- Dual hydraulic pressure gauge power supply
{down = devCmds.Cmd399, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Dual hydraulic pressure gauge power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd399, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Dual hydraulic pressure gauge power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- Gun firing trigger power supply
{down = devCmds.Cmd400, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Gun firing trigger power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd400, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Gun firing trigger power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- LP cock power supply
{down = devCmds.Cmd401, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('LP cock power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd401, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('LP cock power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- Electro-pump relay power supply
{down = devCmds.Cmd402, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Electro-pump relay power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd402, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Electro-pump relay power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- Flight refuelling system power supply
{down = devCmds.Cmd403, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Flight refuelling system power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd403, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Flight refuelling system power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- Cabin pressurization system power supply
{down = devCmds.Cmd404, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Cabin pressurization system power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd404, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Cabin pressurization system power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- Inverter 28 V power supply
{down = devCmds.Cmd405, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Inverter 28 V power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd405, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Inverter 28 V power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- U/C normal operation power supply
{down = devCmds.Cmd406, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('U/C normal operation power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd406, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('U/C normal operation power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- V/UHF power supply
{down = devCmds.Cmd407, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('V/UHF power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd407, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('V/UHF power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- Starter and sequencing system power supply
{down = devCmds.Cmd408, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Starter and sequencing system power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd408, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Starter and sequencing system power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- Refuelling probe control power supply
{down = devCmds.Cmd409, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Refuelling probe control power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd409, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Refuelling probe control power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- Manual trim control power supply
{down = devCmds.Cmd410, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Manual trim control power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd410, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Manual trim control power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- Valve position repeater, control valve and ground mode power supply
{down = devCmds.Cmd411, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Valve position repeater, control valve and ground mode power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd411, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Valve position repeater, control valve and ground mode power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- Failure warning panel and master failure warning light power supply
{down = devCmds.Cmd412, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Failure warning panel and master failure warning light power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd412, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Failure warning panel and master failure warning light power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- Configuration indicator (U/C section) and U/C warning light power supply
{down = devCmds.Cmd413, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Configuration indicator (U/C section) and U/C warning light power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd413, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Configuration indicator (U/C section) and U/C warning light power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- IFF power supply
{down = devCmds.Cmd414, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('IFF power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd414, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('IFF power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
-- Emergency regulation system and control lever power supply
{down = devCmds.Cmd415, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Emergency regulation system and control lever power supply - OUT'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},
{down = devCmds.Cmd415, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Emergency regulation system and control lever power supply - IN'), category = {_('Right console'), _('Electrical system'), _('Circuit breaker box')}},

----------------------------------------------------------------
-- Ejection seat

-- Seat height adjustment control
{down = devCmds.Cmd431, up = devCmds.Cmd431, cockpit_device_id = devices.MAIN ,value_down = -1.0, value_up = 0.0, name = _('Seat height adjustment control - UP'), category = {_('Ejection seat')}},
{down = devCmds.Cmd430, up = devCmds.Cmd430, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Seat height adjustment control - DOWN'), category = {_('Ejection seat')}},
-- Face blind firing handle
{down = devCmds.Cmd432, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Face blind firing handle - PULL'), category = {_('Ejection seat')}},
{down = devCmds.Cmd432, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Face blind firing handle - PUSH'), category = {_('Ejection seat')}},
-- Alternative firing handle
{down = devCmds.Cmd434, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Alternative firing handle - PULL'), category = {_('Ejection seat')}},
{down = devCmds.Cmd434, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Alternative firing handle - PUSH'), category = {_('Ejection seat')}},
-- Ejection handle safety pin
{pressed = devCmds.Cmd650,cockpit_device_id = devices.MAIN,	value_pressed = 0.0,	name = _('Ejection Seat Handle Safety Pin - INSTALL'),	category = {_('Ejection seat')}},
{pressed = devCmds.Cmd650,cockpit_device_id = devices.MAIN,	value_pressed = 1.0,	name = _('Ejection Seat Handle Safety Pin - REMOVE'),	category = {_('Ejection seat')}},

----------------------------------------------------------------
-- Chaff and flares dispenser ALE 40 control unit

-- Chaff/flares selector switch
{down = devCmds.Cmd437, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Chaff/flares selector switch - FLARE'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}},
{down = devCmds.Cmd437, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Chaff/flares selector switch - BOTH'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}},
{down = devCmds.Cmd437, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Chaff/flares selector switch - CHAFF'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}},
-- Program selector switch
{down = devCmds.Cmd439, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Program selector switch - Clockwise'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}},
{down = devCmds.Cmd439, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Program selector switch - Counterclockwise'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}},
-- Chaff counter reset button
{down = devCmds.Cmd440, up = devCmds.Cmd440, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Chaff counter reset button'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}},
-- Flares counter reset button
{down = devCmds.Cmd441, up = devCmds.Cmd441, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Flares counter reset button'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}},
-- Emergency jettisoning switch
{down = devCmds.Cmd442, up = devCmds.Cmd442, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = -1.0, name = _('Emergency jettisoning switch'), category = {_('Front structure'), _('Chaff and flares dispenser ALE 40 control unit')}},

----------------------------------------------------------------
-- Radar detector switch
{down = devCmds.Cmd443, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Radar detector switch - ON'), category = {_('Right console'), _('Radar detector')}},
{down = devCmds.Cmd443, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Radar detector switch - OFF'), category = {_('Right console'), _('Radar detector')}},

-- Chaff and flares release button
{down = devCmds.Cmd444, up = devCmds.Cmd444, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Chaff/flares release button'), category = {_('Left wall'), _('Chaff and flares dispenser system')}},

----------------------------------------------------------------
-- Control stick

-- Gun firing trigger
{down = devCmds.Cmd631, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Gun firing trigger - UNFOLDED'), category = {_('Control Stick'), _('Armament system')}},
{down = devCmds.Cmd631, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Gun firing trigger - FOLDED'), category = {_('Control Stick'), _('Armament system')}},
-- PTT button
{down = devCmds.Cmd632, up = devCmds.Cmd632, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('PTT button'), category = {_('Control Stick'), _('Radio system')}},
-- Search light button
{down = devCmds.Cmd633, up = devCmds.Cmd633, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Search light button'), category = {_('Control Stick'), _('Exterior lighting')}},
-- Bombs, rockets, missiles and sight recorder button
{down = devCmds.Cmd634, up = devCmds.Cmd634, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Bombs, rockets, missiles and sight recorder button'), category = {_('Control Stick'), _('Armament system')}},
-- Gun firing safety
{down = devCmds.Cmd635, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Gun firing safety - OUT'), category = {_('Control Stick'), _('Armament system')}},
{down = devCmds.Cmd635, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Gun firing safety - IN'), category = {_('Control Stick'), _('Armament system')}},
-- Gun button
{down = devCmds.Cmd636, up = devCmds.Cmd636, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Gun button'), category = {_('Control Stick'), _('Armament system')}},
-- Sight recorder button
{down = devCmds.Cmd637, up = devCmds.Cmd637, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Sight recorder button'), category = {_('Control Stick'), _('Sight system and recording camera')}},

----------------------------------------------------------------
-- Throttle lever
-- ((C + M or SW) R button
{down = devCmds.Cmd640, up = devCmds.Cmd640, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('(C + M or SW) R button'), category = {_('Throttle lever'), _('Armament system')}},
-- Cannon 300-600m and missile lock/unlock button
{down = devCmds.Cmd641, up = devCmds.Cmd641, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Cannon 300-600m and missile lock/unlock button'), category = {_('Throttle lever'), _('Armament system')}},

----------------------------------------------------------------
-- Moved from Mirage-F1CE default lua

----------------------------------------------------------------
-- Armament control panel

-- Sight selector
{down = devCmds.Cmd580, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Sight selector - APP'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
{down = devCmds.Cmd580, cockpit_device_id  = devices.MAIN, value_down = 0.5, name = _('Sight selector - ON'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
{down = devCmds.Cmd580, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Sight selector - OFF'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
-- Bomb/Rocket selector
{down = devCmds.Cmd581, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Bomb/Rocket selector - OUTBD'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
{down = devCmds.Cmd581, cockpit_device_id  = devices.MAIN, value_down = 0.5, name = _('Bomb/Rocket selector - 1+2'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
{down = devCmds.Cmd581, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Bomb/Rocket selector - INBD'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
-- MATRA 550 missile switch
{down = devCmds.Cmd582, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('MATRA 550 or Sidewinder missile switch - ON'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
{down = devCmds.Cmd582, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('MATRA 550 or Sidewinder missile switch - OFF'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
-- Fore/Aft selector switch
{down = devCmds.Cmd583, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Fore/Aft selector switch - FORE'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
{down = devCmds.Cmd583, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Fore/Aft selector switch - AFT'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
-- Auto/Manual firing selector switch
{down = devCmds.Cmd584, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Auto/Manual firing selector switch - AUTO'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
{down = devCmds.Cmd584, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Auto/Manual firing selector switch - MAN'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
-- Single/Salvo selector
{down = devCmds.Cmd585, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Single/Salvo selector - SINGLE'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
{down = devCmds.Cmd585, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Single/Salvo selector - SALVO'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
-- Instantaneous/Delay/Safe selector switch
{down = devCmds.Cmd586, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Instantaneous/Delay/Safe selector switch - INST'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
{down = devCmds.Cmd586, cockpit_device_id  = devices.MAIN, value_down = 0.5, name = _('Instantaneous/Delay/Safe selector switch - DLY'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
{down = devCmds.Cmd586, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Instantaneous/Delay/Safe selector switch - SAFE'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},

-- Armament control panel - lighted pushbutton selectors

-- Left MATRA R550 or Sidewinder missile pushbutton
{down = devCmds.Cmd587, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Left MATRA R550 or Sidewinder missile pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
-- Left or fuselage MATRA R530 missile pushbutton
{down = devCmds.Cmd588, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Left or fuselage MATRA R530 missile pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
-- Air-to-Air guns pushbutton
{down = devCmds.Cmd589, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Air-to-Air guns pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
-- Wing bombs pushbutton
{down = devCmds.Cmd590, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Wing bombs pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
-- Right MATRA R550 or Sidewinder missile pushbutton
{down = devCmds.Cmd591, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Right MATRA R550 or Sidewinder missile pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
-- Right MATRA R530 missile pushbutton
{down = devCmds.Cmd592, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Right MATRA R530 missile pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
-- Air-to-Ground guns or rockets pushbutton
{down = devCmds.Cmd593, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Air-to-Ground guns or rockets pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
-- Fuselage bombs pushbutton
{down = devCmds.Cmd594, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Fuselage bombs pushbutton'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},

-- Armament control panel - continued

-- R 530 Missile Normal/Altitude difference selector switch
{down = devCmds.Cmd595, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('R 530 Missile Normal/Altitude difference selector switch - SNAP'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
{down = devCmds.Cmd595, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('R 530 Missile Normal/Altitude difference selector switch - NORM'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
-- Normal/Jammer pursuit switch, commented as being 'No function'
--{down = devCmds.Cmd596, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Normal/Jammer pursuit switch (No function) - JP'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
--{down = devCmds.Cmd596, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Normal/Jammer pursuit switch (No function) - N'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},
-- Armament panel lights test
{down = devCmds.Cmd597, up = devCmds.Cmd597, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Armament panel lights test'), category = {_('Right console'), _('Armament system'), _('Armament control panel')}},

----------------------------------------------------------------
-- Armament control panel - radar controls

-- Radar selector
{down = devCmds.Cmd613, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Radar selector - TX'), category = {_('Right console'), _('Radar'), _('Armament control panel')}},
{down = devCmds.Cmd613, cockpit_device_id  = devices.MAIN, value_down = 0.5, name = _('Radar selector - SBY'), category = {_('Right console'), _('Radar'), _('Armament control panel')}},
{down = devCmds.Cmd613, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Radar selector - OFF'), category = {_('Right console'), _('Radar'), _('Armament control panel')}},
-- Emergency transmission button
{down = devCmds.Cmd614, up = devCmds.Cmd614, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Radar emergency transmission button'), category = {_('Right console'), _('Radar'), _('Armament control panel')}},
-- Radar 4 lines/1 line scan switch
{down = devCmds.Cmd615, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Radar 4 lines/1 line scan switch - 4L'), category = {_('Right console'), _('Radar'), _('Armament control panel')}},
{down = devCmds.Cmd615, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Radar 4 lines/1 line scan switch - 1L'), category = {_('Right console'), _('Radar'), _('Armament control panel')}},

----------------------------------------------------------------
-- Radar indicator scope control box

-- Indicator lights brightness
{pressed = devCmds.Cmd619, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Indicator lights brightness - Increase'), category = {_('Right console'), _('Radar indicator scope control box')}},
{pressed = devCmds.Cmd619, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Indicator lights brightness - Decrease'), category = {_('Right console'), _('Radar indicator scope control box')}},
-- Strobe brightness
{pressed = devCmds.Cmd621, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Strobe brightness - Increase'), category = {_('Right console'), _('Radar indicator scope control box')}},
{pressed = devCmds.Cmd621, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Strobe brightness - Decrease'), category = {_('Right console'), _('Radar indicator scope control box')}},
-- Distance markers brightness
{pressed = devCmds.Cmd623, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Distance markers brightness - Increase'), category = {_('Right console'), _('Radar indicator scope control box')}},
{pressed = devCmds.Cmd623, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Distance markers brightness - Decrease'), category = {_('Right console'), _('Radar indicator scope control box')}},
-- Horizon and radial velocity marker brightness
{pressed = devCmds.Cmd625, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Horizon and radial velocity marker brightness - Increase'), category = {_('Right console'), _('Radar indicator scope control box')}},
{pressed = devCmds.Cmd625, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Horizon and radial velocity marker brightness - Decrease'), category = {_('Right console'), _('Radar indicator scope control box')}},
-- Horizon symbol vertical position
{pressed = devCmds.Cmd627, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Horizon symbol vertical position - Increase'), category = {_('Right console'), _('Radar indicator scope control box')}},
{pressed = devCmds.Cmd627, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Horizon symbol vertical position - Decrease'), category = {_('Right console'), _('Radar indicator scope control box')}},

----------------------------------------------------------------
-- Armament master switch

-- Armament master switch guard
{down = devCmds.Cmd143, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Armament master switch guard - OPEN'), category = {_('Left console'), _('Armament system')}},
{down = devCmds.Cmd143, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Armament master switch guard - CLOSE'), category = {_('Left console'), _('Armament system')}},
-- Armament master switch
{down = devCmds.Cmd144, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Armament master switch - TEST'), category = {_('Left console'), _('Armament system')}},
{down = devCmds.Cmd144, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Armament master switch - ON'), category = {_('Left console'), _('Armament system')}},
{down = devCmds.Cmd144, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Armament master switch - OFF'), category = {_('Left console'), _('Armament system')}},

----------------------------------------------------------------
-- ANTENNA-GYRO switch
{down = devCmds.Cmd453, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('ANTENNA-GYRO switch - GYRO'), category = {_('Left console'), _('Armament system')}},
{down = devCmds.Cmd453, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('ANTENNA-GYRO switch - ANTENNA'), category = {_('Left console'), _('Armament system')}},

----------------------------------------------------------------
-- Left wall armament switches

-- (C + M or SW) R deselection switch
{down = devCmds.Cmd475, up = devCmds.Cmd475, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('(C + M or SW) R deselection switch'), category = {_('Left wall'), _('Armament system')}},
-- Telemeter/zone scanning switch
{down = devCmds.Cmd476, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Telemeter/zone scanning switch - TEL'), category = {_('Left wall'), _('Armament system')}},
{down = devCmds.Cmd476, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Telemeter/zone scanning switch - CENTER'), category = {_('Left wall'), _('Armament system')}},
{down = devCmds.Cmd476, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Telemeter/zone scanning switch - BPZ'), category = {_('Left wall'), _('Armament system')}},

----------------------------------------------------------------
-- Accelerometer reset button and rheostat
{down = devCmds.Cmd477, up = devCmds.Cmd477, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Accelerometer reset button and rheostat'), category = {_('Front structure'), _('Systems')}},

----------------------------------------------------------------
-- Sight system and recording camera

-- AUTO/MAN intensity selector switch
{down = devCmds.Cmd480, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('AUTO/MAN intensity selector switch - MAN'), category = {_('Central front panel'), _('Sight system and recording camera')}},
{down = devCmds.Cmd480, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('AUTO/MAN intensity selector switch - AUTO'), category = {_('Central front panel'), _('Sight system and recording camera')}},
-- Lighting selector switch
{down = devCmds.Cmd481, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Lighting selector switch - E'), category = {_('Central front panel'), _('Sight system and recording camera')}},
{down = devCmds.Cmd481, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('Lighting selector switch - N'), category = {_('Central front panel'), _('Sight system and recording camera')}},
{down = devCmds.Cmd481, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Lighting selector switch - O'), category = {_('Central front panel'), _('Sight system and recording camera')}},
-- Manual gravity drop selection thumbwheel
{pressed = devCmds.Cmd482, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Manual gravity drop selection thumbwheel - Decrease'), category = {_('Central front panel'), _('Sight system and recording camera')}},
{pressed = devCmds.Cmd482, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Manual gravity drop selection thumbwheel - Increase'), category = {_('Central front panel'), _('Sight system and recording camera')}},
-- Fixed Reticle intensity rheostat
{pressed = devCmds.Cmd484, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Fixed Reticle intensity rheostat - Clockwise/Increase'), category = {_('Central front panel'), _('Sight system and recording camera')}},
{pressed = devCmds.Cmd484, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Fixed Reticle intensity rheostat - Counterclockwise/Decrease'), category = {_('Central front panel'), _('Sight system and recording camera')}},
-- Moving and Target Reticles intensity rheostat
{pressed = devCmds.Cmd486, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Moving and Target Reticles intensity rheostat - Clockwise/Increase'), category = {_('Central front panel'), _('Sight system and recording camera')}},
{pressed = devCmds.Cmd486, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Moving and Target Reticles intensity rheostat - Counterclockwise/Decrease'), category = {_('Central front panel'), _('Sight system and recording camera')}},
-- Attitude Reticle intensity rheostat
{pressed = devCmds.Cmd488, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Attitude Reticle intensity rheostat - Clockwise/Increase'), category = {_('Central front panel'), _('Sight system and recording camera')}},
{pressed = devCmds.Cmd488, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Attitude Reticle intensity rheostat - Counterclockwise/Decrease'), category = {_('Central front panel'), _('Sight system and recording camera')}},
-- Sight system test button
{down = devCmds.Cmd489, up = devCmds.Cmd489, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Sight system test button'), category = {_('Central front panel'), _('Sight system and recording camera')}},
-- Exposure time repeater
{pressed = devCmds.Cmd491, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Exposure time repeater - Clockwise'), category = {_('Central front panel'), _('Sight system and recording camera')}},
{pressed = devCmds.Cmd491, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Exposure time repeater - Counterclockwise'), category = {_('Central front panel'), _('Sight system and recording camera')}},
-- Overrun select thumbwheel
{pressed = devCmds.Cmd493, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Overrun select thumbwheel - Increase'), category = {_('Central front panel'), _('Sight system and recording camera')}},
{pressed = devCmds.Cmd493, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Overrun select thumbwheel - Decrease'), category = {_('Central front panel'), _('Sight system and recording camera')}},
-- 5/16 PPS framing rate selector switch
{down = devCmds.Cmd494, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('5/16 PPS framing rate selector switch - 16'), category = {_('Central front panel'), _('Sight system and recording camera')}},
{down = devCmds.Cmd494, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('5/16 PPS framing rate selector switch - 5'), category = {_('Central front panel'), _('Sight system and recording camera')}},
-- Sight camera test switch
{down = devCmds.Cmd495, up = devCmds.Cmd495, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Sight camera test switch - TEST'), category = {_('Central front panel'), _('Sight system and recording camera')}},

----------------------------------------------------------------
-- Radar

-- Radar test buttton
{down = devCmds.Cmd505, up = devCmds.Cmd505, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Radar test buttton'), category = {_('Central front panel'), _('Radar')}},
-- Scope intensity adjustment
{pressed = devCmds.Cmd507, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Scope intensity adjustment - Clockwise/Increase'), category = {_('Central front panel'), _('Radar')}},
{pressed = devCmds.Cmd507, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Scope intensity adjustment - Counterclockwise/Decrease'), category = {_('Central front panel'), _('Radar')}},
-- Radar function selection
{down = devCmds.Cmd509, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Radar function selection - Clockwise/Increase'), category = {_('Central front panel'), _('Radar')}},
{down = devCmds.Cmd509, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Radar function selection - Counterclockwise/Decrease'), category = {_('Central front panel'), _('Radar')}},
-- Storage adjustment
{pressed = devCmds.Cmd511, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Storage adjustment - Clockwise/Increase'), category = {_('Central front panel'), _('Radar')}},
{pressed = devCmds.Cmd511, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Storage adjustment - Counterclockwise/Decrease'), category = {_('Central front panel'), _('Radar')}},
-- Scope erasing
{down = devCmds.Cmd512, up = devCmds.Cmd512, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Scope erasing'), category = {_('Central front panel'), _('Radar')}},
-- Polaroid screen adjustment
{pressed = devCmds.Cmd514, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Polaroid screen adjustment - Clockwise'), category = {_('Central front panel'), _('Radar')}},
{pressed = devCmds.Cmd514, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Polaroid screen adjustment - Counterclockwise'), category = {_('Central front panel'), _('Radar')}},

-- Radar cover
{down = devCmds.Cmd629, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Radar cover remove toggle'), category = {_('Central front panel')}},

----------------------------------------------------------------
-- IFF

-- Mode 1 coding tens selector
{down = devCmds.Cmd521, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode 1 coding tens selector - Increase'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd521, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode 1 coding tens selector - Decrease'), category = {_('Central front panel'), _('IFF')}},
-- Mode 1 coding units selector
{down = devCmds.Cmd523, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode 1 coding units selector - Increase'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd523, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode 1 coding units selector - Decrease'), category = {_('Central front panel'), _('IFF')}},
-- Mode 3A coding thousands selector
{down = devCmds.Cmd525, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode 3A coding thousands selector - Increase'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd525, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode 3A coding thousands selector - Decrease'), category = {_('Central front panel'), _('IFF')}},
-- Mode 3A coding hundreds selector
{down = devCmds.Cmd527, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode 3A coding hundreds selector - Increase'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd527, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode 3A coding hundreds selector - Decrease'), category = {_('Central front panel'), _('IFF')}},
-- Mode 3A coding tens selector
{down = devCmds.Cmd529, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode 3A coding tens selector - Increase'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd529, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode 3A coding tens selector - Decrease'), category = {_('Central front panel'), _('IFF')}},
-- Mode 3A coding units selector
{down = devCmds.Cmd531, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode 3A coding units selector - Increase'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd531, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode 3A coding units selector - Decrease'), category = {_('Central front panel'), _('IFF')}},
-- Position identification selector
{down = devCmds.Cmd533, up = devCmds.Cmd533, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Position identification selector - IDENT'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd532, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Position identification selector - OFF'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd532, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Position identification selector - MIC'), category = {_('Central front panel'), _('IFF')}},
-- IFF test button
{down = devCmds.Cmd534, up = devCmds.Cmd534, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('IFF test button'), category = {_('Central front panel'), _('IFF')}},
-- Mode 4 selector switch
{down = devCmds.Cmd536, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode 4 selector switch - Clockwise'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd536, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode 4 selector switch - Counterclockwise'), category = {_('Central front panel'), _('IFF')}},
-- IFF monitoring light
{down = devCmds.Cmd537, up = devCmds.Cmd537, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('IFF monitoring light - PUSH'), category = {_('Central front panel'), _('IFF')}},
{pressed = devCmds.Cmd539, cockpit_device_id = devices.MAIN, value_pressed = 1.0, name = _('IFF monitoring light - Increase'), category = {_('Central front panel'), _('IFF')}},
{pressed = devCmds.Cmd539, cockpit_device_id = devices.MAIN, value_pressed = -1.0, name = _('IFF monitoring light - Decrease'), category = {_('Central front panel'), _('IFF')}},
-- Function selector switch
{down = devCmds.Cmd541, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Function selector switch - Clockwise'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd541, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Function selector switch - Counterclockwise'), category = {_('Central front panel'), _('IFF')}},
-- IFF mode 4 switch
{down = devCmds.Cmd542, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('IFF mode 4 switch - ON'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd542, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('IFF mode 4 switch - OFF'), category = {_('Central front panel'), _('IFF')}},
-- IFF fault light
{down = devCmds.Cmd543, up = devCmds.Cmd543, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('IFF fault light - PUSH'), category = {_('Central front panel'), _('IFF')}},
{pressed = devCmds.Cmd545, cockpit_device_id = devices.MAIN, value_pressed = 1.0, name = _('IFF fault light - Increase'), category = {_('Central front panel'), _('IFF')}},
{pressed = devCmds.Cmd545, cockpit_device_id = devices.MAIN, value_pressed = -1.0, name = _('IFF fault light - Decrease'), category = {_('Central front panel'), _('IFF')}},
-- AUDIO-LIGHT switch
{down = devCmds.Cmd546, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('AUDIO-LIGHT switch - ON'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd546, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('AUDIO-LIGHT switch - OFF'), category = {_('Central front panel'), _('IFF')}},
-- M-1 mode switch
{down = devCmds.Cmd547, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('M-1 mode switch - ON'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd547, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('M-1 mode switch - OFF'), category = {_('Central front panel'), _('IFF')}},
-- M-2 mode switch
{down = devCmds.Cmd548, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('M-2 mode switch - ON'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd548, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('M-2 mode switch - OFF'), category = {_('Central front panel'), _('IFF')}},
-- M-3 mode switch
{down = devCmds.Cmd549, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('M-3 mode switch - ON'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd549, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('M-3 mode switch - OFF'), category = {_('Central front panel'), _('IFF')}},
-- M-4 mode switch
{down = devCmds.Cmd550, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('M-4 mode switch - ON'), category = {_('Central front panel'), _('IFF')}},
{down = devCmds.Cmd550, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('M-4 mode switch - OFF'), category = {_('Central front panel'), _('IFF')}},

})

-- axes
join(res.axisCommands,{

--{combos = defaultDeviceAssignmentFor("roll"), 	action = iCommandPlaneRoll, 				name = _('Roll')},
{combos = defaultDeviceAssignmentFor("roll"), 		action = GLOB_CMD_F1CMN_AXIS_STICK_ROLL, 	name = _('Roll')},
--{combos = defaultDeviceAssignmentFor("pitch"), 	action = iCommandPlanePitch, 				name = _('Pitch')},
{combos = defaultDeviceAssignmentFor("pitch"), 		action = GLOB_CMD_F1CMN_AXIS_STICK_PITCH,	name = _('Pitch')},
--{combos = defaultDeviceAssignmentFor("rudder"), 	action = iCommandPlaneRudder, 				name = _('Rudder')},
{combos = defaultDeviceAssignmentFor("rudder"), 	action = GLOB_CMD_F1CMN_AXIS_RUDDER, 		name = _('Rudder')},
{combos = defaultDeviceAssignmentFor("thrust"), 	action = iCommandPlaneThrustCommon, 		name = _('Thrust')},

{action = iCommandLeftWheelBrake,        name = _('Wheel Brake Left')},
{action = iCommandRightWheelBrake,       name = _('Wheel Brake Right')},
{action = iCommandWheelBrake,       	 name = _('Wheel Brakes')},

-- Radar control stick bearing control (horizontal axis)
{action = devCmds.Cmd105, cockpit_device_id = devices.MAIN,	name = _('Radar control stick bearing control'), category = {_('Left console'), _('Radar control stick')}},
-- Radar control stick range/velocity control (vertical axis)
{action = devCmds.Cmd108, cockpit_device_id = devices.MAIN,	name = _('Radar control stick range/velocity control'), category = {_('Left console'), _('Radar control stick')}},
-- Radar control stick gain control wheel
{action = devCmds.Cmd113, cockpit_device_id = devices.MAIN,	name = _('Radar control stick gain control wheel'), category = {_('Left console'), _('Radar control stick')}},

})

return res
