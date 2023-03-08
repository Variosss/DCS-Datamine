return {
keyCommands = {
{name = 'View smoke 1'						, down = iCommandViewSmoke1  , category = "JTAC" },
{name = 'View smoke 2'						, down = iCommandViewSmoke2	 , category = "JTAC" },
{name = 'View smoke 3'						, down = iCommandViewSmoke3  , category = "JTAC" },
{name = 'View IR pointer on/blink/off'		, down = iCommandViewIRPointerOnOff , category = "JTAC" },
{name = 'View nightvision on/off'			, down = iCommandViewNVGOnOff 		  , category = "View" },
{name = 'Light Beacon Cycle on/blink/off'	, down = iCommandViewLightBeaconCycle , category = "JTAC" },
{name = 'Light Beacon On Target'			, down = iCommandViewLightBeaconToTarget , category = "JTAC" },

{name = 'Launch Green Flare'				, down = iCommandViewSpawnSignalFlare, value_down = 0, category = "JTAC" },
{name = 'Launch Red Flare'					, down = iCommandViewSpawnSignalFlare, value_down = 1, category = "JTAC" },
{name = 'Launch White Flare'				, down = iCommandViewSpawnSignalFlare, value_down = 2, category = "JTAC" },
{name = 'Launch Yellow Flare'				, down = iCommandViewSpawnSignalFlare, value_down = 3, category = "JTAC" },
{name = 'Launch Illumination Flare'			, down = iCommandViewSpawnSignalFlare, value_down = 10, category = "JTAC" },

},
}