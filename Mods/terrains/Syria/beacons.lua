dofile('Scripts/Database/wsTypes.lua')
dofile('Scripts/World/Radio/BeaconTypes.lua')
dofile('Scripts/World/Radio/BeaconSites.lua')

local disableNauticalBeacons = true

local gettext = require("i_18n")
local       _ = gettext.translate

--WORLD BEACONS

beaconsTableFormat = 2
beacons = {
	{
		display_name = _('BANIAS');
		beaconId = 'world_0';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'BAN';
		frequency = 304000.000000;
		position = { 22735.679688, 8.532078, 5935.380859 };
		direction = 0.000000;
		positionGeo = { latitude = 35.228286, longitude = 35.957919 };
		sceneObjects = {'t:402988475'};
	};
	{
		display_name = _('KAHRAMANMARAS');
		beaconId = 'world_1';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'KHM';
		frequency = 374000.000000;
		position = { 276904.968750, 503.130081, 101895.742188 };
		direction = 0.000000;
		positionGeo = { latitude = 37.540196, longitude = 36.952346 };
		sceneObjects = {'t:631341056'};
	};
	{
		display_name = _('KLEYATE');
		beaconId = 'world_2';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'RA';
		frequency = 450000.000000;
		position = { -48636.152344, 4.410843, 7884.588867 };
		direction = 0.000000;
		positionGeo = { latitude = 34.586111, longitude = 36.002778 };
		sceneObjects = {'t:339152018'};
	};
	{
		display_name = _('KARIATAIN');
		beaconId = 'world_3';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'KTN';
		frequency = 372500.000000;
		position = { -91109.367188, 752.408956, 120109.953125 };
		direction = 0.000000;
		positionGeo = { latitude = 34.227181, longitude = 37.233667 };
		sceneObjects = {'t:320637039'};
	};
	{
		display_name = _('TURAIF');
		beaconId = 'world_4';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'TRF';
		frequency = 116100000.000000;
		position = { -373082.937500, 846.806633, 257743.343750 };
		direction = 0.000000;
		positionGeo = { latitude = 31.696111, longitude = 38.735583 };
		sceneObjects = {'t:67895296'};
	};
	{
		display_name = _('BAYSUR');
		beaconId = 'world_5';
		type = BEACON_TYPE_VOR;
		callsign = 'BAR';
		frequency = 113900000.000000;
		position = { -137939.109375, 837.341536, -36216.691406 };
		direction = 0.000000;
		positionGeo = { latitude = 33.769444, longitude = 35.555556 };
		sceneObjects = {'t:99753403'};
	};
	{
		display_name = _('MARKA');
		beaconId = 'world_6';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'AMN';
		frequency = 116300000.000000;
		position = { -335215.781250, 656.782761, 5626.460938 };
		direction = 0.000000;
		positionGeo = { latitude = 32.004072, longitude = 36.065986 };
		sceneObjects = {'t:67928330'};
	};
	{
		display_name = _('TANF');
		beaconId = 'world_7';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'TAN';
		frequency = 114000000.000000;
		position = { -175046.437500, 703.699556, 250662.015625 };
		direction = 0.000000;
		positionGeo = { latitude = 33.482383, longitude = 38.654064 };
		sceneObjects = {'t:89063518'};
	};
	{
		display_name = _('NATANIA');
		beaconId = 'world_8';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'NAT';
		frequency = 112400000.000000;
		position = { -295272.531250, 22.862537, -96707.609375 };
		direction = 0.000000;
		positionGeo = { latitude = 32.333889, longitude = 34.968889 };
		sceneObjects = {'t:69404353'};
	};
	{
		display_name = _('KAHRAMANMARAS');
		beaconId = 'world_9';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'KHM';
		frequency = 113900000.000000;
		position = { 276922.218750, 504.614030, 101996.453125 };
		direction = 0.000000;
		positionGeo = { latitude = 37.540371, longitude = 36.953481 };
		sceneObjects = {'t:187006976'};
	};
	{
		display_name = _('KARIATAIN');
		beaconId = 'world_10';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'KTN';
		frequency = 117700000.000000;
		position = { -92699.039063, 748.330887, 122897.039063 };
		direction = 0.000000;
		positionGeo = { latitude = 34.213283, longitude = 37.264208 };
		sceneObjects = {'t:106233856'};
	};
	{
		display_name = _('MUT');
		beaconId = 'world_11';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'MUT';
		frequency = 112300000.000000;
		position = { 215007.406250, 1739.611481, -226320.593750 };
		direction = 0.000000;
		positionGeo = { latitude = 36.862579, longitude = 33.290921 };
		sceneObjects = {'t:170688512'};
	};
	{
		display_name = _('DHEKELIA');
		beaconId = 'world_12';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'DKA';
		frequency = 343000.000000;
		position = { 5039.548340, 46.457856, -196596.843750 };
		direction = 0.000000;
		positionGeo = { latitude = 34.993187, longitude = 33.749388 };
		sceneObjects = {'t:384241364'};
	};
	{
		display_name = _('');
		beaconId = 'airfield2_0';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'IADA';
		frequency = 108700000.000000;
		position = { 220391.796875, 17.000017, -46974.203125 };
		direction = -124.199000;
		positionGeo = { latitude = 36.990667, longitude = 35.294835 };
		sceneObjects = {'t:586484077'};
		chartOffsetX = 3030.000000;
	};
	{
		display_name = _('');
		beaconId = 'airfield2_1';
		type = BEACON_TYPE_ILS_GLIDESLOPE;
		callsign = 'IADA';
		frequency = 108700000.000000;
		position = { 218806.687500, 17.000017, -49094.089844 };
		direction = -125.000001;
		positionGeo = { latitude = 36.975663, longitude = 35.271760 };
		sceneObjects = {'t:1144817698'};
	};
	{
		display_name = _('ADANA');
		beaconId = 'airfield2_2';
		type = BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER;
		callsign = 'ADN';
		frequency = 395000.000000;
		position = { 218312.296875, 11.821711, -50018.769531 };
		direction = 0.000000;
		positionGeo = { latitude = 36.970889, longitude = 35.261611 };
		sceneObjects = {'t:585925629'};
	};
	{
		display_name = _('ADANA');
		beaconId = 'airfield2_3';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'ADA';
		frequency = 112700000.000000;
		position = { 215128.828125, 6.788498, -54714.742188 };
		direction = 0.000000;
		positionGeo = { latitude = 36.940583, longitude = 35.210389 };
		sceneObjects = {'t:171247026'};
	};
	{
		display_name = _('');
		beaconId = 'airfield44_0';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'IAK';
		frequency = 109700000.000000;
		position = { -35143.730469, 18.235578, -270549.812500 };
		direction = 111.071989;
		positionGeo = { latitude = 34.595184, longitude = 32.969540 };
		sceneObjects = {'t:346165796'};
		chartOffsetX = 3211.500000;
	};
	{
		display_name = _('');
		beaconId = 'airfield44_1';
		type = BEACON_TYPE_ILS_GLIDESLOPE;
		callsign = 'IAK';
		frequency = 109700000.000000;
		position = { -36049.847656, 20.847738, -267864.875000 };
		direction = 110.000033;
		positionGeo = { latitude = 34.588499, longitude = 32.999245 };
		sceneObjects = {'t:813401020'};
	};
	{
		display_name = _('Akrotiri');
		beaconId = 'airfield44_2';
		type = BEACON_TYPE_TACAN;
		callsign = 'AKR';
		frequency = 116000000.000000;
		channel = 107;
		position = { -36858.277344, 44.742232, -271271.562500 };
		direction = 0.000000;
		positionGeo = { latitude = 34.579420, longitude = 32.962829 };
		sceneObjects = {'t:346165795'};
	};
	{
		display_name = _('AKROTIRI');
		beaconId = 'airfield44_3';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'AK';
		frequency = 365000.000000;
		position = { -36612.078125, 20.988369, -266658.687500 };
		direction = -53.476058;
		positionGeo = { latitude = 34.584101, longitude = 33.012689 };
		sceneObjects = {'t:346199334'};
	};
	{
		display_name = _('KALDE');
		beaconId = 'airfield6_0';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'KAD';
		frequency = 112600000.000000;
		position = { -133511.000000, 12.000012, -42518.968750 };
		direction = 0.000000;
		positionGeo = { latitude = 33.807390, longitude = 35.485991 };
		sceneObjects = {'t:99653738'};
	};
	{
		display_name = _('');
		beaconId = 'airfield6_1';
		type = BEACON_TYPE_ILS_GLIDESLOPE;
		callsign = 'IBB';
		frequency = 110100000.000000;
		position = { -130320.203125, 12.000012, -42839.488281 };
		direction = -11.107002;
		positionGeo = { latitude = 33.836015, longitude = 35.481357 };
		sceneObjects = {'t:771722991'};
		chartOffsetX = 3722.000000;
	};
	{
		display_name = _('');
		beaconId = 'airfield6_2';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'IKK';
		frequency = 110700000.000000;
		position = { -131222.921875, 12.034485, -40739.011719 };
		direction = -145.184003;
		positionGeo = { latitude = 33.828534, longitude = 35.504347 };
		sceneObjects = {'t:301498961'};
		chartOffsetX = 4140.000000;
	};
	{
		display_name = _('');
		beaconId = 'airfield6_3';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'BIL';
		frequency = 109500000.000000;
		position = { -133542.953125, 12.000010, -42243.164063 };
		direction = -1.121999;
		positionGeo = { latitude = 33.807187, longitude = 35.488977 };
		sceneObjects = {'t:301109334'};
		chartOffsetX = 3510.000000;
	};
	{
		display_name = _('');
		beaconId = 'airfield6_4';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'IBB';
		frequency = 110100000.000000;
		position = { -133400.578125, 12.000012, -42358.453125 };
		direction = -11.107002;
		positionGeo = { latitude = 33.808433, longitude = 35.487681 };
		sceneObjects = {'t:301109323'};
		chartOffsetX = 3722.000000;
	};
	{
		display_name = _('');
		beaconId = 'airfield6_5';
		type = BEACON_TYPE_ILS_GLIDESLOPE;
		callsign = 'BIL';
		frequency = 109500000.000000;
		position = { -130440.914063, 12.000012, -42160.257813 };
		direction = -1.121999;
		positionGeo = { latitude = 33.835138, longitude = 35.488728 };
		sceneObjects = {'t:771722992'};
		chartOffsetX = 3510.000000;
	};
	{
		display_name = _('');
		beaconId = 'airfield6_6';
		type = BEACON_TYPE_ILS_GLIDESLOPE;
		callsign = 'IKK';
		frequency = 110700000.000000;
		position = { -133752.968750, 12.000012, -42644.976563 };
		direction = -145.184003;
		positionGeo = { latitude = 33.805173, longitude = 35.484721 };
		sceneObjects = {'t:770443094'};
		chartOffsetX = 4140.000000;
	};
	{
		display_name = _('BEIRUT');
		beaconId = 'airfield6_7';
		type = BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER;
		callsign = 'BOD';
		frequency = 351000.000000;
		position = { -122843.140625, 3.000003, -42540.902344 };
		direction = 0.000000;
		positionGeo = { latitude = 33.903416, longitude = 35.481814 };
		sceneObjects = {'t:309297178'};
	};
	{
		display_name = _('');
		beaconId = 'airfield7_0';
		type = BEACON_TYPE_ILS_GLIDESLOPE;
		callsign = 'IDA';
		frequency = 109900000.000000;
		position = { -177673.234375, 612.000612, 53046.078125 };
		direction = 52.625842;
		positionGeo = { latitude = 33.434538, longitude = 36.528631 };
		sceneObjects = {'t:740229243'};
	};
	{
		display_name = _('');
		beaconId = 'airfield7_1';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'IDA';
		frequency = 109900000.000000;
		position = { -180064.953125, 612.000612, 50398.371094 };
		direction = 49.999989;
		positionGeo = { latitude = 33.412415, longitude = 36.500792 };
		sceneObjects = {'t:269844804'};
		chartOffsetX = 4063.000000;
	};
	{
		display_name = _('Damascus');
		beaconId = 'airfield7_2';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'DAM';
		frequency = 116000000.000000;
		position = { -185235.656250, 609.969482, 47226.804688 };
		direction = 0.000000;
		positionGeo = { latitude = 33.365131, longitude = 36.468066 };
		sceneObjects = {'t:87198373'};
	};
	{
		display_name = _('');
		beaconId = 'airfield7_3';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'DAML';
		frequency = 111100000.000000;
		position = { -180656.640625, 612.000673, 52815.601563 };
		direction = -130.000016;
		positionGeo = { latitude = 33.407604, longitude = 36.526916 };
		sceneObjects = {'t:267361870'};
		chartOffsetX = 3926.000000;
	};
	{
		display_name = _('DAMASCUS');
		beaconId = 'airfield7_4';
		type = BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER;
		callsign = 'DAL';
		frequency = 342000000.000000;
		position = { -171986.156250, 592.209210, 60026.417969 };
		direction = 0.000000;
		positionGeo = { latitude = 33.487262, longitude = 36.602245 };
		sceneObjects = {'t:35949591'};
	};
	{
		display_name = _('ABYAD');
		beaconId = 'airfield7_5';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'ABD';
		frequency = 264000.000000;
		position = { -188453.578125, 627.344011, 43443.796875 };
		direction = 0.000000;
		positionGeo = { latitude = 33.335299, longitude = 36.428295 };
		sceneObjects = {'t:34144297'};
	};
	{
		display_name = _('');
		beaconId = 'airfield7_6';
		type = BEACON_TYPE_ILS_GLIDESLOPE;
		callsign = 'DAML';
		frequency = 111100000.000000;
		position = { -183014.953125, 612.000673, 50184.816406 };
		direction = -130.000001;
		positionGeo = { latitude = 33.385786, longitude = 36.499259 };
		sceneObjects = {'t:735707876'};
	};
	{
		display_name = _('DEIR_EZ-ZOR');
		beaconId = 'airfield42_0';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'DRZ';
		frequency = 295000.000000;
		position = { 25885.554688, 207.272516, 390774.875000 };
		direction = 0.000000;
		positionGeo = { latitude = 35.289111, longitude = 40.187417 };
		sceneObjects = {'t:409666420'};
	};
	{
		display_name = _('DEIR_EZ-ZOR');
		beaconId = 'airfield42_1';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'DRZ';
		frequency = 117000000.000000;
		position = { 26163.650391, 215.063020, 387712.218750 };
		direction = 0.000000;
		positionGeo = { latitude = 35.291944, longitude = 40.153778 };
		sceneObjects = {'t:127242781'};
	};
	{
		display_name = _('ERCAN');
		beaconId = 'airfield49_0';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'ECN';
		frequency = 117000000.000000;
		position = { 24471.242188, 95.000087, -219165.546875 };
		direction = -29.411821;
		positionGeo = { latitude = 35.156671, longitude = 33.491449 };
		sceneObjects = {'t:402329418'};
	};
	{
		display_name = _('');
		beaconId = 'airfield49_1';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'IECR';
		frequency = 108300000.000000;
		position = { 24896.134766, 95.000095, -219711.640625 };
		direction = 114.367010;
		positionGeo = { latitude = 35.160212, longitude = 33.485222 };
		sceneObjects = {'t:407047976'};
		chartOffsetX = 3027.000000;
	};
	{
		display_name = _('');
		beaconId = 'airfield11_0';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'IGNP';
		frequency = 109100000.000000;
		position = { 210811.390625, 702.613435, 145646.171875 };
		direction = 105.990001;
		positionGeo = { latitude = 36.952192, longitude = 37.459536 };
		sceneObjects = {'t:578488673'};
		chartOffsetX = 3230.000000;
	};
	{
		display_name = _('');
		beaconId = 'airfield11_1';
		type = BEACON_TYPE_ILS_GLIDESLOPE;
		callsign = 'IGNP';
		frequency = 109100000.000000;
		position = { 209897.875000, 670.317138, 148451.203125 };
		direction = 106.808504;
		positionGeo = { latitude = 36.944364, longitude = 37.491193 };
		sceneObjects = {'t:1132658830'};
		chartOffsetX = 3230.000000;
	};
	{
		display_name = _('GAZIANTEP');
		beaconId = 'airfield11_2';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'GAZ';
		frequency = 432000.000000;
		position = { 210917.500000, 693.557456, 146450.375000 };
		direction = 0.000000;
		positionGeo = { latitude = 36.953265, longitude = 37.468546 };
		sceneObjects = {'t:578521221'};
	};
	{
		display_name = _('GAZIANTEP');
		beaconId = 'airfield11_3';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'GAZ';
		frequency = 116700000.000000;
		position = { 210721.703125, 688.106035, 146838.281250 };
		direction = 0.000000;
		positionGeo = { latitude = 36.951556, longitude = 37.472937 };
		sceneObjects = {'t:169543333'};
	};
	{
		display_name = _('');
		beaconId = 'airfield41_0';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'IGZP';
		frequency = 108500000.000000;
		position = { 158246.453125, 41.617138, -318053.000000 };
		direction = -94.354002;
		positionGeo = { latitude = 36.300667, longitude = 32.312367 };
		sceneObjects = {'t:520134007'};
		chartOffsetX = 2585.500000;
	};
	{
		display_name = _('ALANYA/GAZIPASA');
		beaconId = 'airfield41_1';
		type = BEACON_TYPE_DME;
		callsign = 'GZP';
		frequency = 0.000000;
		channel = 89;
		position = { 158055.437500, 26.645849, -319162.156250 };
		direction = 30.136678;
		positionGeo = { latitude = 36.298267, longitude = 32.300245 };
		sceneObjects = {'t:153026884'};
	};
	{
		display_name = _('GAZIPASA/ALANYA');
		beaconId = 'airfield41_2';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'GZP';
		frequency = 316000.000000;
		position = { 158253.984375, 27.102293, -319167.562500 };
		direction = -63.025353;
		positionGeo = { latitude = 36.300041, longitude = 32.300032 };
		sceneObjects = {'t:520134006'};
	};
	{
		display_name = _('FAMAGUSTA_GECITKALE');
		beaconId = 'airfield50_0';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'GKE';
		frequency = 114300000.000000;
		position = { 31834.185547, 45.000045, -197182.593750 };
		direction = -55.385914;
		positionGeo = { latitude = 35.233502, longitude = 33.727477 };
		sceneObjects = {'t:412454981'};
	};
	{
		display_name = _('GECITKALE');
		beaconId = 'airfield50_1';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'GKE';
		frequency = 435000.000000;
		position = { 31577.271484, 45.000045, -195761.718750 };
		direction = -111.535787;
		positionGeo = { latitude = 35.231874, longitude = 33.743176 };
		sceneObjects = {'t:412549569'};
	};
	{
		display_name = _('HATAY');
		beaconId = 'airfield15_0';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'HTY';
		frequency = 112050000.000000;
		position = { 147753.046875, 77.282517, 39662.273438 };
		direction = -45.690008;
		positionGeo = { latitude = 36.362972, longitude = 36.290113 };
		sceneObjects = {'t:151721059'};
	};
	{
		display_name = _('');
		beaconId = 'airfield15_1';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'IHAT';
		frequency = 108900000.000000;
		position = { 149019.375000, 79.613071, 40718.835938 };
		direction = -135.689998;
		positionGeo = { latitude = 36.374642, longitude = 36.301483 };
		sceneObjects = {'t:513347561'};
		chartOffsetX = 3421.000000;
	};
	{
		display_name = _('');
		beaconId = 'airfield15_2';
		type = BEACON_TYPE_ILS_GLIDESLOPE;
		callsign = 'IHAT';
		frequency = 108900000.000000;
		position = { 146921.406250, 77.175828, 38518.476563 };
		direction = -136.812009;
		positionGeo = { latitude = 36.355193, longitude = 36.277639 };
		sceneObjects = {'t:1025311918'};
	};
	{
		display_name = _('HATAY');
		beaconId = 'airfield15_3';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'HTY';
		frequency = 336000.000000;
		position = { 147771.703125, 77.308656, 39693.753906 };
		direction = -45.690008;
		positionGeo = { latitude = 36.363148, longitude = 36.290458 };
		sceneObjects = {'t:513347560'};
	};
	{
		display_name = _('INCIRLIC');
		beaconId = 'airfield16_0';
		type = BEACON_TYPE_TACAN;
		callsign = 'DAN';
		channel = 21;
		position = { 222639.437500, 73.699811, -33216.257813 };
		direction = 0.000000;
		positionGeo = { latitude = 37.015611, longitude = 35.448194 };
		sceneObjects = {'t:594349479'};
	};
	{
		display_name = _('');
		beaconId = 'airfield16_1';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'IDAN';
		frequency = 109300000.000000;
		position = { 222315.812500, 73.638211, -33655.464844 };
		direction = -125.002995;
		positionGeo = { latitude = 37.012552, longitude = 35.443402 };
		sceneObjects = {'t:594348422'};
		chartOffsetX = 3617.000000;
	};
	{
		display_name = _('');
		beaconId = 'airfield16_2';
		type = BEACON_TYPE_ILS_GLIDESLOPE;
		callsign = 'IDAN';
		frequency = 109300000.000000;
		position = { 220377.484375, 48.478762, -36217.171875 };
		direction = -125.000001;
		positionGeo = { latitude = 36.994247, longitude = 35.415483 };
		sceneObjects = {'t:1148815222'};
		chartOffsetX = 3617.000000;
	};
	{
		display_name = _('');
		beaconId = 'airfield16_3';
		type = BEACON_TYPE_ILS_GLIDESLOPE;
		callsign = 'IDNA';
		frequency = 111700000.000000;
		position = { 222001.125000, 63.883437, -34347.218750 };
		direction = 55.000018;
		positionGeo = { latitude = 37.009487, longitude = 35.435774 };
		sceneObjects = {'t:1152224100'};
	};
	{
		display_name = _('');
		beaconId = 'airfield16_4';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'IDNA';
		frequency = 111700000.000000;
		position = { 220088.968750, 47.390974, -36832.261719 };
		direction = 54.996984;
		positionGeo = { latitude = 36.991443, longitude = 35.408706 };
		sceneObjects = {'t:587694170'};
		chartOffsetX = 3639.000000;
	};
	{
		display_name = _('');
		beaconId = 'airfield47_0';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'ILC';
		frequency = 110300000.000000;
		position = { -8990.810547, 7.217739, -210314.343750 };
		direction = 48.171958;
		positionGeo = { latitude = 34.860647, longitude = 33.608001 };
		sceneObjects = {'t:370577419'};
		chartOffsetX = 3620.000000;
	};
	{
		display_name = _('Larnaca');
		beaconId = 'airfield47_1';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'LCA';
		frequency = 112800000.000000;
		position = { -7711.266602, 6.441702, -208672.828125 };
		direction = 47.364518;
		positionGeo = { latitude = 34.872928, longitude = 33.625131 };
		sceneObjects = {'t:118620903'};
	};
	{
		display_name = _('');
		beaconId = 'airfield47_2';
		type = BEACON_TYPE_ILS_GLIDESLOPE;
		callsign = 'ILC';
		frequency = 110300000.000000;
		position = { -6842.452099, 5.000005, -208095.043820 };
		direction = 49.274376;
		positionGeo = { latitude = 34.881007, longitude = 33.630916 };
		sceneObjects = {'t:847577536'};
	};
	{
		display_name = _('Larnaca');
		beaconId = 'airfield47_3';
		type = BEACON_TYPE_HOMER;
		callsign = 'LCA';
		frequency = 432000.000000;
		position = { -12868.368164, 6.492096, -214644.968750 };
		direction = 0.000000;
		positionGeo = { latitude = 34.823731, longitude = 33.563132 };
		sceneObjects = {'t:116982362'};
	};
	{
		display_name = _('');
		beaconId = 'airfield21_0';
		type = BEACON_TYPE_ILS_GLIDESLOPE;
		callsign = 'IBA';
		frequency = 109100000.000000;
		position = { 43061.328125, 28.398050, 5722.375977 };
		direction = -1.444000;
		positionGeo = { latitude = 35.411243, longitude = 35.948708 };
		sceneObjects = {'t:-1850081279'};
	};
	{
		display_name = _('');
		beaconId = 'airfield21_1';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'IBA';
		frequency = 109100000.000000;
		position = { 40423.035156, 25.704942, 5693.940918 };
		direction = -1.444000;
		positionGeo = { latitude = 35.387480, longitude = 35.949291 };
		sceneObjects = {'t:-1850081280'};
		chartOffsetX = 3027.000000;
	};
	{
		display_name = _('LATAKIA');
		beaconId = 'airfield21_2';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'LTK';
		frequency = 114800000.000000;
		position = { 41444.796875, 27.958673, 5975.583496 };
		direction = 0.000000;
		positionGeo = { latitude = 35.396758, longitude = 35.952041 };
		sceneObjects = {'t:129730047'};
	};
	{
		display_name = _('LATAKIA');
		beaconId = 'airfield21_3';
		type = BEACON_TYPE_HOMER;
		callsign = 'LTK';
		frequency = 414000.000000;
		position = { 50737.488281, 121.697601, 5622.082031 };
		direction = -1.444000;
		positionGeo = { latitude = 35.480331, longitude = 35.944991 };
		sceneObjects = {'t:49480366'};
	};
	{
		display_name = _('MEZZEH');
		beaconId = 'airfield25_0';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'MEZ';
		frequency = 358000.000000;
		position = { -171265.828125, 727.811031, 25122.662109 };
		direction = 0.000000;
		positionGeo = { latitude = 33.485917, longitude = 36.226722 };
		sceneObjects = {'t:276268441'};
	};
	{
		display_name = _('ALEPPO');
		beaconId = 'airfield27_0';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'ALE';
		frequency = 396000.000000;
		position = { 126175.296875, 382.191026, 123040.015625 };
		direction = 0.000000;
		positionGeo = { latitude = 36.185997, longitude = 37.223297 };
		sceneObjects = {'t:487620738'};
	};
	{
		display_name = _('ALEPPO');
		beaconId = 'airfield27_1';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'MER';
		frequency = 365000.000000;
		position = { 124610.679688, 372.975593, 130592.070313 };
		direction = 0.000000;
		positionGeo = { latitude = 36.173114, longitude = 37.307553 };
		sceneObjects = {'t:487687686'};
	};
	{
		display_name = _('ALEPPO');
		beaconId = 'airfield27_2';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'ALE';
		frequency = 114500000.000000;
		position = { 125497.867188, 382.191026, 121775.375000 };
		direction = 0.000000;
		positionGeo = { latitude = 36.179683, longitude = 37.209378 };
		sceneObjects = {'t:145230030'};
	};
	{
		display_name = _('PALMYRA');
		beaconId = 'airfield28_0';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'PLR';
		frequency = 363000.000000;
		position = { -55843.890625, 413.873095, 215545.687500 };
		direction = 0.000000;
		positionGeo = { latitude = 34.555739, longitude = 38.266916 };
		sceneObjects = {'t:336141688'};
	};
	{
		display_name = _('PALMYRA');
		beaconId = 'airfield28_1';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'PAL';
		frequency = 337000.000000;
		position = { -56185.023438, 388.136313, 218419.765625 };
		direction = 0.000000;
		positionGeo = { latitude = 34.552847, longitude = 38.298267 };
		sceneObjects = {'t:336168820'};
	};
	{
		display_name = _('Pafos');
		beaconId = 'airfield46_0';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'PHA';
		frequency = 328000.000000;
		position = { -18611.082031, 10.003174, -314997.281250 };
		direction = 23.966996;
		positionGeo = { latitude = 34.718456, longitude = 32.476168 };
		sceneObjects = {'t:361072450'};
	};
	{
		display_name = _('');
		beaconId = 'airfield46_1';
		type = BEACON_TYPE_ILS_GLIDESLOPE;
		callsign = 'IPA';
		frequency = 108900000.000000;
		position = { -19225.234375, 11.331800, -313313.031250 };
		direction = 113.967035;
		positionGeo = { latitude = 34.713934, longitude = 32.494877 };
		sceneObjects = {'t:829589465'};
	};
	{
		display_name = _('');
		beaconId = 'airfield46_2';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'IPA';
		frequency = 108900000.000000;
		position = { -18026.191406, 11.641539, -315715.781250 };
		direction = 113.966978;
		positionGeo = { latitude = 34.723276, longitude = 32.467959 };
		sceneObjects = {'t:361040805'};
		chartOffsetX = 3055.000000;
	};
	{
		display_name = _('Pafos');
		beaconId = 'airfield46_3';
		type = BEACON_TYPE_DME;
		callsign = 'IPA';
		frequency = 108900000.000000;
		position = { -19244.414063, 11.222618, -313349.875000 };
		direction = 23.966996;
		positionGeo = { latitude = 34.713741, longitude = 32.494490 };
		sceneObjects = {'t:361071652'};
	};
	{
		display_name = _('Pafos');
		beaconId = 'airfield46_4';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'PHA';
		frequency = 117900000.000000;
		position = { -19535.277344, 11.677918, -312322.156250 };
		direction = 23.966996;
		positionGeo = { latitude = 34.711733, longitude = 32.505846 };
		sceneObjects = {'t:114951919'};
	};
	{
		display_name = _('Pafos');
		beaconId = 'airfield46_5';
		type = BEACON_TYPE_TACAN;
		callsign = 'PHA';
		channel = 79;
		position = { -18853.347656, 10.537752, -314408.500000 };
		direction = 23.966996;
		positionGeo = { latitude = 34.716628, longitude = 32.482728 };
		sceneObjects = {'t:361072212'};
	};
	{
		display_name = _('RAMATDAVID');
		beaconId = 'airfield30_0';
		type = BEACON_TYPE_AIRPORT_HOMER;
		callsign = 'RMD';
		frequency = 368000.000000;
		position = { -259542.296875, 42.067127, -74613.953125 };
		direction = 0.000000;
		positionGeo = { latitude = 32.662780, longitude = 35.189551 };
		sceneObjects = {'t:75730545'};
	};
	{
		display_name = _('RAMATDAVID');
		beaconId = 'airfield30_1';
		type = BEACON_TYPE_VORTAC;
		callsign = 'RMD';
		frequency = 113700000.000000;
		channel = 84;
		position = { -259304.093750, 41.573772, -74774.546875 };
		direction = 15.278860;
		positionGeo = { latitude = 32.664872, longitude = 35.187751 };
		sceneObjects = {'t:223019818'};
	};
	{
		display_name = _('');
		beaconId = 'airfield30_2';
		type = BEACON_TYPE_ILS_LOCALIZER;
		callsign = 'RMD';
		frequency = 111100000.000000;
		position = { -257894.421875, 41.832523, -75916.710938 };
		direction = 146.477722;
		positionGeo = { latitude = 32.677190, longitude = 35.175056 };
		sceneObjects = {'t:225575082'};
		chartOffsetX = 2803.900000;
	};
	{
		display_name = _('');
		beaconId = 'airfield30_3';
		type = BEACON_TYPE_ILS_GLIDESLOPE;
		callsign = 'RMD';
		frequency = 111100000.000000;
		position = { -259880.625000, 42.289189, -74462.875000 };
		direction = -119.374671;
		positionGeo = { latitude = 32.659784, longitude = 35.191288 };
		sceneObjects = {'t:671483271'};
	};
	{
		display_name = _('ROSH-PINA');
		beaconId = 'airfield34_0';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'ROP';
		frequency = 115300000.000000;
		position = { -225297.281250, 261.503649, -37497.257813 };
		direction = 0.000000;
		positionGeo = { latitude = 32.982528, longitude = 35.572778 };
		sceneObjects = {'t:82051195'};
	};
	{
		display_name = _('Cheka');
		beaconId = 'airfield40_0';
		type = BEACON_TYPE_VOR_DME;
		callsign = 'CAK';
		frequency = 116200000.000000;
		position = { -79459.062500, 196.905226, -20936.335938 };
		direction = 0.000000;
		positionGeo = { latitude = 34.300489, longitude = 35.699946 };
		sceneObjects = {'t:107742274'};
	};
}
