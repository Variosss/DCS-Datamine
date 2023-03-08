-- In next string to enter "ru" for Russian localisation or "EN" for English localisation

local language = "en"
local country  = "RU"

local i18n_  = require("i_18n")
if i18n_ then
   language,country = i18n_.get_locale()
end

localize_table = {}


function LOCALIZE(str)
	if		localize_table[language] == nil then
		return str
	else
		if localize_table[language][str] == nil then
			return str
		end
		return localize_table[language][str]
	end
end

localize_table ["en"] = {} -- special hint translation for en
-- SYSTEM CONTROLLER
localize_table["en"]["Rotor RPM warning push-light"]		        ="Low rotor RPM caution push-light"
-- HSI
localize_table["en"]["HSI Commanded course rotary"]		    		="HSI DTA - Desired Track Angle (COURSE) rotary"
localize_table["en"]["HSI Commanded heading rotary"]		    	="HSI DH - Desired Heading (HEADING) rotary"
localize_table["en"]["HSI Desired track angle - Desired heading, Auto - Manual"]		    ='HSI "DTA-DH Manual / Auto" switch'


localize_table["ru"] = {}

-- CPT MECH
localize_table["ru"]["Gear lever"]		    						="Кран шасси"
localize_table["ru"]["Main/Common hydraulics for emergency gear"]	="Аварийный переключатель основная/общая гидросистема для шасси"
localize_table["ru"]["Accelerometer reset"]		    				="Сброс показаний акселерометра"

-- SYSTEM CONTROLLER
localize_table["ru"]["Master caution push-light"]		    		="Центральный сигнальный огонь - кнопка"
localize_table["ru"]["Lamps test"]		    						="Кнопка контроля сигнализации"
localize_table["ru"]["Rotor RPM warning push-light"]		        ="Табло-кнопка сигнализации о падении частоты вращения винтов ниже допустимой величины"
localize_table["ru"]["MWS operation mode (not functional)"]			="Переключатель режима работы БКО (не задействован)"

--laser ranger ( front panel)
localize_table["ru"]["Laser rangefinder / designator - mode switch"]	="Лазерный дальномер / подсвет - переключатель режима"
localize_table["ru"]["Laser designator reset"]		    			="Сброс лазерного подсвета"

-- Right Side Panel (Правый Боковой Пульт) 
-- ELECTRICS POWER
localize_table["ru"]["DC ground power"]		    					="Аэродромное питание. Постоянный ток"
localize_table["ru"]["Battery 2"]		    						="Аккумулятор 2"
localize_table["ru"]["Battery 1"]		    						="Аккумулятор 1"
localize_table["ru"]["AC ground power"]		    					="Аэродромное питание. Переменный ток"
localize_table["ru"]["AC left generator"]		    				="Левый генератор. Переменный ток"
localize_table["ru"]["AC right generator"]		    				="Правый генератор. Переменный ток"
localize_table["ru"]["DC/AC inverter"]		    					="Преобразователь постоянный/переменный ток"

-- FUEL PUMPS POWER AND VALVES
localize_table["ru"]["Forward fuel tank pumps"]		    			="Насос переднего бака"
localize_table["ru"]["Rear fuel tank pumps"]		    			="Насос заднего бака"
localize_table["ru"]["Inner external fuel tanks pumps"]		    	="Насосы внутренних подвесных баков"
localize_table["ru"]["Outer external fuel tanks pumps"]		    	="Насосы внешних подвесных баков"
localize_table["ru"]["Fuelmeter power"]		    					="Топливомер"
localize_table["ru"]["Left engine fuel shutoff valve"]		    	="Перекрывной кран левого двигателя"
localize_table["ru"]["Right engine fuel shutoff valve"]		    	="Перекрывной кран правого двигателя"
localize_table["ru"]["APU fuel shutoff valve"]		    			="Перекрывной кран ВСУ"
localize_table["ru"]["Fuel crossfeed valve"]		    			="Кран кольцевания"
localize_table["ru"]["Fuel quantity indicator self test button"]	="Кнопка контроля топливомера"

-- COMMS POWER
localize_table["ru"]["Intercom"]		    						="Выключатель самолетного переговорного устройста СПУ-9"
localize_table["ru"]["VHF-1 (R828) power switch"]		    		="УКВ-1. Выключатель питания радиостанции Р-828"
localize_table["ru"]["VHF-2 (R-800) power switch"]		    		="УКВ-2. Выключатель питания радиостанции Р-800"
localize_table["ru"]["Radio equipment datalink TLK power switch"]	="Выключатель питания аппаратуры телекодовой связи. ТЛК"
localize_table["ru"]["Radio equipment datalink UHF TLK power switch"]	="Выключатель питания аппаратуры телекодовой связи. УКВ-ТЛК"
localize_table["ru"]["Radio equipment datalink SA-TLF power switch"]	="Выключатель питания аппаратуры телекодовой связи. СА-ТЛФ"

-- WEAPON SYS
localize_table["ru"]["Weapons сontrol system"]		    			="Система управления оружием"

-- EJECT SYSTEM
localize_table["ru"]["Ejecting system power 1"]		    			="Система аварийного покидания. Выключатель электроснабжения 1"
localize_table["ru"]["Ejecting system power 2"]		    			="Система аварийного покидания. Выключатель электроснабжения 2"
localize_table["ru"]["Ejecting system power 3"]		    			="Система аварийного покидания. Выключатель электроснабжения 3"
localize_table["ru"]["Ejecting system power"]		    			="Система аварийного покидания"
localize_table["ru"]["Ejecting system circuit test"]		    	="Система аварийного покидания. Кнопка контроля"
localize_table["ru"]["Ejecting system circuit selector"]		   	="Система аварийного покидания. Переключатель каналов"

-- HYDRAULICS
localize_table["ru"]["Main hydraulics"]		    					="Основная гидросистема ОТКЛ"

-- IFF
localize_table["ru"]["IFF power"]		    						="Самолетный радиолокационный ответчик"

-- ENGINES
localize_table["ru"]["EEG Left engine Electronic Engine Governor"]	="Электронный регулятор левого двигателя"
localize_table["ru"]["EEG Right engine Electronic Engine Governor"]	="Электронный регулятор правого двигателя"
localize_table["ru"]["EEG power turbine channel 1 test – Operate – EEG power turbine channel 2 test, three-switch contactor"]	="ЭРД Проверка оборотов свободной турбины, контуры СТ-1/СТ-2"
localize_table["ru"]["EEG gas generator test – Operate switch"]		="ЭРД ТК Проверка оборотов контура турбокомпрессора"
localize_table["ru"]["Left EGT control threshold governor button"]	="РТ-12-6 регулятор температуры, проверка левого ЭРД"
localize_table["ru"]["Right EGT control threshold governor button"]	="РТ-12-6 регулятор температуры, проверка правого ЭРД"
localize_table["ru"]["Engines vibrations monitoring system control button"]	="Кнопка контроля вибрации ИВ"

-- NAV SYSTEM
localize_table["ru"]["Navigation system power"]						="Пилотажно-навигационный комплекс"
localize_table["ru"]["Gyro/Mag/Manual heading"]		    			="Магнитный курс/Гиро-полукомпас/Заданный курс"

-- SHKVAL windscreen wiper
localize_table["ru"]["SHKVAL windscreen wiper"]		    			="Стеклоочиститель Шквала"


-- ABRIS Display (Дисплей АБРИС) 
localize_table["ru"]["ABRIS Pushbutton 1"]		    				="АБРИС кнопка 1"
localize_table["ru"]["ABRIS Pushbutton 2"]		    				="АБРИС кнопка 2"
localize_table["ru"]["ABRIS Pushbutton 3"]		    				="АБРИС кнопка 3"
localize_table["ru"]["ABRIS Pushbutton 4"]		    				="АБРИС кнопка 4"
localize_table["ru"]["ABRIS Pushbutton 5"]		    				="АБРИС кнопка 5"
localize_table["ru"]["ABRIS Cursor сontrol (rot/push)"]		    	="АБРИС Манипулятор курсора"
localize_table["ru"]["ABRIS Brightness"]		    				="АБРИС Яркость"
localize_table["ru"]["ABRIS Power"]		    						="АБРИС Выключатель"

-- HUD (ИЛС)
localize_table["ru"]["HUD Brightness"]		    					="ИЛС Регулировка яркости"
localize_table["ru"]["HUD Modes Reticle/Night/Day"]		    		="ИЛС СЕТКА/Ночь/День"
localize_table["ru"]["HUD Test"]		    						="ИЛС Тест"
localize_table["ru"]["HUD Filter"]		    						="ИЛС Фильтр"

-- PVI NAV Panel (ПВИ - Пульт Ввода и Индикации)
localize_table["ru"]["NAV '0' Btn"]		    						="ПВИ Кнопка 0"
localize_table["ru"]["NAV '1' Btn"]		    						="ПВИ Кнопка 1"
localize_table["ru"]["NAV '2' Btn"]		    						="ПВИ Кнопка 2"
localize_table["ru"]["NAV '3' Btn"]		    						="ПВИ Кнопка 3"
localize_table["ru"]["NAV '4' Btn"]		    						="ПВИ Кнопка 4"
localize_table["ru"]["NAV '5' Btn"]		    						="ПВИ Кнопка 5"
localize_table["ru"]["NAV '6' Btn"]		    						="ПВИ Кнопка 6"
localize_table["ru"]["NAV '7' Btn"]		    						="ПВИ Кнопка 7"
localize_table["ru"]["NAV '8' Btn"]		    						="ПВИ Кнопка 8"
localize_table["ru"]["NAV '9' Btn"]		    						="ПВИ Кнопка 9"
localize_table["ru"]["NAV Waypoints"]		    					="ПВИ Промежуточный пункт маршрута"
localize_table["ru"]["NAV Inflight INU Realignment"]		    	="ПВИ Повторный запуск ИКВ"
localize_table["ru"]["NAV Fixpoints"]		    					="ПВИ Режим коррекции и ввод координат ориентиров коррекции"
localize_table["ru"]["NAV Precise INU Alignment"]		    		="ПВИ Режим выставки с гирокомпасированием"
localize_table["ru"]["NAV Airfields"]		    					="ПВИ Режим возврата на аэродром и ввод координат аэродромов"
localize_table["ru"]["NAV Normal INU Alignment"]		    		="ПВИ Включение нормальной подготовки ИКВ"
localize_table["ru"]["NAV Targets"]		    						="ПВИ Режим определения координат целей, ввода известных целей и выход в ОТ"
localize_table["ru"]["NAV Enter"]		    						="ПВИ Ввод набранной информации"
localize_table["ru"]["NAV Cancel"]		    						="ПВИ Сброс информации для повторного набора"
localize_table["ru"]["NAV Initial Nav Pos"]		    				="ПВИ Ввод (индикация) координат точки старта"
localize_table["ru"]["NAV Self coordinates"]		    			="ПВИ Индикация текущих координат"
localize_table["ru"]["NAV Course:Course Deviation/Time/Range to WPT"] ="ПВИ Индикация текущего ЗПУ на ППМ, бокового уклонения от ЛЗП, времени полета и расстояния до ППМ"
localize_table["ru"]["NAV Wind Heading/Speed"]		    			="ПВИ Индикация направления и скорости ветра"
localize_table["ru"]["NAV True Heading/Time/Range to final WPT"]	="ПВИ Индикация текущего истинного курса, времени полета и расстояния до КПМ"
localize_table["ru"]["NAV Bearing/Range to target"]		    		="ПВИ Индикация курсового угла и дальности до цели"
localize_table["ru"]["NAV Master modes"]		    				="ПВИ Галетный переключатель режимов"
localize_table["ru"]["NAV INU fixtaking method"]		    		="ПВИ Выбор способа коррекции координат, с помощью И-251 или пролетом"
localize_table["ru"]["NAV Datalink power"]		    				="ПВИ Включение режима внешнего целеуказания"
localize_table["ru"]["NAV Brightness"]		    					="ПВИ Регулировка яркости"

-- UV-26 CMD Control Panel (УВ-26 - Устройство Выброса ЛТЦ)
localize_table["ru"]["CMD Select Left/Both/Right board flares dispensers"]	="УВ-26 Переключатель Левый/Оба/Правый борт"
localize_table["ru"]["CMD Amount flares counter/Programming"]	="УВ-26 Переключатель Остаток ЛТЦ/Программирование"
localize_table["ru"]["CMD Num of sequences"]		    			="УВ-26 Количество залпов"
localize_table["ru"]["CMD Num in sequence"]		    				="УВ-26 Количество патронов в залпе"
localize_table["ru"]["CMD Dispense interval"]		    			="УВ-26 Интeрвал между залпами"
localize_table["ru"]["CMD Start dispense"]		    				="УВ-26 Запуск программы"
localize_table["ru"]["CMD Reset to default program"]		    	="УВ-26 Сброс программы"
localize_table["ru"]["CMD Stop dispense"]		    				="УВ-26 Останов программы"

-- UV-26 related (BACK CONTROL PANEL)
localize_table["ru"]["CMD Power"]		    						="УВ-26 Выключатель питания"
localize_table["ru"]["CMD BIT"]		    							="УВ-26 Контроль"

-- Datalink Control Panel
localize_table["ru"]["DLNK Send/Memory"]		    				="ПРЦ Передача или запоминание информации"
localize_table["ru"]["DLNK Ingress to target"]		    			="ПРЦ Режим выхода на цель"
localize_table["ru"]["DLNK Erase"]		    						="ПРЦ Стирание введенной информации"
localize_table["ru"]["N/A"]		    								="ПРЦ н.д."
localize_table["ru"]["DLNK to ALL"]		    						="ПРЦ Адресация информации всему звену"
localize_table["ru"]["DLNK to Wingman 1"]		    				="ПРЦ Адресация информации вертолету 1"
localize_table["ru"]["DLNK to Wingman 2"]		    				="ПРЦ Адресация информации вертолету 2"
localize_table["ru"]["DLNK to Wingman 3"]		    				="ПРЦ Адресация информации вертолету 3"
localize_table["ru"]["DLNK to Wingman 4"]		    				="ПРЦ Адресация информации вертолету 4"
localize_table["ru"]["DLNK Target #1/Vehicle"]		    			="ПРЦ Тип цели МАШИНА или номер 1"
localize_table["ru"]["DLNK Target #2/SAM"]		    				="ПРЦ Тип цели ЗРК или номер 2"
localize_table["ru"]["DLNK Target #3/Other Type"]		    		="ПРЦ Тип цели ДРУГАЯ или номер 3"
localize_table["ru"]["DLNK Ingress point"]		    				="ПРЦ Точка выхода"

-- Datalink Mode Controls
localize_table["ru"]["Datalink self ID"]		    				="ПВЦ Галетный переключатель КТО Я"
localize_table["ru"]["Datalink Master mode"]		    			="ПВЦ Галетный переключатель РЕЖИМ"

-- PUI-800 Weapons Control Panel (ПУИ-800 Пульт Управления и Индикации)
localize_table["ru"]["Master Arm"]		    						="ПУИ Главный выключатель СУО"
localize_table["ru"]["Not implemented"]		    					="ПУИ н.д."
localize_table["ru"]["External stores jettison"]		    		="ПУИ Кнопка аварийного сброса подвесок"
localize_table["ru"]["Manual/Auto weapon system control switch"]	="ПУИ Переключатель выбора режима СУО"
localize_table["ru"]["Cannon round selector switch HE/AP"]		    ="ПУИ Переключатель выбора типа патронной ленты пушки"
localize_table["ru"]["Weapon mode switch - Burst Length"]		   	="ПУИ Переключатель выбора длины очереди или количества ракет в залпе"
localize_table["ru"]["Cannon rate of fire setting"]		    		="ПУИ Переключатель выбора темпа стрельбы пушки"
localize_table["ru"]["Jettison arm mode - arm fuse/disarm fuse"]	="ПУИ Переключатель выбора режима сброса ВЗРЫВ-НЕВЗРЫВ"
localize_table["ru"]["Expedite emergency ATGM launch"]				="ПУИ Кнопка аварийного пуска ПТУР"

-- PUR Weapons Aux Panel (ПУР Пульт Управления Режимом)
localize_table["ru"]["IT-23 Black-White indication switch"]			="ПУР ИТ-23 Цвет индикации"
localize_table["ru"]["IT-23 display brightness"]		    		="ПУР ИТ-23 Яркость"
localize_table["ru"]["IT-23 display contrast"]		    			="ПУР ИТ-23 Контраст"
localize_table["ru"]["SHKVAL Optics adjustment"]		    		="ПУР ИТ Переключение светофильтров в КАПК"
localize_table["ru"]["Helmet device brightness"]					="ПУР Нашлемное устройство яркость"
localize_table["ru"]["Laser code selector"]		    				="ПУР Установка литера для КАПК"
localize_table["ru"]["HUD/TV declutter switch"]		    			="ПУР Переключение объема выводимой индикации на ИЛС и ИТ"

-- Auxiliary panel - Preflight Set and Check Panel (ППК - Пульт Подготовки и Контроля)
localize_table["ru"]["ATGM Temperature selector"]		    		="ППК Температура ПТУР"
localize_table["ru"]["Unguided rocket and gun pods ballistics data settings selector"] ="ППК Установки баллистических коэффициентов НАР и пушек"
localize_table["ru"]["Systems BIT selector"]		    			="ППК Установка режима проверки"
localize_table["ru"]["Control computers BIT switch"]		    	="ППК К-ЦВМ"
localize_table["ru"]["INU Power switch"]		    				="ППК Инерциальная курсо-вертикаль"
localize_table["ru"]["INU Heater switch"]		    				="ППК Обогрев инерциальной курсо-вертикали"
localize_table["ru"]["Self test system push-button"]		    	="ППК Система самотестирования"
localize_table["ru"]["Emergency INU alignment switch"]		    	="ППК Аварийная выставка ИКВ"
localize_table["ru"]["Stabilisation and indication of hanger cable switch"] ="ППК Стабилизация и индикация положения троса"
localize_table["ru"]["Video Tape Recorder switch"]		    		="ППК Фото-контрольный прибор"

localize_table["ru"]["Power plant, hydraulics, EKRAN self-test systems switch"]	="Выключатель электроснабжения систем ВМГ, ГИДРО и ЭКРАН."

-- PPR - Autopilot Control Panel (ППР - Пульт Пилотажных Режимов)
localize_table["ru"]["Autopilot Bank hold"]		    				="ППР Канал крена"
localize_table["ru"]["Autopilot Heading hold"]		    			="ППР Канал направления"
localize_table["ru"]["Autopilot Pitch hold"]		    			="ППР Канал тангажа"
localize_table["ru"]["Autopilot Altitude hold"]		    			="ППР Канал высоты"
localize_table["ru"]["Autopilot Director control"]					="ППР Канал директорного управления"
localize_table["ru"]["Autopilot BARO/RALT altitude hold mode"]		="ППР Режимы стабилизации высоты БАРО/РВ"
localize_table["ru"]["Autopilot Desired heading - Desired track"]	="ППР Режимы автоматизированного полета по маршруту ЗК/ЛЗП"

