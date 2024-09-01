lineheight = 37

-- Table to store the currently visible mounts
local visibleMounts = {}

-- Function to check if the player can fly
local function canPlayerFly()
    local hasExpertRiding = IsSpellKnown(34090)
    local hasArtisanRiding = IsSpellKnown(34091)
    local hasMasterRiding = IsSpellKnown(90265)
    local isFlyable = IsFlyableArea()

    return (hasExpertRiding or hasArtisanRiding or hasMasterRiding) and isFlyable
end

-- Function to check if a mount is flying
local function isMountFlying(typeId)
    -- Check if mount type or other known factors indicate that it is a flying mount
    -- https://wowpedia.fandom.com/wiki/API_C_MountJournal.GetMountInfoExtraByID
    local flyingMountTypes = { 
        [247] = true, -- Disc of the Red Flying Cloud
        [248] = true, -- flying mounts, including those that change capability based on riding skill
        [402] = true, -- dragonriding
        [407] = true, -- Ability mount
        [424] = true, -- Dragonriding mounts, including mounts that have dragonriding animations but are not yet enabled for dragonriding
    }
    return flyingMountTypes[typeId]
end

-- Function to filter mounts by usability, skeleton, and color
local function filterMounts()
    local filteredMounts = {}

    for _, mountID in ipairs(C_MountJournal.GetMountIDs()) do
        local name, spellID, icon, active, isUsable, sourceType, isFavorite, isFactionSpecific, faction, hideOnChar, isCollected = C_MountJournal.GetMountInfoByID(mountID)
        local creatureDisplayInfoID, descriptionText, sourceText, isSelfMount, mountType, mountFaction, shouldHideOnChar, isCollected, isFavorite, isFactionSpecific, faction, isFlying, isAquatic, isGround, isJumping = C_MountJournal.GetMountInfoExtraByID(mountID)

        if isUsable and isCollected then
            local mountInfo = findMountByID(mountID)  -- Assuming this function gets extra info about the mount

            if mountInfo then
                -- Debugging output to check the retrieved skeleton type
                --print("Mount Name:", name)
                --print("Skeleton Type:", mountInfo.skeleton_type)

                -- Use lower-case comparisons only if color and skeleton exist
                local colorMatches = (selectedColor == "All") or (mountInfo.color and string.lower(mountInfo.color) == string.lower(selectedColor))
                local skeletonMatches = (selectedSkeleton == "All") or (mountInfo.skeleton_type and string.lower(mountInfo.skeleton_type) == string.lower(selectedSkeleton))

                if colorMatches and skeletonMatches then
                    local canFly = isMountFlying(mountType)

                    --print("Mount:", name, "Can fly:", canFly, "Type ID:", mountType, "Skeleton Matches:", skeletonMatches)
                    table.insert(filteredMounts, {
                        id = mountID,
                        name = name,
                        icon = icon,
                        isFlying = canFly
                    })
                end
            end
        end
    end

    return filteredMounts
end



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
        mountIcon:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 10, -10 - (i-1) * lineheight)
        mountIcon:SetTexture(mount.icon)  -- Get the icon texture

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

        -- Create text for the mount name
        local mountText = contentFrame:CreateFontString(nil, "OVERLAY")
        mountText:SetFontObject("GameFontNormal")
        mountText:SetPoint("LEFT", mountIcon, "RIGHT", 10, 0)
        mountText:SetText(mount.name)
    end

    -- Add a button to summon a random mount from the visible list
    local randomMountButton = CreateFrame("Button", "RandomMountButton", mountSelectorFrame, "UIPanelButtonTemplate")
    randomMountButton:SetSize(120, 22)
    randomMountButton:SetPoint("BOTTOM", mountSelectorFrame, "BOTTOM", 0, 10)
    randomMountButton:SetText("Random Mount")

    randomMountButton:SetScript("OnClick", function()
        if #visibleMounts > 0 then
            local flyingMounts = {}
            local groundMounts = {}

            for _, mount in ipairs(visibleMounts) do
                if mount.isFlying then
                    table.insert(flyingMounts, mount)
                else
                    table.insert(groundMounts, mount)
                end
            end

            local chosenMounts
            if canPlayerFly() and #flyingMounts > 0 then
                chosenMounts = flyingMounts
            else
                chosenMounts = groundMounts
            end

            if #chosenMounts > 0 then
                local randomIndex = math.random(1, #chosenMounts)
                C_MountJournal.SummonByID(chosenMounts[randomIndex].id)
            else
                print("No mounts available to summon.")
            end
        else
            print("No mounts available to summon.")
        end
    end)

    -- Bind the "K" key to trigger the random mount button
    SetOverrideBindingClick(mountSelectorFrame, true, "K", "RandomMountButton")
end

-- Function to render mounts after filtering
function renderMounts()
    -- Get the filtered list of mounts based on usability, skeleton, and color
    local filteredMounts = filterMounts()

    -- Render only the filtered mounts
    createMountButtons(filteredMounts)
end

-- Function to find mount by ID (assuming this function exists and provides extra info like color and skeleton)
function findMountByID(id)
    for _, mount in ipairs(mounts) do
        if mount.id == id then
            return mount
        end
    end
    return nil
end
