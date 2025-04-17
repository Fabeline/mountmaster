function getAllColors()
    -- Collect all unique colors from the mounts data
    local colorSet = {}
    for _, mount in ipairs(mounts) do
        if mount.color and mount.color ~= "" then
            local lowerColor = string.lower(mount.color)
            colorSet[lowerColor] = mount.color
        end
        if mount.secondary_color and mount.secondary_color ~= "" then
            local lowerColor = string.lower(mount.secondary_color)
            colorSet[lowerColor] = mount.secondary_color
        end
    end

    -- Convert the set of colors to a list and sort
    local colors = {}
    for _, originalColor in pairs(colorSet) do
        table.insert(colors, CapitalizeFirstLetter(originalColor))
    end

    table.sort(colors)
    return colors
end

function getAllTypes()
    -- Collect all unique skeleton types from the mounts data
    local typeSet = {}
    for _, mount in ipairs(mounts) do
        if mount.skeleton_type and mount.skeleton_type ~= "" then
            local lowerType = string.lower(mount.skeleton_type)
            typeSet[lowerType] = mount.skeleton_type
        end
    end

    -- Convert the set of skeleton types to a list and sort
    local types = {}
    for _, originalType in pairs(typeSet) do
        table.insert(types, CapitalizeFirstLetter(originalType))
    end

    table.sort(types)
    return types
end

function getAllExpansions()
    local expansions = {
        "Classic", "TBC", "WotLK", "Cataclysm", "MoP", "WoD", "Legion",
        "BFA", "Shadowlands", "Dragonflight", "MoP remix", "TWW"
    }
    return expansions
end

local function allColorsAreSelected()
    return #selectedColors == #getAllColors()
end

local function allTypesAreSelected()
    return #selectedTypes == #getAllTypes()
end

local function allExpansionsAreSelected()
    return #selectedExpansions == #getAllExpansions()
end

local function toggleType(type)
    if (type == "All") then
        if allTypesAreSelected() then
            selectedTypes = {}
        else
            selectedTypes = getAllTypes()
        end
    else
        -- add type to selectedTypes
        if not tContains(selectedTypes, type) then
            table.insert(selectedTypes, type)
        else -- remove type from selectedTypes
            for i, v in ipairs(selectedTypes) do
                if v == type then
                    table.remove(selectedTypes, i)
                end
            end
        end
    end
    saveSelectedTypes(selectedTypes)
    renderMounts()
end

local function toggleColor(color)
    if (color == "All") then
        if allColorsAreSelected() then
            selectedColors = {}
        else
            selectedColors = getAllColors()
        end
    else
        -- add color to selectedColors
        if not tContains(selectedColors, color) then
            table.insert(selectedColors, color)
        else -- remove color from selectedColors
            for i, v in ipairs(selectedColors) do
                if v == color then
                    table.remove(selectedColors, i)
                end
            end
        end

        --for i, v in ipairs(selectedColors) do
        --    print(v)
        --end
    end
    saveSelectedColors(selectedColors)
    renderMounts()
end

local function toggleExpansion(expansion)
    if (expansion == "All") then
        if allExpansionsAreSelected() then
            selectedExpansions = {}
        else
            selectedExpansions = getAllExpansions()
        end
    else
        -- add expansion to selectedExpansions
        if not tContains(selectedExpansions, expansion) then
            table.insert(selectedExpansions, expansion)
        else -- remove expansion from selectedExpansions
            for i, v in ipairs(selectedExpansions) do
                if v == expansion then
                    table.remove(selectedExpansions, i)
                end
            end
        end
    end

    saveSelectedExpansions(selectedExpansions)
    renderMounts()
end


-- Populate the dropdown menu with skeleton types
function initializeSkeletonDropdown(self)
    local info = UIDropDownMenu_CreateInfo()
    info.func = function(self)
        selectedType = self.value
        toggleType(selectedType)
        renderMounts() -- Re-render mounts when a new filter is selected
    end

    -- Add "All" option
    info.text = "All"
    info.value = "All"
    info.checked = allTypesAreSelected()
    UIDropDownMenu_AddButton(info, 1)

    -- Add each unique skeleton type to the dropdown
    for _, skeleton in ipairs(getAllTypes()) do
        info.text, info.value = skeleton, skeleton
        info.checked = tContains(selectedTypes, skeleton)
        UIDropDownMenu_AddButton(info, 1)
    end
end

-- Populate the dropdown menu with colors
function initializeColorDropdown(self)
    local info = UIDropDownMenu_CreateInfo()
    info.func = function(self)
        selectedColor = self.value
        toggleColor(selectedColor)
        -- Re-render mounts when a new filter is selected
        renderMounts()
    end

    -- Add "All" option
    info.text = "All"
    info.value = "All"
    info.checked = (allColorsAreSelected())
    UIDropDownMenu_AddButton(info, 1)

    -- Add each unique color to the dropdown
    for _, color in ipairs(getAllColors()) do
        info.text, info.value = color, color
        info.checked = tContains(selectedColors, color)
        UIDropDownMenu_AddButton(info, 1)
    end
end

function initializeExpansionDropdown(self)
    local info = UIDropDownMenu_CreateInfo()
    info.func = function(self)
        selectedExpansion = self.value
        toggleExpansion(selectedExpansion)
        renderMounts() -- Re-render mounts when a new filter is selected
    end

    -- Add "All" option
    info.text = "All"
    info.value = "All"
    info.checked = allExpansionsAreSelected()
    UIDropDownMenu_AddButton(info, 1)

    -- Add each unique expansion to the dropdown
    for _, expansion in ipairs(getAllExpansions()) do
        info.text, info.value = expansion, expansion
        info.checked = tContains(selectedExpansions, expansion)
        UIDropDownMenu_AddButton(info, 1)
    end
end

local function hasSelectedColor(mount)
    return #selectedColors == 0 or
        (
            tContains(selectedColors, CapitalizeFirstLetter(mount.color)) or
            tContains(selectedColors, CapitalizeFirstLetter(mount.secondary_color))
        )
end

local function hasSelectedType(mount)
    return #selectedTypes == 0 or tContains(selectedTypes, CapitalizeFirstLetter(mount.skeleton_type))
end

local function hasSelectedExpansion(mount)
    return #selectedExpansions == 0 or tContains(selectedExpansions, CapitalizeFirstLetter(mount.expansion))
end

-- Filter mounts based on selected color and type
function filterMounts(availableMounts)
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
