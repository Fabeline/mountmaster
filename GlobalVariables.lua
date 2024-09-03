selectedColors = {}
selectedTypes = {}
summonKey = "k"
currentMounts = {}

function CapitalizeFirstLetter(str)
    return (str:gsub("^%l", string.upper))
end