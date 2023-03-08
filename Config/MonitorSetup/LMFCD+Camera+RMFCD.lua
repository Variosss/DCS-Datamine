_  = function(p) return p; end;
name = _('LMFCD+Camera+RMFCD');
Description = 'Left MFCD on the left monitor,Right MFCD on the right and camera on the center'
Viewports =
{
     Center =
     {
          x = screen.width / 3;
          y = 0;
          width = screen.width / 3;
          height = screen.height;
          viewDx = 0;
          viewDy = 0;
          aspect = screen.aspect / 3;
     }
}

LEFT_MFCD =
{
     x = 0;
     y = 0;
     width = screen.width / 3;
     height = screen.height;
}

RIGHT_MFCD =
{
     x = screen.width *(2 / 3);
     y = 0;
     width = screen.width / 3;
     height = screen.height;
}

UIMainView = Viewports.Center
GU_MAIN_VIEWPORT = Viewports.Center