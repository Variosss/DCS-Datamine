preset = 
{
    InputSLZ = 10,
    Squelch = true,
    Step = 25000,
    OutputSD = 5,
    ID = "ARC_210",
    Ranges = 
    {
        [1] = 
        {
            maxFreq = 88000000,
            modulation = 1,
            minFreq = 30000000,
        }, -- end of [1]
        [2] = 
        {
            maxFreq = 156000000,
            modulation = 0,
            minFreq = 108000000,
        }, -- end of [2]
        [3] = 
        {
            maxFreq = 174000000,
            modulation = 1,
            minFreq = 136000000,
        }, -- end of [3]
        [4] = 
        {
            maxFreq = 400000000,
            modulation = 0,
            minFreq = 225000000,
        }, -- end of [4]
        [5] = 
        {
            maxFreq = 400000000,
            modulation = 1,
            minFreq = 225000000,
        }, -- end of [5]
    }, -- end of Ranges
    Power = 
    {
        [1] = 
        {
            value = 10,
        }, -- end of [1]
    }, -- end of Power
    InputSD = 50,
    Channels = 
    {
    }, -- end of Channels
    MaxSearchTime = 0,
    FrequencyAccuracy = 40,
    MinSearchTime = 0,
    Guards = 
    {
        [1] = 
        {
            modulation = 0,
            freq = 121500000,
        }, -- end of [1]
        [2] = 
        {
            modulation = 0,
            freq = 243000000,
        }, -- end of [2]
    }, -- end of Guards
    InnerNoise = 1.1561e-06,
    Name = "ARC-210",
    Encryption = 
    {
        enable = false,
        key = 1,
        present = true,
    }, -- end of Encryption
    RegulationTime = 0.25,
    BandWidth = 15000,
} -- end of preset
