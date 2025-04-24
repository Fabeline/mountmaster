local mountToPets = {
    ["horse"] = "horse",
    ["wolf"] = "wolf",
    ["dog"] = "wolf",
    ["stag"] = "stag",
    ["cat"] = "cat",
    ["dinosaur"] = "dinosaur",
    ["bear"] = "bear",
    ["dragon"] = "dragon",
    ["mechanical"] = "mechanical",
    ["kodo"] = "kodo",
    ["insect"] = "insect",
    ["crocodile"] = "crocodile",
    ["gryphon"] = "gryphon",
    ["emu"] = "emu",
    ["mammoth"] = "mammoth",
    ["fish"] = "fish",
    ["bird"] = "bird",
    ["kite"] = "kite",
    ["serpent"] = "serpent",
    ["rat"] = "rat",
    ["bat"] = "bat",
    ["gargoyle"] = "gargoyle",
    ["elemental"] = "elemental",
    ["spider"] = "spider",
    ["snail"] = "snail"
}

function FilterPets(lookForRace, lookForColor, petList, mount)
    local filteredPets = {}
    local skeletonType = mount.skeleton_type:lower()
    local lookingForPetRace = mountToPets[skeletonType]

    for i = 1, #RuthesMS.data.pets do
        local pet = RuthesMS.data.pets[i]

        if pet and pet.race then
            local petRace = pet.race:lower()

            for _, race in ipairs(lookingForPetRace) do
                if petRace == race then
                    table.insert(filteredPets, pet)
                    break
                end
            end
        end
    end

    return filteredPets
end

local function summonPetFromLastMount()
    local mount = RuthesMS.utils.mount.findMountByID(RuthesMS.state.lastSummonedMount)

    if not mount then
        return
    end

    local filteredPets = {}
    local skeletonType = mount.skeleton_type:lower()
    local lookingForPetRace = mountToPets[skeletonType]

    for i = 1, #RuthesMS.data.pets do
        local pet = RuthesMS.data.pets[i]

        if pet and pet.race then
            local petRace = pet.race:lower()

            for _, race in ipairs(lookingForPetRace) do
                if petRace == race then
                    table.insert(filteredPets, pet)
                    break
                end
            end
        end
    end

    local availablePets = {}
    local numPets, numOwned = C_PetJournal.GetNumPets()

    for i = 1, numPets do
        local petGUID, thisSpeciesID, isOwned = C_PetJournal.GetPetInfoByIndex(i)
        local petToBeInserted = {
            petGUID = petGUID,
            speciesID = thisSpeciesID,
            isOwned = isOwned
        }
        if isOwned then
            for _, pet in ipairs(filteredPets) do
                if thisSpeciesID == pet.speciesID then
                    table.insert(availablePets, petToBeInserted)
                    break
                end
            end
        end
    end


    if #availablePets > 0 then
        local randomIndex = math.random(1, #availablePets)
        local pet = availablePets[randomIndex]
        C_PetJournal.SummonPetByGUID(pet.petGUID)
    else
        print("No matching pets found for the last summoned mount.")
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
