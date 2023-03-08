local gettext = require("i_18n")
_ = gettext.translate

programs = {}

-- Old generation radar SAM
programs['A'] = {}
programs['A']["chaff"] = 2
programs['A']["flare"] = 0
programs['A']["intv"]  = 1.0
programs['A']["cycle"] = 10

-- Current generation radar SAM
programs['B'] = {}
programs['B']["chaff"] = 4
programs['B']["flare"] = 0
programs['B']["intv"]  = 0.5
programs['B']["cycle"] = 10

-- IR SAM
programs['C'] = {}
programs['C']["chaff"] = 0
programs['C']["flare"] = 4
programs['C']["intv"]  = 0.2
programs['C']["cycle"] = 5

-- Default manual presets
-- Mix 1
programs['D'] = {}
programs['D']["chaff"] = 2
programs['D']["flare"] = 2
programs['D']["intv"]  = 1.0
programs['D']["cycle"] = 10

-- Mix 2
programs['E'] = {}
programs['E']["chaff"] = 2
programs['E']["flare"] = 2
programs['E']["intv"]  = 0.5
programs['E']["cycle"] = 10

-- Mix 3
programs['F'] = {}
programs['F']["chaff"] = 4
programs['F']["flare"] = 4
programs['F']["intv"]  = 1.0
programs['F']["cycle"] = 10

-- Mix 4
programs['G'] = {}
programs['G']["chaff"] = 4
programs['G']["flare"] = 4
programs['G']["intv"]  = 0.5
programs['G']["cycle"] = 10

-- Chaff single
programs['H'] = {}
programs['H']["chaff"] = 1
programs['H']["flare"] = 0
programs['H']["intv"]  = 1.0
programs['H']["cycle"] = 1

-- Chaff pair
programs['I'] = {}
programs['I']["chaff"] = 2
programs['I']["flare"] = 0
programs['I']["intv"]  = 1.0
programs['I']["cycle"] = 1

-- Flare single
programs['J'] = {}
programs['J']["chaff"] = 0
programs['J']["flare"] = 1
programs['J']["intv"]  = 1.0
programs['J']["cycle"] = 1

-- Flare pair
programs['K'] = {}
programs['K']["chaff"] = 0
programs['K']["flare"] = 2
programs['K']["intv"]  = 1.0
programs['K']["cycle"] = 1

-- Chaff pre-empt
programs['L'] = {}
programs['L']["chaff"] = 1
programs['L']["flare"] = 0
programs['L']["intv"]  = 1.0
programs['L']["cycle"] = 20

-- Flare pre-empt
programs['M'] = {}
programs['M']["chaff"] = 0
programs['M']["flare"] = 1
programs['M']["intv"]  = 1.0
programs['M']["cycle"] = 20



ContainerChaffCapacity = 120

ContainerFlareCapacity = 60

NumberOfContiners      = 4

AN_ALE_40V_FAILURE_TOTAL = 0
AN_ALE_40V_FAILURE_CONTAINER_LEFT_WING	= 1
AN_ALE_40V_FAILURE_CONTAINER_LEFT_GEAR	= 2
AN_ALE_40V_FAILURE_CONTAINER_RIGHT_GEAR	= 3
AN_ALE_40V_FAILURE_CONTAINER_RIGHT_WING	= 4

Damage = {	{Failure = AN_ALE_40V_FAILURE_TOTAL, Failure_name = "AN_ALE_40V_FAILURE_TOTAL", Failure_editor_name = _("AN/ALE-40(V) total failure"),  Element = 10, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = AN_ALE_40V_FAILURE_CONTAINER_LEFT_WING, Failure_name = "AN_ALE_40V_FAILURE_CONTAINER_LEFT_WING", Failure_editor_name = _("AN/ALE-40(V) left wing container failure"),  Element = 23, Integrity_Treshold = 0.75, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = AN_ALE_40V_FAILURE_CONTAINER_LEFT_GEAR, Failure_name = "AN_ALE_40V_FAILURE_CONTAINER_LEFT_GEAR", Failure_editor_name = _("AN/ALE-40(V) left gear container failure"),  Element = 15, Integrity_Treshold = 0.75, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = AN_ALE_40V_FAILURE_CONTAINER_RIGHT_GEAR, Failure_name = "AN_ALE_40V_FAILURE_CONTAINER_RIGHT_GEAR", Failure_editor_name = _("AN/ALE-40(V) right gear container failure"),  Element = 16, Integrity_Treshold = 0.75, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = AN_ALE_40V_FAILURE_CONTAINER_RIGHT_WING, Failure_name = "AN_ALE_40V_FAILURE_CONTAINER_RIGHT_WING", Failure_editor_name = _("AN/ALE-40(V) right wing container failure"),  Element = 24, Integrity_Treshold = 0.75, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()