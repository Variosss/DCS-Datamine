localize_table = {}

localize_table["RU"] = {}
localize_table["EN"]  = {}

-- COMMON PART

localize_table["RU"]["BLANK"]	=                 
"         %c\n"..
"         %c\n"..
"         %c\n"..
"         %c"
localize_table["EN"]["BLANK"]	=                 
"         %c\n"..
"         %c\n"..
"         %c\n"..
"         %c"

localize_table["RU"]["SELFTEST"]	=             
"         %c\n"..
"САМОКОНТ %c\n"..
"         %c\n"..
"         %c"
localize_table["EN"]["SELFTEST"]	=             
"         %c\n"..
"SELFTEST %c\n"..
"         %c\n"..
"         %c"

localize_table["RU"]["EKRAN_READY"]	=         
"  ЭКРАН  %c\n"..
"         %c\n"..
"  ГОДЕН  %c\n"..
"         %c"
localize_table["EN"]["EKRAN_READY"]	=             
"  EKRAN  %c\n"..
"         %c\n"..
"  READY  %c\n"..
"         %c"

localize_table["RU"]["EKRAN_FAILURE"]	=         
"  ЭКРАН  %c\n"..
"         %c\n"..
"  ОТКАЗ  %c\n"..
"         %c"localize_table["EN"]["EKRAN_FAILURE"]	=         
"  EKRAN  %c\n"..
"         %c\n"..
" FAILURE %c\n"..
"         %c"

localize_table["RU"]["FLIGHT"]	=                 
"         %c\n"..
"  РЕЙС   %c\n"..
"         %c\n"..
"         %c"
localize_table["EN"]["FLIGHT"]	=                 
"         %c\n"..
" FLIGHT  %c\n"..
"         %c\n"..
"         %c"

localize_table["RU"]["DOCUMENT"]	=             
"         %c\n"..
"ДОКУМЕНТ %c\n"..
"         %c\n"..
"         %c"
localize_table["EN"]["DOCUMENT"]	=             
"         %c\n"..
"DOCUMENT %c\n"..
"         %c\n"..
"         %c"

localize_table["RU"]["DOC_MESS"]	=             
"00000000 %c\n"..
"00000000 %c\n"..
"00000000 %c\n"..
" 0 0 0 0 %c"
localize_table["EN"]["DOC_MESS"]	=             
"00000000 %c\n"..
"00000000 %c\n"..
"00000000 %c\n"..
" 0 0 0 0 %c"

-- FLIGHT CONTROL MODE

localize_table["RU"]["RECEIVE_DL_TARGET"]	=     
"         %c\n"..
" ПРИНЯТЬ %c\n"..
"         %c\n"..
"   ЦУ    %c"
localize_table["EN"]["RECEIVE_DL_TARGET"]	=     
" RECEIVE %c\n"..
"   DL    %c\n"..
"  TARGET %c\n"..
"         %c"

localize_table["RU"]["MAIN_HYDRO"]	=             
"ОСНОВНАЯ %c\n"..
"         %c\n"..
" ГИДРО   %c\n"..
"         %c"
localize_table["EN"]["MAIN_HYDRO"]	=             
"  MAIN   %c\n"..
"         %c\n"..
" HYDRO   %c\n"..
"         %c"


localize_table["RU"]["COMMON_HYDRO"]	=         
" ОБЩАЯ   %c\n"..
"         %c\n".. 
" ГИДРО   %c\n"..
"         %c"
localize_table["EN"]["COMMON_HYDRO"]	=         
" COMMON  %c\n"..
"         %c\n"..
" HYDRO   %c\n"..
"         %c"

localize_table["RU"]["EXTEND_GEAR"]	=         
" ВЫПУСТИ %c\n"..
"         %c\n"..
" ШАССИ   %c\n"..
"         %c"
localize_table["EN"]["EXTEND_GEAR"]	=             
" EXTEND  %c\n"..
"         %c\n"..
"  GEAR   %c\n"..
"         %c"

localize_table["RU"]["MAIN_TRANSM_OIL_PRESS"]	= 
"ДАВЛЕНИЕ %c\n"..
"  МАСЛА  %c\n"..
"         %c\n"..
"ГЛАВ РЕД %c"
localize_table["EN"]["MAIN_TRANSM_OIL_PRESS"]	= 
"  MAIN   %c\n"..
"  TRANSM %c\n"..
"   OIL   %c\n"..
"  PRESS  %c"

localize_table["RU"]["MAIN_TRANSM_OIL_TEMP"]	= 
"  ТЕМП   %c\n"..
"  МАСЛА  %c\n"..
"         %c\n"..
"ГЛАВ РЕД %c"
localize_table["EN"]["MAIN_TRANSM_OIL_TEMP"]	= 
"  MAIN   %c\n"..
"  TRANSM %c\n"..
"   OIL   %c\n"..
"  TEMP   %c"

localize_table["RU"]["MAIN_TRANSM_CHIP"]	=     
"         %c\n"..
" СТРУЖКА %c\n"..
"         %c\n"..
"ГЛАВ РЕД %c"
localize_table["EN"]["MAIN_TRANSM_CHIP"]	=     
"  MAIN   %c\n"..
"  TRANSM %c\n"..
"         %c\n"..
"  CHIP   %c"

