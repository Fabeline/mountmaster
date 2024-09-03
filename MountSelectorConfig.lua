-- MountSelectorConfig.lua

-- Function to initialize the configuration table
local function InitializeConfig()
    if not MountSelectorCharacterConfig then
        MountSelectorCharacterConfig = {
            colors = {
            },
            types = {
            },
            summonKey = "k"
        }
    end

    summonKey = MountSelectorCharacterConfig.summonKey or "k"
    selectedColors = MountSelectorCharacterConfig.colors or {}
    selectedTypes = MountSelectorCharacterConfig.types or {}
end

function saveSummonKey(key)
    MountSelectorCharacterConfig.summonKey = key
    summonKey = key
end

function saveSelectedColors(colors)
    MountSelectorCharacterConfig.colors = colors
end

function saveSelectedTypes(types)
    MountSelectorCharacterConfig.types = types
end

-- Event handler for when the addon is loaded and mount data is available
local function OnEvent(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "MountSelector" then
            print("MountSelector loaded")
        end
    end
    if event == "PLAYER_LOGIN" then
        InitializeConfig()
        renderMounts()
        loadSummoningKey()
        UIDropDownMenu_SetText(skeletonDropdown, "Select types")
        UIDropDownMenu_SetText(colorDropdown, "Select colors")
    end
end

-- Create a frame to listen for events
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", OnEvent)
