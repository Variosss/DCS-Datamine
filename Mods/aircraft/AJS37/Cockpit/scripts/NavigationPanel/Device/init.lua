local gettext = require("i_18n")
_ = gettext.translate

Damage =
{
	{
		Failure = 2,
		Failure_name = "AC_BUS_FAILURE_TOTAL",
		Failure_editor_name = _(""),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
	
	{
		Failure = 3,
		Failure_name = "AC_BUS_PO7501_FAILURE",
		Failure_editor_name = _(""),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	

	{
		Failure = 4,
		Failure_name = "AC_BUS_PO7502_FAILURE",
		Failure_editor_name = _(""),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},		
}
NAV_settings = {
{
	output_bases = true, -- Outputs info about the bases on the map into the dcs.log
}
}

NAV_data_BlackSea = {
  -- FYLL PÅ!
  -- The code can't start with a 0
  -- The runway heading needs to be as exact as possible and should be in-game heading (by using the map-tool) and not real world or magnetic heading.
  
 -- {
	-- code = 9001, -- Batumi
  	-- latitude = 41.60917,
	-- longitude = 41.60028,
	-- isrunway = true, -- false for regular navpoint
	-- rwyheading = 126.5,--126
	-- rwyalt = 10,--meters 
	-- rwylength = 2455, --meters
	-- tilschannel = 10,
  -- },
  
  -- {
	-- code = 9002, -- Kobuleti
  	-- latitude = 41.93,
	-- longitude = 41.86389,
	-- isrunway = true, -- false for regular navpoint
	-- rwyheading = 70,
	-- rwyalt = 18,--meters 
	-- rwylength = 2400, --meters
	-- tilschannel = 12,
  -- },
  
  
  
  -- { -- Example! (Some place near Maykop?)
	-- code = 9211,
  	-- latitude = 44.62306,
	-- longitude = 40.14694,
	-- isrunway = false, -- false for regular navpoints
	-- rwy = 0,--Is not used
	-- rwyalt = 0,--neither is this
	-- rwylength = 0, --nor this
	-- tils = 0, -- not even this
  -- },
  
  -- { -- ARK-station near Gori?
		-- code = 9212,
	-- latitude = 42.01694,
	-- longitude = 44.13278,
	-- isrunway = false, -- false for regular navpoints
	-- rwy = 0,--Is not used
	-- rwyalt = 0,--neither is this
	-- rwylength = 0, --nor this
	-- tils = 0, -- not even this
-- },
-- { -- ARK-station near Gali
	-- name = "Radio-beacon near Gali",
	-- code = 9261,
		-- latitude = 42.60000,
		-- longitude = 41.78306,
		-- isrunway = false, -- false for regular navpoints
	-- rwy = 0,--Is not used
	-- rwyalt = 0,--neither is this
	-- rwylength = 0, --nor this
	-- tils = 0, -- not even this
-- }
}

TILS_stations_BlackSea = {
	-- Please note that these needs to be _exactly_ in the middle of the runway (I think a error-marginal within decimeters would suffice)
	-- the heading also needs to be exact and is the runway heading as seen by using the map-tool within DCS (not real-world heading or magnetic heading).
	-- {
		-- tilschannel = 10,
		-- latitude = 41.60917, -- Degrees
		-- latitudeminutes = 0, -- Optional
		-- latitudeseconds = 0, -- Optional
		-- longitude = 41.60028, -- Degrees
		-- longitudeminutes = 0, -- Optional
		-- longitudeseconds = 0, -- Optional
		-- rwyheading = 126.5,--126
		-- rwyalt = 10,--meters 
		-- rwylength = 2455, --meters
  -- },
  
	-- {
		-- airbase = 'Anapa',	-- 1
		-- latitude = 45.00472,
		-- longitude = 37.34750,
		-- rwyalt = 40,--45
		-- rwyheading = 41.5,--42
		-- rwylength = 2900,
		-- code = '.- -. .- ', --/N/ Ana_
		-- tilschannel = 10,
	-- },
	
	-- {
		-- airbase = 'Krimsk', --2
		-- latitude	= 44.96778,
		-- longitude 	= 37.99472,
		-- rwyalt	= 15,--20
		-- rwyheading	= 39.5,--40
		-- length	= 2600,
		-- code = '-.- .-. .. ' --/N/ Kri_
	-- },
	
	-- {
		-- airbase = 'Krasnodar', --3
		-- latitude = 45.08667,
		-- longitude = 38.94083,
		-- rwyalt = 30,
		-- rwyheading = 87.5,--87
		-- rwylength = 2500,
		-- code = '-.- ... -.. ' --/N/ Ksd_ to avoid similarity with Kri
	-- },

	-- {	
		-- airbase = 'Pashkovskiy', --4
		-- latitude = 45.03833,
		-- longitude = 39.18917,
		-- rwyalt = 29,--34
		-- rwyheading = 47.5,--47
		-- rwylength = 3000,
		-- code = '.--. .- ... ' --/N/ Pas_
	-- },

	-- {
		-- airbase = 'Maykop', --5
		-- latitude = 44.68139,
		-- longitude = 40.03556,
		-- rwyalt = 175,--180
		-- rwyheading = 39.5,--39
		-- rwylength = 3200,
		-- code = '-- .- -.-- ' --/N/ May_
	-- },

	-- {	
		-- airbase = 'Adler', --6
		-- latitude = 43.44361,
		-- longitude = 39.94028,
		-- rwyalt = 25,--30
		-- rwyheading = 62.5,--62
		-- rwylength = 3100,
		-- code = '.- -.. .-.. ' --/N/ Adl_
	-- },

	-- {
		-- airbase = 'Mineralnye Vody', --7
		-- latitude = 44.22778,
		-- longitude 	 = 43.08056,
		-- rwyalt = 315,--320
		-- rwyheading = 115.5,--115
		-- rwylength = 4000,
		-- code = '-- .. -. ' --/N/ Min_
	-- },

	-- {
		-- airbase = 'Nalchik', --8
		-- latitude = 43.51472,
		-- longitude 	 = 43.63861,
		-- rwyalt = 430,
		-- rwyheading = 55.5,--56
		-- rwylength = 2300,
		-- code = '-. .- .-.. ' --/N/ Nal_
	-- },
	
	-- {
		-- airbase = 'Mozdok',	--9
		-- latitude = 43.79139,
		-- longitude 	 = 44.59972,
		-- rwyalt = 150,--155
		-- rwyheading = 83.5,--83
		-- rwylength = 3500,
		-- code = '-- --- --.. ' --/N/ Moz_
	-- },
	
	-- {		
		-- airbase = 'Beslan',	 --10
		-- latitude = 43.20528,
		-- longitude 	 = 44.60611,
		-- rwyalt = 535,--540
		-- rwyheading = 94.5,--94
		-- rwylength = 3100,
		-- code = '-... . ... ' --/N/ Bes_
	-- },
	
	-- {		
		-- airbase = 'Tbilisi Vaziani',	--11
		-- latitude = 41.62833,
		-- longitude 	 = 45.02750,
		-- rwyalt = 450,--455
		-- rwyheading = 134.5,--135
		-- rwylength = 2500,
		-- code = '- ...- .- ' --/N/ Tva_
	-- },
	
	-- {
		-- airbase = 'Tbilisi Lochini', --12
		-- latitude = 41.66833,
		-- longitude = 44.95472,
		-- rwyalt = 465,--470
		-- rwyheading = 128,--128
		-- rwylength = 3000,
		-- code = '- .-.. --- ' --/N/ Tlo_
	-- },
	
	-- {
		-- airbase = 'Kutaisi', --13
		-- latitude = 42.17750,
		-- longitude 	 = 42.48194,
		-- rwyalt = 40,--45
		-- rwyheading = 74.5,--74
		-- rwylength = 2500,
		-- code = '-.- ..- - ' --/N/ Kut_
	-- },

	-- {	
		-- airbase = 'Senaki Kolkhi', --14
		-- latitude = 42.24056,
		-- longitude 	 = 42.04778,
		-- rwyalt = 11,--13
		-- rwyheading = 95.5,--95
		-- rwylength = 2400,
		-- code = '... . -.- ' --/N/ Sek_
	-- },

	-- {	
		-- airbase = 'Kobuleti', --15
		-- latitude = 41.93028,
		-- longitude 	 = 41.86528,
		-- rwyalt = 15,--18
		-- rwyheading = 70,--70
		-- rwylength = 2400,
		-- code = '-.- --- -... ', --/N/ Kob_
		-- tilschannel = 12,
	-- },

	-- {
		-- airbase = 'Batumi', --16
		-- latitude = 41.60917,
		-- longitude = 41.60028,
		-- rwyalt = 8,--10
		-- rwyheading = 126.5,--126
		-- rwylength = 2450,
		-- code = '-... .- - ' --/N/ Bat_
	-- },
}

Radio_beacons_BlackSea = {
	{ -- ARK-station near Gori?
		latitude = 42.01694,
		longitude = 44.13278,
	},
	
		{

		latitude = 42.60000,
		longitude = 41.78306,
		location = 'GH22 Gali',
		
	},
}

Data_cartridges = {
	{
		cartridgenr = 1, -- Can be 1 to 5
		waypointnr = 0, -- From 0 to 10 where 0 i starting base LS and 10 is L1. Nearest pre-programmed airbase will be used.
		latitude = 41.60917, -- Degrees
		latitudeminutes = 0, -- Optional
		latitudeseconds = 0, -- Optional
		longitude = 41.60028, -- Degrees
		longitudeminutes = 0, -- Optional
		longitudeseconds = 0, -- Optional
		missiontime = 0, -- Optional. ETA in seconds from the start of the mission or when the aircraft is spawned.
		velocity = 0, -- Optional. Sets a forced speed in m/s.
		etalocked = false, -- Set to true to make the waypoint use the missiontime. Waypoint will be converted to targetpoint (Målpunkt)
		velocitylocked = false, -- Set to true to use the forced speed.
		istargetpoint = false, -- Set to true to set the waypoint as a targetpoint.
	},
	{
		cartridgenr = 1, -- Can be 1 to 5
		waypointnr = 1, -- From 0 to 10 where 0 i starting base LS and 10 is L1. Nearest pre-programmed airbase will be used.
		latitude = 41.93028, -- Degrees
		latitudeminutes = 0, -- Optional
		latitudeseconds = 0, -- Optional
		longitude = 41.86528, -- Degrees
		longitudeminutes = 0, -- Optional
		longitudeseconds = 0, -- Optional
		missiontime = 0, -- Optional. ETA in seconds from the start of the mission or when the aircraft is spawned.
		velocity = 0, -- Optional. Sets a forced speed in m/s.
		etalocked = false, -- Set to true to make the waypoint use the missiontime. Waypoint will be converted to targetpoint (Målpunkt)
		velocitylocked = false, -- Set to true to use the forced speed.
		istargetpoint = false, -- Set to true to set the waypoint as a targetpoint.
	},
	{
		cartridgenr = 1, -- Can be 1 to 5
		waypointnr = 2, -- From 0 to 10 where 0 i starting base LS and 10 is L1. Nearest pre-programmed airbase will be used.
		latitude = 42, -- Degrees
		latitudeminutes = 0, -- Optional
		latitudeseconds = 0, -- Optional
		longitude = 42, -- Degrees
		longitudeminutes = 0, -- Optional
		longitudeseconds = 0, -- Optional
		missiontime = 0, -- Optional. ETA in seconds from the start of the mission or when the aircraft is spawned.
		velocity = 340*0.8, -- Optional. Sets a forced speed in m/s.
		etalocked = false, -- Set to true to make the waypoint use the missiontime. Waypoint will be converted to targetpoint (Målpunkt)
		velocitylocked = true, -- Set to true to use the forced speed.
		istargetpoint = false, -- Set to true to set the waypoint as a targetpoint.
	},
	{
		cartridgenr = 1, -- Can be 1 to 5
		waypointnr = 3, -- From 0 to 10 where 0 i starting base LS and 10 is L1. Nearest pre-programmed airbase will be used.
		latitude = 42, -- Degrees
		latitudeminutes = 55, -- Optional
		latitudeseconds = 55, -- Optional
		longitude = 42, -- Degrees
		longitudeminutes = 55, -- Optional
		longitudeseconds = 55, -- Optional
		missiontime = 0, -- Optional. ETA in seconds from the start of the mission or when the aircraft is spawned.
		velocity = 0, -- Optional. Sets a forced speed in m/s.
		etalocked = false, -- Set to true to make the waypoint use the missiontime. Waypoint will be converted to targetpoint (Målpunkt)
		velocitylocked = false, -- Set to true to use the forced speed.
		istargetpoint = false, -- Set to true to set the waypoint as a targetpoint.
	},
	{
		cartridgenr = 1, -- Can be 1 to 5
		waypointnr = 10, -- From 0 to 10 where 0 i starting base LS and 10 is L1. Nearest pre-programmed airbase will be used.
		latitude = 42.17750, -- Degrees
		latitudeminutes = 0, -- Optional
		latitudeseconds = 0, -- Optional
		longitude = 42.48194, -- Degrees
		longitudeminutes = 0, -- Optional
		longitudeseconds = 0, -- Optional
		missiontime = 0, -- Optional. ETA in seconds from the start of the mission or when the aircraft is spawned.
		velocity = 0, -- Optional. Sets a forced speed in m/s.
		etalocked = false, -- Set to true to make the waypoint use the missiontime. Waypoint will be converted to targetpoint (Målpunkt)
		velocitylocked = false, -- Set to true to use the forced speed.
		istargetpoint = false, -- Set to true to set the waypoint as a targetpoint.
	},
}

need_to_be_closed = true