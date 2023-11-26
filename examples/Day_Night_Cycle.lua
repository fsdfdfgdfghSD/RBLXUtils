local Players = game:GetService("Players")

local Day_Night_Cycle = require("pathToDay_Night_Cycle")

local Day_Night_Cycle_Configuration = Day_Night_Cycle.new()

Players.PlayerAdded:Connect(function(Player)
	Day_Night_Cycle_Configuration:Start()
end)
