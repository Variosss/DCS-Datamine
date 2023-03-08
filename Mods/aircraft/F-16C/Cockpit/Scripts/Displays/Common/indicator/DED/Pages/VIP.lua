local count = 0
local function counter()
	count = count + 1
	return count
end

count = -1
local ASTERISKS_POS =
{
	LABEL			= counter();
	VIP_NUMBER   	= counter();
    TRUE_BEARING  	= counter();
    RANGE           = counter();
    ELEVATION       = counter();
}

--function addText(name, text, pos, inv, parent, controllers, formats)
addText("Visual initial point to TGT Label",	"",						{6, 0}, {"DED_VIP_ModeSelected"}, nil, {{"DED_VIP_PageLabel"}}, {"VIP-TO-TGT", "VIP-TO-PUP"})
addAsteriscs("VIP to TGT Label Asteriscs",             		       	  	{5, 0}, 10, nil, {{"DED_VIP_AsterisksPos", ASTERISKS_POS.LABEL}})

addText("Visual initial point number",	    	"VIP",					{5, 1})
addText("VIP number value",	           		 	"",						{10, 1}, {"DED_VIP_DataEntry_Inv", ASTERISKS_POS.VIP_NUMBER}, nil, {{"DED_VIP_Number"}})
addAsteriscs("VIP number Asteriscs",									{9, 1}, 3, nil, {{"DED_VIP_AsterisksPos", ASTERISKS_POS.VIP_NUMBER}})
addText("VIP number up down arrows",			"a",					{14, 1})

addText("VIP bearing",	               			"TBRG",					{4, 2})
addText("VIP bearing value",	            	"",						{10, 2}, {"DED_VIP_DataEntry_Inv", ASTERISKS_POS.TRUE_BEARING}, nil, {{"DED_VIP_Bearing"}})
addAsteriscs("VIP bearing Asteriscs",									{9, 2}, 6, nil, {{"DED_VIP_AsterisksPos", ASTERISKS_POS.TRUE_BEARING}})

addText("Range",								"RNG",					{5, 3})
addText("Range value",							"",						{12, 3}, {"DED_VIP_DataEntry_Inv", ASTERISKS_POS.RANGE}, nil, {{"DED_VIP_Range"}})
addAsteriscs("Range Asteriscs",											{11, 3}, 4, nil, {{"DED_VIP_AsterisksPos", ASTERISKS_POS.RANGE}})
addText("Range NM",								"NM",					{17, 3})

addText("Elevation",							"ELEV",					{4, 4})
addText("Elevation value",						"",						{10, 4}, {"DED_VIP_DataEntry_Inv", ASTERISKS_POS.ELEVATION}, nil, {{"DED_VIP_Elevation"}})
addAsteriscs("Elevation Asteriscs",										{9, 4}, 8, nil, {{"DED_VIP_AsterisksPos", ASTERISKS_POS.ELEVATION}})