local setKeyButton = CreateFrame("Button", "SummonKeyButton", mountSelectorFrame, "UIPanelButtonTemplate")
setKeyButton:SetSize(70, 20)
setKeyButton:SetPoint("TOP", mountSelectorFrame, "TOP", 5, -71)
setKeyButton:SetText("key (" .. summonKey .. ")")

-- Create the favorite label
local favoriteLabel = mountSelectorFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
favoriteLabel:SetPoint("TOPRIGHT", mountSelectorFrame, "TOPRIGHT", -21, -63)
favoriteLabel:SetText("Only favorites") -- The text to display

-- Create the small mounts in dungeons label
local smallMountLabel = mountSelectorFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
smallMountLabel:SetPoint("TOPRIGHT", mountSelectorFrame, "TOPRIGHT", -20, -40)
smallMountLabel:SetText("Small in instance") -- The text to display

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

-- Create small mount in instance checkbox
local smallMountCheckbox = CreateFrame("CheckButton", "smallMountCheckbox", mountSelectorFrame, "ChatConfigCheckButtonTemplate")
smallMountCheckbox:SetPoint("RIGHT", smallMountLabel, "LEFT", 0, 0)

smallMountCheckbox:SetScript("OnClick", function(self)
    if self:GetChecked() then
        saveSmallMountInInstance(true)
        renderMounts()
    else
        saveSmallMountInInstance(false)
        renderMounts()
    end
end)

function reloadSmallMountInInstance()
    smallMountCheckbox:SetChecked(smallMountInInstance)
end

setKeyButton:SetScript("OnClick", function()
    StaticPopup_Show("SET_KEYBIND")
end)

-- Define the StaticPopupDialog
StaticPopupDialogs["SET_KEYBIND"] = {
    text = "Enter key for summon",
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

-- Reusable function to create a macro
function createAndDragMacro(macroName, macroBody, macroIcon)
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
    setKeyButton:SetText("key (" .. summonKey .. ")")
end