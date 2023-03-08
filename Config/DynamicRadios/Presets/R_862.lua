preset = 
{
    Channels = 
    {
    }, -- end of Channels
    Squelch = true,
    Step = 25000,
    OutputSD = 5,
    RegulationTime = 0.25,
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
            maxFreq = 400000000,
            modulation = 0,
            minFreq = 220000000,
        }, -- end of [2]
    }, -- end of Ranges
    Power = 
    {
        [1] = 
        {
            value = 30,
        }, -- end of [1]
    }, -- end of Power
    InputSD = 50,
    Encryption = 
    {
        enable = false,
        key = 1,
        present = true,
    }, -- end of Encryption
    MaxSearchTime = 1.5,
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
    Name = "R-862",
    ID = "R_862",
    InputSLZ = 10,
    InnerNoise = 1.1561e-06,
    BandWidth = 25000,
} -- end of preset
