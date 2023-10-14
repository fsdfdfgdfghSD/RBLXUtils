return function(Sound: Sound, Callback: () -> ()) -- When the sound played you can create a function same as Tween.Completed.
	task.wait(Sound.TimeLength)
	Callback()
end
