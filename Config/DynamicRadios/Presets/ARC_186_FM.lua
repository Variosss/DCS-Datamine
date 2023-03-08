preset = 
{
    InputSLZ = 10,
    Squelch = true,
    Step = 25000,
    OutputSD = 5,
    ID = "ARC_186_FM",
    Ranges = 
    {
        [1] = 
        {
            maxFreq = 88000000,
            modulation = 1,
            minFreq = 30000000,
        }, -- end of [1]
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
    FrequencyAccuracy = 2000,
    MinSearchTime = 0,
    Guards = 
    {
        [1] = 
        {
            modulation = 1,
            freq = 40500000,
        }, -- end of [1]
    }, -- end of Guards
    InnerNoise = 3.468e-06,
    Name = "ARC-186-VHF-FM",
    Encryption = 
    {
        enable = false,
        key = 1,
        present = true,
    }, -- end of Encryption
    RegulationTime = 0.25,
    BandWidth = 19000,
} -- end of preset
