local dxgui			= require('dxgui')
local UpdateManager	= require('UpdateManager')

local function blinkWidget(widget, blinkSkin)
	local startTime = os.clock()
	local lastTime = startTime
	
	local validSkin = widget:getSkin()
	local currentSkin = blinkSkin
	
	widget:setSkin(currentSkin)
	dxgui.EnableHighSpeedUpdate(true)
	
	UpdateManager.add(function()
		local delay = 0.08
		local duration = 0.5
		local currTime = os.clock()
		
		if currTime - lastTime > delay then
			if currentSkin == validSkin then
				currentSkin = blinkSkin
			else
				currentSkin = validSkin
			end

			widget:setSkin(currentSkin)
			lastTime = currTime
			
			if currentSkin == validSkin and currTime - startTime > duration then
				dxgui.EnableHighSpeedUpdate(false)
				
				-- удаляем себя из UpdateManager
				return true
			end
		end				
	end)
end

return {
	blinkWidget = blinkWidget,
}