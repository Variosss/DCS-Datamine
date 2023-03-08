dofile(LockOn_Options.common_script_path.."elements_defs.lua")

maxDisplayedEmitters = 15

-- see 'use_mipfilter' in symbology_defs.lua
mip_filter_used	= true

Radius    = GetScale() -- half_width
Radius    = Radius * 0.0158
Diameter  = 2 * Radius
SetCustomScale(Diameter)

function AddCenterOrigin()
	CenterOrigin			= CreateElement "ceSimple"
	CenterOrigin.name		= "CenterOrigin"
	CenterOrigin.init_pos	= {0.0, -0.0015 / Diameter, 0}
	Add(CenterOrigin)
end 

AddCenterOrigin()

function SetCenterOrigin(object)
	object.parent_element =  "CenterOrigin"
end

stringdefs = {0.003, 0.003, 0.0, 0.0028}

TextureSize		= 512
TextureScale	= 1.0

function use_mipfilter(object)
	if mip_filter_used then
		object.use_mipfilter = true
	end
end

local function GetName(name, upScale)
    if upScale then
        return "Enlarged"..name
    end
    return name
end 

function addPlaceholder(name, pos, parent, controllers)
	local placeholder			= CreateElement "ceSimple"
	placeholder.name			= name
	pos							= pos or {0, 0}
	placeholder.init_pos		= {pos[1], pos[2], 0}
	if parent ~= nil then
		placeholder.parent_element	= parent
	end	
	if controllers ~= nil then
		placeholder.controllers		= controllers
	end
	Add(placeholder)
	return placeholder
end

function AddText(Name, Xpos, Ypos, Controllers, Value)
	local txt			= CreateElement "ceStringPoly"
	txt.name			= Name
	txt.material		= "font_RWR"
	txt.stringdefs		= stringdefs
	txt.alignment		= "CenterCenter"
	txt.init_pos		= {Xpos, -Ypos, 0.0}
	
	if Controllers ~= nil then
		txt.controllers	= Controllers
	end
	
	if Value ~= nil then
		txt.value		= Value
	end
	
	SetCenterOrigin(txt)
	use_mipfilter(txt)
	Add(txt)
end

function AddThreatPlacer(Number, Controllers)
	local placer		= CreateElement "ceSimple"
	placer.name			= "ThreatPlacer" .. string.format("%d", Number)
	
	if Controllers ~= nil then
		placer.controllers	= Controllers
	end
	
	SetCenterOrigin(placer)
	Add(placer)
end

function AddThreatSymbol(Number, Controllers, upScale)
	local txt			= CreateElement "ceStringPoly"
	txt.name			= GetName("ThreatSymbol" .. string.format("%d", Number), upScale)
	txt.material		= "font_RWR"
	txt.stringdefs		= stringdefs
	txt.alignment		= "CenterCenter"
	
	if upScale == true then
		fontScaleX = stringdefs[1] * 1.5
		fontScaleY = stringdefs[2] * 1.5
		txt.stringdefs		= {fontScaleX, fontScaleY, 0.0, 0.0028}
	end
		
	if Controllers ~= nil then
		txt.controllers	= Controllers
	end
	
	txt.parent_element =  "ThreatPlacer" .. string.format("%d", Number)
	use_mipfilter(txt)
	Add(txt)
end

function AddAirborneSymbol(Number, Controllers, upScale)
	local symbol		= CreateElement "ceTexPoly"
	symbol.name			= GetName("AirborneSymbol" .. string.format("%d", Number), upScale)
	symbol.material		= "INDICATION_RWR"
	
	symbol.init_pos		= {0.0, 0.09, 0}
	if upScale == true then
		symbol.init_pos		= {0.0, 0.12, 0}
	end
	
	symbol.vertices		= {{-0.08, -0.06}, {-0.08, 0.02}, {0.08, 0.02}, {0.08, -0.06}}	
	symbol.indices		= default_box_indices
	symbol.tex_params	= {309.5 / TextureSize, 20.9 / TextureSize, TextureScale, TextureScale}
	--symbol.tex_params	= {5.46 / TextureSize, 0.37 / TextureSize, TextureScale, TextureScale}
	if Controllers ~= nil then
		symbol.controllers	= Controllers
	end
	
	symbol.parent_element =  "ThreatPlacer" .. string.format("%d", Number)
	use_mipfilter(symbol)
	Add(symbol)
	
	--[[
	-- DEBUG PURPOSES
	AddDbgBox("AirborneSymbol" .. string.format("%d", Number) .. "_DbgBox",
		{symbol.name}, Controllers, 
		"ThreatPlacer" .. string.format("%d", Number), {0.0, 0.12, 0})
	--]]
end

