--/N/ oct 2015
local cockpit = folder.."../../../Cockpit/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

return {

keyCommands={

--/N/ added 31.01.2015.
{combos={{key='M'}},down=iCommandToggleMirrors,name=_('Toggle Mirror'),category=_('View')},
{combos={{key='B',reformers = {'LAlt'}}},down = iCommandViewBriefing,name=_('View briefing on/off'),category = _('General')},


--************** Planseta *********************************************************************
--- Kneeboard
{combos={{key="Up",reformers={"RCtrl"}}},down=iCommandPlaneShowKneeboard,name=_('Kneeboard On/Off'),category=_('Kneeboard')},
{combos={{key="Right",reformers={"RCtrl"}}},down=3001--[[device_commands.KneeboardNext]],cockpit_device_id=devices.KNEEBOARD,value_down=1.0,name=_('Kneeboard Page +'),category=_('Kneeboard')},
{combos={{key="Left",reformers={"RCtrl"}}},down=3002--[[device_commands.KneeboardPrev]],cockpit_device_id=devices.KNEEBOARD,value_down=1.0,name=_('Kneeboard Page -'),category=_('Kneeboard')},
{combos={{key="Down",reformers={"RCtrl"}}},down=3003--[[device_commands.KneeboardMark]],cockpit_device_id=devices.KNEEBOARD,value_down=1.0,name=_('Kneeboard mark current position'),category=_('Kneeboard')},
{combos={{key="Up",reformers={"RShift"}}},down=iCommandPlaneShowKneeboard,up=iCommandPlaneShowKneeboard,value_down=1.0,value_up=-1.0,name=_('Kneeboard glance'),category=_('Kneeboard')},

--************** Avionics *********************************************************************

-- Pitot tubes - TOGGLES 
{combos={{key='T',reformers={'RAlt'}}},down=device_commands.PitoSelect,cockpit_device_id=devices.PITOT_TUBES,value_down=1.0,name=_('Pitot tubes - main/emerg. toggle'),category=_('Avionics')},
{combos={{key='H',reformers={'LShift'}}},down=device_commands.PitoHeatMain,cockpit_device_id=devices.PITOT_TUBES,value_down=1.0,name=_('Pitot Tube Heating On/Off'),category=_('Avionics')},
{combos={{key='H',reformers={'LAlt'}}},down=device_commands.PitoHeatAux,cockpit_device_id=devices.PITOT_TUBES,value_down=1.0,name=_('Emergency Pitot Tube Heating On/Off'),category=_('Avionics')},

-- Instrument related
{combos={{key='A',reformers={'RCtrl'}}},down=device_commands.AccelReset,up=device_commands.AccelReset,cockpit_device_id=devices.ACCELEROMETER,value_down=1.0,value_up=0.0,name=_('Accelerometer Reset'),category=_('Avionics')},

-- KPP - Artificial Horizont
{combos={{key='K',reformers={'RCtrl'}}},down=device_commands.KPPon,cockpit_device_id=devices.KPP,value_down=1.0,name=_('KPP Main/Emergency toggle'),category=_('Avionics')},
{combos={{key='K'}},down=device_commands.KPParretir,up=device_commands.KPParretir,cockpit_device_id=devices.KPP,value_down=1.0,value_up=0.0,name=_('KPP Cage'),category=_('Avionics')},

-- NPP - Horizontal Situation Indicator
{combos={{key='N',reformers={'LShift'}}},down=device_commands.NPPon,cockpit_device_id=devices.KSI,value_down=1.0,name=_('NPP On/Off'),category=_('Avionics')},
{combos={{key='N',reformers={'LCtrl'}}},down=device_commands.NPPnastrojka,up=device_commands.NPPnastrojka,cockpit_device_id=devices.KSI,value_down=1.0,value_up=0.0,name=_('NPP Cage'),category=_('Avionics')},
{combos={{key='N',reformers={'LAlt'}}},down=device_commands.RSBNARK,cockpit_device_id=devices.RSBN,value_down=1,name=_('NPP - RSBN/ARK mode'),category=_('Avionics')},
{pressed=device_commands.NPPsetCourse_kb,cockpit_device_id=devices.KSI, value_pressed=  0.005, value_up=0.0, action=device_commands.NPPsetCourse,name=_('NPP Course set +'),category=_('Avionics')},
{pressed=device_commands.NPPsetCourse_kb,cockpit_device_id=devices.KSI, value_pressed=  -0.005, value_up=0.0, action=device_commands.NPPsetCourse,name=_('NPP Course set -'),category=_('Avionics')},

-- Radio Altimeter
{combos={{key='B',reformers={'RAlt'}}},down=device_commands.RadioAltOn,cockpit_device_id=devices.RADIO_ALTIMETER,value_down=1.0,name=_('Radio Altimeter/Marker On/Off'),category=_('Avionics')},

{combos={{key='1',reformers={'RCtrl'}}},down=device_commands.DangerAltSelect,cockpit_device_id=devices.RADIO_ALTIMETER,value_down=0.14,name=_('Danger Altitude 50m'),category=_('Avionics')},
{combos={{key='2',reformers={'RCtrl'}}},down=device_commands.DangerAltSelect,cockpit_device_id=devices.RADIO_ALTIMETER,value_down=0.28,name=_('Danger Altitude 100m'),category=_('Avionics')},
{combos={{key='3',reformers={'RCtrl'}}},down=device_commands.DangerAltSelect,cockpit_device_id=devices.RADIO_ALTIMETER,value_down=0.42,name=_('Danger Altitude 150m'),category=_('Avionics')},
{combos={{key='4',reformers={'RCtrl'}}},down=device_commands.DangerAltSelect,cockpit_device_id=devices.RADIO_ALTIMETER,value_down=0.56,name=_('Danger Altitude 200m'),category=_('Avionics')},
{combos={{key='5',reformers={'RCtrl'}}},down=device_commands.DangerAltSelect,cockpit_device_id=devices.RADIO_ALTIMETER,value_down=0.70,name=_('Danger Altitude 250m'),category=_('Avionics')},
{combos={{key='6',reformers={'RCtrl'}}},down=device_commands.DangerAltSelect,cockpit_device_id=devices.RADIO_ALTIMETER,value_down=0.84,name=_('Danger Altitude 300m'),category=_('Avionics')},
{combos={{key='7',reformers={'RCtrl'}}},down=device_commands.DangerAltSelect,cockpit_device_id=devices.RADIO_ALTIMETER,value_down=1.00,name=_('Danger Altitude 400m'),category=_('Avionics')},
{combos={{key='0',reformers={'RCtrl'}}},down=device_commands.DangerAltSelect,cockpit_device_id=devices.RADIO_ALTIMETER,value_down=0.0,name=_('Danger Altitude Off'),category=_('Avionics')},

-- RSBN - Navigation
{combos={{key='R',reformers={'RCtrl'}}},down=device_commands.RSBNon,cockpit_device_id=devices.RSBN,value_down=1,name=_('RSBN On/Off'),category=_('Avionics')},

{combos={{key='N'}},down=device_commands.RSBNmodeToggle,cockpit_device_id=devices.RSBN,value_down=1.0,name=_('RSBN Mode select'),category=_('Avionics')},
{combos={{key='R',reformers={'LAlt','LCtrl'}}},down=device_commands.RSBNmode,cockpit_device_id=devices.RSBN,value_down=1,name=_('RSBN Mode: Descend'),category=_('Avionics')},
{combos={{key='R',reformers={'LCtrl'}}},down=device_commands.RSBNmode,cockpit_device_id=devices.RSBN,value_down=0.5,name=_('RSBN Mode: Navigation'),category=_('Avionics')},
{combos={{key='R',reformers={'LAlt'}}},down=device_commands.RSBNmode,cockpit_device_id=devices.RSBN,value_down=0,name=_('RSBN Mode: Landing'),category=_('Avionics')},
{combos={{key='R',reformers={'LWin','LShift'}}},down=device_commands.RSBNtest,up=device_commands.RSBNtest,cockpit_device_id=devices.RSBN,value_down=1.0,value_up=0.0,name=_('RSBN self test'),category=_('Avionics')},

-- ARK - Radiocompass
{combos={{key='B'}},down=device_commands.ARKon,cockpit_device_id=devices.ARK,value_down=1,name=_('ARK On/Off'),category=_('Avionics')},
{combos={{key='B',reformers={'LShift'}}},down=device_commands.ARKfarNear,cockpit_device_id=devices.ARK,value_down=1,name=_('ARK Far/Near'),category=_('Avionics')},


{combos={{key='1',reformers={'RShift'}}},down=device_commands.ARKchannel,cockpit_device_id=devices.ARK,value_down=0.1,name=_('ARK channel 1'),category=_('Avionics')},
{combos={{key='2',reformers={'RShift'}}},down=device_commands.ARKchannel,cockpit_device_id=devices.ARK,value_down=0.2,name=_('ARK channel 2'),category=_('Avionics')},
{combos={{key='3',reformers={'RShift'}}},down=device_commands.ARKchannel,cockpit_device_id=devices.ARK,value_down=0.3,name=_('ARK channel 3'),category=_('Avionics')},
{combos={{key='4',reformers={'RShift'}}},down=device_commands.ARKchannel,cockpit_device_id=devices.ARK,value_down=0.4,name=_('ARK channel 4'),category=_('Avionics')},
{combos={{key='5',reformers={'RShift'}}},down=device_commands.ARKchannel,cockpit_device_id=devices.ARK,value_down=0.5,name=_('ARK channel 5'),category=_('Avionics')},
{combos={{key='6',reformers={'RShift'}}},down=device_commands.ARKchannel,cockpit_device_id=devices.ARK,value_down=0.6,name=_('ARK channel 6'),category=_('Avionics')},
{combos={{key='7',reformers={'RShift'}}},down=device_commands.ARKchannel,cockpit_device_id=devices.ARK,value_down=0.7,name=_('ARK channel 7'),category=_('Avionics')},
{combos={{key='8',reformers={'RShift'}}},down=device_commands.ARKchannel,cockpit_device_id=devices.ARK,value_down=0.8,name=_('ARK channel 8'),category=_('Avionics')},
{combos={{key='9',reformers={'RShift'}}},down=device_commands.ARKchannel,cockpit_device_id=devices.ARK,value_down=0.9,name=_('ARK channel 9'),category=_('Avionics')},

{combos={{key='1',reformers={'RAlt'}}},down=device_commands.ARKzone,cockpit_device_id=devices.ARK,value_down=0.0,name=_('ARK Sector I-1'),category=_('Avionics')},
{combos={{key='2',reformers={'RAlt'}}},down=device_commands.ARKzone,cockpit_device_id=devices.ARK,value_down=0.14,name=_('ARK Sector I-2'),category=_('Avionics')},
{combos={{key='3',reformers={'RAlt'}}},down=device_commands.ARKzone,cockpit_device_id=devices.ARK,value_down=0.28,name=_('ARK Sector II-1'),category=_('Avionics')},
{combos={{key='4',reformers={'RAlt'}}},down=device_commands.ARKzone,cockpit_device_id=devices.ARK,value_down=0.42,name=_('ARK Sector II-2'),category=_('Avionics')},
{combos={{key='5',reformers={'RAlt'}}},down=device_commands.ARKzone,cockpit_device_id=devices.ARK,value_down=0.56,name=_('ARK Sector III-1'),category=_('Avionics')},
{combos={{key='6',reformers={'RAlt'}}},down=device_commands.ARKzone,cockpit_device_id=devices.ARK,value_down=0.70,name=_('ARK Sector III-2'),category=_('Avionics')},
{combos={{key='7',reformers={'RAlt'}}},down=device_commands.ARKzone,cockpit_device_id=devices.ARK,value_down=0.84,name=_('ARK Sector IV-1'),category=_('Avionics')},
{combos={{key='8',reformers={'RAlt'}}},down=device_commands.ARKzone,cockpit_device_id=devices.ARK,value_down=1.00,name=_('ARK Sector IV-2'),category=_('Avionics')},

-- SARPP - Data Recorder
{combos={{key='S',reformers={'LCtrl'}}},down=device_commands.SARPP,cockpit_device_id=devices.SARPP,value_down=1.0,name=_('SARPP-12 Flight Data Recorder - On/Off'),category=_('Avionics')},

--************** Engine and fuel *********************************************************************

-- Autostart/Stop
{combos={{key='Home',reformers={'LWin'}}},down=device_commands.mig21_autostart,cockpit_device_id=devices.MACROS,value_down=1.0,name=_('Autostart Procedure'),category=_('Engine')},
{combos={{key='End',reformers={'LWin'}}},down=device_commands.mig21_autostop,cockpit_device_id=devices.MACROS,value_down=1.0,name=_('Autostop Procedure'),category=_('Engine')},

-- Fuel pumps & systems
{combos={{key='P',reformers={'RShift'}}},down=device_commands.Pump3,cockpit_device_id=devices.FUEL_PUMPS,value_down=1.0,name=_('3rd Fuel Tanks Group, Fuel Pump On/Off'),category=_('Engine')},
{combos={{key='P',reformers={'RAlt'}}},down=device_commands.Pump1,cockpit_device_id=devices.FUEL_PUMPS,value_down=1.0,name=_('1st Fuel Tanks Group, Fuel Pump On/Off'),category=_('Engine')},
{combos={{key='P',reformers={'RCtrl'}}},down=device_commands.PumpRashod,cockpit_device_id=devices.FUEL_PUMPS,value_down=1.0,name=_('Drain Tank, Fuel Pump On/Off'),category=_('Engine')},

-- Engine start device
{combos={{key='/',reformers={'RAlt'}}},down=device_commands.Zazig,cockpit_device_id=devices.ENGINE_START_DEVICE,value_down=1.0,name=_('APU On/Off'),category=_('Engine')},
{combos={{key='/',reformers={'RCtrl'}}},down=device_commands.HotStart,cockpit_device_id=devices.ENGINE_START_DEVICE,value_down=1.0,name=_('Engine Normal/Cold Start'),category=_('Engine')},
{combos={{key='E'}},down=device_commands.AirStart,cockpit_device_id=devices.ENGINE_START_DEVICE,value_down=1.0,name=_('Engine Emergency Air Start On/Off'),category=_('Engine')},
{down=device_commands.AirStart_2pos,cockpit_device_id=devices.ENGINE_START_DEVICE,value_down=1.0,name=_('Engine Emergency Air Start On'),category=_('Engine')},
{down=device_commands.AirStart_2pos,cockpit_device_id=devices.ENGINE_START_DEVICE,value_down=0.0,name=_('Engine Emergency Air Start Off'),category=_('Engine')},

{combos={{key='E',reformers={'LWin','LShift'}}},down=device_commands.RUDStop_lock,up=device_commands.RUDStop_lock,cockpit_device_id=devices.ENGINE_START_DEVICE,value_down=1.0,value_up=0.0,name=_('Throttle Start/Stop Position Toggle'),category=_('Engine')},
{combos={{key='E',reformers={'LWin','LCtrl'}}},down=device_commands.StartButton,up=device_commands.StartButton,cockpit_device_id=devices.ENGINE_START_DEVICE,value_down=1.0,value_up=0.0,name=_('Start Engine'),category=_('Engine')},

-- Engine
{combos={{key=']',reformers={'RShift'}}},down=device_commands.SurgeDoors,cockpit_device_id=devices.ENGINE,value_down=1.0,name=_('Anti surge doors - Auto/Manual'),category=_('Engine')},
{down=device_commands.SurgeDoors_2pos,cockpit_device_id=devices.ENGINE,value_down=1.0,name=_('Anti surge doors - Manual'),category=_('Engine')},
{down=device_commands.SurgeDoors_2pos,cockpit_device_id=devices.ENGINE,value_down=0.0,name=_('Anti surge doors - Auto'),category=_('Engine')},
{combos={{key=']',reformers={'RAlt'}}},down=device_commands.ForsMax,cockpit_device_id=devices.ENGINE,value_down=1.0,name=_('Afterburner/Maximum On/Off'),category=_('Engine')},
{combos={{key='E',reformers={'LAlt'}}},down=device_commands.Chr,cockpit_device_id=devices.ENGINE,value_down=1.0,name=_('Emergency Afterburner On/Off'),category=_('Engine')},
{down=device_commands.Chr_2pos,cockpit_device_id=devices.ENGINE,value_down=1.0,name=_('Emergency Afterburner On'),category=_('Engine')},
{down=device_commands.Chr_2pos,cockpit_device_id=devices.ENGINE,value_down=0.0,name=_('Emergency Afterburner Off'),category=_('Engine')},

-- Nosecone
{combos={{key='[',reformers={'RShift'}}},down=device_commands.KonusOn,cockpit_device_id=devices.KONUS,value_down=1.0,name=_('Cone On/Off'),category=_('Engine')},
{combos={{key='\\',reformers={'RShift'}}},down=device_commands.KonusManAuto,cockpit_device_id=devices.KONUS,value_down=1.0,name=_('Cone Auto/Manual'),category=_('Engine')},

-- Engine nozzle
{combos={{key='\\',reformers={'RAlt'}}},down=device_commands.Soplo2xPoz,cockpit_device_id=devices.SOPLO,value_down=1.0,name=_('Nozzle, Emergency Control - On/Off'),category=_('Engine')},

-- Fire Extinguisher
{combos={{key='F',reformers={'RAlt'}}},down=device_commands.PozarOborud,cockpit_device_id=devices.FIRE_EXTINGUISHER,value_down=1.0,name=_('Fire Extinguisher System On/Off'),category=_('Engine')},
{combos={{key='F',reformers={'RShift'}}},down=device_commands.PozarSafetyCover,cockpit_device_id=devices.FIRE_EXTINGUISHER,value_down=1.0,name=_('Fire Extinguisher Cover Open/Close'),category=_('Engine')},
{combos={{key='F',reformers={'LWin','LAlt'}}},down=device_commands.Ognetushitel,up=device_commands.Ognetushitel,cockpit_device_id=devices.FIRE_EXTINGUISHER,value_down=1.0,value_up=0.0,name=_('Fire Extinguisher Engage'),category=_('Engine')},

-- Fuel pod drop
{combos={{key='PageUp',reformers={'RCtrl'}}},down=device_commands.SbrosPodvBakov,up=device_commands.SbrosPodvBakov,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,value_up=0.0,name=_('Drop Center Fuel Pod'),category=_('Engine')},
{combos={{key='PageDown',reformers={'RCtrl'}}},down=device_commands.SbrosKrilBakov,up=device_commands.SbrosKrilBakov,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,value_up=0.0,name=_('Drop Wing Fuel Pods'),category=_('Engine')},
{combos={{key='PageDown',reformers={'RShift'}}},down=device_commands.SbrosKrilBakovSafetyCover,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Drop Wing Fuel Pods Cover Open/Close'),category=_('Engine')},

--******************* Flight controls *****************************************************************

-- FFB support
{combos={{key='J',reformers={'RAlt','RShift'}}},down=device_commands.ForceFeedback,up=device_commands.ForceFeedback,cockpit_device_id=devices.CONTROL_SYSTEM,value_down=1.0,value_up=0.0,name=_('Force Feedback On/Off'),category=_('Flight Controls')},

-- Flight Control
{combos = {{key = "Up"}},									down = iCommandPlaneUpStart, up = iCommandPlaneUpStop, name=_('Flight Nose Down'),category=_('Flight Controls')},
{combos = {{key = "Down"}},									down = iCommandPlaneDownStart, up = iCommandPlaneDownStop, name=_('Flight Nose Up'),category=_('Flight Controls')},
{combos = {{key = "Left"}},									down = iCommandPlaneLeftStart, up = iCommandPlaneLeftStop, name=_('Flight Left Wing Down'),category=_('Flight Controls')},
{combos = {{key = "Right"}},								down = iCommandPlaneRightStart, up = iCommandPlaneRightStop, name=_('Flight Right Wing Down'),category=_('Flight Controls')},
{combos = {{key = "Z"}},									down = iCommandPlaneLeftRudderStart, up = iCommandPlaneLeftRudderStop, name=_('Flight Rudder Left'),category=_('Flight Controls')},
{combos = {{key = "X"}},									down = iCommandPlaneRightRudderStart, up = iCommandPlaneRightRudderStop, name=_('Flight Rudder Right'),category=_('Flight Controls')},

{combos = {{key = "Num+"}},									down = iCommandThrottle1Increase, up = iCommandThrottle1Stop, name=_('Throttle Up'),category=_('Flight Controls')},
{combos = {{key = "Num-"}},									down = iCommandThrottle1Decrease, up = iCommandThrottle1Stop, name=_('Throttle Down'),category=_('Flight Controls')},

-- Trimmer
{combos={{key='T',reformers={'RShift'}}},down=device_commands.TrimmerOn,cockpit_device_id=devices.TRIMER,value_down=1.0,name=_('Trim On/Off'),category=_('Flight Controls')},
{combos={{key='T',reformers={'LShift'}}},down=device_commands.TrimmerBtnUp,up=device_commands.TrimmerBtnUp,cockpit_device_id=devices.TRIMER,value_down=1.0,value_up=0.0,name=_('Trim Pitch Down'),category=_('Flight Controls')},
{combos={{key='T',reformers={'LCtrl'}}},down=device_commands.TrimmerBtnDown,up=device_commands.TrimmerBtnDown,cockpit_device_id=devices.TRIMER,value_down=-1.0,value_up=0.0,name=_('Trim Pitch Up'),category=_('Flight Controls')},

-- Hidraulics
{combos={{key='H',reformers={'RShift'}}},down=device_commands.NR27on,cockpit_device_id=devices.MAIN_HYDRO,value_down=1.0,name=_('Emergency Hydraulic Pump On/Off'),category=_('Flight Controls')},
{combos={{key='H',reformers={'RAlt'}}},down=device_commands.AileronBoosters,cockpit_device_id=devices.MAIN_HYDRO,value_down=1.0,name=_('Aileron Boosters On/Off'),category=_('Flight Controls')},

{down=device_commands.Aileron_boosters_On,cockpit_device_id=devices.MAIN_HYDRO,value_down=1.0,name=_('Aileron Boosters On'),category=_('Flight Controls')},
{down=device_commands.Aileron_boosters_Off,cockpit_device_id=devices.MAIN_HYDRO,value_down=0.0,name=_('Aileron Boosters Off'),category=_('Flight Controls')},

{combos={{key='H',reformers={'RAlt'}}},down=device_commands.AileronBoosters,cockpit_device_id=devices.MAIN_HYDRO,value_down=1.0,name=_('Aileron Boosters On/Off'),category=_('Flight Controls')},

-- SPS - Boundary Layer System
{combos={{key='U',reformers={'RShift'}}},down=device_commands.SPSon,cockpit_device_id=devices.SPS,value_down=1,name=_('SPS (BLC) System On/Off'),category=_('Flight Controls')},

-- ARU
{combos={{key='U',reformers={'RAlt'}}},down=device_commands.ARUmanAuto,cockpit_device_id=devices.ARU,value_down=1.0,name=_('ARU - Auto/Manual'),category=_('Flight Controls')},
{combos={{key='U',reformers={'RCtrl'}}},down=device_commands.ARUhighSpeed,up=device_commands.ARUhighSpeed,cockpit_device_id=devices.ARU,value_down=1,value_up=0,name=_('ARU manual - High Speed'),category=_('Flight Controls')},
{combos={{key='U',reformers={'LCtrl'}}},down=device_commands.ARUlowSpeed,up=device_commands.ARUlowSpeed,cockpit_device_id=devices.ARU,value_down=-1,value_up=0,name=_('ARU manual - Low Speed'),category=_('Flight Controls')},

-- Airbrake
{combos={{key='C'}},down=device_commands.Airbrakes,cockpit_device_id=devices.AIRBRAKE,value_down=1.0,name=_('Airbrakes On/Off'),category=_('Flight Controls')},

{down=device_commands.Airbrakes_On,cockpit_device_id=devices.AIRBRAKE,value_down=1.0,name=_('Airbrakes On'),category=_('Flight Controls')},
{down=device_commands.Airbrakes_Off,cockpit_device_id=devices.AIRBRAKE,value_down=0.0,name=_('Airbrakes Off'),category=_('Flight Controls')},

-- Flaps
{combos = {{key = "F"}}, 							down = iCommandPlaneFlapsOn, name=_('Flaps Down'),category=_('Flight Controls')},
{combos = {{key = "F", reformers = {'LShift'}}} , 	down = iCommandPlaneFlapsOff, name=_('Flaps Up'),category=_('Flight Controls')},

{down=device_commands.Flaps0,cockpit_device_id=devices.FLAPS,value_down=1.0,name=_('Flaps 0'),category=_('Flight Controls')},
{down=device_commands.Flaps25,cockpit_device_id=devices.FLAPS,value_down=1.0,name=_('Flaps 25'),category=_('Flight Controls')},
{down=device_commands.Flaps45,cockpit_device_id=devices.FLAPS,value_down=1.0,name=_('Flaps 45'),category=_('Flight Controls')},
{down=device_commands.FlapsReset,up=device_commands.FlapsReset,cockpit_device_id=devices.FLAPS,value_down=1.0,value_up=0.0,name=_('Flaps, releave springs '),category=_('Flight Controls')},

--************************************** SAU *************************************************************************************

-- SAU
{combos={{key='S',reformers={'RShift'}}},down=device_commands.SAUon,cockpit_device_id=devices.SAU,value_down=1,name=_('SAU On/Off'),category=_('SAU')},
{combos={{key='S',reformers={'RAlt'}}},down=device_commands.SAUpitchOn,cockpit_device_id=devices.SAU,value_down=1,name=_('SAU Pitch On/Off'),category=_('SAU')},
{combos={{key='S',reformers={'RCtrl'}}},down=device_commands.SAUlowAltOn,cockpit_device_id=devices.SAU,value_down=1,name=_('SAU - Low Altitude Recovery On/Off'),category=_('SAU')},


{combos={{key='A'}},down=device_commands.SAUprivedenie,up=device_commands.SAUprivedenie,cockpit_device_id=devices.SAU,value_down=1.0,value_up=0.0,name=_('SAU - Recovery'),category=_('SAU')},
{combos={{key='A',reformers={'LAlt'}}},down=device_commands.SAUstabil,up=device_commands.SAUstabil,cockpit_device_id=devices.SAU,value_down=1.0,value_up=0.0,name=_('SAU - Stabilize'),category=_('SAU')},
{combos={{key='A',reformers={'LAlt','LCtrl'}}},down=device_commands.SAUcancel,up=device_commands.SAUcancel,cockpit_device_id=devices.SAU,value_down=1.0,value_up=0.0,name=_('SAU cancel current mode'),category=_('SAU')},

{combos={{key='A',reformers={'RShift'}}},down=device_commands.SAUlandingControlCommand,up=device_commands.SAUlandingControlCommand,cockpit_device_id=devices.SAU,value_down=1.0,value_up=0.0,name=_('SAU Landing - Command'),category=_('SAU')},
{combos={{key='A',reformers={'RAlt'}}},down=device_commands.SAUlandingControlAuto,up=device_commands.SAUlandingControlAuto,cockpit_device_id=devices.SAU,value_down=1.0,value_up=0.0,name=_('SAU Landing - Auto'),category=_('SAU')},
{combos={{key='A',reformers={'RShift','RAlt'}}},down=device_commands.SAUresetOff,up=device_commands.SAUresetOff,cockpit_device_id=devices.SAU,value_down=1.0,value_up=0.0,name=_('SAU Cancel Landing Mode'),category=_('SAU')},

{combos = {{key = "J"}}, down = iCommandPlaneStabPathHold, up = iCommandPlaneStabPathHold, value_down=1.0,value_up=0.0, name=_('SAU - Hold Attitude'),category=_('SAU')},

--************************************* GEARS, G. Brakes and Drag chute  ******************************************************************

-- Gears
{combos={{key='G'}},down=device_commands.GearLever,cockpit_device_id=devices.GEARS,value_down=1.0,name=_('Gears Up'),category=_('Gears, brakes and chute')},
{combos={{key='G',reformers={'LShift'}}},down=device_commands.GearLever,cockpit_device_id=devices.GEARS,value_down=-1.0,name=_('Gears Down'),category=_('Gears, brakes and chute')},
{combos={{key='G',reformers={'LCtrl'}}},down=device_commands.GearLever,cockpit_device_id=devices.GEARS,value_down=0.0,name=_('Gears Handle Neutral'),category=_('Gears, brakes and chute')},
{combos={{key='G',reformers={'RShift'}}},down=device_commands.GearHandleFixator,cockpit_device_id=devices.GEARS,value_down=1.0,name=_('Gears Handle Lock released'),category=_('Gears, brakes and chute')},
{combos={{key='G',reformers={'RCtrl'}}},down=device_commands.GearHandleFixator,cockpit_device_id=devices.GEARS,value_down=0.0,name=_('Gears Handle Lock engaged'),category=_('Gears, brakes and chute')},
{combos={{key='G',reformers={'LCtrl','LShift'}}},down=device_commands.EmergGearsNose,cockpit_device_id=devices.GEARS,value_down=1.0,name=_('Nose Gear Emergency Release On'),category=_('Gears, brakes and chute')},
{combos={{key='G',reformers={'LCtrl','LAlt'}}},down=device_commands.EmergGearsMain,cockpit_device_id=devices.GEARS,value_down=1.0,name=_('Main Gears Emergency Release On'),category=_('Gears, brakes and chute')},

-- Wheel brake
{combos={{key='W'}},down=iCommandPlaneWheelBrakeOn,up=iCommandPlaneWheelBrakeOff,name=_('Wheel Brakes'),category=_('Gears, brakes and chute')},
{combos={{key='W',reformers={'RShift'}}},down=device_commands.ABSon,cockpit_device_id=devices.GEAR_BRAKES,value_down=1.0,name=_('ABS On/Off'),category=_('Gears, brakes and chute')},
{combos={{key='W',reformers={'LAlt'}}},down=device_commands.NosegearBrake,cockpit_device_id=devices.GEAR_BRAKES,value_down=1.0,name=_('Nosegear Brake On/Off'),category=_('Gears, brakes and chute')},
{combos={{key='W',reformers={'LCtrl'}}},down=device_commands.EmergBrakes,cockpit_device_id=devices.GEAR_BRAKES,value_down=1.0,name=_('Emergency Braking On/Off'),category=_('Gears, brakes and chute')},

-- Chute *cover
{combos={{key='P'}},down=device_commands.DragChute,up=device_commands.DragChute, cockpit_device_id=devices.CHUTE,value_down=1.0,value_up=0.0,name=_('Drag Chute - Activate'),category=_('Gears, brakes and chute')},
{combos={{key='D',reformers={'RShift','RCtrl'}}},down=device_commands.DragChuteDisconnect,up=device_commands.DragChuteDisconnect,cockpit_device_id=devices.CHUTE,value_down=1.0,value_up=0.0,name=_('Drag Chute - Disconnect'),category=_('Gears, brakes and chute')},
{combos={{key='D',reformers={'RAlt'}}},down=device_commands.DragChuteSafetyCover,cockpit_device_id=devices.CHUTE,value_down=1.0,name=_('Button Cap Open/Close (for Disconnect Drag Chute)'),category=_('Gears, brakes and chute')},

--************************* SPRD or ASO ***********************************************************************

-- SPRD / ASO
{combos={{key='J',reformers={'LCtrl'}}},down=device_commands.SPRDstartOn,cockpit_device_id=devices.SPRD,value_down=1,name=_('SPRD (or ASO), Power On/Off'),category=_('SPRD or ASO Chaff/Flares')},
{combos={{key='J',reformers={'LAlt'}}},down=device_commands.SPRDdropOn,cockpit_device_id=devices.SPRD,value_down=1,name=_('SPRD (or ASO) drop, Power On/Off'),category=_('SPRD or ASO Chaff/Flares')},
{combos={{key='J',reformers={'RCtrl'}}},down=device_commands.SPRDstartSafetyCover,cockpit_device_id=devices.SPRD,value_down=1,name=_('SPRD (or ASO), Start Cover, Open/Close'),category=_('SPRD or ASO Chaff/Flares')},
{down=device_commands.SPRDstartSafetyCover_2pos,cockpit_device_id=devices.SPRD,value_down=1.0,name=_('SPRD (or ASO), Start Cover, Open'),category=_('SPRD or ASO Chaff/Flares')},
{down=device_commands.SPRDstartSafetyCover_2pos,cockpit_device_id=devices.SPRD,value_down=0.0,name=_('SPRD (or ASO), Start Cover, Close'),category=_('SPRD or ASO Chaff/Flares')},
{combos={{key='J',reformers={'RShift'}}},down=device_commands.SPRDdropSafetyCover,cockpit_device_id=devices.SPRD,value_down=1,name=_('SPRD (or ASO), Drop Cover, Open/Close'),category=_('SPRD or ASO Chaff/Flares')},
{down=device_commands.SPRDdropSafetyCover_2pos,cockpit_device_id=devices.SPRD,value_down=1.0,name=_('SPRD (or ASO), Drop Cover, Open'),category=_('SPRD or ASO Chaff/Flares')},
{down=device_commands.SPRDdropSafetyCover_2pos,cockpit_device_id=devices.SPRD,value_down=0.0,name=_('SPRD (or ASO), Drop Cover, Close'),category=_('SPRD or ASO Chaff/Flares')},
{combos={{key='Space',reformers={'LShift'}}},down=device_commands.SPRDstart,up=device_commands.SPRDstart,cockpit_device_id=devices.SPRD,value_down=1.0,value_up=0.0,name=_('SPRD Start'),category=_('SPRD or ASO Chaff/Flares')},
{combos={{key='Space',reformers={'LCtrl'}}},down=device_commands.SPRDdrop,up=device_commands.SPRDdrop,cockpit_device_id=devices.SPRD,value_down=1.0,value_up=0.0,name=_('SPRD Drop / or ASO drop chaff flares'),category=_('SPRD or ASO Chaff/Flares')},

--************************** General *******************************************************************************

{combos={{key='E',reformers={'LCtrl'}}},down=iCommandPlaneEject,name=_('Eject (3 times)'),category=_('General')},
{combos={{key='T'}},down=iCommandPlaneWingtipSmokeOnOff,name=_('Smoke'),category=_('General')},

{combos = {{key = "Enter", reformers = {'RCtrl'}}}, down = iCommandPlane_ShowControls, name=_('Show controls indicator'),category=_('General')},

-- Gameplay
--{combos={{key='Esc'}},down=iCommandQuit,name=_('End mission'),category=_('General')},
--{combos={{key='Pause'}},down=iCommandBrakeGo,name=_('Pause'),category=_('General')},
--{combos={{key='Z',reformers={'LCtrl'}}},down=iCommandAccelerate,name=_('Time accelerate'),category=_('General')},
--{combos={{key='Z',reformers={'LWin','LCtrl'}}},down=iCommandDecelerate,name=_('Time decelerate'),category=_('General')},
--{combos={{key='Z',reformers={'LShift'}}},down=iCommandNoAcceleration,name=_('Time normal'),category=_('General')},
{combos={{key='\''}},down=iCommandScoresWindowToggle,name=_('Score window'),category=_('General')},
{combos={{key=','}},down=iCommandDebriefing,name=_('Show debriefing window'),category=_('General')},
{combos={{key='.'}},down=iCommandMissionResourcesManagement,name=_('Rearming and Refueling Window'),category=_('General')},

{combos={{key='Y',reformers={'LCtrl'}}},down=iCommandInfoOnOff,name=_('Info bar view toggle'),category=_('General')},
{combos={{key='Tab',reformers={'RCtrl','RShift'}}},down=iCommandRecoverHuman,name=_('Get new plane - respawn'),category=_('General')},
{combos={{key='J',reformers={'RAlt'}}},down=iCommandPlaneJump,name=_('Jump into other aircraft'),category=_('General')},
{combos={{key='SysRQ'}},down=iCommandScreenShot,name=_('Screenshot'),category=_('General')},
{combos={{key='Y',reformers={'LAlt'}}},down=iCommandViewCoordinatesInLinearUnits,name=_('Info bar coordinate units toggle'),category=_('General')},
{combos={{key='C',reformers={'LAlt','LShift'}}},down=iCommandCockpitClickModeOnOff,name=_('Mouse cursor cockpit mode'),category=_('General')},
{combos={{key='S',reformers={'LWin','LAlt'}}},down=iCommandSoundOnOff,name=_('Sound On/Off'),category=_('General')},
{combos={{key='Scroll',reformers={'RShift','RCtrl'}}},down=iCommandRecordCursorOnOff,name=_('Record of mouse cursor in track On/Off'),category=_('General')},
{combos={{key='Scroll',reformers={'RShift'}}},down=iCommandRecordSubtitleOn,name=_('Subtitle recording begin'),category=_('General')},
{combos={{key='Scroll',reformers={'RCtrl'}}},down=iCommandRecordSubtitleOff,name=_('Subtitle recording end'),category=_('General')},
{combos={{key='Pause',reformers={'LShift','LWin'}}},down=iCommandActivePauseOnOff,name=_('Active Pause'),category=_('General')},
--{combos={{key='Pause',reformers={'RShift','RCtrl'}}},down=iCommandActivePauseOnOff,name=_('Active Pause'),category=_('General')},
--{down = iCommandActivePauseOnOff, name=_('Active Pause'),category=_('General')},

-- Labels
{combos={{key='F10',reformers={'LShift'}}},down=iCommandMarkerState,name=_('All Labels'),category=_('General')},
{combos={{key='F2',reformers={'LShift'}}},down=iCommandMarkerStatePlane,name=_('Aircraft Labels'),category=_('General')},
{combos={{key='F6',reformers={'LShift'}}},down=iCommandMarkerStateRocket,name=_('Missile Labels'),category=_('General')},
{combos={{key='F9',reformers={'LShift'}}},down=iCommandMarkerStateShip,name=_('Vehicle & Ship Labels'),category=_('General')},

--**************************** Life support **************************************************************

{combos={{key='P',reformers={'LWin'}}},down=device_commands.EmergOxygene,cockpit_device_id=devices.OXYGENE_SYSTEM,value_down=1.0,name=_('Emergency O2 On/Off'),category=_('Life support')},
{combos={{key='P',reformers={'LCtrl'}}},down=device_commands.MixtureOxygeneSelect,cockpit_device_id=devices.OXYGENE_SYSTEM,value_down=1.0,name=_('Air - Mix / 100% O2'),category=_('Life support')},

-- Canopy
{combos={{key='C',reformers={'LCtrl'}}},down=device_commands.CanopyAntiIce,up=device_commands.CanopyAntiIce,cockpit_device_id=devices.CANOPY,value_down=1.0,value_up=0.0,name=_('Canopy Anti Icing'),category=_('Life support')},
{combos={{key='C',reformers={'RCtrl'}}},down=device_commands.CanopyClose,up=device_commands.CanopyClose,cockpit_device_id=devices.CANOPY,value_down=1.0,value_up=0.0,name=_('Canopy Close/Open'),category=_('Life support')},
{combos={{key='C',reformers={'LShift'}}},down=device_commands.CanopyLockHandle,cockpit_device_id=devices.CANOPY,value_down=1.0,name=_('Canopy Locked/Unlocked'),category=_('Life support')},
{combos={{key='C',reformers={'LAlt'}}},down=device_commands.CanopyHermetHandle,cockpit_device_id=devices.CANOPY,value_down=1.0,name=_('Canopy Pressurized On/Off'),category=_('Life support')},
{combos={{key='C',reformers={'LWin','LAlt'}}},down=device_commands.CanopyEmergRelease,cockpit_device_id=devices.CANOPY,value_down=1.0,name=_('Canopy Emergency jettison'),category=_('Life support')},

-- Helmet Visor
{combos={{key='Home',reformers={'LAlt'}}},down=device_commands.HelmetVisor,cockpit_device_id=devices.HELMET_VISOR,value_down=1.0,name=_('Helmet visor - On/Off'),category=_('Life support')},

--*************** Lights ***********************************************************************

-- Cockpit Lights
{combos={{key='Num+',reformers={'LAlt'}}},pressed=device_commands.TextBacklight_kb_up,up=device_commands.TextBacklight_kb_up,cockpit_device_id=devices.LIGHTS,value_pressed=1.0,value_up=0.0,name=_('Cockpit Texts Backlight +'),category=_('Lights')},
{combos={{key='Num-',reformers={'LAlt'}}},pressed=device_commands.TextBacklight_kb_down,up=device_commands.TextBacklight_kb_down,cockpit_device_id=devices.LIGHTS,value_pressed=-1.0,value_up=0.0,name=_('Cockpit Texts Backlight -'),category=_('Lights')},
{combos={{key='Num+',reformers={'LShift'}}},pressed=device_commands.InstrumentsBacklight_kb_up,up=device_commands.InstrumentsBacklight_kb_up,cockpit_device_id=devices.LIGHTS,value_pressed=1.0,value_up=0.0,name=_('Cockpit Instruments Backlight +'),category=_('Lights')},
{combos={{key='Num-',reformers={'LShift'}}},pressed=device_commands.InstrumentsBacklight_kb_down,up=device_commands.InstrumentsBacklight_kb_down,cockpit_device_id=devices.LIGHTS,value_pressed=-1.0,value_up=0.0,name=_('Cockpit Instruments Backlight -'),category=_('Lights')},
{combos={{key='Num+',reformers={'LCtrl'}}},pressed=device_commands.RedLightsMain_kb_up,up=device_commands.RedLightsMain_kb_up,cockpit_device_id=devices.LIGHTS,value_pressed=1.0,value_up=0.0,name=_('Cockpit Red Lights -'),category=_('Lights')},
{combos={{key='Num-',reformers={'LCtrl'}}},pressed=device_commands.RedLightsMain_kb_down,up=device_commands.RedLightsMain_kb_down,cockpit_device_id=devices.LIGHTS,value_pressed=-1.0,value_up=0.0,name=_('Cockpit Red Lights +'),category=_('Lights')},
{combos={{key='Num+',reformers={'LWin'}}},pressed=device_commands.WhiteLightsMain_kb_up,up=device_commands.WhiteLightsMain_kb_up,cockpit_device_id=devices.LIGHTS,value_pressed=1.0,value_up=0.0,name=_('Cockpit White Lights -'),category=_('Lights')},
{combos={{key='Num-',reformers={'LWin'}}},pressed=device_commands.WhiteLightsMain_kb_down,up=device_commands.WhiteLightsMain_kb_down,cockpit_device_id=devices.LIGHTS,value_pressed=-1.0,value_up=0.0,name=_('Cockpit White Lights +'),category=_('Lights')},

{combos={{key='L',reformers={'RCtrl'}}},down= 3256,cockpit_device_id=0,value_down=0,name=_('Pilot torch light on-off'),category=_('Lights')},--

--Landing Lights
{combos={{key='L',reformers={'LAlt'}}},down=device_commands.LandingLights,cockpit_device_id=devices.LIGHTS,value_down=0.5,name=_('Landing Lights'),category=_('Lights')},
{down=device_commands.LandingLights_Off,cockpit_device_id=devices.LIGHTS,value_down=0.0,name=_('Landing Lights OFF'),category=_('Lights')},
{down=device_commands.LandingLights_Taxi,cockpit_device_id=devices.LIGHTS,value_down=0.5,name=_('Landing Lights TAXI'),category=_('Lights')},
{down=device_commands.LandingLights_Landing,cockpit_device_id=devices.LIGHTS,value_down=1.0,name=_('Landing Lights LANDING'),category=_('Lights')},


-- Nav Lights
{combos={{key='L',reformers={'LShift'}}},down=device_commands.NavLights,cockpit_device_id=devices.LIGHTS,value_down=0.99,name=_('Nav Lights'),category=_('Lights')},
{combos={{key='L',reformers={'LAlt','LWin'}}},down=device_commands.CheckWarningLights10,up=device_commands.CheckWarningLights10,cockpit_device_id=devices.LIGHTS_WARNING,value_down=1.0,value_up=0.0,name=_('Check Warning Lights'),category=_('Lights')},

{combos={{key='Back'}},down=device_commands.SORC,up=device_commands.SORC,cockpit_device_id=devices.LIGHTS_WARNING,value_down=1.0,value_up=0.0,name=_('SORC'),category=_('Lights')},

--************** El. Power *****************************************************************

{combos={{key='I',reformers={'RShift'}}},down=device_commands.PO7501,cockpit_device_id=devices.AC_BUS,value_down=1.0,name=_('PO-750 Inverter #1'),category=_('Power')},
{combos={{key='I',reformers={'RAlt'}}},down=device_commands.PO7502,cockpit_device_id=devices.AC_BUS,value_down=1.0,name=_('PO-750 Inverter #2'),category=_('Power')},
{combos={{key='I',reformers={'RCtrl'}}},down=device_commands.EmergencyInverter,cockpit_device_id=devices.AC_BUS,value_down=1.0,name=_('Emergency Inverter'),category=_('Power')},
{combos={{key='O',reformers={'RShift'}}},down=device_commands.BatteryHeat,cockpit_device_id=devices.DC_BUS,value_down=1.0,name=_('Battery Heat'),category=_('Power')},
{combos={{key='O',reformers={'RAlt'}}},down=device_commands.BatteryOn,cockpit_device_id=devices.DC_BUS,value_down=1.0,name=_('Battery'),category=_('Power')},
{combos={{key='K',reformers={'RShift'}}},down=device_commands.DCGenerator,cockpit_device_id=devices.DC_BUS,value_down=1.0,name=_('DC Generator'),category=_('Power')},
{combos={{key='K',reformers={'RAlt'}}},down=device_commands.ACGenerator,cockpit_device_id=devices.AC_BUS,value_down=1.0,name=_('AC Generator'),category=_('Power')},
{combos={{key='L',reformers={'RShift'}}},down=device_commands.Giro1,cockpit_device_id=devices.GYRO_DEVICES,value_down=1.0,name=_('Giro,NPP,SAU,RLS Signal,KPP Power'),category=_('Power')},
{combos={{key='L',reformers={'RAlt'}}},down=device_commands.Giro2,cockpit_device_id=devices.GYRO_DEVICES,value_down=1.0,name=_('DA-200 Signal,Giro,NPP,RLS,SAU Power'),category=_('Power')},

--***************** Radar and Spo **********************************************************

-- Radar
{combos={{key='4',reformers={'LAlt'}}},down=device_commands.RADARon,cockpit_device_id=devices.RADAR,value_down=0.5,name=_('Radar Standby'),category=_('Radar and SPO')},
{combos={{key='4',reformers={'LShift','LAlt'}}},down=device_commands.RADARon,cockpit_device_id=devices.RADAR,value_down=1,name=_('Radar On'),category=_('Radar and SPO')},
{combos={{key='4',reformers={'LShift','LCtrl'}}},down=device_commands.RADARon,cockpit_device_id=devices.RADAR,value_down=0,name=_('Radar Off'),category=_('Radar and SPO')},

{combos={{key='5',reformers={'LAlt'}}},down=device_commands.RADARlowAlt,cockpit_device_id=devices.RADAR,value_down=0.5,name=_('Low Altitude Filter'),category=_('Radar and SPO')},
{combos={{key='5',reformers={'LShift','LAlt'}}},down=device_commands.RADARlowAlt,cockpit_device_id=devices.RADAR,value_down=1,name=_('Low Altitude Antenna Tilt'),category=_('Radar and SPO')},
{combos={{key='5',reformers={'LShift','LCtrl'}}},down=device_commands.RADARlowAlt,cockpit_device_id=devices.RADAR,value_down=0,name=_('Low Altitude Filter Off'),category=_('Radar and SPO')},

{combos={{key='6',reformers={'LAlt'}}},down=device_commands.RADARfixBeam,cockpit_device_id=devices.RADAR,value_down=1,name=_('Locked Beam On'),category=_('Radar and SPO')},
{combos={{key='6',reformers={'LShift','LCtrl'}}},down=device_commands.RADARfixBeam,cockpit_device_id=devices.RADAR,value_down=0,name=_('Locked Beam Off'),category=_('Radar and SPO')},

{combos={{key='O'}},pressed=device_commands.RUDoblog_kb_up,cockpit_device_id=devices.ASP,value_pressed=0.01,value_up=0.0,name=_('TDC Range / Pipper Span +'),category=_('Radar and SPO')},
{combos={{key='L'}},pressed=device_commands.RUDoblog_kb_down,cockpit_device_id=devices.ASP,value_pressed=0.01,value_up=0.0,name=_('TDC Range / Pipper Span -'),category=_('Radar and SPO')},

{combos={{key='Enter'}},down=device_commands.Zahvat,up=device_commands.Zahvat,cockpit_device_id=devices.RADAR,value_down=1.0,value_up=0.0,name=_('Target Lock On'),category=_('Radar and SPO')},

{combos={{key='Q',reformers={'LShift'}}},down=device_commands.RADARjamCont,up=device_commands.RADARjamCont,cockpit_device_id=devices.RADAR,value_down=1,value_up=0,name=_('Radar ECM protection panel - Continues'),category=_('Radar and SPO')},
{combos={{key='W',reformers={'LShift'}}},down=device_commands.RADARjamTmp,up=device_commands.RADARjamTmp,cockpit_device_id=devices.RADAR,value_down=1,value_up=0,name=_('Radar ECM protection panel - Temporary'),category=_('Radar and SPO')},
{combos={{key='E',reformers={'LShift'}}},down=device_commands.RADARjamPass,up=device_commands.RADARjamPass,cockpit_device_id=devices.RADAR,value_down=1,value_up=0,name=_('Radar ECM protection panel - Passive'),category=_('Radar and SPO')},
{combos={{key='R'}},down=device_commands.RADARjamMeteo,up=device_commands.RADARjamMeteo,cockpit_device_id=devices.RADAR,value_down=1,value_up=0,name=_('Radar ECM protection panel - Weather'),category=_('Radar and SPO')},
{combos={{key='A',reformers={'LShift'}}},down=device_commands.RADARvopros,up=device_commands.RADARvopros,cockpit_device_id=devices.RADAR,value_down=1,value_up=0,name=_('Radar ECM protection panel - IFF'),category=_('Radar and SPO')},
{combos={{key='S',reformers={'LShift'}}},down=device_commands.RADARjamLowSpeed,up=device_commands.RADARjamLowSpeed,cockpit_device_id=devices.RADAR,value_down=1,value_up=0,name=_('Radar ECM protection panel - Low Speed Target'),category=_('Radar and SPO')},
{combos={{key='D',reformers={'LShift'}}},down=device_commands.RADARkontrol,up=device_commands.RADARkontrol,cockpit_device_id=devices.RADAR,value_down=1,value_up=0,name=_('Radar ECM protection panel - Selftest'),category=_('Radar and SPO')},
{combos={{key='F',reformers={'LShift','LCtrl'}}},down=device_commands.RADARreset,up=device_commands.RADARreset,cockpit_device_id=devices.RADAR,value_down=1.0,value_up=0.0,name=_('Radar ECM protection panel - Reset'),category=_('Radar and SPO')},

-- SPO - RWR
{combos={{key='Z',reformers={'RShift'}}},down=device_commands.SPOon,cockpit_device_id=devices.SPO,value_down=1,name=_('SPO-10 RWR On/Off'),category=_('Radar and SPO')},
{combos={{key='Z',reformers={'RAlt'}}},down=device_commands.SPOdayNight,cockpit_device_id=devices.SPO,value_down=1,name=_('SPO-10 Day/Night lights'),category=_('Radar and SPO')},
{combos={{key='Z',reformers={'RCtrl'}}},down=device_commands.SPOtest,up=device_commands.SPOtest,cockpit_device_id=devices.SPO,value_down=1.0,value_up=0.0,name=_('SPO-10 Test'),category=_('Radar and SPO')},

--***************************************** Radio *************************************************************

{combos={{key='\\'--[[,reformers={'RCtrl'}]]}},down=device_commands.RadioINTERCOM,up=device_commands.RadioINTERCOM,cockpit_device_id=devices.INTERCOM,value_down=1.0,value_up=0.0,name=_('Intercomm menu'),category=_('Radio Communications')},


{combos={{key='Q',reformers={'LWin'}}},down=iCommandAWACSBanditBearing,name=_('Request AWACS Nearest Bandit'),category=_('Radio Communications')},
{combos={{key='W',reformers={'LWin'}}},down=iCommandPlaneDoAndBack,name=_('Flight - Complete mission and rejoin'),category=_('Radio Communications')},
{combos={{key='E',reformers={'LWin'}}},down=iCommandPlaneDoAndHome,name=_('Flight - Complete mission and RTB'),category=_('Radio Communications')},
{combos={{key='S',reformers={'LWin'}}},down=iCommandPlane_EngageAirDefenses,name=_('Flight - Attack air defenses'),category=_('Radio Communications')},
{combos={{key='D',reformers={'LWin'}}},down=iCommandPlane_EngageGroundTargets,name=_('Flight - Attack ground targets'),category=_('Radio Communications')},
{combos={{key='X',reformers={'LWin'}}},down=iCommandPlaneCoverMySix,name=_('Cover Me'),category=_('Radio Communications')},
{combos={{key='C',reformers={'LWin'}}},down=iCommandPlaneAttackMyTarget,name=_('Attack My Target'),category=_('Radio Communications')},
{combos={{key='R',reformers={'LWin'}}},down=iCommandPlaneFormation,name=_('Toggle Formation'),category=_('Radio Communications')},
{combos={{key='T',reformers={'LWin'}}},down=iCommandPlaneJoinUp,name=_('Join Up Formation'),category=_('Radio Communications')},
{combos={{key='A',reformers={'LWin'}}},down=iCommandAWACSHomeBearing,name=_('Request AWACS Home Airbase'),category=_('Radio Communications')},

--******************************* Views *************************************************************************
--Defaults

{combos={{key=']',reformers={'LShift'}}},down=iCommandViewFastKeyboard,name=_('Keyboard Rate Fast'),category=_('View')},
{combos={{key=']',reformers={'LCtrl'}}},down=iCommandViewSlowKeyboard,name=_('Keyboard Rate Slow'),category=_('View')},
{combos={{key=']',reformers={'LAlt'}}},down=iCommandViewNormalKeyboard,name=_('Keyboard Rate Normal'),category=_('View')},
{combos={{key='[',reformers={'LShift'}}},down=iCommandViewFastMouse,name=_('Mouse Rate Fast'),category=_('View')},
{combos={{key='[',reformers={'LCtrl'}}},down=iCommandViewSlowMouse,name=_('Mouse Rate Slow'),category=_('View')},
{combos={{key='[',reformers={'LAlt'}}},down=iCommandViewNormalMouse,name=_('Mouse Rate Normal'),category=_('View')},

-- Save current cockpit camera angles for fast numpad jumps 
{combos={{key='Num0',reformers={'RAlt'}}},down=iCommandViewSaveAngles,name=_('Save Cockpit Angles'),category=_('View')},
{combos={{key='Num8',reformers={'RShift'}}},pressed=iCommandViewUp,up=iCommandViewStop,name=_('View up'),category=_('View')},
{combos={{key='Num2',reformers={'RShift'}}},pressed=iCommandViewDown,up=iCommandViewStop,name=_('View down'),category=_('View')},
{combos={{key='Num4',reformers={'RShift'}}},pressed=iCommandViewLeft,up=iCommandViewStop,name=_('View left'),category=_('View')},
{combos={{key='Num6',reformers={'RShift'}}},pressed=iCommandViewRight,up=iCommandViewStop,name=_('View right'),category=_('View')},
{combos={{key='Num9',reformers={'RShift'}}},pressed=iCommandViewUpRight,up=iCommandViewStop,name=_('View up right'),category=_('View')},
{combos={{key='Num3',reformers={'RShift'}}},pressed=iCommandViewDownRight,up=iCommandViewStop,name=_('View down right'),category=_('View')},
{combos={{key='Num1',reformers={'RShift'}}},pressed=iCommandViewDownLeft,up=iCommandViewStop,name=_('View down left'),category=_('View')},
{combos={{key='Num7',reformers={'RShift'}}},pressed=iCommandViewUpLeft,up=iCommandViewStop,name=_('View up left'),category=_('View')},

-- View 
{combos={{key='Num4'}},pressed=iCommandViewLeftSlow,up=iCommandViewStopSlow,name=_('View Left slow'),category=_('View')},
{combos={{key='Num6'}},pressed=iCommandViewRightSlow,up=iCommandViewStopSlow,name=_('View Right slow'),category=_('View')},
{combos={{key='Num8'}},pressed=iCommandViewUpSlow,up=iCommandViewStopSlow,name=_('View Up slow'),category=_('View')},
{combos={{key='Num2'}},pressed=iCommandViewDownSlow,up=iCommandViewStopSlow,name=_('View Down slow'),category=_('View')},
{combos={{key='Num9'}},pressed=iCommandViewUpRightSlow,up=iCommandViewStopSlow,name=_('View Up Right slow'),category=_('View')},
{combos={{key='Num3'}},pressed=iCommandViewDownRightSlow,up=iCommandViewStopSlow,name=_('View Down Right slow'),category=_('View')},
{combos={{key='Num1'}},pressed=iCommandViewDownLeftSlow,up=iCommandViewStopSlow,name=_('View Down Left slow'),category=_('View')},
{combos={{key='Num7'}},pressed=iCommandViewUpLeftSlow,up=iCommandViewStopSlow,name=_('View Up Left slow'),category=_('View')},
{combos={{key='Num5'}},pressed=iCommandViewCenter,name=_('View Center'),category=_('View')},

-- F views
{combos={{key='F1'}},down=iCommandViewCockpit,name=_('F1 Cockpit view'),category=_('View')},
{combos={{key='F1',reformers={'LCtrl'}}},down=iCommandNaturalViewCockpitIn,name=_('F1 Natural head movement view'),category=_('View')},
{combos={{key='F1',reformers={'LAlt'}}},down=iCommandViewHUDOnlyOnOff,name=_('F1 HUD only view switch'),category=_('View')},
{combos={{key='F2'}},down=iCommandViewAir,name=_('F2 Aircraft view'),category=_('View')},
{combos={{key='F2',reformers={'LCtrl'}}},down=iCommandViewMe,name=_('F2 View own aircraft'),category=_('View')},
{combos={{key='F2',reformers={'RAlt'}}},down=iCommandViewFromTo,name=_('F2 Toggle camera position'),category=_('View')},
{combos={{key='F2',reformers={'LAlt'}}},down=iCommandViewLocal,name=_('F2 Toggle local camera control'),category=_('View')},
{combos={{key='F3'}},down=iCommandViewTower,name=_('F3 Fly-By view'),category=_('View')},
{combos={{key='F3',reformers={'LCtrl'}}},down=iCommandViewTowerJump,name=_('F3 Fly-By jump view'),category=_('View')},
{combos={{key='F4'}},down=iCommandViewRear,name=_('F4 Look back view'),category=_('View')},
{combos={{key='F4',reformers={'LCtrl'}}},down=iCommandViewChase,name=_('F4 Chase view'),category=_('View')},
{combos={{key='F5'}},down=iCommandViewFight,name=_('F5 nearest AC view'),category=_('View')},
{combos={{key='F5',reformers={'LCtrl'}}},down=iCommandViewFightGround,name=_('F5 Ground hostile view'),category=_('View')},
{combos={{key='F6'}},down=iCommandViewWeapons,name=_('F6 Released weapon view'),category=_('View')},
{combos={{key='F6',reformers={'LCtrl'}}},down=iCommandViewWeaponAndTarget,name=_('F6 Weapon to target view'),category=_('View')},
{combos={{key='F7'}},down=iCommandViewGround,name=_('F7 Ground unit view'),category=_('View')},
--{combos={{key='F8'}},down=iCommandViewTargets,name=_('F8 Target view'),category=_('View')},
--{combos={{key='F8',reformers={'RCtrl'}}},down=iCommandViewTargetType,name=_('F8 Player targets/All targets filter'),category=_('View')},
{combos={{key='F9'}},down=iCommandViewNavy,name=_('F9 Ship view'),category=_('View')},
{combos={{key='F9',reformers={'LAlt'}}},down=iCommandViewLndgOfficer,name=_('F9 Landing signal officer view'),category=_('View')},
{combos={{key='F10'}},down=iCommandViewAWACS,name=_('F10 Theater map view'),category=_('View')},
{combos={{key='F10',reformers={'LCtrl'}}},down=iCommandViewAWACSJump,name=_('F10 Jump to theater map view over current point'),category=_('View')},
{combos={{key='F11'}},down=iCommandViewFree,name=_('F11 Airport free camera'),category=_('View')},
{combos={{key='F11',reformers={'LCtrl'}}},down=iCommandViewFreeJump,name=_('F11 Jump to free camera'),category=_('View')},
{combos={{key='F12'}},down=iCommandViewStatic,name=_('F12 Static object view'),category=_('View')},
{combos={{key='F12',reformers={'LCtrl'}}},down=iCommandViewMirage,name=_('F12 Civil traffic view'),category=_('View')},
{combos={{key='F12',reformers={'LShift'}}},down=iCommandViewLocomotivesToggle,name=_('F12 Trains/cars toggle'),category=_('View')},
{combos={{key='F1',reformers={'LCtrl','LShift'}}},down=iCommandViewPitHeadOnOff,name=_('F1 Head shift movement on / off'),category=_('View')},

{combos={{key='Num*'}},pressed=iCommandViewForwardSlow,up=iCommandViewForwardSlowStop,name=_('Zoom in slow'),category=_('View')},
{combos={{key='Num/'}},pressed=iCommandViewBackSlow,up=iCommandViewBackSlowStop,name=_('Zoom out slow'),category=_('View')},
{combos={{key='NumEnter'}},down=iCommandViewAngleDefault,name=_('Zoom normal'),category=_('View')},
{combos={{key='Num*',reformers={'RCtrl'}}},pressed=iCommandViewExternalZoomIn,up=iCommandViewExternalZoomInStop,name=_('Zoom external in'),category=_('View')},
{combos={{key='Num/',reformers={'RCtrl'}}},pressed=iCommandViewExternalZoomOut,up=iCommandViewExternalZoomOutStop,name=_('Zoom external out'),category=_('View')},
{combos={{key='NumEnter',reformers={'RCtrl'}}},down=iCommandViewExternalZoomDefault,name=_('Zoom external normal'),category=_('View')},
{combos={{key='Num*',reformers={'LAlt'}}},down=iCommandViewSpeedUp,name=_('F11 Camera moving forward'),category=_('View')},
{combos={{key='Num/',reformers={'LAlt'}}},down=iCommandViewSlowDown,name=_('F11 Camera moving backward'),category=_('View')},

-- Cockpit view
{combos={{key='Num0'}},down=iCommandViewTempCockpitOn,up=iCommandViewTempCockpitOff,name=_('Cockpit panel view in'),category=_('View')},
{combos={{key='Num0',reformers={'RCtrl'}}},down=iCommandViewTempCockpitToggle,name=_('Cockpit panel view toggle'),category=_('View')},

-- Cockpit Camera Motion
{combos={{key='Num8',reformers={'RCtrl','RShift'}}},pressed=iCommandViewPitCameraMoveUp,up=iCommandViewPitCameraMoveStop,name=_('Cockpit Camera Move Up'),category=_('View')},
{combos={{key='Num2',reformers={'RCtrl','RShift'}}},pressed=iCommandViewPitCameraMoveDown,up=iCommandViewPitCameraMoveStop,name=_('Cockpit Camera Move Down'),category=_('View')},
{combos={{key='Num4',reformers={'RCtrl','RShift'}}},pressed=iCommandViewPitCameraMoveLeft,up=iCommandViewPitCameraMoveStop,name=_('Cockpit Camera Move Left'),category=_('View')},
{combos={{key='Num6',reformers={'RCtrl','RShift'}}},pressed=iCommandViewPitCameraMoveRight,up=iCommandViewPitCameraMoveStop,name=_('Cockpit Camera Move Right'),category=_('View')},
{combos={{key='Num*',reformers={'RCtrl','RShift'}}},pressed=iCommandViewPitCameraMoveForward,up=iCommandViewPitCameraMoveStop,name=_('Cockpit Camera Move Forward'),category=_('View')},
{combos={{key='Num/',reformers={'RCtrl','RShift'}}},pressed=iCommandViewPitCameraMoveBack,up=iCommandViewPitCameraMoveStop,name=_('Cockpit Camera Move Back'),category=_('View')},
{combos={{key='Num5',reformers={'RCtrl','RShift'}}},down=iCommandViewPitCameraMoveCenter,name=_('Cockpit Camera Move Center'),category=_('View')},

{combos={{key='Num8',reformers={'RCtrl'}}},down=iCommandViewCameraUp,up=iCommandViewCameraCenter,name=_('Glance up'),category=_('View')},
{combos={{key='Num2',reformers={'RCtrl'}}},down=iCommandViewCameraDown,up=iCommandViewCameraCenter,name=_('Glance down'),category=_('View')},
{combos={{key='Num4',reformers={'RCtrl'}}},down=iCommandViewCameraLeft,up=iCommandViewCameraCenter,name=_('Glance left'),category=_('View')},
{combos={{key='Num6',reformers={'RCtrl'}}},down=iCommandViewCameraRight,up=iCommandViewCameraCenter,name=_('Glance right'),category=_('View')},
{combos={{key='Num7',reformers={'RCtrl'}}},down=iCommandViewCameraUpLeft,up=iCommandViewCameraCenter,name=_('Glance up-left'),category=_('View')},
{combos={{key='Num1',reformers={'RCtrl'}}},down=iCommandViewCameraDownLeft,up=iCommandViewCameraCenter,name=_('Glance down-left'),category=_('View')},
{combos={{key='Num9',reformers={'RCtrl'}}},down=iCommandViewCameraUpRight,up=iCommandViewCameraCenter,name=_('Glance up-right'),category=_('View')},
{combos={{key='Num3',reformers={'RCtrl'}}},down=iCommandViewCameraDownRight,up=iCommandViewCameraCenter,name=_('Glance down-right'),category=_('View')},
{combos={{key='Z',reformers={'LAlt','LShift'}}},down=iCommandViewPanToggle,name=_('Camera pan mode toggle'),category=_('View')},

{combos={{key='Num8',reformers={'RAlt'}}},down=iCommandViewCameraUpSlow,name=_('Camera snap view up'),category=_('View')},
{combos={{key='Num2',reformers={'RAlt'}}},down=iCommandViewCameraDownSlow,name=_('Camera snap view down'),category=_('View')},
{combos={{key='Num4',reformers={'RAlt'}}},down=iCommandViewCameraLeftSlow,name=_('Camera snap view left'),category=_('View')},
{combos={{key='Num6',reformers={'RAlt'}}},down=iCommandViewCameraRightSlow,name=_('Camera snap view right'),category=_('View')},
{combos={{key='Num7',reformers={'RAlt'}}},down=iCommandViewCameraUpLeftSlow,name=_('Camera snap view up-left'),category=_('View')},
{combos={{key='Num1',reformers={'RAlt'}}},down=iCommandViewCameraDownLeftSlow,name=_('Camera snap view down-left'),category=_('View')},
{combos={{key='Num9',reformers={'RAlt'}}},down=iCommandViewCameraUpRightSlow,name=_('Camera snap view up-right'),category=_('View')},
{combos={{key='Num3',reformers={'RAlt'}}},down=iCommandViewCameraDownRightSlow,name=_('Camera snap view down-right'),category=_('View')},
{combos={{key='Num5',reformers={'RShift'}}},down=iCommandViewCameraCenter,name=_('Center Camera View'),category=_('View')},
{combos={{key='Num5',reformers={'RCtrl'}}},down=iCommandViewCameraReturn,name=_('Return Camera'),category=_('View')},
{combos={{key='Num5',reformers={'RAlt'}}},down=iCommandViewCameraBaseReturn,name=_('Return Camera Base'),category=_('View')},

{combos={{key='Num0',reformers={'LWin'}}},down=iCommandViewSnapView0,up=iCommandViewSnapViewStop,name=_('Custom Snap View 0'),category=_('View')},
{combos={{key='Num1',reformers={'LWin'}}},down=iCommandViewSnapView1,up=iCommandViewSnapViewStop,name=_('Custom Snap View 1'),category=_('View')},
{combos={{key='Num2',reformers={'LWin'}}},down=iCommandViewSnapView2,up=iCommandViewSnapViewStop,name=_('Custom Snap View 2'),category=_('View')},
{combos={{key='Num3',reformers={'LWin'}}},down=iCommandViewSnapView3,up=iCommandViewSnapViewStop,name=_('Custom Snap View 3'),category=_('View')},
{combos={{key='Num4',reformers={'LWin'}}},down=iCommandViewSnapView4,up=iCommandViewSnapViewStop,name=_('Custom Snap View 4'),category=_('View')},
{combos={{key='Num5',reformers={'LWin'}}},down=iCommandViewSnapView5,up=iCommandViewSnapViewStop,name=_('Custom Snap View 5'),category=_('View')},
{combos={{key='Num6',reformers={'LWin'}}},down=iCommandViewSnapView6,up=iCommandViewSnapViewStop,name=_('Custom Snap View 6'),category=_('View')},
{combos={{key='Num7',reformers={'LWin'}}},down=iCommandViewSnapView7,up=iCommandViewSnapViewStop,name=_('Custom Snap View 7'),category=_('View')},
{combos={{key='Num8',reformers={'LWin'}}},down=iCommandViewSnapView8,up=iCommandViewSnapViewStop,name=_('Custom Snap View 8'),category=_('View')},
{combos={{key='Num9',reformers={'LWin'}}},down=iCommandViewSnapView9,up=iCommandViewSnapViewStop,name=_('Custom Snap View 9'),category=_('View')},

{combos={{key='Num8',reformers={'RWin'}}},down=iCommandViewLeftMirrorOn,up=iCommandViewLeftMirrorOff,name=_('Mirror View'),category=_('View')},

{combos={{key='Num*',reformers={'RShift'}}},pressed=iCommandViewForward,up=iCommandViewForwardStop,name=_('Zoom in'),category=_('View')},
{combos={{key='Num/',reformers={'RShift'}}},pressed=iCommandViewBack,up=iCommandViewBackStop,name=_('Zoom out'),category=_('View')},


-- Extended view
{combos={{key='J',reformers={'LShift'}}},down=iCommandViewCameraJiggle,name=_('Camera jiggle toggle'),category=_('View')},
{combos={{key='K',reformers={'LAlt'}}},down=iCommandViewKeepTerrain,name=_('Keep terrain camera altitude'),category=_('View')},
{combos={{key='Home',reformers={'RCtrl','RShift'}}},down=iCommandViewFriends,name=_('View friends mode'),category=_('View')},
{combos={{key='End',reformers={'RCtrl','RShift'}}},down=iCommandViewEnemies,name=_('View enemies mode'),category=_('View')},
{combos={{key='Delete',reformers={'RCtrl'}}},down=iCommandViewAll,name=_('View all mode'),category=_('View')},
{combos={{key='Num+',reformers={'RCtrl'}}},down=iCommandViewPlus,name=_('Toggle tracking fire weapon'),category=_('View')},
{combos={{key='PageDown',reformers={'LCtrl'}}},down=iCommandViewSwitchForward,name=_('Objects switching direction forward '),category=_('View')},
{combos={{key='PageUp',reformers={'LCtrl'}}},down=iCommandViewSwitchReverse,name=_('Objects switching direction reverse '),category=_('View')},
{combos={{key='Delete',reformers={'LAlt'}}},down=iCommandViewObjectIgnore,name=_('Object exclude '),category=_('View')},
{combos={{key='Insert',reformers={'LAlt'}}},down=iCommandViewObjectsAll,name=_('Objects all excluded - include'),category=_('View')},

-- Padlock
{combos={{key='Num.'}},down=iCommandViewLock,name=_('Lock View (cycle padlock)'),category=_('View')},
{combos={{key='NumLock'}},down=iCommandViewUnlock,name=_('Unlock view (stop padlock)'),category=_('View')},
{combos={{key='Num.',reformers={'RShift'}}},down=iCommandAllMissilePadlock,name=_('All missiles padlock'),category=_('View')},
{combos={{key='Num.',reformers={'RAlt'}}},down=iCommandThreatMissilePadlock,name=_('Threat missile padlock'),category=_('View')},
{combos={{key='Num.',reformers={'RCtrl'}}},down=iCommandViewTerrainLock,name=_('Lock terrain view'),category=_('View')},

--**************************** Weapons management /// several sub cats ********************************************************** 

--***************************** Weapons management / ASP *********************************************************

-- ASP Gunsight
{combos={{key='1',reformers={'LShift'}}},down=device_commands.ASPmissileGunSelect,cockpit_device_id=devices.ASP,value_down=1.0,name=_('ASP Mode - Gun/Missiles-Rockets'),category=_('Weapons / ASP')},
{down=device_commands.ASPmissileGunSelect_2pos,cockpit_device_id=devices.ASP,value_down=1.0,name=_('ASP Mode - Gun'),category=_('Weapons / ASP')},
{down=device_commands.ASPmissileGunSelect_2pos,cockpit_device_id=devices.ASP,value_down=0.0,name=_('ASP Mode - Missiles-Rockets'),category=_('Weapons / ASP')},
{combos={{key='2',reformers={'LShift'}}},down=device_commands.ASPbombStrelbSelect,cockpit_device_id=devices.ASP,value_down=1.0,name=_('ASP Mode - Shooting/Bombardment'),category=_('Weapons / ASP')},
{down=device_commands.ASPbombStrelbSelect_2pos,cockpit_device_id=devices.ASP,value_down=1.0,name=_('ASP Mode - Shooting'),category=_('Weapons / ASP')},
{down=device_commands.ASPbombStrelbSelect_2pos,cockpit_device_id=devices.ASP,value_down=0.0,name=_('ASP Mode - Bombardment'),category=_('Weapons / ASP')},
{combos={{key='3',reformers={'LShift'}}},down=device_commands.ASPmanAutoSelect,cockpit_device_id=devices.ASP,value_down=1.0,name=_('ASP Main Mode - Auto/Manual'),category=_('Weapons / ASP')},
{down=device_commands.ASPmanAutoSelect_2pos,cockpit_device_id=devices.ASP,value_down=1.0,name=_('ASP Main Mode - Auto'),category=_('Weapons / ASP')},
{down=device_commands.ASPmanAutoSelect_2pos,cockpit_device_id=devices.ASP,value_down=0.0,name=_('ASP Main Mode - Manual'),category=_('Weapons / ASP')},
{combos={{key='4',reformers={'LShift'}}},down=device_commands.ASPssGiroSelect,cockpit_device_id=devices.ASP,value_down=1.0,name=_('ASP Mode - Giro/Missiles'),category=_('Weapons / ASP')},
{down=device_commands.ASPssGiroSelect_2pos,cockpit_device_id=devices.ASP,value_down=1.0,name=_('ASP Mode - Giro'),category=_('Weapons / ASP')},
{down=device_commands.ASPssGiroSelect_2pos,cockpit_device_id=devices.ASP,value_down=0.0,name=_('ASP Mode - Missiles'),category=_('Weapons / ASP')},
{combos={{key='V',reformers={'RShift'}}},down=device_commands.ASPon,cockpit_device_id=devices.ASP,value_down=1.0,name=_('ASP-17 Gunsight On/Off'),category=_('Weapons / ASP')},
{combos={{key='C',reformers={'RShift'}}},down=device_commands.ASPpipperOn,cockpit_device_id=devices.ASP,value_down=1.0,name=_('Pipper On/Off'),category=_('Weapons / ASP')},
{combos={{key='X',reformers={'RShift'}}},down=device_commands.ASPnetOn,cockpit_device_id=devices.ASP,value_down=1.0,name=_('Fix net On/Off'),category=_('Weapons / ASP')},

--***************************** Weapons management / SELECTOR *********************************************************

-- Weapon selector
{combos={{key='1'}},down=device_commands.ASPlauncherSelect,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.7,name=_('Select Weapon AA 1'),category=_('Weapons / Select')},
{combos={{key='2'}},down=device_commands.ASPlauncherSelect,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.8,name=_('Select Weapon AA 2'),category=_('Weapons / Select')},
{combos={{key='3'}},down=device_commands.ASPlauncherSelect,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.9,name=_('Select Weapon AA 3'),category=_('Weapons / Select')},
{combos={{key='4'}},down=device_commands.ASPlauncherSelect,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Select Weapon AA 4'),category=_('Weapons / Select')},
{combos={{key='5'}},down=device_commands.ASPlauncherSelect,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.0,name=_('Select Weapon B 1-2 / UB-16'),category=_('Weapons / Select')},
{combos={{key='6'}},down=device_commands.ASPlauncherSelect,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.1,name=_('Select Weapon B 3-4 / UB-8'),category=_('Weapons / Select')},
{combos={{key='7'}},down=device_commands.ASPlauncherSelect,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.2,name=_('Select Weapon B 1-4 / UB-4'),category=_('Weapons / Select')},

{combos={{key='8'}},down=device_commands.ASPlauncherSelect,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.3,name=_('Select Weapon S-24 1-2'),category=_('Weapons / Select')},
{combos={{key='9'}},down=device_commands.ASPlauncherSelect,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.4,name=_('Select Weapon S-24 3-4'),category=_('Weapons / Select')},

{combos={{key='0'}},down=device_commands.ASPlauncherSelect,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.5,name=_('Select Weapon AA 3-4'),category=_('Weapons / Select')},
{combos={{key='-'}},down=device_commands.ASPlauncherSelect,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.6,name=_('Select Weapon AA 1-2'),category=_('Weapons / Select')},


--/N/ 05.02.2016. 2-way circular toggle weapon selector
{down=iCommandHelicopter_SelectWeapon_Internal,cockpit_device_id=devices.WEAPON_CONTROL,name=_('Select next weapon'),category=_('Weapons / Select')},
{down=iCommandHelicopter_SelectWeapon_External,cockpit_device_id=devices.WEAPON_CONTROL,name=_('Select previous weapon'),category=_('Weapons / Select')},

--***************************** Weapons management / Masters *********************************************************

--Master modes
{combos={{key='1',reformers={'LWin'}}},down=device_commands.ASPvozduhZemlja,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Master Mode - Air'),category=_('Weapons / Master control')},
{combos={{key='2',reformers={'LWin'}}},down=device_commands.ASPvozduhZemlja,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.0,name=_('Master Mode - Ground'),category=_('Weapons / Master control')},
{combos={{key='3',reformers={'LWin'}}},down=device_commands.ASPssNeutrRns,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.0,name=_('Weapon AA Mode - SAR Missile'),category=_('Weapons / Master control')},
{combos={{key='4',reformers={'LWin'}}},down=device_commands.ASPssNeutrRns,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Weapon AA Mode - IR Missile'),category=_('Weapons / Master control')},
{combos={{key='4',reformers={'LWin','LAlt'}}},down=device_commands.ASPssNeutrRns,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.5,name=_('Weapon Mode - Neutral'),category=_('Weapons / Master control')},

-- Weapon drop *cover
{combos={{key='Insert',reformers={'RShift'}}},down=device_commands.SbrosVnesnSafetyCover,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Jettison Outer Pylons - Safety Cover Open'),category=_('Weapons / Master control')},
{combos={{key='Insert',reformers={'RShift','RCtrl'}}},down=device_commands.SbrosVnesnSafetyCover,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.0,name=_('Jettison Outer Pylons - Safety Cover Close'),category=_('Weapons / Master control')},
{combos={{key='Insert',reformers={'RAlt'}}},down=device_commands.SbrosVnesn,up=device_commands.SbrosVnesn,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,value_up=0.0,name=_('Jettison Outer Pylons'),category=_('Weapons / Master control')},
{combos={{key='Delete',reformers={'RShift'}}},down=device_commands.SbrosVnutrSafetyCover,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Jettison Inner Pylons - Safety Cover Open'),category=_('Weapons / Master control')},
{combos={{key='Delete',reformers={'RShift','RCtrl'}}},down=device_commands.SbrosVnutrSafetyCover,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.0,name=_('Jettison Payload Inner Pylons - Safety Cover Close'),category=_('Weapons / Master control')},
{combos={{key='Delete',reformers={'RAlt'}}},down=device_commands.SbrosVnutr,up=device_commands.SbrosVnutr,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,value_up=0.0,name=_('Jettison Inner Pylons'),category=_('Weapons / Master control')},

--***************************** Weapons management  *********************************************************

-- Weapon
{combos={{key='1',reformers={'LAlt'}}},down=device_commands.ASPgunReload1,up=device_commands.ASPgunReload1,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,value_up=0.0,name=_('Gun reload - 1'),category=_('Weapons')},
{combos={{key='2',reformers={'LAlt'}}},down=device_commands.ASPgunReload2,up=device_commands.ASPgunReload2,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,value_up=0.0,name=_('Gun reload - 2'),category=_('Weapons')},
{combos={{key='3',reformers={'LAlt'}}},down=device_commands.ASPgunReload3,up=device_commands.ASPgunReload3,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,value_up=0.0,name=_('Gun reload - 3'),category=_('Weapons')},

{combos={{key='Space'}},down=device_commands.GunFireBtn,up=device_commands.GunFireBtn,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,value_up=0.0,name=_('Fire Gun'),category=_('Weapons')},
{combos={{key='Space',reformers={'RAlt'}}},down=device_commands.PuskBtn,up=device_commands.PuskBtn,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,value_up=0.0,name=_('Weapon Release'),category=_('Weapons')},

{combos={{key='=',reformers={'RShift'}}},down=device_commands.PuskBtnSafetyCover,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Weapon Release Cover Open'),category=_('Weapons')},
{combos={{key='=',reformers={'RShift','RCtrl'}}},down=device_commands.PuskBtnSafetyCover,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.0,name=_('Weapon Release Cover Close'),category=_('Weapons')},

{combos={{key='=',reformers={'RAlt'}}},down=device_commands.TaktSbrosSafetyCover,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Tactical Drop Safety Cover Open'),category=_('Weapons')},
{combos={{key='=',reformers={'RAlt','RCtrl'}}},down=device_commands.TaktSbrosSafetyCover,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.0,name=_('Tactical Drop Safety Cover Close'),category=_('Weapons')},
{combos={{key='=',reformers={'RCtrl'}}},down=device_commands.TaktSbros,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Tactical Drop On'),category=_('Weapons')},
{combos={{key='=',reformers={'RAlt','RShift'}}},down=device_commands.TaktSbros,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.0,name=_('Tactical Drop Off'),category=_('Weapons')},

{combos={{key='B',reformers={'RShift'}}},down=device_commands.Obogrev,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Missiles Heat On/Off'),category=_('Weapons')},
{down=device_commands.Missiles_Heat_On,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Missiles Heat On'),category=_('Weapons')},
{down=device_commands.Missiles_Heat_Off,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.0,name=_('Missiles Heat Off'),category=_('Weapons')},


{combos={{key='N',reformers={'RShift'}}},down=device_commands.Pusk,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Missiles - Rockets Launch On/Off'),category=_('Weapons')},
{down=device_commands.Missiles_Rockets_Launch_On,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Missiles - Rockets Launch On'),category=_('Weapons')},
{down=device_commands.Missiles_Rockets_Launch_Off,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.0,name=_('Missiles - Rockets Launch Off'),category=_('Weapons')},


{combos={{key='M',reformers={'RShift'}}},down=device_commands.Pitanie12,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Pylon 1-2 Power On/Off'),category=_('Weapons')},
{combos={{key=',',reformers={'RShift'}}},down=device_commands.Pitanie34,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Pylon 3-4 Power On/Off'),category=_('Weapons')},

{down=device_commands.Pylon_1_2_On,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Pylon 1-2 Power On'),category=_('Weapons')},
{down=device_commands.Pylon_1_2_Off,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.0,name=_('Pylon 1-2 Power Off'),category=_('Weapons')},
{down=device_commands.Pylon_3_4_On,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Pylon 3-4 Power On'),category=_('Weapons')},
{down=device_commands.Pylon_3_4_Off,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.0,name=_('Pylon 3-4 Power Off'),category=_('Weapons')},

{combos={{key='.',reformers={'RShift'}}},down=device_commands.GS23,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('GS-23 Gun On/Off'),category=_('Weapons')},

{down=device_commands.GSh23_On,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('GS-23 Gun On'),category=_('Weapons')},
{down=device_commands.GSh23_Off,cockpit_device_id=devices.WEAPON_CONTROL,value_down=0.0,name=_('GS-23 Gun Off'),category=_('Weapons')},



{combos={{key='/',reformers={'RShift'}}},down=device_commands.FKP,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Guncam On/Off'),category=_('Weapons')},

{combos={{key='N',reformers={'RAlt'}}},down=device_commands.AvarPuskSafetyCover,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,name=_('Emergency Missile/Rocket Launcher Cover Open/Close'),category=_('Weapons')},

{combos={{key='N',reformers={'RCtrl'}}},down=device_commands.AvarPusk,up=device_commands.AvarPusk,cockpit_device_id=devices.WEAPON_CONTROL,value_down=1.0,value_up=0.0,name=_('Emergency Missile/Rocket Launch'),category=_('Weapons')},

{down = iCommandPlaneDropFlareOnce, up = iCommandPlaneDropChaffOnce, name=_('Drop Countermeasures (ASO and SPS-141)'),category=_('SPRD or ASO Chaff/Flares')},


--/N/ new 10.05.2015. **************************************************************************************************

-- ASP
{combos={{key='S'}},pressed=device_commands.ASPtargetSize_kb,up=device_commands.ASPtargetSize_kb,cockpit_device_id=devices.ASP,value_pressed=0.01,name=_('Target Size +'),category=_('Weapons / ASP')},

{combos={{key='S',reformers={'LAlt'}}},pressed=device_commands.ASPtargetSize_kb,up=device_commands.ASPtargetSize_kb,cockpit_device_id=devices.ASP,value_pressed=-0.01,name=_('Target Size -'),category=_('Weapons / ASP')},

{combos={{key='I'}},pressed=device_commands.ASPinterceptAngle_kb,up=device_commands.ASPinterceptAngle_kb,cockpit_device_id=devices.ASP,value_pressed=0.01,name=_('Intercept Angle +'),category=_('Weapons / ASP')},

{combos={{key='I',reformers={'LAlt'}}},pressed=device_commands.ASPinterceptAngle_kb,up=device_commands.ASPinterceptAngle_kb,cockpit_device_id=devices.ASP,value_pressed=-0.01,name=_('Intercept Angle -'),category=_('Weapons / ASP')},

-- SPO 
{combos={{key='V'}},pressed=device_commands.SPOvolume_kb,up=device_commands.SPOvolume_kb,cockpit_device_id=devices.SPO,value_pressed=0.05,name=_('SPO-10 Volume +'),category=_('Radar and SPO')},

{combos={{key='V',reformers={'LAlt'}}},pressed=device_commands.SPOvolume_kb,up=device_commands.SPOvolume_kb,cockpit_device_id=devices.SPO,value_pressed=-0.05,name=_('SPO-10 Volume -'),category=_('Radar and SPO')},

-- KPP
{combos={{key='K',reformers={'LShift'}}},pressed=device_commands.KPPsetPitch_kb,up=device_commands.KPPsetPitch_kb,cockpit_device_id=devices.KPP,value_pressed=0.02,name=_('KPP set pitch +'),category=_('Avionics')},

{combos={{key='K',reformers={'LCtrl'}}},pressed=device_commands.KPPsetPitch_kb,up=device_commands.KPPsetPitch_kb,cockpit_device_id=devices.KPP,value_pressed=-0.02,name=_('KPP Set pitch -'),category=_('Avionics')},

-- RSBN
{combos={{key='Y'}},pressed=device_commands.RSBNnav_kb,cockpit_device_id=devices.RSBN,value_pressed=0.01,name=_('RSBN nav chnl +'),category=_('Avionics')},

{combos={{key='Y',reformers={'LShift'}}},pressed=device_commands.RSBNnav_kb,cockpit_device_id=devices.RSBN,value_pressed=-0.01,name=_('RSBN nav chnl -'),category=_('Avionics')},

{combos={{key='U'}},pressed=device_commands.RSBNland_kb,cockpit_device_id=devices.RSBN,value_pressed=0.01,name=_('RSBN land chnl +'),category=_('Avionics')},

{combos={{key='U',reformers={'LShift'}}},pressed=device_commands.RSBNland_kb,cockpit_device_id=devices.RSBN,value_pressed=-0.01,name=_('RSBN land chnl -'),category=_('Avionics')},

-- Radio
{combos={{key='H'}},pressed=device_commands.RadioVolume_kb,cockpit_device_id=devices.RADIO,value_pressed=0.01,name=_('Radio Volume +'),category=_('Radio Communications')},

{combos={{key='H',reformers={'LCtrl'}}},pressed=device_commands.RadioVolume_kb,cockpit_device_id=devices.RADIO,value_pressed=-0.01,name=_('Radio Volume -'),category=_('Radio Communications')},

{combos={{key='['}},down=device_commands.RadioChannel_kb,cockpit_device_id=devices.RADIO,value_down=0.05,name=_('Radio channel +'),category=_('Radio Communications')},

{combos={{key=']'}},down=device_commands.RadioChannel_kb,cockpit_device_id=devices.RADIO,value_down=-0.05,name=_('Radio channel -'),category=_('Radio Communications')},

{combos={{key='/'}},down=device_commands.RadioOn_kb,cockpit_device_id=devices.RADIO,value_down=1.0,name=_('Radio on/off'),category=_('Radio Communications')},

{down=device_commands.RadioOn,cockpit_device_id=devices.RADIO,value_down=1.0,name=_('Radio on'),category=_('Radio Communications')},
{down=device_commands.RadioOn,cockpit_device_id=devices.RADIO,value_down=0.0,name=_('Radio off'),category=_('Radio Communications')},

{down=device_commands.RadioCompassSound,cockpit_device_id=devices.RADIO,value_down=1.0,name=_('Radio / Compass off'),category=_('Radio Communications')},
{down=device_commands.RadioCompassSound,cockpit_device_id=devices.RADIO,value_down=0.0,name=_('Radio / Compass on'),category=_('Radio Communications')},

--/N/ 21.02.2016.
{pressed = device_commands.AltimeterPressure_increase, cockpit_device_id=devices.ALTIMETER, value_pressed=  0.01, value_up=0.0, name=_('Altimeter pressure +'),category=_('Avionics')},
{pressed = device_commands.AltimeterPressure_decrease, cockpit_device_id=devices.ALTIMETER, value_pressed= -0.01, value_up=0.0, name=_('Altimeter pressure -'),category=_('Avionics')},

{down = iCommandVoIPRadioPushToTalkEnableDisableVoice, up = iCommandVoIPRadioPushToTalkEnableDisableVoice, value_down=1.0, value_up=0.0, name=('VOIP Talk'), category=('VOIP')},

},

}
