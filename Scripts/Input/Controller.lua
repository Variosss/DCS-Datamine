local InputData		= require('Input.Data')

local view_

local function setView(view)
	view_ = view
end

local function inputDataSaved()
	if view_ then
		view_:onInputDataSaved()
	end
end

local function inputDataRestored()
	if view_ then
		view_:onInputDataRestored()
	end
end

return {
	setView				= setView,
	saveChanges			= InputData.saveChanges,
	undoChanges			= InputData.undoChanges,
	inputDataSaved		= inputDataSaved,
	inputDataRestored	= inputDataRestored,
}