local count = 0
local function counter()
	count = count + 1
	return count
end

count = -1
local ASTERISKS_POS =
{
	TGP_CODE		= counter();
	LST_CODE		= counter();
	ST_TIME			= counter();
}


addText("LASR LABEL",			"LASR",						{11, 0})

addText("TGP CODE LABEL",		"TGP CODE",					{1, 1})
addText("TGP CODE VALUE",		"",							{13, 1}, {"DED_LASR_DataEntry_Inv", ASTERISKS_POS.TGP_CODE}, nil, {{"DED_LASR_TGP_Code"}})
addAsteriscs("TGP CODE Asteriscs",							{12, 1}, 4, nil, {{"DED_LASR_AsterisksPos", ASTERISKS_POS.TGP_CODE}})

addText("LST CODE LABEL",		"LST CODE",					{1, 2})
addText("LST CODE VALUE",		"",							{13, 2}, {"DED_LASR_DataEntry_Inv", ASTERISKS_POS.LST_CODE}, nil, {{"DED_LASR_LST_Code"}})
addAsteriscs("LST CODE Asteriscs",							{12, 2}, 4, nil, {{"DED_LASR_AsterisksPos", ASTERISKS_POS.LST_CODE}})

addText("Laser ST Time LABEL",	"LASER ST TIME      SEC",	{1, 4})
addText("Laser ST Time VALUE",	"",							{16, 4}, {"DED_LASR_DataEntry_Inv", ASTERISKS_POS.ST_TIME}, nil, {{"DED_LASR_ST_Time"}})
addAsteriscs("Laser ST Time Asteriscs",						{15, 4}, 3, nil, {{"DED_LASR_AsterisksPos", ASTERISKS_POS.ST_TIME}})