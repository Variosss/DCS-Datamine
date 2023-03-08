dofile(LockOn_Options.script_path.."/KNEEBOARD/pages/common.lua")

addChecklistTitle(2, _("AFTER APU START_board"), _("LSHIFT+NUM2"))

addChecklistItem(1,		_("APU PARAMETERS_board"),				_("NORMAL_board"))
addChecklistItem(2,		_("EMERGENCY GENERATOR_board"),			_("ON_board"))
addChecklistItem(3,		_("HYDRAULIC SWITCHES_board"),			_("ON_board"))
addChecklistItem(4,		_("STROBE LIGHT_board"),				_("ON_board"))
addChecklistItem(5,		_("INVERTER PO-115_board"),				_("MANUAL_board"))
addChecklistItem(6,		_("READINESS FOR ENGINES START_board"),	_("READY_board"))

TitleLineY	= getLineY(9)
addChecklistTitle(3, _("ENGINES IDLE_board"), _("LSHIFT+NUM3"))

FirstLineY	= getLineY(10)
addChecklistItem(1,		_("ENGINES PARAMETERS_board"),			_("NORMAL_board"))
addChecklistItem(2,		_("ANTI DUST_board"),					_("ON_board"))
addChecklistItem(3,		_("REDUCTORS_board"),					_("WARMED UP. OK_board"))
addChecklistItem(4,		_("HYDRAULIC SYSTEMS_board"),			_("ON. OK_board"))
addChecklistItem(5,		_("RADIO_board"),						_("ON. CHECKED_board"))
