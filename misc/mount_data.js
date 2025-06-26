const specNames = {
    250: "Blood DK", 251: "Frost DK", 252: "Unholy DK",
    577: "Havoc DH", 581: "Vengeance DH",
    102: "Balance Druid", 9999: "Balance (Glyph)", 103: "Feral Druid", 104: "Guardian Druid", 105: "Restoration Druid",
    1467: "Devastation Evoker", 1468: "Preservation Evoker", 1473: "Augmentation Evoker",
    253: "Beast Mastery Hunter", 254: "Marksmanship Hunter", 255: "Survival Hunter",
    62: "Arcane Mage", 63: "Fire Mage", 64: "Frost Mage",
    268: "Brewmaster Monk", 270: "Mistweaver Monk", 269: "Windwalker Monk",
    65: "Holy Paladin", 66: "Protection Paladin", 70: "Retribution Paladin",
    256: "Discipline Priest", 257: "Holy Priest", 258: "Shadow Priest",
    259: "Assassination Rogue", 260: "Outlaw Rogue", 261: "Subtlety Rogue",
    262: "Elemental Shaman", 263: "Enhancement Shaman", 264: "Restoration Shaman",
    265: "Affliction Warlock", 266: "Demonology Warlock", 267: "Destruction Warlock",
    71: "Arms Warrior", 72: "Fury Warrior", 73: "Protection Warrior"
};

const specClasses = {
    250: "Death Knight", 251: "Death Knight", 252: "Death Knight",
    577: "Demon Hunter", 581: "Demon Hunter",
    102: "Druid", 9999: "Druid", 103: "Druid", 104: "Druid", 105: "Druid",
    1467: "Evoker", 1468: "Evoker", 1473: "Evoker",
    253: "Hunter", 254: "Hunter", 255: "Hunter",
    62: "Mage", 63: "Mage", 64: "Mage",
    268: "Monk", 270: "Monk", 269: "Monk",
    65: "Paladin", 66: "Paladin", 70: "Paladin",
    256: "Priest", 257: "Priest", 258: "Priest",
    259: "Rogue", 260: "Rogue", 261: "Rogue",
    262: "Shaman", 263: "Shaman", 264: "Shaman",
    265: "Warlock", 266: "Warlock", 267: "Warlock",
    71: "Warrior", 72: "Warrior", 73: "Warrior"
};

const raceNames = {
    Human: "Human", Dwarf: "Dwarf", NightElf: "Night Elf", Gnome: "Gnome", Draenei: "Draenei",
    Worgen: "Worgen", Pandaren: "Pandaren", VoidElf: "Void Elf", LightforgedDraenei: "Lightforged Draenei",
    DarkIronDwarf: "Dark Iron Dwarf", KulTiran: "Kul Tiran", Mechagnome: "Mechagnome",
    Orc: "Orc", Scourge: "Undead", Tauren: "Tauren", Troll: "Troll", BloodElf: "Blood Elf",
    Goblin: "Goblin", Nightborne: "Nightborne", HighmountainTauren: "Highmountain Tauren",
    MagharOrc: "Mag'har Orc", ZandalariTroll: "Zandalari Troll", Vulpera: "Vulpera",
    EarthenDwarf: "Earthen Dwarf", Dracthyr: "Dracthyr"
};

