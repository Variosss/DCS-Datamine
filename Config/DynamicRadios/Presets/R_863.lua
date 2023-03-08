preset = 
{
    InputSLZ = 10,
    Squelch = true,
    Step = 25000,
    OutputSD = 5,
    ID = "R_863",
    Ranges = 
    {
        [1] = 
        {
            maxFreq = 150000000,
            modulation = 0,
            minFreq = 100000000,
        }, -- end of [1]
        [2] = 
        {
            maxFreq = 150000000,
            modulation = 1,
            minFreq = 100000000,
        }, -- end of [2]
        [3] = 
        {
            maxFreq = 400000000,
            modulation = 0,
            minFreq = 220000000,
        }, -- end of [3]
        [4] = 
        {
            maxFreq = 400000000,
            modulation = 1,
            minFreq = 220000000,
        }, -- end of [4]
    }, -- end of Ranges
    Power = 
    {
        [1] = 
        {
            value = 8,
        }, -- end of [1]
        [2] = 
        {
            value = 10,
        }, -- end of [2]
    }, -- end of Power
    InputSD = 50,
    Channels = 
    {
    }, -- end of Channels
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
        [2] = 
        {
            modulation = 0,
            freq = 243000000,
        }, -- end of [2]
    }, -- end of Guards
    InnerNoise = 2.511e-06,
    Name = "R-863",
    Encryption = 
    {
        enable = false,
        key = 1,
        present = true,
    }, -- end of Encryption
    RegulationTime = 0.25,
    BandWidth = 25000,
} -- end of preset
