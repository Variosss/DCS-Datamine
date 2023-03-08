--revised 20. Jan 2015.
--/N/ this script holds navigation data to be used with MiG-21BiS mod

--[[
/N/ Instructions for inserting a custom station:

1. RSBN
		RSBN table can hold up to 100 stations. 
		See the commented example at the end of active stations sequence.
		- uncomment or add additional station (copy-paste existing one),
		- change it according to this example:
		
		{
			airbase = 'AAAAAA',	-- name of station, ignore "airbase" variable name
			lat = YY.YYYY, -- latitude from Editor map
			long = XX.XXXX, -- longitude from Editor map
			alt = HHH, -- above sea altitude on station location, read from Editor map
			rwy = CC, -- if station is near RWY, this will be the PRMG course, insert value between 0-180 in degrees
			length = LLLL, -- length of the RWY if exist, if not - put 2500 (in meters)
			code = '.- -. .- ' -- Morse code, be very careful, separate letters with one space, put one space at the end
		},

2. ARK
		for ARK data -> Every 10th channel MUST be empty, like it is now!
		Go to first free slot that has
			country = 0
		value.

		Edit it in this manner:

		{
			country = 'CCC - description here',
			freq = FFF, -- frequency number if you know it, if not - put 3 digit number
			lat = YY.YYYY, -- latitude from Editor map
			long = XX.XXXX, -- longitude from Editor map
			location = 'LLLL', -- map sector from Editor map, this should help you find your station later
			code = '--.. - ...-- ..--- ' -- Morse code, be very careful, separate letters with one space, put one space at the end
		},

]]

RSBN_data = {

	{
		airbase = 'Anapa',	-- 1
		lat = 45.00472,
		long = 37.34750,
		alt = 40,--45
		rwy = 41.5,--42
		length = 2900,
		code = '.- -. .- ' --/N/ Ana_
	},
	
	{
		airbase = 'Krimsk', --2
		lat	= 44.96778,
		long	= 37.99472,
		alt	= 15,--20
		rwy	= 39.5,--40
		length	= 2600,
		code = '-.- .-. .. ' --/N/ Kri_
	},
	
	{
		airbase = 'Krasnodar', --3
		lat = 45.08667,
		long = 38.94083,
		alt = 30,
		rwy = 87.5,--87
		length = 2500,
		code = '-.- ... -.. ' --/N/ Ksd_ to avoid similarity with Kri
	},

	{	
		airbase = 'Pashkovskiy', --4
		lat = 45.03833,
		long = 39.18917,
		alt = 29,--34
		rwy = 47.5,--47
		length = 3000,
		code = '.--. .- ... ' --/N/ Pas_
	},

	{
		airbase = 'Maykop', --5
		lat = 44.68139,
		long = 40.03556,
		alt = 175,--180
		rwy = 39.5,--39
		length = 3200,
		code = '-- .- -.-- ' --/N/ May_
	},

	{	
		airbase = 'Adler', --6
		lat = 43.44361,
		long = 39.94028,
		alt = 25,--30
		rwy = 62.5,--62
		length = 3100,
		code = '.- -.. .-.. ' --/N/ Adl_
	},

	{
		airbase = 'Mineralnye Vody', --7
		lat = 44.22778,
		long	 = 43.08056,
		alt = 315,--320
		rwy = 115.5,--115
		length = 4000,
		code = '-- .. -. ' --/N/ Min_
	},

	{
		airbase = 'Nalchik', --8
		lat = 43.51472,
		long	 = 43.63861,
		alt = 430,
		rwy = 55.5,--56
		length = 2300,
		code = '-. .- .-.. ' --/N/ Nal_
	},
	
	{
		airbase = 'Mozdok',	--9
		lat = 43.79139,
		long	 = 44.59972,
		alt = 150,--155
		rwy = 83.5,--83
		length = 3500,
		code = '-- --- --.. ' --/N/ Moz_
	},
	
	{		
		airbase = 'Beslan',	 --10
		lat = 43.20528,
		long	 = 44.60611,
		alt = 535,--540
		rwy = 94.5,--94
		length = 3100,
		code = '-... . ... ' --/N/ Bes_
	},
	
	{		
		airbase = 'Tbilisi Vaziani',	--11
		lat = 41.62833,
		long	 = 45.02750,
		alt = 450,--455
		rwy = 134.5,--135
		length = 2500,
		code = '- ...- .- ' --/N/ Tva_
	},
	
	{
		airbase = 'Tbilisi Lochini', --12
		lat = 41.66833,
		long = 44.95472,
		alt = 465,--470
		rwy = 128,--128
		length = 3000,
		code = '- .-.. --- ' --/N/ Tlo_
	},
	
	{
		airbase = 'Kutaisi', --13
		lat = 42.17750,
		long	 = 42.48194,
		alt = 40,--45
		rwy = 74.5,--74
		length = 2500,
		code = '-.- ..- - ' --/N/ Kut_
	},

	{	
		airbase = 'Senaki Kolkhi', --14
		lat = 42.24056,
		long	 = 42.04778,
		alt = 11,--13
		rwy = 95.5,--95
		length = 2400,
		code = '... . -.- ' --/N/ Sek_
	},

	{	
		airbase = 'Kobuleti', --15
		lat = 41.93028,
		long	 = 41.86528,
		alt = 15,--18
		rwy = 70,--70
		length = 2400,
		code = '-.- --- -... ' --/N/ Kob_
	},

	{
		airbase = 'Batumi', --16
		lat = 41.60917,
		long	= 41.60028,
		alt = 8,--10
		rwy = 126.5,--126
		length = 2450,
		code = '-... .- - ' --/N/ Bat_
	},
	
	--[[ /N/ EXAMPLE of custom station
	{
		airbase = 'My Airbase or My station', --17
		lat = 41.99215,
		long	= 42.20137,
		alt = 100,
		rwy = 44, --makes sense if the station is near the runway
		length = 3000, --makes sense if the station is near the runway
		code = '.- -... - ' --/N/ Abt_ Morse signals should be separated by an empty space + one empty space at the end of the sequence 
	},	
	
	]]

}


