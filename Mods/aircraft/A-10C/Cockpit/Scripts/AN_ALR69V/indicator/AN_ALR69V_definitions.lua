dofile(LockOn_Options.common_script_path.."elements_defs.lua")

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

stringdefs = {0.004, 0.004, 0.0, 0.0028}

TextureSize		= 9.03
TextureScale	= 1.0

function use_mipfilter(object)
	if mip_filter_used then
		object.use_mipfilter = true
	end
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

function AddThreatSymbol(Number, Controllers)
	local txt			= CreateElement "ceStringPoly"
	txt.name			= "ThreatSymbol" .. string.format("%d", Number)
	txt.material		= "font_RWR"
	txt.stringdefs		= stringdefs
	txt.alignment		= "CenterCenter"
		
	if Controllers ~= nil then
		txt.controllers	= Controllers
	end
	
	txt.parent_element =  "ThreatPlacer" .. string.format("%d", Number)
	use_mipfilter(txt)
	Add(txt)
end

function AddDbgBox(Name, GeometryHosts, Controllers, Parent, InitPos)
	local DbgBox  				= CreateElement "ceBoundingMeshBox"
	DbgBox.name 				= Name
	DbgBox.init_pos				= InitPos
	DbgBox.primitivetype		= "lines"
	DbgBox.material	   			= "INDICATION_COMMON_BLACK"
	DbgBox.controllers			= Controllers
	DbgBox.geometry_hosts		= GeometryHosts
	DbgBox.parent_element		= Parent
	Add(DbgBox)
	return DbgBox
end

function AddAirborneSymbol(Number, Controllers)
	local symbol		= CreateElement "ceTexPoly"
	symbol.name			= "AirborneSymbol" .. string.format("%d", Number)
	symbol.material		= "INDICATION_RWR"
	symbol.init_pos		= {0.0, 0.12, 0}
	symbol.vertices		= {{-0.08, -0.06}, {-0.08, 0.02}, {0.08, 0.02}, {0.08, -0.06}}	
	symbol.indices		= default_box_indices
	symbol.tex_params	= {5.46 / TextureSize, 0.37 / TextureSize, TextureScale, TextureScale}
		
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

function AddPrimaryThreatSymbol(Number, Controllers)
	local symbol		= CreateElement "ceTexPoly"
	symbol.name			= "PrimaryThreatSymbol" .. string.format("%d", Number)
	symbol.material		= "INDICATION_RWR"
	local side = 0.237
	symbol.vertices		= {{-side, -side}, {-side, side}, {side, side}, {side, -side}}	
	symbol.indices		= default_box_indices
	symbol.tex_params	= {2.26 / TextureSize, 2.12 / TextureSize, TextureScale, TextureScale}
		
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

function AddNewGuySymbol(Number, Controllers)
	local symbol		= CreateElement "ceTexPoly"
	symbol.name			= "NewGuySymbol" .. string.format("%d", Number)
	symbol.material		= "INDICATION_RWR"
	local side = 0.245
	symbol.vertices		= {{-side, -side}, {-side, side}, {side, side}, {side, -side}}	
	symbol.indices		= default_box_indices
	symbol.tex_params	= {2.26 / TextureSize, 6.42 / TextureSize, TextureScale, TextureScale}
		
	if Controllers ~= nil then
		symbol.controllers	= Controllers
	end
	
	symbol.parent_element =  "ThreatPlacer" .. string.format("%d", Number)
	use_mipfilter(symbol)
	Add(symbol)
	
	--[[
	-- DEBUG PURPOSES
	AddDbgBox("NewGuySymbol" .. string.format("%d", Number) .. "_DbgBox",
		{symbol.name}, Controllers, 
		"ThreatPlacer" .. string.format("%d", Number), {0.0, 0.0, 0})
	--]]
end


