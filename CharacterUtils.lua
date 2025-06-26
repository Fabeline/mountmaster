local BALANCE_GLYPH_OF_STARS = 1122334455

local allMountTypes = {
    "horse", "gryphon", "bird", "dragon", "bear", "stag", "cat", "serpent",
    "mechanical", "kite", "rat", "snail", "mammoth", "crocodile", "fish",
    "elemental", "spider", "gargoyle", "wolf", "kodo", "dinosaur",
    "bat", "insect"
}


local mountTypesBySize = {
    small = { "kite", "emu", "fish", "rat" },
    mediumSmall = { "crocodile", "insect", "cat", "bat", "dinosaur", "wolf", "stag", "horse" },
    mediumLarge = { "bear", "mechanical", "spider", "gryphon", "snail", "bird" },
    large = { "elemental", "gargoyle", "dragon", "serpent", "mammoth", "kodo" }
}

local raceMountPreferencesCombined = {
    Gnome = {
        size = "small",
        standard = { "mechanical", "kite", "rat", "snail" },
        extra = { "cat" }
    },
    Mechagnome = {
        size = "small",
        standard = { "mechanical", "rat", "kite", "spider" },
        extra = { "emu", "fish", "cat" }
    },
    Goblin = {
        size = "small",
        standard = { "mechanical", "insect", "crocodile", "fish" },
        extra = { "bat", "spider", "cat", "kite" }
    },
    Vulpera = {
        size = "small",
        standard = { "rat", "insect", "cat", "snail", "wolf" },
        extra = { "kite", "emu", "fish" }
    },
    Dwarf = {
        size = "small",
        standard = { "bear", "gryphon", "mammoth", "elemental", "kodo", "stag" },
        extra = { "snail", "crocodile", "gargoyle" }
    },
    Human = {
        size = "normal",
        standard = { "horse", "gryphon", "bird", "dragon" },
        extra = { "insect", "crocodile", "bear", "stag" }
    },
    NightElf = {
        size = "normal",
        standard = { "stag", "cat", "bird", "serpent" },
        extra = { "bear", "elemental", "dragon" }
    },
    Draenei = {
        size = "normal",
        standard = { "mammoth", "crocodile", "serpent", "fish", "dragon" },
        extra = { "bear", "insect" }
    },
    Worgen = {
        size = "normal",
        standard = { "horse", "bat", "wolf", "gargoyle", "bear" },
        extra = { "spider", "dragon", "stag" }
    },
    Pandaren = {
        size = "normal",
        standard = { "dragon", "serpent", "bird", "fish", "crocodile" },
        extra = { "bear", "snail" }
    },
    VoidElf = {
        size = "normal",
        standard = { "spider", "elemental", "dragon", "kite", "emu", "bat", "fish" },
        extra = { "bird", "insect" }
    },
    LightforgedDraenei = {
        size = "normal",
        standard = { "horse", "gryphon", "elemental", "dragon", "mammoth" },
        extra = { "bird", "stag" }
    },
    DarkIronDwarf = {
        size = "normal",
        standard = { "elemental", "spider", "bear", "gargoyle", "dragon", "rat" },
        extra = { "wolf", "snail", "crocodile" }
    },
    Orc = {
        size = "normal",
        standard = { "wolf", "kodo", "dragon", "dinosaur" },
        extra = { "snail", "crocodile", "bear" }
    },
    Scourge = {
        size = "normal",
        standard = { "bat", "spider", "horse", "gargoyle", "elemental", "insect" },
        extra = { "dragon", "bear" }
    },
    Troll = {
        size = "normal",
        standard = { "dinosaur", "bat", "bird", "serpent", "crocodile" },
        extra = { "snail", "gargoyle", "mammoth" }
    },
    BloodElf = {
        size = "normal",
        standard = { "dragon", "bird", "gryphon", "gargoyle", "emu" },
        extra = { "cat", "spider", "insect" }
    },
    Nightborne = {
        size = "normal",
        standard = { "cat", "spider", "serpent", "elemental", "dragon" },
        extra = { "spider", "insect", "bear" }
    },
    MagharOrc = {
        size = "normal",
        standard = { "wolf", "kodo", "dinosaur", "elemental", "spider", "bat", "snail" },
        extra = { "mammoth", "crocodile", "dragon" }
    },
    EarthenDwarf = {
        size = "normal",
        standard = { "elemental", "bear", "mechanical", "gryphon", "stag" },
        extra = { "dragon", "snail", "crocodile" }
    },
    Dracthyr = {
        size = "normal",
        standard = { "dragon", "elemental", "bird", "dinosaur", "serpent" },
        extra = { "stag", "cat", "insect" }
    },
    KulTiran = {
        size = "large",
        standard = { "crocodile", "horse", "bird", "fish" },
        extra = { "gargoyle", "serpent", "mammoth", "dragon" }
    },
    Tauren = {
        size = "large",
        standard = { "kodo", "bear", "stag", "mammoth" },
        extra = { "bird", "dragon", "crocodile", "serpent", "gargoyle" }
    },
    HighmountainTauren = {
        size = "large",
        standard = { "bear", "stag", "gryphon", "mammoth", "kodo" },
        extra = { "crocodile", "serpent", "dragon" }
    },
    ZandalariTroll = {
        size = "large",
        standard = { "dinosaur", "bird", "serpent", "crocodile" },
        extra = { "gargoyle", "mammoth", "dragon" }
    }
}


