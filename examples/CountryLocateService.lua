local CountryLocateService = require(game.ReplicatedStorage.OpenSource_Modules.CountryLocateService)

game.Players.PlayerAdded:Connect(function(Player: Player)
	local MyCountry = CountryLocateService.new({Code = "MyCountryCode", Name = "MyCountryEmoji", Emoji = "MyCountryName"}) -- Creates a new country with custom preferences
	print(CountryLocateService:GetCountryForPlayer(Player)) -- Returns a data containing the country name and emoji
	MyCountry:AddCountryToList() -- Adds my custom country to the countries list
	print(CountryLocateService:GetAllCountries()) -- Returns all of the countries
	
	--print(CountryLocateService:GetMyCountry()) -- Will error since this is a server code, must be used on the client.
	
	print(CountryLocateService:GetCountryCodeByName("Canada")) -- Returns "CA"
	print(CountryLocateService:GetCountryNameByCode("RO")) -- Returns "Romania"
end)
