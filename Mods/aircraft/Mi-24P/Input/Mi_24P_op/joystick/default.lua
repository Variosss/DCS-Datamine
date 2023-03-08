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

------------------------------------------------
-- Night Vision Goggles ------------------------
------------------------------------------------
{down = iCommandViewNightVisionGogglesOn,		name = _('Night Vision Goggles'),			category = {_('Sensors')}},
{pressed = iCommandPlane_Helmet_Brightess_Up,	name = _('Night Vision Goggles Gain Up'),	category = {_('Sensors')}},
{pressed = iCommandPlane_Helmet_Brightess_Down,	name = _('Night Vision Goggles Gain Down'),	category = {_('Sensors')}},


-- View Cockpit 
{down = iCommandViewCockpitChangeSeat,	value_down = 1, name = _('Set Pilot Seat'),		category = _('View Cockpit')},
{down = iCommandViewCockpitChangeSeat,	value_down = 2, name = _('Set Operator Seat'),	category = _('View Cockpit')},
{down = iCommandViewCockpitChangeSeat,	value_down = 3, name = _('Set Gunner Seat'),	category = _('View Cockpit')},
{down = headwrapper_commands.TrackIR_OnOff, cockpit_device_id = devices.HEAD_WRAPPER, value_down = 0.0,	name = _('TrackIR Aiming On/Off'),		category = _('View Cockpit')},

{down = iCommandPlanePickleOn,    up = iCommandPlanePickleOff, name = _('Release weapons'), category = {_('Ins Cyclic Stick'), _('Weapon')}},

{down = SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_EXT,	up = SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_EXT, cockpit_device_id = devices.SPU_8, value_down = 1.0, value_up = 0.0,		name = _('Radio trigger - RADIO (call radio menu)'),			category = {_('Ins Cyclic Stick'), _('Communications')}},
{down = SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_EXT,	up = SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_EXT, cockpit_device_id = devices.SPU_8, value_down = 0.5, value_up = 0.0,		name = _('Radio trigger - ICS (call radio menu)'),			category = {_('Ins Cyclic Stick'), _('Communications')}},
-- VoIP radio global command
-- in case you need to open commands in the cockpit
{down = iCommandVoIPRadioPushToTalkEnableDisableVoice,	up = iCommandVoIPRadioPushToTalkEnableDisableVoice, value_down = 1.0, value_up = 0.0,	name = _('Radio trigger - RADIO (VOIP)'), category = {_('Ins Cyclic Stick'), _('Communications')}},
{down = iCommandVoIPIntercomPushToTalkEnableDisableVoice,	up = iCommandVoIPIntercomPushToTalkEnableDisableVoice, value_down = 0.5, value_up = 0.0,	name = _('Radio trigger - ICS (VOIP)'), category = {_('Ins Cyclic Stick'), _('Communications')}},
--
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

--9K113
{down = i9K113_commands.Command_POWER_PN_Ext, 		cockpit_device_id = devices.I9K113, value_down = 1,		name = _('GUID.UNIT POWER'),						category = {_('9K113')}},
{down = i9K113_commands.Command_9k113_Backlight_Ext, cockpit_device_id = devices.I9K113, value_down = 1,	name = _('LIGHTS (Backlight)'),						category = {_('9K113')}},
{down = i9K113_commands.Command_Heat_O_Ext, 		cockpit_device_id = devices.I9K113, value_down = 1,		name = _('Sight Heating'),						category = {_('9K113')}},

{down = i9K113_commands.Command_NABL_Ext,		cockpit_device_id = devices.I9K113,	value_down =  0.0,	name = _('OBSERVE - OFF'),			category = {_('9K113')}},
{down = i9K113_commands.Command_NABL_Ext,		cockpit_device_id = devices.I9K113,	value_down =  1.0,	name = _('OBSERVE - ON'),			category = {_('9K113')}},
{down = i9K113_commands.Command_NABL_Iter,		cockpit_device_id = devices.I9K113,	value_down =  1.0,	name = _('OBSERVE - ON/OFF'),		category = {_('9K113')}},

