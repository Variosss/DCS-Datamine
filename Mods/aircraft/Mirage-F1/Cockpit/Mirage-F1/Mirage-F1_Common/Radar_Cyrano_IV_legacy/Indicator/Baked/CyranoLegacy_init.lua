-- Baked

dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_init_common.lua")

purposes = {100} -- is rendered into a texture

--Source files for page subsets
SRC_RDR_BACK		= 0
SRC_RDR_AA			= 1
SRC_RDR_AG			= 2
SRC_RDR_TARGETS		= 3

--subsets declare lua indication source files which will be used to combines pages 
my_path = LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/Baked/"

page_subsets = {
[SRC_RDR_BACK]			= my_path.."CyranoLegacy_back.lua",
[SRC_RDR_AA] 			= my_path.."CyranoLegacy_AA.lua",
[SRC_RDR_AG] 			= my_path.."CyranoLegacy_AG.lua",
[SRC_RDR_TARGETS] 		= my_path.."CyranoLegacy_targets.lua",
}

----------------------
pages = {
[PAGE_OFF]				= {},
[PAGE_AA]				= {SRC_RDR_BACK, SRC_RDR_AA},
[PAGE_AG]				= {SRC_RDR_BACK, SRC_RDR_AG},
}

function getMultipleSymbolByID(id)
	if id == 1 then
		return "target_mark"
	end
	
	return ""
end

function get_template(name)
	if name == "TARGETS" then
		return SRC_RDR_TARGETS
	end
	
	return -1
end
