_  = function(p) return p; end;
name 		= _('Camera + LMFCD automatic placement');
Description = 'Camera on primary display and Left MFCD on secondary'

if  displays and #displays > 1 then 
	primary = 
	{	
		x 		= displays[1].x - screen.x,
		y 		= displays[1].y - screen.y,
		width   = displays[1].width,
		height  = displays[1].height,
		aspect  = displays[1].width/displays[1].height;
		viewDx  = 0;
        viewDy  = 0;
	}
	secondary = 
	{
		x 		= displays[2].x - screen.x,
		y 		= displays[2].y - screen.y,
		width   = displays[2].width,
		height  = displays[2].height,
	}
else
	primary = 
	{	
		  x = screen.width / 2;
          y = 0;
          width  = screen.width / 2;
          height = screen.height;
          viewDx = 0;
          viewDy = 0;
          aspect = screen.aspect / 2;
	}
	secondary =
	{
		 x = 0;
		 y = 0;
		 width = screen.width / 2;
		 height = screen.height;
	}
end

UIMainView = primary
GU_MAIN_VIEWPORT = primary
LEFT_MFCD  = secondary
Viewports  = {UIMainView}