localize_table["RU"]["TURN_ON_BACKUP_TRANSP"]	= 
" ВКЛЮЧИ  %c\n"..
"         %c\n"..
" ЗАП КОД %c\n"..
"ОТВЕТЧИК %c"
localize_table["EN"]["TURN_ON_BACKUP_TRANSP"]	= 
"  TURN   %c\n"..
"    ON   %c\n"..
"  BACKUP %c\n"..
" TRANSP  %c"

localize_table["RU"]["ELEC_ON_BATTERY"]	=         
"         %c\n"..
" СЕТЬ НА %c\n"..
"АККУМУЛ  %c\n"..
"         %c"
localize_table["EN"]["ELEC_ON_BATTERY"]	=         
"         %c\n"..
"   ELEC  %c\n"..
"    ON   %c\n"..
"BATTERY  %c"

localize_table["RU"]["USE_TV"]	=                 
"         %c\n"..
" РАБОТАЙ %c\n"..
" С ИТ    %c\n"..
"         %c"
localize_table["EN"]["USE_TV"]	=                 
"         %c\n"..
"   USE   %c\n"..
"    TV   %c\n"..
"         %c"

localize_table["RU"]["TURN_ON_MAN_ATCK_USE_HUD_TV"]	= 
" ВКЛЮЧИ  %c\n"..
"   РУ    %c\n"..
" РАБОТАЙ %c\n"..
" С КИ-ИТ %c"
localize_table["EN"]["TURN_ON_MAN_ATCK_USE_HUD_TV"]	    = 
" TURN ON %c\n"..
"  MAIN   %c\n"..
"ATCK USE %c\n"..
"  HUD TV %c"

localize_table["RU"]["TURN_ON_NAV_BACKUP"]	=     
"         %c\n"..
" ВКЛЮЧИ  %c\n"..
"         %c\n"..
"  РЗН    %c"
localize_table["EN"]["TURN_ON_NAV_BACKUP"]	=     
"TURN ON  %c\n"..
"         %c\n"..
"  NAV    %c\n"..
" BACKUP  %c"

localize_table["RU"]["WPN_CTRL_ROCKET_FAILURE"]= 
"         %c\n"..
" ОТКАЗ   %c\n"..
"         %c\n"..
" СУО-РС  %c"
localize_table["EN"]["WPN_CTRL_ROCKET_FAILURE"]	= 
"   WPN   %c\n"..
"  CTRL   %c\n"..
" ROCKET  %c\n"..
" FAILURE %c"

localize_table["RU"]["GUN_DRIVE_FAILURE"]=       
"         %c\n"..
" ОТКАЗ   %c\n"..
"         %c\n"..
"   ППУ   %c"
localize_table["EN"]["GUN_DRIVE_FAILURE"]	=     
"   GUN   %c\n"..
" DRIVE   %c\n"..
"         %c\n"..
" FAILURE %c"

localize_table["RU"]["FORWARD_TANK_110"]=        
"ПЕРЕДНИЙ %c\n"..
"         %c\n"..
" БАК 110 %c\n"..
"         %c"
localize_table["EN"]["FORWARD_TANK_110"]	=     
" FORWARD %c\n"..
"         %c\n"..
"TANK 110 %c\n"..
"         %c"

localize_table["RU"]["REAR_TANK_110"] =          
" ЗАДНИЙ  %c\n"..
"         %c\n"..
" БАК 110 %c\n"..
"         %c"       
localize_table["EN"]["REAR_TANK_110"]	=         
"   REAR  %c\n"..
"         %c\n"..
"TANK 110 %c\n"..
"         %c"

localize_table["RU"]["TURN_ON_ROTOR_ANTIICE"]	= 
" ОБЛЕДЕН %c\n"..
"         %c\n"..
" ВКЛЮЧИ  %c\n"..
"ПОС ВИНТ %c"
localize_table["EN"] ["TURN_ON_ROTOR_ANTIICE"]	= 
" TURN ON %c\n"..
"         %c\n"..
"  ROTOR  %c\n"..
" ANTIICE %c"

localize_table["RU"]["RADAR_ALT"]	=             
"         %c\n"..
" РАДИО   %c\n"..
"ВЫСОТОМ  %c\n"..
"         %c"
localize_table["EN"] ["RADAR_ALT"]	=             
"         %c\n"..
" RADAR   %c\n"..
"   ALT   %c\n"..
"         %c"

localize_table["RU"]["INU"]	=                 
"         %c\n"..
" КУРСО-  %c\n"..
"ВЕРТИК   %c\n"..
"         %c"
localize_table["EN"] ["INU"]	=                 
"         %c\n"..
"         %c\n"..
"  INU    %c\n"..
"         %c"

localize_table["RU"]["DL_MEMORY_FAILURE"]	=     
"         %c\n"..
" ОТКАЗ   %c\n"..
"         %c\n"..
" ЭЗУ-Ц   %c"           
localize_table["EN"] ["DL_MEMORY_FAILURE"]	=     
"   DL    %c\n"..
" MEMORY  %c\n"..
"         %c\n"..
" FAILURE %c"    

