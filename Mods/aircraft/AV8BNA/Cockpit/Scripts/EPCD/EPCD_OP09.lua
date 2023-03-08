local gettext = require("i_18n")
_ = gettext.translate

data_frame = {}

data_frame[1] = {}
data_frame[1]["Title"]	= 1
data_frame[1]["Text"]	= "FUEL TRANSFER FAILURE (L TRANS/R TRANS CAUTION LIGHTS)"

data_frame[2] = {}
data_frame[2]["Title"]	= 1
data_frame[2]["Text"]	= "## IF L FUEL OR R FUEL CAUTION FLASHES"

data_frame[3] = {}
data_frame[3]["Title"]	= 1
data_frame[3]["Text"]	= "1. FUEL PROPORTIONER SW: OFF"

data_frame[4] = {}
data_frame[4]["Title"]	= 1
data_frame[4]["Text"]	= "2. BOOST PUMP SW (FLASHING SIDE): OFF"

data_frame[5] = {}
data_frame[5]["Title"]	= 1
data_frame[5]["Text"]	= "3. BOOST PUMP SW (NON-FLASHING SIDE): ON"

data_frame[6] = {}
data_frame[6]["Title"]	= 1
data_frame[6]["Text"]	= "4. FUEL ASYMMERTY: MONITOR"

data_frame[7] = {}
data_frame[7]["Title"]	= 1
data_frame[7]["Text"]	= "5. LAND AS SOON AS PRACTICAL"

data_frame[8] = {}
data_frame[8]["Title"]	= 1
data_frame[8]["Text"]	= "## IF BOTH L FUEL AND R FUEL CAUTION FLASH"

data_frame[9] = {}
data_frame[9]["Title"]	= 1
data_frame[9]["Text"]	= "1. DROP TANKS: JETTISON"

data_frame[10] = {}
data_frame[10]["Title"]	= 1
data_frame[10]["Text"]	= "2. BOTH BOOST PUMPS : NORM"

data_frame[11] = {}
data_frame[11]["Title"]	= 1
data_frame[11]["Text"]	= "3. FUEL PROPORTIONER SWHTCH: OFF"

data_frame[12] = {}
data_frame[12]["Title"]	= 1
data_frame[12]["Text"]	= "4. LAND IMMEDITATELY"

data_frame[13] = {}
data_frame[13]["Title"]	= 1
data_frame[13]["Text"]	= " "

data_frame[14] = {}
data_frame[14]["Title"]	= 1
data_frame[14]["Text"]	= "FUEL LOW LEVEL (L FUEL/R FUEL CAUTION LIGHTS)"

data_frame[15] = {}
data_frame[15]["Title"]	= 1
data_frame[15]["Text"]	= "A. EXTERNAL FUEL TANK TRANSFER FAILURE"

data_frame[16] = {}
data_frame[16]["Title"]	= 1
data_frame[16]["Text"]	= "1. WING TANK (FAILED SIDE): BURN USEABLE FUEL"

data_frame[17] = {}
data_frame[17]["Title"]	= 1
data_frame[17]["Text"]	= "2. DUMP SW (FAILED SIDE): DUMP (HOLD IF NECESSARY)"

data_frame[18] = {}
data_frame[18]["Title"]	= 1
data_frame[18]["Text"]	= " "

data_frame[19] = {}
data_frame[19]["Title"]	= 1
data_frame[19]["Text"]	= "CONTINUED"

data_frame[20] = {}
data_frame[20]["Title"]	= 2
data_frame[20]["Text"]	= "A. EXTERNAL FUEL TANK TRANSFER FAILURE (CONTD)"

data_frame[21] = {}
data_frame[21]["Title"]	= 2
data_frame[21]["Text"]	= "## WHEN FUEL STARTS TO DUMP FROM DUMP MAST:"

data_frame[22] = {}
data_frame[22]["Title"]	= 2
data_frame[22]["Text"]	= "3. DUMP SW: NORM"

data_frame[23] = {}
data_frame[23]["Title"]	= 2
data_frame[23]["Text"]	= "4. FUEL QTY INDICATOR: MONITOR"

data_frame[24] = {}
data_frame[24]["Title"]	= 2
data_frame[24]["Text"]	= "5. REPEAT PROCEDURE AS REQUIRED TO USE EXT. FUEL"

data_frame[25] = {}
data_frame[25]["Title"]	= 2
data_frame[25]["Text"]	= "## IF FUEL DOES NOT TRANS FROM EXT TANK"

data_frame[26] = {}
data_frame[26]["Title"]	= 2
data_frame[26]["Text"]	= "6. BALANCE INT WING TANK FUEL"

data_frame[27] = {}
data_frame[27]["Title"]	= 2
data_frame[27]["Text"]	= " "

data_frame[28] = {}
data_frame[28]["Title"]	= 2
data_frame[28]["Text"]	= "B. FUEL LEAK"

data_frame[29] = {}
data_frame[29]["Title"]	= 2
data_frame[29]["Text"]	= "1. MINIMIZE MANEUVERING"

data_frame[30] = {}
data_frame[30]["Title"]	= 2
data_frame[30]["Text"]	= "2. AIR REFUEL SW: OUT"

data_frame[31] = {}
data_frame[31]["Title"]	= 2
data_frame[31]["Text"]	= "3. BOOST PUMPS: OFF"

data_frame[32] = {}
data_frame[32]["Title"]	= 2
data_frame[32]["Text"]	= "4. FUEL FLOW PROPORTIONER: OFF"

data_frame[33] = {}
data_frame[33]["Title"]	= 2
data_frame[33]["Text"]	= "5. EXECTUTE INFLIGHT FIRE PROCEDURE"

data_frame[34] = {}
data_frame[34]["Title"]	= 2
data_frame[34]["Text"]	= " "

data_frame[35] = {}
data_frame[35]["Title"]	= 2
data_frame[35]["Text"]	= "C. AIR REFUEL PROBE FAILS TO RETRACT"

data_frame[36] = {}
data_frame[36]["Title"]	= 2
data_frame[36]["Text"]	= "1. A/R SW: CYCLE THEN IN"

data_frame[37] = {}
data_frame[37]["Title"]	= 2
data_frame[37]["Text"]	= "##IF PROBE REMAINS OUT"

data_frame[38] = {}
data_frame[38]["Title"]	= 2
data_frame[38]["Text"]	= "2. DO NOT EXCEED 300 KNOTS"

data_frame[39] = {}
data_frame[39]["Title"]	= 2
data_frame[39]["Text"]	= "## IF L TRANS/R TRANS CAUTION COMES ON"

data_frame[40] = {}
data_frame[40]["Title"]	= 2
data_frame[40]["Text"]	= "3. A/R SW: PRESS"

need_to_be_closed = true