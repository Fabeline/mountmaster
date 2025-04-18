local function create()
    local mountSelectorFrame = RuthesMS.frames.mountSelectorFrame.frame

    -- Normal mount
    local randomMountButton = CreateFrame("Button", "RuthesMSRandomMountButton", mountSelectorFrame,
        "UIPanelButtonTemplate")
    randomMountButton:Hide()

    randomMountButton:SetScript("OnClick", function()
        RuthesMS.utils.mount.reloadMounts()
        RuthesMS.utils.mount.summonRandomMount(false)
    end)

    -- Aquatic mount
    local randomAquaticMountButton = CreateFrame("Button", "RuthesMSRandomAquaticMountButton", mountSelectorFrame,
        "UIPanelButtonTemplate")
    randomAquaticMountButton:Hide()

    randomAquaticMountButton:SetScript("OnClick", function()
        RuthesMS.utils.mount.reloadMounts()
        RuthesMS.utils.mount.summonRandomMount(true)
    end)

    -- Repair mount
    local randomRepairMountButton = CreateFrame("Button", "RuthesMSRandomRepairMountButton", mountSelectorFrame,
        "UIPanelButtonTemplate")
    randomRepairMountButton:Hide()

    randomRepairMountButton:SetScript("OnClick", function()
        RuthesMS.utils.mount.reloadMounts()
        RuthesMS.utils.mount.summonRandomRepairMount()
    end)

    RuthesMS.buttons.randomMountButton.button = randomMountButton
end

RuthesMS.buttons.randomMountButton = {
    create = create,
    button = nil
}
