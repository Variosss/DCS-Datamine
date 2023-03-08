--/N/ rev. 2.1 -  feb 2014

country = "EN"
if  LockOn_Options.cockpit_language == "russian" then
    country = "RU"
end

--reverse_table = {}
--reverse_table["RU"] = {}

localize_table = {}

function LOCALIZE(str)
	if	localize_table[country]      == nil or 
		localize_table[country][str] == nil then
		return _(str)
	else
		return localize_table[country][str]
	end
end


localize_table["RU"] = {}

-- DC & AC buses & giro devices
localize_table["RU"]["Battery On/Off"]		    							="Аккумулятор Борт"  
localize_table["RU"]["Battery Heat On/Off"]		    						="Обогрев Аккумуляторa"
localize_table["RU"]["DC Generator On/Off"]		    						="Генератор ="
localize_table["RU"]["AC Generator On/Off"]		    						="Генератор ~"
localize_table["RU"]["PO-750 Inverter #1 On/Off"]		    				="Запуск ПО-750  N°1"
localize_table["RU"]["PO-750 Inverter #2 On/Off"]		    				="Запуск ПО-750  N°2"
localize_table["RU"]["Emergency Inverter"]		    						="Авар. Переключ. Преобразователя" 

-- GIRO
localize_table["RU"]["Giro, NPP, SAU, RLS Signal, KPP Power On/Off"] 		="Гирод КСИ, АП, РЛС, Сигнал, АГД"
localize_table["RU"]["DA-200 Signal, Giro, NPP, RLS, SAU Power On/Off"]		="ДА-200 Сигнал, Гиро, КСИ, РЛС, АП"

-- FUEL_PUMPS & FUEL_SYSTEM (merged)
localize_table["RU"]["Fuel Tanks 1st Group, Fuel Pump"]		    			="Насос 1ГР Баков"
localize_table["RU"]["Fuel Tanks 3rd Group, Fuel Pump"]		    			="Насос 3ГР Баков"
localize_table["RU"]["Drain Fuel Tank, Fuel Pump"]		    				="Расходн Насос"
localize_table["RU"]["Fuel Quantity Set"]		    						="Установка количества топлива"

-- ENGINE START DEVICE
localize_table["RU"]["APU On/Off"]		    								="Агрегат Запуска"
localize_table["RU"]["Engine Cold / Normal Start"]		    				="Двигатель Холодная Прокрутка / Запуск Двигателя" 
localize_table["RU"]["Start Engine"]		    							="Двигатель Запуск На Земле"
localize_table["RU"]["Engine Emergency Air Start"]		    				="Запуск в Воздухе"
localize_table["RU"]["Engine Stop/Lock"]		    						="Двигатель Стоп/Блокировки"

-- ACCELEROMETER
localize_table["RU"]["Accelerometer Reset"]		    						="Акселерометр Сброс" 

-- PITOT TUBES and related things that use dc bus for heating
localize_table["RU"]["Pitot tube Selector Main/Emergency"]		    		="Приемник Воздушного Давления Рабоч./Авар."
localize_table["RU"]["Pitot tube/Periscope/Clock Heat"]		    			="Обогрев Приемника Воздушного Давления/Перископ/Часы"
localize_table["RU"]["Secondary Pitot Tube Heat"]		    				="Обогрев Авар. Приемника Воздушного Давления"

-- DA-200
localize_table["RU"]["Variometer Set"]		    							="Установка Вариометра"

-- ENGINE
localize_table["RU"]["Anti surge doors - Auto/Manual"]		   			 	="Противопомпаж. створки - Авт./Руч." 
localize_table["RU"]["Afterburner/Maximum Off/On"]		    				="Форсаж Максимал"
localize_table["RU"]["Emergency Afterburner Off/On"]		    			="Чрезвычайный Форсаж"

-- FIRE EXTINGUISHER
localize_table["RU"]["Fire Extinguisher Off/On"]		    				="Пожар оборуд. Выкл/Вкл"
localize_table["RU"]["Fire Extinguisher Cover"]		    					="Защитная крышка - Огнетушитель"
localize_table["RU"]["Fire Extinguisher"]		    						="Огнетушитель"

