return {

forceFeedback = {
trimmer = 1.0,
shake = 0.5,
swapAxes = false,
invertX = false,
invertY = false,
},

keyCommands = {
{down = iCommandScoresWindowToggle, name = _('Score window'), category = _('General')},
{down = iCommandInfoOnOff, name = _('Info bar view toggle'), category = _('General')},
{down = iCommandRecoverHuman, name = _('Get new plane - respawn'), category = _('General')},
{down = iCommandViewCoordinatesInLinearUnits, name = _('Coordinates units change'), category = _('General')},
{down = iCommandViewBriefing, name = _('Briefing window'), category = _('General')},
{down = iCommandPlaneJump, name = _('Jump into other aircraft'), category = _('General')},
{down = iCommandMissionResourcesManagement, name = _('Show Mission Resources Management window'), category = _('General')},
{down = iCommandDebriefing, name = _('Show debriefing window'), category = _('General')},


{down = iCommandToggleCommandMenu, name = _('Communication menu'), category = _('Communications')},
{down = ICommandSwitchDialog, name = _('Switch dialog'), category = _('Communications')},
{down = ICommandSwitchToCommonDialog, name = _('Switch to main menu'), category = _('Communications')},
{down = iCommandSoundOnOff,				name = _('Sound On/Off'),				category = _('General')},

-- View                                                    
{combos = {{key = 'JOY_BTN_POV1_L'}}, pressed = iCommandViewLeftSlow, up = iCommandViewStopSlow, name = _('View Left slow'), category = _('View')},
{combos = {{key = 'JOY_BTN_POV1_R'}}, pressed = iCommandViewRightSlow, up = iCommandViewStopSlow, name = _('View Right slow'), category = _('View')},
{combos = {{key = 'JOY_BTN_POV1_U'}}, pressed = iCommandViewUpSlow, up = iCommandViewStopSlow, name = _('View Up slow'), category = _('View')},
{combos = {{key = 'JOY_BTN_POV1_D'}}, pressed = iCommandViewDownSlow, up = iCommandViewStopSlow, name = _('View Down slow'), category = _('View')},
{combos = {{key = 'JOY_BTN_POV1_UR'}}, pressed = iCommandViewUpRightSlow, up = iCommandViewStopSlow, name = _('View Up Right slow'), category = _('View')},
{combos = {{key = 'JOY_BTN_POV1_DR'}}, pressed = iCommandViewDownRightSlow, up = iCommandViewStopSlow, name = _('View Down Right slow'), category = _('View')},
{combos = {{key = 'JOY_BTN_POV1_DL'}}, pressed = iCommandViewDownLeftSlow, up = iCommandViewStopSlow, name = _('View Down Left slow'), category = _('View')},
{combos = {{key = 'JOY_BTN_POV1_UL'}}, pressed = iCommandViewUpLeftSlow, up = iCommandViewStopSlow, name = _('View Up Left slow'), category = _('View')},
{combos = {{key = 'JOY_BTN5'}}, pressed = iCommandViewCenter, name = _('View Center'), category = _('View')},

{pressed = iCommandViewUp, up = iCommandViewStop, name = _('View up'), category = _('View')},
{pressed = iCommandViewDown, up = iCommandViewStop, name = _('View down'), category = _('View')},
{pressed = iCommandViewLeft, up = iCommandViewStop, name = _('View left'), category = _('View')},
{pressed = iCommandViewRight, up = iCommandViewStop, name = _('View right'), category = _('View')},
{pressed = iCommandViewUpRight, up = iCommandViewStop, name = _('View up right'), category = _('View')},
{pressed = iCommandViewDownRight, up = iCommandViewStop, name = _('View down right'), category = _('View')},
{pressed = iCommandViewDownLeft, up = iCommandViewStop, name = _('View down left'), category = _('View')},
{pressed = iCommandViewUpLeft, up = iCommandViewStop, name = _('View up left'), category = _('View')},
{pressed = iCommandViewForwardSlow, up = iCommandViewForwardSlowStop, name = _('Zoom in slow'), category = _('View')},
{pressed = iCommandViewBackSlow, up = iCommandViewBackSlowStop, name = _('Zoom out slow'), category = _('View')},
{pressed = iCommandViewForward, up = iCommandViewForwardStop, name = _('Zoom in'), category = _('View Cockpit')},
{pressed = iCommandViewBack, up = iCommandViewBackStop, name = _('Zoom out'), category = _('View Cockpit')},

{down = iCommandViewAngleDefault, name = _('Zoom normal'), category = _('View')},
{pressed = iCommandViewExternalZoomIn, up = iCommandViewExternalZoomInStop, name = _('Zoom external in'), category = _('View')},
{pressed = iCommandViewExternalZoomOut, up = iCommandViewExternalZoomOutStop, name = _('Zoom external out'), category = _('View')},
{down = iCommandViewExternalZoomDefault, name = _('Zoom external normal'), category = _('View')},
{down = iCommandViewSpeedUp, name = _('F11 camera moving forward'), category = _('View')},
{down = iCommandViewSlowDown, name = _('F11 camera moving backward'), category = _('View')},

{down = iCommandViewCockpit, name = _('F1 Cockpit view'), category = _('View')},
{down = iCommandNaturalViewCockpitIn, name = _('F1 Natural head movement view'), category = _('View')},
{down = iCommandViewHUDOnlyOnOff, name = _('F1 HUD only view switch'), category = _('View')},
{down = iCommandViewAir, name = _('F2 Aircraft view'), category = _('View')},
{down = iCommandViewMe, name = _('F2 View own aircraft'), category = _('View')},
{down = iCommandViewFromTo, name = _('F2 Toggle camera position'), category = _('View')},
{down = iCommandViewLocal, name = _('F2 Toggle local camera control'), category = _('View')},
{down = iCommandViewTower, name = _('F3 Fly-By view'), category = _('View')},
{down = iCommandViewTowerJump, name = _('F3 Fly-By jump view'), category = _('View')},
{down = iCommandViewRear, name = _('F4 Camera mounted on airframe'), category = _('View')},
{down = iCommandViewChase, name = _('F4 Chase view'), category = _('View')},
{down = iCommandViewChaseArcade, name = _('F4 Arcade Chase view'), category = _('View')},
{down = iCommandViewFight, name = _('F5 nearest AC view'), category = _('View')},
{down = iCommandViewFightGround, name = _('F5 Ground hostile view'), category = _('View')},
{down = iCommandViewWeapons, name = _('F6 Released weapon view'), category = _('View')},
{down = iCommandViewWeaponAndTarget, name = _('F6 Weapon to target view'), category = _('View')},
{down = iCommandViewGround, name = _('F7 Ground unit view'), category = _('View')},
{down = iCommandViewJFO, name = _('F7 Ground JFO/JTAC view'), category = _('View')},
{down = iCommandViewBinocular, name = _('F7 Ground JFO/JTAC Binocular view'), category = _('View')},
{down = iCommandViewNavy, name = _('F9 Ship view'), category = _('View')},
{down = iCommandViewLndgOfficer, name = _('F9 Landing signal officer view'), category = _('View')},
{down = iCommandViewAWACS, name = _('F10 Theater map view'), category = _('View')},
{down = iCommandViewAWACSJump, name = _('F10 Jump to theater map view over current point'), category = _('View')},
{down = iCommandViewFree, name = _('F11 Airport free camera'), category = _('View')},
{down = iCommandViewFreeJump, name = _('F11 Jump to free camera'), category = _('View')},
{down = iCommandViewStatic, name = _('F12 Static object view'), category = _('View')},
{down = iCommandViewMirage, name = _('F12 Civil traffic view'), category = _('View')},
{down = iCommandViewLocomotivesToggle, name = _('F12 Trains/cars toggle'), category = _('View')},
{down = iCommandViewPitHeadOnOff, name = _('F1 Head shift movement on / off'), category = _('View')},

{down = iCommandViewFastKeyboard, name = _('Fast keyboard turn speed'), category = _('View')},
{down = iCommandViewSlowKeyboard, name = _('Slow keyboard turn speed'), category = _('View')},
{down = iCommandViewNormalKeyboard, name = _('Normal keyboard turn speed'), category = _('View')},
{down =  iCommandViewFastMouse, name = _('Fast mouse turn speed'), category = _('View')},
{down = iCommandViewSlowMouse, name = _('Slow mouse turn speed'), category = _('View')},
{down = iCommandViewNormalMouse, name = _('Normal mouse turn speed'), category = _('View')},

-- Extended view
{down = iCommandViewCameraJiggle, name = _('Camera jiggle toggle'), category = _('View Extended')},
{down = iCommandViewKeepTerrain, name = _('Keep terrain camera altitude'), category = _('View Extended')},
{down = iCommandViewFriends, name = _('View friends mode'), category = _('View Extended')},
{down = iCommandViewEnemies, name = _('View enemies mode'), category = _('View Extended')},
{down = iCommandViewAll, name = _('View all mode'), category = _('View Extended')},
{down = iCommandViewPlus, name = _('Toggle tracking launched weapon'), category = _('View Extended')},
{down = iCommandViewSwitchForward, name = _('Objects switching direction forward '), category = _('View Extended')},
{down = iCommandViewSwitchReverse, name = _('Objects switching direction reverse '), category = _('View Extended')},
{down = iCommandViewObjectIgnore, name = _('Object exclude '), category = _('View Extended')},
{down = iCommandViewObjectsAll, name = _('Objects all excluded - include'), category = _('View Extended')},

{down = iCommandCockpitClickModeOnOff, 	name = _('Force cursor to show on/off'),	category = _('General')},

-- Padlock
{down = iCommandViewLock, name = _('Lock view (cycle padlock)'), category = _('View Padlock')},
{down = iCommandViewUnlock, name = _('Unlock view (stop padlock)'), category = _('View Padlock')},
--{down = iCommandAllMissilePadlock, name = _('All missiles padlock'), category = _('View Padlock')},
--{down = iCommandThreatMissilePadlock, name = _('Threat missile padlock'), category = _('View Padlock')},
{down = iCommandViewTerrainLock, name = _('Lock terrain view'), category = _('View Padlock')},

-- Labels
{down = iCommandMarkerState, name = _('All Labels'), category = _('Labels')},
{down = iCommandMarkerStatePlane, name = _('Aircraft Labels'), category = _('Labels')},
{down = iCommandMarkerStateRocket, name = _('Missile Labels'), category = _('Labels')},
{down = iCommandMarkerStateShip, name = _('Vehicle & Ship Labels'), category = _('Labels')},
},

axisCommands = {

-- joystick axes 
{combos = defaultDeviceAssignmentFor("roll")	, action = iCommandPlaneRoll, name = _('Roll')},
{combos = defaultDeviceAssignmentFor("pitch")	, action = iCommandPlanePitch, name = _('Pitch')},
{combos = defaultDeviceAssignmentFor("rudder")	, action = iCommandPlaneRudder, name = _('Rudder')},
{combos = defaultDeviceAssignmentFor("thrust")	, action = iCommandPlaneThrustCommon, name = _('Thrust')},
-- TrackIR axes
{action = iCommandViewVerticalAbs, name = _('Horizontal View')},
{action = iCommandViewHorizontalAbs, name = _('Vertical View')},

-- for test purposes only , do not merge this to public
{action = iHeadTrackerPitchNormed	, name = _('Head Tracker : Pitch')},
{action = iHeadTrackerYawNormed		, name = _('Head Tracker : Yaw')},
{action = iHeadTrackerRollNormed		, name = _('Head Tracker : Roll')},

{action = iHeadTrackerPosZNormed		, name = _('Head Tracker : Right/Left')},
{action = iHeadTrackerPosYNormed		, name = _('Head Tracker : Up/Down')},
{action = iHeadTrackerPosXNormed		, name = _('Head Tracker : Forward/Backward')},

},

}