localize_table["RU"]["TURN_ON_SBY_RTCL_USE_FIXED_GUN"]	= 
"  ВКЛЮЧИ %c\n"..
" СЕТКУ   %c\n"..
" РАБОТАЙ %c\n"..
"  С НПУ  %c"    
localize_table["EN"] ["TURN_ON_SBY_RTCL_USE_FIXED_GUN"]	= 
" TURN ON %c\n"..
"SBY RTCL %c\n"..
"    USE  %c\n"..
"FIXD GUN %c" 

localize_table["RU"]["USE_FIXED_GUN"]	=         
"         %c\n"..
"         %c\n"..
" РАБОТАЙ %c\n"..
"  С НПУ  %c" 
localize_table["EN"] ["USE_FIXED_GUN"]	=         
"         %c\n"..
"   USE   %c\n"..
"  FIXED  %c\n"..
"   GUN   %c"

localize_table["RU"]["DATALINK_FAILURE"]	=     
"         %c\n"..
" ОТКАЗ   %c\n"..
"ТЕЛЕКОДА %c\n"..
"         %c"       
localize_table["EN"] ["DATALINK_FAILURE"]	=     
"         %c\n"..
"DATALINK %c\n"..
" FAILURE %c\n"..
"         %c"   

localize_table["RU"]["TURN_ON_INVERTER"]	=     
"  ВКЛЮЧИ %c\n"..
"         %c\n"..
"ПРЕОБРАЗ %c\n"..
"         %c"       
localize_table["EN"] ["TURN_ON_INVERTER"]	=     
" TURN ON %c\n"..
"         %c\n"..
"INVERTER %c\n"..
"         %c" 

localize_table["RU"]["LWS_FAILURE"]	=         
"         %c\n"..
"  ОТКАЗ  %c\n"..
"         %c\n"..
" ЛР-РЭП  %c"         
localize_table["EN"] ["LWS_FAILURE"]	=         
"         %c\n"..
"   LWS   %c\n"..
"         %c\n"..
" FAILURE %c" 

localize_table["RU"]["LEFT_TRANSM_OIL_PRESS"]	= 
"ДАВЛЕНИЕ %c\n"..
"  МАСЛА  %c\n"..
"         %c\n"..
" ЛЕВ РЕД %c"
localize_table["EN"]["LEFT_TRANSM_OIL_PRESS"]	= 
"   LEFT  %c\n"..
" TRANSM  %c\n"..
"   OIL   %c\n"..
"  PRESS  %c"

localize_table["RU"]["LEFT_TRANSM_OIL_TEMP"]	= 
"  ТЕМПЕР %c\n"..
"  МАСЛА  %c\n"..
"         %c\n"..
" ЛЕВ РЕД %c"
localize_table["EN"]["LEFT_TRANSM_OIL_TEMP"]	= 
"   LEFT  %c\n"..
" TRANSM  %c\n"..
"   OIL   %c\n"..
"   TEMP  %c"

localize_table["RU"]["LEFT_TRANSM_CHIP"]	=     
"         %c\n"..
" СТРУЖКА %c\n"..
"         %c\n"..
" ЛЕВ РЕД %c"
localize_table["EN"]["LEFT_TRANSM_CHIP"]	=     
"   LEFT  %c\n"..
" TRANSM  %c\n"..
"         %c\n"..
"   CHIP  %c"

localize_table["RU"]["RIGHT_TRANSM_OIL_PRESS"]	= 
"ДАВЛЕНИЕ %c\n"..
"   МАСЛА %c\n"..
"         %c\n"..
"ПРАВ РЕД %c"
localize_table["EN"]["RIGHT_TRANSM_OIL_PRESS"]	= 
"  RIGHT  %c\n"..
" TRANSM  %c\n"..
"  OIL    %c\n"..
"  PRESS  %c"

localize_table["RU"]["RIGHT_TRANSM_OIL_TEMP"]	= 
"  ТЕМПЕР %c\n"..
"   МАСЛА %c\n"..
"         %c\n"..
"ПРАВ РЕД %c"
localize_table["EN"]["RIGHT_TRANSM_OIL_TEMP"]	= 
"  RIGHT  %c\n"..
" TRANSM  %c\n"..
"   OIL   %c\n"..
"   TEMP  %c"

localize_table["RU"]["RIGHT_TRANSM_CHIP"]	=     
"         %c\n"..
" СТРУЖКА %c\n"..
"         %c\n"..
"ПРАВ РЕД %c"
localize_table["EN"]["RIGHT_TRANSM_CHIP"]	=     
"  RIGHT  %c\n"..
" TRANSM  %c\n"..
"         %c\n"..
"   CHIP  %c"

localize_table["RU"]["ACTUATOR_OIL_PRESS"]	=     
"ДАВЛЕНИЕ %c\n"..
"   МАСЛА %c\n"..
"         %c\n"..
"ПРИВОДОВ %c"
localize_table["EN"]["ACTUATOR_OIL_PRESS"]	=     
"ACTUATOR %c\n"..
"    OIL  %c\n"..
"         %c\n"..
"  PRESS  %c"

localize_table["RU"]["TURN_ON_ARM_SYS_SAFE_SW"]= 
"  ВКЛЮЧИ %c\n"..
"         %c\n"..
" БЛОКИР  %c\n"..
" СУО     %c"
localize_table["EN"]["TURN_ON_ARM_SYS_SAFE_SW"]	= 
" TURN ON %c\n"..
" ARM SYS %c\n"..
"   SAFE  %c\n"..
"   SW    %c"

