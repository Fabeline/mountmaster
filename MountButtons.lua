-- MountButtons.lua

lineheight = 37

-- Table to store the currently visible mounts
local visibleMounts = {}

-- Function to create new mount buttons
local function createMountButtons(mountList)
    -- Refresh the content frame
    deleteContentFrame()
    createContentFrame()

    -- Clear the visibleMounts table
    visibleMounts = {}

    -- Set the height of the content frame based on the number of mounts
    local contentHeight = #mountList * lineheight
    contentFrame:SetHeight(contentHeight)

    for i, mount in ipairs(mountList) do
        -- Add the mount to the visibleMounts table
        table.insert(visibleMounts, mount)

        -- Create a texture for the mount icon
        local mountIcon = contentFrame:CreateTexture(nil, "ARTWORK")
        mountIcon:SetSize(32, 32)  -- Set icon size
        mountIcon:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 10, -30 - (i-1) * lineheight)
        mountIcon:SetTexture(select(3, C_MountJournal.GetMountInfoByID(mount.id)))  -- Get the icon texture

        -- Create a button over the icon to make it clickable
        local iconButton = CreateFrame("Button", nil, contentFrame)
        iconButton:SetAllPoints(mountIcon)  -- Make the button the same size and position as the icon

        -- Add highlight texture (on hover)
        iconButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
        
        -- Add pressed texture (on click)
        iconButton:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")

        -- Create the animation group for scaling effect
        local animGroup = iconButton:CreateAnimationGroup()
        
        -- Create the scaling animation
        local scaleUp = animGroup:CreateAnimation("Scale")
        scaleUp:SetScale(1.2, 1.2)  -- Scale up by 20%
        scaleUp:SetDuration(0.1)  -- Duration of the scale up
        scaleUp:SetOrder(1)  -- Play this first

        local scaleDown = animGroup:CreateAnimation("Scale")
        scaleDown:SetScale(0.83, 0.83)  -- Scale back to original size
        scaleDown:SetDuration(0.1)  -- Duration of the scale down
        scaleDown:SetOrder(2)  -- Play this after the scale up

        -- Set the summon action using the correct ID
        iconButton:SetScript("OnClick", function()
            animGroup:Play()  -- Play the animation
            C_MountJournal.SummonByID(mount.id)
        end)

        -- Show tooltip with mount name on hover
        iconButton:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(mount.name)
            GameTooltip:Show()
        end)
        iconButton:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        -- Create text for the mount name
        local mountText = contentFrame:CreateFontString(nil, "OVERLAY")
        mountText:SetFontObject("GameFontNormal")
        mountText:SetPoint("LEFT", mountIcon, "RIGHT", 10, 0)
        mountText:SetText(mount.name)
    end

    -- Add a button to summon a random mount from the visible list
    local randomMountButton = CreateFrame("Button", "RandomMountButton", mountSelectorFrame, "UIPanelButtonTemplate")
    randomMountButton:SetSize(130, 22)
    randomMountButton:SetPoint("BOTTOM", mountSelectorFrame, "BOTTOM", 0, 10)
    randomMountButton:SetText("Random Mount (K)")

    randomMountButton:SetScript("OnClick", function()
        if #visibleMounts > 0 then
            local randomIndex = math.random(1, #visibleMounts)
            C_MountJournal.SummonByID(visibleMounts[randomIndex].id)
        else
            print("No mounts available to summon.")
        end
    end)

    -- Bind the "K" key to trigger the random mount button
    SetOverrideBindingClick(mountSelectorFrame, true, "K", "RandomMountButton")
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
