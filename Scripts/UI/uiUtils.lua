local base = _G
--module('ui_utils') --singleton!

local speech = base.require('speech')

function getUnitCallsign(unit)
    local pCommunicator = unit:getCommunicator()
    local selfCoalition = unit:getCoalition()
	
    if pCommunicator == nil or selfCoalition == nil then return "" end
    
	local callsignStr = speech.protocols[(speech.protocolByCountry[selfCoalition] or speech.defaultProtocol)]:makeCallsignString(pCommunicator)
    return callsignStr or ""
end
