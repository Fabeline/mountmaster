-- MountButtons.lua

-- Function to create new mount buttons
local function createMountButtons(mountList)
    -- Refresh the content frame
    deleteContentFrame()
    createContentFrame()

    -- Set the height of the content frame based on the number of mounts
    local contentHeight = #mountList * 35
    contentFrame:SetHeight(contentHeight)

    for i, mount in ipairs(mountList) do
        -- Create text for the mount name
        local mountText = contentFrame:CreateFontString(nil, "OVERLAY")
        mountText:SetFontObject("GameFontNormal")
        mountText:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 10, -30 - (i-1) * 35)
        mountText:SetText(mount.name)

        -- Create the summon button
        local summonButton = CreateFrame("Button", nil, contentFrame, "UIPanelButtonTemplate")
        summonButton:SetSize(80, 22)
        summonButton:SetPoint("LEFT", mountText, "RIGHT", 10, 0)
        summonButton:SetText("Summon")

        -- Set the summon action using the correct ID
        summonButton:SetScript("OnClick", function()
            C_MountJournal.SummonByID(mount.id)
        end)
    end
end

-- Function to render mounts after filtering
function renderMounts(color)
    -- Get the filtered list of mounts
    local filteredMounts = filterMounts(color)

    -- Render only the filtered mounts
    createMountButtons(filteredMounts)
end

-- Initial population of buttons
renderMounts("All")
