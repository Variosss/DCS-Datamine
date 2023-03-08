--[[ Designer Notes. This file defines the order the lessons are shown in the in-game list.
       Explanations:
  ["file"] = "FileName.miz", - obligatory field.
  ["name"] = _("New Name"), - optional. Provides a key for ext localization. If omitted the name is taken from miz in proper locale.
  ["description"] = _("New Description"), - optional. Works same as "name" field but for description.
--]]--*end of notes*

lessons = 
{
    {
        ["file"] = "UH-1H-TR-startup.miz",
        ["name"] = _("Cold Start"),
        ["description"] = _("In this lesson, we will practice starting the Huey from the ramp."),
    }, -- end of [1]
    {
        ["file"] = "UH-1H-TR-pickup.ogv",
        ["name"] = _("Pickup Demonstration"),
        ["description"] = _("This is a video demonstration lesson overviewing the helicopter pickup from the ground into a low altitude hover."),
    }, -- end of [2]
    {
        ["file"] = "UH-1H-TR-takeoff.ogv",
        ["name"] = _("Takeoff Demonstration"),
        ["description"] = _("This is a video demonstration lesson overviewing the transition from a low altitude hover to forward flight as part of the Huey takeoff procedure."),
    }, -- end of [3]
    {
        ["file"] = "UH-1H-TR-takeoff-solo.miz",
        ["name"] = _("Pickup and Takeoff Solo Practice"),
        ["description"] = _("This is a solo flight mission in which you can practice the Pickup and Takeoff without help from the instructor."),
    }, -- end of [4]
    {
        ["file"] = "UH-1H-TR-landing.ogv",
        ["name"] = _("Landing Demonstration"),
        ["description"] = _("This is a video demonstration lesson overviewing the approach and landing in the Huey."),
    }, -- end of [5]
    {
        ["file"] = "UH-1H-TR-landing-solo.miz",
        ["name"] = _("Landing Solo Practice"),
        ["description"] = _("This is a solo flight mission in which you can practice the approach and landing without help from the instructor."),
    }, -- end of [6]
    {
        ["file"] = "UH-1H-TR-weapons.miz",
        ["name"] = _("Weapons Employment"),
        ["description"] = _("In this lesson, we will overview and practice employing the weapon systems equipped on the Huey."),
    }, -- end of [7]
} -- end of lessons