local specColorThemes = {
    -- Death Knight v
    [250] = { "red", "black", "purple", "gray", "brown", "various" },      -- Blood
    [251] = { "blue", "white", "ghost", "gray", "black", "various" },      -- Frost
    [252] = { "green", "black", "ghost", "gray", "turquoise", "various" }, -- Unholy

    -- Demon Hunter v
    [577] = { "purple", "fire", "red", "black", "brown", "green", "various" },
    [581] = { "purple", "fire", "red", "black", "brown", "green", "various" },

    -- Druid (v)
    [102] = { "brown", "orange", "green", "white", "yellow", "various" },       -- Balance
    [BALANCE_GLYPH_OF_STARS] = { "ghost", "white", "blue", "pink", "various" }, -- Balance (Glyph of the Stars)
    [103] = { "orange", "brown", "red", "yellow", "various", "green" },         -- Feral
    [104] = { "brown", "gray", "green", "black", "various" },                   -- Guardian
    [105] = { "green", "turquoise", "white", "pink", "various" },               -- Restoration

    -- Evoker v
    [1467] = { "red", "orange", "fire", "yellow", "various" },
    [1468] = { "green", "blue", "turquoise", "white", "various" },
    [1473] = { "yellow", "black", "brown", "orange", "various" },

    -- Hunter
    [253] = { "brown", "green", "orange", "yellow", "various" },
    [254] = { "gray", "blue", "white", "turquoise", "various" },
    [255] = { "green", "brown", "yellow", "gray", "various" },

    -- Mage v
    [62] = { "purple", "blue", "pink", "white", "various" }, -- Arcane
    [63] = { "red", "orange", "fire", "yellow", "various" }, -- Fire
    [64] = { "blue", "white", "turquoise", "various" },      -- Frost

    -- Monk
    [268] = { "brown", "green", "gray", "yellow", "various" },
    [270] = { "green", "turquoise", "white", "pink", "various" },
    [269] = { "yellow", "orange", "ghost", "green", "red", "various" },

    -- Paladin
    [65] = { "white", "blue", "yellow", "pink", "orange", "gray", "various" },         -- Holy
    [66] = { "white", "blue", "yellow", "pink", "orange", "gray", "various" },         -- Protection
    [70] = { "white", "blue", "yellow", "pink", "orange", "gray", "various", "fire" }, -- Retribution

    -- Priest
    [256] = { "white", "gray", "blue", "pink", "various", "ghost", "yellow" },
    [257] = { "white", "yellow", "gray", "turquoise", "various", "ghost", "pink", "blue" },
    [258] = { "purple", "black", "ghost", "red", "various", "pink" },

    -- Rogue
    [259] = { "green", "black", "red", "gray", "various" },
    [260] = { "brown", "gray", "red", "yellow", "various" },
    [261] = { "black", "purple", "ghost", "red", "various" },

    -- Shaman v
    [262] = { "blue", "orange", "fire", "yellow", "various" },    -- Elemental
    [263] = { "red", "yellow", "fire", "brown", "various" },      -- Enhancement
    [264] = { "green", "blue", "turquoise", "white", "various" }, -- Restoration

    -- Warlock
    [265] = { "purple", "green", "ghost", "black", "blue", "fire", "red", "various" }, --Aff
    [266] = { "purple", "green", "ghost", "black", "blue", "fire", "red", "various" }, --Demo
    [267] = { "purple", "green", "ghost", "black", "blue", "fire", "red", "various" }, --Destro

    -- Warrior
    [71] = { "red", "gray", "brown", "black", "various" },
    [72] = { "red", "orange", "fire", "yellow", "various" },
    [73] = { "blue", "gray", "black", "brown", "various" },
}


