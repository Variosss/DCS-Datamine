local gettext = require("i_18n")
_ = gettext.translate

argument_azimuth   = 19
argument_elevation = 20

limits_azimuth   = {math.rad(-2.5),math.rad(9)}
limits_elevation = {math.rad(-37) ,math.rad(3.5)}

h_axis_velocity = math.rad(20.0)
v_axis_velocity = math.rad(20.0)

DRIVES_FAILURE = 0
LATCH_FAILURE = 1
MECH_FAILURE = 2
Damage = {	{Failure = DRIVES_FAILURE, Failure_name = "GUN_DRIVE_FAILURE", Failure_editor_name = _("Gun drive failure"), Element = 7, Slope_param = 2.5},
			{Failure = LATCH_FAILURE, Failure_name = "GUN_LATCH_FAILURE", Failure_editor_name = _("Gun latch failure"), Element = 7, Slope_param = 2},
			{Failure = MECH_FAILURE, Failure_name = "GUN_FAILURE", Failure_editor_name = _("Gun failure"), Element = 7, Slope_param = 1}}
