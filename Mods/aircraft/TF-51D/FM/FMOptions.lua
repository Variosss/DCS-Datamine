wingRollDeg = 3.0

tailGearAreaAD = 0.1
mainGearAreaAD = 0.4

tailWheelStaticFricK = 0.60
tailWheelSideFricK = 0.6
tailWheelRollFricK = 0.025
tailWheelGlideFricK = 0.54
tailWheelMOI = 0.5
mainWheelStaticFricK = 0.71
mainWheelSideFricK = 0.73
mainWheelRollFricK = 0.022
mainWheelGlideFricK = 0.69
mainWheelBrakeMomentMax = 8000.0
mainWheelMOI = 3.6

tailGearYawDamperK = 20.0
tailGearAxleAngShift    = 0
tailGearAxleFricM0s	= 0 --140
tailGearAxleFricM0f	= 0 --35
tailGearAxleFricVs = 0.2
tailGearAxleFricVf = 5

tailGearStockLength = 0.20
tailGearSpringForceFactor = 9000000.0
tailGearSpringForceFactorRate = 20
tailGearStaticForce = 38000.0
tailGearReduceLength = 0.02
tailGearDirectDamperForceFactor = 20.0
tailGearBackDamperForceFactor = 90000.0
tailGearDamageLengthLim = 0.10

mainGearSpringForceFactor = 4000000 --5000000
mainGearSpringForceFactorRate = 3 --3.0
mainGearStaticForce	= 12000.0 --20000
mainGearReduceLength = 0.14 
mainGearDirectDamperForceFactor = 2000
mainGearBackDamperForceFactor = 90000.0
mainGearDamageLengthLim = 0.12

skew_w_wingK = 0.7
skew_w_tailK = 1

governorRegK = 0.0003  -- 0.0005
governorVelK = 0.0035 -- 0.0075
governorDamperK = 0.00002
governorNscale = 3.0 -- 1
governorNc1 = 160
governorNc2 = 320 
governorNc3 = 0.003

transversalK = 1

valvePosK1 = 0.8
valvePosK2 = 0.51

fuselageMyDampK =  0.9   --- 06 Mar 2012
fuselageMzDampK	=  0.19   --- 06 Mar 2012
wingMzDampK	=  0.43  --- 12 Jan 2011 

stabSkewK = 0.9

aileronAngleBias = 0 --Degrees!
rudderAngleBias = -0.5

contactPosShiftK = -1.3

tailShadowPower = 6
tailShadowK = 0.21      --0.34
tailShadowSpread = 36
damperShadowK = 2.5      --1 

autoRudderK = 16.0 -- попорционально боковой перегрузке (шарику)
autoRudderWyK = 8.5 -- при угловой скорости
autoRudderWyLowTauInv = 0.5 -- ФНЧ угловой скорости
autoRudderDampK = 0*2 -- при производной перегрузки
autoRudderOutTauInv = 1.2

takeoffHelperK = 70
takeoffHelperWyTauInv = 0.7

wingInForceMax					= 58000*1.5
wingCntForceMax					= 47000*1.5
wingOutForceMax					= 36000*1.5
wingInForceDamage				= 58000
wingCntForceDamage				= 47000
wingOutForceDamage				= 36000

gearYawDamperK					= 0 --50000.0

propBodyShakeK					= 180
propBodyShakeLim				= 7000
propDisbalanceShakeLim          = 70000.0

gearPostAntiExtractM0			= 125.1;
gearPostAntiExtractK			= 2500.1;
gearPostAntiExtractState0		= 0.81;

overcritZeroPoint				= 5.8
overcritK						= 0

fusK1							= 2
fusK2							= 3
fusPwr1							= 3
fusPwr2							= 5
fusKmain						= 0


--Bias_poly = {1.7261e-5, -6.6216e-3, 0.49792}
--Func_poly = {-8998.9, 1948.9, -60.874, -0.1996, 0.0378}

Bias_poly						= {0.0, 0.0, 0.0}
Func_poly						= {0.0, 0.0, 0.0, 0.0, 1.1}
Tau_residual					= 0.2
A_RPM							= {0.05,0.15}

