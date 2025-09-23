RuthesMS = {
    settings = {
        selectedColors = {},
        selectedTypes = {},
        selectedExpansions = {},
        selectedLooks = {},
        useOnlyFavourites = false,
        smallMountInInstance = false,
        dontIncludeUtilityMounts = true,
        noPetsInInstance = false,
        globalKeybinds = false,
        summonPetFromMount = false,
        useOnlyPetFavourites = false,
        useDruidGlyphOfTheStars = false,
        pickForme = false,
    },
    keybinds = {
    },
    state = {
        currentMounts = {},
        availableMounts = {},
        knownMounts = {},
    },
    frames = {
        contentFrame = {},
        keybindFrame = {},
        advancedFrame = {},
        generalFrame = {},
        helpFrame = {},
        mountSelectorFrame = {},
        mountSelectorScrollFrame = {},
    },
    buttons = {
        mountButtons = {},
        minimapButton = {},
        summonButton = {},
        randomMountButton = {},
        druidButtons = {}
    },
    data = {
        mounts = {},
        pets = {}
    },
    utils = {
        dropdown = {},
        filterDropdowns = {},
        mount = {},
        pet = {},
        filter = {},
        addon = {},
        summon = {},
        druid = {},
        character = {},
    },
    db = {}
}

function CapitalizeFirstLetter(str)
    if str == nil or str == "" then
        return str
    end
    return (str:gsub("^%l", string.upper))
end
