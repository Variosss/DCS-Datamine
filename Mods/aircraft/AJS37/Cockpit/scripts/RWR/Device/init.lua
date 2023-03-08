local count_ = 0

function count()
	count_ = count_ + 1
	return count_
end

-- RWR sensors: six sensors + U/22
local sensorcount = 12
local sensorcoverage = 60
eyes ={}

for i = 0, sensorcount-1 do
	sensordir = i * (sensorcoverage/2)
	if (sensordir > 180) then
		sensordir = sensordir - 360
	end
	eyes[count()] =
	{
		position      = {x = 1.0,y = 0.0, z = 0.0},
		orientation   = {azimuth  = math.rad(sensordir),elevation = math.rad(0.0)},
		field_of_view = math.rad(sensorcoverage)
	}
end

eyes[count()] = -- U/22 jammer
{
    position      = {x = 1.0,y = 0.0,z =  0.0},
    orientation   = {azimuth  = math.rad(0),elevation = math.rad(0.0)},
    field_of_view = math.rad(60) 
}

cw = "<<<CCC<<<CCC"
hprf = "::DD::DD"
f1_lock = "7"
f1_launch = "7",


dofile('Scripts/Database/wsTypes.lua')

Emitter_Types = {}
Emitter_Types = {
	
	-- MA-APP27 V4.7
	-- M(ore) A(ccurate) - APP(arat)27
	
	-- Script made by Heatblur
	-- Remade RWR signals by MYSE1234
	
	-- Apparat 27 opperates in the 2GHz to 25GHz range
	-- anyting outside will not (should) not be picked up.
	-- Radars that are not suposed to be picked up are
	-- marked with "*" in the beginning of the name
	
	-- PRF's above 5600Hz, doppler, or CW will be "converted" to an "ambulance tone".
	-- -CW - alternating between 1200Hz and 1900Hz.
	-- -High PRF - alternating between 1000Hz and 2000hz
	
	--EWR--
	
	{ --- *Early warning radar EWR_1L13
		Type_Level4 = EWR_1L13,
		Type_Level3 = 101, 
		Type_Level2 = 16,
		Type_Level1 = wsType_Ground, 
		Search = "-", -- Beep 1.5 second then silence 8.5 seconds
		Lock = "-", -- Beep every 0.2 second (this will never happen)
		Carrier_Frequency = 200000, --Khz L-Band (Band 1)
	},
	{ --- *Early warning radar EWR_55G6
		Type_Level4 = EWR_55G6,
		Type_Level3 = 101, 
		Type_Level2 = 16,
		Type_Level1 = wsType_Ground, 
		Search = "-",
		Lock = "-", -- Beep every 0.2 second (this will never happen)
		Carrier_Frequency = 200000, --Khz (Band 1)
	},
	{ --- *Dog ear

		Type_Level4 = 27,
		Type_Level3 = 101, 
		Type_Level2 = 16,
		Type_Level1 = wsType_Ground, 
		Search = "-",
		Lock = "-", -- Beep every 0.2 second (this will never happen)
		Carrier_Frequency = 500000, --Khz (Band 1)
	},
	{ --- *Flat face - P19

		Type_Level4 = 75,
		Type_Level3 = 101, 
		Type_Level2 = 16,
		Type_Level1 = wsType_Ground, 
		Search = "-",
		Lock = "-", -- Beep every 0.2 second (this will never happen)
		Carrier_Frequency = 850000, --Khz (Band 1)
	},
	{ -- 19J6 - Tin Shield

		Type_Level4 = 309,
		Type_Level3 = 101, 
		Type_Level2 = 16,
		Type_Level1 = 2, 
		Search = "88--------------------------------------------------------------------------------------------------",
		Lock = "-", -- Beep every 0.2 second (this will never happen)
		Carrier_Frequency = 2500000, --2,5Ghz
	},
	{ --- *AN/FPS-117 

		Type_Level4 = 329,
		Type_Level3 = 101, 
		Type_Level2 = 16,
		Type_Level1 = 2, 
		Search = "-",
		Lock = "-", -- Beep every 0.2 second (this will never happen)
		Carrier_Frequency = 1300000, --1,3Ghz
	},
	{ --- *AN/FPS-117 (Dome)

		Type_Level4 = 327,
		Type_Level3 = 101, 
		Type_Level2 = 16,
		Type_Level1 = 2, 
		Search = "-",
		Lock = "-", -- Beep every 0.2 second (this will never happen)
		Carrier_Frequency = 1300000, --1,3Ghz
	},

	--SAM--	
	
	{ -- C-RAM
		Type_Level4 = 336,
		Type_Level3 = 105, 
		Type_Level2 = 16,
		Type_Level1 = 2, 
		Search = hprf,
		Lock = hprf, 
		Carrier_Frequency = 15000000, -- 15GHz
	},
	{ -- SON-9 "Fire Can"
		Type_Level4 = 335,
		Type_Level3 = 26, 
		Type_Level2 = 16,
		Type_Level1 = 2, 
		Search = "=------------------------",
		Lock = "=", 
		Launch = "-",
		Carrier_Frequency = 2850000, -- 3GHz
	},
	{ -- Mys M1 "Silkworm SR"
		Type_Level4 = 263,
		Type_Level3 = 101, 
		Type_Level2 = 16,
		Type_Level1 = 2, 
		Search = "6---------------------------------------------------------------------------------------------------",
		Lock = "-", -- Beep every 0.2 second
		Carrier_Frequency = 10000000, -- 10Hz
	},
	{ -- NASAMS - AN/MPQ-64F1 Sentinel
		Type_Level4 = 305,
		Type_Level3 = 101, 
		Type_Level2 = 16,
		Type_Level1 = 2, 
		Search = "@-------B-------@-------D-------B-------",
		Lock = "-", -- Beep every 0.2 second
		Carrier_Frequency = 10000000, -- 10GHz
	},
	{ -- Rapier LN
		Type_Level4 = 260,
		Type_Level3 = 27, 
		Type_Level2 = 16,
		Type_Level1 = 2, 
		Search = "]---------",
		Lock = "]---------", -- Beep every 0.2 second
		Carrier_Frequency = 3000000, -- 3GHz
	},
	{ --- *Rapier - Blindfire
		Type_Level4 = 262,
		Type_Level3 = 27, 
		Type_Level2 = 16,
		Type_Level1 = 2, 
		Search = "-",
		Lock = "-", -- Beep every 0.2 second
		Carrier_Frequency = 35000000, -- 35GHz
		Scan_Area = 5,
	},
	{ -- HQ-7 LN
		Type_Level4 = 277,
		Type_Level3 = 102, 
		Type_Level2 = 16,
		Type_Level1 = 2, 
		Search = "T--",
		Lock = hprf, -- Beep every 0.2 second
		Carrier_Frequency = 15000000, -- 15Ghz
		Scan_Area = 3,
	},
	{ -- HQ-7 SR
		Type_Level4 = 278,
		Type_Level3 = 101, 
		Type_Level2 = 16,
		Type_Level1 = 2, 
		Search = "@---------",
		Lock = "-", -- Beep every 0.2 second
		Carrier_Frequency = 3000000, -- 3Ghz
	},
	{ -- SA-8 OSA
		Type_Level4 = OSA_9A33BM3,
		Type_Level3 = 102, 
		Type_Level2 = wsType_GenericTank,
		Type_Level1 = wsType_Ground, 
		Search = "L-----------------",
		Lock = "L", -- Beep every 0.2 second
		Carrier_Frequency = 12000000, -- 7Ghz
		Scan_Area = 3,
	},
	{ --- *SA-13 Strela 10M3
		Type_Level4 = 26,
		Type_Level3 = 104, 
		Type_Level2 = 16,
		Type_Level1 = 2, 
		Search = "-",
		Lock = "-", 
		Carrier_Frequency = 30000000, -- 30Ghz
		Scan_Area = 60,
	},
	{ -- SA-3 TR - Low blow

		Type_Level4 = 73,
		Type_Level3 = 101, 
		Type_Level2 = 16,
		Type_Level1 = wsType_Ground, 
		Search = "B",   --Scan rate 16Hz = Scan rate > than indivitual RWR pulse length (0.1s). Therefore constant
		Lock = "T",     --Scan rate 25Hz = Scan rate > than indivitual RWR pulse length (0.1s). Therefore constant
		Carrier_Frequency = 9000000, -- 9Ghz
		Scan_Area = 3,
	},
	{ -- SA-2 TR - Fan Song E

		Type_Level4 = 256,
		Type_Level3 = 101, 
		Type_Level2 = 16,
		Type_Level1 = 2, 
		Search = "8",   --Scan rate 15,5 - 17Hz = Scan rate > than indivitual RWR pulse length (0.1s). Therefore constant
		Lock = "M",     --Scan rate 15,5 - 17Hz = Scan rate > than indivitual RWR pulse length (0.1s). Therefore constant
		Carrier_Frequency = 5000000, -- 5Ghz
		Scan_Area = 3,
	},
	{ -- SA-5 TR - Square Pair

		Type_Level4 = 313,
		Type_Level3 = 101, 
		Type_Level2 = 16,
		Type_Level1 = 2, 
		Search = cw,   
		Lock = cw,
		Launch = cw,		
		Carrier_Frequency = 7000000, -- 7Ghz
		Scan_Area = 1.4,
	},
	{ -- SA-6 STR
		Type_Level4 = KUB_1C91, -- STR
		Type_Level3 = wsRadarAir, 
		Type_Level2 = wsType_SAM,
		Type_Level1 = wsType_Ground, 
		Search = "D---------------------------------------", 
		Lock = "D", 
		Launch = cw,
		Carrier_Frequency = 8000000, -- 8Ghz
	},
	{ -- SA-15

		 Type_Level4 = 28,
		 Type_Level3 = 102, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = ">---------", 
		 Lock = ">", 
		 Carrier_Frequency = 10000000, -- 10Ghz
	},
	{ -- SA-19

		 Type_Level4 = Tunguska_,
		 Type_Level3 = 103, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = hprf,
		 Lock = hprf, 
		 Carrier_Frequency = 2000000, -- 2Ghz
	},
	{ -- ZSU-23-4

		 Type_Level4 = 30,
		 Type_Level3 = 105, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = "BB----------------------------", 
		 Lock = "T", 
		 Carrier_Frequency = 14600000, -- 14,6Ghz
		 Scan_Area = 5, -- Degrees
	},
	{ --- *HAWK SR - AN/MPQ-50

		 Type_Level4 = 39,
		 Type_Level3 = 101, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = "-", -- Beep one second then silence two seconds
		 Lock = "-", 
		 Carrier_Frequency = 500000, -- 500MHz
	},
	{ -- HAWK TR - AN/MPQ-46

		 Type_Level4 = 40,
		 Type_Level3 = 101, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = "8-----------------------------", -- Beep one second then silence two seconds
		 Lock = cw,
		 Launch = cw,
		 Carrier_Frequency = 10000000, --10GHz
		 Scan_Area = 3,
	},
	{ -- HAWK CWAR - AN/MPQ-55

		 Type_Level4 = 42,
		 Type_Level3 = 101, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = "<<<CCC<<<CCC------------------", -- Beep one second then silence two seconds
		 Lock = cw, 
		 Carrier_Frequency = 15000000, -- 15GHz
	},
	{ -- S-300 -search CW - 64N6E - Big Bird

		 Type_Level4 = 7,
		 Type_Level3 = 101, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = "2-----------------------------------------------------------------------------------------------------------------------",
		 Lock = "-", 
		 Carrier_Frequency = 2900000, --2,9GHZ
	},
	{ -- S-300 -FMCW search - V_40B6MD Clam Shell

		 Type_Level4 = 5,
		 Type_Level3 = 101, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = cw, 
		 Lock = cw, 
		 Carrier_Frequency = 9000000, -- 9Ghz
		 Scan_Area = 3,
	},
	{ -- S-300 -TR - 40B6E Flap Lid 

		 Type_Level4 = 4,
		 Type_Level3 = 101, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = "-", -- Beep one second then silence two seconds
		 Lock = "5", 
		 Carrier_Frequency = 9000000, -- 9Ghz
		 Scan_Area = 3,
	},
	{ -- SA-11 BUK - Snow Drift

		 Type_Level4 = 18,
		 Type_Level3 = 101, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = "8-----------------------------------------------------------------------------------------------------------------------",
		 Lock = cw, 
		 Carrier_Frequency = 2000000, -- 2GHz
	},
	{ -- SA-11 BUK - Fire Dome

		 Type_Level4 = 19,
		 Type_Level3 = 102, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = "?-------------------", 
		 Lock = "?",
		 Launch = cw,
		 Carrier_Frequency = 8000000, -- 8GHz
		 Scan_Area = 120,
	},
	{ -- SA-12 Gladiator - STR - 9S19M2

		 Type_Level4 = 12,
		 Type_Level3 = 101, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = "Z[------------------a`------------------", 
		 Lock = cw, 
		 Carrier_Frequency = 10000000, -- 10GHz
	},
	{ -- Patriot - STR - AN/MPQ-53

		 Type_Level4 = 34,
		 Type_Level3 = 101, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = "9------<------9------<------", 
		 Lock = cw, 
		 Carrier_Frequency = 5000000, -- 5GHz
	},
	{ -- Roland

		 Type_Level4 = 31,
		 Type_Level3 = 102, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = "b---------", -- Beep one second then silence two seconds
		 Lock = cw, 
		 Carrier_Frequency = 15000000, -- 15GHz
	},
	{ -- Roland EWR

		 Type_Level4 = 32,
		 Type_Level3 = 101, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = "b-----------------------------", -- Beep one second then silence two seconds
		 Lock = cw, 
		 Carrier_Frequency = 5000000, -- 5GHz
	},
	{ -- Gepard

		 Type_Level4 = 38,
		 Type_Level3 = 105, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = hprf, -- Beep one second then silence two seconds
		 Lock = hprf, 
		 Carrier_Frequency = 2500000, -- 2,5GHz
		 Scan_Area = 2,
	},
	{ -- Vulcan

		 Type_Level4 = 46,
		 Type_Level3 = 105, 
		 Type_Level2 = 16,
		 Type_Level1 = 2, 
		 Search = hprf,
		 Lock = hprf, 
		 Carrier_Frequency = 2500000, -- 2,5GHz
		 Scan_Area = 3,
	},
	
	--Ship--
	
	{ -- Tug
		Type_Level4 = 5, 
		Type_Level3 = 15, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "I-------------------------------------------------", 
		Lock = "-", 
		Carrier_Frequency = 2300000, -- 2,3Ghz
	},
	{ -- HMS Invincible
		Type_Level4 = 331, 
		Type_Level3 = 12, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "8-------------------------------------------------", 
		Lock = cw, 
		Launch = cw,
		Carrier_Frequency = 2300000, -- 2,3Ghz
	},
	{ -- Leander class
		Type_Level4 = 14, 
		Type_Level3 = 14, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "D-----------------------------------------------------------------------------------------", 
		Lock = "N", 
		Launch = "N",
		Carrier_Frequency = 9410000, -- 9,41Ghz
	},
	{ -- Moskva - "Top Plate"
		Type_Level4 = 3, 
		Type_Level3 = 13, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "8-----------------------------------------------------------", 
		Lock = "L",
		Launch = "L",
		Carrier_Frequency = 2300000, -- 2,3Ghz
	},
	{ -- Kuznetsov
		Type_Level4 = 1, 
		Type_Level3 = 12, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "6-----------------------------------------------------------", 
		Lock = ">",
		Launch = ">",		
		Carrier_Frequency = 10000000, -- 10Ghz
	},
	{ -- PIOTR
		Type_Level4 = 19, 
		Type_Level3 = 14, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "6-------------------------------------------------4-------------------------------------------------", 
		Lock = "5--", 
		Launch = "5",
		Carrier_Frequency = 10000000, -- 10Ghz
	},
	{ -- Grisha V (1124.4)
		Type_Level4 = 11, 
		Type_Level3 = 14, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "6-----------------------------", 
		Lock = "L-", 
		Launch = "L",
		Carrier_Frequency = 3000000, -- 3Ghz
	},
	{ -- Rezky
		Type_Level4 = 14, 
		Type_Level3 = 14, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = ":-----------------------------", 
		Lock = "L", 
		Launch = "L",
		Carrier_Frequency = 75000000, -- 10hz
	},
	{ -- Molniya
		Type_Level4 = 15, 
		Type_Level3 = 14, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "6-----------------------------", 
		Lock = "L", 
		Launch = "L",
		Carrier_Frequency = 10000000, -- 10hz
	},
	{ -- Neustrashimyy
		Type_Level4 = 28, 
		Type_Level3 = 14, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "5-----------------------", 
		Lock = ">-", 
		Launch = ">",
		Carrier_Frequency = 5000000, -- 500Mhz
	},
	{ -- Hazzard Perry
		Type_Level4 = 17, 
		Type_Level3 = 14, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "3-----------------------------", 
		Lock = "E", 
		Launch = "E",
		Carrier_Frequency = 9420000, -- 9.42Ghz
	},
	{ -- Carl Vinson
		Type_Level4 = 2, 
		Type_Level3 = 12, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "4---------------------------------------", 
		Lock = "E-", 
		Launch = cw,
		Carrier_Frequency = 10000000, -- 10Ghz
	},
	{ -- John C. Stennis NEW?
		Type_Level4 = 264, 
		Type_Level3 = 12, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "4---------------------------------------", 
		Lock = "E-", 
		Launch = cw, 
		Carrier_Frequency = 10000000, -- 10Ghz
	},
	{ -- John C. Stennis
		Type_Level4 = 2, 
		Type_Level3 = 12, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "4---------------------------------------", 
		Lock = "E-", 
		Launch = cw, 
		Carrier_Frequency = 10000000, -- 10Ghz
	},
	{ -- Forrestal
		Type_Level4 = 315, 
		Type_Level3 = 12, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "3-----------------------------------------------------------", 
		Lock = "E-", 
		Launch = cw, 
		Carrier_Frequency = 10000000, -- 10Ghz
	},
	{ -- TICONDEROGA
		Type_Level4 = 21, 
		Type_Level3 = 14, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "=-------------------", 
		Lock = "@-",
		Launch = cw,		
		Carrier_Frequency = 3000000, -- 300Mhz
	},
	{ -- Tarawa
		Type_Level4 = 269, 
		Type_Level3 = 12, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "3-------------------------------------------------------------------------------", 
		Lock = "L-", 
		Launch = cw,
		Carrier_Frequency = 8500000, -- 850Mhz
	},	
	{ -- Type 052B
		Type_Level4 = 270, 
		Type_Level3 = 13, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "5-------------------------------------------------", 
		Lock = cw, 
		Launch = cw,
		Carrier_Frequency = 23000000, -- 2,3Ghz
	},	
	{ -- Type 052C
		Type_Level4 = 272, 
		Type_Level3 = 13, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "D-------------------",	
		Lock = "J-", 
		Launch = cw,
		Carrier_Frequency = 4000000, -- 4Ghz
	},	
	{ -- Type 054A
		Type_Level4 = 271, 
		Type_Level3 = 13, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "5-----------------------------",	
		Lock = cw,
		Launch = cw,
		Carrier_Frequency = 4000000, -- 4Ghz
	},	
	{ -- Type 071
		Type_Level4 = 274, 
		Type_Level3 = 12, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "9-------------------",	
		Lock = "L", 
		Launch = "L",
		Carrier_Frequency = 3000000, -- 3Ghz
	},
	{ -- La_Combattante_II --
		Type_Level4 = 304, 
		Type_Level3 = 14, 
		Type_Level2 = 12, 
		Type_Level1 = 3, 
		Search = "b--------------",	
		Lock = "T-", 
		Launch = "T",
		Carrier_Frequency = 450000, -- 450Mhz
	},
	
	--Aircraft--
	
	{ -- Mirage F1 BD
		Type_Level4 = 321,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock,
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 B
		Type_Level4 = 322,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock,
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 BE
		Type_Level4 = 319,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 BQ
		Type_Level4 = 320,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 C
		Type_Level4 = 306,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 C-200
		Type_Level4 = 305,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 CE
		Type_Level4 = 301,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 CG
		Type_Level4 = 310,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 CH
		Type_Level4 = 308,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 CJ
		Type_Level4 = 312,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 CK
		Type_Level4 = 313,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 CR
		Type_Level4 = 317,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 CT
		Type_Level4 = 318,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "99----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 CZ
		Type_Level4 = 318,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 DDA
		Type_Level4 = 323,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 ED
		Type_Level4 = 315,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 EDA
		Type_Level4 = 316,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 EE
		Type_Level4 = 302,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 EH
		Type_Level4 = 307,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 EQ
		Type_Level4 = 314,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "99----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 JA
		Type_Level4 = 309,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "77----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 M-CE
		Type_Level4 = 304,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "99----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage F1 M-EE
		Type_Level4 = 303,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "99----------------------------------------------", -- 4,8sec scan
		Lock = f1_lock, 
		Launch = f1_launch,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mirage 2000-5
		Type_Level4 = 34,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "P-----------S-----------", -- 
		Lock = hprf, 
		Launch = cw,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- Mig-25PD
		Type_Level4 = 24,
		Type_Level3 = 3, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "<----------------", 
		Lock = "A", 
		Launch = cw,		
		Carrier_Frequency = 9383000, --X-band 9,383Ghz
		Scan_Area = 65, -- Degrees
	},
	{ -- Mig-23MLD
		Type_Level4 = 1,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = ":----------------", 
		Lock = ":",
		Launch = cw,
		Carrier_Frequency = 9383000, --X-band 9,383Ghz
		Scan_Area = 112, -- Degrees
	},
	{ -- Mig-19P
		Type_Level4 = 287,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "D--D---------------------", 
		Lock = "D",
		Launch = "D",		
		Carrier_Frequency = 9383000, --X-band 9,383Ghz
		Scan_Area = 60, -- Degrees
	},
	{ -- Mig-21Bis
		Type_Level4 = 288,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "9-9---------------------------", 
		Lock = "B", 
		Launch = cw, 
		Carrier_Frequency = 9420000, --Khz X-band 9,42Ghz
		Scan_Area = 60, -- Degrees
	},
	{ -- JF-17
		Type_Level4 = 271,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "=---------------------------------------", -- 
		Lock = hprf,
		Launch = cw,		-- 
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- F/A-18C Lot 20
		Type_Level4 = 280,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "7------7--------------------<------<--------------------", -- 
		Lock = "E",
		Launch = cw,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- F-86F --
		Type_Level4 = 277,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "6-", -- Beep half second then silence two and a half second
		Lock = "6", 
		Carrier_Frequency = 9335000, -- 9,335Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- F-16CM_50
		Type_Level4 = 275,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "::DD::DD-----------::DD::DD-----------", -- Beep half second then silence two and a half second
		Lock = "D",
		Launch = cw,
		Carrier_Frequency = 9905000, -- 9,905Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- F-14B
		Type_Level4 = 278,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "8---------8-----------------------------", -- Beep half second then silence two and a half second
		Lock = "<",
		Launch = cw,
		Carrier_Frequency = 20000000, -- 20Ghz
		Scan_Area = 130, -- Degrees
	},
	{ -- F-14A-135
		Type_Level4 = 279,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "8---------8-----------------------------", -- Beep half second then silence two and a half second
		Lock = "<", 
		Launch = cw,
		Carrier_Frequency = 20000000, -- 20Ghz
		Scan_Area = 130, -- Degrees
	},
	{ -- F-5E-3
		Type_Level4 = 276,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "I-----------", -- Beep half second then silence two and a half second
		Lock = "I", 
		Carrier_Frequency = 20000000, -- 20Ghz
		Scan_Area = 90, -- Degrees
	},
	{ -- AJS37
		Type_Level4 = 265,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "5----------", -- Beep half second then silence two and a half second
		Lock = "C",
		Launch = "C",
		Carrier_Frequency = 8600000, -- 8,6Ghz
		Scan_Area = 123, -- Degrees
	},
	{ -- MiG-29S
		Type_Level4 = 50,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "T------------------------P------------------------", -- Beep half second then silence two and a half second
		Lock = "<", 
		Launch = cw,
		Carrier_Frequency = 10000000, -- 10Ghz
		Scan_Area = 130, -- Degrees
	},
	{ -- MiG-29G
		Type_Level4 = 49,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "T------------------------P------------------------", -- Beep half second then silence two and a half second
		Lock = "<",
		Launch = cw,		
		Carrier_Frequency = 9000000, -- 9Ghz
		Scan_Area = 130, -- Degrees
	},
	{ -- MiG-29A
		Type_Level4 = 2,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "T------------------------P------------------------", 
		Lock = "<",
		Launch = cw,		
		Carrier_Frequency = 9000000, -- 9Ghz
		Scan_Area = 130, -- Degrees
	},
	{ -- MiG-31
		Type_Level4 = 9,
		Type_Level3 = wsType_Intercepter, --3
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = ">@------@-------", 
		Lock = "A",
		Launch = cw,		
		Carrier_Frequency = 8000000, -- 8Ghz (Band 2)
		Scan_Area = 140, -- Degrees
	},
	{ -- Su-30 
		Type_Level4 = 13,
		Type_Level3 = 1, 
		Type_Level2 = 1, 
		Type_Level1 = 1, 
		Search = ">------><------<", 
		Lock = "<",
		Launch = cw,		
		Carrier_Frequency = 8000000, -- 8Ghz (Band 2)
		Scan_Area = 120, -- Degrees
	},
	{ -- J-11A
		Type_Level4 = 66,
		Type_Level3 = 1, --3
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "T------------------------P------------------------", -- Beep half second then silence two and a half second
		Lock = "<", 
		Launch = cw,
		Carrier_Frequency = 10000000, -- 10Ghz (Band 2)
		Scan_Area = 120, -- Degrees
	},
	{ -- Su-27
		Type_Level4 = 3,
		Type_Level3 = 1, 
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "T------------------------P------------------------", -- Beep half second then silence two and a half second
		Lock = "<", 
		Launch = cw,
		Carrier_Frequency = 10000000, -- 10Ghz (Band 2)
		Scan_Area = 120, -- Degrees
	},
	{ -- Su-33
		Type_Level4 = 4,
		Type_Level3 = 1, 
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "T------------------------P------------------------", -- Beep half second then silence two and a half second
		Lock = "<", 
		Launch = cw,
		Carrier_Frequency = 10000000, -- 10Ghz (Band 2)
		Scan_Area = 120, -- Degrees
	},
	{ -- F-14 
		Type_Level4 = 5,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "8---------8-----------------------------",
		Lock = "<", 
		Launch = cw,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz (Band 2)
		Scan_Area = 130, -- Degrees
	},
	{ -- F-15C
		Type_Level4 = 6,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "9---------9-----------------------------=---------=-----------------------------", --Interleaved
		Lock = ">", 
		Launch = cw,
		Carrier_Frequency = 9000000, 
		Scan_Area = 120, 
	},
	{ -- F-16A
		Type_Level4 = 52,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "7------7--------------------", 
		Lock = "D",
		Launch = cw,		
		Carrier_Frequency = 9000000, --Khz X-band 9Ghz (Band 2)
		Scan_Area = 120, -- Degrees
	},
	{ -- F-16
		Type_Level4 = 7,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "8------8--------------------<------<--------------------", -- 
		Lock = "D", 
		Launch = cw,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- F/A-18A
		Type_Level4 = 14,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "9-----------9-----------------------------------", -- 
		Lock = "E",  
		Launch = cw,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- F/A-18C /= Lot 20
		Type_Level4 = 53,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "7------7--------------------<------<--------------------", -- 
		Lock = "E", 
		Launch = cw,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- F-4E
		Type_Level4 = 45,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "3-----------3------------------------", -- 
		Lock = ":", 
		Launch = cw,
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	{ -- F-5E
		Type_Level4 = 46,
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "I---------", -- 
		Lock = "I", 
		Carrier_Frequency = 11000000, -- 11Ghz
		Scan_Area = 80, -- Degrees
	},
	{ -- Mirage 2000C
		Type_Level4 = 284,
		Type_Level3 = 1, --Interceptor
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "P-----------S-----------", -- 
		Lock = hprf, 
		Launch = cw,		
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 120, -- Degrees
	},
	
	--AWACS--
	
	{ -- E-2C
		Type_Level4 = E_2C,
		Type_Level3 = wsType_Cruiser, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "33--------------------------------------------------------------------------------------------------", -- Beep half second then silence six and a half second
		Lock =   "-", -- Beep every 0.6 second, mid/high prf interleved mode
		Carrier_Frequency = 3000000,
		Scan_Area = 360, -- Degrees
	},
	{ -- E-3 Sentry   
		Type_Level4 = E_3,
		Type_Level3 = wsType_Cruiser, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "333-------------------------------------------------------------------------------------------------", -- Beep one second then silence six and a half second
		Lock = "-", -- Beep every 0.6 second, mid/high prf interleved mode
		Carrier_Frequency = 3000000, --Khz L-Band 3Ghz (Band 1)
		Scan_Area = 360, -- Degrees
	},
	{ -- *А-50 Mainstay  
		Type_Level4 = A_50,
		Type_Level3 = wsType_Cruiser, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "-",
		Lock = "-",
		Carrier_Frequency = 1500000, -- 1.5Ghz
		Scan_Area = 360, -- Degrees
	},
	{ -- *KJ-2000  
		Type_Level4 = 272,
		Type_Level3 = 5, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "-",
		Lock = "-",
		Carrier_Frequency = 1200000, -- 1.2Ghz
		Scan_Area = 360, -- Degrees
	},
	
	--Helicopters--
	
	{ -- *Apache D FF
		Type_Level4 = 300,
		Type_Level3 = 6, --Interceptor
		Type_Level2 = 2, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "-", -- 
		Lock = "-", 
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 360, -- Degrees
	},
	{ -- *Apache D old
		Type_Level4 = 158,
		Type_Level3 = 6, --Interceptor
		Type_Level2 = 2, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = "-", -- 
		Lock = "-", 
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz
		Scan_Area = 360, -- Degrees
	},
	
	--Missiles--
	
	{ -- AIM-54C 60  
		Type_Level4 = 408,
		Type_Level3 = 7, 
		Type_Level2 = 4, 
		Type_Level1 = 4, 
		Search = "-",
		Lock = cw,
		Carrier_Frequency = 10000000, -- 10Ghz
		Scan_Area = 30, -- 30? Degrees
	},
	{ -- AIM-54C 47  
		Type_Level4 = 322,
		Type_Level3 = 7, 
		Type_Level2 = 4, 
		Type_Level1 = 4, 
		Search = "-",
		Lock = cw,
		Carrier_Frequency = 10000000, -- 1.5Ghz
		Scan_Area = 30, -- 30? Degrees
	},
	{ -- AIM-54A 47  
		Type_Level4 = 320,
		Type_Level3 = 7, 
		Type_Level2 = 4, 
		Type_Level1 = 4, 
		Search = "-",
		Lock = cw,
		Carrier_Frequency = 10000000, -- 1.5Ghz
		Scan_Area = 30, -- 30? Degrees
	},
	{ -- AIM-54A 60  
		Type_Level4 = 321,
		Type_Level3 = 7, 
		Type_Level2 = 4, 
		Type_Level1 = 4, 
		Search = "-",
		Lock = cw,
		Carrier_Frequency = 10000000, -- 1.5Ghz
		Scan_Area = 30, -- 30? Degrees
	},
	{ -- SD-10  
		Type_Level4 = 307,
		Type_Level3 = 7, 
		Type_Level2 = 4, 
		Type_Level1 = 4, 
		Search = "-",
		Lock = cw,
		Carrier_Frequency = 1500000, -- 1.5Ghz
		Scan_Area = 30, -- 30? Degrees
	},
	{ -- AIM-120C  
		Type_Level4 = 106,
		Type_Level3 = 7, 
		Type_Level2 = 4, 
		Type_Level1 = 4, 
		Search = "-",
		Lock = cw,
		Carrier_Frequency = 1500000, -- 1.5Ghz
		Scan_Area = 30, -- 30? Degrees
	},
	{ -- AIM-120? 
		Type_Level4 = 24,
		Type_Level3 = 7, 
		Type_Level2 = 4, 
		Type_Level1 = 4, 
		Search = "-",
		Lock = cw,
		Carrier_Frequency = 1500000, -- 1.5Ghz
		Scan_Area = 30, -- 30? Degrees
	},
	{ -- AIM-54  
		Type_Level4 = 23,
		Type_Level3 = 7, 
		Type_Level2 = 4, 
		Type_Level1 = 4, 
		Search = "-",
		Lock = cw,
		Carrier_Frequency = 1500000, -- 1.5Ghz
		Scan_Area = 30, -- 30? Degrees
	},
	{ -- R-77  
		Type_Level4 = 19,
		Type_Level3 = 7, 
		Type_Level2 = 4, 
		Type_Level1 = 4, 
		Search = "-",
		Lock = cw,
		Carrier_Frequency = 1500000, -- 1.5Ghz
		Scan_Area = 30, -- 30? Degrees
	},
	
	--General type--
	{ -- General category: Interceptors
		Type_Level4 = 0,
		Type_Level3 = wsType_Intercepter, --3
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = ">>------------------", -- Beep half second then silence one and a half second
		Lock = "MMMM------", -- Beep every 0.8 second
		Carrier_Frequency = 10000000, --Khz X-band 10Ghz (Band 2)
		Scan_Area = 60, -- Degrees
	},
	{ -- General category: fighters
		Type_Level4 = 0, --0 = Any type 
		Type_Level3 = 1, --wsType_Fighter
		Type_Level2 = 1, --wsType_Airplane
		Type_Level1 = 1, --wsType_Air
		Search = ":----------------", -- Beep half second then silence two and a half second
		Lock = "ff-----RR-----", -- Beep every 0.6 second, mid/high prf interleved mode
		Carrier_Frequency = 10000000, --Khz 10Ghz (Band 2)
		Scan_Area = 120, -- Degrees
	},
	{ -- General category: ships
		 Type_Level4 = 0, --0 = Any type 
		 Type_Level3 = 0, --0 = Any type 
		 Type_Level2 = 12, --wsType_Ship
		 Type_Level1 = 3, --wsType_Navy
		 Search = "2---------", -- Short beep every second
		 Lock = "3---", -- Beep every 0.1 second
		 Carrier_Frequency = 10000000, --Khz 10Ghz (Band 2)
	},	
	{  --General category: missiles
		Type_Level4 = 0, --0 = Any type 
		Type_Level3 = 0, --0 = Any type 
		Type_Level2 = 12, --wsType_Ship
		Type_Level1 = wsType_Weapon,
		Search = "2---------", -- Short beep every second
		Lock = cw,
		Carrier_Frequency = 10000000, --Khz 10Ghz (Band 2)
		Scan_Area = 24, -- Degrees (this is a wild guess after 0.5 seoncds of Googling)
	},
	{ -- Everything else
		 Type_Level4 = 0, --0 = Any type 
		 Type_Level3 = 0, 
		 Type_Level2 = 0, 
		 Type_Level1 = 0, 
		 Search = "444-----------------", -- Beep one second then silence one second
		 Lock = "2---", -- Beep every 0.2 second
		 Carrier_Frequency = 10000000, --Khz 10Ghz (Band 2)
	},
}


local gettext = require("i_18n")
_ = gettext.translate

need_to_be_closed = true