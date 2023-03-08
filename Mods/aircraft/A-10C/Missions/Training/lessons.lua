--[[ Designer Notes. This file defines the order the lessons are shown in the in-game list.
       Explanations:
  ["file"] = "FileName.miz", - obligatory field.
  ["name"] = _("New Name"), - optional. Provides a key for ext localization. If omitted the name is taken from miz in proper locale.
  ["description"] = _("New Description"), - optional. Works same as "name" field but for description.
--]]--*end of notes*

lessons = 
{
	{
        ["file"] = "A-10C-Training-Introduction.miz",
        ["name"] = _("Introduction to the A-10C"),
        ["description"] = _("In this lesson, we will briefly overview the A-10C."),
    },
	{
        ["file"] = "A-10C-Training-HOTAS-Fundamentals.miz",
        ["name"] = _("HOTAS Fundamentals"),
        ["description"] = _("In this lesson, we will overview essential cockpit control concepts."),
    },
	{
        ["file"] = "A-10C-Training-Start-Up.miz",
        ["name"] = _("Aircraft Start-up"),
        ["description"] = _("In this lesson, we will practice starting the A-10C from the ramp."),
    },
	{
        ["file"] = "A-10C-Training-Takeoff and Handling.miz",
        ["name"] = _("Takeoff and Basic Handling"),
        ["description"] = _("In this lesson, we will practice taking off in the A-10C and some basic maneuvers at medium altitude."),
    },
	{
        ["file"] = "A-10C-Training-Navigation.miz",
        ["name"] = _("Navigation"),
        ["description"] = _("In this lesson, we will review the navigation systems of the A-10C and practice navigation procedures."),
    },
	{
        ["file"] = "A-10C-Training-Landing.miz",
        ["name"] = _("Landing"),
        ["description"] = _("In this lesson, we will practice landing the A-10C using an ILS approach and review the shut-down procedure."),
    },
	{
        ["file"] = "A-10C-Training-DSMS.miz",
        ["name"] = _("Digital Stores Management System (DSMS)"),
        ["description"] = _("In this lesson, we will overview the Digital Stores Management System (DSMS) of the A-10C."),
    },
	{
        ["file"] = "A-10C-Training-TGP.miz",
        ["name"] = _("AN/AAQ-28 LITENING-II"),
        ["description"] = _("In this lesson, we will practice using the AN/AAQ-28 LITENING-II targeting pod against ground targets."),
    },
	{
        ["file"] = "A-10C-Training-Guns and Rockets.miz",
        ["name"] = _("GAU-8/A and Unguided Rockets"),
        ["description"] = _("In this lesson, we will overview employment of the GAU-8/A gun and unguided rockets carried by the A-10C."),
    }, 
    {
        ["file"] = "A-10C-Training-Unguided Bombs.miz",
        ["name"] = _("General Purpose Bombs"),
        ["description"] = _("In this lesson, we will overview the employment of unguided bombs in the A-10C."),
    },
	{
        ["file"] = "A-10C-Training-PGM.miz",
        ["name"] = _("Precision-Guided Munitions"),
        ["description"] = _("In this lesson, we will overview the employment of precision guided munitions in the A-10C."),
    },
	{
        ["file"] = "A-10C-Training-Maverick.miz",
        ["name"] = _("AGM-65 Maverick"),
        ["description"] = _("In this lesson, we will overview employment of the AGM-65 Maverick air-to-surface missile."),
    },
	{
        ["file"] = "A-10C-Training-Air to Air.miz",
        ["name"] = _("Air-to-air"),
        ["description"] = _("In this lesson, we will practice using the AN/AAQ-28 LITENING-II targeting pod in air-to-air mode and employment of AIM-9M short-range IR-guided air-to-air missiles and the GAU-8/A gun against airborne targets."),
    },
    {
        ["file"] = "A-10C-Training-Countermeasures.miz",
        ["name"] = _("Countermeasures (CMS)"),
        ["description"] = _("In this lesson, we will overview the countermeasures systems of the A-10C."),
    },
} -- end of lessons
