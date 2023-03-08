preset = 
{
    Encryption = 
    {
        enable = false,
        key = 1,
        present = true,
    }, -- end of Encryption
    Squelch = true,
    Step = 5000,
    OutputSD = 5,
    ID = "ARC_210_2",
    Ranges = 
    {
        [1] = 
        {
            minFreq = 30000000,
            maxFreq = 87975000,
            modulation = 1,
        }, -- end of [1]
        [2] = 
        {
            minFreq = 108000000,
            maxFreq = 115975000,
            modulation = 0,
        }, -- end of [2]
        [3] = 
        {
            minFreq = 118000000,
            maxFreq = 173975000,
            modulation = 0,
        }, -- end of [3]
        [4] = 
        {
            minFreq = 225000000,
            maxFreq = 399975000,
            modulation = 0,
        }, -- end of [3]
    }, -- end of Ranges
	
	-- Transmitter poser, Watt, can be a table of values (thus it will be selectable via VOIP UI)
    Power = 
    {
        [1] = 
        {
            value = 10,
        }, -- end of [1]
    }, -- end of Power
    InputSD = 50,
    InputSLZ = 10,
    MaxSearchTime = 0,
    FrequencyAccuracy = 500,
	MinSearchTime = 0,
    Guards = 
    {
        [1] = 
        {
            modulation = 0,
            freq = 243000000,
        }, -- end of [1]
    }, -- end of Guards
    InnerNoise = 1.1561e-06,
    Name = "ARC-210",
    RegulationTime = 0.25,
	
    Channels = 
    {        
    }, -- end of Channels
    BandWidth = 12000,
} -- end of preset
