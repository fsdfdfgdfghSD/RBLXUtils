-- TODO: Strict mode + type checking support.

local Ragdoll = {}

function Ragdoll:RagdollCharacter(Character)
	local Humanoid = Character:WaitForChild("Humanoid")
	
	for _, Joint in Character:GetDescendants() do
		if Joint:IsA("Motor6D") then
			local Socket = Instance.new("BallSocketConstraint")
			local Attachment0 = Instance.new("Attachment")
			local Attachment1 = Instance.new("Attachment")
			
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

function Ragdoll:UnRagdollCharacter(Character)
	local Humanoid = Character:WaitForChild("Humanoid")
	
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
	
	Humanoid.WalkSpeed = 16
	Humanoid.JumpPower = 50
	
	Humanoid.AutoRotate = true
end

function Ragdoll:IsRagdolled(Character): boolean
	for _, Joint in Character:GetDescendants() do
		if Joint:IsA("BallSocketConstraint") then
			return true
		end
	end
	
	return false
end

return Ragdoll
