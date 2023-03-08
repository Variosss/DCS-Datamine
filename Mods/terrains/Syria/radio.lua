dofile('Scripts/World/Radio/ModulationTypes.lua')
dofile('Scripts/World/Radio/FrequencyBands.lua')

local gettext = require("i_18n")
local       _ = gettext.translate

--WORLD RADIO

radioTableFormat = 3
radio = {
	{
		radioId = 'airfield1_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Abu_Ad_Duhur"), "Abu_Ad_Duhur"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 122200000.000000}};
		sceneObjects = {'t:945619000'};
	};
	{
		radioId = 'airfield2_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Adana"), "Adana"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 121100000.000000}};
		sceneObjects = {'t:171640589'};
	};
	{
		radioId = 'airfield44_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Akrotiri"), "Akrotiri"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 128000000.000000}};
		sceneObjects = {'t:112200011'};
	};
	{
		radioId = 'airfield3_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Al_Qusayr"), "Al_Qusayr"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 119200000.000000}};
		sceneObjects = {'t:803241999'};
	};
	{
		radioId = 'airfield4_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("An_Nasiriyah"), "An_Nasiriyah"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 122300000.000000}};
		sceneObjects = {'t:775913487'};
	};
	{
		radioId = 'airfield5_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("As_Suwayda"), "As_Suwayda"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 122400000.000000}};
		sceneObjects = {'t:674955364'};
	};
	{
		radioId = 'airfield63_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("At-Tanf"), "At-Tanf"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 121100000.000000}};
		sceneObjects = {'t:743571482'};
	};
	{
		radioId = 'airfield6_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Hariri"), "Hariri"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118900000.000000}};
		sceneObjects = {'t:14192597'};
	};
	{
		radioId = 'airfield7_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Damascus"), "Damascus"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118500000.000000}};
		sceneObjects = {'t:34244551'};
	};
	{
		radioId = 'airfield42_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Deirez-Zor"), "Deirez-Zor"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118100000.000000}};
		sceneObjects = {'t:127242793'};
	};
	{
		radioId = 'airfield8_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Der_Salman"), "Der_Salman"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 122900000.000000}};
		sceneObjects = {'t:743211029'};
	};
	{
		radioId = 'airfield9_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Dumayr"), "Dumayr"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 120300000.000000}};
		sceneObjects = {'t:754974792'};
	};
	{
		radioId = 'airfield49_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Ercan"), "Ercan"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 120200000.000000}};
		sceneObjects = {'t:125803358'};
	};
	{
		radioId = 'airfield10_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Eyn_Shemer"), "Eyn_Shemer"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 123400000.000000}};
		sceneObjects = {'t:649330695'};
	};
	{
		radioId = 'airfield11_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Gaziantep"), "Gaziantep"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 120100000.000000}};
		sceneObjects = {'t:169543334'};
	};
	{
		radioId = 'airfield41_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Gazipasa"), "Gazipasa"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 119250000.000000}};
		sceneObjects = {'t:153026898'};
	};
	{
		radioId = 'airfield50_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Gecitkale"), "Gecitkale"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 120000000.000000}};
		sceneObjects = {'t:125866550'};
	};
	{
		radioId = 'airfield53_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("H3"), "H3"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 122000000.000000}};
		sceneObjects = {'t:81625163'};
	};
	{
		radioId = 'airfield12_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("H4"), "H4"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 122600000.000000}};
		sceneObjects = {'t:653623310'};
	};
	{
		radioId = 'airfield13_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Haifa"), "Haifa"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 127800000.000000}};
		sceneObjects = {'t:78774657'};
	};
	{
		radioId = 'airfield14_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Hama"), "Hama"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118050000.000000}};
		sceneObjects = {'t:389873664'};
	};
	{
		radioId = 'airfield15_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Hatay"), "Hatay"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 128500000.000000}};
		sceneObjects = {'t:56983906'};
	};
	{
		radioId = 'airfield51_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Pinarbashi"), "Pinarbashi"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 121000000.000000}};
		sceneObjects = {'t:913277111'};
	};
	{
		radioId = 'airfield16_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Incirlik"), "Incirlik"}}};
		frequency = {[UHF] = {MODULATIONTYPE_AM, 360100000.000000}, [VHF_HI] = {MODULATIONTYPE_AM, 122100000.000000}};
		sceneObjects = {'t:63280027'};
	};
	{
		radioId = 'airfield17_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Jirah"), "Jirah"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118100000.000000}};
		sceneObjects = {'t:985923593'};
	};
	{
		radioId = 'airfield18_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Khalkhalah"), "Khalkhalah"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 122500000.000000}};
		sceneObjects = {'t:710344706'};
	};
	{
		radioId = 'airfield59_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Kharab_Ishk"), "Kharab_Ishk"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 122200000.000000}};
		sceneObjects = {'t:1056505965'};
	};
	{
		radioId = 'airfield19_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Mafraq"), "Mafraq"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118300000.000000}};
		sceneObjects = {'t:643366918'};
	};
	{
		radioId = 'airfield45_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Kingsfield"), "Kingsfield"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 121000000.000000}};
		sceneObjects = {'t:866877458'};
	};
	{
		radioId = 'airfield20_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Kiryat"), "Kiryat"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118400000.000000}};
		sceneObjects = {'t:723648537'};
	};
	{
		radioId = 'airfield48_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Lakatamia"), "Lakatamia"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 120200000.000000}};
		sceneObjects = {'t:885654131'};
	};
	{
		radioId = 'airfield47_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Larnaca"), "Larnaca"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 121200000.000000}};
		sceneObjects = {'t:118621030'};
	};
	{
		radioId = 'airfield21_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Latakia"), "Latakia"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118100000.000000}};
		sceneObjects = {'t:129761520'};
	};
	{
		radioId = 'airfield22_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Marj_Al_Sultan"), "Marj_Al_Sultan"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 122700000.000000}};
		sceneObjects = {'t:745078942'};
	};
	{
		radioId = 'airfield23_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Marj_Ruhayyil"), "Marj_Ruhayyil"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 120800000.000000}};
		sceneObjects = {'t:729153596'};
	};
	{
		radioId = 'airfield24_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Meggido"), "Meggido"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 119900000.000000}};
		sceneObjects = {'t:664174645'};
	};
	{
		radioId = 'airfield25_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Mezzeh"), "Mezzeh"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 120700000.000000}};
		sceneObjects = {'t:744624262'};
	};
	{
		radioId = 'airfield26_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Minakh"), "Minakh"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 120600000.000000}};
		sceneObjects = {'t:1052180511'};
	};
	{
		radioId = 'airfield52_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Naqoura"), "Naqoura"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 122000000.000000}};
		sceneObjects = {'t:83566408'};
	};
	{
		radioId = 'airfield27_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Aleppo"), "Aleppo"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 119100000.000000}};
		sceneObjects = {'t:20251499'};
	};
	{
		radioId = 'airfield28_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Palmyra"), "Palmyra"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 121900000.000000}};
		sceneObjects = {'t:802717735'};
	};
	{
		radioId = 'airfield46_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Pafos"), "Pafos"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 119900000.000000}};
		sceneObjects = {'t:114952216'};
	};
	{
		radioId = 'airfield29_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Qabr_as_Sitt"), "Qabr_as_Sitt"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 122600000.000000}};
		sceneObjects = {'t:741507113'};
	};
	{
		radioId = 'airfield30_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Ramat_David"), "Ramat_David"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118600000.000000}};
		sceneObjects = {'t:75760364'};
	};
	{
		radioId = 'airfield31_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Rasin"), "Rasin"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 120500000.000000}};
		sceneObjects = {'t:145756014'};
	};
	{
		radioId = 'airfield32_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Riyaq"), "Riyaq"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 124400000.000000}};
		sceneObjects = {'t:772342069'};
	};
	{
		radioId = 'airfield33_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("ReneMouaward"), "ReneMouaward"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 121000000.000000}};
		sceneObjects = {'t:805699623'};
	};
	{
		radioId = 'airfield34_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("RoshPina"), "RoshPina"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118450000.000000}};
		sceneObjects = {'t:81987904'};
	};
	{
		radioId = 'airfield57_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Ruwayshid"), "Ruwayshid"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 122100000.000000}};
		sceneObjects = {'t:29032448'};
	};
	{
		radioId = 'airfield58_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Sanliurfa"), "Sanliurfa"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118400000.000000}};
		sceneObjects = {'t:186516538'};
	};
	{
		radioId = 'airfield35_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Sayqal"), "Sayqal"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 120400000.000000}};
		sceneObjects = {'t:760774675'};
	};
	{
		radioId = 'airfield36_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Shayrat"), "Shayrat"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 120200000.000000}};
		sceneObjects = {'t:798621705'};
	};
	{
		radioId = 'airfield37_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Tabqa"), "Tabqa"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 118500000.000000}};
		sceneObjects = {'t:946044940'};
	};
	{
		radioId = 'airfield38_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Taftanaz"), "Taftanaz"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 122800000.000000}};
		sceneObjects = {'t:972849360'};
	};
	{
		radioId = 'airfield60_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Tal_Siman"), "Tal_Siman"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 121900000.000000}};
		sceneObjects = {'t:148668426'};
	};
	{
		radioId = 'airfield39_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Tiyas"), "Tiyas"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 120500000.000000}};
		sceneObjects = {'t:800096266'};
	};
	{
		radioId = 'airfield40_0';
		role = {"ground", "tower", "approach"};
		callsign = {{["common"] = {_("Hamat"), "Hamat"}}};
		frequency = {[VHF_HI] = {MODULATIONTYPE_AM, 121500000.000000}};
		sceneObjects = {'t:789872682'};
	};
}
