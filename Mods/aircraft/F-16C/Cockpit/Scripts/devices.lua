local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices = {}
-- do not changed following sequence for sim
devices["FM_PROXY"]					= counter()--1
devices["CONTROL_INTERFACE"]		= counter()--2
devices["ELEC_INTERFACE"]			= counter()--3
devices["FUEL_INTERFACE"]			= counter()--4
devices["HYDRO_INTERFACE"]			= counter()--5
devices["ENGINE_INTERFACE"]			= counter()--6
devices["GEAR_INTERFACE"]			= counter()--7
devices["OXYGEN_INTERFACE"]			= counter()--8
devices["HEARING_SENS"]				= counter()--9
devices["CPT_MECH"]					= counter()--10
devices["EXTLIGHTS_SYSTEM"]			= counter()--11
devices["CPTLIGHTS_SYSTEM"]			= counter()--12
devices["ECS_INTERFACE"]			= counter()--13
devices["INS"]						= counter()--14
devices["RALT"]						= counter()--15
-- HOTAS Interface
devices["HOTAS"]					= counter()--16
--
devices["UFC"]						= counter()--17		-- Upfront Controls (UFC) with Integrated Control Panel (ICP)
-- Computers ----------------------------
devices["MUX"]						= counter()--18		-- Multiplex manager, holds channels and manages remote terminals addition/remove
devices["MMC"]						= counter()--19		-- Modular Mission Computer (MMC) / Fire Control Computer (FCC)
devices["CADC"]						= counter()--20		-- Central Air Data Computer
devices["FLCC"]						= counter()--21		-- Flight Control Computer
devices["SMS"]						= counter()--22		-- Stores Management Subsystem
-- Displays -----------------------------
devices["HUD"]						= counter()--23
devices["MFD_LEFT"]					= counter()--24		-- Multifunction Display
devices["MFD_RIGHT"]				= counter()--25		-- Multifunction Display
devices["DED"]						= counter()--26		-- Data Entry Display (DED)
devices["PFLD"]						= counter()--27		-- Pilot Fault List Display (PFLD)
devices["EHSI"]						= counter()--28		-- Electronic Horizontal Situation Indicator (EHSI)
-- Helmet
devices["HELMET"]					= counter()--29
devices["HMCS"]						= counter()--30		-- HMCS Interface
-- Sensors ------------------------------
devices["FCR"]						= counter()--31		-- AN/APG-68
-- EWS ----------------------------------
devices["CMDS"]						= counter()--32		-- Counter Measures Dispensing System
devices["RWR"]						= counter()--33		-- Radar Warning Receiver (RWR)
-- Radio --------------------------------
devices["IFF"]						= counter()--34		-- AN/APX-113
devices["IFF_CONTROL_PANEL"]		= counter()--35
devices["UHF_RADIO"]				= counter()--36		-- AN/ARC-164
devices["UHF_CONTROL_PANEL"]		= counter()--37
devices["VHF_RADIO"]				= counter()--38		-- AN/ARC-222
devices["INTERCOM"]					= counter()--39
devices["MIDS_RT"]					= counter()--40
devices["MIDS"]						= counter()--41
devices["KY58"]						= counter()--42		-- KY-58 Secure Speech System
devices["ILS"]						= counter()--43
-- Instruments --------------------------
devices["AOA_INDICATOR"]			= counter()--44
devices["AAU34"]     				= counter()--45		-- Altimeter AAU-34/A
devices["AMI"]						= counter()--46		-- Airspeed/Mach Indicator
devices["SAI"]						= counter()--47
devices["VVI"]						= counter()--48		-- Vertical Velocity Indicator
devices["STANDBY_COMPASS"]			= counter()--49
devices["ADI"]    					= counter()--50		-- Attitude Director Indicator
devices["CLOCK"]					= counter()--51
--
devices["MACROS"]					= counter()--52
devices["AIHelper"]					= counter()--53
devices["KNEEBOARD"] 				= counter()--54
devices["ARCADE"]					= counter()--55
--
devices["TACAN_CTRL_PANEL"]			= counter()--56
-- Armament
devices["SIDEWINDER_INTERFACE"]		= counter()--57
devices["TGP_INTERFACE"]			= counter()--58
--
devices["GPS"]						= counter()--59
devices["IDM"]						= counter()--60
devices["MAP"]						= counter()--61
-- Armament
devices["MAV_INTERFACE"]			= counter()--62
devices["HARM_INTERFACE"]			= counter()--63
devices["HTS_INTERFACE"]			= counter()--64
--
devices["DTE"]						= counter()--65
-- ECM ----------------------------------
devices["ECM_INTERFACE"]			= counter()--66		-- Electronic Countermeasures interface
