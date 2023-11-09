--!nocheck

--[[

	Name: CountryLocateService.lua
	Author: netheround
	Description: List of some useful functions to expand the Localization service.
	
	License: MIT
	Version: CountryLocateService 1.0

]]--

local LocalizationService = game:GetService("LocalizationService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Countries = require(script.parent.Countries)

export type Country = {[string]: {Name: string, Emoji: string}} -- Custom country type.

--[[

	How to check if something's a country:

	local MyCountry: CountryService.Country = {["A"] = {Name = "B", Emoji = "C"}}

]]--

type table = {[any]: any?}

local CountryLocateService = { _VERSION = "CountryLocateService 1.0" }

-- Returns the given player's country data: Emoji, Name

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

-- Returns the local player's country data: Emoji, Name

function CountryLocateService:GetMyCountry()
	if RunService:IsServer() then
		return error("GetMyCountry() cannot be called from the server.")
	end
	
	return self:GetCountryForPlayer(Players.LocalPlayer)
end

-- Returns the country name from the given country code.

function CountryLocateService:GetCountryNameByCode(CountryCode: string): string
	for Code, Data in pairs(Countries) do
		if Code == CountryCode then
			return Data.Name
		end
	end
	
	return error("Country code: \""..CountryCode.."\" not found.")
end

-- Returns the country code from the given name

function CountryLocateService:GetCountryCodeByName(CountryName: string): string
	for Code, Data in pairs(Countries) do
		if Data.Name == CountryName then
			return Code
		end
	end
	
	return error("Country: \""..CountryName.."\" not found.")
end

-- Adds a country with the: Code, Name, Emoji to the "Countries" list.

function CountryLocateService:AddCountryToList(Code: string, Name: string, Emoji: string)
	if Code and Name and Emoji then
		Countries[Code] = {["Name"] = Name, ["Emoji"] = Emoji}
	else
		return error("Please provide the country name and code.")
	end
end

-- Returns all of the countries in a table.

function CountryLocateService:GetAllCountries(): Country
	return Countries
end

-- Returns a random country data sample.

function CountryLocateService:CountrySample(): {Emoji: string, Name: string}
	local CountryListSample: table = {}
	
	for _, CountryData: table in pairs(Countries) do
		table.insert(CountryListSample, CountryData)
	end
	
	return CountryListSample[math.random(1, #CountryListSample)]
end

return CountryLocateService
