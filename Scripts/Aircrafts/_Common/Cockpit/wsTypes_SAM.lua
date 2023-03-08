--- Names of SAM for cockpit use

dofile("Scripts/Database/wsTypes.lua")

-- SAM Missile
	-- SA-3
	S_125_LN_5P73	= {wsType_Ground, wsType_SAM, wsType_Miss, Hawk_}
	-- SA-6
	Kub_LN_2P25		= {wsType_Ground, wsType_SAM, wsType_Miss, KUB_2P25}
	-- SA-9
	Strela_1_9P31	= {wsType_Ground, wsType_SAM, wsType_Miss, Strela_9K31}
	-- SA-10
	S300PS_LN_5P85C = {wsType_Ground, wsType_SAM, wsType_Miss, PU_5P85C}
	S300PS_LN_5P85D = {wsType_Ground, wsType_SAM, wsType_Miss, PU_5P85D}
	-- SA-18
	Igla_mpad_GRG	= {wsType_Ground, wsType_SAM, wsType_Miss, IglaGRG_1}
	Igla_comm_GRG 	= {wsType_Ground, wsType_SAM, wsType_Miss, IglaGRG_2}
	Igla_S_mpad_RUS	= {wsType_Ground, wsType_SAM, wsType_Miss, IglaRUS_1}
	Igla_S_comm_RUS = {wsType_Ground, wsType_SAM, wsType_Miss, IglaRUS_2}
	Igla_mpad_INS   = {wsType_Ground, wsType_SAM, wsType_Miss, IglaINS_1}

	---
	Stinger_mpad_USA = {wsType_Ground,wsType_SAM, wsType_Miss, StingerUSA_1}
	Stinger_comm_USA = {wsType_Ground,wsType_SAM, wsType_Miss, StingerUSA_2}
	Stinger_mpad_IZR = {wsType_Ground,wsType_SAM, wsType_Miss, StingerIZR_1}
	Stinger_comm_IZR = {wsType_Ground,wsType_SAM, wsType_Miss, StingerIZR_2}
	Stinger_mpad_GRG = {wsType_Ground,wsType_SAM, wsType_Miss, StingerGRG_1}
	--Stinger_comm_GRG = {wsType_Ground,wsType_SAM, wsType_Miss, StingerGRG_2}

	Patriot_LN_901 	= {wsType_Ground, wsType_SAM, wsType_Miss, Patriot_}
	Hawk_LN_M192 	= {wsType_Ground, wsType_SAM, wsType_Miss, Hawk_}
	Chaparral_M48	= {wsType_Ground, wsType_SAM, wsType_Miss, M48_Chaparral}

-----------------------------------------------------------------------------------
-- SAM Radar - Missile
	-- SA-8
	Osa_9A33		= {wsType_Ground, wsType_SAM, wsType_Radar_Miss, OSA_9A33BM3}
	-- SA-11
	Buk_LN_9A310M1	= {wsType_Ground, wsType_SAM, wsType_Radar_Miss, BUK_PU}
	-- SA-15
	Tor_9A331 		= {wsType_Ground, wsType_SAM, wsType_Radar_Miss, Tor_}
	----
	Roland_ADS		= {wsType_Ground, wsType_SAM, wsType_Radar_Miss, Roland_}
-----------------------------------------------------------------------------------
-- SAM Missile - GUN
	-- SA-13
	Strela_9A35M3 	= {wsType_Ground, wsType_SAM, wsType_MissGun, Strela_9K35}
	----
	Linebacker_M6	= {wsType_Ground, wsType_SAM, wsType_MissGun, M6Linebacker}
	Avenger_M1097	= {wsType_Ground, wsType_SAM, wsType_MissGun, Avenger_}
-----------------------------------------------------------------------------------
-- SAM Radar - GUN
	ZSU_23_4_Shilka	= {wsType_Ground, wsType_SAM, wsType_Radar_Gun, Shilka_}
	Gepard			= {wsType_Ground, wsType_SAM, wsType_Radar_Gun, Gepard_}
	Vulcan_M163 	= {wsType_Ground, wsType_SAM, wsType_Radar_Gun, wsTypeVulkan}
