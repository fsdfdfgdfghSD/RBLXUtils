local HttpService = game:GetService("HttpService")

return function(url: string)
	if not url then return error("Argument 1 (\"url: string\") missing or nil") end
	assert(type(url) == "string", "Argument 1 (\"url: string\") must be a string, got "..tostring(type(url))..".")
	
	local succ, result = pcall(function()
		return HttpService:GetAsync(url)
	end)
	
	if succ then
		local data = HttpService:JSONDecode(result)

		return data
	end
end