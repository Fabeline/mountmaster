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

local function hasLook(mount, looks)
    if #looks == 0 then
        return true
    end

    for _, look in ipairs(looks) do
        if (mount.looks == look) then
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

-- Note that we might end up with a higher number of mounts when onlyFavorites is selected,
-- that is because the data set is smaller and we then filter less strictly
local function filterMounts(availableMounts)
    local filteredMounts = {}
    local specId, race, className, colors, types, looks

    if (RuthesMS.settings.pickForMe) then
        specId = RuthesMS.utils.character.getSpecId()
        race = RuthesMS.utils.character.getRace()
        className = RuthesMS.utils.character.getClassName() or ""

        colors = RuthesMS.utils.character.getColorForSpec(specId)
        types = RuthesMS.utils.character.getTypeFromRace(race, availableMounts)
        looks = RuthesMS.utils.character.getLooksForSpec(specId)

        for i = 1, #availableMounts do
            local currentMount = availableMounts[i]

            if ((hasColor(currentMount, colors) and hasType(currentMount, types)) and hasLook(currentMount, looks))
                or (currentMount.className and string.lower(currentMount.className) == string.lower(className)) then
                table.insert(filteredMounts, currentMount)
            end
        end

        local minMounts = 7

        -- If there are too few mounts after filtering, only filter by looks and color
        if (#filteredMounts < minMounts) then
            filteredMounts = {}

            for i = 1, #availableMounts do
                local currentMount = availableMounts[i]

                if (hasColor(currentMount, colors) and hasLook(currentMount, looks))
                    or (currentMount.className and string.lower(currentMount.className) == string.lower(className)) then
                    table.insert(filteredMounts, currentMount)
                end
            end
        end

        -- If there are still too few mounts, filter only by looks
        if (#filteredMounts < minMounts) then
            filteredMounts = {}

            for i = 1, #availableMounts do
                local currentMount = availableMounts[i]

                if (hasLook(currentMount, looks)) then
                    table.insert(filteredMounts, currentMount)
                end
            end
        end

        -- If there are still too few mounts, pick all
        if (#filteredMounts < minMounts) then
            filteredMounts = availableMounts
        end
    else
        for i = 1, #availableMounts do
            local currentMount = availableMounts[i]

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
