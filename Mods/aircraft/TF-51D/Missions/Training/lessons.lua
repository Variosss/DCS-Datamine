--[[ Designer Notes. This file defines the order the lessons are shown in the in-game list.
       Explanations:
  ["file"] = "FileName.miz", - obligatory field.
  ["name"] = _("New Name"), - optional. Provides a key for ext localization. If omitted the name is taken from miz in proper locale.
  ["description"] = _("New Description"), - optional. Works same as "name" field but for description.
--]]--*end of notes*

lessons = 
{
	{
        ["file"] = "1_Cockpit_TF51.miz",
        ["name"] = _("Cockpit Familiarization"),
        ["description"] = _("In this lesson, we will take a detailed look at the TF-51D cockpit."),
    },
	{
        ["file"] = "2_startup_TF51.miz",
        ["name"] = _("Engine Start Procedure"),
        ["description"] = _("In this lesson, we will practice starting the TF-51D from the ramp."),
    },
	{
        ["file"] = "3_taxi_TF51.miz",
        ["name"] = _("Taxi"),
        ["description"] = _("In this lesson, we will practice taxiing in the TF-51D."),
    },
	{
        ["file"] = "4_takeoff_TF51.miz",
        ["name"] = _("Takeoff Guided Practice"),
        ["description"] = _("In this lesson, we will practice taking off in the TF-51D with the help of the instructor."),
    },
	{
        ["file"] = "5_takeoff-solo_TF51.miz",
        ["name"] = _("Takeoff Solo Practice"),
        ["description"] = _("This is a solo mission, in which you can practice taking off on your own without help from the instructor."),
    },
	{
        ["file"] = "6_landing_TF51.miz",
        ["name"] = _("Landing"),
        ["description"] = _("In this lesson, we will practice landing the TF-51D using a visual approach, followed by the shut down procedure."),
    }, 
  } -- end of lessons
