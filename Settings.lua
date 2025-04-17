RuthesMS = {
    settings = {
        selectedColors = {},
        selectedTypes = {},
        selectedExpansions = {},
        useOnlyFavourites = false,
        smallMountInInstance = false,
    },
    keybinds = {
        summonNormal = "k",
    },
    temp = {
        currentMounts = {},
        availableMounts = {}
    },
    frames = {
        contentFrame = {}
    },
    buttons = {
        frameButtons = {},
        mountButtons = {}
    },
    mountFunctions = {},
    filterFunctions = {},
}

function CapitalizeFirstLetter(str)
    if str == nil or str == "" then
        return str
    end
    return (str:gsub("^%l", string.upper))
end
