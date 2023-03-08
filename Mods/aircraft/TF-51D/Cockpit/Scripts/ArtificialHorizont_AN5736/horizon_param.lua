local gettext = require("i_18n")
_ = gettext.translate

-- Timer update time
device_timer_dt = 0.04

-- Gyro cage rate
CageRate = math.rad(160) -- rad/sec

-- Gyro mass
Mass = 0.14 -- kilograms
-- Moment of inertia along gyro main axis
Jz = 0.00086 -- N * m * sec * sec
-- Moment of inertia along gyro X, Y axes
Jxy = 0.00043 -- N * m * sec * sec
-- Friction coefficients along X, Y axes
KfrX = 0.00005
KfrY = 0.00005

-- Nominal gyro rotation rate
NominalRotRate = 15000*math.rad(360)/60 -- rad/sec, 15 000 RPM
-- Spinup rate
SpinUpT = 4.0 -- time constant, spinup time - ~18 sec
-- Slowdown rate
SlowDownT = 12 -- time constant, slow down time - ~92 sec
-- Threshold spinning velocity, rad/sec
ThresholdRotRate = 0.01

-- Time constant of pitch drum-servo motor feedback ctrl system
T_Pitch = 0.2 -- sec
-- Time constant of tracking frame-servo motor feedback ctrl system
T_Bank = 0.2 -- сек

-- Mass displacement constant scale along X gyro axis
DmassX_const_scale = 0.0002
-- Mass displacement constant scale along Y gyro axis
DmassY_const_scale = DmassX_const_scale
-- Mass displacement constant scale along Z gyro axis
DmassZ_const_scale = DmassX_const_scale

-- Mass displacement random scale along X gyro axis
DmassX_rnd_scale = DmassX_const_scale * 0.3
-- Mass displacement random scale along Y gyro axis
DmassY_rnd_scale = DmassX_rnd_scale
-- Mass displacement random scale along Z gyro axis
DmassZ_rnd_scale = DmassX_rnd_scale

-- Constant drift (rad/sec)
ConstDriftYRate_Scale = math.rad(0.0084)
ConstDriftXRate_Scale = ConstDriftYRate_Scale

-- Constant drift noise
T_Corr = 15.0 -- sec
E = math.rad(0.006) -- rad/sec

----------------------------------------------------
-- Radial correction
--
-- Max deflection of gyro main axis from apparent vertical
MaxDeflection = math.rad(7) -- radians
-- Correction rate with gyro axis deflected on MaxDeflection deg from apparent vertical
CorrectionRate = math.rad(0.4) -- rad/sec with the apex deflection at MaxDeflection degrees (maximum)
-- Minimum correction rate
MinCorrectionRate = CorrectionRate * 0.1 -- rad/sec

warnFlag = {valmin = 0, valmax = 1, dvalue = 11}

HORIZON_BAR_NOT_SETTLE	= 0

Damage = {	{Failure = HORIZON_BAR_NOT_SETTLE, Failure_name = "HORIZON_BAR_NOT_SETTLE", Failure_editor_name = _("Artif Horizon. Horizon bar does not settle"),  Element = 3, Integrity_Treshold = 0.3, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
