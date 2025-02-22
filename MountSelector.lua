-- Create the MountSelectorFrame
mountSelectorFrame = CreateFrame("Frame", "MountSelectorFrame", UIParent, "BasicFrameTemplateWithInset")
mountSelectorFrame:SetSize(400, 500)
mountSelectorFrame:SetPoint("CENTER", UIParent, "CENTER", -400, 0)
mountSelectorFrame:Hide()

-- Make the frame closeable with ESC
table.insert(UISpecialFrames, "MountSelectorFrame")

-- Create a dropdown menu for filtering by color
colorDropdown = CreateFrame("FRAME", "ColorFilterDropdown", mountSelectorFrame, "UIDropDownMenuTemplate")
UIDropDownMenu_SetWidth(colorDropdown, 120)
colorDropdown:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 0, -35)
UIDropDownMenu_Initialize(colorDropdown, initializeColorDropdown)

-- Create a dropdown menu for filtering by skeleton type
skeletonDropdown = CreateFrame("FRAME", "SkeletonFilterDropdown", mountSelectorFrame, "UIDropDownMenuTemplate")
UIDropDownMenu_SetWidth(skeletonDropdown, 120)
skeletonDropdown:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 0, -65)
UIDropDownMenu_Initialize(skeletonDropdown, initializeSkeletonDropdown)


-- Reusable function to set up a macro button
function createMacroButton(parentFrame, size, position, iconPath, tooltipText, macroName, macroBody, macroIcon)
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

-- Create buttons for both macros
normalMacroButton = createMacroButton(
    mountSelectorFrame, -- Parent frame
    30,                 -- Button size
    {"TOP", mountSelectorFrame, "TOP", -14, -37}, -- Position
    "Interface\\Icons\\Ability_Mount_RidingHorse", -- Icon path
    "Create Summon Macro", -- Tooltip text
    "RMS",              -- Macro name
    "/rms summon",      -- Macro body
    "Ability_Mount_RidingHorse" -- Macro icon
)

swimMacroButton = createMacroButton(
    mountSelectorFrame, -- Parent frame
    30,                 -- Button size
    {"TOP", mountSelectorFrame, "TOP", 23, -37}, -- Position
    "Interface\\Icons\\inv_stingray2mount_teal", -- Icon path
    "Create Summon Swim Macro", -- Tooltip text
    "SWM",              -- Macro name
    "/rms summonswim",  -- Macro body
    "inv_stingray2mount_teal" -- Macro icon
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

-- Create a scroll frame to hold the mount buttons
mountSelectorScrollFrame = CreateFrame("ScrollFrame", "MountSelectorScrollFrame", mountSelectorFrame, "UIPanelScrollFrameTemplate")
mountSelectorScrollFrame:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 10, -110)
mountSelectorScrollFrame:SetPoint("BOTTOMRIGHT", mountSelectorFrame, "BOTTOMRIGHT", -30, 40)

local function printHelp()
    print("|cffffcc00==================================|r")
    print("|cffff9900  Ruthe's Mount Selector      |r")
    print("|cffffcc00==================================|r")
    print("|cffffff00Commands:                         |r")
    print("|cff00ff00  /rms |r - Toggles the mount selector window")
    print("|cff00ff00  /rms summon |r - Summons a random mount")
    print("|cff00ff00  /rms summonswim |r - Summons a random swimming mount")
    print("|cff00ff00  /rms minimap |r - Toggles the minimap button")
    print("|cff00ff00  /rms help |r - Displays this help message")
    print("|cffffcc00==================================|r")
end


function SlashCmdList.RMS(msg, editBox)
    if msg == "summon" then -- /rms summon - will summon a random mount
        summonRandomMount(false)
    elseif msg == "summonswim" then -- /rms summonswim - will summon a random swimming mount
        summonRandomMount(true)
    elseif msg == "minimap" then --/rms minimap - will toggle minimap button
        toggleMinimap()
    elseif msg == "help" then --/rms help - will display help message
        printHelp()
    else
        if not MountSelectorFrame:IsShown() then -- /rms - will toggle the mount selector window
            MountSelectorFrame:Show()
        else
            MountSelectorFrame:Hide()
        end
    end
end

createContentFrame()