const legalCombos = {
    Human: ["Death Knight", "Hunter", "Mage", "Monk", "Paladin", "Priest", "Rogue", "Warlock", "Warrior"],
    Dwarf: ["Death Knight", "Hunter", "Mage", "Paladin", "Priest", "Rogue", "Shaman", "Warlock", "Warrior"],
    NightElf: ["Death Knight", "Druid", "Hunter", "Mage", "Priest", "Rogue", "Warrior"],
    Gnome: ["Death Knight", "Mage", "Monk", "Priest", "Rogue", "Warlock", "Warrior"],
    Draenei: ["Death Knight", "Hunter", "Mage", "Paladin", "Priest", "Shaman", "Warrior"],
    Worgen: ["Death Knight", "Druid", "Hunter", "Mage", "Priest", "Rogue", "Warrior"],
    Pandaren: ["Hunter", "Mage", "Monk", "Priest", "Rogue", "Shaman", "Warrior"],
    VoidElf: ["Death Knight", "Hunter", "Mage", "Monk", "Priest", "Rogue", "Warlock", "Warrior"],
    LightforgedDraenei: ["Death Knight", "Hunter", "Mage", "Paladin", "Priest", "Warrior"],
    DarkIronDwarf: ["Death Knight", "Hunter", "Mage", "Paladin", "Priest", "Rogue", "Shaman", "Warlock", "Warrior"],
    KulTiran: ["Death Knight", "Druid", "Hunter", "Mage", "Priest", "Rogue", "Shaman", "Warrior"],
    Mechagnome: ["Death Knight", "Hunter", "Mage", "Monk", "Priest", "Rogue", "Warlock", "Warrior"],
    Orc: ["Death Knight", "Hunter", "Mage", "Monk", "Priest", "Rogue", "Shaman", "Warlock", "Warrior"],
    Scourge: ["Death Knight", "Hunter", "Mage", "Monk", "Priest", "Rogue", "Warlock", "Warrior"],
    Tauren: ["Death Knight", "Druid", "Hunter", "Monk", "Paladin", "Priest", "Shaman", "Warrior"],
    Troll: ["Death Knight", "Druid", "Hunter", "Mage", "Monk", "Priest", "Rogue", "Shaman", "Warlock", "Warrior"],
    BloodElf: ["Death Knight", "Demon Hunter", "Hunter", "Mage", "Monk", "Paladin", "Priest", "Rogue", "Warlock", "Warrior"],
    Goblin: ["Death Knight", "Hunter", "Mage", "Priest", "Rogue", "Shaman", "Warlock", "Warrior"],
    Nightborne: ["Death Knight", "Hunter", "Mage", "Monk", "Priest", "Rogue", "Warlock", "Warrior"],
    HighmountainTauren: ["Death Knight", "Druid", "Hunter", "Mage", "Monk", "Priest", "Shaman", "Warrior"],
    MagharOrc: ["Death Knight", "Hunter", "Mage", "Monk", "Priest", "Rogue", "Shaman", "Warrior"],
    ZandalariTroll: ["Death Knight", "Druid", "Hunter", "Mage", "Monk", "Paladin", "Priest", "Rogue", "Shaman", "Warrior"],
    Vulpera: ["Death Knight", "Hunter", "Mage", "Priest", "Rogue", "Shaman", "Warlock", "Warrior"],
    EarthenDwarf: ["Death Knight", "Hunter", "Mage", "Paladin", "Priest", "Rogue", "Shaman", "Warlock", "Warrior"],
    Dracthyr: ["Evoker", "Hunter", "Mage", "Priest", "Rogue", "Warlock", "Warrior"]
};