-- LIGHTS
localize_table["RU"]["Cockpit Texts Back-light"]		    				="Пульты - Регулировка яркости"
localize_table["RU"]["Instruments Back-light"]		    					="Приборная Доска - Регулировка яркости"
localize_table["RU"]["Main Red Lights"]		    							="Красный Свет - Регулировка яркости"
localize_table["RU"]["Main White Lights"]		    						="Белый Свет - Регулировка яркости"
localize_table["RU"]["Navigation Lights Off/Min/Med/Max"]		    		="Аэронавигационные огни БАНО Выкл/Малый/Средний/Полный"
localize_table["RU"]["Landing Lights Off/Taxi/Land"]		    			="Посадочная Фара Убрано/Рулеж/Посадка"

-- LIGHTS WARNING
localize_table["RU"]["Check Warning Lights - Set Warning Light Day/Night"]	="Кнопка Контроля Сигнализации - Установка Ночь/День"
localize_table["RU"]["SORC"]		    									="СОРЦ - Система Опасных Режимов Централизованная"

-- Radio
localize_table["RU"]["Radio System On/Off"]		    						="Рация Выкл/Вкл"
localize_table["RU"]["Radio / Compass"]		    							="Радио/Компас"
localize_table["RU"]["Squelch On/Off"]		    							="Переключатель Шумоподавителя" 
localize_table["RU"]["Radio Volume"]		    							="Громкость"
localize_table["RU"]["Radio Channel"]		    							="Переключатель каналов"
localize_table["RU"]["Radio PTT"]		    								="Передавать"

-- ARK  - Автоматический Радиокомпас

localize_table["RU"]["ARK On/Off"]		    								="АРК"
localize_table["RU"]["ARK Sound"]		    								="Громкость APK"
localize_table["RU"]["ARK Change"]		    								="Переключает Пульт"
localize_table["RU"]["ARK 1"]		    									="АРК Канал N°1"
localize_table["RU"]["ARK 2"]		    									="АРК Канал N°2"
localize_table["RU"]["ARK 3"]		    									="АРК Канал N°3"
localize_table["RU"]["ARK 4"]		    									="АРК Канал N°4"
localize_table["RU"]["ARK 5"]		    									="АРК Канал N°5"
localize_table["RU"]["ARK 6"]		    									="АРК Канал N°6"
localize_table["RU"]["ARK 7"]		    									="АРК Канал N°7"
localize_table["RU"]["ARK 8"]		    									="АРК Канал N°8"
localize_table["RU"]["ARK 9"]		    									="АРК Канал N°9"
localize_table["RU"]["ARK Zone"]		    								="Сектор АРК"
localize_table["RU"]["ARK Mode - Antenna / Compass"]		    			="АРК - Антенна/Компас"
localize_table["RU"]["Marker Far/Near"]		    							="Маркер Дальн/Ближн"

-- RSBN
localize_table["RU"]["RSBN On/Off"]		    								="РСБН Вкл/Выкл"
localize_table["RU"]["RSBN Mode Land/Navigation/Descend"]		    		="РСБН - Посадкa/Навигация/Пробивание"
localize_table["RU"]["RSBN / ARK"]		    								="РСБН / АРК"
localize_table["RU"]["RSBN Identify"]		    							="РСБН Опознание"
localize_table["RU"]["RSBN self-test"]		    							="РСБН тест сигнал"
localize_table["RU"]["RSBN Sound"]		    								="РСБН Громкость"
localize_table["RU"]["RSBN Navigation"]		    							="РСБН Навигация"
localize_table["RU"]["PRMG Landing"]		    							="ПРМГ Посадка"
localize_table["RU"]["RSBN Reset"]		    								="РСБН начал. установка"
localize_table["RU"]["RSBN Bearing"]		    							="РСБН Азимут"
localize_table["RU"]["RSBN Distance"]		    							="РСБН Дальность"

