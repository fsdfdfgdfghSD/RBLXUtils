--!strict

--[[

	Name: LoadJsonData.lua
	Author: netheround
	Description: A simple function that retrieves json data from the web and returns a lua table representation decoded.

	License: MIT
	Version: LoadJsonData 1.1

]]--

local HttpService = game:GetService("HttpService")

return function(Url: string): string?
	local Success: boolean, Result: string? = pcall(function()
		return HttpService:GetAsync(Url)
	end)
	
	if not Success then
		warn(Result)
		return
	end
	
	local Data: string? = HttpService:JSONDecode(Result)
	
	return Data
end
