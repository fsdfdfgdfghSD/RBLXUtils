function Played(Sound: Sound, Callback: () -> ())
	task.wait(Sound.TimeLength)
	Callback()
end

return function(SoundId: number, SoundName: string, Location)
	local Sound = Instance.new("Sound")
	Sound.Parent = Location
	Sound.Name = SoundName
	Sound.SoundId = "rbxassetid://"..tostring(SoundId)

	Sound:Play()

	Played(Sound, function()
		Sound:Destroy()
	end)
end
