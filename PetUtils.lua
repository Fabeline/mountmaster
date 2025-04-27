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
        local petGUID, thisSpeciesID, isOwned, _, _, favorite, _, speciesName = C_PetJournal.GetPetInfoByIndex(i)
        local petInfo = getPetInfoBySpeciesId(thisSpeciesID)

        if petInfo and isOwned then
            table.insert(availablePets, {
                petGUID = petGUID,
                speciesID = thisSpeciesID,
                isOwned = isOwned,
                speciesName = speciesName,
                race = petInfo.race,
                color = petInfo.color,
                druid = petInfo.druid,
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

local function summonPetByRace(raceList)
    if (not RuthesMS.settings.summonPetFromDruidForm or (RuthesMS.settings.noPetsInInstance and IsInInstance())) then
        return
    end
    resetPetFilters()

    local filteredPets = getPetsByRace(raceList)

    if #filteredPets > 0 then
        local randomIndex = math.random(1, #filteredPets)
        local pet = filteredPets[randomIndex]
        C_PetJournal.SummonPetByGUID(pet.petGUID)
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

    local availablePets = RuthesMS.state.availablePets
    if not availablePets or #availablePets == 0 then
        RuthesMS.utils.pet.getAvailablePets()
        availablePets = RuthesMS.state.availablePets
        return
    end

    local filteredPets = filterPets(mount.skeleton_type, mount.color, availablePets)

    if #filteredPets > 0 then
        local randomIndex = math.random(1, #filteredPets)
        local pet = filteredPets[randomIndex]

        -- Don't summon if the pet is already summoned
        local oldPetGUID = UnitGUID("pet")
        if oldPetGUID ~= pet.petGUID then
            C_PetJournal.SummonPetByGUID(pet.petGUID)
        end
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
