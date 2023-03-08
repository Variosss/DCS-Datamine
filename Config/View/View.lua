-- View scripts
-- Copyright (C) 2004, Eagle Dynamics.

mouseSpeedCoeff = 0.45 -- experimental, need tuning

CockpitMouse = true --false
CockpitMouseSpeedSlow = 1.0 * mouseSpeedCoeff
CockpitMouseSpeedNormal = 10.0 * mouseSpeedCoeff
CockpitMouseSpeedFast = 20.0 * mouseSpeedCoeff
CockpitKeyboardAccelerationSlow = 5.0
CockpitKeyboardAccelerationNormal = 30.0
CockpitKeyboardAccelerationFast = 80.0
CockpitKeyboardZoomAcceleration = 300.0
DisableSnapViewsSaving = false
UseDefaultSnapViews = true
CockpitPanStepHor = 45.0
CockpitPanStepVert = 30.0
CockpitNyMove = true

CockpitHAngleAccelerateTimeMax = 0.15
CockpitVAngleAccelerateTimeMax = 0.15
CockpitZoomAccelerateTimeMax   = 0.2

CockpitOffsetsMin = {-0.2, -0.25, -0.5}
CockpitOffsetsMax = {0.2, 0.25, 0.5}

function NaturalHeadMoving(tang, roll, omz)
	local r = roll
	if r > 90.0 then
		r = 180.0 - r
	elseif roll < -90.0 then
		r = -180.0 - r
	end
	local hAngle = -0.25 * r
	local vAngle = math.min(math.max(0.0, 0.4 * tang + 45.0 * omz), 90.0)
	return hAngle, vAngle
end

ExternalMouse = true
ExternalMouseSpeedSlow = 1.0 * mouseSpeedCoeff
ExternalMouseSpeedNormal = 5.0 * mouseSpeedCoeff
ExternalMouseSpeedFast = 20.0 * mouseSpeedCoeff
ExternalViewAngleMin = 3.0
ExternalViewAngleMax = 140.0
ExternalViewAngleDefault = 78.0
ExternalKeyboardZoomAcceleration = 30.0
ExternalKeyboardZoomAccelerateTimeMax = 1.0
ExplosionExpoTime = 4.0
ExternalKeyboardAccelerationSlow = 1.0
ExternalKeyboardAccelerationNormal = 10.0
ExternalKeyboardAccelerationFast = 30.0
ExternalAngleAcceleration = 60.0
ExternalAngleAccelerateTimeMax = 3.0
ExternalMoveAcceleration = 30
ExternalCameraInertia = true
ExternalMoveAccelerateTimeMax = 3.0
ExternalBrakeTimeMax = 0.5
ExternalZoomBrakeTimeMax = 0.25
ExternalAngleNormalDiscreteStep = 15.0/ExternalKeyboardAccelerationNormal -- When 'S' is pressed only
ChaseCameraNyMove = true
IgnoreParachutists = true	-- for F2 view, bots only
CameraToUnitModelCollision = true
CameraBookmarkAnimationTime = 2.0

WingmanCameraOrientationDelayTime = 2.0
WingmanCameraPointDelayTime = 0.75
WingmanCameraDelayTimeMax = 3.0
WingmanCameraLocalOffsets = {-36.0, 5.0, 15.0}
WingmanCameraLocalOffsetsMin = {-100.0, -50.0, -75.0}
WingmanCameraLocalOffsetsMax = {-20.0, 50.0, 75.0}
FreeCameraAngleIncrement = 3.0
FreeCameraDistanceIncrement = 100.0
FreeCameraLeftRightIncrement = 2.0
FreeCameraAltitudeIncrement = 2.0
FreeCameraScalarSpeedAcceleration = 0.1 
FreeCameraMoveAcceleration = 1000.0
FreeCameraMoveAccelerateTimeMax = 6.0
FreeCameraBrakeTimeMax = 0.5

FreeCamera_speedWSNormal = 1000000.0 / 3600.0
FreeCamera_speedWSFast = 8000.0
FreeCamera_speedWSSlow = 32.0
FreeCamera_AD_WS_coeff = 0.25
FreeCamera_speedADNormal = FreeCamera_speedWSNormal * FreeCamera_AD_WS_coeff
FreeCamera_speedADFast = FreeCamera_speedWSFast * FreeCamera_AD_WS_coeff
FreeCamera_speedADSlow = FreeCamera_speedWSSlow * FreeCamera_AD_WS_coeff
FreeCamera_EQ_WS_coeff = 0.125
FreeCamera_speedEQNormal = FreeCamera_speedWSNormal * FreeCamera_EQ_WS_coeff
FreeCamera_speedEQFast = FreeCamera_speedWSFast * FreeCamera_EQ_WS_coeff
FreeCamera_speedEQSlow = FreeCamera_speedWSSlow * FreeCamera_EQ_WS_coeff

AwacsDialogDebug = false

keyboardSpeedLSO = 0.005
keyboardSpeedBOSS = 0.02
keyboardSpeedHANGAR = 0.05
keyboardSpeedBRIEFING_ROOM = 0.05
mouseSpeedLSO = 980.0
mouseSpeedBOSS = 980.0
mouseSpeedHANGAR = 980.0
mouseSpeedBRIEFING_ROOM = 980.0

