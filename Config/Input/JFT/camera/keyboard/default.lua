return {
keyCommands = {
{combos = {{key = '1'}}, name = 'View smoke 1'									, down = iCommandViewSmoke1  , category = "JTAC" },
{combos = {{key = '2'}}, name = 'View smoke 2'									, down = iCommandViewSmoke2	 , category = "JTAC" },
{combos = {{key = '3'}}, name = 'View smoke 3'									, down = iCommandViewSmoke3  , category = "JTAC" },
{combos = {{key = 'R'}}, name = 'View IR pointer on/blink/off'					, down = iCommandViewIRPointerOnOff                     , category = "JTAC" },
{combos = {{key = 'N'}}, name = 'View nightvision on/off'						, down = iCommandViewNVGOnOff 		                    , category = "View" },

{combos = {{key = 'L'}}, name = 'Light Beacon Cycle Steady/Blink/Off'						, down = iCommandViewLightBeaconCycle                    , category = "JTAC" },
{                        name = 'Light Beacon Spectrum Cycle NVG/FLIR/Visual'				, down = iCommandViewLightBeaconCycleSpectrum            , category = "JTAC" },
{						 name = 'Light Beacon On Target'									, down = iCommandViewLightBeaconToTarget                 , category = "JTAC" },
{						 name = 'Light Beacon On Target Cycle Steady/Blink'					, down = iCommandViewLightBeaconToTargetCycleBlink       , category = "JTAC" },
{						 name = 'Light Beacon On Target Spectrum Cycle NVG/FLIR/Visual'		, down = iCommandViewLightBeaconToTargetCycleSpectrum    , category = "JTAC" },
{						 name = 'Light Beacon On Target Delete Last Created'				, down = iCommandViewLightBeaconToTargetDeleteLastCreated, category = "JTAC" },

{combos = {{key = '1' , reformers = {'LAlt'}}}, name = 'Launch Green Flare'			, down = iCommandViewSpawnSignalFlare, value_down = 0, category = "JTAC" },
{combos = {{key = '2' , reformers = {'LAlt'}}}, name = 'Launch Red Flare'			, down = iCommandViewSpawnSignalFlare, value_down = 1, category = "JTAC" },
{combos = {{key = '3' , reformers = {'LAlt'}}}, name = 'Launch White Flare'			, down = iCommandViewSpawnSignalFlare, value_down = 2, category = "JTAC" },
{combos = {{key = '4' , reformers = {'LAlt'}}}, name = 'Launch Yellow Flare'		, down = iCommandViewSpawnSignalFlare, value_down = 3, category = "JTAC" },
{combos = {{key = '5' , reformers = {'LAlt'}}}, name = 'Launch Illumination Flare'	, down = iCommandViewSpawnSignalFlare, value_down = 10, category = "JTAC" },

},
}