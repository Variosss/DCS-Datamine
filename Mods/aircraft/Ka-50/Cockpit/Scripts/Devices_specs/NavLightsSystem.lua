local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.1

LEFT_POSITION_LIGHT_FAILURE = 0
RIGHT_POSITION_LIGHT_FAILURE = 1
TAIL_POSITION_LIGHT_FAILURE = 2
LEFT_FORMATION_LIGHT_FAILURE = 3
RIGHT_FORMATION_LIGHT_FAILURE = 4
TAIL_FORMATION_LIGHT_FAILURE = 5
STROBE_LIGHT_FAILURE = 6
CONTOUR_LIGHTS_FAILURE =7

Damage = {	{Failure = LEFT_POSITION_LIGHT_FAILURE, Failure_name = "LEFT_POSITION_LIGHT_FAILURE", Failure_editor_name = _("Left position light failure"), Element = 23},
			{Failure = RIGHT_POSITION_LIGHT_FAILURE, Failure_name = "RIGHT_POSITION_LIGHT_FAILURE", Failure_editor_name = _("Right position light failure"), Element = 24},
			{Failure = TAIL_POSITION_LIGHT_FAILURE, Failure_name = "TAIL_POSITION_LIGHT_FAILURE", Failure_editor_name = _("Tail position light failure"), Element = 58},
			--
			{Failure = LEFT_FORMATION_LIGHT_FAILURE, Failure_name = "LEFT_FORM_LIGHT_FAILURE", Failure_editor_name = _("Left formation light failure"), Element = 29},
			{Failure = RIGHT_FORMATION_LIGHT_FAILURE, Failure_name = "RIGHT_FORM_LIGHT_FAILURE", Failure_editor_name = _("Right formation light failure"), Element = 30},
			{Failure = TAIL_FORMATION_LIGHT_FAILURE, Failure_name = "TAIL_FORM_LIGHT_FAILURE", Failure_editor_name = _("Tail formation light failure"), Element = 55},
			--
			{Failure = STROBE_LIGHT_FAILURE, Failure_name = "STROBE_LIGHT_FAILURE", Failure_editor_name = _("Strobe light failure"), Element = 82},
			--
			{Failure = CONTOUR_LIGHTS_FAILURE, Failure_name = "CONTOUR_LIGHTS_FAILURE", Failure_editor_name = _("Contour lights failure"), Element = 66},
			{Failure = CONTOUR_LIGHTS_FAILURE, Failure_name = "CONTOUR_LIGHTS_FAILURE", Failure_editor_name = _("Contour lights failure"), Element = 69},
			{Failure = CONTOUR_LIGHTS_FAILURE, Failure_name = "CONTOUR_LIGHTS_FAILURE", Failure_editor_name = _("Contour lights failure"), Element = 72},
			{Failure = CONTOUR_LIGHTS_FAILURE, Failure_name = "CONTOUR_LIGHTS_FAILURE", Failure_editor_name = _("Contour lights failure"), Element = 75},
			{Failure = CONTOUR_LIGHTS_FAILURE, Failure_name = "CONTOUR_LIGHTS_FAILURE", Failure_editor_name = _("Contour lights failure"), Element = 78},
			{Failure = CONTOUR_LIGHTS_FAILURE, Failure_name = "CONTOUR_LIGHTS_FAILURE", Failure_editor_name = _("Contour lights failure"), Element = 81}}
