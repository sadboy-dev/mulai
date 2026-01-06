--==================================================
--  FISHIT | CHLOE X STYLE HUB
--  Delta Executor Optimized (Android Safe)
--==================================================

local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "ChloeX_Fishit"
gui.ResetOnSpawn = false

--------------------------------------------------
-- VARIABLES
--------------------------------------------------
local AutoFishing = false
local FishingSpeed = 0.22 -- FAST & SAFE

--------------------------------------------------
-- MAIN GUI
--------------------------------------------------
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,620,0,380)
main.Position = UDim2.new(0.5,-310,0.5,-190)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

-- Sidebar
local side = Instance.new("Frame", main)
side.Size = UDim2.new(0,150,1,0)
side.BackgroundColor3 = Color3.fromRGB(18,18,18)
side.BorderSizePixel = 0

local function SideBtn(txt,y)
    local b = Instance.new("TextButton", side)
    b.Size = UDim2.new(1,0,0,40)
    b.Position = UDim2.new(0,0,0,y)
    b.Text = txt
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 16
    b.TextColor3 = Color3.fromRGB(200,200,200)
    b.BackgroundColor3 = Color3.fromRGB(18,18,18)
    b.BorderSizePixel = 0
    return b
end

local btnFishing  = SideBtn("Fishing",60)
local btnTeleport = SideBtn("Teleport",100)
local btnMisc     = SideBtn("Misc",140)

--------------------------------------------------
-- TABS
--------------------------------------------------
local function CreateTab()
    local f = Instance.new("Frame", main)
    f.Position = UDim2.new(0,160,0,15)
    f.Size = UDim2.new(1,-175,1,-30)
    f.BackgroundTransparency = 1
    f.Visible = false

    local s = Instance.new("ScrollingFrame", f)
    s.Size = UDim2.new(1,0,1,0)
    s.CanvasSize = UDim2.new(0,0,0,0)
    s.ScrollBarImageTransparency = 0.4
    s.BackgroundTransparency = 1
    s.BorderSizePixel = 0
    return f,s
end

local tabFishing, scrollFishing   = CreateTab()
local tabTeleport, scrollTeleport = CreateTab()
local tabMisc, scrollMisc         = CreateTab()
tabFishing.Visible = true

local function Switch(tab)
    tabFishing.Visible=false
    tabTeleport.Visible=false
    tabMisc.Visible=false
    tab.Visible=true
end

btnFishing.MouseButton1Click:Connect(function() Switch(tabFishing) end)
btnTeleport.MouseButton1Click:Connect(function() Switch(tabTeleport) end)
btnMisc.MouseButton1Click:Connect(function() Switch(tabMisc) end)

--------------------------------------------------
-- UI ELEMENTS
--------------------------------------------------
local function Toggle(parent,text,y,callback)
    local f = Instance.new("Frame",parent)
    f.Size = UDim2.new(1,-10,0,40)
    f.Position = UDim2.new(0,5,0,y)
    f.BackgroundColor3 = Color3.fromRGB(35,35,35)
    f.BorderSizePixel = 0

    local l = Instance.new("TextLabel",f)
    l.Text=text
    l.Font=Enum.Font.SourceSans
    l.TextSize=15
    l.TextColor3=Color3.fromRGB(230,230,230)
    l.BackgroundTransparency=1
    l.Position=UDim2.new(0,10,0,0)
    l.Size=UDim2.new(1,-90,1,0)
    l.TextXAlignment=Enum.TextXAlignment.Left

    local b=Instance.new("TextButton",f)
    b.Size=UDim2.new(0,50,0,22)
    b.Position=UDim2.new(1,-60,0.5,-11)
    b.Text="OFF"
    b.Font=Enum.Font.SourceSansBold
    b.TextSize=14
    b.TextColor3=Color3.new(1,1,1)
    b.BackgroundColor3=Color3.fromRGB(80,80,80)
    b.BorderSizePixel=0

    local on=false
    b.MouseButton1Click:Connect(function()
        on=not on
        b.Text=on and "ON" or "OFF"
        b.BackgroundColor3=on and Color3.fromRGB(0,170,255) or Color3.fromRGB(80,80,80)
        if callback then callback(on) end
    end)
