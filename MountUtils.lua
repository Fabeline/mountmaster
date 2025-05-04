local function canPlayerFly()
    local isFlyable = IsFlyableArea()

    if isFlyable then
        return true
    else
        return false
    end
end

local function isMountFlying(typeId)
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

    if typeId == 231 or  -- Riding turtle, sea turtle, savage ebony battle turtle
        typeId == 232 or -- Vash'ir seahorse
        typeId == 254 or -- poseidus, tidestallions, brinedeep bottom-feeder and fathom dweller, surf jelly
        typeId == 412    -- ottuks
    then
        isAquatic = true
    end

    if RuthesMS.utils.mount.isMountFlying(typeId) and RuthesMS.utils.mount.isSteadyFlightActive() and
        (
            typeId == 407 or -- Deepstar polyp and otterwordly ottuk carrier
            typeId == 436    -- Depthstalker, corrupted behemoth
        )
    then
        isAquatic = true
    end

    return isAquatic
end

local function hasGroundAnim(mountId, skeleton_type)
    local typeHasGroundAnimTbl = {
        ["horse"] = true,
        ["cat"] = true,
        ["stag"] = true,
        ["rat"] = true,
    }
    if typeHasGroundAnimTbl[skeleton_type] then
        return true
    end

    local hasGroundAnimTbl = {
        ["1450"] = true, -- Soaring razorwing
        ["1508"] = true, -- Fierce Razorwing
        ["1510"] = true, -- Dusklight Razorwing
        ["1509"] = true, -- Garnet razorwing
    }

    if hasGroundAnimTbl[mountId] then
        return true
    end

    return false;
end

local function getAvailableMounts()
    local availableMounts = {}
    local zoneId = C_Map.GetBestMapForUnit("player")
    local vashirMountAllowed = zoneId == 5146

    -- Use small mounts if in an instance
    local useSmallMounts = (IsInInstance() and RuthesMS.settings.smallMountInInstance)

    for _, mountID in ipairs(C_MountJournal.GetMountIDs()) do
        local name, spellID, icon, _, isUsable, _, isFavorite, _, _, _, isCollected =
            C_MountJournal.GetMountInfoByID(mountID)

        local _, _, _, _, mountType = C_MountJournal.GetMountInfoExtraByID(mountID)

        local isUtilityMount = RuthesMS.utils.summon.isUtilityMount(mountID)

        -- Uncomment to output missing mounts
        -- local mountInfo = RuthesMS.utils.mount.findMountByID(mountID)
        -- if not mountInfo then
        --     print("Missing> Name: " .. name .. ", mountID: " .. mountID)
        -- end

        if isUsable and isCollected and
            ((isUtilityMount and not RuthesMS.settings.dontIncludeUtilityMounts) or not isUtilityMount) and
            ((isFavorite and RuthesMS.settings.useOnlyFavourites) or not RuthesMS.settings.useOnlyFavourites) then
            local mountInfo = RuthesMS.utils.mount.findMountByID(mountID)

            -- Validate mount info and apply small mount filtering
            if (mountID == 373 and not vashirMountAllowed) then
                -- skip varshir mount
            elseif mountInfo and
                ((useSmallMounts and tostring(mountInfo.is_small) == "true") or not useSmallMounts) then
                local canFly = RuthesMS.utils.mount.isMountFlying(mountType)
                local canSwim = RuthesMS.utils.mount.isAquaticMount(mountType)

                -- print(name .. ", mountType: " .. mountType )

                -- Add mount to the available list
                table.insert(availableMounts, {
                    id = mountID,
                    name = name,
                    icon = icon,
                    isFlying = canFly,
                    isAquatic = canSwim,
                    isFavorite = isFavorite,
                    isSmall = mountInfo.is_small,
                    spellID = spellID,
                    color = mountInfo.color,
                    secondary_color = mountInfo.secondary_color,
                    skeleton_type = mountInfo.skeleton_type,
                    expansion = mountInfo.expansion,
                    looks = mountInfo.looks,
                    is_small = mountInfo.is_small,
                })
            end
        end
    end
    return availableMounts
end

local function findMountByID(id)
    for _, mount in ipairs(RuthesMS.data.mounts) do
        if mount.id == id then
            return mount
        end
    end
    return nil
end


local function reloadMounts()
    local availableMounts = RuthesMS.utils.mount.getAvailableMounts()
    RuthesMS.state.availableMounts = availableMounts
    RuthesMS.state.currentMounts = RuthesMS.utils.filter.filterMounts(availableMounts)
end


local function displayBigMessage(message)
    UIErrorsFrame:AddMessage(message, 1.0, 0.0, 0.0) -- text, red, green, blue
end

local function canSummonMount()
    -- Check if the player is in combat
    if UnitAffectingCombat("player") then
        displayBigMessage("You cannot mount in combat.")
        -- return false -> you can summon in some instances like Dawnbreaker and Tindral
    end

    -- Check if the player is dead or in ghost form
    if UnitIsDeadOrGhost("player") then
        displayBigMessage("You cannot mount while dead or in ghost form.")
        return false
    end

    -- Check if the player is indoors
    if IsIndoors() then
        displayBigMessage("You cannot mount indoors.")
        return false
    end

    return true
end


local function isSteadyFlightActive()
    local buffName = "Flight Style: Steady"
    return AuraUtil.FindAuraByName(buffName, "player", "HELPFUL") ~= nil
end

RuthesMS.utils.mount = {
    canPlayerFly = canPlayerFly,
    isMountFlying = isMountFlying,
    isAquaticMount = isAquaticMount,
    hasGroundAnim = hasGroundAnim,
    getAvailableMounts = getAvailableMounts,
    findMountByID = findMountByID,
    reloadMounts = reloadMounts,
    isSteadyFlightActive = isSteadyFlightActive,
    canSummonMount = canSummonMount,
    detectMountSummon = detectMountSummon
}
