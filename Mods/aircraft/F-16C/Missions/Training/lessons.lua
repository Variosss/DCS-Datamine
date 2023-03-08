--[[ Designer Notes. This file defines the order the lessons are shown in the in-game list.
       Explanations:
  ["file"] = "FileName.miz", - obligatory field.
  ["name"] = _("New Name"), - optional. Provides a key for ext localization. If omitted the name is taken from miz in proper locale.
  ["description"] = _("New Description"), - optional. Works same as "name" field but for description.
--]]--*end of notes*

lessons = 
{
	{
        ["file"] = "Lesson 2 - Aircraft Startup.miz",
        ["name"] = _("Lesson 1 - Aircraft Startup"),
        ["description"] = _("Welcome to this training lesson on starting up the Viper. In some missions, you will find yourself in a cold and dark Viper that you will need to bring to life. While this can be a rather long process as described in the manual, you can also enable the auto-start function. However, for this lesson, we’ll review the full startup procedure."),
    },
		{
        ["file"] = "Lesson 3 - Taxi and Takeoff.miz",
        ["name"] = _("Lesson 2 - Taxi and Takeoff"),
        ["description"] = _("In this lesson, we’re starting in a Viper that is already up and running, and we will learn how to taxi to the runway and take off."),
    },
		{
        ["file"] = "Lesson 4 - VFR Landing.miz",
        ["name"] = _("Lesson 3 - VFR Straight In Landing"),
        ["description"] = _("In this lesson, we’ll go over the basics of landing a Viper at an airfield in Visual Flight Rules (VFR) conditions using a straight-in approach. This will also be useful for the later Instrument Flight Rules (IFR) landing lesson."),
    },
		{
        ["file"] = "Lesson 5 - VFR Overhead Landing.miz",
        ["name"] = _("Lesson 4 - Overhead Break Landing"),
        ["description"] = _("In this lesson, we’ll start on the initial approach for an overhead break landing pattern.  This technique is the safest and most efficient way to recover a lot of aircraft quickly with minimum impact on airfield operations.  This is an advanced technique that requires familiarity with aircraft handling on approach.  Before flying this lesson, please make sure you are familiar with the procedures described in the VFR Landing lesson."),
    },
		{
        ["file"] = "Lesson 6 - Up Front Controls.miz",
        ["name"] = _("Lesson 5 - Up-Front Controls Introduction"),
        ["description"] = _("Now let’s dig a little deeper into how to control key aircraft systems.  We will have a look at the Up-Front Controls (UFC), the large bank of buttons and the small display at the top of the instrument panel.  These allow you to quickly access communications, navigation, IFF and other information in one place, without digging around on the cockpit panels."),
    },
		{
        ["file"] = "Lesson 11 - AIM-9 LM Air-Air Missles.miz",
        ["name"] = _("Lesson 6 - AIM-9 LM Air-Air Missiles"),
        ["description"] = _("In this training mission, you will learn how to employ the AIM-9 Sidewinder, heat seeking/IR-guided air-to-air missile (AAM) to shoot down target aircraft."),
    },
		{
        ["file"] = "Lesson 12 - AIM-120 BC Air-Air Missles.miz",
        ["name"] = _("Lesson 7 - AIM-120 B & C Air-Air Missiles"),
        ["description"] = _("In this training mission, you will learn how to employ the AIM-120 AMRAM, an active radar homing (AHR) air-to-air missile (AAM)."),
    },
		{
        ["file"] = "Lesson 13 - Air-Air TWS and LINK-16 Use.miz",
        ["name"] = _("Lesson 8 - AIM-120 using TWS & LINK-16"),
        ["description"] = _("In this lesson, you will learn how to use TWS to engage multiple targets simultaneously. Then you will use the F-16's LINK-16 data link (DL) to coordinate multi-target engagements with wingmen."),
    },
		{
        ["file"] = "Lesson 14 - Air-Air ACM and HMCS Use.miz",
        ["name"] = _("Lesson 9 - Air-Air ACM and HMCS"),
        ["description"] = _("In this lesson you will learn how to use the Air Combat Modes (ACM) of the F-16C's radar as well as its Helmeted Mounted Cueing System (HMCS) to shoot down targets that would otherwise be difficult to engage.  "),
    },
		{
        ["file"] = "Lesson 15 - NCTR.miz",
        ["name"] = _("Lesson 10 - NCTR"),
        ["description"] = _("In this lesson you will learn how to use IFF Mode 4 and Non-Cooperative Target Recognition (NTCR) to build situational awareness in air-to-air combat."),
    },
	    {
		["file"] = "Lesson 17 - SMS and CCIP Unguided Bombs.miz",
        ["name"] = _("Lesson 11 - SMS Page and CCIP with Unguided Bombs"),
        ["description"] = _("In this lesson, we’ll look at the CCIP mode for unguided free fall bombs. We will also have a close look at the SMS Page and functions that apply to all bombing modes."),
    },
		{
		["file"] = "Lesson 18 - CCIP Post Designate.miz",
        ["name"] = _("Lesson 12 - 'Post-Designate' CCIP with HD Bombs"),
        ["description"] = _("Today, we are going to look at the ‘post-designate’ CCIP mode that is used when the computed impact point is outside the HUD field of view. This happens most often when bombing in a shallow dive or when high drag bombs are loaded. We will also have a look at high drag bombs in a ripple release."),
	},
		{
		["file"] = "Lesson 19 - CCRP Cluster Bombs.miz",
        ["name"] = _("Lesson 13 - CCRP Bombing with Cluster Bombs"),
        ["description"] = _("The Continuously Computed Release Point (CCRP) bombing mode provides computed, automatic release of bombs.  We have unguided bombs loaded again for this lesson but this is the primary mode used when dropping laser guided bombs.  We will also look at two diffetent types of Cluster Bombs and their functions."),
    },
		{
		["file"] = "Lesson 20 - AGM-65 Maverick.miz",
        ["name"] = _("Lesson 14 - AGM-65 Maverick Training"),
        ["description"] = _("In this training you will be presented with four structured tactical scenarios. Each will stress one aspect of AGM-65 employment."),
    },
	{
		["file"] = "Lesson 21 - AGM-88C HARM AS Sensor HAS.miz",
        ["name"] = _("Lesson 15 - AGM-88C HARM AS Sensor HAS"),
        ["description"] = _("In this training you will be presented with two structured tactical scenarios. You will be required to adjust the AGM-88C HAS settings in order to optimize threat detection."),
    },
	{
		["file"] = "Lesson 22 - AGM-88C POS-RUK.miz",
        ["name"] = _("Lesson 16 - AGM-88C HARM AS Sensor POS-RUK"),
        ["description"] = _("In this training you will learn to employ the AGM-88 HARM using the POS-RUK mode."),
    },
		{
		["file"] = "Lesson 23 - AGM-88C HARM PB and EOM.miz",
        ["name"] = _("Lesson 17 - AGM-88C POS PB and EOM Training"),
        ["description"] = _("In this lesson you will learn to employ the AGM-88C HARM in POS PB and EOM modes. "),
    },
		{
		["file"] = "Lesson 24 - JDAM Employment.miz",
        ["name"] = _("Lesson 18 - JDAM Employment"),
        ["description"] = _("In this lesson you will learn to employ the JDAMs. "),
    },
		{
		["file"] = "Lesson 25 - JSOW Employment.miz",
        ["name"] = _("Lesson 19 - JSOW Employment"),
        ["description"] = _("In this lesson you will learn to employ the JSOWs. "),
    },
		{
		["file"] = "Lesson 26 - ESM ECM Employment.miz",
        ["name"] = _("Lesson 20 - ESM / ECM Employment"),
        ["description"] = _("In this lesson you will learn to employ the F-16C's Electronic Support Measures (ESM) and Electronic Counter-Measures (ECM)."),
    },
		{
		["file"] = "Lesson 27 - VIP and PUP.miz",
        ["name"] = _("Lesson 21 - VIP and PUP Employment"),
        ["description"] = _("In this lesson you will learn how use the F-16Cs navigation functions Visual Initial Point (VIP) and Pop-Up Point (UP) in a CCRP bombing attack."),
    },
} -- end of lessons

