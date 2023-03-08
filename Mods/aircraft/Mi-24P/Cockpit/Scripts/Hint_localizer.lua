-- In next string to enter "RU" for Russian localisation or "EN" for English localisation
country = "EN"
if  LockOn_Options.cockpit_language == "russian" then
    country = "RU"
end

localize_table = {}


function LOCALIZE(str)
	if		localize_table[country] == nil then
		return str
	else
		if localize_table[country][str] == nil then
			return str
		end
		return localize_table[country][str]
	end
end

localize_table["RU"] = {}

-- CPT MECH
localize_table["RU"]["Gear lever"]		    						="Кран шасси"
localize_table["RU"]["Main/Common hydraulics for emergency gear"]	="Аварийный переключатель основная/общая гидросистема для шасси"
localize_table["RU"]["Accelerometer reset"]		    				="Сброс показаний акселерометра"

-- SYSTEM CONTROLLER
localize_table["RU"]["Master caution push-light"]		    		="Центральный сигнальный огонь - кнопка"
localize_table["RU"]["Lamps test"]		    						="Кнопка контроля сигнализации"
localize_table["RU"]["Rotor RPM warning push-light"]		    	="Кнопка-табло сигнализации выхода за допустимые пределы частоты вращения винтов"
localize_table["RU"]["MWS operation mode (not functional)"]			="Переключатель режима работы БКО (не задействован)"

--laser ranger ( front panel)
localize_table["RU"]["Laser rangefinder / designator - mode switch"]	="Лазерный дальномер / подсвет - переключатель режима"
localize_table["RU"]["Laser designator reset"]		    			="Сброс лазерного подсвета"

-- Right Side Panel (Правый Боковой Пульт) 
-- ELECTRICS POWER
localize_table["RU"]["DC ground power"]		    					="Аэродромное питание. Постоянный ток"
localize_table["RU"]["Battery 2"]		    						="Аккумулятор 2"
localize_table["RU"]["Battery 1"]		    						="Аккумулятор 1"
localize_table["RU"]["AC ground power"]		    					="Аэродромное питание. Переменный ток"
localize_table["RU"]["AC left generator"]		    				="Левый генератор. Переменный ток"
localize_table["RU"]["AC right generator"]		    				="Правый генератор. Переменный ток"
localize_table["RU"]["DC/AC inverter"]		    					="Преобразователь постоянный/переменный ток"

-- FUEL PUMPS POWER AND VALVES
localize_table["RU"]["Forward fuel tank pumps"]		    			="Насос переднего бака"
localize_table["RU"]["Rear fuel tank pumps"]		    			="Насос заднего бака"
localize_table["RU"]["Inner external fuel tanks pumps"]		    	="Насосы внутренних подвесных баков"
localize_table["RU"]["Outer external fuel tanks pumps"]		    	="Насосы внешних подвесных баков"
localize_table["RU"]["Fuelmeter power"]		    					="Топливомер"
localize_table["RU"]["Left engine fuel shutoff valve"]		    	="Перекрывной кран левого двигателя"
localize_table["RU"]["Right engine fuel shutoff valve"]		    	="Перекрывной кран правого двигателя"
localize_table["RU"]["APU fuel shutoff valve"]		    			="Перекрывной кран ВСУ"
localize_table["RU"]["Fuel crossfeed valve"]		    			="Кран кольцевания"
localize_table["RU"]["Fuel quantity indicator self test button"]	="Кнопка контроля топливомера"

-- COMMS POWER
localize_table["RU"]["Intercom"]		    						="Выключатель самолетного переговорного устройста СПУ-9"
localize_table["RU"]["VHF-1 (R828) power switch"]		    		="УКВ-1. Выключатель питания радиостанции Р-828"
localize_table["RU"]["VHF-2 (R-800) power switch"]		    		="УКВ-2. Выключатель питания радиостанции Р-800"
localize_table["RU"]["Radio equipment datalink TLK power switch"]	="Выключатель питания аппаратуры телекодовой связи. ТЛК"
localize_table["RU"]["Radio equipment datalink UHF TLK power switch"]	="Выключатель питания аппаратуры телекодовой связи. УКВ-ТЛК"
localize_table["RU"]["Radio equipment datalink SA-TLF power switch"]	="Выключатель питания аппаратуры телекодовой связи. СА-ТЛФ"

