--/N/ redefined...feb 2014	

local count = 0
local function counter()
	count = count + 1
	return count
end 

devices = {}
devices["DC_BUS"] = counter() -- 1
devices["AC_BUS"] = counter() --2
devices["ENGINE_START_DEVICE"] = counter() --3
devices["FUEL_PUMPS"] = counter() -- 4
devices["FUEL_SYSTEM"] = counter() -- 5
devices["ENGINE"] = counter() -- 6
devices["CONTROL_SYSTEM"] = counter() --8 
devices["SAU"] = counter() --9
devices["TRIMER"] = counter() --10
devices["SPS"] = counter() --11
devices["ARU"] = counter() --12
devices["AIRBRAKE"] = counter() --13
devices["GEAR_BRAKES"] = counter() --14
devices["GEARS"] = counter() --15
devices["FLAPS"] = counter() --16
devices["CHUTE"] = counter() --17
devices["KONUS"] = counter() --18
devices["SOPLO"] = counter() --19
devices["OXYGENE_SYSTEM"] = counter() --20
devices["COMPRESSED_AIR_SYSTEM"] = counter() --21
devices["GYRO_DEVICES"] = counter() --22
devices["RADIO"] = counter() --23
devices["KSI"] = counter() --26
devices["ARK"] = counter() --27
devices["RSBN"] = counter() --28
devices["avAChS"] = counter() --29
devices["PITOT_TUBES"] = counter() --31
devices["KPP"] = counter() --32
devices["IAS_INDICATOR"] = counter() --33
devices["TAS_INDICATOR"] = counter() --34
devices["M_INDICATOR"] = counter() --35
devices["ALTIMETER"] = counter() --36
devices["RADIO_ALTIMETER"] = counter() --37
devices["DA_200"] = counter() --38
devices["ACCELEROMETER"] = counter() --39
devices["UUA"] = counter() --40
devices["SPO"] = counter() --41
devices["SRZO"] = counter() --42
devices["SOD"] = counter() --43
devices["RADAR"] = counter() --44
devices["ASP"] = counter() --45
devices["WEAPON_CONTROL"] = counter() --46
devices["CANOPY"] = counter() --47
devices["MAIN_HYDRO"] = counter() --48
devices["HELMET_VISOR"] = counter() --50
devices["LIGHTS"] = counter() --53
devices["LIGHTS_WARNING"] = counter() --54
devices["SPRD"] = counter() --55
devices["SARPP"] = counter() --56
devices["AIR_CONDITIONING"] = counter() --57
devices["UNCLASSIFIED"] = counter() --58
devices["MARKER"] = counter() --59 /N/ added Feb 2013
devices["FIRE_EXTINGUISHER"] = counter() --60 added Feb 2013
devices["MACROS"] = counter() --61 added Feb 2013
devices["INTERCOM"] = counter() --R: intercom
devices["NUKE_CONTROL"] = counter() --B: Nuke control box
devices["SPS_CONTROL"] = counter() --B: SPS control box
devices["ASO"] = counter() --R: ASO pod
	
devices["ARCADE"] = counter() -- for Arcade mode
devices["ARCADE2"] = counter() -- for Arcade2 mode
devices["KNEEBOARD"] = counter() --51 /N/ feb 2014
devices["PADLOCK"] = counter() --52

devices["DEBUG"] = counter() -- R: debug class DebugAvDevice
devices["DEBUG_AVIONICS_MODULE"] = counter() -- R: debug EdBinaryTemplate class

devices["SMOKE"] = counter() --/N/ feb 2014

devices["CONTROLSINDICATOR"] = counter()