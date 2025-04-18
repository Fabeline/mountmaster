local function createFrame()
    local mountSelectorFrame = RuthesMS.frames.mountSelectorFrame.frame

    local helpFrame = CreateFrame("Frame", "MountSelectorHelpFrame", mountSelectorFrame, "BackdropTemplate")
    helpFrame:SetSize(mountSelectorFrame:GetWidth(), 400)
    helpFrame:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 0, -65)

    -- Add help text
    local helpText = helpFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    helpText:SetPoint("TOPLEFT", helpFrame, "TOPLEFT", 10, -10)
    helpText:SetText("Mount Selector Help")

    helpFrame:Show()

    RuthesMS.frames.helpFrame.frame = helpFrame
end

local function show()
    -- Create if missing
    if not RuthesMS.frames.helpFrame.frame then
        RuthesMS.frames.helpFrame.create()
    end

    local helpFrame = RuthesMS.frames.helpFrame.frame
    helpFrame:Show()
end

local function hide()
    local helpFrame = RuthesMS.frames.helpFrame.frame
    if helpFrame then
        helpFrame:Hide()
    end
end

RuthesMS.frames.helpFrame = {
    create = createFrame,
    show = show,
    hide = hide,
    frame = nil
}
