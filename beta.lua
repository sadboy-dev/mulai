-- FAST BLATANT + AUTO FISH | DELTA SAFE | NO LIB
warn("[Aikoware] FAST BLATANT AUTO FISH START")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

_G.AutoFishPerfect = false

-- ================= GUI =================
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "AikowareFast"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.26, 0.22)
frame.Position = UDim2.fromScale(0.37, 0.39)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active, frame.Draggable = true, true

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0.3,0)
title.BackgroundTransparency = 1
title.Text = "Aikoware | FAST"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.new(1,1,1)

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0.85,0,0.35,0)
btn.Position = UDim2.fromScale(0.075,0.52)
btn.Text = "AUTO FISH + PERFECT : OFF"
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14
btn.BackgroundColor3 = Color3.fromRGB(170,0,0)
btn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

btn.MouseButton1Click:Connect(function()
    _G.AutoFishPerfect = not _G.AutoFishPerfect
    if _G.AutoFishPerfect then
        btn.Text = "AUTO FISH + PERFECT : ON"
        btn.BackgroundColor3 = Color3.fromRGB(0,170,0)
    else
        btn.Text = "AUTO FISH + PERFECT : OFF"
        btn.BackgroundColor3 = Color3.fromRGB(170,0,0)
    end
end)

-- ================= AUTO FISH =================
task.spawn(function()
    while task.wait(0.25) do
        if not _G.AutoFishPerfect then continue end

        local char = game.Players.LocalPlayer.Character
        if not char then continue end

        local tool = char:FindFirstChildOfClass("Tool")
        if not tool then continue end

        -- cari remote di dalam rod
        for _,v in pairs(tool:GetDescendants()) do
            if v:IsA("RemoteEvent") then
                local n = v.Name:lower()
                if n:find("fish")
                or n:find("cast")
                or n:find("start")
                or n:find("use") then
                    pcall(function()
                        v:FireServer()
                    end)
                end
            end
        end
    end
end)