-- WEAPON SYS
localize_table["RU"]["Weapons сontrol system"]		    			="Система управления оружием"

-- EJECT SYSTEM
localize_table["RU"]["Ejecting system power 1"]		    			="Система аварийного покидания. Выключатель электроснабжения 1"
localize_table["RU"]["Ejecting system power 2"]		    			="Система аварийного покидания. Выключатель электроснабжения 2"
localize_table["RU"]["Ejecting system power 3"]		    			="Система аварийного покидания. Выключатель электроснабжения 3"
localize_table["RU"]["Ejecting system power"]		    			="Система аварийного покидания"
localize_table["RU"]["Ejecting system circuit test"]		    	="Система аварийного покидания. Кнопка контроля"
localize_table["RU"]["Ejecting system circuit selector"]		   	="Система аварийного покидания. Переключатель каналов"

-- HYDRAULICS
localize_table["RU"]["Main hydraulics"]		    					="Основная гидросистема ОТКЛ"

-- IFF
localize_table["RU"]["IFF power"]		    						="Самолетный радиолокационный ответчик"

-- ENGINES
localize_table["RU"]["EEG Left engine Electronic Engine Governor"]	="Электронный регулятор левого двигателя"
localize_table["RU"]["EEG Right engine Electronic Engine Governor"]	="Электронный регулятор правого двигателя"
localize_table["RU"]["EEG power turbine channel 1 test – Operate – EEG power turbine channel 2 test, three-switch contactor"]	="ЭРД Проверка оборотов свободной турбины, контуры СТ-1/СТ-2"
localize_table["RU"]["EEG gas generator test – Operate switch"]		="ЭРД ТК Проверка оборотов контура турбокомпрессора"
localize_table["RU"]["Left EGT control threshold governor button"]	="РТ-12-6 регулятор температуры, проверка левого ЭРД"
localize_table["RU"]["Right EGT control threshold governor button"]	="РТ-12-6 регулятор температуры, проверка правого ЭРД"
localize_table["RU"]["Engines vibrations monitoring system control button"]	="Кнопка контроля вибрации ИВ"

-- NAV SYSTEM
localize_table["RU"]["Navigation system power"]						="Пилотажно-навигационный комплекс"
localize_table["RU"]["Gyro/Mag/Manual heading"]		    			="Магнитный курс/Гиро-полукомпас/Заданный курс"

-- SHKVAL windscreen wiper
localize_table["RU"]["SHKVAL windscreen wiper"]		    			="Стеклоочиститель Шквала"


-- ABRIS Display (Дисплей АБРИС) 
localize_table["RU"]["ABRIS Pushbutton 1"]		    				="АБРИС кнопка 1"
localize_table["RU"]["ABRIS Pushbutton 2"]		    				="АБРИС кнопка 2"
localize_table["RU"]["ABRIS Pushbutton 3"]		    				="АБРИС кнопка 3"
localize_table["RU"]["ABRIS Pushbutton 4"]		    				="АБРИС кнопка 4"
localize_table["RU"]["ABRIS Pushbutton 5"]		    				="АБРИС кнопка 5"
localize_table["RU"]["ABRIS Cursor сontrol (rot/push)"]		    	="АБРИС Манипулятор курсора"
localize_table["RU"]["ABRIS Brightness"]		    				="АБРИС Яркость"
localize_table["RU"]["ABRIS Power"]		    						="АБРИС Выключатель"

-- HUD (ИЛС)
localize_table["RU"]["HUD Brightness"]		    					="ИЛС Регулировка яркости"
localize_table["RU"]["HUD Modes Reticle/Night/Day"]		    		="ИЛС СЕТКА/Ночь/День"
localize_table["RU"]["HUD Test"]		    						="ИЛС Тест"
localize_table["RU"]["HUD Filter"]		    						="ИЛС Фильтр"

