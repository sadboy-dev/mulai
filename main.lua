--// Simple Fishing GUI (Executor Friendly)
--// UI Only | Inspired by Chloe X Style

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Destroy if exists
if PlayerGui:FindFirstChild("FishingGUI") then
    PlayerGui.FishingGUI:Destroy()
end

-- GUI
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "FishingGUI"
ScreenGui.ResetOnSpawn = false

-- Main Frame
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 620, 0, 380)
Main.Position = UDim2.new(0.5, -310, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Sidebar
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Sidebar.BorderSizePixel = 0

-- Title
local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "Fishing"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

-- Content
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0, 160, 0, 15)
Content.Size = UDim2.new(1, -175, 1, -30)
Content.BackgroundTransparency = 1

-- UI List
local List = Instance.new("UIListLayout", Content)
List.Padding = UDim.new(0, 10)

-- Toggle Function
local function CreateToggle(text)
    local Toggle = Instance.new("Frame")
    Toggle.Size = UDim2.new(1, 0, 0, 45)
    Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Toggle.BorderSizePixel = 0
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 8)

    local Label = Instance.new("TextLabel", Toggle)
    Label.Text = text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Size = UDim2.new(1, -100, 1, 0)
    Label.TextXAlignment = Left

    local Button = Instance.new("TextButton", Toggle)
    Button.Size = UDim2.new(0, 50, 0, 22)
    Button.Position = UDim2.new(1, -65, 0.5, -11)
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.Text = ""
    Button.BorderSizePixel = 0
    Instance.new("UICorner", Button).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame", Button)
    Circle.Size = UDim2.new(0, 18, 0, 18)
    Circle.Position = UDim2.new(0, 2, 0.5, -9)
    Circle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Circle.BorderSizePixel = 0
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local Enabled = false

    Button.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        if Enabled then
            Button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            Circle.Position = UDim2.new(1, -20, 0.5, -9)
        else
            Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Circle.Position = UDim2.new(0, 2, 0.5, -9)
        end

        -- FUNCTION HERE
        print(text, Enabled)
    end)

    Toggle.Parent = Content
end

-- Toggles (Fishing Support)
CreateToggle("Show Real Ping")
CreateToggle("Show Fishing Panel")
CreateToggle("Auto Equip Rod")
CreateToggle("No Fishing Animations")
CreateToggle("Walk on Water")
CreateToggle("Freeze Player")

-- Footer
local Footer = Instance.new("TextLabel", Main)
Footer.Size = UDim2.new(1, 0, 0, 25)
Footer.Position = UDim2.new(0, 0, 1, -25)
Footer.Text = "Chloe X | UI Mockup"
Footer.TextSize = 12
Footer.Font = Enum.Font.Gotham
Footer.TextColor3 = Color3.fromRGB(120, 120, 120)
Footer.BackgroundTransparency = 1
