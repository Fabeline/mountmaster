local function createFrame()
    local mountSelectorFrame = RuthesMS.frames.mountSelectorFrame.frame

    local helpFrame = CreateFrame("Frame", "MountSelectorHelpFrame", mountSelectorFrame, "BackdropTemplate")
    helpFrame:SetSize(mountSelectorFrame:GetWidth(), 400)
    helpFrame:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 20, -65)

    -- Add help text
    local helpText = helpFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    helpText:SetPoint("TOPLEFT", helpFrame, "TOPLEFT", 0, 0)
    helpText:SetWidth(helpFrame:GetWidth() - 40)
    helpText:SetWordWrap(true)
    helpText:SetJustifyH("LEFT")
    helpText:SetJustifyV("TOP")
    helpText:SetText(
        "|cffffffffWelcome to Ruthe's Mount Selector!|r\n\n" ..
        "This addon helps you summon the perfect mounts for each of your characters.\n\n" ..
        "Use the dropdowns to filter by color, expansion, or type.\n\n" ..
        "You can set a keybind or drag an action button/macro to summon from your selection.\n\n" ..
        "If you have any comments or questions, please enter them here:\n|cffffffffhttps://www.curseforge.com/wow/addons/ruthes-mountselector/comments\n\n|r" ..
        "Enjoy your adventures!"
    )

    -- local logo = helpFrame:CreateTexture(nil, "ARTWORK")
    -- logo:SetSize(100, 100)
    -- logo:SetPoint("TOP", helpText, "BOTTOM", 0, -10)
    -- logo:SetTexture("Interface\\AddOns\\Ruthes_MountSelector\\Ruthes_MountSelector.tga")

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