-- PVI NAV Panel (ПВИ - Пульт Ввода и Индикации)
localize_table["RU"]["NAV '0' Btn"]		    						="ПВИ Кнопка 0"
localize_table["RU"]["NAV '1' Btn"]		    						="ПВИ Кнопка 1"
localize_table["RU"]["NAV '2' Btn"]		    						="ПВИ Кнопка 2"
localize_table["RU"]["NAV '3' Btn"]		    						="ПВИ Кнопка 3"
localize_table["RU"]["NAV '4' Btn"]		    						="ПВИ Кнопка 4"
localize_table["RU"]["NAV '5' Btn"]		    						="ПВИ Кнопка 5"
localize_table["RU"]["NAV '6' Btn"]		    						="ПВИ Кнопка 6"
localize_table["RU"]["NAV '7' Btn"]		    						="ПВИ Кнопка 7"
localize_table["RU"]["NAV '8' Btn"]		    						="ПВИ Кнопка 8"
localize_table["RU"]["NAV '9' Btn"]		    						="ПВИ Кнопка 9"
localize_table["RU"]["NAV Waypoints"]		    					="ПВИ Промежуточный пункт маршрута"
localize_table["RU"]["NAV Inflight INU Realignment"]		    	="ПВИ Повторный запуск ИКВ"
localize_table["RU"]["NAV Fixpoints"]		    					="ПВИ Режим коррекции и ввод координат ориентиров коррекции"
localize_table["RU"]["NAV Precise INU Alignment"]		    		="ПВИ Режим выставки с гирокомпасированием"
localize_table["RU"]["NAV Airfields"]		    					="ПВИ Режим возврата на аэродром и ввод координат аэродромов"
localize_table["RU"]["NAV Normal INU Alignment"]		    		="ПВИ Включение нормальной подготовки ИКВ"
localize_table["RU"]["NAV Targets"]		    						="ПВИ Режим определения координат целей, ввода известных целей и выход в ОТ"
localize_table["RU"]["NAV Enter"]		    						="ПВИ Ввод набранной информации"
localize_table["RU"]["NAV Cancel"]		    						="ПВИ Сброс информации для повторного набора"
localize_table["RU"]["NAV Initial Nav Pos"]		    				="ПВИ Ввод (индикация) координат точки старта"
localize_table["RU"]["NAV Self coordinates"]		    			="ПВИ Индикация текущих координат"
localize_table["RU"]["NAV Course:Course Deviation/Time/Range to WPT"] ="ПВИ Индикация текущего ЗПУ на ППМ, бокового уклонения от ЛЗП, времени полета и расстояния до ППМ"
localize_table["RU"]["NAV Wind Heading/Speed"]		    			="ПВИ Индикация направления и скорости ветра"
localize_table["RU"]["NAV True Heading/Time/Range to final WPT"]	="ПВИ Индикация текущего истинного курса, времени полета и расстояния до КПМ"
localize_table["RU"]["NAV Bearing/Range to target"]		    		="ПВИ Индикация курсового угла и дальности до цели"
localize_table["RU"]["NAV Master modes"]		    				="ПВИ Галетный переключатель режимов"
localize_table["RU"]["NAV INU fixtaking method"]		    		="ПВИ Выбор способа коррекции координат, с помощью И-251 или пролетом"
localize_table["RU"]["NAV Datalink power"]		    				="ПВИ Включение режима внешнего целеуказания"
localize_table["RU"]["NAV Brightness"]		    					="ПВИ Регулировка яркости"

-- UV-26 CMD Control Panel (УВ-26 - Устройство Выброса ЛТЦ)
localize_table["RU"]["CMD Select Left/Both/Right board flares dispensers"]	="УВ-26 Переключатель Левый/Оба/Правый борт"
localize_table["RU"]["CMD Amount flares counter/Programming"]	="УВ-26 Переключатель Остаток ЛТЦ/Программирование"
localize_table["RU"]["CMD Num of sequences"]		    			="УВ-26 Количество залпов"
localize_table["RU"]["CMD Num in sequence"]		    				="УВ-26 Количество патронов в залпе"
localize_table["RU"]["CMD Dispence interval"]		    			="УВ-26 Интревал между залпами"
localize_table["RU"]["CMD Start dispense"]		    				="УВ-26 Запуск программы"
localize_table["RU"]["CMD Reset to default program"]		    	="УВ-26 Сброс программы"
localize_table["RU"]["CMD Stop dispense"]		    				="УВ-26 Останов программы"

