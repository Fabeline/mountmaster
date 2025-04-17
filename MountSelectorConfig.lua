local function InitializeConfig()
    if not MountSelectorCharacterConfig then
        MountSelectorCharacterConfig = {
            colors = getAllColors(),
            types = getAllTypes(),
            expansions = getAllExpansions(),
            summonKey = "k",
            useOnlyFavourites = false
        }
    end

    RuthesMS.keybinds.summonNormal = MountSelectorCharacterConfig.summonKey or "k"
    RuthesMS.settings.selectedColors = MountSelectorCharacterConfig.colors or {}
    RuthesMS.settings.selectedTypes = MountSelectorCharacterConfig.types or {}
    RuthesMS.settings.selectedExpansions = MountSelectorCharacterConfig.expansions or {}
    RuthesMS.settings.useOnlyFavourites = MountSelectorCharacterConfig.useOnlyFavourites or false
    RuthesMS.smallMountInInstance = MountSelectorCharacterConfig.smallMountInInstance or false
end

function saveSummonKey(key)
    MountSelectorCharacterConfig.summonKey = key
    RuthesMS.keybinds.summonNormal = key
end

function saveSelectedColors(colors)
    MountSelectorCharacterConfig.colors = colors
end

function saveSelectedTypes(types)
    MountSelectorCharacterConfig.types = types
end

function saveSelectedExpansions(expansions)
    MountSelectorCharacterConfig.expansions = expansions
end

function saveUseOnlyFavourites(shouldUse)
    MountSelectorCharacterConfig.useOnlyFavourites = shouldUse
    RuthesMS.settings.useOnlyFavourites = shouldUse
end

function saveSmallMountInInstance(shouldUse)
    MountSelectorCharacterConfig.smallMountInInstance = shouldUse
    RuthesMS.smallMountInInstance = shouldUse
end

local function OnEvent(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "Ruthes_MountSelector" then
            print(
                "|cffff9900Ruthe's Mount Selector loaded - |cffffff00To see available commands, type: |r|cff00ff00/rms help|r")
        end
    elseif event == "PLAYER_LOGIN" then
        InitializeConfig()
        renderMounts()
        loadSummoningKey()
        UIDropDownMenu_SetText(skeletonDropdown, "Select types")
        UIDropDownMenu_SetText(colorDropdown, "Select colors")
        UIDropDownMenu_SetText(expansionDropdown, "Select expansions")

        -- Some functions may not have been loaded yet
        local maxRetries = 10
        local retryCount = 0

        local function waitForFunctions()
            if reloadUseOnlyFavourites and reloadSmallMountInInstance then
                reloadUseOnlyFavourites()
                reloadSmallMountInInstance()
            elseif retryCount < maxRetries then
                retryCount = retryCount + 1
                C_Timer.After(0.2, waitForFunctions) -- Keep checking
            else
                -- An error occurred
            end
        end

        -- Start checking
        waitForFunctions()
    end
end



-- Create a frame to listen for events
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", OnEvent)
