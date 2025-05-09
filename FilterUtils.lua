local function hasColor(mount, colors)
    if #colors == 0 then
        return true
    end

    for _, color in ipairs(colors) do
        if (mount.color == color or mount.secondary_color == color) then
            return true
        end
    end

    return false
end

local function hasType(mount, types)
    if #types == 0 then
        return true
    end

    for _, type in ipairs(types) do
        if (mount.skeleton_type == type) then
            return true
        end
    end

    return false
end

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

local function hasSelectedLooks(mount)
    if #RuthesMS.settings.selectedLooks == 0 then
        return true
    end

    return tContains(RuthesMS.settings.selectedLooks, CapitalizeFirstLetter(mount.looks))
end

-- Filter mounts based on selected color and type
local function filterMounts(availableMounts)
    local filteredMounts = {}
    local colors = RuthesMS.utils.character.getColorForSpec()
    local types = RuthesMS.utils.character.getTypeFromRace()


    for i = 1, #availableMounts do
        local currentMount = availableMounts[i]

        if (RuthesMS.settings.pickForMe) then
            if (hasColor(currentMount, colors) and hasType(currentMount, types)) then
                table.insert(filteredMounts, currentMount)
            end
        else
            if (hasSelectedColor(currentMount) and
                    hasSelectedType(currentMount) and
                    hasSelectedLooks(currentMount) and
                    hasSelectedExpansion(currentMount)) then
                table.insert(filteredMounts, currentMount)
            end
        end
    end

    return filteredMounts
end

RuthesMS.utils.filter = {
    filterMounts = filterMounts,
}
