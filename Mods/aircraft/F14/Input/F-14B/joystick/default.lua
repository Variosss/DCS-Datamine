local cockpit = folder.."../../../Cockpit/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")



return {

forceFeedback={
	trimmer=1.0,
	shake=0.5,
	swapAxes=false,
	invertX=false,
	invertY=false,
},

keyCommands={


--************************** General *******************************************************************************

{combos={{key='E',reformers={'LCtrl'}}},down=iCommandPlaneEject,name=_('Eject (3 times)'),category=_('General')},

-- Gameplay
{combos={{key='Esc'}},down=iCommandQuit,name=_('End mission'),category=_('General')},
{combos={{key='Pause'}},down=iCommandBrakeGo,name=_('Pause'),category=_('General')},
{combos={{key='Z',reformers={'LCtrl'}}},down=iCommandAccelerate,name=_('Time accelerate'),category=_('General')},
{combos={{key='Z',reformers={'LWin','LCtrl'}}},down=iCommandDecelerate,name=_('Time decelerate'),category=_('General')},
{combos={{key='Z',reformers={'LShift'}}},down=iCommandNoAcceleration,name=_('Time normal'),category=_('General')},
{combos={{key='\''}},down=iCommandScoresWindowToggle,name=_('Score window'),category=_('General')},
--{combos={{key=','}},down=iCommandDebriefing,name=_('Show debriefing window'),category=_('General')},
--{combos={{key='.'}},down=iCommandMissionResourcesManagement,name=_('Rearming and Refueling Window'),category=_('General')},
{combos={{key='Tab'}},down=iCommandChat,name=_('Multiplayer chat - mode All'),category=_('General')},
{combos={{key='Tab',reformers={'LCtrl'}}},down=iCommandFriendlyChat,name=_('Multiplayer chat - mode Allies'),category=_('General')},
{combos={{key='Y',reformers={'LCtrl'}}},down=iCommandInfoOnOff,name=_('Info bar view toggle'),category=_('General')},
{combos={{key='Tab',reformers={'RCtrl','RShift'}}},down=iCommandRecoverHuman,name=_('Get new plane - respawn'),category=_('General')},
{combos={{key='J',reformers={'RAlt'}}},down=iCommandPlaneJump,name=_('Jump into other aircraft'),category=_('General')},
{combos={{key='SysRQ'}},down=iCommandScreenShot,name=_('Screenshot'),category=_('General')},
{combos={{key='Y',reformers={'LAlt'}}},down=iCommandViewCoordinatesInLinearUnits,name=_('Info bar coordinate units toogle'),category=_('General')},
{combos={{key='C',reformers={'LAlt','LShift'}}},down=iCommandCockpitClickModeOnOff,name=_('Mouse cursor cockpit mode'),category=_('General')},
{combos={{key='S',reformers={'LWin','LAlt'}}},down=iCommandSoundOnOff,name=_('Sound On/Off'),category=_('General')},
{combos={{key='Scroll',reformers={'RShift','RCtrl'}}},down=iCommandRecordCursorOnOff,name=_('Record of mouse cursor in track On/Off'),category=_('General')},
{combos={{key='Scroll',reformers={'RShift'}}},down=iCommandRecordSubtitleOn,name=_('Subtitle recording begin'),category=_('General')},
{combos={{key='Scroll',reformers={'RCtrl'}}},down=iCommandRecordSubtitleOff,name=_('Subtitle recording end'),category=_('General')},
{combos={{key='Pause',reformers={'LShift','LWin'}}},down=iCommandActivePauseOnOff,name=_('Active Pause'),category=_('General')},
--{combos={{key='Pause',reformers={'RShift','RCtrl'}}},down=iCommandActivePauseOnOff,name=_('Active Pause'),category=_('General')},
--{down = iCommandActivePauseOnOff, name = 'Active Pause', category = 'General')},

-- Labels
{combos={{key='F10',reformers={'LShift'}}},down=iCommandMarkerState,name=_('All Labels'),category=_('General')},
{combos={{key='F2',reformers={'LShift'}}},down=iCommandMarkerStatePlane,name=_('Aircraft Labels'),category=_('General')},
{combos={{key='F6',reformers={'LShift'}}},down=iCommandMarkerStateRocket,name=_('Missile Labels'),category=_('General')},
{combos={{key='F9',reformers={'LShift'}}},down=iCommandMarkerStateShip,name=_('Vehicle & Ship Labels'),category=_('General')},



--******************************* Views *************************************************************************
--Defaults

{combos={{key=']',reformers={'LShift'}}},down=iCommandViewFastKeyboard,name=_('Keyboard Rate Fast'),category=_('Views')},
{combos={{key=']',reformers={'LCtrl'}}},down=iCommandViewSlowKeyboard,name=_('Keyboard Rate Slow'),category=_('Views')},
{combos={{key=']',reformers={'LAlt'}}},down=iCommandViewNormalKeyboard,name=_('Keyboard Rate Normal'),category=_('Views')},
{combos={{key='[',reformers={'LShift'}}},down=iCommandViewFastMouse,name=_('Mouse Rate Fast'),category=_('Views')},
{combos={{key='[',reformers={'LCtrl'}}},down=iCommandViewSlowMouse,name=_('Mouse Rate Slow'),category=_('Views')},
{combos={{key='[',reformers={'LAlt'}}},down=iCommandViewNormalMouse,name=_('Mouse Rate Normal'),category=_('Views')},

-- Save current cockpit camera angles for fast numpad jumps 
{combos={{key='Num0',reformers={'RAlt'}}},down=iCommandViewSaveAngles,name=_('Save Cockpit Angles'),category=_('Views')},
{combos={{key='Num8',reformers={'RShift'}}},pressed=iCommandViewUp,up=iCommandViewStop,name=_('View up'),category=_('Views')},
{combos={{key='Num2',reformers={'RShift'}}},pressed=iCommandViewDown,up=iCommandViewStop,name=_('View down'),category=_('Views')},
{combos={{key='Num4',reformers={'RShift'}}},pressed=iCommandViewLeft,up=iCommandViewStop,name=_('View left'),category=_('Views')},
{combos={{key='Num6',reformers={'RShift'}}},pressed=iCommandViewRight,up=iCommandViewStop,name=_('View right'),category=_('Views')},
{combos={{key='Num9',reformers={'RShift'}}},pressed=iCommandViewUpRight,up=iCommandViewStop,name=_('View up right'),category=_('Views')},
{combos={{key='Num3',reformers={'RShift'}}},pressed=iCommandViewDownRight,up=iCommandViewStop,name=_('View down right'),category=_('Views')},
{combos={{key='Num1',reformers={'RShift'}}},pressed=iCommandViewDownLeft,up=iCommandViewStop,name=_('View down left'),category=_('Views')},
{combos={{key='Num7',reformers={'RShift'}}},pressed=iCommandViewUpLeft,up=iCommandViewStop,name=_('View up left'),category=_('Views')},

-- View 
--{ pressed = iCommandViewLeftSlow, up = iCommandViewStopSlow, name = _('View Left slow'), category = _('Views')},
--{ pressed = iCommandViewRightSlow, up = iCommandViewStopSlow, name = _('View Right slow'), category = _('Views')},
--{ pressed = iCommandViewUpSlow, up = iCommandViewStopSlow, name = _('View Up slow'), category = _('Views')},
--{ pressed = iCommandViewDownSlow, up = iCommandViewStopSlow, name = _('View Down slow'), category = _('Views')},
--{ pressed = iCommandViewUpRightSlow, up = iCommandViewStopSlow, name = _('View Up Right slow'), category = _('Views')},
--{ pressed = iCommandViewDownRightSlow, up = iCommandViewStopSlow, name = _('View Down Right slow'), category = _('Views')},
--{ pressed = iCommandViewDownLeftSlow, up = iCommandViewStopSlow, name = _('View Down Left slow'), category = _('Views')},
--{ pressed = iCommandViewUpLeftSlow, up = iCommandViewStopSlow, name = _('View Up Left slow'), category = _('Views')},
--{combos = {}, pressed = iCommandViewCenter, name = _('View Center'), category = _('Views')},

-- F views
{combos={{key='F1'}},down=iCommandViewCockpit,name=_('F1 Cockpit view'),category=_('Views')},
{combos={{key='F1',reformers={'LCtrl'}}},down=iCommandNaturalViewCockpitIn,name=_('F1 Natural head movement view'),category=_('Views')},
{combos={{key='F1',reformers={'LAlt'}}},down=iCommandViewHUDOnlyOnOff,name=_('F1 HUD only view switch'),category=_('Views')},
{combos={{key='F2'}},down=iCommandViewAir,name=_('F2 Aircraft view'),category=_('Views')},
{combos={{key='F2',reformers={'LCtrl'}}},down=iCommandViewMe,name=_('F2 View own aircraft'),category=_('Views')},
{combos={{key='F2',reformers={'RAlt'}}},down=iCommandViewFromTo,name=_('F2 Toggle camera position'),category=_('Views')},
{combos={{key='F2',reformers={'LAlt'}}},down=iCommandViewLocal,name=_('F2 Toggle local camera control'),category=_('Views')},
{combos={{key='F3'}},down=iCommandViewTower,name=_('F3 Fly-By view'),category=_('Views')},
{combos={{key='F3',reformers={'LCtrl'}}},down=iCommandViewTowerJump,name=_('F3 Fly-By jump view'),category=_('Views')},
{combos={{key='F4'}},down=iCommandViewRear,name=_('F4 Look back view'),category=_('Views')},
{combos={{key='F4',reformers={'LCtrl'}}},down=iCommandViewChase,name=_('F4 Chase view'),category=_('Views')},
{combos={{key='F5'}},down=iCommandViewFight,name=_('F5 nearest AC view'),category=_('Views')},
{combos={{key='F5',reformers={'LCtrl'}}},down=iCommandViewFightGround,name=_('F5 Ground hostile view'),category=_('Views')},
{combos={{key='F6'}},down=iCommandViewWeapons,name=_('F6 Released weapon view'),category=_('Views')},
{combos={{key='F6',reformers={'LCtrl'}}},down=iCommandViewWeaponAndTarget,name=_('F6 Weapon to target view'),category=_('Views')},
{combos={{key='F7'}},down=iCommandViewGround,name=_('F7 Ground unit view'),category=_('Views')},
{combos={{key='F8'}},down=iCommandViewTargets,name=_('F8 Target view'),category=_('Views')},
{combos={{key='F8',reformers={'RCtrl'}}},down=iCommandViewTargetType,name=_('F8 Player targets/All targets filter'),category=_('Views')},
{combos={{key='F9'}},down=iCommandViewNavy,name=_('F9 Ship view'),category=_('Views')},
{combos={{key='F9',reformers={'LAlt'}}},down=iCommandViewLndgOfficer,name=_('F9 Landing signal officer view'),category=_('Views')},
{combos={{key='F10'}},down=iCommandViewAWACS,name=_('F10 Theater map view'),category=_('Views')},
{combos={{key='F10',reformers={'LCtrl'}}},down=iCommandViewAWACSJump,name=_('F10 Jump to theater map view over current point'),category=_('Views')},
{combos={{key='F11'}},down=iCommandViewFree,name=_('F11 Airport free camera'),category=_('Views')},
{combos={{key='F11',reformers={'LCtrl'}}},down=iCommandViewFreeJump,name=_('F11 Jump to free camera'),category=_('Views')},
{combos={{key='F12'}},down=iCommandViewStatic,name=_('F12 Static object view'),category=_('Views')},
{combos={{key='F12',reformers={'LCtrl'}}},down=iCommandViewMirage,name=_('F12 Civil traffic view'),category=_('Views')},
{combos={{key='F12',reformers={'LShift'}}},down=iCommandViewLocomotivesToggle,name=_('F12 Trains/cars toggle'),category=_('Views')},
{combos={{key='F1',reformers={'LCtrl','LShift'}}},down=iCommandViewPitHeadOnOff,name=_('F1 Head shift movement on / off'),category=_('Views')},

{combos={{key='Num*'}},pressed=iCommandViewForwardSlow,up=iCommandViewForwardSlowStop,name=_('Zoom in slow'),category=_('Views')},
{combos={{key='Num/'}},pressed=iCommandViewBackSlow,up=iCommandViewBackSlowStop,name=_('Zoom out slow'),category=_('Views')},
{down=iCommandViewAngleDefault,name=_('Zoom normal'),category=_('Views')},
{combos={{key='Num*',reformers={'RCtrl'}}},pressed=iCommandViewExternalZoomIn,up=iCommandViewExternalZoomInStop,name=_('Zoom external in'),category=_('Views')},
{combos={{key='Num/',reformers={'RCtrl'}}},pressed=iCommandViewExternalZoomOut,up=iCommandViewExternalZoomOutStop,name=_('Zoom external out'),category=_('Views')},
{combos={{key='NumEnter',reformers={'RCtrl'}}},down=iCommandViewExternalZoomDefault,name=_('Zoom external normal'),category=_('Views')},
{combos={{key='Num*',reformers={'LAlt'}}},down=iCommandViewSpeedUp,name=_('F11 Camera moving forward'),category=_('Views')},
{combos={{key='Num/',reformers={'LAlt'}}},down=iCommandViewSlowDown,name=_('F11 Camera moving backward'),category=_('Views')},

-- Cockpit view
{down=iCommandViewTempCockpitOn,up=iCommandViewTempCockpitOff,name=_('Cockpit panel view in'),category=_('Views')},
{combos={{key='Num0',reformers={'RCtrl'}}},down=iCommandViewTempCockpitToggle,name=_('Cockpit panel view toggle'),category=_('Views')},

-- Cockpit Camera Motion
{combos={{key='Num8',reformers={'RCtrl','RShift'}}},pressed=iCommandViewPitCameraMoveUp,up=iCommandViewPitCameraMoveStop,name=_('Cockpit Camera Move Up'),category=_('Views')},
{combos={{key='Num2',reformers={'RCtrl','RShift'}}},pressed=iCommandViewPitCameraMoveDown,up=iCommandViewPitCameraMoveStop,name=_('Cockpit Camera Move Down'),category=_('Views')},
{combos={{key='Num4',reformers={'RCtrl','RShift'}}},pressed=iCommandViewPitCameraMoveLeft,up=iCommandViewPitCameraMoveStop,name=_('Cockpit Camera Move Left'),category=_('Views')},
{combos={{key='Num6',reformers={'RCtrl','RShift'}}},pressed=iCommandViewPitCameraMoveRight,up=iCommandViewPitCameraMoveStop,name=_('Cockpit Camera Move Right'),category=_('Views')},
{combos={{key='Num*',reformers={'RCtrl','RShift'}}},pressed=iCommandViewPitCameraMoveForward,up=iCommandViewPitCameraMoveStop,name=_('Cockpit Camera Move Forward'),category=_('Views')},
{combos={{key='Num/',reformers={'RCtrl','RShift'}}},pressed=iCommandViewPitCameraMoveBack,up=iCommandViewPitCameraMoveStop,name=_('Cockpit Camera Move Back'),category=_('Views')},
{combos={{key='Num5',reformers={'RCtrl','RShift'}}},down=iCommandViewPitCameraMoveCenter,name=_('Cockpit Camera Move Center'),category=_('Views')},

{combos={{key='Num8',reformers={'RCtrl'}}},down=iCommandViewCameraUp,up=iCommandViewCameraCenter,name=_('Glance up'),category=_('Views')},
{combos={{key='Num2',reformers={'RCtrl'}}},down=iCommandViewCameraDown,up=iCommandViewCameraCenter,name=_('Glance down'),category=_('Views')},
{combos={{key='Num4',reformers={'RCtrl'}}},down=iCommandViewCameraLeft,up=iCommandViewCameraCenter,name=_('Glance left'),category=_('Views')},
{combos={{key='Num6',reformers={'RCtrl'}}},down=iCommandViewCameraRight,up=iCommandViewCameraCenter,name=_('Glance right'),category=_('Views')},
{combos={{key='Num7',reformers={'RCtrl'}}},down=iCommandViewCameraUpLeft,up=iCommandViewCameraCenter,name=_('Glance up-left'),category=_('Views')},
{combos={{key='Num1',reformers={'RCtrl'}}},down=iCommandViewCameraDownLeft,up=iCommandViewCameraCenter,name=_('Glance down-left'),category=_('Views')},
{combos={{key='Num9',reformers={'RCtrl'}}},down=iCommandViewCameraUpRight,up=iCommandViewCameraCenter,name=_('Glance up-right'),category=_('Views')},
{combos={{key='Num3',reformers={'RCtrl'}}},down=iCommandViewCameraDownRight,up=iCommandViewCameraCenter,name=_('Glance down-right'),category=_('Views')},
{combos={{key='Z',reformers={'LAlt','LShift'}}},down=iCommandViewPanToggle,name=_('Camera pan mode toggle'),category=_('Views')},

{combos={{key='Num8',reformers={'RAlt'}}},down=iCommandViewCameraUpSlow,name=_('Camera snap view up'),category=_('Views')},
{combos={{key='Num2',reformers={'RAlt'}}},down=iCommandViewCameraDownSlow,name=_('Camera snap view down'),category=_('Views')},
{combos={{key='Num4',reformers={'RAlt'}}},down=iCommandViewCameraLeftSlow,name=_('Camera snap view left'),category=_('Views')},
{combos={{key='Num6',reformers={'RAlt'}}},down=iCommandViewCameraRightSlow,name=_('Camera snap view right'),category=_('Views')},
{combos={{key='Num7',reformers={'RAlt'}}},down=iCommandViewCameraUpLeftSlow,name=_('Camera snap view up-left'),category=_('Views')},
{combos={{key='Num1',reformers={'RAlt'}}},down=iCommandViewCameraDownLeftSlow,name=_('Camera snap view down-left'),category=_('Views')},
{combos={{key='Num9',reformers={'RAlt'}}},down=iCommandViewCameraUpRightSlow,name=_('Camera snap view up-right'),category=_('Views')},
{combos={{key='Num3',reformers={'RAlt'}}},down=iCommandViewCameraDownRightSlow,name=_('Camera snap view down-right'),category=_('Views')},
{combos={{key='Num5',reformers={'RShift'}}},down=iCommandViewCameraCenter,name=_('Center Camera View'),category=_('Views')},
{combos={{key='Num5',reformers={'RCtrl'}}},down=iCommandViewCameraReturn,name=_('Return Camera'),category=_('Views')},
{combos={{key='Num5',reformers={'RAlt'}}},down=iCommandViewCameraBaseReturn,name=_('Return Camera Base'),category=_('Views')},

{combos={{key='Num0',reformers={'LWin'}}},down=iCommandViewSnapView0,up=iCommandViewSnapViewStop,name=_('Custom Snap View 0'),category=_('Views')},
{combos={{key='Num1',reformers={'LWin'}}},down=iCommandViewSnapView1,up=iCommandViewSnapViewStop,name=_('Custom Snap View 1'),category=_('Views')},
{combos={{key='Num2',reformers={'LWin'}}},down=iCommandViewSnapView2,up=iCommandViewSnapViewStop,name=_('Custom Snap View 2'),category=_('Views')},
{combos={{key='Num3',reformers={'LWin'}}},down=iCommandViewSnapView3,up=iCommandViewSnapViewStop,name=_('Custom Snap View 3'),category=_('Views')},
{combos={{key='Num4',reformers={'LWin'}}},down=iCommandViewSnapView4,up=iCommandViewSnapViewStop,name=_('Custom Snap View 4'),category=_('Views')},
{combos={{key='Num5',reformers={'LWin'}}},down=iCommandViewSnapView5,up=iCommandViewSnapViewStop,name=_('Custom Snap View 5'),category=_('Views')},
{combos={{key='Num6',reformers={'LWin'}}},down=iCommandViewSnapView6,up=iCommandViewSnapViewStop,name=_('Custom Snap View 6'),category=_('Views')},
{combos={{key='Num7',reformers={'LWin'}}},down=iCommandViewSnapView7,up=iCommandViewSnapViewStop,name=_('Custom Snap View 7'),category=_('Views')},
{combos={{key='Num8',reformers={'LWin'}}},down=iCommandViewSnapView8,up=iCommandViewSnapViewStop,name=_('Custom Snap View 8'),category=_('Views')},
{combos={{key='Num9',reformers={'LWin'}}},down=iCommandViewSnapView9,up=iCommandViewSnapViewStop,name=_('Custom Snap View 9'),category=_('Views')},

{combos={{key='Num8',reformers={'RWin'}}},down=iCommandViewLeftMirrorOn,up=iCommandViewLeftMirrorOff,name=_('Mirror View'),category=_('Views')},

{combos={{key='Num*',reformers={'RShift'}}},pressed=iCommandViewForward,up=iCommandViewForwardStop,name=_('Zoom in'),category=_('Views')},
{combos={{key='Num/',reformers={'RShift'}}},pressed=iCommandViewBack,up=iCommandViewBackStop,name=_('Zoom out'),category=_('Views')},


-- Extended view
{combos={{key='J',reformers={'LShift'}}},down=iCommandViewCameraJiggle,name=_('Camera jiggle toggle'),category=_('Views')},
{combos={{key='K',reformers={'LAlt'}}},down=iCommandViewKeepTerrain,name=_('Keep terrain camera altitude'),category=_('Views')},
{combos={{key='Home',reformers={'RCtrl','RShift'}}},down=iCommandViewFriends,name=_('View friends mode'),category=_('Views')},
{combos={{key='End',reformers={'RCtrl','RShift'}}},down=iCommandViewEnemies,name=_('View enemies mode'),category=_('Views')},
{combos={{key='Delete',reformers={'RCtrl'}}},down=iCommandViewAll,name=_('View all mode'),category=_('Views')},
{combos={{key='Num+',reformers={'RCtrl'}}},down=iCommandViewPlus,name=_('Toggle tracking fire weapon'),category=_('Views')},
{combos={{key='PageDown',reformers={'LCtrl'}}},down=iCommandViewSwitchForward,name=_('Objects switching direction forward'),category=_('Views')},
{combos={{key='PageUp',reformers={'LCtrl'}}},down=iCommandViewSwitchReverse,name=_('Objects switching direction reverse'),category=_('Views')},
{combos={{key='Delete',reformers={'LAlt'}}},down=iCommandViewObjectIgnore,name=_('Object exclude'),category=_('Views')},
{combos={{key='Insert',reformers={'LAlt'}}},down=iCommandViewObjectsAll,name=_('Objects all excluded - include'),category=_('Views')},

-- Padlock
{down=iCommandViewLock,name=_('Lock View (cycle padlock)'),category=_('Views')},
{combos={{key='NumLock'}},down=iCommandViewUnlock,name=_('Unlock view (stop padlock)'),category=_('Views')},
{combos={{key='Num.',reformers={'RShift'}}},down=iCommandAllMissilePadlock,name=_('All missiles padlock'),category=_('Views')},
{combos={{key='Num.',reformers={'RAlt'}}},down=iCommandThreatMissilePadlock,name=_('Threat missile padlock'),category=_('Views')},
{combos={{key='Num.',reformers={'RCtrl'}}},down=iCommandViewTerrainLock,name=_('Lock terrain view'),category=_('Views')},

--	Head Tracker View
{down = iHeadTrackerZoomToggle,			up = iHeadTrackerZoomToggle, 		 value_down = 1.0, value_up = 0.0, name = _('VR tracker Zoom'),			 category = _('Head Tracker')},
{down = iHeadTrackerSpyglassZoomToggle,	up = iHeadTrackerSpyglassZoomToggle, value_down = 1.0, value_up = 0.0, name = _('VR tracker Spyglass Zoom'), category = _('Head Tracker')},
{down = iHeadTrackerPosReset,																				   name = _('VR tracker Reset Base'),	 category = _('Head Tracker')},

},

-- joystick axes 
axisCommands={

{action=iCommandViewHorizontalAbs,name=_('Horizontal View')},
{action=iCommandViewVerticalAbs,name=_('Vertical View')},
{action=iCommandViewZoomAbs,name=_('Zoom View')},
{action=iCommandViewRollAbs,name=_('Cockpit camera roll')},
{action=iCommandViewHorTransAbs,name=_('Cockpit camera move lateral')},
{action=iCommandViewVertTransAbs,name=_('Cockpit camera move vertical')},
{action=iCommandViewLongitudeTransAbs,name=_('Cockpit camera move forward/backward')},

},

}