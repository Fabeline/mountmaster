local repairMounts = {
    280,  -- Traveler's Tundra Mammoth
    284,  -- Traveler's Tundra Mammoth
    2237, -- Grizzly Hills Packmaster
    1039  -- Mighty Caravan Brutosaur
}

local transmogMounts = {
    460,  -- Grand Expedition Yak
    2237, -- Grizzly Hills Packmaster
}

local auctionHouseMounts = {
    1039, -- Mighty Caravan Brutosaur
    2265  -- Trader's Gilded Brutosaur
}

local mailboxMounts = {
    2265 -- Trader's Gilded Brutosaur
}

local multipleMountsWithNpcs = {
    280,  -- Traveler's Tundra Mammoth
    284,  -- Traveler's Tundra Mammoth
    2237, -- Grizzly Hills Packmaster
    1039, -- Mighty Caravan Brutosaur
    2265, -- Trader's Gilded Brutosaur
}

local multipleMounts = {
    286,  -- Grand Black War Mammoth
    287,  -- Grand Black War Mammoth
    289,  -- Grand Ice Mammoth
    288,  -- Grand Ice Mammoth
    455,  -- Obsidian Nightwing (transmutation)
    1287, -- Explorer's Jungle Hopper
    240,  -- Mechano-Hog
    275,  -- Mekgineer's Chopper
    960,  -- Orgrimmar Interceptor
    1288, -- Explorer's Dunetrekker
    407,  -- Sandstone Drake
    959,  -- Stormwind Skychaser
    382,  -- X-53 Touring Rocket
}


local function summonRandomRepairMount()
    local availableRepairMounts = {}

    for _, mountID in ipairs(repairMounts) do
        local _, _, _, _, isUsable, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountID)
        if isUsable and isCollected then
            table.insert(availableRepairMounts, mountID)
        end
    end

    if #availableRepairMounts == 0 then
        print("No repair mounts available.")
        return
    end

    local randomIndex = math.random(1, #availableRepairMounts)
    C_MountJournal.SummonByID(availableRepairMounts[randomIndex])
end

local function summonRandomAuctionHouseMount()
    local availableAuctionHouseMounts = {}

    for _, mountID in ipairs(auctionHouseMounts) do
        local _, _, _, _, isUsable, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountID)
        if isUsable and isCollected then
            table.insert(availableAuctionHouseMounts, mountID)
        end
    end

    if #availableAuctionHouseMounts == 0 then
        print("No auction house mounts available.")
        return
    end

    local randomIndex = math.random(1, #availableAuctionHouseMounts)
    C_MountJournal.SummonByID(availableAuctionHouseMounts[randomIndex])
end

local function summonRandomTransmogMount()
    local availableTransmogMounts = {}

    for _, mountID in ipairs(transmogMounts) do
        local _, _, _, _, isUsable, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountID)
        if isUsable and isCollected then
            table.insert(availableTransmogMounts, mountID)
        end
    end

    if #availableTransmogMounts == 0 then
        print("No transmog mounts available.")
        return
    end

    local randomIndex = math.random(1, #availableTransmogMounts)
    C_MountJournal.SummonByID(availableTransmogMounts[randomIndex])
end

local function summonRandomMultipleMount()
    local availableMultipleMounts = {}

    for _, mountID in ipairs(multipleMounts) do
        local _, _, _, _, isUsable, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountID)
        if isUsable and isCollected then
            table.insert(availableMultipleMounts, mountID)
        end
    end

    if #availableMultipleMounts == 0 then
        -- If no multiple mounts are available, check for multiple mounts with NPCs
        for _, mountID in ipairs(multipleMountsWithNpcs) do
            local _, _, _, _, isUsable, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountID)
            if isUsable and isCollected then
                table.insert(availableMultipleMounts, mountID)
            end
        end
        if #availableMultipleMounts == 0 then
            print("No multiple mounts available.")
            return
        end
    end

    local flyingMounts = {}
    local groundMounts = {}

    for _, mountID in ipairs(availableMultipleMounts) do
        local _, _, _, _, mountType = C_MountJournal.GetMountInfoExtraByID(mountID)
        local canFly = RuthesMS.utils.mount.isMountFlying(mountType)

        if canFly then
            table.insert(flyingMounts, mountID)
        else
            table.insert(groundMounts, mountID)
        end
    end

    if #flyingMounts == 0 or not RuthesMS.utils.mount.canPlayerFly() then
        availableMultipleMounts = groundMounts
    else
        availableMultipleMounts = flyingMounts
    end

    local randomIndex = math.random(1, #availableMultipleMounts)

    C_MountJournal.SummonByID(availableMultipleMounts[randomIndex])
end

local function summonRandomMailboxMount()
    local availableMailboxMounts = {}

    for _, mountID in ipairs(mailboxMounts) do
        local _, _, _, _, isUsable, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountID)
        if isUsable and isCollected then
            table.insert(availableMailboxMounts, mountID)
        end
    end

    if #availableMailboxMounts == 0 then
        print("No mailbox mounts available.")
        return
    end

    local randomIndex = math.random(1, #availableMailboxMounts)
    C_MountJournal.SummonByID(availableMailboxMounts[randomIndex])
end

local function summonRandomMount(isSwimming)
    if IsMounted() then
        Dismount()
    else
        CancelShapeshiftForm()
        if (RuthesMS.utils.mount.canSummonMount() == false) then
            return
        end

        RuthesMS.utils.mount.reloadMounts()

        if #RuthesMS.state.currentMounts > 0 then
            local chosenMounts

            local flyingMounts = {}
            local groundMounts = {}
            local aquaticMounts = {}

            for _, mount in ipairs(RuthesMS.state.currentMounts) do
                if mount.isFlying then -- flying and aquatic if steady flight is active
                    table.insert(flyingMounts, mount)
                    -- Mounts with flying and aquatic have a bug where they are only fast
                    -- underwater if steady flight is active
                    if mount.isAquatic and RuthesMS.utils.mount.isSteadyFlightActive() then
                        table.insert(aquaticMounts, mount)
                    end
                elseif mount.isAquatic then -- aquatic and not flying
                    table.insert(aquaticMounts, mount)
                end

                if ((not mount.isFlying or RuthesMS.utils.mount.hasGroundAnim(mount.id, mount.skeleton_type)) and not mount.isAquatic) then
                    table.insert(groundMounts, mount)
                end
            end


            if (isSwimming) then
                if #aquaticMounts > 0 then
                    chosenMounts = aquaticMounts
                else
                    -- If the aquatic mounts don't fit the criteria, summon a random aquatic mount
                    RuthesMS.state.currentMounts = RuthesMS.state.availableMounts
                    if (#RuthesMS.state.currentMounts > 0) then
                        for _, mount in ipairs(RuthesMS.state.currentMounts) do
                            if mount.isAquatic then
                                table.insert(aquaticMounts, mount)
                            end
                        end
                        chosenMounts = aquaticMounts
                    else
                        print("No aquatic mounts available to summon.")
                    end
                end
            elseif RuthesMS.utils.mount.canPlayerFly() and #flyingMounts > 0 then
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

RuthesMS.utils.summon = {
    summonRandomMount = summonRandomMount,
    summonRandomRepairMount = summonRandomRepairMount,
    summonRandomTransmogMount = summonRandomTransmogMount,
    summonRandomAuctionHouseMount = summonRandomAuctionHouseMount,
    summonRandomMailboxMount = summonRandomMailboxMount,
    summonRandomMultipleMount = summonRandomMultipleMount,
}
