-- Pages Definition
MPCD_MENU		= 0
MPCD_FLIR		= 1
MPCD_EHSD		= 2
MPCD_DMT		= 3
MPCD_STRS		= 4
MPCD_HUD		= 5
MPCD_BIT		= 6
MPCD_VRST		= 8
MPCD_ENG		= 11
MPCD_CONF		= 12
MPCD_TPOD		= 13
MPCD_IFF		= 14
MPCD_EW			= 15
MPCD_CARD		= 16
MPCD_CAS		= 17
MPCD_EPCD		= 18
MPCD_SDAT		= 19
MPCD_COMM		= 20

-- Subpages Definitions
-- NAVFLIR Subpages
MPCD_FLIR_NAV		= 30
MPCD_FLIR_BRS		= 31

-- EHSD Subpages
MPCD_EHSD_STR		= 40
MPCD_EHSD_DATA		= 42
MPCD_EHSD_DATA_GPS	= 43
MPCD_EHSD_ALIGN		= 44
MPCD_EHSD_TEST		= 46
MPCD_EHSD_INS_OFF	= 47
MPCD_EHSD_NOINS		= 48
MPCD_EHSD_ALIGN_DAT	= 49
MPCD_EHSD_JDAM		= 55
MPCD_EHSD_CHART		= 56


-- DMT Subpages (NONE)

-- STRS Subpages
MPCD_STRS_BASE		= 50
MPCD_STRS_LSM		= 51
MPCD_STRS_IRM		= 52
MPCD_STRS_IRM_VIDEO	= 53
MPCD_STRS_DMGD		= 54
MPCD_STRS_JDAM		= 57

-- HUD Subpages
MPCD_HUD_BASE		= 60
MPCD_HUD_PG1		= 61

-- BIT Subpages
MPCD_BIT_1			= 70
MPCD_BIT_2			= 71
MPCD_BIT_SMS		= 72
MPCD_BIT_FBST		= 73

-- VRST Subpages
MPCD_VRST_BSC		= 80
MPCD_VRST_VTO		= 81
MPCD_VRST_STO		= 82
MPCD_VRST_CRS		= 83
MPCD_VRST_BNG		= 84

-- ENG Subpages
MPCD_ENG_EMS		= 90
MPCD_ENG_PHOV		= 91

-- CONF Subpages
MPCD_CONF_1			= 95
MPCD_CONF_2			= 96
MPCD_CONF_3			= 97

--TPOD Subpages
MPCD_TPOD_CCD_PR	= 100
MPCD_TPOD_CCD_DT	= 101
MPCD_TPOD_FLIR_PR	= 102
MPCD_TPOD_FLIR_DT	= 103
MPCD_TPOD_NAV_PR	= 104
MPCD_TPOD_NAV_DT	= 105
MPCD_TPOD_VCR_DSPLY	= 106

-- EW Subpages
MPCD_EW_RWR			= 120
MPCD_EW_CMD_PRG		= 121

-- CARD Subpages

-- CAS Subpages
MPCD_CAS_PAGE		= 130
MPCD_CAS_LIST		= 131

-- EPCD Subpages
MPCD_EPCD_MENU		= 140

-- SDAT Subpages


-- Page Sources
SRC_MPCD_BASE	= 0
SRC_MPCD_FLIR	= 1
SRC_MPCD_EHSD	= 2
SRC_MPCD_DMT	= 3
SRC_MPCD_STRS	= 4
SRC_MPCD_HUD	= 5
SRC_MPCD_BIT	= 6
SRC_MPCD_VRST	= 8
SRC_MPCD_ENG	= 11
SRC_MPCD_CONF	= 12
SRC_MPCD_TPOD	= 13
SRC_MPCD_IFF	= 14
SRC_MPCD_EW		= 15
SRC_MPCD_CARD	= 16
SRC_MPCD_CAS	= 17
SRC_MPCD_EPCD	= 18
SRC_MPCD_SDAT	= 19
SRC_MPCD_COMM	= 20
SRC_MPCD_MENU	= 99

SRC_FLIR_NAV			= 100
SRC_FLIR_BRS			= 101

SRC_EHSD_NAV			= 110
SRC_EHSD_DATA			= 111
SRC_EHSD_ALIGN			= 112
SRC_EHSD_TEST			= 114
SRC_EHSD_NOINS			= 115
SRC_EHSD_DATA_GPS		= 116
SRC_EHSD_NAV_AG			= 117
SRC_EHSD_INS_OFF		= 118
SRC_EHSD_ALIGN_DATA		= 119
SRC_EHSD_JDAM			= 124
SRC_EHSD_CHART			= 125

SRC_DMT_VIDEO			= 120
SRC_DMT_INS_WPT			= 121
SRC_DMT_INS_TGT			= 122
SRC_DMT_AG_INS_TD		= 123

SRC_STRS_LSM			= 130
SRC_STRS_IRM			= 131
SRC_STRS_IRM_VIDEO		= 132
SRC_STRS_DMGD			= 133
SRC_STRS_JDAM			= 134

SRC_MPCD_BIT_1			= 140
SRC_MPCD_BIT_2			= 141
SRC_MPCD_BIT_SMS		= 142
SRC_MPCD_BIT_FBST		= 143

SRC_VRST_BSC			= 150
SRC_VRST_VTO			= 151
SRC_VRST_STO			= 152
SRC_VRST_CRS			= 153
SRC_VRST_BNG			= 154

SRC_MPCD_ENG_EMS		= 160
SRC_MPCD_ENG_PHOV		= 161

SRC_MPCD_CONF_1			= 165
SRC_MPCD_CONF_2			= 166
SRC_MPCD_CONF_3			= 167

SRC_TPOD_CCD_PR			= 170
SRC_TPOD_CCD_DT			= 171
SRC_TPOD_FLIR_PR		= 172
SRC_TPOD_FLIR_DT		= 173
SRC_TPOD_NAV_PR			= 174
SRC_TPOD_NAV_DT			= 175
SRC_TPOD_VCR_DSPLY		= 176

SRC_EW_RWR				= 180
SRC_EW_CMD_PRG			= 181

SRC_CAS_PAGE			= 190
SRC_CAS_LIST			= 191

SRC_EPCD_MENU			= 200

