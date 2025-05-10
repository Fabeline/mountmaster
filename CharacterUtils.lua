local BALANCE_GLYPH_OF_STARS = 1122334455

local raceMountPreferences = {
    Human = { "horse", "gryphon", "bird", "dragon" },
    Dwarf = { "bear", "gryphon", "mammoth", "elemental", "kodo" },
    NightElf = { "stag", "cat", "bird", "serpent" },
    Gnome = { "mechanical", "kite", "rat", "snail" },
    Draenei = { "mammoth", "crocodile", "serpent", "fish", "dragon" },
    Worgen = { "horse", "bat", "wolf", "gargoyle" },
    Pandaren = { "dragon", "serpent", "bird", "fish" },
    VoidElf = { "spider", "elemental", "dragon", "kite" },
    LightforgedDraenei = { "horse", "gryphon", "elemental", "dragon" },
    DarkIronDwarf = { "elemental", "spider", "bear", "gargoyle", "dragon" },
    KulTiran = { "crocodile", "horse", "bird", "fish" },
    Mechagnome = { "mechanical", "rat", "kite", "spider" },
    Orc = { "wolf", "kodo", "dragon", "dinosaur" },
    Scourge = { "bat", "spider", "horse", "gargoyle", "elemental" },
    Tauren = { "kodo", "bear", "stag", "mammoth" },
    Troll = { "dinosaur", "bat", "bird", "serpent", "crocodile" },
    BloodElf = { "dragon", "bird", "gryphon", "gargoyle" },
    Goblin = { "mechanical", "insect", "crocodile", "fish" },
    Nightborne = { "cat", "spider", "serpent", "elemental", "dragon" },
    HighmountainTauren = { "bear", "stag", "gryphon", "mammoth" },
    MagharOrc = { "wolf", "kodo", "dinosaur", "elemental" },
    ZandalariTroll = { "dinosaur", "bird", "serpent", "crocodile" },
    Vulpera = { "rat", "insect", "cat", "snail" },
    EarthenDwarf = { "elemental", "bear", "mechanical", "gryphon" },
    Dracthyr = { "dragon", "elemental", "bird" },
}

local specColorThemes = {
    -- Death Knight
    [250] = { "red", "black", "ghost", "various" },   -- Blood
    [251] = { "blue", "white", "gray", "various" },   -- Frost
    [252] = { "green", "black", "ghost", "various" }, -- Unholy

    -- Demon Hunter
    [577] = { "purple", "fire", "red", "various" },   -- Havoc
    [581] = { "black", "purple", "fire", "various" }, -- Vengeance

    -- Druid
    [102] = { "brown", "orange", "green", "white", "various" },         -- Balance
    [BALANCE_GLYPH_OF_STARS] = { "ghost", "white", "blue", "various" }, -- Custom override
    [103] = { "orange", "brown", "red", "various" },                    -- Feral
    [104] = { "brown", "gray", "green", "various" },                    -- Guardian
    [105] = { "green", "turquoise", "white", "various" },               -- Restoration

    -- Evoker
    [1467] = { "red", "orange", "fire", "various" },      -- Devastation
    [1468] = { "green", "blue", "turquoise", "various" }, -- Preservation
    [1473] = { "yellow", "black", "brown", "various" },   -- Augmentation

    -- Hunter
    [253] = { "brown", "green", "orange", "various" }, -- Beast Mastery
    [254] = { "gray", "blue", "white", "various" },    -- Marksmanship
    [255] = { "green", "brown", "yellow", "various" }, -- Survival

    -- Mage
    [62] = { "purple", "blue", "pink", "various" },     -- Arcane
    [63] = { "red", "orange", "fire", "various" },      -- Fire
    [64] = { "blue", "white", "turquoise", "various" }, -- Frost

    -- Monk
    [268] = { "brown", "green", "gray", "various" },                        -- Brewmaster
    [270] = { "green", "turquoise", "white", "various" },                   -- Mistweaver
    [269] = { "yellow", "orange", "various", "ghost", "green", "various" }, -- Windwalker

    -- Paladin
    [65] = { "white", "yellow", "pink", "orange", "various" }, -- Holy
    [66] = { "blue", "gray", "white", "various" },             -- Protection
    [70] = { "red", "orange", "fire", "various" },             -- Retribution

    -- Priest
    [256] = { "white", "gray", "blue", "various" },    -- Discipline
    [257] = { "white", "yellow", "gray", "various" },  -- Holy
    [258] = { "purple", "black", "ghost", "various" }, -- Shadow

    -- Rogue
    [259] = { "green", "black", "red", "various" },    -- Assassination
    [260] = { "brown", "gray", "red", "various" },     -- Outlaw
    [261] = { "black", "purple", "ghost", "various" }, -- Subtlety

    -- Shaman
    [262] = { "blue", "orange", "fire", "various" },     -- Elemental
    [263] = { "red", "yellow", "fire", "various" },      -- Enhancement
    [264] = { "green", "blue", "turquoise", "various" }, -- Restoration

    -- Warlock
    [265] = { "purple", "green", "ghost", "various" }, -- Affliction
    [266] = { "purple", "black", "green", "various" }, -- Demonology
    [267] = { "red", "orange", "fire", "various" },    -- Destruction

    -- Warrior
    [71] = { "red", "gray", "brown", "various" },  -- Arms
    [72] = { "red", "orange", "fire", "various" }, -- Fury
    [73] = { "blue", "gray", "black", "various" }, -- Protection
}

