local setKeyButton = CreateFrame("Button", "SummonKeyButton", mountSelectorFrame, "UIPanelButtonTemplate")
setKeyButton:SetSize(120, 22)
setKeyButton:SetPoint("TOPRIGHT", mountSelectorFrame, "TOPRIGHT", -20, -30)
setKeyButton:SetText("Set key (" .. summonKey .. ")")

-- trigger set keybind dialog
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