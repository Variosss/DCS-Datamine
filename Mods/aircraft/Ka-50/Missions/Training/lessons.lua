--[[ Designer Notes. This file defines the order the lessons are shown in the in-game list.
       Explanations:
  ["file"] = "FileName.miz", - obligatory field.
  ["name"] = _("New Name"), - optional. Provides a key for ext localization. If omitted the name is taken from miz in proper locale.
  ["description"] = _("New Description"), - optional. Works same as "name" field but for description.
--]]--*end of notes*

lessons = 
{
	{
        ["file"] = "BS2_Cold_Start_Training.miz",
        ["name"] = _("Aircraft Start-up"),
        ["description"] = _("In this lesson, we will practice starting the Ka-50 from the ramp."),
    },
	{
        ["file"] = "BS2_En-Route_Navigation_Training.miz",
        ["name"] = _("En-Route Navigation Training"),
        ["description"] = _("In this lesson, we will practice En-route navigation using the PVI-800, ABRIS and the autopilot."),
    },
	{
        ["file"] = "BS2_ABRIS_AMMS_Training.miz",
        ["name"] = _("ABRIS AMMS Overview"),
        ["description"] = _("In this lesson, we will review the ABRIS AMMS system of the KA-50."),
    },
	{
        ["file"] = "BS2_ABRIS_Advanced_Training.miz",
        ["name"] = _("ABRIS Advanced Training"),
        ["description"] = _("In this mission, you will learn about the various sub modes of the main operating modes of the ABRIS."),
    },
	{
        ["file"] = "BS2_Weapon Employment_Training.miz",
        ["name"] = _("Weapon Employment"),
        ["description"] = _("In this lesson, we will use the weapon systems."),
    },
	{
        ["file"] = "BS2_Countermeasure_training.miz",
        ["name"] = _("Counter measure training"),
        ["description"] = _("In this lesson, we will practice using the L-140 laser warning system, the UV-26 flare dispenser, and signal flare."),
    },
    {
        ["file"] = "BS2_Datalink_Wingmen_Training.miz",
        ["name"] = _("Datalink and Wingmen"),
        ["description"] = _("In this lesson you will learn to command your wingmen and issue targets through the data link."),
    },
} -- end of lessons
