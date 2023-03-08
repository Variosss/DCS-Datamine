
addLocalPlaceholder("HTS_DED_ROOT", nil, {{"DED_HTS_isShow"}})

addText("HTS", "SEAD", {4,0}, nil, "HTS_DED_ROOT")

addText("HTS_LAT_lbl",							"LAT",				{2, 1}, nil, "HTS_DED_ROOT")
addText("HTS_LAT",								"N XXoXX.X'",		{7, 1}, nil, "HTS_DED_ROOT", {{"DED_HTS_LAT"}})

addText("HTS_LNG_lbl",							"LNG",				{2, 2}, nil, "HTS_DED_ROOT")
addText("HTS_LNG",								"WXXXoXX.X'",		{7, 2}, nil, "HTS_DED_ROOT", {{"DED_HTS_LNG"}})

addText("HTS_ELEV_lbl",							"ELV",				{2, 3}, nil, "HTS_DED_ROOT")
addText("HTS_ELEV",								"XXXXFT",			{7, 3}, nil, "HTS_DED_ROOT", {{"DED_HTS_ELEV"}})

addText("HTS_TOT_lbl",							"TOT",				{2, 4}, nil, "HTS_DED_ROOT")
addText("HTS_TOT",								"XX:XX:XX",			{7, 4}, nil, "HTS_DED_ROOT", {{"DED_HTS_TOT"}})