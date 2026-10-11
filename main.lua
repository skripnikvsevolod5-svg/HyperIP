
-- HyperIP Hub
-- Main menu foundation

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("HyperIP")
if old then
    old:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "HyperIP"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local function create(class, props, parent)
    local obj = Instance.new(class)
    for key, value in pairs(props) do
        obj[key] = value
    end
    obj.Parent = parent
    return obj
end

local red = Color3.fromRGB(220, 25, 45)
local dark = Color3.fromRGB(20, 20, 24)
local panel = Color3.fromRGB(30, 30, 36)
local white = Color3.fromRGB(245, 245, 245)

local launcher = create("TextButton", {
    Name = "Launcher",
    Size = UDim2.fromOffset(145, 46),
    Position = UDim2.new(0, 18, 0.5, -23),
    BackgroundColor3 = red,
    Text = "⚡ HYPERIP",
    TextColor3 = white,
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    Active = true,
}, gui)

create("UICorner", {CornerRadius = UDim.new(0, 14)}, launcher)

local window = create("Frame", {
    Name = "Window",
    Size = UDim2.fromOffset(330, 370),
    Position = UDim2.new(0.5, -165, 0.5, -185),
    BackgroundColor3 = dark,
    Visible = false,
    Active = true,
}, gui)

create("UICorner", {CornerRadius = UDim.new(0, 12)}, window)
create("UIStroke", {Color = red, Thickness = 2}, window)

local title = create("TextLabel", {
    Size = UDim2.new(1, -55, 0, 48),
    Position = UDim2.fromOffset(12, 0),
    BackgroundTransparency = 1,
    Text = "HYPERIP HUB",
    TextColor3 = red,
    TextSize = 22,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, window)

local close = create("TextButton", {
    Size = UDim2.fromOffset(38, 38),
    Position = UDim2.new(1, -44, 0, 5),
    BackgroundColor3 = red,
    Text = "X",
    TextColor3 = white,
    TextSize = 18,
    Font = Enum.Font.GothamBold,
}, window)

create("UICorner", {CornerRadius = UDim.new(0, 9)}, close)

local tabs = create("Frame", {
    Size = UDim2.new(1, -20, 0, 42),
    Position = UDim2.fromOffset(10, 52),
    BackgroundTransparency = 1,
}, window)

create("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, tabs)

local content = create("Frame", {
    Size = UDim2.new(1, -20, 1, -108),
    Position = UDim2.fromOffset(10, 100),
    BackgroundColor3 = panel,
}, window)

create("UICorner", {CornerRadius = UDim.new(0, 9)}, content)

local pages = {}
local currentPage

local function showPage(name)
    for pageName, page in pairs(pages) do
        page.Visible = pageName == name
    end
    currentPage = name
end

local function addPage(name)
    local button = create("TextButton", {
        Size = UDim2.fromOffset(98, 38),
        BackgroundColor3 = red,
        Text = name,
        TextColor3 = white,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        LayoutOrder = #tabs:GetChildren(),
    }, tabs)
    create("UICorner", {CornerRadius = UDim.new(0, 8)}, button)

    local page = create("ScrollingFrame", {
        Name = name,
        Size = UDim2.new(1, -12, 1, -12),
        Position = UDim2.fromOffset(6, 6),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
    }, content)

    create("UIListLayout", {
        Padding = UDim.new(0, 7),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, page)

    pages[name] = page
    button.Activated:Connect(function()
        showPage(name)
    end)

    return page
end

local function addLabel(page, text)
    return create("TextLabel", {
        Size = UDim2.new(1, -8, 0, 35),
        BackgroundColor3 = dark,
        Text = text,
        TextColor3 = white,
        TextSize = 13,
        Font = Enum.Font.Gotham,
        TextWrapped = true,
    }, page)
end

local function addButton(page, text, callback)
    local button = create("TextButton", {
        Size = UDim2.new(1, -8, 0, 38),
        BackgroundColor3 = dark,
        Text = text,
        TextColor3 = white,
        TextSize = 14,
        Font = Enum.Font.GothamMedium,
    }, page)

    create("UICorner", {CornerRadius = UDim.new(0, 7)}, button)
    button.Activated:Connect(callback)
    return button
end

local mainPage = addPage("Main")
local visualPage = addPage("Visuals")
local settingsPage = addPage("Settings")

addLabel(mainPage, "Welcome to HyperIP Hub")
addLabel(mainPage, "Игрок: " .. player.Name)
addLabel(mainPage, "Игровые функции добавим отдельными модулями.")

addLabel(visualPage, "Игроки на сервере")
local playerList = addLabel(visualPage, "Загрузка списка игроков...")

local function updatePlayers()
    local names = {}
    for _, other in ipairs(Players:GetPlayers()) do
        if other ~= player then
            table.insert(names, other.Name)
        end
    end

    playerList.Text = #names > 0
        and table.concat(names, "\n")
        or "Других игроков пока нет"
end

updatePlayers()
Players.PlayerAdded:Connect(updatePlayers)
Players.PlayerRemoving:Connect(updatePlayers)

local languages = {"Русский", "English", "Українська", "Deutsch"}
local languageIndex = 1

addButton(settingsPage, "Язык: Русский", function(button)
    languageIndex = languageIndex % #languages + 1
    button.Text = "Язык: " .. languages[languageIndex]
end)

addButton(settingsPage, "Изменить цвет темы", function()
    if window.BackgroundColor3 == dark then
        window.BackgroundColor3 = Color3.fromRGB(25, 15, 35)
        content.BackgroundColor3 = Color3.fromRGB(40, 25, 50)
        red = Color3.fromRGB(170, 70, 255)
    else
        window.BackgroundColor3 = dark
        content.BackgroundColor3 = panel
        red = Color3.fromRGB(220, 25, 45)
    end
    launcher.BackgroundColor3 = red
    close.BackgroundColor3 = red
    title.TextColor3 = red
end)

launcher.Activated:Connect(function()
    window.Visible = not window.Visible
end)

close.Activated:Connect(function()
    window.Visible = false
end)

-- Drag the floating button and menu with touch or mouse.
local function makeDraggable(object, handle)
    local dragging = false
    local startInput
    local startPosition

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startInput = input
            startPosition = object.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            local delta = input.Position - startInput.Position
            object.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input == startInput then
            dragging = false
        end
    end)
end

makeDraggable(launcher, launcher)
makeDraggable(window, title)

showPage("Main")
print("HyperIP Hub loaded")
