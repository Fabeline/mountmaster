RuthesMS = {
    settings = {
        selectedColors = {},
        selectedTypes = {},
        selectedExpansions = {},
        selectedLooks = {},
        useOnlyFavourites = false,
        smallMountInInstance = false,
        dontIncludeUtilityMounts = false,
        globalKeybinds = false
    },
    keybinds = {
    },
    state = {
        currentMounts = {},
        availableMounts = {},
        lastSummonedMount = nil,
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
        summon = {}
    },
    db = {}
}

function CapitalizeFirstLetter(str)
    if str == nil or str == "" then
        return str
    end
    return (str:gsub("^%l", string.upper))
end
