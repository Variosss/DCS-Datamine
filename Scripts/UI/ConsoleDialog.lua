local DialogLoader			= require('DialogLoader')
local ListBoxItem			= require('ListBoxItem')
local dxgui					= require('dxgui')
local lfs					= require('lfs')

local window_
local listBox_
local comboBox_
local maxListBoxItemCount_ = 250

local callback_ = function(text) 
	-- эта функция будет вызвана после того, 
	-- как пользователь нажмет Enter 
end

local closeCallback_ = function()
	-- эта функция будет вызвана после того, 
	-- как пользователь закроет окно консоли
end

local history_

local function getLogFilename()
	return lfs.writedir() .. '/Logs/console.log'
end

local function loadHistory()
	history_ = {}
	
	local file, err = io.open(getLogFilename(), 'r')
	
	if file then
		local line = file:read('*line')

		while line do
			table.insert(history_, line)
			line = file:read('*line')
		end 
		
		file:close()
	end
end

local function updateHistory(text)
	for i, historyText in ipairs(history_) do
		if text == historyText then
			table.remove(history_, i)
			
			break
		end
	end

	table.insert(history_, text)
	
	local file, err = io.open(getLogFilename(), 'w')	
	
	if file then
		
		for i, historyText in ipairs(history_) do
			file:write(historyText .. '\n')
		end
		
		file:close()
	end
end

local function updateComboBoxList()
	comboBox_:removeAllItems()
	
	local text = comboBox_:getText()
	local textLength = string.len(text) - 1

	for i, historyText in ipairs(history_) do
		if string.sub(historyText, 1, textLength + 1) == text then
			comboBox_:insertItem(ListBoxItem.new(historyText), 0)
		end
	end
end

local function addText(text)
	local item = ListBoxItem.new(text)
	
	listBox_:insertItem(item)
	listBox_:setItemVisible(item)
	
	if listBox_:getItemCount() > maxListBoxItemCount_ then
		listBox_:removeItem(listBox_:getItem(0))
	end
end

local function onEnterButton()
	local text = comboBox_:getText()
	
	comboBox_:setWindowVisible(true)
	
	if '' ~= text then
		updateHistory(text)
		callback_(text)
		comboBox_:setText()
		comboBox_:setWindowVisible(false)
		updateComboBoxList()
	end
end

local function onArrowButton()
	local count = comboBox_:getItemCount()
	local selected = comboBox_:getSelectedItem()
	local index = ''
	if nil ~= selected 	then 
		index = comboBox_:getItemIndex(selected) 
		if index == 0 		then 
			comboBox_:setText(selected:getText()) 
		end	
	end
	-- addText("Items: ".. count .. "  : Index ".. index) --debug
	
end

local function onEscapeButton()
	comboBox_:setText()
	updateComboBoxList()
end

local function create()
	window_		= DialogLoader.spawnDialogFromFile('./Scripts/UI/ConsoleDialog.dlg')
	listBox_	= window_.listBox
	comboBox_	= window_.comboBox
	
	local screenWidth, screenHeigt = dxgui.GetScreenSize()
	local windowWidth, windowHeight = window_:getSize()
	
	window_:setSize(screenWidth, windowHeight)
	
	loadHistory()
	updateComboBoxList()
	
	function window_:onClose()
		closeCallback_()
		self:setVisible(false)
	end
	
	comboBox_:addKeyDownCallback(function(self, keyName, unicode)
		if 		'return'	== keyName then onEnterButton()
		elseif 	'escape'	== keyName then onEscapeButton()
		elseif	'up'		== keyName then onArrowButton()
		elseif	'down'		== keyName then onArrowButton()
		end
	end)
	
	comboBox_:addChangeEditBoxCallback(function(self)
		updateComboBoxList()
		comboBox_:setWindowVisible(true)
	end)
end

local function kill()
	window_:kill()
	window_ = nil
end

local function show()	
	window_:setVisible(true)
	comboBox_:setFocused(true)
end

local function hide()
	window_:setVisible(false)
end

local function getVisible()
	return window_:getVisible()
end

local function setCallback(callback)
	callback_ = callback
end

local function setCloseCallback(callback)
	closeCallback_ = callback
end


local function clear()
	listBox_:clear()
end

local function addHistoryText(text)
	updateHistory(text)
	updateComboBoxList()
end

local function clearHistory()
	history_ = {}
	comboBox_:clear()
end

local function setPrompt(text)
	window_.staticPrompt:setText(text)
end

local function setPosition(x, y)
	window_:setPosition(x, y)
end

local function setSize(w, h)
	window_:setSize(w, h)
end

return {
	create				= create,
	kill				= kill,
	show				= show,
	hide				= hide,
	getVisible			= getVisible,
	setCallback			= setCallback,
	setCloseCallback	= setCloseCallback,
	addText				= addText,
	clear				= clear,
	addHistoryText		= addHistoryText,
	clearHistory		= clearHistory,
	setPrompt			= setPrompt,
	setPosition			= setPosition,
	setSize				= setSize,
}