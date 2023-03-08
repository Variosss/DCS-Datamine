local base = _G

module('me_trigrules')

local require 			= base.require
local print 			= base.print
local pairs 			= base.pairs
local ipairs 			= base.ipairs
local table 			= base.table
local tostring 			= base.tostring
local tonumber 			= base.tonumber
local string 			= base.string

local loader			= require('DialogLoader')
local U					= require('me_utilities')
local mission			= require('me_mission')
local predicates		= require('me_predicates')
local S					= require('Serializer')
local failures			= require('me_failures')
local TEMPL				= require('me_template')
local actionDB			= require('me_action_db')
local textutil			= require('textutil')
local MapWindow			= require('me_map_window')

local FileDialog 		= require('FileDialog')
local FileDialogFilters	= require('FileDialogFilters')
local MeSettings 		= require('MeSettings')
local mod_dictionary    = require('dictionary')
local CoalitionUtils	= require('Mission.CoalitionUtils')
local music             = require('me_music')
local SkinUtils         = require('SkinUtils')
local Skin              = require('Skin')
local Button			= require('Button')
local ProductType 		= require('me_ProductType') 

require('i18n').setup(_M)

cdata = {
    triggers 	= _("TRIGGERS"),
    new 		= _("NEW"),
    open 		= _("OPEN"),
    update 		= _("UPDATE"),
    delete 		= _("DELETE"),
    rules 		= _("RULES"),
    rule 		= _("TYPE:"),
    type 		= _("TYPE:"),
    actions 	= _("ACTIONS"),
    action 		= _("ACTION:"),
    ["or"] 		= _("OR"),
    ["clone"] 	= _("CLONE"),
    play 		= _("PLAY"),
	stop 		= _("STOP"),
	init_script = _("INITIALIZATION SCRIPT"),
	reset 		= _("RESET"),
	code 		= _("CODE"),
	Color 		= _("COLOR"),

    predicates = {
        trigger             = _("TRIGGER"),
        triggerOnce         = _("ONCE"),
        triggerContinious   = _("CONTINUOUS"),
        triggerStart        = _("MISSION START"),
        triggerFront        = _("FRONT CONDITION"),

        score               = _("SCORE"),
--        a_out_text = _("MESSAGE"),
        a_out_text_delay    = _("MESSAGE TO ALL"),
        a_out_text_delay_c  = _("COUNTRY MSG"),
        a_out_text_delay_s  = _("COALITION MSG"),
        a_out_text_delay_g  = _("MESSAGE TO GROUP"),
		a_out_text_delay_u  = _("MESSAGE TO UNIT"),
        a_mark_to_all       = _("MARK TO ALL"),
        a_mark_to_coalition = _("MARK TO COALITION"),
        a_mark_to_group     = _("MARK TO GROUP"),
        a_remove_mark       = _("REMOVE MARK"),
        a_out_sound         = _("SOUND TO ALL"),
		a_out_sound_stop    = _("SOUND STOP"),
        a_out_sound_c       = _("SOUND TO COUNTRY"),
        a_out_sound_s       = _("SOUND TO COALITION"),
        a_out_sound_g       = _("SOUND TO GROUP"),
		a_out_sound_u       = _("SOUND TO UNIT"),
		a_out_picture       = _("PICTURE TO ALL"),
		a_out_picture_stop  = _("PICTURE CLEAR"),
        a_out_picture_c     = _("PICTURE TO COUNTRY"),
        a_out_picture_s     = _("PICTURE TO COALITION"),
        a_out_picture_g     = _("PICTURE TO GROUP"),
		a_out_picture_u     = _("PICTURE TO UNIT"),
        a_activate_group    = _("GROUP ACTIVATE"),
		a_activate_static 	= _("STATIC ACTIVATE"),
        a_deactivate_group  = _("GROUP DEACTIVATE"),
        a_fall_in_template  = _("FALL IN TEMPLATE"),
        a_end_mission       = _("END MISSION"),
        a_set_flag          = _("SET FLAG"),
        a_clear_flag        = _("CLEAR FLAG"),
		a_set_flag_value    = _("SET FLAG VALUE"),
        a_inc_flag          = _("INCREASE FLAG"),
        a_dec_flag          = _("DECREASE FLAG"),
        a_set_flag_random   = _("SET FLAG RANDOM"),

        a_set_failure       = _("SET FAILURE"),
		a_set_ATC_silent_mode = _("SET ATC SILENT MODE"),

		a_set_internal_cargo    = _("SET INTERNAL CARGO"),
        a_set_internal_cargo_unit= _("SET INTERNAL CARGO ON UNIT"),

        a_explosion             = _("EXPLOSION"),
        a_explosion_unit        = _("EXPLODE UNIT"),
        a_explosion_marker      = _("EXPLODE WP MARKER"),
        a_explosion_marker_unit = _("EXPLODE WP MARKER ON UNIT"),
		a_effect_smoke			= _("EFFECT - SMOKE"),
		a_effect_smoke_stop		= _("EFFECT - SMOKE - STOP"),
        a_illumination_bomb     = _("ILLUMINATING BOMB"),
        a_signal_flare          = _("SIGNAL FLARE"),
        a_signal_flare_unit     = _("SIGNAL FLARE ON UNIT"),
        a_play_argument         = _("PLAY ARGUMENT"),
--        a_set_altitude = _("SET ALTITUDE"),
        a_aircraft_ctf_color_tag= _("CTF COLOR TAG ON AIRCRAFT"),

        a_load_mission                      = _("LOAD MISSION"),

        a_cockpit_highlight                 = _("COCKPIT HIGHLIGHT ELEMENT"),
        a_cockpit_highlight_position        = _("COCKPIT HIGHLIGHT POINT"),
        a_cockpit_highlight_indication      = _("COCKPIT HIGHLIGHT INDICATION"),
        a_cockpit_remove_highlight          = _("COCKPIT REMOVE HIGHLIGHT"),

        a_set_command                       = _("SET COMMAND"),
        a_set_command_with_value            = _("SET COMMAND WITH VALUE"),
        a_cockpit_perform_clickable_action  = _("COCKPIT PERFORM CLICKABLE ACTION"),
        a_cockpit_param_save_as             = _("COCKPIT PARAM SAVE AS"),

        a_start_listen_command              = _("START LISTEN COMMAND"),
        a_start_listen_event                = _("START LISTEN CKPT EVENT"),

		c_start_wait_for_user				= _("START WAIT USER RESPONSE"),
		c_stop_wait_for_user				= _("STOP WAIT USER RESPONSE"),
		
        a_add_radio_item                    = _("RADIO ITEM ADD"),
        a_remove_radio_item                 = _("RADIO ITEM REMOVE"),
		
        a_add_radio_item_for_coalition      = _("RADIO ITEM ADD FOR COALITION"),
        a_remove_radio_item_for_coalition   = _("RADIO ITEM REMOVE FOR COALITION"),
		
        a_add_radio_item_for_group          = _("RADIO ITEM ADD FOR GROUP"),
        a_remove_radio_item_for_group       = _("RADIO ITEM REMOVE FOR GROUP"),		
        
        a_group_stop                        = _("GROUP STOP"),
        a_group_resume                      = _("GROUP RESUME"),

        a_unit_on                           = _("UNIT AI ON"),
        a_unit_off                          = _("UNIT AI OFF"),
		a_unit_set_life_percentage			= _("UNIT AI SET LIFE"),
        a_group_on                          = _("GROUP AI ON"),
        a_group_off                         = _("GROUP AI OFF"),
		a_group_controllable_on             = _("GROUP CONTROL DEFAULT"),
		a_group_controllable_off            = _("GROUP CONTROL GAMEMASTER ONLY"),
		a_unit_emission_on                  = _("UNIT EMISSION ON"),
		a_unit_emission_off                 = _("UNIT EMISSION OFF"),
        a_set_ai_task                       = _("AI TASK SET"),
		a_ai_task                           = _("AI TASK PUSH"),
		
		a_prevent_controls_synchronization  = _("PREVENT CONTROLS SYNCHRONIZATION"),
		
		a_radio_transmission                = _("RADIO TRANSMISSION"),
		a_stop_radio_transmission           = _("STOP RADIO TRANSMISSION"),
		a_set_briefing                      = _("SET BRIEFING"),
		
		a_do_script                         = _('DO SCRIPT'),
		a_do_script_file                    = _('DO SCRIPT FILE'),
		
		a_show_route_gates_for_unit         = _("SHOW HELPER GATES FOR UNIT"),
		a_route_gates_set_current_point     = _("SET ACTIVE HELPER GATE TO POINT"),
        
        a_show_helper_gate                  = _("SHOW HELPER GATES"),

		a_cockpit_push_actor	  	        = _("BEGIN PLAYING ACTOR"),
		a_cockpit_pop_actor	 		        = _("STOP PLAYING ACTOR"),
		a_cockpit_lock_player_seat	        = _("START PLAYER SEAT LOCK"),
		a_cockpit_unlock_player_seat        = _("STOP PLAYER SEAT LOCK"),
		a_shelling_zone				        = _("SHELLING ZONE"),
		a_scenery_destruction_zone			= _("SCENERY DESTRUCTION ZONE"),
		a_remove_scene_objects				= _("SCENERY REMOVE OBJECTS ZONE"),
		
		a_zone_increment_resize				= _("ZONE_INCREMENT_SIZE"),
		
	    a_user_draw_show					= _("USER DRAW SHOW"),
		a_user_draw_hide					= _("USER DRAW HIDE"),
	},
    values = {
        score = _("SCORE:"),
        text = _("TEXT:"),
        flag = _("FLAG:"),
        seconds = _("SECONDS:"),
        file = _("FILE:"),
		picture = _("PICTURE:"),
        image = _("IMAGE:"),
        group = _("GROUP:"),
        template = _("TEMPLATE:"),
        random_pause = _("Within(mm)"),
        probability = _("Probability(%)"),
		cargo_mass = _("Mass kg:"),
        failure = _("FAILURE:"),
        coalitionlist = _("COALITION:"),
		horzAlignment = _("HORZ ALIGNMENT:"),
		vertAlignment = _("VERT ALIGNMENT:"),
		size = _("SIZE:"),
		size_units = _("SIZE UNITS:"),
        rolelist = _("ROLE:"),
        countrylist = _("COUNTRY:"),
        volume = _("VOLUME:"),
        altitude = _("ALTITUDE:"),
        winner = _("WINNER:"),
        cockpitdevice = _("DEVICE:"),
        switch = _("SWITCH:"),
        switch_state = _("STATE:"),
        command  = _("COMMAND:"),
        value    = _("VALUE:"),
        value_text = _("VALUE:"),
        element_value  = _("VALUE:"),
        element_name = _("ELEM NAME:"),
        highlight_id = _("ID:"),
        cockpit_device = _("COCKPIT DEVICE:"),
        source         = _("SOURCE:"),
        destination    = _("DESTINATION:"),
        radiotext    = _("NAME:"),
        color    = _("COLOR:"),
        bearing    = _("BEARING:"),
        indicator_id = _("INDICATOR ID:"), 
		eventlist = _("EVENT:"),
		modulation = _('MODULATION:'),
        frequency = _("FREQ, MHz:"),
		power	  = _("POWER, W:"),	
		loop = _("LOOP:"),
		number = _("NUMBER:"),
		name = _("NAME:"),
        x = _("X:"),
        y = _("Y:"),
        z = _("Z:"),
        course = _("COURSE:"), 
        clearview = _("CLEARVIEW"), 
		readonly = _("READONLY"), 
		comment = _("COMMENT"),
		density = _("DENSITY"),
		preset = _("PRESET"),
		
        in_cockpit_position_x = _("X(FWD/AFT):"),
        in_cockpit_position_y = _("Y(UP/DN):"),
        in_cockpit_position_z = _("Z(RGT/LFT):"),   
        size_of_box           = _("SIZE OF BOX:"),
        size_of_box_x         = _("BOX DIM ,X:"),
        size_of_box_y         = _("BOX DIM ,Y:"),
        size_of_box_z         = _("BOX DIM ,Z:"),
        
        hit_count             = _("HIT COUNT:"),
		value             	  = _("VALUE:"),
        min_value             = _("VALUE LIM MIN:"),
        max_value             = _("VALUE LIM MAX:"),
        event                 = _("EVENT:"),
        
        ai_task               = _('AI ACTION:'),
        set_ai_task           = _('AI TASK:'),
		
		flag_continue 		  =  _('FLAG CONTINUE:'),
		flag_back 			  =  _('FLAG BACK:'),
        
        start                 =  _('START:'),
        stop                  =  _('STOP:'),

		TNT                   =  _('TNT Eq:'),
        shells_count		  =  _('SHELLS COUNT:'),
		destruction_level	  =  _('DESTRUCTION LEVEL %%:'),
		
		COCKPIT_ADDITIONAL_PLUGIN	=  _('AVIONICS PLUGIN:'),
		objects_mask				=  _("OBJECTS MASK:"),
		object						=  _("UNIT:"),
		start_delay					=  _("START DELAY"),
		silent						=  _("SILENT:"),
    },
};

