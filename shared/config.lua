Config = {}

Config.MinimumPolice = 0 -- Minimum Police Required to rob

Config.ResetTime = 900 -- in seconds Example: 900 seconds would be a 15 minute cooldown

--Items required
Config.RegisterItem = 'lockpick'
Config.ComputerItem = 'trojan_usb'
Config.SafeItem = 'thermite'

--Payouts
Config.PayoutItem = 'black_money'
Config.MinAmount = '250'
Config.MaxAmount = '450'

Config.Debug = false -- true/false to enable debug. Mainly to show polyzones. Uses heavy resources while debug is enabled due to the large zones.

Config.Dispatch = 'ps' -- 'ps' for Project Sloth Dispatch or 'cd' for Codedesign Dispatch

Config.SpecialChance = 5 -- Chance of finding a "Valuable" in the register. Example: 10 = 10%

Config.SpecialItems = { -- Valuable Items. You can add or remove whatever you want
    'goldchain',
    'rolex',
    'diamond_ring',
    'goldbar',
}

Config.Registers = {
    [1] = {coords = vector4(-47.24, -1757.65, 29.53, 50), robbed = false, time = 0},
    [2] = {coords = vector4(-48.58, -1759.21, 29.59, 50), robbed = false, time = 0},
    [3] = {coords = vector4(-706.63, -915.72, 19.32, 90.0), robbed = false, time = 0},
    [4] = {coords = vector4(-706.63, -913.68, 19.32, 90.0), robbed = false, time = 0},
    [5] = {coords = vector4(24.94, -1344.95, 29.61, 270.0), robbed = false, time = 0},
    [6] = {coords = vector4(24.94, -1347.28, 29.61, 270.0), robbed = false, time = 0},
    [7] = {coords = vector4(1164.55, -324.89, 69.31, 100.00), robbed = false, time = 0},
    [8] = {coords = vector4(1164.20, -322.89, 69.31, 100.00), robbed = false, time = 0},
    [9] = {coords = vector4(373.59, 328.58, 103.68, 255.88), robbed = false, time = 0},
    [10] = {coords = vector4(373.02, 326.32, 103.68, 255.88), robbed = false, time = 0},
    [11] = {coords = vector4(-1819.09, 792.31, 138.20, 132.46), robbed = false, time = 0},
    [12] = {coords = vector4(-1820.46, 793.81, 138.21, 132.46), robbed = false, time = 0},
    [13] = {coords = vector4(-3041.35, 584.26, 8.02, 17.75), robbed = false, time = 0},
    [14] = {coords = vector4(-3039.13, 584.97, 8.02, 17.75), robbed = false, time = 0},
    [15] = {coords = vector4(-3244.57, 1000.65, 12.94, 355.07), robbed = false, time = 0},
    [16] = {coords = vector4(-3242.24, 1000.45, 12.94, 355.07), robbed = false, time = 0},
    [17] = {coords = vector4(548.90, 2668.94, 42.27, 97.49), robbed = false, time = 0},
    [18] = {coords = vector4(548.59, 2671.25, 42.27, 97.49), robbed = false, time = 0},
    [19] = {coords = vector4(2676.21, 3280.96, 55.35, 330.87), robbed = false, time = 0},
    [20] = {coords = vector4(2678.25, 3279.83, 55.35, 330.87), robbed = false, time = 0},
    [21] = {coords = vector4(1959.32, 3742.28, 32.45, 300.0), robbed = false, time = 0},
    [22] = {coords = vector4(1960.48, 3740.26, 32.45, 300.0), robbed = false, time = 0},
    [23] = {coords = vector4(1729.32, 6417.12, 35.15, 243.64), robbed = false, time = 0},
    [24] = {coords = vector4(1728.29, 6415.03, 35.15, 243.64), robbed = false, time = 0},
}

Config.Computers = {
    [1] = {coords = vector4(-44.88, -1748.81, 29.22, 49.98), hacked = false, time = 0},
    [2] = {coords = vector4(-710.55, -905.41, 19.01, 90.0), hacked = false, time = 0},
    [3] = {coords = vector4(29.55, -1338.37, 29.37, 355.00), hacked = false, time = 0},
    [4] = {coords = vector4(1158.91, -315.42, 69.00, 100.00), hacked = false, time = 0},
    [5] = {coords = vector4(379.67, 333.84, 103.44, 340.88), hacked = false, time = 0},
    [6] = {coords = vector4(-1828.94, 797.26, 138.00, 132.46), hacked = false, time = 0},
    [7] = {coords = vector4(-3049.03, 586.65, 7.78, 102.75), hacked = false, time = 0},
    [8] = {coords = vector4(-3250.73, 1005.81, 12.70, 80.07), hacked = false, time = 0},
    [9] = {coords = vector4(545.18, 2661.81, 42.03, 182.50), hacked = false, time = 0},
    [10] = {coords = vector4(2672.70, 3288.20, 55.11, 55.87), hacked = false, time = 0},
    [11] = {coords = vector4(1960.02, 3750.29, 32.21, 25.00), hacked = false, time = 0},
    [12] = {coords = vector4(1736.38, 6420.97, 34.91, 328.64), hacked = false, time = 0},
}

Config.Safes = {
    [1] = {coords = vector4(-43.93, -1747.95, 28.80, 320.0), blown = false, time = 0},
    [2] = {coords = vector4(-710.35, -904.18, 18.66, 0.0), blown = false, time = 0},
    [3] = {coords = vector4(28.17, -1338.53, 28.92, 0.0), blown = false, time = 0},
    [4] = {coords = vector4(1158.96, -314.16, 68.71, 10.0), blown = false, time = 0},
    [5] = {coords = vector4(378.3, 333.94, 102.98, 345.0), blown = false, time = 0},
    [6] = {coords = vector4(-1829.65, 798.28, 137.67, 313.0), blown = false, time = 0},
    [7] = {coords = vector4(-3048.42, 585.43, 7.31, 17.0), blown = false, time = 0},
    [8] = {coords = vector4(-3250.69, 1004.43, 12.23, 355.0), blown = false, time = 0},
    [9] = {coords = vector4(546.52, 2662.18, 41.71, 7.0), blown = false, time = 0},
    [10] = {coords = vector4(2672.22, 3286.92, 54.74, 331.0), blown = false, time = 0},
    [11] = {coords = vector4(1958.91, 3749.44, 31.84, 30.0), blown = false, time = 0},
    [12] = {coords = vector4(1735.03, 6421.34, 34.54, 334.0), blown = false, time = 0},
}

Config.MaleFingerprints = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true,
}
Config.FemaleFingerprints = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true,
}