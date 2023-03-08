dofile(LockOn_Options.script_path.."devices.lua")

std_message_timeout = 15

start_sequence_full = {
{time = 2.0,message = _("AUTOSTART SEQUENCE IS RUNNING"),message_timeout = std_message_timeout},

--- INIT
{time = 3.226000,action = 74},

--reset trimmers
{time = 3.250000,device = devices.CONTROL_SYSTEM,action = 3014,value = 1.0},
--[[
Нагнетатель - выс.
--]]
{time = 3.520000,device = devices.ENGINE_CONTROL_PANEL,action = 3002,value = 1.0},
{time = 3.64000,device = devices.ENGINE_CONTROL_PANEL,action = 3001,value = 0.0},
{time = 3.720000,device = devices.ENGINE_CONTROL_PANEL,action = 3002,value = 0.0},
--[[
Магнето - выкл.
--]]
{time = 3.8,device = devices.FRONT_SWITCH_BOX,action = 3005,value = 0.0},
--[[
Select Left Combat Tank
--]]
{time = 3.984000,device = devices.FUEL_SYSTEM,action = 3004,value = 0.100000},
--[[
Топливная смесь, выкл. при холостом ходу/вкл./авар. полное обогащение.
--]]
{time = 4.732000,device = devices.ENGINE_SYSTEM,action = 3011,value = 0.0},
{time = 4.992000,action = 75},
--[[
Блокировка ручки управления самолётом
--]]
--{time = 3.870000,device = devices.CONTROL_SYSTEM,action = 3015,value = 1.0, message = _("SURFACE CONTROL LOCK UNLOCKING"),message_timeout = std_message_timeout},
--{time = 3.990000,device = devices.CONTROL_SYSTEM,action = 3015,value = 0.0},
--[[
Стояночный тормоз
--]]
{time = 5.0,device = devices.CONTROL_SYSTEM,action = 3005,value = 1.0, message = _("SET PARKING BRAKES"),message_timeout = std_message_timeout},
{time = 5.726000,action = 74},
{time = 7.292000,action = 75},
{time = 8.708000,device = devices.CONTROL_SYSTEM,action = 3005,value = 0.0},
--[[
Рукоятка положения закрылков
--]]
{time = 12.137000,device = devices.CONTROL_SYSTEM,action = 3001,value = 1.0, message = _("FLAPS HANDLE UP"),message_timeout = std_message_timeout},
--[[
Регулятор подачи горячего воздуха в карбюратор
--]]
{time = 13.278000,device = devices.ENGINE_SYSTEM,action = 3027,value = 1.0, message = _("CARBURETOR HOT-AIR CONTROL IN NORMAL"),message_timeout = std_message_timeout},
--[[
Регулятор подачи холодного воздуха в карбюратор
--]]
{time = 14.700000,device = devices.ENGINE_SYSTEM,action = 3007,value = 0.0, message = _("CARBURETOR RAM-AIR CONTROL IN UNRAMMED FILTERED AIR"),message_timeout = std_message_timeout},
--[[
Рычаг управления двигателем
--]]
{time = 20.010000,device = devices.ENGINE_SYSTEM,action = 3021,value = 0.080, message = _("OPEN THROTTLE ONE INCH"),message_timeout = std_message_timeout},
--[[
Propeller RPM
--]]
{time = 21.258000,device = devices.ENGINE_SYSTEM,action = 3022,value = 1.0, message = _("FULL INCREASE PROPELLER RPM"),message_timeout = std_message_timeout},
--[[
Подключение генератора
--]]
{time = 22.087000,device = devices.RIGHT_SWITCH_PANEL,action = 3013,value = 1.0, message = _("GENERATOR-DISCONNECT SWITCH ON"),message_timeout = std_message_timeout},
--[[
Отключение аккумулятора
--]]
{time = 23.517000,device = devices.RIGHT_SWITCH_PANEL,action = 3012,value = 1.0, message = _("BATTERY-DISCONNECT SWITCH ON"),message_timeout = std_message_timeout},
--[[
Топливный насос, вкл./выкл.
--]]
{time = 24.540000,device = devices.ENGINE_CONTROL_PANEL,action = 3012,value = 1.0, message = _("FUEL BOOSTER ON"),message_timeout = std_message_timeout},
--[[
Перекрывной кран топливной системы
--]]
{time = 25.464000,device = devices.FUEL_SYSTEM,action = 3005,value = 1.0, message = _("TURN ON FUEL SHUT-OFF CONTROL"),message_timeout = std_message_timeout},
--[[
Разбавление масла
--]]
{time = 26.310000,device = devices.ENGINE_CONTROL_PANEL,action = 3007,value = 1.0, message = _("OIL DILUTE"),message_timeout = std_message_timeout},
{time = 35.956000,device = devices.ENGINE_CONTROL_PANEL,action = 3007,value = 0.0},
--[[
Активировать заливку мотора
--]]
{time = 36.310000,device = devices.ENGINE_CONTROL_PANEL,action = 3011,value = 1.0, message = _("ENGINE PRIMING"),message_timeout = std_message_timeout},
{time = 37.956000,device = devices.ENGINE_CONTROL_PANEL,action = 3011,value = 0.0},
--[[
Магнето - вкл.
--]]
{time =  47.2,device = devices.FRONT_SWITCH_BOX,action = 3005,value = 0.3, message = _("TURN IGNITION ON"),message_timeout = std_message_timeout},
--[[
Включение стартера
--]]
{time = 48.0,device = devices.ENGINE_CONTROL_PANEL,action = 3008,value = 1.000000},
{time = 49.2,device = devices.ENGINE_CONTROL_PANEL,action = 3008,value = 1.0, message = _("STARTER ON"),message_timeout = std_message_timeout},
--[[
Топливная смесь, выкл. при холостом ходу/вкл./авар. полное обогащение.
--]]
{time = 50.732000,device = devices.ENGINE_SYSTEM,action = 3019,value = 0.9},
--[[
Включение стартера
--]]
{time = 58.5,device = devices.ENGINE_CONTROL_PANEL,action = 3008,value = 0.0,message = _("MIXTURE RUN"),message_timeout = std_message_timeout},
--[[
Крышка переключателя стартера
--]]
{time = 62.776000,device = devices.ENGINE_CONTROL_PANEL,action = 3009,value = 0.0},
--[[
Арретирование
--]]
{time = 64.580000,device = devices.ARTIFICIAL_HORIZON,action = 3003,value = 0.0, message = _("UNCAGE GYRO"),message_timeout = std_message_timeout},
--[[
Вкл. канал A
--]]
{time = 68.590000,device = devices.VHF_RADIO,action = 3002,value = 1.0},
--[[
Canopy crank
--]]
{time = 71.620000,device = devices.CPT_MECH,action = 3007,value = -1.0, message = _("CANOPY CLOSING"),message_timeout = std_message_timeout},
--[[
Рычаг управления двигателем - IDLE
--]]
{time = 76.000000,device = devices.ENGINE_SYSTEM,action = 3021,value = 0, message = _("THROTTLE BACK TO IDLE"),message_timeout = std_message_timeout},
--[[
Стояночный тормоз отпустить
--]]
{time = 76.010000,action = 74, message = _("RELEASE PARKING BRAKES"),message_timeout = std_message_timeout},
{time = 78.838000,action = 75},
--[[
Set elevator trimmer
--]]
{time = 79.250000,action = 2022,value = 0.2,message = _("SET ELEVATOR TRIMMER TO 2 DEGR NH"),message_timeout = std_message_timeout},
--[[
Самолет готов
--]]
{time = 80.0,message = _("AUTOSTART COMPLETE. AIRCRAFT IS READY TO FLY"),message_timeout = std_message_timeout},
}

