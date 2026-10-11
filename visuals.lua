
-- HyperIP Hub Visuals Module
-- Player list utilities for a Roblox experience.

local Players = game:GetService("Players")

local Visuals = {}

function Visuals.GetPlayers()
    local result = {}

    for _, player in ipairs(Players:GetPlayers()) do
        table.insert(result, {
            Name = player.Name,
            DisplayName = player.DisplayName,
            UserId = player.UserId
        })
    end

    return result
end

function Visuals.GetDistanceFromLocalPlayer(targetPlayer)
    local localPlayer = Players.LocalPlayer

    if not localPlayer or not targetPlayer then
        return nil
    end

    local character = localPlayer.Character
    local targetCharacter = targetPlayer.Character

    if not character or not targetCharacter then
        return nil
    end

    local root = character:FindFirstChild("HumanoidRootPart")
    local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")

    if not root or not targetRoot then
        return nil
    end

    -- Roblox distance is measured in studs.
    return math.floor((root.Position - targetRoot.Position).Magnitude)
end

return Visuals
