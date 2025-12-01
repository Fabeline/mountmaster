local detectedKey = nil
local detectedModifiers = {}
local selectedType = ""
local characterSpecificKeybindsCheckbox

local keybindTable = {
    {
        label = "Summon mount",
        name = "normal",
        iconPath = "Interface\\Icons\\Ability_Mount_RidingHorse",
        icon = "Ability_Mount_RidingHorse",
        macro = "/rms summon",
        macroName = "RMS normal",
        tooltip = "Summon a random flying or ground mount, \nbased on your current zone."
    },
    {
        label = "Ground mount",
        name = "ground",
        iconPath = "Interface\\Icons\\ability_mount_raptor",
        icon = "ability_mount_raptor",
        macro = "/rms summonground",
        macroName = "RMS ground",
    },
    {
        label = "Small mount",
        name = "small",
        iconPath = "Interface\\Icons\\Inv_alpacamount_brown",
        icon = "Inv_alpacamount_brown",
        macro = "/rms summonsmall",
        macroName = "RMS small",
        tooltip =
        "Summon a random flying or ground mount, \nbased on your current zone.\nIt will always pick a small mount."
    },
    {
        label = "Aquatic mount",
        name = "aquatic",
        iconPath = "Interface\\Icons\\inv_stingray2mount_teal",
        icon = "inv_stingray2mount_teal",
        macro = "/rms summonswim",
        macroName = "RMS aquatic",
        tooltip =
        "Summon a random aquatic mount. \nNote that aquatic mounts that can fly will only \ncount as aquatic if you are using steady flying."
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
        iconPath = "Interface\\Icons\\ability_ardenweald_mage",
        icon = "ability_ardenweald_mage",
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
        label = "Multiple riders",
        name = "multiple",
        iconPath = "Interface\\Icons\\ability_mount_camel_brown",
        icon = "ability_mount_camel_brown",
        macro = "/rms multiple",
        macroName = "RMS multiple"
    }
}


local function applySummonKeyBinding()
    ClearOverrideBindings(RuthesMS.frames.mountSelectorFrame.frame)

    local function bindKey(keyName, buttonName)
        if keyName then
            local formattedKey = string.gsub(keyName, "+", "-")
            SetOverrideBindingClick(RuthesMS.frames.mountSelectorFrame.frame, true, formattedKey, buttonName)
        end
    end

    bindKey(RuthesMS.keybinds.normal, "RuthesMSRandomMountButton")
    bindKey(RuthesMS.keybinds.small, "RuthesMSRandomSmallMountButton")
    bindKey(RuthesMS.keybinds.ground, "RuthesMSRandomGroundMountButton")
    bindKey(RuthesMS.keybinds.aquatic, "RuthesMSRandomAquaticMountButton")
    bindKey(RuthesMS.keybinds.repair, "RuthesMSRandomRepairMountButton")
    bindKey(RuthesMS.keybinds.transmog, "RuthesMSRandomTransmogMountButton")
    bindKey(RuthesMS.keybinds.auctionHouse, "RuthesMSRandomAuctionHouseMountButton")
    bindKey(RuthesMS.keybinds.mailbox, "RuthesMSRandomMailboxMountButton")
    bindKey(RuthesMS.keybinds.multiple, "RuthesMSRandomMultipleMountButton")
end


-- Ensure Keybinding is Applied After Login
local function loadSummoningKey()
    RuthesMS.frames.keybindFrame.delete()
    RuthesMS.frames.keybindFrame.create()

    -- Reload the checkbox
    if characterSpecificKeybindsCheckbox then
        characterSpecificKeybindsCheckbox:SetChecked(not RuthesMS.settings.globalKeybinds)
    end

    applySummonKeyBinding()
end