stop_sequence_full =  {
--[[
Топливный насос, вкл./выкл.
--]]
{time = 7.586000,device = devices.ENGINE_CONTROL_PANEL,action = 3005,value = 0.0},
--[[
UNKNOWN ACTION
--]]
{time = 20.760000,device = devices.ENGINE_SYSTEM,action = 3024,value = -1.0},
--[[
UNKNOWN ACTION
--]]
{time = 21.800000,device = devices.ENGINE_SYSTEM,action = 3023,value = -1.0},
--[[
Топливная смесь, выкл. при холостом ходу/вкл./авар. полное обогащение.
--]]
{time = 25.470000,device = devices.ENGINE_SYSTEM,action = 3011,value = 0.0},
--[[
Магнето - выкл.
--]]
{time = 37.692000,device = devices.FRONT_SWITCH_BOX,action = 3005,value = 0.0},
--[[
Fuel Shut-Off Valve Off
--]]
{time = 41.090000,device = devices.FUEL_SYSTEM,action = 3005,value = 0.0},
--[[
Радио - вкл./выкл.
--]]
{time = 48.867000,device = devices.VHF_RADIO,action = 3001,value = 1.0},
--[[
Отключение генератора
--]]
{time = 53.588000,device = devices.RIGHT_SWITCH_PANEL,action = 3003,value = 0.0},
--[[
Отключение аккумулятора
--]]
{time = 54.506000,device = devices.RIGHT_SWITCH_PANEL,action = 3001,value = 0.0},
--[[
Обогрев пушки
--]]
{time = 56.924000,device = devices.RIGHT_SWITCH_PANEL,action = 3019,value = 0.0},
--[[
Обогрев ПВД
--]]
{time = 57.620000,device = devices.RIGHT_SWITCH_PANEL,action = 3005,value = 0.0},
--[[
Камера - вкл.
--]]
{time = 67.418000,device = devices.FRONT_SWITCH_BOX,action = 3012,value = 0.0},
--[[
Close Coolant Control
--]]
{time = 84.560000,device = devices.ENGINE_SYSTEM,action = 3001,value = 0.0},
--[[
Крышка тумблера радиатора системы охлаждения
--]]
{time = 85.107000,device = devices.ENGINE_SYSTEM,action = 3003,value = 0.0},
--[[
Маслорадиатор - закрыть
--]]
{time = 86.607000,device = devices.ENGINE_SYSTEM,action = 3002,value = 0.0},
--[[
Крышка тумблера маслорадиатора
--]]
{time = 87.374000,device = devices.ENGINE_SYSTEM,action = 3004,value = 0.0},
--[[
Посадочные огни - вкл.
--]]
{time = 97.574000,device = devices.LIGHT_SYSTEM,action = 3007,value = 0.0},
--[[
Питание хвостовой РЛС - выкл.
--]]
{time = 120.008000,device = devices.TAIL_WARNING_RADAR,action = 3007,value = 0.0},
--[[
Регулятор подачи холодного воздуха в карбюратор
--]]
{time = 133.088000,device = devices.ENGINE_SYSTEM,action = 3007,value = 0.0},
--[[
Canopy crank
--]]
{time = 134.420000,device = devices.CPT_MECH,action = 3007,value = 1.0, message = _("CANOPY OPENING"),message_timeout = std_message_timeout},
}