-- CLOCK (часы)
localize_table["ru"]["Mech clock left lever"]		    			="АЧС-1 Левая головка"
localize_table["ru"]["Mech clock right lever"]		    			="АЧС-1 Правая головка"

-- OVERHEAD PANEL
localize_table["ru"]["Brightness"]		    						="Яркость"
localize_table["ru"]["Rotor de-icing system switch"]		    	="Противообледенительная система винтов"
localize_table["ru"]["Engines de-icing / dust-protection systems switch"]	="Противообледенительная система двигателей / пылезащитное устройство"
localize_table["ru"]["Navigation Lights 10\% / 30\% / 100\% / Off"]	="Переключатель регулировки яркости свечения БАНО, 10\% / 30\% / 100\% / Off"
localize_table["ru"]["Windshield wiper switch"]		    			="Переключатель стеклоочистителя лобового стекла"
localize_table["ru"]["Windshield washer fluid switch"]		    	="Выключатель подачи омывающей жидкости"
localize_table["ru"]["Pitot static port and AoA sensors heat switch"] ="Выключатель подогрева приемника полного давления и датчиков угла атаки и сноса"
localize_table["ru"]["Pitot ram air and clock heat switch"]		    ="Выключатель подогрева приемника воздушного давления и часов"

localize_table["ru"]["Pitot heat system test"] = "Кнопка контроля обогрева ПВД"
-- HSI (ПНП)
localize_table["ru"]["HSI Commanded course rotary"]		    		="ПНП Кремальера заданного путевого угла"
localize_table["ru"]["HSI Commanded heading rotary"]		    	="ПНП Кремальера заданного курса"
localize_table["ru"]["HSI test"]		    						="ПНП Тест"
localize_table["ru"]["HSI Desired track angle - Desired heading, Auto - Manual"]		    ="ПНП ЗПУ-ЗК Ручной/Автоматический режим"

-- ADI (ИКП)
localize_table["ru"]["ADI Zero pitch trim"]		    				="ИКП Установка нулевого тангажа"
localize_table["ru"]["ADI Test"]		    						="ИКП Тест"

-- SAI (АГР-81)
localize_table["ru"]["Standby Attitude Indicator Cage/control test handle"]		="АГР Ручка арретира/тест контроль"
localize_table["ru"]["Standby Attitude Indicator power switch"]			="АГР Питание резервного авиагоризонта"

-- RADIOALTIMETER
localize_table["ru"]["Dangerous RALT set rotary"]		    		="РВ Установка сигнализации опасной высоты"
localize_table["ru"]["Radar altimeter test"]		    			="РВ Тест"

-- BARO ALTIMETER
localize_table["ru"]["Baro pressure QFE knob"]		    			="Кремальера установки высоты аэродрома (QFE)"

-- PVR (ПВР - Пульт Выбора Режимов К-041)
localize_table["ru"]["Training mode"]		    					="ПВР Режим ТРЕНАЖ"
localize_table["ru"]["Automatic turn on target mode"]		    	="ПВР Автоматический доворот на цель"
localize_table["ru"]["Airborne Target"]		    					="ПВР Воздушная цель"
localize_table["ru"]["Forward hemisphere (head-on) air target aspect"] ="ПВР Передняя полусфера атаки"
localize_table["ru"]["Ground moving target"]		    			="ПВР Наземная подвижная цель"
localize_table["ru"]["Weapon system mode selector"]		    		="ПВР Выбор режимов"
localize_table["ru"]["Targeting mode reset"]		    			="ПВР СБРОС задачи"
localize_table["ru"]["Automatic Tracking / gun sight"]		    	="ПВР Автоматическое сопровождение / Прицельная марка"
localize_table["ru"]["K-041 Targeting-navigation system power switch"]		   	="ПВР ПрПНК К-041"
localize_table["ru"]["Laser standby ON/OFF switch"]		    		="ПВР Выключатель готовности лазерного дальномера"
localize_table["ru"]["Helmet-mounted sight system power switch"]	="ПВР Нашлемное устройство"
localize_table["ru"]["Shkval scan rate"]		    				="Переключатель скорости сканирования КАПК"


-- Laser Warning System (Л-140)
localize_table["ru"]["LWS Reset button"]		    				="Л-140 кнопка СБРОС"
localize_table["ru"]["LWS Power switch"]		    				="Л-140 выключатель питания"
localize_table["ru"]["LWS self-test button"]		    			="Л-140 кнопка контроля (самотестирования) аппаратуры"

-- Engines Start Control Panel
localize_table["ru"]["Start-up selected engine button"]		    	="Запуск выбранного двигателя"
localize_table["ru"]["Interrupt start-up button"]		    		="Прекращение запуска"
localize_table["ru"]["Stop APU button"]		    					="Останов ВСУ"
localize_table["ru"]["Engine selector"]		    					="Переключатель двигателей четырехпозиционный"
localize_table["ru"]["Engine work mod selector"]		    		="Переключатель режима работы двигателя"
localize_table["ru"]["Left engine cut-off valve"]		    		="Стоп-кран левого двигателя"
localize_table["ru"]["Right engine cut-off valve"]		    		="Стоп-кран правого двигателя"
localize_table["ru"]["Rotor brake"]		    						="Тормоз винтов"
localize_table["ru"]["Engine Startup/Crank/False Start selector"]	="Переключатель режимов запуска, ЗАПУСК / ПРОКРУТКА / ЛОЖНЫЙ ЗАПУСК"

localize_table["ru"]["Running engines exhaust gas temperature indicator test button"]	="Кнопка контроля указателя температуры газов двигателей при работающих двигателях"
localize_table["ru"]["Stopped engines exhaust gas temperature indicator test button"]	="Кнопка контроля указателя температуры газов двигателей при неработающих двигателях"

--Radio switcher
localize_table["ru"]["SPU-9 Radio communicator selector"]		    ="СПУ-9 Выбор типа связи"

-- Fire Extinguishers Control Panel
localize_table["ru"]["Left engine extinguisher"]		    		="Система пожаротушения левого двигателя"
localize_table["ru"]["APU extinguisher"]		    				="Система пожаротушения ВСУ"
localize_table["ru"]["Right engine extinguisher"]		    		="Система пожаротушения правого двигателя"
localize_table["ru"]["Ventilator extinguisher"]		    			="Система пожаротушения в отсеке вентиляции"
localize_table["ru"]["Fire extinguisher Work – Off – Test switch"]	="Переключатель Огнетушители - Отключено - Контроль"
localize_table["ru"]["Fire signaling"]		    					="Выключатель пожарной сигнализации"
localize_table["ru"]["Fire extinguisher First (Auto) / Second (Manual) selector"]	="Переключатель БАЛЛОНЫ. Выбор первого (АВТО) или второго (РУЧН) баллона"
localize_table["ru"]["1st fire warning sensors group BIT"]			="Переключатель КОНТРОЛЬ ДАТЧИКОВ I ГР"
localize_table["ru"]["2nd fire warning sensors group BIT"]			="Переключатель КОНТРОЛЬ ДАТЧИКОВ II ГР"
localize_table["ru"]["3rd fire warning sensors group BIT"]			="Переключатель КОНТРОЛЬ ДАТЧИКОВ III ГР"

-- Misc. systems
localize_table["ru"]["Reducing gear box oil pressure indication selector"] ="Переключатель индикации давления масла в редукторах"
localize_table["ru"]["Sling load Auto/Manual"] 						="Подвеска груза на тросе АВТ/РУЧН"

-- Lighting
localize_table["ru"]["Lighting cockpit interior lamp switch"]		= "Освещение кабины - плафон"
localize_table["ru"]["Lighting cockpit panel switch"]		    	= "Подсвет приборов"
localize_table["ru"]["Lighting night vision cockpit switch"]		= "Подсвет пультов синий ОНВ"
localize_table["ru"]["Lighting ADI and SAI switch"]					= "Подсвет АГР и ПКП"
localize_table["ru"]["Lighting night vision cockpit brightness knob"]	= "Яркость синей ночной подсветки"
localize_table["ru"]["Lighting cockpit panel brightness knob"]		= "Яркость подсветки приборов"
localize_table["ru"]["Lighting HSI and ADI brightness knob"]		= "Яркость подсветки АГР и ПКП"
localize_table["ru"]["Lighting auxiliary panel switch"]				= "Посвет панели контроля"
localize_table["ru"]["Lighting auxiliary panel brightness knob"]		= "Яркость посвета панели контроля"

-- Outside illumination
localize_table["ru"]["Light landing-search. On/Retraction/Off"]		="Поисково-посадочная фара"
localize_table["ru"]["Lights landing-search change. Main/Reserved"]	="Переключатель поисково-посадочных фар. Основная/Резервная"
localize_table["ru"]["Tip Lights"]		    						="Контурные огни"
localize_table["ru"]["Anticollision Light"]		    				="Проблесковый маяк"
localize_table["ru"]["Navigation Lights 10\%/30\%/100\%/Off"]		="Аэронавигационные огни"
localize_table["ru"]["Formation Lights"]		    				="Строевые огни"

--ARK-22
localize_table["ru"]["ADF Inner-Auto-Outer NDB switch"]		    	="АРК Переключатель режима маяков Дальний/Автомат/Ближний"
localize_table["ru"]["ADF channel switch"]		    				="АРК Переключатель каналов"
localize_table["ru"]["COMPASS-ANTENNA modes"]		    			="АРК Выбор режима работы Компас/Антенна"
localize_table["ru"]["TLF-TLG modes"]		    					="АРК Телефон/Телеграф"
localize_table["ru"]["ADF Volume"]		    						="АРК Громкость звука"
localize_table["ru"]["ADF Test"]		    						="АРК Контроль"

-- Betty ("ALMAZ" system)
localize_table["ru"]["Voice message system messages off"]			="Речевой информатор отключить сообщения"
localize_table["ru"]["Voice message system emergency on"]			="Речевой информатор аварийный режим работы"
localize_table["ru"]["Voice message system messages repeat"]		="Речевой информатор повтор сообщений"
localize_table["ru"]["Voice message system check"]		    		="Речевой информатор контроль"

--R-800 Radio
localize_table["ru"]["R-800 (VHF-2) BIT button"]		    		="Р-800 (УКВ-2) Контроль"
localize_table["ru"]["R-800 (VHF-2) AM-FM toggle switch"]		    ="Р-800 (УКВ-2) Амплитудная/Частотная модуляция"
localize_table["ru"]["R-800 (VHF-2) Emergency receiver"]		    ="Р-800 (УКВ-2) Аварийный приемник"
localize_table["ru"]["R-800 (VHF-2) ADF switch"]		    		="Р-800 (УКВ-2) Подключение АРК"
localize_table["ru"]["R-800 (VHF-2) Data transfer rate switch"]		="Р-800 (УКВ-2) Переключатель скорости передачи"
localize_table["ru"]["R-800 (VHF-2) Squelch"]		    			="Р-800 (УКВ-2) Шумоподавитель"
localize_table["ru"]["R-800 (VHF-2) 1st rotary"]		    		="Р-800 (УКВ-2) Барабан задатчика частоты 1"
localize_table["ru"]["R-800 (VHF-2) 2nd rotary"]		    		="Р-800 (УКВ-2) Барабан задатчика частоты 2"
localize_table["ru"]["R-800 (VHF-2) 3rd rotary"]		    		="Р-800 (УКВ-2) Барабан задатчика частоты 3"
localize_table["ru"]["R-800 (VHF-2) 4th rotary"]		    		="Р-800 (УКВ-2) Барабан задатчика частоты 4"

--R-828 Radio
localize_table["ru"]["R-828 (VHF-1) Radio channel selector"]		="Р-828 (УКВ-1) Переключатель каналов"
localize_table["ru"]["R-828 (VHF-1) Radio Volume"]		    		="Р-828 (УКВ-1) Громкость"
localize_table["ru"]["R-828 (VHF-1) Tuner button"]		    		="Р-828 (УКВ-1) Автоматическое согласующее устройство (тюнер)"
localize_table["ru"]["R-828 (VHF-1) Squelch"]		    			="Р-828 (УКВ-1) Шумоподавитель"

--Signal Flares
localize_table["ru"]["Signal flare system power"]		    		="ПУСР Питание системы выброса сигнальных ракет"
localize_table["ru"]["Signal flare red"]		    				="ПУСР Сигнальная ракета красная"
localize_table["ru"]["Signal flare green"]		    				="ПУСР Сигнальная ракета зеленая"
localize_table["ru"]["Signal flare white"]		    				="ПУСР Сигнальная ракета белая"
localize_table["ru"]["Signal flare yellow"]		    				="ПУСР Сигнальная ракета желтая"

-- PShK_7 (Latitude Entry Panel) Пульт широтной коррекции
localize_table["ru"]["Latitude selection rotaty"]		    		="Задатчик широтной коррекции"
localize_table["ru"]["North/South latitude selection"]		    	="Северная/Южная широта"

-- ZMS_3 (Magnetic Variation Entry Panel) Задатчик магнитного склонения
localize_table["ru"]["Magnetic variation selection rotaty"]		    ="Задатчик магнитного склонения"


localize_table["de"] = {}

-- CPT MECH
localize_table["de"]["Gear lever"]		    						="Fahrwerkshebel"
localize_table["de"]["Main/Common hydraulics for emergency gear"]	="Fahrwerk-Notausfahrschalter"
localize_table["de"]["Accelerometer reset"]		    				="Beschleunigungsmesser zurücksetzen"

-- SYSTEM CONTROLLER
localize_table["de"]["Master caution push-light"]		    		="Hauptwarnleuchte MWL (Druckknopf)"
localize_table["de"]["Lamps test"]		    						="Warnleuchten-Test"
localize_table["de"]["Rotor RPM warning push-light"]		        ="Druckknopf Warnlampe niedrige Rotordrehzahl"
localize_table["de"]["MWS operation mode (not functional)"]			="Raketenanflugswarnsystem Betriebsmodus (ohne Funktion)"

--laser ranger ( front panel)
localize_table["de"]["Laser rangefinder / designator - mode switch"]	="Umschalter für Laser-Entfernungsmesser/-Zielbeleuchter"
localize_table["de"]["Laser designator reset"]		    			="Laserzielbeleuchter zurücksetzen"

-- Right Side Panel (Правый Боковой Пульт) 
-- ELECTRICS POWER
localize_table["de"]["DC ground power"]		    					="Externe Gleichstromversorgung DC"
localize_table["de"]["Battery 2"]		    						="Batterie 2"
localize_table["de"]["Battery 1"]		    						="Batterie 1"
localize_table["de"]["AC ground power"]		    					="Externe Wechselstromversorgung AC"
localize_table["de"]["AC left generator"]		    				="Linker Generator AC"
localize_table["de"]["AC right generator"]		    				="Rechter Generator AC"
localize_table["de"]["DC/AC inverter"]		    					="DC/AC Inverter"

-- FUEL PUMPS POWER AND VALVES
localize_table["de"]["Forward fuel tank pumps"]		    			="Kraftstoffpumpen vorderer Tank"
localize_table["de"]["Rear fuel tank pumps"]		    			="Kraftstoffpumpen hinterer Tank"
localize_table["de"]["Inner external fuel tanks pumps"]		    	="Kraftstoffpumpen externe Tanks, innere Flügelstationen"
localize_table["de"]["Outer external fuel tanks pumps"]		    	="Kraftstoffpumpen externe Tanks, äußere Flügelstationen"
localize_table["de"]["Fuelmeter power"]		    					="Stromversorgung der Kraftstoffanzeige"
localize_table["de"]["Left engine fuel shutoff valve"]		    	="Kraftstoffabsperrventil linkes Triebwerk"
localize_table["de"]["Right engine fuel shutoff valve"]		    	="Kraftstoffabsperrventil rechtes Triebwerk"
localize_table["de"]["APU fuel shutoff valve"]		    			="Kraftstoffabsperrventil Hilfsturbine (APU)"
localize_table["de"]["Fuel crossfeed valve"]		    			="Kraftstoff-Kreuzschaltventil (X-FEED)"
localize_table["de"]["Fuel quantity indicator self test button"]	="Kraftstoffmengenanzeiger Selbsttestknopf"

-- COMMS POWER
localize_table["de"]["Intercom"]		    						="SPU-9 Intercom Stromversorgung"
localize_table["de"]["VHF-1 (R828) power switch"]		    		="R-828 VHF-1 Funkgerät Stromversorgung"
localize_table["de"]["VHF-2 (R-800) power switch"]		    		="R-800 VHF-2 Funkgerät Stromversorgung"
localize_table["de"]["Radio equipment datalink TLK power switch"]	="Data Link TLK Stromversorgung"
localize_table["de"]["Radio equipment datalink UHF TLK power switch"]	="Data Link VHF TLK Stromversorgung"
localize_table["de"]["Radio equipment datalink SA-TLF power switch"]	="Data Link SA-TLF Stromversorgung"

-- WEAPON SYS
localize_table["de"]["Weapons сontrol system"]		    			="Feuerleitsystem"

-- EJECT SYSTEM
localize_table["de"]["Ejecting system power 1"]		    			="Schleudersitzsystem Stromversorgung 1"
localize_table["de"]["Ejecting system power 2"]		    			="Schleudersitzsystem Stromversorgung 2"
localize_table["de"]["Ejecting system power 3"]		    			="Schleudersitzsystem Stromversorgung 3"
localize_table["de"]["Ejecting system power"]		    			="Schleudersitzsystem Stromversorgung"
localize_table["de"]["Ejecting system circuit test"]		    	="Schleudersitzsystem Stromkreis-Testknopf"
localize_table["de"]["Ejecting system circuit selector"]		   	="Schleudersitzsystem Ausstiegsmodus-Wahlschalter"

-- HYDRAULICS
localize_table["de"]["Main hydraulics"]		    					="Haupthydrauliksystem"

-- IFF
localize_table["de"]["IFF power"]		    						="IFF Freund-Feind-Kenngerät Stromversorgung"

-- ENGINES
localize_table["de"]["EEG Left engine Electronic Engine Governor"]	="EEG elektronischer Triebwerksregler linkes Triebwerk"
localize_table["de"]["EEG Right engine Electronic Engine Governor"]	="EEG elektronischer Triebwerksregler rechtes Triebwerk"
localize_table["de"]["EEG power turbine channel 1 test – Operate – EEG power turbine channel 2 test, three-switch contactor"]	="EEG Antriebsturbine Testkanal 1 / Betrieb / Testkanal 2, Dreifachschalter"
localize_table["de"]["EEG gas generator test – Operate switch"]		="EEG Gasgenerator Test / Betrieb"
localize_table["de"]["Left EGT control threshold governor button"]	="EGT Abgastemperaturüberwachung linkes Triebwerk, Schwellenwertregelknopf"
localize_table["de"]["Right EGT control threshold governor button"]	="EGT Abgastemperaturüberwachung rechtes Triebwerk, Schwellenwertregelknopf"
localize_table["de"]["Engines vibrations monitoring system control button"]	="Triebwerksvibrationsüberwachung Kontrollknopf"