localize_table["RU"]["STANDBY_ATTITUDE_IND"]	= 
"         %c\n"..
" РЕЗЕРВ  %c\n"..
"   АВИА  %c\n"..
"ГОРИЗОНТ %c"
localize_table["EN"]["STANDBY_ATTITUDE_IND"]	= 
"         %c\n"..
" STANDBY %c\n"..
"ATTITUDE %c\n"..
"   IND   %c"

localize_table["RU"]["LEFT_PROBE_HEAT_FAILURE"]= 
"  ОТКАЗ  %c\n"..
"         %c\n"..
"ОБОГРЕВА %c\n"..
"ПВД ЛЕВ  %c"
localize_table["EN"]["LEFT_PROBE_HEAT_FAILURE"]	= 
"  LEFT   %c\n"..
"  PROBE  %c\n"..
"   HEAT  %c\n"..
" FAILURE %c"

localize_table["RU"]["RIGHT_PROBE_HEAT_FAILURE"]=
"  ОТКАЗ  %c\n"..
"         %c\n"..
"ОБОГРЕВА %c\n"..
"ПВД ПРАВ %c"
localize_table["EN"]["RIGHT_PROBE_HEAT_FAILURE"] =
"  RIGHT  %c\n"..
"  PROBE  %c\n"..
"   HEAT  %c\n"..
" FAILURE %c"  

localize_table["RU"]["AIR_DATA_SYS"]	=         
"         %c\n"..
" ИК-ВСП  %c\n"..
"         %c\n"..
"         %c"
localize_table["EN"]["AIR_DATA_SYS"]	=         
"         %c\n"..
"   AIR   %c\n"..
"   DATA  %c\n"..
"   SYS   %c"

localize_table["RU"]["DOPPLER_NAV_SYS"]=         
"         %c\n"..
"  ДИСС   %c\n"..
"         %c\n"..
"         %c"
localize_table["EN"]["DOPPLER_NAV_SYS"]	=         
"         %c\n"..
" DOPPLER %c\n"..
"   NAV   %c\n"..
"   SYS   %c"

localize_table["RU"]["HUNG_WEAPON"]	=         
"         %c\n"..
" НЕСХОД  %c\n"..
"         %c\n"..
"ИЗДЕЛИЯ  %c"
localize_table["EN"]["HUNG_WEAPON"]	=             
"         %c\n"..
"   HUNG  %c\n"..
"         %c\n"..
" WEAPON  %c"

localize_table["RU"]["TURN_OFF_L-140"]	=         
"         %c\n"..
" ОТКЛЮЧИ %c\n"..
"СОЭП-РЭП %c\n"..
"         %c"
localize_table["EN"]["TURN_OFF_L-140"]	=         
"         %c\n"..
"TURN OFF %c\n"..
"         %c\n"..
"  L-410  %c"

localize_table["RU"]["HEADING_INVALID"]	=     
"         %c\n"..
"  КАНАЛ  %c\n"..
" КУРСА   %c\n"..
"         %c"
localize_table["EN"]["HEADING_INVALID"]	=         
"         %c\n"..
" HEADING %c\n"..
" INVALID %c\n"..
"         %c"

localize_table["RU"]["NAV_POS_INVALID"]	=     
"         %c\n"..
"  НЕТ    %c\n"..
" СЧИСЛЕН %c\n"..
" КООРД   %c"
localize_table["EN"]["NAV_POS_INVALID"]	=         
"         %c\n"..
"  ROUTE  %c\n"..
"    POS  %c\n"..
" FAILURE %c"

localize_table["RU"]["ROUTE_NAV_FAILURE"]	=     
"         %c\n"..
"  СБОЙ   %c\n"..
" РАСЧЕТА %c\n"..
"МАРШРУТА %c"
localize_table["EN"]["ROUTE_NAV_FAILURE"]	=     
"         %c\n"..
"  ROUTE  %c\n"..
"   NAV   %c\n"..
" FAILURE %c"

localize_table["RU"]["NAV_DATA_MEMORY_FAILURE"]= 
"         %c\n"..
"  ЭЗУ-Н  %c\n"..
"         %c\n"..
"         %c"
localize_table["EN"]["NAV_DATA_MEMORY_FAILURE"]	= 
"   NAV   %c\n"..
"   DATA  %c\n"..
"  MEMORY %c\n"..
" FAILURE %c"

localize_table["RU"]["PERFORM_NAV_POS_FIX"]	= 
"         %c\n"..
"ПРОВЕДИ  %c\n"..
"КОРРЕКЦ  %c\n"..
"  КООРД  %c"
localize_table["EN"]["PERFORM_NAV_POS_FIX"]	=     
"         %c\n"..
" PERFORM %c\n"..
" NAV POS %c\n"..
"   FIX   %c"

localize_table["RU"]["LEFT_GEN"]	=             
"         %c\n"..
"   ЛЕВ   %c\n"..
"         %c\n"..
"ГЕНЕР    %c"
localize_table["EN"]["LEFT_GEN"]	=             
"         %c\n"..
"   LEFT  %c\n"..
"         %c\n"..
"  GEN    %c"

