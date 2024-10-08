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

-- Enable the frame to be movable
mountSelectorFrame:SetMovable(true)
mountSelectorFrame:EnableMouse(true)

-- Create a title for the frame
mountSelectorFrame.title = mountSelectorFrame:CreateFontString(nil, "OVERLAY")
mountSelectorFrame.title:SetFontObject("GameFontHighlightLarge")
mountSelectorFrame.title:SetPoint("TOP", mountSelectorFrame.TitleBg, "TOP", 0, -3)
mountSelectorFrame.title:SetText("Mount Selector")

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
    if not MountSelectorFrame:IsShown() then
        MountSelectorFrame:Show()
    else
        MountSelectorFrame:Hide()
    end
end

createContentFrame()
