local function isInProwl()
    return C_UnitAuras.GetPlayerAuraBySpellID(5215) ~= nil
end


local function getPetRaces()
    local form = GetShapeshiftFormID()

    local petRaces = {}

    if form == 0 then -- Normal
        -- Dont use any pet
    elseif form == nil then
        --print("No form detected")
    elseif form == 1 then       -- Cat form
        if not isInProwl() then -- Don't break stelath
            table.insert(petRaces, "Cat")
        end
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
    else
        --print("Unknown form detected: " .. tostring(form))
    end

    return petRaces
end

local function summonDruidPet()
    local form = GetShapeshiftFormID()

    -- Summon pets after 0.5 sec
    C_Timer.After(1, function()
        local petRaces = getPetRaces()
        if #petRaces > 0 then
            RuthesMS.utils.pet.summonPetByRace(petRaces)
        end
    end
    )
end

local function debounce(func, delay, getTime)
    local lastCall = 0

    return function(...)
        local now = getTime()
        if now - lastCall >= delay then
            lastCall = now
            return func(...)
        end
    end
end

local function shapeshiftDetection()
    C_Timer.After(0.5, function()
        if RuthesMS.settings.summonPetFromDruidForm then
            RuthesMS.utils.druid.summonDruidPet()
        end
    end)
end

local function detectShapseshift()
    local debouncedShapeshiftDetection = debounce(shapeshiftDetection, 0.5, GetTime)
    -- Listen for shapeshift
    local _, class = UnitClass("player")
    if class == "DRUID" then
        local f = CreateFrame("Frame")
        f:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
        f:SetScript("OnEvent", debouncedShapeshiftDetection)
    end
end

RuthesMS.utils.druid = {
    summonDruidPet = summonDruidPet,
    detectShapseshift = detectShapseshift
}
