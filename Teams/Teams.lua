-- This module only works on Client --

local Teams = {}

function Teams:GetTeams() -- Returns a table with every player in game with their team, if they dont have a team then it will return nil
	if game["Run Service"]:IsClient() then
		local Players = game:GetService("Players")
		local PlayerTeams = {}

		for _, Player in ipairs(Players:GetPlayers()) do
			PlayerTeams[Player.Name] = tostring(Player.Team)
		end

		return PlayerTeams
	else
		error("GetTeams function must be used in a LocalScript")
	end
end

function Teams:GetPlayerTeam(Player: Player) -- Returns a table with player's team, if no team then return nil
	if game["Run Service"]:IsClient() then
		local PlayerTeam = {}

		if Player then
			PlayerTeam[Player.Name] = tostring(Player.Team)
			return PlayerTeam
		end
	else
		error("GetPlayerTeam function must be used in a LocalScript")
	end
end

return Teams
