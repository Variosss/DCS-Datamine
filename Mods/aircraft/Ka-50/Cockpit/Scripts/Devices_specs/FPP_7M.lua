local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.05

MAIN_SPOT_FAILURE = 0	
MAIN_SPOT_DRIVE_FAILURE = 1
BACKUP_SPOT_FAILURE = 2
BACKUP_SPOT_DRIVE_FAILURE = 3
Damage = {	{Failure = MAIN_SPOT_FAILURE, Failure_name = "MAIN_SPOTLIGHT_FAILURE", Failure_editor_name = _("Main spotlight failure"), Element = 82},
			{Failure = MAIN_SPOT_DRIVE_FAILURE, Failure_name = "MAIN_SPOTLIGHT_DRIVE_FAILURE", Failure_editor_name = _("Main spotlight drive failure"), Element = 82, Slope_param = 2.1},
			{Failure = BACKUP_SPOT_FAILURE, Failure_name = "BACKUP_SPOTLIGHT_FAILURE", Failure_editor_name = _("Backup spotlight failure"), Element = 82},
			{Failure = BACKUP_SPOT_DRIVE_FAILURE, Failure_name = "BACKUP_SPOTLIGHT_DRIVE_FAILURE", Failure_editor_name = _("Backup spotlight drive failure"), Element = 82, Slope_param = 2.1}}
