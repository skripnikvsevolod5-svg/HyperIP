
-- HyperIP Hub Settings

local Settings = {}

Settings.Theme = "Red"
Settings.Language = "Russian"

Settings.AvailableLanguages = {
    "Russian",
    "Ukrainian",
    "Belarusian",
    "English",
    "German",
    "Kazakh"
}

Settings.Themes = {
    Red = {
        Background = Color3.fromRGB(20, 20, 24),
        Accent = Color3.fromRGB(220, 25, 45)
    },
    Blue = {
        Background = Color3.fromRGB(20, 24, 35),
        Accent = Color3.fromRGB(40, 130, 255)
    },
    Purple = {
        Background = Color3.fromRGB(25, 15, 35),
        Accent = Color3.fromRGB(170, 70, 255)
    },
    Green = {
        Background = Color3.fromRGB(15, 30, 24),
        Accent = Color3.fromRGB(30, 220, 120)
    }
}

return Settings