-- UV-26 related (BACK CONTROL PANEL)
localize_table["RU"]["CMD Power"]		    						="УВ-26 Выключатель питания"
localize_table["RU"]["CMD BIT"]		    							="УВ-26 Контроль"

-- Datalink Control Panel
localize_table["RU"]["DLNK Send/Memory"]		    				="ПРЦ Передача или запоминание информации"
localize_table["RU"]["DLNK Ingress to target"]		    			="ПРЦ Режим выхода на цель"
localize_table["RU"]["DLNK Erase"]		    						="ПРЦ Стирание введенной информации"
localize_table["RU"]["N/A"]		    								="ПРЦ н.д."
localize_table["RU"]["DLNK to ALL"]		    						="ПРЦ Адресация информации всему звену"
localize_table["RU"]["DLNK to Wingman 1"]		    				="ПРЦ Адресация информации вертолету 1"
localize_table["RU"]["DLNK to Wingman 2"]		    				="ПРЦ Адресация информации вертолету 2"
localize_table["RU"]["DLNK to Wingman 3"]		    				="ПРЦ Адресация информации вертолету 3"
localize_table["RU"]["DLNK to Wingman 4"]		    				="ПРЦ Адресация информации вертолету 4"
localize_table["RU"]["DLNK Target #1/Vehicle"]		    			="ПРЦ Тип цели МАШИНА или номер 1"
localize_table["RU"]["DLNK Target #2/SAM"]		    				="ПРЦ Тип цели ЗРК или номер 2"
localize_table["RU"]["DLNK Target #3/Other Type"]		    		="ПРЦ Тип цели ДРУГАЯ или номер 3"
localize_table["RU"]["DLNK Ingress point"]		    				="ПРЦ Точка выхода"

-- Datalink Mode Controls
localize_table["RU"]["Datalink self ID"]		    				="ПВЦ Галетный переключатель КТО Я"
localize_table["RU"]["Datalink Master mode"]		    			="ПВЦ Галетный переключатель РЕЖИМ"

-- PUI-800 Weapons Control Panel (ПУИ-800 Пульт Управления и Индикации)
localize_table["RU"]["Master Arm"]		    						="ПУИ Главный выключатель СУО"
localize_table["RU"]["Not implemented"]		    					="ПУИ н.д."
localize_table["RU"]["External stores jettison"]		    		="ПУИ Кнопка аварийного сброса подвесок"
localize_table["RU"]["Manual/Auto weapon system control switch"]	="ПУИ Переключатель выбора режима СУО"
localize_table["RU"]["Cannon round selector switch HE/AP"]		    ="ПУИ Переключатель выбора типа патронной ленты пушки"
localize_table["RU"]["Weapon mode switch - Burst Length"]		   	="ПУИ Переключатель выбора длины очереди или количества ракет в залпе"
localize_table["RU"]["Cannon rate of fire setting"]		    		="ПУИ Переключатель выбора темпа стрельбы пушки"
localize_table["RU"]["Jettison arm mode - arm fuse/disarm fuse"]	="ПУИ Переключатель выбора режима сброса ВЗРЫВ-НЕВЗРЫВ"
localize_table["RU"]["Expedite emergency ATGM launch"]				="ПУИ Кнопка аварийного пуска ПТУР"

