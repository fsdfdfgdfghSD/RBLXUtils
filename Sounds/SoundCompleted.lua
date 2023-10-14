return function(Sound: Sound, Callback: () -> ())
	task.wait(Sound.TimeLength)
	Callback()
end