localize_table["RU"]["RIGHT_GEN"]	=             
"         %c\n"..
"   ПРАВ  %c\n"..
"         %c\n"..
"ГЕНЕР    %c"
localize_table["EN"]["RIGHT_GEN"]	=             
"         %c\n"..
"   RIGHT %c\n"..
"         %c\n"..
"  GEN    %c"

localize_table["RU"]["LEFT_DC_RECTIF_FAILURE"]	= 
"         %c\n"..
"   ЛЕВ   %c\n"..
"         %c\n"..
"ВЫПРЯМИТ %c"
localize_table["EN"]["LEFT_DC_RECTIF_FAILURE"]	= 
"         %c\n"..
"   LEFT  %c\n"..
"DC RECTF %c\n"..
" FAILURE %c"

localize_table["RU"]["RIGHT_DC_RECTIF_FAILURE"]= 
"         %c\n"..
"   ПРАВ  %c\n"..
"         %c\n"..
"ВЫПРЯМИТ %c"
localize_table["EN"]["RIGHT_DC_RECTIF_FAILURE"]	= 
"         %c\n"..
"  RIGHT  %c\n"..
"DC RECTF %c\n"..
" FAILURE %c"

localize_table["RU"]["LEFT_ENG_GOVERNOR"]	=     
"ЭЛЕКТРОН %c\n"..
" РЕГУЛЯТ %c\n"..
"         %c\n"..
" ЛЕВ ДВ  %c"
localize_table["EN"]["LEFT_ENG_GOVERNOR"]	=     
"   LEFT  %c\n"..
"   ENG   %c\n"..
"         %c\n"..
"GOVERNOR %c"

localize_table["RU"]["RIGHT_ENG_GOVERNOR"]	=     
"ЭЛЕКТРОН %c\n"..
" РЕГУЛЯТ %c\n"..
"         %c\n"..
"ПРАВ ДВ  %c"
localize_table["EN"]["RIGHT_ENG_GOVERNOR"]	=     
"  RIGHT  %c\n"..
"   ENG   %c\n"..
"         %c\n"..
"GOVERNOR %c"

localize_table["RU"]["CMD_FAILURE"]	=         
"         %c\n"..
"  ОТКАЗ  %c\n"..
"         %c\n"..
"ЛТЦ-РЭП  %c"
localize_table["EN"]["CMD_FAILURE"]	=             
"         %c\n"..
"   CMD   %c\n"..
"         %c\n"..
" FAILURE %c"

localize_table["RU"]["LOW_COCKPIT_PRESS"]	=     
"         %c\n"..
" РАЗГЕРМ %c\n"..
"         %c\n"..
"КАБИНЫ   %c"
localize_table["EN"]["LOW_COCKPIT_PRESS"]	=     
"         %c\n"..
"   LOW   %c\n"..
"  COCPIT %c\n"..
"  PRESS  %c"

localize_table["RU"]["NO_HYDRO_PRESS"]	=         
"   НЕТ   %c\n"..
"         %c\n"..
"НАДДУВА  %c\n"..
"ГИДРО    %c"
localize_table["EN"]["NO_HYDRO_PRESS"]	=         
"   NO    %c\n"..
"         %c\n"..
"  HYDRO  %c\n"..
"  PRESS  %c"

localize_table["RU"]["AIRCOND_FAILURE"]	=     
"  ОТКАЗ  %c\n"..
"         %c\n"..
"         %c\n"..
" СКВ     %c"
localize_table["EN"]["AIRCOND_FAILURE"]	=         
"         %c\n"..
" AIRCOND %c\n"..
"         %c\n"..
" FAILURE %c"

localize_table["RU"]["ROTOR_ANTIICE_FAILURE"]	= 
"  ОТКАЗ  %c\n"..
"         %c\n"..
" ПОС     %c\n"..
" ВИНТОВ  %c"
localize_table["EN"]["ROTOR_ANTIICE_FAILURE"]	= 
"  ROTOR  %c\n"..
" ANTIICE %c\n"..
"         %c\n"..
" FAILURE %c"

localize_table["RU"]["HI_VIBR_LEFT_ENG"]	=     
" ПРЕДЕЛ  %c\n"..
"ВИБРАЦИЯ %c\n"..
"         %c\n"..
" ЛЕВ ДВ  %c"
localize_table["EN"]["HI_VIBR_LEFT_ENG"]	=     
"    HI   %c\n"..
"   VIBR  %c\n"..
"   LEFT  %c\n"..
"   ENG   %c"

localize_table["RU"]["HI_VIBR_RIGHT_ENG"]	=     
" ПРЕДЕЛ  %c\n"..
"ВИБРАЦИЯ %c\n"..
"         %c\n"..
" ПРАВ ДВ %c"
localize_table["EN"]["HI_VIBR_RIGHT_ENG"]	=     
"    HI   %c\n"..
"   VIBR  %c\n"..
"  RIGHT  %c\n"..
"   ENG   %c"

localize_table["RU"]["FLIGHT_DATA_REC_FAILURE"]= 
"         %c\n"..
"  ОТКАЗ  %c\n"..
"         %c\n"..
"РЕГИСТР  %c"
localize_table["EN"]["FLIGHT_DATA_REC_FAILURE"]	= 
" FLIGHT  %c\n"..
"   DATA  %c\n"..
"    REC  %c\n"..
" FAILURE %c"