-- NAV SYSTEM
localize_table["de"]["Navigation system power"]						="Ziel- und Navigationssystem Stromversorgung"
localize_table["de"]["Gyro/Mag/Manual heading"]		    			="Magnetischer Steuerkurs - Kreiselgerät – Manueller Steuerkurs"

-- SHKVAL windscreen wiper
localize_table["de"]["SHKVAL windscreen wiper"]		    			="Shkval-Scheibenwischer"


-- ABRIS Display (Дисплей АБРИС) 
localize_table["de"]["ABRIS Pushbutton 1"]		    				="ABRIS Funktionsknopf 1"
localize_table["de"]["ABRIS Pushbutton 2"]		    				="ABRIS Funktionsknopf 2"
localize_table["de"]["ABRIS Pushbutton 3"]		    				="ABRIS Funktionsknopf 3"
localize_table["de"]["ABRIS Pushbutton 4"]		    				="ABRIS Funktionsknopf 4"
localize_table["de"]["ABRIS Pushbutton 5"]		    				="ABRIS Funktionsknopf 5"
localize_table["de"]["ABRIS Cursor сontrol (rot/push)"]		    	="ABRIS Cursordrehknopf (rotieren / drücken)"
localize_table["de"]["ABRIS Brightness"]		    				="ABRIS Helligkeitsregler"
localize_table["de"]["ABRIS Power"]		    						="ABRIS Stromversorgung"

-- HUD (ИЛС)
localize_table["de"]["HUD Brightness"]		    					="HUD Helligkeitseinstellung"
localize_table["de"]["HUD Modes Reticle/Night/Day"]		    		="HUD Modusschalter, Tag / Nacht / Ersatzvisier"
localize_table["de"]["HUD Test"]		    						="HUD Selbsttestknopf"
localize_table["de"]["HUD Filter"]		    						="HUD Farbfilterhebel"

-- PVI NAV Panel (ПВИ - Пульт Ввода и Индикации)
localize_table["de"]["NAV '0' Btn"]		    						="PVI Taste 0"
localize_table["de"]["NAV '1' Btn"]		    						="PVI Taste 1"
localize_table["de"]["NAV '2' Btn"]		    						="PVI Taste 2"
localize_table["de"]["NAV '3' Btn"]		    						="PVI Taste 3"
localize_table["de"]["NAV '4' Btn"]		    						="PVI Taste 4"
localize_table["de"]["NAV '5' Btn"]		    						="PVI Taste 5"
localize_table["de"]["NAV '6' Btn"]		    						="PVI Taste 6"
localize_table["de"]["NAV '7' Btn"]		    						="PVI Taste 7"
localize_table["de"]["NAV '8' Btn"]		    						="PVI Taste 8"
localize_table["de"]["NAV '9' Btn"]		    						="PVI Taste 9"
localize_table["de"]["NAV Waypoints"]		    					="PVI Wegpunkt-Navigationsmodus"
localize_table["de"]["NAV Inflight INU Realignment"]		    	="PVI INU Wiederabgleich im Flug, ohne Funktion"
localize_table["de"]["NAV Fixpoints"]		    					="PVI Referenzpunktupdate-Navigationsmodus"
localize_table["de"]["NAV Precise INU Alignment"]		    		="PVI Fehlerfreier INU Abgleich"
localize_table["de"]["NAV Airfields"]		    					="PVI Flugplatz-Navigationsmodus"
localize_table["de"]["NAV Normal INU Alignment"]		    		="PVI normaler INU Abgleich"
localize_table["de"]["NAV Targets"]		    						="PVI Zielpunkt-Navigationsmodus"
localize_table["de"]["NAV Enter"]		    						="PVI Eingabe-Knopf"
localize_table["de"]["NAV Cancel"]		    						="PVI Abbruch-Knopf"
localize_table["de"]["NAV Initial Nav Pos"]		    				="PVI Startpunkt-Koordinaten"
localize_table["de"]["NAV Self coordinates"]		    			="PVI Koordinaten des eigenen Flugzeugs"
localize_table["de"]["NAV Course:Course Deviation/Time/Range to WPT"] ="PVI Sollkurs:XTE / Zeit / Entfernung zum Wegpunkt"
localize_table["de"]["NAV Wind Heading/Speed"]		    			="PVI Windrichtung / -Geschwindigkeit"
localize_table["de"]["NAV True Heading/Time/Range to final WPT"]	="PVI Rechtweisender Steuerkurs / Zeit / Entfernung zum letzten Wegpunkt"
localize_table["de"]["NAV Bearing/Range to target"]		    		="PVI Steuerkurs / Entfernung zum Zielpunkt"
localize_table["de"]["NAV Master modes"]		    				="PVI Betriebsmodusschalter"
localize_table["de"]["NAV INU fixtaking method"]		    		="PVI INU Korrekturmodus, I-251V Shkval – Überflug"
localize_table["de"]["NAV Datalink power"]		    				="PVI Data Link ein / aus"
localize_table["de"]["NAV Brightness"]		    					="PVI Helligkeitsregler"

-- UV-26 CMD Control Panel (УВ-26 - Устройство Выброса ЛТЦ)
localize_table["de"]["CMD Select Left/Both/Right board flares dispensers"]	="UV-26 Fackelwerfer-Seitenauswahl, links / beide / rechts"
localize_table["de"]["CMD Amount flares counter/Programming"]	="UV-26 Menge / Programm"
localize_table["de"]["CMD Num of sequences"]		    			="UV-26 Anzahl an Sequenzen"
localize_table["de"]["CMD Num in sequence"]		    				="UV-26 Anzahl Täuschkörper pro Sequenz"
localize_table["de"]["CMD Dispense interval"]		    			="UV-26 Ausstoßintervall"
localize_table["de"]["CMD Start dispense"]		    				="UV-26 Ausstoßprogramm starten"
localize_table["de"]["CMD Reset to default program"]		    	="UV-26 Programm zurücksetzen (auf Standardprogramm 110)"
localize_table["de"]["CMD Stop dispense"]		    				="UV-26 Ausstoßprogramm stoppen"

-- UV-26 related (BACK CONTROL PANEL)
localize_table["de"]["CMD Power"]		    						="UV-26 Energieversorgung"
localize_table["de"]["CMD BIT"]		    							="UV-26 BIT Selbsttest-Schalter"

-- Datalink Control Panel
localize_table["de"]["DLNK Send/Memory"]		    				="Data Link Senden / Speichern"
localize_table["de"]["DLNK Ingress to target"]		    			="Data Link Automatische Zielausrichtung"
localize_table["de"]["DLNK Erase"]		    						="Data Link Löschen"
localize_table["de"]["N/A"]		    								="N/A"
localize_table["de"]["DLNK to ALL"]		    						="Data Link an Alle"
localize_table["de"]["DLNK to Wingman 1"]		    				="Data Link an Flügelmann 1"
localize_table["de"]["DLNK to Wingman 2"]		    				="Data Link an Flügelmann 2"
localize_table["de"]["DLNK to Wingman 3"]		    				="Data Link an Flügelmann 3"
localize_table["de"]["DLNK to Wingman 4"]		    				="Data Link an Flügelmann 4"
localize_table["de"]["DLNK Target #1/Vehicle"]		    			="Data Link Zieltyp #1 / Fahrzeuge"
localize_table["de"]["DLNK Target #2/SAM"]		    				="Data Link Zieltyp #2 / SAM oder AAA"
localize_table["de"]["DLNK Target #3/Other Type"]		    		="Data Link Zieltyp #3 / Andere"
localize_table["de"]["DLNK Ingress point"]		    				="Data Link Zielanflugspunkt"

-- Datalink Mode Controls
localize_table["de"]["Datalink self ID"]		    				="Data Link Eigene ID"
localize_table["de"]["Datalink Master mode"]		    			="Data Link Datenübertragungsmodus"

-- PUI-800 Weapons Control Panel (ПУИ-800 Пульт Управления и Индикации)
localize_table["de"]["Master Arm"]		    						="Waffenhauptschalter"
localize_table["de"]["Not implemented"]		    					="N/A"
localize_table["de"]["External stores jettison"]		    		="Außenlasten-Notabwurf"
localize_table["de"]["Manual/Auto weapon system control switch"]	="Waffenkontrollschalter manuell / automatisch"
localize_table["de"]["Cannon round selector switch HE/AP"]		    ="Munitionsauswahl für Bordkanone"
localize_table["de"]["Weapon mode switch - Burst Length"]		   	="Waffenmodusschalter - Salvenlänge"
localize_table["de"]["Cannon rate of fire setting"]		    		="Feuerrate der Bordkanone (Kadenz)"
localize_table["de"]["Jettison arm mode - arm fuse/disarm fuse"]	="Waffen scharf / gesichert für Notabwurf"
localize_table["de"]["Expedite emergency ATGM launch"]				="Notabschussschalter für Panzerabwehrlenkwaffen"

-- PUR Weapons Aux Panel (ПУР Пульт Управления Режимом)
localize_table["de"]["IT-23 Black-White indication switch"]			="IT-23 TV-Bildschirm Polarität (schwarze / weiße Symbolik)"
localize_table["de"]["IT-23 display brightness"]		    		="IT-23 TV-Bildschirm Helligkeitsregler"
localize_table["de"]["IT-23 display contrast"]		    			="IT-23 TV-Bildschirm Kontrastregler"
localize_table["de"]["SHKVAL Optics adjustment"]		    		="Shkvaloptik Farbfilter"
localize_table["de"]["Helmet device brightness"]					="Helmgerät Helligkeitsregler (HMS / NVG)"
localize_table["de"]["Laser code selector"]		    				="Lasercode-Wahlschalter"
localize_table["de"]["HUD/TV declutter switch"]		    			="Vereinfachte HUD / TV Symbolik"

-- Auxiliary panel - Preflight Set and Check Panel (ППК - Пульт Подготовки и Контроля)
localize_table["de"]["ATGM Temperature selector"]		    		="ATGM Temperaturauswahl"
localize_table["de"]["Unguided rocket and gun pods ballistics data settings selector"] ="Ballistik-Wahlschalter Raketen / Kanonenbehälter"
localize_table["de"]["Systems BIT selector"]		    			="Feuerleitsystem Selbsttest-Wahlschalter"
localize_table["de"]["Control computers BIT switch"]		    	="Steuercomputer Selbsttest-Schalter"
localize_table["de"]["INU Power switch"]		    				="INU Stromversorgungsschalter"
localize_table["de"]["INU Heater switch"]		    				="INU Heizungsschalter"
localize_table["de"]["Self test system push-button"]		    	="Feuerleitrechner Selbsttest-Knopf"
localize_table["de"]["Emergency INU alignment switch"]		    	="Schalter für Notfallausrichtung des Trägheitsnavigationssystems"
localize_table["de"]["Stabilisation and indication of hanger cable switch"] ="Stabilisierung des Kabels für schwingende Außenlasten"
localize_table["de"]["Video Tape Recorder switch"]		    		="HUD-Videorekorder"

localize_table["de"]["Power plant, hydraulics, EKRAN self-test systems switch"]	="Stromversorgung für Hydraulik- / Getriebebaugruppen und EKRAN Selbsttest-Systeme"

-- PPR - Autopilot Control Panel (ППР - Пульт Пилотажных Режимов)
localize_table["de"]["Autopilot Bank hold"]		    				="Autopilot Roll-Dämpfer - Querlage halten"
localize_table["de"]["Autopilot Heading hold"]		    			="Autopilot Gier-Dämpfer - Steuerkurs / Kurs halten"
localize_table["de"]["Autopilot Pitch hold"]		    			="Autopilot Nick-Dämpfer - Nickwinkel halten"
localize_table["de"]["Autopilot Altitude hold"]		    			="Autopilot Flughöhenhaltung"
localize_table["de"]["Autopilot Director control"]					="Autopilot Flight-Director-Modus"
localize_table["de"]["Autopilot BARO/RALT altitude hold mode"]		="Autopilot Barometrische / Radarhöhe halten (BARO / R-ALT)"
localize_table["de"]["Autopilot Desired heading - Desired track"]	="Autopilot Geplanten Steuerkurs/Sollkurs halten (DH / DT)"

-- CLOCK (часы)
localize_table["de"]["Mech clock left lever"]		    			="Borduhr, linker Drehknopf"
localize_table["de"]["Mech clock right lever"]		    			="Borduhr, rechter Drehknopf"

-- OVERHEAD PANEL
localize_table["de"]["Brightness"]		    						="Helligkeitsregler"
localize_table["de"]["Rotor de-icing system switch"]		    	="Hauptrotorblattheizung (Enteisung)"
localize_table["de"]["Engines de-icing / dust-protection systems switch"]	="Triebwerksenteisung / Staubschutzsystem"
localize_table["de"]["Navigation Lights 10\% / 30\% / 100\% / Off"]	="Helligkeit der Navigationslichter 10\% / 30\% / 100\% / Aus"
localize_table["de"]["Windshield wiper switch"]		    			= "Scheibenwischerschalter"
localize_table["de"]["Windshield washer fluid switch"]		    	="Scheibenwaschflüssigkeit"
localize_table["de"]["Pitot static port and AoA sensors heat switch"] ="Pitot-Statikdrucksensor- und Anstellwinkelgeber-Heizung"
localize_table["de"]["Pitot ram air and clock heat switch"]		    ="Pitot-Staudrucksensor- und Borduhr-Heizung"
localize_table["de"]["Pitot heat system test"] 						= "Pitot-Staurohr-Heizung Systemtest"

-- HSI (ПНП)
localize_table["de"]["HSI Commanded course rotary"]		    		="HSI Einstellknopf für Sollkurs"
localize_table["de"]["HSI Commanded heading rotary"]		    	="HSI Einstellknopf für geplanten Steuerkurs"
localize_table["de"]["HSI test"]		    						="HSI Selbsttest"
localize_table["de"]["HSI Desired track angle - Desired heading, Auto - Manual"]		    ="HSI Sollkurs DTA - geplanter Steuerkurs DH, auto / manuell"

-- ADI (ИКП)
localize_table["de"]["ADI Zero pitch trim"]		    				="ADI Flugzeugsymbol-Einstellknopf"
localize_table["de"]["ADI Test"]		    						="ADI Selbsttest"

-- SAI (АГР-81)
localize_table["de"]["Standby Attitude Indicator Cage/control test handle"]		="SAI Ersatzfluglageanzeiger Einstell- und Testknopf"
localize_table["de"]["Standby Attitude Indicator power switch"]			="SAI Ersatzfluglageanzeiger Stromversorgung"

-- RADIOALTIMETER
localize_table["de"]["Dangerous RALT set rotary"]		    		="Radarhöhenmesser Mindestsicherheitsflughöhe"
localize_table["de"]["Radar altimeter test"]		    			="Radarhöhenmesser Testknopf"

-- BARO ALTIMETER
localize_table["de"]["Baro pressure QFE knob"]		    			="Barometrischer Höhenmesser QFE-Druckeinstellknopf"

-- PVR (ПВР - Пульт Выбора Режимов К-041)
localize_table["de"]["Training mode"]		    					="Trainingssmodus"
localize_table["de"]["Automatic turn on target mode"]		    	="Automatisches Eindrehen auf Ziel"
localize_table["de"]["Airborne Target"]		    					="Luftzielmodus"
localize_table["de"]["Forward hemisphere (head-on) air target aspect"] ="Luftziel von vorne"
localize_table["de"]["Ground moving target"]		    			="Bewegliches Bodenziel"
localize_table["de"]["Weapon system mode selector"]		    		="Waffensystemmodus-Auswahlschalter"
localize_table["de"]["Targeting mode reset"]		    			="Zielmodus zurücksetzen"
localize_table["de"]["Automatic Tracking / gun sight"]		    	="Automatische Zielverfolgung / Kanonen-Reflexvisier"
localize_table["de"]["K-041 Targeting-navigation system power switch"]		   	="K-041 Ziel- und Navigationssystem Stromversorgung"
localize_table["de"]["Laser standby ON/OFF switch"]		    		="Laser-Standbymodus ein / aus"
localize_table["de"]["Helmet-mounted sight system power switch"]	="Helmvisier/Nachtsichtgerät ein / aus"
localize_table["de"]["Shkval scan rate"]		    				="Shkval-Abtastrate"


-- Laser Warning System (Л-140)
localize_table["de"]["LWS Reset button"]		    				="LWS zurücksetzen"
localize_table["de"]["LWS Power switch"]		    				="LWS Energieversorgung"
localize_table["de"]["LWS self-test button"]		    			="LWS Selbsttest"

-- Engines Start Control Panel
localize_table["de"]["Start-up selected engine button"]		    	="Triebwerks- / Hilfsturbinen-Startknopf"
localize_table["de"]["Interrupt start-up button"]		    		="Startabbruch"
localize_table["de"]["Stop APU button"]		    					="APU herunterfahren"
localize_table["de"]["Engine selector"]		    					="Triebwerk- / APU-Auswahlschalter"
localize_table["de"]["Engine work mod selector"]		    		="Triebwerksbetriebsmodus"
localize_table["de"]["Left engine cut-off valve"]		    		="Absperrventil (Brandhahn) linkes Triebwerk"
localize_table["de"]["Right engine cut-off valve"]		    		="Absperrventil (Brandhahn) rechtes Triebwerk"
localize_table["de"]["Rotor brake"]		    						="Rotorbremse"
localize_table["de"]["Engine Startup/Crank/False Start selector"]	="Triebwerksanlassmodus Start / Ventilieren / Fehlstart"

localize_table["de"]["Running engines exhaust gas temperature indicator test button"]	="EGT Abgastemperatur-Anzeigetest bei laufenden Triebwerken"
localize_table["de"]["Stopped engines exhaust gas temperature indicator test button"]	="EGT Abgastemperatur-Anzeigetest bei stehenden Triebwerken"

--Radio switcher
localize_table["de"]["SPU-9 Radio communicator selector"]		    ="SPU-9 Intercom Auswahlschalter"

