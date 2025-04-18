local function create()
    local mountSelectorFrame = RuthesMS.frames.mountSelectorFrame.frame

    local randomMountButton = CreateFrame("Button", "RuthesMSRandomMountButton", mountSelectorFrame,
        "UIPanelButtonTemplate")
    randomMountButton:SetSize(120, 22)
    randomMountButton:SetPoint("BOTTOMLEFT", mountSelectorFrame, "BOTTOMLEFT", 10, 10)
    randomMountButton:SetText("Random Mount")
    randomMountButton:Hide()

    randomMountButton:SetScript("OnClick", function()
        RuthesMS.utils.mount.reloadMounts()
        RuthesMS.utils.mount.summonRandomMount()
    end)

    RuthesMS.buttons.randomMountButton.button = randomMountButton
end

RuthesMS.buttons.randomMountButton = {
    create = create,
    button = nil
}
