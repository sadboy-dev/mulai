-- DELTA EXECUTOR FIXED beta.lua
warn("[Aikoware] Delta beta.lua start")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- === LOAD UI LIBRARY (AMAN UNTUK DELTA) ===
local AIKO
local ok, err = pcall(function()
    AIKO = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/sadboy-dev/mulai/refs/heads/main/libary.lua"
    ))()
end)

if not ok or not AIKO then
    warn("[Aikoware] Library gagal load")
    return
end

-- === UI ===
local Window = AIKO:Window({
    Title = "Aikoware | Fish It",
    Footer = "Delta Edition",
    Version = 1
})

AIKO:MakeNotify({
    Title = "Aikoware",
    Description = "Status",
    Content = "Delta compatible UI loaded",
    Delay = 4
})

-- === TAB ===
local Fishing = Window:MakeTab({
    Name = "Fishing",
    Icon = "fish",
    PremiumOnly = false
})

local Blatant = Window:MakeTab({
    Name = "Blatant",
    Icon = "alert",
    PremiumOnly = false
})

-- === ULTRA AUTO PERFECT (DELTA SAFE) ===
_G.UltraPerfect = false

Blatant:AddToggle({
    Name = "Auto Perfect (Delta)",
    Default = false,
    Callback = function(v)
        _G.UltraPerfect = v
    end
})

-- === FORCE PERFECT VIA REMOTES (DELTA OK) ===
task.spawn(function()
    while task.wait(0.25) do
        if _G.UltraPerfect then
            pcall(function()
                for _,r in pairs(
                    ReplicatedStorage.Packages
                        ._Index["sleitnick_net@0.2.0"]
                        .net:GetChildren()
                ) do
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

-- === INFO ===
Fishing:AddParagraph({
    Title = "Info",
    Content = "Auto Perfect versi Delta.\nTidak pakai hook / getgc.\nLebih aman untuk Delta."
})

AIKO:MakeNotify({
    Title = "Aikoware",
    Description = "Loaded",
    Content = "Script siap digunakan",
    Delay = 5
})