-- Fire Extinguishers Control Panel
localize_table["de"]["Left engine extinguisher"]		    		="Auslöseknopf für Feuerlöscher, Triebwerk links"
localize_table["de"]["APU extinguisher"]		    				="Auslöseknopf für Feuerlöscher, Hilfsturbine"
localize_table["de"]["Right engine extinguisher"]		    		="Auslöseknopf für Feuerlöscher, Triebwerk rechts"
localize_table["de"]["Ventilator extinguisher"]		    			="Auslöseknopf für Feuerlöscher, Ölkühler-Gebläse"
localize_table["de"]["Fire extinguisher Work – Off – Test switch"]	="Feuerlöschanlage Ein / Aus / Test"
localize_table["de"]["Fire signaling"]		    					="Feueralarm Ein / Aus"
localize_table["de"]["Fire extinguisher First (Auto) / Second (Manual) selector"]	="1. (automatischer) / 2. (manueller) Feuerlöschmodus"
localize_table["de"]["1st fire warning sensors group BIT"]			="1. Gruppe Feuerwarnsensoren Selbsttest"
localize_table["de"]["2nd fire warning sensors group BIT"]			="2. Gruppe Feuerwarnsensoren Selbsttest"
localize_table["de"]["3rd fire warning sensors group BIT"]			="3. Gruppe Feuerwarnsensoren Selbsttest"

-- Misc. systems
localize_table["de"]["Reducing gear box oil pressure indication selector"] ="Auswahlschalter Getriebeöldruckanzeige verringern"
localize_table["de"]["Sling load Auto/Manual"] 						="Angehängte Außenlast auto / manuell"

-- Lighting
localize_table["de"]["Lighting cockpit interior lamp switch"]		= "Cockpitinnenbeleuchtung"
localize_table["de"]["Lighting cockpit panel switch"]		    	= "Hintergrundbeleuchtung für Cockpitpanels"
localize_table["de"]["Lighting night vision cockpit switch"]		= "Nachtsichtbeleuchtung"
localize_table["de"]["Lighting ADI and SAI switch"]					= "Beleuchtung für SAI und ADI"
localize_table["de"]["Lighting night vision cockpit brightness knob"]	= "Helligkeitsregler für blaue Nachtsichtbeleuchtung"
localize_table["de"]["Lighting cockpit panel brightness knob"]		= "Helligkeitsregler für Hintergrundbeleuchtung der Cockpitpanels"
localize_table["de"]["Lighting HSI and ADI brightness knob"]		= "Helligkeitsregler für HSI und ADI"
localize_table["de"]["Lighting auxiliary panel switch"]				= "Beleuchtung hinteres Panel"
localize_table["de"]["Lighting auxiliary panel brightness knob"]		= "Helligkeitsregler Beleuchtung hinteres Panel"

-- Outside illumination
localize_table["de"]["Light landing-search. On/Retraction/Off"]		="Landelichter / Suchscheinwerfer an / einfahren / aus"
localize_table["de"]["Lights landing-search change. Main/Reserved"]	="Haupt- und Notlandelichter"
localize_table["de"]["Tip Lights"]		    						="Rotorblattspitzenbeleuchtung"
localize_table["de"]["Anticollision Light"]		    				="Antikollisionslicht"
localize_table["de"]["Navigation Lights 10\%/30\%/100\%/Off"]		="Navigationslichter 10\% / 30\% / 100\% / Aus"
localize_table["de"]["Formation Lights"]		    				="Formationslichter"

--ARK-22
localize_table["de"]["ADF Inner-Auto-Outer NDB switch"]		    	="ADF Schalter für ungerichtetes Funkfeuer (inneres / auto / äußeres)"
localize_table["de"]["ADF channel switch"]		    				="ADF Kanalwahlschalter"
localize_table["de"]["COMPASS-ANTENNA modes"]		    			="ADF Kompass-Antenne Modus"
localize_table["de"]["TLF-TLG modes"]		    					="ADF TLF-TLG Modus"
localize_table["de"]["ADF Volume"]		    						="ADF Lautstärke"
localize_table["de"]["ADF Test"]		    						="ADF Selbsttest"

-- Betty ("ALMAZ" system)
localize_table["de"]["Voice message system messages off"]			="Sprachmitteilung abbrechen"
localize_table["de"]["Voice message system emergency on"]			="Sprachinformationssystem Notfallmodus"
localize_table["de"]["Voice message system messages repeat"]		="Sprachmitteilung wiederholen"
localize_table["de"]["Voice message system check"]		    		="Sprachinformationssystem Selbsttest"

--R-800 Radio
localize_table["de"]["R-800 (VHF-2) BIT button"]		    		="R-800 (VHF-2) Testknopf"
localize_table["de"]["R-800 (VHF-2) AM-FM toggle switch"]		    ="R-800 (VHF-2) AM-FM Umschalter"
localize_table["de"]["R-800 (VHF-2) Emergency receiver"]		    ="R-800 (VHF-2) Notfallfrequenz"
localize_table["de"]["R-800 (VHF-2) ADF switch"]		    		="R-800 (VHF-2) ADF-Schalter"
localize_table["de"]["R-800 (VHF-2) Data transfer rate switch"]		="R-800 (VHF-2) Data Link Datentransferrate"
localize_table["de"]["R-800 (VHF-2) Squelch"]		    			="R-800 (VHF-2) Rauschunterdrückung"
localize_table["de"]["R-800 (VHF-2) 1st rotary"]		    		="R-800 (VHF-2) Frequenzdrehregler 1"
localize_table["de"]["R-800 (VHF-2) 2nd rotary"]		    		="R-800 (VHF-2) Frequenzdrehregler 2"
localize_table["de"]["R-800 (VHF-2) 3rd rotary"]		    		="R-800 (VHF-2) Frequenzdrehregler 3"
localize_table["de"]["R-800 (VHF-2) 4th rotary"]		    		="R-800 (VHF-2) Frequenzdrehregler 4"

--R-828 Radio
localize_table["de"]["R-828 (VHF-1) Radio channel selector"]		="R-828 (VHF-1) Kanalauswahl"
localize_table["de"]["R-828 (VHF-1) Radio Volume"]		    		="R-828 (VHF-1) Lautstärkenregler"
localize_table["de"]["R-828 (VHF-1) Tuner button"]		    		="R-828 (VHF-1) automatischer Tuner"
localize_table["de"]["R-828 (VHF-1) Squelch"]		    			="R-828 Rauschunterdrückung"

--Signal Flares
localize_table["de"]["Signal flare system power"]		    		="Leuchtsignalsystem Stromversorgung"
localize_table["de"]["Signal flare red"]		    				="Leuchtkugel - rot"
localize_table["de"]["Signal flare green"]		    				="Leuchtkugel - grün"
localize_table["de"]["Signal flare white"]		    				="Leuchtkugel - weiß"
localize_table["de"]["Signal flare yellow"]		    				="Leuchtkugel - gelb"

-- PShK_7 (Latitude Entry Panel) Пульт широтной коррекции
localize_table["de"]["Latitude selection rotaty"]		    		="Breitengrad-Auswahlschalter"
localize_table["de"]["North/South latitude selection"]		    	="Nord- / Süd-Ausrichtung"

-- ZMS_3 (Magnetic Variation Entry Panel) Задатчик магнитного склонения
localize_table["de"]["Magnetic variation selection rotaty"]		    ="Magnetische Ortsmissweisung Drehschalter"

localize_table["es"] = {}

-- CPT MECH
localize_table["es"]["Gear lever"]		    						="Palanca del tren de aterrizaje"
localize_table["es"]["Main/Common hydraulics for emergency gear"]	="Selector de hidráulico Principal/Común para extensión del tren por emergencia"
localize_table["es"]["Accelerometer reset"]		    				="Puesta a cero del acelerómetro"

-- SYSTEM CONTROLLER
localize_table["es"]["Master caution push-light"]		    		="Pastilla de alarma principal"
localize_table["es"]["Lamps test"]		    						="Prueba de luces"
localize_table["es"]["Rotor RPM warning push-light"]		    	="Pulsador de aviso de bajas revoluciones de los rotor"
localize_table["es"]["MWS operation mode (not functional)"]			="Modo de operación del sistema de alerta de misil MWS (no funcional)"

--laser ranger ( front panel)
localize_table["es"]["Laser rangefinder / designator - mode switch"]	="Láser - Interruptor de modo del telémetro-designador"
localize_table["es"]["Laser designator reset"]		    			="Reinicio del designador láser"

-- Right Side Panel (Правый Боковой Пульт) 
-- ELECTRICS POWER
localize_table["es"]["DC ground power"]		    					="Energía eléctrica externa de DC"
localize_table["es"]["Battery 2"]		    						="Batería 2"
localize_table["es"]["Battery 1"]		    						="Batería 1"
localize_table["es"]["AC ground power"]		    					="Energía eléctrica externa de AC"
localize_table["es"]["AC left generator"]		    				="Generador izquierdo de AC"
localize_table["es"]["AC right generator"]		    				="Generador derecho de AC"
localize_table["es"]["DC/AC inverter"]		    					="Inversor DC/AC"

-- FUEL PUMPS POWER AND VALVES
localize_table["es"]["Forward fuel tank pumps"]		    			="Bombas de combustible del tanque delantero"
localize_table["es"]["Rear fuel tank pumps"]		    			="Bombas de combustible del tanque trasero"
localize_table["es"]["Inner external fuel tanks pumps"]		    	="Bombas de combustible de los tanques externos interiores"
localize_table["es"]["Outer external fuel tanks pumps"]		    	="Bombas de combustible de los tanques externos exteriores"
localize_table["es"]["Fuelmeter power"]		    					="Alimentación del aforador de combustible"
localize_table["es"]["Left engine fuel shutoff valve"]		    	="Válvula de corte de combustible del motor izquierdo"
localize_table["es"]["Right engine fuel shutoff valve"]		    	="Válvula de corte de combustible del motor derecho"
localize_table["es"]["APU fuel shutoff valve"]		    			="Válvula de corte de combustible del APU"
localize_table["es"]["Fuel crossfeed valve"]		    			="Válvula de alimentación cruzada de combustible"
localize_table["es"]["Fuel quantity indicator self test button"]	="Botón de autoprueba del indicador de cantidad de combustible"

-- COMMS POWER
localize_table["es"]["Intercom"]		    						="Intercom (SPU-9)"
localize_table["es"]["VHF-1 (R828) power switch"]		    		="Interruptor VHF-1 R-828"
localize_table["es"]["VHF-2 (R-800) power switch"]		    		="Interruptor VHF-2 R-800"
localize_table["es"]["Radio equipment datalink TLK power switch"]	="Interruptor equipo de radio - enlace de datos TLK"
localize_table["es"]["Radio equipment datalink UHF TLK power switch"]	="Interruptor equipo de radio de enlace de datos UHF TLK"
localize_table["es"]["Radio equipment datalink SA-TLF power switch"]	="Interruptor equipo de radio de enlace de datos SA-TLK"

-- WEAPON SYS
localize_table["es"]["Weapons сontrol system"]		    			="Sistema de control de armamento"

-- EJECT SYSTEM
localize_table["es"]["Ejecting system power 1"]		    			="Alimentación 1 del sistema de eyección"
localize_table["es"]["Ejecting system power 2"]		    			="Alimentación 2 del sistema de eyección"
localize_table["es"]["Ejecting system power 3"]		    			="Alimentación 3 del sistema de eyección"
localize_table["es"]["Ejecting system power"]		    			="Alimentación del sistema de eyección"
localize_table["es"]["Ejecting system circuit test"]		    	="Prueba del circuito del sistema de eyección"
localize_table["es"]["Ejecting system circuit selector"]		   	="Selector del circuito del sistema de eyección"

-- HYDRAULICS
localize_table["es"]["Main hydraulics"]		    					="Circuito hidráulico principal"

-- IFF
localize_table["es"]["IFF power"]		    						="Energía del IFF"

-- ENGINES
localize_table["es"]["EEG Left engine Electronic Engine Governor"]	="Regulador electrónico del motor izquierdo - EEG"
localize_table["es"]["EEG Right engine Electronic Engine Governor"]	="Regulador electrónico del motor derecho - EEG"
localize_table["es"]["EEG power turbine channel 1 test – Operate – EEG power turbine channel 2 test, three-switch contactor"]	="Interruptor de prueba - operación de los reguladores electrónicos (EEG) de las turbinas canal 1 / canal 2, interruptor de tres posiciones"
localize_table["es"]["EEG gas generator test – Operate switch"]		="Interruptor de prueba - operación del generador de gas EEG"
localize_table["es"]["Left EGT control threshold governor button"]	="Regulador izquierdo de umbral de EGT"
localize_table["es"]["Right EGT control threshold governor button"]	="Regulador derecho de umbral de EGT"
localize_table["es"]["Engines vibrations monitoring system control button"]	="Botón del sistema de monitorización de vibración de motor"

-- NAV SYSTEM
localize_table["es"]["Navigation system power"]						="Alimentación del sistema de navegación"
localize_table["es"]["Gyro/Mag/Manual heading"]		    			="Rumbo Giro/Mag/Manual"

-- SHKVAL windscreen wiper
localize_table["es"]["SHKVAL windscreen wiper"]		    			="Limpiaparabrisas del Shkval"


-- ABRIS Display (Дисплей АБРИС) 
localize_table["es"]["ABRIS Pushbutton 1"]		    				="Botón ABRIS 1"
localize_table["es"]["ABRIS Pushbutton 2"]		    				="Botón ABRIS 2"
localize_table["es"]["ABRIS Pushbutton 3"]		    				="Botón ABRIS 3"
localize_table["es"]["ABRIS Pushbutton 4"]		    				="Botón ABRIS 4"
localize_table["es"]["ABRIS Pushbutton 5"]		    				="Botón ABRIS 5"
localize_table["es"]["ABRIS Cursor сontrol (rot/push)"]		    	="Control del cursor del ABRIS (girar/pulsar)"
localize_table["es"]["ABRIS Brightness"]		    				="Intensidad del ABRIS"
localize_table["es"]["ABRIS Power"]		    						="Alimentación del ABRIS"

-- HUD (ИЛС)
localize_table["es"]["HUD Brightness"]		    					="Intensidad del HUD"
localize_table["es"]["HUD Modes Reticle/Night/Day"]		    		="Modos del HUD Retícula/Noche/Día"
localize_table["es"]["HUD Test"]		    						="Prueba del HUD"
localize_table["es"]["HUD Filter"]		    						="Filtro del HUD"

-- PVI NAV Panel (ПВИ - Пульт Ввода и Индикации)
localize_table["es"]["NAV '0' Btn"]		    						="Botón PVI 0"
localize_table["es"]["NAV '1' Btn"]		    						="Botón PVI 1"
localize_table["es"]["NAV '2' Btn"]		    						="Botón PVI 2"
localize_table["es"]["NAV '3' Btn"]		    						="Botón PVI 3"
localize_table["es"]["NAV '4' Btn"]		    						="Botón PVI 4"
localize_table["es"]["NAV '5' Btn"]		    						="Botón PVI 5"
localize_table["es"]["NAV '6' Btn"]		    						="Botón PVI 6"
localize_table["es"]["NAV '7' Btn"]		    						="Botón PVI 7"
localize_table["es"]["NAV '8' Btn"]		    						="Botón PVI 8"
localize_table["es"]["NAV '9' Btn"]		    						="Botón PVI 9"
localize_table["es"]["NAV Waypoints"]		    					="PVI Modo Punto de ruta (WPT)"
localize_table["es"]["NAV Inflight INU Realignment"]		    	="PVI Realineamiento en vuelo de la INU"
localize_table["es"]["NAV Fixpoints"]		    					="PVI Modo Punto fijo"
localize_table["es"]["NAV Precise INU Alignment"]		    		="PVI Alineamiento preciso de la INU"
localize_table["es"]["NAV Airfields"]		    					="PVI Modo Aeropuerto"
localize_table["es"]["NAV Normal INU Alignment"]		    		="PVI Alineamiento normal de la INU"
localize_table["es"]["NAV Targets"]		    						="PVI Modo Objetivos"
localize_table["es"]["NAV Enter"]		    						="PVI Intro"
localize_table["es"]["NAV Cancel"]		    						="PVI Cancelar"
localize_table["es"]["NAV Initial Nav Pos"]		    				="PVI Posición de navegación inicial"
localize_table["es"]["NAV Self coordinates"]		    			="PVI Coordenadas propias"
localize_table["es"]["NAV Course:Course Deviation/Time/Range to WPT"] ="PVI Curso: Desviación/Tiempo de vuelo/Distancia"
localize_table["es"]["NAV Wind Heading/Speed"]		    			="PVI Dirección / Intensidad del viento"
localize_table["es"]["NAV True Heading/Time/Range to final WPT"]	="PVI Rumbo verdadero / Tiempo / Distancia al punto de guiado final"
localize_table["es"]["NAV Bearing/Range to target"]		    		="PVI Rumbo / Distancia al objetivo"
localize_table["es"]["NAV Master modes"]		    				="PVI Modo principal"
localize_table["es"]["NAV INU fixtaking method"]		    		="PVI Método de fijación de la INU"
localize_table["es"]["NAV Datalink power"]		    				="PVI Alimentación del Enlace de Datos"
localize_table["es"]["NAV Brightness"]		    					="PVI Intensidad"

-- UV-26 CMD Control Panel (УВ-26 - Устройство Выброса ЛТЦ)
localize_table["es"]["CMD Select Left/Both/Right board flares dispensers"]	="UV-26 Selección del dispensador de bengalas Izquierdo-Ambos-Derecho"
localize_table["es"]["CMD Amount flares counter/Programming"]	="UV-26 Contador de cantidad de bengalas / Programación"
localize_table["es"]["CMD Num of sequences"]		    			="UV-26 Número de secuencias de bengalas"
localize_table["es"]["CMD Num in sequence"]		    				="UV-26 Número de bengalas en la secuencia"
localize_table["es"]["CMD Dispense interval"]		    			="UV-26 Intervalo de lanzamiento"
localize_table["es"]["CMD Start dispense"]		    				="UV-26 Comenzar el lanzamiento"
localize_table["es"]["CMD Reset to default program"]		    	="UV-26 Reiniciar el programa por defecto"
localize_table["es"]["CMD Stop dispense"]		    				="UV-26 Detener el lanzamiento"

-- UV-26 related (BACK CONTROL PANEL)
localize_table["es"]["CMD Power"]		    						="UV-26 Alimentación"
localize_table["es"]["CMD BIT"]		    							="UV-26 Prueba integrada (BIT)"

