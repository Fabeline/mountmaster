-- MountSelector.lua

-- Print to confirm the file is loading
print("MountSelector.lua is running")

-- Create the MountSelectorFrame
mountSelectorFrame = CreateFrame("Frame", "MountSelectorFrame", UIParent, "BasicFrameTemplateWithInset")
mountSelectorFrame:SetSize(400, 500)
mountSelectorFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
mountSelectorFrame:Hide()

-- Ensure colorDropdown is available
if not colorDropdown then
    print("Error: colorDropdown is not initialized!")
    return
end

-- Attach the dropdown to the frame
colorDropdown:SetParent(mountSelectorFrame)
colorDropdown:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 10, -30)

-- Create a scrollable content frame inside the main frame
local scrollFrame = CreateFrame("ScrollFrame", "MountSelectorScrollFrame", mountSelectorFrame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 10, -60)
scrollFrame:SetPoint("BOTTOMRIGHT", mountSelectorFrame, "BOTTOMRIGHT", -30, 10)

-- Create a child frame to hold the content
contentFrame = CreateFrame("Frame", "MountSelectorContentFrame", scrollFrame, "BackdropTemplate")  -- Use BackdropTemplate
scrollFrame:SetScrollChild(contentFrame)

-- Set the content frame's width and height larger than the scroll frame so it can scroll
contentFrame:SetSize(scrollFrame:GetWidth(), 2000)
contentFrame:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
contentFrame:SetBackdropColor(0, 1, 0, 0.5)  -- Green background with 50% opacity for debugging

-- Enable the frame to be movable
mountSelectorFrame:SetMovable(true)
mountSelectorFrame:EnableMouse(true)

-- Create a title for the frame
mountSelectorFrame.title = mountSelectorFrame:CreateFontString(nil, "OVERLAY")
mountSelectorFrame.title:SetFontObject("GameFontHighlightLarge")
mountSelectorFrame.title:SetPoint("TOP", mountSelectorFrame.TitleBg, "TOP", 0, -5)
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