localize_table["RU"]["WPN_CTRL_MEMORY_FAILURE"]= 
"         %c\n"..
"  ЭЗУ-Б  %c\n"..
"         %c\n"..
"         %c"
localize_table["EN"]["WPN_CTRL_MEMORY_FAILURE"]	= 
"   WPN   %c\n"..
"   CTRL  %c\n"..
"  MEMORY %c\n"..
" FAILURE %c"


localize_table["RU"]["LEFT_ENG_CHIP"]	=         
"         %c\n"..
" СТРУЖКА %c\n"..
"         %c\n"..
" ЛЕВ ДВ  %c"
localize_table["EN"]["LEFT_ENG_CHIP"]	=         
"         %c\n"..
"   LEFT  %c\n"..
"   ENG   %c\n"..
"   CHIP  %c"


localize_table["RU"]["RIGHT_ENG_CHIP"]	=         
"         %c\n"..
" СТРУЖКА %c\n"..
"         %c\n"..
" ПРАВ ДВ %c"
localize_table["EN"]["RIGHT_ENG_CHIP"]	=         
"         %c\n"..
"  RIGHT  %c\n"..
"   ENG   %c\n"..
"   CHIP  %c"


localize_table["RU"]["LEFT_ENG_OIL_PRESS"]	=     
"ДАВЛЕНИЕ %c\n"..
"  МАСЛА  %c\n"..
"         %c\n"..
" ЛЕВ ДВ  %c"
localize_table["EN"]["LEFT_ENG_OIL_PRESS"]	=     
"  LEFT   %c\n"..
"   ENG   %c\n"..
"   OIL   %c\n"..
"  PRESS  %c"


localize_table["RU"]["RIGHT_ENG_OIL_PRESS"]	= 
"ДАВЛЕНИЕ %c\n"..
"  МАСЛА  %c\n"..
"         %c\n"..
" ПРАВ ДВ %c"
localize_table["EN"]["RIGHT_ENG_OIL_PRESS"]	=     
"  RIGHT  %c\n"..
"   ENG   %c\n"..
"   OIL   %c\n"..
"  PRESS  %c"



localize_table["RU"]["NO_GUN_INTERLCK"]	=     
"         %c\n"..
"   НЕТ   %c\n"..
" СТОПОРА %c\n"..
"  ППУ    %c"
localize_table["EN"]["NO_GUN_INTERLCK"]	=         
"         %c\n"..
"    NO   %c\n"..
"   GUN   %c\n"..
"INTERLCK %c"


-- ONLY DOCUMENT MODE

localize_table["RU"]["ROTOR_RPM"]	=             
"         %c\n"..
" ОБОРОТЫ %c\n"..
"         %c\n"..
"ВИНТОВ   %c"
localize_table["EN"]["ROTOR_RPM"]	=             
"         %c\n"..
"   ROTOR %c\n"..
"         %c\n"..
"   RPM   %c"


localize_table["RU"]["MAX_G"]	=                 
"         %c\n"..
" ПРЕДЕЛ  %c\n"..
"         %c\n"..
"  NY     %c"
localize_table["EN"]["MAX_G"]	=                 
"         %c\n"..
"   MAX   %c\n"..
"         %c\n"..
"   NY    %c"


localize_table["RU"]["MAX_IAS"]	=             
"         %c\n"..
"  V MAX  %c\n"..
"         %c\n"..
"  ДОП    %c"
localize_table["EN"]["MAX_IAS"]	=                 
"         %c\n"..
"  V MAX  %c\n"..
"         %c\n"..
"  IAS    %c"


localize_table["RU"]["TRANSP_FAILURE"]	=         
"         %c\n"..
"   ОТКАЗ %c\n"..
"         %c\n"..
"ОТВЕТЧИК %c"
localize_table["EN"]["TRANSP_FAILURE"]	=         
"         %c\n"..
"  TRANSP %c\n"..
"         %c\n"..
" FAILURE %c"


localize_table["RU"]["WARNING_THREAT"]	=         
"         %c\n"..
" ATAKA   %c\n"..
"         %c\n"..
"БЕРЕГИСЬ %c" 
localize_table["EN"]["WARNING_THREAT"]	=         
"         %c\n"..
" WARNING %c\n"..
"         %c\n"..
"  THREAD %c" 

localize_table["RU"]["LEFT_ENG_FIRE"]	=         
"  ПОЖАР  %c\n"..
" ЛЕВ     %c\n"..
" ДВ      %c\n"..
"         %c"
localize_table["EN"]["LEFT_ENG_FIRE"]	=         
"   LEFT  %c\n"..
"   ENG   %c\n"..
"         %c\n"..
"  FIRE   %c"

localize_table["RU"]["RIGHT_ENG_FIRE"]	=         
"  ПОЖАР  %c\n"..
"  ПРАВ   %c\n"..
"  ДВ     %c\n"..
"         %c"
localize_table["EN"]["RIGHT_ENG_FIRE"]	=         
"  RIGHT  %c\n"..
"   ENG   %c\n"..
"         %c\n"..
"  FIRE   %c"

