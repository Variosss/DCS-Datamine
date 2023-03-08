preset = 
{
    Channels = 
    {
    }, -- end of Channels
    Squelch = true,
    Step = 25000,
    OutputSD = 5,
    ID = "R_800",
    Ranges = 
    {
        [1] = 
        {
            maxFreq = 400000000,
            modulation = 0,
            minFreq = 100000000,
        }, -- end of [1]
        [2] = 
        {
            maxFreq = 400000000,
            modulation = 1,
            minFreq = 100000000,
        }, -- end of [2]
    }, -- end of Ranges
    Power = 
    {
        [1] = 
        {
            value = 16,
        }, -- end of [1]
        [2] = 
        {
            value = 25,
        }, -- end of [2]
    }, -- end of Power
    InputSD = 50,
    InputSLZ = 10,
    MaxSearchTime = 0,
    FrequencyAccuracy = 1000,
    MinSearchTime = 0,
    Guards = 
    {
        [1] = 
        {
            modulation = 0,
            freq = 121500000,
        }, -- end of [1]
    }, -- end of Guards
    InnerNoise = 2.511e-06,
    RegulationTime = 0.25,
    Encryption = 
    {
        enable = false,
        key = 1,
        present = true,
    }, -- end of Encryption
    Name = "R-800",
    BandWidth = 25000,
} -- end of preset