-- PUR Weapons Aux Panel (ПУР Пульт Управления Режимом)
localize_table["RU"]["IT-23 Black-White indication switch"]			="ПУР ИТ-23 Цвет индикации"
localize_table["RU"]["IT-23 display brightness"]		    		="ПУР ИТ-23 Яркость"
localize_table["RU"]["IT-23 display contrast"]		    			="ПУР ИТ-23 Контраст"
localize_table["RU"]["SHKVAL Optics adjustment"]		    		="ПУР ИТ Переключение светофильтров в КАПК"
localize_table["RU"]["Helmet device brightness"]					="ПУР Нашлемное устройство яркость"
localize_table["RU"]["Laser code selector"]		    				="ПУР Установка литера для КАПК"
localize_table["RU"]["HUD/TV declutter switch"]		    			="ПУР Переключение объема выводимой индикации на ИЛС и ИТ"

-- Auxiliary panel - Preflight Set and Check Panel (ППК - Пульт Подготовки и Контроля)
localize_table["RU"]["ATGM Temperature selector"]		    		="ППК Температура ПТУР"
localize_table["RU"]["Unguided rocket and gun pods ballistics data settings selector"] ="ППК Установки баллистических коэффициентов НАР и пушек"
localize_table["RU"]["Systems BIT selector"]		    			="ППК Установка режима проверки"
localize_table["RU"]["Control computers BIT switch"]		    	="ППК К-ЦВМ"
localize_table["RU"]["INU Power switch"]		    				="ППК Инерциальная курсо-вертикаль"
localize_table["RU"]["INU Heater switch"]		    				="ППК Обогрев инерциальной курсо-вертикали"
localize_table["RU"]["Self test system push-button"]		    	="ППК Система самотестирования"
localize_table["RU"]["Emergency INU alignment switch"]		    	="ППК Аварийная выставка ИКВ"
localize_table["RU"]["Stabilisation and indication of hanger cable switch"] ="ППК Стабилизация и индикация положения троса"
localize_table["RU"]["Video Tape Recorder switch"]		    		="ППК Фото-контрольный прибор"

localize_table["RU"]["Power plant, hydraulics, EKRAN self-test systems switch"]	="Выключатель электроснабжения систем ВМГ, ГИДРО и ЭКРАН."

-- PPR - Autopilot Control Panel (ППР - Пульт Пилотажных Режимов)
localize_table["RU"]["Autopilot Bank hold"]		    				="ППР Канал крена"
localize_table["RU"]["Autopilot Heading hold"]		    			="ППР Канал направления"
localize_table["RU"]["Autopilot Pitch hold"]		    			="ППР Канал тангажа"
localize_table["RU"]["Autopilot Altitude hold"]		    			="ППР Канал высоты"
localize_table["RU"]["Autopilot Director control"]					="ППР Канал директорного управления"
localize_table["RU"]["Autopilot BARO/RALT altitude hold mode"]		="ППР Режимы стабилизации высоты БАРО/РВ"
localize_table["RU"]["Autopilot Desired heading - Desired track"]	="ППР Режимы автоматизированного полета по маршруту ЗК/ЛЗП"

-- CLOCK (часы)
localize_table["RU"]["Mech clock left lever"]		    			="АЧС-1 Левая головка"
localize_table["RU"]["Mech clock right lever"]		    			="АЧС-1 Правая головка"

-- OVERHEAD PANEL
localize_table["RU"]["Brightness"]		    						="Яркость"
localize_table["RU"]["Rotor de-icing system switch"]		    	="Противообледенительная система винтов"
localize_table["RU"]["Engines de-icing / dust-protection systems switch"]	="Противообледенительная система двигателей / пылезащитное устройство"
localize_table["RU"]["Navigation Lights 10\% / 30\% / 100\% / Off"]	="Переключатель регулировки яркости свечения БАНО, 10\% / 30\% / 100\% / Off"
localize_table["RU"]["Windshield wiper switch"]		    			="Переключатель стеклоочистителя лобового стекла"
localize_table["RU"]["Windshield washer fluid switch"]		    	="Выключатель подачи омывающей жидкости"
localize_table["RU"]["Pitot static port and AoA sensors heat switch"] ="Выключатель подогрева приемника полного давления и датчиков угла атаки и сноса"
localize_table["RU"]["Pitot ram air and clock heat switch"]		    ="Выключатель подогрева приемника воздушного давления и часов"

