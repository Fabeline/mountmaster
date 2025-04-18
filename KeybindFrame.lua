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

    -- Normal summon
    local formattedKey = string.gsub(RuthesMS.keybinds.normal, "+", "-")
    SetOverrideBindingClick(RuthesMS.frames.mountSelectorFrame.frame, true, formattedKey,
        "RuthesMSRandomMountButton")

    -- TODO: do for every keybind
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
                RuthesMS.db.saveSummonKey(keyCombo, selectedType)
                loadSummoningKey()

                StaticPopup_Hide("SET_KEYBIND")
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
        for _, child in ipairs({ RuthesMS.frames.keybindFrame.frame:GetChildren() }) do
            child:Hide()
            child:SetParent(nil)
        end

        RuthesMS.frames.keybindFrame.frame:Hide()
        RuthesMS.frames.keybindFrame.frame:SetParent(nil)
        RuthesMS.frames.keybindFrame.frame = nil
    end
end

local function createKeybindFrame()
    local mountSelectorFrame = RuthesMS.frames.mountSelectorFrame.frame

    local keybindFrame = CreateFrame("Frame", "MountSelectorKeybindFrame", mountSelectorFrame,
        "BackdropTemplate")
    keybindFrame:SetSize(400, 400)
    keybindFrame:SetPoint("CENTER", mountSelectorFrame, "CENTER", 0, 0)

    local yOffset = -20
    local lineHeight = 40

    -- Mount type
    local mountTypeLabel = keybindFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    mountTypeLabel:SetPoint("TOPLEFT", keybindFrame, "TOPLEFT", 20, yOffset)
    mountTypeLabel:SetText("Mount Type")

    -- Set keybind
    local setKeybindLabel = keybindFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    setKeybindLabel:SetPoint("TOPRIGHT", keybindFrame, "TOP", 20, yOffset)
    setKeybindLabel:SetText("Keybind")

    -- Action button
    local setActionButtonLabel = keybindFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    setActionButtonLabel:SetPoint("TOPRIGHT", keybindFrame, "TOPRIGHT", -20, yOffset)
    setActionButtonLabel:SetText("Action button")

    for index, value in ipairs(keybindTable) do
        local keybindLabel = keybindFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        keybindLabel:SetPoint("TOPLEFT", keybindFrame, "TOPLEFT", 20, yOffset - (index * lineHeight))
        keybindLabel:SetText(value.label)

        -- Keybind button
        local setKeyButton = CreateFrame("Button", nil, keybindFrame, "UIPanelButtonTemplate")
        setKeyButton:SetSize(100, 22)
        setKeyButton:SetPoint("TOPLEFT", keybindFrame, "TOP", -50, yOffset - (index * lineHeight))
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
        actionButtonIcon:SetPoint("TOPRIGHT", keybindFrame, "TOPRIGHT", -20, yOffset - (index * lineHeight))

        actionButtonIcon:SetTexture(value.actionIcon)
    end


    keybindFrame:Show()

    RuthesMS.frames.keybindFrame.frame = keybindFrame
end

local function show()
    -- Create if missing
    if not RuthesMS.frames.keybindFrame.frame then
        RuthesMS.frames.keybindFrame.create()
    end

    local keybindFrame = RuthesMS.frames.keybindFrame.frame
    keybindFrame:Show()
end

local function hide()
    local keybindFrame = RuthesMS.frames.keybindFrame.frame
    if keybindFrame then
        keybindFrame:Hide()
    end
end

RuthesMS.frames.keybindFrame = {
    frame = nil,
    create = createKeybindFrame,
    delete = deleteKeybindFrame,
    show = show,
    hide = hide,
    loadSummoningKey = loadSummoningKey,
}
