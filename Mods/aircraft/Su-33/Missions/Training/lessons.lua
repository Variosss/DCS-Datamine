--[[ Designer Notes. This file defines the order the lessons are shown in the in-game list.
       Explanations:
  ["file"] = "FileName.miz", - obligatory field.
  ["name"] = _("New Name"), - optional. Provides a key for ext localization. If omitted the name is taken from miz in proper locale.
  ["description"] = _("New Description"), - optional. Works same as "name" field but for description.
--]]--*end of notes*

lessons = 
{
	{
        ["file"] = "Su-33 - Carrier Take-Off.miz",
        ["name"] = _("Su-33 - Carrier Take-Off"),
        ["description"] = _("This tutorial mission shows you how to start-up, taxi and take-off from the deck of the Admiral Kuznetzov."),
    },
	{
        ["file"] = "Su-33 - Carrier Short Take-Off.miz",
        ["name"] = _("Su-33 - Carrier Short Take-Off"),
        ["description"] = _("This tutorial mission shows you how to start-up and then take-off from the short position at the front of the Admiral Kuznetzov."),
    },
	{
        ["file"] = "Su-33 - Carrier Landing.miz",
        ["name"] = _("Su-33 - Carrier Landing"),
        ["description"] = _("In this lesson we're going to learn how to land on the Admiral Kuznetsov aircraft carrier."),
    },      
	{
        ["file"] = "Su-33 - Very Quick - Carrier Short Take-Off.miz",
        ["name"] = _("Su-33 - Very Quick - Carrier Short Take-Off"),
        ["description"] = _("This very short tutorial has you starting on the deck in the short take-off position with engines running. Use and replay this mission to gain confidence in using the short takeoff positions."),
    },
} -- end of lessons
