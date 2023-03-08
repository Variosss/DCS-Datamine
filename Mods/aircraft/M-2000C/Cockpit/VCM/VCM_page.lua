local my_path = LockOn_Options.script_path.."VCM/"
dofile(my_path.."VCM_definitions.lua")


--Generate VCM circle mask
local VCM_radius  =  80 -- millimeters
num_points = 32
step = math.rad(360.0/num_points)

local verts = {}
for i = 1, num_points do
	verts[i] = {VCM_radius * math.cos(i * step), VCM_radius * math.sin(i * step)}
end

local inds = {}
for i = 0, 29 do
	inds[i*3+1] = 0
	inds[i*3+2] = i + 1
	inds[i*3+3] = i + 2
end

vcm_screen_view	 				  = CreateElement "ceMeshPoly"
vcm_screen_view.name 			  = "vcm-mask"
vcm_screen_view.material		  = MakeMaterial(nil,{0,0,0,0})
vcm_screen_view.h_clip_relation   = h_clip_relations.REWRITE_LEVEL
vcm_screen_view.level			  = VCM_DEFAULT_LEVEL
vcm_screen_view.collimated	  	  = false
vcm_screen_view.isvisible		  = true
vcm_screen_view.z_emable		  = true
vcm_screen_view.vertices = verts
vcm_screen_view.indices  = inds
Add(vcm_screen_view)


create_symbol("vcm-center", "vcm-cross", 1.0, nil, nil, {{"vcm_cross"}})
create_text("vcm-pcm", "PCM", 6, "CenterCenter", nil, nil, {{"vcm_pcm"}})
create_text("vcm-cross", "M", 9, "CenterCenter", nil, nil, {{"vcm_taf"}})

for i = 0, 5 do
	create_symbol("vcm-fail-sect-"..i, "vcm-fail-sect", 0.92, nil, nil, {{"vcm_serval_sensor_fail", i}})
end


-- SERVAL threats
for i = 0, 7 do
	local name = "vcm-serval-threat-" .. i
	create_text(name, "", 5, "CenterCenter", nil, nil, {{"vcm_serval_threat", i, 4.0, 34.0}})
	create_symbol(name.."-lohat", "vcm-lohat", 1.0, nil, name, {{"vcm_serval_threat_lohat", i}})
	create_symbol(name.."-hihat", "vcm-hihat", 1.0, nil, name, {{"vcm_serval_threat_hihat", i}})
	create_symbol(name.."-box", "vcm-box", 1.0, nil, name, {{"vcm_serval_threat_box", i}})
	create_symbol(name.."-moustache", "vcm-moustache", 1.0, nil, name, {{"vcm_serval_threat_moustache", i}})

end

-- DDM threats
for i = 0, 1 do
	local name = "vcm-ddm-threat-" .. i
	create_text(name, "X", 5, "CenterCenter", nil, nil, {{"vcm_ddm_threat", i, 12.0}} )
	create_symbol(name.."-lo", "vcm-lobar", 1.0, nil, name, {{"vcm_ddm_threat_el", i, 0}})
	create_symbol(name.."-hi", "vcm-hibar", 1.0, nil, name, {{"vcm_ddm_threat_el", i, 1}})
end
