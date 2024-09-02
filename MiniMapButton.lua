-- Load the libraries
local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("MountSelector", {
    type = "launcher",
    text = "Mount Selector",
    icon = "Interface\\AddOns\\MountSelector\\Textures\\MountSelector.tga",
    OnClick = function(self, button)
        if MountSelectorFrame:IsShown() then
            MountSelectorFrame:Hide()
        else
            renderMounts()
            MountSelectorFrame:Show()
        end
    end,
    OnTooltipShow = function(tooltip)
        tooltip:AddLine("Mount Selector")
        tooltip:AddLine("Click to toggle the Mount Selector window.")
    end,
})

local icon = LibStub("LibDBIcon-1.0")

-- Settings table for saving position and visibility
local mountSelectorDB = {
    minimap = {
        hide = false,
    },
}

-- Register the minimap button
icon:Register("MountSelector", LDB, mountSelectorDB.minimap)

-- Optional: Add a slash command to show/hide the minimap button
SLASH_MOUNTSELECTOR1 = "/mountselector"
SlashCmdList["MOUNTSELECTOR"] = function(msg)
    mountSelectorDB.minimap.hide = not mountSelectorDB.minimap.hide
    if mountSelectorDB.minimap.hide then
        icon:Hide("MountSelector")
    else
        icon:Show("MountSelector")
    end
end
