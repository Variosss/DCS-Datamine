--[[ Designer Notes. This file defines the order the lessons are shown in the in-game list.
       Explanations:
  ["file"] = "FileName.miz", - obligatory field.
  ["name"] = _("New Name"), - optional. Provides a key for ext localization. If omitted the name is taken from miz in proper locale.
  ["description"] = _("New Description"), - optional. Works same as "name" field but for description.
--]]--*end of notes*

lessons = 
{
	{
        ["file"] = "Lesson 1-Introduction and Basic Controls.miz",
        ["name"] = _("Introduction and Basic Controls"),
        ["description"] = _("Hello and welcome to this training course on the F/A-18C Hornet. These interactive training lessons are a supplement to the manual and will provide a hands-on means of learning this aircraft. Whilst learning the Hornet may seem a dauting task at first, these lessons are broken down into small chunks to allow you to better absorb the material.\n\nThis first training mission contains a general introduction to the aircraft and its basic controls."),
    },
	{
        ["file"] = "Lesson 2-Cold Start.miz",
        ["name"] = _("Cold Start"),
        ["description"] = _("Welcome to this training lesson on starting up the Hornet. In some missions, you will find yourself in a cold and dark Hornet that you will need to bring to life. While this can be a rather long process as described in the manual, you can also enable the auto-start function. However, for this lesson, we'll review the full startup procedure."),
    },
	{
        ["file"] = "Lesson 3-Taxi and Takeoff.miz",
        ["name"] = _("Taxi and Takeoff"),
        ["description"] = _("In this lesson, we're starting in an up and running Hornet, and we will learn how to taxi to the runway and take off."),
    },
	{
        ["file"] = "Lesson 4-HSI Overview and TACAN-ADF Navigation.miz",
        ["name"] = _("HSI Overview and TACAN-ADF Navigation"),
        ["description"] = _("A key part of any mission is the ability to navigate to and from the target. Two such tools the Hornet provides are Automatic Direction Finding, or ADF, and Tactical Air Navigation, or TACAN. ADF uses VOR stations located throughout the maps to get bearing-only information to them, and TACAN stations are co-located with many airfields, aircraft carriers and some aerial refuelers. TACAN can provide both bearing and range, or just one of them depending on the source and TACAN mode used."),
    },
	{
        ["file"] = "Lesson 5-Waypoint Navigation.miz",
        ["name"] = _("Waypoint Navigation"),
        ["description"] = _("While TACAN navigation is a great tool to get back to your airfield or carrier, many times you will need the ability to set arbitrary navigation points. This is where waypoint navigation comes in. The Hornet allows you to have three sequences of waypoints that you could use to mark anything from a turn point, to a target, or to a threat location. Waypoints can be created in both the Mission Editor and while in the Hornet cockpit. For this lesson though, we will focus on a waypoint sequence already created."),
    },
	{
        ["file"] = "Lesson 6-VFR Airfield Straight In Landing.miz",
        ["name"] = _("VFR Airfield Straight In Landing"),
        ["description"] = _("In previous lessons we learned how to take off and navigate, but what goes up, must come down. In this lesson, we'll go over the basics of landing a Hornet at an airfield in Visual Flight Rules (VFR) conditions using a straight-in approach. This will also be useful for the later Instrument Flight Rules (IFR) landing lesson."),
    },
	{
        ["file"] = "Lesson 7-VFR Airfield Overhead Pattern Landing.miz",
        ["name"] = _("VFR Airfield Overhead Pattern Landing"),
        ["description"] = _("In the previous lesson, we learned how to perform a simple, straight-in landing during VFR conditions. In this lesson, we're going to learn how to perform an overhead landing pattern. This should be your usual VFR landing pattern, and it will be very similar to the Case I and Case II landing pattern you'll use to land on the boat."),
    },
	{
        ["file"] = "Lesson 8-IFR Airfield Approach.miz",
        ["name"] = _("Instrument Approach Airfield Landing"),
        ["description"] = _("When Visual Flight Rules (VFR) conditions are not present, such as at night or foul weather, an instrument approach landing is used. As the name implies, this relies on the instruments of the Hornet to provide a correct azimuth and glideslope approach to the selected airfield. Although the US Navy Hornet in DCS World has the Instrument Carrier Landing Systems, or ICLS, this is only used for carrier landings and not airfield landings. Even in the real world, US Hornets do not have ILS. As such, we’ll instead use a TACAN  approach azimuth and a standard 3-degree glideslope from a known Distance Measuring Equipment (DME) and altitude."),
    },
	{
        ["file"] = "Lesson 9-Carrier Taxi and Takeoff.miz",
        ["name"] = _("Carrier Taxi and Takeoff"),
        ["description"] = _("In this lesson we will learn to taxi to an aircraft carrier catapult and takeoff. In a previous lesson we learned how to start up the Hornet, so we will be starting in a “hot” aircraft."),
    },
	{
        ["file"] = "Lesson 10-Case I Carrier Landing.miz",
        ["name"] = _("Case I Carrier Landing"),
        ["description"] = _("Today we will perform a Case I, Case II carrier landing. This will be very similar to the VFR field overhead pattern. In fact, Navy pilots land at airfields much like they do on the boat to maintain this perishable skill. "),
    },
	{
        ["file"] = "Lesson 11-AA Gun.miz",
        ["name"] = _("Air-to-Air M61A2 Gun"),
        ["description"] = _("Welcome to this training lesson on use of the Hornet’s M61A2 20mm cannon. Mounted in the nose of the aircraft, it can be loaded with up to 578 rounds and has a firing rate of either 4,000 or 6,000 round per minute. When too close for missiles, the gun is a great option in a dogfight."),
    },
	{
        ["file"] = "Lesson 12-AIM-9LM.miz",
        ["name"] = _("AIM-9L and M Sidewinder Air-to-Air Missile"),
        ["description"] = _("In this lesson we’ll learn how to use the AIM-9L and M versions of the venerable Sidewinder short-range, infrared-guided, air-to-air missile. Using a cooled-infrared seeker, the Sidewinder locks onto the “hot” elements of a target, most often the engines. Best used in close-range dogfights, the Sidewinder is fire-and-forget after launch. However, the Sidewinder can be decoyed be flares and is less effective against ground clutter."),
    },
	{
        ["file"] = "Lesson 13-AIM-120BC.miz",
        ["name"] = _("AIM-120B and C Advanced Medium Range Air-to-Air Missile"),
        ["description"] = _("In this lesson we’ll explore employment of the Advanced Medium Range Air to Air missile, or AMRAAM. The AMRAAM replaced the older AIM-7 Sparrow with improved range, guidance, weight, and an embedded radar-seeker in the nose cone. This allows the AMRAAM to guide on a target without support from the host-aircraft as the missile closes with the target. This in turn allows the launch aircraft to maneuver without loss of missile guidance to the target. The AMRAAM can be cued to targets with the Hornet’s radar, or it can be launched at close-range just using the missile’s seeker. As with all air-to-air missiles, engagement range is highly dependent on engagement aspect, launch altitude, and launch speed. You will see much greater ranges at 30,000 feet on a closing target than 5,000 feet on a receding target."),
    },
	{
        ["file"] = "Lesson 14-AG Gun.miz",
        ["name"] = _("Air-to-Ground M61A2 Gun"),
        ["description"] = _("Welcome to this training lesson on use of the Hornet’s M61A2 20mm cannon against ground targets. Mounted in the nose of the aircraft, it can be loaded with up to 578 rounds and has a firing rate of either 4,000 rounds or 6,000 round per minute. When you need precise fire against unarmed or lightly armed targets, the gun can be a great choice."),
    },
	{
        ["file"] = "Lesson 15-Rockets.miz",
        ["name"] = _("Unguided Rockets"),
        ["description"] = _("In this lesson we’ll look at the use of unguided rockets. Like the A/G gun, it’s a simple point and shoot weapon system best used against unarmed and lightly armed targets. It’s an area effect weapon and not designed for precision attack. As such, it’s often used in a ripple fire mode in which all rockets in a pod are fired at once. However, you can also fire one rocket at time."),
    },
	{
        ["file"] = "Lesson 16-CCIP Mode Bombing.miz",
        ["name"] = _("CCIP Bombing Mode"),
        ["description"] = _("Today we’re going to start dropping some iron. On our jet we have Mk-83 1,000 lbs and Mk-84 2,000 lbs high-explosive, unguided bombs. These can be delivered in Manual, Continuously Computed Impact Point, or CCIP, and Automatic, or AUTO, release modes. These modes will also apply to other bombs like canister munitions and high-drag bomb modes. In this lesson, we’ll look at the CCIP modes for free fall bombs. For this lesson, we will dive into CCIP release mode."),
    },
	{
        ["file"] = "Lesson 17-Manual Mode Bombing.miz",
        ["name"] = _("Manual Bombing Mode"),
        ["description"] = _("Like A/G Gun and rockets, we can also have a manual mode for unguided bombs. We can set fixed gun reticle on the HUD to an entered mil depression. By using a set mil value with a bomb release dive angle, altitude and airspeed, it can be a handy delivery method when CCIP and AUTO modes are not available."),
    },
	{
        ["file"] = "Lesson 18-AUTO Mode Bombing.miz",
        ["name"] = _("AUTO Bombing Mode"),
        ["description"] = _("The third bombing mode to discuss is automatic, or AUTO, bombing. This is like a mode you may be familiar with in the A-10C called CCRP mode. It allows accurate delivery of a weapon based on a designated target (TGT) point. This target point can be a waypoint, designated on the HUD, or set with another sensor. Today, we’ll look at setting up a target point using a waypoint and the HUD. Then we will deliver a bomb on that location. The big advantage of AUTO mode is that you can deliver a bomb in level flight, and it is most often used for guided bombs like laser- and GPS-guided systems. However, you can still use for unguided bombs."),
    },
	{
        ["file"] = "Lesson 19-High Drag Bombing.miz",
        ["name"] = _("High Drag Bombing"),
        ["description"] = _("When needing to drop bombs at low altitudes, high drag bombs like the Mk-82 SnakeEye and Mk-82 Ballute are great tools. The fins of the SnakeEye and the chute of the Ballute allow the aircraft to drop at very low altitudes but be far away from the blast by the time the bomb impacts."),
    },
	{
        ["file"] = "Lesson 20-Canister Munitons Bombing.miz",
        ["name"] = _("Canister Munition Bombing"),
        ["description"] = _("In addition to high-explosive general-purpose bombs like Mk-82, 83, and 84, you also have canister munitions at your disposal. Also termed cluster bombs, the F/A-18C can carry the Mk-20 Rockeye II, CBU-99, and CBU-100. All three munitions carry 247 Mk-118 Mod 1 bomblets. The Mk-118 bomblet contains a shaped-charged warhead, designed for anti-armor use. As such, these bomblets are good at defeating armor but have very little proximity damage effect. To be effective, the bomblet must directly hit the target. The three versions of the munition only differ in their canister an fuses."),
    },
{
        ["file"] = "Lesson 22-AGM-88C PB and SP.miz",
        ["name"] = _("AGM-88C HARM PB and SP Modes"),
        ["description"] = _("In this lesson you will learn to employ the AGM-88C HARM in PB mode; with aircraft and missile “Pull Up” profiles."),
    },
{
        ["file"] = "Lesson 23-GPS Weapon Programing.miz",
        ["name"] = _("GPS Weapons Data Entry"),
        ["description"] = _("In this lesson you will learn how to set up GPS guided weapons - JDAM, JSOW, SLAM/SLAM-ER - in Pre Planned mode."),
    },
{
        ["file"] = "Lesson 24-JDAM Employment.miz",
        ["name"] = _("JDAM Employment"),
        ["description"] = _("In this lesson you will learn how to employ JDAM munitions in the Pre-Planned and Target Of Opportunity modes, as well as how to conduct a sensor-handoff JDAM attack. [Training Lesson FA-18C GPS Weapon Data Entry is a prerequisite for this training mission."),
    },
{
        ["file"] = "Lesson 25-JSOW Employment.miz",
        ["name"] = _("JSOW Employment"),
        ["description"] = _("In this lesson you will learn to employ the Joint Stand Off Weapon (JSOW; AGM-154A and AGM-154C) in both Pre-Planned (PP) and Target of Opportunity (TOO) modes. FA-18C GPS Weapons Data Entry is a prerequisite for this training mission."),
    },
} -- end of lessons
