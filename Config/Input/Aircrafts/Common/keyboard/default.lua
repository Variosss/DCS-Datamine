return {

keyCommands = {
--- Kneeboard
{combos = {{key = ']'}}						   , 			down = 3001, cockpit_device_id  = 100, value_down = 1.0, name = _('Kneeboard Next Page')  , category = _('Kneeboard')},
{combos = {{key = '['}}						   , 			down = 3002, cockpit_device_id  = 100, value_down = 1.0, name = _('Kneeboard Previous Page'), category = _('Kneeboard')},
{combos = {{key = 'K', reformers = {'RShift'}}}, 			down = iCommandPlaneShowKneeboard,	name = _('Kneeboard ON/OFF'), category = _('Kneeboard')},
{combos = {{key = 'K', reformers = {'RAlt'}}}  , 			down = iCommandPlaneShowKneeboard, up = iCommandPlaneShowKneeboard ,value_down = 1.0,value_up = -1.0, name = _('Kneeboard glance view')  , category = _('Kneeboard')},
{combos = {{key = 'K', reformers = {'RCtrl'}}} , 			down = 3003	, cockpit_device_id  = 100,value_down = 1.0, name = _('Kneeboard current position mark point')  , category = _('Kneeboard')},
},
}
