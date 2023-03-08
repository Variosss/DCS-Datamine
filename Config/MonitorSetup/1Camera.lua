_  = function(p) return p; end;
name = _('1 Screen');
Description = 'One monitor configuration'
Viewports =
{
     Center =
     {
          x = 0;
          y = 0;
          width = screen.width;
          height = screen.height;
          viewDx = 0;
          viewDy = 0;
          aspect = screen.aspect;
     }
}
GU_MAIN_VIEWPORT = Viewports.Center