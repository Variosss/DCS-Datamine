
country = "EN"
if  LockOn_Options.avionics_language == "native" then
    country = "RU"
end

reverse_table = {}
reverse_table["RU"] = {}

for i,o in pairs(localize_table["EN"]) do
	if type(o) == 'string' then
	   reverse_table["RU"][o] = i
	end
end

function LOCALIZE(str)
	if	localize_table[country]      == nil or 
		localize_table[country][str] == nil then
		return str
	else
		return localize_table[country][str]
	end
end

function LOCALIZE_EX(str, param)
	if localize_table[country]				== nil or
	   localize_table[country][str]			== nil or
	   localize_table[country][str][param]	== nil then
	   return  str;
	else
	   return localize_table[country][str][param]
	end
end

function LOCALIZE_C(str)
	if reverse_table[country]				== nil or
	   reverse_table[country][str]			== nil then
	   return  str;
	else
	   return reverse_table[country][str]
	end
end

function LOCALIZE_C_EX(str, param)
	if reverse_table[country]	   		  	== nil or
	   reverse_table[country][str] 			== nil or
	   reverse_table[country][str][param]	== nil then
	   return  str;
	else
	   return reverse_table[country][str][param]
	end
end