local specMountTypes = {
    -- Death Knight
    [250] = { "horse", "dragon" }, -- Blood (undead steed / death charger)
    [251] = { "horse", "dragon" }, -- Frost (ice wyrm aesthetic)
    [252] = { "horse", "dragon" }, -- Unholy (necrotic, creepy creatures)

    -- Demon Hunter v
    [577] = { "gargoyle" }, -- Havoc (mobility, wings, demonic)
    [581] = { "gargoyle" }, -- Vengeance (demonic, armored beetle vibe)

    -- Druid
    [102] = { "stag" },                    -- Balance (moon/spell/nature)
    [BALANCE_GLYPH_OF_STARS] = { "stag" }, -- Balance (moon/spell/nature)
    [103] = { "cat" },                     -- Feral (cats = shapeshift theme)
    [104] = { "bear" },                    -- Guardian (bear form)
    [105] = { "stag" },                    -- Restoration (gentle, nature healing)

    -- Evoker
    [1467] = { "dragon" }, -- Devastation (direct draconic heritage)
    [1468] = { "dragon" }, -- Preservation (serpent/flowing theme)
    [1473] = { "dragon" }, -- Augmentation (dragonflight empowerment)

    -- Hunter
    [253] = { "wolf" }, -- Beast Mastery (animal companion)
    [254] = { "wolf" }, -- Marksmanship (precision, hawks)
    [255] = { "wolf" }, -- Survival (troll/survivalist vibes)

    -- Mage v
    [62] = { "elemental", "kite" }, -- Arcane (elegant, high magic)
    [63] = { "elemental", "kite" }, -- Fire (flaming elemental)
    [64] = { "elemental", "kite" }, -- Frost (gliding, icy elegance)

    -- Monk
    [268] = { "cat" }, -- Brewmaster (tankiness, strength)
    [270] = { "cat" }, -- Mistweaver (calm, water-magic)
    [269] = { "cat" }, -- Windwalker (nimble, slightly silly monk mount)

    -- Paladin v
    [65] = { "horse" }, -- Holy
    [66] = { "horse" }, -- Protection
    [70] = { "horse" }, -- Retribution

    -- Priest
    [256] = { "gryphon" }, -- Discipline
    [257] = { "gryphon" }, -- Holy
    [258] = { "gryphon" }, -- Shadow

    -- Rogue
    [259] = { "spider", "bird" }, -- Assassination
    [260] = { "spider", "bird" }, -- Outlaw
    [261] = { "spider", "bird" }, -- Subtlety

    -- Shaman
    [262] = { "elemental", }, -- Elemental
    [263] = { "elemental" },  -- Enhancement
    [264] = { "elemental" },  -- Restoration

    -- Warlock v
    [265] = { "horse", "gargoyle" }, -- Affliction
    [266] = { "horse", "gargoyle" }, -- Demonology
    [267] = { "horse", "gargoyle" }, -- Destruction

    -- Warrior
    [71] = { "dragon" }, -- Arms
    [72] = { "dragon" }, -- Fury
    [73] = { "dragon" }, -- Protection
}

-- { "neutral", "scary", "pretty", "cute", "tough" },

