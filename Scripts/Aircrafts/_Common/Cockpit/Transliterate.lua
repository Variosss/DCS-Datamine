
CyrillicLetters = {}
CyrillicLetters["а"] = "А"
CyrillicLetters["б"] = "Б"
CyrillicLetters["в"] = "В"
CyrillicLetters["г"] = "Г"
CyrillicLetters["д"] = "Д"
CyrillicLetters["е"] = "Е"
CyrillicLetters["ё"] = "Ё"
CyrillicLetters["ж"] = "Ж"
CyrillicLetters["з"] = "З"
CyrillicLetters["и"] = "И"
CyrillicLetters["й"] = "Й"
CyrillicLetters["к"] = "К"
CyrillicLetters["л"] = "Л"
CyrillicLetters["м"] = "М"
CyrillicLetters["н"] = "Н"
CyrillicLetters["о"] = "О"
CyrillicLetters["п"] = "П"
CyrillicLetters["р"] = "Р"
CyrillicLetters["с"] = "С"
CyrillicLetters["т"] = "Т"
CyrillicLetters["у"] = "У"
CyrillicLetters["ф"] = "Ф"
CyrillicLetters["х"] = "Х"
CyrillicLetters["ц"] = "Ц"
CyrillicLetters["ч"] = "Ч"
CyrillicLetters["ш"] = "Ш"
CyrillicLetters["щ"] = "Щ"
CyrillicLetters["ь"] = "Ь"
CyrillicLetters["ы"] = "Ы"
CyrillicLetters["ъ"] = "Ъ"
CyrillicLetters["э"] = "Э"
CyrillicLetters["ю"] = "Ю"
CyrillicLetters["я"] = "Я"


TransliteTable = { -- must be sorted from largest phrase to single letter
	{"ИЙ","Y"},
	{"ЫЙ","Y"},
	{"ЬЕ","YE"},
	{"ий","y"},
	{"ый","y"},
	{"ье","ye"},
	
	{"А","A"},
	{"Б","B"},
	{"В","V"},
	{"Г","G"},
	{"Д","D"},
	{"Е","E"},
	{"Ё","YO"},
	{"Ж","ZH"},
	{"З","Z"},
	{"И","I"},
	{"Й","Y"},
	{"К","K"},
	{"Л","L"},
	{"М","M"},
	{"Н","N"},
	{"О","O"},
	{"П","P"},
	{"Р","R"},
	{"С","S"},
	{"Т","T"},
	{"У","U"},
	{"Ф","F"},
	{"Х","KH"},
	{"Ц","TZ"},
	{"Ч","CH"},
	{"Ш","SH"},
	{"Щ","SCH"},
	{"Ъ",""},
	{"Ь",""},
	{"Ы","Y"},
	{"Э","E"},
	{"Ю","YU"},
	{"Я","YA"},
	{"а","a"},
	{"б","b"},
	{"в","v"},
	{"г","g"},
	{"д","d"},
	{"е","e"},
	{"ё","yo"},
	{"ж","zh"},
	{"з","z"},
	{"и","i"},
	{"й","y"},
	{"к","k"},
	{"л","l"},
	{"м","m"},
	{"н","n"},
	{"о","o"},
	{"п","p"},
	{"р","r"},
	{"с","s"},
	{"т","t"},
	{"у","u"},
	{"ф","f"},
	{"х","kh"},
	{"ц","tz"},
	{"ч","ch"},
	{"ш","sh"},
	{"щ","sch"},
	{"ъ",""},
	{"ь",""},
	{"ы","y"},
	{"э","e"},
	{"ю","yu"},
	{"я","ya"},
}


MorzeLetter = {
{"А","A"},
{"Б","B"},
{"В","W"},
{"Г","G"},
{"Д","D"},
{"Е","E"},
{"Ж","V"},
{"З","Z"},
{"И","I"},
{"Й","J"},
{"К","K"},
{"Л","L"},
{"М","M"},
{"Н","N"},
{"О","O"},
{"П","P"},
{"Р","R"},
{"С","S"},
{"Т","T"},
{"У","U"},
{"Ф","F"},
{"Х","H"},
{"Ц","C"},
{"Ч","yo"},
{"Ш","ch"},
{"Щ","Q"},
{"Ь","X"},
{"Ы","Y"},
{"Э","ye"},
{"Ю","yu"},
{"Я","ya"},
{"а","A"},
{"б","B"},
{"в","W"},
{"г","G"},
{"д","D"},
{"е","E"},
{"ж","V"},
{"з","Z"},
{"и","I"},
{"й","J"},
{"к","K"},
{"л","L"},
{"м","M"},
{"н","N"},
{"о","O"},
{"п","P"},
{"р","R"},
{"с","S"},
{"т","T"},
{"у","U"},
{"ф","F"},
{"х","H"},
{"ц","C"},
{"ч","yo"},
{"ш","ch"},
{"щ","Q"},
{"ь","X"},
{"ы","Y"},
{"э","ye"},
{"ю","yu"},
{"я","ya"},
}
function upper_case(str)
	local res_str = ""
	      res_str = str
	for i,o in pairs(CyrillicLetters) do
		res_str = string.gsub(res_str,i,o)
	end
	return string.upper(res_str)
end

function lower_case(str)
	local res_str = ""
	      res_str = str
	for i,o in pairs(CyrillicLetters) do
		res_str = string.gsub(res_str,o,i)
	end
	return string.upper(res_str)
end



function translit(str,tbl)
	local res_str = ""
		  res_str = str
	for i,o in ipairs(tbl) do
		res_str = string.gsub(res_str,o[1],o[2])
	end
	return res_str
end

function TransliterateToLatDefault(str)
	if LockOn_Options.avionics_language == "native" then
		return str
	else
		local  res_str = ""
			   res_str = translit(str,TransliteTable)
		return upper_case(res_str)
	end	
end

function TransliterateMorzeToLatDefault(str)
	if LockOn_Options.avionics_language == "native" then
		return str
	else
		local  res_str = ""
			   res_str = translit(str,MorzeLetter)
		return upper_case(res_str)
	end	
end

function TransliterateToLat(str)
	return translit(str,TransliteTable)
end

function TransliterateMorzeToLat(str)
	return translit(str,MorzeLetter)
end
