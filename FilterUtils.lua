local function hasSelectedColor(mount)
    if #RuthesMS.settings.selectedColors == 0 then
        return true
    end

    return tContains(RuthesMS.settings.selectedColors, CapitalizeFirstLetter(mount.color)) or
        tContains(RuthesMS.settings.selectedColors, CapitalizeFirstLetter(mount.secondary_color))
end

local function hasSelectedType(mount)
    if #RuthesMS.settings.selectedTypes == 0 then
        return true
    end

    return tContains(RuthesMS.settings.selectedTypes, CapitalizeFirstLetter(mount.skeleton_type))
end


local function hasSelectedExpansion(mount)
    if #RuthesMS.settings.selectedExpansions == 0 then
        return true
    end

    return tContains(RuthesMS.settings.selectedExpansions, CapitalizeFirstLetter(mount.expansion))
end

-- Filter mounts based on selected color and type
local function filterMounts(availableMounts)
    local filteredMounts = {}

    for i = 1, #availableMounts do
        local currentMount = availableMounts[i]
        if (hasSelectedColor(currentMount) and
                hasSelectedType(currentMount) and
                hasSelectedExpansion(currentMount)) then
            table.insert(filteredMounts, currentMount)
        end
    end

    return filteredMounts
end

RuthesMS.utils.filter = {
    filterMounts = filterMounts,
}
