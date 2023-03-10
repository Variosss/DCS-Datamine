dofile('Scripts/Aircrafts/_Common/Cockpit/wsTypes_SAM.lua')
dofile('Scripts/Aircrafts/_Common/Cockpit/wsTypes_Airplane.lua')
dofile('Scripts/Aircrafts/_Common/Cockpit/wsTypes_Ship.lua')
dofile('Scripts/Aircrafts/_Common/Cockpit/wsTypes_Missile.lua')

DefaultType          = 100
DEFAULT_TYPE_ = {DefaultType, DefaultType, DefaultType, DefaultType}

symbolID = 
{
	{110, S300PS_TR_30N6},
	{104, S300PS_SR_64H6E},
	{103, S300PS_SR_5N66M},
	{115, Buk_LN_9A310M1},
	{107, Buk_SR_9S18M1},	
	{120, Tunguska_2S6},
	{119, Tor_9A331},
	{117, Osa_9A33},
	{121, ZSU_23_4_Shilka},
	{109, Dog_Ear},	
	{123, S125_TR_SNR},
	{122, S125_SR_P_19},
	{108, Kub_STR_9S91},
	{118, Strela_9A35M3},
	{105, RLO_9C15MT_},
	{106, RLO_9C19M2_},
	{111, RLS_5H63C},
	{112, RLS_9C32_1_},
	{113, S300V_9A82_},
	{114, S300V_9A83},
	{116, BUK_LL_},
	{201, Roland_ADS},
	{202, Patriot_STR_ANMPQ_53},
	{203, Hawk_SR_ANMPQ_50},
	{204, Hawk_TR_ANMPQ_46},
	{205, Roland_rdr},
	{206, Hawk_CWAR_ANMPQ_55},
	{207, Gepard},
	{208, Vulcan_M163},	
	{301, Kuznecow_},
	{303, MOSCOW_},
	{304, GROZNY_},
	{305, AZOV_},
	{306, ALBATROS_},
	{307, AMETYST_},
	{308, OREL_},
	{309, REZKY_},
	{311, OSA_},
	{312, MOLNIYA_},
	{313, SKORY_},
	{314, SPRUANCE_},
	{315, TICONDEROGA_},
	{316, BORA_},
	{317, BOBRUISK_},
	{318, VETER_},
	{319, NEUSTRASH_},	
	{401, PERRY_},
	{402, VINSON_},
	
}

symbols_stringsID = 
{
	{124 ,"rapier_fsa_blindfire_radar"},
	{125 ,"rapier_fsa_launcher"},
	{126 ,"SNR_75V"},
	{127 ,"HQ-7_LN_SP"},
	{128 ,"HQ-7_STR_SP"}, 
	{403 ,"CVN_71"},
	{404 ,"CVN_72"},
	{405 ,"CVN_73"},
	{406 ,"Stennis"},
	{407 ,"LHA_Tarawa"},
	{320 ,"CV_1143_5"},
	{408 ,"Type_071"},
	{409 ,"Type_052B"},
	{410 ,"Type_052C"},
	{411 ,"Type_054A"},
	{412 ,"USS_Arleigh_Burke_IIa"},
	{209 ,"NASAMS_Radar_MPQ64F1"},
	{129 ,"RPC_5N62V"},
	{413 ,"CVN_75"},
	{130 ,"RLS_19J6"},
	{131 ,"SON_9"},
}