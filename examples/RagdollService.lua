local RagdollService = require("pathToRagdollService")

game.Players.PlayerAdded:Connect(function(Player: Player)
	Player.CharacterAdded:Connect(function(Character)
		print(RagdollService:IsRagdolled(Character)) -- Returns false because character is not in ragdoll mode.
		task.wait(3)
		
		RagdollService:RagdollCharacter(Character) -- Ragdolls the character
		
		print(RagdollService:IsRagdolled(Character)) -- Returns true because character is in ragdoll mode.
		task.wait(2)
		
		RagdollService:UnragdollCharacter(Character, 30, 100) -- Unragdolls the character and then setting a custom WalkSpeed/JumpPower
		
		print(RagdollService:IsRagdolled(Character)) -- Returns false because character is not in ragdoll mode.
	end)
end)