-- Datalink Control Panel
localize_table["es"]["DLNK Send/Memory"]		    				="Enlace de datos - Enviar / Memoria"
localize_table["es"]["DLNK Ingress to target"]		    			="Enlace de datos - Ingreso al objetivo"
localize_table["es"]["DLNK Erase"]		    						="Enlace de datos - Borrar datos entrantes"
localize_table["es"]["N/A"]		    								="N/A"
localize_table["es"]["DLNK to ALL"]		    						="Enlace de datos - A todos"
localize_table["es"]["DLNK to Wingman 1"]		    				="Enlace de datos - Al Punto 1"
localize_table["es"]["DLNK to Wingman 2"]		    				="Enlace de datos - Al Punto 2"
localize_table["es"]["DLNK to Wingman 3"]		    				="Enlace de datos - Al Punto 3"
localize_table["es"]["DLNK to Wingman 4"]		    				="Enlace de datos - Al Punto 4"
localize_table["es"]["DLNK Target #1/Vehicle"]		    			="Enlace de datos - Objetivo 1 / Vehículo"
localize_table["es"]["DLNK Target #2/SAM"]		    				="Enlace de datos - Objetivo 2 / SAM"
localize_table["es"]["DLNK Target #3/Other Type"]		    		="Enlace de datos - Objetivo 3 / Otros"
localize_table["es"]["DLNK Ingress point"]		    				="Enlace de datos - Punto de ingreso"

-- Enlace de datos Mode Controls
localize_table["es"]["Datalink self ID"]		    				="Enlace de datos - Identificación (ID) propia"
localize_table["es"]["Datalink Master mode"]		    			="Enlace de datos - Modo principal"

-- PUI-800 Weapons Control Panel (ПУИ-800 Пульт Управления и Индикации)
localize_table["es"]["Master Arm"]		    						="Interruptor de armado"
localize_table["es"]["Not implemented"]		    					="No implementado"
localize_table["es"]["External stores jettison"]		    		="Lanzamiento de carga externa"
localize_table["es"]["Manual/Auto weapon system control switch"]	="Interruptor del sistema de control de armamento Manual/Auto"
localize_table["es"]["Cannon round selector switch HE/AP"]		    ="Interruptor selector de munición de cañón HE/AP"
localize_table["es"]["Weapon mode switch - Burst Length"]		   	="Interruptor de modo de armamento - longitud de la ráfaga"
localize_table["es"]["Cannon rate of fire setting"]		    		="Ajuste del régimen de disparo del cañón"
localize_table["es"]["Jettison arm mode - arm fuse/disarm fuse"]	="Modo de lanzamiento del armamento - armado/no armado"
localize_table["es"]["Expedite emergency ATGM launch"]				="Lanzamiento de emergencia de ATGM"

-- PUR Weapons Aux Panel (ПУР Пульт Управления Режимом)
localize_table["es"]["IT-23 Black-White indication switch"]			="IT-23 - Interruptor de indicación Negra-Blanca"
localize_table["es"]["IT-23 display brightness"]		    		="IT-23 - Intensidad"
localize_table["es"]["IT-23 display contrast"]		    			="IT-23 - Contraste"
localize_table["es"]["SHKVAL Optics adjustment"]		    		="Ajuste de la óptica del Shkval"
localize_table["es"]["Helmet device brightness"]					="Intensidad del dispositivo de casco"
localize_table["es"]["Laser code selector"]		    				="Selector de código del láser"
localize_table["es"]["HUD/TV declutter switch"]		    			="Interruptor de filtrado de datos del HUD/TV"

-- Auxiliary panel - Preflight Set and Check Panel (ППК - Пульт Подготовки и Контроля)
localize_table["es"]["ATGM Temperature selector"]		    		="Selector de temperatura de ATGM"
localize_table["es"]["Unguided rocket and gun pods ballistics data settings selector"] ="Selector de ajustes de datos balísticos de cohetes y góndolas de cañón"
localize_table["es"]["Systems BIT selector"]		    			="Selector de la prueba integrada (BIT) de sistemas"
localize_table["es"]["Control computers BIT switch"]		    	="Interruptor de la prueba integrada (BIT) de los ordenadores de control"
localize_table["es"]["INU Power switch"]		    				="Interruptor de alimentación de la INU"
localize_table["es"]["INU Heater switch"]		    				="Interruptor de calefacción de la INU"
localize_table["es"]["Self test system push-button"]		    	="Botón del sistema de autoprueba"
localize_table["es"]["Emergency INU alignment switch"]		    	="Interruptor de alineamiento de emergencia de la INU"
localize_table["es"]["Stabilisation and indication of hanger cable switch"] ="Interruptor de estabilización e indicación del cable de la eslinga"
localize_table["es"]["Video Tape Recorder switch"]		    		="Interruptor de la cinta grabadora de vídeo"

localize_table["es"]["Power plant, hydraulics, EKRAN self-test systems switch"]	="Interruptor de los sistemas de planta de potencia, hidráulicos y autoprueba EKRAN"

-- PPR - Autopilot Control Panel (ППР - Пульт Пилотажных Режимов)
localize_table["es"]["Autopilot Bank hold"]		    				="Piloto automático - Mantenimiento de alabeo"
localize_table["es"]["Autopilot Heading hold"]		    			="Piloto automático - Mantenimiento de rumbo"
localize_table["es"]["Autopilot Pitch hold"]		    			="Piloto automático - Mantenimiento de cabeceo"
localize_table["es"]["Autopilot Altitude hold"]		    			="Piloto automático - Mantenimiento de altitud"
localize_table["es"]["Autopilot Director control"]					="Piloto automático - Control director"
localize_table["es"]["Autopilot BARO/RALT altitude hold mode"]		="Piloto automático - Modo de mantenimiento de altitud BARO/RALT"
localize_table["es"]["Autopilot Desired heading - Desired track"]	="Piloto automático - Rumbo deseado - ruta deseada"

-- CLOCK (часы)
localize_table["es"]["Mech clock left lever"]		    			="Reloj mecánico. Botón izquierdo"
localize_table["es"]["Mech clock right lever"]		    			="Reloj mecánico. Botón derecho"

-- OVERHEAD PANEL
localize_table["es"]["Brightness"]		    						="Intensidad de iluminación"
localize_table["es"]["Rotor de-icing system switch"]		    	="Interruptor del sistema de deshileo del rotor"
localize_table["es"]["Engines de-icing / dust-protection systems switch"]	="Interruptor de los sistemas de deshileo / protección de polvo de los motores"
localize_table["es"]["Navigation Lights 10\% / 30\% / 100\% / Off"]	="Luces de navegación 10%/30%/100%/Apagado"
localize_table["es"]["Windshield wiper switch"]		    			="Interruptor del limpiaparabrisas"
localize_table["es"]["Windshield washer fluid switch"]		    	="Interruptor de fluido del limpiador del parabrisas"
localize_table["es"]["Pitot static port and AoA sensors heat switch"] ="Interruptor de calefacción de la toma estática de pitot y de los sensores de AoA"
localize_table["es"]["Pitot ram air and clock heat switch"]		    ="Interruptor de calefacción de aire de impacto de pitot y de reloj"

localize_table["es"]["Pitot heat system test"] = "Prueba del sistema de calefacción de pitot"
-- HSI (ПНП)
localize_table["es"]["HSI Commanded course rotary"]		    		="HSI - Botón de curso"
localize_table["es"]["HSI Commanded heading rotary"]		    	="HSI - Botón de rumbo"
localize_table["es"]["HSI test"]		    						="Prueba del HSI"
localize_table["es"]["HSI Desired track angle - Desired heading, Auto - Manual"]		    ="HSI - Ángulo de ruta deseada - Rumbo deseado, Auto - Manual"

-- ADI (ИКП)
localize_table["es"]["ADI Zero pitch trim"]		    				="ADI - Ajuste a cero del cabeceo"
localize_table["es"]["ADI Test"]		    						="Prueba del ADI"

-- SAI (АГР-81)
localize_table["es"]["Standby Attitude Indicator Cage/control test handle"]		="Botón de calaje/control/prueba del Indicador de Actitud de reserva SAI"
localize_table["es"]["Standby Attitude Indicator power switch"]			="Interruptor de alimentación del Indicador de Actitud de Reserva SAI"

-- RADIOALTIMETER
localize_table["es"]["Dangerous RALT set rotary"]		    		="Radioaltímetro - botón de ajuste de RALT de peligro"
localize_table["es"]["Radar altimeter test"]		    			="Prueba del radioaltímetro"

-- BARO ALTIMETER
localize_table["es"]["Baro pressure QFE knob"]		    			="Botón de ajuste de la presión QFE en el altímetro barométrico"

-- PVR (ПВР - Пульт Выбора Режимов К-041)
localize_table["es"]["Training mode"]		    					="Modo de entrenamiento"
localize_table["es"]["Automatic turn on target mode"]		    	="Modo de viraje automático hacia el objetivo"
localize_table["es"]["Airborne Target"]		    					="Objetivo aéreo"
localize_table["es"]["Forward hemisphere (head-on) air target aspect"] ="Aspecto de objetivo aéreo frontal"
localize_table["es"]["Ground moving target"]		    			="Objetivo móvil de tierra"
localize_table["es"]["Weapon system mode selector"]		    		="Selector de modo del sistema de armas"
localize_table["es"]["Targeting mode reset"]		    			="Reinicio del modo de designación de objetivos"
localize_table["es"]["Automatic Tracking / gun sight"]		    	="Seguimiento automático / Mira del cañón"
localize_table["es"]["K-041 Targeting-navigation system power switch"]		   	="K-041 - Interruptor de alimentación del sistema de designación de objetivos y navegación"
localize_table["es"]["Laser standby ON/OFF switch"]		    		="Láser - Interruptor standby On/Off"
localize_table["es"]["Helmet-mounted sight system power switch"]	="Interruptor de alimentación del sistema de visión montado en el casco"
localize_table["es"]["Shkval scan rate"]		    				="Régimen de escaneo del Shkval"


-- Laser Warning System (Л-140)
localize_table["es"]["LWS Reset button"]		    				="Botón de reinico del LWS"
localize_table["es"]["LWS Power switch"]		    				="Interruptor del LWS"
localize_table["es"]["LWS self-test button"]		    			="Botón de autoprueba del LWS"

-- Engines Start Control Panel
localize_table["es"]["Start-up selected engine button"]		    	="Botón de puesta en marcha del motor seleccionado"
localize_table["es"]["Interrupt start-up button"]		    		="Botón de Interrupción de la puesta en marcha"
localize_table["es"]["Stop APU button"]		    					="Botón de parada del APU"
localize_table["es"]["Engine selector"]		    					="Selector de motor"
localize_table["es"]["Engine work mod selector"]		    		="Selector de modo de funcionamiento del motor"
localize_table["es"]["Left engine cut-off valve"]		    		="Válvula de corte del motor izquierdo"
localize_table["es"]["Right engine cut-off valve"]		    		="Válvula de corte del motor derecho"
localize_table["es"]["Rotor brake"]		    						="Freno del rotor"
localize_table["es"]["Engine Startup/Crank/False Start selector"]	="Selector de puesta en marcha de motor: Puesta en marcha/Ventilación/Arranque falso"

localize_table["es"]["Running engines exhaust gas temperature indicator test button"]	="Botón de prueba del indicador de Temperatura de Gases de Escape con motores en marcha"
localize_table["es"]["Stopped engines exhaust gas temperature indicator test button"]	="Botón de prueba del indicador de Temperatura de Gases de Escape con motores parados"

--Radio switcher
localize_table["es"]["SPU-9 Radio communicator selector"]		    ="Selector de comunicación por radio SPU-9"

-- Fire Extinguishers Control Panel
localize_table["es"]["Left engine extinguisher"]		    		="Extintor de fuego del motor izquierdo"
localize_table["es"]["APU extinguisher"]		    				="Extintor de fuego del APU"
localize_table["es"]["Right engine extinguisher"]		    		="Extintor de fuego del motor derecho"
localize_table["es"]["Ventilator extinguisher"]		    			="Extintor de fuego del ventilador"
localize_table["es"]["Fire extinguisher Work – Off – Test switch"]	="Interruptor de Trabajo - Apagado - Prueba del extintor de fuego"
localize_table["es"]["Fire signaling"]		    					="Aviso de incendio"
localize_table["es"]["Fire extinguisher First (Auto) / Second (Manual) selector"]	="Extintor de fuego - Selector en Primero (Auto) / Segundo (Manual)"
localize_table["es"]["1st fire warning sensors group BIT"]			="Prueba del 1er grupo de detectores de incendio"
localize_table["es"]["2nd fire warning sensors group BIT"]			="Prueba del 2º grupo de detectores de incendio"
localize_table["es"]["3rd fire warning sensors group BIT"]			="Prueba del 3er grupo de detectores de incendio"

-- Misc. systems
localize_table["es"]["Reducing gear box oil pressure indication selector"] ="Selector de indicación de presión de aceite de la caja reductora"
localize_table["es"]["Sling load Auto/Manual"] 						="Eslinga de carga Auto/Manual"

-- Lighting
localize_table["es"]["Lighting cockpit interior lamp switch"]		= "Interruptor de la luz de iluminación interior de cabina"
localize_table["es"]["Lighting cockpit panel switch"]		    	= "Interruptor de iluminación de paneles de cabina"
localize_table["es"]["Lighting night vision cockpit switch"]		= "Interruptor de iluminación de la cabina para visión nocturna"
localize_table["es"]["Lighting ADI and SAI switch"]					= "Interruptor de iluminación del HSI y del ADI"
localize_table["es"]["Lighting night vision cockpit brightness knob"]	= "Botón de intensidad de iluminación de la cabina para visión nocturna"
localize_table["es"]["Lighting cockpit panel brightness knob"]		= "Botón de intensidad de iluminación de paneles de cabina"
localize_table["es"]["Lighting HSI and ADI brightness knob"]		= "Botón de intensidad de iluminación de HSI y ADI"
localize_table["es"]["Lighting auxiliary panel switch"]				= "Interruptor de iluminación del panel auxiliar"
localize_table["es"]["Lighting auxiliary panel brightness knob"]		= "Interruptor de intensidad de iluminación del panel auxiliar"

-- Outside illumination
localize_table["es"]["Light landing-search. On/Retraction/Off"]		="Luz de aterrizaje y búsqueda Encendido/Retracción/Apagado"
localize_table["es"]["Lights landing-search change. Main/Reserved"]	="Luces de aterrizaje y búsqueda - Cambiar Principal/Reserva"
localize_table["es"]["Tip Lights"]		    						="Luces de punta de rotor"
localize_table["es"]["Anticollision Light"]		    				="Luz anticolisión"
localize_table["es"]["Navigation Lights 10\%/30\%/100\%/Off"]		="Luces de navegación 10%/30%/100%/Apagado"
localize_table["es"]["Formation Lights"]		    				="Luces de formación"

--ARK-22
localize_table["es"]["ADF Inner-Auto-Outer NDB switch"]		    	="ADF - Selector de NDB Interior-Auto-Exterior"
localize_table["es"]["ADF channel switch"]		    				="ADF - Selector de canal"
localize_table["es"]["COMPASS-ANTENNA modes"]		    			="ADF - Modos Compás-Antena"
localize_table["es"]["TLF-TLG modes"]		    					="ADF - Modos TLF-TLG"
localize_table["es"]["ADF Volume"]		    						="ADF - Volumen de audio"
localize_table["es"]["ADF Test"]		    						="ADF - Prueba"

-- Betty ("ALMAZ" system)
localize_table["es"]["Voice message system messages off"]			="Apagar los mensajes del sistema de mensajes por voz"
localize_table["es"]["Voice message system emergency on"]			="Conectar en modo emergencia el sistema de mensajes por voz"
localize_table["es"]["Voice message system messages repeat"]		="Repetir los mensajes del sistema de mensajes por voz"
localize_table["es"]["Voice message system check"]		    		="Prueba del sistema de mensajes por voz"

--R-800 Radio
localize_table["es"]["R-800 (VHF-2) BIT button"]		    		="R-800 (VHF-2) Botón de prueba"
localize_table["es"]["R-800 (VHF-2) AM-FM toggle switch"]		    ="R-800 (VHF-2)Interruptor AM-FM"
localize_table["es"]["R-800 (VHF-2) Emergency receiver"]		    ="R-800 (VHF-2) Receptor de emergencia"
localize_table["es"]["R-800 (VHF-2) ADF switch"]		    		="R-800 (VHF-2) Interruptor ADF"
localize_table["es"]["R-800 (VHF-2) Data transfer rate switch"]		="R-800 (VHF-2) Interruptor de régimen de transferencia de datos"
localize_table["es"]["R-800 (VHF-2) Squelch"]		    			="R-800 (VHF-2) Filtro anti-ruido (Squelch)"
localize_table["es"]["R-800 (VHF-2) 1st rotary"]		    		="R-800 (VHF-2) Selección de la frecuencia - Rueda 1"
localize_table["es"]["R-800 (VHF-2) 2nd rotary"]		    		="R-800 (VHF-2) Selección de la frecuencia - Rueda 2"
localize_table["es"]["R-800 (VHF-2) 3rd rotary"]		    		="R-800 (VHF-2) Selección de la frecuencia - Rueda 3"
localize_table["es"]["R-800 (VHF-2) 4th rotary"]		    		="R-800 (VHF-2) Selección de la frecuencia - Rueda 4"

--R-828 Radio
localize_table["es"]["R-828 (VHF-1) Radio channel selector"]		="R-828 (VHF-1) Selector de canal de radio"
localize_table["es"]["R-828 (VHF-1) Radio Volume"]		    		="R-828 (VHF-1) Volumen de la radio"
localize_table["es"]["R-828 (VHF-1) Tuner button"]		    		="R-828 (VHF-1) Botón de sintonización"
localize_table["es"]["R-828 (VHF-1) Squelch"]		    			="R-828 Filtro anti-ruido (Squelch)"

--Signal Flares
localize_table["es"]["Signal flare system power"]		    		="Alimentación del sistema de bengalas de señalización"
localize_table["es"]["Signal flare red"]		    				="Bengala de señalización - Roja"
localize_table["es"]["Signal flare green"]		    				="Bengala de señalización - Verde"
localize_table["es"]["Signal flare white"]		    				="Bengala de señalización - Blanca"
localize_table["es"]["Signal flare yellow"]		    				="Bengala de señalización - Amarilla"

-- PShK_7 (Latitude Entry Panel) Пульт широтной коррекции
localize_table["es"]["Latitude selection rotaty"]		    		="Dial de selección de la latitud"
localize_table["es"]["North/South latitude selection"]		    	="Selección de latitud Norte/Sur"

-- ZMS_3 (Magnetic Variation Entry Panel) Задатчик магнитного склонения
localize_table["es"]["Magnetic variation selection rotaty"]		    ="Dial de selección de la variación magnética"

localize_table["fr"] = {}

-- CPT MECH
localize_table["fr"]["Gear lever"]		    						="Palette du train"
localize_table["fr"]["Main/Common hydraulics for emergency gear"]	="Sélecteur de l'hydraulique de secours du train"
localize_table["fr"]["Accelerometer reset"]		    				="Réinitialisation du mouchard de l'accéléromètre"

-- SYSTEM CONTROLLER
localize_table["fr"]["Master caution push-light"]		    		="Voyant-poussoir d'alerte principale"
localize_table["fr"]["Lamps test"]		    						="Test des voyants d'alertes"
localize_table["fr"]["Rotor RPM warning push-light"]		    	="Voyant d'alerte tours rotor"
localize_table["fr"]["MWS operation mode (not functional)"]			="Mode du système d'alerte missile (non fonctionel)"

