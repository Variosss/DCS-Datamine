dofile(LockOn_Options.common_script_path.."elements_defs.lua")
SetCustomScale(1.0)

local MATERIAL_ = MakeMaterial("Indication_Padlock.tga",{255,0,0,255})

function texture_box(UL_X,UL_Y,W,H,C_X,C_Y)
	local texture_k  = 1/128
	local geometry_k = 1.0/LockOn_Options.screen.height
	
	local  CX = C_X
	local  CY = C_Y
	if CX == nil then
	   CX = UL_X + W * 0.5
	end
	if CY == nil then
	   CY = UL_Y + H * 0.5
	end

	local x_min = (UL_X     - CX)   * geometry_k
	local x_max = (UL_X + W - CX)   * geometry_k
	local y_max = (CY   - UL_Y)		* geometry_k
	local y_min = (CY   - UL_Y - H) * geometry_k

	local v = {{x_min , y_max},
			   {x_max , y_max},
			   {x_max , y_min},
			   {x_min , y_min}}
	local t = {{UL_X 	 * texture_k, UL_Y      * texture_k},
			  {(UL_X + W)* texture_k, UL_Y      * texture_k},
			  {(UL_X + W)* texture_k,(UL_Y + H) * texture_k},
			  { UL_X     * texture_k,(UL_Y + H) * texture_k}}
			  
	local element = CreateElement "ceTexPoly"  
	element.material   = MATERIAL_
	element.vertices   = v
	element.tex_coords = t
	element.indices    = default_box_indices
	element.additive_alpha = true
	element.screenspace = ScreenType.SCREENSPACE_TRUE
    element.use_mipfilter = true
	Add(element)
	
--[[
	local element2 = CreateElement "ceMeshPoly"  
	element2.material   = MakeMaterial(nil,{0,255,0,255})
	element2.primitivetype = "lines"
	element2.vertices   = {{x_min , y_max},
						   {x_max , y_max},
						   {x_max , y_min},
						   {x_min , y_min},
						   {x_min , 0},
						   {x_max , 0},
						   {0 , y_min},
						   {0 , y_max},
						   }
	element2.indices    = {0,1,1,2,2,3,3,0,4,5,6,7}
	element2.screenspace = ScreenType.SCREENSPACE_TRUE
	element2.parent_element = element.name
	element2.use_mipfilter = true
	Add(element2)
--]]

	return element
end

-------------------------------------------------------------------
--flag             = texture_box(0,0,51,65,16,49)
--flag.controllers = {{"padlock_mode",1},{"padlock_point",4}}
-------------------------------------------------------------------
object             = texture_box(58,0,70,70)
object.controllers = {{"padlock_mode",1,2},{"padlock_point",4}}
-------------------------------------------------------------------
