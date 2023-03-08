local count = 0
local function counter()
	count = count + 1
	return count
end

count = -1
local ASTERISKS_POS =
{
	LABEL			= counter();
	TARGET_NUMBER   = counter();
    TARGET_BEARING  = counter();
    RANGE           = counter();
    ELEVATION       = counter();
}

--function addText(name, text, pos, inv, parent, controllers, formats)
addText("Target to VRP Label",		        "",						{6, 0}, {"DED_VRP_ModeSelected"}, nil, {{"DED_VRP_PageLabel"}}, {"TGT-TO-VRP", "TGT-TO-PUP"})
addAsteriscs("Target to VRP Label Asteriscs",                       {5, 0}, 10, nil, {{"DED_VRP_AsterisksPos", ASTERISKS_POS.LABEL}})

addText("Target number",	                "TGT",					{5, 1})
addText("Target number value",	            "",						{10, 1}, {"DED_VRP_DataEntry_Inv", ASTERISKS_POS.TARGET_NUMBER}, nil, {{"DED_VRP_Number"}})
addAsteriscs("Target number Asteriscs",								{9, 1}, 3, nil, {{"DED_VRP_AsterisksPos", ASTERISKS_POS.TARGET_NUMBER}})
addText("Target number up down arrows",		"a",					{14, 1})

addText("Target bearing",	                "TBRG",					{4, 2})
addText("Target bearing value",	            "",						{10, 2}, {"DED_VRP_DataEntry_Inv", ASTERISKS_POS.TARGET_BEARING}, nil, {{"DED_VRP_Bearing"}})
addAsteriscs("Target bearing Asteriscs",							{9, 2}, 6, nil, {{"DED_VRP_AsterisksPos", ASTERISKS_POS.TARGET_BEARING}})

addText("Range",							"RNG",					{5, 3})
addText("Range value",						"",						{10, 3}, {"DED_VRP_DataEntry_Inv", ASTERISKS_POS.RANGE}, nil, {{"DED_VRP_Range"}})
addAsteriscs("Range Asteriscs",										{9, 3}, 8, nil, {{"DED_VRP_AsterisksPos", ASTERISKS_POS.RANGE}})

addText("Elevation",						"ELEV",					{4, 4})
addText("Elevation value",					"",						{10, 4}, {"DED_VRP_DataEntry_Inv", ASTERISKS_POS.ELEVATION}, nil, {{"DED_VRP_Elevation"}})
addAsteriscs("Elevation Asteriscs",									{9, 4}, 8, nil, {{"DED_VRP_AsterisksPos", ASTERISKS_POS.ELEVATION}})