-- SAU
localize_table["RU"]["SAU On/Off"]		    								="САУ вкл/выкл"
localize_table["RU"]["SAU Pitch On/Off"]		    						="САУ Тангаж вкл/выкл"
localize_table["RU"]["SAU - Stabilize"]		    							="САУ - Стабилизация"
localize_table["RU"]["SAU cancel current mode"]		    					="САУ Сброс"
localize_table["RU"]["SAU - Recovery"]		    							="САУ - Привед. к горизонту"
localize_table["RU"]["SAU Preset - Limit Altitude"]		    				="САУ - Увод с опасн. высоты"
localize_table["RU"]["SAU - Landing - Command"]		    					="САУ - Посадка Директ."
localize_table["RU"]["SAU - Landing - Auto"]		    					="САУ - Посадка Авто."
localize_table["RU"]["SAU Reset/Off"]		    							="САУ Сброс/Отключ"

-- SPO  Звука Нет
localize_table["RU"]["SPO-10 RWR On/Off"]		    						="СПО-10 'Сирена-3' Вкл/Выкл"
localize_table["RU"]["SPO-10 Test"]		    								="СПО-10 Проверка"
localize_table["RU"]["SPO-10 Night / Day"]		    						="СПО-10 Ночь/День"
localize_table["RU"]["SPO-10 Volume"]		    							="СПО-10 Звук"

-- SRZO IFF

localize_table["RU"]["SRZO IFF Coder/Decoder On/Off"]		    			="СРЗО - Самолетный радиолокационный запросчик-ответчик"
localize_table["RU"]["SRZO Codes"]		    								="СРЗО - Шифр Канал"
localize_table["RU"]["IFF System 'Type 81' On/Off"]		    				="Код Изделие 81 Выкл/Вкл"
localize_table["RU"]["Emergency Transmitter Cover"]		    				="Защитная крышка Сигнала Бедствия"
localize_table["RU"]["Emergency Transmitter On/Off"]		    			="Сигнал Бедствия вкл/выкл"
localize_table["RU"]["SRZO Self Destruct Cover"]		    				="Защитная крышка - СРЗО Взрыв"
localize_table["RU"]["SRZO Self Destruct"]		    						="СРЗО Взрыв"

-- SOD
localize_table["RU"]["SOD IFF On/Off"]		    							="Bключено СОД - Самолетный Ответчик Дальности"
localize_table["RU"]["SOD Identify"]		    							="Опознавание СОД"
localize_table["RU"]["SOD Wave Selector 3/1/2"]		    					="СОД Волны 3/2/1"
localize_table["RU"]["SOD Modes"]		    								="СОД Режимы"

-- RADAR
localize_table["RU"]["Radar Off/Prep/On"]		    						="РЛС Выкл/Пред/Полное Вкл"
localize_table["RU"]["Low Altitude Off/Comp/On"]		    				="Маленькaя Высота Выкл/Сигнал/Вкл"
localize_table["RU"]["Locked Beam On/Off"]		    						="Закрепленний Луч"
localize_table["RU"]["Radar Screen Magnetic Reset"]		    				="РЛС Мгновеное Стирование"
localize_table["RU"]["Radar Interferences - Continuous"]		    			="РЛС Помехи - Непрерывные"
localize_table["RU"]["Radar Interferences - Temporary"]		    			="РЛС Помехи - Прерывные"
localize_table["RU"]["Radar Interferences - Passive"]		    				="РЛС Помехи - Пассивное"
localize_table["RU"]["Radar Interferences - Weather"]		    				="РЛС Помехи - Метео"
localize_table["RU"]["Radar Interferences - IFF"]		    					="РЛС Помехи - Запрос"
localize_table["RU"]["Radar Interferences - Low Speed"]		    			="РЛС Помехи - Малоскоросnная цель" 
localize_table["RU"]["Radar Interferences - Self-test"]		   				="РЛС Помехи - Контроль"
localize_table["RU"]["Radar Interferences - Reset"]		    				="РЛС Помехи - Сброс"
localize_table["RU"]["Lock Target"]		    								="РЛС Захват"
localize_table["RU"]["Radar Polar Filter"]		    						="РЛС Солнце-фильтр"

-- SPRD

