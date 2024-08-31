-- MountButtons.lua

-- Function to create new mount buttons
local function createMountButtons(mountList)
    -- Refresh the content frame
    deleteContentFrame()
    createContentFrame()

    -- Set the height of the content frame based on the number of mounts
    local contentHeight = #mountList * 35
    contentFrame:SetHeight(contentHeight)
    print("Setting content frame height to:", contentHeight)

    for i, mount in ipairs(mountList) do
        -- Create text for the mount name
        local mountText = contentFrame:CreateFontString(nil, "OVERLAY")
        mountText:SetFontObject("GameFontNormal")
        mountText:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 10, -30 - (i-1) * 35)
        mountText:SetText(mount.name)
        print("Created mount text for:", mount.name, "at position:", -30 - (i-1) * 35)

        -- Create the summon button
        local summonButton = CreateFrame("Button", nil, contentFrame, "UIPanelButtonTemplate")
        summonButton:SetSize(80, 22)
        summonButton:SetPoint("LEFT", mountText, "RIGHT", 10, 0)
        summonButton:SetText("Summon")

        -- Set the summon action using the correct ID
        summonButton:SetScript("OnClick", function()
            C_MountJournal.SummonByID(mount.id)
        end)
        print("Created summon button for:", mount.name, "with ID:", mount.id)
    end
end

-- Function to filter mounts based on selected color and whether the mount is collected
local function filterMounts(color)
    local filteredMounts = {}

    -- Iterate over all mounts in the journal
    local totalMounts = C_MountJournal.GetNumMounts()

    for i = 1, totalMounts do
        local mountID = C_MountJournal.GetDisplayedMountID(i)
        local name, spellID, icon, active, isUsable, sourceType, isFavorite, isFactionSpecific, faction, hideOnChar, isCollected = C_MountJournal.GetMountInfoByID(mountID)
        local mountColor = mounts[mountID] and mounts[mountID].color or "Unknown Color"

        if isCollected then
            if color == "All" or mountColor == color then
                table.insert(filteredMounts, { id = mountID, name = name, color = mountColor })
                print("Mount added to filtered list:", name, "Color:", mountColor)
            else
                print("Mount filtered out:", name, "Color:", mountColor)
            end
        else
            print("Mount not collected, filtered out:", name)
        end
    end

    -- Debugging: Print the count of filtered mounts
    print("Filtered Mounts Count:", #filteredMounts)

    return filteredMounts
end

-- Function to render mounts after filtering
function renderMounts(color)
    if not mountSelectorFrame then
        print("Error: mountSelectorFrame is not available during renderMounts!")
        return
    end

    -- Get the filtered list of mounts
    local filteredMounts = filterMounts(color)

    -- Render only the filtered mounts
    createMountButtons(filteredMounts)
end

-- Initial population of buttons
renderMounts("All")
