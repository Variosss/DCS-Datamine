-- Bomb definitions must have been included before this file

-- RAFAUT BOMB RACK
local rafaut_rot = 0
local rafaut_auf2_points = {
	[1] = {Position = {-0.011874, -0.162894, -0.220}  , Rotation = { rafaut_rot,0,0} },-- left
	[2] = {Position = {-0.011874, -0.162894,  0.220}  , Rotation = {-rafaut_rot,0,0} },-- right
}

--some predefinition helpers as adapter
local rafaut_auf2_adapter =  {  ShapeName = "M-2000C_AUF2", IsAdapter = true }

-- and weapon itself , attached to point at number i
local function rafaut_auf2_element(shape,i)
 return  {
    Position = rafaut_auf2_points[i].Position, -- position relative to adapter
    Rotation = rafaut_auf2_points[i].Rotation, -- rotations in degrees , mostly used only X axis
    ShapeName = shape,
   }
end

declare_loadout({
	category	= CAT_BOMBS,
	CLSID		= "{M2KC_RAFAUT_MK82}",
	attribute	= {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon	=	{4,	5,	9,	31},
	Count		= 2,	--count of wepon
	Cx_pil		= 0.001, -- drag index of whole rack
	Picture		=	"mk82.png",
	displayName	= _("AUF2 MK-82 x 2"),
	Weight		= 75 + 2 * 225,-- weight adapter + weapon
	Elements	=
	{
		rafaut_auf2_adapter,
		rafaut_auf2_element("MK-82", 2),
		rafaut_auf2_element("MK-82", 1),
	}
})

declare_loadout({
	category	= CAT_BOMBS,
	CLSID		= "{M2KC_RAFAUT_MK82S}",
	attribute	= {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon	=	{4,	5,	9,	79},
	Count		= 2,	--count of wepon
	Cx_pil		= 0.001, -- drag index of whole rack
	Picture		=	"mk82.png",
	displayName	= _("AUF2 MK-82 Snakeyes x 2"),
	Weight		= 75 + 2 * 225,-- weight adapter + weapon
	Elements	=
	{
		rafaut_auf2_adapter,
		rafaut_auf2_element("MK-82_Snakeye", 2),
		rafaut_auf2_element("MK-82_Snakeye", 1),
	}
})

declare_loadout({
	category	= CAT_BOMBS,
	CLSID		= "{M2KC_RAFAUT_MK82A}",
	attribute	= {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon	=	{4,	5,	9,	75},
	Count		= 2,	--count of wepon
	Cx_pil		= 0.001, -- drag index of whole rack
	Picture		=	"mk82AIR.png",
	displayName	= _("AUF2 MK-82 Air x 2"),
	Weight		= 75 + 2 * 225,-- weight adapter + weapon
	Elements	=
	{
		rafaut_auf2_adapter,
		rafaut_auf2_element("Mk-82AIR", 2),
		rafaut_auf2_element("Mk-82AIR", 1),
	}
})

declare_loadout({
	category		= CAT_BOMBS,
	CLSID			= "{M2KC_RAFAUT_BLG66}",
	attribute		= {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER},
	--attribute		= {4, 5, 32, 15},
	wsTypeOfWeapon	= Belouga.wsTypeOfWeapon,
	Count			= 2,	--count of wepon
	Cx_pil			= 0.001, -- drag index of whole rack
	Picture			= "Mk20.png",
	displayName		= _("AUF2 BLG-66-AC x 2"),
	Weight			= 75 + 2 * 305,-- weight adapter + weapon
	Elements		=
	{
		rafaut_auf2_adapter,
		rafaut_auf2_element("M2000C_BLG66", 2),
		rafaut_auf2_element("M2000C_BLG66", 1),
	}
})

declare_loadout({
	category	= CAT_BOMBS,
	CLSID		= "{M2KC_RAFAUT_ROCKEYE}",
	attribute	= {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon	=	{4,	5,	38,	45},
	Count		= 2,	--count of wepon
	Cx_pil		= 0.001, -- drag index of whole rack
	Picture		=	"Mk20.png",
	displayName	= _("AUF2 ROCKEYE x 2"),
	Weight		= 75 + 2 * 225,-- weight adapter + weapon
	Elements	=
	{
		rafaut_auf2_adapter,
		rafaut_auf2_element("ROCKEYE", 2),
		rafaut_auf2_element("ROCKEYE", 1),
	}
})

declare_loadout({
	category	= CAT_BOMBS,
	CLSID		= "{M2KC_RAFAUT_GBU12}",
	attribute	= {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon	=	{4,	5,	36,	38},
	Count		= 2,	--count of wepon
	Cx_pil		= 0.001, -- drag index of whole rack
	Picture		=	"GBU12.png",
	displayName	= _("AUF2 GBU-12 x 2"),
	Weight		= 75 + 2 * 273,-- weight adapter + weapon
	Elements	=
	{
		rafaut_auf2_adapter,
		rafaut_auf2_element("GBU-12", 2),
		rafaut_auf2_element("GBU-12", 1),
	}
})

declare_loadout({
	category	= CAT_BOMBS,
	CLSID		= "{M2KC_RAFAUT_SAMP250LD}",
	attribute	= {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon	=	{4, 5, 9, 389},
	Count		= 2,	--count of wepon
	Cx_pil		= 0.001, -- drag index of whole rack
	Picture		=	"mk82.png",
	displayName	= _("AUF2 SAMP-250 x 2"),
	Weight		= 75 + 2 * 245,-- weight adapter + weapon
	Elements	=
	{
		rafaut_auf2_adapter,
		rafaut_auf2_element("SAMP250LD", 2),
		rafaut_auf2_element("SAMP250LD", 1),
	}
})

declare_loadout({
	category	= CAT_BOMBS,
	CLSID		= "{M2KC_RAFAUT_SAMP250HD}",
	attribute	= {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon	=	{4, 5, 9, 390},
	Count		= 2,	--count of wepon
	Cx_pil		= 0.001, -- drag index of whole rack
	Picture		=	"mk82AIR.png",
	displayName	= _("AUF2 SAMP-250 HD x 2"),
	Weight		= 75 + 2 * 269,-- weight adapter + weapon
	Elements	=
	{
		rafaut_auf2_adapter,
		rafaut_auf2_element("SAMP250HD", 2),
		rafaut_auf2_element("SAMP250HD", 1),
	}
})