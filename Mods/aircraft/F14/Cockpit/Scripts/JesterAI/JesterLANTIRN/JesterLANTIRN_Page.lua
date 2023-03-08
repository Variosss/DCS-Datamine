dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
dofile(LockOn_Options.common_script_path.."devices_defs.lua")

INDICATOR_LEVEL = JESTER_DEFAULT_LEVEL

dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

SetScale(MILLYRADIANS)
SetCustomScale(GetScale() * 0.34)

function AddElement(object, additive)
    Add(object)
end

local grid_origin = create_origin()
grid_origin.init_pos = {0.0, 0.0, 0.0}

JesterLantirnMat = MakeMaterial(nil,{221,36,36,255})

function addCircle(name, radius, pos)
	local segmentsN = 64
	local circle     		= CreateElement "ceSCircle"
	circle.radius    	 	= {radius, radius}
	circle.arc       		= {0, math.pi * 2}
	circle.segment_detail   = 4
	circle.dashed    	= false
	circle.thickness    		= 0.2
    circle.fuzziness    		= 2.5
    circle.name               = name
    circle.isdraw             = true
    circle.isvisible    	= true
    circle.material           = JesterLantirnMat
    circle.additive_alpha	  = false
    circle.use_mipfilter      = true
    circle.parent_element = grid_origin.name
    circle.level = JESTER_DEFAULT_LEVEL
    pos = pos or { 0, 0 }
    circle.init_pos       	  = { pos[1], pos[2], 0 }
	return circle
end

local qeyeballs_pointer_radius = 17.5
local head_pointer_radius_1 = 2.0
local head_pointer_radius_2 = 6.0
local head_pointer_radius_3 = 10.0
local vdi_center_radius = 5 * qeyeballs_pointer_radius
local head_max_radius = 35 * qeyeballs_pointer_radius

local qeyeballs_pointer = addCircle( "jester_lantirn_qeyeballs", qeyeballs_pointer_radius )
qeyeballs_pointer.controllers = {{"jester_lantirn_qeyeballs"}}
Add(qeyeballs_pointer)

local head_pointer_main = create_origin("jester_lantirn_head_pointer_main")
head_pointer_main.controllers = {{"jester_lantirn_head_pointer"}}
head_pointer_main.parent_element = grid_origin.name
head_pointer_main.init_pos = { 0, 0, 0 }

local head_pointer_1 = addCircle( "jester_lantirn_head_pointer_1", head_pointer_radius_1 )
head_pointer_1.parent_element = head_pointer_main.name
Add(head_pointer_1)

local head_pointer_2 = addCircle( "jester_lantirn_head_pointer_2", head_pointer_radius_2 )
head_pointer_2.parent_element = head_pointer_main.name
Add(head_pointer_2)

local head_pointer_3 = addCircle( "jester_lantirn_head_pointer_3", head_pointer_radius_3 )
head_pointer_3.parent_element = head_pointer_main.name
Add(head_pointer_3)

local vdi_center = addCircle( "jester_lantirn_vdi_center", vdi_center_radius )
vdi_center.controllers = {{"jester_lantirn_vdi_center"}}
Add(vdi_center)

local head_max_ring = addCircle( "jester_lantirn_head_max_ring", head_max_radius )
head_max_ring.controllers = {{"jester_lantirn_head_max_ring"}}
Add(head_max_ring)
