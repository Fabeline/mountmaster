local lineheight = 37

local twwFlyingZones = {
    [2248] = true, -- Isle of Dorn
    [2339] = true, -- Dornogal
    [2215] = true, -- Hallowfall
    [2214] = true, -- The Ringing Deeps
    [2255] = true, -- Azj-Kahet
    [2256] = true, -- Azj-Kahet - Lower
    [2213] = true, -- City of Threads
    [2216] = true, -- City of Threads - Lower
}

function canPlayerFly()
    -- The War within zones are not added to the IsFlyableArea function... so we need to add them manually
    local isFlyable = IsFlyableArea() --or twwFlyingZones[zoneId]

    if isFlyable then
        return true
    else
        return false
    end
end

-- Check if a mount is flying
local function isMountFlying(typeId)
    -- Check if mount type or other known factors indicate that it is a flying mount
    -- https://wowpedia.fandom.com/wiki/API_C_MountJournal.GetMountInfoExtraByID
    local flyingMountTypes = { 
        [247] = true, -- Disc of the Red Flying Cloud
        [248] = true, -- flying mounts, including those that change capability based on riding skill
        [402] = true, -- dragonriding
        [407] = true, -- Ability mount
        [424] = true, -- Dragonriding mounts, including mounts that have dragonriding animations but are not yet enabled for dragonriding
        [436] = true, -- Swimming and flying mounts
    }
    return flyingMountTypes[typeId]
end

-- Uncomment to check specific mount type
-- local _, _, _, _, mountType = C_MountJournal.GetMountInfoExtraByID(1260)
-- print ("mountType: " .. mountType)

local function isAquaticMount(typeId)
    local isAquatic = false

    if typeId == 231 or -- Riding turtle, sea turtle, savage ebony battle turtle
        typeId == 232 or -- Vash'ir seahorse
        typeId == 254 or -- poseidus, tidestallions, brinedeep bottom-feeder and fathom dweller, surf jelly
        typeId == 412 -- ottuks
    then
        isAquatic = true
    end

    if isMountFlying(typeId) and isSteadyFlightActive() and 
        (
            typeId == 407 or -- Deepstar polyp and otterwordly ottuk carrier
            typeId == 436 -- Depthstalker, corrupted behemoth
        )
    then
        isAquatic = true
    end

    return isAquatic
end

function hasGroundAnim(mountId, skeleton_type)
    local typeHasGroundAnim = {
        ["horse"] = true,
        ["cat"] = true,
        ["stag"] = true,
        ["rat"] = true,
    }
    if typeHasGroundAnim[skeleton_type] then
        return true
    end

    local hasGroundAnim = {
        ["1450"] = true, -- Soaring razorwing
        ["1508"] = true, -- Fierce Razorwing
        ["1510"] = true, -- Dusklight Razorwing
        ["1509"] = true, -- Garnet razorwing
    }

    if hasGroundAnim[mountId] then
        return true
    end

    return false;
end

local function getAvailableMounts()
    local availableMounts = {}
    local zoneId = C_Map.GetBestMapForUnit("player")
    local vashirMountAllowed = zoneId == 5146
                

    -- Use small mounts if in an instance
    local useSmallMounts = (IsInInstance() and smallMountInInstance)

    for _, mountID in ipairs(C_MountJournal.GetMountIDs()) do
        local name, spellID, icon, _, isUsable, _, isFavorite, _, _, _, isCollected = 
            C_MountJournal.GetMountInfoByID(mountID)

        local _, _, _, _, mountType = C_MountJournal.GetMountInfoExtraByID(mountID)

        -- Uncomment to output missing mounts
        -- local mountInfo = findMountByID(mountID)
        -- if not mountInfo then
        --     print("Missing> Name: " .. name .. ", mountID: " .. mountID)
        -- end

        if isUsable and isCollected and 
           ((isFavorite and useOnlyFavourites) or not useOnlyFavourites) then

            local mountInfo = findMountByID(mountID)

            -- Validate mount info and apply small mount filtering
            if(mountID == 373 and not vashirMountAllowed) then
                -- skip varshir mount
            elseif mountInfo and 
               ((useSmallMounts and tostring(mountInfo.is_small) == "true") or not useSmallMounts) then

                local canFly = isMountFlying(mountType)
                local canSwim = isAquaticMount(mountType)

                -- print(name .. ", mountType: " .. mountType)
                
                -- Add mount to the available list
                table.insert(availableMounts, {
                    id = mountID,
                    name = name,
                    icon = icon,
                    isFlying = canFly,
                    isAquatic = canSwim,
                    isSmall = mountInfo.is_small,
                    spellID = spellID,
                    color = mountInfo.color,
                    secondary_color = mountInfo.secondary_color,
                    skeleton_type = mountInfo.skeleton_type,
                })
            end
        end
    end

    return availableMounts
end



local function createMountButtons()
    -- Refresh the content frame
    deleteContentFrame()
    createContentFrame()

    -- Set the height of the content frame based on the number of mounts
    local contentHeight = #currentMounts * lineheight
    contentFrame:SetHeight(contentHeight)

    for i, mount in ipairs(currentMounts) do
        -- Create a texture for the mount icon
        local mountIcon = contentFrame:CreateTexture(nil, "ARTWORK")
        mountIcon:SetSize(32, 32)
        mountIcon:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 10, - (i-1) * lineheight)
        mountIcon:SetTexture(mount.icon)

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
    
    loadRandomMountButton(currentMounts)
end

function reloadMounts()
    local availableMounts = getAvailableMounts()
    currentMounts = filterMounts(availableMounts)
    allMounts = availableMounts
end

function renderMounts()
    reloadMounts()
    createMountButtons(currentMounts)
end

function findMountByID(id)
    for _, mount in ipairs(mounts) do
        if mount.id == id then
            return mount
        end
    end
    return nil
end
