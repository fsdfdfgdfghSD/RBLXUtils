--[[

	Name: GamePassService.lua
	Author: netheround
	Description: a useless gamepass service with simpler functions to use.
	
	License: MIT
	Version: GamePassService 1.2
	
]]--

local MarketPlaceService = game:GetService("MarketplaceService")

type table = {[any]: any?}

local GamePassService = {}
GamePassService._VERSION = "GamePassService 1.2"

-- Returns true if the player owns the given pass id, or an error if UserOwnsGamePassAsync didnt succeed.

function GamePassService:PlayerOwnsPass(UserId: number, PassId: number): boolean
	local Success = nil
	local Result = nil
	local Attempts = 1
	
	repeat
		Success, Result = pcall(function()
			return MarketPlaceService:UserOwnsGamePassAsync(UserId, PassId)
		end)
		
		Attempts += 1
		
		if not Success then
			warn(Result)
			task.wait(3)
		end
	until Success or Attempts == 5
	
	if Success then
		return Result
	else
		error("Error, Can't check if \""..UserId.."\" owns \""..PassId.."\"")
	end
end

-- Returns a big table with all of the info of the given pass id.

function GamePassService:GetPassInfo(PassId: number): table
	return MarketPlaceService:GetProductInfo(PassId, Enum.InfoType.GamePass)
end

-- If player doesn't own the given pass id then it prompts the given pass id purchase, if owns then it returns a message.

function GamePassService:PromptPlayerPass(Player: Player, PassId: number): ()
	if GamePassService:PlayerOwnsPass(Player.UserId, PassId) == false and GamePassService:GetPassInfo(PassId).IsForSale ~= false then
		return MarketPlaceService:PromptGamePassPurchase(Player, PassId)
	else
		print("Gamepass: \""..PassId.."\" must either be for sale or \""..Player.Name.."\" not own it.")
	end
end

return GamePassService