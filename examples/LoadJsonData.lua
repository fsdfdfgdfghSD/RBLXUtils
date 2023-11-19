local LoadJsonData = require("pathToLoadJsonData")

local Data = LoadJsonData("https://catfact.ninja/fact") -- Retrieves the information from the web and decoding json to lua table format.

print(Data.fact) -- the api returns fact and length, we're printing fact.
