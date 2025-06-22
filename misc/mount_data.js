const raceMountPreferences = {
  Human: [ "horse", "gryphon", "bird", "dragon" ],
  Dwarf: [ "bear", "gryphon", "mammoth", "elemental", "kodo", "stag" ],
  NightElf: [ "stag", "cat", "bird", "serpent" ],
  Gnome: [ "mechanical", "kite", "rat", "snail" ],
  Draenei: [ "mammoth", "crocodile", "serpent", "fish", "dragon" ],
  Worgen: [ "horse", "bat", "wolf", "gargoyle" ],
  Pandaren: [ "dragon", "serpent", "bird", "fish", "crocodile" ],
  VoidElf: [ "spider", "elemental", "dragon", "kite", "emu" ],
  LightforgedDraenei: [ "horse", "gryphon", "elemental", "dragon", "mammoth" ],
  DarkIronDwarf: [ "elemental", "spider", "bear", "gargoyle", "dragon", "rat" ],
  KulTiran: [ "crocodile", "horse", "bird", "fish" ],
  Mechagnome: [ "mechanical", "rat", "kite", "spider" ],
  Orc: [ "wolf", "kodo", "dragon", "dinosaur" ],
  Scourge: [ "bat", "spider", "horse", "gargoyle", "elemental" ],
  Tauren: [ "kodo", "bear", "stag", "mammoth" ],
  Troll: [ "dinosaur", "bat", "bird", "serpent", "crocodile" ],
  BloodElf: [ "dragon", "bird", "gryphon", "gargoyle", "emu" ],
  Goblin: [ "mechanical", "insect", "crocodile", "fish" ],
  Nightborne: [ "cat", "spider", "serpent", "elemental", "dragon" ],
  HighmountainTauren: [ "bear", "stag", "gryphon", "mammoth" ],
  MagharOrc: [ "wolf", "kodo", "dinosaur", "elemental" ],
  ZandalariTroll: [ "dinosaur", "bird", "serpent", "crocodile" ],
  Vulpera: [ "rat", "insect", "cat", "snail", "wolf" ],
  EarthenDwarf: [ "elemental", "bear", "mechanical", "gryphon", "stag" ],
  Dracthyr: [ "dragon", "elemental", "bird" ]
};

const BALANCE_GLYPH_OF_STARS = 9999; // replace with actual ID if known

const specColorThemes = {
  250: ["red", "black", "purple", "gray", "brown", "various"],
  251: ["blue", "white", "ghost", "gray", "black", "various"],
  252: ["green", "black", "ghost", "gray", "turquoise", "various"],

  577: ["purple", "fire", "red", "black", "brown", "green", "various"],
  581: ["purple", "fire", "red", "black", "brown", "green", "various"],

  102: ["brown", "orange", "green", "white", "yellow", "various"],
  [BALANCE_GLYPH_OF_STARS]: ["ghost", "white", "blue", "pink", "various"],
  103: ["orange", "brown", "red", "yellow", "various", "green"],
  104: ["brown", "gray", "green", "black", "various"],
  105: ["green", "turquoise", "white", "pink", "various"],

  1467: ["red", "orange", "fire", "yellow", "various"],
  1468: ["green", "blue", "turquoise", "white", "various"],
  1473: ["yellow", "black", "brown", "orange", "various"],

  253: ["brown", "green", "orange", "yellow", "various"],
  254: ["gray", "blue", "white", "turquoise", "various"],
  255: ["green", "brown", "yellow", "gray", "various"],

  62: ["purple", "blue", "pink", "white", "various"],
  63: ["red", "orange", "fire", "yellow", "various"],
  64: ["blue", "white", "turquoise", "various"],

  268: ["brown", "green", "gray", "yellow", "various"],
  270: ["green", "turquoise", "white", "pink", "various"],
  269: ["yellow", "orange", "ghost", "green", "red", "various"],

  65: ["white", "blue", "yellow", "pink", "orange", "gray", "various"],
  66: ["white", "blue", "yellow", "pink", "orange", "gray", "various"],
  70: ["white", "blue", "yellow", "pink", "orange", "gray", "various", "fire"],

  256: ["white", "gray", "blue", "pink", "various"],
  257: ["white", "yellow", "gray", "turquoise", "various"],
  258: ["purple", "black", "ghost", "red", "various"],

  259: ["green", "black", "red", "gray", "various"],
  260: ["brown", "gray", "red", "yellow", "various"],
  261: ["black", "purple", "ghost", "red", "various"],

  262: ["blue", "orange", "fire", "yellow", "various"],
  263: ["red", "yellow", "fire", "brown", "various"],
  264: ["green", "blue", "turquoise", "white", "various"],

  265: ["purple", "green", "ghost", "black", "blue", "fire", "red", "various"],
  266: ["purple", "green", "ghost", "black", "blue", "fire", "red", "various"],
  267: ["purple", "green", "ghost", "black", "blue", "fire", "red", "various"],

  71: ["red", "gray", "brown", "black", "various"],
  72: ["red", "orange", "fire", "yellow", "various"],
  73: ["blue", "gray", "black", "brown", "various"],
};

