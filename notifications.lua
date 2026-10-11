
-- HyperIP Hub Notifications Module

local Notifications = {}

function Notifications.Show(guiParent, message, duration)
    if not guiParent then
        return
    end

    duration = duration or 3

    local toast = Instance.new("TextLabel")
    toast.Name = "HyperIPNotification"
    toast.Size = UDim2.new(1, -20, 0, 42)
    toast.Position = UDim2.new(0, 10, 0, 10)
    toast.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    toast.TextColor3 = Color3.fromRGB(255, 65, 80)
    toast.TextSize = 14
    toast.Font = Enum.Font.GothamBold
    toast.TextWrapped = true
    toast.Text = tostring(message)
    toast.Parent = guiParent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = toast

    task.delay(duration, function()
        if toast and toast.Parent then
            toast:Destroy()
        end
    end)
end

return Notifications