--laser ranger ( front panel)
localize_table["fr"]["Laser rangefinder / designator - mode switch"]	="Sélecteur de mode Laser Télémètre/Désignateur"
localize_table["fr"]["Laser designator reset"]		    			="Réinitialisation du désignateur Laser"

-- Right Side Panel (Правый Боковой Пульт) 
-- ELECTRICS POWER
localize_table["fr"]["DC ground power"]		    					="Groupe de parc - courant continu"
localize_table["fr"]["Battery 2"]		    						="Batterie 2"
localize_table["fr"]["Battery 1"]		    						="Batterie 1"
localize_table["fr"]["AC ground power"]		    					="Groupe de parc - courant alternatif"
localize_table["fr"]["AC left generator"]		    				="Alternateur gauche"
localize_table["fr"]["AC right generator"]		    				="Alternateur droit"
localize_table["fr"]["DC/AC inverter"]		    					="Convertisseur continu/alternatif"

-- FUEL PUMPS POWER AND VALVES
localize_table["fr"]["Forward fuel tank pumps"]		    			="Pompe de gavage - Réservoir avant"
localize_table["fr"]["Rear fuel tank pumps"]		    			="Pompe de gavage - Réservoir arrière"
localize_table["fr"]["Inner external fuel tanks pumps"]		    	="Pompe de gavage - Réservoirs pendulaires internes"
localize_table["fr"]["Outer external fuel tanks pumps"]		    	="Pompe de gavage - Réservoirs pendulaires externes"
localize_table["fr"]["Fuelmeter power"]		    					="Indicateur de carburant Marche/Arrêt"
localize_table["fr"]["Left engine fuel shutoff valve"]		    	="Vanne d'alimentation moteur gauche"
localize_table["fr"]["Right engine fuel shutoff valve"]		    	="Vanne d'alimentation moteur droit"
localize_table["fr"]["APU fuel shutoff valve"]		    			="Vanne d'alimentation APU"
localize_table["fr"]["Fuel crossfeed valve"]		    			="Inter-alimentation"
localize_table["fr"]["Fuel quantity indicator self test button"]	="Test de l'indicateur de carburant"

-- COMMS POWER
localize_table["fr"]["Intercom"]		    						="Intercom (SPU-9)"
localize_table["fr"]["VHF-1 (R828) power switch"]		    		="Radio R-828 VHF-1 Marche/Arrêt"
localize_table["fr"]["VHF-2 (R-800) power switch"]		    		="Radio R-800 VHF-2 Marche/Arrêt"
localize_table["fr"]["Radio equipment datalink TLK power switch"]	="Radio pour datalink TLK Marche/Arrêt"
localize_table["fr"]["Radio equipment datalink UHF TLK power switch"]	="Radio pour datalink UHF TLK Marche/Arrêt"
localize_table["fr"]["Radio equipment datalink SA-TLF power switch"]	="Radio pour datalink SA-TLF Marche/Arrêt"

-- WEAPON SYS
localize_table["fr"]["Weapons сontrol system"]		    			="Système de contrôle de l'armement"

-- EJECT SYSTEM
localize_table["fr"]["Ejecting system power 1"]		    			="Alimentation 1 système d'éjection"
localize_table["fr"]["Ejecting system power 2"]		    			="Alimentation 2 système d'éjection"
localize_table["fr"]["Ejecting system power 3"]		    			="Alimentation 3 système d'éjection"
localize_table["fr"]["Ejecting system power"]		    			="Alimentation du système d'éjection"
localize_table["fr"]["Ejecting system circuit test"]		    	="Test des circuits du système d'éjection"
localize_table["fr"]["Ejecting system circuit selector"]		   	="Sélecteur du circuit du système d'éjection"

-- HYDRAULICS
localize_table["fr"]["Main hydraulics"]		    					="Circuit hydraulique principal"

-- IFF
localize_table["fr"]["IFF power"]		    						="IFF Marche/Arrêt"

-- ENGINES
localize_table["fr"]["EEG Left engine Electronic Engine Governor"]	="Régulateur électronique moteur gauche"
localize_table["fr"]["EEG Right engine Electronic Engine Governor"]	="Régulateur électronique moteur droit"
localize_table["fr"]["EEG power turbine channel 1 test – Operate – EEG power turbine channel 2 test, three-switch contactor"]	="EEG turbine moteur 1 Test-Marche / EEG turbine moteur 2 Test-Marche"
localize_table["fr"]["EEG gas generator test – Operate switch"]		="EEG turbine de puissance Test - Marche"
localize_table["fr"]["Left EGT control threshold governor button"]	="Contrôle de la limite d'EGT moteur gauche"
localize_table["fr"]["Right EGT control threshold governor button"]	="Contrôle de la limite d'EGT moteur droit"
localize_table["fr"]["Engines vibrations monitoring system control button"]	="Système de contrôle des vibrations moteurs"

-- NAV SYSTEM
localize_table["fr"]["Navigation system power"]						="Système de navigation Marche/Arrêt"
localize_table["fr"]["Gyro/Mag/Manual heading"]		    			="Cap de suivi Gyro/Magnétique/Manuel"

-- SHKVAL windscreen wiper
localize_table["fr"]["SHKVAL windscreen wiper"]		    			="Essuie glace du Shkval"


-- ABRIS Display (Дисплей АБРИС) 
localize_table["fr"]["ABRIS Pushbutton 1"]		    				="Touche ABRIS 1"
localize_table["fr"]["ABRIS Pushbutton 2"]		    				="Touche ABRIS 2"
localize_table["fr"]["ABRIS Pushbutton 3"]		    				="Touche ABRIS 3"
localize_table["fr"]["ABRIS Pushbutton 4"]		    				="Touche ABRIS 4"
localize_table["fr"]["ABRIS Pushbutton 5"]		    				="Touche ABRIS 5"
localize_table["fr"]["ABRIS Cursor сontrol (rot/push)"]		    	="Commande du curseur ABRIS (tourner/pousser)"
localize_table["fr"]["ABRIS Brightness"]		    				="Luminosité ABRIS"
localize_table["fr"]["ABRIS Power"]		    						="Alimentation ABRIS"

-- HUD (ИЛС)
localize_table["fr"]["HUD Brightness"]		    					="Luminosité VTH"
localize_table["fr"]["HUD Modes Reticle/Night/Day"]		    		="Mode VTH Réticule/Nuit/Jour"
localize_table["fr"]["HUD Test"]		    						="Test VTH"
localize_table["fr"]["HUD Filter"]		    						="Filtre VTH"

-- PVI NAV Panel (ПВИ - Пульт Ввода и Индикации)
localize_table["fr"]["NAV '0' Btn"]		    						="Bouton PVI 0"
localize_table["fr"]["NAV '1' Btn"]		    						="Bouton PVI 1"
localize_table["fr"]["NAV '2' Btn"]		    						="Bouton PVI 2"
localize_table["fr"]["NAV '3' Btn"]		    						="Bouton PVI 3"
localize_table["fr"]["NAV '4' Btn"]		    						="Bouton PVI 4"
localize_table["fr"]["NAV '5' Btn"]		    						="Bouton PVI 5"
localize_table["fr"]["NAV '6' Btn"]		    						="Bouton PVI 6"
localize_table["fr"]["NAV '7' Btn"]		    						="Bouton PVI 7"
localize_table["fr"]["NAV '8' Btn"]		    						="Bouton PVI 8"
localize_table["fr"]["NAV '9' Btn"]		    						="Bouton PVI 9"
localize_table["fr"]["NAV Waypoints"]		    					="PVI Mode waypoint (WPT)"
localize_table["fr"]["NAV Inflight INU Realignment"]		    	="PVI Réalignement en vol"
localize_table["fr"]["NAV Fixpoints"]		    					="PVI point de recalage"
localize_table["fr"]["NAV Precise INU Alignment"]		    		="PVI Alignement de précision"
localize_table["fr"]["NAV Airfields"]		    					="PVI Mode aérodrome"
localize_table["fr"]["NAV Normal INU Alignment"]		    		="PVI alignement normal"
localize_table["fr"]["NAV Targets"]		    						="PVI Mode point-cible (TP)"
localize_table["fr"]["NAV Enter"]		    						="PVI Entrée"
localize_table["fr"]["NAV Cancel"]		    						="PVI Annuler (RESET)"
localize_table["fr"]["NAV Initial Nav Pos"]		    				="PVI Coordonnées initiales (INIT PNT)"
localize_table["fr"]["NAV Self coordinates"]		    			="PVI Coordonées actuelles (SELF COOR)"
localize_table["fr"]["NAV Course:Course Deviation/Time/Range to WPT"] ="PVI Route: Déviation/Temps de vol/Distance"
localize_table["fr"]["NAV Wind Heading/Speed"]		    			="PVI Direction/vitesse du vent"
localize_table["fr"]["NAV True Heading/Time/Range to final WPT"]	="PVI Cap vrai/Temps de vol/Distance"
localize_table["fr"]["NAV Bearing/Range to target"]		    		="PVI Relèvement/Distance vers cible"
localize_table["fr"]["NAV Master modes"]		    				="PVI Mode principal"
localize_table["fr"]["NAV INU fixtaking method"]		    		="PVI mode de recalage"
localize_table["fr"]["NAV Datalink power"]		    				="PVI Datalink Marche/Arrêt"
localize_table["fr"]["NAV Brightness"]		    					="PVI Luminosité"

-- UV-26 CMD Control Panel (УВ-26 - Устройство Выброса ЛТЦ)
localize_table["fr"]["CMD Select Left/Both/Right board flares dispensers"]	="UV-26 Sélection du lanceur, Gauche/Tous/Droite"
localize_table["fr"]["CMD Amount flares counter/Programming"]	="UV-26 Quantité de leurres/Programmation"
localize_table["fr"]["CMD Num of sequences"]		    			="UV-26 Nombre de séquences"
localize_table["fr"]["CMD Num in sequence"]		    				="UV-26 Quantité de leurres dans la séquence"
localize_table["fr"]["CMD Dispense interval"]		    			="UV-26 Intervalle de largage"
localize_table["fr"]["CMD Start dispense"]		    				="UV-26 START (Début du leurrage)"
localize_table["fr"]["CMD Reset to default program"]		    	="UV-26 Reset (Programme standard)"
localize_table["fr"]["CMD Stop dispense"]		    				="UV-26 STOP (Arrêt du leurrage)"

-- UV-26 related (BACK CONTROL PANEL)
localize_table["fr"]["CMD Power"]		    						="UV-26 Alimentation"
localize_table["fr"]["CMD BIT"]		    							="UV-26 Auto-test"

-- Datalink Control Panel
localize_table["fr"]["DLNK Send/Memory"]		    				="Datalink Envoi/Sauvegarde"
localize_table["fr"]["DLNK Ingress to target"]		    			="Datalink Insertion vers la cible (DL INGRESS)"
localize_table["fr"]["DLNK Erase"]		    						="Datalink Effacer"
localize_table["fr"]["N/A"]		    								="N/A"
localize_table["fr"]["DLNK to ALL"]		    						="Datalink à Tous"
localize_table["fr"]["DLNK to Wingman 1"]		    				="Datalink à l'équipier 1"
localize_table["fr"]["DLNK to Wingman 2"]		    				="Datalink à l'équipier 2"
localize_table["fr"]["DLNK to Wingman 3"]		    				="Datalink à l'équipier 3"
localize_table["fr"]["DLNK to Wingman 4"]		    				="Datalink à l'équipier 4"
localize_table["fr"]["DLNK Target #1/Vehicle"]		    			="Datalink Cible #1/Vehicule"
localize_table["fr"]["DLNK Target #2/SAM"]		    				="Datalink Cible #2/SAM"
localize_table["fr"]["DLNK Target #3/Other Type"]		    		="Datalink Cible #3/Autre"
localize_table["fr"]["DLNK Ingress point"]		    				="Datalink Point d'insertion"

-- Datalink Mode Controls
localize_table["fr"]["Datalink self ID"]		    				="Datalink n° d'identification"
localize_table["fr"]["Datalink Master mode"]		    			="Datalink mode principal"

-- PUI-800 Weapons Control Panel (ПУИ-800 Пульт Управления и Индикации)
localize_table["fr"]["Master Arm"]		    						="Sécurité armement (MASTER ARM)"
localize_table["fr"]["Not implemented"]		    					="N/A"
localize_table["fr"]["External stores jettison"]		    		="Largage d'urgence des emports"
localize_table["fr"]["Manual/Auto weapon system control switch"]	="Système de contrôle des armes Manuel/Auto "
localize_table["fr"]["Cannon round selector switch HE/AP"]		    ="Sélection des obus canons HE/API"
localize_table["fr"]["Weapon mode switch - Burst Length"]		   	="Type de salve Longue/Moyenne/Courte"
localize_table["fr"]["Cannon rate of fire setting"]		    		="Cadence de tir du canon"
localize_table["fr"]["Jettison arm mode - arm fuse/disarm fuse"]	="Sécurité armement pour le largage d'urgence"
localize_table["fr"]["Expedite emergency ATGM launch"]				="Tir de largage des ATGM"

-- PUR Weapons Aux Panel (ПУР Пульт Управления Режимом)
localize_table["fr"]["IT-23 Black-White indication switch"]			="IT-23 surimpression Noire/Blanche"
localize_table["fr"]["IT-23 display brightness"]		    		="IT-23 Luminosité"
localize_table["fr"]["IT-23 display contrast"]		    			="IT-23 Contraste"
localize_table["fr"]["SHKVAL Optics adjustment"]		    		="Ajustement des optiques du Shkval"
localize_table["fr"]["Helmet device brightness"]					="Luminosité du viseur de casque"
localize_table["fr"]["Laser code selector"]		    				="Sélection du code laser"
localize_table["fr"]["HUD/TV declutter switch"]		    			="Allègement de l'affichage VTH/TV"

-- Auxiliary panel - Preflight Set and Check Panel (ППК - Пульт Подготовки и Контроля)
localize_table["fr"]["ATGM Temperature selector"]		    		="Sélection de la température ATGM"
localize_table["fr"]["Unguided rocket and gun pods ballistics data settings selector"] ="Configuration de la ballistique des roquettes et pods canons"
localize_table["fr"]["Systems BIT selector"]		    			="Sélecteur de l'auto-test des systèmes"
localize_table["fr"]["Control computers BIT switch"]		    	="Auto-test des calculateurs de contrôle"
localize_table["fr"]["INU Power switch"]		    				="Centralle inertielle Marche/Arrêt"
localize_table["fr"]["INU Heater switch"]		    				="Réchauffe centralle inertielle"
localize_table["fr"]["Self test system push-button"]		    	="Bouton d'auto-test"
localize_table["fr"]["Emergency INU alignment switch"]		    	="Interrupteur d'alignement d'urgence de la centrale inertielle"
localize_table["fr"]["Stabilisation and indication of hanger cable switch"] ="Stabilisation et indication du cable de suspension"
localize_table["fr"]["Video Tape Recorder switch"]		    		="Interrupteur du système d'enregistrement vidéo"

localize_table["fr"]["Power plant, hydraulics, EKRAN self-test systems switch"]	="Alimentation électrique, hydraulique et EKRAN"

-- PPR - Autopilot Control Panel (ППР - Пульт Пилотажных Режимов)
localize_table["fr"]["Autopilot Bank hold"]		    				="Pilote Auto. - Roulis (Amortissement/maintien)"
localize_table["fr"]["Autopilot Heading hold"]		    			="Pilote Auto. - Lacet/Cap (Amortissement/maintien)"
localize_table["fr"]["Autopilot Pitch hold"]		    			="Pilote Auto. - Assiette (Amortissement/maintien)"
localize_table["fr"]["Autopilot Altitude hold"]		    			="Pilote Auto. - Maintien d'altitude"
localize_table["fr"]["Autopilot Director control"]					="Pilote Auto. - Directeur de vol"
localize_table["fr"]["Autopilot BARO/RALT altitude hold mode"]		="Pilote Auto. - type de maintien d'altitude (barométrique/radar)"
localize_table["fr"]["Autopilot Desired heading - Desired track"]	="Pilote Auto. - type de suivi de cap (cap/route)"

-- CLOCK (часы)
localize_table["fr"]["Mech clock left lever"]		    			="Horloge de bord, bouton gauche"
localize_table["fr"]["Mech clock right lever"]		    			="Horloge de bord, bouton droit"

-- OVERHEAD PANEL
localize_table["fr"]["Brightness"]		    						="Luminosité"
localize_table["fr"]["Rotor de-icing system switch"]		    	="Dégivrage rotor"
localize_table["fr"]["Engines de-icing / dust-protection systems switch"]	="Dégivrage / Protection anti-poussières des moteurs"
localize_table["fr"]["Navigation Lights 10\% / 30\% / 100\% / Off"]	="Feux de position 10\% / 30\% / 100\% / Eteints"
localize_table["fr"]["Windshield wiper switch"]		    			="Essuie-glace"
localize_table["fr"]["Windshield washer fluid switch"]		    	="Lave-glace"
localize_table["fr"]["Pitot static port and AoA sensors heat switch"] ="Réchauffe prise de pression statique et girouettes d'incidence/dérapage"
localize_table["fr"]["Pitot ram air and clock heat switch"]		    ="Réchauffe prise de pression totale et horloge de bord"

localize_table["fr"]["Pitot heat system test"] = "Test de la réchauffe du Pitot"
-- HSI (ПНП)
localize_table["fr"]["HSI Commanded course rotary"]		    		="Sélection de la route HSI"
localize_table["fr"]["HSI Commanded heading rotary"]		    	="Sélection du cap HSI"
localize_table["fr"]["HSI test"]		    						="Test HSI"
localize_table["fr"]["HSI Desired track angle - Desired heading, Auto - Manual"]		    ="Route - cap désiré du HSI, Manuel - Auto"

-- ADI (ИКП)
localize_table["fr"]["ADI Zero pitch trim"]		    				="Réglage du zéro de l'ADI"
localize_table["fr"]["ADI Test"]		    						="Test ADI"

-- SAI (АГР-81)
localize_table["fr"]["Standby Attitude Indicator Cage/control test handle"]		="Décager/Régler l'ADI de secours"
localize_table["fr"]["Standby Attitude Indicator power switch"]			="ADI de secours Marche/Arrêt"

-- RADIOALTIMETER
localize_table["fr"]["Dangerous RALT set rotary"]		    		="Réglage de l'alerte d'altitude radar"
localize_table["fr"]["Radar altimeter test"]		    			="Test du radar altimétrique"

-- BARO ALTIMETER
localize_table["fr"]["Baro pressure QFE knob"]		    			="Réglage de la pression QFE de l'altimètre barométrique"

