warn("[Aikoware] FINAL FIX START")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- LOAD LIBRARY
local AIKO = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/sadboy-dev/mulai/refs/heads/main/libary.lua"
))()

-- WINDOW
local Window = AIKO:Window({
    Title = "Aikoware | Fish It",
    Footer = "Delta Final Fix",
    Version = 1
})

-- === GLOBAL FLAG ===
_G.UltraPerfect = false

-- === ADD TOGGLE LANGSUNG (TANPA TAB) ===
Window:AddToggle({
    Title = "Auto Perfect (Delta)",
    Description = "Force server perfect",
    Default = false,
    Callback = function(v)
        _G.UltraPerfect = v
    end
})

-- === FORCE PERFECT (DELTA SAFE) ===
task.spawn(function()
    while task.wait(0.3) do
        if _G.UltraPerfect then
            pcall(function()
                local net = ReplicatedStorage:FindFirstChild("Packages")
                if not net then return end

                for _,v in pairs(net:GetDescendants()) do
                    if v:IsA("RemoteEvent") then
                        local n = v.Name:lower()
                        if n:find("fish")
                        or n:find("catch")
                        or n:find("perfect")
                        or n:find("complete") then
                            v:FireServer("Perfect", true, 100)
                        end
                    end
                end
            end)
        end
    end
end)

-- INFO
Window:AddParagraph({
    Title = "Status",
    Content = "GUI aktif\nFitur aktif\nDelta compatible"
})

AIKO:MakeNotify({
    Title = "Aikoware",
    Description = "Loaded",
    Content = "Fitur sudah muncul",
    Delay = 4
})
