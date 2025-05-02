local function resetPetFilters()
    C_PetJournal.SetFilterChecked(LE_PET_JOURNAL_FILTER_COLLECTED, true)
    C_PetJournal.SetFilterChecked(LE_PET_JOURNAL_FILTER_NOT_COLLECTED, true)
    C_PetJournal.SetSearchFilter("")

    for index = 1, C_PetJournal.GetNumPetTypes() do
        C_PetJournal.SetPetTypeFilter(index, true)
    end

    for index = 1, C_PetJournal.GetNumPetSources() do
        C_PetJournal.SetPetSourceChecked(index, true)
    end
end

local function getPetInfoBySpeciesId(speciesID)
    local allPets = RuthesMS.data.pets

    for i = 1, #allPets do
        if allPets[i].speciesID == speciesID then
            return allPets[i]
        end
    end
    print("No pet found with species ID: " .. speciesID)
end

local function getAvailablePets()
    local availablePets = {}
    local numPets, _ = C_PetJournal.GetNumPets()

    for i = 1, numPets do
        local petGUID, thisSpeciesID, isOwned, _, _, favorite, _, speciesName, _, type = C_PetJournal.GetPetInfoByIndex(
            i)
        local petInfo = getPetInfoBySpeciesId(thisSpeciesID)

        -- Uncomment to output missing pets
        -- if not petInfo then
        --     print("Missing pet> Name: " .. speciesName .. ", speciesID: " .. thisSpeciesID .. ", type: " .. type)
        -- end

        if petInfo and isOwned then
            table.insert(availablePets, {
                petGUID = petGUID,
                speciesID = thisSpeciesID,
                isOwned = isOwned,
                speciesName = speciesName,
                race = petInfo.race,
                color = petInfo.color,
                druid = petInfo.druid,
                warlock = petInfo.warlock,
                shaman = petInfo.shaman,
                deathknight = petInfo.deathknight,
                mage = petInfo.mage,
                priest = petInfo.priest,
                type = type,
                favorite = favorite,
            })
        end
    end

    RuthesMS.state.availablePets = availablePets
end

local function getPetsByRace(raceList)
    local availablePets = RuthesMS.state.availablePets
    local filteredPets = {}

    for petIndex = 1, #availablePets do
        for raceIndex = 1, #raceList do
            local pet = availablePets[petIndex]
            local race = raceList[raceIndex]

            if (((RuthesMS.settings.useOnlyPetFavourites and pet.favorite) or not RuthesMS.settings.useOnlyPetFavourites) and
                    (pet.race and pet.race:lower() == race:lower()) or (pet.druid and pet.druid:lower() == race:lower())) then
                table.insert(filteredPets, pet)
            end
        end
    end

    return filteredPets
end


local loadAvailablePets = function()
    local availablePets = RuthesMS.state.availablePets
    if not availablePets or #availablePets == 0 then
        RuthesMS.utils.pet.getAvailablePets()
        availablePets = RuthesMS.state.availablePets
    end
    return availablePets
end

local function summonPetByGUID(guid)
    -- Don't summon if the pet is already summoned
    local oldPetGUID = C_PetJournal.GetSummonedPetGUID()
    if oldPetGUID ~= guid then
        C_PetJournal.SummonPetByGUID(guid)
    end
end

local function getGlyphOfTheStarsPets()
    local availablePets = loadAvailablePets()
    local filteredPets = {}

    for i = 1, #availablePets do
        local pet = availablePets[i]
        if (pet.color == "ghost") then
            table.insert(filteredPets, pet)
        end
    end
    return filteredPets
end

