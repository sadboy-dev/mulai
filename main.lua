--// DELTA FRIENDLY FISHING GUI

local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "FishingGUI"
gui.Parent = plr:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- Main Frame
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0, 600, 0, 360)
main.Position = UDim2.new(0.5, -300, 0.5, -180)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

-- Sidebar
local side = Instance.new("Frame")
side.Parent = main
side.Size = UDim2.new(0, 150, 1, 0)
side.BackgroundColor3 = Color3.fromRGB(18,18,18)
side.BorderSizePixel = 0

-- Title
local title = Instance.new("TextLabel")
title.Parent = side
title.Size = UDim2.new(1,0,0,50)
title.Text = "Fishing"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(0,170,255)
title.BackgroundTransparency = 1

-- Content
local content = Instance.new("Frame")
content.Parent = main
content.Position = UDim2.new(0,160,0,20)
content.Size = UDim2.new(1,-170,1,-40)
content.BackgroundTransparency = 1

-- Toggle creator (manual Y)
local function Toggle(text, y)
    local frame = Instance.new("Frame")
    frame.Parent = content
    frame.Size = UDim2.new(1,0,0,40)
    frame.Position = UDim2.new(0,0,0,y)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    frame.BorderSizePixel = 0

    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Position = UDim2.new(0,10,0,0)
    label.Size = UDim2.new(1,-80,1,0)
    label.Text = text
    label.Font = Enum.Font.SourceSans
    label.TextSize = 16
    label.TextColor3 = Color3.fromRGB(220,220,220)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1

    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.Size = UDim2.new(0,50,0,22)
    btn.Position = UDim2.new(1,-60,0.5,-11)
    btn.Text = "OFF"
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    btn.BorderSizePixel = 0

    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        if on then
            btn.Text = "ON"
            btn.BackgroundColor3 = Color3.fromRGB(0,170,255)
        else
            btn.Text = "OFF"
            btn.BackgroundColor3 = Color3.fromRGB(80,80,80)
        end
        print(text, on)
    end)
end

-- Toggles
Toggle("Show Real Ping", 0)
Toggle("Show Fishing Panel", 50)
Toggle("Auto Equip Rod", 100)
Toggle("No Fishing Animations", 150)
Toggle("Walk on Water", 200)
Toggle("Freeze Player", 250)
