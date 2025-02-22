-- TODO: add more underwater mounts if steady flight is on

function isSteadyFlightActive()
    local buffName = "Flight Style: Steady" -- Replace with the exact name of the buff
    return AuraUtil.FindAuraByName(buffName, "player", "HELPFUL") ~= nil
end

-- Add a button to summon a random mount from the visible list
local randomMountButton = CreateFrame("Button", "RandomMountButton", mountSelectorFrame, "UIPanelButtonTemplate")
randomMountButton:SetSize(120, 22)
randomMountButton:SetPoint("BOTTOM", mountSelectorFrame, "BOTTOM", 0, 10)
randomMountButton:SetText("Random Mount")

-- Add Info Button Beside Random Mount Button
local infoButton = CreateFrame("Button", "InfoButton", mountSelectorFrame, "UIPanelButtonTemplate")
infoButton:SetSize(20, 20)
infoButton:SetPoint("LEFT", RandomMountButton, "RIGHT", 5, 0)
infoButton:SetText("?")

infoButton:SetScript("OnClick", function()
    StaticPopup_Show("RUTHES_MOUNT_INFO")
end)

-- Create Info Popup
StaticPopupDialogs["RUTHES_MOUNT_INFO"] = {
    text = "|cffff8000 Ruthe's Mount Selector|r\n\n" ..
    
        "Welcome to Ruthe's Mount Selector! This addon will help you to summon a random mount based on your preferences.\n\n" ..

        "You can set a keybind to summon a random mount, or use the button in the Mount Selector window. You can also click one of the icons to create a custom icon that you can drag to your action bar.\n\n" ..
        
        "|cffffff00Small in instances:|r\n" ..
        "Check this box if you want to only summon small mounts while in instances (dungeons, raids, etc.).\n\n" ..
        
        "|cffffff00Only favorites:|r\n" ..
        "Check this box if you want to only summon mounts that you have marked as favorites.\n\n" ..
        
        "|cffffff00Commands:|r\n" ..
        "   /rms - Open the mount selector\n" ..
        "   /rms summon - Summon a random mount\n" ..
        "   /rms summonswim - Summon a swimming mount\n" ..
        "   /rms minimap - Toggle minimap button\n" ..
        "   /rms help - available commands\n\n" ..
        
        "|cffffff00For more info or feedback:|r\n" ..
        "|cff00ccffhttps://www.curseforge.com/wow/addons/ruthes-mountselector",
    button1 = "OK",
    OnAccept = function() end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}


local function displayBigMessage(message)
    UIErrorsFrame:AddMessage(message, 1.0, 0.0, 0.0) -- text, red, green, blue
end

function canSummonMount()
    -- Check if the player is in combat
    if UnitAffectingCombat("player") then
        displayBigMessage("You cannot mount in combat.")
        -- return false -> you can summon in some instances like Dawnbreaker and Tindral
    end

    -- Check if the player is dead or in ghost form
    if UnitIsDeadOrGhost("player") then
        displayBigMessage("You cannot mount while dead or in ghost form.")
        return false
    end

    -- Check if the player is indoors
    if IsIndoors() then
        displayBigMessage("You cannot mount indoors.")
        return false
    end

    return true
end

function summonRandomMount(isSwimming)
    if IsMounted() then
        Dismount()
    else
        CancelShapeshiftForm()
        if(canSummonMount() == false) then
            return
        end

        reloadMounts()

        if #currentMounts > 0 then
            local chosenMounts           
            
            local flyingMounts = {}
            local groundMounts = {}
            local aquaticMounts = {}

            for _, mount in ipairs(currentMounts) do
                if mount.isFlying then -- flying and aquatic if steady flight is active
                    table.insert(flyingMounts, mount)
                    -- Mounts with flying and aquatic have a bug where they are only fast
                    -- underwater if steady flight is active                    
                    if mount.isAquatic and isSteadyFlightActive() then
                        table.insert(aquaticMounts, mount)
                    end
                elseif mount.isAquatic then -- aquatic and not flying                  
                    table.insert(aquaticMounts, mount)
                end
            
                if ((not mount.isFlying or hasGroundAnim(mount.id, mount.skeleton_type)) and not mount.isAquatic) then
                    table.insert(groundMounts, mount)
                end
            end
            

            if(isSwimming) then
                if #aquaticMounts > 0 then
                    chosenMounts = aquaticMounts
                else
                    -- If the aquatic mounts don't fit the criteria, summon a random aquatic mount
                    currentMounts = allMounts
                    if(#currentMounts > 0) then
                        for _, mount in ipairs(currentMounts) do
                            if mount.isAquatic then
                                table.insert(aquaticMounts, mount)
                            end
                        end
                        chosenMounts = aquaticMounts
                    else
                        print("No aquatic mounts available to summon.")
                    end
                end
            elseif canPlayerFly() and #flyingMounts > 0 then
                chosenMounts = flyingMounts
            else
                chosenMounts = groundMounts
            end          

            if #chosenMounts > 0 then
                local randomIndex = math.random(1, #chosenMounts)
                C_MountJournal.SummonByID(chosenMounts[randomIndex].id)
            else
                print("No mounts available to summon.")
            end
            
        else
            print("No mounts available to summon.")
        end
    end
end

function loadRandomMountButton()
    randomMountButton:SetScript("OnClick", function()
        summonRandomMount(false)
    end)

    -- clear the previous keybinding
    ClearOverrideBindings(mountSelectorFrame)
    -- set the new one
    SetOverrideBindingClick(mountSelectorFrame, true, summonKey, "RandomMountButton")
end
