preset = 
{
    Channels = 
    {
    }, -- end of Channels
    Squelch = true,
    Step = 25000,
    OutputSD = 9,
    ID = "ground_radio",
    Ranges = 
    {
        [1] = 
        {
            maxFreq = 400000000,
            modulation = 0,
            minFreq = 225000000,
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
    RegulationTime = 0.25,
    Encryption = 
    {
        enable = false,
        key = 1,
        present = true,
    }, -- end of Encryption
    Name = "Ground radio",
    BandWidth = 22000,
} -- end of preset
