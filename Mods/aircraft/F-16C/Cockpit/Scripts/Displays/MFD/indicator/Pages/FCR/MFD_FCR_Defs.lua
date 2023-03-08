local count = -1
local function counter()
	count = count + 1
	return count
end

count = -1
FCR_SELECT_MODES = 
{
	NONE	= counter(),
	STBY	= counter(),
	-- AA
	ACM		= counter(),
	CRM		= counter(),
	-- AG
	GM		= counter(),
	GMT		= counter(),
	SEA		= counter(),
	BCN		= counter(),
	AGR		= counter(),
	--
	BIT		= counter(),
}

count = -1
FCR_OPERATING_MODE = 
{
	NONE		= counter(),
	STBY		= counter(),
	-- AA
	ACM_30_20	= counter(),
	ACM_10_60	= counter(),
	ACM_BORE	= counter(),
	ACM_SLEW	= counter(),
	CRM_RWS		= counter(),
	CRM_ULS		= counter(),
	CRM_VS		= counter(),
	CRM_TWS		= counter(),
	-- AG search
	GM			= counter(),
	GMT			= counter(),
	SEA			= counter(),
	BCN			= counter(),
	AGR			= counter(),
	--
	BIT			= counter(),
}

tactical_display_sz 	= 480
tactical_display_sz_half = tactical_display_sz / 2

count = -1
HAFU =
{
	NONE		= counter(),		-- "Undefined" or "No Statement"
	--
	UNKNOWN		= counter(),
	FRIENDLY	= counter(),
	HOSTILE		= counter(),
	AMBIGUOUS	= counter(),
};

count = -1
FCR_MODE_MENU_STATE =
{
	MAIN	= counter(),
	MODE	= counter(),
	CNTL	= counter(),
}