-- PVR (ПВР - Пульт Выбора Режимов К-041)
localize_table["fr"]["Training mode"]		    					="Mode entraînement"
localize_table["fr"]["Automatic turn on target mode"]		    	="Virage automatique vers la cible"
localize_table["fr"]["Airborne Target"]		    					="Cible aérienne"
localize_table["fr"]["Forward hemisphere (head-on) air target aspect"] ="Cible aérienne de face"
localize_table["fr"]["Ground moving target"]		    			="Cible mobile au sol"
localize_table["fr"]["Weapon system mode selector"]		    		="Mode du système d'armes"
localize_table["fr"]["Targeting mode reset"]		    			="Réinitialisation du système d'armes"
localize_table["fr"]["Automatic Tracking / gun sight"]		    	="Suivi automatique de cible/Viseur canon"
localize_table["fr"]["K-041 Targeting-navigation system power switch"]		   	="Système de navigation et ciblage K-041 Marche/Arrêt"
localize_table["fr"]["Laser standby ON/OFF switch"]		    		="Laser en attente/Arrêt"
localize_table["fr"]["Helmet-mounted sight system power switch"]	="Viseur de casque/JVN - Marche/Arrêt"
localize_table["fr"]["Shkval scan rate"]		    				="Vitesse de balayage du Shkval"


-- Laser Warning System (Л-140)
localize_table["fr"]["LWS Reset button"]		    				="Réinitialisation LWS"
localize_table["fr"]["LWS Power switch"]		    				="LWS Marche/Arrêt"
localize_table["fr"]["LWS self-test button"]		    			="Auto-test LWS"

-- Engines Start Control Panel
localize_table["fr"]["Start-up selected engine button"]		    	="Démarrage du moteur sélectionné"
localize_table["fr"]["Interrupt start-up button"]		    		="Interruption de la séquence de démarrage"
localize_table["fr"]["Stop APU button"]		    					="Arrêt de l'APU"
localize_table["fr"]["Engine selector"]		    					="Sélecteur du moteur"
localize_table["fr"]["Engine work mod selector"]		    		="Mode de fonctionnement du moteur sélectionné"
localize_table["fr"]["Left engine cut-off valve"]		    		="Vanne de coupure, moteur gauche"
localize_table["fr"]["Right engine cut-off valve"]		    		="Vanne de coupure, moteur droit"
localize_table["fr"]["Rotor brake"]		    						="Frein rotor"
localize_table["fr"]["Engine Startup/Crank/False Start selector"]	="Sélecteur Démarrage/Ventilation/Démarrage décraboté"

localize_table["fr"]["Running engines exhaust gas temperature indicator test button"]	="Test de l'indicateur de température des gaz d'échappement, moteurs en fonctionnement"
localize_table["fr"]["Stopped engines exhaust gas temperature indicator test button"]	="Test de l'indicateur de température des gaz d'échappement, moteurs à l'arrêt"

--Radio switcher
localize_table["fr"]["SPU-9 Radio communicator selector"]		    ="Sélecteur de la radio SPU-9"

-- Fire Extinguishers Control Panel
localize_table["fr"]["Left engine extinguisher"]		    		="Extincteur moteur gauche"
localize_table["fr"]["APU extinguisher"]		    				="Extincteur APU"
localize_table["fr"]["Right engine extinguisher"]		    		="Extincteur moteur droit"
localize_table["fr"]["Ventilator extinguisher"]		    			="Extincteur refroidisseur d'huile"
localize_table["fr"]["Fire extinguisher Work – Off – Test switch"]	="Extincteur Marche - Arrêt - Test"
localize_table["fr"]["Fire signaling"]		    					="Indicateurs d'incendie"
localize_table["fr"]["Fire extinguisher First (Auto) / Second (Manual) selector"]	="Extincteur 1 (Auto) / 2 (Manuel)"
localize_table["fr"]["1st fire warning sensors group BIT"]			="Auto-test du 1er groupe de détecteurs incendie"
localize_table["fr"]["2nd fire warning sensors group BIT"]			="Auto-test du 2e groupe de détecteurs incendie"
localize_table["fr"]["3rd fire warning sensors group BIT"]			="Auto-test du 3e groupe de détecteurs incendie"

-- Misc. systems
localize_table["fr"]["Reducing gear box oil pressure indication selector"] ="Sélecteur d'indication de pression d'huile réducteur"
localize_table["fr"]["Sling load Auto/Manual"] 						="Charge suspendue Auto/Manuel"

-- Lighting
localize_table["fr"]["Lighting cockpit interior lamp switch"]		= "Lampe intérieure cockpit"
localize_table["fr"]["Lighting cockpit panel switch"]		    	= "Eclairage panneaux cockpit"
localize_table["fr"]["Lighting night vision cockpit switch"]		= "Eclairage compatible JVN"
localize_table["fr"]["Lighting ADI and SAI switch"]					= "Eclairage HSI et ADI"
localize_table["fr"]["Lighting night vision cockpit brightness knob"]	= "Luminosité éclairage compatible JVN"
localize_table["fr"]["Lighting cockpit panel brightness knob"]		= "Luminosité éclairage cockpit"
localize_table["fr"]["Lighting HSI and ADI brightness knob"]		= "Luminosité éclairage HSI et ADI"
localize_table["fr"]["Lighting auxiliary panel switch"]				= "Eclairage panneau auxiliaire"
localize_table["fr"]["Lighting auxiliary panel brightness knob"]		= "Luminosité éclairage panneau auxiliaire"

-- Outside illumination
localize_table["fr"]["Light landing-search. On/Retraction/Off"]		="Phare d'atterrissage et de recherche Marche/Rétraction/Arrêt"
localize_table["fr"]["Lights landing-search change. Main/Reserved"]	="Sélection du phare d'atterrissage Principal/Secours"
localize_table["fr"]["Tip Lights"]		    						="Feux en saumons de pales"
localize_table["fr"]["Anticollision Light"]		    				="Feu anti-collision"
localize_table["fr"]["Navigation Lights 10\%/30\%/100\%/Off"]		="Feux de position 10\%/30\%/100\%/Arrêt"
localize_table["fr"]["Formation Lights"]		    				="Feux de formation"

--ARK-22
localize_table["fr"]["ADF Inner-Auto-Outer NDB switch"]		    	="ADF - Sélection du NDB INNER-AUTO-OUTER"
localize_table["fr"]["ADF channel switch"]		    				="ADF - Sélection du canal"
localize_table["fr"]["COMPASS-ANTENNA modes"]		    			="ADF - Mode Compas-Antenne"
localize_table["fr"]["TLF-TLG modes"]		    					="ADF - Mode TLF-TLG"
localize_table["fr"]["ADF Volume"]		    						="ADF - Volume audio"
localize_table["fr"]["ADF Test"]		    						="ADF - Test"

-- Betty ("ALMAZ" system)
localize_table["fr"]["Voice message system messages off"]			="Couper le système vocal d'informations"
localize_table["fr"]["Voice message system emergency on"]			="Système vocal d'information en marche"
localize_table["fr"]["Voice message system messages repeat"]		="Répéter les messages du système vocal d'informations"
localize_table["fr"]["Voice message system check"]		    		="Test du système vocal d'informations"

--R-800 Radio
localize_table["fr"]["R-800 (VHF-2) BIT button"]		    		="R-800 (VHF-2) Autot-test"
localize_table["fr"]["R-800 (VHF-2) AM-FM toggle switch"]		    ="R-800 (VHF-2) Mode AM-FM"
localize_table["fr"]["R-800 (VHF-2) Emergency receiver"]		    ="R-800 (VHF-2) Récepteur d'urgence"
localize_table["fr"]["R-800 (VHF-2) ADF switch"]		    		="R-800 (VHF-2) ADF"
localize_table["fr"]["R-800 (VHF-2) Data transfer rate switch"]		="R-800 (VHF-2) Taux de transfert des données"
localize_table["fr"]["R-800 (VHF-2) Squelch"]		    			="R-800 (VHF-2) Filtre anti-bruit (Squelch)"
localize_table["fr"]["R-800 (VHF-2) 1st rotary"]		    		="R-800 (VHF-2) Sélection de la fréquence - Roue 1"
localize_table["fr"]["R-800 (VHF-2) 2nd rotary"]		    		="R-800 (VHF-2) Sélection de la fréquence - Roue 2"
localize_table["fr"]["R-800 (VHF-2) 3rd rotary"]		    		="R-800 (VHF-2) Sélection de la fréquence - Roue 3"
localize_table["fr"]["R-800 (VHF-2) 4th rotary"]		    		="R-800 (VHF-2) Sélection de la fréquence - Roue 4"

--R-828 Radio
localize_table["fr"]["R-828 (VHF-1) Radio channel selector"]		="R-828 (VHF-1) Sélection du canal"
localize_table["fr"]["R-828 (VHF-1) Radio Volume"]		    		="R-828 (VHF-1) Volume"
localize_table["fr"]["R-828 (VHF-1) Tuner button"]		    		="R-828 (VHF-1) Syntoniseur"
localize_table["fr"]["R-828 (VHF-1) Squelch"]		    			="R-828 Filtre anti-bruit (Squelch)"

--Signal Flares
localize_table["fr"]["Signal flare system power"]		    		="Système de fusées de signalisation Marche/Arrêt"
localize_table["fr"]["Signal flare red"]		    				="Fusée de signalisation - Rouge"
localize_table["fr"]["Signal flare green"]		    				="Fusée de signalisation - Vert"
localize_table["fr"]["Signal flare white"]		    				="Fusée de signalisation - Blanc"
localize_table["fr"]["Signal flare yellow"]		    				="Fusée de signalisation - Jaune"

-- PShK_7 (Latitude Entry Panel) Пульт широтной коррекции
localize_table["fr"]["Latitude selection rotaty"]		    		="Sélection de la latitude"
localize_table["fr"]["North/South latitude selection"]		    	="Sélection Nord/Sud"

-- ZMS_3 (Magnetic Variation Entry Panel) Задатчик магнитного склонения
localize_table["fr"]["Magnetic variation selection rotaty"]		    ="Réglage de la déclinaison magnétique"


localize_table["cn"] = {}

-- CPT MECH
localize_table["cn"]["Gear lever"]		    						="起落架控制杆"
localize_table["cn"]["Main/Common hydraulics for emergency gear"]	="应急起落架 主/通用 液压"
localize_table["cn"]["Accelerometer reset"]		    				="加速度计 复位"

-- SYSTEM CONTROLLER
localize_table["cn"]["Master caution push-light"]		    		="主警告 带灯按钮"
localize_table["cn"]["Lamps test"]		    						="告警灯 检测"
localize_table["cn"]["Rotor RPM warning push-light"]		        ="低旋翼转速带按钮注意灯"
localize_table["cn"]["MWS operation mode (not functional)"]			="导弹告警系统 操作模式 (无功能)"

--laser ranger (前面板)
localize_table["cn"]["Laser rangefinder / designator - mode switch"]	="激光 测距仪/指示器 - 模式开关"
localize_table["cn"]["Laser designator reset"]		    			="激光指示器 复位"

-- Right Side Panel (右侧面板) 
-- ELECTRICS POWER
localize_table["cn"]["DC ground power"]		    					="地面直流电源"
localize_table["cn"]["Battery 2"]		    						="电瓶 2"
localize_table["cn"]["Battery 1"]		    						="电瓶 1"
localize_table["cn"]["AC ground power"]		    					="地面交流电源"
localize_table["cn"]["AC left generator"]		    				="交流发电机 左"
localize_table["cn"]["AC right generator"]		    				="交流发电机 右"
localize_table["cn"]["DC/AC inverter"]		    					="直流/交流 逆变器"

-- FUEL PUMPS POWER AND VALVES
localize_table["cn"]["Forward fuel tank pumps"]		    			="前油箱燃油泵"
localize_table["cn"]["Rear fuel tank pumps"]		    			="后油箱燃油泵"
localize_table["cn"]["Inner external fuel tanks pumps"]		    	="油箱燃油泵 外挂内侧"
localize_table["cn"]["Outer external fuel tanks pumps"]		    	="油箱燃油泵 外挂外侧"
localize_table["cn"]["Fuelmeter power"]		    					="油量表 电源"
localize_table["cn"]["Left engine fuel shutoff valve"]		    	="发动机燃油切断阀 左侧"
localize_table["cn"]["Right engine fuel shutoff valve"]		    	="发动机燃油切断阀 右侧"
localize_table["cn"]["APU fuel shutoff valve"]		    			="APU 燃油切断阀"
localize_table["cn"]["Fuel crossfeed valve"]		    			="燃油交叉供应阀"
localize_table["cn"]["Fuel quantity indicator self test button"]	="油量表内置检测按钮"

-- COMMS POWER
localize_table["cn"]["Intercom"]		    						="内部通话装置"
localize_table["cn"]["VHF-1 (R828) power switch"]		    		="VHF-1 (R828) 电源开关"
localize_table["cn"]["VHF-2 (R-800) power switch"]		    		="VHF-2 (R-800) 电源开关"
localize_table["cn"]["Radio equipment datalink TLK power switch"]	="无线电设备数据链 TLK 电源开关"
localize_table["cn"]["Radio equipment datalink UHF TLK power switch"]	="无线电设备数据链 VHF-电报 电源开关"
localize_table["cn"]["Radio equipment datalink SA-TLF power switch"]	="无线电设备数据链 SA-电话 电源开关"

-- WEAPON SYS
localize_table["cn"]["Weapons сontrol system"]		    			="武器控制系统"

-- EJECT SYSTEM
localize_table["cn"]["Ejecting system power 1"]		    			="弹射系统电源 1"
localize_table["cn"]["Ejecting system power 2"]		    			="弹射系统电源 2"
localize_table["cn"]["Ejecting system power 3"]		    			="弹射系统电源 3"
localize_table["cn"]["Ejecting system power"]		    			="弹射系统电源"
localize_table["cn"]["Ejecting system circuit test"]		    	="弹射系统电路 检测"
localize_table["cn"]["Ejecting system circuit selector"]		   	="弹射系统电路 选择器"

-- HYDRAULICS
localize_table["cn"]["Main hydraulics"]		    					="主液压"

-- IFF
localize_table["cn"]["IFF power"]		    						="IFF 电源"

-- ENGINES
localize_table["cn"]["EEG Left engine Electronic Engine Governor"]	="EEG 左发动机电子调速器"
localize_table["cn"]["EEG Right engine Electronic Engine Governor"]	="EEG 右发动机电子调速器"
localize_table["cn"]["EEG power turbine channel 1 test – Operate – EEG power turbine channel 2 test, three-switch contactor"]	="EEG 动力涡轮通道1检测 - 操作 - EEG 动力涡轮通道2检测，三开关接触器"
localize_table["cn"]["EEG gas generator test – Operate switch"]		="EEG 气体发生器 检测-操作 开关"
localize_table["cn"]["Left EGT control threshold governor button"]	="左发动机排气温度阈值调节器按钮"
localize_table["cn"]["Right EGT control threshold governor button"]	="右发动机排气温度阈值调节器按钮"
localize_table["cn"]["Engines vibrations monitoring system control button"]	="发动机振动监视系统按钮"

-- NAV SYSTEM
localize_table["cn"]["Navigation system power"]						="导航系统电源"
localize_table["cn"]["Gyro/Mag/Manual heading"]		    			="陀螺/磁/手动 航向"

-- SHKVAL windscreen wiper
localize_table["cn"]["SHKVAL windscreen wiper"]		    			="Shkval 风挡雨刮"


-- ABRIS Display (Дисплей АБРИС) 
localize_table["cn"]["ABRIS Pushbutton 1"]		    				="ABRIS 按钮1"
localize_table["cn"]["ABRIS Pushbutton 2"]		    				="ABRIS 按钮2"
localize_table["cn"]["ABRIS Pushbutton 3"]		    				="ABRIS 按钮3"
localize_table["cn"]["ABRIS Pushbutton 4"]		    				="ABRIS 按钮4"
localize_table["cn"]["ABRIS Pushbutton 5"]		    				="ABRIS 按钮5"
localize_table["cn"]["ABRIS Cursor сontrol (rot/push)"]		    	="ABRIS 光标控制 (旋转/按下)"
localize_table["cn"]["ABRIS Brightness"]		    				="ABRIS 亮度"
localize_table["cn"]["ABRIS Power"]		    						="ABRIS 电源"

-- HUD (ИЛС)
localize_table["cn"]["HUD Brightness"]		    					="HUD 亮度"
localize_table["cn"]["HUD Modes Reticle/Night/Day"]		    		="HUD 模式 固定光环/夜/昼"
localize_table["cn"]["HUD Test"]		    						="HUD 检测"
localize_table["cn"]["HUD Filter"]		    						="HUD 滤镜"

-- PVI NAV Panel (ПВИ - Пульт Ввода и Индикации)
localize_table["cn"]["NAV '0' Btn"]		    						="PVI 按钮 '0'"
localize_table["cn"]["NAV '1' Btn"]		    						="PVI 按钮 '1'"
localize_table["cn"]["NAV '2' Btn"]		    						="PVI 按钮 '2'"
localize_table["cn"]["NAV '3' Btn"]		    						="PVI 按钮 '3'"
localize_table["cn"]["NAV '4' Btn"]		    						="PVI 按钮 '4'"
localize_table["cn"]["NAV '5' Btn"]		    						="PVI 按钮 '5'"
localize_table["cn"]["NAV '6' Btn"]		    						="PVI 按钮 '6'"
localize_table["cn"]["NAV '7' Btn"]		    						="PVI 按钮 '7'"
localize_table["cn"]["NAV '8' Btn"]		    						="PVI 按钮 '8'"
localize_table["cn"]["NAV '9' Btn"]		    						="PVI 按钮 '9'"
localize_table["cn"]["NAV Waypoints"]		    					="PVI 航路点"
localize_table["cn"]["NAV Inflight INU Realignment"]		    	="PVI 惯导飞行中重新校准"
localize_table["cn"]["NAV Fixpoints"]		    					="PVI 导航位置校准模式"
localize_table["cn"]["NAV Precise INU Alignment"]		    		="PVI 惯导精确校准"
localize_table["cn"]["NAV Airfields"]		    					="PVI 机场模式"
localize_table["cn"]["NAV Normal INU Alignment"]		    		="PVI 惯导普通校准"
localize_table["cn"]["NAV Targets"]		    						="PVI 目标模式"
localize_table["cn"]["NAV Enter"]		    						="PVI 输入"
localize_table["cn"]["NAV Cancel"]		    						="PVI 取消"
localize_table["cn"]["NAV Initial Nav Pos"]		    				="PVI 初始导航位置"
localize_table["cn"]["NAV Self coordinates"]		    			="PVI 自身坐标"
localize_table["cn"]["NAV Course:Course Deviation/Time/Range to WPT"] ="PVI 至航路点的航线-航向偏差/时间/距离"
localize_table["cn"]["NAV Wind Heading/Speed"]		    			="PVI 风向/风速"
localize_table["cn"]["NAV True Heading/Time/Range to final WPT"]	="PVI 至最终航路点的航向/时间/距离"
localize_table["cn"]["NAV Bearing/Range to target"]		    		="PVI 目标方位/距离"
localize_table["cn"]["NAV Master modes"]		    				="PVI 主模式"
localize_table["cn"]["NAV INU fixtaking method"]		    		="PVI INU定点位置修正"
localize_table["cn"]["NAV Datalink power"]		    				="PVI 数据链电源"
localize_table["cn"]["NAV Brightness"]		    					="PVI 亮度"