localize_table["RU"]["Pitot heat system test"] = "Кнопка контроля обогрева ПВД"
-- HSI (ПНП)
localize_table["RU"]["HSI Commanded course rotary"]		    		="ПНП Кремальера заданного путевого угла"
localize_table["RU"]["HSI Commanded heading rotary"]		    	="ПНП Кремальера заданного курса"
localize_table["RU"]["HSI test"]		    						="ПНП Тест"
localize_table["RU"]["HSI Desired track angle - Desired heading, Auto - Manual"]		    ="ЗК-ЗПУ Ручной/Автоматический режим"

-- ADI (ИКП)
localize_table["RU"]["ADI Zero pitch trim"]		    				="ИКП Установка нулевого тангажа"
localize_table["RU"]["ADI Test"]		    						="ИКП Тест"

-- SAI (АГР-81)
localize_table["RU"]["Standby Attitude Indicator Cage/control test handle"]		="АГР Ручка арретира/тест контроль"
localize_table["RU"]["Standby Attitude Indicator power switch"]			="АГР Питание резервного авиагоризонта"

-- RADIOALTIMETER
localize_table["RU"]["Dangerous RALT set rotary"]		    		="РВ Установка сигнализации опасной высоты"
localize_table["RU"]["Radar altimeter test"]		    			="РВ Тест"

-- BARO ALTIMETER
localize_table["RU"]["Baro pressure QFE knob"]		    			="Кремальера установки высоты аэродрома (QFE)"

-- PVR (ПВР - Пульт Выбора Режимов К-041)
localize_table["RU"]["Training mode"]		    					="ПВР Режим ТРЕНАЖ"
localize_table["RU"]["Automatic turn on target mode"]		    	="ПВР Автоматический доворот на цель"
localize_table["RU"]["Airborne Target"]		    					="ПВР Воздушная цель"
localize_table["RU"]["Forward hemisphere (head-on) air target aspect"] ="ПВР Передняя полусфера атаки"
localize_table["RU"]["Ground moving target"]		    			="ПВР Наземная подвижная цель"
localize_table["RU"]["Weapon system mode selector"]		    		="ПВР Выбор режимов"
localize_table["RU"]["Targeting mode reset"]		    			="ПВР СБРОС задачи"
localize_table["RU"]["Automatic Tracking / gun sight"]		    	="ПВР Автоматическое сопровождение / Прицельная марка"
localize_table["RU"]["K-041 Targeting-navigation system power switch"]		   	="ПВР ПрПНК К-041"
localize_table["RU"]["Laser standby ON/OFF switch"]		    		="ПВР Выключатель готовности лазерного дальномера"
localize_table["RU"]["Helmet-mounted sight system power switch"]	="ПВР Нашлемное устройство"
localize_table["RU"]["Shkval scan rate"]		    				="Переключатель скорости сканирования КАПК"


-- Laser Warning System (Л-140)
localize_table["RU"]["LWS Reset button"]		    				="Л-140 кнопка СБРОС"
localize_table["RU"]["LWS Power switch"]		    				="Л-140 выключатель питания"
localize_table["RU"]["LWS self-test button"]		    			="Л-140 кнопка контроля (самотестирования) аппаратуры"

-- Engines Start Control Panel
localize_table["RU"]["Start-up selected engine button"]		    	="Запуск выбранного двигателя"
localize_table["RU"]["Interrupt start-up button"]		    		="Прекращение запуска"
localize_table["RU"]["Stop APU button"]		    					="Останов ВСУ"
localize_table["RU"]["Engine selector"]		    					="Переключатель двигателей четырехпозиционный"
localize_table["RU"]["Engine work mod selector"]		    		="Переключатель режима работы двигателя"
localize_table["RU"]["Left engine cut-off valve"]		    		="Стоп-кран левого двигателя"
localize_table["RU"]["Right engine cut-off valve"]		    		="Стоп-кран правого двигателя"
localize_table["RU"]["Rotor brake"]		    						="Тормоз винтов"
localize_table["RU"]["Engine Startup/Crank/False Start selector"]	="Переключатель режимов запуска, ЗАПУСК / ПРОКРУТКА / ЛОЖНЫЙ ЗАПУСК"

