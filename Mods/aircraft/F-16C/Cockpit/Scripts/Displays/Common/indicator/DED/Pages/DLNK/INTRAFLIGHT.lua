
addText("INTRAFLIGHT lbl",		"INTRAFLIGHT",			{7, 0})

for i = 1,8,1 do
	local col = 1
	local dl = 0
	if i > 4 then
		col = 7
		dl = 4
	end

	addText("STN id lbl"..i,	"#"..i,					{col, i - dl})
	addText("STN value"..i,		"XX",					{col + 3, i - dl})
end

addText("COMM lbl",				"COMM",					{13, 1})
addText("COMM status",			"VHF",					{18, 1})

addText("DATA lbl",				"DATA",					{13, 2})
addText("DATA status",			"XXK",					{18, 2})

addText("OWN lbl",				"OWN",					{14, 3})
addText("OWN value",			"XX",					{18, 3})

addText("LAST lbl",				"LAST",					{13, 4})
addText("LAST value",			"#X",					{18, 4})


addText("P6 lbl",				"P6>",					{21, 4})
