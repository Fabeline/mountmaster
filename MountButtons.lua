-- Function to get mount names, create buttons, and display textures
function createMountButtons(parentFrame)
    local numMounts = C_MountJournal.GetNumDisplayedMounts() -- Get the number of mounts
    local maxPrints = math.min(numMounts, 10) -- Limit to 10 mounts or the number you have, whichever is smaller

    for i = 1, maxPrints do
        local mountID = C_MountJournal.GetDisplayedMountID(i) -- Get the mount ID for the current index
        local name, spellID, icon, active, isUsable, sourceType, isFavorite, isFactionSpecific, faction, hideOnChar, isCollected = C_MountJournal.GetMountInfoByID(mountID)

        if isCollected then
            -- Create a texture for the mount icon
            local mountIcon = parentFrame:CreateTexture(nil, "ARTWORK")
            mountIcon:SetSize(24, 24) -- Icon size
            mountIcon:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 10, -30 - (i-1) * 30) -- Position the icon
            mountIcon:SetTexture(icon) -- Set the mount icon texture

            -- Create a font string for the mount name
            local mountText = parentFrame:CreateFontString(nil, "OVERLAY")
            mountText:SetFontObject("GameFontNormal")
            mountText:SetPoint("LEFT", mountIcon, "RIGHT", 10, 0) -- Position to the right of the mount icon
            mountText:SetText(name)
            mountText:SetJustifyH("LEFT")
            
            -- Create a button to summon the mount
            local summonButton = CreateFrame("Button", nil, parentFrame, "UIPanelButtonTemplate")
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
