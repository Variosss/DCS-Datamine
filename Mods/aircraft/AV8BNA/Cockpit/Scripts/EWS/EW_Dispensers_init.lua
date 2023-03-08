local gettext = require("i_18n")
_ = gettext.translate

-- Chaff Burst Values
-- BQTY: 1 to 15. Special values: -1 = Continuous (will use ALL chaff); -2 = Random (will dispense between 1 to 6 chaff)
-- BINT: 0.1 to 1.5 seconds. Special values: -2 = Random (will set an interval between 0.1 and 0.4 seconds)

-- Chaff Salvo Values
-- SQTY: 1 to 15.
-- SINT: 1 to 15 seconds.

-- Flare Salvo Values
-- SQTY: 1 to 15.
-- SINT: 1 to 15 seconds.

--All Expendables
EW_ALL_CHAFF_BQTY = 1;
EW_ALL_CHAFF_BINT = 0.1;
EW_ALL_CHAFF_SQTY = 1;
EW_ALL_CHAFF_SINT = 1;
EW_ALL_FLARES_SQTY = 1;
EW_ALL_FLARES_SINT = 1;

--Chaff Only
EW_CHAFF_BQTY = 1;
EW_CHAFF_BINT = 0.1;
EW_CHAFF_SQTY = 1;
EW_CHAFF_SINT = 1;

--Flares Only
EW_FLARES_SQTY = 1;
EW_FLARES_SINT = 1;

need_to_be_closed = true
