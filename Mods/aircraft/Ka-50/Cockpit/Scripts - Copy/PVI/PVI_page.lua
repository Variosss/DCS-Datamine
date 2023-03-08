dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetScale(FOV) -- set scale factor modifier (in this case FOV - half of horizontal size)

--[[
  SetScale(MILLYRADIANS)
	next elements will be scaled in millyrads
  SetScale(METERS)
        next elements will be scaled in meters
  SetScale(FOV)
        and again in FOV parts
--]]

local SYMBOL_WIDTH    = 0.0075
local SYMBOL_HEIGHT   = 0.012
local FONT_SYMBOL_W_K = 0.8203125
local FONT_SYMBOL_H_K = 1.015625
local SPACING		  = 0.00278

local SIGN_POS        = -0.956803
local OIT_POS         = 0.78
local DIGIT_SIZE      = (SYMBOL_WIDTH + SPACING)/GetScale()
local SYMBOL_OFFSET   =  0.25 * SYMBOL_WIDTH/GetScale()
local INIT_POS        = -0.675 + SYMBOL_OFFSET
local APOSTROPH_1 	  = 2.3
local APOSTROPH_2     = 4.3


local VIT_pnt_pos = {INIT_POS ,   0.22}
local NIT_pnt_pos = {INIT_POS ,  -0.185}

local function VIT_pos(symbols)
	return  {VIT_pnt_pos[1] + (symbols or 0) * DIGIT_SIZE ,VIT_pnt_pos[2]}  
end

local function NIT_pos(symbols)
	return  {NIT_pnt_pos[1] + (symbols or 0) * DIGIT_SIZE ,NIT_pnt_pos[2]}  
end


base					= CreateElement "ceSimple"
base.controllers 		= {{"power"}}
Add(base)

local function MakeStringPoly(name)
local txt			= CreateElement "ceStringPoly"
	if name then
		txt.name       		= name
	end
	txt.material   		= "font_PVI"
	txt.alignment  		= "LeftCenter"
	txt.stringdefs 		= {SYMBOL_HEIGHT / FONT_SYMBOL_H_K , SYMBOL_WIDTH / FONT_SYMBOL_W_K,SPACING, 0.0}
	txt.parent_element  = base.name
	Add(txt)
	return txt
end


-----------------------------------------------------------------------

txt_VIT_sign					= MakeStringPoly("txt_VIT_sign")
txt_VIT_sign.init_pos			= {SIGN_POS,VIT_pnt_pos[2]}
txt_VIT_sign.value				= "-"
txt_VIT_sign.controllers 		= {{"VIT_sign"}}

txt_VIT							= MakeStringPoly("txt_VIT")
txt_VIT.init_pos				= VIT_pos()
txt_VIT.controllers				= {{"VIT"}}

txt_VIT_apostrophe1				= MakeStringPoly("txt_VIT_apostrophe1")
txt_VIT_apostrophe1.init_pos	= VIT_pos(APOSTROPH_1)
txt_VIT_apostrophe1.value		= "'"
txt_VIT_apostrophe1.controllers	= {{"VIT_apostrophe1"}}

txt_VIT_apostrophe2				= MakeStringPoly("txt_VIT_apostrophe2")
txt_VIT_apostrophe2.init_pos	= VIT_pos(APOSTROPH_2)
txt_VIT_apostrophe2.value		= "'"
txt_VIT_apostrophe2.controllers	= {{"VIT_apostrophe2"}}
----------------------------------------------------------------------
txt_OIT_PPM						= MakeStringPoly("txt_OIT_PPM")
txt_OIT_PPM.init_pos			= {OIT_POS,VIT_pnt_pos[2]}
txt_OIT_PPM.formats				= {"%1u"}
txt_OIT_PPM.controllers			= {{"OIT_PPM", 0}}
----------------------------------------------------------------------
txt_NIT_sign					= MakeStringPoly("txt_NIT_sign")
txt_NIT_sign.init_pos			= {SIGN_POS,NIT_pnt_pos[2]}
txt_NIT_sign.value				= "-"
txt_NIT_sign.controllers 		= {{"NIT_sign"}}

txt_NIT							= MakeStringPoly("txt_NIT")
txt_NIT.init_pos				= NIT_pos()
txt_NIT.controllers				= {{"NIT"}}

txt_NIT_apostrophe1				= MakeStringPoly("txt_NIT_apostrophe1")
txt_NIT_apostrophe1.init_pos	= NIT_pos(APOSTROPH_1)
txt_NIT_apostrophe1.value		= "'"
txt_NIT_apostrophe1.controllers	= {{"NIT_apostrophe1"}}

txt_NIT_apostrophe2				= MakeStringPoly("txt_NIT_apostrophe2")
txt_NIT_apostrophe2.init_pos	= NIT_pos(APOSTROPH_2)
txt_NIT_apostrophe2.value		= "'"
txt_NIT_apostrophe2.controllers = {{"NIT_apostrophe2"}}
-------------------------------------------------------------------------
txt_OIT_NOT						= MakeStringPoly("txt_OIT_NOT")
txt_OIT_NOT.init_pos			= {OIT_POS,NIT_pnt_pos[2]}
txt_OIT_NOT.formats				= {"%1u"}
txt_OIT_NOT.controllers			= {{"OIT_NOT", 0}}
----------------------------------------------------------------------

-- local function SymbolsGrid(init_pos )
	-- local grid					= CreateElement "ceMeshPoly"
	-- grid.material				= MakeMaterial("",{100,0,100,255})
	-- grid.primitivetype 			= "lines"

	-- local szy = 0.25
	-- local verts  = {}
	-- local inds   = {}

	-- for i = 0,6 do
		-- verts[#verts + 1] = {i * DIGIT_SIZE,-0.5*szy}
		-- verts[#verts + 1] = {i * DIGIT_SIZE, 0.5*szy}
		-- inds[#inds + 1]   = #verts - 2
		-- inds[#inds + 1]   = #verts - 1
	-- end


	-- grid.vertices 		  = verts
	-- grid.indices	 	  = inds
	-- grid.init_pos 	      = init_pos or VIT_pos()
	-- grid.parent_element   = base.name
	-- Add(grid)
-- end

-- txt_VIT_test					= MakeStringPoly("txt_VIT_test")
-- txt_VIT_test.init_pos 			= VIT_pos()
-- txt_VIT_test.value				= "888888"
-- txt_VIT_test.UseBackground		= true
-- txt_VIT_test.BackgroundMaterial = MakeMaterial("",{0,100,100,255})

-- apostrophe1						= MakeStringPoly()
-- apostrophe1.init_pos			= VIT_pos(APOSTROPH_1)
-- apostrophe1.value				= "'"

-- apostrophe2						= MakeStringPoly()
-- apostrophe2.init_pos			= VIT_pos(APOSTROPH_2)
-- apostrophe2.value				= "'"

-- SymbolsGrid({INIT_POS - SYMBOL_OFFSET,0.2})

