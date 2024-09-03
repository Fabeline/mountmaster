-- MountSelectorConfig.lua

-- Function to initialize the configuration table
local function InitializeConfig()
    if not MountSelectorCharacterConfig then
        MountSelectorCharacterConfig = {
            lastSelectedColor = "All",
            lastSelectedSkeleton = "All",
            summonKey = "k"
        }
    end

    summonKey = MountSelectorCharacterConfig.summonKey or "q"
    selectedColor = MountSelectorCharacterConfig.lastSelectedColor or "All"
    selectedSkeleton = MountSelectorCharacterConfig.lastSelectedSkeleton or "All"
    --print("Selected Color:", selectedColor)
    --print("Selected Skeleton:", selectedSkeleton)
end

function saveSummonKey(key)
    MountSelectorCharacterConfig.summonKey = key
    summonKey = key
end

function SaveColorFilter(color)
    MountSelectorCharacterConfig.lastSelectedColor = color
    selectedColor = color
end

function SaveSkeletonFilter(skeleton)
    MountSelectorCharacterConfig.lastSelectedSkeleton = skeleton
    selectedSkeleton = skeleton
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
        UIDropDownMenu_SetText(skeletonDropdown, selectedSkeleton)
        UIDropDownMenu_SetText(colorDropdown, selectedColor)
    end
end

-- Create a frame to listen for events
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", OnEvent)
