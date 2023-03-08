local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices = {}
devices["TEST2"]					= counter()--1
devices["WEAPON_SYSTEM"]			= counter()--2
devices["ELECTRIC_SYSTEM"]			= counter()--3
devices["CLOCK"]					= counter()--4
devices["RADAR"]					= counter()--5
devices["LANDINGGEAR"]				= counter()--6
devices["REVERSAL"]					= counter()--7
devices["CANARDFLAPS"]				= counter()--8
devices["SPAK"]						= counter()--10
devices["WEAPON_SYS"]				= counter() -- 11
devices["AIRBRAKE"]					= counter()--12
devices["NAVIGATION"]				= counter()--14
devices["ENGINE_MGMT"]				= counter()--15
devices["DEBUG"]					= counter()--16
devices["TEST"]						= counter()--17
devices["EP13"]						= counter()--18
devices["LIGHTS"]					= counter()--20
devices["ENGINEPANEL"]				= counter()--21
devices["ELECTRICSYSTEM"]			= counter()--22
devices["RADARALT"]					= counter()--23
devices["DOPPLER"]					= counter()--24
devices["FLIGHTDATAUNIT"]			= counter()--25
devices["NAVIGATIONPANEL"]			= counter()--26
devices["RWR"]						= counter()--27
devices["HIGHALPHAWARNING"]			= counter()--28
devices["ERRORPANEL"]				= counter()--29
devices["MISSILECONTROLLER"] 		= counter()--30
devices["COUNTERMEASURE"] 			= counter()--31
devices["TESTINTERCOM"] 					= counter()--35 -- TEST
devices["FR22"] 				= counter()--35 -- Radio 2
devices["FR24"] 				= counter()--35 -- Radio 1
devices["IFF"]						= counter()--34?
devices["CONTROLS"]					= counter()--34?
devices["KNEEBOARDINTERFACE"]		= counter()
devices["KNEEBOARD"]				= counter()
devices["JOKER"]					= counter()--counter()
devices["WALKMAN"]					= counter()--counter()
devices["REPORTER"]					= counter()--counter()
devices["MISSIONGENERATOR"]			= counter()
devices["MACROS"]          			= counter()	-- whatever
devices["HELMET_DEVICE"]		= counter()--33

