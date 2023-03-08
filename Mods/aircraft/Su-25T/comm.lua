local parameters = {
	fighter = false,
	radar = false,
	ECM = true,
	refueling = false
}
return utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/LockOnAirplane.lua', getfenv()))(parameters)