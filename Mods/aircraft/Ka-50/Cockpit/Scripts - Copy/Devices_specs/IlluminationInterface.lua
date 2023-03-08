local gettext = require("i_18n")
_ = gettext.translate

PANELS_ILLUMINATION_FAILURE = 0	
ADI_SAI_ILLUMINATION_FAILURE = 1
DOME_LIGHT_FAILURE = 2
NIGHT_ILLUMINATION_FAILURE = 3
CONTROL_PANEL_ILLUMINATION_FAILURE = 4

Damage = {	{Failure = PANELS_ILLUMINATION_FAILURE, Failure_name = "PANELS_ILLUM_FAILURE", Failure_editor_name = _("Panels illumination failure"), Element = 3}, 
			{Failure = PANELS_ILLUMINATION_FAILURE, Failure_name = "PANELS_ILLUM_FAILURE", Failure_editor_name = _("Panels illumination failure"), Element = 4}, 
			{Failure = PANELS_ILLUMINATION_FAILURE, Failure_name = "PANELS_ILLUM_FAILURE", Failure_editor_name = _("Panels illumination failure"), Element = 5},
			--
			{Failure = ADI_SAI_ILLUMINATION_FAILURE, Failure_name = "ADI_SAI_ILLUM_FAILURE", Failure_editor_name = _("ADI/SAI illumination failure"), Element = 3}, 
			{Failure = ADI_SAI_ILLUMINATION_FAILURE, Failure_name = "ADI_SAI_ILLUM_FAILURE", Failure_editor_name = _("ADI/SAI illumination failure"), Element = 4}, 
			{Failure = ADI_SAI_ILLUMINATION_FAILURE, Failure_name = "ADI_SAI_ILLUM_FAILURE", Failure_editor_name = _("ADI/SAI illumination failure"), Element = 5},
			--
			{Failure = DOME_LIGHT_FAILURE, Failure_name = "DOME_LIGHT_FAILURE", Failure_editor_name = _("Dome light failure"), Element = 3}, 
			{Failure = DOME_LIGHT_FAILURE, Failure_name = "DOME_LIGHT_FAILURE", Failure_editor_name = _("Dome light failure"), Element = 4}, 
			{Failure = DOME_LIGHT_FAILURE, Failure_name = "DOME_LIGHT_FAILURE", Failure_editor_name = _("Dome light failure"), Element = 5},
			--
			{Failure = NIGHT_ILLUMINATION_FAILURE, Failure_name = "NIGHT_ILLUM_FAILURE", Failure_editor_name = _("Night illumination failure"), Element = 3}, 
			{Failure = NIGHT_ILLUMINATION_FAILURE, Failure_name = "NIGHT_ILLUM_FAILURE", Failure_editor_name = _("Night illumination failure"), Element = 4}, 
			{Failure = NIGHT_ILLUMINATION_FAILURE, Failure_name = "NIGHT_ILLUM_FAILURE", Failure_editor_name = _("Night illumination failure"), Element = 5},
			--
			{Failure = CONTROL_PANEL_ILLUMINATION_FAILURE, Failure_name = "CNTRL_PANEL_ILLUM_FAILURE", Failure_editor_name = _("Control panel illumination failure"), Element = 3}, 
			{Failure = CONTROL_PANEL_ILLUMINATION_FAILURE, Failure_name = "CNTRL_PANEL_ILLUM_FAILURE", Failure_editor_name = _("Control panel illumination failure"), Element = 4}, 
			{Failure = CONTROL_PANEL_ILLUMINATION_FAILURE, Failure_name = "CNTRL_PANEL_ILLUM_FAILURE", Failure_editor_name = _("Control panel illumination failure"), Element = 5}}