xMinMap = -300000
xMaxMap = 500000
yMinMap = -400000
yMaxMap = 200000
dxMap = 150000
dyMap = 100000

head_roll_shaking = true
head_roll_shaking_max = 30.0
head_roll_shaking_compensation_gain = 0.3

QuakeParams = {
    ["quakePowerBase"] = 0.25,
    ["quakePowerMin"] = 0.25,
    ["quakeAngleMin"] = 0.05,
    ["quakeDistanceDecay"] = 0.005,
    ["quakeDuration"] = 2.5,
	["quakeAngleScale"] = 48.0,
}

PlaneCameraFluctus = true
ArcadeCameraFluctus = false
WingmanCameraFluctus = true
FlyByCameraFluctus = false
ObjectCameraFluctus = false
WeaponCameraFluctus = false
GroundCameraFluctus = false
NavyCameraFluctus = false
FreeCameraFluctus = false

FloatParams = {
    ["ampCameraFloatSlow"] = {
        [1] = 0.02766800665855,
        [2] = 0.05453100293875,
        [3] = 0.034109999030828,
    },
    ["freqCameraFloatFast"] = {
        [1] = 2.56231045723,
        [2] = 2.285439729691,
        [3] = 3.10145945549,
    },
    ["freqCameraFloatSlow"] = {
        [1] = 1.2188499569893,
        [2] = 1.6617801189423,
        [3] = 1.3032699465752,
    },
    ["ampCameraFloatFast"] = {
        [1] = 0.019068997263908,
        [2] = -0.044290998876095,
        [3] = 0.015494000762701,
    },
}

JiggleParams = {
	["ampCameraJiggle"] = { 0.05, 0.05, 0.05 },
	["freqCameraJiggle"] = { 37.0, 41.0, 53.0 },
}

-- CameraJiggle() and CameraFloat() functions make camera position
-- dependent on FPS so be careful in using the Shift-J command with tracks, please.
-- uncomment to use custom jiggle functions
--[[
function CameraJiggle(t,rnd1,rnd2,rnd3)
	local rotX, rotY, rotZ
	rotX = JiggleParams.ampCameraJiggle[1] * rnd1 * math.sin(JiggleParams.freqCameraJiggle[1] * (t - 0.0))
	rotY = JiggleParams.ampCameraJiggle[2] * rnd2 * math.sin(JiggleParams.freqCameraJiggle[2] * (t - 1.0))
	rotZ = JiggleParams.ampCameraJiggle[3] * rnd3 * math.sin(JiggleParams.freqCameraJiggle[3] * (t - 2.0))
	return rotX, rotY, rotZ
end

function CameraFloat(t)
	local dX, dY, dZ
	dX = FloatParams.ampCameraFloatSlow[1] * math.sin(FloatParams.freqCameraFloatSlow[1] * t) + 
		FloatParams.ampCameraFloatFast[1] * math.sin(FloatParams.freqCameraFloatFast[1] * t);
	dY = FloatParams.ampCameraFloatSlow[2] * math.sin(FloatParams.freqCameraFloatSlow[2] * t) + 
		FloatParams.ampCameraFloatFast[2] * math.sin(FloatParams.freqCameraFloatFast[2] * t);
	dZ = FloatParams.ampCameraFloatSlow[3] * math.sin(FloatParams.freqCameraFloatSlow[3] * t) + 
		FloatParams.ampCameraFloatFast[3] * math.sin(FloatParams.freqCameraFloatFast[3] * t);
	return dX, dY, dZ
end
--]]
--Debug keys

DEBUG_TEXT 		= 1
DEBUG_GEOMETRY 	= 2

debug_keys = {
	[DEBUG_TEXT] = 1,
	[DEBUG_GEOMETRY] = 1
}

function onDebugCommand(command)
	if command == 10000 then		
		if debug_keys[DEBUG_TEXT] ~= 0 or debug_keys[DEBUG_GEOMETRY] ~= 0 then
			debug_keys[DEBUG_GEOMETRY] = 0
			debug_keys[DEBUG_TEXT] = 0
		else
			debug_keys[DEBUG_GEOMETRY] = 1
			debug_keys[DEBUG_TEXT] = 1		
		end	
	elseif command == 10001 then 
		if debug_keys[DEBUG_TEXT] ~= 0 then
			debug_keys[DEBUG_TEXT] = 0
		else
			debug_keys[DEBUG_TEXT] = 1
		end		
	elseif command == 10002 then
		if debug_keys[DEBUG_GEOMETRY] ~= 0 then
			debug_keys[DEBUG_GEOMETRY] = 0
		else
			debug_keys[DEBUG_GEOMETRY] = 1
		end
	end
end

-- gain values for TrackIR , to unify responce on diffrent types of aircraft
TrackIR_gain_x    = -0.6
TrackIR_gain_y    =  0.3
TrackIR_gain_z    = -0.25
TrackIR_gain_roll = -90
