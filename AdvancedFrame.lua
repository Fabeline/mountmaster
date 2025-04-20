local favoriteCheckbox
local smallMountCheckbox
local utilityCheckbox

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
end

local function createFrame()
    local mountSelectorFrame = RuthesMS.frames.mountSelectorFrame.frame

    local advancedFrame = CreateFrame("Frame", "MountSelectorAdvancedFrame", mountSelectorFrame, "BackdropTemplate")
    advancedFrame:SetSize(mountSelectorFrame:GetWidth(), 400)
    advancedFrame:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 0, -65)

    -- Heading
    local heading = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    heading:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", 20, 0)
    heading:SetText("Settings for non-utility summons")

    -- Only favorites
    favoriteCheckbox = CreateFrame("CheckButton", "FavoriteCheckbox", advancedFrame,
        "ChatConfigCheckButtonTemplate")
    favoriteCheckbox:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", 15, -25)
    favoriteCheckbox:SetScript("OnClick", function(self)
        RuthesMS.db.saveUseOnlyFavourites(self:GetChecked())
        RuthesMS.buttons.mountButtons.reload()
    end)

    local favoriteLabel = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    favoriteLabel:SetPoint("LEFT", favoriteCheckbox, "RIGHT", 5, 0)
    favoriteLabel:SetText("Only use favorites")

    -- Small in instances
    smallMountCheckbox = CreateFrame("CheckButton", "SmallMountCheckbox", advancedFrame,
        "ChatConfigCheckButtonTemplate")
    smallMountCheckbox:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", 15, -50)
    smallMountCheckbox:SetScript("OnClick", function(self)
        RuthesMS.db.saveSmallMountInInstance(self:GetChecked())
        RuthesMS.buttons.mountButtons.reload()
    end)

    local smallMountLabel = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    smallMountLabel:SetPoint("LEFT", smallMountCheckbox, "RIGHT", 5, 0)
    smallMountLabel:SetText("Only summon small mounts in instances")

    -- Don't include utility mounts
    utilityCheckbox = CreateFrame("CheckButton", "UtilityCheckbox", advancedFrame,
        "ChatConfigCheckButtonTemplate")
    utilityCheckbox:SetPoint("TOPLEFT", advancedFrame, "TOPLEFT", 15, -75)
    utilityCheckbox:SetScript("OnClick", function(self)
        RuthesMS.db.saveDontIncludeUtilityMounts(self:GetChecked())
        RuthesMS.buttons.mountButtons.reload()
    end)

    local utilityLabel = advancedFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    utilityLabel:SetPoint("LEFT", utilityCheckbox, "RIGHT", 5, 0)
    utilityLabel:SetText("Don't include utility mounts")

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
