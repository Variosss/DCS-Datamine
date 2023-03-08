-- don't forget to correct \Projects\Frogfoot\source\View\AwacsCameraWidget\IF10ViewLayer\UnitsLayer\UnitsLayerUserDrawObjects.cpp
-- in case of table format changes
if not _ then
	_ = function(str) return str end
end

lineStyles = {
	{name = _('Solid'	), style = 'solid'		, file = './MissionEditor/data/NewMap/images/draw/polyline_solid.png'	},
	{name = _('Solid 2'	), style = 'solid2'		, file = './MissionEditor/data/NewMap/images/draw/polyline_Solid2.png'	},
	{name = _('Dot'		), style = 'dot'		, file = './MissionEditor/data/NewMap/images/draw/polyline_dotted2.png'	},
	{name = _('Dot 2'		), style = 'dot2'		, file = './MissionEditor/data/NewMap/images/draw/polyline_DoubleDotted.png'	},
	{name = _('Dot Dash'		), style = 'dotdash'		, file = './MissionEditor/data/NewMap/images/draw/polyline_DotDash.png'	},
	{name = _('Dash'	), style = 'dash'		, file = './MissionEditor/data/NewMap/images/draw/polyline_dash2.png'	},
	{name = _('Cross'	), style = 'cross'		, file = './MissionEditor/data/NewMap/images/draw/polyline_cross2.png'	},
	{name = _('Square'	), style = 'square'		, file = './MissionEditor/data/NewMap/images/draw/polyline_square2.png'	},
	{name = _('Strong Point'	), style = 'strongpoint'	, file = './MissionEditor/data/NewMap/images/draw/polyline_StrongPoint.png'	},
	{name = _('Triangle'), style = 'triangle'	, file = './MissionEditor/data/NewMap/images/draw/polyline_triangle2.png'},
	{name = _('Wire Fence'), style = 'wirefence'	, file = './MissionEditor/data/NewMap/images/draw/polyline_wirefence.png'},
	{name = _('Boundry 1'), style = 'boundry1'	, file = './MissionEditor/data/NewMap/images/draw/polyline_Bound1.png'},
	{name = _('Boundry 2'), style = 'boundry2'	, file = './MissionEditor/data/NewMap/images/draw/polyline_Bound2.png'},
	{name = _('Boundry 3'), style = 'boundry3'	, file = './MissionEditor/data/NewMap/images/draw/polyline_Bound3.png'},
	{name = _('Boundry 4'), style = 'boundry4'	, file = './MissionEditor/data/NewMap/images/draw/polyline_Bound4.png'},
	{name = _('Boundry 5'), style = 'boundry5'	, file = './MissionEditor/data/NewMap/images/draw/polyline_Bound5.png'},
}

