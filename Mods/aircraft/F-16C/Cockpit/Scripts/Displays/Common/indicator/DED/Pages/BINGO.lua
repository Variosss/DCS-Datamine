
addText("BINGO label",			"BINGO",				{9, 0})

addText("BINGO STPT Num",		"XX",					{20, 0}, nil, nil, {{"DED_CNI_WPT_Num"}})
addText("BINGO IncDecSymbol",	"a",					{23, 0})

addText("SET label",			"SET",					{6, 2})
addAsteriscs("BINGO Asterisks",	{10, 2}, 8)
addText("BINGO Scratchpad",		"XXXXXLBS",				{11, 2}, {"DED_BINGO_DataEntry_Inv", 0}, nil, {{"DED_BINGO_Scratchpad"}})

addText("TOTAL label",			"TOTAL",				{4, 3})
addText("TOTAL value",			"XXXXX",				{11, 3}, nil, nil, {{"DED_BINGO_Total"}})
addText("TOTAL LBS label",		"LBS",					{16, 3})
