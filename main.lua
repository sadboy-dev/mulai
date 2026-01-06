-- Memuat Rayfield UI Library (Kompatibel dengan Delta)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Membuat Window
local Window = Rayfield:CreateWindow({
    Name = "Fish It Hub | v2.0",
    LoadingTitle = "Fish It Automation",
    LoadingSubtitle = "Sedang memuat modul...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "FishItHub",
        FileName = "ConfigFish"
    },
    Discord = {
        Enabled = false,
        Invite = "discord.gg/place", -- Ganti dengan link discord kamu jika ada
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "Fish It Key",
        Subtitle = "Key System",
        Note = "No Key Required",
        FileName = "FishItKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"1234"}
    }
})

-- Notifikasi saat script dimuat
Rayfield:Notify({
    Title = "Fish It Hub",
    Content = "Script berhasil dimuat! Selamat memancing.",
    Duration = 5,
    Image = 4483362458
})

-- TAB UTAMA: FISHING
local MainTab = Window:CreateTab("Main Fishing", 4483362458)

local Section = MainTab:CreateSection("Auto Farming")

-- Fitur 1: Auto Farm (Mekanisme Melempar & Menarik)
local AutoFarmEnabled = false

MainTab:CreateToggle({
    Name = "Auto Farm (Cast & Reel)",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value)
        AutoFarmEnabled = Value
        
        if AutoFarmEnabled then
            spawn(function()
                while AutoFarmEnabled do
                    local player = game.Players.LocalPlayer
                    local mouse = player:GetMouse()
                    
                    -- Pastikan karakter ada
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        -- Simulasi Klik Kiri untuk Melempar (Cast)
                        mouse1click()
                        
                        -- Tunggu waktu random agar terlihat natural (antara 3 hingga 6 detik)
                        -- Waktu ini biasanya cukup untuk ikan memakan umpan
                        local waitTime = math.random(3, 6)
                        
                        -- Loop cek visual "Bite" (Opsional: Cek GUI "!" jika ada)
                        -- Di sini kita pakai timer tunggu sederhana yang efektif
                        wait(waitTime)
                        
                        if AutoFarmEnabled then
                            -- Simulasi Klik Kiri lagi untuk Menarik (Reel)
                            mouse1click()
                            
                            -- Jeda sebentar sebelum lempar lagi
                            wait(1) 
                        end
                    else
                        wait(2)
                    end
                end
            end)
        end
    end
})

-- Fitur 2: Auto Equip Rod
local AutoEquipEnabled = false

MainTab:CreateToggle({
    Name = "Auto Equip Rod",
    CurrentValue = false,
    Flag = "AutoEquip",
    Callback = function(Value)
        AutoEquipEnabled = Value
        
        if AutoEquipEnabled then
            spawn(function()
                while AutoEquipEnabled do
                    wait(1)
                    local player = game.Players.LocalPlayer
                    local char = player.Character
                    local backpack = player.Backpack
                    
                    -- Jika tidak memegang alat apapun
                    if char and not char:FindFirstChildWhichIsA("Tool") then
                        -- Cari Rod di Backpack
                        for _, tool in pairs(backpack:GetChildren()) do
                            -- Mencari nama alat yang mengandung "Rod", "Net", atau "Fishing"
                            if string.find(tool.Name:lower(), "rod") or 
                               string.find(tool.Name:lower(), "net") or 
                               string.find(tool.Name:lower(), "fishing") then
                                char.Humanoid:EquipTool(tool)
                                break
                            end
                        end
                    end
                end
            end)
        end
    end
})

-- TAB KEDUA: PLAYER & MISC
local PlayerTab = Window:CreateTab("Player & Misc", 4483362458)

local Section2 = PlayerTab:CreateSection("Character Stats")

-- Fitur 3: Walk Speed
PlayerTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 200},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "SpeedSlider",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = Value
        end
    end
})

-- Fitur 4: Jump Power
PlayerTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 300},
    Increment = 10,
    Suffix = "Power",
    CurrentValue = 50,
    Flag = "JumpSlider",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = Value
        end
    end
})

local Section3 = PlayerTab:CreateSection("Utilities")

-- Fitur 5: Infinite Jump
PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJump",
    Callback = function(Value)
        _G.InfiniteJumpEnabled = Value
        
        if Value then
            game:GetService("UserInputService").JumpRequest:connect(function()
                if _G.InfiniteJumpEnabled then
                    game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
                end
            end)
        end
    end
})