local spinBoxRed_
local spinBoxGreen_
local spinBoxBlue_
local panelColorButtons_
local staticColorView_
local staticColorViewSkin_

local tmp = {}
U.recursiveCopyTable(tmp, cdata)
cdata.Triggers = tmp
cdata.Triggers.values.comment = _("NAME:")


if ProductType.getType() == "LOFAC" then
    cdata.predicates.triggerStart = _("MISSION START-LOFAC")
    cdata.predicates.a_load_mission = _("LOAD MISSION-LOFAC")
    cdata.predicates.a_end_mission = _("END MISSION-LOFAC")
    cdata.predicates.a_set_briefing = _("SET BRIEFING-LOFAC")  
    cdata.predicates.a_show_route_gates_for_unit = _("SHOW HELPER GATES FOR UNIT-LOFAC") 
    cdata.predicates.a_unit_emission_off = _("UNIT EMISSION OFF-LOFAC")  
    cdata.predicates.a_unit_emission_on = _("UNIT EMISSION ON-LOFAC")
    cdata.predicates.a_unit_on = _("UNIT AI ON-LOFAC")
    cdata.predicates.a_unit_off = _("UNIT AI OFF-LOFAC")
	cdata.predicates.a_unit_set_life_percentage = _("UNIT AI SET LIFE-LOFAC")
    cdata.predicates.a_explosion_marker_unit = _("EXPLODE WP MARKER ON UNIT-LOFAC")
end

function convertMultilineText(p1, text)
    text = string.gsub(text, '\n', ' ');

    if (text ~= nil) then    
        local position = 0
        local length = 15

        text = textutil.Utf8GetSubString(text, position, length)
    end
    
    return text;
end;

function convertMultilineText2(p1, text)
    return text;
end;

globalevents = {
	{id="",name=_("NO EVENT"),},
	{id="dead",name=_("ON DESTROY"),},
--	{id="birth",name=_("ON CREATE"),},
	{id="shot",name=_("ON SHOT"),},
	{id="crash",name=_("ON CRASH"),},
	{id="eject",name=_("ON EJECT"),},
	{id="refuel",name=_("ON REFUEL"),},
	{id="pilot dead",name=_("ON PILOT DEAD"),},
	{id="base captured",name=_("ON BASE CAPTURED"),},
	{id="took control",name=_("ON TAKE CONTROL"),},
	{id="refuel stop",name=_("ON REFUEL STOP"),},
	{id="failure",name=_("ON FAILURE"),},
	{id="mission start",name=_("ON MISSION START"),},
	{id="mission end"  ,name=_("ON MISSION ENDS"),},
	}



local gamePatterns = { 
    { id = ''						, name = _('NONE') },
    { id = 'LastManStanding'		, name = _('LAST MAN STANDING') }, 
	{ id = 'ContestingAnAirfield'	, name = _('CONTESTING AN AIRFIELD') }, 
}
	

function eventLister()
    return globalevents
end

function eventIdToName(cdata, id)
    for k, v in pairs(globalevents) do
		if v.id==id then return v.name; end
	end
	return _("NO EVENT")
end

-- descripption of triggers
triggersDescr = {
    {
        name = "triggerOnce";
        firstValueAsName = false;
        fields = {
            {
                id = "comment",
                type = "edit",
                default = "",
            },
            {
                id = "eventlist",
                type = "combo",
                comboFunc = eventLister,
                displayFunc = eventIdToName,
                serializeFunc = null_transform,
                default = "",
            },
        }
    },
    {
        name = "triggerContinious";
        firstValueAsName = false;
        fields = {
            {
                id = "comment",
                type = "edit",
                default = "",
            },
            {
                id = "eventlist",
                type = "combo",
                comboFunc = eventLister,
                displayFunc = eventIdToName,
                serializeFunc = null_transform,
                default = "",
            },
        }
    },
    {
        name = "triggerStart";
        firstValueAsName = false;
        fields = {
            {
                id = "comment",
                type = "edit",
                default = "",
            },
        }
    },
    {
        name = "triggerFront";
        firstValueAsName = false;
        fields = {
            {
                id = "comment",
                type = "edit",
                default = "",
            },
        }
    },
}

function failureLister()
    local failure = { }
    if (failures.vdata ~= nil) then
        for k, v in pairs(failures.vdata_view) do
            table.insert(failure, { id = v.id, name = v.label })         
        end
    end
    return failure
end

function failureIdToName(cdata, id)
    if  failures.vdata ~= nil then
		local d = failures.vdata[id]
		if d ~= nil then
		   return d.label
		end
	end
    return ""    
end

function airdromeAndHeliportLister()
    local result = { }
    for k, v in pairs(MapWindow.listAirdromes) do
		table.insert(result,{id = k, name = v.display_name, data = {type = "airdromeId"}})
	end
	
	local categories = {AircraftCarrier = 1, HelicopterCarrier = 1}
	
	for k, unit in pairs(mission.unit_by_id) do
		if base.me_db.isFARP(unit.type) then
			table.insert(result,{id = unit.unitId, name = unit.name, data = {type = "helipadId"}})
		elseif (unit.boss.type == 'ship') then
			if base.me_db.isShipSuitable(unit, categories) then
				table.insert(result,{id = unit.unitId, name = unit.name, data = {type = "helipadId"}})
			end
		end
	end

    return result
end

function helipadAndShipIdToName(cdata, id)
    for k, unit in pairs(mission.unit_by_id) do
		if unit.unitId == id then return unit.name end
	end

	return "INVALID ID"
end

function airdromeAndHeliportDisplay(cdata, id, data)
	if data then
		if data.type == 'airdromeId' then
			return predicates.airdromeIdToName(cdata, id)
		else
			return helipadAndShipIdToName(cdata, id)
		end
	end
    return "INVALID ID" 
end


function airdromeAndHeliportSerialize(cdata, id, data)
	return "{"..data.type.."="..id.."}"
end

-- conver groupId to group name
function groupIdToName(cdata, id)
    if not id then
        return ""
    else
        local group = mission.group_by_id[id]
        if group then
            return group.name
        else
            return ""
        end
    end
end

function taskToName(cdata, id)
    local group = mission.group_by_id[id[1]]
    if  group and 
        group.tasks then
        local task = group.tasks[id[2]]
        if task then
            return groupIdToName(cdata, id[1])..' / '..actionDB.getTaskDescription(group, nil, task)
        end
    end
    return ""
end

-- return true if group with specified ID exists
function isGroupExists(id)
    return nil ~= mission.group_by_id[id]
end

function isTaskExists(id)
    local group = mission.group_by_id[id[1]]
    if  group and 
        group.tasks then
        return group.tasks[id[2]] ~= nil
    end
    return false
end

function null_transform(cdata,param) -- to make sure we will use serializeFunc instead of displayFunc
    return param 
end 

function serializeTask(cdata, param)
    return param[1], param[2]
end

function countryLister()
    local countries = { }
    for k, v in pairs(base.me_db.country_by_id) do
		if v.hide ~= true then
			table.insert(countries, { id=k, name=v.Name })
		end
    end
    return countries
end

function countryIdToName(cdata, id)
    for k, v in pairs(base.me_db.country_by_id) do
        if id == k then return v.Name end
    end
	
    return ""    
end

function coalitionIdToName(cdata, coalitionName)
	return CoalitionUtils.coalitionNameToLocalizedName(coalitionName, _("OFFLINE"))
end

function winnerLister()
	local result = CoalitionUtils.listerNameRedBlue()
	
	table.insert(result, 1, CoalitionUtils.createListerNameValue('', ''))

	return result
end

function winnerIdToName(cdata, coalitionName)
	return CoalitionUtils.coalitionNameToLocalizedName(coalitionName, _("UNKNOWN"))
end

function coalition2IdToName(cdata, coalitionName)
    return CoalitionUtils.coalitionNameToLocalizedName(coalitionName, _("ALL"))
end

-- groups names enumerator, no statics
function groupsLister()
    local groups = { }
    for k, v in pairs(mission.group_by_id) do
        if v and ('static' ~= v.type) then
            table.insert(groups, { id=k, name=v.name })
        end
    end
    table.sort(groups, U.namedTableComparator)
    return groups
end

-- groups names enumerator, only statics
function groupsStaticLister()
	local groups = { }
    for k, v in pairs(mission.group_by_id) do
        if v and ('static' == v.type) then
            table.insert(groups, { id=k, name=v.name })
        end
    end
    table.sort(groups, U.namedTableComparator)
    return groups
end

-- tasks of all groups for activation by a trigger
function aiTaskLister()
    local tasks = { }
    for groupId, group in pairs(mission.group_by_id) do
        --if v and ('static' ~= v['type']) then
        if group.tasks then
            for taskNumber, task in pairs(group.tasks) do
                local taskDesc = actionDB.getTaskDescription(group, nil, task)
				if taskDesc ~= nil then
					local itemName = group.name..' / '..taskDesc
					print(itemName)
					table.insert(tasks, { id = {groupId, taskNumber}, name = itemName })           
				else
					table.remove(group, taskNumber)
				end
            end
        end
    end
    table.sort(tasks, U.namedTableComparator)
    return tasks
end

-- static groups names enumerator, statics only
function groupsListerS()
    local groups = { }
    for k, v in pairs(mission.group_by_id) do
        if v and ('static' == v.type) then
            table.insert(groups, { id=k, name=v.name })
        end
    end
    table.sort(groups, U.namedTableComparator)
    return groups
end

-- groups Vehicles+Ships enumerator
function groupsVSLister()
    local groups = { }
    for k, v in pairs(mission.group_by_id) do
        if v and (v.type == 'vehicle' or v.type == 'ship') then
            table.insert(groups, { id=k, name=v.name })
        end
    end
    table.sort(groups, U.namedTableComparator)
    return groups
end

-- groups Airplanes+Helicopter enumerator
function groupsAHLister()
    local groups = { }
    for k, v in pairs(mission.group_by_id) do
        if v and (v.type == 'plane' or v.type == 'helicopter') then
            table.insert(groups, { id=k, name=v.name })
        end
    end
    table.sort(groups, U.namedTableComparator)
    return groups
end

-- groups Vehicles enumerator
function groupsVLister()
    local groups = { }
    for k, v in pairs(mission.group_by_id) do
        if v and v.type == 'vehicle' then
            table.insert(groups, { id=k, name=v.name })
        end
    end
    table.sort(groups, U.namedTableComparator)
    return groups
end

local function rolesLister()
	local roles = {	
		{id = '0', name = _('GAME MASTER')},
		{id = '1', name = _('PILOT')},
		{id = '2', name = _('FORWARD OBSERVER')},
		{id = '3', name = _('TACTICAL CMDR')},
		{id = '4', name = _('OBSERVER')},
		{id = '5', name = _('SPECTATOR')},
	}
	
	if base.__PRODUCT_ID__ == 2 then
        roles[1].name   = _("SUPERVISOR")
    end
	
	return roles
end

local roleNames = {
	['0'] = 'ROLE_INSTRUCTOR'			,
	['1'] = 'ROLE_PILOT'				,
	['2'] = 'ROLE_FORWARD_OBSERVER'		,
	['3'] = 'ROLE_ARTILLERY_COMMANDER'	,
	['4'] = 'ROLE_OBSERVER'				,
	['5'] = 'ROLE_SPECTRATOR'			,
}

local function roleIdToName(cdata, id)	
	local result = roleNames[id]
	
	if not result then
		result = ""
	end
	
	return result
end

local function alignmentHorzLister()
	local alignments = {	
		{id = '0', name = _('LEFT'	)},
		{id = '1', name = _('CENTER')},
		{id = '2', name = _('RIGHT'	)},
	}
	
	return alignments
end

local function alignmentVertLister()
	local alignments = {	
		{id = '0', name = _('TOP'	)},
		{id = '1', name = _('CENTER')},
		{id = '2', name = _('BOTTOM')},
	}
	
	return alignments
end

local alignmentHorzNames = {
	['0'] = 'LEFT'	,
	['1'] = 'CENTER',
	['2'] = 'RIGHT'	,
}

local alignmentVertNames = {
	['0'] = 'TOP'	,
	['1'] = 'CENTER',
	['2'] = 'BOTTOM',
}

local function alignmentHorzIdToName(cdata, id)	
	local result = alignmentHorzNames[id]
	
	if not result then
		result = ""
	end
	
	return result
end

local function alignmentVertIdToName(cdata, id)	
	local result = alignmentVertNames[id]
	
	if not result then
		result = ""
	end
	
	return result
end



local function sizeUnitsLister()
	local sizeUnits = {	
		{id = '0', name = _('% OF ORIGINAL SIZE')},
		{id = '1', name = _('% OF WINDOW SIZE'	)},
	}
	
	return sizeUnits
