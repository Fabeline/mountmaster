-- Create a frame when the addon is loaded
local mountSelectorFrame = CreateFrame("Frame", "MountSelectorFrame", UIParent, "BasicFrameTemplateWithInset")
mountSelectorFrame:SetSize(400, 300) -- Increased Width, Height
mountSelectorFrame:SetPoint("CENTER") -- Position the frame in the center of the screen

-- Create a title for the frame
mountSelectorFrame.title = mountSelectorFrame:CreateFontString(nil, "OVERLAY")
mountSelectorFrame.title:SetFontObject("GameFontHighlightLarge")
mountSelectorFrame.title:SetPoint("TOP", mountSelectorFrame.TitleBg, "TOP", 0, -5) -- Adjusted for better alignment
mountSelectorFrame.title:SetText("Mount Selector")

-- Function to get mount names and create buttons
local function createMountButtons()
    local numMounts = C_MountJournal.GetNumDisplayedMounts() -- Get the number of mounts
    local maxPrints = math.min(numMounts, 10) -- Limit to 10 mounts or the number you have, whichever is smaller

    for i = 1, maxPrints do
        local mountID = C_MountJournal.GetDisplayedMountID(i) -- Get the mount ID for the current index
        local name, spellID, icon, active, isUsable, sourceType, isFavorite, isFactionSpecific, faction, hideOnChar, isCollected = C_MountJournal.GetMountInfoByID(mountID)

        if isCollected then
            -- Create a font string for the mount name
            local mountText = mountSelectorFrame:CreateFontString(nil, "OVERLAY")
            mountText:SetFontObject("GameFontNormal")
            mountText:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 10, -30 - (i-1) * 30) -- Adjust position based on index
            mountText:SetText(name)
            mountText:SetJustifyH("LEFT")
            
            -- Create a button to summon the mount
            local summonButton = CreateFrame("Button", nil, mountSelectorFrame, "UIPanelButtonTemplate")
            summonButton:SetSize(80, 22) -- Button size
            summonButton:SetPoint("LEFT", mountText, "RIGHT", 10, 0) -- Position to the right of the mount name
            summonButton:SetText("Summon")
            
            -- Set up the button to summon the mount when clicked
            summonButton:SetScript("OnClick", function()
                C_MountJournal.SummonByID(mountID)
            end)
        end
    end
end

-- Create the buttons when the addon is loaded
createMountButtons()

-- Create the Minimap Button
local mountSelectorMinimapButton = CreateFrame("Button", "MountSelectorMinimapButton", Minimap)
mountSelectorMinimapButton:SetSize(32, 32) -- Size of the minimap button
mountSelectorMinimapButton:SetFrameStrata("MEDIUM")
mountSelectorMinimapButton:SetFrameLevel(8)

-- Set the minimap button's texture
mountSelectorMinimapButton:SetNormalTexture("Interface\\AddOns\\MountSelector\\Textures\\MountSelector") -- Path to the normal texture
mountSelectorMinimapButton:SetPushedTexture("Interface\\AddOns\\MountSelector\\Textures\\MountSelector") -- Path to the pushed texture
mountSelectorMinimapButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight") -- Highlight texture

-- Position the minimap button
mountSelectorMinimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -10, -10)

-- Make the button draggable around the minimap
mountSelectorMinimapButton:RegisterForDrag("LeftButton")
mountSelectorMinimapButton:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)
mountSelectorMinimapButton:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)

-- Set up the click event to toggle the MountSelector window
mountSelectorMinimapButton:SetScript("OnClick", function(self, button)
    if mountSelectorFrame:IsShown() then
        mountSelectorFrame:Hide()
    else
        mountSelectorFrame:Show()
    end
end)

-- Set the minimap button texture (you may need to adjust the file paths)
if not mountSelectorMinimapButton:GetNormalTexture() then
    local tex = mountSelectorMinimapButton:CreateTexture(nil, "BACKGROUND")
    tex:SetTexture("Interface\\AddOns\\MountSelector\\Textures\\MountIconNormal")
    tex:SetAllPoints()
    mountSelectorMinimapButton:SetNormalTexture(tex)
end

-- Initialize the MountSelector frame as hidden
mountSelectorFrame:Hide()


-- Function to update the button's position around the minimap
local function updateMinimapButtonPosition()
    local angle = math.rad(45) -- Adjust this value to place the button at a different angle
    local x = cos(angle) * 80
    local y = sin(angle) * 80
    mountSelectorMinimapButton:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