const mountTypesBySize = {
  small: ["kite", "emu", "fish", "rat"],
  mediumSmall: ["crocodile", "insect", "cat", "bat", "dinosaur", "wolf", "stag", "horse"],
  mediumLarge: ["bear", "mechanical", "spider", "gryphon", "snail", "bird"],
  large: ["elemental", "gargoyle", "dragon", "serpent", "mammoth", "kodo"]
};

  const raceMountPreferencesCombined = {
    Gnome: {
      size: "small",
      standard: ["mechanical", "kite", "rat", "snail"],
      extra: ["cat"]
    },
    Mechagnome: {
      size: "small",
      standard: ["mechanical", "rat", "kite", "spider"],
      extra: ["emu", "fish", "cat"]
    },
    Goblin: {
      size: "small",
      standard: ["mechanical", "insect", "crocodile", "fish"],
      extra: ["bat", "spider", "cat", "kite"]
    },
    Vulpera: {
      size: "small",
      standard: ["rat", "insect", "cat", "snail", "wolf"],
      extra: ["kite", "emu", "fish"]
    },
    Dwarf: {
      size: "small",
      standard: ["bear", "gryphon", "mammoth", "elemental", "kodo", "stag"],
      extra: ["snail", "crocodile", "gargoyle"]
    },
    Human: {
      size: "normal",
      standard: ["horse", "gryphon", "bird", "dragon"],
      extra: ["insect", "crocodile", "bear", "stag"]
    },
    NightElf: {
      size: "normal",
      standard: ["stag", "cat", "bird", "serpent"],
      extra: ["bear", "elemental", "dragon"]
    },
    Draenei: {
      size: "normal",
      standard: ["mammoth", "crocodile", "serpent", "fish", "dragon"],
      extra: ["bear", "insect"]
    },
    Worgen: {
      size: "normal",
      standard: ["horse", "bat", "wolf", "gargoyle", "bear"],
      extra: ["spider", "dragon", "stag"]
    },
    Pandaren: {
      size: "normal",
      standard: ["dragon", "serpent", "bird", "fish", "crocodile"],
      extra: ["bear", "snail"]
    },
    VoidElf: {
      size: "normal",
      standard: ["spider", "elemental", "dragon", "kite", "emu", "bat", "fish"],
      extra: ["bird", "insect"]
    },
    LightforgedDraenei: {
      size: "normal",
      standard: ["horse", "gryphon", "elemental", "dragon", "mammoth"],
      extra: ["bird", "stag"]
    },
    DarkIronDwarf: {
      size: "normal",
      standard: ["elemental", "spider", "bear", "gargoyle", "dragon", "rat"],
      extra: ["wolf", "snail", "crocodile"]
    },
    Orc: {
      size: "normal",
      standard: ["wolf", "kodo", "dragon", "dinosaur"],
      extra: ["snail", "crocodile", "bear"]
    },
    Scourge: {
      size: "normal",
      standard: ["bat", "spider", "horse", "gargoyle", "elemental", "insect"],
      extra: ["dragon", "bear"]
    },
    Troll: {
      size: "normal",
      standard: ["dinosaur", "bat", "bird", "serpent", "crocodile"],
      extra: ["snail", "gargoyle", "mammoth"]
    },
    BloodElf: {
      size: "normal",
      standard: ["dragon", "bird", "gryphon", "gargoyle", "emu"],
      extra: ["cat", "spider", "insect"]
    },
    Nightborne: {
      size: "normal",
      standard: ["cat", "spider", "serpent", "elemental", "dragon"],
      extra: ["spider", "insect", "bear"]
    },
    MagharOrc: {
      size: "normal",
      standard: ["wolf", "kodo", "dinosaur", "elemental", "spider", "bat", "snail"],
      extra: ["mammoth", "crocodile", "dragon"]
    },
    EarthenDwarf: {
      size: "normal",
      standard: ["elemental", "bear", "mechanical", "gryphon", "stag"],
      extra: ["dragon", "snail", "crocodile"]
    },
    Dracthyr: {
      size: "normal",
      standard: ["dragon", "elemental", "bird", "dinosaur", "serpent"],
      extra: ["stag", "cat", "insect"]
    },
    KulTiran: {
      size: "large",
      standard: ["crocodile", "horse", "bird", "fish"],
      extra: ["gargoyle", "serpent", "mammoth", "dragon"]
    },
    Tauren: {
      size: "large",
      standard: ["kodo", "bear", "stag", "mammoth"],
      extra: ["bird", "dragon", "crocodile", "serpent", "gargoyle"]
    },
    HighmountainTauren: {
      size: "large",
      standard: ["bear", "stag", "gryphon", "mammoth", "kodo"],
      extra: ["crocodile", "serpent", "dragon"]
    },
    ZandalariTroll: {
      size: "large",
      standard: ["dinosaur", "bird", "serpent", "crocodile"],
      extra: ["gargoyle", "mammoth", "dragon"]
    }
  };

