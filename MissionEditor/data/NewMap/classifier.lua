-- 
local translate = ...
local fontName = 'DejaVuLGCSansCondensed.ttf'

if not translate then
	translate = function(arg)
		return arg
	end  
end

_ = translate

local function Layer(title)
	return {
		title = title,	-- название
		
		LocalizedTitle = function(self, text)
			self.localizedTitle = text -- локализованное название
			return self
		end,
		
		Order = function(self, order)
			self.order = order	-- порядок в стеке слоев - 1 - самый нижний слой
			return self
		end,
		
		Switchable = function(self, switchable)
			self.switchable = switchable	-- пользователь управляет видимостью слоя
			return self
		end,
		
		Visible	= function(self, visible)
			self.visible = visible			-- слой виден при загрузке карты
			return self
		end,
	}
end

return {

	iconsPaths  = {"MissionEditor/data/NewMap/images/common/"}, -- for common ,  theme folders added  inside 
	-- список слоев карты
	layers = {
		[1]		= Layer('RIVERS')			:LocalizedTitle(_("RIVERS"))			:Order(1)	:Switchable(true)	:Visible(true),
		[6]		= Layer('FORESTS')			:LocalizedTitle(_("FORESTS"))			:Order(2)	:Switchable(true)	:Visible(true), 		
		[7]		= Layer('TOWNS')			:LocalizedTitle(_("TOWNS"))				:Order(3)	:Switchable(true)	:Visible(true),	
		
		[5]		= Layer('ROADS')			:LocalizedTitle(_("ROADS"))				:Order(5)	:Switchable(true)	:Visible(true), 
		[8]		= Layer('RAILWAYS')			:LocalizedTitle(_("RAILWAYS"))			:Order(6)	:Switchable(true)	:Visible(true), 
		[14]	= Layer('AIRPORTS') 		:LocalizedTitle(_("AIRPORTS"))			:Order(7)	:Switchable(true)	:Visible(true), 
		[4]		= Layer('BUILDINGS')		:LocalizedTitle(_("BUILDINGS"))			:Order(8)	:Switchable(true)	:Visible(true), 
		[15]	= Layer('MGRS GRID')		:LocalizedTitle(_("MGRS GRID"))			:Order(9)	:Switchable(true)	:Visible(true), 
		[10]	= Layer('ELECTRIC POWER TRANSMISSION')
											:LocalizedTitle(_("ELECTRIC POWER TRANSMISSION"))
																					:Order(10)	:Switchable(true)	:Visible(true), 
		[11]	= Layer('GEOGRAPHICAL GRID'):LocalizedTitle(_("GEOGRAPHICAL GRID"))	:Order(11)	:Switchable(true)	:Visible(true), 		
		[9]		= Layer('USER OBJECTS')		:LocalizedTitle(_("USER OBJECTS"))		:Order(100)	:Switchable(true)	:Visible(true), 
		[2]		= Layer('SUPPLIERS OBJECTS'):LocalizedTitle(_("SUPPLIERS OBJECTS"))	:Order(200)	:Switchable(false)	:Visible(false),
		[16]	= Layer('PARKINGS')			:LocalizedTitle(_("PARKINGS"))			:Order(13)	:Switchable(true)	:Visible(true), 
		[17]	= Layer('GEO NAME')			:LocalizedTitle(_("GEO NAMES"))			:Order(14)	:Switchable(true)	:Visible(true), 
		[20]	= Layer('DRAWINGS')			:LocalizedTitle(_("DRAWINGS"))			:Order(300)	:Switchable(true)	:Visible(true), 
	},
	
	objects = 
	{
		P0091000075 = 
		{
			type = "DOT",
			title = "БЛИНДАЖ",
			minScale = 1,
			layer = 9,
			file = "P91000075.png",
			maxScale = 40000000,
		},
		P0091000011 = 
		{
			type = "DOT",
			title = "ЗРК МАЛОЙ ДАЛЬНОСТИ",
			minScale = 1,
			layer = 9,
			file = "P91000011.png",
			maxScale = 40000000,
		},
		P0091000002 = 
		{
			type = "DOT",
			title = "БОЕВАЯ МАШИНА ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000002.png",
			maxScale = 40000000,
		},
		P0091000076 = 
		{
			type = "DOT",
			title = "ЗДАНИЕ, СООРУЖЕНИЕ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000076.png",
			maxScale = 40000000,
		},
		P0091000045 = 
		{
			type = "DOT",
			title = "ПУНКТ УПРАВЛЕНИЯ ИСТРЕБИТЕЛЕЙ",
			minScale = 1,
			layer = 9,
			file = "P91000045.png",
			maxScale = 40000000,
		},
		P0091000215 = 
		{
			type = "DOT",
			title = "POINT 215",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000215.png",
			maxScale = 40000000,
		},
		P0091000001 = 
		{
			
			type = "DOT",
			title = "ТАНК",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000001.png",
			maxScale = 40000000,
		},
		P0091000038 = 
		{
			type = "DOT",
			title = "ПОДВОДНАЯ ЛОДКА",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000038.png",
			maxScale = 40000000,
		},
        P91000108 =
        {
            type = "DOT",
			title = "ПОЕЗД",
			rotatable = false,
			minScale = 1,
			layer = 9,
			file = "P91000108.png",
			maxScale = 40000000,
        },
        P91000109 =
        {
            type = "DOT",
			title = "BARRAGE BALLOON",
			rotatable = false,
			minScale = 1,
			layer = 9,
			file = "P91000109.png",
			maxScale = 40000000,
        },
		P0091000029 = 
		{
			type = "DOT",
			title = "САМОЛЁТ ТРАНСПОРТНЫЙ",
			file = "P91000029.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		P0091000046 = 
		{
			type = "DOT",
			title = "ПУНКТ НАВЕДЕНИЯ И ЦЕЛЕУКАЗАНИЯ",
			minScale = 1,
			layer = 9,
			file = "P91000046.png",
			maxScale = 40000000,
		},
		P0091000071 = 
		{
			type = "DOT",
			title = "КОМАНДНЫЙ ПУНКТ",
			minScale = 1,
			layer = 9,
			file = "P91000071.png",
			maxScale = 40000000,
		},
		P0091000047 = 
		{
			type = "DOT",
			title = "ГРУППА БОЕВОГО УПРАВЛЕНИЯ",
			minScale = 1,
			layer = 9,
			file = "P91000047.png",
			maxScale = 40000000,
		},
		P0091000218 = 
		{
			type = "DOT",
			title = "POINT 218",
			minScale = 1,
			layer = 9,
			file = "P91000218.png",
			maxScale = 40000000,
		},
		P0091000209 = 
		{
			type = "DOT",
			title = "POINT 209",
			minScale = 1,
			layer = 9,
			file = "P91000209.png",
			maxScale = 40000000,
		},
		P0091000016 = 
		{
			
			type = "DOT",
			title = "ЗСУ ОБЩЕГО НАЗНАЧЕНИЯ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000016.png",
			maxScale = 40000000,
		},
		P0091000083 = 
		{
			type = "DOT",
			title = "МОБИЛЬНАЯ РЛС",
			minScale = 1,
			layer = 9,
			file = "P91000083.png",
			maxScale = 40000000,
		},
		P0091000068 = 
		{
			
			type = "DOT",
			title = "БОЛЬШОЙ КОРАБЛЬ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000068.png",
			maxScale = 40000000,
		},
		P0091000214 = 
		{
			
			type = "DOT",
			title = "POINT 214",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000214.png",
			maxScale = 40000000,
		},
		P0091000015 = 
		{
			type = "DOT",
			title = "ЗЕНИТНЫЕ ОРУДИЯ",
			file = "P91000015.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		P0091000037 = 
		{
			
			type = "DOT",
			title = "КОРАБЛЬ НАДВОДНЫЙ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000037.png",
			maxScale = 40000000,
		},
		P0091000205 = 
		{
			
			type = "DOT",
			title = "POINT 205",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000205.png",
			maxScale = 40000000,
		},
		P0091000207 = 
		{
			type = "DOT",
			title = "POINT 207",
			minScale = 1,
			layer = 9,
			file = "P91000207.png",
			maxScale = 40000000,
		},
		P0091000021 = 
		{
			type = "DOT",
			title = "ВЕРТОЛЁТ БОЕВОЙ",
			file = "P91000021.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		TriggerZoneSelectionBorder = 
		{
			type = "LIN",
			title = "TRIGGER ZONE SELECTION BORDER",
			minScale = 1,
			layer = 9,
			maxScale = 40000000,
		},
		P0091000044 = 
		{
			type = "DOT",
			title = "ЦЕЛЬ ОСНОВНАЯ",
			minScale = 1,
			layer = 9,
			file = "P91000044.png",
			maxScale = 40000000,
		},
		P0091000003 = 
		{
			
			type = "DOT",
			title = "БОЕВАЯ РАЗВЕДЫВАТЕЛЬНАЯ МАШИНА",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000003.png",
			maxScale = 40000000,
		},
		P0091000050 = 
		{
			
			type = "DOT",
			title = "АВИАЦИОННЫЙ НАВОДЧИК ПОДВИЖНЫЙ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000050.png",
			maxScale = 40000000,
		},
		P0091000078 = 
		{
			
			type = "DOT",
			title = "ПУ ЗРК БД С РАДАРОМ НА ГШ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000078.png",
			maxScale = 40000000,
		},
		P0091000025 = 
		{
			type = "DOT",
			title = "ШТУРМОВИК",
			file = "P91000025.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		P0091000013 = 
		{
			type = "DOT",
			title = "ЗРК ДАЛЬНЕГО ДЕЙСТВИЯ",
			minScale = 1,
			layer = 9,
			file = "P91000013.png",
			maxScale = 40000000,
		},
		P0091000014 = 
		{
			
			type = "DOT",
			title = "ЗРК ПУШЕЧНО-РАКЕТНЫЙ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000014.png",
			maxScale = 40000000,
		},
		S_companyPos = 
		{
			type = "SQR",
			title = "Company position",
			color =	 {0, 1, 0, 0.5},
			minScale = 1,
			layer = 9,
			borderColor =  {0, 0, 0},
			maxScale = 1000000,
		},
		P_battleNodePos = 
		{
			type = "DOT",
			title = "Battle node position",
			file = "P_battleNodePos.png",
			minScale = 1,
			layer = 9,
			rotatable = false,
			maxScale = 40000000,
		},
		S0000000528 = 
		{
			type = "SQR",
			title = "ЗОНА ТРИГГЕРА",
			color =	 {131 / 255, 1, 1, 0.05},
			minScale = 1,
			layer = 9,
			borderColor =  {0, 0, 0}, --{168 / 255, 84 / 255, 0},
			maxScale = 40000000,
		},
		TriggerZone = 
		{
			type = "SQR",
			title = "ЗОНА ТРИГГЕРА",
			color =	 {131 / 255, 1, 1, 0.05},
			minScale = 1,
			maxScale = 40000000,
			layer = 9,
			borderColor =  {0, 0, 0, 0}, --{168 / 255, 84 / 255, 0},	
		},
		TriggerZoneSelected = 
		{
			type = "SQR",
			title = "ЗОНА ТРИГГЕРА ВЫДЕЛЕН",
			color =	 {1, 1, 0, 76 / 255},
			minScale = 1,
			maxScale = 40000000,
			layer = 9,
			borderColor =  {0, 0, 0, 0}, --{168 / 255, 84 / 255, 0},	
		},		
		P0091000086 = 
		{
			
			type = "DOT",
			title = "ПУ ЗРК МД НА ГШ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000086.png",
			maxScale = 40000000,
		},
		P0091000054 = 
		{
			type = "DOT",
			title = "ЗРК СРЕДНЕЙ ДАЛЬНОСТИ",
			minScale = 1,
			layer = 9,
			file = "P91000054.png",
			maxScale = 40000000,
		},
		P0091000206 = 
		{
			type = "DOT",
			title = "POINT 206",
			minScale = 1,
			layer = 9,
			file = "P91000206.png",
			maxScale = 40000000,
		},
		P0091001206 = 
		{
			type = "DOT",
			title = "NAV TARGET POINT",
			minScale = 1,
			layer = 9,
			file = "P91001206.png",
			maxScale = 40000000,
		},
		POINTDATACARTRIDGE_ROUND = 
		{
			type = "DOT",
			title = "POINTDATACARTRIDGE_ROUND",
			minScale = 1,
			layer = 9,
			file = "navigation_point.png",
			maxScale = 40000000,
		},
		POINTDATACARTRIDGE_SQUARE = 
		{
			type = "DOT",
			title = "POINTDATACARTRIDGE_SQUARE",
			minScale = 1,
			layer = 9,
			file = "P91001206.png",
			maxScale = 40000000,
		},
		POINTDATACARTRIDGE_TRIANGLE = 
		{
			type = "DOT",
			title = "POINTDATACARTRIDGE_TRIANGLE",
			minScale = 1,
			layer = 9,
			file = "F18_triangle_point.png",
			maxScale = 40000000,
		},

		P0091000213 = 
		{
			
			type = "DOT",
			title = "POINT 213",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000213.png",
			maxScale = 40000000,
		},
		P0091000043 = 
		{
			type = "DOT",
			title = "ЦЕЛЬ ДОПОЛНИТЕЛЬНАЯ",
			minScale = 1,
			layer = 9,
			file = "P91000043.png",
			maxScale = 40000000,
		},
		P0091000042 = 
		{
			type = "DOT",
			title = "КОНЕЧНАЯ ТОЧКА МАРШРУТА",
			minScale = 1,
			layer = 9,
			file = "P91000042.png",
			maxScale = 40000000,
		},
		P0091000036 = 
		{
			type = "DOT",
			title = "РАДИОЛОКАЦИОННАЯ СТАНЦИЯ",
			minScale = 1,
			layer = 9,
			file = "P91000036.png",
			maxScale = 40000000,
		},
		P0091000080 = 
		{
			
			type = "DOT",
			title = "ПУ ЗРК СД НА ГШ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000080.png",
			maxScale = 40000000,
		},
		AirdromeClass1 = 
		{
			type = "DOT",
			title = "АЭРОДРОМ ПЕРВОГО КЛАССА",
			minScale = 200000,
			layer = 14,
			file = "airdrome_class_1.png",
			maxScale = 10000000,
		},
		AirdromeClass2 = 
		{
			type = "DOT",
			title = "АЭРОДРОМ ВТОРОГО КЛАССА",
			minScale = 200000,
			layer = 14,
			file = "airdrome_class_2.png",
			maxScale = 10000000,
		},
		AirdromeClass3 = 
		{
			type = "DOT",
			title = "АЭРОДРОМ ТРЕТЬЕГО КЛАССА",
			minScale = 200000,
			layer = 14,
			file = "airdrome_class_3.png",
			maxScale = 10000000,
		},
		AirdromeClassNone = 
		{
			type = "DOT",
			title = "АЭРОДРОМ ОБЩЕГО НАЗНАЧЕНИЯ",
			minScale = 200000,
			layer = 14,
			file = "airdrome_class_none.png",
			maxScale = 10000000,
		},     
		AirdromeGrass = 
		{
			type = "DOT",
			title = "АЭРОДРОМ ГРУНТОВЫЙ",
			minScale = 200000,
			layer = 14,
			file = "airdrome_grass.png",
			maxScale = 10000000,
		},
        P_AirdromeGrass = 
		{
			type = "DOT",
			title = "АЭРОДРОМ ГРУНТОВЫЙ",
			minScale = 1,
			layer = 9,
			file = "airdrome_class_none.png",
			maxScale = 10000000,
		},
		WarehouseSupplierIcon = 
		{
			type = "DOT",
			title = "ИНДИКАТОР ПОСТАВЩИКОВ (СТАТИКИ)",
			minScale = 1000,
			layer = 2,
			file = "warehouse_supplier.png",
			maxScale = 10000000,
		},
		AirdromeSupplierIcon = 
		{
			type = "DOT",
			title = "ИНДИКАТОР ПОСТАВЩИКОВ",
			minScale = 1000,
			layer = 2,
			file = "airdrome_supplier.png",
			maxScale = 10000000,
		},
		AirdromeWarehouseTerrain = 
		{
			type = "DOT",
			title = "СКЛАД АЭРОДРОМА",
			minScale = 1000,
			layer = 9,
			file = "P91000072.png",
			maxScale = 5000,
		},
		AirdromeWarehouseTerrainOneLvl = 
		{
			type = "DOT",
			title = "СКЛАД АЭРОДРОМА",
			minScale = 5001,
			layer = 9,
			file = "P91000072.png",
			maxScale = 10000,
		},
		
		AirdromeWarehouseTerrainTwoLvl = 
		{
			type = "DOT",
			title = "СКЛАД АЭРОДРОМА",
			minScale = 10001,
			layer = 9,
			file = "P91000072.png",
			maxScale = 50000,
		},
		
		AirdromeFueldepotsTerrain = 
		{
			type = "DOT",
			title = "ГСМ АЭРОДРОМА",
			minScale = 1000,
			layer = 9,
			file = "P91000207.png",
			maxScale = 5000,
		},
		AirdromeFueldepotsTerrainOneLvl = 
		{
			type = "DOT",
			title = "СКЛАД АЭРОДРОМА",
			minScale = 5001,
			layer = 9,
			file = "P91000207.png",
			maxScale = 10000,
		},
		AirdromeFueldepotsTerrainTwoLvl = 
		{
			type = "DOT",
			title = "СКЛАД АЭРОДРОМА",
			minScale = 10001,
			layer = 9,
			file = "P91000207.png",
			maxScale = 50000,
		},
		AirdromeWarehouse = 
		{
			type = "SQR",
			title = "СКЛАД НА АЭРОДРОМЕ",
			minScale = 1000,
			layer = 14,
			color =	 {1, 0, 0, 0},
			maxScale = 10000000,
			borderColor = {0, 0, 0, 0},
		},
		AirdromeCircleZoneBorder = 
		{
			type		= "LIN",
			title		= "ГРАНИЦА ЗОНЫ АЭРОДРОМА",
			maxScale	= 10000000,
			minScale	= 1000,
			layer		= 14,
			color		= {0, 0, 0, 0.7},
		},
		SupplierArrow = {
			type		= "SQR",
			title		= "СТРЕЛКА ПОСТАВЩИКОВ",
			maxScale	= 10000000,			
			minScale	= 1000,
			layer		= 2,
			color		= {0.3, 0.3, 0.3, 0.5},
			borderColor = {0, 0, 0}, --{168 / 255, 84 / 255, 0},
		},
		P0091000082 = 
		{
			type = "DOT",
			title = "ПУ ЗРК СД НА КШ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000082.png",
			maxScale = 40000000,
		},
		P0091000084 = 
		{
			type = "DOT",
			title = "БМ ЗРК МД НА КШ С РАДАРОМ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000084.png",
			maxScale = 40000000,
		},
		P0091000081 = 
		{
			type = "DOT",
			title = "ПУ ЗРК СД С РАДАРОМ НА ГШ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000081.png",
			maxScale = 40000000,
		},
		TriggerZoneIcon = 
		{
			type = "DOT",
			title = "ТРИГГЕРНАЯ ЗОНА",
			file = "trigger_zone.png",
			minScale = 1,
			maxScale = 40000000,
			layer = 9,			
		},
		BeaconWithoutMarker = 
		{
			type = "DOT",
			title = "МАЯК БЕЗ МАРКЕРА",
			minScale = 1,
			maxScale = 40000000,
			layer = 9,
			file = "beacon_without_marker.png",
		},
		BeaconWithMarker = 
		{
			type = "DOT",
			title = "МАЯК С МАРКЕРОМ",
			minScale = 1,
			maxScale = 40000000,
			layer = 9,
			file = "beacon_with_marker.png",
		},	
		BeaconTacan = 
		{
			type = "DOT",
			title = "МАЯК TACAN",
			minScale = 1,
			maxScale = 40000000,
			layer = 9,
			file = "beacon_tacan.png",
		},	
		BeaconVor = 
		{
			type = "DOT",
			title = "МАЯК VOR",
			minScale = 1,
			maxScale = 40000000,
			layer = 9,
			file = "beacon_vor.png",
		},	
        BeaconDME = 
		{
			type = "DOT",
			title = "МАЯК DME",
			minScale = 1,
			maxScale = 40000000,
			layer = 9,
			file = "beacon_DME.png",
		}, 
        beaconVORDME = 
		{
			type = "DOT",
			title = "МАЯК VORDME",
			minScale = 1,
			maxScale = 40000000,
			layer = 9,
			file = "beacon_VOR-DME.png",
		}, 
        beaconVORTAC = 
		{
			type = "DOT",
			title = "МАЯК VORTAC",
			minScale = 1,
			maxScale = 40000000,
			layer = 9,
			file = "beacon_VORTAC.png",
		},       
        beaconRSBN = 
		{
			type = "DOT",
			title = "МАЯК RSBN",
			minScale = 1,
			maxScale = 40000000,
			layer = 9,
			file = "beacon_RSBN.png",
		},   
        beaconHOMER = 
		{
			type = "DOT",
			title = "МАЯК HOMER",
			minScale = 1,
			maxScale = 40000000,
			layer = 9,
			file = "beacon_without_marker.png",
		},                   
		BeaconCaption = 
		{
			type = "TIT",
			title = "ПОДПИСИ ДЛЯ МАЯКОВ",
			font = fontName,
			minScale = 1000,
			maxScale = 40000000,
			layer = 9,
			color =	 {0, 0, 0},
			size = 10,
		},
		BeaconIls = 
		{
			type = "SQR",
			title = "МАЯКИ ILS",
			color =	 {0, 0, 0, 0},
			minScale = 1,
			maxScale = 40000000,
			layer = 14,
			borderColor =  {1, 1, 1},
		},
		BeaconIlsCaption = 
		{
			type = "TIT",
			title = "ПОДПИСИ ДЛЯ МАЯКОВ ILS",
			font = fontName,
			minScale = 1000,
			maxScale = 40000000,
			layer = 14,
			color =	 {0, 0, 0},
			size = 11,
		},
		pointTriggerZone = 
		{
			type = "DOT",
			title = "POINT TRIGGER ZONE",
			minScale = 1,
			maxScale = 40000000,
			layer = 9,
			file = "warehouse_supplier.png",
		},	
		P0091000217 = 
		{
			
			type = "DOT",
			title = "POINT 217",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000217.png",
			maxScale = 40000000,
		},
		T0000000524 = 
		{
			maxScale = 40000000,
			type = "TIT",
			title = "ПОДПИСИ",
			font = fontName,
			minScale = 1,
			layer = 9,
			color =	 {0, 0, 0},
			size = 16,
		},		 
		NavigationPointCallsign = 
		{
			maxScale = 40000000,
			type = "TIT",
			title = "ПОЗЫВНОЙ НАВИГАЦИОННОЙ ТОЧКИ",
			font = fontName,
			minScale = 1,
			layer = 9,
			color =	 {0, 0, 0},
			size = 16,
		},		 
		TriggerZoneCaption = 
		{
			maxScale = 40000000,
			type = "TIT",
			title = "ПОДПИСЬ ТРИГГЕРНОЙ ЗОНЫ",
			font = fontName,
			minScale = 1,
			layer = 9,
			color =	 {0, 0, 0},
			size = 16,
		},
		NavigationPointDescription = 
		{
			maxScale = 40000000,
			type = "TIT",
			title = "КОММЕНТАРИЙ НАВИГАЦИОННОЙ ТОЧКИ",
			font = fontName,
			minScale = 1,
			layer = 9,
			color =	 {0, 0, 0},
			size = 12,
		},
		AirdromeCaption = 
		{
			type		= "TIT",
			title		= "НАЗВАНИЯ АЭРОДРОМОВ",
			font		= 'DejaVuLGCSansCondensed-Bold.ttf',
			maxScale	= 10000000,
			minScale	= 1000,
			layer		= 14,
			color		= {0, 0, 0},
			size		= 18,
			blur		= 1,
		},
		L0000000525 = 
		{
			type = "LIN",
			title = "ЛИНЕЙКА",
			minScale = 1,
			layer = 9,
			color =	 {0, 1, 1},
			maxScale = 40000000,
		},
		TriggerZoneSelectionPolyline = 
		{
			type = "PLN",
			title = "TRIGGER ZONE SELECTION POLYLINE",
			minScale = 1,
			layer = 9,
			color =	 {1, 1, 1},
			thickness = 4,
			file = "./MissionEditor/data/NewMap/images/trigger_select_line.png",
			-- rect  = {x = 64, y = 0, w = 64, h = 64}, -- texture rectangle
			maxScale = 40000000,
		},		
		P0091000066 = 
		{
			
			type = "DOT",
			title = "ТЯЖЕЛЫЙ КРЕЙСЕР",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000066.png",
			maxScale = 40000000,
		},
		P0091000216 = 
		{
			type = "DOT",
			title = "POINT 216",
			file = "P91000216.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		P0091000062 = 
		{
			type = "DOT",
			title = "ASW Helicopter",
			file = "P91000062.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		P0091000041 = 
		{
			type = "DOT",
			title = "ПРОМЕЖУТОЧНАЯ ТОЧКА МАРШРУТА",
			minScale = 1,
			layer = 9,
			file = "P91000041.png",
			maxScale = 40000000,
		},
		P0091000212 = 
		{
			
			type = "DOT",
			title = "POINT 212",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000212.png",
			maxScale = 40000000,
		},
		P0091000023 = 
		{
			type = "DOT",
			title = "ДПЛА",
			file = "P91000023.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		P0091000202 = 
		{
			type = "DOT",
			title = "POINT 202",
			file = "P91000202.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		T_companyName = 
		{
			maxScale = 1000000,
			type = "TIT",
			title = "Company name",
			font = fontName,
			minScale = 1,
			layer = 9,
			color =	 {0, 0, 0},
			size = 13,
		},
		P0091000073 = 
		{
			type = "DOT",
			title = "БЛОК-ПОСТ",
			minScale = 1,
			layer = 9,
			file = "P91000073.png",
			maxScale = 40000000,
		},
		P0000000634 = 
		{
			type = "DOT",
			title = "ГРУЗОВОЙ КОРАБЛЬ",
			minScale = 1,
			layer = 9,
			file = "P91000210.png",
			maxScale = 40000000,
		},
		P0091000026 = 
		{
			type = "DOT",
			title = "САМОЛЁТ РАЗВЕДЧИК",
			file = "P91000026.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		P0091000005 = 
		{
			
			type = "DOT",
			title = "АВТОМОБИЛЬ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000005.png",
			maxScale = 40000000,
		},
		P0091000006 = 
		{
			
			type = "DOT",
			title = "САМОХОДНОЕ ОРУДИЕ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000006.png",
			maxScale = 40000000,
		},
		L0091000301 = 
		{
			type = "LIN",
			color =	 {168 / 255, 84 / 255, 0},
			layer = 9,
			title = "LINE 301",
			minScale = 1,
			maxScale = 40000000,
		},
		P0091000211 = 
		{
			
			type = "DOT",
			title = "POINT 211",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000211.png",
			maxScale = 40000000,
		},
		P0091000056 = 
		{
			type = "DOT",
			title = "САМОЛЕТ ДРЛО",
			file = "P91000056.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		P0091000022 = 
		{
			type = "DOT",
			title = "ПЛОЩАДКА БАЗИРОВАНИЯ АВИАЦИИ FARP",
			minScale = 1,
			layer = 9,
			file = "P91000022.png",
			maxScale = 40000000,
		},
		
		DetectionRangeBorder = 
		{
			type = "LIN",
			title = "ГРАНИЦА ЗОНЫ ОБНАРУЖЕНИЯ",
			maxScale = 40000000,
			minScale = 1,
			layer = 9,
			color =	 {1, 1, 0},
		},
		
		ThreatRangeBorder = 
		{
			type = "LIN",
			title = "ГРАНИЦА ЗОНЫ ДОСЯГАЕМОСТИ",
			maxScale = 40000000,
			minScale = 1,
			layer = 9,
			color =	 {1, 0, 0},
		},	
		
		Sector = 
		{
			type = "SQR",
			title = "СЕКТОР ЗОНЫ ДОСЯГАЕМОСТИ",
			color =	 {1, 1, 0, 0.3},
			minScale = 1,
			maxScale = 40000000,
			layer = 9,
			--borderColor =  {0, 0, 0, 0}, 
		},	
		
		ThreatRangeMinBorder = 
		{
			type = "LIN",
			title = "ГРАНИЦА МИНИМАЛЬНОЙ ЗОНЫ ДОСЯГАЕМОСТИ",
			maxScale = 40000000,
			minScale = 1,
			layer = 9,
			color =	 {0, 1, 0},
		},	
		
		WarehouseRangeBorder = 
		{
			type = "LIN",
			title = "ГРАНИЦА ЗОНЫ WAREHOUSE",
			maxScale = 20000,
			minScale = 1,
			layer = 9,
			color =	 {0, 0, 0},
		},
		P0091000004 = 
		{
			
			type = "DOT",
			title = "БРОНЕТРАНСПОРТЕР",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000004.png",
			maxScale = 40000000,
		},
		P0053330000 = 
		{
			type = "DOT",
			title = "ТЕЛЕВИЗИОННЫЕ БАШНИ",
			minScale = 5000,
			layer = 6,
			maxScale = 200000,
		},
		P0091000009 = 
		{
			type = "DOT",
			title = "ЗРК ОБЩЕГО НАЗНАЧЕНИЯ",
			minScale = 1,
			layer = 9,
			file = "P91000009.png",
			maxScale = 40000000,
		},	
		T0000000533 = 
		{
			maxScale = 40000000,
			type = "TIT",
			title = "НАЗВАНИЕ ЗОНЫ ТРИГГЕРА",
			font = fontName,
			minScale = 1,
			layer = 9,
			color =	 {0, 0, 0},
			size = 16,
		},
		P0091000012 = 
		{
			type = "DOT",
			title = "ЗРК СРЕДНЕЙ ДАЛЬНОСТИ",
			minScale = 1,
			layer = 9,
			file = "P91000012.png",
			maxScale = 40000000,
		},
		P0091000039 = 
		{
			
			type = "DOT",
			title = "БОЕВОЙ КАТЕР",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000039.png",
			maxScale = 40000000,
		},
		P0091000101 = 
		{
			type = "DOT",
			title = "ТЕСТ-ТАНК",
			file = "P91000101.png",
			minScale = 1,
			layer = 9,
			mask = "P91000101mask.png",
			maxScale = 40000000,
		},
		P0091000208 = 
		{
			type = "DOT",
			title = "POINT 208",
			minScale = 1,
			layer = 9,
			file = "P91000208.png",
			maxScale = 40000000,
		},
		P0091000040 = 
		{
			
			type = "DOT",
			title = "КРЫЛАТЫЕ РАКЕТЫ ОБЩ. ОБОЗН.",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000040.png",
			maxScale = 40000000,
		},
		P0091000020 = 
		{
			type = "DOT",
			title = "ВЕРТОЛЁТ",
			file = "P91000020.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		P910000106 = 
		{
			type = "DOT",
			title = "POINT 106",
			minScale = 1,
			layer = 9,
			file = "P910000106.png",
			maxScale = 40000000,
		},
		P0091000007 = 
		{
			type = "DOT",
			title = "БОЕВЫЕ МАШИНЫ РЕАКТИВНОЙ АРТИЛ.",
			minScale = 1,
			layer = 9,
			file = "P91000007.png",
			maxScale = 40000000,
		},
		L0061111000 = 
		{
			type = "LIN",
			title = "ЖЕЛ.ДОРОГИ ШИРОК.ДЕЙСТВУЮЩИЕ ",
			maxScale = 1000000,
			minScale = 1,
			layer = 4,
			color =	 {0, 0, 0},
		},
		P0091000028 = 
		{
			type = "DOT",
			title = "СРЕДСТВО РЭБ",
			file = "P91000028.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		P0091000024 = 
		{
			type = "DOT",
			title = "ИСТРЕБИТЕЛЬ",
			file = "P91000024.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		P910000104 = 
		{
			type = "DOT",
			title = "POINT 104",
			minScale = 1,
			layer = 9,
			file = "P910000104.png",
			maxScale = 40000000,
		},
		RouteLine = 
		{
			type = "LIN",
			title = "ЛИНИЯ МАРШРУТА",
			maxScale = 40000000,
			minScale = 1,
			layer = 9,
			color =	 {168 / 255, 84 / 255, 0},
		},
		TriggerZoneBorder = 
		{
			type = "LIN",
			title = "ГРАНИЦА ЗОНЫ ТРИГГЕРА",
			maxScale = 40000000,
			minScale = 1,
			layer = 9,
			color =	 {168 / 255, 84 / 255, 0},
		},
		P0091000072 = 
		{
			type = "DOT",
			title = "СКЛАД",
			minScale = 1,
			layer = 9,
			file = "P91000072.png",
			maxScale = 40000000,
		},
		P0091000017 = 
		{
			
			type = "DOT",
			title = "ЗСУ С РАДИОЛОКАЦИОННЫМ КОМПЛ.",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000017.png",
			maxScale = 40000000,
		},
		S0000000530 = 
		{
			type = "SQR",
			title = "ЗОНА ЦЕЛИ",
			color =	 {131 / 255, 1, 1, 0.5},
			minScale = 1,
			layer = 9,
			borderColor =  {168 / 255, 84 / 255, 0},
			maxScale = 40000000,
		},
		P910000103 = 
		{
			type = "DOT",
			title = "POINT 103",
			minScale = 1,
			layer = 9,
			file = "P910000103.png",
			maxScale = 40000000,
		},
		P0051140000 = 
		{
			type = "DOT",
			title = "ЭЛЕКТРОСТАНЦИИ",
			minScale = 5000,
			layer = 6,
			maxScale = 200000,
		},
		P0091000088 = 
		{
			type = "DOT",
			title = "МНОГОКАНАЛЬНЫЙ ЗРК БД",
			minScale = 1,
			layer = 9,
			file = "P91000088.png",
			maxScale = 40000000,
		},
		P0091000079 = 
		{
			
			type = "DOT",
			title = "ПУ ЗРК БД НА КШ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000079.png",
			maxScale = 40000000,
		},
		P0091000087 = 
		{
			
			type = "DOT",
			title = "ПУ ЗРК МД НА ГШ С РАДАРОМ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000087.png",
			maxScale = 40000000,
		},
		P0091000069 = 
		{
			
			type = "DOT",
			title = "СРЕДНИЙ КОРАБЛЬ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000069.png",
			maxScale = 40000000,
		},
		P0091000027 = 
		{
			type = "DOT",
			title = "САМОЛЁТ БОМБАРДИРОВЩИК",
			file = "P91000027.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		P0091000203 = 
		{
			
			type = "DOT",
			title = "POINT 203",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000203.png",
			maxScale = 40000000,
		},
		P0091000085 = 
		{
			
			type = "DOT",
			title = "БМ ЗРК МД НА КШ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000085.png",
			maxScale = 40000000,
		},
		P910000107 = 
		{
			type = "DOT",
			title = "POINT 107",
			minScale = 1,
			layer = 9,
			file = "P910000107.png",
			maxScale = 40000000,
		},
		P0091000010 = 
		{
			type = "DOT",
			title = "ЗРК БЛИЖНЕГО ДЕЙСТВИЯ",
			minScale = 1,
			layer = 9,
			file = "P91000010.png",
			maxScale = 40000000,
		},
		P910000105 = 
		{
			type = "DOT",
			title = "POINT 105",
			minScale = 1,
			layer = 9,
			file = "P910000105.png",
			maxScale = 40000000,
		},
		P0091000096 = 
		{
			type = "DOT",
			title = "Recon Helicopter",
			file = "P91000096.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		P0091000067 = 
		{
			
			type = "DOT",
			title = "КРЕЙСЕР",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000067.png",
			maxScale = 40000000,
		},
		P0091000063 = 
		{
			type = "DOT",
			title = "САМОЛЕТ ПРОТИВОЛОДОЧНЫЙ",
			file = "P91000063.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		P0091000204 = 
		{
			
			type = "DOT",
			title = "POINT 204",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000204.png",
			maxScale = 40000000,
		},
		P0053230000 = 
		{
			type = "DOT",
			title = "МОРСКИЕ ПОРТЫ,ГАВАНИ(Т)",
			minScale = 5000,
			layer = 6,
			maxScale = 200000,
		},
		P0091000035 = 
		{
			type = "DOT",
			title = "РАДИОНАВИГАЦИОННЫЙ ПУНКТ",
			minScale = 1,
			layer = 9,
			file = "P91000035.png",
			maxScale = 40000000,
		},
		P0091000089 = 
		{
			type = "DOT",
			title = "МНОГОКАНАЛЬНЫЙ ЗРК СД",
			minScale = 1,
			layer = 9,
			file = "P91000089.png",
			maxScale = 40000000,
		},
		P0091000070 = 
		{
			
			type = "DOT",
			title = "МАЛЫЙ КОРАБЛЬ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000070.png",
			maxScale = 40000000,
		},
		P0091000018 = 
		{
			
			type = "DOT",
			title = "БОЕВАЯ МАШИНА ЗРК БЛИЖН. ДЕЙСТ.",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000018.png",
			maxScale = 40000000,
		},
		P0091000064 = 
		{
			type = "DOT",
			title = "САМОЛЕТ ЗАПРАВЩИК",
			file = "P91000064.png",
			minScale = 1,
			layer = 9,
			rotatable = true,
			maxScale = 40000000,
		},
		P0091000201 = 
		{
			
			type = "DOT",
			title = "POINT 201",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000201.png",
			maxScale = 40000000,
		},
		P0091000065 = 
		{
			
			type = "DOT",
			title = "АВИАНОСЕЦ",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000065.png",
			maxScale = 40000000,
		},
		T0000000527 = 
		{
			maxScale = 40000000,
			type = "TIT",
			title = "ПОДПИСЬ ДЛЯ ЛИНЕЙКИ",
			font = fontName,
			minScale = 1,
			layer = 9,
			color =	 {0, 0, 0},
			size = 12,
		},
		P0091000048 = 
		{
			type = "DOT",
			title = "АВИАЦИОННЫЙ НАВОДЧИК",
			minScale = 1,
			layer = 9,
			file = "P91000048.png",
			maxScale = 40000000,
		},
		P0091000347 = 
		{
			type = "DOT",
			title = "bullseye",
			minScale = 1,
			layer = 9,
			file = "P0091000347.png",
			maxScale = 40000000,
		},		
		
		P0091000349 = 
		{
			type = "DOT",
			title = "cyclone",
			minScale = 1,
			layer = 9,
			rect  = {x = 64, y = 0, w = 64, h = 64},
			file = "cyclons.png",
			maxScale = 40000000,
		},
		P0091000350 = 
		{
			type = "DOT",
			title = "anticyclone",
			minScale = 1,
			layer = 9,
			rect  = {x = 0, y = 0, w = 64, h = 64},
			file = "cyclons.png",
			maxScale = 40000000,
		},
		P0091000351 = 
		{
			
			type = "DOT",
			title = "Load",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P0091000351.png",
			maxScale = 40000000,
		},
		P0091000352 = 
		{
			
			type = "DOT",
			title = "Slingload",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P0091000352.png",
			maxScale = 40000000,
		},
		P0091000353 = 
		{
			
			type = "DOT",
			title = "Effect",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P0091000353.png",
			maxScale = 40000000,
		},
		
		
		P000WIND000 =
		{
			type = "DOT",
			title = "wind000",
			minScale = 1,
			layer = 9,
			rect  = {x = 0, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND005 =
		{
			type = "DOT",
			title = "wind005",
			minScale = 1,
			layer = 9,
			rect  = {x = 64, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND010 =
		{
			type = "DOT",
			title = "wind010",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*2, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND015 =
		{
			type = "DOT",
			title = "wind015",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*3, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND020 =
		{
			type = "DOT",
			title = "wind020",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*4, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND025 =
		{
			type = "DOT",
			title = "wind025",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*5, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND030 =
		{
			type = "DOT",
			title = "wind030",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*6, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND035 =
		{
			type = "DOT",
			title = "wind035",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*7, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND040 =
		{
			type = "DOT",
			title = "wind040",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*8, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND045 =
		{
			type = "DOT",
			title = "wind045",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*9, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND050 =
		{
			type = "DOT",
			title = "wind050",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*10, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND055 =
		{
			type = "DOT",
			title = "wind055",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*11, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND060 =
		{
			type = "DOT",
			title = "wind060",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*12, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND065 =
		{
			type = "DOT",
			title = "wind065",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*13, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND070 =
		{
			type = "DOT",
			title = "wind070",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*14, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND075 =
		{
			type = "DOT",
			title = "wind075",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*15, y = 0, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND080 =
		{
			type = "DOT",
			title = "wind080",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*0, y = 64, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND085 =
		{
			type = "DOT",
			title = "wind085",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*1, y = 64, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND090 =
		{
			type = "DOT",
			title = "wind090",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*2, y = 64, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND095 =
		{
			type = "DOT",
			title = "wind095",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*3, y = 64, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND100 =
		{
			type = "DOT",
			title = "wind100",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*4, y = 64, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND105 =
		{
			type = "DOT",
			title = "wind105",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*5, y = 64, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND110 =
		{
			type = "DOT",
			title = "wind110",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*6, y = 64, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND115 =
		{
			type = "DOT",
			title = "wind115",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*7, y = 64, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND120 =
		{
			type = "DOT",
			title = "wind120",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*8, y = 64, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND125 =
		{
			type = "DOT",
			title = "wind125",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*9, y = 64, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND130 =
		{
			type = "DOT",
			title = "wind130",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*10, y = 64, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND135 =
		{
			type = "DOT",
			title = "wind135",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*11, y = 64, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND140 =
		{
			type = "DOT",
			title = "wind140",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*12, y = 64, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		P000WIND145 =
		{
			type = "DOT",
			title = "wind145",
			minScale = 1,
			layer = 9,
			rect  = {x = 64*13, y = 64, w = 64, h = 64},
			file = "weather-knots-icons.png",
			maxScale = 40000000,
		},
		
		Field_Artillery =
		{
			type = "DOT",
			title = "Field Artillery",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "Field_Artillery.png",
			maxScale = 40000000,
		},
		
		P_small_marker_object = 
		{
			type = "DOT",
			title = "small_marker_object",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "P91000044.png",
			maxScale = 40000000,
		},
		
		P_COW =
		{
			type = "DOT",
			title = "COW",
			minScale = 1,
			layer = 9,
			file = "cow.png",
			maxScale = 40000000,
		},
		RTS_HQ_000_B =
		{
			type = "DOT",
			title = "HQ_GENERIC_B",
			minScale = 1,
			layer = 9,
			file = "RTS_HQ_000_B.png",
			maxScale = 40000000,
		},
		RTS_HQ_000_R =
		{
			type = "DOT",
			title = "HQ_GENERIC_R",
			minScale = 1,
			layer = 9,
			file = "RTS_HQ_000_R.png",
			maxScale = 40000000,
		},
		RTS_HQ_001_B =
		{
			type = "DOT",
			title = "HQ_VEHICLES_B",
			minScale = 1,
			layer = 9,
			file = "RTS_HQ_001_B.png",
			maxScale = 40000000,
		},
		RTS_HQ_001_R =
		{
			type = "DOT",
			title = "HQ_VEHICLES_R",
			minScale = 1,
			layer = 9,
			file = "RTS_HQ_001_R.png",
			maxScale = 40000000,
		},
		RTS_HQ_002_B =
		{
			type = "DOT",
			title = "HQ_GUN_B",
			minScale = 1,
			layer = 9,
			file = "RTS_HQ_002_B.png",
			maxScale = 40000000,
		},
		RTS_HQ_002_R =
		{
			type = "DOT",
			title = "HQ_GUN_R",
			minScale = 1,
			layer = 9,
			file = "RTS_HQ_002_R.png",
			maxScale = 40000000,
		},
		RTS_HQ_003_B =
		{
			type = "DOT",
			title = "HQ_PVO_B",
			minScale = 1,
			layer = 9,
			file = "RTS_HQ_003_B.png",
			maxScale = 40000000,
		},
		RTS_HQ_003_R =
		{
			type = "DOT",
			title = "HQ_PVO_R",
			minScale = 1,
			layer = 9,
			file = "RTS_HQ_003_R.png",
			maxScale = 40000000,
		},
		RTS_HQ_004_B =
		{
			type = "DOT",
			title = "HQ_HELICOPTER_B",
			minScale = 1,
			layer = 9,
			file = "RTS_HQ_004_B.png",
			maxScale = 40000000,
		},
		RTS_HQ_004_R =
		{
			type = "DOT",
			title = "HQ_HELICOPTER_R",
			minScale = 1,
			layer = 9,
			file = "RTS_HQ_004_R.png",
			maxScale = 40000000,
		},
		RTS_HQ_005_B =
		{
			type = "DOT",
			title = "HQ_AIRCRAFT_B",
			minScale = 1,
			layer = 9,
			file = "RTS_HQ_005_B.png",
			maxScale = 40000000,
		},
		RTS_HQ_005_R =
		{
			type = "DOT",
			title = "HQ_AIRCRAFT_R",
			minScale = 1,
			layer = 9,
			file = "RTS_HQ_005_R.png",
			maxScale = 40000000,
		},
		RTS_TR_001_B =
		{
			type = "DOT",
			title = "TR_001_B",
			minScale = 1,
			layer = 9,
			file = "RTS_TR_001_B.png",
			maxScale = 40000000,
		},
		RTS_TR_001_R =
		{
			type = "DOT",
			title = "TR_001_R",
			minScale = 1,
			layer = 9,
			file = "RTS_TR_001_R.png",
			maxScale = 40000000,
		},
		RTS_POI_001 =
		{
			type = "DOT",
			title = "FACTORY",
			minScale = 1,
			layer = 9,
			file = "RTS_POI_001.png",
			maxScale = 40000000,
		},
		RTS_POI_002 =
		{
			type = "DOT",
			title = "WAREHOUSE_R",
			minScale = 1,
			layer = 9,
			file = "RTS_POI_002.png",
			maxScale = 40000000,
		},
		RTS_DEF_000 =
		{
			type = "DOT",
			title = "DEFENCE POINT",
			minScale = 1,
			layer = 9,
			file = "RTS_DEF_000.png",
			maxScale = 40000000,
		},
		SAM_SPAAA_RAD_APC = --Tunguska
		{
			type = "DOT",
			title = "SAM SPAAA RAD APC",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "SAM_SPAAA_RAD_APC.png",
			maxScale = 40000000,
		},
		SPAAA_NoRAD_Tank = --ZSU-57-2
		{
			type = "DOT",
			title = "SPAAA NoRAD Tank",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "SPAAA_NoRAD_Tank.png",
			maxScale = 40000000,
		},
		SPAAA_RAD_Truck = --LPWS C-RAM
		{
			type = "DOT",
			title = "SPAAA RAD Truck",
			rotatable = true,
			minScale = 1,
			layer = 9,
			file = "SPAAA_RAD_Truck.png",
			maxScale = 40000000,
		},

		NavigationPointIcon = 
		{
			type = "DOT",
			title = "navpoint",
			minScale = 1,
			layer = 9,
			file = "navPoints/nav_navigation_point.png",
			maxScale = 40000000,
		},	
		
		FlightPointIcon = 
		{
			type = "DOT",
			title = "ТОЧКА flight point",
			minScale = 1,
			layer = 9,
			file = "P91000041.png",
			maxScale = 40000000,
		},		
		
	},
}