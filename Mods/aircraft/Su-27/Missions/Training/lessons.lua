--[[ Designer Notes. This file defines the order the lessons are shown in the in-game list.
       Explanations:
  ["file"] = "FileName.miz", - obligatory field.
  ["name"] = _("New Name"), - optional. Provides a key for ext localization. If omitted the name is taken from miz in proper locale.
  ["description"] = _("New Description"), - optional. Works same as "name" field but for description.
--]]--*end of notes*

lessons = 
{
	{
        ["file"] = "Su-27 - Start Up.miz",
        ["name"] = _("Start Up"),
        ["description"] = _("Welcome to the Su-27 \"Flanker\". The \"Flanker\" is one of the most dominate air superiority fighters in modern-day combat aviation. Equipped with powerful sensors, weapons and a data link, it is match for any aircraft you may encounter in DCS World. In addition to its air-to-air capabilities, it also can perform a secondary ground strike role with unguided bombs and rockets. \
\
Follow instruction and learn the basics of starting up the Su-27."),
    },
	{
        ["file"] = "Su-27 - Flight and Navigation.miz",
        ["name"] = _("Flight and Navigation"),
        ["description"] = _("Welcome to this lesson on the basic flying and navigation of the Su-27. This lesson will teach you how to get from point A to point Z and all points in between. \
	\
Follow instruction and learn the basics of flying and navigating the Su-27."),
    }, 
    {
        ["file"] = "Su-27 - Landing - Easy.miz",
        ["name"] = _("Landing - Easy"),
        ["description"] = _("In this lesson we're going to learn how to navigate to an airfield and land on it.\
	\
Follow instruction and learn the basics of landing the Su-27"),
    },
	{
        ["file"] = "Su-27 - Landing - Difficult.miz",
        ["name"] = _("Landing - Difficult"),
        ["description"] = _("In the past two lessons we learned the basics of navigation and landing under ideal conditions. In this lesson, we're going to put what you learned to the test by finding an airfield and landing at night during a thunderstorm.\
	\
Follow instruction and learn the basics of landing the Su-27 at night in bad weather."),
    },
	{
        ["file"] = "Su-27 - RWR and Countermeasures.miz",
        ["name"] = _("RWR and Countermeasures"),
        ["description"] = _("In this lesson, we're going to take a look at the SPO-15 \"Beryoza\" Radar Warning Receiver, or RWR. We'll also talk about the countermeasure systems at your disposal.\
\
Follow instruction and learn the basics of using radar warning receiver and expendable countermeasures."),
    },
	{
        ["file"] = "Su-27 - CCIP Mode Unguided Bombs.miz",
        ["name"] = _("CCIP Mode Unguided Bombs"),
        ["description"] = _("In this lesson, we're going to learn how to deliver unguided bombs in the Continuously Computed Impact Point, or CCIP.\
\
Follow instruction and learn the basics of putting bombs on target using the CCIP bombing mode."),
    },
	{
        ["file"] = "Su-27 - CCRP Mode Unguided Bombs.miz",
        ["name"] = _("CCRP Mode Unguided Bombs"),
        ["description"] = _("In the previous lesson, we learned how to put bombs on target using CCIP mode. In this lesson, we'll learn how to do it using the Continuously Computed Release Point mode, or CCRP.\
\
Follow instruction and learn the basics of putting bombs on target using the CCRP bombing mode."),
    },
	{
        ["file"] = "Su-27 - KMGU Submunitions Dispenser.miz",
        ["name"] = _("Dispenser Bombing"),
        ["description"] = _("In addition to the unguided bombs we used in the previous lessons, we also have the KMGU submunitions dispenser. In this lesson, we will learn how to use them.\
\
Follow instruction and learn the basics of using the KMGU submunition dispensers."),
    },
	{
        ["file"] = "Su-27 - Unguided Rockets.miz",
        ["name"] = _("Unguided Rockets"),
        ["description"] = _("Now that we're getting the hang of unguided bomb delivery, we're going move on to using unguided rockets.\
\
Follow instruction and learn the basics of using unguided rockets."),
    },
	{
        ["file"] = "Su-27 - Strafe.miz",
        ["name"] = _("Strafe"),
        ["description"] = _("In this lesson, we're going to learn how to use the internal 30mm cannon. \
\
Follow instruction and learn the basics of using the internal cannon against ground targets."),
    }, 
    {
        ["file"] = "Su-27 - Sensors Scan Mode.miz",
        ["name"] = _("Sensors Scan Mode"),
        ["description"] = _("In this lesson, we will learn how to use the two sensors of the Su-27: the N001 pulse Doppler radar and the OLS-27 Infrared Search and Track system, or IRST to search for targets.\
\
Follow instruction and learn the basics of using the radar and IRST in search mode."),
    }, 
    {
        ["file"] = "Su-27 - Missiles.miz",
        ["name"] = _("Air-to-Air Missile Engagement"),
        ["description"] = _("In this lesson, we will build upon what we learned using the radar scan mode to locate targets, lock them up with sensors, and launch a missile at it.\
\
Follow instruction and learn the basics of using radar and infrared guided missiles."),
    },
    {
        ["file"] = "Su-27 - Close Air Combat Radar Modes.miz",
        ["name"] = _("Close Air Combat Radar Modes and HMS"),
        ["description"] = _("When within visual range of enemy aircraft, it is time to transition from beyond visual range radar scan mode to one of the Close Air Combat (CAC) modes. In this lesson, we will learn about the different CAC modes and the helmet mounted sight.\
\
Follow instruction and learn the basics of using the CAC modes and the HMS."),
    },
    {
        ["file"] = "Su-27 - Aerial Gunnery.miz",
        ["name"] = _("Aerial Gunnery"),
        ["description"] = _("In this lesson, we are going to learn how to use the 30 mm cannon to shoot down other aircraft. We can do so with and without first getting a radar lock.  \
\
Follow instruction and learn the basics of using the cannon in air-to-air mode."),
    },
} -- end of lessons