const BALANCE_GLYPH_OF_STARS = 9999;

const specColorThemes = {
  // Death Knight v
  250: ["red", "black", "purple", "gray", "brown", "various"],
  251: ["blue", "white", "ghost", "gray", "black", "various"],
  252: ["green", "black", "ghost", "gray", "turquoise", "various"],

  //Demon Hunter v
  577: ["purple", "fire", "red", "black", "brown", "green", "various"],
  581: ["purple", "fire", "red", "black", "brown", "green", "various"],

  // Druid (v)
  102: ["brown", "orange", "green", "white", "yellow", "various"],
  [BALANCE_GLYPH_OF_STARS]: ["ghost", "white", "blue", "pink", "various"],
  103: ["orange", "brown", "red", "yellow", "various", "green"],
  104: ["brown", "gray", "green", "black", "various"],
  105: ["green", "turquoise", "white", "pink", "various"],

  //Evoker v
  1467: ["red", "orange", "fire", "yellow", "various"],
  1468: ["green", "blue", "turquoise", "white", "various"],
  1473: ["yellow", "black", "brown", "orange", "various"],

  // Hunter
  253: ["brown", "green", "orange", "yellow", "various"],
  254: ["gray", "blue", "white", "turquoise", "various"],
  255: ["green", "brown", "yellow", "gray", "various"],

  // Mage v
  62: ["purple", "blue", "pink", "white", "various"],
  63: ["red", "orange", "fire", "yellow", "various"],
  64: ["blue", "white", "turquoise", "various"],

  // Monk
  268: ["brown", "green", "gray", "yellow", "various"],
  270: ["green", "turquoise", "white", "pink", "various"],
  269: ["yellow", "orange", "ghost", "green", "red", "various"],

  // Paladin
  65: ["white", "blue", "yellow", "pink", "orange", "gray", "various"],
  66: ["white", "blue", "yellow", "pink", "orange", "gray", "various"],
  70: ["white", "blue", "yellow", "pink", "orange", "gray", "various", "fire"],

  // Priest
  256: ["white", "gray", "blue", "pink", "turquoise", "various", "ghost", "yellow"], // Discipline
  257: ["white", "yellow", "gray", "turquoise", "various", "ghost", "pink", "blue"], // Holy
  258: ["purple", "black", "ghost", "red", "turquoise", "various", "pink"], // Shadow

  // Rogue
  259: ["green", "black", "red", "gray", "various"],
  260: ["brown", "gray", "red", "yellow", "various"],
  261: ["black", "purple", "ghost", "red", "various"],

  // Shaman
  262: ["blue", "orange", "fire", "yellow", "various"],
  263: ["red", "yellow", "fire", "brown", "various"],
  264: ["green", "blue", "turquoise", "white", "various"],

  // Warlock
  265: ["purple", "green", "ghost", "black", "blue", "fire", "red", "various"],
  266: ["purple", "green", "ghost", "black", "blue", "fire", "red", "various"],
  267: ["purple", "green", "ghost", "black", "blue", "fire", "red", "various"],

  // Warrior
  71: ["red", "gray", "brown", "black", "various"],
  72: ["red", "orange", "fire", "yellow", "various"],
  73: ["blue", "gray", "black", "brown", "various"],
};