localize_table["RU"]["HYDRO_FIRE"]	=             
"  ПОЖАР  %c\n"..
"         %c\n"..
"  ГИДРО- %c\n"..
" ОТСЕКА  %c"  
localize_table["EN"]["HYDRO_FIRE"]	=             
"  HYDRO  %c\n"..
"         %c\n"..
"   FIRE  %c\n"..
"         %c"  

localize_table["RU"]["FAN_FIRE"]	=             
"  ПОЖАР  %c\n"..
"         %c\n"..
" ВЕНТИЛ  %c\n"..
"         %c" 
localize_table["EN"]["FAN_FIRE"]	=             
"   FAN   %c\n"..
"         %c\n"..
"  FIRE   %c\n"..
"         %c" 

localize_table["RU"]["APU_FIRE"]	=             
"  ПОЖАР  %c\n"..
"         %c\n"..
" ВСУ     %c\n"..
"         %c"
localize_table["EN"]["APU_FIRE"]	=             
"    APU  %c\n"..
"         %c\n"..
"  FIRE   %c\n"..
"         %c"
 
localize_table["RU"]["MAX_RPM_LEFT_ENG"]	=     
"  N СТ   %c\n"..
" ПРЕД    %c\n"..
"         %c\n"..
" ЛЕВ ДВ  %c"
localize_table["EN"]["MAX_RPM_LEFT_ENG"]	=     
"   MAX   %c\n"..
"   RPM   %c\n"..
"   LEFT  %c\n"..
"   ENG   %c"

localize_table["RU"]["MAX_RPM_RIGHT_ENG"]	=     
"  N СТ   %c\n"..
" ПРЕД    %c\n"..
"         %c\n"..
" ПРАВ ДВ %c" 
localize_table["EN"]["MAX_RPM_RIGHT_ENG"]	=     
"   MAX   %c\n"..
"   RPM   %c\n"..
"  RIGHT  %c\n"..
"   ENG   %c"

localize_table["RU"]["DANGER_VIBR_LEFT_ENG"]	= 
"ВИБРАЦИЯ %c\n"..
" ОПАСНАЯ %c\n"..
"   ЛЕВ   %c\n"..
" ДВ      %c"
localize_table["EN"]["DANGER_VIBR_LEFT_ENG"]	= 
"  DANGER %c\n"..
"   VIBR  %c\n"..
"  LEFT   %c\n"..
"  ENG    %c"

localize_table["RU"]["DANGER_VIBR_RIGHT_ENG"]	= 
"ВИБРАЦИЯ %c\n"..
" ОПАСНАЯ %c\n"..
"   ПРАВ  %c\n"..
" ДВ      %c"
localize_table["EN"]["DANGER_VIBR_RIGHT_ENG"]	= 
"  DANGER %c\n"..
"   VIBR  %c\n"..
"  RIGHT  %c\n"..
"   ENG   %c"

localize_table["RU"]["HYDRO_FIRE_WARN_SYS"]	= 
"         %c\n"..
"  СПС    %c\n"..
"  ГИДРО  %c\n"..
"         %c"
localize_table["EN"]["HYDRO_FIRE_WARN_SYS"]	=     
"  HYDRO  %c\n"..
"   FIRE  %c\n"..
"   WARN  %c\n"..
"   SYS   %c"

localize_table["RU"]["APU_FIRE_WARN_SYS"]	=     
"  СПС    %c\n"..
"         %c\n"..
" ВСУ     %c\n"..
"         %c"  
localize_table["EN"]["APU_FIRE_WARN_SYS"]	=     
"  APU    %c\n"..
"   FIRE  %c\n"..
"   WARN  %c\n"..
"   SYS   %c"  

localize_table["RU"]["FORWARD_TANK_OFF"]	=     
"ПЕРЕДНИЙ %c\n"..
"         %c\n"..
"   БАК   %c\n"..
"ОТКЛЮЧЕН %c"  
localize_table["EN"]["FORWARD_TANK_OFF"]	=     
" FORWARD %c\n"..
"         %c\n"..
"  TANK   %c\n"..
"   OFF   %c"  

localize_table["RU"]["REAR_TANK_OFF"]	=         
" ЗАДНИЙ  %c\n"..
"         %c\n"..
"   БАК   %c\n"..
"ОТКЛЮЧЕН %c"
localize_table["EN"]["REAR_TANK_OFF"]	=         
"   REAR  %c\n"..
"         %c\n"..
"  TANK   %c\n"..
"   OFF   %c"

localize_table["RU"]["LEFT_FUEL_VALVE"]	=     
" ТОПЛИВН %c\n"..
"         %c\n"..
"  КРАН   %c\n"..
"  ЛЕВ    %c"
localize_table["EN"]["LEFT_FUEL_VALVE"]	=         
"   LEFT  %c\n"..
"         %c\n"..
"  FUEL   %c\n"..
"  VALVE  %c"

localize_table["RU"]["RIGHT_FUEL_VALVE"]	=     
" ТОПЛИВН %c\n"..
"         %c\n"..
"  КРАН   %c\n"..
"  ПРАВ   %c"  
localize_table["EN"]["RIGHT_FUEL_VALVE"]	=     
"  RIGHT  %c\n"..
"         %c\n"..
"  FUEL   %c\n"..
"  VALVE  %c"  