localize_table["RU"]["SPRD (RATO) System On/Off"]		 				   	="СПРД сист. - Пуск Ускоритель вкл/выкл"
localize_table["RU"]["SPRD (RATO) Drop System On/Off"]		   			 	="СПРД сист. - Сброс Ускоритель вкл/выкл"
localize_table["RU"]["SPRD (RATO) Start Cover"]		    					="Защитная крышка - Пуск Ускоритель"
localize_table["RU"]["SPRD (RATO) Start"]		    						="Пуск Ускоритель"
localize_table["RU"]["SPRD (RATO) Drop Cover"]		    					="Защитная крышка - Сброс Ускоритель"
localize_table["RU"]["SPRD (RATO) Drop"]		    						="Сброс Ускоритель"

-- CONTROL SYSTEM

-- SPS
localize_table["RU"]["SPS System Off/On"]		    						="СПС Система вкл/выкл"

-- ARU
localize_table["RU"]["ARU System - Manual/Auto"]		    				="АРУ Автом/Ручной"
localize_table["RU"]["ARU System - Low Speed/Neutral/High Speed"]		  	="АРУ Больш.Скорость/Нейтрал/Мал.Скорость"

-- Airbrake
localize_table["RU"]["Airbrake - Out/In"]									="Тормозные щитки"

-- Gear brakes
localize_table["RU"]["ABS Off/On"]											="Автом. Тормож. Колеса"
localize_table["RU"]["Nosegear Brake Off/On"]		    					="Тормоз носового колеса выкл/вкл" 
localize_table["RU"]["Emergency Brake"]		    							="Аварийный Тормоз Колеса" 
localize_table["RU"]["Gear Brake Handle"]		    						="Тормоз Колеса"

-- Gears
localize_table["RU"]["Gear Handle Fixator"]		    						="Шасси Замыкать"
localize_table["RU"]["Gear Up/Neutral/Down"]		    					="Шасси Убраны/Нейтрал/Выпущены" 
localize_table["RU"]["Main Gears Emergency Release Handle"]		    		="Авар.выпуск шасси - основные стойки" 
localize_table["RU"]["Nose Gear Emergency Release Handle"]		    		="Авар.выпуск шасси - носовая стойка" 

-- Flaps
localize_table["RU"]["Flaps Neutral"]		    							="Закрылки Убраны"
localize_table["RU"]["Flaps Take-Off"]		    							="Закрылки Взлет"
localize_table["RU"]["Flaps Landing"]		    							="Закрылки Посадка"
localize_table["RU"]["Flaps Reset buttons"]		    						="Сброс установки"

-- Drag chute
localize_table["RU"]["Release Drag Chute"]		    						="Выпуск Парашюта"
localize_table["RU"]["Drop Drag Chute Cover"]		    					="Защитная крышка - Сброс Парашюта"
localize_table["RU"]["Drop Drag Chute"]		    							="Сброс Парашюта"

--TRIMER
localize_table["RU"]["Trimmer On/Off"]		    							="Тримм Эффект Выкл/Вкл"
localize_table["RU"]["Trimmer Pitch Up/Down"]		    					="Тримм Тангаж Вверх/Вниз"

-- KONUS
localize_table["RU"]["Nosecone On/Off"]		    							="Конус Выкл/Вкл"
localize_table["RU"]["Nosecone Control - Manual/Auto"]		    			="Конус Руч./Авт."
localize_table["RU"]["Nosecone manual position controller"]		    		="Конус Ручнaя Установка"

-- SOPLO
localize_table["RU"]["Engine Nozzle 2 Position Emergency Control"]			="Авар. Вкл. 2xПозиция Сопла"

--MAIN_HYDRO and BUSTER_HYDRO
localize_table["RU"]["Emergency Hydraulic Pump On/Off"]		    			="Насос. станция НР-27 Выкл/Вкл"
localize_table["RU"]["Aileron Booster - Off/On"]		    				="Усилитель элеронов Выкл/Вкл"

--KPP
localize_table["RU"]["KPP Main/Emergency"]		    						="КПП Рабочий/Аварийный" 
localize_table["RU"]["KPP Cage"]		    								="КПП Арретир"
localize_table["RU"]["KPP Set"]		    									="КПП Установка крена"

