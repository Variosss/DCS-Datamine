need_to_be_closed	= true -- lua_state  will be closed in post_initialize()
device_timer_dt		= 0.2
pause_play_time		= 0.01

WarningTone =
{	
	tones =
	{		
		{ path = "Aircrafts/Cockpits/Avionics_440Hz" },	-- danger altitude
		{ path = "Aircrafts/Mi-24P/Cockpit/LaunchPermission" },	-- 9K113 Launch Permission
		{ path = "Aircrafts/Mi-24P/Cockpit/SPO-10" },	-- RWR radiation detected
		{ path = "Aircrafts/Mi-24P/Cockpit/R60_Locked" },	-- R-60 LockOn
	},
	cpt_tones =
	{
		{ path = "Aircrafts/Mi-24P/Cockpit/Migalka" },	-- flasher
	}
}

