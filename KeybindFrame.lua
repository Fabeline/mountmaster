local detectedKey = nil
local detectedModifiers = {}
local selectedType = ""

local keybindTable = {
    {
        label = "Normal & flying",
        name = "normal",
        iconPath = "Interface\\Icons\\Ability_Mount_RidingHorse",
        icon = "Ability_Mount_RidingHorse",
        macro = "/rms summon",
        macroName = "RMS normal"
    },
    {
        label = "Aquatic",
        name = "aquatic",
        iconPath = "Interface\\Icons\\inv_stingray2mount_teal",
        icon = "inv_stingray2mount_teal",
        macro = "/rms summonswim",
        macroName = "RMS aquatic"
    },
    {
        label = "Repair",
        name = "repair",
        iconPath = "Interface\\Icons\\inv_hammer_20",
        icon = "inv_hammer_20",
        macro = "/rms repair",
        macroName = "RMS repair"
    },
    {
        label = "Transmog",
        name = "transmog",
        iconPath = "Interface\\Icons\\Inv_enchant_essencemagiclarge",
        icon = "Inv_enchant_essencemagiclarge",
        macro = "/rms transmog",
        macroName = "RMS transmog"
    },
    {
        label = "Auction house",
        name = "auctionHouse",
        iconPath = "Interface\\Icons\\Inv_misc_coinbag_special",
        icon = "Inv_misc_coinbag_special",
        macro = "/rms auctionHouse",
        macroName = "RMS auctionHouse"
    },
    {
        label = "Mailbox",
        name = "mailbox",
        iconPath = "Interface\\Icons\\inv_letter_15",
        icon = "inv_letter_15",
        macro = "/rms mailbox",
        macroName = "RMS mailbox",
    },
    {
        label = "Multiple",
        name = "multiple",
        iconPath = "Interface\\Icons\\ability_mount_camel_brown",
        icon = "ability_mount_camel_brown",
        macro = "/rms multiple",
        macroName = "RMS multiple"
    }
}

local function applySummonKeyBinding(type)
    -- First clear all previous bindings
    ClearOverrideBindings(RuthesMS.frames.mountSelectorFrame.frame)

    -- Normal summon
    local formattedKey = string.gsub(RuthesMS.keybinds.normal, "+", "-")
    SetOverrideBindingClick(RuthesMS.frames.mountSelectorFrame.frame, true, formattedKey,
        "RuthesMSRandomMountButton")

    -- Aquatic summon
    formattedKey = string.gsub(RuthesMS.keybinds.aquatic, "+", "-")
    SetOverrideBindingClick(RuthesMS.frames.mountSelectorFrame.frame, true, formattedKey,
        "RuthesMSRandomAquaticMountButton")

    -- Repair summon
    formattedKey = string.gsub(RuthesMS.keybinds.repair, "+", "-")
    SetOverrideBindingClick(RuthesMS.frames.mountSelectorFrame.frame, true, formattedKey,
        "RuthesMSRandomRepairMountButton")

    -- Transmog summon
    formattedKey = string.gsub(RuthesMS.keybinds.transmog, "+", "-")
    SetOverrideBindingClick(RuthesMS.frames.mountSelectorFrame.frame, true, formattedKey,
        "RuthesMSRandomTransmogMountButton")


    -- Auction house summon
    formattedKey = string.gsub(RuthesMS.keybinds.auctionHouse, "+", "-")
    SetOverrideBindingClick(RuthesMS.frames.mountSelectorFrame.frame, true, formattedKey,
        "RuthesMSRandomAuctionHouseMountButton")

    -- Mailbox summon
    formattedKey = string.gsub(RuthesMS.keybinds.mailbox, "+", "-")
    SetOverrideBindingClick(RuthesMS.frames.mountSelectorFrame.frame, true, formattedKey,
        "RuthesMSRandomMailboxMountButton")
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

local function createAndDragMacro(macroName, macroBody, macroIcon)
    local macroIndex = GetMacroIndexByName(macroName)

    if macroIndex == 0 then
        macroIndex = CreateMacro(macroName, macroIcon, macroBody, true)
    else
        EditMacro(macroIndex, macroName, macroIcon, macroBody)
    end

    if macroIndex then
        PickupMacro(macroIndex)
    end
end

local function createMacroButton(parentFrame, size, position, iconPath, tooltipText, macroName, macroBody, macroIcon)
    local button = CreateFrame("Button", nil, parentFrame, "UIPanelButtonTemplate")
    button:SetSize(size, size)
    button:SetPoint(unpack(position))
    button:SetNormalTexture(iconPath)

    -- Set up the click handler to create and drag the macro
    button:SetScript("OnClick", function()
        createAndDragMacro(macroName, macroBody, macroIcon)
    end)

    -- Add a tooltip
    button:EnableMouse(true)
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tooltipText, 1, 1, 1)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    return button
end

local function createKeybindFrame()
    local mountSelectorFrame = RuthesMS.frames.mountSelectorFrame.frame

    local keybindFrame = CreateFrame("Frame", "MountSelectorKeybindFrame", mountSelectorFrame,
        "BackdropTemplate")
    keybindFrame:SetSize(400, 400)
    keybindFrame:SetPoint("CENTER", mountSelectorFrame, "CENTER", 0, 0)

    local yOffset = -10
    local lineHeight = 35

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
        createMacroButton(
            keybindFrame,                                                                        -- Parent frame
            30,                                                                                  -- Button size
            { "TOPRIGHT", keybindFrame, "TOPRIGHT", -20, -35 - yOffset - (index * lineHeight) }, -- Position
            value.iconPath,                                                                      -- Icon path
            "Create Summon Macro",                                                               -- Tooltip text
            value.macroName,                                                                     -- Macro name
            value.macro,                                                                         -- Macro body
            value.icon                                                                           -- Macro icon
        )
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
