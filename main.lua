-- DELTA FISHING GUI FULL VERSION (CLEAN + ACCORDION)

local UIS = game:GetService("UserInputService")
local connections = {}

local function connect(sig, fn)
    local c = sig:Connect(fn)
    table.insert(connections, c)
    return c
end

local function cleanup()
    for _,c in ipairs(connections) do
        pcall(function() c:Disconnect() end)
    end
    connections = {}
end

-- Parent GUI (Delta Safe)
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

-- Drag Floating Button
do
    local dragging, dragStart, startPos
    connect(floatBtn.InputBegan,function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = i.Position
            startPos = floatBtn.Position
        end
    end)
    connect(floatBtn.InputEnded,function()
        dragging = false
    end)
    connect(UIS.InputChanged,function(i)
        if dragging then
            local d = i.Position - dragStart
            floatBtn.Position = UDim2.new(
                startPos.X.Scale,startPos.X.Offset+d.X,
                startPos.Y.Scale,startPos.Y.Offset+d.Y
            )
        end
    end)
end

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,480,0,320)
main.Position = UDim2.new(0.5,-240,0.5,-160)
main.BackgroundColor3 = Color3.fromRGB(30,30,30)
main.BorderSizePixel = 0
main.Active = true

-- Top Bar
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,32)
top.BackgroundColor3 = Color3.fromRGB(20,20,20)
top.Active = true

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,-80,1,0)
title.Position = UDim2.new(0,10,0,0)
title.Text = "Fishing"
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local mini = Instance.new("TextButton", top)
mini.Size = UDim2.new(0,30,0,32)
mini.Position = UDim2.new(1,-60,0,0)
mini.Text = "-"
mini.BackgroundColor3 = Color3.fromRGB(90,90,90)
mini.TextColor3 = Color3.new(1,1,1)
mini.Active = true

local close = Instance.new("TextButton", top)
close.Size = UDim2.new(0,30,0,32)
close.Position = UDim2.new(1,-30,0,0)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(180,0,0)
close.TextColor3 = Color3.new(1,1,1)
close.Active = true

-- Left Menu
local left = Instance.new("Frame", main)
left.Position = UDim2.new(0,0,0,32)
left.Size = UDim2.new(0,130,1,-32)
left.BackgroundColor3 = Color3.fromRGB(25,25,25)

-- Right Content
local right = Instance.new("Frame", main)
right.Position = UDim2.new(0,130,0,32)
right.Size = UDim2.new(1,-130,1,-32)
right.BackgroundColor3 = Color3.fromRGB(40,40,40)

-- Clear Right
local function clearRight()
    for _,v in pairs(right:GetChildren()) do
        v:Destroy()
    end
end

-- ===== FISHING PAGE =====
local function showFishing()
    clearRight()

    local pad = Instance.new("UIPadding", right)
    pad.PaddingTop = UDim.new(0,12)
    pad.PaddingLeft = UDim.new(0,16)
    pad.PaddingRight = UDim.new(0,16)

    local layout = Instance.new("UIListLayout", right)
    layout.Padding = UDim.new(0,8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    -- Header
    local header = Instance.new("TextLabel", right)
    header.Size = UDim2.new(1,0,0,26)
    header.BackgroundTransparency = 1
    header.Text = "Fishing"
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.TextColor3 = Color3.new(1,1,1)
    header.Font = Enum.Font.GothamBold
    header.TextSize = 20

    local sub = Instance.new("TextLabel", right)
    sub.Size = UDim2.new(1,0,0,18)
    sub.BackgroundTransparency = 1
    sub.Text = "Fishing Support"
    sub.TextXAlignment = Enum.TextXAlignment.Left
    sub.TextColor3 = Color3.fromRGB(170,170,170)
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 14

    local function section(name)
        local btn = Instance.new("TextButton", right)
        btn.Size = UDim2.new(1,0,0,36)
        btn.BackgroundColor3 = Color3.fromRGB(55,55,55)
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.Gotham
        btn.Text = "  "..name
        btn.Active = true

        local arrow = Instance.new("TextLabel", btn)
        arrow.Size = UDim2.new(0,20,1,0)
        arrow.Position = UDim2.new(1,-22,0,0)
        arrow.BackgroundTransparency = 1
        arrow.Text = ">"
        arrow.TextColor3 = Color3.fromRGB(200,200,200)
        arrow.Font = Enum.Font.GothamBold

        return btn
    end

    -- Fishing Support Section
    local supportBtn = section("Fishing Support")
    local open = false

    local subBox = Instance.new("Frame", right)
    subBox.Size = UDim2.new(1,-10,0,0)
    subBox.BackgroundTransparency = 1
    subBox.Visible = false
    subBox.AutomaticSize = Enum.AutomaticSize.Y

    local subLayout = Instance.new("UIListLayout", subBox)
    subLayout.Padding = UDim.new(0,6)

    local function toggle(name)
        local b = Instance.new("TextButton", subBox)
        b.Size = UDim2.new(1,0,0,30)
        b.BackgroundColor3 = Color3.fromRGB(45,45,45)
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.TextColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.Gotham
        b.Text = "    "..name.." [OFF]"
        b.Active = true

        local on = false
        connect(b.Activated,function()
            on = not on
            b.Text = "    "..name..(on and " [ON]" or " [OFF]")
        end)
    end

    toggle("Auto Equip Rod")
    toggle("No Fishing Animation")
    toggle("Walk on Water")
    toggle("Show Real Ping")

    connect(supportBtn.Activated,function()
        open = not open
        subBox.Visible = open
    end)

    section("Fishing Features")
    section("Instant Features")
    section("Blatant v1 Features")
    section("Blatant v2 Features")
end

-- Left Menu Buttons (9)
for i = 1,9 do
    local btn = Instance.new("TextButton", left)
    btn.Size = UDim2.new(1,-10,0,26)
    btn.Position = UDim2.new(0,5,0,(i-1)*28+6)
    btn.BackgroundColor3 = Color3.fromRGB(55,55,55)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Active = true

    if i == 1 then
        btn.Text = "Fishing"
        connect(btn.Activated, showFishing)
    else
        btn.Text = "Menu "..i
        connect(btn.Activated, clearRight)
    end
end

-- Minimize → Floating
connect(mini.Activated,function()
    main.Visible = false
    floatBtn.Visible = true
end)

-- Floating → Open
connect(floatBtn.Activated,function()
    main.Visible = true
    floatBtn.Visible = false
end)

-- Close → FULL CLEAN
connect(close.Activated,function()
    cleanup()
    gui:Destroy()
end)

-- Drag Main GUI
do
    local dragging, dragStart, startPos
    connect(top.InputBegan,function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = i.Position
            startPos = main.Position
        end
    end)
    connect(top.InputEnded,function()
        dragging = false
    end)
    connect(UIS.InputChanged,function(i)
        if dragging then
            local d = i.Position - dragStart
            main.Position = UDim2.new(
                startPos.X.Scale,startPos.X.Offset+d.X,
                startPos.Y.Scale,startPos.Y.Offset+d.Y
            )
        end
    end)
end
