local standardKey = "k"

local function InitializeConfig()
    if not MountSelectorCharacterConfig then
        MountSelectorCharacterConfig = {
            colors = RuthesMS.utils.filterDropdowns.getAllColors(),
            types = RuthesMS.utils.filterDropdowns.getAllTypes(),
            expansions = RuthesMS.utils.filterDropdowns.getAllExpansions(),
            summonKey = standardKey, -- deprecated, use keybinds instead
            useOnlyFavourites = false,
            keybinds = {
                normal = standardKey,
                aquatic = "",
                repair = "",
                transmog = "",
                auctionHouse = "",
                multiple = "",
            },
        }
    end

    if (MountSelectorCharacterConfig.keybinds == nil) then
        MountSelectorCharacterConfig.keybinds = {}
    end

    RuthesMS.keybinds = {
        normal = MountSelectorCharacterConfig.keybinds.normal or
            MountSelectorCharacterConfig.summonKey or -- Backward compatibility for summonKey
            standardKey,
        aquatic = MountSelectorCharacterConfig.keybinds.aquatic or "",
        repair = MountSelectorCharacterConfig.keybinds.repair or "",
        transmog = MountSelectorCharacterConfig.keybinds.transmog or "",
        auctionHouse = MountSelectorCharacterConfig.keybinds.auctionHouse or "",
        multiple = MountSelectorCharacterConfig.keybinds.multiple or "",
    }

    RuthesMS.settings.selectedColors = MountSelectorCharacterConfig.colors or {}
    RuthesMS.settings.selectedTypes = MountSelectorCharacterConfig.types or {}
    RuthesMS.settings.selectedExpansions = MountSelectorCharacterConfig.expansions or {}
    RuthesMS.settings.useOnlyFavourites = MountSelectorCharacterConfig.useOnlyFavourites or false
    RuthesMS.settings.smallMountInInstance = MountSelectorCharacterConfig.smallMountInInstance or false
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
        RuthesMS.buttons.mountButtons.reload()
        RuthesMS.buttons.summonButton.reload()

        -- Some functions may not have been loaded yet
        local maxRetries = 10
        local retryCount = 0

        local function waitForFunctions()
            if RuthesMS.buttons.summonButton.reloadUseOnlyFavourites and RuthesMS.buttons.summonButton.reloadSmallMountInInstance then
                RuthesMS.buttons.summonButton.reloadUseOnlyFavourites()
                RuthesMS.buttons.summonButton.reloadSmallMountInInstance()
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

local function init()
    -- Create a frame to listen for events
    local eventFrame = CreateFrame("Frame")
    eventFrame:RegisterEvent("ADDON_LOADED")
    eventFrame:RegisterEvent("PLAYER_LOGIN")
    eventFrame:SetScript("OnEvent", OnEvent)
end

local function saveSummonKey(key, type)
    MountSelectorCharacterConfig.summonKey = key
    RuthesMS.keybinds[type] = key
end

local function saveSelectedColors(colors)
    MountSelectorCharacterConfig.colors = colors
end

local function saveSelectedTypes(types)
    MountSelectorCharacterConfig.types = types
end

local function saveSelectedExpansions(expansions)
    MountSelectorCharacterConfig.expansions = expansions
end

local function saveUseOnlyFavourites(shouldUse)
    MountSelectorCharacterConfig.useOnlyFavourites = shouldUse
    RuthesMS.settings.useOnlyFavourites = shouldUse
end

local function saveSmallMountInInstance(shouldUse)
    MountSelectorCharacterConfig.smallMountInInstance = shouldUse
    RuthesMS.smallMountInInstance = shouldUse
end

RuthesMS.db = {
    init = init,
    saveSummonKey = saveSummonKey,
    saveSelectedColors = saveSelectedColors,
    saveSelectedTypes = saveSelectedTypes,
    saveSelectedExpansions = saveSelectedExpansions,
    saveUseOnlyFavourites = saveUseOnlyFavourites,
    saveSmallMountInInstance = saveSmallMountInInstance,
}
