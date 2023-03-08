local general	= _('General')

return {
keyCommands = {
{down = iCommandChat				, name = _('Multiplayer chat - mode All'		), category = general},
{down = iCommandFriendlyChat		, name = _('Multiplayer chat - mode Allies'		), category = general},
{down = iCommandAllChat				, name = _('Chat read/write All'				), category = general},
{down = iCommandChatShowHide		, name = _('Chat show/hide'						), category = general},
{down = iCommandMissionRestart		, name = _('Restart Mission'					), category = general},
{down = iCommandBdaShowHide			, name = _('BDA show/hide'						), category = general},

{down = iCommandVoiceChat			, name = _('Show VoiceChat window'				), category = general},
{down = iCommandGraphicsFrameRate	, name = _('Frame rate counter - Service info'	), category = general},
{down = iCommandActivePauseOnOff	, name = _('Active Pause'						), category = general},

{down = iCommandScreenShot			, name = _('Make Screenshot'					), category = general},
{down = iCommandQuit				, name = _('End mission'						), category = general},
{down = iCommandBrakeGo				, name = _('Pause'								), category = general},
{down = iCommandAccelerate			, name = _('Time accelerate'					), category = general},
{down = iCommandDecelerate			, name = _('Time decelerate'					), category = general},
{down = iCommandNoAcceleration		, name = _('Time normal'						), category = general},

{down = iCommandClipboardToCockpit  , name = _('Paste From Clipboard to Kneeboard')  , category = _('Kneeboard')},

},
axisCommands = {
},
}
