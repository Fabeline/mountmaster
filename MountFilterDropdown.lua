-- MountFilterDropdown.lua

-- Print to confirm the file is loading
print("MountFilterDropdown.lua is running")

-- Create a dropdown menu for filtering by color
colorDropdown = CreateFrame("FRAME", "ColorFilterDropdown", UIParent, "UIDropDownMenuTemplate")
UIDropDownMenu_SetWidth(colorDropdown, 150)
UIDropDownMenu_SetText(colorDropdown, "Select Color")

local selectedColor = "All"

-- Populate the dropdown menu with colors
local function initializeColorDropdown(self, level)
    local info = UIDropDownMenu_CreateInfo()
    info.func = function(self)
        selectedColor = self.value
        UIDropDownMenu_SetText(colorDropdown, selectedColor)
        renderMounts(selectedColor)  -- Re-render mounts when a new filter is selected
    end

    -- Add "All" option
    info.text, info.value = "All", "All"
    UIDropDownMenu_AddButton(info, level)

    -- Collect all unique colors from the mounts data
    local colors = {}
    for _, mount in ipairs(mounts) do
        if mount.color and mount.color ~= "Unknown Color" then
            colors[mount.color] = true
        end
    end

    -- Add each unique color to the dropdown
    for color in pairs(colors) do
        info.text, info.value = color, color
        UIDropDownMenu_AddButton(info, level)
    end
end

-- Initialize the dropdown
UIDropDownMenu_Initialize(colorDropdown, initializeColorDropdown)
