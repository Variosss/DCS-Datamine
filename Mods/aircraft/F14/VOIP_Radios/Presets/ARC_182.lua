-- Notes
--
-- AGC - Automatic Gain Control.
-- Refer to global presets for possible values of AGC parameters. ARC-164 can be used as a good average, suitable for most cases.
-- Also refer to AGC_excerpt.cpp example if custom AGC tuning is still needed.

preset = 
{
	-- describes VOIP UI encryption capability, and the 'crypto key' used by default
    Encryption = 
    {
		-- default state at the moment of cockpit entry
        enable = false,
		-- 'crypto key'
        key = 1,
		-- principal presence of the feature
        present = true,
    }, -- end of Encryption
	-- squelch - 'noise cancelling', presence of the feature
    Squelch = true,
	-- frequency step
    Step = 25000,
	-- AGC parameter, output signal deviation, Db
    OutputSD = 5,
	-- The radio ID
    ID = "ARC_182",
	-- Frequency ranges, Hz
	-- Modulation: 0 - AM; 1 - FM
    Ranges = 
    {
        [1] = 
        {
            maxFreq = 87975000,
            modulation = 1,
            minFreq = 30000000,
        },
        [2] = 
        {
            maxFreq = 155975000,
            modulation = 0,
            minFreq = 108000000,
        },
        [3] = 
        {
            maxFreq = 173975000,
            modulation = 1,
            minFreq = 156000000,
        },
        [4] = 
        {
            maxFreq = 399975000,
            modulation = 0,
            minFreq = 225000000,
        },
        [5] = 
        {
            maxFreq = 399975000,
            modulation = 1,
            minFreq = 225000000,
        },
    }, -- end of Ranges
	-- Transmitter poser, Watt, can be a table of values (thus it will be selectable via VOIP UI)
    Power = 
    {
        [1] = 
        {
            value = 10,
        }, -- end of [1]
    }, -- end of Power
	-- AGC parameter, input signal deviation, Db
    InputSD = 50,
	-- AGC parameter, input signal linear zone, Db
    InputSLZ = 10,
	-- maximum frequency tuning time (to the farthest frequency of the range), seconds
    MaxSearchTime = 0,
	-- frequency tuning accuracy, Hz
    FrequencyAccuracy = 1000,
	-- minimum frequency tuning time (to the nearest frequency according to the step), seconds
	MinSearchTime = 0,
	-- List of avaiable guard channels
    Guards = 
    {
        [1] = 
        {
            modulation = 1,
            freq = 40500000,
        },
        [2] = 
        {
            modulation = 0,
            freq = 121500000,
        },
        [3] = 
        {
            modulation = 1,
            freq = 156800000,
        },
        [4] = 
        {
            modulation = 0,
            freq = 243000000,
        },
    }, -- end of Guards
	-- Receiver inner noise, Volts
    InnerNoise = 1.387e-06,
	-- UI name
    Name = "ARC-182",
	-- AGC parameter, time constant, seconds
    RegulationTime = 0.25,
	-- List of channels presets, currently not used, as it was considered to be a dynamic parameter, rather than a static setting
    Channels = 
    {        
    }, -- end of Channels
	-- Receiver bandwidth, Hz
    BandWidth = 19000,
} -- end of preset
