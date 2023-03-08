local ui		= _('UI')
local vr		= _('VR')
local general	= _('General')

local  ADD_FAKE_VR = false

local ret_val  = {
keyCommands = 
{
	{category = ui, down = iCommand_UILayer_MouseLeftButton	, up = iCommand_UILayer_MouseLeftButton	, value_down = 1.0, value_up = 0.0	, name = _('as left mouse button'				)},
	{category = ui, down = iCommand_UILayer_MouseRightButton, up = iCommand_UILayer_MouseRightButton, value_down = 1.0, value_up = 0.0	, name = _('as right mouse button'				)},
	{category = ui, down = iCommand_UILayer_MouseWheelFwd	, up = iCommand_UILayer_MouseWheelFwd	, value_down = 1.0, value_up = 0.0	, name = _('as mouse wheel forward'				)},
	{category = ui, down = iCommand_UILayer_MouseWheelBwd	, up = iCommand_UILayer_MouseWheelBwd	, value_down = 1.0, value_up = 0.0	, name = _('as mouse wheel backward'			)},
	{category = vr, down = iHeadTrackerZoomToggle			, up = iHeadTrackerZoomToggle			, value_down = 1.0, value_up = 0.0	, name = _('toggle VR Zoom'						)},
    {category = vr, down = iHeadTrackerSpyglassZoomToggle	, up = iHeadTrackerSpyglassZoomToggle	, value_down = 1.0, value_up = 0.0	, name = _('toggle VR Spyglass Zoom'			)},
	{category = vr, down = iHeadTrackerPosReset																							, name = _('recenter VR Headset'				)},
	{category = vr, down = iHeadTrackerLeftHandEnable		, up = iHeadTrackerLeftHandEnable		, value_down = 1.0, value_up = 0.0	, name = _('VR, left hand (enable/disable)'		)},
	{category = vr, down = iHeadTrackerRightHandEnable		, up = iHeadTrackerRightHandEnable		, value_down = 1.0, value_up = 0.0	, name = _('VR, right hand (enable/disable)'	)},
	
	{category = general	, down = iCommandScreenShot 																					, name = _('Make Screenshot'					)},
	{category = general	, down = iCommandQuit																							, name = _('End mission'						)},
	{category = general	, down = iCommandAccelerate																						, name = _('Time accelerate'					)},
	{category = general	, down = iCommandDecelerate																						, name = _('Time decelerate'					)},
	{category = general	, down = iCommandNoAcceleration																					, name = _('Time normal'						)},
	{category = general	, down = iCommandBrakeGo																						, name = _('Pause'								)},
	{category = general , down = iCommandActivePauseOnOff																				, name = _('Active Pause'						)},

	{category = general	, down = iCommandGraphicsFrameRate																				, name = _('Frame rate counter - Service info'	)},
	{category = general	, down = iCommandMissionRestart																					, name = _('Restart Mission'					)},
	{category = general	, down = iCommandChat																							, name = _('Multiplayer chat - mode All'		)},
	{category = general	, down = iCommandFriendlyChat																					, name = _('Multiplayer chat - mode Allies'		)},
	{category = general	, down = iCommandAllChat																						, name = _('Chat read/write All'				)},
	{category = general	, down = iCommandChatShowHide																					, name = _('Chat show/hide'						)},
	{category = general	, down = iCommandBdaShowHide																					, name = _('BDA show/hide'						)},
	{category = general	, down =  iCommandVoiceChat																						, name = _('Show VoiceChat window')},
-- BDA panel not moved.  remove command
--	{category = general	, pressed = iCommandBdaShowCursor				, up = iCommandBdaShowCursorStop			, value_down = 1.0	, value_up = 0.0	, name = _('BDA show cursor')},
	{category = ui	, down = iCommandVoiceChatPushToTalkEnableVoice				, up = iCommandVoiceChatPushToTalkDisableVoice, name = _('VoiceChat push-to-talk mic. mode: On/Off voice transfer')},

	{down = iCommandClipboardToCockpit, name = _('Paste From Clipboard to Kneeboard'), category = _('Kneeboard')},
},

axisCommands = 
{	
},
}

if ADD_FAKE_VR then 
	ret_val.axisCommands[#ret_val.axisCommands + 1] = {category = vr		, action = iHeadTrackerPitchNormed  , name = _('Head Pitch')}
	ret_val.axisCommands[#ret_val.axisCommands + 1] = {category = vr		, action = iHeadTrackerYawNormed	, name = _('Head Yaw')}
	ret_val.keyCommands[#ret_val.keyCommands + 1] 	= {category = vr		, pressed = iHeadTrackerPitchAdd  	, value_pressed = 0.005, name = _('Head + Pitch')}
	ret_val.keyCommands[#ret_val.keyCommands + 1] 	= {category = vr		, pressed = iHeadTrackerPitchAdd  	, value_pressed =-0.005, name = _('Head - Pitch')}
	ret_val.keyCommands[#ret_val.keyCommands + 1] 	= {category = vr		, pressed = iHeadTrackerYawAdd		, value_pressed = 0.005, name = _('Head + Yaw')}
	ret_val.keyCommands[#ret_val.keyCommands + 1] 	= {category = vr		, pressed = iHeadTrackerYawAdd		, value_pressed =-0.005, name = _('Head - Yaw')}
end

return ret_val

