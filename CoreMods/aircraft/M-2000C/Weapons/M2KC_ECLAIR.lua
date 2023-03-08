
declare_loadout({
	category		=	CAT_PODS,
	CLSID			=	"{Eclair}",
	Picture			=	"mercury.png",
	displayName		=	_("Eclair 16 flares 16 chaffs"),
	Count			=	1,
	Weight			=	20,
	Cx_pil			=	0.0,
	attribute		=	{wsType_Weapon, wsType_GContainer, wsType_Snare_Cont, WSTYPE_PLACEHOLDER},
	Elements		=	{
		[1]	=	
		{
			Position	=	{0,	0,	0},
		}, 
	}, -- end of Elements
})




for i=0,6 do
	local chaff = i*18
	local flare = (6-i)*8
	
	local dispname = "Eclair-M "..(6-i).."/"..i.." :"
	if flare>0 then
		dispname = dispname.." "..flare.." flares"
	end

	if chaff>0 then
		dispname = dispname.." "..chaff.." chaffs"
	end
	
	declare_loadout({
		category		=	CAT_PODS,
		CLSID			=	"{EclairM_"..(6-i)..i.."}",
		Picture			=	"mercury.png",
		displayName		=	_(dispname),
		Count			=	1,
		Weight			=	20,
		Cx_pil			=	0.0,
		attribute		=	{wsType_Weapon, wsType_GContainer, wsType_Snare_Cont, WSTYPE_PLACEHOLDER},
		Elements		=	{
			[1]	=	
			{
				Position	=	{0,	0,	0},
			}, 
		}, -- end of Elements
	})
end


