local setKeyButton = CreateFrame("Button", "SummonKeyButton", mountSelectorFrame, "UIPanelButtonTemplate")
setKeyButton:SetSize(120, 20)
setKeyButton:SetPoint("TOPRIGHT", mountSelectorFrame, "TOPRIGHT", -20, -37)
setKeyButton:SetText("Set key (" .. summonKey .. ")")

-- Create the favorite label
local favoriteLabel = mountSelectorFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
favoriteLabel:SetPoint("TOPRIGHT", mountSelectorFrame, "TOPRIGHT", -29, -65)
favoriteLabel:SetText("Only favorites") -- The text to display

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

-- Define the StaticPopupDialog with an added "Create Macro" button
StaticPopupDialogs["SET_KEYBIND"] = {
    text = "Enter key for summon or create macro",
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

-- Function to create the summon macro
function createAndDragSummonMacro()
    local macroName = "RMS"
    local macroBody = "/rms summon"
    local macroIcon = "Ability_Mount_RidingHorse"

    local macroID = GetMacroIndexByName(macroName)

    if macroID == 0 then
        local numAccountMacros, numCharacterMacros = GetNumMacros()

        if numAccountMacros < MAX_ACCOUNT_MACROS then
            macroID = CreateMacro(macroName, macroIcon, macroBody, false)            
        else
            print("No free account-wide macro slots available!")
            return
        end
    else
        EditMacro(macroID, macroName, macroIcon, macroBody)
    end

    -- Attempt to pick up the macro for dragging (may have restrictions)
    if macroID > 0 then
        PickupMacro(macroID)
        print("Macro picked up. Drag it to your action bar.")
    end
end

function loadSummoningKey()
    loadRandomMountButton()
    setKeyButton:SetText("Set key (" .. summonKey .. ")")
end