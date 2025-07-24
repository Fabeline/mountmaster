local standardKey = "k"

local function InitializeConfig()
    if not MountSelectorCharacterConfig then
        MountSelectorCharacterConfig = {
            colors = RuthesMS.utils.filterDropdowns.getAllColors(),
            types = RuthesMS.utils.filterDropdowns.getAllTypes(),
            expansions = RuthesMS.utils.filterDropdowns.getAllExpansions(),

            -- looks = RuthesMS.utils.filterDropdowns.getAllLooks(),
            summonKey = standardKey, -- deprecated, use keybinds instead

            useOnlyFavourites = false,
            dontIncludeUtilityMounts = false,
            globalKeybinds = false,

            allowPetsInInstance = false,
            dontSummonPetFromMount = false,
            dontSummonPetFromDruidForm = false,
            dismissPetOnUnmount = false,

            pickForMe = false,

            useOnlyPetFavourites = false,
            useClassPets = false,
            useDruidGlyphOfTheStars = false,

            keybinds = {
                normal = "",
                small = "",
                ground = "",
                aquatic = "",
                repair = "",
                transmog = "",
                auctionHouse = "",
                mailbox = "",
                multiple = "",
            },
        }
    end

    if not MountSelectorGlobalConfig then
        MountSelectorGlobalConfig = {
            keybinds = {
                normal = "",
                small = "",
                ground = "",
                aquatic = "",
                repair = "",
                transmog = "",
                auctionHouse = "",
                mailbox = "",
                multiple = "",
            }
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
        small = MountSelectorCharacterConfig.keybinds.small or "",
        ground = MountSelectorCharacterConfig.keybinds.ground or "",
        repair = MountSelectorCharacterConfig.keybinds.repair or "",
        transmog = MountSelectorCharacterConfig.keybinds.transmog or "",
        mailbox = MountSelectorCharacterConfig.keybinds.mailbox or "",
        auctionHouse = MountSelectorCharacterConfig.keybinds.auctionHouse or "",
        multiple = MountSelectorCharacterConfig.keybinds.multiple or "",
    }

    RuthesMS.settings.selectedColors = MountSelectorCharacterConfig.colors or {}
    RuthesMS.settings.selectedTypes = MountSelectorCharacterConfig.types or {}
    RuthesMS.settings.selectedExpansions = MountSelectorCharacterConfig.expansions or {}
    -- RuthesMS.settings.selectedLooks = MountSelectorCharacterConfig.looks or {}

    RuthesMS.settings.useOnlyFavourites = MountSelectorCharacterConfig.useOnlyFavourites or false
    RuthesMS.settings.smallMountInInstance = MountSelectorCharacterConfig.smallMountInInstance or false
    RuthesMS.settings.dontIncludeUtilityMounts = MountSelectorCharacterConfig.dontIncludeUtilityMounts or false
    RuthesMS.settings.globalKeybinds = MountSelectorCharacterConfig.globalKeybinds or false
    RuthesMS.settings.dismissPetOnUnmount = MountSelectorCharacterConfig.dismissPetOnUnmount or false

    RuthesMS.settings.summonPetFromMount = not MountSelectorCharacterConfig.dontSummonPetFromMount or false
    RuthesMS.settings.summonPetFromDruidForm = not MountSelectorCharacterConfig.dontSummonPetFromDruidForm or false
    RuthesMS.settings.noPetsInInstance = not MountSelectorCharacterConfig.allowPetsInInstance or false

    RuthesMS.settings.useOnlyPetFavourites = MountSelectorCharacterConfig.useOnlyPetFavourites or false
    RuthesMS.settings.useClassPets = MountSelectorCharacterConfig.useClassPets or false
    RuthesMS.settings.useDruidGlyphOfTheStars = MountSelectorCharacterConfig.useDruidGlyphOfTheStars or false

    RuthesMS.settings.pickForMe = MountSelectorCharacterConfig.pickForMe or false

    if (MountSelectorCharacterConfig.globalKeybinds) then
        RuthesMS.keybinds = MountSelectorGlobalConfig.keybinds
    end
end

