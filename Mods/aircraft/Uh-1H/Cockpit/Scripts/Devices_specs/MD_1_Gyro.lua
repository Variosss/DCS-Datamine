local gettext = require("i_18n")
_ = gettext.translate

-- Timer update time
device_timer_dt = 0.04

-------------------
-- Gyro settings --

-- Gyro cage rate
CageRate = 1.0 -- rad/sec with the apex deflection at 1 radian

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
NominalRotRate = 2090.0 -- rad/sec, 20000 revolutions/min
-- Spinup rate
SpinUpT = 12 -- time constant, spinup time - ~60 sec
-- Slowdown rate
SlowDownT = 80 -- time constant, slow down time - ~7 minutes
-- Threshold spinning velocity, rad/sec
ThresholdRotRate = 0.01

-- Mass displacement constant scale along X gyro axis
DmassX_const_scale = 0.00001
-- Mass displacement constant scale along Y gyro axis
DmassY_const_scale = 0.00001
-- Mass displacement constant scale along Z gyro axis
DmassZ_const_scale = 0.00001

-- Mass displacement random scale along X gyro axis
DmassX_rnd_scale = 0.00002
-- Mass displacement random scale along Y gyro axis
DmassY_rnd_scale = 0.00002
-- Mass displacement random scale along Z gyro axis
DmassZ_rnd_scale = 0.00002

-- Constant drift (rad/sec)
ConstDriftYRate_Scale = 0.00005--006 -- rad/sec
ConstDriftXRate_Scale = 0.00005--006 -- rad/sec

-- Constant drift noise
T_Corr = 15.0 -- sec
E = 0.00001 -- rad/sec

----------------------------------------------------
-- Radial correction
--
-- Max deflection of gyro main axis from vertical
MaxDeflection = math.rad(8) -- radians
-- Correction rate with gyro axis deflected on 8 deg from vertical
CorrectionRate = 0.0017 -- rad/sec with the apex deflection at 8 degrees (maximum)
-- Minimum correction rate
MinCorrectionRate = 0.0005 -- rad/sec

---- Damages
MD1_GYRO_TOTAL_FAILURE		= 0

Damage = {	
{Failure = MD1_GYRO_TOTAL_FAILURE, 	  Failure_name = "MD1_GYRO_TOTAL_FAILURE", Failure_editor_name = _("Roll pitch gyro failure"),  Element = 0, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
