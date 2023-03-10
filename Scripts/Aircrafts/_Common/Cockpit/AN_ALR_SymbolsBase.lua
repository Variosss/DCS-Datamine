dofile('Scripts/Aircrafts/_Common/Cockpit/wsTypes_SAM.lua')
dofile('Scripts/Aircrafts/_Common/Cockpit/wsTypes_Airplane.lua')
dofile('Scripts/Aircrafts/_Common/Cockpit/wsTypes_Ship.lua')
dofile('Scripts/Aircrafts/_Common/Cockpit/wsTypes_Missile.lua')

DefaultType          = 100
DEFAULT_TYPE_ = {DefaultType, DefaultType, DefaultType, DefaultType}

symbols = 
{
    {MiG_23_,       "23"},
    {MiG_29_,       "29"},
    {MIG_29K_,      "29"},
    {MiG_29G_,      "29"},
    {MiG_29C_,      "29"},
    {Su_27_,        "29"},
    {Su_33_,        "29"},
    {F_14_,         "14"},
    {F_15_,         "15"},
	{F_15E_,        "15"},
    {F_16_,         "16"},
    {F_16A_,        "16"},
    {F_2_,          "F2"},
    {Su_30_,        "30"},
    {FA_18_,        "18"},
    {FA_18C_,       "18"},
    {Su_34_,        "34"},
    {Mirage_,       "M2"},
    {F_4E_,         "F4"},
    {F_5E_,         "F5"},
    {Su_24_,        "24"},
    {Su_24MR_,      "24"},
    {AV_8B_,        "AV"},
    {EA_6B_,        "E6"},
    {F_111_,        "11"},
    {Tu_160_,       "BJ"},
    {B_1_,          "B1"},
    {Tu_22M3_,      "22"},
    {MiG_25P_,      "25"},
    {MiG_31_,       "31"},
    {Tu_95_,        "95"},
    {Tu_142_,       "Tu"},
    {B_52_,         "52"},
    {A_50_,         "50"},
    {E_3_,          "E3"},
    {S_3A_,         "S3"},
    {S_3R_,         "S3"},
    {E_2C_,         "E2"},
    {C_17_,         "17"},
    {C_130_,        "13"},
    {IL_76_,        "76"},
    {AN_26B_,       "AN"},
    {AN_30M_,       "AN"},
    {KC_10_,        "KC"},
    {KC_135_,       "KC"},
    {IL_78_,        "78"},
    {Su_39_,        "39"},
    {EWR_1L13_,             "S"},
    {EWR_55G6_,             "S"},
    {S300PS_SR_5N66M,       "CS"},
    {S300PS_SR_64H6E,       "BB"},
    {RLO_9C15MT_,           "BD"},
    {RLO_9C19M2_,           "HS"},
    {Buk_SR_9S18M1,         "SD"},
    {Kub_STR_9S91,          "6"},
    {Dog_Ear,               "DE"},
    {Roland_rdr,            "RO"},
    {Patriot_STR_ANMPQ_53,  "P"},
    {Hawk_SR_ANMPQ_50,      "HK"},
    {S300PS_TR_30N6,        "10"},
    {RLS_5H63C,             "S"},
    {RLS_9C32_1_,           "12"},
    {Hawk_TR_ANMPQ_46,      "HK"},
	{Hawk_CWAR_ANMPQ_55,	"HK"},
    {S300V_9A82_,           "12"},
    {S300V_9A83,            "12"},
    {Buk_LN_9A310M1,        "11"},
    {BUK_LL_,               "11"},
    {Osa_9A33,              "8"},
    {Strela_9A35M3,         "13"},
    {Tor_9A331,             "15"},
    {Roland_ADS,            "RO"},
    {Tunguska_2S6,          "19"},
    {ZSU_23_4_Shilka,       "A"},
    {Gepard,                "A"},
    {Vulcan_M163,           "A"},
    {Kuznecow_,             "SW"},
    {VINSON_,               "SS"},		-- SUPCAR-159: Carriers unknown on RWR - made the same as other carriers
    {MOSCOW_,               "T2"},
    {GROZNY_,               "HN"},
    {AZOV_,                 "AZ"},
    {ALBATROS_,             "HP"},
    {AMETYST_,              "SC"},
    {OREL_,                 "HN"},
    {REZKY_,                "TP"},
    {PERRY_,                "49"},
    {OSA_,                  "DT"},
    {MOLNIYA_,              "PS"},
    {SKORY_,                "HN"},
    {SPRUANCE_,             "40"},
    {TICONDEROGA_,          "AE"},
    {BORA_,                 "CD"},
    {BOBRUISK_,             "CD"},
    {VETER_,                "PP"},
    {NEUSTRASH_,            "TP"},
    {MICA_R_,               "M"},
    {P_27AE_,               "M"},
    {P_77_,                 "M"},
    {P_37_,                 "M"},
    {AIM_54_,               "M"},
    {AIM_120_,              "M"},
    {AIM_120C_,             "M"},
	--0020256: SA-3 as Unknown in the western RWR
    {S125_SR_P_19,          "S"},--P-19 		   - "Flat Face" radar (FF),
    {S125_TR_SNR,           "3"},--SNR S-125 Neva - "Low Blow" radar (LB).
}

