return {
	keyCommands = {
--[[	
		{combos = {{key = 'Z'}}, down = iCommandViewBookmarksEditor, name = _('Camera bookmarks editor'), category =  _('View')},
		{combos = {{key = 'M'}}, down = iCommandViewMainMenuBar, name = _('Camera main menu bar'), category =  _('View')},
		{combos = {{key = 'H', reformers = {'LAlt'}}}, down = iCommandViewCameraMoveHorizontal, name = _('Horizontal camera moving'), category = _('View')},
		{combos = {{key = 'V', reformers = {'LAlt'}}}, down = iCommandViewCameraMoveVertical, name = _('Vertical camera moving'), category = _('View')},
		{combos = {{key = 'F', reformers = {'LAlt'}}}, down = iCommandViewCameraMoveFrontal, name = _('Frontal camera moving'), category = _('View')},
		{combos = {{key = 'G', reformers = {'LAlt'}}}, down = iCommandViewAtGround, name = _('Direct the camera towards the ground'), category = _('View')},
		{combos = {{key = 'N', reformers = {'LAlt'}}}, down = iCommandViewCameraWorldAxes, name = _('Direct the camera along world axes'), category = _('View')},
		-- Camera position to clipboard 
		{combos = {{key = 'C', reformers = {'LShift'}}}, down = iCommandViewCameraToClipboard, name = _('Unload camera position to clipboard'), category = _('View')},
		-- Dummy WASD keys for disable them in other layers
		{combos = {{key = 'W'}}, pressed = iCommandViewKeyW, name = _('Forward key W'), category = _('View')},
		{combos = {{key = 'S'}}, pressed = iCommandViewKeyS, name = _('Backward key S'), category = _('View')},
		{combos = {{key = 'A'}}, pressed = iCommandViewKeyA, name = _('Left key A'), category = _('View')},
		{combos = {{key = 'D'}}, pressed = iCommandViewKeyD, name = _('Right key D'), category = _('View')},
		{combos = {{key = 'W', reformers = {'LShift'}}}, pressed = iCommandViewKeyLShiftW, name = _('Fast forward key LShift-W'), category = _('View')},
		{combos = {{key = 'S', reformers = {'LShift'}}}, pressed = iCommandViewKeyLShiftS, name = _('Fast backward key LShift-S'), category = _('View')},
		{combos = {{key = 'A', reformers = {'LShift'}}}, pressed = iCommandViewKeyLShiftA, name = _('Fast left key LShift-A'), category = _('View')},
		{combos = {{key = 'D', reformers = {'LShift'}}}, pressed = iCommandViewKeyLShiftD, name = _('Fast right key LShift-D'), category = _('View')},
		{combos = {{key = 'W', reformers = {'LCtrl'}}}, pressed = iCommandViewKeyLCtrlW, name = _('Slow forward key LCtrl-W'), category = _('View')},
		{combos = {{key = 'S', reformers = {'LCtrl'}}}, pressed = iCommandViewKeyLCtrlS, name = _('Slow backward key LCtrl-S'), category = _('View')},
		{combos = {{key = 'A', reformers = {'LCtrl'}}}, pressed = iCommandViewKeyLCtrlA, name = _('Slow left key LCtrl-A'), category = _('View')},
		{combos = {{key = 'D', reformers = {'LCtrl'}}}, pressed = iCommandViewKeyLCtrlD, name = _('Slow right key LCtrl-D'), category = _('View')},
--]]		
	},
}
