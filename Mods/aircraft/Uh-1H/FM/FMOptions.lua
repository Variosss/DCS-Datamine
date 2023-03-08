
CenteringShiftX = 0.0;--смещение центровки
CenteringShiftY = 0.0;
CenteringShiftZ = 0.0;
StickVibrationxMax=0.2;-- Максимальное отклонение ручки по одному каналу в +
StickVibrationxMin=-0.2;-- Максимальное отклонение ручки по одному каналу в -
StickVibrationFrequency=1;-- Частота колебаний ручки
StickWithoutHydroVelocity=1/2; -- скорость хода ручки

critForceFuselage = 150000.0-- 110000.0
critImpulseFuselage = 0.0
critForceSkid = 70000.0-- 50000.0
critImpulseSkid = 0.0
critForceTail = 35000.0-- 25000.0
critImpulseTail = 0.0
critForceStabilizer = 15000.0--  15000.0-
critImpulseStabilizer = 0

cushionStrength=0.235 -- сила воздушной подушки
cushionWeakening=0.40 -- степень снижения силы воздушной подушки от
cushionDensityCoef =0.0

critSpeedFuselage=14.0
critSpeedSkid=5.0
critSpeedTail=8.0

maxCentrifugalRotorForce = 150.0
breakingUnbalance = 0.02

CargoMass = 0.0; --масса внутреннего груза

deltaFlappingForCrash = -2.22;

PilotHelperOn = false -- помощник в управлении

-- // груз

CargoModelling=false; -- моделирование груза 
CargoGround=false;-- отрисовка груза на земле при холодном и горячем старте.


MediumDynamic=false; -- настройка для средней сложности динамики вертолета
SimpleHooking=false; -- включение упрощенной динамики в радиусе 20 м от груза.

sticktimelag=0.5;

CargoDempher=.0; --демпфер груза;

--// зацепка груза

CargoHeight=7.0;
dCargoHeight=2.0;
dxzCargo=2.0;
HoveringTime=5.0;