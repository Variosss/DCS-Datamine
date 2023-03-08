_  = function(p) return p; end;
name = _('Stereo');
Description = 'Stereo render two viewports for left and right eye respectivelly'
Viewports = 
{
	Left = 
	{
		x = 0;
		y = 0;
		width = screen.width * 0.5;
		height = screen.height;
		viewDx = 0;
		viewDy = 0;
		aspect = screen.aspect / 2;
		eye_shift = -0.032;
		--tans of side angles
		projection_bounds = { 
			left   = 0.964925826,
			right  = 0.715263844,
			top    = 0.889498115,
			bottom = 1.11092532,
		}
	},
	Right = 
	{
		x = screen.width * 0.5;
		y = 0;
		width = screen.width * 0.5;
		height = screen.height;
		viewDx = 0;
		viewDy = 0;
		aspect = screen.aspect / 2;
		eye_shift = 0.032;
		--tans of side angles
		projection_bounds = { 
			left   = 0.715263844,
			right  = 0.964925826,
			top    = 0.889498115,
			bottom = 1.11092532,
		}
	}
}

UIMainView =  {
	x      = 0;
	y      = 0;
	width  = screen.width;
	height = screen.height;
}
GU_MAIN_VIEWPORT = UIMainView

