-- Create a dropdown menu for filtering by color
colorDropdown = CreateFrame("FRAME", "ColorFilterDropdown", UIParent, "UIDropDownMenuTemplate")
UIDropDownMenu_SetWidth(colorDropdown, 150)

-- Create a dropdown menu for filtering by skeleton type
skeletonDropdown = CreateFrame("FRAME", "SkeletonFilterDropdown", UIParent, "UIDropDownMenuTemplate")
UIDropDownMenu_SetWidth(skeletonDropdown, 150)

local function toggleColor(color)
    if(color == "All") then
        selectedColors = {}
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

local function toggleType(type)
    if(type == "All") then
        selectedTypes = {}
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

        --for i, v in ipairs(selectedTypes) do
        --    print(v)
        --end
    end
    saveSelectedTypes(selectedTypes)
    renderMounts()
end


-- Populate the dropdown menu with skeleton types
local function initializeSkeletonDropdown(self, level)
    local info = UIDropDownMenu_CreateInfo()
    info.func = function(self)
        selectedType = self.value
        toggleType(selectedType)
        renderMounts()  -- Re-render mounts when a new filter is selected
    end

    -- Add "All" option
    info.text = "All"
    info.value = "All"
    info.checked = (#selectedTypes == 0)
    UIDropDownMenu_AddButton(info, level)

    -- Collect all unique skeleton types from the mounts data, case-insensitively
    local skeletonSet = {}
    for _, mount in ipairs(mounts) do
        if mount.skeleton_type and mount.skeleton_type ~= "" then
            local lowerSkeleton = string.lower(mount.skeleton_type)
            skeletonSet[lowerSkeleton] = mount.skeleton_type  -- Store the original case
        end
    end

    -- Convert the set of skeleton types to a list
    local skeletons = {}
    for _, originalSkeleton in pairs(skeletonSet) do
        table.insert(skeletons, CapitalizeFirstLetter(originalSkeleton))
    end

    -- Sort the skeleton types alphabetically
    table.sort(skeletons)

    -- Add each unique skeleton type to the dropdown
    for _, skeleton in ipairs(skeletons) do 
        info.text, info.value = skeleton, skeleton
        info.checked = tContains(selectedTypes, skeleton)
        UIDropDownMenu_AddButton(info, level)
    end
end

-- Populate the dropdown menu with colors
local function initializeColorDropdown(self, level)
    
    local info = UIDropDownMenu_CreateInfo()
    info.func = function(self)
        selectedColor = self.value
        toggleColor(selectedColor)
        renderMounts()  -- Re-render mounts when a new filter is selected
    end

    -- Add "All" option
    info.text = "All"
    info.value = "All"
    info.checked = (#selectedColors == 0)
    UIDropDownMenu_AddButton(info, level)

    if #selectedColors == 0 then
        info.checked = true
    end

    -- Collect all unique colors from the mounts data, case-insensitively
    local colorSet = {}
    for _, mount in ipairs(mounts) do
        if mount.color and mount.color ~= "" then
            local lowerColor = string.lower(mount.color)
            colorSet[lowerColor] = mount.color  -- Store the original case
        end
    end

    -- Convert the set of colors to a list
    local colors = {}
    for _, originalColor in pairs(colorSet) do
        table.insert(colors, CapitalizeFirstLetter(originalColor))
    end

    -- Sort the colors alphabetically
    table.sort(colors)

    -- Add each unique color to the dropdown
    for _, color in ipairs(colors) do  -- Use ipairs to correctly iterate over the sorted list
        info.text, info.value = color, color
        info.checked = tContains(selectedColors, color)
        UIDropDownMenu_AddButton(info, level)
    end 
end

-- Initialize the dropdown
UIDropDownMenu_Initialize(colorDropdown, initializeColorDropdown)
UIDropDownMenu_Initialize(skeletonDropdown, initializeSkeletonDropdown)

local function findMountByID(id)
    for _, mount in ipairs(mounts) do
        if mount.id == id then
            return mount
        end
    end
    return nil
end

-- Filter mounts based on selected color and whether the mount is collected
function filterMounts(visibleMounts)
    local filteredMounts = {}

    for i = 1, #visibleMounts do
        local currentMount = visibleMounts[i]
        if (#selectedColors == 0 or tContains(selectedColors, CapitalizeFirstLetter(currentMount.color))) and (#selectedTypes == 0 or  tContains(selectedTypes, CapitalizeFirstLetter(currentMount.skeleton_type))) then
            table.insert(filteredMounts, currentMount)
        end

    end

    return filteredMounts
end