export type Country = { -- Custom country type.
	[string]: CountryData
}

export type CountryData = { -- Custom country data type.
	Name: string, Emoji: string
}

--[[

	How to check if something is a country:

	local MyCountry: Types.Country = {["A"] = {Name = "B", Emoji = "C"}}
	
	How to check if something is a country data
	
	local MyCountryData: Types.CountryData = {Name = "B", Emoji = "C"}

]]--

export type table = {[any]: any?}

return nil -- We must return something or the require() function will have a orange underline.
