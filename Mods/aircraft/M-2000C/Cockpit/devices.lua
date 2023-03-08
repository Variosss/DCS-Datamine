---- COUNTER FOR DEVICE ID-----
local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices = {}
devices["FLIGHTINST"]	        = counter()	-- 1
devices["NAVINST"]		        = counter()	-- 2
devices["ENGINE"]		        = counter()	-- 3
devices["INSTPANEL"]	        = counter()	-- 4
devices["VTB"]		        	= counter()	-- 5
devices["PCA"]		        	= counter()	-- 6
devices["ENGPANEL"]		        = counter()	-- 7
devices["PWRPNL"]		        = counter()	-- 8
devices["PCN"]			        = counter()	-- 9
devices["INS"]					= counter() -- 10
devices["PCR"]		        	= counter()	-- 11
devices["SERVAL"]		        = counter()	-- 12	SERVAL & ECLAIR (Counter Measure dispensers)
devices["PCCM"]			        = counter()	-- 13	Poste de Controle Contre Measures (Countermeasures panel)
devices["HYDRAULICS"]	        = counter()	-- 14
devices["MAGIC"]		        = counter()	-- 15
devices["SYSLIGHTS"]	        = counter()	-- 16
devices["CDVE"]			        = counter()	-- 17
devices["ELECTRIC"] 	        = counter()	-- 18
devices["VHF"]			        = counter()	-- 19
devices["UHF"]			        = counter()	-- 20
devices["INTERCOM"]		        = counter()	-- 21
devices["MISCPANELS"]	        = counter() -- 22
devices["TACAN"]	            = counter() -- 23
devices["VORILS"]	            = counter() -- 24
devices["ECS"]	                = counter() -- 25
devices["FBW"]	                = counter() -- 26
devices["DDM"]	                = counter() -- 27	Detecteur de Depart Missile (MLWS)
devices["SPIRALE"]              = counter() -- 28	SPIRALE (Countermeasure dispenser)
devices["CAS"]					= counter() -- 29	Calculateur Air Sol (Air Ground Calculator)
devices["SNA"]					= counter() -- 30	Systeme de navigation et d'attaque
devices["Helmet_NVG"]			= counter() -- 31
devices["PPA"]					= counter() -- 32	Panneau de Préparation Armement (Weapon Preparation Panel)
devices["RDI"]					= counter() -- 33	Radar Doppler Impulsions (main radar)
devices["DATABUS"]				= counter() -- 34	
devices["CCLT"]					= counter() -- 35	Calcul Continu Ligne Tracantes (Gun snake)
devices["VTH"]		        	= counter()	-- 36	Visee Tete Haute (Head Up Display)
devices["CAA"]		        	= counter()	-- 37	Calculateur Air Air	(Air Air Calculator)
devices["RS"]		        	= counter()	-- 38	Radio Sonde	(Radar Altimeter)
devices["TAF"]		        	= counter()	-- 39	Teleaffichage (Datalink)
devices["CANOPY"]	        	= counter()	-- 40
devices["SABRE"]	        	= counter()	-- 41	SABRE (Jammer)



devices["KNEEBOARD"]        	= 100



