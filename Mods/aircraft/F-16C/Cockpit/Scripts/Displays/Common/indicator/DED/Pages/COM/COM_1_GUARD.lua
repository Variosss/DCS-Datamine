
addText("COM 1 Mode",					"UHF",	{8, 0}, nil, nil, nil, {"UHF", "HQ"})
addText("COM 1 Power Status",			"ON",	{13, 0}, nil, nil, {{"DED_COM1_PowerStatus"}}, {"", "ON", "OFF"})

addText("Guard or Backup Status",		"GUARD",	{9, 2}, nil, nil, {{"DED_COM1_BackupStatus"}}, {"", "GUARD", "BACKUP"})

addText("Preset Channel Number",		"",			{7, 4}, nil, nil, {{"DED_COM1_BackupChannel"}})
addText("Guard or Backup Frequency",	"243.00",	{10, 4}, nil, nil, {{"DED_COM1_BackupFrequency"}})
