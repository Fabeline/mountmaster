local function InitializeConfig()
    if not MountSelectorCharacterConfig then
        MountSelectorCharacterConfig = {
            colors = getAllColors(),
            types = getAllTypes(),
            summonKey = "k",
            useOnlyFavourites = false
        }
    end

    summonKey = MountSelectorCharacterConfig.summonKey or "k"
    selectedColors = MountSelectorCharacterConfig.colors or {}
    selectedTypes = MountSelectorCharacterConfig.types or {}
    useOnlyFavourites = MountSelectorCharacterConfig.useOnlyFavourites or false
    smallMountInInstance = MountSelectorCharacterConfig.smallMountInInstance or false
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

function saveUseOnlyFavourites(shouldUse)
    MountSelectorCharacterConfig.useOnlyFavourites = shouldUse
    useOnlyFavourites = shouldUse
end

function saveSmallMountInInstance(shouldUse)
    MountSelectorCharacterConfig.smallMountInInstance = shouldUse
    smallMountInInstance = shouldUse
end

-- Event handler for when the addon is loaded and mount data is available
local function OnEvent(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "Ruthes_MountSelector" then
            print("Ruthe's MountSelector loaded. Type /rms to open.")
        end
    end
    if event == "PLAYER_LOGIN" then
        InitializeConfig()
        renderMounts()
        loadSummoningKey()
        UIDropDownMenu_SetText(skeletonDropdown, "Select types")
        UIDropDownMenu_SetText(colorDropdown, "Select colors")
        reloadUseOnlyFavourites()
        reloadSmallMountInInstance()
    end
end

-- Create a frame to listen for events
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", OnEvent)
