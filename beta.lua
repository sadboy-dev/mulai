-- Aikoware DELTA FIX (UI + Feature MUNCUL)
warn("[Aikoware] Delta fix start")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- LOAD LIBRARY
local AIKO = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/sadboy-dev/mulai/refs/heads/main/libary.lua"
))()

-- WINDOW
local Window = AIKO:Window({
    Title = "Aikoware | Fish It",
    Footer = "Delta Edition",
    Version = 1
})

-- TAB (INI YANG BENAR)
local Fishing = Window:AddTab("Fishing")
local Blatant = Window:AddTab("Blatant")

-- === ULTRA AUTO PERFECT (DELTA SAFE) ===
_G.UltraPerfect = false

Blatant:AddToggle({
    Title = "Auto Perfect (Delta)",
    Default = false,
    Callback = function(v)
        _G.UltraPerfect = v
    end
})

-- FORCE PERFECT VIA REMOTE (DELTA OK)
task.spawn(function()
    while task.wait(0.25) do
        if _G.UltraPerfect then
            pcall(function()
                local net = ReplicatedStorage.Packages
                    ._Index["sleitnick_net@0.2.0"]
                    .net

                for _,r in pairs(net:GetChildren()) do
                    if r:IsA("RemoteEvent") then
                        local n = r.Name:lower()
                        if n:find("fish")
                        or n:find("catch")
                        or n:find("perfect")
                        or n:find("complete") then
                            r:FireServer("Perfect", true, 100)
                        end
                    end
                end
            end)
        end
    end
end)

Fishing:AddParagraph({
    Title = "Info",
    Content = "Versi Delta\nUI & fitur aktif\nAuto Perfect via server"
})

AIKO:MakeNotify({
    Title = "Aikoware",
    Description = "Loaded",
    Content = "Fitur sudah aktif",
    Delay = 4
})