localize_table["RU"]["Running engines exhaust gas temperature indicator test button"]	="Кнопка контроля указателя температуры газов двигателей при работающих двигателях"
localize_table["RU"]["Stopped engines exhaust gas temperature indicator test button"]	="Кнопка контроля указателя температуры газов двигателей при неработающих двигателях"

--Radio switcher
localize_table["RU"]["SPU-9 Radio communicator selector"]		    ="СПУ-9 Выбор типа связи"

-- Fire Extinguishers Control Panel
localize_table["RU"]["Left engine extinguisher"]		    		="Система пожаротушения левого двигателя"
localize_table["RU"]["APU extinguisher"]		    				="Система пожаротушения ВСУ"
localize_table["RU"]["Right engine extinguisher"]		    		="Система пожаротушения правого двигателя"
localize_table["RU"]["Ventilator extinguisher"]		    			="Система пожаротушения в отсеке вентиляции"
localize_table["RU"]["Fire extinguisher Work – Off – Test switch"]	="Переключатель Огнетушители - Отключено - Контроль"
localize_table["RU"]["Fire signaling"]		    					="Выключатель пожарной сигнализации"
localize_table["RU"]["Fire extinguisher First (Auto) / Second (Manual) selector"]	="Переключатель БАЛЛОНЫ. Выбор первого (АВТО) или второго (РУЧН) баллона"
localize_table["RU"]["1st fire warning sensors group BIT"]			="Переключатель КОНТРОЛЬ ДАТЧИКОВ I ГР"
localize_table["RU"]["2nd fire warning sensors group BIT"]			="Переключатель КОНТРОЛЬ ДАТЧИКОВ II ГР"
localize_table["RU"]["3rd fire warning sensors group BIT"]			="Переключатель КОНТРОЛЬ ДАТЧИКОВ III ГР"

-- Misc. systems
localize_table["RU"]["Reducing gear box oil pressure indication selector"] ="Переключатель индикации давления масла в редукторах"
localize_table["RU"]["Sling load Auto/Manual"] 						="Подвеска груза на тросе АВТ/РУЧН"

-- Lighting
localize_table["RU"]["Lighting cockpit interior lamp switch"]		= "Освещение кабины - плафон"
localize_table["RU"]["Lighting cockpit panel switch"]		    	= "Подсвет приборов"
localize_table["RU"]["Lighting night vision cockpit switch"]		= "Подсвет пультов синий ОНВ"
localize_table["RU"]["Lighting ADI and SAI switch"]					= "Подсвет АГР и ПКП"
localize_table["RU"]["Lighting night vision cockpit brightness knob"]	= "Яркость синей ночной подсветки"
localize_table["RU"]["Lighting cockpit panel brightness knob"]		= "Яркость подсветки приборов"
localize_table["RU"]["Lighting HSI and ADI brightness knob"]		= "Яркость подсветки АГР и ПКП"
localize_table["RU"]["Lighting auxiliary panel switch"]				= "Посвет панели контроля"
localize_table["RU"]["Lighting auxiliary panel brightness knob"]		= "Яркость посвета панели контроля"

-- Outside illumination
localize_table["RU"]["Light landing-search. On/Retraction/Off"]		="Поисково-посадочная фара"
localize_table["RU"]["Lights landing-search change. Main/Reserved"]	="Переключатель поисково-посадочных фар. Основная/Резервная"
localize_table["RU"]["Tip Lights"]		    						="Контурные огни"
localize_table["RU"]["Anticollision Light"]		    				="Проблесковый маяк"
localize_table["RU"]["Navigation Lights 10\%/30\%/100\%/Off"]		="Аэронавигационные огни"
localize_table["RU"]["Formation Lights"]		    				="Строевые огни"

