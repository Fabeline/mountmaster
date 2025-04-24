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
        "This addon lets you summon mounts based on your preferences, and save different choices for each character.\n\n" ..
        "You can filter mounts by type, expansion, and color for each character. For example, your warlock might prefer black horses, while your frost mage favors blue cats or dragons.\n\n" ..
        "You can assign keybinds or drag action button macros to summon mounts by type — such as normal (including flying mounts when flying is available), aquatic, repair, mailbox, or auction house mounts.\n\n" ..
        "Keybinds can be saved globally or individually for each character.\n\n" ..
        "For questions or feedback, visit:\n|cffffffffhttps://www.curseforge.com/wow/addons/ruthes-mountselector/comments|r\n\n"
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
