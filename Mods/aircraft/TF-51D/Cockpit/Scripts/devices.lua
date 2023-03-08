local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices = {}

devices["TEMP1"]				= counter()--
devices["ELEC_INTERFACE"]		= counter()--1
devices["HYDRAULIC_SYSTEM"]		= counter()--2
devices["TEMP2"]				= counter()--
devices["ENGINE_SYSTEM"]		= counter()--3
devices["CPT_MECH"]				= counter()--4 
devices["OXYGEN_SYSTEM"]		= counter()--5
devices["FM_PROXY"]				= counter()--6
devices["FUEL_SYSTEM"]			= counter()--7
devices["LIGHT_SYSTEM"]			= counter()--8
devices["ENVIRONMENT_SYSTEM"]	= counter()--9
devices["CONTROL_SYSTEM"]		= counter()--10
devices["FRONT_SWITCH_BOX"]		= counter()--11
devices["RIGHT_SWITCH_PANEL"]	= counter()--12
devices["ENGINE_CONTROL_PANEL"]	= counter()--13
devices["AIRSPEED_INDICATOR"]   = counter()--14
devices["ALTIMETER"]   			= counter()--15
devices["VARIOMETER"]  			= counter()--16
devices["ARTIFICIAL_HORIZON"]   = counter()--17
devices["DIRECTIONAL_GYRO"]     = counter()--18
devices["TURN_INDICATOR"] 	    = counter()--19
devices["CLOCK"]		 	    = counter()--20
devices["REMOTE_COMPASS"]	    = counter()--21
devices["VHF_RADIO"]		    = counter()--22
devices["TAIL_WARNING_RADAR"]   = counter()--23
devices["DETROLA"]   			= counter()--24
devices["IFF"]   				= counter()--25
devices["HOMING_ADAPTER"]   	= counter()--26
devices["KNEEBOARD"] 			= counter()--27
devices["ACCELEROMETER"]        = counter()--28
devices["INTERCOM"]				= counter()--29

devices["PADLOCK"]				= counter()--30
devices["HELMET_DEVICE"]		= counter()--31

devices["ARCADE"]				= counter()--32
devices["MACROS"]          		= counter()--33 	-- start stop macros

devices["HEARING_SENS"]         = counter()