symbols_strings ={
	['MiG-21Bis']		= '21',
	['F-5E-3']			= 'F5',
	['F-16C_50']		= '16',		-- F16CB50-359: F-16 is unknown on RWR
	['FA-18C_hornet']	= '18',
	['J-11A']			= '29',
	
	--0045150: Rapier is unknown on RWR
	['rapier_fsa_blindfire_radar'] = 'RP',
	['rapier_fsa_launcher']		   = 'RT',
	['SNR_75V']					   = '2',--SAM SA-2 TR SNR-75 Fan Song
	['Hawk cwar']				   = 'HK',

	-- SUPCAR-159: Carriers unknown on RWR
	['CVN_71']			= 'SS',
	['CVN_72']			= 'SS',
	['CVN_73']			= 'SS',
	['CVN_75']			= 'SS',
	['Stennis']			= 'SS',
	['USS_Arleigh_Burke_IIa'] = 'AE',
	-- F16CB50-971: for new Kuznezov (2017)
	['CV_1143_5']		= 'SW',
	
	-- F-14 heatblur
	['F-14A-135-GR'] = '14',	-- F18-1387: F-14A appears as 'U' in RWR
	['F-14B']		 = '14',
	['F-14D']		 = '14',
	['AIM_54A_Mk60'] = 'M',
	['AIM_54A_Mk47'] = 'M',
	['AIM_54C_Mk47'] = 'M',
	['AIM_54C_Mk60'] = 'M',		-- F16CB50-2060: AIM-54C MK60: does not give RWR warning
	--RAZBAM
	['LHA_Tarawa']	 	= '40', -- same AN/SPS-40 as on Spruance
	['M-2000C']			= 'M2',
	['MiG-19P']			= '19',
	
	--Chinese
	['KJ-2000']			= '50',--0045208: KJ-2000 shows as Unknown on Western RWR
	['JF-17']			= 'JF',--DCSCORE-1655 JF-17 Unknown on Western RWR
	['HQ-7_LN_SP']		= '7', --DCSCORE-1083 HQ-7 from China Asset Pack listed as unknown on NATO RWR
	['HQ-7_STR_SP']		= 'HQ',--DCSCORE-1083 HQ-7 from China Asset Pack listed as unknown on NATO RWR
	['PL-12']			= 'M',
	['SD-10']			= 'M',
	['Type_071']		= 'PS',
	['Type_052B']		= 'MR',
	['Type_052C']		= 'HN',
	['Type_054A']		= 'MR',
	
	['NASAMS_Radar_MPQ64F1'] = 'NS',
	['RPC_5N62V']			 = '5',
	['RLS_19J6']			 = 'TS',
	
	['FPS-117']			 		= 'S',
	['FPS-117 Dome']			= 'S',
	
	--6042: Mirage F-1 , AERGES
	['Mirage-F1B']			= 'F1',
	['Mirage-F1BD']			= 'F1',
	['Mirage-F1BE']			= 'F1',
	['Mirage-F1BQ']			= 'F1',
	['Mirage-F1C-200']		= 'F1',
	['Mirage-F1C']			= 'F1',
	['Mirage-F1CE']			= 'F1',
	['Mirage-F1CG']			= 'F1',
	['Mirage-F1CH']			= 'F1',
	['Mirage-F1CJ']			= 'F1',
	['Mirage-F1CK']			= 'F1',
	['Mirage-F1CR']			= 'F1',
	['Mirage-F1CT']			= 'F1',
	['Mirage-F1CZ']			= 'F1',
	['Mirage-F1DDA']		= 'F1',
	['Mirage-F1ED']			= 'F1',
	['Mirage-F1EDA']		= 'F1',
	['Mirage-F1EE']			= 'F1',
	['Mirage-F1EH']			= 'F1',
	['Mirage-F1EQ']			= 'F1',
	['Mirage-F1JA']			= 'F1',
	['Mirage-F1M-CE']		= 'F1',
	['Mirage-F1M-EE']		= 'F1',
	
	['SON_9']				= 'FC',
} 
