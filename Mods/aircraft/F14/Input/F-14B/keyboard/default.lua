local cockpit = folder.."../../../Cockpit/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")
local f14input = folder.."../../../Input/"
dofile(f14input.."utils.lua")

local res = external_profile("Config/Input/Aircrafts/common_keyboard_binding.lua")

join_override(res.keyCommands,{

---Cockpit mechanics

{combos = {{key='C',reformers={'LCtrl'}}}, down = device_commands.CANOPY_Toggle, cockpit_device_id=devices.COCKPITMECHANICS, value_down = 1, name = _('Toggle Canopy'), category = _('Cockpit Mechanics')},

{combos = {{key = 'P',	reformers = {'RShift'}}},	down = iCommandCockpitShowPilotOnOff,	name = _('Show pilot body'),	category = _('General')},

{combos = {{key = '1', reformers = {'RShift','RAlt'}}},		down = device_commands.KNEEBOARD_Laser100,		cockpit_device_id = devices.WEAPONS,	value_down = 1,	name = _('Change LGB laser code 2nd digit'), category = {_('Ground Adjustment')}},
{combos = {{key = '2', reformers = {'RShift','RAlt'}}},		down = device_commands.KNEEBOARD_Laser10,		cockpit_device_id = devices.WEAPONS,	value_down = 1,	name = _('Change LGB laser code 3rd digit'), category = {_('Ground Adjustment')}},
{combos = {{key = '3', reformers = {'RShift','RAlt'}}},		down = device_commands.KNEEBOARD_Laser1,		cockpit_device_id = devices.WEAPONS,	value_down = 1,	name = _('Change LGB laser code 4th digit'), category = {_('Ground Adjustment')}},
{combos = {{key = '4', reformers = {'RShift','RAlt'}}},		down = device_commands.KNEEBOARD_gunburst,		cockpit_device_id = devices.WEAPONS,	value_down = 1,	name = _('Change gun burst mode'), category = {_('Ground Adjustment')}},
{combos = {{key = '=', reformers = {'RShift','RAlt'}}},		down = device_commands.KNEEBOARD_ky28adj,		cockpit_device_id = devices.ICS,	value_down = 1,	name = _('Inc KY-28 encryption key'), category = {_('Ground Adjustment')}},
{combos = {{key = '-', reformers = {'RShift','RAlt'}}},		down = device_commands.KNEEBOARD_ky28adj,		cockpit_device_id = devices.ICS,	value_down = -1,	name = _('Dec KY-28 encryption key'),category = {_('Ground Adjustment')}},


--************************************* NVG  ******************************************************************

{combos = {{key = 'H', reformers = {'RShift'}}}    , down = iCommandViewNightVisionGogglesOn , name = _('Night Vision Goggles') , category = _('Night Vision Goggles')},
{combos = {{key = 'H', reformers = {'RCtrl','RShift'}}}, pressed = iCommandPlane_Helmet_Brightess_Up , name = _('Night Vision Goggles Gain Up') , category = _('Night Vision Goggles')},
{combos = {{key = 'H', reformers = {'RAlt','RShift'}}} , pressed = iCommandPlane_Helmet_Brightess_Down, name = _('Night Vision Goggles Gain Down'), category = _('Night Vision Goggles')},



--************************************* Walkman  ******************************************************************

{combos={{key='M', reformers={'LShift'}}},		down=device_commands.WALKMAN_Play, cockpit_device_id=devices.WALKMAN, value_down=1.0, name=_('Play'),category=_('Tape Player')},
{combos={{key='N', reformers={'LShift'}}},		down=device_commands.WALKMAN_Stop, cockpit_device_id=devices.WALKMAN, value_down=1.0, name=_('Stop'),category=_('Tape Player')},
{combos={{key='M', reformers={'LCtrl'}}},		down=device_commands.WALKMAN_FFWD, cockpit_device_id=devices.WALKMAN, value_down=1.0, name=_('Fast Forward'),category=_('Tape Player')},
{combos={{key='N', reformers={'LCtrl'}}},		down=device_commands.WALKMAN_FBWD, cockpit_device_id=devices.WALKMAN, value_down=1.0, name=_('Fast Backward'),category=_('Tape Player')},
{												down=device_commands.WALKMAN_VOLUP, cockpit_device_id=devices.WALKMAN, value_down=1.0, name=_('Volume Up'),category=_('Tape Player')},
{												down=device_commands.WALKMAN_VOLDOWN, cockpit_device_id=devices.WALKMAN, value_down=1.0, name=_('Volume Down'),category=_('Tape Player')},
{												down=device_commands.WALKMAN_Side, cockpit_device_id=devices.WALKMAN, value_down=1.0, name=_('Switch  Side'),category=_('Tape Player')},



--************************** General *******************************************************************************

{combos={{key='E',reformers={'LCtrl'}}},down=iCommandPlaneEject,name=_('Eject (3 times)'),category=_('General')},

{combos={{key='Tab'}},down=iCommandChat,name=_('Multiplayer chat - mode All'),category=_('General')},
{combos={{key='Tab',reformers={'LCtrl'}}},down=iCommandFriendlyChat,name=_('Multiplayer chat - mode Allies'),category=_('General')},
{combos={{key='Scroll',reformers={'RShift','RCtrl'}}},down=iCommandRecordCursorOnOff,name=_('Record of mouse cursor in track On/Off'),category=_('General')},
{combos={{key='Scroll',reformers={'RShift'}}},down=iCommandRecordSubtitleOn,name=_('Subtitle recording begin'),category=_('General')},
{combos={{key='Scroll',reformers={'RCtrl'}}},down=iCommandRecordSubtitleOff,name=_('Subtitle recording end'),category=_('General')},

--******************************* Views *************************************************************************

-- Cockpit seats
{combos = {{key = '1'}}, down = iCommandViewCockpitChangeSeat, value_down = 1, name = _('Occupy Pilot Seat'), category = _('View Cockpit')},
{combos = {{key = '2'}}, down = iCommandViewCockpitChangeSeat, value_down = 2, name = _('Occupy RIO Seat'), category = _('View Cockpit')},
{combos = {{key = 'S', reformers = {'LShift'}}},			down = iCommandPilotSeatAdjustmentUp  ,	up = iCommandPilotSeatAdjustmentStop, name = _('Seat Adjustment Up'),	category = {_('Systems')}},
{combos = {{key = 'S', reformers = {'LShift','LAlt'}}},		down = iCommandPilotSeatAdjustmentDown,	up = iCommandPilotSeatAdjustmentStop, name = _('Seat Adjustment Down'),	category = {_('Systems')}},

{combos={{key='Num8',reformers={'RWin'}}},down=iCommandViewLeftMirrorOn,up=iCommandViewLeftMirrorOff,name=_('Mirror View'),category=_('Views')},

{combos = {{key = 'N', reformers = {'RAlt'}}},	down = iCommandViewLeftMirrorOn ,	up = iCommandViewLeftMirrorOff ,	name = _('Mirror Left On'),		category = _('View Cockpit') , features = {"Mirrors"}},
{combos = {{key = 'M', reformers = {'RAlt'}}},	down = iCommandViewRightMirrorOn,	up = iCommandViewRightMirrorOff,	name = _('Mirror Right On'),	category = _('View Cockpit') , features = {"Mirrors"}},
{combos = {{key = 'M' }},						down = iCommandToggleMirrors,											name = _('Toggle Mirrors'),		category = _('View Cockpit') , features = {"Mirrors"}},

-- carrier
{down = device_commands.CARRIER_ballcall,	cockpit_device_id = devices.ICS,	value_down =  1.0,	name = _('Tomcat Ball'),	category = _('Communications')},

})

return res
