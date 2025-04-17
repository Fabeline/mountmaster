local function getAllColors()
    return RuthesMS.utils.dropdown.collectUniqueValues(RuthesMS.data.mounts, "color", "secondary_color")
end

local function getAllTypes()
    return RuthesMS.utils.dropdown.collectUniqueValues(RuthesMS.data.mounts, "skeleton_type")
end

local function getAllExpansions()
    return {
        "Classic", "TBC", "WotLK", "Cataclysm", "MoP", "WoD", "Legion",
        "BFA", "Shadowlands", "Dragonflight", "MoP remix", "TWW"
    }
end

local function toggleColor(color)
    RuthesMS.settings.selectedColors =
        RuthesMS.utils.dropdown.toggleOption(RuthesMS.settings.selectedColors, color, getAllColors)
    RuthesMS.db.saveSelectedColors(RuthesMS.settings.selectedColors)
end

local function toggleType(type)
    RuthesMS.settings.selectedTypes =
        RuthesMS.utils.dropdown.toggleOption(RuthesMS.settings.selectedTypes, type, getAllTypes)
    RuthesMS.db.saveSelectedTypes(RuthesMS.settings.selectedTypes)
end

local function toggleExpansion(expansion)
    RuthesMS.settings.selectedExpansions =
        RuthesMS.utils.dropdown.toggleOption(RuthesMS.settings.selectedExpansions, expansion, getAllExpansions)
    RuthesMS.db.saveSelectedExpansions(RuthesMS.settings.selectedExpansions)
end


local function initializeColorDropdown(self)
    RuthesMS.utils.dropdown.initializeDropdown(self, getAllColors, RuthesMS.settings.selectedColors, toggleColor)
end

local function initializeSkeletonDropdown(self)
    RuthesMS.utils.dropdown.initializeDropdown(self, getAllTypes, RuthesMS.settings.selectedTypes, toggleType)
end

local function initializeExpansionDropdown(self)
    RuthesMS.utils.dropdown.initializeDropdown(self, getAllExpansions, RuthesMS.settings.selectedExpansions,
        toggleExpansion)
end

RuthesMS.utils.filterDropdowns = {
    initializeColorDropdown = initializeColorDropdown,
    initializeSkeletonDropdown = initializeSkeletonDropdown,
    initializeExpansionDropdown = initializeExpansionDropdown,
    getAllColors = getAllColors,
    getAllTypes = getAllTypes,
    getAllExpansions = getAllExpansions,
}
