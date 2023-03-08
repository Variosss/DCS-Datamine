-- This is just sample of the file
-- please  put your version as in your user folder
-- like this for example:
-- "C:\Users\<USERNAME>\Saved Games\DCS\Config\ModelTimer\ModelTimer.lua"

TraceOn = false
ActivitiesTraceOn = false
TraceCommandsDiscreteOn = false
TraceCommandsAnalogOn = false
TraceObjectsOn = false
TraceDurationOn = false
TraceDurationMin = 0.0
TraceBeginTime = 0.0
TraceEndTime = 1.7976931348623158e+308
RecordModelTimeAccelerationToTrack = true
TraceObjectBegin = 0.0
TraceObjectEnd = 1.7976931348623158e+308
TraceObjectStep = 0.0
TraceObjectExclude = {"class woCar", "class woShip", "class wWeaponSystem", "class cLauncher", "class cLauncherAutogun", "class cLauncherGun"}
--TraceNames = {"class woCar"}

ExcludeNames = {"class TrackActivity"}

--TraceObjectExclude = {"class Effects::GraphicEffectActivity"}
--ExcludeNames = {"class wAirdromeActivity","class LightFlashActivity","class Effects::GraphicEffectActivity","class wActivity<class woCar>",  "class wActivity<class wcColumn>", "class wAtmosphereActivity", "class TrackActivity"}

--[[

This file controls model timer trace tools. 
You can edit it just before every mission/track start.

Parameters description:

The log file will be created if TraceOn or TraceCommandsDiscreteOn or TraceCommandsAnalogOn or TraceObjectsOn or TraceFramesOn != 0:
 For simple mission - Temp/MissionFly.log.
 For track recording - Temp/TrackRecord.log.
 For track playing - Temp/TrackPlay.log.
 For track editing - Temp/TrackEdit.log.

TraceOn = true  - World activities (processes) will be traced

TraceCommandsDiscreteOn = true  -- World and View input discrete commands will be traced
TraceCommandsAnalogOn = true -- World and View input analog commands will be traced

TraceObjectsOn = true -- Moving Objects will be traced
 (they must use MovingObject::Print() function)

TraceFramesOn = true -- Frames times will be traced

TraceNames = {"...", "...", ... "..."}  -- Trace enumerated activities only. 
 Use special name format (e.g. "class MyActivity").
 Don't use TraceNames at all to trace all activities.

ExcludeNames = {"...", "...", ... "..."} -- Excludes these activities from the trace log.

TraceBeginTime, TraceEndTime    -- Trace model time interval.

RecordModelTimeAccelerationToTrack = true   
-- If true then model time acceleration commands will be recorded to the track
-- and then they will be interpreted during the track playback.
-- Set false to disable model time acceleration commands recording. 


StopTimes = { model_time_1, model_time_2, ..., model_time_n }   
-- Model time quantizer will freeze exactly at these times. Press 'S' to continue.

TraceObjectBegin, TraceObjectEnd -- Objects trace model time interval.
TraceObjectStep  -- Objects trace time step

TraceObjectExclude = {"class wHumanHel", "class wHumanPlane", "class woAIHelicopter", "class woAIPlane", "class woCar", "class woShip", "class wWeaponSystem", ... "..."} --  Excludes these classes of moving objects from the trace log.
   Use special name format (e.g. "class MyObject").
    Don't use ObjectNames at all to trace all objects.
    
--]]