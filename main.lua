-- Memuat UI Library (Rayfield) yang kompatibel dengan Delta
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Membuat Window Utama
local Window = Rayfield:CreateWindow({
    Name = "Chloex v1.1.0 | Fishing Module",
    LoadingTitle = "Chloex System",
    LoadingSubtitle = "by Assistant",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil, -- Nama folder custom jika ingin save config
        FileName = "ChloexConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink", -- Link Discord jika ada
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "Chloex Key",
        Subtitle = "Key System",
        Note = "No Key Needed",
        FileName = "ChloexKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Hello"}
    }
})

-- Membuat Tab "Info"
local InfoTab = Window:CreateTab("Info", 4483362458) -- Icon ID opsional

InfoTab:CreateLabel("Welcome to Chloex v1.1.0")
InfoTab:CreateLabel("Status: Undetected")
InfoTab:CreateLabel("Game: Supported")

-- Label Real Ping (Update otomatis)
local PingLabel = InfoTab:CreateLabel("Ping: Calculating...")

spawn(function()
    while true do
        wait(1)
        local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        PingLabel:Set("Real Ping: " .. ping)
    end
end)

-- Membuat Tab "Fishing"
local FishingTab = Window:CreateTab("Fishing", 4483362458)

-- Section: Fishing Support
local Section = FishingTab:CreateSection("Fishing Support")

-- Fitur: Auto Equip Rod
Rayfield:Notify({
    Title = "Chloex Loaded",
    Content = "Fishing Module Ready.",
    Duration = 5,
    Image = 4483362458
})

local AutoRodToggle = FishingTab:CreateToggle({
    Name = "Auto Equip Rod",
    CurrentValue = false,
    Flag = "AutoRod",
    Callback = function(Value)
        _G.AutoRod = Value
        if Value then
            spawn(function()
                while _G.AutoRod do
                    wait(1)
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    local backpack = player.Backpack

                    -- Logika untuk mencari Rod (bisa disesuaikan nama tool-nya)
                    if character and not character:FindFirstChildWhichIsA("Tool") then
                        for _, tool in pairs(backpack:GetChildren()) do
                            if string.find(tool.Name:lower(), "rod") or string.find(tool.Name:lower(), "fishing") then
                                character.Humanoid:EquipTool(tool)
                                break
                            end
                        end
                    end
                end
            end)
        end
    end
})

-- Fitur: No Fishing Animations
FishingTab:CreateToggle({
    Name = "No Fishing Animations",
    CurrentValue = false,
    Flag = "NoAnim",
    Callback = function(Value)
        _G.NoAnim = Value
        if Value then
            -- Menghentikan animasi karakter lokal
            local player = game.Players.LocalPlayer
            if player.Character:FindFirstChild("Animate") then
                player.Character.Animate:Destroy()
            end
        end
    end
})

-- Section: Fishing Features (Extra)
local Section2 = FishingTab:CreateSection("Fishing Features")

-- Fitur: Walk on Water (Simulasi Noclip di atas air)
FishingTab:CreateToggle({
    Name = "Walk on Water",
    CurrentValue = false,
    Flag = "WaterWalk",
    Callback = function(Value)
        _G.WaterWalk = Value
        spawn(function()
            while _G.WaterWalk do
                wait()
                local player = game.Players.LocalPlayer
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    -- Jika posisi Y rendah (di dalam air), dorong ke atas
                    if player.Character.HumanoidRootPart.Position.Y < 5 then -- Sesuaikan tinggi air
                        player.Character.HumanoidRootPart.Velocity = Vector3.new(player.Character.HumanoidRootPart.Velocity.X, 20, player.Character.HumanoidRootPart.Velocity.Z)
                        player.Character.Humanoid:ChangeState("Jumping")
                    end
                end
            end
        end)
    end
})

-- Fitur: Freeze Player
FishingTab:CreateToggle({
    Name = "Freeze Player",
    CurrentValue = false,
    Flag = "Freeze",
    Callback = function(Value)
        _G.Freeze = Value
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if Value then
                player.Character.HumanoidRootPart.Anchored = true
            else
                player.Character.HumanoidRootPart.Anchored = false
            end
        end
    end
})

-- Tab Tambahan: Automatically (Opsional untuk kelengkapan UI)
local AutoTab = Window:CreateTab("Automatically", 4483362458)
AutoTab:CreateSection("Auto Farm")
AutoTab:CreateButton({
    Name = "Coming Soon",
    Callback = function()
        Rayfield:Notify({
            Title = "Info",
            Content = "Fitur ini akan hadir di update berikutnya.",
            Duration = 3,
        })
    end
})
