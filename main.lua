-- DELTA GUI CLEAN EXIT
-- CLOSE = FULL CLEANUP

local UIS = game:GetService("UserInputService")
local connections = {} -- simpan semua connection

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
    parentGui.DeltaCleanGUI:Destroy()
end)

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "DeltaCleanGUI"
gui.ResetOnSpawn = false
gui.Parent = parentGui

-- ================= FLOATING BUTTON =================
local floatBtn = Instance.new("TextButton")
floatBtn.Parent = gui
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

    connect(floatBtn.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = floatBtn.Position
        end
    end)

    connect(floatBtn.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    connect(UIS.InputChanged, function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.Touch
            or input.UserInputType == Enum.UserInputType.MouseMovement
        ) then
            local delta = input.Position - dragStart
            floatBtn.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- ================= MAIN GUI =================
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

-- Minimize
local mini = Instance.new("TextButton", top)
mini.Size = UDim2.new(0,30,0,30)
mini.Position = UDim2.new(1,-60,0,0)
mini.Text = "-"
mini.BackgroundColor3 = Color3.fromRGB(90,90,90)
mini.TextColor3 = Color3.new(1,1,1)
mini.Active = true

-- Close (FULL CLEAN)
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

local label = Instance.new("TextLabel", right)
label.Size = UDim2.new(1,0,1,0)
label.BackgroundTransparency = 1
label.TextScaled = true
label.TextColor3 = Color3.new(1,1,1)
label.Text = "Pilih Menu"

-- 9 Menu
for i = 1,9 do
    local btn = Instance.new("TextButton", left)
    btn.Size = UDim2.new(1,-10,0,25)
    btn.Position = UDim2.new(0,5,0,(i-1)*27+5)
    btn.Text = "Menu "..i
    btn.BackgroundColor3 = Color3.fromRGB(55,55,55)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Active = true

    connect(btn.Activated, function()
        label.Text = "Isi Menu "..i
    end)
end

-- Minimize → Floating
connect(mini.Activated, function()
    main.Visible = false
    floatBtn.Visible = true
end)

-- Floating → Open
connect(floatBtn.Activated, function()
    main.Visible = true
    floatBtn.Visible = false
end)

-- Close → FULL CLEANUP
connect(close.Activated, function()
    cleanup()
    gui:Destroy()
end)

-- Drag Main GUI
do
    local dragging, dragStart, startPos

    connect(top.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
        end
    end)

    connect(top.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    connect(UIS.InputChanged, function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.Touch
            or input.UserInputType == Enum.UserInputType.MouseMovement
        ) then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end
