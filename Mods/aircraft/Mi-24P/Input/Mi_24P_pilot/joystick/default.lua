local cockpit = folder.."../../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

--modifiers = {
--['JOY_BTN6'] = 'JOY_BTN6',
--},



local res = external_profile("Config/Input/Aircrafts/common_joystick_binding.lua")



join(res.forceFeedback, {
trimmer = 1.0,
shake = 0.5,
swapAxes = false,
})



join(res.keyCommands, {
-- Cheat - Temporary
--{pressed = iCommandViewExplosion, name = 'Explosion', category = 'Cheat'},
{down = iCommandEnginesStart, name = _('Auto Start'),	category = _('Cheat')},
{down = iCommandEnginesStop, name = _('Auto Stop'),		category = _('Cheat')},

-- General
{down = iCommandScoresWindowToggle, name = _('Score window'), category = _('General')},
{down = iCommandFriendlyChat, name = _('Multiplayer chat - mode Allies'), category = _('General')},
{down = iCommandInfoOnOff, name = _('Info bar toggle'), category = _('General')},
{down = iCommandRecoverHuman, name = _('Get New Plane - respawn'), category = _('General')},
{down = iCommandCockpitClickModeOnOff, name = _('Clickable mouse cockpit mode On/Off'), category = _('General')},
{down = iCommandScreenShot, name = _('Screenshot'), category = _('General')},
{down = iCommandViewCoordinatesInLinearUnits, name = _('Info bar coordinate units toggle'), category = _('General')},
{down = iCommandCockpitShowPilotOnOff, name = _('Show Pilot Body'), category = _('General')},
{down = iCommandPlane_ShowControls, name = _('Show controls indicator') , category = _('General')},


-- View                                                    
{combos = {{key = 'JOY_BTN_POV1_L'}}, pressed = iCommandViewLeftSlow, up = iCommandViewStopSlow, name = 'View Left slow', category = 'View'},
{combos = {{key = 'JOY_BTN_POV1_R'}}, pressed = iCommandViewRightSlow, up = iCommandViewStopSlow, name = 'View Right slow', category = 'View'},
{combos = {{key = 'JOY_BTN_POV1_U'}}, pressed = iCommandViewUpSlow, up = iCommandViewStopSlow, name = 'View Up slow', category = 'View'},
{combos = {{key = 'JOY_BTN_POV1_D'}}, pressed = iCommandViewDownSlow, up = iCommandViewStopSlow, name = 'View Down slow', category = 'View'},
{combos = {{key = 'JOY_BTN_POV1_UR'}}, pressed = iCommandViewUpRightSlow, up = iCommandViewStopSlow, name = 'View Up Right slow', category = 'View'},
{combos = {{key = 'JOY_BTN_POV1_DR'}}, pressed = iCommandViewDownRightSlow, up = iCommandViewStopSlow, name = 'View Down Right slow', category = 'View'},
{combos = {{key = 'JOY_BTN_POV1_DL'}}, pressed = iCommandViewDownLeftSlow, up = iCommandViewStopSlow, name = 'View Down Left slow', category = 'View'},
{combos = {{key = 'JOY_BTN_POV1_UL'}}, pressed = iCommandViewUpLeftSlow, up = iCommandViewStopSlow, name = 'View Up Left slow', category = 'View'},
{combos = {{key = 'JOY_BTN5'}}, pressed = iCommandViewCenter, name = 'Center View', category = 'View'},


{pressed = iCommandViewForwardSlow, up = iCommandViewForwardSlowStop, name = 'Zoom in slow', category = 'View'},
{pressed = iCommandViewBackSlow, up = iCommandViewBackSlowStop, name = 'Zoom out slow', category = 'View'},
{down = iCommandViewAngleDefault, name = 'Zoom normal', category = 'View'},
{pressed = iCommandViewExternalZoomIn, up = iCommandViewExternalZoomInStop, name = 'Zoom external in', category = 'View'},
{pressed = iCommandViewExternalZoomOut, up = iCommandViewExternalZoomOutStop, name = 'Zoom external out', category = 'View'},
{down = iCommandViewExternalZoomDefault, name = 'Zoom external normal', category = 'View'},
{down = iCommandViewSpeedUp, name = 'F11 camera moving forward', category = 'View'},
{down = iCommandViewSlowDown, name = 'F11 camera moving backward', category = 'View'},
{down = iCommandViewSwitchForward, name = 'Objects switching direction forward ', category = 'View'},
{down = iCommandViewSwitchReverse, name = 'Objects switching direction reverse ', category = 'View'},
{down = iCommandViewObjectIgnore, name = 'Object exclude ', category = 'View'},
{down = iCommandViewObjectsAll, name = 'Objects all excluded - include', category = 'View'},


{down = iCommandViewCockpit, name = 'F1 Cockpit view', category = 'View'},
{down = iCommandNaturalViewCockpitIn, name = 'F1 Natural head movement view', category = 'View'},
{down = iCommandViewHUDOnlyOnOff, name = 'F1 HUD only view switch', category = 'View'},
{down = iCommandViewAir, name = 'F2 Aircraft view', category = 'View'},
{down = iCommandViewMe, name = 'F2 View own aircraft', category = 'View'},
{down = iCommandViewFromTo, name = 'F2 Toggle camera position', category = 'View'},
{down = iCommandViewLocal, name = 'F2 Toggle local camera control', category = 'View'},
{down = iCommandViewTower, name = 'F3 Fly-By view', category = 'View'},
{down = iCommandViewTowerJump, name = 'F3 Fly-By jump view', category = 'View'},
{down = iCommandViewRear, name = 'F4 Camera mounted on airframe', category = 'View'},
{down = iCommandViewChase, name = 'F4 Chase view', category = 'View'},
{down = iCommandViewChaseArcade, name = 'F4 Arcade Chase view', category = 'View'},
{down = iCommandViewFight, name = 'F5 nearest AC view', category = 'View'},
{down = iCommandViewFightGround, name = 'F5 Ground hostile view', category = 'View'},
{down = iCommandViewWeapons, name = 'F6 Released weapon view', category = 'View'},
{down = iCommandViewWeaponAndTarget, name = 'F6 Weapon to target view', category = 'View'},
{down = iCommandViewGround, name = 'F7 Ground unit view', category = 'View'},
{down = iCommandViewNavy, name = 'F9 Ship view', category = 'View'},
{down = iCommandViewLndgOfficer, name = 'F9 Landing signal officer view', category = 'View'},
{down = iCommandViewAWACS, name = 'F10 Theater map view', category = 'View'},
{down = iCommandViewAWACSJump, name = 'F10 Jump to theater map view over current point', category = 'View'},
{down = iCommandViewFree, name = 'F11 Airport free camera', category = 'View'},
{down = iCommandViewFreeJump, name = 'F11 Jump to free camera', category = 'View'},
{down = iCommandViewStatic, name = 'F12 Static object view', category = 'View'},
{down = iCommandViewMirage, name = 'F12 Civil traffic view', category = 'View'},
{down = iCommandViewLocomotivesToggle, name = 'F12 Trains/cars toggle', category = 'View'},

-- View Cockpit
{down = iCommandViewTempCockpitOn, up = iCommandViewTempCockpitOff, name = 'Cockpit panel view in', category = 'View Cockpit'},
{down = iCommandViewTempCockpitToggle, name = 'Cockpit panel view toggle', category = 'View Cockpit'},
--// Save current cockpit camera angles for fast numpad jumps  
{down = iCommandViewSaveAngles, name = 'Save Cockpit Angles', category = 'View Cockpit'},
{pressed = iCommandViewUp, up = iCommandViewStop, name = 'View up', category = 'View Cockpit'},
{pressed = iCommandViewDown, up = iCommandViewStop, name = 'View down', category = 'View Cockpit'},
{pressed = iCommandViewLeft, up = iCommandViewStop, name = 'View left', category = 'View Cockpit'},
{pressed = iCommandViewRight, up = iCommandViewStop, name = 'View right', category = 'View Cockpit'},
{pressed = iCommandViewUpRight, up = iCommandViewStop, name = 'View up right', category = 'View Cockpit'},
{pressed = iCommandViewDownRight, up = iCommandViewStop, name = 'View down right', category = 'View Cockpit'},
{pressed = iCommandViewDownLeft, up = iCommandViewStop, name = 'View down left', category = 'View Cockpit'},
{pressed = iCommandViewUpLeft, up = iCommandViewStop, name = 'View up left', category = 'View Cockpit'},

{down = iCommandViewFastKeyboard, name = 'Fast cockpit keyboard', category = 'View Cockpit'},
{down = iCommandViewSlowKeyboard, name = 'Slow cockpit keyboard', category = 'View Cockpit'},
{down = iCommandViewNormalKeyboard, name = 'Normal cockpit keyboard speed', category = 'View Cockpit'},
{down =  iCommandViewFastMouse, name = 'Fast cockpit mouse', category = 'View Cockpit'},
{down = iCommandViewSlowMouse, name = 'Slow cockpit mouse', category = 'View Cockpit'},
{down = iCommandViewNormalMouse, name = 'Normal cockpit mouse speed', category = 'View Cockpit'},

{down = iCommandViewCameraUp, up = iCommandViewCameraCenter, name = _('Camera view up'), category = _('View Cockpit')},
{down = iCommandViewCameraDown, up = iCommandViewCameraCenter, name = 'Camera view down', category = 'View Cockpit'},
{down = iCommandViewCameraLeft, up = iCommandViewCameraCenter, name = 'Camera view left', category = 'View Cockpit'},
{down = iCommandViewCameraRight, up = iCommandViewCameraCenter, name = 'Camera view right', category = 'View Cockpit'},
{down = iCommandViewCameraUpLeft, up = iCommandViewCameraCenter, name = 'Camera view up-left', category = 'View Cockpit'},
{down = iCommandViewCameraDownLeft, up = iCommandViewCameraCenter, name = 'Camera view down-left', category = 'View Cockpit'},
{down = iCommandViewCameraUpRight, up = iCommandViewCameraCenter, name = 'Camera view up-right', category = 'View Cockpit'},
{down = iCommandViewCameraDownRight, up = iCommandViewCameraCenter, name = 'Camera view down-right', category = 'View Cockpit'},
--{down = iCommandViewPanToggle, name = 'Camera pan mode toggle', category = 'View Cockpit'},

{down = iCommandViewCameraUpSlow, name = 'Camera view up slow', category = 'View Cockpit'},
{down = iCommandViewCameraDownSlow, name = 'Camera view down slow', category = 'View Cockpit'},
{down = iCommandViewCameraLeftSlow, name = 'Camera view left slow', category = 'View Cockpit'},
{down = iCommandViewCameraRightSlow, name = 'Camera view right slow', category = 'View Cockpit'},
{down = iCommandViewCameraUpLeftSlow, name = 'Camera view up-left slow', category = 'View Cockpit'},
{down = iCommandViewCameraDownLeftSlow, name = 'Camera view down-left slow', category = 'View Cockpit'},
{down = iCommandViewCameraDownRightSlow, name = 'Camera view down-right slow', category = 'View Cockpit'},
{down = iCommandViewCameraUpRightSlow, name = 'Camera view down-right slow', category = 'View Cockpit'},
{down = iCommandViewCameraCenter, name = 'Center camera view', category = 'View Cockpit'},
{down = iCommandViewCameraReturn, name = 'Return camera', category = 'View Cockpit'},
{down = iCommandViewCameraBaseReturn, name = 'Return camera base', category = 'View Cockpit'},

{down = iCommandViewSnapView0, up = iCommandViewSnapViewStop, name = 'Snap View 0', category = 'View Cockpit'},
{down = iCommandViewSnapView1, up = iCommandViewSnapViewStop, name = 'Snap View 1', category = 'View Cockpit'},
{down = iCommandViewSnapView2, up = iCommandViewSnapViewStop, name = 'Snap View 2', category = 'View Cockpit'},
{down = iCommandViewSnapView3, up = iCommandViewSnapViewStop, name = 'Snap View 3', category = 'View Cockpit'},
{down = iCommandViewSnapView4, up = iCommandViewSnapViewStop, name = 'Snap View 4', category = 'View Cockpit'},
{down = iCommandViewSnapView5, up = iCommandViewSnapViewStop, name = 'Snap View 5', category = 'View Cockpit'},
{down = iCommandViewSnapView6, up = iCommandViewSnapViewStop, name = 'Snap View 6', category = 'View Cockpit'},
{down = iCommandViewSnapView7, up = iCommandViewSnapViewStop, name = 'Snap View 7', category = 'View Cockpit'},
{down = iCommandViewSnapView8, up = iCommandViewSnapViewStop, name = 'Snap View 8', category = 'View Cockpit'},
{down = iCommandViewSnapView9, up = iCommandViewSnapViewStop, name = 'Snap View 9', category = 'View Cockpit'},

{down = iCommandViewPitHeadOnOff, name = 'Head shift movement on / off', category = 'View Cockpit'},

{pressed = iCommandViewForward, up = iCommandViewForwardStop, name = 'Zoom in', category = 'View Cockpit'},
{pressed = iCommandViewBack, up = iCommandViewBackStop, name = 'Zoom out', category = 'View Cockpit'},

-- Cockpit Camera Motion (Передвижение камеры в кабине)
{pressed = iCommandViewPitCameraMoveUp, up = iCommandViewPitCameraMoveStop, name = 'Cockpit Camera Move Up', category = 'View Cockpit'},
{pressed = iCommandViewPitCameraMoveDown, up = iCommandViewPitCameraMoveStop, name = 'Cockpit Camera Move Down', category = 'View Cockpit'},
{pressed = iCommandViewPitCameraMoveLeft, up = iCommandViewPitCameraMoveStop, name = 'Cockpit Camera Move Left', category = 'View Cockpit'},
{pressed = iCommandViewPitCameraMoveRight, up = iCommandViewPitCameraMoveStop, name = 'Cockpit Camera Move Right', category = 'View Cockpit'},
{pressed = iCommandViewPitCameraMoveForward, up = iCommandViewPitCameraMoveStop, name = 'Cockpit Camera Move Forward', category = 'View Cockpit'},
{pressed = iCommandViewPitCameraMoveBack, up = iCommandViewPitCameraMoveStop, name = 'Cockpit Camera Move Back', category = 'View Cockpit'},
{down = iCommandViewPitCameraMoveCenter, name = 'Cockpit Camera Move Center', category = 'View Cockpit'},

-- View Extended

{down = iCommandViewCameraJiggle, name = 'Camera jiggle toggle', category = 'View Extended'},
{down = iCommandViewKeepTerrain, name = 'Keep terrain camera altitude', category = 'View Extended'},
{down = iCommandViewPlus, name = 'Toggle tracking fire weapon', category = 'View Extended'},
{down = iCommandViewFriends, name = 'View friends mode', category = 'View Extended'},
{down = iCommandViewEnemies, name = 'View enemies mode', category = 'View Extended'},
{down = iCommandViewAll, name = 'View all mode', category = 'View Extended'},

-- View Padlock
{down = iCommandViewLock, name = 'Lock view (cycle padlock)', category = 'View Padlock'},
{down = iCommandViewUnlock, name = 'Unlock view (stop padlock)', category = 'View Padlock'},
{down = iCommandAllMissilePadlock, name = 'All missiles padlock', category = 'View Padlock'},
{down = iCommandThreatMissilePadlock, name = 'Threat missile padlock', category = 'View Padlock'},
{down = iCommandViewTerrainLock, name = 'Lock terrain view', category = 'View Padlock'},

------------------------------------------------
-- Night Vision Goggles ------------------------
------------------------------------------------
{down = iCommandViewNightVisionGogglesOn,		name = _('Night Vision Goggles'),			category = {_('Sensors')}},
{pressed = iCommandPlane_Helmet_Brightess_Up,	name = _('Night Vision Goggles Gain Up'),	category = {_('Sensors')}},
{pressed = iCommandPlane_Helmet_Brightess_Down,	name = _('Night Vision Goggles Gain Down'),	category = {_('Sensors')}},


-- Labels
{down = iCommandMarkerState, name = 'All Labels', category = 'Labels'},
{down = iCommandMarkerStatePlane, name = 'Aircraft Labels', category = 'Labels'},
{down = iCommandMarkerStateRocket, name = 'Missile Labels', category = 'Labels'},
{down = iCommandMarkerStateShip, name = 'Vehicle & Ship Labels', category = 'Labels'},
   
{down = iCommandPlanePickleOn,    up = iCommandPlanePickleOff, name = _('Release weapons'), category = {_('Ins Cyclic Stick')}},
{down = weapon_commands.Pilot_RUV_FIRE_Cvr_Ext,  					cockpit_device_id = devices.WEAP_SYS, value_down = 1, 	name = _('Weapon Release Button Cover'),				category = {_('Ins Cyclic Stick')}},

{down = SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_EXT,	up = SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_EXT, cockpit_device_id = devices.SPU_8, value_down = 1.0, value_up = 0.0,		name = _('Radio trigger - RADIO (call radio menu)'),			category = {_('Ins Cyclic Stick'), _('Communications')}},
{down = SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_EXT,	up = SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_EXT, cockpit_device_id = devices.SPU_8, value_down = 0.5, value_up = 0.0,		name = _('Radio trigger - ICS (call radio menu)'),			category = {_('Ins Cyclic Stick'), _('Communications')}},
-- VoIP radio global command
-- in case you need to open commands in the cockpit
{down = iCommandVoIPRadioPushToTalkEnableDisableVoice,	up = iCommandVoIPRadioPushToTalkEnableDisableVoice, value_down = 1.0, value_up = 0.0,	name = _('Radio trigger - RADIO (VOIP)'), category = {_('Ins Cyclic Stick'), _('Communications')}},
{down = iCommandVoIPIntercomPushToTalkEnableDisableVoice,	up = iCommandVoIPIntercomPushToTalkEnableDisableVoice, value_down = 0.5, value_up = 0.0,	name = _('Radio trigger - ICS (VOIP)'), category = {_('Ins Cyclic Stick'), _('Communications')}},


{down = iCommandPlaneCollectiveIncrease, pressed = iCommandPlaneCollectiveIncrease, up = iCommandPlaneCollectiveStop,					name = _('Collective - Up'),									category = {_('Ins Collective Stick'), _('Flight Control')}},
{down = iCommandPlaneCollectiveDecrease, pressed = iCommandPlaneCollectiveDecrease, up = iCommandPlaneCollectiveStop,					name = _('Collective - Down'),									category = {_('Ins Collective Stick'), _('Flight Control')}},
{down = iCommandPlane_ReadjustFreeTurbineRPM_Up,		up = iCommandPlane_ReadjustFreeTurbineRPM_Up,	value_down =  1, value_up = 0,	name = _('Readjust Free Turbine RPM Switch - Increase'),		category = {_('Ins Collective Stick'), _('Engines')}},
{down = iCommandPlane_ReadjustFreeTurbineRPM_Down,		up = iCommandPlane_ReadjustFreeTurbineRPM_Down,	value_down = -1, value_up = 0,	name = _('Readjust Free Turbine RPM Switch - Decrease'),		category = {_('Ins Collective Stick'), _('Engines')}},
{down = iCommandHelicopter_CollectiveStopper_Up,		up = iCommandHelicopter_CollectiveStopper_Down,									name = _('Collective brake - Assign altitude lever'),			category = {_('Ins Collective Stick'), _('Flight Control')}},
{down = iCommandThrottleIncrease,	up = iCommandThrottleStop,																			name = _('Correction Lever - Increase'),						category = {_('Ins Collective Stick'), _('Engines')}},
{down = iCommandThrottleDecrease,	up = iCommandThrottleStop,																			name = _('Correction Lever - Decrease'),						category = {_('Ins Collective Stick'), _('Engines')}},

{down = iCommandPlaneTrimOn, up = iCommandPlaneTrimOff,																							name = _('Trimmer Button'),					category = {_('Ins Cyclic Stick'), _('Trimmer')}},
{down = iCommandPlaneTrimCancel,																													name = _('Trimmer - Reset'),				category = {_('Ins Cyclic Stick'), _('Trimmer')}},

{pressed = iCommandPlaneTrimUp,				up = iCommandPlaneTrimStop,	name = _('Trim: Nose Up'),			category = {_('Ins Cyclic Stick'), _('Trimmer')}},
{pressed = iCommandPlaneTrimDown,			up = iCommandPlaneTrimStop,	name = _('Trim: Nose Down'),		category = {_('Ins Cyclic Stick'), _('Trimmer')}},
{pressed = iCommandPlaneTrimLeft,			up = iCommandPlaneTrimStop,	name = _('Trim: Left Wing Down'),	category = {_('Ins Cyclic Stick'), _('Trimmer')}},
{pressed = iCommandPlaneTrimRight,			up = iCommandPlaneTrimStop,	name = _('Trim: Right Wing Down'),	category = {_('Ins Cyclic Stick'), _('Trimmer')}},
--{pressed = iCommandPlaneTrimLeftRudder,		up = iCommandPlaneTrimStop,	name = _('Trim: Rudder Left'),		category = {_('Ins Cyclic Stick'), _('Trimmer')}},
--{pressed = iCommandPlaneTrimRightRudder,	up = iCommandPlaneTrimStop,	name = _('Trim: Rudder Right'),		category = {_('Ins Cyclic Stick'), _('Trimmer')}},


{down = iCommandPlaneWheelBrakeOn,	up = iCommandPlaneWheelBrakeOff,																			name = _('Wheel Brake'),					category = {_('Ins Cyclic Stick')}},
{down = iCommandPlaneWheelParkingBrake,																											name = _('Wheel Parking Brake'),			category = {_('Ins Cyclic Stick')}},
{down = cockpit_mechanics_commands.Command_CPT_MECH_ParkingBrake_EXT,	cockpit_device_id = devices.CPT_MECH,	value_down =  0.0,				name = _('Wheel Parking Brake - OFF'),		category = {_('Ins Cyclic Stick')}},
{down = cockpit_mechanics_commands.Command_CPT_MECH_ParkingBrake_EXT,	cockpit_device_id = devices.CPT_MECH,	value_down =  1.0,				name = _('Wheel Parking Brake - ON'),		category = {_('Ins Cyclic Stick')}},

{down = iCommandPlaneLeftRudderStart,	up = iCommandPlaneLeftRudderStop,	name = _('Rudder Left'),	category = {_('Ins Rudder'), _('Flight Control')}},
{down = iCommandPlaneRightRudderStart,	up = iCommandPlaneRightRudderStop,	name = _('Rudder Right'),	category = {_('Ins Rudder'), _('Flight Control')}},

-- Cheat ---------------------------------------

{down = iCommandEnginesStart,	name = _('Auto Start'),		category = _('Cheat')},
{down = iCommandEnginesStop,		name = _('Auto Stop'),		category = _('Cheat')},

-- View Cockpit 

{down = iCommandViewCockpitChangeSeat,	value_down = 1, name = _('Set Pilot Seat'),		category = _('View Cockpit')},
{down = iCommandViewCockpitChangeSeat,	value_down = 2, name = _('Set Operator Seat'),	category = _('View Cockpit')},
{down = iCommandViewCockpitChangeSeat,	value_down = 3, name = _('Set Gunner Seat'),	category = _('View Cockpit')},
{down = headwrapper_commands.TrackIR_OnOff, cockpit_device_id = devices.HEAD_WRAPPER, value_down = 0.0,	name = _('TrackIR Aiming On/Off'),		category = _('View Cockpit')},

-- General

{down = iCommandCockpitShowPilotOnOff, name = _('Show Pilot Body'), category = _('General')},
{down = iCommandSoundMicOn, name = _('Sound recording start'), category = _('General')},
{down = iCommandSoundMicOff, name = _('Sound recording stop'), category = _('General')},
{down = iCommandTrackEditReplace, name = _('Track edit replace mode'), category = _('General')},
{down = iCommandTrackEditInsert, name = _('Track edit insert mode'), category = _('General')},
{down = iCommandRecordSubtitleOn, name = _('Subtitle recording begin'), category = _('General')},
{down = iCommandRecordSubtitleOff, name = _('Subtitle recording end'), category = _('General')},

-- Cockpit elements hide/show:
{down = cockpit_mechanics_commands.Command_CPT_MECH_Elements_Hide,		cockpit_device_id = devices.CPT_MECH,	value_down =  1.0,	name = _('Cockpit elements - HIDE'),			category = {_('Cheat')}},
{down = cockpit_mechanics_commands.Command_CPT_MECH_Elements_Hide,		cockpit_device_id = devices.CPT_MECH,	value_down =  0.0,	name = _('Cockpit elements - SHOW'),			category = {_('Cheat')}},
{down = cockpit_mechanics_commands.Command_CPT_MECH_Elements_Hide_EXT,	cockpit_device_id = devices.CPT_MECH,	value_down =  1.0,	name = _('Cockpit elements - HIDE/SHOW'),		category = {_('Cheat')}},

-- Engines Levers ------------------------------
------------------------------------------------
{cockpit_device_id = devices.ENGINE_INTERFACE, down = engine_commands.END_THROTTLES_ITER, value_down = 1.0,				name = _('Throttle Up'),									category = _('Engines')},
{cockpit_device_id = devices.ENGINE_INTERFACE, down = engine_commands.END_THROTTLES_ITER, value_down = -1.0,				name = _('Throttle Down'),									category = _('Engines')},
{cockpit_device_id = devices.ENGINE_INTERFACE, down = engine_commands.CONTROL_LEFT_THROTTLE_ITER, value_down = 1.0,		name = _('Left Throttle up (Idle-Medium-Auto-Full)'),		category = _('Engines')},
{cockpit_device_id = devices.ENGINE_INTERFACE, down = engine_commands.CONTROL_LEFT_THROTTLE_ITER, value_down = -1.0,		name = _('Left Throttle down (Idle-Medium-Auto-Full)'),		category = _('Engines')},
{cockpit_device_id = devices.ENGINE_INTERFACE, down = engine_commands.CONTROL_RIGHT_THROTTLE_ITER, value_down = 1.0,		name = _('Right Throttle up (Idle-Medium-Auto-Full)'),		category = _('Engines')},
{cockpit_device_id = devices.ENGINE_INTERFACE, down = engine_commands.CONTROL_RIGHT_THROTTLE_ITER, value_down = -1.0,	name = _('Right Throttle down (Idle-Medium-Auto-Full)'),	category = _('Engines')},
{down = iCommandHelicopter_Left_Engine_Lock,																				name = _('Cut-off valve left engine'),						category = _('Engines')},
{down = iCommandHelicopter_Right_Engine_Lock,																			name = _('Cut-off valve right engine'),						category = _('Engines')},
{down = iCommandHelicopter_Rotor_Lock,																					name = _('Rotor Brake Handle - UP/DOWN'),					category = _('Engines')},
{down = engine_commands.LEVER_Rotor_Lock, cockpit_device_id = devices.ENGINE_INTERFACE,	value_down = 1.0,				name = _('Rotor Brake Handle - UP'),						category = _('Engines')},
{down = engine_commands.LEVER_Rotor_Lock, cockpit_device_id = devices.ENGINE_INTERFACE,	value_down = 0.0,				name = _('Rotor Brake Handle - DOWN'),						category = _('Engines')},

{down = iCommandHelicopter_Selected_Engine_start,			up = iCommandHelicopter_Selected_Engine_start_up,										name = _('Start-up Engine Button'),						category = {_('Left Side Panel'), _('Engines')}},
{down = iCommandHelicopter_Selected_Engine_interrupt_start,	up = iCommandHelicopter_Selected_Engine_interrupt_start_up,								name = _('Interrupt Start-up Sequence Button'),			category = {_('Left Side Panel'), _('Engines')}},
{down = iCommandPlane_APU_Start,								up = iCommandPlane_APU_Off,															name = _('Start APU Button'),							category = {_('Left Side Panel'), _('Engines')}},
{down = iCommandHelicopter_APU_stop,							up = iCommandHelicopter_APU_stop_up,												name = _('Stop APU Button'),							category = {_('Left Side Panel'), _('Engines')}},
{down = engine_commands.STARTUP_Engine_Select,	cockpit_device_id = devices.ENGINE_INTERFACE,	value_down = 1,										name = _('Engine Selector Switch - LEFT'),				category = {_('Left Side Panel'), _('Engines')}},
{down = engine_commands.STARTUP_Engine_Select,	cockpit_device_id = devices.ENGINE_INTERFACE,	value_down = -1,									name = _('Engine Selector Switch - RIGHT'),				category = {_('Left Side Panel'), _('Engines')}},
{down = iCommandEngineLaunchMethod,													value_down = 1,													name = _('Engine Start Mode Switch - Up'),				category = {_('Left Side Panel'), _('Engines')}},
{down = iCommandEngineLaunchMethod,													value_down = -1,												name = _('Engine Start Mode Switch - Down'),			category = {_('Left Side Panel'), _('Engines')}},
{down = engine_commands.STARTUP_Engine_Launch_Method,	cockpit_device_id = devices.ENGINE_INTERFACE,	value_down = -1,							name = _('Engine Start Mode Switch - COLD CRANKING'),	category = {_('Left Side Panel'), _('Engines')}},
{down = engine_commands.STARTUP_Engine_Launch_Method,	cockpit_device_id = devices.ENGINE_INTERFACE,	value_down = 0,								name = _('Engine Start Mode Switch - OFF'),				category = {_('Left Side Panel'), _('Engines')}},
{down = engine_commands.STARTUP_Engine_Launch_Method,	cockpit_device_id = devices.ENGINE_INTERFACE,	value_down = 1,								name = _('Engine Start Mode Switch - START'),			category = {_('Left Side Panel'), _('Engines')}},
{down = engine_commands.STARTUP_APU_Launch_Method_EXT,	cockpit_device_id = devices.ENGINE_INTERFACE,	value_down = 1,								name = _('APU Start Mode Switch - Up'),					category = {_('Left Side Panel'), _('Engines')}},
{down = engine_commands.STARTUP_APU_Launch_Method_EXT,	cockpit_device_id = devices.ENGINE_INTERFACE,	value_down = -1,							name = _('APU Start Mode Switch - Down'),				category = {_('Left Side Panel'), _('Engines')}},
{down = engine_commands.STARTUP_APU_Launch_Method,		cockpit_device_id = devices.ENGINE_INTERFACE,	value_down = 1,								name = _('APU Start Mode Switch - FALSE START'),		category = {_('Left Side Panel'), _('Engines')}},
{down = engine_commands.STARTUP_APU_Launch_Method,		cockpit_device_id = devices.ENGINE_INTERFACE,	value_down = 0,								name = _('APU Start Mode Switch - COLD CRANKING'),		category = {_('Left Side Panel'), _('Engines')}},
{down = engine_commands.STARTUP_APU_Launch_Method,		cockpit_device_id = devices.ENGINE_INTERFACE,	value_down = -1,							name = _('APU Start Mode Switch - START'),				category = {_('Left Side Panel'), _('Engines')}},
{down = engine_commands.ANTIDUST_On_COVER_ITER,			cockpit_device_id = devices.ENGINE_INTERFACE,	value_down = 1,								name = _('Antidust ON Cover - UP/DOWN'),				category = {_('Left Side Panel'), _('Engines')}},
{down = engine_commands.ANTIDUST_On,					cockpit_device_id = devices.ENGINE_INTERFACE,	value_down = 1,								name = _('Antidust - ON'),								category = {_('Left Side Panel'), _('Engines')}},
{down = engine_commands.ANTIDUST_On,					cockpit_device_id = devices.ENGINE_INTERFACE,	value_down = 0,								name = _('Antidust - OFF'),								category = {_('Left Side Panel'), _('Engines')}},
--HydroInterface
{down = hydraulic_commands.MainHydro_EXT,																										cockpit_device_id = devices.HYDRO_SYS_INTERFACE,		value_down = 1,							name = _('Main/Auxiliary Hydraulic Switch - AUXILIARY'),			category = {_('Left Forward Panel')}},
{down = hydraulic_commands.MainHydro_EXT,																										cockpit_device_id = devices.HYDRO_SYS_INTERFACE,		value_down = 0,							name = _('Main/Auxiliary Hydraulic Switch - MAIN'),					category = {_('Left Forward Panel')}},
{down = hydraulic_commands.MainHydro_ITER,																										cockpit_device_id = devices.HYDRO_SYS_INTERFACE,		value_down = 1,							name = _('Main/Auxiliary Hydraulic Switch - MAIN/AUXILIARY'),		category = {_('Left Forward Panel')}},
{down = hydraulic_commands.GearHydro_EXT,																										cockpit_device_id = devices.HYDRO_SYS_INTERFACE,		value_down = 1,							name = _('Main/Reserve Gear Hydraulic Switch - RESERVE'),			category = {_('Left Forward Panel')}},
{down = hydraulic_commands.GearHydro_EXT,																										cockpit_device_id = devices.HYDRO_SYS_INTERFACE,		value_down = 0,							name = _('Main/Reserve Gear Hydraulic Switch - MAIN'),				category = {_('Left Forward Panel')}},
{down = hydraulic_commands.GearHydro_ITER,																										cockpit_device_id = devices.HYDRO_SYS_INTERFACE,		value_down = 1,							name = _('Main/Reserve Gear Hydraulic Switch - MAIN/RESERVE'),		category = {_('Left Forward Panel')}},
{down = hydraulic_commands.DisableAuxiliaryHydro_EXT,					up = hydraulic_commands.DisableAuxiliaryHydro_EXT,						cockpit_device_id = devices.HYDRO_SYS_INTERFACE,	 	value_down = 1,	 	value_up = 0,		name = _('Auxiliary Disable Button'),								category = {_('Left Forward Panel')}},

--CockpitMechanics
{down = iCommandEmergencyGear, 																																											value_down = 1,							name = _('Emeregency Gear Lever'), 									category = {_('Instrument Panel')}},
{down = iCommandPlaneGearUp,																																											value_down = 1,							name = _('Gear Lever - UP'),										category = {_('Instrument Panel')}},
{down = iCommandPlaneGearDown,																																											value_down = 0,							name = _('Gear Lever - DOWN'),										category = {_('Instrument Panel')}},
{down = iCommandPlaneGear,																																												value_down = 1,							name = _('Gear Lever - UP/DOWN'),									category = {_('Instrument Panel')}},
{down = cockpit_mechanics_commands.Command_CPT_MECH_Gear_Pilot_Lock,	up = cockpit_mechanics_commands.Command_CPT_MECH_Gear_Pilot_Lock,		cockpit_device_id = devices.CPT_MECH,	 				value_down = 1,	 	value_up = 0,		name = _('Gear Lever Lock, UP/DOWN'),								category = {_('Instrument Panel')}},
{down = cockpit_mechanics_commands.Command_CPT_MECH_WindSprayerEXT,		up = cockpit_mechanics_commands.Command_CPT_MECH_WindSprayerEXT,		cockpit_device_id = devices.CPT_MECH,	 				value_down = 1,	 	value_up = 0,		name = _('Window Sprayer Button'),									category = {_('Left Side Panel')}},
{down = iCommandToggleMirrors,	name = _('Mirror ON/OFF'), category = {_('Cheat')}},

--Weapon System
{down = weapon_commands.Pilot_NPU_CHAIN_Ext, 						cockpit_device_id = devices.WEAP_SYS, value_down = 1, 	name = _('Pilot Burst Length SHORT/MED/LONG Up'),		category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_NPU_CHAIN_Ext, 						cockpit_device_id = devices.WEAP_SYS, value_down = -1, 	name = _('Pilot Burst Length SHORT/MED/LONG Down'),	category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_NPU_CHAIN, 							cockpit_device_id = devices.WEAP_SYS, value_down = 1, 	name = _('Pilot Burst Length SHORT'),				category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_NPU_CHAIN, 							cockpit_device_id = devices.WEAP_SYS, value_down = -1, 	name = _('Pilot Burst Length MED'),					category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_NPU_CHAIN, 							cockpit_device_id = devices.WEAP_SYS, value_down = 0, 	name = _('Pilot Burst Length LONG'),				category = {_('Weapon Panel')}},

{down = weapon_commands.Pilot_RELOAD_LEFT_Ext, 						cockpit_device_id = devices.WEAP_SYS, value_down = 1, 	name = _('Reload Left Gondola Up'),				category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_RELOAD_LEFT_Ext, 						cockpit_device_id = devices.WEAP_SYS, value_down = -1, 	name = _('Reload Left Gondola Down'),			category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_RELOAD_RIGHT_Ext, 					cockpit_device_id = devices.WEAP_SYS, value_down = 1, 	name = _('Reload Right Gondola Up'),			category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_RELOAD_RIGHT_Ext, 					cockpit_device_id = devices.WEAP_SYS, value_down = -1, 	name = _('Reload Right Gondola Down'),			category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_FKP_CAMERA_Ext, 						cockpit_device_id = devices.WEAP_SYS, value_down = 1, 	name = _('Camera ON/OFF'),						category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_SWITCHER_OFF_GM_URS_NPU_Iter, 		cockpit_device_id = devices.WEAP_SYS, value_down = -1,	name = _('Select Weapon Pilot Prev'),					category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_SWITCHER_OFF_GM_URS_NPU_Iter, 		cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Select Weapon Pilot Next'),					category = {_('Weapon Panel')}},

{down = weapon_commands.Pilot_SWITCHER_OFF_GM_URS_NPU_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 0,		name = _('Select Weapon Pilot 1 OFF MSL'),			category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_SWITCHER_OFF_GM_URS_NPU_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 0.1,	name = _('Select Weapon Pilot 2 GM-30'),			category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_SWITCHER_OFF_GM_URS_NPU_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 0.2,	name = _('Select Weapon Pilot 3 FXD MG7.62+12.7'),	category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_SWITCHER_OFF_GM_URS_NPU_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 0.3,	name = _('Select Weapon Pilot 4 FXD MG-12.7'),		category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_SWITCHER_OFF_GM_URS_NPU_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 0.4,	name = _('Select Weapon Pilot 5 FXD MG-7.62'),		category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_SWITCHER_OFF_GM_URS_NPU_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 0.5,	name = _('Select Weapon Pilot 6 FXD MG-30'),		category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_SWITCHER_OFF_GM_URS_NPU_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 0.6,	name = _('Select Weapon Pilot 7 ROCKET'),			category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_SWITCHER_OFF_GM_URS_NPU_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 0.7,	name = _('Select Weapon Pilot 8 BOMB'),				category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_SWITCHER_OFF_GM_URS_NPU_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 0.8,	name = _('Select Weapon Pilot 9 USLP'),				category = {_('Weapon Panel')}},


{down = weapon_commands.Pilot_BOTH_LEFT_RIGHT_Ext, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Select Rockets LEFT/BOTH/RIGHT Right'),		category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_BOTH_LEFT_RIGHT_Ext, 				cockpit_device_id = devices.WEAP_SYS, value_down = -1,	name = _('Select Rockets LEFT/BOTH/RIGHT Left'),		category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_BOTH_LEFT_RIGHT, 					cockpit_device_id = devices.WEAP_SYS, value_down = -1,	name = _('Select Rockets LEFT'),		category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_BOTH_LEFT_RIGHT, 					cockpit_device_id = devices.WEAP_SYS, value_down = 0,	name = _('Select Rockets BOTH'),		category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_BOTH_LEFT_RIGHT, 					cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Select Rockets RIGHT'),		category = {_('Weapon Panel')}},


{down = weapon_commands.Pilot_SWITCHER_FIRE_CONTROL_UP_Ext, 		cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Weapon Control ON'),							category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_SWITCHER_FIRE_CONTROL_DOWN_Ext, 		cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Weapon Control OFF'),							category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_SWITCHER_FIRE_CONTROL_Ext, 			cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Weapon Control ON/OFF'),							category = {_('Weapon Panel')}},

{down = weapon_commands.Pilot_TEMP_NPU30_Ext, 						cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Pilot Cannon Fire Rate SLOW/FAST'),			category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_TEMP_NPU30, 							cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Pilot MG rate HIGH'),			category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_TEMP_NPU30, 							cockpit_device_id = devices.WEAP_SYS, value_down = 0,	name = _('Pilot MG rate LOW'),			category = {_('Weapon Panel')}},

{down = weapon_commands.Pilot_RELOAD_NPU30_Ext, up = weapon_commands.Pilot_RELOAD_NPU30_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 1, value_up = 0,	name = _('Pilot Reload Cannon'),	category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_STOP_KMG_Ext, up = weapon_commands.Pilot_STOP_KMG_Ext,	cockpit_device_id = devices.WEAP_SYS, value_down = 1, value_up = 0,	name = _('Stop container'),	category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_EMERG_EXPLODE_Ext, 					cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Pilot Explosion on Jettison ON/OFF '),		category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_EMERG_EXPLODE, 						cockpit_device_id = devices.WEAP_SYS, value_down = 0,	name = _('Pilot Explosion on Jettison OFF'),		category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_EMERG_EXPLODE, 						cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Pilot Explosion on Jettison ON'),		category = {_('Weapon Panel')}},

