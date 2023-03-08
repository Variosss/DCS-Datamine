WAYPOINT_STP	=	0
WAYPOINT_STP_SUBTYPES	=	0+5
	BASICTYPE_INT              = 1
	BASICTYPE_LANDMARK         = 2
	BASICTYPE_OBSTACLE         = 4
	BASICTYPE_REFPOINT		   = 8
	BASICTYPE_CLIMB_POINT      = 16
	BASICTYPE_DIVE_POINT       = 32
WAYPOINT_AIRDROME	=	1
WAYPOINT_AIRDROME_SUBTYPES	=	1+5
WAYPOINT_AIRDROME_SUBTYPES_FULL	=	1
WAYPOINT_AIRDROME_SUBTYPES_BRIEF	=	0
	AD_MILITARY_AERODROME			 = 6
	AD_MILITARY_HELIDROME			 = 10
	AD_MILITARY_SEADROME			 = 18
	AD_CIVIL_AIRPORT				 = 5
	AD_CIVIL_SEADROME				 = 17
	AD_CIVIL_HELIPORT				 = 9
	AERODROME_TYPE_CLOSED			=	32
	AERODROME_TYPE_COMMON			=	4
	AERODROME_TYPE_NEW				=	64
WAYPOINT_RADIOBEACON	=	2
WAYPOINT_RADIOBEACON_SUBTYPES	=	2+5
	BEACON_TYPE_VOR			     = 1
	BEACON_TYPE_DME              = 2
	BEACON_TYPE_TACAN            = 4
	BEACON_TYPE_HOMER            = 8	
	BEACON_TYPE_VOR_DME	      = 3
	BEACON_TYPE_VOR_TACAN     = 5
	BEACON_TYPE_AIRPORT_HOMER = 264
	BEACON_TYPE_ROUTE_MARKER  = 528
	BEACON_TYPE_ILS_MARKER    = 1040
WAYPOINT_TOWN	=	3
WAYPOINT_TOWN_SUBTYPES	=	3+5
WAYPOINT_DATALINK_POINT	=	4
WAYPOINT_DATALINK_POINT_SUBTYPES	=	4+5
	DLPT_UNKNOWN	=	0
	DLPT_ARMOR	=	1
	DLPT_AIRDEFENCE	=	2
	DLPT_OTHER	=	3
	DLPT_REFPOINT	=	4
	DLPT_GROUP_MEMBER	=	5


waypoint_type_name = {}
waypoint_type_name[WAYPOINT_STP]="ТОЧКА"
waypoint_type_name[WAYPOINT_STP_SUBTYPES] = {
    [BASICTYPE_INT]="ППМ ",
    [BASICTYPE_LANDMARK]="ГЕОТОЧКА",
    [BASICTYPE_OBSTACLE]="ПРЕПЯТСТВИЕ",
    [BASICTYPE_REFPOINT]="ОРИЕНТИР",
    [BASICTYPE_CLIMB_POINT]="ТОЧКА НАБОРА",
    [BASICTYPE_DIVE_POINT]="ТОЧКА СНИЖЕНИЯ",
}	
	
waypoint_type_name[WAYPOINT_AIRDROME]="АЭРОДРОМ"
waypoint_type_name[WAYPOINT_AIRDROME_SUBTYPES] = {
    	[AD_CIVIL_AIRPORT]={	
        	"ГРАЖД",
        	"АЭРОПОРТ ГРАЖД",
        },
    	[AD_CIVIL_HELIPORT]={
            "ГРАЖД ВЕРТ",
            "ВЕРТОДРОМ ГРАЖД",
        },
        [AD_CIVIL_SEADROME]={
            "ГРАЖД ГИДРО",
            "ГИДРОАЭРОДРОМ ГРАЖД",
        },
        [AD_MILITARY_AERODROME]={
            "ВОЕН",
            "АЭРОДРОМ ВОЕН",
        },
        [AD_MILITARY_HELIDROME]={
            "ВОЕН ВЕРТ",
            "ВЕРТОДРОМ ВОЕН",
        },
        [AD_MILITARY_SEADROME]={
            "ВОЕН ГИДРО",
            "ГИДРОАЭРОДРОМ ВОЕН",
        },
        [AERODROME_TYPE_CLOSED]={
            "ЗАКРЫТ",
            "ЗАКРЫТ",
        },
        [AERODROME_TYPE_COMMON]={
            "",
            "АЭРОДРОМ",
        },
        [AERODROME_TYPE_NEW]={
            "АП",
            "АП",
        }
 }
		
	
waypoint_type_name[WAYPOINT_RADIOBEACON]="РАДИО"
waypoint_type_name[WAYPOINT_RADIOBEACON_SUBTYPES] = {
    [BEACON_TYPE_VOR]           ="VOR",
    [BEACON_TYPE_DME]           ="DME",
    [BEACON_TYPE_TACAN]         ="TACAN",
    [BEACON_TYPE_VOR_DME]       ="VOR/DME",
    [BEACON_TYPE_VOR_TACAN]     ="VOR/TAC",
    [BEACON_TYPE_HOMER]         ="ОПРС",
    [BEACON_TYPE_AIRPORT_HOMER] ="ОПРС",
    [BEACON_TYPE_ROUTE_MARKER]  ="ROUTE MARKER",
    [BEACON_TYPE_ILS_MARKER]    ="ILS MARKER",
}

waypoint_type_name[WAYPOINT_TOWN]="ГОРОД"
waypoint_type_name[WAYPOINT_DATALINK_POINT]="ЦУ"
waypoint_type_name[WAYPOINT_DATALINK_POINT_SUBTYPES] = {
    [DLPT_UNKNOWN]      ="НЕИЗВ",
    [DLPT_ARMOR]        ="БРОНЯ",
    [DLPT_AIRDEFENCE]   ="ПВО",
    [DLPT_OTHER]        ="ПРОЧ",
    [DLPT_REFPOINT]     ="ТЧК ПОДХОДА",
    [DLPT_GROUP_MEMBER] ="ВЕДОМЫЙ",
}
 
function get_WAYPOINT_TYPE_NAME(wp_type)
	if		waypoint_type_name[wp_type] ~= nil then
		return LOCALIZE(waypoint_type_name[wp_type])
	else
		return ""
	end	
end

function get_WAYPOINT_DESCRIPTION(wp_type,wp_subtype,view_type)

    if	waypoint_type_name[wp_type]               == nil or
        waypoint_type_name[wp_type+5]             == nil or
        waypoint_type_name[wp_type+5][wp_subtype] == nil then			
        return ""
    end
    local obj = waypoint_type_name[wp_type+5][wp_subtype]
    if  wp_type ~= WAYPOINT_AIRDROME then
        return LOCALIZE(obj)
    end 
    
    if	obj[view_type + 1] ~= nil then
        return LOCALIZE(obj[view_type + 1])
    end
    return ""
end
