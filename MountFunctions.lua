local function canPlayerFly()
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

    if typeId == 231 or  -- Riding turtle, sea turtle, savage ebony battle turtle
        typeId == 232 or -- Vash'ir seahorse
        typeId == 254 or -- poseidus, tidestallions, brinedeep bottom-feeder and fathom dweller, surf jelly
        typeId == 412    -- ottuks
    then
        isAquatic = true
    end

    if RuthesMS.mountFunctions.isMountFlying(typeId) and RuthesMS.mountFunctions.isSteadyFlightActive() and
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
    local useSmallMounts = (IsInInstance() and RuthesMS.smallMountInInstance)

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
            ((isFavorite and RuthesMS.settings.useOnlyFavourites) or not RuthesMS.settings.useOnlyFavourites) then
            local mountInfo = RuthesMS.mountFunctions.findMountByID(mountID)

            -- Validate mount info and apply small mount filtering
            if (mountID == 373 and not vashirMountAllowed) then
                -- skip varshir mount
            elseif mountInfo and
                ((useSmallMounts and tostring(mountInfo.is_small) == "true") or not useSmallMounts) then
                local canFly = RuthesMS.mountFunctions.isMountFlying(mountType)
                local canSwim = RuthesMS.mountFunctions.isAquaticMount(mountType)

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
    local availableMounts = RuthesMS.mountFunctions.getAvailableMounts()
    RuthesMS.temp.availableMounts = availableMounts
    RuthesMS.temp.currentMounts = RuthesMS.filterFunctions.filterMounts(availableMounts)
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

local function summonRandomMount(isSwimming)
    if IsMounted() then
        Dismount()
    else
        CancelShapeshiftForm()
        if (RuthesMS.mountFunctions.canSummonMount() == false) then
            return
        end

        RuthesMS.mountFunctions.reloadMounts()

        if #RuthesMS.temp.currentMounts > 0 then
            local chosenMounts

            local flyingMounts = {}
            local groundMounts = {}
            local aquaticMounts = {}

            for _, mount in ipairs(RuthesMS.temp.currentMounts) do
                if mount.isFlying then -- flying and aquatic if steady flight is active
                    table.insert(flyingMounts, mount)
                    -- Mounts with flying and aquatic have a bug where they are only fast
                    -- underwater if steady flight is active
                    if mount.isAquatic and RuthesMS.mountFunctions.isSteadyFlightActive() then
                        table.insert(aquaticMounts, mount)
                    end
                elseif mount.isAquatic then -- aquatic and not flying
                    table.insert(aquaticMounts, mount)
                end

                if ((not mount.isFlying or RuthesMS.mountFunctions.hasGroundAnim(mount.id, mount.skeleton_type)) and not mount.isAquatic) then
                    table.insert(groundMounts, mount)
                end
            end


            if (isSwimming) then
                if #aquaticMounts > 0 then
                    chosenMounts = aquaticMounts
                else
                    -- If the aquatic mounts don't fit the criteria, summon a random aquatic mount
                    RuthesMS.temp.currentMounts = RuthesMS.temp.availableMounts
                    if (#RuthesMS.temp.currentMounts > 0) then
                        for _, mount in ipairs(RuthesMS.temp.currentMounts) do
                            if mount.isAquatic then
                                table.insert(aquaticMounts, mount)
                            end
                        end
                        chosenMounts = aquaticMounts
                    else
                        print("No aquatic mounts available to summon.")
                    end
                end
            elseif RuthesMS.mountFunctions.canPlayerFly() and #flyingMounts > 0 then
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
    end
end

local function isSteadyFlightActive()
    local buffName = "Flight Style: Steady"
    return AuraUtil.FindAuraByName(buffName, "player", "HELPFUL") ~= nil
end

RuthesMS.mountFunctions = {
    canPlayerFly = canPlayerFly,
    isMountFlying = isMountFlying,
    isAquaticMount = isAquaticMount,
    hasGroundAnim = hasGroundAnim,
    getAvailableMounts = getAvailableMounts,
    findMountByID = findMountByID,
    reloadMounts = reloadMounts,
    summonRandomMount = summonRandomMount,
    isSteadyFlightActive = isSteadyFlightActive,
    canSummonMount = canSummonMount
}
