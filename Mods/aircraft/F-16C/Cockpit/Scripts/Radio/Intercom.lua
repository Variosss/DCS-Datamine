GUI = {

}

device_timer_dt = 0.05

local VMS_short_delay	= 0.5	-- [sec]
local VMS_long_delay	= 1.5	-- [sec]

VMS =
{
	path = "Aircrafts/F-16/Cockpit/",

	messages =
	{
		{ msg = "Betty/PullUp",			duration = 0.65,	looped = true,	delays = { VMS_short_delay, VMS_long_delay, VMS_short_delay } },
		{ msg = "Betty/Altitude",		duration = 0.8,		looped = false,	delays = { VMS_short_delay } },
		{ msg = "Betty/Warning",		duration = 0.40,	looped = false,	delays = { 0, 0.4, 0 } },
		{ msg = "Betty/Jammer",			duration = 0.55,	looped = false,	delays = {} },
		{ msg = "Betty/Counter",		duration = 0.65,	looped = false,	delays = {} },
		{ msg = "Betty/ChaffFlare",		duration = 0.85,	looped = false,	delays = {} },
		{ msg = "Betty/Low",			duration = 0.5,		looped = false,	delays = {} },
		{ msg = "Betty/Out",			duration = 0.45,	looped = false,	delays = {} },
		{ msg = "Betty/Lock",			duration = 0.55,	looped = false,	delays = {} },
		{ msg = "Betty/Caution",		duration = 0.6,		looped = false,	delays = { VMS_short_delay } },
		{ msg = "Betty/Bingo",			duration = 0.65,	looped = false,	delays = { VMS_short_delay } },
		{ msg = "Betty/Data",			duration = 0.45,	looped = false,	delays = {} },
		{ msg = "Betty/IFF",			duration = 0.95,	looped = false,	delays = {} },
	},

	tones =
	{
		{ tone = "Tones/stall_warning",		duration = 2.0 },	-- Low Speed Warning Tone
		{ tone = "Tones/unsafe_landing",	duration = 1.975 },	-- LG Warning Horn
	},
}