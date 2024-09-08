SLASH_RMS1 = '/rms' -- Write /rms in chat to toggle the mount selector window

selectedColors = {}
selectedTypes = {}
summonKey = "k"
currentMounts = {}
useOnlyFavourites = false

function CapitalizeFirstLetter(str)
    return (str:gsub("^%l", string.upper))
end