-- MountSelectorConfig.lua

local mountDataRendered = false  -- Variable to track if the mount data has been rendered

-- Function to initialize the configuration table and prepare for rendering
local function InitializeConfig()
    if not MountSelectorCharacterConfig then
        MountSelectorCharacterConfig = {}
        print("Config not found, creating new table")
    else
        print("Config loaded:", MountSelectorCharacterConfig)
    end

    -- Load the last selected color filter, default to "All" if not set
    local lastColor = MountSelectorCharacterConfig.lastSelectedColor or "All"
    print("Last selected color:", lastColor)
end

-- Function to save the selected color filter
function SaveColorFilter(color)
    MountSelectorCharacterConfig.lastSelectedColor = color
    print("Saving color filter:", color)
end

-- Function to check if mount data is ready and render mounts
local function TryRenderMounts()
    if not mountDataRendered then
        local numMounts = C_MountJournal.GetNumDisplayedMounts()
        if numMounts > 0 then
            renderMounts(MountSelectorCharacterConfig.lastSelectedColor or "All")
            mountDataRendered = true
            print("Mount data rendered successfully with", numMounts, "mounts.")
        else
            -- Re-check after a short delay
            print("Mount data not ready, checking again...")
            C_Timer.After(1, TryRenderMounts)
        end
    end
end

-- Event handler for when the addon is loaded and mount data is available
local function OnEvent(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "MountSelector" then
            InitializeConfig()
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        print("Player entering world, starting delayed mount data check...")
        C_Timer.After(5, TryRenderMounts)  -- Start checking after a 5-second delay
    end
end

-- Create a frame to listen for events
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:SetScript("OnEvent", OnEvent)
