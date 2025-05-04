local favoriteCheckbox
local smallMountCheckbox
local utilityCheckbox

local summonPetCheckbox
local summonPetFromDruidForm
local useOnlyPetFavourites
local noPetsInInstanceCheckbox
local useClassPetsCheckbox
local useDruidGlyphOfTheStarsCheckbox

local lineHeight = 25
local currentY = 0
local xMargin = 15
local checkboxMargin = 5

local function reloadCheckboxes()
    if favoriteCheckbox then
        favoriteCheckbox:SetChecked(RuthesMS.settings.useOnlyFavourites)
    end

    if smallMountCheckbox then
        smallMountCheckbox:SetChecked(RuthesMS.settings.smallMountInInstance)
    end

    if utilityCheckbox then
        utilityCheckbox:SetChecked(RuthesMS.settings.dontIncludeUtilityMounts)
    end

    if summonPetCheckbox then
        summonPetCheckbox:SetChecked(RuthesMS.settings.summonPetFromMount)
    end

    if summonPetFromDruidForm then
        summonPetFromDruidForm:SetChecked(RuthesMS.settings.summonPetFromDruidForm)
    end

    if useOnlyPetFavourites then
        useOnlyPetFavourites:SetChecked(RuthesMS.settings.useOnlyPetFavourites)
    end

    if noPetsInInstanceCheckbox then
        noPetsInInstanceCheckbox:SetChecked(RuthesMS.settings.noPetsInInstance)
    end

    if useClassPetsCheckbox then
        useClassPetsCheckbox:SetChecked(RuthesMS.settings.useClassPets)
    end

    if useDruidGlyphOfTheStarsCheckbox then
        useDruidGlyphOfTheStarsCheckbox:SetChecked(RuthesMS.settings.useDruidGlyphOfTheStars)
    end
end

