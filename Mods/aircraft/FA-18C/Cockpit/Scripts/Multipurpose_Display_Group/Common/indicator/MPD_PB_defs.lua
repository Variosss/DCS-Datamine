-- PB positions on MPD (in DI)

local TDXLeftPos = -336	--TD - top and down menu
local DYLeftPos = -500
local TYLeftPos = DYLeftPos * -1

local LRYLeftPos = 307	--LR - left and right menu
local LXLeftPos = -500
local RXLeftPos = LXLeftPos * -1

local PB_TextDistBetweenWordsInRow = 169
local PB_TextDistBetweenWordsInColumn = 167

-- global table with precalculated pushbuttons positions (copy/paste fight)
PB_positions = {}
for PBNumber = 1, 20 do
	if PBNumber <= 5 and PBNumber >= 1 then
		PB_positions[PBNumber] = {LXLeftPos, LRYLeftPos - PB_TextDistBetweenWordsInColumn * (5 - PBNumber)}
	elseif PBNumber <= 10 and PBNumber >= 6 then
		PB_positions[PBNumber] = {TDXLeftPos + PB_TextDistBetweenWordsInRow * (PBNumber - 6), TYLeftPos}
	elseif PBNumber <= 15 and PBNumber >= 11 then
		PB_positions[PBNumber] = {RXLeftPos, LRYLeftPos - PB_TextDistBetweenWordsInColumn * (PBNumber - 11)}
	elseif PBNumber <= 20 and PBNumber >= 16 then
		PB_positions[PBNumber] = {TDXLeftPos + PB_TextDistBetweenWordsInRow * (20 - PBNumber), DYLeftPos}
	end
end