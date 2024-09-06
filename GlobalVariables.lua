selectedColors = {}
selectedTypes = {}
summonKey = "k"
currentMounts = {}
useOnlyFavourites = false

function CapitalizeFirstLetter(str)
    return (str:gsub("^%l", string.upper))
end