local function createFrame()
    currentY = 0
    local mountSelectorFrame = RuthesMS.frames.mountSelectorFrame.frame

    local advancedFrame = CreateFrame("Frame", "MountSelectorAdvancedFrame", mountSelectorFrame, "BackdropTemplate")
    advancedFrame:SetSize(mountSelectorFrame:GetWidth(), 400)
    advancedFrame:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 0, -65)

    -- Heading
    local heading = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    heading:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", xMargin + 5, currentY)
    heading:SetText("Settings for non-utility mount summons")
    currentY = currentY - lineHeight

    -- Only favorites
    favoriteCheckbox = CreateFrame("CheckButton", "FavoriteCheckbox", advancedFrame,
        "ChatConfigCheckButtonTemplate")
    favoriteCheckbox:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", xMargin, currentY)
    favoriteCheckbox:SetScript("OnClick", function(self)
        RuthesMS.db.saveUseOnlyFavourites(self:GetChecked())
        RuthesMS.buttons.mountButtons.reload()
    end)

    local favoriteLabel = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    favoriteLabel:SetPoint("LEFT", favoriteCheckbox, "RIGHT", checkboxMargin, 0)
    favoriteLabel:SetText("Only use favorite mounts")
    currentY = currentY - lineHeight

    -- Small in instances
    smallMountCheckbox = CreateFrame("CheckButton", "SmallMountCheckbox", advancedFrame,
        "ChatConfigCheckButtonTemplate")
    smallMountCheckbox:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", xMargin, currentY)
    smallMountCheckbox:SetScript("OnClick", function(self)
        RuthesMS.db.saveSmallMountInInstance(self:GetChecked())
        RuthesMS.buttons.mountButtons.reload()
    end)

    local smallMountLabel = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    smallMountLabel:SetPoint("LEFT", smallMountCheckbox, "RIGHT", checkboxMargin, 0)
    smallMountLabel:SetText("Only summon small mounts in instances")
    currentY = currentY - lineHeight

    -- Don't include utility mounts
    utilityCheckbox = CreateFrame("CheckButton", "UtilityCheckbox", advancedFrame,
        "ChatConfigCheckButtonTemplate")
    utilityCheckbox:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", xMargin, currentY)
    utilityCheckbox:SetScript("OnClick", function(self)
        RuthesMS.db.saveDontIncludeUtilityMounts(self:GetChecked())
        RuthesMS.buttons.mountButtons.reload()
    end)

    local utilityLabel = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    utilityLabel:SetPoint("LEFT", utilityCheckbox, "RIGHT", checkboxMargin, 0)
    utilityLabel:SetText("Don't include utility mounts")
    currentY = currentY - lineHeight * 2


    -- Heading
    local heading2 = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    heading2:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", xMargin + 5, currentY)
    heading2:SetText("Settings for pet summons")
    currentY = currentY - lineHeight

    -- Summon pet from mount
    summonPetCheckbox = CreateFrame("CheckButton", "SummonPetCheckbox", advancedFrame,
        "ChatConfigCheckButtonTemplate")
    summonPetCheckbox:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", xMargin, currentY)
    summonPetCheckbox:SetScript("OnClick", function(self)
        RuthesMS.db.saveSummonPetFromMount(self:GetChecked())
        RuthesMS.buttons.mountButtons.reload()
    end)

    local summonPetLabel = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    summonPetLabel:SetPoint("LEFT", summonPetCheckbox, "RIGHT", checkboxMargin, 0)
    summonPetLabel:SetText("Summon pet when mounting")
    currentY = currentY - lineHeight

    -- Use only pet favorites
    useOnlyPetFavourites = CreateFrame("CheckButton", "UseOnlyPetFavouritesCheckbox", advancedFrame,
        "ChatConfigCheckButtonTemplate")
    useOnlyPetFavourites:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", xMargin, currentY)
    useOnlyPetFavourites:SetScript("OnClick", function(self)
        RuthesMS.db.saveUseOnlyPetFavourites(self:GetChecked())
        RuthesMS.buttons.mountButtons.reload()
    end)

    local useOnlyPetFavouritesLabel = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    useOnlyPetFavouritesLabel:SetPoint("LEFT", useOnlyPetFavourites, "RIGHT", checkboxMargin, 0)
    useOnlyPetFavouritesLabel:SetText("Use only pet favorites")
    currentY = currentY - lineHeight

    -- No pets in instances
    noPetsInInstanceCheckbox = CreateFrame("CheckButton", "NoPetsInInstanceCheckbox", advancedFrame,
        "ChatConfigCheckButtonTemplate")
    noPetsInInstanceCheckbox:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", xMargin, currentY)
    noPetsInInstanceCheckbox:SetScript("OnClick", function(self)
        RuthesMS.db.saveNoPetsInInstance(self:GetChecked())
        RuthesMS.buttons.mountButtons.reload()
    end)

    local noPetsInInstanceLabel = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    noPetsInInstanceLabel:SetPoint("LEFT", noPetsInInstanceCheckbox, "RIGHT", checkboxMargin, 0)
    noPetsInInstanceLabel:SetText("No pets in instances")
    currentY = currentY - lineHeight * 2

    -- Heading
    local heading3 = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    heading3:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", xMargin + 5, currentY)
    heading3:SetText("Class specific pet settings")
    currentY = currentY - lineHeight

    -- Summon pet from druid form
    summonPetFromDruidForm = CreateFrame("CheckButton", "SummonPetFromDruidFormCheckbox", advancedFrame,
        "ChatConfigCheckButtonTemplate")
    summonPetFromDruidForm:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", xMargin, currentY)
    summonPetFromDruidForm:SetScript("OnClick", function(self)
        RuthesMS.db.saveSummonPetFromDruidForm(self:GetChecked())
        RuthesMS.buttons.mountButtons.reload()
    end)

    local summonPetFromDruidFormLabel = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    summonPetFromDruidFormLabel:SetPoint("LEFT", summonPetFromDruidForm, "RIGHT", checkboxMargin, 0)
    summonPetFromDruidFormLabel:SetText("Summon pet from druid form")
    currentY = currentY - lineHeight


    -- Use Druid Glyph of Stars
    useDruidGlyphOfTheStarsCheckbox = CreateFrame("CheckButton", "UseDruidGlyphOfTheStarsCheckbox", advancedFrame,
        "ChatConfigCheckButtonTemplate")
    useDruidGlyphOfTheStarsCheckbox:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", xMargin, currentY)
    useDruidGlyphOfTheStarsCheckbox:SetScript("OnClick", function(self)
        RuthesMS.db.saveUseDruidGlyphOfTheStars(self:GetChecked())
        RuthesMS.buttons.mountButtons.reload()
    end)

    local useDruidGlyphOfTheStarsLabel = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    useDruidGlyphOfTheStarsLabel:SetPoint("LEFT", useDruidGlyphOfTheStarsCheckbox, "RIGHT", checkboxMargin, 0)
    useDruidGlyphOfTheStarsLabel:SetText("Using glyph of stars for druids")
    currentY = currentY - lineHeight

    -- Use only class pets
    useClassPetsCheckbox = CreateFrame("CheckButton", "UseClassPetsCheckbox", advancedFrame,
        "ChatConfigCheckButtonTemplate")
    useClassPetsCheckbox:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", xMargin, currentY)
    useClassPetsCheckbox:SetScript("OnClick", function(self)
        RuthesMS.db.saveUseClassPets(self:GetChecked())
        RuthesMS.buttons.mountButtons.reload()
    end)

    local useClassPetsLabel = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    useClassPetsLabel:SetPoint("LEFT", useClassPetsCheckbox, "RIGHT", checkboxMargin, 0)
    useClassPetsLabel:SetText("Prefer class specific pets (only for some classes)")
    currentY = currentY - lineHeight


    advancedFrame:Show()
    reloadCheckboxes()

    RuthesMS.frames.advancedFrame.frame = advancedFrame
end

local function show()
    -- Create if missing
    if not RuthesMS.frames.advancedFrame.frame then
        RuthesMS.frames.advancedFrame.create()
    end

    local advancedFrame = RuthesMS.frames.advancedFrame.frame
    advancedFrame:Show()
end

local function hide()
    local advancedFrame = RuthesMS.frames.advancedFrame.frame
    if advancedFrame then
        advancedFrame:Hide()
    end
end

RuthesMS.frames.advancedFrame = {
    create = createFrame,
    show = show,
    hide = hide,
    frame = nil
}
