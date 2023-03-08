local count = -1
local function counter()
	count = count + 1
	return count
end

ASTERISKS_POS =
{
	NONE				= counter();
	-- NAV STATUS Page
	MSN_DUR				= counter();
	-- NAV COMMANDS Page
	FILTER_MODE			= counter();
	RESET_GPS			= counter();
	ZEROIZE_GPS			= counter();
}