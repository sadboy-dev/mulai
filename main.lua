-- DELTA GUI FINAL FIX
-- BUTTONS WORKING (Activated)

local parentGui
pcall(function()
    if gethui then parentGui = gethui() end
end)
if not parentGui then
    parentGui = game:GetService("CoreGui")
end

pcall(function()
    parentGui.DeltaFinalGUI:Destroy()
end)

local gui = Instance.new("ScreenGui")
gui.Name = "DeltaFinalGUI"
gui.ResetOnSpawn = false
gui.Parent = parentGui

-- Main Frame
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,480,0,280)
main.Position = UDim2.new(0.5,-240,0.5,-140)
main.BackgroundColor3 = Color3.fromRGB(30,30,30)
main.BorderSizePixel = 0
main.Active = true
main.ZIndex = 1

-- Top Bar
local top = Instance.new("Frame")
top.Parent = main
top.Size = UDim2.new(1,0,0,30)
top.BackgroundColor3 = Color3.fromRGB(20,20,20)
top.Active = true
top.ZIndex = 2

-- Title
local title = Instance.new("TextLabel")
title.Parent = top
title.Size = UDim2.new(1,-80,1,0)
title.Position = UDim2.new(0,10,0,0)
title.Text = "Delta GUI"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 3

-- Minimize Button
local mini = Instance.new("TextButton")
mini.Parent = top
mini.Size = UDim2.new(0,30,0,30)
mini.Position = UDim2.new(1,-60,0,0)
mini.Text = "-"
mini.BackgroundColor3 = Color3.fromRGB(90,90,90)
mini.TextColor3 = Color3.new(1,1,1)
mini.Active = true
mini.ZIndex = 4

-- Close Button
local close = Instance.new("TextButton")
close.Parent = top
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-30,0,0)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(180,0,0)
close.TextColor3 = Color3.new(1,1,1)
close.Active = true
close.ZIndex = 4

-- Left Menu
local left = Instance.new("Frame")
left.Parent = main
left.Position = UDim2.new(0,0,0,30)
left.Size = UDim2.new(0,120,1,-30)
left.BackgroundColor3 = Color3.fromRGB(25,25,25)
left.ZIndex = 1

-- Right Content
local right = Instance.new("Frame")
right.Parent = main
right.Position = UDim2.new(0,120,0,30)
right.Size = UDim2.new(1,-120,1,-30)
right.BackgroundColor3 = Color3.fromRGB(40,40,40)
right.ZIndex = 1

local label = Instance.new("TextLabel")
label.Parent = right
label.Size = UDim2.new(1,0,1,0)
label.BackgroundTransparency = 1
label.TextScaled = true
label.TextColor3 = Color3.new(1,1,1)
label.Text = "Pilih Menu"
label.ZIndex = 2

-- Menu Buttons
for i = 1,10 do
    local btn = Instance.new("TextButton")
    btn.Parent = left
    btn.Size = UDim2.new(1,-10,0,25)
    btn.Position = UDim2.new(0,5,0,(i-1)*27+5)
    btn.Text = "Menu "..i
    btn.BackgroundColor3 = Color3.fromRGB(55,55,55)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Active = true
    btn.ZIndex = 2

    btn.Activated:Connect(function()
        label.Text = "Isi Menu "..i
    end)
end

-- FUNCTIONS
local minimized = false

mini.Activated:Connect(function()
    minimized = not minimized
    left.Visible = not minimized
    right.Visible = not minimized
    main.Size = minimized and UDim2.new(0,480,0,30) or UDim2.new(0,480,0,280)
end)

close.Activated:Connect(function()
    gui:Destroy()
end)