function AddCircle(Number, Name, Controllers, ParentName)
	local side = 0.245
	local Circle		  = CreateElement "ceTexPoly"
	Circle.name			  = Name
	Circle.material		  = "INDICATION_RWR"
	Circle.vertices		  = {{-side, -side}, {-side, side}, {side, side}, {side, -side}}	
	Circle.indices		  = default_box_indices
	Circle.tex_params	  = {6.79 / TextureSize, 6.85 / TextureSize, TextureScale, TextureScale}
	Circle.parent_element = ParentName
	
	if Controllers ~= nil then
		Circle.controllers	= Controllers
	end
	
	use_mipfilter(Circle)
	Add(Circle)
end

function AddLaunchSymbol(Number, Controllers)
	AddCircle(Number, "LaunchSymbol" .. Number, Controllers, "ThreatPlacer" .. Number)
end

function AddMWS_Symbol(Number, Controllers)
	local MWS_Symbol        = CreateElement "ceStringPoly"
	MWS_Symbol.name			= "MWS_MissileSymbol" .. Number
	MWS_Symbol.controllers	= Controllers
	MWS_Symbol.material		= "font_RWR"
	MWS_Symbol.stringdefs	= stringdefs
	MWS_Symbol.alignment	= "CenterCenter"
	SetCenterOrigin(MWS_Symbol)
	use_mipfilter(MWS_Symbol)
	Add(MWS_Symbol)
	
	AddCircle(Number, "MWS_SymbolCircle" .. Number, nil, MWS_Symbol.name)
end

function AddNoiseBar(Number, Controllers)
	local NoiseBar  	    = CreateElement "ceTexPoly"
	NoiseBar.name			= "NoiseBar" .. string.format("%d", Number)
	NoiseBar.material		= "INDICATION_RWR"
	
	local kx = 0.75
	local side = 0.055
    if Number == 0 then
	 NoiseBar.init_pos		= {0.0, -0.11, 0}
	 NoiseBar.init_rot      = {180.0, 0.0 , 0.0}
	end
	
    if Number == 2 then
	 NoiseBar.init_pos		= {0.0, 0.11, 0}
	 NoiseBar.init_rot      = {0.0, 0.0 , 0.0}
	end

    if Number == 1 then
	 NoiseBar.init_pos		= {-0.11, 0.0, 0}
	 NoiseBar.init_rot      = {90.0, 0.0 , 0.0}
	end
	
	NoiseBar.vertices		= {{-side * kx, -side}, {-side * kx, side}, {side * kx, side}, {side * kx, -side}}		
	NoiseBar.indices		= default_box_indices
	NoiseBar.tex_params	    = {5.9 / TextureSize, 3.0 / TextureSize, TextureScale, TextureScale}
		
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
	
	local side = 0.045

	if Number == 0 then	
     NoiseBar.init_pos		= {0.11, -0.02, 0}
	end
	if Number == 1 then	
     NoiseBar.init_pos		= {0.11, 0.00, 0}
	end
	
	NoiseBar.init_rot      = {270.0, 0.0 , 0.0}
	
	NoiseBar.vertices		= {{-side, -side}, {-side, side}, {side, side}, {side, -side}}		
	NoiseBar.indices		= default_box_indices
	if Number == 0 then
	 NoiseBar.tex_params	    = {6.65 / TextureSize, 3.0 / TextureSize, TextureScale, TextureScale}
	end

	if Number == 1 then
	 NoiseBar.tex_params	    = {7.4 / TextureSize, 3.0 / TextureSize, TextureScale, TextureScale}
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
	
	local side = 0.025

    CentralPoint.init_pos		= {0.0, 0.0, 0}
		
	CentralPoint.vertices		= {{-side, -side}, {-side, side}, {side, side}, {side, -side}}		
	CentralPoint.indices		= default_box_indices
    CentralPoint.tex_params	    = {6.75 / TextureSize, 0.5 / TextureSize, TextureScale, TextureScale}
		
	if Controllers ~= nil then
		CentralPoint.controllers	= Controllers
	end
	
	use_mipfilter(CentralPoint)
	Add(CentralPoint)
end
