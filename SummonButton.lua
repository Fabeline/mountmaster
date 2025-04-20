-- TODO: this file will be deleted

local detectedKey = nil
local detectedModifiers = {}


local function reloadUseOnlyFavourites(favoriteCheckbox)
    if favoriteCheckbox then
        favoriteCheckbox:SetChecked(RuthesMS.settings.useOnlyFavourites)
    end
end

local function reloadSmallMountInInstance(smallMountCheckbox)
    if smallMountCheckbox then
        smallMountCheckbox:SetChecked(RuthesMS.settings.smallMountInInstance)
    end
end

local function createButton()
    local mountSelectorFrame = RuthesMS.frames.mountSelectorFrame.frame

    -- Create a frame to capture key events
    local setKeyButton = CreateFrame("Button", "SummonKeyButton", mountSelectorFrame, "UIPanelButtonTemplate")
    setKeyButton:SetSize(90, 22)
    setKeyButton:SetPoint("TOP", mountSelectorFrame, "TOP", 5, -71)
    setKeyButton:SetText("Key (" .. (RuthesMS.keybinds.summonNormal or "None") .. ")")

    local favoriteCheckbox = CreateFrame("CheckButton", "FavoriteCheckbox", mountSelectorFrame,
        "ChatConfigCheckButtonTemplate")
    favoriteCheckbox:SetPoint("TOPRIGHT", mountSelectorFrame, "TOPRIGHT", -21, -63)
    favoriteCheckbox:SetScript("OnClick", function(self)
        RuthesMS.db.saveUseOnlyFavourites(self:GetChecked())
        RuthesMS.buttons.mountButtons.reload()
    end)

    local favoriteLabel = RuthesMS.frames.mountSelectorFrame.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    favoriteLabel:SetPoint("RIGHT", favoriteCheckbox, "LEFT", -5, 0)
    favoriteLabel:SetText("Only Favorites")

    local smallMountCheckbox = CreateFrame("CheckButton", "SmallMountCheckbox", mountSelectorFrame,
        "ChatConfigCheckButtonTemplate")
    smallMountCheckbox:SetPoint("TOPRIGHT", mountSelectorFrame, "TOPRIGHT", -20, -40)
    smallMountCheckbox:SetScript("OnClick", function(self)
        RuthesMS.db.saveSmallMountInInstance(self:GetChecked())
        RuthesMS.buttons.mountButtons.reload()
    end)

    local smallMountLabel = RuthesMS.frames.mountSelectorFrame.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    smallMountLabel:SetPoint("RIGHT", smallMountCheckbox, "LEFT", -5, 0)
    smallMountLabel:SetText("Small in Instance")

    -- Ensure UI Elements Load After Login
    C_Timer.After(1, function()
        if reloadUseOnlyFavourites and reloadSmallMountInInstance then
            reloadUseOnlyFavourites(favoriteCheckbox)
            reloadSmallMountInInstance(smallMountCheckbox)
        end
    end)

    -- Keybinding Popup (Detects Key Press)
    setKeyButton:SetScript("OnClick", function()
        detectedKey = nil
        detectedModifiers = {}
        StaticPopup_Show("SET_KEYBIND")
    end)

    RuthesMS.buttons.summonButton.button = setKeyButton
end

-- Apply the Keybinding
local function applySummonKeyBinding()
    if RuthesMS.keybinds.summonNormal and RuthesMS.keybinds.summonNormal ~= "" then
        local formattedKey = string.gsub(RuthesMS.keybinds.summonNormal, "+", "-")

        -- Clear previous binding & apply new one
        ClearOverrideBindings(RuthesMS.frames.mountSelectorFrame.frame)
        SetOverrideBindingClick(RuthesMS.frames.mountSelectorFrame.frame, true, formattedKey, "RandomMountButton")
    end
end


-- Ensure Keybinding is Applied After Login
local function loadSummoningKey()
    RuthesMS.buttons.summonButton.button:SetText("Key (" .. (RuthesMS.keybinds.summonNormal or "None") .. ")")
    applySummonKeyBinding()
end


RuthesMS.buttons.summonButton = {
    create = createButton,
    reload = loadSummoningKey,
    button = nil,
    reloadUseOnlyFavourites = reloadUseOnlyFavourites,
    reloadSmallMountInInstance = reloadSmallMountInInstance,
}
