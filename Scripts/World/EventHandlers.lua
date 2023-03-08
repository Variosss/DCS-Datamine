world.eventHandlers = {}

function world.addEventHandler(handler)
	world.eventHandlers[handler] = handler
end

function world.removeEventHandler(handler)
	world.eventHandlers[handler] = nil
end

function world.onEvent(event)
	for index, handler in pairs(world.eventHandlers) do
		handler:onEvent(event)
	end
end
