--[[
FIXED beta.lua
Tujuan: memastikan SCRIPT SELALU MUNCUL (UI tampil)
Strategi: loader aman (pcall) + fallback + notifikasi
--]]

-- === BOOTSTRAP (ANTI-CRASH) ===
warn("[Aikoware] beta.lua start")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function notify(title, desc, content)
    pcall(function()
        local AIKO = _G.AIKO
        if AIKO and AIKO.MakeNotify then
            AIKO:MakeNotify({ Title = title, Description = desc, Content = content, Delay = 4 })
        else
            warn(title, desc, content)
        end
    end)
end

-- === SAFE HTTP GET ===
local function safeLoad(url)
    local ok, res = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not ok then
        warn("[Aikoware] Failed to load:", url)
        warn(res)
        return nil, res
    end
    return res
end

-- === LOAD UI LIBRARY (WAJIB) ===
local AIKO, err = safeLoad("https://raw.githubusercontent.com/sadboy-dev/mulai/refs/heads/main/libary.lua")
if not AIKO then
    notify("Aikoware", "Error", "Library gagal load. Cek URL / koneksi.")
    return
end

_G.AIKO = AIKO

-- === WINDOW ===
local Window = AIKO:Window({
    Title   = "Aikoware | Fish It",
    Footer  = "beta (fixed)",
    Version = 1,
})

notify("Aikoware", "Status", "UI berhasil dibuat")

-- === LOAD MAIN SCRIPT DENGAN AMAN ===
-- Semua fitur (termasuk Ultra Perfect) ada di main.lua
local MAIN_URL = "https://raw.githubusercontent.com/sadboy-dev/mulai/refs/heads/main/main.lua"

local ok, mainErr = pcall(function()
    loadstring(game:HttpGet(MAIN_URL))()
end)

if not ok then
    notify("Aikoware", "Error", "main.lua gagal load. Cek console.")
    warn(mainErr)
    return
end

notify("Aikoware", "Loaded", "Script siap digunakan")

-- === GUARD: cegah silent crash ===
LocalPlayer.CharacterAdded:Connect(function()
    warn("[Aikoware] CharacterAdded")
end)
