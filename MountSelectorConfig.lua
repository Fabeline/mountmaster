-- MountSelectorConfig.lua

-- Function to initialize the configuration table
local function InitializeConfig()
    if not MountSelectorCharacterConfig then
        MountSelectorCharacterConfig = {}
    end

    -- Load the last selected color filter, default to "All" if not set
    local lastColor = MountSelectorCharacterConfig.lastSelectedColor or "All"
    local lastSkeleton = MountSelectorCharacterConfig.lastSelectedSkeleton or "All"
end

-- Function to save the selected color filter
function SaveColorFilter(color)
    MountSelectorCharacterConfig.lastSelectedColor = color
end

-- Function to save the selected color filter
function SaveSkeletonFilter(skeleton)
    MountSelectorCharacterConfig.lastSelectedSkeleton = skeleton
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
        playerLoggedIn = true
        InitializeConfig()
        selectedColor = MountSelectorCharacterConfig.lastSelectedColor or "All"
        selectedSkeleton = MountSelectorCharacterConfig.lastSelectedSkeleton or "All"
        renderMounts()
    end
end

-- Create a frame to listen for events
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", OnEvent)
