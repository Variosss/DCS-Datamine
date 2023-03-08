local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices = {}
devices["MAIN"]					= counter()
devices["HELMET"]				= counter()
devices["AUTOSTART"]       		= counter()
devices["INTERCOM"]				= counter()
devices["OXY_SYS_STARV_IMPL"]	= counter()
devices["TRAP136"]          	= counter()
devices["TRAP137B"]          	= counter()