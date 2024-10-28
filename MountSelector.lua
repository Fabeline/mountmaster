-- MountSelector.lua

-- TODO: dont set it to a default key
-- TODO: check if in combat!
-- TODO: check if you are inside

-- Create the MountSelectorFrame
mountSelectorFrame = CreateFrame("Frame", "MountSelectorFrame", UIParent, "BasicFrameTemplateWithInset")
mountSelectorFrame:SetSize(400, 500)
mountSelectorFrame:SetPoint("CENTER", UIParent, "CENTER", -400, 0)
mountSelectorFrame:Hide()

-- Create a dropdown menu for filtering by color
colorDropdown = CreateFrame("FRAME", "ColorFilterDropdown", mountSelectorFrame, "UIDropDownMenuTemplate")
UIDropDownMenu_SetWidth(colorDropdown, 150)
colorDropdown:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 0, -35)
UIDropDownMenu_Initialize(colorDropdown, initializeColorDropdown)

-- Create a dropdown menu for filtering by skeleton type
skeletonDropdown = CreateFrame("FRAME", "SkeletonFilterDropdown", mountSelectorFrame, "UIDropDownMenuTemplate")
UIDropDownMenu_SetWidth(skeletonDropdown, 150)
skeletonDropdown:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 0, -65)
UIDropDownMenu_Initialize(skeletonDropdown, initializeSkeletonDropdown)


-- Create the macro button
local createMacroButton = CreateFrame("Button", nil, mountSelectorFrame, "UIPanelButtonTemplate")
createMacroButton:SetSize(40, 40)
createMacroButton:SetPoint("TOP", mountSelectorFrame, "TOP", 33, -39)
createMacroButton:SetNormalTexture("Interface\\Icons\\Ability_Mount_RidingHorse")

-- Set the script to create the macro when clicked
createMacroButton:SetScript("OnClick", function()
    createAndDragSummonMacro()
end)

-- Add a tooltip
createMacroButton:EnableMouse(true)
createMacroButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Create Summon Macro", 1, 1, 1)
    GameTooltip:Show()
end)
createMacroButton:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
end)


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

function SlashCmdList.RMS(msg, editBox)
    if msg == "summon" then -- /rms summon - will summon a random mount
        summonRandomMount()
    elseif msg == "minimap" then --/rms minimap - will toggle minimap button
        toggleMinimap()
    else
        if not MountSelectorFrame:IsShown() then -- /rms - will toggle the mount selector window
            MountSelectorFrame:Show()
        else
            MountSelectorFrame:Hide()
        end
    end
end

createContentFrame()
