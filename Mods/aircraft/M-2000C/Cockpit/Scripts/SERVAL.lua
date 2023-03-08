-- You can now add your own RWR customization in Saved Games instead of altering this file:close
-- Just copy this file to Saved Games\DCS(.openbeta)\Config\M-2000C\SERVAL.lua
-- Remove all the lines you don't want to change
-- Update the displayed character on existing contact types
-- And add lines for newer unit types
-- Unknown unit types are logged into dcs.log

local CIR = ';'		-- Hollow circle
local DOT = '.'		-- Big solid dot
local ARW = '='		-- Vertical arrow
local IVT = '?'		-- Inverted T
local SQP = '>'		-- Square pulse : _|-|_
local BR3 = '<'		-- Three vertical bars above horizontal bar  _|_|_|_
local IDS = '@'		-- Kind of inverted double square pulse |_|-|_|

rwr_codes = {}
rwr_codes["F-4E"				] = { symb='4', 	coal = 1,	cm='1',		leth_rng=15, desc = "F-4E" }
rwr_codes["F-5E"				] = { symb='F', 	coal = 1,	cm='4',		leth_rng=05, desc = "F-5E" }
rwr_codes["F-5E-3"				] = { symb='F', 	coal = 1,	cm='4',		leth_rng=05, desc = "F-5E" }
rwr_codes["F-14A"				] = { symb='T', 	coal = 1,	cm='2',		leth_rng=50, desc = "F-14" }
rwr_codes["F-14B"				] = { symb='T', 	coal = 1,	cm='2',		leth_rng=50, desc = "F-14" }
rwr_codes["F-14A-135-GR"		] = { symb='T', 	coal = 1,	cm='2',		leth_rng=50, desc = "F-14" }
rwr_codes["F-15C"				] = { symb='+', 	coal = 1,	cm='3',		leth_rng=30, desc = "F-15" }
rwr_codes["F-15E"				] = { symb='+', 	coal = 1,	cm='3',		leth_rng=30, desc = "F-15" }
rwr_codes["F-16A"				] = { symb='*', 	coal = 1,	cm='4',		leth_rng=30, desc = "F-16" }
rwr_codes["F-16C_50"			] = { symb='*', 	coal = 1,	cm='3',		leth_rng=30, desc = "F-16" }
rwr_codes["F-16C bl.50"			] = { symb='*', 	coal = 1,	cm='3',		leth_rng=30, desc = "F-16" }
rwr_codes["F-16C bl.52d"		] = { symb='*', 	coal = 1,	cm='3',		leth_rng=30, desc = "F-16" }
rwr_codes["F-16A MLU"			] = { symb='*', 	coal = 1,	cm='2',		leth_rng=30, desc = "F-16" }
rwr_codes["F/A-18A"				] = { symb=DOT, 	coal = 1,	cm='1',		leth_rng=20, desc = "F/A-18A" }
rwr_codes["F/A-18C"				] = { symb='-', 	coal = 1,	cm='3',		leth_rng=30, desc = "F/A-18C" }
rwr_codes["FA-18C_hornet"		] = { symb='-', 	coal = 1,	cm='3',		leth_rng=30, desc = "F/A-18C" }
rwr_codes["Tornado GR4"			] = { symb='F', 	coal = 1,	cm='4',		leth_rng=05, desc = "TORNADO" }
rwr_codes["Tornado IDS"			] = { symb='F', 	coal = 1,	cm='4',		leth_rng=05, desc = "TORNADO" }
rwr_codes["M-2000C"				] = { symb='I', 	coal = 1,	cm='2',		leth_rng=20, desc = "M2000-C" }
rwr_codes["Mirage 2000-5"		] = { symb='Y', 	coal = 1,	cm='3',		leth_rng=30, desc = "M2000-5" }
rwr_codes["AV8BNA"				] = { symb=DOT, 	coal = 1,	cm='4',		leth_rng=30, desc = "AV-8B+" }
rwr_codes["AJS37"				] = { symb='F', 	coal = 1,	cm='4',		leth_rng=05, desc = "AJS-37" }
rwr_codes["B-1B"				] = { symb='E', 	coal = 1,	cm='0',		leth_rng=00, desc = "B-1B" }
rwr_codes["B-52H"				] = { symb='E', 	coal = 1,	cm='0',		leth_rng=00, desc = "B-52" }
rwr_codes["E-3A"				] = { symb=CIR, 	coal = 1,	cm='0',		leth_rng=00, desc = "AWACS" }
rwr_codes["S-3B"				] = { symb='E', 	coal = 1,	cm='0',		leth_rng=00, desc = "S-3" }
rwr_codes["S-3B Tanker"			] = { symb='E', 	coal = 1,	cm='0',		leth_rng=00, desc = "S-3" }
rwr_codes["E-2C"				] = { symb=CIR, 	coal = 1,	cm='0',		leth_rng=00, desc = "AWACS" }

