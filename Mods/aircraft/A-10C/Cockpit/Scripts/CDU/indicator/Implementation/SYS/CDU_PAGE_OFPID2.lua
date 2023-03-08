dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameOFPID2",   2, 1, LFT, "OFPID")

AddStaticText("OFPID2_LINE3",     2, 3, LFT, "EGI")
AddStaticText("OFPID2_LINE4_1",   2, 4, LFT, "A10P 4")
AddStaticText("OFPID2_LINE4_2",   16,4, LFT, "D4CF")
AddStaticText("OFPID2_LINE5",     2, 5, LFT, "EGI GEM")
AddStaticText("OFPID2_LINE6_1",   2, 6, LFT, "00=017")
AddStaticText("OFPID2_LINE6_2",   16,6, LFT, "6C6C")
AddStaticText("OFPID2_LINE7",     2, 7, LFT, "DTSAS")
AddStaticText("OFPID2_LINE8",     2, 8, LFT, "011F")

AddStaticText("PAGE_NUMBER", 19 + PageNumNorOffset, 10, LFT, "P2/2")

--[[
AddStaticText("OFPID2_LINE6_1",   1, 1, LFT,  "123456123456123456123456")
AddStaticText("OFPID2_LINE6_1",   1, 3, LFT,  "->000000000")
AddStaticText("OFPID2_LINE6_1",   1, 4, LFT,  "123456123456123456123456")
AddStaticText("OFPID2_LINE6_1",   24, 4, RGHT,"123456123456123456123456")
AddStaticText("OFPID2_LINE6_1",   1, 7, LFT,  "->000000000")
AddStaticText("OFPID2_LINE6_1",   1, 9, LFT,  "->000000000")
AddStaticText("OFPID2_LINE6_1",   1,10, LFT,  "123456123456123456123456")

function AddGrid(delta_pixel_x,delta_pixel_y,rows,cols)
	local rows          = rows or 570/delta_pixel_y
	local cols          = cols or 570/delta_pixel_x
	
	local sz_x          = cols * delta_pixel_x
	local sz_y          = rows * delta_pixel_y
	
	local dx = 0.1
	local dy = 0.05---0.3
	
	local verts       = {{-sz_x/2 + dx, -sz_y/2 + dy},
						 {sz_x/2 +dx,   -sz_y/2 + dy},
						 {sz_x/2 + dx, sz_y/2 + dy},
						 {-sz_x/2 + dx, sz_y/2 + dy}}
	local indices     = {0,1,2,2,3,0}
	
	
	local lines       = sz_y / delta_pixel_y
	
	for j = 1,cols do
		verts[#verts + 1] =  {delta_pixel_x*(j-cols/2) +dx ,   -sz_y/2 + dy}	indices[#indices + 1] = #verts - 1	
		verts[#verts + 1] =  {delta_pixel_x*(j-cols/2) +dx, sz_y/2 + dy}	indices[#indices + 1] = #verts - 1
	end
	for i = 1,rows do
		verts[#verts + 1] =  {-sz_x/2 + dx, delta_pixel_y*(i-rows/2) + dy}		indices[#indices + 1] = #verts - 1	
		verts[#verts + 1] =  {sz_x/2 + dx, delta_pixel_y*(i-rows/2) +dy}		indices[#indices + 1] = #verts - 1
	end

	material			= "INDICATION_COMMON_RED"
	grid			    = CreateElement "ceMeshPoly"
	grid.material	    = material
	grid.primitivetype  = "lines"	
	grid.vertices       = verts
	grid.indices	    = indices
	Add(grid)
	return grid
end

AddGrid(1.0,1.60,10,24)
       --dx, dy
--]]