{down = i9K113_commands.Command_DIAFR_OTKR_Ext, 	cockpit_device_id = devices.I9K113, value_down = 1,		name = _('DIAFR Open'),							category = {_('9K113')}},
{down = i9K113_commands.Command_OTKL_BLOCK_ARU_Ext, cockpit_device_id = devices.I9K113, value_down = 1,		name = _('LOCK ARU'),							category = {_('9K113')}},
{down = i9K113_commands.Command_SSP_VKL_Ext, 		cockpit_device_id = devices.I9K113, value_down = 1,		name = _('SSP On'),								category = {_('9K113')}},
{down = i9K113_commands.Command_GENER_EMIT_Ext, 	cockpit_device_id = devices.I9K113, value_down = 1,		name = _('GENERATOR-IMIT'),						category = {_('9K113')}},
{down = i9K113_commands.Command_KONTR_T1_B9_KONTR_T2_Ext, 		cockpit_device_id = devices.I9K113, value_down = 1,		name = _('CHECK2-NEUTR-CHECK1 Up'),				category = {_('9K113')}},
{down = i9K113_commands.Command_WORK_CONTROL_Ext, 	cockpit_device_id = devices.I9K113, value_down = -1,	name = _('CHECK2-NEUTR-CHECK1 Down'),			category = {_('9K113')}},
{down = i9K113_commands.Command_VHOD_BVK_KV_Ext, 	cockpit_device_id = devices.I9K113, value_down = 1,		name = _('WORK-CHECK'),							category = {_('9K113')}},
{down = i9K113_commands.Command_START_PM_Ext, 		cockpit_device_id = devices.I9K113, value_down = 1,		name = _('Start PM'),							category = {_('9K113')}},
{down = i9K113_commands.Command_VHOD_BVK_KV_Ext, 	cockpit_device_id = devices.I9K113, value_down = 1,		name = _('BVK Set Next'),						category = {_('9K113')}},
{down = i9K113_commands.Command_VHOD_BVK_KV_Ext, 	cockpit_device_id = devices.I9K113, value_down = -1,	name = _('BVK Set Prev'),						category = {_('9K113')}},
{down = i9K113_commands.Command_STVORKI_Ext, 		cockpit_device_id = devices.I9K113, value_down = 1,		name = _('Sight Doors'),						category = {_('9K113')}},
{down = i9K113_commands.Command_HEAT_O_Ext, 		cockpit_device_id = devices.I9K113, value_down = 1,		name = _('Sight Fan'),							category = {_('9K113')}},
{down = i9K113_commands.Command_CHECK_LAMPS_Ext, 	cockpit_device_id = devices.I9K113, value_down = 1,		name = _('Lamps Check'),						category = {_('9K113')}},
{down = i9K113_commands.Command_0_04_Ext, 			cockpit_device_id = devices.I9K113, value_down = 1,		name = _('Switcher 0 - 0.4'),					category = {_('9K113')}},
{down = i9K113_commands.Command_SWITCHER_IN_OUT_Ext, cockpit_device_id = devices.I9K113, value_down = 1,		name = _('Switcher IN-OUT'),					category = {_('9K113')}},
{down = i9K113_commands.Command_COD1_COD2_Ext, 		cockpit_device_id = devices.I9K113, value_down = 1,		name = _('Switcher CODE1-CODE2'),				category = {_('9K113')}},
{down = i9K113_commands.Command_CHECKING_Ext, 		up = i9K113_commands.Button_49, cockpit_device_id = devices.I9K113, value_down = 1, value_up = 0, name = _('Checking'),	category = {_('9K113')}},
{down = i9K113_commands.Command_HIGH_K_Ext, 		up = i9K113_commands.Button_50, cockpit_device_id = devices.I9K113, value_down = 1, value_up = 0, name = _('High K'),	category = {_('9K113')}},
{down = i9K113_commands.Command_TABLO_Ext, 		cockpit_device_id = devices.I9K113, 					name = _('Board Check'),						category = {_('9K113')}},

{down = i9K113_commands.Command_StickPark_Ext, 		cockpit_device_id = devices.I9K113, value_down = 1, name = _('Park/Unpark Operators Stick'), category = {_('Ins Cyclic Stick')}},

{down = i9K113_commands.Command_RadiationReset_Ext, up = i9K113_commands.Command_RadiationReset_Ext,		cockpit_device_id = devices.I9K113, value_down = 1, value_up = 0,	name = _('Radiation Reset'),						category = {_('9K113')}},

{ down = i9K113_commands.Command_ZOOM_Ext, cockpit_device_id = devices.I9K113, value_down = 1,	name = _('Enlargement x3/x10'),		category = {_('9K113')}},
{down = i9K113_commands.Command_OS_Ext, cockpit_device_id = devices.I9K113, value_down = 1,	name = _('Orange Filter On/Off'),		category = {_('9K113')}},
{down = i9K113_commands.Command_SES_Ext, cockpit_device_id = devices.I9K113, value_down = 1,	name = _('Laser Filter On/Off'),		category = {_('9K113')}},
{down = i9K113_commands.Command_Hint_Ext, cockpit_device_id = devices.I9K113, value_down = 1,	name = _('9K113 Hints On/Off'),		category = {_('9K113')}},

{down = i9K113_commands.Command_Aiming, 		cockpit_device_id = devices.I9K113, 		value_down = 1,	name = _('9K113 aiming profile On/Off'), category = {_('9K113')}},
{down = i9K113_commands.Command_SteeringHelper_Ext, cockpit_device_id = devices.I9K113, value_down = 1,	name = _('9K113 Steering Arrow On/Off'),		category = {_('9K113')}},

{down = iCommandPlaneRadarUp, 		up = iCommandPlaneRadarUp, 		value_down = 1,	value_up = 0, name = _('9K113 slew up'), category = _('9K113')},
{down = iCommandPlaneRadarDown, 	up = iCommandPlaneRadarDown, 	value_down = -1,	value_up = 0, name = _('9K113 slew down'), category = _('9K113')},
{down = iCommandPlaneRadarLeft, 	up = iCommandPlaneRadarLeft, 	value_down = -1,	value_up = 0, name = _('9K113 slew left'), category = _('9K113')},
{down = iCommandPlaneRadarRight, 	up = iCommandPlaneRadarRight, 	value_down = 1,	value_up = 0, name = _('9K113 slew right'), category = _('9K113')},
{down = iCommandPlaneRadarCenter, value_down = 1, name = _('9K113, missile control console - knobs in neutral'), category = _('9K113')},
{down = iCommandPlaneZoomIn, 	value_down = 1,	name = _('Zoom In'), category = _('9K113')},
{down = iCommandPlaneZoomOut,	value_down = 1, name = _('Zoom Out'), category = _('9K113')},

