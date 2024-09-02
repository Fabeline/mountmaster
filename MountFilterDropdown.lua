-- MountFilterDropdown.lua

-- Create a dropdown menu for filtering by color
colorDropdown = CreateFrame("FRAME", "ColorFilterDropdown", UIParent, "UIDropDownMenuTemplate")
UIDropDownMenu_SetWidth(colorDropdown, 150)
UIDropDownMenu_SetText(colorDropdown, "Select Color")

-- Create a dropdown menu for filtering by skeleton type
skeletonDropdown = CreateFrame("FRAME", "SkeletonFilterDropdown", UIParent, "UIDropDownMenuTemplate")
UIDropDownMenu_SetWidth(skeletonDropdown, 150)
UIDropDownMenu_SetText(skeletonDropdown, "Select Skeleton")

-- Populate the dropdown menu with skeleton types
local function initializeSkeletonDropdown(self, level)
    local info = UIDropDownMenu_CreateInfo()
    info.func = function(self)
        selectedSkeleton = self.value
        SaveSkeletonFilter(selectedSkeleton)
        UIDropDownMenu_SetText(skeletonDropdown, selectedSkeleton)
        renderMounts()  -- Re-render mounts when a new filter is selected
    end

    -- Add "All" option
    info.text, info.value = "All", "All"
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
        table.insert(skeletons, originalSkeleton)
    end

    -- Sort the skeleton types alphabetically
    table.sort(skeletons)

    -- Add each unique skeleton type to the dropdown
    for _, skeleton in ipairs(skeletons) do  -- Use ipairs to correctly iterate over the sorted list
        info.text, info.value = skeleton, skeleton
        UIDropDownMenu_AddButton(info, level)
    end

    UIDropDownMenu_SetSelectedValue(skeletonDropdown, selectedSkeleton)
    UIDropDownMenu_SetText(skeletonDropdown, selectedSkeleton)
end

-- Populate the dropdown menu with colors
local function initializeColorDropdown(self, level)
    local info = UIDropDownMenu_CreateInfo()
    info.func = function(self)
        selectedColor = self.value
        SaveColorFilter(selectedColor)
        UIDropDownMenu_SetText(colorDropdown, selectedColor)
        renderMounts()  -- Re-render mounts when a new filter is selected
    end

    -- Add "All" option
    info.text, info.value = "All", "All"
    UIDropDownMenu_AddButton(info, level)

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
        table.insert(colors, originalColor)
    end

    -- Sort the colors alphabetically
    table.sort(colors)

    -- Add each unique color to the dropdown
    for _, color in ipairs(colors) do  -- Use ipairs to correctly iterate over the sorted list
        info.text, info.value = color, color
        UIDropDownMenu_AddButton(info, level)
    end

    UIDropDownMenu_SetSelectedValue(colorDropdown, selectedColor)
    UIDropDownMenu_SetText(colorDropdown, selectedColor)
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
    return nil  -- Return nil if no mount with the given ID is found
end

-- Function to filter mounts based on selected color and whether the mount is collected
function filterMounts(visibleMounts)
    local filteredMounts = {}

    -- Convert the input color to lowercase for case-insensitive comparison
    local colorLower = string.lower(selectedColor)
    local skeletonLower = string.lower(selectedSkeleton)

    for i = 1, #visibleMounts do
        local currentMount = visibleMounts[i]
        local mountColorLower = string.lower(currentMount.color or "")
        local mountSkeletonLower = string.lower(currentMount.skeleton_type or "")

        if (colorLower == "all" or mountColorLower == colorLower) and (skeletonLower == "all" or mountSkeletonLower == skeletonLower) then
            table.insert(filteredMounts, currentMount)
        end

    end

    return filteredMounts
end