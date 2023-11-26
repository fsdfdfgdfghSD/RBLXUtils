--!nonstrict

-- TODO: Fix type checking bug + strict mode.

--[[

	Name: Day_Night_Cycle.lua
	Author: netheround
	Description: A small module for configuring your day/night cycle system.

	License: MIT
	Version: Day_Night_Cycle 1.0

	API Documentation: {
	
		1. new()
		
		-> Configurating your preferences for the day/night cycle effect.
		
		Parameters:
		[NewData: {DayLength: number, CycleTime: number, Minutes_In_A_Day: number}]
		
		2. Start()
		
		-> Starts the day/night cycle effect with the custom configuration.
	}

]]--

local Lighting = game:GetService("Lighting")

type self = {
	DayLength: number,
	CycleTime: number,
	Minutes_In_A_Day: number,
}

local Day_Night_Cycle = { _VERSION = "Day_Night_Cycle 1.0" }
Day_Night_Cycle.__index = Day_Night_Cycle

function Day_Night_Cycle.new(Configuration): ()
	local self = setmetatable(Configuration or {}, Day_Night_Cycle)
	
	self.DayLength = self.DayLength or 12
	self.CycleTime = self.CycleTime or self.DayLength * 60
	self.Minutes_In_A_Day = self.Minutes_In_A_Day or 24 * 60
	
	return self
end

function Day_Night_Cycle:Start(): ()
	local StartTime: number = tick() - (Lighting:GetMinutesAfterMidnight() / self.Minutes_In_A_Day) * self.CycleTime
	local EndTime: number = StartTime + self.CycleTime
	
	local TimeRation: number = self.Minutes_In_A_Day / self.CycleTime
	
	if self.DayLength == 0 then
		self.DayLength = 1
	end
	
	repeat
		local CurrentTime: number = tick()
		
		if CurrentTime > EndTime then
			StartTime = EndTime
			EndTime = StartTime + self.CycleTime
		end
		
		Lighting:SetMinutesAfterMidnight((CurrentTime - StartTime) * TimeRation)
		task.wait(1 / 15)
	until false
end

return Day_Night_Cycle
