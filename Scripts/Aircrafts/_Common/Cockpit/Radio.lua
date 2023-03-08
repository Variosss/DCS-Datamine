-- U - is signal amplitude in volts for the given SNNRdB
-- SNNRdB means - (signal + noise) / noise, in decibels
function getInnerNoise(U, SNNRdB)
	return U / (math.pow(10.0, SNNRdB / 20.0) - 1)
end

function rangeUtoDb(Umin, Umax)
	return 20 * math.log10(Umax / Umin)
end