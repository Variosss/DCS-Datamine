local gettext = require("i_18n")
_ = gettext.translate

data_frame = {}

data_frame[1] = {}
data_frame[1]["Title"]	= 1
data_frame[1]["Text"]	= " 1. GENERATOR SWITCH: CYCLE"

data_frame[2] = {}
data_frame[2]["Title"]	= 1
data_frame[2]["Text"]	= "## IF GEN RESETS: CONTINUE FLIGHT"

data_frame[3] = {}
data_frame[3]["Title"]	= 1
data_frame[3]["Text"]	= "## IF CONDITION REMAINS"

data_frame[4] = {}
data_frame[4]["Title"]	= 1
data_frame[4]["Text"]	= " 2. MFS: SELECT"

data_frame[5] = {}
data_frame[5]["Title"]	= 1
data_frame[5]["Text"]	= " 3. GENERATOR SWITCH: OFF"

data_frame[6] = {}
data_frame[6]["Title"]	= 1
data_frame[6]["Text"]	= " 4. APU SWITCH: ON"

data_frame[7] = {}
data_frame[7]["Title"]	= 1
data_frame[7]["Text"]	= "## IF APU COMES ONLINE"

data_frame[8] = {}
data_frame[8]["Title"]	= 1
data_frame[8]["Text"]	= " 5. MFS: AS REQUIRED"

data_frame[9] = {}
data_frame[9]["Title"]	= 1
data_frame[9]["Text"]	= "## IF APU GEN CAUTION COMES ON"

data_frame[10] = {}
data_frame[10]["Title"]	= 1
data_frame[10]["Text"]	= " 6. APU SWITCH: RESET THEN ON"

data_frame[11] = {}
data_frame[11]["Title"]	= 1
data_frame[11]["Text"]	= "## IF APU GEN LIGHT STILL ON"

data_frame[12] = {}
data_frame[12]["Title"]	= 1
data_frame[12]["Text"]	= " 7. APU SWITCH: OFF"

data_frame[13] = {}
data_frame[13]["Title"]	= 1
data_frame[13]["Text"]	= " 8. NON ESSENTIAL DC EQP: OFF"

data_frame[14] = {}
data_frame[14]["Title"]	= 1
data_frame[14]["Text"]	= " 9. LDG GEAR: DOWN AS SOON AS POSSIBLE"

data_frame[15] = {}
data_frame[15]["Title"]	= 1
data_frame[15]["Text"]	= "10. STOL FLAPS: BELOW 165 KTS AND NOZZLES LESS"

data_frame[16] = {}
data_frame[16]["Title"]	= 1
data_frame[16]["Text"]	= "    THAN 25 DEGS."

data_frame[17] = {}
data_frame[17]["Title"]	= 1
data_frame[17]["Text"]	= "11. FUEL BST PUMPS SW: DC BEFORE LANDING"

data_frame[18] = {}
data_frame[18]["Title"]	= 1
data_frame[18]["Text"]	= "12. LAND AS SOON AS PRACTICABLE"

need_to_be_closed = true