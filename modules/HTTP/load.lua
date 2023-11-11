--!strict

local HttpService = game:GetService("HttpService")

-- Takes an argument as string and it extracts the data from the url and then it decodes the json format to lua table and returns the data.

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
