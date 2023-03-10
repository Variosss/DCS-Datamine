dofile('Scripts/World/Radio/ModulationTypes.lua')
dofile('Scripts/World/Radio/FrequencyBands.lua')

local gettext = require("i_18n")
local       _ = gettext.translate

--WORLD RADIO

radioTableFormat = 3
radio = {
	{
		radioId = 'airfield22_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OMAA"), "OMAA"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 119200000.000000}};
		sceneObjects = {'t:70517820'};
	};
	{
		radioId = 'airfield1_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OIBA"), "OIBA"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 122900000.000000}};
		sceneObjects = {'t:84115510'};
	};
	{
		radioId = 'airfield25_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OMAL"), "OMAL"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 119850000.000000}};
		sceneObjects = {'t:68419649'};
	};
	{
		radioId = 'airfield23_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OMAD"), "OMAD"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 119900000.000000}};
		sceneObjects = {'t:46600593'};
	};
	{
		radioId = 'airfield2_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OIKB"), "OIKB"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118100000.000000}};
		sceneObjects = {'t:55149114'};
	};
	{
		radioId = 'airfield21_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Jask"), "Jask"}}};
		frequency = {};
		sceneObjects = {'t:82673668'};
	};
	{
		radioId = 'airfield3_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OIBL"), "OIBL"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 121700000.000000}};
		sceneObjects = {'t:53280861'};
	};
	{
		radioId = 'airfield4_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OMAM"), "OMAM"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 126500000.000000}};
		sceneObjects = {'t:67863199'};
	};
	{
		radioId = 'airfield5_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OMDB"), "OMDB"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118750000.000000}};
		sceneObjects = {'t:20779909'};
	};
	{
		radioId = 'airfield6_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OMDW"), "OMDW"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118600000.000000}};
		sceneObjects = {'t:19271516'};
	};
	{
		radioId = 'airfield7_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OMFJ"), "OMFJ"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 124600000.000000}};
		sceneObjects = {'t:78155690'};
	};
	{
		radioId = 'airfield9_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Havadarya"), "Havadarya"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 123150000.000000}};
		sceneObjects = {'t:91227625'};
	};
	{
		radioId = 'airfield27_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OIKJ"), "OIKJ"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 136000000.000000}};
		sceneObjects = {'t:120848424'};
	};
	{
		radioId = 'airfield18_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("KERMAN"), "KERMAN"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118250000.000000}};
		sceneObjects = {'t:141787586'};
	};
	{
		radioId = 'airfield10_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Khasab"), "Khasab"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 124350000.000000}};
		sceneObjects = {'t:25362488'};
	};
	{
		radioId = 'airfield24_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Kish"), "Kish"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 121650000.000000}};
		sceneObjects = {'t:85329081'};
	};
	{
		radioId = 'airfield11_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OISL"), "OISL"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 127350000.000000}};
		sceneObjects = {'t:56296087'};
	};
	{
		radioId = 'airfield26_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("LVA"), "LVA"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 128550000.000000}};
		sceneObjects = {'t:87490740'};
	};
	{
		radioId = 'airfield29_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OMLW"), "OMLW"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 119300000.000000}};
		sceneObjects = {'t:44008046'};
	};
	{
		radioId = 'airfield12_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OMDM"), "OMDM"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118550000.000000}};
		sceneObjects = {'t:77201634'};
	};
	{
		radioId = 'airfield13_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Qeshm Island"), "Qeshm Island"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118050000.000000}};
		sceneObjects = {'t:86638615'};
	};
	{
		radioId = 'airfield28_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OMRK"), "OMRK"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 121600000.000000}};
		sceneObjects = {'t:82348152'};
	};
	{
		radioId = 'airfield20_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OMNK"), "OMNK"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 128900000.000000}};
		sceneObjects = {'t:70257951'};
	};
	{
		radioId = 'airfield14_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("SharjahIntl"), "SharjahIntl"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118600000.000000}};
		sceneObjects = {'t:10717269'};
	};
	{
		radioId = 'airfield19_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("SHIRAZ"), "SHIRAZ"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 121900000.000000}};
		sceneObjects = {'t:130418428'};
	};
	{
		radioId = 'airfield17_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OMSN"), "OMSN"}}};
		frequency = {[UHF] = {MODULATIONTYPE_AM, 250800000.000000}};
		sceneObjects = {'t:79167513'};
	};
	{
		radioId = 'airfield15_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("OIBS"), "OIBS"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 135050000.000000}};
		sceneObjects = {'t:84050124'};
	};
}
