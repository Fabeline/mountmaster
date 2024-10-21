-- Add a button to summon a random mount from the visible list
local randomMountButton = CreateFrame("Button", "RandomMountButton", mountSelectorFrame, "UIPanelButtonTemplate")
randomMountButton:SetSize(120, 22)
randomMountButton:SetPoint("BOTTOM", mountSelectorFrame, "BOTTOM", 0, 10)
randomMountButton:SetText("Random Mount")

function summonRandomMount()
    if IsMounted() then
        Dismount()
    else
        reloadMounts()

        if #currentMounts > 0 then
            local flyingMounts = {}
            local groundMounts = {}

            for _, mount in ipairs(currentMounts) do
                if mount.isFlying then
                    table.insert(flyingMounts, mount)
                else
                    table.insert(groundMounts, mount)
                end
            end

            local chosenMounts
            if canPlayerFly() and #flyingMounts > 0 then
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
        summonRandomMount()
    end)

    -- clear the previous keybinding
    ClearOverrideBindings(mountSelectorFrame)
    -- set the new one
    SetOverrideBindingClick(mountSelectorFrame, true, summonKey, "RandomMountButton")
end
