local cockpit = folder.."../../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

return {
keyCommands = {

-- Cheat - Temporary
{combos = {{key = 'Home', reformers = {'LWin'}}}, down = iCommandEnginesStart, name = _('Auto Start'), category = _('Cheat')},
{combos = {{key = 'End' , reformers = {'LWin'}}} , down = iCommandEnginesStop, name = _('Auto Stop') , category = _('Cheat')},

-- General
{combos = {{key = '\''}}, down = iCommandScoresWindowToggle, name = _('Score window'), category = _('General')},
--{combos = {{key = 'Tab', reformers = {'LShift'}}}, down = iCommandTrkEsc, name = _('Playback track cancel'), category = _('General')},
{combos = {{key = 'Y', reformers = {'LCtrl'}}}, down = iCommandInfoOnOff, name = _('Info bar toggle'), category = _('General')},
{combos = {{key = 'Tab', reformers = {'RCtrl','RShift'}}}, down = iCommandRecoverHuman, name = _('Get New Plane - respawn'), category = _('General')},
{combos = {{key = 'C', reformers = {'LAlt'}}}, down = iCommandCockpitClickModeOnOff, name = _('Clickable mouse cockpit mode On/Off'), category = _('General')},
{combos = {{key = 'J', reformers = {'RAlt'}}}, down = iCommandPlaneJump, name = _('Jump into other aircraft'), category = _('General')},
{combos = {{key = 'SysRQ'}}, down = iCommandScreenShot, name = _('Screenshot'), category = _('General'), disabled = true},
{combos = {{key = 'Y', reformers = {'LAlt'}}}, down = iCommandViewCoordinatesInLinearUnits, name = _('Info bar coordinate units toggle'), category = _('General')},
{combos = {{key = 'P', reformers = {'RShift'}}}, down = iCommandCockpitShowPilotOnOff, name = _('Show Pilot Body'), category = _('General')},
{combos = {{key = 'Enter', reformers = {'RCtrl'}}}, down = iCommandPlane_ShowControls, name = _('Show controls indicator') , category = _('General')},

{combos = {{key = '\'', reformers = {'LAlt'}}}, 			down = iCommandMissionResourcesManagement, name = _('Rearming and Refueling Window'), category = _('General')},
{combos = {{key = '\'', reformers = {'RShift'}}}, 			down = iCommandDebriefing, name = _('Debriefing window'), category = _('General')},
{combos = {{key = 'B', reformers = {'LAlt'}}},				down = iCommandViewBriefing, name = _('Briefing window'), category = _('General')},
{combos = {{key = 'S',	 reformers = {'LWin'}}},			down = iCommandSoundOnOff,			name = _('Sound On/Off'),	 category = _('General')},

{combos = {{key = 'C'}},	down = device_commands.Button_1,	cockpit_device_id = devices.NETWORK_SYNCH_CONTROLLER,	value_down = 0.0,	name = _('Request Aircraft Control'),	category = _('Flight Control')},
{combos = {{key = 'Enter', reformers = {'RCtrl', 'RWin'}}}, down = device_commands.Button_1, cockpit_device_id = devices.CREWE, value_down = 1.0, name = _('Show crew indicator'), category = _('General')},

-- View                                                    
{combos = {{key = 'Num4'}}, pressed = iCommandViewLeftSlow, up = iCommandViewStopSlow, name = _('View Left slow'), category = _('View')},
{combos = {{key = 'Num6'}}, pressed = iCommandViewRightSlow, up = iCommandViewStopSlow, name = _('View Right slow'), category = _('View')},
{combos = {{key = 'Num8'}}, pressed = iCommandViewUpSlow, up = iCommandViewStopSlow, name = _('View Up slow'), category = _('View')},
{combos = {{key = 'Num2'}}, pressed = iCommandViewDownSlow, up = iCommandViewStopSlow, name = _('View Down slow'), category = _('View')},
{combos = {{key = 'Num9'}}, pressed = iCommandViewUpRightSlow, up = iCommandViewStopSlow, name = _('View Up Right slow'), category = _('View')},
{combos = {{key = 'Num3'}}, pressed = iCommandViewDownRightSlow, up = iCommandViewStopSlow, name = _('View Down Right slow'), category = _('View')},
{combos = {{key = 'Num1'}}, pressed = iCommandViewDownLeftSlow, up = iCommandViewStopSlow, name = _('View Down Left slow'), category = _('View')},
{combos = {{key = 'Num7'}}, pressed = iCommandViewUpLeftSlow, up = iCommandViewStopSlow, name = _('View Up Left slow'), category = _('View')},
{combos = {{key = 'Num5'}}, pressed = iCommandViewCenter, name = _('Center View'), category = _('View')},

{combos = {{key = 'Num*'}}, pressed = iCommandViewForwardSlow, up = iCommandViewForwardSlowStop, name = _('Zoom in slow'), category = _('View')},

{combos = {{key = 'Num/'}}, pressed = iCommandViewBackSlow, up = iCommandViewBackSlowStop, name = _('Zoom out slow'), category = _('View')},
{combos = {{key = 'NumEnter'}}, down = iCommandViewAngleDefault, name = _('Zoom normal'), category = _('View')},
{combos = {{key = 'Num*', reformers = {'RCtrl'}}}, pressed = iCommandViewExternalZoomIn, up = iCommandViewExternalZoomInStop, name = _('Zoom external in'), category = _('View')},
{combos = {{key = 'Num/', reformers = {'RCtrl'}}}, pressed = iCommandViewExternalZoomOut, up = iCommandViewExternalZoomOutStop, name = _('Zoom external out'), category = _('View')},
{combos = {{key = 'NumEnter', reformers = {'RCtrl'}}}, down = iCommandViewExternalZoomDefault, name = _('Zoom external normal'), category = _('View')},
{combos = {{key = 'Num*', reformers = {'LAlt'}}}, down = iCommandViewSpeedUp, name = _('F11 camera moving forward'), category = _('View')},
{combos = {{key = 'Num/', reformers = {'LAlt'}}}, down = iCommandViewSlowDown, name = _('F11 camera moving backward'), category = _('View')},
{combos = {{key = 'PageDown', reformers = {'LCtrl'}}}, down = iCommandViewSwitchForward, name = _('Objects switching direction forward '), category = _('View')},
{combos = {{key = 'PageUp', reformers = {'LCtrl'}}}, down = iCommandViewSwitchReverse, name = _('Objects switching direction reverse '), category = _('View')},
{combos = {{key = 'Delete', reformers = {'LAlt'}}}, down = iCommandViewObjectIgnore, name = _('Object exclude '), category = _('View')},
{combos = {{key = 'Insert', reformers = {'LAlt'}}}, down = iCommandViewObjectsAll, name = _('Objects all excluded - include'), category = _('View')},

{combos = {{key = 'F1'}}, down = iCommandViewCockpit, name = _('F1 Cockpit view'), category = _('View')},
{combos = {{key = 'F1', reformers = {'LCtrl'}}}, down = iCommandNaturalViewCockpitIn, name = _('F1 Natural head movement view'), category = _('View')},
{combos = {{key = 'F1', reformers = {'LAlt'}}}, down = iCommandViewHUDOnlyOnOff, name = _('F1 HUD only view switch'), category = _('View')},
{combos = {{key = 'F2'}}, down = iCommandViewAir, name = _('F2 Aircraft view'), category = _('View')},
{combos = {{key = 'F2', reformers = {'LCtrl'}}}, down = iCommandViewMe, name = _('F2 View own aircraft'), category = _('View')},
{combos = {{key = 'F2', reformers = {'RAlt'}}}, down = iCommandViewFromTo, name = _('F2 Toggle camera position'), category = _('View')},
{combos = {{key = 'F2', reformers = {'LAlt'}}}, down = iCommandViewLocal, name = _('F2 Toggle local camera control'), category = _('View')},
{combos = {{key = 'F3'}}, down = iCommandViewTower, name = _('F3 Fly-By view'), category = _('View')},
{combos = {{key = 'F3', reformers = {'LCtrl'}}}, down = iCommandViewTowerJump, name = _('F3 Fly-By jump view'), category = _('View')},
{combos = {{key = 'F4'}}, down = iCommandViewRear, name = _('F4 Camera mounted on airframe'), category = _('View')},
{combos = {{key = 'F4', reformers = {'LCtrl'}}}, down = iCommandViewChase, name = _('F4 Chase view'), category = _('View')},
{combos = {{key = 'F4', reformers = {'LShift'}}},down = iCommandViewChaseArcade, name = _('F4 Arcade Chase view'), category = _('View')},
{combos = {{key = 'F5'}}, down = iCommandViewFight, name = _('F5 Nearest AC view'), category = _('View')},
{combos = {{key = 'F5', reformers = {'LCtrl'}}}, down = iCommandViewFightGround, name = _('F5 Ground hostile view'), category = _('View')},
{combos = {{key = 'F6'}}, down = iCommandViewWeapons, name = _('F6 Released weapon view'), category = _('View')},
{combos = {{key = 'F6', reformers = {'LCtrl'}}}, down = iCommandViewWeaponAndTarget, name = _('F6 Weapon to target view'), category = _('View')},
{combos = {{key = 'F7'}}, down = iCommandViewGround, name = _('F7 Ground unit view'), category = _('View')},
{combos = {{key = 'F9'}}, down = iCommandViewNavy, name = _('F9 Ship view'), category = _('View')},
{combos = {{key = 'F9', reformers = {'LAlt'}}}, down = iCommandViewLndgOfficer, name = _('F9 Landing signal officer view'), category = _('View')},
{combos = {{key = 'F10'}}, down = iCommandViewAWACS, name = _('F10 Theater map view'), category = _('View')},
{combos = {{key = 'F10', reformers = {'LCtrl'}}}, down = iCommandViewAWACSJump, name = _('F10 Jump to theater map view over current point'), category = _('View')},
{combos = {{key = 'F11'}}, down = iCommandViewFree, name = _('F11 Airport free camera'), category = _('View')},
{combos = {{key = 'F11', reformers = {'LCtrl'}}}, down = iCommandViewFreeJump, name = _('F11 Jump to free camera'), category = _('View')},
{combos = {{key = 'F12'}}, down = iCommandViewStatic, name = _('F12 Static object view'), category = _('View')},
{combos = {{key = 'F12', reformers = {'LCtrl'}}}, down = iCommandViewMirage, name = _('F12 Civil traffic view'), category = _('View')},
{combos = {{key = 'F12', reformers = {'LShift'}}}, down = iCommandViewLocomotivesToggle, name = _('F12 Trains/cars toggle'), category = _('View')},

{combos = {{key = ']', reformers = {'LShift'}}}, down = iCommandViewFastKeyboard, name = _('Camera view keyboard rate fast'), category = _('View')},
{combos = {{key = ']', reformers = {'LCtrl'}}}, down = iCommandViewSlowKeyboard, name = _('Camera view keyboard rate slow'), category = _('View')},
{combos = {{key = ']', reformers = {'LAlt'}}}, down = iCommandViewNormalKeyboard, name = _('Camera view keyboard rate normal'), category = _('View')},
{combos = {{key = '[', reformers = {'LShift'}}}, down =  iCommandViewFastMouse, name = _('Camera view mouse rate fast'), category = _('View')},
{combos = {{key = '[', reformers = {'LCtrl'}}}, down = iCommandViewSlowMouse, name = _('Camera view mouse rate slow'), category = _('View')},
{combos = {{key = '[', reformers = {'LAlt'}}}, down = iCommandViewNormalMouse, name = _('Camera view mouse rate normal'), category = _('View')},

-- Experimental object free camera
{combos = {{key = 'F2', reformers = {'RCtrl'}}}, 		down = iCommandViewObject, name = _('Object free camera'), category = _('View')},
{combos = {{key = '=', reformers = {'RAlt', 'RShift'}}}, 			down = iCommandViewBookmarksEditor, name = _('Object free camera bookmarks editor'), category = _('View')},
{combos = {{key = '-', reformers = {'RWin'}}}, 			down = iCommandViewBookmarksMenu, name = _('Object free camera bookmarks menu'), category = _('View')},
{combos = {{key = 'O', reformers = {'RWin'}}}, 			down = iCommandViewPieMenu, name = _('Pie menu'), category = _('View')},
-- Experimental wingman camera
{combos = {{key = 'F4', reformers = {'LAlt'}}}, 		down = iCommandViewWingman, name = _('Wingman camera'), category = _('View')},
-- Camera position to/from clipboard 
{combos = {{key = ',', reformers = {'RWin'}}}, 			down = iCommandViewCameraToClipboard, name = _('Unload camera position to clipboard'), category = _('View')},
{combos = {{key = '.', reformers = {'RWin'}}}, 			down = iCommandViewClipboardToCamera, name = _('Load camera position from clipboard'), category = _('View')},

-- View Cockpit
{combos = {{key = 'Num0'}}, down = iCommandViewTempCockpitOn, up = iCommandViewTempCockpitOff, name = _('Cockpit panel view in'), category = _('View Cockpit')},
{combos = {{key = 'Num0', reformers = {'RCtrl'}}}, down = iCommandViewTempCockpitToggle, name = _('Cockpit panel view toggle'), category = _('View Cockpit')},
--// Save current cockpit camera angles for fast numpad jumps  
{combos = {{key = 'Num0', reformers = {'RAlt'}}}, down = iCommandViewSaveAngles, name = _('Save Cockpit Angles'), category = _('View Cockpit')},
{combos = {{key = 'Num8', reformers = {'RShift'}}}, pressed = iCommandViewUp, up = iCommandViewStop, name = _('View up'), category = _('View Cockpit')},
{combos = {{key = 'Num2', reformers = {'RShift'}}}, pressed = iCommandViewDown, up = iCommandViewStop, name = _('View down'), category = _('View Cockpit')},
{combos = {{key = 'Num4', reformers = {'RShift'}}}, pressed = iCommandViewLeft, up = iCommandViewStop, name = _('View left'), category = _('View Cockpit')},
{combos = {{key = 'Num6', reformers = {'RShift'}}}, pressed = iCommandViewRight, up = iCommandViewStop, name = _('View right'), category = _('View Cockpit')},
{combos = {{key = 'Num9', reformers = {'RShift'}}}, pressed = iCommandViewUpRight, up = iCommandViewStop, name = _('View up right'), category = _('View Cockpit')},
{combos = {{key = 'Num3', reformers = {'RShift'}}}, pressed = iCommandViewDownRight, up = iCommandViewStop, name = _('View down right'), category = _('View Cockpit')},
{combos = {{key = 'Num1', reformers = {'RShift'}}}, pressed = iCommandViewDownLeft, up = iCommandViewStop, name = _('View down left'), category = _('View Cockpit')},
{combos = {{key = 'Num7', reformers = {'RShift'}}}, pressed = iCommandViewUpLeft, up = iCommandViewStop, name = _('View up left'), category = _('View Cockpit')},

{combos = {{key = 'Num8', reformers = {'RCtrl'}}}, down = iCommandViewCameraUp, up = iCommandViewCameraCenter, name = _('Camera view up'), category = _('View Cockpit')},
{combos = {{key = 'Num2', reformers = {'RCtrl'}}}, down = iCommandViewCameraDown, up = iCommandViewCameraCenter, name = _('Camera view down'), category = _('View Cockpit')},
{combos = {{key = 'Num4', reformers = {'RCtrl'}}}, down = iCommandViewCameraLeft, up = iCommandViewCameraCenter, name = _('Camera view left'), category = _('View Cockpit')},
{combos = {{key = 'Num6', reformers = {'RCtrl'}}}, down = iCommandViewCameraRight, up = iCommandViewCameraCenter, name = _('Camera view right'), category = _('View Cockpit')},
{combos = {{key = 'Num7', reformers = {'RCtrl'}}}, down = iCommandViewCameraUpLeft, up = iCommandViewCameraCenter, name = _('Camera view up-left'), category = _('View Cockpit')},
{combos = {{key = 'Num1', reformers = {'RCtrl'}}}, down = iCommandViewCameraDownLeft, up = iCommandViewCameraCenter, name = _('Camera view down-left'), category = _('View Cockpit')},
{combos = {{key = 'Num9', reformers = {'RCtrl'}}}, down = iCommandViewCameraUpRight, up = iCommandViewCameraCenter, name = _('Camera view up-right'), category = _('View Cockpit')},
{combos = {{key = 'Num3', reformers = {'RCtrl'}}}, down = iCommandViewCameraDownRight, up = iCommandViewCameraCenter, name = _('Camera view down-right'), category = _('View Cockpit')},
--{combos = {{key = 'F1', reformers = {'RAlt'}}}, down = iCommandViewPanToggle, name = _('Camera pan mode toggle'), category = _('View Cockpit')},

{combos = {{key = 'Num8', reformers = {'RAlt'}}}, down = iCommandViewCameraUpSlow, name = _('Camera view up slow'), category = _('View Cockpit')},
{combos = {{key = 'Num2', reformers = {'RAlt'}}}, down = iCommandViewCameraDownSlow, name = _('Camera view down slow'), category = _('View Cockpit')},
{combos = {{key = 'Num4', reformers = {'RAlt'}}}, down = iCommandViewCameraLeftSlow, name = _('Camera view left slow'), category = _('View Cockpit')},
{combos = {{key = 'Num6', reformers = {'RAlt'}}}, down = iCommandViewCameraRightSlow, name = _('Camera view right slow'), category = _('View Cockpit')},
{combos = {{key = 'Num7', reformers = {'RAlt'}}}, down = iCommandViewCameraUpLeftSlow, name = _('Camera view up-left slow'), category = _('View Cockpit')},
{combos = {{key = 'Num1', reformers = {'RAlt'}}}, down = iCommandViewCameraDownLeftSlow, name = _('Camera view down-left slow'), category = _('View Cockpit')},
{combos = {{key = 'Num9', reformers = {'RAlt'}}}, down = iCommandViewCameraDownRight, name = _('Camera view up-right slow'), category = _('View Cockpit')},
{combos = {{key = 'Num3', reformers = {'RAlt'}}}, down = iCommandViewCameraUpRightSlow, name = _('Camera view down-right slow'), category = _('View Cockpit')},
{combos = {{key = 'Num5', reformers = {'RShift'}}}, down = iCommandViewCameraCenter, name = _('Center camera view'), category = _('View Cockpit')},
{combos = {{key = 'Num5', reformers = {'RCtrl'}}}, down = iCommandViewCameraReturn, name = _('Return camera'), category = _('View Cockpit')},
{combos = {{key = 'Num5', reformers = {'RAlt'}}}, down = iCommandViewCameraBaseReturn, name = _('Return camera base'), category = _('View Cockpit')},

{combos = {{key = 'Num0', reformers = {'LWin'}}}, down = iCommandViewSnapView0, up = iCommandViewSnapViewStop, name = _('Snap View 0'), category = _('View Cockpit')},
{combos = {{key = 'Num1', reformers = {'LWin'}}}, down = iCommandViewSnapView1, up = iCommandViewSnapViewStop, name = _('Snap View 1'), category = _('View Cockpit')},
{combos = {{key = 'Num2', reformers = {'LWin'}}}, down = iCommandViewSnapView2, up = iCommandViewSnapViewStop, name = _('Snap View 2'), category = _('View Cockpit')},
{combos = {{key = 'Num3', reformers = {'LWin'}}}, down = iCommandViewSnapView3, up = iCommandViewSnapViewStop, name = _('Snap View 3'), category = _('View Cockpit')},
{combos = {{key = 'Num4', reformers = {'LWin'}}}, down = iCommandViewSnapView4, up = iCommandViewSnapViewStop, name = _('Snap View 4'), category = _('View Cockpit')},
{combos = {{key = 'Num5', reformers = {'LWin'}}}, down = iCommandViewSnapView5, up = iCommandViewSnapViewStop, name = _('Snap View 5'), category = _('View Cockpit')},
{combos = {{key = 'Num6', reformers = {'LWin'}}}, down = iCommandViewSnapView6, up = iCommandViewSnapViewStop, name = _('Snap View 6'), category = _('View Cockpit')},
{combos = {{key = 'Num7', reformers = {'LWin'}}}, down = iCommandViewSnapView7, up = iCommandViewSnapViewStop, name = _('Snap View 7'), category = _('View Cockpit')},
{combos = {{key = 'Num8', reformers = {'LWin'}}}, down = iCommandViewSnapView8, up = iCommandViewSnapViewStop, name = _('Snap View 8'), category = _('View Cockpit')},
{combos = {{key = 'Num9', reformers = {'LWin'}}}, down = iCommandViewSnapView9, up = iCommandViewSnapViewStop, name = _('Snap View 9'), category = _('View Cockpit')},

{combos = {{key = 'F1', reformers = {'LWin'}}} , down = iCommandViewPitHeadOnOff, name = _('Head shift movement on / off'), category = _('View Cockpit')},

{combos = {{key = 'Num/', reformers = {'RShift'}}}, pressed = iCommandViewBack, up = iCommandViewBackStop, name = _('Zoom out'), category = _('View Cockpit')},
{combos = {{key = 'Num*', reformers = {'RShift'}}}, pressed = iCommandViewForward, up = iCommandViewForwardStop, name = _('Zoom in'), category = _('View Cockpit')},

-- Cockpit Camera Motion (Передвижение камеры в кабине)
{combos = {{key = 'Num8', reformers = {'RCtrl','RShift'}}}, pressed = iCommandViewPitCameraMoveUp, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Up'), category = _('View Cockpit')},
{combos = {{key = 'Num2', reformers = {'RCtrl','RShift'}}}, pressed = iCommandViewPitCameraMoveDown, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Down'), category = _('View Cockpit')},
{combos = {{key = 'Num4', reformers = {'RCtrl','RShift'}}}, pressed = iCommandViewPitCameraMoveLeft, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Left'), category = _('View Cockpit')},
{combos = {{key = 'Num6', reformers = {'RCtrl','RShift'}}}, pressed = iCommandViewPitCameraMoveRight, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Right'), category = _('View Cockpit')},
{combos = {{key = 'Num*', reformers = {'RCtrl','RShift'}}}, pressed = iCommandViewPitCameraMoveForward, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Forward'), category = _('View Cockpit')},
{combos = {{key = 'Num/', reformers = {'RCtrl','RShift'}}, {key = 'Num-', reformers = {'RCtrl','RShift'}}}, pressed = iCommandViewPitCameraMoveBack, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Back'), category = _('View Cockpit')},
{combos = {{key = 'Num5', reformers = {'RCtrl','RShift'}}}, down = iCommandViewPitCameraMoveCenter, name = _('Cockpit Camera Move Center'), category = _('View Cockpit')},

{down = iCommand_ExplorationStart, name = _('Enable visual recon mode'), category = _('View Cockpit')},
{combos = {{key = 'F1', reformers = {'LShift'}}},  down = iCommandViewTransposeModeOn, up = iCommandViewTransposeModeOff, name = _('Camera transpose mode (press and hold)'), category = _('View Cockpit')},

-- External Cargo
{combos = {{key = 'L', reformers = {'RCtrl','RShift'}}},		down = iCommandExtCargoHook,																														name = _('External Cargo Hook'),				category = _("External Cargo")},
{combos = {{key = 'K', reformers = {'RCtrl','RShift'}}},		down = iCommandExternalCargoAutounhook,																												name = _('External Cargo Autounhook'),			category = _("External Cargo")},
{combos = {{key = 'P', reformers = {'RCtrl','RShift'}}},		down = iCommandExternalCargoIndicator,																												name = _('External Cargo Indicator'),			category = _("External Cargo")},
{combos = {{key = ';', reformers = {'RCtrl','RShift'}}},		down = device_commands.Button_5, up = device_commands.Button_5, cockpit_device_id = devices.EXT_CARGO_EQUIPMENT, value_down = 1, value_up = 0,		name = _('External Cargo Unhook'),				category = _("External Cargo")},
-- View Extended
{combos = {{key = 'J', reformers = {'LShift'}}}, down = iCommandViewCameraJiggle, name = _('Camera jiggle toggle'), category = _('View Extended')},
{combos = {{key = 'K', reformers = {'LAlt'}}}, down = iCommandViewKeepTerrain, name = _('Keep terrain camera altitude'), category = _('View Extended')},
{combos = {{key = 'Num+', reformers = {'RCtrl'}}}, down = iCommandViewPlus, name = _('Toggle tracking launched weapon'), category = _('View Extended')},
{combos = {{key = 'F', reformers = {'RCtrl','RShift','RAlt'}}}, down = iCommandViewFriends, name = _('View friends mode'), category = _('View Extended')},
{combos = {{key = 'D', reformers = {'RCtrl','RShift','RAlt'}}}, down = iCommandViewEnemies, name = _('View enemies mode'), category = _('View Extended')},
{combos = {{key = 'A', reformers = {'RCtrl','RShift','RAlt'}}}, down = iCommandViewAll, name = _('View all mode'), category = _('View Extended')},

-- View Padlock
{combos = {{key = 'Num.'}}, down = iCommandViewLock, name = _('Lock view (cycle padlock)'), category = _('View Padlock')},
{combos = {{key = 'NumLock'}}, down = iCommandViewUnlock, name = _('Unlock view (stop padlock)'), category = _('View Padlock')},
{combos = {{key = 'Num.', reformers = {'RShift'}}}, down = iCommandAllMissilePadlock, name = _('All missiles padlock'), category = _('View Padlock')},
{combos = {{key = 'Num.', reformers = {'RAlt'}}}, down = iCommandThreatMissilePadlock, name = _('Threat missile padlock'), category = _('View Padlock')},
{combos = {{key = 'Num.', reformers = {'RCtrl'}}}, down = iCommandViewTerrainLock, name = _('Lock terrain view'), category = _('View Padlock')},

-- Labels
{combos = {{key = 'F10', reformers = {'LShift'}}}, down = iCommandMarkerState, name = _('All Labels'), category = _('Labels')},
{combos = {{key = 'F2', reformers = {'LShift'}}}, down = iCommandMarkerStatePlane, name = _('Aircraft Labels'), category = _('Labels')},
{combos = {{key = 'F6', reformers = {'LShift'}}}, down = iCommandMarkerStateRocket, name = _('Missile Labels'), category = _('Labels')},
{combos = {{key = 'F9', reformers = {'LShift'}}}, down = iCommandMarkerStateShip, name = _('Vehicle & Ship Labels'), category = _('Labels')},

--MainPanel
{combos = {{key = 'P', reformers = {'LShift', 'LCtrl', 'LAlt'}}}, down = device_commands.Button_2, up = device_commands.Button_2, cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 1.0, value_up = 0.0, name = _('Fuel Indicator Test'), category = _('Main Panel')},
{combos = {{key = 'T', reformers = {'RCtrl'}}}, down = device_commands.Button_23, up = device_commands.Button_23, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 1.0, value_up = 0.0, name = _('Fire Detector Test'), category = _("Main Panel")},

---Pedestal
{combos = {{key = 'F'}}, down = device_commands.Button_3, cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 0.0, name = _('Main Fuel Switch'), category = _('Pedestal')},
{combos = {{key = 'I'}}, down = device_commands.Button_17, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 0.0, name = _('De-Ice Switch'), category = _('Pedestal')},
{combos = {{key = 'G'}}, down = device_commands.Button_16, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 0.0, name = _('Governor Auto/Emer'), category = _('Pedestal')},
{combos = {{key = 'W', reformers = {'RCtrl'}}}, down = device_commands.Button_22, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 1.0, name = _('Low RPM Warning Switch'), category = _('Pedestal')},

{combos = {{key = 'R'}}, down = device_commands.Button_3, up = device_commands.Button_3, cockpit_device_id = devices.SYS_CONTROLLER, value_down = 1.0, value_up = 0.0, name = _('Caution Panel Test/Reset Switch Reset'), category = _('Pedestal')},
{combos = {{key = 'R',   reformers = {'LAlt'}}}, down = device_commands.Button_3, up = device_commands.Button_3, cockpit_device_id = devices.SYS_CONTROLLER, value_down = -1.0, value_up = 0.0, name = _('Caution Panel Test/Reset Switch Test'), category = _('Pedestal')},
{combos = {{key = 'F',   reformers = {'LAlt'}}}, down = device_commands.Button_4, up = device_commands.Button_4, cockpit_device_id = devices.SYS_CONTROLLER, value_down = 1.0, value_up = 0.0, name = _('Caution Panel Dim Switch Bright'), category = _('Pedestal')},
{combos = {{key = 'F',   reformers = {'LCtrl'}}}, down = device_commands.Button_4, up = device_commands.Button_4, cockpit_device_id = devices.SYS_CONTROLLER, value_down = -1.0, value_up = 0.0, name = _('Caution Panel Dim Switch Dim'), category = _('Pedestal')},

-- Ins Cyclick Stick
{combos = {{key = 'Space'}}, down = iCommandPlaneFire, up = iCommandPlaneFire, value_down = 1, value_up = 0, name = _('Pilot weapon release/Machinegun fire'), category = _('Ins Cyclic Stick')},
{combos = {{key = 'Space',   reformers = {'RAlt'}}}, down = iCommandPlanePickleOn, up = iCommandPlanePickleOn, value_down = 1, value_up = 0, name = _('Copilot weapon release'), category = _('Ins Cyclic Stick')},

{combos = {{key = 'Up'}},    pressed = iCommandPlaneUpStart    , up = iCommandPlaneUpStop  ,   name = _('Cyclic nose down'), category = _('Ins Cyclic Stick')},
{combos = {{key = 'Down'}},  pressed = iCommandPlaneDownStart  , up = iCommandPlaneDownStop,   name = _('Cyclic nose up'), category = _('Ins Cyclic Stick')},
{combos = {{key = 'Left'}},  pressed = iCommandPlaneLeftStart  , up = iCommandPlaneLeftStop,   name = _('Cyclic bank left'), category = _('Ins Cyclic Stick')},
{combos = {{key = 'Right'}}, pressed = iCommandPlaneRightStart , up = iCommandPlaneRightStop,  name = _('Cyclic bank right'), category = _('Ins Cyclic Stick')},

{combos = {{key = '\\', 	 reformers = {'RAlt'}}}, down = device_commands.Button_9, up = device_commands.Button_9, cockpit_device_id  = devices.INTERCOM, value_down = 1.0, value_up = 0.0, name = _("Pilot's radio trigger RADIO (call radio menu)"), category = _('Ins Cyclic Stick')},
{combos = {{key = 'Space',   reformers = {'RShift'}}}, down = device_commands.Button_9, up = device_commands.Button_9, cockpit_device_id = devices.INTERCOM, value_down = 0.5, value_up = 0.0, name = _("Pilot's radio trigger ICS (call radio menu)"), category = _('Ins Cyclic Stick')},

{combos = {{key = 'Space',   reformers = {'LCtrl'}}}, down = device_commands.Button_10, up = device_commands.Button_10, cockpit_device_id = devices.INTERCOM, value_down = 1.0, value_up = 0.0, name = _("Co-pilot's radio trigger RADIO (call radio menu)"), category = _('Ins Cyclic Stick')},
{combos = {{key = 'Space',   reformers = {'LShift'}}}, down = device_commands.Button_10, up = device_commands.Button_10, cockpit_device_id = devices.INTERCOM, value_down = 0.5, value_up = 0.0, name = _("Co-pilot's radio trigger ICS (call radio menu)"), category = _('Ins Cyclic Stick')},

-- VoIP radio global command
-- in case you need to open commands in the cockpit
-- global commands
{	down = iCommandVoIPRadioPushToTalkEnableDisableVoice, up = iCommandVoIPRadioPushToTalkEnableDisableVoice, value_down = 1.0, value_up = 0.0, name = _("radio trigger RADIO (VOIP)"),	category = _('Ins Cyclic Stick')},
{	down = iCommandVoIPIntercomPushToTalkEnableDisableVoice, up = iCommandVoIPIntercomPushToTalkEnableDisableVoice, value_down = 0.5, value_up = 0.0, name = _("radio trigger ICS (VOIP)"),		category = _('Ins Cyclic Stick')},
-- old local commands
-- {	down = device_commands.Button_18, up = device_commands.Button_18, cockpit_device_id = devices.INTERCOM, value_down = 1.0, value_up = 0.0, name = _("radio trigger RADIO (VOIP)"),	category = _('Ins Cyclic Stick')},
-- {	down = device_commands.Button_18, up = device_commands.Button_18, cockpit_device_id = devices.INTERCOM, value_down = 0.5, value_up = 0.0, name = _("radio trigger ICS (VOIP)"),		category = _('Ins Cyclic Stick')},

{combos = {{key = 'T'}},  down = device_commands.Button_4, up = device_commands.Button_4, cockpit_device_id = devices.CONTROL_SYSTEM, value_down = 1.0, value_up = 0.0, name = _('Pilot Trimmer'), category = _('Ins Cyclic Stick')},
{combos = {{key = 'T', reformers = {'LCtrl'}}}, down = device_commands.Button_3, cockpit_device_id = devices.CONTROL_SYSTEM, value_down = 1.0, name = _('Trimmer reset'), category = _('Ins Cyclic Stick')},

-- Flexible sight
{combos = {{key = 'M'}}, down = device_commands.Button_5, cockpit_device_id = devices.FLEX_SIGHT, value_down = 0.0, name = _('Toggle Flexible Sight'), category = _('Flexible Sight')},
{combos = {{key = 'O', reformers = {'RAlt'}}}, pressed = device_commands.Button_2, cockpit_device_id = devices.FLEX_SIGHT, value_pressed = -0.5, name = _('Flexible Sight Intensity Decrease'), category = _('Flexible Sight')},
{combos = {{key = 'O', reformers = {'RCtrl'}}}, pressed = device_commands.Button_2, cockpit_device_id = devices.FLEX_SIGHT, value_pressed = 0.5, name = _('Flexible Sight Intensity Increase'), category = _('Flexible Sight')},
{combos = {{key = 'O'}}, down = device_commands.Button_3, cockpit_device_id = devices.FLEX_SIGHT, value_down = 1.0, name = _('Flexible Sight Main Lamp'), category = _('Flexible Sight')},
{combos = {{key = 'O', reformers = {'RCtrl','RShift'}}}, down = device_commands.Button_3, cockpit_device_id = devices.FLEX_SIGHT, value_down = 0.0, name = _('Flexible Sight Lamp Off'), category = _('Flexible Sight')},
{combos = {{key = 'O', reformers = {'RAlt','RCtrl'}}}, down = device_commands.Button_3, cockpit_device_id = devices.FLEX_SIGHT, value_down = -1.0, name = _('Flexible Sight Backup Lamp'), category = _('Flexible Sight')},

{combos = {{key = 'M', reformers = {'RShift'}}}, down = device_commands.Button_5, cockpit_device_id = devices.PILOT_SIGHT, value_down = 0.0, name = _('Pilot Sight Armed/Docked'), category = _('Pilot Sight')},
{combos = {{key = 'M', reformers = {'RCtrl'}}}, down = device_commands.Button_7, cockpit_device_id = devices.PILOT_SIGHT, value_down = 1.0, name = _('Pilot Sight Switch'), category = _('Pilot Sight')},
{combos = {{key = 'X', reformers = {'LAlt'}}}, pressed = device_commands.Button_2, cockpit_device_id = devices.PILOT_SIGHT, value_pressed = -0.5, name = _('Pilot Sight Intensity Decrease'), category = _('Pilot Sight')},
{combos = {{key = 'X', reformers = {'LCtrl'}}}, pressed = device_commands.Button_2, cockpit_device_id = devices.PILOT_SIGHT, value_pressed = 0.5, name = _('Pilot Sight Intensity Increase'), category = _('Pilot Sight')},
{combos = {{key = 'S', reformers = {'LAlt'}}}, pressed = device_commands.Button_4, cockpit_device_id = devices.PILOT_SIGHT, value_pressed = -0.5, name = _('Pilot Sight Elevation Decrease'), category = _('Pilot Sight')},
{combos = {{key = 'S', reformers = {'LCtrl'}}}, pressed = device_commands.Button_4, cockpit_device_id = devices.PILOT_SIGHT, value_pressed = 0.5, name = _('Pilot Sight Elevation Increase'), category = _('Pilot Sight')},


-- Weapon System
{combos = {{key = ']', reformers = {'RShift'}}}, down = device_commands.Button_20, cockpit_device_id = devices.WEAPON_SYS, value_down = 1.0, name = _('Armament Off/Safe/Armed Up'), category = _('Armament System')},
{combos = {{key = '[', reformers = {'RShift'}}}, down = device_commands.Button_20, cockpit_device_id = devices.WEAPON_SYS, value_down = -1.0, name = _('Armament Off/Safe/Armed Down'), category = _('Armament System')},
{combos = {{key = ']', reformers = {'RAlt'}}}, down = device_commands.Button_21, cockpit_device_id = devices.WEAPON_SYS, value_down = 1.0, name = _('Armament Selector Up'), category = _('Armament System')},
{combos = {{key = '[', reformers = {'RAlt'}}}, down = device_commands.Button_21, cockpit_device_id = devices.WEAPON_SYS, value_down = -1.0, name = _('Armament Selector Down'), category = _('Armament System')},
{combos = {{key = ']', reformers = {'RCtrl'}}}, down = device_commands.Button_22, cockpit_device_id = devices.WEAPON_SYS, value_down = 1.0, name = _('Rocket Pair Increase'), category = _('Armament System')},
{combos = {{key = '[', reformers = {'RCtrl'}}}, down = device_commands.Button_22, cockpit_device_id = devices.WEAPON_SYS, value_down = -1.0, name = _('Rocket Pair Decrease'), category = _('Armament System')},
{combos = {{key = 'J'}}, down = device_commands.Button_23, up = device_commands.Button_23, cockpit_device_id = devices.WEAPON_SYS, value_down = 1.0, value_up = 0.0, name = _('Jettison Switch'), category = _('Armament System')},
{combos = {{key = 'J', reformers = {'LAlt'}}}, down = device_commands.Button_25, cockpit_device_id = devices.WEAPON_SYS, value_down = 0.0, name = _('Jettison Switch Cover'), category = _('Armament System')},
{combos = {{key = 'R', reformers = {'LCtrl'}}}, down = device_commands.Button_12, up = device_commands.Button_12, cockpit_device_id = devices.WEAPON_SYS, value_down = 1.0, value_up = 0.0, name = _('Rocket Reset Button'), category = _('Armament System')},
{combos = {{key = ']', reformers = {'RAlt', 'RCtrl'}}}, down = device_commands.Button_24, cockpit_device_id = devices.WEAPON_SYS, value_down = 1.0, name = _('Gun Selector Switch Up'), category = _('Armament System')},
{combos = {{key = '[', reformers = {'RAlt', 'RCtrl'}}}, down = device_commands.Button_24, cockpit_device_id = devices.WEAPON_SYS, value_down = -1.0, name = _('Gun Selector Switch Down'), category = _('Armament System')},
{combos = {{key = 'A', reformers = {'LWin'}}}, down = device_commands.Button_26, cockpit_device_id = devices.WEAPON_SYS, value_down = 1.0, name = _('AutoPilot'), category = _('Cheat')},
{combos = {{key = 'H', reformers = {'LCtrl','LShift'}}}, down = device_commands.Button_27, cockpit_device_id = devices.WEAPON_SYS, value_down = 1.0, name = _('Toggle Weapon Hints'), category = _('Cheat')},
{combos = {{key = 'A', reformers = {'LShift', 'LAlt'}}}, down = device_commands.Button_28, cockpit_device_id = devices.WEAPON_SYS, value_down = 1.0, name = _('AutoPilot ATTITUDE HOLD'), category = _('Cheat')},
{combos = {{key = 'A', reformers = {'LCtrl'}}}, down = device_commands.Button_29, cockpit_device_id = devices.WEAPON_SYS, value_down = 1.0, name = _('AutoPilot LEVEL FLIGHT'), category = _('Cheat')},
{combos = {{key = 'A', reformers = {'LAlt'}}}, down = device_commands.Button_30, cockpit_device_id = devices.WEAPON_SYS, value_down = 1.0, name = _('AutoPilot ORBIT'), category = _('Cheat')},

{combos = {{key = '4', reformers = {'LAlt'}}}, down = device_commands.Button_35, cockpit_device_id = devices.WEAPON_SYS, value_down = 1.0, name = _('Open/Close Right Gunner Door'), category = _('Armament System')},
{combos = {{key = '3', reformers = {'LAlt'}}}, down = device_commands.Button_36, cockpit_device_id = devices.WEAPON_SYS, value_down = 1.0, name = _('Open/Close Left Gunner Door'), category = _('Armament System')},

-- Ins Collective Stick
{combos = {{key = 'Num+'}}, down = iCommandPlaneCollectiveIncrease, pressed = iCommandPlaneCollectiveIncrease, up = iCommandPlaneCollectiveStop, name = _('Collective up'), category = _('Ins Collective Stick')},
{combos = {{key = 'Num-'}}, down = iCommandPlaneCollectiveDecrease, pressed = iCommandPlaneCollectiveDecrease, up = iCommandPlaneCollectiveStop, name = _('Collective down'), category = _('Ins Collective Stick')},

{combos = {{key = 'PageUp'}}	, pressed = device_commands.Button_25,	cockpit_device_id = devices.ENGINE_INTERFACE, value_pressed = 1.0,	name = _('Throttle Up'), category = _('Ins Collective Stick')},
{combos = {{key = 'PageDown'}}	, pressed = device_commands.Button_25,	cockpit_device_id = devices.ENGINE_INTERFACE, value_pressed = -1.0,	name = _('Throttle Down'), category = _('Ins Collective Stick')},
{combos = {{key = 'T', reformers = {'RWin'}}}	, down = device_commands.Button_28,	cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 1.0,	name = _('Throttle Stop Switch'), category = _('Ins Collective Stick')},

--SearchLight Control
{combos = {{key = '7'}}, 		down = iCommandPlane_SpotLight_up, up = iCommandPlane_SpotLight_vert_stop, name = _('Search light Retract'), category = _('Ins Collective Stick')},
{combos = {{key = '8'}}, 		down = iCommandPlane_SpotLight_down, up = iCommandPlane_SpotLight_vert_stop, name = _('Search light Extend'),  category = _('Ins Collective Stick')},
{combos = {{key = '9'}}, 		down = iCommandPlane_SpotLight_left, up = iCommandPlane_SpotLight_vert_stop, name = _('Search light Left'),  category = _('Ins Collective Stick')},
{combos = {{key = '0'}}, 		down = iCommandPlane_SpotLight_right, up = iCommandPlane_SpotLight_vert_stop, name = _('Search light Right'), category = _('Ins Collective Stick')},

--LandingLight Control
{combos = {{key = ',', reformers = {'RCtrl'}}}, down = device_commands.Button_12, cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_down = 1.0, name = _('Landing Light Switch'), category = _('Ins Collective Stick')},

{combos = {{key = '/', reformers = {'RCtrl'}}}, down = device_commands.Button_38, cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_down = 1.0, name = _('Landing light Extend'), category = _('Ins Collective Stick')},
{combos = {{key = '/', reformers = {'RAlt'}}}, down = device_commands.Button_38, cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_down = 0.0, name = _('Landing light Stop'), category = _('Ins Collective Stick')},
{combos = {{key = '/', reformers = {'RWin'}}}, down = device_commands.Button_38, cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_down = -1.0, name = _('Landing light Retract'), category = _('Ins Collective Stick')},

{combos = {{key = ';', reformers = {'RCtrl'}}}, down = device_commands.Button_37, cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_down = 1.0, name = _('Search light On'), category = _('Ins Collective Stick')},
{combos = {{key = ';', reformers = {'RAlt'}}}, down = device_commands.Button_37, cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_down = 0.0, name = _('Search light Off'), category = _('Ins Collective Stick')},
{combos = {{key = ';', reformers = {'RWin'}}}, down = device_commands.Button_37, cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_down = -1.0, name = _('Search light Stow'), category = _('Ins Collective Stick')},
--{combos = {{key = ';', reformers = {'RCtrl'}}}, 			pressed = device_commands.Button_12, cockpit_device_id = 12, value_pressed = 0.05, name = _('Trim Elevator Down'), category = _('Flight Control')},

{combos = {{key = 'Home'}}, down = device_commands.Button_18, up = device_commands.Button_18, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 1.0, value_up = 0.0, name = _('Start-up engine'), category = _('Ins Collective Stick')},

{combos = {{key = 'PageUp', reformers = {'RCtrl'}}}, down = device_commands.Button_19, up = device_commands.Button_19, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 1.0, value_up = 0.0, name = _('Increase Turbine RPM'), category = _('Ins Collective Stick')},
{combos = {{key = 'PageDown', reformers = {'RCtrl'}}}, down = device_commands.Button_19, up = device_commands.Button_19, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = -1.0, value_up = 0.0, name = _('Decrease Turbine RPM'), category = _('Ins Collective Stick')},

--Ins Rudder
{combos = {{key = 'Z'}}, down = iCommandPlaneLeftRudderStart, up = iCommandPlaneLeftRudderStop, name = _('Rudder left'), category = _('Ins Rudder')},
{combos = {{key = 'X'}}, down = iCommandPlaneRightRudderStart, up = iCommandPlaneRightRudderStop, name = _('Rudder right'), category = _('Ins Rudder')},

-- Ins Overhead panel (Верхняя панель)

{combos = {{key = 'L', reformers = {'RAlt'}}}, 		down = device_commands.Button_13, cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_down = 1.0, name = _('Nav Lights Dim/Bright'), category = _('Ins Overhead panel')},
{combos = {{key = 'L', reformers = {'RCtrl'}}}, 	down = device_commands.Button_2, cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_down = 0.0, name = _('Nav Lights Off'), category = _('Ins Overhead panel')},
{combos = {{key = 'L', reformers = {'RAlt', 'RWin'}}}, 		down = device_commands.Button_2, cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_down = 1.0, name = _('Nav Lights Steady'), category = _('Ins Overhead panel')},
{combos = {{key = 'L', reformers = {'RCtrl', 'RWin'}}}, 	down = device_commands.Button_2, cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_down = -1.0, name = _('Nav Lights Flash'), category = _('Ins Overhead panel')},
{combos = {{key = 'L', reformers = {'RShift'}}}, 	down = device_commands.Button_14, cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_down = 1.0, name = _('Anti Collision Light Switch'), category = _('Ins Overhead panel')},

{combos = {{key = 'L', reformers = {'RAlt', 'RShift'}}}, down = device_commands.Button_21, cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_down = -1.0, name = _('Dome Light Green'), category = _('Ins Overhead panel')},
{combos = {{key = 'O', reformers = {'RAlt', 'RShift'}}}, down = device_commands.Button_21, cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_down = 0.0, name = _('Dome Light Off'), category = _('Ins Overhead panel')},
{combos = {{key = 'P', reformers = {'RAlt', 'RShift'}}}, down = device_commands.Button_21, cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_down = 1.0, name = _('Dome Light White'), category = _('Ins Overhead panel')},

{combos = {{key = 'O', reformers = {'LAlt','LWin'}}},  pressed = device_commands.Button_22,cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_pressed = -0.4, name = _('Overhead Console Light Decrease'), category = _("Ins Overhead panel")},
{combos = {{key = 'O', reformers = {'LCtrl','LWin'}}}, pressed = device_commands.Button_22,cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_pressed = 0.4,  name = _('Overhead Console Light Increase'), category = _("Ins Overhead panel")},

{combos = {{key = 'P', reformers = {'LAlt','LWin'}}},  pressed = device_commands.Button_23,cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_pressed = -0.4, name = _('Pedestal Light Decrease'), category = _("Ins Overhead panel")},
{combos = {{key = 'P', reformers = {'LCtrl','LWin'}}}, pressed = device_commands.Button_23,cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_pressed = 0.4,  name = _('Pedestal Light Increase'), category = _("Ins Overhead panel")},

{combos = {{key = 'S', reformers = {'LAlt','LWin'}}},  pressed = device_commands.Button_24,cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_pressed = -0.4, name = _('Secondary Instrument Light Decrease'), category = _("Ins Overhead panel")},
{combos = {{key = 'S', reformers = {'LCtrl','LWin'}}}, pressed = device_commands.Button_24,cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_pressed = 0.4,  name = _('Secondary Instrument Light Increase'), category = _("Ins Overhead panel")},

{combos = {{key = 'E', reformers = {'LAlt','LWin'}}},  pressed = device_commands.Button_25,cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_pressed = -0.4, name = _('Engine Instrument Light Decrease'), category = _("Ins Overhead panel")},
{combos = {{key = 'E', reformers = {'LCtrl','LWin'}}}, pressed = device_commands.Button_25,cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_pressed = 0.4,  name = _('Engine Instrument Light Increase'), category = _("Ins Overhead panel")},

{combos = {{key = 'C', reformers = {'LAlt','LWin'}}},  pressed = device_commands.Button_26,cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_pressed = -0.4, name = _('Copilot Instrument Light Decrease'), category = _("Ins Overhead panel")},
{combos = {{key = 'C', reformers = {'LCtrl','LWin'}}}, pressed = device_commands.Button_26,cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_pressed = 0.4,  name = _('Copilot Instrument Light Increase'), category = _("Ins Overhead panel")},

{combos = {{key = 'P', reformers = {'LAlt','LCtrl','LWin'}}},   pressed = device_commands.Button_27,cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_pressed = -0.4, name = _('Pilot Instrument Light Decrease'), category = _("Ins Overhead panel")},
{combos = {{key = 'P', reformers = {'LCtrl','LShift','LWin'}}}, pressed = device_commands.Button_27,cockpit_device_id = devices.NAVLIGHT_SYSTEM, value_pressed = 0.4,  name = _('Pilot Instrument Light Increase'), category = _("Ins Overhead panel")},

----

{combos = {{key = 'L', reformers = {'LShift'}}},down = device_commands.Button_20, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1.0, name = _('Main Generator Cover'), category = _('Ins Overhead panel')},
{combos = {{key = 'Q', reformers = {'LShift'}}},down = device_commands.Button_10, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1.0, name = _('Main Generator Switch'), category = _('Ins Overhead panel')},
{combos = {{key = 'A', reformers = {'LShift'}}},down = device_commands.Button_2, up = device_commands.Button_2, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1.0, value_up = 0.0, name = _('Main generator RESET'), category = _('Ins Overhead panel')},
{combos = {{key = 'P', reformers = {'LShift'}}},down = device_commands.Button_9, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1.0, name = _('Battery Switch'), category = _('Ins Overhead panel')},
{combos = {{key = 'X', reformers = {'LShift'}}},down = device_commands.Button_11, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1.0, name = _('Starter-Generator STARTER/STBY GEN'), category = _('Ins Overhead panel')},
{combos = {{key = 'C', reformers = {'LShift'}}},down = device_commands.Button_12, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1.0, name = _('Non-Ess Bus NORMAL ON/MANUAL ON'), category = _('Ins Overhead panel')},

{combos = {{key = 'Y', reformers = {'LShift'}}},down = device_commands.Button_15, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1.0, name = _('Inverter switch'), category = _('Ins Overhead panel')},
{combos = {{key = 'O', reformers = {'LShift'}}},down = device_commands.Button_8, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1.0, name = _('Inverter SPARE ON'), category = _('Ins Overhead panel')},
{combos = {{key = 'I', reformers = {'LShift'}}},down = device_commands.Button_8, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.0, name = _('Inverter OFF'), category = _('Ins Overhead panel')},
{combos = {{key = 'U', reformers = {'LShift'}}},down = device_commands.Button_8, cockpit_device_id = devices.ELEC_INTERFACE, value_down = -1.0, name = _('Inverter MAIN ON'), category = _('Ins Overhead panel')},

{combos = {{key = 'W', reformers = {'LShift'}}},down = device_commands.Button_13, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1.0, name = _('Voltmeter AC switch'), category = _('Ins Overhead panel')},
{combos = {{key = 'E', reformers = {'LShift'}}},down = device_commands.Button_7, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.0, name = _('Voltmeter AC, AB phase'), category = _('Ins Overhead panel')},
{combos = {{key = 'R', reformers = {'LShift', 'LAlt'}}},down = device_commands.Button_7, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.1, name = _('Voltmeter AC, AC phase'), category = _('Ins Overhead panel')},
{combos = {{key = 'T', reformers = {'LShift'}}},down = device_commands.Button_7, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.2, name = _('Voltmeter AC, BC phase'), category = _('Ins Overhead panel')},

{combos = {{key = 'S', reformers = {'LShift'}}},down = device_commands.Button_14, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1.0, name = _('Voltmeter DC switch'), category = _('Ins Overhead panel')},
{combos = {{key = 'D', reformers = {'LShift'}}},down = device_commands.Button_4, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.0, name = _('Voltmeter DC, BAT'), category = _('Ins Overhead panel')},
{combos = {{key = 'F', reformers = {'LShift'}}},down = device_commands.Button_4, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.1, name = _('Voltmeter DC, MAIN GEN'), category = _('Ins Overhead panel')},
{combos = {{key = 'G', reformers = {'LShift'}}},down = device_commands.Button_4, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.2, name = _('Voltmeter DC, STBY GEN'), category = _('Ins Overhead panel')},
{combos = {{key = 'H', reformers = {'LShift'}}},down = device_commands.Button_4, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.3, name = _('Voltmeter DC, ESS BUS'), category = _('Ins Overhead panel')},
{combos = {{key = 'K', reformers = {'LShift'}}},down = device_commands.Button_4, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.4, name = _('Voltmeter DC, NON-ESS BUS'), category = _('Ins Overhead panel')},

{combos = {{key = 'P', reformers = {'RAlt'}}},down = device_commands.Button_17, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.0, name = _('Pitot Heater Switch'), category = _('Ins Overhead panel')},

-- Systems
{combos = {{key = 'C', reformers = {'RCtrl'}}}, down = iCommandPlaneFonar, name = _('Cockpit door open/close'), category = _('Systems')},
--{combos = {{key = 'H' , reformers = {'LWin'}}} , down = iCommandPlane_CallHelpWindow, name = _('Checklists') , category = _('Systems')},

{combos = {{key = 'T', reformers = {'LAlt'}}}, down = device_commands.Button_13, up = device_commands.Button_13, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 1.0, value_up = 0.0, name = _('Chip detector XMSN'), category = _('Systems')}, 
{combos = {{key = 'B', reformers = {'LWin'}}}, down = device_commands.Button_13, up = device_commands.Button_13, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = -1.0,value_up = 0.0, name = _('Chip detector TAIL ROTOR'), category = _('Systems')}, 

{combos = {{key = 'U', reformers = {'LAlt'}}}, down = device_commands.Button_6, cockpit_device_id = devices.HYDRO_SYS_INTERFACE, value_down = 1.0,name = _('Force Trim Switch'), category = _('Systems')}, 
{combos = {{key = 'I', reformers = {'LAlt'}}}, down = device_commands.Button_5, cockpit_device_id = devices.HYDRO_SYS_INTERFACE, value_down = 1.0,name = _('Hydraulic Control Switch'), category = _('Systems')}, 

-- Radio Communications
{combos = {{key = '\\'}}, down = iCommandToggleCommandMenu, name = _('Communication menu'), category = _('Radio Communications')},
{combos = {{key = 'E', reformers = {'LWin'}}}, down = iCommandPlaneDoAndHome, name = _('Flight - Complete mission and RTB'), category = _('Radio Communications')},
--{combos = {{key = 'R', reformers = {'LWin'}}}, down = iCommandPlaneDoAndBack, name = _('Flight - Complete mission and rejoin'), category = _('Radio Communications')},
{combos = {{key = 'T', reformers = {'LWin'}}}, down = iCommandPlaneFormation, name = _('Toggle formation'), category = _('Radio Communications')},
{combos = {{key = 'Y', reformers = {'LWin'}}}, down = iCommandPlaneJoinUp, name = _('Join up formation'), category = _('Radio Communications')},
{combos = {{key = 'Q', reformers = {'LWin'}}}, down = iCommandPlaneAttackMyTarget, name = _('Attack my target'), category = _('Radio Communications')},
{combos = {{key = 'W', reformers = {'LWin'}}}, down = iCommandPlaneCoverMySix, name = _('Cover me'), category = _('Radio Communications')},
{combos = {{key = 'G', reformers = {'LWin'}}}, down = iCommandPlane_EngageGroundTargets, name = _('Flight - Attack ground targets'), category = _('Radio Communications')},
{combos = {{key = 'D', reformers = {'LWin'}}}, down = iCommandPlane_EngageAirDefenses, name = _('Flight - Attack air defenses'), category = _('Radio Communications')},
{combos = {{key = '\\', reformers = {'LShift'}}}, down = ICommandSwitchDialog, name = _('Switch dialog'), category = _('Radio Communications')},

--AN/ARN-82
{combos = {{key = '`', reformers = {'LShift','LAlt'}}}, down = device_commands.Button_8, cockpit_device_id = devices.ARN_82, value_down = 1.0, name = _('VOR/ILS Mode Select (totary)'), category = _("VOR/ILS Control panel")},
{combos = {{key = '1', reformers = {'LShift','LAlt'}}}, down = device_commands.Button_3, cockpit_device_id = devices.ARN_82, value_down = 0.8,	name = _('VOR/ILS Power OFF'), 		category = _("VOR/ILS Control panel")},
{combos = {{key = '2', reformers = {'LShift','LAlt'}}}, down = device_commands.Button_3, cockpit_device_id = devices.ARN_82, value_down = 0.9, name = _('VOR/ILS Power PWR'), 		category = _("VOR/ILS Control panel")},
{combos = {{key = '3', reformers = {'LShift','LAlt'}}}, down = device_commands.Button_3, cockpit_device_id = devices.ARN_82, value_down = 1.0, name = _('VOR/ILS Power TEST'), 		category = _("VOR/ILS Control panel")},
{combos = {{key = 'O', reformers = {'LShift','LAlt'}}}, down = device_commands.Button_5, cockpit_device_id = devices.ARN_82, value_down = -1.0,name = _('VOR/ILS Freq. MHz Decrease'),category = _("VOR/ILS Control panel")},
{combos = {{key = 'P', reformers = {'LShift','LAlt'}}}, down = device_commands.Button_5, cockpit_device_id = devices.ARN_82, value_down = 1.0, name = _('VOR/ILS Freq. MHz Increase'),category = _("VOR/ILS Control panel")},
{combos = {{key = '[', reformers = {'LShift','LAlt'}}}, down = device_commands.Button_6, cockpit_device_id = devices.ARN_82, value_down = -1.0,name = _('VOR/ILS Freq. kHz Decrease'),category = _("VOR/ILS Control panel")},
{combos = {{key = ']', reformers = {'LShift','LAlt'}}}, down = device_commands.Button_6, cockpit_device_id = devices.ARN_82, value_down = 1.0,	name = _('VOR/ILS Freq. kHz Increase'),category = _("VOR/ILS Control panel")},
{combos = {{key = '-', reformers = {'LShift','LAlt'}}},pressed = device_commands.Button_7,cockpit_device_id = devices.ARN_82, value_pressed = -1.0,name = _('VOR/ILS Volume Decrease'), category = _("VOR/ILS Control panel")},
{combos = {{key = '=', reformers = {'LShift','LAlt'}}},pressed = device_commands.Button_7,cockpit_device_id = devices.ARN_82, value_pressed = 1.0,	name = _('VOR/ILS Volume Increase'), category = _("VOR/ILS Control panel")},

--AN/ARC-131
{combos = {{key = '9', reformers = {'LCtrl','LShift'}}}, down = device_commands.Button_6, cockpit_device_id = devices.VHF_ARC_134, value_down = 1, name = _('VHF AM Radio Power Switch'), 	category = _("VHF AM Radio Control panel")},
{combos = {{key = 'I', reformers = {'LCtrl','LShift'}}}, down = device_commands.Button_2, up=device_commands.Button_2, cockpit_device_id = devices.VHF_ARC_134, value_down = 1,value_up= 0,name = _('VHF AM Radio Test'),category = _("VHF AM Radio Control panel")},
{combos = {{key = 'O', reformers = {'LCtrl','LShift'}}}, down = device_commands.Button_8, cockpit_device_id = devices.VHF_ARC_134, value_down = -1.0,		name = _('VHF AM Radio Freq. MHz Decrease'), 	category = _("VHF AM Radio Control panel")},
{combos = {{key = 'P', reformers = {'LCtrl','LShift'}}}, down = device_commands.Button_8, cockpit_device_id = devices.VHF_ARC_134, value_down = 1.0, 		name = _('VHF AM Radio Freq. MHz Increase'), 	category = _("VHF AM Radio Control panel")},
{combos = {{key = '[', reformers = {'LCtrl','LShift'}}}, down = device_commands.Button_9, cockpit_device_id = devices.VHF_ARC_134, value_down = -1.0,		name = _('VHF AM Radio Freq. kHz Decrease'), 	category = _("VHF AM Radio Control panel")},
{combos = {{key = ']', reformers = {'LCtrl','LShift'}}}, down = device_commands.Button_9, cockpit_device_id = devices.VHF_ARC_134, value_down = 1.0,		name = _('VHF AM Radio Freq. kHz Increase'), 	category = _("VHF AM Radio Control panel")},
{combos = {{key = '-', reformers = {'LCtrl','LShift'}}},pressed = device_commands.Button_7,cockpit_device_id = devices.VHF_ARC_134, value_pressed = -1.0,	name = _('VHF AM Radio Volume Decrease'), 		category = _("VHF AM Radio Control panel")},
{combos = {{key = '=', reformers = {'LCtrl','LShift'}}},pressed = device_commands.Button_7,cockpit_device_id = devices.VHF_ARC_134, value_pressed = 1.0,	name = _('VHF AM Radio Volume Increase'), 		category = _("VHF AM Radio Control panel")},

--AN/ARC-134
{combos = {{key = '5', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_13, cockpit_device_id = devices.VHF_ARC_131, value_down = 1.0,		name = _('VHF FM Radio Squelch Select (rotary)'), category = _("VHF FM Radio Control panel")},
{combos = {{key = '6', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_5, 	cockpit_device_id = devices.VHF_ARC_131, value_down = 0.0,		name = _('VHF FM Radio Squelch DIS'), 	category = _("VHF FM Radio Control panel")},
{combos = {{key = '7', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_5, 	cockpit_device_id = devices.VHF_ARC_131, value_down = 0.1,		name = _('VHF FM Radio Squelch CARR'), category = _("VHF FM Radio Control panel")},
{combos = {{key = '8', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_5, 	cockpit_device_id = devices.VHF_ARC_131, value_down = 0.2,		name = _('VHF FM Radio Squelch TONE'), category = _("VHF FM Radio Control panel")},

{combos = {{key = '`', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_14, cockpit_device_id = devices.VHF_ARC_131, value_down = 1.0,		name = _('VHF FM Radio Mode Select (rotary)'), category = _("VHF FM Radio Control panel")},
{combos = {{key = '1', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_7, 	cockpit_device_id = devices.VHF_ARC_131, value_down = 0.0,		name = _('VHF FM Radio Mode OFF'), 	category = _("VHF FM Radio Control panel")},
{combos = {{key = '2', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_7, 	cockpit_device_id = devices.VHF_ARC_131, value_down = 0.1,		name = _('VHF FM Radio Mode TR'), 		category = _("VHF FM Radio Control panel")},
{combos = {{key = '3', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_7, 	cockpit_device_id = devices.VHF_ARC_131, value_down = 0.2,		name = _('VHF FM Radio Mode RETRAN'), category = _("VHF FM Radio Control panel")},
{combos = {{key = '4', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_7, 	cockpit_device_id = devices.VHF_ARC_131, value_down = 0.3,		name = _('VHF FM Radio Mode HOME'), 	category = _("VHF FM Radio Control panel")},

{combos = {{key = '-', reformers = {'RCtrl','RAlt'}}},pressed = device_commands.Button_8,cockpit_device_id = devices.VHF_ARC_131, value_pressed = -1.0,	name = _('VHF FM Radio Volume Decrease'), 	category = _("VHF FM Radio Control panel")},
{combos = {{key = '=', reformers = {'RCtrl','RAlt'}}},pressed = device_commands.Button_8,cockpit_device_id = devices.VHF_ARC_131, value_pressed = 1.0,	name = _('VHF FM Radio Volume Increase'), 	category = _("VHF FM Radio Control panel")},

{combos = {{key = 'U', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_12,	cockpit_device_id = devices.VHF_ARC_131, value_down = -1.0,		name = _('VHF FM Radio 50kHz Decrease'), category = _("VHF FM Radio Control panel")},
{combos = {{key = 'I', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_12,	cockpit_device_id = devices.VHF_ARC_131, value_down = 1.0, 		name = _('VHF FM Radio 50kHz Increase'), category = _("VHF FM Radio Control panel")},

{combos = {{key = 'T', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_11,	cockpit_device_id = devices.VHF_ARC_131, value_down = -1.0,		name = _('VHF FM Radio 100kHz Decrease'),category = _("VHF FM Radio Control panel")},
{combos = {{key = 'Y', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_11,	cockpit_device_id = devices.VHF_ARC_131, value_down = 1.0, 		name = _('VHF FM Radio 100kHz Increase'),category = _("VHF FM Radio Control panel")},

{combos = {{key = 'E', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_10,	cockpit_device_id = devices.VHF_ARC_131, value_down = -1.0,		name = _('VHF FM Radio 1MHz Decrease'),  category = _("VHF FM Radio Control panel")},
{combos = {{key = 'R', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_10,	cockpit_device_id = devices.VHF_ARC_131, value_down = 1.0, 		name = _('VHF FM Radio 1MHz Increase'),  category = _("VHF FM Radio Control panel")},

{combos = {{key = 'Q', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_9,	cockpit_device_id = devices.VHF_ARC_131, value_down = -1.0,		name = _('VHF FM Radio 10MHz Decrease'), category = _("VHF FM Radio Control panel")},
{combos = {{key = 'W', reformers = {'RCtrl','RAlt'}}},down = device_commands.Button_9,	cockpit_device_id = devices.VHF_ARC_131, value_down = 1.0, 		name = _('VHF FM Radio 10MHz Increase'), category = _("VHF FM Radio Control panel")},

--AN/ARC-51
{combos = {{key = ';', reformers = {'LCtrl','LShift'}}}, pressed = device_commands.Button_9,cockpit_device_id = devices.UHF_ARC_51, value_pressed = -1.0,	name = _('UHF Radio Volume Decrease'), category = _("UHF Radio Control panel")},
{combos = {{key = "'", reformers = {'LCtrl','LShift'}}}, pressed = device_commands.Button_9,cockpit_device_id = devices.UHF_ARC_51, value_pressed = 1.0, 	name = _('UHF Radio Volume Increase'), category = _("UHF Radio Control panel")},
{combos = {{key = 'Q', reformers = {'LCtrl','LShift'}}}, down = device_commands.Button_10,	cockpit_device_id = devices.UHF_ARC_51, value_down = 1.0, 		name = _('UHF Radio Squelch Switch'), 		category = _("UHF Radio Control panel")},

{combos = {{key = '`', reformers = {'LCtrl','LShift'}}}, down = device_commands.Button_16, 	cockpit_device_id = devices.UHF_ARC_51, value_down = 1.0, name = _('UHF Radio Mode Select(rotary)'), category = _("UHF Radio Control panel")},
{combos = {{key = '1', reformers = {'LCtrl','LShift'}}}, down = device_commands.Button_6, 	cockpit_device_id = devices.UHF_ARC_51, value_down = 0.0, name = _('UHF Radio Mode OFF'), 		category = _("UHF Radio Control panel")},
{combos = {{key = '2', reformers = {'LCtrl','LShift'}}}, down = device_commands.Button_6, 	cockpit_device_id = devices.UHF_ARC_51, value_down = 0.1, name = _('UHF Radio Mode T/R'), 		category = _("UHF Radio Control panel")},
{combos = {{key = '3', reformers = {'LCtrl','LShift'}}}, down = device_commands.Button_6, 	cockpit_device_id = devices.UHF_ARC_51, value_down = 0.2, name = _('UHF Radio Mode T/R+G'), 	category = _("UHF Radio Control panel")},
{combos = {{key = '4', reformers = {'LCtrl','LShift'}}}, down = device_commands.Button_6, 	cockpit_device_id = devices.UHF_ARC_51, value_down = 0.3, name = _('UHF Radio Mode ADF'), 		category = _("UHF Radio Control panel")},

{combos = {{key = '5', reformers = {'LCtrl','LShift'}}},down = device_commands.Button_15, 	cockpit_device_id = devices.UHF_ARC_51, value_down = 1.0, name = _('UHF Radio Freq. Mode Select(rotary)'), category = _("UHF Radio Control panel")},
{combos = {{key = '6', reformers = {'LCtrl','LShift'}}},down = device_commands.Button_5, 	cockpit_device_id = devices.UHF_ARC_51, value_down = 0.0, name = _('UHF Radio Freq. Mode PRESET'), 	category = _("UHF Radio Control panel")},
{combos = {{key = '7', reformers = {'LCtrl','LShift'}}},down = device_commands.Button_5, 	cockpit_device_id = devices.UHF_ARC_51, value_down = 0.1, name = _('UHF Radio Freq. Mode MAN'), 		category = _("UHF Radio Control panel")},
{combos = {{key = '8', reformers = {'LCtrl','LShift'}}},down = device_commands.Button_5, 	cockpit_device_id = devices.UHF_ARC_51, value_down = 0.2, name = _('UHF Radio Freq. Mode GD XMIT'), 	category = _("UHF Radio Control panel")},

{combos = {{key = 'A', reformers = {'LCtrl','LShift'}}},down = device_commands.Button_11,	cockpit_device_id = devices.UHF_ARC_51, value_down = -1.0,name = _('UHF Preset Channel Decrease'), 	category = _("UHF Radio Control panel")},
{combos = {{key = 'S', reformers = {'LCtrl','LShift'}}},down = device_commands.Button_11,	cockpit_device_id = devices.UHF_ARC_51, value_down = 1.0, name = _('UHF Preset Channel Increase'), 	category = _("UHF Radio Control panel")},

{combos = {{key = 'W', reformers = {'LCtrl','LShift'}}},down = device_commands.Button_12,	cockpit_device_id = devices.UHF_ARC_51, value_down = -1.0,name = _('UHF Radio 10MHz Decrease'), 	category = _("UHF Radio Control panel")},
{combos = {{key = 'E', reformers = {'LCtrl','LShift'}}},down = device_commands.Button_12,	cockpit_device_id = devices.UHF_ARC_51, value_down = 1.0, name = _('UHF Radio 10MHz Increase'), 	category = _("UHF Radio Control panel")},
{combos = {{key = 'R', reformers = {'LCtrl','LShift'}}},down = device_commands.Button_13,	cockpit_device_id = devices.UHF_ARC_51, value_down = -1.0,name = _('UHF Radio 1MHz Decrease'), 	category = _("UHF Radio Control panel")},
{combos = {{key = 'T', reformers = {'LCtrl','LShift'}}},down = device_commands.Button_13,	cockpit_device_id = devices.UHF_ARC_51, value_down = 1.0, name = _('UHF Radio 1MHz Increase'), 	category = _("UHF Radio Control panel")},
{combos = {{key = 'J', reformers = {'LCtrl','LShift'}}},down = device_commands.Button_14,	cockpit_device_id = devices.UHF_ARC_51, value_down = -1.0,name = _('UHF Radio 50kHz Decrease'), 	category = _("UHF Radio Control panel")},
{combos = {{key = 'U', reformers = {'LCtrl','LShift'}}},down = device_commands.Button_14,	cockpit_device_id = devices.UHF_ARC_51, value_down = 1.0, name = _('UHF Radio 50kHz Increase'), 	category = _("UHF Radio Control panel")},

--AN/ARN-83
{combos = {{key = '`', reformers = {'LCtrl','LAlt'}}},down = device_commands.Button_10, 	cockpit_device_id = devices.ADF_ARN_83, value_down = 1.0, name = _('ADF Mode Select (rotary)'), category = _("ADF Set Control panel")},
{combos = {{key = '1', reformers = {'LCtrl','LAlt'}}},down = device_commands.Button_1, 	cockpit_device_id = devices.ADF_ARN_83, value_down = 0.0, name = _('ADF Mode OFF'), 			category = _("ADF Set Control panel")},
{combos = {{key = '2', reformers = {'LCtrl','LAlt'}}},down = device_commands.Button_1, 	cockpit_device_id = devices.ADF_ARN_83, value_down = 0.1, name = _('ADF Mode ADF'), 			category = _("ADF Set Control panel")},
{combos = {{key = '3', reformers = {'LCtrl','LAlt'}}},down = device_commands.Button_1, 	cockpit_device_id = devices.ADF_ARN_83, value_down = 0.2, name = _('ADF Mode ANT'), 			category = _("ADF Set Control panel")},
{combos = {{key = '4', reformers = {'LCtrl','LAlt'}}},down = device_commands.Button_1, 	cockpit_device_id = devices.ADF_ARN_83, value_down = 0.3, name = _('ADF Mode LOOP'), 			category = _("ADF Set Control panel")},

{combos = {{key = '5', reformers = {'LCtrl','LAlt'}}},down = device_commands.Button_11, 	cockpit_device_id = devices.ADF_ARN_83, value_down = 1.0, name = _('ADF Band Select (rotary)'), category = _("ADF Set Control panel")},
{combos = {{key = '6', reformers = {'LCtrl','LAlt'}}},down = device_commands.Button_2, 	cockpit_device_id = devices.ADF_ARN_83, value_down = -1,  name = _('ADF Band 190-400 kHz'), 	category = _("ADF Set Control panel")},
{combos = {{key = '7', reformers = {'LCtrl','LAlt'}}},down = device_commands.Button_2, 	cockpit_device_id = devices.ADF_ARN_83, value_down = 0,	  name = _('ADF Band 400-850 kHz'), 	category = _("ADF Set Control panel")},
{combos = {{key = '8', reformers = {'LCtrl','LAlt'}}},down = device_commands.Button_2, 	cockpit_device_id = devices.ADF_ARN_83, value_down = 1,	  name = _('ADF Band 850-1750 kHz'), 	category = _("ADF Set Control panel")},

{combos = {{key = '[', reformers = {'LCtrl','LAlt'}}},pressed = device_commands.Button_7,cockpit_device_id = devices.ADF_ARN_83, value_pressed = -1.0,name = _('ADF Frequency Decrease'), category = _("ADF Set Control panel")},
{combos = {{key = ']', reformers = {'LCtrl','LAlt'}}},pressed = device_commands.Button_7,cockpit_device_id = devices.ADF_ARN_83, value_pressed = 1.0, name = _('ADF Frequency Increase'), category = _("ADF Set Control panel")},

{combos = {{key = '-', reformers = {'LCtrl','LAlt'}}},pressed = device_commands.Button_8,cockpit_device_id = devices.ADF_ARN_83, value_pressed = -1.0,	name = _('ADF Gain Decrease'), category = _("ADF Set Control panel")},
{combos = {{key = '=', reformers = {'LCtrl','LAlt'}}},pressed = device_commands.Button_8,cockpit_device_id = devices.ADF_ARN_83, value_pressed = 1.0, 	name = _('ADF Gain Increase'), category = _("ADF Set Control panel")},

{combos = {{key = 'Z', reformers = {'LCtrl','LAlt'}}},down = device_commands.Button_5,up = device_commands.Button_5,cockpit_device_id = devices.ADF_ARN_83, value_down = 0.0, value_up = 0.2,	name = _('ADF Loop Left High'), 	category = _("ADF Set Control panel")},
{combos = {{key = 'X', reformers = {'LCtrl','LAlt'}}},down = device_commands.Button_5,up = device_commands.Button_5,cockpit_device_id = devices.ADF_ARN_83, value_down = 0.1, value_up = 0.2,	name = _('ADF Loop Left Low'), 	category = _("ADF Set Control panel")},
{combos = {{key = 'C', reformers = {'LCtrl','LAlt'}}},down = device_commands.Button_5,up = device_commands.Button_5,cockpit_device_id = devices.ADF_ARN_83, value_down = 0.3, value_up = 0.2,	name = _('ADF Loop Right Low'), 	category = _("ADF Set Control panel")},
{combos = {{key = 'V', reformers = {'LCtrl','LAlt'}}},down = device_commands.Button_5,up = device_commands.Button_5,cockpit_device_id = devices.ADF_ARN_83, value_down = 0.4, value_up = 0.2,	name = _('ADF Loop Right High'), 	category = _("ADF Set Control panel")},

{combos = {{key = 'Q', reformers = {'LCtrl','LAlt'}}},down = device_commands.Button_9, 	cockpit_device_id = devices.ADF_ARN_83, value_down = 1.0,		name = _('ADF BFO Switch'), 	category = _("ADF Set Control panel")},

--Intercom
{combos = {{key = '-', reformers = {'RCtrl','RShift'}}},pressed = device_commands.Button_11,cockpit_device_id = devices.INTERCOM, value_pressed = -1.0,	name = _('Intercom Volume Decrease'), 	category = _("Intercom Control Panel")},
{combos = {{key = '=', reformers = {'RCtrl','RShift'}}},pressed = device_commands.Button_11,cockpit_device_id = devices.INTERCOM, value_pressed = 1.0, 	name = _('Intercom Volume Increase'), 	category = _("Intercom Control Panel")},

{combos = {{key = 'W', reformers = {'RCtrl','RShift'}}},down = device_commands.Button_8,cockpit_device_id = devices.INTERCOM, value_down = 0.0, 	name = _('Intercom Mode PVT'), 				category = _("Intercom Control Panel")},
{combos = {{key = 'E', reformers = {'RCtrl','RShift'}}},down = device_commands.Button_8,cockpit_device_id = devices.INTERCOM, value_down = 0.1, 	name = _('Intercom Mode INT'), 				category = _("Intercom Control Panel")},
{combos = {{key = 'R', reformers = {'RCtrl','RShift'}}},down = device_commands.Button_8,cockpit_device_id = devices.INTERCOM, value_down = 0.2, 	name = _('Intercom Mode 1'), 					category = _("Intercom Control Panel")},
{combos = {{key = 'T', reformers = {'RCtrl','RShift'}}},down = device_commands.Button_8,cockpit_device_id = devices.INTERCOM, value_down = 0.3, 	name = _('Intercom Mode 2'), 					category = _("Intercom Control Panel")},
{combos = {{key = 'Y', reformers = {'RCtrl','RShift'}}},down = device_commands.Button_8,cockpit_device_id = devices.INTERCOM, value_down = 0.4, 	name = _('Intercom Mode 3'), 					category = _("Intercom Control Panel")},
{combos = {{key = 'U', reformers = {'RCtrl','RShift'}}},down = device_commands.Button_8,cockpit_device_id = devices.INTERCOM, value_down = 0.5, 	name = _('Intercom Mode 4'), 					category = _("Intercom Control Panel")},
{combos = {{key = 'Q', reformers = {'RCtrl','RShift'}}},down = device_commands.Button_12,cockpit_device_id = devices.INTERCOM, value_down = 1.0, 	name = _('Intercom Mode Selector (rotary)'), 	category = _("Intercom Control Panel")},

{combos = {{key = '1', reformers = {'RCtrl','RShift'}}},down = device_commands.Button_13,cockpit_device_id = devices.INTERCOM, value_down = 0.0, 	name = _('Intercom Receiver #1'), 				category = _("Intercom Control Panel")},
{combos = {{key = '2', reformers = {'RCtrl','RShift'}}},down = device_commands.Button_13,cockpit_device_id = devices.INTERCOM, value_down = 0.1, 	name = _('Intercom Receiver #2'), 				category = _("Intercom Control Panel")},
{combos = {{key = '3', reformers = {'RCtrl','RShift'}}},down = device_commands.Button_13,cockpit_device_id = devices.INTERCOM, value_down = 0.2, 	name = _('Intercom Receiver #3'), 				category = _("Intercom Control Panel")},
{combos = {{key = '4', reformers = {'RCtrl','RShift'}}},down = device_commands.Button_13,cockpit_device_id = devices.INTERCOM, value_down = 0.3, 	name = _('Intercom Receiver #4'), 				category = _("Intercom Control Panel")},
{combos = {{key = '5', reformers = {'RCtrl','RShift'}}},down = device_commands.Button_13,cockpit_device_id = devices.INTERCOM, value_down = 0.4, 	name = _('Intercom Receiver INT'), 			category = _("Intercom Control Panel")},
{combos = {{key = '6', reformers = {'RCtrl','RShift'}}},down = device_commands.Button_13,cockpit_device_id = devices.INTERCOM, value_down = 0.5, 	name = _('Intercom Receiver NAV'), 			category = _("Intercom Control Panel")},

--GMC
{combos = {{key = 'G', reformers = {'LCtrl','LAlt'}}}, 	 down = device_commands.Button_6,cockpit_device_id = devices.GMCS, value_down = 1.0,  		name = _('GMC Operating Mode Slave/Gyro'),	category = _('Systems')},
{combos = {{key = '.', reformers = {'LCtrl','LShift'}}}, pressed = device_commands.Button_7,cockpit_device_id = devices.GMCS, value_pressed = 1.0,	name = _('GMC Manual Heading Decrease'),category = _("Systems")},
{combos = {{key = ',', reformers = {'LCtrl','LShift'}}}, pressed = device_commands.Button_7,cockpit_device_id = devices.GMCS, value_pressed = -1.0, 	name = _('GMC Manual Heading Increase'),category = _("Systems")},
{combos = {{key = 'G', reformers = {'LCtrl'}}}, 		 down = device_commands.Button_8,cockpit_device_id = devices.GMCS, value_down = 1.0,  		name = _('GMC Pointer #1 ADF/VOR'), 	category = _('Systems')},
{combos = {{key = '.', reformers = {'LCtrl','LAlt'}}}, 	 pressed = device_commands.Button_9,cockpit_device_id = devices.GMCS, value_pressed = -1.0,	name = _('GMC Synchronizing o'),		category = _("Systems")},
{combos = {{key = ',', reformers = {'LCtrl','LAlt'}}},   pressed = device_commands.Button_9,cockpit_device_id = devices.GMCS, value_pressed = 1.0, 	name = _('GMC Synchronizing +'),		category = _("Systems")},

--Course Indicator
{combos = {{key = '.', reformers = {'LCtrl'}}}, pressed = device_commands.Button_2,cockpit_device_id = devices.COURSE_IND, value_pressed = -0.5,	name = _('Course Indicator OBS Decrease'),category = _("Systems")},
{combos = {{key = ',', reformers = {'LCtrl'}}}, pressed = device_commands.Button_2,cockpit_device_id = devices.COURSE_IND, value_pressed = 0.5, 	name = _('Course Indicator OBS Increase'),category = _("Systems")},

--Marker Beacon
{combos = {{key = '.', reformers = {'LShift'}}}, pressed = device_commands.Button_3,cockpit_device_id = devices.MARKER_BEACON, value_pressed = -1.0,	name = _('Marker Beacon Volume Decrease'),		category = _("Systems")},
{combos = {{key = ';', reformers = {'LShift'}}}, pressed = device_commands.Button_3,cockpit_device_id = devices.MARKER_BEACON, value_pressed = 1.0, 	name = _('Marker Beacon Volume Increase'),		category = _("Systems")},
{combos = {{key = 'V', reformers = {'LShift'}}}, down = device_commands.Button_4, 	cockpit_device_id = devices.MARKER_BEACON, value_down = 1.0,		name = _('Marker Beacon Sensitivity High/Low'),category = _("Systems")},

--Clock 
{combos = {{key = 'Q', reformers = {'RShift'}}}, down = device_commands.Button_3, cockpit_device_id = devices.CLOCK, value_down = 1.0,  name = _('Clock Winding/Adjust'), category = _('Front Dash')},
{combos = {{key = 'Q', reformers = {'RCtrl'}}},	 pressed = device_commands.Button_4, cockpit_device_id = devices.CLOCK, value_pressed = -0.2, name = _('Clock Winding/Adjust Decrease'), category = _('Front Dash')},
{combos = {{key = 'Q', reformers = {'RAlt'}}},	 pressed = device_commands.Button_4, cockpit_device_id = devices.CLOCK, value_pressed = 0.2, name = _('Clock Winding/Adjust Increase'), category = _('Front Dash')},

--Copilot Altimeter 
{combos = {{key = 'B', reformers = {'LCtrl'}}},	pressed = device_commands.Button_2, cockpit_device_id = devices.AAU32, value_pressed = -1.0, name = _('Altimeter Copilot, Pressure Decrease'), category = _('Front Dash')},
{combos = {{key = 'B', reformers = {'LShift'}}},pressed = device_commands.Button_2, cockpit_device_id = devices.AAU32, value_pressed = 1.0, name = _('Altimeter Copilot, Pressure Increase'), category = _('Front Dash')},

--Pilot Altimeter 
{combos = {{key = 'B', reformers = {'RCtrl'}}},	pressed = device_commands.Button_2, cockpit_device_id = devices.AAU7, value_pressed = -1.0, name = _('Altimeter Pilot, Pressure Decrease'), category = _('Front Dash')},
{combos = {{key = 'B', reformers = {'RShift'}}},pressed = device_commands.Button_2, cockpit_device_id = devices.AAU7, value_pressed = 1.0, name = _('Altimeter Pilot, Pressure Increase'), category = _('Front Dash')},


--Pilot's attitude indicator
{combos = {{key = 'N', reformers = {'LCtrl'}}},	pressed = device_commands.Button_3, cockpit_device_id = devices.ADI_PILOT, value_pressed = -0.5, name = _('Attitude Indicator pilot, Pitch Decrease'), category = _('Front Dash')},
{combos = {{key = 'N', reformers = {'LShift'}}},pressed = device_commands.Button_3, cockpit_device_id = devices.ADI_PILOT, value_pressed = 0.5, name = _('Attitude Indicator pilot, Pitch Increase'), category = _('Front Dash')},
{combos = {{key = 'M', reformers = {'LCtrl'}}},	pressed = device_commands.Button_4, cockpit_device_id = devices.ADI_PILOT, value_pressed = -0.5, name = _('Attitude Indicator pilot, Roll Decrease'), category = _('Front Dash')},
{combos = {{key = 'M', reformers = {'LShift'}}},pressed = device_commands.Button_4, cockpit_device_id = devices.ADI_PILOT, value_pressed = 0.5, name = _('Attitude Indicator pilot, Roll Increase'), category = _('Front Dash')},

--Copilot's attitude indicator
{combos = {{key = 'F', reformers = {'RCtrl'}}}, pressed = device_commands.Button_3, cockpit_device_id = devices.ADI_OPERATOR, value_pressed = -0.5, name = _('Copilot Gyro, Pitch Decrease'), category = _('Front Dash')},
{combos = {{key = 'F', reformers = {'RShift'}}}, pressed = device_commands.Button_3, cockpit_device_id = devices.ADI_OPERATOR, value_pressed = 0.5, name = _('Copilot Gyro, Pitch Increase'), category = _('Front Dash')},
{combos = {{key = 'G', reformers = {'RShift'}}}, down = device_commands.Button_1, up = device_commands.Button_1, cockpit_device_id = devices.ADI_OPERATOR, value_down = 1, value_up = 0, name = _('Copilot Gyro Cage'), category = _('Front Dash')},

--Radar Altimeter
{combos = {{key = 'R', reformers = {'RAlt'}}}, down = device_commands.Button_4, up = device_commands.Button_4, cockpit_device_id = devices.RADAR_ALTIMETER, value_down = 1.0, value_up	= 0.0, name = _('Radar Altimeter, Test'), category = _('Front Dash')},
{combos = {{key = 'R', reformers = {'RAlt','RShift'}}}, pressed = device_commands.Button_6, cockpit_device_id = devices.RADAR_ALTIMETER, value_pressed = -0.1, name = _('Radar Altimeter, Hight Altitude Decrease'), category = _('Front Dash')},
{combos = {{key = 'R', reformers = {'RCtrl','RWin'}}}, pressed = device_commands.Button_6, cockpit_device_id = devices.RADAR_ALTIMETER, value_pressed = 0.1, value_up = 0, name = _('Radar Altimeter, Hight Altitude Increase'), category = _('Front Dash')},
{combos = {{key = 'R', reformers = {'RAlt','RWin'}}}, pressed = device_commands.Button_5, cockpit_device_id = devices.RADAR_ALTIMETER, value_pressed = -0.1, name = _('Radar Altimeter, Low Altitude Decrease'), category = _('Front Dash')},
{combos = {{key = 'R', reformers = {'RShift','RWin'}}}, pressed = device_commands.Button_5, cockpit_device_id = devices.RADAR_ALTIMETER, value_pressed = 0.1, value_up = 0, name = _('Radar Altimeter, Low Altitude Increase'), category = _('Front Dash')},

--- Kneeboard
{combos = {{key = ']'}}  , 	down = device_commands.Button_1, cockpit_device_id = devices.KNEEBOARD, value_down = 1.0, name = _('Kneeboard Next Page')  , category = _('Kneeboard')},
{combos = {{key = '['}}  , 	down = device_commands.Button_2, cockpit_device_id = devices.KNEEBOARD, value_down = 1.0, name = _('Kneeboard Previous Page'), category = _('Kneeboard')},
{combos = {{key = 'K', reformers = {'RShift'}}}, 	down = iCommandPlaneShowKneeboard,	name = _('Kneeboard ON/OFF'), category = _('Kneeboard')},
{combos = {{key = 'K'}}						   , 	down = iCommandPlaneShowKneeboard, up = iCommandPlaneShowKneeboard ,value_down = 1.0,value_up = -1.0, name = _('Kneeboard glance view')  , category = _('Kneeboard')},
{combos = {{key = 'K', reformers = {'RCtrl'}}} , 	down = device_commands.Button_3	, cockpit_device_id = devices.KNEEBOARD,value_down = 1.0, name = _('Kneeboard current position mark point')  , category = _('Kneeboard')},

--Night Vision Goggles
{combos = {{key = 'H', reformers = {'RShift'}}}		   , 	down    = iCommandViewNightVisionGogglesOn   , name = _('Night Vision Goggles')   , category = _('Sensors')},
{combos = {{key = 'H', reformers = {'RShift','RCtrl'}}}, 	pressed = iCommandPlane_Helmet_Brightess_Up  , name = _('Night Vision Goggles Gain Up')  , category = _('Sensors')},
{combos = {{key = 'H', reformers = {'RShift','RAlt'}}} , 	pressed = iCommandPlane_Helmet_Brightess_Down, name = _('Night Vision Goggles Gain Down'), category = _('Sensors')},

--Windshield wipers
{combos = {{key = 'S'}},						down = device_commands.Button_3, cockpit_device_id = devices.CPT_MECH, value_down = -1.0, name = _('Wiper Mode Selector Down'), category = _('Ins Overhead panel')},
{combos = {{key = 'W'}},						down = device_commands.Button_3, cockpit_device_id = devices.CPT_MECH, value_down = 1.0, name = _('Wiper Mode Selector Up'), category = _('Ins Overhead panel')},
{combos = {{key = ',', reformers = {'RAlt'}}},	up = device_commands.Button_1, down = device_commands.Button_1, cockpit_device_id = devices.CPT_MECH, value_up = 0.0, value_down = -1.0, name = _('Windshield Mode Decrease'), category = _('Ins Overhead panel')},
{combos = {{key = '.', reformers = {'RAlt'}}},	up = device_commands.Button_1, down = device_commands.Button_1, cockpit_device_id = devices.CPT_MECH, value_up = 0.0, value_down = 1.0, name = _('Windshield Mode Increase'), category = _('Ins Overhead panel')},

{combos = {{key = 'E', reformers = {'LCtrl'}}}, down = iCommandPlaneEject, name = _('Leave Helicopter (3 times)'), category = _('Systems')},

{combos = {{key = '1'}}, down = iCommandViewCockpitChangeSeat, value_down = 1, name = _('Set Pilot Seat'), category = _('View Cockpit')},
{combos = {{key = '2'}}, down = iCommandViewCockpitChangeSeat, value_down = 2, name = _('Set Operator Seat'), category = _('View Cockpit')},
{combos = {{key = '3'}}, down = iCommandViewCockpitChangeSeat, value_down = 3, name = _('Set Left Gunner Seat'), category = _('View Cockpit')},
{combos = {{key = '4'}}, down = iCommandViewCockpitChangeSeat, value_down = 4, name = _('Set Right Gunner Seat'), category = _('View Cockpit')},
{combos = {{key = 'T', reformers = {'RShift'}}},	down = device_commands.Button_5, cockpit_device_id = devices.HEAD_WRAPPER, value_down = 0.0,	name = _('Uncoupled Aiming On/Off'),		category = _('View Cockpit')},
{combos = {{key = 'Y', reformers = {'RShift'}}},	down = device_commands.Button_45, cockpit_device_id = devices.WEAPON_SYS, value_down = 0.0,	name = _('Absolute/Relative Axis Aiming'),		category = _('View Cockpit')},


--Circuit breakers
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.0,  name = _('CB IFF APX 1'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.01, name = _('CB IFF APX 2'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.02, name = _('CB Prox. warn.'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.03, name = _('CB Marker beacon'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.04, name = _('CB VHF Nav. (ARN-82)'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.05, name = _('CB LF Nav. (ARN-83)'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.06, name = _('CB Intercom CPLT'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.07, name = _('CB Intercom PLT'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.08, name = _('CB Wind wiper PLT'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.09, name = _('CB Wind wiper CPLT'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.10, name = _('CB KY-28 voice security'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.11, name = _('CB Search light power'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.12, name = _('CB Landing light power'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.13, name = _('CB Landing & Search light control'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.14, name = _('CB Anticollision light '), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.15, name = _('CB Heated blanket 1'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.16, name = _('CB Heated blanket 2'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.17, name = _('CB Voltmeter Non Ess Bus'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.18, name = _('CB Pitot tube'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.19, name = _('CB Cabin heater (Outlet valve)'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.20, name = _('CB Cabin heater (Air valve)'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.21, name = _('CB RPM Warning system'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.22, name = _('CB Engine anti-ice'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.23, name = _('CB Fire detector'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.24, name = _('CB LH fuel boost pump'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.25, name = _('CB Turn & Slip indicator'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.26, name = _('CB TEMP indicator'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.27, name = _('CB HYD Control'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.28, name = _('CB FORCE Trim'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.29, name = _('CB Rescue hoist PWR'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.30, name = _('CB Rescue hoist CTL'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.31, name = _('CB Rescue hoist cable cutter'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.32, name = _('CB ARC-102 HF Static INVTR'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.33, name = _('CB HF ANT COUPLR'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.34, name = _('CB HF ARC-102'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.35, name = _('CB FM Radio'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.36, name = _('CB UHF Radio'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.37, name = _('CB FM 2 Radio'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.38, name = _('CB VHF AM Radio'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.39, name = _('CB Fuselage lights'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.40, name = _('CB Navigation lights'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.41, name = _('CB Dome lights'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.42, name = _('CB Cockpit lights'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.43, name = _('CB Caution lights'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.44, name = _('CB Console lights'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.45, name = _('CB INST Panel lights'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.46, name = _('CB INST SEC lights'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.47, name = _('CB Cargo hook release'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.48, name = _('CB EXT Stores jettison'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.49, name = _('CB Spare inverter PWR'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.50, name = _('CB Inverter CTRL'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.51, name = _('CB Main inverter PWR'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.52, name = _('CB Generator & Bus Reset'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.53, name = _('CB STBY Generator Field'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.54, name = _('CB Governor Control'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.55, name = _('CB IDLE Stop release'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.56, name = _('CB RH fuel boost pump'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.57, name = _('CB Fuel TRANS'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.58, name = _('CB Fuel valves'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.59, name = _('CB Starter Relay'), category = _('Circuit breaker panel')},
{down = device_commands.Button_18, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.60, name = _('CB Ignition system'), category = _('Circuit breaker panel')},

{combos = {{key = 'R', reformers = {'RShift'}}}, down = device_commands.Button_8, cockpit_device_id = devices.RADAR_ALTIMETER, value_down = 1.0,  name = _('Radar Altimeter Power Switch'), category = _('Circuit breaker panel')},

--Gunners AI Panel
{combos = {{key = 'H', reformers = {'LWin'}}}, down = device_commands.Button_37, cockpit_device_id = devices.WEAPON_SYS, value_down = 1.0, name = _('AI Panel Show/Hide'), category = _('Gunners AI Panel')},

{combos = {{key = '3', reformers = {'LCtrl'}}}, down = device_commands.Button_38, cockpit_device_id = devices.WEAPON_SYS, value_down = 0.0, name = _('AI Left ROE Iterate'), category = _('Gunners AI Panel')},
{combos = {{key = '3', reformers = {'LShift'}}}, down = device_commands.Button_38, cockpit_device_id = devices.WEAPON_SYS, value_down = 0.1, name = _('AI Left Burst Switch'), category = _('Gunners AI Panel')},

{combos = {{key = '2', reformers = {'LCtrl'}}}, down = device_commands.Button_39, cockpit_device_id = devices.WEAPON_SYS, value_down = 0.0, name = _('AI Operator ROE Iterate'), category = _('Gunners AI Panel')},
{combos = {{key = '2', reformers = {'LShift'}}}, down = device_commands.Button_39, cockpit_device_id = devices.WEAPON_SYS, value_down = 0.1, name = _('AI Operator Burst Switch'), category = _('Gunners AI Panel')},

{combos = {{key = '4', reformers = {'LCtrl'}}}, down = device_commands.Button_40, cockpit_device_id = devices.WEAPON_SYS, value_down = 0.0, name = _('AI Right ROE Iterate'), category = _('Gunners AI Panel')},
{combos = {{key = '4', reformers = {'LShift'}}}, down = device_commands.Button_40, cockpit_device_id = devices.WEAPON_SYS, value_down = 0.1, name = _('AI Right Burst Switch'), category = _('Gunners AI Panel')},


{down = device_commands.Button_11, cockpit_device_id = devices.XM_130, value_down = 0.0, name = _('Ripple Fire Cover'), category = _('Pedestal')},
{down = device_commands.Button_12, cockpit_device_id = devices.XM_130, value_down = 0.0, name = _('Ripple Fire Switch'), category = _('Pedestal')},
{down = device_commands.Button_13, cockpit_device_id = devices.XM_130, value_down = 0.0, name = _('SAFE/ARMED Switcher'), category = _('Pedestal')},
{down = device_commands.Button_14, cockpit_device_id = devices.XM_130, value_down = 0.0, name = _('Chaff Mode Switch'), category = _('Pedestal')},
{combos = {{key = 'C', reformers = {'LCtrl'}}}, down = device_commands.Button_6, up = device_commands.Button_6, cockpit_device_id = devices.XM_130, value_down = 1.0, value_up = 0.0, name = _('Flare Dispense Button'), category = _('Pedestal')},
{down = device_commands.Button_10, up = device_commands.Button_10, cockpit_device_id = devices.XM_130, value_down = 1.0, value_up = 0.0, name = _('Armed Lamp Test Button'), category = _('Pedestal')},


-- View
{combos = {{key = 'Q', reformers = {'LShift','LAlt'}}},	down = device_commands.Button_1, cockpit_device_id = devices.EXTERNAL_CARGO_VIEW, value_down = 1, name = _('Cargo View'), category = _('View')},

-- Flashlight
{combos = {{key = 'L', reformers = {'LCtrl','LAlt'}}}, down = 3256, cockpit_device_id = 0, value_down = 1.0, name = _('Flashlight'), category = _('View Cockpit')},
{down = 3255, cockpit_device_id = 0, value_down = 1.0, name = _('Flashlight Color - Toggle Green/White'), category = {_('View Cockpit')}},

},
}