local function summonPetByRace(raceList)
    if (not RuthesMS.settings.summonPetFromDruidForm or (RuthesMS.settings.noPetsInInstance and IsInInstance())) then
        return
    end

    resetPetFilters()
    loadAvailablePets()

    local filteredPets = {}

    if (RuthesMS.settings.useDruidGlyphOfTheStars) then
        local form = GetShapeshiftFormID()
        if (form >= 31 and form <= 35) then -- Moonkin form
            filteredPets = getGlyphOfTheStarsPets()
        end
    end

    if (#filteredPets == 0) then
        filteredPets = getPetsByRace(raceList)
    end

    if #filteredPets > 0 then
        local randomIndex = math.random(1, #filteredPets)
        local pet = filteredPets[randomIndex]
        summonPetByGUID(pet.petGUID)
    else
        -- Fail silently, no pets available
    end
end

local function checkFavorites(pet)
    return (RuthesMS.settings.useOnlyPetFavourites and pet.favorite) or not RuthesMS.settings.useOnlyPetFavourites
end

local function checkRace(pet, mountRace)
    if not pet.race then
        return false
    end

    -- Too few pets are horses, add stags to the list
    if mountRace:lower() == "horse" then
        return pet.race:lower() == "stag"
    end

    -- Too few gryphon pets, add birds to the list
    if mountRace:lower() == "gryphon" then
        return pet.race:lower() == "bird"
    end

    -- Too few mammoth pets, add kodo to the list
    if mountRace:lower() == "mammoth" then
        return pet.race:lower() == "kodo"
    end

    return pet.race:lower() == mountRace:lower()
end

local BattlePetTypes = {
    [1] = "Humanoid",
    [2] = "Dragonkin",
    [3] = "Flying",
    [4] = "Undead",
    [5] = "Critter",
    [6] = "Magic",
    [7] = "Elemental",
    [8] = "Beast",
    [9] = "Aquatic",
    [10] = "Mechanical",
}
local PetTypes = {
    ["Humanoid"] = 1,
    ["Dragonkin"] = 2,
    ["Flying"] = 3,
    ["Undead"] = 4,
    ["Critter"] = 5,
    ["Magic"] = 6,
    ["Elemental"] = 7,
    ["Beast"] = 8,
    ["Aquatic"] = 9,
    ["Mechanical"] = 10,
}

local function filterByClass(petList)
    local localizedClass, englishClass, classIndex = UnitClass("player")
    local filteredPets = {}

    local checkFunction = function(pet)
        return true
    end

    -- print("englishClass: " .. englishClass)

    if (englishClass == "WARLOCK") then
        checkFunction = function(pet) return pet.warlock end
    elseif (englishClass == "SHAMAN") then
        checkFunction = function(pet) return pet.shaman end
    elseif (englishClass == "DEATHKNIGHT") then
        checkFunction = function(pet) return pet.deathknight end
    elseif (englishClass == "MAGE") then
        checkFunction = function(pet) return pet.mage end
    elseif (englishClass == "DRUID") then
        checkFunction = function(pet)
            return pet.druid or
                pet.type == PetTypes["Beast"] or
                pet.type == PetTypes["Critter"]
        end
    elseif (englishClass == "EVOKER") then
        checkFunction = function(pet) return pet.type == PetTypes["Dragonkin"] end
    elseif (englishClass == "HUNTER") then
        checkFunction = function(pet)
            return pet.type == PetTypes["Beast"]
        end
    elseif (englishClass == "PRIEST") and GetSpecialization() == 3 then -- SHADOWPRIEST
        checkFunction = function(pet) return pet.priest end
    end

    for i = 1, #petList do
        local pet = petList[i]
        if checkFunction(pet) then
            if checkFavorites(pet) then
                table.insert(filteredPets, pet)
            end
        end
    end

    return filteredPets
end

local function filterPets(mountRace, mountColor, petList)
    local filteredPets = {}

    for i = 1, #petList do
        local pet = petList[i]
        if pet.race and pet.color then
            if checkFavorites(pet) and
                checkRace(pet, mountRace) and
                pet.color:lower() == mountColor:lower() then
                table.insert(filteredPets, pet)
            end
        end
    end

    if #filteredPets == 0 then
        -- If no matching both color and race, only match race
        for i = 1, #petList do
            local pet = petList[i]
            if checkFavorites(pet) and
                checkRace(pet, mountRace) then
                table.insert(filteredPets, pet)
            end
        end
    end

    if #filteredPets == 0 then
        -- If no matching race, try to match color
        for i = 1, #petList do
            local pet = petList[i]
            if checkFavorites(pet) and
                pet.color and pet.color:lower() == mountColor:lower() then
                table.insert(filteredPets, pet)
            end
        end
    end

    if #filteredPets == 0 then
        -- If stil no matching, return every pet
        filteredPets = petList
    end

    return filteredPets
end

local function summonPetFromMount(mount)
    if (not RuthesMS.settings.summonPetFromMount or (RuthesMS.settings.noPetsInInstance and IsInInstance())) then
        return
    end

    if not mount then
        print("No mount provided for pet summoning.")
        return
    end

    resetPetFilters()

    local availablePets = loadAvailablePets()

    local filteredPets
    if (RuthesMS.settings.useClassPets) then
        filteredPets = filterByClass(availablePets)
        if (#filteredPets == 0) then -- If no pets, try to match all instead
            filteredPets = filterPets(mount.skeleton_type, mount.color, availablePets)
        else
            -- Try to match the filtered pets to the mount too
            filteredPets = filterPets(mount.skeleton_type, mount.color, filteredPets)
        end
    else
        filteredPets = filterPets(mount.skeleton_type, mount.color, availablePets)
    end

    if #filteredPets > 0 then
        local randomIndex = math.random(1, #filteredPets)
        local pet = filteredPets[randomIndex]
        summonPetByGUID(pet.petGUID)
    else
        -- Fail silently, no pets available
        -- print("No pets available for summon.")
    end
end



RuthesMS.utils.pet = {
    summonRandomPet = summonPetFromMount,
    summonPetByRace = summonPetByRace,
    getAvailablePets = getAvailablePets,
}