-----------------------------------------------------------------------------------
-- SAM Radar - GUN - Missile
	-- SA - 19
	Tunguska_2S6 = {wsType_Ground, wsType_SAM, wsType_Radar_MissGun, Tunguska_}
-----------------------------------------------------------------------------------
-- SAM GUN
	ZU_23_Ural_ 			 = {wsType_Ground, wsType_SAM, wsType_Gun, ZU_23_URAL}
	ZU_23_Insurgent_ 		 = {wsType_Ground, wsType_SAM, wsType_Gun, ZU_23_insurgent}
	ZU_23_Insurgent_Closed 	 = {wsType_Ground, wsType_SAM, wsType_Gun, ZU_23_insurgent_okop}
	ZU_23_Emplacement 		 = {wsType_Ground, wsType_SAM, wsType_Gun, ZU_23}
	ZU_23_Emplacement_Closed = {wsType_Ground, wsType_SAM, wsType_Gun, ZU_23_OKOP}
	ZU_23_Insurgent_Ural_ 	 = {wsType_Ground, wsType_SAM, wsType_Gun, ZU_23_insurgent_ural}
-----------------------------------------------------------------------------------
-- SAM Radar
	-- SA - 3
	S125_SR_P_19 		 = {wsType_Ground, wsType_SAM, wsType_Radar, SA3_SR} 
	S125_TR_SNR 		 = {wsType_Ground, wsType_SAM, wsType_Radar, SA3_TR} 
	-- SA - 6 
	Kub_STR_9S91 		 = {wsType_Ground, wsType_SAM, wsType_Radar, KUB_1C91} 
	-- SA - 10
	S300PS_SR_64H6E 	 = {wsType_Ground, wsType_SAM, wsType_Radar, RLO_64H6E} 
	S300PS_SR_5N66M 	 = {wsType_Ground, wsType_SAM, wsType_Radar, V_40B6MD}	
	S300PS_TR_30N6 		 = {wsType_Ground, wsType_SAM, wsType_Radar, V_40B6M} 
	-- SA - 11
	Buk_SR_9S18M1		 = {wsType_Ground, wsType_SAM, wsType_Radar, BUK_9C18M1} 
	
	---
	Patriot_STR_ANMPQ_53 = {wsType_Ground, wsType_SAM, wsType_Radar, Patr_AN_MPQ_53_P}
	Hawk_SR_ANMPQ_50  	 = {wsType_Ground, wsType_SAM, wsType_Radar, Hawk_Search_Radar}
	Hawk_CWAR_ANMPQ_55   = {wsType_Ground, wsType_SAM, wsType_Radar, Hawk_CWAR_Radar}
	Hawk_TR_ANMPQ_46  	 = {wsType_Ground, wsType_SAM, wsType_Radar, Hawk_Track_Radar}
	EWR_1L13_ 			 = {wsType_Ground, wsType_SAM, wsType_Radar, EWR_1L13}
	EWR_55G6_ 			 = {wsType_Ground, wsType_SAM, wsType_Radar, EWR_55G6}
	Roland_rdr			 = {wsType_Ground, wsType_SAM, wsType_Radar, Roland_Search_Radar}
	Dog_Ear 			 = {wsType_Ground, wsType_SAM, wsType_Radar, Radar_Dog_Ear}

	--- No units
	RLO_9C15MT_			 = {wsType_Ground, wsType_SAM, wsType_Radar, RLO_9C15MT}	--sa12
	RLO_9C19M2_			 = {wsType_Ground, wsType_SAM, wsType_Radar, RLO_9C19M2}	-- sa12
	RLS_5H63C_			 = {wsType_Ground, wsType_SAM, wsType_Radar, RLS_5H63C} 	-- sa10
	RLS_9C32_1_			 = {wsType_Ground, wsType_SAM, wsType_Radar, RLS_9C32_1}	-- sa12
	S300V_9A82_			 = {wsType_Ground, wsType_SAM, wsType_Radar_Miss, S300V_9A82}--sa12
	BUK_LL_				 = {wsType_Ground, wsType_SAM, wsType_Radar_Miss, BUK_LL} --sa11

----------------------------------------------------------------------------------------



















