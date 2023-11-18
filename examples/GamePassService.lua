local GamePassService = require("pathToGamePassService")

game.Players.PlayerAdded:Connect(function(Player: Player)
	if GamePassService:PlayerOwnsPass(Player.UserId, 1) then -- Checks if player owns the gamepass 1
		print("Owns the gamepass 1")
	else
		print("Doesnt own the gamepass 1")
	end
	
	print(GamePassService:GetPassInfo(1)) -- Returns a big table with the gamepass information
	
	GamePassService:PromptPlayerPass(Player, 1000) -- Prompts the gamepass id 1000 to player.
	
	game.MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(Player, GamePassId, WasPurchased)
		if WasPurchased then
			print(GamePassId.." gamepass id was purchased by "..Player.Name)
		else
			print(Player.Name.." declined the purchase of gamepass "..GamePassService:GetPassInfo(GamePassId).Name) -- Returns the name of the pass.
		end
	end)
end)
