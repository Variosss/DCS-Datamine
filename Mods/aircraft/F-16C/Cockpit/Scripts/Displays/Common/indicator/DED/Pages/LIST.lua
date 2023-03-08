
addText("LIST Label",	"LIST",	{10, 0})

local function addLabels(number, text, col, line)
	addText("List Item "..number.." Number", number, {col, line}, true)
	addText("List Item "..number.." Name", text, {col + 1, line})
end

local function addItem(number, text)
	local num = number - 1
	local line	= 1 + math.floor(num / 3)
	local col	= (num % 3) * 6

	addLabels(number, text, col, line)
end

addItem(1, "DEST")
addItem(2, "BNGO")
addItem(3, "VIP")
addItem(4, "NAV")
addItem(5, "MAN")
addItem(6, "INS")
addItem(7, "CMDS")
addItem(8, "MODE")
addItem(9, "VRP")

addLabels("R", "INTG",	18, 1)
addLabels("E", "DLNK",	18, 2)
addLabels("0", "MISC",	18, 3)