localize_table["RU"]["ENG_ANTIICE"]	=         
"         %c\n"..
"   ПОС   %c\n"..
" ДВ      %c\n"..
"         %c"   
localize_table["EN"]["ENG_ANTIICE"]	=             
"         %c\n"..
"   ENG   %c\n"..
" ANIICE  %c\n"..
"         %c"   

localize_table["RU"]["ENG_ANTIDUST"]	=         
"         %c\n"..
"   ПЗУ   %c\n"..
" ДВ      %c\n"..
"         %c"
localize_table["EN"]["ENG_ANTIDUST"]	=         
"         %c\n"..
"   ENG   %c\n"..
" ANIDUST %c\n"..
"         %c"

localize_table["RU"]["LEFT_ENG_STOP"]	=         
" ОСТАНОВ %c\n"..
"         %c\n"..
"   ЛЕВ   %c\n"..
" ДВИГ    %c" 
localize_table["EN"]["LEFT_ENG_STOP"]	=         
"   LEFT  %c\n"..
"         %c\n"..
"   ENG   %c\n"..
"  STOP   %c" 

localize_table["RU"]["RIGHT_ENG_STOP"]	=         
" ОСТАНОВ %c\n"..
"         %c\n"..
"   ПРАВ  %c\n"..
" ДВИГ    %c"
localize_table["EN"]["RIGHT_ENG_STOP"]	=         
"  RIGHT  %c\n"..
"         %c\n"..
"   ENG   %c\n"..
"  STOP   %c" 


localize_table["RU"]["MASTER_ARM"]	=             
"         %c\n"..
" ГЛАВНЫЙ %c\n"..
"         %c\n"..
"         %c" 
localize_table["EN"]["MASTER_ARM"]	=             
"         %c\n"..
"  MASTER %c\n"..
"   ARM   %c\n"..
"         %c" 


localize_table["RU"]["ANTITANK_PICKLE"]	=     
"         %c\n"..
"   ПУСК  %c\n"..
"         %c\n"..
"  ПС     %c"  
localize_table["EN"]["ANTITANK_PICKLE"]	=         
"         %c\n"..
" ANTITANK%c\n"..
" PICKLE  %c\n"..
"         %c"  

localize_table["RU"]["ROCKET_PICKLE"]	=         
"         %c\n"..
"   ПУСК  %c\n"..
"         %c\n"..
"  НР     %c"   
localize_table["EN"]["ROCKET_PICKLE"]	=         
"         %c\n"..
" ROCKET  %c\n"..
" PICKLE  %c\n"..
"  НР     %c"

localize_table["RU"]["CANNON_FIRE"]	=         
"         %c\n"..
" СТР     %c\n"..
"         %c\n"..
"  ПУШКА  %c"  
localize_table["EN"]["CANNON_FIRE"]	=             
"         %c\n"..
"  CANON  %c\n"..
"         %c\n"..
"   FIRE  %c"

localize_table["RU"]["SUSP_RELEASE"]	=         
"         %c\n"..
"  СБРОС  %c\n"..
"         %c\n"..
"         %c" 
localize_table["EN"]["SUSP_RELEASE"]	=         
"         %c\n"..
"   SUSP  %c\n"..
"         %c\n"..
" RELEASE %c" 

-- ONLY GROUND CONTROL MODE

localize_table["RU"]["LEFT_ENG_FIRE_WARN_SYS"]	= 
"  СПС    %c\n"..
" ЛЕВ     %c\n"..
" ДВИГ    %c\n"..
"         %c"
localize_table["EN"]["LEFT_ENG_FIRE_WARN_SYS"]	= 
"   LEFT  %c\n"..
"ENG FIRE %c\n"..
"  WARN   %c\n"..
"   SYS   %c"

localize_table["RU"]["RIGHT_ENG_FIRE_WARN_SYS"]= 
"  СПС    %c\n"..
" ПРАВ    %c\n"..
" ДВИГ    %c\n"..
"         %c"   
localize_table["EN"]["RIGHT_ENG_FIRE_WARN_SYS"]	= 
"  RIGHT  %c\n"..
"ENG FIRE %c\n"..
"  WARN   %c\n"..
"   SYS   %c"

localize_table["RU"]["TURN_OFF_ARM_SYS_SAFE_SW"]=
" ВЫКЛЮЧИ %c\n"..
"         %c\n"..
" БЛОКИР  %c\n"..
" СУО     %c"   
localize_table["EN"]["TURN_OFF_ARM_SYS_SAFE_SW"] =
"TURN OFF %c\n"..
" ARM SYS %c\n"..
"  SAFE   %c\n"..
"   SW    %c"    

localize_table["RU"]["FAN_FWS"]	=             
"  СПС    %c\n"..
"         %c\n"..
"ВЕНТИЛ   %c\n"..
"         %c"  
localize_table["EN"]["FAN_FWS"]	=                 
"  FAN    %c\n"..
"         %c\n"..
"  FWS    %c\n"..
"         %c" 

localize_table["RU"]["MEMORY"]		= "ПАМЯТЬ"
localize_table["RU"]["QUEUE"]		= "ОЧЕРЕДЬ"
localize_table["RU"]["FAILURE"]	= "ОТКАЗ"

dofile (LockOn_Options.common_script_path.."localizer.lua")
