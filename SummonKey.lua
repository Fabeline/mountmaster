local detectedKey = nil
local detectedModifiers = {}

-- Create a frame to capture key events
local setKeyButton = CreateFrame("Button", "SummonKeyButton", mountSelectorFrame, "UIPanelButtonTemplate")
setKeyButton:SetSize(90, 22)
setKeyButton:SetPoint("TOP", mountSelectorFrame, "TOP", 5, -71)
setKeyButton:SetText("Key (" .. (RuthesMS.keybinds.summonNormal or "None") .. ")")

local favoriteCheckbox = CreateFrame("CheckButton", "FavoriteCheckbox", mountSelectorFrame,
    "ChatConfigCheckButtonTemplate")
favoriteCheckbox:SetPoint("TOPRIGHT", mountSelectorFrame, "TOPRIGHT", -21, -63)
favoriteCheckbox:SetScript("OnClick", function(self)
    saveUseOnlyFavourites(self:GetChecked())
    renderMounts()
end)

local favoriteLabel = mountSelectorFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
favoriteLabel:SetPoint("RIGHT", favoriteCheckbox, "LEFT", -5, 0)
favoriteLabel:SetText("Only Favorites")

local smallMountCheckbox = CreateFrame("CheckButton", "SmallMountCheckbox", mountSelectorFrame,
    "ChatConfigCheckButtonTemplate")
smallMountCheckbox:SetPoint("TOPRIGHT", mountSelectorFrame, "TOPRIGHT", -20, -40)
smallMountCheckbox:SetScript("OnClick", function(self)
    saveSmallMountInInstance(self:GetChecked())
    renderMounts()
end)

local smallMountLabel = mountSelectorFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
smallMountLabel:SetPoint("RIGHT", smallMountCheckbox, "LEFT", -5, 0)
smallMountLabel:SetText("Small in Instance")

function reloadUseOnlyFavourites()
    if favoriteCheckbox then
        favoriteCheckbox:SetChecked(RuthesMS.settings.useOnlyFavourites)
    end
end

function reloadSmallMountInInstance()
    if smallMountCheckbox then
        smallMountCheckbox:SetChecked(RuthesMS.smallMountInInstance)
    end
end

-- Keybinding Popup (Detects Key Press)
setKeyButton:SetScript("OnClick", function()
    detectedKey = nil
    detectedModifiers = {}
    StaticPopup_Show("SET_KEYBIND")
end)

StaticPopupDialogs["SET_KEYBIND"] = {
    text = "Press a key to set as your summon key",
    button1 = "Cancel",
    OnAccept = function() end,
    OnShow = function(self)
        self:EnableKeyboard(true)
        self:SetScript("OnKeyDown", function(_, key)
            if key == "ESCAPE" then
                StaticPopup_Hide("SET_KEYBIND")
                return
            end

            -- Detect Modifier Keys
            if key == "LALT" or key == "RALT" or key == "LCTRL" or key == "RCTRL" or key == "LSHIFT" or key == "RSHIFT" then
                detectedModifiers[key] = true
                return
            end

            -- Store the actual key pressed
            detectedKey = key
        end)

        self:SetScript("OnKeyUp", function()
            if detectedKey then
                -- Format the final keybinding string
                local keyCombo = ""
                if detectedModifiers["LALT"] or detectedModifiers["RALT"] then keyCombo = keyCombo .. "ALT+" end
                if detectedModifiers["LCTRL"] or detectedModifiers["RCTRL"] then keyCombo = keyCombo .. "CTRL+" end
                if detectedModifiers["LSHIFT"] or detectedModifiers["RSHIFT"] then keyCombo = keyCombo .. "SHIFT+" end
                keyCombo = keyCombo .. detectedKey

                -- Save & Apply Keybinding
                RuthesMS.keybinds.summonNormal = keyCombo
                saveSummonKey(RuthesMS.keybinds.summonNormal)
                loadSummoningKey()

                StaticPopup_Hide("SET_KEYBIND")
                applySummonKeyBinding()
            end
        end)
    end,
    OnHide = function(self)
        self:SetScript("OnKeyDown", nil)
        self:SetScript("OnKeyUp", nil)
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Ensure Keybinding is Applied After Login
function loadSummoningKey()
    setKeyButton:SetText("Key (" .. (RuthesMS.keybinds.summonNormal or "None") .. ")")
    applySummonKeyBinding()
end

-- Apply the Keybinding
function applySummonKeyBinding()
    if RuthesMS.keybinds.summonNormal and RuthesMS.keybinds.summonNormal ~= "" then
        local formattedKey = string.gsub(RuthesMS.keybinds.summonNormal, "+", "-")

        -- Clear previous binding & apply new one
        ClearOverrideBindings(mountSelectorFrame)
        SetOverrideBindingClick(mountSelectorFrame, true, formattedKey, "RandomMountButton")
    end
end

-- Ensure UI Elements Load After Login
C_Timer.After(1, function()
    if reloadUseOnlyFavourites and reloadSmallMountInInstance then
        reloadUseOnlyFavourites()
        reloadSmallMountInInstance()
    end
end)
