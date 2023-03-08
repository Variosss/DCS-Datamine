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
    ID = "ARC_222",
    Ranges = 
    {
        [1] = 
        {
            maxFreq = 87975000,
            modulation = 1,
            minFreq = 30000000,
        }, -- end of [1]
        [2] = 
        {
            maxFreq = 155975000,
            modulation = 0,
            minFreq = 116000000,
        }, -- end of [2]
    }, -- end of Ranges
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
            freq = 121500000,
        }, -- end of [1]
    }, -- end of Guards
    InnerNoise = 1.1561e-06,
    Name = "ARC-222",
    RegulationTime = 0.25,
    Channels = 
    {        
    }, -- end of Channels
    BandWidth = 12000,
} -- end of preset