rwr_codes["J-11A"				] = { symb='S', 	coal = 2,	cm='3',		leth_rng=30, desc = "J-11A" }
rwr_codes["JF-17"				] = { symb='Q', 	coal = 2,	cm='3',		leth_rng=30, desc = "JF-17" }
rwr_codes["MiG-21Bis"			] = { symb=ARW, 	coal = 2,	cm='1',		leth_rng=10, desc = "MIG-21" }
rwr_codes["MiG-23MLD"			] = { symb=SQP, 	coal = 2,	cm='1',		leth_rng=15, desc = "MIG-23" }
rwr_codes["MiG-25PD"			] = { symb=IVT, 	coal = 2,	cm='2',		leth_rng=20, desc = "MIG-25" }
rwr_codes["MiG-25RBT"			] = { symb=IVT, 	coal = 2,	cm='2',		leth_rng=20, desc = "MIG-25" }
rwr_codes["MiG-29A"				] = { symb='M', 	coal = 2,	cm='2',		leth_rng=25, desc = "MIG-29" }
rwr_codes["MiG-29S"				] = { symb='M', 	coal = 2,	cm='2',		leth_rng=30, desc = "MIG-29" }
rwr_codes["MiG-29G"				] = { symb='M', 	coal = 2,	cm='2',		leth_rng=25, desc = "MIG-29" }
rwr_codes["MiG-31"				] = { symb=IDS, 	coal = 2,	cm='3',		leth_rng=30, desc = "MIG-31" }
rwr_codes["MiG-27K"				] = { symb=SQP, 	coal = 2,	cm='4',		leth_rng=05, desc = "MIG-27" }
rwr_codes["Su-17M4"				] = { symb='X', 	coal = 2,	cm='4',		leth_rng=05, desc = "SU-17" }
rwr_codes["Su-24M"				] = { symb='X', 	coal = 2,	cm='4',		leth_rng=05, desc = "SU-24" }
rwr_codes["Su-24MR"				] = { symb='X', 	coal = 2,	cm='4',		leth_rng=05, desc = "SU-24" }
rwr_codes["Su-27"				] = { symb='S', 	coal = 2,	cm='2',		leth_rng=25, desc = "SU-27" }
rwr_codes["Su-30"				] = { symb=BR3, 	coal = 2,	cm='3',		leth_rng=30, desc = "SU-30" }
rwr_codes["Su-33"				] = { symb='S', 	coal = 2,	cm='3',		leth_rng=25, desc = "SU-33" }
rwr_codes["Su-34"				] = { symb=BR3, 	coal = 2,	cm='3',		leth_rng=30, desc = "SU-34" }
rwr_codes["Tu-22M3"				] = { symb='B', 	coal = 2,	cm='0',		leth_rng=00, desc = "TU-22" }
rwr_codes["Tu-95MS"				] = { symb='B', 	coal = 2,	cm='0',		leth_rng=00, desc = "TU-95" }
rwr_codes["Tu-142"				] = { symb='B', 	coal = 2,	cm='0',		leth_rng=00, desc = "TU-142" }
rwr_codes["Tu-160"				] = { symb='B', 	coal = 2,	cm='0',		leth_rng=00, desc = "TU-160" }
rwr_codes["KJ-2000"				] = { symb=CIR, 	coal = 2,	cm='0',		leth_rng=00, desc = "AWACS" }
rwr_codes["A-50"				] = { symb=CIR, 	coal = 2,	cm='0',		leth_rng=00, desc = "AWACS" }

rwr_codes["Hawk sr"				] = { symb='H', 	coal = 1,	cm='6',		leth_rng=20, desc="HAWK" }
rwr_codes["Hawk tr"				] = { symb='H', 	coal = 1,	cm='6',		leth_rng=20, desc="HAWK" }
rwr_codes["Hawk ln"				] = { symb='H', 	coal = 1,	cm='6',		leth_rng=20, desc="HAWK" }
rwr_codes["Hawk cwar"			] = { symb='H', 	coal = 1,	cm='6',		leth_rng=20, desc="HAWK" }
rwr_codes["Patriot str"			] = { symb='P', 	coal = 1,	cm='7',		leth_rng=45, desc="PATRIOT" }
rwr_codes["Roland Radar"		] = { symb='R', 	coal = 1,	cm='6',		leth_rng=30, desc="ROLAND" }
rwr_codes["Gepard"				] = { symb='G', 	coal = 1,	cm='6',		leth_rng=05, desc="GUEPARD" }
rwr_codes["Vulcan"				] = { symb='V', 	coal = 1,	cm='6',		leth_rng=05, desc="VULCAN" }
rwr_codes["Patriot ECS"			] = { symb='P', 	coal = 1,	cm='7',		leth_rng=45, desc="PATRIOT" }
rwr_codes["Patriot ln"			] = { symb='P', 	coal = 1,	cm='7',		leth_rng=45, desc="PATRIOT" }
rwr_codes["Roland ADS"			] = { symb='R', 	coal = 1,	cm='6',		leth_rng=10, desc="ROLAND" }
rwr_codes["2S6 Tunguska"		] = { symb='9', 	coal = 2,	cm='6',		leth_rng=05, desc="SA-19 GRISON" }
rwr_codes["ZSU-23-4 Shilka"		] = { symb='Z', 	coal = 2,	cm='6',		leth_rng=05, desc="ZSU-23 SHLIKA" }
rwr_codes["NASAMS_Radar_MPQ64F1"] = { symb='H', 	coal = 1,	cm='7',		leth_rng=10, desc="HAWK" }

