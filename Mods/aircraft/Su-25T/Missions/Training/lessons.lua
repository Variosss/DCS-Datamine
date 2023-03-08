--[[ Designer Notes. This file defines the order the lessons are shown in the in-game list.
       Explanations:
  ["file"] = "FileName.miz", - obligatory field.
  ["name"] = _("New Name"), - optional. Provides a key for ext localization. If omitted the name is taken from miz in proper locale.
  ["description"] = _("New Description"), - optional. Works same as "name" field but for description.
--]]--*end of notes*

lessons = 
{
	{
        ["file"] = "01- Su-25T Start Up.miz",
        ["name"] = _("Aircraft Start-Up, Taxi, and Takeoff"),
        ["description"] = _("In this lesson, we will practice starting the Su-25T from the ramp, taxi to the runway, and takeoff."),
    },
	{
        ["file"] = "02- Su-25T Flight and Navigation.miz",
        ["name"] = _("Basic Flight Controls and Navigation"),
        ["description"] = _("In this lesson, we will learn about the basic flight controls of the Su-25T, how to navigate between waypoints, and how to select autopilot modes."),
    },
	{
        ["file"] = "03- Su-25T Landing - Easy.miz",
        ["name"] = _("Landing - Easy"),
        ["description"] = _("In this lesson, we will learn how to navigate to an airfield and land at it under good conditions."),
    },
	{
        ["file"] = "04- Su-25T Landing - Difficult.miz",
        ["name"] = _("Landing - Difficult"),
        ["description"] = _("In this lesson, we will learn how to navigate to an airfield and land at it under poor conditions."),
    },
	{
        ["file"] = "05- Su-25T CCIP Mode Unguided Bombs.miz",
        ["name"] = _("CCIP Mode, Unguided Bombing"),
        ["description"] = _("In this lesson, we are going to learn how to deliver unguided bombs using Continuously Computed Impact Point (CCIP) mode."),
    },
	{
        ["file"] = "06- Su-25T CCRP Mode Unguided Bombs.miz",
        ["name"] = _("CCRP Mode, Unguided Bombing"),
        ["description"] = _("In this lesson, we are going to learn how to deliver unguided bombs using Continuously Computed Release Point (CCRP) mode."),
    },
	{
        ["file"] = "07- Su-25T KMGU Submunitions Dispenser.miz",
        ["name"] = _("KMGU Submunitions Dispenser"),
        ["description"] = _("In this lesson, we will learn to employ the KMGU submunitions dispenser."),
    },
    {
        ["file"] = "08- Su-25T Unguided Rockets.miz",
        ["name"] = _("Unguided Rockets"),
        ["description"] = _("In this lesson, we are going to learn how to employ unguided rockets."),
    },
	{
        ["file"] = "09- Su-25T Internal 30 mm Cannon.miz",
        ["name"] = _("Internal Cannon"),
        ["description"] = _("In this lesson, we will learn to use the internal, twin barrel GSh-20 30mm cannon."),
    },
	{
        ["file"] = "10- Su-25T Gun Pods.miz",
        ["name"] = _("Gun Pods"),
        ["description"] = _("In this lesson, we will learn to use the SPPU-22-1 gun pods."),
    },
	{
        ["file"] = "11- Su-25T Shkval Assisting Guided Bombs and Missiles.miz",
        ["name"] = _("Shkval Sensor with Kh-29T and KAB-500Kr"),
        ["description"] = _("In this lesson, you will learn how to use the Shkval sensor, the Kh-29T guided-missile and the KAB-500Kr guided-bomb."),
    },
	{
        ["file"] = "12- Su-25T Kh-29L, Kh-25ML and S-25L Laser Guided Missiles.miz",
        ["name"] = _("Kh-29L, Kh-25ML, and S-25L Laser-Guided Missiles"),
        ["description"] = _("In this lesson, you will learn how to employ the Kh-29L, Kh-25ML, and S-25L laser-guided missiles."),
    },
	{
        ["file"] = "13- Su-25T Vikhr Laser Guided Missile and Mercury Pod.miz",
        ["name"] = _("Vikhr Laser Guided Missile and Mercury Pod"),
        ["description"] = _("In this lesson, you will learn how to use the Vikhr laser-guided anti-tank missile and the Mercury night vision pod."),
    },
	{
        ["file"] = "14- Su-25T Anti-Radiation Missiles, RWR and Countermeasures.miz",
        ["name"] = _("Anti-Radar Missiles, RWR and Countermeasures"),
        ["description"] = _("In this lesson, you will learn how to interpret the radar warning receiver, how to use the countermeasure systems of the Su-25T, and how to employ the Kh-58U and Kh-25MPU anti-radar missiles."),
    },
    {
        ["file"] = "15- Su-25T Air-to-Air.miz",
        ["name"] = _("Air-to-Air Missiles"),
        ["description"] = _("In this lesson, you will learn to use the R-60M and R-73 infrared-guided, short-range air-to-air missiles."),
    },
} -- end of lessons