const specMountTypes = {
  250: ["horse", "dragon"],
  251: ["horse", "dragon"],
  252: ["horse", "dragon"],

  577: ["gargoyle"],
  581: ["gargoyle"],

  102: ["stag"],
  [BALANCE_GLYPH_OF_STARS]: ["stag"],
  103: ["cat"],
  104: ["bear"],
  105: ["stag"],

  1467: ["dragon"],
  1468: ["dragon"],
  1473: ["dragon"],

  253: ["wolf"],
  254: ["wolf"],
  255: ["wolf"],

  62: ["elemental", "kite"],
  63: ["elemental", "kite"],
  64: ["elemental", "kite"],

  268: ["cat"],
  270: ["cat"],
  269: ["cat"],

  65: ["horse"],
  66: ["horse"],
  70: ["horse"],

  256: ["gryphon"],
  257: ["gryphon"],
  258: ["gryphon"],

  259: ["spider", "bird"],
  260: ["spider", "bird"],
  261: ["spider", "bird"],

  262: ["elemental"],
  263: ["elemental"],
  264: ["elemental"],

  265: ["horse", "gargoyle"],
  266: ["horse", "gargoyle"],
  267: ["horse", "gargoyle"],

  71: ["dragon"],
  72: ["dragon"],
  73: ["dragon"],
};

const looksForSpecs = {
  250: ["neutral", "scary", "tough"],
  251: ["neutral", "scary", "tough"],
  252: ["neutral", "scary", "tough"],

  577: ["neutral", "silly", "tough", "scary"],
  581: ["neutral", "silly", "tough", "scary"],

  102: ["pretty", "neutral", "cute", "silly"],
  [BALANCE_GLYPH_OF_STARS]: ["pretty", "neutral", "cute", "silly"],
  103: ["pretty", "neutral", "cute", "silly", "tough"],
  104: ["pretty", "neutral", "cute", "silly", "tough"],
  105: ["pretty", "neutral", "cute", "silly"],

  1467: ["pretty", "neutral", "cute", "silly", "tough", "scary"],
  1468: ["pretty", "neutral", "cute", "silly", "tough", "scary"],
  1473: ["pretty", "neutral", "cute", "silly", "tough", "scary"],

  253: ["pretty", "neutral", "cute", "tough", "scary", "silly"],
  254: ["pretty", "neutral", "cute", "tough", "scary", "silly"],
  255: ["pretty", "neutral", "cute", "tough", "scary", "silly"],

  62: ["pretty", "neutral", "cute", "silly", "tough", "scary"],
  63: ["pretty", "neutral", "cute", "scary", "tough", "scary"],
  64: ["pretty", "neutral", "cute", "silly", "tough", "scary"],

  268: ["pretty", "neutral", "cute", "silly", "tough", "scary"],
  270: ["pretty", "neutral", "cute", "silly", "tough", "scary"],
  269: ["pretty", "neutral", "cute", "silly", "tough", "scary"],

  65: ["pretty", "neutral", "cute", "tough"],
  66: ["pretty", "neutral", "cute", "tough"],
  70: ["pretty", "neutral", "cute", "tough"],

  256: ["pretty", "neutral", "cute"],
  257: ["pretty", "neutral", "cute"],
  258: ["pretty", "neutral", "scary"],

  259: ["silly", "neutral", "tough", "scary"],
  260: ["silly", "neutral", "tough", "scary"],
  261: ["silly", "neutral", "tough", "scary"],

  262: ["pretty", "neutral", "cute", "silly", "tough", "scary"],
  263: ["pretty", "neutral", "cute", "silly", "tough", "scary"],
  264: ["pretty", "neutral", "cute", "silly", "tough", "scary"],

  265: ["scary"],
  266: ["scary"],
  267: ["scary"],

  71: ["tough", "scary", "neutral", "silly"],
  72: ["tough", "scary", "neutral", "silly"],
  73: ["tough", "scary", "neutral", "silly"],
};
