-- Add a button to summon a random mount from the visible list
local randomMountButton = CreateFrame("Button", "RandomMountButton", mountSelectorFrame, "UIPanelButtonTemplate")
randomMountButton:SetSize(120, 22)
randomMountButton:SetPoint("BOTTOM", mountSelectorFrame, "BOTTOM", 0, 10)
randomMountButton:SetText("Random Mount")

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
                if mount.isFlying then
                    table.insert(flyingMounts, mount)
                elseif mount.isAquatic then
                    table.insert(aquaticMounts, mount)
                else
                    table.insert(groundMounts, mount)
                end
            end

            if(isSwimming) then
                chosenMounts = aquaticMounts
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
