local ui		= _('UI')
local vr		= _('VR')
local general	= _('General')

local ADD_FAKE_VR = false

local ret_val = {
keyCommands = {
{combos = {{key = 'Tab'		,								 }}, down = iCommandChat				, name = _('Multiplayer chat - mode All'		), category = general},
{combos = {{key = 'Tab'		, reformers = {'LCtrl'			}}}, down = iCommandFriendlyChat		, name = _('Multiplayer chat - mode Allies'		), category = general},
{combos = {{key = 'Tab'		, reformers = {'LShift'			}}}, down = iCommandAllChat				, name = _('Chat read/write All'				), category = general},
{combos = {{key = 'Y'		, reformers = {'LCtrl', 'LShift'}}}, down = iCommandChatShowHide		, name = _('Chat show/hide'						), category = general},
{combos = {{key = 'R'		, reformers = {'LShift'			}}}, down = iCommandMissionRestart		, name = _('Restart Mission'					), category = general},
{combos = {{key = '\''		, reformers = {'RAlt'			}}}, down = iCommandBdaShowHide			, name = _('BDA show/hide'						), category = general},
-- BDA panel not moved.  remove command	
--{combos = {{key = '\`'  , reformers = {'LCtrl','LAlt'}		}}, pressed = iCommandBdaShowCursor, up = iCommandBdaShowCursorStop, name = _('BDA show cursor')			, category = general},
{combos = {{key = 'Tab'		, reformers = {'LCtrl', 'LShift'}}}, down = iCommandVoiceChat			, name = _('Show VoiceChat window'				), category = general},
{combos = {{key = 'Pause'	, reformers = {'RCtrl'			}}}, down = iCommandGraphicsFrameRate	, name = _('Frame rate counter - Service info'	), category = general},
{combos = {{key = 'Pause'	, reformers = {'LShift', 'LWin'}}},  down = iCommandActivePauseOnOff	, name = _('Active Pause'						), category = general},

{																 down = iCommandScreenShot			, name = _('Make Screenshot'					), category = general},
{combos = {{key = 'Esc'										 }}, down = iCommandQuit				, name = _('End mission'						), category = general},
{combos = {{key = 'Pause'									 }}, down = iCommandBrakeGo				, name = _('Pause'								), category = general},
{combos = {{key = 'Z', reformers = {'LCtrl'					}}}, down = iCommandAccelerate			, name = _('Time accelerate'					), category = general},
{combos = {{key = 'Z', reformers = {'LAlt'					}}}, down = iCommandDecelerate			, name = _('Time decelerate'					), category = general},
{combos = {{key = 'Z', reformers = {'LShift'				}}}, down = iCommandNoAcceleration		, name = _('Time normal'						), category = general},

{down = iCommandClipboardToCockpit, name = _('Paste From Clipboard to Kneeboard'), category = _('Kneeboard')},

{down = iCommand_UILayer_MouseLeftButton	, up = iCommand_UILayer_MouseLeftButton	, value_down = 1.0	, value_up = 0.0	, name = _('as left mouse button'		), category = ui},
{down = iCommand_UILayer_MouseRightButton	, up = iCommand_UILayer_MouseRightButton, value_down = 1.0	, value_up = 0.0	, name = _('as right mouse button'		), category = ui},
{down = iCommand_UILayer_MouseWheelFwd		, up = iCommand_UILayer_MouseWheelFwd	, value_down = 1.0	, value_up = 0.0	, name = _('as mouse wheel forward'		), category = ui},
{down = iCommand_UILayer_MouseWheelBwd		, up = iCommand_UILayer_MouseWheelBwd	, value_down = 1.0	, value_up = 0.0	, name = _('as mouse wheel backward'	), category = ui},
{down = iCommandVoiceChatPushToTalkEnableVoice		, up = iCommandVoiceChatPushToTalkDisableVoice	, name = _('VoiceChat push-to-talk mic. mode: On/Off voice transfer'), category = ui},
{down = iHeadTrackerZoomToggle				, up = iHeadTrackerZoomToggle			, value_down = 1.0	, value_up = 0.0	, name = _('toggle VR Zoom'				), category = vr},
{down = iHeadTrackerSpyglassZoomToggle		, up = iHeadTrackerSpyglassZoomToggle	, value_down = 1.0	, value_up = 0.0	, name = _('toggle VR Spyglass Zoom'	), category = vr},
{down = iHeadTrackerPosReset																								, name = _('recenter VR Headset'		), category = vr},
{down = iHeadTrackerLeftHandEnable			, up = iHeadTrackerLeftHandEnable		, value_down = 1.0	, value_up = 0.0	, name = _('VR, left hand (enable/disable)'	), category = vr},
{down = iHeadTrackerRightHandEnable			, up = iHeadTrackerRightHandEnable		, value_down = 1.0	, value_up = 0.0	, name = _('VR, right hand (enable/disable)'	), category = vr},
},
}


if ADD_FAKE_VR then 
	ret_val.keyCommands[#ret_val.keyCommands + 1] 	= {combos = {{key = 'Num8'}},category = vr		, pressed = iHeadTrackerPitchAdd  	, value_pressed = 0.005, name = _('Head + Pitch')}
	ret_val.keyCommands[#ret_val.keyCommands + 1] 	= {combos = {{key = 'Num2'}},category = vr		, pressed = iHeadTrackerPitchAdd  	, value_pressed =-0.005, name = _('Head - Pitch')}
	ret_val.keyCommands[#ret_val.keyCommands + 1] 	= {combos = {{key = 'Num4'}},category = vr		, pressed = iHeadTrackerYawAdd		, value_pressed = 0.005, name = _('Head + Yaw')}
	ret_val.keyCommands[#ret_val.keyCommands + 1] 	= {combos = {{key = 'Num6'}},category = vr		, pressed = iHeadTrackerYawAdd		, value_pressed =-0.005, name = _('Head - Yaw')}
end

return ret_val