const specMountTypes = {
  // Death Knight
  250: ["horse", "dragon"],
  251: ["horse", "dragon"],
  252: ["horse", "dragon"],

  // Demon Hunter
  577: ["gargoyle"],
  581: ["gargoyle"],

  // Druid
  102: ["stag"],
  [BALANCE_GLYPH_OF_STARS]: ["stag"],
  103: ["cat"],
  104: ["bear"],
  105: ["stag"],

  // Evoker
  1467: ["dragon"],
  1468: ["dragon"],
  1473: ["dragon"],

  // Hunter
  253: ["wolf"],
  254: ["wolf"],
  255: ["wolf"],

  // Mage
  62: ["elemental", "kite"],
  63: ["elemental", "kite"],
  64: ["elemental", "kite"],

  // Monk
  268: ["cat"],
  270: ["cat"],
  269: ["cat"],

  // Paladin
  65: ["horse"],
  66: ["horse"],
  70: ["horse"],

  // Priest
  256: ["gryphon"],
  257: ["gryphon"],
  258: ["gryphon"],

  // Rogue
  259: ["spider", "bird"],
  260: ["spider", "bird"],
  261: ["spider", "bird"],

  // Shaman
  262: ["elemental"],
  263: ["elemental"],
  264: ["elemental"],

  // Warlock
  265: ["horse", "gargoyle"],
  266: ["horse", "gargoyle"],
  267: ["horse", "gargoyle"],

  // Warrior
  71: ["dragon"],
  72: ["dragon"],
  73: ["dragon"],
};

const looksForSpecs = {
  // Death Knight
  250: ["neutral", "scary", "tough"],
  251: ["neutral", "scary", "tough"],
  252: ["neutral", "scary", "tough"],

  // Demon Hunter
  577: ["neutral", "silly", "tough", "scary"],
  581: ["neutral", "silly", "tough", "scary"],
  
  // Druid
  102: ["pretty", "neutral", "cute", "silly"],
  [BALANCE_GLYPH_OF_STARS]: ["pretty", "neutral", "cute", "silly"],
  103: ["pretty", "neutral", "cute", "silly", "tough"],
  104: ["pretty", "neutral", "cute", "silly", "tough"],
  105: ["pretty", "neutral", "cute", "silly"],

  // Evoker
  1467: ["pretty", "neutral", "cute", "silly", "tough", "scary"],
  1468: ["pretty", "neutral", "cute", "silly", "tough", "scary"],
  1473: ["pretty", "neutral", "cute", "silly", "tough", "scary"],

  // Hunter
  253: ["pretty", "neutral", "cute", "tough", "scary", "silly"],
  254: ["pretty", "neutral", "cute", "tough", "scary", "silly"],
  255: ["pretty", "neutral", "cute", "tough", "scary", "silly"],

  // Mage
  62: ["pretty", "neutral", "cute", "silly", "tough", "scary"],
  63: ["pretty", "neutral", "cute", "scary", "tough", "scary"],
  64: ["pretty", "neutral", "cute", "silly", "tough", "scary"],

  // Monk
  268: ["pretty", "neutral", "cute", "silly", "tough", "scary"],
  270: ["pretty", "neutral", "cute", "silly", "tough", "scary"],
  269: ["pretty", "neutral", "cute", "silly", "tough", "scary"],

  // Paladin
  65: ["pretty", "neutral", "cute", "tough"],
  66: ["pretty", "neutral", "cute", "tough"],
  70: ["pretty", "neutral", "cute", "tough"],

  // Priest
  256: ["pretty", "neutral", "cute"],
  257: ["pretty", "neutral", "cute"],
  258: ["pretty", "neutral", "scary"],

  // Rogue
  259: ["silly", "neutral", "tough", "scary"],
  260: ["silly", "neutral", "tough", "scary"],
  261: ["silly", "neutral", "tough", "scary"],

  // Shaman
  262: ["pretty", "neutral", "cute", "silly", "tough", "scary"],
  263: ["pretty", "neutral", "cute", "silly", "tough", "scary"],
  264: ["pretty", "neutral", "cute", "silly", "tough", "scary"],

  // Warlock
  265: ["scary"],
  266: ["scary"],
  267: ["scary"],

  // Warrior
  71: ["tough", "scary", "neutral", "silly"],
  72: ["tough", "scary", "neutral", "silly"],
  73: ["tough", "scary", "neutral", "silly"],
};
