-- Create the MountSelectorFrame
mountSelectorFrame = CreateFrame("Frame", "MountSelectorFrame", UIParent, "BasicFrameTemplateWithInset")
mountSelectorFrame:SetSize(400, 500) -- Increased height to make the window taller
mountSelectorFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0) -- Position at the center of the screen
mountSelectorFrame:Hide()

-- Enable the frame to be movable
mountSelectorFrame:SetMovable(true)
mountSelectorFrame:EnableMouse(true)

-- Create a title for the frame
mountSelectorFrame.title = mountSelectorFrame:CreateFontString(nil, "OVERLAY")
mountSelectorFrame.title:SetFontObject("GameFontHighlightLarge")
mountSelectorFrame.title:SetPoint("TOP", mountSelectorFrame.TitleBg, "TOP", 0, -5) -- Adjusted for better alignment
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

-- Create a scrollable content frame inside the main frame
local scrollFrame = CreateFrame("ScrollFrame", nil, mountSelectorFrame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 10, -30)
scrollFrame:SetPoint("BOTTOMRIGHT", mountSelectorFrame, "BOTTOMRIGHT", -30, 10) -- Leave space for the scrollbar

-- Create a child frame to hold the content
local contentFrame = CreateFrame("Frame", nil, scrollFrame)
scrollFrame:SetScrollChild(contentFrame)

-- Function to update the height of the content frame
local function updateContentFrameHeight()
    local numMounts = C_MountJournal.GetNumDisplayedMounts()
    local contentHeight = numMounts * 35 -- Each mount button row is approximately 35 pixels tall
    contentFrame:SetSize(scrollFrame:GetWidth(), contentHeight)
end

-- Create the buttons when the addon is loaded and update the content height
createMountButtons(contentFrame)
updateContentFrameHeight()