--IAS / TAS / KSI (NPP)
localize_table["RU"]["NPP On/Off"]		    								="НПП (КСИ) Выкл/Вкл"
localize_table["RU"]["NPP Adjust"]		    								="НПП (КСИ) Начальная установка" 
localize_table["RU"]["NPP Course set"]		    							="НПП (КСИ) Задача курса"

-- ALTIMETER and radioALTIMETER
localize_table["RU"]["Radio Altimeter/Marker On/Off"]		    			="Радиовысотомер/Маркер Выкл/Вкл" 
localize_table["RU"]["Dangerous Altitude Warning Set"]		    			="РВ Установка опасной высоты"
localize_table["RU"]["Altimeter pressure knob"]								="Установка давления аэродрома" 

--OXYGENE_SYSTEM
localize_table["RU"]["Helmet Air Condition Off/On"]		    				="Вентиляция Шлемa Выкл/Вкл" 
localize_table["RU"]["Emergency Oxygen Off/On"]		    					="Аварийная Подача O2 Выкл/Вкл"
localize_table["RU"]["Mixture/Oxygen"]		    							="Воздух/Кислород"

--CANOPY
localize_table["RU"]["Hermetize Canopy"]		    						="Герметизация Фонаря" 
localize_table["RU"]["Secure Canopy"]		    							="Запри Фонарь" 
localize_table["RU"]["Canopy Open"]		    								="Фонарь Открыт"
localize_table["RU"]["Canopy Close"]		    							="Фонарь Закрыт" 
localize_table["RU"]["Canopy Anti Ice"]		    							="Антиобледение фонаря" 
localize_table["RU"]["Canopy Emergency Release Handle"]		    			="Аварийный Сброс Фонаря" 
localize_table["RU"]["Canopy Ventilation System"]		    				="Вентиляция Кабине Выкл/Вкл" 

-- ASP Gunsight
localize_table["RU"]["ASP Optical sight On/Off"]		    				="АСП Прицел Выкл/Вкл"
localize_table["RU"]["ASP Main Mode - Manual/Auto"]		    				="АСП Прицел - Ручно/Авт."
localize_table["RU"]["ASP Mode - Bombardment/Shooting"]		    			="АСП Прицел - Бомбометание/Cтрельба" 
localize_table["RU"]["ASP Mode - Missiles-Rockets/Gun"]		    			="АСП Прицел - Ракетная Cтрельба/Пушка" 
localize_table["RU"]["ASP Mode - Giro/Missile"]		    					="АСП Прицел - Гиро/Снаряд Cтрелять"
localize_table["RU"]["Pipper On/Off"]		    							="Подвижную Сетку Выкл/Вкл"
localize_table["RU"]["Fix net On/Off"]		    							="Hеподвижную Сетку Выкл/Вкл"
localize_table["RU"]["Target Size"]		    								="Шкала Размера Цели" 
localize_table["RU"]["Intercept Angle"]		    							="Угол Перехвата"
localize_table["RU"]["Scale Backlights control"]		    				="Шкала - Регулировка яркости" 
localize_table["RU"]["Pipper light control"]		    					="Подвижная Сетка - Регулировка яркости"
localize_table["RU"]["Fix Net light control"]		    					="Hеподвижная Сеткa - Регулировка яркости"
localize_table["RU"]["TDC Range / Pipper Span control"]		    			="РЛС стробы / Подвижная Сетка размер"
localize_table["RU"]["Guncam On/Off"]		    							="Прицел Фотокамеры Выкл/Вкл" 

-- WEAPON_CONTROL
localize_table["RU"]["Missiles - Rockets Heat On/Off"]		    			="Обогрев CC, PHC, ФКЛ Выкл/Вкл"
localize_table["RU"]["Missiles - Rockets Launch On/Off"]		    		="Пуск CC, PC, PHC Выкл/Вкл"
localize_table["RU"]["Pylon 1-2 Power On/Off"]		    					="Питан 1-2 Выкл/Вкл"
localize_table["RU"]["Pylon 3-4 Power On/Off"]		    					="Питан 3-4 Выкл/Вкл"
localize_table["RU"]["GS-23 Gun On/Off"]		    						="ГШ-23 Пушка Выкл/Вкл"

