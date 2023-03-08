-- Baked

dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_init_common.lua")

purposes = {100} -- is rendered into a texture

--Source files for page subsets
SRC_RDR_BACK		= 0
SRC_RDR_MAIN		= 1
SRC_RDR_CONTACTS	= 2

--subsets declare lua indication source files which will be used to combines pages 
my_path = LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/Baked/"

page_subsets = {
[SRC_RDR_BACK]			= my_path.."CyranoLegacy_contacts_back.lua",
[SRC_RDR_MAIN]			= my_path.."CyranoLegacy_contacts_main.lua",
[SRC_RDR_CONTACTS] 		= my_path.."CyranoLegacy_rdr_contacts.lua",
}

----------------------
pages = {
[PAGE_OFF]				= {},
[PAGE_AA]				= {SRC_RDR_BACK, SRC_RDR_MAIN},
[PAGE_AG]				= {SRC_RDR_BACK},
}

function getRadarContactsTemplate(id)
	if id == 0 then
		return "radar_contact"
	end
	
	return ""
end

function get_template(name)
	if name == "RADAR_CONTACTS" then
		return SRC_RDR_CONTACTS
	end
	
	return -1
end
