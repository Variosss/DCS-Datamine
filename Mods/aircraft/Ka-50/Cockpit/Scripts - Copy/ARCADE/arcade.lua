scales           = {1000,5000,10000,20000,50000}
default_scale    =  3

dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua") 

select_next_after_destroy = true;

function post_initialize()
    local weapon_interface = GetDevice(devices.WEAP_INTERFACE)
    local laser_ranger     = GetDevice(devices.LASERRANGER)
    local cpt_mech         = GetDevice(devices.CPT_MECH)
    weapon_interface:performClickableAction(device_commands.Button_1,1.0);
    weapon_interface:performClickableAction(device_commands.Button_4,0.1);-- burst length to MIDDLE     
    weapon_interface:performClickableAction(device_commands.Button_5,1.0);-- override launch authorization     
   
    cpt_mech:SetCommand(Keys.PlaneModeCannon,1.0) 
    laser_ranger:performClickableAction(device_commands.Button_1,1.0); 
	switch_labels_off()
end
