dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
--dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")
--dofile(LockOn_Options.common_script_path.."tools.lua")

local xsize = 64
local ysize = 64

fontdescription_5mmbluegelpen = {
    textures = {"Fonts/font_5mmbluegelpencapitals_EN.dds",},
    size = {16, 16},
    resolution = {1024, 1024},
    default = {64, 64},
    chars = {
        -- ROW 1 --
        {symbol[' '], 64, ysize}, -- gap
        {symbol['1'], 29, ysize}, -- 1
        {256, 35, ysize}, -- 1
        {257, 50, ysize}, -- 1
        {258, 33, ysize}, -- 1
        {259, 43, ysize}, -- 1
        {260, 47, ysize}, -- 1
        {261, 11, ysize}, -- 1
        {262, 41, ysize}, -- 1
        {symbol['2'], 43, ysize}, -- 2
        {263, 41, ysize}, -- 2
        {264, 46, ysize}, -- 2
        {symbol['3'], 48, ysize}, -- 3
        {265, 44, ysize}, -- 3
        {266, 36, ysize}, -- 3
        {267, 47, ysize}, -- 3

        -- ROW 2 --
        {268, 38, ysize}, -- 3
        {symbol['4'], 57, ysize}, -- 4
        {269, 41, ysize}, -- 4
        {270, 47, ysize}, -- 4
        {271, 46, ysize}, -- 4
        {272, 41, ysize}, -- 4
        {273, 33, ysize}, -- 4
        {274, 47, ysize}, -- 4
        {symbol['5'], 44, ysize}, -- 5
        {275, 31, ysize}, -- 5
        {276, 50, ysize}, -- 5
        {277, 49, ysize}, -- 5
        {278, 55, ysize}, -- 5
        {symbol['6'], 43, ysize}, -- 6
        {279, 37, ysize}, -- 6
        {280, 35, ysize}, -- 6

        -- ROW 3 --
        {281, 37, ysize}, -- 6
        {282, 43, ysize}, -- 6
        {symbol['7'], 41, ysize}, -- 7
        {283, 35, ysize}, -- 7
        {284, 49, ysize}, -- 7
        {285, 43, ysize}, -- 7
        {286, 43, ysize}, -- 7
        {symbol['8'], 40, ysize}, -- 8
        {287, 35, ysize}, -- 8
        {288, 38, ysize}, -- 8
        {289, 37, ysize}, -- 8
        {290, 47, ysize}, -- 8
        {symbol['9'], 38, ysize}, -- 9
        {291, 36, ysize}, -- 9
        {292, 30, ysize}, -- 9
        {293, 37, ysize}, -- 9

        -- ROW 4 --
        {294, 35, ysize}, -- 9
        {symbol['0'], 45, ysize}, -- 0
        {295, 44, ysize}, -- 0
        {296, 35, ysize}, -- 0
        {297, 36, ysize}, -- 0
        {298, 39, ysize}, -- 0
        {symbol['.'], 23, ysize}, -- .
        {299, 9, ysize}, -- .
        {300, 15, ysize}, -- .
        {301, 12, ysize}, -- .
        {symbol[','], 33, ysize}, -- ,
        {302, 18, ysize}, -- ,
        {303, 20, ysize}, -- ,
        {304, 13, ysize}, -- ,
        {symbol['-'], 43, ysize}, -- -
        {symbol['+'], 36, ysize}, -- +

        -- ROW 5 --
        {symbol['/'], 44, ysize}, -- /
        {305, 50, ysize}, -- /
        {symbol['\\'], 41, ysize}, -- \
        {306, 39, ysize}, -- \
        {symbol['|'], 37, ysize}, -- div
        {307, 41, ysize}, -- div
        {symbol['*'], 43, ysize}, -- mul
        {308, 36, ysize}, -- mul
        {symbol['('], 35, ysize}, -- (
        {309, 29, ysize}, -- (
        {symbol[')'], 31, ysize}, -- )
        {310, 30, ysize}, -- )
        {symbol['%'], 44, ysize}, -- %
        {311, 49, ysize}, -- %
        {symbol["'"], 28, ysize}, -- '
        {symbol['"'], 20, ysize}, -- "

        -- ROW 6 --
        {312, 25, ysize}, -- "
        {symbol[':'], 17, ysize}, -- :
        {313, 21, ysize}, -- :
        {symbol[';'], 20, ysize}, -- ;
        {314, 23, ysize}, -- ;
        {latin['x'], xsize, ysize}, -- XXX
        {315, xsize, ysize}, -- XXX
        {316, xsize, ysize}, -- XXX
        {317, xsize, ysize}, -- XXX
        {latin['v'], xsize, ysize}, -- vvv
        {318, xsize, ysize}, -- vvv
        {319, xsize, ysize}, -- vvv
        {320, xsize, ysize}, -- vvv
        {latin['q'], 49, ysize}, -- <<
        {latin['r'], xsize, ysize}, -- ret
        {latin['p'], 44, ysize}, -- >>

        -- ROW 7 --
        {latin['a'], 44, ysize}, -- --
        {321, 61, ysize}, -- --
        {322, 44, ysize}, -- --
        {323, 58, ysize}, -- --
        {324, 38, ysize}, -- --
        {325, 46, ysize}, -- --
        {326, 61, ysize}, -- --
        {327, 49, ysize}, -- --
        {latin['i'], 25, ysize}, -- ..      25 lmargin 2
        {328, 31, ysize}, -- ..      31 lmargin 5
        {329, 26, ysize}, -- ..      26 lmargin 4
        {330, 25, ysize}, -- ..      25 lmargin 4
        {331, 17, ysize}, -- ..      17 lmargin 4
        {332, 24, ysize}, -- ..      24-25 lmagrin 8
        {333, 30, ysize}, -- ..      29-30 lmargin 6
        {334, 26, ysize}, -- ..      26 lmargin 8

        -- ROW 8 --
        {latin['A'], 48, ysize}, -- A
        {335, 41, ysize}, -- A
        {336, 35, ysize}, -- A
        {latin['B'], 35, ysize}, -- B
        {337, 38, ysize}, -- B
        {338, 41, ysize}, -- B
        {latin['C'], 44, ysize}, -- C
        {339, 38, ysize}, -- C
        {340, 40, ysize}, -- C
        {latin['D'], 39, ysize}, -- D
        {341, 38, ysize}, -- D
        {342, 37, ysize}, -- D
        {latin['E'], 47, ysize}, -- E
        {343, 41, ysize}, -- E
        {344, 42, ysize}, -- E
        {latin['F'], 46, ysize}, -- F

        -- ROW 9 --
        {345, 37, ysize}, -- F
        {346, 34, ysize}, -- F
        {latin['G'], 42, ysize}, -- G
        {347, 39, ysize}, -- G
        {348, 44, ysize}, -- G
        {latin['H'], 44, ysize}, -- H
        {349, 39, ysize}, -- H
        {350, 41, ysize}, -- H
        {latin['I'], 27, ysize}, -- I
        {351, 20, ysize}, -- I
        {352, 21, ysize}, -- I
        {latin['J'], 45, ysize}, -- J
        {353, 44, ysize}, -- J
        {354, 43, ysize}, -- J
        {latin['K'], 49, ysize}, -- K
        {355, 49, ysize}, -- K

        -- ROW 10 --
        {356, 43, ysize}, -- K
        {latin['L'], 47, ysize}, -- L
        {357, 43, ysize}, -- L
        {358, 51, ysize}, -- L
        {latin['M'], 48, ysize}, -- M
        {359, 44, ysize}, -- M
        {360, 45, ysize}, -- M
        {latin['N'], 44, ysize}, -- N
        {361, 47, ysize}, -- N
        {latin['n'], 43, ysize}, -- n
        {latin['O'], 43, ysize}, -- O
        {362, 35, ysize}, -- O
        {363, 39, ysize}, -- O
        {latin['P'], 35, ysize}, -- P
        {364, 33, ysize}, -- P
        {365, 36, ysize}, -- P

        -- ROW 11 --
        {latin['Q'], 36, ysize}, -- Q
        {366, 37, ysize}, -- Q
        {367, 38, ysize}, -- q
        {latin['R'], 50, ysize}, -- R
        {368, 43, ysize}, -- R
        {369, 37, ysize}, -- R
        {latin['S'], 39, ysize}, -- S
        {370, 25, ysize}, -- S
        {371, 43, ysize}, -- S
        {latin['T'], 58, ysize}, -- T
        {372, 53, ysize}, -- T
        {373, 58, ysize}, -- T
        {latin['U'], 47, ysize}, -- U
        {374, 43, ysize}, -- U
        {375, 46, ysize}, -- U
        {latin['V'], 55, ysize}, -- V

        -- ROW 12 --
        {376, 47, ysize}, -- V
        {377, 46, ysize}, -- V
        {latin['W'], 53, ysize}, -- W
        {378, 51, ysize}, -- W
        {379, 53, ysize}, -- W
        {latin['X'], 40, ysize}, -- X
        {380, 46, ysize}, -- X
        {381, 49, ysize}, -- X
        {latin['Y'], 39, ysize}, -- Y
        {382, 40, ysize}, -- Y
        {383, 38, ysize}, -- Y
        {latin['Z'], 43, ysize}, -- Z
        {384, 43, ysize}, -- Z
        {385, 39, ysize}, -- Z
        {euro_spec['Ö'], 40, ysize}, -- oo
        {386, 41, ysize}, -- oo

        -- ROW 13 --
        {latin['c'], 43, ysize}, -- Ch
        {387, 46, ysize}, -- Ch
        {euro_spec['Ñ'], 54, ysize}, -- nn
        {388, 42, ysize}, -- nn
        {euro_spec['É'], 46, ysize}, -- ee
        {389, 41, ysize}, -- ee
        {euro_spec['Ü'], 41, ysize}, -- uu
        {390, 43, ysize}, -- uu
        {euro_spec['Ä'], 38, ysize}, -- aa
        {391, 40, ysize}, -- aa

        -- ROW 14 --
        -- ROW 15 --
        -- ROW 16 --
    },
}
