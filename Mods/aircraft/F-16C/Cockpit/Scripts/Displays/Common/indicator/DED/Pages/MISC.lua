
addText("MISC Label",	"MISC",	{10, 0})

local function addLabels(number, text, col, line, controllers)
	addText("Misc Item "..number.." Number", number, {col, line}, true)
	addText("Misc Item "..number.." Name", text, {col + 1, line}, false, nil, controllers)
end

local function addItem(number, text)
	local num = number - 1
	local line	= 1 + math.floor(num / 3)
	local col	= (num % 3) * 6

	addLabels(number, text, col, line)
end

addItem(1, "CORR")
addItem(2, "MAGV")
addItem(3, "OFP")
addItem(4, "INSM")
addItem(5, "LASR")
addItem(6, "GPS")
addItem(7, "DRNG")
addItem(8, "BULL")
addItem(9, "")

addLabels("R", "HMCS",	18, 1)
addLabels("E", "HTS",	18, 2,{{"DED_MISC_HTS_availability"}})
addLabels("0", "HARM",	18, 3,{{"DED_MISC_HARM_availability"}})
