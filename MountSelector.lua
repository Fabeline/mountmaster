RuthesMS.db.init()

RuthesMS.frames.mountSelectorFrame.create()
RuthesMS.buttons.minimapButton.create()

local function OnEvent(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "Ruthes_MountSelector" then
            print(
                "|cffff9900Ruthe's Mount Selector loaded - |cffffff00To see available commands, type: |r|cff00ff00/rms help|r")
        end
    elseif event == "PLAYER_LOGIN" then
        RuthesMS.utils.addon.afterAddonLoaded()
    end
end

-- Create a frame to listen for events
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", OnEvent)
