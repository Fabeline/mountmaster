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

    -- Create a dropdown menu for filtering by color
    local colorDropdown = CreateFrame("FRAME", "ColorFilterDropdown", mountSelectorFrame, "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(colorDropdown, 120)
    colorDropdown:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 0, -35)
    UIDropDownMenu_Initialize(colorDropdown, RuthesMS.utils.filterDropdowns.initializeColorDropdown)

    -- Create a dropdown menu for filtering by skeleton type
    local skeletonDropdown = CreateFrame("FRAME", "SkeletonFilterDropdown", mountSelectorFrame, "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(skeletonDropdown, 120)
    skeletonDropdown:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 0, -65)
    UIDropDownMenu_Initialize(skeletonDropdown, RuthesMS.utils.filterDropdowns.initializeSkeletonDropdown)

    -- Create a dropdown menu for filtering by expansion
    local expansionDropdown = CreateFrame("FRAME", "ExpansionFilterDropdown", mountSelectorFrame,
        "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(expansionDropdown, 120)
    expansionDropdown:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 0, -95)
    UIDropDownMenu_Initialize(expansionDropdown, RuthesMS.utils.filterDropdowns.initializeExpansionDropdown)

    UIDropDownMenu_SetText(skeletonDropdown, "Select types")
    UIDropDownMenu_SetText(colorDropdown, "Select colors")
    UIDropDownMenu_SetText(expansionDropdown, "Select expansions")

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

    RuthesMS.frames.mountSelectorFrame.frame = mountSelectorFrame
end

RuthesMS.frames.mountSelectorFrame = {
    frame = nil,
    create = createMountSelectorFrame
}
