dofile(LockOn_Options.script_path.."PKV/Indicator/PKV_definitions.lua")
dofile(LockOn_Options.common_script_path.."elements_defs.lua")

TFOV    = 110

num_points = 32
step = math.rad(360.0/num_points)
	
verts = {}
for i = 1, num_points do
	verts[i] = {TFOV * math.cos(i * step), TFOV * math.sin(i * step)}
end

local k = 0.5

SymbologyBox_sizeX 		= 40
SymbologyBox_sizeXmax 	= 65
SymbologyBox_sizeY  	= 50
SymbologyBox_sizeY_med  = 30

SymbologyBox = CreateElement "ceMeshPoly"
SymbologyBox.name = "SymbologyBox"
SymbologyBox.primitivetype = "triangles"


SymbologyBox.vertices	= {
							{-SymbologyBox_sizeX, -SymbologyBox_sizeY},
							{-SymbologyBox_sizeX, SymbologyBox_sizeY},
							{ SymbologyBox_sizeXmax, SymbologyBox_sizeY},
							{ SymbologyBox_sizeXmax, -SymbologyBox_sizeY},
							{ -SymbologyBox_sizeX - 20, SymbologyBox_sizeY_med},
							{ -SymbologyBox_sizeX - 20, -SymbologyBox_sizeY_med},
						}						
						

SymbologyBox.indices		 = {0,1,2,2,3,0,0,5,4,0,4,1}
SymbologyBox.init_pos		 = {0.0, 0.0, 0.0}
SymbologyBox.init_rot		 = {0.0, -45.0, 0.0}
SymbologyBox.material		 = "GREEN_2"
SymbologyBox.h_clip_relation = h_clip_relations.REWRITE_LEVEL
SymbologyBox.level			 = HUD_NOCLIP_LEVEL
SymbologyBox.isdraw			 = true
SymbologyBox.change_opacity	 = false
SymbologyBox.isvisible		 = false
Add(SymbologyBox)


total_field_of_view = CreateElement "ceMeshPoly"
total_field_of_view.name = "total_field_of_view"
total_field_of_view.primitivetype = "triangles"

total_field_of_view.vertices = verts

inds = {}
j = 0
for i = 0, 29 do
	j = j + 1
	inds[j] = 0
	j = j + 1
	inds[j] = i + 1
	j = j + 1
	inds[j] = i + 2
end

total_field_of_view.indices		     = inds
total_field_of_view.init_pos		 = {0.0, 0.0, 0.0}
total_field_of_view.init_rot		 = {0.0, 0.0, 0.0}
total_field_of_view.material		 = "RED_TRANSPARENT"
total_field_of_view.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
total_field_of_view.level			 = HUD_DEFAULT_LEVEL - 1
total_field_of_view.isdraw			= true
total_field_of_view.change_opacity	= false
total_field_of_view.collimated 		= true
total_field_of_view.isvisible		= false
total_field_of_view.z_enabled 		= false
Add(total_field_of_view)

