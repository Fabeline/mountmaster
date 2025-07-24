local function create()
    local mountSelectorFrame = RuthesMS.frames.mountSelectorFrame.frame

    -- Normal mount
    local randomMountButton = CreateFrame("Button", "RuthesMSRandomMountButton", mountSelectorFrame,
        "UIPanelButtonTemplate")
    randomMountButton:Hide()

    randomMountButton:SetScript("OnClick", function()
        RuthesMS.utils.mount.reloadMounts()
        RuthesMS.utils.summon.summonRandomMount(false)
    end)

    -- Small mount
    local randomSmallMountButton = CreateFrame("Button", "RuthesMSRandomSmallMountButton", mountSelectorFrame,
        "UIPanelButtonTemplate")
    randomSmallMountButton:Hide()

    randomSmallMountButton:SetScript("OnClick", function()
        RuthesMS.utils.mount.reloadMounts()
        RuthesMS.utils.summon.summonRandomMount(false, true)
    end)

    -- Ground mount
    local randomGroundMountButton = CreateFrame("Button", "RuthesMSRandomGroundMountButton", mountSelectorFrame,
        "UIPanelButtonTemplate")
    randomGroundMountButton:Hide()

    randomGroundMountButton:SetScript("OnClick", function()
        RuthesMS.utils.mount.reloadMounts()
        RuthesMS.utils.summon.summonRandomMount(false, false, true)
    end)

    -- Aquatic mount
    local randomAquaticMountButton = CreateFrame("Button", "RuthesMSRandomAquaticMountButton", mountSelectorFrame,
        "UIPanelButtonTemplate")
    randomAquaticMountButton:Hide()

    randomAquaticMountButton:SetScript("OnClick", function()
        RuthesMS.utils.mount.reloadMounts()
        RuthesMS.utils.summon.summonRandomMount(true)
    end)

    -- Repair mount
    local randomRepairMountButton = CreateFrame("Button", "RuthesMSRandomRepairMountButton", mountSelectorFrame,
        "UIPanelButtonTemplate")
    randomRepairMountButton:Hide()

    randomRepairMountButton:SetScript("OnClick", function()
        RuthesMS.utils.mount.reloadMounts()
        RuthesMS.utils.summon.summonRandomRepairMount()
    end)

    -- Transmog mount
    local randomTransmogMountButton = CreateFrame("Button", "RuthesMSRandomTransmogMountButton", mountSelectorFrame,
        "UIPanelButtonTemplate")
    randomTransmogMountButton:Hide()

    randomTransmogMountButton:SetScript("OnClick", function()
        RuthesMS.utils.mount.reloadMounts()
        RuthesMS.utils.summon.summonRandomTransmogMount()
    end)

    -- Auction house mount
    local randomAuctionHouseMountButton = CreateFrame("Button", "RuthesMSRandomAuctionHouseMountButton",
        mountSelectorFrame, "UIPanelButtonTemplate")
    randomAuctionHouseMountButton:Hide()

    randomAuctionHouseMountButton:SetScript("OnClick", function()
        RuthesMS.utils.mount.reloadMounts()
        RuthesMS.utils.summon.summonRandomAuctionHouseMount()
    end)

    -- Mailbox mount
    local randomMailboxMountButton = CreateFrame("Button", "RuthesMSRandomMailboxMountButton", mountSelectorFrame,
        "UIPanelButtonTemplate")
    randomMailboxMountButton:Hide()

    randomMailboxMountButton:SetScript("OnClick", function()
        RuthesMS.utils.mount.reloadMounts()
        RuthesMS.utils.summon.summonRandomMailboxMount()
    end)

    -- Multiple character mount
    local randomMultipleMountButton = CreateFrame("Button", "RuthesMSRandomMultipleMountButton", mountSelectorFrame,
        "UIPanelButtonTemplate")
    randomMultipleMountButton:Hide()

    randomMultipleMountButton:SetScript("OnClick", function()
        RuthesMS.utils.mount.reloadMounts()
        RuthesMS.utils.summon.summonRandomMultipleMount()
    end)

    RuthesMS.buttons.randomMountButton.button = randomMountButton
end

RuthesMS.buttons.randomMountButton = {
    create = create,
    button = nil
}
