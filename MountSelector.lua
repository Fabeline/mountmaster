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