localize_table["RU"]["Guncam On/Off"]		    							="Фотокамерa Выкл/Вкл"
localize_table["RU"]["Tactical Drop Cover"]		    						="Защитная крышка - Тактич. Сброс"
localize_table["RU"]["Tactical Drop"]		    							="Тактич. Сброс"
localize_table["RU"]["Emergency Missile/Rocket Launcher Cover"]		    	="Защитная крышка - Аварийный Пуск CC, PHC" 
localize_table["RU"]["Emergency Missile/Rocket Launcher"]		    		="Аварийный Пуск CC, PHC"  
localize_table["RU"]["Drop Wing Fuel Tanks Cover"]		    				="Защитная крышка - Сброс Крыл. Баков"
localize_table["RU"]["Drop Wing Fuel Tanks"]		    					="Сброс Крыл. Баков"
localize_table["RU"]["Drop Center Fuel Tank"]		    					="Сброс Подфюзеляжного Бака"
localize_table["RU"]["Drop Payload - Outer Pylons Cover"]		    		="Защитная крышка - Аварийный Сброс Подвесок Внешн." 
localize_table["RU"]["Drop Payload - Outer Pylons"]		    				="Аварийный Сброс Подвесок Внешн." 
localize_table["RU"]["Drop Payload - Inner Pylons Cover"]		    		="Защитная крышка - Аварийний Сброс Подвесок Внутр."
localize_table["RU"]["Drop Payload - Inner Pylons"]		    				="Аварийный Сброс Подвесок Внутр." 
localize_table["RU"]["Weapon Mode - Air/Ground"]		    				="Система управления оружием - Воздух/Земля"
localize_table["RU"]["Weapon Mode - IR Missile/Neutral/SAR Missile"]		="Система управления ракетами - CC/Нейтрал/PHC"
localize_table["RU"]["Activate Gun Loading Pyro - 1"]		    			="Перезарядка Пушка - 1"
localize_table["RU"]["Activate Gun Loading Pyro - 2"]		    			="Перезарядка Пушка - 2"
localize_table["RU"]["Activate Gun Loading Pyro - 3"]		    			="Перезарядка Пушка - 3"
localize_table["RU"]["Weapon Selector"]		    							="Выбор оружия"
localize_table["RU"]["Missile Seeker Sound"]		    					="Захват - Громкость"
localize_table["RU"]["Fire Gun"]		    								="Стрельба"
localize_table["RU"]["Release Weapon"]		    							="Пуск"
localize_table["RU"]["Release Weapon Cover"]		    					="Защитная крышка - Пуск"

--HELMET_VISOR
localize_table["RU"]["Helmet Heat - Manual/Auto"]		    				="Обогр Гермошлемa Руч./Авт."
localize_table["RU"]["Helmet Quick Heat"]		    						="Быстрый Обогр. Гермошлемa"
localize_table["RU"]["Helmet Visor on/off"]		    						="Визир шлема вкл/выкл"

--AIR CONDITIONING
localize_table["RU"]["Cockpit Air Condition Off/Cold/Auto/Warm"]		   	="Вентиляция Кабины Выкл/Холод/Горяч/Автомат"

-- SARPP
localize_table["RU"]["SARPP-12 Flight Data Recorder On/Off"]		    	="Система автоматической регистрации параметров полета Выкл/Вкл"

--avAChS
localize_table["RU"]["Mech clock left lever"]		    					="Часы левая ручка"
localize_table["RU"]["Mech clock right lever"]		    					="Часы правая ручка"

--UNCLASSIFIED
localize_table["RU"]["Seat Height Down/Neutral/Up"]							="Сиденье Вверх/Вниз"

