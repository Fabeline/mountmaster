local function afterAddonLoaded()
    RuthesMS.db.init()
    RuthesMS.utils.mount.loadKnownMounts()

    RuthesMS.frames.generalFrame.reloadCheckboxes()
    RuthesMS.buttons.mountButtons.reload()
    RuthesMS.frames.keybindFrame.loadSummoningKey()
    RuthesMS.frames.mountSelectorFrame.selectTab(1)
    RuthesMS.buttons.randomMountButton.create()
    RuthesMS.utils.pet.getAvailablePets()

    RuthesMS.utils.druid.detectShapseshift()
    RuthesMS.utils.pet.detectDismountAndDismiss()
end

local function printHelp()
    print("|cffffcc00==================================|r")
    print("|cffff9900  Ruthe's Mount Selector      |r")
    print("|cffffcc00==================================|r")
    print("|cffffff00Commands:                         |r")
    print("|cff00ff00  /rms |r - Toggles the mount selector window")
    print("|cff00ff00  /rms minimap |r - Toggles the minimap button")
    print("|cff00ff00  /rms help |r - Displays this help message")
    print("|cffffcc00==================================|r")
end

SLASH_RMS1 = "/rms"

function SlashCmdList.RMS(msg, editBox)
    if msg == "summon" then           -- /rms summon - will summon a random mount
        RuthesMS.utils.summon.summonRandomMount(false)
    elseif msg == "summonsmall" then  -- /rms summonsmall - will summon a random small mount
        RuthesMS.utils.summon.summonRandomMount(false, true, false)
    elseif msg == "summonground" then -- /rms summonground - will summon a random ground mount
        RuthesMS.utils.summon.summonRandomMount(false, false, true)
    elseif msg == "summonswim" then   -- /rms summonswim - will summon a random swimming mount
        RuthesMS.utils.summon.summonRandomMount(true)
    elseif msg == "repair" then       -- /rms repair - will summon a random repair mount
        RuthesMS.utils.summon.summonRandomRepairMount()
    elseif msg == "transmog" then     -- /rms transmog - will summon a random transmog mount
        RuthesMS.utils.summon.summonRandomTransmogMount()
    elseif msg == "auctionHouse" then -- /rms auctionHouse - will summon a random auction house mount
        RuthesMS.utils.summon.summonRandomAuctionHouseMount()
    elseif msg == "mailbox" then      -- /rms mailbox - will summon a random mailbox mount
        RuthesMS.utils.summon.summonRandomMailboxMount()
    elseif msg == "multiple" then     -- /rms multiple - will summon a random multiple character mount
        RuthesMS.utils.summon.summonRandomMultipleMount()
    elseif msg == "minimap" then      --/rms minimap - will toggle minimap button
        RuthesMS.buttons.minimapButton.toggleMinimap()
    elseif msg == "help" then         --/rms help - will display help message
        printHelp()
    else
        if not RuthesMS.frames.mountSelectorFrame.frame:IsShown() then -- /rms - will toggle the mount selector window
            RuthesMS.frames.mountSelectorFrame.frame:Show()
        else
            RuthesMS.frames.mountSelectorFrame.frame:Hide()
        end
    end
end

RuthesMS.utils.addon = {
    afterAddonLoaded = afterAddonLoaded
}
