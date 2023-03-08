vdata = 
{
    name_ru = "Зима. Oблачность",
    name_de = "Winter, Wolken und Wind",
    name_es = "Invierno. Nubes y viento",
    name_fr = "Hiver, nuages et vent",
	name_cn = "冬季 多云+有风",
	wind = 
    {
        at8000 = 
        {
            speed = 7,
            dir = 206,
        }, -- end of at8000
        at2000 = 
        {
            speed = 5,
            dir = 130,
        }, -- end of at2000
        atGround = 
        {
            speed = 3,
            dir = 257,
        }, -- end of atGround
    }, -- end of wind
    groundTurbulence = 7,
    season = 
    {
        temperature = -1,
    }, -- end of season
    qnh = 750,
    name = "Winter. Clouds & wind",
	enable_fog = false,
	fog = 
	{
		density = 0,
        visibility = 0,
        thickness = 0,
	},
    clouds = 
    {
        thickness = 1600,
        density = 5,
        base = 2000,
        iprecptns = 0,
    }, -- end of clouds
} -- end of vdata