function AddEWR_Symbol(Number, Controllers, upScale)
	local symbol		= CreateElement "ceTexPoly"
	symbol.name			= GetName("EWR_Symbol" .. string.format("%d", Number), upScale)
	symbol.material		= "INDICATION_RWR"
	
	local side = 0.100 * 1.1
	
	local IncreaseScale = 0.9
	if upScale == true then
		IncreaseScale = 0.6
		side = 0.100 * 1.3
	end
	
	symbol.vertices		= {{-side, -side}, {-side, side}, {side, side}, {side, -side}}	
	symbol.indices		= default_box_indices
	symbol.tex_params	= {475.0 / TextureSize, 72.0 / TextureSize, TextureScale * IncreaseScale, TextureScale * IncreaseScale}
--	symbol.tex_params	= {2.26 / TextureSize, 2.12 / TextureSize, TextureScale, TextureScale}
		
	if Controllers ~= nil then
		symbol.controllers	= Controllers
	end
	
	symbol.parent_element =  "ThreatPlacer" .. string.format("%d", Number)
	use_mipfilter(symbol)
	Add(symbol)
end

function AddBoxThreatSymbol(Number, Controllers, upScale)
	local symbol		= CreateElement "ceTexPoly"
	symbol.name			= GetName("BoxThreatSymbol" .. string.format("%d", Number), upScale)
	symbol.material		= "INDICATION_RWR"
	local side = 0.237 * 0.6
	
	local IncreaseScale = 1.4
	if upScale == true then
		IncreaseScale = 1.1
		side = 0.237 * 0.9
	end
	
	symbol.vertices		= {{-side, -side}, {-side, side}, {side, side}, {side, -side}}	
	symbol.indices		= default_box_indices
	symbol.tex_params	= {128.1 / TextureSize, 374.0 / TextureSize, TextureScale * IncreaseScale, TextureScale * IncreaseScale}
--	symbol.tex_params	= {2.26 / TextureSize, 2.12 / TextureSize, TextureScale, TextureScale}
		
	if Controllers ~= nil then
		symbol.controllers	= Controllers
	end
	
	symbol.parent_element =  "ThreatPlacer" .. string.format("%d", Number)
	use_mipfilter(symbol)
	Add(symbol)
end

function AddPrimaryThreatSymbol(Number, Controllers, upScale)
	local symbol		= CreateElement "ceTexPoly"
	symbol.name			= GetName("PrimaryThreatSymbol" .. string.format("%d", Number), upScale)
	symbol.material		= "INDICATION_RWR"
	local side = 0.237 * 1.1
	
	local IncreaseScale = 0.9
	if upScale == true then
		IncreaseScale = 0.7
		side = 0.237 * 1.3
	end
	
	symbol.vertices		= {{-side, -side}, {-side, side}, {side, side}, {side, -side}}	
	symbol.indices		= default_box_indices
	symbol.tex_params	= {128.1 / TextureSize, 120.2 / TextureSize, TextureScale * IncreaseScale, TextureScale * IncreaseScale}
--	symbol.tex_params	= {2.26 / TextureSize, 2.12 / TextureSize, TextureScale, TextureScale}
		
	if Controllers ~= nil then
		symbol.controllers	= Controllers
	end
	
	symbol.parent_element =  "ThreatPlacer" .. string.format("%d", Number)
	use_mipfilter(symbol)
	Add(symbol)
	
	--[[
	-- DEBUG PURPOSES
	AddDbgBox("PrimaryThreatSymbol" .. string.format("%d", Number) .. "_DbgBox",
		{symbol.name}, Controllers, 
		"ThreatPlacer" .. string.format("%d", Number), {0.0, 0.0, 0})
	--]]
end

function AddCircle(Number, Name, Controllers, ParentName, upScale)

	local Circle		  = CreateElement "ceTexPoly"
	Circle.name			  = Name
	Circle.material		  = "INDICATION_RWR"
	Circle.indices		  = default_box_indices
	
	local side = 0.245 * 0.7
	local IncreaseScale = 1.4
	if upScale == true then
		IncreaseScale = 1.1
		side = 0.245 * 0.9
	end
	
	Circle.vertices		  = {{-side, -side}, {-side, side}, {side, side}, {side, -side}}	
	Circle.tex_params	  = {385 / TextureSize, 388.4 / TextureSize, TextureScale * IncreaseScale, TextureScale * IncreaseScale}
	Circle.parent_element = ParentName
	
	if Controllers ~= nil then
		Circle.controllers	= Controllers
	end
	
	use_mipfilter(Circle)
	Add(Circle)
end

