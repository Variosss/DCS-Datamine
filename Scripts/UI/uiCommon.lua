local base = _G

module('UICommon')

local isMetric

function reset()
	isMetric = nil
end

function isMetricSystem()
	if isMetric == nil then
		local difficulty = base.require('Options.Data').readDifficultyFromFile()
		
		if difficulty and difficulty.units then
			isMetric = difficulty.units ~= 'imperial' -- 'imperial' is default
		else
			isMetric = false
		end
	end

	return isMetric
end