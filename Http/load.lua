local HttpService = game:GetService("HttpService")

return function(url: string) -- Taks an argument as "string" and it extracts the data from the url and then it decodes the json format to lua table and returns the data.
	if not url then return error("Argument 1 (\"url: string\") missing or nil") end
	assert(type(url) == "string", "Argument 1 (\"url: string\") must be a string, got "..tostring(type(url))..".")
	
	local succ, result = pcall(function()
		return HttpService:GetAsync(url)
	end)
	
	if succ then
		local data = HttpService:JSONDecode(result)

		return data
	else
		warn(result)
	end
end
