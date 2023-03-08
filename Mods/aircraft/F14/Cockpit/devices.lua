local count = 8
local function counter()
	count = count + 1
	return count
end

devices = {}
devices["PROXY"] = 1 -- must be 1, hardcoded device ID of 1 is used by mission files (see proxy_device.lua)
devices["ICS"] = 2  -- hardcoded for SimpleRadioStandalone integration
devices["ARC159"] = 3 -- hardcoded for SimpleRadioStandalone integration
devices["ARC182"] = 4 -- hardcoded for SimpleRadioStandalone integration
devices["COUNTERMEASURES"] = 5 -- hardcoded for the ground crew menu options (countermeasures loadout)
devices["EPOXY"] = 6 -- hardcoded for some glue
devices["LANTIRN"] = 7
devices["SENSORS"] = 8
-- Adjust 'local count' (the first line) before adding a fixed ID device here.

devices["FMSENSOR"] = counter()

devices["MULTICREW"] = counter()

devices["BITPANEL"] = counter()
devices["COCKPITMECHANICS"] = counter()
devices["HYDRAULICS"] = counter()
devices["AICS"] = counter()
devices["ELECTRICS"] = counter()
devices["PNEUMATICS"] = counter()

devices["WINGSWEEP"] = counter()
devices["GEARHOOK"] = counter()
devices["FLAPS"] = counter()

devices["ENGINE"] = counter()
devices["FUELSYSTEM"] = counter()

devices["AFCS"] = counter()
devices["CADC"] = counter()
devices["CAP"] = counter()

devices["ACCELEROMETER"] = counter()
devices["AOASYSTEM"] = counter()
devices["CLOCK"] = counter()
devices["MACHANDAIRSPEED"] = counter()
devices["BAROALTIMETER"] = counter()
devices["RADARALTIMETER"] = counter()
devices["STDBYAI"] = counter()
devices["TURNANDSLIP"] = counter()
devices["VERTICALVEL"] = counter()
devices["STANDBYCOMPASS"] = counter()

devices["WARNINGLIGHTS"] = counter()

devices["FCINSTRUMENTS"] = counter()

devices["BDHI"] = counter()

-- sensors
devices["TCS"] = counter()
devices["RADAR"] = counter()

-- displays
devices["HUD"] = counter()
devices["HSD"] = counter()
devices["VDI"] = counter()
devices["TID"] = counter()
devices["ECMD"] = counter()
devices["HELMET_DEVICE"] = counter()

-- navigation
devices["NAV_INTERFACE"] = counter()
devices["TACAN"] = counter()
devices["ILS"] = counter()
devices["IMU"] = counter()
devices["INS"] = counter()
devices["AHRS"] = counter()

devices["DATALINK"] = counter()

-- ECM
devices["DECM"] = counter()
devices["RWR"] = counter()

-- weapons
devices["WEAPONS"] = counter()

-- misc
devices["WALKMAN"] = counter()

devices["HOTAS"] = counter()
devices["HCU"] = counter()

--devices["ICSRADIO"] = counter()
--devices["TESTRADIO"] = counter()
--devices["TESTINTERCOM"] = counter()

devices["DEBUGDISPLAY"] = counter()
devices["CONTROLS"] = counter()

devices["KNEEBOARD"] = counter()

devices["JESTERAI"] = counter()

devices["WCS"] = counter()
devices["IFF"] = counter()

devices["AUTO"] = counter()

devices["PADLOCK"] = counter()
devices["FIRE"] = counter()

devices["AUTOPILOT"] = counter()
devices["REPAIR_DEVICE"] = counter()
