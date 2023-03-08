local base = _G

module('me_localizationMG')

local gettext       	= base.require("i_18n")
_ = gettext.translate

local maxKey = 0
local dicts = {}
local locales 

localizedStrings = 
{
	missionName 		= { key = 'Fast mission', value = _('Fast mission')},
	goalDescription 	= { key = 'Inflict maximum damage on enemy forces.', value = _('Inflict maximum damage on enemy forces.')},
	missionDescription 	= { key = 'Provide support to friendly forces in contact with the enemy.', value = _('Provide support to friendly forces in contact with the enemy.')},
	at 					= { key = 'at', value = _('at')},
	mhz 				= { key = 'MHz', value = _('MHz')},
	jtacDescription 	= { key = 'You will be supported by JTAC units: ', value = _('You will be supported by JTAC units: ')},
	awacsDescription 	= { key = 'AWACS units: ', value = _('AWACS units: ')},
	
	Nice_job 			= { key = "Nice job!", value = _("Nice job!")},
	Scratch 			= { key = "Scratch one.", value = _("Scratch one.")},
	Target_is_down 		= { key = "Target is down.", value = _("Target is down.")},
	Thats_a_hit 		= { key = "That's a hit.", value = _("That's a hit.")},
	You_got_it 			= { key = "You got it.", value = _("You got it.")},
	Target_hit 			= { key = "Target hit.", value = _("Target hit.")},
	Hogs_on_the_prowl 	= { key = "Hogs on the prowl.", value = _("Hogs on the prowl.")},
	Good_work 			= { key = "Good work.", value = _("Good work.")},
	Enemy_down 			= { key = "Enemy down.", value = _("Enemy down.")},
	Bad_day 			= { key = "Bad day to be enemy.", value = _("Bad day to be enemy.")},
	Well_done 			= { key = "Well done.", value = _("Well done.")},
	Direct_hit 			= { key = "Direct hit!", value = _("Direct hit!")},
	Let_have 			= { key = "Let 'em have it!", value = _("Let 'em have it!")},
	Way_to_fly 			= { key = "Way to fly that thing!", value = _("Way to fly that thing!")},
	Target_hit 			= { key = "Target hit.", value = _("Target hit.")},
	Welcome_to 			= { key = " Welcome to hell.", value = _(" Welcome to hell.")},
	Nice_flying 		= { key = "Nice flying!", value = _("Nice flying!")},
	Target_desroyed 	= { key = "Target desroyed.", value = _("Target desroyed.")},
	Bad_guys 			= { key = "Bad guys beware!", value = _("Bad guys beware!")},
	Somebody 			= { key = "Somebody's having a bad day down there...", value = _("Somebody's having a bad day down there...")},
	Thats_kill 			= { key = "That's a kill!", value = _("That's a kill!")},
	Good_hunting 		= { key = "Good hunting.", value = _("Good hunting.")},
	Way_to_go 			= { key = "Way to go!", value = _("Way to go!")},
	Effect_on 			= { key = "Effect on target.", value = _("Effect on target.")},
	Hog_heaven 			= { key = "Hog heaven.", value = _("Hog heaven.")},
	Good_shooting 		= { key = "Good shooting!", value = _("Good shooting!")},
	Impact 				= { key = "Impact!", value = _("Impact!")},
	Positive 			= { key = "Positive destruction.", value = _("Positive destruction.")},
	Sierra 				= { key = "Sierra Hotel!", value = _("Sierra Hotel!")},
	Good_hit 			= { key = "Good hit!", value = _("Good hit!")},
	Confirmed 			= { key = "Confirmed kill.", value = _("Confirmed kill.")},
	
	Player 				= { key = "Player", value = _("Player")},
	Wingman 			= { key = "Wingman", value = _("Wingman")},
	Platoon 			= { key = "Platoon", value = _("Platoon")},
	Alfa 				= { key = "Alfa", value = _("Alfa")},
	target 				= { key = "target:", value = _("target:")},
	group 				= { key = "group.", value = _("group.")},
	LastManStanding		= { key = "Last Man Standing", value = _("Last Man Standing")},
	KillThemAll			= { key = "Kill them all", value = _("Kill them all!!")},
	FreeFlightMission	= { key = "Free Flight Mission", value = _("Free Flight Mission")},
	FreeFlight			= { key = "Free Flight", value = _("Free Flight")},
	Conquest			= { key = "Conquest", value = _("Conquest")},
	ToSmoothOutAirfield	= { key = "Attack and capture the airfield", value = _("Attack and capture the airfield")},
}

function init()
	local f = base.loadfile("MissionEditor/data/scripts/Langs.lua")
	local env = {}	
    locales = nil
    if f then
        base.setfenv(f, env)
        f()
        locales = env.locales
    end 

	for k,v in base.pairs(locales) do
		dicts[v.locale] = {dictionary = {}, mapResource = {}}
	end
	dicts['DEFAULT'] = {dictionary = {}, mapResource = {}}
end

local function getNewKey(a_comment)
	local newId
    maxKey = maxKey + 1
    if a_comment then
        newId = 'DictKey_MG_'..a_comment.."_"..maxKey
    else
        newId = 'DictKey_MG_'..maxKey
    end

    return newId
end


function addTexts(a_text1, a_text2, a_text3, a_text4)
	if base.test_localizationMG == true then
		local key = getNewKey("Texts")
		
		for k,v in base.pairs(locales) do
			dicts[v.locale].dictionary[key] = getLocalization(v.locale, a_text1)..((a_text2 and getLocalization(v.locale, a_text2)) or "")
				..((a_text3 and getLocalization(v.locale, a_text3)) or "")..((a_text4 and getLocalization(v.locale, a_text4)) or "")
			--dicts[v.locale].mapResource = {}
		end
		
		dicts['DEFAULT'].dictionary[key] = getLocalization('EN', a_text1)..((a_text2 and getLocalization('EN', a_text2)) or "")
				..((a_text3 and getLocalization('EN', a_text3)) or "")..((a_text4 and getLocalization('EN', a_text4)) or "")
		--dicts['DEFAULT'].mapResource = {}
			
		return key
	else
		local tmp = _(a_text1)..(a_text2 and _(a_text2) or "")..(a_text3 and _(a_text3) or "")..(a_text4 and _(a_text4) or "")
		base.print("----addTexts---",tmp)
		return tmp
	end
end

function getLocalization(a_locale, a_text)
	--TEST
	return a_locale.."_"..a_text
end

function getDicts()
	return dicts
end

function getLocalizedStrings()
	return localizedStrings
end
function getLocKey(a_key)
	return localizedStrings[a_key].key
end
function getLoc(a_key)
	return localizedStrings[a_key].value
end

function isTestLocalizationMG()
	return base.test_localizationMG == true
end



