local empty_string = ''

events = {
    [Message.wMsgNull] = nil,
		--Leader
		--Leader to wingmen/pair/flight/wing/group
		[Message.wMsgLeaderNull] = nil,
			[Message.wMsgLeaderToWingmenNull] = nil,
				[Message.wMsgLeaderEngageMyTarget] = { _('engage my target'), 'engage my target' },
				[Message.wMsgLeaderEngageBandits] = { _('engage bandits'), 'engage bandits' },
				[Message.wMsgLeaderEngageGroundTargets] = { _('engage targets of opportunity'), 'engage targets of opportunity' },
				[Message.wMsgLeaderEngageArmor] = { _('engage armor'), 'engage armor' },
				[Message.wMsgLeaderEngageArtillery] = { _('engage artillery'), 'engage artillery' },
				[Message.wMsgLeaderEngageAirDefenses] = { _('engage air defence'), 'engage air defence' },
				[Message.wMsgLeaderEngageUtilityVehicles] = { _('engage utility vehicles'), 'engage utility vehicles' },
				[Message.wMsgLeaderEngageInfantry]		 = { _('engage infantry'), 'engage infantry' },
				[Message.wMsgLeaderEngageNavalTargets] = { _('engage ships'), 'engage ships' },			
				[Message.wMsgLeaderEngageDlinkTarget] = { _('engage datalink target'), 'engage datalink target' },
				[Message.wMsgLeaderEngageDlinkTargets] = { _('engage datalink target group'), 'engage datalink target group'},
				[Message.wMsgLeaderEngageDlinkTargetByType] = { _('engage datalink target'), 'engage datalink target' },
				[Message.wMsgLeaderEngageDlinkTargetsByType] = { _('engage datalink target group'), 'engage datalink target group'},		
				[Message.wMsgLeaderFulfilTheTaskAndJoinUp] = { _('attack primary target and rejoin'), 'attack primary target and rejoin' },
				[Message.wMsgLeaderFulfilTheTaskAndReturnToBase] = { _('attack primary target and RTB'), 'attack primary target and RTB', 'attack primary target and aR Te Be' },
				[Message.wMsgLeaderRayTarget] = { _('ray target'), 'ray target' },
				[Message.wMsgLeaderMyEnemyAttack] = { _('attack my enemy'), 'attack my enemy' },
				[Message.wMsgLeaderCoverMe] = { _('cover me'), 'cover me' },
				[Message.wMsgLeaderFlightCheckIn] = { _('flight check'), 'flight check' },
				--Maneuver
				[Message.wMsgLeaderPincerRight] = { _('pincer right'), 'pincer right' },
				[Message.wMsgLeaderPincerLeft] = { _('pincer left'), 'pincer left' },
				[Message.wMsgLeaderPincerHigh] = { _('pincer high'), 'pincer high' },
				[Message.wMsgLeaderPincerLow] = { _('pincer low'), 'pincer low' },
				[Message.wMsgLeaderBreakRight] = { _('break right'), 'break right' },
				[Message.wMsgLeaderBreakLeft] = { _('break left'), 'break left' },
				[Message.wMsgLeaderBreakHigh] = { _('break high'), 'break high' },
				[Message.wMsgLeaderBreakLow] = { _('break low'), 'break low' },
				[Message.wMsgLeaderClearRight] = { _('clear right'), 'clear right' },
				[Message.wMsgLeaderClearLeft] = { _('clear left'), 'clear left' },
				[Message.wMsgLeaderPump] = { _('pump'), 'pump' },
				--Navigation
				[Message.wMsgLeaderAnchorHere] = { _('anchor here'), 'anchor here' },
				[Message.wMsgLeaderFlyAndOrbitAtSteerPoint] = { _('anchor steerpoint'), 'anchor steerpoint' },
				[Message.wMsgLeaderFlyAndOrbitAtSPI] = { _('anchor at my SPI'), 'anchor at my SPI' },
				[Message.wMsgLeaderFlyAndOrbitAtPoint] = { _('follow to datalink '), 'follow to datalink point' },
				[Message.wMsgLeaderReturnToBase] = { _('RTB'), 'RTB', 'aR Te Be' },
				[Message.wMsgLeaderGoRefueling] = { _('go tanker'), 'go tanker' },
				[Message.wMsgLeaderJoinUp] = { _('join up'), 'join up' },
				[Message.wMsgLeaderFlyRoute]  = { _('continue route'), 'continue route' },
				[Message.wMsgLeaderMakeRecon] = { _('recce to'), 'recce to' },
				[Message.wMsgLeaderMakeReconAtPoint] = { _('recce to datalink point'), 'recce to datalink point' },
				--State
				[Message.wMsgLeaderRadarOn] = { _('radar on'), 'radar on' },
				[Message.wMsgLeaderRadarOff] = { _('radar off'), 'radar off' },
				[Message.wMsgLeaderDisturberOn] = { _('music on'), 'music on' },
				[Message.wMsgLeaderDisturberOff] = { _('music off'), 'music off' },
				[Message.wMsgLeaderSmokeOn] = { _('smoke on'), 'smoke on' },
				[Message.wMsgLeaderSmokeOff] = { _('smoke off'), 'smoke off' },
				[Message.wMsgLeaderJettisonWeapons] = { _('jettison weapons'), 'jettison weapons' },
				[Message.wMsgLeaderFenceIn] = {_('fence In'), 'fence In' },
				[Message.wMsgLeaderFenceOut] = {_('fence Out'), 'fence Out' },
				[Message.wMsgLeaderOut]  = { _('OUT'), 'OUT' },
				--Formation
				--Airplane
				[Message.wMsgLeaderLineAbreast] = { _('go line abreast'), 'go line abreast' },
				[Message.wMsgLeaderGoTrail] = { _('go trail'), 'go trail' },
				[Message.wMsgLeaderWedge] = { _('go wedge'), 'go wedge' },
				[Message.wMsgLeaderEchelonLeft] = { _('go echelon left'), 'go echelon left' },
				[Message.wMsgLeaderEchelonRight] = { _('go echelon right'), 'go echelon right' },
				[Message.wMsgLeaderFingerFour] = { _('go finger four'), 'go finger four' },
				[Message.wMsgLeaderSpreadFour] = { _('go spread four'), 'go spread four' },
				[Message.wMsgLeaderCloseFormation] = { _('close formation'), 'close formation' },
				[Message.wMsgLeaderOpenFormation] = { _('open formation'), 'open formation' },
				[Message.wMsgLeaderCloseGroupFormation] = { _('close group formation'), 'close group formation' },
				--Helicopter
				[Message.wMsgLeaderHelGoHeavy] = { _('go heavy formation'), 'go heavy formation'},
				[Message.wMsgLeaderHelGoEchelon] = { _('go echelon formation'), 'go echelon formation'},
				[Message.wMsgLeaderHelGoSpread] = { _('go spread formation'), 'go spread formation'},
				[Message.wMsgLeaderHelGoTrail] = { _('go trail formation'), 'go trail formation'},
				[Message.wMsgLeaderHelGoOverwatch] = { _('perform overwatch'), 'perform overwatch'},
				[Message.wMsgLeaderHelGoLeft] = { _('go left formation'), 'go left formation'},
				[Message.wMsgLeaderHelGoRight] = { _('go right formation'), 'go right formation'},
				[Message.wMsgLeaderHelGoTight] = { _('go tight formation'), 'go tight formation'},
				[Message.wMsgLeaderHelGoCruise] = { _('go cruise formation'), 'go cruise formation'},
				[Message.wMsgLeaderHelGoCombat] = { _('go combat formation'), 'go combat formation'},
			[Message.wMsgLeaderToWingmenMaximum] = '',
		
			--Leader to Service
			[Message.wMsgLeaderToServiceNull] = nil,
				--Leader to ATC
				[Message.wMsgLeaderToATCNull] = nil,
					[Message.wMsgLeaderRequestEnginesLaunch] = { _('request startup'), 'request startup' },
					[Message.wMsgLeaderRequestControlHover] = { _('request control hover'), 'request control hover' },
					[Message.wMsgLeaderRequestTaxiToRunway] = { _('request taxi to runway'), 'request taxi to runway' },
					[Message.wMsgLeaderRequestTakeOff] = { _('request takeoff'), 'request takeoff' },
					[Message.wMsgLeaderAbortTakeoff] = { _('abort takeoff'), 'abort takeoff' },
					[Message.wMsgLeaderRequestAzimuth] = { _('request navigation assistance'), 'request navigation assistance' },
					[Message.wMsgLeaderInbound] = '',
					[Message.wMsgLeaderAbortInbound] = { _('abort inbound, resuming mission'), 'abort inbound' },
					[Message.wMsgLeaderRequestLanding] = { _('request landing'), 'request landing' },
					[Message.wMsgLeaderRequestTaxiForTakeoff] = { _('request taxi for takeoff'), 'request taxi for takeoff' },
					[Message.wMsgLeaderRequestTaxiToParking] = { _('request taxi to parking'), 'request taxi to parking' },
					[Message.wMsgLeaderTowerRequestTakeOff] = { _('tower request takeoff'), 'tower request takeoff' },
					[Message.wMsgLeaderInboundStraight] = '',
					[Message.wMsgLeaderApproachOverhead] = '',
					[Message.wMsgLeaderApproachStraight] = '',
					[Message.wMsgLeaderApproachInstrument] = '',
				[Message.wMsgLeaderToATCMaximum] = '',
			
				--Leader to AWACS
				[Message.wMsgLeaderToAWACSNull] = nil,
					[Message.wMsgLeaderVectorToBullseye] = { _('alpha check from bulls picture'), 'alpha check from bulls picture' },
					[Message.wMsgLeaderVectorToNearestBandit] = { _('request bogey dope'), 'request bogey dope' },
					[Message.wMsgLeaderVectorToHomeplate] = { _('alpha check to home plate'), 'alpha check to home plate' },
					[Message.wMsgLeaderVectorToTanker] = { _('alpha check to tanker'), 'alpha check to tanker' },
					[Message.wMsgLeaderDeclare] = { _('DECLARE'), 'DECLARE' },
					[Message.wMsgLeaderPicture] = { _('request picture'), 'picture' },
				[Message.wMsgLeaderToAWACSMaximum] = nil,
			
				--Leader to Tanker
				[Message.wMsgLeaderToTankerNull]		= '',
					[Message.wMsgLeaderIntentToRefuel] 	= { _('request rejoin'), 'request rejoin' },
					[Message.wMsgLeaderAbortRefueling]	= { _('abort rejoin'), 'abort rejoin' },
					[Message.wMsgLeaderReadyPreContact]	= { _('ready pre-contact'), 'ready pre-contact' },
					[Message.wMsgLeaderStopRefueling]	= { _('abort rejoin'), 'abort rejoin' },
				[Message.wMsgLeaderToTankerMaximum]		= '',
				
				--Player to FAC
				[Message.wMsgLeaderToFACNull] = nil,
					[Message.wMsgLeaderCheckIn] = '',
					[Message.wMsgLeaderCheckOut] = { _('we are end of vul and checking out. Stay safe down there'), 'checking-out', 'we are end of vul and checking out. Stay safe down there' },
					[Message.wMsgLeaderReadyToCopy] = { _('ready to copy'), 'ready to copy' },
					[Message.wMsgLeaderReadyToCopyRemarks] = { _('ready to copy remarks'), 'ready to copy remarks' },
					[Message.wMsgLeader9LineReadback] = '',
					[Message.wMsgLeaderRequestTasking] = { _('request tasking'), 'request tasking' },
					[Message.wMsgLeaderRequestBDA] = { _('request BDA'), 'request BDA' },
					[Message.wMsgLeaderRequestTargetDescription] = { _('what is my target?'), 'what is my target' },
					[Message.wMsgLeaderFACRepeat] = { _('repeat'), 'repeat' },
					[Message.wMsgLeaderUnableToComply] = { _('unable to comply'), 'unable to comply' },
					[Message.wMsgLeader_IP_INBOUND] = {_('IP INBOUND'), 'IP INBOUND', 'I Pe INBOUND' },
					[Message.wMsgLeader_ONE_MINUTE] = { _('ONE MINIUTE'), 'ONE MINIUTE' },
					[Message.wMsgLeader_IN] = { _('IN'), 'IN' },
					[Message.wMsgLeader_OFF] = { _('OFF'), 'OFF' },
					[Message.wMsgLeader_ATTACK_COMPLETE] = { _('ATTACK COMPLETE at time'), 'ATTACK COMPLETE at time' },
					[Message.wMsgLeaderAdviseWhenReadyToCopyBDA] = { _('Advise when ready to copy BDA'), 'Advise when ready to copy BDA' },
					[Message.wMsgLeaderContact] = { _('contact: '), 'contact' },
					[Message.wMsgLeader_NO_JOY] = { _('NO JOY'), 'NO JOY' },
					[Message.wMsgLeader_CONTACT_the_mark] = { _('CONTACT the mark'), 'CONTACT the mark' },
					[Message.wMsgLeader_SPARKLE] = { _('SPARKLE COMMAND'), 'SPARKLE'},
					[Message.wMsgLeader_SNAKE] = { _('SNAKE COMMAND'), 'SNAKE'},
					[Message.wMsgLeader_PULSE] = { _('PULSE COMMAND'), 'PULSE'},
					[Message.wMsgLeader_STEADY] = { _('STEADY COMMAND'), 'STEADY'},
					[Message.wMsgLeader_ROPE] = { _('ROPE COMMAND'), 'ROPE'},
					[Message.wMsgLeader_CONTACT_SPARKLE] = { _('CONTACT SPARKLE'), 'CONTACT SPARKLE' },
					[Message.wMsgLeader_STOP] = { _('STOP COMMAND'), 'STOP'},
					[Message.wMsgLeader_TEN_SECONDS] = { _('TEN SECONDS'), 'TEN SECONDS' },
					[Message.wMsgLeader_LASER_ON] = { _('LASER ON COMMAND'), 'LASER ON'},
					[Message.wMsgLeader_SHIFT] = { _('SHIFT COMMAND'), 'SHIFT'},
					[Message.wMsgLeader_SPOT] = { _('SPOT'), 'SPOT' },
					[Message.wMsgLeader_TERMINATE] = { _('TERMINATE COMMAND'), 'TERMINATE'},
					[Message.wMsgFAC_NoMark] = { _('No mark'), 'No mark'},
					[Message.wMsgLeaderGuns] = { _('guns! guns! guns!'), 'guns', 'guns! guns! guns!' },
					[Message.wMsgLeaderBombsAway] = { _('bombs away'), 'bombs away' },
					[Message.wMsgLeaderRIFLE] = { _('RIFLE'), 'RIFLE' },
					[Message.wMsgLeaderRockets] = { _('rockets away'), 'rockets away' },
					[Message.wMsgLeaderBDA] = '',
					[Message.wMsgLeaderINFLIGHTREP] = { _('INFLIGHTREP'), 'INFLIGHTREP' },
				[Message.wMsgLeaderToFACMaximum] = nil,
				
				--Leader to Ground Crew
				[Message.wMsgLeaderToGroundCrewNull] = nil,
					[Message.wMsgLeaderSpecialCommand] = '',
					[Message.wMsgLeaderRequestRefueling] = { _('request refueling'), 'request refueling' },
					[Message.wMsgLeaderRequestCannonReloading] = '',
					[Message.wMsgLeaderRequestRearming] = { _('request rearming'), 'request rearming' },
					[Message.wMsgLeaderGroundToggleElecPower] = '',
					[Message.wMsgLeaderGroundToggleWheelChocks] = '',
					[Message.wMsgLeaderGroundToggleExhaustScreen] = '',
					[Message.wMsgLeaderGroundToggleCanopy] = '',
					[Message.wMsgLeaderGroundToggleAir] = '',
					[Message.wMsgLeaderGroundApplyAir] = '',
					[Message.wMsgLeaderGroundRepair] = { _('repair'), 'repair' },
				[Message.wMsgLeaderToGroundCrewMaximum] = nil,
			[Message.wMsgLeaderToServiceMaximum] = nil,
		[Message.wMsgLeaderMaximum] = nil,
		--Leader to NAVY ATC
		[Message.wMsgLeaderToNavyATCNull] = nil,
			[Message.wMsgLeaderInboundCarrier] = '',
			[Message.wMsgLeaderConfirm] = {empty_string, ''},			--	//NAVY	- [SIDE NUMBER] 
			[Message.wMsgLeaderConfirmRemainingFuel] = { _('low state '), 'PLAYER-LOW-STATE' },	--	//NAVY	- [SIDE NUMBER], [REMAINING FUEL]. //after approach answer on "See you at 10" 
			[Message.wMsgLeaderInboundMarshallRespond] = { _(', marshal on the '), ', marshal on the' },	--	//NAVY - CASE II and III: [SIDE NUMBER], marshal on the [BEARING], range, [DME] angels [ALTITUDE]. Expected approach time [TIME], approach button is 15.
			[Message.wMsgLeaderEstablished] = { _(', established angels '), ', established angels ' },		--			//NAVY - CASE II and III: [SIDE NUMBER], established angels [ALTITUDE]. State [FUEL LEVEL]. When on holding stack
			[Message.wMsgLeaderCommencing] = { _(' commencing, '), ' commencing, ' },		--				//NAVY - CASE II and III: [SIDE NUMBER] commencing, [ALTIMETER], state [FUEL LEVEL]. When pushing time - next stack
			[Message.wMsgLeaderCheckingIn] = { _(', checking in, '), ', checking in, ' },		--				//NAVY - CASE II and III: [SIDE NUMBER], checking in, [DISTANCE TO CARRIER] miles.  - When start Approach
			[Message.wMsgLeaderPlatform] = { _('platform'), 'PLATFORM' },		--				//NAVY - CASE II and III: [SIDE NUMBER], platform. - When approach and 5000 feet altitude.
			[Message.wMsgLeaderSayNeedle] = { _('needles'), 'needles' },			--				//NAVY - CASE III: [SIDE NUMBERS], [GLIDEPATH][LOCALIZER]. answer to Approach
			[Message.wMsgLeaderSeeYouAtTen] = { _('see you at 10.'), 'SEE_YOU', 'see you at ten.' },		--			//NAVY - answer to marshall after inbound call			
			[Message.wMsgLeaderHornetBall] = { _('hornet ball'), 'PLAYER-HORNET-BALL' },			--				//NAVY - At 3/4 Mile ; IF: Not CLARA high or low 	
			[Message.wMsgLeaderCLARA] = { _('Clara'), 'clara' },
			[Message.wMsgLeaderBall] = { _('Ball'), 'ball' },
			[Message.wMsgLeaderTowerOverhead] = { _(', overhead, angles '), 'OVERHEAD' },			--			//NAVY - CASE I ; Once player is within 3 nm of carrier
			[Message.wMsgLeaderFlightKissOff] = { _('Kiss Off'), 'Kiss_off' },			--			//NAVY - CASE I ;
			[Message.wMsgLeaderAirborn] = {empty_string, 'airborn'},			--	//NAVY	- [SIDE NUMBER], airborn
			[Message.wMsgLeaderPassing2_5Kilo] = {empty_string, 'PASSING_25'},			--	//NAVY	- [SIDE NUMBER], wMsgLeaderPassing2_5Kilo
		[Message.wMsgLeaderToNavyATCMaximum] = '',
		
		--Wingmen
		[Message.wMsgWingmenNull] = nil,
			--Answers	
			[Message.wMsgWingmenCopy] = '',
			[Message.wMsgWingmenNegative] = '',
			[Message.wMsgWingmenFlightCheckInPositive] = '',
			--Reports
			[Message.wMsgWingmenHelReconBearing] = '',
			[Message.wMsgWingmenHelReconEndFound] = { _('recce complete'), 'recce complete' },
			[Message.wMsgWingmenHelReconEndNotFound] = { _('recce complete no targets'), 'recce complete no targets' },
			[Message.wMsgWingmenHelLaunchAbortTask] = { _('under attack and aborting recce'), 'under attack and aborting recce' },
				--Contacts
				[Message.wMsgWingmenRadarContact] = { _('contact bearing'), 'contact bearing' },
				[Message.wMsgWingmenContact] = { _('contact'), 'contact' },
				[Message.wMsgWingmenTallyBandit] = { _('tally bandit'), 'tally bandit' },
				[Message.wMsgWingmenNails] = { _('NAILS'), 'NAILS' },
				[Message.wMsgWingmenSpike] = { _('SPIKE'), 'SPIKE' },
				[Message.wMsgWingmenMudSpike] = { _('MUD SPIKE'), 'MUD SPIKE' },
			--Events
			[Message.wMsgWingmenIamHit] = { _('I\'m hit!'), 'I am hit' },
			[Message.wMsgWingmenIveTakenDamage] =  { _('I\'m hit!'), 'I am hit' },
			[Message.wMsgWingmenEjecting] = { _('ejecting!'), 'ejecting' },
			[Message.wMsgWingmenBailOut] = { _('bail out!'), 'bail out' },
			[Message.wMsgWingmenWheelsUp] = { _('wheels up'), 'wheels up' },
			[Message.wMsgWingmenHelOccupFormLeft] = { _('in position to the left'), 'in position to the left' },
			[Message.wMsgWingmenHelOccupFormRight] = { _('in position to the right'), 'in position to the right' },
			[Message.wMsgWingmenHelOccupFormBehind] = { _('in position behind'), 'in position behind' },
			[Message.wMsgWingmenOnPosition] = { _('at destination'), 'at destination' },
				--Weapon launch	
				[Message.wMsgWingmenGuns] = { _('Guns! Guns! Guns!'), 'guns', 'Guns! Guns! Guns!' },
				[Message.wMsgWingmenFoxFrom] = { _('missile away from'), 'missile away from' },
				[Message.wMsgWingmenFox1] = { _('FOX 1'), 'FOX 1' },
				[Message.wMsgWingmenFox2] = { _('FOX 2'), 'FOX 2' },
				[Message.wMsgWingmenFox3] = { _('FOX 3'), 'FOX 3' },
				[Message.wMsgWingmenBombsAway] = { _('bombs away'), 'bombs away' },
				[Message.wMsgWingmenGBUAway] = { _('bombs away'), 'bombs away' },
				[Message.wMsgWingmenMagnum] = { _('missile away'), 'missile away' }, --'Magnum',
				[Message.wMsgWingmenMissileAway] = { _('missile away'), 'missile away' },
				[Message.wMsgWingmenRifle] = { _('missile away'), 'missile away' }, --'RIFLE',
				[Message.wMsgWingmenBruiser] = { _('missile away'), 'missile away' }, --'BRUISER',
				[Message.wMsgWingmenRockets] = { _('rockets away'), 'rockets away' }, --ROCKETS
				[Message.wMsgWingmenSmoke] = { _('rockets away'), 'rockets away' }, --'SMOKE',
			--Status messages
			[Message.wMsgWingmenRadarOff] = { _('radar off'), 'radar off' },
			[Message.wMsgWingmenRadarOn] = { _('radar on'), 'radar on' },
			[Message.wMsgWingmenMusicOff] = { _('music is off'), 'music is off' },
			[Message.wMsgWingmenMusicOn] = { _('music is on'), 'music is on' },
			[Message.wMsgWingmenBingo] = { _('bingo fuel'), 'bingo fuel' },
			[Message.wMsgWingmenKansas] = { _('kansas'), 'kansas' },
			[Message.wMsgWingmenWinchester]	= { _('winchester'), 'winchester' },
				--Task
				[Message.wMsgWingmenRolling] = { _('rolling'), 'rolling' },
				[Message.wMsgWingmenRollingTaxi] = { _('rolling_taxi'), 'rolling_taxi' },
				[Message.wMsgWingmenRTB] = { _('RTB'), 'RTB', 'ar Te Be' },
				[Message.wMsgWingmenBugout] = { _('bug out'), 'bug out' },
				[Message.wMsgWingmenRejoin] = { _('rejoin'), 'rejoin' },
				[Message.wMsgWingmenFollowScanMode] = { _('proceeding in recon scan mode'), 'proceeding in recon scan mode' },
					--Engaging
					[Message.wMsgWingmenAttackingPrimary] = { _('engaging primary'), 'engaging primary' },
					[Message.wMsgWingmenEngagingBandit] = { _('engaging bandit'), 'engaging bandit' },
					[Message.wMsgWingmenEngagingHelicopter] = { _('engaging bandit'), 'engaging bandit' },-- 'engaging helo',
					[Message.wMsgWingmenEngagingSAM] =  { _('engaging air defences'), 'engaging air defences' }, -- 'engaging SAM',
					[Message.wMsgWingmenEngagingAAA] = { _('engaging air defences'), 'engaging air defences' }, -- 'engaging AAA',
					[Message.wMsgWingmenEngagingArmor] = { _('engaging target'), 'engaging target' }, -- 'engaging armor',
					[Message.wMsgWingmenEngagingArtillery] = { _('engaging target'), 'engaging target' }, -- 'engaging artillery',
					[Message.wMsgWingmenEngagingVehicle] = { _('engaging target'), 'engaging target' }, -- 'engaging vehicles',
					[Message.wMsgWingmenEngagingShip] = { _('engaging target'), 'engaging target' }, -- 'engaging ships',
					[Message.wMsgWingmenEngagingBunker] = { _('engaging target'), 'engaging target' }, -- 'engaging bunker',
					[Message.wMsgWingmenEngagingStructure] = { _('engaging target'), 'engaging target' }, -- 'engaging building',
					--Attack stage
					[Message.wMsgWingmenRunningIn] = { _('RUNNING IN'), 'RUNNING IN' },
					[Message.wMsgWingmenRunningOff] = { _('OFF'), 'OFF' },
					[Message.wMsgWingmenBanditDestroyed] = { _('splash one'), 'splash one' },
					[Message.wMsgWingmenTargetDestroyed] = '',
					--Defensive
					[Message.wMsgWingmenEngagedDefensive] = { _('engaged, defensive'), 'engaged defensive' },
			--Requests
			[Message.wMsgWingmenRequestPermissionToAttack] = { _('request permission to attack'), 'request permission to attack' },
			[Message.wMsgWingmenSplashMyBandit] = { _('splash my bandit!'), 'splash my bandit' },
			--Attack warning    
			[Message.wMsgWingmenSAMLaunch] = { _('SAM launch!'), 'SAM launch' },
			[Message.wMsgWingmenMissileLaunch] = { _('missile launch!'), 'missile launch' },
			[Message.wMsgWingmenCheckYourSix] = { _('check six!'), 'check six' },
		[Message.wMsgWingmenMaximum] = nil,
		
		--Flights
		[Message.wMsgFlightNull] = nil,
			[Message.wMsgFlightAirbone] = { _('airborne'), 'airborne' },
			[Message.wMsgFlightPassingWaypoint] = { _('passing waypoint'), 'passing waypoint' },
			[Message.wMsgFlightOnStation] = { _('on station'), 'on station' },
			[Message.wMsgFlightDepartingStation] = { _('pushing from waypoint'), 'pushing from waypoint' },
			[Message.wMsgFlightRTB] = { _('is RTB'), 'is RTB', 'is aR Te Be' },
			[Message.wMsgFlightTallyBandit] = { _('tally bandit'), 'tally bandit' },
			[Message.wMsgFlightTally] = { _('tally'), 'tally' },
			[Message.wMsgFlightEngagingBandit] = { _('engaging bandit'), 'engaging bandit' },
			[Message.wMsgFlightEngaging] = { _('in'), 'in' },
			[Message.wMsgFlightSplashBandit] = { _('splash bandit'), 'splash bandit' },
			[Message.wMsgFlightTargetDestroyed] = { _('kill'), 'kill' },
			[Message.wMsgFlightDefensive] = { _('defending'), 'defending' },
			[Message.wMsgFlightMemberDown] = { _('mayday, mayday, mayday, member down!'), 'member down', 'mayday, mayday, mayday, member down!' },
			[Message.wMsgFlightAerobaticTurnPreStart]	= '',
			[Message.wMsgFlightAerobaticTurnStart]		= { _('start!'), 'start' },
			[Message.wMsgFlightAerobaticTurnStop]		= { _('break turn!'), 'break turn' },
		[Message.wMsgFlightMaximum] = nil,
		
		--ATC
		[Message.wMsgServiceNull] = nil,
			[Message.wMsgATCNull] = nil,
				[Message.wMsgATCClearedForEngineStartUp] = { _('cleared for startup'), 'cleared for startup' },
				[Message.wMsgATCEngineStartUpDenied] = { _('unable clear start up'), 'unable clear start up' },
				[Message.wMsgATCClearedToTaxiRunWay] = { _('cleared to taxi to runway'), 'cleared to taxi to runway' },
				[Message.wMsgATCTaxiDenied] = { _('unable clear taxi'), 'unable clear taxi' },
				[Message.wMsgATCHoldPosition] = { _('hold position'), 'hold position' },
				[Message.wMsgATCYouAreClearedForTO] = { _('you are cleared for takeoff when ready'), 'you are cleared for takeoff when ready' },
				[Message.wMsgATCTakeoffDenied] = { _('unable to clear takeoff'), 'unable to clear takeoff' },
				[Message.wMsgATCYouHadTakenOffWithNoPermission] = { _('unable to clear takeoff'), 'unable to clear takeoff' },
				[Message.wMsgATCTrafficBearing] = { _('traffic bearing'), 'traffic bearing' },
				[Message.wMsgATCYouAreClearedForLanding] = { _('cleared to land'), 'cleared to land' },
				[Message.wMsgATCYouAreAboveGlidePath] = { _('you are above glide path'), 'you are above glide path' },
				[Message.wMsgATCYouAreOnGlidePath] = { _('you are on glide path'), 'you are on glide path' },
				[Message.wMsgATCYouAreBelowGlidePath] = { _('you are below glide path'), 'you are below glide path' },
				[Message.wMsgATCTaxiToParkingArea] = { _('taxi to parking area'), 'taxi to parking area' },
				[Message.wMsgATCGoAround] = { _('go around runway occupied'), 'go around runway occupied' },
				[Message.wMsgATCContinueTaxi] = { _('continue taxi'), 'continue taxi' },
				[Message.wMsgATCOrbitForSpacing] = { _('orbit for spacing'), 'orbit for spacing', 'orbit for spacing, waiting for permission' },
				[Message.wMsgATCClearedForVisual] = { _('cleared for visual, contact tower'), 'cleared for visual contact tower' },
				[Message.wMsgATCFlyHeading] = { _('fly heading'), 'fly heading' },
				[Message.wMsgATCAzimuth] = { _('-ADF, your heading'), 'ADF your heading' },
				[Message.wMsgATCGoSecondary] = { _('go to alternate'), 'go to alternate' },
				[Message.wMsgATCClearedControlHover] = { _('cleared hover check'), 'cleared hover check' },
				[Message.wMsgATCControlHoverDenied] = { _('unable clear control hover'), 'unable clear control hover' },
				[Message.wMsgATCCheckLandingGear] = { _('check landing gear'), 'check landing gear' },
				[Message.wMsgATCFlightCheckIn] = { _('check flight in'), 'check flight in' },					
			[Message.wMsgATCMaximum] = nil,
			
			[Message.wMsgATCNAVYDepartureNull] = nil,
				[Message.wMsgATCDepartureRadarContact] 		= { _('radar contact, altimeter 29.92.'), 'DEPARTURE-REPORT' }, --  [SIDE NUMBER],radar contact, altimeter 29.92.
				[Message.wMsgATCDepartureClearedToSwitch]  	= { _('cleared to switch.'), 'SWITCH' },--[SIDE NUMBER], cleared to switch.
			[Message.wMsgATCNAVYDepartureMaximum] = nil,
			[Message.wMsgATCNAVYMarshalNull] = nil,
				--[Message.wMsgATCMarshallCopyInbound]  = { _('Marshall copies'), 'marshall copies' },
				--)		//NAVY - CASE I : [SIDE NUMBER], marshal copies, [VISIBILITY],[CLOUDS], altimeter is [PRESSURE]. [CASE], [OVERHEAD], report, see me at 10.
				[Message.wMsgATCMarshallCopyTen]  = { _('update state, switch tower'), 'SWITCH_TOWER' },
				--)			//NAVY - CASE I : [SIDE NUMBER], marshal copies, switch tower.
				
				--[Message.wMsgATCMarshallCopyInbound2and3]  = { _('You are high'), 'You\’re high' },
				--)	//NAVY - CASE II and III: [SIDE NUMBER] flight, [SHIP CALLSIGN] marshal, CASE III recovery, CV-1 approach, expected final bearing [BEARING], altimeter [PRESSURE]. [SIDE NUMBER] flight, marshal mother’s [BEARING] radial, [DISTANCE] DME, angels [ALTITUDE]. Expected approach time is [TIME], approach button is button 15. 
				[Message.wMsgATCMarshallReadbackCorrect]  = { _('readback correct.'), 'READBACK' },
				--)	//NAVY - CASE II and III: [SIDE NUMBER], readback correct.
				[Message.wMsgATCMarshallRogerState]  = { _(', roger, state '), ', roger, state ' },
				--)		//NAVY - CASE II and III: [SIDE NUMBER], roger, state [FUEL LEVEL]. - answer on ESTABLISHED
				[Message.wMsgATCMarshallCopyCommencing]  = { _(', radar contact'), ', radar contact' },
				--)	//NAVY - CASE II and III: [SIDE NUMBER], radar contact [DME] miles, expected final bearing 309. - answer on COMMENCING
				[Message.wMsgATCMarshallSwitchApproach]  = { _('switch approach.'), 'SWITCH_APP' },
				--)	//NAVY - CASE II and III: [SIDE NUMBER], switch approach. 
			[Message.wMsgATCNAVYMarshalMaximum] = nil,
			[Message.wMsgATCNAVYApproachTowerNull] = nil,
				[Message.wMsgATCTowerCopyOverhead]  = { _('Paddles copies,'), 'Paddles copies,' },
					--)			//NAVY - CASE I : Paddles copies, [CASE TYPE RECOVERY] in effect. BRC [CARRIER HEADING], signal is Charlie.
				[Message.wMsgATCTowerFinalBearing]  = { _('final bearing'), 'FINAL' },
				--)			//NAVY - CASE II and III: [SIDE NUMBER], final bearing [BEARING]. - tower answer on Checking In
				[Message.wMsgATCTowerRoger]  = { _('roger'), 'ROGER' },
				--)				//NAVY - CASE II and III: [SIDE NUMBER], roger. - tower answer on Platform
				[Message.wMsgATCTowerFlyBullseye]  = { _('fly bullseye.'), 'FLY_THE_BULL' },
				--)			//NAVY - CASE II and III: [SIDE NUMBER] fly bullseye. - When aircraft intercepts final landing bearing
				[Message.wMsgATCTowerFinalContact]  = { _('final radar contact,'), 'final radar contact,' },
				--)			//NAVY - CASE II and III: [SIDE NUMBER] final radar contact, [DISTANCE TO CARRIER] miles. - At 6-8 miles the approach controller should say
				[Message.wMsgATCTowerSayNeedles]  = { _('ACLS lock on'), 'ACLS lock on' },
				--)			//NAVY - CASE II and III: [SIDE NUMBER], ACLS lock on [DISTANCE TO CARRIER] miles, say needles. - At ACLS lock on
				[Message.wMsgATCTowerConcurFlyMode2]  = { _('Concur, Fly Mode 2.'), 'CONCUR' }, --[SIDE NUMBER], Concur, Fly Mode 2.
				[Message.wMsgATCTowerApproachGlidepath]  = { _('approaching glidepath.'), 'APPROACH_GLIDEPATH' },
				--)	//NAVY - CASE II and III: [SIDE NUMBER], approaching glidepath. - Approach would normally say at 4 miles
				[Message.wMsgATCTowerCallTheBall]  = { _('call the ball'), 'call the ball' },
				--)			//NAVY - CASE II and III: [SIDE NDUMBER], [GLIDEPATH LOCATION], [COURSE LOCATION], ? mile, call the ball. - At ? mile
				[Message.wMsgATCTowerSwitchMenu]  = { _('roger'), 'ROGER' },
			[Message.wMsgATCNAVYApproachTowerMaximum] = nil,
			[Message.wMsgATCNAVYLSONull] = nil,
				[Message.wMsgATCLSORogerBall]  = { _('Roger ball'), 'LSO-ROGER-BALL' },
				--)				//NAVY - Roger ball, [WIND OVER DECK SPEED], [OPTIONAL DIRECTION]. - Answer on BALL
				[Message.wMsgATCLSOWaveOFFGear]  = { _('wave off, gear'), 'wave off, gear' },
				--)			//NAVY - [SIDE NUMBER], wave off, gear.  - IF: Landing gear is up, ? mile
				[Message.wMsgATCLSOWaveOFFFlaps]  = { _('wave off, flaps'), 'wave off, flaps' },
				--)			//NAVY - [SIDE NUMBER], wave off, flaps. - IF: Flaps are in AUTO, ? mile
				[Message.wMsgATCLSOWaveOFFWaveOFFWaveOFF]  = { _('Wave off, wave off, wave off'), 'LSO-WAVE-OFF' },
				--)	//NAVY - Wave off, wave off, wave off.   - Not in glideslope // see text for other situations
				[Message.wMsgATCLSOYoureHigh]  = { _('You are high'), 'LSO-HIGH' },
				--)				//NAVY - You’re high.   - IF: Greater than 5 degrees above 3.1 glidepath, ? mile
				[Message.wMsgATCLSOYoureLow]  = { _('You are low'), 'LSO-LOW' },
				--)				//NAVY - You’re low, POWER.   - IF: Lower than 2.7 degrees below 3.1 glidepath (below IFLOS red ball), ? mile
				[Message.wMsgATCLSOYoureGoingHigh]  = { _('You are going high'), 'LSO-GOING-HIGH' },
				--)				//NAVY - You’re going high.   - Unless corrected, aircraft will go above optimum glide - slope.
				[Message.wMsgATCLSOYoureGoingLow]  = { _('You are going low'), 'LSO-GOING-LOW' },
				--)				//NAVY - You’re going low, POWER.   - Unless corrected, aircraft will go below optimum glide - slope.
				[Message.wMsgATCLSOLinedUpLeft]  = { _('You are lined up left'), 'LSO-LINED-UP-LEFT' },
				--)			//NAVY - You’re lined up left.   - IF: Aircraft center point is 1.7 degrees or greater left of centerline, Between ? to ? Mile
				[Message.wMsgATCLSOLinedUpRight]  = { _('You are lined up right'), 'LSO-LINED-UP-RIGHT' },
				--)			//NAVY - You’re lined up right.  - IF: Aircraft center point is 1.7 degrees or greater left of centerline, Between ? to ? Mile
				[Message.wMsgATCLSODriftingLeft]  = { _('You drifting left'), 'LSO-DRIFTING-LEFT' },
				--)			//NAVY - You’re Drifting left.   - Aircraft is drifting left of center - line.
				[Message.wMsgATCLSODriftingRight]  = { _('You drifting right'), 'LSO-DRIFTING-RIGHT' },
				--)			//NAVY - You’re Drifting right.   - Aircraft is drifting right of center - line.				
				[Message.wMsgATCLSOYoureFast]  = { _('You are fast'), 'LSO-FAST' },
				--)				//NAVY - You're fast.  - IF: 7.4 or lower angle of attack.  , Between ? to ? Mile , Condition persists for 4 seconds
				[Message.wMsgATCLSOYoureSlow]  = { _('You are slow'), 'LSO-SLOW' },
				--)				//NAVY - You're slow.  - IF: 8.8 or higher angel of attack. , Between ? to ? Mile , Condition persists for 4 seconds
				[Message.wMsgATCLSOEasyNose]  = { _('Easy with the nose'), 'Easy with the nose' },
				--)				//NAVY - Easy with the nose.  - IF: Pitch changes more than 5 degrees per second., Between ? to ? Mile 
				[Message.wMsgATCLSOEasyWings]  = { _('Easy with your wings'), 'LSO-EASY-WINGS' },
				--)				//NAVY - Easy with your wings.  - IF: Roll angel exceeds 20 degrees., Between ? to ? Mile 
				[Message.wMsgATCLSOEasyIt]  = { _('Easy with it'), 'LSO-EASY' },
				--)					//NAVY - Easy with it.  - IF: REngine RPM changes more than 30% per second., Between ? to ? Mile 
				[Message.wMsgATCLSOYoureHighClose]  = { _('You are high'), 'LSO-HIGH' },
				--)			//NAVY - You're high.  - IF: RAircraft center point is 2.5 degrees above 3.1 degree glidepath, Inside ? to ? Mile 
				[Message.wMsgATCLSOPower]  = { _('Power'), 'LSO-POWER' },
				--)					//NAVY - Power.  - IF: Aircraft center point is 1.5 degrees or greater below 3.1 degree glidepath  OR Aircraft center point within 2 degrees 3.1 degree glidepath but is descending more than 1 degree per second., Inside ? to ? Mile 
				[Message.wMsgATCLSOPowerX2]  = { _('power, Power'), 'LSO-POWER-' },
				--)				//NAVY - “Power” with more annoyed inflection.  - second call, Inside ? to ? Mile 
				[Message.wMsgATCLSOPowerX3]  = { _('power, Power, POWER'), 'LSO-POWER-POWER-POWER' },
				--)				//NAVY - “power, Power, POWER” (increasing inflection).  - Aircraft center point is 2.7 degrees or greater below 3.1 degree glidepath., Inside ? to ? Mile 
				[Message.wMsgATCLSOEasyItX2]  = { _('Easy with it, easy with it'), 'LSO-EASY' },
				--)				//NAVY - “Easy with it" (With a sheepish inflection).  - after PowerX3 Greater than 1 degree per second change , Inside ? to ? Mile 
				[Message.wMsgATCLSORight4LineUp]  = { _('Right for lineup'), 'LSO-RIGHT-LINEUP' },
				--)			//NAVY - "Right for lineup".  - Aircraft center point is 1.7 degrees or greater left of centerline.Condition persists for 3 seconds , Inside ? to ? Mile 
				[Message.wMsgATCLSOLeft4LineUp]  = { _('Come left'), 'COME_LEFT' },
				--)			//NAVY - "Come left".  - Aircraft center point is 1.7 degrees or greater right of centerline.Condition persists for 3 seconds , Inside ? to ? Mile 
				[Message.wMsgATCLSOFoulDeck]  = { _('Wave off, wave off, wave off, foul deck'), 'LSO-WAVE-OFF-FOUL' },
				--)				//NAVY - “Wave off, wave off, wave off, foul deck”.  - Other aircraft on deck landing area
				[Message.wMsgATCLSOBolterX3]  = { _('Bolter!Bolter!Bolter!'), 'LSO-BOLTER' },
				
				
				[Message.wMsgATCLSOYoureLittleHigh]  	= { _('You are little high')		, 'LSO-LITTLE-HIGH' },
				[Message.wMsgATCLSOYoureLittleLow]  	= { _('You are little low')			, 'LSO-LITTLE-LOW' },
				[Message.wMsgATCLSOLittleRight4LineUp]  = { _('Little right for line up')	, 'LSO-LITTLE-RIGHT' },
				[Message.wMsgATCLSOLittleLeft4LineUp]  	= { _('Little come left')			, 'LSO-LITTLE-COME-LEFT' },
				[Message.wMsgATCLSOFlyTheBall]  		= { _('Fly the ball')				, 'LSO-FLY-THE-BALL' },
				[Message.wMsgATCLSOOnGlideslope]  		= { _('You are on glideslope')		, 'LSO-ON-GLIDESLOPE' },
				[Message.wMsgATCLSOOnCenterLine]  		= { _('You are on centerline')		, 'LSO-CENTER' },
				--[Message.wMsgATCLSOOnSpeed]  			= { _('You are on speed')			, 'LSO-ON-SPEED' },
				
				[Message.wMsgATCLSOInGlideslopeBall]    = {empty_string, ''},
				[Message.wMsgATCLSOOutOfGlideslopeClara]  = {empty_string, ''},
				
				[Message.wMsgATCYouAreNotAuthorised]  	= { _('You are not authorized to land')		, 'NOTAUTHORIZED' },
				-- auto answers
			[Message.wMsgATCNAVYLSOMaximum] = nil,
			
			--AWACS
			[Message.wMsgAWACSNull] = nil,
				[Message.wMsgAWACSVectorToBullseye] = '',
				[Message.wMsgAWACSBanditBearingForMiles] = { _('BRA'), 'BRA' },
				[Message.wMsgAWACSVectorToNearestBandit] = { _('BRA'), 'BRA' },
				[Message.wMsgAWACSPopUpGroup] = { _('pop-up group'), 'pop-up group' },
				[Message.wMsgAWACSHomeBearing] = { _('home plate'), 'home plate' },
				[Message.wMsgAWACSTankerBearing] = { _('texaco'), 'texaco' },
				[Message.wMsgAWACSContactIsFriendly] = { _('contact is friendly'), 'contact is friendly' },
				[Message.wMsgAWACSContactIsHostile] = { _('contact is hostile'), 'contact is hostile' },
				[Message.wMsgAWACSClean] = { _('clean'), 'clean' },
				[Message.wMsgAWACSMerged] = { _('MERGED'), 'MERGED' },
				[Message.wMsgAWACSNoTankerAvailable] = { _('no tanker available'), 'no tanker available' },
				[Message.wMsgAWACSPicture] = { _('picture: '), 'picture: ' },
			[Message.wMsgAWACSMaximum] = nil,
			
			--Tanker
			[Message.wMsgTankerNull] = nil,
				[Message.wMsgTankerClearedPreContact] = { _('proceed to pre-contact'), 'proceed to pre-contact' },
				[Message.wMsgTankerClearedContact] = { _('cleared contact'), 'cleared contact' },
				[Message.wMsgTankerContact] = { _('contact'), 'contact' },
				[Message.wMsgTankerReturnPreContact] = { _('return pre-contact'), 'return pre-contact' },
				[Message.wMsgTankerChicksInTow] = { _('chiks in tow, 1 mile trail'), 'chiks in tow', 'chiks in tow, 1 mile trail' },
				[Message.wMsgTankerFuelFlow] = { _('you are taking fuel'), 'you are taking fuel' },
				[Message.wMsgTankerRefuelingComplete] = { _('transfer complete'), 'transfer complete' },
				[Message.wMsgTankerDisconnectNow] = { _('disconnect'), 'disconnect' },
				[Message.wMsgTankerBreakawayBreakaway] = { _('breakaway, breakaway!'), 'breakaway', 'breakaway, breakaway!' },
			[Message.wMsgTankerMaximum] = nil,

			--FAC
			[Message.wMsgFACNull] = nil,
				[Message.wMsgFAC_CONTINUE] 								= { _('CONTINUE'), 'CONTINUE' },
				[Message.wMsgFAC_ABORT] 								= { _('ABORT! ABORT! ABORT!'), 'ABORT' },
				[Message.wMsgFAC_ABORT_ATTACK] 							= { _('ABORT! ABORT! ABORT!'), 'ABORT' },
				[Message.wMsgFAC_CLERED_HOT] 							= { _('CLEARED HOT!'), 'CLEARED HOT' },
				[Message.wMsgFAC_CLEARED_TO_ENGAGE] 					= { _('CLEARED TO ENGAGE'), 'CLEARED TO ENGAGE' },
				[Message.wMsgFAC_CLEARED_TO_DEPART] 					= { _('you may depart'), 'you may depart' },
				[Message.wMsgFACNoTaskingAvailableStandBy] 				= { _('no tasking available for now. Standby'), 'standby' },
				[Message.wMsgFACNoTaskingAvailable] 					= { _('no tasking available'), 'no tasking available' },
				[Message.wMsgFACType1InEffectAdviseWhenReadyFor9Line] 	= { _('type 1 in effect. Advise when ready for 9-line'), 'type 1', 'type 1 in effect. Advise when ready for 9-line' },
				[Message.wMsgFACType2InEffectAdviseWhenReadyFor9Line]	= { _('type 2 in effect. Advise when ready for 9-line'), 'type 2', 'type 2 in effect. Advise when ready for 9-line' },
				[Message.wMsgFACType3InEffectAdviseWhenReadyFor9Line] 	= { _('type 3 in effect. Advise when ready for 9-line'), 'type 3', 'type 3 in effect. Advise when ready for 9-line' },
				[Message.wMsgFACAdviseWhenReadyForRemarksAndFutherTalkOn] = { _('advise when ready for remarks and further talk-on'), 'advise when ready for remarks and further talk-on' },
				[Message.wMsgFACStandbyForData]							= { _('standby data'), 'standby data' },
				[Message.wMsgFACReadBackCorrect] 						= { _('readback correct'), 'readback correct' },
				[Message.wMsgFACNoTaskingAvailableClearedToDepart] 		= { _('no further tasking available. '), 'no further tasking available' },
				[Message.wMsgFACReport_IP_INBOUND] 						= { _('report IP INBOUND'), 'report IP INBOUND' },
				[Message.wMsgFACReportWhenAttackComplete] 				= { _('Report when attack complete'), 'Report when attack complete' },
				[Message.wMsgFACThatIsYourTarget] 						= { _('that is your target'), 'that is your target' },
				[Message.wMsgFACThatIsNotYourTarget] 					= { _('that is not your target!'), 'that is not your target' },
				[Message.wMsgFACThatIsFriendly] 						= { _('that is friendly'), 'that is friendly' },
				[Message.wMsgFACYourTarget] 							= '',	-- :)
				[Message.wMsgFAC9lineBrief] 							= { _('line is as follows'), 'line is as follows' },
				[Message.wMsgFAC9lineBriefWP] 							= { _('line is as follows'), 'line is as follows' },
				[Message.wMsgFAC9lineBriefWPLaser]						= { _('line is as follows'), 'line is as follows' },
				[Message.wMsgFAC9lineBriefIRPointer] 					= { _('line is as follows'), 'line is as follows' },
				[Message.wMsgFAC9lineBriefLaser] 						= { _('line is as follows'), 'line is as follows' },
				[Message.wMsgFAC9lineRemarks] 							= '',
				[Message.wMsgFACTargetDescription] 						= { _('your target is'), 'your target is' },
				[Message.wMsgFACTargetHit]								= { _('target hit'), 'target hit' },
				[Message.wMsgFACTargetDestroyed]						= { _('target destroyed'), 'target destroyed' },
				[Message.wMsgFACTargetPartiallyDestroyed] 				= '',
				[Message.wMsgFACTargetNotDestroyed] 					= { _('target not destroyed. Cleared to re-attack'), 'target not destroyed' },
				[Message.wMsgUseWeapon]									= '',
				[Message.wMsgFACMarkOnDeck] 							= { _('mark is on the deck'), 'mark is on the deck' },
				[Message.wMsgFACFromTheMark] 							= { _('from the mark'), 'from the mark' },
				[Message.wMsgFAC_SPARKLE] 								= { _('SPARKLE RESPOND'), 'SPARKLE'},
				[Message.wMsgFAC_SNAKE] 								= { _('SNAKE RESPOND'), 'SNAKE'},
				[Message.wMsgFAC_PULSE] 								= { _('PULSE RESPOND'), 'PULSE'},
				[Message.wMsgFAC_STEADY] 								= { _('STEADY RESPOND'), 'STEADY'},
				[Message.wMsgFAC_STOP] 									= { _('STOP RESPOND'), 'STOP'},
				[Message.wMsgFAC_ROPE] 									= { _('ROPE RESPOND'), 'ROPE'},
				[Message.wMsgFAC_LASER_ON] 								= { _('LASER ON RESPOND'), 'LASER ON'},
				[Message.wMsgFAC_LASING] 								= { _('LASING'), 'LASING' },
				[Message.wMsgFAC_SHIFT] 								= { _('SHIFT RESPOND'), 'SHIFT'},
				[Message.wMsgFAC_TERMINATE] 							= { _('TERMINATE RESPOND'), 'TERMINATE'},
				--[Message.wMsgFAC_NoMark] 								= { _('no mark'), 'no mark'},
				[Message.wMsgFAC_SAM_launch]							= { _('SAM launch'), 'SAM launch' },
				[Message.wMsgFACAreYouReadyToCopy]						= { _('are you ready to copy?'), 'are you ready to copy' },
				[Message.wMsgFACWhereAreYouGoing]						= { _('where are you going?'), 'where are you going' },
				[Message.wMsgFACDoYouSeeTheMark]						= { _('do you see the mark?'), 'do you see the mark' },			
			[Message.wMsgFACMaximum] = nil,

			--Ground Crew
			[Message.wMsgGroundCrewNull] = nil,
				[Message.wMsgGroundCrewCopy]	 = { _('copy'), 'copy' },	   --Copy  that] = '',
				[Message.wMsgGroundCrewNegative] = { _('unable to comply'), 'unable to comply' },      --
				[Message.wMsgGroundCrewReloadDone] = { _('rearming complete'), 'rearming complete' },    --Reload done,sir!
				[Message.wMsgGroundCrewRefuelDone] = { _('refueling complete'), 'refueling complete' },    --Refuel done,sir!
				[Message.wMsgGroundCrewHMSDone] = { _('HMS installed'), 'HMS installed' },       --There is your HMS,sir!
				[Message.wMsgGroundCrewNVGDone] = { _('NVG installed'), 'NVG installed' },       --There is your gogles,sir!
				[Message.wMsgGroundCrewGroundPowerOn] = { _('ground power is now on'), 'ground power is now on' }, --Ground power on,sir!
				[Message.wMsgGroundCrewGroundPowerOff] = { _('ground power is now off'), 'ground power is now off' },--Ground power off,sir!
				[Message.wMsgGroundCrewWheelChocksOn] = { _('wheel chocks are now placed'), 'wheel chocks are now placed' }, --wheel chocks are placed,sir!
				[Message.wMsgGroundCrewWheelChocksOff] = { _('wheel chocks are now removed'), 'wheel chocks are now removed' },--wheel chocks are removed,sir!
				[Message.wMsgGroundCrewCanopyOpenes] = { _('open canopy'), 'open canopy' }, --open canopy ,sir!
				[Message.wMsgGroundCrewCanopyCloses] = { _('close canopy'), 'close canopy' }, --close canopy,sir!
				[Message.wMsgGroundCrewGroundAirOn] = { _('ground air supply is now connected'), 'ground air supply is now connected' }, --Ground air supply on,sir!
				[Message.wMsgGroundCrewGroundAirOff] = { _('ground air supply is now disconnected'), 'ground air supply is now disconnected' },--Ground air supply off,sir!
				[Message.wMsgGroundCrewGroundAirDone] = { _('air is now applied'), 'air is now applied' },--Ground air supply applied,sir!
				[Message.wMsgGroundCrewGroundAirFailed] = { _('unable to comply, air source isn\'t connected'), 'unable to comply, air source isn\'t connected' },--can't apply air,sir!
				[Message.wMsgGroundCrewTurboGearOn] = { _('turbo gear is now on'), 'turbo gear is now on' },   --Turbo gear on ,sir!
				[Message.wMsgGroundCrewTurboGearOff] = { _('turbo gear is now off'), 'turbo gear is now off' },  --Turbo gear off,sir!
				[Message.wMsgGroundCrewStop] = { _('Hey! What are you doing!'), 'Hey What are you doing'},        --What hell are you doing ,man !!!!
				[Message.wMsgGroundCrewClear] = { _('Clear!'), 'clear'}, -- Clear!
				[Message.wMsgGroundDone] = '',
				[Message.wMsgGroundCrewNegativeAircraftOnTheMove] =         { _("No can do - Stop your plane!"),                                                'unable to comply' },
				[Message.wMsgGroundCrewNegativeShutDownAircraft] =          { _("No can do - Shut down aircraft to perform work on the airframe"),              'unable to comply' },
				[Message.wMsgGroundCrewNegativeBringDownEngines] =          { _("No can do - Can't walk up to you, idle your engines"),                         'unable to comply' },
				[Message.wMsgGroundCrewNegativeShutDownEngines] =           { _("No can do - Shut down your engines"),                                          'unable to comply' },
				[Message.wMsgGroundCrewNegativeFireHazard] =                { _("No can do - Fire hazard, square away the leaks first"),                        'unable to comply' },
				[Message.wMsgGroundCrewNegativeSystemDamaged] =             { _("No can do - Can't work on the system, needs repairing or replacing first"),    'unable to comply' },
				[Message.wMsgGroundCrewNegativeNoAccessToCabin] =           { _("No can do - Give access to cabin first"),                                      'unable to comply' },
				[Message.wMsgGroundCrewNegativeNoAccessToSystem] =          { _("No can do - Give access to the system"),                                       'unable to comply' },
				[Message.wMsgGroundCrewNegativeNoResources] =               { _("No can do - We don't have this in stock"),                                     'unable to comply' },
				[Message.wMsgGroundCrewNegativeAlreadyDone] =               { _("Won't do - It's already done"),                                                'unable to comply' },
				[Message.wMsgGroundCrewNegativeCrewUnderFire] =             { _("No can do - We're taking fire!"),                                              'unable to comply' },
				[Message.wMsgGroundCrewNegativeUnfeasibleConfiguration] =   { _("No can do - We can't set up the aircraft this way"),                           'unable to comply' },
			[Message.wMsgGroundCrewMaximum] = nil,
			
			--ССС
			[Message.wMsgNull] = nil,
				[Message.wMsgCCCFollowTo] = { _('follow to'), 'follow to' },
				[Message.wMsgCCCTasking] = { _('your mission number is'), 'your mission number is' },
				[Message.wMsgCCCResume] = { _('resume your misson'), 'resume your misson' },
				[Message.wMsgCCCRTB] = { _('return to base'), 'return to base' },
			[Message.wMsgMaximum] = nil,
		[Message.wMsgServiceMaximum] = nil,
		
		--Betty
		[Message.wMsgBettyNull] = nil,
			[Message.wMsgBettyLeftEngineFire] = {_('Left Engine Fire'), 'LeftEngineFire'},
			[Message.wMsgBettyRightEngineFire] = {_('Right Engine Fire'), 'RightEngineFire'},
			[Message.wMsgBettyMaximumAOA] = {_('Maximum Angle Of Attack, Maximum G'), 'MaximumAngleOfAttack'},
			[Message.wMsgBettyAOAOverLimit] = {_('Angle Of Attack Over Limit'), 'AngleOfAttackOverLimit'},
			[Message.wMsgBettyMaximumG] = {_('Maximum G'), 'MaximumG'},
			[Message.wMsgBettyGearDown] = {_('Gear Down'), 'GearDown'},
			[Message.wMsgBettyGearUp] = {_('Gear Up'), 'GearUp'},
			[Message.wMsgBettyMaximumSpeed] = {_('Maximum Speed'), 'MaximumSpeed'},
			[Message.wMsgBettyMinimumSpeed] = {_('Minimum Speed'), 'MinimumSpeed'},
			[Message.wMsgBettyMissile3Low] = {_('Missile 3 O\'Clock Low'), 'Missile3OClockLow'},
			[Message.wMsgBettyMissile3High] = {_('Missile 3 O\'Clock High'), 'Missile3OClockHigh'},
			[Message.wMsgBettyMissile6Low] = {_('Missile 6 O\'Clock Low'), 'Missile6OClockLow'},
			[Message.wMsgBettyMissile6High] = {_('Missile 6 O\'Clock High'), 'Missile6OClockHigh'},
			[Message.wMsgBettyMissile9Low] = {_('Missile 9 O\' Clock Low'), 'Missile9OClockLow'},
			[Message.wMsgBettyMissile9High] = {_('Missile 9 O\'Clock High'), 'Missile9OClockHigh'},
			[Message.wMsgBettyMissile12Low] = {_('Missile 12 O\'Clock Low'), 'Missile12OClockLow'},
			[Message.wMsgBettyMissile12High	] = {_('Missile 12 O\'Clock High'), 'Missile12OClockHigh'},
			[Message.wMsgBettyBingoFuel] = {_('Bingo'), 'Bingo'},
			[Message.wMsgBettyAttitudeIndicatorFailure] = {_('Attitude Indication Failure'), 'Attitude Indication Failure'},
			[Message.wMsgBettyRadarFailure] = {_('Radar Failure'), 'RadarFailure'},
			[Message.wMsgBettyEOSFailure] = {_('EOS Failure'), 'EOSFailure'},
			[Message.wMsgBettySystemsFailure] = {_('Systems Failure'), 'SystemsFailure'},
			[Message.wMsgBettyTWSFailure] = {_('TWS Failure'), 'TWSFailure'},
			[Message.wMsgBettyMLWSFailure] = {_('MLWS Failure'), 'MLWSFailure'},
			[Message.wMsgBettyECMFailure] = {_('ECM Failure'), 'ECMFailure'},
			[Message.wMsgBettyNCSFailure] = {_('NCS Failure'), 'NCSFailure'},
			[Message.wMsgBettyACSFailure] = {_('ACS Failure'), 'ACSFailure', 'A ci eS failure. Take manual control'},
			[Message.wMsgBettyThrottleBackLeftEngine] = {_('Throttle Back Left Engine'), 'ThrottleBackLeftEngine'},
			[Message.wMsgBettyThrottleBackRightEngine] = {_('Throttle Back Right Engine'), 'ThrottleBackRightEngine'},
			[Message.wMsgBettyPower] = {_('Power'), 'Power'},
			[Message.wMsgBettyHydrolicsFailure] = {_('Hydrolics Failure'), 'HydrolicsFailure'},
			[Message.wMsgBettyEject] = {_('Eject'), 'Eject'},
			[Message.wMsgBettyGOverLimit] = {_('G Over Limit'), 'GOverLimit'},
			[Message.wMsgBettyFuel1500] = {_('Fuel 1500'), 'Fuel1500'},
			[Message.wMsgBettyFuel800] = {_('Fuel 800'), 'Fuel800'},
			[Message.wMsgBettyFuel500] = {_('Fuel 500'), 'Fuel500'},
			[Message.wMsgBettyPullUp] = {_('Pull Up'), 'PullUp'},
			[Message.wMsgBettyLaunchAuthorised] = {_('Launch Authorised'), 'LaunchAuthorised'},
			[Message.wMsgBettyMissileMissile] = {_('Missile Missile'), 'MissileMissile'},
			[Message.wMsgBettyShootShoot] = {_('Shoot Shoot'), 'ShootShoot'},
			[Message.wMsgBettyFlightControls] = {_('Flight Controls'), 'FlightControls'},
			[Message.wMsgBettyWarningWarning] = {_('Warning Warning'), 'WarningWarning'},
			[Message.wMsgBettyMessageBegin] = {empty_string, ''},
			[Message.wMsgBettyMessageEnd] = {empty_string, ''},
			[Message.wMsgBettyGearDownSingle] = {empty_string, ''},
			[Message.wMsgBettyCancel] = {empty_string, ''},
			[Message.wMsgBettyTakeManualControl] = {_('Take manual control'), 'APDisengage', 'Upravlay vrutchnuiy'}, -- 'Управляй вручную' (Су-27, Су-33)
		[Message.wMsgBettyMaximum] = nil,

		--Ka-50 ALMAZ messages
		[Message.wMsgALMAZ_Null] = nil,
			[Message.wMsgALMAZ_IS_READY] = {_('Voice message system is ready'), 'IS_READY'},					--Речевой информатор исправен
			[Message.wMsgALMAZ_WATCH_EKRAN]= {_('Watch EKRAN'), 'WATCH_EKRAN'},					--Смотри УСТ
			[Message.wMsgALMAZ_THREAT]= {_('Attack. Take care!'), 'THREAT'},						--Атака берегись
			[Message.wMsgALMAZ_CHECK_OIL_PRESS_LEFT_TRANSM]= {_('Check oil pressure left transmission'), 'CHECK_OIL_PRESS_LEFT_TRANSM'},	--Проверь давление масла левого редуктора
			[Message.wMsgALMAZ_CHECK_OIL_PRESS_RIGHT_TRANSM]= {_('Check oil pressure right transmission'), 'CHECK_OIL_PRESS_RIGHT_TRANSM'},--Проверь давление масла правого редуктора
			[Message.wMsgALMAZ_LEFT_ENG_FIRE]= {_('Left engine fire'), 'LEFT_ENG_FIRE'},   			--Пожар левого двигателя
			[Message.wMsgALMAZ_RIGHT_ENG_FIRE]= {_('Right engine fire'), 'RIGHT_ENG_FIRE'},				--Пожар правого двигателя
			[Message.wMsgALMAZ_APU_FIRE]	= {_('APU fire'), 'APU_FIRE'},				--Пожар вспомогательной силовой установки
			[Message.wMsgALMAZ_HYDRO_FIRE]= {_('Hydro fire'), 'HYDRO_FIRE'},					--Пожар в отсеке гидравлики
			[Message.wMsgALMAZ_FAN_FIRE]= {_('Fan fire'), 'FAN_FIRE'},					--Пожар в отсеке вентиляции
			[Message.wMsgALMAZ_LEFT_ENG_TORQUE]= {_('Left engine torque'), 'LEFT_ENG_TORQUE'},				--Раскрутка турбины левого двигателя
			[Message.wMsgALMAZ_RIGHT_ENG_TORQUE]= {_('Right engine torque'), 'RIGHT_ENG_TORQUE'},			--Раскрутка турбины правого двигателя
			[Message.wMsgALMAZ_DANGER_ENG_VIBR]= {_('Danger engine vibration'), 'WATCH_EKRAN'},				--Опасно вибрация двигателя
			[Message.wMsgALMAZ_DATA]= {_('Take data'), 'DATA'},                       	--Принять ЦУ
			[Message.wMsgALMAZ_MAIN_HYDRO]= {_('Main hydro failure'), 'MAIN_HYDRO'},					--Отказ основной гидросистемы
			[Message.wMsgALMAZ_COMMON_HYDRO]= {_('Common hydro failure'), 'COMMON_HYDRO'},    			--Отказ вспомогательной гидросистемы
			[Message.wMsgALMAZ_LOWER_GEAR]= {_('Lower gear'), 'LOWER_GEAR'},					--Выпусти шасси
			[Message.wMsgALMAZ_CHECK_MAIN_TRANSM]= {_('Check main transmission'), 'CHECK_MAIN_TRANSM'},			--Проверь параметры масла главного редуктора
			[Message.wMsgALMAZ_TURN_ON_BACKUP_TRANSP]= {_('Turn on backup transponder code'), 'TURN_ON_BACKUP_TRANSP'},		--Включи запасной код ответчика
			[Message.wMsgALMAZ_ELEC_ON_ACCUM]= {_('Electric on accumulator'), 'ELEC_ON_ACCUM'},				--Сеть на аккумуляторе
			[Message.wMsgALMAZ_USE_TV]= {_('Use TV'), 'USE_TV'},						--Работай по телевизору
			[Message.wMsgALMAZ_USE_MANUAL_ATTACK_KI_TV]= {_('Use manual attack KI TV'), 'USE_MANUAL_ATTACK_KI_TV'},		--Включи резервное управление. Работай по коллиматору и телевизору
			[Message.wMsgALMAZ_FAILURE_WCS_ROCKET]= {_('WCS rocket failure'), 'FAILURE_WCS_ROCKET'},			--Отказ СУО. Нет управления подвесками
			[Message.wMsgALMAZ_GUN_ACTUATOR_FAILURE]= {_('Gun actuator failure'), 'GUN_ACTUATOR_FAILURE'}, 		--Отказ ППУ
			[Message.wMsgALMAZ_MIN_FUEL]= {_('Fuel low'), ''},					--Минимальный остаток топлива
			[Message.wMsgALMAZ_TURN_ON_ROTOR_ANTIICE]= {_('Turn on rotor antiice'), 'TURN_ON_ROTOR_ANTIICE'},		--Обледенение. Включи ПОС винтов.
			[Message.wMsgALMAZ_RADIO_ALT]= {_('radio altimeter failure'), 'RADIO_ALT'},					--Отказ радиовысотомера
			[Message.wMsgALMAZ_INS]= {_('INS failure'), 'INS'},							--Отказ курсовертикали
			[Message.wMsgALMAZ_TURN_ON_GRID_USE_FIXED_GUN]= {_('Turn on grid use fixed gun'), 'TURN_ON_GRID_USE_FIXED_GUN'},	--Включи сетку коллиматора. Работай с неподвижной ПУ.
			[Message.wMsgALMAZ_TURN_ON_DC_AC_CONVERT]= {_('Turn on DC AC converter'), 'TURN_ON_DC_AC_CONVERT'},		--Включи преобразователь
			[Message.wMsgALMAZ_CHECK_LEFT_TRANSM]= {_('Check left transmission'), 'CHECK_LEFT_TRANSM'},			--Проверь параметры масла левого редуктора
			[Message.wMsgALMAZ_CHECK_RIGHT_TRANSM]= {_('Check right transmission'), 'CHECK_RIGHT_TRANSM'},			--Проверь параметры масла правого редуктора
			[Message.wMsgALMAZ_ACTUATOR_OIL_PRESSURE]= {_('Actuator oil pressure'), 'ACTUATOR_OIL_PRESSURE'},		--Мало давление масла приводов
			[Message.wMsgALMAZ_FAILURE_LEFT_PROBE_HEATER]= {_('Left probe heater failure'), 'FAILURE_LEFT_PROBE_HEATER'},	--Отказ обогрева ПВД левого
			[Message.wMsgALMAZ_FAILURE_RIGHT_PROBE_HEATER]= {_('Right probe heater failure'), 'FAILURE_RIGHT_PROBE_HEATER'},	--Отказ обогрева ПВД правого
			[Message.wMsgALMAZ_DNS]= {_('DNS failure'), 'DNS'},     					--Отказ доплеровского измерителя скорости
			[Message.wMsgALMAZ_FAILURE_NAV_POSITION]= {_('Navigation position failure'), 'FAILURE_NAV_POSITION'},		--Нет счисления координат
			[Message.wMsgALMAZ_GENERATOR_FAILURE]= {_('Generator failure'), 'GENERATOR_FAILURE'},			--Отказ генератора
			[Message.wMsgALMAZ_DC_RECTIF_FAILURE]= {_('DC rectifier failure'), 'DC_RECTIF_FAILURE'},			--Отказ выпрямителя
			[Message.wMsgALMAZ_ENG_DIGITAL_CONTROL_FAILURE]= {_('Engine digital control failure'), 'ENG_DIGITAL_CONTROL_FAILURE'},	--Отказ электронного регулятора двигателя
			[Message.wMsgALMAZ_LOW_COCKPIT_PRESSURE]= {_('Low cockpit pressure'), 'LOW_COCKPIT_PRESSURE'},		--разгерметизация кабины. Выходи из зоны.
			[Message.wMsgALMAZ_NO_HYDRO_PRESSURE]= {_('No hydro pressure'), 'NO_HYDRO_PRESSURE'},			--Нет давления наддува гидросистемы
			[Message.wMsgALMAZ_FAILURE_AIRCOND]= {_('Conditioning and ventilation failure'), 'FAILURE_AIRCOND'},				--Отказ кондиционирования и вентиляции в кабине
			[Message.wMsgALMAZ_FAILURE_ROTOR_ANTIICE]= {_('Rotor antiice failure'), 'FAILURE_ROTOR_ANTIICE'}, 		--Отказ ПОС винтов
			[Message.wMsgALMAZ_NO_MOV_GUN_STOP]= { _('No move gun stop'), 'NO_MOV_GUN_STOP'},				--Нет стопора ППУ
		[Message.wMsgALMAZ_Maximum]= '',

		--Mi8 RI65 messages
		[Message.wMsgRI65_Null] = nil,
			[Message.wMsgRI65_IS_READY] =						{_('RI-65 is operable'), 'device RI-65 is without fail'},	-- Речевой информатор исправен
			[Message.wMsgRI65_LEFT_ENGINE_FIRE] =				{_('left engine fire'), 'left engine fire'},				-- Пожар в отсеке левого двигателя
			[Message.wMsgRI65_RIGHT_ENGINE_FIRE] =				{_('right engine fire'), 'right engine fire'},				-- Пожар в отсеке правого двигателя
			[Message.wMsgRI65_MAIN_TRANSMISSION_FIRE] =			{_('main transmission fire'), 'main transmission fire'},	-- Пожар в отсеке главного редуктора
			[Message.wMsgRI65_HEATER_FIRE] =					{_('aircraft heater fire'), 'aircraft heater fire'},		-- Пожар в отсеке обогревателя
			[Message.wMsgRI65_SWITCH_OFF_LEFT_ENGINE] =			{_('switch off left engine'), 'switch off left engine'},	-- Выключи левый двигатель
			[Message.wMsgRI65_SWITCH_OFF_RIGHT_ENGINE] =		{_('switch off right engine'), 'switch off right engine'},	-- Выключи правый двигатель
			[Message.wMsgRI65_LEFT_ENGINE_VIBRATION] =			{_('left engine vibration'), 'left engine vibration'},		-- Опасная вибрация левого двигателя
			[Message.wMsgRI65_RIGHT_ENGINE_VIBRATION] =			{_('right engine vibration'), 'right engine vibration'},	-- Опасная вибрация правого двигателя
			[Message.wMsgRI65_MAIN_HYDRO_FAILURE] =				{_('main hydraulics failure'), 'main hydraulics failure'},	-- Отказала основная гидросистема
			[Message.wMsgRI65_EMERGENCY_FUEL] =					{_('emergency fuel'), 'emergency fuel'},					-- Аварийный остаток топлива
			[Message.wMsgRI65_ICING] =							{_('icing'), 'icing'},										-- Обледенение
			[Message.wMsgRI65_TRANSMISSION_MALFUNCTION] =		{_('transmission malfunction'), 'transmission malfunction'},	-- Неисправность в редукторах
			[Message.wMsgRI65_GENERATOR1_FAILURE] =				{_('first generator failure'), 'first generator failure'},		-- Отказал первый генератор
			[Message.wMsgRI65_GENERATOR2_FAILURE] =				{_('second generator failure'), 'second generator failure'},	-- Отказал второй генератор
			[Message.wMsgRI65_PUMP_FEEDER_FUEL_TANK_FAILURE] =	{_('pump the feeder fuel tank failure'), 'pump the feeder fuel tank failure'},	-- Отказал насос расходного бака
			[Message.wMsgRI65_PUMPS_MAIN_FUEL_TANKS_FAILURE] =	{_('pumps the main fuel tanks failure'), 'pumps the main fuel tanks failure'},	-- Отказали насосы основных топливных баков
			[Message.wMsgRI65_BOARD] =		{_('board'), 'board'},	-- борт
			[Message.wMsgRI65_0_BEGIN] =	{_('0'), '0-begin'},	-- 0
			[Message.wMsgRI65_0_END] =		{_('0'), '0-end'},		-- 0
			[Message.wMsgRI65_1_BEGIN] =	{_('1'), '1-begin'},	-- 1
			[Message.wMsgRI65_1_END] =		{_('1'), '1-end'},		-- 1
			[Message.wMsgRI65_2_BEGIN] =	{_('2'), '2-begin'},	-- 2
			[Message.wMsgRI65_2_END] =		{_('2'), '2-end'},		-- 2
			[Message.wMsgRI65_3_BEGIN] =	{_('3'), '3-begin'},	-- 3
			[Message.wMsgRI65_3_END] =		{_('3'), '3-end'},		-- 3
			[Message.wMsgRI65_4_BEGIN] =	{_('4'), '4-begin'},	-- 4
			[Message.wMsgRI65_4_END] =		{_('4'), '4-end'},		-- 4
			[Message.wMsgRI65_5_BEGIN] =	{_('5'), '5-begin'},	-- 5
			[Message.wMsgRI65_5_END] =		{_('5'), '5-end'},		-- 5
			[Message.wMsgRI65_6_BEGIN] =	{_('6'), '6-begin'},	-- 6
			[Message.wMsgRI65_6_END] =		{_('6'), '6-end'},		-- 6
			[Message.wMsgRI65_7_BEGIN] =	{_('7'), '7-begin'},	-- 7
			[Message.wMsgRI65_7_END] =		{_('7'), '7-end'},		-- 7
			[Message.wMsgRI65_8_BEGIN] =	{_('8'), '8-begin'},	-- 8
			[Message.wMsgRI65_8_END] =		{_('8'), '8-end'},		-- 8
			[Message.wMsgRI65_9_BEGIN] =	{_('9'), '9-begin'},	-- 9
			[Message.wMsgRI65_9_END] =		{_('9'), '9-end'},		-- 9
		[Message.wMsgRI65_Maximum]= '',

		[Message.wMsgAutopilotAdjustment_Null] = nil,
			[Message.wMsgAutopilotAdjustment_AdjustingPitchChannel] =	{_('adjusting pitch channel'), 'adjusting pitch channel'},	-- подстраиваю тангаж
			[Message.wMsgAutopilotAdjustment_AdjustingRollChannel] =	{_('adjusting roll channel'), 'adjusting roll channel'},	-- подстраиваю крен
		[Message.wMsgAutopilotAdjustment_Maximum]= '',
		
		--External Cargo: flight engineer
		[Message.wMsgExternalCargo_Null] = nil,
			[Message.wMsgExternalCargo_meter] =	{_('meter'), 'meter'},	
			[Message.wMsgExternalCargo_two] =	{_('two'), 'two'},	
			[Message.wMsgExternalCargo_three] =	{_('three'), 'three'},
			[Message.wMsgExternalCargo_five] =	{_('five'), 'five'},
			[Message.wMsgExternalCargo_ten] =	{_('ten'), 'ten'},
			[Message.wMsgExternalCargo_fifteen] =	{_('ten'), 'fifteen'},
			[Message.wMsgExternalCargo_twenty] ={_('twenty'), 'twenty'},
			[Message.wMsgExternalCargo_thirty] =	{_('thirty'), 'thirty'},
			[Message.wMsgExternalCargo_fifty] =	{_('fifty'), 'fifty'},
			[Message.wMsgExternalCargo_sixty] =	{_('sixty'), 'sixty'},
			[Message.wMsgExternalCargo_one_hundred] =	{_('one_hundred'), 'one_hundred'},
			[Message.wMsgExternalCargo_one_hundred_and_fifty] =	{_('one_hundred_and_fifty'), 'one_hundred_and_fifty'},
			[Message.wMsgExternalCargo_above] =	{_('above'), 'above'},
			[Message.wMsgExternalCargo_below] =	{_('below'), 'below'},
			[Message.wMsgExternalCargo_back] =	{_('back'), 'back'},
			[Message.wMsgExternalCargo_forward] =	{_('forward'), 'forward'},
			[Message.wMsgExternalCargo_left] =	{_('left_crg'), 'left'},
			[Message.wMsgExternalCargo_right] =	{_('right_crg'), 'right'},
			[Message.wMsgExternalCargo_hold_height]={empty_string, 'hold_height'},
			[Message.wMsgExternalCargo_at_height]={empty_string, 'at_height'},
			[Message.wMsgExternalCargo_lock_closed] =	{_('lock_closed'), 'lock_closed'},
			[Message.wMsgExternalCargo_cargo_hooked] =	{_('cargo_hooked'), 'cargo_hooked'},
			[Message.wMsgExternalCargo_end] =	{empty_string, '_end'},
			[Message.wMsgExternalCargo_start] =	{empty_string, '_start'},
			[Message.wMsgExternalCargo_above_cargo] =	{empty_string, 'above_cargo'},
			[Message.wMsgExternalCargo_taut_of_rope] = {empty_string, 'taut_of_rope'},
			[Message.wMsgExternalCargo_rope_was_taut]={empty_string, 'rope_was_taut'},
			[Message.wMsgExternalCargo_meter_ground]={empty_string, 'meter_ground'},
			[Message.wMsgExternalCargo_three_ground]={empty_string, 'three_ground'},
			[Message.wMsgExternalCargo_five_ground]={empty_string, 'five_ground'},
			[Message.wMsgExternalCargo_ten_ground]={empty_string, 'ten_ground'},
			[Message.wMsgExternalCargo_fifteen_ground]={empty_string, 'fifteen_ground'},
			[Message.wMsgExternalCargo_cargo_ropes_normal] = {empty_string, 'cargo_ropes_normal'},
			[Message.wMsgExternalCargo_cargo_ropes_normal_2] = {empty_string, 'cargo_ropes_normal_2'},
			[Message.wMsgExternalCargo_longitudinal_swing] = {empty_string, 'longitudinal_swing'},
			[Message.wMsgExternalCargo_transverse_swing] = {empty_string, 'transverse_swing'},
			[Message.wMsgExternalCargo_sixty_to_ground]={empty_string, 'sixty_to_ground'},
			[Message.wMsgExternalCargo_thirty_to_ground]={empty_string, 'thirty_to_ground'},
			[Message.wMsgExternalCargo_twenty_to_ground]={empty_string, 'twenty_to_ground'},
			[Message.wMsgExternalCargo_ten_to_ground]={empty_string, 'ten_to_ground'},
			[Message.wMsgExternalCargo_three_to_ground]={empty_string, 'three_to_ground'},
			[Message.wMsgExternalCargo_one_to_ground]={empty_string, 'one_to_ground'},
			[Message.wMsgExternalCargo_cargo_ground_reset]={empty_string, 'cargo_ground_reset'},
			[Message.wMsgExternalCargo_over_the_zone]={empty_string, 'over_the_zone'},
			[Message.wMsgExternalCargo_rope_is_torn]={empty_string, 'rope_is_torn'},
			[Message.wMsgExternalCargo_cargo_is_unhooked]={empty_string, 'cargo_is_unhooked'},
			[Message.wMsgExternalCargo_rope_near_luke]={empty_string, 'rope_near_luke'},
		[Message.wMsgExternalCargo_Maximum] = '',	
		
		-- Mi-8 Checklist Messages
		[Message.wMsgMi8_Checklist_Null] = nil,
			[Message.wMsgMi8_Checklist_CM_BeforeAPU]								= { _('crew, I read the card BEFORE START THE APU'),		'Checklist//01//00' },
				[Message.wMsgMi8_Checklist_ITEM_Accums]								= { _('accumulators'),										'Checklist//01//01' },
				[Message.wMsgMi8_Checklist_ANSWER_Accums_On_VoltageNorm]			= { _('turned on, voltage normal'),							'Checklist//01//01_00' },
				[Message.wMsgMi8_Checklist_ITEM_Recorder]							= { _('recorder'),											'Checklist//01//02' },
				[Message.wMsgMi8_Checklist_ANSWER_Recorder_On_Works]				= { _('turned on, working'),								'Checklist//01//02_00' },
				[Message.wMsgMi8_Checklist_ITEM_CommHearing]						= { _('spu hearing'),										'Checklist//01//03' },
				[Message.wMsgMi8_Checklist_ANSWER_CommHearing_Good_1]				= { _('good'),												'Checklist//01//03_00' },
				[Message.wMsgMi8_Checklist_ANSWER_CommHearing_Good_2]				= { _('good'),												'Checklist//01//03_01' },
				[Message.wMsgMi8_Checklist_ANSWER_CommHearing_Good_3]				= { _('good'),												'Checklist//01//03_02' },
				[Message.wMsgMi8_Checklist_ITEM_CollectiveLock]						= { _('collective lock'),									'Checklist//01//04' },
				[Message.wMsgMi8_Checklist_ANSWER_CollectiveLock_Opened]			= { _('opened'),											'Checklist//01//04_00' },
				[Message.wMsgMi8_Checklist_ITEM_SPUU]								= { _('spuu'),												'Checklist//01//05' },
				[Message.wMsgMi8_Checklist_ANSWER_SPUU_On_OK]						= { _('turned on, OK'),										'Checklist//01//05_00' },
				[Message.wMsgMi8_Checklist_ITEM_Stick]								= { _('stick and pedals'),									'Checklist//01//06' },
				[Message.wMsgMi8_Checklist_ANSWER_Stick_Neutral]					= { _('neutral position'),									'Checklist//01//06_00' },
				[Message.wMsgMi8_Checklist_ITEM_StartCB]							= { _('circuit breakers for start and systems'),			'Checklist//01//07' },
				[Message.wMsgMi8_Checklist_ANSWER_StartCB_On_1]						= { _('turned on'),											'Checklist//01//07_00' },
				[Message.wMsgMi8_Checklist_ANSWER_StartCB_On_2]						= { _('turned on'),											'Checklist//01//07_01' },
				[Message.wMsgMi8_Checklist_ITEM_Doors]								= { _('flaps, doors, hatches'),								'Checklist//01//08' },
				[Message.wMsgMi8_Checklist_ANSWER_Doors_Closed]						= { _('closed'),											'Checklist//01//08_00' },
				[Message.wMsgMi8_Checklist_ITEM_WheelBrakesCheck]					= { _('wheel brakes'),										'Checklist//01//09' },
				[Message.wMsgMi8_Checklist_ANSWER_WheelBrakesCheck_OK_1]			= { _('OK, on the stopper, pressure normal'),				'Checklist//01//09_00' },
				[Message.wMsgMi8_Checklist_ANSWER_WheelBrakesCheck_OK_2]			= { _('OK, on the stopper, pressure normal'),				'Checklist//01//09_01' },
				[Message.wMsgMi8_Checklist_ITEM_RotorBrake]							= { _('rotor brake'),										'Checklist//01//10' },
				[Message.wMsgMi8_Checklist_ANSWER_RotorBrake_Off]					= { _('disinhibited'),										'Checklist//01//10_00' },
				[Message.wMsgMi8_Checklist_ITEM_Throttles]							= { _('throttles'),											'Checklist//01//11' },
				[Message.wMsgMi8_Checklist_ANSWER_Throttles_Middle_Locked]			= { _('middle position, latched'),							'Checklist//01//11_00' },
				[Message.wMsgMi8_Checklist_ITEM_CollectiveCorrection]				= { _('collective, correction lever'),						'Checklist//01//12' },
				[Message.wMsgMi8_Checklist_ANSWER_CollectiveCorrection_Min_Left]	= { _('lower position, left'),								'Checklist//01//12_00' },
				[Message.wMsgMi8_Checklist_ITEM_Lamps]								= { _('annunciator lights'),								'Checklist//01//13' },
				[Message.wMsgMi8_Checklist_ANSWER_Lamps_OK_1]						= { _('OK'),												'Checklist//01//13_00' },
				[Message.wMsgMi8_Checklist_ANSWER_Lamps_OK_2]						= { _('OK'),												'Checklist//01//13_01' },
				[Message.wMsgMi8_Checklist_ANSWER_Lamps_OK_3]						= { _('OK'),												'Checklist//01//13_02' },
				[Message.wMsgMi8_Checklist_ITEM_RI]									= { _('betty'),												'Checklist//01//14' },
				[Message.wMsgMi8_Checklist_ANSWER_RI_OK]							= { _('OK'),												'Checklist//01//14_00' },
				[Message.wMsgMi8_Checklist_ITEM_Vibro]								= { _('vibration equipment'),								'Checklist//01//15' },
				[Message.wMsgMi8_Checklist_ANSWER_Vibro_OK]							= { _('OK'),												'Checklist//01//15_00' },
				[Message.wMsgMi8_Checklist_ITEM_SARPP]								= { _('flight recorder'),									'Checklist//01//16' },
				[Message.wMsgMi8_Checklist_ANSWER_SARPP_On_Manual]					= { _('turned on, manual'),									'Checklist//01//16_00' },
				[Message.wMsgMi8_Checklist_ITEM_FireExt]							= { _('fire extinguishing system'),							'Checklist//01//17' },
				[Message.wMsgMi8_Checklist_ANSWER_FireExt_OK]						= { _('fire extinguishing OK'),								'Checklist//01//17_00' },
				[Message.wMsgMi8_Checklist_ITEM_FlowSw]								= { _('consumption switch'),								'Checklist//01//18' },
				[Message.wMsgMi8_Checklist_ANSWER_FlowSw_On]						= { _('turned on'),											'Checklist//01//18_00' },
				[Message.wMsgMi8_Checklist_ITEM_FuelMeter]							= { _('fuel gauge'),										'Checklist//01//19' },
				[Message.wMsgMi8_Checklist_ANSWER_FuelMeter_OK]						= { _('OK'),												'Checklist//01//19_00' },
				[Message.wMsgMi8_Checklist_ITEM_Generators]							= { _('generators'),										'Checklist//01//20' },
				[Message.wMsgMi8_Checklist_ANSWER_Generators_Off]					= { _('disabled'),											'Checklist//01//20_00' },
				[Message.wMsgMi8_Checklist_ITEM_FuelPumps]							= { _('fuel pumps'),										'Checklist//01//21' },
				[Message.wMsgMi8_Checklist_ANSWER_FuelPumps_On]						= { _('turned on'),											'Checklist//01//21_00' },
				[Message.wMsgMi8_Checklist_ITEM_FuelShutoffValves]					= { _('fuel shutoff valves'),								'Checklist//01//22' },
				[Message.wMsgMi8_Checklist_ANSWER_FuelShutoffValves_Opened]			= { _('opened'),											'Checklist//01//22_00' },
				[Message.wMsgMi8_Checklist_ITEM_EngineShutoffValves]				= { _('engines shutdown valves levers'),					'Checklist//01//23' },
				[Message.wMsgMi8_Checklist_ANSWER_EngineShutoffValves_RearPos_1]	= { _('in the rear position'),								'Checklist//01//23_00' },
				[Message.wMsgMi8_Checklist_ANSWER_EngineShutoffValves_RearPos_2]	= { _('in the rear position'),								'Checklist//01//23_01' },
			[Message.wMsgMi8_Checklist_CM_WithAPU]									= { _('crew, I read the card WHEN THE APU RUNNING'),		'Checklist//02//00' },
				[Message.wMsgMi8_Checklist_ITEM_ParamsAPU]							= { _('APU parameters'),									'Checklist//02//01' },
				[Message.wMsgMi8_Checklist_ANSWER_ParamsAPU_Norm]					= { _('normal'),											'Checklist//02//01_00' },
				[Message.wMsgMi8_Checklist_ITEM_GeneratorAPU]						= { _('standby generator'),									'Checklist//02//02' },
				[Message.wMsgMi8_Checklist_ANSWER_GeneratorAPU_On]					= { _('turned on'),											'Checklist//02//02_00' },
				[Message.wMsgMi8_Checklist_ITEM_HydraulicSw]						= { _('hydraulic switches'),								'Checklist//02//03' },
				[Message.wMsgMi8_Checklist_ANSWER_HydraulicSw_On]					= { _('turned on'),											'Checklist//02//03_00' },
				[Message.wMsgMi8_Checklist_ITEM_BeaconLight]						= { _('beacon light'),										'Checklist//02//04' },
				[Message.wMsgMi8_Checklist_ANSWER_BeaconLight_On]					= { _('turned on'),											'Checklist//02//04_00' },
				[Message.wMsgMi8_Checklist_ITEM_Inverter115]						= { _('inverter 115 switch'),								'Checklist//02//05' },
				[Message.wMsgMi8_Checklist_ANSWER_Inverter115_Manual]				= { _('manual'),											'Checklist//02//05_00' },
				[Message.wMsgMi8_Checklist_ITEM_EnginesStartReady]					= { _('readiness for engines start'),						'Checklist//02//06' },
				[Message.wMsgMi8_Checklist_ANSWER_EnginesStartReady_Ready_1]		= { _('ready'),												'Checklist//02//06_00' },
				[Message.wMsgMi8_Checklist_ANSWER_EnginesStartReady_Ready_2]		= { _('ready'),												'Checklist//02//06_01' },
				[Message.wMsgMi8_Checklist_ANSWER_EnginesStartReady_Ready_3]		= { _('ready for start'),									'Checklist//02//06_02' },
			[Message.wMsgMi8_Checklist_CM_EnginesIdle]								= { _('crew, I read the card WITH ENGINES ON IDLE'),		'Checklist//03//00' },
				[Message.wMsgMi8_Checklist_ITEM_EnginesParams]						= { _('engines parameters'),								'Checklist//03//01' },
				[Message.wMsgMi8_Checklist_ANSWER_EnginesParams_Norm]				= { _('normal'),											'Checklist//03//01_00' },
				[Message.wMsgMi8_Checklist_ITEM_HeatPZU]							= { _('anti dust'),											'Checklist//03//02' },
				[Message.wMsgMi8_Checklist_ANSWER_HeatPZU_On]						= { _('turned on'),											'Checklist//03//02_00' },
				[Message.wMsgMi8_Checklist_ITEM_Reductors]							= { _('gearboxes'),											'Checklist//03//03' },
				[Message.wMsgMi8_Checklist_ANSWER_Reductors_Heated_OK]				= { _('warmed, OK'),										'Checklist//03//03_00' },
				[Message.wMsgMi8_Checklist_ITEM_Hydraulics]							= { _('hydraulics'),										'Checklist//03//04' },
				[Message.wMsgMi8_Checklist_ANSWER_Hydraulics_On_OK]					= { _('turned on, OK'),										'Checklist//03//04_00' },
				[Message.wMsgMi8_Checklist_ITEM_Radio]								= { _('radio'),												'Checklist//03//05' },
				[Message.wMsgMi8_Checklist_ANSWER_Radio_On_Checked_1]				= { _('turned on, checked'),								'Checklist//03//05_00' },
				[Message.wMsgMi8_Checklist_ANSWER_Radio_On_Checked_2]				= { _('turned on, checked'),								'Checklist//03//05_01' },
			[Message.wMsgMi8_Checklist_CM_CorrectionRight]							= { _('crew, I read the card WITH CORRECTION LEVER RIGHT'),	'Checklist//04//00' },
				[Message.wMsgMi8_Checklist_ITEM_GensAndRects]						= { _('generators and rectifiers'),							'Checklist//04//01' },
				[Message.wMsgMi8_Checklist_ANSWER_GensAndRects_On]					= { _('turned on'),											'Checklist//04//01_00' },
				[Message.wMsgMi8_Checklist_ITEM_ResGenAndAPU]						= { _('standby generator and APU'),							'Checklist//04//02' },
				[Message.wMsgMi8_Checklist_ANSWER_ResGenAndAPU_Off]					= { _('turned off'),										'Checklist//04//02_00' },
				[Message.wMsgMi8_Checklist_ITEM_Inverters]							= { _('inverters switches'),								'Checklist//04//03' },
				[Message.wMsgMi8_Checklist_ANSWER_Inverters_Auto]					= { _('auto'),												'Checklist//04//03_00' },
				[Message.wMsgMi8_Checklist_ITEM_SARPP12]							= { _('flight recorder'),									'Checklist//04//04' },
				[Message.wMsgMi8_Checklist_ANSWER_SARPP12_On_Manual]				= { _('turned on, manual'),									'Checklist//04//04_00' },
				[Message.wMsgMi8_Checklist_ITEM_RotorRate]							= { _('main rotor frequency'),								'Checklist//04//05' },
				[Message.wMsgMi8_Checklist_ANSWER_RotorRate_Reached]				= { _('frequency achieved'),								'Checklist//04//05_00' },
				[Message.wMsgMi8_Checklist_ITEM_AGBs]								= { _('attitude indicators'),								'Checklist//04//06' },
				[Message.wMsgMi8_Checklist_ANSWER_AGBs_On_Norm_1]					= { _('turned on, readings normal'),						'Checklist//04//06_00' },
				[Message.wMsgMi8_Checklist_ANSWER_AGBs_On_Norm_2]					= { _('turned on, readings normal'),						'Checklist//04//06_01' },
				[Message.wMsgMi8_Checklist_ITEM_GMK]								= { _('course system'),										'Checklist//04//07' },
				[Message.wMsgMi8_Checklist_ANSWER_GMK_On_Slaved_1]					= { _('turned on, slaved'),									'Checklist//04//07_00' },
				[Message.wMsgMi8_Checklist_ANSWER_GMK_On_Slaved_2]					= { _('turned on, slaved'),									'Checklist//04//07_01' },
				[Message.wMsgMi8_Checklist_ITEM_ADF]								= { _('ADF'),												'Checklist//04//08' },
				[Message.wMsgMi8_Checklist_ANSWER_ADF_On_1]							= { _('turned on'),											'Checklist//04//08_00' },
				[Message.wMsgMi8_Checklist_ANSWER_ADF_On_2]							= { _('turned on'),											'Checklist//04//08_01' },
				[Message.wMsgMi8_Checklist_ITEM_DISS]								= { _('doppler navigation'),								'Checklist//04//09' },
				[Message.wMsgMi8_Checklist_ANSWER_DISS_On_Ready]					= { _('turned on, ready to work'),							'Checklist//04//09_00' },
				[Message.wMsgMi8_Checklist_ITEM_IFF]								= { _('IFF'),												'Checklist//04//10' },
				[Message.wMsgMi8_Checklist_ANSWER_IFF_On]							= { _('turned on'),											'Checklist//04//10_00' },
				[Message.wMsgMi8_Checklist_ITEM_RA]									= { _('radar altimeter'),									'Checklist//04//11' },
				[Message.wMsgMi8_Checklist_ANSWER_RA_On]							= { _('turned on'),											'Checklist//04//11_00' },
				[Message.wMsgMi8_Checklist_ITEM_P0]									= { _('QFE'),												'Checklist//04//12' },
				[Message.wMsgMi8_Checklist_ANSWER_P0_Set_1]							= { _('is set'),											'Checklist//04//12_00' },
				[Message.wMsgMi8_Checklist_ANSWER_P0_Set_2]							= { _('is set'),											'Checklist//04//12_01' },
				[Message.wMsgMi8_Checklist_ITEM_ERD_CHR]							= { _('EEC, emergency mode'),								'Checklist//04//13' },
				[Message.wMsgMi8_Checklist_ANSWER_ERD_CHR_OK_CHR_On]				= { _('OK, emergency mode turned on'),						'Checklist//04//13_00' },
				[Message.wMsgMi8_Checklist_ITEM_PowerPlantParams]					= { _('power plant and transmission parameters'),			'Checklist//04//14' },
				[Message.wMsgMi8_Checklist_ANSWER_PowerPlantParams_Norm]			= { _('normal'),											'Checklist//04//14_00' },
				[Message.wMsgMi8_Checklist_ITEM_LampsDanger]						= { _('alarm and warning lamps'),							'Checklist//04//15' },
				[Message.wMsgMi8_Checklist_ANSWER_LampsDanger_Off_1]				= { _('do not lit'),										'Checklist//04//15_00' },
				[Message.wMsgMi8_Checklist_ANSWER_LampsDanger_Off_2]				= { _('do not lit'),										'Checklist//04//15_01' },
				[Message.wMsgMi8_Checklist_ANSWER_LampsDanger_Off_3]				= { _('do not lit'),										'Checklist//04//15_02' },
				[Message.wMsgMi8_Checklist_ITEM_WheelBrakes]						= { _('wheel brakes'),										'Checklist//04//16' },
				[Message.wMsgMi8_Checklist_ANSWER_WheelBrakes_OK]					= { _('OK'),												'Checklist//04//16_00' },
			[Message.wMsgMi8_Checklist_CM_BeforeTakeOff]							= { _('crew, I read the card BEFORE TAKE-OFF'),				'Checklist//05//00' },
				[Message.wMsgMi8_Checklist_ITEM_Obstacle]							= { _('obstacles'),											'Checklist//05//01' },
				[Message.wMsgMi8_Checklist_ANSWER_Obstacle_No_1]					= { _('no'),												'Checklist//05//01_00' },
				[Message.wMsgMi8_Checklist_ANSWER_Obstacle_No_2]					= { _('no'),												'Checklist//05//01_01' },
				[Message.wMsgMi8_Checklist_ITEM_TakeOffCourse]						= { _('take-off course on HSI'),							'Checklist//05//02' },
				[Message.wMsgMi8_Checklist_ANSWER_TakeOffCourse_Set_1]				= { _('is set'),											'Checklist//05//02_00' },
				[Message.wMsgMi8_Checklist_ANSWER_TakeOffCourse_Set_2]				= { _('is set'),											'Checklist//05//02_01' },
				[Message.wMsgMi8_Checklist_ITEM_AGBsEqual]							= { _('attitude indicators'),								'Checklist//05//03' },
				[Message.wMsgMi8_Checklist_ANSWER_AGBsEqual_ReadingsEqual]			= { _('readings are equal'),								'Checklist//05//03_00' },
				[Message.wMsgMi8_Checklist_ITEM_AutopilotPitchRoll]					= { _('autopilot, roll and pitch channels'),				'Checklist//05//04' },
				[Message.wMsgMi8_Checklist_ANSWER_AutopilotPitchRoll_On]			= { _('turned on'),											'Checklist//05//04_00' },
				[Message.wMsgMi8_Checklist_ITEM_WheelBrakesOff]						= { _('wheel brakes'),										'Checklist//05//05' },
				[Message.wMsgMi8_Checklist_ANSWER_WheelBrakesOff_Off]				= { _('wheels disinhibited'),								'Checklist//05//05_00' },
				[Message.wMsgMi8_Checklist_ITEM_ReadyToFlight]						= { _('ready to take off'),									'Checklist//05//06' },
				[Message.wMsgMi8_Checklist_ANSWER_ReadyToFlight_1]					= { _('ready'),												'Checklist//05//06_00' },
				[Message.wMsgMi8_Checklist_ANSWER_ReadyToFlight_2]					= { _('ready'),												'Checklist//05//06_01' },
				[Message.wMsgMi8_Checklist_ANSWER_ReadyToFlight_3]					= { _('ready'),												'Checklist//05//06_02' },
			[Message.wMsgMi8_Checklist_CM_BeforeLanding]							= { _('crew, I read the card BEFORE LANDING'),				'Checklist//06//00' },
				[Message.wMsgMi8_Checklist_ITEM_LandingConditions]					= { _('landing conditions'),								'Checklist//06//01' },
				[Message.wMsgMi8_Checklist_ANSWER_LandingConditions_OK_1]			= { _('known, landing provided'),							'Checklist//06//01_00' },
				[Message.wMsgMi8_Checklist_ANSWER_LandingConditions_OK_2]			= { _('known, landing provided'),							'Checklist//06//01_01' },
				[Message.wMsgMi8_Checklist_ITEM_AutopilotAlt]						= { _('autopilot'),											'Checklist//06//02' },
				[Message.wMsgMi8_Checklist_ANSWER_AutopilotAlt_On_AltOff]			= { _('turned on, altitude channel turned off'),			'Checklist//06//02_00' },
				[Message.wMsgMi8_Checklist_ITEM_SystemsCheck]						= { _('systems serviceability'),							'Checklist//06//03' },
				[Message.wMsgMi8_Checklist_ANSWER_SystemsCheck_OK]					= { _('OK'),												'Checklist//06//03_00' },
				[Message.wMsgMi8_Checklist_ITEM_RAlt]								= { _('radar altimeter'),									'Checklist//06//04' },
				[Message.wMsgMi8_Checklist_ANSWER_RAlt_AltSet]						= { _('height is set'),										'Checklist//06//04_00' },
				[Message.wMsgMi8_Checklist_ITEM_SlavedGMK]							= { _('course system'),										'Checklist//06//05' },
				[Message.wMsgMi8_Checklist_ANSWER_SlavedGMK_Slaved]					= { _('slaved'),											'Checklist//06//05_00' },
				[Message.wMsgMi8_Checklist_ITEM_PZU]								= { _('anti dust'),											'Checklist//06//06' },
				[Message.wMsgMi8_Checklist_ANSWER_PZU_On]							= { _('turned on'),											'Checklist//06//06_00' },
				[Message.wMsgMi8_Checklist_ITEM_LandingCourse]						= { _('landing course on HSI'),								'Checklist//06//07' },
				[Message.wMsgMi8_Checklist_ANSWER_LandingCourse_Set_1]				= { _('is set'),											'Checklist//06//07_00' },
				[Message.wMsgMi8_Checklist_ANSWER_LandingCourse_Set_2]				= { _('is set'),											'Checklist//06//07_01' },
				[Message.wMsgMi8_Checklist_ITEM_ReadyToLanding]						= { _('readiness for landing'),								'Checklist//06//08' },
				[Message.wMsgMi8_Checklist_ANSWER_ReadyToLanding_1]					= { _('ready'),												'Checklist//06//08_00' },
				[Message.wMsgMi8_Checklist_ANSWER_ReadyToLanding_2]					= { _('ready'),												'Checklist//06//08_01' },
				[Message.wMsgMi8_Checklist_ANSWER_ReadyToLanding_3]					= { _('ready'),												'Checklist//06//08_02' },
			[Message.wMsgMi8_Checklist_WindDir_Front]								= { _('Wind Front'),										'Checklist//Wind//Front' },
			[Message.wMsgMi8_Checklist_WindDir_FrontLeft]							= { _('Wind Front Left'),									'Checklist//Wind//FrontLeft' },
			[Message.wMsgMi8_Checklist_WindDir_FrontRight]							= { _('Wind Front Right'),									'Checklist//Wind//FrontRight' },
			[Message.wMsgMi8_Checklist_WindDir_Back]								= { _('Wind Back'),											'Checklist//Wind//Back' },
			[Message.wMsgMi8_Checklist_WindDir_BackLeft]							= { _('Wind Back Left'),									'Checklist//Wind//BackLeft' },
			[Message.wMsgMi8_Checklist_WindDir_BackRight]							= { _('Wind Back Right'),									'Checklist//Wind//BackRight' },
			[Message.wMsgMi8_Checklist_WindDir_Left]								= { _('Wind Left'),											'Checklist//Wind//Left' },
			[Message.wMsgMi8_Checklist_WindDir_Right]								= { _('Wind Right'),										'Checklist//Wind//Right' },
				[Message.wMsgMi8_Checklist_WindStr_Calm]							= { _('Calm'),												'Checklist//Wind//Calm' },
				[Message.wMsgMi8_Checklist_WindStr_Light]							= { _('Light'),												'Checklist//Wind//Light' },
				[Message.wMsgMi8_Checklist_WindStr_Average]							= { _('Average'),											'Checklist//Wind//Average' },
				[Message.wMsgMi8_Checklist_WindStr_Stiff]							= { _('Strong'),											'Checklist//Wind//Stiff' },
			[Message.wMsgMi8_Checklist_Completed]									= { _('Checklist Completed'),								'Procedures//14_01' },
		[Message.wMsgMi8_Checklist_Maximum] = nil,

		-- Mi8 Procedures Messages
		[Message.wMsgMi8_CrewProcedures_Null] = nil,
			[Message.wMsgMi8_CrewProcedures_OpenDoor]									= { empty_string,								'Procedures//01_01_01' },
			[Message.wMsgMi8_CrewProcedures_DoorOpened]									= { empty_string,								'Procedures//01_01_02' },
			[Message.wMsgMi8_CrewProcedures_CloseDoor]									= { empty_string,								'Procedures//01_02_01' },
			[Message.wMsgMi8_CrewProcedures_DoorClosed]									= { empty_string,								'Procedures//01_02_02' },
			[Message.wMsgMi8_CrewProcedures_OpenLeaf]									= { empty_string,								'Procedures//02_01_01' },
			[Message.wMsgMi8_CrewProcedures_LeafOpened]									= { empty_string,								'Procedures//02_01_02' },
			[Message.wMsgMi8_CrewProcedures_CloseLeaf]									= { empty_string,								'Procedures//02_02_01' },
			[Message.wMsgMi8_CrewProcedures_LeafClosed]									= { empty_string,								'Procedures//02_02_02' },
			[Message.wMsgMi8_CrewProcedures_StartAPU_Command]							= { empty_string,								'Procedures//03_01_01' },
			[Message.wMsgMi8_CrewProcedures_StartAPU_Answer]							= { empty_string,								'Procedures//03_01_02' },
			[Message.wMsgMi8_CrewProcedures_StartAPU_AutoOn]							= { empty_string,								'Procedures//03_02' },
			[Message.wMsgMi8_CrewProcedures_StartAPU_VoltageNorm]						= { empty_string,								'Procedures//03_03' },
			[Message.wMsgMi8_CrewProcedures_StartAPU_TemprGrowsPressNorm]				= { empty_string,								'Procedures//03_04' },
			[Message.wMsgMi8_CrewProcedures_StartAPU_ApuRunningReadingsNorm]			= { empty_string,								'Procedures//03_05' },
			[Message.wMsgMi8_CrewProcedures_StartEngines_StartLeftEngine_Command]		= { empty_string,								'Procedures//04_01_01' },
			[Message.wMsgMi8_CrewProcedures_StartEngines_ClearPropLeft]					= { empty_string,								'Procedures//04_01_02' },
			[Message.wMsgMi8_CrewProcedures_StartEngines_StartLeftEngine_Answer]		= { empty_string,								'Procedures//04_01_03' },
			[Message.wMsgMi8_CrewProcedures_StartEngines_StartRightEngine_Command]		= { empty_string,								'Procedures//04_02_01' },
			[Message.wMsgMi8_CrewProcedures_StartEngines_ClearPropRight]				= { empty_string,								'Procedures//04_02_02' },
			[Message.wMsgMi8_CrewProcedures_StartEngines_StartRightEngine_Answer]		= { empty_string,								'Procedures//04_02_03' },
			[Message.wMsgMi8_CrewProcedures_StartEngines_SpeedGrows]					= { empty_string,								'Procedures//04_03' },
			[Message.wMsgMi8_CrewProcedures_StartEngines_OilPressureGrows]				= { empty_string,								'Procedures//04_04' },
			[Message.wMsgMi8_CrewProcedures_StartEngines_TemperatureGrows]				= { empty_string,								'Procedures//04_05' },
			[Message.wMsgMi8_CrewProcedures_StartEngines_LeftIdleParamsNormal]			= { empty_string,								'Procedures//04_06' },
			[Message.wMsgMi8_CrewProcedures_StartEngines_RightIdleParamsNormal]			= { empty_string,								'Procedures//04_07' },
			[Message.wMsgMi8_CrewProcedures_TurnDevicesOn]								= { empty_string,								'Procedures//05_01' },
			[Message.wMsgMi8_CrewProcedures_CheckDevices]								= { empty_string,								'Procedures//05_02' },
			[Message.wMsgMi8_CrewProcedures_TurnAutopilotOn]							= { empty_string,								'Procedures//06_01_01' },
			[Message.wMsgMi8_CrewProcedures_AutopilotPitchRollOn]						= { empty_string,								'Procedures//06_01_02' },
			[Message.wMsgMi8_CrewProcedures_PerformControlHover]						= { empty_string,								'Procedures//07_01' },
			[Message.wMsgMi8_CrewProcedures_CrewTakeOff]								= { empty_string,								'Procedures//07_02' },
			[Message.wMsgMi8_CrewProcedures_IcingZoneEndedTurnAntiIceOff]				= { empty_string,								'Procedures//08_01_01' },
			[Message.wMsgMi8_CrewProcedures_RotorsAntiIcingOff]							= { empty_string,								'Procedures//08_01_02' },
			[Message.wMsgMi8_CrewProcedures_TurnDustProofDeviceOn]						= { empty_string,								'Procedures//09_01_01' },
			[Message.wMsgMi8_CrewProcedures_DustProofDeviceOn]							= { empty_string,								'Procedures//09_01_02' },
			[Message.wMsgMi8_CrewProcedures_TurnDustProofDeviceOff]						= { empty_string,								'Procedures//09_02_01' },
			[Message.wMsgMi8_CrewProcedures_DustProofDeviceOff]							= { empty_string,								'Procedures//09_02_02' },
			[Message.wMsgMi8_CrewProcedures_Descent_H60Decision]						= { empty_string,								'Procedures//10_01_01' },
			[Message.wMsgMi8_CrewProcedures_Descent_CrewLanding]						= { empty_string,								'Procedures//10_01_02' },
			[Message.wMsgMi8_CrewProcedures_Descent_H40Speed]							= { empty_string,								'Procedures//10_02_01' },
			[Message.wMsgMi8_CrewProcedures_Descent_H30Speed]							= { empty_string,								'Procedures//10_02_02' },
			[Message.wMsgMi8_CrewProcedures_Descent_H20Speed]							= { empty_string,								'Procedures//10_02_03' },
			[Message.wMsgMi8_CrewProcedures_Descent_H10Speed]							= { empty_string,								'Procedures//10_02_04' },
			[Message.wMsgMi8_CrewProcedures_Descent_Speed120]							= { empty_string,								'Procedures//10_03_01' },
			[Message.wMsgMi8_CrewProcedures_Descent_Speed110]							= { empty_string,								'Procedures//10_03_02' },
			[Message.wMsgMi8_CrewProcedures_Descent_Speed100]							= { empty_string,								'Procedures//10_03_03' },
			[Message.wMsgMi8_CrewProcedures_Descent_Speed90]							= { empty_string,								'Procedures//10_03_04' },
			[Message.wMsgMi8_CrewProcedures_Descent_Speed80]							= { empty_string,								'Procedures//10_03_05' },
			[Message.wMsgMi8_CrewProcedures_Descent_Speed70]							= { empty_string,								'Procedures//10_03_06' },
			[Message.wMsgMi8_CrewProcedures_Descent_Speed60]							= { empty_string,								'Procedures//10_03_07' },
			[Message.wMsgMi8_CrewProcedures_Descent_Speed50]							= { empty_string,								'Procedures//10_03_08' },
			[Message.wMsgMi8_CrewProcedures_Descent_Speed40]							= { empty_string,								'Procedures//10_03_09' },
			[Message.wMsgMi8_CrewProcedures_Descent_Speed30]							= { empty_string,								'Procedures//10_03_10' },
			[Message.wMsgMi8_CrewProcedures_Descent_Speed20]							= { empty_string,								'Procedures//10_03_11' },
			[Message.wMsgMi8_CrewProcedures_Descent_Speed10]							= { empty_string,								'Procedures//10_03_12' },
			[Message.wMsgMi8_CrewProcedures_CheckFuel_20min]							= { empty_string,								'Procedures//11_01_01' },
			[Message.wMsgMi8_CrewProcedures_CheckFuel_40min]							= { empty_string,								'Procedures//11_01_02' },
			[Message.wMsgMi8_CrewProcedures_CheckFuel_60min]							= { empty_string,								'Procedures//11_01_03' },
			[Message.wMsgMi8_CrewProcedures_CheckFuel]									= { empty_string,								'Procedures//11_01_04' },
			[Message.wMsgMi8_CrewProcedures_CrewLanding]								= { empty_string,								'Procedures//12_01' },
			[Message.wMsgMi8_CrewProcedures_TurnOffConsumers_GetReadyToStopEngines]		= { empty_string,								'Procedures//13_01_01' },
			[Message.wMsgMi8_CrewProcedures_CoolingTimeWasOver_ReadyToShutdown]			= { empty_string,								'Procedures//13_02_01' },
			[Message.wMsgMi8_CrewProcedures_ReadyToShutdown_StopEngines]				= { empty_string,								'Procedures//13_02_02' },
			[Message.wMsgMi8_CrewProcedures_ReadyToShutdown]							= { empty_string,								'Procedures//13_02_03' },
			[Message.wMsgMi8_CrewProcedures_RunningOutTimeOfEngineTurbinesNormal]		= { empty_string,								'Procedures//13_03' },
			[Message.wMsgMi8_CrewProcedures_FlightIsOver]								= { empty_string,								'Procedures//13_04' },
		[Message.wMsgMi8_CrewProcedures_Maximum] = nil,

		--A-10 VMU messages
		[Message.wMsgA10_VMU_Null] = nil,
			[Message.wMsgA10_VMU_Alert]						= { _('ALERT!'), 					'A10_VMU_Alert' },
			[Message.wMsgA10_VMU_Altitude]					= { _('ALTITUDE! ALTITUDE!'), 		'A10_VMU_Altitude' },
			[Message.wMsgA10_VMU_WarningAutopilot]			= { _('WARNING AUTOPILOT!'), 		'A10_VMU_APdiseng' },
			[Message.wMsgA10_VMU_Ceiling]					= { _('CEILING!'), 					'A10_VMU_Ceiling' },
			[Message.wMsgA10_VMU_IFF]						= { _('IFF!'), 						'A10_VMU_IFF' },
			[Message.wMsgA10_VMU_Obstacle]					= { _('OBSTACLE!'), 				'A10_VMU_Obstacle' },
			[Message.wMsgA10_VMU_Pullup]					= { _('PULL UP! PULL UP!'), 		'A10_VMU_Pullup' },
			[Message.wMsgA10_VMU_Speedbreak]				= { _('SPEEDBRAKE! SPEEDBRAKE!'),	'A10_VMU_Speedbrk' },
		[Message.wMsgA10_VMU_Maximum] = nil,
	
	[Message.wMsgMaximum] = nil,
}