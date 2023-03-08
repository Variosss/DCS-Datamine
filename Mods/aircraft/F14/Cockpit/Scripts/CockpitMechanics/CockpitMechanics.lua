Presets = {}

function AddPaintScheme( name ) 
	local preset = { Modexes = {} }
	Presets[ name ] = preset
	_p = Presets[ name ]
end

function AddModex( modex_number, varg4001, varg4002, varg4003, varg4004, varg4005 )
	local args = { }
	args[ 4001 ] = varg4001
	args[ 4002 ] = varg4002
	args[ 4003 ] = varg4003
	args[ 4004 ] = varg4004
	args[ 4005 ] = varg4005
	_p.Modexes[ modex_number ] = args
end


AddPaintScheme( "Fallback" )
AddModex( 100, 0.01, 0.02, 0.03, 0.04, 0.05 )
AddModex( 101, 0.11, 0.12, 0.13, 0.14, 0.15 )
AddModex( 102, 0.21, 0.22, 0.23, 0.24, 0.25 )
AddModex( 103, 0.31, 0.32, 0.33, 0.34, 0.35 )
AddModex( 104, 0.41, 0.42, 0.43, 0.44, 0.45 )

AddPaintScheme( "KillThemAllSkin" )
AddModex( 100, 0.01, 0.02, 0.03, 0.04, 0.05 )
AddModex( 101, 0.51, 0.52, 0.53, 0.54, 0.55 )
AddModex( 102, 0.61, 0.62, 0.63, 0.64, 0.65 )
AddModex( 103, 0.71, 0.72, 0.73, 0.74, 0.75 )
AddModex( 104, 0.81, 0.82, 0.83, 0.84, 0.85 )

need_to_be_closed = true
