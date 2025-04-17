SLASH_RMS1 = '/rms' -- Write /rms in chat to toggle the mount selector window

selectedColors = {}
selectedTypes = {}
selectedExpansions = {}
summonKey = "k"
currentMounts = {}
useOnlyFavourites = false
smallMountInInstance = false

function CapitalizeFirstLetter(str)
    if str == nil or str == "" then
        return str -- Return the string as it is if it's empty or nil
    end
    return (str:gsub("^%l", string.upper))
end