{down = weapon_commands.Pilot_EMERG_EXPLODE_COVER_Ext, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Pilot Explosion on Jettison Cover, UP/DOWN'),	category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_EMERG_RELEASE_Ext, 					cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Pilot Jettison Pylons ON/OFF'),				category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_EMERG_RELEASE_COVER_Ext, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Pilot Jettison Pylons Cover, UP/DOWN'),		category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_EMERG_RELEASE_PU_Ext, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Pilot Jettison Launcher ON/OFF'),			category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_EMERG_RELEASE_PU_COVER_Ext, 			cockpit_device_id = devices.WEAP_SYS, 	value_down = 1,	name = _('Pilot Jettison Launcher Cover, UP/DOWN'),	category = {_('Weapon Panel')}},
{down = weapon_commands.Pilot_PUS_ARMING, up = weapon_commands.Pilot_PUS_ARMING_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 1, value_up = 0, name = _('Arm Rockets'),	category = {_('Weapon Panel')}},

{down = weapon_commands.Pilot_Counter1_Inc, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Ammo Counter 1 Increment'),			category = {_('Ammo Counters Panel')}},
{down = weapon_commands.Pilot_Counter2_Inc, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Ammo Counter 2 Increment'),			category = {_('Ammo Counters Panel')}},
{down = weapon_commands.Pilot_Counter3_Inc, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Ammo Counter 3 Increment'),			category = {_('Ammo Counters Panel')}},
{down = weapon_commands.Pilot_Counter4_Inc, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Ammo Counter 4 Increment'),			category = {_('Ammo Counters Panel')}},
{down = weapon_commands.Pilot_Counter5_Inc, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Ammo Counter 5 Increment'),			category = {_('Ammo Counters Panel')}},


{down = R60_commands.Power_OnOff_Ext, 				cockpit_device_id = devices.R60_INTERFACE, value_down = 1,	name = _('R-60 Power - ON'),			category = {_('R-60 (A2A) Panel')}},
{down = R60_commands.Power_OnOff_Ext, 				cockpit_device_id = devices.R60_INTERFACE, value_down = 0,	name = _('R-60 Power - OFF'),			category = {_('R-60 (A2A) Panel')}},

{down = R60_commands.NC_VC_Ext, 					cockpit_device_id = devices.R60_INTERFACE, value_down = 1,	name = _('R-60 Mode - AIR'),			category = {_('R-60 (A2A) Panel')}},
{down = R60_commands.NC_VC_Ext, 					cockpit_device_id = devices.R60_INTERFACE, value_down = 0,	name = _('R-60 Mode - GND'),			category = {_('R-60 (A2A) Panel')}},

{down = R60_commands.StationSelector_Ext, 			cockpit_device_id = devices.R60_INTERFACE, value_down = 0,		name = _('R-60 Launcher Selector - OFF'),	category = {_('R-60 (A2A) Panel')}},
{down = R60_commands.StationSelector_Ext, 			cockpit_device_id = devices.R60_INTERFACE, value_down = 0.1,	name = _('R-60 Launcher Selector - 1'),		category = {_('R-60 (A2A) Panel')}},
{down = R60_commands.StationSelector_Ext, 			cockpit_device_id = devices.R60_INTERFACE, value_down = 0.2,	name = _('R-60 Launcher Selector - 2'),		category = {_('R-60 (A2A) Panel')}},
{down = R60_commands.StationSelector_Ext, 			cockpit_device_id = devices.R60_INTERFACE, value_down = 0.3,	name = _('R-60 Launcher Selector - 3'),		category = {_('R-60 (A2A) Panel')}},
{down = R60_commands.StationSelector_Ext, 			cockpit_device_id = devices.R60_INTERFACE, value_down = 0.4,	name = _('R-60 Launcher Selector - 4'),		category = {_('R-60 (A2A) Panel')}},

--Gunners AI Panel
{down = weapon_commands.CMD_GAI_CTL_SHOW, 		cockpit_device_id = devices.WEAP_SYS, value_down = 1.0, name = _('AI Panel Show/Hide'), 		category = _('Gunners AI Panel')},
{down = weapon_commands.CMD_GAI_CTL_GUNNER, 	cockpit_device_id = devices.WEAP_SYS, value_down = 0.0, name = _('AI Gunner ROE Iterate'), 	category = _('Gunners AI Panel')},
{down = weapon_commands.CMD_GAI_CTL_GUNNER, 	cockpit_device_id = devices.WEAP_SYS, value_down = 0.1, name = _('AI Gunner Burst Switch'), 	category = _('Gunners AI Panel')},
{down = weapon_commands.CMD_Show_Gunners_Panel,	cockpit_device_id = devices.WEAP_SYS,		value_down = 1.0,	name = _('Show Gunners Panel'),	category = {_('Hints'), _('Armament System')}},

--SPO-10
{down = SPO_commands.Command_SPO_POWER_Ext, 		cockpit_device_id = devices.SPO_10, value_down = 1,	name = _('RWR Power'),			category = {_('RWR')}},
{down = SPO_commands.Command_SPO_SIGNAL_Ext, 		cockpit_device_id = devices.SPO_10, value_down = 1, name = _('RWR Signal On/Off'),	category = {_('RWR')}},
{down = SPO_commands.Command_DAY_NIGHT_Ext, 		cockpit_device_id = devices.SPO_10, value_down = -1, name = _('RWR DAY/NIGHT'),		category = {_('RWR')}},

--ASO-2V
{down = avASO_2V_commands.ASO_2V_Release_Pilot_Ext, up = avASO_2V_commands.ASO_2V_Release_Pilot_Ext, 	cockpit_device_id = devices.ASO_2V, value_down = 1, value_up = 0,	name = _('Pilot Launch Countermeasures'),		category = {_('Left Side Panel')}},

--ASP-17
{down = asp_commands.Reflector_Fix_ITER, 			cockpit_device_id = devices.ASP_17V, value_down = 1, name = _('Sight Fix/Release Reflector'),		category = {_('ASP-17V')}},
{down = asp_commands.Reflector_Fix_EXT, 			cockpit_device_id = devices.ASP_17V, value_down = 0, name = _('Sight Fix Reflector'),		category = {_('ASP-17V')}},
{down = asp_commands.Reflector_Fix_EXT, 			cockpit_device_id = devices.ASP_17V, value_down = 1, name = _('Sight Release Reflector'),		category = {_('ASP-17V')}},
{down = asp_commands.Reflector_Move_Up_EXT, 		cockpit_device_id = devices.ASP_17V, value_down = 1, name = _('Sight Reflector Up'),				category = {_('ASP-17V')}},
{down = asp_commands.Reflector_Move_Down_EXT, 		cockpit_device_id = devices.ASP_17V, value_down = 1, name = _('Sight Reflector Down'),			category = {_('ASP-17V')}},
{down = asp_commands.Power_EXT, 					cockpit_device_id = devices.ASP_17V, value_down = 1, name = _('Sight Power On'),			category = {_('ASP-17V')}},
{down = asp_commands.Power_EXT, 					cockpit_device_id = devices.ASP_17V, value_down = 0, name = _('Sight Power Off'),			category = {_('ASP-17V')}},
{down = asp_commands.Power_ITER, 					cockpit_device_id = devices.ASP_17V, value_down = 0, name = _('Sight Power On/Off'),			category = {_('ASP-17V')}},


{down = asp_commands.Range_Auto_Manual, 			cockpit_device_id = devices.ASP_17V, value_down = 1, 			name = _('Sight distance AUTO'),							category = {_('Weapon Panel')}},
{down = asp_commands.Range_Auto_Manual, 			cockpit_device_id = devices.ASP_17V, value_down = 0, 			name = _('Sight distance Manual'),							category = {_('Weapon Panel')}},
{down = asp_commands.Range_Auto_Manual_ITER, 		cockpit_device_id = devices.ASP_17V, value_down = 0, 			name = _('Sight distance Manual/AUTO'),						category = {_('Weapon Panel')}},
{down = asp_commands.Manual_Auto, 					cockpit_device_id = devices.ASP_17V, value_down = 0.5, 			name = _('Sight mode AUTO'),								category = {_('ASP-17V')}},
{down = asp_commands.Manual_Auto, 					cockpit_device_id = devices.ASP_17V, value_down = 0, 			name = _('Sight mode MANUAL'),								category = {_('ASP-17V')}},
{down = asp_commands.Manual_Auto_ITER, 				cockpit_device_id = devices.ASP_17V, value_down = 0, 			name = _('Sight mode MANUAL/AUTO'),							category = {_('ASP-17V')}},
{down = asp_commands.Sync_Async, 					cockpit_device_id = devices.ASP_17V, value_down = 0.5, 			name = _('Sight mode SYNC'),								category = {_('ASP-17V')}},
{down = asp_commands.Sync_Async, 					cockpit_device_id = devices.ASP_17V, value_down = 0, 			name = _('Sight mode ASYNC'),								category = {_('ASP-17V')}},
{down = asp_commands.Sync_Async_ITER, 				cockpit_device_id = devices.ASP_17V, value_down = 0, 			name = _('Sight mode SYNC/ASYNC'),							category = {_('ASP-17V')}},

{pressed = asp_commands.Range_Value_AXIS, 			cockpit_device_id = devices.ASP_17V, value_pressed = 0.05, 		name = _('Sight Range Adjustment Inc'),						category = {_('Weapon Panel')}},
{pressed = asp_commands.Range_Value_AXIS, 			cockpit_device_id = devices.ASP_17V, value_pressed = -0.05, 	name = _('Sight Range Adjustment Dec'),						category = {_('Weapon Panel')}},
{pressed = asp_commands.Elevation_Delta_AXIS, 		cockpit_device_id = devices.ASP_17V, value_pressed = 0.0125, 	name = _('Sight Crosshair Vertical Adjustment Up'),			category = {_('ASP-17V')}},
{pressed = asp_commands.Elevation_Delta_AXIS, 		cockpit_device_id = devices.ASP_17V, value_pressed = -0.0125, 	name = _('Sight Crosshair Vertical Adjustment Down'),		category = {_('ASP-17V')}},
{pressed = asp_commands.Base_Range_AXIS,			cockpit_device_id = devices.ASP_17V, value_pressed = 0.05, 		name = _('Sight Base of Target Adjustment Inc'),			category = {_('ASP-17V')}},
{pressed = asp_commands.Base_Range_AXIS,			cockpit_device_id = devices.ASP_17V, value_pressed = -0.05, 	name = _('Sight Base of Target Adjustment Dec'),			category = {_('ASP-17V')}},
{pressed = asp_commands.Brightness_PM_AXIS, 		cockpit_device_id = devices.ASP_17V, value_pressed = 0.05, 		name = _('Sight Crosshair Brightness Adjustment Inc'),		category = {_('ASP-17V')}},
{pressed = asp_commands.Brightness_PM_AXIS, 		cockpit_device_id = devices.ASP_17V, value_pressed = -0.05, 	name = _('Sight Crosshair Brightness Adjustment Dec'),		category = {_('ASP-17V')}},
{pressed = asp_commands.Azimuth_Delta_AXIS, 		cockpit_device_id = devices.ASP_17V, value_pressed = 0.0125, 	name = _('Sight Crosshair Horizontal Adjustment Right'),	category = {_('ASP-17V')}},
{pressed = asp_commands.Azimuth_Delta_AXIS, 		cockpit_device_id = devices.ASP_17V, value_pressed = -0.0125, 	name = _('Sight Crosshair Horizontal Adjustment Left'),		category = {_('ASP-17V')}},
{pressed = asp_commands.Brightness_NS_AXIS, 		cockpit_device_id = devices.ASP_17V, value_pressed = 0.05, 		name = _('Sight Grid Brightness Adjustment Inc'),			category = {_('ASP-17V')}},
{pressed = asp_commands.Brightness_NS_AXIS, 		cockpit_device_id = devices.ASP_17V, value_pressed = -0.05, 	name = _('Sight Grid Brightness Adjustment Dec'),			category = {_('ASP-17V')}},

{down = asp_commands.Control_EXT, up = asp_commands.Control_EXT,	cockpit_device_id = devices.ASP_17V, value_down = 1, value_up = 0, name = _('BIT button'),					category = {_('ASP-17V')}},
{down = asp_commands.Backup_Light_PM_ITER, 			cockpit_device_id = devices.ASP_17V, value_down = 1, 			name = _('Floating Reticle Backup Lamp ON/OFF'),			category = {_('ASP-17V')}},
{down = asp_commands.Backup_Light_NS_ITER, 			cockpit_device_id = devices.ASP_17V, value_down = 1, 			name = _('Fixed Grid Backup Lamp ON/OFF'),					category = {_('ASP-17V')}},

--InternalLightSystem
{down = int_lights_commands.CabinLightingWhiteRed_EXT,                                                                 								cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Cabin Lighting Switch - WHITE'),												category = {_('Left Side Panel')}},
{down = int_lights_commands.CabinLightingWhiteRed_EXT,	                                                             								cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = -1,                       	name = _('Cabin Lighting Switch - RED'),												category = {_('Left Side Panel')}},
{down = int_lights_commands.CabinLightingWhiteRed_ITER,                                                                								cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Cabin Lighting Switch - WHITE/RED'),											category = {_('Left Side Panel')}},
{down = int_lights_commands.CargoWhiteLightingOn_EXT,                                                                 								cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Cargo Lighting Switch - ON'),													category = {_('Left Side Panel')}},
{down = int_lights_commands.CargoWhiteLightingOn_EXT,	                                                             								cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0,                        	name = _('Cargo Lighting Switch - OFF'),												category = {_('Left Side Panel')}},
{down = int_lights_commands.CargoWhiteLightingOn_ITER,                                                                								cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Cargo Lighting Switch - ON/OFF'),												category = {_('Left Side Panel')}},
{down = int_lights_commands.CargoLightingWhiteBlue_EXT,                                                                 								cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Cargo Lighting Switch - WHITE'),												category = {_('Left Side Panel')}},
{down = int_lights_commands.CargoLightingWhiteBlue_EXT,	                                                             								cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0,                        	name = _('Cargo Lighting Switch - BLUE'),												category = {_('Left Side Panel')}},
{down = int_lights_commands.CargoLightingWhiteBlue_ITER,                                                                								cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Cargo Lighting Switch - WHITE/BLUE'),											category = {_('Left Side Panel')}},
{down = int_lights_commands.TestLights_EXT,									up = int_lights_commands.TestLights_EXT,								cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,	 	value_up = 0,		name = _('Test Warning Lights Button'),													category = {_('Left Forward Panel')}},
{down = int_lights_commands.DayNight_EXT,                                                                 											cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Day-Night Switch - DAY'),														category = {_('Left Forward Panel')}},
{down = int_lights_commands.DayNight_EXT,	                                                             											cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0,                        	name = _('Day-Night Switch - NIGHT'),													category = {_('Left Forward Panel')}},
{down = int_lights_commands.DayNight_ITER,                                                                											cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Day-Night Switch - DAY/NIGHT'),												category = {_('Left Forward Panel')}},
{down = int_lights_commands.BlinkerSystem_EXT,                                                                 										cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Blinker Switch - ON'),														category = {_('Left Forward Panel')}},
{down = int_lights_commands.BlinkerSystem_EXT,	                                                             										cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0,                        	name = _('Blinker Switch - OFF'),														category = {_('Left Forward Panel')}},
{down = int_lights_commands.BlinkerSystem_ITER,                                                                										cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Blinker Switch - ON/OFF'),													category = {_('Left Forward Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_1_EXT,                                                                 			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.0,                       name = _('Transformer 1 Group Of Red Lights Right And Pilot Panel - OFF'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_1_EXT,	                                                             			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.1,                       name = _('Transformer 1 Group Of Red Lights Right And Pilot Panel - 8V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_1_EXT,                                                                 			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.2,                     	name = _('Transformer 1 Group Of Red Lights Right And Pilot Panel - 9V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_1_EXT,                                                                 			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.3,                       name = _('Transformer 1 Group Of Red Lights Right And Pilot Panel - 10V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_1_EXT,	                                                             			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.4,                       name = _('Transformer 1 Group Of Red Lights Right And Pilot Panel - 11V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_1_EXT,                                                                 			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.5,                     	name = _('Transformer 1 Group Of Red Lights Right And Pilot Panel - 12V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_1_EXT,                                                                 			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.6,                       name = _('Transformer 1 Group Of Red Lights Right And Pilot Panel - 13V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_1_EXT,	                                                             			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.7,                       name = _('Transformer 1 Group Of Red Lights Right And Pilot Panel - 14V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_1_EXT,                                                                 			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.8,                     	name = _('Transformer 1 Group Of Red Lights Right And Pilot Panel - 16V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_1_EXT,                                                                 			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.9,                       name = _('Transformer 1 Group Of Red Lights Right And Pilot Panel - 18V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_1_EXT,	                                                             			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1.0,                       name = _('Transformer 1 Group Of Red Lights Right And Pilot Panel - 20V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_1_ITER,                                                                			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Transformer 1 Group Of Red Lights Right And Pilot Panel - CYCLE(UP)'),		category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_1_ITER,                                                                			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = -1,                       	name = _('Transformer 1 Group Of Red Lights Right And Pilot Panel - CYCLE(DOWN)'),		category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_2_EXT,                                                                 			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.0,                       name = _('Transformer 2 Group Of Red Lights Right And Pilot Panel - OFF'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_2_EXT,	                                                             			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.1,                       name = _('Transformer 2 Group Of Red Lights Right And Pilot Panel - 8V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_2_EXT,                                                                 			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.2,                     	name = _('Transformer 2 Group Of Red Lights Right And Pilot Panel - 9V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_2_EXT,                                                                 			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.3,                       name = _('Transformer 2 Group Of Red Lights Right And Pilot Panel - 10V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_2_EXT,	                                                             			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.4,                       name = _('Transformer 2 Group Of Red Lights Right And Pilot Panel - 11V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_2_EXT,                                                                 			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.5,                     	name = _('Transformer 2 Group Of Red Lights Right And Pilot Panel - 12V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_2_EXT,                                                                 			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.6,                       name = _('Transformer 2 Group Of Red Lights Right And Pilot Panel - 13V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_2_EXT,	                                                             			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.7,                       name = _('Transformer 2 Group Of Red Lights Right And Pilot Panel - 14V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_2_EXT,                                                                 			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.8,                     	name = _('Transformer 2 Group Of Red Lights Right And Pilot Panel - 16V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_2_EXT,                                                                 			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.9,                       name = _('Transformer 2 Group Of Red Lights Right And Pilot Panel - 18V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_2_EXT,	                                                             			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1.0,                       name = _('Transformer 2 Group Of Red Lights Right And Pilot Panel - 20V'),				category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_2_ITER,                                                                			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Transformer 2 Group Of Red Lights Right And Pilot Panel - CYCLE(UP)'),		category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_2_ITER,                                                                			cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = -1,                       	name = _('Transformer 2 Group Of Red Lights Right And Pilot Panel - CYCLE(DOWN)'),		category = {_('Right Side Panel')}},
{down = int_lights_commands.SpecialEquipmentPanelRedLights_EXT,                                                                 						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Armament Panel Red Lights Switch - ON'),										category = {_('Right Forward Panel')}},
{down = int_lights_commands.SpecialEquipmentPanelRedLights_EXT,	                                                             						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0,                        	name = _('Armament Panel Red Lights Switch - OFF'),										category = {_('Right Forward Panel')}},
{down = int_lights_commands.SpecialEquipmentPanelRedLights_ITER,                                                                						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Armament Panel Red Lights Switch - ON/OFF'),									category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_1_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.0,                       name = _('Transformer 1 Group Of Red Lights Left Pilot Panel - OFF'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_1_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.1,                       name = _('Transformer 1 Group Of Red Lights Left Pilot Panel - 8V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_1_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.2,                     	name = _('Transformer 1 Group Of Red Lights Left Pilot Panel - 9V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_1_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.3,                       name = _('Transformer 1 Group Of Red Lights Left Pilot Panel - 10V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_1_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.4,                       name = _('Transformer 1 Group Of Red Lights Left Pilot Panel - 11V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_1_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.5,                     	name = _('Transformer 1 Group Of Red Lights Left Pilot Panel - 12V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_1_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.6,                       name = _('Transformer 1 Group Of Red Lights Left Pilot Panel - 13V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_1_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.7,                       name = _('Transformer 1 Group Of Red Lights Left Pilot Panel - 14V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_1_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.8,                     	name = _('Transformer 1 Group Of Red Lights Left Pilot Panel - 16V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_1_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.9,                       name = _('Transformer 1 Group Of Red Lights Left Pilot Panel - 18V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_1_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1.0,                       name = _('Transformer 1 Group Of Red Lights Left Pilot Panel - 20V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_1_ITER,                                                                							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Transformer 1 Group Of Red Lights Left Pilot Panel - CYCLE(UP)'),				category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_1_ITER,                                                                							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = -1,                       	name = _('Transformer 1 Group Of Red Lights Left Pilot Panel - CYCLE(DOWN)'),			category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_2_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.0,                       name = _('Transformer 2 Group Of Red Lights Left Pilot Panel - OFF'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_2_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.1,                       name = _('Transformer 2 Group Of Red Lights Left Pilot Panel - 8V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_2_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.2,                     	name = _('Transformer 2 Group Of Red Lights Left Pilot Panel - 9V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_2_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.3,                       name = _('Transformer 2 Group Of Red Lights Left Pilot Panel - 10V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_2_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.4,                       name = _('Transformer 2 Group Of Red Lights Left Pilot Panel - 11V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_2_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.5,                     	name = _('Transformer 2 Group Of Red Lights Left Pilot Panel - 12V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_2_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.6,                       name = _('Transformer 2 Group Of Red Lights Left Pilot Panel - 13V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_2_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.7,                       name = _('Transformer 2 Group Of Red Lights Left Pilot Panel - 14V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_2_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.8,                     	name = _('Transformer 2 Group Of Red Lights Left Pilot Panel - 16V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_2_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.9,                       name = _('Transformer 2 Group Of Red Lights Left Pilot Panel - 18V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_2_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1.0,                       name = _('Transformer 2 Group Of Red Lights Left Pilot Panel - 20V'),					category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_2_ITER,                                                                							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Transformer 2 Group Of Red Lights Left Pilot Panel - CYCLE(UP)'),				category = {_('Right Forward Panel')}},
{down = int_lights_commands.RedLightsPilotLeftPanel_2_ITER,                                                                							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = -1,                       	name = _('Transformer 2 Group Of Red Lights Left Pilot Panel - CYCLE(DOWN)'),			category = {_('Right Forward Panel')}},

{down = int_lights_commands.RedLightsPilotBuiltInRedLights_EXT,                                                                 						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.0,                       name = _('Builtin Red Lights Transformer - OFF'),										category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotBuiltInRedLights_EXT,	                                                             						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.1,                       name = _('Builtin Red Lights Transformer - 0.6V'),										category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotBuiltInRedLights_EXT,                                                                 						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.2,                     	name = _('Builtin Red Lights Transformer - 1.2V'),										category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotBuiltInRedLights_EXT,                                                                 						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.3,                       name = _('Builtin Red Lights Transformer - 1.8V'),										category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotBuiltInRedLights_EXT,	                                                             						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.4,                       name = _('Builtin Red Lights Transformer - 2.4V'),										category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotBuiltInRedLights_EXT,                                                                 						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.5,                     	name = _('Builtin Red Lights Transformer - 3V'),										category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotBuiltInRedLights_EXT,                                                                 						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.6,                       name = _('Builtin Red Lights Transformer - 3.6V'),										category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotBuiltInRedLights_EXT,	                                                             						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.7,                       name = _('Builtin Red Lights Transformer - 4.2V'),										category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotBuiltInRedLights_EXT,                                                                 						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.8,                     	name = _('Builtin Red Lights Transformer - 4.8V'),										category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotBuiltInRedLights_EXT,                                                                 						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.9,                       name = _('Builtin Red Lights Transformer - 5.4V'),										category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotBuiltInRedLights_EXT,	                                                             						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1.0,                       name = _('Builtin Red Lights Transformer - 6V'),										category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotBuiltInRedLights_ITER,                                                                						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Builtin Red Lights Transformer - CYCLE(UP)'),									category = {_('Right Side Panel')}},
{down = int_lights_commands.RedLightsPilotBuiltInRedLights_ITER,                                                                						cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = -1,                  	name = _('Builtin Red Lights Transformer - CYCLE(DOWN)'),								category = {_('Right Side Panel')}},

--ExternalLightSystem
{																				down = ext_lights_commands.GearLights_EXT,                  				                                           								cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 1,                     	name = _('Gear Lights Switch - ON'),													category = {_('Left Forward Panel')}},
{																				down = ext_lights_commands.GearLights_EXT,	                				                                            							cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 0,                     	name = _('Gear Lights Switch - OFF'),													category = {_('Left Forward Panel')}},
{																				down = ext_lights_commands.GearLights_ITER,                 				                                           								cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 1,                     	name = _('Gear Lights Switch - ON/OFF'),												category = {_('Left Forward Panel')}},
{																				down = ext_lights_commands.TaxiLight_EXT,                  				                                           									cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 1,                     	name = _('Taxi Light Control Switch - ON'),												category = {_('Left Forward Panel')}},
{																				down = ext_lights_commands.TaxiLight_EXT,	                				                                            							cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 0,                     	name = _('Taxi Light Control Switch - OFF'),											category = {_('Left Forward Panel')}},
{																				down = ext_lights_commands.TaxiLight_ITER,                 				                                           									cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 1,                     	name = _('Taxi Light Control Switch - ON/OFF'),											category = {_('Left Forward Panel')}},
{																				down = ext_lights_commands.NavLtSwitch_EXT,                  				                                           								cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 1,                     	name = _('Navigation Lights Switch - BRIGHT'),											category = {_('Left Forward Panel')}},
{																				down = ext_lights_commands.NavLtSwitch_EXT,	                				                                            							cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 0,                     	name = _('Navigation Lights Switch - OFF'),												category = {_('Left Forward Panel')}},
{																				down = ext_lights_commands.NavLtSwitch_EXT,	                				                                            							cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = -1,                     	name = _('Navigation Lights Switch - DIM'),												category = {_('Left Forward Panel')}},
{																				down = ext_lights_commands.NavLtSwitch_ITER,                 				                                           								cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 1,                     	name = _('Navigation Lights Switch - CYCLE(UP)'),										category = {_('Left Forward Panel')}},
{																				down = ext_lights_commands.NavLtSwitch_ITER,                 				                                           								cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = -1,                     	name = _('Navigation Lights Switch - CYCLE(DOWN)'),										category = {_('Left Forward Panel')}},
{																				down = ext_lights_commands.NavCodeButton_EXT,								up = ext_lights_commands.NavCodeButton_EXT,								cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 1,	 	value_up = 0,		name = _('Navigation Lights Code Button'),												category = {_('Left Forward Panel')}},
{																				down = ext_lights_commands.FormationLights_EXT,                  				                                           							cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 1,                     	name = _('Formation Lights Switch - BRIGHT'),											category = {_('Left Side Panel')}},
{																				down = ext_lights_commands.FormationLights_EXT,	                				                                            						cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 0,                     	name = _('Formation Lights Switch - OFF'),												category = {_('Left Side Panel')}},
{																				down = ext_lights_commands.FormationLights_EXT,	                				                                            						cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = -1,                     	name = _('Formation Lights Switch - DIM'),												category = {_('Left Side Panel')}},
{																				down = ext_lights_commands.FormationLights_ITER,                 				                                           							cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 1,                     	name = _('Formation Lights Switch - CYCLE(UP)'),										category = {_('Left Side Panel')}},
{																				down = ext_lights_commands.FormationLights_ITER,                 				                                           							cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = -1,                     	name = _('Formation Lights Switch - CYCLE(DOWN)'),										category = {_('Left Side Panel')}},
{																				down = ext_lights_commands.TipLights_EXT,                  				                                           									cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 1,                     	name = _('Tip Lights Switch - ON'),														category = {_('Left Side Panel')}},
{																				down = ext_lights_commands.TipLights_EXT,	                				                                            							cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 0,                     	name = _('Tip Lights Switch - OFF'),													category = {_('Left Side Panel')}},
{																				down = ext_lights_commands.TipLights_ITER,                 				                                           									cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 1,                     	name = _('Tip Lights Switch - ON/OFF'),													category = {_('Left Side Panel')}},
{																				down = ext_lights_commands.StrobeLight_EXT,                  				                                           								cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 1,                     	name = _('Strobe Light Switch - ON'),													category = {_('Left Side Panel')}},
{																				down = ext_lights_commands.StrobeLight_EXT,	                				                                            							cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 0,                     	name = _('Strobe Light Switch - OFF'),													category = {_('Left Side Panel')}},
{																				down = ext_lights_commands.StrobeLight_ITER,                 				                                           								cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 1,                     	name = _('Strobe Light Switch - ON/OFF'),												category = {_('Left Side Panel')}},
{down = iCommandPlaneLightsOnOff,	 value_down = -1,	name = _('Nav. Lights Switch - Down'),			category = {_('Left Forward Panel'), _('External Lights')}},
{down = iCommandPlaneLightsOnOff,     value_down = 1,	name = _('Nav. Lights Switch - Up'),			category = {_('Left Forward Panel'), _('External Lights')}},
{down = iCommandPlaneFormationLights, value_down = -1,	name = _('Formation Lights Switch - Down'),		category = {_('Left Side Panel'), _('External Lights')}},
{down = iCommandPlaneFormationLights, value_down = 1,	name = _('Formation Lights Switch - Up'),		category = {_('Left Side Panel'), _('External Lights')}},
--{down = iCommandPlaneRotorTipLights,	name = _('Tip Lights Switch - ON/OFF'),			category = {_('Left Side Panel'), _('External Lights')}},
--{down = iCommandPlaneAntiCollisionLights,name = _('Strobe Light Switch - ON/OFF'),		category = {_('Left Side Panel'), _('External Lights')}},


{down = ext_lights_commands.HeadLightPilotControl_EXT, up = ext_lights_commands.HeadLightPilotControl_EXT,	cockpit_device_id = devices.EXT_LIGHTS_SYSTEM, value_down = 0.2, value_up = 0,	name = _('Headlight - Down'),	category = {_('Ins Collective Stick'), _('External Lights')}},
{down = ext_lights_commands.HeadLightPilotControl_EXT, up = ext_lights_commands.HeadLightPilotControl_EXT,	cockpit_device_id = devices.EXT_LIGHTS_SYSTEM, value_down = 0.1, value_up = 0,	name = _('Headlight - Up'),		category = {_('Ins Collective Stick'), _('External Lights')}},
{down = ext_lights_commands.HeadLightPilotControl_EXT, up = ext_lights_commands.HeadLightPilotControl_EXT,	cockpit_device_id = devices.EXT_LIGHTS_SYSTEM, value_down = 0.3, value_up = 0,	name = _('Headlight - Left'),	category = {_('Ins Collective Stick'), _('External Lights')}},
{down = ext_lights_commands.HeadLightPilotControl_EXT, up = ext_lights_commands.HeadLightPilotControl_EXT,	cockpit_device_id = devices.EXT_LIGHTS_SYSTEM, value_down = 0.4, value_up = 0,	name = _('Headlight - Right'),	category = {_('Ins Collective Stick'), _('External Lights')}},


{down = ext_lights_commands.HeadlightControl,	cockpit_device_id = devices.EXT_LIGHTS_SYSTEM, value_down = -1.0, 	name = _('Headlight - Retract'),	category = {_('Left Forward Panel'), _('External Lights')}},
{down = ext_lights_commands.HeadlightControl,	cockpit_device_id = devices.EXT_LIGHTS_SYSTEM, value_down = 0.0, 	name = _('Headlight - Off'),		category = {_('Left Forward Panel'), _('External Lights')}},
{down = ext_lights_commands.HeadlightControl,	cockpit_device_id = devices.EXT_LIGHTS_SYSTEM, value_down = 1.0, 	name = _('Headlight - Control'),	category = {_('Left Forward Panel'), _('External Lights')}},


-- Circuit breakers ----------------------------
------------------------------------------------
{down = elec_commands.CB_FRAME_LEFT_EXT, up = elec_commands.CB_FRAME_LEFT_EXT, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1.0, value_up = 0.0,	name = _('All Left CBs ON'),	category = {_('CB Panels')}},
{down = elec_commands.CB_FRAME_RIGHT_EXT, up = elec_commands.CB_FRAME_RIGHT_EXT, cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1.0, value_up = 0.0,	name = _('All Right CBs ON'),	category = {_('CB Panels')}},

--ECSystem
{down = ecs_commands.CabinUnseal_EXT,                                                                 												cockpit_device_id = devices.ECS_INTERFACE,				value_down = 1,                        	name = _('Cabin Unseal Switch - ON'),													category = {_('EC System Control Panel')}},
{down = ecs_commands.CabinUnseal_EXT,	                                                             												cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0,                        	name = _('Cabin Unseal Switch - OFF'),													category = {_('EC System Control Panel')}},
{down = ecs_commands.CabinUnseal_ITER,                                                                												cockpit_device_id = devices.ECS_INTERFACE,				value_down = 1,                        	name = _('Cabin Unseal Switch - ON/OFF'),												category = {_('EC System Control Panel')}},
{down = ecs_commands.BlowdownConditioning_EXT,                                                                 										cockpit_device_id = devices.ECS_INTERFACE,				value_down = 1,                        	name = _('Blowdown Conditioning Switch - CONDITIONING'),								category = {_('EC System Control Panel')}},
{down = ecs_commands.BlowdownConditioning_EXT,	                                                             										cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0,                        	name = _('Blowdown Conditioning Switch - OFF'),											category = {_('EC System Control Panel')}},
{down = ecs_commands.BlowdownConditioning_EXT,                                                                 										cockpit_device_id = devices.ECS_INTERFACE,				value_down = -1,                        name = _('Blowdown Conditioning Switch - BLOWDOWN'),									category = {_('EC System Control Panel')}},
{down = ecs_commands.BlowdownConditioning_ITER,                                                                										cockpit_device_id = devices.ECS_INTERFACE,				value_down = 1,                        	name = _('Blowdown Conditioning Switch - CYCLE(UP)'),									category = {_('EC System Control Panel')}},
{down = ecs_commands.BlowdownConditioning_ITER,                                                                										cockpit_device_id = devices.ECS_INTERFACE,				value_down = -1,                       	name = _('Blowdown Conditioning Switch - CYCLE(DOWN)'),									category = {_('EC System Control Panel')}},
{down = ecs_commands.Filter_EXT,                                                                 													cockpit_device_id = devices.ECS_INTERFACE,				value_down = 1,                        	name = _('Filter Switch - ON'),															category = {_('EC System Control Panel')}},
{down = ecs_commands.Filter_EXT,	                                                             													cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0,                        	name = _('Filter Switch - OFF'),														category = {_('EC System Control Panel')}},
{down = ecs_commands.Filter_ITER,                                                                													cockpit_device_id = devices.ECS_INTERFACE,				value_down = 1,                        	name = _('Filter Switch - ON/OFF'),														category = {_('EC System Control Panel')}},
{down = ecs_commands.Heating_EXT,                                                                 													cockpit_device_id = devices.ECS_INTERFACE,				value_down = 1,                        	name = _('Heating Switch - HOT'),														category = {_('EC System Control Panel')}},
{down = ecs_commands.Heating_EXT,	                                                             													cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0,                        	name = _('Heating Switch - NORMAL'),													category = {_('EC System Control Panel')}},
{down = ecs_commands.Heating_ITER,                                                                													cockpit_device_id = devices.ECS_INTERFACE,				value_down = 1,                        	name = _('Heating Switch - HOT/NORMAL'),												category = {_('EC System Control Panel')}},
{down = ecs_commands.AutomaticHotCold_EXT,                                                                 											cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0.0,                       name = _('Automatic Hot Cold Switch - OFF'),											category = {_('EC System Control Panel')}},
{down = ecs_commands.AutomaticHotCold_EXT,	                                                             											cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0.1,                       name = _('Automatic Hot Cold Switch - COLD'),											category = {_('EC System Control Panel')}},
{down = ecs_commands.AutomaticHotCold_EXT,                                                                 											cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0.2,                       name = _('Automatic Hot Cold Switch - HOT'),											category = {_('EC System Control Panel')}},
{down = ecs_commands.AutomaticHotCold_EXT,                                                                 											cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0.3,                       name = _('Automatic Hot Cold Switch - AUTO'),											category = {_('EC System Control Panel')}},
{down = ecs_commands.AutomaticHotCold_ITER,                                                                											cockpit_device_id = devices.ECS_INTERFACE,				value_down = 1,                        	name = _('Automatic Hot Cold Switch - CYCLE(UP)'),										category = {_('EC System Control Panel')}},
{down = ecs_commands.AutomaticHotCold_ITER,                                                                											cockpit_device_id = devices.ECS_INTERFACE,				value_down = -1,                       	name = _('Automatic Hot Cold Switch - CYCLE(DOWN)'),									category = {_('EC System Control Panel')}},
{down = ecs_commands.Temperature_EXT,                                                                 												cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0.0,                       name = _('Temperature Selector - 5'),													category = {_('EC System Control Panel')}},
{down = ecs_commands.Temperature_EXT,	                                                             												cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0.1,                       name = _('Temperature Selector - 10'),													category = {_('EC System Control Panel')}},
{down = ecs_commands.Temperature_EXT,                                                                 												cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0.2,                       name = _('Temperature Selector - 15'),													category = {_('EC System Control Panel')}},
{down = ecs_commands.Temperature_EXT,                                                                 												cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0.3,                       name = _('Temperature Selector - 18'),													category = {_('EC System Control Panel')}},
{down = ecs_commands.Temperature_EXT,                                                                 												cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0.4,                       name = _('Temperature Selector - 20'),													category = {_('EC System Control Panel')}},
{down = ecs_commands.Temperature_EXT,	                                                             												cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0.5,                       name = _('Temperature Selector - 22'),													category = {_('EC System Control Panel')}},
{down = ecs_commands.Temperature_EXT,                                                                 												cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0.6,                       name = _('Temperature Selector - 24'),													category = {_('EC System Control Panel')}},
{down = ecs_commands.Temperature_EXT,                                                                 												cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0.7,                       name = _('Temperature Selector - 30'),													category = {_('EC System Control Panel')}},
{down = ecs_commands.Temperature_EXT,                                                                 												cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0.8,                       name = _('Temperature Selector - 35'),													category = {_('EC System Control Panel')}},
{down = ecs_commands.Temperature_EXT,	                                                             												cockpit_device_id = devices.ECS_INTERFACE,				value_down = 0.9,                       name = _('Temperature Selector - 40'),													category = {_('EC System Control Panel')}},
{down = ecs_commands.Temperature_EXT,                                                                 												cockpit_device_id = devices.ECS_INTERFACE,				value_down = 1.0,                       name = _('Temperature Selector - 50'),													category = {_('EC System Control Panel')}},
{down = ecs_commands.Temperature_ITER,																												cockpit_device_id = devices.ECS_INTERFACE,				value_down = 1,							name = _('Temperature Selector - CYCLE(UP)'),											category = {_('EC System Control Panel')}},
{down = ecs_commands.Temperature_ITER,																												cockpit_device_id = devices.ECS_INTERFACE,				value_down = -1,						name = _('Temperature Selector - CYCLE(DOWN)'),											category = {_('EC System Control Panel')}},

--PKP72M_interface
{pressed = pkp72m_interface_commands.PitchTrimKnob_ITER,																								cockpit_device_id = devices.PKP72M_INTERFACE,			value_pressed = 1,						name = _('Pitch Trim Knob PKP72M - CW'),														category = {_('Front Instrument Panel')}},
{pressed = pkp72m_interface_commands.PitchTrimKnob_ITER,																								cockpit_device_id = devices.PKP72M_INTERFACE,			value_pressed = -1,						name = _('Pitch Trim Knob PKP72M - CCW'),														category = {_('Front Instrument Panel')}},
{down = pkp72m_interface_commands.TestControl_EXT,							up = pkp72m_interface_commands.TestControl_EXT,							cockpit_device_id = devices.PKP72M_INTERFACE,	 		value_down = 1,	 	value_up = 0,		name = _('Test ADI Button'),															category = {_('Front Instrument Panel')}},
{down = pkp72m_interface_commands.GyroverticalSwitch_EXT,                                                                 							cockpit_device_id = devices.PKP72M_INTERFACE,			value_down = 1,                        	name = _('Gyrovertical Switch - 1'),													category = {_('Front Instrument Panel')}},
{down = pkp72m_interface_commands.GyroverticalSwitch_EXT,	                                                             							cockpit_device_id = devices.PKP72M_INTERFACE,			value_down = 0,                        	name = _('Gyrovertical Switch - 2'),													category = {_('Front Instrument Panel')}},
{down = pkp72m_interface_commands.GyroverticalSwitch_ITER,																							cockpit_device_id = devices.PKP72M_INTERFACE,			value_down = 1,							name = _('Gyrovertical Switch - 1/2'),													category = {_('Front Instrument Panel')}},


--UKT2
{																				pressed = ukt2_commands.PitchTrimKnob_ITER,																											cockpit_device_id = devices.UKT_2,						value_pressed = 1,						name = _('Pitch Trim Knob UKT-2 - CW'),														category = {_('Front Instrument Panel')}},
{																				pressed = ukt2_commands.PitchTrimKnob_ITER,																											cockpit_device_id = devices.UKT_2,						value_pressed = -1,						name = _('Pitch Trim Knob UKT-2 - CCW'),														category = {_('Front Instrument Panel')}},

-- Barometric Altimeter Pilot
{pressed = baroaltimeter_commands.CMD_ADJUST_PRESSURE_EXT, 																							cockpit_device_id = devices.BAROALT_P, 					value_pressed = 1,						name = _('Baro Pressure Pilot Knob - CW'),													category = {_('Front Instrument Panel')}},
{pressed = baroaltimeter_commands.CMD_ADJUST_PRESSURE_EXT, 																							cockpit_device_id = devices.BAROALT_P, 					value_pressed = -1,						name = _('Baro Pressure Pilot Knob - CCW'),													category = {_('Front Instrument Panel')}},


-- RMI2 Pilot
{																				down = rmi2_commands.MODE_LEFTSW_EXT,                  				                                           										cockpit_device_id = devices.RMI2_P,						value_down = 1,                     	name = _('Mode Switch Pilot -  '),															category = {_('Front Instrument Panel')}},
{																				down = rmi2_commands.MODE_LEFTSW_EXT,	                				                                            								cockpit_device_id = devices.RMI2_P,						value_down = 0,                     	name = _('Mode Switch Pilot - ARK1'),															category = {_('Front Instrument Panel')}},
{																				down = rmi2_commands.MODE_LEFTSW_ITER,                 				                                           										cockpit_device_id = devices.RMI2_P,						value_down = 1,                     	name = _('Mode Switch Pilot -  /ARK1'),														category = {_('Front Instrument Panel')}},
{																				down = rmi2_commands.MODE_RIGHTSW_EXT,                  				                                           									cockpit_device_id = devices.RMI2_P,						value_down = 1,                     	name = _('Mode Switch Pilot - ZK'),															category = {_('Front Instrument Panel')}},
{																				down = rmi2_commands.MODE_RIGHTSW_EXT,	                				                                            								cockpit_device_id = devices.RMI2_P,						value_down = 0,                     	name = _('Mode Switch Pilot - ARKU2'),														category = {_('Front Instrument Panel')}},
{																				down = rmi2_commands.MODE_RIGHTSW_ITER,                 				                                           									cockpit_device_id = devices.RMI2_P,						value_down = 1,                     	name = _('Mode Switch Pilot - ZK/ARKU2'),														category = {_('Front Instrument Panel')}},



-- Clock
{down = iCommandMechClock_LeftLever_Down, up = iCommandMechClock_LeftLever_Down_up,			name = _('Clock Left Knob - Push'),				category = {_('Instrument Panel')}},
{down = iCommandMechClock_LeftLever_Up,														name = _('Clock Left Knob - Pull'),				category = {_('Instrument Panel')}},
{pressed = iCommandMechClock_LeftLever_TurnRight,											name = _('Clock Left Knob - Rotate right'),		category = {_('Instrument Panel')}},
{pressed = iCommandMechClock_LeftLever_TurnLeft,												name = _('Clock Left Knob - Rotate left'),		category = {_('Instrument Panel')}},
{down = iCommandMechClock_RightLever_Down, up = iCommandMechClock_RightLever_Down_up,		name = _('Clock Right Knob - Push'),			category = {_('Instrument Panel')}},
{down = iCommandMechClock_RightLever_Rotate_left,											name = _('Clock Right Knob - Rotate left'),		category = {_('Instrument Panel')}},
{down = iCommandMechClock_RightLever_Rotate_right,											name = _('Clock Right Knob - Rotate right'),	category = {_('Instrument Panel')}},

------------------



-- Electric system
-- commented out lines are temporary commented
-- todo: restore to normal after coding clickable elements
-- Electric system AC

{down = elec_commands.ACGroundPowerITER,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('AC Ground Power Switch - ON/OFF'),		category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGroundPower,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('AC Ground Power Switch - ON'),		category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGroundPower,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('AC Ground Power Switch - OFF'),		category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGeneratorLeft,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('AC Left Generator - ON'),				category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGeneratorLeft,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('AC Left Generator - OFF'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGeneratorRight,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('AC Right Generator - ON'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGeneratorRight,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('AC Right Generator - OFF'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.Transformer115vMainBackup,	cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('AC Transformer 115v - Main'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.Transformer115vMainBackup,	cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('AC Transformer 115v - Neutral'),		category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.Transformer115vMainBackup,	cockpit_device_id = devices.ELEC_INTERFACE, value_down = -1,	name = _('AC Transformer 115v - Backup'),		category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.Transformer36vMainBackup,		cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('AC Transformer 36v - Main'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.Transformer36vMainBackup,		cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('AC Transformer 36v - Neutral'),		category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.Transformer36vMainBackup,		cockpit_device_id = devices.ELEC_INTERFACE, value_down = -1,	name = _('AC Transformer 36v - Backup'),		category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.GroundCheck,					cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('AC Ground Check - ON'),				category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.GroundCheck,					cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('AC Ground Check - OFF'),				category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.Rotary115vConverter,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('AC Rotary 115v Converter - ON'),		category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.Rotary115vConverter,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('AC Rotary 115v Converter - OFF'),		category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.Rotary36vConverter,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('AC Rotary 36v Converter - ON'),		category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.Rotary36vConverter,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('AC Rotary 36v Converter - OFF'),		category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.Transformer36vDIMMainBackup,	cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('DIM Transformer 36v - Main'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.Transformer36vDIMMainBackup,	cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('DIM Transformer 36v - Backup'),		category = {_('Electrical Control Panel'), _('AC Panel')}},

-- temp
{down = elec_commands.ACGangSwitcherSet,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,			name = _('AC Voltmeter switch - 0'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGangSwitcherSet,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.1,		name = _('AC Voltmeter switch - 1'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGangSwitcherSet,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.2,		name = _('AC Voltmeter switch - 2'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGangSwitcherSet,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.3,		name = _('AC Voltmeter switch - 3'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGangSwitcherSet,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.4,		name = _('AC Voltmeter switch - 4'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGangSwitcherSet,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.5,		name = _('AC Voltmeter switch - 5'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGangSwitcherSet,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.6,		name = _('AC Voltmeter switch - 6'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGangSwitcherSet,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.7,		name = _('AC Voltmeter switch - 7'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGangSwitcherSet,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.8,		name = _('AC Voltmeter switch - 8'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGangSwitcherSet,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.9,		name = _('AC Voltmeter switch - 9'),			category = {_('Electrical Control Panel'), _('AC Panel')}},
{down = elec_commands.ACGangSwitcherSet,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,			name = _('AC Voltmeter switch - 10'),			category = {_('Electrical Control Panel'), _('AC Panel')}},


-- Electric system DC
{down = elec_commands.DCGroundPower,					cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('DC Ground Power Switch - ON'),		category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.DCGroundPower,					cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('DC Ground Power Switch - OFF'),		category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.BatteryLeft,					cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('DC Left Battery - ON'),				category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.BatteryLeft,					cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('DC Left Battery - OFF'),				category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.BatteryRight,					cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('DC Right Battery - ON'),				category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.BatteryRight,					cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('DC Right Battery - OFF'),				category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.RectifierLeft,					cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('DC Left Rectifier - ON'),				category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.RectifierLeft,					cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('DC Left Rectifier - OFF'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.RectifierRight,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('DC Right Rectifier - ON'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.RectifierRight,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('DC Right Rectifier - OFF'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.DCGenerator,					cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('DC Starter-Generator - ON'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.DCGenerator,					cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('DC Starter-Generator - OFF'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.BatteryHeating,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('DC Battery Heating - ON'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.BatteryHeating,				cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('DC Battery Heating - OFF'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.NetworkToBatteries,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('DC Circuits to Batt switch - ON'),	category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.NetworkToBatteries,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('DC Circuits to Batt switch - OFF'),	category = {_('Electrical Control Panel'), _('DC Panel')}},

{down = elec_commands.NetworkToBatteriesCoverITER,		cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,	name = _('DC Power from BATT. Switch Cover - OPEN/CLOSE'),	category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.NetworkToBatteriesCover,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,		name = _('DC Power from BATT. Switch Cover - OPEN'),	category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.NetworkToBatteriesCover,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,		name = _('DC Power from BATT. Switch Cover - CLOSE'),	category = {_('Electrical Control Panel'), _('DC Panel')}},


-- temp
{down = elec_commands.DCGangSwitcherEXT,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0,			name = _('DC Voltmeter switch - 0'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.DCGangSwitcherEXT,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.1111111,	name = _('DC Voltmeter switch - 1'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.DCGangSwitcherEXT,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.2222222,	name = _('DC Voltmeter switch - 2'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.DCGangSwitcherEXT,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.3333333,	name = _('DC Voltmeter switch - 3'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.DCGangSwitcherEXT,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.4444444,	name = _('DC Voltmeter switch - 4'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.DCGangSwitcherEXT,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.5555555,	name = _('DC Voltmeter switch - 5'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.DCGangSwitcherEXT,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.6666666,	name = _('DC Voltmeter switch - 6'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.DCGangSwitcherEXT,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.7777777,	name = _('DC Voltmeter switch - 7'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.DCGangSwitcherEXT,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 0.8888888,	name = _('DC Voltmeter switch - 8'),			category = {_('Electrical Control Panel'), _('DC Panel')}},
{down = elec_commands.DCGangSwitcherEXT,			cockpit_device_id = devices.ELEC_INTERFACE, value_down = 1,			name = _('DC Voltmeter switch - 9'),			category = {_('Electrical Control Panel'), _('DC Panel')}},

--Fuel System
--{combos = {{key = '1', reformers = {'LCtrl','LAlt'}}},	down = fuel_commands.ValveTank1EXT,			cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 1,		name = _('Tank 1 valve Open/Close'),			category = {_('Fuel Control Panel')}},
{down = fuel_commands.ValveTank1,			cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 1,		name = _('Tank 1 valve Open'),					category = {_('Fuel Control Panel')}},
{down = fuel_commands.ValveTank1,			cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 0,		name = _('Tank 1 valve Close'),					category = {_('Fuel Control Panel')}},
{down = fuel_commands.ValveTank2,			cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 1,		name = _('Tank 2 valve Open'),					category = {_('Fuel Control Panel')}},
{down = fuel_commands.ValveTank2,			cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 0,		name = _('Tank 2 valve Close'),					category = {_('Fuel Control Panel')}},

{down = fuel_commands.ValveLeftEngine,		cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 1,		name = _('Left Engine fire valve Open'),		category = {_('Fuel Control Panel')}},
{down = fuel_commands.ValveLeftEngine,		cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 0,		name = _('Left Engine fire valve Close'),		category = {_('Fuel Control Panel')}},
{down = fuel_commands.ValveRightEngine,		cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 1,		name = _('Right Engine fire valve Open'),		category = {_('Fuel Control Panel')}},
{down = fuel_commands.ValveRightEngine,		cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 0,		name = _('Right Engine fire valve Close'),		category = {_('Fuel Control Panel')}},
{down = fuel_commands.ValveDelimiter,		cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 1,		name = _('Delimiter valve Open'),				category = {_('Fuel Control Panel')}},
{down = fuel_commands.ValveDelimiter,		cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 0,		name = _('Delimiter valve Close'),				category = {_('Fuel Control Panel')}},
{down = fuel_commands.ExtTank,				cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 1,		name = _('External tanks ON'),					category = {_('Fuel Control Panel')}},
{down = fuel_commands.ExtTank,				cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 0,		name = _('External tanks OFF'),					category = {_('Fuel Control Panel')}},
{down = fuel_commands.Tank4Pump,				cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 1,		name = _('Pump 4 tank ON'),						category = {_('Fuel Control Panel')}},
{down = fuel_commands.Tank4Pump,				cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 0,		name = _('Pump 4 tank OFF'),					category = {_('Fuel Control Panel')}},
{down = fuel_commands.Tank5Pump,				cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 1,		name = _('Pump 5 tank ON'),						category = {_('Fuel Control Panel')}},
{down = fuel_commands.Tank5Pump,				cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 0,		name = _('Pump 5 tank OFF'),					category = {_('Fuel Control Panel')}},
{down = fuel_commands.Tank1Pump,				cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 1,		name = _('Pump 1 tank ON'),						category = {_('Fuel Control Panel')}},
{down = fuel_commands.Tank1Pump,				cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 0,		name = _('Pump 1 tank OFF'),					category = {_('Fuel Control Panel')}},
{down = fuel_commands.Tank2Pump,				cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 1,		name = _('Pump 2 tank ON'),						category = {_('Fuel Control Panel')}},
{down = fuel_commands.Tank2Pump,				cockpit_device_id = devices.FUELSYS_INTERFACE, value_down = 0,		name = _('Pump 2 tank OFF'),					category = {_('Fuel Control Panel')}},

--Fire extinguisher
--1st queue
{up = fire_commands.ExtingiushLE1,			cockpit_device_id = devices.FIRE_EXTING_INTERFACE,	value_up = 0,		
down = fire_commands.ExtingiushLE1,																value_down = 1,		name = _('Extinguish Left Engine 1'),		category = {_('Fire Extinguisher Control Panel')}},
{up = fire_commands.ExtingiushRE1,			cockpit_device_id = devices.FIRE_EXTING_INTERFACE,	value_up = 0,		
down = fire_commands.ExtingiushRE1,																value_down = 1,		name = _('Extinguish Right Engine 1'),		category = {_('Fire Extinguisher Control Panel')}},
{up = fire_commands.ExtingiushAPU1,			cockpit_device_id = devices.FIRE_EXTING_INTERFACE,	value_up = 0,		
down = fire_commands.ExtingiushAPU1,															value_down = 1,		name = _('Extinguish APU 1'),				category = {_('Fire Extinguisher Control Panel')}},
{up = fire_commands.ExtingiushMRED1,			cockpit_device_id = devices.FIRE_EXTING_INTERFACE,	value_up = 0,		
down = fire_commands.ExtingiushMRED1,															value_down = 1,		name = _('Extinguish Main Reductor 1'),		category = {_('Fire Extinguisher Control Panel')}},
--2nd queue
{up = fire_commands.ExtingiushLE2,			cockpit_device_id = devices.FIRE_EXTING_INTERFACE,	value_up = 0,		
down = fire_commands.ExtingiushLE2,																value_down = 1,		name = _('Extinguish Left Engine 2'),		category = {_('Fire Extinguisher Control Panel')}},
{up = fire_commands.ExtingiushRE2,			cockpit_device_id = devices.FIRE_EXTING_INTERFACE,	value_up = 0,		
down = fire_commands.ExtingiushRE2,																value_down = 1,		name = _('Extinguish Right Engine 2'),		category = {_('Fire Extinguisher Control Panel')}},
{up = fire_commands.ExtingiushAPU2,			cockpit_device_id = devices.FIRE_EXTING_INTERFACE,	value_up = 0,		
down = fire_commands.ExtingiushAPU2,															value_down = 1,		name = _('Extinguish APU 2'),				category = {_('Fire Extinguisher Control Panel')}},
{up = fire_commands.ExtingiushMRED2,			cockpit_device_id = devices.FIRE_EXTING_INTERFACE,	value_up = 0,		
down = fire_commands.ExtingiushMRED2,															value_down = 1,		name = _('Extinguish Main Reductor 2'),		category = {_('Fire Extinguisher Control Panel')}},


-- Autopilot
{up = autopilot_commands.ButtonHonEXT,		cockpit_device_id = devices.AUTOPILOT,	value_up = 0,		
down = autopilot_commands.ButtonHonEXT,												value_down = 1,		name = _('Autopilot H on'),		category = {_('Autopilot (SAU-V24)')}},
{up = autopilot_commands.ButtonHoffEXT,		cockpit_device_id = devices.AUTOPILOT,	value_up = 0,		
down = autopilot_commands.ButtonHoffEXT,											value_down = 1,		name = _('Autopilot H off'),	category = {_('Autopilot (SAU-V24)')}},
{up = autopilot_commands.ButtonKonEXT,		cockpit_device_id = devices.AUTOPILOT,	value_up = 0,		
down = autopilot_commands.ButtonKonEXT,												value_down = 1,		name = _('Autopilot K on'),		category = {_('Autopilot (SAU-V24)')}},
{up = autopilot_commands.ButtonKoffEXT,		cockpit_device_id = devices.AUTOPILOT,	value_up = 0,		
down = autopilot_commands.ButtonKoffEXT,											value_down = 1,		name = _('Autopilot K off'),	category = {_('Autopilot (SAU-V24)')}},
{up = autopilot_commands.ButtonTonEXT,		cockpit_device_id = devices.AUTOPILOT,	value_up = 0,		
down = autopilot_commands.ButtonTonEXT,												value_down = 1,		name = _('Autopilot T on'),		category = {_('Autopilot (SAU-V24)')}},
{up = autopilot_commands.ButtonToffEXT,		cockpit_device_id = devices.AUTOPILOT,	value_up = 0,		
down = autopilot_commands.ButtonToffEXT,											value_down = 1,		name = _('Autopilot T off'),	category = {_('Autopilot (SAU-V24)')}},
{up = autopilot_commands.ButtonBonEXT,		cockpit_device_id = devices.AUTOPILOT,	value_up = 0,		
down = autopilot_commands.ButtonBonEXT,												value_down = 1,		name = _('Autopilot B on'),		category = {_('Autopilot (SAU-V24)')}},
{up = autopilot_commands.ButtonBoffEXT,		cockpit_device_id = devices.AUTOPILOT,	value_up = 0,		
down = autopilot_commands.ButtonBoffEXT,											value_down = 1,		name = _('Autopilot B off'),	category = {_('Autopilot (SAU-V24)')}},
{up = autopilot_commands.AutopilotOffEXT,	cockpit_device_id = devices.AUTOPILOT,	value_up = 0,		
down = autopilot_commands.AutopilotOffEXT,											value_down = 1,		name = _('Autopilot OFF'),		category = {_('Ins Cyclic Stick')}},


{up = autopilot_commands.HoverOnEXT,			cockpit_device_id = devices.AUTOPILOT,	value_up = 0,		
down = autopilot_commands.HoverOnEXT,													value_down = 1,				name = _('Autopilot Hover mode'),								category = {_('Autopilot (SAU-V24)')}},
{up = autopilot_commands.RouteHoverOffEXT,		cockpit_device_id = devices.AUTOPILOT,	value_up = 0,		
down = autopilot_commands.RouteHoverOffEXT,												value_down = 1,				name = _('Autopilot Hover/Route off'),							category = {_('Autopilot (SAU-V24)')}},
{up = autopilot_commands.RouteOnEXT,			cockpit_device_id = devices.AUTOPILOT,	value_up = 0,		
down = autopilot_commands.RouteOnEXT,													value_down = 1,				name = _('Autopilot Route mode'),								category = {_('Autopilot (SAU-V24)')}},

{up = autopilot_commands.HeightOffEXT,			cockpit_device_id = devices.AUTOPILOT,	value_up = 0,		
down = autopilot_commands.HeightOffEXT,													value_down = 1,				name = _('Autopilot Landing/Height off'),						category = {_('Autopilot (SAU-V24)')}},
{up = autopilot_commands.HeightOnEXT,			cockpit_device_id = devices.AUTOPILOT,	value_up = 0,		
 down = autopilot_commands.HeightOnEXT,													value_down = 1,				name = _('Autopilot Height mode'),								category = {_('Autopilot (SAU-V24)')}},
{down = autopilot_commands.SpeedOnEXT,			cockpit_device_id = devices.AUTOPILOT, 	value_down = 1,
 up = autopilot_commands.SpeedOnEXT,	                                                value_up = 0,     			name = _('Speed Stabilization On'),								category = {_('Autopilot (SAU-V24)')}},
{down = autopilot_commands.SpeedOffEXT,			cockpit_device_id = devices.AUTOPILOT, 	value_down = 1,	
 up = autopilot_commands.SpeedOffEXT,	                                                value_up = 0,     			name = _('Speed Stabilization Off'),		  					category = {_('Autopilot (SAU-V24)')}},
{pressed = autopilot_commands.RouteAngleAXIS,	cockpit_device_id = devices.AUTOPILOT, 	value_pressed = -0.2,		name = _('set the required heading angle - CCW/Decrease'),		category = {_('Autopilot (SAU-V24)')}},
{pressed = autopilot_commands.RouteAngleAXIS,	cockpit_device_id = devices.AUTOPILOT, 	value_pressed = 0.2,		name = _('set the required heading angle - CW/Increase'),		category = {_('Autopilot (SAU-V24)')}},

{down = autopilot_commands.RudderSignal, 	up = autopilot_commands.RudderSignal, 	cockpit_device_id = devices.AUTOPILOT,	value_down = 1, 		value_up = 0,				name = _('Autopilot Yaw Channel Rudder Align, button - ON/OFF'),								category = {_('Ins Rudder'), _('Flight Control')}},
														
--Helper AI
{up = helperai_commands.ShowMenu, 	down = helperai_commands.ShowMenu, 	cockpit_device_id = devices.HELPER_AI, value_up = 0, value_down = 1,	name = _('Show/Hide Menu'),	category = {_('Helper AI Commands')}},
{up = helperai_commands.MainWeapSwitch, 	down = helperai_commands.MainWeapSwitch, 	cockpit_device_id = devices.HELPER_AI, value_up = 0, value_down = 1,	name = _('Prepare Weapons Systems'),	category = {_('Helper AI Commands')}},
{up = helperai_commands.HeliControlEXT, down = helperai_commands.HeliControlEXT,	cockpit_device_id = devices.HELPER_AI, 	value_up = 0, value_down = 1,	name = _('Request Aircraft Control'),	category = {_('Helper AI Commands'), _('Multicrew')}},
{up = helperai_commands.Select_or_fireEXT, down = helperai_commands.Select_or_fireEXT,	cockpit_device_id = devices.HELPER_AI, 	value_up = 0, value_down = 1,	name = _('Select target with ASP-17/Order to fire'),	category = {_('Helper AI Commands')}},
{up = helperai_commands.CycleMissile_EXT,	down = helperai_commands.CycleMissile_EXT,		cockpit_device_id = devices.HELPER_AI, 	value_up = 0, value_down = 1,	name = _('Cycle Missile Type'),	category = {_('Helper AI Commands')}},
{up = helperai_commands.ToggleSubtitles_EXT,	down = helperai_commands.ToggleSubtitles_EXT,		cockpit_device_id = devices.HELPER_AI, 	value_up = 0, value_down = 1,	name = _('Toggle AI Subtitles ON/OFF'),	category = {_('Helper AI Commands')}},


--Map display (TEMP)
{down = map_display_commands.Power,		cockpit_device_id = devices.MAP_DISPLAY, value_down = 1,		name = _('Map display ON'),						category = {_('Map Display Commands')}},
{down = map_display_commands.Power,		cockpit_device_id = devices.MAP_DISPLAY, value_down = 0,		name = _('Map display OFF'),					category = {_('Map Display Commands')}},
{down = map_display_commands.Scale,		cockpit_device_id = devices.MAP_DISPLAY, value_down = 1,		name = _('Map display scale 10km'),				category = {_('Map Display Commands')}},
{down = map_display_commands.Scale,		cockpit_device_id = devices.MAP_DISPLAY, value_down = 0,		name = _('Map display scale 2km'),				category = {_('Map Display Commands')}},

--Map Lights
{down = map_display_commands.Lights_EXT, cockpit_device_id = devices.MAP_DISPLAY,			value_down = 1,                     	name = _('Map Lights Switch - BRIGHT'),									category = {_('Right Forward Panel'), _('Map Display Commands')}},
{down = map_display_commands.Lights_EXT, cockpit_device_id = devices.MAP_DISPLAY,			value_down = 0,                     	name = _('Map Lights Switch - OFF'),									category = {_('Right Forward Panel'), _('Map Display Commands')}},
{down = map_display_commands.Lights_EXT, cockpit_device_id = devices.MAP_DISPLAY,			value_down = -1,                     	name = _('Map Lights Switch - DIM'),									category = {_('Right Forward Panel'), _('Map Display Commands')}},
--Map (the rotary knobs for adjusting position)
{pressed = map_display_commands.HorAdj,	value_pressed = -0.2,	cockpit_device_id = devices.MAP_DISPLAY,	name = _('Set the horizontall position of the helicopter on the Map - CCW/Decrease'), category = {_('Map Display Commands')}},
{pressed = map_display_commands.HorAdj,	value_pressed = 0.2,	cockpit_device_id = devices.MAP_DISPLAY,	name = _('Set the horizontall position of the helicopter on the Map - CW/Increase'),  category = {_('Map Display Commands')}},
{pressed = map_display_commands.VertAdj,	value_pressed = -0.2,	cockpit_device_id = devices.MAP_DISPLAY,	name = _('Set the vertical position of the helicopter on the Map - CCW/Decrease'),	  category = {_('Map Display Commands')}},
{pressed = map_display_commands.VertAdj,	value_pressed = 0.2,	cockpit_device_id = devices.MAP_DISPLAY,	name = _('Set the vertical position of the helicopter on the Map - CCW/Increase'),	  category = {_('Map Display Commands')}},
-- Accelerometer
{down = G_Meter_commands.Command_AccelReset_EXT, up = G_Meter_commands.Command_AccelReset_EXT, cockpit_device_id = devices.G_Meter, value_down = 1, value_up = 0, name = _('Accelerometer Reset Button'), category = {_('Instrument Panel')}},

-- ARC-U2		
{down = ARC_U2_commands.CMD_ARC_U2_ON_OFF_EXT, 		up = ARC_U2_commands.CMD_ARC_U2_ON_OFF_EXT, 		cockpit_device_id = devices.ARC_U2, value_down = 1, value_up = 0, name = _('ARC-U2 POWER - ON/OFF'), category = {_('Left Side Panel')}},
{down = ARC_U2_commands.CMD_ARC_U2_FRAME_EXT_LEFT, 	up = ARC_U2_commands.CMD_ARC_U2_FRAME_EXT_LEFT, 	cockpit_device_id = devices.ARC_U2, value_down = -1,	value_up = 0, name = _('ARC-U2 Left RAMKA Right Switch - L position'), category = {_('Left Side Panel')}},
{down = ARC_U2_commands.CMD_ARC_U2_FRAME_EXT_RIGHT, up = ARC_U2_commands.CMD_ARC_U2_FRAME_EXT_RIGHT, 	cockpit_device_id = devices.ARC_U2, value_down = 1,	value_up = 0, name = _('ARC-U2 Left RAMKA Right Switch - P position'), category = {_('Left Side Panel')}},
{down = ARC_U2_commands.CMD_ARC_U2_SENS_EXT,  		up = ARC_U2_commands.CMD_ARC_U2_SENS_EXT, 			cockpit_device_id = devices.ARC_U2, value_down = 1,	value_up = 0, name = _('ARC-U2 Sensitivity Switch - MORE/LESS'), category = {_('Left Side Panel')}},
{down = ARC_U2_commands.CMD_ARC_U2_COMPASS_CONNECT_EXT,up = ARC_U2_commands.CMD_ARC_U2_COMPASS_CONNECT_EXT,cockpit_device_id = devices.ARC_U2,	value_down = 1,	value_up = 0, name = _('ARC-U2 Compass Selector Switch - COMPASS R-852–RADIOLINK–COMPASS R-828'), category = {_('Left Side Panel')}},

-- ARC-15
{pressed = arc15_commands.VOLUME_EXT,									cockpit_device_id = devices.ARC_15_PANEL_P, value_pressed = -0.2,				name = _('ARC-15 Volume Knob - CCW/Decrease'),						category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{pressed = arc15_commands.VOLUME_EXT,									cockpit_device_id = devices.ARC_15_PANEL_P, value_pressed = 0.2,				name = _('ARC-15 Volume Knob - CW/Increase'),						category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.TLF_TLG_ITER,									cockpit_device_id = devices.ARC_15_PANEL_P, value_down = 1.0,					name = _('ARC-15 Signal Mode Switch - TLF/TLG'),					category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.TLF_TLG_EXT,										cockpit_device_id = devices.ARC_15_PANEL_P, value_down = 1,						name = _('ARC-15 Signal Mode Switch - TLF'),						category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.TLF_TLG_EXT,										cockpit_device_id = devices.ARC_15_PANEL_P, value_down = 0,						name = _('ARC-15 Signal Mode Switch - TLG'),						category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.MODE_EXT,										cockpit_device_id = devices.ARC_15_PANEL_P, value_down = -1.0,					name = _('ARC-15 Mode Selector Switch - CCW'),						category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.MODE_EXT,										cockpit_device_id = devices.ARC_15_PANEL_P, value_down = 1.0,					name = _('ARC-15 Mode Selector Switch - CW'),						category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.LOOP_EXT,up = arc15_commands.LOOP_EXT, 			cockpit_device_id = devices.ARC_15_PANEL_P, value_down = 1.0, value_up = 0.0,	name = _('ARC-15 Loop Antenna Button'),								category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.BACKUP_100KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_P, value_down = -1.0,					name = _('ARC-15 Backup Frequency Dial 100 kHz Knob - Decrease'),	category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.BACKUP_100KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_P, value_down = 1.0,					name = _('ARC-15 Backup Frequency Dial 100 kHz Knob - Increase'),	category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.BACKUP_10KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_P, value_down = -1.0,					name = _('ARC-15 Backup Frequency Dial 10 kHz Knob - Decrease'),	category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.BACKUP_10KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_P, value_down = 1.0,					name = _('ARC-15 Backup Frequency Dial 10 kHz Knob - Increase'),	category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.BACKUP_1KHz_EXT,									cockpit_device_id = devices.ARC_15_PANEL_P, value_down = -1.0,					name = _('ARC-15 Backup Frequency Dial 1 kHz Knob - Decrease'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.BACKUP_1KHz_EXT,									cockpit_device_id = devices.ARC_15_PANEL_P, value_down = 1.0,					name = _('ARC-15 Backup Frequency Dial 1 kHz Knob - Increase'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.PRIMARY_100KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_P, value_down = -1.0,					name = _('ARC-15 Main Frequency Dial 100 kHz Knob - Decrease'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.PRIMARY_100KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_P, value_down = 1.0,					name = _('ARC-15 Main Frequency Dial 100 kHz Knob - Increase'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.PRIMARY_10KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_P, value_down = -1.0,					name = _('ARC-15 Main Frequency Dial 10 kHz Knob - Decrease'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.PRIMARY_10KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_P, value_down = 1.0,					name = _('ARC-15 Main Frequency Dial 10 kHz Knob - Increase'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.PRIMARY_1KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_P, value_down = -1.0,					name = _('ARC-15 Main Frequency Dial 1 kHz Knob - Decrease'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.PRIMARY_1KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_P, value_down = 1.0,					name = _('ARC-15 Main Frequency Dial 1 kHz Knob - Increase'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.DIAL_SELECT_ITER,								cockpit_device_id = devices.ARC_15_PANEL_P, value_down = 1.0,					name = _('ARC-15 Channel Selector - 1/2'),							category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.DIAL_SELECT_EXT,									cockpit_device_id = devices.ARC_15_PANEL_P, value_down = 0,						name = _('ARC-15 Channel Selector - 1'),							category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.DIAL_SELECT_EXT,									cockpit_device_id = devices.ARC_15_PANEL_P, value_down = 1,						name = _('ARC-15 Channel Selector- 2'),								category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.CONTROL_EXT, up = arc15_commands.CONTROL_EXT,	cockpit_device_id = devices.ARC_15_PANEL_P,	value_down = 1.0, value_up = 0.0,	name = _('ARC-15 Control Button'),									category = {_('Left Panel'), _('ARC-15 Control Panel')}},

-- Intercom Panels -----------------------------
------------------------------------------------
{pressed = SPU_8_Mi24_commands.CMD_SPU8_MAIN_VOLUME_EXT, value_pressed = -0.2,	cockpit_device_id = devices.SPU_8,	name = _('SPU-8 Main Volume Knob - CCW/Decrease'),			category = {_('SPU-8 Intercom Panels')}},
{pressed = SPU_8_Mi24_commands.CMD_SPU8_MAIN_VOLUME_EXT, value_pressed = 0.2,	cockpit_device_id = devices.SPU_8,	name = _('SPU-8 Main Volume Knob - CW/Increase'),			category = {_('SPU-8 Intercom Panels')}},
{pressed = SPU_8_Mi24_commands.CMD_SPU8_RADIO_VOLUME_EXT,value_pressed = -0.2,	cockpit_device_id = devices.SPU_8,	name = _('SPU-8 Listening Volume Knob - CCW/Decrease'),		category = {_('SPU-8 Intercom Panels')}},
{pressed = SPU_8_Mi24_commands.CMD_SPU8_RADIO_VOLUME_EXT,value_pressed = 0.2,	cockpit_device_id = devices.SPU_8,	name = _('SPU-8 Listening Volume Knob - CW/Increase'),		category = {_('SPU-8 Intercom Panels')}},
{down = SPU_8_Mi24_commands.CMD_SPU8_MODE_ITER,			 value_down = -0.2,   	cockpit_device_id = devices.SPU_8,	name = _('SPU-8 Radio Source Select Rotary - CCW/Left'),	category = {_('SPU-8 Intercom Panels')}},
{down = SPU_8_Mi24_commands.CMD_SPU8_MODE_ITER,			 value_down = 0.3,   	cockpit_device_id = devices.SPU_8,	name = _('SPU-8 Radio Source Select Rotary - CW/Right'),	category = {_('SPU-8 Intercom Panels')}},
{down = SPU_8_Mi24_commands.CMD_SPU8_ICS_RADIO_ITER,	 value_down = 1.0,		cockpit_device_id = devices.SPU_8,	name = _('SPU-8 Mode Switch - RADIO/ICS'),					category = {_('SPU-8 Intercom Panels')}},	
{down = SPU_8_Mi24_commands.CMD_SPU8_ICS_RADIO_EXT,		 value_down = 0.0,		cockpit_device_id = devices.SPU_8,	name = _('SPU-8 Mode Switch - RADIO'),						category = {_('SPU-8 Intercom Panels')}},
{down = SPU_8_Mi24_commands.CMD_SPU8_ICS_RADIO_EXT,		 value_down = 1.0,		cockpit_device_id = devices.SPU_8,	name = _('SPU-8 Mode Switch - ICS'),						category = {_('SPU-8 Intercom Panels')}},
{down = SPU_8_Mi24_commands.CMD_SPU8_NETWORK_ITER,		 value_down = 1.0,		cockpit_device_id = devices.SPU_8, 	name = _('SPU-8 Net Selector - 1/2'),						category = {_('SPU-8 Intercom Panels')}},	
{down = SPU_8_Mi24_commands.CMD_SPU8_NETWORK_EXT,		 value_down = 1,		cockpit_device_id = devices.SPU_8, 	name = _('SPU-8 Net Selector - 1'),							category = {_('SPU-8 Intercom Panels')}},	
{down = SPU_8_Mi24_commands.CMD_SPU8_NETWORK_EXT,		 value_down = 0,		cockpit_device_id = devices.SPU_8, 	name = _('SPU-8 Net Selector - 2'),							category = {_('SPU-8 Intercom Panels')}},	
{down = SPU_8_Mi24_commands.CMD_SPU8_MODE_EXT,           value_down = 0,		cockpit_device_id = devices.SPU_8, 	name = _('SPU-8 Radio Selector - R-863'),					category = {_('SPU-8 Intercom Panels')}},
{down = SPU_8_Mi24_commands.CMD_SPU8_MODE_EXT,           value_down = 0.2,		cockpit_device_id = devices.SPU_8, 	name = _('SPU-8 Radio Selector - VHF'),						category = {_('SPU-8 Intercom Panels')}},
{down = SPU_8_Mi24_commands.CMD_SPU8_MODE_EXT,           value_down = 0.4,		cockpit_device_id = devices.SPU_8, 	name = _('SPU-8 Radio Selector - R-828'),					category = {_('SPU-8 Intercom Panels')}},
{down = SPU_8_Mi24_commands.CMD_SPU8_MODE_EXT,           value_down = 0.6,		cockpit_device_id = devices.SPU_8, 	name = _('SPU-8 Radio Selector - YADRO'),					category = {_('SPU-8 Intercom Panels')}},
{down = SPU_8_Mi24_commands.CMD_SPU8_MODE_EXT,           value_down = 0.8,		cockpit_device_id = devices.SPU_8, 	name = _('SPU-8 Radio Selector - ARK-15'),					category = {_('SPU-8 Intercom Panels')}},
{down = SPU_8_Mi24_commands.CMD_SPU8_MODE_EXT,           value_down = 1.0,		cockpit_device_id = devices.SPU_8, 	name = _('SPU-8 Radio Selector - ARK-U2'),					category = {_('SPU-8 Intercom Panels')}},								
	
-- IFF Transponder-----------------------------
{down = IFF_6201_commands.CMD_IFF_Erase_BtnCover_EXT,		cockpit_device_id = devices.IFF,	value_down = 1,		name = _('IFF Transponder Erase Button Cover - OPEN/CLOSE'),		category = {_('Left Side Panel'), _('IFF Transponder')}},
{down = IFF_6201_commands.CMD_IFF_Erase_Btn, up = IFF_6201_commands.CMD_IFF_Erase_Btn,	cockpit_device_id = devices.IFF,	value_down = 1, value_up = 0,		name = _('IFF Transponder Erase Button'),		category = {_('Left Side Panel'), _('IFF Transponder')}},
{down = IFF_6201_commands.CMD_IFF_Disaster_SwCover_EXT,		cockpit_device_id = devices.IFF,	value_down = 1,		name = _('IFF Transponder Disaster Switch Cover - OPEN/CLOSE'),		category = {_('Left Side Panel'), _('IFF Transponder')}},
{down = IFF_6201_commands.CMD_IFF_Disaster_Sw_EXT,			cockpit_device_id = devices.IFF,	value_down = 1,		name = _('IFF Transponder Disaster Switch - ON/OFF'),				category = {_('Left Side Panel'), _('IFF Transponder')}},
{down = IFF_6201_commands.CMD_IFF_1_2_EXT,					cockpit_device_id = devices.IFF,	value_down = 1,		name = _('IFF Transponder Device Mode Switch - 1/2'),				category = {_('Left Side Panel'), _('IFF Transponder')}},
{down = IFF_6201_commands.CMD_IFF_Device_Sw_EXT,			cockpit_device_id = devices.IFF,	value_down = 1,		name = _('IFF Transponder Device Selector Switch - WORK/RESERVE'),	category = {_('Left Side Panel'), _('IFF Transponder')}},
{down = IFF_6201_commands.CMD_IFF_Mode_Sw_EXT,				cockpit_device_id = devices.IFF,	value_down = 1,		name = _('IFF Transponder Mode Selector Switch - CW/Right'),		category = {_('Left Side Panel'), _('IFF Transponder')}},
{down = IFF_6201_commands.CMD_IFF_Mode_Sw_EXT,				cockpit_device_id = devices.IFF,	value_down = -1,	name = _('IFF Transponder Mode Selector Switch - CCW/Left'),		category = {_('Left Side Panel'), _('IFF Transponder')}},
{down = IFF_6201_commands.CMD_IFF_Power_Sw_EXT,				cockpit_device_id = devices.IFF,	value_down = 1,		name = _('IFF Transponder Power Switch - CCW/Left'),				category = {_('Left Side Panel'), _('IFF Transponder')}},

-- Signal Flare
{down = signal_flares_commands.CMD_Cassette1_Power_EXT,		cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Signal Flare Dispenser Cassette 1 Power Switch - ON/OFF'),	category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_Cassette1_Power,			cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Signal Flare Dispenser Cassette 1 Power Switch - ON'),		category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_Cassette1_Power,			cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 0,		name = _('EKSR-46 Signal Flare Dispenser Cassette 1 Power Switch - OFF'),		category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette1_RED_EXT,	cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 1 Red Signal Flare Launch Button - ON/OFF'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette1_RED,		cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 1 Red Signal Flare Launch Button - ON'),				category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette1_RED,		cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 0,		name = _('EKSR-46 Cassette 1 Red Signal Flare Launch Button - OFF'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette1_GREEN_EXT,	cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 1 Green Signal Flare Launch Button - ON/OFF'),		category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette1_GREEN,		cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 1 Green Signal Flare Launch Button - ON'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette1_GREEN,		cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 0,		name = _('EKSR-46 Cassette 1 Green Signal Flare Launch Button - OFF'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette1_YELLOW_EXT,cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 1 Yellow Signal Flare Launch Button - ON/OFF'),		category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette1_YELLOW,	cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 1 Yellow Signal Flare Launch Button - ON'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette1_YELLOW,	cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 0,		name = _('EKSR-46 Cassette 1 Yellow Signal Flare Launch Button - OFF'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette1_WHITE_EXT,	cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 1 White Signal Flare Launch Button - ON/OFF'),		category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette1_WHITE,		cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 1 White Signal Flare Launch Button - ON'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette1_WHITE,		cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 0,		name = _('EKSR-46 Cassette 1 White Signal Flare Launch Button - OFF'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_Cassette2_Power_EXT,		cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Signal Flare Dispenser Cassette 2 Power Switch - ON/OFF'),	category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_Cassette2_Power,			cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Signal Flare Dispenser Cassette 2 Power Switch - ON'),		category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_Cassette2_Power,			cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 0,		name = _('EKSR-46 Signal Flare Dispenser Cassette 2 Power Switch - OFF'),		category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette2_RED_EXT,	cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 2 Red Signal Flare Launch Button - ON/OFF'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette2_RED,		cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 2 Red Signal Flare Launch Button - ON'),				category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette2_RED,		cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 0,		name = _('EKSR-46 Cassette 2 Red Signal Flare Launch Button - OFF'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette2_GREEN_EXT,	cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 2 Green Signal Flare Launch Button - ON/OFF'),		category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette2_GREEN,		cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 2 Green Signal Flare Launch Button - ON'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette2_GREEN,		cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 0,		name = _('EKSR-46 Cassette 2 Green Signal Flare Launch Button - OFF'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette2_YELLOW_EXT,cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 2 Yellow Signal Flare Launch Button - ON/OFF'),		category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette2_YELLOW,	cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 2 Yellow Signal Flare Launch Button - ON'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette2_YELLOW,	cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 0,		name = _('EKSR-46 Cassette 2 Yellow Signal Flare Launch Button - OFF'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette2_WHITE_EXT,	cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 2 White Signal Flare Launch Button - ON/OFF'),		category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette2_WHITE,		cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 1,		name = _('EKSR-46 Cassette 2 White Signal Flare Launch Button - ON'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},
{down = signal_flares_commands.CMD_drop_Cassette2_WHITE,		cockpit_device_id = devices.SIGNAL_FLARES,	value_down = 0,		name = _('EKSR-46 Cassette 2 White Signal Flare Launch Button - OFF'),			category = {_('Left Side Panel'), _('Signal Flare Dispenser')}},

-- PU-38 ( heading systen "Greben")
{down = greben_commands.MATCH_EXT,    up = greben_commands.MATCH_EXT,	cockpit_device_id = devices.GREBEN,	value_down = 1.0, value_up = 0.0,	name = _('Greben Match Button'),				category = {_('Left Side Panel'), _('PU-38 Panel')}},
{down = greben_commands.SETUP_OPER_ITER,  								cockpit_device_id = devices.GREBEN,	value_down = 1.0, 					name = _('mode SETUP/OPER'),					category = {_('Left Side Panel'), _('PU-38 Panel')}},
{down = greben_commands.MODE_EXT,  										cockpit_device_id = devices.GREBEN,	value_down = 1.0, 					name = _('mode ZK/GPK/MK - ZK'),				category = {_('Left Side Panel'), _('PU-38 Panel')}},
{down = greben_commands.MODE_EXT,  										cockpit_device_id = devices.GREBEN,	value_down = 0.0, 					name = _('mode ZK/GPK/MK - GPK'),				category = {_('Left Side Panel'), _('PU-38 Panel')}},
{down = greben_commands.MODE_EXT,  										cockpit_device_id = devices.GREBEN,	value_down =-1.0, 					name = _('mode ZK/GPK/MK - MK'),				category = {_('Left Side Panel'), _('PU-38 Panel')}},
{pressed = greben_commands.LATITUDE_EXT,  								cockpit_device_id = devices.GREBEN,	value_pressed = 0.1, 				name = _('Set Latitude Knob - CW/Increase'),	category = {_('Left Side Panel'), _('PU-38 Panel')}},
{pressed = greben_commands.LATITUDE_EXT,  								cockpit_device_id = devices.GREBEN,	value_pressed = -0.1, 				name = _('Set Latitude Knob - CCW/Decrease'),	category = {_('Left Side Panel'), _('PU-38 Panel')}},

-- Recorder MC 61
{down = RecorderMC61_commands.CMD_Power_EXT,		cockpit_device_id = devices.Recorder_MC61,	value_down = 1,			name = _('Recorder MC-61 Power Switch - ON/OFF'),			category = {_('Left Side Panel'), _('Recorder MC-61')}},
{pressed = RecorderMC61_commands.CMD_LightRst_EXT,	cockpit_device_id = devices.Recorder_MC61,	value_pressed = 0.2,	name = _('Recorder MC-61 Brightness Knob - CW/Increase'),	category = {_('Left Side Panel'), _('Recorder MC-61')}},
{pressed = RecorderMC61_commands.CMD_LightRst_EXT,	cockpit_device_id = devices.Recorder_MC61,	value_pressed = -0.2,	name = _('Recorder MC-61 Brightness Knob - CCW/Decrease'),	category = {_('Left Side Panel'), _('Recorder MC-61')}},

{down = RecorderMC61_commands.CMD_Auto_Work_EXT,	cockpit_device_id = devices.Recorder_MC61,	value_down = 1,			name = _('Recorder MC-61 Operating Mode Switch - UP/DOWN'),			category = {_('Left Side Panel'), _('Recorder MC-61')}},
{down = RecorderMC61_commands.CMD_Laryngophone_EXT,		cockpit_device_id = devices.Recorder_MC61,	value_down = 1,		name = _('Recorder MC-61 Microphone Selector Switch - UP/DOWN'),	category = {_('Left Side Panel'), _('Recorder MC-61')}},

-- Radio R-863
{pressed = r863_commands.VOLUME_ITER,  		cockpit_device_id = devices.R_863, value_pressed = -0.2,	name = _('Radio R-863 Volume Knob - CCW/Decrease'),					category = {_('Left Console'), _('Radio R-863')}},
{pressed = r863_commands.VOLUME_ITER,  		cockpit_device_id = devices.R_863, value_pressed = 0.2,		name = _('Radio R-863 Volume Knob - CW/Increase'),					category = {_('Left Console'), _('Radio R-863')}},
{down = r863_commands.SQUELCH_ITER,	  		cockpit_device_id = devices.R_863, value_down = 1,			name = _('Radio R-863 Squelch Switch - ON/OFF'),					category = {_('Left Console'), _('Radio R-863')}},
{down = r863_commands.SQUELCH,		  		cockpit_device_id = devices.R_863, value_down = 1,			name = _('Radio R-863 Squelch Switch - ON'),						category = {_('Left Console'), _('Radio R-863')}},
{down = r863_commands.SQUELCH,		  		cockpit_device_id = devices.R_863, value_down = 0,			name = _('Radio R-863 Squelch Switch - OFF'),						category = {_('Left Console'), _('Radio R-863')}},
{down = r863_commands.POWER_ITER,	  		cockpit_device_id = devices.R_863, value_down = 1,			name = _('Radio R-863 ARC Switch - ON/OFF'),						category = {_('Left Console'), _('Radio R-863')}},
{down = r863_commands.POWER,			  	cockpit_device_id = devices.R_863, value_down = 1,			name = _('Radio R-863 ARC Switch - ON'),							category = {_('Left Console'), _('Radio R-863')}},
{down = r863_commands.POWER,			  	cockpit_device_id = devices.R_863, value_down = 0,			name = _('Radio R-863 ARC Switch - OFF'),							category = {_('Left Console'), _('Radio R-863')}},
{down = r863_commands.EMERG_RCV_ITER,  		cockpit_device_id = devices.R_863, value_down = 1,			name = _('Radio R-863 Emergency Receiver Switch - ON/OFF'),			category = {_('Left Console'), _('Radio R-863')}},
{down = r863_commands.EMERG_RCV,		  	cockpit_device_id = devices.R_863, value_down = 1,			name = _('Radio R-863 Emergency Receiver Switch - ON'),				category = {_('Left Console'), _('Radio R-863')}},
{down = r863_commands.EMERG_RCV,		  	cockpit_device_id = devices.R_863, value_down = 0,			name = _('Radio R-863 Emergency Receiver Switch - OFF'),			category = {_('Left Console'), _('Radio R-863')}},
{down = r863_commands.AM_FM_ITER,  	  		cockpit_device_id = devices.R_863, value_down = 1,			name = _('Radio R-863 Frequency Band Selector - FM/AM'),			category = {_('Left Console'), _('Radio R-863')}},
{down = r863_commands.AM_FM,		  	  	cockpit_device_id = devices.R_863, value_down = 1,			name = _('Radio R-863 Frequency Band Selector - FM'),				category = {_('Left Console'), _('Radio R-863')}},
{down = r863_commands.AM_FM,		  	  	cockpit_device_id = devices.R_863, value_down = 0,			name = _('Radio R-863 Frequency Band Selector - AM'),				category = {_('Left Console'), _('Radio R-863')}},
{down = r863_commands.CHANNEL_SEL_ITER,		cockpit_device_id = devices.R_863, value_down = 1,			name = _('Radio R-863 Channel Selector - Next'),					category = {_('Left Console'), _('Radio R-863')}},
{down = r863_commands.CHANNEL_SEL_ITER,		cockpit_device_id = devices.R_863, value_down = -1,			name = _('Radio R-863 Channel Selector - Previous'),				category = {_('Left Console'), _('Radio R-863')}},

-- R-828
{down = iCommandPlane_R_828_Channel_next,																		name = _('Radio R-828 Channel Selector - Next'),		category = {_('Left Side Panel'), _('Radio R-828')}},
{down = iCommandPlane_R_828_Channel_prevous,																	name = _('Radio R-828 Channel Selector - Previous'),	category = {_('Left Side Panel'), _('Radio R-828')}},
{down = iCommandPlane_R_828_Noise_Reductor_on_off,																name = _('Radio R-828 Squelch Switch - ON/OFF'),		category = {_('Left Side Panel'), _('Radio R-828')}},
{down = eucalypt_commands.NOISE_REDUCTOR_ON_OFF2_EXT, cockpit_device_id = devices.EUCALYPT_M24,	value_down = 1,	name = _('Radio R-828 Squelch Switch - ON'),			category = {_('Left Side Panel'), _('Radio R-828')}},
{down = eucalypt_commands.NOISE_REDUCTOR_ON_OFF2_EXT, cockpit_device_id = devices.EUCALYPT_M24,	value_down = 0,	name = _('Radio R-828 Squelch Switch - OFF'),			category = {_('Left Side Panel'), _('Radio R-828')}},
{down = iCommandPlane_R_828_ASU, up = iCommandPlane_R_828_ASU_up,												name = _('Radio R-828 Tuner Button'),					category = {_('Left Side Panel'), _('Radio R-828')}},
{down = iCommandPlane_R_828_Power_on_off,																		name = _('Radio R-828 Power Switch - ON/OFF'),			category = {_('Left Side Panel'), _('Radio R-828')}},
{down = eucalypt_commands.POWER_ON_OFF2_EXT,		 cockpit_device_id = devices.EUCALYPT_M24,	value_down = 1,	name = _('Radio R-828 Power Switch - ON'),				category = {_('Left Side Panel'), _('Radio R-828')}},
{down = eucalypt_commands.POWER_ON_OFF2_EXT,		 cockpit_device_id = devices.EUCALYPT_M24,	value_down = 0,	name = _('Radio R-828 Power Switch - OFF'),				category = {_('Left Side Panel'), _('Radio R-828')}},
{pressed = iCommandPlane_R_828_volume_up,																		name = _('Radio R-828 Volume Knob - CW/Increase'),		category = {_('Left Side Panel'), _('Radio R-828')}},
{pressed = iCommandPlane_R_828_volume_down,																		name = _('Radio R-828 Volume Knob - CCW/Decrease'),		category = {_('Left Side Panel'), _('Radio R-828')}},

-- JADRO
{down = jadro_commands.POWER_ITER,		cockpit_device_id = devices.JADRO_1I,	value_down = 1.0,		name = _('Jadro-1A Power Switch - ON/OFF'),							category = {_('Right Triangular Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.POWER_EXT,		cockpit_device_id = devices.JADRO_1I,	value_down = 1,			name = _('Jadro-1A Power Switch - ON'),								category = {_('Right Triangular Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.POWER_EXT,		cockpit_device_id = devices.JADRO_1I,	value_down = 0,			name = _('Jadro-1A Power Switch - OFF'),							category = {_('Right Triangular Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.MODE_ITER,		cockpit_device_id = devices.JADRO_1I,	value_down = -1.0,		name = _('Radio Jadro-1A Mode Selector Switch - CCW/Left'),			category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.MODE_ITER,		cockpit_device_id = devices.JADRO_1I,	value_down = 1.0,		name = _('Radio Jadro-1A Mode Selector Switch - CW/Right'),			category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.MODE_EXT,		cockpit_device_id = devices.JADRO_1I,	value_down = 0.0,		name = _('Radio Jadro-1A Mode Selector Switch - OFF'),				category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.MODE_EXT,		cockpit_device_id = devices.JADRO_1I,	value_down = 0.1,		name = _('Radio Jadro-1A Mode Selector Switch - OM'),				category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.MODE_EXT,		cockpit_device_id = devices.JADRO_1I,	value_down = 0.2,		name = _('Radio Jadro-1A Mode Selector Switch - AM'),				category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.FREQ_1MHZ,		cockpit_device_id = devices.JADRO_1I,	value_down = -0.1,		name = _('Radio Jadro-1A Frequency Dial 1MHz Knob - Increase'),		category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.FREQ_1MHZ,		cockpit_device_id = devices.JADRO_1I,	value_down = 0.1,		name = _('Radio Jadro-1A Frequency Dial 1MHz Knob - Decrease'),		category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.FREQ_100KHZ,		cockpit_device_id = devices.JADRO_1I,	value_down = -0.1,		name = _('Radio Jadro-1A Frequency Dial 100kHz Knob - Decrease'),	category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.FREQ_100KHZ,		cockpit_device_id = devices.JADRO_1I,	value_down = 0.1,		name = _('Radio Jadro-1A Frequency Dial 100kHz Knob - Increase'),	category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.FREQ_10KHZ,		cockpit_device_id = devices.JADRO_1I,	value_down = -0.1,		name = _('Radio Jadro-1A Frequency Dial 10kHz Knob - Decrease'),	category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.FREQ_10KHZ,		cockpit_device_id = devices.JADRO_1I,	value_down = 0.1,		name = _('Radio Jadro-1A Frequency Dial 10kHz Knob - Increase'),	category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.FREQ_1KHZ,		cockpit_device_id = devices.JADRO_1I,	value_down = -0.1,		name = _('Radio Jadro-1A Frequency Dial 1kHz Knob - Decrease'),		category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.FREQ_1KHZ,		cockpit_device_id = devices.JADRO_1I,	value_down = 0.1,		name = _('Radio Jadro-1A Frequency Dial 1kHz Knob - Increase'),		category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.FREQ_100HZ,		cockpit_device_id = devices.JADRO_1I,	value_down = -0.1,		name = _('Radio Jadro-1A Frequency Dial 100Hz Knob - Decrease'),	category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.FREQ_100HZ,		cockpit_device_id = devices.JADRO_1I,	value_down = 0.1,		name = _('Radio Jadro-1A Frequency Dial 100Hz Knob - Increase'),	category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{pressed = jadro_commands.SQUELCH_ITER,	cockpit_device_id = devices.JADRO_1I,	value_pressed = -0.1,	name = _('Radio Jadro-1A Squelch Switch - Decrease'),				category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{pressed = jadro_commands.SQUELCH_ITER,	cockpit_device_id = devices.JADRO_1I,	value_pressed = 0.1,	name = _('Radio Jadro-1A Squelch Switch - Increase'),				category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{pressed = jadro_commands.VOLUME_ITER,	cockpit_device_id = devices.JADRO_1I,	value_pressed = -1.0,	name = _('Radio Jadro-1A Volume Knob - CCW/Decrease'),				category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{pressed = jadro_commands.VOLUME_ITER,	cockpit_device_id = devices.JADRO_1I,	value_pressed = 1.0,	name = _('Radio Jadro-1A Volume Knob - CW/Increase'),				category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},
{down = jadro_commands.CTL_EXT, up = jadro_commands.CTL_EXT,	cockpit_device_id = devices.JADRO_1I,	value_down = 1.0, value_up = 0.0,	name = _('Radio Jadro-1A Control Button'),	category = {_('Left Auxiliary Panel'), _('Radio Jadro-1A')}},

-- Ri-65
{down = RI65_commands.Command_RI_Mi24_Off_EXT,    up = RI65_commands.Command_RI_Mi24_Off_EXT,	cockpit_device_id = devices.VMS,	value_down = 1.0, value_up = 0.0,	name = _('RI-65 OFF Button'),					category = {_('Left Side Panel'), _('RI-65 Panel')}},
{down = RI65_commands.Command_RI_Mi24_Repeat_EXT, up = RI65_commands.Command_RI_Mi24_Repeat_EXT,	cockpit_device_id = devices.VMS,	value_down = 1.0, value_up = 0.0,	name = _('RI-65 Repeat Button'),				category = {_('Left Side Panel'), _('RI-65 Panel')}},
{down = RI65_commands.Command_RI_Mi24_Check_EXT,  up = RI65_commands.Command_RI_Mi24_Check_EXT,	cockpit_device_id = devices.VMS,	value_down = 1.0, value_up = 0.0,	name = _('RI-65 Check Button'),					category = {_('Left Side Panel'), _('RI-65 Panel')}},

-- SPUU-52
{down = spuu_commands.On_Off_ITER,											cockpit_device_id = devices.SPUU_52,	value_down = 1.0,						name = _('SPUU-52 Power Switch - ON/OFF'),				category = {_('Left Console'), _('SPUU-52')}},
{down = spuu_commands.On_Off_EXT,											cockpit_device_id = devices.SPUU_52,	value_down = 1,							name = _('SPUU-52 Power Switch - ON'),					category = {_('Left Console'), _('SPUU-52')}},
{down = spuu_commands.On_Off_EXT,											cockpit_device_id = devices.SPUU_52,	value_down = 0,							name = _('SPUU-52 Power Switch - OFF'),					category = {_('Left Console'), _('SPUU-52')}},
{down = spuu_commands.switchUp_EXT, 	up = spuu_commands.switchUp_EXT, 	cockpit_device_id = devices.SPUU_52,	value_down = -1, 		value_up = 0,	name = _('SPUU-52 Test Switch - t'),					category = {_('Left Console'), _('SPUU-52')}},
{down = spuu_commands.switchDown_EXT, 	up = spuu_commands.switchDown_EXT, 	cockpit_device_id = devices.SPUU_52,	value_down = 1, 		value_up = 0,	name = _('SPUU-52 Test Switch - P'),					category = {_('Left Console'), _('SPUU-52')}},
{pressed = spuu_commands.control_ITER, 										cockpit_device_id = devices.SPUU_52,	value_pressed = -0.5,					name = _('SPUU-52 Test Adjustment Knob - CCW/Left'),	category = {_('Left Console'), _('SPUU-52')}},
{pressed = spuu_commands.control_ITER, 										cockpit_device_id = devices.SPUU_52,	value_pressed = 0.5,					name = _('SPUU-52 Test Adjustment Knob - CW/Right'),	category = {_('Left Console'), _('SPUU-52')}},

-- pilot door:
{down = cockpit_mechanics_commands.Command_CPT_MECH_Door_EXT, value_down = 1, cockpit_device_id = devices.CPT_MECH, name = _('Open/Close Cockpit Door'),	  category = _('Systems')},
-- left, right cargo doors:
{down = cockpit_mechanics_commands.Command_CPT_MECH_LeftMainDoor,  value_down = 1,	cockpit_device_id = devices.CPT_MECH,	name = _('Open/Close Left Door'),category = _('Systems')},
{down = cockpit_mechanics_commands.Command_CPT_MECH_RightMainDoor, value_down = 1,	cockpit_device_id = devices.CPT_MECH,	name = _('Open/Close Right Door'),category = _('Systems')},

-- Anti Ice System
{down = AntiIceSys_commands.ANTIICE_ManAuto_EXT,   cockpit_device_id = devices.ANTI_ICE_INTERFACE, value_down = 1,	value_up = 0, name = _('AntiIce AUTO/MANUAL'),         		category = _('Right Side Panel')},
{down = AntiIceSys_commands.ANTIICE_Off_EXT, 	   cockpit_device_id = devices.ANTI_ICE_INTERFACE, value_down = 1,	value_up = 0, name = _('AntiIce OFF'),                 		category = _('Right Side Panel')},
{down = AntiIceSys_commands.ANTIICE_LeftEng_EXT,   cockpit_device_id = devices.ANTI_ICE_INTERFACE, value_down = 1,	value_up = 0, name = _('Left Engine AntiIce ON/OFF'),  		category = _('Right Side Panel')},
{down = AntiIceSys_commands.ANTIICE_RightEng_EXT,  cockpit_device_id = devices.ANTI_ICE_INTERFACE, value_down = 1,	value_up = 0, name = _('Right Engine AntiIce ON/OFF'), 		category = _('Right Side Panel')},
{down = AntiIceSys_commands.ANTIICE_GLAZING_P_EXT, cockpit_device_id = devices.ANTI_ICE_INTERFACE, value_down = 1,                name = _('Windshield Antiice Switch - HIGH'),	category = _('Right Side Panel')},
{down = AntiIceSys_commands.ANTIICE_GLAZING_P_EXT, cockpit_device_id = devices.ANTI_ICE_INTERFACE, value_down = 0,                name = _('Windshield Antiice Switch - OFF'),	category = _('Right Side Panel')},
{down = AntiIceSys_commands.ANTIICE_GLAZING_P_EXT, cockpit_device_id = devices.ANTI_ICE_INTERFACE, value_down = -1,               name = _('Windshield Antiices Switch - LOW'),	category = _('Right Side Panel')},
{down = AntiIceSys_commands.ANTIICE_Ammeter_ITER,  cockpit_device_id = devices.ANTI_ICE_INTERFACE, value_down = -1,               name = _('AC Ammeter knob - CCW/Decrease'),   category = _('Right Side Panel')},
{down = AntiIceSys_commands.ANTIICE_Ammeter_ITER,  cockpit_device_id = devices.ANTI_ICE_INTERFACE, value_down = 1,                name = _('AC Ammeter knob - CW/Increase'),    category = _('Right Side Panel')},

{down = cockpit_mechanics_commands.Command_CPT_MECH_ClockHeat_ITER,	  		cockpit_device_id = devices.CPT_MECH, value_down = 1,			name = _('Сlock heating Switch - ON/OFF'),					category = _('Left Side Panel')},
{down = cockpit_mechanics_commands.Command_CPT_MECH_ClockHeat_EXT,			cockpit_device_id = devices.CPT_MECH, value_down = 1,			name = _('Сlock heating Switch - ON'),						category = _('Left Side Panel')},
{down = cockpit_mechanics_commands.Command_CPT_MECH_ClockHeat_EXT,			cockpit_device_id = devices.CPT_MECH, value_down = 0,			name = _('Сlock heating Switch - OFF'),						category = _('Left Side Panel')},
{down = cockpit_mechanics_commands.Command_CPT_MECH_PitotTotalLeft_ITER,	cockpit_device_id = devices.CPT_MECH, value_down = 1,			name = _('Pitot Left heating Switch - ON/OFF'),				category = _('Left Side Panel')},
{down = cockpit_mechanics_commands.Command_CPT_MECH_PitotTotalLeft,			cockpit_device_id = devices.CPT_MECH, value_down = 1,			name = _('Pitot Left heating Switch - ON'),					category = _('Left Side Panel')},
{down = cockpit_mechanics_commands.Command_CPT_MECH_PitotTotalLeft,			cockpit_device_id = devices.CPT_MECH, value_down = 0,			name = _('Pitot Left heating Switch - OFF'),				category = _('Left Side Panel')},
{down = cockpit_mechanics_commands.Command_CPT_MECH_PitotTotalRight_ITER,	cockpit_device_id = devices.CPT_MECH, value_down = 1,			name = _('Pitot Right heating Switch - ON/OFF'),			category = _('Left Side Panel')},
{down = cockpit_mechanics_commands.Command_CPT_MECH_PitotTotalRight,		cockpit_device_id = devices.CPT_MECH, value_down = 1,			name = _('Pitot Right heating Switch - ON'),				category = _('Left Side Panel')},
{down = cockpit_mechanics_commands.Command_CPT_MECH_PitotTotalRight,		cockpit_device_id = devices.CPT_MECH, value_down = 0,			name = _('Pitot Right heating Switch - OFF'),				category = _('Left Side Panel')},

-- External Cargo
{	down = iCommandExtCargoHook,																				name = _('External Cargo Hook'),				category = {_('External Cargo')}},
{	down = iCommandTacticalCargoUnhook,		up = iCommandTacticalCargoUnhook,	value_down = 1, value_up = 0,	name = _('External Cargo Tactical Unhook'),		category = {_('Ins Collective Stick'), _('External Cargo')}},
{	down = iCommandEmergencyCargoUnhook,	up = iCommandEmergencyCargoUnhook,	value_down = 1, value_up = 0,	name = _('External Cargo Emergency Unhook'),	category = {_('Ins Collective Stick'), _('External Cargo')}},

{	down = ext_cargo_equipment_commands.CMD_TacticalReleaseBtn_EXT,			up = ext_cargo_equipment_commands.CMD_TacticalReleaseBtn_EXT,	cockpit_device_id = devices.EXT_CARGO_EQUIPMENT,	value_down = 1.0,	value_up = 0.0,	name = _('Tactical Cargo Release Button'),							category = {_('Ins Collective Stick'), _('External Cargo')}},
{	down = ext_cargo_equipment_commands.CMD_TacticalReleaseBtn_Cover_ITER,																	cockpit_device_id = devices.EXT_CARGO_EQUIPMENT,	value_down = 0,						name = _('Tactical Cargo Release Button Cover - OPEN/CLOSE'),		category = {_('Ins Collective Stick'), _('External Cargo')}},
{	down = ext_cargo_equipment_commands.CMD_TacticalReleaseBtn_Cover_EXT,																	cockpit_device_id = devices.EXT_CARGO_EQUIPMENT,	value_down = 1,						name = _('Tactical Cargo Release Button Cover - OPEN'),				category = {_('Ins Collective Stick'), _('External Cargo')}},
{	down = ext_cargo_equipment_commands.CMD_TacticalReleaseBtn_Cover_EXT,																	cockpit_device_id = devices.EXT_CARGO_EQUIPMENT,	value_down = 0,						name = _('Tactical Cargo Release Button Cover - CLOSE'),			category = {_('Ins Collective Stick'), _('External Cargo')}},
{	down = ext_cargo_equipment_commands.CMD_EmergReleaseBtn_EXT,			up = ext_cargo_equipment_commands.CMD_EmergReleaseBtn_EXT,		cockpit_device_id = devices.EXT_CARGO_EQUIPMENT,	value_down = 1.0,	value_up = 0.0,	name = _('Emergency Cargo Release Button'),							category = {_('Ins Collective Stick'), _('External Cargo')}},
{	down = ext_cargo_equipment_commands.CMD_EmergReleaseBtnCover_ITER,																		cockpit_device_id = devices.EXT_CARGO_EQUIPMENT,	value_down = 0,						name = _('Emergency Cargo Release Button Cover - OPEN/CLOSE'),		category = {_('Ins Collective Stick'), _('External Cargo')}},
{	down = ext_cargo_equipment_commands.CMD_EmergReleaseBtnCover_EXT,																		cockpit_device_id = devices.EXT_CARGO_EQUIPMENT,	value_down = 1,						name = _('Emergency Cargo Release Button Cover - OPEN'),			category = {_('Ins Collective Stick'), _('External Cargo')}},
{	down = ext_cargo_equipment_commands.CMD_EmergReleaseBtnCover_EXT,																		cockpit_device_id = devices.EXT_CARGO_EQUIPMENT,	value_down = 0,						name = _('Emergency Cargo Release Button Cover - CLOSE'),			category = {_('Ins Collective Stick'), _('External Cargo')}},
{	down = ext_cargo_equipment_commands.CMD_AutoReleaseSw_ITER,																				cockpit_device_id = devices.EXT_CARGO_EQUIPMENT,	value_down = 0,						name = _('External Cargo Auto-Release Switch - ON/OFF'),			category = {_('Right Forward Panel'), _('External Cargo')}},
{	down = ext_cargo_equipment_commands.CMD_AutoReleaseSw_EXT,																				cockpit_device_id = devices.EXT_CARGO_EQUIPMENT,	value_down = 1,						name = _('External Cargo Auto-Release Switch - ON'),				category = {_('Right Forward Panel'), _('External Cargo')}},
{	down = ext_cargo_equipment_commands.CMD_AutoReleaseSw_EXT,																				cockpit_device_id = devices.EXT_CARGO_EQUIPMENT,	value_down = 0,						name = _('External Cargo Auto-Release Switch - OFF'),				category = {_('Right Forward Panel'), _('External Cargo')}},
{	down = ext_cargo_equipment_commands.CMD_RemoveRelease_ITER,																				cockpit_device_id = devices.EXT_CARGO_EQUIPMENT,	value_down = 0,						name = _('External Cargo Remove-Release Switch - RELEASE/REMOVE'),	category = {_('Right Forward Panel'), _('External Cargo')}},
{	down = ext_cargo_equipment_commands.CMD_RemoveRelease_EXT,																				cockpit_device_id = devices.EXT_CARGO_EQUIPMENT,	value_down = 1,						name = _('External Cargo Remove-Release Switch - RELEASE'),			category = {_('Right Forward Panel'), _('External Cargo')}},
{	down = ext_cargo_equipment_commands.CMD_RemoveRelease_EXT,																				cockpit_device_id = devices.EXT_CARGO_EQUIPMENT,	value_down = 0,						name = _('External Cargo Remove-Release Switch - REMOVE'),			category = {_('Right Forward Panel'), _('External Cargo')}},


})



join(res.axisCommands, {

-- joystick axes 
{action = iCommandPlaneThrustCommon, name = _('Corrector')},
{action = iCommandPlaneThrustLeft, name = _('Left Throttle')},
{action = iCommandPlaneThrustRight, name = _('Right Throttle')},
{action = iCommandWheelBrake, name = _('Wheel Brake')},

{combos = defaultDeviceAssignmentFor("roll"),	action = iCommandPlaneRoll,			name = _('Flight Control Cyclic Roll')},
{combos = defaultDeviceAssignmentFor("pitch"),	action = iCommandPlanePitch,		name = _('Flight Control Cyclic Pitch')},
{combos = defaultDeviceAssignmentFor("rudder"),	action = iCommandPlaneRudder,		name = _('Flight Control Rudder')},
{combos = defaultDeviceAssignmentFor("thrust"),	action = iCommandPlaneCollective,	name = _('Flight Control Collective')},

{action = iCommandHelicopterRotorEngineBrake_ByAxis, name = _('Rotor Brake Handle')},

{action = iCommandWheelBrake, name = _('Wheel brake')},

-- TrackIR axes
{action = iCommandViewVerticalAbs, name = _('Absolute Camera Vertical View')},
{action = iCommandViewHorizontalAbs, name = _('Absolute Camera Horizontal View')},
{action = iCommandViewHorTransAbs, name = _('Absolute Horizontal Shift Camera View')},
{action = iCommandViewVertTransAbs, name = _('Absolute Vertical Shift Camera View')},
{action = iCommandViewLongitudeTransAbs, name = _('Absolute Longitude Shift Camera View')},
{action = iCommandViewRollAbs, name = _('Absolute Roll Shift Camera View')},
{action = iCommandViewZoomAbs, name = _('Zoom View')},

})



return res
