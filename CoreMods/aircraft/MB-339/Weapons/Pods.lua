declare_loadout(
{
    category    = CAT_PODS,
    displayName = _("Photo-Recon Pod (4*70mm Vinten Cameras)"),
    Picture     = "MB339-Vinten.png",
    attribute   = {wsType_Weapon,wsType_GContainer,wsType_Control_Cont,WSTYPE_PLACEHOLDER},
    CLSID       = "{MB339_VINTEN}",
    
    Weight = 72,
    Cx_pil = 0.0006,
    shape_table_data =
    {
        {
            name = "MB339_Vinten",
            file = "MB339_Vinten",
            life = 1,
            fire = { 0, 1},
            username = "MB339_Vinten",
            index = WSTYPE_PLACEHOLDER,
        },
    },
    Elements =
    {
        [1] = {
            Position = {0, 0, 0},
            ShapeName = "MB339_Vinten",
        },
    },
}
)

declare_loadout(
{
    category    = CAT_PODS,
    displayName = _("Luggage Container"),
    Picture     = "MB339-Travelpod.png",
    attribute   = {wsType_Weapon, wsType_GContainer, wsType_Support,WSTYPE_PLACEHOLDER},
    CLSID       = "{MB339_TRAVELPOD}",
    
    Weight = 72,
    Cx_pil = 0.0006,
    shape_table_data =
    {
        {
            name = "MB339_TravelPod",
            file = "MB339_TravelPod",
            life = 1,
            fire = { 0, 1},
            username = "MB339_TravelPod",
            index = WSTYPE_PLACEHOLDER,
        },
    },
    Elements =
    {
        [1] = {
            Position = {0, 0, 0},
            ShapeName = "MB339_TravelPod",
        },
    },
}
)