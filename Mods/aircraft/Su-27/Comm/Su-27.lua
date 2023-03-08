local parameters = {
	fighter = true,
	radar = true,
	ECM = true,
	refueling = false
}
return utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/LockOnAirplane.lua', getfenv()))(parameters)