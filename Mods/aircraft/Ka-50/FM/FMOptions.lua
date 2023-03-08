----------- for new helicopter trimmer method -----------------------------------------------
----------- (joystick will be disable after trim until it come to neutral zone) -------------
HelicopterTrimmerZonePitch		= 0.05
HelicopterTrimmerZoneRoll		= 0.05	
HelicopterTrimmerZoneRudder		= 0.1

---------- for old helicopter trimmer method ------------------------------------------------
----------- (aperiodic process)  ------------------------------------------------------------
HelicopterTrimmerTauInverse		= 7.0 --lower value - decrease trim speed after trim button release. 

CyclicZPitch = 8.25 	--	8.25 	Real Ka-50
CyclicMinXPitch = 15.0  --    15 	Real Ka-50 (от себя)
CyclicMaxXPitch = 9.5 	--    9.5 	Real Ka-50 (на себя)
GeneralPitch = 16.0 	--    это дельта! (GeneralPitchMax = GeneralPitch + GeneralPitch0) Real Ka-50: GeneralPitchMax = 22 ?
GeneralPitch0 = 3.0 	--	7.0 ?
DifferentPitch = 2.5 	--	2.5 	Real Ka-50
AP_K_PitchPilot	= 0.25
AP_K_RollPilot	= 0.8
AP_K_RudderPilot	= -0.15
AP_K_Vx		= -0.02
AP_K_Yaw		= 0.7

--параметры компенсации отдачи:
AP_K_GunYaw					= 2.0
AP_K_GunPitch				= 0.05
AP_K_GunSlowYaw				= 0.04
AP_K_GunSlowPitch			= 0.005
AP_K_RocketYaw				= 0
AP_K_RocketPitch			= 3.0


-- трение колес
NoseWheelStaticFricK	= 0.71
NoseWheelSideFricK		= 0.73
NoseWheelRollFricK		= 0.025
NoseWheelGlideFricK		= 0.58
MainWheelStaticFricK	= 0.71
MainWheelSideFricK		= 0.73
MainWheelRollFricK		= 0.03 
MainWheelGlideFricK		= 0.69 
MainWheelBrakeMomentMax = 6000.0

NoseGearPostDamper		= 37

VindWingK			= 1.0
VindStabK			= 1.0
VindFusK			= 1.0
