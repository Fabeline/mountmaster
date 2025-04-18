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
        keybindFrame = {}
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
        filter = {}
    },
    db = {}
}

function CapitalizeFirstLetter(str)
    if str == nil or str == "" then
        return str
    end
    return (str:gsub("^%l", string.upper))
end