local function saveSummonKey(key, type)
    if (RuthesMS.settings.globalKeybinds) then
        MountSelectorGlobalConfig.keybinds[type] = key
        RuthesMS.frames.keybindFrame.loadSummoningKey()
    else
        MountSelectorCharacterConfig.keybinds[type] = key
        RuthesMS.frames.keybindFrame.loadSummoningKey()
    end
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

local function saveSelectedLooks(looks)
    MountSelectorCharacterConfig.looks = looks
end

local function saveUseOnlyFavourites(shouldUse)
    MountSelectorCharacterConfig.useOnlyFavourites = shouldUse
    RuthesMS.settings.useOnlyFavourites = shouldUse
end

local function saveSmallMountInInstance(shouldUse)
    MountSelectorCharacterConfig.smallMountInInstance = shouldUse
    RuthesMS.settings.smallMountInInstance = shouldUse
end

local function saveDontIncludeUtilityMounts(shouldUse)
    MountSelectorCharacterConfig.dontIncludeUtilityMounts = shouldUse
    RuthesMS.settings.dontIncludeUtilityMounts = shouldUse
end

local function saveGlobalKeybinds(shouldUse)
    if (shouldUse) then
        RuthesMS.keybinds = MountSelectorGlobalConfig.keybinds
    else
        RuthesMS.keybinds = MountSelectorCharacterConfig.keybinds
    end

    RuthesMS.frames.keybindFrame.loadSummoningKey()
    MountSelectorCharacterConfig.globalKeybinds = shouldUse
    RuthesMS.settings.globalKeybinds = shouldUse
end

local function saveSummonPetFromMount(shouldUse)
    MountSelectorCharacterConfig.dontSummonPetFromMount = not shouldUse
    RuthesMS.settings.summonPetFromMount = shouldUse
end

local function saveSummonPetFromDruidForm(shouldUse)
    MountSelectorCharacterConfig.dontSummonPetFromDruidForm = not shouldUse
    RuthesMS.settings.summonPetFromDruidForm = shouldUse
end

local function saveDismissPetOnUnmount(shouldUse)
    MountSelectorCharacterConfig.dismissPetOnUnmount = shouldUse
    RuthesMS.settings.dismissPetOnUnmount = shouldUse
end

local function saveUseOnlyPetFavourites(shouldUse)
    MountSelectorCharacterConfig.useOnlyPetFavourites = shouldUse
    RuthesMS.settings.useOnlyPetFavourites = shouldUse
end

local function saveNoPetsInInstance(shouldUse)
    MountSelectorCharacterConfig.allowPetsInInstance = not shouldUse
    RuthesMS.settings.noPetsInInstance = shouldUse
end

local function saveUseClassPets(shouldUse)
    MountSelectorCharacterConfig.useClassPets = shouldUse
    RuthesMS.settings.useClassPets = shouldUse
end

local function saveUseDruidGlyphOfTheStars(shouldUse)
    MountSelectorCharacterConfig.useDruidGlyphOfTheStars = shouldUse
    RuthesMS.settings.useDruidGlyphOfTheStars = shouldUse
end

local function savePickForMe(shouldUse)
    MountSelectorCharacterConfig.pickForMe = shouldUse
    RuthesMS.settings.pickForMe = shouldUse
end

RuthesMS.db = {
    init = InitializeConfig,
    saveSummonKey = saveSummonKey,
    saveSelectedColors = saveSelectedColors,
    saveSelectedTypes = saveSelectedTypes,
    saveSelectedExpansions = saveSelectedExpansions,
    saveSelectedLooks = saveSelectedLooks,

    saveUseOnlyFavourites = saveUseOnlyFavourites,
    saveSmallMountInInstance = saveSmallMountInInstance,
    saveDontIncludeUtilityMounts = saveDontIncludeUtilityMounts,
    saveGlobalKeybinds = saveGlobalKeybinds,

    saveDismissPetOnUnmount = saveDismissPetOnUnmount,
    saveSummonPetFromMount = saveSummonPetFromMount,
    saveSummonPetFromDruidForm = saveSummonPetFromDruidForm,
    saveUseOnlyPetFavourites = saveUseOnlyPetFavourites,
    saveNoPetsInInstance = saveNoPetsInInstance,
    saveUseClassPets = saveUseClassPets,
    saveUseDruidGlyphOfTheStars = saveUseDruidGlyphOfTheStars,

    savePickForMe = savePickForMe,
}