end

local function Dropdown(parent,text,y)
    local open=false
    local btn=Instance.new("TextButton",parent)
    btn.Size=UDim2.new(1,-10,0,40)
    btn.Position=UDim2.new(0,5,0,y)
    btn.Text="  "..text.."  ▼"
    btn.Font=Enum.Font.SourceSansBold
    btn.TextSize=15
    btn.TextXAlignment=Enum.TextXAlignment.Left
    btn.TextColor3=Color3.fromRGB(200,200,200)
    btn.BackgroundColor3=Color3.fromRGB(30,30,30)
    btn.BorderSizePixel=0

    local cont=Instance.new("Frame",parent)
    cont.Position=UDim2.new(0,5,0,y+40)
    cont.Size=UDim2.new(1,-10,0,0)
    cont.BackgroundTransparency=1
    cont.ClipsDescendants=true

    btn.MouseButton1Click:Connect(function()
        open=not open
        cont.Size=open and UDim2.new(1,-10,0,120) or UDim2.new(1,-10,0,0)
        btn.Text=open and "  "..text.."  ▲" or "  "..text.."  ▼"
    end)

    return function(name,offset,cb)
        Toggle(cont,name,offset,cb)
    end
end

--------------------------------------------------
-- FISHIT LOGIC
--------------------------------------------------
local function getRod()
    local c=plr.Character
    if not c then return end
    for _,v in pairs(c:GetChildren()) do
        if v:IsA("Tool") and v.Name:lower():find("rod") then return v end
    end
    for _,v in pairs(plr.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.Name:lower():find("rod") then return v end
    end
end

local function waitForBite(rod,timeout)
    local bite=false
    local a=rod.AttributeChanged:Connect(function() bite=true end)
    local c=rod.ChildAdded:Connect(function() bite=true end)
    local t=tick()
    while tick()-t<timeout do
        if bite then break end
        for _,v in pairs(rod:GetDescendants()) do
            if (v:IsA("BoolValue") and v.Value)
            or (v:IsA("NumberValue") and v.Value>0) then
                bite=true break
            end
        end
        task.wait(0.05)
    end
    a:Disconnect() c:Disconnect()
    return bite
end

local function perfectReel(rod,dur)
    local start=tick()
    local last=0
    while tick()-start<dur do
        for _,v in pairs(rod:GetDescendants()) do
            if v:IsA("NumberValue") and v.Value>last then
                last=v.Value
                pcall(function() rod:Activate() end)
            end
        end
        task.wait(0.05)
    end
end

task.spawn(function()
    while task.wait(FishingSpeed) do
        if not AutoFishing then continue end
        local c=plr.Character
        local h=c and c:FindFirstChildOfClass("Humanoid")
        local r=getRod()
        if not (h and r) then continue end
        if r.Parent~=c then h:EquipTool(r) task.wait(0.25) end
        pcall(function() r:Activate() end)
        if waitForBite(r,2.2) then
            perfectReel(r,1.6)
        end
    end
end)

--------------------------------------------------
-- FISHING TAB UI
--------------------------------------------------
local drop=Dropdown(scrollFishing,"Fishing Support",0)
drop("Auto Fishing",0,function(v) AutoFishing=v end)
drop("Speed Fishing",50,function(v) FishingSpeed=v and 0.22 or 0.35 end)
scrollFishing.CanvasSize=UDim2.new(0,0,0,200)

--------------------------------------------------
-- TELEPORT
--------------------------------------------------
Toggle(scrollTeleport,"Teleport Spawn",0,function()
    local c=plr.Character
    if c and c:FindFirstChild("HumanoidRootPart") and workspace:FindFirstChild("SpawnLocation") then
        c.HumanoidRootPart.CFrame=workspace.SpawnLocation.CFrame+Vector3.new(0,3,0)
    end
end)
scrollTeleport.CanvasSize=UDim2.new(0,0,0,100)

--------------------------------------------------
-- MISC
--------------------------------------------------
Toggle(scrollMisc,"Freeze Player",0,function(v)
    local c=plr.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        c.HumanoidRootPart.Anchored=v
    end
end)
scrollMisc.CanvasSize=UDim2.new(0,0,0,100)
