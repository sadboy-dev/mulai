-- DELTA FISHING GUI FULL (FINAL VERSION)

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
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

-- Drag Floating Button
do
    local dragging, start, pos
    connect(floatBtn.InputBegan,function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            start = i.Position
            pos = floatBtn.Position
        end
    end)
    connect(UIS.InputChanged,function(i)
        if dragging then
            local d = i.Position - start
            floatBtn.Position = UDim2.new(pos.X.Scale,pos.X.Offset+d.X,pos.Y.Scale,pos.Y.Offset+d.Y)
        end
    end)
    connect(floatBtn.InputEnded,function() dragging = false end)
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
title.Text = "Delta Fishing"
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold

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

local function clearRight()
    for _,v in pairs(right:GetChildren()) do v:Destroy() end
end

-- ===== FISHING PAGE =====
local function showFishing()
    clearRight()

    -- Header
    local header = Instance.new("Frame", right)
    header.Size = UDim2.new(1,0,0,70)
    header.BackgroundTransparency = 1

    local pad = Instance.new("UIPadding", header)
    pad.PaddingTop = UDim.new(0,10)
    pad.PaddingLeft = UDim.new(0,16)

    local h1 = Instance.new("TextLabel", header)
    h1.Size = UDim2.new(1,0,0,28)
    h1.Text = "FISHING"
    h1.TextXAlignment = Enum.TextXAlignment.Left
    h1.TextColor3 = Color3.new(1,1,1)
    h1.Font = Enum.Font.GothamBold
    h1.TextSize = 22
    h1.BackgroundTransparency = 1

    local h2 = Instance.new("TextLabel", header)
    h2.Position = UDim2.new(0,0,0,32)
    h2.Size = UDim2.new(1,0,0,18)
    h2.Text = "Fishing Support"
    h2.TextXAlignment = Enum.TextXAlignment.Left
    h2.TextColor3 = Color3.fromRGB(170,170,170)
    h2.Font = Enum.Font.Gotham
    h2.TextSize = 14
    h2.BackgroundTransparency = 1

    -- Content
    local content = Instance.new("Frame", right)
    content.Position = UDim2.new(0,0,0,70)
    content.Size = UDim2.new(1,0,1,-70)
    content.BackgroundTransparency = 1

    local cpad = Instance.new("UIPadding", content)
    cpad.PaddingLeft = UDim.new(0,16)
    cpad.PaddingRight = UDim.new(0,16)
    cpad.PaddingTop = UDim.new(0,8)

    local layout = Instance.new("UIListLayout", content)
    layout.Padding = UDim.new(0,8)

    local function section(name)
        local btn = Instance.new("TextButton", content)
        btn.Size = UDim2.new(1,0,0,36)
        btn.Text = "  "..name
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.BackgroundColor3 = Color3.fromRGB(55,55,55)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.Gotham
        btn.Active = true

        local arrow = Instance.new("TextLabel", btn)
        arrow.Size = UDim2.new(0,20,1,0)
        arrow.Position = UDim2.new(1,-26,0,0)
        arrow.BackgroundTransparency = 1
        arrow.Text = ">"
        arrow.TextColor3 = Color3.fromRGB(200,200,200)
        arrow.Font = Enum.Font.GothamBold
        arrow.Rotation = 0

        return btn, arrow
    end

    -- Fishing Support Section
    local supportBtn, arrow = section("Fishing Support")
    local open = false

    local sub = Instance.new("Frame", content)
    sub.Size = UDim2.new(1,-10,0,0)
    sub.BackgroundTransparency = 1
    sub.Visible = false
    sub.AutomaticSize = Enum.AutomaticSize.Y

    local subLayout = Instance.new("UIListLayout", sub)
    subLayout.Padding = UDim.new(0,6)

    local function toggle(name)
        local b = Instance.new("TextButton", sub)
        b.Size = UDim2.new(1,0,0,30)
        b.Text = "    "..name.." [OFF]"
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.BackgroundColor3 = Color3.fromRGB(45,45,45)
        b.TextColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.Gotham
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
        sub.Visible = open
        TweenService:Create(
            arrow,
            TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
            {Rotation = open and 90 or 0}
        ):Play()
    end)

    section("Fishing Features")
    section("Instant Features")
    section("Blatant v1 Features")
    section("Blatant v2 Features")
end

-- Left Menu Buttons
for i=1,9 do
    local b = Instance.new("TextButton", left)
    b.Size = UDim2.new(1,-10,0,26)
    b.Position = UDim2.new(0,5,0,(i-1)*28+6)
    b.BackgroundColor3 = Color3.fromRGB(55,55,55)
    b.TextColor3 = Color3.new(1,1,1)
    b.Active = true

    if i == 1 then
        b.Text = "Fishing"
        connect(b.Activated, showFishing)
    else
        b.Text = "Menu "..i
        connect(b.Activated, clearRight)
    end
end

-- Minimize / Open
connect(mini.Activated,function()
    main.Visible = false
    floatBtn.Visible = true
end)

connect(floatBtn.Activated,function()
    main.Visible = true
    floatBtn.Visible = false
end)

-- Close (Clean)
connect(close.Activated,function()
    cleanup()
    gui:Destroy()
end)

-- Drag Main
do
    local drag, start, pos
    connect(top.InputBegan,function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true
            start = i.Position
            pos = main.Position
        end
    end)
    connect(UIS.InputChanged,function(i)
        if drag then
            local d = i.Position - start
            main.Position = UDim2.new(pos.X.Scale,pos.X.Offset+d.X,pos.Y.Scale,pos.Y.Offset+d.Y)
        end
    end)
    connect(top.InputEnded,function() drag = false end)
end
