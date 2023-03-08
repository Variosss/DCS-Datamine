-- Модуль для вызова функций, которые должны выполняться на каждом кадре
-- если функция возвращает true, то после своего выполнения она будет удалена из UpdateManager.
-- Это удобный механизм для однократного выполнения какой-либо функции,
-- которая не может быть выполнена сразу, а должна быть выполнена "откуда-то извне".
local updaters_ = {}
local updatersToDelete_
local insideUpdate_ = false

local function deleteUpdaters_()
	if updatersToDelete_ then
		count = #updaters_
		
		for i = count, 1, -1 do 
			local updater = updaters_[i]
			
			if updatersToDelete_[updater] then
				table.remove(updaters_, i)
			end
		end
		
		updatersToDelete_ = nil
	end
end

local function findUpdater_(updaterToFind)
	for i, updater in ipairs(updaters_) do
		if updaterToFind == updater then
			return i
		end
	end
end

local function delete(updater)
	if findUpdater_(updater) then
		updatersToDelete_ = updatersToDelete_ or {}
		updatersToDelete_[updater] = true	
	end
end

local function update()
	if insideUpdate_ then
		return
	end
	
	insideUpdate_ = true
	
	deleteUpdaters_()
	
	local count = #updaters_
	
	if count > 0 then
		-- работаем с копией updaters,
		-- поскольку во время вызова функций в UpdateManager могут добавляться новые функции
		local updaters = {}
		
		for i, updater in ipairs(updaters_) do
			table.insert(updaters, updater)
		end
		
		for i = 1, count do
			local updater = updaters[i]
			
			if updater then
				if updater() then
					delete(updater)
				end
			end
		end
		
		deleteUpdaters_()
	end
	
	insideUpdate_ = false
end

local function add(updater)
	if not findUpdater_(updater) then
		table.insert(updaters_, updater)
	end	
end

return {
	add		= add,
	delete	= delete,
	update	= update,
}