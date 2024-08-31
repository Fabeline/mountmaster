-- MountButtons.lua

-- Print to confirm the file is loading
print("MountButtons.lua is running")

-- Function to clear the contentFrame
local function clearContentFrame()
    -- Remove all child elements from contentFrame
    if contentFrame then
        for i = contentFrame:GetNumChildren(), 1, -1 do
            local child = select(i, contentFrame:GetChildren())
            child:Hide()
            child:SetParent(nil)
            child = nil
        end
    end
end

-- Function to create new mount buttons
local function createMountButtons(mountList)
    -- Clear the contentFrame by removing all its children
    clearContentFrame()

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
        print("Created mount text for:", mount.name)

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

-- Function to filter mounts based on selected color
local function filterMounts(color)
    local filteredMounts = {}
    local maxMounts = 200  -- Load up to 200 mounts

    for i = 1, maxMounts do
        local mount = mounts[i]
        if mount then
            if color == "All" or mount.color == color then
                table.insert(filteredMounts, mount)
                print("Mount added to filtered list:", mount.name, "Color:", mount.color)
            else
                print("Mount filtered out:", mount.name, "Color:", mount.color)
            end
        end
    end

    -- Debugging: Print the count of filtered mounts
    print("Filtered Mounts Count:", #filteredMounts)

    return filteredMounts
end

-- Function to render mounts after filtering
function renderMounts(color)
    if not contentFrame then
        print("Error: contentFrame is not available during renderMounts!")
        return
    end
    local filteredMounts = filterMounts(color)
    createMountButtons(filteredMounts)
end

-- Initial population of buttons
renderMounts("All")
