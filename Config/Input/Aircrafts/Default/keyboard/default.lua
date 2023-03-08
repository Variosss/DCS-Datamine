return {

keyCommands = {

-- Temporary
{combos = {{key = '`', reformers = {'LAlt'}}}, down = ICommandToggleConsole, name = _('Toggle Console'), category = _('Debug')},

{combos = {{key = 'Y'}}, down = iCommandViewInfoControlPanelOnOff, name = _('Control panel'), category = _('General')},

{combos = {{key = '\'', reformers = {'RAlt'}}}, down = iCommandBdaShowHide, name = _('BDA show/hide'), category = _('General')},

{combos = {{key = '\'', reformers = {'RAlt'}}}, down = iCommandBdaShowHide, name = _('BDA show/hide'), category = _('General')},
{combos = {{key = '\`', reformers = {'LCtrl', 'LAlt'}}}, pressed = iCommandBdaShowCursor, up = iCommandBdaShowCursorStop, name = _('BDA show cursor'), category = _('General')},

-- Gameplay
{combos = {{key = 'B', reformers = {'LAlt'}}},				down = iCommandViewBriefing, name = _('Briefing window'), category = _('General')},
{combos = {{key = '\''}}, down = iCommandScoresWindowToggle, name = _('Score window'), category = _('General')},
{combos = {{key = '\'', reformers = {'RShift'}}}, down = iCommandDebriefing, name = _('Show debriefing window'), category = _('General')},
{combos = {{key = '\'', reformers = {'LAlt'}}}, down = iCommandMissionResourcesManagement, name = _('Show Mission Resources Management window'), category = _('General')},
{combos = {{key = 'Y', reformers = {'LCtrl', 'LShift'}}}, down = iCommandChatShowHide, name = _('Chat show/hide'), category = _('General')},
{combos = {{key = 'Y', reformers = {'LCtrl'}}}, down = iCommandInfoOnOff, name = _('Info bar view toggle'), category = _('General')},
{combos = {{key = 'Tab', reformers = {'RCtrl', 'RShift'}}}, down = iCommandRecoverHuman, name = _('Get new plane - respawn'), category = _('General')},
{combos = {{key = 'J', reformers = {'RAlt'}}}, down = iCommandPlaneJump, name = _('Jump into other aircraft'), category = _('General')},
{combos = {{key = 'SysRQ'}}, down = iCommandScreenShot, name = _('Screenshot'), category = _('General'), disabled = true},
{combos = {{key = 'Y', reformers = {'LAlt'}}}, down = iCommandViewCoordinatesInLinearUnits, name = _('Coordinates units change'), category = _('General')},
{combos = {{key = 'S',     reformers = {'LCtrl'}}},	down = iCommandSoundOnOff,				name = _('Sound On/Off'),				category = _('General')},

{combos = {{key = '\\'}}, down = iCommandToggleCommandMenu, name = _('Communication menu'), category = _('Communications')},
{combos = {{key = '\\', reformers = {'LShift'}}}, down = ICommandSwitchDialog, name = _('Switch dialog'), category = _('Communications')},
{combos = {{key = '\\', reformers = {'LCtrl'}}}, down = ICommandSwitchToCommonDialog, name = _('Switch to main menu'), category = _('Communications')},


-- View                                                    
{combos = {{key = 'Num4'}}, pressed = iCommandViewLeftSlow, up = iCommandViewStopSlow, name = _('View Left slow'), category = _('View')},
{combos = {{key = 'Num6'}}, pressed = iCommandViewRightSlow, up = iCommandViewStopSlow, name = _('View Right slow'), category = _('View')},
{combos = {{key = 'Num8'}}, pressed = iCommandViewUpSlow, up = iCommandViewStopSlow, name = _('View Up slow'), category = _('View')},
{combos = {{key = 'Num2'}}, pressed = iCommandViewDownSlow, up = iCommandViewStopSlow, name = _('View Down slow'), category = _('View')},
{combos = {{key = 'Num9'}}, pressed = iCommandViewUpRightSlow, up = iCommandViewStopSlow, name = _('View Up Right slow'), category = _('View')},
{combos = {{key = 'Num3'}}, pressed = iCommandViewDownRightSlow, up = iCommandViewStopSlow, name = _('View Down Right slow'), category = _('View')},
{combos = {{key = 'Num1'}}, pressed = iCommandViewDownLeftSlow, up = iCommandViewStopSlow, name = _('View Down Left slow'), category = _('View')},
{combos = {{key = 'Num7'}}, pressed = iCommandViewUpLeftSlow, up = iCommandViewStopSlow, name = _('View Up Left slow'), category = _('View')},
{combos = {{key = 'Num5'}}, pressed = iCommandViewCenter, name = _('View Center'), category = _('View')},
{combos = {{key = 'Num5', reformers = {'RCtrl'}}},	down = iCommandViewCameraReturn, name = _('Return Camera'),	category = _('View')},
{combos = {{key = 'Num5', reformers = {'RAlt'}}},	down = iCommandViewCameraBaseReturn, name = _('Return Camera Base'), category = _('View')},

{combos = {{key = 'Num8', reformers = {'RShift'}}}, pressed = iCommandViewUp, up = iCommandViewStop, name = _('View up'), category = _('View')},
{combos = {{key = 'Num2', reformers = {'RShift'}}}, pressed = iCommandViewDown, up = iCommandViewStop, name = _('View down'), category = _('View')},
{combos = {{key = 'Num4', reformers = {'RShift'}}}, pressed = iCommandViewLeft, up = iCommandViewStop, name = _('View left'), category = _('View')},
{combos = {{key = 'Num6', reformers = {'RShift'}}}, pressed = iCommandViewRight, up = iCommandViewStop, name = _('View right'), category = _('View')},
{combos = {{key = 'Num9', reformers = {'RShift'}}}, pressed = iCommandViewUpRight, up = iCommandViewStop, name = _('View up right'), category = _('View')},
{combos = {{key = 'Num3', reformers = {'RShift'}}}, pressed = iCommandViewDownRight, up = iCommandViewStop, name = _('View down right'), category = _('View')},
{combos = {{key = 'Num1', reformers = {'RShift'}}}, pressed = iCommandViewDownLeft, up = iCommandViewStop, name = _('View down left'), category = _('View')},
{combos = {{key = 'Num7', reformers = {'RShift'}}}, pressed = iCommandViewUpLeft, up = iCommandViewStop, name = _('View up left'), category = _('View')},
{combos = {{key = 'Num*', reformers = {'RShift'}}}, pressed = iCommandViewForward, up = iCommandViewForwardStop, name = _('Zoom in'), category = _('View')},
{combos = {{key = 'Num/', reformers = {'RShift'}}}, pressed = iCommandViewBack, up = iCommandViewBackStop, name = _('Zoom out'), category = _('View')},

{combos = {{key = 'Num*'}},								pressed = iCommandViewForwardSlow,		up = iCommandViewForwardSlowStop,		name = _('Zoom in slow'),										category = _('View')},
{combos = {{key = 'Num/'}},								pressed = iCommandViewBackSlow,			up = iCommandViewBackSlowStop,			name = _('Zoom out slow'),										category = _('View')},
{combos = {{key = 'NumEnter'}},							down = iCommandViewAngleDefault,												name = _('Zoom normal'),										category = _('View')},
{combos = {{key = 'Num*', reformers = {'RCtrl'}}},		pressed = iCommandViewExternalZoomIn,	up = iCommandViewExternalZoomInStop,	name = _('Zoom external in'),									category = _('View')},
{combos = {{key = 'Num/', reformers = {'RCtrl'}}},		pressed = iCommandViewExternalZoomOut,	up = iCommandViewExternalZoomOutStop,	name = _('Zoom external out'),									category = _('View')},
{combos = {{key = 'NumEnter', reformers = {'RCtrl'}}},	down = iCommandViewExternalZoomDefault,											name = _('Zoom external normal'),								category = _('View')},
{combos = {{key = 'Num*', reformers = {'LAlt'}}},		down = iCommandViewSpeedUp,														name = _('F11 Camera moving forward'),							category = _('View')},
{combos = {{key = 'Num/', reformers = {'LAlt'}}},		down = iCommandViewSlowDown,													name = _('F11 Camera moving backward'),							category = _('View')},

{combos = {{key = 'Num8', reformers = {'RAlt','RCtrl'}}}, pressed = iCommandViewCameraAltUpSlow, up = iCommandViewCameraAltStopSlow, name = _('Camera alternative up slow'), category = _('View')},
{combos = {{key = 'Num2', reformers = {'RAlt','RCtrl'}}}, pressed = iCommandViewCameraAltDownSlow, up = iCommandViewCameraAltStopSlow, name = _('Camera alternative down slow'), category = _('View')},
{combos = {{key = 'Num4', reformers = {'RAlt','RCtrl'}}}, pressed = iCommandViewCameraAltLeftSlow, up = iCommandViewCameraAltStopSlow, name = _('Camera alternative left slow'), category = _('View')},
{combos = {{key = 'Num6', reformers = {'RAlt','RCtrl'}}}, pressed = iCommandViewCameraAltRightSlow, up = iCommandViewCameraAltStopSlow, name = _('Camera alternative right slow'), category = _('View')},
{combos = {{key = 'Num9', reformers = {'RAlt','RCtrl'}}}, pressed = iCommandViewCameraAltUpRightSlow, up = iCommandViewCameraAltStopSlow, name = _('Camera alternative up right slow'), category = _('View')},
{combos = {{key = 'Num3', reformers = {'RAlt','RCtrl'}}}, pressed = iCommandViewCameraAltDownRightSlow, up = iCommandViewCameraAltStopSlow, name = _('Camera alternative down right slow'), category = _('View')},
{combos = {{key = 'Num1', reformers = {'RAlt','RCtrl'}}}, pressed = iCommandViewCameraAltDownLeftSlow, up = iCommandViewCameraAltStopSlow, name = _('Camera alternative down left slow'), category = _('View')},
{combos = {{key = 'Num7', reformers = {'RAlt','RCtrl'}}}, pressed = iCommandViewCameraAltUpLeftSlow, up = iCommandViewCameraAltStopSlow, name = _('Camera alternative up left slow'), category = _('View')},
{combos = {{key = 'Num*', reformers = {'RAlt','RCtrl'}}}, pressed = iCommandViewCameraAltForwardSlow, up = iCommandViewCameraAltForwardStopSlow, name = _('Camera alternative forward slow'), category = _('View')},
{combos = {{key = 'Num/', reformers = {'RAlt','RCtrl'}}}, pressed = iCommandViewCameraAltBackSlow, up = iCommandViewCameraAltBackStopSlow, name = _('Camera alternative backward slow'), category = _('View')},

{combos = {{key = 'Num5', reformers = {'RAlt','RCtrl'}}}, down = iCommandViewCameraAltCenter, name = _('Camera alternative center'), category = _('View')},

{combos = {{key = 'Num8', reformers = {'RAlt','RCtrl','RShift'}}}, pressed = iCommandViewCameraAltUp, up = iCommandViewCameraAltStop, name = _('Camera alternative up'), category = _('View')},
{combos = {{key = 'Num2', reformers = {'RAlt','RCtrl','RShift'}}}, pressed = iCommandViewCameraAltDown, up = iCommandViewCameraAltStop, name = _('Camera alternative down'), category = _('View')},
{combos = {{key = 'Num4', reformers = {'RAlt','RCtrl','RShift'}}}, pressed = iCommandViewCameraAltLeft, up = iCommandViewCameraAltStop, name = _('Camera alternative left'), category = _('View')},
{combos = {{key = 'Num6', reformers = {'RAlt','RCtrl','RShift'}}}, pressed = iCommandViewCameraAltRight, up = iCommandViewCameraAltStop, name = _('Camera alternative right'), category = _('View')},
{combos = {{key = 'Num9', reformers = {'RAlt','RCtrl','RShift'}}}, pressed = iCommandViewCameraAltUpRight, up = iCommandViewCameraAltStop, name = _('Camera alternative up right'), category = _('View')},
{combos = {{key = 'Num3', reformers = {'RAlt','RCtrl','RShift'}}}, pressed = iCommandViewCameraAltDownRight, up = iCommandViewCameraAltStop, name = _('Camera alternative down right'), category = _('View')},
{combos = {{key = 'Num1', reformers = {'RAlt','RCtrl','RShift'}}}, pressed = iCommandViewCameraAltDownLeft, up = iCommandViewCameraAltStop, name = _('Camera alternative down left'), category = _('View')},
{combos = {{key = 'Num7', reformers = {'RAlt','RCtrl','RShift'}}}, pressed = iCommandViewCameraAltUpLeft, up = iCommandViewCameraAltStop, name = _('Camera alternative up left'), category = _('View')},
{combos = {{key = 'Num*', reformers = {'RAlt','RCtrl','RShift'}}}, pressed = iCommandViewCameraAltForward, up = iCommandViewCameraAltForwardStop, name = _('Camera alternative forward'), category = _('View')},
{combos = {{key = 'Num/', reformers = {'RAlt','RCtrl','RShift'}}}, pressed = iCommandViewCameraAltBack, up = iCommandViewCameraAltBackStop, name = _('Camera alternative backward'), category = _('View')},

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
{combos = {{key = 'F5'}}, down = iCommandViewFight, name = _('F5 nearest AC view'), category = _('View')},
{combos = {{key = 'F5', reformers = {'LCtrl'}}}, down = iCommandViewFightGround, name = _('F5 Ground hostile view'), category = _('View')},
{combos = {{key = 'F6'}}, down = iCommandViewWeapons, name = _('F6 Released weapon view'), category = _('View')},
{combos = {{key = 'F6', reformers = {'LCtrl'}}}, down = iCommandViewWeaponAndTarget, name = _('F6 Weapon to target view'), category = _('View')},
{combos = {{key = 'F7'}}, down = iCommandViewGround, name = _('F7 Ground unit view'), category = _('View')},
{combos = {{key = 'F7', reformers = {'LCtrl'}}}, down = iCommandViewJFO, name = _('F7 Ground JFO/JTAC view'), category = _('View')},
{combos = {{key = 'B', reformers = {'LWin'}}}, down = iCommandViewBinocular, name = _('F7 Ground JFO/JTAC Binocular view'), category = _('View')},

{combos = {{key = 'F9'}}, down = iCommandViewNavy, name = _('F9 Ship view'), category = _('View')},
{combos = {{key = 'F9', reformers = {'LAlt'}}}, down = iCommandViewLndgOfficer, name = _('F9 Landing signal officer view'), category = _('View')},
{combos = {{key = 'F10'}}, down = iCommandViewAWACS, name = _('F10 Theater map view'), category = _('View')},
{combos = {{key = 'F10', reformers = {'LCtrl'}}}, down = iCommandViewAWACSJump, name = _('F10 Jump to theater map view over current point'), category = _('View')},
{combos = {{key = 'F10', reformers = {'RShift'}}}, down = iCommandViewAWACSDialog, name = _('Theater map dialog on/off'), category = _('View')},
{combos = {{key = 'F11'}}, down = iCommandViewFree, name = _('F11 Airport free camera'), category = _('View')},
{combos = {{key = 'F11', reformers = {'LCtrl'}}}, down = iCommandViewFreeJump, name = _('F11 Jump to free camera'), category = _('View')},
{combos = {{key = 'F12'}}, down = iCommandViewStatic, name = _('F12 Static object view'), category = _('View')},
{combos = {{key = 'F12', reformers = {'LCtrl'}}}, down = iCommandViewMirage, name = _('F12 Civil traffic view'), category = _('View')},
{combos = {{key = 'F12', reformers = {'LShift'}}}, down = iCommandViewLocomotivesToggle, name = _('F12 Trains/cars toggle'), category = _('View')},
{combos = {{key = 'F1', reformers = {'LWin'}}} , down = iCommandViewPitHeadOnOff, name = _('F1 Head shift movement on / off'), category = _('View')},


-- Experimental object free camera
{combos = {{key = 'F2', reformers = {'RCtrl'}}}, 		down = iCommandViewObject, name = _('Object free camera'), category = _('View')},
{combos = {{key = '=', reformers = {'RCtrl', 'RAlt', 'RShift'}}}, 			down = iCommandViewBookmarksEditor, name = _('Object free camera bookmarks editor'), category = _('View')},
{combos = {{key = '-', reformers = {'RCtrl', 'RAlt', 'RShift'}}}, 			down = iCommandViewBookmarksMenu, name = _('Object free camera bookmarks menu'), category = _('View')},
{combos = {{key = 'O', reformers = {'RCtrl', 'RAlt', 'RShift'}}}, 			down = iCommandViewPieMenu, name = _('Pie menu'), category = _('View')},
-- Experimental wingman camera
{combos = {{key = 'F4', reformers = {'LAlt'}}}, 		down = iCommandViewWingman, name = _('Wingman camera'), category = _('View')},
-- Aircraft carrier cameras
{combos = {{key = 'F9', reformers = {'RCtrl', 'RAlt', 'RShift'}}},	down = iCommandViewSupercarrier, name = _('Supercarrier camera'), category = _('View')},
{combos = {{key = 'F9', reformers = {'RCtrl'}}}, 		down = iCommandViewCatapult, name = _('Aircraft carrier catapult camera'), category = _('View')},
{combos = {{key = 'F9', reformers = {'RCtrl', 'RAlt'}}}, 		down = iCommandViewCatapultCrew, name = _('Aircraft carrier catapult crew camera'),	category = _('View')},
{combos = {{key = 'F11', reformers = {'RAlt', 'RCtrl', 'RShift'}}},	down = iCommandViewFreeInputLayer,	name = _('F11 view local input layer toggle'),	category = _('View')},
-- Camera position to/from clipboard 
{combos = {{key = ',', reformers = {'RAlt', 'RCtrl'}}}, 			down = iCommandViewCameraToClipboard, name = _('Unload camera position to clipboard'), category = _('View')},
{combos = {{key = '.', reformers = {'RAlt', 'RCtrl'}}}, 			down = iCommandViewClipboardToCamera, name = _('Load camera position from clipboard'), category = _('View')},

{combos = {{key = ']', reformers = {'LShift'}}},	down = iCommandViewFastKeyboard,	name = _('Keyboard Rate Fast'),									category = _('View')},
{combos = {{key = ']', reformers = {'LCtrl'}}},		down = iCommandViewSlowKeyboard,	name = _('Keyboard Rate Slow'),									category = _('View')},
{combos = {{key = ']', reformers = {'LAlt'}}},		down = iCommandViewNormalKeyboard,	name = _('Keyboard Rate Normal'),								category = _('View')},
{combos = {{key = '[', reformers = {'LShift'}}},	down = iCommandViewFastMouse,		name = _('Mouse Rate Fast'),									category = _('View')},
{combos = {{key = '[', reformers = {'LCtrl'}}},		down = iCommandViewSlowMouse,		name = _('Mouse Rate Slow'),									category = _('View')},
{combos = {{key = '[', reformers = {'LAlt'}}},		down = iCommandViewNormalMouse,		name = _('Mouse Rate Normal'),									category = _('View')},

-- Extended view
{combos = {{key = 'J', reformers = {'LShift'}}}, down = iCommandViewCameraJiggle, name = _('Camera jiggle toggle'), category = _('View Extended')},
{combos = {{key = 'K', reformers = {'LAlt'}}}, down = iCommandViewKeepTerrain, name = _('Keep terrain camera altitude'), category = _('View Extended')},
{combos = {{key = 'Home', reformers = {'RCtrl'}}}, down = iCommandViewFriends, name = _('View friends mode'), category = _('View Extended')},
{combos = {{key = 'End', reformers = {'RCtrl'}}}, down = iCommandViewEnemies, name = _('View enemies mode'), category = _('View Extended')},
{combos = {{key = 'Delete', reformers = {'RCtrl'}}}, down = iCommandViewAll, name = _('View all mode'), category = _('View Extended')},
{combos = {{key = 'Num+', reformers = {'RCtrl'}}}, down = iCommandViewPlus, name = _('Toggle tracking launched weapon'), category = _('View Extended')},
{combos = {{key = 'PageDown', reformers = {'LCtrl'}}}, down = iCommandViewSwitchForward, name = _('Objects switching direction forward '), category = _('View Extended')},
{combos = {{key = 'PageUp', reformers = {'LCtrl'}}}, down = iCommandViewSwitchReverse, name = _('Objects switching direction reverse '), category = _('View Extended')},
{combos = {{key = 'Delete', reformers = {'LAlt'}}}, down = iCommandViewObjectIgnore, name = _('Object exclude '), category = _('View Extended')},
{combos = {{key = 'Insert', reformers = {'LAlt'}}}, down = iCommandViewObjectsAll, name = _('Objects all excluded - include'), category = _('View Extended')},

-- Padlock

{combos = {{key = 'Num.'}}, down = iCommandViewLock, name = _('Lock view (cycle padlock)'), category = _('View Padlock')},
{combos = {{key = 'NumLock'}}, down = iCommandViewUnlock, name = _('Unlock view (stop padlock)'), category = _('View Padlock')},
{combos = {{key = 'Num.', reformers = {'RCtrl'}}}, down = iCommandViewTerrainLock, name = _('Lock terrain view'), category = _('View Padlock')},


-- Labels
{combos = {{key = 'F10', reformers = {'LShift'}}}, down = iCommandMarkerState, name = _('All Labels'), category = _('Labels')},
{combos = {{key = 'F2', reformers = {'LShift'}}}, down = iCommandMarkerStatePlane, name = _('Aircraft Labels'), category = _('Labels')},
{combos = {{key = 'F6', reformers = {'LShift'}}}, down = iCommandMarkerStateRocket, name = _('Missile Labels'), category = _('Labels')},
{combos = {{key = 'F9', reformers = {'LShift'}}}, down = iCommandMarkerStateShip, name = _('Vehicle & Ship Labels'), category = _('Labels')},

{combos = {{key = 'C',	 reformers = {'LAlt'}}}, down = iCommandCockpitClickModeOnOff, 	name = _('Force cursor to show on/off'),	category = _('General')},


},
}
