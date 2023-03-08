dofile('Scripts/Aircrafts/_Common/Cockpit/wsTypes_SAM.lua')
dofile('Scripts/Aircrafts/_Common/Cockpit/wsTypes_Ship.lua')

local DO_NOT_LOCALIZE = true


symbols = 
{
	{NEUSTRASH_,            "SN9"},
	{Kuznecow_,             "SN9"},
	{MOSCOW_,               "SN6"},
	{OSA_,                  "SA8"},
	{ALBATROS_,             "SA8"},
 	{REZKY_,                "SA8"},
	{VINSON_,               "SS" ,DO_NOT_LOCALIZE},
	{PERRY_,                "SM2",DO_NOT_LOCALIZE},
	{SPRUANCE_,             "40" ,DO_NOT_LOCALIZE},
	{TICONDEROGA_,          "SM2",DO_NOT_LOCALIZE},
	
	{S300PS_SR_64H6E,		"S"},
	{RLO_9C15MT_,			"S"},
	{Buk_SR_9S18M1,			"S11"},
	{Kub_STR_9S91,			"SA6"},
	
	{Roland_ADS,			"R",DO_NOT_LOCALIZE},
	{Roland_rdr,			"S",DO_NOT_LOCALIZE},
	{Patriot_STR_ANMPQ_53,	"P",DO_NOT_LOCALIZE},
	
	{Hawk_SR_ANMPQ_50,		"S"},
	
	{S300PS_TR_30N6,		"S10"},
	{S300PS_SR_5N66M,		"S"},
	{RLS_5H63C_,			"S",DO_NOT_LOCALIZE},
	{RLS_9C32_1_,			"S",DO_NOT_LOCALIZE},
	{Hawk_TR_ANMPQ_46,		"HK",DO_NOT_LOCALIZE},
	
	{S125_SR_P_19,			"S"},
	{S125_TR_SNR,			"SA3"},

	{S300V_9A82_,			"S11"},
	{Buk_LN_9A310M1,		"S11"},
	{Osa_9A33,				"SA8"},
	{Strela_9A35M3,			"S13"},
	{Tor_9A331,				"S15"},
	{Tunguska_2S6,			"S19"},
}

symbols_strings ={
	--0045150: Rapier is unknown on RWR
	{'rapier_fsa_blindfire_radar',	'S'},
	{'rapier_fsa_launcher',			'RT'},
	{'SNR_75V',						'SA2'},--SAM SA-2 TR SNR-75 Fan Song
	{'Hawk cwar',					'HK'},
	{'Dog Ear radar',				'DGE'},
	{'LHA_Tarawa',					'40'}, -- same AN/SPS-40 as on Spruance

	-- SUPCAR-159: Carriers unknown on RWR
	{'CVN_71',						'SS',DO_NOT_LOCALIZE},
	{'CVN_72',						'SS',DO_NOT_LOCALIZE},
	{'CVN_73',						'SS',DO_NOT_LOCALIZE},
	{'Stennis',						'SS',DO_NOT_LOCALIZE},

	--Chinese
	{'HQ-7_LN_SP',					'7', DO_NOT_LOCALIZE },--DCSCORE-1083 HQ-7 from China Asset Pack listed as unknown on NATO RWR
	{'HQ-7_STR_SP',					'HQ',DO_NOT_LOCALIZE },--DCSCORE-1083 HQ-7 from China Asset Pack listed as unknown on NATO RWR

--	{'55G6 EWR',					'TLR'}, -- 55G6 'Tall Rack' EWR  i have doubts about availability of EWR engagement with anti radar missiles
} 