function AddLaunchSymbol(Number, Controllers, upScale)
	local Name = GetName("LaunchSymbol" .. string.format("%d", Number), upScale)
		
	AddCircle(Number, Name, Controllers, "ThreatPlacer" .. Number, upScale)
end

local pos = 0.2
function AddNoiseBar(Number, Parent, Controllers)
	local NoiseBar  	    = CreateElement "ceTexPoly"
	NoiseBar.name			= "NoiseBar" .. string.format("%d", Number)
	NoiseBar.material		= "INDICATION_RWR"
	
	local sideX = 7/512
	local sideY = 56/512
    if Number == 0 then
	 NoiseBar.init_pos		= {0.0, -pos, 0}
	 NoiseBar.init_rot      = {180.0, 0.0 , 0.0}
	end
	
    if Number == 2 then
	 NoiseBar.init_pos		= {0.0, pos, 0}
	 NoiseBar.init_rot      = {0.0, 0.0 , 0.0}
	end

    if Number == 1 then
	 NoiseBar.init_pos		= {-pos, 0.0, 0}
	 NoiseBar.init_rot      = {90.0, 0.0 , 0.0}
	end

	NoiseBar.vertices		= {{-sideX, -sideY}, {-sideX, 0}, {sideX, 0}, {sideX, -sideY}}
	NoiseBar.indices		= default_box_indices
	NoiseBar.tex_params	    = {334 / TextureSize, 132 / TextureSize, TextureScale, TextureScale}
	
	if Parent ~= nil then
		NoiseBar.parent_element	= Parent
	end	
	
	if Controllers ~= nil then
		NoiseBar.controllers	= Controllers
	end
	
	use_mipfilter(NoiseBar)
	Add(NoiseBar)
end

function AddNoiseStatus(Number, Controllers)
	local NoiseBar  	    = CreateElement "ceTexPoly"
	NoiseBar.name			= "NoiseStatus" .. string.format("%d", Number)
	NoiseBar.material		= "INDICATION_RWR"
	
	local sideX = 12.5/512
	local sideY = 54/512

	if Number == 0 then	
     NoiseBar.init_pos		= {pos, -0.01, 0}
	end
	if Number == 1 then	
     NoiseBar.init_pos		= {pos, 0.01, 0}
	end
	
	NoiseBar.init_rot      = {270.0, 0.0 , 0.0}
	
	NoiseBar.vertices		= {{-sideX, 0}, {-sideX, -sideY}, {sideX, -sideY}, {sideX, 0}}		
	NoiseBar.indices		= default_box_indices
	if Number == 0 then
	 NoiseBar.tex_params	    = {376.5 / TextureSize, 132 / TextureSize, TextureScale, TextureScale}
	end

	if Number == 1 then
	 NoiseBar.tex_params	    = {412.5 / TextureSize, 132 / TextureSize, TextureScale, TextureScale}
	end
		
	if Controllers ~= nil then
		NoiseBar.controllers	= Controllers
	end
	
	use_mipfilter(NoiseBar)
	Add(NoiseBar)
end

function AddPoint(Controllers)
	local CentralPoint  	    = CreateElement "ceTexPoly"
	CentralPoint.name			= "CentralPoint"
	CentralPoint.material		= "INDICATION_RWR"
	
	local side = 0.025*2.0

    CentralPoint.init_pos		= {0.0, 0.0, 0}
		
	CentralPoint.vertices		= {{-side, -side}, {-side, side}, {side, side}, {side, -side}}		
	CentralPoint.indices		= default_box_indices
    CentralPoint.tex_params	    = {385 / TextureSize, 31.8 / TextureSize, TextureScale/2.0, TextureScale/2.0}
		
	if Controllers ~= nil then
		CentralPoint.controllers	= Controllers
	end
	
	use_mipfilter(CentralPoint)
	Add(CentralPoint)
end

function AddTestSquareSymbol(Number, Controllers)
	local symbol			= CreateElement "ceTexPoly"
	symbol.name				= "TestSquareSymbol" .. string.format("%d", Number)
	symbol.material			= "INDICATION_RWR_LINE"
	local side = 0.43
	local line_width		= (4.5/512)
	symbol.vertices			= {	{-side,	-line_width},
								{-side,	line_width},
								{side,	line_width},
								{side,	-line_width}}
	symbol.indices			= default_box_indices
	symbol.init_pos     	= {math.sin(0.5*math.pi*Number)*side, math.cos(0.5*math.pi*Number)*side, 0.0}
	symbol.init_rot     	= {90*Number, 0.0 , 0.0}
	symbol.tex_params		= {256/512,176.5/512,TextureScale/2.0,TextureScale/2.0}
	if Controllers ~= nil then
		symbol.controllers	= Controllers
	end

	use_mipfilter(symbol)
	Add(symbol)	
end
