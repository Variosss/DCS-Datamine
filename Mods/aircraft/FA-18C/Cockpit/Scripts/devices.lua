local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices = {}
-- do not change following sequence for sim
devices["FM_PROXY"]					= counter()--1
devices["CONTROL_INTERFACE"]		= counter()--2
devices["ELEC_INTERFACE"]			= counter()--3
devices["HYDRAULIC_INTERFACE"]		= counter()--4
devices["GEAR_INTERFACE"]			= counter()--5
devices["FUEL_INTERFACE"]			= counter()--6
devices["CPT_MECHANICS"]			= counter()--7      -- Integral device for various mechanical systems like canopy, etc
devices["EXT_LIGHTS"]				= counter()--8      -- External Lighting
devices["CPT_LIGHTS"]				= counter()--9      -- Cockpit Lighting
devices["OXYGEN_INTERFACE"]			= counter()--10     -- Cockpit interface to OBOGS
devices["ECS_INTERFACE"]			= counter()--11		-- Environmental Control System
devices["ENGINES_INTERFACE"]		= counter()--12		-- Cockpit interface to aircraft engines
-- HOTAS Interface
devices["HOTAS"]					= counter()--13     -- Stick and throttle grips
-- Computers -----------------------------
devices["MUX"]						= counter()--14     -- Multiplex manager, holds channels and manages remote terminals addition/remove
devices["SDC"]						= counter()--15     -- Signal Data Computer (part of FIRAMS)
devices["MISSION_COMPUTER_NO_1"]	= counter()--16     -- AN/AYK-14, Mission Computer No 1
devices["MISSION_COMPUTER_NO_2"]	= counter()--17     -- AN/AYK-14, Mission Computer No 2
devices["FCCA"]						= counter()--18		-- Flight Control Computer A
devices["FCCB"]						= counter()--19		-- Flight Control Computer B
devices["ADC"]						= counter()--20		-- Air Data Computer - CPO-1334/A
devices["ARMAMENT_COMPUTER"]		= counter()--21		-- Armament Computer - AYK-22
devices["CONTROL_CONVERTER"]		= counter()--22		-- Control-Converter - C-10382/A
devices["SMS"]		                = counter()--23		-- Stores Management System, Armament Computer - CP-2218/AYK-22(V)
devices["DIGITAL_MAP_COMPUTER"]		= counter()--24		-- Digital Map Computer - CP-1802/ASQ-196
devices["UFC"]						= counter()--25     -- Electronic Equipment Control (UFC) - C-10380/ASQ
-- Instruments --------------------------
devices["AAU52"]     				= counter()--26		-- Standby Pressure Altimeter - AAU-52/A
devices["AVU35"]     				= counter()--27		-- Indicated Airspeed Indicator - AVU-35/A
devices["AVU53"]     				= counter()--28		-- Vertical Speed Indicator - AVU-53/A
devices["STANDBY_COMPASS"]			= counter()--29     -- Standby Compass - AQU-3/A
devices["ID2163A"]					= counter()--30     -- Radar Altimeter Height Indicator - ID-2163/A
devices["RADAR_ALTIMETER"]			= counter()--31     -- Radar Altimeter - APN-194(V)
devices["SAI"]						= counter()--32     -- Standby Attitude Indicator - ARU-48
-- FIRAMS --------------------------
devices["IFEI"]						= counter()--33     -- Integrated Fuel/Engine Indicator (IFEI)
-- Multipurpose Display Group
devices["HUD"]						= counter()--34     -- Head-Up Display - AVQ-32
devices["MDI_LEFT"]					= counter()--35     -- Left Multipurpose Display Indicator (DDI) - IP-1556/A
devices["MDI_RIGHT"]				= counter()--36     -- Right Multipurpose Display Indicator (DDI) - IP-1556/A
devices["AMPCD"]					= counter()--37     -- Advanced Multipurpose Color Display - ???
-- Radio & Comm
devices["UHF1"]						= counter()--38		-- VHF/UHF Receiver-Transmitter - ARC 210
devices["UHF2"]						= counter()--39		-- VHF/UHF Receiver-Transmitter - ARC 210 DCS
devices["INTERCOM"]					= counter()--40     -- Intercommunication Amplifier-Control - AM-7360/A
devices["KY58"]						= counter()--41		-- KY-58 Secure Speech System
-- Sensors
devices["RADAR"]					= counter()--42     -- Radar - AN/APG-73, interfaced to the rest of avionic system via the Radar Data Processor CP-2062/APG-73
devices["FLIR"]						= counter()--43     -- Forward Looking Infrared Pod interface
-- INS/GPS
devices["INS"]						= counter()--44     -- INS, AN/ASN-139
devices["GPS"]						= counter()--45     -- GPS, AN/ASN-163
devices["MAD"]						= counter()--46     -- Magnetic Azimuth Detector, DT-604/A
-- Armament
devices["SIDEWINDER_INTERFACE"]		= counter()--47
devices["MAVERICK_INTERFACE"]		= counter()--48
-- RNAV
devices["ADF"]						= counter()--49		-- Direction Finder OA-8697/ARD
devices["ANTENNA_SELECTOR"]			= counter()--50
devices["MIDS"]						= counter()--51		-- MIDS-LVT (implements Link 16 and TACAN)
devices["ILS"]						= counter()--52		-- AN/ARA-63D, airborne segment of US NAVY ACLS, and US Marines MRAALS
-- TEWS
devices["RWR"]						= counter()--53		-- AN/ALR-67(V)
devices["CMDS"]						= counter()--54		-- Countermeasures dispenser system
--
devices["MACROS"]					= counter()--55
-- IFF
devices["IFF"]						= counter()--56		-- IFF, AN/APX-111(V) CIT
-- Helmet
devices["HELMET"]					= counter()--57
devices["HMD_INTERFACE"]			= counter()--58
-- MIDS parts
devices["MIDS_RT"]					= counter()--59
--
devices["CLC"]						= counter()--60		-- Command Launch Computer
devices["HARM_INTERFACE"]			= counter()--61
devices["TGP_INTERFACE"]			= counter()--62
devices["WALLEYE_INTERFACE"]		= counter()--63
devices["DATALINK_INTERFACE"]		= counter()--64
devices["SLAM_INTERFACE"]			= counter()--65
-- ASPJ
devices["ASPJ"]						= counter()--66
--
devices["BCN"]						= counter()--67

devices["KNEEBOARD"] 				= counter()--68

devices["LINK4"] 					= counter()--69
