local mountToPets = {
    ["horse"] = { "horse" },
    ["wolf"] = { "wolf", "dog" },
    ["stag"] = { "stag" },
    ["cat"] = { "cat" },
    ["dinosaur"] = { "dinosaur" },
    ["bear"] = { "bear" },
    ["dragon"] = { "dragon" },
    ["mechanical"] = { "mechanical" },
    ["kodo"] = { "kodo" },
    ["insect"] = { "insect" },
    ["crocodile"] = { "crocodile" },
    ["gryphon"] = { "gryphon" },
    ["emu"] = { "emu" },
    ["mammoth"] = { "mammoth" },
    ["fish"] = { "fish" },
    ["bird"] = { "bird" },
    ["kite"] = { "kite" },
    ["serpent"] = { "serpent" },
    ["rat"] = { "rat" },
    ["bat"] = { "bat" },
    ["gargoyle"] = { "gargoyle" },
    ["elemental"] = { "elemental" },
    ["spider"] = { "spider" },
    ["snail"] = { "snail" }
}

local function summonRandomPetBySpeciesID(speciesID)
    local matchingPets = {}

    for i = 1, C_PetJournal.GetNumPets() do
        local petGUID, thisSpeciesID, isOwned = C_PetJournal.GetPetInfoByIndex(i)
        if isOwned and thisSpeciesID == speciesID then
            table.insert(matchingPets, petGUID)
        end
    end

    if #matchingPets > 0 then
        local petGUID = matchingPets[math.random(#matchingPets)]
        C_PetJournal.SummonPetByGUID(petGUID)
        print("Summoning random pet with species ID:", speciesID)
    else
        print("You don't own a pet with species ID:", speciesID)
    end
end

local function summonPetFromLastMount()
    local mount = RuthesMS.utils.mount.findMountByID(RuthesMS.state.lastSummonedMount)

    if not mount then
        print("No mount summoned yet.")
        return
    else
        print("Last summoned mount:", mount)
    end

    local filteredPets = {}
    local skeletonType = mount.skeleton_type:lower()
    local lookingForPetRace = mountToPets[skeletonType]

    -- start debu

    print("Mount skeleton type:", skeletonType)
    print("Mapped races for this mount type:")

    print("Scanning pets... total:", #RuthesMS.data.pets)

    for i = 1, #RuthesMS.data.pets do
        local pet = RuthesMS.data.pets[i]
        print("PET")

        if pet and pet.race then
            local petRace = pet.race:lower()
            print("Pet", i, "race:", petRace)

            for _, race in ipairs(lookingForPetRace) do
                print("Checking race:", race)
                if petRace == race then
                    print("→ Match found!")
                    table.insert(filteredPets, pet)
                    break
                end
            end
        else
            print("Pet", i, "is missing race data")
        end
    end

    -- end debug

    if not lookingForPetRace then
        print("No race mapping for mount type:", skeletonType)
        return
    end

    for i = 1, #RuthesMS.data.pets do
        local pet = RuthesMS.data.pets[i]
        local petRace = pet.race:lower()

        for _, race in ipairs(lookingForPetRace) do
            if petRace == race then
                table.insert(filteredPets, pet)
                break
            end
        end
    end

    if #filteredPets > 0 then
        local randomIndex = math.random(1, #filteredPets)
        local pet = filteredPets[randomIndex]
        summonRandomPetBySpeciesID(pet.speciesID)
        print("Summoning pet with speciesID:", pet.speciesID)
    else
        print("No matching pets found for the last summoned mount.")
    end
end




local function summonPet()
    local targetSpeciesID = 536
    local numPets, numOwned = C_PetJournal.GetNumPets()

    for i = 1, numPets do
        local petGUID, speciesID, isOwned = C_PetJournal.GetPetInfoByIndex(i)
        if isOwned and speciesID == targetSpeciesID then
            C_PetJournal.SummonPetByGUID(petGUID)
            print("Summoning pet with species ID:", targetSpeciesID)
            return
        end
    end
end

local function summonRandomPet()
    local numPets, numOwned = C_PetJournal.GetNumPets()

    if numOwned > 0 then
        local randomIndex = math.random(1, numOwned)
        local petGUID, speciesID, isOwned = C_PetJournal.GetPetInfoByIndex(randomIndex)

        if isOwned then
            C_PetJournal.SummonPetByGUID(petGUID)
            print("Summoning pet with speciesID:", speciesID)
        else
            print("You don't own a pet with GUID:", petGUID)
        end
    else
        print("You don't own any pets.")
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
    summonRandomPet = summonPetFromLastMount,
}
