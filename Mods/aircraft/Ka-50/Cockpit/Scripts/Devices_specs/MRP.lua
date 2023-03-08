local gettext = require("i_18n")
_ = gettext.translate

innerNoise = 0.00000048 / 3
frequency = 75000000.0
band_width = 2000.0

MRP_FAILURE = 0
Damage = {{Failure = MRP_FAILURE, Failure_name = "MRP_FAILURE", Failure_editor_name = _("MRP failure"), Element = 4, Integrity_Treshold = 0.3},
		  {Failure = MRP_FAILURE, Failure_name = "MRP_FAILURE", Failure_editor_name = _("MRP failure"), Element = 82}}
