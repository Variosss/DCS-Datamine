vdata = 
{
    name_ru = "Зима. Oблачность и порывистый ветер",
    name_de = "Winter, Wolken und Windboen",
    name_es = "Invierno. Nubes y viento racheado",
    name_fr = "Hiver, nuages et vent",
	name_cn = "冬季 强风+多云",
    wind = 
    {
        at8000 = 
        {
            speed = 10,
            dir = 65,
        }, -- end of at8000
        at2000 = 
        {
            speed = 7,
            dir = 209,
        }, -- end of at2000
        atGround = 
        {
            speed = 5,
            dir = 129,
        }, -- end of atGround
    }, -- end of wind
    groundTurbulence = 17,
    season = 
    {
        temperature = -2,
    }, -- end of season
    qnh = 760,
    name = "Winter. Wind & clouds",
	enable_fog = false,
	fog = 
	{
		density = 0,
        visibility = 0,
        thickness = 0,
	},
    clouds = 
    {
        thickness = 760,
        density = 8,
        base = 2400,
        iprecptns = 0,
    }, -- end of clouds
} -- end of vdata
