local function createContentFrame()
    local contentFrame = CreateFrame("Frame", "MountSelectorContentFrame",
        RuthesMS.frames.mountSelectorScrollFrame.frame,
        "BackdropTemplate")
    RuthesMS.frames.mountSelectorScrollFrame.frame:SetScrollChild(contentFrame)

    local height = #RuthesMS.state.currentMounts * RuthesMS.buttons.mountButtons.lineHeight
    contentFrame:SetSize(RuthesMS.frames.mountSelectorScrollFrame.frame:GetWidth(), height)
    RuthesMS.frames.contentFrame.frame = contentFrame
end

local function deleteContentFrame()
    local contentFrame = RuthesMS.frames.contentFrame.frame
    if contentFrame then
        contentFrame:Hide()
        contentFrame:SetParent(nil)
        RuthesMS.frames.contentFrame.frame = nil
    end
end

RuthesMS.frames.contentFrame = {
    frame = nil,
    create = createContentFrame,
    delete = deleteContentFrame,
}
