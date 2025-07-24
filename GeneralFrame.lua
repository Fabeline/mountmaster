local pickForMeCheckbox

local function createTooltip(frame, label, realtiveToFrame)
    local icon = CreateFrame("Button", nil, frame)
    icon:SetSize(15, 15)
    icon:SetPoint("LEFT", realtiveToFrame, "RIGHT", -10, 5)

    local texture = icon:CreateTexture(nil, "BACKGROUND")
    texture:SetAllPoints()
    texture:SetTexture("Interface\\FriendsFrame\\InformationIcon")

    icon:EnableMouse(true)
    icon:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(label)
        GameTooltip:SetAlpha(0)
        GameTooltip:Show()
    end)
    icon:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
end


local function createFrame()
    local mountSelectorFrame = RuthesMS.frames.mountSelectorFrame.frame

    local generalFrame = CreateFrame("Frame", "MountSelectorGeneralFrame",
        mountSelectorFrame,
        "BackdropTemplate")
    generalFrame:SetSize(mountSelectorFrame:GetWidth(), 400)
    generalFrame:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 0, -55)

    -- Create a dropdown menu for filtering by color
    local colorDropdown = CreateFrame("FRAME", "ColorFilterDropdown", generalFrame, "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(colorDropdown, 120)
    colorDropdown:SetPoint("TOPLEFT", generalFrame, "TOPLEFT", 0, -5)
    UIDropDownMenu_Initialize(colorDropdown, RuthesMS.utils.filterDropdowns.initializeColorDropdown)
    UIDropDownMenu_SetText(colorDropdown, "Select colors")

    -- Create a dropdown menu for filtering by skeleton type
    local skeletonDropdown = CreateFrame("FRAME", "SkeletonFilterDropdown", generalFrame, "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(skeletonDropdown, 120)
    skeletonDropdown:SetPoint("TOPLEFT", generalFrame, "TOPLEFT", 0, -35)
    UIDropDownMenu_Initialize(skeletonDropdown, RuthesMS.utils.filterDropdowns.initializeSkeletonDropdown)
    UIDropDownMenu_SetText(skeletonDropdown, "Select types")

    -- Create a dropdown menu for filtering by expansion
    local expansionDropdown = CreateFrame("FRAME", "ExpansionFilterDropdown", generalFrame,
        "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(expansionDropdown, 120)
    expansionDropdown:SetPoint("TOPLEFT", generalFrame, "TOPLEFT", 140, -5)
    UIDropDownMenu_Initialize(expansionDropdown, RuthesMS.utils.filterDropdowns.initializeExpansionDropdown)
    UIDropDownMenu_SetText(expansionDropdown, "Select expansions")

    -- Create a dropdown for filtering by looks
    -- local looksDropdown = CreateFrame("FRAME", "LooksFilterDropdown", generalFrame, "UIDropDownMenuTemplate")
    -- UIDropDownMenu_SetWidth(looksDropdown, 120)
    -- looksDropdown:SetPoint("TOPLEFT", generalFrame, "TOPLEFT", 140, -35)
    -- UIDropDownMenu_Initialize(looksDropdown, RuthesMS.utils.filterDropdowns.initializeLooksDropdown)
    -- UIDropDownMenu_SetText(looksDropdown, "Select looks")



    createTooltip(generalFrame, [[
1. Choose your selection of mounts by filters
2. Go to the "keybind" tab and set keybind or drag a button to your action bar
3. Press keybind or button to summon a random mount based on your selection]],
        expansionDropdown)

    -- Pick for me checkbox
    pickForMeCheckbox = CreateFrame("CheckButton", "PickForMeCheckbox", generalFrame,
        "ChatConfigCheckButtonTemplate")
    pickForMeCheckbox:SetPoint("TOPLEFT", generalFrame, "TOPLEFT", 157, -35)
    pickForMeCheckbox:SetScript("OnClick", function(self)
        RuthesMS.db.savePickForMe(self:GetChecked())

        if (self:GetChecked()) then
            skeletonDropdown:SetAlpha(0.35)
            colorDropdown:SetAlpha(0.35)
            expansionDropdown:SetAlpha(0.35)
        else
            skeletonDropdown:SetAlpha(1)
            colorDropdown:SetAlpha(1)
            expansionDropdown:SetAlpha(1)
        end
        RuthesMS.buttons.mountButtons.reload()
    end)

    local pickForMeLabel = generalFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    pickForMeLabel:SetPoint("LEFT", pickForMeCheckbox, "RIGHT", 5, 0)
    pickForMeLabel:SetText("Pick for me")


    -- Add refresh button (for favorites)
    local refreshButton = CreateFrame("Button", "RefreshButton", generalFrame, "UIPanelButtonTemplate")
    refreshButton:SetSize(80, 22)
    refreshButton:SetText("Refresh")
    refreshButton:SetPoint("BOTTOM", generalFrame, "BOTTOM", 0, -35)
    refreshButton:SetScript("OnClick", function()
        RuthesMS.utils.mount.loadKnownMounts()
        RuthesMS.buttons.mountButtons.reload()
    end)

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

local reloadCheckboxes = function()
    if RuthesMS.settings.pickForMe then
        pickForMeCheckbox:SetChecked(true)
        pickForMeCheckbox:GetScript("OnClick")(pickForMeCheckbox)
    else
        pickForMeCheckbox:SetChecked(false)
        pickForMeCheckbox:GetScript("OnClick")(pickForMeCheckbox)
    end
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
    frame = nil,
    reloadCheckboxes = reloadCheckboxes,
}
