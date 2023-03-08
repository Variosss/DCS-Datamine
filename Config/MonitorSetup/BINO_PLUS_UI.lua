_  = function(p) return p; end;
name 		= "UI+BINOS";
Description = "UI+BINOS"

local ui = 
{	
	x 		= 0;
	y 		= 0;
	width	= screen.width / 2;
	height	= screen.height;
	viewDx	= 0;
	viewDy	= 0;
	aspect	= screen.aspect / 2;
}

local bino =
{
	x 		= screen.width / 2;
	y 		= 0;
	width	= screen.width / 2;
	height	= screen.height;
}

if  displays and #displays > 1 then 
	ui = 
	{	
		x 		= displays[1].x - screen.x,
		y 		= displays[1].y - screen.y,
		width   = displays[1].width,
		height  = displays[1].height,
		aspect  = displays[1].width/displays[1].height;
	}
	bino = 
	{
		x 		= displays[2].x - screen.x,
		y 		= displays[2].y - screen.y,
		width   = displays[2].width,
		height  = displays[2].height,
	}
end

Viewports = 
{
	{
		x 		  = bino.x;
		y 		  = bino.y;
		width 	  = bino.width;
		height 	  = bino.height;
		aspect    = bino.width / bino.height;
	},
}

UIMainView 					 = ui
GU_MAIN_VIEWPORT 			 = ui
BINOS_NOSTEREO_VIEWPORT      = bino
