folToleranceDist =15.0
folBreakingDist = 2.0
pathNearIdealPosDist = 30.
predictedPathTime = 2.0
maxOutsidePathDist = 20.0
intervalCoeff = 0.8
maxStayingDistance = 20.0
searchTrailDist = 10.0
maxDirErrorCos = 0.999
maxWanderDirErrorCos = 0.99
pauseToGiveWay = 90.0
frontDistMin = 50.0
sideDist = 10.0
sideOffDist = 2.0
angle = 0.785 --osg::PI_4
offsetToAverangePathDir = 40.0
fwdPathOffset = 4
sidePathOffset = 0.3

parAngle = 0.94
minNeighbSearchDist = 20.0
neighbSearchTime = 10.0
timeForAvoidTurn = 0.3
truncatedConeC = 0.1
    
arrivedDist = 15.0
arriveBehindDist = 30.0
criticalDevDir = 0.995
criticalArrivedDir = 0.2
timeLimit = 30.0
timeToStopLimit = 70.0
arriveSpeedCoeff = 1.2
distToArrive = 25.0
minTimeDisperse = 7.0
maxTimeDisperse = 20.0
wanderChangeDir = 17.0
warningDist = 30.0
checkTime = 2.0
disperseCheckDist = 10.0
bridgeVisibleDist = 150.0
maxSpeedOnBridge = 6.0
obsCheckingDist = 1.0
goAheadDist = 40.0

bridgeIsNearDist = 1000.0
bridgeIsVeryNearDist = 100.0
maxBypassLength = 100000.0
routeByRouteIsLong = 1000.0

bypassRiversWeight = 10.0
defaultGroundWeight = 4.0
defaultRiversWeight = 100.0 

cFricGround = 0.3
powSpeedC = 0.2
speedDiffForceCoeff = 0.4

smoothCurvC = 4.0 --check
smoothAccC = 4.0  --check
distTolerance = 4.0 --check
maxObsRadius = 120.0
maxNeighbRadius = 50.0
checkNeighbDist = 2.0
checkObsDist = 20.0
checkPathParamDist = 2.0
obsParallelSpeed = 7.0
obsParallelAngle = 0.122 --7.*MathTools::GradToRad*
maxAdjustedSpeed = 3.0
uTurnSpeed = maxAdjustedSpeed + 0.1
speedWithMaxDiv = 2.5
coeffCentripetal = 1.0
maxSpeedDiff = 1.0
minSegmentsCosine = 0.999
weightDist = 10.0
checkLandscapeDist = 0.5
diveDepth = 1.5
 --для возможности маневрирования при движении по воде maxSpeedOnShallowWater должна быть больше uTurnSpeed
maxSpeedOnShallowWater = uTurnSpeed
hillsideThreshold = 15/180*3.1415 -- slope angle threshold to apply speed limit 
maxSpeedOnHillside = 5.55 -- 20 km/h
maxSpeedInForest = 5.55 -- 20 km/h
CatTrackCoeff = 2.0
CatTrackMax = 0.15

fColumnFwd = 30.0
fRowSide = 50.0
fWedgeStartSide = 20.0
fWedgeSide = 40.0
fWedgeFwd = 60.0
fVeeStartSide = 20.0
fVeeSide = 40.0
fVeeFwd = 60.0
fEchelonFwd = 30.0
fEchelonSide = 20.0
fDiamondFwd = 40.0
fDiamondSide = 20.0
fHumanFwd = 5.0
fHumanSide = 10.0

sndSmoothAccC = 0.05
sndBreakingAcc = -0.02

timeForFinishSendUpdateMessages = 10.0

cAgonyAngDev = 0.15
cAgonyBreakingDevMin = 0.1
cAgonyBreakingDevMax = 0.5