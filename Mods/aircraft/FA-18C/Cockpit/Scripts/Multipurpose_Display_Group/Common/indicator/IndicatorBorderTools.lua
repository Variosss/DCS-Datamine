-- Tools for indicator border mesh handling

-- Add the second half of the convex poly mirrored about Y axis
local function addVertsMirroredAboutY(verts)
	--if #verts == 0 then do return end end
	
	local vertsSz = #verts
	for i = 0, vertsSz - 1 do
		local idx = vertsSz - i
		verts[#verts + 1] = {-(verts[idx][1]), (verts[idx][2])}
	end
end

-- Rescale verts
local function rescaleVerts(verts, scale)
	for i = 1, #verts do
		verts[i] = {verts[i][1] * scale, verts[i][2] * scale}
	end
end

function prepareBorderVerts(verts, scale)
	-- Add the second half of the border (mirrored about Y axis)
	addVertsMirroredAboutY(verts)
	-- Rescale vertices to indicator units
	rescaleVerts(verts, scale)
	-- Build indices and return them as a table
	return buildConvexPolyIndices(#verts)
end
