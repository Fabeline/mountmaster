local setKeyButton = CreateFrame("Button", "SummonKeyButton", mountSelectorFrame, "UIPanelButtonTemplate")
setKeyButton:SetSize(120, 22)
setKeyButton:SetPoint("TOPRIGHT", mountSelectorFrame, "TOPRIGHT", -20, -40)
setKeyButton:SetText("Set key (" .. summonKey .. ")")

-- Create the favorite label
local favoriteLabel = mountSelectorFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
favoriteLabel:SetPoint("TOPRIGHT", mountSelectorFrame, "TOPRIGHT", -20, -72)
favoriteLabel:SetText("Use only favorites") -- The text to display

-- Create favorite checkbox
local favoriteCheckbox = CreateFrame("CheckButton", "favoriteCheckbox", mountSelectorFrame, "ChatConfigCheckButtonTemplate")
favoriteCheckbox:SetPoint("RIGHT", favoriteLabel, "LEFT", 0, 0)

favoriteCheckbox:SetScript("OnClick", function(self)
    if self:GetChecked() then
        saveUseOnlyFavourites(true)
        renderMounts()
    else
        saveUseOnlyFavourites(false)
        renderMounts()
    end
end)

function reloadUseOnlyFavourites()
    favoriteCheckbox:SetChecked(useOnlyFavourites)
end

setKeyButton:SetScript("OnClick", function()
    StaticPopup_Show("SET_KEYBIND")
end)

StaticPopupDialogs["SET_KEYBIND"] = {
    text = "Enter key",
    button1 = "OK",
    button2 = "Cancel",
    hasEditBox = true,
    maxLetters = 20,
    OnAccept = function(self)
        local enteredKey = self.editBox:GetText()
        saveSummonKey(enteredKey)
        loadSummoningKey()
    end,
    OnShow = function(self)
        self.editBox:SetText("")
        self.editBox:SetFocus()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,  -- Avoid taint issues
}

function loadSummoningKey()
    loadRandomMountButton()
    setKeyButton:SetText("Set key (" .. summonKey .. ")")
end