ARK_data = {

		--/N/ UKRAINE - ARK sector 1 I, channels 1 - 9
	{
		country = 'UKR - Krim', --1 / absolute 1
		freq = 1050,
		lat = 45.36667,
		long = 36.40000,
		location = 'YR63',
		code = '-.-- .-. -.... ...-- ' --/N/ YR63_
	},

	{
		country ='UKR - Krim',
		freq = 301,
		lat = 45.01444,
		long = 35.41917,
		location ='XQ99',
		code = '-..- --.- ----. ----. ' --/N/ YR63_
	},

	{
		country = 'UKR - Krim', --3
		freq = 395,
		lat = 44.83361,
		long = 34.24972,
		location = 'XQ06',
		code = '-..- --.- ----- -.... ' --/N/ XQ06_
	},
	
	{
		country = 'UKR - Krim',
		freq = 	580,
		lat = 44.75056,
		long = 33.56694,
		location = 'WQ45',
		code = '.-- --.- ....- ..... ' --/N/ WQ45_
	},
	
	{
		country = 'UKR - Krim', --5
		freq = 1175,
		lat = 45.37889,
		long = 33.36111,
		location = 'WR22',
		code = '.-- .-. ..--- ..--- ' --/N/ WR22_
	},
	
	{
		country = 'UKR - Krim',
		freq = 670,
		lat = 45.62472,
		long = 34.89833,
		location = 'XR45',
		code = '-..- .-. ....- ..... ' --/N/ XR45_
	},
	
	{
		country = 'UKR - Azov Sea coast', --7
		freq = 342,
		lat = 46.81667,
		long = 36.76694,
		location = 'YS89',
		code = '-.-- ... ---.. ----. ' --/N/ YS89_
	},
	
	{
		country = 'UKR - Azov Sea coast',
		freq = 770,
		lat = 47.08333,
		long = 39.45056,
		location = 'ZT32',
		code = '--.. - ...-- ..--- ' --/N/ ZT32_
	},
	
	{
		country = 'UKR - Azov Sea coast', --9
		freq = 720,
		lat = 47.20083,
		long = 38.84972,
		location = 'DN92',
		code = '-.. -. ----. ..--- ' --/N/ DN92_
	},
	
	{
	--/N/ 10th channel must be empty
		country = 0
	},
	
	--/N/ sector 1 II, not in use in order to separate UKR from RUS frequency fields
	{
		--1 / absolute 11
		country = 0		
	},	
	
	{
		country = 0
	},
	
	{
		--3
		country = 0		
	},
	
	{
		country = 0
	},

	{
		--5
		country = 0		
	},	
	
	{
		country = 0
	},
	
	{
		--7
		country = 0		
	},
	
	{
		country = 0
	},
	
	{
		--9
		country = 0		
	},
	
	{
		--/N/ 10th channel must be empty
		country = 0		
	},
	
	--/N/ RUSSIA - ARK sector 2 I and 2 II, channels 1 - 9 * 2 (18 channels)
	{
		country = 'RUS', --1 / absolute 21
		freq = 301,
		lat = 45.43972,
		long = 36.85333,
		location = 'ZR03',
		code = '--.. .-. ----- ...-- ' --/N/ ZR03_
	},
	
	{
		country = 'RUS',
		freq = 420,
		lat = 44.32056,
		long = 38.70139,
		location = 'DK70 Dzhubga',
		code = '-.. -.- --... ----- ' --/N/ DK70_
	},
	
	{
		country = 'RUS', --3
		freq = 662,
		lat = 44.78778,
		long = 38.79639,
		location = 'DK85',
		code = '-.. -.- ---.. ..... ' --/N/ DK85_
	},
	
	{
		country = 'RUS',
		freq = 381,
		lat = 44.13333,
		long = 39.03417,
		location = 'EJ08 Tuapse',
		code = '. .--- ----- ---.. ' --/N/ EJ08_
	},
	
	{
		country = 'RUS', --5
		freq = 312,
		lat = 44.96667,
		long = 39.56639,
		location = 'EK47',
		code = '. -.- ....- --... ' --/N/ EK47_
	},
	
	{
		country = 'RUS',
		freq = 330,
		lat = 45.22694,
		long = 39.65389,
		location = 'EL50 Ust-Labinsk',
		code = '. .-.. ..... ----- ' --/N/ EL50_
	},
	
	{
		country = 'RUS', --7
		freq = 307,
		lat = 43.91722,
		long = 39.33750,
		location = 'EJ26 Lazarevkoe',
		code = '. .--- ..--- -.... ' --/N/ EJ26_
	},
	
	{
		country = 'RUS',
		freq = 682,
		lat = 44.62306,
		long = 40.14694,
		location = 'EK94 Maykop',
		code = '. -.- ----. ....- ' --/N/ EK94_
	},
	
	{
		country = 'RUS', --9
		freq = 1210,
		lat = 44.11667,
		long = 41.46694,
		location = 'FJ98',
		code = '..-. .--- ----. ---.. ' --/N/ FJ98_
	},
	
	{
		--/N/ 10th channel must be empty
		country = 0		
	},	
	
	-- 2 II sector channels
	{
		country = 'RUS', -- 1 / absolute 31
		freq = 995,
		lat = 43.94139,
		long = 42.65000,
		location = 'GJ96 Kisovodsk',
		code = '--. .--- ----. -.... ' --/N/ GJ96_
	},
	
	{
		country = 'RUS',
		freq = 1182,
		lat = 44.15500,
		long = 43.53306,
		location = 'LP89 Georgievsk',
		code = '.-.. .--. ---.. ----. ' --/N/ LP89_
	},
	
	{
		country = 'RUS', --3
		freq = 735,
		lat = 43.46639,
		long = 45.21667,
		location = 'NP11',
		code = '-. .--. .---- .---- ' --/N/ NP11_
	},
	
	{ -- reserved for RUSSIA
		country = 0
	},
	
	{ -- reserved for RUSSIA
		country = 0
	},
	
	{ -- reserved for RUSSIA
		country = 0
	},
	
	{ -- reserved for RUSSIA
		country = 0
	},
	
	{ -- reserved for RUSSIA
		country = 0
	},
	
	{ -- reserved for RUSSIA
		country = 0
	},
	
	{
		--/N/ 10th channel must be empty
		country = 0		
	},	
	
	--/N/ GEORGIA - ARK sector 3 I, channels 1 - 5 used
	{
		country = 'GEO - Abkhazia', --1 / absolute 41
		freq = 395,
		lat = 43.09889,
		long = 40.57861,
		location = 'FH27 Gudauta RWY',
		code = '..-. .... ..--- --... ' --/N/ FH27_
	},
	
	{
		country = 'GEO - Abkhazia',
		freq = 995,
		lat = 42.83333,
		long = 41.18444,
		location = 'FH74 Sukhumi RWY',
		code = '..-. .... --... ....- ' --/N/ FH74_
	},
	
	{
		country = 'GEO - Abkhazia', --3
		freq = 	525,
		lat = 42.60000,
		long = 41.78306,
		location = 'GH22 Gali',
		code = '--. .... ..--- ..--- ' --/N/ GH22_
	},
	
	{
		country = 'GEO', 
		freq = 845,
		lat = 42.26889,
		long = 42.62444,
		location = 'LM08 Kutaisi',
		code = '.-.. -- ----- ---.. ' --/N/ LM08_
	},
	
	{
		country = 'GEO', --5
		freq = 462,
		lat = 42.01694,
		long = 44.13278,
		location = 'MM25 Gori',
		code = '-- -- ..--- ..... ' --/N/ MM25_
	},
	
	{
		country = 0	
	},
	
	{
		--7
		country = 0		
	},	
	
	{
		country = 0	
	},

	{
		--9
		country = 0		
	},
	
	{
		--/N/ 10th channel must be empty
		country = 0		
	},
	
}
	
need_to_be_closed = true