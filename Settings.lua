RuthesMS = {
    settings = {
        selectedColors = {},
        selectedTypes = {},
        selectedExpansions = {},
        useOnlyFavourites = false,
        smallMountInInstance = false,
    },
    keybinds = {
    },
    state = {
        currentMounts = {},
        availableMounts = {}
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
        frameButtons = {},
        mountButtons = {},
        minimapButton = {},
        summonButton = {}
    },
    data = {
        mounts = {}
    },
    utils = {
        dropdown = {},
        filterDropdowns = {},
        mount = {},
        filter = {},
        addon = {},
    },
    db = {}
}

function CapitalizeFirstLetter(str)
    if str == nil or str == "" then
        return str
    end
    return (str:gsub("^%l", string.upper))
end