-- UV-26 CMD Control Panel (УВ-26 - Устройство Выброса ЛТЦ)
localize_table["cn"]["CMD Select Left/Both/Right board flares dispensers"]	="UV-26 选择 左/双/右侧 红外诱饵弹释放"
localize_table["cn"]["CMD Amount flares counter/Programming"]	="UV-26 红外诱饵弹剩余计数/编程"
localize_table["cn"]["CMD Num of sequences"]		    			="UV-26 红外诱饵弹序列次数"
localize_table["cn"]["CMD Num in sequence"]		    				="UV-26 单次序列中的红外诱饵弹数量"
localize_table["cn"]["CMD Dispense interval"]		    			="UV-26 投放间隔"
localize_table["cn"]["CMD Start dispense"]		    				="UV-26 开始投放"
localize_table["cn"]["CMD Reset to default program"]		    	="UV-26 复位当前程序"
localize_table["cn"]["CMD Stop dispense"]		    				="UV-26 停止投放"

-- UV-26 related (BACK CONTROL PANEL)
localize_table["cn"]["CMD Power"]		    						="UV-26 电源"
localize_table["cn"]["CMD BIT"]		    							="UV-26 内置检测"

-- Datalink Control Panel
localize_table["cn"]["DLNK Send/Memory"]		    				="PRTs 发送/保存"
localize_table["cn"]["DLNK Ingress to target"]		    			="PRTs 指向目标"
localize_table["cn"]["DLNK Erase"]		    						="PRTs 清除输入数据"
localize_table["cn"]["N/A"]		    								="不可用"
localize_table["cn"]["DLNK to ALL"]		    						="PRTs 至所有单位"
localize_table["cn"]["DLNK to Wingman 1"]		    				="PRTs 至1号僚机"
localize_table["cn"]["DLNK to Wingman 2"]		    				="PRTs 至2号僚机"
localize_table["cn"]["DLNK to Wingman 3"]		    				="PRTs 至3号僚机"
localize_table["cn"]["DLNK to Wingman 4"]		    				="PRTs 至4号僚机"
localize_table["cn"]["DLNK Target #1/Vehicle"]		    			="PRTs 目标1/车辆"
localize_table["cn"]["DLNK Target #2/SAM"]		    				="PRTs 目标2/地空导弹"
localize_table["cn"]["DLNK Target #3/Other Type"]		    		="PRTs 目标3/其他"
localize_table["cn"]["DLNK Ingress point"]		    				="PRTs 指向目标"

-- Datalink Mode Controls
localize_table["cn"]["Datalink self ID"]		    				="数据链 自身ID"
localize_table["cn"]["Datalink Master mode"]		    			="数据链 主模式"

-- PUI-800 Weapons Control Panel (ПУИ-800 Пульт Управления и Индикации)
localize_table["cn"]["Master Arm"]		    						="武器主开关"
localize_table["cn"]["Not implemented"]		    					="未实现"
localize_table["cn"]["External stores jettison"]		    		="外部挂载抛离"
localize_table["cn"]["Manual/Auto weapon system control switch"]	="手动/自动 武器系统控制开关"
localize_table["cn"]["Cannon round selector switch HE/AP"]		    ="机炮弹药选择开关 高爆弹/穿甲弹"
localize_table["cn"]["Weapon mode switch - Burst Length"]		   	="武器模式开关 - 连发数量"
localize_table["cn"]["Cannon rate of fire setting"]		    		="机炮射速设置"
localize_table["cn"]["Jettison arm mode - arm fuse/disarm fuse"]	="抛离模式 - 爆炸/不爆炸"
localize_table["cn"]["Expedite emergency ATGM launch"]				="快速应急反坦克导弹发射"

-- PUR Weapons Aux Panel (ПУР Пульт Управления Режимом)
localize_table["cn"]["IT-23 Black-White indication switch"]			="IT-23 黑白指示开关"
localize_table["cn"]["IT-23 display brightness"]		    		="IT-23 亮度"
localize_table["cn"]["IT-23 display contrast"]		    			="IT-23 对比度"
localize_table["cn"]["SHKVAL Optics adjustment"]		    		="Shkval 光学调整"
localize_table["cn"]["Helmet device brightness"]					="头盔设备亮度"
localize_table["cn"]["Laser code selector"]		    				="激光编码选择器"
localize_table["cn"]["HUD/TV declutter switch"]		    			="HUD/TV 调节开关"

-- Auxiliary panel - Preflight Set and Check Panel (ППК - Пульт Подготовки и Контроля)
localize_table["cn"]["ATGM Temperature selector"]		    		="反坦克导弹温度选择器"
localize_table["cn"]["Unguided rocket and gun pods ballistics data settings selector"] ="火箭弹和机炮吊舱弹道数据设置选择器"
localize_table["cn"]["Systems BIT selector"]		    			="系统内置检测开关"
localize_table["cn"]["Control computers BIT switch"]		    	="控制计算机内置检测开关"
localize_table["cn"]["INU Power switch"]		    				="INU 电源开关"
localize_table["cn"]["INU Heater switch"]		    				="INU 加热开关"
localize_table["cn"]["Self test system push-button"]		    	="内置检测系统按钮"
localize_table["cn"]["Emergency INU alignment switch"]		    	="应急INU校准开关"
localize_table["cn"]["Stabilisation and indication of hanger cable switch"] ="安定面和位置指示开关"
localize_table["cn"]["Video Tape Recorder switch"]		    		="录像带记录仪开关"

localize_table["cn"]["Power plant, hydraulics, EKRAN self-test systems switch"]	="动力系统、液压、EKRAN 内置检测系统开关"

-- PPR - Autopilot Control Panel (ППР - Пульт Пилотажных Режимов)
localize_table["cn"]["Autopilot Bank hold"]		    				="自动驾驶仪 坡度保持"
localize_table["cn"]["Autopilot Heading hold"]		    			="自动驾驶仪 航向保持"
localize_table["cn"]["Autopilot Pitch hold"]		    			="自动驾驶仪 俯仰保持"
localize_table["cn"]["Autopilot Altitude hold"]		    			="自动驾驶仪 高度保持"
localize_table["cn"]["Autopilot Director control"]					="自动驾驶仪 指引控制"
localize_table["cn"]["Autopilot BARO/RALT altitude hold mode"]		="自动驾驶仪 气压高度/雷达高度保持模式"
localize_table["cn"]["Autopilot Desired heading - Desired track"]	="自动驾驶仪 预设航向-预设航路"

-- CLOCK (часы)
localize_table["cn"]["Mech clock left lever"]		    			="机械时钟左杆"
localize_table["cn"]["Mech clock right lever"]		    			="机械时钟右杆"

-- OVERHEAD PANEL
localize_table["cn"]["Brightness"]		    						="亮度"
localize_table["cn"]["Rotor de-icing system switch"]		    	="旋翼防冰系统开关"
localize_table["cn"]["Engines de-icing / dust-protection systems switch"]	="发动机 防冰/防砂保护 系统开关"
localize_table["cn"]["Navigation Lights 10\% / 30\% / 100\% / Off"]	="航行灯 10\% / 30\% / 100\% / 关"
localize_table["cn"]["Windshield wiper switch"]		    			="风挡雨刮开关"
localize_table["cn"]["Windshield washer fluid switch"]		    	="风挡清洗开关"
localize_table["cn"]["Pitot static port and AoA sensors heat switch"] ="空速管静压孔与迎角传感器加热开关"
localize_table["cn"]["Pitot ram air and clock heat switch"]		    ="空速管冲压空气与时钟加热开关"

localize_table["cn"]["Pitot heat system test"] = "空速管加热系统 检测"
-- HSI (ПНП)
localize_table["cn"]["HSI Commanded course rotary"]		    		="HSI 指定航线旋钮"
localize_table["cn"]["HSI Commanded heading rotary"]		    	="HSI 指定航向旋钮"
localize_table["cn"]["HSI test"]		    						="HSI 检测"
localize_table["cn"]["HSI Desired track angle - Desired heading, Auto - Manual"]		    ="HSI 预设航路角度-预设航向，自动-手动"

-- ADI (ИКП)
localize_table["cn"]["ADI Zero pitch trim"]		    				="ADI 俯仰角零位调整旋钮"
localize_table["cn"]["ADI Test"]		    						="ADI 检测"

-- SAI (АГР-81)
localize_table["cn"]["Standby Attitude Indicator Cage/control test handle"]		="备用姿态仪 锁定/控制 检测手柄"
localize_table["cn"]["Standby Attitude Indicator power switch"]			="备用姿态仪 电源开关"

-- RADIOALTIMETER
localize_table["cn"]["Dangerous RALT set rotary"]		    		="危险无线电高度 设置旋钮"
localize_table["cn"]["Radar altimeter test"]		    			="雷达高度表 检测"

-- BARO ALTIMETER
localize_table["cn"]["Baro pressure QFE knob"]		    			="气压高度QFE旋钮"

-- PVR (ПВР - Пульт Выбора Режимов К-041)
localize_table["cn"]["Training mode"]		    					="训练模式"
localize_table["cn"]["Automatic turn on target mode"]		    	="自动转向目标模式"
localize_table["cn"]["Airborne Target"]		    					="空中目标"
localize_table["cn"]["Forward hemisphere (head-on) air target aspect"] ="前半球(迎面)空中目标态势"
localize_table["cn"]["Ground moving target"]		    			="地面移动目标"
localize_table["cn"]["Weapon system mode selector"]		    		="武器系统模式选择器"
localize_table["cn"]["Targeting mode reset"]		    			="瞄准模式 复位"
localize_table["cn"]["Automatic Tracking / gun sight"]		    	="自动跟踪/机炮视角"
localize_table["cn"]["K-041 Targeting-navigation system power switch"]		   	="K-041 瞄准-导航 系统电源开关"
localize_table["cn"]["Laser standby ON/OFF switch"]		    		="激光待命 开启/关闭 开关"
localize_table["cn"]["Helmet-mounted sight system power switch"]	="头盔瞄准具系统电源开关"
localize_table["cn"]["Shkval scan rate"]		    				="Shkval 扫描速率"


-- Laser Warning System (Л-140)
localize_table["cn"]["LWS Reset button"]		    				="激光告警系统 L-140 复位按钮"
localize_table["cn"]["LWS Power switch"]		    				="激光告警系统 L-140 电源开关"
localize_table["cn"]["LWS self-test button"]		    			="激光告警系统 L-140 内置检测按钮"

-- Engines Start Control Panel
localize_table["cn"]["Start-up selected engine button"]		    	="启动所选发动机 按钮"
localize_table["cn"]["Interrupt start-up button"]		    		="中止启动 按钮"
localize_table["cn"]["Stop APU button"]		    					="APU停止 按钮"
localize_table["cn"]["Engine selector"]		    					="发动机选择器"
localize_table["cn"]["Engine work mod selector"]		    		="发动机工作模式选择器"
localize_table["cn"]["Left engine cut-off valve"]		    		="左发动机切断阀"
localize_table["cn"]["Right engine cut-off valve"]		    		="右发动机切断阀"
localize_table["cn"]["Rotor brake"]		    						="旋翼刹车"
localize_table["cn"]["Engine Startup/Crank/False Start selector"]	="发动机 启动/曲柄/假启动 选择器"

localize_table["cn"]["Running engines exhaust gas temperature indicator test button"]	="开车状态排气温度表检测按钮"
localize_table["cn"]["Stopped engines exhaust gas temperature indicator test button"]	="关车状态排气温度表检测按钮"

--Radio switcher
localize_table["cn"]["SPU-9 Radio communicator selector"]		    ="SPU-9 无线电通信选择器"

-- Fire Extinguishers Control Panel
localize_table["cn"]["Left engine extinguisher"]		    		="左发动机 灭火器"
localize_table["cn"]["APU extinguisher"]		    				="APU 灭火器"
localize_table["cn"]["Right engine extinguisher"]		    		="右发动机 灭火器"
localize_table["cn"]["Ventilator extinguisher"]		    			="通风机 灭火器"
localize_table["cn"]["Fire extinguisher Work – Off – Test switch"]	="灭火器 工作 - 关闭 - 检测 开关"
localize_table["cn"]["Fire signaling"]		    					="火警信号"
localize_table["cn"]["Fire extinguisher First (Auto) / Second (Manual) selector"]	="灭火器 第1(自动)/第2(手动) 选择器"
localize_table["cn"]["1st fire warning sensors group BIT"]			="第1火警传感器组 内置检测"
localize_table["cn"]["2nd fire warning sensors group BIT"]			="第2火警传感器组 内置检测"
localize_table["cn"]["3rd fire warning sensors group BIT"]			="第3火警传感器组 内置检测"

-- Misc. systems
localize_table["cn"]["Reducing gear box oil pressure indication selector"] ="减速器滑油压力指示器 选择器"
localize_table["cn"]["Sling load Auto/Manual"] 						="起吊载荷 自动/手动"

-- Lighting
localize_table["cn"]["Lighting cockpit interior lamp switch"]		= "驾驶舱照明 灯 开关"
localize_table["cn"]["Lighting cockpit panel switch"]		    	= "驾驶舱面板照明 开关"
localize_table["cn"]["Lighting night vision cockpit switch"]		= "驾驶舱夜视照明 开关"
localize_table["cn"]["Lighting ADI and SAI switch"]					= "ADI和SAI照明 开关"
localize_table["cn"]["Lighting night vision cockpit brightness knob"]	= "驾驶舱夜视照明亮度 旋钮"
localize_table["cn"]["Lighting cockpit panel brightness knob"]		= "驾驶舱面板照明亮度 旋钮"
localize_table["cn"]["Lighting HSI and ADI brightness knob"]		= "HSI和ADI照明亮度 旋钮"
localize_table["cn"]["Lighting auxiliary panel switch"]				= "辅助面板照明 开关"
localize_table["cn"]["Lighting auxiliary panel brightness knob"]		= "辅助面板照明亮度 旋钮"

-- Outside illumination
localize_table["cn"]["Light landing-search. On/Retraction/Off"]		="着陆-搜索灯 开/收回/关"
localize_table["cn"]["Lights landing-search change. Main/Reserved"]	="着陆-搜索灯切换 主要/备份"
localize_table["cn"]["Tip Lights"]		    						="翼尖灯"
localize_table["cn"]["Anticollision Light"]		    				="防撞灯"
localize_table["cn"]["Navigation Lights 10\%/30\%/100\%/Off"]		="航行灯 10\%/30\%/100\%/关"
localize_table["cn"]["Formation Lights"]		    				="编队灯"

--ARK-22
localize_table["cn"]["ADF Inner-Auto-Outer NDB switch"]		    	="АDF 内-自动-外 NDB开关"
localize_table["cn"]["ADF channel switch"]		    				="АDF 频道开关"
localize_table["cn"]["COMPASS-ANTENNA modes"]		    			="АDF 罗盘-天线 模式"
localize_table["cn"]["TLF-TLG modes"]		    					="АDF 电话/电报 模式"
localize_table["cn"]["ADF Volume"]		    						="АDF 音量"
localize_table["cn"]["ADF Test"]		    						="АDF 检测"

-- Betty ("ALMAZ" system)
localize_table["cn"]["Voice message system messages off"]			="语音信息系统停止播放"
localize_table["cn"]["Voice message system emergency on"]			="语音信息系统应急模式"
localize_table["cn"]["Voice message system messages repeat"]		="语音信息系统重复播放"
localize_table["cn"]["Voice message system check"]		    		="语音信息系统检查"

--R-800 Radio
localize_table["cn"]["R-800 (VHF-2) BIT button"]		    		="R-800 (VHF-2) 内置检测按钮"
localize_table["cn"]["R-800 (VHF-2) AM-FM toggle switch"]		    ="R-800 (VHF-2) AM-FM 切换开关"
localize_table["cn"]["R-800 (VHF-2) Emergency receiver"]		    ="R-800 (VHF-2) 应急接收机"
localize_table["cn"]["R-800 (VHF-2) ADF switch"]		    		="R-800 (VHF-2) ADF开关"
localize_table["cn"]["R-800 (VHF-2) Data transfer rate switch"]		="R-800 (VHF-2) 数据传输率开关"
localize_table["cn"]["R-800 (VHF-2) Squelch"]		    			="R-800 (VHF-2) 静噪"
localize_table["cn"]["R-800 (VHF-2) 1st rotary"]		    		="R-800 (VHF-2) 旋钮1"
localize_table["cn"]["R-800 (VHF-2) 2nd rotary"]		    		="R-800 (VHF-2) 旋钮2"
localize_table["cn"]["R-800 (VHF-2) 3rd rotary"]		    		="R-800 (VHF-2) 旋钮3"
localize_table["cn"]["R-800 (VHF-2) 4th rotary"]		    		="R-800 (VHF-2) 旋钮4"

--R-828 Radio
localize_table["cn"]["R-828 (VHF-1) Radio channel selector"]		="R-828 (VHF-1) 无线电频道选择器"
localize_table["cn"]["R-828 (VHF-1) Radio Volume"]		    		="R-828 (VHF-1) 无线电音量"
localize_table["cn"]["R-828 (VHF-1) Tuner button"]		    		="R-828 (VHF-1) 调谐按钮"
localize_table["cn"]["R-828 (VHF-1) Squelch"]		    			="R-828 (VHF-1) 静噪"

--Signal Flares
localize_table["cn"]["Signal flare system power"]		    		="信号弹 系统电源"
localize_table["cn"]["Signal flare red"]		    				="信号弹 红色"
localize_table["cn"]["Signal flare green"]		    				="信号弹 绿色"
localize_table["cn"]["Signal flare white"]		    				="信号弹 白色"
localize_table["cn"]["Signal flare yellow"]		    				="信号弹 黄色"

-- PShK_7 (Latitude Entry Panel) Пульт широтной коррекции
localize_table["cn"]["Latitude selection rotaty"]		    		="纬度选择旋钮"
localize_table["cn"]["North/South latitude selection"]		    	="北/南 纬度选择"

-- ZMS_3 (Magnetic Variation Entry Panel) Задатчик магнитного склонения
localize_table["cn"]["Magnetic variation selection rotaty"]		    ="磁差选择旋钮"








