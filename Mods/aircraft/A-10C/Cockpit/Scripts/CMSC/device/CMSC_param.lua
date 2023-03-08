dofile(LockOn_Options.common_script_path..'wsTypes_SAM.lua')

device_timer_dt	= 0.5

JAMMER_SAM1 = 1
JAMMER_SAM2 = 2
JAMMER_AAA 	= 3

-- a sequence below in an Alphabet order
DEF_PROG_A		= 0
DEF_PROG_B		= 1
-- C .... K
DEF_PROG_L		= 11
-- M ....

JammersProgramsForSAM =
{					
	--Program SAM 1
	{ JAMMER_SAM1,
		{ Kub_STR_9S91, Osa_9A33, Roland_ADS, Roland_rdr, S125_SR_P_19, S125_TR_SNR, Hawk_SR_ANMPQ_50, Hawk_TR_ANMPQ_46}
	},
	--Program SAM 2
	{ JAMMER_SAM2, 
		{ S300PS_TR_30N6, Buk_SR_9S18M1, Buk_LN_9A310M1, Tor_9A331, Tunguska_2S6, Patriot_STR_ANMPQ_53 }
	},
	--Program AAA
	{ JAMMER_AAA, 
		{ Gepard, Vulcan_M163, ZSU_23_4_Shilka, Dog_Ear }
	}
}

ChaffFlaresProgramsForRadars =
{
	--Program A
	{ DEF_PROG_A,
		{ Kub_STR_9S91, Osa_9A33, ZSU_23_4_Shilka}
	},

	--Program B
	{ DEF_PROG_B,
		{ S300PS_SR_5N66M, S300PS_TR_30N6, Buk_SR_9S18M1, Buk_LN_9A310M1, Tor_9A331, Tunguska_2S6, Roland_ADS, Patriot_STR_ANMPQ_53}
	},
	
	--Program L
	{ DEF_PROG_L,
		{S125_SR_P_19, S125_TR_SNR, Hawk_SR_ANMPQ_50, Hawk_TR_ANMPQ_46}
	},
}

need_to_be_closed = true -- close lua state after initialization 