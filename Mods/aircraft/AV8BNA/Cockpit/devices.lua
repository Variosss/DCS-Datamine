local count = 0
local function counter()
    count = count + 1
    return count
end

devices                         = {}
devices["ELECTRIC"]             = counter()	-- 1
devices["COMM1"]                = counter()	-- 2
devices["COMM2"]                = counter()	-- 3
devices["INTERCOM"]             = counter()	-- 4
devices["TACAN"]                = counter()	-- 5
devices["AWLS"]                 = counter()	-- 6
devices["RSC"]                  = counter()	-- 7
devices["ACNIP"]                = counter()	-- 8
devices["DECS"]                 = counter()	-- 9
devices["ADC"]                  = counter()	-- 10
devices["NAV_INS"]              = counter()	-- 11
devices["MSC"]                  = counter()	-- 12
devices["VREST"]                = counter()	-- 13
devices["NAVFLIR"]				= counter()	-- 14
devices["TGTPOD"]				= counter()	-- 15
devices["DMT"]					= counter()	-- 16
devices["RWR"]					= counter()	-- 17
devices["RWRCONTROL"]			= counter()	-- 18
devices["FLIGHTINSTRUMENTS"]    = counter()	-- 19
devices["EDP"]                  = counter()	-- 20
devices["FQIS"]                 = counter()	-- 21
devices["HUDCONTROL"]           = counter()	-- 22
devices["UFCCONTROL"]           = counter()	-- 23
devices["ODUCONTROL"]           = counter()	-- 24
devices["EHSD_MAP"]     		= counter()	-- 25
devices["MPCD_LEFT"]            = counter()	-- 26
devices["MPCD_RIGHT"]           = counter()	-- 27
devices["FLIGHTCONTROLS"]       = counter()	-- 28
devices["SMC"]                  = counter()	-- 29
devices["EWS"]                  = counter()	-- 30
devices["CBTSYST"]              = counter()	-- 31
devices["TVWPNS"]				= counter()	-- 32
devices["LTEXT"]				= counter()	-- 33
devices["LTINT"]				= counter()	-- 34
devices["LTWCA"]				= counter()	-- 35
devices["ECS"]                  = counter()	-- 36
devices["HYDRAULIC"]            = counter() -- 37
devices["NETWORKINTERFACE"]     = counter()	-- 38
devices["ANVIS9"]     			= counter()	-- 39
devices["AUTOSTART"]     		= counter()	-- 40
devices["DAMAGE_CONTROL"]		= counter()	-- 41
devices["ATHS"]					= counter()	-- 42
devices["IRHSD"]				= counter()	-- 42
devices["DATAPARAMS"]			= counter()	-- 43

