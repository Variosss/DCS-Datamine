dofile(folder.."../../Cockpit/Scripts/devices.lua")
dofile(folder.."../../Cockpit/Scripts/command_defs.lua")

local res = {keyCommands = {},axisCommands = {}}

local keycommands = {
{combos = {{key = 'MOUSE_BTN2'}}, down = iCommand_ExplorationStart, name = _('Enable visual recon mode'), category = _('View Cockpit')},
{combos = {{key = 'MOUSE_BTN3'}}, down = iCommandViewTransposeModeOn, up = iCommandViewTransposeModeOff, name = _('Camera transpose mode (press and hold)'), category = _('View Cockpit')},

-- Synced from keyboard
{down = 3302, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Autopilot mode ATT (Attitude hold)'), category = _('Autopilot')},
{down = 3303, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Autopilot mode HÖJD (Altitude Hold)'), category = _('Autopilot')},
{cockpit_device_id = devices.FLIGHTDATAUNIT,  pressed = 3712, value_pressed =-1.0, name = _('Autopilot yaw trim Left'), category = _('Autopilot')},
{cockpit_device_id = devices.FLIGHTDATAUNIT, pressed = 3712, value_pressed =1.0, name = _('Autopilot yaw trim Right'), category = _('Autopilot')},
{down = 3402, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Autothrottle 12 or 15.5 alpha mode'), category = _('Autopilot')},
{down = 3104, value_down = 1.000000, cockpit_device_id = devices.ENGINEPANEL, name = _('Autothrottle mode AFK (toggle)'), category = _('Autopilot')},
{down = 3301, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('SAS mode SPAK flight stabiliser'), category = _('Autopilot')},
{down = 3002, value_down = 1.000000, up = 3002, value_up = 0.000000, cockpit_device_id = devices.ERRORPANEL, name = _('Check indicator lights'), category = _('Caution panel')},
{down = 3001, value_down = 1.000000, cockpit_device_id = devices.ERRORPANEL, name = _('Master caution reset'), category = _('Caution panel')},
{down = 3003, value_down = 1.000000, cockpit_device_id = devices.ERRORPANEL, name = _('Toggle caution light full/half'), category = _('Caution panel')},
{down = 3006, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure KB Mod 0'), category = _('Countermeasures')},
{down = 3007, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure KB Mod 1'), category = _('Countermeasures')},
{down = 3008, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure KB Mod 2'), category = _('Countermeasures')},
{down = 3009, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure KB Mod 3'), category = _('Countermeasures')},
{down = 3005, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure KB Mod A'), category = _('Countermeasures')},
{down = 3010, value_down = 0.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure KB Stråk Mod 0'), category = _('Countermeasures')},
{down = 3010, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure KB Stråk Mod 4'), category = _('Countermeasures')},
{down = 3016, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure U22 Jammer Band F'), category = _('Countermeasures')},
{down = 3017, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure U22 Jammer Band G'), category = _('Countermeasures')},
{down = 3018, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure U22 Jammer Band H'), category = _('Countermeasures')},
{down = 3019, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure U22 Jammer Band J'), category = _('Countermeasures')},
{down = 3020, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure U22 Jammer Band K'), category = _('Countermeasures')},
{down = 3011, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure U22 Jammer Mod 0'), category = _('Countermeasures')},
{down = 3012, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure U22 Jammer Mod A'), category = _('Countermeasures')},
{down = 3013, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure U22 Jammer Mod B'), category = _('Countermeasures')},
{down = 3014, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure U22 Jammer Mod D'), category = _('Countermeasures')},
{down = 3015, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Countermeasure U22 Jammer Mod E'), category = _('Countermeasures')},
{down = 3001, value_down = 1.000000, cockpit_device_id = devices.COUNTERMEASURE, name = _('Fast countermeasure dispense'), category = _('Countermeasures')},
{down = 3002, value_down = -1.000000, cockpit_device_id = devices.IFF, name = _('IK (IFF) Code Down'), category = _('Countermeasures')},
{down = 3002, value_down = 1.000000, cockpit_device_id = devices.IFF, name = _('IK (IFF) Code Up'), category = _('Countermeasures')},
{down = 3001, value_down = 1.000000, cockpit_device_id = devices.IFF, name = _('IK (IFF) On/Off'), category = _('Countermeasures')},
{pressed = 3005, value_pressed = -1.0, cockpit_device_id = devices.RWR, name = _('Master Volume / Sidewinder Tone Down'), category = _('Countermeasures')},
{pressed = 3005, value_pressed = 1.0, cockpit_device_id = devices.RWR, name = _('Master Volume / Sidewinder Tone Up'), category = _('Countermeasures')},
{down = 3002, value_down = 1.000000, cockpit_device_id = devices.RWR, name = _('RWR KB Lights'), category = _('Countermeasures')},
{down = 3003, value_down = 1.000000, cockpit_device_id = devices.RWR, name = _('RWR KB Lights/Sound'), category = _('Countermeasures')},
{down = 3001, value_down = 1.000000, cockpit_device_id = devices.RWR, name = _('RWR KB Off'), category = _('Countermeasures')},
{down = 3020, value_down = 1.000000, up = 3020, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Data panel Digit 0'), category = _('Data panel')},
{down = 3021, value_down = 1.000000, up = 3021, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Data panel Digit 1'), category = _('Data panel')},
{down = 3022, value_down = 1.000000, up = 3022, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Data panel Digit 2'), category = _('Data panel')},
{down = 3023, value_down = 1.000000, up = 3023, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Data panel Digit 3'), category = _('Data panel')},
{down = 3024, value_down = 1.000000, up = 3024, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Data panel Digit 4'), category = _('Data panel')},
{down = 3025, value_down = 1.000000, up = 3025, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Data panel Digit 5'), category = _('Data panel')},
{down = 3026, value_down = 1.000000, up = 3026, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Data panel Digit 6'), category = _('Data panel')},
{down = 3027, value_down = 1.000000, up = 3027, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Data panel Digit 7'), category = _('Data panel')},
{down = 3028, value_down = 1.000000, up = 3028, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Data panel Digit 8'), category = _('Data panel')},
{down = 3029, value_down = 1.000000, up = 3029, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Data panel Digit 9'), category = _('Data panel')},
{down = 3001, value_down = 1.000000, up = 3001, value_up = 0.000000, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Data panel RENSA (Clear)'), category = _('Data panel')},
{down = 3101, up = 3101, cockpit_device_id = devices.NAVIGATIONPANEL, value_down = 1.0, value_up = 0.0, name = _("Data panel RENSA cover"), category = _("Data panel")},
{down = 3101, value_down = 0.000000, up = 3101, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Data panel RENSA cover CLOSE'), category = _('Data panel')},
{down = 3101, value_down = 1.000000, up = 3101, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Data panel RENSA cover OPEN'), category = _('Data panel')},
{down = 3008, value_down = 1.000000, up = 3008, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Datapanel IN/UT Input / Output Switch IN'), category = _('Data panel')},
{down = 3008, value_down = 0.000000, up = 3008, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Datapanel IN/UT Input / Output Switch OUT (UT)'), category = _('Data panel')},
{down = 3602, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Airbrake in'), category = _('Flight Control')},
{down = 3601, value_down = 1.000000, up = 3601, value_up = 0.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Airbrake out (force)'), category = _('Flight Control')},
{down = 3600, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Airbrake out/in/force out'), category = _('Flight Control')},
{down = 3600, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Airbrake out/in/force out'), category = _('Flight Control')},
{down = 3406, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Canopy close'), category = _('Flight Control')},
{down = 3406, value_down = -1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Canopy open'), category = _('Flight Control')},
{down = 3405, value_down = 0.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Ejection seat Safe'), category = _('Flight Control')},
{down = 3405, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Ejection seat arm'), category = _('Flight Control')},
{down = 3717, value_down = 1.000000, up = 3717, value_up = 0.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Emergency Trim Pitch Down'), category = _('Flight Control')},
{down = 3717, value_down = -1.000000, up = 3717, value_up = 0.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Emergency Trim Pitch Up'), category = _('Flight Control')},
{down = 3716, value_down = -1.000000, up = 3716, value_up = 0.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Emergency Trim Roll Left'), category = _('Flight Control')},
{down = 3716, value_down = 1.000000, up = 3716, value_up = 0.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Emergency Trim Roll Rght'), category = _('Flight Control')},
{down = 3719, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Landing Gear Down'), category = _('Flight Control')},
{down = 3719, value_down = 0.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Landing Gear Up'), category = _('Flight Control')},
{down = 3723, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Landing Gear Up/Down (toggle)'), category = _('Flight Control')},
{down = 3413, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down =1.0, name = _('Parking brake (toggle)'), category = _('Flight Control')},
{down = 3211, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = "Pitch gearing Automatic/Landing (toggle)", category = "Flight Control"},
{down = 3001, value_down = 0.000000, cockpit_device_id = devices.REVERSAL, name = _('Reversal off'), category = _('Flight Control')},
{down = 3001, value_down = 1.000000, cockpit_device_id = devices.REVERSAL, name = _('Reversal on'), category = _('Flight Control')},
{up = 3305, value_up = 0.000000, pressed = 3305, value_pressed = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Roll centrering (Roll trim reset)'), category = _('Flight Control')},
{down = 3698, value_down = 1.000000, up = 3698, value_up = 0.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Wheelbrake'), category = _('Flight Control')},
{pressed = 3306, value_pressed = -0.330000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Altimeter setting Fast - Down'), category = _('Flight Data')},
{pressed = 3306, value_pressed = 0.330000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Altimeter setting Fast - Up'), category = _('Flight Data')},
{pressed = 3306, value_pressed = -0.050000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Altimeter setting Medium - Down'), category = _('Flight Data')},
{pressed = 3306, value_pressed = 0.050000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Altimeter setting Medium - Up'), category = _('Flight Data')},
{pressed = 3306, value_pressed = 0.012, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Altimeter setting Slow - Up'), category = _('Flight Data')},
{pressed = 3306, value_pressed = -0.012, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Altimeter setting Slow - Down'), category = _('Flight Data')},
{pressed = 3306, value_pressed = -0.003, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Altimeter setting Finest - Down'), category = _('Flight Data')},
{down = 3711, value_down = 1.0, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _("Altimeter setting pull-out (toggle)"), category = _("Flight Data")},
{down = 3715, up = 3715, value_down = 1.0, value_up = 0.0, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _("Altimeter setting pull-out (hold-pull)"), category = _("Flight Data")},    
{pressed = 3306, value_pressed = 0.003, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Altimeter setting Finest - Up'), category = _('Flight Data')},
{down = 3003, cockpit_device_id = devices.RADARALT, value_down = 1.0, name = _("Radar altimeter switch (toggle)"), category = _("Flight Data")},
{pressed = 3411, cockpit_device_id = devices.FLIGHTDATAUNIT, value_pressed = 1.0, name = _('HUD Brightness Increase'), category = _('HUD')},
{pressed = 3411, cockpit_device_id = devices.FLIGHTDATAUNIT, value_pressed = -1.0, name = _('HUD Brightness Decrease'), category = _('HUD')},
{down = 3001, cockpit_device_id = devices.LIGHTS, value_down = -1.0, name = _('Anti collision lights switch'), category = _('Lights')},
{down = 3001, value_down = 0.000000, cockpit_device_id = devices.LIGHTS, name = _('Anti collision lights switch - OFF'), category = _('Lights')},
{down = 3001, value_down = 1.000000, cockpit_device_id = devices.LIGHTS, name = _('Anti collision lights switch - ON'), category = _('Lights')},
{down = 3010, value_down = 0.000000, cockpit_device_id = devices.LIGHTS, name = _('Emergency lights switch - OFF'), category = _('Lights')},
{down = 3010, value_down = 1.000000, cockpit_device_id = devices.LIGHTS, name = _('Emergency lights switch - ON'), category = _('Lights')},
{down = 3003, value_down = -1.000000, cockpit_device_id = devices.LIGHTS, name = _('Formation lights switch'), category = _('Lights')},
{down = 3003, value_down = 0.000000, cockpit_device_id = devices.LIGHTS, name = _('Formation lights switch - OFF'), category = _('Lights')},
{down = 3003, value_down = 1.000000, cockpit_device_id = devices.LIGHTS, name = _('Formation lights switch - ON'), category = _('Lights')},
{down = 3001, value_down = 1.000000, up = 3001, value_up = 0.000000, cockpit_device_id = devices.ERRORPANEL, name = _('KONTROLL light test'), category = _('Lights')},
{down = 3002, cockpit_device_id = devices.LIGHTS, value_down = -2.0, name = _('Navigation lights switch'), category = _('Lights')},
{down = 3002, value_down = -1.000000, cockpit_device_id = devices.LIGHTS, name = _('Navigation lights switch - HALV'), category = _('Lights')},
{down = 3002, value_down = 1.000000, cockpit_device_id = devices.LIGHTS, name = _('Navigation lights switch - HEL'), category = _('Lights')},
{down = 3002, value_down = 0.000000, cockpit_device_id = devices.LIGHTS, name = _('Navigation lights switch - OFF'), category = _('Lights')},
{down = 3004, value_down = 0.000000, cockpit_device_id = devices.LIGHTS, name = _('Position lights switch - OFF'), category = _('Lights')},
{down = 3004, value_down = 1.000000, cockpit_device_id = devices.LIGHTS, name = _('Position lights switch - ON'), category = _('Lights')},
{down = 3009, cockpit_device_id = devices.LIGHTS, value_down = -1.0, name = 'Taxi/landing lights switch - ON', category = 'Lights'},
{down = 3009, cockpit_device_id = devices.LIGHTS, value_down = 1.0, name = 'Taxi/landing lights switch - TAXI', category = 'Lights'},
{down = 3009, cockpit_device_id = devices.LIGHTS, value_down = 0.0, name = 'Taxi/landing lights switch - OFF', category = 'Lights'},
{down = 3718, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Oxygen lever'), category = _('Misc')},
{down = 3504, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Easy mode - Air-to-air'), category = _('Mode selector')},
{down = 3503, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Easy mode - Grond attack'), category = _('Mode selector')},
{down = 3502, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Easy mode - Landing'), category = _('Mode selector')},
{down = 3501, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Easy mode - Navigaton'), category = _('Mode selector')},
{down = 3103, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Mode select - ANF'), category = _('Mode selector')},
{down = 3101, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Mode select - BER'), category = _('Mode selector')},
{down = 3100, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Mode select - FK'), category = _('Mode selector')},
{down = 3105, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Mode select - LANDNAV'), category = _('Mode selector')},
{down = 3106, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Mode select - LANDPO'), category = _('Mode selector')},
{down = 3102, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Mode select - NAV'), category = _('Mode selector')},
{down = 3104, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Mode select - SPA'), category = _('Mode selector')},
{down = 3669, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Mode select - turn clockwise'), category = _('Mode selector')},
{down = 3669, value_down = -1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Mode select - turn counterclockwise'), category = _('Mode selector')},
{down = 3006, value_down = 1.000000, cockpit_device_id = devices.ENGINEPANEL, name = _('Afterburner fuel valve (LTkran EBK)'), category = _('Motor')},
{down = 3003, value_down = 0.000000, cockpit_device_id = devices.ELECTRICSYSTEM, name = _('Backup Generator - OFF'), category = _('Motor')},
{down = 3003, value_down = 1.000000, cockpit_device_id = devices.ELECTRICSYSTEM, name = _('Backup Generator - ON'), category = _('Motor')},
{down = 3008, value_down = 1.000000, cockpit_device_id = devices.ENGINEPANEL, name = _('Engine De-ice switch (toggle)'), category = _('Motor')},
{down = 3002, value_down = 0.000000, cockpit_device_id = devices.ELECTRICSYSTEM, name = _('Generator - OFF'), category = _('Motor')},
{down = 3002, value_down = 1.000000, cockpit_device_id = devices.ELECTRICSYSTEM, name = _('Generator - ON'), category = _('Motor')},
{down = 3005, value_down = 1.000000, cockpit_device_id = devices.ENGINEPANEL, name = _('High-pressure fuel valve (toggle)'), category = _('Motor')},
{down = 3003, value_down = 0.000000, cockpit_device_id = devices.ENGINEPANEL, name = _('Ignition System - OFF'), category = _('Motor')},
{down = 3003, value_down = 1.000000, cockpit_device_id = devices.ENGINEPANEL, name = _('Ignition System - ON'), category = _('Motor')},
{down = 3002, value_down = 0.000000, cockpit_device_id = devices.ENGINEPANEL, name = _('Low Pressure Fuel Valve- OFF'), category = _('Motor')},
{down = 3002, value_down = 1.000000, cockpit_device_id = devices.ENGINEPANEL, name = _('Low Pressure Fuel Valve- ON'), category = _('Motor')},
{down = 3040, value_down = 1.000000, cockpit_device_id = devices.TEST, name = _('Low pressure fuel valve LT Kran'), category = _('Motor')},
{down = 3001, value_down = 0.000000, cockpit_device_id = devices.ELECTRICSYSTEM, name = _('Main Electric Power - OFF'), category = _('Motor')},
{down = 3001, value_down = 1.000000, cockpit_device_id = devices.ELECTRICSYSTEM, name = _('Main Electric Power - ON'), category = _('Motor')},
{down = 3009, value_down = 1.0, cockpit_device_id = devices.ENGINEPANEL, name = _('Manual fuel regulator switch (toggle)'), category = _('Motor')},
{down = 3001, value_down = 0.000000, cockpit_device_id = devices.ENGINEPANEL, name = _('Start System - OFF'), category = _('Motor')},
{down = 3001, value_down = 1.000000, cockpit_device_id = devices.ENGINEPANEL, name = _('Start System - ON'), category = _('Motor')},
{down = 3042, value_down = 1.000000, up = 3043, value_up = 1.000000, cockpit_device_id = devices.TEST, name = _('Startknapp'), category = _('Motor')},
{down = 3301, value_down = 1.000000, up = 3301, value_up = 0.000000, cockpit_device_id = devices.ENGINEPANEL, name = _('Throttle down'), category = _('Motor')},
{down = 3302, value_down = 1.000000, up = 3302, value_up = 0.000000, cockpit_device_id = devices.ENGINEPANEL, name = _('Throttle up'), category = _('Motor')},
{down = 3801, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = (0.5/15.0), value_up = 0, name = _('Clock Increase Time Setting'), category = _('Navigation')}, -- 15 seconds per click
{down = 3801, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = -(0.5/15.0), value_up = 0, name = _('Clock Decrease Time Setting'), category = _('Navigation')}, -- 15 seconds per click
{down = 3802, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0, name = _('Clock Stopwatch Start/Stop/Reset'), category = _('Navigation')},
{down = 3009, value_down = 0.000000, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Datapanel Rotary Mode 1 - ID-NR'), category = _('Navigation')},
{down = 3009, value_down = 0.100000, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Datapanel Rotary Mode 2 - TAKT'), category = _('Navigation')},
{down = 3009, value_down = 0.200000, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Datapanel Rotary Mode 3 - TID'), category = _('Navigation')},
{down = 3009, value_down = 0.300000, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Datapanel Rotary Mode 4 - VINDRUTA MÅL'), category = _('Navigation')},
{down = 3009, value_down = 0.400000, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Datapanel Rotary Mode 5 - BANA GRÄNS'), category = _('Navigation')},
{down = 3009, value_down = 0.500000, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Datapanel Rotary Mode 6 - REF LOLA'), category = _('Navigation')},
{down = 3009, value_down = 0.600000, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Datapanel Rotary Mode 7 - AKT POS'), category = _('Navigation')},
{down = 3401, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('HUD Position LOW/HIGH (toggle)'), category = _('Navigation')},
{down = 3200, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('HÖJD CISI (toggle)'), category = _('Navigation')},
{down = 3714, value_down = -1.000000, up = 3714, value_up = 0.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Magnetic correction left'), category = _('Navigation')},
{down = 3714, value_down = 1.000000, up = 3714, value_up = 0.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Magnetic correction right'), category = _('Navigation')},
{down = 3011, value_down = 1.000000, up = 3011, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Navigation panel Waypoint B1'), category = _('Navigation')},
{down = 3012, value_down = 1.000000, up = 3012, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Navigation panel Waypoint B2'), category = _('Navigation')},
{down = 3013, value_down = 1.000000, up = 3013, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Navigation panel Waypoint B3'), category = _('Navigation')},
{down = 3014, value_down = 1.000000, up = 3014, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Navigation panel Waypoint B4'), category = _('Navigation')},
{down = 3015, value_down = 1.000000, up = 3015, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Navigation panel Waypoint B5'), category = _('Navigation')},
{down = 3016, value_down = 1.000000, up = 3016, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Navigation panel Waypoint B6'), category = _('Navigation')},
{down = 3017, value_down = 1.000000, up = 3017, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Navigation panel Waypoint B7'), category = _('Navigation')},
{down = 3018, value_down = 1.000000, up = 3018, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Navigation panel Waypoint B8'), category = _('Navigation')},
{down = 3019, value_down = 1.000000, up = 3019, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Navigation panel Waypoint B9'), category = _('Navigation')},
{down = 3010, value_down = 1.000000, up = 3010, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Navigation panel Waypoint Bx'), category = _('Navigation')},
{down = 3008, value_down = 1.000000, up = 3008, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Navigation panel Waypoint L MÅL'), category = _('Navigation')},
{down = 3009, value_down = 1.000000, up = 3009, value_up = 0.000000, cockpit_device_id = devices.NAVIGATION, name = _('Navigation panel Waypoint LS SKU'), category = _('Navigation')},
{down = 3090, value_down = 1.000000, up = 3090, value_up = 0.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Reference button'), category = _('Navigation')},
{down = 3202, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, name = _("SLAV SI (toggle)"), category = _("Navigation")},
{up = 3404, value_up = 0.000000, pressed = 3404, value_pressed = -1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Seat adjustment down'), category = _('Navigation')},
{up = 3404, value_up = 0.000000, pressed = 3404, value_pressed = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('Seat adjustment up'), category = _('Navigation')},
{down = 3010, value_down = -1.000000, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Select Data Cartridge - Down'), category = _('Navigation')},
{down = 3010, value_down = 1.000000, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Select Data Cartridge - Up'), category = _('Navigation')},
{down = 3001, value_down = 1.0, cockpit_device_id = devices.MISSIONGENERATOR, name = _('Generated Cartride Increase Time Margin'), category = _('Navigation')},
{down = 3001, value_down = -1.0, cockpit_device_id = devices.MISSIONGENERATOR, name = _('Generated Cartride Decrease Time Margin'), category = _('Navigation')},
{down = 3510, value_down = 1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('TILS rotary clockwise'), category = _('Navigation')},
{down = 3510, value_down = -1.000000, cockpit_device_id = devices.FLIGHTDATAUNIT, name = _('TILS rotary counterclockwise'), category = _('Navigation')},
{down = 3002, cockpit_device_id = devices.NAVIGATIONPANEL, value_down = 1.0, name = _("A0 Mode"), category = _("Radar")},
{down = 3002, up = 3002, cockpit_device_id = devices.NAVIGATIONPANEL, value_down = 1.0, value_up = 0.0, name = _("A0 Mode (Three position switch)"), category = _("Radar")},
{down = 3002, cockpit_device_id = devices.NAVIGATIONPANEL, value_down = 0.0, name = _("A1 Mode"), category = _("Radar")},
{down = 3002, cockpit_device_id = devices.NAVIGATIONPANEL, value_down = -1.0, name = _("A2 Mode"), category = _("Radar")},
{down = 3002, up = 3002, cockpit_device_id = devices.NAVIGATIONPANEL, value_down = -1.0, value_up = 0.0, name = _("A2 Mode (Three position switch)"), category = _("Radar")},
{down = 3213, value_down = 1.000000, up = 3213, value_up = 0.0, cockpit_device_id = devices.RADAR, name = _('Radar Terrain Avoidance Mode'), category = _('Radar')},
{down = 3214, value_down = 1.000000, cockpit_device_id = devices.RADAR, name = _('Passive radar mode'), category = _('Radar')},
{down = 3323, value_down = -1.000000, up = 3323, value_up = 0.0, cockpit_device_id = devices.RADAR, name = _('Radar Range Decrease'), category = _('Radar')},
{down = 3323, value_down = 1.000000, up = 3323, value_up = 0.0, cockpit_device_id = devices.RADAR, name = _('Radar Range Increase'), category = _('Radar')},
{down = 3208, value_down = 0.000000, cockpit_device_id = devices.RADAR, name = _('Radar AS0'), category = _('Radar')},
{down = 3208, value_down = 0.100000, cockpit_device_id = devices.RADAR, name = _('Radar AS1'), category = _('Radar')},
{down = 3208, value_down = 0.200000, cockpit_device_id = devices.RADAR, name = _('Radar AS2'), category = _('Radar')},
{down = 3208, value_down = 0.300000, cockpit_device_id = devices.RADAR, name = _('Radar AS3'), category = _('Radar')},
{down = 3208, value_down = 0.400000, cockpit_device_id = devices.RADAR, name = _('Radar AS4'), category = _('Radar')},
{down = 3208, value_down = 0.500000, cockpit_device_id = devices.RADAR, name = _('Radar AS5'), category = _('Radar')},
{down = 3208, value_down = 0.600000, cockpit_device_id = devices.RADAR, name = _('Radar AS6'), category = _('Radar')},
{down = 3208, value_down = 0.700000, cockpit_device_id = devices.RADAR, name = _('Radar AS7'), category = _('Radar')},
{pressed = 3924, cockpit_device_id = devices.RADAR, value_pressed = 1.0, name = _('Radar Brightness Increase'), category = _('Radar')},  
{pressed = 3924, cockpit_device_id = devices.RADAR, value_pressed = -1.0, name = _('Radar Brightness Decrease'), category = _('Radar')}, 
{down = 3209, value_down = 0.000000, cockpit_device_id = devices.RADAR, name = _('Radar LIN'), category = _('Radar')},
{down = 3209, value_down = 1.000000, cockpit_device_id = devices.RADAR, name = _('Radar LOG'), category = _('Radar')},
{pressed = 3326, value_pressed = -1.000000, cockpit_device_id = devices.RADAR, name = _('Radar MKR Gain Decrease'), category = _('Radar')},
{pressed = 3326, value_pressed = 1.000000, cockpit_device_id = devices.RADAR, name = _('Radar MKR Gain Increase'), category = _('Radar')},
{down = 3325, value_down = 0.5, cockpit_device_id = devices.RADAR, name = _('Radar MKR Gain Center'), category = _('Radar')},
{up = 3215, value_up = 0.000000, pressed = 3215, value_pressed = -1.000000, cockpit_device_id = devices.RADAR, name = _('Radar elevation down'), category = _('Radar')},
{up = 3215, value_up = 0.000000, pressed = 3215, value_pressed = 1.000000, cockpit_device_id = devices.RADAR, name = _('Radar elevation up'), category = _('Radar')},
{down = 3641, value_down = 0.0, 	 cockpit_device_id = devices.RADAR  name = _("Radar elevation center"), category = _("Radar")},
{down = 3010, value_down = 1.000000, cockpit_device_id = devices.RADAR, name = _('Radar range 120km'), category = _('Radar')},
{down = 3013, value_down = 1.000000, cockpit_device_id = devices.RADAR, name = _('Radar range 15km'), category = _('Radar')},
{down = 3012, value_down = 1.000000, cockpit_device_id = devices.RADAR, name = _('Radar range 30km'), category = _('Radar')},
{down = 3011, value_down = 1.000000, cockpit_device_id = devices.RADAR, name = _('Radar range 60km'), category = _('Radar')},
{up = 3100, value_up = 1.000000, pressed = 3102, value_pressed = 1.000000, cockpit_device_id = devices.RADAR, name = _('Radarstick Down'), category = _('Radar')},
{up = 3100, value_up = 1.000000, pressed = 3103, value_pressed = 1.000000, cockpit_device_id = devices.RADAR, name = _('Radarstick Left'), category = _('Radar')},
{up = 3100, value_up = 1.000000, pressed = 3104, value_pressed = 1.000000, cockpit_device_id = devices.RADAR, name = _('Radarstick Right'), category = _('Radar')},
{up = 3100, value_up = 1.000000, pressed = 3101, value_pressed = 1.000000, cockpit_device_id = devices.RADAR, name = _('Radarstick Up'), category = _('Radar')},
{down = 3005, value_down = 1.000000, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('T0 Fix'), category = _('Radar')},
{down = 3006, value_down = 1.000000, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('T1 Fix'), category = _('Radar')},
{down = 3007, value_down = 1.000000, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('TV Fix'), category = _('Radar')},
{pressed = 3802,         cockpit_device_id = devices.RADAR, value_pressed = 1.0, value_up = 0.0, name = _("Radar Cl filter clockwise"), category = _("Radar")},
{pressed = 3802,         cockpit_device_id = devices.RADAR, value_pressed = -1.0, value_up = 0.0, name = _("Radar Cl filter anti-clockwise"), category = _("Radar")},
{down = 3001, value_down = -1.000000, cockpit_device_id = devices.FR22, name = _('FR22 Base selector turn left'), category = _('Radios')},
{down = 3014, value_down = 1.0, up = 3014, value_up = 0.0, cockpit_device_id = devices.FR22, name = _('FR22 Radio AM/FM switch (hold- AM)'), category = _('Radios')},
{down = 3001, value_down = 1.000000, cockpit_device_id = devices.FR22, name = _('FR22 Base selector turn right'), category = _('Radios')},
{down = 3003, value_down = -1.000000, cockpit_device_id = devices.FR22, name = _('FR22 Frequency wheel 1 and 2 Down'), category = _('Radios')},
{down = 3003, value_down = 1.000000, cockpit_device_id = devices.FR22, name = _('FR22 Frequency wheel 1 and 2 Up'), category = _('Radios')},
{down = 3004, value_down = -1.000000, cockpit_device_id = devices.FR22, name = _('FR22 Frequency wheel 3 Down'), category = _('Radios')},
{down = 3004, value_down = 1.000000, cockpit_device_id = devices.FR22, name = _('FR22 Frequency wheel 3 Up'), category = _('Radios')},
{down = 3005, value_down = -1.000000, cockpit_device_id = devices.FR22, name = _('FR22 Frequency wheel 4 Down'), category = _('Radios')},
{down = 3005, value_down = 1.000000, cockpit_device_id = devices.FR22, name = _('FR22 Frequency wheel 4 Up'), category = _('Radios')},
{down = 3006, value_down = -1.000000, cockpit_device_id = devices.FR22, name = _('FR22 Frequency wheel 5 and 6 Down'), category = _('Radios')},
{down = 3006, value_down = 1.000000, cockpit_device_id = devices.FR22, name = _('FR22 Frequency wheel 5 and 6 Up'), category = _('Radios')},
{down = 3007, value_down = -1.000000, cockpit_device_id = devices.FR22, name = _('FR22 Group selector turn left'), category = _('Radios')},
{down = 3007, value_down = 1.000000, cockpit_device_id = devices.FR22, name = _('FR22 Group selector turn right'), category = _('Radios')},
{down = 3002, value_down = 0.500000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button 0'), category = _('Radios')},
{down = 3002, value_down = 0.550000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button 1'), category = _('Radios')},
{down = 3002, value_down = 0.600000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button 2'), category = _('Radios')},
{down = 3002, value_down = 0.650000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button 3'), category = _('Radios')},
{down = 3002, value_down = 0.700000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button 4'), category = _('Radios')},
{down = 3002, value_down = 0.750000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button 5'), category = _('Radios')},
{down = 3002, value_down = 0.800000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button 6'), category = _('Radios')},
{down = 3002, value_down = 0.850000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button 7'), category = _('Radios')},
{down = 3002, value_down = 0.900000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button 8'), category = _('Radios')},
{down = 3002, value_down = 0.950000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button 9'), category = _('Radios')},
{down = 3002, value_down = 0.250000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button A/G'), category = _('Radios')},
{down = 3002, value_down = 0.300000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button B'), category = _('Radios')},
{down = 3002, value_down = 0.350000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button C/F'), category = _('Radios')},
{down = 3002, value_down = 0.400000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button C2'), category = _('Radios')},
{down = 3002, value_down = 0.450000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button D/E'), category = _('Radios')},
{down = 3002, value_down = 0.000000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button H'), category = _('Radios')},
{down = 3002, value_down = 0.200000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button Minus'), category = _('Radios')},
{down = 3002, value_down = 0.050000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button Special 1'), category = _('Radios')},
{down = 3002, value_down = 0.100000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button Special 2'), category = _('Radios')},
{down = 3002, value_down = 0.150000, cockpit_device_id = devices.FR22, name = _('FR22 Push-button Special 3'), category = _('Radios')},
{down = 3011, value_down = 1.000000, cockpit_device_id = devices.TESTINTERCOM, name = _('FR22 Push-to-talk'), category = _('Radios')},
{down = 3013, value_down = 1.000000, up = 3013, value_up = 0.000000, cockpit_device_id = devices.FR22, name = _('FR24 Mute'), category = _('Radios')},
{down = 3012, value_down = 1.000000, cockpit_device_id = devices.TESTINTERCOM, name = _('FR24 Push-to-talk'), category = _('Radios')},
{down = 3013, value_down = 1.0, up = 3013, value_up = 0.0, cockpit_device_id = devices.TESTINTERCOM, name = _('FR22 Push-to-talk (Short- Menu, Long- VOIP)'), category = _('Radios')},
{down = 3014, value_down = 1.0, up = 3014, value_up = 0.0, cockpit_device_id = devices.TESTINTERCOM, name = _('FR24 Push-to-talk (Short- Menu, Long- VOIP)'), category = _('Radios')},
{down = 3010, value_down = 1.000000, cockpit_device_id = devices.FR22, name = _('Radio function selector turn left'), category = _('Radios')},
{down = 3010, value_down = -1.000000, cockpit_device_id = devices.FR22, name = _('Radio function selector turn right'), category = _('Radios')},
{pressed = 3012, value_pressed = -1.0, cockpit_device_id = devices.FR22, name = _('Radio volume control decrease'), category = _('Radios')},
{pressed = 3012, value_pressed = 1.0, cockpit_device_id = devices.FR22, name = _('Radio volume control increase'), category = _('Radios')},
{down = 3004, value_down = 1.000000, cockpit_device_id = devices.WALKMAN, name = _('Fast Backward'), category = _('Tape Player')},
{down = 3003, value_down = 1.000000, cockpit_device_id = devices.WALKMAN, name = _('Fast Forward'), category = _('Tape Player')},
{down = 3001, value_down = 1.000000, cockpit_device_id = devices.WALKMAN, name = _('Play'), category = _('Tape Player')},
{down = 3002, value_down = 1.000000, cockpit_device_id = devices.WALKMAN, name = _('Stop'), category = _('Tape Player')},
{down = 3006, value_down = 1.000000, cockpit_device_id = devices.WALKMAN, name = _('Volume Down'), category = _('Tape Player')},
{down = 3005, value_down = 1.000000, cockpit_device_id = devices.WALKMAN, name = _('Volume Up'), category = _('Tape Player')},
{down = 3504, value_down = 1.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Confirm Ground Crew Orders'), category = _('Weapons')},
{down = 3502, value_down = 1.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Cycle Ground Crew Fuel Selection'), category = _('Weapons')},
{down = 3501, value_down = 1.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Cycle Ground Crew Loadout Selection'), category = _('Weapons')},
{down = 3503, value_down = 1.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Cycle Ground Crew Regroup Selection'), category = _('Weapons')},
{pressed = 3316, value_pressed = 1.0, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('EP13 Brightness up'), category = _('Weapons')},
{pressed = 3316, value_pressed = -1.0, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('EP13 Brightness down'), category = _('Weapons')},
{pressed = 3317, value_pressed = 1.0, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('EP13 Contrast up'), category = _('Weapons')},
{pressed = 3317, value_pressed = -1.0, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('EP13 Contrast down'), category = _('Weapons')},
{down = 3320, value_down = 1.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Fuel tank jettison Button'), category = _('Weapons')},
{down = 3402, value_down = 1.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Fuel tank jettison Cover'), category = _('Weapons')},
{down = 3311, value_down = 1.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('IR-missile fast select'), category = _('Weapons')},
{down = 3314, value_down = 1.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('IR-missile uncage'), category = _('Weapons')},
{down = 3322, value_down = -1.000000, up = 3322, value_up = 0.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Rb05 stick pitch down'), category = _('Weapons')},
{down = 3322, value_down = 1.000000, up = 3322, value_up = 0.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Rb05 stick pitch up'), category = _('Weapons')},
{down = 3321, value_down = -1.000000, up = 3321, value_up = 0.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Rb05 stick yaw left'), category = _('Weapons')},
{down = 3321, value_down = 1.000000, up = 3321, value_up = 0.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Rb05 stick yaw right'), category = _('Weapons')},
{down = 3304, value_down = 0.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Weapon Selector Knob Mode 1 - SJÖ | PLAN'), category = _('Weapons')},
{down = 3304, value_down = 0.100000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Weapon Selector Knob Mode 2 - RB75 | MARK | DYK'), category = _('Weapons')},
{down = 3304, value_down = 0.200000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Weapon Selector Knob Mode 3 - LUFT | RR'), category = _('Weapons')},
{down = 3304, value_down = 0.300000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Weapon Selector Knob Mode 4 - AKAN JAKT'), category = _('Weapons')},
{down = 3304, value_down = 0.400000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Weapon Selector Knob Mode 5 - ATTACK'), category = _('Weapons')},
{down = 3304, value_down = 0.500000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Weapon Selector Knob Mode 6 - IR-RB'), category = _('Weapons')},
{down = 3303, value_down = 1.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Weapon jettison Button'), category = _('Weapons')},
{down = 3302, value_down = 1.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Weapon jettison Cover'), category = _('Weapons')},
{down = 3969, value_down = -1.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Weapon selector turn clockwise'), category = _('Weapons')},
{down = 3969, value_down = 1.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Weapon selector turn counterclockwise'), category = _('Weapons')},


-- Synced from joystick
{down = 3323, value_down = 1.000000, up = 3323, value_up = 0.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Rb05 switch input with flight stick (hold)'), category = _('Weapons')},
{down = 3300, value_down = 1.000000, up = 3300, value_up = 0.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Trigger safety bracket (hold)'), category = _('Weapons')},
{down = 3300, value_down = 1.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Trigger safety bracket ARM'), category = _('Weapons')},
{down = 3300, value_down = 0.000000, cockpit_device_id = devices.WEAPON_SYSTEM, name = _('Trigger safety bracket SAFE'), category = _('Weapons')},
{down = 3011, value_down = 1.000000, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Datapanel Rotary Clockwise'), category = _('Navigation')},
{down = 3011, value_down = -1.000000, cockpit_device_id = devices.NAVIGATIONPANEL, name = _('Datapanel Rotary Counterclockwise'), category = _('Navigation')},
{down = 3001, value_down = -1.000000, cockpit_device_id = devices.MISSIONGENERATOR, name = _('Decrease Generated Cartride Time Margin'), category = _('Navigation')},
{down = 3001, value_down = 1.000000, cockpit_device_id = devices.MISSIONGENERATOR, name = _('Increase Generated Cartride Time Margin'), category = _('Navigation')},
{down=iCommandPlaneEject,name = _('Eject (3 times)'), category = _('Flight Control')},
{down = 3003, cockpit_device_id = devices.LIGHTS, value_down = -1.0, name = _('Formation lights switch'), category = _('Lights')},
{down = 3001, cockpit_device_id = devices.ERRORPANEL, value_down = 1.0,  name = _('Master caution reset'), category = _('Caution panel')},
{cockpit_device_id = devices.FLIGHTDATAUNIT,  down = 3713, up = 3713, value_down =-1.0, value_up =0.0, name = _('Trim: Rudder Left'), category = _('Flight Control')},
{cockpit_device_id = devices.FLIGHTDATAUNIT,  down = 3713, up = 3713, value_down =1.0, value_up =0.0, name = _('Trim: Rudder Right'), category = _('Flight Control')},
  
  -- FunkyFranks assigments
	-- FF: begin custom assignments
	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- flight data unit
	{down = 3097, up = 3097, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0.0, name = _('HÖJD CISI LD/RHM (hold- LD)'), category = _('Navigation')}, --working, toggle only
	{down = 3201, up = 3201, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0.0, name = _('Slav SI Switch F/T (hold- T)'), category = _('Navigation')}, --working, toggle only
	{down = 3210, up = 3210, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0.0, name = _('Pitch Gear Switch Automatic/Landing (hold- landing)'), category = _('Flight Control')}, --working
	{down = 3401, up = 3401, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 1.0, name = _('HUD shift to lower position (hold)'), category = _('Navigation')}, --working, toggle only
	{down = 3405, up = 3405, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0.0, name = _('Ejection Seat Arm/Disarm'), category = _('Flight Control')}, --working
	{down = 3406, up = 3406, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0.0, name = _('Canopy Close/Center'), category = _('Flight Control')}, --working
	{down = 3406, up = 3406, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down =-1.0, value_up = 0.0, name = _('Canopy Open/Center'), category = _('Flight Control')}, -- working
	{down = 3406, up = 3406, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up =-1.0, name = _('Canopy Close/Open'), category = _('Flight Control')}, --working
	{down = 3407, up = 3407, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0.0, name = _('Canopy Jettison'), category = _('Flight Control')}, --added v0.5
	{down = 3408, up = 3408, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0.0, name = _('Parking Brake (hold- on)'), category = _('Flight Control')},
	{down = 3513,            cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0,                 name = _('TILS Channel Layer Selection 1-10/11-20 (toggle)'), category = _('Navigation')}, --working, toggle only
    {down = 3511, up = 3511, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0.0, name = _('TILS Channel Layer Selection 1-10/11-20 (hold - 11-20)'), category = _('Navigation')}, --working, toggle only
	{down = 3601, up = 3602, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 1.0, name = _('Airbrake Out/In'), category = _('Flight Control')}, --working
    {down=3718, up=3718, cockpit_device_id=devices.FLIGHTDATAUNIT, value_down=1.0, value_up=0.0, name = _('Oxygen lever (hold- on)'), category = _('Misc')},
    {down=3710, cockpit_device_id=devices.FLIGHTDATAUNIT, value_down=1.0, name = _('Oxygen lever (toggle)'), category = _('Misc')},
	{down = 3719, up = 3719, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 0.0, value_up = 1.0, name = _('Landing Gear Lever Up/Down (hold- Up)'), category = _('Flight Control')}, --working
	{down = 3719, up = 3719, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0.0, name = _('Landing Gear Lever Up/Down (hold- Down)'), category = _('Flight Control')}, --working
	{down = 3301, up = 3302, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 1.0, name = _('Autopilot SPAK/ATT'), category = _('Flight Control')}, --added v0.5
	{down = 3303, up = 3302, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 1.0, name = _('Autopilot HÖJD/ATT'), category = _('Flight Control')}, --added v0.5
	{down = 3720, up = 3720, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0.0, name = _('Backup ADI Cage Depress/Release'), category = _('Navigation')}, --added v1.3
	{down = 3091, up = 3091, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0.0, name = _('FL37 ADI Fast Erect (Snabbresning) Depress/Release'), category = _('Navigation')}, --added v1.3
	{down = 3722, up = 3722, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0.0, name = _('Max G Reset Depress/Release'), category = _('Navigation')}, --added v1.3
	{down = 3305, up = 3305, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0.0, name = _('Roll Centering Depress/Release'), category = _('Flight Control')}, --added v1.3
	{down = 3716, up = 3716, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0.0, name = _('Emergency Roll Trim (NÖDTRIM ROLL) Right(H)/Center'), category = _('Flight Control')}, --added v1.3
	{down = 3716, up = 3716, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down =-1.0, value_up = 0.0, name = _('Emergency Roll Trim (NÖDTRIM ROLL) Left(V)/Center'), category = _('Flight Control')}, --added v1.3
	{down = 3918, up = 3918, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, value_up = 0.0, name = _('Emergency Yaw Trim (SIDTRIM) Right(H)/Center'), category = _('Flight Control')}, --added v1.3
	{down = 3918, up = 3918, cockpit_device_id = devices.FLIGHTDATAUNIT, value_down =-1.0, value_up = 0.0, name = _('Emergency Yaw Trim (SIDTRIM) Left(V)/Center'), category = _('Flight Control')}, --added v1.3
	{down = 3743, 			 cockpit_device_id = devices.FLIGHTDATAUNIT, value_down = 1.0, 				   name = _('Magnetic Declination Cover Open/Close'), category = _('Navigation')}, -- added v1.3
	{pressed = 3725,         cockpit_device_id = devices.FLIGHTDATAUNIT, value_pressed = 0.010,            name = _("Magnetic Declination Increase"), category = _("Navigation")}, --added v1.3
	{pressed = 3725,         cockpit_device_id = devices.FLIGHTDATAUNIT, value_pressed =-0.010,            name = _("Magnetic Declination Decrease"), category = _("Navigation")}, --added v1.3
	{pressed = 3721,         cockpit_device_id = devices.FLIGHTDATAUNIT, value_pressed = 0.005,            name = _("Backup Altimeter Setting Up - Slow"), category = _("Navigation")}, --added v1.3
	{pressed = 3721,         cockpit_device_id = devices.FLIGHTDATAUNIT, value_pressed =-0.005,            name = _("Backup Altimeter Setting Down - Slow"), category = _("Navigation")}, --added v1.3
	{pressed = 3721,         cockpit_device_id = devices.FLIGHTDATAUNIT, value_pressed = 0.015,            name = _("Backup Altimeter Setting Up - Normal"), category = _("Navigation")}, --added v1.3
	{pressed = 3721,         cockpit_device_id = devices.FLIGHTDATAUNIT, value_pressed =-0.015,            name = _("Backup Altimeter Setting Down - Normal"), category = _("Navigation")}, --added v1.3
	{pressed = 3721,         cockpit_device_id = devices.FLIGHTDATAUNIT, value_pressed = 0.045,            name = _("Backup Altimeter Setting Up - Fast"), category = _("Navigation")}, --added v1.3
	{pressed = 3721,         cockpit_device_id = devices.FLIGHTDATAUNIT, value_pressed =-0.045,            name = _("Backup Altimeter Setting Down - Fast"), category = _("Navigation")}, --added v1.3

	-- engine panel
	{down = 3001, up = 3001, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0, name = _("System Start Switch On/Off"), category = _("Motor")}, --working
	{down = 3002, up = 3002, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0, name = _('Low-pressure Fuel Valve On/Off'), category = _('Motor')}, --working
	{down = 3003, up = 3003, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0, name = _('Ignition System Man/Aut'), category = _('Motor')}, --working
	{down = 3401, up = 3401, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0, name = _('Aterstart (Restart) Switch On/Off'), category = _('Motor')}, --added v0.6
	{down = 3004, up = 3004, cockpit_device_id = devices.ENGINEPANEL, value_down = 0.0, value_up = 1.0,  name = _("High-pressure Fuel Valve (hold- cut off)"), category = _("Motor")},
	{down = 3004, up = 3004, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0,  name = _("High-pressure Fuel Valve (hold- idle)"), category = _("Motor")},
	{down = 3006,            cockpit_device_id = devices.ENGINEPANEL, value_down = 0.5,                 name = _("Manual Afterburner Fuel Valve Open/Closed (toggle)"), category = _("Motor")}, --working
    {down = 3006, up = 3006, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0, name = _("Manual Afterburner Fuel Valve Open/Closed (hold- open)"), category = _("Motor")}, --working
    {down = 3006, up = 3006, cockpit_device_id = devices.ENGINEPANEL, value_down = 0.0, value_up = 1.0, name = _("Manual Afterburner Fuel Valve Open/Closed (hold- closed)"), category = _("Motor")}, --working
	{down = 3007, up = 3007, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0, name = _("Manual Fuel Regulator On/Off (hold- on)"), category = _("Motor")}, --working
	{down = 3099, up = 3099, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0, name = _("Engine De-Ice On/Off (hold)"), category = _("Motor")}, --working, toggle only
	{down = 3304, up = 3304, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0, name = _('Autopilot Autothrottle mode AFK (hold-On)'), category = _('Flight Control')}, --working
	{down = 3913, up = 3913, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0, name = _('Autopilot Maintenance Testing Mode On/Off'), category = _('Flight Control')}, --added v0.6
	{down = 3919, up = 3919, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0, name = _('DME Selector On/Off'), category = _('Navigation')}, --working
	{down = 3920, up = 3920, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0, name = _('IFF/Transponder Power On/Off'), category = _('Navigation')}, --working
	{down = 3920,            cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0,                 name = _('IFF/Transponder Power On'), category = _('Navigation')}, --added v1.3
	{down = 3920,            cockpit_device_id = devices.ENGINEPANEL, value_down = 0.0,                 name = _('IFF/Transponder Power Off'), category = _('Navigation')}, --added v1.3
	{down = 3921, up = 3921, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0, name = _('IFF Channel Selector A+C/A'), category = _('Navigation')}, --working
	{down = 3921,            cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0,                 name = _('IFF Channel Selector A+C'), category = _('Navigation')}, --added v1.3
	{down = 3921,            cockpit_device_id = devices.ENGINEPANEL, value_down = 0.0,                 name = _('IFF Channel Selector A'), category = _('Navigation')}, --added v1.3
	{down = 3924, up = 3924, cockpit_device_id = devices.ENGINEPANEL, value_down = 0.0, value_up = 1.0, name = _('Flight Recorder Till/Fran'), category = _('Navigation')}, --working
	{down = 3924, up = 3924, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0, name = _('Flight Recorder Fran/Till'), category = _('Navigation')}, --working
	{down = 3925, up = 3925, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0, name = _('Data Cartridge Insert/Remove'), category = _('Navigation')}, --working
	{down = 3925,            cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0,                 name = _('Data Cartridge Insert'), category = _('Navigation')}, --added v0.6
	{down = 3925,            cockpit_device_id = devices.ENGINEPANEL, value_down = 0.0,                 name = _('Data Cartridge Remove'), category = _('Navigation')}, --added v0.6
	{down = 3000, up = 3000, cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0, value_up = 0.0, name = _('Missile Select Button (IR-RB FRAMSTEGN) Depress/Release'), category = _('Weapons')}, --added v1.3 (seems to be same button number as Cabin Air Valve)
	{down = 3905,            cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0,                 name = _('CB Autopilot SA Out'), category = _('Electronics')}, --added v1.3
	{down = 3905,            cockpit_device_id = devices.ENGINEPANEL, value_down = 0.0,                 name = _('CB Autopilot SA In'), category = _('Electronics')}, --added v1.3
	{down = 3906,            cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0,                 name = _('CB High Alpha Warning Out'), category = _('Electronics')}, --added v1.3
	{down = 3906,            cockpit_device_id = devices.ENGINEPANEL, value_down = 0.0,                 name = _('CB High Alpha Warning In'), category = _('Electronics')}, --added v1.3
	{down = 3907,            cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0,                 name = _('CB Trim System Out'), category = _('Electronics')}, --added v1.3
	{down = 3907,            cockpit_device_id = devices.ENGINEPANEL, value_down = 0.0,                 name = _('CB Trim System In'), category = _('Electronics')}, --added v1.3
	{down = 3908,            cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0,                 name = _('CB CI/SI Out'), category = _('Electronics')}, --added v1.3
	{down = 3908,            cockpit_device_id = devices.ENGINEPANEL, value_down = 0.0,                 name = _('CB CI/SI In'), category = _('Electronics')}, --added v1.3
	{down = 3909,            cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0,                 name = _('CB Ejection System Out'), category = _('Electronics')}, --added v1.3
	{down = 3909,            cockpit_device_id = devices.ENGINEPANEL, value_down = 0.0,                 name = _('CB Ejection System In'), category = _('Electronics')}, --added v1.3
	{down = 3910,            cockpit_device_id = devices.ENGINEPANEL, value_down = 1.0,                 name = _('CB Engine Out'), category = _('Electronics')}, --added v1.3
	{down = 3910,            cockpit_device_id = devices.ENGINEPANEL, value_down = 0.0,                 name = _('CB Engine In'), category = _('Electronics')}, --added v1.3
	-- lights
	{down = 3001, up = 3001, cockpit_device_id = devices.LIGHTS, value_down = 1.0, value_up = 0.0, name = _('Anti Collision Lights On/Off'), category = _('Lights')}, --working
	{down = 3002, up = 3002, cockpit_device_id = devices.LIGHTS, value_down = 1.0, value_up = 0.0, name = _('Navigation Lights Bright/Off'), category = _('Lights')}, --working
	{down = 3002, up = 3002, cockpit_device_id = devices.LIGHTS, value_down =-2.0, value_up = 0.0, name = _('Navigation Lights Dim/Off'), category = _('Lights')}, --working
	{down = 3003, up = 3003, cockpit_device_id = devices.LIGHTS, value_down = 1.0, value_up = 0.0, name = _('Formation Lights On/Off'), category = _('Lights')}, --working
	{down = 3004, up = 3004, cockpit_device_id = devices.LIGHTS, value_down = 1.0, value_up = 0.0, name = _('Position Lights On/Off'), category = _('Lights')}, --working
	{down = 3006, up = 3006, cockpit_device_id = devices.LIGHTS, value_down = 1.0, value_up = 0.0, name =_('Panel Lights 2-Pos. Switch (hold-on)'), category = _('Lights')}, --added v1.2 LeCuvier
	{down = 3007, up = 3007, cockpit_device_id = devices.LIGHTS, value_down = 1.0, value_up = 0.0, name =_('Flood Lights 2-Pos. Switch (hold-on)'), category = _('Lights')}, --added v1.2 LeCuvier
	{down = 3008, up = 3008, cockpit_device_id = devices.LIGHTS, value_down = 1.0, value_up = 0.0, name =_('Instrument Lights 2-Pos. Switch (hold-on)'), category = _('Lights')}, --added v1.2 LeCuvier
	{down = 3015,            cockpit_device_id = devices.LIGHTS, value_down = 1.0,                    name =_('Panel Lights toggle'), category = _('Lights')},
    {down = 3016,            cockpit_device_id = devices.LIGHTS, value_down = 1.0,                    name =_('Flood Lights toggle'), category = _('Lights')},
    {down = 3017,            cockpit_device_id = devices.LIGHTS, value_down = 1.0,                    name =_('Instrument Lights toggle'), category = _('Lights')},
	-- brightness
	{down = 3005, up = 3005, cockpit_device_id = devices.LIGHTS, value_down = 0.2, value_up = 0.0, name = _('Position Lights Brightness 3/1'), category = _('Lights')}, --working
	{down = 3005, up = 3005, cockpit_device_id = devices.LIGHTS, value_down = 0.1, value_up = 0.0, name = _('Position Lights Brightness 2/1'), category = _('Lights')}, --working
	{down = 3005, up = 3005, cockpit_device_id = devices.LIGHTS, value_down = 0.2, value_up = 0.1, name = _('Position Lights Brightness 3/2'), category = _('Lights')}, --working
	{down = 3005, up = 3005, cockpit_device_id = devices.LIGHTS, value_down = 0.0, value_up = 0.1, name = _('Position Lights Brightness 1/2'), category = _('Lights')}, --working
	{down = 3010, up = 3010, cockpit_device_id = devices.LIGHTS, value_down = 1.0, value_up = 0.0, name = _('Emergency Lights Switch On/Off'), category = _('Lights')}, --working
	-- device "7"
	{down = 3001, up = 3001, cockpit_device_id = 7, value_down = 1.0, value_up = 0.0, name = _('Thrust Reverser On/Off'), category = _('Flight Control')}, --working
	-- electrical system
	{down = 3001, up = 3001, cockpit_device_id = devices.ELECTRICSYSTEM, value_down = 1.0, value_up = 0.0, name = _('Main Electric Power On/Off'), category = _('Electronics')}, --working
	{down = 3002, up = 3002, cockpit_device_id = devices.ELECTRICSYSTEM, value_down = 1.0, value_up = 0.0, name = _('Generator On/Off'), category = _('Electronics')}, --working
	--{down = 3003, up = 3003, cockpit_device_id = devices.ELECTRICSYSTEM, value_down = 1.0, value_up = 0.0, name = _('Backup Generator On/Off'), category = _('Electronics')}, --working
	-- radar altimeter
	{down = 3002, up = 3002, cockpit_device_id = devices.RADARALT, value_down = 1.0, value_up = 0.0, name = _('Radar Altimeter Power On/Off (hold- on)'), category = _('Navigation')}, --working
	-- weapon system
	{down = 3306, up = 3306, cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.0, value_up = 1.0, name = _('Weapon Release Mode Fallsattomkopplare Up/Down'), category = _('Weapons')}, --working
	{down = 3307, up = 3307, cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.0, value_up = 1.0, name = _('RB-04/RB-15/BK Release Mode Valb/Prep'), category = _('Weapons')}, --working
	{down = 3304,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.0,                 name = _("Weapon Selector 0 SJÖ/PLAN"), category = _("Weapons")}, -- added v0.6
	{down = 3304,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.1,                 name = _("Weapon Selector 1 RB75/MARK/DYK"), category = _("Weapons")}, -- added v0.6
	{down = 3304,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.2,                 name = _("Weapon Selector 2 LUFT/RR"), category = _("Weapons")}, -- added v0.6
	{down = 3304,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.3,                 name = _("Weapon Selector 3 AKAN/JAKT"), category = _("Weapons")}, -- added v0.6
	{down = 3304,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.4,                 name = _("Weapon Selector 4 ATTACK"), category = _("Weapons")}, -- added v0.6
	{down = 3304,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.5,                 name = _("Weapon Selector 5 IR-RB"), category = _("Weapons")}, -- added v0.6
	{down = 3305,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 1.0,                 name = _("Weapon Interval 00 VÄ"), category = _("Weapons")}, -- added v0.6
	{down = 3305,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.9,                 name = _("Weapon Interval 01 RAKT"), category = _("Weapons")}, -- added v0.6
	{down = 3305,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.8,                 name = _("Weapon Interval 02 HÖ"), category = _("Weapons")}, -- added v0.6
	{down = 3305,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.7,                 name = _("Weapon Interval 03 10m"), category = _("Weapons")}, -- added v0.6
	{down = 3305,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.6,                 name = _("Weapon Interval 04 15m"), category = _("Weapons")}, -- added v0.6
	{down = 3305,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.5,                 name = _("Weapon Interval 05 20m"), category = _("Weapons")}, -- added v0.6
	{down = 3305,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.4,                 name = _("Weapon Interval 06 25m"), category = _("Weapons")}, -- added v0.6
	{down = 3305,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.3,                 name = _("Weapon Interval 07 30m"), category = _("Weapons")}, -- added v0.6
	{down = 3305,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.2,                 name = _("Weapon Interval 08 40m"), category = _("Weapons")}, -- added v0.6
	{down = 3305,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.1,                 name = _("Weapon Interval 09 50m"), category = _("Weapons")}, -- added v0.6
	{down = 3305,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 0.0,                 name = _("Weapon Interval 10 60m"), category = _("Weapons")}, -- added v0.6
	{down = 3301,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 1.0,				  name = _("Weapon Interval turn clockwise"), category = _("Weapons")},
	{down = 3301,            cockpit_device_id = devices.WEAPON_SYSTEM, value_down = -1.0,				  name = _("Weapon Interval turn anti-clockwise"), category = _("Weapons")},
	{down = 3320, up = 3320, cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 1.0, value_up = 0.0, name = _('Fuel Tank Jettison Button Depress/Release'), category = _('Weapons')}, -- added v1.3
	{down = 3303, up = 3303, cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 1.0, value_up = 0.0, name = _('Weapon Emergency Release Button Depress/Release'), category = _('Weapons')}, -- added v1.3
	{down = 3302, up = 3302, cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 1.0, value_up = 0.0, name = _('Weapon Emergency Release Cover Open/Close'), category = _('Weapons')}, -- added v1.3
	{down = 3402, up = 3402, cockpit_device_id = devices.WEAPON_SYSTEM, value_down = 1.0, value_up = 0.0, name = _('External Tank Release Cover Open/Close'), category = _('Weapons')}, -- added v1.3
	-- radios
	{down = 3008, cockpit_device_id = devices.FR22, value_down = 1.0, name = _('FR22 Radio AM/FM (toggle)'), category = _('Radios')}, --changed v1.0
	{down = 3210,            cockpit_device_id = devices.FR22, value_down = 1.0,                 name = _('FR22 Radio Flight 0'), category = _('Radios')}, --added v1.2
	{down = 3211,            cockpit_device_id = devices.FR22, value_down = 1.0,                 name = _('FR22 Radio Flight 1'), category = _('Radios')}, --added v1.2
	{down = 3212,            cockpit_device_id = devices.FR22, value_down = 1.0,                 name = _('FR22 Radio Flight 2'), category = _('Radios')}, --added v1.2
	{down = 3213,            cockpit_device_id = devices.FR22, value_down = 1.0,                 name = _('FR22 Radio Flight 3'), category = _('Radios')}, --added v1.2
	{down = 3214,            cockpit_device_id = devices.FR22, value_down = 1.0,                 name = _('FR22 Radio Flight 4'), category = _('Radios')}, --added v1.2
	{down = 3215,            cockpit_device_id = devices.FR22, value_down = 1.0,                 name = _('FR22 Radio Flight 5'), category = _('Radios')}, --added v1.2
	{down = 3216,            cockpit_device_id = devices.FR22, value_down = 1.0,                 name = _('FR22 Radio Flight 6'), category = _('Radios')}, --added v1.2
	{down = 3217,            cockpit_device_id = devices.FR22, value_down = 1.0,                 name = _('FR22 Radio Flight 7'), category = _('Radios')}, --added v1.2
	{down = 3218,            cockpit_device_id = devices.FR22, value_down = 1.0,                 name = _('FR22 Radio Flight 8'), category = _('Radios')}, --added v1.2
	{down = 3219,            cockpit_device_id = devices.FR22, value_down = 1.0,                 name = _('FR22 Radio Flight 9'), category = _('Radios')}, --added v1.2
	{pressed = 3003, up = 3003, cockpit_device_id = devices.FR22, value_pressed = 0.1, value_up = 0.0, name = _('FR22 Radio Manual Frequency Setting Knob Inner Left Increase'), category = _('Radios')}, --added v1.3
	{pressed = 3003, up = 3003, cockpit_device_id = devices.FR22, value_pressed =-0.1, value_up = 0.0, name = _('FR22 Radio Manual Frequency Setting Knob Inner Left Decrease'), category = _('Radios')}, --added v1.3
	{pressed = 3004, up = 3004, cockpit_device_id = devices.FR22, value_pressed = 0.1, value_up = 0.0, name = _('FR22 Radio Manual Frequency Setting Knob Outer Left Increase'), category = _('Radios')}, --added v1.3
	{pressed = 3004, up = 3004, cockpit_device_id = devices.FR22, value_pressed =-0.1, value_up = 0.0, name = _('FR22 Radio Manual Frequency Setting Knob Outer Left Decrease'), category = _('Radios')}, --added v1.3
	{pressed = 3005, up = 3005, cockpit_device_id = devices.FR22, value_pressed = 0.1, value_up = 0.0, name = _('FR22 Radio Manual Frequency Setting Knob Inner Right Increase'), category = _('Radios')}, --added v1.3
	{pressed = 3005, up = 3005, cockpit_device_id = devices.FR22, value_pressed =-0.1, value_up = 0.0, name = _('FR22 Radio Manual Frequency Setting Knob Inner Right Decrease'), category = _('Radios')}, --added v1.3
	{pressed = 3006, up = 3006, cockpit_device_id = devices.FR22, value_pressed = 0.1, value_up = 0.0, name = _('FR22 Radio Manual Frequency Setting Knob Outer Right Increase'), category = _('Radios')}, --added v1.3
	{pressed = 3006, up = 3006, cockpit_device_id = devices.FR22, value_pressed =-0.1, value_up = 0.0, name = _('FR22 Radio Manual Frequency Setting Knob Outer Right Decrease'), category = _('Radios')}, --added v1.3
	-- walkman
	{down=3001, up = 3002, cockpit_device_id=devices.WALKMAN, value_down=1.0, value_up = 1.0, name= _('Walkman Play/Stop'), category = _('Tape Player')}, --working
	-- radar
	{pressed = 3208, up = 0.0, cockpit_device_id = devices.RADAR, value_pressed = 0.1, value_up = 0.0, name = _("Anti Jamming Mode (AS) Selector Up (test)"), category = _("Radar")}, -- added v1.3
	{down = 3208,            cockpit_device_id = devices.RADAR, value_down = 0.0,                 name = _("Anti Jamming Mode (AS) Selector 0"), category = _("Radar")}, -- added v0.6
	{down = 3208,            cockpit_device_id = devices.RADAR, value_down = 0.1,                 name = _("Anti Jamming Mode (AS) Selector 1"), category = _("Radar")}, -- added v0.6
	{down = 3208,            cockpit_device_id = devices.RADAR, value_down = 0.2,                 name = _("Anti Jamming Mode (AS) Selector 2"), category = _("Radar")}, -- added v0.6
	{down = 3208,            cockpit_device_id = devices.RADAR, value_down = 0.3,                 name = _("Anti Jamming Mode (AS) Selector 3"), category = _("Radar")}, -- added v0.6
	{down = 3208,            cockpit_device_id = devices.RADAR, value_down = 0.4,                 name = _("Anti Jamming Mode (AS) Selector 4"), category = _("Radar")}, -- added v0.6
	{down = 3208,            cockpit_device_id = devices.RADAR, value_down = 0.5,                 name = _("Anti Jamming Mode (AS) Selector 5"), category = _("Radar")}, -- added v0.6
	{down = 3208,            cockpit_device_id = devices.RADAR, value_down = 0.6,                 name = _("Anti Jamming Mode (AS) Selector 6"), category = _("Radar")}, -- added v0.6
	{down = 3208,            cockpit_device_id = devices.RADAR, value_down = 0.7,                 name = _("Anti Jamming Mode (AS) Selector 7"), category = _("Radar")}, -- added v0.6
	{down = 3209, up = 3209, cockpit_device_id = devices.RADAR, value_down = 1.0, value_up = 0.0, name = _("Radar Gain Log/Lin"), category = _("Radar")}, --working
	{down = 3209, up = 3209, cockpit_device_id = devices.RADAR, value_down = 0.0, value_up = 1.0, name = _("Radar Gain Lin/Log"), category = _("Radar")}, --working
	{down = 3213, up = 3213, cockpit_device_id = devices.RADAR, value_down = 1.0, value_up = 0.0, name = _("Radar Obstacle detection mode On/Off"), category = _("Radar")}, --added v1.2 by HF
	{down = 3328, up = 3328, cockpit_device_id = devices.RADAR, value_down = 0.0, value_up = 1.0, name = _("Radar Pulse Normal/Short"), category = _("Radar")}, --working
	{down = 3350, up = 3350, cockpit_device_id = devices.RADAR, value_down = 1.0, value_up = 0.0, name = _("Radar Passive Recce On/Off"), category = _("Radar")}, --working
	--{down = 3914, up = 3914, cockpit_device_id = devices.RADAR, value_down = 1.0, value_up = 0.0, name = _("Radar/EL Maintenance Test On/Off"), category = _("Radar")}, --working
	--{down = 3918, up = 3918, cockpit_device_id = devices.RADAR, value_down = 1.0, value_up = 0.0, name = _("Radar Ignition Coils On/Off"), category = _("_My Buttons")}, --working
	{down = 3922, up = 3922, cockpit_device_id = devices.RADAR, value_down = 1.0, value_up = 0.0, name = _("IFF Identification Depressed/Released"), category = _("Navigation")}, --added v1.3
	-- doppler
	{down = 3001, up = 3001, cockpit_device_id = devices.DOPPLER, value_down = 0.0, value_up = 1.0, name = _("Doppler Mode Land (hold)"), category = _("Navigation")}, --working, toggle only
	{down = 3098, value_down = 1.0, cockpit_device_id = devices.DOPPLER, name = _('Doppler Mode Land/Sea (toggle)'), category = _('Navigation')}, -- toggle
	-- navigation panel
	{down = 3008, up = 3008, cockpit_device_id = devices.NAVIGATIONPANEL, value_down = 1.0, value_up = 0.0, name = _("Datapanel Switch In/out"), category = _("Navigation")}, --working
	{down = 3008,            cockpit_device_id = devices.NAVIGATIONPANEL, value_down = 1.0,                 name = _("Datapanel Switch Input"), category = _("Navigation")}, --added v0.4
	{down = 3008,            cockpit_device_id = devices.NAVIGATIONPANEL, value_down = 0.0,                 name = _("Datapanel Switch Output"), category = _("Navigation")}, --added v0.4
	{down = 3009,            cockpit_device_id = devices.NAVIGATIONPANEL, value_down = 0.0,                 name = _("Datapanel ID-NR"), category = _("Navigation")}, -- added v0.6
	{down = 3009,            cockpit_device_id = devices.NAVIGATIONPANEL, value_down = 0.1,                 name = _("Datapanel TAKT"), category = _("Navigation")}, -- added v0.6
	{down = 3009,            cockpit_device_id = devices.NAVIGATIONPANEL, value_down = 0.2,                 name = _("Datapanel TID"), category = _("Navigation")}, -- added v0.6
	{down = 3009,            cockpit_device_id = devices.NAVIGATIONPANEL, value_down = 0.3,                 name = _("Datapanel VIND/RUTA/MAL"), category = _("Navigation")}, -- added v0.6
	{down = 3009,            cockpit_device_id = devices.NAVIGATIONPANEL, value_down = 0.4,                 name = _("Datapanel BANA/GRANS"), category = _("Navigation")}, -- added v0.6
	{down = 3009,            cockpit_device_id = devices.NAVIGATIONPANEL, value_down = 0.5,                 name = _("Datapanel REF/LOLA"), category = _("Navigation")}, -- added v0.6
	{down = 3009,            cockpit_device_id = devices.NAVIGATIONPANEL, value_down = 0.6,                 name = _("Datapanel AKTPOS"), category = _("Navigation")}, -- added v0.6
	-- RWR
	{down = 3001, up = 3002, cockpit_device_id = devices.RWR, value_down = 1.0, value_up = 1.0,  name = _('KB Off/Lights'), category = _('Lights')}, --added v0.4
	{down = 3003, up = 3002, cockpit_device_id = devices.RWR, value_down = 1.0, value_up = 1.0,  name = _('KB Lights+Sound/Lights'), category = _('Lights')}, --added v0.4
	-- countermeasures
	{down = 3010, up = 3010, cockpit_device_id = devices.COUNTERMEASURE, value_down = 1.0, value_up = 0.0, name = _('Countermeasure KB Stråk Mod 4/0'), category = _('Countermeasures')}, --added v0.4
	{down = 3028, up = 3028, cockpit_device_id = devices.COUNTERMEASURE, value_down = 0.0, value_up = 0.1, name = _('Countermeasure Chaff/Flares Selector R/RF'), category = _('Countermeasures')}, --added v0.4
	{down = 3028, up = 3028, cockpit_device_id = devices.COUNTERMEASURE, value_down = 0.2, value_up = 0.1, name = _('Countermeasure Chaff/Flares Selector F/RF'), category = _('Countermeasures')}, --added v0.4
	-- ERRORPANEL
	{down = 3004, up = 3004, cockpit_device_id = devices.ERRORPANEL,     value_down = 1.0, value_up = 0.0, name = _('KONTROLL Indicator System Test'), category = _('Lights')}, --added v1.3
	-- begin added missing buttons
	{down = 3008, up = 3008, cockpit_device_id = devices.NAVIGATION, value_down = 1.0, value_up = 0.0, name = _("Navigationpanel Button L MÅL"), category = _("Navigation")}, --added v0.4
	{down = 3009, up = 3009, cockpit_device_id = devices.NAVIGATION, value_down = 1.0, value_up = 0.0, name = _("Navigationpanel Button LS"), category = _("Navigation")}, --added v0.4
	{down = 3010, up = 3010, cockpit_device_id = devices.NAVIGATION, value_down = 1.0, value_up = 0.0, name = _("Navigationpanel Waypoint BX"), category = _("Navigation")}, --added v0.4
	-- end added missing buttons
  
}

local autogeneratedkeys = dofile(folder.."../mousebindings.lua")
join(keycommands, autogeneratedkeys)
join(res.keyCommands, keycommands)

axiscommands = {
-- mouse axes
{combos = {{key = 'MOUSE_X'}}, action = iCommandPlaneViewHorizontal, name = _('Camera Horizontal View')},
{combos = {{key = 'MOUSE_Y'}}, action = iCommandPlaneViewVertical, name = _('Camera Vertical View')},
{combos = {{key = 'MOUSE_Z'}}, action = iCommandPlaneZoomView, name = _('Camera Zoom View')},

}

local autogeneratedaxis = dofile(folder.."../mouseaxisbindings.lua")
join(axiscommands, autogeneratedaxis)
join(res.axisCommands, axiscommands)
return res
