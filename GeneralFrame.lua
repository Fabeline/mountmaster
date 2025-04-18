local function createFrame()
    local mountSelectorFrame = RuthesMS.frames.mountSelectorFrame.frame

    local generalFrame = CreateFrame("Frame", "MountSelectorGeneralFrame",
        mountSelectorFrame,
        "BackdropTemplate")
    generalFrame:SetSize(mountSelectorFrame:GetWidth(), 400)
    generalFrame:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 0, -35)

    -- Create a dropdown menu for filtering by color
    local colorDropdown = CreateFrame("FRAME", "ColorFilterDropdown", generalFrame, "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(colorDropdown, 120)
    colorDropdown:SetPoint("TOPLEFT", generalFrame, "TOPLEFT", 0, -25)
    UIDropDownMenu_Initialize(colorDropdown, RuthesMS.utils.filterDropdowns.initializeColorDropdown)

    -- Create a dropdown menu for filtering by skeleton type
    local skeletonDropdown = CreateFrame("FRAME", "SkeletonFilterDropdown", generalFrame, "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(skeletonDropdown, 120)
    skeletonDropdown:SetPoint("TOPLEFT", generalFrame, "TOPLEFT", 0, -55)
    UIDropDownMenu_Initialize(skeletonDropdown, RuthesMS.utils.filterDropdowns.initializeSkeletonDropdown)

    -- Create a dropdown menu for filtering by expansion
    local expansionDropdown = CreateFrame("FRAME", "ExpansionFilterDropdown", generalFrame,
        "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(expansionDropdown, 120)
    expansionDropdown:SetPoint("TOPLEFT", generalFrame, "TOPLEFT", 140, -25)
    UIDropDownMenu_Initialize(expansionDropdown, RuthesMS.utils.filterDropdowns.initializeExpansionDropdown)

    UIDropDownMenu_SetText(skeletonDropdown, "Select types")
    UIDropDownMenu_SetText(colorDropdown, "Select colors")
    UIDropDownMenu_SetText(expansionDropdown, "Select expansions")

    -- Add refresh button (for favorites)
    local refreshButton = CreateFrame("Button", "RefreshButton", generalFrame, "UIPanelButtonTemplate")
    refreshButton:SetSize(80, 22)
    refreshButton:SetText("Refresh")
    refreshButton:SetPoint("BOTTOM", generalFrame, "BOTTOM", 0, -55)
    refreshButton:SetScript("OnClick", RuthesMS.buttons.mountButtons.reload)

    RuthesMS.frames.generalFrame.frame = generalFrame
    RuthesMS.frames.mountSelectorScrollFrame.create()
    RuthesMS.frames.contentFrame.create()
    RuthesMS.frames.keybindFrame.create()
end

local function show()
    -- Create if missing
    if not RuthesMS.frames.generalFrame.frame then
        RuthesMS.frames.generalFrame.create()
    end

    local generalFrame = RuthesMS.frames.generalFrame.frame
    generalFrame:Show()
end


local function hide()
    local generalFrame = RuthesMS.frames.generalFrame.frame
    if generalFrame then
        generalFrame:Hide()
    end
end

RuthesMS.frames.generalFrame = {
    create = createFrame,
    show = show,
    hide = hide,
    frame = nil
}
