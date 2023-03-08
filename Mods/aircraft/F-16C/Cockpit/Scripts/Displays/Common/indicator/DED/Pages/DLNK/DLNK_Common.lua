local count = -1
local function counter()
	count = count + 1
	return count
end

ASTERISKS_POS =
{
	NONE				= counter();
	-- NET STATUS Page
	ETR					= counter();	-- GPS TIME
	TIME				= counter();
	NTR					= counter();
	SYNC				= counter();
	IPF					= counter();	-- IPF RESET
	NET_STATUS_MAX		= counter();
	-- LINK 16 Page
	FC					= counter();	-- fighter channel
	MC					= counter();	-- mission control channel
	SC					= counter();	-- special channel
	CS_NUM				= counter();	-- call sign number
	CS_NAME				= counter();	-- call sign name
	FL					= counter();	-- flight lead
	XMT					= counter();	-- power level
	LINK_16_MAX			= counter();
	-- LINK 16 STN Page
	STN1_TDOA			= counter();
	STN1				= counter();
	STN2_TDOA			= counter();
	STN2				= counter();
	STN3_TDOA			= counter();
	STN3				= counter();
	STN4_TDOA			= counter();
	STN4				= counter();
	STN5_TDOA			= counter();
	STN5				= counter();
	STN6_TDOA			= counter();
	STN6				= counter();
	STN7_TDOA			= counter();
	STN7				= counter();
	STN8_TDOA			= counter();
	STN8				= counter();
	OWN_ID				= counter();
	LINK_16_STN_MAX		= counter();
}