{down = weapon_commands.SWITCHER_SAFE_WEAP_Ext, 					cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Main Weapon Safe Switch'),			category = {_('Weapon')}},
{down = weapon_commands.Operator_SWITCHER_SAFE_WEAP, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1, 	name = _('Main Weapon Safe Switch On'),			category = {_('Weapon')}},
{down = weapon_commands.Operator_SWITCHER_SAFE_WEAP, 				cockpit_device_id = devices.WEAP_SYS, value_down = 0, 	name = _('Main Weapon Safe Switch Off'),		category = {_('Weapon')}},

{pressed = weapon_commands.Operator_LAUNCH_URS,	up = weapon_commands.Operator_LAUNCH_URS, cockpit_device_id = devices.WEAP_SYS,	value_pressed = 1,	value_up = 0, name = _('Fire Shturm'),	category = {_('Weapon')}},

{down = weapon_commands.SWITCHER_WEAP_TYPE_AB_Iter, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1, 	name = _('Select Weapon Operator Next'),		category = {_('Weapon')}},
{down = weapon_commands.SWITCHER_WEAP_TYPE_AB_Iter, 				cockpit_device_id = devices.WEAP_SYS, value_down = -1, 	name = _('Select Weapon Operator Prev'),		category = {_('Weapon')}},
{down = weapon_commands.EMERG_RELEASE_OPERATOR_Cvr_Ext, 			cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Emergency Jettison Cover, UP/DOWN'),	category = {_('Weapon')}},
{down = weapon_commands.EMERG_RELEASE_OPERATOR_Ext, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Emergency Jettison'),					category = {_('Weapon')}},
{down = weapon_commands.SWITCHER_BOMB_BLOCK_BOMB_Cvr_Ext, 			cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Bombs/Blocks Mode Cover, UP/DOWN'),	category = {_('Weapon')}},
{down = weapon_commands.SWITCHER_BOMB_BLOCK_BOMB_Ext, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1,   name = _('Bombs/Blocks Mode Up'),				category = {_('Weapon')}},
{down = weapon_commands.SWITCHER_BOMB_BLOCK_BOMB_Ext, 				cockpit_device_id = devices.WEAP_SYS, value_down = -1,  name = _('Bombs/Blocks Mode Down'),				category = {_('Weapon')}},
{down = weapon_commands.Operator_EMERG_EXPLODE_OPERATOR_Cvr_Ext,	cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Explosion on Jettison Cover, UP/DOWN'),category = {_('Weapon')}},
{down = weapon_commands.EMERG_EXPLODE_OPERATOR_Ext, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Explosion on Jettison'),				category = {_('Weapon')}},
{down = weapon_commands.CONTROL_On_ME_OPERATOR_Cvr_Up_Ext,			cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Operator Weapon Control Cover, UP'),		category = {_('Weapon')}},
{down = weapon_commands.CONTROL_On_ME_OPERATOR_Cvr_Down_Ext,		cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Operator Weapon Control Cover, DOWN'),		category = {_('Weapon')}},
{down = weapon_commands.SWITCHER_CONTROL_On_ME_OPERATOR_Up_Ext,		cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Operator Weapon Control, UP'),						category = {_('Weapon')}},
{down = weapon_commands.SWITCHER_CONTROL_On_ME_OPERATOR_Down_Ext,	cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Operator Weapon Control, DOWN'),						category = {_('Weapon')}},
{down = weapon_commands.EMERG_RELEASE_PU_OPERATOR_Ext, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Jettison Launcher ON/OFF'),			category = {_('Weapon')}},
{down = weapon_commands.EMERG_RELEASE_PU_OPERATOR_Cvr_Ext,	cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Jettison Launcher Cover, UP/DOWN'),	category = {_('Weapon')}},
{down = weapon_commands.CHAIN_LENGTH_SHORT_MED_LONG_Ext, 			cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Burst Length SHORT/MED/LONG Up'),		category = {_('Weapon')}},
{down = weapon_commands.CHAIN_LENGTH_SHORT_MED_LONG_Ext, 			cockpit_device_id = devices.WEAP_SYS, value_down = -1,	name = _('Burst Length SHORT/MED/LONG Down'),		category = {_('Weapon')}},
{down = weapon_commands.OPERATOR_RATE_MORE_Ext, 			cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Cannon Fire Rate SLOW/FAST'),			category = {_('Weapon')}},
{down = weapon_commands.URS_POWER_Ext, 						cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Missiles Power'),						category = {_('Weapon')}},
{down = weapon_commands.CHECK_RELEASE_PU_Ext, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Release Check PU'),					category = {_('Weapon')}},
{down = weapon_commands.CHECK1_WORK_CHECK2_Ext, 			cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('CHECK1-WORK-CHECK2 Next'),			category = {_('Weapon')}},
{down = weapon_commands.CHECK1_WORK_CHECK2_Ext, 			cockpit_device_id = devices.WEAP_SYS, value_down = -1,	name = _('CHECK1-WORK-CHECK2 Prev'),			category = {_('Weapon')}},
{down = weapon_commands.RELOAD_NPU30_Ext, up = weapon_commands.RELOAD_NPU30_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 1, value_up = 0, name = _('Reload Cannon'),	category = {_('Weapon')}},
{down = weapon_commands.POWER_SHO_SWITCHER_Ext, 			cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('SCHO Power'),							category = {_('Weapon')}},
{down = weapon_commands.CHECK_LAMPS_9C475_Ext, 				cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('SCHO Lamps Check'),					category = {_('Weapon')}},
{down = weapon_commands.SWITCHER_LAUNCH_STATION_Ext, 		cockpit_device_id = devices.WEAP_SYS, value_down = 1,	name = _('Select Station Next'),				category = {_('Weapon')}},
{down = weapon_commands.SWITCHER_LAUNCH_STATION_Ext, 		cockpit_device_id = devices.WEAP_SYS, value_down = -1,	name = _('Select Station Prev'),				category = {_('Weapon')}},
{down = weapon_commands.Operator_START_KMG_Ext, up = weapon_commands.Operator_START_KMG_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 1, value_up = 0, name = _('Start container'),			category = {_('Weapon')}},
{down = weapon_commands.Operator_STOP_KMG_Ext, up = weapon_commands.Operator_STOP_KMG_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 1, value_up = 0,	name = _('Stop container Operator'),	category = {_('Weapon')}},

{down = weapon_commands.SWITCHER_WEAP_TYPE_AB_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 0,	name = _('Select Weapon Operator 1 OFF MSL'),		category = {_('Weapon Panel')}},
{down = weapon_commands.SWITCHER_WEAP_TYPE_AB_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 0.1,	name = _('Select Weapon Operator 2 GM-30'),			category = {_('Weapon Panel')}},
{down = weapon_commands.SWITCHER_WEAP_TYPE_AB_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 0.2,	name = _('Select Weapon Operator 3 ROCKET'),		category = {_('Weapon Panel')}},
{down = weapon_commands.SWITCHER_WEAP_TYPE_AB_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 0.3,	name = _('Select Weapon Operator 4 BOMB'),			category = {_('Weapon Panel')}},
{down = weapon_commands.SWITCHER_WEAP_TYPE_AB_Ext, cockpit_device_id = devices.WEAP_SYS, value_down = 0.4,	name = _('Select Weapon Operator 5 USLP'),			category = {_('Weapon Panel')}},

--Gunners AI Panel
{down = weapon_commands.CMD_GAI_CTL_SHOW, 		cockpit_device_id = devices.WEAP_SYS, value_down = 1.0, name = _('AI Panel Show/Hide'), 		category = _('Gunners AI Panel')},
{down = weapon_commands.CMD_GAI_CTL_GUNNER, 	cockpit_device_id = devices.WEAP_SYS, value_down = 0.0, name = _('AI Gunner ROE Iterate'), 	category = _('Gunners AI Panel')},
{down = weapon_commands.CMD_GAI_CTL_GUNNER, 	cockpit_device_id = devices.WEAP_SYS, value_down = 0.1, name = _('AI Gunner Burst Switch'), 	category = _('Gunners AI Panel')},
{down = weapon_commands.CMD_Show_Gunners_Panel,	cockpit_device_id = devices.WEAP_SYS,		value_down = 1.0,	name = _('Show Gunners Panel'),	category = {_('Hints'), _('Armament System')}},

--ASP-17
{down = asp_commands.USR_ITER, 	    cockpit_device_id = devices.ASP_17V,    value_down =  1.0,	name = _('USR power - ON/OFF'),		category = {_('ASP-17V')}},
{down = asp_commands.USR_EXT,		cockpit_device_id = devices.ASP_17V,	value_down =  0.0,	name = _('USR power - OFF'),		category = {_('ASP-17V')}},
{down = asp_commands.USR_EXT,		cockpit_device_id = devices.ASP_17V,	value_down =  1.0,	name = _('USR power - ON'),			category = {_('ASP-17V')}},

--PKI
{pressed = pki_commands.Brightness_EXT, 		cockpit_device_id = devices.PKV, value_pressed = 0.01, 		name = _('PKI Brightness Adjustment Inc'),		category = {_('PKI')}},
{pressed = pki_commands.Brightness_EXT, 		cockpit_device_id = devices.PKV, value_pressed = -0.01, 	name = _('PKI Brightness Adjustment Dec'),		category = {_('PKI')}},
{pressed = pki_commands.Reflector_Move_Up_Down_EXT,	cockpit_device_id = devices.PKV, value_pressed = 0.003, 	name = _('PKI Adjustment Up'),					category = {_('PKI')}},
{pressed = pki_commands.Reflector_Move_Up_Down_EXT,	cockpit_device_id = devices.PKV, value_pressed = -0.003, name = _('PKI Adjustment Down'),				category = {_('PKI')}},
{down 	 = pki_commands.Lock_Unlock_EXT,		cockpit_device_id = devices.PKV, value_down = 0, 			name = _('PKI Lock'),					category = {_('PKI')}},
{down 	 = pki_commands.Lock_Unlock_EXT,		cockpit_device_id = devices.PKV, value_down = 1, 			name = _('PKI Unlock'),					category = {_('PKI')}},



--ASO-2V
{down = avASO_2V_commands.ASO_2V_Release_Ext, 		up = avASO_2V_commands.ASO_2V_Release_Ext, 			cockpit_device_id = devices.ASO_2V, value_down = 1, value_up = 0,	name = _('Launch Countermeasures'),			category = {_('ASO-2V')}},
{down = avASO_2V_commands.ASO_2V_Left_Ext, 			cockpit_device_id = devices.ASO_2V, value_down = 1, name = _('Countermeasures Left Side activate, switch'),			category = {_('ASO-2V')}},
{down = avASO_2V_commands.ASO_2V_Right_Ext, 		cockpit_device_id = devices.ASO_2V, value_down = 1, name = _('Countermeasures Right Side activate, switch'),			category = {_('ASO-2V')}},
{down = avASO_2V_commands.ASO_2V_Set_I_II_III_Ext, 	cockpit_device_id = devices.ASO_2V, value_down = 1,	name = _('Countermeasures Set I/II/II, switch'),		category = {_('ASO-2V')}},
{down = avASO_2V_commands.ASO_2V_Interval_2_4_Ext, 	cockpit_device_id = devices.ASO_2V, value_down = 1, name = _('Countermeasures Flare Interval, switch'),			category = {_('ASO-2V')}},
{down = avASO_2V_commands.ASO_2V_Series_4_16_Ext, 	cockpit_device_id = devices.ASO_2V, value_down = 1, name = _('Countermeasures Flare Serie, switch'),				category = {_('ASO-2V')}},

--Helper AI
{up = helperai_commands.ShowMenu, 	down = helperai_commands.ShowMenu, 	cockpit_device_id = devices.HELPER_AI, value_up = 0, value_down = 1,	name = _('Show/Hide Menu'),	category = {_('Helper AI Commands')}},
{up = helperai_commands.HeliControlEXT, down = helperai_commands.HeliControlEXT,	cockpit_device_id = devices.HELPER_AI, 	value_up = 0, value_down = 1,	name = _('Request Aircraft Control'),	category = {_('Helper AI Commands'), _('Multicrew')}},

{up = helperai_commands.LineUp_EXT,	down = helperai_commands.LineUp_EXT,	cockpit_device_id = devices.HELPER_AI, 	value_up = 0, value_down = 1,	name = _('Turn to sight heading'),	category = {_('Helper AI Commands')}},
{up = helperai_commands.ShootIn_EXT,	down = helperai_commands.ShootIn_EXT,	cockpit_device_id = devices.HELPER_AI, 	value_up = 0, value_down = 1,	name = _('ATGM launch align'),	category = {_('Helper AI Commands')}},
{up = helperai_commands.UTurn_EXT,	down = helperai_commands.UTurn_EXT,		cockpit_device_id = devices.HELPER_AI, 	value_up = 0, value_down = 1,	name = _('Evasion turn (180 degrees)'),	category = {_('Helper AI Commands')}},
{up = helperai_commands.ToggleSubtitles_EXT,	down = helperai_commands.ToggleSubtitles_EXT,		cockpit_device_id = devices.HELPER_AI, 	value_up = 0, value_down = 1,	name = _('Toggle AI Subtitles ON/OFF'),	category = {_('Helper AI Commands')}},


--InternalLightSystem
{down = int_lights_commands.RedLightsOperatorPanel_1_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.0,                       name = _('Transformer 1 Group Of Red Lights Left And Operator Panel - OFF'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_1_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.1,                       name = _('Transformer 1 Group Of Red Lights Left And Operator Panel - 8V'),				category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_1_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.2,                     	name = _('Transformer 1 Group Of Red Lights Left And Operator Panel - 9V'),				category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_1_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.3,                       name = _('Transformer 1 Group Of Red Lights Left And Operator Panel - 10V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_1_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.4,                       name = _('Transformer 1 Group Of Red Lights Left And Operator Panel - 11V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_1_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.5,                     	name = _('Transformer 1 Group Of Red Lights Left And Operator Panel - 12V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_1_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.6,                       name = _('Transformer 1 Group Of Red Lights Left And Operator Panel - 13V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_1_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.7,                       name = _('Transformer 1 Group Of Red Lights Left And Operator Panel - 14V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_1_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.8,                     	name = _('Transformer 1 Group Of Red Lights Left And Operator Panel - 16V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_1_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.9,                       name = _('Transformer 1 Group Of Red Lights Left And Operator Panel - 18V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_1_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1.0,                       name = _('Transformer 1 Group Of Red Lights Left And Operator Panel - 20V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_1_ITER,                                                                							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Transformer 1 Group Of Red Lights Left And Operator Panel - CYCLE(UP)'),		category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_1_ITER,                                                                							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = -1,                       	name = _('Transformer 1 Group Of Red Lights Left And Operator Panel - CYCLE(DOWN)'),	category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_2_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.0,                       name = _('Transformer 2 Group Of Red Lights Left And Operator Panel - OFF'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_2_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.1,                       name = _('Transformer 2 Group Of Red Lights Left And Operator Panel - 8V'),				category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_2_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.2,                     	name = _('Transformer 2 Group Of Red Lights Left And Operator Panel - 9V'),				category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_2_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.3,                       name = _('Transformer 2 Group Of Red Lights Left And Operator Panel - 10V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_2_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.4,                       name = _('Transformer 2 Group Of Red Lights Left And Operator Panel - 11V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_2_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.5,                     	name = _('Transformer 2 Group Of Red Lights Left And Operator Panel - 12V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_2_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.6,                       name = _('Transformer 2 Group Of Red Lights Left And Operator Panel - 13V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_2_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.7,                       name = _('Transformer 2 Group Of Red Lights Left And Operator Panel - 14V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_2_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.8,                     	name = _('Transformer 2 Group Of Red Lights Left And Operator Panel - 16V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_2_EXT,                                                                 							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0.9,                       name = _('Transformer 2 Group Of Red Lights Left And Operator Panel - 18V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_2_EXT,	                                                             							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1.0,                       name = _('Transformer 2 Group Of Red Lights Left And Operator Panel - 20V'),			category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_2_ITER,                                                                							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Transformer 2 Group Of Red Lights Left And Operator Panel - CYCLE(UP)'),		category = {_('Left Instrument Panel')}},
{down = int_lights_commands.RedLightsOperatorPanel_2_ITER,                                                                							cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = -1,                       	name = _('Transformer 2 Group Of Red Lights Left And Operator Panel - CYCLE(DOWN)'),	category = {_('Left Instrument Panel')}},
{down = int_lights_commands.OperatorPanelRedLights_EXT,                                                                 								cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Operator Panel Lights Switch - ON'),											category = {_('Front Instrument Panel')}},
{down = int_lights_commands.OperatorPanelRedLights_EXT,	                                                             								cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 0,                        	name = _('Operator Panel Lights Switch - OFF'),											category = {_('Front Instrument Panel')}},
{down = int_lights_commands.OperatorPanelRedLights_ITER,                                                                								cockpit_device_id = devices.INT_LIGHTS_SYSTEM,			value_down = 1,                        	name = _('Operator Panel Lights Switch - ON/OFF'),										category = {_('Front Instrument Panel')}},

--ExternalLightSystem
{																				down = ext_lights_commands.TaxiLight_EXT,                  				                                           									cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 1,                     	name = _('Taxi Light Control Switch - ON'),												category = {_('Left Instrument Panel')}},
{																				down = ext_lights_commands.TaxiLight_EXT,	                				                                            							cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 0,                     	name = _('Taxi Light Control Switch - OFF'),											category = {_('Left Instrument Panel')}},
{																				down = ext_lights_commands.TaxiLight_ITER,                 				                                           									cockpit_device_id = devices.EXT_LIGHTS_SYSTEM,			value_down = 1,                     	name = _('Taxi Light Control Switch - ON/OFF'),											category = {_('Left Instrument Panel')}},

{down = ext_lights_commands.HeadLightOperatorControl_EXT, up = ext_lights_commands.HeadLightOperatorControl_EXT,	cockpit_device_id = devices.EXT_LIGHTS_SYSTEM, value_down = 0.2, value_up = 0,	name = _('Operator Headlight - Down'),	category = {_('Ins Collective Stick'), _('External Lights')}},
{down = ext_lights_commands.HeadLightOperatorControl_EXT, up = ext_lights_commands.HeadLightOperatorControl_EXT,	cockpit_device_id = devices.EXT_LIGHTS_SYSTEM, value_down = 0.1, value_up = 0,	name = _('Operator Headlight - Up'),	category = {_('Ins Collective Stick'), _('External Lights')}},
{down = ext_lights_commands.HeadLightOperatorControl_EXT, up = ext_lights_commands.HeadLightOperatorControl_EXT,	cockpit_device_id = devices.EXT_LIGHTS_SYSTEM, value_down = 0.3, value_up = 0,	name = _('Operator Headlight - Left'),	category = {_('Ins Collective Stick'), _('External Lights')}},
{down = ext_lights_commands.HeadLightOperatorControl_EXT, up = ext_lights_commands.HeadLightOperatorControl_EXT,	cockpit_device_id = devices.EXT_LIGHTS_SYSTEM, value_down = 0.4, value_up = 0,	name = _('Operator Headlight - Right'),	category = {_('Ins Collective Stick'), _('External Lights')}},


-- Barometric Altimeter Operator
{pressed = baroaltimeter_commands.CMD_ADJUST_PRESSURE_EXT, 						cockpit_device_id = devices.BAROALT_O, 					value_pressed = 1,			name = _('Baro Pressure Operator Knob - CW'),		category = {_('Front Instrument Panel')}},
{pressed = baroaltimeter_commands.CMD_ADJUST_PRESSURE_EXT, 						cockpit_device_id = devices.BAROALT_O, 					value_pressed = -1,			name = _('Baro Pressure Operator Knob - CCW'),		category = {_('Front Instrument Panel')}},
--PKP72M_interface                                                                                                                                                  
{down = pkp72m_interface_commands.PKP72MoperatorSwitch_EXT,                     cockpit_device_id = devices.PKP72M_INTERFACE,			value_down = 1,             name = _('ADI Switch - ON'),						category = {_('Front Instrument Panel')}},
{down = pkp72m_interface_commands.PKP72MoperatorSwitch_EXT,	                    cockpit_device_id = devices.PKP72M_INTERFACE,			value_down = 0,             name = _('ADI Switch - OFF'),						category = {_('Front Instrument Panel')}},
{down = pkp72m_interface_commands.PKP72MoperatorSwitch_ITER,					cockpit_device_id = devices.PKP72M_INTERFACE,			value_down = 1,				name = _('ADI Switch - ON/OFF'),					category = {_('Front Instrument Panel')}},

-- RMI2 Operator
{down = rmi2_commands.MODE_LEFTSW_EXT,                  				        cockpit_device_id = devices.RMI2_O,						value_down = 1,             name = _('Mode Switch Operator -  '),															category = {_('Front Instrument Panel')}},
{down = rmi2_commands.MODE_LEFTSW_EXT,	                				        cockpit_device_id = devices.RMI2_O,						value_down = 0,             name = _('Mode Switch Operator - ARK1'),															category = {_('Front Instrument Panel')}},
{down = rmi2_commands.MODE_LEFTSW_ITER,                 				        cockpit_device_id = devices.RMI2_O,						value_down = 1,             name = _('Mode Switch Operator -  /ARK1'),														category = {_('Front Instrument Panel')}},
{down = rmi2_commands.MODE_RIGHTSW_EXT,                  				        cockpit_device_id = devices.RMI2_O,						value_down = 1,             name = _('Mode Switch Operator - ZK'),															category = {_('Front Instrument Panel')}},
{down = rmi2_commands.MODE_RIGHTSW_EXT,	                				        cockpit_device_id = devices.RMI2_O,						value_down = 0,             name = _('Mode Switch Operator - ARKU2'),														category = {_('Front Instrument Panel')}},
{down = rmi2_commands.MODE_RIGHTSW_ITER,                 				        cockpit_device_id = devices.RMI2_O,						value_down = 1,             name = _('Mode Switch Operator - ZK/ARKU2'),														category = {_('Front Instrument Panel')}},

-- Clock
{down = iCommandMechClock_LeftLever_Down, up = iCommandMechClock_LeftLever_Down_up,			name = _('Clock Left Knob - Push'),				category = {_('Instrument Panel')}},
{down = iCommandMechClock_LeftLever_Up,														name = _('Clock Left Knob - Pull'),				category = {_('Instrument Panel')}},
{pressed = iCommandMechClock_LeftLever_TurnRight,											name = _('Clock Left Knob - Rotate right'),		category = {_('Instrument Panel')}},
{pressed = iCommandMechClock_LeftLever_TurnLeft,											name = _('Clock Left Knob - Rotate left'),		category = {_('Instrument Panel')}},
{down = iCommandMechClock_RightLever_Down, up = iCommandMechClock_RightLever_Down_up,		name = _('Clock Right Knob - Push'),			category = {_('Instrument Panel')}},
{down = iCommandMechClock_RightLever_Rotate_left,											name = _('Clock Right Knob - Rotate left'),		category = {_('Instrument Panel')}},
{down = iCommandMechClock_RightLever_Rotate_right,											name = _('Clock Right Knob - Rotate right'),	category = {_('Instrument Panel')}},
{down = cockpit_mechanics_commands.Command_CPT_MECH_ClockHeat_ITER,	 cockpit_device_id = devices.CPT_MECH, value_down = 1,	 name = _('Сlock heating Switch - ON/OFF'),		category = _('Left Panel')},
{down = cockpit_mechanics_commands.Command_CPT_MECH_ClockHeat_EXT,	 cockpit_device_id = devices.CPT_MECH, value_down = 1,	 name = _('Сlock heating Switch - ON'),			category = _('Left Panel')},
{down = cockpit_mechanics_commands.Command_CPT_MECH_ClockHeat_EXT,	 cockpit_device_id = devices.CPT_MECH, value_down = 0,	 name = _('Сlock heating Switch - OFF'),		category = _('Left Panel')},
-- KM-2
{pressed = avKM_2_commands.MagneticDeclRotary_EXT,	cockpit_device_id = devices.KM_2, 	value_pressed = -0.2,		name = _('Set magnetic declination  - CCW/Decrease'),		category = {_('Left Instrument Panel')}},
{pressed = avKM_2_commands.MagneticDeclRotary_EXT,	cockpit_device_id = devices.KM_2, 	value_pressed = 0.2,		name = _('Set magnetic declination  - CW/Increase'),		category = {_('Left Instrument Panel')}},
{down = avKM_2_commands.TEST_EXT, 	up = avKM_2_commands.TEST_EXT,				cockpit_device_id = devices.KM_2, 	value_down = 1.0, 	value_up = -1.0,		name = _('Test 315° button - press'),						category = {_('Left Instrument Panel')}},

-- canopy:
{down = cockpit_mechanics_commands.Command_CPT_MECH_Door_EXT,         value_down = 1, cockpit_device_id = devices.CPT_MECH, name = _('Open/Close Operator Canopy'), category = _('Systems')},
-- gear lever:
{down = iCommandPlaneGearUp,	value_down = 1,							name = _('Gear Lever - UP'),										category = {_('Left Instrument Panel')}},
{down = iCommandPlaneGearDown,	value_down = 0,							name = _('Gear Lever - DOWN'),										category = {_('Left Instrument Panel')}},
{down = iCommandPlaneGear,		value_down = 1,							name = _('Gear Lever - UP/DOWN'),									category = {_('Left Instrument Panel')}},
-- Intercom Panels -----------------------------
------------------------------------------------
{pressed = SPU_8_Mi24_commands.CMD_SPU8_MAIN_VOLUME_EXT, value_pressed = -0.2,	cockpit_device_id = devices.SPU_8,	name = _('SPU-8 Main Volume Knob - CCW/Decrease'),			category = {_('SPU-8 Intercom Panels')}},
{pressed = SPU_8_Mi24_commands.CMD_SPU8_MAIN_VOLUME_EXT, value_pressed = 0.2,	cockpit_device_id = devices.SPU_8,	name = _('SPU-8 Main Volume Knob - CW/Increase'),			category = {_('SPU-8 Intercom Panels')}},
{pressed = SPU_8_Mi24_commands.CMD_SPU8_RADIO_VOLUME_EXT,value_pressed = -0.2,	cockpit_device_id = devices.SPU_8,	name = _('SPU-8 Listening Volume Knob - CCW/Decrease'),		category = {_('SPU-8 Intercom Panels')}},
{pressed = SPU_8_Mi24_commands.CMD_SPU8_RADIO_VOLUME_EXT,value_pressed = 0.2,	cockpit_device_id = devices.SPU_8,	name = _('SPU-8 Listening Volume Knob - CW/Increase'),		category = {_('SPU-8 Intercom Panels')}},
{down = SPU_8_Mi24_commands.CMD_SPU8_MODE_ITER,     	 value_down = -0.2, 	cockpit_device_id = devices.SPU_8,	name = _('SPU-8 Radio Source Select Rotary - CCW/Left'),	category = {_('SPU-8 Intercom Panels')}},
{down = SPU_8_Mi24_commands.CMD_SPU8_MODE_ITER,     	 value_down = 0.3,   	cockpit_device_id = devices.SPU_8,	name = _('SPU-8 Radio Source Select Rotary - CW/Right'),	category = {_('SPU-8 Intercom Panels')}},
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

-- ARC-15
{pressed = arc15_commands.VOLUME_EXT,									cockpit_device_id = devices.ARC_15_PANEL_O, value_pressed = -0.2,				name = _('ARC-15 Volume Knob - CCW/Decrease'),						category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{pressed = arc15_commands.VOLUME_EXT,									cockpit_device_id = devices.ARC_15_PANEL_O, value_pressed = 0.2,				name = _('ARC-15 Volume Knob - CW/Increase'),						category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.TLF_TLG_ITER,									cockpit_device_id = devices.ARC_15_PANEL_O, value_down = 1.0,					name = _('ARC-15 Signal Mode Switch - TLF/TLG'),					category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.TLF_TLG_EXT,										cockpit_device_id = devices.ARC_15_PANEL_O, value_down = 1,						name = _('ARC-15 Signal Mode Switch - TLF'),						category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.TLF_TLG_EXT,										cockpit_device_id = devices.ARC_15_PANEL_O, value_down = 0,						name = _('ARC-15 Signal Mode Switch - TLG'),						category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.MODE_EXT,										cockpit_device_id = devices.ARC_15_PANEL_O, value_down = -1.0,					name = _('ARC-15 Mode Selector Switch - CCW'),						category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.MODE_EXT,										cockpit_device_id = devices.ARC_15_PANEL_O, value_down = 1.0,					name = _('ARC-15 Mode Selector Switch - CW'),						category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.LOOP_EXT,up = arc15_commands.LOOP_EXT, 			cockpit_device_id = devices.ARC_15_PANEL_O, value_down = 1.0, value_up = 0.0,	name = _('ARC-15 Loop Antenna Button'),								category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.BACKUP_100KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_O, value_down = -1.0,					name = _('ARC-15 Backup Frequency Dial 100 kHz Knob - Decrease'),	category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.BACKUP_100KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_O, value_down = 1.0,					name = _('ARC-15 Backup Frequency Dial 100 kHz Knob - Increase'),	category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.BACKUP_10KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_O, value_down = -1.0,					name = _('ARC-15 Backup Frequency Dial 10 kHz Knob - Decrease'),	category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.BACKUP_10KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_O, value_down = 1.0,					name = _('ARC-15 Backup Frequency Dial 10 kHz Knob - Increase'),	category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.BACKUP_1KHz_EXT,									cockpit_device_id = devices.ARC_15_PANEL_O, value_down = -1.0,					name = _('ARC-15 Backup Frequency Dial 1 kHz Knob - Decrease'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.BACKUP_1KHz_EXT,									cockpit_device_id = devices.ARC_15_PANEL_O, value_down = 1.0,					name = _('ARC-15 Backup Frequency Dial 1 kHz Knob - Increase'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.PRIMARY_100KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_O, value_down = -1.0,					name = _('ARC-15 Main Frequency Dial 100 kHz Knob - Decrease'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.PRIMARY_100KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_O, value_down = 1.0,					name = _('ARC-15 Main Frequency Dial 100 kHz Knob - Increase'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.PRIMARY_10KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_O, value_down = -1.0,					name = _('ARC-15 Main Frequency Dial 10 kHz Knob - Decrease'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.PRIMARY_10KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_O, value_down = 1.0,					name = _('ARC-15 Main Frequency Dial 10 kHz Knob - Increase'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.PRIMARY_1KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_O, value_down = -1.0,					name = _('ARC-15 Main Frequency Dial 1 kHz Knob - Decrease'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.PRIMARY_1KHz_EXT,								cockpit_device_id = devices.ARC_15_PANEL_O, value_down = 1.0,					name = _('ARC-15 Main Frequency Dial 1 kHz Knob - Increase'),		category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.DIAL_SELECT_ITER,								cockpit_device_id = devices.ARC_15_PANEL_O, value_down = 1.0,					name = _('ARC-15 Channel Selector - 1/2'),							category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.DIAL_SELECT_EXT,									cockpit_device_id = devices.ARC_15_PANEL_O, value_down = 1,						name = _('ARC-15 Channel Selector - 1'),							category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.DIAL_SELECT_EXT,									cockpit_device_id = devices.ARC_15_PANEL_O, value_down = 0,						name = _('ARC-15 Channel Selector- 2'),								category = {_('Left Panel'), _('ARC-15 Control Panel')}},
{down = arc15_commands.CONTROL_EXT, up = arc15_commands.CONTROL_EXT,	cockpit_device_id = devices.ARC_15_PANEL_O,	value_down = 1.0, value_up = 0.0,	name = _('ARC-15 Control Button'),									category = {_('Left Panel'), _('ARC-15 Control Panel')}},

-- Anti Ice System

-- {down = AntiIceSys_commands.ANTIICE_GLAZING_O_EXT, cockpit_device_id = devices.ANTI_ICE_INTERFACE, value_down = 1,  value_up = 0, name = _('Windshield Anti-Ice switch - toggle'),			category = _('Left Side Operator Panel')},

-- Timer
{down = timers_commands.CMD_Timer_On_Off_Ext, 		cockpit_device_id = devices.TIMER, 	value_down = 1.0, 	name = _('Timer On/Off'),						category = {_('Timer Device')}},
{down = timers_commands.CMD_Timer_Left_Right_Ext, 	cockpit_device_id = devices.TIMER, 	value_down = -1.0, 	name = _('Timer Selector Left'),				category = {_('Timer Device')}},
{down = timers_commands.CMD_Timer_Left_Right_Ext, 	cockpit_device_id = devices.TIMER, 	value_down = 1.0, 	name = _('Timer Selector Right'),				category = {_('Timer Device')}},
{down = timers_commands.CMD_Timer_Left_Up_Down_Ext, cockpit_device_id = devices.TIMER, 	value_down = 1.0, 	name = _('Left Timer Interval knob - Pull-Up/release'),		category = {_('Timer Device')}},
{down = timers_commands.CMD_Timer_Left_Rot_Ext, 	cockpit_device_id = devices.TIMER, 	value_down = -1.0, 	name = _('Left Timer Interval knob - Decrease'),		category = {_('Timer Device')}},
{down = timers_commands.CMD_Timer_Left_Rot_Ext, 	cockpit_device_id = devices.TIMER, 	value_down = 1.0, 	name = _('Left Timer Interval knob - Increase'),		category = {_('Timer Device')}},
{down = timers_commands.CMD_Timer_Right_Up_Down_Ext, cockpit_device_id = devices.TIMER, value_down = 1.0, 	name = _('Right Timer Interval knob - Pull-Up/Release'),	category = {_('Timer Device')}},
{down = timers_commands.CMD_Timer_Right_Rot_Ext, 	cockpit_device_id = devices.TIMER, 	value_down = -1.0, 	name = _('Right Timer Interval knob - Decrease'),		category = {_('Timer Device')}},
{down = timers_commands.CMD_Timer_Right_Rot_Ext, 	cockpit_device_id = devices.TIMER, 	value_down = 1.0, 	name = _('Right Timer Interval knob - Increase'),		category = {_('Timer Device')}},

})


join(res.axisCommands, {

-- joystick axes 
{action = iCommandPlaneThrustCommon, name = _('Corrector')},

{combos = defaultDeviceAssignmentFor("roll"),	action = iCommandPlaneRoll,			name = _('Flight Control Cyclic Roll')},
{combos = defaultDeviceAssignmentFor("pitch"),	action = iCommandPlanePitch,		name = _('Flight Control Cyclic Pitch')},
{combos = defaultDeviceAssignmentFor("rudder"),	action = iCommandPlaneRudder,		name = _('Flight Control Rudder')},
{combos = defaultDeviceAssignmentFor("thrust"),	action = iCommandPlaneCollective,	name = _('Flight Control Collective')},

{action = pki_commands.Reflector_Move_Up_Down_Axis,	cockpit_device_id = devices.PKV, name = _('PKI Adjustment'),	category = {_('PKI')}},

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
