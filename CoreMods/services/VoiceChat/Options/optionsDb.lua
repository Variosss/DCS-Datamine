local DbOption   	= require('Options.DbOption')
return {
	use_turn_servers_enabled = DbOption.new():setValue(false):checkbox(),
}