StaticPopupDialogs["SET_KEYBIND"] = {
    text = "Press a key to set as your summon key",
    button1 = "Cancel",
    button2 = "Delete",
    OnAccept = function() end,
    OnCancel = function(self)
        -- Save & Apply Keybinding
        RuthesMS.keybinds[selectedType] = ""
        RuthesMS.db.saveSummonKey("", selectedType)
        loadSummoningKey()
        StaticPopup_Hide("SET_KEYBIND")
    end,
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
    keybindFrame:SetSize(400, 360)
    keybindFrame:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 20, -65)

    local yOffset = 0
    local lineHeight = 30

    -- Mount type
    local mountTypeLabel = keybindFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    mountTypeLabel:SetPoint("TOPLEFT", keybindFrame, "TOPLEFT", 0, yOffset)
    mountTypeLabel:SetText("Mount Type")

    -- Set keybind
    local setKeybindLabel = keybindFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    setKeybindLabel:SetPoint("TOP", keybindFrame, "TOP", 0, yOffset)
    setKeybindLabel:SetText("Keybind")

    -- Action button
    local setActionButtonLabel = keybindFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    setActionButtonLabel:SetPoint("TOPRIGHT", keybindFrame, "TOPRIGHT", -40, yOffset)
    setActionButtonLabel:SetText("Button")

    for index, value in ipairs(keybindTable) do
        if (index == 1 or index == 2) then
            yOffset = yOffset - lineHeight / 3 -- Add space for the first line
        end

        -- Mount type
        local keybindLabel = keybindFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        keybindLabel:SetPoint("TOPLEFT", keybindFrame, "TOPLEFT", 0, yOffset - (index * lineHeight))
        keybindLabel:SetText(value.label)

        -- Keybind button
        if value.noKey then
            local label = keybindFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            label:SetPoint("TOP", keybindFrame, "TOP", 0, yOffset - (index * lineHeight))
            label:SetText("Not available")
        else
            local setKeyButton = CreateFrame("Button", nil, keybindFrame, "UIPanelButtonTemplate")
            local keybindText = RuthesMS.keybinds[value.name]

            if keybindText == "" or keybindText == nil then
                keybindText = "Not set"
            else
                keybindText = RuthesMS.keybinds[value.name]
            end
            setKeyButton:SetSize(110, 22)
            setKeyButton:SetPoint("TOP", keybindFrame, "TOP", -0, yOffset - (index * lineHeight))
            setKeyButton:SetText(keybindText)

            -- Keybinding Popup (Detects Key Press)
            setKeyButton:SetScript("OnClick", function()
                detectedKey = nil
                detectedModifiers = {}
                selectedType = value.name
                StaticPopup_Show("SET_KEYBIND")
            end)
        end

        -- Action button icon
        createMacroButton(
            keybindFrame,                                                                  -- Parent frame
            30,                                                                            -- Button size
            { "TOPRIGHT", keybindFrame, "TOPRIGHT", -47, yOffset - (index * lineHeight) }, -- Position
            value.iconPath,                                                                -- Icon path
            "Create Summon Macro",                                                         -- Tooltip text
            value.macroName,                                                               -- Macro name
            value.macro,                                                                   -- Macro body
            value.icon                                                                     -- Macro icon
        )

        -- Tooltip
        if (value.tooltip) then
            local icon = CreateFrame("Button", nil, keybindFrame)
            icon:SetSize(15, 15)
            icon:SetPoint("LEFT", keybindLabel, "RIGHT", 5, 0)

            local texture = icon:CreateTexture(nil, "BACKGROUND")
            texture:SetAllPoints()
            texture:SetTexture("Interface\\FriendsFrame\\InformationIcon")

            icon:EnableMouse(true)
            icon:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(value.tooltip)
                GameTooltip:SetAlpha(0)
                GameTooltip:Show()
            end)
            icon:SetScript("OnLeave", function()
                GameTooltip:Hide()
            end)
        end
    end

    -- Character specific checkbox
    characterSpecificKeybindsCheckbox = CreateFrame("CheckButton", "CharacterSpecificKeybindsCheckbox", keybindFrame,
        "ChatConfigCheckButtonTemplate")
    characterSpecificKeybindsCheckbox:SetPoint("TOPLEFT", keybindFrame, "TOPLEFT", -5,
        yOffset - (#keybindTable * lineHeight) - 50)
    characterSpecificKeybindsCheckbox:SetScript("OnClick", function(self)
        RuthesMS.db.saveGlobalKeybinds(not self:GetChecked())
        RuthesMS.frames.keybindFrame.loadSummoningKey()
        RuthesMS.buttons.mountButtons.reload()
    end)
    local characterSpecificKeybindLabel = keybindFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    characterSpecificKeybindLabel:SetPoint("LEFT", characterSpecificKeybindsCheckbox, "RIGHT", 5, 0)
    characterSpecificKeybindLabel:SetText("Character specific keybinds")


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
