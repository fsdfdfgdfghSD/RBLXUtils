--!strict

--[[

	> NOTE: This module uses JumpPower, not JumpHeight.

	Name: RagdollService.lua
	Author: netheround
	Description: Nice ragdolling module that works with both R6/R15
	
	License: MIT
	Version: RagdollService 1.2
	
	API Documentation: {
	
		1. RagdollCharacter()
		
		-> Ragdolls the given characters + changes the WalkSpeed/JumpPower to 0.
		
		
		Parameters:
		[Character: Model]
		
		2. UnragdollCharacter()
		
		-> Unragdolls the given characters + changes the WalkSpeed/JumpPower to the given ones or default which is 16/50.
		
		Parameters:
		[Character: Model]
		[WalkSpeed: number]
		[JumpPower: number]
		
		3. IsRagdolled()
		
		-> Returns true if the given character is ragdolled or false if its not.
		
		Parameters:
		[Character: model]
		
		Returns:
		[boolean]
	}

]]--

local RagdollService = { _VERSION = "RagdollService 1.2" }

function RagdollService:RagdollCharacter(Character): ()
	local Humanoid: Humanoid? = Character:FindFirstChild("Humanoid")
		
	if Humanoid then
		for _, Joint in Character:GetDescendants() do
			if Joint:IsA("Motor6D") then
				local Socket: BallSocketConstraint = Instance.new("BallSocketConstraint")
				local Attachment0: Attachment = Instance.new("Attachment")
				local Attachment1: Attachment = Instance.new("Attachment")

				Attachment0.Parent = Joint.Part0
				Attachment1.Parent = Joint.Part1

				Socket.Parent = Joint.Parent
				Socket.Attachment0 = Attachment0
				Socket.Attachment1 = Attachment1

				Attachment0.CFrame = Joint.C0
				Attachment1.CFrame = Joint.C1

				Socket.LimitsEnabled = true
				Socket.TwistLimitsEnabled = true
				Joint.Enabled = false
			end
		end
			
		Humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)

		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0

		Humanoid.PlatformStand = true
		Humanoid.AutoRotate = false
	end
end

function RagdollService:UnragdollCharacter(Character, WalkSpeed: number?, JumpPower: number?): ()
	local Humanoid: Humanoid? = Character:WaitForChild("Humanoid")

	if Humanoid then
		Humanoid.PlatformStand = false

		for _, Joint in Character:GetDescendants() do
			if Joint:IsA("BallSocketConstraint") then
				Joint:Destroy()
			end

			if Joint:IsA("Motor6D") then
				Joint.Enabled = true
			end
		end

		Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)

		Humanoid.WalkSpeed = WalkSpeed or 16
		Humanoid.JumpPower = JumpPower or 50

		Humanoid.AutoRotate = true
	end
end

function RagdollService:IsRagdolled(Character): boolean
	for _, Joint in Character:GetDescendants() do
		if Joint:IsA("BallSocketConstraint") then
			return true
		end
	end

	return false
end

return RagdollService
