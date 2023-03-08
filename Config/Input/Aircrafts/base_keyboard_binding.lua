local base = external_profile("Config/Input/Aircrafts/common_keyboard_binding.lua")
join(base.keyCommands,{

-- General (Gameplay)
{combos = {{key = 'U'}},							down = iCommandPlaneShipTakeOff,			name = _('Ship Take Off Position'),		category = _('General') , features = {"shiptakeoff"}},
{combos = {{key = 'P', reformers = {'RShift'}}},	down = iCommandCockpitShowPilotOnOff,		name = _('Show Pilot Body'),			category = _('General')},

-- Flight Control
{combos = {{key = 'Up'}},		down = iCommandPlaneUpStart,			up = iCommandPlaneUpStop,			name = _('Aircraft Pitch Down'),	category = _('Flight Control')},
{combos = {{key = 'Down'}},		down = iCommandPlaneDownStart,			up = iCommandPlaneDownStop,			name = _('Aircraft Pitch Up'),		category = _('Flight Control')},
{combos = {{key = 'Left'}},		down = iCommandPlaneLeftStart,			up = iCommandPlaneLeftStop,			name = _('Aircraft Bank Left'),		category = _('Flight Control')},
{combos = {{key = 'Right'}},	down = iCommandPlaneRightStart,			up = iCommandPlaneRightStop,		name = _('Aircraft Bank Right'),	category = _('Flight Control')},
{combos = {{key = 'Z'}},		down = iCommandPlaneLeftRudderStart,	up = iCommandPlaneLeftRudderStop,	name = _('Aircraft Rudder Left'),	category = _('Flight Control')},
{combos = {{key = 'X'}},		down = iCommandPlaneRightRudderStart,	up = iCommandPlaneRightRudderStop,	name = _('Aircraft Rudder Right'),	category = _('Flight Control')},

{combos = {{key = '.', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimUp,			up = iCommandPlaneTrimStop, name = _('Trim: Nose Up'),			category = _('Flight Control')},
{combos = {{key = ';', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimDown,		up = iCommandPlaneTrimStop, name = _('Trim: Nose Down'),		category = _('Flight Control')},
{combos = {{key = ',', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimLeft,		up = iCommandPlaneTrimStop, name = _('Trim: Left Wing Down'),	category = _('Flight Control')},
{combos = {{key = '/', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimRight,		up = iCommandPlaneTrimStop, name = _('Trim: Right Wing Down'),	category = _('Flight Control')},
{combos = {{key = 'Z', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimLeftRudder,	up = iCommandPlaneTrimStop, name = _('Trim: Rudder Left'),		category = _('Flight Control')},
{combos = {{key = 'X', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimRightRudder,	up = iCommandPlaneTrimStop, name = _('Trim: Rudder Right'),		category = _('Flight Control')},

{combos = {{key = 'Num+'}}, 						pressed = iCommandThrottleIncrease,		up = iCommandThrottleStop,  name = _('Throttle Up'),		category = _('Flight Control')},
{combos = {{key = 'Num-'}}, 						pressed = iCommandThrottleDecrease,		up = iCommandThrottleStop,  name = _('Throttle Down'),		category = _('Flight Control')},
{combos = {{key = 'Num+', reformers = {'RAlt'}}}, 	pressed = iCommandThrottle1Increase,	up = iCommandThrottle1Stop, name = _('Throttle Left Up'),	category = _('Flight Control')},
{combos = {{key = 'Num-', reformers = {'RAlt'}}}, 	pressed = iCommandThrottle1Decrease,	up = iCommandThrottle1Stop, name = _('Throttle Left Down'), category = _('Flight Control')},
{combos = {{key = 'Num+', reformers = {'RShift'}}}, pressed = iCommandThrottle2Increase,	up = iCommandThrottle2Stop, name = _('Throttle Right Up'),	category = _('Flight Control')},
{combos = {{key = 'Num-', reformers = {'RShift'}}}, pressed = iCommandThrottle2Decrease,	up = iCommandThrottle2Stop, name = _('Throttle Right Down'), category = _('Flight Control')},

{combos = {{key = 'PageUp'}},							down = iCommandPlaneAUTIncreaseRegime,		name = _('Throttle Step Up'),			category = _('Flight Control')},
{combos = {{key = 'PageDown'}},							down = iCommandPlaneAUTDecreaseRegime,		name = _('Throttle Step Down'),			category = _('Flight Control')},
{combos = {{key = 'PageUp', reformers = {'RAlt'}}},		down = iCommandPlaneAUTIncreaseRegimeLeft,	name = _('Throttle Step Up Left'),		category = _('Flight Control')},
{combos = {{key = 'PageDown', reformers = {'RAlt'}}},	down = iCommandPlaneAUTDecreaseRegimeLeft,	name = _('Throttle Step Down Left'),	category = _('Flight Control')},
{combos = {{key = 'PageUp', reformers = {'RShift'}}},	down = iCommandPlaneAUTIncreaseRegimeRight, name = _('Throttle Step Up Right'),		category = _('Flight Control')},
{combos = {{key = 'PageDown', reformers = {'RShift'}}}, down = iCommandPlaneAUTDecreaseRegimeRight, name = _('Throttle Step Down Right'),	category = _('Flight Control')},

-- Systems
{combos = {{key = 'L', reformers = {'RShift'}}},	down = iCommandPowerOnOff,					name = _('Electric Power Switch'),					category = _('Systems')},
{combos = {{key = 'B'}},							down = iCommandPlaneAirBrake,				name = _('Airbrake'),								category = _('Systems') , features = {"airbrake"}},
{combos = {{key = 'B', reformers = {'LShift'}}},	down = iCommandPlaneAirBrakeOn,				name = _('Airbrake On'),							category = _('Systems') , features = {"airbrake"}},
{combos = {{key = 'B', reformers = {'LCtrl'}}},		down = iCommandPlaneAirBrakeOff,			name = _('Airbrake Off'),							category = _('Systems') , features = {"airbrake"}},
{combos = {{key = 'T'}},							down = iCommandPlaneWingtipSmokeOnOff,		name = _('Smoke'),									category = _('Systems')},
{combos = {{key = 'L'}},							down = iCommandPlaneCockpitIllumination,	name = _('Illumination Cockpit'),					category = _('Systems')},
{combos = {{key = 'L', reformers = {'RCtrl'}}},		down = iCommandPlaneLightsOnOff,			name = _('Navigation lights'),						category = _('Systems')},
{combos = {{key = 'L', reformers = {'RAlt'}}},		down = iCommandPlaneHeadLightOnOff,			name = _('Gear Light Near/Far/Off'),				category = _('Systems')},
{combos = {{key = 'F'}},							down = iCommandPlaneFlaps,					name = _('Flaps Up/Down'),							category = _('Systems')},
{combos = {{key = 'F', reformers = {'LShift'}}},	down = iCommandPlaneFlapsOn,				name = _('Flaps Landing Position'),					category = _('Systems')},
{combos = {{key = 'F', reformers = {'LCtrl'}}},		down = iCommandPlaneFlapsOff,				name = _('Flaps Up'),								category = _('Systems')},
{combos = {{key = 'G'}},							down = iCommandPlaneGear,					name = _('Landing Gear Up/Down'),					category = _('Systems')},
{combos = {{key = 'G', reformers = {'LCtrl'}}},		down = iCommandPlaneGearUp,					name = _('Landing Gear Up'),						category = _('Systems')},
{combos = {{key = 'G', reformers = {'LShift'}}},	down = iCommandPlaneGearDown,				name = _('Landing Gear Down'),						category = _('Systems')},
{combos = {{key = 'W'}},							down = iCommandPlaneWheelBrakeOn, up = iCommandPlaneWheelBrakeOff, name = _('Wheel Brake On'),	category = _('Systems')},
{combos = {{key = 'C', reformers = {'LCtrl'}}},		down = iCommandPlaneFonar,					name = _('Canopy Open/Close'),						category = _('Systems')},
{combos = {{key = 'P'}},							down = iCommandPlaneParachute,				name = _('Dragging Chute'),							category = _('Systems') , features = {"dragchute"}},
{combos = {{key = 'N', reformers = {'RShift'}}},	down = iCommandPlaneResetMasterWarning,		name = _('Audible Warning Reset'),					category = _('Systems')},
{combos = {{key = 'W', reformers = {'LCtrl'}}},		down = iCommandPlaneJettisonWeapons,up = iCommandPlaneJettisonWeaponsUp, name = _('Weapons Jettison'), category = _('Systems')},
{combos = {{key = 'E', reformers = {'LCtrl'}}},		down = iCommandPlaneEject,					name = _('Eject (3 times)'),						category = _('Systems')},
{combos = {{key = 'C', reformers = {'RShift'}}},	down = iCommandFlightClockReset,			name = _('Flight Clock Start/Stop/Reset'),			category = _('Systems') , features = {"flightclock"}},
{													down = iCommandClockElapsedTimeReset,		name = _('Elapsed Time Clock Start/Stop/Reset'),	category = _('Systems') , features = {"flightclock"}},
{combos = {{key = 'Home', reformers = {'RShift'}}}, down = iCommandEnginesStart,				name = _('Engines Start'),							category = _('Systems')},
{combos = {{key = 'End', reformers = {'RShift'}}},	down = iCommandEnginesStop,					name = _('Engines Stop'),							category = _('Systems')},
{combos = {{key = 'Home', reformers = {'RAlt'}}},	down = iCommandLeftEngineStart,				name = _('Engine Left Start'),						category = _('Systems') , features = {"TwinEngineAircraft"}},
{combos = {{key = 'End', reformers = {'RAlt'}}},	down = iCommandLeftEngineStop,				name = _('Engine Left Stop'),						category = _('Systems') , features = {"TwinEngineAircraft"}},
{combos = {{key = 'Home', reformers = {'RCtrl'}}},	down = iCommandRightEngineStart,			name = _('Engine Right Start'),						category = _('Systems') , features = {"TwinEngineAircraft"}},
{combos = {{key = 'End', reformers = {'RCtrl'}}},	down = iCommandRightEngineStop,				name = _('Engine Right Stop'),						category = _('Systems') , features = {"TwinEngineAircraft"}},
{combos = {{key = 'H', reformers = {'RCtrl'}}},		down = iCommandBrightnessILS,				name = _('HUD Color'),								category = _('Systems') , features = {"HUDcolor"}},
{combos = {{key = 'H', reformers = {'RCtrl','RShift'}}}, pressed = iCommandHUDBrightnessUp,		name = _('HUD Brightness up'),						category = _('Systems') , features = {"HUDbrightness"}},
{combos = {{key = 'H', reformers = {'RShift','RAlt'}}}, pressed = iCommandHUDBrightnessDown,	name = _('HUD Brightness down'),					category = _('Systems') , features = {"HUDbrightness"}},
{combos = {{key = 'R'}},							down = iCommandPlaneFuelOn, up = iCommandPlaneFuelOff, name = _('Fuel Dump'),					category = _('Systems') , features = {"fueldump"}},

{combos = {{key = '=', reformers = {'RShift'}}}, pressed = iCommandAltimeterPressureIncrease,	up = iCommandAltimeterPressureStop, name = _('Altimeter Pressure Increase'), category = _('Systems')},
{combos = {{key = '-', reformers = {'RShift'}}}, pressed = iCommandAltimeterPressureDecrease, up = iCommandAltimeterPressureStop, name = _('Altimeter Pressure Decrease'), category = _('Systems')},

-- Modes
{combos = {{key = '`', reformers = {'LCtrl'}}},		down = iCommandPlaneChangeTarget,			name = _('Next Waypoint, Airfield Or Target'),		category = _('Modes')},
{combos = {{key = '`', reformers = {'LShift'}}},	down = iCommandPlaneUFC_STEER_DOWN,			name = _('Previous Waypoint, Airfield Or Target'),	category = _('Modes')},
{combos = {{key = '1'}},							down = iCommandPlaneModeNAV,				name = _('(1) Navigation Modes'),					category = _('Modes')},

-- Weapons
{combos = {{key = 'Space'}},					down = iCommandPlaneFire,	up = iCommandPlaneFireOff,	name = _('Weapon Fire'),		category = _('Weapons')},
{combos = {{key = 'D'}},						down = iCommandPlaneChangeWeapon,						name = _('Weapon Change'),		category = _('Weapons')},
{combos = {{key = 'C'}},						down = iCommandPlaneModeCannon,							name = _('Cannon'),				category = _('Weapons')},
{combos = {{key = 'W', reformers = {'LAlt'}}},	down = iCommandPlaneLaunchPermissionOverride,			name = _('Launch Permission Override'), category = _('Weapons') , features = {"LaunchPermissionOverride"}},

-- Countermeasures
{combos = {{key = 'Q', reformers = {'LShift'}}},	down = iCommandPlaneDropSnar,			name = _('Countermeasures Continuously Dispense'),					category = _('Countermeasures') , features = {"Countermeasures"}},
{combos = {{key = 'Q'}},							down = iCommandPlaneDropSnarOnce, up = iCommandPlaneDropSnarOnceOff, name = _('Countermeasures Release'),	category = _('Countermeasures') , features = {"Countermeasures"}},
{combos = {{key = 'Delete'}},						down = iCommandPlaneDropFlareOnce,		name = _('Countermeasures Flares Dispense'),						category = _('Countermeasures') , features = {"Countermeasures"}},
{combos = {{key = 'Insert'}},						down = iCommandPlaneDropChaffOnce,		name = _('Countermeasures Chaff Dispense'),							category = _('Countermeasures') , features = {"Countermeasures"}},
{combos = {{key = 'E'}},							down = iCommandActiveJamming,			name = _('ECM'),													category = _('Countermeasures') , features = {"ECM"}},

-- Communications
{combos = {{key = 'I', reformers = {'LWin'}}},											down = iCommandAWACSTankerBearing,	name = _('Request AWACS Available Tanker'),	category = _('Communications')},
{combos = {{key = '\\', reformers = {'RShift'}}, {key = 'M', reformers = {'RShift'}}},	down = iCommandToggleReceiveMode,	name = _('Receive Mode'),					category = _('Communications')},

-- Cockpit Camera Motion (Передвижение камеры в кабине)
{combos = {{key = 'N', reformers = {'RAlt'}}},	down = iCommandViewLeftMirrorOn ,	up = iCommandViewLeftMirrorOff ,	name = _('Mirror Left On'),		category = _('View Cockpit') , features = {"Mirrors"}},
{combos = {{key = 'M', reformers = {'RAlt'}}},	down = iCommandViewRightMirrorOn,	up = iCommandViewRightMirrorOff,	name = _('Mirror Right On'),	category = _('View Cockpit') , features = {"Mirrors"}},
{combos = {{key = 'M' }},						down = iCommandToggleMirrors,											name = _('Toggle Mirrors'),		category = _('View Cockpit') , features = {"Mirrors"}},

-- Auto Lock On 
{combos = {{key = 'F5', reformers = {'RAlt'}}},		down = iCommandAutoLockOnNearestAircraft,		name = _('Auto lock on nearest aircraft'),			category = _('Simplifications')},
{combos = {{key = 'F6', reformers = {'RAlt'}}},		down = iCommandAutoLockOnCenterAircraft,		name = _('Auto lock on center aircraft'),			category = _('Simplifications')},
{combos = {{key = 'F7', reformers = {'RAlt'}}},		down = iCommandAutoLockOnNextAircraft,			name = _('Auto lock on next aircraft'),				category = _('Simplifications')},
{combos = {{key = 'F8', reformers = {'RAlt'}}},		down = iCommandAutoLockOnPreviousAircraft,		name = _('Auto lock on previous aircraft'),			category = _('Simplifications')},
{combos = {{key = 'F9', reformers = {'RAlt'}}},		down = iCommandAutoLockOnNearestSurfaceTarget,	name = _('Auto lock on nearest surface target'),	category = _('Simplifications')},
{combos = {{key = 'F10', reformers = {'RAlt'}}},	down = iCommandAutoLockOnCenterSurfaceTarget,	name = _('Auto lock on center surface target'),		category = _('Simplifications')},
{combos = {{key = 'F11', reformers = {'RAlt'}}},	down = iCommandAutoLockOnNextSurfaceTarget,		name = _('Auto lock on next surface target'),		category = _('Simplifications')},
{combos = {{key = 'F12', reformers = {'RAlt'}}},	down = iCommandAutoLockOnPreviousSurfaceTarget, name = _('Auto lock on previous surface target'),	category = _('Simplifications')},

})
return base