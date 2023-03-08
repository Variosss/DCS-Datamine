dofile(LockOn_Options.script_path.."/KNEEBOARD/pages/common.lua")

addChecklistTitle(5, _("BEFORE TAKE-OFF_board"), _("LSHIFT+NUM5"))

addChecklistItem(1,		_("OBSTACLES IN THE DIRECTION OF TAKE-OFF_board"),		_("NONE_board"))
addChecklistItem(2,		_("TAKE-OFF COURSE ON HSI_board"),						_("SET_board"))
addChecklistItem(3,		_("ATTITUDE INDICATORS_board"),							_("READINGS EQUAL_board"))
addChecklistItem(4,		_("AUTOPILOT. ROLL AND PITCH CHANNELS_board"),			_("ON_board"))
addChecklistItem(5,		_("WHEEL BRAKES_board"),								_("DISINHIBITED_board"))
addChecklistItem(6,		_("READINESS FOR TAKE-OFF_board"),						_("READY_board"))

TitleLineY	= getLineY(9)
addChecklistTitle(6, _("BEFORE LANDING_board"), _("LSHIFT+NUM6"))

FirstLineY	= getLineY(10)
addChecklistItem(1,		_("LANDING CONDITIONS_board"),			_("KNOWN. LANDING IS ASSURED_board"))
addChecklistItem(2,		_("AUTOPILOT_board"),					_("ON. ALTITUDE CHANNEL OFF_board"))
addChecklistItem(3,		_("SERVICEABILITY OF SYSTEMS_board"),	_("OK_board"))
addChecklistItem(4,		_("RADAR ALTIMETER_board"),				_("HEIGHT SET_board"))
addChecklistItem(5,		_("COURSE SYSTEM_board"),				_("SLAVED_board"))
addChecklistItem(6,		_("ANTI-DUST_board"),					_("ON_board"))
addChecklistItem(7,		_("LANDING COURSE ON HSI_board"),		_("SET_board"))
addChecklistItem(8,		_("READINESS FOR LANDING_board"),		_("READY_board"))
