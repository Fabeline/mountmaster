RuthesMS.frames.mountSelectorFrame.create()
RuthesMS.frames.mountSelectorScrollFrame.create()
RuthesMS.frames.contentFrame.create()
RuthesMS.buttons.frameButtons.create()

local function printHelp()
    print("|cffffcc00==================================|r")
    print("|cffff9900  Ruthe's Mount Selector      |r")
    print("|cffffcc00==================================|r")
    print("|cffffff00Commands:                         |r")
    print("|cff00ff00  /rms |r - Toggles the mount selector window")
    print("|cff00ff00  /rms summon |r - Summons a random mount")
    print("|cff00ff00  /rms summonswim |r - Summons a random swimming mount")
    print("|cff00ff00  /rms minimap |r - Toggles the minimap button")
    print("|cff00ff00  /rms help |r - Displays this help message")
    print("|cffffcc00==================================|r")
end

function SlashCmdList.RMS(msg, editBox)
    if msg == "summon" then         -- /rms summon - will summon a random mount
        RuthesMS.mountFunctions.summonRandomMount(false)
    elseif msg == "summonswim" then -- /rms summonswim - will summon a random swimming mount
        RuthesMS.mountFunctions.summonRandomMount(true)
    elseif msg == "minimap" then    --/rms minimap - will toggle minimap button
        toggleMinimap()
    elseif msg == "help" then       --/rms help - will display help message
        printHelp()
    else
        if not RuthesMS.frames.mountSelectorFrame.frame:IsShown() then -- /rms - will toggle the mount selector window
            RuthesMS.frames.mountSelectorFrame.frame:Show()
        else
            RuthesMS.frames.mountSelectorFrame.frame:Hide()
        end
    end
end
