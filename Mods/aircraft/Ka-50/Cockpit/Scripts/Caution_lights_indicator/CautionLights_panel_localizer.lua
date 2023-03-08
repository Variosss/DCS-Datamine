
country = "EN"
if  LockOn_Options.avionics_language == "native" then
    country = "RU"
end

localize_table = {}

localize_table["EN"] = {
	["НРВ\nСТАБ"] = "R-ALT\nHOLD",
	["ВИСЕНИЕ"] = "AUTO\nHOVER",
	["СНИЖЕНИЕ"] = "AUTO\nDESCENT",
	["МАРШРУТ\nЗК"] = "ENR\nNAV ON",
	["МАРШРУТ\nЛЗП"] = "ENR\nCOURSE",
	["ППМ\nРАЗВОРОТ"] = "NEXT\nWP",
	["КОНЕЦ\nМАРШРУТА"] = "ROUTE\nEND",
	["СЧИСЛЕН\nГРУБОЕ"] = "AC-POS\nCAL.DATA",
	["ВЗРЫВ"] = "WEAP\nARM",
	["ППУ"] = "CANNON",
	["<ППУ>"] = "<CANNON>",
	["КОЛЬЦЕВ\nОТКРЫТО"] = "X-FEED\nVLV OPEN",
	["МУФТ\nОТКЛ"] = "TURBO\nGEAR",
	["Р МАСЛА\nПРИВОДОВ"] = "AGB\nOIL PRESS",
	["ЗАМОК\nОТКРЫТ"] = "SL-HOOK\nOPEN",

	["БОЕВАЯ\nСЕТЬ ВКЛ"] = "MASTER\nARM ON",
	["ТРЕНАЖ"] = "WEAPON\nTRAINING",
	["ОБЗОР"] = "HMS\nFAIL",
	["РАНЕТ"] = "HUD\nNO READY",
	["К-ЦВМ"] = "COMPUTER\nDIAGNOSE",
	["ЦВС"] = "COMPUTER\nFAIL",
	["ПРЕОБРАЗ"] = "INVERTER\nON",
	["И-251В"] = "SHKVAL\nFAIL",
	["ПОС ЛЕВ\nДВИГ"] = "LH ENG\nANTI-ICE",
	["ПЗУ ЛЕВ\nДВИГ"] = "LH ENG\nDUST-PROT",
	["ОГРАН РЕЖ\nЛЕВ"] = "LH POWER\nSET LIM",
	["ПОС\nВИНТ"] = "ROTOR\nANTI-ICE",
	["ПОС ПРАВ\nДВИГ"] = "RH ENG\nANTI-ICE",
	["ПЗУ ПРАВ\nДВИГ"] = "RH ENG\nDUST-PROT",
	["ОГРАН РЕЖ\nПРАВ"] = "RH POWER\nSET LIM",
	["ОБОГРЕВ\nВУО"] = "WINDSHIELD\nHEATER ON",
	["БАК\nПЕРЕДНИЙ"] = "FWD TANK\nPUMP ON",
	["КРАН ЛЕВ\nЗАКРЫТ"] = "LH VLV\nCLOSED",
	["БАК ЛЕВ\nВНЕШН"] = "LH OUTER\nTANK PUMP",
	["БАК ЛЕВ\nВНУТР"] = "LH INNER\nTANK PUMP",
	["БАК\nЗАДНИЙ"] = "AFT TANK\nPUMP ON",
	["КРАН ПРАВ\nЗАКРЫТ"] = "RH VLV\nCLOSED",
	["БАК ПРАВ\nВНЕШН"] = "RH OUTER\nTANK PUMP",
	["БАК ПРАВ\nВНУТР"] = "RH INNER\nTANK PUMP",
}

function LOCALIZE(str)
	if	localize_table[country]      == nil or 
		localize_table[country][str] == nil then
		return str
	else
		return localize_table[country][str]
	end
end
