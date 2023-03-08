
local function add_cargo(f)
	if(f) then
		f.shape_table_data = 
		{
			{
				file  	    = f.ShapeName,
				life		= f.Life,
				username    = f.Name,
				desrt       = f.ShapeNameDestr or "self",
			    --classname 	= f.classname   or "lLandVehicle",
				positioning = f.positioning or "ONLYHEIGTH"	--available: {"BYNORMAL", "ONLYHEIGTH", "BY_XZ", "ADD_HEIGTH"}
			}
		}
		if f.ShapeNameDestr then
			f.shape_table_data[#f.shape_table_data + 1] = 
			{
				name  = f.ShapeName,
				file  = f.ShapeNameDestr,	
			}
		end
		
		
		f.mapclasskey 	= "P0091000352";
		f.attribute 		= {"Cargos"}; 
		f.category 		= 'Cargo';
		
		add_surface_unit(f)
	
	else
		error("Can't add cargo")
	end;
end





add_cargo({
Name 		 	=  "L118",
DisplayName  	=  _("L118 Light Artillery Gun"),
ShapeName	 	=   "L118",
Life		 	 	= -1,
Rate		 	=  100,
desrt		 	= "self",
canExplode		= false,
mass			= 1260,
minMass		= 800,
maxMass		= 3500,
couldCargo		= false,
topdown_view 	=  topdown_view,
})