--ARK-22
localize_table["RU"]["ADF Inner-Auto-Outer NDB switch"]		    	="АРК Переключатель режима маяков Дальний/Автомат/Ближний"
localize_table["RU"]["ADF channel switch"]		    				="АРК Переключатель каналов"
localize_table["RU"]["COMPASS-ANTENNA modes"]		    			="АРК Выбор режима работы Компас/Антенна"
localize_table["RU"]["TLF-TLG modes"]		    					="АРК Телефон/Телеграф"
localize_table["RU"]["ADF Volume"]		    						="АРК Громкость звука"
localize_table["RU"]["ADF Test"]		    						="АРК Контроль"

-- Betty ("ALMAZ" system)
localize_table["RU"]["Voice message system messages off"]			="Речевой информатор отключить сообщения"
localize_table["RU"]["Voice message system emergency on"]			="Речевой информатор аварийный режим работы"
localize_table["RU"]["Voice message system messages repeat"]		="Речевой информатор повтор сообщений"
localize_table["RU"]["Voice message system check"]		    		="Речевой информатор контроль"

--R-800 Radio
localize_table["RU"]["R-800 (VHF-2) BIT button"]		    		="Р-800 (УКВ-2) Контроль"
localize_table["RU"]["R-800 (VHF-2) AM-FM toggle switch"]		    ="Р-800 (УКВ-2) Амплитудная/Частотная модуляция"
localize_table["RU"]["R-800 (VHF-2) Emergency receiver"]		    ="Р-800 (УКВ-2) Аварийный приемник"
localize_table["RU"]["R-800 (VHF-2) ADF switch"]		    		="Р-800 (УКВ-2) Подключение АРК"
localize_table["RU"]["R-800 (VHF-2) Data transfer rate switch"]		="Р-800 (УКВ-2) Переключатель скорости передачи"
localize_table["RU"]["R-800 (VHF-2) Squelch"]		    			="Р-800 (УКВ-2) Шумоподавитель"
localize_table["RU"]["R-800 (VHF-2) 1st rotary"]		    		="Р-800 (УКВ-2) Барабан задатчика частоты 1"
localize_table["RU"]["R-800 (VHF-2) 2nd rotary"]		    		="Р-800 (УКВ-2) Барабан задатчика частоты 2"
localize_table["RU"]["R-800 (VHF-2) 3rd rotary"]		    		="Р-800 (УКВ-2) Барабан задатчика частоты 3"
localize_table["RU"]["R-800 (VHF-2) 4th rotary"]		    		="Р-800 (УКВ-2) Барабан задатчика частоты 4"

--R-828 Radio
localize_table["RU"]["R-828 (VHF-1) Radio channel selector"]		="Р-828 (УКВ-1) Переключатель каналов"
localize_table["RU"]["R-828 (VHF-1) Radio Volume"]		    		="Р-828 (УКВ-1) Громкость"
localize_table["RU"]["R-828 (VHF-1) Tuner button"]		    		="Р-828 (УКВ-1) Автоматическое согласующее устройство (тюнер)"
localize_table["RU"]["R-828 (VHF-1) Squelch"]		    			="Р-828 (УКВ-1) Шумоподавитель"

--Signal Flares
localize_table["RU"]["Signal flare system power"]		    		="ПУСР Питание системы выброса сигнальных ракет"
localize_table["RU"]["Signal flare red"]		    				="ПУСР Сигнальная ракета красная"
localize_table["RU"]["Signal flare green"]		    				="ПУСР Сигнальная ракета зеленая"
localize_table["RU"]["Signal flare white"]		    				="ПУСР Сигнальная ракета белая"
localize_table["RU"]["Signal flare yellow"]		    				="ПУСР Сигнальная ракета желтая"

-- PShK_7 (Latitude Entry Panel) Пульт широтной коррекции
localize_table["RU"]["Latitude selection rotaty"]		    		="Задатчик широтной коррекции"
localize_table["RU"]["North/South latitude selection"]		    	="Северная/Южная широта"

-- ZMS_3 (Magnetic Variation Entry Panel) Задатчик магнитного склонения
localize_table["RU"]["Magnetic variation selection rotaty"]		    ="Задатчик магнитного склонения"