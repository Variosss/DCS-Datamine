
	-- AGC - Automatic Gain Control.
preset = 
{
    ID = "MiG-21 R-832",
	
	-- AGC parameter, input signal linear zone, Db
    InputSLZ = 10,
	-- AGC parameter, input signal deviation, Db
	InputSD = 50,
	-- squelch - 'noise cancelling', presence of the feature
    Squelch = true,
	-- frequency step
    Step = 50000,
	-- AGC parameter, output signal deviation, Db
    OutputSD = 5,
	-- AGC parameter, time constant, seconds
    RegulationTime = 0.25,
	
    Ranges = 
    {
		-- Frequency ranges, Hz
		-- Modulation: 0 - AM; 1 - FM	
        [1] = 
        {
			minFreq = 118000000,
            maxFreq = 140000000,
            modulation = 0,
        }, -- end of [1]
		[2] = 
        {
			minFreq = 220000000,
            maxFreq = 390000000,
            modulation = 0,
        }, -- end of [2]
		
    }, -- end of Ranges
	
    Power = 
    {-- Transmitter poser, Watt, can be a table of values (thus it will be selectable via VOIP UI)
        [1] = 
        {
            value = 25.0,
        }, -- end of [1]
		[2] = 
        {
            value = 50.0,
        }, -- end of [2]
    }, -- end of Power
	
	-- maximum frequency tuning time (to the farthest frequency of the range), seconds
    MaxSearchTime = 4,
	-- frequency tuning accuracy, Hz
    FrequencyAccuracy = 50,
	-- minimum frequency tuning time (to the nearest frequency according to the step), seconds
    MinSearchTime = 0.5,
	

    Guards = 
    {-- List of avaiable guard channels
        [1] = 
        {
            modulation = 0,
            freq = 121500000,
        }, -- end of [1]
    }, -- end of Guards
	
	-- Receiver inner noise, Volts
    InnerNoise = 2.511e-06,
	
    Channels = 
    {	-- List of channels presets, currently not used, as it was considered to be a dynamic parameter, rather than a static setting
	
    }, -- end of Channels
	
    Name = "R-832",
	
    Encryption = 
    {-- describes VOIP UI encryption capability, and the 'crypto key' used by default
        enable = false,
        key = 21,
        present = false,
    }, -- end of Encryption
	
	-- Receiver bandwidth, Hz
    BandWidth = 2 * 25000,
	
} -- end of preset
