_  = function(p) return p; end;
name = _('Camera + RMFCD');
Description = 'Right MFCD on the right and camera on the center'
Viewports =
{
     Center =
     {
          x = 0;
          y = 0;
          width  = screen.width / 2;
          height = screen.height;
          viewDx = 0;
          viewDy = 0;
          aspect = screen.aspect / 2;
     }
}

RIGHT_MFCD =
{
     x = screen.width / 2;
     y = 0;
     width = screen.width / 2;
     height = screen.height;
}

UIMainView = Viewports.Center
GU_MAIN_VIEWPORT = Viewports.Center