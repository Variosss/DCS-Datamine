local gettext = require("i_18n")
_ = gettext.translate

times =
{
	["dawn"] =
	{
		["name"] = _("dawn"),
		["Caucasus"] = 
		{
			["summer"] = 18000,
			["winter"] = 28000,
			["spring"] = 20000,
			["autumn"] = 20000,
		},
		["Normandy"] = 
		{
			["summer"] = 23000,
			["winter"] = 34000,
			["spring"] = 28000,
			["autumn"] = 28000,
		},
		["Nevada"] = 
		{
			["summer"] = 14000,
			["winter"] = 22000,
			["spring"] = 16000,
			["autumn"] = 16000,
		},
		["LasVegas"] = 
		{
			["summer"] = 16500,
			["winter"] = 27000,
			["spring"] = 22000,
			["autumn"] = 22000,
		},
		["Dubai"] = 
		{
			["summer"] = 21500,
			["winter"] = 27000,
			["spring"] = 24000,
			["autumn"] = 24000,
		},
		["Islands"] = 
		{
			["summer"] = 21500,
			["winter"] = 27000,
			["spring"] = 24000,
			["autumn"] = 24000,
		},
		["PersianGulf"] = 
		{
			["summer"] = 17000,
			["winter"] = 23000,
			["spring"] = 21000,
			["autumn"] = 21000,
		},
	},
	["midday"] =
	{
		["name"] = _("midday"),
		["Caucasus"] = 
		{
			["summer"] = 25000,
			["autumn"] = 26000,
			["winter"] = 35000,
			["spring"] = 26000
		},
		["Normandy"] = 
		{
			["summer"] = 59000,
			["autumn"] = 55000,
			["winter"] = 51000,
			["spring"] = 55000
		},
		["Nevada"] = 
		{
			["summer"] = 20000,
			["winter"] = 27000,
			["autumn"] = 22000,
			["spring"] = 22000,
		},
		["LasVegas"] = 
		{
			["summer"] = 48000,
			["autumn"] = 46000,
			["winter"] = 45000,
			["spring"] = 46000,
		},
		["Dubai"] = 
		{
			["summer"] = 46000,
			["autumn"] = 45000,
			["winter"] = 44000,
			["spring"] = 45000,
		},
		["Islands"] = 
		{
			["summer"] = 46000,
			["autumn"] = 45000,
			["winter"] = 44000,
			["spring"] = 45000,
		},
		["PersianGulf"] = 
		{
			["summer"] = 24000,
			["winter"] = 30000,
			["autumn"] = 25000,
			["spring"] = 25000,
		},
	},
	["evening"] =
	{
		["name"] = _("evening"),
		["Caucasus"] = 
		{
			["summer"] = 70000,
			["autumn"] = 67000,
			["winter"] = 60000,
			["spring"] = 67000,
		},
		["Normandy"] = 
		{
			["summer"] = 75000,
			["autumn"] = 80000,
			["winter"] = 86000,
			["spring"] = 80000,
		},
		["Nevada"] = 
		{
			["summer"] = 65000,
			["winter"] = 55000,
			["autumn"] = 63000,
			["spring"] = 63000,
		},
		["LasVegas"] = 
		{
			["summer"] = 66000,
			["autumn"] = 52000,
			["winter"] = 58000,
			["spring"] = 52000,
		},
		["Dubai"] = 
		{
			["summer"] = 66500,
			["autumn"] = 63000,
			["winter"] = 60000,
			["spring"] = 63000,
		},
		["Islands"] = 
		{
			["summer"] = 66500,
			["autumn"] = 63000,
			["winter"] = 60000,
			["spring"] = 63000,
		},
		["PersianGulf"] = 
		{
			["summer"] = 67000,
			["winter"] = 59000,
			["autumn"] = 61000,
			["spring"] = 61000,
		},
	},

	["night"] =
	{
		["name"] = _("night"),
		["Caucasus"] = 
		{
			["summer"] = 79000,
			["autumn"] = 74000,
			["winter"] = 68000,
			["spring"] = 74000,
		},
		["Normandy"] = 
		{
			["summer"] = 7000,
			["autumn"] = 7000,
			["winter"] = 7000,
			["spring"] = 7000,
		},
		["Nevada"] = 
		{
			["summer"] = 71000,
			["winter"] = 62000,
			["autumn"] = 68000,
			["spring"] = 68000,
		},
		["LasVegas"] = 
		{
			["summer"] = 7000,
			["autumn"] = 7000,
			["winter"] = 7000,
			["spring"] = 7000,
		},
		["Dubai"] = 
		{
			["summer"] = 7000,
			["autumn"] = 7000,
			["winter"] = 7000,
			["spring"] = 7000,
		},
		["Islands"] = 
		{
			["summer"] = 7000,
			["autumn"] = 7000,
			["winter"] = 7000,
			["spring"] = 7000,
		},
		["PersianGulf"] = 
		{
			["summer"] = 71000,
			["winter"] = 64000,
			["autumn"] = 66000,
			["spring"] = 66000,
		},
	},
}

seasons =
{
    [1] = 
    {
        id = "summer",
        name = _("Summer"),
		iseason = 1,
		temperature = {18, 32},
		daysOfYear = {0, 91},
        artificialDay = {22800, 75600},
    },
    [2] = 
    {
        id = "winter",
        name = _("Winter"),
		temperature = {-7, 5},
		iseason = 2,
        artificialDay = {23400, 66600},
        daysOfYear = {183, 274},
    },
    [3] = 
    {
        id = "autumn",
        name = _("Autumn"),
		temperature = {5, 25},
		iseason = 4,
        artificialDay = {27600, 64200},
        daysOfYear = {92, 182},
    },
    [4] = 
    {
        id = "spring",
        name = _("Spring"),
		temperature = {5, 25},
		iseason = 3,
        artificialDay = {22800, 75600},
        daysOfYear = {275, 365},
    },
}

weather = 
{
    [1] = 
    {
		iprecptns = {0, 0}, --осадки при температуре выше и ниже 0 (0 - без осадков, 1 - дождь, 2 - сильный дождь, 3 - снег, 4 - сильный снег)
		--cloudDensity = {0, 2}, --диапазон возможной облачности (от 0 до 10)
		cloudDensity = {0, 0}, -- Clear aways clear
        id = "clear", --идентификатор (любая уникальная в пределах таблицы строка)
        name = _('gen_Clear'), --название (отображается в редакторе)
		fileName = 'clear.mt' -- название файла с погодным шаблоном
	},
    [2] = 
    {
		iprecptns = {0, 0},
		cloudDensity = {3, 9},
        id = "cloudy",
        name = _("Cloudy"),
		fileName = 'cloudy.mt'
	},
    [3] = 
    {
		iprecptns = {1, 3},
		cloudDensity = {7, 9},
        id = "precipitation",
        name = _("Precipitation"),
		fileName = 'precipitation.mt'
	},
    [4] = 
    {
		iprecptns = {2, 4},
		cloudDensity = {9, 10},
        id = "storm",
        name = _("Storm"),
		fileName = 'storm.mt'
	},
}

localisedid = {
_("summer_gen","Summer"),
_("winter_gen","Winter"),
_("autumn_gen","Autumn"),
_("spring_gen","Spring"),
}