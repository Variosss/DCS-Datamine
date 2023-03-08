local self_ID = "AJS37 Viggen by Heatblur Simulations"

declare_plugin(
    self_ID,
    {
        installed = true, -- if false that will be place holder , or advertising
        dirName = current_mod_path,

        displayName = _("AJS37"),
        version = __DCS_VERSION__,
        state = "sale",
        info = _("The AJS37 Viggen is a Swedish double-delta supersonic attack aircraft from the late Cold War. It was the backbone of the Swedish Air Force during the Cold war, serving as the main attack and anti-ship platform. The AJS is the 90’s upgrade of this 70’s era aircraft, adding several advanced weapons and systems functionalities. The aircraft was designed around the pilot, with an excellent man-machine interface, supporting the pilot through the smart use of autopilot systems and HUD symbology in order to deliver the ordnance onto targets from treetop level with high speed attack runs."),

        linkBuy =
        {
            ED      = "http://www.digitalcombatsimulator.com/",
            STEAM   = "",
        },
        Skins = {
            {
                name = _("AJS37"),
                dir = "Skins/1"
            },
        },
    })
----------------------------------------------------------------------------------------
plugin_done() -- finish declaration , clear temporal data
