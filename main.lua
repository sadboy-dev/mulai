-- DELTA GUI CLEAN EXIT + FISHING MENU

local UIS = game:GetService("UserInputService")
local connections = {}

local function connect(signal, func)
    local c = signal:Connect(func)
    table.insert(connections, c)
    return c
end

local function cleanup()
    for _,c in ipairs(connections) do
        pcall(function() c:Disconnect() end)
    end
    connections = {}
end

-- Parent GUI
local parentGui
pcall(function()
    if gethui then parentGui = gethui() end
end)
if not parentGui then
    parentGui = game:GetService("CoreGui")
end

pcall(function()
    parentGui.DeltaFishingGUI:Destroy()
end)

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "DeltaFishingGUI"
gui.ResetOnSpawn = false
gui.Parent = parentGui

-- Floating Button
local floatBtn = Instance.new("TextButton", gui)
floatBtn.Size = UDim2.new(0,50,0,50)
floatBtn.Position = UDim2.new(0,20,0.5,-25)
floatBtn.Text = "OPEN"
floatBtn.TextScaled = true
floatBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)
floatBtn.TextColor3 = Color3.new(1,1,1)
floatBtn.Visible = false
floatBtn.Active = true
floatBtn.ZIndex = 10
Instance.new("UICorner", floatBtn).CornerRadius = UDim.new(1,0)

-- Drag Floating
do
    local dragging, dragStart, startPos
    connect(floatBtn.InputBegan, function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = i.Position
            startPos = floatBtn.Position
        end
    end)
    connect(floatBtn.InputEnded, function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    connect(UIS.InputChanged, function(i)
        if dragging then
            local d = i.Position - dragStart
            floatBtn.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)
end

-- Main GUI
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,480,0,280)
main.Position = UDim2.new(0.5,-240,0.5,-140)
main.BackgroundColor3 = Color3.fromRGB(30,30,30)
main.BorderSizePixel = 0
main.Active = true

-- Top Bar
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,30)
top.BackgroundColor3 = Color3.fromRGB(20,20,20)
top.Active = true

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,-80,1,0)
title.Position = UDim2.new(0,10,0,0)
title.Text = "Delta GUI"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local mini = Instance.new("TextButton", top)
mini.Size = UDim2.new(0,30,0,30)
mini.Position = UDim2.new(1,-60,0,0)
mini.Text = "-"
mini.BackgroundColor3 = Color3.fromRGB(90,90,90)
mini.TextColor3 = Color3.new(1,1,1)
mini.Active = true

local close = Instance.new("TextButton", top)
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-30,0,0)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(180,0,0)
close.TextColor3 = Color3.new(1,1,1)
close.Active = true

-- Left Menu
local left = Instance.new("Frame", main)
left.Position = UDim2.new(0,0,0,30)
left.Size = UDim2.new(0,120,1,-30)
left.BackgroundColor3 = Color3.fromRGB(25,25,25)

-- Right Content
local right = Instance.new("Frame", main)
right.Position = UDim2.new(0,120,0,30)
right.Size = UDim2.new(1,-120,1,-30)
right.BackgroundColor3 = Color3.fromRGB(40,40,40)

-- Clear Right Panel
local function clearRight()
    for _,v in pairs(right:GetChildren()) do
        if not v:IsA("UIListLayout") then
            v:Destroy()
        end
    end
end

-- Show Fishing Features
local function showFishing()
    clearRight()

    local layout = Instance.new("UIListLayout", right)
    layout.Padding = UDim.new(0,8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = Enum.VerticalAlignment.Center

    local features = {
        "Auto Fish",
        "Instant Catch",
        "No Delay",
        "Auto Sell",
        "Infinite Bait",
        "Safe Mode"
    }

    for _,name in ipairs(features) do
        local btn = Instance.new("TextButton", right)
        btn.Size = UDim2.new(0.8,0,0,30)
        btn.Text = name
        btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Active = true

        connect(btn.Activated, function()
            btn.Text = name.." [ON]"
        end)
    end
end

-- Menu Buttons (9)
for i = 1,9 do
    local btn = Instance.new("TextButton", left)
    btn.Size = UDim2.new(1,-10,0,25)
    btn.Position = UDim2.new(0,5,0,(i-1)*27+5)
    btn.BackgroundColor3 = Color3.fromRGB(55,55,55)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Active = true

    if i == 1 then
        btn.Text = "Fishing"
        connect(btn.Activated, showFishing)
    else
        btn.Text = "Menu "..i
        connect(btn.Activated, function()
            clearRight()
        end)
    end
end

-- Minimize
connect(mini.Activated, function()
    main.Visible = false
    floatBtn.Visible = true
end)

-- Floating Open
connect(floatBtn.Activated, function()
    main.Visible = true
    floatBtn.Visible = false
end)

-- Close = FULL CLEAN
connect(close.Activated, function()
    cleanup()
    gui:Destroy()
end)

-- Drag Main
do
    local dragging, dragStart, startPos
    connect(top.InputBegan, function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = i.Position
            startPos = main.Position
        end
    end)
    connect(top.InputEnded, function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    connect(UIS.InputChanged, function(i)
        if dragging then
            local d = i.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)
end
