dofile('Scripts/World/Radio/ModulationTypes.lua')
dofile('Scripts/World/Radio/FrequencyBands.lua')

local gettext = require("i_18n")
local       _ = gettext.translate

--WORLD RADIO

radioTableFormat = 3
radio = {
	{
		radioId = 'airfield12_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Anapa"), "Anapa"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 3750000.000000}, [UHF] = {MODULATIONTYPE_AM, 250000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 121000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 38400000.000000}};
		sceneObjects = {'t:136022192'};
	};
	{
		radioId = 'airfield22_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["nato"] = {_("Batumi"), "Batumi"}}, {["ussr"] = {_("Druzhinnik"), "Druzhinnik"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4250000.000000}, [UHF] = {MODULATIONTYPE_AM, 260000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 131000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 40400000.000000}};
		sceneObjects = {'t:54694615'};
	};
	{
		radioId = 'airfield32_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["nato"] = {_("Beslan"), "Beslan"}}, {["ussr"] = {_("Stavok"), "Stavok"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4750000.000000}, [UHF] = {MODULATIONTYPE_AM, 270000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 141000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 42400000.000000}};
		sceneObjects = {'t:95522046'};
	};
	{
		radioId = 'airfield17_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["nato"] = {_("Gelendzhik"), "Gelendzhik"}}, {["ussr"] = {_("Maslenka"), "Maslenka"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4000000.000000}, [UHF] = {MODULATIONTYPE_AM, 255000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 126000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 39400000.000000}};
		sceneObjects = {'t:118525997'};
	};
	{
		radioId = 'airfield21_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["nato"] = {_("Gudauta"), "Gudauta"}}, {["ussr"] = {_("Lachuga"), "Lachuga"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4200000.000000}, [UHF] = {MODULATIONTYPE_AM, 259000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 130000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 40200000.000000}};
		sceneObjects = {'t:86311003'};
	};
	{
		radioId = 'airfield24_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Kobuleti"), "Kobuleti"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4350000.000000}, [UHF] = {MODULATIONTYPE_AM, 262000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 133000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 40800000.000000}};
		sceneObjects = {'t:59082457'};
	};
	{
		radioId = 'airfield13_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["nato"] = {_("Krasnodar"), "Krasnodar"}}, {["ussr"] = {_("Volokno"), "Volokno"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 3800000.000000}, [UHF] = {MODULATIONTYPE_AM, 251000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 122000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 38600000.000000}};
		sceneObjects = {'t:141067227'};
	};
	{
		radioId = 'airfield19_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["nato"] = {_("Pashkovsky"), "Pashkovsky"}}, {["ussr"] = {_("Krasnodar"), "Krasnodar"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4100000.000000}, [UHF] = {MODULATIONTYPE_AM, 257000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 128000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 39800000.000000}};
		sceneObjects = {'t:137592844'};
	};
	{
		radioId = 'airfield15_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["nato"] = {_("Krymsk"), "Krymsk"}}, {["ussr"] = {_("Taymyr"), "Taymyr"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 3900000.000000}, [UHF] = {MODULATIONTYPE_AM, 253000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 124000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 39000000.000000}};
		sceneObjects = {'t:136814292'};
	};
	{
		radioId = 'airfield25_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Kutaisi"), "Kutaisi"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4400000.000000}, [UHF] = {MODULATIONTYPE_AM, 263000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 134000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 41000000.000000}};
		sceneObjects = {'t:68355409'};
	};
	{
		radioId = 'airfield29_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Lochini"), "Lochini"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4600000.000000}, [UHF] = {MODULATIONTYPE_AM, 267000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 138000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 41800000.000000}};
		sceneObjects = {'t:14615718'};
	};
	{
		radioId = 'airfield16_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["nato"] = {_("Khanskaya"), "Khanskaya"}}, {["ussr"] = {_("Sokrat"), "Sokrat"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 3950000.000000}, [UHF] = {MODULATIONTYPE_AM, 254000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 125000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 39200000.000000}};
		sceneObjects = {'t:127571804'};
	};
	{
		radioId = 'airfield26_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Minvody"), "Minvody"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4450000.000000}, [UHF] = {MODULATIONTYPE_AM, 264000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 135000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 41200000.000000}};
		sceneObjects = {'t:119998387'};
	};
	{
		radioId = 'airfield28_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["nato"] = {_("Mozdok"), "Mozdok"}}, {["ussr"] = {_("Assistent"), "Assistent"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4550000.000000}, [UHF] = {MODULATIONTYPE_AM, 266000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 137000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 41600000.000000}};
		sceneObjects = {'t:110430036'};
	};
	{
		radioId = 'airfield27_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Nalchik"), "Nalchik"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4500000.000000}, [UHF] = {MODULATIONTYPE_AM, 265000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 136000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 41400000.000000}};
		sceneObjects = {'t:100045189'};
	};
	{
		radioId = 'airfield14_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["nato"] = {_("Novorossiysk"), "Novorossiysk"}}, {["ussr"] = {_("Myskhako"), "Myskhako"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 3850000.000000}, [UHF] = {MODULATIONTYPE_AM, 252000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 123000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 38800000.000000}};
		sceneObjects = {'t:123869211'};
	};
	{
		radioId = 'airfield23_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["nato"] = {_("Kolkhi"), "Kolkhi"}}, {["ussr"] = {_("Tzokot"), "Tzokot"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4300000.000000}, [UHF] = {MODULATIONTYPE_AM, 261000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 132000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 40600000.000000}};
		sceneObjects = {'t:67406890'};
	};
	{
		radioId = 'airfield18_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Sochi"), "Sochi"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4050000.000000}, [UHF] = {MODULATIONTYPE_AM, 256000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 127000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 39600000.000000}};
		sceneObjects = {'t:91554927'};
	};
	{
		radioId = 'airfield20_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["nato"] = {_("Sukhumi"), "Sukhumi"}}, {["ussr"] = {_("Uklad"), "Uklad"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4150000.000000}, [UHF] = {MODULATIONTYPE_AM, 258000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 129000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 40000000.000000}};
		sceneObjects = {'t:23201191'};
	};
	{
		radioId = 'airfield30_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Soganlug"), "Soganlug"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4650000.000000}, [UHF] = {MODULATIONTYPE_AM, 268000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 139000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 42000000.000000}};
		sceneObjects = {'t:60361261'};
	};
	{
		radioId = 'airfield31_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Vaziani"), "Vaziani"}}};
		frequency = {[HF] = {MODULATIONTYPE_AM, 4700000.000000}, [UHF] = {MODULATIONTYPE_AM, 269000000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 140000000.000000}, [VHF_LOW] = {MODULATIONTYPE_AM, 42200000.000000}};
		sceneObjects = {'t:58884600'};
	};
}