local looksForSpecs = {
    -- Death Knight
    [250] = { "neutral", "scary", "tough" }, -- Blood
    [251] = { "neutral", "scary", "tough" }, -- Frost
    [252] = { "neutral", "scary", "tough" }, -- Unholy

    -- Demon Hunter
    [577] = { "neutral", "silly", "tough", "scary" }, -- Havoc
    [581] = { "neutral", "silly", "tough", "scary" }, -- Vengeance

    -- Druid
    [102] = { "pretty", "neutral", "cute", "silly" },                     -- Balance
    [BALANCE_GLYPH_OF_STARS] = { "pretty", "neutral", "cute", "silly", }, -- Balance (Glyph of the Stars)
    [103] = { "pretty", "neutral", "cute", "silly", "tough" },            -- Feral
    [104] = { "pretty", "neutral", "cute", "silly", "tough", },           -- Guardian
    [105] = { "pretty", "neutral", "cute", "silly" },                     -- Restoration

    -- Evoker
    [1467] = { "pretty", "neutral", "cute", "silly", "tough", "scary" }, -- Devastation
    [1468] = { "pretty", "neutral", "cute", "silly", "tough", "scary" }, -- Preservation
    [1473] = { "pretty", "neutral", "cute", "silly", "tough", "scary" }, -- Augmentation

    -- Hunter
    [253] = { "pretty", "neutral", "cute", "tough", "scary", "silly", }, -- Beast Mastery
    [254] = { "pretty", "neutral", "cute", "tough", "scary", "silly", }, -- Marksmanship
    [255] = { "pretty", "neutral", "cute", "tough", "scary", "silly", }, -- Survival

    -- Mage
    [62] = { "pretty", "neutral", "cute", "silly", "tough", "scary" }, -- Arcane
    [63] = { "pretty", "neutral", "cute", "scary", "tough", "scary" }, -- Fire
    [64] = { "pretty", "neutral", "cute", "silly", "tough", "scary" }, -- Frost

    -- Monk
    [268] = { "pretty", "neutral", "cute", "silly", "tough", "scary" }, -- Brewmaster
    [270] = { "pretty", "neutral", "cute", "silly", "tough", "scary" }, -- Mistweaver
    [269] = { "pretty", "neutral", "cute", "silly", "tough", "scary" }, -- Windwalker

    -- Paladin
    [65] = { "pretty", "neutral", "cute", "tough" }, -- Holy
    [66] = { "pretty", "neutral", "cute", "tough" }, -- Protection
    [70] = { "pretty", "neutral", "cute", "tough" }, -- Retribution

    -- Priest
    [256] = { "pretty", "neutral", "cute" },  -- Discipline
    [257] = { "pretty", "neutral", "cute" },  -- Holy
    [258] = { "pretty", "neutral", "scary" }, -- Shadow

    -- Rogue
    [259] = { "silly", "neutral", "tough", "scary" }, -- Assassination
    [260] = { "silly", "neutral", "tough", "scary" }, -- Outlaw
    [261] = { "silly", "neutral", "tough", "scary" }, -- Subtlety

    -- Shaman
    [262] = { "pretty", "neutral", "cute", "silly", "tough", "scary" }, -- Elemental
    [263] = { "pretty", "neutral", "cute", "silly", "tough", "scary" }, -- Enhancement
    [264] = { "pretty", "neutral", "cute", "silly", "tough", "scary" }, -- Restoration

    -- Warlock
    [265] = { "scary" }, -- Affliction
    [266] = { "scary" }, -- Demonology
    [267] = { "scary" }, -- Destruction

    -- Warrior
    [71] = { "tough", "scary", "neutral", "silly" }, -- Arms
    [72] = { "tough", "scary", "neutral", "silly" }, -- Fury
    [73] = { "tough", "scary", "neutral", "silly" }, -- Protection
}

local function getSpecId()
    local specID = GetSpecializationInfo(GetSpecialization())

    if (specID == 102) then -- Balance Druid
        if RuthesMS.settings.useDruidGlyphOfTheStars then
            specID = BALANCE_GLYPH_OF_STARS
        end
    end

    return specID
end

local function getRace()
    local _, race = UnitRace("player")
    return race
end

local function getColorForSpec(specID)
    if (specID == 102) then -- Balance Druid
        if RuthesMS.settings.useDruidGlyphOfTheStars then
            specID = BALANCE_GLYPH_OF_STARS
        end
    end

    return specColorThemes[specID] or {}
end


local function getTypeFromRace(race, availableMounts)
    local combined = {}
    local numMounts = #availableMounts
    local racePrefs = raceMountPreferencesCombined[race]
    local raceMounts = {}

    if racePrefs then
        local standard = racePrefs.standard or {}
        local extra = racePrefs.extra or {}
        local sizeExtras = mountTypesBySize[racePrefs.size] or {}

        if numMounts >= 400 then
            raceMounts = standard
        elseif numMounts >= 250 then
            for _, v in ipairs(standard) do table.insert(raceMounts, v) end
            for _, v in ipairs(extra) do table.insert(raceMounts, v) end
        elseif numMounts >= 90 then
            for _, v in ipairs(standard) do table.insert(raceMounts, v) end
            for _, v in ipairs(extra) do table.insert(raceMounts, v) end
            for _, v in ipairs(sizeExtras) do table.insert(raceMounts, v) end
        else
            raceMounts = allMountTypes
        end
    else
        raceMounts = allMountTypes
    end

    local specID = GetSpecializationInfo(GetSpecialization())
    local specMounts = specMountTypes[specID] or {}

    for _, v in ipairs(raceMounts) do table.insert(combined, v) end
    for _, v in ipairs(specMounts) do table.insert(combined, v) end

    return combined
end

local function getLooksForSpec(specID)
    if (specID == 102) then -- Balance Druid
        if RuthesMS.settings.useDruidGlyphOfTheStars then
            specID = BALANCE_GLYPH_OF_STARS
        end
    end

    return looksForSpecs[specID] or {}
end

local function getClassName()
    local className, _ = UnitClass("player")
    return className
end

RuthesMS.utils.character = {
    getColorForSpec = getColorForSpec,
    getTypeFromRace = getTypeFromRace,
    getLooksForSpec = getLooksForSpec,
    getSpecId = getSpecId,
    getRace = getRace,
    getClassName = getClassName,
}