cockpit_illumination_full = {
--[[
Cockpit Lights
--]]
{time = 3.098000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0, message = _("TURN ON COCKPIT LIGHTS"),message_timeout = std_message_timeout},
{time = 3.146000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.188000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.230000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.272000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.314000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.360000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.401000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.446000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.488000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.532000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.578000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.620000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.668000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.710000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.758000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.800000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.848000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.892000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.938000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 3.983000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.028000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.072000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.118000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.166000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.208000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.252000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.298000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.340000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.388000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.430000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.478000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.520000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.568000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.610000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.658000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.706000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.748000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.796000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.838000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.886000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.932000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 4.976000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.020000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.070000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.114000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.160000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.204000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.250000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.294000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.340000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.390000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.438000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.480000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.522000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.570000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.618000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.660000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.702000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.750000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.792000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.840000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.882000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.930000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 5.972000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 6.020000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 6.062000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 6.110000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
{time = 6.158000,device = devices.FRONT_SWITCH_BOX,action = 3003,value = 1.0},
--[[
Right Fluor Light
--]]
{time = 11.460000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0, message = _("TURN ON RIGHT FLUORESCENT LIGHT"),message_timeout = std_message_timeout},
{time = 11.504000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 11.546000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 11.589000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 11.636000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 11.678000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 11.720000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 11.768000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 11.810000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 11.852000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 11.900000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 11.942000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 11.990000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.038000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.080000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.122000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.170000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.218000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.260000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.308000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.350000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.398000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.440000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.482000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.527000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.570000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.614000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.659000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.704000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.747000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.792000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.836000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.880000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.926000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 12.972000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.016000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.058000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.106000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.150000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.196000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.240000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.286000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.332000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.376000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.418000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.466000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.510000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.556000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.598000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.640000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.688000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.729000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.772000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.820000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.862000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.910000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.952000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 13.994000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.040000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.084000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.130000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.174000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.220000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.264000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.310000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.354000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.397000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.444000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.486000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.528000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.572000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.618000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.666000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
{time = 14.708000,device = devices.RIGHT_SWITCH_PANEL,action = 3010,value = 1.0},
--[[
Left fluor light
--]]
{time = 16.032000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0, message = _("TURN ON LEFT FLUORESCENT LIGHT"),message_timeout = std_message_timeout},
{time = 16.076000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.120000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.166000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.208000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.252000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.297000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.340000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.388000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.430000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.478000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.520000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.562000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.612000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.658000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.700000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.748000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.790000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.838000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.880000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.928000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 16.970000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.012000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.054000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.097000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.144000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.186000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.232000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.276000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.318000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.366000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.408000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.452000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.498000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.546000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.588000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.632000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.678000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.726000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.768000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.812000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.858000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.902000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.948000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 17.990000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.038000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.080000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.122000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.176000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.223000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.270000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.320000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.360000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.410000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.450000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.500000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.540000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.584000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.626000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.672000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.716000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.760000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.806000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.848000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.896000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.938000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 18.986000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 19.028000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 19.070000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 19.118000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 19.160000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 19.208000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 19.250000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
{time = 19.293000,device = devices.LIGHT_SYSTEM,action = 3005,value = 1.0},
} 