end

local sizeUnitNames = {
	['0'] = 'ORIGINAL SIZE'	,
	['1'] = 'WINDOW SIZE'	,
}

local function sizeUnitsIdToName(cdata, id)	
	local result = sizeUnitNames[id]
	
	if not result then
		result = ""
	end
	
	return result
end

local defaultTemplateName = 'Default'
function templatesLister()
    local templList = { }
    for templName, templ in pairs(TEMPL.templates) do
        table.insert(templList, {id=templName, name = _(templName)})
    end
	table.insert(templList, {id = defaultTemplateName, name = _(defaultTemplateName)})
    table.sort(templList, U.namedTableComparator)
    return templList
end

function isTemplateExists(id)
	if id == defaultTemplateName then return true end
	
    if TEMPL.templates ~= nil then	
		for templName, templ in pairs(TEMPL.templates) do
			if templName == id then
				return true
			end
		end
	end
    return false
end

function GetEffectSmokePresets()
	return
	{
		{id=1, name = _("small smoke and fire")},
		{id=2, name = _("medium smoke and fire")},
		{id=3, name = _("large smoke and fire")},
		{id=4, name = _("huge smoke and fire")},
		{id=5, name = _("small smoke")},
		{id=6, name = _("medium smoke")},
		{id=7, name = _("large smoke")},
		{id=8, name = _("huge smoke")},
	}
end

function GetEffectSmokePresetId(cdata, id)
    if     id == 1 then return _("small smoke and fire") 
    elseif id == 2 then return _("medium smoke and fire") 
    elseif id == 3 then return _("large smoke and fire") 
    elseif id == 4 then return _("huge smoke and fire") 
    elseif id == 5 then return _("small smoke")
    elseif id == 6 then return _("medium smoke") 
    elseif id == 7 then return _("large smoke") 
    elseif id == 8 then return _("huge smoke") 
    else return _("UNKNOWN") end
end

function colorLister_smoke()
    return {{id="0",name=_("GREEN_clr"),},{id="1",name=_("RED_clr")},{id="2",name=_("WHITE_clr")},{id="3",name=_("ORANGE_clr")},{id="4",name=_("BLUE_clr")},}
end

function colorLister_snare()
    return {{id="0",name=_("GREEN_clr"),},{id="1",name=_("RED_clr")},{id="2",name=_("WHITE_clr")},{id="3",name=_("ORANGE_clr")},}
end

function colorIdToName(cdata, id)
    if     id == "0" then return _("GREEN_clr") 
    elseif id == "1" then return _("RED_clr") 
    elseif id == "2" then return _("WHITE_clr") 
    elseif id == "3" then return _("ORANGE_clr") 
    elseif id == "4" then return _("BLUE_clr") 
    else return _("UNKNOWN") end
end



function colorLister_tag()
    return {
        {id="0", name=_("REMOVE")},
        {id="1", name=_("GREEN_clr")},
        {id="2", name=_("RED_clr")},
        {id="3", name=_("WHITE_clr")},
        {id="4", name=_("ORANGE_clr")},
        {id="5", name=_("BLUE_clr")},
    }
end
function colorTagToName(cdata, id)
    if     id == "1" then return _("GREEN_clr") 
    elseif id == "2" then return _("RED_clr") 
    elseif id == "3" then return _("WHITE_clr") 
    elseif id == "4" then return _("ORANGE_clr") 
    elseif id == "5" then return _("BLUE_clr") 
    elseif id == "0" then return _("REMOVE") 
    else return _("UNKNOWN") end
end



function onOffDisp(cdata, id)
    if   id  then return _("ON")
	else  		  return _("OFF")
	end
end

local on_off_combo_data = 
{
	{id = false , name = onOffDisp(nil,false)},
	{id = true  , name = onOffDisp(nil,true)}
}


local ON_OFF_FIELD =
{	
	id    = "value",
	type  = "combo",
	default = false,
	comboFunc     = function() return on_off_combo_data end,
	displayFunc   = onOffDisp,
	serializeFunc = null_transform,
}

local START_DELAY =
{
	id      = "start_delay",
	type    = "spin",
	default =  0,
	min     =  0,
	max     =  100,
	step    =  0.1,
}

local FILE_SELECT =
{
	id 		= "file",
	type 	= "file_edit",
	default = "",
}

