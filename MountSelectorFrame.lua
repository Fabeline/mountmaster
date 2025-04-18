local function createTabs()
    local mountSelectorFrame = RuthesMS.frames.mountSelectorFrame.frame

    local tabNames = { "General", "Keybinds", "Advanced", "Help" }
    local tabs = {}

    -- Function to switch active tab
    local function selectTab(index)
        for i, tab in ipairs(tabs) do
            if i == index then
                tab:SetBackdropBorderColor(1, 1, 0, 1) -- yellow border
                tab:Disable()
                if (i == 1) then
                    RuthesMS.frames.generalFrame.show()
                    RuthesMS.frames.keybindFrame.hide()
                    RuthesMS.frames.helpFrame.hide()
                elseif (i == 2) then
                    RuthesMS.frames.generalFrame.hide()
                    RuthesMS.frames.keybindFrame.show()
                    RuthesMS.frames.helpFrame.hide()
                elseif (i == 3) then
                    RuthesMS.frames.generalFrame.hide()
                    RuthesMS.frames.keybindFrame.hide()
                    RuthesMS.frames.helpFrame.show()
                end
            else
                tab:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
                tab:Enable()
            end
        end
    end

    for i, name in ipairs(tabNames) do
        local tab = CreateFrame("Button", nil, mountSelectorFrame, "UIPanelButtonTemplate, BackdropTemplate")
        tab:SetSize(100, 24)

        if i == 1 then
            tab:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 0, -25)
        else
            tab:SetPoint("LEFT", tabs[i - 1], "RIGHT", -1, 0)
        end

        tab:SetText(name)
        tab:SetScript("OnClick", function()
            selectTab(i)
        end)

        -- Add a backdrop so we can change border color
        tab:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 12,
            insets = { left = 2, right = 2, top = 2, bottom = 2 }
        })
        tab:SetBackdropColor(0.1, 0.1, 0.1, 0.9)
        tab:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)

        tabs[i] = tab
    end

    selectTab(1)
end

local function createAndDragMacro(macroName, macroBody, macroIcon)
    -- Check if the macro already exists
    local macroIndex = GetMacroIndexByName(macroName)

    if macroIndex == 0 then
        -- Create a new macro if it doesn't exist
        macroIndex = CreateMacro(macroName, macroIcon, macroBody, true)
    else
        -- Update the existing macro
        EditMacro(macroIndex, macroName, macroIcon, macroBody)
    end

    -- Pick up the macro and allow dragging
    if macroIndex then
        PickupMacro(macroIndex)
    end
end

-- Reusable function to set up a macro button
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

local function createMountSelectorFrame()
    -- Create the MountSelectorFrame
    local mountSelectorFrame = CreateFrame("Frame", "MountSelectorFrame", UIParent, "BasicFrameTemplateWithInset")
    mountSelectorFrame:SetSize(400, 500)
    mountSelectorFrame:SetPoint("CENTER", UIParent, "CENTER", -400, 0)
    mountSelectorFrame:Hide()
    RuthesMS.frames.mountSelectorFrame.frame = mountSelectorFrame

    -- Make the frame closeable with ESC
    table.insert(UISpecialFrames, "MountSelectorFrame")

    -- Enable the frame to be movable
    mountSelectorFrame:SetMovable(true)
    mountSelectorFrame:EnableMouse(true)

    -- Create a title for the frame
    mountSelectorFrame.title = mountSelectorFrame:CreateFontString(nil, "OVERLAY")
    mountSelectorFrame.title:SetFontObject("GameFontHighlightMedium")
    mountSelectorFrame.title:SetPoint("TOP", mountSelectorFrame.TitleBg, "TOP", 0, -4.5)
    mountSelectorFrame.title:SetText("Ruthe's Mount Selector")

    -- Make the title bar draggable
    mountSelectorFrame.TitleBg:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            mountSelectorFrame:StartMoving()
        end
    end)

    mountSelectorFrame.TitleBg:SetScript("OnMouseUp", function(self)
        mountSelectorFrame:StopMovingOrSizing()
    end)

    createTabs()
    RuthesMS.frames.mountSelectorFrame.frame = mountSelectorFrame
end

local function later()
    -- Create buttons for both macros
    -- Normal mounts
    createMacroButton(
        mountSelectorFrame,                             -- Parent frame
        30,                                             -- Button size
        { "TOP", mountSelectorFrame, "TOP", -14, -37 }, -- Position
        "Interface\\Icons\\Ability_Mount_RidingHorse",  -- Icon path
        "Create Summon Macro",                          -- Tooltip text
        "RMS",                                          -- Macro name
        "/rms summon",                                  -- Macro body
        "Ability_Mount_RidingHorse"                     -- Macro icon
    )

    -- Aquatic mounts
    createMacroButton(
        mountSelectorFrame,                            -- Parent frame
        30,                                            -- Button size
        { "TOP", mountSelectorFrame, "TOP", 23, -37 }, -- Position
        "Interface\\Icons\\inv_stingray2mount_teal",   -- Icon path
        "Create Summon Swim Macro",                    -- Tooltip text
        "SWM",                                         -- Macro name
        "/rms summonswim",                             -- Macro body
        "inv_stingray2mount_teal"                      -- Macro icon
    )
end

RuthesMS.frames.mountSelectorFrame = {
    frame = nil,
    create = createMountSelectorFrame
}
