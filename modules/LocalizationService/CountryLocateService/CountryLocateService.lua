--!strict

--[[

	Name: CountryLocateService.lua
	Author: netheround
	Description: List of some useful functions to expand the Localization service.
	
	License: MIT
	Version: CountryLocateService 1.7
	
	API Documentation: {
	
		1. new()
		
		-> Creating a country to add it in the countries table using the AddCountryToList() method.
		
		Parameters:
		[NewData: {Code: string, Name: string, Emoji: string}]
	
		2. GetCountryForPlayer()
		
		-> Returns the given player's country data: Emoji, Name
		
		Parameters:
		[Player: Instance]
		
		Returns:
		[string]
		
		3. GetMyCountry()
		
		-> Returns the local player's country data: Emoji, Name
		Function must be used on the client.
		
		Returns:
		[string]
		
		4. GetCountryNameByCode()
		
		-> Returns the country name from the given country code.
		
		Parameters:
		[CountryCode: string]
		
		Returns:
		[string]
		
		5. GetCountryCodeByName()
		
		-> Returns the country code from the given name
		
		Parameters:
		[CountryName: string]
		
		Returns:
		[string]
		
		6. AddCountryToList()
		
		-> Adds a country with the: Code, Name, Emoji to the "Countries" list.
		
		Parameters:
		[Country: self]
		
		7. GetAllCountries()
		
		-> Returns all of the countries in a table representation.
		
		Returns:
		[Country: {[string]: Name: string, Emoji: string}]
		
		8. RandomCountry()
		
		-> Returns a random country from the countries table.
		
		Returns:
		[CountryData: {Name: string, Emoji: string}]
	}
]]--

local LocalizationService = game:GetService("LocalizationService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Countries = require(script.Countries)
local Types = require(script.Types)

local CountryLocateService = { _VERSION = "CountryLocateService 1.7" }
CountryLocateService.__index = CountryLocateService

type self = {
	Code: string,
	Name: string,
	Emoji: string
}

function CountryLocateService.new(NewData)
	local self = setmetatable(NewData or {}, CountryLocateService)
	
	self.Code = self.Code or "N/A"
	self.Name = self.Name or "N/A"
	self.Emoji = self.Emoji or "N/A"
	
	return self
end

function CountryLocateService:GetCountryForPlayer(Player: Player): string?
	local Success: boolean = nil
	local Result: string? = nil
	local Attempts: number = 1
	
	repeat
		Success, Result = pcall(function()
			return Countries[LocalizationService:GetCountryRegionForPlayerAsync(Player)]
		end)
		
		Attempts += 1
		
		if not Success then
			warn(Result)
			task.wait(3)
		end
	until Success or Attempts == 5
	
	if not Success and Attempts == 5 then
		error("Can't fetch "..Player.Name.."'s location.")
	end
	
	return Result
end

function CountryLocateService:GetMyCountry(): string?
	if RunService:IsServer() then
		return error("GetMyCountry() cannot be called from the server.")
	end
	
	return self:GetCountryForPlayer(Players.LocalPlayer)
end

function CountryLocateService:GetCountryNameByCode(CountryCode: string): string
	for Code: string, Data: Types.CountryData in pairs(Countries) do
		if Code == CountryCode then
			return Data.Name
		end
	end
	
	return error("Country code: \""..CountryCode.."\" not found.")
end

function CountryLocateService:GetCountryCodeByName(CountryName: string): string
	for Code: string, Data: Types.CountryData in pairs(Countries) do
		if Data.Name == CountryName then
			return Code
		end
	end
	
	return error("Country name: \""..CountryName.."\" not found.")
end

function CountryLocateService:AddCountryToList(): ()
	Countries[self.Code] = {["Name"] = self.Name, ["Emoji"] = self.Emoji}
end

function CountryLocateService:GetAllCountries(): Types.Country
	return Countries
end

function CountryLocateService:RandomCountry(): Types.CountryData?
	local CountryListSample: Types.table = {}
	
	for _, Data: Types.CountryData in pairs(Countries) do
		table.insert(CountryListSample, Data)
	end
	
	return CountryListSample[math.random(1, #CountryListSample)]
end

return CountryLocateService