local specMountTypes = {
    -- Death Knight
    [250] = { "horse", "dragon" }, -- Blood (undead steed / death charger)
    [251] = { "horse", "dragon" }, -- Frost (ice wyrm aesthetic)
    [252] = { "horse", "dragon" }, -- Unholy (necrotic, creepy creatures)

    -- Demon Hunter
    [577] = { "gargoyle" }, -- Havoc (mobility, wings, demonic)
    [581] = { "gargoyle" }, -- Vengeance (demonic, armored beetle vibe)

    -- Druid
    [102] = { "stag" }, -- Balance (moon/spell/nature)
    [103] = { "cat" },  -- Feral (cats = shapeshift theme)
    [104] = { "bear" }, -- Guardian (bear form)
    [105] = { "stag" }, -- Restoration (gentle, nature healing)

    -- Evoker
    [1467] = { "dragon" }, -- Devastation (direct draconic heritage)
    [1468] = { "dragon" }, -- Preservation (serpent/flowing theme)
    [1473] = { "dragon" }, -- Augmentation (dragonflight empowerment)

    -- Hunter
    [253] = { "wolf" }, -- Beast Mastery (animal companion)
    [254] = { "wolf" }, -- Marksmanship (precision, hawks)
    [255] = { "wolf" }, -- Survival (troll/survivalist vibes)

    -- Mage
    [62] = { "elemental", "kite" }, -- Arcane (elegant, high magic)
    [63] = { "elemental", "kite" }, -- Fire (flaming elemental)
    [64] = { "elemental", "kite" }, -- Frost (gliding, icy elegance)

    -- Monk
    [268] = { "cat" }, -- Brewmaster (tankiness, strength)
    [270] = { "cat" }, -- Mistweaver (calm, water-magic)
    [269] = { "cat" }, -- Windwalker (nimble, slightly silly monk mount)

    -- Paladin
    [65] = { "horse" }, -- Holy)
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

    -- Warlock
    [265] = { "horse" }, -- Affliction
    [266] = { "horse" }, -- Demonology
    [267] = { "horse" }, -- Destruction

    -- Warrior
    [71] = { "dragon" }, -- Arms
    [72] = { "dragon" }, -- Fury
    [73] = { "dragon" }, -- Protection
}


local function getColorForSpec()
    local specID = GetSpecializationInfo(GetSpecialization())

    if (specID == 102) then -- Balance Druid
        if RuthesMS.settings.useDruidGlyphOfTheStars then
            specID = BALANCE_GLYPH_OF_STARS
        end
    end

    return specColorThemes[specID] or {}
end

local function getTypeFromRace()
    local combined = {}

    local _, race = UnitRace("player")
    local raceMounts = raceMountPreferences[race] or {}

    local specID = GetSpecializationInfo(GetSpecialization())
    local specMounts = specMountTypes[specID] or {}

    for _, v in ipairs(raceMounts) do table.insert(combined, v) end
    for _, v in ipairs(specMounts) do table.insert(combined, v) end

    return combined
end

RuthesMS.utils.character = {
    getColorForSpec = getColorForSpec,
    getTypeFromRace = getTypeFromRace,
}