-- Flight Control
localize_table["RU"]["Throttle Increase"]		   							="Ручка упр. двигателем +"
localize_table["RU"]["Throttle Decrease"]		   							="Ручка упр. двигателем -"
localize_table["RU"]["Rudder Left"]		   									="Педаль лев"
localize_table["RU"]["Rudder Right"]		   								="Педаль прав"
localize_table["RU"]["Stick Up"]		   									="Ручка упр. самол. на себя"
localize_table["RU"]["Stick Down"]		   									="Ручка упр. самол. от себя"
localize_table["RU"]["Stick Left"]		   									="Ручка упр. самол. влево"
localize_table["RU"]["Stick Right"]		   									="Ручка упр. самол. вправо"
localize_table["RU"]["Force Feedback On/Off"]		   						="Обратная Связь Вкл/Выкл" 

--Dummy buttons/switches
localize_table["RU"]["Radar emission - Cover"]		   						="РЛС режим Боев./Учеб. - Крышка"
localize_table["RU"]["Radar emission - Combat/Training"]			  		="РЛС режим Боев./Учеб."
localize_table["RU"]["G-Suit Max/Min valve"]		   						="Анти Г мин/макс"
localize_table["RU"]["Electric Bus Nr.1 - Cover"]		   					="Защитная крышка - Электр. Шина N°1"
localize_table["RU"]["Electric Bus Nr.1"]		   							="Электр. Шина N°1"
localize_table["RU"]["Electric Bus Nr.2"]		   							="Электр. Шина N°2"
localize_table["RU"]["1.7 Mach Test Button - Cover"]		   				="Защитная крышка - Имитация Срабатывания М 1.7"
localize_table["RU"]["1.7 Mach Test Button"]		   						="Имитация Срабатывания М 1.7"
localize_table["RU"]["BU-45 Buster System Separation"]		   				="Отключение БУ-45"

localize_table["RU"]["SOD Control PBU-1"]		   							="СОД контроль ПБУ-1"
localize_table["RU"]["SOD Control PBU-2"]			  						="СОД контроль ПБУ-2"
localize_table["RU"]["Eject"]		   										="Катапульта"
localize_table["RU"]["Ejection Seat Emergency Oxygen"]						="Авар. подача 02 - кресло"
localize_table["RU"]["UK-2M Mic Amplifier M/L"]		   						="УК-2М Усилитель микроф. М/Л"
localize_table["RU"]["UK-2M Mic Amplifier GS/KM"]		   					="УК-2М Усилитель микроф. ГШ/КМ"
localize_table["RU"]["Suit Ventilation"]		   							="Вентиляция костюма"
localize_table["RU"]["Harness Separation"]		   							="КМ-1М Отпустить Лямки"
localize_table["RU"]["Harness Loose/Tight"]		   							="КМ-1М Затянуть Лямки"
localize_table["RU"]["Throttle Fixation"]		   							="РУД Фиксатор"


-- IAB PBK-3
localize_table["RU"]["Emergency Jettison"]		    						="Авар. сброс"
localize_table["RU"]["Emergency Jettison Armed / Not Armed"]				="Авар. сброс тактич./пассив."
localize_table["RU"]["Tactical Jettison"]		    						="Тактический сброс"
localize_table["RU"]["Special AB / Missile-Rocket-Bombs-Cannon"]			="Спец. бомба / ракеты-бомбы-пушка"
localize_table["RU"]["Brake Chute"]		    								="Парашют"
localize_table["RU"]["Detonation Air / Ground"]		    					="Взрыв воздух/земля" 

-- SPS 141-100
localize_table["RU"]["On / Off"]		    								="Вкл/выкл"
localize_table["RU"]["Transmit / Receive"]									="Передача/прием"
localize_table["RU"]["Program I / II"]		    							="Программа I / II"
localize_table["RU"]["Continuous / Impulse"]								="Непрерыв. / Прерыв." 
localize_table["RU"]["Test"]		    									="Контроль"
localize_table["RU"]["Dispenser Auto / Manual"]		    					="Сброс авт./руч."
localize_table["RU"]["Off / Parallel / Full"]								="Выкл. / Паралел. / Полн."
localize_table["RU"]["Manual Activation button - Cover"]		   			="Руч. включение - Крышка"
localize_table["RU"]["Manual Activation button"]		    				="Руч. включение" 