rwr_codes["S-300PS 5P85C ln"	] = { symb='0',		coal = 2,	cm='7',		leth_rng=50, desc="SA-10 / SA-12" }
rwr_codes["S-300PS 5P85D ln"	] = { symb='0',		coal = 2,	cm='7',		leth_rng=50, desc="SA-10 / SA-12" }
rwr_codes["S-300PS 40B6MD sr"	] = { symb='0',		coal = 2,	cm='7',		leth_rng=30, desc="SA-10 / SA-12" }
rwr_codes["S-300PS 64H6E sr"	] = { symb='0',		coal = 2,	cm='7',		leth_rng=50, desc="SA-10 / SA-12" }
rwr_codes["S-300PS 40B6M tr"	] = { symb='0',		coal = 2,	cm='7',		leth_rng=50, desc="SA-10 / SA-12" }
rwr_codes["SA-11 Buk SR 9S18M1"	] = { symb='1',		coal = 2,	cm='7',		leth_rng=20, desc="SA-11 GADFLY" }
rwr_codes["SA-11 Buk LN 9A310M1"] = { symb='1',		coal = 2,	cm='7',		leth_rng=20, desc="SA-11 GADFLY" }
rwr_codes["SNR_75V"				] = { symb='2',		coal = 2,	cm='6',		leth_rng=20, desc="SA-2 GUIDELINE" }
rwr_codes["snr s-125 tr"		] = { symb='3',		coal = 2,	cm='6',		leth_rng=15, desc="SA-3 GOA LOW BLOW" }
rwr_codes["RPC_5N62V"			] = { symb='5',		coal = 2,	cm='6',		leth_rng=50, desc="SA-5 GAMMON" }
rwr_codes["Kub 2P25 ln"			] = { symb='6',		coal = 2,	cm='6',		leth_rng=15, desc="SA-6 GAINFUL" }
rwr_codes["Kub 1S91 str"		] = { symb='6',		coal = 2,	cm='6',		leth_rng=15, desc="SA-6 GAINFUL" }
rwr_codes["Osa 9A33 ln"			] = { symb='8',		coal = 2,	cm='6',		leth_rng=10, desc="SA-8 GECKO" }
rwr_codes["SA-8 Osa LD 9T217"	] = { symb='8',		coal = 2,	cm='6',		leth_rng=10, desc="SA-8 GECKO" }
rwr_codes["Tor 9A331"			] = { symb='8',		coal = 2,	cm='7',		leth_rng=10, desc="SA-15 GAUNTLET" }
rwr_codes["RLS_19J6"			] = { symb='C',		coal = 2,	cm='0',		leth_rng=00, desc="EWR" }
rwr_codes["1L13 EWR"			] = { symb='C',		coal = 2,	cm='0',		leth_rng=00, desc="EWR" }
rwr_codes["55G6 EWR"			] = { symb='C',		coal = 2,	cm='0',		leth_rng=00, desc="EWR" }
rwr_codes["Dog Ear radar"		] = { symb='D',		coal = 2,	cm='8',		leth_rng=05, desc="SA-13 IR GUIDED" }
rwr_codes["Strela-1 9P31"		] = { symb='D', 	coal = 2,	cm='8',		leth_rng=05, desc="SA-13 IR GUIDED" }
rwr_codes["Strela-10M3"			] = { symb='D', 	coal = 2,	cm='8',		leth_rng=05, desc="SA-13 IR GUIDED" }
rwr_codes["p-19 s-125 sr"		] = { symb='K', 	coal = 2,	cm='6',		leth_rng=20, desc="SR SA-2/SA-3" }
rwr_codes["HQ-7_STR_SP"			] = { symb='7',		coal = 2,	cm='6',		leth_rng=10, desc="HQ-7" }
rwr_codes["HQ-7_LN_SP"			] = { symb='7',		coal = 2,	cm='6',		leth_rng=10, desc="HQ-7" }
