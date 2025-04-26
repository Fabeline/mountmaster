local function getPetRaces()
    local form = GetShapeshiftFormID()

    local petRaces = {}

    if form == 0 then     -- Normal
        -- Dont use any pet
    elseif form == 1 then -- Cat form
        table.insert(petRaces, "Cat")
    elseif form == 2 then -- Tree of life
        table.insert(petRaces, "Tree")
    elseif form == 3 then -- Travel form
        table.insert(petRaces, "Stag")
        table.insert(petRaces, "Dinosaur")
    elseif form == 4 then  -- Aquatic form
        table.insert(petRaces, "Fish")
    elseif form == 5 then  -- Bear form
        table.insert(petRaces, "Bear")
    elseif form == 27 then -- Swift flight form
        table.insert(petRaces, "Bird")
        table.insert(petRaces, "Bat")
    elseif form == 29 then -- Flight form
        table.insert(petRaces, "Bird")
        table.insert(petRaces, "Bat")
    elseif form >= 31 and form <= 35 then
        table.insert(petRaces, "Moonkin")
    elseif form == 36 then
        table.insert(petRaces, "Tree")
    end

    return petRaces
end

local function showForm()
    RuthesMS.utils.pet.summonPetByRace(getPetRaces())
end

RuthesMS.utils.druid = {
    detectForm = showForm
}
