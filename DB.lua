local standardKey = "k"

local function InitializeConfig()
    if not MountSelectorCharacterConfig then
        MountSelectorCharacterConfig = {
            colors = RuthesMS.utils.filterDropdowns.getAllColors(),
            types = RuthesMS.utils.filterDropdowns.getAllTypes(),
            expansions = RuthesMS.utils.filterDropdowns.getAllExpansions(),
            summonKey = standardKey, -- deprecated, use keybinds instead
            useOnlyFavourites = false,
            dontIncludeUtilityMounts = false,
            keybinds = {
                normal = standardKey,
                aquatic = "",
                repair = "",
                transmog = "",
                auctionHouse = "",
                mailbox = "",
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
        mailbox = MountSelectorCharacterConfig.keybinds.mailbox or "",
        auctionHouse = MountSelectorCharacterConfig.keybinds.auctionHouse or "",
        multiple = MountSelectorCharacterConfig.keybinds.multiple or "",
    }

    RuthesMS.settings.selectedColors = MountSelectorCharacterConfig.colors or {}
    RuthesMS.settings.selectedTypes = MountSelectorCharacterConfig.types or {}
    RuthesMS.settings.selectedExpansions = MountSelectorCharacterConfig.expansions or {}
    RuthesMS.settings.useOnlyFavourites = MountSelectorCharacterConfig.useOnlyFavourites or false
    RuthesMS.settings.smallMountInInstance = MountSelectorCharacterConfig.smallMountInInstance or false
    RuthesMS.settings.dontIncludeUtilityMounts = MountSelectorCharacterConfig.dontIncludeUtilityMounts or false
end

local function saveSummonKey(key, type)
    MountSelectorCharacterConfig.keybinds[type] = key
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

local function saveDontIncludeUtilityMounts(shouldUse)
    MountSelectorCharacterConfig.dontIncludeUtilityMounts = shouldUse
    RuthesMS.settings.dontIncludeUtilityMounts = shouldUse
end

RuthesMS.db = {
    init = InitializeConfig,
    saveSummonKey = saveSummonKey,
    saveSelectedColors = saveSelectedColors,
    saveSelectedTypes = saveSelectedTypes,
    saveSelectedExpansions = saveSelectedExpansions,
    saveUseOnlyFavourites = saveUseOnlyFavourites,
    saveSmallMountInInstance = saveSmallMountInInstance,
    saveDontIncludeUtilityMounts = saveDontIncludeUtilityMounts,
}
