local function filterPets(mountRace, mountColor, petList)
    local filteredPets = {}

    for i = 1, #petList do
        local pet = petList[i]
        if pet.race and pet.color then
            if pet.race:lower() == mountRace:lower() and
                pet.color:lower() == mountColor:lower() then
                table.insert(filteredPets, pet)
            end
        end
    end

    if #filteredPets == 0 then
        -- If no matching both color and race, only match race
        for i = 1, #petList do
            local pet = petList[i]
            if pet.race and pet.race:lower() == mountRace:lower() then
                table.insert(filteredPets, pet)
            end
        end
    end

    if #filteredPets == 0 then
        -- If no matching race, try to match color
        for i = 1, #petList do
            local pet = petList[i]
            if pet.color and pet.color:lower() == mountColor:lower() then
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

local function getPetInfoBySpeciesId(speciesID)
    local allPets = RuthesMS.data.pets
    local petInfo = {}

    for i = 1, #allPets do
        if allPets[i].speciesID == speciesID then
            return allPets[i]
        end
    end
    print("No pet found with species ID: " .. speciesID)
end

local function summonPetFromMount(mount)
    if not mount then
        print("No mount provided for pet summoning.")
        return
    end

    local availablePets = {}
    local numPets, numOwned = C_PetJournal.GetNumPets()

    for i = 1, numPets do
        local petGUID, thisSpeciesID, isOwned, _, _, _, _, speciesName = C_PetJournal.GetPetInfoByIndex(i)
        local petInfo = getPetInfoBySpeciesId(thisSpeciesID)
        local petToBeInserted = {
            petGUID = petGUID,
            speciesID = thisSpeciesID,
            isOwned = isOwned,
            speciesName = speciesName,
            race = petInfo.race,
            color = petInfo.color,
            druid = petInfo.druid,
        }
        if isOwned then
            for _, pet in ipairs(RuthesMS.data.pets) do
                if thisSpeciesID == pet.speciesID then
                    table.insert(availablePets, petToBeInserted)
                    break
                end
            end
        end
    end

    local filteredPets = filterPets(mount.skeleton_type, mount.color, availablePets)

    if #filteredPets > 0 then
        local randomIndex = math.random(1, #filteredPets)
        local pet = filteredPets[randomIndex]
        C_PetJournal.SummonPetByGUID(pet.petGUID)
    else
        print("No pets available")
    end
end


local function dumpData()
    PetDumpData = PetDumpData or {}
    PetDumpData.pets = {}

    local seenSpecies = {}

    for i = 1, C_PetJournal.GetNumPets() do
        local petGUID, speciesID, isOwned, customName, level, favorite, isRevoked, speciesName, icon, petType =
            C_PetJournal.GetPetInfoByIndex(i)

        if not seenSpecies[speciesID] then
            table.insert(PetDumpData.pets, {
                name = speciesName,
                speciesID = speciesID,
                type = petType,
                icon = icon,
            })
            seenSpecies[speciesID] = true
        end
    end

    print("Dumped", #PetDumpData.pets, "unique species to SavedVariables.")
end


RuthesMS.utils.pet = {
    summonRandomPet = summonPetFromMount,
}
