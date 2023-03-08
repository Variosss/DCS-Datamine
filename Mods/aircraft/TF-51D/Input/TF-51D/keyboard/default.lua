local cockpit = folder.."../../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

return {
keyCommands = {

{combos = {{key = 'Home', reformers = {'RWin'}}} , 			down = iCommandEnginesStart, name = _('Start Procedure'), category = _('Cheat')},
{combos = {{key = 'End', reformers = {'RWin'}}} , 			down = iCommandEnginesStop, name = _('Stop Procedure'), category = _('Cheat')},


-- Gameplay
{combos = {{key = 'B', reformers = {'LAlt'}}},				down = iCommandViewBriefing, name = _('Briefing window'), category = _('General')},
{combos = {{key = 'J', reformers = {'RAlt'}}}, 				down = iCommandPlaneJump, name = _('Jump into selected aircraft'), category = _('General')},
{combos = {{key = '\''}}, 									down = iCommandScoresWindowToggle, name = _('Score window'), category = _('General')},
{combos = {{key = '\'', reformers = {'RShift'}}}, 			down = iCommandDebriefing, name = _('Show debriefing window'), category = _('General')},
{combos = {{key = 'Y', reformers = {'LCtrl'}}}, 			down = iCommandInfoOnOff, name = _('Info bar view toggle'), category = _('General')},
{combos = {{key = 'Tab', reformers = {'RCtrl', 'RShift'}}}, down = iCommandRecoverHuman, name = _('Get new plane - respawn'), category = _('General')},
{combos = {{key = 'SysRQ'}}, 								down = iCommandScreenShot, name = _('Screenshot'), category = _('General'), disabled = true},
{combos = {{key = 'Pause', reformers = {'RShift'}}},		down = iCommandOneFrame, name = _('One frame mode'), category = _('General')},
{combos = {{key = 'Y', reformers = {'LAlt'}}}, 				down = iCommandViewCoordinatesInLinearUnits, name = _('Info bar coordinate units toggle'), category = _('General')},
{combos = {{key = 'C', reformers = {'LAlt'}}}, 				down = iCommandCockpitClickModeOnOff, name = _('Clickable mouse cockpit mode On/Off'), category = _('General')},
{combos = {{key = 'Enter', reformers = {'RCtrl'}}}, 		down = iCommandPlane_ShowControls, name = _('Show controls indicator') , category = _('General')},
{combos = {{key = 'P', reformers = {'RShift'}}}, 			down = iCommandCockpitShowPilotOnOff, name = _('Show pilot'), category = _('General')},

{combos = {{key = '\'', reformers = {'LAlt'}}}, 			down = iCommandMissionResourcesManagement, name = _('Rearming and Refueling Window'), category = _('General')},
{combos = {{key = 'S',	 reformers = {'LWin'}}},			down = iCommandSoundOnOff,			name = _('Sound On/Off'),	 category = _('General')},


-- Communications
{combos = {{key = 'E', reformers = {'LWin'}}}, 				down = iCommandPlaneDoAndHome, name = _('COMM Dispatch wingmans - complete mission and RTB (easy communication only)'), category = _('Communications')},
{combos = {{key = 'R', reformers = {'LWin'}}}, 				down = iCommandPlaneDoAndBack, name = _('COMM Dispatch wingmans - complete mission and rejoin (easy communication only)'), category = _('Communications')},
{combos = {{key = 'T', reformers = {'LWin'}}}, 				down = iCommandPlaneFormation, name = _('COMM Toggle formation (easy communication only)'), category = _('Communications')},
{combos = {{key = 'Y', reformers = {'LWin'}}}, 				down = iCommandPlaneJoinUp, name = _('COMM Join up formation (easy communication only)'), category = _('Communications')},
{combos = {{key = 'Q', reformers = {'LWin'}}}, 				down = iCommandPlaneAttackMyTarget, name = _('COMM Attack my target (easy communication only)'), category = _('Communications')},
{combos = {{key = 'W', reformers = {'LWin'}}}, 				down = iCommandPlaneCoverMySix, name = _('COMM Cover me (easy communication only)'), category = _('Communications')},
{combos = {{key = 'U', reformers = {'LWin'}}}, 				down = iCommandAWACSHomeBearing, name = _('COMM Ask AWACS home airbase (easy communication only)'), category = _('Communications')},
{combos = {{key = 'G', reformers = {'LWin'}}}, 				down = iCommandPlane_EngageGroundTargets, name = _('COMM Attack Ground Targets (easy communication only)'), category = _('Communications')},
{combos = {{key = 'D', reformers = {'LWin'}}}, 				down = iCommandPlane_EngageAirDefenses, name = _('COMM Attack Air Defenses (easy communication only)'), category = _('Communications')},
{combos = {{key = '\\'}}, 									down = iCommandToggleCommandMenu, name = _('COMM Communication menu'), category = _('Communications')},
{combos = {{key = '\\', reformers = {'RShift'}}}, 			down = ICommandSwitchDialog, name = _('COMM Switch dialog'), category = _('Communications')},
{combos = {{key = '\\', reformers = {'RCtrl'}}}, 			down = ICommandSwitchToCommonDialog, name = _('COMM Switch to main menu'), category = _('Communications')},
{combos = {{key = '\\', reformers = {'RAlt'}}},				down = iCommandPlane_P_51_PTT_on, up = iCommandPlane_P_51_PTT_off, name = _('COMM Push to talk (call radio menu)'), category = _('Communications')},

-- VoIP radio global command
-- in case you need to open commands in the cockpit
{down = iCommandVoIPRadioPushToTalkEnableDisableVoice, up = iCommandVoIPRadioPushToTalkEnableDisableVoice, value_down = 1.0, value_up = 0.0, name = _('COMM Push to talk (VOIP)'), category = _('Communications')},
--

-- View                                                    
{combos = {{key = 'Num4'}}, 								pressed = iCommandViewLeftSlow, up = iCommandViewStopSlow, name = _('View Left slow'), category = _('View')},
{combos = {{key = 'Num6'}}, 								pressed = iCommandViewRightSlow, up = iCommandViewStopSlow, name = _('View Right slow'), category = _('View')},
{combos = {{key = 'Num8'}}, 								pressed = iCommandViewUpSlow, up = iCommandViewStopSlow, name = _('View Up slow'), category = _('View')},
{combos = {{key = 'Num2'}}, 								pressed = iCommandViewDownSlow, up = iCommandViewStopSlow, name = _('View Down slow'), category = _('View')},
{combos = {{key = 'Num9'}}, 								pressed = iCommandViewUpRightSlow, up = iCommandViewStopSlow, name = _('View Up Right slow'), category = _('View')},
{combos = {{key = 'Num3'}}, 								pressed = iCommandViewDownRightSlow, up = iCommandViewStopSlow, name = _('View Down Right slow'), category = _('View')},
{combos = {{key = 'Num1'}}, 								pressed = iCommandViewDownLeftSlow, up = iCommandViewStopSlow, name = _('View Down Left slow'), category = _('View')},
{combos = {{key = 'Num7'}}, 								pressed = iCommandViewUpLeftSlow, up = iCommandViewStopSlow, name = _('View Up Left slow'), category = _('View')},
{combos = {{key = 'Num5'}}, 								pressed = iCommandViewCenter, name = _('View Center'), category = _('View')},

{combos = {{key = 'Num*'}}, 								pressed = iCommandViewForwardSlow, up = iCommandViewForwardSlowStop, name = _('Zoom in slow'), category = _('View')},
{combos = {{key = 'Num/'}}, 								pressed = iCommandViewBackSlow, up = iCommandViewBackSlowStop, name = _('Zoom out slow'), category = _('View')},
{combos = {{key = 'NumEnter'}}, 							down = iCommandViewAngleDefault, name = _('Zoom normal'), category = _('View')},
{combos = {{key = 'Num*', reformers = {'RCtrl'}}}, 			pressed = iCommandViewExternalZoomIn, up = iCommandViewExternalZoomInStop, name = _('Zoom external in'), category = _('View')},
{combos = {{key = 'Num/', reformers = {'RCtrl'}}}, 			pressed = iCommandViewExternalZoomOut, up = iCommandViewExternalZoomOutStop, name = _('Zoom external out'), category = _('View')},
{combos = {{key = 'NumEnter', reformers = {'RCtrl'}}}, 		down = iCommandViewExternalZoomDefault, name = _('Zoom external normal'), category = _('View')},
{combos = {{key = 'Num*', reformers = {'LAlt'}}}, 			down = iCommandViewSpeedUp, name = _('F11 camera moving forward'), category = _('View')},
{combos = {{key = 'Num/', reformers = {'LAlt'}}}, 			down = iCommandViewSlowDown, name = _('F11 camera moving backward'), category = _('View')},


{combos = {{key = 'F1'}}, 									down = iCommandViewCockpit, name = _('F1 Cockpit view'), category = _('View')},
{combos = {{key = 'F1', reformers = {'LCtrl'}}}, 			down = iCommandNaturalViewCockpitIn, name = _('F1 Natural head movement view'), category = _('View')},
{combos = {{key = 'F1', reformers = {'LAlt'}}}, 			down = iCommandViewHUDOnlyOnOff, name = _('F1 HUD only view switch'), category = _('View')},
{combos = {{key = 'F2'}}, 									down = iCommandViewAir, name = _('F2 Aircraft view'), category = _('View')},
{combos = {{key = 'F2', reformers = {'LCtrl'}}},		 	down = iCommandViewMe, name = _('F2 View own aircraft'), category = _('View')},
{combos = {{key = 'F2', reformers = {'RAlt'}}}, 			down = iCommandViewFromTo, name = _('F2 Toggle camera position'), category = _('View')},
{combos = {{key = 'F2', reformers = {'LAlt'}}},			 	down = iCommandViewLocal, name = _('F2 Toggle local camera control'), category = _('View')},
{combos = {{key = 'F3'}}, 									down = iCommandViewTower, name = _('F3 Fly-By view'), category = _('View')},
{combos = {{key = 'F3', reformers = {'LCtrl'}}},		 	down = iCommandViewTowerJump, name = _('F3 Fly-By jump view'), category = _('View')},
{combos = {{key = 'F4'}},								down = iCommandViewRear,														name = _('F4 Camera mounted on airframe'),									category = _('View')},
{combos = {{key = 'F4', reformers = {'LCtrl'}}},		down = iCommandViewChase,														name = _('F4 Chase view'),										category = _('View')},
{combos = {{key = 'F4', reformers = {'LShift'}}},		down = iCommandViewChaseArcade,													name = _('F4 Arcade Chase view'),								category = _('View')},
{combos = {{key = 'F5'}}, 									down = iCommandViewFight, name = _('F5 nearest AC view'), category = _('View')},
{combos = {{key = 'F5', reformers = {'LCtrl'}}},		 	down = iCommandViewFightGround, name = _('F5 Ground hostile view'), category = _('View')},
{combos = {{key = 'F6'}}, 									down = iCommandViewWeapons, name = _('F6 Released weapon view'), category = _('View')},
{combos = {{key = 'F6', reformers = {'LCtrl'}}},		 	down = iCommandViewWeaponAndTarget, name = _('F6 Weapon to target view'), category = _('View')},
{combos = {{key = 'F7'}}, 									down = iCommandViewGround, name = _('F7 Ground unit view'), category = _('View')},
{combos = {{key = 'F7', reformers = {'LCtrl'}}},  			down = iCommandViewJFO, name = _('F7 Ground JFO/JTAC view'), category = _('View')},
{combos = {{key = 'F9'}}, 									down = iCommandViewNavy, name = _('F9 Ship view'), category = _('View')},
{combos = {{key = 'F9', reformers = {'LAlt'}}}, 			down = iCommandViewLndgOfficer, name = _('F9 Landing signal officer view'), category = _('View')},
{combos = {{key = 'F10'}}, 									down = iCommandViewAWACS, name = _('F10 Theater map view'), category = _('View')},
{combos = {{key = 'F10', reformers = {'LCtrl'}}},		 	down = iCommandViewAWACSJump, name = _('F10 Jump to theater map view over current point'), category = _('View')},
{combos = {{key = 'F11'}}, 									down = iCommandViewFree, name = _('F11 Airport free camera'), category = _('View')},
{combos = {{key = 'F11', reformers = {'LCtrl'}}},		 	down = iCommandViewFreeJump, name = _('F11 Jump to free camera'), category = _('View')},
{combos = {{key = 'F12'}}, 									down = iCommandViewStatic, name = _('F12 Static object view'), category = _('View')},
{combos = {{key = 'F12', reformers = {'LCtrl'}}},		 	down = iCommandViewMirage, name = _('F12 Civil traffic view'), category = _('View')},
{combos = {{key = 'F12', reformers = {'LShift'}}}, 			down = iCommandViewLocomotivesToggle, name = _('F12 Trains/cars toggle'), category = _('View')},
{combos = {{key = 'F1', reformers = {'LWin'}}} ,		 	down = iCommandViewPitHeadOnOff, name = _('F1 Head shift movement on / off'), category = _('View')},

{combos = {{key = ']', reformers = {'LShift'}}}, 			down = iCommandViewFastKeyboard, name = _('Camera view keyboard rate fast'), category = _('View')},
{combos = {{key = ']', reformers = {'LCtrl'}}}, 			down = iCommandViewSlowKeyboard, name = _('Camera view keyboard rate slow'), category = _('View')},
{combos = {{key = ']', reformers = {'LAlt'}}}, 				down = iCommandViewNormalKeyboard, name = _('Camera view keyboard rate normal'), category = _('View')},
{combos = {{key = '[', reformers = {'LShift'}}}, 			down =  iCommandViewFastMouse, name = _('Camera view mouse rate fast'), category = _('View')},
{combos = {{key = '[', reformers = {'LCtrl'}}}, 			down = iCommandViewSlowMouse, name = _('Camera view mouse rate slow'), category = _('View')},
{combos = {{key = '[', reformers = {'LAlt'}}}, 				down = iCommandViewNormalMouse, name = _('Camera view mouse rate normal'), category = _('View')},

-- Experimental object free camera
{combos = {{key = 'F2', reformers = {'RCtrl'}}}, 		down = iCommandViewObject, name = _('Object free camera'), category = _('View')},
{combos = {{key = '=', reformers = {'RCtrl', 'RAlt', 'RShift'}}}, 			down = iCommandViewBookmarksEditor, name = _('Object free camera bookmarks editor'), category = _('View')},
{combos = {{key = '-', reformers = {'RCtrl', 'RAlt', 'RShift'}}}, 			down = iCommandViewBookmarksMenu, name = _('Object free camera bookmarks menu'), category = _('View')},
{combos = {{key = 'O', reformers = {'RCtrl', 'RAlt', 'RShift'}}}, 			down = iCommandViewPieMenu, name = _('Pie menu'), category = _('View')},
-- Experimental wingman camera
{combos = {{key = 'F4', reformers = {'LAlt'}}}, 		down = iCommandViewWingman, name = _('Wingman camera'), category = _('View')},
-- Camera position to/from clipboard 
{combos = {{key = ',', reformers = {'RAlt', 'RCtrl'}}}, 			down = iCommandViewCameraToClipboard, name = _('Unload camera position to clipboard'), category = _('View')},
{combos = {{key = '.', reformers = {'RAlt', 'RCtrl'}}}, 			down = iCommandViewClipboardToCamera, name = _('Load camera position from clipboard'), category = _('View')},


-- Cockpit view
{combos = {{key = 'Num0'}}, 								down = iCommandViewTempCockpitOn, up = iCommandViewTempCockpitOff, name = _('Cockpit panel view in'), category = _('View Cockpit')},
{combos = {{key = 'Num0', reformers = {'RCtrl'}}}, 			down = iCommandViewTempCockpitToggle, name = _('Cockpit panel view toggle'), category = _('View Cockpit')},
{combos = {{key = 'Num0', reformers = {'RAlt'}}}, 			down = iCommandViewSaveAngles, name = _('Save Cockpit Angles'), category = _('View Cockpit')}, -- Save current cockpit camera angles for fast numpad jumps  
{combos = {{key = 'Num8', reformers = {'RShift'}}}, 		pressed = iCommandViewUp, up = iCommandViewStop, name = _('View up'), category = _('View Cockpit')},
{combos = {{key = 'Num2', reformers = {'RShift'}}}, 		pressed = iCommandViewDown, up = iCommandViewStop, name = _('View down'), category = _('View Cockpit')},
{combos = {{key = 'Num4', reformers = {'RShift'}}}, 		pressed = iCommandViewLeft, up = iCommandViewStop, name = _('View left'), category = _('View Cockpit')},
{combos = {{key = 'Num6', reformers = {'RShift'}}}, 		pressed = iCommandViewRight, up = iCommandViewStop, name = _('View right'), category = _('View Cockpit')},
{combos = {{key = 'Num9', reformers = {'RShift'}}}, 		pressed = iCommandViewUpRight, up = iCommandViewStop, name = _('View up right'), category = _('View Cockpit')},
{combos = {{key = 'Num3', reformers = {'RShift'}}}, 		pressed = iCommandViewDownRight, up = iCommandViewStop, name = _('View down right'), category = _('View Cockpit')},
{combos = {{key = 'Num1', reformers = {'RShift'}}}, 		pressed = iCommandViewDownLeft, up = iCommandViewStop, name = _('View down left'), category = _('View Cockpit')},
{combos = {{key = 'Num7', reformers = {'RShift'}}}, 		pressed = iCommandViewUpLeft, up = iCommandViewStop, name = _('View up left'), category = _('View Cockpit')},

{combos = {{key = 'Num8', reformers = {'RCtrl'}}}, 			down = iCommandViewCameraUp, up = iCommandViewCameraCenter, name = _('Camera view up'), category = _('View Cockpit')},
{combos = {{key = 'Num2', reformers = {'RCtrl'}}}, 			down = iCommandViewCameraDown, up = iCommandViewCameraCenter, name = _('Camera view down'), category = _('View Cockpit')},
{combos = {{key = 'Num4', reformers = {'RCtrl'}}}, 			down = iCommandViewCameraLeft, up = iCommandViewCameraCenter, name = _('Camera view left'), category = _('View Cockpit')},
{combos = {{key = 'Num6', reformers = {'RCtrl'}}}, 			down = iCommandViewCameraRight, up = iCommandViewCameraCenter, name = _('Camera view right'), category = _('View Cockpit')},
{combos = {{key = 'Num7', reformers = {'RCtrl'}}}, 			down = iCommandViewCameraUpLeft, up = iCommandViewCameraCenter, name = _('Camera view up-left'), category = _('View Cockpit')},
{combos = {{key = 'Num1', reformers = {'RCtrl'}}}, 			down = iCommandViewCameraDownLeft, up = iCommandViewCameraCenter, name = _('Camera view down-left'), category = _('View Cockpit')},
{combos = {{key = 'Num9', reformers = {'RCtrl'}}}, 			down = iCommandViewCameraUpRight, up = iCommandViewCameraCenter, name = _('Camera view up-right'), category = _('View Cockpit')},
{combos = {{key = 'Num3', reformers = {'RCtrl'}}}, 			down = iCommandViewCameraDownRight, up = iCommandViewCameraCenter, name = _('Camera view down-right'), category = _('View Cockpit')},

{combos = {{key = 'Num8', reformers = {'RAlt'}}}, 			down = iCommandViewCameraUpSlow, name = _('Camera view up slow'), category = _('View Cockpit')},
{combos = {{key = 'Num2', reformers = {'RAlt'}}},		 	down = iCommandViewCameraDownSlow, name = _('Camera view down slow'), category = _('View Cockpit')},
{combos = {{key = 'Num4', reformers = {'RAlt'}}}, 			down = iCommandViewCameraLeftSlow, name = _('Camera view left slow'), category = _('View Cockpit')},
{combos = {{key = 'Num6', reformers = {'RAlt'}}},		 	down = iCommandViewCameraRightSlow, name = _('Camera view right slow'), category = _('View Cockpit')},
{combos = {{key = 'Num7', reformers = {'RAlt'}}},		 	down = iCommandViewCameraUpLeftSlow, name = _('Camera view up-left slow'), category = _('View Cockpit')},
{combos = {{key = 'Num1', reformers = {'RAlt'}}}, 			down = iCommandViewCameraDownLeftSlow, name = _('Camera view down-left slow'), category = _('View Cockpit')},
{combos = {{key = 'Num9', reformers = {'RAlt'}}},		 	down = iCommandViewCameraDownRight, name = _('Camera view down-right slow'), category = _('View Cockpit')},
{combos = {{key = 'Num3', reformers = {'RAlt'}}},		 	down = iCommandViewCameraUpRightSlow, name = _('Camera view up-right slow'), category = _('View Cockpit')},
{combos = {{key = 'Num5', reformers = {'RShift'}}},			down = iCommandViewCameraCenter, name = _('Center camera view'), category = _('View Cockpit')},
{combos = {{key = 'Num5', reformers = {'RCtrl'}}},		 	down = iCommandViewCameraReturn, name = _('Return camera'), category = _('View Cockpit')},
{combos = {{key = 'Num5', reformers = {'RAlt'}}}, 			down = iCommandViewCameraBaseReturn, name = _('Return camera base'), category = _('View Cockpit')},

{combos = {{key = 'Num0', reformers = {'LWin'}}},			down = iCommandViewSnapView0,	up = iCommandViewSnapViewStop, name = _('Snap View 0'), category = _('View Cockpit')},
{combos = {{key = 'Num1', reformers = {'LWin'}}}, 			down = iCommandViewSnapView1,	up = iCommandViewSnapViewStop, name = _('Snap View 1'), category = _('View Cockpit')},
{combos = {{key = 'Num2', reformers = {'LWin'}}}, 			down = iCommandViewSnapView2,	up = iCommandViewSnapViewStop, name = _('Snap View 2'), category = _('View Cockpit')},
{combos = {{key = 'Num3', reformers = {'LWin'}}}, 			down = iCommandViewSnapView3,	up = iCommandViewSnapViewStop, name = _('Snap View 3'), category = _('View Cockpit')},
{combos = {{key = 'Num4', reformers = {'LWin'}}}, 			down = iCommandViewSnapView4,	up = iCommandViewSnapViewStop, name = _('Snap View 4'), category = _('View Cockpit')},
{combos = {{key = 'Num5', reformers = {'LWin'}}}, 			down = iCommandViewSnapView5,	up = iCommandViewSnapViewStop, name = _('Snap View 5'), category = _('View Cockpit')},
{combos = {{key = 'Num6', reformers = {'LWin'}}}, 			down = iCommandViewSnapView6,	up = iCommandViewSnapViewStop, name = _('Snap View 6'), category = _('View Cockpit')},
{combos = {{key = 'Num7', reformers = {'LWin'}}},			down = iCommandViewSnapView7,	up = iCommandViewSnapViewStop, name = _('Snap View 7'), category = _('View Cockpit')},
{combos = {{key = 'Num8', reformers = {'LWin'}}}, 			down = iCommandViewSnapView8,	up = iCommandViewSnapViewStop, name = _('Snap View 8'), category = _('View Cockpit')},
{combos = {{key = 'Num9', reformers = {'LWin'}}}, 			down = iCommandViewSnapView9,	up = iCommandViewSnapViewStop, name = _('Snap View 9'), category = _('View Cockpit')},

{combos = {{key = 'N', reformers = {'RWin'}}}, 				down = iCommandViewLeftMirrorOn ,	up = iCommandViewLeftMirrorOff , name = _('Mirror glance'), category = _('View Cockpit')},


{combos = {{key = 'Num*', reformers = {'RShift'}}}, 		pressed = iCommandViewForward, up = iCommandViewForwardStop, name = _('Zoom in'), category = _('View Cockpit')},
{combos = {{key = 'Num/', reformers = {'RShift'}}}, 		pressed = iCommandViewBack, up = iCommandViewBackStop, name = _('Zoom out'), category = _('View Cockpit')},


-- Cockpit Camera Motion (������������ ������ � ������)
{combos = {{key = 'Num8', reformers = {'RCtrl','RShift'}}}, pressed = iCommandViewPitCameraMoveUp, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Up'), category = _('View Cockpit')},
{combos = {{key = 'Num2', reformers = {'RCtrl','RShift'}}}, pressed = iCommandViewPitCameraMoveDown, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Down'), category = _('View Cockpit')},
{combos = {{key = 'Num4', reformers = {'RCtrl','RShift'}}}, pressed = iCommandViewPitCameraMoveLeft, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Left'), category = _('View Cockpit')},
{combos = {{key = 'Num6', reformers = {'RCtrl','RShift'}}}, pressed = iCommandViewPitCameraMoveRight, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Right'), category = _('View Cockpit')},
{combos = {{key = 'Num*', reformers = {'RCtrl','RShift'}}}, pressed = iCommandViewPitCameraMoveForward, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Forward'), category = _('View Cockpit')},
{combos = {{key = 'Num/', reformers = {'RCtrl','RShift'}}, {key = 'Num-', reformers = {'RCtrl','RShift'}}}, pressed = iCommandViewPitCameraMoveBack, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Back'), category = _('View Cockpit')},
{combos = {{key = 'Num5', reformers = {'RCtrl','RShift'}}}, down = iCommandViewPitCameraMoveCenter, name = _('Cockpit Camera Move Center'), category = _('View Cockpit')},

{down = iCommand_ExplorationStart, name = _('Enable visual recon mode'), category = _('View Cockpit')},
{combos = {{key = 'F1', reformers = {'LShift'}}},  down = iCommandViewTransposeModeOn, up = iCommandViewTransposeModeOff, name = _('Camera transpose mode (press and hold)'), category = _('View Cockpit')},

-- Extended view
{combos = {{key = 'J', reformers = {'LShift'}}}, 			down = iCommandViewCameraJiggle, name = _('Camera jiggle toggle'), category = _('View Extended')},
{combos = {{key = 'K', reformers = {'LAlt'}}}, 				down = iCommandViewKeepTerrain, name = _('Camera terrain altitude hold'), category = _('View Extended')},
{combos = {{key = 'Home', reformers = {'RCtrl','RShift'}}}, down = iCommandViewFriends, name = _('View friends mode'), category = _('View Extended')},
{combos = {{key = 'End', reformers = {'RCtrl' ,'RShift'}}}, down = iCommandViewEnemies, name = _('View enemies mode'), category = _('View Extended')},
{combos = {{key = 'Delete', reformers = {'RCtrl'}}}, 		down = iCommandViewAll, name = _('View all mode'), category = _('View Extended')},
{combos = {{key = 'Num+', reformers = {'RCtrl'}}}, 		down = iCommandViewPlus, name = _('Toggle tracking launched weapon'), category = _('View Extended')},
{combos = {{key = 'PageDown', reformers = {'LCtrl'}}}, 		down = iCommandViewSwitchForward, name = _('Objects switching direction forward '), category = _('View Extended')},
{combos = {{key = 'PageUp', reformers = {'LCtrl'}}}, 		down = iCommandViewSwitchReverse, name = _('Objects switching direction reverse '), category = _('View Extended')},
{combos = {{key = 'Delete', reformers = {'LAlt'}}}, 		down = iCommandViewObjectIgnore, name = _('Object exclude '), category = _('View Extended')},
{combos = {{key = 'Insert', reformers = {'LAlt'}}}, 		down = iCommandViewObjectsAll, name = _('Objects all excluded - include'), category = _('View Extended')},

-- Padlock

{combos = {{key = 'Num.', reformers = {'RShift'}}}, 		down = iCommandAllMissilePadlock, name = _('Padlock missiles all'), category = _('View Padlock')},
{combos = {{key = 'Num.', reformers = {'RAlt'}}}, 			down = iCommandThreatMissilePadlock, name = _('Padlock missile threat'), category = _('View Padlock')},
{combos = {{key = 'Num.'}}, 								down = iCommandViewLock, name = _('Padlock cycle'), category = _('View Padlock')},
{combos = {{key = 'NumLock'}}, 								down = iCommandViewUnlock, name = _('Padlock Off (stop padlock)'), category = _('View Padlock')},
{combos = {{key = 'Num.', reformers = {'RCtrl'}}}, 			down = iCommandViewTerrainLock, name = _('Padlock terrain point'), category = _('View Padlock')},


-- Labels
{combos = {{key = 'F10', reformers = {'LShift'}}}, 			down = iCommandMarkerState, name = _('Labels All'), category = _('Labels')},
{combos = {{key = 'F2', reformers = {'LShift'}}}, 			down = iCommandMarkerStatePlane, name = _('Labels Aircraft'), category = _('Labels')},
{combos = {{key = 'F6', reformers = {'LShift'}}}, 			down = iCommandMarkerStateRocket, name = _('Labels Missile'), category = _('Labels')},
{combos = {{key = 'F9', reformers = {'LShift'}}}, 			down = iCommandMarkerStateShip, name = _('Labels Vehicle & Ship'), category = _('Labels')},

-- Flight Control
{combos = {{key = 'Up'}},									down = iCommandPlaneUpStart, up = iCommandPlaneUpStop, name = _('Aircraft Pitch Down'), category = _('Flight Control')},
{combos = {{key = 'Down'}},									down = iCommandPlaneDownStart, up = iCommandPlaneDownStop, name = _('Aircraft Pitch Up'), category = _('Flight Control')},
{combos = {{key = 'Left'}},									down = iCommandPlaneLeftStart, up = iCommandPlaneLeftStop, name = _('Aircraft Bank Left'), category = _('Flight Control')},
{combos = {{key = 'Right'}},								down = iCommandPlaneRightStart, up = iCommandPlaneRightStop, name = _('Aircraft Bank Right'), category = _('Flight Control')},
{combos = {{key = 'Z'}},									down = iCommandPlaneLeftRudderStart, up = iCommandPlaneLeftRudderStop, name = _('Aircraft Rudder Left'), category = _('Flight Control')},
{combos = {{key = 'X'}},									down = iCommandPlaneRightRudderStart, up = iCommandPlaneRightRudderStop, name = _('Aircraft Rudder Right'), category = _('Flight Control')},

{combos = {{key = 'Num+'}}, 								pressed = device_commands.Button_23, cockpit_device_id  = devices.ENGINE_SYSTEM, value_pressed = 1.0, 	name = _('Throttle Up'), category = _('Flight Control')},
{combos = {{key = 'Num-'}}, 								pressed = device_commands.Button_23, cockpit_device_id  = devices.ENGINE_SYSTEM, value_pressed = -1.0,	name = _('Throttle Down'), category = _('Flight Control')},
{combos = {{key = 'PageUp'}}, 								pressed = device_commands.Button_24, cockpit_device_id  = devices.ENGINE_SYSTEM, value_pressed = 1.0,	name = _('Engine RPM Increase'), category = _('Flight Control')},
{combos = {{key = 'PageDown'}}, 							pressed = device_commands.Button_24, cockpit_device_id  = devices.ENGINE_SYSTEM, value_pressed = -1.0,	name = _('Engine RPM Decrease'), category = _('Flight Control')},

{combos = {{key = 'E'}},									down = iCommandPlane_P_51_WarEmergencyPower, name = _('War Emergency Power'), category = _('Flight Control')},

{combos = {{key = 'M', reformers = {'LShift'}}}, 			down = device_commands.Button_11, cockpit_device_id  = devices.ENGINE_SYSTEM, value_down = 0.0, name = _('Mixture IDLE CUT OFF'), category = _('Flight Control')},
{combos = {{key = 'M', reformers = {'LCtrl'}}}, 			down = device_commands.Button_11, cockpit_device_id  = devices.ENGINE_SYSTEM, value_down = 0.1, name = _('Mixture RUN'), category = _('Flight Control')},
{combos = {{key = 'M', reformers = {'LAlt'}}}, 				down = device_commands.Button_11, cockpit_device_id  = devices.ENGINE_SYSTEM, value_down = 0.2, name = _('Mixture EMERGENCY FULL RICH'), category = _('Flight Control')},
{combos = {{key = 'M'}},						 			down = device_commands.Button_20, cockpit_device_id  = devices.ENGINE_SYSTEM, value_down = 1.0, name = _('Mixture control (rotary)'), category = _('Flight Control')},

{combos = {{key = 'X', reformers = {'LShift'}}}, 			down = device_commands.Button_15, up = device_commands.Button_15, cockpit_device_id  = devices.CONTROL_SYSTEM, value_down = 1.0, value_up = 0.0, name = _('Stick lock in the Forward Position'), category = _('Flight Control')},
{combos = {{key = 'X', reformers = {'LAlt'}}},				down = device_commands.Button_16, up = device_commands.Button_16, cockpit_device_id  = devices.CONTROL_SYSTEM, value_down = 1.0, value_up = 0.0, name = _('Stick lock in the Neutral Position'), category = _('Flight Control')},

{combos = {{key = 'X', reformers = {'LCtrl'}}}, 			pressed = device_commands.Button_13, cockpit_device_id  = devices.ENGINE_SYSTEM, value_pressed = 1.0, name = _('Throttle Control Lock'), category = _('Flight Control')},
{combos = {{key = 'X', reformers = {'LCtrl', 'LAlt'}}},		pressed = device_commands.Button_13, cockpit_device_id  = devices.ENGINE_SYSTEM, value_pressed = -1.0, name = _('Throttle Control Unlock'), category = _('Flight Control')},
{combos = {{key = 'X', reformers = {'LShift', 'LAlt'}}}, 	pressed = device_commands.Button_15, cockpit_device_id  = devices.ENGINE_SYSTEM, value_pressed = 1.0, name = _('Propeller & Mixture Lock'), category = _('Flight Control')},
{combos = {{key = 'X', reformers = {'LShift', 'LCtrl', 'LAlt'}}},	pressed = device_commands.Button_15, cockpit_device_id  = devices.ENGINE_SYSTEM, value_pressed = -1.0, name = _('Propeller & Mixture Unlock'), category = _('Flight Control')},

--flaps
{combos = {{key = 'F', reformers = {'LShift'}}} , 			down = device_commands.Button_2, cockpit_device_id  = devices.CONTROL_SYSTEM, value_down = 1.0, name = _('Flaps Up'), category = _('Flight Control')},
{combos = {{key = 'F'}}, 									down = device_commands.Button_2, cockpit_device_id  = devices.CONTROL_SYSTEM, value_down = 0.0, name = _('Flaps Down'), category = _('Flight Control')},

--Trimmers
{combos = {{key = ',', reformers = {'RCtrl'}}}, 			pressed = device_commands.Button_11, cockpit_device_id  = devices.CONTROL_SYSTEM, value_pressed = -0.1, name = _('Trim Aileron Left'), category = _('Flight Control')},
{combos = {{key = '/', reformers = {'RCtrl'}}}, 			pressed = device_commands.Button_11, cockpit_device_id  = devices.CONTROL_SYSTEM, value_pressed = 0.1, name = _('Trim Aileron Right'), category = _('Flight Control')},
{combos = {{key = ';', reformers = {'RCtrl'}}}, 			pressed = device_commands.Button_12, cockpit_device_id  = devices.CONTROL_SYSTEM, value_pressed = 0.05, name = _('Trim Elevator Down'), category = _('Flight Control')},
{combos = {{key = '.', reformers = {'RCtrl'}}}, 			pressed = device_commands.Button_12, cockpit_device_id  = devices.CONTROL_SYSTEM, value_pressed = -0.05, name = _('Trim Elevator Up'), category = _('Flight Control')},
{combos = {{key = 'Z', reformers = {'RCtrl'}}},				pressed = device_commands.Button_13, cockpit_device_id  = devices.CONTROL_SYSTEM, value_pressed = -0.1, name = _('Trim Rudder Left'), category = _('Flight Control')},
{combos = {{key = 'X', reformers = {'RCtrl'}}}, 			pressed = device_commands.Button_13, cockpit_device_id  = devices.CONTROL_SYSTEM, value_pressed = 0.1, name = _('Trim Rudder Right'), category = _('Flight Control')},
{combos = {{key = 'T', reformers = {'LCtrl'}}}, 			down = device_commands.Button_14, cockpit_device_id  = devices.CONTROL_SYSTEM, value_down = 1.0, name = _('Trimmers Reset'), category = _('Flight Control')},

-- Systems
{combos = {{key = 'W'}}, 									down = iCommandPlaneWheelBrakeOn, up = iCommandPlaneWheelBrakeOff, name = _('Wheel brake Both'), category = _('Systems')},
{combos = {{key = 'W', reformers = {'LCtrl'}}}, 			down = iCommandPlaneWheelBrakeLeftOn, up = iCommandPlaneWheelBrakeLeftOff, name = _('Wheel brake Left'), category = _('Systems')},
{combos = {{key = 'W', reformers = {'LAlt'}}}, 				down = iCommandPlaneWheelBrakeRightOn, up = iCommandPlaneWheelBrakeRightOff, name = _('Wheel brake Right'), category = _('Systems')},
{combos = {{key = 'W', reformers = {'LCtrl', 'LAlt'}}},		down = device_commands.Button_6, up = device_commands.Button_6, cockpit_device_id  = devices.CONTROL_SYSTEM, value_down = 1.0,	value_up = 0.0, name = _('Wheel brake Parking'), category = _('Systems')},
{combos = {{key = 'E', reformers = {'LCtrl'}}}, 			down = iCommandPlaneEject, name = _('Bailout'), category = _('Systems')},

{combos = {{key = 'C', reformers = {'LCtrl'}}}, 			pressed = device_commands.Button_4, cockpit_device_id  = devices.CPT_MECH, value_pressed = -1.0, name = _('Canopy Closing'), category = _('Systems')},
{combos = {{key = 'C', reformers = {'LShift'}}}, 			pressed = device_commands.Button_4, cockpit_device_id  = devices.CPT_MECH, value_pressed = 1.0, name = _('Canopy Opening'), category = _('Systems')},
{combos = {{key = 'C', reformers = {'LShift', 'LCtrl'}}},	down = device_commands.Button_5, cockpit_device_id  = devices.CPT_MECH, value_down = 1.0, name = _('Canopy Emergency Release'), category = _('Systems')},

{down = device_commands.Button_2, cockpit_device_id  = devices.HYDRAULIC_SYSTEM, value_down = 1.0, name = _('Hydraulic Emergency Release Knob'), category = _('Systems')},

{combos = {{key = 'G'}}, 									down = device_commands.Button_4, cockpit_device_id  = devices.CONTROL_SYSTEM, value_down = 1.0, name = _('Landing Gear Up/Down'), category = _('Systems')},
{                       									down = device_commands.Button_4, cockpit_device_id  = devices.CONTROL_SYSTEM, value_down = 0.1, name = _('Landing Gear Down'),    category = _('Systems')},
{                       									down = device_commands.Button_4, cockpit_device_id  = devices.CONTROL_SYSTEM, value_down = 0.2, name = _('Landing Gear Up'),      category = _('Systems')},
{down = device_commands.Button_18, up = device_commands.Button_18, cockpit_device_id  = devices.CONTROL_SYSTEM, value_down = 1.0, value_up = 0.0, name = _('Landing Gear Safe Light Test'), category = _('Systems')},
{down = device_commands.Button_7, up = device_commands.Button_7, cockpit_device_id  = devices.CONTROL_SYSTEM, value_down = 1.0, value_up = 0.0, name = _('Landing Gear Unsafe Light Test'), category = _('Systems')},

{combos = {{key = 'B', reformers = {'RShift'}}},			down = device_commands.Button_2, cockpit_device_id  = devices.OXYGEN_SYSTEM, value_down = 1.0, name = _('Oxygen regulator Deluter lever Auto-Mix On-Off'), category = _('Systems')},
{combos = {{key = 'B', reformers = {'RCtrl'}}},				down = device_commands.Button_4, cockpit_device_id  = devices.OXYGEN_SYSTEM, value_down = 1.0, name = _('Oxygen regulator Emergency By-Pass Valve'), category = _('Systems')},

--Right Switch Panel
{combos = {{key = 'B'}},									down = device_commands.Button_2, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0,	 name = _('Battery'), category = _('Right Switch Panel')},
{combos = {{key = 'V'}},									down = device_commands.Button_4, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0,	 name = _('Generator'), category = _('Right Switch Panel')},
{combos = {{key = 'C', reformers = {'LShift', 'LAlt'}}}, 	down = device_commands.Button_20, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0, name = _('Gun heat'), category = _('Right Switch Panel')},
{combos = {{key = 'P', reformers = {'RCtrl'}}}, 			down = device_commands.Button_6, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0,	 name = _('Pitot heat'), category = _('Right Switch Panel')},

{combos = {{key = 'U', reformers = {'RCtrl'}}}, 			down = device_commands.Button_8, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = -1.0, name = _('Position lights wing DIM'), category = _('Right Switch Panel')},
{combos = {{key = 'U', reformers = {'RShift'}}}, 			down = device_commands.Button_8, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 0.0,	 name = _('Position lights wing OFF'), category = _('Right Switch Panel')},
{combos = {{key = 'U', reformers = {'RAlt'}}},				down = device_commands.Button_8, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0,	 name = _('Position lights wing BRIGHT'), category = _('Right Switch Panel')},
{combos = {{key = 'U'}},									down = device_commands.Button_17, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0,	 name = _('Position lights wing (rotary)'), category = _('Right Switch Panel')},

{combos = {{key = 'I', reformers = {'RCtrl', 'RShift'}}}, 	down = device_commands.Button_9, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = -1.0, name = _('Position light tail DIM'), category = _('Right Switch Panel')},
{combos = {{key = 'I', reformers = {'RShift'}}}, 			down = device_commands.Button_9, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 0.0,	 name = _('Position light tail OFF'), category = _('Right Switch Panel')},
{combos = {{key = 'I', reformers = {'RAlt'}}},				down = device_commands.Button_9, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0,	 name = _('Position light tail BRIGHT'), category = _('Right Switch Panel')},
{combos = {{key = 'I'}},									down = device_commands.Button_18, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0,	 name = _('Position light tail (rotary)'), category = _('Right Switch Panel')},


{combos = {{key = 'Y', reformers = {'RCtrl', 'RShift'}}}, 	down = device_commands.Button_21, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0, name = _('Recognition light red Steady'), category = _('Right Switch Panel')},
{combos = {{key = 'U', reformers = {'LCtrl', 'LShift'}}}, 	down = device_commands.Button_22, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0, name = _('Recognition light green Steady'), category = _('Right Switch Panel')},
{combos = {{key = 'I', reformers = {'LCtrl', 'LShift'}}}, 	down = device_commands.Button_23, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0, name = _('Recognition light amber Steady'), category = _('Right Switch Panel')},
{combos = {{key = 'Y', reformers = {'RShift'}}}, 			down = device_commands.Button_21, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 0.0, name = _('Recognition light red Off'), category = _('Right Switch Panel')},
{combos = {{key = 'U', reformers = {'LShift'}}}, 			down = device_commands.Button_22, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 0.0, name = _('Recognition light green Off'), category = _('Right Switch Panel')},
{combos = {{key = 'I', reformers = {'LShift'}}}, 			down = device_commands.Button_23, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 0.0, name = _('Recognition light amber Off'), category = _('Right Switch Panel')},
{combos = {{key = 'Y', reformers = {'RAlt'}}}, 				down = device_commands.Button_21, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = -1.0, name = _('Recognition light red Key'), category = _('Right Switch Panel')},
{combos = {{key = 'U', reformers = {'LAlt'}}}, 				down = device_commands.Button_22, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = -1.0, name = _('Recognition light green Key'), category = _('Right Switch Panel')},
{combos = {{key = 'I', reformers = {'LAlt'}}}, 				down = device_commands.Button_23, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = -1.0, name = _('Recognition light amber Key'), category = _('Right Switch Panel')},

{combos = {{key = 'Y', reformers = {'RCtrl'}}}, 			down = device_commands.Button_30, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0, name = _('Recognition light red (rotary)'), category = _('Right Switch Panel')},
{combos = {{key = 'U', reformers = {'LCtrl'}}}, 			down = device_commands.Button_31, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0, name = _('Recognition light green (rotary)'), category = _('Right Switch Panel')},
{combos = {{key = 'I', reformers = {'LCtrl'}}}, 			down = device_commands.Button_32, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0, name = _('Recognition light amber (rotary)'), category = _('Right Switch Panel')},

{combos = {{key = 'Y'}}, 									down = device_commands.Button_24, up = device_commands.Button_24, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0, value_up = 0.0, name = _('Recognition lights key'), category = _('Right Switch Panel')},
{down = device_commands.Button_25, up = device_commands.Button_25, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_down = 1.0, value_up = 0.0, name = _('Circuit Protectors Cover'), category = _('Right Switch Panel')},


--Remote compass 
{combos = {{key = 'C', reformers = {'RAlt'}}}, 				pressed = device_commands.Button_2, cockpit_device_id = 23, value_pressed = -1.0, name = _('Compass course Decrease'), category = _('Front Dash')},
{combos = {{key = 'C', reformers = {'RCtrl'}}},				pressed = device_commands.Button_2, cockpit_device_id = 23, value_pressed = 1.0, name = _('Compass course Increase'), category = _('Front Dash')},

--Directional gyro 
{combos = {{key = 'G', reformers = {'RAlt'}}},				pressed = device_commands.Button_2, cockpit_device_id  = devices.DIRECTIONAL_GYRO, value_pressed =-1.0, name = _('Directional gyro heading Decrease'), category = _('Front Dash')},
{combos = {{key = 'G', reformers = {'RCtrl'}}},				pressed = device_commands.Button_2, cockpit_device_id  = devices.DIRECTIONAL_GYRO, value_pressed = 1.0, name = _('Directional gyro heading Increase'), category = _('Front Dash')},
{combos = {{key = 'G', reformers = {'RShift'}}},			down = device_commands.Button_4, cockpit_device_id  = devices.DIRECTIONAL_GYRO, value_down = 1, name = _('Directional gyro Cage/Uncage'), category = _('Front Dash')},

--	AN5736 Flight Indicator (Gyro Horizon Indicator) 
{combos = {{key = 'V', reformers = {'RCtrl'}}},				pressed = device_commands.Button_4, cockpit_device_id  = devices.ARTIFICIAL_HORIZON, value_pressed = -1.0, name = _('Horizon pitch Decrease'), category = _('Front Dash')},
{combos = {{key = 'V', reformers = {'RAlt'}}},				pressed = device_commands.Button_4, cockpit_device_id  = devices.ARTIFICIAL_HORIZON, value_pressed = 1.0, name = _('Horizon pitch Increase'), category = _('Front Dash')},
{combos = {{key = 'V', reformers = {'LShift'}}},			down = device_commands.Button_5, cockpit_device_id  = devices.ARTIFICIAL_HORIZON, value_down = 1.0, name = _('Horizon Cage'), category = _('Front Dash')},
{combos = {{key = 'V', reformers = {'LAlt'}}},				pressed = device_commands.Button_6, cockpit_device_id  = devices.ARTIFICIAL_HORIZON, value_pressed = -1.0, name = _('Horizon cage knob OFF'), category = _('Front Dash')},
{combos = {{key = 'V', reformers = {'LCtrl'}}},				pressed = device_commands.Button_6, cockpit_device_id  = devices.ARTIFICIAL_HORIZON, value_pressed = 1.0, name = _('Horizon cage knob ON'), category = _('Front Dash')},

--Clock 
{combos = {{key = 'Q', reformers = {'RShift'}}},			down = device_commands.Button_3, cockpit_device_id  = devices.CLOCK, value_down = 1.0,  name = _('Clock Winding/Adjust'), category = _('Front Dash')},
{combos = {{key = 'Q', reformers = {'RCtrl'}}},				pressed = device_commands.Button_4, cockpit_device_id  = devices.CLOCK, value_pressed = -1.0, name = _('Clock Winding/Adjust Decrease'), category = _('Front Dash')},
{combos = {{key = 'Q', reformers = {'RAlt'}}},				pressed = device_commands.Button_4, cockpit_device_id  = devices.CLOCK, value_pressed = 1.0, name = _('Clock Winding/Adjust Increase'), category = _('Front Dash')},

--Altimeter 
{combos = {{key = 'B', reformers = {'LCtrl'}}},				pressed = device_commands.Button_2, cockpit_device_id  = devices.ALTIMETER, value_pressed = -1.0, name = _('Altimeter pressure set Decrease'), category = _('Front Dash')},
{combos = {{key = 'B', reformers = {'LShift'}}},			pressed = device_commands.Button_2, cockpit_device_id  = devices.ALTIMETER, value_pressed = 1.0, name = _('Altimeter pressure set Increase'), category = _('Front Dash')},

--G-meter 
{combos = {{key = 'G', reformers = {'LShift'}}},			down = device_commands.Button_1, up = device_commands.Button_1, cockpit_device_id  = devices.ACCELEROMETER, value_down = 0.6, value_up = 0.0, name = _('G-meter Reset'), category = _('Front Dash')},

--VHF Radio 
{combos = {{key = '`', reformers = {'LCtrl'}}},				down = device_commands.Button_9, cockpit_device_id  = devices.VHF_RADIO, value_down = 1.0, name = _('Radio Power'), category = _('VHF Radio')},
{combos = {{key = '1', reformers = {'LCtrl'}}},				down = device_commands.Button_10, cockpit_device_id  = devices.VHF_RADIO, value_down = 1.0, name = _('Radio chanel A'), category = _('VHF Radio')},
{combos = {{key = '2', reformers = {'LCtrl'}}},				down = device_commands.Button_11, cockpit_device_id  = devices.VHF_RADIO, value_down = 1.0, name = _('Radio chanel B'), category = _('VHF Radio')},
{combos = {{key = '3', reformers = {'LCtrl'}}},				down = device_commands.Button_12, cockpit_device_id  = devices.VHF_RADIO, value_down = 1.0, name = _('Radio chanel C'), category = _('VHF Radio')},
{combos = {{key = '4', reformers = {'LCtrl'}}},				down = device_commands.Button_13, cockpit_device_id  = devices.VHF_RADIO, value_down = 1.0, name = _('Radio chanel D'), category = _('VHF Radio')},
{pressed = device_commands.Button_14, cockpit_device_id  = devices.VHF_RADIO, value_pressed = -1.0, name = _('Radio lights dimmer Decrease'), category = _('VHF Radio')},
{pressed = device_commands.Button_14, cockpit_device_id  = devices.VHF_RADIO, value_pressed = 1.0, name = _('Radio lights dimmer Increase'), category = _('VHF Radio')},

{combos = {{key = '5', reformers = {'LAlt'}}},				down = device_commands.Button_8, up = device_commands.Button_8, cockpit_device_id  = devices.VHF_RADIO, value_down = -1.0, value_up = 0.0, name = _('Radio Mode T'), category = _('VHF Radio')},
{combos = {{key = '5', reformers = {'LCtrl'}}},				down = device_commands.Button_7, cockpit_device_id  = devices.VHF_RADIO, value_down = 0.0, name = _('Radio mode R'), category = _('VHF Radio')},
{combos = {{key = '5', reformers = {'LShift'}}},			down = device_commands.Button_7, cockpit_device_id  = devices.VHF_RADIO, value_down = 1.0, name = _('Radio mode REM'), category = _('VHF Radio')},
{combos = {{key = '5', reformers = {'LCtrl', 'LAlt'}}},		down = device_commands.Button_18,  cockpit_device_id  = devices.VHF_RADIO, value_down = 1.0,  name = _('Radio mode switch locking lever'), category = _('VHF Radio')},
{combos = {{key = '6', reformers = {'RCtrl'}}},				pressed = device_commands.Button_16, cockpit_device_id  = devices.VHF_RADIO, value_pressed = -1.0, name = _('VHF radio volume Decrease'), category = _('VHF Radio')},
{combos = {{key = '6', reformers = {'RAlt'}}},				pressed = device_commands.Button_16, cockpit_device_id  = devices.VHF_RADIO, value_pressed = 1.0, name = _('VHF radio volume Increase'), category = _('VHF Radio')},

{combos = {{key = 'End', reformers = {'RShift'}}}, 			down = device_commands.Button_2, cockpit_device_id  = devices.FRONT_SWITCH_BOX, value_down = 0.0,	 name = _('Ignition switch OFF'), category = _('Front Switch Box')},
{down = device_commands.Button_2, cockpit_device_id  = devices.FRONT_SWITCH_BOX, value_down = 0.1,	 name = _('Ignition switch Right'), category = _('Front Switch Box')},
{down = device_commands.Button_2, cockpit_device_id  = devices.FRONT_SWITCH_BOX, value_down = 0.2,	 name = _('Ignition switch Left'), category = _('Front Switch Box')},
{combos = {{key = 'End', reformers = {'RCtrl'}}}, 			down = device_commands.Button_2, cockpit_device_id  = devices.FRONT_SWITCH_BOX, value_down = 0.3,	 name = _('Ignition switch BOTH'), category = _('Front Switch Box')},
{combos = {{key = 'End'}}, 									down = device_commands.Button_6, cockpit_device_id  = devices.FRONT_SWITCH_BOX, value_down = 0.3,	 name = _('Ignition switch (rotary)'), category = _('Front Switch Box')},

{combos = {{key = 'L', reformers = {'RCtrl'}}}, 			pressed = device_commands.Button_3, cockpit_device_id  = devices.FRONT_SWITCH_BOX, value_pressed = -1.0, name = _('Cockpit Lights Decrease'), category = _('Front Switch Box')},
{combos = {{key = 'L', reformers = {'RAlt'}}}, 				pressed = device_commands.Button_3, cockpit_device_id  = devices.FRONT_SWITCH_BOX, value_pressed = 1.0, name = _('Cockpit Lights Increase'), category = _('Front Switch Box')},

{combos = {{key = 'H', reformers = {'RAlt'}}}, 				down = device_commands.Button_8, up = device_commands.Button_8, cockpit_device_id  = devices.FRONT_SWITCH_BOX, value_down = 1.0,	value_up = 0.0, name = _('Silence Horn'), category = _('Front Switch Box')},

--Engine control panel
{combos = {{key = 'S', reformers = {'RCtrl', 'RShift'}}},	down = device_commands.Button_3, cockpit_device_id  = devices.ENGINE_CONTROL_PANEL, value_down = 1.0, name = _('Supercharger switch Cover'), category = _('Engine Control Panel')},
{combos = {{key = 'S', reformers = {'RAlt'}}},				down = device_commands.Button_1, cockpit_device_id  = devices.ENGINE_CONTROL_PANEL, value_down = 0.0, name = _('Supercharger switch AUTO'), category = _('Engine Control Panel')},
{combos = {{key = 'S', reformers = {'RCtrl'}}},				down = device_commands.Button_1, cockpit_device_id  = devices.ENGINE_CONTROL_PANEL, value_down = 0.1, name = _('Supercharger switch LOW'), category = _('Engine Control Panel')},
{combos = {{key = 'S', reformers = {'RShift'}}},			down = device_commands.Button_1, up = device_commands.Button_1, cockpit_device_id  = devices.ENGINE_CONTROL_PANEL, value_down = 0.2, value_up = 0.1, name = _('Supercharger switch HIGH'), category = _('Engine Control Panel')},

{combos = {{key = 'L', reformers = {'LShift'}}},			down = device_commands.Button_4, up = device_commands.Button_4, cockpit_device_id  = devices.ENGINE_CONTROL_PANEL, value_down = 1.0, value_up = 0.0, name = _('High Blower lamp test'), category = _('Engine Control Panel')},
{combos = {{key = 'Delete'}},								down = device_commands.Button_6, cockpit_device_id  = devices.ENGINE_CONTROL_PANEL, value_down = 1.0, name = _('Fuel Booster'), category = _('Engine Control Panel')},
{combos = {{key = 'Delete', reformers = {'LShift'}}},		down = device_commands.Button_12, cockpit_device_id = devices.ENGINE_CONTROL_PANEL, value_down = 1.0, name = _('Fuel Booster ON'), category = _('Engine Control Panel')},
{combos = {{key = 'Delete', reformers = {'LCtrl'}}},		down = device_commands.Button_12, cockpit_device_id = devices.ENGINE_CONTROL_PANEL, value_down = 0.0, name = _('Fuel Booster OFF'), category = _('Engine Control Panel')},
{down = device_commands.Button_7, up = device_commands.Button_7, cockpit_device_id  = devices.ENGINE_CONTROL_PANEL, value_down = 1.0, value_up = 0.0, name = _('Oil Dilute'), category = _('Engine Control Panel')},
{combos = {{key = 'Home'}},									down = device_commands.Button_8, up = device_commands.Button_8, cockpit_device_id  = devices.ENGINE_CONTROL_PANEL, value_down = 1.0, value_up = 0.0, name = _('Starter'), category = _('Engine Control Panel')},
{combos = {{key = 'Home', reformers = {'RShift'}}},			down = device_commands.Button_10, cockpit_device_id  = devices.ENGINE_CONTROL_PANEL, value_down = 1.0, name = _('Starter Switch Cover'), category = _('Engine Control Panel')},
{combos = {{key = 'Insert'}},								down = device_commands.Button_11, up = device_commands.Button_11, cockpit_device_id  = devices.ENGINE_CONTROL_PANEL, value_down = 1.0, value_up = 0.0, name = _('Primer'), category = _('Engine Control Panel')},

--Fuel Control
{combos = {{key = 'T', reformers = {'RShift'}}},			down = device_commands.Button_1, cockpit_device_id  = devices.FUEL_SYSTEM, value_down = 0.0, name = _('Fuel selector Right Combat Tank'), category = _('Fuel Control')},
{combos = {{key = 'T', reformers = {'LAlt'}}},				down = device_commands.Button_1, cockpit_device_id  = devices.FUEL_SYSTEM, value_down = 0.1, name = _('Fuel selector Left Main Tank'), category = _('Fuel Control')},
{combos = {{key = 'T', reformers = {'RCtrl'}}},				down = device_commands.Button_1, cockpit_device_id  = devices.FUEL_SYSTEM, value_down = 0.2, name = _('Fuel selector Fuselage Tank'), category = _('Fuel Control')},
{combos = {{key = 'T', reformers = {'RAlt'}}},				down = device_commands.Button_1, cockpit_device_id  = devices.FUEL_SYSTEM, value_down = 0.3, name = _('Fuel selector Right Main Tank'), category = _('Fuel Control')},
{combos = {{key = 'T', reformers = {'LShift'}}},			down = device_commands.Button_1, cockpit_device_id  = devices.FUEL_SYSTEM, value_down = 0.4, name = _('Fuel selector Left Combat Tank'), category = _('Fuel Control')},
{combos = {{key = 'T', reformers = {'LCtrl', 'LShift'}}},	down = device_commands.Button_3, cockpit_device_id  = devices.FUEL_SYSTEM, value_down = 1.0, name = _('Fuel shut-off valve'), category = _('Fuel Control')},
{combos = {{key = 'T'}},									down = device_commands.Button_6, cockpit_device_id  = devices.FUEL_SYSTEM, value_down = 1.0, name = _('Fuel selector valve (rotary)'), category = _('Fuel Control')},

--Rear Warning Radar
{combos = {{key = 'R'}},									down = device_commands.Button_2, cockpit_device_id  = devices.TAIL_WARNING_RADAR, value_down = 1.0, name = _('Rear warning radar Power'), category = _('Rear Warning Radar')},
{down = device_commands.Button_3, up = device_commands.Button_3, cockpit_device_id  = devices.TAIL_WARNING_RADAR, value_down = 1.0, value_up = 0.0, name = _('Rear warning radar Test'), category = _('Rear Warning Radar')},
{combos = {{key = 'R', reformers = {'LCtrl'}}},				pressed = device_commands.Button_5, cockpit_device_id  = devices.TAIL_WARNING_RADAR, value_pressed = -1.0, name = _('Rear warning radar signal light Decrease'), category = _('Rear Warning Radar')},
{combos = {{key = 'R', reformers = {'LAlt'}}},				pressed = device_commands.Button_5, cockpit_device_id  = devices.TAIL_WARNING_RADAR, value_pressed = 1.0, name = _('Rear warning radar signal light Increase'), category = _('Rear Warning Radar')},

-- Starboard Wall - Detrola Receiver ------------------------------------------------------
{                                                           pressed = device_commands.Button_5, cockpit_device_id = devices.DETROLA, value_pressed = -0.5, name = _('Detrola Frequency Selector Decrease'), category = _('Detrola Receiver')},
{                                                           pressed = device_commands.Button_5, cockpit_device_id = devices.DETROLA, value_pressed = 0.5,  name = _('Detrola Frequency Selector Increase'), category = _('Detrola Receiver')},
{                                                           pressed = device_commands.Button_2, cockpit_device_id = devices.DETROLA, value_pressed = -0.5, name = _('Detrola Volume Decrease'),             category = _('Detrola Receiver')},
{                                                           pressed = device_commands.Button_2, cockpit_device_id = devices.DETROLA, value_pressed = 0.5,  name = _('Detrola Volume Increase'),             category = _('Detrola Receiver')},
-- ----------------------------------------------------------------------------------------

--Homing Adapter
{down = device_commands.Button_3, cockpit_device_id  = devices.HOMING_ADAPTER, value_down = 0.0, name = _('Homing Adapter TRANS'), category = _('Homing Adapter')},
{down = device_commands.Button_3, cockpit_device_id  = devices.HOMING_ADAPTER, value_down = 0.1, name = _('Homing Adapter COMM'), category = _('Homing Adapter')},
{down = device_commands.Button_3, cockpit_device_id  = devices.HOMING_ADAPTER, value_down = 0.2, name = _('Homing Adapter HOMING'), category = _('Homing Adapter')},
{down = device_commands.Button_2, cockpit_device_id  = devices.HOMING_ADAPTER, value_down = 1.0, name = _('Homing Adapter Next Mode'), category = _('Homing Adapter')},
{down = device_commands.Button_2, cockpit_device_id  = devices.HOMING_ADAPTER, value_down = -1.0, name = _('Homing Adapter Prev. Mode'), category = _('Homing Adapter')},
{down = device_commands.Button_4, cockpit_device_id  = devices.HOMING_ADAPTER, value_down = 0.0, name = _('Homing Adapter MCW'), category = _('Homing Adapter')},
{down = device_commands.Button_4, cockpit_device_id  = devices.HOMING_ADAPTER, value_down = 1.0, name = _('Homing Adapter CW'), category = _('Homing Adapter')},
{down = device_commands.Button_5, cockpit_device_id  = devices.HOMING_ADAPTER, value_down = 1.0, name = _('Homing Adapter CW/MCW'), category = _('Homing Adapter')},
--{down = device_commands.Button_3, up = device_commands.Button_3, cockpit_device_id  = devices.HOMING_ADAPTER, value_down = 1.0, value_up = 0.0, name = _('Homing Adapter Circuit Breaker'), category = _('Homing Adapter')},

--Iff radio set
{down = device_commands.Button_9, cockpit_device_id  = devices.IFF, value_down = 1.0, name = _('IFF Power On/Off'), category = _('IFF')},
{down = device_commands.Button_12, cockpit_device_id  = devices.IFF, value_down = -1, name = _('IFF Code Decrease'), category = _('IFF')},
{down = device_commands.Button_12, cockpit_device_id  = devices.IFF, value_down = 1, name = _('IFF Code Increase'), category = _('IFF')},
{down = device_commands.Button_18, cockpit_device_id  = devices.IFF, value_down = 1, name = _('IFF Code'), category = _('IFF')},
{down = device_commands.Button_3, cockpit_device_id  = devices.IFF, value_down = -1, name = _('IFF TIME'), category = _('IFF')},
{down = device_commands.Button_3, cockpit_device_id  = devices.IFF, value_down = 0, name = _('IFF OFF'), category = _('IFF')},
{down = device_commands.Button_3, cockpit_device_id  = devices.IFF, value_down = 1, name = _('IFF ON'), category = _('IFF')},
{down = device_commands.Button_19, cockpit_device_id  = devices.IFF, value_down = 1, name = _('IFF Mode'), category = _('IFF')},
{down = device_commands.Button_13, cockpit_device_id  = devices.IFF, value_down = 1.0, name = _('IFF Detonator Circuit On/Off'), category = _('IFF')},
{down = device_commands.Button_10, cockpit_device_id  = devices.IFF, value_down = 1, name = _('IFF Distress Signal'), category = _('IFF')},
{down = device_commands.Button_7, up = device_commands.Button_7, cockpit_device_id  = devices.IFF, value_down = 1.0, value_up = 0.0, name = _('IFF Detonator Left'), category = _('IFF')},
{down = device_commands.Button_8, up = device_commands.Button_8, cockpit_device_id  = devices.IFF, value_down = 1.0, value_up = 0.0, name = _('IFF Detonator Right'), category = _('IFF')},


--Environment
{pressed = device_commands.Button_4, cockpit_device_id  = devices.ENVIRONMENT_SYSTEM, value_pressed = -1.0, name = _('Defroster Decrease'), category = _('Environment System')},
{pressed = device_commands.Button_4, cockpit_device_id  = devices.ENVIRONMENT_SYSTEM, value_pressed = 1.0, name = _('Defroster Increase'), category = _('Environment System')},

{pressed = device_commands.Button_5, cockpit_device_id  = devices.ENVIRONMENT_SYSTEM, value_pressed = -1.0, name = _('Air Cold Decrease'), category = _('Environment System')},
{pressed = device_commands.Button_5, cockpit_device_id  = devices.ENVIRONMENT_SYSTEM, value_pressed = 1.0, name = _('Air Cold Increase'), category = _('Environment System')},

{pressed = device_commands.Button_6, cockpit_device_id  = devices.ENVIRONMENT_SYSTEM, value_pressed = -1.0, name = _('Air Hot Decrease'), category = _('Environment System')},
{pressed = device_commands.Button_6, cockpit_device_id  = devices.ENVIRONMENT_SYSTEM, value_pressed = 1.0, name = _('Air Hot Increase'), category = _('Environment System')},

{combos = {{key = 'N', reformers = {'LCtrl'}}}, 			pressed = device_commands.Button_5, cockpit_device_id  = devices.LIGHT_SYSTEM, value_pressed = -1.0, name = _('Cockpit Fluorescent Light Left Decrease'), category = _('Environment System')},
{combos = {{key = 'N', reformers = {'LShift'}}}, 			pressed = device_commands.Button_5, cockpit_device_id  = devices.LIGHT_SYSTEM, value_pressed = 1.0, name = _('Cockpit Fluorescent Light Left Increase'), category = _('Environment System')},
{combos = {{key = 'N', reformers = {'RCtrl'}}}, 			pressed = device_commands.Button_10, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_pressed = -1.0, name = _('Cockpit Fluorescent Light Right Decrease'), category = _('Environment System')},
{combos = {{key = 'N', reformers = {'RShift'}}}, 			pressed = device_commands.Button_10, cockpit_device_id  = devices.RIGHT_SWITCH_PANEL, value_pressed = 1.0, name = _('Cockpit Fluorescent Light Right Increase'), category = _('Environment System')},
{combos = {{key = 'L'}}, 									down = device_commands.Button_4, cockpit_device_id  = devices.LIGHT_SYSTEM, value_down = 1.0, name = _('Landing Light'), category = _('Environment System')},

----------------------------------------------------
--Radiator Air Controls
{combos = {{key = 'A', reformers = {'LCtrl'}}}, 			down = device_commands.Button_1, up = device_commands.Button_1, cockpit_device_id  = devices.ENGINE_SYSTEM, value_down = 0.1, value_up = 0.0, name = _('Radiator coolant Close'), category = _('Radiator Air Controls')},
{combos = {{key = 'A'}},						 			down = device_commands.Button_9, cockpit_device_id  = devices.ENGINE_SYSTEM, value_down = 0.2, name = _('Radiator coolant Auto'), category = _('Radiator Air Controls')},
{combos = {{key = 'A', reformers = {'LAlt'}}},	 			down = device_commands.Button_1, up = device_commands.Button_1, cockpit_device_id  = devices.ENGINE_SYSTEM, value_down = 0.3, value_up = 0.0, name = _('Radiator coolant Open'), category = _('Radiator Air Controls')},
{combos = {{key = 'A', reformers = {'LShift', 'LCtrl'}}},	down = device_commands.Button_5, cockpit_device_id  = devices.ENGINE_SYSTEM, value_down = 1.0, name = _('Radiator coolant Cover'), category = _('Radiator Air Controls')},

{combos = {{key = 'S', reformers = {'LCtrl'}}}, 			down = device_commands.Button_2, up = device_commands.Button_2, cockpit_device_id  = devices.ENGINE_SYSTEM, value_down = 0.1, value_up = 0.0, name = _('Radiator oil Close'), category = _('Radiator Air Controls')},
{combos = {{key = 'S'}}, 									down = device_commands.Button_10, cockpit_device_id  = devices.ENGINE_SYSTEM, value_down = 0.2, name = _('Radiator oil Auto'), category = _('Radiator Air Controls')},
{combos = {{key = 'S', reformers = {'LAlt'}}}, 				down = device_commands.Button_2, up = device_commands.Button_2, cockpit_device_id  = devices.ENGINE_SYSTEM, value_down = 0.3, value_up = 0.0, name = _('Radiator oil Open'), category = _('Radiator Air Controls')},
{combos = {{key = 'S', reformers = {'LShift', 'LCtrl'}}}, 	down = device_commands.Button_6, cockpit_device_id  = devices.ENGINE_SYSTEM, value_down = 1.0, name = _('Radiator oil Cover'), category = _('Radiator Air Controls')},

--Carburetor air control
{combos = {{key = 'H', reformers = {'LShift', 'LCtrl'}}}, 	pressed = device_commands.Button_8, cockpit_device_id  = devices.ENGINE_SYSTEM, value_pressed = -1.0, name = _('Cold Air Control to UNRAMMED FILTERED'), category = _('Carburetor Air Controls')},
{combos = {{key = 'H', reformers = {'LShift'}}}, 			pressed = device_commands.Button_8, cockpit_device_id  = devices.ENGINE_SYSTEM, value_pressed = 1.0, name = _('Cold Air Control to RAM'), category = _('Carburetor Air Controls')},
{combos = {{key = 'H', reformers = {'LCtrl'}}}, 			pressed = device_commands.Button_28, cockpit_device_id  = devices.ENGINE_SYSTEM, value_pressed = -1.0, name = _('Warm Air Control to HOT'), category = _('Carburetor Air Controls')},
{combos = {{key = 'H', reformers = {'LAlt'}}}, 				pressed = device_commands.Button_28, cockpit_device_id  = devices.ENGINE_SYSTEM, value_pressed = 1.0, name = _('Warm Air Control to NORMAL'), category = _('Carburetor Air Controls')},

--- Kneeboard
{combos = {{key = ']'}}						   , 			down = device_commands.Button_1, cockpit_device_id  = devices.KNEEBOARD, value_down = 1.0, name = _('Kneeboard Next Page')  , category = _('Kneeboard')},
{combos = {{key = '['}}						   , 			down = device_commands.Button_2, cockpit_device_id  = devices.KNEEBOARD, value_down = 1.0, name = _('Kneeboard Previous Page'), category = _('Kneeboard')},
{combos = {{key = 'K', reformers = {'RShift'}}}, 			down = iCommandPlaneShowKneeboard,	name = _('Kneeboard ON/OFF'), category = _('Kneeboard')},
{combos = {{key = 'K'}}						   , 			down = iCommandPlaneShowKneeboard, up = iCommandPlaneShowKneeboard ,value_down = 1.0,value_up = -1.0, name = _('Kneeboard glance view')  , category = _('Kneeboard')},
{combos = {{key = 'K', reformers = {'RCtrl'}}} , 			down = device_commands.Button_3	, cockpit_device_id  = devices.KNEEBOARD,value_down = 1.0, name = _('Kneeboard current position mark point')  , category = _('Kneeboard')},

--Night Vision Goggles
{combos = {{key = 'H', reformers = {'RShift'}}}		   , 	down    = iCommandViewNightVisionGogglesOn   , name = _('Night Vision Goggles')   , category = _('Sensors')},
{combos = {{key = 'H', reformers = {'RShift','RCtrl'}}}, 	pressed = iCommandPlane_Helmet_Brightess_Up  , name = _('Night Vision Goggles Gain Up')  , category = _('Sensors')},
{combos = {{key = 'H', reformers = {'RShift','RAlt'}}} , 	pressed = iCommandPlane_Helmet_Brightess_Down, name = _('Night Vision Goggles Gain Down'), category = _('Sensors')},

--FAC
--{combos = {{key = 'B', reformers = {'LWin'}}}, down = iCommandViewBinocular , name = _('Binocular view toggle'), category = _('FAC')},
--{combos = {{key = 'L', reformers = {'LAlt'}}}, down = iCommandViewLaserOnOff, name = _('Binocular laser illumination toggle'), category = _('FAC')},
--{combos = {{key = 'Z', reformers = {'LWin'}}}, down = iCommandViewIR		, name = _('Binocular view IR mode'), category = _('FAC')},


},
}
