RSBN_data_TheChannel = {

	map_location = 'NE',

	{
		airbase = 'Manston',	-- 1
		lat = 51.34194,
		long = 1.34583,
		alt = 55,--
		rwy = 102,--
		length = 2700,
		code = '-- .- -. ' --/N/ MAN_
	},
	
	{
		airbase = 'High Halden', --2
		lat	= 51.12472,
		long	= 0.70528,
		alt	= 37,--
		rwy	= 31,--
		length	= 1300,
		code = '.... .... .-.. ' --/N/ HHL_
	},
	
	{
		airbase = 'RES1 - Detling', --3
		lat = 51.30556,
		long = 0.59972,
		alt = 195,
		rwy = 45,--
		length = 1000,
		code = '-.. . - ' --/N/ DET_
	},

	{	
		airbase = 'RES2', --4
		lat = 25.02667,
		long = 55.36556,
		alt = 55,--
		rwy = 90,--
		length = 4000,
		code = '.- -- -. ' --/N/ AMN_
	},
	
	{	
		airbase = 'RES3', --5
		lat = 25.02667,
		long = 55.36556,
		alt = 55,--
		rwy = 90,--
		length = 4000,
		code = '.- -- -. ' --/N/ AMN_
	},
	
	{	
		airbase = 'Merville Calonne', --6
		lat = 50.61833,
		long = 2.64333,
		alt = 21,--
		rwy = 38,--
		length = 2900,
		code = '-- -.-. .- ' --/N/ MCA_
	},

	{	
		airbase = 'Abbeville Drucat', --7
		lat = 50.13444,
		long = 1.84528,
		alt = 61,--
		rwy = 90,--
		length = 1500,
		code = '.- -.. ..- ' --/N/ ADU_
	},
	
	{	
		airbase = 'RES4', --8
		lat = 26.17056,
		long = 56.24028,
		alt = 22,--
		rwy = 14,--
		length = 2500,
		code = '.- -- -. ' --/N/ AMN_
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


ARK_data_TheChannel = {

	map_location = 'NE',

		--/N/ ARK sector 1 I, channels 1 - 9
	{
		country = 'GBR', --1 / absolute 1
		freq = 999,
		lat = 51.07861,
		long = 1.01389,
		location = 'Lympne airfield', --
		code = '.-.. -.-- .- ' --/N/ LYA_
	},

	{
		country ='GBR',
		freq = 999,
		lat = 51.07861,
		long = 0.0000,
		location ='RESERVE_1',
		code = '.-. . ... ' --/N/ RES_
	},

	{
		country = 'GBR', --3
		freq = 999,
		lat = 51.07861,
		long = -1.01389,
		location ='RESERVE_2',
		code = '.-. . ... ' --/N/ RES_
	},
	
	{
		country = 'GBR',
		freq = 999,
		lat = 51.07861,
		long = -5.01389,
		location ='RESERVE_3',
		code = '.-. . ... ' --/N/ RES_
	},
	
	{
		country = 'FRN', --5
		freq = 999,
		lat = 51.02944,
		long = 2.25194,
		location = 'Dunkirk airfield',
		code = '-.. -.- .- ' --/N/ DKA_
	},
	
	{
		country = 'FRN',
		freq = 999,
		lat = 50.72861,
		long = 2.23194,
		location = 'Saint Omer Long. airfield',
		code = '... --- .-.. ' --/N/ SOL_
	},
	
	{
		country = 'FRN', --7
		freq = 999,
		lat = 50.72861,
		long = 4.23194,
		location = 'RESERVE_4',
		code = '.-. . ... ' --/N/ RES_
	},
	
	{
		country = 'FRN',
		freq = 999,
		lat = 50.72861,
		long = 6.23194,
		location = 'RESERVE_5',
		code = '.-. . ... ' --/N/ RES_
	},
	
	{
		--9
		country = 0	
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
	
	--/N/ ARK sector 2 I and 2 II, channels 1 - 9 * 2 (18 channels)
	{
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
	
	-- 2 II sector channels
	{
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
	
	--/N/ ARK sector 3 I, channels 1 - 5 used
	{
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
	
}

need_to_be_closed = true