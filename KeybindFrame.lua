local detectedKey = nil
local detectedModifiers = {}
local selectedType = ""

local keybindTable = {
    {
        label = "Normal & flying",
        name = "normal",
        actionIcon = "Interface\\Icons\\Ability_Mount_RidingHorse",
    },
    {
        label = "Aquatic",
        name = "aquatic",
        actionIcon = "Interface\\Icons\\inv_stingray2mount_teal"
    },
    {
        label = "Repare",
        name = "repair",
        actionIcon = "Interface\\Icons\\inv_misc_gear_01",
    },
    {
        label = "Transmog",
        name = "transmog",
        actionIcon = "Interface\\Icons\\inv_stingray2mount_teal",
    },
    {
        label = "Auction house",
        name = "auctionHouse",
        actionIcon = "Interface\\Icons\\inv_stingray2mount_teal",
    },
    {
        label = "Multiple",
        name = "multiple",
        actionIcon = "Interface\\Icons\\inv_misc_gear_01",
    }
}

-- Apply the Keybinding
local function applySummonKeyBinding(type)
    -- First clear all previous bindings
    ClearOverrideBindings(RuthesMS.frames.mountSelectorFrame.frame)

    ipairs(keybindTable)
    do
        if RuthesMS.keybinds[type] and RuthesMS.keybinds[type] ~= "" then
            local formattedKey = string.gsub(RuthesMS.keybinds[type], "+", "-")
            SetOverrideBindingClick(RuthesMS.frames.mountSelectorFrame.frame, true, formattedKey, "RandomMountButton")
        end
    end
end


-- Ensure Keybinding is Applied After Login
local function loadSummoningKey()
    RuthesMS.frames.keybindFrame.delete()
    RuthesMS.frames.keybindFrame.create()
    applySummonKeyBinding()
end

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
                RuthesMS.keybinds[selectedType] = keyCombo
                print("selectedType")
                print(selectedType)
                RuthesMS.db.saveSummonKey(keyCombo, selectedType)
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

local function deleteKeybindFrame()
    if RuthesMS.frames.keybindFrame.frame then
        RuthesMS.frames.keybindFrame.frame:Hide()
        RuthesMS.frames.keybindFrame.frame = nil
    end
end

local function createKeybindFrame()
    local keybindFrame = CreateFrame("Frame", "KeybindFrame", UIParent, "BasicFrameTemplateWithInset")
    keybindFrame:SetSize(400, 500)
    keybindFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

    -- Enable the frame to be movable
    keybindFrame:SetMovable(true)
    keybindFrame:EnableMouse(true)

    keybindFrame.title = keybindFrame:CreateFontString(nil, "OVERLAY")
    keybindFrame.title:SetFontObject("GameFontHighlight")
    keybindFrame.title:SetPoint("LEFT", keybindFrame.TitleBg, "LEFT", 5, 0)
    keybindFrame.title:SetText("Keybind Frame")

    -- Make the title bar draggable
    keybindFrame.TitleBg:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            keybindFrame:StartMoving()
        end
    end)

    keybindFrame.TitleBg:SetScript("OnMouseUp", function(self)
        keybindFrame:StopMovingOrSizing()
    end)



    local lineHeight = 40

    -- Mount type
    local mountTypeLabel = keybindFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    mountTypeLabel:SetPoint("TOPLEFT", keybindFrame, "TOPLEFT", 20, -35)
    mountTypeLabel:SetText("Mount Type")

    -- Set keybind
    local setKeybindLabel = keybindFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    setKeybindLabel:SetPoint("TOPRIGHT", keybindFrame, "TOP", 20, -35)
    setKeybindLabel:SetText("Keybind")

    -- Action button
    local setActionButtonLabel = keybindFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    setActionButtonLabel:SetPoint("TOPRIGHT", keybindFrame, "TOPRIGHT", -20, -35)
    setActionButtonLabel:SetText("Action button")

    for index, value in ipairs(keybindTable) do
        local keybindLabel = keybindFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        keybindLabel:SetPoint("TOPLEFT", keybindFrame, "TOPLEFT", 20, -35 - (index * lineHeight))
        keybindLabel:SetText(value.label)

        -- Keybind button
        local setKeyButton = CreateFrame("Button", "SummonKeyButton", keybindFrame, "UIPanelButtonTemplate")
        setKeyButton:SetSize(100, 22)
        setKeyButton:SetPoint("TOPLEFT", keybindFrame, "TOP", -50, -35 - (index * lineHeight))
        setKeyButton:SetText("Key (" .. (RuthesMS.keybinds[value.name] or "None") .. ")")

        -- Keybinding Popup (Detects Key Press)
        setKeyButton:SetScript("OnClick", function()
            detectedKey = nil
            detectedModifiers = {}
            selectedType = value.name
            StaticPopup_Show("SET_KEYBIND")
        end)

        -- Action button icon
        local actionButtonIcon = keybindFrame:CreateTexture(nil, "ARTWORK")
        actionButtonIcon:SetSize(32, 32)
        actionButtonIcon:SetPoint("TOPRIGHT", keybindFrame, "TOPRIGHT", -20, -35 - (index * lineHeight))

        actionButtonIcon:SetTexture(value.actionIcon)
    end


    keybindFrame:Show()
    RuthesMS.frames.keybindFrame.frame = keybindFrame
end

RuthesMS.frames.keybindFrame = {
    frame = nil,
    create = createKeybindFrame,
    delete = deleteKeybindFrame
}
