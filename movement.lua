
-- HyperIP Hub Movement Module
-- Character utilities for a Roblox experience.

local Players = game:GetService("Players")

local Movement = {}

function Movement.GetCharacter()
    local player = Players.LocalPlayer

    if not player then
        return nil
    end

    return player.Character
end

function Movement.GetHumanoid()
    local character = Movement.GetCharacter()

    if not character then
        return nil
    end

    return character:FindFirstChildOfClass("Humanoid")
end

function Movement.GetRootPart()
    local character = Movement.GetCharacter()

    if not character then
        return nil
    end

    return character:FindFirstChild("HumanoidRootPart")
end

return Movement
