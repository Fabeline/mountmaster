-- Load the libraries
local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("MountSelector", {
    type = "launcher",
    text = "Ruthe's Mount Selector",
    icon = "Interface\\AddOns\\Ruthes_MountSelector\\Ruthes_MountSelector.tga",
    OnClick = function(self, button)
        if MountSelectorFrame:IsShown() then
            MountSelectorFrame:Hide()
        else
            renderMounts()
            MountSelectorFrame:Show()
        end
    end,
    OnTooltipShow = function(tooltip)
        tooltip:AddLine("Ruthe's Mount Selector")
        tooltip:AddLine("Click to toggle the Mount Selector window.")
        tooltip:AddLine("To toggle minimap button, type /rms minimap")
    end,
})

local icon = LibStub("LibDBIcon-1.0")

-- Function to ensure backward compatibility with previous versions
local function EnsureDefaults()
    if not mountSelectorDB then
        mountSelectorDB = {} -- Initialize the table if it doesn't exist
    end
    if not mountSelectorDB.minimap then
        mountSelectorDB.minimap = {} -- Initialize the minimap table if it doesn't exist
    end
    if mountSelectorDB.minimap.minimapPos == nil then
        mountSelectorDB.minimap.minimapPos = 220 -- Set default position if it doesn't exist
    end
    if mountSelectorDB.minimap.hide == nil then
        mountSelectorDB.minimap.hide = false -- Default visibility is shown
    end
end

-- Function to register and load minimap button
local function LoadMinimapButton()
    EnsureDefaults() -- Ensure that the DB has valid values for position and visibility
    -- Register the minimap button with saved position and visibility
    icon:Register("MountSelector", LDB, mountSelectorDB.minimap)

    -- Check visibility on load
    if mountSelectorDB.minimap.hide then
        icon:Hide("MountSelector")
    else
        icon:Show("MountSelector")
    end
end

-- Save the minimap button position when it moves
icon:RegisterCallback("LibDBIcon_IconPositionChanged", function(_, _, position)
    mountSelectorDB.minimap.minimapPos = position
end)

-- Listen for the ADDON_LOADED event to ensure SavedVariables are loaded
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
    if addon == "Ruthes_MountSelector" then
        LoadMinimapButton()
        self:UnregisterEvent("ADDON_LOADED")
    end
end)

function toggleMinimap()
    mountSelectorDB.minimap.hide = not mountSelectorDB.minimap.hide
    if mountSelectorDB.minimap.hide then
        icon:Hide("MountSelector")
    else
        icon:Show("MountSelector")
    end
end