local cockpit = folder.."../../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

return {

forceFeedback = {
trimmer = 1.0,
shake = 0.5,
swapAxes = false,
},

keyCommands = {

-- Cheat - Temporary
{down = iCommandEnginesStart, name = _('Auto Start'), category = _('Cheat')},
{down = iCommandEnginesStop, name = _('Auto Stop') , category = _('Cheat')},

-- General
{down = iCommandScoresWindowToggle, name = _('Score window'), category = _('General')},
--{down = iCommandTrkEsc, name = _('Playback track cancel'), category = _('General')},
{down = iCommandInfoOnOff, name = _('Info bar toggle'), category = _('General')},
{down = iCommandRecoverHuman, name = _('Get New Plane - respawn'), category = _('General')},
{down = iCommandCockpitClickModeOnOff, name = _('Clickable mouse cockpit mode On/Off'), category = _('General')},
--{down = iCommandPlaneJump, name = _('Jump into other aircraft'), category = _('General')},
{down = iCommandViewCoordinatesInLinearUnits, name = _('Info bar coordinate units toggle'), category = _('General')},
{down = iCommandCockpitShowPilotOnOff, name = _('Show Pilot Body'), category = _('General')},
{down = iCommandPlane_ShowControls, name = _('Show controls indicator') , category = _('General')},
{down = iCommandDebriefing, name = _('Show debriefing window'), category = _('General')},
{down = iCommandViewBriefing, name = _('View briefing on/off'), category = _('General')},
{down = iCommandPlaneJump, name = _('Jump into selected aircraft'), category = _('General')},
{down = iCommandMissionResourcesManagement, name = _('Rearming and Refueling Window'), category = _('General')},
{down = iCommandSoundOnOff,			name = _('Sound On/Off'),	 category = _('General')},

-- View                                                    
{combos = {{key = 'JOY_BTN_POV1_L'}}, pressed = iCommandViewLeftSlow, up = iCommandViewStopSlow, name = _('View Left slow'), category = _('View')},
{combos = {{key = 'JOY_BTN_POV1_R'}}, pressed = iCommandViewRightSlow, up = iCommandViewStopSlow, name = _('View Right slow'), category = _('View')},
{combos = {{key = 'JOY_BTN_POV1_U'}}, pressed = iCommandViewUpSlow, up = iCommandViewStopSlow, name = _('View Up slow'), category = _('View')},
{combos = {{key = 'JOY_BTN_POV1_D'}}, pressed = iCommandViewDownSlow, up = iCommandViewStopSlow, name = _('View Down slow'), category = _('View')},
{combos = {{key = 'JOY_BTN_POV1_UR'}}, pressed = iCommandViewUpRightSlow, up = iCommandViewStopSlow, name = _('View Up Right slow'), category = _('View')},
{combos = {{key = 'JOY_BTN_POV1_DR'}}, pressed = iCommandViewDownRightSlow, up = iCommandViewStopSlow, name = _('View Down Right slow'), category = _('View')},
{combos = {{key = 'JOY_BTN_POV1_DL'}}, pressed = iCommandViewDownLeftSlow, up = iCommandViewStopSlow, name = _('View Down Left slow'), category = _('View')},
{combos = {{key = 'JOY_BTN_POV1_UL'}}, pressed = iCommandViewUpLeftSlow, up = iCommandViewStopSlow, name = _('View Up Left slow'), category = _('View')},
{combos = {{key = 'JOY_BTN5'}}, pressed = iCommandViewCenter, name = _('Center View'), category = _('View')},
         

{pressed = iCommandViewForwardSlow, up = iCommandViewForwardSlowStop, name = _('Zoom in slow'), category = _('View')},
{pressed = iCommandViewBackSlow, up = iCommandViewBackSlowStop, name = _('Zoom out slow'), category = _('View')},
{down = iCommandViewAngleDefault, name = _('Zoom normal'), category = _('View')},
{pressed = iCommandViewExternalZoomIn, up = iCommandViewExternalZoomInStop, name = _('Zoom external in'), category = _('View')},
{pressed = iCommandViewExternalZoomOut, up = iCommandViewExternalZoomOutStop, name = _('Zoom external out'), category = _('View')},
{down = iCommandViewExternalZoomDefault, name = _('Zoom external normal'), category = _('View')},
{down = iCommandViewSpeedUp, name = _('F11 camera moving forward'), category = _('View')},
{down = iCommandViewSlowDown, name = _('F11 camera moving backward'), category = _('View')},
{down = iCommandViewSwitchForward, name = _('Objects switching direction forward '), category = _('View')},
{down = iCommandViewSwitchReverse, name = _('Objects switching direction reverse '), category = _('View')},
{down = iCommandViewObjectIgnore, name = _('Object exclude '), category = _('View')},
{down = iCommandViewObjectsAll, name = _('Objects all excluded - include'), category = _('View')},


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
{down = iCommandViewNavy, name = _('F9 Ship view'), category = _('View')},
{down = iCommandViewLndgOfficer, name = _('F9 Landing signal officer view'), category = _('View')},
{down = iCommandViewAWACS, name = _('F10 Theater map view'), category = _('View')},
{down = iCommandViewAWACSJump, name = _('F10 Jump to theater map view over current point'), category = _('View')},
{down = iCommandViewFree, name = _('F11 Airport free camera'), category = _('View')},
{down = iCommandViewFreeJump, name = _('F11 Jump to free camera'), category = _('View')},
{down = iCommandViewStatic, name = _('F12 Static object view'), category = _('View')},
{down = iCommandViewMirage, name = _('F12 Civil traffic view'), category = _('View')},
{down = iCommandViewLocomotivesToggle, name = _('F12 Trains/cars toggle'), category = _('View')},

{down = iCommandViewFastKeyboard, name = _('Camera view keyboard rate fast'), category = _('View')},
{down = iCommandViewSlowKeyboard, name = _('Camera view keyboard rate slow'), category = _('View')},
{down = iCommandViewNormalKeyboard, name = _('Camera view keyboard rate normal'), category = _('View')},
{down = iCommandViewFastMouse, name = _('Camera view mouse rate fast'), category = _('View')},
{down = iCommandViewSlowMouse, name = _('Camera view mouse rate slow'), category = _('View')},
{down = iCommandViewNormalMouse, name = _('Camera view mouse rate normal'), category = _('View')},

-- View Cockpit
{down = iCommandViewTempCockpitOn, up = iCommandViewTempCockpitOff, name = _('Cockpit panel view in'), category = _('View Cockpit')},
{down = iCommandViewTempCockpitToggle, name = _('Cockpit panel view toggle'), category = _('View Cockpit')},
{down = iCommandViewLeftMirrorOn,	up = iCommandViewLeftMirrorOff,		name = _('Mirror Left On'),		category = _('View Cockpit') , features = {"Mirrors"}},
{down = iCommandViewRightMirrorOn,	up = iCommandViewRightMirrorOff,	name = _('Mirror Right On'),	category = _('View Cockpit') , features = {"Mirrors"}},
{down = iCommandToggleMirrors,											name = _('Toggle Mirrors'),		category = _('View Cockpit') , features = {"Mirrors"}},


--// Save current cockpit camera angles for fast numpad jumps  
{down = iCommandViewSaveAngles, name = _('Save Cockpit Angles'), category = _('View Cockpit')},
{pressed = iCommandViewUp, up = iCommandViewStop, name = _('View up'), category = _('View Cockpit')},
{pressed = iCommandViewDown, up = iCommandViewStop, name = _('View down'), category = _('View Cockpit')},
{pressed = iCommandViewLeft, up = iCommandViewStop, name = _('View left'), category = _('View Cockpit')},
{pressed = iCommandViewRight, up = iCommandViewStop, name = _('View right'), category = _('View Cockpit')},
{pressed = iCommandViewUpRight, up = iCommandViewStop, name = _('View up right'), category = _('View Cockpit')},
{pressed = iCommandViewDownRight, up = iCommandViewStop, name = _('View down right'), category = _('View Cockpit')},
{pressed = iCommandViewDownLeft, up = iCommandViewStop, name = _('View down left'), category = _('View Cockpit')},
{pressed = iCommandViewUpLeft, up = iCommandViewStop, name = _('View up left'), category = _('View Cockpit')},

{down = iCommandViewCameraUp, up = iCommandViewCameraCenter, name = _('Camera view up'), category = _('View Cockpit')},
{down = iCommandViewCameraDown, up = iCommandViewCameraCenter, name = _('Camera view down'), category = _('View Cockpit')},
{down = iCommandViewCameraLeft, up = iCommandViewCameraCenter, name = _('Camera view left'), category = _('View Cockpit')},
{down = iCommandViewCameraRight, up = iCommandViewCameraCenter, name = _('Camera view right'), category = _('View Cockpit')},
{down = iCommandViewCameraUpLeft, up = iCommandViewCameraCenter, name = _('Camera view up-left'), category = _('View Cockpit')},
{down = iCommandViewCameraDownLeft, up = iCommandViewCameraCenter, name = _('Camera view down-left'), category = _('View Cockpit')},
{down = iCommandViewCameraUpRight, up = iCommandViewCameraCenter, name = _('Camera view up-right'), category = _('View Cockpit')},
{down = iCommandViewCameraDownRight, up = iCommandViewCameraCenter, name = _('Camera view down-right'), category = _('View Cockpit')},
--{down = iCommandViewPanToggle, name = _('Camera pan mode toggle'), category = _('View Cockpit')},

{down = iCommandViewCameraUpSlow, name = _('Camera view up slow'), category = _('View Cockpit')},
{down = iCommandViewCameraDownSlow, name = _('Camera view down slow'), category = _('View Cockpit')},
{down = iCommandViewCameraLeftSlow, name = _('Camera view left slow'), category = _('View Cockpit')},
{down = iCommandViewCameraRightSlow, name = _('Camera view right slow'), category = _('View Cockpit')},
{down = iCommandViewCameraUpLeftSlow, name = _('Camera view up-left slow'), category = _('View Cockpit')},
{down = iCommandViewCameraDownLeftSlow, name = _('Camera view down-left slow'), category = _('View Cockpit')},
{down = iCommandViewCameraDownRight, name = _('Camera view down-right slow'), category = _('View Cockpit')},
{down = iCommandViewCameraUpRightSlow, name = _('Camera view up-right slow'), category = _('View Cockpit')},
{down = iCommandViewCameraCenter, name = _('Center camera view'), category = _('View Cockpit')},
{down = iCommandViewCameraReturn, name = _('Return camera'), category = _('View Cockpit')},
{down = iCommandViewCameraBaseReturn, name = _('Return camera base'), category = _('View Cockpit')},

{down = iCommandViewSnapView0, up = iCommandViewSnapViewStop, name = _('Snap View 0'), category = _('View Cockpit')},
{down = iCommandViewSnapView1, up = iCommandViewSnapViewStop, name = _('Snap View 1'), category = _('View Cockpit')},
{down = iCommandViewSnapView2, up = iCommandViewSnapViewStop, name = _('Snap View 2'), category = _('View Cockpit')},
{down = iCommandViewSnapView3, up = iCommandViewSnapViewStop, name = _('Snap View 3'), category = _('View Cockpit')},
{down = iCommandViewSnapView4, up = iCommandViewSnapViewStop, name = _('Snap View 4'), category = _('View Cockpit')},
{down = iCommandViewSnapView5, up = iCommandViewSnapViewStop, name = _('Snap View 5'), category = _('View Cockpit')},
{down = iCommandViewSnapView6, up = iCommandViewSnapViewStop, name = _('Snap View 6'), category = _('View Cockpit')},
{down = iCommandViewSnapView7, up = iCommandViewSnapViewStop, name = _('Snap View 7'), category = _('View Cockpit')},
{down = iCommandViewSnapView8, up = iCommandViewSnapViewStop, name = _('Snap View 8'), category = _('View Cockpit')},
{down = iCommandViewSnapView9, up = iCommandViewSnapViewStop, name = _('Snap View 9'), category = _('View Cockpit')},

{down = iCommandViewPitHeadOnOff, name = _('Head shift movement on / off'), category = _('View Cockpit')},

{pressed = iCommandViewForward, up = iCommandViewForwardStop, name = _('Zoom in'), category = _('View Cockpit')},
{pressed = iCommandViewBack, up = iCommandViewBackStop, name = _('Zoom out'), category = _('View Cockpit')},

{down = iCommand_ExplorationStart, name = _('Enable visual recon mode'), category = _('View Cockpit')},

-- Cockpit Camera Motion (Передвижение камеры в кабине)
{pressed = iCommandViewPitCameraMoveUp, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Up'), category = _('View Cockpit')},
{pressed = iCommandViewPitCameraMoveDown, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Down'), category = _('View Cockpit')},
{pressed = iCommandViewPitCameraMoveLeft, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Left'), category = _('View Cockpit')},
{pressed = iCommandViewPitCameraMoveRight, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Right'), category = _('View Cockpit')},
{pressed = iCommandViewPitCameraMoveForward, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Forward'), category = _('View Cockpit')},
{pressed = iCommandViewPitCameraMoveBack, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Back'), category = _('View Cockpit')},
{down = iCommandViewPitCameraMoveCenter, name = _('Cockpit Camera Move Center'), category = _('View Cockpit')},

{down = iCommandViewTransposeModeOn, up = iCommandViewTransposeModeOff, name = _('Camera transpose mode (press and hold)'), category = _('View Cockpit')},

-- View Extended

{down = iCommandViewCameraJiggle, name = _('Camera jiggle toggle'), category = _('View Extended')},
{down = iCommandViewKeepTerrain, name = _('Keep terrain camera altitude'), category = _('View Extended')},
{down = iCommandViewPlus, name = _('Toggle tracking launched weapon'), category = _('View Extended')},
{down = iCommandViewFriends, name = _('View friends mode'), category = _('View Extended')},
{down = iCommandViewEnemies, name = _('View enemies mode'), category = _('View Extended')},
{down = iCommandViewAll, name = _('View all mode'), category = _('View Extended')},

-- View Padlock
{down = iCommandViewLock, name = _('Lock view (cycle padlock)'), category = _('View Padlock')},
{down = iCommandViewUnlock, name = _('Unlock view (stop padlock)'), category = _('View Padlock')},
{down = iCommandAllMissilePadlock, name = _('All missiles padlock'), category = _('View Padlock')},
{down = iCommandThreatMissilePadlock, name = _('Threat missile padlock'), category = _('View Padlock')},
{down = iCommandViewTerrainLock, name = _('Lock terrain view'), category = _('View Padlock')},

--	Head Tracker View
{down = iHeadTrackerZoomToggle,			up = iHeadTrackerZoomToggle, 		 value_down = 1.0, value_up = 0.0, name = _('VR tracker Zoom'),			 category = _('Head Tracker')},
{down = iHeadTrackerSpyglassZoomToggle,	up = iHeadTrackerSpyglassZoomToggle, value_down = 1.0, value_up = 0.0, name = _('VR tracker Spyglass Zoom'), category = _('Head Tracker')},
{down = iHeadTrackerPosReset,																				   name = _('VR tracker Reset Base'),	 category = _('Head Tracker')},

-- Labels
{down = iCommandMarkerState, name = _('All Labels'), category = _('Labels')},
{down = iCommandMarkerStatePlane, name = _('Aircraft Labels'), category = _('Labels')},
{down = iCommandMarkerStateRocket, name = _('Missile Labels'), category = _('Labels')},
{down = iCommandMarkerStateShip, name = _('Vehicle & Ship Labels'), category = _('Labels')},

-- Ins Forward panel and gauges
{down = iCommandPlaneGear, name = _('Gear lever'), category = _('Ins Forward panel and gauges')},
{down = device_commands.Button_12, cockpit_device_id = devices.CPT_MECH, value_down = 1.0, name = _('Gear up'), category = _('Ins Forward panel and gauges')},
{down = device_commands.Button_13, cockpit_device_id = devices.CPT_MECH, value_down = 1.0, name = _('Gear down'), category = _('Ins Forward panel and gauges')},
{down = device_commands.Button_1, up = device_commands.Button_1, cockpit_device_id = devices.CPT_MECH, value_down = 1.0, value_up = 0.0, name = _('Gear Lever : DOWN<>UP'), category = {_('Special For Joystick'), _('Ins Forward panel and gauges')}},

{down = iCommandEmergencyGear, name = _('Emergency gear'), category = _('Ins Forward panel and gauges')},
{down = device_commands.Button_14, up = device_commands.Button_15, cockpit_device_id = devices.CPT_MECH, value_down = 1.0, value_up = 0.0, name = _('Emergency Gear 2-pos Switch : ON<>OFF'), category = {_('Special For Joystick'), _('Ins Forward panel and gauges')}},

{down = iCommandEmergencyGearCover, name = _('Emergency gear cover'), category = _('Ins Forward panel and gauges')},
{down = device_commands.Button_5, up = device_commands.Button_5, cockpit_device_id = devices.CPT_MECH, value_down = 1.0, value_up = 0.0, name = _('Emergency Gear 2-pos Switch Cover : OPEN<>CLOSE'), category = {_('Special For Joystick'), _('Ins Forward panel and gauges')}},

{down = iCommandBKOMode, name = _('LWS/CMD operation mode'), category = _('Ins Forward panel and gauges')},

{down = iCommandMechClock_LeftLever_Down, up = iCommandMechClock_LeftLever_Down_up, name = _('Mech clock. Left lever Down'), category = _('Ins Forward panel and gauges')},
{down = iCommandMechClock_LeftLever_Up, name = _('Mech clock. Left lever Up'), category = _('Ins Forward panel and gauges')},
{pressed = iCommandMechClock_LeftLever_TurnRight, name = _('Mech clock. Left lever turning right'), category = _('Ins Forward panel and gauges')},
{pressed = iCommandMechClock_LeftLever_TurnLeft, name = _('Mech clock. Left lever turning left'), category = _('Ins Forward panel and gauges')},
{down = iCommandMechClock_RightLever_Down, up = iCommandMechClock_RightLever_Down_up, name = _('Mech clock. Right lever Down'), category = _('Ins Forward panel and gauges')},
{down = iCommandMechClock_RightLever_Rotate_left, name = _('Mech clock. Right lever Rotate left'), category = _('Ins Forward panel and gauges')},
{down = iCommandMechClock_RightLever_Rotate_right, name = _('Mech clock. Right lever Rotate right'), category = _('Ins Forward panel and gauges')},

{down = iCommandPlaneMasterCaution, up = iCommandPlaneMasterCautionOff, name = _('Master caution push-light'), category = _('Ins Forward panel and gauges')},
{down = iCommandLampsControl, up = iCommandLampsControl_up, name = _('Lamps test'), category = _('Ins Forward panel and gauges')},
{down = iCommandRotorRPMHigh, up = iCommandRotorRPMHigh_up, name = _('Low rotor RPM caution push-light'), category = _('Ins Forward panel and gauges')},


{pressed = iCommandHSI_CourseRotaryRight, name = _('HSI Commanded course rotary right'), category = _('Ins Forward panel and gauges')},
{pressed = iCommandHSI_CourseRotaryLeft, name = _('HSI Commanded course rotary left'), category = _('Ins Forward panel and gauges')},
{pressed = iCommandHSI_HeadingRotaryRight, name = _('HSI Commanded heading rotary right'), category = _('Ins Forward panel and gauges')},
{pressed = iCommandHSI_HeadingRotaryLeft, name = _('HSI Commanded heading rotary left'), category = _('Ins Forward panel and gauges')},
{down = iCommandHSI_Test, up = iCommandHSI_Test_up, name = _('HSI Test'), category = _('Ins Forward panel and gauges')},
{down = iCommandHSI_SteeringSelection, name = _('HSI Desired track angle - Desired heading, Auto - Manual'), category = _('Ins Forward panel and gauges')},

{pressed = iCommandADI_ZeroPitchTrimRight, name = _('ADI Zero pitch trim right'), category = _('Ins Forward panel and gauges')},
{pressed = iCommandADI_ZeroPitchTrimLeft, name = _('ADI Zero pitch trim left'), category = _('Ins Forward panel and gauges')},
{down = iCommandADI_Test, up = iCommandADI_Test_up, name = _('ADI Test button'), category = _('Ins Forward panel and gauges')},
{down = iCommandADI_TestCover, name = _('ADI Test button cover'), category = _('Ins Forward panel and gauges')},

{pressed = iCommandRALT_DangerousAltitudeRotaryRight, name = _('Radar altimeter dangerous RALT set rotary right'), category = _('Ins Forward panel and gauges')},
{pressed = iCommandRALT_DangerousAltitudeRotaryLeft, name = _('Radar altimeter dangerous RALT set rotary left'), category = _('Ins Forward panel and gauges')},
{down = iCommandRALT_Test, up = iCommandRALT_Test_up, name = _('Radar altimeter test button'), category = _('Ins Forward panel and gauges')},

{pressed = iCommandAltimeterPressureIncrease,   up = iCommandAltimeterPressureStop, name = _('Altimeter QFE knob pressure increase'), category = _('Ins Forward panel and gauges')},
{pressed = iCommandAltimeterPressureDecrease, up = iCommandAltimeterPressureStop, name = _('Altimeter QFE knob pressure Decrease'), category = _('Ins Forward panel and gauges')},
{down = iCommandAccelReset, up = iCommandAccelReset, name = _('G-meter reset'), category = _('Ins Forward panel and gauges')},

{down = iCommandLaserRangeModeSwitchCover, name = _('Laser mode switch cover'), category = _('Ins Forward panel and gauges')},
{down = device_commands.Button_2, up = device_commands.Button_2, cockpit_device_id = devices.LASERRANGER, value_down = 1, value_up = 0, name = _('Laser Mode 2-pos Switch Cover : OPEN<>CLOSE'), category = {_('Special For Joystick'), _('Ins Forward panel and gauges')}},
{down = device_commands.Button_2, cockpit_device_id = devices.LASERRANGER, value_down = 1, name = _('Laser mode switch cover OPEN'), category = _('Ins Forward panel and gauges')},
{down = device_commands.Button_2, cockpit_device_id = devices.LASERRANGER, value_down = 0, name = _('Laser mode switch cover CLOSE'), category = _('Ins Forward panel and gauges')},

{down = iCommandLaserRangeModeSwitch, name = _('Laser mode switch'), category = _('Ins Forward panel and gauges')},
{down = device_commands.Button_5, up = device_commands.Button_6, cockpit_device_id = devices.LASERRANGER, value_down = 1, value_up = 1, name = _('Laser Mode 2-pos Switch : ILLUM<>RNG'), category = {_('Special For Joystick'), _('Ins Forward panel and gauges')}},
{down = device_commands.Button_5, cockpit_device_id = devices.LASERRANGER, value_down = 1, name = _('Laser mode ILLUM'), category = _('Ins Forward panel and gauges')},
{down = device_commands.Button_6, cockpit_device_id = devices.LASERRANGER, value_down = 1, name = _('Laser mode RNG'), category = _('Ins Forward panel and gauges')},

{down = iCommandLaserRangeReset, up=iCommandLaserRangeReset, name = _('Laser designater reset button'), category = _('Ins Forward panel and gauges')},

{down =iCommand_ENG_INTERF_TempIndTestwRunningEng ,up=iCommand_ENG_INTERF_TempIndTestwRunningEng, name = _('Exhaust gas temperature running engines indicator test button'), category = _('Ins Forward panel and gauges')},
{down=iCommand_ENG_INTERF_TempIndTestwStoppedEng , up=iCommand_ENG_INTERF_TempIndTestwStoppedEng, name = _('Exhaust gas temperature stopped engines indicator test button'), category = _('Ins Forward panel and gauges')},

{down=iCommand_FuelSysInterf_FuelQuantityIndTestOn , up=iCommand_FuelSysInterf_FuelQuantityIndTestOn, name = _('Fuel quantity indicator self test button'), category = _('Ins Forward panel and gauges')},


{down=iCommand_AGR_Oriet, up=iCommand_AGR_Oriet, name = _('SAI Standby Attitude Indicator Cage/control test handle up'), category = _('Ins Forward panel and gauges')},
{pressed=iCommand_AGR_axis_right, name = _('SAI Standby Attitude Indicator Cage/control test handle right'), category = _('Ins Forward panel and gauges')},
{pressed=iCommand_AGR_axis_left, name = _('SAI Standby Attitude Indicator Cage/control test handle left'), category = _('Ins Forward panel and gauges')},


-- Ins HUD controls
--{down = iCommandPlaneHUDFilterOnOff, name = _('Raise/Lower Colour Filter On HUD'), category = _('Ins HUD controls')},
{down = device_commands.Button_4, cockpit_device_id = devices.HUD, value_down = 1, name = _('Raise/Lower Colour Filter On HUD'), category = _('Ins HUD controls')},
--{down = iCommandPlaneModeGrid, name = _('HUD Modes Reticle/Night/Day'), category = _('Ins HUD controls')},
{down = device_commands.Button_5, cockpit_device_id = devices.HUD, value_down = 1, name = _('HUD Modes Reticle/Night/Day - next'), category = _('Ins HUD controls')},
{down = device_commands.Button_5, cockpit_device_id = devices.HUD, value_down = -1, name = _('HUD Modes Reticle/Night/Day - prev.'), category = _('Ins HUD controls')},
{pressed = iCommandHUDBrightnessUp, name = _('HUD Brightness up'), category = _('Ins HUD controls')},
{pressed = iCommandHUDBrightnessDown, name = _('HUD Brightness down'), category = _('Ins HUD controls')},
{down = iCommandHUDTest,up = iCommandHUDTest_up, name = _('HUD Test'), category = _('Ins HUD controls')},



-- Ins Countermeasures dispensers (Ка-50 - щиток УВ-26)
{down = iCommandPlaneCMDDispence,  up = iCommandPlaneCMDDispenceOff, name = _('UV-26 Start dispensing'), category = _('Ins Countermeasures dispensers UV-26')},
{down = iCommandPlaneCMDDispenceStop,  up = iCommandPlaneCMDDispenceStopOff, name = _('UV-26 Stop dispensing'), category = _('Ins Countermeasures dispensers UV-26')},
{down = iCommandPlaneCMDChangeRippleQuantity,  up = iCommandPlaneCMDChangeRippleQuantityOff, name = _('UV-26 Number of flare sequences'), category = _('Ins Countermeasures dispensers UV-26')},
{down = iCommandPlaneCMDChangeRippleInterval,    up = iCommandPlaneCMDChangeRippleIntervalOff, name = _('UV-26 Delay between sequences'), category = _('Ins Countermeasures dispensers UV-26')},
{down = iCommandPlaneCMDChangeBurstAmount,  up = iCommandPlaneCMDChangeBurstAmountOff, name = _('UV-26 Number of flares in sequence'), category = _('Ins Countermeasures dispensers UV-26')},
{down = iCommandPlaneCMDCancelCurrentProgram, up = iCommandPlaneCMDCancelCurrentProgramOff, name = _('UV-26 Reset current program'), category = _('Ins Countermeasures dispensers UV-26')},

--{down = iCommandPlaneCMDChangeBoard, name = _('UV-26 Change dispensing board Left-Both-Right'), category = _('Ins Countermeasures dispensers UV-26')},
{down = device_commands.Button_14, cockpit_device_id = devices.UV_26, value_down = 1, name = _('UV-26 Change dispensing board : NEXT'), category = _('Ins Countermeasures dispensers UV-26')},
{down = device_commands.Button_14, cockpit_device_id = devices.UV_26, value_down = -1, name = _('UV-26 Change dispensing board : PREV'), category = _('Ins Countermeasures dispensers UV-26')},
		
{down = device_commands.Button_15, cockpit_device_id = devices.UV_26, value_down = 1, name = _('UV-26 Change dispensing board : LEFT'), category = _('Ins Countermeasures dispensers UV-26')},
{down = device_commands.Button_16, cockpit_device_id = devices.UV_26, value_down = 1, name = _('UV-26 Change dispensing board : BOTH'), category = _('Ins Countermeasures dispensers UV-26')},
{down = device_commands.Button_17, cockpit_device_id = devices.UV_26, value_down = 1, name = _('UV-26 Change dispensing board : RIGHT'), category = _('Ins Countermeasures dispensers UV-26')},

{down = iCommandPlaneCMDShowAmountOrProgram, name = _('UV-26 Amount flares counter / Programming'), category = _('Ins Countermeasures dispensers UV-26')},


-- Ins Cyclick Stick
{pressed = iCommandPlaneDesignate_CageOn, up = iCommandPlaneDesignate_CageOff, name = _('Uncage SHKVAL, designate target'), category = _('Ins Cyclic Stick')},
{combos = {{key = 'JOY_BTN_POV1_U', reformers = {'RAlt'}}}, pressed = iCommandPlaneRadarUp, up = iCommandPlaneRadarStop, name = _('KU-31 Shkval slew up'), category = _('Ins Cyclic Stick')},
{combos = {{key = 'JOY_BTN_POV1_D', reformers = {'RAlt'}}}, pressed = iCommandPlaneRadarDown, up = iCommandPlaneRadarStop, name = _('KU-31 Shkval slew down'), category = _('Ins Cyclic Stick')},
{combos = {{key = 'JOY_BTN_POV1_L', reformers = {'RAlt'}}}, pressed = iCommandPlaneRadarLeft, up = iCommandPlaneRadarStop, name = _('KU-31 Shkval slew left'), category = _('Ins Cyclic Stick')},
{combos = {{key = 'JOY_BTN_POV1_R', reformers = {'RAlt'}}}, pressed = iCommandPlaneRadarRight, up = iCommandPlaneRadarStop, name = _('KU-31 Shkval slew right'), category = _('Ins Cyclic Stick')},
{down = iCommandPlaneRadarCenter, name = _('KU-31 Shkval center'), category = _('Ins Cyclic Stick')},
{combos = defaultDeviceAssignmentFor("fire"), down = iCommandPlaneFire, up = iCommandPlaneFireOff, name = _('Gun fire'), category = _('Ins Cyclic Stick')},
{combos = {{key = 'JOY_BTN2'}}, down = iCommandPlanePickleOn,    up = iCommandPlanePickleOff, name = _('Release weapons'), category = _('Ins Cyclic Stick')},

{down = iCommandPlaneModeCannon, name = _('Gun Select'), category = _('Ins Cyclic Stick')},
{down = device_commands.Button_25, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 1, name = _('Gun Select : ON'), category = _('Ins Cyclic Stick')},
{down = device_commands.Button_26, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 0.25, name = _('Gun Select : OFF'), category = _('Ins Cyclic Stick')},
{down = iCommandPlaneModeCannon, up = iCommandPlaneModeCannon, value_down = 1, value_up = 0, name = _('Gun Select Trigger Position : GUN<>RKT'), category = {_('Special For Joystick'), _('Ins Cyclic Stick')}},

{pressed = iCommandPlaneUpStart    , up = iCommandPlaneUpStop  ,   name = _('Cyclic nose down'), category = _('Ins Cyclic Stick')},
{pressed = iCommandPlaneDownStart  , up = iCommandPlaneDownStop,   name = _('Cyclic nose up'), category = _('Ins Cyclic Stick')},
{pressed = iCommandPlaneLeftStart  , up = iCommandPlaneLeftStop,   name = _('Cyclic bank left'), category = _('Ins Cyclic Stick')},
{pressed = iCommandPlaneRightStart , up = iCommandPlaneRightStop,  name = _('Cyclic bank right'), category = _('Ins Cyclic Stick')},

{combos = {{key = 'JOY_BTN3'}}, down = iCommandPlaneTrimOn, up = iCommandPlaneTrimOff, name = _('Trimmer'), category = _('Ins Cyclic Stick')},
{down = iCommandPlaneTrimCancel, name = _('Trimmer reset'), category = _('Ins Cyclic Stick')},
{combos = {{key = 'JOY_BTN3', reformers = {'LAlt'}}}, down = iCommandHelicopterHover,up = iCommandHelicopterHover_up,  name = _('Hover On/Off'), category = _('Ins Cyclic Stick')},
{down = iCommandAutopilotEmergOFF,up = iCommandAutopilotEmergOFF_up, name = _('Autopilot Emergency Off'), category = _('Ins Cyclic Stick')},
{down = iCommandPlaneWheelBrakeOn, pressed = iCommandPlaneWheelBrakeOn, up = iCommandPlaneWheelBrakeOff, name = _('Wheel brake (press and hold)'), category = _('Ins Cyclic Stick')},

{down = iCommandPlaneWheelParkingBrake, name = _('Parking brake'), category = _('Ins Cyclic Stick')},
{down = iCommandPlaneWheelParkingBrake, up = iCommandPlaneWheelParkingBrake, value_down = 1.0, value_up = 0.0, name = _('Parking Brake Lever Position : DEPRESSED<>RELEASED'), category = {_('Special For Joystick'), _('Ins Cyclic Stick')}},

{down = iCommandHelicopter_PanelsIlluminationButtonDown, up = iCommandHelicopter_PanelsIlluminationButtonUp, name = _('Cockpit gauges illumination (stick)'), category = _('Ins Cyclic Stick')},

{down = iCommandPlane_SPU9_PTT_on, up = iCommandPlane_SPU9_PTT_off, name = _('SPU-9 PTT (call radio menu)'), category = _('Ins Cyclic Stick')},
-- VoIP radio global command
-- in case you need to open commands in the cockpit
{down = iCommandVoIPRadioPushToTalkEnableDisableVoice, up = iCommandVoIPRadioPushToTalkEnableDisableVoice, value_down = 1.0, value_up = 0.0, name = _('SPU-9 PTT (VOIP)'), category = _('Ins Cyclic Stick')},

-- Ins Collective Stick
{combos = {{key = 'JOY_BTN4'}}, down = iCommandPlane_LockOn_start, up = iCommandPlane_LockOn_finish, name = _('Lock target'), category = _('Ins Collective Stick')},

{down = iCommandPlaneZoomIn, name = _('Shkval Narrow View 23x'), category = _('Ins Collective Stick')},
{down = iCommandPlaneZoomOut, name = _('Shkval Wide View 7x'), category = _('Ins Collective Stick')},
{down = iCommandPlaneZoomIn, up = iCommandPlaneZoomOut, name = _('Shkval Narrow/Wide View 2-pos Switch : NARROW<>WIDE'), category = {_('Special For Joystick'), _('Ins Collective Stick')}},

{down = iCommandPlaneIncreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('TV Target frame Increase size'), category = _('Ins Collective Stick')},
{down = iCommandPlaneDecreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('TV Target frame Decrease size'), category = _('Ins Collective Stick')},
{down = iCommandHelicopter_CollectiveStopper_Up, up = iCommandHelicopter_CollectiveStopper_Down, name = _('Collective brake - Assign altitude lever'), category = _('Ins Collective Stick')},
--{combos = {{key = 'JOY_BTN5'}}, down = iCommandPlaneChangeWeapon, name = _('Outward - Inward Stations Change Weapon'), category = _('Ins Collective Stick')},

{down = iCommandPlane_RouteMode, name = _('Engage/Disengage Route Mode'), category = _('Ins Collective Stick')},
{down = device_commands.Button_4, up = device_commands.Button_4, cockpit_device_id = devices.NAV_INTERFACE, value_down = 1, value_up = 0, name = _('Route/Descent 3-pos Switch : ROUTE<>CENTER'), category = {_('Special For Joystick'), _('Ins Collective Stick')}},
{down = iCommandPlane_DescentMode, up = iCommandPlane_DescentModeOff, name = _('Engage Descent Mode'), category = _('Ins Collective Stick')},

{down = iCommandPlane_SpotLight_left,  up = iCommandPlane_SpotLight_hor_stop, name = _('Spot light left'), category = _('Ins Collective Stick')},
{down = iCommandPlane_SpotLight_right, up = iCommandPlane_SpotLight_hor_stop, name = _('Spot light right'), category = _('Ins Collective Stick')},
{down = iCommandPlane_SpotLight_up,    up = iCommandPlane_SpotLight_vert_stop, name = _('Spot light up'), category = _('Ins Collective Stick')},
{down = iCommandPlane_SpotLight_down,  up = iCommandPlane_SpotLight_vert_stop, name = _('Spot light down'), category = _('Ins Collective Stick')},
{down = iCommandPlaneCollectiveIncrease, pressed = iCommandPlaneCollectiveIncrease, up = iCommandPlaneCollectiveStop, name = _('Collective up'), category = _('Ins Collective Stick')},
{down = iCommandPlaneCollectiveDecrease, pressed = iCommandPlaneCollectiveDecrease, up = iCommandPlaneCollectiveStop, name = _('Collective down'), category = _('Ins Collective Stick')},

{down = iCommandHelicopter_SelectWeapon_Internal,up = iCommandHelicopter_SelectWeapon_hor_up, name = _('Weapon selection inward stations'), category = _('Ins Collective Stick')},
{down = iCommandHelicopter_SelectWeapon_External,up = iCommandHelicopter_SelectWeapon_hor_up, name = _('Weapon selection outward stations'), category = _('Ins Collective Stick')},
{down = iCommandHelicopter_SelectWeapon_ALL	    ,up = iCommandHelicopter_SelectWeapon_vert_up, name = _('Weapon selection all stations'), category = _('Ins Collective Stick')},
{down = iCommandHelicopter_SelectWeapon_AA	    ,up = iCommandHelicopter_SelectWeapon_vert_up, name = _('Weapon selection A-A mode'), category = _('Ins Collective Stick')},

{down = iCommandPlane_ReadjustFreeTurbineRPM_Up, name = _('Readjust Free Turbine RPM to Nominal'), category = _('Ins Collective Stick')},
{down = iCommandPlane_ReadjustFreeTurbineRPM_Down, name = _('Readjust Free Turbine RPM to Low'), category = _('Ins Collective Stick')},


--Ins Rudder
{down = iCommandPlaneLeftRudderStart, up = iCommandPlaneLeftRudderStop, name = _('Rudder left'), category = _('Ins Rudder')},
{down = iCommandPlaneRightRudderStart, up = iCommandPlaneRightRudderStop, name = _('Rudder right'), category = _('Ins Rudder')},

--Ins Engines Start-Up Control Panel and levers
{down = iCommandHelicopter_Selected_Engine_start, up = iCommandHelicopter_Selected_Engine_start_up, name = _('Start-up engine'), category = _('Ins Engines start-up control panel and levers')},
{down = iCommandHelicopter_Selected_Engine_interrupt_start, up = iCommandHelicopter_Selected_Engine_interrupt_start_up, name = _('Interrupt start-up sequence'), category = _('Ins Engines start-up control panel and levers')},
{down = iCommandHelicopter_APU_stop, up = iCommandHelicopter_APU_stop_up, name = _('Stop APU button'), category = _('Ins Engines start-up control panel and levers')},

{down = iCommandHelicopter_Engine_Select, name = _('Engine selector'), category = _('Ins Engines start-up control panel and levers')},
{down = device_commands.Button_8, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 0, name = _('Engine selector : APU'), category = _('Ins Engines start-up control panel and levers')},
{down = device_commands.Button_8, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 0.1, name = _('Engine selector : LEFT ENG'), category = _('Ins Engines start-up control panel and levers')},
{down = device_commands.Button_8, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 0.2, name = _('Engine selector : RIGHT ENG'), category = _('Ins Engines start-up control panel and levers')},
{down = device_commands.Button_8, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 0.3, name = _('Engine selector : TURBO GEAR'), category = _('Ins Engines start-up control panel and levers')},

{down = device_commands.Button_8, up = device_commands.Button_8, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 0.1, value_up = 0, name = _('Engine selector 4-pos Switch : LEFT ENG<>CENTER(APU)'), category = {_('Special For Joystick'), _('Ins Engines start-up control panel and levers')}},
{down = device_commands.Button_8, up = device_commands.Button_8, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 0.2, value_up = 0, name = _('Engine selector 4-pos Switch : RIGHT ENG<>CENTER(APU)'), category = {_('Special For Joystick'), _('Ins Engines start-up control panel and levers')}},

--{down = iCommandEngineLaunchMethod, name = _('Engine Startup/Crank/False Start selector'), category = _('Ins Engines start-up control panel and levers')},
{down = device_commands.Button_26, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 1, name = _('Engine Startup/Crank/False Start selector : NEXT'), category = _('Ins Engines start-up control panel and levers')},
{down = device_commands.Button_26, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = -1, name = _('Engine Startup/Crank/False Start selector : PREV'), category = _('Ins Engines start-up control panel and levers')},
{down = device_commands.Button_12, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 0, name = _('Engine Startup/Crank/False Start selector : START'), category = _('Ins Engines start-up control panel and levers')},
{down = device_commands.Button_12, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 0.1, name = _('Engine Startup/Crank/False Start selector : CRANK'), category = _('Ins Engines start-up control panel and levers')},
{down = device_commands.Button_12, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 0.2, name = _('Engine Startup/Crank/False Start selector : FALSE START'), category = _('Ins Engines start-up control panel and levers')},

{down = iCommandPlaneAUTIncreaseRegime, name = _('Throttle up (Idle-Medium-Auto-Full)'), category = _('Ins Engines start-up control panel and levers')},
{down = iCommandPlaneAUTDecreaseRegime, name = _('Throttle down (Idle-Medium-Auto-Full)'), category = _('Ins Engines start-up control panel and levers')},
{down = iCommandPlaneAUTIncreaseRegimeLeft, name = _('Throttle Left Up (Idle-Medium-Auto-Full)'), category = _('Ins Engines start-up control panel and levers')},
{down = iCommandPlaneAUTDecreaseRegimeLeft, name = _('Throttle Left Down (Idle-Medium-Auto-Full)'), category = _('Ins Engines start-up control panel and levers')},
{down = iCommandPlaneAUTIncreaseRegimeRight, name = _('Throttle Right Up (Idle-Medium-Auto-Full)'), category = _('Ins Engines start-up control panel and levers')},
{down = iCommandPlaneAUTDecreaseRegimeRight, name = _('Throttle Right Down (Idle-Medium-Auto-Full)'), category = _('Ins Engines start-up control panel and levers')},

{down = iCommandHelicopter_Left_Engine_Lock, name = _('Cut-off valve left engine'), category = _('Ins Engines start-up control panel and levers')},
{down = device_commands.Button_9, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 1, name = _('Cut-off valve left engine : ON'), category = _('Ins Engines start-up control panel and levers')},
{down = device_commands.Button_9, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 0, name = _('Cut-off valve left engine : OFF'), category = _('Ins Engines start-up control panel and levers')},

{down = iCommandHelicopter_Right_Engine_Lock, name = _('Cut-off valve right engine'), category = _('Ins Engines start-up control panel and levers')},
{down = device_commands.Button_10, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 1, name = _('Cut-off valve right engine : ON'), category = _('Ins Engines start-up control panel and levers')},
{down = device_commands.Button_10, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 0, name = _('Cut-off valve right engine : OFF'), category = _('Ins Engines start-up control panel and levers')},

{down = iCommandHelicopter_Rotor_Lock, name = _('Rotor brake'), category = _('Ins Engines start-up control panel and levers')},

-- Ins Targeting Mode Controls Panel PVR (Ка-50 - ПВР)
{down = iCommandPlaneCancelWeaponsDelivery, up = iCommandPlaneCancelWeaponsDelivery_up, name = _('Button Targeting mode reset'), category = _('Ins Targeting Mode Controls Panel PVR')},

{down = iCommandPlaneModeHelmet, name = _('Helmet-mounted system On/Off'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = device_commands.Button_2, cockpit_device_id = devices.HELMET, value_down = 1, name = _('Helmet-mounted system : ON'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = device_commands.Button_2, cockpit_device_id = devices.HELMET, value_down = 0, name = _('Helmet-mounted system : OFF'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = device_commands.Button_2, up = device_commands.Button_2, cockpit_device_id = devices.HELMET, value_down = 1, value_up = 0, name = _('Helmet-mounted system 2-pos Switch : ON<>OFF'), category = {_('Special For Joystick'), _('Ins Targeting Mode Controls Panel PVR')}},

{down = iCommandPlaneLaserRangerOnOff, name = _('Laser standby On/Off switch'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = device_commands.Button_1, cockpit_device_id = devices.LASERRANGER, value_down = 1, name = _('Laser standby On/Off switch : ON'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = device_commands.Button_1, cockpit_device_id = devices.LASERRANGER, value_down = 0, name = _('Laser standby On/Off switch : OFF'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = device_commands.Button_1, up = device_commands.Button_1, cockpit_device_id = devices.LASERRANGER, value_down = 1, value_up = 0, name = _('Laser Standby Power 2-pos Switch : ON<>OFF'), category = {_('Special For Joystick'), _('Ins Targeting Mode Controls Panel PVR')}},

{down = iCommandPlane_AutomaticTracking_Gunsight_switch, name = _('Auto-Tracking/Gun Sight Reticle Mode - AT/RET'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = device_commands.Button_17, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 1, name = _('Auto-Tracking/Gun Sight Reticle Mode : AT'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = device_commands.Button_17, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 0, name = _('Auto-Tracking/Gun Sight Reticle Mode : RET'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = device_commands.Button_17, up = device_commands.Button_17, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 1, value_up = 0, name = _('Auto-Tracking/Gun Sight Reticle Mode 2-pos Switch : AT<>RET'), category = {_('Special For Joystick'), _('Ins Targeting Mode Controls Panel PVR')}},

{down = iCommandPlane_K041_Power						, name = _('K-041 Targeting system power switch'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = device_commands.Button_2, up = device_commands.Button_2, cockpit_device_id = devices.K041, value_down = 1, value_up = 0, name = _('K-041 Targeting-Navigation System Power 2-pos Switch : ON<>OFF'), category = {_('Special For Joystick'), _('Ins Targeting Mode Controls Panel PVR')}},

{down = iCommandPlane_AutomaticTurn, up = iCommandPlane_AutomaticTurn_up, name = _('Button Automatic turn on target mode'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = iCommandPlane_GroundMovingTarget, up =	iCommandPlane_GroundMovingTarget_up, name = _('Button Ground moving target'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = iCommandPlane_AirborneTarget, up = iCommandPlane_AirborneTarget_up, name = _('Button Airborne target'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = iCommandPlane_HeadOnAspect, up = iCommandPlane_HeadOnAspect_up, name = _('Button Head-on airborne target aspect'), category = _('Ins Targeting Mode Controls Panel PVR')},

{down = iCommandPlane_ChangeDeliveryMode_right, name = _('Weapon system mode selector (to right)'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = iCommandPlane_ChangeDeliveryMode_left, name = _('Weapon system mode selector (to left)'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = device_commands.Button_14, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 0, name = _('Weapon system mode selector : MOV'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = device_commands.Button_14, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 0.1, name = _('Weapon system mode selector : FIX'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = device_commands.Button_14, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 0.2, name = _('Weapon system mode selector : MAN'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = device_commands.Button_14, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 0.3, name = _('Weapon system mode selector : FAIL'), category = _('Ins Targeting Mode Controls Panel PVR')},
{down = device_commands.Button_14, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 0.4, name = _('Weapon system mode selector : NAV'), category = _('Ins Targeting Mode Controls Panel PVR')},


--Ins Weapons Status and Control Panel PUI-800 (Ка-50 - ПУИ-800)
{down = iCommandSwitchMasterArm, name = _('Master arm on/off'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_1, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 1, name = _('Master arm : ON'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_1, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 0, name = _('Master arm : OFF'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_1, up = device_commands.Button_1, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 1, value_up = 0, name = _('Master Arm 2-pos Switch : ARM<>DISARM'), category = {_('Special For Joystick'), _('Ins Weapons Status and Control Panel PUI-800')}},

{down = iCommandPlaneJettisonFuelTanks,up = iCommandPlaneJettisonFuelTanksUp, name = _('External stores jettison'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = iCommandPlaneJettisonWeapons,up = iCommandPlaneJettisonWeaponsUp, name   = _('Expedite emergency ATGM launch'), category = _('Ins Weapons Status and Control Panel PUI-800')},

{down = iCommandPlane_WeaponMode_Manual_Auto, name = _('Weapon Control Switch - Manual/Auto'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_5, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 1, name = _('Weapon Control Switch : MAN'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_5, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 0, name = _('Weapon Control Switch : AUTO'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_5, up = device_commands.Button_5, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 1, value_up = 0, name = _('Weapon Control 2-pos Switch : MAN<>AUTO'), category = {_('Special For Joystick'), _('Ins Weapons Status and Control Panel PUI-800')}},

--{down = iCommandPlane_WeaponMode_switch		, name = _('Burst Length Switch'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_24, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 1, name = _('Burst Length Switch : NEXT'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_24, cockpit_device_id = devices.WEAP_INTERFACE, value_down = -1, name = _('Burst Length Switch : PREV'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_4, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 0, name = _('Burst Length Switch : SHORT'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_4, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 0.1, name = _('Burst Length Switch : MEDIUM'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_4, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 0.2, name = _('Burst Length Switch : LONG'), category = _('Ins Weapons Status and Control Panel PUI-800')},

{down = iCommandPlane_AmmoTypeSelect		, name = _('Cannon Ammo Type Switch - HE/AP'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_6, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 1, name = _('Cannon Ammo Type Switch : HE'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_6, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 0, name = _('Cannon Ammo Type Switch : AP'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_6, up = device_commands.Button_6, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 1, value_up = 0, name = _('Cannon Ammo Type 2-pos Switch : HE<>AP'), category = {_('Special For Joystick'), _('Ins Weapons Status and Control Panel PUI-800')}},

{down = iCommandPlane_FireRate				, name = _('Cannon Rate of Fire Switch - LOW/HIGH'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_20, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 1, name = _('Cannon Rate of Fire Switch : LOW'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_20, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 0, name = _('Cannon Rate of Fire Switch : HI'), category = _('Ins Weapons Status and Control Panel PUI-800')},
{down = device_commands.Button_20, up = device_commands.Button_20, cockpit_device_id = devices.WEAP_INTERFACE, value_down = 1, value_up = 0, name = _('Cannon Rate 2-pos Switch : LOW<>HIGH'), category = {_('Special For Joystick'), _('Ins Weapons Status and Control Panel PUI-800')}},

{down =	iCommandPlane_JettisonMode_explosion, name = _('Jettison arm mode - explosive/unexplosive'), category = _('Ins Weapons Status and Control Panel PUI-800')},



-- Ins Datalink panel PRTs (Пульт Режимов Целеуказания ПРЦ)
{down = iCommandPlaneDLK_Target1, up = iCommandPlaneDLK_Target1_up, name = _('PRTs Target 1 / Vehicle'), category = _('Ins Datalink panel PRTs')},
{down = iCommandPlaneDLK_Target2, up = iCommandPlaneDLK_Target2_up, name = _('PRTs Target 2 / SAM'), category = _('Ins Datalink panel PRTs')},
{down = iCommandPlaneDLK_Target3, up = iCommandPlaneDLK_Target3_up, name = _('PRTs Target 3 / Other'), category = _('Ins Datalink panel PRTs')},
{down = iCommandPlaneDLK_RefPoint, up = iCommandPlaneDLK_RefPoint_up, name = _('PRTs Reference point'), category = _('Ins Datalink panel PRTs')},
{down = iCommandPlaneDLK_Wingman1, up = iCommandPlaneDLK_Wingman1_up, name = _('PRTs To Wingman 1'), category = _('Ins Datalink panel PRTs')},
{down = iCommandPlaneDLK_Wingman2, up = iCommandPlaneDLK_Wingman2_up, name = _('PRTs To Wingman 2'), category = _('Ins Datalink panel PRTs')},
{down = iCommandPlaneDLK_Wingman3, up = iCommandPlaneDLK_Wingman3_up, name = _('PRTs To Wingman 3'), category = _('Ins Datalink panel PRTs')},
{down = iCommandPlaneDLK_Wingman4, up = iCommandPlaneDLK_Wingman4_up, name = _('PRTs To Wingman 4'), category = _('Ins Datalink panel PRTs')},
{down = iCommandPlaneDLK_All, up = iCommandPlaneDLK_All_up, name = _('PRTs To All'), category = _('Ins Datalink panel PRTs')},
{down = iCommandPlaneDLK_Erase, up = iCommandPlaneDLK_Erase_up, name = _('PRTs Erase Entering Data'), category = _('Ins Datalink panel PRTs')},
{down = iCommandPlaneDLK_Ingress, up = iCommandPlaneDLK_Ingress_up, name = _('PRTs Ingress to Target'), category = _('Ins Datalink panel PRTs')},
{down = iCommandPlaneDLK_SendMemory, up = iCommandPlaneDLK_SendMemory_up, name = _('PRTs Send / Memory'), category = _('Ins Datalink panel PRTs')},
{down = iCommandPlaneDLK_None, up = iCommandPlaneDLK_None_up, name = _('PRTs void button'), category = _('Ins Datalink panel PRTs')},


-- Ins  NAV panel controls PVI (Ка-50 - щиток ПВИ)
{down = iCommandPlaneNavChangePanelModeRight, name = _('PVI Change Master Mode (to right)'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNavChangePanelModeLeft, name = _('PVI Change Master Mode (to left)'), category = _('Ins NAV panel controls PVI')},
{down = device_commands.Button_26, cockpit_device_id = devices.PVI, value_down = 0, name = _('PVI Change Master Mode : OFF'), category = _('Ins NAV panel controls PVI')},
{down = device_commands.Button_26, cockpit_device_id = devices.PVI, value_down = 0.1, name = _('PVI Change Master Mode : CHECK'), category = _('Ins NAV panel controls PVI')},
{down = device_commands.Button_26, cockpit_device_id = devices.PVI, value_down = 0.2, name = _('PVI Change Master Mode : ENT'), category = _('Ins NAV panel controls PVI')},
{down = device_commands.Button_26, cockpit_device_id = devices.PVI, value_down = 0.3, name = _('PVI Change Master Mode : OPER'), category = _('Ins NAV panel controls PVI')},
{down = device_commands.Button_26, cockpit_device_id = devices.PVI, value_down = 0.4, name = _('PVI Change Master Mode : STM'), category = _('Ins NAV panel controls PVI')},
{down = device_commands.Button_26, cockpit_device_id = devices.PVI, value_down = 0.5, name = _('PVI Change Master Mode : K-1'), category = _('Ins NAV panel controls PVI')},
{down = device_commands.Button_26, cockpit_device_id = devices.PVI, value_down = 0.6, name = _('PVI Change Master Mode : K-2'), category = _('Ins NAV panel controls PVI')},

{down = iCommandPlaneNavSetFixtakingMode, name = _('PVI Set Fixtaking Method'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_DLK_OnOff, name = _('PVI Datalink Power'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_PB1,               up = iCommandPlaneNav_PB1_off, name = _('PVI Pushbutton 1'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_PB2,               up = iCommandPlaneNav_PB2_off, name = _('PVI Pushbutton 2'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_PB3,               up = iCommandPlaneNav_PB3_off, name = _('PVI Pushbutton 3'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_PB4,               up = iCommandPlaneNav_PB4_off, name = _('PVI Pushbutton 4'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_PB5,               up = iCommandPlaneNav_PB5_off, name = _('PVI Pushbutton 5'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_PB6,               up = iCommandPlaneNav_PB6_off, name = _('PVI Pushbutton 6'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_PB7,               up = iCommandPlaneNav_PB7_off, name = _('PVI Pushbutton 7'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_PB8,               up = iCommandPlaneNav_PB8_off, name = _('PVI Pushbutton 8'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_PB9,               up = iCommandPlaneNav_PB9_off, name = _('PVI Pushbutton 9'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_PB0,               up = iCommandPlaneNav_PB0_off, name = _('PVI Pushbutton 0'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_Steerpoints,       up=iCommandPlaneNav_Steerpoints_off,  name = _('PVI Waypoint Mode'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_INU_realign,       up=iCommandPlaneNav_INU_realign_off, name = _('PVI In-flight INU Realignment'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_POS_corrMode,      up=iCommandPlaneNav_POS_corrMode_off, name = _('PVI Navpos Correction Mode'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_INU_precise_align, up=iCommandPlaneNav_INU_precise_align_off, name = _('PVI Precise INU Alignment'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_Airfields,         up=iCommandPlaneNav_Airfields_off, name = _('PVI Airfields Mode'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_INU_normal_align,  up=iCommandPlaneNav_INU_normal_align_off, name = _('PVI Normal INU Alignment'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_Targets,           up=iCommandPlaneNav_Targets_off, name = _('PVI Targets Mode'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_Enter,             up=iCommandPlaneNav_Enter_off, name = _('PVI Enter'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_Cancel,            up=iCommandPlaneNav_Cancel_off, name = _('PVI Cancel'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_POS_init,          up=iCommandPlaneNav_POS_init_off,  name = _('PVI Initial NAV Position'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_SelfCoord,         up=iCommandPlaneNav_SelfCoord_off,  name = _('PVI Self Coordinates'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_CourseTimeRange,   up=iCommandPlaneNav_CourseTimeRange_off, name = _('PVI Course / Time / Range'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_Wind,              up=iCommandPlaneNav_Wind_off, name = _('PVI Wind Heading / Speed'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_THeadingTimeRangeF,up=iCommandPlaneNav_THeadingTimeRangeF_off, name = _('PVI True Heading / Time / Range to Final STP'), category = _('Ins NAV panel controls PVI')},
{down = iCommandPlaneNav_BearingRangeT,     up=iCommandPlaneNav_BearingRangeT_off, name = _('PVI Bearing / Range to Target'), category = _('Ins NAV panel controls PVI')},
{pressed =iCommand_PVI_BRIGHTNESS_LEVER_up , name = _('PVI Lighting up'), category = _('Ins NAV panel controls PVI')},
{pressed =iCommand_PVI_BRIGHTNESS_LEVER_down , name = _('PVI Lighting down'), category = _('Ins NAV panel controls PVI')},

--Ins datalink panel PVTs (Блок ПВЦ-800 из комплекта К-041)
--{down = iCommandPlaneDLK_Self_ID_change, name = _('Self ID'), category = _('Ins Datalink panel PVTs ')},
{down = device_commands.Button_20, cockpit_device_id = devices.DATALINK, value_down = 1, name = _('Self ID : NEXT'), category = _('Ins Datalink panel PVTs ')},
{down = device_commands.Button_20, cockpit_device_id = devices.DATALINK, value_down = -1, name = _('Self ID : PREV'), category = _('Ins Datalink panel PVTs ')},

--{down = iCommandPlaneDLK_mode_change, name = _('Datalink mode'), category = _('Ins Datalink panel PVTs ')},
{down = device_commands.Button_19, cockpit_device_id = devices.DATALINK, value_down = 1, name = _('Datalink mode : NEXT'), category = _('Ins Datalink panel PVTs ')},
{down = device_commands.Button_19, cockpit_device_id = devices.DATALINK, value_down = -1, name = _('Datalink mode : PREV'), category = _('Ins Datalink panel PVTs ')},

-- Ins ABRIS AMMS
{down = iCommandPlane_ABRIS_Power, name = _('ABRIS Power'), category = _('Ins ABRIS AMMS')},
{down = iCommandPlane_ABRIS_BT_1, up = iCommandPlane_ABRIS_BT_1_up, name = _('ABRIS Button 1'), category = _('Ins ABRIS AMMS')},
{down = iCommandPlane_ABRIS_BT_2, up = iCommandPlane_ABRIS_BT_2_up, name = _('ABRIS Button 2'), category = _('Ins ABRIS AMMS')},
{down = iCommandPlane_ABRIS_BT_3, up = iCommandPlane_ABRIS_BT_3_up, name = _('ABRIS Button 3'), category = _('Ins ABRIS AMMS')},
{down = iCommandPlane_ABRIS_BT_4, up = iCommandPlane_ABRIS_BT_4_up, name = _('ABRIS Button 4'), category = _('Ins ABRIS AMMS')},
{down = iCommandPlane_ABRIS_BT_5, up = iCommandPlane_ABRIS_BT_5_up, name = _('ABRIS Button 5'), category = _('Ins ABRIS AMMS')},
{down = iCommandPlane_ABRIS_Axis_Push, up = iCommandPlane_ABRIS_Axis_Push_up, name = _('ABRIS Axis Push'), category = _('Ins ABRIS AMMS')},
{pressed = iCommandPlane_ABRIS_Axis_Decrease, name = _('ABRIS Axis Decrease'), category = _('Ins ABRIS AMMS')},
{pressed = iCommandPlane_ABRIS_Axis_Increase, name = _('ABRIS Axis Increase'), category = _('Ins ABRIS AMMS')},
{pressed = iCommandPlane_ABRIS_Brightness_Decrease, name = _('ABRIS Brightness Decrease'), category = _('Ins ABRIS AMMS')},
{pressed = iCommandPlane_ABRIS_Brightness_Increase, name = _('ABRIS Brightness Increase'), category = _('Ins ABRIS AMMS')},

-- Ins Wall panel (Боковая панель)
{down = iCommandGroundPowerDC, name = _('Electrical power ground power DC'), category = _('Ins Wall panel')},
{down = iCommandGroundPowerDC_Cover, name = _('Electrical power ground power DC cover'), category = _('Ins Wall panel')},
{down = iCommandPowerBattery2, name = _('Electrical power battery 2'), category = _('Ins Wall panel')},
{down = iCommandPowerBattery2_Cover, name = _('Electrical power battery 2 cover'), category = _('Ins Wall panel')},
{down = iCommandPowerBattery1, name = _('Electrical power battery 1'), category = _('Ins Wall panel')},
{down = iCommandPowerBattery1_Cover, name = _('Electrical power battery 1 cover'), category = _('Ins Wall panel')},
{down = iCommandGroundPowerAC, name = _('Electrical power ground power AC'), category = _('Ins Wall panel')},
{down = iCommandPowerGeneratorLeft, name = _('Electrical power generator left'), category = _('Ins Wall panel')},
{down = iCommandPowerGeneratorRight, name = _('Electrical power generator right'), category = _('Ins Wall panel')},
{down = iCommandElectricalPowerInverter, name = _('Electrical power inverter AUTO/OFF/MAN'), category = _('Ins Wall panel')},

{down = iCommandPlane_SPU9_SPU_9_on_off, name = _('Radio equipment AVSK (SPU-9) intercom'), category = _('Ins Wall panel')},
{down = iCommandPlane_R_800_Power_on_off, name = _('Radio equipment VHF-2 (R-800)'), category = _('Ins Wall panel')},
{down = iCommandPlane_R_828_Power_on_off, name = _('Radio equipment VHF-1 (R-828)'), category = _('Ins Wall panel')},
{down = iCommandDatalinkTLK, name = _('Radio equipment datalink TLK'), category = _('Ins Wall panel')},
{down = iCommandDatalinkUHF_TLK, name = _('Radio equipment datalink UHF TLK'), category = _('Ins Wall panel')},

{down = iCommandFuelPumpsTankForward, name = _('Fuel pumps tank forward'), category = _('Ins Wall panel')},
{down = iCommandFuelPumpsTankRear, name = _('Fuel pumps tank rear'), category = _('Ins Wall panel')},
{down = iCommandFuelExternalPumpsTanksInner, name = _('Fuel pumps external tanks inner'), category = _('Ins Wall panel')},
{down = iCommandFuelExternalPumpsTanksOuter, name = _('Fuel pumps external tanks outer'), category = _('Ins Wall panel')},
{down = iCommandFuelmeterPower, name = _('Fuel meter power'), category = _('Ins Wall panel')},
{down = iCommandLeftEngineFuelValveShutOffCover, name = _('Shutoff valve left engine fuel cover'), category = _('Ins Wall panel')},
{down = iCommandLeftEngineFuelValveShutOff, name = _('Shutoff valve left engine fuel'), category = _('Ins Wall panel')},
{down = iCommandRightEngineFuelValveShutOffCover, name = _('Shutoff valve right engine fuel cover'), category = _('Ins Wall panel')},
{down = iCommandRightEngineFuelValveShutOff, name = _('Shutoff valve right engine fuel '), category = _('Ins Wall panel')},
{down = iCommandAPUFuelValveShutOffCover, name = _('Shutoff valve APU fuel cover'), category = _('Ins Wall panel')},
{down = iCommandAPUFuelValveShutOff, name = _('Shutoff valve APU fuel'), category = _('Ins Wall panel')},
{down = iCommandFuelBypassValveCover, name = _('Fuel bypass valve cover'), category = _('Ins Wall panel')},
{down = iCommandFuelBypassValve, name = _('Fuel bypass valve'), category = _('Ins Wall panel')},

{down = iCommandEjectingSystemPower1Cover, name = _('Ejecting system power cover'), category = _('Ins Wall panel')},
{down = iCommandEjectingSystemPower1, name = _('Ejecting system power 1'), category = _('Ins Wall panel')},
{down = iCommandEjectingSystemPower2, name = _('Ejecting system power 2'), category = _('Ins Wall panel')},
{down = iCommandEjectingSystemPower3, name = _('Ejecting system power 3'), category = _('Ins Wall panel')},

{down = iCommandWeaponsControlSystemCover, name = _('Weapons control system cover'), category = _('Ins Wall panel')},
{down = iCommandWeaponsControlSystem, name = _('Weapons control system'), category = _('Ins Wall panel')},

{down = iCommandMainHydraulicsCover, name = _('Main hydraulics cover'), category = _('Ins Wall panel')},
{down = iCommandMainHydraulics, name = _('Main hydraulics'), category = _('Ins Wall panel')},
{down = iCommandIFF_PowerCover, name = _('IFF power cover'), category = _('Ins Wall panel')},
{down = iCommandIFF_Power, name = _('IFF power'), category = _('Ins Wall panel')},
{down = iCommandTargetingNavigationSystemsPower, name = _('Targeting-Navigation system power'), category = _('Ins Wall panel')},

{down = iCommandElectronicControlSystemLeftEngineCover, name = _('EEG Electronic Engine Governor left engine cover'), category = _('Ins Wall panel')},
{down = iCommandElectronicControlSystemLeftEngine, name = _('EEG Electronic Engine Governor left engine'), category = _('Ins Wall panel')},
{down = iCommandElectronicControlSystemRightEngineCover, name = _('EEG Electronic Engine Governor right engine cover'), category = _('Ins Wall panel')},
{down = iCommandElectronicControlSystemRightEngine, name = _('EEG Electronic Engine Governor right engine'), category = _('Ins Wall panel')},
{down = iCommandHelicopter_Engine_Temperature_Control_Cover, name = _('EEG power turbine channel 1 test / channel 2 test three-switch contactor cover'), category = _('Ins Wall panel')},
{down = iCommandHelicopter_Engine_Temperature_Control, name = _('EEG power turbine channel 1 test / channel 2 test three-switch contactor'), category = _('Ins Wall panel')},
{down = iCommandHelicopter_TC_RPM_Cover, name = _('EEG gas generator test - Operate switch cover'), category = _('Ins Wall panel')},
{down = iCommandHelicopter_TC_RPM, name = _('EEG gas generator test - Operate switch'), category = _('Ins Wall panel')},

{down = iCommand_AGR_Power, name = _('SAI Standby Attitude Indicator power switch'), category = _('Ins Wall panel')},
{down = iCommand_AGR_Test, up = iCommand_AGR_Test, name = _('SAI Standby Attitude Indicator self test button'), category = _('Ins Wall panel')},


{down =iCommand_FireExting_LeftEngineExting, up=iCommand_FireExting_LeftEngineExting  , name = _('Fire extinguisher left engine '), category = _('Ins Wall panel')},
{down =iCommand_FireExting_RightEngineExting, up=iCommand_FireExting_RightEngineExting , name = _('Fire extinguisher right engine'), category = _('Ins Wall panel')},
{down =iCommand_FireExting_APUExting, up=iCommand_FireExting_APUExting , name = _('Fire extinguisher APU'), category = _('Ins Wall panel')},
{down =iCommand_FireExting_VentilatorExting, up=iCommand_FireExting_VentilatorExting , name = _('Fire extinguisher oil cooling fan'), category = _('Ins Wall panel')},
{down =iCommand_FireExting_ExtinguishersCover , name = _('Fire extinguishers WORK - OFF - TEST cover'), category = _('Ins Wall panel')},
{down =iCommand_FireExting_ExtinguishersToDown , name = _('Fire extinguishers WORK - OFF - TEST'), category = _('Ins Wall panel')},
{down =iCommand_FireExting_Signals , name = _('Fire signaling'), category = _('Ins Wall panel')},
{down =iCommand_FireExting_ReservoirsCover , name = _('Fire extinguisher First (Auto) / Second (Manual) selector cover'), category = _('Ins Wall panel')},
{down =iCommand_FireExting_Reservoirs , name = _('Fire extinguisher First (Auto) / Second (Manual) selector'), category = _('Ins Wall panel')},
{up = iCommand_FireDetectorsTest1stGroup, down = iCommand_FireDetectorsTest1stGroup, name = _('Fire warning 1st sensors group BIT selector'), category = _('Ins Wall panel')},
{up = iCommand_FireDetectorsTest2ndGroup, down = iCommand_FireDetectorsTest2ndGroup, name = _('Fire warning 2nd sensors group BIT selector'), category = _('Ins Wall panel')},
{up = iCommand_FireDetectorsTest3rdGroup, down = iCommand_FireDetectorsTest3rdGroup, name = _('Fire warning 3rd sensors group BIT selector'), category = _('Ins Wall panel')},

--{down = iCommand_FireExting_TestGroups, name = _('Fire warning 1st/2nd/3rd sensors groups BIT selector'), category = _('Ins Wall panel')},

--{down = iCommandHeadingMethodSwitch, name = _('Gyro/Mag/Manual heading'), category = _('Ins Wall panel')},
{down = device_commands.Button_5, cockpit_device_id = devices.NAV_INTERFACE, value_down = 1, name = _('Gyro/Mag/Manual heading : NEXT'), category = _('Ins Wall panel')},
{down = device_commands.Button_5, cockpit_device_id = devices.NAV_INTERFACE, value_down = -1, name = _('Gyro/Mag/Manual heading : PREV'), category = _('Ins Wall panel')},

{down = iCommandPlaneCockpitIlluminationGauges, name = _('Lighting cockpit panel switch'), category = _('Ins Wall panel')},
{down = iCommandPlaneCockpitIlluminationPanels, name = _('Lighting night vision cockpit switch'), category = _('Ins Wall panel')},
{down = iCommandPlaneCockpitIllumination, name = _('Lighting cockpit interior lamp switch'), category = _('Ins Wall panel')},
{down = iCommandPlaneADIAHRIllumination, name = _('Lighting HSI and ADI switch'), category = _('Ins Wall panel')},
{down = iCommandControlPanelIllumination, name = _('Lighting auxiliary panel switch'), category = _('Ins Wall panel')},
{down = iCommandPlaneRotorTipLights, name = _('Lights rotor tip'), category = _('Ins Wall panel')},
{down =  iCommandPlaneAntiCollisionLights , name  = _('Light anti-collision'), category = _('Ins Wall panel')},
{down =  iCommandPlaneFormationLights , name  =  _('Lights formation 10\%/30\%/100\%/Off'), category = _('Ins Wall panel')},

{down = iCommandHelicopter_SignalFlares_switch_OnOff, name = _('Signal flares power') , category = _('Ins Wall panel')},
{down = iCommandHelicopter_SignalFlares_RED		, name = _('Signal flares - red flare')   , category = _('Ins Wall panel')},
{down = iCommandHelicopter_SignalFlares_GREEN		, name = _('Signal flares - green flare') , category = _('Ins Wall panel')},
{down = iCommandHelicopter_SignalFlares_WHITE		, name = _('Signal flares - white flare') , category = _('Ins Wall panel')},
{down = iCommandHelicopter_SignalFlares_YELLOW		, name = _('Signal flares - yellow flare'), category = _('Ins Wall panel')},
{down = iCommand_WEAP_INTERF_MasterSimulate, name = _('Training mode switch'), category = _('Ins Targeting Mode Controls Panel PVR')},

{down =iCommand_SHKVAL_scan_vel_up , name = _('Shkval auto scan rate dial up'), category = _('Ins Wall panel')},
{down =iCommand_SHKVAL_scan_vel_down , name = _('Shkval auto scan rate dial down'), category = _('Ins Wall panel')},
{down =iCommand_SHKVAL_windscreen_wiper , name = _('Shkval windshield wiper'), category = _('Ins Wall panel')},

{down =iCommand_ZMS_3_MagVarRotaryRight, name = _('Magnetic variation knob right'), category = _('Ins Wall panel')},
{down =iCommand_ZMS_3_MagVarRotaryLeft, name = _('Magnetic variation knob left'), category = _('Ins Wall panel')},

-- Ins Overhead panel (Верхняя панель)
{down = iCommandPlaneLightsOnOff, name = _('Lights navigation 10\%/30\%/100\%/Off'), category = _('Ins Overhead panel')},
{down = iCommandPlaneNavLights_CodeModeOn, up = iCommandPlaneNavLights_CodeModeOff , name = _('Lights navigation Code Mode'), category = _('Ins Overhead panel')},
{down = iCommand_CPT_MECH_WindscreenWiper_Speed, name = _('Windshield wiper switch'), category = _('Ins Overhead panel')},
{down =iCommand_LWS_Reset, up=iCommand_LWS_Reset , name = _('L-140 Laser warning system reset button'), category = _('Ins Overhead panel')},
{down =iCommandPitotAoAHeat, name = _('Pitot static port and AoA sensors heat switch'), category = _('Ins Overhead panel')},
{down =iCommandPitotRam, name = _('Pitot ram air and clock heat switch'), category = _('Ins Overhead panel')},
{down =iCommand_CPT_MECH_PitotSystemHeatTest, up =iCommand_CPT_MECH_PitotSystemHeatTest,  name = _('Pitot system heat test'), category = _('Ins Overhead panel')},
{down =iCommandHelicopter_Rotor_Anti_Icing_Dust_Protection_System, name = _('Rotor de-icing system switch'), category = _('Ins Overhead panel')},

--{down = iCommandHelicopter_Engines_Anti_Icing_Dust_Protection_System, name = _('Engines de-icing / dust-protection systems switch'), category = _('Ins Overhead panel')},
{down = device_commands.Button_27, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = 1, name = _('Engines de-icing / dust-protection systems switch : NEXT'), category = _('Ins Overhead panel')},
{down = device_commands.Button_27, cockpit_device_id = devices.ENGINE_INTERFACE, value_down = -1, name = _('Engines de-icing / dust-protection systems switch : PREV'), category = _('Ins Overhead panel')},

-- Landing Lights & Voice Warning Panel (Панель управления освещением, переключением каналов АРК и речевым информатором)
--{down = iCommandPlaneHeadLightOnOff, name = _('Light landing search On/Retraction/Off'), category = _('Ins Landing Lights & Voice Warning Panel')},
{down = device_commands.Button_3, cockpit_device_id = devices.SPOTLIGHT_SYSTEM, value_down = 1, name = _('Light landing search On/Retraction/Off : NEXT'), category = _('Ins Landing Lights & Voice Warning Panel')},
{down = device_commands.Button_3, cockpit_device_id = devices.SPOTLIGHT_SYSTEM, value_down = -1, name = _('Light landing search On/Retraction/Off : PREV'), category = _('Ins Landing Lights & Voice Warning Panel')},

{down =  iCommandPlane_SpotSelect_switch  , name  = _('Lights landing search change Main/Reserved'), category = _('Ins Landing Lights & Voice Warning Panel')},

--{down = iCommandPlane_ADF_Homer_change, name = _('ADF Beacon select'), category = _('Ins Landing Lights & Voice Warning Panel')},
{down = device_commands.Button_8, cockpit_device_id = devices.ARK_22, value_down = 1, name = _('ADF Beacon select : NEXT'), category = _('Ins Landing Lights & Voice Warning Panel')},
{down = device_commands.Button_8, cockpit_device_id = devices.ARK_22, value_down = -1, name = _('ADF Beacon select : PREV'), category = _('Ins Landing Lights & Voice Warning Panel')},

{down =iCommand_VMS_ALMAZ_UP_EmergencyOn , name = _('Voice message emergency mode'), category = _('Ins Landing Lights & Voice Warning Panel')},
{down=iCommand_VMS_ALMAZ_UP_SpeechInfoOff , up=iCommand_VMS_ALMAZ_UP_SpeechInfoOff, name = _('Voice message cease'), category = _('Ins Landing Lights & Voice Warning Panel')},
{down=iCommand_VMS_ALMAZ_UP_Repeat , up=iCommand_VMS_ALMAZ_UP_Repeat, name = _('Voice message repeat'), category = _('Ins Landing Lights & Voice Warning Panel')},

-- Targeting Display Control Panel PUR (Панель управления режимами ПУР)
{down = iCommandPlaneScalesReject, name = _('HUD Scales Reject On/Off'), category = _('Ins Targeting Display Control Panel PUR')},
{pressed = iCommandPlane_I251_Brightness_Down, name = _('IT-23 brightness Down'), category = _('Ins Targeting Display Control Panel PUR')},
{pressed = iCommandPlane_I251_Brightness_Up, name = _('IT-23 brightness Up'), category = _('Ins Targeting Display Control Panel PUR')},
{pressed = iCommandPlane_I251_Contrast_Down, name = _('IT-23 contrast Down'), category = _('Ins Targeting Display Control Panel PUR')},
{pressed = iCommandPlane_I251_Contrast_Up, name = _('IT-23 contrast Up'), category = _('Ins Targeting Display Control Panel PUR')},
{pressed = iCommandPlane_Helmet_Brightess_Down, name = _('Helmet device brightness Down'), category = _('Ins Targeting Display Control Panel PUR')},
{pressed = iCommandPlane_Helmet_Brightess_Up, name = _('Helmet device brightness Up'), category = _('Ins Targeting Display Control Panel PUR')},
{down = iCommandPlane_LaserCode_Previous, name = _('Laser code selector left'), category = _('Ins Targeting Display Control Panel PUR')},
{down = iCommandPlane_LaserCode_Next, name = _('Laser code selector right'), category = _('Ins Targeting Display Control Panel PUR')},
{down = iCommandPlane_I251_Background_WhiteBlack, name = _('IT-23 Black-White indication switch'), category = _('Ins Targeting Display Control Panel PUR')},


-- Ins ADF (ARK-22)
{down = iCommandPlane_ADF_Channel_next, name = _('ADF Channel next'), category = _('Ins ADF')},
{down = iCommandPlane_ADF_Channel_prevous, name = _('ADF Channel prevous'), category = _('Ins ADF')},
{down = iCommandPlane_ADF_Mode_change, name = _('ADF Mode change'), category = _('Ins ADF')},
{down = iCommandPlane_ADF_Receiver_Mode_change, name = _('ADF Receiver mode change'), category = _('Ins ADF')},
{down = iCommandPlane_ADF_Volume_up, name = _('ADF Volume up'), category = _('Ins ADF')},
{down = iCommandPlane_ADF_Volume_down, name = _('ADF Volume down'), category = _('Ins ADF')},
{down = iCommandPlane_ADF_Test, up = iCommandPlane_ADF_Test_up, name = _('ADF Self test'), category = _('Ins ADF')},

--Ins Radio R-800 VHF-2
{down = iCommandPlane_R_800_1st_wheel_up, name = _('R-800 Rotary 1 Up'), category = _('Ins Radio R-800 VHF-2')},
{down = iCommandPlane_R_800_1st_wheel_down, name = _('R-800 Rotary 1 Down'), category = _('Ins Radio R-800 VHF-2')},
{down = iCommandPlane_R_800_2nd_wheel_up, name = _('R-800 Rotary 2 Up'), category = _('Ins Radio R-800 VHF-2')},
{down = iCommandPlane_R_800_2nd_wheel_down, name = _('R-800 Rotary 2 Down'), category = _('Ins Radio R-800 VHF-2')},
{down = iCommandPlane_R_800_3rd_wheel_up, name = _('R-800 Rotary 3 Up'), category = _('Ins Radio R-800 VHF-2')},
{down = iCommandPlane_R_800_3rd_wheel_down, name = _('R-800 Rotary 3 Down'), category = _('Ins Radio R-800 VHF-2')},
{down = iCommandPlane_R_800_4th_wheel_up, name = _('R-800 Rotary 4 Up'), category = _('Ins Radio R-800 VHF-2')},
{down = iCommandPlane_R_800_4th_wheel_down, name = _('R-800 Rotary 4 Down'), category = _('Ins Radio R-800 VHF-2')},
{down = iCommandPlane_R_800_Noise_Reductor_on_off, name = _('R-800 Squelch'), category = _('Ins Radio R-800 VHF-2')},
{down = iCommandPlane_R_800_Modulation_change, name = _('R-800 AM-FM Mode switch'), category = _('Ins Radio R-800 VHF-2')},
{down = iCommandPlane_R_800_50_100_switch, name = _('R-800 Data transfer rate switch'), category = _('Ins Radio R-800 VHF-2')},
{down = iCommandPlane_R_800_ADF_Sound_switch, name = _('R-800 ADF switch'), category = _('Ins Radio R-800 VHF-2')},
{down = iCommandPlane_R_800_Emergency_Radio, name = _('R-800 Emergency receiver'), category = _('Ins Radio R-800 VHF-2')},
{down = iCommandPlane_R_800_Test, up = iCommandPlane_R_800_Test_up, name = _('R-800 Test button'), category = _('Ins Radio R-800 VHF-2')},


--Ins Radio R-828 VHF-1
{down = iCommandPlane_R_828_Channel_next, name = _('R-828 Channel selector next'), category = _('Ins Radio R-828 VHF-1')},
{down = iCommandPlane_R_828_Channel_prevous, name = _('R-828 Channel selector previous'), category = _('Ins Radio R-828 VHF-1')},
{down = iCommandPlane_R_828_Noise_Reductor_on_off, name = _('R-828 Squelch'), category = _('Ins Radio R-828 VHF-1')},
{down = iCommandPlane_R_828_ASU, up = iCommandPlane_R_828_ASU_up, name = _('R-828 Tuner button'), category = _('Ins Radio R-828 VHF-1')},
{down = iCommandPlane_R_828_volume_up, name = _('R-828 Volume up'), category = _('Ins Radio R-828 VHF-1')},
{down = iCommandPlane_R_828_volume_down, name = _('R-828 Volume down'), category = _('Ins Radio R-828 VHF-1')},


-- Ins Autopilot
{down = iCommandHelicopter_PPR_button_K,up = iCommandHelicopter_PPR_button_K_up, name = _('Autopilot Bank hold'), category = _('Ins Autopilot')},
{down = iCommandHelicopter_PPR_button_T,up = iCommandHelicopter_PPR_button_T_up, name = _('Autopilot Pitch hold'), category = _('Ins Autopilot')},
{down = iCommandHelicopter_PPR_button_H,up = iCommandHelicopter_PPR_button_H_up, name = _('Autopilot Heading hold'), category = _('Ins Autopilot')},
{down = iCommandHelicopter_PPR_button_B,up = iCommandHelicopter_PPR_button_B_up, name = _('Autopilot Altitude hold'), category = _('Ins Autopilot')},
{down = iCommandHelicopter_PPR_button_DIR,up = iCommandHelicopter_PPR_button_DIR_up, name = _('Autopilot Director control'), category = _('Ins Autopilot')},

--{down = iCommandHelicopter_PPR_BAR_RV , name = _('Autopilot BARO/RALT altitude hold mode'), category = _('Ins Autopilot')},
{down = device_commands.Button_6, cockpit_device_id = devices.AUTOPILOT, value_down = 0, name = _('Autopilot BARO/RALT altitude hold mode : BARO'), category = _('Ins Autopilot')},
{down = device_commands.Button_6, cockpit_device_id = devices.AUTOPILOT, value_down = 1, name = _('Autopilot BARO/RALT altitude hold mode : RALT'), category = _('Ins Autopilot')},

--{down =iCommand_NAVINTERF_HeadingCourse , name = _('Autopilot Desired heading - Desired track'), category = _('Ins Autopilot')},
{down = device_commands.Button_3, cockpit_device_id = devices.NAV_INTERFACE, value_down = 0, name = _('Autopilot Desired heading - Desired track : DESIRED HDG'), category = _('Ins Autopilot')},
{down = device_commands.Button_3, cockpit_device_id = devices.NAV_INTERFACE, value_down = 1, name = _('Autopilot Desired heading - Desired track : DESIRED TRK'), category = _('Ins Autopilot')},

{down = device_commands.Button_3, up = device_commands.Button_3, cockpit_device_id = devices.NAV_INTERFACE, value_down = 0, value_up = 0.5, name = _('Autopilot Steering Mode 3-pos Switch : DESIRED HDG<>CENTER(OFF)'), category = {_('Special For Joystick'), _('Ins Autopilot')}},
{down = device_commands.Button_3, up = device_commands.Button_3, cockpit_device_id = devices.NAV_INTERFACE, value_down = 1, value_up = 0.5, name = _('Autopilot Steering Mode 3-pos Switch : DESIRED TRK<>CENTER(OFF)'), category = {_('Special For Joystick'), _('Ins Autopilot')}},

-- Ins Auxiliary Control Panel
{down = iCommand_CPT_MECH_VMG_HYDRO_EKRAN_Cover, name = _('Power plant, hydraulics, EKRAN self-test systems switch cover') , category = _('Ins Auxiliary Control Panel')},
{down = iCommand_CPT_MECH_VMG_HYDRO_EKRAN, name = _('Power plant, hydraulics, EKRAN self-test systems switch') , category = _('Ins Auxiliary Control Panel')},
{down = iCommand_LWS_BIT_On, up=iCommand_LWS_BIT_On , name = _('LWS L-140 self-test button') , category = _('Ins Auxiliary Control Panel')},
{down = iCommand_LWS_Power , name = _('LWS L-140 power switch') , category = _('Ins Auxiliary Control Panel')},
{down = iCommand_IlluminationInterf_Control_Panel_Illumination , name = _('Illumination control panel switch') , category = _('Ins Auxiliary Control Panel')},

{down = iCommand_UV26_PowerCover , name = _('CMD UV-26 power switch cover') , category = _('Ins Auxiliary Control Panel')},
{down = iCommand_UV26_Power , name = _('CMD UV-26 power switch') , category = _('Ins Auxiliary Control Panel')},
{down = iCommand_UV26_BITCover , name = _('CMD UV-26 BIT switch cover') , category = _('Ins Auxiliary Control Panel')},
{down = iCommand_UV26_BIT , name = _('CMD UV-26 BIT switch') , category = _('Ins Auxiliary Control Panel')},

{down = iCommand_C061K_power , name = _('INU power switch') , category = _('Ins Auxiliary Control Panel')},
{down = iCommand_C061K_heat , name = _('INU heater switch') , category = _('Ins Auxiliary Control Panel')},
{down = iCommandWeaponsBallisticSelectorRight , name = _('Rocket and gun pods ballistics data settings selector Right') , category = _('Ins Auxiliary Control Panel')},
{down = iCommandWeaponsBallisticSelectorLeft , name = _('Rocket and gun pods ballistics data settings selector Left') , category = _('Ins Auxiliary Control Panel')},


{down = iCommand_VMS_ALMAZ_UP_Check , up=iCommand_VMS_ALMAZ_UP_Check , name = _('ALMAZ Voice alert system test button') , category = _('Ins Auxiliary Control Panel')},

{down =iCommand_EjectInterface_Circuit_Test  , up=iCommand_EjectInterface_Circuit_Test , name = _('Eject system circuit test button') , category = _('Ins Auxiliary Control Panel')},
{down =iCommand_EjectInterface_Circuit_SelectRight, name = _('Eject system circuit check selector right') , category = _('Ins Auxiliary Control Panel')},
{down =iCommand_EjectInterface_Circuit_SelectLeft, name = _('Eject system circuit check selector left') , category = _('Ins Auxiliary Control Panel')},

{down =iCommand_ENG_INTERF_Right_Engine_RT_12_6  , up=iCommand_ENG_INTERF_Right_Engine_RT_12_6 , name = _('EGT right threshold governor button') , category = _('Ins Auxiliary Control Panel')},
{down =iCommand_ENG_INTERF_Left_Engine_RT_12_6  , up=iCommand_ENG_INTERF_Left_Engine_RT_12_6 , name = _('EGT left threshold governor button') , category = _('Ins Auxiliary Control Panel')},
{down =iCommand_ENG_INTERF_EngVibrDetectorBIT  , up=iCommand_ENG_INTERF_EngVibrDetectorBIT , name = _('Engine vibration monitor system button') , category = _('Ins Auxiliary Control Panel')},

{pressed = iCommand_IlluminationInterf_Cockpit_Night_Illumination_brightness_up	  , name = _('Lighting night vision cockpit brightness knob Down'), category = _('Ins Auxiliary Control Panel')},
{pressed = iCommand_IlluminationInterf_Cockpit_Night_Illumination_brightness_down , name = _('Lighting night vision cockpit brightness knob Up'), category = _('Ins Auxiliary Control Panel')},
{pressed = iCommand_IlluminationInterf_Panels_Illumination_brightness_up, name = _('Lighting cockpit panel brightness knob Down'), category = _('Ins Auxiliary Control Panel')},
{pressed = iCommand_IlluminationInterf_Panels_Illumination_brightness_down, name = _('Lighting cockpit panel brightness knob Up'), category = _('Ins Auxiliary Control Panel')},
{pressed = iCommand_IlluminationInterf_ADI_AHR_Illumination_brightness_up			, name = _('Lighting HSI and ADI brightness knob Down'), category = _('Ins Auxiliary Control Panel')},
{pressed = iCommand_IlluminationInterf_ADI_AHR_Illumination_brightness_down			, name = _('Lighting HSI and ADI brightness knob  Up'), category = _('Ins Auxiliary Control Panel')},

{pressed = iCommand_IlluminationInterf_Control_Panel_Illumination_brightness_up 			, name = _('Lighting auxiliary panel brightness knob Down'), category = _('Ins Auxiliary Control Panel')},
{pressed = iCommand_IlluminationInterf_Control_Panel_Illumination_brightness_down		, name = _('Lighting auxiliary panel brightness knob  Up'), category = _('Ins Auxiliary Control Panel')},



-- Systems
{down = iCommandPlaneFonar, name = _('Cockpit door open/close'), category = _('Systems')},
{down = iCommandPlaneEject, name = _('Eject (3 times)'), category = _('Systems')},
--{down = iCommandPlane_CallHelpWindow, name = _('Checklists') , category = _('Systems')},

--{down = iCommandPlane_SPU9_radio_change, name = _('SPU-9 Radio communicator selector'), category = _('Systems')},
{down = device_commands.Button_5, cockpit_device_id = devices.SPU_9, value_down = 1, name = _('SPU-9 Radio communicator selector : NEXT'), category = _('Systems')},
{down = device_commands.Button_5, cockpit_device_id = devices.SPU_9, value_down = -1, name = _('SPU-9 Radio communicator selector : PREV'), category = _('Systems')},
{down = device_commands.Button_2, cockpit_device_id = devices.SPU_9, value_down = 0, name = _('SPU-9 Radio communicator selector : CA(VHF-2)'), category = _('Systems')},
{down = device_commands.Button_2, cockpit_device_id = devices.SPU_9, value_down = 0.1, name = _('SPU-9 Radio communicator selector : VHF-1'), category = _('Systems')},
{down = device_commands.Button_2, cockpit_device_id = devices.SPU_9, value_down = 0.2, name = _('SPU-9 Radio communicator selector : SW'), category = _('Systems')},
{down = device_commands.Button_2, cockpit_device_id = devices.SPU_9, value_down = 0.3, name = _('SPU-9 Radio communicator selector : GND CREW'), category = _('Systems')},

-- Radio Communications
{down = iCommandToggleCommandMenu, name = _('Communication menu'), category = _('Radio Communications')},
{down = iCommandPlaneDoAndHome, name = _('Flight - Complete mission and RTB'), category = _('Radio Communications')},
{down = iCommandPlaneDoAndBack, name = _('Flight - Complete mission and rejoin'), category = _('Radio Communications')},
{down = iCommandPlaneFormation, name = _('Toggle formation'), category = _('Radio Communications')},
{down = iCommandPlaneJoinUp, name = _('Join up formation'), category = _('Radio Communications')},
{down = iCommandPlaneAttackMyTarget, name = _('Attack my target'), category = _('Radio Communications')},
{down = iCommandPlaneCoverMySix, name = _('Cover me'), category = _('Radio Communications')},
{down = iCommandPlane_EngageGroundTargets, name = _('Flight - Attack ground targets'), category = _('Radio Communications')},
{down = iCommandPlane_EngageAirDefenses, name = _('Flight - Attack air defenses'), category = _('Radio Communications')},
{down = ICommandSwitchDialog, name = _('Switch dialog'), category = _('Communications')},
{down = ICommandSwitchToCommonDialog, name = _('Switch to main menu'), category = _('Communications')},

-- External Cargo
-- {down = iCommandExtCargoHook, name = _('External Cargo Hook'), 	category = _("External Cargo")},
-- {down = iCommandExternalCargoAutounhook, name = _('External Cargo Autounhook'),	category = _("External Cargo")},
-- {down = iCommandExternalCargoIndicator, name = _("External Cargo Indicator"),  category = _("External Cargo"), },
-- {down = iCommandEmergencyCargoUnhook, name = _('External Cargo Emergency Unhook'), 	category = _("External Cargo")},
--- Kneeboard
{down = 3001, cockpit_device_id  = 100, value_down = 1.0, name = _('Kneeboard Next Page')  , category = _('Kneeboard')},
{down = 3002, cockpit_device_id  = 100, value_down = 1.0, name = _('Kneeboard Previous Page'), category = _('Kneeboard')},
{down = iCommandPlaneShowKneeboard,	name = _('Kneeboard ON/OFF'), category = _('Kneeboard')},
{down = iCommandPlaneShowKneeboard, up = iCommandPlaneShowKneeboard ,value_down = 1.0,value_up = -1.0, name = _('Kneeboard glance view')  , category = _('Kneeboard')},
{down = 3003	, cockpit_device_id  = 100,value_down = 1.0, name = _('Kneeboard current position mark point')  , category = _('Kneeboard')},

-- Flashlight
{down = 3256, cockpit_device_id = 0, value_down = 1.0, name = _('Flashlight'), category = _('View Cockpit')},
{down = 3255, cockpit_device_id = 0, value_down = 1.0, name = _('Flashlight Color - Toggle Green/White'), category = {_('View Cockpit')}},
{down = device_commands.Button_10, cockpit_device_id = devices.ILLUMINATION_INTERFACE, value_down =  0.1, name = _('Flashlight BRT Control - Increase'), category = {_('View Cockpit')}},
{down = device_commands.Button_10, cockpit_device_id = devices.ILLUMINATION_INTERFACE, value_down = -0.1, name = _('Flashlight BRT Control - Decrease'), category = {_('View Cockpit')}},

},


axisCommands = {

-- joystick axes 
{combos = defaultDeviceAssignmentFor("roll")	, action = iCommandPlaneRoll  , name = _('Flight Control Cyclic Roll')	},
{combos = defaultDeviceAssignmentFor("pitch")	, action = iCommandPlanePitch , name = _('Flight Control Cyclic Pitch')},
{combos = defaultDeviceAssignmentFor("rudder")	, action = iCommandPlaneRudder, name = _('Flight Control Rudder')		},
{combos = defaultDeviceAssignmentFor("thrust")	, action = iCommandPlaneCollective, name = _('Flight Control Collective')},

{action = iCommandPlaneThrustCommon, name = _('Throttle')},
{action = iCommandPlaneThrustLeft, name = _('Left Throttle')},
{action = iCommandPlaneThrustRight, name = _('Right Throttle')},
{action = iCommandWheelBrake, name = _('Wheel Brake')},


{action = iCommandPlaneSelecterHorizontalAbs, name = _('Absolute SHKVAL Horizontal Slew')},
{action = iCommandPlaneSelecterVerticalAbs   , name = _('Absolute SHKVAL Vertical Slew')},

--{combos = {{key = 'JOY_X', reformers = {'JOY_BTN6'}}},  action = iCommandPlaneSelecterHorizontalAbs, name = _('Absolute SHKVAL Horizontal Slew')},
--{combos = {{key = 'JOY_Y', reformers = {'JOY_BTN6'}}}, action = iCommandPlaneSelecterVerticalAbs   , name = _('Absolute SHKVAL Vertical Slew')},


-- mouse axes
--{action = iCommandPlaneViewHorizontal, name = _('Camera Horizontal View')},
--{action = iCommandPlaneViewVertical, name = _('Camera Vertical View')},
--{action = iCommandPlaneZoomView, name = _('Camera Zoom View')},
--{action = iCommandViewHorTrans	  , name = _('Camera View Horizontal Shift')},
--{action = iCommandViewVertTrans	  , name = _('Camera View Vertical Shift')},
--{action = iCommandViewLongitudeTrans, name = _('Camera View Longitude Shift')},
                          
--{keys = {'MOUSE_Z'}}, action = iCommandPlaneZoomView, name = _('Zoom View')},

-- TrackIR axes
{action = iCommandViewVerticalAbs, name = _('Absolute Camera Vertical View')},
{action = iCommandViewHorizontalAbs, name = _('Absolute Camera Horizontal View')},
{action = iCommandViewHorTransAbs, name = _('Absolute Horizontal Shift Camera View')},
{action = iCommandViewVertTransAbs, name = _('Absolute Vertical Shift Camera View')},
{action = iCommandViewLongitudeTransAbs, name = _('Absolute Longitude Shift Camera View')},
{action = iCommandViewRollAbs, name = _('Absolute Roll Shift Camera View')},
{action = iCommandViewZoomAbs, name = _('Zoom View')},

-- Flashlight
{action = device_commands.Button_11, cockpit_device_id = devices.ILLUMINATION_INTERFACE, name = _('Flashlight BRT Control'), category = {_('View Cockpit')}},

--{action = iCommandHelicopterLeftEngineBrake_ByAxis, name = _('Cut-off valve left engine axis'), category = _('Ins Engines start-up control panel and levers')},
--{action = iCommandHelicopterRightEngineBrake_ByAxis, name = _('Cut-off valve right engine axis'), category = _('Ins Engines start-up control panel and levers')},
{action = device_commands.Button_28, cockpit_device_id = devices.ENGINE_INTERFACE, name = _('Cut-off valve left engine axis'), category = _('Ins Engines start-up control panel and levers')},
{action = device_commands.Button_29, cockpit_device_id = devices.ENGINE_INTERFACE, name = _('Cut-off valve right engine axis'), category = _('Ins Engines start-up control panel and levers')},
{action = device_commands.Button_30, cockpit_device_id = devices.ENGINE_INTERFACE, name = _('Rotor brake axis'), category = _('Ins Engines start-up control panel and levers')},

{action = device_commands.Button_17, cockpit_device_id = devices.CPT_MECH, name = _('Gear lever axis'), category = _('Ins Forward panel and gauges')},

},
}
