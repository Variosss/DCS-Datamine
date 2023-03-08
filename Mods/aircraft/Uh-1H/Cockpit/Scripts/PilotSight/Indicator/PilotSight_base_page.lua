dofile(LockOn_Options.script_path.."PilotSight/Indicator/PilotSight_definitions.lua")
dofile(LockOn_Options.common_script_path.."elements_defs.lua")
local k = 0.5

num_points =32
step = math.rad(360.0/num_points)
	
verts = {}
for i = 1, num_points do
	verts[i] = {TFOV * math.cos(i * step), TFOV * math.sin(i * step)}
end

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


SymbologyBox1 = CreateElement "ceMeshPoly"
SymbologyBox1.name = "SymbologyBox1"
SymbologyBox1.primitivetype = "triangles"
SymbologyBox1.vertices	= verts
SymbologyBox1.indices		 = inds
SymbologyBox1.init_pos		 = {0.0, 0.0, -15.0}---0.005/GetScale()}
SymbologyBox1.init_rot		 = {0, 0, 47.0}
SymbologyBox1.material		 = "GREEN_2"
SymbologyBox1.h_clip_relation = h_clip_relations.REWRITE_LEVEL
SymbologyBox1.level			 = HUD_NOCLIP_LEVEL
SymbologyBox1.isdraw			 = true
SymbologyBox1.change_opacity	 = false
SymbologyBox1.isvisible		 = false
Add(SymbologyBox1)


total_field_of_view1 = CreateElement "ceMeshPoly"
total_field_of_view1.name = "total_field_of_view1"
total_field_of_view1.primitivetype = "triangles"


total_field_of_view1.vertices = verts
total_field_of_view1.indices		     = inds
total_field_of_view1.init_pos		 = {0, ZSL, 0.0}
total_field_of_view1.material		 = "DBG_RED"
total_field_of_view1.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
total_field_of_view1.level			 = HUD_DEFAULT_LEVEL - 1
total_field_of_view1.isdraw			= true
total_field_of_view1.change_opacity	= false
total_field_of_view1.collimated 		= true
total_field_of_view1.isvisible		= false
total_field_of_view1.z_enabled 		= false
Add(total_field_of_view1)

