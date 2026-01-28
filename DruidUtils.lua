local function isInProwl()
    return C_UnitAuras.GetPlayerAuraBySpellID(5215) ~= nil
end

--[[
Found on: https://www.wowhead.com/guide/druid-forms-customization-color-options
displayId is in the model viewer link <a href="https://www.wowhead.com/guide/druid-forms-customization-color-options#modelviewer:1:33664:0">
]]

local formToDisplayId = {
  -- Cat forms

  -- Dreamsaber
  [116194] = { race = "cat", color = "blue" },                             -- Dreamsaber light Blue
  [116195] = { race = "cat", color = "purple" },                           -- Dreamsaber purple
  [116196] = { race = "cat", color = "green" },                            -- Dreamsaber green

  -- Night elf
  [892]   = { race = "cat", color = "blue" },                               -- Night elf dark blue
  [29405] = { race = "cat", color = "purple" },                            -- Night elf purple
  [29406] = { race = "cat", color = "purple"},                              -- Night elf lighter purple
  [29407] = { race = "cat", color = "blue" },                              -- Night elf blue
  [29408] = { race = "cat", color = "purple", secondaryColor = "pink" },   -- Night elf purple pink white

  -- Tauren
  [8571]  = { race = "cat", color = "brown" },                             -- Tauren brown
  [29409] = { race = "cat", color = "white",  secondaryColor = "gray" },   -- Tauren white gray
  [29410] = { race = "cat", color = "brown",  secondaryColor = "orange" }, -- Tauren brown orange
  [29411] = { race = "cat", color = "brown" },                             -- Tauren brown
  [29412] = { race = "cat", color = "black",  secondaryColor = "gray" },   -- Tauren black gray

  -- Troll
  [33665] = { race = "cat", color = "purple", secondaryColor = "white" },  -- Troll purple white
  [33666] = { race = "cat", color = "green",  secondaryColor = "blue" },   -- Troll green blue
  [33667] = { race = "cat", color = "green",  secondaryColor = "gray" },   -- Troll green gray
  [33668] = { race = "cat", color = "red",    secondaryColor = "gray" },   -- Troll red gray
  [33669] = { race = "cat", color = "gray",   secondaryColor = "white" },  -- Troll gray white

  -- Worgen
  [33660] = { race = "cat", color = "black",  secondaryColor = "gray" },   -- Worgen black gray
  [33661] = { race = "cat", color = "black" },                             -- Worgen black
  [33662] = { race = "cat", color = "brown",  secondaryColor = "orange" }, -- Worgen brown, orange shoulder
  [33663] = { race = "cat", color = "gray",   secondaryColor = "blue" },   -- Worgen gray, blue shoulder
  [33664] = { race = "cat", color = "black",  secondaryColor = "brown" },  -- Worgen black, brown, green shoulder

  -- Kul Tiran
  [86100] = { race = "cat", color = "brown",  secondaryColor = "gray" },   -- Kul Tiran brown gray green
  [86524] = { race = "cat", color = "gray",   secondaryColor = "brown" },  -- Kul Tiran gray, brown green
  [86525] = { race = "cat", color = "green",  secondaryColor = "brown" },  -- Kul Tiran green brown
  [86526] = { race = "cat", color = "gray",   secondaryColor = "white" },  -- Kul Tiran gray white green

  -- Zandalari
  [85195] = { race = "cat", color = "turquoise" },                         -- Zandalari turquoise
  [85194] = { race = "cat", color = "black" },                             -- Zandalari black
  [85196] = { race = "cat", color = "green" },                             -- Zandalari green
  [85197] = { race = "cat", color = "gray",   secondaryColor = "blue" },   -- Zandalari gray blue

  -- Artifact tiger
  [66791] = { race = "cat", color = "orange", secondaryColor = "green" },  -- Orange and green artifact tiger
  [66792] = { race = "cat", color = "purple", secondaryColor = "blue" },   -- (You listed twice) Purple artifact tiger / Purple and blue artifact tiger
  [66793] = { race = "cat", color = "white",  secondaryColor = "blue" },   -- White and blue artifact tiger

  -- Artifact armored
  [66775] = { race = "cat", color = "black",  secondaryColor = "purple" }, -- Black and purple artifact armored
  [66778] = { race = "cat", color = "brown",  secondaryColor = "red" },    -- Brown and red artifact armored
  [66781] = { race = "cat", color = "gray",   secondaryColor = "white" },  -- (You listed twice) Gray and white / Gray artifact armored
  [66780] = { race = "cat", color = "purple" },                            -- Purple artifact armored
  [66777] = { race = "cat", color = "brown",  secondaryColor = "green" },  -- Brown green artifact armored
  [66779] = { race = "cat", color = "red",    secondaryColor = "green" },  -- Red green artifact armored
  [66776] = { race = "cat", color = "purple", secondaryColor = "blue" },   -- Purple and blue artifact armored

  -- Artifact tree
  [66787] = { race = "cat", color = "brown",  secondaryColor = "green" },  -- Brown and green artifact tree
  [66786] = { race = "cat", color = "turquoise",   secondaryColor = "gray" }, -- Turquoise and gray artifact tree
  [66788] = { race = "cat", color = "orange", secondaryColor = "brown" },  -- Orange brown artifact tree
  [66789] = { race = "cat", color = "purple", secondaryColor = "gray" },   -- Purple and gray artifact tree

  -- Artifact ghost
  [66783] = { race = "cat", color = "green" },                             -- Green artifact ghost
  [66785] = { race = "cat", color = "red",    secondaryColor = "orange" }, -- Red and orange artifact ghost
  [66782] = { race = "cat", color = "blue" },                              -- Blue artifact ghost
  [66784] = { race = "cat", color = "purple" },                            -- Purple artifact ghost

  -- Artifact owlcat
  [69834] = { race = "cat", color = "orange", secondaryColor = "brown" },  -- Orange and brown artifact owlcat (you also had 67552 noted)
  [68338] = { race = "cat", color = "gray",   secondaryColor = "brown" },  -- Gray and brown artifact owlcat
  [69832] = { race = "cat", color = "gray" },                              -- Gray artifact owlcat (you also had 67550 noted)
  [69833] = { race = "cat", color = "white",  secondaryColor = "black" },  -- White and black owlcat (you also had 67551 noted)

  -- Thorn artifact
  [66794] = { race = "cat", color = "blue",   secondaryColor = "green" },  -- Blue and green thorn artifact
  [66795] = { race = "cat", color = "blue",   secondaryColor = "turquoise" },   -- Blue and turquoise thorn artifact
  [66796] = { race = "cat", color = "red",    secondaryColor = "brown" },  -- Red and brown thorn artifact
  [66797] = { race = "cat", color = "purple", secondaryColor = "pink" },   -- Purple and pink thorn artifact

  -- Fire cat
  [38150] = { race = "cat", color = "fire" },                              -- Fire cat
}


local function getPetRaces()
    local form = GetShapeshiftFormID()

    local petRaces = {}

    if form == 0 then -- Normal
        -- Dont use any pet
    elseif form == nil then
        --print("No form detected")
    elseif form == 1 then -- Cat form
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

    print ("Detected Druid form: " .. tostring(form) .. ", Pet races: " .. table.concat(petRaces, ", "))
    return petRaces
end

local function getPetInfoFromDruidForm()
    local displayId = C_PlayerInfo.GetDisplayID()
    local formInfo = formToDisplayId[displayId]

    if formInfo then
        return formInfo
    end
end

local function summonDruidPet()
    local form = GetShapeshiftFormID()

    -- Summon pets after 0.5 sec
    C_Timer.After(1, function()
        local petInfo = getPetInfoFromDruidForm()
        
        if petInfo then
            RuthesMS.utils.pet.sommonPetByDruidForm(petInfo)
        else
            RuthesMS.utils.pet.summonPetByRace(getPetRaces())
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
    getPetInfoFromDruidForm = getPetInfoFromDruidForm,
    detectShapseshift = detectShapseshift
}