local function out_picture_fields(out)
	
	local out = out or {}
	
	out[#out + 1] = 
	{
		id 		= "file",
		type 	= "file_img",
		default = "",
	}
	out[#out + 1] =
	{	
		--duration
		id 		= "seconds",
		type 	= "spin",
		default = 10,
		min     = 0, -- если время показа картинки 0, то показываем до вызова a_out_picture_stop DCSCORE-2754
		max     = 1000,
	}
	out[#out + 1] =
	{
        id 		= "clearview",
        type 	= "checkbox",
        default = false,
    }
	out[#out + 1] = START_DELAY
	out[#out + 1] = 
	{
		id 				= "horzAlignment",
		type 			= "combo",
		comboFunc 		= alignmentHorzLister,
		displayFunc 	= alignmentHorzIdToName,
		serializeFunc 	= null_transform,
		default 		= "1",
	}
	out[#out + 1] =
	{
		id 				= "vertAlignment",
		type 			= "combo",
		comboFunc 		= alignmentVertLister,
		displayFunc 	= alignmentVertIdToName,
		serializeFunc 	= null_transform,
		default 		= "1",
	}
    out[#out + 1] =
	{
		id 		= "size",
		type 	= "spin",
		default =  100,
		min     =  1,
		max     =  100,
	}
	out[#out + 1] =
	{
		id 				= "size_units",
		type 			= "combo",
		comboFunc 		= sizeUnitsLister,
		displayFunc 	= sizeUnitsIdToName,
		serializeFunc 	= null_transform,
		default 		= "0",
	}
	return out
end

function fm_amDisp(cdata, id)
    if   id  then return _("AM")
	else  		  return _("FM")
	end
end

local am_fm_combo_data = 
{
	{id = false , name = fm_amDisp(nil,false)},
	{id = true  , name = fm_amDisp(nil,true)}
}

local AM_FM_FIELD =
{	
	id    = "modulation",
	type  = "combo",
	default = false,
	comboFunc     = function() return am_fm_combo_data end,
	displayFunc   = am_fmDisp,
	serializeFunc = null_transform,
}

local function flag_with_id(inid,initvalue, intitle)

return {  	id 		= inid or "flag",
			title 	= intitle,
			type 	= "text",
			default = tostring(initvalue or 1),
			serializeFunc   = null_transform,
			displayFunc     = function(cdata,param) return '"'..param..'"' end,}	
			
end

local FLAG_FIELD =  flag_with_id("flag")
 

local FLAG_VALUE = {
	id      = "value",
	type    = "spin",
	default =  1,
	min     =  0,
	max     =  SPINBOX_MAX_VALUE,
	step    =  1,
}

local RADIO_TEXT = {
	id 		= "radiotext",
	type 	= "text",
	default = "",
}

local RADIO_NAME = {
	id 		= "name",
	type 	= "text",
	default = "",
}

function TEXT_FIELD(name)
     return {
        id              = name,
        type            = "text",
        default         = "",
        displayFunc     = function(cdata,param) return '"'..param..'"' end,
        serializeFunc   = null_transform,
    }
end

local ZONE_SELECTOR =
{
	id 				= "zone",
	type 			= "combo",
	comboFunc 		= predicates.zonesLister,
	displayFunc 	= predicates.zoneIdToName,
	existsFunc 		= predicates.isZoneExists,
	default 		= "",
	serializeFunc 	= null_transform,
}

local COCKPIT_ADDITIONAL_PLUGIN =
{
	id              = "COCKPIT_ADDITIONAL_PLUGIN",
	type            = "text",
	default         = "",
	displayFunc     = function(cdata,param) return '"'..param..'"' end,
	serializeFunc   = null_transform,
}



local UNIT_SELECTOR		= predicates.UNIT_SELECTOR
local VEHICLE_SELECTOR	= predicates.VEHICLE_SELECTOR

-- list of available actions for score calculation and their arguments
-- list of available actions for triggers and their arguments
actionsDescr = {
--[[    
    {
        name = "a_out_text";
        fields = {
            {
                id = "text",
                type = "medit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            },
        }
    },
]]
    {
        name = "a_out_text_delay";
        fields = {
            {
                id = "text",
                type = "medit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            },
            {
                id = "seconds",
                type = "spin",
                default = 10,
                min     =  1,
                max     =  1000,
            },
            {
                id = "clearview",
                type = "checkbox",
                default = false,
            },
			START_DELAY,
        },
    },

    {
        name = "a_out_text_delay_s";
        fields = {
            {
                id = "coalitionlist",
                type = "combo",
                comboFunc = CoalitionUtils.listerNameRedBlue,
                displayFunc = coalitionIdToName,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "text",
                type = "medit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            },
            {
                id = "seconds",
                type = "spin",
                default = 10,
                min     =  1,
                max     =  1000,
            },
            {
                id = "clearview",
                type = "checkbox",
                default = false,
            },
			START_DELAY,
        },
    },

    {
        name = "a_out_text_delay_g";
        fields = {
            {
                id = "group",
                type = "combo",
                comboFunc = groupsAHLister,
                displayFunc = groupIdToName,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "text",
                type = "medit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            },
            {
                id = "seconds",
                type = "spin",
                default = 10,
                min     =  1,
                max     =  1000,
            },
            {
                id = "clearview",
                type = "checkbox",
                default = false,
            },
			START_DELAY,
        },
    },
	{
        name = "a_out_text_delay_u";
        fields = {
			UNIT_SELECTOR,
            {
                id = "text",
                type = "medit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            },
            {
                id = "seconds",
                type = "spin",
                default = 10,
                min     =  1,
                max     =  1000,
            },
            {
                id = "clearview",
                type = "checkbox",
                default = false,
            },
			START_DELAY,
        },
    },
    {
        name = "a_out_text_delay_c";
        fields = {
            {
                id = "countrylist",
                type = "combo",
                comboFunc = countryLister,
                displayFunc = countryIdToName,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "text",
                type = "medit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            },
            {
                id = "seconds",
                type = "spin",
                default = 10,
                min     =  1,
                max     =  1000,
            },
            {
                id = "clearview",
                type = "checkbox",
                default = false,
            },
			START_DELAY,
        }
    },
        
    {
        name = "a_mark_to_all";
        fields = {
            {
                id = "value",
                type = "spin",
                default = 10,
                min = 1,
                max = 100,
                step = 1,
            },
            {
                id = "text",
                type = "medit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            },
			ZONE_SELECTOR,
			{
                id = "readonly",
                type = "checkbox",
                default = false,
            },
			{
                id = "comment",
                type = "edit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            },
        },
    },
    
    {
        name = "a_mark_to_coalition";
        fields = {
            {
                id = "value",
                type = "spin",
                default = 10,
                min = 1,
                max = 100,
                step = 1,
            },
            {
                id = "text",
                type = "medit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            },
			ZONE_SELECTOR,
            {
                id = "coalitionlist",
                type = "combo",
                comboFunc = CoalitionUtils.listerNameRedBlue,
                displayFunc = coalitionIdToName,
                serializeFunc = null_transform,
                default = "",
            },
			{
                id = "readonly",
                type = "checkbox",
                default = false,
            },
			{
                id = "comment",
                type = "edit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            },
        },
    },
    
    {
        name = "a_mark_to_group";
        fields = {
            {
                id = "value",
                type = "spin",
                default = 10,
                min = 1,
                max = 100,
                step = 1,
            },
            {
                id = "text",
                type = "medit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            },
			ZONE_SELECTOR,
            {
                id = "group",
                type = "combo",
                comboFunc = groupsAHLister,
                displayFunc = groupIdToName,
                serializeFunc = null_transform,
                default = "",
            },
			{
                id = "readonly",
                type = "checkbox",
                default = false,
            },
			{
                id = "comment",
                type = "edit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            },
        },
    },
    
    {
        name = "a_remove_mark";
        fields = {
            {
                id = "value",
                type = "spin",
                default = 10,
                min = 1,
                max = 100,
                step = 1,
            },            
        },
    },

    {
        name = "a_set_flag";
        fields = {
                    FLAG_FIELD,
        }
    },

    {
        name = "a_clear_flag";
        fields = {
            FLAG_FIELD,
        }
    },
	
    {
        name = "a_set_flag_value";
        fields = {
                    FLAG_FIELD,
					FLAG_VALUE
       }
    },	

    {
        name = "a_set_flag_random";
        fields = {
                    FLAG_FIELD,
             {
                id      = "min_value",
                type    = "spin",
                default =  0,
                min     =  0,
                max     =  SPINBOX_MAX_VALUE,
                step    =  1,
            },
            {
                id      = "max_value",
                type    = "spin",
                default =  100,
                min     =  1,
                max     =  SPINBOX_MAX_VALUE,
                step    =  1,
            },
       }
    },

    {
        name = "a_inc_flag";
        fields = {
            FLAG_FIELD,
            {
                id = "value",
                type = "spin",
                default = 10,
                min = 1,
                max = SPINBOX_MAX_VALUE,
                step = 1,
            },
        }
    },

    {
        name = "a_dec_flag";
        fields = {
            FLAG_FIELD,
            {
                id = "value",
                type = "spin",
                default = 10,
                min = 1,
                max = SPINBOX_MAX_VALUE,
                step = 1,
            },
        }
    },
	
	{
		name = 'a_user_draw_show',
		fields = {
			{
                id				= "coalitionlist",
                type			= "combo",
                default			= "",				
                comboFunc		= CoalitionUtils.listerNameRedBlue,
                displayFunc		= coalitionIdToName,
                serializeFunc	= null_transform,

            },	
            {
                id				= "rolelist",
                type			= "combo",
                default			= "",
                comboFunc		= rolesLister,
                displayFunc		= roleIdToName,
                serializeFunc	= null_transform,
            },
		},
	},	
	
	{
		name = 'a_user_draw_hide',
		fields = {
			{
                id				= "coalitionlist",
                type			= "combo",
                comboFunc		= CoalitionUtils.listerNameRedBlue,
                displayFunc		= coalitionIdToName,
                serializeFunc	= null_transform,
                default			= "",
            },
            {
                id				= "rolelist",
                type			= "combo",
                default			= "",
                comboFunc		= rolesLister,
                displayFunc		= roleIdToName,
                serializeFunc	= null_transform,
            },
		},
	},
	
	{
        name = "a_out_picture";
        fields = out_picture_fields()
    },
	{
        name = "a_out_picture_stop";
        fields = {},
    },
    {
        name = "a_out_picture_s";
        fields = out_picture_fields({
            {
                id = "coalitionlist",
                type = "combo",
                comboFunc = CoalitionUtils.listerNameRedBlue,
                displayFunc = coalitionIdToName,
                serializeFunc = null_transform,
                default = "",
            }
		})
    },
    {
        name = "a_out_picture_g";
        fields = out_picture_fields({
            {
                id = "group",
                type = "combo",
                comboFunc = groupsAHLister,
                displayFunc = groupIdToName,
                serializeFunc = null_transform,
                default = "",
            }
		})
    },  
    {
        name = "a_out_picture_u";
        fields = out_picture_fields({
			UNIT_SELECTOR
		})
    },	
    {
        name = "a_out_picture_c";
        fields = out_picture_fields({
            {
                id = "countrylist",
                type = "combo",
                comboFunc = countryLister,
                displayFunc = countryIdToName,
                serializeFunc = null_transform,
                default = "",
            }
        })
    },
    {
        name = "a_out_sound";
        fields = {
            FILE_SELECT,
			START_DELAY
        }
    },
	{
        name = "a_out_sound_stop";
        fields = {},
    },
    {
        name = "a_out_sound_s";
        fields = {
            {
                id = "coalitionlist",
                type = "combo",
                comboFunc = CoalitionUtils.listerNameRedBlue,
                displayFunc = coalitionIdToName,
                serializeFunc = null_transform,
                default = "",
            },
            FILE_SELECT,
			START_DELAY
        }
    },

    {
        name = "a_out_sound_g";
        fields = {
            {
                id = "group",
                type = "combo",
                comboFunc = groupsAHLister,
                displayFunc = groupIdToName,
                serializeFunc = null_transform,
                default = "",
            },
            FILE_SELECT,
			START_DELAY
        }
    },
	{
        name = "a_out_sound_u";
        fields = {
			UNIT_SELECTOR,
            FILE_SELECT,
			START_DELAY
        }
    },
    {
        name = "a_out_sound_c";
        fields = {
            {
                id = "countrylist",
                type = "combo",
                comboFunc = countryLister,
                displayFunc = countryIdToName,
                serializeFunc = null_transform,
                default = "",
            },
            FILE_SELECT,
			START_DELAY
        }
    },
    
    {
        name = "a_activate_group";
        fields = {
            {
                id = "group",
                type = "combo",
                default = "",
                comboFunc = groupsLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
            },
        }
    },
	
	{
        name = "a_activate_static";
        fields = {
            {
                id = "group",
                type = "combo",
                default = "",
                comboFunc = groupsStaticLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
            },
        }
    },

    {
        name = "a_fall_in_template";
        fields = {
            {
                id = "group",
                type = "combo",
                default = "",
                comboFunc = groupsVLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
            },
            {
                id = "template",
                type = "combo",
                default = "",
                comboFunc = templatesLister,
                existsFunc = isTemplateExists,
            },
        }
    },

    {
        name = "a_deactivate_group";
        fields = {
            {
                id = "group",
                type = "combo",
                default = "",
                comboFunc = groupsLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
            },
        }
    },

    {
        name = "a_end_mission";
        fields = {
            {
                id = "winner",
                type = "combo",
                default = "",
                comboFunc = winnerLister,
                displayFunc = winnerIdToName,
                serializeFunc = null_transform,
            },
            {
                id = "text",
                type = "medit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            },
			START_DELAY,
        }
    },

    {
        name = "a_set_failure";
        fields = {
            {
                id = "failure",
                type = "combo",
                comboFunc = failureLister,
                displayFunc = failureIdToName,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "probability",
                type = "spin",
                default = 100,
                min = 1,
                max = 100,
            },
            {
                id = "random_pause",
                type = "spin",
                default = 1,
                min = 1,
                max = 999,
            }
        }
    },
	
	{
        name = "a_set_ATC_silent_mode";
		fields = {
			{	
                id = "object",
				type = "combo", 
				comboFunc = airdromeAndHeliportLister,	
				displayFunc = airdromeAndHeliportDisplay,
				serializeTblFunc = airdromeAndHeliportSerialize,				
            },
			{
                id = "silent",
				type 	= "checkbox",
                default = false,             
            },
        }
    },
	
	{
        name = "a_set_internal_cargo";
        fields = {
            {
                id = "cargo_mass",
                type = "spin",
                default = 100,
                min = 0,
				step = 1,
                max = 5000,
            },
        }
    },

    {
        name = "a_set_internal_cargo_unit";
        fields = {
			UNIT_SELECTOR,
            {
                id = "cargo_mass",
                type = "spin",
                default = 600,
                min = 0,
                step = 100,
                max = 100000,
            },
        }
    },

    {
        name = "a_explosion",
        fields = {
            ZONE_SELECTOR,
            {
                id = "altitude",
                type = "spin",
                default = 1,
                min = 1,
                max = 30000,
            },
            {
                id = "volume",
                type = "spin",
                default = 1000,
                min = 1,
				step = 1,
                max = 10000,
            },
        }
    },

    {
        name = "a_explosion_unit",
        fields = {
			UNIT_SELECTOR,
            {
                id = "volume",
                type = "spin",
                default = 1000,
                min = 1,
				step = 1,
                max = 10000,
            },
        }
    },
    {
        name = "a_explosion_marker",
        fields = {
            ZONE_SELECTOR,
            {
                id = "altitude",
                type = "spin",
                default = 1,
                min = 1,
                max = 30000,
            },
            {
                id = "color",
                type = "combo",
                comboFunc = colorLister_smoke,
                displayFunc = colorIdToName,
                serializeFunc = null_transform,
                default = "0",
            },
        }
    },
    {
        name = "a_explosion_marker_unit",
        fields = {
			UNIT_SELECTOR,
            {
                id = "color",
                type = "combo",
                comboFunc = colorLister_smoke,
                displayFunc = colorIdToName,
                serializeFunc = null_transform,
                default = "0",
            },
        }
    },
    {
        name = "a_aircraft_ctf_color_tag",
        fields = {
			UNIT_SELECTOR,
            {
                id = "color",
                type = "combo",
                comboFunc = colorLister_tag,
                displayFunc = colorTagToName,
                serializeFunc = null_transform,
                default = "0",
            },
        }
    },
    {
        name = "a_effect_smoke",
        fields = {
            ZONE_SELECTOR,
            -- {
                -- id = "altitude",
                -- type = "spin",
                -- default = 1,
                -- min = 1,
                -- max = 30000,
            -- },			
            {
                id = "preset",
                type = "combo",
                comboFunc = GetEffectSmokePresets,
                displayFunc = GetEffectSmokePresetId,
                serializeFunc = null_transform,
                default = 1,
            },
			{
                id = "density",
                type = "spin",
                default = 1.0,
                min	= 0.0,
                max = 1.0,
				step = 0.05,
            },
			{
				id 		= "name",
				type 	= "text",
				default = "",
			},
        }
    },
	{
        name = "a_effect_smoke_stop",
        fields = {
			{
				id 		= "name",
				type 	= "text",
				default = "",
			},

        }
    },
    {
        name = "a_illumination_bomb",
        fields = {
            ZONE_SELECTOR,
            {
                id = "altitude",
                type = "spin",
                default = 1,
                min = 1,
                max = 30000,
            },
        }
    },
    {
        name = "a_signal_flare",
        fields = {
            ZONE_SELECTOR,
            {
                id = "altitude",
                type = "spin",
                default = 1,
                min = 1,
                max = 30000,
            },
            {
                id = "color",
                type = "combo",
                comboFunc = colorLister_snare,
                displayFunc = colorIdToName,
                serializeFunc = null_transform,
                default = "0",
            },
            {
                id = "bearing",
                type = "spinbearing",
                default = "0",
            },
        }
    },
    {
        name = "a_signal_flare_unit",
        fields = {
			UNIT_SELECTOR,
            {
                id = "color",
                type = "combo",
                comboFunc = colorLister_snare,
                displayFunc = colorIdToName,
                serializeFunc = null_transform,
                default = "0",
            },
            {
                id = "bearing",
                type = "spinbearing",
                default = "0",
            },
        }
    },
    {
        name = "a_play_argument",
        fields = {
            {
                id = "object",
                type = "combo",
                comboFunc = groupsListerS,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
            },
            {
                id = "argument",
                type = "spin",
                default = 0,
                min = 0,
                max = 1000,
            },
            {
                id = "start",
                type    = "spin",
                default =  0,
                step    =  0.05,
            },
            {
                id = "stop",
                type    = "spin",
                default =  1,
                step    =  0.05,
            },
            {
                id = "speed",
                type    = "spin",
                default =  1,
                step    =  0.05,
            },
        }
    },
--[[
    {
        name = "a_set_altitude",
        fields = {
            {
                id = "object",
                type = "combo",
                comboFunc = groupsListerS,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
            },
            {
                id = "altitude",
                type    = "spin",
                default =  0,
                step    =  1,
                min     =  0,
            },
        }
    },--]]
    {
        name = "a_load_mission",
        fields = {
            {
                id = "file",
                type = "file_miz",
                default = "",
            },
        }
    },
    {
        name = "a_cockpit_highlight",
        fields = {
            {
                id      = "highlight_id",
                type    = "spin",
                default = 0,
                min     = 0,
                max     = 100,
                step    = 1
            },
            {
                id              = "element_name",
                type            = "text",
                default         = "",
                displayFunc     = function(cdata,param) return '"'..param..'"' end,
                serializeFunc   = null_transform,
            },
            {
                id      = "size_of_box",
                type    = "spin",
                default = 0,
                min     = 0,
                max     = 1,
                step    = 0.01
            },
			COCKPIT_ADDITIONAL_PLUGIN,
        }
    },
    {
        name = "a_cockpit_highlight_position",
        fields = {
            {
                id      = "highlight_id",
                type    = "spin",
                default = 0,
                min     = 0,
                max     = 100,
                step    = 1
            },
            {
                id      = "in_cockpit_position_x",
                type    = "spin",
                default = 1,
                min     =-2,
                max     = 2,
                step    = 0.01
            },
            {
                id      = "in_cockpit_position_y",
                type    = "spin",
                default =  0,
                min     = -2,
                max     =  2,
                step    = 0.01
            },
            {
                id      = "in_cockpit_position_z",
                type    = "spin",
                default = 0,
                min     = -2,
                max     =  2,
                step    = 0.01
            },
            {
                id      = "size_of_box_x",
                type    = "spin",
                default = 0.1,
                min     = 0,
                max     = 1,
                step    = 0.01
            },
            {
                id      = "size_of_box_y",
                type    = "spin",
                default = 0.1,
                min     = 0,
                max     = 1,
                step    = 0.01
            },
            {
                id      = "size_of_box_z",
                type    = "spin",
                default = 0.1,
                min     = 0,
                max     = 1,
                step    = 0.01
            },
        }
    },
    {
        name = "a_cockpit_highlight_indication",
        fields = {
            {
                id      = "highlight_id",
                type    = "spin",
                default = 0,
                min     = 0,
                max     = 100,
                step    = 1
            },
            {
                id      = "indicator_id",
                type    = "spin",
                default = 0,
                min     = 0,
                max     = 100,
                step    = 1
            },
            {
                id              = "element_name",
                type            = "text",
                default         = "",
                displayFunc     = function(cdata,param) return '"'..param..'"' end,
                serializeFunc   = null_transform,
            },
            {
                id      = "size_of_box",
                type    = "spin",
                default = 0,
                min     = 0,
                max     = 1,
                step    = 0.01
            },          
			COCKPIT_ADDITIONAL_PLUGIN,
         }
    },
    {
        name = "a_cockpit_remove_highlight",
        fields = {
            {
                id      = "highlight_id",
                type    = "spin",
                default = 0,
                min     = 0,
                max     = 100,
                step    = 1
            },
        }
    },
	{
        name = "c_start_wait_for_user",
        fields = {
            flag_with_id("flag", nil, "flag_continue"),			
			flag_with_id("flag_back",999)
        }
    },
	{
        name   = "c_stop_wait_for_user",
        fields = {}
	},
    {
        name = "a_set_command",
        fields = {
            {
                id      = "command",
                type    = "spin",
                default =  0,
                min     =  0,
                max     =  100000,
                step    =  1,
            },
        }
    },
    {
        name = "a_set_command_with_value",
        fields = {
            {
                id      = "command",
                type    = "spin",
                default =  0,
                min     =  0,
                max     =  100000,
                step    =  1,
            },
            {
                id      = "value",
                type    = "spin",
                default =  0,
                min     = -1.0,
                max     =  1.0,
                step    =  0.05,
            },
        }
    },
    {
        name = "a_start_listen_command",
        fields = {
            {
                id      = "command",
                type    = "spin",
                default =  0,
                min     =  0,
                max     =  100000,
                step    =  1,
            },
            FLAG_FIELD,
            {
                id      = "hit_count",
                type    = "spin",
                default =  0,
                min     =  0,
                max     =  1000000,
                step    =  1,
            },
            {
                id      = "min_value",
                type    = "spin",
                default =  -1000000,
                min     =  -1000000,
                max     =   1000000,
                step    =   0.01,
            },
            {
                id      = "max_value",
                type    = "spin",
                default =   1000000,
                min     =  -1000000,
                max     =   1000000,
                step    =   0.01,
            },
			{
                id      = "cockpit_device",
                type    = "spin",
                default =  0,
                min     =  0,
                max     =  255,
                step    =  1,
            },
        }
    },
    {
        name = "a_start_listen_event",
        fields =
        {
            {
                id              = "event",
                type            = "text",
                default         = "",
                displayFunc     = function(cdata,param) return '"'..param..'"' end,
                serializeFunc   = null_transform,
            },
            FLAG_FIELD,
        }
    },
    {
        name = "a_cockpit_perform_clickable_action",
        fields = {
            {
                id      = "cockpit_device",
                type    = "spin",
                default =  0,
                min     =  0,
                max     =  255,
                step    =  1,
            },
            {
                id      = "command",
                type    = "spin",
                default =  3001,
                min     =  3001,
                max     =  3999,
                step    =  1,
            },
            {
                id      = "value",
                type    = "spin",
                default =  0,
                min     = -1,
                max     =  1,
                step    =  0.05,
            },
			COCKPIT_ADDITIONAL_PLUGIN,
        }
    },
    {
        name = "a_cockpit_param_save_as",
        fields = {
            {
                id              = "source",
                type            = "text",
                default         = "",
                displayFunc     = function(cdata,param) return '"'..param..'"' end,
                serializeFunc   = null_transform,
            },
            {
                id              = "destination",
                type            = "text",
                default         = "",
                displayFunc     = function(cdata,param) return '"'..param..'"' end,
                serializeFunc   = null_transform,
            },
        }
    },
    {
        name = "a_add_radio_item";
        fields = {
			RADIO_TEXT,
            FLAG_FIELD,
			FLAG_VALUE
        }
    },
    {
        name = "a_remove_radio_item";
        fields = {
			RADIO_TEXT
        }
    },
    {
        name = "a_add_radio_item_for_coalition";
        fields = {
            {
                id = "coalitionlist",
                type = "combo",
                default = "all",
                comboFunc = CoalitionUtils.listerNameRedBlue,
                displayFunc = coalition2IdToName,
                serializeFunc = null_transform,
            },
			RADIO_TEXT,
            FLAG_FIELD,
			FLAG_VALUE
        }
    },
    {
        name = "a_remove_radio_item_for_coalition";
        fields = {
            {
                id = "coalitionlist",
                type = "combo",
                default = "all",
                comboFunc = CoalitionUtils.listerNameRedBlue,
                displayFunc = coalition2IdToName,
                serializeFunc = null_transform,
            },
			RADIO_TEXT,
         }
    },
    {
        name = "a_add_radio_item_for_group";
        fields = {
            {
                id = "group",
                type = "combo",
                default = "",
                comboFunc = groupsLister,
                --displayFunc = groupIdToName,
                existsFunc = isGroupExists,
            },
			RADIO_TEXT,
            FLAG_FIELD,
			FLAG_VALUE
        }
    },
    {
        name = "a_remove_radio_item_for_group";
        fields = {
            {
                id = "group",
                type = "combo",
                default = "",
                comboFunc = groupsLister,
                --displayFunc = groupIdToName,
                existsFunc = isGroupExists,
            },
			RADIO_TEXT,
        }
    },
	{
        name = "a_group_stop";
        fields = {
            {
                id = "group",
                type = "combo",
                default = "",
                comboFunc = groupsVLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
				serializeFunc = null_transform,
            },
        }
    },
    {
        name = "a_group_resume";
        fields = {
            {
                id = "group",
                type = "combo",
                default = "",
                comboFunc = groupsVLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
            },
        }
    },
    {
        name = "a_group_on";
        fields = {
            {
                id = "group",
                type = "combo",
                default = "",
                comboFunc = groupsVSLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
            },
        }
    },
    {
        name = "a_group_off";
        fields = {
            {
                id = "group",
                type = "combo",
                default = "",
                comboFunc = groupsVSLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
            },
        }
    },
	{
        name = "a_group_controllable_on";
        fields = {
            {
                id = "group",
                type = "combo",
                default = "",
                comboFunc = groupsVSLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
            },
        }
    },
    {
        name = "a_group_controllable_off";
        fields = {
            {
                id = "group",
                type = "combo",
                default = "",
                comboFunc = groupsVSLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
            },
        }
    },
    {
        name = "a_unit_on",
        fields = {
			VEHICLE_SELECTOR,
        }
    },
    {
        name = "a_unit_off",
        fields = {
			VEHICLE_SELECTOR,
        }
    },
    {
        name = "a_unit_set_life_percentage",
        fields = {
			UNIT_SELECTOR,
            {
                id = "life_percents",
                type = "spin",
                default = 100,
                min = 0,
                step = 1,
                max = 100,
            },
        }
    },
	{
        name = "a_unit_emission_on",
        fields = {
			VEHICLE_SELECTOR,
        }
    },
	{
        name = "a_unit_emission_off",
        fields = {
			VEHICLE_SELECTOR,
        }
    },
    {
        name = "a_set_ai_task",
        fields = {
            {
                id = "set_ai_task",
                type = "combo",
                default = {"", ""},
                comboFunc = aiTaskLister,
                compareFunc = function(left, right)
                    return left[1] == right[1] and left[2] == right[2]
                end,
                displayFunc = taskToName,
                existsFunc = isTaskExists,
                serializeFunc = serializeTask,
            }
        }
    },	
    {
        name = "a_ai_task",
        fields = {
            {
                id = "ai_task",
                type = "combo",
                default = {"", ""},
                comboFunc = aiTaskLister,
                compareFunc = function(left, right)
                    return left[1] == right[1] and left[2] == right[2]
                end,
                displayFunc = taskToName,
                existsFunc = isTaskExists,
                serializeFunc = serializeTask,
            }
        }
    },	
	{
	    name   = "a_prevent_controls_synchronization",
        fields = {ON_OFF_FIELD}
	},
	{
		name = "a_radio_transmission",
        fields = {
            {
                id = "file",
                type = "file_edit",
                default = "",
            },
            ZONE_SELECTOR,
			AM_FM_FIELD,
			{	
				id    = "loop",
				type  = "combo",
				default = false,
				comboFunc     = function() return on_off_combo_data end,
				displayFunc   = onOffDisp,
				serializeFunc = null_transform,
			},
            {
                id      = "frequency",
                type    = "spin",
                default =  124,
                min     =  0.300,
                max     =  30000,
                step    =  0.001,
            },
            {
                id      = "power",
                type    = "spin",
                default =  100,
                min     =  1,
                max     =  10000,
                step    =  1,
            },
			RADIO_NAME,
			START_DELAY,
		},
	},
	{
       name = "a_stop_radio_transmission";
        fields = {
			RADIO_NAME,
        }	
	},
	{
		name = "a_show_helper_gate",
		fields = {
            {
                id      = "x",
                type    = "edit",
                default = 0,
            },
            {
                id      = "z",
                type    = "edit",
                default = 0,
            },
            {
                id      = "y",
                type    = "edit",
                default = 0,
            },
			{
                id      = "course",
                type    = "edit",
                default = 0,
            },
		}
	},
	{
		name = "a_show_route_gates_for_unit",
		fields = {
			UNIT_SELECTOR,
			FLAG_FIELD,
		}
	},
	{
		name = "a_route_gates_set_current_point",
		fields = {
			UNIT_SELECTOR,
			{
				id      = "number",
                type    = "spin",
                default =  1,
                min     =  0,
                max     =  100,
                step    =  1,
            },
		}
	},

	{
		name = "a_set_briefing",
		fields = {
            {
                id = "coalitionlist",
                type = "combo",
                comboFunc = CoalitionUtils.listerNameRedBlue,
                displayFunc = coalitionIdToName,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "file",
                type = "file_img",
                default = "",
            },
            {
                id = "text",
                type = "medit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            },
		}
	},	
	
	{
		name = "a_do_script",
        fields = {
            {
                id = "text",
                type = "medit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            }
		}
	},
	{
		name = "a_do_script_file",
        fields = {
            {
                id = "file",
                type = "file_script",
                default = "",
            }
		}
	},
	{
		name = "a_cockpit_push_actor",
		fields = 
		{	
			{
				id		= "number",
				type    = "spin",
                default =  1,
                min     =  1,
                max     =  8,
                step    =  1,
			}
		}
	},
	{
		name = "a_cockpit_pop_actor",
		fields = {},
	},
	{
		name = "a_cockpit_lock_player_seat",
		fields = 
		{	
			{
				id		= "number",
				type    = "spin",
                default =  1,
                min     =  1,
                max     =  8,
                step    =  1,
			}
		}
	},
	{
		name   = "a_cockpit_unlock_player_seat",
		fields = {},
	},
	{
		name   = "a_shelling_zone",
		fields = {
            ZONE_SELECTOR,
            {
				id      = "TNT",
                type    = "spin",
                default =  0.5,
                min     =  0.5,
                max     =  500.0,
                step    =  10,
            },
            {
                id      = "shells_count",
                type    = "spin",
                default =  100,
                min     =  1,
                max     =  4000,
                step    =  100,
            },
        }
	},
	{
		name   = "a_scenery_destruction_zone",
		fields = {
            ZONE_SELECTOR,
            {
				id      = "destruction_level",
                type    = "spin",
                default =  0,
                min     =  0,
                max     =  100,
                step    =  10,
            },
        }
	},
	{
		name   = "a_remove_scene_objects",
		fields = {
            ZONE_SELECTOR,
			{	
				id      = "objects_mask",
				type    = "combo",
				default 	  = 0,
				serializeFunc = null_transform,
				comboFunc     = function ()	return {
							{id= 0,name=_("ALL"),},
							{id= 1,name=_("TREES ONLY")},
							{id= 2,name=_("OBJECTS ONLY")}
							}	end,
				displayFunc = function (cdata, id)
								if		id == 1 then return _("TREES ONLY") 
								elseif	id == 2 then return _("OBJECTS ONLY")
								else 				 return _("ALL") end
							  end,
			},
        }
	},
	{
		name   = "a_zone_increment_resize",
		fields = {
            ZONE_SELECTOR,
			{
				id		= "meters",
				type    = "spin",
                default =  1000,
                min     = -1e5,
                max     =  1e5,
                step    =  100,
			}
        }
	},
}

-- create dialog
function create(x, y, w, h)
    U.copyTable(cdata, predicates.cdata)
    
    triggersWindow = loader.spawnDialogFromFile("MissionEditor/modules/dialogs/triggers_dialog.dlg", cdata)
	
	local panelSkins = triggersWindow.panelSkins
	
	predicates.loadSkins(panelSkins)
	
	
	spinBoxRed_				= triggersWindow.Box.pColor.spinBoxRed
	spinBoxGreen_			= triggersWindow.Box.pColor.spinBoxGreen
	spinBoxBlue_			= triggersWindow.Box.pColor.spinBoxBlue
	panelColorButtons_		= triggersWindow.Box.pColor.panelColorButtons
	staticColorView_		= triggersWindow.Box.pColor.staticColorView
	
	staticColorViewSkin_	= staticColorView_:getSkin()
	
	bindColorWidgets()
	createColorButtons(panelColorButtons_)

    local width, height = triggersWindow:getSize()

    triggersWindow:setBounds(w - width, y, width, h)
    triggersWindow.Box:setBounds(0, 0, width, h-30)

    if 1 == #triggersDescr then
        hideTriggerType(triggersWindow.Box)
    end
	
	function triggersWindow:onClose()
		show(false)
	end
end

function isVisible()
	return triggersWindow and triggersWindow:getVisible()
end

local onSpinBoxColorChange = function()
	local item = triggersWindow.Box.triggersList:getSelectedItem()
	if item then
		local newColor = string.format('0x%.2x%.2x%.2x%.2x', spinBoxRed_:getValue(), spinBoxGreen_:getValue(), spinBoxBlue_:getValue(), 255)
		local tmpSkin = item:getSkin()
		local newSkin = SkinUtils.setListBoxItemTextColor(newColor, tmpSkin)
		item:setSkin(newSkin)
		
		local trigger = item.itemId
		trigger.colorItem = newColor
	end
	updateColorWidgets()
end
	
function createColorButtons(panel)
	local colors = {
		{{	0,	 0,	  0},	{128, 128, 128},	{128,	0,	 0},	{128, 128,	 0}},
		{{	0, 128,	  0},	{  0, 128, 128},	{  0,	0, 128},	{128,	0, 128}},
		{{128, 128,	 64},	{  0,  64,	64},	{  0, 128, 255},	{  0,  64, 128}},
		{{128,	 0, 255},	{128,  64,	 0},	{255, 255, 255},	{192, 192, 192}},
		{{255,	 0,	  0},	{255, 255,	 0},	{  0, 255,	 0},	{  0, 255, 255}},
		{{	0,	 0, 255},	{255,	0, 255},	{255, 255, 128},	{  0, 255, 128}},
		{{128, 255, 255},	{128, 128, 255},	{255,	0, 128},	{225, 128, 164}},
	}
	local width, height = panel:getSize()
	local buttonHeight	= height / #colors
	local buttonWidth	= width / #colors[1]
	local buttonSkin	= Skin.buttonSkin()
	
	for i, colorRow in ipairs(colors) do
		for j, color in ipairs(colorRow) do
			local button = Button.new()
			local x = buttonWidth * (j - 1)
			local y = buttonHeight * (i - 1)
			
			button:setBounds(x , y, buttonWidth, buttonHeight)
			panel:insertWidget(button)
			
			button:setSkin(SkinUtils.setButtonColor(string.format('0x%.2x%.2x%.2xff', color[1], color[2], color[3]), buttonSkin))
			
			function button:onChange()
				spinBoxRed_		:setValue(color[1])
				spinBoxGreen_	:setValue(color[2])
				spinBoxBlue_	:setValue(color[3])
				onSpinBoxColorChange()
			end
		end
	end
end


function bindColorWidgets()
	function spinBoxRed_:onChange()
		onSpinBoxColorChange()
	end
	
	function spinBoxGreen_:onChange()
		onSpinBoxColorChange()
	end
	
	function spinBoxBlue_:onChange()
		onSpinBoxColorChange()
	end
end

local function hexColorToRGBA256(hexColor)
	-- hexColor строка в формате 0xrrggbbaa
	local r = tonumber(			string.sub(hexColor, 1, 4)	)	-- 0xrr
	local g = tonumber('0x' .. 	string.sub(hexColor, 5, 6)	)	-- 0xgg
	local b = tonumber('0x' ..	string.sub(hexColor, 7, 8)	)	-- 0xbb
	local a = tonumber('0x' ..	string.sub(hexColor, -2)	)	-- 0xaa
	
	return r, g, b, a
end

function updateColorWidgets()
--	local r, g, b, a = controller_.getTriggerZoneColor(triggerZoneId_)
	local item = triggersWindow.Box.triggersList:getSelectedItem()
	if item then
		local tmpSkin = item:getSkin()
		local hexColor = tmpSkin.skinData.states.released[1].text.color
			
		local r, g, b, a = hexColorToRGBA256(hexColor)
			
		spinBoxRed_		:setValue(r)
		spinBoxGreen_	:setValue(g)
		spinBoxBlue_	:setValue(b)
		
		staticColorView_:setSkin(SkinUtils.setStaticColor(hexColor, staticColorViewSkin_))
	end	
end

-- show triggers dialog
function show(b)
    if b then
        if not mission.mission.trigrules then
            mission.mission.trigrules = { }
        end
        fixTriggers(mission.mission.trigrules)
        setupCallbacks(triggersWindow.Box, mission.mission.trigrules, 
                 triggersDescr, actionsDescr, predicates.rulesDescr, cdata)
	else
		base.toolbar.setTrigrulesButtonState(false)
		music.stopOneSound();	
    end
    triggersWindow:setVisible(b)
end

function updatePositionInitScriptPanel(y)
	if y < 191 then
		triggersWindow.Box.p_init_script:setPosition(8,719)
	else
		triggersWindow.Box.p_init_script:setPosition(8,719+(y-191))
	end	
	triggersWindow.Box:updateWidgetsBounds() 
end

-- create widgets for rule predicate editing
function createRuleArgumentsWidgets(window, rule, list, cdata)
    local labelX, _tmp, labelW, _tmp1 = window.ruleTypeLabel:getBounds()
    local comboX, _tmp, comboW, comboH = window.ruleTypeCombo:getBounds()
    predicates.updateArgumentsPanel(rule, list, window.argsContainer, labelX, 
        comboX, labelW, comboW, comboH, cdata)
end


-- create widgets for action editing
function createActionArgumentsWidgets(window, rule, cdata)
    local labelX, _tmp, labelW, _tmp1 = window.goalTypeLabel:getBounds()
    local comboX, _tmp, comboW, comboH = window.goalTypeCombo:getBounds()
    local y = predicates.updateArgumentsPanel(rule, window.goalsList, 
        window.goalArgsContainer, labelX, comboX, labelW, comboW, comboH, 
        cdata)
		
	updatePositionInitScriptPanel(y)	
end

-- create widgets for trigger editing
function createTriggerArgumentsWidgets(window, rule, cdata)
    local labelX, _tmp, labelW, _tmp1 = window.triggerTypeLabel:getBounds()
    local comboX, _tmp, comboW, comboH = window.triggerTypeCombo:getBounds()
    predicates.updateArgumentsPanel(rule, window.triggersList, 
        window.triggerArgsContainer, labelX, comboX, labelW, comboW, comboH, 
        cdata.Triggers)
end


-- Create action from description
function createAction(descr)
    return predicates.createRule(descr)
end


-- Create trigger from description
function createTrigger(descr)
    local res = predicates.createRule(descr)
    res.actions = { }
    res.rules = { }
	res.comment = "Trigger ".. base.os.time() -- default trigger name
    return res
end



-- show or hide rules widgets
function showRulesWidgets(window, visible)
    predicates.showWidgets(visible, window.argsContainer, window.ruleTypeCombo,
        window.ruleTypeLabel, window.delRuleBtn)
end


-- show or hide goals widgets
function showGoalsWidgets(window, visible)
    predicates.showWidgets(visible, window.goalArgsContainer, 
        window.goalTypeCombo, window.goalTypeLabel, window.delGoalBtn)
end


-- show or hide triggers widgets
function showTriggersWidgets(window, visible, noActionChoice)
    if noActionChoice then
        predicates.showWidgets(visible, window.triggerArgsContainer, 
                window.delTriggerBtn)
    else
        predicates.showWidgets(visible, window.triggerArgsContainer, 
                window.triggerTypeCombo, window.triggerTypeLabel, 
                window.delTriggerBtn)
    end
end



-- hide action type combo
function hideTriggerType(window)

    window.triggerTypeLabel:setVisible(false)
    window.triggerTypeCombo:setVisible(false)
    local x, y, w, h = window.triggerArgsContainer:getBounds()
    local _tmp, _tmp1, _tmp2, offset = window.triggerTypeCombo:getBounds()
    offset = offset + 10
    window.triggerArgsContainer:setBounds(x, y - offset, w, h + offset)

end

local function selectListBoxItem(listBox, itemIndex)
	itemIndex = itemIndex or listBox:getItemCount()
	local item = listBox:getItem(itemIndex - 1)
	
	listBox:selectItem(item)
	listBox:setItemVisible(item)
	listBox:onChange(item)
end

-- setup callbacks
function setupCallbacks(window, triggers, triggersDesc, actionsDescr, 
                rulesDescr, cdata)
	
	function window.p_init_script.b_load_init_script:onChange(self)
		mod_dictionary.removeResource(mission.mission.initScriptFile)
        window.p_init_script.e_init_script_file.resId = nil
		
		local path = MeSettings.getScriptPath()
		local filters = {FileDialogFilters.script()}
		local filename = FileDialog.open(path, filters, _('Choose Lua script:'))
		
		if filename then
			MeSettings.setScriptPath(filename)
            
            local newId = mod_dictionary.getNewResourceId("initScript")   
            mod_dictionary.setValueToResource(newId, U.extractFileName(filename), filename, "DEFAULT")	
           
            window.p_init_script.e_init_script_file.resId = newId
			window.p_init_script.e_init_script_file:setText(mod_dictionary.getValueResource(newId))
			window.p_init_script.e_init_script_file:onChange()
		end
		mission.mission.initScriptFile = window.p_init_script.e_init_script_file.resId
		
		window.p_init_script.e_init_script:setEnabled(false)
	end

	local text = ""    
    if mission.mission.initScriptFile then
        text = mod_dictionary.getValueResource(mission.mission.initScriptFile)
    end            
    window.p_init_script.e_init_script_file:setText(text)

    
	function window.p_init_script.b_reset_init_script:onChange(self)
		mod_dictionary.removeResource(mission.mission.initScriptFile)
		mission.mission.initScriptFile = nil
        window.p_init_script.e_init_script_file.resId = nil
		window.p_init_script.e_init_script_file:setText('')
		window.p_init_script.e_init_script:setEnabled(true)		
	end
	
	function window.p_init_script.e_init_script:onChange(self)    
		mission.mission.initScript = window.p_init_script.e_init_script:getText()
	end
	window.p_init_script.e_init_script:setEnabled(mission.mission.initScriptFile == nil)
	window.p_init_script.e_init_script:setText(mission.mission.initScript or '')

    local noTriggerChoice = (1 == #triggersDescr)

    -- add new trigger on new button pressed
    function window.newTriggerBtn:onChange()
        local trigger = createTrigger(triggersDescr[1])
        table.insert(triggers, trigger)
        local item = U.addListBoxItem(window.triggersList, 
                predicates.getRuleAsText(trigger, cdata), trigger)
				
		selectListBoxItem(window.triggersList)
    end

    -- delete current trigger
    function window.delTriggerBtn:onChange()
        local item = window.triggersList:getSelectedItem()
        if item then
            local trigger = item.itemId

            for _tmp, action in ipairs(trigger.actions) do
				--print("delFile")
                if action.file and action.predicate.name ~= "a_load_mission" then
                    mod_dictionary.removeResource(action.file);   
                end        
				action.file = '';
            end
          
            local idx = predicates.getIndex(triggers, trigger)
            table.remove(triggers, idx)
            window.triggersList:removeItem(item)
            if idx > window.triggersList:getItemCount() then
                idx = idx - 1
            end
			
			selectListBoxItem(window.triggersList, idx)
        end
    end

    -- called on new trigger selected 
    function window.triggersList:onChange(item)
        if item then
            showTriggersWidgets(window, true, noTriggerChoice)
            local trigger = item.itemId
            predicates.rulesToList(window.goalsList, trigger.actions, cdata)
            predicates.rulesToList(window.rulesList, trigger.rules, cdata)
            window.triggerTypeCombo.selectedItem = trigger
            window.triggerTypeCombo:setText(predicates.getPredicateName(trigger.predicate, 
                        cdata))
            createTriggerArgumentsWidgets(window, trigger, cdata)
			
			updateColorWidgets()
        else
            showTriggersWidgets(window, false, noTriggerChoice)
            predicates.rulesToList(window.goalsList, nil, cdata)
            predicates.rulesToList(window.rulesList, nil, cdata)
            showTriggersWidgets(window, false)
        end
    end
    
    -- called on new goal selected 
    function window.goalsList:onChange(item)
        if item then
            showGoalsWidgets(window, true)
            local goal = item.itemId
            if goal.file and goal.predicate then
                goal.predicate.file = goal.file
            end
            window.goalTypeCombo.selectedItem = goal
            window.goalTypeCombo:setText(predicates.getPredicateName(goal.predicate, cdata))
            createActionArgumentsWidgets(window, goal, cdata)
        else
            showGoalsWidgets(window, false)
        end
    end
    
    -- add new goal on new button pressed
    function window.newGoalBtn:onChange()
        local item = window.triggersList:getSelectedItem()
        if item then
            local trigger = item.itemId
            local goal = createAction(actionsDescr[1])
            table.insert(trigger.actions, goal)
            local item = U.addListBoxItem(window.goalsList, 
                    predicates.getRuleAsText(goal, cdata), goal)
			
			selectListBoxItem(window.goalsList)
            window.goalTypeCombo:onChange(window.goalTypeCombo:getSelectedItem())
        end
    end

    -- delete current action
    function window.delGoalBtn:onChange()
        local triggerItem = window.triggersList:getSelectedItem()
        local item = window.goalsList:getSelectedItem()
        if item and triggerItem then
            local goal = item.itemId
            local goals = triggerItem.itemId.actions
            if (goal ~= nil) and (goal.file ~= nil) and (goal.file ~= '') then
                --print("delFile")
                mod_dictionary.removeResource(goal.file)
            end;
            local idx = predicates.getIndex(goals, goal)
            table.remove(goals, idx)
            window.goalsList:removeItem(item)
            if idx > window.goalsList:getItemCount() then
                idx = idx - 1
            end

			selectListBoxItem(window.goalsList, idx)
        end
    end

    function window.UpTrigBtn:onChange()
        local trigItem = window.triggersList:getSelectedItem()
        if trigItem and trigItem.itemId then
            local idx = predicates.getIndex(triggers, trigItem.itemId)
            if idx > 1 then 
                window.triggersList:clear()
                local tosave = triggers[idx]
                table.remove(triggers, idx)
                table.insert(triggers, idx-1, tosave)
                predicates.rulesToList(window.triggersList, triggers, cdata)

				selectListBoxItem(window.triggersList, idx-1)
            end
        end
    end
	
    function window.UpRuleBtn:onChange()
        local trigItem = window.triggersList:getSelectedItem()
        local item = window.rulesList:getSelectedItem()
        if not item or not item.itemId or not trigItem or not trigItem.itemId or not trigItem.itemId.rules then return end
        local idx = predicates.getIndex(trigItem.itemId.rules, item.itemId)
        if idx > 1 then 
            window.rulesList:clear()
            local tosave = trigItem.itemId.rules[idx]
            table.remove(trigItem.itemId.rules, idx)
            table.insert(trigItem.itemId.rules, idx-1, tosave)
            predicates.rulesToList(window.goalsList, trigItem.itemId.actions, cdata)
            predicates.rulesToList(window.rulesList, trigItem.itemId.rules, cdata)

			selectListBoxItem(window.rulesList, idx-1)
        end
    end
	
    function window.UpActionBtn:onChange()
        local trigItem = window.triggersList:getSelectedItem()
        local item = window.goalsList:getSelectedItem()
        if not item or not item.itemId or not trigItem or not trigItem.itemId or not trigItem.itemId.actions then return end
        local idx = predicates.getIndex(trigItem.itemId.actions, item.itemId)
        if idx > 1 then 
            window.goalsList:clear()
            local tosave = trigItem.itemId.actions[idx]
            table.remove(trigItem.itemId.actions, idx)
            table.insert(trigItem.itemId.actions, idx-1, tosave)
            predicates.rulesToList(window.goalsList, trigItem.itemId.actions, cdata)

			selectListBoxItem(window.goalsList, idx-1)
        end
    end

    function window.DownTrigBtn:onChange()
        local trigItem = window.triggersList:getSelectedItem()
        if trigItem and trigItem.itemId then
            local idx = predicates.getIndex(triggers, trigItem.itemId)
            if idx < #triggers then 
                window.triggersList:clear()
                local tosave = triggers[idx]
                table.remove(triggers, idx)
                table.insert(triggers, idx+1, tosave)
                predicates.rulesToList(window.triggersList, triggers, cdata)

				selectListBoxItem(window.triggersList, idx+1)
            end
        end
    end
	
    function window.DownRuleBtn:onChange()
        local trigItem = window.triggersList:getSelectedItem()
        local item = window.rulesList:getSelectedItem()
        if not item or not item.itemId or not trigItem or not trigItem.itemId or not trigItem.itemId.rules then return end
        local idx = predicates.getIndex(trigItem.itemId.rules, item.itemId)
        if idx < # trigItem.itemId.rules then 
            window.rulesList:clear()
            local tosave = trigItem.itemId.rules[idx]
            table.remove(trigItem.itemId.rules, idx)
            table.insert(trigItem.itemId.rules, idx+1, tosave)
            predicates.rulesToList(window.goalsList, trigItem.itemId.actions, cdata)
            predicates.rulesToList(window.rulesList, trigItem.itemId.rules, cdata)

			selectListBoxItem(window.rulesList, idx+1)
        end
    end
    function window.DownActionBtn:onChange()
        local trigItem = window.triggersList:getSelectedItem()
        local item = window.goalsList:getSelectedItem()
        if not item or not item.itemId or not trigItem or not trigItem.itemId or not trigItem.itemId.actions then return end
        local idx = predicates.getIndex(trigItem.itemId.actions, item.itemId)
        if idx < # trigItem.itemId.actions then 
            window.goalsList:clear()
            local tosave = trigItem.itemId.actions[idx]
            table.remove(trigItem.itemId.actions, idx)
            table.insert(trigItem.itemId.actions, idx+1, tosave)
            predicates.rulesToList(window.goalsList, trigItem.itemId.actions, cdata)

			selectListBoxItem(window.goalsList, idx+1)
        end
    end
    
    function window.CloneTrigBtn:onChange()
        local trigItem = window.triggersList:getSelectedItem()
        if trigItem and trigItem.itemId then
            local idx = predicates.getIndex(triggers, trigItem.itemId)
            if idx and idx > 0 and idx <= #triggers then            
                local newItem = U.copyTable(newItem,triggers[idx])
                table.insert(triggers, idx+1, newItem)
            
                window.triggersList:clear()
                window.rulesList:clear()
                window.goalsList:clear()
                predicates.rulesToList(window.triggersList, triggers, cdata)
                predicates.rulesToList(window.goalsList, triggers[idx+1].actions, cdata)
                predicates.rulesToList(window.rulesList, triggers[idx+1].rules, cdata)
                
				for k, v in pairs(triggers[idx+1].rules) do
                    if v.text then
                        local oldKey = v.text
                        local text = mod_dictionary.getValueDict(oldKey)  
                        mod_dictionary.textToME(v,'text', mod_dictionary.getNewDictId("ActionText"))	
                        v.text = text
                    end
                end
				
                for k, v in pairs(triggers[idx+1].actions) do
                    if v.file and v.predicate.name ~= "a_load_mission" then
                        local oldKey = v.file
                        v.file = mod_dictionary.getNewResourceId("Action")   
                        local fileName, path = mod_dictionary.getValueResource(oldKey)   
                        mod_dictionary.setValueToResource(v.file, fileName, path, nil, true)	
                    end
                    
                    if v.text then
                        local oldKey = v.text
                        local text = mod_dictionary.getValueDict(oldKey)  
                        mod_dictionary.textToME(v,'text', mod_dictionary.getNewDictId("ActionText"))	
                        v.text = text
                    end
					
					if v.comment then
                        local oldKey = v.comment
                        local comment = mod_dictionary.getValueDict(oldKey)  
                        mod_dictionary.textToME(v,'comment', mod_dictionary.getNewDictId("ActionComment"))	
                        v.comment = comment
                    end
                    
                    if v.radiotext then    
						local oldKey = v.radiotext
                        local radiotext = mod_dictionary.getValueDict(oldKey)  
                        mod_dictionary.textToME(v,'radiotext', mod_dictionary.getNewDictId("ActionRadioText"))	
                        v.radiotext = radiotext
                    end
                end

				selectListBoxItem(window.triggersList, idx+1)
            end
        end
    end
    
    function window.CloneRuleBtn:onChange()
        local trigItem = window.triggersList:getSelectedItem()
        local item = window.rulesList:getSelectedItem()
        if not item or not item.itemId or not trigItem or not trigItem.itemId or not trigItem.itemId.rules then return end
        local idx = predicates.getIndex(trigItem.itemId.rules, item.itemId)
        if idx and idx > 0 and idx <= #trigItem.itemId.rules then 
            --U.traverseTable(trigItem.itemId.rules,5)
            local newItem = U.copyTable(newItem,trigItem.itemId.rules[idx])
            table.insert(trigItem.itemId.rules, idx+1, newItem)          

			if newItem.text then
				local oldKey = newItem.text
				local text = mod_dictionary.getValueDict(oldKey)  
				mod_dictionary.textToME(newItem,'text', mod_dictionary.getNewDictId("ActionText"))	
				newItem.text = text
			end
				
            window.rulesList:clear()
            ---window.goalsList:clear()
            --predicates.rulesToList(window.goalsList, trigItem.itemId.actions, cdata)
            predicates.rulesToList(window.rulesList, trigItem.itemId.rules, cdata)

			selectListBoxItem(window.rulesList, idx+1)
            --U.traverseTable(trigItem.itemId.rules,5)
        end
    end

    function window.CloneActionBtn:onChange()
        local trigItem = window.triggersList:getSelectedItem()
        local item = window.goalsList:getSelectedItem()
        if not item or not item.itemId or not trigItem or not trigItem.itemId or not trigItem.itemId.actions then return end
        local idx = predicates.getIndex(trigItem.itemId.actions, item.itemId)
        if idx and idx > 0 and idx <= #trigItem.itemId.actions then             
            local newItem = U.copyTable(newItem,trigItem.itemId.actions[idx])
            table.insert(trigItem.itemId.actions, idx+1, newItem)
            
            if newItem.file and newItem.predicate.name ~= "a_load_mission" then
                local oldKey = newItem.file
                newItem.file = mod_dictionary.getNewResourceId("Action")   
                local fileName, path = mod_dictionary.getValueResource(oldKey)   
                mod_dictionary.setValueToResource(newItem.file, fileName, path, nil, true)	
            end
            
            if newItem.text then
                local oldKey = newItem.text
                local text = mod_dictionary.getValueDict(oldKey)  
                mod_dictionary.textToME(newItem,'text', mod_dictionary.getNewDictId("ActionText"))	
                newItem.text = text
            end  
			
			if newItem.comment then
                local oldKey = newItem.comment
                local comment = mod_dictionary.getValueDict(oldKey)  
                mod_dictionary.textToME(newItem,'comment', mod_dictionary.getNewDictId("ActionComment"))	
                newItem.comment = comment
            end 

            if newItem.radiotext then    
				local oldKey = newItem.radiotext
                local radiotext = mod_dictionary.getValueDict(oldKey)  
                mod_dictionary.textToME(newItem,'radiotext', mod_dictionary.getNewDictId("ActionRadioText"))	
                newItem.radiotext = radiotext
            end
            
            window.goalsList:clear()
            predicates.rulesToList(window.goalsList, trigItem.itemId.actions, cdata)

			selectListBoxItem(window.goalsList, idx+1)
        end
    end
    
    function window.ORruleBtn:onChange()
        local trigItem = window.triggersList:getSelectedItem()
        local item = window.rulesList:getSelectedItem()
        if not item or not item.itemId or not trigItem or not trigItem.itemId or not trigItem.itemId.rules then return end
        local idx = predicates.getIndex(trigItem.itemId.rules, item.itemId)
        if idx and idx > 0 and idx <= # trigItem.itemId.rules then 
            base.assert(rulesDescr['or'])
            local rule = predicates.createRule(rulesDescr['or']) -- последний предикат OR
            table.insert(trigItem.itemId.rules, idx+1, rule)
            window.rulesList:clear()
            window.goalsList:clear()
            predicates.rulesToList(window.goalsList, trigItem.itemId.actions, cdata)
            predicates.rulesToList(window.rulesList, trigItem.itemId.rules, cdata)

			selectListBoxItem(window.rulesList, idx+1)
        end
    end
    
    -- if action type was changed  "действия"
    function window.goalTypeCombo:onChange(item)
        self.selectedItem = (item and item.itemId or self.selectedItem)
        if window.goalsList:getSelectedItem() then
			--window.goalsList:getSelectedItem().itemId = {}
            local goal = window.goalsList:getSelectedItem().itemId
            --освобождаем предыдущий ресурс в этом экшене 
            if (goal.file ~= nil) then
                mod_dictionary.removeResource(goal.file)          
            end
			-- очищаем от старых данных
			local keys = {}
			for k,v in pairs(goal) do
				keys[k] = k
			end
			for k,v in pairs(keys) do
				goal[k] = nil
			end

            goal.value = nil
            goal.predicate = self.selectedItem 
            localizeNewAction(goal)
            predicates.setRuleDefaults(goal, self.selectedItem)
            createActionArgumentsWidgets(window, goal, cdata)
            predicates.updateListRow(window.goalsList, predicates.ruleTextFunc(cdata))
        end
    end
    
    -- if trigger type was changed 
    function window.triggerTypeCombo:onChange(item)
        self.selectedItem = item.itemId
        if window.triggersList:getSelectedItem() then
            local trigger = window.triggersList:getSelectedItem().itemId
			window.triggersList:getSelectedItem().itemId.eventlist = ""
            trigger.predicate = item.itemId
            createTriggerArgumentsWidgets(window, trigger, cdata)
            predicates.updateListRow(window.triggersList, predicates.ruleTextFunc(cdata))
        end
    end
    
    -- called on new rule selected 
    function window.rulesList:onChange(item)
        if item then
            showRulesWidgets(window, true)
            local rule = item.itemId
            createRuleArgumentsWidgets(window, rule, window.rulesList, cdata)
            window.ruleTypeCombo.selectedItem = rule			
            window.ruleTypeCombo:setText(predicates.getPredicateName(rule.predicate, cdata))
        else
            showRulesWidgets(window, false)
        end
    end
   
    
    function window.newRuleBtn:onChange()
        local goalItem = window.triggersList:getSelectedItem()
        if goalItem then
            local rule = predicates.createRule(rulesDescr[1])
            table.insert(goalItem.itemId.rules, rule)
            local item = U.addListBoxItem(window.rulesList, 
                        predicates.getRuleAsText(rule, cdata), rule)
			
			selectListBoxItem(window.rulesList)            
        end
    end

    -- if predicate type was changed 
    function window.ruleTypeCombo:onChange(item)        
        self.selectedItem = item.itemId
        if window.rulesList:getSelectedItem() then
            local rule = window.rulesList:getSelectedItem().itemId          
            rule.predicate = item.itemId
			localizeNewAction(rule)
            predicates.setRuleDefaults(rule, item.itemId)
            createRuleArgumentsWidgets(window, rule, window.rulesList, cdata)
            predicates.updateListRow(window.rulesList, predicates.ruleTextFunc(cdata))
        end
    end
    
    -- delete rule
    function window.delRuleBtn:onChange()
        local currentGoal = window.triggersList:getSelectedItem()
        local item = window.rulesList:getSelectedItem()
        if currentGoal and item and (0 < window.rulesList:getItemCount()) then
            local rule = item.itemId
            local goal = currentGoal.itemId
            local idx = predicates.getIndex(goal.rules, rule)
            table.remove(goal.rules, idx)
            window.rulesList:removeItem(item)
            if idx > window.rulesList:getItemCount() then
                idx = idx - 1
            end
			
			selectListBoxItem(window.rulesList, idx)
        end
    end

    predicates.rulesToList(window.triggersList, triggers, cdata)
    predicates.fillPredicatesCombo(window.triggerTypeCombo, triggersDescr, cdata)
    predicates.fillPredicatesCombo(window.goalTypeCombo, actionsDescr, cdata)
    predicates.fillPredicatesCombo(window.ruleTypeCombo, rulesDescr, cdata)
    
    predicates.rulesToList(window.rulesList, nil, cdata)
    showRulesWidgets(window, false)
    
end

-- проверяем новый экшен на необходимость добавления ключей локализации
function localizeNewAction(a_newGoal)
    --ищем места для вставки ключей локализации
    for k, field in pairs(a_newGoal.predicate.fields) do
        if field.type == 'file_edit' or field.type == 'file_script' or field.type == "file_img" then
            -- Добавляем ключ для локализации ресурсов
            a_newGoal.predicate.file = mod_dictionary.getNewResourceId("Action")
        end

        if field.type == 'medit' and a_newGoal.predicate.name ~= 'a_do_script' then
            mod_dictionary.textToME(a_newGoal, 'text', mod_dictionary.getNewDictId("ActionText"))
        end
		
		if field.id == "comment" and field.type == 'edit' then
            mod_dictionary.textToME(a_newGoal, 'comment', mod_dictionary.getNewDictId("ActionComment"))
        end
        
        if field.id == "radiotext" and field.type == "text" then
            mod_dictionary.textToME(a_newGoal, 'radiotext', mod_dictionary.getNewDictId("ActionRadioText"))
        end
   
    end
 
end

-- convert goals to serializable description
function saveTriggers(triggers)
  if not triggers then
      return { }
  end
  local result = { }
  U.copyTable(result, triggers)
  for _tmp, goal in ipairs(result) do
      goal.predicate = goal.predicate.name

      for _tmp, rule in ipairs(goal.rules) do	  
			if rule.text ~= nil then
				mod_dictionary.textToMis(rule, 'text', rule.text, rule.KeyDict_text) 
			end
			rule.predicate = rule.predicate.name
      end
      for _tmp, goal in ipairs(goal.actions) do
            if goal.text ~= nil then
				if goal.predicate.name ~= 'a_do_script' then
					mod_dictionary.textToMis(goal, 'text', goal.text, goal.KeyDict_text) 
				else
					goal.KeyDict_text = nil
				end
			end
			
			if goal.comment ~= nil then
                mod_dictionary.textToMis(goal, 'comment', goal.comment, goal.KeyDict_comment)
			end
			
            if goal.radiotext ~= nil then
                mod_dictionary.textToMis(goal, 'radiotext', goal.radiotext, goal.KeyDict_radiotext)
            end
                       
            goal.predicate = goal.predicate.name
      end
  end
  return result
end

-- convert triggers from serializable desctiption to internal representation
function loadTriggers(triggers)
    if not triggers then
        return { }
    end

    local triggersByName = predicates.getRulesIndex(triggersDescr)
    local actionsByName = predicates.getRulesIndex(actionsDescr)
    local predicatesByName = predicates.getRulesIndex(predicates.rulesDescr)
    local result = { }
    U.copyTable(result, triggers)
    for _tmp, goal in ipairs(result) do
        goal.predicate = triggersByName[goal.predicate]
        for _tmp, rule in ipairs(goal.rules) do
			if rule.predicate == "c_expression" then
				-- для совместимости старых версий
				rule.predicate = "c_predicate"
			end		
			
			if (mission.mission.version < 8) then
				mod_dictionary.fixDict(rule, 'text', rule.text) 
			else
				mod_dictionary.textToME(rule, 'text', rule.text) 
			end
			
            rule.predicate = predicatesByName[rule.predicate]
        end
        for _tmp, rule in ipairs(goal.actions) do
            if rule.text then
                if (mission.mission.version < 8) then
                    mod_dictionary.fixDict(rule, 'text', rule.text) 
                else					
					if rule.predicate ~= 'a_do_script' then
						mod_dictionary.textToME(rule, 'text', rule.text) 
					elseif (mission.mission.version < 19) then	
						local tmpKey = rule.text
						rule.text = mod_dictionary.getValueDictDEFAULT(tmpKey)
						mod_dictionary.clearDict(tmpKey)
					end
                end
            end
            if rule.radiotext then
                if (mission.mission.version < 9) then
                    mod_dictionary.fixDict(rule, 'radiotext', rule.radiotext) 
                else
                    mod_dictionary.textToME(rule, 'radiotext', rule.radiotext) 
                end
            end
			
			if rule.predicate == "a_mark_to_all" or rule.predicate == "a_mark_to_coalition" or rule.predicate == "a_mark_to_group" then
				if (mission.mission.version < 14) then
					mod_dictionary.fixDict(rule, 'comment', rule.comment, "ActionComment") 
				else
					mod_dictionary.textToME(rule, 'comment', rule.comment) 
				end
			end	
			
			if rule.predicate == 'a_do_script_file' then
				if (mission.mission.version < 19) then	
					if rule.file then
						mod_dictionary.clearResourceExceptDEFAULT(rule.file)
					end
				end
            end
			
            if rule.frequency then
                if (mission.mission.version < 13) then
                    rule.frequency = rule.frequency / 1000
                end
            end
            rule.predicate = actionsByName[rule.predicate]
        end
    end
    
    return result
end


-- Generate Lua functions from rules list.  
-- All functions returned in array as strings
function generateTriggerConditions(triggers) 
  if not triggers then
      return { }
  end
  local result = { }
  local idx = 1
  for _tmp, trigger in ipairs(triggers) do
    if trigger.rules then

        local str = "return("
        local first = true
        local empty = true

        for _tmp, rule in ipairs(trigger.rules) do
            local skip = false
            if rule.predicate.pseudo then
                if first then
                    skip = true
                end
                first = true
            else
                empty = false
                if first then
                    first = false
                else
                    str = str .. 'and ' 
                end
            end
        
            if not skip then
                str = str .. predicates.actionToString(rule) .. ' '
            end
        end
        if empty then
            str = 'return(true)'
        else
            str = str .. ')'
        end
        result[idx] = str
        idx = idx + 1
    end 
  end
  return result
end

function generateTriggerActions(triggers, startup_) 
  if not triggers then
      return { }
  end
  local result = { }
  local idx = 1
  for _tmp, trigger in ipairs(triggers) do
    if trigger.actions then

      local str = ""
        for _tmp, action in ipairs(trigger.actions) do
          str = str .. predicates.actionToString(action) .. ';'
        end

        if trigger.predicate.name == "triggerOnce" then
			if trigger.eventlist and (trigger.eventlist ~= "") then
				str = str .. ' mission.trig.events["' .. tostring(trigger.eventlist) .. '"][' .. tostring(idx) .. ']=nil;'
			else
				str = str .. ' mission.trig.func[' .. tostring(idx) .. ']=nil;'
			end --if
        end
		
		
        result[idx] = str
        idx = idx + 1
    end 
  end
  return result
end

function generateEvents(triggers)
  if not triggers then
      return { }
  end
  local result = { }
  
  local events = eventLister()
  for i=2,#events do --first one is empty, skip it
  
	  local idx = 1
	  local event = events[i].id;
	  for _tmp, trigger in ipairs(triggers) do
		if trigger.eventlist and (trigger.eventlist == event) then
	
		  result[event] = result[event] or {}
		  result[event][idx] = "if mission.trig.conditions["..tostring(idx).."]() then mission.trig.actions["..tostring(idx).."]() end"

		end  --if
		idx = idx + 1
	  end --for
  end; 
  return result
end

function generateTriggerFunc2(triggers, startup_) -- Dmut: new format, conditions and actions separated
  if not triggers then
      return { }
  end
  local result = { }
  local idx = 1
  for _tmp, trigger in ipairs(triggers) do

      local save =  (not trigger.eventlist or (trigger.eventlist==""))and ((startup_ and (trigger.predicate.name == "triggerStart")) or (not startup_ and (trigger.predicate.name ~= "triggerStart")))

      local str = {}
      if trigger.predicate.name == "triggerFront" then
          str = "if mission.trig.conditions["..tostring(idx).."]() then if not mission.trig.flag["..tostring(idx).."] then mission.trig.actions["..tostring(idx).."](); mission.trig.flag["..tostring(idx).."] = true;end; else mission.trig.flag["..tostring(idx).."] = false; end;"
      else
          str = "if mission.trig.conditions["..tostring(idx).."]() then mission.trig.actions["..tostring(idx).."]() end"
      
      end

      if save then
        result[idx] = str
      end -- if save

      idx = idx + 1
	  
  end
  return result
end

-- remove invalid rules and actions from triggers
function fixTriggers(triggers)
  if triggers then
  
    local toRemove = { }

    for _tmp, trigger in pairs(triggers) do
        predicates.removeInvalidRules(trigger.rules)
        predicates.removeInvalidRules(trigger.actions)
        
        -- check for OR-only rules
        local good_rule = #trigger.rules == 0 or false;
        for i = 1, #trigger.rules do
            if not trigger.rules[i].predicate.pseudo then good_rule = true; break;end;
        end
		print("good_rule",good_rule)
        if not good_rule or (#trigger.actions < 1) --[[or (#trigger.rules < 1)]] then print("invalid trigger removed, index ",_tmp); table.insert(toRemove, _tmp); end;
    end

    for i = 1, #toRemove do
        table.remove(triggers, toRemove[i] - (i - 1))
    end

  end -- if
end

function enableFileSound(triggers, fileSound)
    if triggers then
        for _tmp, trigger in pairs(triggers) do
            for k, v in pairs(trigger.actions) do
               -- print("string.lower(file) == fileSound  ",v.file,fileSound)
                if (v.file == fileSound) then
                    result = true
                    return true
                end
            end
        end
    end    
    return false
end

function countTriggerFileRef(triggers, file)
	local refCount = 0
    if triggers then
        for _tmp, trigger in pairs(triggers) do
            for k, v in pairs(trigger.actions) do
                if (v.file == file) then
					refCount = refCount + 1
                end
            end
        end
    end    
    return refCount
end